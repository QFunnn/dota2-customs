--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


var ITEM_RARITY_LIST =
[
    {id: "E", name: "rarity_E", color: "#ffffff", max_price: 150},
    {id: "C", name: "rarity_C", color: "#3d86ff", max_price: 500},
    {id: "B", name: "rarity_B", color: "#b04ee6", max_price: 1000},
    {id: "A", name: "rarity_A", color: "#f2d21c", max_price: 1500},
    {id: "S", name: "rarity_S", color: "#ff8a1f", max_price: 5000},
    {id: "R", name: "rarity_R", color: "#ff3b3b", max_price: 10000},
    {id: "U", name: "rarity_U", color: "#3fe05a", max_price: -1},
]

var ITEM_RARITY_OVERRIDES =
{
    "1096": "R",
    "1097": "S",
    "1098": "S",
    "1103": "R",
}

function GetItemArenaBonus(item_id)
{
    if (typeof ITEM_ARENA_BONUS === "undefined" || item_id === undefined || item_id === null)
    {
        return null
    }
    return ITEM_ARENA_BONUS[String(item_id)] || null
}

var RUNE_RARITY_DEFAULT = null

var RUNE_RARITY_OVERRIDES =
{
}

var ITEM_TOOLTIP_ID = "woda_item_tooltip"
var ITEM_TOOLTIP_LAYOUT = "file://{resources}/layout/custom_game/tooltips/item_tooltip/item_tooltip.xml"

function GetRarityInfo(rarity_id)
{
    for (var i = 0; i < ITEM_RARITY_LIST.length; i++)
    {
        if (ITEM_RARITY_LIST[i].id == rarity_id)
        {
            return ITEM_RARITY_LIST[i]
        }
    }
    return null
}

function GetRarityByPrice(price)
{
    var value = Number(price)
    if (isNaN(value))
    {
        return null
    }
    for (var i = 0; i < ITEM_RARITY_LIST.length; i++)
    {
        var info = ITEM_RARITY_LIST[i]
        if (info.max_price < 0 || value <= info.max_price)
        {
            return info.id
        }
    }
    return null
}

function GetItemRarity(item_id, price)
{
    if (ITEM_RARITY_OVERRIDES[String(item_id)])
    {
        return ITEM_RARITY_OVERRIDES[String(item_id)]
    }
    return GetRarityByPrice(price)
}

function GetRuneRarity(rune_id)
{
    if (RUNE_RARITY_OVERRIDES[String(rune_id)])
    {
        return RUNE_RARITY_OVERRIDES[String(rune_id)]
    }
    return RUNE_RARITY_DEFAULT
}

function GetShopCosmeticTables()
{
    var result = []
    if (typeof Items_pets !== "undefined") { result.push([Items_pets, "Items_pets"]) }
    if (typeof Items_Five !== "undefined") { result.push([Items_Five, "Items_Five"]) }
    if (typeof Items_emblems !== "undefined") { result.push([Items_emblems, "Items_emblems"]) }
    if (typeof Items_heads !== "undefined") { result.push([Items_heads, "Items_heads"]) }
    if (typeof Items_tips !== "undefined") { result.push([Items_tips, "Items_tips"]) }
    if (typeof Items_Backround !== "undefined") { result.push([Items_Backround, "Items_Backround"]) }
    if (typeof Items_tpscroll !== "undefined") { result.push([Items_tpscroll, "Items_tpscroll"]) }
    return result
}

function FindShopItemRow(item_id)
{
    var tables = GetShopCosmeticTables()
    for (var t = 0; t < tables.length; t++)
    {
        var table = tables[t][0]
        for (var i = 0; i < table.length; i++)
        {
            if (String(table[i][0]) == String(item_id))
            {
                return {row: table[i], type: tables[t][1]}
            }
        }
    }
    return null
}

function GetShopRowIcon(row)
{
    if (String(row[4]).indexOf("pet_") === 0)
    {
        return "file://{images}/custom_game/shop/" + row[0] + ".png"
    }
    return "file://{images}/custom_game/shop/" + row[3] + ".png"
}

function GetShopRowRarity(row)
{
    return GetItemRarity(row[0], row[2])
}

function GetItemRarityById(item_id)
{
    var found = FindShopItemRow(item_id)
    if (!found)
    {
        return null
    }
    return GetShopRowRarity(found.row)
}

function ApplyRarityGlow(panel, rarity_id)
{
    if (!panel) { return }
    for (var i = 0; i < ITEM_RARITY_LIST.length; i++)
    {
        panel.SetHasClass("RarityGlow_" + ITEM_RARITY_LIST[i].id, ITEM_RARITY_LIST[i].id == rarity_id)
    }
}

function BuildItemTooltipParams(params)
{
    var parts = []
    for (var key in params)
    {
        if (params[key] === null || params[key] === undefined || params[key] === "")
        {
            continue
        }
        parts.push(key + "=" + String(params[key]))
    }
    return parts.join("&")
}

function SetItemTooltip(panel, params)
{
    panel.SetPanelEvent("onmouseover", function()
    {
        var data = typeof params === "function" ? params() : params
        var arena_bonus = data && !data.rune_id ? GetItemArenaBonus(data.item_id) : null
        if (arena_bonus)
        {
            var copy = {}
            for (var key in data) { copy[key] = data[key] }
            copy.bonus_stat = arena_bonus[0]
            copy.bonus_value = arena_bonus[1]
            data = copy
        }
        $.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, ITEM_TOOLTIP_ID, ITEM_TOOLTIP_LAYOUT, BuildItemTooltipParams(data))
    })
    panel.SetPanelEvent("onmouseout", function()
    {
        $.DispatchEvent("UIHideCustomLayoutTooltip", panel, ITEM_TOOLTIP_ID)
    })
}

function SetShopItemTooltip(panel, item_id)
{
    var found = FindShopItemRow(item_id)
    if (!found)
    {
        return null
    }
    var rarity = GetShopRowRarity(found.row)
    SetItemTooltip(panel, {
        item_id: item_id,
        name_key: found.row[4],
        desc_key: found.row[4] + "_description",
        rarity: rarity,
        icon: GetShopRowIcon(found.row),
    })
    return rarity
}

function SetRuneTooltip(panel, rune_id)
{
    SetItemTooltip(panel, function()
    {
        return {
            name_key: rune_id,
            rune_id: rune_id,
            level: typeof GetRuneLevel === "function" ? GetRuneLevel(rune_id) : 0,
            rarity: GetRuneRarity(rune_id),
            icon: "file://{images}/custom_game/runes/" + rune_id + ".png",
        }
    })
}