--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
const matchAll = (string, regexp) => {
    const matches = [];
    let match;
    while ((match = regexp.exec(string)) !== null)
        matches.push(match);
    return matches;
};
const replaceAll = (string, searchValue, replaceValue) => {
    const regexp = searchValue instanceof RegExp
        ? searchValue
        : new RegExp(searchValue.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), 'g');
    return string.replace(regexp, replaceValue);
};

const exception =
{
   "item_ward_observer": true,
   "item_ward_sentry": true,
   "item_dust": true,
   "item_smoke_of_deceit": true,
}


class AbilityDifferences {
    constructor() {
        this.CreateDiffDescription();
        if (!$.DbgIsReloadingScript()) {
            $.RegisterEventHandler("DOTAShowAbilityTooltip", dotaHud_, (panel, ability_name) => this.AbilityTooltipHandler(panel, ability_name, -1));
            $.RegisterEventHandler("DOTAShowAbilityTooltipForEntityIndex", dotaHud_, (panel, ability_name, entity) => this.AbilityTooltipHandler(panel, ability_name, entity));
            $.RegisterEventHandler("DOTAHideAbilityTooltip", dotaHud_, (panel, ability_name) => this.AbilityTooltipHandler(panel, ability_name, -1));
        }
    }
    CreateDiffDescription(tooltip) {
        let description = FindDotaHudElement_("AbilityDifferenceDescription");
        if (description)
            return description;
        else if (!description && tooltip) {
            const extra_description = tooltip.FindChildTraverse("AbilityExtraDescription");
            const core_details = tooltip.FindChildTraverse("AbilityCoreDetails");
            description = $.CreatePanel("Panel", core_details, "AbilityDifferenceDescription");
            description.BLoadLayout("file://{resources}/layout/custom_game/ability_differences.xml", false, false);
            core_details.MoveChildAfter(description, extra_description);
        }
        return description;
    }
    AbilityTooltipHandler(panel, ability_name, entity) {
        const tooltips = FindDotaHudElement_("Tooltips");
        if (!tooltips)
            return;
        const tooltip = tooltips.FindChildTraverse("DOTAAbilityTooltip");
        if (!tooltip)
            return;
        const description = this.CreateDiffDescription(tooltip);
        if (!description)
            return;
        if (Game.GameStateIsBefore(DOTA_GameState.DOTA_GAMERULES_STATE_PRE_GAME))
            return;
        description.visible = false;
        this.RefreshTooltip(panel, description, ability_name, entity);
    }
    RefreshTooltip(panel, description, ability_name, entity) {
        if (panel.id === "ItemImage" || !ability_name)
            return;
        if (exception[ability_name] == true)
            return;

        description.visible = true;
        const good_description = this.GenerateDescription(ability_name, entity, 'good');
        const bad_description = this.GenerateDescription(ability_name, entity, 'bad');
        const neutral_description = this.GenerateDescription(ability_name, entity, 'neutral');
        if (good_description)
            description.SetDialogVariable("good_change_description", good_description);
        if (bad_description)
            description.SetDialogVariable("bad_change_description", bad_description);
        if (neutral_description)
            description.SetDialogVariable("neutral_change_description", neutral_description);
        const good_panel = description.FindChildTraverse("GoodChangeDescription");
        const bad_panel = description.FindChildTraverse("BadChangeDescription");
        const neutral_panel = description.FindChildTraverse("NeutralChangeDescription");
        if (entity === -1) {
            this.hideSchedule = $.Schedule(0.175 + Game.GetGameFrameTime(), () => {
                description.visible = false;
                if (good_panel)
                    good_panel.visible = false;
                if (bad_panel)
                    bad_panel.visible = false;
                if (neutral_panel)
                    neutral_panel.visible = false;
            });
        }
        else {
            if (this.hideSchedule)
                $.CancelScheduled(this.hideSchedule);
            if (good_panel)
                good_panel.visible = good_description !== undefined;
            if (bad_panel)
                bad_panel.visible = bad_description !== undefined;
            if (neutral_panel)
                neutral_panel.visible = neutral_description !== undefined;
            if (!good_description && !bad_description && !neutral_description)
                description.visible = false;
        }
    }
    GenerateDescription(abilityName, entity, type) {
        const localize_key = `#DOTA_Tooltip_Ability_${abilityName}_${type}Changes`;
        let text = $.Localize(localize_key);
        if (text === localize_key || text.trim().length === 0)
            return;
        if (entity === -1)
            return;
        const ability = Entities.GetAbilityByName(entity, abilityName);
        if (ability === -1)
            return;
        const normal_keys = matchAll(text, /%([^%]+)%/g).map(match => match[1]);
        const percent_keys = matchAll(text, /%([^%]+)%%(.)/g).map(match => match[1]);
        percent_keys.forEach(key => {
            const value = Abilities.GetLevelSpecialValueFor(ability, key, 1);
            text = replaceAll(text, new RegExp(`%${key}%%\.`, 'g'), this.modifyNumber(value, true));
        });
        normal_keys.forEach(key => {
            const value = Abilities.GetLevelSpecialValueFor(ability, key, 1);
            text = replaceAll(text, `%${key}%`, this.modifyNumber(value, false));
        });
        return text;
    }
    modifyNumber(number, is_percent) {
        const string = number.toFixed(4).replace(/\.?0+$/, '');
        return is_percent
            ? `<font color='#e1e1e1'>${string}%</font>`
            : `<font color='#e1e1e1'>${string}</font>`;
    }
}

const dotaHud_ = (() => {
    let panel = $.GetContextPanel();
    while (panel) {
        if (panel.id === "DotaHud")
            return panel;
        panel = panel.GetParent();
    }
    return panel;
})();

const FindDotaHudElement_ = (id) => {
    return dotaHud_.FindChildTraverse(id);
};



new AbilityDifferences();