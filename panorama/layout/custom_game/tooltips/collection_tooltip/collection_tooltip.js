--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


function GetCollectionTooltipAttribute(name)
{
    return $.GetContextPanel().GetAttributeString(name, "")
}

function UpdateCollectionTooltip()
{
    var percent = Math.max(0, Math.min(100, Number(GetCollectionTooltipAttribute("percent")) || 0))
    var count = Number(GetCollectionTooltipAttribute("count")) || 0
    var bonus_raw = GetCollectionTooltipAttribute("bonus")

    var percent_label = $("#CollectionTooltipPercent")
    percent_label.text = $.Localize("#profile_collection_percent").replace("{p}", String(percent))
    $("#CollectionTooltipBarFill").style.width = percent + "%"

    var count_label = $("#CollectionTooltipCount")
    count_label.html = true
    count_label.text = $.Localize("#profile_collection_count").replace("{n}", WodaGold(String(count)))

    var stats = {}
    var bonus_parts = bonus_raw.split(",")
    for (var i = 0; i < bonus_parts.length; i++)
    {
        var pair = bonus_parts[i].split(":")
        if (pair.length == 2)
        {
            stats[pair[0]] = Number(pair[1]) || 0
        }
    }

    var list = $("#CollectionTooltipBonusList")
    list.RemoveAndDeleteChildren()
    var added = 0
    for (var s = 0; s < ARENA_STAT_ORDER.length; s++)
    {
        var key = ARENA_STAT_ORDER[s]
        if (!stats[key]) { continue }
        var line = $.CreatePanel("Label", list, "")
        line.AddClass("CollectionTooltipBonus")
        line.text = LocalizeArenaStat(line, key, stats[key])
        added++
    }
    if (added == 0)
    {
        var empty = $.CreatePanel("Label", list, "")
        empty.AddClass("CollectionTooltipBonus")
        empty.AddClass("Empty")
        empty.text = $.Localize("#profile_collection_empty")
    }
}