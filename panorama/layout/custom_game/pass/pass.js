--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var PASS_SIDEBAR = $("#PassSidebar")
var PASS_TRACK_VIEWPORT = $("#PassTrackViewport")
var PASS_CURRENT_LEVEL = $("#PassCurrentLevel")
var PASS_CURRENT_LEVEL_LABEL = $("#PassCurrentLevelLabel")
var PASS_EXP_VALUE = $("#PassExpValue")
var PASS_PROGRESS_FILL = $("#PassProgressFill")
var PASS_CLAIM_ALL_WRAP = $("#PassClaimAllWrap")
var PASS_BUY_BUTTON = $("#PassBuyButton")
var PASS_CURRENCY_ROW = $("#PassCurrencyRow")

var current_pass_id = "light_of_heavens"

var pass_state =
{
    current_level: 0,
    current_exp: 0,
    current_level_exp: 0,
    next_level_exp: 100,
    premium_unlocked: false,
}

var pass_list = []
var pass_currency_data = []
var pass_track_signature = ""
var pass_sidebar_signature = ""
var pass_render_deferred = false
var pass_player_data_override = null

function GetCurrentPassPlayerData()
{
    let player_data = GetServicePlayerData()
    return ((player_data.battlepass_data || {})[current_pass_id]) || {}
}

function GetClaimedMap(pass_player, lane)
{
    if (lane === "premium")
    {
        return (pass_player && pass_player.claimed_premium) || {}
    }
    return (pass_player && pass_player.claimed_free) || {}
}

function IsRewardClaimed(level, lane, pass_player)
{
    return !!GetClaimedMap(pass_player, lane)[String(level)]
}

function CanClaimReward(level, lane, pass_player)
{
    if ((Number(level) || 0) > pass_state.current_level)
    {
        return false
    }
    if (lane === "premium" && !pass_state.premium_unlocked)
    {
        return false
    }
    return !IsRewardClaimed(level, lane, pass_player)
}

function CanClaimAnyReward()
{
    let selected_pass = GetCurrentPass()
    let pass_player = GetCurrentPassPlayerData()
    if (!selected_pass)
    {
        return false
    }
    for (let level_data of selected_pass.levels)
    {
        if (CanClaimReward(level_data.level, "free", pass_player) || CanClaimReward(level_data.level, "premium", pass_player))
        {
            return true
        }
    }
    return false
}

function BuildPassTrackSignature(pass)
{
    if (!pass)
    {
        return ""
    }
    let parts = [pass.id, pass.levels.length]
    for (let level_data of pass.levels)
    {
        let free_signature = level_data.free_rewards.map(function(reward) { return reward.icon + "x" + reward.count + ":" + reward.rarity }).join(",")
        let premium_signature = level_data.premium_rewards.map(function(reward) { return reward.icon + "x" + reward.count + ":" + reward.rarity }).join(",")
        parts.push(level_data.level + ":" + free_signature + ":" + premium_signature)
    }
    return parts.join("|")
}

function BuildPassSidebarSignature()
{
    return pass_list.map(function(pass) { return pass.id + ":" + pass.title }).join("|")
}

function GetLocalPlayerKey()
{
    return String(Players.GetLocalPlayer())
}

function GetServiceItems()
{
    return Game.GetCustomTable ? Game.GetCustomTable("services_config", "items") : {}
}

function GetServicePassConfig()
{
    return Game.GetCustomTable ? Game.GetCustomTable("services_config", "battlepass") : {}
}

function GetServicePlayerData()
{
    if (pass_player_data_override)
    {
        return pass_player_data_override
    }
    return Game.GetCustomTable ? Game.GetCustomTable("services_player", GetLocalPlayerKey()) : {}
}

function MergePassPlayerData(base_data, patch_data)
{
    let result = {}
    base_data = base_data || {}
    patch_data = patch_data || {}
    for (let key in base_data) result[key] = base_data[key]
    for (let key in patch_data) result[key] = patch_data[key]
    if (base_data.economy_data || patch_data.economy_data)
    {
        result.economy_data = {}
        let base_economy = base_data.economy_data || {}
        let patch_economy = patch_data.economy_data || {}
        for (let key in base_economy) result.economy_data[key] = base_economy[key]
        for (let key in patch_economy) result.economy_data[key] = patch_economy[key]
    }
    return result
}

function OnPassInventoryUpdate(data)
{
    let base_data = pass_player_data_override || (Game.GetCustomTable ? Game.GetCustomTable("services_player", GetLocalPlayerKey()) : {})
    pass_player_data_override = MergePassPlayerData(base_data, data || {})
    RenderPassFromServices()
}

function UpdatePassClaimNotifications()
{
    if (Game.UpdateServiceTopClaimNotifications)
    {
        Game.UpdateServiceTopClaimNotifications()
    }
}

function NormalizePassReward(reward)
{
    let item = GetServiceItems()[reward.id] || {}
    return Reward(reward.id, item.icon || "file://{images}/game_hud/icons/gold.png", reward.count || 1, item.rarity || reward.rarity || "common")
}

function BuildServiceCurrencyData(player_data)
{
    let items = GetServiceItems()
    let currencies = (player_data && player_data.economy_data) || {}
    return ["coin", "stone", "moon", "sand_time", "magic_crystal"].map(function(currency_id)
    {
        let item = items[currency_id] || {}
        return {
            id: currency_id,
            icon: item.icon || "file://{images}/game_hud/icons/gold.png",
            amount: String(currencies[currency_id] || 0),
        }
    })
}

function GetPassLevelByExperience(exp_by_level, experience)
{
    let level = 0
    let next_exp = 0
    let current_level_exp = 0
    for (let key in (exp_by_level || {}))
    {
        let level_id = Number(key) || 0
        let required = Number(exp_by_level[key]) || 0
        if (experience >= required && level_id > level)
        {
            level = level_id
            current_level_exp = required
        }
        if (required > experience && (!next_exp || required < next_exp))
        {
            next_exp = required
        }
    }
    return { level: level, current_level_exp: current_level_exp, next_exp: next_exp || Math.max(1, experience) }
}

function RefreshPassDataFromServices()
{
    let pass_config = GetServicePassConfig()
    if (!pass_config || !Object.keys(pass_config).length)
    {
        return false
    }

    let player_data = GetServicePlayerData()
    pass_currency_data = BuildServiceCurrencyData(player_data)
    pass_list = []
    for (let pass_id in pass_config)
    {
        let config = pass_config[pass_id]
        let pass_player = (player_data.battlepass_data || {})[pass_id] || {}
        let progress = GetPassLevelByExperience(config.exp_by_level, Number(pass_player.experience) || 0)
        if (pass_id === current_pass_id)
        {
            pass_state.current_level = progress.level
            pass_state.current_exp = Number(pass_player.experience) || 0
            pass_state.current_level_exp = progress.current_level_exp
            pass_state.next_level_exp = progress.next_exp
            pass_state.premium_unlocked = !!pass_player.premium_unlocked
        }

        let levels = []
        for (let level_id in (config.rewards || {}))
        {
            let reward_data = config.rewards[level_id]
            levels.push(LevelReward(
                Number(level_id),
                Object.values(reward_data.free || {}).map(NormalizePassReward),
                Object.values(reward_data.premium || {}).map(NormalizePassReward),
                !!(pass_player.claimed_free || {})[String(level_id)],
                !!(pass_player.claimed_premium || {})[String(level_id)]
            ))
        }
        levels.sort(function(a, b) { return a.level - b.level })
        pass_list.push({
            id: config.id || pass_id,
            title: config.title || pass_id,
            level_cap: levels.length,
            icon: "file://{images}/game_hud/pass/icon.png",
            buy_text: $.Localize("#services_pass_buy_pass"),
            levels: levels,
        })
    }

    if (!pass_config[current_pass_id])
    {
        current_pass_id = pass_list[0] && pass_list[0].id || current_pass_id
    }
    return true
}

function RenderPassFromServices(table_name, key, data)
{
    if (table_name === "services_player" && String(key) === GetLocalPlayerKey() && data)
    {
        pass_player_data_override = data
    }
    if (typeof IsContextWindowVisible === "function" && !IsContextWindowVisible("PassWindow"))
    {
        pass_render_deferred = true
        if (RefreshPassDataFromServices())
        {
            RenderPassCurrencies()
            UpdatePassClaimNotifications()
        }
        return
    }

    if (!RefreshPassDataFromServices())
    {
        return
    }

    let sidebar_signature = BuildPassSidebarSignature()
    if (sidebar_signature !== pass_sidebar_signature)
    {
        RenderPassSidebar()
    }

    let selected_pass = GetCurrentPass()
    let track_signature = BuildPassTrackSignature(selected_pass)
    if (track_signature !== pass_track_signature)
    {
        RenderPassTrack()
    }
    else
    {
        UpdatePassTrackState()
        RenderClaimAllButton()
    }

    RenderPassBottom()
    RenderPassCurrencies()
    UpdatePassClaimNotifications()
}

function RenderPassIfDeferred()
{
    if (!pass_render_deferred)
    {
        return
    }
    pass_render_deferred = false
    RenderPassFromServices()
}

if (typeof Game !== 'undefined') Game.RenderPassIfDeferred = RenderPassIfDeferred

function Reward(item_id, icon, count, rarity)
{
    return { item_id: item_id, icon: icon, count: count, rarity: rarity || "common" }
}

function LevelReward(level, free_rewards, premium_rewards, free_claimed, premium_claimed)
{
    return {
        level: level,
        free_rewards: free_rewards || [],
        premium_rewards: premium_rewards || [],
        free_claimed: !!free_claimed,
        premium_claimed: !!premium_claimed,
    }
}

function InitPass()
{
    RefreshPassDataFromServices()
    RenderPassSidebar()
    RenderPassTrack()
    RenderPassBottom()
    RenderPassCurrencies()
    UpdatePassClaimNotifications()

    if (Game.SubscribeCustomTableListener)
    {
        Game.SubscribeCustomTableListener("services_config", "battlepass", RenderPassFromServices)
        Game.SubscribeCustomTableListener("services_config", "items", RenderPassFromServices)
        Game.SubscribeCustomTableListener("services_player", GetLocalPlayerKey(), RenderPassFromServices)
    }
    GameEvents.Subscribe("event_services_inventory_update", OnPassInventoryUpdate)
}

function RenderPassCurrencies()
{
    if (!PASS_CURRENCY_ROW)
    {
        return
    }

    PASS_CURRENCY_ROW.RemoveAndDeleteChildren()
    if (typeof RenderServiceServerSyncButton === "function")
    {
        RenderServiceServerSyncButton(PASS_CURRENCY_ROW)
    }
    for (let currency of pass_currency_data)
    {
        let panel = $.CreatePanel("Panel", PASS_CURRENCY_ROW, "")
        panel.AddClass("PassCurrencyPanel")

        let icon = $.CreatePanel("Panel", panel, "")
        icon.AddClass("PassCurrencyIcon")
        SetPanelImage(icon, currency.icon)

        let label = $.CreatePanel("Label", panel, "")
        label.AddClass("PassCurrencyAmount")
        label.text = currency.amount

        if (typeof SetServiceItemTooltip === "function")
        {
            SetServiceItemTooltip(panel, currency.id, currency.amount)
        }
    }
    if (typeof RenderServiceCurrencyMoreButton === "function")
    {
        RenderServiceCurrencyMoreButton(PASS_CURRENCY_ROW, (GetServicePlayerData().economy_data || {}))
    }
}

function RenderPassSidebar()
{
    PASS_SIDEBAR.RemoveAndDeleteChildren()
    pass_sidebar_signature = BuildPassSidebarSignature()

    for (let i = 0; i < pass_list.length; i++)
    {
        let pass = pass_list[i]
        let button = $.CreatePanel("Panel", PASS_SIDEBAR, "")
        button.AddClass("PassSidebarButton")
        button.pass_id = pass.id
        button.SetHasClass("PassSidebarButtonActive", pass.id === current_pass_id)
        button.SetPanelEvent("onactivate", (function(pass_id)
        {
            return function()
            {
                if (current_pass_id === pass_id)
                {
                    return
                }
                current_pass_id = pass_id
                RefreshPassDataFromServices()
                UpdatePassSidebarActive()
                let selected_pass = GetCurrentPass()
                let track_signature = BuildPassTrackSignature(selected_pass)
                if (track_signature !== pass_track_signature)
                {
                    RenderPassTrack()
                }
                else
                {
                    UpdatePassTrackState()
                    RenderClaimAllButton()
                }
                RenderPassBottom()
            }
        })(pass.id))

        let icon = $.CreatePanel("Panel", button, "")
        icon.AddClass("PassSidebarIcon")
        SetPanelImage(icon, pass.icon)

        let label = $.CreatePanel("Label", button, "")
        label.AddClass("PassSidebarTitle")
        label.text = $.Localize("#"+pass.title)
    }
}

function UpdatePassSidebarActive()
{
    if (!PASS_SIDEBAR)
    {
        return
    }

    let buttons = PASS_SIDEBAR.Children()
    for (let i = 0; i < buttons.length; i++)
    {
        let button = buttons[i]
        button.SetHasClass("PassSidebarButtonActive", button.pass_id === current_pass_id)
    }
}

function RenderPassTrack()
{
    PASS_TRACK_VIEWPORT.RemoveAndDeleteChildren()

    let selected_pass = GetCurrentPass()
    if (!selected_pass)
    {
        return
    }
    pass_track_signature = BuildPassTrackSignature(selected_pass)

    let root = $.CreatePanel("Panel", PASS_TRACK_VIEWPORT, "")
    root.AddClass("PassTrackRoot")

    let leftLabels = $.CreatePanel("Panel", root, "")
    leftLabels.AddClass("PassLaneLabels")

    CreateLaneLabel(leftLabels, "#services_pass_lane_free", "PassLaneLabelFree")
    CreateLaneLabel(leftLabels, "#services_pass_lane_premium", "PassLaneLabelPremium")

    let rewardsScroller = $.CreatePanel("Panel", root, "")
    rewardsScroller.AddClass("PassRewardsScroller")
    rewardsScroller.style.overflow = "scroll squish"

    for (let i = 0; i < selected_pass.levels.length; i++)
    {
        RenderLevelColumn(rewardsScroller, selected_pass.levels[i], i === selected_pass.levels.length - 1)
    }

    RenderClaimAllButton()
}

function CreateLaneLabel(parent, text, class_name)
{
    let lane = $.CreatePanel("Panel", parent, "")
    lane.AddClass("PassLaneLabel")
    lane.AddClass(class_name)

    
    $.CreatePanel("DOTAParticleScenePanel", lane, "", 
    { 
        class: "ParticleLaneFx",
        particleName: "particles/pass_ui/pass_ui_smoke.vpcf", 
        particleonly:"true", 
        startActive:"true", 
        cameraOrigin:"0 0 120", 
        lookAt:"0 0 0",  
        fov:"64",
        squarePixels:"true",
        hittest: "false"
    });

    let lane_content = $.CreatePanel("Panel", lane, "")
    lane_content.AddClass("PassLaneContent")

    let emblem = $.CreatePanel("Panel", lane_content, "")
    emblem.AddClass("PassLaneEmblem")

    let label = $.CreatePanel("Label", lane_content, "")
    label.AddClass("PassLaneText")
    label.text = String(text || "").charAt(0) === "#" ? $.Localize(text) : text
}

function RenderLevelColumn(parent, level_data, is_last)
{
    let column = $.CreatePanel("Panel", parent, "PassLevelColumn_" + level_data.level)
    column.AddClass("PassLevelColumn")
    column.SetHasClass("PassLevelColumnLast", !!is_last)

    let levelHeader = $.CreatePanel("Panel", column, "")
    levelHeader.AddClass("PassLevelHeader")

    let levelLabel = $.CreatePanel("Label", levelHeader, "")
    levelLabel.AddClass("PassLevelHeaderText")
    levelLabel.SetDialogVariable("value", String(level_data.level))
    levelLabel.text = $.Localize("#services_pass_level_short", levelLabel)

    let freeCell = $.CreatePanel("Panel", column, "PassRewardCell_free_" + level_data.level)
    freeCell.AddClass("PassRewardCell")
    freeCell.AddClass("PassRewardCellFree")
    RenderRewardStack(freeCell, level_data.free_rewards, level_data.level, "free")

    let premiumCell = $.CreatePanel("Panel", column, "PassRewardCell_premium_" + level_data.level)
    premiumCell.AddClass("PassRewardCell")
    premiumCell.AddClass("PassRewardCellPremium")
    RenderRewardStack(premiumCell, level_data.premium_rewards, level_data.level, "premium")

    UpdateLevelColumnState(level_data)
}

function RenderRewardStack(parent, rewards, level, lane)
{
    for (let i = 0; i < rewards.length; i++)
    {
        let reward = rewards[i]
        let item = $.CreatePanel("Panel", parent, "")
        item.AddClass("PassRewardItem")
        SetServiceItemTooltip(item, reward.item_id, reward.count)

        let PassRewardItemBG1 = $.CreatePanel("Panel", item, "")
        PassRewardItemBG1.AddClass("PassRewardItemBG1")

        let PassRewardItemBG2 = $.CreatePanel("Panel", item, "")
        PassRewardItemBG2.AddClass("PassRewardItemBG2")
        if (reward.rarity && reward.rarity !== "common")
        {
            PassRewardItemBG2.AddClass("RareColor_" + reward.rarity)
        }

        let icon = $.CreatePanel("Panel", item, "")
        icon.AddClass("PassRewardIcon")
        SetPanelImage(icon, reward.icon)

        let count = $.CreatePanel("Label", item, "")
        count.AddClass("PassRewardCount")
        count.text = String(reward.count)

        let check = $.CreatePanel("Panel", item, "")
        check.AddClass("PassRewardClaimCheck")
    }
}

function UpdatePassTrackState()
{
    let selected_pass = GetCurrentPass()
    if (!selected_pass)
    {
        return
    }

    for (let level_data of selected_pass.levels)
    {
        UpdateLevelColumnState(level_data)
    }
}

function UpdateLevelColumnState(level_data)
{
    let pass_player = GetCurrentPassPlayerData()
    let free_claimed = IsRewardClaimed(level_data.level, "free", pass_player)
    let premium_claimed = IsRewardClaimed(level_data.level, "premium", pass_player)
    let free_available = CanClaimReward(level_data.level, "free", pass_player)
    let premium_available = CanClaimReward(level_data.level, "premium", pass_player)
    let locked = level_data.level > pass_state.current_level

    let column = $("#PassLevelColumn_" + level_data.level)
    if (column)
    {
        column.SetHasClass("PassLevelColumnCurrent", level_data.level === pass_state.current_level)
        column.SetHasClass("PassLevelColumnPast", level_data.level < pass_state.current_level)
        column.SetHasClass("PassLevelColumnLocked", locked)
        column.SetHasClass("PassLevelColumnReady", free_available || premium_available)
        column.SetHasClass("PassLevelColumnClaimed", free_claimed && (premium_claimed || !pass_state.premium_unlocked))
    }

    UpdateRewardCellState(level_data.level, "free", free_claimed, free_available, locked, false)
    UpdateRewardCellState(level_data.level, "premium", premium_claimed, premium_available, locked || !pass_state.premium_unlocked, !pass_state.premium_unlocked)
}

function UpdateRewardCellState(level, lane, claimed, available, locked, premium_locked)
{
    let cell = $("#PassRewardCell_" + lane + "_" + level)
    if (!cell)
    {
        return
    }
    cell.SetHasClass("PassRewardCellClaimed", claimed)
    cell.SetHasClass("PassRewardCellReady", available)
    cell.SetHasClass("PassRewardCellLocked", locked)
    cell.SetHasClass("PassRewardCellPremiumLocked", premium_locked)
}

function RenderClaimAllButton()
{
    PASS_CLAIM_ALL_WRAP.RemoveAndDeleteChildren()
    let can_claim = CanClaimAnyReward()

    let button = $.CreatePanel("Panel", PASS_CLAIM_ALL_WRAP, "")
    button.AddClass("PassClaimAllButton")
    button.SetHasClass("PassClaimAllButtonDisabled", !can_claim)
    button.SetHasClass("PassClaimAllButtonReady", can_claim)
    button.SetPanelEvent("onactivate", function()
    {
        if (!CanClaimAnyReward())
        {
            return
        }
        Game.EmitSound("General.ButtonClick")
        GameEvents.SendCustomGameEventToServer("event_services_claim_battlepass_all", { pass_id: current_pass_id })
    })

    let label = $.CreatePanel("Label", button, "")
    label.text = $.Localize("#services_pass_claim_all")
}

function RenderPassBottom()
{
    let selected_pass = GetCurrentPass()
    if (!selected_pass)
    {
        return
    }

    PASS_CURRENT_LEVEL.text = String(pass_state.current_level)
    PASS_CURRENT_LEVEL_LABEL.text = $.Localize("#services_common_level")
    let level_exp = Math.max(0, pass_state.current_exp - pass_state.current_level_exp)
    let level_need = Math.max(1, pass_state.next_level_exp - pass_state.current_level_exp)
    PASS_EXP_VALUE.text = level_exp + "/" + level_need
    PASS_PROGRESS_FILL.style.width = Math.min(100, (level_exp / level_need) * 100) + "%"

    PASS_BUY_BUTTON.RemoveAndDeleteChildren()
    PASS_BUY_BUTTON.SetPanelEvent("onactivate", function()
    {
        if (pass_state.premium_unlocked) return
        if (Game.OpenStorePurchaseModalById)
        {
            Game.EmitSound("General.ButtonClick")
            Game.OpenStorePurchaseModalById("store_battlepass_premium")
        }
    })

    let buyLabel = $.CreatePanel("Label", PASS_BUY_BUTTON, "")
    buyLabel.text = selected_pass.buy_text
    PASS_BUY_BUTTON.SetHasClass("PassBuyButtonOwned", pass_state.premium_unlocked)
    PASS_BUY_BUTTON.style.opacity = pass_state.premium_unlocked ? "0" : "1"
    PASS_BUY_BUTTON.hittest = !pass_state.premium_unlocked
}

function GetCurrentPass()
{
    for (let i = 0; i < pass_list.length; i++)
    {
        if (pass_list[i].id === current_pass_id)
        {
            return pass_list[i]
        }
    }

    return pass_list.length > 0 ? pass_list[0] : null
}

function SetPanelImage(panel, path)
{
    panel.style.backgroundImage = "url('" + path + "')"
    panel.style.backgroundSize = "contain"
    panel.style.backgroundRepeat = "no-repeat"
    panel.style.backgroundPosition = "center"
}

InitPass()