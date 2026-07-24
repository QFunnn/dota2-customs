--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let ability_tooltip, default_scepter, default_shard, aghs_tooltips;

let AGHS_CONTAINERS = {
	Scepter: undefined,
	Shard: undefined,
};
let DEFAULT_ABILITY_HINTS = {
	Default: undefined,
	Scepter: undefined,
	Shard: undefined,
	Innate: undefined,
	Innate_Status: undefined,
};
let TOOLTIPS_NON_PREGEN = {
	Innate: "DOTAHUDInnateTooltip",
	Innate_Status: "DOTAHUDInnateStatusTooltip",
};
function IsDefaultType(type) {
	return type == "Default";
}

let last_ability_name, last_selected_portrait;
let cached_ability_name = "none";
let initialized = false;
let AOE_ABILITIES = {};
let BOSS_ITEMS_INFO = {};

function GetBossDropSourceHint(ability_name) {
	let boss_drop_source = "";
	let existed_bosses = {};

	// let process_boss_source_hint = (type) => {
	// 	const info = BOSS_ITEMS_INFO?.[ability_name]?.[type];
	// 	if (!info || Object.keys(info).length == 0) return;
	//
	// 	let is_inited_header = false;
	// 	Object.entries(info).forEach(([boss_name, value]) => {
	// 		if (existed_bosses[boss_name]) return;
	// 		existed_bosses[boss_name] = true;
	//
	// 		if (!is_inited_header) {
	// 			boss_drop_source += `<br><b><font color='white'>${$.Localize(`boss_source_${type}_item`)}</font></b>`;
	// 			is_inited_header = true;
	// 		}
	//
	// 		boss_drop_source += `<br><img src='file://{images}/custom_game/tooltip_extender/${boss_name}_icon.png'> ${$.Localize(
	// 			`boss_source_${boss_name}`,
	// 		)}`;
	//
	// 		// if (type == "random") boss_drop_source += ` - ${value}%`;
	// 	});
	// };
	// process_boss_source_hint("required");
	// process_boss_source_hint("random");

	// boss_drop_source.replaceAll("<br><br>", "<br>");

	return BOSS_ITEMS_COST[ability_name];
}

function GetRescaleSpellAmpHint(panel, ability_name) {
	const tune_pct = TOOLTIP_EXTENDER_PREGEN.spell_amp_tune[ability_name];
	if (tune_pct > 0) {
		panel.SetDialogVariable("spell_amp_tune", tune_pct * 100);
		return $.Localize("custom_ability_hint_RescaledSpellAmp_Value", panel);
	}
	return $.Localize("custom_ability_hint_RescaledSpellAmp_None");
}

function UpdateAbilityInnateDetailsAghUgprades(panel, extender, default_container, type, ability_name, post_callback) {
	const current_selected_portrait = Players.GetLocalPlayerPortraitUnit();

	if (last_ability_name == ability_name && last_selected_portrait == current_selected_portrait) return;

	$.Schedule(0.016, () => {
		if (!extender.IsValid()) return;
		extender.RemoveAndDeleteChildren();

		if (!default_container.IsValid()) return;

		for (const p of default_container.Children()) p.SetParent(extender);

		extender.SetHasClass(`Hidden`, default_container.BHasClass(`Hidden`));
		extender.SetHasClass(`NoUpgrade`, default_container.BHasClass(`NoUpgrade`));
		extender.SetHasClass(`Inline${type}Description`, default_container.BHasClass(`Inline${type}Description`));

		CreateDynamicAghHints(type, extender, current_selected_portrait);

		panel.te_lock = true;
		last_ability_name = ability_name;
		last_selected_portrait = current_selected_portrait;

		post_callback();
	});
}

function UpdateTooltip(event_name, panel, ability_name, force_local_hero, ...event_args) {
	let current_selected_portrait = Players.GetLocalPlayerPortraitUnit();
	if (force_local_hero) current_selected_portrait = Players.GetPlayerSelectedHero(LOCAL_PLAYER_ID);

	if (panel.te_lock) {
		panel.te_lock = false;
		return;
	}

	let is_has_hint = false;
	for (let [type, extender] of Object.entries(DEFAULT_ABILITY_HINTS)) {
		if (!extender || !extender.IsValid()) continue;

		const hint_loc_key = `${ability_name}_CustomHint${IsDefaultType(type) ? "" : `_${type}`}`;
		let hint_loc = $.Localize(hint_loc_key);

		const checks = InitTooltipChecks(ability_name);
		const aoe_scaling_hint = GetAOEScalingHint(extender, ability_name, current_selected_portrait);

		if (IsDefaultType(type)) {
			if (custom_abilities_list.includes(ability_name)) checks.is_custom = true;
			if (hint_loc_key != hint_loc) checks.is_has_details = true;
			if (aoe_scaling_hint) checks.is_aoe_scaling = true;

			if (Object.values(checks).every((value) => !value)) {
				extender.visible = false;
				continue;
			}
		}

		is_has_hint = true;

		if (type == "Scepter" || type == "Shard") {
			let default_container = type == "Scepter" ? default_scepter : default_shard;

			UpdateAbilityInnateDetailsAghUgprades(panel, extender, default_container, type, ability_name, () => {
				if (panel.BHasHoverStyle()) $.DispatchEvent(event_name, ...event_args);
			});
		} else extender.visible = true;

		PostProgressTooltip(extender, ability_name, hint_loc, checks, aoe_scaling_hint);
	}

	if (!is_has_hint) {
		last_ability_name = ability_name;
		last_selected_portrait = current_selected_portrait;
	}
}

let tooltip_manager;
function CreateExtender(type, tooltip, parent_name = "AbilityCoreDetails", sorter_idx, sub_parent_name) {
	let sub_parent = tooltip;
	if (sub_parent_name) sub_parent = tooltip.FindChildTraverse(sub_parent_name);

	const core_details = sub_parent.FindChildTraverse(parent_name);

	let extra_info = core_details.FindChildTraverse("AbilityExtraDescription");
	if (sorter_idx != undefined) extra_info = core_details.GetChild(sorter_idx);

	if (!extra_info) return;

	const default_hint = $.CreatePanel("Panel", HUD.TEMP_CONTAINER, `TE_Static_Default_${type}`);
	default_hint.BLoadLayoutSnippet("TEB_AbilityHint");
	default_hint.SetDialogVariableLocString("te_header", `custom_ability_hint_Default`);

	const ex_default_hint = core_details.FindChildTraverse(`TE_Static_Default_${type}`);
	if (ex_default_hint) ex_default_hint.DeleteAsync(0);

	default_hint.SetParent(core_details);
	core_details.MoveChildAfter(default_hint, extra_info);

	DEFAULT_ABILITY_HINTS[type] = default_hint;

	return core_details;
}

function InitNonPregeneratedTooltip(type) {
	tooltip_manager = FindDotaHudElement("Tooltips");
	if (!tooltip_manager) return;

	if (typeof TOOLTIPS_NON_PREGEN[type] != "string") return;

	const focus_tooltip = tooltip_manager.FindChildTraverse(TOOLTIPS_NON_PREGEN[type]);
	let sorder_idx, parent_tooltip_name, sub_parent_name;

	if (type == "Innate_Status") sub_parent_name = "InnateAbilityDetails";

	if (focus_tooltip) {
		TOOLTIPS_NON_PREGEN[type] = focus_tooltip;
		CreateExtender(type, focus_tooltip, parent_tooltip_name, sorder_idx, sub_parent_name);
	}
}

function InitStaticTooltipExtender() {
	if (initialized) return;

	tooltip_manager = FindDotaHudElement("Tooltips");

	if (!tooltip_manager) return;

	ability_tooltip = tooltip_manager.FindChildTraverse("DOTAAbilityTooltip");
	default_scepter = ability_tooltip?.FindChildTraverse("ScepterUpgradeDescription");
	default_shard = ability_tooltip?.FindChildTraverse("ShardUpgradeDescription");
	if (!ability_tooltip || !default_scepter || !default_shard) return;

	const core_details = CreateExtender("Default", ability_tooltip);
	const create_custom_agh_container = (type, default_container) => {
		const ex_container = core_details.FindChild(`CustomAghsDescription_${type}`);
		if (ex_container) ex_container.DeleteAsync(0);

		const container = $.CreatePanel("DOTAAghsDescription", core_details, `CustomAghsDescription_${type}`);
		core_details.MoveChildAfter(container, default_container);
		DEFAULT_ABILITY_HINTS[type] = container;
		default_container.visible = false;
	};

	create_custom_agh_container("Scepter", default_scepter);
	create_custom_agh_container("Shard", default_shard);

	initialized = true;
}

function InitTooltipChecks(ability_name) {
	return {
		is_custom: false,
		is_has_details: false,
		is_aoe_scaling: false,
		is_boss_drop: BOSS_ITEMS_COST[ability_name] != undefined,
		is_shift_consumable: SHIFT_INSTA_CONSUMABLE.includes(ability_name),
		is_rescaled_spell_amp: TOOLTIP_EXTENDER_PREGEN?.spell_amp_tune?.[ability_name] != undefined,
	};
}
function PostProgressTooltip(tooltip_extender, ability_name, hint_loc, checks, aoe_scaling_hint) {
	hint_loc = GameUI.ReplaceDOTAAbilitySpecialValues(ability_name, hint_loc);

	tooltip_extender.SetDialogVariableLocString(
		"te_header",
		`custom_ability_hint_${checks.is_boss_drop ? "BossDrop" : "Default"}`,
	);

	tooltip_extender.SetDialogVariable("te_custom_hint", hint_loc);
	tooltip_extender.SetDialogVariable("aoe_scaling_hint", aoe_scaling_hint);

	if (checks.is_boss_drop) {
		// tooltip_extender.SetDialogVariable("boss_item_source", GetBossDropSourceHint(ability_name));
		tooltip_extender.SetDialogVariable("boss_currency_cost", GetBossDropSourceHint(ability_name));
	}
	if (checks.is_rescaled_spell_amp)
		tooltip_extender.SetDialogVariable(
			"spell_amp_tune_hint",
			GetRescaleSpellAmpHint(tooltip_extender, ability_name),
		);

	for (const [check_name, v_boolean] of Object.entries(checks))
		tooltip_extender.SetHasClass(`Check_${check_name}`, v_boolean);
}
function CreateDynamicAghHints(type, container, current_selected_portrait) {
	let b_has_upgrade = false;
	for (const tooltip_item of container.Children()) {
		if (!tooltip_item.BHasClass("InsetContainer")) continue;

		const ability_image = tooltip_item.FindChildTraverse("ScepterAbilityImage");
		const ability_name = ability_image.abilityname;

		const checks = InitTooltipChecks(ability_name);

		const aoe_scaling_hint = GetAOEScalingHint(container, ability_name, current_selected_portrait);

		let hint_loc_key = `${ability_name}_CustomHint_${type.toLowerCase()}`;
		let hint_loc = $.Localize(hint_loc_key);

		if (hint_loc_key != hint_loc && !hint_loc.startsWith("#")) checks.is_has_details = true;

		if (tooltip_item.BHasClass("GrantedAbility")) {
			if (custom_abilities_list.includes(ability_name)) checks.is_custom = true;
			hint_loc_key = `${ability_name}_CustomHint`;
		}

		if (aoe_scaling_hint) checks.is_aoe_scaling = true;

		if (Object.values(checks).some(Boolean)) {
			const focus_container = GetChildByPath(tooltip_item, 0, 1);
			const sort_child = focus_container.GetChild(1);

			const ex_te_scepter = focus_container.FindChildTraverse(`TE_${type}_${ability_name}`);
			if (ex_te_scepter) continue;

			b_has_upgrade = true;

			let te_scepter = $.CreatePanel("Panel", HUD.TEMP_CONTAINER, `TE_${type}_${ability_name}`);
			te_scepter.BLoadLayoutSnippet("TEB_AbilityHint");
			te_scepter.SetParent(focus_container);
			te_scepter.AddClass("AghHint");

			focus_container.MoveChildAfter(te_scepter, sort_child);

			if (hint_loc.startsWith("-")) {
				focus_container.Children().forEach((c) => {
					if (c != te_scepter) c.visible = false;
				});
				focus_container.style.padding = "0px 4px;";

				if (hint_loc.startsWith("--") && current_selected_portrait) container.SetHasClass(`Hidden`, true);

				hint_loc = hint_loc.replace(/^-*/, "");
			}

			PostProgressTooltip(te_scepter, ability_name, hint_loc, checks, aoe_scaling_hint);
		}
	}
	return b_has_upgrade;
}

function InitAghsTooltips() {
	aghs_tooltips = FindDotaHudElement("DOTAHUDAghsStatusTooltip");
	if (!aghs_tooltips) return void $.Schedule(0.5, InitAghsTooltips);

	const scepter_container = aghs_tooltips.FindChildTraverse("AghsScepterContainer1");
	const shard_container = aghs_tooltips.FindChildTraverse("AghsShardContainer1");

	if (!scepter_container || !shard_container) return void $.Schedule(0.5, InitAghsTooltips);

	AGHS_CONTAINERS.Scepter = scepter_container;
	AGHS_CONTAINERS.Shard = shard_container;
}

function OnAghsTooltip(panel, hero_id) {
	if (!AGHS_CONTAINERS.Scepter || !AGHS_CONTAINERS.Shard)
		return void $.Schedule(0.1, OnAghsTooltip.bind(undefined, panel, hero_id));

	if (panel.te_lock) {
		panel.te_lock = false;
		return;
	}

	$.Schedule(0, () => {
		if (!panel.IsValid()) return;
		aghs_tooltips.ClearPropertyFromCode("margin");
		aghs_tooltips.ClearPropertyFromCode("position");
		const scepter_upgarde = CreateDynamicAghHints("Scepter", AGHS_CONTAINERS.Scepter);
		const shard_upgrade = CreateDynamicAghHints("Shard", AGHS_CONTAINERS.Shard);

		if (!aghs_tooltips.BHasClass("TooltipVisible")) return;

		panel.te_lock = true;
		$.DispatchEvent("DOTAHUDShowAghsStatusTooltip", panel, -1, hero_id);
		$.Schedule(0, () => {
			if (!scepter_upgarde && !shard_upgrade) return;
			const pos = aghs_tooltips.GetPositionWithinWindow();
			const bottom_space = Game.GetScreenHeight() - aghs_tooltips.actuallayoutheight - pos.y;

			const is_bottom = aghs_tooltips.BHasClass("TooltipPositionBottom");

			const extra_space = (100 * is_bottom ? -1 : 1) - bottom_space;
			if (extra_space > 0) aghs_tooltips.style.marginTop = `-${extra_space}px`;
		});
	});
}

function OnAbilityTooltip(event_name, panel, ability_name, force_local_hero, ...event_args) {
	if (!initialized) {
		InitStaticTooltipExtender();
		return void $.Schedule(0.01, () =>
			OnAbilityTooltip(event_name, panel, ability_name, force_local_hero, ...event_args),
		);
	}

	UpdateTooltip(event_name, panel, ability_name, force_local_hero, ...event_args);
}

function TryInvokeNonPregenCallback(type, event_name, callback, ...args) {
	if (typeof TOOLTIPS_NON_PREGEN[type] != "object") {
		InitNonPregeneratedTooltip(type);
		return void $.Schedule(0.01, TryInvokeNonPregenCallback.bind(undefined, type, event_name, callback, ...args));
	}
	callback(event_name, ...args);
}
function RegisterNonPregenTooltip(event_name, callback, type) {
	$.RegisterForUnhandledEvent(event_name, (...args) => {
		if (RootParentCheck(args[0], "DotaDashboard")) return;
		TryInvokeNonPregenCallback(type, event_name, callback, ...args);
	});
}

//P0 = panel idx, P1 = ability_name idx
function RegisterDefaultTooltip(event_name, points, force_local_hero) {
	$.RegisterForUnhandledEvent(event_name, (...args) => {
		const panel = args[points[0]];
		let ability_name = args[points[1]];
		const unit_entity_id = args[points[2]];
		const item_slot = args[points[3]];

		if (item_slot != undefined && unit_entity_id != undefined) {
			const item = Entities.GetItemInSlot(unit_entity_id, item_slot);
			ability_name = Abilities.GetAbilityName(item);
		}

		if (!ability_name) return;

		OnAbilityTooltip(event_name, panel, ability_name, force_local_hero, ...args);
	});
}

function RegisterHandleTooltip(event_name, panel, type, callback) {
	const b_ex_callback = panel.tooltip_extender_callback != undefined;

	panel.tooltip_extender_callback = () => {
		const portrait_unit = Players.GetLocalPlayerPortraitUnit();
		if (!portrait_unit || portrait_unit == -1) return;

		const hero_name = Entities.GetUnitName(portrait_unit);
		const hero_id = GetHeroID(hero_name);

		TryInvokeNonPregenCallback(
			type,
			event_name,
			() => {
				callback(event_name, panel, hero_id, -1, type);
			},
			panel,
		);
	};

	if (b_ex_callback) return;

	$.RegisterEventHandler(event_name, panel, () => {
		panel.tooltip_extender_callback();
	});
}

function RegisterLowerHUDHandleTooltips() {
	const innate_lower_hud = FindDotaHudElement("ContentsContainer");
	if (!innate_lower_hud) return void $.Schedule(0.1, RegisterLowerHUDHandleTooltips);

	const innate_button = innate_lower_hud.GetChild(2);

	if (!innate_button) return void $.Schedule(0.1, RegisterLowerHUDHandleTooltips);

	// InitNonPregeneratedTooltip("Innate");
	RegisterHandleTooltip("DOTAShowInnateDisplayTooltip", innate_button, "Innate_Status", OnInnateTooltip);
}

function InitTooltipExtender() {
	last_selected_portrait = Players.GetLocalPlayerPortraitUnit();
	InitAghsTooltips();
	HUD.TEMP_CONTAINER.RemoveAndDeleteChildren();
	RegisterDefaultTooltip("DOTAShowAbilityTooltip", [0, 1]);
	RegisterDefaultTooltip("DOTAShowAbilityTooltipForEntityIndex", [0, 1]);
	RegisterDefaultTooltip("DOTAShowAbilityTooltipForHero", [0, 1]);
	RegisterDefaultTooltip("DOTAShowAbilityShopItemTooltip", [0, 1], true);
	RegisterDefaultTooltip("DOTAShowDroppedItemTooltip", [0, 3], true);
	RegisterDefaultTooltip("DOTAShowAbilityInventoryItemTooltip", [0, undefined, 1, 2]);
	$.RegisterForUnhandledEvent("DOTAHUDShowAghsStatusTooltip", OnAghsTooltip);
	RegisterNonPregenTooltip("DOTAShowInnateTooltip", OnInnateTooltip, "Innate");
	RegisterLowerHUDHandleTooltips();
}

function convertToHexString(first, second) {
	const firstHex = first.toString(16).padStart(2, "0");
	const secondHex = second.toString(16).padStart(2, "0");
	const middleZeroes = "0".repeat(10 - firstHex.length - secondHex.length);
	return (firstHex + middleZeroes + secondHex).toUpperCase();
}

let INNATE_DETAILS = {
	Scepter: undefined,
	Shard: undefined,
	Scepter_Default: undefined,
	Shard_Default: undefined,
};
let innate_details_requested,
	innate_details_inited = false;

function InitInnateStatusUpgradesExtenders() {
	const innate_tooltip = TOOLTIPS_NON_PREGEN.Innate_Status;
	if (typeof innate_tooltip == "string") return void $.Schedule(0, InitInnateStatusUpgradesExtenders);

	const innate_core_details = innate_tooltip
		?.FindChildTraverse("InnateAbilityDetails")
		?.FindChildTraverse("AbilityCoreDetails");

	if (!innate_core_details) return void $.Schedule(0, InitInnateStatusUpgradesExtenders);

	INNATE_DETAILS.Scepter_Default = innate_core_details?.FindChildTraverse("ScepterUpgradeDescription");
	INNATE_DETAILS.Shard_Default = innate_core_details?.FindChildTraverse("ShardUpgradeDescription");

	if (!INNATE_DETAILS.Scepter_Default || !INNATE_DETAILS.Shard_Default)
		return void $.Schedule(0, InitInnateStatusUpgradesExtenders);

	const create_custom_agh_container = (type, default_container) => {
		const ex_container = innate_core_details.FindChild(`CustomAghsDescription_${type}`);
		if (ex_container) ex_container.DeleteAsync(0);

		const container = $.CreatePanel("DOTAAghsDescription", innate_core_details, `CustomAghsDescription_${type}`);
		innate_core_details.MoveChildAfter(container, default_container);
		INNATE_DETAILS[type] = container;
		default_container.visible = false;
	};

	create_custom_agh_container("Scepter", INNATE_DETAILS.Scepter_Default);
	create_custom_agh_container("Shard", INNATE_DETAILS.Shard_Default);

	innate_details_inited = true;
}

function UpdateInnateStatusUpgrades(panel, event_name, loc_token) {
	if (!innate_details_requested) InitInnateStatusUpgradesExtenders();
	innate_details_requested = true;

	if (!innate_details_inited)
		return void $.Schedule(0, UpdateInnateStatusUpgrades.bind(undefined, panel, event_name));

	for (const type of ["Scepter", "Shard"]) {
		const extender = type == "Scepter" ? INNATE_DETAILS.Scepter : INNATE_DETAILS.Shard;
		const default_container = type == "Scepter" ? INNATE_DETAILS.Scepter_Default : INNATE_DETAILS.Shard_Default;

		UpdateAbilityInnateDetailsAghUgprades(panel, extender, default_container, type, loc_token, () => {
			if (panel.BHasHoverStyle()) $.DispatchEvent(event_name, panel);
		});
	}
}
function NonDefaultTooltipHandler(panel, hero_id, type, event_name, loc_line_func) {
	if (!DEFAULT_ABILITY_HINTS[type] || !DEFAULT_ABILITY_HINTS[type].IsValid())
		return void $.Schedule(
			0,
			NonDefaultTooltipHandler.bind(undefined, panel, hero_id, type, event_name, loc_line_func),
		);

	if (panel.te_lock) {
		panel.te_lock = false;
		return;
	}

	const loc_token = loc_line_func(hero_id);
	const loc_line = $.Localize(loc_token);
	const is_visible = loc_token != loc_line;

	DEFAULT_ABILITY_HINTS[type].visible = is_visible;
	DEFAULT_ABILITY_HINTS[type].SetDialogVariable(`extender_hint`, loc_line);
	DEFAULT_ABILITY_HINTS[type].SetHasClass(`Check_is_${type}_details`, is_visible);
	$.Schedule(0, () => {
		if (!panel.IsValid()) return;

		if (!TOOLTIPS_NON_PREGEN[type].BHasClass("TooltipVisible")) return;

		panel.te_lock = true;
		if (type.includes("Status")) {
			if (type == "Innate_Status") UpdateInnateStatusUpgrades(panel, event_name, loc_token);
			else $.DispatchEvent(event_name, panel);
		}
	});
}

function OnInnateTooltip(event_name, panel, hero_id, _, type = "Innate") {
	NonDefaultTooltipHandler(panel, hero_id, type, event_name, (hero_id) => {
		return `${INNATES[GetHeroName(hero_id)] || ""}_CustomHint`;
	});
}
function GetAOEScalingHint(panel, ability_name, hero_idx) {
	const condition = AOE_ABILITIES[ability_name];
	if (!condition) return;

	panel.SetDialogVariable("reduced_damage", Math.abs(typeof condition == "number" ? condition : condition.value));
	let basic_hint = $.Localize("ability_aoe_scaling_basic_hint", panel);

	if (typeof condition == "number") return basic_hint;

	let conditions = "";
	if (condition.shard) conditions += $.Localize("ability_aoe_scaling_shard", panel);
	if (condition.scepter) conditions += $.Localize("ability_aoe_scaling_scepter", panel);
	if (condition.talent) {
		HUD.TEMP_LABEL.text = "";
		GameUI.SetupDOTATalentNameLabel(HUD.TEMP_LABEL, condition.talent);

		panel.SetDialogVariable("talent", HUD.TEMP_LABEL.text);
		conditions += $.Localize("ability_aoe_scaling_talent", panel);
	}
	if (condition.modifier) {
		panel.SetDialogVariable("modifier_name", $.Localize(`DOTA_Tooltip_${condition.modifier}`, panel));
		conditions += $.Localize("ability_aoe_scaling_modifier", panel);
	}

	if (conditions != "") {
		basic_hint += "<br>";
		basic_hint += conditions;
		return basic_hint;
	}
}

function InitAOEAbilities() {
	if (!TOOLTIP_EXTENDER_PREGEN?.aoe_abilities) return;

	AOE_ABILITIES = TOOLTIP_EXTENDER_PREGEN.aoe_abilities;
	Object.values(TOOLTIP_EXTENDER_PREGEN.aoe_abilities).forEach((def) => {
		if (typeof def == "number") return;
		if (def.localization_source) AOE_ABILITIES[def.localization_source] = def;
	});
}
function InitBossItems() {
	if (!TOOLTIP_EXTENDER_PREGEN?.boss_items) return;

	Object.entries(TOOLTIP_EXTENDER_PREGEN.boss_items).forEach(([boss_name, def]) => {
		const process_items = (type, key) => {
			if (!def[type]) return;
			Object.entries(def[type]).forEach(([name, value]) => {
				if (BOSS_DROP_ITEMS_EXCEPTIONS.includes(name)) return;

				BOSS_ITEMS_INFO[name] ??= {
					required: {},
					random: {},
				};

				BOSS_ITEMS_INFO[name][type][boss_name] = value[key] || value;
			});
		};
		process_items("required");
		process_items("random", "chance");
	});
}
function UpdateDefinition() {
	InitAOEAbilities();
	InitBossItems();
	InitTooltipExtender();
}

(function () {
	UpdateDefinition();
})();