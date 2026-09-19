--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";

GameEvents.SendCustomEventToServer = (pEventName, eventData) => {
	if (!(Players.GetLocalPlayer() == -1 || Players.IsSpectator(Players.GetLocalPlayer()) || Players.IsLocalPlayerLiveSpectating())) {
		GameEvents.SendCustomGameEventToServer(pEventName, eventData);
	}
};

var CustomUIConfig = GameUI.CustomUIConfig();

function print(...args) {
	if (!Game.IsInToolsMode()) {
		return;
	}
	let s = "";
	let a = [...args];
	a.forEach(e => {
		if (s != "") {
			s += "\t";
		}
		if (typeof e == "function" && e.length == 0) {
			e = e();
		}
		if (typeof e == "object") {
			s = s + JSON.stringify(e);
		} else {
			s = s + String(e);
		}
	});
	if (s.length > 2000) {
		for (let i = 0; i < s.length; i += 2000) {
			$.Msg(s.slice(i, Math.min(s.length, i + 2000)));
		}
	} else {
		$.Msg(s);
	}
}

function SaveData(panel, key, value) {
	panel[key] = value;
}
function LoadData(panel, key) {
	return panel[key];
}

function Round(fNumber, prec = 0) {
	let i = Math.pow(10, prec);
	return Math.round(fNumber * i) / i;
}

function Clamp(num, min, max) {
	return num <= min ? min : (num >= max ? max : num);
}

function Float(f) {
	return Math.round(f * 10000) / 10000;
}

function ErrorMessage(msg, sound = "General.CastFail_Custom") {
	GameUI.SendCustomHUDError(msg, sound);
}

function intToARGB(i) {
	return ('00' + (i & 0xFF).toString(16)).substr(-2) +
		('00' + ((i >> 8) & 0xFF).toString(16)).substr(-2) +
		('00' + ((i >> 16) & 0xFF).toString(16)).substr(-2) +
		('00' + ((i >> 24) & 0xFF).toString(16)).substr(-2);
}

function formatNumByLanguage(fNumber, bSeparate = false, bUseScientific = false, iFixNum = 2) {
	fNumber = Number(fNumber);
	if (isNaN(fNumber)) {
		if (bSeparate == true) {
			return {
				sNumber: 0,
				sUnit: "",
			};
		} else {
			return "0";
		}
	}
	let sNumber = fNumber.toFixed(0);
	let sUnit = "";

	if (bUseScientific) {
		if (fNumber > 1000000) {
			let _fNumber = fNumber;
			sUnit = 0;
			while (_fNumber > 10) {
				_fNumber /= 10;
				sUnit += 1;
			}
			sNumber = Round(_fNumber, iFixNum);
			sUnit = "E-" + sUnit;
		}
	} else {
		if (fNumber > 1000000000000000) {
			sNumber = Round((fNumber / 1000000000000000), iFixNum);
			sUnit = "#DamageUnit_Quadrillion";
		} else if (fNumber > 1000000000000) {
			sNumber = Round((fNumber / 1000000000000), iFixNum);
			sUnit = "#DamageUnit_Trillion";
		} else if (fNumber > 1000000000) {
			sNumber = Round((fNumber / 1000000000), iFixNum);
			sUnit = "#DamageUnit_Billion";
		} else if (fNumber > 1000000) {
			sNumber = Round((fNumber / 1000000), iFixNum);
			sUnit = "#DamageUnit_Million";
		}
		if (sUnit != "") {
			sUnit = $.Localize(sUnit);
		}
	}

	if (bSeparate == true) {
		return {
			sNumber: sNumber,
			sUnit: sUnit,
		};
	} else {
		return (sNumber + sUnit);
	}
}

Entities.HasBuff = function (unitEntIndex, buffName) {
	for (let index = 0; index < Entities.GetNumBuffs(unitEntIndex); index++) {
		let buff = Entities.GetBuff(unitEntIndex, index);
		if (Buffs.GetName(unitEntIndex, buff) == buffName)
			return true;
	}
	return false;
};

function _TimerFunction() {
	if (typeof (CustomUIConfig.Timers) == "object") {
		let fTime = Game.Time();
		let bNoSchedule = false;

		let aKeys = Object.keys(CustomUIConfig.Timers);
		for (let index = aKeys.length - 1; index >= 0; index--) {
			let sKey = aKeys[index];

			let tData = CustomUIConfig.Timers[sKey];
			if (tData) {
				let time = tData.time;
				if (typeof (time) == "number") {
					if (fTime < time) continue;

					if (tData.running == true) {
						bNoSchedule = true;
						continue;
					}

					let callback = tData.callback;
					if (typeof (callback) == "function") {
						tData.running = true;
						let result = callback();
						tData.running = false;
						if (typeof (result) == "number") {
							tData.time = fTime + result;
							continue;
						}
					}
				}
			}

			CustomUIConfig.Timers[sKey] = undefined;
			delete CustomUIConfig.Timers[sKey];
			aKeys.splice(index, 1);
		}

		if (!bNoSchedule) {
			CustomUIConfig.iScheduleHandle = $.Schedule(Game.GetGameFrameTime(), _TimerFunction);
		}
	}
}

function Timer(sKey, fTime, funcCallback) {
	if (typeof (CustomUIConfig.Timers) != "object") {
		CustomUIConfig.Timers = {};
	}

	if (typeof (fTime) == "number" && typeof (funcCallback) == "function") {
		if (fTime == 0) fTime = 0.0001;
		CustomUIConfig.Timers[sKey] = {
			time: Game.Time() + fTime,
			callback: funcCallback,
			running: false,
		};
	} else {
		CustomUIConfig.Timers[sKey] = undefined;
	}

	if (CustomUIConfig.iScheduleHandle) {
		try {
			$.CancelScheduled(CustomUIConfig.iScheduleHandle);
		} catch (error) { }
		CustomUIConfig.iScheduleHandle = undefined;
	}
	_TimerFunction();
}

function ToggleWindows(sName, bShowState) {
	GameEvents.SendEventClientSide("custom_ui_toggle_windows", { window_name: sName, show_state: bShowState });
}

var PayType;
(function (PayType) {
	PayType[PayType["MONEY"] = 0] = "MONEY";
	PayType[PayType["MOON"] = 1000001] = "MOON";
	PayType[PayType["STAR"] = 1000002] = "STAR";
	PayType[PayType["SHARD"] = 1000003] = "SHARD";
	PayType[PayType["FUNNY"] = 1200001] = "FUNNY";
})(PayType || (PayType = {}));