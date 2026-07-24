--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const TOOLTIP_PANELS = 
{
    BundlesList : $("#BundlesList"),
}

function UpdateTooltip()
{
    let bundles_list = Game.GetCustomTable("consumed_bundles_data", String(Game.GetLocalPlayerID()))
    TOOLTIP_PANELS.BundlesList.RemoveAndDeleteChildren()
    for (let bundle_name of Object.keys(bundles_list))
    {
        let bundle_label = $.CreatePanel("Label", TOOLTIP_PANELS.BundlesList, "")
        bundle_label.AddClass("bundle_label")
        bundle_label.text = $.Localize("#"+bundle_name) + ":" + " " + bundles_list[bundle_name].card_have + "/" + bundles_list[bundle_name].card_max
    }
}