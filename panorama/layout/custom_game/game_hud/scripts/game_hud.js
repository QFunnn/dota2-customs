--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


// const
const HealthBarFront = $("#HealthBarFront")
const HealthBarLabel = $("#HealthBarLabel")
const HealthRegen = $("#HealthRegen")
const ManaBarFront = $("#ManaBarFront")
const ManaBarLabel = $("#ManaBarLabel")
const ManaRegen = $("#ManaRegen")
const HeroLevelCircleActive = $("#HeroLevelCircleActive")
const HeroLevelLabel = $("#HeroLevelLabel")
const HeroName = $("#HeroName")
const AbilitiesList = $("#AbilitiesList")
const ItemsList1 = $("#ItemsList1")
const ItemsList2 = $("#ItemsList2")
const StatsNavigation = $("#StatsNavigation")
const PlayersStatsEconomyList = $("#PlayersStatsEconomyList")
const StatsListParent = $("#StatsListParent")
const ItemsContainer = $("#ItemsContainer")
const LowerHud = $("#LowerHud")
const GameHudNotifications = $("#GameHudNotifications")
const TutorialOverlayRoot = $("#TutorialOverlayRoot")
const TutorialTargetFrame = $("#TutorialTargetFrame")
const TutorialHintPanel = $("#TutorialHintPanel")
const TutorialHintTitle = $("#TutorialHintTitle")
const TutorialHintText = $("#TutorialHintText")
const TutorialHintReward = $("#TutorialHintReward")
const TutorialHintClose = $("#TutorialHintClose")
if (TutorialHintClose)
{
    TutorialHintClose.SetPanelEvent("onactivate", function()
    {
        GameEvents.SendCustomGameEventToServer("event_tutorial_dismiss", {})
        HideLevelupTutorial()
    })
}
const UpgradeStatsLevel = $("#UpgradeStatsLevel")
const UpgradeStatsList = $("#UpgradeStatsList")
const ChooseCardList = $("#ChooseCardList")
const CardSelectorList = $("#CardSelectorList")
const CardSystemBaseStashSlots = 5
const minimap_container = $("#minimap_container")
const PanelChooseCard = $("#PanelChooseCard")
const PanelChooseBodyCard = $("#PanelChooseBodyCard")
const ChooseCardButtonReroll = $("#ChooseCardButtonReroll")
const ChooseCardButtonCancel = $("#ChooseCardButtonCancel")
const ChooseCardButtonInfoUpdater = $("#ChooseCardButtonInfoUpdater")
const PanelReplaceCard = $("#PanelReplaceCard")
const PanelReplaceCardData = $("#PanelReplaceCardData")
const CardButtonReplaceBack = $("#CardButtonReplaceBack")
const CardButtonReplaceCancel = $("#CardButtonReplaceCancel")
const NeutralRoshanBonusPanel = $("#NeutralRoshanBonusPanel")
const NeutralRoshanBonusBody = $("#NeutralRoshanBonusBody")
const NeutralRoshanBonusList = $("#NeutralRoshanBonusList")
const NeutralRoshanBonusProgress = $("#NeutralRoshanBonusProgress")
const ArtefactSelectorPanel = $("#ArtefactSelectorPanel")
const ArtefactSelectorBody = $("#ArtefactSelectorBody")
const ArtefactSelectorList = $("#ArtefactSelectorList")
const ArtefactSelectorRerollButton = $("#ArtefactSelectorRerollButton")
const ArtefactSelectorRerollInfo = $("#ArtefactSelectorRerollInfo")
const ArtefactSelectorRestoreButtons = $("#ArtefactSelectorRestoreButtons")
const PostStageActivityPanel = $("#PostStageActivityPanel")
const PostStageActivityBody = $("#PostStageActivityBody")
const PostStageDummyOption = $("#PostStageDummyOption")
const PostStageAghanimOption = $("#PostStageAghanimOption")
const PostStageHomePanel = $("#PostStageHomePanel")
const PostStageHomeBody = $("#PostStageHomeBody")
const PostStageHomeConfirmButton = $("#PostStageHomeConfirmButton")
const PostStageHomeCancelButton = $("#PostStageHomeCancelButton")
const PostStageRestartConfirmPanel = $("#PostStageRestartConfirmPanel")
const PostStageRestartConfirmHeaderLabel = $("#PostStageRestartConfirmHeaderLabel")
const PostStageRestartConfirmDescriptionLabel = $("#PostStageRestartConfirmDescriptionLabel")
const PostStageRestartConfirmButton = $("#PostStageRestartConfirmButton")
const PostStageRestartConfirmButtonLabel = $("#PostStageRestartConfirmButtonLabel")
const PostStageRestartCancelButton = $("#PostStageRestartCancelButton")
const PostStageActivityBlockedHint = $("#PostStageActivityBlockedHint")
const PostStageDummyCountdownPanel = $("#PostStageDummyCountdownPanel")
const PostStageDummyCountdownTitle = $("#PostStageDummyCountdownTitle")
const PostStageDummyCountdownNumber = $("#PostStageDummyCountdownNumber")
const AghanimRewardPanel = $("#AghanimRewardPanel")
const AghanimRewardItems = $("#AghanimRewardItems")
const AghanimRewardHint = $("#AghanimRewardHint")
const AghanimRewardConfirmButton = $("#AghanimRewardConfirmButton")
const AfkRewardsPanel = $("#AfkRewardsPanel")
const AfkRewardsItems = $("#AfkRewardsItems")
const AfkDailyLimitLabel = $("#AfkDailyLimitLabel")
const AfkReceivedRewardsPanel = $("#AfkReceivedRewardsPanel")
const AfkReceivedRewardItems = $("#AfkReceivedRewardItems")
const AfkReceivedRewardHint = $("#AfkReceivedRewardHint")
const AghanimContinuePanel = $("#AghanimContinuePanel")
const AghanimContinueTitle = $("#AghanimContinueTitle")
const AghanimContinueTimer = $("#AghanimContinueTimer")
const AghanimContinueButton = $("#AghanimContinueButton")
const AghanimLeaveButton = $("#AghanimLeaveButton")
const AghanimContinueVotes = $("#AghanimContinueVotes")
const MatchResultPanel = $("#MatchResultPanel")
const MatchResultDim = $("#MatchResultDim")
const MatchResultTitle = $("#MatchResultTitle")
const MatchResultStage = $("#MatchResultStage")
const MatchResultDuration = $("#MatchResultDuration")
const MatchResultRows = $("#MatchResultRows")
const MatchResultCardsPopup = $("#MatchResultCardsPopup")
const MatchResultCardsTitle = $("#MatchResultCardsTitle")
const MatchResultCardsList = $("#MatchResultCardsList")
const MatchResultCardsCloseButton = $("#MatchResultCardsCloseButton")
const MatchResultTopButton = $("#MatchResultTopButton")
const LeaderboardPanel = $("#LeaderboardPanel")
const LeaderboardBody = $("#LeaderboardBody")
const LeaderboardPodium = $("#LeaderboardPodium")
const LeaderboardRows = $("#LeaderboardRows")
const LeaderboardStatus = $("#LeaderboardStatus")
const LeaderboardSelfRow = $("#LeaderboardSelfRow")
const PanelInventoryCard = $("#PanelInventoryCard")
const CardInventoryList = $("#CardInventoryList")
const AnothersPanels = $("#AnothersPanels")
const AbyssButton = $("#AbyssButton")
const AbyssButtonIcon = $("#AbyssButtonIcon")
const AbyssCooldownPanel = $("#AbyssCooldownPanel")
const AbyssCooldownLabel = $("#AbyssCooldownLabel")
const AbyssLevel = $("#AbyssLevel")
const AutoVictoryButton = $("#AutoVictoryButton")
const AutoVictoryButtonIcon = $("#AutoVictoryButtonIcon")
const AutoVictoryTokenCount = $("#AutoVictoryTokenCount")
const CurrencyGoldButton = $("#CurrencyGoldButton")
const CurrencyWoodButton = $("#CurrencyWoodButton")
const CurrencyWeaponButton = $("#CurrencyWeaponButton")
const HeroStats = $("#HeroStats")
const PlayersStatsDamageList = $("#PlayersStatsDamageList")
const PlayersStatsAllList = $("#PlayersStatsAllList")
const ChooseNewHeroButtonStartChallenge = $("#ChooseNewHeroButtonStartChallenge")
const ChooseNewHeroButtonStartChallengeCounter = $("#ChooseNewHeroButtonStartChallengeCounter")
const ChooseNewHeroButtonOpenHeroCards = $("#ChooseNewHeroButtonOpenHeroCards")
const ChooseNewHeroButtonOpenHeroCardsCounter = $("#ChooseNewHeroButtonOpenHeroCardsCounter")
const ChooseNewHeroPanelData = $("#ChooseNewHeroPanelData")
const ChooseNewHeroCardsList = $("#ChooseNewHeroCardsList")
const ChooseNewHeroButtonInfoRefresher = $("#ChooseNewHeroButtonInfoRefresher")
const ChooseNewHeroButtonInfoUpdater = $("#ChooseNewHeroButtonInfoUpdater")
const HeroAvatarImage = $("#HeroAvatarImage")
const GameItemsStoreList= $("#GameItemsStoreList")
const GameItemsStoreButtonChangeDataPriceLabel = $("#GameItemsStoreButtonChangeDataPriceLabel")
const GameItemsStoreButtonChangeDataCooldownLabel = $("#GameItemsStoreButtonChangeDataCooldownLabel")
const RefreshButtonStoreCircleBG = $("#RefreshButtonStoreCircleBG")
const GoldChallengeButton = $("#GoldChallengeButton")
const ExpChallengeButton = $("#ExpChallengeButton")
const KillsChallengeButton = $("#KillsChallengeButton")
const SpawnChallengersPanel = $("#SpawnChallengersPanel")
const GameItemsStorePanel = $("#GameItemsStorePanel")
const SwapAttributesStatsPanel = $("#SwapAttributesStatsPanel")
const SwapAttributesStatsList = $("#SwapAttributesStatsList")
const StartGamePanel = $("#StartGamePanel")
const StartGameDifficultPanel = $("#StartGameDifficultPanel")
const StartGameSelectorList = $("#StartGameSelectorList")
const StartGameControlsList = $("#StartGameControlsList")
const StartGameRestartCloseButton = $("#StartGameRestartCloseButton")
const StartGameInfoPanel = $("#StartGameInfoPanel")
const StartGameInfoTitle = $("#StartGameInfoTitle")
const StartGameInfoContent = $("#StartGameInfoContent")

var CARD_SELECTOR_PENDING_REPLACE_CARD_ID = null
const StartGameLobbyProgressPanel = $("#StartGameLobbyProgressPanel")
const StartGameLobbyProgressList = $("#StartGameLobbyProgressList")
const CurrentTimeLabel = $("#CurrentTimeLabel")
const GameTimerPanel = CurrentTimeLabel ? CurrentTimeLabel.GetParent() : null
const ServicesRewardPopup = $("#ServicesRewardPopup")
const ServicesRewardPopupTitle = $("#ServicesRewardPopupTitle")
const ServicesRewardPopupItems = $("#ServicesRewardPopupItems")

// vars
var local_player_id = Game.GetLocalPlayerID()
var save_level_table_exp = {}
var UPDATE_PLAYER_ABILITIES = true
var UPDATE_PLAYER_ITEMS = true
var DEFAULT_HUD_DISABLE = true
var LEVEL_UPGRADES_QUEUE = 0
var AnotherPanelsList = {}
var SAVED_ALL_DAMAGE_PLAYERS = {}
var CHALLENGER_STATE = {}
var ABYSS_STATE = {}
var CHALLENGER_BUTTONS = {}
var POST_STAGE_TRIALS_DISABLED = false
var POST_STAGE_DUMMY_TIMER_ACTIVE = false
var POST_STAGE_DUMMY_TIMER_TOKEN = 0
var POST_STAGE_DUMMY_TIMER_ENDS_AT = -1
var POST_STAGE_DUMMY_COUNTDOWN_ACTIVE = false
var POST_STAGE_DUMMY_COUNTDOWN_TOKEN = 0
var POST_STAGE_DUMMY_COUNTDOWN_ENDS_AT = -1
var POST_STAGE_DUMMY_COUNTDOWN_LAST_NUMBER = -1
var POST_STAGE_LAST_BASE_TIMER_TEXT = "00:00"
var AGHANIM_REWARD_STATE = { items: [], selected: {}, selection_mode: false, max_select: 3 }
var AGHANIM_CONTINUE_TOKEN = 0
var AGHANIM_CONTINUE_ENDS_AT = -1
var AGHANIM_CONTINUE_TIMER_TOKEN = 0
var AGHANIM_CONTINUE_STATE = { participant_player_ids: [], responses: {}, local_choice_locked: false }
var MATCH_RESULT_STATE = { players: [] }
var MATCH_RESULT_RENDERED = false
var LEADERBOARD_STATE = { loading: false, leaderboard: [], self: null }
var START_GAME_RESTART_MODE = false
var START_GAME_AFK_EXIT_MODE = false
var START_GAME_PICKER_PLAYER_ID = -1
var START_GAME_MUSIC_HANDLE = -1
var m_BuffPanels = [];
var SERVICES_REWARD_POPUP_QUEUE = []
var AFK_MODE_ACTIVE = false
const NEUTRAL_ROSHAN_BONUS_ICONS = {
    neutral_roshan_attack_speed_cdr:                "file://{images}/game_hud/roshan/1.png",
    neutral_roshan_consume_card:                    "file://{images}/game_hud/roshan/2.png",
    neutral_roshan_summon_warriors:                 "file://{images}/game_hud/roshan/3.png",
    neutral_roshan_mana_regen_guard:                "file://{images}/game_hud/roshan/4.png",
    neutral_roshan_monster_kill_attributes:         "file://{images}/game_hud/roshan/5.png",
    neutral_roshan_horns:                           "file://{images}/game_hud/roshan/6.png",
    neutral_roshan_all_attributes_pct:              "file://{images}/game_hud/roshan/7.png",
    neutral_roshan_reward_xp_after_kill:            "file://{images}/game_hud/roshan/8.png",
    neutral_roshan_reward_gold_after_kill:          "file://{images}/game_hud/roshan/9.png",
    neutral_roshan_reward_wood_after_kill:          "file://{images}/game_hud/roshan/10.png",
    neutral_roshan_reward_kills_after_kill:         "file://{images}/game_hud/roshan/11.png",
    neutral_roshan_reward_attributes_after_kill:    "file://{images}/game_hud/roshan/12.png",
    neutral_roshan_reward_all_after_kill:           "file://{images}/game_hud/roshan/13.png",
    neutral_roshan_change_artefact:                 "file://{images}/game_hud/roshan/14.png",
}
var hidden_dota_panels = 
[
    "minimap_container",
    "ToggleScoreboardButton",
    "stackable_side_panels",
    "KillCam",
    "MenuButtons",
]
var another_panels_names =
[
    ["SettingsWindow", "keybind_panel/keybind_panel.xml"],
    ["detail_hero_stats", "detail_hero_stats/detail_hero_stats.xml"],
    ["PlayerProfile", "profile/profile.xml"],
    ["PlayerInventory", "inventory/inventory.xml"],
    ["StoreWindow", "store/store.xml"],
    ["ChestsWindow", "chests/chests.xml"],
    ["PromoWindow", "promo/promo.xml"],
    ["PassWindow", "pass/pass.xml"],
]
var POST_STAGE_ACTIVITY_STATE = {}
var POST_STAGE_SELECTED_ACTIVITY = "DUMMY"

const POST_STAGE_ACTIVITY_UI = {
    DUMMY: {
        id: "DUMMY",
        title: "#post_stage_activity_dummy",
        description: "#post_stage_activity_dummy_description",
        option_icon_class: "DummyIcon",
        preview: "file://{images}/dungeon/1.png",
        rewards: 
        [
            { icon: "file://{images}/game_hud/chest/icon2.png", text: "#chest_sky", count: 1 },
        ],
    },
    AGHANIM: {
        id: "AGHANIM",
        title: "#post_stage_activity_aghanim",
        description: "#post_stage_activity_aghanim_description",
        option_icon_class: "AghanimIcon",
        preview: "file://{images}/dungeon/2.png",
        rewards:
        [
            { icon: "file://{images}/game_hud/services/chest_armor.png", text: "#post_stage_activity_reward_aghanim_equipment" },
        ],
    },
    BOSS_RUSH: {
        id: "BOSS_RUSH",
        title: "#post_stage_activity_boss_rush",
        description: "#post_stage_activity_boss_rush_description",
        option_icon_class: "BossRushIcon",
        preview: "file://{images}/dungeon/3.png",
        rewards:
        [
            { icon: "file://{images}/game_hud/chest/icon7.png", text: "#chest_companion", count: 1 },
        ],
    },
}

const POST_STAGE_ACTIVITY_OPTION_PANEL_IDS = {
    DUMMY: "PostStageDummyOption",
    AGHANIM: "PostStageAghanimOption",
    BOSS_RUSH: "PostStageBossRushOption",
}

const POST_STAGE_ACTIVITY_ORDER = ["DUMMY", "AGHANIM", "BOSS_RUSH"]

function IsPostStageTrialsDisabled()
{
    return POST_STAGE_TRIALS_DISABLED === true
}

function SetPostStageTrialsDisabled(disabled)
{
    POST_STAGE_TRIALS_DISABLED = disabled === true
    ApplyPostStageTrialsDisabledState()
}

function ApplyPostStageTrialsDisabledState()
{
    if (AbyssButton)
    {
        AbyssButton.SetHasClass("IsPostStageDisabled", IsPostStageTrialsDisabled())
    }

    for (let challenger_id of Object.keys(CHALLENGER_BUTTONS))
    {
        const panelData = CHALLENGER_BUTTONS[challenger_id]
        if (panelData && panelData.button)
        {
            panelData.button.SetHasClass("IsPostStageDisabled", IsPostStageTrialsDisabled())
        }
    }

    if (AbilitiesList)
    {
        const artefactTrialAbility = AbilitiesList.FindChildTraverse("AbilitySlot2")
        if (artefactTrialAbility)
        {
            artefactTrialAbility.SetHasClass("IsPostStageDisabled", IsPostStageTrialsDisabled())
        }
    }

    ApplyNeutralRoshanPostStageDisabledState()
}

function FormatNeutralRoshanBonusProgress(meritCurrent)
{
    return $.Localize("#neutral_roshan_bonus_panel_progress") + " " + Math.floor(Number(meritCurrent || 0)) + "/2000"
}

function UpdateNeutralRoshanBonusProgress(meritCurrent)
{
    if (NeutralRoshanBonusProgress)
    {
        NeutralRoshanBonusProgress.text = FormatNeutralRoshanBonusProgress(meritCurrent)
    }
}

function UpdateNeutralRoshanBonusOptionDisabledStates(meritCurrent)
{
    if (!NeutralRoshanBonusList) return

    const postStageDisabled = IsPostStageTrialsDisabled()
    const progressDisabled = Math.floor(Number(meritCurrent || 0)) < 2000
    for (const optionPanel of NeutralRoshanBonusList.Children())
    {
        const isProgressOption = optionPanel._neutralRoshanNeedsProgress === true
        const baseDisabled = optionPanel._neutralRoshanBaseDisabled === true
        optionPanel._neutralRoshanProgressDisabled = isProgressOption && progressDisabled
        optionPanel.SetHasClass("DisabledBonus", postStageDisabled || baseDisabled || optionPanel._neutralRoshanProgressDisabled)
    }
}

function OnNeutralRoshanStateChanged(tableName, key, data)
{
    if (String(key) !== String(Game.GetLocalPlayerID())) return
    if (!NeutralRoshanBonusPanel || !NeutralRoshanBonusPanel.BHasClass("OpenNeutralRoshanBonusPanel")) return

    const meritCurrent = data && data.merit_current || 0
    UpdateNeutralRoshanBonusProgress(meritCurrent)
    UpdateNeutralRoshanBonusOptionDisabledStates(meritCurrent)
}

if (Game.SubscribeCustomTableListener)
{
    Game.SubscribeCustomTableListener("neutral_roshan_state", OnNeutralRoshanStateChanged)
    Game.SubscribeCustomTableListener("player_cards_data", function()
    {
        if (typeof ApplyCardStashCapacity === "function") { ApplyCardStashCapacity() }
    })
}

function ShowNeutralRoshanBonusTooltip(panel, option)
{
    if (!panel || !option) return

    const params = typeof buildTooltipParams === "function" ? buildTooltipParams({
        title_key: option.title_key || "",
        description_key: option.description_key || "",
        requirement_key: option.requirement_key || "",
    }) : ""

    $.DispatchEvent(
        "UIShowCustomLayoutParametersTooltip", panel, "neutral_roshan_bonus_custom",
        "file://{resources}/layout/custom_game/tooltips/neutral_roshan_bonus_tooltip/neutral_roshan_bonus_tooltip.xml",
        params
    )
}

function HideNeutralRoshanBonusTooltip(panel)
{
    if (!panel) return
    $.DispatchEvent("UIHideCustomLayoutTooltip", panel, "neutral_roshan_bonus_custom")
}
function ApplyNeutralRoshanPostStageDisabledState()
{
    const disabled = IsPostStageTrialsDisabled()

    if (NeutralRoshanBonusPanel)
    {
        NeutralRoshanBonusPanel.SetHasClass("IsPostStageDisabled", disabled)
    }

    if (NeutralRoshanBonusList)
    {
        for (const optionPanel of NeutralRoshanBonusList.Children())
        {
            optionPanel.SetHasClass("DisabledBonus", disabled || optionPanel._neutralRoshanBaseDisabled === true || (optionPanel._neutralRoshanNeedsProgress === true && optionPanel._neutralRoshanProgressDisabled === true))
        }
    }

    if (ArtefactSelectorPanel)
    {
        ArtefactSelectorPanel.SetHasClass("IsPostStageDisabled", false)
    }

    if (ArtefactSelectorList)
    {
        for (const optionPanel of ArtefactSelectorList.Children())
        {
            optionPanel.SetHasClass("DisabledBonus", false)
        }
    }

    if (ArtefactSelectorRerollButton)
    {
        ArtefactSelectorRerollButton.SetHasClass("DisabledBonus", ArtefactSelectorRerollButton._neutralRoshanBaseDisabled === true)
    }
}

function FormatHudCardValue(value)
{
    const formatted_value = FormatPrecisionValue(value)
    const numeric_value = Number(value)
    if (!Number.isFinite(numeric_value))
    {
        return formatted_value
    }

    return numeric_value > 0 ? "+" + formatted_value : formatted_value
}

const CARD_RARITY_CLASSES = [
    "CardRarityCommon",
    "CardRarityRare",
    "CardRarityEpic",
    "CardRarityLegendary",
    "CardRarityMythical",
    "CardRaritySSS",
]

function GetAllCardBundlesData()
{
    return Game.GetCustomTable("game_data", "card_bundles_data") || {}
}

function GetCardBundleData(card_data)
{
    if (!card_data || !card_data.bundle_name)
    {
        return null
    }
    return GetAllCardBundlesData()[card_data.bundle_name] || null
}

function NormalizeCardRarityName(rarity)
{
    switch (String(rarity || "").toLowerCase())
    {
        case "rare":
        case "epic":
        case "legendary":
        case "mythical":
        case "sss":
            return String(rarity).toLowerCase()
        default:
            return "common"
    }
}

function GetCardRarity(card_data, bundle_data)
{
    return NormalizeCardRarityName((card_data && card_data.rarity) || (bundle_data && bundle_data.rarity))
}

function GetCardRarityClassName(rarity)
{
    switch (NormalizeCardRarityName(rarity))
    {
        case "rare":
            return "CardRarityRare"
        case "epic":
            return "CardRarityEpic"
        case "legendary":
            return "CardRarityLegendary"
        case "mythical":
            return "CardRarityMythical"
        case "sss":
            return "CardRaritySSS"
        default:
            return "CardRarityCommon"
    }
}

function ClearCardRarityClasses(panel)
{
    if (!panel)
    {
        return
    }

    for (let class_name of CARD_RARITY_CLASSES)
    {
        panel.RemoveClass(class_name)
    }
}

function ApplyCardRarityClass(panel, rarity)
{
    if (!panel)
    {
        return
    }

    ClearCardRarityClasses(panel)
    panel.AddClass(GetCardRarityClassName(rarity))
}

var TUTORIAL_CURRENT_TARGET_PANEL = null
var TUTORIAL_POSITION_TOKEN = 0
var TUTORIAL_ACTIVE_PAYLOAD = null

const TUTORIAL_TARGET_PANEL_IDS = {
    ability_select_card: ["AbilityData_levelup_select_card", "AbilitySlot0"],
    abyss_button: ["AbyssButton"],
    ability_upgrade_stats: ["AbilityData_levelup_upgrade_stats", "AbilitySlot1"],
    challengers_panel: ["SpawnChallengersPanel"],
    card_inventory: ["PanelInventoryCard", "CardInventoryList"],
    card_selector: ["CardSelectorPanel", "CardSelectorList"],
    ability_upgrade_artifacts: ["AbilityData_levelup_upgrade_artifacts", "AbilitySlot2"],
    post_stage_activity: ["PostStageActivityPanel", "PostStageActivityBody"],
    post_stage_restart: ["PostStageRestartConfirmPanel", "StartGamePanel"],
    top_left_settings: ["TopLeftSettingsButton", "TopLeftButtonsList"],
}

const TUTORIAL_TARGET_PLACEMENTS = {
    card_selector: "above",
}

function TutorialLocalizeKey(key)
{
    key = String(key || "")
    return key.charAt(0) == "#" ? key : "#" + key
}

function TutorialFindPanelById(panelId)
{
    if (!panelId)
    {
        return null
    }

    let panel = $("#" + panelId)
    if (!panel)
    {
        panel = $.GetContextPanel().FindChildTraverse(panelId)
    }

    if (panel && panel.IsValid && panel.IsValid())
    {
        return panel
    }

    return null
}

function TutorialResolveTarget(target)
{
    const ids = TUTORIAL_TARGET_PANEL_IDS[String(target || "")] || []
    for (let id of ids)
    {
        const panel = TutorialFindPanelById(id)
        if (panel)
        {
            return panel
        }
    }
    return null
}

function TutorialClearTarget()
{
    if (TUTORIAL_CURRENT_TARGET_PANEL && TUTORIAL_CURRENT_TARGET_PANEL.IsValid && TUTORIAL_CURRENT_TARGET_PANEL.IsValid())
    {
        TUTORIAL_CURRENT_TARGET_PANEL.RemoveClass("TutorialTargetActive")
    }
    TUTORIAL_CURRENT_TARGET_PANEL = null
}

function HideLevelupTutorial()
{
    TUTORIAL_ACTIVE_PAYLOAD = null
    TUTORIAL_POSITION_TOKEN += 1
    TutorialClearTarget()

    if (TutorialOverlayRoot)
    {
        TutorialOverlayRoot.SetHasClass("TutorialOverlayVisible", false)
    }
    if (TutorialHintPanel)
    {
        TutorialHintPanel.SetHasClass("TutorialHintVisible", false)
    }
    if (TutorialTargetFrame)
    {
        TutorialTargetFrame.SetHasClass("TutorialTargetFrameVisible", false)
    }
}

function ClampTutorialValue(value, min, max)
{
    return Math.max(min, Math.min(max, value))
}

function IsTutorialFiniteNumber(value)
{
    return typeof value === "number" && isFinite(value)
}

function PositionLevelupTutorialFallback(token, screenWidth, screenHeight, scale)
{
    if (TutorialTargetFrame)
    {
        TutorialTargetFrame.SetHasClass("TutorialTargetFrameVisible", false)
    }

    const hintWidth = Math.min(440, Math.max(320, screenWidth - 48))
    TutorialHintPanel.style.width = hintWidth + "px"

    const hintHeight = Math.max(118, (Number(TutorialHintPanel.actuallayoutheight) || 138) / scale)
    TutorialHintPanel.style.x = ClampTutorialValue((screenWidth - hintWidth) / 2, 24, Math.max(24, screenWidth - hintWidth - 24)) + "px"
    TutorialHintPanel.style.y = ClampTutorialValue(screenHeight * 0.62, 120, Math.max(120, screenHeight - hintHeight - 24)) + "px"

    $.Schedule(0.1, function() { PositionLevelupTutorial(token) })
}

function PositionLevelupTutorial(token)
{
    if (token !== TUTORIAL_POSITION_TOKEN || !TUTORIAL_ACTIVE_PAYLOAD || !TutorialHintPanel)
    {
        return
    }

    const scale = Math.max(0.01, Game.GetScreenHeight() / 1080)
    const screenWidth = Game.GetScreenWidth() / scale
    const screenHeight = Game.GetScreenHeight() / scale
    const target = TutorialResolveTarget(TUTORIAL_ACTIVE_PAYLOAD.target)

    TutorialClearTarget()

    if (!target)
    {
        PositionLevelupTutorialFallback(token, screenWidth, screenHeight, scale)
        return
    }

    const targetPos = target.GetPositionWithinWindow()
    const targetX = targetPos.x / scale
    const targetY = targetPos.y / scale
    const targetWidth = Math.max(36, (Number(target.actuallayoutwidth) || 36) / scale)
    const targetHeight = Math.max(36, (Number(target.actuallayoutheight) || 36) / scale)
    const hasValidTargetRect = IsTutorialFiniteNumber(targetX)
        && IsTutorialFiniteNumber(targetY)
        && IsTutorialFiniteNumber(targetWidth)
        && IsTutorialFiniteNumber(targetHeight)
        && Math.abs(targetX) < screenWidth * 4
        && Math.abs(targetY) < screenHeight * 4
        && targetWidth > 0
        && targetHeight > 0

    if (!hasValidTargetRect)
    {
        PositionLevelupTutorialFallback(token, screenWidth, screenHeight, scale)
        return
    }

    TUTORIAL_CURRENT_TARGET_PANEL = target
    target.AddClass("TutorialTargetActive")

    if (TutorialTargetFrame)
    {
        TutorialTargetFrame.style.x = (targetX - 9) + "px"
        TutorialTargetFrame.style.y = (targetY - 9) + "px"
        TutorialTargetFrame.style.width = (targetWidth + 18) + "px"
        TutorialTargetFrame.style.height = (targetHeight + 18) + "px"
        TutorialTargetFrame.SetHasClass("TutorialTargetFrameVisible", true)
    }

    const hintWidth = Math.min(440, Math.max(320, screenWidth - 48))
    TutorialHintPanel.style.width = hintWidth + "px"

    const placement = TUTORIAL_TARGET_PLACEMENTS[String(TUTORIAL_ACTIVE_PAYLOAD.target || "")] || "auto"
    const hintHeight = Math.max(118, (Number(TutorialHintPanel.actuallayoutheight) || 138) / scale)
    let hintX = targetX + targetWidth * 0.5 - hintWidth * 0.5
    let hintY = targetY + targetHeight + 18
    if (placement === "above" || targetY > screenHeight * 0.55)
    {
        hintY = targetY - hintHeight - 14
    }

    hintX = ClampTutorialValue(hintX, 24, Math.max(24, screenWidth - hintWidth - 24))
    hintY = ClampTutorialValue(hintY, 80, Math.max(80, screenHeight - hintHeight - 24))

    TutorialHintPanel.style.x = hintX + "px"
    TutorialHintPanel.style.y = hintY + "px"

    $.Schedule(0.1, function() { PositionLevelupTutorial(token) })
}

function ShowLevelupTutorial(data)
{
    if (!data || Number(data.active || 0) !== 1)
    {
        HideLevelupTutorial()
        return
    }

    TUTORIAL_ACTIVE_PAYLOAD = data
    TUTORIAL_POSITION_TOKEN += 1

    if (TutorialHintTitle)
    {
        TutorialHintTitle.text = $.Localize(TutorialLocalizeKey(data.title_key || "levelup_tutorial_title"))
    }
    if (TutorialHintText)
    {
        TutorialHintText.text = $.Localize(TutorialLocalizeKey(data.text_key || "levelup_tutorial_title"))
    }
    if (TutorialHintReward)
    {
        const rewardWood = Math.max(0, Math.floor(Number(data.reward_wood || 0)))
        TutorialHintReward.visible = rewardWood > 0
        TutorialHintReward.SetDialogVariable("value", String(rewardWood))
        TutorialHintReward.text = $.Localize("#levelup_tutorial_reward_wood", TutorialHintReward)
    }

    if (TutorialOverlayRoot)
    {
        TutorialOverlayRoot.SetHasClass("TutorialOverlayVisible", true)
    }
    if (TutorialHintPanel)
    {
        TutorialHintPanel.SetHasClass("TutorialHintVisible", true)
    }

    PositionLevelupTutorial(TUTORIAL_POSITION_TOKEN)
}

Game.OpenSettingsFromTopButton = function()
{
    GameEvents.SendCustomGameEventToServer("event_tutorial_settings_opened", {})
    Game.SwitchAnothersPanel("SettingsWindow")
}

function Init()
{
    // Скрытие дотовских панелей
    for (dota_panel_name of hidden_dota_panels)
    {
        let dota_panel = FindDotaHudElement(dota_panel_name)
        if (dota_panel)
        {
            dota_panel.visible = false
        }
    }
    // Запомнить что эта кнопка отвечает за бинд башни
    SAVE_HOTKEYS_LABELS["ability7"] = $("#abyss_label_keybind")
    // Установка базовых тултипов
    SetCustomTooltip(AbyssButtonIcon, "wood_challenge", {})
    SetCustomTooltip(CurrencyGoldButton, "currency_tooltip", {header : "levelup_game_gold", description : "levelup_game_gold_description", description_2 : "levelup_game_gold_description_2"})
    SetCustomTooltip(CurrencyWoodButton, "currency_tooltip", {header : "levelup_game_tree", description : "levelup_game_tree_description", description_2 : "levelup_game_tree_description_2"})
    SetCustomTooltip(CurrencyWeaponButton, "currency_tooltip", {header : "levelup_game_kill", description : "levelup_game_kill_description", description_2 : "levelup_game_kill_description_2"})
    SetCustomTooltip(HeroStats, "stats_tooltip", {})
    SetCustomTooltip(GoldChallengeButton, "challenge_tooltip", {header : "levelup_challenge_gold", description : "levelup_challenge_gold_description", image : "", description_2 : "levelup_challenge_gold_description_2", challenger_id : "gold_trial"})
    SetCustomTooltip(ExpChallengeButton, "challenge_tooltip", {header : "levelup_challenge_exp", description : "levelup_challenge_exp_description", image : "2", description_2 : "levelup_challenge_exp_description_2", challenger_id : "exp_trial"})
    SetCustomTooltip(KillsChallengeButton, "challenge_tooltip", {header : "levelup_challenge_kill", description : "levelup_challenge_kill_description", image : "3", description_2 : "levelup_challenge_kill_description_2", challenger_id : "kills_trial"})
    
    // Создание слотов предметов
    CreatePlayerItemsList()
    // Обновление худа
    PlayerHeroThink()
    // Создание статов игроков
    CreatePlayersStats()
    // Обновление кнопки башни
    InitAbyssButton()
    InitAutoVictoryButton()
    // Обновление кнопки челенджей
    InitChallengerButtons()
    // Создание панелей вне игрового худа
    AnothersPanels.RemoveAndDeleteChildren()

    for (let panel_data of another_panels_names)
    {
        AnotherPanelsList[panel_data[0]] = $.CreatePanel("Panel", AnothersPanels, panel_data[0]);
        AnotherPanelsList[panel_data[0]].BLoadLayout("file://{resources}/layout/custom_game/" + panel_data[1], false, false);
    }
    
    RegisterNeutralRoshanMouseHandler()
    InitPostStageActivityPanels()

    InitGameStart()

    GameEvents.SendCustomGameEventToServer( "event_reconnect_player_restore", {});
}

// Обновление способностей игрока
function UpdatePlayerAbilitiesList()
{
    const local_hero = GetPlayerHero()
    const hiddenAbilityNames = {
        custom_twin_gate_portal_warp: true,
    }
    if (AbilitiesList)
    {
        AbilitiesList.RemoveAndDeleteChildren()
        for (let i = 0; i <= 24; i++)
        {
            let ability_handle = Entities.GetAbility(local_hero, i)
            let ability_name = ability_handle && ability_handle != -1 ? Abilities.GetAbilityName(ability_handle) : ""
            if (ability_handle && ability_handle != -1 && !hiddenAbilityNames[ability_name] && !Abilities.IsHidden(ability_handle) && Abilities.IsDisplayedAbility(ability_handle))
            {
                let behavior = Abilities.GetBehavior(ability_handle)
                if (!FlagExistsBig(behavior, 8796093022208)) 
                {  
                    CreateAbilitySlot(ability_handle, i)
                }
            }
        }
        CreateCardButton()
        ApplyPostStageTrialsDisabledState()
    }
}

// Создание слота способности
function CreateAbilitySlot(ability_handle, ability_id)
{
    let ability_name = Abilities.GetAbilityName(ability_handle)

    let AbilityContainer = $.CreatePanel("Panel", AbilitiesList, "AbilitySlot"+ability_id)
    AbilityContainer.AddClass("AbilityContainer")
    
    let AbilityData = $.CreatePanel("Panel", AbilityContainer, "AbilityData_"+ability_name)
    AbilityData.AddClass("AbilityData")
    
    let AbilityIconContainer = $.CreatePanel("Panel", AbilityData, "")
    AbilityIconContainer.AddClass("AbilityIconContainer")
    
    let AbilityImage = $.CreatePanel("Image", AbilityIconContainer, "AbilityImage")
    AbilityImage.AddClass("AbilityImage")
    
    if (BASE_ABILITIES_DATA[ability_name])
    {
        AbilityImage.SetImage("file://{images}/abilities/"+BASE_ABILITIES_DATA[ability_name].icon+".png")
    }

    SetCustomTooltip(AbilityImage, "ability_tooltip", {ability_name : ability_name})
    SetPanelAbilityClick(AbilityImage, ability_id)

    let AbilityCooldownPanel = $.CreatePanel("Panel", AbilityImage, "")
    AbilityCooldownPanel.AddClass("AbilityCooldownPanel")
    AbilityContainer.AbilityCooldownPanel = AbilityCooldownPanel

    let AbilityCooldownLabel = $.CreatePanel("Label", AbilityImage, "AbilityCooldownLabel")
    AbilityCooldownLabel.AddClass("AbilityCooldownLabel")
    AbilityCooldownLabel.text = "0"
    AbilityContainer.AbilityCooldownLabel = AbilityCooldownLabel
    
    let AbilityBG = $.CreatePanel("Panel", AbilityIconContainer, "")
    AbilityBG.AddClass("AbilityBG")
    AbilityBG.hittest = false
    AbilityContainer.AbilityBG = AbilityBG

    let CostContainer = $.CreatePanel("Panel", AbilityData, "")
    CostContainer.AddClass("CostContainer")
    
    let CostAbilityIcon = $.CreatePanel("Panel", CostContainer, "CostAbilityIcon")
    CostAbilityIcon.AddClass("CostAbilityIcon")
    
    let CostAbilityLabel = $.CreatePanel("Label", CostContainer, "CostAbilityLabel")
    CostAbilityLabel.AddClass("CostAbilityLabel")
    
    let AbilityHotkey = $.CreatePanel("Panel", AbilityContainer, "")
    AbilityHotkey.AddClass("AbilityHotkey")
    
    let AbilityHotkeyLabel = $.CreatePanel("Label", AbilityHotkey, "AbilityHotkeyLabel")
    AbilityHotkeyLabel.text = GetLevelUpKeyBind("ability", Number(ability_id)+1)
    SAVE_HOTKEYS_LABELS["ability" + (Number(ability_id)+1)] = AbilityHotkeyLabel

    if (ability_id == 0)
    {
        CostContainer.style.opacity = "1"
        CostAbilityIcon.AddClass("IconWood")
        CostAbilityLabel.text = String(GetCurrentAbilityCost("levelup_select_card"))

        $.CreatePanel("DOTAParticleScenePanel", AbilityContainer, "", 
        { 
            style: "width:64px;height:64px;margin-top: 8px;",
            class: "ParticleAbilityFx",
            particleName: "particles/custom_hud/spell_level_max.vpcf", 
            particleonly:"true", 
            startActive:"true", 
            cameraOrigin:"0 0 150", 
            lookAt:"0 0 0",  
            fov:"64", 
            squarePixels:"true",
            hittest: "false"
        });
    }

    if (ability_id == 1)
    {
        CostAbilityIcon.AddClass("IconGold")
        CostAbilityLabel.text = String(GetCurrentAbilityCost("levelup_upgrade_stats"))
        let cost_counter = Number(GetCurrentAbilityCost("levelup_upgrade_stats"))
        if (CostContainer)
        {
            CostContainer.style.opacity = cost_counter > 0 ? 1 : 0
        }
        UpdateArtefactData()

        $.CreatePanel("DOTAParticleScenePanel", AbilityContainer, "", 
        { 
            style: "width:64px;height:64px;margin-top: 8px;",
            class: "ParticleAbilityFx",
            particleName: "particles/custom_hud/spell_level_max.vpcf", 
            particleonly:"true", 
            startActive:"true", 
            cameraOrigin:"0 0 150", 
            lookAt:"0 0 0",  
            fov:"64", 
            squarePixels:"true",
            hittest: "false"
        });
    }

    if (ability_id == 2)
    {
        UpdateArtefactData()

        $.CreatePanel("DOTAParticleScenePanel", AbilityContainer, "",
        {
            style: "width:64px;height:64px;margin-top: 8px;",
            class: "ParticleAbilityFx",
            particleName: "particles/custom_hud/spell_level_max.vpcf",
            particleonly:"true",
            startActive:"true",
            cameraOrigin:"0 0 150",
            lookAt:"0 0 0",
            fov:"64",
            squarePixels:"true",
            hittest: "false"
        });
    }

    if (ability_id == 5)
    {
        UpdateUltimateData()
        AbilityBG.AddClass("AbilityBGGold")
    }

    SetAbilityThinker(AbilityContainer, ability_handle, ability_name)
}

// Обновление способности постоянный
function GetCurrentAbilityCost(ability_name)
{
    let playerId = String(Game.GetLocalPlayerID())
    let abilities_cost = Game.GetCustomTable("abilities_cost", playerId) || {}
    return Math.floor(Number(abilities_cost?.[ability_name]?.[1] ?? 0))
}

function UpdateAbilityCostLabel(AbilityContainer, ability_name)
{
    if (!AbilityContainer || !AbilityContainer.IsValid || !AbilityContainer.IsValid())
    {
        return
    }

    let CostAbilityLabel = AbilityContainer.FindChildTraverse("CostAbilityLabel")
    if (!CostAbilityLabel)
    {
        return
    }

    if (ability_name === "levelup_select_card")
    {
        CostAbilityLabel.text = String(GetCurrentAbilityCost("levelup_select_card"))
    }
    else if (ability_name === "levelup_upgrade_stats")
    {
        CostAbilityLabel.text = String(GetCurrentAbilityCost("levelup_upgrade_stats"))
    }
}

function SetAbilityThinker(AbilityContainer, ability_handle, ability_name)
{
    if (AbilityContainer == null || !AbilityContainer.IsValid())
    {
        return
    }
    UpdateAbilityCostLabel(AbilityContainer, ability_name)
    const AbilityCooldownPanel = AbilityContainer.AbilityCooldownPanel
    const AbilityCooldownLabel = AbilityContainer.AbilityCooldownLabel
    if (!Abilities.IsCooldownReady(ability_handle)) 
    {
        if (AbilityContainer.maxCooldown == null) 
        {
            AbilityContainer.maxCooldown = Abilities.GetCooldownLength(ability_handle);
        }
        const remaining = Abilities.GetCooldownTimeRemaining(ability_handle);
        const progress = (remaining / AbilityContainer.maxCooldown) * -360;
        AbilityCooldownPanel.visible = true;
        if (!isNaN(progress))
        {
            AbilityCooldownPanel.style.clip = "radial( 50% 50%, 0deg, " + progress + "deg )";
        }
        AbilityCooldownLabel.text = Math.ceil(remaining);
        AbilityCooldownLabel.visible = true;
    } 
    else 
    {
        AbilityContainer.maxCooldown = null;
        AbilityCooldownLabel.visible = false;
        AbilityCooldownPanel.visible = false;
    }

    let playerId = String(Game.GetLocalPlayerID());
    let currency_data = Game.GetCustomTable("currency_data", playerId) || {};
    let abilities_cost = Game.GetCustomTable("abilities_cost", playerId) || {};
    let hasEnough = false;
    if (ability_name === "levelup_select_card")
    {
        let cost = abilities_cost?.levelup_select_card?.[1] ?? 0;
        let wood = currency_data?.wood ?? 0;
        hasEnough = !IsPostStageTrialsDisabled() > 0 && wood >= cost && Abilities.IsActivated(ability_handle);
    }
    else if (ability_name === "levelup_upgrade_stats")
    {
        let cost = abilities_cost?.levelup_upgrade_stats?.[1] ?? 0;
        let gold = currency_data?.gold ?? 0;
        hasEnough = !IsPostStageTrialsDisabled() > 0 && gold >= cost && Abilities.IsActivated(ability_handle);
    }
    else if (ability_name === "levelup_upgrade_artifacts")
    {
        let artefact_data = Game.GetCustomTable("artefact_state", playerId) || {};
        let has_active_trial = Boolean(artefact_data?.main_artefact_has_active_trial);
        hasEnough = !IsPostStageTrialsDisabled() > 0 && !has_active_trial && Abilities.IsActivated(ability_handle) && Abilities.IsCooldownReady(ability_handle);
        AbilityContainer.SetHasClass("IsPostStageDisabled", IsPostStageTrialsDisabled());
    }

    AbilityContainer.SetHasClass("ActiveAbilityFx", hasEnough);
    
    $.Schedule(0.1, () => SetAbilityThinker(AbilityContainer, ability_handle, ability_name));
}

function UpdateUltimateData(data)
{
    if (!data)
    {
        data = Game.GetCustomTable("ultimate_state", String(Game.GetLocalPlayerID()));
    }
    let AbilityContainer = AbilitiesList.FindChildTraverse("AbilitySlot5")
    if (AbilityContainer)
    {
        let AbilityImage = AbilityContainer.FindChildTraverse("AbilityImage")
        if (AbilityImage)
        {
            AbilityImage.SetImage("file://{images}/spellicons/"+data.icon+".png")
            SetCustomTooltip(AbilityImage, "ability_tooltip", {ability_name : data.ultimate_id})
        }
    }
}

function UpdateArtefactData(data)
{
    if (!data)
    {
        data = Game.GetCustomTable("artefact_state", String(Game.GetLocalPlayerID()));
    }
    if (!data)
    {
        return
    }
    let artefact_icon_level = Math.max(0, Math.min(6, Math.floor(Number(data?.passive_artefact_step || 0) / 6)))
    let currentArtefactIcon = data?.current_icon_path || ("file://{images}/abilities/" + String(data.current_passive_artefact || "firework_splitshot") + "_" + artefact_icon_level + ".png")
    let AbilityContainer = AbilitiesList.FindChildTraverse("AbilitySlot1")
    if (AbilityContainer)
    {
        let AbilityImage = AbilityContainer.FindChildTraverse("AbilityImage")
        if (AbilityImage)
        {
            AbilityImage.SetImage(currentArtefactIcon)
        }
    }
    let AbilityContainer_2 = AbilitiesList.FindChildTraverse("AbilitySlot2")
    if (AbilityContainer_2)
    {
        let AbilityImage = AbilityContainer_2.FindChildTraverse("AbilityImage")
        let AbilityBG = AbilityContainer_2.AbilityBG
        if (AbilityImage)
        {
            AbilityImage.SetImage("file://{images}/abilities/levelup_upgrade_artifacts_"+artefact_icon_level+".png")
        }
        if (AbilityBG)
        {
            AbilityBG.SetHasClass("AbilityBGGold", false)
        }
    }
}

// Панель поглощенных карт
function CreateCardButton()
{
    let CardButtonContainer = $.CreatePanel("Panel", AbilitiesList, "CardButtonContainer")
    CardButtonContainer.AddClass("CardButtonContainer")

    let CardButtonImage = $.CreatePanel("Panel", CardButtonContainer, "")
    CardButtonImage.AddClass("CardButtonImage")
    SetCustomTooltip(CardButtonImage, "consumed_bundles_tooltip", {})
    CardButtonImage.SetPanelEvent("onactivate", function()
    {
        SwitchInventoryCards()
        UnFocusUI()
    })

    let AbilityHotkey = $.CreatePanel("Panel", CardButtonContainer, "")
    AbilityHotkey.AddClass("AbilityHotkey")

    let AbilityHotkeyLabel = $.CreatePanel("Label", AbilityHotkey, "AbilityHotkeyLabel")
    AbilityHotkeyLabel.AddClass("AbilityHotkeyLabel")
    AbilityHotkeyLabel.text = GetLevelUpKeyBind("ability", 5)
    SAVE_HOTKEYS_LABELS["ability5"] = AbilityHotkeyLabel
}

// Первичное создание панелей предметов
function CreatePlayerItemsList()
{
    if (ItemsList1 && ItemsList2)
    {
        ItemsList1.RemoveAndDeleteChildren()
        ItemsList2.RemoveAndDeleteChildren()
        for (let i = 0; i <= 2; i++)
        {
            CreateItemSlot(i, ItemsList1)
        }
        for (let i = 3; i <= 5; i++)
        {
            CreateItemSlot(i, ItemsList2)
        }
    }
}

// Создание слота для предмета
function CreateItemSlot(item_slot, parent)
{
    let ItemPanel = $.CreatePanel("Panel", parent, "ItemPanel"+item_slot)
    ItemPanel.AddClass("ItemPanel")
    ItemPanel.hittestchildren = false
    ItemPanel.item_slot = item_slot
    ItemPanel.current_item = null
    $.RegisterEventHandler( 'DragStart', ItemPanel, OnDragStart );
    $.RegisterEventHandler( 'DragDrop', ItemPanel, OnDragDrop );
    $.RegisterEventHandler( 'DragEnd', ItemPanel, OnDragEnd );
    ItemPanel.SetDraggable(true)
    SetPanelItemClick(ItemPanel, item_slot)

    let ItemData = $.CreatePanel("Panel", ItemPanel, "")
    ItemData.AddClass("ItemData")

    let ItemPanelImage = $.CreatePanel("DOTAItemImage", ItemData, "ItemPanelImage", {scaling:"cover"})
    ItemPanelImage.AddClass("ItemPanelImage")
    ItemPanelImage.itemname = ""

    let ItemBG = $.CreatePanel("Panel", ItemData, "")
    ItemBG.AddClass("ItemBG")

    let ItemChargesLabel = $.CreatePanel("Label", ItemPanel, "ItemChargesLabel")
    ItemChargesLabel.AddClass("ItemChargesLabel")
    ItemChargesLabel.visible = false

    let ItemHotkey = $.CreatePanel("Panel", ItemPanel, "")
    ItemHotkey.AddClass("ItemHotkey")

    let ItemHotkeyLabel = $.CreatePanel("Label", ItemHotkey, "ItemHotkeyLabel")
    ItemHotkeyLabel.AddClass("ItemHotkeyLabel")
    ItemHotkeyLabel.text = GetLevelUpKeyBind("item", Number(item_slot)+1)
    SAVE_HOTKEYS_LABELS["item"+(Number(item_slot)+1)] = ItemHotkeyLabel
}

// Обновление инвентаря предметов
function GetItemCurrentCharges(item_index)
{
    let charges = 0
    if (typeof Abilities !== "undefined" && typeof Abilities.GetCurrentCharges === "function")
    {
        charges = Number(Abilities.GetCurrentCharges(item_index) || 0)
    }
    if (charges <= 0 && typeof Items !== "undefined" && typeof Items.GetCurrentCharges === "function")
    {
        charges = Number(Items.GetCurrentCharges(item_index) || 0)
    }
    return Math.max(0, Math.floor(charges))
}

function UpdatePlayerItemsList()
{
    const local_hero = GetPlayerHero()
    const ItemPanels = ItemsContainer.FindChildrenWithClassTraverse("ItemPanel")
    for (let item_panel of ItemPanels)
    {
        let item_slot = item_panel.item_slot
        let item_index = Entities.GetItemInSlot(local_hero, item_slot)
        let ItemPanelImage = item_panel.FindChildTraverse("ItemPanelImage")
        let ItemChargesLabel = item_panel.FindChildTraverse("ItemChargesLabel")
        if (item_index && item_index != -1)
        {
            SetCustomTooltip(item_panel, "item_tooltip", {item_name : Abilities.GetAbilityName(item_index)})
            ItemPanelImage.itemname = Abilities.GetAbilityName(item_index)
            item_panel.current_item = item_index
            let charges = GetItemCurrentCharges(item_index)
            if (ItemChargesLabel)
            {
                ItemChargesLabel.text = String(charges)
                ItemChargesLabel.visible = charges > 1
            }
        }
        else
        {
            item_panel.ClearPanelEvent("onmouseover")
            ItemPanelImage.itemname = ""
            item_panel.current_item = null
            if (ItemChargesLabel)
            {
                ItemChargesLabel.text = ""
                ItemChargesLabel.visible = false
            }
        }
    }
}

// Каст предмета
function SetPanelItemClick(ItemPanel, item_slot)
{
    ItemPanel.SetPanelEvent("onactivate", function()
    {
        const local_hero = GetPlayerHero()
        let item_index = Entities.GetItemInSlot(local_hero, item_slot)
        if (item_index)
        {
            //Abilities.ExecuteAbility(item_index, local_hero, false)
            Game.ItemClickCast(item_slot)
            UnFocusUI()
        }
    })
}

// Каст способности
function SetPanelAbilityClick(AbilityPanel, ability_index)
{
    AbilityPanel.SetPanelEvent("onactivate", function()
    {
        if (ability_index == 2 && IsPostStageTrialsDisabled())
        {
            return
        }

        Game.AbilityClickCast(ability_index)
        UnFocusUI()
    })
}

// Главный апдейт худа
function PlayerHeroThink()
{
    const local_hero = GetPlayerHero()
    if (local_hero == -1)
    {
        $.Schedule(0.1, PlayerHeroThink)
        return
    }

    let health_data = Game.GetCustomTable("health_data", "health_data")
    if (health_data && health_data[String(local_hero)])
    {
        health_data = health_data[String(local_hero)]
    }
    
    let player_stats = Game.GetCustomTable("player_stats", String(local_player_id)) || {}
    const health_percent = health_data.current_health && health_data.max_health ? Math.floor((health_data.current_health / health_data.max_health * 100)+0.5) : 0
    const health_regen = Number(player_stats.health_regen || 0)
    const health = Math.floor(health_data.current_health || 0)
    const max_health = Math.floor(health_data.max_health || 0)
    const mana = Math.floor(Entities.GetMana(local_hero))
    const mana_regen = Math.floor(Entities.GetManaThinkRegen(local_hero))
    const max_mana = Math.floor(Entities.GetMaxMana(local_hero))
    const mana_percent = (mana / max_mana) * 100
    const player_level = Players.GetLevel(local_player_id)
    let player_current_exp = Entities.GetCurrentXP(local_hero)
    let player_next_exp = Entities.GetNeededXPToLevel(local_hero)
    
    if (!save_level_table_exp[player_level] && player_level > 0)
    {
        save_level_table_exp[player_level] = player_next_exp
    }

    if (save_level_table_exp[player_level-1])
    {
        player_current_exp = player_current_exp - save_level_table_exp[player_level-1]
        player_next_exp = player_next_exp - save_level_table_exp[player_level-1]
    }

    // Health Bar
    if (HealthBarFront && HealthBarLabel && HealthRegen)
    {
        HealthBarFront.style["width"] = `${health_percent}%`
        HealthBarLabel.text = `${health}/${max_health}`
        HealthRegen.text = `${Math.floor(health_regen)}/s`
    }

    // Mana Bar
    if (ManaBarFront && ManaBarLabel && ManaRegen)
    {
        ManaBarFront.style["width"] = `${mana_percent}%`
        ManaBarLabel.text = `${mana}/${max_mana}`
        ManaRegen.text = `${mana_regen}/s`
    }

    // Exp Panel
    if (HeroLevelCircleActive && HeroLevelLabel)
    {
        const exp_clip_radial = player_next_exp > 0 ? (player_current_exp / player_next_exp) * -360 : 0
        if (isFinite(exp_clip_radial))
        {
            HeroLevelCircleActive.style.clip = "radial( 50% 50%, 0deg, " + exp_clip_radial + "deg )";
        }
        HeroLevelLabel.text = `${player_level}`
    }

    if (HeroName)
    {
        let hero_name_player = Game.GetCustomTable("ui_hero_data", String(Game.GetLocalPlayerID()))
        if (hero_name_player && hero_name_player.hero_name)
        {
            HeroName.text = $.Localize("#"+hero_name_player.hero_name)
        }
    }

    if (UPDATE_PLAYER_ABILITIES)
    {
        UPDATE_PLAYER_ABILITIES = false
        UpdatePlayerAbilitiesList()
    }

    if (UPDATE_PLAYER_ITEMS)
    {
        UPDATE_PLAYER_ITEMS = false
        UpdatePlayerItemsList()
    }

    $.Schedule(0.03, PlayerHeroThink)

    UpdateBuffs();
    MinimapUpdater()
}

// Логика переноса предметов в инвентаре
function OnDragStart( panelId, dragCallbacks )
{
    if (panelId.current_item == null || panelId.current_item == -1)
    {
        return false
    }
    var displayPanel = $.CreatePanel( "DOTAItemImage", $.GetContextPanel(), "ItemDragInventory", {scaling:"stretch-to-fit-y-preserve-aspect"});
    displayPanel.AddClass("ItemDragInventory")
    displayPanel.itemname = Abilities.GetAbilityName(panelId.current_item)
    displayPanel.current_item = panelId.current_item
    displayPanel.item_slot = panelId.item_slot;
    displayPanel.old_panel = panelId;
    dragCallbacks.displayPanel = displayPanel;
	dragCallbacks.offsetX = 0;
	dragCallbacks.offsetY = 0;
    $.DispatchEvent('UIHideCustomLayoutTooltip', panelId, "item_tooltip_custom");
	return true;
}

function OnDragDrop(panelId, draggedPanel )
{
    if (panelId && panelId != draggedPanel.old_panel && panelId.item_slot != undefined && panelId.current_item == null)
    {
        if (draggedPanel.current_item != null && draggedPanel.current_item != -1)
        {
            GameEvents.SendCustomGameEventToServer( "event_change_item_slots_custom", {item_index : draggedPanel.current_item, new_slot : panelId.item_slot} );
        }
    }
    draggedPanel.IsSuccess = true
    if (draggedPanel && draggedPanel.IsValid())
    {
        draggedPanel.DeleteAsync( 0 );
    }
	return true;
}

function OnDragEnd(panelId, draggedPanel)
{
    if (!draggedPanel.IsSuccess)
    {
        const local_hero = GetPlayerHero()
        Game.DropItemAtCursor(local_hero, draggedPanel.current_item);
    }
    if (draggedPanel && draggedPanel.IsValid())
    {
        draggedPanel.DeleteAsync( 0 );
    }
	return true;
}

// Статистика игроков
function ChangeStatsWindow(id, id_panel)
{
    for (let child of StatsNavigation.Children())
    {
        child.SetHasClass("StatsNavigateActive", child.id == id)
    }
    if (StatsListParent)
    {
        for (let child of StatsListParent.Children())
        {
            child.visible = child.id == id_panel
        }
    }
}

function CreatePlayersStats()
{
    PlayersStatsEconomyList.RemoveAndDeleteChildren()
    for (let player_id = 0; player_id <= 10; player_id++)
    {
        if (Players.IsValidPlayerID(player_id))
        {
            CreatePlayerForStat(player_id)
        }
    }
}
  
function CreatePlayerForStat(player_id)
{
    let playerInfo = Game.GetPlayerInfo(player_id);
    if (playerInfo)
    {
        let PlayerStatPanel = $.CreatePanel("Panel", PlayersStatsEconomyList, "PlayerStatPanel_"+player_id)
        PlayerStatPanel.AddClass("PlayerStatPanel")
        PlayerStatPanel.player_id = player_id

        let PlayerStatAvatar = $.CreatePanel("DOTAAvatarImage", PlayerStatPanel, "", {style : "width: 40px;height: 40px;vertical-align: center;margin-left: 5px;"})
        PlayerStatAvatar.steamid = playerInfo.player_steamid

        let CurrencyStats = $.CreatePanel("Panel", PlayerStatPanel, "")
        CurrencyStats.AddClass("CurrencyStats")

        let CurrencyStatsColumn_1 = $.CreatePanel("Panel", CurrencyStats, "")
        CurrencyStatsColumn_1.AddClass("CurrencyStatsColumn")

        let CurrencyStatGold = $.CreatePanel("Panel", CurrencyStatsColumn_1, "")
        CurrencyStatGold.AddClass("CurrencyStat")

        let CurrencyStatIconGold = $.CreatePanel("Panel", CurrencyStatGold, "")
        CurrencyStatIconGold.AddClass("CurrencyStatIcon")
        CurrencyStatIconGold.AddClass("IconGold")

        let CurrencyStatLabelGold = $.CreatePanel("Label", CurrencyStatGold, "GoldValue")
        CurrencyStatLabelGold.AddClass("CurrrencyStatLabel")
        CurrencyStatLabelGold.text = "0"

        let CurrencyStatWood = $.CreatePanel("Panel", CurrencyStatsColumn_1, "")
        CurrencyStatWood.AddClass("CurrencyStat")

        let CurrencyStatIconWood = $.CreatePanel("Panel", CurrencyStatWood, "")
        CurrencyStatIconWood.AddClass("CurrencyStatIcon")
        CurrencyStatIconWood.AddClass("IconWood")

        let CurrencyStatLabelWood = $.CreatePanel("Label", CurrencyStatWood, "WoodValue")
        CurrencyStatLabelWood.AddClass("CurrrencyStatLabel")
        CurrencyStatLabelWood.text = "0"

        let CurrencyStatsColumn_limiter = $.CreatePanel("Panel", CurrencyStats, "")
        CurrencyStatsColumn_limiter.AddClass("CurrencyStatsColumn_limiter")

        let CurrencyStatsColumn_2 = $.CreatePanel("Panel", CurrencyStats, "")
        CurrencyStatsColumn_2.AddClass("CurrencyStatsColumn")

        let CurrencyStatKills = $.CreatePanel("Panel", CurrencyStatsColumn_2, "")
        CurrencyStatKills.AddClass("CurrencyStat")

        let CurrencyStatIconKills = $.CreatePanel("Panel", CurrencyStatKills, "")
        CurrencyStatIconKills.AddClass("CurrencyStatIcon")
        CurrencyStatIconKills.AddClass("IconKills")

        let CurrencyStatLabelKills = $.CreatePanel("Label", CurrencyStatKills, "KillsValue")
        CurrencyStatLabelKills.AddClass("CurrrencyStatLabel")
        CurrencyStatLabelKills.text = "0"

        let CurrencyStatDeaths = $.CreatePanel("Panel", CurrencyStatsColumn_2, "")
        CurrencyStatDeaths.AddClass("CurrencyStat")

        let CurrencyStatIconDeaths = $.CreatePanel("Panel", CurrencyStatDeaths, "")
        CurrencyStatIconDeaths.AddClass("CurrencyStatIcon")
        CurrencyStatIconDeaths.AddClass("IconDeaths")

        let CurrencyStatLabelDeaths = $.CreatePanel("Label", CurrencyStatDeaths, "DeathsValue")
        CurrencyStatLabelDeaths.AddClass("CurrrencyStatLabel")
        CurrencyStatLabelDeaths.text = "0"
    }
}

function UpdateSelfDamageAbilities(data)
{
    let all_damage = 0;
    const abilities_data = data["abilities"] || {};

    for (const abilityname of Object.keys(abilities_data))
    {
        const ability_data = abilities_data[abilityname] || {};
        const physical = Number(ability_data["1"] || 0);
        const magical  = Number(ability_data["2"] || 0);
        all_damage += (physical + magical);
    }

    const panels_sort = [];

    for (const abilityname of Object.keys(abilities_data))
    {
        const ability_data = abilities_data[abilityname] || {};
        const physical_damage = Number(ability_data["1"] || 0);
        const magical_damage  = Number(ability_data["2"] || 0);
        const ability_total   = physical_damage + magical_damage;

        let ability_panel = PlayersStatsDamageList.FindChildTraverse("ability_" + abilityname);

        if (!ability_panel)
        {
            const PlayerDamageAbilityStat = $.CreatePanel("Panel", PlayersStatsDamageList, "ability_" + abilityname);
            PlayerDamageAbilityStat.AddClass("PlayerDamageAbilityStat");

            const PlayerDamageAbilityStatHeader = $.CreatePanel("Panel", PlayerDamageAbilityStat, "");
            PlayerDamageAbilityStatHeader.AddClass("PlayerDamageAbilityStatHeader");

            const PlayerDamageAbilityStatHeaderAbilityName = $.CreatePanel("Label", PlayerDamageAbilityStatHeader, "");
            PlayerDamageAbilityStatHeaderAbilityName.AddClass("PlayerDamageAbilityStatHeaderAbilityName");
            PlayerDamageAbilityStatHeaderAbilityName.text = $.Localize("#dota_tooltip_ability_" + abilityname);

            const PlayerDamageAbilityStatHeaderDamageCounter = $.CreatePanel("Label", PlayerDamageAbilityStatHeader, "PlayerDamageAbilityStatHeaderDamageCounter");
            PlayerDamageAbilityStatHeaderDamageCounter.AddClass("PlayerDamageAbilityStatHeaderDamageCounter");

            const PlayerDamageAbilityStatBodyLine = $.CreatePanel("Panel", PlayerDamageAbilityStat, "");
            PlayerDamageAbilityStatBodyLine.AddClass("PlayerDamageAbilityStatBodyLine");

            const PlayerDamageAbilityStatBodyLineBack = $.CreatePanel("Panel", PlayerDamageAbilityStatBodyLine, "");
            PlayerDamageAbilityStatBodyLineBack.AddClass("PlayerDamageAbilityStatBodyLineBack");

            const PlayerDamageAbilityStatBodyLineFrontList = $.CreatePanel("Panel", PlayerDamageAbilityStatBodyLine, "PlayerDamageAbilityStatBodyLineFrontList");
            PlayerDamageAbilityStatBodyLineFrontList.AddClass("PlayerDamageAbilityStatBodyLineFrontList");

            const PlayerDamageAbilityStatBodyLineFrontListFX = $.CreatePanel("Panel", PlayerDamageAbilityStatBodyLine, "PlayerDamageAbilityStatBodyLineFrontListFX");
            PlayerDamageAbilityStatBodyLineFrontListFX.AddClass("PlayerDamageAbilityStatBodyLineFrontListFX");

            const PlayerDamageAbilityStatBodyLineFrontPhysical = $.CreatePanel("Panel", PlayerDamageAbilityStatBodyLineFrontList, "PlayerDamageAbilityStatBodyLineFrontPhysical");
            PlayerDamageAbilityStatBodyLineFrontPhysical.AddClass("PlayerDamageAbilityStatBodyLineFrontPhysical");

            const PlayerDamageAbilityStatBodyLineFrontMagical = $.CreatePanel("Panel", PlayerDamageAbilityStatBodyLineFrontList, "PlayerDamageAbilityStatBodyLineFrontMagical");
            PlayerDamageAbilityStatBodyLineFrontMagical.AddClass("PlayerDamageAbilityStatBodyLineFrontMagical");

            const PlayerDamageAbilityStatBodyLinePercent = $.CreatePanel("Label", PlayerDamageAbilityStatBodyLine, "PlayerDamageAbilityStatBodyLinePercent");
            PlayerDamageAbilityStatBodyLinePercent.AddClass("PlayerDamageAbilityStatBodyLinePercent");
            PlayerDamageAbilityStatBodyLinePercent.text = "0%";

            ability_panel = PlayerDamageAbilityStat;
        }

        const PlayerDamageAbilityStatBodyLinePercent = ability_panel.FindChildTraverse("PlayerDamageAbilityStatBodyLinePercent");
        const PlayerDamageAbilityStatHeaderDamageCounter = ability_panel.FindChildTraverse("PlayerDamageAbilityStatHeaderDamageCounter");
        const PlayerDamageAbilityStatBodyLineFrontList = ability_panel.FindChildTraverse("PlayerDamageAbilityStatBodyLineFrontList");
        const PlayerDamageAbilityStatBodyLineFrontPhysical = ability_panel.FindChildTraverse("PlayerDamageAbilityStatBodyLineFrontPhysical");
        const PlayerDamageAbilityStatBodyLineFrontMagical = ability_panel.FindChildTraverse("PlayerDamageAbilityStatBodyLineFrontMagical");
        const ability_share = (all_damage > 0) ? (ability_total / all_damage) : 0;
        const ability_percent = Math.max(0, Math.min(100, ability_share * 100));
        let phys_in_ability = 0;
        let mag_in_ability = 0;

        if (PlayerDamageAbilityStatBodyLinePercent)
        {
            PlayerDamageAbilityStatBodyLinePercent.text = ability_percent.toFixed(1) + "%";
        }
        if (PlayerDamageAbilityStatHeaderDamageCounter)
        {
            PlayerDamageAbilityStatHeaderDamageCounter.text = String(CheckStringDamage(Math.floor(ability_total)));
        }
        if (PlayerDamageAbilityStatBodyLineFrontList)
        {
            PlayerDamageAbilityStatBodyLineFrontList.style.width = ability_percent.toFixed(3) + "%";
        }
        if (ability_total > 0)
        {
            phys_in_ability = (physical_damage / ability_total) * 100;
            mag_in_ability  = (magical_damage  / ability_total) * 100;
        }
        if (PlayerDamageAbilityStatBodyLineFrontPhysical)
        {
            PlayerDamageAbilityStatBodyLineFrontPhysical.style.width = phys_in_ability.toFixed(3) + "%";
        }
        if (PlayerDamageAbilityStatBodyLineFrontMagical)
        {
            PlayerDamageAbilityStatBodyLineFrontMagical.style.width  = mag_in_ability.toFixed(3) + "%";
        }
        panels_sort.push({panel: ability_panel, percent: ability_percent});
    }

    panels_sort.sort((a, b) => b.percent - a.percent);
    for (let i = 0; i < panels_sort.length; i++)
    {
        const p = panels_sort[i].panel;
        if (!p || p.GetParent() !== PlayersStatsDamageList) continue;
        if (i === 0)
        {
            const first = PlayersStatsDamageList.GetChild(0);
            if (first && first !== p)
            {
                PlayersStatsDamageList.MoveChildBefore(p, first);
            }
        }
        else
        {
            const prev = panels_sort[i - 1].panel;
            if (prev && prev !== p)
            {
                PlayersStatsDamageList.MoveChildAfter(p, prev);
            }
        }
    }
}

function UpdateAllPlayersDamage(all_players_data)
{
    let all_damage_global = 0;
    for (const player_id of Object.keys(all_players_data))
    {
        const data = all_players_data[player_id];
        const abilities = (data && data.abilities) || {};
        for (const abilityname of Object.keys(abilities))
        {
            const a = abilities[abilityname] || {};
            all_damage_global += Number(a["1"] || 0) + Number(a["2"] || 0);
        }
    }
    const sort_list = [];
    for (const player_id of Object.keys(all_players_data))
    {
        const res = UpdateAllDamageStats(Number(player_id), all_players_data[player_id], all_damage_global);
        if (res && res.panel) sort_list.push(res);
    }
    sort_list.sort((a, b) => b.total - a.total);
    for (let i = 0; i < sort_list.length; i++)
    {
        const p = sort_list[i].panel;
        if (!p || p.GetParent() !== PlayersStatsAllList) continue;

        if (i === 0)
        {
            const first = PlayersStatsAllList.GetChild(0);
            if (first && first !== p) PlayersStatsAllList.MoveChildBefore(p, first);
        }
        else
        {
            const prev = sort_list[i - 1].panel;
            if (prev && prev !== p) PlayersStatsAllList.MoveChildAfter(p, prev);
        }
    }
}

function UpdateAllDamageStats(player_id, data, all_damage_global)
{
    let player_total = 0;
    let player_physical = 0;
    let player_magical = 0;

    const abilities_data = data["abilities"] || {};
    for (const abilityname of Object.keys(abilities_data))
    {
        const ability_data = abilities_data[abilityname] || {};
        const physical = Number(ability_data["1"] || 0);
        const magical  = Number(ability_data["2"] || 0);

        player_total += (physical + magical);
        player_physical += physical;
        player_magical += magical;
    }

    let player_panel = PlayersStatsAllList.FindChildTraverse("player_stat_damage_" + player_id);
    if (!player_panel)
    {
        const PlayerDamageStat = $.CreatePanel("Panel", PlayersStatsAllList, "player_stat_damage_" + player_id);
        PlayerDamageStat.AddClass("PlayerDamageAbilityStat"); // можешь переименовать класс под игроков

        const header = $.CreatePanel("Panel", PlayerDamageStat, "");
        header.AddClass("PlayerDamageAbilityStatHeader");

        const nameLbl = $.CreatePanel("Label", header, "");
        nameLbl.AddClass("PlayerDamageAbilityStatHeaderAbilityName");
        nameLbl.text = Players.GetPlayerName(player_id);

        const counterLbl = $.CreatePanel("Label", header, "PlayerDamageAbilityStatHeaderDamageCounter");
        counterLbl.AddClass("PlayerDamageAbilityStatHeaderDamageCounter");

        const line = $.CreatePanel("Panel", PlayerDamageStat, "");
        line.AddClass("PlayerDamageAbilityStatBodyLine");

        const back = $.CreatePanel("Panel", line, "");
        back.AddClass("PlayerDamageAbilityStatBodyLineBack");

        const frontList = $.CreatePanel("Panel", line, "PlayerDamageAbilityStatBodyLineFrontList");
        frontList.AddClass("PlayerDamageAbilityStatBodyLineFrontList");

        const PlayerDamageAbilityStatBodyLineFrontListFX = $.CreatePanel("Panel", line, "PlayerDamageAbilityStatBodyLineFrontListFX");
        PlayerDamageAbilityStatBodyLineFrontListFX.AddClass("PlayerDamageAbilityStatBodyLineFrontListFX");

        const frontPhys = $.CreatePanel("Panel", frontList, "PlayerDamageAbilityStatBodyLineFrontPhysical");
        frontPhys.AddClass("PlayerDamageAbilityStatBodyLineFrontPhysical");

        const frontMag = $.CreatePanel("Panel", frontList, "PlayerDamageAbilityStatBodyLineFrontMagical");
        frontMag.AddClass("PlayerDamageAbilityStatBodyLineFrontMagical");

        const percentLbl = $.CreatePanel("Label", line, "PlayerDamageAbilityStatBodyLinePercent");
        percentLbl.AddClass("PlayerDamageAbilityStatBodyLinePercent");
        percentLbl.text = "0%";

        player_panel = PlayerDamageStat;
    }

    const percentLbl = player_panel.FindChildTraverse("PlayerDamageAbilityStatBodyLinePercent");
    const counterLbl = player_panel.FindChildTraverse("PlayerDamageAbilityStatHeaderDamageCounter");
    const frontList  = player_panel.FindChildTraverse("PlayerDamageAbilityStatBodyLineFrontList");
    const frontPhys  = player_panel.FindChildTraverse("PlayerDamageAbilityStatBodyLineFrontPhysical");
    const frontMag   = player_panel.FindChildTraverse("PlayerDamageAbilityStatBodyLineFrontMagical");
    const share = (all_damage_global > 0) ? (player_total / all_damage_global) : 0;
    const percent_of_all = Math.max(0, Math.min(100, share * 100));
    let phys_in_player = 0;
    let mag_in_player = 0;

    if (percentLbl)
    {
        percentLbl.text = percent_of_all.toFixed(1) + "%";
    }
    if (counterLbl)
    {
        counterLbl.text = String(CheckStringDamage(Math.floor(player_total)));
    }
    if (frontList)
    {
        frontList.style.width = percent_of_all.toFixed(3) + "%";
    }
    if (player_total > 0)
    {
        phys_in_player = (player_physical / player_total) * 100;
        mag_in_player  = (player_magical  / player_total) * 100;
    }
    if (frontPhys)
    {
        frontPhys.style.width = phys_in_player.toFixed(3) + "%";
    }
    if (frontMag)
    {
        frontMag.style.width  = mag_in_player.toFixed(3) + "%";
    }

    return { panel: player_panel, total: player_total, percent: percent_of_all };
}

// Апгрейды за уровень
function OpenUpgradePanel(data)
{
    UpgradeStatsList.RemoveAndDeleteChildren()
    LEVEL_UPGRADES_QUEUE = data.upgrades_queue
    UpgradeStatsLevel.SetHasClass("OpenUpgrade", true)

    for (let upgrade_data of Object.values(data.upgrades_list))
    {
        let UpgradeStat = $.CreatePanel("Panel", UpgradeStatsList, "")
        UpgradeStat.AddClass("UpgradeStat")
        
        let UpgradeStatLabel = $.CreatePanel("Label", UpgradeStat, "")
        UpgradeStatLabel.text = FormatUpgradeLabel(upgrade_data, UpgradeStatLabel)

        UpgradeStat.SetPanelEvent("onactivate", function()
        {
            ActiveUpgradeEvent(upgrade_data.upgrade_id)
            UnFocusUI()
        })
    }
}

function FormatUpgradeLabel(upgrade_data, panel)
{
    const localizedToken = "#level_upgrade_" + upgrade_data.upgrade_name
    const valueText = ApplyNumberFormat(upgrade_data.value) + (upgrade_data.value_kind === "pct" ? "%" : "")

    if (panel)
    {
        panel.SetDialogVariable("value", valueText)
    }

    const localizedText = panel ? $.Localize(localizedToken, panel) : $.Localize(localizedToken)

    if (localizedText && localizedText !== localizedToken)
        return localizedText

    return valueText + " " + upgrade_data.upgrade_name
}

function ActiveUpgradeEvent(upgrade_id)
{
    if (!UpgradeStatsLevel.BHasClass("OpenUpgrade")) { return }
    LEVEL_UPGRADES_QUEUE = LEVEL_UPGRADES_QUEUE - 1
    GameEvents.SendCustomGameEventToServer("event_player_select_upgrade_custom", {upgrade_id : upgrade_id})
    if (LEVEL_UPGRADES_QUEUE <= 0)
    {
        UpgradeStatsLevel.SetHasClass("OpenUpgrade", false)
    }
}

function CloseNeutralRoshanBonusPanel(notifyServer = true)
{
    if (!NeutralRoshanBonusPanel)
    {
        return
    }

    const wasOpen = NeutralRoshanBonusPanel.BHasClass("OpenNeutralRoshanBonusPanel")
    NeutralRoshanBonusPanel.SetHasClass("OpenNeutralRoshanBonusPanel", false)
    if (NeutralRoshanBonusList)
    {
        NeutralRoshanBonusList.RemoveAndDeleteChildren()
    }

    if (notifyServer && wasOpen)
    {
        GameEvents.SendCustomGameEventToServer("event_player_close_neutral_roshan_bonus_panel", {})
    }
}

function GetPostStageActivityData(activity_id)
{
    return POST_STAGE_ACTIVITY_UI[activity_id] || POST_STAGE_ACTIVITY_UI.DUMMY
}

function IsPostStageActivityBusy()
{
    if (typeof POST_STAGE_ACTIVITY_STATE === "undefined") return false
    if (!POST_STAGE_ACTIVITY_STATE) return false

    const activity = POST_STAGE_ACTIVITY_STATE.activity
    return !!activity && activity !== "NONE"
}

function IsPostStageActivityUsed(activity_id)
{
    if (!activity_id) return false

    if (typeof POST_STAGE_ACTIVITY_STATE === "undefined") return false
    if (!POST_STAGE_ACTIVITY_STATE) return false

    if (activity_id === "DUMMY" && IsDummyTrialUsed()) return true
    if (activity_id === "AGHANIM" && IsAghanimAttemptUsed()) return true
    if (activity_id === "BOSS_RUSH" && IsBossRushUsed()) return true

    if (!POST_STAGE_ACTIVITY_STATE.used_activities) return false

    return POST_STAGE_ACTIVITY_STATE.used_activities[activity_id] === true
}

function IsPostStageActivityStartDisabled(activity_id)
{
    if (activity_id === "BOSS_RUSH" && !IsBossRushUnlocked()) return true
    return IsPostStageActivityUsed(activity_id) || IsPostStageActivityBusy()
}

function GetPostStageActivityStartText(activity_id)
{
    if (activity_id === "BOSS_RUSH" && !IsBossRushUnlocked()) return $.Localize("#post_stage_activity_boss_rush_locked")
    if (IsPostStageActivityUsed(activity_id)) return $.Localize("#post_stage_activity_unavailable")
    if (IsPostStageActivityBusy()) return $.Localize("#post_stage_activity_unavailable")
    return $.Localize("#post_stage_activity_start")
}

function BuildPostStageActivityMenu()
{
    if (!PostStageActivityBody) return

    PostStageActivityBody.RemoveAndDeleteChildren()

    let PostStageActivityBodyBG = $.CreatePanel("Panel", PostStageActivityBody, "")
    PostStageActivityBodyBG.AddClass("PostStageActivityBodyBG")

    const header = $.CreatePanel("Label", PostStageActivityBody, "")
    header.AddClass("PostStageActivityHeaderLabel")
    header.text = $.Localize("#post_stage_activity_panel_title")

    const layout = $.CreatePanel("Panel", PostStageActivityBody, "PostStageActivityLayout")
    layout.AddClass("PostStageActivityLayout")

    const list = $.CreatePanel("Panel", layout, "PostStageActivityList")
    list.AddClass("PostStageActivityList")

    for (const activity_id of POST_STAGE_ACTIVITY_ORDER)
    {
        CreatePostStageActivityOption(list, activity_id)
    }

    const preview = $.CreatePanel("Panel", PostStageActivityBody, "PostStageActivityPreview")
    preview.AddClass("PostStageActivityPreview")

    const previewImage = $.CreatePanel("Image", preview, "PostStageActivityPreviewImage")
    previewImage.AddClass("PostStageActivityPreviewImage")

    const previewTitle = $.CreatePanel("Label", preview, "PostStageActivityPreviewTitle")
    previewTitle.AddClass("PostStageActivityPreviewTitle")

    const info = $.CreatePanel("Panel", layout, "PostStageActivityInfo")
    info.AddClass("PostStageActivityInfo")

    const descBlock = $.CreatePanel("Panel", info, "")
    descBlock.AddClass("PostStageActivityInfoBlock")

    const descTitle = $.CreatePanel("Label", descBlock, "")
    descTitle.AddClass("PostStageActivityInfoTitle")
    descTitle.text = $.Localize("#post_stage_activity_description_title")

    const desc = $.CreatePanel("Label", descBlock, "PostStageActivityDescription")
    desc.AddClass("PostStageActivityDescription")
    desc.html = true

    const rewardsBlock = $.CreatePanel("Panel", info, "")
    rewardsBlock.AddClass("PostStageActivityInfoBlock")

    const rewardsTitle = $.CreatePanel("Label", rewardsBlock, "")
    rewardsTitle.AddClass("PostStageActivityInfoTitle")
    rewardsTitle.text = $.Localize("#post_stage_activity_rewards_title")

    const rewards = $.CreatePanel("Panel", rewardsBlock, "PostStageActivityRewards")
    rewards.AddClass("PostStageActivityRewards")

    const startButton = $.CreatePanel("Panel", info, "PostStageActivityStartButton")
    startButton.AddClass("PostStageActivityStartButton")
    startButton.SetPanelEvent("onactivate", function()
    {
        LaunchSelectedPostStageActivity()
    })

    const startLabel = $.CreatePanel("Label", startButton, "PostStageActivityStartButtonLabel")
    startLabel.AddClass("PostStageActivityStartButtonLabel")

    RenderSelectedPostStageActivity()
}

function CreatePostStageActivityOption(parent, activity_id)
{
    const activity = GetPostStageActivityData(activity_id)
    const option = $.CreatePanel("Panel", parent, POST_STAGE_ACTIVITY_OPTION_PANEL_IDS[activity_id] || ("PostStage" + activity_id + "Option"))
    option.AddClass("PostStageActivityOption")
    option.SetPanelEvent("onactivate", function()
    {
        SelectPostStageActivity(activity_id)
    })

    const optionBG1 = $.CreatePanel("Panel", option, "")
    optionBG1.AddClass("PostStageActivityOptionBG1")
    optionBG1.hittest = false

    const optionBG2 = $.CreatePanel("Panel", option, "")
    optionBG2.AddClass("PostStageActivityOptionBG2")
    optionBG2.hittest = false

    const icon = $.CreatePanel("Panel", option, "")
    icon.AddClass("PostStageActivityOptionIcon")
    icon.AddClass(activity.option_icon_class)

    const title = $.CreatePanel("Label", option, "")
    title.AddClass("PostStageActivityOptionTitle")
    title.text = $.Localize(activity.title)

    return option
}

function SelectPostStageActivity(activity_id)
{
    POST_STAGE_SELECTED_ACTIVITY = activity_id
    RenderSelectedPostStageActivity()
}

function RenderSelectedPostStageActivity()
{
    if (!PostStageActivityBody) return

    const activity = GetPostStageActivityData(POST_STAGE_SELECTED_ACTIVITY)
    const previewImage = PostStageActivityBody.FindChildTraverse("PostStageActivityPreviewImage")
    const previewTitle = PostStageActivityBody.FindChildTraverse("PostStageActivityPreviewTitle")
    const description = PostStageActivityBody.FindChildTraverse("PostStageActivityDescription")
    const rewards = PostStageActivityBody.FindChildTraverse("PostStageActivityRewards")
    const startButton = PostStageActivityBody.FindChildTraverse("PostStageActivityStartButton")
    const startLabel = PostStageActivityBody.FindChildTraverse("PostStageActivityStartButtonLabel")
    for (const activity_id of POST_STAGE_ACTIVITY_ORDER)
    {
        const option = PostStageActivityBody.FindChildTraverse(POST_STAGE_ACTIVITY_OPTION_PANEL_IDS[activity_id])
        if (option)
        {
            option.SetHasClass("SelectedActivity", POST_STAGE_SELECTED_ACTIVITY === activity_id)
            option.SetHasClass("DisabledActivity", IsPostStageActivityStartDisabled(activity_id))
        }
    }
    if (previewImage)
    {
        previewImage.SetImage(activity.preview)
    }
    if (previewTitle)
    {
        previewTitle.text = $.Localize(activity.title)
    }
    if (description)
    {
        description.text = $.Localize(activity.description)
    }
    if (rewards)
    {
        rewards.RemoveAndDeleteChildren()
        for (const reward of activity.rewards || [])
        {
            CreatePostStageActivityReward(rewards, reward)
        }
    }
    if (startButton)
    {
        const disabled = IsPostStageActivityStartDisabled(POST_STAGE_SELECTED_ACTIVITY)
        startButton.SetHasClass("DisabledStartButton", disabled)
    }
    if (startLabel)
    {
        startLabel.text = GetPostStageActivityStartText(POST_STAGE_SELECTED_ACTIVITY)
    }
}

function CreatePostStageActivityReward(parent, reward)
{
    const panel = $.CreatePanel("Panel", parent, "")
    panel.AddClass("PostStageActivityReward")

    const iconWrap = $.CreatePanel("Panel", panel, "")
    iconWrap.AddClass("PostStageActivityRewardIconWrap")

    const icon = $.CreatePanel("Image", iconWrap, "")
    icon.AddClass("PostStageActivityRewardIcon")
    icon.SetImage(reward.icon || "file://{images}/game_hud/icons/closed.png")

    if (Number(reward.count || 0) > 1)
    {
        const count = $.CreatePanel("Label", iconWrap, "")
        count.AddClass("PostStageActivityRewardCount")
        count.text = "x" + String(reward.count)
    }

    const label = $.CreatePanel("Label", panel, "")
    label.AddClass("PostStageActivityRewardLabel")
    label.text = $.Localize(reward.text || "")
}

function LaunchSelectedPostStageActivity()
{
    if (IsPostStageActivityStartDisabled(POST_STAGE_SELECTED_ACTIVITY))
    {
        if (POST_STAGE_SELECTED_ACTIVITY === "DUMMY" && IsDummyTrialUsed())
        {
            ShowPostStageActivityHint("post_stage_activity_dummy_unavailable")
        }
        else if (POST_STAGE_SELECTED_ACTIVITY === "AGHANIM" && IsAghanimAttemptUsed())
        {
            ShowPostStageActivityHint("post_stage_activity_aghanim_unavailable")
        }
        else if (POST_STAGE_SELECTED_ACTIVITY === "BOSS_RUSH" && !IsBossRushUnlocked())
        {
            ShowPostStageActivityHint("post_stage_activity_boss_rush_locked")
        }
        else if (POST_STAGE_SELECTED_ACTIVITY === "BOSS_RUSH" && IsBossRushUsed())
        {
            ShowPostStageActivityHint("post_stage_activity_boss_rush_unavailable")
        }
        else
        {
            ShowPostStageActivityHint("post_stage_activity_blocked")
        }
        return
    }

    GameEvents.SendCustomGameEventToServer("event_player_select_post_stage_activity", { activity_id: POST_STAGE_SELECTED_ACTIVITY })
}

function IsAghanimAttemptUsed()
{
    const state = POST_STAGE_ACTIVITY_STATE && POST_STAGE_ACTIVITY_STATE.aghanim_attempt_state
    return state === "WON" || state === "LOST"
}

function IsDummyTrialUsed()
{
    const state = POST_STAGE_ACTIVITY_STATE && POST_STAGE_ACTIVITY_STATE.dummy_trial_state
    return state === "WON" || state === "LOST"
}

function IsBossRushUsed()
{
    const state = POST_STAGE_ACTIVITY_STATE && POST_STAGE_ACTIVITY_STATE.boss_rush_state
    return state === "WON" || state === "LOST"
}

function IsBossRushUnlocked()
{
    if (typeof POST_STAGE_ACTIVITY_STATE === "undefined" || !POST_STAGE_ACTIVITY_STATE) return true
    if (POST_STAGE_ACTIVITY_STATE.boss_rush_unlocked === undefined) return true
    return IsTruthyCustomValue(POST_STAGE_ACTIVITY_STATE.boss_rush_unlocked)
}

function IsPostStageDummyTimerActive()
{
    return POST_STAGE_DUMMY_TIMER_ACTIVE === true
}

function IsPostStageCombatTimerActive()
{
    return POST_STAGE_DUMMY_TIMER_ACTIVE === true
}

function IsPostStageDummyCountdownActive()
{
    return POST_STAGE_DUMMY_COUNTDOWN_ACTIVE === true
}

function IsTruthyCustomValue(value)
{
    return value === true || value === 1 || value === "1" || value === "true"
}

function FormatPostStageDummyCountdown(seconds)
{
    const safeSeconds = Math.max(0, Math.ceil(Number(seconds) || 0))
    const minutes = Math.floor(safeSeconds / 60)
    const secs = safeSeconds - minutes * 60
    return String(minutes).padStart(2, "0") + ":" + String(secs).padStart(2, "0")
}

function UpdatePostStageCombatTimerLabel(endsAt, token)
{
    if (token !== POST_STAGE_DUMMY_TIMER_TOKEN || !POST_STAGE_DUMMY_TIMER_ACTIVE)
    {
        return
    }

    const remaining = Math.max(0, Number(endsAt || 0) - Math.max(0, Game.GetGameTime()))
    if (CurrentTimeLabel)
    {
        CurrentTimeLabel.text = FormatPostStageDummyCountdown(remaining)
    }

    if (remaining > 0)
    {
        $.Schedule(0.1, function()
        {
            UpdatePostStageCombatTimerLabel(endsAt, token)
        })
    }
}

function AnimatePostStageDummyCountdownNumber(number)
{
    if (!PostStageDummyCountdownNumber)
    {
        return
    }

    PostStageDummyCountdownNumber.text = String(number)
    PostStageDummyCountdownNumber.SetHasClass("AnimateCountdownNumber", false)
    $.Schedule(0.01, function()
    {
        if (PostStageDummyCountdownNumber)
        {
            PostStageDummyCountdownNumber.SetHasClass("AnimateCountdownNumber", true)
        }
    })
}

function UpdatePostStageDummyCountdown(endsAt, token)
{
    if (token !== POST_STAGE_DUMMY_COUNTDOWN_TOKEN || !POST_STAGE_DUMMY_COUNTDOWN_ACTIVE)
    {
        return
    }

    const remaining = Math.ceil(Number(endsAt || 0) - Math.max(0, Game.GetGameTime()))
    if (remaining <= 0)
    {
        StopPostStageDummyCountdown()
        return
    }

    if (remaining !== POST_STAGE_DUMMY_COUNTDOWN_LAST_NUMBER)
    {
        POST_STAGE_DUMMY_COUNTDOWN_LAST_NUMBER = remaining
        AnimatePostStageDummyCountdownNumber(remaining)
    }

    $.Schedule(0.05, function()
    {
        UpdatePostStageDummyCountdown(endsAt, token)
    })
}

function StartPostStageCountdown(data, titleKey)
{
    const now = Math.max(0, Game.GetGameTime())
    const duration = Number(data && data.duration || data && data.dummy_trial_countdown_duration || data && data.aghanim_countdown_duration || data && data.boss_rush_countdown_duration || 5)
    const rawEndsAt = Number(data && (data.ends_at || data.dummy_trial_countdown_ends_at || data.aghanim_countdown_ends_at || data.boss_rush_countdown_ends_at) || 0)
    const endsAt = rawEndsAt > 0 ? rawEndsAt : now + duration
    if (endsAt <= now)
    {
        StopPostStageDummyCountdown()
        return
    }

    if (POST_STAGE_DUMMY_COUNTDOWN_ACTIVE && Math.abs(POST_STAGE_DUMMY_COUNTDOWN_ENDS_AT - endsAt) < 0.01)
    {
        return
    }

    POST_STAGE_DUMMY_COUNTDOWN_ACTIVE = true
    POST_STAGE_DUMMY_COUNTDOWN_ENDS_AT = endsAt
    POST_STAGE_DUMMY_COUNTDOWN_LAST_NUMBER = -1
    POST_STAGE_DUMMY_COUNTDOWN_TOKEN += 1

    if (PostStageDummyCountdownTitle)
    {
        PostStageDummyCountdownTitle.text = $.Localize(titleKey || "#post_stage_dummy_countdown_title")
    }
    if (PostStageDummyCountdownPanel)
    {
        PostStageDummyCountdownPanel.SetHasClass("VisibleDummyCountdown", true)
    }

    UpdatePostStageDummyCountdown(endsAt, POST_STAGE_DUMMY_COUNTDOWN_TOKEN)
}

function StartPostStageDummyCountdown(data)
{
    StartPostStageCountdown(data, "#post_stage_dummy_countdown_title")
}

function StartPostStageAghanimCountdown(data)
{
    StartPostStageCountdown(data, "#post_stage_aghanim_countdown_title")
}

function StartPostStageBossRushCountdown(data)
{
    StartPostStageCountdown(data, "#post_stage_boss_rush_countdown_title")
}

function StopPostStageBossRushCountdown()
{
    StopPostStageDummyCountdown()
}

function StopPostStageDummyCountdown()
{
    POST_STAGE_DUMMY_COUNTDOWN_ACTIVE = false
    POST_STAGE_DUMMY_COUNTDOWN_ENDS_AT = -1
    POST_STAGE_DUMMY_COUNTDOWN_LAST_NUMBER = -1
    POST_STAGE_DUMMY_COUNTDOWN_TOKEN += 1

    if (PostStageDummyCountdownPanel)
    {
        PostStageDummyCountdownPanel.SetHasClass("VisibleDummyCountdown", false)
    }
    if (PostStageDummyCountdownNumber)
    {
        PostStageDummyCountdownNumber.SetHasClass("AnimateCountdownNumber", false)
    }
}

function StopPostStageAghanimCountdown()
{
    StopPostStageDummyCountdown()
}

function StartPostStageCombatTimer(endsAt)
{
    StopPostStageDummyCountdown()

    const parsedEndsAt = Number(endsAt || -1)
    if (parsedEndsAt <= 0)
    {
        StopPostStageCombatTimer()
        return
    }

    if (POST_STAGE_DUMMY_TIMER_ACTIVE && Math.abs(POST_STAGE_DUMMY_TIMER_ENDS_AT - parsedEndsAt) < 0.01)
    {
        return
    }

    if (CurrentTimeLabel && !POST_STAGE_DUMMY_TIMER_ACTIVE)
    {
        POST_STAGE_LAST_BASE_TIMER_TEXT = CurrentTimeLabel.text || POST_STAGE_LAST_BASE_TIMER_TEXT
    }

    POST_STAGE_DUMMY_TIMER_ACTIVE = true
    POST_STAGE_DUMMY_TIMER_ENDS_AT = parsedEndsAt
    POST_STAGE_DUMMY_TIMER_TOKEN += 1
    if (GameTimerPanel)
    {
        GameTimerPanel.SetHasClass("DummyTrialTimer", true)
    }

    UpdatePostStageCombatTimerLabel(parsedEndsAt, POST_STAGE_DUMMY_TIMER_TOKEN)
}

function StopPostStageCombatTimer()
{
    if (!POST_STAGE_DUMMY_TIMER_ACTIVE && POST_STAGE_DUMMY_TIMER_ENDS_AT <= 0)
    {
        return
    }

    POST_STAGE_DUMMY_TIMER_ACTIVE = false
    POST_STAGE_DUMMY_TIMER_ENDS_AT = -1
    POST_STAGE_DUMMY_TIMER_TOKEN += 1
    if (GameTimerPanel)
    {
        GameTimerPanel.SetHasClass("DummyTrialTimer", false)
    }
    if (CurrentTimeLabel)
    {
        CurrentTimeLabel.text = $.Localize("#levelup_post_stage_win") || POST_STAGE_LAST_BASE_TIMER_TEXT
    }
}

function StartPostStageDummyTimer(endsAt)
{
    StartPostStageCombatTimer(endsAt)
}

function StopPostStageDummyTimer()
{
    StopPostStageCombatTimer()
}

function StartPostStageAghanimTimer(endsAt)
{
    StartPostStageCombatTimer(endsAt)
}

function StopPostStageAghanimTimer()
{
    StopPostStageCombatTimer()
}

function ApplyPostStageActivityState(state)
{
    POST_STAGE_ACTIVITY_STATE = state || Game.GetCustomTable("post_stage_activity_state", "global") || {}
    RenderSelectedPostStageActivity()

    const dummyTimerActive = IsTruthyCustomValue(POST_STAGE_ACTIVITY_STATE.dummy_trial_active)
    const dummyCountdownActive = IsTruthyCustomValue(POST_STAGE_ACTIVITY_STATE.dummy_trial_countdown_active)
    const aghanimCountdownActive = IsTruthyCustomValue(POST_STAGE_ACTIVITY_STATE.aghanim_countdown_active)
    const aghanimTimerActive = IsTruthyCustomValue(POST_STAGE_ACTIVITY_STATE.aghanim_boss_timer_active)
    const bossRushCountdownActive = IsTruthyCustomValue(POST_STAGE_ACTIVITY_STATE.boss_rush_countdown_active)
    if (bossRushCountdownActive)
    {
        StartPostStageBossRushCountdown(POST_STAGE_ACTIVITY_STATE)
    }
    else if (aghanimCountdownActive)
    {
        StartPostStageAghanimCountdown(POST_STAGE_ACTIVITY_STATE)
    }
    else if (dummyCountdownActive && !dummyTimerActive && !aghanimTimerActive)
    {
        StartPostStageDummyCountdown(POST_STAGE_ACTIVITY_STATE)
    }
    else
    {
        StopPostStageDummyCountdown()
    }

    if (aghanimTimerActive)
    {
        StartPostStageAghanimTimer(POST_STAGE_ACTIVITY_STATE.aghanim_boss_timer_ends_at)
    }
    else if (dummyTimerActive)
    {
        StartPostStageDummyTimer(POST_STAGE_ACTIVITY_STATE.dummy_trial_ends_at)
    }
    else
    {
        StopPostStageDummyTimer()
    }
}

function OpenPostStageActivityPanel(state)
{
    if (!PostStageActivityPanel)
    {
        return
    }

    POST_STAGE_ACTIVITY_STATE = state || Game.GetCustomTable("post_stage_activity_state", "global") || {}
    BuildPostStageActivityMenu()
    ApplyPostStageActivityState(state)
    PostStageActivityPanel.SetHasClass("OpenPostStageActivityPanel", true)
}

function ClosePostStageActivityPanel(notifyServer = true)
{
    if (!PostStageActivityPanel)
    {
        return
    }

    const wasOpen = PostStageActivityPanel.BHasClass("OpenPostStageActivityPanel")
    PostStageActivityPanel.SetHasClass("OpenPostStageActivityPanel", false)
    if (notifyServer && wasOpen)
    {
        GameEvents.SendCustomGameEventToServer("event_player_close_post_stage_activity_panel", {})
    }
}

function OpenPostStageHomePanel()
{
    if (!PostStageHomePanel)
    {
        return
    }

    PostStageHomePanel.SetHasClass("OpenPostStageHomePanel", true)
}

function ClosePostStageHomePanel(notifyServer = true)
{
    if (!PostStageHomePanel)
    {
        return
    }

    const wasOpen = PostStageHomePanel.BHasClass("OpenPostStageHomePanel")
    PostStageHomePanel.SetHasClass("OpenPostStageHomePanel", false)
    if (notifyServer && wasOpen)
    {
        GameEvents.SendCustomGameEventToServer("event_player_close_post_stage_home_panel", {})
    }
}

function UpdateRestartConfirmText()
{
    const prefix = START_GAME_AFK_EXIT_MODE ? "#afk_exit_confirm" : "#post_stage_restart_confirm"
    if (PostStageRestartConfirmHeaderLabel)
    {
        PostStageRestartConfirmHeaderLabel.text = $.Localize(prefix + "_title")
    }
    if (PostStageRestartConfirmDescriptionLabel)
    {
        PostStageRestartConfirmDescriptionLabel.text = $.Localize(prefix + "_description")
    }
    if (PostStageRestartConfirmButtonLabel)
    {
        PostStageRestartConfirmButtonLabel.text = $.Localize(prefix)
    }
}

function OpenPostStageRestartConfirmPanel()
{
    if (!PostStageRestartConfirmPanel)
    {
        return
    }

    UpdateRestartConfirmText()
    PostStageRestartConfirmPanel.SetHasClass("OpenPostStageRestartConfirmPanel", true)
}

function ClosePostStageRestartConfirmPanel()
{
    if (!PostStageRestartConfirmPanel)
    {
        return
    }

    PostStageRestartConfirmPanel.SetHasClass("OpenPostStageRestartConfirmPanel", false)
}

var POST_STAGE_BLOCKED_HINT_TOKEN = 0
function ShowPostStageActivityHint(localization_key)
{
    if (!PostStageActivityBlockedHint)
    {
        return
    }

    PostStageActivityBlockedHint.text = $.Localize("#" + localization_key)
    POST_STAGE_BLOCKED_HINT_TOKEN += 1
    const token = POST_STAGE_BLOCKED_HINT_TOKEN
    PostStageActivityBlockedHint.SetHasClass("VisibleBlockedHint", true)
    $.Schedule(1.6, function()
    {
        if (token === POST_STAGE_BLOCKED_HINT_TOKEN)
        {
            PostStageActivityBlockedHint.SetHasClass("VisibleBlockedHint", false)
        }
    })
}

function NormalizeAghanimRewardItems(items)
{
    return Array.isArray(items) ? items : Object.values(items || {})
}

function GetAghanimRewardSelectedIds()
{
    return Object.keys(AGHANIM_REWARD_STATE.selected || {}).filter(function(generated_id) {
        return AGHANIM_REWARD_STATE.selected[generated_id] === true
    })
}

function BuildAghanimEquipmentTooltipExtra(item)
{
    return {
        generated: "true",
        generated_id: item.generated_id || "",
        generated_name: item.generated_name || "",
        rarity: item.rarity || "common",
        icon: item.icon || "",
        slot: item.slot || "",
        potential: item.potential || 0,
        potential_reforge_attempts: item.potential_reforge_attempts || 0,
        strengthen_level: item.strengthen_level || 0,
        set_id: item.set_id || "",
        set_equipped_count: GetEquippedSetCountHud(item.set_id || ""),
        star_min: item.star_min || 1,
        star_max: item.star_max || 1,
        compare_equipped: item.compare_equipped || null,
        normal_stats: item.normal_stats || [],
        random_stats: item.random_stats || [],
    }
}

function GetServiceEquipmentConfigHud()
{
    return Game.GetCustomTable ? (Game.GetCustomTable("services_config", "equipment") || {}) : {}
}

function GetSetConfigHud(set_id)
{
    if (!set_id) return null
    let sets = GetServiceEquipmentConfigHud().sets || {}
    return (sets.list || {})[set_id] || null
}

function GetEquippedSetCountHud(set_id)
{
    if (!set_id) return 0
    let player_data = Game.GetCustomTable ? (Game.GetCustomTable("services_player", String(Players.GetLocalPlayer())) || {}) : {}
    let armor_data = player_data.armor_data || {}
    let config = (armor_data.configurations_data || {})[Number(armor_data.current_configuration) || 1] || {}
    let storage = player_data.storage_items || {}
    let equipped = {}
    for (let slot in config)
    {
        if (config[slot] !== undefined && config[slot] !== null) equipped[String(config[slot])] = true
    }
    let count = 0
    for (let key in storage)
    {
        let entry = storage[key]
        if (entry && equipped[String(entry.uid)] && String(entry.set_id || "") === String(set_id)) count++
    }
    return count
}

function AddSetIconOverlayHud(parentPanel, set_id)
{
    let set_config = GetSetConfigHud(set_id)
    if (!set_config || !set_config.icon) return
    let overlay = $.CreatePanel("Panel", parentPanel, "")
    overlay.AddClass("ItemSetIconOverlay")
    overlay.style.backgroundImage = "url('" + set_config.icon + "')"
    overlay.style.backgroundSize = "contain"
    overlay.style.backgroundRepeat = "no-repeat"
    overlay.style.backgroundPosition = "center"
}

function UpdateAghanimRewardPanelStatus()
{
    const items = NormalizeAghanimRewardItems(AGHANIM_REWARD_STATE.items)
    const selectionMode = AGHANIM_REWARD_STATE.selection_mode === true
    const selectedCount = GetAghanimRewardSelectedIds().length
    const requiredCount = Math.min(Number(AGHANIM_REWARD_STATE.max_select) || 3, items.length)

    if (AghanimRewardPanel)
    {
        AghanimRewardPanel.SetHasClass("VisibleAghanimRewardPanel", items.length > 0)
        AghanimRewardPanel.SetHasClass("SelectionMode", selectionMode)
    }

    if (AghanimRewardHint)
    {
        if (AGHANIM_REWARD_STATE.error_key)
        {
            AghanimRewardHint.text = $.Localize("#" + AGHANIM_REWARD_STATE.error_key)
        }
        else if (selectionMode)
        {
            AghanimRewardHint.SetDialogVariable("current", String(selectedCount))
            AghanimRewardHint.SetDialogVariable("max", String(requiredCount))
            AghanimRewardHint.text = $.Localize("#post_stage_aghanim_rewards_select_hint", AghanimRewardHint)
        }
        else
        {
            AghanimRewardHint.text = $.Localize("#post_stage_aghanim_rewards_preview_hint")
        }
    }

    if (AghanimRewardConfirmButton)
    {
        AghanimRewardConfirmButton.SetHasClass("VisibleConfirmButton", selectionMode)
        AghanimRewardConfirmButton.SetHasClass("DisabledConfirmButton", selectedCount !== requiredCount)
    }
}

function RenderAghanimRewardPanel()
{
    if (!AghanimRewardPanel || !AghanimRewardItems)
    {
        return
    }

    const items = NormalizeAghanimRewardItems(AGHANIM_REWARD_STATE.items)
    const selectionMode = AGHANIM_REWARD_STATE.selection_mode === true
    const requiredCount = Math.min(Number(AGHANIM_REWARD_STATE.max_select) || 3, items.length)

    AghanimRewardItems.RemoveAndDeleteChildren()
    for (let itemData of items)
    {
        const generatedId = String(itemData.generated_id || "")
        const item = $.CreatePanel("Panel", AghanimRewardItems, "")
        item.AddClass("AghanimRewardItem")
        item.SetHasClass("SelectableReward", selectionMode)
        item.SetHasClass("SelectedReward", AGHANIM_REWARD_STATE.selected[generatedId] === true)

        let selectedGlow = $.CreatePanel("Panel", item, "")
        selectedGlow.AddClass("AghanimRewardItemSelectedGlow")

        let bg1 = $.CreatePanel("Panel", item, "")
        bg1.AddClass("AghanimRewardItemBG1")
        if (itemData.rarity && itemData.rarity !== "common")
        {
            bg1.AddClass("RareColor_" + itemData.rarity)
        }

        let bg2 = $.CreatePanel("Panel", item, "")
        bg2.AddClass("AghanimRewardItemBG2")

        SetServiceItemTooltip(item, itemData.item_id || "generated_equipment", 1, BuildAghanimEquipmentTooltipExtra(itemData))

        let icon = $.CreatePanel("Panel", item, "")
        icon.AddClass("AghanimRewardItemIcon")
        SetServicesRewardPopupImage(icon, itemData.icon)

        AddSetIconOverlayHud(item, itemData.set_id)

        if (selectionMode)
        {
            item.SetPanelEvent("onactivate", function()
            {
                if (!generatedId)
                {
                    return
                }
                if (AGHANIM_REWARD_STATE.selected[generatedId] === true)
                {
                    delete AGHANIM_REWARD_STATE.selected[generatedId]
                }
                else if (GetAghanimRewardSelectedIds().length < requiredCount)
                {
                    AGHANIM_REWARD_STATE.selected[generatedId] = true
                }
                item.SetHasClass("SelectedReward", AGHANIM_REWARD_STATE.selected[generatedId] === true)
                UpdateAghanimRewardPanelStatus()
            })
        }
    }

    UpdateAghanimRewardPanelStatus()
}

function UpdateAghanimRewardPanel(data)
{
    data = data || {}
    AGHANIM_REWARD_STATE.items = NormalizeAghanimRewardItems(data.items)
    AGHANIM_REWARD_STATE.selection_mode = data.selection_mode === true || data.selection_mode === 1
    AGHANIM_REWARD_STATE.max_select = Number(data.max_select) || 3
    AGHANIM_REWARD_STATE.error_key = String(data.error_key || "")
    AGHANIM_REWARD_STATE.selected = {}
    for (let selectedId of Object.values(data.selected_ids || {}))
    {
        selectedId = String(selectedId || "")
        if (selectedId)
        {
            AGHANIM_REWARD_STATE.selected[selectedId] = true
        }
    }
    RenderAghanimRewardPanel()
}

function HideAghanimRewardPanel()
{
    AGHANIM_REWARD_STATE = { items: [], selected: {}, selection_mode: false, max_select: 3 }
    if (AghanimRewardPanel)
    {
        AghanimRewardPanel.SetHasClass("VisibleAghanimRewardPanel", false)
        AghanimRewardPanel.SetHasClass("SelectionMode", false)
    }
    if (AghanimRewardItems)
    {
        AghanimRewardItems.RemoveAndDeleteChildren()
    }
}

function ConfirmAghanimRewards()
{
    const items = NormalizeAghanimRewardItems(AGHANIM_REWARD_STATE.items)
    const requiredCount = Math.min(Number(AGHANIM_REWARD_STATE.max_select) || 3, items.length)
    const selectedIds = GetAghanimRewardSelectedIds()
    if (!AGHANIM_REWARD_STATE.selection_mode || selectedIds.length !== requiredCount)
    {
        return
    }
    GameEvents.SendCustomGameEventToServer("event_player_post_stage_aghanim_confirm_rewards", {
        selected_ids: selectedIds,
    })
}

function IsAfkModeActive()
{
    return AFK_MODE_ACTIVE === true
}

function NormalizeAfkRewardItems(items)
{
    return Array.isArray(items) ? items : Object.values(items || {})
}

function RenderAfkRewardItem(parent, reward)
{
    if (!parent || !reward) return

    const itemId = String(reward.id || reward.item_id || "sand_time")
    const countValue = Math.max(0, Math.floor(Number(reward.count || 0)))
    const items = GetServicesRewardPopupItemsConfig()
    const itemData = items[itemId] || {}
    const rarity = String(reward.rarity || itemData.rarity || "common")

    const item = $.CreatePanel("Panel", parent, "")
    item.AddClass("AghanimRewardItem")
    SetServiceItemTooltip(item, itemId, Math.max(1, countValue))

    let selectedGlow = $.CreatePanel("Panel", item, "")
    selectedGlow.AddClass("AghanimRewardItemSelectedGlow")

    let bg1 = $.CreatePanel("Panel", item, "")
    bg1.AddClass("AghanimRewardItemBG1")
    if (rarity && rarity !== "common")
    {
        bg1.AddClass("RareColor_" + rarity)
    }

    let bg2 = $.CreatePanel("Panel", item, "")
    bg2.AddClass("AghanimRewardItemBG2")

    let icon = $.CreatePanel("Panel", item, "")
    icon.AddClass("AghanimRewardItemIcon")
    SetServicesRewardPopupImage(icon, reward.icon || itemData.icon)

    let count = $.CreatePanel("Label", item, "")
    count.AddClass("AfkRewardItemCount")
    count.text = String(countValue)
}

function RenderAfkRewardList(parent, rewards)
{
    if (!parent) return
    parent.RemoveAndDeleteChildren()

    for (let reward of NormalizeAfkRewardItems(rewards))
    {
        RenderAfkRewardItem(parent, reward)
    }
}

function ApplyAfkModeHudState(data)
{
    data = data || {}
    AFK_MODE_ACTIVE = IsTruthyEventValue(data.active)

    if (LowerHud)
    {
        LowerHud.SetHasClass("AfkMode", AFK_MODE_ACTIVE)
    }
    if (GameItemsStorePanel)
    {
        GameItemsStorePanel.SetHasClass("AfkMode", AFK_MODE_ACTIVE)
    }
    if (SpawnChallengersPanel)
    {
        SpawnChallengersPanel.SetHasClass("AfkMode", AFK_MODE_ACTIVE)
    }

    if (AfkRewardsPanel)
    {
        AfkRewardsPanel.SetHasClass("VisibleAfkRewardPanel", AFK_MODE_ACTIVE)
    }
    if (AfkReceivedRewardsPanel)
    {
        AfkReceivedRewardsPanel.SetHasClass("VisibleAfkRewardPanel", AFK_MODE_ACTIVE)
    }

    if (AFK_MODE_ACTIVE)
    {
        if (CurrentTimeLabel)
        {
            CurrentTimeLabel.text = $.Localize("#levelup_afk_timer")
        }
        $("#CurrentWaveLabel").text = ""
        $("#CurrentDifficultLabel").text = $.Localize("#levelup_afk_game_mode")
        SetPostStageTrialsDisabled(true)
    }

    RenderAfkRewardList(AfkRewardsItems, data.possible_rewards)
    RenderAfkRewardList(AfkReceivedRewardItems, data.received_rewards)

    if (AfkReceivedRewardHint)
    {
        AfkReceivedRewardHint.SetHasClass("HiddenAfkRewardHint", NormalizeAfkRewardItems(data.received_rewards).length > 0)
    }

    if (AfkDailyLimitLabel)
    {
        AfkDailyLimitLabel.SetDialogVariable("current", String(Math.floor(Number(data.earned_today || 0))))
        AfkDailyLimitLabel.SetDialogVariable("max", String(Math.floor(Number(data.daily_cap || 0))))
        AfkDailyLimitLabel.text = $.Localize("#levelup_afk_daily_limit", AfkDailyLimitLabel)
    }
}

function NormalizeAghanimContinueParticipants(participants)
{
    return Object.values(participants || {}).map(function(player_id) {
        return Number(player_id)
    }).filter(function(player_id) {
        return player_id >= 0
    })
}
  
function NormalizeAghanimContinueResponses(responses)
{
    const result = {}
    for (let key in (responses || {}))
    {
        const playerId = String(Number(key))
        const response = String(responses[key] || "")
        if (playerId !== "NaN" && response)
        {
            result[playerId] = response
        }
    }
    return result
}

function UpdateAghanimContinueButtonState()
{
    const locked = AGHANIM_CONTINUE_STATE.local_choice_locked === true
    if (AghanimContinueButton)
    {
        AghanimContinueButton.SetHasClass("ChoiceLocked", locked)
    }
    if (AghanimLeaveButton)
    {
        AghanimLeaveButton.SetHasClass("ChoiceLocked", locked)
    }
}

function GetAghanimContinueVotePanel(playerId)
{
    if (!AghanimContinueVotes)
    {
        return null
    }
    return AghanimContinueVotes.FindChildTraverse("AghanimContinueVote_" + playerId)
}

function CreateAghanimContinueVotePanel(playerId)
{
    if (!AghanimContinueVotes)
    {
        return null
    }

    const playerInfo = Game.GetPlayerInfo(playerId)
    const votePanel = $.CreatePanel("Panel", AghanimContinueVotes, "AghanimContinueVote_" + playerId)
    votePanel.AddClass("AghanimContinueVote")

    const steamId = playerInfo && playerInfo.player_steamid ? playerInfo.player_steamid : "local"
    const avatar = $.CreatePanel("DOTAAvatarImage", votePanel, "", {
        steamid: steamId,
        style: "width: 100%; height: 100%;",
    })
    avatar.AddClass("AghanimContinueVoteAvatar")
    avatar.steamid = steamId

    const badge = $.CreatePanel("Panel", votePanel, "AghanimContinueVoteBadge_" + playerId)
    badge.AddClass("AghanimContinueVoteBadge")

    const badgeLabel = $.CreatePanel("Label", badge, "AghanimContinueVoteBadgeLabel_" + playerId)
    badgeLabel.AddClass("AghanimContinueVoteBadgeLabel")

    return votePanel
}

function ReconcileAghanimContinueVotePanels()
{
    if (!AghanimContinueVotes)
    {
        return
    }

    const participants = AGHANIM_CONTINUE_STATE.participant_player_ids || []
    AghanimContinueVotes.SetHasClass("VisibleAghanimContinueVotes", participants.length > 1)

    const activePanelIds = {}
    for (let playerId of participants)
    {
        activePanelIds["AghanimContinueVote_" + playerId] = true
        if (!GetAghanimContinueVotePanel(playerId))
        {
            CreateAghanimContinueVotePanel(playerId)
        }
    }

    for (let index = AghanimContinueVotes.GetChildCount() - 1; index >= 0; index--)
    {
        const child = AghanimContinueVotes.GetChild(index)
        if (child && !activePanelIds[child.id])
        {
            child.DeleteAsync(0)
        }
    }
}

function UpdateAghanimContinueVoteStates()
{
    if (!AghanimContinueVotes)
    {
        return
    }

    const participants = AGHANIM_CONTINUE_STATE.participant_player_ids || []
    const responses = AGHANIM_CONTINUE_STATE.responses || {}
    AghanimContinueVotes.SetHasClass("VisibleAghanimContinueVotes", participants.length > 1)

    for (let playerId of participants)
    {
        const response = responses[String(playerId)] || ""
        const votePanel = GetAghanimContinueVotePanel(playerId) || CreateAghanimContinueVotePanel(playerId)
        if (!votePanel)
        {
            continue
        }

        votePanel.SetHasClass("VotePending", response === "")
        votePanel.SetHasClass("VoteContinue", response === "continue")
        votePanel.SetHasClass("VoteLeave", response === "leave")

        const badgeLabel = votePanel.FindChildTraverse("AghanimContinueVoteBadgeLabel_" + playerId)
        if (badgeLabel)
        {
            badgeLabel.text = response === "continue" ? "✓" : response === "leave" ? "×" : ""
        }
    }
}

function AreAghanimContinueParticipantsSame(nextParticipants)
{
    const currentParticipants = AGHANIM_CONTINUE_STATE.participant_player_ids || []
    if (currentParticipants.length !== nextParticipants.length)
    {
        return false
    }

    for (let index = 0; index < nextParticipants.length; index++)
    {
        if (Number(currentParticipants[index]) !== Number(nextParticipants[index]))
        {
            return false
        }
    }
    return true
}

function ApplyAghanimContinueChoiceData(data, resetLocalLock)
{
    data = data || {}
    const nextToken = Number(data.token) || 0
    const nextParticipants = NormalizeAghanimContinueParticipants(data.participant_player_ids)
    const shouldReconcileVotes = resetLocalLock
        || nextToken !== AGHANIM_CONTINUE_TOKEN
        || !AreAghanimContinueParticipantsSame(nextParticipants)

    AGHANIM_CONTINUE_TOKEN = nextToken
    AGHANIM_CONTINUE_ENDS_AT = Number(data.ends_at) || -1
    AGHANIM_CONTINUE_STATE.participant_player_ids = nextParticipants
    AGHANIM_CONTINUE_STATE.responses = NormalizeAghanimContinueResponses(data.responses)

    const localPlayerId = String(Players.GetLocalPlayer())
    if (resetLocalLock)
    {
        AGHANIM_CONTINUE_STATE.local_choice_locked = AGHANIM_CONTINUE_STATE.responses[localPlayerId] ? true : false
    }
    else if (AGHANIM_CONTINUE_STATE.responses[localPlayerId])
    {
        AGHANIM_CONTINUE_STATE.local_choice_locked = true
    }

    UpdateAghanimContinueButtonState()
    if (shouldReconcileVotes)
    {
        ReconcileAghanimContinueVotePanels()
    }
    UpdateAghanimContinueVoteStates()
}

function UpdateAghanimContinueTimer(endsAt, timerToken)
{
    if (timerToken !== AGHANIM_CONTINUE_TIMER_TOKEN || !AghanimContinuePanel || !AghanimContinuePanel.BHasClass("VisibleAghanimContinuePanel"))
    {
        return
    }
    const remaining = Math.max(0, Number(endsAt || 0) - Math.max(0, Game.GetGameTime()))
    if (AghanimContinueTimer)
    {
        AghanimContinueTimer.text = String(Math.ceil(remaining))
    }
    if (remaining > 0)
    {
        $.Schedule(0.1, function()
        {
            UpdateAghanimContinueTimer(endsAt, timerToken)
        })
    }
}

function OpenAghanimContinuePrompt(data)
{
    data = data || {}
    AGHANIM_CONTINUE_STATE.local_choice_locked = false
    ApplyAghanimContinueChoiceData(data, true)
    AGHANIM_CONTINUE_TIMER_TOKEN += 1
    if (AghanimContinuePanel)
    {
        AghanimContinuePanel.SetHasClass("VisibleAghanimContinuePanel", true)
    }
    if (AghanimContinueTitle)
    {
        AghanimContinueTitle.SetDialogVariable("index", String(Number(data.killed_index) || 1))
        AghanimContinueTitle.text = $.Localize("#post_stage_aghanim_continue_title", AghanimContinueTitle)
    }
    UpdateAghanimContinueTimer(AGHANIM_CONTINUE_ENDS_AT, AGHANIM_CONTINUE_TIMER_TOKEN)
}

function CloseAghanimContinuePrompt()
{
    AGHANIM_CONTINUE_TOKEN = 0
    AGHANIM_CONTINUE_ENDS_AT = -1
    AGHANIM_CONTINUE_TIMER_TOKEN += 1
    AGHANIM_CONTINUE_STATE = { participant_player_ids: [], responses: {}, local_choice_locked: false }
    UpdateAghanimContinueButtonState()
    if (AghanimContinueVotes)
    {
        AghanimContinueVotes.RemoveAndDeleteChildren()
        AghanimContinueVotes.SetHasClass("VisibleAghanimContinueVotes", false)
    }
    if (AghanimContinuePanel)
    {
        AghanimContinuePanel.SetHasClass("VisibleAghanimContinuePanel", false)
    }
}

function UpdateAghanimContinuePrompt(data)
{
    ApplyAghanimContinueChoiceData(data || {}, false)
}

function SendAghanimContinueChoice(action)
{
    if (AGHANIM_CONTINUE_TOKEN <= 0 || AGHANIM_CONTINUE_STATE.local_choice_locked === true)
    {
        return
    }
    AGHANIM_CONTINUE_STATE.local_choice_locked = true
    UpdateAghanimContinueButtonState()
    GameEvents.SendCustomGameEventToServer("event_player_post_stage_aghanim_continue_choice", {
        token: AGHANIM_CONTINUE_TOKEN,
        action: action || "continue",
    })
}

function NormalizeMatchResultList(list)
{
    return Array.isArray(list) ? list : Object.values(list || {})
}

function FormatMatchResultDuration(seconds)
{
    const safeSeconds = Math.max(0, Math.floor(Number(seconds) || 0))
    const minutes = Math.floor(safeSeconds / 60)
    const secs = safeSeconds - minutes * 60
    return String(minutes).padStart(2, "0") + ":" + String(secs).padStart(2, "0")
}

function RenderMatchResultRewards(parent, rewards)
{
    parent.RemoveAndDeleteChildren()
    const items = GetServicesRewardPopupItemsConfig()
    const rewardGroups = NormalizeMatchResultList(rewards).filter(function(reward) {
        return String(reward && reward.id || "") !== "" && (Number(reward && reward.count) || 0) > 0
    })
    parent.SetHasClass("NoRewards", rewardGroups.length <= 0)

    if (rewardGroups.length <= 0)
    {
        return
    }

    for (let reward of rewardGroups)
    {
        const itemData = items[reward.id] || {}
        const isGenerated = reward.generated === true || reward.generated === 1 || reward.generated === "true"
        const rarity = reward.rarity || itemData.rarity || "common"
        const rewardItem = $.CreatePanel("Panel", parent, "")
        rewardItem.AddClass("MatchResultRewardItem")
        if (rewardGroups.length >= 7)
        {
            rewardItem.style["ui-scale"] = "80%"
        }
        SetServiceItemTooltip(rewardItem, reward.id, isGenerated ? 1 : reward.count, isGenerated ? BuildAghanimEquipmentTooltipExtra(reward) : null)

        const bg = $.CreatePanel("Panel", rewardItem, "")
        bg.AddClass("MatchResultRewardBg")
        if (rarity && rarity !== "common") bg.AddClass("RareColor_" + rarity)

        const icon = $.CreatePanel("Panel", rewardItem, "")
        icon.AddClass("MatchResultRewardIcon")
        SetServicesRewardPopupImage(icon, reward.icon || itemData.icon)

        if (isGenerated) AddSetIconOverlayHud(rewardItem, reward.set_id)

        const count = $.CreatePanel("Label", rewardItem, "")
        count.AddClass("MatchResultRewardCount")
        count.text = isGenerated ? "" : "x" + String(Math.floor(Number(reward.count) || 0))
    }
}

function RenderMatchResultResources(parent, economy)
{
    parent.RemoveAndDeleteChildren()
    const resources = [
        { key: "gold", className: "IconGold" },
        { key: "wood", className: "IconWood" },
        { key: "kills", className: "IconKills" },
    ]
    for (let resource of resources)
    {
        const row = $.CreatePanel("Panel", parent, "")
        row.AddClass("MatchResultResource")

        const icon = $.CreatePanel("Panel", row, "")
        icon.AddClass("MatchResultResourceIcon")
        icon.AddClass(resource.className)

        const label = $.CreatePanel("Label", row, "")
        label.AddClass("MatchResultResourceValue")
        label.text = String(Math.floor(Number(economy && economy[resource.key]) || 0))
    }
}

function OpenMatchResultCards(playerData)
{
    if (!MatchResultCardsPopup || !MatchResultCardsList) return

    const cards = NormalizeMatchResultList(playerData && (playerData.cards || playerData.consumed_cards))
    MatchResultCardsList.RemoveAndDeleteChildren()
    if (MatchResultCardsTitle)
    {
        MatchResultCardsTitle.SetDialogVariable("player", String(Players.GetPlayerName( playerData.player_id )))
        MatchResultCardsTitle.text = $.Localize("#match_result_cards_title", MatchResultCardsTitle)
    }

    if (cards.length <= 0)
    {
        const empty = $.CreatePanel("Label", MatchResultCardsList, "")
        empty.AddClass("MatchResultEmptyCards")
        empty.text = $.Localize("#match_result_no_cards")
    }

    for (let cardData of cards)
    {
        const card = $.CreatePanel("Panel", MatchResultCardsList, "")
        card.AddClass("InventoryCardChild")
        ApplyCardRarityClass(card, GetCardRarity(cardData, GetCardBundleData(cardData)))

        const icon = $.CreatePanel("Image", card, "")
        icon.AddClass("InventoryCardChildImg")
        if (cardData.card_type === "ultimate")
        {
            icon.SetImage("file://{images}/heroes_list/" + String(cardData.card_icon || "") + ".png")
            SetCustomTooltip(card, "ability_tooltip", { ability_name: String(cardData.card_name || "").replace("ultimate_card_", "") })
        }
        else
        {
            icon.SetImage("file://{images}/card_list/" + String(cardData.card_name || "") + ".png")
            SetCustomTooltip(card, "card_tooltip", { card_name: cardData.card_name || "" })
        }
    }

    MatchResultCardsPopup.SetHasClass("VisibleMatchResultCardsPopup", true)
}

function CloseMatchResultCards()
{
    if (MatchResultCardsPopup)
    {
        MatchResultCardsPopup.SetHasClass("VisibleMatchResultCardsPopup", false)
    }
}

function SetLeaderboardStatus(textKey)
{
    if (!LeaderboardStatus) return
    LeaderboardStatus.text = textKey ? $.Localize("#" + textKey) : ""
    LeaderboardStatus.SetHasClass("VisibleLeaderboardStatus", !!textKey)
}

function IsLeaderboardResponseOk(data)
{
    return data && (data.ok === true || data.ok === 1 || data.ok === "1" || data.ok === "true")
}

function FormatLeaderboardDamage(value)
{
    const damage = Math.floor(Number(value) || 0)
    if (damage <= 0)
    {
        return $.Localize("#dummy_leaderboard_no_result")
    }
    return typeof CheckStringDamage === "function" ? CheckStringDamage(damage) : String(damage)
}

function FormatLeaderboardRank(value)
{
    const rank = Math.floor(Number(value) || 0)
    return rank > 0 ? String(rank) : "-"
}

function GetLeaderboardRowRank(row, fallbackRank)
{
    const rank = Math.floor(Number(row && row.rank) || 0)
    if (rank > 0) return rank
    return Math.floor(Number(fallbackRank) || 0)
}

function FormatLeaderboardDate(value)
{
    if (!value) return "-"
    const date = new Date(value)
    if (!date || isNaN(date.getTime())) return "-"

    const day = String(date.getDate()).padStart(2, "0")
    const month = String(date.getMonth() + 1).padStart(2, "0")
    const hours = String(date.getHours()).padStart(2, "0")
    const minutes = String(date.getMinutes()).padStart(2, "0")

    return day + "." + month + " " + hours + ":" + minutes
}

function GetLocalLeaderboardPlayerName()
{
    const playerInfo = Game.GetPlayerInfo(Game.GetLocalPlayerID())
    return String((playerInfo && playerInfo.player_name) || Players.GetPlayerName(Game.GetLocalPlayerID()) || "")
}

function BindLeaderboardProfileTooltip(panel, accountId)
{
    if (!panel) return
    const profileAccountId = Math.floor(Number(accountId) || 0)
    if (profileAccountId <= 0) return
    const profileSteamId = GetLeaderboardSteam64FromAccountId(profileAccountId)
    if (profileSteamId === "") return

    panel.hittest = true

    panel.SetPanelEvent("onmouseover", function()
    {
        $.DispatchEvent("DOTAShowProfileCardTooltip", panel, profileSteamId, false)
    })
    panel.SetPanelEvent("onmouseout", function()
    {
        HideLeaderboardProfileTooltip(panel)
    })
}

function HideLeaderboardProfileTooltip(panel)
{
    $.DispatchEvent("DOTAHideProfileCardTooltip", panel || $.GetContextPanel())
}

function GetLeaderboardSteam64FromAccountId(accountId)
{
    const value = Math.floor(Number(accountId) || 0)
    if (value <= 0) return ""

    const baseHigh = 7656119
    const baseLow = 7960265728
    const lowBase = 10000000000
    const lowSum = baseLow + value
    const high = baseHigh + Math.floor(lowSum / lowBase)
    const low = String(lowSum % lowBase)
    return String(high) + ("0000000000" + low).slice(-10)
}

function CreateLeaderboardAvatar(parent, accountId, className, isSelfLine)
{
    const avatarClass = className || "LeaderboardAvatar"
    const isPodium = avatarClass === "LeaderboardPodiumAvatar"
    const avatar = $.CreatePanel("DOTAAvatarImage", parent, "", {style:"width:100%;height:100%;"})
    avatar.AddClass(avatarClass)
    const numericAccountId = Math.floor(Number(accountId) || 0)
    if (numericAccountId > 0)
    {
        avatar.accountid = numericAccountId
    }
    else if (isSelfLine === true)
    {
        avatar.steamid = "local"
    }
    BindLeaderboardProfileTooltip(avatar, numericAccountId)
    return avatar
}

function CreateLeaderboardPlayerCell(parent, row, isSelfLine)
{
    const playerCell = $.CreatePanel("Panel", parent, "")
    playerCell.AddClass("LeaderboardPlayerCell")

    const playerCellAvatarContainer = $.CreatePanel("Panel", playerCell, "")
    playerCellAvatarContainer.AddClass("playerCellAvatarContainer")

    CreateLeaderboardAvatar(playerCellAvatarContainer, row && row.steam_id, "LeaderboardAvatar", isSelfLine)

    const nameBlock = $.CreatePanel("Panel", playerCell, "")
    nameBlock.AddClass("LeaderboardNameBlock")

    const name = $.CreatePanel("Label", nameBlock, "")
    name.AddClass("LeaderboardPlayerName")
    name.text = String(row && row.player_name || GetLocalLeaderboardPlayerName() || $.Localize("#dummy_leaderboard_unknown_player"))

    if (isSelfLine === true)
    {
        const caption = $.CreatePanel("Label", nameBlock, "")
        caption.AddClass("LeaderboardSelfCaption")
        caption.text = $.Localize("#dummy_leaderboard_self")
    }
}

function RenderLeaderboardRow(parent, row, isSelfLine, selfSteamId, fallbackRank)
{
    if (!parent) return
    const line = $.CreatePanel("Panel", parent, "")
    line.AddClass(isSelfLine ? "LeaderboardSelfRowContent" : "LeaderboardRow")
    const rowSteamId = String(row && row.steam_id || "")
    line.SetHasClass("SelfLeaderboardRow", !isSelfLine && rowSteamId !== "" && rowSteamId === String(selfSteamId || ""))

    const rank = $.CreatePanel("Label", line, "")
    rank.AddClass("LeaderboardRankValue")
    rank.text = FormatLeaderboardRank(GetLeaderboardRowRank(row, fallbackRank))

    CreateLeaderboardPlayerCell(line, row, isSelfLine)

    const damage = $.CreatePanel("Label", line, "")
    damage.AddClass("LeaderboardDamageValue")
    damage.text = FormatLeaderboardDamage(row && row.damage)

    const date = $.CreatePanel("Label", line, "")
    date.AddClass("LeaderboardDateValue")
    date.text = FormatLeaderboardDate(row && row.created_at)
}

function RenderLeaderboardPodiumSlot(row, rank)
{
    const slot = $.CreatePanel("Panel", LeaderboardPodium, "")
    slot.AddClass("LeaderboardPodiumSlot")
    slot.AddClass("Place" + String(rank))

    if (!row)
    {
        return
    }

    const slot_podium_center = $.CreatePanel("Panel", slot, "")
    slot_podium_center.AddClass("slot_podium_center")

    const podium_avatar_container = $.CreatePanel("Panel", slot_podium_center, "")
    podium_avatar_container.AddClass("podium_avatar_container")

    if (rank === 1)
    {
        let podium_fx_particle = $.CreatePanel("DOTAParticleScenePanel", slot, "", {particleName:"particles/item_fx_inventory/item_fx_inventory.vpcf", renderdeferred:"true", particleonly:"false", startActive:"true", cameraOrigin:"160 0 0", lookAt:"0 0 0", fov:"52"})
        podium_fx_particle.AddClass("podium_fx_particle")
        podium_fx_particle.hittest = false
    }

    CreateLeaderboardAvatar(podium_avatar_container, row.steam_id, "LeaderboardPodiumAvatar", false)

    const name = $.CreatePanel("Label", slot_podium_center, "")
    name.AddClass("LeaderboardPodiumName")
    name.text = String(row.player_name || $.Localize("#dummy_leaderboard_unknown_player"))

    const damage = $.CreatePanel("Label", slot_podium_center, "")
    damage.AddClass("LeaderboardPodiumDamage")
    damage.text = FormatLeaderboardDamage(row.damage)
}

function RenderLeaderboardPanel(data)
{
    LEADERBOARD_STATE.loading = false
    LEADERBOARD_STATE.leaderboard = NormalizeMatchResultList(data && data.leaderboard).sort(function(a, b)
    {
        return GetLeaderboardRowRank(a, 999999) - GetLeaderboardRowRank(b, 999999)
    })
    LEADERBOARD_STATE.self = data && data.self || null

    if (LeaderboardPodium) LeaderboardPodium.RemoveAndDeleteChildren()
    if (LeaderboardRows) LeaderboardRows.RemoveAndDeleteChildren()
    if (LeaderboardSelfRow) LeaderboardSelfRow.RemoveAndDeleteChildren()

    if (!IsLeaderboardResponseOk(data))
    {
        SetLeaderboardStatus("dummy_leaderboard_error")
        RenderLeaderboardRow(LeaderboardSelfRow, LEADERBOARD_STATE.self || {}, true, "")
        return
    }

    const rows = LEADERBOARD_STATE.leaderboard
    const selfRow = LEADERBOARD_STATE.self || {}
    const selfSteamId = String(selfRow.steam_id || "")

    if (LeaderboardSelfRow)
    {
        const fallbackSelf = {
            rank: null,
            steam_id: selfSteamId,
            player_name: GetLocalLeaderboardPlayerName(),
            damage: 0,
            created_at: null,
        }
        RenderLeaderboardRow(LeaderboardSelfRow, selfRow && selfRow.steam_id ? selfRow : fallbackSelf, true, selfSteamId)
    }

    if (LeaderboardPodium)
    {
        const byRank = {}
        for (let index = 0; index < rows.length; index++)
        {
            const row = rows[index]
            byRank[String(GetLeaderboardRowRank(row, index + 1))] = row
        }
        RenderLeaderboardPodiumSlot(byRank["2"], 2)
        RenderLeaderboardPodiumSlot(byRank["1"], 1)
        RenderLeaderboardPodiumSlot(byRank["3"], 3)
    }

    if (LeaderboardRows)
    {
        for (let index = 0; index < rows.length; index++)
        {
            const row = rows[index]
            const rank = GetLeaderboardRowRank(row, index + 1)
            if (rank <= 3) continue
            RenderLeaderboardRow(LeaderboardRows, row, false, selfSteamId, rank)
        }
    }

    SetLeaderboardStatus(rows.length <= 0 ? "dummy_leaderboard_empty" : "")
}

function RequestDummyLeaderboard()
{
    LEADERBOARD_STATE.loading = true
    SetLeaderboardStatus("dummy_leaderboard_loading")
    if (LeaderboardPodium) LeaderboardPodium.RemoveAndDeleteChildren()
    if (LeaderboardRows) LeaderboardRows.RemoveAndDeleteChildren()
    if (LeaderboardSelfRow) LeaderboardSelfRow.RemoveAndDeleteChildren()
    GameEvents.SendCustomGameEventToServer("event_player_request_dummy_leaderboard", {})
}

function OpenLeaderboardPanel()
{
    if (!LeaderboardPanel) return
    if (LeaderboardPanel.BHasClass("VisibleLeaderboardPanel"))
    {
        CloseLeaderboardPanel()
        return
    }
    CloseMatchResultPanel()
    CloseMatchResultCards()
    CloseAnothersPanels()
    LeaderboardPanel.SetHasClass("VisibleLeaderboardPanel", true)
    RequestDummyLeaderboard()
}

function CloseLeaderboardPanel()
{
    HideLeaderboardProfileTooltip(LeaderboardPanel)
    if (LeaderboardPanel)
    {
        LeaderboardPanel.SetHasClass("VisibleLeaderboardPanel", false)
    }
}

function CloseAnothersPanels()
{
    if (!AnothersPanels) return
    let leaving_chests = false
    for (let child of AnothersPanels.Children())
    {
        if (child.BHasClass("WindowVisible"))
        {
            if (child.id == "ChestsWindow")
            {
                leaving_chests = true
            }
            child.SetHasClass("WindowVisible", false)
        }
    }
    if (leaving_chests)
    {
        if (typeof Game.StopChestMusic === "function")
        {
            Game.StopChestMusic()
        }
        GameEvents.SendCustomGameEventToServer("event_services_flush_deferred_sync", {})
    }
}

function SetMatchResultTopButtonVisible(visible)
{
    if (MatchResultTopButton)
    {
        MatchResultTopButton.SetHasClass("HiddenMatchResultTopButton", visible !== true)
    }
}

function RenderMatchResultDamage(parent, playerData, allDamageGlobal)
{
    parent.RemoveAndDeleteChildren()

    const total = Number(playerData.damage_total || playerData.damage) || 0
    const physical = Number(playerData.damage_physical) || 0
    const magical = Number(playerData.damage_magical) || 0
    const totalShare = allDamageGlobal > 0 ? Math.max(0, Math.min(100, total / allDamageGlobal * 100)) : 0
    const physicalShare = total > 0 ? Math.max(0, Math.min(100, physical / total * 100)) : 0
    const magicalShare = total > 0 ? Math.max(0, Math.min(100, magical / total * 100)) : 0

    const damageLabel = $.CreatePanel("Label", parent, "")
    damageLabel.AddClass("MatchResultDamageValue")
    damageLabel.text = CheckStringDamage(Math.floor(total))

    const line = $.CreatePanel("Panel", parent, "")
    line.AddClass("MatchResultDamageLine")

    const back = $.CreatePanel("Panel", line, "")
    back.AddClass("MatchResultDamageLineBack")

    const frontList = $.CreatePanel("Panel", line, "")
    frontList.AddClass("MatchResultDamageLineFrontList")
    frontList.style.width = totalShare.toFixed(3) + "%"

    const frontPhys = $.CreatePanel("Panel", frontList, "")
    frontPhys.AddClass("MatchResultDamageLineFrontPhysical")
    frontPhys.style.width = physicalShare.toFixed(3) + "%"

    const frontMag = $.CreatePanel("Panel", frontList, "")
    frontMag.AddClass("MatchResultDamageLineFrontMagical")
    frontMag.style.width = magicalShare.toFixed(3) + "%"

    const fx = $.CreatePanel("Panel", line, "")
    fx.AddClass("MatchResultDamageLineFx")

    const percent = $.CreatePanel("Label", line, "")
    percent.AddClass("MatchResultDamagePercent")
    percent.text = totalShare.toFixed(1) + "%"
}

function RenderMatchResultRows(players)
{
    if (!MatchResultRows) return

    MatchResultRows.RemoveAndDeleteChildren()
    const rows = NormalizeMatchResultList(players).sort(function(a, b) {
        if ((a && a.mvp) && !(b && b.mvp)) return -1
        if (!(a && a.mvp) && (b && b.mvp)) return 1
        return (Number(b && b.damage) || 0) - (Number(a && a.damage) || 0)
    })
    const allDamageGlobal = rows.reduce(function(total, row) {
        return total + (Number(row && (row.damage_total || row.damage)) || 0)
    }, 0)

    for (let playerData of rows)
    {
        const playerId = Number(playerData.player_id)
        const playerInfo = Game.GetPlayerInfo(playerId)
        const row = $.CreatePanel("Panel", MatchResultRows, "MatchResultRow_" + playerId)
        row.AddClass("MatchResultRow")
        const row_border = $.CreatePanel("Panel", row, "")
        row_border.AddClass("MatchResultRowBorder")
        row.SetHasClass("MvpRow", playerData.mvp === true || playerData.mvp === 1)

        const playerCell = $.CreatePanel("Panel", row, "")
        playerCell.AddClass("MatchResultPlayerCell")
        const isMvp = playerData.mvp === true || playerData.mvp === 1
        const mvpBadge = $.CreatePanel("Panel", playerCell, "")
        mvpBadge.AddClass("MatchResultMvpBadge")
        mvpBadge.SetHasClass("VisibleMvpBadge", isMvp)

        const steamId = playerInfo && playerInfo.player_steamid ? playerInfo.player_steamid : "local"
        const avatar = $.CreatePanel("DOTAAvatarImage", playerCell, "", {
            steamid: steamId,
            style: "width: 46px; height: 46px; vertical-align: center; margin-right: 8px;"
        })
        avatar.AddClass("MatchResultAvatar")
        avatar.steamid = steamId

        const nameBlock = $.CreatePanel("Panel", playerCell, "")
        nameBlock.AddClass("MatchResultNameBlock")
        const name = $.CreatePanel("Label", nameBlock, "")
        name.AddClass("MatchResultPlayerName")
        name.text = String(playerData.player_name || Players.GetPlayerName(playerId) || "")

        const level = $.CreatePanel("Label", row, "")
        level.AddClass("MatchResultLevel")
        level.text = $.Localize("#match_result_level_prefix") + String(Math.floor(Number(playerData.hero_level) || 0))

        const resources = $.CreatePanel("Panel", row, "")
        resources.AddClass("MatchResultResources")
        RenderMatchResultResources(resources, playerData.economy || {})

        const damage = $.CreatePanel("Panel", row, "")
        damage.AddClass("MatchResultDamage")
        RenderMatchResultDamage(damage, playerData, allDamageGlobal)

        const rewards = $.CreatePanel("Panel", row, "")
        rewards.AddClass("MatchResultRewards")
        RenderMatchResultRewards(rewards, playerData.rewards || [])

        const cardsButton = $.CreatePanel("Panel", row, "")
        cardsButton.AddClass("MatchResultCardsButton")
        const cardsCount = NormalizeMatchResultList(playerData.cards || playerData.consumed_cards).length
        cardsButton.SetHasClass("NoCards", cardsCount <= 0)
        if (cardsCount > 0)
        {
            cardsButton.SetPanelEvent("onactivate", function() { OpenMatchResultCards(playerData) })
        }

        const cardsLabel = $.CreatePanel("Label", cardsButton, "")
        cardsLabel.AddClass("MatchResultCardsButtonLabel")
        cardsLabel.text = $.Localize("#match_result_cards_view")
    }
}

function OpenMatchResultPanel(data)
{
    CloseLeaderboardPanel()
    MATCH_RESULT_STATE = data || { players: [] }
    MATCH_RESULT_RENDERED = false
    CloseMatchResultCards()

    if (MatchResultTitle)
    {
        const isWin = MATCH_RESULT_STATE.result === "win"
        MatchResultTitle.text = $.Localize(isWin ? "#match_result_victory" : "#match_result_defeat")
        MatchResultTitle.SetHasClass("DefeatTitle", !isWin)
    }
    const isInfinityMode = String(MATCH_RESULT_STATE.game_mode || "") === "infinity"
    if (MatchResultStage)
    {
        MatchResultStage.text = isInfinityMode
            ? $.Localize("#infinity_mode_title")
            : String(MATCH_RESULT_STATE.stage_id || "")
    }
    if (MatchResultDuration)
    {
        MatchResultDuration.text = isInfinityMode && typeof FormatInfinityTime === "function"
            ? FormatInfinityTime(MATCH_RESULT_STATE.duration)
            : FormatMatchResultDuration(MATCH_RESULT_STATE.duration)
    }

    RenderMatchResultRows(MATCH_RESULT_STATE.players)
    MATCH_RESULT_RENDERED = true
    SetMatchResultTopButtonVisible(true)

    if (MatchResultPanel)
    {
        MatchResultPanel.SetHasClass("VisibleMatchResultPanel", true)
    }

    if (SpawnChallengersPanel)
    {
        SpawnChallengersPanel.SetHasClass("GameOver", true)
    }
}

function OpenCachedMatchResultPanel()
{
    CloseLeaderboardPanel()
    if (!MATCH_RESULT_STATE || !MATCH_RESULT_STATE.players)
    {
        return
    }

    CloseMatchResultCards()

    if (MATCH_RESULT_RENDERED !== true)
    {
        OpenMatchResultPanel(MATCH_RESULT_STATE)
        return
    }

    if (MatchResultPanel)
    {
        MatchResultPanel.SetHasClass("VisibleMatchResultPanel", true)
    }
}

function CloseMatchResultPanel()
{
    CloseMatchResultCards()
    if (MatchResultPanel)
    {
        MatchResultPanel.SetHasClass("VisibleMatchResultPanel", false)
    }
}

function InitPostStageActivityPanels()
{
    BuildPostStageActivityMenu()
    ApplyPostStageActivityState(Game.GetCustomTable("post_stage_activity_state", "global"))

    if (PostStageHomeConfirmButton)
    {
        PostStageHomeConfirmButton.SetPanelEvent("onactivate", function()
        {
            GameEvents.SendCustomGameEventToServer("event_player_confirm_post_stage_home", {})
        })
    }

    if (PostStageHomeCancelButton)
    {
        PostStageHomeCancelButton.SetPanelEvent("onactivate", function()
        {
            ClosePostStageHomePanel()
            UnFocusUI()
        })
    }

    if (PostStageRestartConfirmButton)
    {
        PostStageRestartConfirmButton.SetPanelEvent("onactivate", function()
        {
            ClosePostStageRestartConfirmPanel()
            const eventName = START_GAME_AFK_EXIT_MODE
                ? "event_player_confirm_afk_exit"
                : "event_player_confirm_post_stage_restart"
            GameEvents.SendCustomGameEventToServer(eventName, {
                difficult: SAVED_CHOOSE_DIFFICULT,
                floor: SAVED_CHOOSE_FLOOR,
                game_mode: SAVED_CHOOSE_GAME_MODE,
            })
            CloseStartGame()
            UnFocusUI()
        })
    }

    if (PostStageRestartCancelButton)
    {
        PostStageRestartCancelButton.SetPanelEvent("onactivate", function()
        {
            ClosePostStageRestartConfirmPanel()
        })
    }

    if (AghanimRewardConfirmButton)
    {
        AghanimRewardConfirmButton.SetPanelEvent("onactivate", ConfirmAghanimRewards)
    }

    if (AghanimContinueButton)
    {
        AghanimContinueButton.SetPanelEvent("onactivate", function()
        {
            SendAghanimContinueChoice("continue")
        })
    }

    if (AghanimLeaveButton)
    {
        AghanimLeaveButton.SetPanelEvent("onactivate", function()
        {
            SendAghanimContinueChoice("leave")
        })
    }

    if (MatchResultDim)
    {
        MatchResultDim.SetPanelEvent("onactivate", function()
        {
            CloseMatchResultPanel()
        })
    }

    if (MatchResultCardsCloseButton)
    {
        MatchResultCardsCloseButton.SetPanelEvent("onactivate", function()
        {
            CloseMatchResultCards()
        })
    }

    if (StartGameRestartCloseButton)
    {
        StartGameRestartCloseButton.SetPanelEvent("onactivate", function()
        {
            if (!START_GAME_RESTART_MODE) { return }
            CloseStartGame()
            UnFocusUI()
        })
    }
}

function CreateNeutralRoshanBonusIcon(parent, option)
{
    const icon_path = (option && option.icon_path) || NEUTRAL_ROSHAN_BONUS_ICONS[option && option.bonus_id] || "file://{images}/game_hud/icons/closed.png"

    let IconPanel = $.CreatePanel("Image", parent, "")
    IconPanel.AddClass("NeutralRoshanBonusIcon")
    IconPanel.hittest = false
    IconPanel.SetImage(icon_path)
}

function CreateNeutralRoshanBonusCostRow(parent, option)
{
    if (!parent || !option || option.kills_cost == null)
    {
        return
    }

    let CostRow = $.CreatePanel("Panel", parent, "")
    CostRow.AddClass("NeutralRoshanBonusCostRow")

    let CostIcon = $.CreatePanel("Panel", CostRow, "")
    CostIcon.AddClass("NeutralRoshanBonusCostIcon")

    let CostLabel = $.CreatePanel("Label", CostRow, "")
    CostLabel.AddClass("NeutralRoshanBonusCostLabel")
    CostLabel.text = String(Math.floor(Number(option.kills_cost || 0)))
}

function IsCursorInsidePanel(panel)
{
    if (!panel || !panel.IsValid())
    {
        return false
    }

    const cursor = GameUI.GetCursorPosition()
    const panelPosition = panel.GetPositionWithinWindow()
    const panelWidth = panel.actuallayoutwidth || 0
    const panelHeight = panel.actuallayoutheight || 0

    return cursor[0] >= panelPosition.x &&
        cursor[0] <= panelPosition.x + panelWidth &&
        cursor[1] >= panelPosition.y &&
        cursor[1] <= panelPosition.y + panelHeight
}

function IsCardSelectorPending()
{
    return Boolean(
        (PanelChooseBodyCard && PanelChooseBodyCard.BHasClass("OpenCardPanel")) ||
        (PanelReplaceCard && PanelReplaceCard.BHasClass("IsOpenedReplace"))
    )
}

function SetCardSelectorCollapsed(collapsed)
{
    if (!PanelChooseCard)
    {
        return
    }

    const shouldCollapse = collapsed === true && IsCardSelectorPending()
    PanelChooseCard.SetHasClass("CollapsedCardSelector", shouldCollapse)

    if (shouldCollapse)
    {
        const replaceCardId = PanelReplaceCard && PanelReplaceCard.BHasClass("IsOpenedReplace") ? CARD_SELECTOR_PENDING_REPLACE_CARD_ID : null
        GameEvents.SendCustomGameEventToServer("event_player_hide_card_selector", {replace_card_id: replaceCardId})
        PanelChooseBodyCard.SetHasClass("OpenCardPanel", false)
    }
}

function SetArtefactSelectorCollapsed(collapsed)
{
    if (!ArtefactSelectorPanel)
    {
        return
    }

    const shouldCollapse = collapsed === true && ArtefactSelectorPanel.BHasClass("OpenArtefactSelectorPanel")
    ArtefactSelectorPanel.SetHasClass("CollapsedArtefactSelector", shouldCollapse)

    if (ArtefactSelectorBody)
    {
        ArtefactSelectorBody.hittest = !shouldCollapse
    }

    if (ArtefactSelectorRestoreButtons)
    {
        ArtefactSelectorRestoreButtons.visible = shouldCollapse
    }
}

function OpenNeutralRoshanBonusPanel(data)
{
    if (!NeutralRoshanBonusPanel || !NeutralRoshanBonusList)
    {
        return
    }

    NeutralRoshanBonusList.RemoveAndDeleteChildren()
    NeutralRoshanBonusPanel.SetHasClass("OpenNeutralRoshanBonusPanel", true)
    NeutralRoshanBonusPanel.SetHasClass("IsPostStageDisabled", IsPostStageTrialsDisabled())

    if (NeutralRoshanBonusProgress)
    {
        const meritCurrent = Math.floor(Number(data && data.merit_current || 0))
        UpdateNeutralRoshanBonusProgress(meritCurrent)
    }

    const options = Object.values(data && data.options || {})
    const postStageDisabled = IsPostStageTrialsDisabled()
    for (const option of options)
    {
        let OptionPanel = $.CreatePanel("Panel", NeutralRoshanBonusList, "")
        OptionPanel.AddClass("NeutralRoshanBonusOption")
        OptionPanel._neutralRoshanBaseDisabled = option && option.is_disabled == true
        OptionPanel._neutralRoshanNeedsProgress = option && option.needs_merit == true
        const isProgressDisabled = OptionPanel._neutralRoshanNeedsProgress && Math.floor(Number(data && data.merit_current || 0)) < 2000
        OptionPanel._neutralRoshanProgressDisabled = isProgressDisabled
        const isDisabled = postStageDisabled || OptionPanel._neutralRoshanBaseDisabled || isProgressDisabled
        OptionPanel.SetHasClass("DisabledBonus", isDisabled)

        CreateNeutralRoshanBonusIcon(OptionPanel, option)

        let OptionTitle = $.CreatePanel("Label", OptionPanel, "")
        OptionTitle.AddClass("NeutralRoshanBonusOptionTitle")
        OptionTitle.text = $.Localize("#" + option.title_key)
        CreateNeutralRoshanBonusCostRow(OptionPanel, option)

        OptionPanel.SetPanelEvent("onmouseover", function()
        {
            OptionPanel.SetHasClass("HoveredBonus", true)
            ShowNeutralRoshanBonusTooltip(OptionPanel, option)
        })

        OptionPanel.SetPanelEvent("onmouseout", function()
        {
            OptionPanel.SetHasClass("HoveredBonus", false)
            HideNeutralRoshanBonusTooltip(OptionPanel)
        })

        OptionPanel.SetPanelEvent("onactivate", function()
        {
            if (IsPostStageTrialsDisabled() || OptionPanel.BHasClass("DisabledBonus"))
            {
                return
            }

            GameEvents.SendCustomGameEventToServer("event_player_select_neutral_roshan_bonus", {bonus_id: option.bonus_id})
            UnFocusUI()
        })
    }

}

function CloseNeutralRoshanArtefactSelector()
{
    if (!ArtefactSelectorPanel)
    {
        return
    }

    SetArtefactSelectorCollapsed(false)
    ArtefactSelectorPanel.SetHasClass("OpenArtefactSelectorPanel", false)
    if (ArtefactSelectorList)
    {
        ArtefactSelectorList.RemoveAndDeleteChildren()
    }
}

function OpenNeutralRoshanArtefactSelector(data)
{
    if (!ArtefactSelectorPanel || !ArtefactSelectorList)
    {
        return
    }

    ArtefactSelectorList.RemoveAndDeleteChildren()
    ArtefactSelectorPanel.SetHasClass("OpenArtefactSelectorPanel", true)
    ArtefactSelectorPanel.SetHasClass("IsPostStageDisabled", false)
    SetArtefactSelectorCollapsed(false)

    const options = Object.values(data && data.options || {})
    for (const option of options)
    {
        let OptionPanel = $.CreatePanel("Panel", ArtefactSelectorList, "")
        OptionPanel.AddClass("ArtefactSelectorOption")

        let IconPanel = $.CreatePanel("Image", OptionPanel, "")
        IconPanel.AddClass("ArtefactSelectorIcon")
        IconPanel.SetImage(option.icon_path || "file://{images}/abilities/levelup_upgrade_artifacts_0.png")

        let ChoiceKind = $.CreatePanel("Label", OptionPanel, "")
        ChoiceKind.AddClass("ArtefactSelectorChoiceKind")
        ChoiceKind.text = $.Localize("#neutral_roshan_artefact_choice_" + option.choice_kind)

        let TitlePanel = $.CreatePanel("Label", OptionPanel, "")
        TitlePanel.AddClass("ArtefactSelectorTitle")
        TitlePanel.text = $.Localize("#" + option.title_key)

        let LevelPanel = $.CreatePanel("Label", OptionPanel, "")
        LevelPanel.AddClass("ArtefactSelectorLevel")
        LevelPanel.text = $.Localize("#neutral_roshan_artefact_proc_level_prefix") + " " + String(Math.floor(Number(option.proc_level || 1)))

        let DescriptionPanel = $.CreatePanel("Label", OptionPanel, "")
        DescriptionPanel.AddClass("ArtefactSelectorDescription")
        DescriptionPanel.html = true
        for (let key of Object.keys(option.proc_params || {}))
        {
            DescriptionPanel.SetDialogVariable(key, "<b><font color=\"gold\">" + String(FormatPrecisionValue(option.proc_params[key])) + "</font></b>")
        }
        DescriptionPanel.text = $.Localize("#" + option.description_key, DescriptionPanel)

        OptionPanel.SetPanelEvent("onactivate", function()
        {
            GameEvents.SendCustomGameEventToServer("event_player_select_neutral_roshan_artefact_option", {
                artefact_id: option.artefact_id,
                choice_kind: option.choice_kind,
            })
            UnFocusUI()
        })
    }

    if (ArtefactSelectorRerollInfo)
    {
        ArtefactSelectorRerollInfo.SetDialogVariable("value", "<b><font color=\"gold\">" + String(Math.floor(Number(data?.rerolls_left || 0))) + "</font></b>")
        ArtefactSelectorRerollInfo.text = $.Localize("#neutral_roshan_artefact_rerolls", ArtefactSelectorRerollInfo)
    }

    if (ArtefactSelectorRerollButton)
    {
        ArtefactSelectorRerollButton._neutralRoshanBaseDisabled = Number(data?.rerolls_left || 0) <= 0
        ArtefactSelectorRerollButton.SetHasClass("DisabledBonus", ArtefactSelectorRerollButton._neutralRoshanBaseDisabled === true)
        ArtefactSelectorRerollButton.SetPanelEvent("onactivate", function()
        {
            if (ArtefactSelectorRerollButton._neutralRoshanBaseDisabled === true)
            {
                return
            }
            GameEvents.SendCustomGameEventToServer("event_player_reroll_neutral_roshan_artefact_selector", {})
            UnFocusUI()
        })
    }
}

function RegisterNeutralRoshanMouseHandler()
{
    if (!GameUI.SetMouseCallback)
    {
        return
    }

    GameUI.SetMouseCallback(function(eventName, arg)
    {
        if (eventName !== "pressed" || arg !== 0)
        {
            return false
        }

        if (NeutralRoshanBonusPanel && NeutralRoshanBonusPanel.BHasClass("OpenNeutralRoshanBonusPanel"))
        {
            if (eventName === "pressed" && arg === 0 && !IsCursorInsidePanel(NeutralRoshanBonusBody))
            {
                CloseNeutralRoshanBonusPanel()
                UnFocusUI()
            }
            return false
        }

        if (PostStageActivityPanel && PostStageActivityPanel.BHasClass("OpenPostStageActivityPanel"))
        {
            if (!IsCursorInsidePanel(PostStageActivityBody))
            {
                ClosePostStageActivityPanel()
                UnFocusUI()
            }
            return false
        }

        if (PostStageHomePanel && PostStageHomePanel.BHasClass("OpenPostStageHomePanel"))
        {
            if (!IsCursorInsidePanel(PostStageHomeBody))
            {
                ClosePostStageHomePanel()
                UnFocusUI()
            }
            return false
        }

        if (LeaderboardPanel && LeaderboardPanel.BHasClass("VisibleLeaderboardPanel"))
        {
            if (!IsCursorInsidePanel(LeaderboardBody))
            {
                CloseLeaderboardPanel()
                UnFocusUI()
            }
            return false
        }

        if (ArtefactSelectorPanel && ArtefactSelectorPanel.BHasClass("OpenArtefactSelectorPanel"))
        {
            return false
        }

        if (GameUI.GetClickBehaviors && GameUI.GetClickBehaviors() !== 0)
        {
            return false
        }

        const cursorPosition = GameUI.GetCursorPosition()
        const screenEntities = GameUI.FindScreenEntities ? GameUI.FindScreenEntities(cursorPosition) : []

        const afkState = Game.GetCustomTable("afk_mode_state", String(Game.GetLocalPlayerID()))
        if (afkState && IsTruthyEventValue(afkState.active))
        {
            const exitEntindex = Number(afkState.exit_entindex || -1)
            for (const screenEntity of screenEntities || [])
            {
                const entityIndex = Number(screenEntity.entityIndex || screenEntity.entindex || -1)
                if (entityIndex === exitEntindex && Entities.GetUnitName(entityIndex) === "npc_levelup_poststage_restart_unit")
                {
                    GameEvents.SendCustomGameEventToServer("event_player_request_afk_exit_panel", {exit_entindex: entityIndex})
                    return false
                }
            }
        }

        const postStageState = Game.GetCustomTable("post_stage_activity_state", "global")
        if (postStageState)
        {
            const selectorEntindex = Number(postStageState.selector_entindex || -1)
            const backEntindex = Number(postStageState.back_entindex || -1)
            const restartEntindex = Number(postStageState.restart_entindex || -1)
            for (const screenEntity of screenEntities || [])
            {
                const entityIndex = Number(screenEntity.entityIndex || screenEntity.entindex || -1)
                if (entityIndex === selectorEntindex && Entities.GetUnitName(entityIndex) === "npc_levelup_poststage_activity_selector")
                {
                    GameEvents.SendCustomGameEventToServer("event_player_request_post_stage_activity_panel", {selector_entindex: entityIndex})
                    return false
                }
                if (entityIndex === backEntindex && Entities.GetUnitName(entityIndex) === "npc_levelup_poststage_back_unit")
                {
                    GameEvents.SendCustomGameEventToServer("event_player_request_post_stage_home_panel", {back_entindex: entityIndex})
                    return false
                }
                if (entityIndex === restartEntindex && Entities.GetUnitName(entityIndex) === "npc_levelup_poststage_restart_unit")
                {
                    GameEvents.SendCustomGameEventToServer("event_player_request_post_stage_restart_panel", {restart_entindex: entityIndex})
                    return false
                }
            }
        }

        const state = Game.GetCustomTable("neutral_roshan_state", String(Game.GetLocalPlayerID()))
        if (!state)
        {
            return false
        }

        const roshanEntindex = Number(state.roshan_entindex || -1)
        if (roshanEntindex < 0)
        {
            return false
        }
        for (const screenEntity of screenEntities || [])
        {
            const entityIndex = Number(screenEntity.entityIndex || screenEntity.entindex || -1)
            if (entityIndex !== roshanEntindex)
            {
                continue
            }

            if (Entities.GetUnitName(entityIndex) !== "npc_levelup_neutral_camp_roshan")
            {
                continue
            }

            GameEvents.SendCustomGameEventToServer("event_player_request_neutral_roshan_bonus_panel", {roshan_entindex: entityIndex})
            break
        }

        return false
    })
}

// Полная логика UI с картами
function OpenCardPanel(data)
{
    ChooseCardList.RemoveAndDeleteChildren()
    if (PanelReplaceCardData)
    {
        PanelReplaceCardData.RemoveAndDeleteChildren()
    }
    CARD_SELECTOR_PENDING_REPLACE_CARD_ID = null
    PanelChooseBodyCard.visible = true
    PanelReplaceCard.visible = false
    PanelReplaceCard.SetHasClass("IsOpenedReplace", false)
    PanelChooseBodyCard.SetHasClass("OpenCardPanel", true)
    SetCardSelectorCollapsed(false)
    let bundles_data = data.bundles_data
    let updates_card_counter = data.updates_card_counter
    let current_card_list = data.current_card_list
    let card_counter_object = Object.values(data.card_list)
    PanelChooseBodyCard.SetHasClass("MoreCardSelection", card_counter_object && card_counter_object.length > 3)
    for (let card_id in card_counter_object)
    {
        let card_data = card_counter_object[card_id]
        let bundle_data = bundles_data[card_data.bundle_name] || GetCardBundleData(card_data)
        let card_rarity = GetCardRarity(card_data, bundle_data)

        let ChooseCardBase = $.CreatePanel("Panel", ChooseCardList, "")
        ChooseCardBase.AddClass("ChooseCardBase")

        let ChooseCardBaseBG = $.CreatePanel("Panel", ChooseCardBase, "")
        ChooseCardBaseBG.AddClass("ChooseCardBaseBG")

        let ChooseCardBaseBG2 = $.CreatePanel("Panel", ChooseCardBase, "")
        ChooseCardBaseBG2.AddClass("ChooseCardBaseBG2")

        let ChooseCardBaseBorder = $.CreatePanel("Panel", ChooseCardBase, "")
        ChooseCardBaseBorder.AddClass("ChooseCardBaseBorder")

        $.CreatePanel("DOTAParticleScenePanel", ChooseCardBase, "", 
        { 
            style: "width:100%;height:100%;",
            class: "CardBasePFXBorder",
            particleName: "particles/card_border/card_border.vpcf", 
            particleonly:"true", 
            startActive:"true", 
            cameraOrigin:"0 0 550", 
            lookAt:"0 0 0",  
            fov:"110", 
            squarePixels:"true",
            hittest: "false"
        });

        $.CreatePanel("DOTAParticleScenePanel", ChooseCardBaseBG, "", 
        { 
            style: "width:100%;height:100%;",
            class: "CardBasePFX",
            particleName: "particles/card_bg/card_bg.vpcf", 
            particleonly:"true", 
            startActive:"true", 
            cameraOrigin:"0 0 550", 
            lookAt:"0 0 0",  
            fov:"64", 
            squarePixels:"true",
            hittest: "false"
        });

        ApplyCardRarityClass(ChooseCardBase, card_rarity)

        let ChooseCardBaseImage = $.CreatePanel("Image", ChooseCardBase, "")
        ChooseCardBaseImage.AddClass("ChooseCardBaseImage")
        ChooseCardBaseImage.SetImage("file://{images}/card_list/" + card_data.card_name + ".png")
        ApplyCardRarityClass(ChooseCardBaseImage, card_rarity)

        let ChooseCardBaseName = $.CreatePanel("Label", ChooseCardBase, "")
        ChooseCardBaseName.AddClass("ChooseCardBaseName")
        ChooseCardBaseName.text = $.Localize("#"+card_data.card_name)

        if (bundle_data)
        {
            let ChooseCardBaseBundleData = $.CreatePanel("Panel", ChooseCardBase, "")
            ChooseCardBaseBundleData.AddClass("ChooseCardBaseBundleData")

            let ChooseCardBaseBundleDataName = $.CreatePanel("Label", ChooseCardBaseBundleData, "")
            ChooseCardBaseBundleDataName.AddClass("ChooseCardBaseBundleDataName")
            ChooseCardBaseBundleDataName.text = $.Localize("#"+card_data.bundle_name)
            ApplyCardRarityClass(ChooseCardBaseBundleDataName, card_rarity)

            let ChooseCardBaseBundleDataCounter = $.CreatePanel("Label", ChooseCardBaseBundleData, "")
            ChooseCardBaseBundleDataCounter.AddClass("ChooseCardBaseBundleDataCounter")
            ChooseCardBaseBundleDataCounter.text = bundle_data.cards_counter_have + "/" + Object.values(bundle_data.card_list).length
        }

        let Limer = $.CreatePanel("Panel", ChooseCardBase, "")
        Limer.AddClass("Limer")

        let ChooseCardBaseBonusListPanel = $.CreatePanel("Panel", ChooseCardBase, "")
        ChooseCardBaseBonusListPanel.AddClass("ChooseCardBaseBonusListPanel")
        ChooseCardBaseBonusListPanel.visible = false

        let ChooseCardBaseEffectsListPanel = $.CreatePanel("Panel", ChooseCardBase, "")
        ChooseCardBaseEffectsListPanel.AddClass("ChooseCardBaseEffectsListPanel")

        if (card_data.kills_consumed_data)
        {
            let consumed_data = card_data.kills_consumed_data
            ChooseCardBaseBonusListPanel.visible = true
            let ChooseCardBaseBonusLine = $.CreatePanel("Panel", ChooseCardBaseBonusListPanel, "")
            ChooseCardBaseBonusLine.AddClass("ChooseCardBaseBonusLine")
            ChooseCardBaseBonusLine.SetDialogVariable("kills_counter", "<b><font color=\"gold\">" + String(consumed_data.kills_counter) + "</font></b>");

            for (let key of Object.keys(consumed_data || {}))
            {
                let value = consumed_data[key]
                if (typeof value == "number" || typeof value == "string")
                {
                    ChooseCardBaseBonusLine.SetDialogVariable(key, "<b><font color=\"gold\">" + String(FormatHudCardValue(value)) + "</font></b>");
                }
            }

            if (consumed_data.bonus_list)
            {
                for (let bonus_name of Object.keys(consumed_data.bonus_list || {}))
                {
                    let bonus_list = consumed_data.bonus_list[bonus_name]
                    if (bonus_name == "stats" || bonus_name == "currency")
                    {
                        for (let bonus_list_key in bonus_list)
                        {
                            let bonus_value = bonus_list[bonus_list_key]
                            ChooseCardBaseBonusLine.SetDialogVariable(bonus_list_key, "<b><font color=\"gold\">" + String(FormatHudCardValue(bonus_value[1])) + "</font></b>");
                        }
                    }
                }
            }
            
            let ChooseCardBaseBonusPin = $.CreatePanel("Panel", ChooseCardBaseBonusLine, "")
            ChooseCardBaseBonusPin.AddClass("ChooseCardBaseBonusPin")

            let ChooseCardBaseBonusLabel = $.CreatePanel("Label", ChooseCardBaseBonusLine, "")
            ChooseCardBaseBonusLabel.AddClass("ChooseCardBaseBonusLabel")
            ChooseCardBaseBonusLabel.html = true
            ChooseCardBaseBonusLabel.text = $.Localize("#" + card_data.card_name + "_consumed_kills_description", ChooseCardBaseBonusLine)
        }

        for (let bonus_name of Object.keys(card_data.bonus_list || {}))
        {
            let bonus_list = card_data.bonus_list[bonus_name]
            if (bonus_name == "stats" || bonus_name == "currency" || bonus_name == "summon_aura")
            {
                for (let bonus_list_key of Object.keys(bonus_list))
                {
                    let label_name = bonus_list_key
                    let bonus_list_data = bonus_list[bonus_list_key]
                    let value = bonus_list_data
                    if (typeof bonus_list_data == "object")
                    {
                        value = bonus_list_data[1]
                        label_name = bonus_list_data[2] + "_" + label_name
                    }
                    value = FormatHudCardValue(value)
                    ChooseCardBaseBonusListPanel.visible = true
                    let ChooseCardBaseBonusLine = $.CreatePanel("Panel", ChooseCardBaseBonusListPanel, "")
                    ChooseCardBaseBonusLine.AddClass("ChooseCardBaseBonusLine")
                    ChooseCardBaseBonusLine.SetDialogVariable("value", "<b><font color=\"gold\">" + String(value) + "</font></b>");

                    let ChooseCardBaseBonusPin = $.CreatePanel("Panel", ChooseCardBaseBonusLine, "")
                    ChooseCardBaseBonusPin.AddClass("ChooseCardBaseBonusPin")

                    let ChooseCardBaseBonusLabel = $.CreatePanel("Label", ChooseCardBaseBonusLine, "")
                    ChooseCardBaseBonusLabel.AddClass("ChooseCardBaseBonusLabel")
                    ChooseCardBaseBonusLabel.html = true
                    const localization_prefix = bonus_name == "summon_aura" ? "#levelup_card_summon_aura_" : "#levelup_card_stats_"
                    ChooseCardBaseBonusLabel.text = $.Localize(localization_prefix + label_name, ChooseCardBaseBonusLine)
                }
            }
            else if (bonus_name == "unique_effects")
            {
                for (let effect_key of Object.keys(bonus_list))
                {
                    let effect_list_data = bonus_list[effect_key]

                    let ChooseCardBaseEffectPanel = $.CreatePanel("Panel", ChooseCardBaseEffectsListPanel, "")
                    ChooseCardBaseEffectPanel.AddClass("ChooseCardBaseEffectPanel")

                    let ChooseCardBaseEffectPanelHeader = $.CreatePanel("Panel", ChooseCardBaseEffectPanel, "")
                    ChooseCardBaseEffectPanelHeader.AddClass("ChooseCardBaseEffectPanelHeader")

                    let ChooseCardBaseEffectPanelName = $.CreatePanel("Label", ChooseCardBaseEffectPanelHeader, "")
                    ChooseCardBaseEffectPanelName.AddClass("ChooseCardBaseEffectPanelName")
                    ChooseCardBaseEffectPanelName.text = $.Localize("#" + effect_list_data.effect_id + "_name")

                    let ChooseCardBaseEffectPanelCooldownPanel = $.CreatePanel("Panel", ChooseCardBaseEffectPanelHeader, "")
                    ChooseCardBaseEffectPanelCooldownPanel.AddClass("ChooseCardBaseEffectPanelCooldownPanel")

                    let ChooseCardBaseEffectPanelCooldownIcon = $.CreatePanel("Panel", ChooseCardBaseEffectPanelCooldownPanel, "")
                    ChooseCardBaseEffectPanelCooldownIcon.AddClass("ChooseCardBaseEffectPanelCooldownIcon")

                    let ChooseCardBaseEffectPanelCooldownLabel = $.CreatePanel("Label", ChooseCardBaseEffectPanelCooldownPanel, "")
                    ChooseCardBaseEffectPanelCooldownLabel.AddClass("ChooseCardBaseEffectPanelCooldownLabel")
                    
                    if (effect_list_data.proc_params.cooldown == null)
                    {
                        ChooseCardBaseEffectPanelCooldownPanel.visible = false
                    }
                    else
                    {
                        ChooseCardBaseEffectPanelCooldownLabel.text = FormatPrecisionValue(effect_list_data.proc_params.cooldown)
                    }
                    
                    let ChooseCardBaseEffectPanelBody = $.CreatePanel("Panel", ChooseCardBaseEffectPanel, "")
                    ChooseCardBaseEffectPanelBody.AddClass("ChooseCardBaseEffectPanelBody")

                    let ChooseCardBaseBonusLabel = $.CreatePanel("Label", ChooseCardBaseEffectPanelBody, "")
                    for (let bonus_list_key of Object.keys(effect_list_data.proc_params))
                    {
                        let bonus_list_value = effect_list_data.proc_params[bonus_list_key]
                        ChooseCardBaseBonusLabel.SetDialogVariable(bonus_list_key, "<b><font color=\"gold\">" + String(FormatPrecisionValue(bonus_list_value)) + "</font></b>");
                    }
                    ChooseCardBaseBonusLabel.AddClass("ChooseCardBaseBonusLabel")
                    ChooseCardBaseBonusLabel.html = true
                    ChooseCardBaseBonusLabel.text = $.Localize("#" + effect_list_data.effect_id + "_description", ChooseCardBaseBonusLabel)
                }
            }
        }

        for (let line_key of Object.values(card_data.custom_description_lines || {}))
        {
            ChooseCardBaseBonusListPanel.visible = true
            let ChooseCardBaseBonusLine = $.CreatePanel("Panel", ChooseCardBaseBonusListPanel, "")
            ChooseCardBaseBonusLine.AddClass("ChooseCardBaseBonusLine")

            let ChooseCardBaseBonusPin = $.CreatePanel("Panel", ChooseCardBaseBonusLine, "")
            ChooseCardBaseBonusPin.AddClass("ChooseCardBaseBonusPin")

            let ChooseCardBaseBonusLabel = $.CreatePanel("Label", ChooseCardBaseBonusLine, "")
            ChooseCardBaseBonusLabel.AddClass("ChooseCardBaseBonusLabel")
            ChooseCardBaseBonusLabel.html = true
            ChooseCardBaseBonusLabel.text = $.Localize("#" + line_key)
        }

        if (bundle_data.bundle_description)
        {
            let ChooseCardBaseBundleBonusPanel = $.CreatePanel("Panel", ChooseCardBase, "")
            ChooseCardBaseBundleBonusPanel.AddClass("ChooseCardBaseBundleBonusPanel")

            let ChooseCardBaseBundleBonusHeader = $.CreatePanel("Panel", ChooseCardBaseBundleBonusPanel, "")
            ChooseCardBaseBundleBonusHeader.AddClass("ChooseCardBaseBundleBonusHeader")
            
            let ChooseCardBaseBundleBonusPanelBG = $.CreatePanel("Panel", ChooseCardBaseBundleBonusHeader, "")
            ChooseCardBaseBundleBonusPanelBG.AddClass("ChooseCardBaseBundleBonusPanelBG")

            ApplyBundleDialogVariables(ChooseCardBaseBundleBonusPanel, bundle_data.bonus_list)

            let ChooseCardBaseBundleBonusHeaderLabel = $.CreatePanel("Label", ChooseCardBaseBundleBonusHeader, "")
            ChooseCardBaseBundleBonusHeaderLabel.AddClass("ChooseCardBaseBundleBonusHeaderLabel")
            ChooseCardBaseBundleBonusHeaderLabel.text = $.Localize("#"+card_data.bundle_name)
            ApplyCardRarityClass(ChooseCardBaseBundleBonusHeaderLabel, card_rarity)

            let ChooseCardBaseBundleBonusLabel = $.CreatePanel("Label", ChooseCardBaseBundleBonusPanel, "")
            ChooseCardBaseBundleBonusLabel.AddClass("ChooseCardBaseBundleBonusLabel")
            ChooseCardBaseBundleBonusLabel.html = true
            ChooseCardBaseBundleBonusLabel.text = $.Localize("#"+bundle_data.bundle_description, ChooseCardBaseBundleBonusPanel)
        }

        ChooseCardBase.SetPanelEvent("onactivate", function()
        {
            let latest_current_card_list = GetLatestCurrentCardList(data.current_card_list)
            let is_changer_type = GetCurrentCardSlotKeys(latest_current_card_list).length >= GetMaxCardStash()
            if (is_changer_type && !CardPickWouldAutoAbsorb(card_data, bundle_data))
            {
                ActiveCardChangerEvent(card_data, card_id, data, latest_current_card_list)
                UnFocusUI()
            }
            else
            {
                ActiveCardEvent(card_id)
                UnFocusUI()
            }
        })
    }

    if (ChooseCardButtonInfoUpdater)
    {
        ChooseCardButtonInfoUpdater.SetDialogVariable("value", "<b><font color=\"gold\">" + String(updates_card_counter) + "</font></b>");
        ChooseCardButtonInfoUpdater.text = $.Localize("#levelup_card_replace_counter", ChooseCardButtonInfoUpdater)
    }

    if (ChooseCardButtonReroll)
    {
        ChooseCardButtonReroll.SetPanelEvent("onactivate", function()
        {
            if (!PanelChooseBodyCard.BHasClass("OpenCardPanel")) { return }
            if (updates_card_counter > 0)
            {
                AllClosedSelectorCard()
                GameEvents.SendCustomGameEventToServer("event_player_reroll_card_custom", {})
                UnFocusUI()
            }
        })
    }

    if (ChooseCardButtonCancel)
    {
        ChooseCardButtonCancel.SetPanelEvent("onactivate", function()
        {
            if (!PanelChooseBodyCard.BHasClass("OpenCardPanel")) { return }
            AllClosedSelectorCard()
            GameEvents.SendCustomGameEventToServer("event_player_close_card_custom", {})
            UnFocusUI()
        })
    }

    const reopenReplaceCardId = data && data.reopen_replace_card_id != null ? Number(data.reopen_replace_card_id) : null
    if (reopenReplaceCardId != null && Number.isFinite(reopenReplaceCardId) && card_counter_object[reopenReplaceCardId])
    {
        let latest_current_card_list = GetLatestCurrentCardList(current_card_list)
        if (GetCurrentCardSlotKeys(latest_current_card_list).length >= GetMaxCardStash())
        {
            ActiveCardChangerEvent(card_counter_object[reopenReplaceCardId], reopenReplaceCardId, data, latest_current_card_list)
        }
    }

}

function OnDeactivateCards()
{
    for (let child of ChooseCardList.Children())
    {
        child.ClearPanelEvent("onactivate")
    }
}

function GameHudGetLocalAtlasStatValue(stat_id)
{
    stat_id = String(stat_id || "")
    if (stat_id === "" || !Game.GetCustomTable) return 0
    let pdata = Game.GetCustomTable("services_player", String(Game.GetLocalPlayerID())) || {}
    let atlas_items = pdata.atlas_items || {}
    let items = Game.GetCustomTable("services_config", "items") || {}
    let total = 0
    for (let item_id in atlas_items)
    {
        if ((Number(atlas_items[item_id]) || 0) <= 0) continue
        let cfg = items[item_id]
        let stats = cfg && cfg.stats
        if (stats && stats[stat_id] !== undefined) total += Number(stats[stat_id]) || 0
    }
    return total
}

function CardPickWouldAutoAbsorb(card_data, bundle_data)
{
    if (!card_data || !bundle_data) return false
    if (card_data.kills_consumed_data) return false
    if (!bundle_data.is_consume) return false
    let total = Object.values(bundle_data.card_list || {}).length
    if (total <= 0) return false
    let have = Number(bundle_data.cards_counter_have) || 0
    if (have !== total - 1) return false
    return GameHudGetLocalAtlasStatValue("last_set_card_auto_absorb") > 0
}

function ActiveCardEvent(card_id, card_replace)
{
    if (!PanelChooseBodyCard.BHasClass("OpenCardPanel")) { return }
    CARD_SELECTOR_PENDING_REPLACE_CARD_ID = null
    AllClosedSelectorCard()
    GameEvents.SendCustomGameEventToServer("event_player_select_card_custom", {card_id : card_id, card_replace_id : card_replace})
}

function GetLatestCurrentCardList(fallback_current_card_list)
{
    let latest_cards_data = Game.GetCustomTable("player_cards_data", String(Game.GetLocalPlayerID()))
    return (latest_cards_data && latest_cards_data.current) || fallback_current_card_list || {}
}

function GetMaxCardStash()
{
    let player_cards = Game.GetCustomTable("player_cards_data", String(Game.GetLocalPlayerID())) || {}
    return Number(player_cards.max_stash) || 5
}

function GetCurrentCardSlotKeys(current_card_list)
{
    return Object.keys(current_card_list || {})
        .filter((slot_key) => current_card_list[slot_key] != null)
        .sort((left, right) => Number(left) - Number(right))
}

function ActiveCardChangerEvent(replace_card_data, card_id, data, current_card_list)
{
    CARD_SELECTOR_PENDING_REPLACE_CARD_ID = Number(card_id)
    PanelChooseBodyCard.visible = false
    PanelReplaceCard.visible = true
    PanelReplaceCard.SetHasClass("IsOpenedReplace", true)
    PanelReplaceCard.SetHasClass("PanelReplaceCardWide", GetMaxCardStash() >= 6)
    PanelReplaceCard.SetHasClass("PanelReplaceCardExtraWide", GetMaxCardStash() >= 7)

    PanelReplaceCardData.RemoveAndDeleteChildren()

    CreatePanelCardReplace(replace_card_data, PanelReplaceCardData)

    let ReplaceCardArrow = $.CreatePanel("Panel", PanelReplaceCardData, "")
    ReplaceCardArrow.AddClass("ReplaceCardArrow")

    let ReplaceCardStashList = $.CreatePanel("Panel", PanelReplaceCardData, "")
    ReplaceCardStashList.AddClass("ReplaceCardStashList")

    current_card_list = current_card_list || GetLatestCurrentCardList(data.current_card_list)

    for (let stash_card_place of GetCurrentCardSlotKeys(current_card_list))
    {
        let stash_card_data = current_card_list[stash_card_place]
        let callback_replace = function()
        {
            ActiveCardEvent(card_id, Number(stash_card_place) - 1)
            UnFocusUI()
        }
        CreatePanelCardReplace(stash_card_data, ReplaceCardStashList, callback_replace)
    }

    if (CardButtonReplaceBack)
    {
        CardButtonReplaceBack.SetPanelEvent("onactivate", function()
        {
            if (!PanelReplaceCard.BHasClass("IsOpenedReplace")) { return }
            CARD_SELECTOR_PENDING_REPLACE_CARD_ID = null
            PanelChooseBodyCard.visible = true
            PanelReplaceCard.visible = false
            UnFocusUI()
        })
    }

    if (CardButtonReplaceCancel)
    {
        CardButtonReplaceCancel.SetPanelEvent("onactivate", function()
        {
            if (!PanelReplaceCard.BHasClass("IsOpenedReplace")) { return }
            AllClosedSelectorCard()
            GameEvents.SendCustomGameEventToServer("event_player_close_card_custom", {})
            UnFocusUI()
        })
    }
}

function ApplyBundleDialogVariables(panel, bonus_list)
{
    for (let bonus_name of Object.keys(bonus_list || {}))
    {
        if (bonus_name == "stats" || bonus_name == "currency" || bonus_name == "summon_aura")
        {
            let bonus_list_data = bonus_list[bonus_name]
            for (let bonus_list_key of Object.keys(bonus_list_data || {}))
            {
                let label_name = bonus_list_key
                let value = bonus_list_data[bonus_list_key]
                if (typeof value == "object")
                {
                    label_name = value[2] + "_" + label_name
                    value = value[1]
                }
                panel.SetDialogVariable("value_" + label_name, "<b><font color=\"gold\">" + String(FormatHudCardValue(value)) + "</font></b>")
            }
        }
        else if (bonus_name == "hero_selection")
        {
            let bonus_list_data = bonus_list[bonus_name]
            for (let bonus_list_key of Object.keys(bonus_list_data || {}))
            {
                panel.SetDialogVariable(bonus_list_key, "<b><font color=\"gold\">" + String(FormatPrecisionValue(bonus_list_data[bonus_list_key])) + "</font></b>")
            }
        }
        else if (bonus_name == "unique_effects")
        {
            for (let effect_data of Object.values(bonus_list[bonus_name] || {}))
            {
                for (let key of Object.keys((effect_data && effect_data.proc_params) || {}))
                {
                    panel.SetDialogVariable(key, "<b><font color=\"gold\">" + String(FormatPrecisionValue(effect_data.proc_params[key])) + "</font></b>")
                }
            }
        }
        else if (bonus_name == "effect_upgrades")
        {
            for (let upgrade_data of Object.values(bonus_list[bonus_name] || {}))
            {
                for (let key of Object.keys(upgrade_data || {}))
                {
                    panel.SetDialogVariable(key, "<b><font color=\"gold\">" + String(FormatPrecisionValue(upgrade_data[key])) + "</font></b>")
                }
            }
        }
    }
}

function AllClosedSelectorCard()
{
    CARD_SELECTOR_PENDING_REPLACE_CARD_ID = null
    SetCardSelectorCollapsed(false)
    PanelChooseBodyCard.SetHasClass("OpenCardPanel", false)
    PanelReplaceCard.SetHasClass("IsOpenedReplace", false)
    PanelReplaceCard.visible = false
    PanelChooseBodyCard.visible = true
}

function ResetMatchProgressClientUI()
{
    save_level_table_exp = {}
    LEVEL_UPGRADES_QUEUE = 0
    SAVED_ALL_DAMAGE_PLAYERS = {}

    if (typeof SetPostStageTrialsDisabled === "function")
    {
        SetPostStageTrialsDisabled(false)
    }
    if (typeof StopPostStageDummyTimer === "function")
    {
        StopPostStageDummyTimer()
    }
    if (typeof StopPostStageDummyCountdown === "function")
    {
        StopPostStageDummyCountdown()
    }
    if (typeof AllClosedSelectorCard === "function")
    {
        AllClosedSelectorCard()
    }
    if (typeof CloseMatchResultPanel === "function")
    {
        CloseMatchResultPanel()
    }
    if (typeof CloseLeaderboardPanel === "function")
    {
        CloseLeaderboardPanel()
    }
    MATCH_RESULT_STATE = { players: [] }
    MATCH_RESULT_RENDERED = false
    LEADERBOARD_STATE = { loading: false, leaderboard: [], self: null }
    SetMatchResultTopButtonVisible(false)
    if (SpawnChallengersPanel)
    {
        SpawnChallengersPanel.SetHasClass("GameOver", false)
    }
    if (ChooseCardList)
    {
        ChooseCardList.RemoveAndDeleteChildren()
    }
    if (PanelReplaceCardData)
    {
        PanelReplaceCardData.RemoveAndDeleteChildren()
    }
    if (PanelInventoryCard)
    {
        PanelInventoryCard.RemoveClass("VisibleInventoryCard")
    }
    if (UpgradeStatsLevel)
    {
        UpgradeStatsLevel.SetHasClass("OpenUpgrade", false)
    }
    if (UpgradeStatsList)
    {
        UpgradeStatsList.RemoveAndDeleteChildren()
    }
    if (PlayersStatsDamageList)
    {
        PlayersStatsDamageList.RemoveAndDeleteChildren()
    }
    if (PlayersStatsAllList)
    {
        PlayersStatsAllList.RemoveAndDeleteChildren()
    }
    if (ChooseNewHeroPanelData)
    {
        ChooseNewHeroPanelData.RemoveClass("VisibleChooseNewHeroPanelData")
    }
    if (ChooseNewHeroCardsList)
    {
        ChooseNewHeroCardsList.RemoveAndDeleteChildren()
    }
    if (GameItemsStorePanel)
    {
        GameItemsStorePanel.SetHasClass("OpenBlackStore", false)
    }
    if (GameItemsStoreList)
    {
        GameItemsStoreList.RemoveAndDeleteChildren()
    }
    if (SwapAttributesStatsPanel)
    {
        SwapAttributesStatsPanel.SetHasClass("IsOpenSwapStats", false)
    }
    if (SwapAttributesStatsList)
    {
        SwapAttributesStatsList.RemoveAndDeleteChildren()
    }
    if (typeof CloseNeutralRoshanBonusPanel === "function")
    {
        CloseNeutralRoshanBonusPanel(false)
    }
    if (typeof CloseNeutralRoshanArtefactSelector === "function")
    {
        CloseNeutralRoshanArtefactSelector()
    }
    if (typeof ClosePostStageActivityPanel === "function")
    {
        ClosePostStageActivityPanel(false)
    }
    if (typeof ClosePostStageHomePanel === "function")
    {
        ClosePostStageHomePanel(false)
    }
    if (typeof ClosePostStageRestartConfirmPanel === "function")
    {
        ClosePostStageRestartConfirmPanel()
    }
}

function CreatePanelCardReplace(card_data, parent, callback)
{
    let bundle_data = GetCardBundleData(card_data)
    let card_rarity = GetCardRarity(card_data, bundle_data)

    let ReplaceCardBasePanel = $.CreatePanel("Panel", parent, "")
    ReplaceCardBasePanel.AddClass("ReplaceCardBasePanel")

    let ReplaceCardBasePanelBundle = $.CreatePanel("Label", ReplaceCardBasePanel, "")
    ReplaceCardBasePanelBundle.AddClass("ReplaceCardBasePanelBundle")
    ReplaceCardBasePanelBundle.text = $.Localize("#"+card_data.bundle_name)
    ApplyCardRarityClass(ReplaceCardBasePanelBundle, card_rarity)

    let ReplaceCardBasePanelImgBox = $.CreatePanel("Panel", ReplaceCardBasePanel, "")
    ReplaceCardBasePanelImgBox.AddClass("ReplaceCardBasePanelImgBox")
    ApplyCardRarityClass(ReplaceCardBasePanelImgBox, card_rarity)

    let ReplaceCardBasePanelImg = $.CreatePanel("Image", ReplaceCardBasePanelImgBox, "")
    ReplaceCardBasePanelImg.AddClass("ReplaceCardBasePanelImg")
    ReplaceCardBasePanelImg.SetImage("file://{images}/card_list/" + card_data.card_name + ".png")

    let ReplaceCardBasePanelCardName = $.CreatePanel("Label", ReplaceCardBasePanel, "")
    ReplaceCardBasePanelCardName.AddClass("ReplaceCardBasePanelCardName")
    ReplaceCardBasePanelCardName.text = $.Localize("#"+card_data.card_name)

    if (callback)
    {
        ReplaceCardBasePanelImgBox.AddClass("ReplaceCardBasePanelImgBoxActive")
        ReplaceCardBasePanelImgBox.SetPanelEvent("onactivate", callback)
    }
}

function ApplyCardStashCapacity()
{
    let max_stash = GetMaxCardStash()
    if (CardSelectorList)
    {
        for (let child of CardSelectorList.Children())
        {
            let slot = Number(String(child.id).replace("CardStashPanel_", ""))
            if (slot > CardSystemBaseStashSlots)
            {
                child.style.visibility = max_stash >= slot ? "visible" : "collapse"
            }
        }
    }
    let selector_panel = $("#CardSelectorPanel")
    if (selector_panel)
    {
        selector_panel.SetHasClass("CardSelectorPanelExpanded", max_stash >= 6)
        selector_panel.SetHasClass("CardSelectorPanelExpandedWide", max_stash >= 7)
    }
}

function UpdateCardStashList(data)
{
    let server_card_list = data

    ApplyCardStashCapacity()

    for (let child of CardSelectorList.Children())
    {
        let get_child_slot = Number(child.id.replace("CardStashPanel_", ""))
        let card_data = server_card_list[get_child_slot]
        
        if (child.current_card && card_data == null)
        {
            child.RemoveAndDeleteChildren()
            child.current_card = null
            child.ClearPanelEvent("onmouseover")
            ClearCardRarityClasses(child)
        }
        else if (!child.current_card && card_data == null)
        {
            child.current_card = null   
            child.ClearPanelEvent("onmouseover")
            ClearCardRarityClasses(child)
        }
        else if (!child.current_card || child.current_card != card_data.card_name)
        {
            child.RemoveAndDeleteChildren()
            ApplyCardRarityClass(child, GetCardRarity(card_data, GetCardBundleData(card_data)))
            
            let CardBGStashImage = $.CreatePanel("Image", child, "")
            CardBGStashImage.AddClass("CardBGStashImage")
            CardBGStashImage.SetImage("file://{images}/card_list/" + card_data.card_name + ".png")

            if (card_data.kills_consumed_data)
            {
                let CardKillsCounterStash = $.CreatePanel("Label", child, "CardKillsCounterStash")
                CardKillsCounterStash.AddClass("CardKillsCounterStash")
                CardKillsCounterStash.text = card_data.kills_consumed_data.current_kills_counter
            }

            child.current_card = card_data.card_name
            SetCustomTooltip(child, "card_tooltip", {card_name : child.current_card})
        }
        else if (child.current_card && child.current_card == card_data.card_name)
        {
            ApplyCardRarityClass(child, GetCardRarity(card_data, GetCardBundleData(card_data)))
            if (card_data.kills_consumed_data)
            {
                let CardKillsCounterStash = child.FindChildTraverse("CardKillsCounterStash")
                if (CardKillsCounterStash)
                {
                    CardKillsCounterStash.text = card_data.kills_consumed_data.current_kills_counter
                }
            } 
        }
    }
}

function SwitchInventoryCards()
{
    PanelInventoryCard.ToggleClass("VisibleInventoryCard")
}

function UpdateCardInventoryList(data)
{
    for (let child of CardInventoryList.Children())
    {
        let card_id = child.id.replace("inventory_card_", "")
        if (!data || data[card_id] == null)
        {
            child.DeleteAsync(0)
        }
    }

    for (card_id of Object.keys(data))
    {
        let card_data = data[card_id]
        if (card_data == null) { continue }
        let card_panel = CardInventoryList.FindChildTraverse("inventory_card_" + card_id)
        if (card_panel == null)
        {
            let InventoryCardChild = $.CreatePanel("Panel", CardInventoryList, "inventory_card_" + card_id)
            InventoryCardChild.AddClass("InventoryCardChild")
            ApplyCardRarityClass(InventoryCardChild, GetCardRarity(card_data, GetCardBundleData(card_data)))
            let InventoryCardChildImg = $.CreatePanel("Image", InventoryCardChild, "")
            InventoryCardChildImg.AddClass("InventoryCardChildImg")
            if (card_data.card_type == "ultimate")
            {
                InventoryCardChildImg.SetImage("file://{images}/heroes_list/" + card_data.card_icon + ".png")
            }
            else
            {
                InventoryCardChildImg.SetImage("file://{images}/card_list/" + card_data.card_name + ".png")
            }
            if (card_data && card_data.card_type && card_data.card_type == "ultimate")
            {
                SetCustomTooltip(InventoryCardChild, "ability_tooltip", {ability_name : card_data.card_name.replace("ultimate_card_", "")})
            }
            else
            {
                SetCustomTooltip(InventoryCardChild, "card_tooltip", {card_name : card_data.card_name})
            }
        }
        else
        {
            ApplyCardRarityClass(card_panel, GetCardRarity(card_data, GetCardBundleData(card_data)))
        }
    }
}

// Логика карт по смене персонажа
function ButtonStartChallenge()
{
    GameEvents.SendCustomGameEventToServer("event_player_start_hero_card_challenge", {});
}

var TRIAL_AUTOCAST_LAST_FIRE = {}
var TRIAL_KEY_BY_CHALLENGER = { gold_trial: "gold", exp_trial: "exp", kills_trial: "kills" }

function IsLocalHeroAliveForAutocast()
{
    let hero = Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer())
    return !!hero && hero !== -1 && Entities.IsAlive(hero)
}

function CanAutoFireTrial(key)
{
    let now = Game.GetGameTime()
    if ((TRIAL_AUTOCAST_LAST_FIRE[key] || -999) + 1.0 > now) return false
    TRIAL_AUTOCAST_LAST_FIRE[key] = now
    return true
}

function ToggleTrialAutocast(trial, current_enabled)
{
    GameEvents.SendCustomGameEventToServer("event_game_set_trial_autocast", { trial: trial, value: current_enabled ? 0 : 1 })
    Game.EmitSound("up_up_ui_visual_on")
}

function InitAbyssButton()
{
    if (AbyssButton)
    {
        AbyssButton.SetPanelEvent("oncontextmenu", function()
        {
            if (Number(ABYSS_STATE.autocast_unlocked || 0) !== 1) return
            ToggleTrialAutocast("wood", Number(ABYSS_STATE.autocast_enabled || 0) === 1)
        })
    }
    UpdateAbyssState()
    SetAbyssThink()
}

function StartAbyssTrial()
{
    if (IsPostStageTrialsDisabled())
    {
        return
    }

    Game.TowerCall()
}

function GetAutoVictoryTokenCount()
{
    let pdata = Game.GetCustomTable("services_player", String(Game.GetLocalPlayerID())) || {}
    let economy = pdata.economy_data || {}
    return Math.max(0, Math.floor(Number(economy.auto_victory_token) || 0))
}

function HasAutoVictoryBlessing()
{
    return typeof GameHudGetLocalAtlasStatValue === "function" && GameHudGetLocalAtlasStatValue("auto_victory_token_unlocked") > 0
}

function UpdateAutoVictoryButton()
{
    if (!AutoVictoryButton) return
    let has_blessing = HasAutoVictoryBlessing()
    AutoVictoryButton.visible = has_blessing
    if (!has_blessing) return

    let count = GetAutoVictoryTokenCount()
    if (AutoVictoryTokenCount) AutoVictoryTokenCount.text = String(count)
    AutoVictoryButton.SetHasClass("IsAutoVictoryEmpty", count <= 0)
}

function CloseAutoVictoryConfirm()
{
    let existing = $.GetContextPanel().FindChildTraverse("AutoVictoryConfirmOverlay")
    if (existing) existing.DeleteAsync(0)
}

function ConfirmAutoVictoryUse()
{
    CloseAutoVictoryConfirm()
    GameEvents.SendCustomGameEventToServer("event_player_use_auto_victory_token", {})
}

function OnAutoVictoryButtonActivate()
{
    if (!HasAutoVictoryBlessing()) return
    if (GetAutoVictoryTokenCount() <= 0) return

    let existing = $.GetContextPanel().FindChildTraverse("AutoVictoryConfirmOverlay")
    if (existing)
    {
        existing.DeleteAsync(0)
        return
    }

    let overlay = $.CreatePanel("Panel", $.GetContextPanel(), "AutoVictoryConfirmOverlay")
    overlay.AddClass("ExitGameConfirmOverlay")
    overlay.hittest = true
    overlay.SetPanelEvent("onactivate", CloseAutoVictoryConfirm)

    let window = $.CreatePanel("Panel", overlay, "")
    window.AddClass("ExitGameConfirmWindow")
    window.hittest = true
    window.SetPanelEvent("onactivate", function() {})

    let title = $.CreatePanel("Label", window, "")
    title.AddClass("ExitGameConfirmTitle")
    title.text = $.Localize("#auto_victory_confirm_title")

    let text = $.CreatePanel("Label", window, "")
    text.AddClass("ExitGameConfirmSaveLabel")
    text.text = $.Localize("#auto_victory_confirm_text")

    let buttons = $.CreatePanel("Panel", window, "")
    buttons.AddClass("ExitGameConfirmButtons")

    let confirm = $.CreatePanel("Panel", buttons, "")
    confirm.AddClass("ExitGameConfirmButton")
    confirm.AddClass("ExitGameLeaveButton")
    confirm.hittest = true
    confirm.SetPanelEvent("onactivate", ConfirmAutoVictoryUse)
    $.CreatePanel("Label", confirm, "").text = $.Localize("#auto_victory_confirm_yes")

    let cancel = $.CreatePanel("Panel", buttons, "")
    cancel.AddClass("ExitGameConfirmButton")
    cancel.hittest = true
    cancel.SetPanelEvent("onactivate", CloseAutoVictoryConfirm)
    $.CreatePanel("Label", cancel, "").text = $.Localize("#auto_victory_confirm_no")

    Game.EmitSound("General.ButtonClick")
}

function InitAutoVictoryButton()
{
    if (AutoVictoryButtonIcon && typeof ShowTextForPanel === "function")
    {
        ShowTextForPanel(AutoVictoryButtonIcon, "#auto_victory_button_tooltip")
    }
    if (!Game.SubscribeCustomTableListener)
    {
        $.Schedule(0.2, InitAutoVictoryButton)
        return
    }
    Game.SubscribeCustomTableListener("services_player", String(Players.GetLocalPlayer()), UpdateAutoVictoryButton)
    UpdateAutoVictoryButton()
}

function UpdateAbyssState(data)
{
    if (!data)
    {
        data = Game.GetCustomTable("abyss_state", String(Game.GetLocalPlayerID()))
    }

    ABYSS_STATE = data || {}
    ApplyAbyssState()
}

function ApplyAbyssState()
{
    const now = Math.max(0, Game.GetGameTime())
    const currentFloor = Math.floor(ABYSS_STATE.current_floor || 1)
    const completed = Number(ABYSS_STATE.completed || 0) === 1
    const isActive = Number(ABYSS_STATE.is_active || 0) === 1
    const initialCooldownDuration = Number(ABYSS_STATE.initial_cooldown_duration || 0)
    const activeDuration = Number(ABYSS_STATE.active_duration || 0)
    const initialRemaining = Math.max(0, Number(ABYSS_STATE.cooldown_end_time || 0) - now)
    const activeRemaining = Math.max(0, Number(ABYSS_STATE.active_end_time || 0) - now)

    let showCooldown = false
    let cooldownDuration = 0
    let cooldownRemaining = 0

    if (isActive && activeRemaining > 0)
    {
        showCooldown = true
        cooldownDuration = activeDuration
        cooldownRemaining = activeRemaining
    }
    else if (!isActive && initialRemaining > 0)
    {
        showCooldown = true
        cooldownDuration = initialCooldownDuration
        cooldownRemaining = initialRemaining
    }

    if (AbyssLevel)
    {
        AbyssLevel.SetDialogVariable("value", String(currentFloor))
        AbyssLevel.text = completed ? $.Localize("#abyss_trial_completed") : $.Localize("#abyss_trial_floor", AbyssLevel)
    }

    if (AbyssCooldownPanel)
    {
        AbyssCooldownPanel.visible = showCooldown
        if (showCooldown && cooldownDuration > 0)
        {
            const progress = (cooldownRemaining / cooldownDuration) * -360
            AbyssCooldownPanel.style.clip = "radial( 50% 50%, 0deg, " + progress + "deg )"
        }
    }

    if (AbyssCooldownLabel)
    {
        AbyssCooldownLabel.visible = showCooldown
        if (showCooldown)
        {
            AbyssCooldownLabel.text = Math.ceil(cooldownRemaining)
        }
    }

    AbyssButton.SetHasClass("IsAbyssCooldown", showCooldown)
    AbyssButton.SetHasClass("IsPostStageDisabled", IsPostStageTrialsDisabled())

    if (Number(ABYSS_STATE.autocast_unlocked || 0) === 1 && Number(ABYSS_STATE.autocast_enabled || 0) === 1
        && !showCooldown && !completed && !IsPostStageTrialsDisabled() && IsLocalHeroAliveForAutocast()
        && CanAutoFireTrial("wood"))
    {
        StartAbyssTrial()
    }
}

function SetAbyssThink()
{
    ApplyAbyssState()
    $.Schedule(0.1, SetAbyssThink)
}

function InitChallengerButtons()
{
    CHALLENGER_BUTTONS =
    {
        gold_trial: BuildChallengerPanelData(GoldChallengeButton),
        exp_trial: BuildChallengerPanelData(ExpChallengeButton),
        kills_trial: BuildChallengerPanelData(KillsChallengeButton),
    }
    for (let challenger_id of Object.keys(CHALLENGER_BUTTONS))
    {
        let panelData = CHALLENGER_BUTTONS[challenger_id]
        if (!panelData || !panelData.button) continue
        panelData.button.SetPanelEvent("oncontextmenu", (function(cid)
        {
            return function()
            {
                let st = CHALLENGER_STATE[cid] || {}
                if (Number(st.autocast_unlocked || 0) !== 1) return
                ToggleTrialAutocast(TRIAL_KEY_BY_CHALLENGER[cid], Number(st.autocast_enabled || 0) === 1)
            }
        })(challenger_id))
    }
    UpdateChallengerState()
    SetChallengerThink()
}

function BuildChallengerPanelData(button)
{
    if (!button)
    {
        return null
    }

    return {
        button: button,
        cooldownPanel: button.GetChild(1),
        cooldownLabel: button.GetChild(2),
        countLabel: button.GetChild(4),
    }
}

function StartChallengerSpawn(challenger_id)
{
    if (IsPostStageTrialsDisabled())
    {
        return
    }

    GameEvents.SendCustomGameEventToServer("event_player_start_challenger_spawn", {challenger_id: challenger_id});

    UnFocusUI()
}

function UpdateChallengerState(data)
{
    if (!data)
    {
        data = Game.GetCustomTable("challenger_state", String(Game.GetLocalPlayerID()))
    }
    CHALLENGER_STATE = data && data.challengers ? data.challengers : {}
    ApplyChallengerState()
}

function ApplyChallengerState()
{
    const now = Math.max(0, Game.GetGameTime())

    for (let challenger_id of Object.keys(CHALLENGER_BUTTONS))
    {
        const panelData = CHALLENGER_BUTTONS[challenger_id]
        if (!panelData)
        {
            continue
        }

        const state = CHALLENGER_STATE[challenger_id]
        const charges = state ? Math.max(0, Math.floor(state.charges || 0)) : 0
        const maxCharges = state ? Math.max(1, Math.floor(state.max_charges || 1)) : 1
        const nextChargeTime = state ? Number(state.next_charge_time || 0) : 0
        const cooldownDuration = state ? Number(state.current_cooldown_duration || 0) : 0
        const remaining = Math.max(0, nextChargeTime - now)

        if (panelData.countLabel)
        {
            panelData.countLabel.text = String(charges)
        }

        const showCooldown = charges <= 0 && remaining > 0 && cooldownDuration > 0
        if (panelData.cooldownPanel)
        {
            panelData.cooldownPanel.visible = showCooldown
            if (showCooldown)
            {
                const progress = (remaining / cooldownDuration) * -360
                panelData.cooldownPanel.style.clip = "radial( 50% 50%, 0deg, " + progress + "deg )"
            }
        }

        if (panelData.cooldownLabel)
        {
            panelData.cooldownLabel.visible = showCooldown
            if (showCooldown)
            {
                panelData.cooldownLabel.text = Math.ceil(remaining)
            }
        }

        panelData.button.SetHasClass("IsChallengeCooldown", showCooldown)
        panelData.button.SetHasClass("IsPostStageDisabled", IsPostStageTrialsDisabled())

        if (state && Number(state.autocast_unlocked || 0) === 1 && Number(state.autocast_enabled || 0) === 1
            && charges > 0 && !IsPostStageTrialsDisabled() && IsLocalHeroAliveForAutocast()
            && CanAutoFireTrial(challenger_id))
        {
            StartChallengerSpawn(challenger_id)
        }
    }
}

function SetChallengerThink()
{
    ApplyChallengerState()
    $.Schedule(0.1, SetChallengerThink)
}

function SwitchHeroCardsPanel()
{
    $("#ChooseNewHeroPanelData").ToggleClass("VisibleChooseNewHeroPanelData")
}

function RefreshHeroCardEvent()
{
    GameEvents.SendCustomGameEventToServer("event_player_refresh_hero_cards_list", {});
}

function UpdateHeroCardList(data)
{
    ChooseNewHeroCardsList.RemoveAndDeleteChildren()
    for (let card_id in Object.keys(data))
    {
        let card_hero_data = Object.values(data)[card_id]

        let ChooseNewHeroCard = $.CreatePanel("Panel", ChooseNewHeroCardsList, "")
        ChooseNewHeroCard.AddClass("ChooseNewHeroCard")
        let hero_rarity = NormalizeCardRarityName(card_hero_data.rarity)
        ApplyCardRarityClass(ChooseNewHeroCard, hero_rarity)

        let ChooseNewHeroCardBG = $.CreatePanel("Panel", ChooseNewHeroCard, "")
        ChooseNewHeroCardBG.AddClass("ChooseNewHeroCardBG")
        ChooseNewHeroCardBG.hittest = false

        let ChooseNewHeroCardBG2 = $.CreatePanel("Panel", ChooseNewHeroCard, "")
        ChooseNewHeroCardBG2.AddClass("ChooseNewHeroCardBG2")
        ChooseNewHeroCardBG2.hittest = false

        let ChooseNewHeroCardBorder = $.CreatePanel("Panel", ChooseNewHeroCard, "")
        ChooseNewHeroCardBorder.AddClass("ChooseNewHeroCardBorder")
        ChooseNewHeroCardBorder.hittest = false

        $.CreatePanel("DOTAParticleScenePanel", ChooseNewHeroCardBG, "", 
        { 
            class: "ChooseNewHeroCardPFX",
            particleName: "particles/hero_card_bg/hero_card_bg.vpcf", 
            particleonly:"true", 
            startActive:"true", 
            cameraOrigin:"0 0 550", 
            lookAt:"0 0 0",  
            fov:"64", 
            squarePixels:"true",
            hittest: "false"
        });

        let ChooseNewHeroCardImage = $.CreatePanel("Image", ChooseNewHeroCard, "")
        ChooseNewHeroCardImage.AddClass("ChooseNewHeroCardImage")
        ChooseNewHeroCardImage.SetImage("file://{images}/heroes_list/cards/" + card_hero_data.hero_name + ".png")

        let ChooseNewHeroQualityPanel = $.CreatePanel("Panel", ChooseNewHeroCard, "")
        ChooseNewHeroQualityPanel.AddClass("ChooseNewHeroQualityPanel")

        let ChooseNewHeroQualityLabel = $.CreatePanel("Label", ChooseNewHeroQualityPanel, "")
        ChooseNewHeroQualityLabel.AddClass("ChooseNewHeroQualityLabel")
        ChooseNewHeroQualityLabel.text = ReplaceQuallityString(card_hero_data.quality || 1)

        let ChooseNewHeroStatPanel = $.CreatePanel("Panel", ChooseNewHeroCard, "")
        ChooseNewHeroStatPanel.AddClass("ChooseNewHeroStatPanel")

        let ChooseNewHeroStatIcon = $.CreatePanel("Image", ChooseNewHeroStatPanel, "")
        ChooseNewHeroStatIcon.AddClass("ChooseNewHeroStatIcon")
        ChooseNewHeroStatIcon.AddClass("ChooseNewHeroStatIcon_"+card_hero_data.primary_attribute)

        if (card_hero_data.attribute_bonus)
        {
            let hero_attribute_bonus_panel = $.CreatePanel("Panel", ChooseNewHeroCard, "")
            hero_attribute_bonus_panel.AddClass("hero_attribute_bonus_panel")

            let hero_attribute_bonus_label = $.CreatePanel("Label", hero_attribute_bonus_panel, "")
            hero_attribute_bonus_label.html = true
            hero_attribute_bonus_label.AddClass("hero_attribute_bonus_label")
            hero_attribute_bonus_label.AddClass("hero_attribute_bonus_label_"+card_hero_data.primary_attribute)
            hero_attribute_bonus_label.SetDialogVariable("value", ApplyNumberFormat(card_hero_data.attribute_bonus[3]))
            hero_attribute_bonus_label.text = $.Localize("#levelup_hero_attribute_bonus_" + card_hero_data.attribute_bonus[1], hero_attribute_bonus_label)
        }

        let ChooseNewHeroCardHeroAbility = $.CreatePanel("Image", ChooseNewHeroCard, "")
        ChooseNewHeroCardHeroAbility.AddClass("ChooseNewHeroCardHeroAbility")
        let ability_card_data = Game.GetCustomTable("ability_card_data", card_hero_data.ultimate_id)
        if (ability_card_data)
        {
            ChooseNewHeroCardHeroAbility.SetImage("file://{images}/spellicons/"+ability_card_data.icon+".png")
        }
        SetCustomTooltip(ChooseNewHeroCardHeroAbility, "ability_tooltip", {ability_name : card_hero_data.ultimate_id})
    
        let ChooseNewHeroCardHeroName = $.CreatePanel("Label", ChooseNewHeroCard, "")
        ChooseNewHeroCardHeroName.AddClass("ChooseNewHeroCardHeroName")
        ChooseNewHeroCardHeroName.text = $.Localize("#"+card_hero_data.hero_name)

        ChooseNewHeroCard.SetPanelEvent("onactivate", function()
        {
            if (!$("#ChooseNewHeroPanelData").BHasClass("VisibleChooseNewHeroPanelData")) { return }
            $("#ChooseNewHeroPanelData").RemoveClass("VisibleChooseNewHeroPanelData")
            GameEvents.SendCustomGameEventToServer("event_player_select_new_hero_card", {card_id: card_id})
            UnFocusUI()
        })
    }
}

// Смена дополнительных окон настройки и профиля итд
Game.OpenStorePurchaseModalById = function(store_item_id)
{
    if (Game.SwitchAnothersPanel)
    {
        Game.SwitchAnothersPanel("StoreWindow")
    }

    let tries = 0
    function tryOpen()
    {
        tries++
        if (Game.NavigateStoreSection)
        {
            Game.NavigateStoreSection("items")
        }
        if (Game.ShowStorePurchaseModalById && Game.ShowStorePurchaseModalById(store_item_id))
        {
            return
        }
        if (tries < 10)
        {
            $.Schedule(0.05, tryOpen)
        }
    }
    $.Schedule(0.03, tryOpen)
}
Game.SwitchAnothersPanel = function(window_name)
{
    CloseLeaderboardPanel()
    let chests_panel = AnothersPanels.FindChildTraverse("ChestsWindow")
    let leaving_chests = !!(chests_panel && chests_panel.BHasClass("WindowVisible") && window_name != "ChestsWindow")
    for (let child of AnothersPanels.Children())
    {
        child.SetHasClass("WindowVisible", child.id == window_name && !child.BHasClass("WindowVisible"))
        if (child.id == "ChestsWindow" && window_name == "ChestsWindow" && !child.BHasClass("WindowVisible"))
        {
            leaving_chests = true
        }
        if (child.id == window_name && child.BHasClass("WindowVisible"))
        {
            const deferred_renderers = {
                PlayerInventory: Game.RenderInventoryIfDeferred,
                PlayerProfile: Game.RenderProfileIfDeferred,
                StoreWindow: Game.RenderStoreIfDeferred,
                PromoWindow: Game.RenderPromoIfDeferred,
                PassWindow: Game.RenderPassIfDeferred,
            }
            const renderer = deferred_renderers[window_name]
            if (typeof renderer === "function")
            {
                renderer()
            }
        }
        if (window_name == "detail_hero_stats")
        {
            GameEvents.SendCustomGameEventToServer("event_player_update_detail_info", {})
        }
    }
    if (leaving_chests)
    {
        if (typeof Game.StopChestMusic === "function")
        {
            Game.StopChestMusic()
        }
        GameEvents.SendCustomGameEventToServer("event_services_flush_deferred_sync", {})
    }
    if (window_name == "ChestsWindow" && chests_panel && chests_panel.BHasClass("WindowVisible") && typeof Game.PlayCurrentChestMusic === "function")
    {
        Game.PlayCurrentChestMusic()
    }
}

// Временное говно можно будет удалить и перенести в отдельный файл потом
function GetServicesRewardPopupItemsConfig()
{
    return Game.GetCustomTable ? (Game.GetCustomTable("services_config", "items") || {}) : {}
}

function GetServicesRewardPopupEquipmentConfig()
{
    return Game.GetCustomTable ? (Game.GetCustomTable("services_config", "equipment") || {}) : {}
}

function NormalizeServicesRewardPopupRewards(rewards)
{
    let by_id = {}
    let result = []
    for (let reward of Object.values(rewards || {}))
    {
        let item_id = String(reward && reward.id || "")
        let count = Number(reward && reward.count) || 0
        if (!item_id || count <= 0)
        {
            continue
        }

        let is_generated = reward.generated === true || reward.generated === 1 || reward.generated === "true"
        if (is_generated)
        {
            result.push({
                id: item_id,
                count: count,
                generated: true,
                generated_id: reward.generated_id || "",
                generated_name: reward.generated_name || "",
                rarity: reward.rarity || "common",
                icon: reward.icon || "",
                slot: reward.slot || "",
                potential: reward.potential || 0,
                potential_reforge_attempts: reward.potential_reforge_attempts || 0,
                strengthen_level: reward.strengthen_level || 0,
                set_id: reward.set_id || "",
                star_min: reward.star_min || 1,
                star_max: reward.star_max || 1,
                normal_stats: reward.normal_stats || [],
                random_stats: reward.random_stats || [],
            })
        }
        else if (by_id[item_id])
        {
            by_id[item_id].count += count
        }
        else
        {
            by_id[item_id] = { id: item_id, count: count }
            result.push(by_id[item_id])
        }
    }
    return result
}

function SetServicesRewardPopupImage(panel, icon)
{
    panel.style.backgroundImage = "url('" + String(icon || "file://{images}/game_hud/icons/gold.png") + "')"
    panel.style.backgroundSize = "contain"
    panel.style.backgroundPosition = "center"
    panel.style.backgroundRepeat = "no-repeat"
}

function GetServicesCrystalPopupConfig(crystal)
{
    crystal = crystal || {}
    let category = String(crystal.category || "")
    let index = Number(crystal.index) || 0
    let equipment = GetServicesRewardPopupEquipmentConfig()
    let crystals = equipment.crystals || {}
    let category_config = crystals.categories && crystals.categories[category] || {}
    let crystal_config = category_config.crystals && (category_config.crystals[index] || category_config.crystals[String(index)]) || {}
    let category_number = ["C", "B", "A", "S", "SS", "SSS"].indexOf(category) + 1
    return {
        category: category,
        index: index,
        level: Number(crystal.level) || 0,
        name: LocalizeServiceKeyOrText(crystal_config.name || crystal_config.id || ("crystal_" + category + "_" + index), category + " " + index),
        icon: "file://{images}/game_hud/gems/" + category_number + "_" + index + ".png",
    }
}

function RenderServicesCrystalPopup(crystal)
{
    let crystal_data = GetServicesCrystalPopupConfig(crystal)
    if (!crystal_data.category || crystal_data.index <= 0)
    {
        return false
    }

    if (ServicesRewardPopupTitle)
    {
        ServicesRewardPopupTitle.text = $.Localize("#services_crystal_popup_title")
    }
    ServicesRewardPopupItems.RemoveAndDeleteChildren()

    let item = $.CreatePanel("Panel", ServicesRewardPopupItems, "")
    item.AddClass("ServicesRewardItem")
    item.AddClass("ServicesCrystalRewardItem")
    if (typeof SetCrystalTooltip === "function")
    {
        SetCrystalTooltip(item, crystal_data.category, crystal_data.index, crystal_data.level, 0, false)
    }

    let bg1 = $.CreatePanel("Panel", item, "")
    bg1.AddClass("ServicesRewardItemBG1")
    bg1.AddClass("CrystalRank_" + crystal_data.category)
    let bg2 = $.CreatePanel("Panel", item, "")
    bg2.AddClass("ServicesRewardItemBG2")

    let icon = $.CreatePanel("Panel", item, "")
    icon.AddClass("ServicesRewardItemIcon")
    icon.AddClass("ServicesCrystalRewardIcon")
    SetServicesRewardPopupImage(icon, crystal_data.icon)

    let name = $.CreatePanel("Label", item, "")
    name.AddClass("ServicesCrystalRewardName")
    name.text = crystal_data.name

    let level = $.CreatePanel("Label", item, "")
    level.AddClass("ServicesCrystalRewardLevel")
    level.SetDialogVariable("value", String(crystal_data.level))
    level.text = $.Localize("#services_inventory_level_suffix", level)

    Game.EmitSound("up_up_ui_stone_recieve")

    ServicesRewardPopup.AddClass("ServicesRewardPopupVisible")
    return true
}

function ShowServicesRewardPopup(data)
{
    if (!data || data.source === "chest")
    {
        return
    }

    let rewards = NormalizeServicesRewardPopupRewards(data.rewards)
    if (rewards.length <= 0)
    {
        return
    }

    SERVICES_REWARD_POPUP_QUEUE.push({ type: "rewards", rewards: rewards })
    if (!ServicesRewardPopup || ServicesRewardPopup.BHasClass("ServicesRewardPopupVisible"))
    {
        return
    }
    RenderNextServicesRewardPopup()
}

function ShowServicesCrystalPopup(data)
{
    if (!data || !data.category || !data.index)
    {
        return
    }
    SERVICES_REWARD_POPUP_QUEUE.push({ type: "crystal", crystal: data })
    if (!ServicesRewardPopup || ServicesRewardPopup.BHasClass("ServicesRewardPopupVisible"))
    {
        return
    }
    RenderNextServicesRewardPopup()
}

function RenderNextServicesRewardPopup()
{
    if (!ServicesRewardPopup || !ServicesRewardPopupItems)
    {
        SERVICES_REWARD_POPUP_QUEUE = []
        return
    }

    let popup_data = SERVICES_REWARD_POPUP_QUEUE.shift()
    if (!popup_data)
    {
        ServicesRewardPopup.RemoveClass("ServicesRewardPopupVisible")
        return
    }

    if (popup_data.type === "crystal")
    {
        if (!RenderServicesCrystalPopup(popup_data.crystal))
        {
            RenderNextServicesRewardPopup()
        }
        return
    }

    let rewards = popup_data.rewards || popup_data

    let items = GetServicesRewardPopupItemsConfig()
    if (ServicesRewardPopupTitle)
    {
        ServicesRewardPopupTitle.text = $.Localize("#services_reward_popup_title")
    }
    ServicesRewardPopupItems.RemoveAndDeleteChildren()

    let rewards_count = Object.keys(rewards).length

    for (let reward of rewards)
    {
        let item_data = items[reward.id] || {}
        let is_generated = reward.generated === true || reward.generated === 1 || reward.generated === "true"
        let reward_icon = reward.icon || item_data.icon
        let reward_rarity = reward.rarity || item_data.rarity
        let item = $.CreatePanel("Panel", ServicesRewardPopupItems, "")
        item.AddClass("ServicesRewardItem")
        SetServiceItemTooltip(item, reward.id, reward.count, is_generated ? BuildAghanimEquipmentTooltipExtra(reward) : null)

        let ServicesRewardItemBG1 = $.CreatePanel("Panel", item, "")
        ServicesRewardItemBG1.AddClass("ServicesRewardItemBG1")
        let bg2 = $.CreatePanel("Panel", item, "")
        bg2.AddClass("ServicesRewardItemBG2")
        if (reward_rarity && reward_rarity !== "common")
        {
            ServicesRewardItemBG1.AddClass("RareColor_" + reward_rarity)
        }

        let icon = $.CreatePanel("Panel", item, "")
        icon.AddClass("ServicesRewardItemIcon")
        SetServicesRewardPopupImage(icon, reward_icon)

        if (is_generated) AddSetIconOverlayHud(item, reward.set_id)

        let count = $.CreatePanel("Label", item, "")
        count.AddClass("ServicesRewardItemCount")
        count.text = Number(reward.count) > 1 ? ("x" + String(reward.count)) : ""
        count.style.visibility = Number(reward.count) > 1 ? "visible" : "collapse"
    }
    Game.EmitSound("up_up_ui_poppup_rewards")
    ServicesRewardPopup.SetHasClass("LargeRewardPopup", rewards_count <= 5)
    ServicesRewardPopup.AddClass("ServicesRewardPopupVisible")
}

function HideServicesRewardPopup()
{
    if (!ServicesRewardPopup)
    {
        return
    }
    ServicesRewardPopup.RemoveClass("ServicesRewardPopupVisible")
    $.Schedule(0.15, RenderNextServicesRewardPopup)
}

GameEvents.Subscribe("event_services_reward_popup", ShowServicesRewardPopup)
GameEvents.Subscribe("event_services_crystal_popup", ShowServicesCrystalPopup)

function SwitchHudDev()
{
    if (DEFAULT_HUD_DISABLE)
    {
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_TIMEOFDAY, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_PREGAME_STRATEGYUI, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ENDGAME, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_TEAMS, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_MINIMAP, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_SHOP, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_ITEMS, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_QUICKBUY, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_COURIER, true );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_PANEL, true );
        $("#TopHud").visible = false
        $("#LowerHud").visible = false
        $("#StatsPlayerPanel").visible = false
        let minimap_container = FindDotaHudElement("minimap_container")
        if (minimap_container)
        {
            minimap_container.visible = true
        }
    }
    else
    {
        $("#TopHud").visible = true
        $("#LowerHud").visible = true
        $("#StatsPlayerPanel").visible = true
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_TIMEOFDAY, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_PREGAME_STRATEGYUI, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ENDGAME, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_TEAMS, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_MINIMAP, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_SHOP, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_ITEMS, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_QUICKBUY, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_COURIER, false );
        GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_PANEL, false );
        let minimap_container = FindDotaHudElement("minimap_container")
        if (minimap_container)
        {
            minimap_container.visible = false
        }
    }
    DEFAULT_HUD_DISABLE = !DEFAULT_HUD_DISABLE
}

function UpdateBlackStore(data)
{
    GameItemsStoreList.RemoveAndDeleteChildren()
    if (Object.values(data.items_list).length > 0)
    {
        GameItemsStorePanel.SetHasClass("OpenBlackStore", true)
    }
    for (let item_key in data.items_list)
    {
        let item_data = data.items_list[item_key]
        CreateItemBlackStore(item_key, item_data)
    }
    let free_refreshes = Number(data.free_refreshes) || 0
    GameItemsStoreButtonChangeDataPriceLabel.text = free_refreshes > 0 ? "0" : data.store_refresh_cost
}

function CreateItemBlackStore(item_key, item_data)
{
    let GameItemStore = GameItemsStoreList.FindChildTraverse("GameItemStore")
    if (!GameItemStore)
    {
        GameItemStore = $.CreatePanel("Panel", GameItemsStoreList, "black_store_item_"+item_key)
        GameItemStore.AddClass("GameItemStore")
        GameItemStore.SetHasClass("is_bought", item_data.is_bought != null)
        SetCustomTooltip(GameItemStore, "item_tooltip", {item_name : item_data.item_name})

        let GameItemStoreBorder = $.CreatePanel("Panel", GameItemStore, "")
        GameItemStoreBorder.AddClass("GameItemStoreBorder")

        let GameItemStoreIcon = $.CreatePanel("DOTAItemImage", GameItemStore, "GameItemStoreIcon", {scaling:"stretch-to-fit-y-preserve-aspect"})
        GameItemStoreIcon.AddClass("GameItemStoreIcon")
        GameItemStoreIcon.itemname = item_data.item_name

        let GameItemStorePrice = $.CreatePanel("Panel", GameItemStore, "")
        GameItemStorePrice.AddClass("GameItemStorePrice")

        let GameItemStorePriceIcon = $.CreatePanel("Panel", GameItemStorePrice, "")
        GameItemStorePriceIcon.AddClass("GameItemStorePriceIcon")

        let GameItemStorePriceLabel = $.CreatePanel("Label", GameItemStorePrice, "GameItemStorePriceLabel")
        GameItemStorePriceLabel.AddClass("GameItemStorePriceLabel")
        GameItemStorePriceLabel.text = item_data.item_cost

        let ItemIsBuyingPanel = $.CreatePanel("Panel", GameItemStore, "")
        ItemIsBuyingPanel.AddClass("ItemIsBuyingPanel")

        let ItemIsBuyingPanelLabel = $.CreatePanel("Label", ItemIsBuyingPanel, "")
        ItemIsBuyingPanelLabel.AddClass("ItemIsBuyingPanelLabel")
        ItemIsBuyingPanelLabel.text = $.Localize("#levelup_black_store_bought")
    }

    let GameItemStoreIcon = GameItemStore.FindChildTraverse("GameItemStoreIcon")
    GameItemStoreIcon.itemname = item_data.item_name

    let GameItemStorePriceLabel = GameItemStore.FindChildTraverse("GameItemStorePriceLabel")
    GameItemStorePriceLabel.text = item_data.item_cost

    GameItemStore.SetHasClass("is_bought", item_data.is_bought != null)

    if (item_data.is_bought)
    {
        GameItemStore.ClearPanelEvent("onactivate")
    }
    else
    {
        GameItemStore.SetPanelEvent("onactivate", function()
        {
            GameEvents.SendCustomGameEventToServer( "event_player_buy_item_black_store", {item_store_slot : item_key} );
            UnFocusUI()
        })
    }
}

function UpdateBlackStoreButton()
{
    GameEvents.SendCustomGameEventToServer( "event_player_update_black_store", {});
    if (RefreshButtonStoreCircleBG && RefreshButtonStoreCircleBG.IsValid())
    {
        RefreshButtonStoreCircleBG.RemoveClass("RefreshStoreSpin")
        $.Schedule(0.0, function()
        {
            if (RefreshButtonStoreCircleBG && RefreshButtonStoreCircleBG.IsValid())
            {
                RefreshButtonStoreCircleBG.AddClass("RefreshStoreSpin")
            }
        })
    }
}

function UpdateSwapStatsPanel(data)
{
    SwapAttributesStatsPanel.SetHasClass("IsOpenSwapStats", data.active == 1)
    SwapAttributesStatsList.RemoveAndDeleteChildren()
    if (Object.values(data.slots).length > 0)
    {
        for (let change_id in data.slots)
        {
            let change_data = data.slots[change_id]
            CreatePanelSwapStats(change_data, change_id, SwapAttributesStatsList)
        }
    }
}

function CreatePanelSwapStats(change_data, change_id, SwapAttributesStatsList)
{
    let SwapStatsButton = $.CreatePanel("Panel", SwapAttributesStatsList, "")
    SwapStatsButton.AddClass("SwapStatsButton")
    SwapStatsButton.AddClass("SwapStatsButton_"+change_data[1]+"_"+change_data[2])
    SwapStatsButton.SetPanelEvent("onactivate", function()
    {
        GameEvents.SendCustomGameEventToServer( "event_player_change_stats_item", {choose_id : change_id} );
        SwapAttributesStatsPanel.SetHasClass("IsOpenSwapStats", false)
        UnFocusUI()
    })
    
    let SwapStatsButtonLabel = $.CreatePanel("Label", SwapStatsButton, "")
    SwapStatsButtonLabel.AddClass("SwapStatsButtonLabel")
    SwapStatsButtonLabel.text = $.Localize("#change_stats_"+change_data[1]+"_"+change_data[2])
}

function InitGameStart()
{
    GameEvents.SendCustomGameEventToServer( "event_player_request_game_start", {});
}

var SAVED_DIFFUCULTS_DATA = {}
var SAVED_CHOOSE_GAME_MODE = "normal"
var SAVED_CHOOSE_DIFFICULT = 1
var SAVED_CHOOSE_FLOOR = 1
var SAVED_LOBBY_OWNER_ID = -1
var SAVED_STAGES_CONNECTION = null
var SAVED_UNLOCK_ALL_STAGES = false
var START_GAME_INFO_CONTEXT = "game_mode"

const START_GAME_INFO_TABS = [
    { id: "unique_enemies", title: "#start_game_info_tab_unique_enemies" },
    { id: "equipment_drop", title: "#start_game_info_tab_equipment_drop" },
    { id: "equipment_boosts", title: "#start_game_info_tab_equipment_boosts" },
]

const START_GAME_MODE_INFO = {
    normal: {
        title: "#levelup_game_mode_normal",
        sections: [
            {
                title: "#start_game_info_mode_description_title",
                lines: [ "#start_game_info_mode_normal_description" ],
            },
        ],
    },
    hardcore: {
        title: "#levelup_game_mode_hardcore",
        sections: [
            {
                title: "#start_game_info_mode_description_title",
                lines: [ "#start_game_info_mode_hardcore_description" ],
            },
        ],
    },
    infinity: {
        title: "#levelup_game_mode_infinity",
        sections: [
            {
                title: "#start_game_info_mode_description_title",
                lines: [ "#start_game_info_mode_infinity_description" ],
            },
        ],
    },
    afk: {
        title: "#levelup_game_mode_afk",
        sections: [
            {
                title: "#start_game_info_mode_description_title",
                lines: [ "#start_game_info_mode_afk_description" ],
            },
        ],
    },
}

const START_GAME_DIFFICULTY_INFO = {
    "1": {
        title: "#start_game_info_difficulty_1_title",
        sections: {
            unique_enemies: [ "#start_game_info_enemy_golem" ],
            equipment_drop: [ "#start_game_info_select_floor_first" ],
            equipment_boosts: [ "#start_game_info_select_floor_first" ],
        },
    },
    "2": {
        title: "#start_game_info_difficulty_2_title",
        sections: {
            unique_enemies: [ "#start_game_info_enemy_golem", "#start_game_info_enemy_assassin" ],
            equipment_drop: [ "#start_game_info_select_floor_first" ],
            equipment_boosts: [ "#start_game_info_select_floor_first" ],
        },
    },
    "3": {
        title: "#start_game_info_difficulty_3_title",
        sections: {
            unique_enemies: [ "#start_game_info_enemy_golem", "#start_game_info_enemy_assassin", "#start_game_info_enemy_demolitionist" ],
            equipment_drop: [ "#start_game_info_select_floor_first" ],
            equipment_boosts: [ "#start_game_info_select_floor_first" ],
        },
    },
    "4": {
        title: "#start_game_info_difficulty_4_title",
        sections: {
            unique_enemies: [ "#start_game_info_enemy_golem", "#start_game_info_enemy_assassin", "#start_game_info_enemy_demolitionist", "#start_game_info_enemy_catapult" ],
            equipment_drop: [ "#start_game_info_select_floor_first" ],
            equipment_boosts: [ "#start_game_info_select_floor_first" ],
        },
    },
    "5": {
        title: "#start_game_info_difficulty_5_title",
        sections: {
            unique_enemies: [ "#start_game_info_enemy_golem", "#start_game_info_enemy_assassin", "#start_game_info_enemy_demolitionist", "#start_game_info_enemy_catapult", "#start_game_info_enemy_twin_gate" ],
            equipment_drop: [ "#start_game_info_select_floor_first" ],
            equipment_boosts: [ "#start_game_info_select_floor_first" ],
        },
    },
    "6": {
        title: "#start_game_info_difficulty_6_title",
        sections: {
            unique_enemies: [ "#start_game_info_enemy_golem", "#start_game_info_enemy_assassin", "#start_game_info_enemy_demolitionist", "#start_game_info_enemy_catapult", "#start_game_info_enemy_twin_gate", "#start_game_info_enemy_roshan_lair" ],
            equipment_drop: [ "#start_game_info_select_floor_first" ],
            equipment_boosts: [ "#start_game_info_select_floor_first" ],
        },
    },
    "7": {
        title: "#start_game_info_difficulty_7_title",
        sections: {
            unique_enemies: [ "#start_game_info_enemy_golem", "#start_game_info_enemy_assassin", "#start_game_info_enemy_demolitionist", "#start_game_info_enemy_catapult", "#start_game_info_enemy_twin_gate", "#start_game_info_enemy_roshan_lair", "#start_game_info_enemy_banner_bearer" ],
            equipment_drop: [ "#start_game_info_select_floor_first" ],
            equipment_boosts: [ "#start_game_info_select_floor_first" ],
        },
    },
}

const START_GAME_STAGE_INFO = {
    "1-1": { rarities: [ "common" ], minStars: 1, maxStars: 2, boosts: [ "#start_game_info_boost_none" ] },
    "1-2": { inherit: "1-1" },
    "1-3": { rarities: [ "common", "rare" ], minStars: 1, maxStars: 2, boosts: [ "#start_game_info_boost_none" ] },
    "1-4": { rarities: [ "common", "rare" ], minStars: 1, maxStars: 3, boosts: [ "#start_game_info_boost_none" ] },
    "1-5": { rarities: [ "common", "rare", "mythical" ], minStars: 1, maxStars: 3, boosts: [ "#start_game_info_boost_star_3" ] },
    "2-1": { rarities: [ "common", "rare", "mythical" ], minStars: 1, maxStars: 3, boosts: [ "#start_game_info_boost_star_3", "#start_game_info_boost_mythical" ] },
    "2-2": { inherit: "2-1" },
    "2-3": { inherit: "2-1" },
    "2-4": { rarities: [ "common", "rare", "mythical", "legendary" ], minStars: 1, maxStars: 3, boosts: [ "#start_game_info_boost_star_3", "#start_game_info_boost_mythical" ] },
    "2-5": { rarities: [ "common", "rare", "mythical", "legendary" ], minStars: 1, maxStars: 3, boosts: [ "#start_game_info_boost_star_3", "#start_game_info_boost_mythical", "#start_game_info_boost_legendary" ] },
    "3-1": { inherit: "2-5" },
    "3-2": { inherit: "2-5" },
    "3-3": { rarities: [ "common", "rare", "mythical", "legendary", "immortal" ], minStars: 1, maxStars: 3, boosts: [ "#start_game_info_boost_star_3", "#start_game_info_boost_mythical", "#start_game_info_boost_legendary" ] },
    "3-4": { rarities: [ "common", "rare", "mythical", "legendary", "immortal" ], minStars: 1, maxStars: 4, boosts: [ "#start_game_info_boost_star_3", "#start_game_info_boost_mythical", "#start_game_info_boost_legendary" ] },
    "3-5": { rarities: [ "common", "rare", "mythical", "legendary", "immortal" ], minStars: 1, maxStars: 4, boosts: [ "#start_game_info_boost_star_3", "#start_game_info_boost_star_4", "#start_game_info_boost_mythical", "#start_game_info_boost_legendary" ] },
    "4-1": { inherit: "3-5" },
    "4-2": { inherit: "3-5" },
    "4-3": { rarities: [ "common", "rare", "mythical", "legendary", "immortal", "super" ], minStars: 1, maxStars: 4, boosts: [ "#start_game_info_boost_star_3", "#start_game_info_boost_star_4", "#start_game_info_boost_legendary", "#start_game_info_boost_super" ] },
    "4-4": { inherit: "4-3" },
    "4-5": { inherit: "4-3" },
    "5-1": { rarities: [ "common", "rare", "mythical", "legendary", "immortal", "super" ], minStars: 2, maxStars: 5, boosts: [ "#start_game_info_boost_star_4", "#start_game_info_boost_star_5", "#start_game_info_boost_legendary", "#start_game_info_boost_super" ] },
    "5-2": { inherit: "5-1" },
    "5-3": { inherit: "5-1" },
    "5-4": { inherit: "5-1" },
    "5-5": { inherit: "5-1" },
    "6-1": { rarities: [ "mythical", "legendary", "immortal", "super" ], minStars: 2, maxStars: 5, boosts: [ "#start_game_info_boost_star_4", "#start_game_info_boost_star_5", "#start_game_info_boost_legendary", "#start_game_info_boost_super" ] },
    "6-2": { inherit: "6-1" },
    "6-3": { inherit: "6-1" },
    "6-4": { inherit: "6-1" },
    "6-5": { inherit: "6-1" },
    "7-1": { rarities: [ "legendary", "immortal", "super" ], minStars: 2, maxStars: 5, boosts: [ "#start_game_info_boost_star_5", "#start_game_info_boost_legendary", "#start_game_info_boost_super" ] },
    "7-2": { inherit: "7-1" },
    "7-3": { rarities: [ "legendary", "immortal", "super" ], minStars: 3, maxStars: 5, boosts: [ "#start_game_info_boost_star_5", "#start_game_info_boost_legendary", "#start_game_info_boost_super" ] },
    "7-4": { inherit: "7-3" },
    "7-5": { inherit: "7-3" },
}

const START_GAME_RARITY_COLORS = {
    common: "#ffffff",
    rare: "#6fc8ff",
    mythical: "#d35bff",
    legendary: "#ff9b2f",
    immortal: "#ff3d3d",
    super: "#ffd75c",
}

function StartGameInfoColorText(text, color)
{
    return "<font color=\"" + color + "\">" + text + "</font>"
}

function StartGameInfoGetRarityText(rarity)
{
    const key = "#start_game_info_equipment_rarity_" + String(rarity)
    return StartGameInfoColorText(StartGameInfoLocalize(key), START_GAME_RARITY_COLORS[String(rarity)] || "#ffffff")
}

function StartGameInfoLocalize(value, panel)
{
    if (!value) { return "" }
    if (String(value).indexOf("#") == 0)
    {
        return panel ? $.Localize(value, panel) : $.Localize(value)
    }
    return String(value)
}

function StartGameInfoResolveStage(stage_id)
{
    let info = START_GAME_STAGE_INFO[String(stage_id)]
    let guard = 0
    while (info && info.inherit && guard < 10)
    {
        guard += 1
        info = START_GAME_STAGE_INFO[String(info.inherit)]
    }
    return info || START_GAME_STAGE_INFO["1-1"]
}

function StartGameInfoSetTitle(title_key, stage_id)
{
    if (!StartGameInfoTitle) { return }
    if (stage_id)
    {
        StartGameInfoTitle.SetDialogVariable("stage", String(stage_id))
    }
    StartGameInfoTitle.text = StartGameInfoLocalize(title_key, StartGameInfoTitle)
}

function StartGameInfoCreateLine(parent, text, line_class, variables)
{
    let line = $.CreatePanel("Label", parent, "")
    line.AddClass("StartGameInfoLine")
    line.html = true
    if (line_class)
    {
        line.AddClass(line_class)
    }
    if (variables)
    {
        for (let name of Object.keys(variables))
        {
            line.SetDialogVariable(name, String(variables[name]))
        }
    }
    line.text = StartGameInfoLocalize(text, line)
    return line
}

function StartGameInfoCreateSection(parent, title, lines)
{
    let section = $.CreatePanel("Panel", parent, "")
    section.AddClass("StartGameInfoSection")

    let title_label = $.CreatePanel("Label", section, "")
    title_label.AddClass("StartGameInfoSectionTitle")
    title_label.text = StartGameInfoLocalize(title)

    for (let line_data of lines || [])
    {
        if (typeof line_data == "object")
        {
            if (line_data.type == "stars")
            {
                StartGameInfoCreateStarsLine(section, line_data.vars)
            }
            else
            {
                StartGameInfoCreateLine(section, line_data.text, line_data.className, line_data.vars)
            }
        }
        else
        {
            StartGameInfoCreateLine(section, line_data, "")
        }
    }
}

function StartGameInfoCreateStarsLine(parent, variables)
{
    let row = $.CreatePanel("Panel", parent, "")
    row.AddClass("StartGameInfoStarsLine")

    let icon = $.CreatePanel("Panel", row, "")
    icon.AddClass("StartGameInfoStarIcon")

    let label = $.CreatePanel("Label", row, "")
    label.AddClass("StartGameInfoLine")
    label.AddClass("StartGameInfoStarsLabel")
    label.html = true
    for (let name of Object.keys(variables || {}))
    {
        label.SetDialogVariable(name, String(variables[name]))
    }
    label.text = StartGameInfoLocalize("#start_game_info_stars_range", label)
}

function StartGameInfoRenderMode(mode)
{
    if (!StartGameInfoContent) { return }
    START_GAME_INFO_CONTEXT = "game_mode"
    let info = START_GAME_MODE_INFO[String(mode)] || START_GAME_MODE_INFO.normal
    StartGameInfoSetTitle(info.title)
    StartGameInfoContent.RemoveAndDeleteChildren()
    for (let section of info.sections)
    {
        StartGameInfoCreateSection(StartGameInfoContent, section.title, section.lines)
    }
}

function StartGameInfoRenderDifficulty(difficult)
{
    if (!StartGameInfoContent) { return }
    START_GAME_INFO_CONTEXT = "difficulty"
    let info = START_GAME_DIFFICULTY_INFO[String(difficult)] || START_GAME_DIFFICULTY_INFO["1"]
    StartGameInfoSetTitle(info.title)
    StartGameInfoContent.RemoveAndDeleteChildren()
    StartGameInfoCreateSection(StartGameInfoContent, "#start_game_info_tab_unique_enemies", info.sections.unique_enemies || [])
    StartGameInfoCreateSection(StartGameInfoContent, "#start_game_info_tab_equipment_drop", info.sections.equipment_drop || [])
    StartGameInfoCreateSection(StartGameInfoContent, "#start_game_info_tab_equipment_boosts", info.sections.equipment_boosts || [])
}

function StartGameInfoRenderFloor(difficult, floor)
{
    if (!StartGameInfoContent) { return }
    START_GAME_INFO_CONTEXT = "floor"
    let stage_id = String(difficult) + "-" + String(floor)
    let info = StartGameInfoResolveStage(stage_id)
    StartGameInfoSetTitle("#start_game_info_floor_title", stage_id)
    StartGameInfoContent.RemoveAndDeleteChildren()

    let difficulty_info = START_GAME_DIFFICULTY_INFO[String(difficult)] || START_GAME_DIFFICULTY_INFO["1"]
    StartGameInfoCreateSection(StartGameInfoContent, "#start_game_info_tab_unique_enemies", difficulty_info.sections.unique_enemies || [])

    let rarities = []
    for (let rarity of info.rarities || [])
    {
        rarities.push(StartGameInfoGetRarityText(rarity))
    }
    StartGameInfoCreateSection(StartGameInfoContent, "#start_game_info_tab_equipment_drop", [
        { text: "#start_game_info_equipment_rarity", className: "Highlight", vars: { rarities: rarities.join(" / ") } },
        { type: "stars", vars: { min: info.minStars || 1, max: info.maxStars || 1 } },
    ])
    StartGameInfoCreateSection(StartGameInfoContent, "#start_game_info_tab_equipment_boosts", info.boosts || [ "#start_game_info_boost_none" ])
}

function GetStartGameStageRank(stage_id)
{
    let parts = String(stage_id || "").split("-")
    if (parts.length != 2) { return 0 }
    return ((Number(parts[0]) || 0) * 100) + (Number(parts[1]) || 0)
}

function GetStartGamePlayerMaxStage(player_id)
{
    let table_name = SAVED_CHOOSE_GAME_MODE === "hardcore" ? "player_hardcore_difficult_complete" : "player_difficult_complete"
    let complete_list = Game.GetCustomTable(table_name, String(player_id))
    let best_id = ""
    let best_rank = 0
    if (complete_list)
    {
        for (let completed_id of Object.values(complete_list))
        {
            let stage_id = String(completed_id)
            let rank = GetStartGameStageRank(stage_id)
            if (rank > best_rank)
            {
                best_rank = rank
                best_id = stage_id
            }
        }
    }
    return { id: best_id, rank: best_rank }
}

function GetStartGameLobbyMaxStage()
{
    let best = { id: "", rank: 0 }
    for (let player_id = 0; player_id <= 10; player_id++)
    {
        if (!Players.IsValidPlayerID(player_id)) { continue }
        let player_best = GetStartGamePlayerMaxStage(player_id)
        if (player_best.rank > best.rank)
        {
            best = player_best
        }
    }
    return best
}

function RenderStartGameLobbyProgress()
{
    if (!StartGameLobbyProgressList) { return }
    StartGameLobbyProgressList.RemoveAndDeleteChildren()

    for (let player_id = 0; player_id <= 10; player_id++)
    {
        if (!Players.IsValidPlayerID(player_id)) { continue }
        let playerInfo = Game.GetPlayerInfo(player_id)
        if (!playerInfo) { continue }

        let row = $.CreatePanel("Panel", StartGameLobbyProgressList, "")
        row.AddClass("StartGameLobbyProgressRow")

        let avatar = $.CreatePanel("DOTAAvatarImage", row, "", { style: "width: 18px; height: 18px; vertical-align: center; margin-right: 7px;" })
        avatar.AddClass("StartGameLobbyProgressAvatar")
        avatar.steamid = playerInfo.player_steamid
        avatar.accountid = playerInfo.player_steamid

        let name = $.CreatePanel("Label", row, "")
        name.AddClass("StartGameLobbyProgressName")
        name.text = String(playerInfo.player_name || Players.GetPlayerName(player_id) || "")

        let best = GetStartGamePlayerMaxStage(player_id)
        let stage = $.CreatePanel("Label", row, "")
        stage.AddClass("StartGameLobbyProgressStage")
        stage.text = best.id != "" ? best.id : "1-1"
    }
}

function IsTruthyEventValue(value)
{
    return value === true || value === 1 || value === "1" || value === "true"
}

function PlayStartGameMusic()
{
    if (START_GAME_MUSIC_HANDLE !== -1)
    {
        return
    }
    START_GAME_MUSIC_HANDLE = Game.EmitSound("upup_music_start_game")
}

function StopStartGameMusic()
{
    if (START_GAME_MUSIC_HANDLE === -1)
    {
        return
    }
    Game.StopSound(START_GAME_MUSIC_HANDLE)
    START_GAME_MUSIC_HANDLE = -1
}

function MarkStartGameButtonActive(id)
{
    for (let child of StartGameSelectorList.Children())
    {
        child.SetHasClass("DifficultActive", child.id == ("DifficultButton_" + id))
    }
}

function MarkStartGameModeButtonActive(id)
{
    for (let child of StartGameSelectorList.Children())
    {
        child.SetHasClass("DifficultActive", child.id == ("DifficultButton_game_mode_" + id))
    }
}

function DrawGameStart(data)
{
    StartGamePanel.SetHasClass("Opened", true)
    PlayStartGameMusic()
    START_GAME_AFK_EXIT_MODE = IsTruthyEventValue(data.afk_exit_mode)
    START_GAME_RESTART_MODE = IsTruthyEventValue(data.restart_mode) || START_GAME_AFK_EXIT_MODE
    START_GAME_PICKER_PLAYER_ID = START_GAME_RESTART_MODE ? Game.GetLocalPlayerID() : -1
    StartGamePanel.SetHasClass("RestartMode", START_GAME_RESTART_MODE)
    if (StartGameRestartCloseButton)
    {
        StartGameRestartCloseButton.SetHasClass("VisibleRestartClose", START_GAME_RESTART_MODE)
    }
    let PFXPortalStartGame = $("#PFXPortalStartGame")
    PFXPortalStartGame.ReloadScene()
    PFXPortalStartGame.StartParticles()
    let lobby_owner_id = START_GAME_RESTART_MODE ? Game.GetLocalPlayerID() : data.lobby_owner_id
    SAVED_LOBBY_OWNER_ID = lobby_owner_id
    let stages_connection = data.stages_connection
    SAVED_STAGES_CONNECTION = stages_connection
    SAVED_UNLOCK_ALL_STAGES = IsTruthyEventValue(data.unlock_all_stages)  || (Game.IsInToolsMode && Game.IsInToolsMode())
    let waves_data = data.waves_data
    let difficult_data = {}
    for (let difficult_id of Object.keys(waves_data))
    {
        let floors_data = waves_data[difficult_id]
        difficult_data[difficult_id] = {}
        for (let floor_id of Object.keys(floors_data))
        {
            difficult_data[difficult_id][floor_id] = true
        }
    }
    SAVED_DIFFUCULTS_DATA = difficult_data
    RenderStartGameLobbyProgress()
    DrawSelectGameMode()
}

function CloseStartGame()
{
    StopStartGameMusic()
    StartGamePanel.SetHasClass("Opened", false)
    StartGamePanel.SetHasClass("RestartMode", false)
    if (StartGameRestartCloseButton)
    {
        StartGameRestartCloseButton.SetHasClass("VisibleRestartClose", false)
    }
    ClosePostStageRestartConfirmPanel()
    START_GAME_RESTART_MODE = false
    START_GAME_AFK_EXIT_MODE = false
    START_GAME_PICKER_PLAYER_ID = -1
}

function IsUnlockedDifficult(diff, floor)
{
    if (SAVED_UNLOCK_ALL_STAGES)
    {
        return true
    }
    if (!SAVED_STAGES_CONNECTION)
    {
        return false
    }
    if (SAVED_LOBBY_OWNER_ID === -1)
    {
        return false
    }
    let diff_checkout = diff + "-" + floor
    if (diff_checkout == "1-1")
    {
        return true
    }
    let target_rank = GetStartGameStageRank(diff_checkout)
    let lobby_best = GetStartGameLobbyMaxStage()
    if (target_rank <= 0 || lobby_best.rank <= 0)
    {
        return false
    }
    if (target_rank <= lobby_best.rank)
    {
        return true
    }

    let previous_stage = SAVED_STAGES_CONNECTION[diff_checkout]
    let previous_rank = GetStartGameStageRank(previous_stage)
    return previous_rank > 0 && previous_rank <= lobby_best.rank
}

function IsHardcoreUnlocked()
{
    let player_id = Game.GetLocalPlayerID()
    let complete_list = Game.GetCustomTable("player_difficult_complete", String(player_id))
    if (!complete_list) { return false }
    for (let completed_id of Object.values(complete_list))
    {
        if (String(completed_id) === "3-1") { return true }
    }
    return false
}

function DrawGameModeOption(id, text, is_active, lobby_owner_id, is_locked)
{
    let DifficultButton = $.CreatePanel("Panel", StartGameSelectorList, "DifficultButton_game_mode_" + id)
    DifficultButton.AddClass("DifficultButton")
    DifficultButton.SetHasClass("DifficultUnlocked", !is_locked)
    DifficultButton.SetHasClass("DifficultLocked", !!is_locked)
    DifficultButton.SetHasClass("DifficultActive", is_active)
    DifficultButton.SetHasClass("HardcoreButton", id === "hardcore")

    let DifficultButtonBG = $.CreatePanel("Panel", DifficultButton, "")
    DifficultButtonBG.AddClass("DifficultButtonBG")

    let DifficultButtonLabel = $.CreatePanel("Label", DifficultButton, "")
    DifficultButtonLabel.AddClass("DifficultButtonLabel")
    DifficultButtonLabel.text = text

    if (lobby_owner_id != Game.GetLocalPlayerID()) { return }
    if (is_locked) { return }

    DifficultButton.SetPanelEvent("onactivate", function()
    {
        if (!StartGamePanel.BHasClass("Opened")) { return }
        SAVED_CHOOSE_GAME_MODE = id
        MarkStartGameModeButtonActive(id)
        StartGameInfoRenderMode(id)
        if (!START_GAME_AFK_EXIT_MODE)
        {
            GameEvents.SendCustomGameEventToServer("event_player_select_start_game_button", {id : "game_mode_" + id});
        }
    })
}

function DrawSelectGameMode()
{
    SAVED_CHOOSE_GAME_MODE = "normal"
    StartGameSelectorList.RemoveAndDeleteChildren()
    StartGameControlsList.RemoveAndDeleteChildren()
    StartGameSelectorList.SetHasClass("HardcoreSelection", false)
    StartGameInfoRenderMode(SAVED_CHOOSE_GAME_MODE)

    let hardcore_unlocked = SAVED_UNLOCK_ALL_STAGES || IsHardcoreUnlocked()
    DrawGameModeOption("normal", $.Localize("#levelup_game_mode_normal"), true, SAVED_LOBBY_OWNER_ID, false)
    DrawGameModeOption("hardcore", $.Localize("#levelup_game_mode_hardcore"), false, SAVED_LOBBY_OWNER_ID, !hardcore_unlocked)
    DrawGameModeOption("infinity", $.Localize("#levelup_game_mode_infinity"), false, SAVED_LOBBY_OWNER_ID, false)
    if (!START_GAME_AFK_EXIT_MODE)
    {
        DrawGameModeOption("afk", $.Localize("#levelup_game_mode_afk"), false, SAVED_LOBBY_OWNER_ID, false)
    }

    DrawButtonStartGame(SAVED_LOBBY_OWNER_ID, $.Localize("#levelup_difficult_button_1"), function()
    {
        if (!StartGamePanel.BHasClass("Opened")) { return }
        if (SAVED_CHOOSE_GAME_MODE === "afk")
        {
            GameEvents.SendCustomGameEventToServer("event_player_select_start_game_button_agree", {game_mode : "afk"})
            return
        }
        if (SAVED_CHOOSE_GAME_MODE === "infinity")
        {
            if (START_GAME_RESTART_MODE)
            {
                OpenPostStageRestartConfirmPanel()
            }
            else
            {
                GameEvents.SendCustomGameEventToServer("event_player_select_start_game_button_agree", {game_mode : "infinity"})
            }
            return
        }
        if (START_GAME_RESTART_MODE)
        {
            DrawSelectDifficult()
        }
        else
        {
            GameEvents.SendCustomGameEventToServer("event_player_select_start_game_button_agree", {game_mode : SAVED_CHOOSE_GAME_MODE})
        }
    })
}

function DrawSelectDifficult()
{
    SAVED_CHOOSE_DIFFICULT = 1
    SAVED_CHOOSE_FLOOR = 1
    StartGameSelectorList.RemoveAndDeleteChildren()
    StartGameControlsList.RemoveAndDeleteChildren()
    StartGameSelectorList.SetHasClass("HardcoreSelection", SAVED_CHOOSE_GAME_MODE === "hardcore")
    StartGameInfoRenderDifficulty(SAVED_CHOOSE_DIFFICULT)
    for (let difficult_id of Object.keys(SAVED_DIFFUCULTS_DATA))
    {
        let difficult_fast_active = false
        let difficult_unlocked = false
        if (IsUnlockedDifficult(String(difficult_id), "1"))
        {
            difficult_unlocked = true
        }
        if (difficult_id == "1")
        {
            difficult_fast_active = true
        }
        DrawLevel(difficult_id, $.Localize("#levelup_difficult_portal"), difficult_unlocked, difficult_fast_active, true, SAVED_LOBBY_OWNER_ID)
    }
    DrawButtonStartGame(SAVED_LOBBY_OWNER_ID, $.Localize("#levelup_difficult_button_2"), function()
    {
        if (!StartGamePanel.BHasClass("Opened")) { return }
        if (START_GAME_RESTART_MODE)
        {
            DrawSelectGameMode()
            return
        }
        GameEvents.SendCustomGameEventToServer("event_player_select_start_game_button_agree", {back_to_mode : true})
    })
    DrawButtonStartGame(SAVED_LOBBY_OWNER_ID, $.Localize("#levelup_difficult_button_1"), function()
    {
        if (!StartGamePanel.BHasClass("Opened")) { return }
        if (START_GAME_RESTART_MODE)
        {
            DrawSelectFloor(SAVED_CHOOSE_DIFFICULT)
            return
        }
        GameEvents.SendCustomGameEventToServer("event_player_select_start_game_button_agree", {difficult : SAVED_CHOOSE_DIFFICULT, floor : SAVED_CHOOSE_FLOOR, is_difficult : true})
    })
}

function DrawSelectFloor(difficult)
{
    SAVED_CHOOSE_FLOOR = 1
    SAVED_CHOOSE_DIFFICULT = difficult
    let data_difficult = SAVED_DIFFUCULTS_DATA[String(difficult)]
    if (data_difficult)
    { 
        StartGameSelectorList.RemoveAndDeleteChildren()
        StartGameControlsList.RemoveAndDeleteChildren()
        StartGameSelectorList.SetHasClass("HardcoreSelection", SAVED_CHOOSE_GAME_MODE === "hardcore")
        StartGameInfoRenderFloor(SAVED_CHOOSE_DIFFICULT, SAVED_CHOOSE_FLOOR)
        for (let floor_id of Object.keys(data_difficult))
        {
            let difficult_fast_active = false
            let difficult_unlocked = false
            if (IsUnlockedDifficult(String(difficult), floor_id))
            {
                difficult_unlocked = true
            }
            if (floor_id == "1")
            {
                difficult_unlocked = true
                difficult_fast_active = true
            }
            DrawLevel(floor_id, $.Localize("#levelup_floor_portal"), difficult_unlocked, difficult_fast_active, false, SAVED_LOBBY_OWNER_ID)
        }
        DrawButtonStartGame(SAVED_LOBBY_OWNER_ID, $.Localize("#levelup_difficult_button_2"), function()
        {
            if (!StartGamePanel.BHasClass("Opened")) { return }
            if (START_GAME_RESTART_MODE)
            {
                DrawSelectDifficult()
                return
            }
            const eventName = START_GAME_RESTART_MODE ? "event_player_select_restart_game_button_agree" : "event_player_select_start_game_button_agree"
            GameEvents.SendCustomGameEventToServer(eventName, {difficult : SAVED_CHOOSE_DIFFICULT, floor : SAVED_CHOOSE_FLOOR, is_back : true});
        })
        DrawButtonStartGame(SAVED_LOBBY_OWNER_ID, $.Localize("#levelup_difficult_button_3"), function()
        {
            if (!StartGamePanel.BHasClass("Opened")) { return }
            if (START_GAME_RESTART_MODE)
            {
                OpenPostStageRestartConfirmPanel()
                return
            }
            GameEvents.SendCustomGameEventToServer("event_player_select_start_game_button_agree", {difficult : SAVED_CHOOSE_DIFFICULT, floor : SAVED_CHOOSE_FLOOR, game_mode : SAVED_CHOOSE_GAME_MODE});
        })
    }
}

function DrawButtonStartGame(lobby_owner_id, text, func)
{
    if (!StartGamePanel.BHasClass("Opened")) { return }
    let DifficultButton = $.CreatePanel("Panel", StartGameControlsList, "")
    DifficultButton.AddClass("DifficultButton")

    let DifficultButtonBG = $.CreatePanel("Panel", DifficultButton, "")
    DifficultButtonBG.AddClass("DifficultButtonBG")

    let DifficultButtonLabel = $.CreatePanel("Label", DifficultButton, "")
    DifficultButtonLabel.AddClass("DifficultButtonLabel")
    DifficultButtonLabel.text = text

    if (!START_GAME_RESTART_MODE && lobby_owner_id != Game.GetLocalPlayerID()) { return }

    DifficultButton.SetPanelEvent("onactivate", func)
}

function DrawLevel(id, text, is_unlocked, is_active, is_difficult, lobby_owner_id)
{
    let DifficultButton = $.CreatePanel("Panel", StartGameSelectorList, "DifficultButton_"+id)
    DifficultButton.AddClass("DifficultButton")
    DifficultButton.SetHasClass("DifficultUnlocked", is_unlocked)
    DifficultButton.SetHasClass("DifficultActive", is_active)

    let DifficultButtonBG = $.CreatePanel("Panel", DifficultButton, "")
    DifficultButtonBG.AddClass("DifficultButtonBG")

    let DifficultButtonLabel = $.CreatePanel("Label", DifficultButton, "")
    DifficultButtonLabel.AddClass("DifficultButtonLabel")
    DifficultButtonLabel.text = text + " " + id

    if (!START_GAME_RESTART_MODE && lobby_owner_id != Game.GetLocalPlayerID()) { return }

    if (is_unlocked)
    {
        if (is_difficult)
        {
            DifficultButton.SetPanelEvent("onactivate", function()
            {
                if (!StartGamePanel.BHasClass("Opened")) { return }
                SAVED_CHOOSE_DIFFICULT = id
                StartGameInfoRenderDifficulty(id)
                if (START_GAME_RESTART_MODE)
                {
                    MarkStartGameButtonActive(id)
                    return
                }
                const eventName = START_GAME_RESTART_MODE ? "event_player_select_restart_game_button" : "event_player_select_start_game_button"
                GameEvents.SendCustomGameEventToServer(eventName, {id : id});
            })
        }
        else
        {
            DifficultButton.SetPanelEvent("onactivate", function()
            {
                if (!StartGamePanel.BHasClass("Opened")) { return }
                SAVED_CHOOSE_FLOOR = id
                StartGameInfoRenderFloor(SAVED_CHOOSE_DIFFICULT, id)
                if (START_GAME_RESTART_MODE)
                {
                    MarkStartGameButtonActive(id)
                    return
                }
                const eventName = START_GAME_RESTART_MODE ? "event_player_select_restart_game_button" : "event_player_select_start_game_button"
                GameEvents.SendCustomGameEventToServer(eventName, {id : id});
            })
        }
    }
}

function UpdateBuff( buffPanel, queryUnit, buffSerial )
{
	var noBuff = ( buffSerial == -1 );
	buffPanel.SetHasClass( "no_buff", noBuff );
	buffPanel.Data().m_QueryUnit = queryUnit;
	buffPanel.Data().m_BuffSerial = buffSerial;
	buffPanel.QueryUnit = queryUnit;
	buffPanel.BuffID = buffSerial;
	if ( noBuff )
	{
		return;
	}
	
	var nNumStacks = Buffs.GetStackCount( queryUnit, buffSerial );
	buffPanel.SetHasClass( "is_debuff", Buffs.IsDebuff( queryUnit, buffSerial ) );
	buffPanel.SetHasClass( "has_stacks", ( nNumStacks > 0 ) );

	var stackCount = buffPanel.FindChildInLayoutFile( "StackCount" );
	var itemImage = buffPanel.FindChildInLayoutFile( "ItemImage" );
	var abilityImage = buffPanel.FindChildInLayoutFile( "AbilityImage" );
	if ( stackCount )
	{
		stackCount.text = nNumStacks;
	}
	
	var buffTexture = Buffs.GetTexture( queryUnit, buffSerial );
	var itemIdx = buffTexture.indexOf( "item_" );

	if ( itemIdx === -1 )
	{
		if ( itemImage ) itemImage.itemname = "";
		if ( abilityImage ) abilityImage.abilityname = buffTexture;
		buffPanel.SetHasClass( "item_buff", false );
		buffPanel.SetHasClass( "ability_buff", true );
	}
	else
	{
		if ( itemImage ) itemImage.itemname = buffTexture;
		if ( abilityImage ) abilityImage.abilityname = "";
		buffPanel.SetHasClass( "item_buff", true );
		buffPanel.SetHasClass( "ability_buff", false );
	}
}

function UpdateBuffs()
{
	var buffsListPanel = $( "#BuffsAndDebuffs" );
	if ( !buffsListPanel )
		return;

	var queryUnit = Players.GetLocalPlayerPortraitUnit();
	
	var nBuffs = Entities.GetNumBuffs( queryUnit );
	
	var nUsedPanels = 0;
	for ( var i = 0; i < nBuffs; ++i )
	{
		var buffSerial = Entities.GetBuff( queryUnit, i );
		if ( buffSerial == -1 )
			continue;

		if ( Buffs.IsHidden( queryUnit, buffSerial ) )
			continue;
		
		if ( nUsedPanels >= m_BuffPanels.length )
		{
			var buffPanel = $.CreatePanel( "Panel", buffsListPanel, "" ); 
			buffPanel.BLoadLayout( "file://{resources}/layout/custom_game/buff/buff.xml", false, false );
			m_BuffPanels.push( buffPanel );
		}

		var buffPanel = m_BuffPanels[ nUsedPanels ];
		UpdateBuff( buffPanel, queryUnit, buffSerial );
		
		nUsedPanels++;
	}

	for ( var i = nUsedPanels; i < m_BuffPanels.length; ++i )
	{
		var buffPanel = m_BuffPanels[ i ];
		UpdateBuff( buffPanel, -1, -1 );
	}
}

var MINIMAP_SETTINGS =
{
    default:
    {
       "ui-scale": "250%", 
       "transform" : "translateX(0px) translateY(0px)",
    },
    aghanim:
    {
        "ui-scale": "350%", 
        "transform" : "translateX(-265px) translateY(-15px)",
    },
    dummy:
    {
        "ui-scale": "350%",
        "transform" : "translateX(20px) translateY(220px)",
    },
    boss_rush:
    {
        "ui-scale": "350%",
        "transform" : "translateX(-15px) translateY(-275px)",
    },
    afk:
    {
        "ui-scale": "350%",
        "transform" : "translateX(-180px) translateY(220px)", 
    },
    twin_gate_island:
    {
        "ui-scale": "250%",
        "transform" : "translateX(180px) translateY(170px)",
    },
}

function MinimapUpdater()
{
    let current_map_name = Game.GetCustomTable("game_data", "current_minimap") || {}
    let local_player_id = Players.GetLocalPlayer()
    let player_minimap_data = Game.GetCustomTable("player_minimap", String(local_player_id)) || {}
    let current_minimap = player_minimap_data.current_minimap
    if (!current_minimap && current_map_name.players)
    {
        current_minimap = current_map_name.players[String(local_player_id)]
    }
    current_minimap = current_minimap || current_map_name.current_minimap || "default"
    let map_settings = MINIMAP_SETTINGS[current_minimap]
    if (map_settings)
    {
        for (let style_key in map_settings)
        {
            minimap_container.style[style_key] = map_settings[style_key]
        }
    }
}

function CreateDeathScreen(data)
{
    let DeathPanel = $("#DeathPanel")
    let video = $.CreatePanel("MoviePanel", DeathPanel, "DeathPanelMovie", { 
        src: "file://{resources}/videos/death.webm",
        repeat:"true",
        class:"DeathPanelMovie",
        autoplay:"onload",
    });
    DeathPanel.SetHasClass("DeathPanelVisible", true)
    let DeathLabelTimer = $.CreatePanel("Label", DeathPanel, "DeathLabelTimer")
    DeathLabelTimer.AddClass("DeathLabelTimer")
    DeathLabelTimer.text = (Number(data.time) > 0) ? Math.floor(data.time) : ""
    $.Schedule(0.1, function()
    {
        video.style.opacity = 1
    })
}

function DestroyDeathScreen()
{
    let DeathPanel = $("#DeathPanel")
    $.Schedule(0.6, function()
    {
        DeathPanel.SetHasClass("DeathPanelVisible", false)
    })
    let DeathPanelMovie = DeathPanel.FindChildTraverse("DeathPanelMovie")
    if (DeathPanelMovie)
    {
        DeathPanelMovie.DeleteAsync(1.5)
    }
    let DeathLabelTimer = DeathPanel.FindChildTraverse("DeathLabelTimer")
    if (DeathLabelTimer)
    {
        DeathLabelTimer.DeleteAsync(1.5)
    }
}

function UpdateDeathScreen(data)
{
    let DeathPanel = $("#DeathPanel")
    let DeathLabelTimer = DeathPanel.FindChildTraverse("DeathLabelTimer")
    if (DeathLabelTimer)
    {
        DeathLabelTimer.text = Math.floor(data.time)
    }
}

function UpdateGameHudServiceClaimNotifications()
{
    if (Game.UpdateServiceTopClaimNotifications)
    {
        Game.UpdateServiceTopClaimNotifications()
    }
}

function GetGameHudNotificationText(data, dialog_panel)
{
    if (!data)
    {
        return ""
    }

    if (data.loc_key)
    {
        let loc_key = String(data.loc_key || "")
        if (loc_key.indexOf("#") != 0)
        {
            loc_key = "#" + loc_key
        }

        let replacements = {
            value: data.value,
            step: data.step,
            level: data.level,
            count: data.count,
            stats: BuildGameHudNotificationStatsText(data.stats),
        }

        if (dialog_panel && dialog_panel.SetDialogVariable)
        {
            for (let key in replacements)
            {
                if (replacements[key] !== undefined && replacements[key] !== null)
                {
                    dialog_panel.SetDialogVariable(key, String(replacements[key]))
                }
            }
        }

        let text = $.Localize(loc_key, dialog_panel)
        for (let key in replacements)
        {
            if (replacements[key] !== undefined && replacements[key] !== null)
            {
                text = ReplaceGameHudNotificationToken(text, key, String(replacements[key]))
            }
        }

        return text
    }

    let text = ""
    text = data.text || data.message || ""
    text = String(text || "")
    if (text.indexOf("#") == 0)
    {
        text = $.Localize(text)
    }
    return text
}

function ReplaceGameHudNotificationToken(text, key, value)
{
    text = String(text || "")
    let string_token = "{s:" + key + "}"
    let int_token = "{d:" + key + "}"
    while (text.indexOf(string_token) != -1)
    {
        text = text.replace(string_token, value)
    }
    while (text.indexOf(int_token) != -1)
    {
        text = text.replace(int_token, value)
    }
    return text
}

function GetGameHudNotificationArray(table_data)
{
    if (!table_data)
    {
        return []
    }

    let result = []
    for (let key in table_data)
    {
        if (table_data[key])
        {
            result.push({ key: Number(key) || 0, value: table_data[key] })
        }
    }
    result.sort(function(a, b) { return a.key - b.key })
    return result.map(function(entry) { return entry.value })
}

function FormatGameHudNotificationNumber(value)
{
    let numeric_value = Number(value) || 0
    let prefix = numeric_value >= 0 ? "+" : ""
    if (Math.abs(numeric_value - Math.floor(numeric_value)) < 0.001)
    {
        return prefix + String(Math.floor(numeric_value))
    }
    return prefix + numeric_value.toFixed(1)
}

function GetGameHudNotificationStatName(stat_name)
{
    let key = String(stat_name || "")
    if (key == "")
    {
        return ""
    }

    let localized = $.Localize("#hud_stat_" + key)
    if (localized == "#hud_stat_" + key)
    {
        localized = $.Localize("#services_stat_" + key)
    }
    if (localized == "#services_stat_" + key)
    {
        localized = key
    }
    return localized
}

function BuildGameHudNotificationStatsText(stats)
{
    let list = GetGameHudNotificationArray(stats)
    let parts = []

    for (let i = 0; i < list.length; i++)
    {
        let stat_data = list[i]
        if (!stat_data)
        {
            continue
        }

        let stat_name = String(stat_data.stat || "")
        let value_text = FormatGameHudNotificationNumber(stat_data.value)
        if (String(stat_data.value_kind || "") == "pct" || stat_name.indexOf("_pct") >= 0)
        {
            value_text = value_text + "%"
        }

        let localized_stat_name = GetGameHudNotificationStatName(stat_name)
        if (localized_stat_name != "")
        {
            parts.push(value_text + " " + localized_stat_name)
        }
    }

    return parts.join(", ")
}

function ShowGameHudNotification(data)
{
    let container = GameHudNotifications || $("#GameHudNotifications")
    if (!container)
    {
        return
    }

    let text = GetGameHudNotificationText(data, container)
    if (text == "")
    {
        return
    }

    if (container.GetChildCount)
    {
        let overflow_count = Math.max(0, container.GetChildCount() - 7)
        let old_children = []
        for (let i = 0; i < overflow_count; i++)
        {
            let old_child = container.GetChild(i)
            if (old_child)
            {
                old_children.push(old_child)
            }
        }
        for (let i = 0; i < old_children.length; i++)
        {
            old_children[i].DeleteAsync(0)
        }
    }

    let duration = 2 // Number(data && data.duration) || 2
    
    let notification = $.CreatePanel("Panel", container, "")
    notification.AddClass("GameHudNotification")
    notification.style["transition-duration"] = "0s"
    notification.AddClass("GameHudNotificationClosing")
    notification.hittest = false
    
    let label = $.CreatePanel("Label", notification, "")
    label.AddClass("GameHudNotificationText")
    label.text = text

    $.Schedule(0.1, function()
    {
        if (notification && notification.IsValid())
        {
            notification.style["transition-duration"] = "0.2s"
            notification.RemoveClass("GameHudNotificationClosing")
        }
    })

    $.Schedule(duration, function()
    {
        if (notification && notification.IsValid())
        {
            notification.AddClass("GameHudNotificationClosing")
            notification.DeleteAsync(0.25)
        }
    })
}

function InitGameHudServiceClaimNotifications()
{
    if (Game._service_claim_notifications_ready)
    {
        return
    }

    if (!Game.SubscribeCustomTableListener)
    {
        $.Schedule(0.2, InitGameHudServiceClaimNotifications)
        return
    }

    Game._service_claim_notifications_ready = true
    let player_key = String(Players.GetLocalPlayer())
    Game.SubscribeCustomTableListener("services_player", player_key, UpdateGameHudServiceClaimNotifications)
    Game.SubscribeCustomTableListener("services_config", "profile", UpdateGameHudServiceClaimNotifications)
    Game.SubscribeCustomTableListener("services_config", "promo", UpdateGameHudServiceClaimNotifications)
    Game.SubscribeCustomTableListener("services_config", "battlepass", UpdateGameHudServiceClaimNotifications)
    GameEvents.Subscribe("event_services_inventory_update", function()
    {
        $.Schedule(0.05, UpdateGameHudServiceClaimNotifications)
    })
    UpdateGameHudServiceClaimNotifications()
}

GameEvents.Subscribe("game_event_hud_notification", ShowGameHudNotification)

var LAST_SAVE_CLIENT_ANCHOR = 0
var EXIT_GAME_DISCONNECT_PENDING = false

function GetExitGameNowUnix()
{
    return Math.floor(Date.now() / 1000)
}

function UpdateExitGameSaveLabel()
{
    let label = $("#ExitGameConfirmSaveLabel")
    if (!label || !label.IsValid()) return

    let is_old = false
    if (LAST_SAVE_CLIENT_ANCHOR <= 0)
    {
        label.text = $.Localize("#levelup_exit_last_save_unknown")
        is_old = true
    }
    else
    {
        let seconds = Math.max(0, GetExitGameNowUnix() - LAST_SAVE_CLIENT_ANCHOR)
        if (seconds < 60)
        {
            label.text = $.Localize("#levelup_exit_last_save_now")
        }
        else if (seconds < 3600)
        {
            label.SetDialogVariableInt("count", Math.floor(seconds / 60))
            label.text = $.Localize("#levelup_exit_last_save_minutes", label)
            is_old = seconds >= 600
        }
        else
        {
            label.SetDialogVariableInt("count", Math.floor(seconds / 3600))
            label.text = $.Localize("#levelup_exit_last_save_hours", label)
            is_old = true
        }
    }
    label.SetHasClass("ExitGameSaveOld", is_old)
}

GameEvents.Subscribe("event_save_status", function(data)
{
    let seconds_ago = Number(data && data.seconds_ago)
    if (isNaN(seconds_ago) || seconds_ago < 0)
    {
        UpdateExitGameSaveLabel()
        return
    }
    let anchor = GetExitGameNowUnix() - Math.floor(seconds_ago)
    if (anchor > LAST_SAVE_CLIENT_ANCHOR)
    {
        LAST_SAVE_CLIENT_ANCHOR = anchor
    }
    UpdateExitGameSaveLabel()
})

function ScheduleExitGameSaveLabelRefresh()
{
    $.Schedule(5.0, function()
    {
        let overlay = $("#ExitGameConfirmOverlay")
        if (!overlay || !overlay.IsValid()) return
        UpdateExitGameSaveLabel()
        ScheduleExitGameSaveLabelRefresh()
    })
}

function CloseExitGameConfirm()
{
    let overlay = $("#ExitGameConfirmOverlay")
    if (overlay) overlay.DeleteAsync(0)
    Game.EmitSound("General.ButtonClick")
}

function ExitGameDisconnectNow()
{
    let overlay = $("#ExitGameConfirmOverlay")
    if (overlay) overlay.DeleteAsync(0)
    Game.EmitSound("General.ButtonClick")
    EXIT_GAME_DISCONNECT_PENDING = false
    $.DispatchEvent("DOTAHUDShowDashboard")
}

GameEvents.Subscribe("event_player_exit_ready", function()
{
    if (EXIT_GAME_DISCONNECT_PENDING)
    {
        ExitGameDisconnectNow()
    }
})

function ConfirmExitGameLeave()
{
    if (EXIT_GAME_DISCONNECT_PENDING) return
    EXIT_GAME_DISCONNECT_PENDING = true
    GameEvents.SendCustomGameEventToServer("event_player_exit_save", {})
    $.Schedule(1.5, function()
    {
        if (EXIT_GAME_DISCONNECT_PENDING)
        {
            ExitGameDisconnectNow()
        }
    })
}

function OpenExitGameConfirm()
{
    let existing = $("#ExitGameConfirmOverlay")
    if (existing)
    {
        existing.DeleteAsync(0)
        return
    }

    GameEvents.SendCustomGameEventToServer("event_request_save_status", {})

    let overlay = $.CreatePanel("Panel", $.GetContextPanel(), "ExitGameConfirmOverlay")
    overlay.AddClass("ExitGameConfirmOverlay")
    overlay.hittest = true
    overlay.SetPanelEvent("onactivate", CloseExitGameConfirm)

    let window = $.CreatePanel("Panel", overlay, "")
    window.AddClass("ExitGameConfirmWindow")
    window.hittest = true
    window.SetPanelEvent("onactivate", function() {})

    let title = $.CreatePanel("Label", window, "")
    title.AddClass("ExitGameConfirmTitle")
    title.text = $.Localize("#levelup_exit_confirm_title")

    let saveLabel = $.CreatePanel("Label", window, "ExitGameConfirmSaveLabel")
    saveLabel.AddClass("ExitGameConfirmSaveLabel")

    let buttons = $.CreatePanel("Panel", window, "")
    buttons.AddClass("ExitGameConfirmButtons")

    let leave = $.CreatePanel("Panel", buttons, "")
    leave.AddClass("ExitGameConfirmButton")
    leave.AddClass("ExitGameLeaveButton")
    leave.hittest = true
    leave.SetPanelEvent("onactivate", ConfirmExitGameLeave)
    $.CreatePanel("Label", leave, "").text = $.Localize("#levelup_exit_confirm_leave")

    let stay = $.CreatePanel("Panel", buttons, "")
    stay.AddClass("ExitGameConfirmButton")
    stay.hittest = true
    stay.SetPanelEvent("onactivate", CloseExitGameConfirm)
    $.CreatePanel("Label", stay, "").text = $.Localize("#levelup_exit_confirm_stay")

    UpdateExitGameSaveLabel()
    ScheduleExitGameSaveLabelRefresh()
    Game.EmitSound("General.ButtonClick")
}

Init()
InitGameHudServiceClaimNotifications()

// ===== Инвентарь нейтральных предметов (перенесено из отдельного neutral_inventory) =====
const NEUTRAL_PLAYER_ID = Players.GetLocalPlayer()
const NeutralInventoryPanel = $("#NeutralInventoryPanel")
const NeutralsList = $("#NeutralsList")
const ActiveNeutralsList = $("#ActiveNeutralsList")
const RoshpitIndicatorPanel = $("#RoshpitIndicatorPanel")
const NeutralsCraftButton = $("#NeutralsCraftButton")

if (NeutralsCraftButton && typeof ShowTextForPanel === "function") {
    ShowTextForPanel(NeutralsCraftButton, "#neutral_inventory_craft_tooltip")
}

if (RoshpitIndicatorPanel && typeof ShowTextForPanel === "function") {
    ShowTextForPanel(RoshpitIndicatorPanel, "#neutral_roshpit_indicator_tooltip")
}

function NeutralSubscribeAndFire(tableName, keyName, callback){
    const currentValue = Game.GetCustomTable(tableName, keyName);
    if (currentValue) {
        callback(currentValue);
    }
    return Game.SubscribeCustomTableListener(tableName, (name, key, values) => {
        if (key == keyName) {
            callback(values);
        }
    });
}

function NeutralSafeDeleteAsync(p){
    if(p && p.IsValid()){
        p.DeleteAsync(0)
    }
}

let NEUTRAL_STATE = "not_active"
let NEUTRAL_SETTINGS = {}
let NEUTRAL_ITEMS = {}
let NEUTRAL_ROSHPIT = {}

// Получаем здесь настройки инвентаря
NeutralSubscribeAndFire("neutral_items", `settings`, function(v){
    NEUTRAL_SETTINGS = v
})
// Получаем текущее состояние системы и прячем панели если они не нужны
NeutralSubscribeAndFire("neutral_items", `state`, function(v){
    NEUTRAL_STATE = v.state

    $.GetContextPanel().SetHasClass("IsNeutralsActive", NEUTRAL_STATE == "active")
})
// Получаем текущий инвентарь игрока и обновляем его
NeutralSubscribeAndFire("neutral_items", `player_${NEUTRAL_PLAYER_ID}`, function(v){
    NEUTRAL_ITEMS = v

    UpdateNeutralInventory()
})
// Получаем информацию о рошпите игрока
NeutralSubscribeAndFire("neutral_items", `player_roshpit_${NEUTRAL_PLAYER_ID}`, function(v){
    NEUTRAL_ROSHPIT = v

    UpdateNeutralRoshpit()
})

function UpdateNeutralInventory(){
    let PassiveSlots = NEUTRAL_SETTINGS.passive_slots || 0
    let MaxSlots = NEUTRAL_SETTINGS.passive_slots == undefined ? 0 : NEUTRAL_SETTINGS.passive_slots + NEUTRAL_SETTINGS.active_slots
    for (let i = 1; i <= MaxSlots; i++) {
        let SlotID = i.toString()
        let SlotData = NEUTRAL_ITEMS[SlotID]

        let Container = i > PassiveSlots ? ActiveNeutralsList : NeutralsList

        let p = GetOrCreateNeutralSlot(Container, SlotID)

        p.SetHasClass("IsActiveNeutralSlot", i > PassiveSlots)

        let Rarity = 0
        let ItemName = ""
        if(SlotData){
            ItemName = SlotData.item_name
            Rarity = SlotData.rarity

            SetCustomTooltip(p, "neutral_item_tooltip", {item_name : ItemName})

            $.RegisterEventHandler( 'DragStart', p, function(a, dragCallbacks ){
                $.DispatchEvent("UIHideCustomLayoutTooltip", p, "neutral_item_tooltip_custom");

                p.AddClass("dragging_from")
                let panel = $.CreatePanel( "Image", NeutralInventoryPanel, "", {
                    class: "DragImage",
                    scaling: "stretch-to-fit-y-preserve-aspect"
                });
                panel.SetImage(`file://{images}/neutral_items/${SlotData.item_name}.png`)
                panel.slot_from = SlotID

                dragCallbacks.displayPanel = panel;
                dragCallbacks.offsetX = 0;
                dragCallbacks.offsetY = 0;
                return true
            } );

            $.RegisterEventHandler( 'DragEnd', p, function(a, draggedPanel ){
                p.RemoveClass("dragging_from")
                NeutralSafeDeleteAsync(draggedPanel)
                return true
            } );
        }else{
            p.ClearPanelEvent("onmouseover")

            $.RegisterEventHandler( 'DragStart', p, function(a, dragCallbacks ){
                return true
            } );

            $.RegisterEventHandler( 'DragEnd', p, function(a, draggedPanel ){
                return true
            } );
        }

        for (let j = 1; j <= 7; j++) {
            p.SetHasClass(`Rarity_${j}`, j == Rarity)
        }

        let ItemImage = p.FindChildTraverse("ItemImage")
        if(ItemImage){
            ItemImage.SetImage(`file://{images}/neutral_items/${ItemName}.png`)
        }

        const CooldownPanel = p.FindChildTraverse("ItemCooldownPanel")
        if(CooldownPanel){
            CooldownPanel.visible = false
            CooldownPanel.SetHasClass("IsCoolingDown", false)
        }

        $.RegisterEventHandler( 'DragDrop', p, function(a, draggedPanel ){
            if(Entities.IsControllableByPlayer(Players.GetLocalPlayerPortraitUnit(), NEUTRAL_PLAYER_ID)){
                GameEvents.SendCustomGameEventToServer("event_player_swap_neutral_items", { Slot1: draggedPanel.slot_from, Slot2: SlotID });
            }

            return true
        })

        $.RegisterEventHandler( 'DragEnter', p, function(a, draggedPanel ){
            p.AddClass("potential_drop_target")
            return true
        });

        $.RegisterEventHandler( 'DragLeave', p, function(a, draggedPanel ){
            p.RemoveClass("potential_drop_target")
            return true
        });
    }
}

function UpdateNeutralItemCooldowns(){
    const PassiveSlots = Number(NEUTRAL_SETTINGS.passive_slots || 0)
    const ActiveSlots = Number(NEUTRAL_SETTINGS.active_slots || 0)
    const Now = Math.max(0, Game.GetGameTime())

    for(let i = PassiveSlots + 1; i <= PassiveSlots + ActiveSlots; i++){
        const SlotID = i.toString()
        const SlotPanel = ActiveNeutralsList.FindChildTraverse(`Item_${SlotID}`)
        if(!SlotPanel) continue

        const CooldownPanel = SlotPanel.FindChildTraverse("ItemCooldownPanel")
        if(!CooldownPanel) continue

        const SlotData = NEUTRAL_ITEMS[SlotID]
        const CooldownEndTime = Number(SlotData?.cooldown_end_time || 0)
        const CooldownDuration = Number(SlotData?.cooldown_duration || 0)
        const Remaining = Math.max(0, CooldownEndTime - Now)
        const IsCoolingDown = Boolean(SlotData) && CooldownDuration > 0 && Remaining > 0

        CooldownPanel.visible = IsCoolingDown
        CooldownPanel.SetHasClass("IsCoolingDown", IsCoolingDown)
        if(IsCoolingDown){
            const Progress = (Remaining / CooldownDuration) * -360
            if(!isNaN(Progress)){
                CooldownPanel.style.clip = `radial( 50% 50%, 0deg, ${Progress}deg )`
            }
        }
    }

    $.Schedule(0.1, UpdateNeutralItemCooldowns)
}

function UpdateNeutralRoshpit(){
    let bActive = NEUTRAL_ROSHPIT.is_alive == 1 || NEUTRAL_ROSHPIT.is_alive === true
    RoshpitIndicatorPanel.SetHasClass("IsAlive", bActive)
}

function CraftNeutralItems(){
    GameEvents.SendCustomGameEventToServer("event_player_craft_neutral_items", { });
}

function ToggleNeutralInventory(){
    $.GetContextPanel().ToggleClass("NeutralsToggled")
}

function GetOrCreateNeutralSlot(Container, SlotID){
    let f = Container.FindChildTraverse(`Item_${SlotID}`)
    if(f){
        return f
    }else{
        let p = $.CreatePanel("Panel", Container, `Item_${SlotID}`, {})
        p.BLoadLayoutSnippet("NeutralInventoryItem")

        return p
    }
}

UpdateNeutralItemCooldowns()