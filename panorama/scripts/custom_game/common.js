--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";

// 需要由服务端校验“事件发送者 == 本地英雄所有者”的局内事件。
// 这里只负责附加实体索引；实体有效性、主英雄身份与归属关系均由服务端判定。
if (!GameEvents.__localHeroVerificationInstalled) {
	var originalSendCustomGameEventToServer = GameEvents.SendCustomGameEventToServer;
	var localHeroVerifiedEvents = {
		AbilitySelected: true,
		AcceptTeammateSwap: true,
		ActiveChatWheel: true,
		ActiveTaunt: true,
		ChangeEquip: true,
		ConfirmActor: true,
		ConfirmBet: true,
		CustomPauseGame: true,
		DeclineTeammateSwap: true,
		DemoEvent: true,
		EquipTempItem: true,
		HeroIconClicked: true,
		HideNeutralItemSelect: true,
		NeutralItemSelected: true,
		PlayerReady: true,
		ProposeTeammateSwap: true,
		RelearnBookAbilitySelected: true,
		ReorderComplete: true,
		SpellBookAbilitySelected: true,
		SwapAbility: true,
		SwitchWearable: true,
		Taunt: true,
		ToggleAutoCreep: true,
		ToggleAutoDuel: true,
		alt_ping_ability: true,
		bet_on_team_allias: true,
		can_choose_ability: true,
		set_mute_player: true,
	};

	GameEvents.SendCustomGameEventToServer = function (eventName, eventData) {
		var securedEventData = eventData;
		if (localHeroVerifiedEvents[eventName]) {
			securedEventData = Object.assign({}, eventData || {});
			var localPlayerID = Players.GetLocalPlayer();
			securedEventData.hero_entindex = Players.GetPlayerHeroEntityIndex(localPlayerID);
		}
		originalSendCustomGameEventToServer.call(GameEvents, eventName, securedEventData);
	};
	GameEvents.__localHeroVerificationInstalled = true;
}

GameEvents.SendCustomEventToServer = (pEventName, eventData) => {
	if (!(Players.GetLocalPlayer() == -1 || Players.IsSpectator(Players.GetLocalPlayer()) || Players.IsLocalPlayerLiveSpectating())) {
		GameEvents.SendCustomGameEventToServer(pEventName, eventData);
	}
};

var CustomUIConfig = GameUI.CustomUIConfig();

var PlayerBuildDataKey = {};
PlayerBuildDataKey.PLAYER_BUILDING = 0;
PlayerBuildDataKey.PLAYER_BUILDING_IN_HAND = 1;
PlayerBuildDataKey.PLAYER_BUILDING_POSITION = 2;

var STEAM_WEB_KEY = "D34B40626FBA6E482A7653E4FB8A80CB";
CustomUIConfig.tSteamID2Name = [];

var REQUEST_TIME_OUT = 30;

String.prototype.replaceAll = function (s1, s2) {
	return this.replace(new RegExp(s1, "gm"), s2);
};

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

$.RandomInt = function (n, m) {
	var random = RemapValClamped(Math.random(), 0, 1, n, m);
	return Math.floor(random);
};

$.RandomFloat = function (n, m) {
	var random = RemapValClamped(Math.random(), 0, 1, n, m);
	return random;
};

function SaveData(panel, key, value) {
	panel[key] = value;
};
function LoadData(panel, key) {
	return panel[key];
};

var Digit;
(function (Digit) {
	Digit[Digit["K"] = 1] = "K";
	Digit[Digit["M"] = 2] = "M";
	Digit[Digit["G"] = 3] = "G";
	Digit[Digit["T"] = 4] = "T";
	Digit[Digit["P"] = 5] = "P";
	Digit[Digit["E"] = 6] = "E";
	Digit[Digit["Z"] = 7] = "Z";
	Digit[Digit["Y"] = 8] = "Y";
	Digit[Digit["B"] = 9] = "B";
})(Digit || (Digit = {}));

var DigitSchinese;
(function (DigitSchinese) {
	DigitSchinese[DigitSchinese["万"] = 1] = "万";
	DigitSchinese[DigitSchinese["亿"] = 2] = "亿";
	DigitSchinese[DigitSchinese["万亿"] = 3] = "万亿";
	DigitSchinese[DigitSchinese["兆"] = 4] = "兆";
	DigitSchinese[DigitSchinese["万兆"] = 5] = "万兆";
	DigitSchinese[DigitSchinese["京"] = 6] = "京";
	DigitSchinese[DigitSchinese["万京"] = 7] = "万京";
	DigitSchinese[DigitSchinese["垓"] = 8] = "垓";
	DigitSchinese[DigitSchinese["万垓"] = 9] = "万垓";
	DigitSchinese[DigitSchinese["秭"] = 10] = "秭";
	DigitSchinese[DigitSchinese["万秭"] = 11] = "万秭";
	DigitSchinese[DigitSchinese["穰"] = 12] = "穰";
	DigitSchinese[DigitSchinese["万穰"] = 13] = "万穰";
	DigitSchinese[DigitSchinese["沟"] = 14] = "沟";
	DigitSchinese[DigitSchinese["万沟"] = 15] = "万沟";
	DigitSchinese[DigitSchinese["涧"] = 16] = "涧";
	DigitSchinese[DigitSchinese["万涧"] = 17] = "万涧";
})(DigitSchinese || (DigitSchinese = {}));

function FormatNumber(fNumber, prec) {
	let [a, b] = FormatNumberBase(fNumber, prec);
	if (b) {
		return a + b;
	}
	return a;
}
function NumberToString(fNumber) {
	let sNumber = String(fNumber);
	if (sNumber.indexOf("e+") != -1) {
		let s = sNumber.split("e+");
		s[0] = s[0].replace(/\./g, "");
		let n = finiteNumber(Number(s[1])) + 1;
		for (let index = s[0].length; index < n; index++) {
			s[0] += "0";
		}
		sNumber = s[0];
	}
	return sNumber;
}

function FormatNumberBase(fNumber, prec = 2) {
	let sSign = fNumber < 0 ? "-" : "";
	fNumber = Math.abs(fNumber);
	let sNumber = NumberToString(Math.abs(fNumber));
	let a = sNumber.split(".");
	let sInteger = a[0];
	let sLanguage = $.Language().toLowerCase();
	if (sLanguage == "schinese") {
		let n = Math.floor((sInteger.length - 1) / 4);
		if (n == 0) {
			return [sSign + NumberToString(Round(fNumber, prec))];
		}
		sNumber = NumberToString(Round(fNumber / Math.pow(10000, n), prec));
		let sDigit = DigitSchinese[n];
		return [sSign + sNumber, sDigit];
	} else {
		let n = Math.floor((sInteger.length - 1) / 3);
		if (n == 0) {
			return [sSign + NumberToString(Round(fNumber, prec))];
		}
		sNumber = NumberToString(Round(fNumber / Math.pow(1000, n), prec));
		let sDigit = Digit[n];
		return [sSign + sNumber, sDigit];
	}
}

function Round(fNumber, prec = 0) {
	let i = Math.pow(10, prec);
	return Math.round(fNumber * i) / i;
}

function Clamp(num, min, max) {
	return num <= min ? min : (num >= max ? max : num);
}

function Lerp(percent, a, b) {
	return a + percent * (b - a);
}

function RemapVal(num, a, b, c, d) {
	if (a == b)
		return c;

	var percent = (num - a) / (b - a);
	return Lerp(percent, c, d);
}

function RemapValClamped(num, a, b, c, d) {
	if (a == b)
		return c;

	var percent = (num - a) / (b - a);
	percent = Clamp(percent, 0.0, 1.0);

	return Lerp(percent, c, d);
}

function FindKey(o, v) {
	for (var k in o) {
		if (o[k] == v)
			return k;
	}
}

function Float(f) {
	return Math.round(f * 10000) / 10000;
}

function VectorToString(vec) {
	return vec.join(" ");
}

function StringToVector(str) {
	let a = str.split(" ");
	return [Number(a[0]), Number(a[1]), Number(a[2])];
}

function alertObj(obj, name, str) {
	let output = "";
	if (name == null) {
		name = toString(obj);
	}
	if (str == null) {
		str = "";
	}
	$.Msg(str + name + "\n" + str + "{");
	for (let i in obj) {
		let property = obj[i];
		if (typeof (property) == "object") {
			alertObj(property, i, str + "\t");
		} else {
			output = i + " = " + property + "\t(" + typeof (property) + ")";
			$.Msg(str + "\t" + output);
		}
	}
	$.Msg(str + "}");
}

function DeepPrint(obj) {
	return alertObj(obj);
}

function polygonArray(polygon) {
	let p = [];
	for (let k in polygon) {
		p.push(polygon[k]);
	}
	return p;
}

function IsPointInPolygon(point, polygon) {
	let j = polygon.length - 1;
	let bool = 0;
	for (let i = 0; i < polygon.length; i++) {
		let polygonPoint1 = polygon[i];
		let polygonPoint2 = polygon[j];
		if (((polygonPoint2.y < point[1] && polygonPoint1.y >= point[1]) || (polygonPoint1.y < point[1] && polygonPoint2.y >= point[1])) && (polygonPoint2.x <= point[0] || polygonPoint1.x <= point[0])) {
			bool = bool ^ (((polygonPoint2.x + (point[1] - polygonPoint2.y) / (polygonPoint1.y - polygonPoint2.y) * (polygonPoint1.x - polygonPoint2.x)) < point[0]) ? 1 : 0);
		}
		j = i;
	}
	return bool == 1;
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
			// 返回分开来的两个
			return {
				sNumber: 0,
				sUnit: "",
			};
		} else {
			// 返回字符串
			return "0";
		}
	}
	let sNumber = fNumber.toFixed(0);
	let sUnit = "";

	const localLanguage = $.Language().toLowerCase();

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
	} else if (false) {
		let ascii_code = 64;
		let _fNumber = fNumber;
		while ((_fNumber > 1000) && (ascii_code < 90)) {
			ascii_code++;
			sUnit = String.fromCharCode(ascii_code);
			_fNumber /= 1000;
		}
		sNumber = Round(_fNumber, iFixNum);
	} else {
		if (fNumber > 1000000000000000) {
			sNumber = Round((fNumber / 1000000000000000), iFixNum);
			sUnit = "#DamageUnit_Quadrillion";
		} else if (fNumber > 1000000000000) {
			sNumber = Round((fNumber / 1000000000000), iFixNum);
			sUnit = "#DamageUnit_Trillion";
		} else if (fNumber > 1000000000 && localLanguage != "schinese") {
			sNumber = Round((fNumber / 1000000000), iFixNum);
			sUnit = "#DamageUnit_Billion";
		} else if (fNumber > 100000000 && localLanguage == "schinese") {
			sNumber = Round((fNumber / 100000000), iFixNum);
			sUnit = "#DamageUnit_100Million";
		} else if (fNumber > 1000000) {
			sNumber = Round((fNumber / 1000000), iFixNum);
			sUnit = "#DamageUnit_Million";
		}
		if (sUnit != "") {
			sUnit = $.Localize(sUnit);
		}
	}

	if (bSeparate == true) {
		// 返回分开来的两个
		return {
			sNumber: sNumber,
			sUnit: sUnit,
		};
	} else {
		// 返回字符串
		return (sNumber + sUnit);
	}
}

function SBehavior2IBehavior(sBehaviors) {
	sBehaviors = sBehaviors.replace(/\s/g, "");
	let aBehaviors = sBehaviors.split(/\|/g);
	let iBehaviors = 0;
	for (const sBehavior of aBehaviors) {
		let iBehavior = parseInt(DOTA_ABILITY_BEHAVIOR[sBehavior]);
		if (iBehavior) {
			iBehaviors = iBehaviors + iBehavior;
		}
	}
	return iBehaviors;
}

function STeam2ITeam(sTeams) {
	sTeams = sTeams.replace(/\s/g, "");
	let aTeams = sTeams.split(/\|/g);
	let iTeams = 0;
	for (const sTeam of aTeams) {
		let iTeam = parseInt(DOTA_UNIT_TARGET_TEAM[sTeam]);
		if (iTeam) {
			iTeams = iTeams + iTeam;
		}
	}
	return iTeams || 0;
}

function SDamageType2IDamageType(sDamageTypes) {
	sDamageTypes = sDamageTypes.replace(/\s/g, "");
	let aDamageTypes = sDamageTypes.split(/\|/g);
	let iDamageTypes = 0;
	for (const sDamageType of aDamageTypes) {
		let iDamageType = parseInt(DAMAGE_TYPES[sDamageType]);
		if (iDamageType) {
			iDamageTypes = iDamageTypes + iDamageType;
		}
	}
	return iDamageTypes || 0;
}

function SSpellImmunityType2ISpellImmunityType(sSpellImmunityType) {
	return SPELL_IMMUNITY_TYPES[sSpellImmunityType] || 0;
}

function SType2IType(sTypes) {
	sTypes = sTypes.replace(/\s/g, "");
	let aTypes = sTypes.split(/\|/g);
	let iTypes = 0;
	for (const sType of aTypes) {
		let iType = parseInt(DOTA_UNIT_TARGET_TYPE[sType]);
		if (iType) {
			iTypes = iTypes + iType;
		}
	}
	return iTypes;
}

function GetHeroNameByHeroID(iHeroID) {
	for (let sHeroName in CustomUIConfig.HeroesKv) {
		if (sHeroName != "Version") {
			let tHeroData = CustomUIConfig.HeroesKv[sHeroName];
			if (tHeroData && Number(tHeroData.HeroID) == iHeroID) {
				return sHeroName;
			}
		}
	}
}

function SimplifyValuesArray(aValues) {
	if (aValues && aValues.length > 1) {
		let a = aValues[0];
		for (let i = 1; i < aValues.length; i++) {
			const value = aValues[i];
			if (a != value) {
				return aValues;
			}
		}
		return [a];
	}
	return aValues;
}

function GetAbilityType(sAbilityName) {
	var tAbilityKeyValues = CustomUIConfig.AbilitiesKv[sAbilityName];
	var tItemKeyValues = CustomUIConfig.AbilitiesKv[sAbilityName];
	var tKeyValues = tAbilityKeyValues || tItemKeyValues;
	if (tKeyValues) {
		return tAbilityKeyValues.AbilityType || "ABILITY_TYPE_BASIC";
	}

	return "";
}

function IsGrantedByScepter(sAbilityName) {
	var tAbilityKeyValues = CustomUIConfig.AbilitiesKv[sAbilityName];
	var tItemKeyValues = CustomUIConfig.AbilitiesKv[sAbilityName];
	var tKeyValues = tAbilityKeyValues || tItemKeyValues;
	if (tKeyValues) {
		return tAbilityKeyValues.IsGrantedByScepter == 1 || tAbilityKeyValues.IsGrantedByScepter == "1";
	}

	return false;
}

let aPropertyNames = [
	"LinkedSpecialBonus",
	"LinkedSpecialBonusField",
	"LinkedSpecialBonusOperation",
	"CalculateSpellDamageTooltip",
	"RequiresScepter",
	"levelkey",
	"_str",
	"_int",
	"_agi",
	"_all",
	"_attack_damage",
	"_attack_speed",
	"_health",
	"_armor",
	"_magical_armor",
	"_mana",
	"_max",
	"_min",
	"_move_speed",
];

function GetSpecialNames(sAbilityName, iEntityIndex = -1) {
	var tAbilityKeyValues = CustomUIConfig.AbilitiesKv[sAbilityName];
	var tItemKeyValues = CustomUIConfig.ItemsKv[sAbilityName];
	var aSpecials = [];
	var tKeyValues = tAbilityKeyValues || tItemKeyValues;

	if (tKeyValues) {
		var tSpecials = tKeyValues.AbilitySpecial;
		if (tSpecials) {
			var sKey = Object.keys(tSpecials);
			sKey.sort(function (a, b) {
				return a - b;
			});
			for (let index = 0; index < sKey.length; index++) {
				const sIndex = sKey[index];
				var tData = tSpecials[sIndex];
				for (var sName in tData) {
					if (FindKey(aPropertyNames, sName) == undefined &&
						sName != "var_type" &&
						sName != "abilitycastrange" &&
						sName != "abilitycastpoint" &&
						sName != "abilityduration" &&
						sName != "abilitychanneltime") {
						aSpecials.push(sName);
						break;
					}
				}
			}
		}
		aSpecials = aSpecials.concat("abilitycastrange", "abilitycastpoint", "abilityduration", "abilitychanneltime", "abilitydamage");
	}

	if (iEntityIndex != -1) {
		let a = GetAbilityMechanicsUpgradeSpecialNames(iEntityIndex, sAbilityName);
		for (let index = 0; index < a.length; index++) {
			const v = a[index];
			if (!FindKey(aSpecials, v)) {
				aSpecials.push(v);
			}
		}
	}

	return aSpecials;
}

function GetAbilityLevelSpecialValueFor(sAbilityName, sName, iLevel) {
	var tAbilityKeyValues = CustomUIConfig.AbilitiesKv[sAbilityName];
	var tItemKeyValues = CustomUIConfig.ItemsKv[sAbilityName];
	var tKeyValues = tAbilityKeyValues || tItemKeyValues;

	if (iEntityIndex != -1) {
		let fValue = GetAbilityMechanicsUpgradeLevelSpecialValue(iEntityIndex, sAbilityName, sName, iLevel);
		if (fValue != undefined) {
			return fValue;
		}
	}

	if (tKeyValues) {
		var tSpecials = tKeyValues.AbilitySpecial;
		if (tSpecials) {
			for (var sIndex in tSpecials) {
				var tData = tSpecials[sIndex];
				if (tData[sName] != undefined && tData[sName] != null) {
					var sType = tData.var_type;
					var sValues = tData[sName].toString();
					var aValues = sValues.split(" ");
					if (aValues[iLevel - 1]) {
						var value = Number(aValues[iLevel - 1]);
						if (sType == "FIELD_INTEGER") {
							return parseInt(value);
						} else if (sType == "FIELD_FLOAT") {
							return Float(Number(value));
						}
					}
				}
			}
		}
	}

	return 0;
}

function StringToValues(sValues) {
	let aStr = sValues.toString().split(" ");
	let aValues = [];
	for (var i = 0; i < aStr.length; i++) {
		let n = Number(aStr[i]);
		if (isFinite(n)) {
			aValues.push(n);
		}
	}
	return SimplifyValuesArray(aValues);
}

function GetSpecialValues(sAbilityName, sName, iEntityIndex = -1) {
	var tAbilityKeyValues = CustomUIConfig.AbilitiesKv[sAbilityName];
	var tItemKeyValues = CustomUIConfig.ItemsKv[sAbilityName];
	var tKeyValues = tAbilityKeyValues || tItemKeyValues;

	if (iEntityIndex != -1) {
		let aValues = GetAbilityMechanicsUpgradeSpecialValues(iEntityIndex, sAbilityName, sName);
		if (aValues != undefined) {
			return aValues;
		}
	}

	if (tKeyValues) {
		var tSpecials = tKeyValues.AbilitySpecial;
		if (tSpecials) {
			for (var sIndex in tSpecials) {
				var tData = tSpecials[sIndex];
				if (tData[sName] != undefined && tData[sName] != null) {
					var sType = tData.var_type;
					var sValues = tData[sName].toString();
					var aValues = sValues.split(" ");
					for (var i = 0; i < aValues.length; i++) {
						var value = Number(aValues[i]);
						if (sType == "FIELD_INTEGER") {
							aValues[i] = parseInt(value);
						} else if (sType == "FIELD_FLOAT") {
							aValues[i] = parseFloat(value.toFixed(6));
						}
					}
					return SimplifyValuesArray(aValues);
				}
			}
		}
	}

	return [];
}

function GetSpecialVarType(sAbilityName, sName) {
	var tAbilityKeyValues = CustomUIConfig.AbilitiesKv[sAbilityName];
	var tItemKeyValues = CustomUIConfig.ItemsKv[sAbilityName];
	var tKeyValues = tAbilityKeyValues || tItemKeyValues;

	if (tKeyValues) {
		var tSpecials = tKeyValues.AbilitySpecial;
		if (tSpecials) {
			for (var sIndex in tSpecials) {
				var tData = tSpecials[sIndex];
				if (tData[sName] != undefined && tData[sName] != null) {
					return tData.var_type;
				}
			}
		}
	}

	return [];
}

function GetSpecialValueProperty(sAbilityName, sName, sPropertyName, iEntityIndex = -1) {
	var tAbilityKeyValues = CustomUIConfig.AbilitiesKv[sAbilityName];
	var tItemKeyValues = CustomUIConfig.ItemsKv[sAbilityName];
	var tKeyValues = tAbilityKeyValues || tItemKeyValues;

	if (iEntityIndex != -1) {
		let sPropertyValue = GetAbilityMechanicsUpgradeLevelSpecialValueProperty(iEntityIndex, sAbilityName, sName, sPropertyName);
		if (sPropertyValue != undefined) {
			return sPropertyValue.toString();
		}
	}

	if (tKeyValues) {
		var tSpecials = tKeyValues.AbilitySpecial;
		if (tSpecials) {
			for (var sIndex in tSpecials) {
				var tData = tSpecials[sIndex];
				if (tData[sName] != undefined && tData[sName] != null) {
					if (tData[sPropertyName] != undefined && tData[sPropertyName] != null) {
						return tData[sPropertyName].toString();
					}
				}
			}
		}
	}
}

// 判断单位是否被玩家选择
Players.IsEntitySelected = function (iEntIndex) {
	let aSelectedEntities = Players.GetSelectedEntities(Players.GetLocalPlayer());
	for (let index = aSelectedEntities.length - 1; index >= 0; index--) {
		let _iEntIndex = aSelectedEntities[index];
		if (iEntIndex == _iEntIndex) {
			return true;
		}
	}
	return false;
};

// 清除本地玩家选择单位
Players.RemoveSelection = function (iRemoveEntIndex) {
	let aSelectedEntities = Players.GetSelectedEntities(Players.GetLocalPlayer());
	for (let index = aSelectedEntities.length - 1; index >= 0; index--) {
		let iEntIndex = aSelectedEntities[index];
		if (iRemoveEntIndex == iEntIndex) {
			aSelectedEntities.splice(index, 1);
		}
	}

	GameUI.SelectUnit(-1, false);
	for (let index = 0; index < aSelectedEntities.length; index++) {
		let iEntIndex = aSelectedEntities[index];
		GameUI.SelectUnit(iEntIndex, true);
	}

};

Players.GetPlayerData = (iPlayerID, sFuncName) => {
	GameEvents.SendEventClientSide("custom_get_player_data", {
		player_id: iPlayerID,
		function_name: sFuncName,
	});
	let t = CustomNetTables.GetTableValue("common", "dummys");
	if (t) {
		let iUnitEntIndex = t.PLAYER_DATA_DUMMY;
		if (typeof iUnitEntIndex == "number" && Entities.IsValidEntity(iUnitEntIndex)) {
			let iBuffIndex = Entities.FindBuffByName(iUnitEntIndex, "modifier_player_data");
			if (iBuffIndex != -1) {
				let sValue = Buffs.GetTexture(iUnitEntIndex, iBuffIndex);
				if (sValue == "nil") {
					return;
				}
				if (sValue == "true") {
					return true;
				}
				if (sValue == "false") {
					return false;
				}
				if (sValue != "") {
					let fValue = Number(sValue);
					if (isFinite(fValue)) {
						return fValue;
					} else {
						return sValue;
					}
				}
			}
		}
	}
};

Abilities.GetLevelCooldown = (iEntityIndex, iLevel = -1) => {
	GameEvents.SendEventClientSide("custom_get_ability_cooldown", {
		ability_ent_index: iEntityIndex,
		level: iLevel,
	});
	let iCasterIndex = Abilities.GetCaster(iEntityIndex);
	let iAbilityEntIndex = Entities.GetAbilityByName(iCasterIndex, "unit_state");
	if (iAbilityEntIndex != -1) {
		let sCooldown = Abilities.GetAbilityTextureName(iAbilityEntIndex);
		if (sCooldown == "") {
			let sAbilityName = Abilities.GetAbilityName(iEntityIndex);
			let tAbility = CustomUIConfig.AbilitiesKv[sAbilityName];
			let tItem = CustomUIConfig.ItemsKv[sAbilityName];
			let tData = tAbility || tItem;
			if (tData) {
				if (iLevel == -1) iLevel = Abilities.GetLevel(iEntityIndex) - 1;
				let aCooldowns = StringToValues(tData.AbilityCooldown || "");
				if (iLevel >= 0 && aCooldowns.length > 0) {
					return aCooldowns[Math.min(iLevel, aCooldowns.length - 1)];
				}
			}
			return 0;
		}
		return Number(sCooldown);
	}
	return 0;
};

Abilities.GetLevelManaCost = (iEntityIndex, iLevel = -1) => {
	GameEvents.SendEventClientSide("custom_get_ability_mana_cost", {
		ability_ent_index: iEntityIndex,
		level: iLevel,
	});
	let iCasterIndex = Abilities.GetCaster(iEntityIndex);
	let iAbilityEntIndex = Entities.GetAbilityByName(iCasterIndex, "unit_state");
	if (iAbilityEntIndex != -1) {
		let sManaCost = Abilities.GetAbilityTextureName(iAbilityEntIndex);
		if (sManaCost == "") {
			let sAbilityName = Abilities.GetAbilityName(iEntityIndex);
			let tAbility = CustomUIConfig.AbilitiesKv[sAbilityName];
			let tItem = CustomUIConfig.ItemsKv[sAbilityName];
			let tData = tAbility || tItem;
			if (tData) {
				if (iLevel == -1) iLevel = Abilities.GetLevel(iEntityIndex) - 1;
				let aManaCosts = StringToValues(tData.AbilityManaCost || "");
				if (iLevel >= 0 && aManaCosts.length > 0) {
					return aManaCosts[Math.min(iLevel, aManaCosts.length - 1)];
				}
			}
			return 0;
		}
		return Number(sManaCost);
	}
	return 0;
};

Abilities.GetLevelGoldCost = (iEntityIndex, iLevel = -1) => {
	GameEvents.SendEventClientSide("custom_get_ability_gold_cost", {
		ability_ent_index: iEntityIndex,
		level: iLevel,
	});
	let iCasterIndex = Abilities.GetCaster(iEntityIndex);
	let iAbilityEntIndex = Entities.GetAbilityByName(iCasterIndex, "unit_state");
	if (iAbilityEntIndex != -1) {
		let sGoldCost = Abilities.GetAbilityTextureName(iAbilityEntIndex);
		if (sGoldCost == "") {
			let sAbilityName = Abilities.GetAbilityName(iEntityIndex);
			let tAbility = CustomUIConfig.AbilitiesKv[sAbilityName];
			let tItem = CustomUIConfig.ItemsKv[sAbilityName];
			let tData = tAbility || tItem;
			if (tData) {
				if (iLevel == -1) iLevel = Abilities.GetLevel(iEntityIndex) - 1;
				let aGoldCosts = StringToValues(tData.AbilityGoldCost || "");
				if (iLevel >= 0 && aGoldCosts.length > 0) {
					return aGoldCosts[Math.min(iLevel, aGoldCosts.length - 1)];
				}
			}
			return 0;
		}
		return Number(sGoldCost);
	}
	return 0;
};

Abilities.GetLevelEnergyCost = (iEntityIndex, iLevel = -1) => {
	GameEvents.SendEventClientSide("custom_get_ability_energy_cost", {
		ability_ent_index: iEntityIndex,
		level: iLevel,
	});
	let iCasterIndex = Abilities.GetCaster(iEntityIndex);
	let iAbilityEntIndex = Entities.GetAbilityByName(iCasterIndex, "unit_state");
	if (iAbilityEntIndex != -1) {
		let sEnergyCost = Abilities.GetAbilityTextureName(iAbilityEntIndex);
		if (sEnergyCost == "") {
			let sAbilityName = Abilities.GetAbilityName(iEntityIndex);
			let tAbility = CustomUIConfig.AbilitiesKv[sAbilityName];
			let tItem = CustomUIConfig.ItemsKv[sAbilityName];
			let tData = tAbility || tItem;
			if (tData) {
				if (iLevel == -1) iLevel = Abilities.GetLevel(iEntityIndex) - 1;
				let aEnergyCosts = StringToValues(tData.AbilityEnergyCost || "");
				if (iLevel >= 0 && aEnergyCosts.length > 0) {
					return aEnergyCosts[Math.min(iLevel, aEnergyCosts.length - 1)];
				}
			}
			return 0;
		}
		return Number(sEnergyCost);
	}
	return 0;
};

Abilities.GetLevelSpecialValue = (iEntityIndex, sKeyName, iLevel = -1) => {
	GameEvents.SendEventClientSide("custom_get_ability_special_value", {
		ability_ent_index: iEntityIndex,
		key_name: sKeyName,
		level: iLevel,
	});
	let iCasterIndex = Abilities.GetCaster(iEntityIndex);
	let iAbilityEntIndex = Entities.GetAbilityByName(iCasterIndex, "unit_state");
	if (iAbilityEntIndex != -1) {
		let sSpecialValue = Abilities.GetAbilityTextureName(iAbilityEntIndex);
		if (sSpecialValue == "") {
			let sAbilityName = Abilities.GetAbilityName(iEntityIndex);
			return GetAbilityLevelSpecialValueFor(sAbilityName, sKeyName, iLevel);
		}
		return Number(sSpecialValue);
	}
	return 0;
};

Entities.GetAbilityIndex = function (iEntityIndex, iAbilityEntIndex) {
	for (let i = 0; i < Entities.GetAbilityCount(iEntityIndex); i++) {
		const _iAbilityEntIndex = Entities.GetAbility(iEntityIndex, i);
		if (_iAbilityEntIndex == iAbilityEntIndex) {
			return i;
		}
	}
	return -1;
};

Entities.HasBuff = function (unitEntIndex, buffName) {
	for (let index = 0; index < Entities.GetNumBuffs(unitEntIndex); index++) {
		let buff = Entities.GetBuff(unitEntIndex, index);
		if (Buffs.GetName(unitEntIndex, buff) == buffName)
			return true;
	}
	return false;
};

Entities.FindBuffByName = function (unitEntIndex, buffName) {
	for (let index = 0; index < Entities.GetNumBuffs(unitEntIndex); index++) {
		let buff = Entities.GetBuff(unitEntIndex, index);
		if (Buffs.GetName(unitEntIndex, buff) == buffName)
			return buff;
	}
	return -1;
};


Entities.GetAttackSpeedPercent = (iUnitEntIndex) => {
	return Entities.GetAttackSpeed(iUnitEntIndex) * 100;
};

Entities.GetMoveSpeed = (iUnitEntIndex) => {
	return Entities.GetMoveSpeedModifier(iUnitEntIndex, Entities.GetBaseMoveSpeed(iUnitEntIndex));
};

Entities.GetUnitData = (iUnitEntIndex, sFuncName) => {
	GameEvents.SendEventClientSide("custom_get_unit_data", {
		unit_ent_index: iUnitEntIndex,
		function_name: sFuncName,
	});
	let iAbilityEntIndex = Entities.GetAbilityByName(iUnitEntIndex, "unit_state");
	if (iAbilityEntIndex != -1) {
		let sValue = Abilities.GetAbilityTextureName(iAbilityEntIndex);
		if (sValue == "nil") {
			return;
		}
		if (sValue == "true") {
			return true;
		}
		if (sValue == "false") {
			return false;
		}
		if (sValue != "") {
			let fValue = Number(sValue);
			if (isFinite(fValue)) {
				return fValue;
			} else {
				return sValue;
			}
		}
	}
};

Entities.GetCustomMaxHealth = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetHealth")));
};
Entities.GetBaseAttackDamage = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetBaseAttackDamage")));
};
Entities.GetAttackDamage = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetAttackDamage")));
};
Entities.GetCastRange = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetCastRange")));
};
Entities.GetBaseArmor = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetBaseArmor")));
};
Entities.GetArmor = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetArmor")));
};
Entities.GetBaseMagicalArmor = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetBaseMagicalArmor")));
};
Entities.GetMagicalArmor = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetMagicalArmor")));
};
Entities.GetBaseSpellAmplify = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetBaseSpellAmplify")));
};
Entities.GetSpellAmplify = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetSpellAmplify")));
};
Entities.GetStatusResistance = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetStatusResistance")));
};
Entities.GetEvasion = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetEvasion")));
};
Entities.GetCooldownReduction = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetCooldownReduction")));
};
Entities.HasHeroAttribute = (iUnitEntIndex) => {
	return Entities.HasBuff(iUnitEntIndex, "modifier_hero_attribute");
};
Entities.GetBaseStrength = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetBaseStrength")));
};
Entities.GetStrength = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetStrength")));
};
Entities.GetBaseAgility = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetBaseAgility")));
};
Entities.GetAgility = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetAgility")));
};
Entities.GetBaseIntellect = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetBaseIntellect")));
};
Entities.GetIntellect = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetIntellect")));
};
Entities.GetAllStats = (iUnitEntIndex) => {
	return Entities.GetStrength(iUnitEntIndex) + Entities.GetAgility(iUnitEntIndex) + Entities.GetIntellect(iUnitEntIndex);
};
Entities.GetBaseAllStats = (iUnitEntIndex) => {
	return Entities.GetBaseStrength(iUnitEntIndex) + Entities.GetBaseAgility(iUnitEntIndex) + Entities.GetBaseIntellect(iUnitEntIndex);
};
Entities.GetPrimaryAttribute = (iUnitEntIndex) => {
	if (Entities.HasHeroAttribute(iUnitEntIndex)) {
		let iBuffIndex = Entities.FindBuffByName(iUnitEntIndex, "modifier_hero_attribute");
		if (iBuffIndex == -1) return -1;
		return Buffs.GetStackCount(iUnitEntIndex, iBuffIndex);
	}
};

Entities.GetHealthBarWidth = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetHealthBarWidth")), -1);
};

Entities.GetHealthBarHeight = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetHealthBarHeight")), -1);
};

let tAddedProperties = {
	_str: "GetStrength",
	_agi: "GetAgility",
	_int: "GetIntellect",
	_all: "GetAllStats",
	_attack_damage: "GetAttackDamage",
	_attack_speed: "GetAttackSpeedPercent",
	_health: "GetCustomMaxHealth",
	_mana: "GetMaxMana",
	_armor: "GetArmor",
	_magical_armor: "GetMagicalArmor",
	_move_speed: "GetMoveSpeed",
};

function GetSpecialValuesWithCalculated(sAbilityName, sName, iEntityIndex = -1) {
	let aOriginalValues = GetSpecialValues(sAbilityName, sName, iEntityIndex);
	for (let i = 0; i < aOriginalValues.length; i++) {
		let v = aOriginalValues[i];
		aOriginalValues[i] = CalcSpecialValueUpgrade(iEntityIndex, sAbilityName, sName, v);
	}
	let aValues = JSON.parse(JSON.stringify(aOriginalValues));
	let tAddedValues = {};
	let tAddedFactors = {};
	let aMinValues = GetSpecialValueProperty(sAbilityName, sName, "_min", iEntityIndex);
	if (aMinValues) {
		aMinValues = StringToValues(aMinValues);
		for (let i = 0; i < aMinValues.length; i++) {
			let v = aMinValues[i];
			aMinValues[i] = CalcSpecialValuePropertyUpgrade(iEntityIndex, sAbilityName, sName, "_min", v);
		}
	}
	let aMaxValues = GetSpecialValueProperty(sAbilityName, sName, "_max", iEntityIndex);
	if (aMaxValues) {
		aMaxValues = StringToValues(aMaxValues);
		for (let i = 0; i < aMaxValues.length; i++) {
			let v = aMaxValues[i];
			aMaxValues[i] = CalcSpecialValuePropertyUpgrade(iEntityIndex, sAbilityName, sName, "_max", v);
		}
	}

	let sType = GetSpecialVarType(sAbilityName, sName);
	let iMaxLevel = aValues.length;
	for (const key in tAddedProperties) {
		const sFuncName = tAddedProperties[key];
		let func = Entities[sFuncName];
		if (typeof (func) != "function") continue;
		let sFactors = GetSpecialValueProperty(sAbilityName, sName, key, iEntityIndex);
		if (sFactors) {
			tAddedValues[key] = [];
			tAddedFactors[key] = [];
			let aFactors = StringToValues(sFactors);
			iMaxLevel = Math.max(aFactors.length, iMaxLevel);
			for (let i = 0; i < Math.max(aFactors.length, aValues.length); i++) {
				let factor = aFactors[Clamp(i, 0, aFactors.length - 1)];
				factor = CalcSpecialValuePropertyUpgrade(iEntityIndex, sAbilityName, sName, key, factor);
				tAddedFactors[key][i] = factor;
				let addedValue = factor * Entities[sFuncName](iEntityIndex);
				if (sType == "FIELD_INTEGER") {
					addedValue = parseInt(addedValue);
				} else if (sType == "FIELD_FLOAT") {
					addedValue = Float(addedValue);
				}
				tAddedValues[key][i] = addedValue;
			}
		} else {
			let extra_factor = GetSpecialValuePropertyUpgrade(iEntityIndex, sAbilityName, sName, key, AbilityUpgradeOperator.ABILITY_UPGRADES_OP_ADD);
			if (extra_factor != 0) {
				tAddedValues[key] = [];
				tAddedFactors[key] = [];
				for (let i = 0; i < aValues.length; i++) {
					let factor = extra_factor;
					tAddedFactors[key][i] = factor;
					let addedValue = factor * Entities[sFuncName](iEntityIndex);
					if (sType == "FIELD_INTEGER") {
						addedValue = parseInt(addedValue);
					} else if (sType == "FIELD_FLOAT") {
						addedValue = Float(addedValue);
					}
					tAddedValues[key][i] = addedValue;
				}
			}
		}
	}
	Object.keys(tAddedValues).forEach(key => {
		let aNewValues = JSON.parse(JSON.stringify(aValues));
		for (let i = 0; i < iMaxLevel; i++) {
			let value = aValues[Clamp(i, 0, aValues.length - 1)] || 0;
			value = value + tAddedValues[key][Clamp(i, 0, tAddedValues[key].length - 1)];
			aNewValues[i] = value;
		}
		aValues = aNewValues;
	});

	if (aMinValues) {
		for (let i = 0; i < aValues.length; i++) {
			aValues[i] = Math.max(aValues[i], aMinValues[Clamp(i, 0, aMinValues.length - 1)]);
		}
	}

	if (aMaxValues) {
		for (let i = 0; i < aValues.length; i++) {
			aValues[i] = Math.min(aValues[i], aMaxValues[Clamp(i, 0, aMaxValues.length - 1)]);
		}
	}

	return {
		aValues: aValues,
		aOriginalValues: aOriginalValues,
		aMinValues: aMinValues,
		aMaxValues: aMaxValues,
		tAddedFactors: tAddedFactors,
		tAddedValues: tAddedValues,
	};
}

var AbilityUpgradeOperator;
(function (AbilityUpgradeOperator) {
	AbilityUpgradeOperator[AbilityUpgradeOperator["ABILITY_UPGRADES_OP_ADD"] = 0] = "ABILITY_UPGRADES_OP_ADD";
	AbilityUpgradeOperator[AbilityUpgradeOperator["ABILITY_UPGRADES_OP_MUL"] = 1] = "ABILITY_UPGRADES_OP_MUL";
})(AbilityUpgradeOperator || (AbilityUpgradeOperator = {}));

var AbilityUpgradeType;
(function (AbilityUpgradeType) {
	AbilityUpgradeType[AbilityUpgradeType["ABILITY_UPGRADES_TYPE_SPECIAL_VALUE"] = 0] = "ABILITY_UPGRADES_TYPE_SPECIAL_VALUE";
	AbilityUpgradeType[AbilityUpgradeType["ABILITY_UPGRADES_TYPE_SPECIAL_VALUE_PROPERTY"] = 1] = "ABILITY_UPGRADES_TYPE_SPECIAL_VALUE_PROPERTY";
	AbilityUpgradeType[AbilityUpgradeType["ABILITY_UPGRADES_TYPE_STATS"] = 2] = "ABILITY_UPGRADES_TYPE_STATS";
	AbilityUpgradeType[AbilityUpgradeType["ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS"] = 3] = "ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS";
	AbilityUpgradeType[AbilityUpgradeType["ABILITY_UPGRADES_TYPE_ADD_ABILITY"] = 4] = "ABILITY_UPGRADES_TYPE_ADD_ABILITY";
})(AbilityUpgradeType || (AbilityUpgradeType = {}));

var AbilityUpgradeKeyType;
(function (AbilityUpgradeKeyType) {
	AbilityUpgradeKeyType[AbilityUpgradeKeyType["UPGRADES_KEY_DATA"] = 0] = "UPGRADES_KEY_DATA";
	AbilityUpgradeKeyType[AbilityUpgradeKeyType["UPGRADES_KEY_CACHED_RESULT"] = 1] = "UPGRADES_KEY_CACHED_RESULT";
})(AbilityUpgradeKeyType || (AbilityUpgradeKeyType = {}));

function unzip(t1, t2) {
	let object = {};
	for (let index = 0; index < t2.length; index++) {
		const k = t1[index];
		const v = t2[index];
		if (v != "null") {
			object[k] = v;
		}
	}
	return object;
}

function GetSpecialValueUpgrade(iEntityIndex, sAbilityName, sSpecialValueName, iOperator) {
	if (!Entities.IsValidEntity(iEntityIndex)) return 0;

	let t = CustomNetTables.GetTableValue("ability_upgrades_result", iEntityIndex.toString());
	if (!t || typeof (t.json) != "string") return 0;

	let tCachedResult = JSON.parse(t.json);
	if (!tCachedResult) return 0;

	let tAllSpecialValueCachedResult = tCachedResult[AbilityUpgradeType.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE];
	if (typeof (tAllSpecialValueCachedResult) != "object" || typeof (tAllSpecialValueCachedResult[sAbilityName]) != "object" || typeof (tAllSpecialValueCachedResult[sAbilityName][sSpecialValueName]) != "object") return 0;

	return tAllSpecialValueCachedResult[sAbilityName][sSpecialValueName][iOperator] || 0;
}

function CalcSpecialValueUpgrade(iEntityIndex, sAbilityName, sSpecialValueName, fValue) {
	return Float((fValue + GetSpecialValueUpgrade(iEntityIndex, sAbilityName, sSpecialValueName, AbilityUpgradeOperator.ABILITY_UPGRADES_OP_ADD)) * (1 + GetSpecialValueUpgrade(iEntityIndex, sAbilityName, sSpecialValueName, AbilityUpgradeOperator.ABILITY_UPGRADES_OP_MUL) * 0.01));
}

function GetSpecialValuePropertyUpgrade(iEntityIndex, sAbilityName, sSpecialValueName, sSpecialValueProperty, iOperator) {
	if (!Entities.IsValidEntity(iEntityIndex)) return 0;

	let t = CustomNetTables.GetTableValue("ability_upgrades_result", iEntityIndex.toString());
	if (!t || typeof (t.json) != "string") return 0;

	let tCachedResult = JSON.parse(t.json);
	if (!tCachedResult) return 0;

	let tAllSpecialValuePropertyCachedResult = tCachedResult[AbilityUpgradeType.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE_PROPERTY];
	if (typeof (tAllSpecialValuePropertyCachedResult) != "object" || typeof (tAllSpecialValuePropertyCachedResult[sAbilityName]) != "object" || typeof (tAllSpecialValuePropertyCachedResult[sAbilityName][sSpecialValueName]) != "object" || typeof (tAllSpecialValuePropertyCachedResult[sAbilityName][sSpecialValueName][sSpecialValueProperty]) != "object") return 0;

	return tAllSpecialValuePropertyCachedResult[sAbilityName][sSpecialValueName][sSpecialValueProperty][iOperator] || 0;
}

function CalcSpecialValuePropertyUpgrade(iEntityIndex, sAbilityName, sSpecialValueName, sSpecialValueProperty, fValue) {
	return Float((fValue + GetSpecialValuePropertyUpgrade(iEntityIndex, sAbilityName, sSpecialValueName, sSpecialValueProperty, AbilityUpgradeOperator.ABILITY_UPGRADES_OP_ADD)) * (1 + GetSpecialValuePropertyUpgrade(iEntityIndex, sAbilityName, sSpecialValueName, sSpecialValueProperty, AbilityUpgradeOperator.ABILITY_UPGRADES_OP_MUL) * 0.01));
}

function GetAbilityMechanicsUpgradeLevelSpecialValue(iEntityIndex, sAbilityName, sKey, iLevel) {
	if (!Entities.IsValidEntity(iEntityIndex)) return;

	let t = CustomNetTables.GetTableValue("ability_upgrades_result", iEntityIndex.toString());
	if (!t || typeof (t.json) != "string") return;

	let tCachedResult = JSON.parse(t.json);
	if (!tCachedResult) return;

	let tAllAbilityMechanicsCachedResult = tCachedResult[AbilityUpgradeType.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS];
	if (typeof (tAllAbilityMechanicsCachedResult) != "object" || typeof (tAllAbilityMechanicsCachedResult[sAbilityName]) != "object") return;

	let tAbilityMechanicsCachedResult = tAllAbilityMechanicsCachedResult[sAbilityName];
	for (const sDescription in tAbilityMechanicsCachedResult) {
		const tValues = tAbilityMechanicsCachedResult[sDescription];
		let aValues = tValues[sKey];
		if (aValues && aValues.value) {
			return aValues.value[Clamp(iLevel, 0, aValues.value.length - 1)];
		}
	}

	return;
}

function GetAbilityMechanicsUpgradeLevelSpecialValueProperty(iEntityIndex, sAbilityName, sKey, sPropertyName) {
	if (!Entities.IsValidEntity(iEntityIndex)) return;

	let t = CustomNetTables.GetTableValue("ability_upgrades_result", iEntityIndex.toString());
	if (!t || typeof (t.json) != "string") return;

	let tCachedResult = JSON.parse(t.json);
	if (!tCachedResult) return;

	let tAllAbilityMechanicsCachedResult = tCachedResult[AbilityUpgradeType.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS];
	if (typeof (tAllAbilityMechanicsCachedResult) != "object" || typeof (tAllAbilityMechanicsCachedResult[sAbilityName]) != "object") return;

	let tAbilityMechanicsCachedResult = tAllAbilityMechanicsCachedResult[sAbilityName];
	for (const sDescription in tAbilityMechanicsCachedResult) {
		const tValues = tAbilityMechanicsCachedResult[sDescription];
		let aValues = tValues[sKey];
		if (aValues) {
			return aValues[sPropertyName];
		}
	}

	return;
}

function GetAbilityMechanicsUpgradeSpecialValues(iEntityIndex, sAbilityName, sKey) {
	if (!Entities.IsValidEntity(iEntityIndex)) return;

	let t = CustomNetTables.GetTableValue("ability_upgrades_result", iEntityIndex.toString());
	if (!t || typeof (t.json) != "string") return;

	let tCachedResult = JSON.parse(t.json);
	if (!tCachedResult) return;

	let tAllAbilityMechanicsCachedResult = tCachedResult[AbilityUpgradeType.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS];
	if (typeof (tAllAbilityMechanicsCachedResult) != "object" || typeof (tAllAbilityMechanicsCachedResult[sAbilityName]) != "object") return;

	let tAbilityMechanicsCachedResult = tAllAbilityMechanicsCachedResult[sAbilityName];
	for (const sDescription in tAbilityMechanicsCachedResult) {
		const tValues = tAbilityMechanicsCachedResult[sDescription];
		let aValues = tValues[sKey];
		if (aValues && aValues.value) {
			return aValues.value;
		}
	}

	return;
}

function GetAbilityMechanicsUpgradeSpecialNames(iEntityIndex, sAbilityName) {
	if (!Entities.IsValidEntity(iEntityIndex)) return [];

	let t = CustomNetTables.GetTableValue("ability_upgrades_result", iEntityIndex.toString());
	if (!t || typeof (t.json) != "string") return [];

	let tCachedResult = JSON.parse(t.json);
	if (!tCachedResult) return [];

	let tAllAbilityMechanicsCachedResult = tCachedResult[AbilityUpgradeType.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS];
	if (typeof (tAllAbilityMechanicsCachedResult) != "object" || typeof (tAllAbilityMechanicsCachedResult[sAbilityName]) != "object") return [];

	let aNames = [];
	let tAbilityMechanicsCachedResult = tAllAbilityMechanicsCachedResult[sAbilityName];
	for (const sDescription in tAbilityMechanicsCachedResult) {
		const tValues = tAbilityMechanicsCachedResult[sDescription];
		for (const sName in tValues) {
			aNames.push(sName);
		}
	}

	return aNames;
}

function GetUnitAbilities(sUnitName) {
	var tUnitKeyValues = CustomUIConfig.UnitsKv[sUnitName];

	var aAbilities = [];

	if (tUnitKeyValues) {
		for (var i = 0; i < 32; i++) {
			var sKey = "Ability" + (i + 1).toString();
			if (tUnitKeyValues[sKey] && tUnitKeyValues[sKey] != "") {
				aAbilities.push(tUnitKeyValues[sKey]);
			}
		}
	}

	return aAbilities;
}

function GetItemValue(sItemName, sKeyName) {
	var tItemKeyValues = CustomUIConfig.ItemsKv[sItemName];

	if (tItemKeyValues) {
		return tItemKeyValues[sKeyName];
	}
	return;
}

function GetItemCost(sItemName) {
	return Number(GetItemValue(sItemName, "ItemCost")) || 0;
}

function GetItemRarity(sItemName) {
	let iRarity = GetItemValue(sItemName, "Rarity");
	if (iRarity == undefined || iRarity == null) {
		return -1;
	}
	return iRarity;
}
function GetCustomItemType(sItemName) {
	let sType = GetItemValue(sItemName, "CustomItemType");
	if (sType == undefined || sType == null) {
		return "";
	}
	return sType;
}

function GetItemRecipes(sItemName) {
	let aList = [];
	let sItemRecipe = GetItemValue(sItemName, "ItemRecipe");
	if (typeof sItemRecipe == "string") {
		sItemRecipe = sItemRecipe.replace(/\s/g, "");
		let a = sItemRecipe.split(/\|/g);
		for (let i = 0; i < a.length; i++) {
			let _a = a[i].split(/\+/g);
			let l = [];
			for (let j = 0; j < _a.length; j++) {
				l.push(_a[j]);
			}
			aList.push(l);
		}
	}
	return aList;
}

function GetItemRelatedRecipes(sItemName) {
	let aList = [];
	for (const _sItemName in CustomUIConfig.ItemsKv) {
		let aRecipes = GetItemRecipes(_sItemName);
		if (aRecipes.length > 0) {
			for (let i = 0; i < aRecipes.length; i++) {
				const aRecipe = aRecipes[i];
				if (aRecipe.indexOf(sItemName) != -1) {
					aList.push(aRecipe);
				}
			}
		}
	}
	return aList;
}

function GetItemRelatedRecipesWithResults(sItemName) {
	let aList = [];
	let aResults = [];
	for (const _sItemName in CustomUIConfig.ItemsKv) {
		let aRecipes = GetItemRecipes(_sItemName);
		if (aRecipes.length > 0) {
			for (let i = 0; i < aRecipes.length; i++) {
				const aRecipe = aRecipes[i];
				if (aRecipe.indexOf(sItemName) != -1) {
					aList.push(aRecipe);
					aResults.push(_sItemName);
				}
			}
		}
	}
	return [aList, aResults];
}



CustomUIConfig.GetCursorEntity = function (aPosition = GameUI.GetCursorPosition()) {
	let targets = GameUI.FindScreenEntities(aPosition);
	let world_position = GameUI.GetScreenWorldPosition(aPosition);
	let targets1 = targets.filter((e) => {
		return e.accurateCollision;
	});
	let targets2 = targets.filter((e) => {
		return !e.accurateCollision;
	});
	targets = targets1;
	if (targets1.length == 0) {
		targets = targets2;
	}
	if (targets.length == 0) {
		return -1;
	}
	targets.sort((a, b) => {
		let a_loc = Entities.GetAbsOrigin(a.entityIndex);
		let b_loc = Entities.GetAbsOrigin(b.entityIndex);
		return Game.Length2D(a_loc, world_position) - Game.Length2D(b_loc, world_position);
	});
	return targets[0].entityIndex;
};

CustomUIConfig.GetCursorPhysicalItem = function (aPosition = GameUI.GetCursorPosition()) {
	let targets = GameUI.FindScreenEntities(aPosition);
	let world_position = GameUI.GetScreenWorldPosition(aPosition);
	targets = targets.filter((e) => {
		return Entities.IsItemPhysical(e.entityIndex);
	});
	let targets1 = targets.filter((e) => {
		return e.accurateCollision;
	});
	let targets2 = targets.filter((e) => {
		return !e.accurateCollision;
	});
	targets = targets1;
	if (targets1.length == 0) {
		targets = targets2;
	}
	if (targets.length == 0) {
		return -1;
	}
	targets.sort((a, b) => {
		let a_loc = Entities.GetAbsOrigin(a.entityIndex);
		let b_loc = Entities.GetAbsOrigin(b.entityIndex);
		return Game.Length2D(a_loc, world_position) - Game.Length2D(b_loc, world_position);
	});
	return targets[0].entityIndex;
};


if (GameUI.CustomUIConfig()._Request_QueueIndex == undefined) {
	GameUI.CustomUIConfig()._Request_QueueIndex = 0;
}
if (GameUI.CustomUIConfig()._Request_Table == undefined) {
	GameUI.CustomUIConfig()._Request_Table = {};
}
if (GameUI.CustomUIConfig()._Request_Result == undefined) {
	GameUI.CustomUIConfig()._Request_Result = {};
}

function Request(event, data, func, timeout) {
	let index = "-1";
	if (typeof func === "function") {
		index = (GameUI.CustomUIConfig()._Request_QueueIndex++).toString();
		GameUI.CustomUIConfig()._Request_Table[index] = func;
	}
	GameEvents.SendCustomEventToServer("service_events_req", {
		event: event,
		data: JSON.stringify(data),
		queueIndex: index
	});
	timeout = timeout || REQUEST_TIME_OUT;
	$.Schedule(timeout, function () {
		delete GameUI.CustomUIConfig()._Request_Table[index];
	});
	return index;
}

function CancelRequest(index) {
	if (GameUI.CustomUIConfig()._Request_Table[index] != undefined) {
		delete GameUI.CustomUIConfig()._Request_Table[index];
	}
}

function ClientRequest(event, data) {
	let t = CustomNetTables.GetTableValue("common", "client_ability");
	if (t) {
		let iAbilityEntIndex = t._;
		if (typeof iAbilityEntIndex == "number" && Entities.IsValidEntity(iAbilityEntIndex)) {
			GameEvents.SendEventClientSide("client_request_event", {
				event: event,
				data: JSON.stringify(data),
			});
			let sValue = Abilities.GetAbilityTextureName(iAbilityEntIndex);
			let s;
			try {
				s = JSON.parse(sValue);
			} catch (error) {
			}
			return s;
		}
	}
}

function RegisterAbilityKeyEvent(iSlot, sKeyName, bQuickCast) {
	let tData = ClientRequest("register_ability_key_event", { slot: iSlot, key_name: sKeyName, quick_cast: bQuickCast });
	if (tData) {
		let sEventName = tData.event_name;
		Game.AddCommand(`+${sEventName}`, () => {
			let hCaster = Players.GetSelectedEntities(Players.GetLocalPlayer())[0];
			if (Entities.IsValidEntity(hCaster)) {
				let hAbility = Entities.GetAbility(hCaster, iSlot);
				if (Entities.IsValidEntity(hAbility)) {
					if (GameUI.IsAltDown() && Abilities.IsAutocast(hAbility)) {
						GameEvents.SendEventClientSide("custom_ability_key_event", {
							event_name: sEventName,
							phase: 0,
						});
						return;
					} else {
						GameEvents.SendEventClientSide("custom_ability_key_event", {
							event_name: sEventName,
							phase: 1,
						});
					}
				}
			}
		}, "", 67108864);
		Game.AddCommand(`-${sEventName}`, () => {
			let hCaster = Players.GetSelectedEntities(Players.GetLocalPlayer())[0];
			if (Entities.IsValidEntity(hCaster)) {
				let hAbility = Entities.GetAbility(hCaster, iSlot);
				if (Entities.IsValidEntity(hAbility)) {
					GameEvents.SendEventClientSide("custom_ability_key_event", {
						event_name: sEventName,
						phase: 2,
					});
				}
			}
		}, "", 67108864);
		return tData.event_name;
	}
}

function UnregisterAbilityKeyEvent(sEventName) {
	ClientRequest("unregister_ability_key_event", { event_name: sEventName });
}

/**
 * 获取游戏是团队还是个人模式
 * @return: 0:团队，1:个人
 */
CustomUIConfig.GetCountingMode = function () {
	var table = CustomNetTables.GetTableValue("common", "game_mode_info");
	return table.counting_mode;
};
CustomUIConfig.GetDifficulty = function () {
	var slocalPlayerID = Players.GetLocalPlayer().toString();
	var table = CustomNetTables.GetTableValue("common", "game_mode_info");
	return table.difficulty[slocalPlayerID];
};


function GetNameBySteamID(sSteamID) {
	return CustomUIConfig.tSteamID2Name[sSteamID];
}

function RequestSteamID2Name(tSteamIDs, fCallBack) {
	var tRequestSteamIDs = [];
	// 仅请求还未获取的steamid
	for (var i in tSteamIDs) {
		if (CustomUIConfig.tSteamID2Name[tSteamIDs[i]] != undefined && CustomUIConfig.tSteamID2Name[tSteamIDs[i]] != null) {
			tRequestSteamIDs.push(tSteamIDs[i]);
		}
	}
	if (tRequestSteamIDs.length < 1) {
		if (typeof (fCallBack) == "function") {
			fCallBack();
		}
		return;
	}

	let url = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=" + STEAM_WEB_KEY + "&steamids=" + tRequestSteamIDs.join(',');
	$.AsyncWebRequest(url, {
		type: 'GET',
		timeout: 6000,
		success: function (tData, b, c) {
			for (var i in tData.response.players) {
				CustomUIConfig.tSteamID2Name[tData.response.players[i].steamid] = tData.response.players[i].personaname;
			}
			if (typeof (fCallBack) == "function") {
				fCallBack();
			}
		},
		error: function (a) {
			$.Msg("RequestSteamID2Name fail");
		},
	});
}

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

	// print(sKey, "\t", fTime, "\t", funcCallback)
}

CustomUIConfig.ShowAbilityTooltip = (panel, abilityname, entityindex = -1, inventoryslot = -1, level = -1) => {
	if (typeof (panel) != "object" || typeof (panel.IsValid) != "function" || !panel.IsValid()) {
		throw "ShowAbilityTooltip must have a panel parameter!";
	}
	if (typeof (abilityname) != "string") {
		throw "abilityname is not a string type!";
	}
	// if (GameUI.IsControlDown()) {
	// 	let tAbility = GameUI.CustomUIConfig().AbilitiesKv[abilityname];
	// 	let tItem = GameUI.CustomUIConfig().ItemsKv[abilityname];
	// 	let tData = tAbility || tItem;
	// 	let bIsItem = (tData != tAbility && tData == tItem);

	// 	print(bIsItem);
	// 	print(panel, abilityname, entityindex, inventoryslot, level);

	// 	if (entityindex != -1 && inventoryslot != -1) {
	// 		$.DispatchEvent("DOTAShowAbilityInventoryItemTooltip", panel, entityindex, inventoryslot);
	// 	} else if (entityindex != -1 && bIsItem) {
	// 		$.Msg(1);
	// 		$.DispatchEvent("DOTAShowAbilityShopItemTooltip", panel, abilityname, "", entityindex);
	// 	} else if (entityindex != -1) {
	// 		$.DispatchEvent("DOTAShowAbilityTooltipForEntityIndex", panel, abilityname, entityindex);
	// 	} else if (level != -1) {
	// 		$.DispatchEvent("DOTAShowAbilityTooltipForLevel", panel, abilityname, level);
	// 	} else {
	// 		$.DispatchEvent("DOTAShowAbilityTooltip", panel, abilityname);
	// 	}
	// 	return;
	// }
	$.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, "AbilityTooltiop", "file://{resources}/layout/custom_game/tooltips/tooltip_ability/tooltip_ability.xml", "abilityname=" + abilityname + "&entityindex=" + entityindex + "&inventoryslot=" + inventoryslot + "&level=" + level);
};

CustomUIConfig.HideAbilityTooltip = (panel) => {
	if (typeof (panel) != "object" || typeof (panel.IsValid) != "function" || !panel.IsValid()) {
		throw "ShowAbilityTooltip must have a panel parameter!";
	}
	// if (GameUI.IsControlDown()) {
	// 	$.DispatchEvent("DOTAHideAbilityTooltip", panel);
	// 	return;
	// }
	$.DispatchEvent("UIHideCustomLayoutTooltip", panel, "AbilityTooltiop");
};

CustomUIConfig.ShowEquipmentTooltip = (panel, eid, eidpool = "PlayerEquipment") => {
	if (typeof (panel) != "object" || typeof (panel.IsValid) != "function" || !panel.IsValid()) {
		throw "ShowEquipmentTooltip must have a panel parameter!";
	}
	$.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, "EquipmentTooltip", "file://{resources}/layout/custom_game/tooltips/tooltip_equipment/tooltip_equipment.xml", "eid=" + eid + "&eidpool=" + eidpool);
};

CustomUIConfig.HideEquipmentTooltip = (panel) => {
	if (typeof (panel) != "object" || typeof (panel.IsValid) != "function" || !panel.IsValid()) {
		throw "HideEquipmentTooltip must have a panel parameter!";
	}
	$.DispatchEvent("UIHideCustomLayoutTooltip", panel, "EquipmentTooltip");
};

CustomUIConfig.ShowAbilityStoneTooltip = (panel, aid, aidpool = "PlayerAbilityStone") => {
	if (typeof (panel) != "object" || typeof (panel.IsValid) != "function" || !panel.IsValid()) {
		throw "ShowAbilityStoneTooltip must have a panel parameter!";
	}
	$.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, "AbilityStoneTooltip", "file://{resources}/layout/custom_game/tooltips/tooltip_ability_stone/tooltip_ability_stone.xml", "aid=" + aid + "&aidpool=" + aidpool);
};

CustomUIConfig.HideAbilityStoneTooltip = (panel) => {
	if (typeof (panel) != "object" || typeof (panel.IsValid) != "function" || !panel.IsValid()) {
		throw "HideAbilityStoneTooltip must have a panel parameter!";
	}
	$.DispatchEvent("UIHideCustomLayoutTooltip", panel, "AbilityStoneTooltip");
};

CustomUIConfig.ShowAbilityStoneAbilityTooltip = (panel, abilityid, abilitycount = -1) => {
	if (typeof (panel) != "object" || typeof (panel.IsValid) != "function" || !panel.IsValid()) {
		throw "ShowAbilityStoneAbilityTooltip must have a panel parameter!";
	}
	$.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, "AbilityStoneAbilityTooltip", "file://{resources}/layout/custom_game/tooltips/tooltip_ability_stone_ability/tooltip_ability_stone_ability.xml", "abilityid=" + abilityid + "&abilitycount=" + abilitycount);
};

CustomUIConfig.HideAbilityStoneAbilityTooltip = (panel) => {
	if (typeof (panel) != "object" || typeof (panel.IsValid) != "function" || !panel.IsValid()) {
		throw "HideAbilityStoneAbilityTooltip must have a panel parameter!";
	}
	$.DispatchEvent("UIHideCustomLayoutTooltip", panel, "AbilityStoneAbilityTooltip");
};

CustomUIConfig.ShowMedalWallTooltip = (panel, iPlayerID, abilitycount = -1) => {
	if (typeof (panel) != "object" || typeof (panel.IsValid) != "function" || !panel.IsValid()) {
		throw "ShowMedalWallTooltip must have a panel parameter!";
	}
	$.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, "ShowMedalWallTooltip", "file://{resources}/layout/custom_game/tooltips/tooltip_medal_wall/tooltip_medal_wall.xml", "iPlayerID=" + iPlayerID);
};

CustomUIConfig.HideMedalWallTooltip = (panel) => {
	if (typeof (panel) != "object" || typeof (panel.IsValid) != "function" || !panel.IsValid()) {
		throw "HideMedalWallTooltip must have a panel parameter!";
	}
	$.DispatchEvent("UIHideCustomLayoutTooltip", panel, "ShowMedalWallTooltip");
};

CustomUIConfig.ShowInlaidStoneTooltip = (panel, iid, iidpool = "PlayerInlaidStone") => {
	if (typeof (panel) != "object" || typeof (panel.IsValid) != "function" || !panel.IsValid()) {
		throw "ShowInlaidStoneTooltip must have a panel parameter!";
	}
	$.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, "InlaidStoneTooltip", "file://{resources}/layout/custom_game/tooltips/tooltip_inlaid_stone/tooltip_inlaid_stone.xml", "iid=" + iid + "&iidpool=" + iidpool);
};

CustomUIConfig.HideInlaidStoneTooltip = (panel) => {
	if (typeof (panel) != "object" || typeof (panel.IsValid) != "function" || !panel.IsValid()) {
		throw "HideInlaidStoneTooltip must have a panel parameter!";
	}
	$.DispatchEvent("UIHideCustomLayoutTooltip", panel, "InlaidStoneTooltip");
};

CustomUIConfig.ShowPotentialStoneTooltip = (panel, psid, psidpool = "PlayerPotentialStone") => {
	if (typeof (panel) != "object" || typeof (panel.IsValid) != "function" || !panel.IsValid()) {
		throw "ShowPotentialStoneTooltip must have a panel parameter!";
	}
	$.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, "PotentialStoneTooltip", "file://{resources}/layout/custom_game/tooltips/tooltip_potential_stone/tooltip_potential_stone.xml", "psid=" + psid + "&psidpool=" + psidpool);
};

CustomUIConfig.HidePotentialStoneTooltip = (panel) => {
	if (typeof (panel) != "object" || typeof (panel.IsValid) != "function" || !panel.IsValid()) {
		throw "HidePotentialStoneTooltip must have a panel parameter!";
	}
	$.DispatchEvent("UIHideCustomLayoutTooltip", panel, "PotentialStoneTooltip");
};

CustomUIConfig.ShowPotentialTooltip = (panel, pid, pidpool = "PlayerPotential") => {
	if (typeof (panel) != "object" || typeof (panel.IsValid) != "function" || !panel.IsValid()) {
		throw "ShowPotentialTooltip must have a panel parameter!";
	}
	$.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, "PotentialTooltip", "file://{resources}/layout/custom_game/tooltips/tooltip_potential/tooltip_potential.xml", "pid=" + pid + "&pidpool=" + pidpool);
};

CustomUIConfig.HidePotentialTooltip = (panel) => {
	if (typeof (panel) != "object" || typeof (panel.IsValid) != "function" || !panel.IsValid()) {
		throw "HidePotentialTooltip must have a panel parameter!";
	}
	$.DispatchEvent("UIHideCustomLayoutTooltip", panel, "PotentialTooltip");
};

function IsItemLocked(iItemEntIndex) {
	let tData = CustomNetTables.GetTableValue("items", iItemEntIndex.toString());

	if (tData && typeof (tData.bLocked) == "number") {
		return tData.bLocked == 1;
	}

	return false;
}

function ToggleWindows(sName, bShowState) {
	GameEvents.SendEventClientSide("custom_ui_toggle_windows", { window_name: sName, show_state: bShowState });
}

function GetWearableDataByIndex(index) {
	for (const sHeroName in GameUI.CustomUIConfig().WearablesKv) {
		const wearableList = GameUI.CustomUIConfig().WearablesKv[sHeroName];
		for (const itemdef in wearableList) {
			let wearableData = wearableList[itemdef];
			if (itemdef == index) {
				wearableData.used_by_heroes = sHeroName;
				wearableData.itemdef = itemdef;
				return wearableData;
			}
		}
	}
}

function GetHeroWearableListBySlot(sHeroName, sSlot) {
	let wearableList = [];
	for (const itemdef in GameUI.CustomUIConfig().WearablesKv[sHeroName]) {
		const wearableData = GameUI.CustomUIConfig().WearablesKv[sHeroName][itemdef];
		if (String(wearableData.item_slot) == String(sSlot)) {
			wearableList.push(itemdef);
		}
	}
	return wearableList;
}
function GetPlayerWearableData(iPlayerID, iEntIndex, sPlayerWearableIndex) {
	let wearableList = CustomNetTables.GetTableValue("player_data", String(iPlayerID)).wearable_list[iEntIndex];
	for (const key in wearableList) {
		const element = wearableList[key];
		if (element.sPlayerWearableIndex == sPlayerWearableIndex) {
			return element;
		}
	}
}

function Transform(obj, sTagName) {
	let tHeader = CustomNetTables.GetTableValue("header", sTagName);
	let _obj = Array.isArray(obj) ? [] : {};
	for (let i in obj) {
		if (typeof obj[i] === 'object') {
			_obj[tHeader[i] || i] = Transform(obj[i], sTagName);
		}
		else {
			if (typeof obj[i] === 'string') {
				_obj[tHeader[i] || i] = tHeader[obj[i]] || obj[i];
			} else {
				_obj[tHeader[i] || i] = obj[i];
			}
		}
	}
	return _obj;
}

function finiteNumber(i, defaultVar = 0) {
	return isFinite(i) ? i : defaultVar;
}

var PayType;
(function (PayType) {
	PayType[PayType["MONEY"] = 0] = "MONEY";
	PayType[PayType["MOON"] = 1000001] = "MOON";
	PayType[PayType["STAR"] = 1000002] = "STAR";
	PayType[PayType["SHARD"] = 1000003] = "SHARD";
	PayType[PayType["FUNNY"] = 1200001] = "FUNNY";
})(PayType || (PayType = {}));

function GetGoodIDByHeroName(sHeroName) {
	if (CustomUIConfig.HeroesKv[sHeroName] && CustomUIConfig.HeroesKv[sHeroName].GoodID) {
		return CustomUIConfig.HeroesKv[sHeroName].GoodID;
	}
}

function GetHeroNameByGoodID(iGoodID) {
	if (iGoodID == undefined) return undefined;
	for (const sHeroName in CustomUIConfig.HeroesKv) {
		const tData = CustomUIConfig.HeroesKv[sHeroName];
		if (tData.GoodID == iGoodID) {
			return sHeroName;
		}
	}
}

CustomNetTables.GetAllTableValuesKV = (sName) => {
	return CustomNetTables.GetAllTableValues(sName).reduce((accumulator, pair) => Object.assign(Object.assign({}, accumulator), { [pair.key]: pair.value }), {});
};

function RegisterKeyBind(key, onkeydown, onkeyup) {
	const now = Date.now();
	const sCommand = key + now
	Game.CreateCustomKeyBind(key, "+" + sCommand);
	Game.AddCommand("+" + sCommand, () => {
		if (onkeydown) {
			onkeydown();
		}
	}, "", 1 << 31);
	Game.AddCommand("-" + sCommand, () => {
		if (onkeyup) {
			onkeyup();
		}
	}, "", 1 << 31);
}