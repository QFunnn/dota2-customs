--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const CRYSTAL_TOOLTIP =
{
    title: $("#CrystalTooltipTitle"),
    meta: $("#CrystalTooltipMeta"),
    requirement: $("#CrystalTooltipRequirement"),
    stats: $("#CrystalTooltipStats"),
    description: $("#CrystalTooltipDescription"),
}

const CRYSTAL_CATEGORY_ORDER = ["C", "B", "A", "S", "SS", "SSS"]

function GetAttr(name, fallback)
{
    return $.GetContextPanel().GetAttributeString(name, fallback || "")
}

function GetEquipmentConfig()
{
    return Game.GetCustomTable ? (Game.GetCustomTable("services_config", "equipment") || {}) : {}
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

function FormatCrystalNumber(value)
{
    value = Number(value) || 0
    if (Math.floor(value) === value) return String(value)
    return value.toFixed(2).replace(/0+$/, "").replace(/\.$/, "")
}

function FormatCrystalValue(value, percent)
{
    return "+" + FormatCrystalNumber(value) + (percent ? "%" : "")
}

function GetStatName(stat_id)
{
    return LocalizeTooltipKeyOrText("services_crystal_stat_" + stat_id, stat_id)
}

function ApplyCrystalRankClass(panel, category)
{
    if (!panel) return
    for (let rank of CRYSTAL_CATEGORY_ORDER)
    {
        panel.SetHasClass("CrystalRank_" + rank, rank === category)
    }
}

function ClearCrystalMeta()
{
    CRYSTAL_TOOLTIP.meta.RemoveAndDeleteChildren()
}

function AddCrystalMetaLabel(text, class_name, category)
{
    let label = $.CreatePanel("Label", CRYSTAL_TOOLTIP.meta, "")
    label.AddClass("CrystalTooltipMetaText")
    if (class_name)
    {
        label.AddClass(class_name)
    }
    if (category)
    {
        ApplyCrystalRankClass(label, category)
    }
    label.text = text
    return label
}

function SetCrystalMeta(category, suffix)
{
    ClearCrystalMeta()
    AddCrystalMetaLabel(LocalizeTooltipKeyOrText("services_crystal_rank_label", "Rank") + " ")
    AddCrystalMetaLabel(category, "CrystalRankText", category)
    AddCrystalMetaLabel(" | " + suffix)
}

function AddStatLine(name, value)
{
    let line = $.CreatePanel("Panel", CRYSTAL_TOOLTIP.stats, "")
    line.AddClass("CrystalTooltipStatLine")
    if (value === undefined || value === null || String(value) === "")
    {
        line.AddClass("CrystalTooltipStatLineText")
    }
    let name_panel = $.CreatePanel("Label", line, "")
    name_panel.AddClass("CrystalTooltipStatName")
    name_panel.html = true
    name_panel.text = name
    let value_panel = $.CreatePanel("Label", line, "")
    value_panel.AddClass("CrystalTooltipStatValue")
    value_panel.html = true
    value_panel.text = value
}

function AddCrystalStats(stats, level, total_level, show_per_level)
{
    for (let stat of Object.values(stats || {}))
    {
        if (stat.text)
        {
            AddStatLine(LocalizeTooltipKeyOrText(stat.text, ""), "")
            continue
        }
        let value = Number(stat.value) || 0
        let base = Number(stat.base) || 0
        let current_value = base + value * Math.max(0, Number(level) || 0)
        if (stat.scale === "category_total_level")
        {
            current_value = value * Math.max(0, Number(total_level) || 0)
        }
        let stat_name = GetStatName(stat.id)
        let is_percent = !!stat.percent || IsLevelUpPercentStatName(stat.id)
        let current_text = FormatCrystalValue(current_value, is_percent)
        let per_level_text = "<font color='#7dff8a'>(" + FormatCrystalValue(value, is_percent) + " " + LocalizeTooltipKeyOrText("services_crystal_per_level_short", "per level") + ")</font>"
        if (stat.per_hero_level !== undefined)
        {
            current_text = FormatCrystalValue(value, is_percent) + " + " + FormatCrystalNumber(stat.per_hero_level) + " x " + LocalizeTooltipKeyOrText("services_crystal_formula_hero_level", "hero level")
        }
        if (stat.per_profile_level !== undefined)
        {
            current_text = FormatCrystalValue(value, is_percent) + " + " + FormatCrystalNumber(stat.per_profile_level) + " x " + LocalizeTooltipKeyOrText("services_crystal_formula_profile_level", "profile level")
        }
        if (stat.scale === "category_total_level")
        {
            current_text = current_text + " <font color='#7dff8a'>(" + FormatCrystalValue(value, is_percent) + " x " + LocalizeTooltipKeyOrText("services_crystal_formula_category_total", "category total level") + ")</font>"
        }
        if (show_per_level && value !== 0 && stat.scale !== "category_total_level" && stat.per_hero_level === undefined && stat.per_profile_level === undefined)
        {
            current_text = current_text + " " + per_level_text
        }
        AddStatLine(stat_name, current_text)
    }
}

function GetCategoryConfig(category)
{
    let crystals = GetEquipmentConfig().crystals || {}
    return crystals.categories && crystals.categories[category] || {}
}

function GetCrystalConfig(category, index)
{
    let category_config = GetCategoryConfig(category)
    let crystals = category_config.crystals || {}
    return crystals[index] || crystals[String(index)] || {}
}

function RenderCrystalTooltip()
{
    let category = GetAttr("category", "")
    let index = Number(GetAttr("index", "0")) || 0
    let level = Number(GetAttr("level", "0")) || 0
    let total_level = Number(GetAttr("total_level", "0")) || 0
    let config = GetCrystalConfig(category, index)
    let max_level = Number(config.max_level) || 0

    CRYSTAL_TOOLTIP.title.text = LocalizeTooltipKeyOrText(config.name || config.id || ("crystal_" + category + "_" + index), category + " " + index)
    ApplyCrystalRankClass(CRYSTAL_TOOLTIP.title, category)
    SetCrystalMeta(category, LocalizeTooltipKeyOrText("services_crystal_level_label", "Level") + " " + String(level) + "/" + String(max_level))
    CRYSTAL_TOOLTIP.requirement.style.visibility = "collapse"
    AddCrystalStats(config.stats || {}, level, total_level, max_level > 0)
    CRYSTAL_TOOLTIP.description.text = LocalizeTooltipKeyOrText("services_crystal_default_description", "")
}

function RenderRareTooltip()
{
    let category = GetAttr("category", "")
    let total_level = Number(GetAttr("total_level", "0")) || 0
    let category_config = GetCategoryConfig(category)
    let config = category_config.rare_crystal || {}
    let threshold = Number(category_config.rare_threshold) || 0

    CRYSTAL_TOOLTIP.title.text = LocalizeTooltipKeyOrText(config.name || config.id || ("rare_crystal_" + category), category)
    ApplyCrystalRankClass(CRYSTAL_TOOLTIP.title, category)
    SetCrystalMeta(category, LocalizeTooltipKeyOrText("services_crystal_total_level_label", "Total level") + " " + String(total_level) + "/" + String(threshold))
    CRYSTAL_TOOLTIP.requirement.style.visibility = total_level >= threshold ? "collapse" : "visible"
    CRYSTAL_TOOLTIP.requirement.SetDialogVariable("value", String(total_level))
    CRYSTAL_TOOLTIP.requirement.SetDialogVariable("max", String(threshold))
    CRYSTAL_TOOLTIP.requirement.text = $.Localize("#services_crystal_activation_condition_value", CRYSTAL_TOOLTIP.requirement)
    AddCrystalStats(config.stats || {}, 1, total_level, false)
    if (CRYSTAL_TOOLTIP.stats.Children().length <= 0)
    {
        AddStatLine(LocalizeTooltipKeyOrText("services_crystal_no_bonus_yet", "Bonus"), LocalizeTooltipKeyOrText("services_crystal_no_bonus_yet_value", "Coming soon"))
    }
    CRYSTAL_TOOLTIP.description.text = LocalizeTooltipKeyOrText("services_crystal_rare_description", "")
}

function RenderPullTooltip()
{
    let crystals = GetEquipmentConfig().crystals || {}
    let categories = crystals.categories || {}
    let total_weight = 0
    for (let category of CRYSTAL_CATEGORY_ORDER)
    {
        total_weight += Number(categories[category] && categories[category].weight) || 0
    }

    CRYSTAL_TOOLTIP.title.text = LocalizeTooltipKeyOrText("services_crystal_pull_title", "Crystal draw")
    ApplyCrystalRankClass(CRYSTAL_TOOLTIP.title, "")
    CRYSTAL_TOOLTIP.requirement.style.visibility = "collapse"
    ClearCrystalMeta()
    AddCrystalMetaLabel(LocalizeTooltipKeyOrText("services_crystal_pull_meta", ""))
    for (let category of CRYSTAL_CATEGORY_ORDER)
    {
        let category_config = categories[category] || {}
        let weight = Number(category_config.weight) || 0
        let chance = total_weight > 0 ? (weight / total_weight) * 100 : 0
        let max_level = 0
        for (let crystal of Object.values(category_config.crystals || {}))
        {
            max_level = Math.max(max_level, Number(crystal.max_level) || 0)
        }
        let value = FormatCrystalNumber(chance) + "% / " + LocalizeTooltipKeyOrText("services_crystal_max_level_short", "max") + " " + String(max_level)
        AddStatLine(category, value)
    }
    CRYSTAL_TOOLTIP.description.text = LocalizeTooltipKeyOrText("services_crystal_pull_description", "")
}

function UpdateTooltip()
{
    CRYSTAL_TOOLTIP.stats.RemoveAndDeleteChildren()
    let mode = GetAttr("mode", "crystal")
    if (mode === "pull")
    {
        RenderPullTooltip()
    }
    else if (mode === "rare")
    {
        RenderRareTooltip()
    }
    else
    {
        RenderCrystalTooltip()
    }
}