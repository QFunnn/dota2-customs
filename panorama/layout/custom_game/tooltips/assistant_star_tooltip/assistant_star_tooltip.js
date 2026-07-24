--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function UpdateTooltip()
{
    let ctx = $.GetContextPanel()
    let level = Number(ctx.GetAttributeString("level", "0")) || 0
    let max = Number(ctx.GetAttributeString("max", "5")) || 5

    let bonuses = []
    try { bonuses = JSON.parse(ctx.GetAttributeString("bonuses", "[]")) || [] }
    catch (e) { bonuses = [] }

    let starsRow = $("#StarsRow")
    starsRow.RemoveAndDeleteChildren()
    for (let i = 0; i < max; i++)
    {
        let star = $.CreatePanel("Panel", starsRow, "")
        star.AddClass("AssistantStarTooltipStar")
        star.SetHasClass("AssistantStarTooltipStarLit", i < level)
        star.SetHasClass("AssistantStarTooltipStarDim", i >= level)
    }

    let list = $("#BonusList")
    list.RemoveAndDeleteChildren()
    for (let bonus of bonuses)
    {
        let row = $.CreatePanel("Panel", list, "")
        row.AddClass("AssistantStarTooltipBonusRow")

        let name = $.CreatePanel("Label", row, "")
        name.AddClass("AssistantStarTooltipBonusName")
        name.text = bonus.name || ""

        let value = $.CreatePanel("Label", row, "")
        value.AddClass("AssistantStarTooltipBonusValue")
        value.text = bonus.value || ""
        value.visible = !!bonus.value
    }
}