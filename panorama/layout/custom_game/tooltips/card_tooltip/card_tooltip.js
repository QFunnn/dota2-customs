--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const TOOLTIP_PANELS =
{
    BundleDataHeader: $("#BundleDataHeader"),
    BundleDataDescription: $("#BundleDataDescription"),
    BundleData: $("#BundleData"),
    CardImagePanel: $("#CardImagePanel"),
    CardNamePanel: $("#CardNamePanel"),
    CardImage: $("#CardImage"),
    CardName: $("#CardName"),
    CardStats: $("#CardStats"),
    EffectsCard: $("#EffectsCard"),
    TooltipBG : $("#TooltipBG"),
    TooltipBG2 : $("#TooltipBG2"),
    BundleBG : $("#BundleBG"),
}

const CARD_RARITY_CLASSES = [
    "CardRarityCommon",
    "CardRarityRare",
    "CardRarityEpic",
    "CardRarityLegendary",
    "CardRarityMythical",
    "CardRaritySSS",
]

function FormatTooltipBonusValue(value)
{
    const formatted_value = FormatPrecisionValue(value)
    const numeric_value = Number(value)
    if (!Number.isFinite(numeric_value))
    {
        return formatted_value
    }

    return numeric_value > 0 ? "+" + formatted_value : formatted_value
}

function GetPlayerRuntimeCardData(player_cards_data, card_name)
{
    if (!player_cards_data || !card_name)
    {
        return null
    }

    if (player_cards_data.current)
    {
        let current_card_data = GetDataFromObjectList(Object.values(player_cards_data.current), "card_name", card_name)
        if (current_card_data)
        {
            return current_card_data
        }
    }

    if (player_cards_data.consumed)
    {
        let consumed_card_data = GetDataFromObjectList(Object.values(player_cards_data.consumed), "card_name", card_name)
        if (consumed_card_data)
        {
            return consumed_card_data
        }
    }

    return null
}

function NormalizeCardRarityName(rarity)
{
    switch (String(rarity || "").toLowerCase())
    {
        case "rare":
        case "epic":
        case "legendary":
        case "mythical":
        case "sss":
            return String(rarity).toLowerCase()
        default:
            return "common"
    }
}

function GetCardRarityClassName(rarity)
{
    switch (NormalizeCardRarityName(rarity))
    {
        case "rare":
            return "CardRarityRare"
        case "epic":
            return "CardRarityEpic"
        case "legendary":
            return "CardRarityLegendary"
        case "mythical":
            return "CardRarityMythical"
        case "sss":
            return "CardRaritySSS"
        default:
            return "CardRarityCommon"
    }
}

function ClearCardRarityClasses(panel)
{
    if (!panel)
    {
        return
    }

    for (let class_name of CARD_RARITY_CLASSES)
    {
        panel.RemoveClass(class_name)
    }
}

function ApplyCardRarityClass(panel, rarity)
{
    if (!panel)
    {
        return
    }

    ClearCardRarityClasses(panel)
    panel.AddClass(GetCardRarityClassName(rarity))
}

function UpdateTooltip()
{
    // vars
    let player_id = String(Game.GetLocalPlayerID())
    let card_name = $.GetContextPanel().GetAttributeString("card_name", "")
    let card_data_all = Game.GetCustomTable("game_data", "card_data")
    let bundle_data_all = Game.GetCustomTable("game_data", "card_bundles_data")
    let player_cards_data = Game.GetCustomTable("player_cards_data", player_id)

    if (!card_data_all || !card_data_all[card_name]) return
    let card_data = card_data_all[card_name]
    let runtime_card_data = GetPlayerRuntimeCardData(player_cards_data, card_name)
    if (runtime_card_data)
    {
        card_data = Object.assign({}, card_data)
        if (runtime_card_data.bonus_list)
        {
            card_data.bonus_list = runtime_card_data.bonus_list
        }
        if (runtime_card_data.kills_consumed_data)
        {
            card_data.kills_consumed_data = runtime_card_data.kills_consumed_data
        }
    }
    let bundle_data = bundle_data_all ? bundle_data_all[card_data.bundle_name] : null
    let card_rarity = NormalizeCardRarityName((card_data && card_data.rarity) || (bundle_data && bundle_data.rarity))

    TOOLTIP_PANELS.CardStats.RemoveAndDeleteChildren()
    TOOLTIP_PANELS.EffectsCard.RemoveAndDeleteChildren()
    TOOLTIP_PANELS.CardImage.SetImage(`file://{images}/card_list/${card_data.card_name}.png`)
    TOOLTIP_PANELS.CardName.text = $.Localize("#" + card_data.card_name)
    ApplyCardRarityClass(TOOLTIP_PANELS.TooltipBG, card_rarity)
    ApplyCardRarityClass(TOOLTIP_PANELS.TooltipBG2, card_rarity)
    ApplyCardRarityClass(TOOLTIP_PANELS.CardImagePanel, card_rarity)
    ApplyCardRarityClass(TOOLTIP_PANELS.CardNamePanel, card_rarity)
    ApplyCardRarityClass(TOOLTIP_PANELS.BundleDataHeader, card_rarity)
    ApplyCardRarityClass(TOOLTIP_PANELS.BundleBG, card_rarity)

    // Отдельная информация, что выдается за убийство
    if (card_data.kills_consumed_data)
    {
        let consumed = card_data.kills_consumed_data
        let panel = $.CreatePanel("Panel", TOOLTIP_PANELS.CardStats, "")
        panel.AddClass("CardBaseBonusLine")
        panel.SetDialogVariable("kills_counter", `<b><font color="gold">${consumed.kills_counter}</font></b>`)
        panel.SetDialogVariable("current_stacks", `<b><font color="gold">${FormatPrecisionValue(consumed.current_stacks || 0)}</font></b>`)

        for (let key in consumed)
        {
            let value = consumed[key]
            if (typeof value == "number" || typeof value == "string")
            {
                panel.SetDialogVariable(key, `<b><font color="gold">${FormatPrecisionValue(value)}</font></b>`)
            }
        }

        if (consumed.bonus_list)
        {
            for (let type in consumed.bonus_list)
            {
                let bonus_list = consumed.bonus_list[type]

                if (type == "stats" || type == "currency")
                {
                    for (let key in bonus_list)
                    {
                        let value = bonus_list[key]
                        if (type == "stats")
                        {
                            value = value[1]
                        }
                        panel.SetDialogVariable(key, `<b><font color="gold">${FormatTooltipBonusValue(value)}</font></b>`)
                    }
                }
                else if (type == "unique_effects")
                {
                    for (let effect_key in bonus_list)
                    {
                        CreateCardEffect(TOOLTIP_PANELS.EffectsCard, bonus_list[effect_key])
                    }
                }
                else if (type == "effect_upgrades")
                {
                    for (let upgrade_data of Object.values(bonus_list || {}))
                    {
                        for (let key in (upgrade_data || {}))
                        {
                            panel.SetDialogVariable(key, `<b><font color="gold">${FormatTooltipBonusValue(upgrade_data[key])}</font></b>`)
                        }
                    }
                }
            }
        }

        let pin = $.CreatePanel("Panel", panel, "")
        pin.AddClass("CardBaseBonusPin")

        let label = $.CreatePanel("Label", panel, "")
        label.AddClass("CardBaseBonusLabel")
        label.html = true
        label.text = $.Localize("#" + card_data.card_name + "_consumed_kills_description", panel)
    }

    // Обновление какие характеристики добавляет
    for (let bonus_name in (card_data.bonus_list || {}))
    {
        let bonus_list = card_data.bonus_list[bonus_name]
        if (bonus_name == "stats" || bonus_name == "currency" || bonus_name == "summon_aura")
        {
            for (let key in bonus_list)
            {
                let data = bonus_list[key]
                let value = data
                let label = key
                if (typeof data == "object")
                {
                    value = data[1]
                    label = data[2] + "_" + key
                }
                CreateCardStatLine(TOOLTIP_PANELS.CardStats, label, value, bonus_name == "summon_aura" ? "#levelup_card_summon_aura_" : "#levelup_card_stats_")
            }
        }
        else if (bonus_name == "unique_effects")
        {
            for (let effect_key in bonus_list)
            {
                CreateCardEffect(TOOLTIP_PANELS.EffectsCard, bonus_list[effect_key])
            }
        }
    }

    for (let line_key of Object.values(card_data.custom_description_lines || {}))
    {
        CreateCardDescriptionLine(TOOLTIP_PANELS.CardStats, line_key)
    }

    // Есть ли эффект бандла и его информация
    if (bundle_data && bundle_data.bundle_description)
    {
        TOOLTIP_PANELS.BundleData.visible = true
        ApplyBundleDialogVariables(TOOLTIP_PANELS.BundleDataDescription, bundle_data.bonus_list)
        TOOLTIP_PANELS.BundleDataHeader.text = $.Localize("#" + card_data.bundle_name)
        TOOLTIP_PANELS.BundleDataDescription.text = $.Localize("#" + bundle_data.bundle_description, TOOLTIP_PANELS.BundleDataDescription)
    }
    else
    {
        TOOLTIP_PANELS.BundleData.visible = false
    }
}

function CreateCardStatLine(parent, label_name, value, localization_prefix)
{
    let panel = $.CreatePanel("Panel", parent, "")
    panel.BLoadLayoutSnippet("CardStatLine")
    value = FormatTooltipBonusValue(value)
    panel.SetDialogVariable("value", `<b><font color="gold">${value}</font></b>`)

    let label = panel.FindChildTraverse("StatLabel")
    label.text = $.Localize((localization_prefix || "#levelup_card_stats_") + label_name, panel)
}

function CreateCardDescriptionLine(parent, localization_key)
{
    let panel = $.CreatePanel("Panel", parent, "")
    panel.AddClass("CardBaseBonusLine")

    let pin = $.CreatePanel("Panel", panel, "")
    pin.AddClass("CardBaseBonusPin")

    let label = $.CreatePanel("Label", panel, "")
    label.AddClass("CardBaseBonusLabel")
    label.html = true
    label.text = $.Localize("#" + localization_key)
}

function CreateCardEffect(parent, effect_data)
{
    let panel = $.CreatePanel("Panel", parent, "")
    panel.BLoadLayoutSnippet("CardEffect")
    panel.FindChildTraverse("EffectName").text = $.Localize("#" + effect_data.effect_id + "_name")

    let cooldown = effect_data.proc_params?.cooldown
    let cooldownPanel = panel.FindChildTraverse("CooldownPanel")

    if (cooldown == null)
    {
        cooldownPanel.visible = false
    }
    else
    {
        panel.FindChildTraverse("CooldownLabel").text = FormatPrecisionValue(cooldown)
    }

    let label = panel.FindChildTraverse("EffectDescription")
    for (let key in effect_data.proc_params)
    {
        label.SetDialogVariable(key,`<b><font color="gold">${FormatPrecisionValue(effect_data.proc_params[key])}</font></b>`)
    }
    label.text = $.Localize("#" + effect_data.effect_id + "_description", label)
}

function ApplyBundleDialogVariables(panel, bonus_list)
{
    for (let type in bonus_list)
    {
        if (type == "stats" || type == "currency" || type == "summon_aura")
        {
            for (let key in bonus_list[type])
            {
                let data = bonus_list[type][key]
                let value = data
                let label = key
                if (typeof data == "object")
                {
                    value = data[1]
                    label = data[2] + "_" + key
                }
                value = FormatTooltipBonusValue(value)
                panel.SetDialogVariable("value_" + label, `<b><font color="gold">${value}</font></b>`)
            }
        }
        else if (type == "unique_effects")
        {
            for (let effect_data of Object.values(bonus_list[type] || {}))
            {
                let proc_params = effect_data && effect_data.proc_params
                if (!proc_params)
                {
                    continue
                }

                for (let key in proc_params)
                {
                    panel.SetDialogVariable(key, `<b><font color="gold">${FormatPrecisionValue(proc_params[key])}</font></b>`)
                }
            }
        }
        else if (type == "hero_selection")
        {
            for (let key in (bonus_list[type] || {}))
            {
                panel.SetDialogVariable(key, `<b><font color="gold">${FormatPrecisionValue(bonus_list[type][key])}</font></b>`)
            }
        }
        else if (type == "effect_upgrades")
        {
            for (let upgrade_data of Object.values(bonus_list[type] || {}))
            {
                for (let key in (upgrade_data || {}))
                {
                    panel.SetDialogVariable(key, `<b><font color="gold">${FormatPrecisionValue(upgrade_data[key])}</font></b>`)
                }
            }
        }
    }
}