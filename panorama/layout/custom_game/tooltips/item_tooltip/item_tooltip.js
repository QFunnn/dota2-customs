--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const TOOLTIP_PANELS = 
{
    ItemImage : $("#ItemImage"),
    ItemName : $("#ItemName"),
    ItemActivePanelHeaderLabel : $("#ItemActivePanelHeaderLabel"),
    ItemActiveDescription : $("#ItemActiveDescription"),
}

function UpdateTooltip()
{
    let item_name = $.GetContextPanel().GetAttributeString("item_name", "")
    TOOLTIP_PANELS.ItemImage.itemname = item_name
    TOOLTIP_PANELS.ItemName.text = $.Localize("#dota_tooltip_ability_"+item_name)
    TOOLTIP_PANELS.ItemActivePanelHeaderLabel.text = $.Localize("#dota_tooltip_ability_"+item_name+"_header")
    TOOLTIP_PANELS.ItemActiveDescription.text = GameUI.ReplaceDOTAAbilitySpecialValues(item_name, $.Localize("#dota_tooltip_ability_"+item_name+"_description"))
}