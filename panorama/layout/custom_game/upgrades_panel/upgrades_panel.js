--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const special_upgrades = {
	["cooldown_and_manacost"]: $.Localize("#cooldown_and_manacost_upgrade"),
};

const HUD = {
	ROOT: $.GetContextPanel(),
	UPGRADES_CONTAINER: $("#Upgrades_Container"),
	UPGRADES_WRAPPER: $("#Upgrades_Wrap"),
	REROLL_LABEL: $("#RerollButton_Label"),
	REROLL_LABEL_UNDER: $("#RerollButtonBonusLabel"),
	REROLL_BUTTON: $("#RerollButton"),
	AS_TOGGLE_BUTTON: $("#AS_Toggle"),
	AS_TIMER: $("#AS_Timer"),
	TOGGLE_GENERIC_FROM_SUB_BUTTON: $("#ToggleButtoon_GenericFromSub"),
};

const DOTA_TOAST_MANAGER = FindDotaHudElement("SpectatorToastManager");

let current_selection_id = "";
let current_reroll_count = 0;
let current_rarity = 0;
let as_time_step = 1;
let as_current_time = 0;
let auto_select_fav_schedule;
let ability_upgrades_counter = 0;

function AssignAbilityTooltip(ability_panel) {
	ability_panel.SetPanelEvent("onmouseover", () => {
		$.DispatchEvent("DOTAShowAbilityTooltip", ability_panel, ability_panel.abilityname);
	});
	ability_panel.SetPanelEvent("onmouseout", () => {
		$.DispatchEvent("DOTAHideAbilityTooltip");
	});
}

function UpdatePanelHeaderText(panel, data) {
	let upgrades_wrapper = panel;
	let common_particle = upgrades_wrapper.FindChildTraverse("common_particle_effect");
	let rare_particle = upgrades_wrapper.FindChildTraverse("rare_particle_effect");
	let epic_particle = upgrades_wrapper.FindChildTraverse("epic_particle_effect");
	let upgrades_header_text = upgrades_wrapper.FindChildTraverse("Upgrades_Header_Text");
	upgrades_header_text.html = true;
	if (data.upgrade_rarity == 1) {
		upgrades_header_text.text = $.Localize("#ui_common_orb_upgrade");

		common_particle.visible = true;
		rare_particle.visible = false;
		epic_particle.visible = false;
	} else if (data.upgrade_rarity == 2) {
		upgrades_header_text.text = $.Localize("#ui_rare_orb_upgrade");

		common_particle.visible = false;
		rare_particle.visible = true;
		epic_particle.visible = false;
	} else if (data.upgrade_rarity == 4) {
		upgrades_header_text.text = $.Localize("#ui_epic_orb_upgrade");

		common_particle.visible = false;
		rare_particle.visible = false;
		epic_particle.visible = true;
	}
}

function MakeAbilityUpgradePanel(upgrade_panel, upgrade_info, data) {
	const is_generic_upgrade = upgrade_info.type == UPGRADE_TYPE.GENERIC;
	const selection_rarity = data.upgrade_rarity || RARITY.COMMON;
	const min_rarity = upgrade_info.min_rarity || upgrade_info.rarity || RARITY.COMMON;
	const current_count = (upgrade_info.count || 0) / (is_generic_upgrade ? 1 : min_rarity);
	const hero_idx = Players.GetPlayerHeroEntityIndex(LOCAL_PLAYER_ID);

	upgrade_panel.SetHasClass("GenericUpgrade", is_generic_upgrade);

	const image = upgrade_panel.FindChildTraverse("Upgrade_Image");
	const additional_values_root = upgrade_panel.FindChildTraverse("AdditionalValues_Container");

	if (is_generic_upgrade) {
		upgrade_info.ability_name = "generic";

		image.SetImage(
			`file://{images}/custom_game/upgrades/generics/${upgrade_info.upgrade_name.replace("generic_", "")}.png`,
		);
		image.SetScaling("stretch-to-fit-y-preserve-aspect");

		upgrade_panel.SetDialogVariable("base_value_desc", $.Localize(`#${upgrade_info.upgrade_name}`, upgrade_panel));
	} else {
		image.SetAbilityImageToLocalHero(upgrade_info.ability_name);
		AssignAbilityTooltip(image);
	}

	if (GameUI.Upgrades.IsUpgradeFavorite(upgrade_info.ability_name, upgrade_info.upgrade_name))
		upgrade_panel.AddClass("BFavorite");

	ability_upgrades_counter++;

	const locked_for_pick_by_supp_1 =
		ability_upgrades_counter == 3 &&
		GameUI.Player.GetSubscriptionTier(LOCAL_PLAYER_ID) < 1 &&
		selection_rarity == RARITY.COMMON;
	const locked_for_pick_by_supp_2 =
		ability_upgrades_counter == 3 &&
		GameUI.Player.GetSubscriptionTier(LOCAL_PLAYER_ID) < 2 &&
		selection_rarity != RARITY.COMMON;
	const tournament_mode_status = GameUI.GetOption("tournament_mode");

	upgrade_panel.SetHasClass("BLockedBySupp_1", locked_for_pick_by_supp_1 && !tournament_mode_status);
	upgrade_panel.SetHasClass("BLockedBySupp_2", locked_for_pick_by_supp_2 && !tournament_mode_status);

	upgrade_panel.IsFavorite = () => {
		return (
			upgrade_panel.BHasClass("BFavorite") &&
			!upgrade_panel.BHasClass("BLockedBySupp_1") &&
			!upgrade_panel.BHasClass("BLockedBySupp_2")
		);
	};

	if (upgrade_info.max_count) {
		const max_count = is_generic_upgrade ? upgrade_info.max_count : Number(upgrade_info.max_count / min_rarity);

		const upgrade_counter_progress_root = upgrade_panel.FindChildTraverse("UpgradeCounter_Progress_Root");
		const levels_from_upgrade = current_count + data.upgrade_rarity / min_rarity;

		for (let level = 0; level < max_count; level++) {
			const level_panel = $.CreatePanel("Panel", upgrade_counter_progress_root, "", {
				class: "UpgradeProgress_Level",
			});
			if (level < current_count) level_panel.AddClass("BLevelOwned");
			else if (level < levels_from_upgrade) level_panel.AddClass("BLevelFromUpgrade");
		}
	}

	CreateUpgrades(
		upgrade_info,
		upgrade_panel,
		additional_values_root,
		true,
		true,
		hero_idx,
		current_count,
		current_count + (is_generic_upgrade ? selection_rarity / min_rarity : selection_rarity),
		"AdditionalValue",
		null,
		null,
		true,
		false,
	);

	upgrade_panel.SetDialogVariable(
		"main_ability_name",
		$.Localize(`#DOTA_Tooltip_ability_${upgrade_info.ability_name}`).replace(":", ""),
	);
	upgrade_panel.SetDialogVariableInt("current_count", current_count);
	upgrade_panel.SetDialogVariableInt("new_upgrade_level", current_count + selection_rarity / min_rarity);

	const select_upgrade = () => {
		if (upgrade_panel.BHasClass("BLockedBySupp_1") || upgrade_panel.BHasClass("BLockedBySupp_2")) {
			GameUI.Collection.OpenSpecificTab("subscription");
			GameUI.Subscriptions.OpenAllSubscriptionBonuses();
		} else {
			ToggleShow(false, true);
			GameEvents.SendToServerEnsured("Upgrades:choose_upgrade", upgrade_info);

			HandleToast();
		}
	};

	upgrade_panel.SetPanelEvent("onactivate", select_upgrade);
	upgrade_panel.select_upgrade = select_upgrade;

	upgrade_panel.FindChildTraverse("FavoriteUpgradeButton").SetPanelEvent("onactivate", () => {
		GameUI.Upgrades.ToggleFavoriteUpgrade(upgrade_info.ability_name, upgrade_info.upgrade_name);
	});
}

const TRINKET_FX_COLORS_RGB = {
	1: ["rgb(178 189 208)", "rgb(200 215 240)"],
	2: ["rgb(86 147 210)", "rgb(56 131 208)"],
	4: ["rgb(221 50 163)", "rgb(245 162 255)"],
};

function GetTrinketFXColor(rarity, idx) {
	return TRINKET_FX_COLORS_RGB[rarity][idx].replace(/rgb\(|\)/g, "");
}

function ShowUpgrades(data) {
	const upgrades = data.upgrades;
	if (!upgrades) return;

	if (upgrades.selection_id == current_selection_id) return;
	HUD.ROOT.SetDialogVariableInt("upgrades_count", data.upgrades_count || 1);

	current_selection_id = upgrades.selection_id;
	current_rarity = upgrades.upgrade_rarity || 1;

	HUD.ROOT.SetHasClass("BLuckyTrinketUpgrade", !!upgrades.is_lucky_trinket_proc);
	HUD.ROOT.SetHasClass("BRerollRequestSent", false);

	HUD.UPGRADES_CONTAINER.RemoveAndDeleteChildren();
	ability_upgrades_counter = 0;
	HUD.ROOT.SwitchClass("rarity", `RARITY_${upgrades.upgrade_rarity || RARITY.COMMON}`);

	if (upgrades.upgrade_rarity) UpdatePanelHeaderText(HUD.UPGRADES_WRAPPER, upgrades);

	upgrades.is_lucky_trinket_proc = false;
	let delay = 0.15;

	for (const upgrade_info of Object.values(upgrades.choices)) {
		const upgrade_panel = $.CreatePanel(
			"Button",
			HUD.UPGRADES_CONTAINER,
			`UpgradeSelection_${upgrade_info.ability_name}_${upgrade_info.upgrade_name}`,
		);
		upgrade_panel.BLoadLayoutSnippet("Upgrade");
		upgrade_panel.AddClass(`Upgrade_${ability_upgrades_counter}`);

		MakeAbilityUpgradePanel(upgrade_panel, upgrade_info, upgrades);

		if (upgrades.is_lucky_trinket_proc) {
			upgrade_panel.AddClass("BHas_Trinket_FX");
			const trinket_fx = upgrade_panel.FindChildTraverse("Upgrade_Trinket_FX");
			const update_fx = () => {
				if (!trinket_fx.BHasClass("SceneLoaded")) {
					$.Schedule(0, update_fx);
					return;
				}
				trinket_fx.FireEntityInput(
					"trinket_glow",
					"SetControlPoint",
					`10: ${GetTrinketFXColor(upgrades.upgrade_rarity, 0)}`,
				);
				trinket_fx.FireEntityInput(
					"trinket_glow",
					"SetControlPoint",
					`11: ${GetTrinketFXColor(upgrades.upgrade_rarity, 1)}`,
				);
			};
			update_fx();
		}
		upgrade_panel.style.transitionDuration = delay + "s";
		upgrade_panel.style.transform = "translateX(0px)";
		delay += 0.15;
	}

	AutoSelectUpgrade();

	if (upgrades.reroll) Game.EmitSound("custom.reroll");

	UpdateRerollButton();
	ToggleShow(true);
	HandleToast();

	if (upgrades.is_lucky_trinket_proc && !upgrades.reroll) Game.EmitSound("ui.trophy_new");
}

function ToggleShow(state, upgradeSelected) {
	HUD.ROOT.SetHasClass("Show", state);
	if (upgradeSelected) {
		Game.EmitSound("General.ButtonClick");
		Game.EmitSound("custom.upgrade_selected");

		current_selection_id = "";
	} else {
		state ? Game.EmitSound("Shop.PanelUp") : Game.EmitSound("Shop.PanelDown");
	}
}

function ToggleUpgradesVisibility() {
	HUD.ROOT.ToggleClass("HideUpgrades");
	HandleToast();
}

function HandleToast() {
	$.Schedule(0, () => {
		DOTA_TOAST_MANAGER.SetHasClass("ShopOpen", HUD.ROOT.BHasClass("Show") && !HUD.ROOT.BHasClass("HideUpgrades"));
	});
}

function Reroll() {
	if (current_reroll_count >= current_rarity) {
		if (!HUD.ROOT.BHasClass("BRerollRequestSent")) {
			HUD.ROOT.SetHasClass("BRerollRequestSent", true);
			GameEvents.SendToServerEnsured("Upgrades:reroll", {});
		}
	} else {
		GameUI.Collection.Show();
		GameUI.Collection.OpenSubPanel("C_PayCurrency");
	}
}

function ClickBehaviorHandler() {
	$.Schedule(0.03, ClickBehaviorHandler);
	const in_target_mode =
		GameUI.GetClickBehaviors() != CLICK_BEHAVIORS.DOTA_CLICK_BEHAVIOR_NONE &&
		GameUI.GetClickBehaviors() != CLICK_BEHAVIORS.DOTA_CLICK_BEHAVIOR_LEARN_ABILITY;

	HUD.ROOT.hittestchildren = !in_target_mode;
	HUD.ROOT.SetHasClass(
		"AbilityCast",
		in_target_mode && !GameUI.Player.GetSettingValue("disable_transparent_upgrade_ui"),
	);
}

let current_reroll_items = 0;
function UpdateRerollButton() {
	// using consumable rerolls if amount of free are not enough to cover rarity
	const is_using_consumable_rerolls = current_reroll_count - current_reroll_items < current_rarity;
	const no_rerolls = current_reroll_count < current_rarity;

	HUD.REROLL_BUTTON.SetHasClass("is_using_consumable_rerolls", is_using_consumable_rerolls);

	let reroll_tooltip = "reroll_tooltip";
	if (no_rerolls) reroll_tooltip = "reroll_buy_in_shop_hint";
	else if (is_using_consumable_rerolls) reroll_tooltip = "reroll_tooltip_consumable";

	HUD.REROLL_BUTTON.SetPanelEvent("onmouseover", () => {
		$.DispatchEvent("DOTAShowTextTooltip", HUD.REROLL_BUTTON, `#${reroll_tooltip}`);
	});
}

function UpdatePlayerData(data) {
	let settings = {};
	if (data) settings = data.settings;
	else settings = GameUI.Player.GetSettings();

	if (settings) {
		if (settings.generic_from_subscription != undefined) {
			// HUD.ROOT.SetHasClass("BGenericUpgradeFromSub", settings.generic_from_subscription == 1);
			HUD.TOGGLE_GENERIC_FROM_SUB_BUTTON.SetSelected(settings.generic_from_subscription == 1);
		}
		if (settings.auto_select_favorites != undefined) {
			const state = settings.auto_select_favorites == 1;
			HUD.AS_TOGGLE_BUTTON.SetSelected(state);
			HUD.ROOT.SetHasClass("BAutoSelectFavorites", state);
		}
		if (settings.auto_select_favorites_delay != undefined) {
			as_current_time = settings.auto_select_favorites_delay;
			HUD.ROOT.SetDialogVariable("as_current_time", settings.auto_select_favorites_delay);
			AutoSelectUpgrade();
		}
	}

	const sub_tier = data.subscription && data.subscription.tier;
	if (!sub_tier) return;
	HUD.ROOT.SetHasClass("BHasSubscription", sub_tier > 0);

	HUD.UPGRADES_CONTAINER.Children().forEach((upgrade) => {
		if (upgrade.BHasClass("BLockedBySupp_1") && sub_tier >= 1) upgrade.RemoveClass("BLockedBySupp_1");
		if (upgrade.BHasClass("BLockedBySupp_2") && sub_tier >= 2) upgrade.RemoveClass("BLockedBySupp_2");
	});
}

function ToggleGenericFromSub(bool) {
	// GameUI.Player.SetSettingValue("generic_from_subscription", bool);
	GameUI.Player.SetSettingValue("generic_from_subscription", HUD.TOGGLE_GENERIC_FROM_SUB_BUTTON.IsSelected());
}
function ToggleAutoSelectFavirites() {
	const state = HUD.AS_TOGGLE_BUTTON.IsSelected();
	GameUI.Player.SetSettingValue("auto_select_favorites", state);

	AutoSelectUpgrade(!state);
}

function UpdateAutoSelectTime(operation) {
	if (operation == "+") as_current_time += as_time_step;
	else if (operation == "-") as_current_time -= as_time_step;

	GameUI.Player.SetSettingValue("auto_select_favorites_delay", Math.clamp(as_current_time, 0, 120));
}
function ResetAutoSelectTime() {
	HUD.ROOT.SetDialogVariable("as_time_step", as_time_step);
	HUD.ROOT.SetDialogVariable("as_current_time", as_current_time);
}
function MinimizeAutoSelect() {
	HUD.ROOT.ToggleClass("BMinimizeAutoSelectContainer");
}

function AutoSelectUpgrade(skip_re_animation) {
	if (auto_select_fav_schedule != undefined) auto_select_fav_schedule = $.CancelScheduled(auto_select_fav_schedule);

	if (HUD.ROOT.BHasClass("BAutoSelectFavorites")) {
		const current_selection_has_favorites = HUD.UPGRADES_CONTAINER.Children().find((upgrade) =>
			upgrade.IsFavorite(),
		);

		if (current_selection_has_favorites) {
			if (!skip_re_animation) HUD.AS_TIMER.style.animationDuration = `${-1}s`;
			HUD.AS_TIMER.style.animationDuration = `${as_current_time}s`;
		} else HUD.AS_TIMER.style.animationDuration = `${-1}s`;

		auto_select_fav_schedule = $.Schedule(as_current_time, () => {
			auto_select_fav_schedule = undefined;
			if (current_selection_id == "") return;

			for (const upgrade of HUD.UPGRADES_CONTAINER.Children()) {
				if (upgrade.IsFavorite()) {
					upgrade.select_upgrade();
					break;
				}
			}
		});
	}
}
(function () {
	ResetAutoSelectTime();
	HUD.ROOT.RemoveClass("BHasSubscription");
	HUD.UPGRADES_CONTAINER.RemoveAndDeleteChildren();
	HUD.ROOT.SetDialogVariableInt("upgrades_count", 0);

	const frame = GameEvents.NewProtectedFrame($.GetContextPanel());

	frame.SubscribeProtected("Upgrades:show_upgrades", ShowUpgrades);
	frame.SubscribeProtected("Upgrades:update_pending_count", (data) => {
		HUD.ROOT.SetDialogVariableInt("upgrades_count", data.upgrades_count || 0);
		GameEvents.SendToServerEnsured("Upgrades:get_upgrades", {});
	});
	GameEvents.SendToServerEnsured("Upgrades:get_upgrades", {});

	GameUI.Player.RegisterForPlayerDataChanges(UpdatePlayerData);

	$.RegisterForUnhandledEvent("DOTAHUDShopClosed", function () {
		HUD.ROOT.RemoveClass("ShopOpened");

		HandleToast();
	});

	$.RegisterForUnhandledEvent("DOTAHUDShopOpened", function () {
		HUD.ROOT.AddClass("ShopOpened");
	});
	SubscribeToNetTableKey("rerolls", Game.GetLocalPlayerID().toString(), function (rerolls) {
		HUD.REROLL_LABEL.text = `x${rerolls.count}`;
		current_reroll_count = rerolls.count;

		UpdateRerollButton();
	});

	GameUI.Inventory.RegisterForInventoryChanges(() => {
		current_reroll_items = GameUI.Inventory.GetItemCount("bp_reroll");

		if (GameUI.GetOption("tournament_mode")) current_reroll_items = 0;

		UpdateRerollButton();
	});

	ClickBehaviorHandler();
})();