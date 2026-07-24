--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const NEUTRAL_ROSHAN_BONUS_TOOLTIP = {
    title: $("#NeutralRoshanBonusTooltipTitle"),
    description: $("#NeutralRoshanBonusTooltipDescription"),
    requirement: $("#NeutralRoshanBonusTooltipRequirement"),
}

function GetAttr(name, fallback)
{
    return $.GetContextPanel().GetAttributeString(name, fallback || "")
}

function LocalizeKey(key)
{
    if (!key) return ""
    return $.Localize("#" + key)
}

function UpdateTooltip()
{
    const title_key = GetAttr("title_key", "")
    const description_key = GetAttr("description_key", "")
    const requirement_key = GetAttr("requirement_key", "")

    NEUTRAL_ROSHAN_BONUS_TOOLTIP.title.text = LocalizeKey(title_key)
    NEUTRAL_ROSHAN_BONUS_TOOLTIP.description.text = LocalizeKey(description_key)

    const has_requirement = requirement_key !== ""
    NEUTRAL_ROSHAN_BONUS_TOOLTIP.requirement.SetHasClass("Hidden", !has_requirement)
    NEUTRAL_ROSHAN_BONUS_TOOLTIP.requirement.text = has_requirement ? LocalizeKey(requirement_key) : ""
}