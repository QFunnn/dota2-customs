--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const TOOLTIP_PANELS =
{
    TooltipHeaderLabel : $("#TooltipHeaderLabel"),
    TooltipDescriptionLabel : $("#TooltipDescriptionLabel"),
}

function UpdateTooltip()
{
    let header_text = $.GetContextPanel().GetAttributeString("header", "")
    let description_text = $.GetContextPanel().GetAttributeString("description", "")
    TOOLTIP_PANELS.TooltipHeaderLabel.text = $.Localize("#"+header_text)
    TOOLTIP_PANELS.TooltipDescriptionLabel.text = $.Localize("#"+description_text)
}