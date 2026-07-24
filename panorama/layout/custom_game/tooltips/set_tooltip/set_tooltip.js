--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function GetSetsTooltipConfig()
{
    let equipment = Game.GetCustomTable ? (Game.GetCustomTable("services_config", "equipment") || {}) : {}
    return equipment.sets || {}
}

function LocalizeSetKeyOrText(value)
{
    let text = String(value || "")
    if (text === "") return ""
    let key = text.charAt(0) === "#" ? text : "#" + text
    if ($.CanLocalize && $.CanLocalize(key))
    {
        return $.Localize(key)
    }
    return text.charAt(0) === "#" ? text.substring(1) : text
}

function UpdateTooltip()
{
    let ctx = $.GetContextPanel()
    let set_id = String(ctx.GetAttributeString("set_id", ""))
    let equipped_count = Number(ctx.GetAttributeString("equipped_count", "0")) || 0

    let header = $("#SetTooltipHeader")
    let body = $("#SetTooltipBonuses")
    body.RemoveAndDeleteChildren()

    let sets = GetSetsTooltipConfig()
    let set_config = (sets.list || {})[set_id]
    if (!set_config)
    {
        header.text = ""
        return
    }

    let bonuses = Object.values(set_config.bonuses || {})
    bonuses.sort(function(a, b) { return (Number(a.pieces) || 0) - (Number(b.pieces) || 0) })
    let max_pieces = 0
    for (let i = 0; i < bonuses.length; i++) max_pieces = Math.max(max_pieces, Number(bonuses[i].pieces) || 0)

    header.text = LocalizeSetKeyOrText(set_config.name || set_id) + " (" + equipped_count + "/" + max_pieces + ")"

    for (let i = 0; i < bonuses.length; i++)
    {
        let bonus = bonuses[i]
        let pieces = Number(bonus.pieces) || 0
        let row = $.CreatePanel("Label", body, "")
        row.AddClass("SetTooltipBonus")
        row.SetHasClass("SetTooltipBonusActive", equipped_count >= pieces)
        row.text = "[" + pieces + "] " + LocalizeSetKeyOrText(bonus.desc || "")
    }
}