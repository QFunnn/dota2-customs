--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let EVENTS_DATA = {};
let EVENTS_CHANGED_LISTENERS = [];

function _UpdateEvents(events_list) {
	EVENTS_DATA = events_list;
	_Notify(EVENTS_CHANGED_LISTENERS, EVENTS_DATA);
}

GameUI.Events = {};

/**
 * Return Hallowen event enable state
 * @returns {boolean}
 */
GameUI.Events.IsHalloween = function () {
	return !!EVENTS_DATA.halloween;
};
GameUI.Events.GetHalloweenDefinition = function () {
	return {
		bundle_bonus_pct: 50,
	};
};

/**
 * Register a `callback` to be called whenever events data changes.
 * @param {CallableFunction} callback
 */
GameUI.Events.RegisterForEventsDataChanges = function (callback) {
	EVENTS_CHANGED_LISTENERS.push(callback);
	if (Object.keys(EVENTS_DATA).length > 0) callback(EVENTS_DATA);
};

SEASONAL_EVENTS_REQUESTED = false;
(() => {
	GameEvents.SubscribeProtected("SeasonalEvents:update_events", _UpdateEvents);

	GameEvents.Subscribe("game_rules_state_change", () => {
		// request once we reach hero selection (or later, if reconnected), but only once in client lifetime
		if (Game.GameStateIsBefore(DOTA_GameState.DOTA_GAMERULES_STATE_HERO_SELECTION)) return;

		if (SEASONAL_EVENTS_REQUESTED) return;
		SEASONAL_EVENTS_REQUESTED = true;

		GameEvents.SendToServerEnsured("SeasonalEvents:get_events", {});
	});
})();