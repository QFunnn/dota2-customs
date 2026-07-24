--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
let ability_tooltip;
let core_details;
let ad_label;
const EXTENDERS = {
    Shard: {},
    Scepter: {},
    DamageCategory: {},
    DamageFlags: {},
};
let last_ability_name;
let last_ability;
let last_unit;
let initialized = false;
function TooltipTextChanged(ability_name) {
    var _a, _b, _c, _d, _e, _f, _g;
    if (!ad_label || !ability_tooltip)
        return;
    // $.Msg("TooltipTextChanged call. Ability name = " + ability_name)
    const cfg = GameUI.CustomUIConfig();
    const ad_note_loc_token = `#DOTA_Tooltip_ability_${ability_name}_ability_note`;
    const sealingToken = "DOTA_AbilityTooltip_Sealing";
    const torturePipeToken = "DOTA_AbilityTooltip_TorturePipe";
    const noSpellAmpToken = "DOTA_AbilityTooltip_SkyStaff";
    let ad_note_loc_string = $.Localize(ad_note_loc_token);
    const ad_note_localized = ad_note_loc_token !== ad_note_loc_string && ad_note_loc_string !== "";
    const torturePipeExist = (_b = (_a = cfg.TorturePipeKv) === null || _a === void 0 ? void 0 : _a.has(ability_name)) !== null && _b !== void 0 ? _b : false;
    const noSpellAmpExist = (_d = (_c = cfg.NoSpellAmpKv) === null || _c === void 0 ? void 0 : _c.has(ability_name)) !== null && _d !== void 0 ? _d : false;
    const sealingAbilityExist = (_f = (_e = cfg.SealingAbilitiesKv) === null || _e === void 0 ? void 0 : _e.has(ability_name)) !== null && _f !== void 0 ? _f : false;
    const parts = [];
    if (ad_note_localized) {
        ad_note_loc_string = (_g = GameUI.ReplaceDOTAAbilitySpecialValues(ability_name, ad_note_loc_string)) !== null && _g !== void 0 ? _g : "";
        parts.push(ad_note_loc_string);
    }
    if (torturePipeExist) {
        parts.push($.Localize("#" + torturePipeToken));
    }
    if (noSpellAmpExist) {
        parts.push($.Localize("#" + noSpellAmpToken));
    }
    if (sealingAbilityExist) {
        parts.push($.Localize("#" + sealingToken));
    }
    const finalText = parts.join("<br><br>");
    ad_label.visible = parts.length > 0;
    if (parts.length > 0) {
        ad_label.SetDialogVariable("ability_draft_note", finalText);
    }
    ability_tooltip.SetHasClass("AbilityDraftDetails", parts.length > 0);
}
function Init() {
    const tooltip_manager = FindDotaHudElement("Tooltips");
    if (!tooltip_manager)
        return;
    ability_tooltip = tooltip_manager.FindChildTraverse("DOTAAbilityTooltip");
    if (!ability_tooltip)
        return;
    core_details = ability_tooltip.FindChildTraverse("AbilityCoreDetails");
    ad_label = ability_tooltip.FindChildTraverse("ADNote");
    CreateCustomAghsExtenders();
    initialized = true;
}
function CreateCustomAghsExtenders() {
    CreateAghPanelByType("Shard");
    CreateAghPanelByType("Scepter");
}
function SaveAghPanelInfo(type, panel) {
    var _a;
    EXTENDERS[type] = {
        panel,
        icon: panel.FindChildTraverse(`AghsStatus${type}Icon`),
        scene: panel.FindChildTraverse(`AghsStatus${type}Scene`),
        header: (_a = panel.GetChild(0)) === null || _a === void 0 ? void 0 : _a.GetChild(1),
        icon_path: `url("s2r://panorama/images/hud/reborn/aghsstatus_${type.toLowerCase()}_psd.vtex")`,
    };
}
function CreateAghPanelByType(type) {
    // $.Msg("CreateAghPanelByType call. type = " + type)
    if (!core_details)
        return;
    const ex_panel = core_details.FindChildTraverse(`Custom${type}UpgradeDescription`);
    if (ex_panel) {
        SaveAghPanelInfo(type, ex_panel);
        return;
    }
    const default_upgrades = core_details.FindChildTraverse(`${type}UpgradeDescription`);
    if (default_upgrades)
        default_upgrades.visible = false;
    const panel = $.CreatePanel("Panel", core_details, `Custom${type}UpgradeDescription`);
    panel.BLoadLayout("file://{resources}/layout/dota_ui_aghs_description.xml", false, false);
    core_details.MoveChildAfter(panel, core_details.FindChildTraverse("ShardUpgradeDescription"));
    $.CreatePanel("Panel", panel, "").BLoadLayoutSnippet(`Inline${type}Header`);
    $.CreatePanel("Panel", panel, "").BLoadLayoutSnippet("AghsScepterSnippet");
    const costs = panel.FindChildTraverse("AbilityCosts");
    if (costs)
        costs.AddClass("Hidden");
    panel.AddClass(`Inline${type}Description`);
    SaveAghPanelInfo(type, panel);
}
function PopulateAghByType(ability_name, ability, unit, type) {
    var _a, _b;
    const type_lc = type.toLowerCase();
    const kv = Abilities.GetAbilityKV(ability_name);
    // $.Msg("KV = " + JSON.stringify(kv, null, "\t"))
    const loc_token = `#DOTA_Tooltip_ability_${ability_name}_${type_lc}_description`;
    let loc_text = $.Localize(loc_token);
    // $.Msg(`Loc text = ${loc_text}`)
    const is_localized = loc_token != loc_text && loc_text != "";
    const ext = EXTENDERS[type];
    if (!ext.panel || !ext.header)
        return;
    if (unit == -1 || Entities[`Has${type}`](unit)) {
        ext.panel.AddClass(`HeroHas${type}`);
        ext.header.style.color = "gradient(linear, 0% 0%, 40% 0%, from(#62cdff), to(#658CF8));";
    }
    else {
        ext.panel.RemoveClass(`HeroHas${type}`);
        ext.header.ClearPropertyFromCode("color");
    }
    const panel = ext.panel;
    if (is_localized && kv && kv[`Has${type}Upgrade`] == 1) {
        // $.Msg(loc_text)
        loc_text = Abilities.ReplaceAbilityValues(loc_text, ability_name, ability, [`special_bonus_${type_lc}`,]); // кароче тут дрочь какая то, сначала кастомным проходимся реплейсером
        loc_text = GameUI.ReplaceDOTAAbilitySpecialValues(ability_name, loc_text); //потом нативным проходимся
        panel.SetDialogVariable("scepter_upgrade_description", loc_text);
        panel.RemoveClass("Hidden");
    }
    else if (kv && kv[`AbilityDraftUlt${type}Ability`]) {
        const granted_ability_name = kv[`AbilityDraftUlt${type}Ability`];
        panel.SetDialogVariableLocString("scepter_ability_name", `dota_tooltip_ability_${granted_ability_name}`);
        loc_text = $.Localize("scepter_description_new_ability", panel);
        panel.SetDialogVariable("scepter_upgrade_description", loc_text);
        panel.RemoveClass("Hidden");
        (_a = panel.GetChild(1)) === null || _a === void 0 ? void 0 : _a.SetHasClass("HasAbilitySpecialKeys", false);
        return;
    }
    else {
        panel.AddClass("Hidden");
    }
    const values = Object.entries(Abilities.GetAbilityValues(ability_name))
        .filter(([name, data]) => name.includes(type_lc) || data[`special_bonus_${type_lc}`] || data[`Requires${type}`] == 1)
        .map(([name]) => Abilities.PrintSpecialValueLine(ability_name, ability, name, [`special_bonus_${type_lc}`]))
        .filter(Boolean)
        .sort();
    (_b = panel.GetChild(1)) === null || _b === void 0 ? void 0 : _b.SetHasClass("HasAbilitySpecialKeys", values.length > 0);
    panel.SetDialogVariable("scepter_ability_keys", values.join("<br>"));
}
function PopulateShardUpgradeDescription(ability_name, ability, unit) {
    PopulateAghByType(ability_name, ability, unit, "Shard");
}
function PopulateScepterUpgradeDescription(ability_name, ability, unit) {
    PopulateAghByType(ability_name, ability, unit, "Scepter");
}
function OnItemTooltipEntityIndex(panel, entIndex, invSlot) {
    // $.Msg("OnItemTooltipEntityIndex call")
    const ability = Entities.GetItemInSlot(entIndex, invSlot);
    const ability_name = Abilities.GetAbilityName(ability);
    if (!initialized)
        Init();
    if (!initialized) {
        $.Schedule(0.01, () => OnItemTooltipEntityIndex(panel, entIndex, invSlot));
        return;
    }
    last_ability_name = ability_name;
    last_ability = ability;
    last_unit = entIndex;
    UpdateTooltip();
}
function OnAbilityTooltip(panel, ability_name) {
    var _a, _b;
    // $.Msg("OnAbilityTooltip call")
    if (!initialized)
        Init();
    if (!initialized) {
        $.Schedule(0.01, () => OnAbilityTooltip(panel, ability_name));
        return;
    }
    const shardExt = EXTENDERS.Shard;
    const scepterExt = EXTENDERS.Scepter;
    (_a = shardExt.icon) === null || _a === void 0 ? void 0 : _a.ClearPropertyFromCode("background-image");
    (_b = scepterExt.icon) === null || _b === void 0 ? void 0 : _b.ClearPropertyFromCode("background-image");
    last_ability_name = ability_name;
    last_ability = -1;
    last_unit = -1;
    UpdateTooltip();
}
function OnAbilityTooltipEntityIndex(panel, ability_name, unit) {
    // $.Msg(`OnAbilityTooltipEntityIndex call. AbName = ${JSON.stringify(ability_name, null, "\t")}. unit = ${unit}`)
    const ability = Entities.GetAbilityByName(unit, ability_name);
    if (!initialized)
        Init();
    if (!initialized) {
        $.Schedule(0.01, () => OnAbilityTooltipEntityIndex(panel, ability_name, unit));
        return;
    }
    last_ability_name = ability_name;
    last_ability = ability !== null && ability !== void 0 ? ability : -1;
    last_unit = unit;
    UpdateTooltip();
}
function UpdateTooltip() {
    // $.Msg("UpdateTooltip call")
    if (!last_ability_name)
        return;
    const unit = last_unit || -1;
    const ability = last_ability || -1;
    TooltipTextChanged(last_ability_name);
    PopulateShardUpgradeDescription(last_ability_name, ability, unit);
    PopulateScepterUpgradeDescription(last_ability_name, ability, unit);
}
function HideCustomDescriptions() {
    if (!ability_tooltip)
        return;
    Object.values(EXTENDERS).forEach((extender) => {
        var _a;
        const e = (_a = extender.panel) !== null && _a !== void 0 ? _a : extender.label;
        if (e)
            e.AddClass("Hidden");
    });
    ability_tooltip.RemoveClass("AbilityDraftDetails");
}
(function () {
    // $.Msg("AbilityTooltip init started.")
    $.RegisterForUnhandledEvent("DOTAShowAbilityTooltipForLevel", OnAbilityTooltip);
    $.RegisterForUnhandledEvent("DOTAShowAbilityTooltip", OnAbilityTooltip);
    //@ts-ignore
    $.RegisterForUnhandledEvent("DOTAShowAbilityTooltipForEntityIndex", OnAbilityTooltipEntityIndex);
    $.RegisterForUnhandledEvent("DOTAShowAbilityShopItemTooltip", OnAbilityTooltip);
    $.RegisterForUnhandledEvent("DOTAShowDroppedItemTooltip", HideCustomDescriptions);
    $.RegisterForUnhandledEvent("DOTAShowAbilityInventoryItemTooltip", OnItemTooltipEntityIndex);
    GameEvents.SubscribeUnprotected("dota_portrait_unit_stats_changed", () => {
        // $.Msg("dota_portrait_unit_stats_changed call")
        if (last_ability_name && (ability_tooltip === null || ability_tooltip === void 0 ? void 0 : ability_tooltip.BHasClass("TooltipVisible")))
            UpdateTooltip();
    });
    GameEvents.SubscribeUnprotected("dota_ability_changed", (event) => {
        // $.Msg("dota_ability_changed call")
        if (ability_tooltip && ability_tooltip.IsValid() && last_ability == event.entityIndex && ability_tooltip.BHasClass("TooltipVisible"))
            UpdateTooltip();
    });
})();