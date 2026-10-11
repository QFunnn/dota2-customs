--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


var TOP_MENU_INFO_LAYOUT = "file://{resources}/layout/custom_game/top_menu_info/top_menu_info.xml"

function TopMenuInfo_Load()
{
    var host = $("#TopMenuInfoHost")
    if (!host) { return }
    if (host.GetChildCount() > 0) { return }
    host.BLoadLayout(TOP_MENU_INFO_LAYOUT, false, false)
}

function TopMenuInfo_Find(id)
{
    var host = $("#TopMenuInfoHost")
    if (!host) { return null }
    return host.FindChildTraverse(id)
}

function TopMenuInfo_SetLabel(id, value)
{
    var label = TopMenuInfo_Find(id)
    if (label)
    {
        label.text = String(value)
    }
}

function TopMenuInfo_Update(player_data)
{
    if (!player_data) { return }
    TopMenuInfo_SetLabel("CoinLabelCount", player_data.coins || 0)
    TopMenuInfo_SetLabel("CrystalLabelCount", player_data.crystals || 0)
    TopMenuInfo_SetLabel("WodaplusLabelCount", player_data.plus_days || 0)
    TopMenuInfo_SetLabel("WodaPremiumLabelCount", player_data.premium_days || 0)
    TopMenuInfo_SetLabel("BossSoulsLabelCount", player_data.boss_souls || 0)
    TopMenuInfo_SetLabel("BattlePassLabelCount", player_data.battlepass_level_2026 || 0)
    TopMenuInfo_SetLabel("DoubleTokensLabelCount", player_data.double_tokens || 0)
}

function TopMenuInfo_SetTooltips()
{
    if (typeof SetTextInfo !== "function") { return }
    var tooltips =
    {
        CoinBlock: "coin_information",
        CrystalBlock: "crystal_information",
        WodaplusBlock: "subscribe_information",
        WodaPremiumBlock: "premium_information",
        BossSoulsBlock: "boss_souls_information",
        BattlePassBlock: "battlepass_information",
        DoubleTokensBlock: "double_tokens_information",
    }
    for (var id in tooltips)
    {
        var block = TopMenuInfo_Find(id)
        if (block)
        {
            SetTextInfo(block, tooltips[id])
        }
    }
}