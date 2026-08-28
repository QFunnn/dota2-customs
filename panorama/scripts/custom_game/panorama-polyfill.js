--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


!function(){"use strict";function e(e,...t){if("string"!=typeof e)return[e,...t].map((e=>n(e))).join(" ");let o=String(e).replace(/%[sdj%]/g,(e=>{if("%%"===e)return"%";if(0===t.length)return e;switch(e){case"%s":return String(t.shift());case"%d":return String(Number(t.shift()));case"%j":try{return JSON.stringify(t.shift())}catch{return"[Circular]"}default:return e}}));for(const e of t)o+="object"!=typeof e||null===e?` ${e}`:` ${n(e)}`;return o}function n(e,o,r=""){let i="";if("string"==typeof e)i=`"${e}"`;else if("number"==typeof e||"boolean"==typeof e)i=`${e}`;else if("function"==typeof e)i=function(e){if("function"!=typeof e)return!1;const n=Object.getOwnPropertyDescriptor(e,"prototype");return!!n&&!n.writable}(e)?`[class ${e.name}]`:`[function ${e.name}]`;else if("symbol"==typeof e)i=e.toString();else if(void 0===e)i="undefined";else if("bigint"==typeof e)i=`[bigint ${e.toString()}]`;else if("object"==typeof e)if(null===e)i="null";else if(Array.isArray(e)){let t=[];for(const i of e)t.push(r+n(i,o,o?r+"    ":r));o?(i+="[\n",i+=t.map((e=>"    "+e)).join(",\n"),i+="\n"+r+"]"):i=`[ ${t.join(", ")} ]`}else{let s=[],c="";if(e instanceof Map){c="[Map]";for(const[t,i]of e.entries()){let e="";"object"==typeof t?e=Array.isArray(t)?"[Array]":"[Object]":t.toString&&(e=t.toString()),s.push(`${r}${e}: ${n(i,o,o?r+"    ":r)}`)}}else if(e instanceof Set){c="[Set]";for(const t of e.values())s.push(`${r}${n(t,o,o?r+"    ":r)}`)}else{const i=t(e);for(const[t,c]of Object.entries(e))"style"===t&&i?s.push(`${r}${t}: [VCSSStyleDeclaration]`):s.push(`${r}${t}: ${n(c,o,o?r+"    ":r)}`)}o?(i+=c+"{\n",i+=s.map((e=>"    "+e)).join(",\n"),i+="\n"+r+"}"):i=c+`{ ${s.join(", ")} }`}return i}const t=e=>"paneltype"in e&&"rememberchildfocus"in e&&"SetPanelEvent"in e;function o(e){for(const n of e.split("\n"))if(n.length>2047){const e="... (line have been trimmed because of a length limit)";$.Warning(`${n.slice(0,2047-e.length)}${e}`)}else $.Msg(n)}function r(...n){$.Warning(e(...n))}const i=r;function s(...n){o(e(...n))}const c=s,l=s,f=new Map;const u={logx:function(...e){o(function(e,...t){if("string"!=typeof e)return[e,...t].map((e=>n(e,!0))).join(" ");let o=String(e).replace(/%[sdj%]/g,(e=>{if("%%"===e)return"%";if(0===t.length)return e;switch(e){case"%s":return String(t.unshift());case"%d":return String(Number(t.unshift()));case"%j":try{return JSON.stringify(t.unshift())}catch{return"[Circular]"}default:return e}}));for(const e of t)o+="object"!=typeof e||null===e?` ${e}`:` ${n(e)}`;return o}(...e))},assert:function(e,n="console.assert",...t){e||r(new Error(`Assertion failed: ${n}`),...t)},warn:i,error:r,log:s,debug:c,info:l,time:function(e="default"){e=`${e}`,f.has(e)?i(`Timer '${e}' already exists`):f.set(e,Date.now())},timeEnd:function(e="default"){e=`${e}`;const n=f.get(e);null!=n?(f.delete(e),o(`${e}: ${Date.now()-n}ms`)):i(`Timer '${e} does not exist'`)},trace:function n(t="",...r){const i={message:e(t,...r),name:"Trace",stack:""};Error.captureStackTrace(i,n),o(e(i.stack))},clear:function(){},dir:function(){throw new Error("console.dir is not implemented")},dirxml:function(){throw new Error("console.dirxml is not implemented")},table:function(){throw new Error("console.table is not implemented")},count:function(){throw new Error("console.count is not implemented")},countReset:function(){throw new Error("console.countReset is not implemented")},group:function(){throw new Error("console.group is not implemented")},groupCollapsed:function(){throw new Error("console.groupCollapsed is not implemented")},groupEnd:function(){throw new Error("console.groupEnd is not implemented")},profile:function(){throw new Error("console.profile is not implemented")},profileEnd:function(){throw new Error("console.profileEnd is not implemented")},timeStamp:function(){throw new Error("console.timeStamp is not implemented")}};globalThis.console=u}();


!function(){"use strict";const e=new Map;let l=-1e5;const t=(e,l=0,...t)=>$.Schedule(l/1e3,(()=>e(...t)));function c(t,c=0,...a){c/=1e3,l-=1;const s=l,n=()=>{e.set(s,$.Schedule(c,n)),t(...a)};return e.set(s,$.Schedule(c,n)),s}const a=(e,...l)=>$.Schedule(0,(()=>e(...l)));function s(l){if("number"==typeof l)try{l<-1e5?e.has(l)&&($.CancelScheduled(e.get(l)),e.delete(l)):$.CancelScheduled(l)}catch{}}globalThis.setInterval=c,globalThis.clearInterval=s,globalThis.setTimeout=t,globalThis.clearTimeout=s,globalThis.setImmediate=a,globalThis.clearImmediate=s}();


/////////////////常量/////////////////
let dateNow = Math.floor(Date.now() / 1000);
var T11LinkageEnable = false;
var T12LinkageEnable = false;
var C1LinkageEnable = true;
var loadingScreenSeason = 4; // 3 | 4 | 5 | 6 | 7 | 8 | 9
var PayType;
(function (PayType) {
	PayType[(PayType['MONEY'] = 0)] = 'MONEY';
	PayType[(PayType['MOON'] = 1000001)] = 'MOON';
	PayType[(PayType['STAR'] = 1000002)] = 'STAR';
	PayType[(PayType['SHARD'] = 1000003)] = 'SHARD';
})(PayType || (PayType = {}));

var GreevilStage;
(function (GreevilStage) {
	GreevilStage[(GreevilStage['EGG'] = 1)] = 'EGG';
	GreevilStage[(GreevilStage['GREEVIL'] = 2)] = 'GREEVIL';
})(GreevilStage || (GreevilStage = {}));

var PlayerCameraType;
(function (PlayerCameraType) {
	PlayerCameraType[(PlayerCameraType['NORMAL'] = 0)] = 'NORMAL';
	PlayerCameraType[(PlayerCameraType['PUBLIC'] = 1)] = 'PUBLIC';
})(PlayerCameraType || (PlayerCameraType = {}));

var OrnamentType = {
	/** 英雄皮肤 */
	HERO_SKIN: 10,
	/** 信使皮肤 */
	COURIER_SKIN: 20,
	/** 信使特效-周身 */
	COURIER_AMBIENT: 21,
	/** 信使特效-背部 */
	COURIER_BACK: 22,
	/** 信使特效-伤害 */
	COURIER_DAMAGE: 23,
	/** 信使特效-足迹 */
	COURIER_PATH: 24,
	/** 称号 */
	COURIER_TITLE: 25,
	/** 战场模型 */
	MAP: 30,
	/** 兔女郎 */
	BUNNY_GIRL: 31,
	/** 战斗特效-传送 */
	TELEPORT: 41,
	/** 战斗特效-击杀 */
	KILL: 42,
	/** 战斗特效-击杀语音 */
	KILL_VOICE: 43,
	/** 战斗特效-连胜播报 */
	BROADCAST: 44,
	/** 战斗-守卫皮肤 */
	WISP_SKIN: 45,
	/** 战斗-圣光特效 */
	HOLY_LIGHT: 46,
	/** 互动表情 */
	EMOJI: 50,
	/** 英雄互动表情 */
	HERO_EMOJI: 51,
	/** 互动道具 */
	ITEM: 60,
	/** 账号皮肤-头像 */
	AVATAR: 70,
	/** 账号皮肤-头像框 */
	AVATAR_BORDER: 71,
	/** 账号皮肤-名片背景 */
	AVATAR_BACKGROUND: 72,
	/** 账号皮肤-名片装饰 */
	AVATAR_DECORATION: 73,
	/** 界面皮肤 */
	HUD_SKIN: 74,
	/** 勋章 */
	MEDAL: 75,
	/** 名称装饰 */
	NAME_DECORATION: 76,
	/** 消耗品 */
	CONSUMABLE: 99,
};

var CosmeticSlot = OrnamentType;

var CosmeticRarity = {
	DEFAULT: 0,
	NORMAL: 1, //普通
	RARE: 2, //勇者
	SUPER: 3, //史诗
	ULTIMATE: 4, //传说
};

var COSMETIC_MARK = {
	default: 0,
	battlePass: 1,
	linkActivity: 2,
	nekoBox: 3,
	springFestival_2024: 4,
	celebration_2024: 5,
};

/////////////////////////////

/** 获取 AbilityUpgradeMechanics 说明 */
function getAbilityUpgradeMechanicsDescriptionByID(id, level = 1, entIndex, onlyShowNowLevel = false) {
	const abilityKV = GameUI.CustomUIConfig().AbilityUpgradesMechenicsKv[id];
	if (!(abilityKV && abilityKV.description)) {
		return 'EORROR';
	}
	let str = $.Localize('#' + abilityKV.description);
	str = replaceInfo(str);
	str = replaceKeyword(str);
	str = replaceAbility(str);
	str = replaceBuffEnum(str);
	str = replaceAbilityValues(str);
	str = getKeyValueDescription(abilityKV?.AbilityValues ?? {}, str, {
		entIndex,
		level,
		onlyShowNowLevel: onlyShowNowLevel,
	});
	return str;
}
/** 获取 AbilityUpgradeMechanics 说明 */
function getAbilityUpgradeMechanicsDescription(description, AbilityValues, level = 1, entIndex, onlyShowNowLevel = false) {
	let str = $.Localize('#' + description);
	str = replaceInfo(str);
	str = replaceKeyword(str);
	str = replaceAbility(str);
	str = replaceBuffEnum(str);
	str = replaceAbilityValues(str);
	str = getKeyValueDescription(AbilityValues ?? {}, str, {
		entIndex,
		level,
		onlyShowNowLevel: onlyShowNowLevel,
	});
	return str;
}

/** 获取技能说明，会将{Info:xxx}格式转化成info说明 */
function getAbilityDescription(abilityName, level = 1, entIndex, onlyShowNowLevel = false) {
	const abilityKV = GameUI.CustomUIConfig().AbilitiesKv[abilityName];
	let str = $.Localize('#DOTA_Tooltip_ability_' + abilityName + '_description');
	str = replaceInfo(str);
	str = replaceKeyword(str);
	str = replaceAbility(str);
	str = replaceBuffEnum(str);
	str = replaceAbilityValues(str);
	str = getKeyValueDescription(abilityKV?.AbilityValues ?? {}, str, {
		entIndex,
		level,
		onlyShowNowLevel: onlyShowNowLevel,
	});
	return str;
}

/** 获取天赋说明，会将{Info:xxx}格式转化成info说明 */
function getHeroTalentDescription(talentName, entIndex) {
	const abilityKV = GameUI.CustomUIConfig().HeroTalentKv[talentName];
	let str = $.Localize('#DOTA_Tooltip_ability_' + talentName + '_description');
	str = replaceInfo(str);
	str = replaceKeyword(str);
	str = replaceBuffEnum(str);
	str = getKeyValueDescription(abilityKV?.AbilityValues ?? {}, str, {
		entIndex,
		level: 1,
		// onlyShowNowLevel: onlyShowNowLevel,
	});
	return str;
}

/** 获取流派技能说明 */
function getSectDescription(abilityUpgradeID, level, onlyShowNowLevel = true, playerID) {
	const abilityKV = GameUI.CustomUIConfig().AbilityUpgradesKv[abilityUpgradeID];
	let str = $.Localize('#DOTA_Tooltip_ability_mechanics_' + abilityUpgradeID + '_description');
	str = replaceAll(str);
	str = getKeyValueDescription(abilityKV?.AbilityValues ?? {}, str, {
		level,
		onlyShowNowLevel: onlyShowNowLevel,
		abilityUpgradeID,
		playerID,
	});
	return str;
}
/** 获取物品技能说明 */
function getItemDescription(abilityName, entIndex) {
	const abilityKV = GameUI.CustomUIConfig().ItemsKv[abilityName];
	let str = $.Localize('#DOTA_Tooltip_ability_' + abilityName + '_description');
	str = replaceInfo(str);
	str = replaceKeyword(str);
	str = replaceBuffEnum(str);
	str = getKeyValueDescription(abilityKV?.AbilityValues ?? {}, str, {
		entIndex,
		level: 1,
	});
	if ('#DOTA_Tooltip_ability_' + abilityName + '_description' == str) {
		str = '';
	}
	return str;
}

/** 获取地域的说明，会将{Info:xxx}格式转化成info说明 */
function getCityDescription(cityName, level = 1, entIndex, onlyShowNowLevel = false) {
	const abilityKV = GameUI.CustomUIConfig().CityEffectKv[cityName];
	let str = $.Localize('#DOTA_Tooltip_ability_' + cityName + '_description');
	str = replaceInfo(str);
	str = replaceKeyword(str);
	str = replaceBuffEnum(str);
	str = getKeyValueDescription(abilityKV?.AbilityValues ?? {}, str, {
		entIndex,
		level,
		onlyShowNowLevel: onlyShowNowLevel,
	});
	return str;
}

/** 获取效果的说明，会将{Info:xxx}格式转化成info说明 */
function getCardDescription(cardName, level = 1, entIndex, onlyShowNowLevel = false) {
	let abilityKV = GameUI.CustomUIConfig().CardEffectKv[cardName];
	if (abilityKV == undefined) {
		abilityKV = GameUI.CustomUIConfig().TeamCardKv[cardName];
	}
	let str = $.Localize('#DOTA_Tooltip_ability_' + cardName + '_description');
	str = replaceAll(str);
	str = getKeyValueDescription(abilityKV?.AbilityValues ?? {}, str, {
		entIndex,
		level,
		onlyShowNowLevel: onlyShowNowLevel,
	});
	if (typeof abilityKV.Limit == 'number' && abilityKV.Limit > 0) {
		str += `<font color='#ff7272'>(${$.Localize('#LimitCount').replace('${count}', `${abilityKV.Limit}`)})</font>`;
	}
	return str;
}

/** 获取物品属性文本 */
function getItemArrtibute(itemName) {
	const itemKV = GameUI.CustomUIConfig().ItemsKv[itemName];

	const AbilityValues = itemKV.AbilityValues ?? {};
	let aValueNames = Object.keys(AbilityValues);
	let sAttributes = aValueNames
		.filter((sValueName) => {
			let sVariableLocalize = $.Localize('#dota_tooltip_item_variable_' + sValueName);
			if (sVariableLocalize != '#dota_tooltip_item_variable_' + sValueName) {
				return sValueName;
			}
		})
		.map((sValueName) => {
			const value = AbilityValues[sValueName];
			let localize = $.Localize('#dota_tooltip_item_variable_' + sValueName);
			localize = replaceInfo(localize);
			const bHasPercentSign = localize.search(/%/g) == 0;
			let name = localize.substring(bHasPercentSign ? 2 : 1, localize.length);
			if (value < 0) {
				name = "<font color='#e03f2f'>" + name + '</font>';
			}
			return (value >= 0 ? '+' : '-') + " <span class='GameplayValues GameplayVariable'>" + Math.abs(value) + (bHasPercentSign ? '%' : '') + '</span> ' + name;
		})
		.join('<br>');
	return sAttributes;
}

/** 获取自定义技能说明，会将{Info:xxx}格式转化成info说明 */
function getCustomAbilityDescription(abilityName, level = 1, entIndex, onlyShowNowLevel = false) {
	const abilityKV = GameUI.CustomUIConfig().CustomAbilitiesKv[abilityName];
	let str = $.Localize('#DOTA_Tooltip_ability_' + abilityName + '_description');
	str = replaceInfo(str);
	str = replaceKeyword(str);
	str = replaceBuffEnum(str);
	str = getKeyValueDescription(abilityKV?.AbilityValues ?? {}, str, {
		entIndex,
		level,
		onlyShowNowLevel: onlyShowNowLevel,
	});
	return str;
}

/** 替换所有格式 */
function replaceAll(str) {
	return replaceAbilityValues(replaceAbility(replaceInfo(replaceKeyword(replaceBuffEnum(str)))));
}

/** {Info:xxx}格式转化成info说明 */
function replaceInfo(sStr) {
	sStr = sStr.replace(/{Info:(\w+?)}/g, (a, b, c) => {
		return $.Localize('#' + b);
		// + "<img class='BuffInfo'/>";
	});
	return sStr;
}

/** 将{KeyWord:xxx}格式转换成特定颜色和图标，本地化格式为KeyWord_xxx */
function replaceKeyword(sStr) {
	const colorMap = {
		/** 攻击 */
		Attack: '#DCC9FF',
		Attack_Russian_1: '#DCC9FF',
		Attack_Russian_2: '#DCC9FF',
		Attack_Russian_3: '#DCC9FF',
		Attack_Russian_4: '#DCC9FF',
		Attack_Russian_5: '#DCC9FF',
		/** 回复 */
		Regen: '#DAFF69',
		Regen_Russian_1: '#DAFF69',
		Regen_Russian_2: '#DAFF69',
		/** 暴击 */
		Crit: '#FFC28B',
		Crit_Russian_1: '#FFC28B',
		Crit_Russian_2: '#FFC28B',
		Crit_Russian_3: '#FFC28B',
		Crit_Russian_4: '#FFC28B',
		Crit_Russian_5: '#FFC28B',
		Crit_Russian_6: '#FFC28B',
		/** 中毒 */
		Poison: '#59FF59',
		PermanentPoison: '#59FF59',
		Poison_Russian_1: '#59FF59',
		Poison_Russian_2: '#59FF59',
		Poison_Russian_3: '#59FF59',
		Poison_Russian_4: '#59FF59',
		Poison_Russian_5: '#59FF59',
		Poison_Russian_6: '#59FF59',
		/** 冰冻 */
		Ice: '#70FFD9',
		PermanentIce: '#70FFD9',
		Ice_Russian_1: '#70FFD9',
		Ice_Russian_2: '#70FFD9',
		Ice_Russian_3: '#70FFD9',
		Ice_Russian_4: '#70FFD9',
		Ice_Russian_5: '#70FFD9',
		Ice_Russian_6: '#70FFD9',
		/** 怒火 */
		Fury: '#FF6666',
		PermanentFury: '#FF6666',
		Fury_Russian_1: '#FF6666',
		Fury_Russian_2: '#FF6666',
		Fury_Russian_3: '#FF6666',
		Fury_Russian_4: '#FF6666',
		Fury_Russian_5: '#FF6666',
		Fury_Russian_6: '#FF6666',
		/** 易伤 */
		Injury: '#E4BAFF',
		PermanentInjury: '#E4BAFF',
		Injury_Russian_1: '#E4BAFF',
		Injury_Russian_2: '#E4BAFF',
		Injury_Russian_3: '#E4BAFF',
		Injury_Russian_4: '#E4BAFF',
		Injury_Russian_5: '#E4BAFF',
		Injury_Russian_6: '#E4BAFF',
		/** 护盾 */
		Shield: '#FFCE66',
		PermanentShield: '#FFCE66',
		StrongShield: '#FFCE66',
		Shield_Russian_1: '#FFCE66',
		Shield_Russian_2: '#FFCE66',
		Shield_Russian_3: '#FFCE66',
		Shield_Russian_4: '#FFCE66',
		Shield_Russian_5: '#FFCE66',
		Shield_Russian_6: '#FFCE66',
		/** 闪避 */
		Evade: '#E4BAFF',
		Evade_Russian_1: '#E4BAFF',
		Evade_Russian_2: '#E4BAFF',
		Evade_Russian_3: '#E4BAFF',
		Evade_Russian_4: '#E4BAFF',
		Evade_Russian_5: '#E4BAFF',
		Evade_Russian_6: '#E4BAFF',
		/** 魔法值 */
		Mana: '#B7E0FF',
		Mana_Russian_1: '#B7E0FF',
		Mana_Russian_2: '#B7E0FF',
		Mana_Russian_3: '#B7E0FF',
		Mana_Russian_4: '#B7E0FF',
		Mana_Russian_5: '#B7E0FF',
		Mana_Russian_6: '#B7E0FF',
		/** 大招 */
		Ulti: '#B7E0FF',
		Ulti_Russian_1: '#B7E0FF',
		Ulti_Russian_2: '#B7E0FF',
		Ulti_Russian_3: '#B7E0FF',
		Ulti_Russian_4: '#B7E0FF',
		Ulti_Russian_5: '#B7E0FF',
		Ulti_Russian_6: '#B7E0FF',
		/** 生命值 */
		Health: '#FFFF9C',
		Health_Russian_1: '#FFFF9C',
		Health_Russian_2: '#FFFF9C',
		Health_Russian_3: '#FFFF9C',
		Health_Russian_4: '#FFFF9C',
		Health_Russian_5: '#FFFF9C',
		Health_Russian_6: '#FFFF9C',
		/** 精灵 */
		Wisp: '#FF87C3',
		Wisp_Russian_1: '#FF87C3',
		Wisp_Russian_2: '#FF87C3',
		Wisp_Russian_3: '#FF87C3',
		Wisp_Russian_4: '#FF87C3',
		Wisp_Russian_5: '#FF87C3',
		Wisp_Russian_6: '#FF87C3',
		Wisp_Russian_7: '#FF87C3',
		Wisp_Russian_8: '#FF87C3',
		Wisp_Russian_9: '#FF87C3',
		Wisp_Russian_10: '#FF87C3',
		Wisp_Russian_11: '#FF87C3',
		Wisp_Russian_12: '#FF87C3',
		/** 流失 */
		HpLoss: '#FFFF9C',
		HpLoss_Russian_1: '#FFFF9C',
		HpLoss_Russian_2: '#FFFF9C',
		HpLoss_Russian_3: '#FFFF9C',
		HpLoss_Russian_4: '#FFFF9C',
		HpLoss_Russian_5: '#FFFF9C',
		HpLoss_Russian_6: '#FFFF9C',
		/** 混沌 */
		Chaos: '#FFFF9C',
		ChaosPoint: '#b8b6e0',
		PermanentChaosPoint: '#9d97fd',
		Chaos_Russian_1: '#FFFF9C',
		Chaos_Russian_2: '#FFFF9C',
		Chaos_Russian_3: '#FFFF9C',
		Chaos_Russian_4: '#FFFF9C',
		Chaos_Russian_5: '#FFFF9C',
		Chaos_Russian_6: '#FFFF9C',
	};
	sStr = sStr.replace(/{KeyWord:(\w+?)}/g, (a, b, c) => {
		return `<font color="${colorMap[b]}">${$.Localize('#KeyWord_' + b)}</font>`;
	});
	return sStr;
}
/** 将{AbilityValues:${abilityName}:${keyvalue}}格式转换成特定颜色数值 */
function replaceAbilityValues(sStr) {
	sStr = sStr.replace(/{AbilityValues:(\w+?):(\w+?)}/g, (a, abilityName, keyvalue) => {
		const abilityKV = KeyValues.AbilitiesKv[abilityName];
		const value = abilityKV?.AbilityValues?.[keyvalue];
		if (value == undefined) return a;
		const v = GetAbilityValue(value, { level: 0 });
		return `<span class='GameplayValues GameplayVariable'>${v}</span>`;
	});
	return sStr;
}

/** 将{Ability:xxx}格式转换成特定颜色和图标，本地化格式为KeyWord_xxx */
function replaceAbility(sStr) {
	const colorMap = {
		/** 流派 */
		SECT: '#fdff70',
		/** 被动 */
		PASSIVE: '#96d3ae',
		/** 大招 */
		ULTI: '#e893ff',
		/** 无效 */
		NONE: '#3A3A3A',
	};
	sStr = sStr.replace(/{Ability:(\w+?)}/g, (a, b, c) => {
		if (KeyValues.AbilitiesKv[b]) {
			if (typeof KeyValues.AbilitiesKv[b]?.AbilityBehavior == 'string') {
				let type = KeyValues.AbilitiesKv[b].AbilityBehavior.indexOf('DOTA_ABILITY_BEHAVIOR_PASSIVE') != -1 ? 'ULTI' : 'PASSIVE';
				return `<font color="${colorMap[type]}">${$.Localize('#DOTA_Tooltip_ability_' + b)}</font>`;
			}
			return `<font color="${colorMap['NONE']}">${$.Localize('#DOTA_Tooltip_ability_' + b)}</font>`;
		} else if (KeyValues.AbilityUpgradesKv[b]) {
			return `<font color="${colorMap['SECT']}">${$.Localize('#DOTA_Tooltip_ability_mechanics_' + b)}</font>`;
		} else if (KeyValues.ItemsKv[b]) {
			return `<font color="${colorMap['SECT']}">${$.Localize('#DOTA_Tooltip_ability_' + b)}</font>`;
		}
		return b;
	});
	return sStr;
}
/** 将{Enum:xxx}格式替换成常量 */
function replaceBuffEnum(sStr) {
	const netEnum = CustomNetTables.GetTableValue('common', 'constant');
	if (netEnum) {
		sStr = sStr.replace(/{Enum:(\w+?)}(%?)/g, (a, b, c) => {
			return "<font color='white'>" + Float(netEnum.BUFF_VALUE[b]) + c + '</font>';
		});
	}
	sStr = replaceAbilityValues(sStr);
	return sStr;
}
/** TODO:与上面的合并 */
function replaceEnum(sStr) {
	const netEnum = CustomNetTables.GetTableValue('common', 'constant');
	if (netEnum) {
		sStr = sStr.replace(/\{Enum:(\w+?\.?\w+?)\}(%?)/g, (a, b, c) => {
			let [netKey, key] = b.split('.');
			if (key == undefined) {
				// @ts-ignore
				return "<font color='white'>" + Float(netEnum[String(netKey)] ?? 0) + c + '</font>';
			} else {
				// @ts-ignore
				return "<font color='white'>" + Float(netEnum[String(netKey)][String(key)] ?? 0) + c + '</font>';
			}
		});
	}
	return sStr;
}

/** wiki里用过 */
function replaceImage(sStr) {
	const netEnum = CustomNetTables.GetTableValue('common', 'constant');
	if (netEnum) {
		sStr = sStr.replace(/\{Image:(\w+?)\}/g, (a, b, c) => {
			return `<img class="${b}" />`;
		});
	}
	return sStr;
}

const addedValueFunctionMap = {
	_str: Entities.GetStrength,
	_agi: Entities.GetAgility,
	_int: Entities.GetIntellect,
	_all: Entities.GetAllStats,
	_attack_damage: Entities.GetAttackDamage,
	_attack_speed: Entities.GetAttackSpeedPercent,
	_health: Entities.GetCustomMaxHealth,
	_mana: Entities.GetMaxMana,
	_armor: Entities.GetArmor,
	_magical_armor: Entities.GetMagicalArmor,
	_move_speed: Entities.GetMoveSpeed,
	// _ulti: Entities.GetUltiPower,
};
/* 是否是加速模式 */
function isTurboMode() {
	return GetMapName() == 'turbo_map';
}
/* 是否是比赛模式 */
function isCompetitionMode() {
	return GetMapName() == 'tournament_map';
	// if (GetMapName() == 'tournament_map') {
	// 	const netData = CustomNetTables.GetTableValue('common', 'tournament_group_mode');
	// 	return netData == null || netData.enabled != true;
	// }
	// return false;
}
/* 是否是巅峰积分赛模式 */
function isKingsRankMode() {
	return GetMapName() == 'peak_arena';
}
/* 是否是休闲模式 */
function IsCasualMode() {
	return GetMapName() == 'casual_map';
}
/** 比赛服禁用天陨烬 */
function IsCompetitionBanRune() {
	return GetMapName() == 'tournament_map' && true;
}
/**
 * 获取指定玩家对流派技能 AbilityValue 的数值强化。
 *
 * 服务端会把缓存结果写入 ability_upgrades_result：
 * [special value type][ability ID][special value name][operator]。
 */
function getAbilityUpgradeSpecialValue(playerID, abilityUpgradeID, specialValueName) {
	if (playerID == undefined || playerID < 0 || abilityUpgradeID == undefined || specialValueName == undefined) {
		return {
			add: 0,
			mul: 0,
		};
	}

	const netData = CustomNetTables.GetTableValue('ability_upgrades_result', String(playerID));
	if (netData?.json == undefined) {
		return {
			add: 0,
			mul: 0,
		};
	}

	try {
		const cachedResult = JSON.parse(netData.json);
		const specialValueData = cachedResult?.[0]?.[abilityUpgradeID]?.[specialValueName];
		return {
			add: Number(specialValueData?.[0] ?? 0),
			mul: Number(specialValueData?.[1] ?? 0),
		};
	} catch (error) {
		return {
			add: 0,
			mul: 0,
		};
	}
}

function GetAbilityValue(valueData, params = {}, onlyValue = false) {
	if (valueData == undefined) {
		return 0;
	}
	let level = params.level;
	let entIndex = params.entIndex;
	let onlyShowNowLevel = params.onlyShowNowLevel;
	let hasPct = params.hasPct ?? false;
	let abilityUpgradeID = params.abilityUpgradeID;
	let playerID = params.playerID ?? Players.GetLocalPlayer();
	let pctSymbol = hasPct ? '%' : '';

	let baseValueString = '';
	let addedValueString = '';

	const ultiPower = valueData['_ulti'];
	const valueList = String(typeof valueData == 'object' ? (isTurboMode() ? valueData._turbo ?? valueData.value : valueData.value) : valueData).split(' ');
	const maxLevel = valueList.length - 1;
	const currentLevel = Math.min(maxLevel, Math.max(0, level - 1));
	{
		let _baseValue = [];
		let digitalNum = 1;
		let maxs = 0;
		if (onlyShowNowLevel) {
			let value = Number(valueList?.[currentLevel] ?? '0');
			let s = value.toString().split('.');
			if (s[1] && s[1].length > 0) {
				maxs = s[1].length;
			}
			_baseValue = [Number(valueList?.[currentLevel] ?? '0')];
		} else {
			_baseValue = valueList.map((v, index) => {
				let value = Number(v);
				let s = value.toString().split('.');
				if (s[1] && s[1].length > maxs) {
					maxs = s[1].length;
				}
				return value;
			});
		}
		if (maxs > 0) {
			for (let i = 0; i < maxs; i++) {
				digitalNum = digitalNum * 10;
			}
		}
		if (entIndex != undefined && entIndex > -1) {
			if (_baseValue.length > 0) {
				if (ultiPower && ultiPower > 0) {
					_baseValue = _baseValue.map((v, i) => {
						return Round(v * (1 + Entities.GetUltiPower(entIndex) * 0.01) * digitalNum) / digitalNum;
					});
				}
				// 加入单位属性的数值
				if (typeof valueData == 'object') {
					for (const key in valueData) {
						let addedValue = 0;
						const addedValueList = String(valueData[key]).split(' ');
						const maxLevel = addedValueList.length - 1;
						if (addedValueFunctionMap[key]) {
							addedValue += Round(addedValueFunctionMap[key](entIndex) * Number(addedValueList[Math.min(maxLevel, Math.max(0, level - 1))]) * digitalNum) / digitalNum;
						}

						const linkAbility = Entities.GetAbilityByName(entIndex, key);
						if (linkAbility != -1 && Abilities.GetLevel(linkAbility) > 0) {
							let linkKey = valueData[key];
							let type = 'add';
							let isFloat = linkKey[0] == 'f';
							if (isFloat) {
								linkKey = linkKey.replace('f', '');
							}
							if (linkKey[0] == '-') {
								type = 'sub';
								linkKey = linkKey.replace('-', '');
							} else if (linkKey[0] == '+') {
								type = 'add';
								linkKey = linkKey.replace('+', '');
							}
							let percent = linkKey[0] == '%';
							if (percent) {
								linkKey = linkKey.replace('%', '');
							}
							const kv = KeyValues.HeroTalentKv[key] ?? KeyValues.HeroShardKv[key];
							if (kv) {
								let = extraValue = GetAbilityValue(kv?.AbilityValues?.[linkKey], Object.assign(params, { onlyShowNowLevel: true }), true);
								_baseValue = _baseValue.map((value, i) => {
									if (percent) {
										if (type == 'sub') {
											addedValue -= value * extraValue * 0.01;
										} else {
											addedValue += value * extraValue * 0.01;
										}
									} else {
										if (type == 'sub') {
											addedValue -= extraValue;
										} else {
											addedValue += extraValue;
										}
									}
									return Round((value + addedValue) * digitalNum, isFloat ? 1 : 0) / digitalNum;
								});
							}
						}
					}
				}
			}
		}
		if (abilityUpgradeID != undefined) {
			const upgradeValue = getAbilityUpgradeSpecialValue(playerID, abilityUpgradeID, params.specialValueName);
			if (upgradeValue.add != 0 || upgradeValue.mul != 0) {
				_baseValue = _baseValue.map((value) => {
					return Round((value + upgradeValue.add) * (1 + upgradeValue.mul * 0.01) * digitalNum) / digitalNum;
				});
			}
		}
		if (onlyValue && onlyShowNowLevel) {
			return _baseValue[currentLevel] ?? _baseValue[0] ?? 0;
		}
		baseValueString = _baseValue
			.map((v, index) => {
				let str = v + pctSymbol;
				if (_baseValue.length > 1) {
					if (level > 0 && index == currentLevel) {
						str = `<span class="current">${str}</span>`;
					}
				} else {
					str = `<span class="current">${str}</span>`;
				}
				return str;
			})
			.join('/');
	}
	const connector = baseValueString != '' && addedValueString != '' ? ' + ' : '';
	return baseValueString + connector + addedValueString;
}
function getKeyValueDescription(abilityValues, description, params = {}) {
	let level = params.level ?? 0;
	let entIndex = params.entIndex ?? -1;
	let symbol = params.symbol ?? ['%', '%'];
	let onlyShowNowLevel = params.onlyShowNowLevel ?? false;
	let valueNameList = Object.keys(abilityValues);
	for (const valueName of valueNameList) {
		let block = new RegExp(symbol[0] + valueName + symbol[1], 'g');
		let blockPS = new RegExp(symbol[0] + valueName + symbol[1] + '%', 'g');
		let iResult = description.search(block);
		let iResultPS = description.search(blockPS);
		if (iResult == -1 && iResultPS == -1) continue;
		let value = abilityValues[valueName];
		let spanClass = 'GameplayValues GameplayVariable';
		if (typeof value == 'object') {
			if (value['_ulti']) {
				spanClass = 'UltimateValues';
			}
		}
		const v = GetAbilityValue(value, {
			entIndex,
			level,
			onlyShowNowLevel,
			hasPct: iResultPS != -1,
			abilityUpgradeID: params.abilityUpgradeID,
			playerID: params.playerID,
			specialValueName: valueName,
		});
		description = description.replace(blockPS, `<span class='${spanClass}'>${v}</span>`);
		description = description.replace(block, `<span class='${spanClass}'>${v}</span>`);
	}
	return description;
}

const getSectIndex = (sectName) => {
	switch (sectName) {
		case 'sect_attack':
			return '14';
		case 'sect_evade':
			return '13';
		case 'sect_crit':
			return '12';
		case 'sect_health':
			return '11';
		case 'sect_regen':
			return '10';
		case 'sect_ulti':
			return '09';
		case 'sect_poison':
			return '08';
		case 'sect_ice':
			return '07';
		case 'sect_fury':
			return '06';
		case 'sect_shield':
			return '05';
		case 'sect_injury':
			return '16';
		case 'sect_wisp':
			return '15';
		case 'total_damage':
			return '04';
		default:
			return '01';
	}
};
const getSectColor = (sectName) => {
	switch (sectName) {
		case 'sect_attack':
			return '#70DBFF';
		case 'sect_evade':
			return '#A696FF';
		case 'sect_crit':
			return '#FFA685';
		case 'sect_health':
			return '#FFFF9C';
		case 'sect_regen':
			return '#DAFF69';
		case 'sect_ulti':
			return '#78B3FF';
		case 'sect_poison':
			return '#59FF59';
		case 'sect_ice':
			return '#70FFD9';
		case 'sect_fury':
			return '#FF6B6D';
		case 'sect_shield':
			return '#FFBD52';
		case 'sect_injury':
			return '#D98CFF';
		case 'sect_wisp':
			return '#FF87C3';
		case 'total_damage':
			return '#c11017';
		default:
			return '#17a3c6';
	}
};
const getSectImage = (sectName) => {
	switch (sectName) {
		case 'sect_attack':
			return 'skill_swordsman';
		case 'sect_evade':
			return 'wild_psd';
		case 'sect_crit':
			return 'assassin_psd';
		case 'sect_health':
			return 'brawny_psd';
		case 'sect_regen':
			return 'healer_psd';
		case 'sect_ulti':
			return 'mage_psd';
		case 'sect_poison':
			return 'poisoner_psd';
		case 'sect_ice':
			return 'ice_psd';
		case 'sect_fury':
			return 'fury_psd';
		case 'sect_shield':
			return 'warrior_psd';
		case 'sect_injury':
			return 'beast_psd';
		case 'sect_wisp':
			return 'void_psd';
		case 'total_damage':
			return 'bloodbound_psd';
		default:
			return '';
	}
};

const isBattleState = (gameState) => {
	if (gameState) {
		return gameState.state == 'GameState_Battle' || gameState.state == 'GameState_ConfirmBattle' || gameState.state == 'GameState_Neutral';
	}
	return false;
};
const isNeutralState = (gameState) => {
	if (gameState) {
		return gameState.state == 'GameState_ConfirmNeutral' || gameState.state == 'GameState_Neutral';
	}
	return false;
};
const isPrepareState = (gameState) => {
	if (gameState) {
		return gameState.state == 'GameState_Prepare';
	}
	return false;
};
function getStoreItemCost(itemData, count = 1) {
	const sLanguage = $.Language().toLowerCase();
	if (itemData.pay_type == undefined || itemData.pay_type == 0) {
		let dollarMark = '￥';
		let price = itemData.real_price;
		if (sLanguage == 'schinese') {
			dollarMark = '￥';
			price = itemData.real_price;
		} else if (sLanguage == 'english') {
			dollarMark = '$';
			price = itemData.overseas_real_price;
		} else if (sLanguage == 'russian') {
			dollarMark = '₽';
			price = itemData.russia_real_price;
		}
		return dollarMark + price * count;
	} else {
		return itemData.real_price * count;
	}
}

function getPayTypeIconPath(payType) {
	return `file://{images}/custom_game/tokens/${payType}.png`;
}
/** 获取伤害类型对应的颜色 */
function getDamageTypeColor(damageType) {
	switch (damageType) {
		case 0:
			return '#a3a3a3';
		case 1:
			return '#ae2f28';
		case 2:
			return '#5b93d1';
		case 4:
			return '#d8ae53';
		case 8:
			return '#36b347';
		case 16:
			return '#b336af';
		case 32:
			return '#d2c8e4';
		default:
			return '#a3a3a3';
	}
}

function getAllPlayerData() {
	const result = [];
	const net = CustomNetTables.GetAllTableValues('player_data');
	for (const info of net) {
		result[Number(info.key)] = info.value;
	}
	return result;
}

function getPlayerData(playerID, key) {
	const net = CustomNetTables.GetTableValue('player_data', String(playerID));
	if (key) {
		return net?.[key];
	}
	return net;
}

function getGameState() {
	const net = CustomNetTables.GetTableValue('common', 'game_state');
	return net?.state ?? 'GameState_None';
}

function getGameStateType() {
	const net = CustomNetTables.GetTableValue('common', 'game_state');
	return net?.type ?? 'normal';
}
function IsCeasefireState(game_state) {
	if (game_state == "GameState_ExtraBattlePrepare" || game_state == "GameState_ConfirmBattle" || game_state == "GameState_Battle" || game_state == "GameState_ConfirmNeutral" || game_state == "GameState_Neutral" || game_state == "GameState_BattleEnd") {
		return false;
	}
	return true;
}

// 获取对战信息
const getBattleData = (playerID, isIllusion) => {
	if (isIllusion == undefined) {
		isIllusion = false;
	}
	const battleDataNet = CustomNetTables.GetTableValue('common', 'battle_data');
	if (battleDataNet) {
		for (const [battleIndex, battleData] of Object.entries(battleDataNet)) {
			if (isIllusion) {
				if (
					(battleData.mainPlayer.PlayerID == playerID && battleData.mainPlayer.illusion == 1) ||
					(battleData.customerPlayer.PlayerID == playerID && battleData.customerPlayer.illusion == 1)
				) {
					return battleData;
				}
			} else {
				if (
					(battleData.mainPlayer.PlayerID == playerID && battleData.mainPlayer.illusion != 1) ||
					(battleData.customerPlayer.PlayerID == playerID && battleData.customerPlayer.illusion != 1)
				) {
					return battleData;
				}
			}
		}
	}
};
const getEnemyPlayerID = (playerID, isIllusion) => {
	if (isIllusion == undefined) {
		isIllusion = false;
	}
	const battleData = getBattleData(playerID, isIllusion);
	if (battleData == undefined) {
		return;
	}
	if (battleData.mainPlayer.PlayerID == playerID) {
		return battleData.customerPlayer.PlayerID;
	} else if (battleData.customerPlayer.PlayerID == playerID) {
		return battleData.mainPlayer.PlayerID;
	}
};
const isIllusionEnemy = (playerID, isIllusion) => {
	if (isIllusion == undefined) {
		isIllusion = false;
	}
	const battleData = getBattleData(playerID, isIllusion);
	if (battleData == undefined) {
		return false;
	}
	if (battleData.mainPlayer.PlayerID == playerID) {
		return battleData.customerPlayer.illusion == 1;
	} else if (battleData.customerPlayer.PlayerID == playerID) {
		return battleData.mainPlayer.illusion == 1;
	}
	return false;
};
/** 是否拥有关键字 */
const hasKeyWord = (str, ignore_list) => {
	// 构建需要匹配的关键字列表
	const keywords = [];
	if (!ignore_list?.keyword) keywords.push('KeyWord');
	if (!ignore_list?.ability) keywords.push('Ability');
	if (!ignore_list?.info) keywords.push('Info');
	if (keywords.length === 0) return false;
	const reg = new RegExp(`{(?:${keywords.join('|')}):([\\w\\d]+?)}`);
	return reg.test(str);
};
/** 获取关键字列表 */
const getKeyWordList = (str, ignore_list) => {
	let arr = [];
	if (!ignore_list?.keyword) {
		str.replace(/{KeyWord:(\w+?)}/g, (a, b, c) => {
			arr.push({ type: 'KeyWord', value: b });
		});
	}

	if (!ignore_list?.ability) {
		str.replace(/{Ability:(\w+?)}/g, (a, b, c) => {
			arr.push({ type: 'Ability', value: b });
		});
	}

	if (!ignore_list?.info) {
		str.replace(/{Info:(\w+?)}/g, (a, b, c) => {
			arr.push({ type: 'Info', value: b });
		});
	}
	let copy = [...arr];
	copy.forEach((v) => {
		if (v.type == 'Ability') {
			if (KeyValues.AbilityUpgradesKv[v.value]) {
				arr = arr.concat(getKeyWordList($.Localize('#DOTA_Tooltip_ability_mechanics_' + v.value + '_description'), ignore_list));
			} else {
				arr = arr.concat(getKeyWordList($.Localize('#DOTA_Tooltip_ability_' + v.value + '_description'), ignore_list));
			}
		} else {
			arr = arr.concat(getKeyWordList($.Localize('#' + v.value + '_description'), ignore_list));
		}
	});
	// 移除重复项
	arr = arr.filter((v, i, a) => a.findIndex((t) => t.type == v.type && t.value == v.value) === i);
	return arr;
};

const getMedalInfo = (medalCount) => {
	let medalKey = '0';
	for (const key in GameUI.CustomUIConfig().MedalConfigKv) {
		const medalInfo = GameUI.CustomUIConfig().MedalConfigKv[key];
		if (medalCount >= medalInfo.medal) {
			medalKey = key;
		} else {
			break;
		}
	}
	const result = { ...GameUI.CustomUIConfig().MedalConfigKv[medalKey] };
	result.level = Number(result.icon);
	result.icon = 's2r://panorama/images/custom_game/medal/' + result.icon + '_png.vtex';
	result.star = result.star;
	return result;
};

const getOrnamentWithType = (data, type) => {
	const result = {};
	for (const oid in data) {
		const ornament = data[oid];
		if (ornament.pool == type) {
			result[oid] = ornament;
		}
	}
	return result;
};

const getHeroCosmeticList = (hid) => {
	const cosmeticList = [
		{
			cosmeticID: 'hero_skin_default',
			Rarity: 0,
		},
	];
	for (const cosmeticID in GameUI.CustomUIConfig().CosmeticsKv) {
		const cosmeticData = GameUI.CustomUIConfig().CosmeticsKv[cosmeticID];
		if (cosmeticData.tool != 1 || Game.IsInToolsMode()) {
			if (cosmeticData.hero == hid) {
				cosmeticList.push({
					cosmeticID,
					Rarity: cosmeticData.rarity ?? 0,
				});
			}
		}
	}
	return cosmeticList;
};

const getAllCosmetics = () => {
	const result = [];
	const kv = GameUI.CustomUIConfig().CosmeticsKv;
	for (let oid in kv) {
		if (kv[oid].tool != 1 || Game.IsInToolsMode()) {
			const islot = Number(oid.slice(1, 3));
			const orderby = finiteNumber(Number(kv.orderby));
			const data = {
				oid: parseInt(oid),
				slot: islot,
				rarity: kv[oid].rarity ?? 0,
				default: oid.slice(3) == '0000',
				orderby: orderby,
				mark: kv[oid].mark ?? 0,
			};
			result.push(data);
		}
	}
	return result;
};

const getCosmeticList = (slot) => {
	const result = [];
	const kv = GameUI.CustomUIConfig().CosmeticsKv;
	for (let oid in kv) {
		if (kv[oid].tool != 1 || Game.IsInToolsMode()) {
			const id = parseInt(oid);
			const islot = Number(oid.slice(1, 3));
			const orderby = finiteNumber(Number(kv.orderby));
			if (islot == slot) {
				const data = {
					oid: id,
					slot: oid,
					rarity: kv[oid].rarity ?? 0,
					default: oid.slice(3) == '0000',
					orderby: orderby,
				};
				result.push(data);
			}
		}
	}
	result.sort((a, b) => {
		return multiCompare(...[b.orderby - a.orderby, a.oid - b.oid]);
	});
	return result;
};
const getCosmeticMark = (oid) => {
	if (!oid) return 0;
	const data = GameUI.CustomUIConfig().CosmeticsKv[oid.toString()];
	if (!data) return 0;
	return data.mark ?? 0;
};
const getCosmeticRarity = (oid) => {
	if (!oid) return 0;
	const data = GameUI.CustomUIConfig().CosmeticsKv[oid.toString()];
	if (!data) return 0;
	return data.rarity ?? 0;
};
const getCosmeticData = (oid) => {
	if (!oid) return;
	const data = GameUI.CustomUIConfig().CosmeticsKv[oid.toString()];
	if (!data) return;
	const id = parseInt(oid);
	const slot = id / 10000 - ((id / 10000) % 1) - 500;
	return Object.assign(data, { oid: id, slot: slot });
};
const getCosmeticImagePath = (itemID, hid, isStoreImage = true) => {
	const type = Number((itemID ?? '').slice(1, 3)) ?? 0;
	let suffix = '';
	const language = $.Language().toLowerCase();
	switch (type) {
		case 70:
			return 's2r://panorama/images/custom_game/avatar_frame/' + itemID + '_png.vtex';
		// case 71:
		// return "s2r://panorama/images/custom_game/avatar_border/" + itemID + "_png.vtex";
		case 75:
			suffix = '';
			if (isStoreImage) {
				if (language == 'english' || language == 'russian') {
					const path = `file://{images}/custom_game/cosmetics_items/${itemID}_${language}.png`;
					if ($.BImageFileExists(path)) {
						suffix = `_${language}`;
					}
				}
				return 's2r://panorama/images/custom_game/cosmetics_items/' + itemID + suffix + '_png.vtex';
			}
			if (language == 'english' || language == 'russian') {
				const path = `file://{images}/custom_game/avatar_medal/${itemID}_${language}.png`;
				if ($.BImageFileExists(path)) {
					suffix = `_${language}`;
				}
			}
			return 's2r://panorama/images/custom_game/avatar_medal/' + itemID + suffix + '_png.vtex';
		case 50:
			if (GameUI.CustomUIConfig().CosmeticsKv[itemID.toString()]?.resource == 'english') {
				if ($.Language().toLowerCase() != 'schinese') {
					return 's2r://panorama/images/custom_game/emoji/' + itemID + '_english' + '_png.vtex';
				}
			}
			return 's2r://panorama/images/custom_game/emoji/' + itemID + '_png.vtex';
		case 51:
			suffix = '';
			if (language == 'english' || language == 'russian') {
				if ($.BImageFileExists(`file://{images}/custom_game/hero_emoji/${itemID}_${language}.png`)) {
					suffix = `_${language}`;
				} else if ($.BImageFileExists(`file://{images}/custom_game/hero_emoji/${itemID}_english.png`)) {
					suffix = `_english`;
				}
			}
			return 's2r://panorama/images/custom_game/hero_emoji/' + itemID + suffix + '_png.vtex';
		case 44:
			return 's2r://panorama/images/custom_game/battle_message/win_streak/' + itemID + '_png.vtex';
		default:
			suffix = '';
			if (language == 'english' || language == 'russian') {
				const path = `file://{images}/custom_game/cosmetics_items/${itemID}_${language}.png`;
				if ($.BImageFileExists(path)) {
					suffix = `_${language}`;
				}
			}
			return 's2r://panorama/images/custom_game/cosmetics_items/' + itemID + suffix + '_png.vtex';
	}
};

const getAccess = (oid) => {
	if (!oid) return 'Access_none';
	const data = GameUI.CustomUIConfig().CosmeticsKv[oid.toString()];
	if (!data) return 'Access_none';

	return data.access != undefined ? 'Access_' + data.access : 'Access_none';
};

const getHeroAccess = (hero_name) => {
	if (!hero_name) return 'Access_none';
	const data = GameUI.CustomUIConfig().UnitsCommonKv[hero_name.toString()];
	if (!data) return 'Access_none';

	return data.Access != undefined ? 'Access_' + data.Access : 'Access_none';
};

const getAvatarFrame = (playerID) => {
	const playerOrnament = getNetDataCache('player_ornament', playerID);
	if (playerOrnament) {
		for (const oid in playerOrnament) {
			const cosmeticInfo = playerOrnament[oid];
			if (cosmeticInfo.pool == OrnamentType.AVTAR && cosmeticInfo.equip == 1) {
				return oid;
			}
		}
	}
};
const getAvatarBorder = (playerID) => {
	const playerOrnament = getNetDataCache('player_ornament', playerID);
	if (playerOrnament) {
		for (const oid in playerOrnament) {
			const cosmeticInfo = playerOrnament[oid];
			if (cosmeticInfo.pool == OrnamentType.AVTAR_BORDER && cosmeticInfo.equip == 1) {
				return oid;
			}
		}
	}
};

function getCosmeticByStoreItem(storeItem, player_ornament) {
	if (storeItem.items && player_ornament != undefined) {
		for (const itemData of storeItem.items) {
			if (player_ornament[itemData.item_id.toString()] && player_ornament[itemData.item_id.toString()].permanent == 1) {
				return true;
			}
		}
	}
	return false;
}

function getHerobyStoreItem(storeItem, player_hero) {
	const oidList = Object.keys(player_hero ?? {});
	if (storeItem.items && player_hero != undefined) {
		for (const itemData of storeItem.items) {
			if (oidList.includes(itemData.item_id.toString())) {
				return true;
			}
		}
	}
	return false;
}

const getRankInfo = (rank_score) => {
	let tier = 0;
	let num = 0;
	let rela_score = 0;
	let score_up = 0;
	for (const i in KeyValues.RankConfigKv) {
		const element = KeyValues.RankConfigKv[i];
		if (rank_score >= element.medal) {
			rela_score = rank_score - element.medal;
			tier = element.icon;
			num = element.num;
			score_up = element.medal_up;
		}
	}
	return { tier, num, rela_score, score_up };
};

function isBlackList(steamID) {
	const blackList = [];
	return blackList.includes(Number(steamID));
}
function isGMList(steamID) {
	const blackList = [143560744, 369504468, 339199150];
	return blackList.includes(Number(steamID));
}
function isTranslatorList(steamID) {
	const blackList = [474028835, 452142223];
	return blackList.includes(Number(steamID));
}
function isRankMode() {
	const mapName = Game.GetMapInfo()?.map_display_name;
	return mapName == 'junior_rank_1' || mapName == 'senior_rank_2' || mapName == 'rank_3' || mapName == 'rank_map';
}
function isGroupMode() {
	const mapName = Game.GetMapInfo()?.map_display_name;
	if (mapName == 'tournament_map') {
		const netData = CustomNetTables.GetTableValue('common', 'tournament_group_mode');
		return netData?.enabled == 1;
	}
	return mapName == '2v2v2v2';
}
function GetMapName() {
	return Game.GetMapInfo()?.map_display_name;
}

function getStoreMaxCount(itemData) {
	if (itemData == undefined) {
		return 999;
	}
	// 战令经验特殊处理
	if (itemData.id == 9900102) {
		const info_bp_level_exp = getNetDataCache('info_bp_level_exp') ?? [];
		let totalExp = 0;
		info_bp_level_exp.map((v) => {
			if (v.season == 1 && v.level < 100) {
				totalExp += v.exp;
			}
		});
		let exp = getNetDataCache('player_battle_passes', Players.GetLocalPlayer())?.['0']?.totalXp ?? 0;
		if (exp > totalExp) {
			return 0;
		}
		return Math.ceil((totalExp - exp) / 1000);
	}
	/** 通行证经验 */
	if (itemData.id == 9900107) {
		const info_bp_level_exp = getNetDataCache('info_bp_level_exp') ?? [];
		let totalExp = 0;
		info_bp_level_exp.map((v) => {
			if (v.season == 2 && v.level < 100) {
				totalExp += v.exp;
			}
		});
		let exp = getNetDataCache('player_battle_passes', Players.GetLocalPlayer())?.['1']?.totalXp ?? 0;
		if (exp > totalExp) {
			return 0;
		}
		return Math.ceil((totalExp - exp) / 200);
	}
	return itemData.limit_type > 0 ? itemData.limit_count : 999;
}

GameUI.CustomUIConfig().nameBanList = GameUI.CustomUIConfig().nameBanList ?? {};
function isNameBan(playerID) {
	if (GameUI.CustomUIConfig().nameBanList[playerID] != undefined) {
		return GameUI.CustomUIConfig().nameBanList[playerID];
	}
	const tableKey = 'ban' + playerID.toString();
	const cache = CustomNetTables.GetTableValue('service', tableKey);

	if (cache != undefined) {
		const data = JSON.parse(cache.data ?? {});
		if (data?.name == true) {
			GameUI.CustomUIConfig().nameBanList[playerID] = true;
			return true;
		} else if (data?.name == false) {
			GameUI.CustomUIConfig().nameBanList[playerID] = false;
			return false;
		}
	}
	return false;
}
// function clickNewMark(info, pSelf) {
// 	if (pSelf?.IsValid()) {
// 		if (!LoadData(pSelf, 'click_new_mark')) {
// 			SaveData(pSelf, 'click_new_mark', true);
// 			$.Schedule(1, () => {
// 				if (pSelf?.IsValid()) {
// 					SaveData(pSelf, 'click_new_mark', undefined);
// 				}
// 			});
// 			GameEvents.SendCustomEventToServer('click_new_mark', {
// 				menu: info.menu,
// 				tag: info.tag,
// 				benchmark: info.benchmark,
// 			});
// 		}
// 	} else {
// 		GameEvents.SendCustomEventToServer('click_new_mark', {
// 			menu: info.menu,
// 			tag: info.tag,
// 			benchmark: info.benchmark,
// 		});
// 	}
// }
// function clickNewMark(menuName, tagName, benchmark) {
// 	if (menuName == undefined) {
// 		return;
// 	}
// 	if (tagName == undefined) {
// 		return;
// 	}
// 	const netData = getNetDataCache("player_new_mark", Players.GetLocalPlayer());
// 	if (netData != undefined) {
// 		for (const mid in netData) {
// 			const state = netData[mid];
// 			if (state) {
// 				const kv = KeyValues.NewMarkInfoKv[mid];
// 				if (kv) {
// 					if (kv.tag_id && kv.tag_id == tagName) {
// 						if (kv.benchmark != undefined) {
// 							if (kv.benchmark == benchmark) {
// 								GameEvents.SendCustomEventToServer("click_new_mark", { mid });
// 							}
// 						} else {
// 							GameEvents.SendCustomEventToServer("click_new_mark", { mid });
// 						}
// 					}
// 				}
// 			}
// 		}
// 	}
// }

const getEquipCosmetic = (slot) => {
	const playerOrnament = getNetDataCache('player_ornament', Players.GetLocalPlayer());
	if (playerOrnament) {
		for (const oid in playerOrnament) {
			const cosmeticInfo = playerOrnament[oid];
			if (cosmeticInfo.pool == slot && cosmeticInfo.equip == 1) {
				return oid;
			}
		}
	}
};
const rookieTip = (type, dialog, extra) => {
	clientSideEvent('rookie', {
		type: type,
		dialog: dialog,
		extra: extra,
	});
};
const clearRookieTip = (type) => {
	clientSideEvent('rookie', {
		type: 'clear',
		id: typeof type == 'string' ? [type] : type,
	});
};
const getTokenSrcPath = (tokenID) => {
	if (tokenID == 1000002) {
		return getSrcPath('eom_design/icon/eom/star.png');
	}
	return getSrcPath(`tokens/${tokenID}.png`);
};

const isSpectator = (id) => {
	if (id == undefined) {
		id = Players.GetLocalPlayer();
	}
	return Players.GetTeam(id) == 3; // DOTATeam_t.DOTA_TEAM_BADGUYS
};

const hasInteractiveAbility = (name) => {
	if (name == undefined || GameUI.CustomUIConfig().UnitsCommonKv[name] == undefined) {
		return false;
	}
	return GameUI.CustomUIConfig().UnitsCommonKv[name].InteractiveAbilityName != undefined;
};
const closeRookieV2Tip = (key) => {
	var kv = GameUI.CustomUIConfig().RookieGuideKV[key];
	if (kv && kv.override) {
		clientSideEvent('rookieV2_override_close', {
			key: key,
		});
	} else {
		clientSideEvent('rookieV2_close', {
			key: key,
		});
	}
};
const getArenaActivityTime = () => {
	// 东8区偏移量（毫秒）
	const TIMEZONE_OFFSET_S = 8 * 60 * 60;

	// 获取当前时间（UTC+8）
	const now = new Date(Date.now() + TIMEZONE_OFFSET_S * 1000);

	// 获取当前星期几（0=周日，6=周六）
	const currentDay = now.getUTCDay();
	const currentHours = now.getUTCHours();
	const currentMin = now.getUTCMinutes();

	// 计算距离下一个周六的天数
	let daysUntilSaturday;
	// let _day = 6;
	// let startHour = 18;
	// let endHour = 24;
	// let startMin = 0;
	let _day = 6;
	let startHour = 18;
	let endHour = 24;
	let startMin = 0;
	if (currentDay === _day) {
		if (currentHours <= endHour) {
			// if (currentHours <= endHour && currentMin <= startMin) {
			daysUntilSaturday = 0;
		} else {
			daysUntilSaturday = 7;
		}
	} else {
		// 如果不是周六，计算距离下周六的天数（6 - currentDay + (currentDay === 0 ? 0 : 7)）
		daysUntilSaturday = (_day - currentDay + 7) % 7;
	}

	// 计算下周六 18:00 和 24:00 的 UTC+8 时间
	const nextTokenTime = new Date(now);
	nextTokenTime.setUTCDate(now.getUTCDate() + daysUntilSaturday);
	let tokenHour = startHour;
	let tokenMin = startMin - 10;
	if (tokenMin < 0) {
		tokenHour--;
		tokenMin = 60 + tokenMin;
	}
	nextTokenTime.setUTCHours(startHour - 1, tokenMin, 0, 0);
	// 计算下周六 18:00 和 24:00 的 UTC+8 时间
	const nextStartTime = new Date(now);
	nextStartTime.setUTCDate(now.getUTCDate() + daysUntilSaturday);
	nextStartTime.setUTCHours(startHour, startMin, 0, 0);

	const nextEndTime = new Date(now);
	nextEndTime.setUTCDate(now.getUTCDate() + daysUntilSaturday);
	nextEndTime.setUTCHours(endHour, startMin, 0, 0); // 24:00 等同于下一天的 00:00

	// 转换为时间戳（秒级）
	return {
		token_time: Math.floor(nextTokenTime.getTime() / 1000) - TIMEZONE_OFFSET_S,
		start_time: Math.floor(nextStartTime.getTime() / 1000) - TIMEZONE_OFFSET_S,
		end_time: Math.floor(nextEndTime.getTime() / 1000) - TIMEZONE_OFFSET_S,
	};
};
const ServerTimestamp = () => {
	const d = CustomNetTables.GetTableValue('service', 'server_time');
	let timestamp = 0;
	if (d) {
		timestamp = d.server_time + Math.floor(Game.Time() - d.request_time);
	} else {
		timestamp = Math.floor(Date.now() / 1000);
	}
	return timestamp;
};
const getPeakScoreRegionTime = () => {
	// let start_time = 1750608000;	// 2025-06-23 00:00:00
	// let end_time = 1751817599;		// 2025-07-06 23:59:59

	let start_time = 1783483200; // 2026-07-08 12:00:00
	let end_time = 1783871999; // 2026-07-12 23:59:59
	return {
		start_time,
		end_time,
	};
};
const addItemMessage = (list) => {
	GameEvents.SendEventClientSide('client_side_event', { event_name: 'client_ReceiveRewards', json: JSON.stringify(list) });
};
const getGameplayModuleState = (name) => {
	const data = CustomNetTables.GetTableValue('common', 'constant');
	if (data && data.GAMEPLAY_MODULE_LIST) {
		return data.GAMEPLAY_MODULE_LIST[name] == 1;
	}
	return false;
};
const IsRankRewardShow = () => {
	return true;
	// return Math.floor(Date.now() / 1000) <= 1753286400;
};
const getProductSrc = (pid, oid) => {
	let suffix = '';
	let id = pid;
	let language = $.Language().toLowerCase();
	if (oid != undefined) {
		if (language == 'english' || language == 'russian') {
			const path = `file://{images}/custom_game/store_items/${id}_${language}.png`;
			if ($.BImageFileExists(path)) {
				suffix = `_${language}`;
			}
		}
		let path = getSrcPath('store_items/' + id + suffix + '.png');
		if ($.BImageFileExists(path)) {
			suffix = `_${language}`;
			return path;
		}
		suffix = "";
		id = oid;
	}
	if (id) {
		let is_token = id.toString().startsWith("110");
		if (KeyValues.BackpackKv?.[id]) {
			suffix = '';
			if (language == 'english' || language == 'russian') {
				const path = `file://{images}/custom_game/backpack_items/${id}_${language}.png`;
				if ($.BImageFileExists(path)) {
					suffix = `_${language}`;
				}
			}
			let path = 'file://{images}/custom_game/backpack_items/' + id + suffix + '.png';
			if ($.BImageFileExists(path)) {
				return path;
			}
		} else if (KeyValues.CosmeticsKv?.[id]) {
			let path = getCosmeticImagePath(id.toString());
			if ($.BImageFileExists(path)) {
				return path;
			}
		} else if (is_token) {
			let path = "file://{images}/custom_game/store_items/" + id + ".png";
			if ($.BImageFileExists(path)) {
				return path;
			}
			path = "file://{images}/custom_game/tokens/" + id + ".png";
			if ($.BImageFileExists(path)) {
				return path;
			}
		}
	}
	suffix = '';
	if (language == 'english' || language == 'russian') {
		const path = `file://{images}/custom_game/store_items/${pid}_${language}.png`;
		//@ts-ignore
		if ($.BImageFileExists(path)) {
			suffix = `_${language}`;
		}
	}
	return getSrcPath('store_items/' + pid + suffix + '.png');
};
const getWeekHeroRefreshTime = () => {
	// 东8区偏移量（毫秒）
	const TIMEZONE_OFFSET_S = 8 * 60 * 60;

	// 获取当前时间（UTC+8）
	const now = new Date(Date.now() + TIMEZONE_OFFSET_S * 1000);

	// 获取当前星期几（0=周日，6=周六）
	const currentDay = now.getUTCDay();
	const currentHours = now.getUTCHours();

	const targetDay = 1;
	const targetHour = 0;
	// 计算距离下一个targetDay和targetHour的天数
	let dayOffset = 0;

	if (currentDay === targetDay) {
		if (currentHours < targetHour) {
			dayOffset = 0;
		} else {
			dayOffset = 7;
		}
	} else {
		// 如果不是周六，计算距离下周六的天数（6 - currentDay + (currentDay === 0 ? 0 : 7)）
		dayOffset = (targetDay - currentDay + 7) % 7;
	}
	// 计算下个 targetDay的targetHour的 UTC+8 时间
	const nextTargetTime = new Date(now);
	nextTargetTime.setUTCDate(now.getUTCDate() + dayOffset);
	nextTargetTime.setUTCHours(targetHour, 0, 0, 0);

	// 转换为时间戳（秒级）
	return Math.floor(nextTargetTime.getTime() / 1000) - TIMEZONE_OFFSET_S;
};

const SetCosmeticPreviewLive = (cosmetic_id, debug) => {
	if (cosmetic_id == undefined) {
		GameUI.CustomUIConfig()._Cosmetic_Preview_Live = false;
		GameUI.SetCameraTarget(GameUI.CustomUIConfig()._Camera_Lock_Target_Ent);
		GameUI.SetCameraYaw(GameUI.CustomUIConfig()._Camera_Yaw);
		GameUI.SetCameraDistance(GameUI.CustomUIConfig()._Camera_Distance);
		GameUI.SetCameraPitchMin(GameUI.CustomUIConfig()._Camera_Pitch);
		GameUI.SetCameraPitchMax(GameUI.CustomUIConfig()._Camera_Pitch);
		GameUI.SetCameraLookAtPositionHeightOffset(GameUI.CustomUIConfig()._Camera_HeightOffset);
		if (debug) {
			GameEvents.SendCustomEventToServer('cosmetic_preview_live', { debug: 1 });
		} else {
			GameEvents.SendCustomEventToServer('cosmetic_preview_live', {});
		}
		GameEvents.SendEventClientSide('cosmetic_preview_live_worldlayer', { state: 0 });
		return;
	}
	GameUI.CustomUIConfig()._Cosmetic_Preview_Live = true;
	if (debug) {
		GameEvents.SendCustomEventToServer('cosmetic_preview_live', { cosmetic_id, debug: 1 });
	} else {
		GameEvents.SendCustomEventToServer('cosmetic_preview_live', { cosmetic_id });
	}
	GameEvents.SendEventClientSide('cosmetic_preview_live_worldlayer', { state: 1 });
	const index = getPlayerData(Players.GetLocalPlayer(), 'index');
	const cameraList = CustomNetTables.GetTableValue('common', 'camera_ent_list');
	if (index != undefined && cameraList) {
		if (cameraList.cosmetic_preview[index] != undefined) {
			const CAMERA_CONFIG = CustomNetTables.GetTableValue('common', 'constant')?.CAMERA_CONFIG;
			GameUI.SetCameraTarget(cameraList.cosmetic_preview[index]);
			GameUI.SetCameraYaw(0);
			if (CAMERA_CONFIG == undefined) {
				// 镜头高度
				GameUI.SetCameraDistance(1590);
				// 镜头俯仰
				GameUI.SetCameraPitchMin(60);
				GameUI.SetCameraPitchMax(60);
				// 镜头zoffset
				GameUI.SetCameraLookAtPositionHeightOffset(-340);
			} else {
				const service_config = getPlayerData(Players.GetLocalPlayer(), 'service_config');
				let type = 'default';
				if (service_config?.['camera_move'] != '0') {
					type = 'close';
				}
				const config = CAMERA_CONFIG[type];
				if (config) {
					// 镜头高度
					GameUI.SetCameraDistance(config.distance_live);
					// 镜头俯仰
					GameUI.SetCameraPitchMin(config.pitch);
					GameUI.SetCameraPitchMax(config.pitch);
					// 镜头zoffset
					GameUI.SetCameraLookAtPositionHeightOffset(config.yOffset_live);
				}
			}
		}
	}
};

const GetCosmeticAccessDescription = (cosmetic_id) => {
	let text = $.Localize('#' + cosmetic_id + '_description');
	if (cosmetic_id && KeyValues.CosmeticsKv[cosmetic_id]?.map_skin_list) {
		text += ' ' + $.Localize('#battle_map_auto_switch');
	}
	return text;
};

var TeamSuggestAction;
(function (TeamSuggestAction) {
	TeamSuggestAction[(TeamSuggestAction['ShopCard'] = 0)] = 'ShopCard';
	TeamSuggestAction[(TeamSuggestAction['CardEffect'] = 1)] = 'CardEffect';
	TeamSuggestAction[(TeamSuggestAction['SpecialSelection'] = 2)] = 'SpecialSelection';
	TeamSuggestAction[(TeamSuggestAction['HeroSelection'] = 3)] = 'HeroSelection';
})(TeamSuggestAction || (TeamSuggestAction = {}));

const SendTeammateSuggestAction = (action, extra_info) => {
	let params = {
		player: Players.GetLocalPlayer(),
		action,
		extra_info,
	};
	GameEvents.SendCustomEventToServer("teammate_suggest_action", params);
	clientSideEvent("teammate_suggest_action", params);
};
/** 中文替换字符，全角空格 */
const NormalizeTabText = (text) => {
	text = text.replace(/，/g, ', ');
	text = text.replace(/。/g, '。 ');
	return text;
};