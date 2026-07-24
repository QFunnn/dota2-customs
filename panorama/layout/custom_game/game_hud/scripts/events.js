--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var LEVELUP_BOSS_HP_ACTIVE_ENTINDEX = null
var LEVELUP_BOSS_HP_LOOP_TOKEN = 0
var LEVELUP_BOSS_HP_BURNER_WIDTH = 595
var LEVELUP_NOTIFICATION_POP_OUT_DURATION = 0.68

function NormalizeLocalizationKey(key)
{
    key = String(key || "")
    return key.charAt(0) == "#" ? key : "#" + key
}

function GetLocalizedText(key, fallback, panel)
{
    if (!key)
    {
        return fallback || ""
    }

    const normalizedKey = NormalizeLocalizationKey(key)
    if ($.CanLocalize && $.CanLocalize(normalizedKey))
    {
        return panel ? $.Localize(normalizedKey, panel) : $.Localize(normalizedKey)
    }

    return fallback || normalizedKey
}

function ShowLevelupNotification(data)
{
    const root = $("#NotificationRoot")
    if (!root)
    {
        return
    }

    const notification = $.CreatePanel("Panel", root, "")
    notification.AddClass("LevelupNotification")

    const styleName = String((data && (data.style || data.style_class)) || "")
    if (styleName == "warning")
    {
        notification.AddClass("NotificationWarning")
    }
    else if (styleName == "miniboss")
    {
        notification.AddClass("NotificationMiniboss")
    }

    const label = $.CreatePanel("Label", notification, "")
    label.AddClass("LevelupNotificationText")
    const dialogVariables = data && data.dialog_variables
    if (dialogVariables)
    {
        for (const key in dialogVariables)
        {
            label.SetDialogVariable(String(key), String(dialogVariables[key]))
        }
    }
    label.text = data && data.text ? String(data.text) : GetLocalizedText(data && data.text_key, "", label)

    if (data && data.text_style == "gold")
    {
        label.AddClass("NotificationTextGold")
    }
    else if (data && data.text_style == "cyan")
    {
        label.AddClass("NotificationTextCyan")
    }

    if (data && data.color)
    {
        label.style.color = String(data.color)
    }
    if (data && Number(data.font_size) > 0)
    {
        label.style.fontSize = Math.floor(Number(data.font_size)) + "px"
    }
    if (data && data.font_weight)
    {
        label.style.fontWeight = String(data.font_weight)
    }

    const duration = Math.max(0.5, Number(data && data.duration || 5))
    $.Schedule(0.03, function()
    {
        if (notification && notification.IsValid())
        {
            notification.AddClass("NotificationVisible")
            notification.AddClass("NotificationPopIn")
            if (label && label.IsValid())
            {
                label.AddClass("NotificationTextFloating")
            }
        }
    })
    $.Schedule(duration, function()
    {
        if (notification && notification.IsValid())
        {
            notification.RemoveClass("NotificationPopIn")
            if (label && label.IsValid())
            {
                label.RemoveClass("NotificationTextFloating")
            }
            notification.AddClass("NotificationLeaving")
            notification.RemoveClass("NotificationVisible")
        }
    })
    notification.DeleteAsync(duration + LEVELUP_NOTIFICATION_POP_OUT_DURATION + 0.08)
}

function UpdateBossHPBarFromCustomHealth()
{
    if (LEVELUP_BOSS_HP_ACTIVE_ENTINDEX === null)
    {
        return
    }

    const healthTable = Game.GetCustomTable("health_data", "health_data") || {}
    const healthData = healthTable[String(LEVELUP_BOSS_HP_ACTIVE_ENTINDEX)]
    if (!healthData)
    {
        return
    }

    const healthPct = Math.max(0, Math.min(1, Number(healthData.health_percent || 0) / 100))
    const progress = $("#BossHPProgress")
    const burner = $("#hp_burner_container")
    const percentLabel = $("#BossHPPercentLabel")

    if (progress)
    {
        progress.value = healthPct
    }
    if (burner)
    {
        burner.style.width = (healthPct * LEVELUP_BOSS_HP_BURNER_WIDTH) + "px"
    }
    if (percentLabel)
    {
        percentLabel.text = Math.floor(healthPct * 100 + 0.5) + "%"
    }
}

function StartBossHPBarLoop()
{
    LEVELUP_BOSS_HP_LOOP_TOKEN += 1
    const token = LEVELUP_BOSS_HP_LOOP_TOKEN

    function Think()
    {
        if (token != LEVELUP_BOSS_HP_LOOP_TOKEN || LEVELUP_BOSS_HP_ACTIVE_ENTINDEX === null)
        {
            return
        }

        UpdateBossHPBarFromCustomHealth()
        $.Schedule(0.05, Think)
    }

    Think()
}

function EventBossHPBarShow(data)
{
    const panel = $("#BossHPPanel")
    const nameLabel = $("#BossNameLabel")
    const avatar = $("#BossAvatarImage")
    if (!panel)
    {
        return
    }

    LEVELUP_BOSS_HP_ACTIVE_ENTINDEX = String(data && data.entindex || "")
    panel.SetHasClass("BossHPNoAvatar", !(data && data.avatar))

    if (nameLabel)
    {
        const fallbackName = data && data.unit_name ? String(data.unit_name) : ""
        nameLabel.text = GetLocalizedText(data && data.name_key, fallbackName)
    }
    if (avatar && data && data.avatar)
    {
        avatar.SetImage(String(data.avatar))
    }

    UpdateBossHPBarFromCustomHealth()
    panel.AddClass("BossHPVisible")
    StartBossHPBarLoop()
}

function EventBossHPBarHide(data)
{
    LEVELUP_BOSS_HP_ACTIVE_ENTINDEX = null
    LEVELUP_BOSS_HP_LOOP_TOKEN += 1

    const panel = $("#BossHPPanel")
    if (panel)
    {
        panel.RemoveClass("BossHPVisible")
    }
}

GameEvents.Subscribe("game_event_show_levelup_notification", ShowLevelupNotification)
GameEvents.Subscribe("game_event_boss_hpbar_show", EventBossHPBarShow)
GameEvents.Subscribe("game_event_boss_hpbar_hide", EventBossHPBarHide)
GameEvents.Subscribe("game_event_tutorial_update", ShowLevelupTutorial)

Game.SubscribeCustomTableListener("health_data", (table, key, val, old) =>
{
    if (key == "health_data")
    {
        UpdateBossHPBarFromCustomHealth()
    }
});

GameEvents.Subscribe("game_event_update_wave_count", EventUpdateGameWave)
function IsInfinityHudEvent(data)
{
    return !!(data && (Number(data.is_infinity_mode) === 1 || String(data.timer_mode || "") === "count_up"))
}

function SetInfinityHudMode(enabled)
{
    const topHud = $("#TopHud")
    if (topHud)
    {
        topHud.SetHasClass("InfinityMode", enabled === true)
    }
}

function PadInfinityTime(value)
{
    value = Math.max(0, Math.floor(Number(value) || 0))
    return value < 10 ? "0" + value : String(value)
}

function FormatInfinityTime(totalSeconds)
{
    totalSeconds = Math.max(0, Math.floor(Number(totalSeconds) || 0))
    const hours = Math.floor(totalSeconds / 3600)
    const minutes = Math.floor((totalSeconds % 3600) / 60)
    const seconds = totalSeconds % 60
    if (hours > 0)
    {
        return String(hours) + ":" + PadInfinityTime(minutes) + ":" + PadInfinityTime(seconds)
    }
    return PadInfinityTime(minutes) + ":" + PadInfinityTime(seconds)
}

function EventUpdateGameWave(data)
{
    if (typeof IsAfkModeActive === "function" && IsAfkModeActive())
    {
        SetInfinityHudMode(false)
        $("#CurrentWaveLabel").text = ""
        return
    }
    if (IsInfinityHudEvent(data))
    {
        SetInfinityHudMode(true)
        $("#CurrentWaveLabel").text = String($.Localize("#levelup_wave")).trim()
            + " " + Math.max(1, Math.floor(Number(data.infinity_wave) || 1))
        return
    }
    SetInfinityHudMode(false)
    $("#CurrentWaveLabel").text = $.Localize("#levelup_wave") + data.current_wave+"/"+data.max_wave
}

GameEvents.Subscribe("game_event_update_wave_timer", EventUpdateGameTimer)
function EventUpdateGameTimer(data)
{
    if (typeof IsAfkModeActive === "function" && IsAfkModeActive())
    {
        SetInfinityHudMode(false)
        $("#CurrentTimeLabel").text = $.Localize("#levelup_afk_timer")
        return
    }
    if (IsInfinityHudEvent(data))
    {
        SetInfinityHudMode(true)
        $("#CurrentTimeLabel").text = FormatInfinityTime(data.elapsed_seconds)
        return
    }
    SetInfinityHudMode(false)
    if (typeof IsPostStageDummyTimerActive === "function" && IsPostStageDummyTimerActive())
    {
        return
    }
    if (typeof IsPostStageDummyCountdownActive === "function" && IsPostStageDummyCountdownActive())
    {
        return
    }

    if (typeof SetPostStageTrialsDisabled === "function")
    {
        SetPostStageTrialsDisabled(data.post_stage_result == "win" || data.post_stage_result == "lose")
    }

    if (data.post_stage_result == "win")
    {
        $("#CurrentTimeLabel").text = $.Localize("#levelup_post_stage_win")
        return
    }
    if (data.post_stage_result == "lose")
    {
        $("#CurrentTimeLabel").text = $.Localize("#levelup_post_stage_lose")
        return
    }
    $("#CurrentTimeLabel").text = ConvertTimeMinutes(data.time)
}

GameEvents.Subscribe("game_event_post_stage_dummy_timer_start", EventPostStageDummyTimerStart)
function EventPostStageDummyTimerStart(data)
{
    if (typeof StopPostStageDummyCountdown === "function")
    {
        StopPostStageDummyCountdown()
    }
    if (typeof StartPostStageDummyTimer === "function")
    {
        const now = Math.max(0, Game.GetGameTime())
        const duration = Number(data && data.duration || 60)
        let endsAt = Number(data && data.ends_at || 0)
        if (endsAt <= now)
        {
            endsAt = now + duration
        }
        StartPostStageDummyTimer(endsAt)
    }
}

GameEvents.Subscribe("game_event_post_stage_dummy_timer_stop", EventPostStageDummyTimerStop)
function EventPostStageDummyTimerStop(data)
{
    if (typeof StopPostStageDummyTimer === "function")
    {
        StopPostStageDummyTimer()
    }
}

GameEvents.Subscribe("game_event_post_stage_aghanim_timer_start", EventPostStageAghanimTimerStart)
function EventPostStageAghanimTimerStart(data)
{
    if (typeof StopPostStageAghanimCountdown === "function")
    {
        StopPostStageAghanimCountdown()
    }
    if (typeof StartPostStageAghanimTimer === "function")
    {
        const now = Math.max(0, Game.GetGameTime())
        const duration = Number(data && data.duration || 45)
        let endsAt = Number(data && data.ends_at || 0)
        if (endsAt <= now)
        {
            endsAt = now + duration
        }
        StartPostStageAghanimTimer(endsAt)
    }
}

GameEvents.Subscribe("game_event_post_stage_aghanim_timer_stop", EventPostStageAghanimTimerStop)
function EventPostStageAghanimTimerStop(data)
{
    if (typeof StopPostStageAghanimTimer === "function")
    {
        StopPostStageAghanimTimer()
    }
}

GameEvents.Subscribe("game_event_post_stage_dummy_countdown_start", EventPostStageDummyCountdownStart)
function EventPostStageDummyCountdownStart(data)
{
    if (typeof StartPostStageDummyCountdown === "function")
    {
        StartPostStageDummyCountdown(data)
    }
}

GameEvents.Subscribe("game_event_post_stage_dummy_countdown_stop", EventPostStageDummyCountdownStop)
function EventPostStageDummyCountdownStop(data)
{
    if (typeof StopPostStageDummyCountdown === "function")
    {
        StopPostStageDummyCountdown()
    }
}

GameEvents.Subscribe("game_event_post_stage_aghanim_countdown_start", EventPostStageAghanimCountdownStart)
function EventPostStageAghanimCountdownStart(data)
{
    if (typeof StartPostStageAghanimCountdown === "function")
    {
        StartPostStageAghanimCountdown(data)
    }
}

GameEvents.Subscribe("game_event_post_stage_aghanim_countdown_stop", EventPostStageAghanimCountdownStop)
function EventPostStageAghanimCountdownStop(data)
{
    if (typeof StopPostStageAghanimCountdown === "function")
    {
        StopPostStageAghanimCountdown()
    }
}

GameEvents.Subscribe("game_event_post_stage_boss_rush_countdown_start", EventPostStageBossRushCountdownStart)
function EventPostStageBossRushCountdownStart(data)
{
    if (typeof StartPostStageBossRushCountdown === "function")
    {
        StartPostStageBossRushCountdown(data)
    }
}

GameEvents.Subscribe("game_event_post_stage_boss_rush_countdown_stop", EventPostStageBossRushCountdownStop)
function EventPostStageBossRushCountdownStop(data)
{
    if (typeof StopPostStageBossRushCountdown === "function")
    {
        StopPostStageBossRushCountdown()
    }
}

GameEvents.Subscribe("game_event_update_difficulty", EventUpdateDifficulty)
function EventUpdateDifficulty(data)
{
    if (typeof IsAfkModeActive === "function" && IsAfkModeActive())
    {
        SetInfinityHudMode(false)
        $("#CurrentDifficultLabel").text = $.Localize("#levelup_afk_game_mode")
        return
    }
    if (IsInfinityHudEvent(data))
    {
        SetInfinityHudMode(true)
        $("#CurrentDifficultLabel").text = $.Localize("#infinity_mode_title")
        return
    }
    SetInfinityHudMode(false)
    $("#CurrentDifficultLabel").text = $.Localize("#levelup_difficulty") + data.current_difficulty + "-" + data.current_floor
}

GameEvents.Subscribe("game_event_infinity_mode_ended", EventInfinityModeEnded)
function EventInfinityModeEnded(data)
{
    const elapsedText = FormatInfinityTime(data && data.elapsed_seconds)
    SetInfinityHudMode(true)
    $("#CurrentWaveLabel").text = String($.Localize("#levelup_wave")).trim()
        + " " + (Math.floor(Math.max(0, Number(data && data.elapsed_seconds) || 0) / 600) + 1)
    $("#CurrentDifficultLabel").text = $.Localize("#infinity_mode_title")
    $("#CurrentTimeLabel").text = elapsedText
}

GameEvents.Subscribe("game_event_sync_item_slots", EventUpdateItemsList)
function EventUpdateItemsList(data)
{
    $.Schedule(0.1, function()
    {
        UPDATE_PLAYER_ITEMS = true
    })
}

GameEvents.Subscribe("game_event_update_player_abilities", EventUpdatePlayerAbilities)
function EventUpdatePlayerAbilities(data)
{
    $.Schedule(0.1, function()
    {
        UPDATE_PLAYER_ABILITIES = true
    })
}

Game.SubscribeCustomTableListener("currency_data", (table, key, val, old) => 
{
    if (key == String(Game.GetLocalPlayerID()))
    {
        $.Schedule(0, function()
        {
            $("#CurrencyGold").text = Math.floor(val.gold)
            $("#CurrencyWood").text = Math.floor(val.wood)
            $("#CurrencyWeapon").text = Math.floor(val.kills)
        })
    }
});

Game.SubscribeCustomTableListener("post_stage_activity_state", (table, key, val, old) =>
{
    if (key == "global" && typeof ApplyPostStageActivityState === "function")
    {
        ApplyPostStageActivityState(val)
    }
});

Game.SubscribeCustomTableListener("afk_mode_state", (table, key, val, old) =>
{
    if (key == String(Game.GetLocalPlayerID()) && typeof ApplyAfkModeHudState === "function")
    {
        ApplyAfkModeHudState(val)
    }
});

GameEvents.Subscribe("game_event_afk_mode_started", EventAfkModeStarted)
function EventAfkModeStarted(data)
{
    const state = Game.GetCustomTable("afk_mode_state", String(Game.GetLocalPlayerID()))
    if (typeof ApplyAfkModeHudState === "function")
    {
        ApplyAfkModeHudState(state && state.active !== undefined ? state : data)
    }
}

GameEvents.Subscribe("game_event_update_upgrade_list", EventUpdateUpgradesList)
function EventUpdateUpgradesList(data)
{
    OpenUpgradePanel(data)
}

GameEvents.Subscribe("game_event_update_card_list", EventUpdateCardList)
function EventUpdateCardList(data)
{
    OpenCardPanel(data)
}

GameEvents.Subscribe("game_event_update_card_stash", EventUpdateCardStash)
var SAVED_CARD_STASH_DATA = {}
var SAVED_CARD_INVENTORY_DATA = {}

function MergeEventPatch(oldVal, patchVal)
{
    if (Game.MergeCustomTablePatch)
    {
        return Game.MergeCustomTablePatch(oldVal, patchVal) || {};
    }
    return patchVal || {};
}

function EventUpdateCardStash(data)
{
    SAVED_CARD_STASH_DATA = MergeEventPatch(SAVED_CARD_STASH_DATA, data)
    UpdateCardStashList(SAVED_CARD_STASH_DATA)
}

GameEvents.Subscribe("game_event_open_neutral_roshan_bonus_panel", EventOpenNeutralRoshanBonusPanel)
function EventOpenNeutralRoshanBonusPanel(data)
{
    OpenNeutralRoshanBonusPanel(data)
}

GameEvents.Subscribe("game_event_close_neutral_roshan_bonus_panel", EventCloseNeutralRoshanBonusPanel)
function EventCloseNeutralRoshanBonusPanel(data)
{
    CloseNeutralRoshanBonusPanel(false)
}

GameEvents.Subscribe("game_event_open_neutral_roshan_artefact_selector", EventOpenNeutralRoshanArtefactSelector)
function EventOpenNeutralRoshanArtefactSelector(data)
{
    OpenNeutralRoshanArtefactSelector(data)
}

GameEvents.Subscribe("game_event_close_neutral_roshan_artefact_selector", EventCloseNeutralRoshanArtefactSelector)
function EventCloseNeutralRoshanArtefactSelector(data)
{
    CloseNeutralRoshanArtefactSelector()
}

GameEvents.Subscribe("game_event_open_post_stage_activity_panel", EventOpenPostStageActivityPanel)
function EventOpenPostStageActivityPanel(data)
{
    OpenPostStageActivityPanel(data)
}

GameEvents.Subscribe("game_event_close_post_stage_activity_panel", EventClosePostStageActivityPanel)
function EventClosePostStageActivityPanel(data)
{
    ClosePostStageActivityPanel(false)
}

GameEvents.Subscribe("game_event_open_post_stage_home_panel", EventOpenPostStageHomePanel)
function EventOpenPostStageHomePanel(data)
{
    OpenPostStageHomePanel()
}

GameEvents.Subscribe("game_event_close_post_stage_home_panel", EventClosePostStageHomePanel)
function EventClosePostStageHomePanel(data)
{
    ClosePostStageHomePanel(false)
}

GameEvents.Subscribe("game_event_match_restart_reset_ui", EventMatchRestartResetUI)
function EventMatchRestartResetUI(data)
{
    SAVED_CARD_STASH_DATA = {}
    SAVED_CARD_INVENTORY_DATA = {}
    if (typeof UpdateCardStashList === "function")
    {
        UpdateCardStashList(SAVED_CARD_STASH_DATA)
    }
    if (typeof UpdateCardInventoryList === "function")
    {
        UpdateCardInventoryList(SAVED_CARD_INVENTORY_DATA)
    }
    if (typeof ResetMatchProgressClientUI === "function")
    {
        ResetMatchProgressClientUI()
    }
}

GameEvents.Subscribe("game_event_post_stage_activity_blocked", EventPostStageActivityBlocked)
function EventPostStageActivityBlocked(data)
{
    ShowPostStageActivityHint("post_stage_activity_blocked")
}

GameEvents.Subscribe("game_event_post_stage_aghanim_unavailable", EventPostStageAghanimUnavailable)
function EventPostStageAghanimUnavailable(data)
{
    ShowPostStageActivityHint("post_stage_activity_aghanim_unavailable")
}

GameEvents.Subscribe("game_event_post_stage_dummy_unavailable", EventPostStageDummyUnavailable)
function EventPostStageDummyUnavailable(data)
{
    ShowPostStageActivityHint("post_stage_activity_dummy_unavailable")
}

GameEvents.Subscribe("game_event_post_stage_boss_rush_unavailable", EventPostStageBossRushUnavailable)
function EventPostStageBossRushUnavailable(data)
{
    ShowPostStageActivityHint("post_stage_activity_boss_rush_unavailable")
}

GameEvents.Subscribe("game_event_post_stage_aghanim_rewards_update", EventPostStageAghanimRewardsUpdate)
function EventPostStageAghanimRewardsUpdate(data)
{
    UpdateAghanimRewardPanel(data)
}

GameEvents.Subscribe("game_event_post_stage_aghanim_rewards_hide", EventPostStageAghanimRewardsHide)
function EventPostStageAghanimRewardsHide(data)
{
    HideAghanimRewardPanel()
}

GameEvents.Subscribe("game_event_post_stage_aghanim_continue_open", EventPostStageAghanimContinueOpen)
function EventPostStageAghanimContinueOpen(data)
{
    OpenAghanimContinuePrompt(data)
}

GameEvents.Subscribe("game_event_post_stage_aghanim_continue_update", EventPostStageAghanimContinueUpdate)
function EventPostStageAghanimContinueUpdate(data)
{
    UpdateAghanimContinuePrompt(data)
}

GameEvents.Subscribe("game_event_post_stage_aghanim_continue_close", EventPostStageAghanimContinueClose)
function EventPostStageAghanimContinueClose(data)
{
    CloseAghanimContinuePrompt()
}

GameEvents.Subscribe("game_event_match_result_open", EventMatchResultOpen)
function EventMatchResultOpen(data)
{
    OpenMatchResultPanel(data)
}

GameEvents.Subscribe("game_event_dummy_leaderboard_update", EventDummyLeaderboardUpdate)
function EventDummyLeaderboardUpdate(data)
{
    RenderLeaderboardPanel(data)
}

GameEvents.Subscribe("game_event_update_card_inventory", EventUpdateCardInventory)
function EventUpdateCardInventory(data)
{
    SAVED_CARD_INVENTORY_DATA = MergeEventPatch(SAVED_CARD_INVENTORY_DATA, data)
    UpdateCardInventoryList(SAVED_CARD_INVENTORY_DATA)
}

GameEvents.Subscribe("game_event_animate_card_to_stash", EventCardAnimateToStash)
function EventCardAnimateToStash(data)
{
    let m = Game.GetScreenHeight() / 1080   
    let card_place = data.card_place
    let ChooseCardBaseImageAnimateStash = $.CreatePanel("Image", $.GetContextPanel(), "")
    ChooseCardBaseImageAnimateStash.hittest = false
    let delay_move = 0.1
    let delay_opacity = 0.4
    let delay_destroy = 1.2
    let centerX = (Game.GetScreenWidth()  / 2) / m;
    let centerY = (Game.GetScreenHeight() / 2) / m;
    ChooseCardBaseImageAnimateStash.style.x = centerX + "px"
    ChooseCardBaseImageAnimateStash.style.y = centerY + "px"
    if (data.is_faster)
    {
        ChooseCardBaseImageAnimateStash.AddClass("ChooseCardBaseImageAnimateStashFaster")
    }
    else
    {
        ChooseCardBaseImageAnimateStash.AddClass("ChooseCardBaseImageAnimateStash")
    }
    ChooseCardBaseImageAnimateStash.DeleteAsync(delay_destroy)
    ChooseCardBaseImageAnimateStash.SetImage("file://{images}/card_list/" + data.card_image + ".png")
    let target_panel = $("#CardStashPanel_"+card_place)
    target_panel_pos_x = (target_panel.GetPositionWithinWindow().x / m)
    target_panel_pos_y = (target_panel.GetPositionWithinWindow().y / m)
    let offsetX = 0 //-100;
    let offsetY = 0 //-240;
    $.Schedule(delay_move, function()
    {
        ChooseCardBaseImageAnimateStash.style.x = target_panel_pos_x + offsetX + "px";
        ChooseCardBaseImageAnimateStash.style.y = target_panel_pos_y + offsetY + "px";
    })
    $.Schedule(delay_opacity, function()
    {
        ChooseCardBaseImageAnimateStash.style.opacity = "0"
    })
}

GameEvents.Subscribe("game_event_animate_card_stash_fade", EventStashFadeOut)
function EventStashFadeOut(data)
{
    let target_panel = $("#CardStashPanel_"+data.card_place)
    if (target_panel)
    {
        let CardFadeAnim = $.CreatePanel("DOTAParticleScenePanel", target_panel, "", 
        { 
            style: "width:100%;height:100%;",
            class: "CardFadeAnim",
            particleName: "particles/ui/ui_card_to_dust_custom.vpcf", 
            particleonly:"true", 
            startActive:"true", 
            cameraOrigin:"0 0 550", 
            lookAt:"0 90 0",
            fov:"10", 
            squarePixels:"true",
            hittest: "false"
        });
        CardFadeAnim.hittest = false
        CardFadeAnim.DeleteAsync(2)
    }
}

Game.SubscribeCustomTableListener("abilities_cost", (table, key, val, old) => 
{
    if (key == String(Game.GetLocalPlayerID()))
    {
        if (AbilitiesList)
        {
            for (let ability_name of Object.keys(val))
            {
                let ability_cost_data = val[ability_name]
                let ability_panel = AbilitiesList.FindChildTraverse("AbilityData_"+ability_name)
                if (ability_panel)
                {
                    let CostAbilityLabel = ability_panel.FindChildTraverse("CostAbilityLabel")
                    if (CostAbilityLabel)
                    {
                        CostAbilityLabel.text = ability_cost_data[1]
                        CostAbilityLabel.GetParent().style.opacity = ability_cost_data[1] > 0 ? 1 : 0
                    }
                }
            }
        }
    }
});

Game.SubscribeCustomTableListener("player_stats", (table, key, data, old) => 
{
    if (key == String(Game.GetLocalPlayerID()))
    {
        $.Schedule(0, function()
        {
            $("#BaseStatsLabelDamage").text = Math.floor(data.damage)
            $("#BaseStatsLabelArmor").text = Math.floor(data.base_armor)
            $("#BaseStatsLabelSpeed").text = Math.floor(data.movement_speed)
            $("#BaseStatsLabelStr").text = Math.floor(data.base_strength)
            $("#BaseStatsLabelAgi").text =  Math.floor(data.base_agility)
            $("#BaseStatsLabelInt").text = Math.floor(data.base_intellect)

            ApplyStatFormat($("#AddStatsLabelDamage"), Math.floor(data.bonus_damage)) 
            ApplyStatFormat($("#AddStatsLabelArmor"), Math.floor(data.armor)) 
            ApplyStatFormat($("#AddStatsLabelStr"), Math.floor(data.strength)) 
            ApplyStatFormat($("#AddStatsLabelAgi"), Math.floor(data.agility)) 
            ApplyStatFormat($("#AddStatsLabelInt"), Math.floor(data.intellect))
        })
    }
}); 

Game.SubscribeCustomTableListener("economy_stats", (table, key, data, old) => 
{
    let player_panel = PlayersStatsEconomyList.FindChildTraverse("PlayerStatPanel_"+key)
    if (player_panel)
    {
        player_panel.GoldValue = player_panel.GoldValue || player_panel.FindChildTraverse("GoldValue")
        if (player_panel.GoldValue)
        {
            player_panel.GoldValue.text = (data.gold || 0)
        }
        player_panel.WoodValue = player_panel.WoodValue || player_panel.FindChildTraverse("WoodValue")
        if (player_panel.WoodValue)
        {
            player_panel.WoodValue.text = (data.wood || 0)
        }
        player_panel.KillsValue = player_panel.KillsValue || player_panel.FindChildTraverse("KillsValue")
        if (player_panel.KillsValue)
        {
            player_panel.KillsValue.text = (data.kills || 0)
        }
        player_panel.DeathsValue = player_panel.DeathsValue || player_panel.FindChildTraverse("DeathsValue")
        if (player_panel.DeathsValue)
        {
            player_panel.DeathsValue.text = (data.deaths || 0)
        }
    }
});

Game.SubscribeCustomTableListener("damage_stats", (table, key, data, old) => 
{
    if (key == String(Game.GetLocalPlayerID()))
    {
        UpdateSelfDamageAbilities(data)
    }
    SAVED_ALL_DAMAGE_PLAYERS[key] = data
    UpdateAllPlayersDamage(SAVED_ALL_DAMAGE_PLAYERS)
});

Game.SubscribeCustomTableListener("heroes_card_player", (table, key, data, old) => 
{
    if (key == String(Game.GetLocalPlayerID()))
    {
        ChooseNewHeroButtonStartChallenge.visible = data.challenge_counters > 0
        ChooseNewHeroButtonStartChallengeCounter.text = data.challenge_counters
        ChooseNewHeroButtonOpenHeroCards.visible = data.heroes_reload_counter > 0
        ChooseNewHeroButtonOpenHeroCardsCounter.text = data.heroes_reload_counter
        ChooseNewHeroButtonInfoRefresher.SetHasClass("CloseIconKillsButton", data.updates_heroes_counter > 0)
        ChooseNewHeroButtonInfoUpdater.SetDialogVariable("value", data.updates_heroes_counter)
        ChooseNewHeroButtonInfoUpdater.text = data.updates_heroes_counter > 0 ? $.Localize("#levelup_card_replace_counter", ChooseNewHeroButtonInfoUpdater) : data.summary_updates_price
    }
});

Game.SubscribeCustomTableListener("challenger_state", (table, key, data, old) => 
{
    if (key == String(Game.GetLocalPlayerID()))
    {
        UpdateChallengerState(data)
    }
});

Game.SubscribeCustomTableListener("abyss_state", (table, key, data, old) => 
{
    if (key == String(Game.GetLocalPlayerID()))
    {
        UpdateAbyssState(data)
    }
});

GameEvents.Subscribe("game_event_update_hero_card_list", EventUpdateHeroCardList)
function EventUpdateHeroCardList(data)
{
    let current_card_list = data.current_card_list
    UpdateHeroCardList(current_card_list)
}

Game.SubscribeCustomTableListener("ui_hero_data", (table, key, data, old) => 
{
    if (key == String(Game.GetLocalPlayerID()))
    {
        HeroName.text = $.Localize("#"+data.hero_name)
        HeroAvatarImage.SetImage("file://{images}/heroes_list/"+data.hero_name+".png")
    }
});

Game.SubscribeCustomTableListener("ultimate_state", (table, key, data, old) => 
{
    if (key == String(Game.GetLocalPlayerID()))
    {
        UpdateUltimateData(data)
    }
});

Game.SubscribeCustomTableListener("artefact_state", (table, key, data, old) => 
{
    if (key == String(Game.GetLocalPlayerID()))
    {
        UpdateArtefactData(data) 
    }
});

Game.SubscribeCustomTableListener("black_store_data", (table, key, data, old) => 
{
    if (key == String(Game.GetLocalPlayerID()))
    {
        UpdateBlackStore(data)
    }
});

Game.SubscribeCustomTableListener("player_difficult_complete", (table, key, data, old) =>
{
    if (!StartGamePanel || !StartGamePanel.BHasClass("Opened")) { return }
    RenderStartGameLobbyProgress()
    // Перерисовка списка выбора при обновлении таблицы завершённых сложностей не
    // должна сбрасывать уже сделанный игроком выбор (DrawSelect* всегда обнуляют
    // SAVED_CHOOSE_* до 1). Иначе на рестарте выбранный этаж/сложность молча
    // слетает — игрок видит 5-5, а запускается меньший этаж.
    let keep_difficult = SAVED_CHOOSE_DIFFICULT
    let keep_floor = SAVED_CHOOSE_FLOOR
    if (START_GAME_INFO_CONTEXT == "difficulty")
    {
        DrawSelectDifficult()
        SAVED_CHOOSE_DIFFICULT = keep_difficult
        if (START_GAME_RESTART_MODE)
        {
            MarkStartGameButtonActive(keep_difficult)
            StartGameInfoRenderDifficulty(keep_difficult)
        }
    }
    else if (START_GAME_INFO_CONTEXT == "floor")
    {
        DrawSelectFloor(keep_difficult)
        SAVED_CHOOSE_DIFFICULT = keep_difficult
        SAVED_CHOOSE_FLOOR = keep_floor
        if (START_GAME_RESTART_MODE)
        {
            MarkStartGameButtonActive(keep_floor)
            StartGameInfoRenderFloor(keep_difficult, keep_floor)
        }
    }
});

GameEvents.Subscribe("event_update_black_store_hide", EventUpdateBlackStoreHide)
function EventUpdateBlackStoreHide()
{
    GameItemsStoreList.RemoveAndDeleteChildren()
    GameItemsStorePanel.SetHasClass("OpenBlackStore", false)
}

GameEvents.Subscribe("event_update_black_store_timer", EventUpdateBlackStoreTimer)
function EventUpdateBlackStoreTimer(data)
{
    GameItemsStoreButtonChangeDataCooldownLabel.text = Math.floor(data.store_cooldown)
}

GameEvents.Subscribe("event_draw_game_start_for_player", event_draw_game_start_for_player)
function event_draw_game_start_for_player(data)
{
    DrawGameStart(data)
}

GameEvents.Subscribe("event_player_death_start", event_player_death_start)
function event_player_death_start(data)
{
    CreateDeathScreen({time : data.time})
}

GameEvents.Subscribe("event_player_death_update", event_player_death_update)
function event_player_death_update(data)
{
    UpdateDeathScreen({time : data.time})
} 

GameEvents.Subscribe("event_player_death_close", event_player_death_close)
function event_player_death_close(data)
{
    DestroyDeathScreen()
} 

GameEvents.Subscribe("event_choose_game_start_button_update", event_choose_game_start_button_update)
function event_choose_game_start_button_update(data)
{
    for (let child of StartGameSelectorList.Children())
    {
        child.SetHasClass("DifficultActive", child.id == ("DifficultButton_"+data.id))
    }
    if (String(data.id).indexOf("game_mode_") == 0)
    {
        const gameMode = String(data.id).replace("game_mode_", "")
        SAVED_CHOOSE_GAME_MODE = gameMode
        MarkStartGameModeButtonActive(gameMode)
        StartGameInfoRenderMode(gameMode)
    }
    else if (SAVED_DIFFUCULTS_DATA[String(data.id)])
    {
        if (START_GAME_INFO_CONTEXT == "floor")
        {
            SAVED_CHOOSE_FLOOR = data.id
            StartGameInfoRenderFloor(SAVED_CHOOSE_DIFFICULT, data.id)
        }
        else
        {
            SAVED_CHOOSE_DIFFICULT = data.id
            StartGameInfoRenderDifficulty(data.id)
        }
    }
    else
    {
        SAVED_CHOOSE_FLOOR = data.id
        StartGameInfoRenderFloor(SAVED_CHOOSE_DIFFICULT, data.id)
    }
}

GameEvents.Subscribe("event_choose_game_start_window_update", event_choose_game_start_window_update)
function event_choose_game_start_window_update(data)
{
    if (data.start_game)
    {
        CloseStartGame()
        return
    }
    if (data.back_to_mode)
    {
        DrawSelectGameMode()
        return
    }
    if (data.game_mode == "normal" || data.game_mode == "hardcore")
    {
        DrawSelectDifficult()
        return
    }
    if (data.is_back)
    {
        DrawSelectDifficult()
    }
    else
    {
        DrawSelectFloor(data.difficult)
    }
}

GameEvents.Subscribe("event_update_debug_tables", event_update_debug_tables)
function event_update_debug_tables(data)
{
    let list = Object.values(data)
    let count = list.length
    $.Msg("====================================")
    $.Msg("[CustomTables] Updates per second: " + count)
    $.Msg("------------------------------------")
    if (count === 0)
    {
        $.Msg(" (empty)")
    }
    else
    {
        for (let i = 0; i < list.length; i++)
        {
            $.Msg(" [" + (i + 1).toString().padStart(2, '0') + "] " + String(list[i]))
        }
    }
    $.Msg("====================================")
}

Game.SubscribeCustomTableListener("change_stats_stone_data", (table, key, data, old) => 
{
    if (key == String(Game.GetLocalPlayerID()))
    {
        UpdateSwapStatsPanel(data)
    }
});