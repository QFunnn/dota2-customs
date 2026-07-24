--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const TOOLTIP_PANELS =
{
    LeftArrow : $.GetContextPanel().GetParent().FindChildTraverse("LeftArrow"),
    AbilityTexture : $("#AbilityTexture"),
    AbilityName : $("#AbilityName"),
    AbilityDescriptionHeaderLabel : $("#AbilityDescriptionHeaderLabel"),
    AbilityDescription : $("#AbilityDescription"),
    AbilityLoreLabel : $("#AbilityLoreLabel"),
    AbilityLore : $("#AbilityLore"),
    CurrencyCost : $("#CurrencyCost"),
    CurrencyCostIcon : $("#CurrencyCostIcon"),
    CurerncyCostLabel : $("#CurerncyCostLabel"),
    ManaCostPanel : $("#ManaCostPanel"),
    CooldownCostPanel : $("#CooldownCostPanel"),
    ManaCostLabel : $("#ManaCostLabel"),
    CooldownCostLabel : $("#CooldownCostLabel"),
    AbilityStats : $("#AbilityStats"),
    AbilityData : $("#AbilityData"),
    AbilityDescriptionPanelArtefact : $("#AbilityDescriptionPanelArtefact"),
    AbilityDescriptionEffectArtefactHeaderLabel : $("#AbilityDescriptionEffectArtefactHeaderLabel"),
    CooldownCostEffectArtefactPanel : $("#CooldownCostEffectArtefactPanel"),
    CooldownCostEffectArtefactLabel : $("#CooldownCostEffectArtefactLabel"),
    AbilityDescriptionEffectArtefact : $("#AbilityDescriptionEffectArtefact"),
    AbilityArtefactEStats : $("#AbilityArtefactEStats"),
}

function GetAbilitySpecialValue(ability_handle, special_name, fallback_special_values)
{
    if (!special_name) return null

    if (ability_handle && ability_handle != -1 && typeof Abilities.GetSpecialValueFor === "function")
    {
        let value = Abilities.GetSpecialValueFor(ability_handle, special_name)
        if (value !== null && typeof(value) != "undefined" && value !== "") return value
    }

    if (ability_handle && ability_handle != -1 && typeof Abilities.GetAbilitySpecial === "function")
    {
        let value = Abilities.GetAbilitySpecial(ability_handle, special_name)
        if (value !== null && typeof(value) != "undefined" && value !== "") return value
    }

    if (fallback_special_values && typeof fallback_special_values[special_name] != "undefined")
    {
        return fallback_special_values[special_name]
    }

    return null
}

function LocalizeAbilityDescription(localization_key, label, ability_handle, fallback_special_values)
{
    let text = $.Localize(localization_key, label)

    text = text.replace(/%([a-zA-Z0-9_]+)%/g, function(match, special_name)
    {
        let value = GetAbilitySpecialValue(ability_handle, special_name, fallback_special_values)
        if (value === null) return match

        label.SetDialogVariable(special_name, FormatPrecisionValue(value))
        return FormatPrecisionValue(value)
    })

    return text.replace(/%%/g, "%")
}

function UpdateTooltip()
{
    // vars
    let player_id = String(Game.GetLocalPlayerID())
    let current_hero = GetPlayerHero()
    let ability_name = $.GetContextPanel().GetAttributeString("ability_name", "")
    let ability_cost_table = Game.GetCustomTable("abilities_cost", player_id) || {}
    let ability_cost_data = ability_cost_table[ability_name]
    let ability_card_data = Game.GetCustomTable("ability_card_data", ability_name)
    let current_ultimate = Game.GetCustomTable("ultimate_state", player_id)
    let player_cards_data = Game.GetCustomTable("player_cards_data", player_id)
    let player_artefact_data = Game.GetCustomTable("artefact_state", player_id)
    let ability_handle = null
    let ability_cost_icon = null
    let ability_cost_value = null
    let current_image = null
    let manacost = 0
    let cooldown = 0
    let stats_bonus_list = null
    let ability_data_list = null
    let ability_artefact_e_list = null
    let is_levelup_upgrade_stats = ability_name == "levelup_upgrade_stats"
    let base_ability_data = typeof BASE_ABILITIES_DATA !== "undefined" ? BASE_ABILITIES_DATA[ability_name] : null
    let has_artefact_state = Boolean(player_artefact_data && player_artefact_data.current_passive_artefact)

    // Обнуление
    TOOLTIP_PANELS.AbilityArtefactEStats.RemoveAndDeleteChildren()
    TOOLTIP_PANELS.AbilityStats.RemoveAndDeleteChildren()
    TOOLTIP_PANELS.AbilityData.RemoveAndDeleteChildren()

    // Изменение данных от способности или от карточки
    if (current_ultimate && current_ultimate.ultimate_id == ability_name)
    {
        ability_card_data = current_ultimate
    }
    else if (ability_card_data && player_cards_data && player_cards_data.consumed)
    {
        let get_data_ultimate_consumed = GetDataFromObjectList(Object.values(player_cards_data.consumed), "card_name", "ultimate_card_"+ability_name)
        if (get_data_ultimate_consumed)
        {
            ability_card_data.passive_stats = get_data_ultimate_consumed.bonus_list.stats
        }
    }

    // Если базовая абилка
    if (base_ability_data)
    {
        current_image = "abilities/"+base_ability_data.icon
        ability_handle = Entities.GetAbilityByName(current_hero, ability_name)
    }

    // Изменение стоимости прокачки
    if (ability_cost_data && ability_cost_data[1] && ability_cost_data[4])
    {
        ability_cost_icon = ability_cost_data[4]
        ability_cost_value = ability_cost_data[1]
    }

    // Взять данные о способности и о бонусах
    if (ability_card_data && ability_card_data.ultimate_id)
    {
        cooldown = Math.round(Number(ability_card_data?.proc_params?.cooldown || 0))
        current_image = "spellicons/"+ability_card_data.icon
        if (ability_card_data.proc_params)
        {
            for (let stat_effect_key in ability_card_data.proc_params)
            {
                let stat_effect_value = ability_card_data.proc_params[stat_effect_key]
                TOOLTIP_PANELS.AbilityDescription.SetDialogVariable(stat_effect_key, FormatPrecisionValue(stat_effect_value))
            }
        }
        if (ability_card_data.passive_stats)
        {
            stats_bonus_list = NormalizeStatsBonusList(ability_card_data.passive_stats)
            for (let type in stats_bonus_list)
            {
                let stats = stats_bonus_list[type]
                if (!stats || typeof stats !== "object") continue
                for (let stat in stats)
                {
                    let value = FormatPrecisionValue(stats[stat])
                    TOOLTIP_PANELS.AbilityDescription.SetDialogVariable(stat, value)
                    TOOLTIP_PANELS.AbilityDescription.SetDialogVariable(type + "_" + stat, value)
                }
            }
        }
    }
    else if (ability_handle)
    {
        manacost = Math.round(Abilities.GetManaCost(ability_handle))
        cooldown = Math.round(Abilities.GetCooldown(ability_handle))
    }
    else if (base_ability_data)
    {
        manacost = Math.round(Number(base_ability_data.mana_cost || 0))
        cooldown = Number(base_ability_data.cooldown || 0)
    }

    TOOLTIP_PANELS.AbilityDescriptionPanelArtefact.visible = is_levelup_upgrade_stats && has_artefact_state

    // Отдельная информация под (способность W)
    if (is_levelup_upgrade_stats && has_artefact_state)
    {
        stats_bonus_list = MergeAllStats(player_artefact_data.passive_stats || {})
        ability_data_list =
        {
            level : Math.floor(player_artefact_data.passive_artefact_level % 5),
            step : player_artefact_data.passive_artefact_step,
        }
        if (player_artefact_data?.proc_params)
        {
            for (let stat_effect_key in player_artefact_data.proc_params)
            {
                let stat_effect_value = player_artefact_data.proc_params[stat_effect_key]
                TOOLTIP_PANELS.AbilityDescriptionEffectArtefact.SetDialogVariable(stat_effect_key, FormatPrecisionValue(stat_effect_value))
            }
        }
        let artefact_cooldown = player_artefact_data?.proc_params?.cooldown || 0
        let artefact_id = String(player_artefact_data.current_passive_artefact)
        let artefact_name_key = player_artefact_data.localization_key_name || ("passive_artefact_" + artefact_id + "_name")
        let artefact_description_key = player_artefact_data.localization_key_desc || ("passive_artefact_" + artefact_id + "_description")
        let artefact_step = Math.max(0, Math.floor(Number(player_artefact_data.passive_artefact_step || 0) / 6))
        TOOLTIP_PANELS.AbilityDescriptionEffectArtefactHeaderLabel.text = $.Localize("#"+artefact_name_key)
        TOOLTIP_PANELS.CooldownCostEffectArtefactPanel.visible = Number(artefact_cooldown) > 0
        TOOLTIP_PANELS.CooldownCostEffectArtefactLabel.text = FormatPrecisionValue(artefact_cooldown)
        TOOLTIP_PANELS.AbilityDescriptionEffectArtefact.text = $.Localize("#"+artefact_description_key, TOOLTIP_PANELS.AbilityDescriptionEffectArtefact)
        current_image = player_artefact_data.current_icon_path || ("file://{images}/abilities/" + artefact_id + "_" + artefact_step + ".png")
    }

    // Отдельная информация под (способность E)
    if (ability_name == "levelup_upgrade_artifacts" && has_artefact_state)
    {
        ability_data_list =
        {
            level : player_artefact_data.main_artefact_level,
        },
        ability_artefact_e_list = 
        {
            base_str : {value:player_artefact_data.main_artefact_stats.base.str || 0, tier: player_artefact_data.main_artefact_bonus_levels.str},
            base_agi : {value:player_artefact_data.main_artefact_stats.base.agi || 0, tier: player_artefact_data.main_artefact_bonus_levels.agi},
            intellect : {value:player_artefact_data.main_artefact_stats.base.int || 0, tier: player_artefact_data.main_artefact_bonus_levels.int},
            physical_damage : {value:player_artefact_data.main_artefact_stats.base.fixed_physical_damage || 0, tier: player_artefact_data.main_artefact_bonus_levels.fixed_physical_damage},
            magical_damage : {value:player_artefact_data.main_artefact_stats.base.fixed_magical_damage || 0, tier: player_artefact_data.main_artefact_bonus_levels.fixed_magical_damage},
            health : {value:player_artefact_data.main_artefact_stats.base.health || 0, tier: player_artefact_data.main_artefact_bonus_levels.health},
        }
        current_image = "abilities/levelup_upgrade_artifacts_" + player_artefact_data.main_artefact_level
    }
    
    // Обновление данных о способности E
    if (ability_artefact_e_list)
    {
        for (let bonus_name in ability_artefact_e_list)
        {
            CreateArtefactEBonus(TOOLTIP_PANELS.AbilityArtefactEStats, bonus_name, ability_artefact_e_list[bonus_name])
        }
    }

    // Обновление какие характеристики добавляет
    if (stats_bonus_list)
    {
        for (let type in stats_bonus_list)
        {
            let stats = stats_bonus_list[type]
            for (let stat in stats)
            {
                CreateCardStatLine(TOOLTIP_PANELS.AbilityStats, `${type}_${stat}`, stats[stat])
            }
        }
    }

    if (ability_data_list)
    {
        if (typeof(ability_data_list.level) != "undefined")
        {
            let label_artefact_panel = $.CreatePanel("Panel", TOOLTIP_PANELS.AbilityData, "")
            label_artefact_panel.AddClass("label_artefact_panel")

            if (typeof(ability_data_list.step) != "undefined")
            {
                let label_artefact_step = $.CreatePanel("Label", label_artefact_panel, "")
                label_artefact_step.AddClass("AbilityDataLabel")
                label_artefact_step.html = true
                label_artefact_step.SetDialogVariable("value", "<b><font color=\"gold\">" + String(ability_data_list.step) + "</font></b>");
                label_artefact_step.text = $.Localize("#levelup_artefact_step", label_artefact_step)

                let Limer2 = $.CreatePanel("Panel", TOOLTIP_PANELS.AbilityData, "")
                Limer2.AddClass("Limer2")
            }

            if (typeof(ability_data_list.level) != "undefined")
            {
                let label_artefact_level = $.CreatePanel("Label", label_artefact_panel, "")
                label_artefact_level.AddClass("AbilityDataLabel")
                label_artefact_level.html = true
                label_artefact_level.SetDialogVariable("value", "<b><font color=\"gold\">" + String(ability_data_list.level) + "</font></b>");
                label_artefact_level.text = $.Localize("#levelup_artefact_level", label_artefact_level)
            }
        }
    }

    // Дополнительная лор херня в абилке
    let get_localize_lore = $.Localize("#dota_tooltip_ability_"+ability_name+"_lore")
    if (get_localize_lore != "" && get_localize_lore != "#dota_tooltip_ability_"+ability_name+"_lore")
    {
        TOOLTIP_PANELS.AbilityLore.SetHasClass("IsArtefactLore", ability_name == "levelup_upgrade_artifacts")
        TOOLTIP_PANELS.AbilityLoreLabel.text = get_localize_lore
        TOOLTIP_PANELS.AbilityLore.visible = true
    }
    else
    {
        TOOLTIP_PANELS.AbilityLore.visible = false
    }

    // Стоимость дерева или золота
    if (ability_cost_value != null)
    {
        TOOLTIP_PANELS.CurrencyCost.visible = true
        TOOLTIP_PANELS.CurrencyCostIcon.SetHasClass("IsWoodIcon", ability_cost_icon == "wood")
        TOOLTIP_PANELS.CurerncyCostLabel.text = ability_cost_value
    }
    else
    {
        TOOLTIP_PANELS.CurrencyCost.visible = false
    }

    // Обновление данных Tooltip
    TOOLTIP_PANELS.AbilityTexture.SetImage(String(current_image || "").indexOf("file://") === 0 ? current_image : ("file://{images}/" + current_image + ".png"))
    TOOLTIP_PANELS.AbilityName.text = $.Localize("#dota_tooltip_ability_"+ability_name)
    TOOLTIP_PANELS.AbilityDescriptionHeaderLabel.text = $.Localize("#dota_tooltip_ability_"+ability_name+"_description_header")
    TOOLTIP_PANELS.AbilityDescription.text = LocalizeAbilityDescription("#dota_tooltip_ability_"+ability_name+"_description", TOOLTIP_PANELS.AbilityDescription, ability_handle, base_ability_data && base_ability_data.special_values)
    TOOLTIP_PANELS.ManaCostPanel.visible = manacost != 0
    TOOLTIP_PANELS.CooldownCostPanel.visible = cooldown != 0
    TOOLTIP_PANELS.ManaCostLabel.text = manacost
    TOOLTIP_PANELS.CooldownCostLabel.text = cooldown
}

function CreateArtefactEBonus(parent, bonus_name, bonus_data)
{
    let panel = $.CreatePanel("Panel", parent, "")
    panel.BLoadLayoutSnippet("ArtefactEBonus")
    panel.FindChildTraverse("Name").text = $.Localize("#artefact_e_stats_" + bonus_name)
    panel.FindChildTraverse("Value").text = ApplyNumberFormat(bonus_data.value)
    panel.FindChildTraverse("Tier").text = "T" + bonus_data.tier
    panel.AddClass("AftefactBonusTier_"+bonus_data.tier)
}

function CreateCardStatLine(parent, label_name, value)
{
    let panel = $.CreatePanel("Panel", parent, "")
    panel.BLoadLayoutSnippet("CardStatLine")
    value = ApplyNumberFormat(value)
    panel.SetDialogVariable("value", `<b><font color="gold">${value}</font></b>`)
    let label = panel.FindChildTraverse("StatLabel")
    label.text = $.Localize("#levelup_card_stats_" + label_name, panel)
}