--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const hidden_upgrades = {
	morphling_morph: ["bonus_attributes"],
	nevermore_shadowraze2: [
		"shadowraze_damage",
		"stack_bonus_damage",
		"shadowraze_radius",
		"duration",
		"shadowraze_radius",
		"cooldown_and_manacost",
	],
	nevermore_shadowraze3: [
		"shadowraze_damage",
		"stack_bonus_damage",
		"shadowraze_radius",
		"duration",
		"shadowraze_radius",
		"cooldown_and_manacost",
	],
	nevermore_necromastery: ["necromastery_max_souls_scepter"],
};
let favorites_upgrades = {};
const CONTEXT = $.GetContextPanel();

GameUI.Upgrades = {};

GameUI.Upgrades.IsHiddenUpgrade = (ability_name, upgrade_name) => {
	return hidden_upgrades[ability_name] != undefined && hidden_upgrades[ability_name].indexOf(upgrade_name) > -1;
};

GameUI.Upgrades.ToggleFavoriteUpgrade = (ability_name, upgrade_name) => {
	if (CONTEXT.BHasClass("FavoriteSetCooldown")) return;
	CONTEXT.AddClass("FavoriteSetCooldown");
	$.Schedule(0.1, () => {
		CONTEXT.RemoveClass("FavoriteSetCooldown");
	});

	const state = !(favorites_upgrades[ability_name] && favorites_upgrades[ability_name][upgrade_name]);

	const upgrade_panel = FindDotaHudElement(`UpgradeSelection_${ability_name}_${upgrade_name}`);
	if (upgrade_panel) upgrade_panel.SetHasClass("BFavorite", state);
	const selected_upgrade_color = FindDotaHudElement(`UpgradeSelected_${ability_name}_${upgrade_name}`);
	if (selected_upgrade_color) selected_upgrade_color.SetHasClass("BFavorite", state);

	if (state) {
		favorites_upgrades[ability_name] = favorites_upgrades[ability_name] || {};
		favorites_upgrades[ability_name][upgrade_name] = true;
	} else if (favorites_upgrades[ability_name] && favorites_upgrades[ability_name][upgrade_name]) {
		delete favorites_upgrades[ability_name][upgrade_name];
		if (Object.keys(favorites_upgrades[ability_name]).length == 0) delete favorites_upgrades[ability_name];
	}

	GameEvents.SendToServerEnsured("Upgrades:set_favorites", { favorites_upgrades: favorites_upgrades });
};

GameUI.Upgrades.IsUpgradeFavorite = (ability_name, upgrade_name) => {
	return favorites_upgrades[ability_name] && favorites_upgrades[ability_name][upgrade_name];
};

function _SetFavorites(_favorites_upgrades) {
	favorites_upgrades = _favorites_upgrades;
}

(() => {
	GameEvents.SubscribeProtected("Upgrades:set_client_favorites", _SetFavorites);

	GameEvents.SendToServerEnsured("Upgrades:get_favorites", {});
	GameEvents.SendToServerEnsured("Upgrades:get_upgrades", {});
})();