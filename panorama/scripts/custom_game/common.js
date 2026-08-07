--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


"use strict";
if ($.Localize_EOM == undefined) {
	$.Localize_EOM = $.Localize;
	$.Localize = function (token, ...args) {
		if (!$.CanLocalize(token)) {
			return token;
		}
		if (token == "") return token;
		let parent;
		let value;
		if (args.length == 1) {
			if (typeof args[0] == "number") {
				value = args[0];
			} else {
				parent = args[0];
			}
		}
		if (args.length == 2) {
			value = args[0];
			parent = args[1];
		}
		let originalToken = token;
		if (token[0] != "#") {
			token = "#" + token;
		}

		let old = token;
		if (value != undefined) {
			if (parent != undefined) {
				token = $.Localize_EOM(token, value, parent);
			} else {
				token = $.Localize_EOM(token, value, $.GetContextPanel());
			}
		} else {
			if (parent != undefined) {
				token = $.Localize_EOM(token, parent);
			} else {
				token = $.Localize_EOM(token, $.GetContextPanel());
			}
		}

		if (token.length == old.length && token.toLocaleLowerCase() == old.toLocaleLowerCase()) {
			return originalToken;
		}
		return token;
	};
}
GameEvents.SendCustomEventToServer = (pEventName, eventData) => {
	if (!(Players.GetLocalPlayer() == -1 || Players.IsSpectator(Players.GetLocalPlayer()) || Players.IsLocalPlayerLiveSpectating())) {
		GameEvents.SendCustomGameEventToServer(pEventName, eventData);
	}
};

var CustomUIConfig = GameUI.CustomUIConfig();
var pSelfContextPanel = $.GetContextPanel();
var KeyValues = GameUI.CustomUIConfig();
pSelfContextPanel.iReload = (pSelfContextPanel.iReload ?? -1) + 1;
$.bIsReload = () => {
	return pSelfContextPanel.iReload > 0;
};

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

function formatDate(timestamp) {
	const date = new Date(timestamp);
	const year = date.getFullYear();
	const month = (date.getMonth() + 1).toString().padStart(2, '0');
	const day = date.getDate().toString().padStart(2, '0');
	return `${year}/${month}/${day}`;
}

function print(...other) {
	let s = "";
	let a = [...other];
	a.forEach(e => {
		if (s != "") {
			s += "\t";
		}
		if (e instanceof Object) {
			s = s + JSON.stringify(e);
		} else {
			s = s + String(e);
		}
	});
	$.Msg(s);
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

JSON.parseSafe = function (text, reviver) {
	try {
		return JSON.parse(text, reviver);
	} catch (error) {
		error.message += '\n\tparams={text:' + text + '}';
		// $.Msg(error);
		return {};
	}
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

function FormatNumberBase(fNumber, prec = 2) {
	let sSign = fNumber < 0 ? "-" : "";
	fNumber = Math.abs(fNumber);
	let sNumber = String(Math.abs(fNumber));
	let a = sNumber.split(".");
	let sInteger = a[0];
	let sLanguage = $.Language().toLowerCase();
	if (sLanguage == "schinese") {
		let n = Math.floor((sInteger.length - 1) / 4);
		if (n == 0) {
			return [sSign + String(Round(fNumber, prec))];
		}
		sNumber = String(Round(fNumber / Math.pow(10000, n), prec));
		let sDigit = DigitSchinese[n];
		return [sSign + sNumber, sDigit];
	} else {
		let n = Math.floor((sInteger.length - 1) / 3);
		if (n == 0) {
			return [sSign + String(Round(fNumber, prec))];
		}
		sNumber = String(Round(fNumber / Math.pow(1000, n), prec));
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


function alertObj(obj, name, str, tab_before, should_show_wrapper = true, should_show_name = false) {
	let output = "";
	if (name == null || name == undefined) {
		if (should_show_name) { name = toString(obj); }
		else { name = ""; }
	}
	if (str == null) {
		str = "";
	}
	if (tab_before == null) {
		tab_before = "";
	}
	if (should_show_wrapper) {
		if ((str + name).trim().length == 0) { $.Msg(tab_before + str + "{"); }
		else { $.Msg(tab_before + str + name + "\n" + tab_before + str + "{"); }
	}
	// Check if the `obj` is a dict
	if (obj instanceof Map) {
		$.Msg(`${tab_before}\t/* type: Map, length: ${obj.size} */\n\n`);
		for (const [k, v] of obj.entries()) {
			$.Msg(
				`${tab_before}\t${k.toString()}\t(${typeof k})\n${tab_before}\t{\t(${typeof v})\n\t\t`
			);
			let v_type = typeof v;
			if (v_type == "object") {
				alertObj(v, name, str, tab_before + "\t");
			}
			else { $.Msg(`${tab_before}\t${v}\t(${v_type})\n`); }

			$.Msg(`\n${tab_before}\t}\n`);
		}
	}
	else if (obj instanceof Array) {
		$.Msg(`${tab_before}\t/* type: Array, length: ${obj.length} */\n${tab_before}\t[\n`);
		for (let i = 0; i < obj.length; i++) {
			$.Msg(`${tab_before}\t\t`);

			let obj_i_type = typeof obj[i];
			if (obj_i_type == "object") { alertObj(obj[i], name, str, tab_before + "\t"); }
			else { $.Msg(`${tab_before}\t${obj[i]}\t(${obj_i_type})\n`); }

			if (i + 1 < obj.length) { $.Msg(`${tab_before}\t,`); } else { $.Msg(`\n`); }
		}
		$.Msg(`${tab_before}\t]\n`);
	}
	else {
		// If it is an empty object, print this instead
		if ((!obj) || Object.keys(obj).length <= 0) { $.Msg(tab_before + str + "\t" + "{/* Empty object */}"); }
		else {
			for (let i in obj) {
				let property = obj[i];
				if (typeof (property) == "object") {
					alertObj(property, `${i}\t(${typeof i})`, str, tab_before + "\t");
				} else {
					output = i + " = " + property + "\t(" + typeof (property) + ")";
					$.Msg(tab_before + str + "\t" + output);
				}
			}
		}
	}
	if (should_show_wrapper) { $.Msg(tab_before + str + "}"); }
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

function GetHeroNameByGoodID(Hid) {
	return KeyValues.HeroIDCache[Hid];
}
function GetGoodIDByHeroName(sHeroName) {
	return CustomUIConfig.UnitsCommonKv[sHeroName]?.Hid;
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
						sName != "abilitycooldown" &&
						sName != "abilitychanneltime") {
						aSpecials.push(sName);
						break;
					}
				}
			}
		}
		aSpecials = aSpecials.concat("abilitycastrange", "abilitycastpoint", "abilityduration", "abilitychanneltime", "abilitydamage", "abilitycooldown");
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
Entities.GetUltiPower = (iUnitEntIndex) => {
	return Entities.GetUnitData(iUnitEntIndex, "GetUltiPower");
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
Entities.GetPhysicalCriticalChance = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetPhysicalCriticalChance")));
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
Entities.GetUltiPower = (iUnitEntIndex) => {
	return finiteNumber(Number(Entities.GetUnitData(iUnitEntIndex, "GetUltiPower")));
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
	_ulti: "GetUltiPower",
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

function RegisterAbilityKeyEvent(iSlot, sKeyName, bQuickCast) {
	let tData = clientRequestQuickReturn("register_ability_key_event", {
		slot: iSlot,
		key_name: sKeyName,
		quick_cast: bQuickCast
	});
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

// function UnregisterAbilityKeyEvent(sEventName) {
// 	clientRequest("unregister_ability_key_event", {
// 		event_name: sEventName
// 	}, (tData) => { });
// }

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
	let tAbility = GameUI.CustomUIConfig().AbilitiesKv[abilityname];
	let tItem = GameUI.CustomUIConfig().ItemsKv[abilityname];
	let tData = tAbility || tItem;
	let bIsItem = (tData != tAbility && tData == tItem);

	if (entityindex != -1 && inventoryslot != -1) {
		$.DispatchEvent("DOTAShowAbilityInventoryItemTooltip", panel, entityindex, inventoryslot);
	} else if (entityindex != -1 && bIsItem) {
		$.DispatchEvent("DOTAShowAbilityShopItemTooltip", panel, abilityname, "", entityindex);
	} else if (entityindex != -1) {
		$.DispatchEvent("DOTAShowAbilityTooltipForEntityIndex", panel, abilityname, entityindex);
	} else if (level != -1) {
		$.DispatchEvent("DOTAShowAbilityTooltipForLevel", panel, abilityname, level);
	} else {
		$.DispatchEvent("DOTAShowAbilityTooltip", panel, abilityname);
	}
	return;
	// }
	$.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, "AbilityTooltiop", "file://{resources}/layout/custom_game/tooltips/tooltip_ability/tooltip_ability.xml", "abilityname=" + abilityname + "&entityindex=" + entityindex + "&inventoryslot=" + inventoryslot + "&level=" + level);
};

CustomUIConfig.HideAbilityTooltip = (panel) => {
	if (typeof (panel) != "object" || typeof (panel.IsValid) != "function" || !panel.IsValid()) {
		throw "ShowAbilityTooltip must have a panel parameter!";
	}
	// if (GameUI.IsControlDown()) {
	$.DispatchEvent("DOTAHideAbilityTooltip", panel);
	return;
	// }
	$.DispatchEvent("UIHideCustomLayoutTooltip", panel, "AbilityTooltiop");
};


function IsItemLocked(iItemEntIndex) {
	let tData = CustomNetTables.GetTableValue("items", iItemEntIndex.toString());

	if (tData && typeof (tData.bLocked) == "number") {
		return tData.bLocked == 1;
	}

	return false;
}

function ToggleWindows(sName, state, data) {
	GameEvents.SendEventClientSide("custom_ui_toggle_windows", {
		window_name: sName,
		state: state,
		data: data
	});
}

function Transform(obj, sTagName) {
	let tHeader = CustomNetTables.GetTableValue("header", sTagName) ?? {};
	let _obj = Array.isArray(obj) ? [] : {};
	for (let i in obj) {
		if (typeof obj[i] === 'object') {
			_obj[tHeader[i] || i] = Transform(obj[i], sTagName);
		} else {
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

function deepcopy(origin) {
	let res;
	if (Array.isArray(origin)) {
		res = origin.map((v) => {
			return deepcopy(v);
		});
	}
	else if (origin === null) {
		res = undefined;
	}
	else if (typeof (origin) == "object") {
		res = {};
		for (const k in origin) {
			res[k] = deepcopy(origin[k]);
		}
	}
	else {
		res = origin;
	}
	return res;
}

function multiCompare(...args) {
	for (let i = 0; i < args.length; i++) {
		const arg = args[i];
		if (arg != 0) {
			return arg;
		}
	}
	return args[args.length - 1];
}

var PayType;
(function (PayType) {
	PayType[PayType["MONEY"] = 0] = "MONEY";
	PayType[PayType["MOON"] = 1000001] = "MOON";
	PayType[PayType["STAR"] = 1000002] = "STAR";
	PayType[PayType["SHARD"] = 1000003] = "SHARD";
	PayType[PayType["COIN"] = 1100001] = "COIN";
})(PayType || (PayType = {}));

CustomNetTables.GetAllTableValuesKV = (sName) => {
	return CustomNetTables.GetAllTableValues(sName).reduce((accumulator, pair) => Object.assign(Object.assign({}, accumulator), {
		[pair.key]: pair.value
	}), {});
};

function SubscribeCustomNettable(event, data, func) {
	let index = ServerRequest(event, data, func);

	return index;
}

function keyof(obj) {
	let keys = Object.keys(obj);
	if (obj[Number(keys[0])]) {
		return keys.map((a) => { return Number(a); });
	}
	return keys;
}

/** 转一下格式 */
function getImagePath(relativePath) {
	if (typeof relativePath == "string") {
		return `url('file://{images}/custom_game/${relativePath}')`;
	} else {
		return `url('file://{images}/custom_game/${relativePath.join("/")}')`;
	}
}
/** 转一下格式 */
function getSrcPath(relativePath) {
	if (typeof relativePath == "string") {
		return `s2r://panorama/images/custom_game/${relativePath.replace(".png", "_png")}.vtex`;
	} else {
		return `s2r://panorama/images/custom_game/${relativePath.join("/").replace(".png", "_png")}`;
	}
}
// TODO:
// function useLocalMessage(eventName, callback) {
// 	let event = eventName;
// 	if (GameUI.CustomUIConfig()._Local_Message_Date_) {
// 		event = event + GameUI.CustomUIConfig()._Local_Message_Date_;
// 	}
// 	Game.AddCommand(event, (_, v) => {
// 		if (callback) {
// 			callback(JSON.parse(v));
// 		}
// 	}, "", 1 << 26);
// }

/** 封装客户端消息 */
function clientSideEvent(eventName, eventData) {
	GameEvents.SendEventClientSide("client_side_event", { event_name: eventName, event_data: JSON.stringify(eventData) });
}
/** 发送UI端事件到所有客户端 */
function allClientSideEvent(eventName, eventData) {
	GameEvents.SendCustomGameEventToAllClients("client_side_event", { event_name: eventName, event_data: JSON.stringify(eventData) });
}
/** 封装客户端消息 */
function useClientSideEvent(eventName, callback) {
	return GameEvents.Subscribe("client_side_event", (eventData) => {
		if (eventName == eventData.event_name) {
			callback(JSON.parse(eventData.event_data));
		}
	});
}
/** 封装客户端消息 */
function useToggleWindow(windowName, value, setter) {
	return GameEvents.Subscribe("custom_ui_toggle_windows", (eventData) => {
		if (eventData.window_name == windowName) {
			if (eventData.state) {
				setter(eventData.state == 1);
			} else {
				setter(!value());
			}
		} else {
			setter(false);
		}
	});
}
/** 网表，但是套的netdata的定义，因为是json所以会保留array */
function useServiceNetTable(tableName, callback, playerID) {
	if (playerID == -1) {
		// 处理16人房间的情况
		for (let id = 0; id < 16; id++) {
			const tableKey = tableName + id;
			const cache = CustomNetTables.GetTableValue("service", tableKey);
			if (cache != undefined) {
				const data = JSON.parse(cache.data);
				callback(data, id);
			}
		}
		return CustomNetTables.SubscribeNetTableListener("service", (_, key, value) => {
			if (new RegExp(`^${tableName}\\d+$`).test(key)) {
				const data = JSON.parse(value.data);
				const id = finiteNumber(Number(key.match(/\d+$/)?.[0]), -1);
				callback(data, id);
			}
		});
	} else if (typeof playerID == "number") {
		const tableKey = tableName + playerID.toString();
		const cache = CustomNetTables.GetTableValue("service", tableKey);
		if (cache != undefined) {
			const data = JSON.parse(cache.data);
			callback(data);
		}
		return CustomNetTables.SubscribeNetTableListener("service", (_, key, value) => {
			if (key == tableKey) {
				const data = JSON.parse(value.data);
				callback(data);
			}
		});
	} else {
		const tableKey = tableName;
		const cache = CustomNetTables.GetTableValue("service", tableKey);
		if (cache != undefined) {
			const data = JSON.parse(cache.data);
			callback(data);
		}
		return CustomNetTables.SubscribeNetTableListener("service", (_, key, value) => {
			if (key == tableKey) {
				const data = JSON.parse(value.data);
				callback(data);
			}
		});
	}
}
function getServiceNetTable(tableName, playerID) {
	if (playerID == -1) {
		const result = {};
		for (let id = 0; id < 16; id++) {
			const tableKey = tableName + id;
			const cache = CustomNetTables.GetTableValue("service", tableKey);
			if (cache != undefined) {
				const data = JSON.parse(cache.data);
				result[id] = data;
			}
		}
		return result;
	} else if (typeof playerID == "number") {
		const tableKey = tableName + playerID.toString();
		const cache = CustomNetTables.GetTableValue("service", tableKey);
		if (cache != undefined) {
			const data = JSON.parse(cache.data);
			return data;
		}
	} else {
		const tableKey = tableName;
		const cache = CustomNetTables.GetTableValue("service", tableKey);
		if (cache != undefined) {
			const data = JSON.parse(cache.data);
			return data;
		}
	}
}
function useNetTableKeyHasDefaultValue(tableName, tableKey, callback) {
	const cache = CustomNetTables.GetTableValue(tableName, tableKey);
	if (cache) {
		callback(cache);
	}
	return useNetTableKey(tableName, tableKey, callback);
}
function useNetTableKey(tableName, tableKey, callback) {
	return CustomNetTables.SubscribeNetTableListener(tableName, (tableName, key, value) => {
		if (key == tableKey) {
			callback(value);
		}
	});
}
/** 返回一个不重复的字符串 */
function doUniqueString(str) {
	if (GameUI.CustomUIConfig()._Record_UniqueString == undefined) {
		GameUI.CustomUIConfig()._Record_UniqueString = 0;
	}
	let result = "_" + Math.random().toString().substring(3, 3) + GameUI.CustomUIConfig()._Record_UniqueString + "_" + str;
	GameUI.CustomUIConfig()._Record_UniqueString++;
	return result;
}
/** 显示popup */
function showPopup(popupName, data) {
	const PopupID = data.PopupID ?? doUniqueString("Popup");
	GameUI.CustomUIConfig()._PopupPropsList[PopupID] = data;
	GameEvents.SendEventClientSide("client_side_event", { event_name: "show_popup", popupName: popupName, PopupID: PopupID });
	// GameEvents.SendEventClientSide("client_side_event", { event_name: "show_popup", event_data: JSON.stringify(Object.assign(data, { popupName: popupName, PopupID: PopupID })) });
	return PopupID;
}
/** 关闭popup */
function closePopup(PopupID, immediately) {
	GameEvents.SendEventClientSide("client_side_event", { event_name: "close_popup_fadeout", event_data: { PopupID } });
	if (immediately) {
		GameEvents.SendEventClientSide("client_side_event", { event_name: "close_popup", event_data: { PopupID } });
	} else {
		$.Schedule(0.2, () => {
			GameEvents.SendEventClientSide("client_side_event", { event_name: "close_popup", event_data: { PopupID } });
		});
	}
}
function ShowComfirmPopup(msg, OnConfirm) {
	const key = showPopup("Confrim", { msg: msg });
	const id = GameEvents.Subscribe("client_side_event", ({ event_name, event_data }) => {
		switch (event_name) {
			case "Popup_Confrim":
				if (event_data == key) {
					OnConfirm && OnConfirm();
					GameEvents.Unsubscribe(id);
				}
				break;
			default:
				break;
		}
	});
	return id;
}
/** 关闭popup组 */
function closePopupGroup(group) {
	GameEvents.SendEventClientSide("client_side_event", { event_name: "close_popup_fadeout", event_data: { group } });
	$.Schedule(0.2, () => {
		GameEvents.SendEventClientSide("client_side_event", { event_name: "close_popup", event_data: { group } });
	});
}
/** 显示popup_main */
function showPopupMain(popupName, data) {
	const PopupID = data.PopupID ?? doUniqueString("PopupMain");
	GameUI.CustomUIConfig()._PopupMainPropsList[PopupID] = data;
	GameEvents.SendEventClientSide("client_side_event", { event_name: "show_popup_main", popupName: popupName, PopupID: PopupID });
	return PopupID;
}
function switchPopupMain(popupName, data) {
	const PopupID = data.PopupID ?? doUniqueString("PopupMain");
	GameUI.CustomUIConfig()._PopupMainPropsList[PopupID] = data;
	GameEvents.SendEventClientSide("client_side_event", { event_name: "switch_popup_main", popupName: popupName, PopupID: PopupID });
	return PopupID;
}
/** 关闭popup_main */
function closePopupMain(PopupID) {
	GameEvents.SendEventClientSide("client_side_event", { event_name: "close_popup_main_fadeout", event_data: { PopupID } });
	$.Schedule(0.2, () => {
		GameEvents.SendEventClientSide("client_side_event", { event_name: "close_popup_main", event_data: { PopupID } });
	});
}
/** 关闭popup_main组 */
function closePopupMainGroup(group) {
	GameEvents.SendEventClientSide("client_side_event", { event_name: "close_popup_main_fadeout", event_data: { group } });
	$.Schedule(0.2, () => {
		GameEvents.SendEventClientSide("client_side_event", { event_name: "close_popup_main", event_data: { group } });
	});
}

/**
 * 显示自定义Tooltip
 * @param {Panel} 面板
 * @param {string} 名字
 */
function ShowCustomTooltip(panel, name, data) {
	let params = "";
	for (const key in data) {
		params += `${key}=${data[key]}&`;
	}
	params.substring(0, params.length - 1);
	$.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, name, "file://{resources}/layout/custom_game/" + name + ".xml", params);
}
/**
 * 隐藏自定义Tooltip
 * @param {Panel} 面板
 * @param {string} 名字
 */
function HideCustomTooltip(panel, name) {
	$.DispatchEvent("UIHideCustomLayoutTooltip", panel, name);
}

function useNetData(key, callback, playerID) {
	if (playerID == undefined) {
		playerID = -1;
	}
	if (GameUI.CustomUIConfig().NET_DATA_CACHE[key + playerID]) {
		callback(GameUI.CustomUIConfig().NET_DATA_CACHE[key + playerID]);
	} else {
		if (GameUI.CustomUIConfig().NET_DATA_STREAM_KEY[key + playerID] == undefined) {
			GameUI.CustomUIConfig().NET_DATA_STREAM_KEY[key + playerID] = [];
			// // 防止请求失败(重发请求)
			// let max = 3;
			// let interval = 10;
			// let counter = 0;
			// const id = doUniqueString(Players.GetLocalPlayer().toString() + "_" + Round(Game.GetGameTime()).toString());
			// function timer() {
			// 	if (counter < max && GameUI.CustomUIConfig().NET_DATA_CACHE[key + playerID] == undefined) {
			// 		counter++;
			// 		GameEvents.SendCustomEventToServer("request_net_data", { id, key, bindPlayerID: playerID });
			// 		$.Schedule(interval, timer);
			// 	}
			// };
			// timer();
			GameEvents.SendCustomEventToServer("request_net_data", { key, bindPlayerID: playerID });
			// } else {
			// 	GameUI.CustomUIConfig().NET_DATA_STREAM_KEY[key + playerID].push(callback);
		}
	}
	return GameEvents.Subscribe("custom_net_data_changed_client", (data) => {
		if (key == data.key && data.PlayerID == playerID) {
			callback(GameUI.CustomUIConfig().NET_DATA_CACHE[data.key + data.PlayerID]);
		}
	});
}

function setClientGlobalData(key, value, override) {
	if (GameUI.CustomUIConfig().CLIENT_GLOBAL_DATA[key] == undefined) {
		GameUI.CustomUIConfig().CLIENT_GLOBAL_DATA[key] = {};
	}
	if (override) {
		GameUI.CustomUIConfig().CLIENT_GLOBAL_DATA[key] = value;
	} else {
		GameUI.CustomUIConfig().CLIENT_GLOBAL_DATA[key] = TableOverride(GameUI.CustomUIConfig().CLIENT_GLOBAL_DATA[key], value);
	}
	GameEvents.SendEventClientSide("client_global_data_changed", { key: key });
}
function getClientGlobalData(key) {
	return GameUI.CustomUIConfig().CLIENT_GLOBAL_DATA[key];
}
function useClientGlobalData(key, callback) {
	if (GameUI.CustomUIConfig().CLIENT_GLOBAL_DATA[key]) {
		callback(GameUI.CustomUIConfig().CLIENT_GLOBAL_DATA[key]);
	}
	return GameEvents.Subscribe("client_global_data_changed", (data) => {
		if (key == data.key) {
			callback(GameUI.CustomUIConfig().CLIENT_GLOBAL_DATA[key]);
		}
	});
}
/** 网表，因为是json所以会保留array */
function useSyncDataKey(tableName, tableKey, callback, playerID) {
	if (playerID == -1) {
		for (let id = 0; id < 16; id++) {
			const net = CustomNetTables.GetTableValue(tableName, tableKey + id);
			if (net != undefined) {
				if (net.data == "") {
					callback(undefined, id);
				} else {
					const data = JSON.parseSafe(net.data);
					callback(data, id);
				}
			}
		}
		return CustomNetTables.SubscribeNetTableListener(tableName, (_, key, value) => {
			if (new RegExp(`^${tableKey}\\d+$`).test(key)) {
				const id = finiteNumber(Number(key.match(/\d+$/)?.[0]), -1);
				if (value.data == "") {
					callback(undefined, id);
				} else {
					const data = JSON.parseSafe(value.data);
					callback(data, id);
				}
			}
		});
	} else if (typeof playerID == "number") {
		const realKey = tableKey + playerID.toString();
		const net = CustomNetTables.GetTableValue(tableName, realKey);
		if (net != undefined) {
			if (net.data == "") {
				callback(undefined);
			} else {
				const data = JSON.parseSafe(net.data);
				callback(data);
			}
		}
		return CustomNetTables.SubscribeNetTableListener(tableName, (_, key, value) => {
			if (key == realKey) {
				if (value.data == "") {
					callback(undefined);
				} else {
					const data = JSON.parseSafe(value.data);
					callback(data);
				}
			}
		});
	} else {
		const net = CustomNetTables.GetTableValue(tableName, tableKey);
		if (net != undefined) {
			if (net.data == "") {
				callback(undefined);
			} else {
				const data = JSON.parseSafe(net.data);
				callback(data);
			}
		}
		return CustomNetTables.SubscribeNetTableListener(tableName, (_, key, value) => {
			if (key == tableKey) {
				if (value.data == "") {
					callback(undefined);
				} else {
					const data = JSON.parseSafe(value.data);
					callback(data);
				}
			}
		});
	}
}
/** 网表，因为是json所以会保留array */
function ListenSyncDataKey(tableName, tableKey, callback, playerID) {
	if (playerID == -1) {
		return CustomNetTables.SubscribeNetTableListener(tableName, (_, key, value) => {
			if (new RegExp(`^${tableKey}\\d+$`).test(key)) {
				const data = JSON.parseSafe(value.data);
				const id = finiteNumber(Number(key.match(/\d+$/)?.[0]), -1);
				callback(data, id);
			}
		});
	} else if (typeof playerID == "number") {
		const realKey = tableKey + playerID.toString();
		return CustomNetTables.SubscribeNetTableListener(tableName, (_, key, value) => {
			if (key == realKey) {
				const data = JSON.parseSafe(value.data);
				callback(data);
			}
		});
	} else {
		return CustomNetTables.SubscribeNetTableListener(tableName, (_, key, value) => {
			if (key == tableKey) {
				const data = JSON.parseSafe(value.data);
				callback(data);
			}
		});
	}
}
function getSyncDataKey(tableName, tableKey, playerID) {
	if (playerID == -1) {
		const result = {};
		for (let id = 0; id < 16; id++) {
			const realKey = tableKey + id;
			const net = CustomNetTables.GetTableValue(tableName, realKey);
			if (net != undefined) {
				const data = JSON.parseSafe(net.data);
				result[id] = data;
			}
		}
		return result;
	} else if (typeof playerID == "number") {
		const realKey = tableKey + playerID.toString();
		const net = CustomNetTables.GetTableValue(tableName, realKey);
		if (net != undefined) {
			const data = JSON.parseSafe(net.data);
			return data;
		}
	} else {
		const net = CustomNetTables.GetTableValue(tableName, tableKey);
		if (net != undefined) {
			const data = JSON.parseSafe(net.data);
			return data;
		}
	}
}


/**
 * 数据表覆盖，会检测特殊字符串"DELETE"，将其设置为空值
 * @param mainTable 被覆盖表
 * @param overrideTable 覆盖表
 * @returns 新表
 */
function TableOverride(mainTable, overrideTable) {
	if (mainTable == undefined) {
		return overrideTable;
	}
	if (overrideTable == undefined || typeof overrideTable != "object") {
		return mainTable;
	}
	let v;
	if (Array.isArray(overrideTable)) {
		if (Array.isArray(mainTable)) {
			mainTable = [...new Set(mainTable.concat(overrideTable))];
		} else {
			mainTable = overrideTable;
		}
	} else {
		for (const k in overrideTable) {
			v = overrideTable[k];
			if (typeof v == "object") {
				mainTable[k] = TableOverride(mainTable[k], v);
			} else {
				if (v == "DELETE") {
					delete mainTable[k];
				} else {
					mainTable[k] = v;
				}
			}
		}
	}
	return mainTable;
}

function getNetDataCache(key, playerID) {
	if (playerID == undefined) {
		playerID = -1;
	}
	return GameUI.CustomUIConfig().NET_DATA_CACHE[key + playerID];
}

/** 新的请求 */
//====================== new Request ======================
const REQUEST_RUNNING_ID_LIST = {};
const REQUEST_STREAM = {};
const REQUEST_STREAM_STEP = {};
function serverRequest(eventName, data, callback, timeout) {
	const id = doUniqueString("request");
	GameEvents.SendCustomEventToServer("server_request", {
		event: eventName,
		data: JSON.stringify(data),
		queueIndex: id,
	});

	const listenID = GameEvents.Subscribe("server_request_res", (data) => {
		if (REQUEST_RUNNING_ID_LIST[listenID] == undefined) return;
		if (id == data.queueIndex) {
			if (REQUEST_STREAM[data.queueIndex] == undefined) {
				REQUEST_STREAM[data.queueIndex] = [];
				REQUEST_STREAM_STEP[data.queueIndex] = 0;
			}
			if (data.done == 1) {
				REQUEST_STREAM_STEP[data.queueIndex] = data.step + 1;
			}
			REQUEST_STREAM[data.queueIndex][data.step] = data.data;

			if (REQUEST_STREAM[data.queueIndex].length == REQUEST_STREAM_STEP[data.queueIndex] && REQUEST_STREAM_STEP[data.queueIndex] > 0) {
				// var msg = JSON.parse(REQUEST_STREAM[data.queueIndex].join(''));
				var msg = Transform(JSON.parse(REQUEST_STREAM[data.queueIndex].join('')), "server_request");
				callback(msg);
				cancelRequest(listenID);
			}
		}
	});

	REQUEST_RUNNING_ID_LIST[listenID] = id;
	// 超时处理
	timeout = timeout || REQUEST_TIME_OUT;
	$.Schedule(timeout, () => {
		cancelRequest(listenID);
	});
	return listenID;
}

// const CLIENT_REQUEST_CALLBACK_INDEX = {};
// function clientRequest(event, data, callback) {
// 	const id = doUniqueString("client_request");
// 	GameEvents.SendEventClientSide("client_request_event", {
// 		event: event,
// 		data: JSON.stringify(data),
// 		queueIndex: id,
// 		quickReturn: 0,
// 	});
// 	if (typeof callback === "function") {
// 		CLIENT_REQUEST_CALLBACK_INDEX[id] = callback;
// 		// CLIENT_REQUEST_CALLBACK_INDEX[id] = func;
// 	}
// 	return id;
// }

// Game.AddCommand("client_request_event_result", (_, queueIndex, result) => {
// 	let id = queueIndex ?? "";
// 	let callback = CLIENT_REQUEST_CALLBACK_INDEX[id];
// 	delete CLIENT_REQUEST_CALLBACK_INDEX[id];
// 	if (!callback) return;
// 	callback(JSON.parse(result));
// }, "", 1 << 26);

function clientRequestQuickReturn(event, data) {
	let t = CustomNetTables.GetTableValue("common", "client_ability");
	if (t) {
		let iAbilityEntIndex = t._;
		if (typeof iAbilityEntIndex == "number" && Entities.IsValidEntity(iAbilityEntIndex)) {
			GameEvents.SendEventClientSide("client_request_event", {
				event: event,
				data: JSON.stringify(data),
				quickReturn: 1,
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
	// let t = CustomNetTables.GetTableValue("common", "dummys");
	// if (t) {
	// 	let iUnitEntIndex = t.PLAYER_DATA_DUMMY;
	// 	if (typeof iUnitEntIndex == "number" && Entities.IsValidEntity(iUnitEntIndex)) {
	// 		GameEvents.SendEventClientSide("client_request_event", {
	// 			event: event,
	// 			data: JSON.stringify(data),
	// 			quickReturn: 1,
	// 		});
	// 		let iBuffIndex = Entities.FindBuffByName(iUnitEntIndex, "modifier_player_data");
	// 		if (iBuffIndex != -1) {
	// 			let sValue = Buffs.GetTexture(iUnitEntIndex, iBuffIndex);
	// 			let s;
	// 			try {
	// 				s = JSON.parse(sValue);
	// 			} catch (error) { }
	// 			return s;
	// 		}
	// 	}
	// }
}

function cancelRequest(id) {
	if (REQUEST_RUNNING_ID_LIST[id] != undefined) {
		const queueIndex = REQUEST_RUNNING_ID_LIST[id];
		delete REQUEST_RUNNING_ID_LIST[id];
		GameEvents.Unsubscribe(id);
		if (REQUEST_STREAM[queueIndex] != undefined) {
			delete REQUEST_STREAM[queueIndex];
		}
		if (REQUEST_STREAM_STEP[queueIndex] != undefined) {
			delete REQUEST_STREAM_STEP[queueIndex];
		}
	}
	//  else if (CLIENT_REQUEST_CALLBACK_INDEX[id] != undefined) {
	// 	delete CLIENT_REQUEST_CALLBACK_INDEX[id];
	// }
}

function callAction(actionName, params) {
	GameEvents.SendCustomEventToServer("call_action", {
		actionName,
		params
	});
}

function GetStoreItemRarity(iItemID, iExpireType, iSpecial) {
	let sItemID = String(iItemID);
	// let iType = finiteNumber(Number(sItemID.substring(0, 3)), 0);

	if (sItemID.length > 7) {
		if (typeof iExpireType != "number") {
			iExpireType = Number(sItemID.substring(sItemID.length - 2, sItemID.length));
		}
		sItemID = sItemID.substring(0, 7);
	}

	let iRarity = finiteNumber(Number(sItemID.substring(3, 4)), 0);

	if (typeof iExpireType == "number" && iExpireType > 0) {
		iRarity = math.max(iRarity - 1, 0);
	}

	return iRarity;
}

/** steam短id转长id */
function steam_3_64(steamid_3) {
	return "7656" + (parseFloat(steamid_3) + 1197960265728);
}

/** steam长id转短id */
function steam_64_3(steamid_64) {
	return "" + (parseFloat((steamid_64 + "").substr(4)) - 1197960265728);
}

/** 计算2个时间戳相差日期 */
function dateDiff(ts1, ts2) {
	const date1 = new Date(ts1 * 1000);
	const date2 = new Date(ts2 * 1000);
	// 将日期转换为不包含时间的日期
	const date1WithoutTime = new Date(date1.getFullYear(), date1.getMonth(), date1.getDate());
	const date2WithoutTime = new Date(date2.getFullYear(), date2.getMonth(), date2.getDate());
	// 计算天数差
	const diffTime = date2WithoutTime.getTime() - date1WithoutTime.getTime();
	const diffDays = Math.ceil(diffTime / (1000 * 3600 * 24));
	return diffDays;
}

/** 获取当前日期的0点时间戳 */
function getMidnightTimeStampWithOffset(daysOffset = 0) {
	const currentDate = new Date();
	currentDate.setDate(currentDate.getDate() + daysOffset);
	currentDate.setHours(0, 0, 0, 0);
	return Math.floor(currentDate.getTime() / 1000);
}

function GeneratePeriod(text) {
	if (typeof text != "string") return "";
	if (text.endsWith("。") || text.endsWith(".")) {
		return text;
	} else {
		return text + ($.Language().toLowerCase() == "schinese" ? "。" : ".");
	}
}

function removeHtmlTags(text) {
	return text.replace(/<.*?>/g, '');
}

function GetUnitStates(iUnitEntindex) {
	if (GameUI.CustomUIConfig()._UNIT_STATES_DATA[iUnitEntindex] == undefined) {
		let unitData = clientRequestQuickReturn("get_unit_stats_data", { unit: iUnitEntindex });
		GameUI.CustomUIConfig()._UNIT_STATES_DATA[iUnitEntindex] = unitData;
	}
	return GameUI.CustomUIConfig()._UNIT_STATES_DATA[iUnitEntindex];
}

function GetLocalization(text, defaultText, ...args) {
	let localizedText = $.Localize(text, ...args);
	if (defaultText != undefined && localizedText == text) {
		localizedText = defaultText;
	}
	return localizedText;
}