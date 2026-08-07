--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


"use strict";

// HeroIDCache
GameUI.CustomUIConfig().HeroIDCache = {}; // Record<number, string>
for (const heroName in GameUI.CustomUIConfig().UnitsCommonKv) {
	if (GameUI.CustomUIConfig().UnitsCommonKv[heroName].Hid) {
		GameUI.CustomUIConfig().HeroIDCache[GameUI.CustomUIConfig().UnitsCommonKv[heroName].Hid] = heroName;
	}
}

// CosmeticColoringList
GameUI.CustomUIConfig().CosmeticColoringList = {}; // Record<number, string>
for (const oid in GameUI.CustomUIConfig().CosmeticsKv) {
	if (GameUI.CustomUIConfig().CosmeticsKv[oid].coloring) {
		if (GameUI.CustomUIConfig().CosmeticColoringList[GameUI.CustomUIConfig().CosmeticsKv[oid].coloring.toString()] == undefined) {
			GameUI.CustomUIConfig().CosmeticColoringList[GameUI.CustomUIConfig().CosmeticsKv[oid].coloring.toString()] = [];
		}
		GameUI.CustomUIConfig().CosmeticColoringList[GameUI.CustomUIConfig().CosmeticsKv[oid].coloring.toString()].push(oid);
	}
}


GameUI.CustomUIConfig().HeroAbilityDisplayList = {}; // Record<string, string[]>
{
	var i = 1;
	var kv;
	var s;
	// var x;
	for (const heroName in GameUI.CustomUIConfig().UnitsCommonKv) {
		kv = GameUI.CustomUIConfig().UnitsCommonKv[heroName];
		GameUI.CustomUIConfig().HeroAbilityDisplayList[heroName] = [];
		i = 1;
		while (kv["DefaultAbility" + i]) {
			s = kv["DefaultAbility" + i];
			if (GameUI.CustomUIConfig().AbilitiesKv[s]) {
				if (GameUI.CustomUIConfig().AbilitiesKv[s].CustomAbilityType == undefined || (GameUI.CustomUIConfig().AbilitiesKv[s].CustomAbilityType != "ABILITY_TYPE_UI_HIDDEN" && GameUI.CustomUIConfig().AbilitiesKv[s].CustomAbilityType != "ABILITY_TYPE_TALENT")) {
					GameUI.CustomUIConfig().HeroAbilityDisplayList[heroName].push(s);
				}
			}
			i++;
		}
	}
}

// SectList
if (GameUI.CustomUIConfig().SECT_LIST == undefined) {
	GameUI.CustomUIConfig().SECT_LIST = []; // Record<number, string>
	for (const sectName in GameUI.CustomUIConfig().SectAbilitiesKv) {
		GameUI.CustomUIConfig().SECT_LIST.push(sectName);
	}
	GameUI.CustomUIConfig().SECT_LIST.sort();
	GameUI.CustomUIConfig().SECT_LIST.push("sect_none");
}

// AbilityUpMechanicsLinked
GameUI.CustomUIConfig().AbilityUpMechanicsLinked = {}; // Record<number, string>
for (const id in GameUI.CustomUIConfig().AbilityUpgradesMechenicsKv) {
	let link_ability = GameUI.CustomUIConfig().AbilityUpgradesMechenicsKv[id].link_ability;
	if (link_ability) {
		let title = "None";
		if (GameUI.CustomUIConfig().AbilityUpgradesMechenicsKv[id].title) {
			title = GameUI.CustomUIConfig().AbilityUpgradesMechenicsKv[id].title;
		}
		if (GameUI.CustomUIConfig().AbilityUpMechanicsLinked[link_ability] == undefined) {
			GameUI.CustomUIConfig().AbilityUpMechanicsLinked[link_ability] = {};
		}
		if (GameUI.CustomUIConfig().AbilityUpMechanicsLinked[link_ability][title] == undefined) {
			GameUI.CustomUIConfig().AbilityUpMechanicsLinked[link_ability][title] = [];
		}
		GameUI.CustomUIConfig().AbilityUpMechanicsLinked[link_ability][title].push(id);
	}
}
GameUI.CustomUIConfig().ShopProductStepList = {
	[9900291]: [9900291, 9900297]
}; // Record<number, number[]>
GameUI.CustomUIConfig().GreevilGiftList = [];
for (const id in GameUI.CustomUIConfig().GreevilShopKV) {
	const kv = GameUI.CustomUIConfig().GreevilShopKV[id];
	if (kv.Round == 1 && (kv.Type == "trait" || kv.Type == "greevil_effect")) {
		GameUI.CustomUIConfig().GreevilGiftList.push(kv.Value);
	}
}
// region 处理神符卡池数据
// /** 多人模式下用TeamCardKV的数据替代 */
// if (Game.GetMapInfo()?.map_display_name == "2v2v2v2") {
// 	GameUI.CustomUIConfig().CardEffectKv = GameUI.CustomUIConfig().TeamCardKv;
// }