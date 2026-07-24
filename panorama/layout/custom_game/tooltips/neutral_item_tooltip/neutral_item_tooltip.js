--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const NEUTRAL_TOOLTIP = {
    root: $.GetContextPanel(),
    image: $("#ItemImage"),
    name: $("#ItemName"),
    rarity: $("#ItemRarity"),
    stats: $("#ItemStats"),
    effectPanel: $("#ItemEffectPanel"),
    effectHeader: $("#ItemEffectHeader"),
    effectName: $("#ItemEffectName"),
    effectCooldown: $("#ItemEffectCooldown"),
    effectCooldownValue: $("#ItemEffectCooldownValue"),
    effectDescription: $("#ItemEffectDescription"),
}

const NEUTRAL_RARITY_CLASSES = [
    "Rarity_common",
    "Rarity_uncommon",
    "Rarity_rare",
    "Rarity_mythical",
    "Rarity_legendary",
    "Rarity_immortal",
    "Rarity_super",
]

function GetIndexedValue(data, index)
{
    if (!data || typeof data !== "object") return undefined
    return data[index] !== undefined ? data[index] : data[String(index)]
}

function FormatNeutralBonusValue(value)
{
    const numericValue = Number(value)
    const formatted = FormatPrecisionValue(value)
    if (!Number.isFinite(numericValue)) return formatted
    return numericValue > 0 ? "+" + formatted : formatted
}

function ApplyNeutralRarity(rarity)
{
    for (const className of NEUTRAL_RARITY_CLASSES)
    {
        NEUTRAL_TOOLTIP.root.RemoveClass(className)
    }
    const normalized = String(rarity || "common").toLowerCase()
    const className = "Rarity_" + normalized
    NEUTRAL_TOOLTIP.root.AddClass(NEUTRAL_RARITY_CLASSES.indexOf(className) >= 0 ? className : "Rarity_common")
}

function CreateNeutralStatLine(statName, statData)
{
    let value = statData
    let channel = "bonus"
    if (statData && typeof statData === "object")
    {
        value = GetIndexedValue(statData, 1)
        channel = String(GetIndexedValue(statData, 2) || "bonus")
    }

    const panel = $.CreatePanel("Panel", NEUTRAL_TOOLTIP.stats, "")
    panel.BLoadLayoutSnippet("NeutralItemStatLine")
    panel.SetDialogVariable("value", `<b><font color=\"gold\">${FormatNeutralBonusValue(value)}</font></b>`)
    panel.FindChildTraverse("StatLabel").text = $.Localize(`#levelup_card_stats_${channel}_${statName}`, panel)
}

function RenderNeutralEffect(effectData)
{
    if (!effectData || !effectData.effect_id)
    {
        NEUTRAL_TOOLTIP.effectPanel.visible = false
        return
    }

    const effectId = String(effectData.effect_id)
    const params = effectData.proc_params || {}
    NEUTRAL_TOOLTIP.effectPanel.visible = true
    NEUTRAL_TOOLTIP.effectHeader.text = $.Localize("#neutral_item_active_effect")
    NEUTRAL_TOOLTIP.effectName.text = $.Localize("#" + effectId + "_name")

    const cooldown = Number(params.cooldown)
    const hideCooldown = params.hide_cooldown_ui === true || Number(params.hide_cooldown_ui) === 1
    NEUTRAL_TOOLTIP.effectCooldown.visible = !hideCooldown && Number.isFinite(cooldown) && cooldown > 0
    if (NEUTRAL_TOOLTIP.effectCooldown.visible)
    {
        NEUTRAL_TOOLTIP.effectCooldownValue.text = FormatPrecisionValue(cooldown)
    }

    for (const key in params)
    {
        if (!Object.prototype.hasOwnProperty.call(params, key)) continue
        const value = Number(params[key])
        const formatted = Number.isFinite(value) ? FormatPrecisionValue(value) : String(params[key])
        NEUTRAL_TOOLTIP.effectDescription.SetDialogVariable(key, `<b><font color=\"gold\">${formatted}</font></b>`)
    }
    NEUTRAL_TOOLTIP.effectDescription.text = $.Localize("#" + effectId + "_description", NEUTRAL_TOOLTIP.effectDescription)
}

function UpdateTooltip()
{
    const itemName = $.GetContextPanel().GetAttributeString("item_name", "")
    const definition = Game.GetCustomTable("neutral_item_definitions", itemName)
    if (!definition) return

    const rarityName = String(definition.rarity_name || "common")
    ApplyNeutralRarity(rarityName)
    NEUTRAL_TOOLTIP.image.SetImage(`file://{images}/neutral_items/${itemName}.png`)
    NEUTRAL_TOOLTIP.name.text = $.Localize("#" + itemName)
    NEUTRAL_TOOLTIP.rarity.text = $.Localize("#neutral_item_rarity_" + rarityName)

    NEUTRAL_TOOLTIP.stats.RemoveAndDeleteChildren()
    const bonusList = definition.bonus_list || {}
    const stats = bonusList.stats || {}
    for (const statName of Object.keys(stats).sort())
    {
        CreateNeutralStatLine(statName, stats[statName])
    }

    const effects = bonusList.unique_effects || {}
    const effectList = Object.values(effects)
    RenderNeutralEffect(effectList.length > 0 ? effectList[0] : null)
}