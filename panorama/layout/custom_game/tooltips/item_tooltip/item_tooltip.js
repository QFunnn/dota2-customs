--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


function GetTooltipAttribute(name)
{
    return $.GetContextPanel().GetAttributeString(name, "")
}

function LocalizeOrEmpty(key)
{
    if (!key) { return "" }
    var text = $.Localize("#" + key)
    if (text == "#" + key || text == key)
    {
        return ""
    }
    return text
}

function UpdateItemTooltip()
{
    var name_key = GetTooltipAttribute("name_key")
    var desc_key = GetTooltipAttribute("desc_key")
    var rune_id = GetTooltipAttribute("rune_id")
    var level = Number(GetTooltipAttribute("level")) || 0
    var rarity_id = GetTooltipAttribute("rarity")
    var icon = GetTooltipAttribute("icon")

    var tooltip = $("#ItemTooltip")
    var name_label = $("#ItemTooltipName")
    var rarity_label = $("#ItemTooltipRarity")
    var rarity_row = $("#ItemTooltipRarityRow")
    var icon_panel = $("#ItemTooltipIcon")
    var description = $("#ItemTooltipDescription")

    name_label.text = LocalizeOrEmpty(name_key) || name_key

    if (icon)
    {
        icon_panel.style.backgroundImage = 'url("' + icon + '")'
        icon_panel.style.backgroundSize = "100%"
        icon_panel.SetHasClass("TipImage", icon.indexOf("/tip.png") >= 0)
        icon_panel.style.visibility = "visible"
    }
    else
    {
        icon_panel.style.visibility = "collapse"
    }

    var rarity = GetRarityInfo(rarity_id)
    for (var i = 0; i < ITEM_RARITY_LIST.length; i++)
    {
        var id = ITEM_RARITY_LIST[i].id
        var active = rarity ? rarity.id == id : false
        name_label.SetHasClass("RarityText_" + id, active)
        rarity_label.SetHasClass("RarityText_" + id, active)
        icon_panel.SetHasClass("RarityGlow_" + id, active)
    }
    if (rarity)
    {
        $("#ItemTooltipRarityLabel").text = $.Localize("#rarity_label") + ":"
        rarity_label.text = $.Localize("#" + rarity.name)
        rarity_row.style.visibility = "visible"
    }
    else
    {
        rarity_row.style.visibility = "collapse"
    }

    var description_text = ""
    if (rune_id)
    {
        description_text = FormatRuneDescription(rune_id, level)
    }
    else
    {
        description_text = LocalizeOrEmpty(desc_key)
    }
    description.text = description_text
    description.style.visibility = description_text ? "visible" : "collapse"

    var bonus_stat = GetTooltipAttribute("bonus_stat")
    var bonus_value = Number(GetTooltipAttribute("bonus_value")) || 0
    var bonus_block = $("#ItemTooltipBonusBlock")
    var bonus_label = $("#ItemTooltipBonus")
    if (!bonus_block || !bonus_label)
    {
        return
    }
    if (bonus_stat != "" && bonus_value != 0)
    {
        bonus_label.text = LocalizeArenaStat(bonus_label, bonus_stat, bonus_value)
        bonus_block.style.visibility = "visible"
    }
    else
    {
        bonus_block.style.visibility = "collapse"
    }
}