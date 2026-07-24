--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var CHEST_TIERS = ["B", "A", "S", "SS"]

var chest_categories = []
var chests_currency_data = []

const ChestsSidebar = $("#ChestsSidebar")
const ChestsContent = $("#ChestsContent")
const ChestsCurrencyRow = $("#ChestsCurrencyRow")
const ChestMainTitle = $("#ChestMainTitle")
const ChestMainSubtitle = $("#ChestMainSubtitle")
const ChestProbabilityButton = $("#ChestProbabilityButton")
const ChestVisualCard = $("#ChestVisualCard")

const ChestProgressArea = $("#ChestProgressArea")
const ChestProgressCountValue = $("#ChestProgressCountValue")
const ChestMilestoneBar = $("#ChestMilestoneBar")
const ChestMilestoneMarkers = $("#ChestMilestoneMarkers")
const ChestOpenOneButton = $("#ChestOpenOneButton")
const ChestOpenTenButton = $("#ChestOpenTenButton")
const ChestBackButton = $("#ChestBackButton")
const ChestGuaranteeText = $("#ChestGuaranteeText")
const ChestRewardsArea = $("#ChestRewardsArea")

var current_chest_id = chest_categories[0] && chest_categories[0].id || ""
var current_chest_results = []
var chest_view_mode = "idle"
var chest_pity_state = {}
var chest_animation_serial = 0
var chest_services_ready = false
var chest_open_pending = false
var chest_open_lock_serial = 0
var chests_sidebar_signature = ""
var chests_currency_signature = ""
var chests_selected_signature = ""
var chests_milestones_signature = ""
var chest_music_handle = -1
var chest_music_name = ""

const CHEST_MUSIC_BY_ID =
{
    sky: "upup_music_chest_sky",
    chest_sky: "upup_music_chest_sky",
    night: "upup_music_chest_night",
    chest_night: "upup_music_chest_night",
    nature: "upup_music_chest_nature",
    chest_nature: "upup_music_chest_nature",
    companion: "upup_music_chest_companion",
    chest_companion: "upup_music_chest_companion",
}

function IsChestsWindowVisible()
{
    let panel = $.GetContextPanel()
    return !!(panel && panel.BHasClass("WindowVisible"))
}

function StopChestMusic()
{
    if (chest_music_handle !== -1)
    {
        Game.StopSound(chest_music_handle)
        chest_music_handle = -1
    }
    chest_music_name = ""
}

function PlayChestMusic(chest_id)
{
    if (!IsChestsWindowVisible())
    {
        return
    }

    let sound_name = CHEST_MUSIC_BY_ID[String(chest_id || "")]
    if (!sound_name)
    {
        StopChestMusic()
        return
    }
    if (sound_name === chest_music_name && chest_music_handle !== -1)
    {
        return
    }

    StopChestMusic()
    chest_music_handle = Game.EmitSound(sound_name)
    chest_music_name = sound_name
}

Game.PlayCurrentChestMusic = function()
{
    PlayChestMusic(current_chest_id)
}

Game.StopChestMusic = function()
{
    StopChestMusic()
}

function GetLocalPlayerKey()
{
    return String(Players.GetLocalPlayer())
}

function GetServiceItems()
{
    return Game.GetCustomTable ? Game.GetCustomTable("services_config", "items") : {}
}

function GetServiceChestsConfig()
{
    return Game.GetCustomTable ? Game.GetCustomTable("services_config", "chests") : {}
}

function GetServicePlayerData()
{
    return Game.GetCustomTable ? Game.GetCustomTable("services_player", GetLocalPlayerKey()) : {}
}

function LocalizeServiceText(value)
{
    let text = String(value || "")
    let key = text.charAt(0) === "#" ? text : "#" + text
    if ($.CanLocalize && $.CanLocalize(key))
    {
        return $.Localize(key)
    }
    if (text.charAt(0) === "#")
    {
        let localized = $.Localize(text)
        return localized && localized !== text ? localized : text.substring(1)
    }
    return text
}

function CountStorageItem(item_id)
{
    let player_data = GetServicePlayerData()
    let count = 0
    for (let entry of Object.values(player_data.storage_items || {}))
    {
        if (entry.item_id === item_id)
        {
            count += Number(entry.count) || 0
        }
    }
    return count
}

function GetTierFromRarity(rarity)
{
    if (rarity === "super") return "UR"
    if (rarity === "immortal") return "SSR"
    if (rarity === "legendary") return "S"
    if (rarity === "mythical") return "A"
    if (rarity === "rare") return "B"
    return "C"
}

function NormalizeChestReward(raw_reward)
{
    let item = GetServiceItems()[raw_reward.id] || {}
    return {
        id: raw_reward.id,
        name: LocalizeServiceItemName(item, raw_reward.id),
        tier: GetTierFromRarity(item.rarity || raw_reward.rarity),
        icon: item.icon || "file://{images}/game_hud/icons/gold.png",
        rarity: item.rarity || raw_reward.rarity || "common",
        count: Number(raw_reward.count) || 1,
    }
}

function NormalizeChestMilestone(raw_milestone, index, claimed_map)
{
    let open_count = Number(raw_milestone.open_count || raw_milestone.count || raw_milestone.opens) || 0
    let id = String(raw_milestone.id || open_count || index)
    let rewards = Object.values(raw_milestone.rewards || {}).map(NormalizeChestReward)
    return {
        id: id,
        index: index,
        open_count: open_count,
        rewards: rewards,
        claimed: !!(claimed_map && claimed_map[id]),
    }
}

function RefreshChestDataFromServices()
{
    let chests_config = GetServiceChestsConfig()
    if (!chests_config || !chests_config.list)
    {
        return false
    }

    let player_data = GetServicePlayerData()
    chest_categories = []
    for (let chest_id in chests_config.list)
    {
        let chest = chests_config.list[chest_id]
        let chest_item = GetServiceItems()[chest.chest_item_id] || {}
        let opened_data = (player_data.chest_opened_data || {})[chest.id] || {}
        chest_categories.push({
            id: chest.id,
            order_index: Number(chest.order_index) || 999999,
            title: LocalizeServiceItemName(chest_item, chest.chest_item_id || chest.id),
            subtitle: LocalizeServiceKeyOrText(((chest.chest_item_id || chest.id) + "_description_short"), ""),
            icon_text: "*",
            theme_class: chest.id === "night" ? "ChestThemeNight" : "ChestThemeSky",
            chest_item_id: chest.chest_item_id,
            currency_icon: chest_item.icon || "file://{images}/game_hud/chest/icon1.png",
            currency_amount: CountStorageItem(chest.chest_item_id),
            pity_threshold: Number(chest.guarantee_every) || 0,
            guarantee_rarity: String(chest.guarantee_rarity || ""),
            progress_opened: Number(opened_data.opened) || 0,
            reward_pool: Object.values(chest.rewards || {}).map(NormalizeChestReward),
            milestones: Object.values(chest.milestones || {}).map(function(milestone, index)
            {
                return NormalizeChestMilestone(milestone, index + 1, opened_data.claimed_milestones || {})
            }).sort(function(a, b) { return a.open_count - b.open_count }),
        })
        chest_pity_state[chest.id] = (Number(opened_data.opened) || 0) % Math.max(1, Number(chest.guarantee_every) || 1)
    }

    chest_categories.sort(function(a, b)
    {
        return (a.order_index || 999999) - (b.order_index || 999999)
    })

    chests_currency_data = chest_categories.map(function(chest)
    {
        return { id: chest.id, item_id: chest.chest_item_id, icon: chest.currency_icon, amount: String(chest.currency_amount || 0) }
    })

    if (!chest_categories.find(function(chest) { return chest.id === current_chest_id }))
    {
        current_chest_id = chest_categories[0] && chest_categories[0].id || ""
    }

    chest_services_ready = true
    return true
}

function RenderChestsFromServices()
{
    if (!RefreshChestDataFromServices())
    {
        return
    }

    let sidebar_signature = BuildChestsSidebarSignature()
    if (sidebar_signature !== chests_sidebar_signature)
    {
        RenderChestsSidebar()
    }
    else
    {
        UpdateChestsSidebarActive()
    }

    let currency_signature = BuildChestsCurrencySignature()
    if (currency_signature !== chests_currency_signature)
    {
        RenderChestsCurrencies()
    }

    let chest = GetCurrentChestData()
    let selected_signature = BuildChestStaticSignature(chest)
    if (selected_signature !== chests_selected_signature)
    {
        SelectChestCategory(current_chest_id)
        return
    }

    RenderChestProgress()
    RenderGuaranteeText()
}

function InitChests()
{
    RefreshChestDataFromServices()
    for (let chest of chest_categories)
    {
        chest_pity_state[chest.id] = 0
    }

    RenderChestsSidebar()
    RenderChestsCurrencies()
    BindChestButtons()
    SelectChestCategory(current_chest_id)

    if (Game.SubscribeCustomTableListener)
    {
        Game.SubscribeCustomTableListener("services_config", "chests", RenderChestsFromServices)
        Game.SubscribeCustomTableListener("services_config", "items", RenderChestsFromServices)
        Game.SubscribeCustomTableListener("services_player", GetLocalPlayerKey(), RenderChestsFromServices)
    }

    GameEvents.Subscribe("event_services_chest_results", function(payload)
    {
        if (!payload || payload.chest_id !== current_chest_id)
        {
            UnlockChestOpenButtons()
            return
        }
        ApplyChestResultState(payload)
        let items = GetServiceItems()
        let raw_results = Object.values(payload.results || {})
        if (!raw_results.length)
        {
            if (payload.error_code)
            {
                $.Msg("[Chests] open denied: ", payload.error_code, " chest=", payload.chest_id, " remaining=", payload.remaining_count)
            }
            current_chest_results = []
            chest_view_mode = "idle"
            chest_animation_serial += 1
            RenderChestProgress()
            RenderGuaranteeText()
            UpdateChestPresentationMode()
            RenderChestRewards()
            UnlockChestOpenButtons()
            return
        }

        current_chest_results = raw_results.map(function(result)
        {
            let reward = result.reward || {}
            let original_reward = result.original_reward || {}
            let original_id = result.original_id || original_reward.id || reward.id
            let original = items[original_id] || items[reward.id] || {}
            let granted = items[reward.id] || original
            let is_duplicate = !!result.duplicate
            let display_item = is_duplicate ? original : granted
            let display_id = is_duplicate ? original_id : reward.id
            return {
                id: display_id,
                name: LocalizeServiceItemName(display_item.id ? display_item : original, display_id),
                tier: GetTierFromRarity(display_item.rarity || original_reward.rarity || reward.rarity || original.rarity),
                icon: display_item.icon || original.icon || "file://{images}/game_hud/icons/gold.png",
                count: Number(is_duplicate ? (original_reward.count || 1) : reward.count) || 1,
                duplicate: is_duplicate,
                converted_id: is_duplicate ? reward.id : "",
                converted_name: is_duplicate ? LocalizeServiceItemName(granted, reward.id) : "",
                converted_icon: is_duplicate ? (granted.icon || "file://{images}/game_hud/icons/gold.png") : "",
                converted_count: is_duplicate ? (Number(reward.count) || 1) : 0,
            }
        })
        chest_view_mode = "results"
        chest_animation_serial += 1
        RenderChestProgress()
        RenderGuaranteeText()
        UpdateChestPresentationMode()
        RenderChestRewards()
        UnlockChestOpenButtons()
    })
}

function ApplyChestResultState(payload)
{
    let chest = GetCurrentChestData()
    if (!chest || !payload)
    {
        return
    }

    if (payload.remaining_count !== undefined)
    {
        chest.currency_amount = Number(payload.remaining_count) || 0
        for (let i = 0; i < chests_currency_data.length; i++)
        {
            if (chests_currency_data[i].id === chest.id)
            {
                chests_currency_data[i].amount = String(chest.currency_amount)
                break
            }
        }
        RenderChestsCurrencies()
    }

    if (payload.opened !== undefined)
    {
        chest.progress_opened = Number(payload.opened) || chest.progress_opened || 0
        chest_pity_state[chest.id] = chest.progress_opened % Math.max(1, chest.pity_threshold || 1)
    }
}

function BindChestButtons()
{
    ChestBackButton.style.visibility = "collapse"
    UpdateChestProbabilityTooltip()

    ChestOpenOneButton.SetPanelEvent("onactivate", function()
    {
        OpenChest(1)
    })

    ChestOpenTenButton.SetPanelEvent("onactivate", function()
    {
        OpenChest(10)
    })

    ChestBackButton.SetPanelEvent("onactivate", function()
    {
        chest_animation_serial += 1
        chest_view_mode = "idle"
        current_chest_results = []
        UpdateChestPresentationMode()
        RenderChestRewards()
    })
}

function RenderChestsSidebar()
{
    ChestsSidebar.RemoveAndDeleteChildren()
    chests_sidebar_signature = BuildChestsSidebarSignature()

    for (let chest of chest_categories)
    {
        let button = $.CreatePanel("Panel", ChestsSidebar, "chest_nav_" + chest.id)
        button.AddClass("ChestNavButton")
        button.SetHasClass("ChestNavButtonActive", chest.id === current_chest_id)
        button.SetPanelEvent("onactivate", function()
        {
            SelectChestCategory(chest.id)
        })

        let icon = $.CreatePanel("Panel", button, "")
        icon.AddClass("ChestNavIcon")
        icon.text = chest.icon_text

        let label = $.CreatePanel("Label", button, "")
        label.AddClass("ChestNavLabel")
        label.text = chest.title
    }
}

function UpdateChestsSidebarActive()
{
    for (let chest of chest_categories)
    {
        let button = $("#chest_nav_" + chest.id)
        if (button)
        {
            button.SetHasClass("ChestNavButtonActive", chest.id === current_chest_id)
        }
    }
}

function RenderChestsCurrencies()
{
    ChestsCurrencyRow.RemoveAndDeleteChildren()
    if (typeof RenderServiceServerSyncButton === "function")
    {
        RenderServiceServerSyncButton(ChestsCurrencyRow)
    }
    chests_currency_signature = BuildChestsCurrencySignature()

    for (let currency of chests_currency_data)
    {
        let panel = $.CreatePanel("Panel", ChestsCurrencyRow, "")
        panel.AddClass("ChestCurrencyPanel")

        let icon = $.CreatePanel("Panel", panel, "")
        icon.AddClass("ChestCurrencyIcon")
        ApplyBackgroundImage(icon, currency.icon)

        let amount = $.CreatePanel("Label", panel, "")
        amount.AddClass("ChestCurrencyAmount")
        amount.text = currency.amount

        if (typeof SetServiceItemTooltip === "function")
        {
            SetServiceItemTooltip(panel, currency.item_id, currency.amount)
        }
    }
    if (typeof RenderServiceCurrencyMoreButton === "function")
    {
        RenderServiceCurrencyMoreButton(ChestsCurrencyRow, (GetServicePlayerData().economy_data || {}))
    }
}

var pokebalss_video =
{
    "sky": "videos/pokeball_sky.webm",
    "night": "videos/pokeball.webm",
    "nature": "videos/pokeball_nature.webm",
    "companion": "videos/pokeball_companion.webm",
}

function SelectChestCategory(chest_id)
{
    chest_animation_serial += 1
    current_chest_id = chest_id
    chest_view_mode = "idle"
    current_chest_results = []
    PlayChestMusic(chest_id)

    let chest = GetCurrentChestData()
    if (!chest)
    {
        return
    }
    chests_selected_signature = BuildChestStaticSignature(chest)

    ChestMainTitle.text = chest.title
    ChestMainSubtitle.text = chest.subtitle
    UpdateChestProbabilityTooltip()

    let ChestVideoFx = $("#ChestVideoFx")
    ChestVideoFx.RemoveAndDeleteChildren()

    let video = $.CreatePanel("MoviePanel", ChestVideoFx, "stage_video", { 
        src: "file://{resources}/" + (pokebalss_video[chest_id] || "videos/pokeball.webm"),
        repeat:"true", 
        autoplay:"onload",
        style:"align:center center;width: 100%;height: 100%;z-index:5;" 
    });

    UpdateChestsSidebarActive()
    RenderChestProgress()
    RenderGuaranteeText()
    UpdateChestPresentationMode()
    RenderChestRewards()
}

function GetCurrentChestData()
{
    return chest_categories.find(function(chest)
    {
        return chest.id === current_chest_id
    }) || null
}

function BuildChestsSidebarSignature()
{
    return chest_categories.map(function(chest)
    {
        return [chest.id, chest.title, chest.icon_text].join(":")
    }).join("|")
}

function BuildChestsCurrencySignature()
{
    return chests_currency_data.map(function(currency)
    {
        return [currency.id, currency.icon, currency.amount].join(":")
    }).join("|")
}

function BuildChestStaticSignature(chest)
{
    if (!chest)
    {
        return ""
    }

    let reward_signature = chest.reward_pool.map(function(reward)
    {
        return [reward.id, reward.name, reward.tier, reward.icon, reward.rarity].join(":")
    }).join(",")
    let milestone_signature = (chest.milestones || []).map(function(milestone)
    {
        let rewards = (milestone.rewards || []).map(function(reward)
        {
            return [reward.id, reward.count, reward.icon, reward.rarity].join(":")
        }).join(",")
        return [milestone.id, milestone.open_count, rewards].join(":")
    }).join("|")

    return [
        chest.id,
        chest.title,
        chest.subtitle,
        chest.theme_class,
        chest.currency_icon,
        chest.pity_threshold,
        reward_signature,
        milestone_signature,
    ].join("|")
}

function ClaimChestMilestone(milestone)
{
    let chest = GetCurrentChestData()
    if (!chest || !milestone || milestone.claimed || (Number(chest.progress_opened) || 0) < (Number(milestone.open_count) || 0)) return
    GameEvents.SendCustomGameEventToServer("event_services_claim_chest_milestone", {
        chest_id: chest.id,
        milestone_id: milestone.id,
        open_count: milestone.open_count,
    })
}

function SetChestMilestoneRewardsTooltip(panel, chest, milestone)
{
    if (!panel || !chest || !milestone || typeof SetCustomTooltip !== "function") return
    SetCustomTooltip(panel, "chest_milestone_tooltip", { chest_id: chest.id, milestone_id: milestone.id })
}

function GetChestMilestoneMarkerPosition(open_count, max_milestone)
{
    open_count = Math.max(0, Number(open_count) || 0)
    max_milestone = Math.max(1, Number(max_milestone) || 1)

    let min_position = 8
    let early_end_count = Math.min(100, max_milestone)
    let early_end_position = max_milestone > 100 ? 32 : 98
    let max_position = 98

    if (open_count <= early_end_count)
    {
        return min_position + (open_count / early_end_count) * (early_end_position - min_position)
    }

    let late_raw = (open_count - early_end_count) / Math.max(1, max_milestone - early_end_count)
    return Math.min(max_position, early_end_position + late_raw * (max_position - early_end_position))
}

function IsEvenSpacedMilestoneChest(chest)
{
    return !!chest && chest.id === "sky"
}

function GetMilestonePositions(chest, milestones, max_milestone)
{
    milestones = milestones || []
    let count = milestones.length
    if (IsEvenSpacedMilestoneChest(chest))
    {
        let min_position = 8
        let max_position = 98
        let positions = []
        for (let i = 0; i < count; i++)
        {
            positions.push(count <= 1 ? max_position : (min_position + (i / (count - 1)) * (max_position - min_position)))
        }
        return positions
    }
    return milestones.map(function(milestone)
    {
        return GetChestMilestoneMarkerPosition(Math.max(0, Number(milestone.open_count) || 0), max_milestone)
    })
}

function GetChestMilestoneProgressWidth(progress_value, milestones, max_milestone, positions)
{
    progress_value = Math.max(0, Number(progress_value) || 0)
    milestones = milestones || []
    max_milestone = Math.max(1, Number(max_milestone) || 1)
    if (progress_value <= 0) return 0
    if (progress_value >= max_milestone) return 100

    let previous_count = 0
    let previous_position = 0
    for (let i = 0; i < milestones.length; i++)
    {
        let current_count = Math.max(0, Number(milestones[i].open_count) || 0)
        let current_position = positions ? positions[i] : GetChestMilestoneMarkerPosition(current_count, max_milestone)
        if (progress_value <= current_count)
        {
            let segment_raw = (progress_value - previous_count) / Math.max(1, current_count - previous_count)
            return previous_position + segment_raw * (current_position - previous_position)
        }
        previous_count = current_count
        previous_position = current_position
    }

    let tail_raw = (progress_value - previous_count) / Math.max(1, max_milestone - previous_count)
    return previous_position + tail_raw * (100 - previous_position)
}

function RenderChestMilestoneMarkers(chest)
{
    let milestones = (chest && chest.milestones) || []
    let signature = chest ? [chest.id].concat(milestones.map(function(milestone)
    {
        return [milestone.id, milestone.open_count].join(":")
    })).join("|") : ""
    if (signature === chests_milestones_signature)
    {
        return
    }

    ChestMilestoneMarkers.RemoveAndDeleteChildren()
    chests_milestones_signature = signature
    if (!milestones.length) return

    let previous_milestone = 0
    let max_milestone = Math.max(1, Number(milestones[milestones.length - 1].open_count) || 1)
    let positions = GetMilestonePositions(chest, milestones, max_milestone)

    for (let i = 0; i < milestones.length; i++)
    {
        let milestone = milestones[i]
        let marker = $.CreatePanel("Panel", ChestMilestoneMarkers, "ChestMilestoneMarker_" + chest.id + "_" + milestone.id)
        marker.AddClass("ChestMilestoneMarker")
        marker.hittest = false
        let position = positions[i]
        marker.style.position = position + "% 0px 0px"
        
        let ChestMilestoneMarkerContent = $.CreatePanel("Panel", marker, "")
        ChestMilestoneMarkerContent.AddClass("ChestMilestoneMarkerContent")

        let icon = $.CreatePanel("Panel", ChestMilestoneMarkerContent, "")
        icon.AddClass("ChestMilestoneIcon")
        icon.hittest = true
        icon.SetPanelEvent("onactivate", (function(saved_milestone)
        {
            return function()
            {
                ClaimChestMilestone(saved_milestone)
            }
        })(milestone))
        SetChestMilestoneRewardsTooltip(icon, chest, milestone)

        let check = $.CreatePanel("Panel", ChestMilestoneMarkerContent, "")
        check.AddClass("ChestMilestoneClaimCheck")
        check.hittest = false

        let label = $.CreatePanel("Label", ChestMilestoneMarkerContent, "")
        label.AddClass("ChestMilestoneLabel")
        label.text = String(milestone.open_count)

        previous_milestone = milestone.open_count
    }
}

function RenderChestProgress()
{
    let chest = GetCurrentChestData()
    if (!chest)
    {
        return
    }
    ChestOpenOneButton.SetHasClass("ChestOpenButtonDisabled", chest_open_pending || (Number(chest.currency_amount) || 0) < 1)
    ChestOpenTenButton.SetHasClass("ChestOpenButtonDisabled", chest_open_pending || (Number(chest.currency_amount) || 0) < 10)

    let progress_value = Math.max(0, chest.progress_opened || 0)
    let milestones = chest.milestones || []
    let max_milestone = milestones.length ? Math.max(1, Number(milestones[milestones.length - 1].open_count) || 1) : 1
    let positions = GetMilestonePositions(chest, milestones, max_milestone)
    ChestProgressCountValue.text = String(progress_value)
    let progress_width = GetChestMilestoneProgressWidth(progress_value, milestones, max_milestone, positions)
    ChestMilestoneBar.style.width = progress_width + "%"

    RenderChestMilestoneMarkers(chest)
    for (let milestone of milestones)
    {
        let marker = $("#ChestMilestoneMarker_" + chest.id + "_" + milestone.id)
        if (marker)
        {
            let reached = progress_value >= (Number(milestone.open_count) || 0)
            marker.SetHasClass("ChestMilestoneReached", reached)
            marker.SetHasClass("ChestMilestoneActive", reached && !milestone.claimed)
            marker.SetHasClass("ChestMilestoneClaimed", !!milestone.claimed)
            marker.SetHasClass("ChestMilestoneLocked", !reached)
        }
    }
}

function RenderGuaranteeText()
{
    let chest = GetCurrentChestData()
    if (!chest)
    {
        return
    }

    if (!chest.pity_threshold || chest.pity_threshold <= 0)
    {
        ChestGuaranteeText.visible = false
        ChestGuaranteeText.text = ""
        return
    }
    ChestGuaranteeText.visible = true

    let pity_value = chest_pity_state[chest.id] || 0
    let remaining = Math.max(0, chest.pity_threshold - pity_value)
    let rarity_text = chest.guarantee_rarity ? $.Localize("#services_chest_rarity_" + chest.guarantee_rarity) : ""
    ChestGuaranteeText.SetDialogVariable("value", String(remaining))
    ChestGuaranteeText.SetDialogVariable("rarity", rarity_text)
    ChestGuaranteeText.text = $.Localize("#services_chest_guarantee", ChestGuaranteeText)
}

function OpenChest(count)
{
    let chest = GetCurrentChestData()
    if (!chest)
    {
        return
    }
    if (chest_open_pending)
    {
        return
    }
    let actual_amount = CountStorageItem(chest.chest_item_id)
    chest.currency_amount = actual_amount
    if (actual_amount < count)
    {
        RenderChestProgress()
        $.Msg("[Chests] not enough spheres: chest=", chest.id, " need=", count, " have=", actual_amount)
        return
    }

    if (!chest_services_ready)
    {
        return
    }

    LockChestOpenButtons()
    RenderChestProgress()
    GameEvents.SendCustomGameEventToServer("event_services_open_chest", { chest_id: chest.id, count: count })
}

function LockChestOpenButtons()
{
    chest_open_pending = true
    chest_open_lock_serial += 1
    let lock_serial = chest_open_lock_serial
    $.Schedule(1.0, function()
    {
        if (chest_open_pending && lock_serial === chest_open_lock_serial)
        {
            UnlockChestOpenButtons()
        }
    })
}

function UpdateChestProbabilityTooltip()
{
    if (typeof SetChestChancesTooltip === "function")
    {
        SetChestChancesTooltip(ChestProbabilityButton, current_chest_id)
    }
}

function UnlockChestOpenButtons()
{
    let lock_serial = chest_open_lock_serial
    $.Schedule(0.25, function()
    {
        if (lock_serial !== chest_open_lock_serial)
        {
            return
        }
        chest_open_pending = false
        RenderChestProgress()
    })
}

function RenderChestRewards()
{
    ChestRewardsArea.RemoveAndDeleteChildren()
    ChestRewardsArea.SetHasClass("ChestRewardsSingle", chest_view_mode === "results" && current_chest_results.length === 1)
    ChestBackButton.style.visibility = chest_view_mode === "results" ? "visible" : "collapse"

    if (chest_view_mode !== "results" || !current_chest_results.length)
    {
        return
    }

    let reward_cards = []

    for (let reward of current_chest_results)
    {
        let card = $.CreatePanel("Panel", ChestRewardsArea, "")
        card.AddClass("ChestRewardCard")
        card.AddClass("ChestTier" + reward.tier)
        card.AddClass("ChestRewardCardPending")
        if (typeof SetServiceItemTooltip === "function")
        {
            SetServiceItemTooltip(card, reward.id, reward.count)
        }
        
        let ChestRewardCardBG = $.CreatePanel("Panel", card, "")
        ChestRewardCardBG.AddClass("ChestRewardCardBG")

        let ChestRewardCardFrame = $.CreatePanel("Panel", card, "")
        ChestRewardCardFrame.AddClass("ChestRewardCardFrame")

        let ChestRewardCardContent = $.CreatePanel("Panel", card, "")
        ChestRewardCardContent.AddClass("ChestRewardCardContent")

        let tier = $.CreatePanel("Label", ChestRewardCardContent, "")
        tier.AddClass("ChestRewardTier")
        tier.text = reward.tier

        let icon = $.CreatePanel("Panel", ChestRewardCardContent, "")
        icon.AddClass("ChestRewardIcon")
        icon.SetHasClass("ChestRewardIconConverted", !!reward.duplicate)
        ApplyBackgroundImage(icon, reward.icon)

        if ((Number(reward.count) || 1) > 1)
        {
            let count = $.CreatePanel("Label", icon, "")
            count.AddClass("ChestRewardIconCount")
            count.text = String(Number(reward.count) || 1)
        }

        if (reward.duplicate)
        {
            let converted = $.CreatePanel("Panel", ChestRewardCardContent, "")
            converted.AddClass("ChestRewardConvertedOverlay")

            let convertedLabel = $.CreatePanel("Label", converted, "")
            convertedLabel.AddClass("ChestRewardConvertedLabel")
            convertedLabel.text = $.Localize("#services_chest_reward_converted")

            let convertedItem = $.CreatePanel("Panel", converted, "")
            convertedItem.AddClass("ChestRewardConvertedItem")
            if (typeof SetServiceItemTooltip === "function")
            {
                SetServiceItemTooltip(convertedItem, reward.converted_id, reward.converted_count)
            }

            let convertedIcon = $.CreatePanel("Panel", convertedItem, "")
            convertedIcon.AddClass("ChestRewardConvertedIcon")
            ApplyBackgroundImage(convertedIcon, reward.converted_icon)

            if ((Number(reward.converted_count) || 1) > 1)
            {
                let convertedCount = $.CreatePanel("Label", convertedIcon, "")
                convertedCount.AddClass("ChestRewardConvertedCount")
                convertedCount.text = String(Number(reward.converted_count) || 1)
            }
        }

        let name = $.CreatePanel("Label", ChestRewardCardContent, "")
        name.AddClass("ChestRewardName")
        name.text = reward.name

        reward_cards.push(card)
    }

    let animation_serial = chest_animation_serial

    for (let index = 0; index < reward_cards.length; index++)
    {
        let delay = index * 0.08
        let card = reward_cards[index]

        $.Schedule(delay, function()
        {
            Game.EmitSound("up_card_spawn")
            if (animation_serial !== chest_animation_serial)
            {
                return
            }

            card.RemoveClass("ChestRewardCardPending")
            card.AddClass("ChestRewardCardVisible")

            let dropped_fx = $.CreatePanel("DOTAParticleScenePanel", card, "",
            {
                class: "ParticleDroppedFx",
                particleName: "particles/chest_dropped/chest_dropped.vpcf",
                particleonly: "true",
                startActive: "true",
                cameraOrigin: "0 0 40",
                lookAt: "0 0 0",
                fov: "64",
                squarePixels: "true",
                hittest: "false"
            })

            dropped_fx.DeleteAsync(3)
        })
    }
}

function UpdateChestPresentationMode()
{
    let show_progress = chest_view_mode !== "results"
    let animation_serial = chest_animation_serial

    if (show_progress)
    {
        ChestProgressArea.style.visibility = "visible"
        ChestGuaranteeText.style.visibility = "visible"
        ChestProgressArea.SetHasClass("ChestProgressAreaHidden", false)
        ChestGuaranteeText.SetHasClass("ChestGuaranteeTextHidden", false)
        return
    }

    ChestProgressArea.style.visibility = "visible"
    ChestGuaranteeText.style.visibility = "visible"
    ChestProgressArea.SetHasClass("ChestProgressAreaHidden", true)
    ChestGuaranteeText.SetHasClass("ChestGuaranteeTextHidden", true)

    $.Schedule(0.22, function()
    {
        if (animation_serial !== chest_animation_serial || chest_view_mode !== "results")
        {
            return
        }

        //ChestProgressArea.style.visibility = "collapse"
        //ChestGuaranteeText.style.visibility = "collapse"
    })
}

function ApplyBackgroundImage(panel, image_path)
{
    panel.style.backgroundImage = "url('" + image_path + "')"
    panel.style.backgroundSize = "contain"
    panel.style.backgroundRepeat = "no-repeat"
    panel.style.backgroundPosition = "center"
}

InitChests()