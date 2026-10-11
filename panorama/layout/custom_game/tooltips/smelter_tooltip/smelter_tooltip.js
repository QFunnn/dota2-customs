--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


var SMELTER_TOOLTIP_RARITY_ORDER = ["E", "C", "B", "A", "S", "R"]

function GetSmelterTooltipAttribute(name)
{
    return $.GetContextPanel().GetAttributeString(name, "")
}

function UpdateSmelterTooltip()
{
    var level = Number(GetSmelterTooltipAttribute("level")) || 0
    var bonus_raw = GetSmelterTooltipAttribute("bonus")
    var max_level = Number(GetSmelterTooltipAttribute("max")) || 0
    var exp_raw = GetSmelterTooltipAttribute("exp")

    var level_label = $("#SmelterTooltipLevel")
    level_label.text = $.Localize("#shop_smelter_level") + " " + level + " / " + max_level

    var exp_map = {}
    var exp_parts = exp_raw.split(",")
    for (var i = 0; i < exp_parts.length; i++)
    {
        var pair = exp_parts[i].split(":")
        if (pair.length == 2)
        {
            exp_map[pair[0]] = Number(pair[1]) || 0
        }
    }

    var list = $("#SmelterTooltipExpList")
    list.RemoveAndDeleteChildren()
    for (var r = 0; r < SMELTER_TOOLTIP_RARITY_ORDER.length; r++)
    {
        var rarity = SMELTER_TOOLTIP_RARITY_ORDER[r]
        if (exp_map[rarity] == null) { continue }
        CreateSmelterTooltipRow(list, $.Localize("#rarity_" + rarity), "RarityText_" + rarity, exp_map[rarity])
    }
    if (exp_map["rune"] != null)
    {
        CreateSmelterTooltipRow(list, $.Localize("#smelter_tt_rune"), "SmelterTooltipRuneName", exp_map["rune"])
    }
    if (exp_map["coal"] != null)
    {
        CreateSmelterTooltipRow(list, $.Localize("#chest_reward_coal"), "SmelterTooltipRuneName", exp_map["coal"])
    }

    var bonus_label = $("#SmelterTooltipBonus")
    var bonus_lines = [$.Localize("#smelter_tt_bonus")]
    var bonus_parts = bonus_raw.split(",")
    for (var b = 0; b < bonus_parts.length; b++)
    {
        var bonus_pair = bonus_parts[b].split(":")
        if (bonus_pair.length == 2)
        {
            bonus_lines.push(LocalizeArenaStat(bonus_label, bonus_pair[0], Number(bonus_pair[1]) || 0))
        }
    }
    bonus_label.html = true
    bonus_label.text = bonus_lines.join("<br>")
}

function CreateSmelterTooltipRow(parent, name_text, name_class, exp)
{
    var row = $.CreatePanel("Panel", parent, "")
    row.AddClass("SmelterTooltipExpRow")
    var name = $.CreatePanel("Label", row, "")
    name.AddClass("SmelterTooltipExpName")
    name.AddClass(name_class)
    name.text = name_text
    var value = $.CreatePanel("Label", row, "")
    value.AddClass("SmelterTooltipExpValue")
    value.text = "+" + exp + " " + $.Localize("#shop_smelter_exp")
}