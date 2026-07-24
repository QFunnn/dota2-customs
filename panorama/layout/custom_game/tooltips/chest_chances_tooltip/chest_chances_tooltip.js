--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const CHEST_CHANCE_PANELS =
{
    title: $("#ChestChancesTitle"),
    description: $("#ChestChancesDescription"),
    list: $("#ChestChancesList"),
    guarantee: $("#ChestChancesGuarantee"),
}

function GetAttr(name, fallback)
{
    return $.GetContextPanel().GetAttributeString(name, fallback || "")
}

function GetServiceItemsTooltip()
{
    return Game.GetCustomTable ? (Game.GetCustomTable("services_config", "items") || {}) : {}
}

function GetServiceChestsTooltip()
{
    return Game.GetCustomTable ? (Game.GetCustomTable("services_config", "chests") || {}) : {}
}

function LocalizeTooltipKeyOrText(value, fallback)
{
    let text = String(value || "")
    if (text === "") return String(fallback || "")
    let key = text.charAt(0) === "#" ? text : "#" + text
    if ($.CanLocalize && $.CanLocalize(key))
    {
        return $.Localize(key)
    }
    return text.charAt(0) === "#" ? text.substring(1) : text
}

function SetTooltipImage(panel, path)
{
    if (!panel) return
    panel.style.backgroundImage = "url('" + String(path || "file://{images}/game_hud/icons/gold.png") + "')"
    panel.style.backgroundSize = "contain"
    panel.style.backgroundPosition = "center"
    panel.style.backgroundRepeat = "no-repeat"
}

function FindChestConfig(chest_id)
{
    let chests = GetServiceChestsTooltip()
    let list = chests.list || {}
    if (list[chest_id]) return list[chest_id]

    for (let key in list)
    {
        if (list[key] && list[key].id === chest_id)
        {
            return list[key]
        }
    }
    return null
}

function FormatChance(value)
{
    if (value >= 10) return value.toFixed(1).replace(".0", "") + "%"
    if (value >= 1) return value.toFixed(2).replace(/0+$/, "").replace(/\.$/, "") + "%"
    return value.toFixed(3).replace(/0+$/, "").replace(/\.$/, "") + "%"
}

const CHEST_RARITY_ORDER = ["common", "rare", "mythical", "legendary", "immortal", "super"]
const CHEST_RARITY_LABEL = {
    common: "C",
    rare: "B",
    mythical: "A",
    legendary: "S",
    immortal: "SSR",
    super: "UR",
}

function ApplyRarityRowClass(row, rarity)
{
    row.SetHasClass("Rarity_common", rarity === "common")
    row.SetHasClass("Rarity_rare", rarity === "rare")
    row.SetHasClass("Rarity_mythical", rarity === "mythical")
    row.SetHasClass("Rarity_legendary", rarity === "legendary")
    row.SetHasClass("Rarity_immortal", rarity === "immortal")
    row.SetHasClass("Rarity_super", rarity === "super")
}

function AddRarityChanceRow(rarity, chance)
{
    let row = $.CreatePanel("Panel", CHEST_CHANCE_PANELS.list, "")
    row.AddClass("ChestChanceRow")
    ApplyRarityRowClass(row, rarity)

    let badge = $.CreatePanel("Label", row, "")
    badge.AddClass("ChestChanceRarityBadge")
    badge.text = CHEST_RARITY_LABEL[rarity] || rarity.toUpperCase()

    let text = $.CreatePanel("Panel", row, "")
    text.AddClass("ChestChanceText")

    let name = $.CreatePanel("Label", text, "")
    name.AddClass("ChestChanceName")
    name.text = LocalizeTooltipKeyOrText("services_chest_rarity_" + rarity, rarity)

    let meta = $.CreatePanel("Label", text, "")
    meta.AddClass("ChestChanceMeta")
    meta.text = LocalizeTooltipKeyOrText("services_rarity_" + rarity, rarity)

    let value = $.CreatePanel("Label", row, "")
    value.AddClass("ChestChanceValue")
    value.text = FormatChance(chance)
}

function AddRewardChanceRow(reward, chance, items)
{
    let item = items[reward.id] || {}
    let rarity = String(reward.rarity || item.rarity || "common")

    let row = $.CreatePanel("Panel", CHEST_CHANCE_PANELS.list, "")
    row.AddClass("ChestChanceRow")
    ApplyRarityRowClass(row, rarity)

    let icon = $.CreatePanel("Panel", row, "")
    icon.AddClass("ChestChanceIcon")
    SetTooltipImage(icon, item.icon || "file://{images}/game_hud/icons/gold.png")

    let text = $.CreatePanel("Panel", row, "")
    text.AddClass("ChestChanceText")

    let name = $.CreatePanel("Label", text, "")
    name.AddClass("ChestChanceName")
    name.text = typeof LocalizeServiceItemName === "function" ? LocalizeServiceItemName(item, reward.id) : LocalizeTooltipKeyOrText(reward.id, reward.id)

    let meta = $.CreatePanel("Label", text, "")
    meta.AddClass("ChestChanceMeta")
    let rarity_text = LocalizeTooltipKeyOrText("services_rarity_" + rarity, rarity)
    meta.text = rarity_text + "  x" + String(Number(reward.count) || 1)

    let value = $.CreatePanel("Label", row, "")
    value.AddClass("ChestChanceValue")
    value.text = FormatChance(chance)
}

function UpdateTooltip()
{
    let chest_id = GetAttr("chest_id", "")
    let chest = FindChestConfig(chest_id)
    let items = GetServiceItemsTooltip()

    CHEST_CHANCE_PANELS.list.RemoveAndDeleteChildren()
    if (!chest)
    {
        CHEST_CHANCE_PANELS.title.text = LocalizeTooltipKeyOrText("services_chest_probability", "Drop chances")
        CHEST_CHANCE_PANELS.description.text = LocalizeTooltipKeyOrText("services_chest_chances_empty", "No reward data.")
        CHEST_CHANCE_PANELS.guarantee.text = ""
        return
    }

    CHEST_CHANCE_PANELS.title.text = LocalizeTooltipKeyOrText("chest_"+chest.id)
    CHEST_CHANCE_PANELS.description.text = LocalizeTooltipKeyOrText("services_chest_chances_description", "Chance is calculated from reward weights.")

    let rarity_chances = chest.rarity_chances || {}
    let has_rarity_chances = false
    for (let rarity of CHEST_RARITY_ORDER)
    {
        if ((Number(rarity_chances[rarity]) || 0) > 0)
        {
            has_rarity_chances = true
            AddRarityChanceRow(rarity, Number(rarity_chances[rarity]) || 0)
        }
    }

    if (!has_rarity_chances)
    {
        let rewards = Object.values(chest.rewards || {})
        let equal_chance = rewards.length > 0 ? 100 / rewards.length : 0
        for (let reward of rewards)
        {
            AddRewardChanceRow(reward, equal_chance, items)
        }
    }

    let guarantee_every = Number(chest.guarantee_every) || 0
    if (guarantee_every > 0)
    {
        CHEST_CHANCE_PANELS.guarantee.SetDialogVariable("value", String(guarantee_every))
        CHEST_CHANCE_PANELS.guarantee.text = $.Localize("#services_chest_chances_guarantee", CHEST_CHANCE_PANELS.guarantee)
    }
    else
    {
        CHEST_CHANCE_PANELS.guarantee.text = ""
    }
}