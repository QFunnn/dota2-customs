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
    let parent = $.GetContextPanel().GetParent().GetParent();

    let header_text = $.GetContextPanel().GetAttributeString("header", "")
    let description_text = $.GetContextPanel().GetAttributeString("description", "")
    let description_text_2 = $.GetContextPanel().GetAttributeString("description_2", "")

    $("#CurrencyName").text = $.Localize("#"+header_text)
    $("#SpendType").text = $.Localize("#"+description_text)
    $("#IncomeType").text = $.Localize("#"+description_text_2)
}