--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


/*
 * Temporary reproduction for the unauthenticated Barrage ChangeEquip path.
 * This does not modify barrage.js and does not send chat messages.
 * Remove this file and its include in barrage.xml after testing.
 */
(function () {
	var PREFIX = "[RAINBOW_BARRAGE_REPRO]";
	var BARRAGE_ITEM = "rain_bow_barrage";
	var CHAT_WHEEL_ITEM = "liu_liu_liu";
	var TRACK_COUNT = 10;
	var MAX_SYNC_ATTEMPTS = 50;

	function log(message) {
		$.Msg(PREFIX, " ", message);
	}

	function setBarrageEquip(playerID, equipped) {
		GameEvents.SendCustomGameEventToServer("ChangeEquip", {
			playerId: playerID,
			type: "Barrage",
			itemName: BARRAGE_ITEM,
			isEquip: equipped ? 1 : 0
		});
	}

	function fireAllTracks(playerID) {
		for (var i = 0; i < TRACK_COUNT; i++) {
			GameEvents.SendCustomGameEventToServer("ActiveChatWheel", {
				playerId: playerID,
				itemName: CHAT_WHEEL_ITEM
			});
		}

		log("sent " + TRACK_COUNT + " ActiveChatWheel events to the server");

		// Existing bullet panels retain the class that was applied at creation.
		$.Schedule(0.5, function () {
			setBarrageEquip(playerID, false);
			log("requested Barrage equip reset");
		});
	}

	function waitForBarrageNetTable(playerID, attempt) {
		var data = CustomNetTables.GetTableValue("econ_data", String(playerID));

		if (data != null && data.itemName === BARRAGE_ITEM) {
			log("econ_data synchronized; firing all tracks");
			fireAllTracks(playerID);
			return;
		}

		if (attempt >= MAX_SYNC_ATTEMPTS) {
			log("FAILED: econ_data did not synchronize to " + BARRAGE_ITEM);
			return;
		}

		$.Schedule(0.1, function () {
			waitForBarrageNetTable(playerID, attempt + 1);
		});
	}

	function runReproduction() {
		var playerID = Game.GetLocalPlayerID();
		if (playerID == null || playerID < 0) {
			log("FAILED: local player is unavailable");
			return;
		}

		log("requesting " + BARRAGE_ITEM + " for local player " + playerID);
		setBarrageEquip(playerID, true);
		waitForBarrageNetTable(playerID, 0);
	}

	log("script loaded");

	// Start directly because undeclared custom client-side events are not dispatched.
	// The reproduction itself still uses the existing ChangeEquip and FireBullet events.
	$.Schedule(1.0, function () {
		runReproduction();
	});
})();