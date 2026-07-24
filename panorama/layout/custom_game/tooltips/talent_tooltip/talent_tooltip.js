--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const TALENT_TOOLTIP =
{
    title: $("#TalentTooltipTitle"),
    meta: $("#TalentTooltipMeta"),
    costIcon: $("#TalentTooltipCostIcon"),
    costValue: $("#TalentTooltipCostValue"),
    description: $("#TalentTooltipDescription"),
    requirements: $("#TalentTooltipRequirements"),
}

function GetAttr(name, fallback)
{
    return $.GetContextPanel().GetAttributeString(name, fallback || "")
}

function SetTalentTooltipPanelImage(panel, image)
{
    if (!panel || !image) return
    panel.style.backgroundImage = "url('" + image + "')"
}

function ParseJSONAttr(name, fallback)
{
    let value = GetAttr(name, "")
    if (value === "") return fallback || {}
    try
    {
        return JSON.parse(value) || fallback || {}
    }
    catch (e)
    {
        return fallback || {}
    }
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

function GetEquipmentConfig()
{
    return Game.GetCustomTable ? (Game.GetCustomTable("services_config", "equipment") || {}) : {}
}

function GetPlayerData()
{
    return Game.GetCustomTable ? (Game.GetCustomTable("services_player", String(Players.GetLocalPlayer())) || {}) : {}
}

function NormalizeRequirements(talent)
{
    let requires = talent && talent.requires || []
    if (requires.id) return [requires]
    return Object.values(requires || {})
}

function AddRequirement(requirement, talents, any_requirement, talent_configs)
{
    let row = $.CreatePanel("Label", TALENT_TOOLTIP.requirements, "")
    row.AddClass("TalentTooltipRequirement")
    let required_talent = talent_configs && talent_configs[requirement.id] || {}
    row.SetDialogVariable("name", LocalizeTooltipKeyOrText(required_talent.name || requirement.id, requirement.id))
    row.SetDialogVariable("value", String(Number(talents[requirement.id]) || 0))
    row.SetDialogVariable("max", String(Number(requirement.level) || 1))
    row.text = $.Localize(any_requirement ? "#services_talent_requirement_any" : "#services_talent_requirement", row)
}

function UpdateTooltip()
{
    let talent_id = GetAttr("talent_id", "")
    let config_id = Number(GetAttr("config_id", "1")) || 1
    let talent_configs = GetEquipmentConfig().talents || {}
    let talent = talent_configs[talent_id] || {}
    let player = GetPlayerData()
    let config = player.talents_data && player.talents_data.configurations_data && player.talents_data.configurations_data[config_id] || {}
    let talents = ParseJSONAttr("talents", config.talents || {})
    let level = Number(GetAttr("level", "")) || Number(talents[talent_id]) || 0
    let max_level = Number(GetAttr("max_level", "")) || Number(talent.max_level) || 1
    let cost = Number(GetAttr("cost", "")) || Number(talent.cost) || 1

    TALENT_TOOLTIP.title.text = LocalizeTooltipKeyOrText(talent.name || talent_id, talent_id)
    TALENT_TOOLTIP.meta.SetDialogVariable("level", String(level))
    TALENT_TOOLTIP.meta.SetDialogVariable("max", String(max_level))
    TALENT_TOOLTIP.meta.SetDialogVariable("cost", String(cost))
    TALENT_TOOLTIP.meta.text = $.Localize("#services_talent_tooltip_meta", TALENT_TOOLTIP.meta)
    let talent_point_item = (Game.GetCustomTable ? (Game.GetCustomTable("services_config", "items") || {}) : {}).talent_point || {}
    if (TALENT_TOOLTIP.costIcon)
    {
        SetTalentTooltipPanelImage(TALENT_TOOLTIP.costIcon, talent_point_item.icon || "file://{images}/game_hud/services/talent_point.png")
    }
    if (TALENT_TOOLTIP.costValue)
    {
        TALENT_TOOLTIP.costValue.SetDialogVariable("cost", String(cost))
        TALENT_TOOLTIP.costValue.text = $.Localize("#services_talent_tooltip_cost", TALENT_TOOLTIP.costValue)
    }
    TALENT_TOOLTIP.description.text = LocalizeTooltipKeyOrText(talent.description || (talent_id + "_description"), $.Localize("#services_talent_description_coming_soon"))

    TALENT_TOOLTIP.requirements.RemoveAndDeleteChildren()
    let requirements = NormalizeRequirements(talent)
    let any_requirements = []
    let normal_requirements = []
    for (let requirement of requirements)
    {
        let required_level = Number(requirement.level) || 1
        let current_level = Number(talents[requirement.id]) || 0
        if (requirement.any)
        {
            any_requirements.push({ requirement: requirement, passed: current_level >= required_level })
        }
        else if (current_level < required_level)
        {
            normal_requirements.push(requirement)
        }
    }

    for (let requirement of normal_requirements)
    {
        AddRequirement(requirement, talents, false, talent_configs)
    }

    let has_any_passed = false
    for (let entry of any_requirements)
    {
        has_any_passed = has_any_passed || entry.passed
    }
    if (any_requirements.length > 0 && !has_any_passed)
    {
        for (let entry of any_requirements)
        {
            AddRequirement(entry.requirement, talents, true, talent_configs)
        }
    }
}