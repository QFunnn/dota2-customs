--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


// Dont use this file for utility functions, dont require it anywhere except custom_ui_manifest
GameEvents._PROTECTED_TOKEN = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
GameEvents._EVENT_ID_PREFIX = Math.random().toString(36).substring(2, 15);
const MANIFEST_LAYOUT_NAME = $.GetContextPanel().layoutfile;
let FRAMES = {};
let OUTCOMING_EVENT_ID = 0;
let AWAITED_EVENTS = {};

let DEFAULT_RETRY_DELAY = 2; // start at 2s retry and calibrate as events arrive
let ACK_EVENTS_COUNT = 0;
const MIN_PESSIMISTIC_PING = 0.06; // at least 1/30s delay

/**
 * Subscribes to protected event, checking for token to match current client on every invocation.
 *
 * **WARNING**: lifetime of this subscription is bound to protected events library, it won't be cancelled on other files reload.
 * Use `GameEvents.NewProtectedFrame` for proper protected events lifetime control.
 * @param {String} event_name
 * @param {CallableFunction} callback
 * @returns ID of listener
 */
GameEvents.SubscribeProtected = (event_name, callback) => {
	return GameEvents.Subscribe(event_name, (event) => {
		// Spectators cant send token to server and have to ignore this check
		// This give possibility to ruin spectators custom UI to cheaters, but I think it's not very important
		// Maybe can be fixed if we will generate tokens on server side and send it to clients
		if (event.protected_token === undefined) {
			$.Msg(`[Protected Events] incoming protected event <${event_name}> with undefined token was discarded!`);
			return;
		}
		if (Game.GetLocalPlayerID() == -1 || GameEvents._PROTECTED_TOKEN == event.protected_token) {
			callback(event.event_data);
		} else {
			throw `Registered event ${event_name} has wrong server token: ${event.protected_token}.
Use GameEvents.Subscribe for vanilla events and GameEvents.SendEventClientSideProtected for custom client-side events`;
		}
	});
};

/**
 * Sends client-side **custom** event in protected way.
 *
 * Otherwise plain clientside event sending fails due to missing token
 * @param {String} event_name
 * @param {Object} event_data
 */
GameEvents.SendEventClientSideProtected = function (event_name, event_data) {
	const event = {
		event_data: event_data,
		protected_token: GameEvents._PROTECTED_TOKEN,
	};
	GameEvents.SendEventClientSide(event_name, event);
};

class ProtectedFrame {
	constructor() {
		this.bound_subscriptions = [];
	}

	/**
	 * Subscribes to protected event, checking for token to match current client on every invocation.
	 *
	 * Lifetime of subscription is bound to this `frame`.
	 * @param {String} event_name
	 * @param {CallableFunction} callback
	 * @returns ID of listener
	 */
	SubscribeProtected(event_name, callback) {
		const _id = GameEvents.SubscribeProtected(event_name, callback);
		this.bound_subscriptions.push(_id);
		return _id;
	}

	/**
	 * Basic proxy to subscribe without protection to custom events.
	 *
	 * Mainly used for cases where protected subscription is impossible (i.e. loadscreen that loads earlier than manifest itself)
	 * All this does is invokes event callback with `.event_data` prefetched from protected event payload
	 * @param {String} event_name
	 * @param {CallableFunction} callback
	 * @returns ID of listener
	 */
	Subscribe(event_name, callback) {
		const _id = GameEvents.Subscribe(event_name, (event) => {
			callback(event.event_data);
		});
		this.bound_subscriptions.push(_id);
		return _id;
	}

	/**
	 * Release all subscriptions bound to this protected frame.
	 *
	 * Usually performed automatially on file reload
	 */
	Release() {
		for (const _id of this.bound_subscriptions) {
			GameEvents.Unsubscribe(_id);
		}
	}
}

/**
 * Prepares new protected frame for event subscriptions.
 *
 * Acts as a reload-proxy to cancel all subscriptions related to context file on reload.
 * @param {Panel | string} context - context panel of JS file, from $.GetContextPanel()
 * @returns
 */
GameEvents.NewProtectedFrame = (context) => {
	let file_name;
	if (typeof context == "string") {
		file_name = context;
	} else {
		file_name = context.layoutfile;
	}

	// using frames in manifest-linked js may cause other manifest-linked files to get cancelled
	if (file_name == MANIFEST_LAYOUT_NAME) {
		throw "[Protected Events] WARNING: YOU SHOULD NOT BE USING FRAMES IN MANIFEST-LINKED JAVASCRIPT.\nUse GameEvents.SubscribeProtected directly.";
	}

	const current_frame = FRAMES[file_name];
	if (current_frame) {
		$.Msg(`Releasing existing frame for ${file_name}`);
		current_frame.Release();
	}

	let frame = new ProtectedFrame(file_name);
	FRAMES[file_name] = frame;
	return frame;
};

/**
 * Schedule event sending retry for this payload ID, and record when we did this for ping approximation
 * @param {String} event_name
 * @param {Map | Object} payload
 * @param {String} payload_id
 * @param {Number} repeat_delay
 */
GameEvents.ScheduleRetry = (event_name, payload, payload_id, repeat_delay) => {
	const retry_token = $.Schedule(repeat_delay || DEFAULT_RETRY_DELAY, () =>
		GameEvents.RetryEventSending(event_name, payload, payload_id, repeat_delay || DEFAULT_RETRY_DELAY),
	);

	AWAITED_EVENTS[payload_id] = {
		retry_token: retry_token,
		sent_time: Game.GetGameTime(),
	};
};

/**
 * Retry sending event to server, keeping same ID and payload, and updating stored schedule to cancel it when ACK arrives
 * @param {String} event_name
 * @param {Map | Object} payload
 * @param {String} payload_id
 * @param {Number} [repeat_delay]
 */
GameEvents.RetryEventSending = (event_name, payload, payload_id, repeat_delay) => {
	$.Msg(`[${Game.GetGameTime()}] Retrying: ${event_name} - ${payload_id} - ${repeat_delay}`);
	GameEvents.SendCustomGameEventToServer(event_name, payload);

	GameEvents.ScheduleRetry(event_name, payload, payload_id, repeat_delay);
};

/**
 * Sends event to server, and awaits for it to be acknowledged by it (ACK)
 * If ACK doesn't arrive in `repeat_delay`, sends event again, until server accepts it
 * @param {String} event_name
 * @param {Map | Object} payload
 * @param {Number} [repeat_delay]
 */
GameEvents.SendToServerEnsured = (event_name, payload, repeat_delay) => {
	// we use special random prefix - can't rely on LocalPlayer completely, as it is -1 for a certain period of time before client fully loads
	// this way we can (hopefully) avoid collisions
	// as well as using incremental ID per client lifespan (surely we won't exceed 9007199254740991, eh?)
	const payload_id = `${GameEvents._EVENT_ID_PREFIX}_${Players.GetLocalPlayer()}_${OUTCOMING_EVENT_ID}`;
	const sent_time = Game.GetGameTime();

	payload._id = payload_id;
	OUTCOMING_EVENT_ID += 1;
	GameEvents.SendCustomGameEventToServer(event_name, payload);

	$.Msg(`[${sent_time}] Sent to server ensured: ${event_name} - ${payload_id}`);

	GameEvents.ScheduleRetry(event_name, payload, payload_id, repeat_delay);
};

(() => {
	$.Msg(`[Protected Events] reloaded!`);
	GameEvents.SendToServerEnsured("ProtectedEvents:set_token", { token: GameEvents._PROTECTED_TOKEN });

	const frame = GameEvents.NewProtectedFrame("event_stream");
	frame.SubscribeProtected("EventStream:ack", (event) => {
		if (!event.ack_id) return;
		if (!AWAITED_EVENTS[event.ack_id]) {
			$.Msg(
				`[${Game.GetGameTime()}] [EventStream] Received ACK for event that we weren't waiting: ${
					event.ack_id
				}!`,
			);
			return;
		}

		const recv_time = Game.GetGameTime();
		const event_entry = AWAITED_EVENTS[event.ack_id];
		// pessimistic multiplier to make sure we aren't retrying when it's not needed
		const bare_ping = recv_time - event_entry.sent_time;
		const pessimistic_ping = Math.max(2 * bare_ping, MIN_PESSIMISTIC_PING);
		// average ping through all events accepted
		DEFAULT_RETRY_DELAY = (ACK_EVENTS_COUNT * DEFAULT_RETRY_DELAY + pessimistic_ping) / (ACK_EVENTS_COUNT + 1);
		ACK_EVENTS_COUNT += 1;

		$.CancelScheduled(event_entry.retry_token);
		delete AWAITED_EVENTS[event.ack_id];
		$.Msg(
			`[${recv_time}] [EventStream] acknowledged event ${event.ack_id}, ping approximation: ${pessimistic_ping}`,
		);
	});
})();