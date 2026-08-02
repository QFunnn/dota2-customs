--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


"use strict";

let iRecordVectorAbility = -1;
function StartVectorAbility(iAbility) {
	let aCursorPosition = GameUI.GetCursorPosition();
	let vWorldPosition = Game.ScreenXYToWorld(aCursorPosition[0], aCursorPosition[1]);
	if (vWorldPosition[0] == 3.4028234663852886e+38) {
		return;
	}
	iRecordVectorAbility = iAbility;

	GameEvents.SendEventClientSide("custom_vector_ability", {
		type: 0,
		ability_ent_index: iAbility,
		x: vWorldPosition[0],
		y: vWorldPosition[1],
		z: vWorldPosition[2],
	});

	let funcUpdate = function () {
		let iActiveAbility = Abilities.GetLocalPlayerActiveAbility();
		let aCursorPosition = GameUI.GetCursorPosition();
		let vWorldPosition = Game.ScreenXYToWorld(aCursorPosition[0], aCursorPosition[1]);

		if (iActiveAbility != iAbility) {
			GameEvents.SendEventClientSide("custom_vector_ability", {
				type: 2,
				ability_ent_index: iAbility,
				x: -1,
				y: -1,
				z: -1,
			});
			iRecordVectorAbility = -1;
		} else {
			GameEvents.SendEventClientSide("custom_vector_ability", {
				type: 1,
				ability_ent_index: iAbility,
				x: vWorldPosition[0] == 3.4028234663852886e+38 ? -1 : vWorldPosition[0],
				y: vWorldPosition[1] == 3.4028234663852886e+38 ? -1 : vWorldPosition[1],
				z: vWorldPosition[2] == 3.4028234663852886e+38 ? -1 : vWorldPosition[2],
			});
			$.Schedule(Game.GetGameFrameTime(), funcUpdate);
		}
	};

	funcUpdate();
}

(() => {
	Game.AddCommand("start_vector_ability" + GameUI.CustomUIConfig().CommandUniqueSuffix, (_, sAbilityIndex) => {
		let iAbility = Number(sAbilityIndex);
		if (iRecordVectorAbility != iAbility && (Abilities.GetBehavior(iAbility) & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING) == DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING) {
			if (GameUI.GetClickBehaviors() == CLICK_BEHAVIORS.DOTA_CLICK_BEHAVIOR_VECTOR_CAST) {
				StartVectorAbility(iAbility);
			}
		}
	}, "", 67108864);

	if (!GameUI.CustomUIConfig().tMouseEvents) {
		GameUI.CustomUIConfig().tMouseEvents = {};
	}
	let CONSUME_EVENT = true;
	let CONTINUE_PROCESSING_EVENT = false;
	GameUI.SetMouseCallback((sEventName, iValue) => {
		let bResult = CONTINUE_PROCESSING_EVENT;
		let aKeys = Object.keys(GameUI.CustomUIConfig().tMouseEvents);

		aKeys.sort((a, b) => GameUI.CustomUIConfig().tMouseEvents[a].iPriority - GameUI.CustomUIConfig().tMouseEvents[b].iPriority);

		for (let index = aKeys.length - 1; index >= 0; index--) {
			let sKey = aKeys[index];
			const tMouseEvent = GameUI.CustomUIConfig().tMouseEvents[sKey];
			if (typeof (tMouseEvent.fCallback) == "function") {
				let bCallbackResult = tMouseEvent.fCallback({
					event_name: sEventName,
					value: iValue,
					result: bResult,
				});
				if (typeof (bCallbackResult) == "boolean") {
					bResult = bResult || bCallbackResult;
				}
			} else {
				delete GameUI.CustomUIConfig().tMouseEvents[sKey];
				aKeys.splice(index, 1);
			}
		}

		if (bResult == CONTINUE_PROCESSING_EVENT) {
			if (GameUI.GetClickBehaviors() == CLICK_BEHAVIORS.DOTA_CLICK_BEHAVIOR_CAST) {
				let iAbility = Abilities.GetLocalPlayerActiveAbility();
				if (iAbility != -1 && (Abilities.GetBehavior(iAbility) & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING) == DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING) {
					StartVectorAbility(iAbility);
				}
			}
		}
		return bResult;
	});
	GameUI.CustomUIConfig().SubscribeMouseEvent = (sName, fCallback, iPriority) => {
		let tMouseEvent = { fCallback: fCallback, iPriority: iPriority };
		GameUI.CustomUIConfig().tMouseEvents[sName] = tMouseEvent;
	};
	GameUI.CustomUIConfig().UnsubscribeMouseEvent = (sName) => {
		delete GameUI.CustomUIConfig().tMouseEvents[sName];
	};
})();