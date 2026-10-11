--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


function PlayerStatsPanel_Create(container, summary_only)
{
    container.RemoveAndDeleteChildren()
    var panel = $.CreatePanel("Panel", container, "")
    panel.BLoadLayout("file://{resources}/layout/custom_game/player_stats_panel/player_stats_panel.xml", false, false)
    panel.SetHasClass("SummaryOnly", summary_only === true)
    return panel
}

function PlayerStatsPanel_FormatChange(value)
{
    if (value > 0)
    {
        return "+" + value
    }
    return String(value)
}

function PlayerStatsPanel_SetText(root, id, value)
{
    var label = root.FindChildTraverse(id)
    if (label)
    {
        label.text = String(value)
    }
}

function PlayerStatsPanel_SetTooltip(panel, token)
{
    panel.SetPanelEvent("onmouseover", function()
    {
        $.DispatchEvent("DOTAShowTextTooltip", panel, $.Localize(token))
    })
    panel.SetPanelEvent("onmouseout", function()
    {
        $.DispatchEvent("DOTAHideTextTooltip", panel)
    })
}

function PlayerStatsPanel_IsDouble(data)
{
    return Number(data.is_double) == 1 || data.is_double === true
}

function PlayerStatsPanel_FixIcons(panel)
{
    var icons = panel.FindChildrenWithClassTraverse("PlayerStatsIcon")
    for (var i = 0; i < icons.length; i++)
    {
        icons[i].style.backgroundSize = "100%"
        icons[i].style.backgroundRepeat = "no-repeat"
    }
}

function PlayerStatsPanel_Fill(panel, data)
{
    var is_arena = data.mode == "arena"
    panel.SetHasClass("ArenaMode", is_arena)

    var place = Number(data.place) || 0
    var total = Number(data.places_total) || 0
    var PlayerStatsPlace = panel.FindChildTraverse("PlayerStatsPlace")
    if (PlayerStatsPlace)
    {
        if (place > 0)
        {
            PlayerStatsPlace.SetDialogVariableInt("place", place)
            PlayerStatsPlace.SetDialogVariableInt("total", Math.max(total, place))
            PlayerStatsPlace.text = $.Localize("#eliminated_place_text", PlayerStatsPlace)
        }
        else
        {
            PlayerStatsPlace.text = "-"
        }
    }

    var rating_now = Number(data.rating_now) || 0
    var rating_change = Number(data.rating_change) || 0
    var is_double = !is_arena && PlayerStatsPanel_IsDouble(data)
    var rating_new = is_arena ? Math.max(rating_now, rating_change) : rating_now + rating_change
    PlayerStatsPanel_SetText(panel, "PlayerStatsRatingNow", rating_now)
    PlayerStatsPanel_SetText(panel, "PlayerStatsRatingNew", rating_new)
    var PlayerStatsRatingChange = panel.FindChildTraverse("PlayerStatsRatingChange")
    if (PlayerStatsRatingChange)
    {
        PlayerStatsRatingChange.text = is_arena ? String(rating_change) : PlayerStatsPanel_FormatChange(rating_change)
        PlayerStatsRatingChange.visible = rating_change != 0
        PlayerStatsRatingChange.SetHasClass("Negative", rating_change < 0)
        PlayerStatsRatingChange.SetHasClass("Double", is_double)
        PlayerStatsRatingChange.SetHasClass("Arena", is_arena)
    }
    var PlayerStatsBadgeDouble = panel.FindChildTraverse("PlayerStatsBadgeDouble")
    if (PlayerStatsBadgeDouble)
    {
        PlayerStatsBadgeDouble.SetHasClass("Visible", is_double)
    }

    var coins = Number(data.coins_change) || 0
    PlayerStatsPanel_SetText(panel, "PlayerStatsCoins", PlayerStatsPanel_FormatChange(coins))
    var PlayerStatsBadgePlus = panel.FindChildTraverse("PlayerStatsBadgePlus")
    if (PlayerStatsBadgePlus)
    {
        PlayerStatsBadgePlus.SetHasClass("Visible", Number(data.has_plus) == 1 && coins > 0)
    }
    var PlayerStatsBadgePremium = panel.FindChildTraverse("PlayerStatsBadgePremium")
    if (PlayerStatsBadgePremium)
    {
        PlayerStatsBadgePremium.SetHasClass("Visible", Number(data.has_premium) == 1 && coins > 0)
    }
    var souls = Number(data.boss_souls_change) || 0
    var PlayerStatsSoulBlock = panel.FindChildTraverse("PlayerStatsSoulBlock")
    if (PlayerStatsSoulBlock)
    {
        PlayerStatsSoulBlock.SetHasClass("Visible", souls > 0)
    }
    PlayerStatsPanel_SetText(panel, "PlayerStatsSouls", PlayerStatsPanel_FormatChange(souls))

    PlayerStatsPanel_SetText(panel, "PlayerStatsGameTime", ConvertTimeMinutes(Math.max(0, Number(data.game_time) || 0)))
    PlayerStatsPanel_FixIcons(panel)
    PlayerStatsPanel_FillHeroProgress(panel, data)

    if (!panel.BHasClass("SummaryOnly"))
    {
        PlayerStatsPanel_FillRow(panel, data)
    }
}

function PlayerStatsPanel_GetLevelStartXp(level)
{
    return 10 * level * (level + 1) / 2
}

function PlayerStatsPanel_GetLevelNeedXp(level)
{
    return 10 * (level + 1)
}

function PlayerStatsPanel_GetHeroLevel(xp)
{
    var level = 0
    while (level < 30 && xp >= PlayerStatsPanel_GetLevelStartXp(level + 1))
    {
        level++
    }
    return level
}

function PlayerStatsPanel_GetHeroRankIcon(level)
{
    if (level >= 30) { return 6 }
    if (level >= 25) { return 5 }
    if (level >= 18) { return 4 }
    if (level >= 12) { return 3 }
    if (level >= 6) { return 2 }
    if (level >= 1) { return 1 }
    return 0
}

function PlayerStatsPanel_FillHeroProgress(panel, data)
{
    var xp_before = Math.max(0, Number(data.hero_xp_before) || 0)
    var xp_gain = Number(data.coins_change)
    if (data.coins_change === undefined || data.coins_change === null || isNaN(xp_gain))
    {
        xp_gain = Number(data.hero_xp_gain) || 0
    }
    xp_gain = Math.max(0, Math.floor(xp_gain))
    var xp_after = xp_before + xp_gain
    var level_before = PlayerStatsPanel_GetHeroLevel(xp_before)
    var level_after = PlayerStatsPanel_GetHeroLevel(xp_after)

    PlayerStatsPanel_SetText(panel, "PlayerStatsHeroLevelBefore", level_before)
    PlayerStatsPanel_SetText(panel, "PlayerStatsHeroLevelAfter", level_after)
    var PlayerStatsHeroLevelAfter = panel.FindChildTraverse("PlayerStatsHeroLevelAfter")
    if (PlayerStatsHeroLevelAfter)
    {
        PlayerStatsHeroLevelAfter.SetHasClass("PlayerStatsHeroLevelUp", level_after > level_before)
    }

    var PlayerStatsHeroXpChange = panel.FindChildTraverse("PlayerStatsHeroXpChange")
    if (PlayerStatsHeroXpChange)
    {
        PlayerStatsHeroXpChange.text = "+" + xp_gain + " XP"
        PlayerStatsHeroXpChange.visible = xp_gain > 0
    }

    var PlayerStatsHeroRankIcon = panel.FindChildTraverse("PlayerStatsHeroRankIcon")
    if (PlayerStatsHeroRankIcon)
    {
        PlayerStatsHeroRankIcon.style.backgroundImage = 'url("file://{images}/custom_game/hero_rank/rank_' + PlayerStatsPanel_GetHeroRankIcon(level_after) + '.png")'
        PlayerStatsHeroRankIcon.style.backgroundSize = "100%"
    }

    var fill_pct = 100
    var xp_text = $.Localize("#shop_hero_tab_max_level")
    if (level_after < 30)
    {
        var xp_in_level = xp_after - PlayerStatsPanel_GetLevelStartXp(level_after)
        var xp_need = PlayerStatsPanel_GetLevelNeedXp(level_after)
        fill_pct = Math.max(0, Math.min(100, xp_in_level / xp_need * 100))
        xp_text = xp_in_level + " / " + xp_need
    }
    var PlayerStatsHeroXpFill = panel.FindChildTraverse("PlayerStatsHeroXpFill")
    if (PlayerStatsHeroXpFill)
    {
        PlayerStatsHeroXpFill.style.width = fill_pct + "%"
    }
    PlayerStatsPanel_SetText(panel, "PlayerStatsHeroXpText", xp_text)
}

function PlayerStatsPanel_FillRow(panel, data)
{
    var container = panel.FindChildTraverse("PlayerStatsRow")
    if (!container) { return }
    container.RemoveAndDeleteChildren()
    var row = $.CreatePanel("Panel", container, "")
    row.BLoadLayout("file://{resources}/layout/custom_game/multiteam_end_screen/multiteam_end_screen_player.xml", false, false)
    row.AddClass("is_local_player")

    var player_id = Players.GetLocalPlayer()
    var player_info = Game.GetPlayerInfo(player_id)
    var hero_name = data.hero_name || ""
    if (hero_name == "" && player_info)
    {
        hero_name = player_info.player_selected_hero
    }

    var avatar = row.FindChildTraverse("SteamAvatarImage")
    if (avatar && player_info)
    {
        avatar.steamid = player_info.player_steamid
    }

    var portrait = row.FindChildTraverse("HeroIcon")
    if (portrait)
    {
        if (hero_name != "")
        {
            portrait.SetImage("file://{images}/heroes/" + GetPortraitHero(hero_name) + ".png")
        }
        else
        {
            portrait.SetImage("file://{images}/custom_game/unassigned.png")
        }
    }

    PlayerStatsPanel_SetText(row, "PlayerName", player_info ? player_info.player_name : "")
    PlayerStatsPanel_SetText(row, "PlayerRating", Number(data.rating_now) || 0)
    PlayerStatsPanel_SetText(row, "StengthTalentLabel", Number(data.talents_str) || 0)
    PlayerStatsPanel_SetText(row, "AgilityTalentLabel", Number(data.talents_agi) || 0)
    PlayerStatsPanel_SetText(row, "IntellectTalentLabel", Number(data.talents_int) || 0)
    PlayerStatsPanel_SetText(row, "hero_level", Number(data.hero_level) || 0)
    PlayerStatsPanel_SetText(row, "NetworthsPlayer", Math.min(99999, Number(data.networth) || 0))
    PlayerStatsPanel_SetText(row, "Kills", Number(data.kills) || 0)
    PlayerStatsPanel_SetText(row, "Deaths", Number(data.deaths) || 0)
    PlayerStatsPanel_SetText(row, "Assists", Number(data.assists) || 0)

    var items_container = row.FindChildTraverse("playerItemsContainer")
    if (items_container)
    {
        var items = data.items || {}
        var slots = [0, 1, 2, 3, 4, 5, 16, 17]
        for (var i = 0; i < slots.length; i++)
        {
            var item_panel = $.CreatePanel("DOTAItemImage", items_container, "_dynamic_item_" + slots[i])
            item_panel.AddClass("PlayerItem")
            item_panel.itemname = items[slots[i]] || ""
        }
    }

    var WodaPlusContainer = row.FindChildTraverse("WodaPlusContainer")
    if (WodaPlusContainer && Number(data.has_plus) == 1)
    {
        WodaPlusContainer.visible = true
        PlayerStatsPanel_SetTooltip(WodaPlusContainer, "#woda_plus_endgame_info")
    }

    var WodaPremiumContainer = row.FindChildTraverse("WodaPremiumContainer")
    if (WodaPremiumContainer && Number(data.has_premium) == 1)
    {
        WodaPremiumContainer.visible = true
        PlayerStatsPanel_SetTooltip(WodaPremiumContainer, "#woda_premium_endgame_info")
    }

    var BattlePassContainer = row.FindChildTraverse("BattlePassContainer")
    var player_data = Game.GetCustomTable ? Game.GetCustomTable("woda_player_data", String(player_id)) : null
    if (BattlePassContainer && player_data && player_data.has_battlepass_2026 > 0)
    {
        BattlePassContainer.visible = true
        PlayerStatsPanel_SetTooltip(BattlePassContainer, "#battle_pass_2")
    }

    var DoubleTokenContainer = row.FindChildTraverse("DoubleTokenContainer")
    if (DoubleTokenContainer && PlayerStatsPanel_IsDouble(data))
    {
        DoubleTokenContainer.visible = true
        PlayerStatsPanel_SetTooltip(DoubleTokenContainer, "#double_token_endgame_info")
    }

    var BossSoulContainer = row.FindChildTraverse("BossSoulContainer")
    var souls = Number(data.boss_souls_change) || 0
    if (BossSoulContainer && souls > 0)
    {
        BossSoulContainer.visible = true
        var souls_count = BossSoulContainer.FindChildTraverse("BossSoulContainerCount")
        if (souls_count)
        {
            souls_count.text = String(souls)
            souls_count.SetHasClass("Visible", souls > 1)
        }
        BossSoulContainer.SetDialogVariableInt("souls", souls)
        var souls_text = $.Localize("#boss_souls_endgame_info", BossSoulContainer)
        BossSoulContainer.SetPanelEvent("onmouseover", function()
        {
            $.DispatchEvent("DOTAShowTextTooltip", BossSoulContainer, souls_text)
        })
        BossSoulContainer.SetPanelEvent("onmouseout", function()
        {
            $.DispatchEvent("DOTAHideTextTooltip", BossSoulContainer)
        })
    }

    var damage = data.damage || {}
    PlayerStatsPanel_FillDamage(row, "Incoming", damage[1] || {})
    PlayerStatsPanel_FillDamage(row, "Outgoing", damage[2] || {})
}

function PlayerStatsPanel_FillDamage(row, type, table)
{
    var physical = Number(table[1]) || 0
    var magical = Number(table[2]) || 0
    var pure = Number(table[4]) || 0
    var all = physical + magical + pure
    if (all <= 0)
    {
        all = 1
    }
    var panels =
    [
        [row.FindChildTraverse("PhysicalDamage" + type), physical],
        [row.FindChildTraverse("MagicalDamage" + type), magical],
        [row.FindChildTraverse("PureDamage" + type), pure],
    ]
    for (var i = 0; i < panels.length; i++)
    {
        var panel = panels[i][0]
        var value = panels[i][1]
        if (!panel) { continue }
        panel.style.width = Math.max(0, value / all * 100) + "%"
        var label = panel.GetChild(0)
        if (label)
        {
            label.text = String(Math.floor(value))
        }
    }
}