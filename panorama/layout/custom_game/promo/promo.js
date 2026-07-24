--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var TAB_TASKS = "tasks"
var TAB_DAILY = "daily"
var TAB_INVITES = "invites"
var TAB_LOGIN = "login"
var TAB_SURVEY = "survey"
var TAB_AHEAD = "ahead"
var TAB_EVENT = "event"

var TASK_GROUP = "daily"
var AHEAD_GROUP = "daily"
var EVENT_GROUP = "daily"
var CURRENT_TAB = TAB_TASKS

var TABS = [
    { id: TAB_TASKS, title: $.Localize("#services_promo_tab_tasks"), badge: true },
    { id: TAB_DAILY, title: $.Localize("#services_promo_tab_daily_login") },
    { id: TAB_EVENT, title: $.Localize("#services_promo_tab_event"), badge: true },
    { id: TAB_INVITES, title: $.Localize("#services_promo_tab_invites"), badge: true },
    { id: TAB_SURVEY, title: $.Localize("#services_promo_tab_survey") },
    //{ id: TAB_AHEAD, title: $.Localize("#services_promo_tab_ahead") },
]

var CURRENCIES = [
    { icon: "file://{images}/game_hud/icons/gold.png", amount: "10786" },
    { icon: "file://{images}/game_hud/icons/wood.png", amount: "0" },
    { icon: "file://{images}/game_hud/icons/refresh.png", amount: "4" },
    { icon: "file://{images}/game_hud/icons/kills_2.png", amount: "31" },
]
var promo_render_deferred = false
var promo_player_data_override = null

var TASKS = {
    progress: 0,
    total: 50,
    nodes: [],
    claimed: {},
    daily: [],
    monthly: [],
    yearly: [],
    unique: [],
}

var DAILY = CalendarData($.Localize("#services_promo_tab_daily_login"), $.Localize("#services_promo_tab_daily_login"), $.Localize("#services_promo_daily_info"), 1, [], [], "PromoCalendarThemeMoon")

var LOGIN = CalendarData($.Localize("#services_promo_tab_daily_login"), $.Localize("#services_promo_tab_daily_login"), $.Localize("#services_promo_daily_info"), 1, [], [], "PromoCalendarThemeFire")

var INVITES = {
    invite_code: "",
    invited_count: 0,
    exchange_code: "",
    bind_code: "",
    cards: [],
}

var SURVEY = {
    submitted: false,
    recommend: true,
    selected: ["friend"],
    sources: ["library", "friend", "tiktok", "youtube"],
    rewards: [],
    feedback: "",
}

var SURVEY_FEEDBACK_MAX_WORDS = 500

var AHEAD = {
    progress: 0,
    cost_1: 0,
    cost_10: 0,
    end_time: "",
    daily: [],
    claim: [],
    history: [],
}

var EVENT = {
    active: false,
    event_id: "",
    title: "",
    currency: { icon: "file://{images}/game_hud/services/leaf.png", name: "", hint: "", amount: 0 },
    cost: 10,
    batch: [1, 10],
    waterings: 0,
    remaining_seconds: 0,
    daily: [],
    accumulative: [],
    permanent: [],
    claimable: { daily: false, accumulative: false, permanent: false },
}

function ListHasClaimable(list)
{
    for (let i = 0; i < list.length; i++)
    {
        if (list[i] && list[i].can_claim) return true
    }
    return false
}
const Sidebar = $("#PromoSidebar")
const CurrencyRow = $("#PromoCurrencyRow")
const SectionBody = $("#PromoSectionBody")
const Frame = $("#PromoContentFrame")

function R(icon, count, rarity, item_id) { return { icon: icon, count: count, rarity: rarity || "common", id: item_id || "" } }
function Task(title, progress, goal, rewards, can_claim, description) { return { title: title, progress: progress, goal: goal, rewards: rewards, can_claim: !!can_claim, description: description || "" } }
function Day(day, rewards) { return { day: day, rewards: rewards } }
function CalendarData(sub, title, info, today, claimed, days, theme) { return { title_sub: sub, title: title, info: info, today: today, claimed: claimed, days: days, theme: theme } }
function InviteCard(title, progress, rewards, can_claim, claimed) { return { title: title, progress: progress, rewards: rewards, can_claim: !!can_claim, claimed: !!claimed } }

function NormalizeSurveyFeedback(text)
{
    text = String(text || "").replace(/\s+/g, " ").replace(/^\s+|\s+$/g, "")
    if (!text) return ""

    let words = text.split(/\s+/)
    if (words.length > SURVEY_FEEDBACK_MAX_WORDS)
    {
        words = words.slice(0, SURVEY_FEEDBACK_MAX_WORDS)
        text = words.join(" ")
    }

    return text
}

function GetSurveyFeedbackWordCount(text)
{
    text = NormalizeSurveyFeedback(text)
    if (!text) return 0
    return text.split(/\s+/).length
}

function CacheCurrentSurveyFeedback()
{
    let feedbackEntry = $("#PromoSurveyFeedbackEntry")
    if (feedbackEntry && feedbackEntry.IsValid && feedbackEntry.IsValid())
    {
        SURVEY.feedback = String(feedbackEntry.text || "")
    }
}

function TableToArray(data)
{
    if (!data) return []
    if (data instanceof Array) return data
    let result = []
    let keys = Object.keys(data)
    keys.sort(function(a, b) { return (Number(a) || 0) - (Number(b) || 0) })
    for (let i = 0; i < keys.length; i++)
    {
        result.push(data[keys[i]])
    }
    return result
}

function GetLocalPlayerKey()
{
    return String(Players.GetLocalPlayer())
}

function GetServiceItems()
{
    return Game.GetCustomTable ? Game.GetCustomTable("services_config", "items") : {}
}

function GetServicePromoConfig()
{
    return Game.GetCustomTable ? Game.GetCustomTable("services_config", "promo") : {}
}

function GetServicePromoEventsConfig()
{
    return Game.GetCustomTable ? Game.GetCustomTable("services_config", "promo_events") : {}
}

function FindPromoEventConfigById(event_id)
{
    let config = GetServicePromoEventsConfig()
    let events = TableToArray(config && config.events)
    for (let i = 0; i < events.length; i++)
    {
        if (events[i] && String(events[i].id) === String(event_id)) return events[i]
    }
    return null
}

function LocalizeTemplateCount(key, count)
{
    let text = $.Localize(key)
    return String(text).replace(/\{n\}/g, String(count))
}

function GetServicePlayerData()
{
    if (promo_player_data_override)
    {
        return promo_player_data_override
    }
    return Game.GetCustomTable ? Game.GetCustomTable("services_player", GetLocalPlayerKey()) : {}
}

function MergePromoPlayerData(base_data, patch_data)
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

function OnPromoInventoryUpdate(data)
{
    let base_data = promo_player_data_override || (Game.GetCustomTable ? Game.GetCustomTable("services_player", GetLocalPlayerKey()) : {})
    promo_player_data_override = MergePromoPlayerData(base_data, data || {})
    RenderPromoFromServices()
}

function GetPromoClaimNotificationState()
{
    return Game.GetServiceClaimState ? (Game.GetServiceClaimState().promo || {}) : {}
}

function IsPromoSidebarTabClaimable(tab_id)
{
    let state = GetPromoClaimNotificationState()
    if (tab_id === TAB_TASKS) return !!state.tasks
    if (tab_id === TAB_DAILY || tab_id === TAB_LOGIN) return !!state.daily_login
    if (tab_id === TAB_INVITES) return !!state.invites
    if (tab_id === TAB_EVENT) return !!state.event
    return false
}

function IsPromoTaskGroupClaimable(group_id)
{
    if (CURRENT_TAB === TAB_EVENT)
    {
        return !!(EVENT.claimable && EVENT.claimable[group_id])
    }
    let state = GetPromoClaimNotificationState()
    return !!(state.task_groups && state.task_groups[group_id])
}

function UpdatePromoClaimNotifications()
{
    if (Game.UpdateServiceTopClaimNotifications)
    {
        Game.UpdateServiceTopClaimNotifications()
    }
}

function GetRarityRank(rarity)
{
    let order = { common: 0, rare: 1, mythical: 2, legendary: 3, immortal: 4 }
    return order[String(rarity || "common")] || 0
}

function GetRewardRarityByIcon(icon)
{
    let items = GetServiceItems()
    let best_rarity = "common"
    for (let item_id in items)
    {
        let item = items[item_id] || {}
        if ((item.icon === icon || item.card_icon === icon || item.preview_icon === icon) && GetRarityRank(item.rarity) > GetRarityRank(best_rarity))
        {
            best_rarity = item.rarity || "common"
        }
    }
    return best_rarity
}

function GetRewardRarity(reward)
{
    if (reward && reward.rarity && reward.rarity !== "common")
    {
        return reward.rarity
    }
    return GetRewardRarityByIcon(reward && reward.icon)
}

function AddRarityClass(panel, rarity)
{
    if (panel && rarity && rarity !== "common")
    {
        panel.AddClass("RareColor_" + rarity)
    }
}

function RewardsToUi(rewards, items)
{
    let result = []
    let rewards_list = TableToArray(rewards)
    for (let i = 0; i < rewards_list.length; i++)
    {
        let reward = rewards_list[i]
        let item = items[reward.id] || {}
        let ui_reward = R(item.icon || "file://{images}/game_hud/icons/gold.png", reward.count || 1, item.rarity || reward.rarity || "common")
        ui_reward.id = reward.id
        result.push(ui_reward)
    }
    return result
}

function LocalizeOrText(value)
{
    if (!value) return ""
    let key = String(value)
    let localized = $.Localize("#" + key)
    return localized && localized !== "#" + key ? localized : key
}

function QuestGroupToTasks(group_id, group_config, player_quest_data, items, quest_access)
{
    let result = []
    let quest_list = TableToArray(group_config && group_config.list)
    let group_state = player_quest_data[group_id] || {}
    let locked = quest_access && quest_access[group_id] === false
    let locked_text = $.Localize("#services_promo_task_locked")
    let required_card = String((group_config && group_config.required_monthly_card) || "")
    if (required_card === "monthly_basic") locked_text = $.Localize("#services_promo_requires_monthly_card")
    else if (required_card === "monthly_premium") locked_text = $.Localize("#services_promo_requires_premium_card")
    for (let i = 0; i < quest_list.length; i++)
    {
        let quest_config = quest_list[i] || {}
        let quest_id = quest_config.id || ""
        let quest_state = group_state[quest_id] || {}
        let progress = Number(quest_state.progress) || 0
        let goal = Number(quest_config.goal || quest_state.goal) || 1
        let claimed = !!quest_state.claimed
        let task = Task(LocalizeOrText(quest_config.name || quest_state.name || quest_id), progress, goal, RewardsToUi(quest_config.rewards || quest_state.rewards || [], items), !locked && progress >= goal && !claimed)
        task.id = quest_id
        task.group_id = group_id
        task.claimed = claimed
        task.locked = locked
        if (locked) task.description = locked_text
        result.push(task)
    }
    return result
}

function RefreshTasksFromServices(promo_config, player_data, items)
{
    let quest_config = promo_config.quests || {}
    let quest_data = player_data.quest_data || {}
    let quest_access = player_data.quest_access || {}
    let week_data = quest_data.week_all_quest_data || {}
    let week_rewards = TableToArray(promo_config.quest_week_rewards)
    let nodes = []
    let total = 0

    for (let i = 0; i < week_rewards.length; i++)
    {
        let reward_config = week_rewards[i] || {}
        let completed = Number(reward_config.completed) || 0
        total = Math.max(total, completed)
        nodes.push({
            reward_index: i + 1,
            completed: completed,
            rewards: RewardsToUi(reward_config.rewards || [], items),
            claimed: !!(week_data.claimed && week_data.claimed[String(i + 1)]),
        })
    }

    TASKS.progress = Number(week_data.completed) || 0
    TASKS.total = total || 50
    TASKS.nodes = nodes
    TASKS.claimed = week_data.claimed || {}
    TASKS.daily = QuestGroupToTasks("day_quest_data", quest_config.day_quest_data || {}, quest_data, items, quest_access)
    TASKS.monthly = QuestGroupToTasks("month_sub_quest_data", quest_config.month_sub_quest_data || {}, quest_data, items, quest_access)
    TASKS.yearly = QuestGroupToTasks("year_sub_quest_data", quest_config.year_sub_quest_data || {}, quest_data, items, quest_access)
}

function RefreshPromoDataFromServices()
{
    let items = GetServiceItems()
    let promo_config = GetServicePromoConfig()
    let player_data = GetServicePlayerData()
    if (!player_data || !Object.keys(player_data).length)
    {
        return false
    }

    let currencies = player_data.economy_data || {}
    CURRENCIES = ["coin", "stone", "moon", "sand_time", "magic_crystal"].map(function(currency_id)
    {
        let item = items[currency_id] || {}
        return { id: currency_id, icon: item.icon || "file://{images}/game_hud/icons/gold.png", amount: String(currencies[currency_id] || 0) }
    })

    RefreshTasksFromServices(promo_config, player_data, items)

    if (promo_config.daily_login)
    {
        let daily_data = player_data.everyday_player_online_data || {}
        let day = Math.max(1, Math.min(7, Number(daily_data.day) || 1))
        let claimed = []
        for (let i = 1; i < day; i++) claimed.push(i)
        let days = []
        for (let i = 1; i <= 7; i++)
        {
            days.push(Day(i, RewardsToUi(promo_config.daily_login[i] || [], items)))
        }
        DAILY = CalendarData($.Localize("#services_promo_tab_daily_login"), $.Localize("#services_promo_tab_daily_login"), $.Localize("#services_promo_daily_info"), day, claimed, days, "PromoCalendarThemeMoon")
        DAILY.can_claim = !!player_data.daily_login_can_claim
    }

    let invite_config = promo_config.invite || {}
    let invite_data = player_data.friends_invite_data || {}
    INVITES.invite_code = player_data.invite_code || GetLocalPlayerKey()
    INVITES.invited_count = Number(invite_data.invited_count) || 0
    INVITES.bound = !!invite_data.inviter_id
    INVITES.bind_code = invite_data.inviter_id || ""
    let bind_claimed = !!(invite_data.claimed && invite_data.claimed.bind)
    INVITES.cards = [
        InviteCard($.Localize("#services_promo_bind_reward"), INVITES.bound ? $.Localize("#services_promo_bound") : $.Localize("#services_promo_after_bind"), RewardsToUi(invite_config.bind_reward || [], items), INVITES.bound && !bind_claimed, bind_claimed),
    ]
    INVITES.cards[0].reward_index = 0
    let invite_rewards = TableToArray(invite_config.invited_rewards)
    for (let i = 0; i < invite_rewards.length; i++)
    {
        let reward = invite_rewards[i]
        let index = i + 1
        let claimed = invite_data.claimed && invite_data.claimed[String(index)]
        let can_claim = INVITES.invited_count >= (Number(reward.invites) || 0) && !claimed
        INVITES.cards.push(InviteCard($.Localize("#services_promo_invite_reward"), String(INVITES.invited_count) + "/" + String(reward.invites || 0), RewardsToUi(reward.rewards || [], items), can_claim, !!claimed))
        INVITES.cards[INVITES.cards.length - 1].reward_index = index
    }

    if (promo_config.survey)
    {
        SURVEY.submitted = !!(player_data.survey_data && player_data.survey_data.completed)
        let saved_answers = (player_data.survey_data && player_data.survey_data.answers) || {}
        let saved_feedback = String(saved_answers.feedback || "")
        if (SURVEY.submitted || !SURVEY.feedback)
        {
            SURVEY.feedback = saved_feedback
        }
        SURVEY.rewards = RewardsToUi(promo_config.survey.rewards || [], items)
    }

    RefreshEventFromServices(player_data, items)

    return true
}

function RefreshEventFromServices(player_data, items)
{
    let state = (player_data && player_data.promo_event) || {}
    EVENT.active = !!state.active
    if (!EVENT.active) return

    let event_config = FindPromoEventConfigById(state.event_id)
    if (!event_config)
    {
        EVENT.active = false
        return
    }

    EVENT.event_id = String(state.event_id || "")

    let currency_config = event_config.currency || {}
    EVENT.currency = {
        icon: currency_config.icon || "file://{images}/game_hud/services/leaf.png",
        name: LocalizeOrText(currency_config.name),
        hint: currency_config.earn_hint ? String(currency_config.earn_hint) : "",
        amount: Number(state.currency) || 0,
    }
    EVENT.title = LocalizeOrText(event_config.title) || $.Localize("#services_promo_tab_event")
    EVENT.cost = Math.max(1, Number(event_config.water && event_config.water.cost) || 1)
    EVENT.waterings = Number(state.waterings) || 0
    EVENT.remaining_seconds = Number(state.remaining_seconds) || 0

    EVENT.daily = []
    let daily_state = state.daily || {}
    let daily_quests = TableToArray(event_config.daily_quests)
    for (let i = 0; i < daily_quests.length; i++)
    {
        let quest = daily_quests[i] || {}
        let quest_state = daily_state[quest.id] || {}
        let progress = Number(quest_state.progress) || 0
        let goal = Math.max(1, Number(quest.goal) || 1)
        let claimed = !!quest_state.claimed
        let task = Task(LocalizeOrText(quest.name || quest.id), progress, goal, RewardsToUi(quest.rewards || [], items), progress >= goal && !claimed)
        task.claimed = claimed
        task.event_kind = "daily"
        task.event_key = quest.id
        EVENT.daily.push(task)
    }

    EVENT.accumulative = []
    let acc_claimed = state.accumulative_claimed || {}
    let accumulative = TableToArray(event_config.accumulative)
    for (let i = 0; i < accumulative.length; i++)
    {
        let tier = accumulative[i] || {}
        let index = i + 1
        let goal = Number(tier.goal) || 0
        let claimed = !!acc_claimed[String(index)]
        let task = Task(LocalizeTemplateCount("#services_event_accumulative_task", goal), Math.min(EVENT.waterings, goal), goal, RewardsToUi(tier.rewards || [], items), EVENT.waterings >= goal && !claimed)
        task.claimed = claimed
        task.event_kind = "accumulative"
        task.event_key = index
        EVENT.accumulative.push(task)
    }

    EVENT.permanent = []
    let perm_claimed = state.permanent_claimed || {}
    let vip_experience = Number(state.vip_experience) || 0
    let permanent = TableToArray(event_config.permanent)
    for (let i = 0; i < permanent.length; i++)
    {
        let tier = permanent[i] || {}
        let index = i + 1
        let goal = Number(tier.cny) || 0
        let claimed = !!perm_claimed[String(index)]
        let task = Task(LocalizeTemplateCount("#services_event_permanent_task", goal), Math.min(vip_experience, goal), goal, RewardsToUi(tier.rewards || [], items), vip_experience >= goal && !claimed)
        task.claimed = claimed
        task.event_kind = "permanent"
        task.event_key = index
        EVENT.permanent.push(task)
    }

    EVENT.claimable = {
        daily: ListHasClaimable(EVENT.daily),
        accumulative: ListHasClaimable(EVENT.accumulative),
        permanent: ListHasClaimable(EVENT.permanent),
    }
}

function InitPromo()
{
    RefreshPromoDataFromServices()
    RenderSidebar()
    RenderCurrencies()
    RenderContent()
    UpdatePromoClaimNotifications()

    if (Game.SubscribeCustomTableListener)
    {
        Game.SubscribeCustomTableListener("services_config", "items", RenderPromoFromServices)
        Game.SubscribeCustomTableListener("services_config", "promo", RenderPromoFromServices)
        Game.SubscribeCustomTableListener("services_player", GetLocalPlayerKey(), RenderPromoFromServices)
    }
    GameEvents.Subscribe("event_services_inventory_update", OnPromoInventoryUpdate)
}

function RenderPromoFromServices(table_name, key, data)
{
    if (table_name === "services_player" && String(key) === GetLocalPlayerKey() && data)
    {
        promo_player_data_override = data
    }
    if (typeof IsContextWindowVisible === "function" && !IsContextWindowVisible("PromoWindow"))
    {
        promo_render_deferred = true
        if (RefreshPromoDataFromServices())
        {
            RenderCurrencies()
            UpdatePromoClaimNotifications()
        }
        return
    }

    if (!RefreshPromoDataFromServices()) return
    RenderSidebar()
    RenderCurrencies()
    if (CURRENT_TAB === TAB_INVITES)
    {
        RefreshInvites()
        UpdatePromoClaimNotifications()
        return
    }
    if (CURRENT_TAB === TAB_DAILY)
    {
        RefreshCalendarState(DAILY)
        UpdatePromoClaimNotifications()
        return
    }
    if (CURRENT_TAB === TAB_LOGIN)
    {
        RefreshCalendarState(LOGIN)
        UpdatePromoClaimNotifications()
        return
    }
    if (CURRENT_TAB === TAB_TASKS)
    {
        RenderContent()
        UpdatePromoClaimNotifications()
        return
    }
    if (CURRENT_TAB === TAB_EVENT)
    {
        RefreshEventInPlace()
        UpdatePromoClaimNotifications()
        return
    }
    if (CURRENT_TAB === TAB_SURVEY || CURRENT_TAB === TAB_AHEAD)
    {
        EnsurePromoContentRendered()
        UpdatePromoClaimNotifications()
        return
    }
    RenderContent()
    UpdatePromoClaimNotifications()
}

function RenderPromoIfDeferred()
{
    if (!promo_render_deferred)
    {
        return
    }
    promo_render_deferred = false
    RenderPromoFromServices()
}

if (typeof Game !== 'undefined') Game.RenderPromoIfDeferred = RenderPromoIfDeferred

function EnsurePromoContentRendered()
{
    if (!SectionBody.Children().length)
    {
        RenderContent()
    }
}

function RenderSidebar()
{
    Sidebar.RemoveAndDeleteChildren()
    for (let i = 0; i < TABS.length; i++)
    {
        let tab = TABS[i]
        let button = $.CreatePanel("Panel", Sidebar, "")
        button.AddClass("PromoNavButton")
        button.SetHasClass("PromoNavButtonActive", tab.id === CURRENT_TAB)
        button.SetHasClass("PromoNavButtonWithBadge", !!tab.badge)
        button.SetPanelEvent("onactivate", (function(tab_id) { return function() { CURRENT_TAB = tab_id; RenderSidebar(); RenderContent() } })(tab.id))
        let label = $.CreatePanel("Label", button, "")
        label.AddClass("PromoNavButtonLabel")
        label.text = tab.title
        if (tab.badge) { $.CreatePanel("Panel", button, "").AddClass("PromoNavBadge") }
        if (Game.SetServiceNotifyDot)
        {
            Game.SetServiceNotifyDot(button, IsPromoSidebarTabClaimable(tab.id))
        }
    }
}

function RenderCurrencies()
{
    CurrencyRow.RemoveAndDeleteChildren()
    if (typeof RenderServiceServerSyncButton === "function")
    {
        RenderServiceServerSyncButton(CurrencyRow)
    }
    for (let i = 0; i < CURRENCIES.length; i++)
    {
        let currency = CURRENCIES[i]
        let panel = $.CreatePanel("Panel", CurrencyRow, "")
        panel.AddClass("PromoCurrencyPanel")
        let icon = $.CreatePanel("Panel", panel, "")
        icon.AddClass("PromoCurrencyIcon")
        SetImage(icon, currency.icon)
        let label = $.CreatePanel("Label", panel, "")
        label.AddClass("PromoCurrencyAmount")
        label.text = currency.amount
        if (typeof SetServiceItemTooltip === "function")
        {
            SetServiceItemTooltip(panel, currency.id, currency.amount)
        }
    }
    if (typeof RenderServiceCurrencyMoreButton === "function")
    {
        RenderServiceCurrencyMoreButton(CurrencyRow, (GetServicePlayerData().economy_data || {}))
    }
}

function RenderContent()
{
    SectionBody.RemoveAndDeleteChildren()
    Frame.SetHasClass("PromoThemeTasks", CURRENT_TAB === TAB_TASKS)
    Frame.SetHasClass("PromoThemeDaily", CURRENT_TAB === TAB_DAILY)
    Frame.SetHasClass("PromoThemeInvites", CURRENT_TAB === TAB_INVITES)
    Frame.SetHasClass("PromoThemeGame", CURRENT_TAB === TAB_LOGIN)
    Frame.SetHasClass("PromoThemeSurvey", CURRENT_TAB === TAB_SURVEY)
    Frame.SetHasClass("PromoThemeAhead", CURRENT_TAB === TAB_AHEAD)
    Frame.SetHasClass("PromoThemeEvent", CURRENT_TAB === TAB_EVENT)

    if (CURRENT_TAB === TAB_TASKS) RenderTasks()
    else if (CURRENT_TAB === TAB_DAILY) RenderCalendar(DAILY)
    else if (CURRENT_TAB === TAB_INVITES) RenderInvites()
    else if (CURRENT_TAB === TAB_LOGIN) RenderCalendar(LOGIN)
    else if (CURRENT_TAB === TAB_SURVEY) RenderSurvey()
    else if (CURRENT_TAB === TAB_EVENT) RenderEvent()
    else RenderAhead()
}

function RenderTasksFromServices()
{
    let root = SplitRoot($.Localize("#services_promo_week_rewards"), $.Localize("#services_promo_week_refresh"), "#services_promo_week_progress", "PromoShowcaseTasks")
    SetWeeklyProgressWidth(root.left, TASKS.progress)
    let progress_label = root.left.FindChildTraverse("PromoShowcaseProgress")
    if (progress_label)
    {
        progress_label.SetDialogVariable("value", String(TASKS.progress) + "/" + String(TASKS.total))
        progress_label.text = $.Localize("#services_promo_week_progress", progress_label)
    }
    let nodes = $.CreatePanel("Panel", root.left, "")
    nodes.AddClass("PromoMilestoneWrap")
    for (let i = 0; i < TASKS.nodes.length; i++)
    {
        let milestone = TASKS.nodes[i]
        let rewards = milestone.rewards || []
        let reward = rewards[0] || R("file://{images}/game_hud/icons/refresh.png", 1)
        let can_claim = TASKS.progress >= milestone.completed && !milestone.claimed

        let node = $.CreatePanel("Panel", nodes, "")
        node.AddClass("PromoMilestoneNode")
        node.AddClass("PromoMilestoneNode"+i)
        node.SetHasClass("PromoMilestoneReady", can_claim)
        node.SetHasClass("PromoMilestoneClaimed", milestone.claimed)
        node.SetPanelEvent("onactivate", (function(reward_index, ready) { return function()
        {
            if (!ready) return
            GameEvents.SendCustomGameEventToServer("event_services_claim_week_quest_reward", { reward_index: reward_index })
            Game.EmitSound("General.ButtonClick")
        }})(milestone.reward_index, can_claim))

        let PromoMilestoneContent = $.CreatePanel("Panel", node, "")
        PromoMilestoneContent.AddClass("PromoMilestoneContent")
        SetServiceItemTooltip(PromoMilestoneContent, reward.id, reward.count)
        $.CreatePanel("Panel", PromoMilestoneContent, "").AddClass("PromoMilestoneBG1")
        let PromoMilestoneBG2 = $.CreatePanel("Panel", PromoMilestoneContent, "")
        PromoMilestoneBG2.AddClass("PromoMilestoneBG2")
        AddRarityClass(PromoMilestoneBG2, GetRewardRarity(reward))

        let icon = $.CreatePanel("Panel", PromoMilestoneContent, "")
        icon.AddClass("PromoMilestoneIcon")
        SetImage(icon, reward.icon)

        let count = $.CreatePanel("Label", PromoMilestoneContent, "")
        count.AddClass("PromoMilestoneCount")
        count.text = "x" + String(reward.count || 1)
        if (milestone.claimed)
        {
            $.CreatePanel("Panel", PromoMilestoneContent, "").AddClass("PromoMilestoneCheck")
        }

        let label = $.CreatePanel("Label", node, "")
        label.AddClass("PromoMilestoneNeed")
        label.text = String(Math.min(TASKS.progress, milestone.completed)) + "/" + String(milestone.completed)
    }

    let right = TaskPanel(root.right, [
        { id: "daily", title: $.Localize("#services_promo_tasks_daily") },
        { id: "monthly", title: $.Localize("#services_promo_tasks_monthly_card") },
        { id: "yearly", title: $.Localize("#services_promo_tasks_yearly_card") },
    ], TASK_GROUP, function(id) { TASK_GROUP = id; RenderContent() })
    let list = TASKS[TASK_GROUP] || []
    for (let i = 0; i < list.length; i++) RenderTaskCard(right.body, list[i])
}

function RenderTasks()
{
    RenderTasksFromServices()
    return
    let root = SplitRoot($.Localize("#services_promo_week_rewards"), $.Localize("#services_promo_week_refresh"), $.Localize("#services_promo_week_progress"), "PromoShowcaseTasks")
    let nodes = $.CreatePanel("Panel", root.left, "")
    nodes.AddClass("PromoMilestoneWrap")
    for (let i = 0; i < TASKS.nodes.length; i++)
    {
        let need = TASKS.nodes[i]

        let node = $.CreatePanel("Panel", nodes, "")
        node.AddClass("PromoMilestoneNode")
        node.AddClass("PromoMilestoneNode"+i)

        let PromoMilestoneContent = $.CreatePanel("Panel", node, "")
        PromoMilestoneContent.AddClass("PromoMilestoneContent")

        let PromoMilestoneBG1 = $.CreatePanel("Panel", PromoMilestoneContent, "")
        PromoMilestoneBG1.AddClass("PromoMilestoneBG1")

        let PromoMilestoneBG2 = $.CreatePanel("Panel", PromoMilestoneContent, "")
        PromoMilestoneBG2.AddClass("PromoMilestoneBG2")
        AddRarityClass(PromoMilestoneBG2, GetRewardRarityByIcon("file://{images}/game_hud/icons/refresh.png"))

        let icon = $.CreatePanel("Panel", PromoMilestoneContent, "")
        icon.AddClass("PromoMilestoneIcon")
        SetImage(icon, "file://{images}/game_hud/icons/refresh.png")

        let count = $.CreatePanel("Label", PromoMilestoneContent, "")
        count.AddClass("PromoMilestoneCount")
        count.text = "x1"

        let label = $.CreatePanel("Label", node, "")
        label.AddClass("PromoMilestoneNeed")
        label.text = "0/" + need
    }
    let right = TaskPanel(root.right, [
        { id: "daily", title: $.Localize("#services_promo_tasks_daily") },
        { id: "monthly", title: $.Localize("#services_promo_tasks_monthly") },
        { id: "unique", title: $.Localize("#services_promo_tasks_unique") },
    ], TASK_GROUP, function(id) { TASK_GROUP = id; RenderContent() })
    let list = TASKS[TASK_GROUP] || []
    for (let i = 0; i < list.length; i++) RenderTaskCard(right.body, list[i])
    MakeButton(right.footer, $.Localize("#services_pass_claim_all"), "PromoClaimAllButton", function() {})
}

function RenderAhead()
{
    let root = SplitRoot($.Localize("#services_promo_ahead_title"), $.Localize("#services_promo_ahead_subtitle"), $.Localize("#services_promo_ahead_until") + ": " + AHEAD.end_time, "PromoShowcaseAhead")
    let medal = $.CreatePanel("Panel", root.left, "")
    medal.AddClass("PromoAheadMedallion")
    let medalIcon = $.CreatePanel("Panel", medal, "")
    medalIcon.AddClass("PromoAheadMedallionIcon")
    SetImage(medalIcon, "file://{images}/game_hud/icons/kills_2.png")
    let medalValue = $.CreatePanel("Label", medal, "")
    medalValue.AddClass("PromoAheadMedallionValue")
    medalValue.text = String(AHEAD.progress)
    let buttons = $.CreatePanel("Panel", root.left, "")
    buttons.AddClass("PromoAheadButtons")
    MakeButton(buttons, $.Localize("#services_promo_throw_1"), "PromoThrowButton PromoThrowButtonBlue", function() {})
    MakeButton(buttons, $.Localize("#services_promo_throw_2"), "PromoThrowButton PromoThrowButtonRed", function() {})
    let costs = $.CreatePanel("Panel", root.left, "")
    costs.AddClass("PromoAheadCosts")
    Cost(costs, AHEAD.cost_1)
    Cost(costs, AHEAD.cost_10)
    let right = TaskPanel(root.right, [
        { id: "daily", title: $.Localize("#services_promo_tasks_daily") },
        { id: "claim", title: $.Localize("#services_common_claim") },
        { id: "history", title: $.Localize("#services_promo_history") },
    ], AHEAD_GROUP, function(id) { AHEAD_GROUP = id; RenderContent() })
    let list = AHEAD[AHEAD_GROUP] || []
    for (let i = 0; i < list.length; i++) RenderTaskCard(right.body, list[i])
}

function FormatEventEndDate(remaining_seconds)
{
    let end = new Date(Date.now() + Math.max(0, Number(remaining_seconds) || 0) * 1000)
    let day = ("0" + end.getDate()).slice(-2)
    let month = ("0" + (end.getMonth() + 1)).slice(-2)
    let year = end.getFullYear()
    let hours = ("0" + end.getHours()).slice(-2)
    let minutes = ("0" + end.getMinutes()).slice(-2)
    return day + "." + month + "." + year + " " + hours + ":" + minutes
}

function SendPromoWater(count)
{
    if (count <= 0) return
    GameEvents.SendCustomGameEventToServer("event_services_promo_water", { count: count })
    Game.EmitSound("General.ButtonClick")
}

function SendEventClaim(kind, key)
{
    if (kind === "daily") GameEvents.SendCustomGameEventToServer("event_services_claim_promo_event_daily", { quest_id: key })
    else if (kind === "accumulative") GameEvents.SendCustomGameEventToServer("event_services_claim_promo_event_accumulative", { index: key })
    else if (kind === "permanent") GameEvents.SendCustomGameEventToServer("event_services_claim_promo_event_permanent", { index: key })
    Game.EmitSound("General.ButtonClick")
}

function RenderEventRewards(parent, rewards)
{
    for (let i = 0; i < rewards.length; i++)
    {
        let reward = rewards[i]
        let panel = $.CreatePanel("Panel", parent, "")
        panel.AddClass("PromoEventReward")
        SetServiceItemTooltip(panel, reward.id, reward.count)

        let bg1 = $.CreatePanel("Panel", panel, "")
        bg1.AddClass("PromoEventRewardBG1")

        let bg2 = $.CreatePanel("Panel", panel, "")
        bg2.AddClass("PromoEventRewardBG2")
        AddRarityClass(bg2, GetRewardRarity(reward))

        let icon = $.CreatePanel("Panel", panel, "")
        icon.AddClass("PromoEventRewardIcon")
        SetImage(icon, reward.icon)

        let count = $.CreatePanel("Label", panel, "")
        count.AddClass("PromoEventRewardCount")
        count.text = "x" + String(reward.count || 1)
    }
}

function RenderEventTaskCard(parent, task)
{
    let card = $.CreatePanel("Panel", parent, "")
    card.AddClass("PromoEventCard")
    card.SetHasClass("PromoEventCardReady", task.can_claim)
    card.SetHasClass("PromoEventCardClaimed", task.claimed)
    let card_bg = $.CreatePanel("Panel", card, "")
    card_bg.AddClass("PromoEventCardBG")
    let card_content = $.CreatePanel("Panel", card, "")
    card_content.AddClass("PromoEventCardContent")
    let left = $.CreatePanel("Panel", card_content, "")
    left.AddClass("PromoEventCardLeft")
    let title = $.CreatePanel("Label", left, "")
    title.AddClass("PromoEventCardTitle")
    title.text = task.title
    let bar = $.CreatePanel("Panel", left, "")
    bar.AddClass("PromoEventProgressBar")
    let fill = $.CreatePanel("Panel", bar, "")
    fill.AddClass("PromoEventProgressFill")
    fill.style.width = Math.min(100, (task.progress / Math.max(1, task.goal)) * 100) + "%"
    let value = $.CreatePanel("Label", bar, "")
    value.AddClass("PromoEventProgressValue")
    value.text = task.progress + "/" + task.goal
    let rewards = $.CreatePanel("Panel", card_content, "")
    rewards.AddClass("PromoEventCardRewards")
    RenderEventRewards(rewards, task.rewards)
    if (task.can_claim)
    {
        let claim = $.CreatePanel("Panel", card_content, "")
        claim.AddClass("PromoEventClaimButton")
        claim.SetPanelEvent("onactivate", (function(kind, key) { return function()
        {
            Game.EmitSound("General.ButtonClick")
            SendEventClaim(kind, key)
        }})(task.event_kind, task.event_key))
        let claim_label = $.CreatePanel("Label", claim, "")
        claim_label.text = $.Localize("#services_promo_take")
    }
    else
    {
        let state = $.CreatePanel("Label", card_content, "")
        state.AddClass("PromoEventCardState")
        state.text = task.claimed ? $.Localize("#services_common_claimed") : $.Localize("#services_common_not_completed")
    }
}

function BuildEventWaterButton(parent, kind, title, waterings)
{
    let spend = waterings * EVENT.cost
    let enabled = waterings > 0 && EVENT.currency.amount >= spend

    let button = $.CreatePanel("Panel", parent, "")
    button.AddClass("PromoEventWaterButton")
    button.AddClass(kind === "all" ? "PromoEventWaterButtonAll" : "PromoEventWaterButtonSingle")
    button.SetHasClass("PromoEventWaterButtonDisabled", !enabled)

    let bg = $.CreatePanel("Panel", button, "")
    bg.AddClass("PromoEventWaterButtonBG")

    let inner = $.CreatePanel("Panel", button, "")
    inner.AddClass("PromoEventWaterButtonInner")

    let label = $.CreatePanel("Label", inner, "")
    label.AddClass("PromoEventWaterButtonTitle")
    label.text = title

    let cost = $.CreatePanel("Panel", inner, "")
    cost.AddClass("PromoEventWaterButtonCost")
    let costIcon = $.CreatePanel("Panel", cost, "")
    costIcon.AddClass("PromoEventWaterButtonCostIcon")
    SetImage(costIcon, EVENT.currency.icon)
    let costAmount = $.CreatePanel("Label", cost, "")
    costAmount.AddClass("PromoEventWaterButtonCostAmount")
    costAmount.text = String(spend)

    button.SetPanelEvent("onactivate", (function(count, need) { return function()
    {
        if (count <= 0 || EVENT.currency.amount < need) return
        SendPromoWater(count)
    }})(waterings, spend))
    return button
}

function RenderEventTabs(container)
{
    container.RemoveAndDeleteChildren()
    let tab_defs = [
        { id: "daily", title: $.Localize("#services_event_tasks_daily") },
        { id: "accumulative", title: $.Localize("#services_event_tasks_accumulative") },
        { id: "permanent", title: $.Localize("#services_event_tasks_permanent") },
    ]
    for (let i = 0; i < tab_defs.length; i++)
    {
        let tab = tab_defs[i]
        let button = $.CreatePanel("Panel", container, "")
        button.AddClass("PromoEventTab")
        button.SetHasClass("PromoEventTabActive", tab.id === EVENT_GROUP)
        button.SetPanelEvent("onactivate", (function(id) { return function() { EVENT_GROUP = id; RefreshEventInPlace() } })(tab.id))
        let label = $.CreatePanel("Label", button, "")
        label.text = tab.title
        if (Game.SetServiceNotifyDot)
        {
            Game.SetServiceNotifyDot(button, !!(EVENT.claimable && EVENT.claimable[tab.id]))
        }
    }
}

function RenderEventWaterButtons(container)
{
    container.RemoveAndDeleteChildren()
    BuildEventWaterButton(container, "single", $.Localize("#services_event_water_once"), 1)
    BuildEventWaterButton(container, "all", $.Localize("#services_event_water_all"), Math.floor(EVENT.currency.amount / EVENT.cost))
}

function RenderEventTaskList(container)
{
    container.RemoveAndDeleteChildren()
    let list = EVENT[EVENT_GROUP] || []
    for (let i = 0; i < list.length; i++) RenderEventTaskCard(container, list[i])
}

function RenderEvent()
{
    if (!EVENT.active)
    {
        let empty = $.CreatePanel("Label", SectionBody, "")
        empty.AddClass("PromoEventEmpty")
        empty.text = $.Localize("#services_event_inactive")
        return
    }

    let root = $.CreatePanel("Panel", SectionBody, "PromoEventRoot")
    root.AddClass("PromoEventSplit")

    let bg = $.CreatePanel("Panel", root, "")
    bg.AddClass("PromoEventQuestBG")
    bg.hittest = false

    let left = $.CreatePanel("Panel", root, "")
    left.AddClass("PromoEventShowcase")

    let promo_event_video = $.CreatePanel("MoviePanel", left, "promo_event_video", {
        src: "file://{resources}/videos/tree_event.webm",
        repeat: "true",
        autoplay: "onload",
    })
    promo_event_video.AddClass("promo_event_video")

    let wrap = $.CreatePanel("Panel", left, "")
    wrap.AddClass("PromoEventShowcaseTitleWrap")
    let title = $.CreatePanel("Label", wrap, "")
    title.AddClass("PromoEventShowcaseTitle")
    title.text = EVENT.title
    let subtitle = $.CreatePanel("Label", wrap, "")
    subtitle.AddClass("PromoEventShowcaseSubtitle")
    subtitle.text = $.Localize("#services_event_subtitle")

    let bottom = $.CreatePanel("Panel", left, "")
    bottom.AddClass("PromoEventBottom")

    let currency = $.CreatePanel("Panel", bottom, "")
    currency.AddClass("PromoEventCurrency")
    let currencyIcon = $.CreatePanel("Panel", currency, "")
    currencyIcon.AddClass("PromoEventCurrencyIcon")
    SetImage(currencyIcon, EVENT.currency.icon)
    if (typeof SetServiceItemTooltip === "function") SetServiceItemTooltip(currencyIcon, "event_currency", EVENT.currency.amount)
    let currencyAmount = $.CreatePanel("Label", currency, "PromoEventCurrencyAmountLabel")
    currencyAmount.AddClass("PromoEventCurrencyAmount")
    currencyAmount.text = String(EVENT.currency.amount)
    let hint = $.CreatePanel("Panel", currency, "")
    hint.AddClass("PromoEventCurrencyHint")
    if (EVENT.event_id && typeof SetCustomTooltip === "function")
    {
        SetCustomTooltip(hint, "service_event_water_tooltip", { event_id: EVENT.event_id })
    }
    else if (EVENT.currency.hint)
    {
        ShowTextForPanel(hint, EVENT.currency.hint)
    }

    let ends = $.CreatePanel("Label", bottom, "")
    ends.AddClass("PromoEventEnds")
    ends.SetDialogVariable("value", FormatEventEndDate(EVENT.remaining_seconds))
    ends.text = $.Localize("#services_event_ends", ends)

    let buttons = $.CreatePanel("Panel", bottom, "PromoEventWaterButtonsRow")
    buttons.AddClass("PromoEventWaterButtons")
    RenderEventWaterButtons(buttons)

    let right = $.CreatePanel("Panel", root, "")
    right.AddClass("PromoEventList")
    let tabs = $.CreatePanel("Panel", right, "PromoEventTabsRow")
    tabs.AddClass("PromoEventTabs")
    RenderEventTabs(tabs)
    let body = $.CreatePanel("Panel", right, "PromoEventListBodyPanel")
    body.AddClass("PromoEventListBody")
    RenderEventTaskList(body)
}

function RefreshEventInPlace()
{
    if (!EVENT.active || !$("#PromoEventRoot"))
    {
        RenderContent()
        return
    }

    let amount = $("#PromoEventCurrencyAmountLabel")
    if (amount) amount.text = String(EVENT.currency.amount)

    let buttons = $("#PromoEventWaterButtonsRow")
    if (buttons) RenderEventWaterButtons(buttons)

    let tabs = $("#PromoEventTabsRow")
    if (tabs) RenderEventTabs(tabs)

    let body = $("#PromoEventListBodyPanel")
    if (body) RenderEventTaskList(body)
}

function RenderCalendar(data)
{
    let root = $.CreatePanel("Panel", SectionBody, "PromoCalendarScene")
    root.AddClass("PromoCalendarScene")
    root.AddClass(data.theme)

    let PromoCalendarBG = $.CreatePanel("Panel", root, "")
    PromoCalendarBG.AddClass("PromoCalendarBG")

    let PromoCalendarBG1 = $.CreatePanel("Panel", root, "")
    PromoCalendarBG1.AddClass("PromoCalendarBG1")
    PromoCalendarBG1.hittest = false

    let header = $.CreatePanel("Panel", root, "")
    header.AddClass("PromoCalendarHeader")
    let titles = $.CreatePanel("Panel", header, "")
    titles.AddClass("PromoCalendarTitleBlock")
    let title = $.CreatePanel("Label", titles, "")
    title.AddClass("PromoCalendarTitle")
    title.text = data.title
    let info = $.CreatePanel("Label", titles, "")
    info.AddClass("PromoCalendarInfoText")
    info.text = data.info
    let claimWrap = $.CreatePanel("Panel", header, "")
    claimWrap.AddClass("PromoCalendarClaimWrap")
    let claimButton = MakeButton(claimWrap, $.Localize("#services_common_claim"), "PromoActionButton PromoCalendarClaimButton", function()
    {
        if (!data.can_claim) return
        GameEvents.SendCustomGameEventToServer("event_services_claim_daily_login", {})
    }, "PromoCalendarClaimButton")
    claimButton.SetHasClass("PromoButtonDisabled", !data.can_claim)
    let frame = $.CreatePanel("Panel", root, "")
    frame.AddClass("PromoCalendarDaysFrame")
    let row = $.CreatePanel("Panel", frame, "")
    row.AddClass("PromoCalendarDays")
    for (let i = 0; i < data.days.length; i++)
    {
        let entry = data.days[i]
        let card = $.CreatePanel("Panel", row, "PromoTallDayCard_" + entry.day)
        card.AddClass("PromoTallDayCard")
        let claimed = data.claimed.indexOf(entry.day) !== -1
        let ready = entry.day === data.today && data.can_claim && !claimed
        let locked = entry.day > data.today || (entry.day === data.today && !data.can_claim && !claimed)
        card.SetHasClass("PromoTallDayCardToday", entry.day === data.today)
        card.SetHasClass("PromoTallDayCardClaimed", claimed)
        card.SetHasClass("PromoTallDayCardLocked", locked)
        card.SetHasClass("PromoTallDayCardReady", ready)
        card.SetHasClass("PromoTallDayCardFinal", entry.day === 7)
        let day = $.CreatePanel("Label", card, "")
        day.AddClass("PromoTallDayLabel")
        day.SetDialogVariable("value", String(entry.day))
        day.text = $.Localize("#services_promo_day", day)
        let rewards = $.CreatePanel("Panel", card, "")
        rewards.AddClass("PromoTallDayRewards")
        RenderRewards(rewards, entry.rewards, "PromoRewardPoster")
        if (claimed) { let stamp = $.CreatePanel("Label", card, "PromoClaimedStamp_" + entry.day); stamp.AddClass("PromoClaimedStamp"); stamp.text = $.Localize("#services_common_claimed") }
    }
}

function RefreshCalendarState(data)
{
    if (!$("#PromoCalendarScene"))
    {
        RenderContent()
        return
    }

    let claimButton = $("#PromoCalendarClaimButton")
    if (claimButton)
    {
        claimButton.SetHasClass("PromoButtonDisabled", !data.can_claim)
        claimButton.SetPanelEvent("onactivate", function()
        {
            if (!data.can_claim) return
            GameEvents.SendCustomGameEventToServer("event_services_claim_daily_login", {})
            Game.EmitSound("General.ButtonClick")
        })
    }

    for (let i = 0; i < data.days.length; i++)
    {
        let entry = data.days[i]
        let card = $("#PromoTallDayCard_" + entry.day)
        if (!card)
        {
            RenderContent()
            return
        }

        let claimed = data.claimed.indexOf(entry.day) !== -1
        let ready = entry.day === data.today && data.can_claim && !claimed
        let locked = entry.day > data.today || (entry.day === data.today && !data.can_claim && !claimed)
        card.SetHasClass("PromoTallDayCardToday", entry.day === data.today)
        card.SetHasClass("PromoTallDayCardClaimed", claimed)
        card.SetHasClass("PromoTallDayCardLocked", locked)
        card.SetHasClass("PromoTallDayCardReady", ready)

        let stamp = $("#PromoClaimedStamp_" + entry.day)
        if (claimed && !stamp)
        {
            stamp = $.CreatePanel("Label", card, "PromoClaimedStamp_" + entry.day)
            stamp.AddClass("PromoClaimedStamp")
            stamp.text = $.Localize("#services_common_claimed")
        }
        else if (!claimed && stamp)
        {
            stamp.DeleteAsync(0)
        }
    }
}

function RenderInvites()
{
    let root = $.CreatePanel("Panel", SectionBody, "")
    root.AddClass("PromoInviteScene")
    let infoBar = $.CreatePanel("Panel", root, "")
    infoBar.AddClass("PromoInviteInfoBar")

    let own = $.CreatePanel("Panel", infoBar, "")
    own.AddClass("PromoInviteOwnInfo")
    let code = $.CreatePanel("Label", own, "PromoInviteOwnCode")
    code.AddClass("PromoInviteOwnCode")
    code.SetDialogVariable("value", String(INVITES.invite_code))
    code.text = $.Localize("#services_promo_my_code", code)
    let count = $.CreatePanel("Label", own, "PromoInviteOwnCount")
    count.AddClass("PromoInviteOwnCount")
    count.SetDialogVariable("value", String(INVITES.invited_count))
    count.text = $.Localize("#services_promo_invited_count", count)
    let frame = $.CreatePanel("Panel", root, "")
    frame.AddClass("PromoInviteGridFrame")
    let grid = $.CreatePanel("Panel", frame, "PromoInviteGrid")
    grid.AddClass("PromoInviteGrid")


        let PromoInviteInfoBarContent = $.CreatePanel("Panel", infoBar, "")
    PromoInviteInfoBarContent.AddClass("PromoInviteInfoBarContent")

    let bind = $.CreatePanel("TextEntry", PromoInviteInfoBarContent, "PromoInviteBindEntry")
    bind.AddClass("PromoWideEntry")
    bind.text = INVITES.bind_code
    bind.enabled = !INVITES.bound
    bind.hittest = !INVITES.bound
    bind.SetHasClass("PromoEntryDisabled", INVITES.bound)

    let bindButton = MakeButton(PromoInviteInfoBarContent, INVITES.bound ? $.Localize("#services_promo_bound") : $.Localize("#services_promo_bind_self"), "PromoTinyButton", function()
    {
        if (INVITES.bound) return
        GameEvents.SendCustomGameEventToServer("event_services_bind_inviter", { inviter_id: bind.text })
    }, "PromoInviteBindButton")
    bindButton.SetHasClass("PromoButtonDisabled", INVITES.bound)

    RenderInviteRewardCards(grid)
}

function RefreshInvites()
{
    let code = $("#PromoInviteOwnCode")
    if (code)
    {
        code.SetDialogVariable("value", String(INVITES.invite_code))
        code.text = $.Localize("#services_promo_my_code", code)
    }

    let count = $("#PromoInviteOwnCount")
    if (count)
    {
        count.SetDialogVariable("value", String(INVITES.invited_count))
        count.text = $.Localize("#services_promo_invited_count", count)
    }

    let bind = $("#PromoInviteBindEntry")
    if (bind)
    {
        bind.text = INVITES.bind_code
        bind.enabled = !INVITES.bound
        bind.hittest = !INVITES.bound
        bind.SetHasClass("PromoEntryDisabled", INVITES.bound)
    }

    let bindButton = $("#PromoInviteBindButton")
    if (bindButton)
    {
        SetButtonText(bindButton, INVITES.bound ? $.Localize("#services_promo_bound") : $.Localize("#services_promo_bind_self"))
        bindButton.SetHasClass("PromoButtonDisabled", INVITES.bound)
    }

    let grid = $("#PromoInviteGrid")
    if (!grid)
    {
        RenderContent()
        return
    }
    RefreshInviteRewardCards(grid)
}

function RenderInviteRewardCards(grid)
{
    grid.RemoveAndDeleteChildren()
    for (let i = 0; i < INVITES.cards.length; i++)
    {
        RenderInviteRewardCard(grid, INVITES.cards[i], i)
    }
}

function RefreshInviteRewardCards(grid)
{
    if (!grid || grid.Children().length !== INVITES.cards.length)
    {
        RenderInviteRewardCards(grid)
        return
    }

    for (let i = 0; i < INVITES.cards.length; i++)
    {
        let card = $("#PromoInviteRewardCard_" + i)
        if (!card)
        {
            RenderInviteRewardCards(grid)
            return
        }
        UpdateInviteRewardCardState(card, INVITES.cards[i], i)
    }
}

function RenderInviteRewardCard(grid, item, index)
{
    let card = $.CreatePanel("Panel", grid, "PromoInviteRewardCard_" + index)
    card.AddClass("PromoInviteRewardCard")
    let title = $.CreatePanel("Label", card, "")
    title.AddClass("PromoInviteRewardCardTitle")
    title.text = item.title
    let rewards = $.CreatePanel("Panel", card, "")
    rewards.AddClass("PromoInviteRewardCardItems")
    RenderRewards(rewards, item.rewards, "PromoRewardLarge")
    let need = $.CreatePanel("Label", card, "PromoInviteRewardNeed_" + index)
    need.AddClass("PromoInviteRewardCardNeed")
    let btn = MakeButton(card, item.claimed ? $.Localize("#services_common_claimed") : $.Localize("#services_common_claim"), "PromoInviteClaimButton", function() {}, "PromoInviteClaimButton_" + index)
    UpdateInviteRewardCardState(card, item, index)
}

function UpdateInviteRewardCardState(card, item, index)
{
    card.SetHasClass("PromoInviteRewardCardReady", item.can_claim && !item.claimed)
    card.SetHasClass("PromoInviteRewardCardClaimed", item.claimed)

    let need = $("#PromoInviteRewardNeed_" + index)
    if (need)
    {
        need.text = item.claimed ? $.Localize("#services_common_claimed") : item.progress
    }

    let btn = $("#PromoInviteClaimButton_" + index)
    if (btn)
    {
        SetButtonText(btn, item.claimed ? $.Localize("#services_common_claimed") : $.Localize("#services_common_claim"))
        btn.SetHasClass("PromoButtonDisabled", !item.can_claim)
        btn.SetPanelEvent("onactivate", (function(reward_index, can_claim)
        {
            return function()
            {
                if (!can_claim) return
                GameEvents.SendCustomGameEventToServer("event_services_claim_invite_reward", { reward_index: reward_index })
                Game.EmitSound("General.ButtonClick")
            }
        })(item.reward_index, item.can_claim))
    }
}

function RenderSurvey()
{
    let root = $.CreatePanel("Panel", SectionBody, "")
    root.AddClass("PromoSurveyScene")
    let paper = $.CreatePanel("Panel", root, "")
    paper.AddClass("PromoSurveyPaper")
    let title = $.CreatePanel("Label", paper, "")
    title.AddClass("PromoSurveyPaperTitle")
    title.text = $.Localize("#services_promo_survey_title")
    let block1 = SurveyBlock(paper, $.Localize("#services_promo_survey_question_source"))
    let grid = $.CreatePanel("Panel", block1, "")
    grid.AddClass("PromoSurveySourceGrid")
    for (let i = 0; i < SURVEY.sources.length; i++)
    {
        let source = SURVEY.sources[i]
        let item = $.CreatePanel("Panel", grid, "")
        item.AddClass("PromoSurveyChoice")
        item.SetHasClass("PromoSurveyChoiceActive", SURVEY.selected.indexOf(source) !== -1)
        item.SetPanelEvent("onactivate", (function(name) { return function() { if (SURVEY.submitted) return; CacheCurrentSurveyFeedback(); ToggleSource(name); RenderContent() } })(source))
        $.CreatePanel("Panel", item, "").AddClass("PromoSurveyCheckbox")
        let label = $.CreatePanel("Label", item, "")
        label.AddClass("PromoSurveyChoiceLabel")
        let source_key = "#services_promo_survey_source_" + String(source || "")
        let source_text = $.Localize(source_key)
        label.text = source_text && source_text !== source_key ? source_text : String(source || "")
    }
    let block2 = SurveyBlock(paper, $.Localize("#services_promo_survey_question_recommend"))
    let grid2 = $.CreatePanel("Panel", block2, "")
    grid2.AddClass("PromoSurveySourceGrid")
    BinaryChoice(grid2, $.Localize("#services_common_yes"), true)
    BinaryChoice(grid2, $.Localize("#services_common_no"), false)

    let feedbackBlock = SurveyBlock(paper, $.Localize("#services_promo_survey_question_feedback"))
    feedbackBlock.AddClass("PromoSurveyFeedbackBlock")
    let feedbackEntry = $.CreatePanel("TextEntry", feedbackBlock, "PromoSurveyFeedbackEntry")
    feedbackEntry.AddClass("PromoSurveyFeedbackEntry")
    feedbackEntry.text = SURVEY.feedback || ""
    feedbackEntry.maxchars = 5000
    feedbackEntry.multiline = true
    feedbackEntry.enabled = !SURVEY.submitted
    feedbackEntry.hittest = !SURVEY.submitted

    let feedbackHint = $.CreatePanel("Label", feedbackBlock, "PromoSurveyFeedbackHint")
    feedbackHint.AddClass("PromoSurveyFeedbackHint")

    let UpdateFeedbackHint = function()
    {
        SURVEY.feedback = String(feedbackEntry.text || "")
        let word_count = GetSurveyFeedbackWordCount(SURVEY.feedback)
        feedbackHint.SetDialogVariable("count", String(word_count))
        feedbackHint.SetDialogVariable("max", String(SURVEY_FEEDBACK_MAX_WORDS))
        feedbackHint.text = $.Localize("#services_promo_survey_feedback_limit", feedbackHint)
        feedbackHint.SetHasClass("PromoSurveyFeedbackHintError", word_count > SURVEY_FEEDBACK_MAX_WORDS)
    }
    feedbackEntry.SetPanelEvent("ontextentrychange", UpdateFeedbackHint)
    feedbackEntry.SetPanelEvent("oninputsubmit", UpdateFeedbackHint)
    UpdateFeedbackHint()

    let rewardBar = $.CreatePanel("Panel", paper, "")
    rewardBar.AddClass("PromoSurveyRewardBar")
    let rewardText = $.CreatePanel("Label", rewardBar, "")
    rewardText.AddClass("PromoSurveyRewardText")
    rewardText.text = SURVEY.submitted ? $.Localize("#services_promo_survey_reward_sent") : $.Localize("#services_promo_survey_reward")
    let rewards = $.CreatePanel("Panel", rewardBar, "")
    rewards.AddClass("PromoSurveyRewardItems")
    RenderRewards(rewards, SURVEY.rewards, "PromoRewardSmall")
    let send = MakeButton(paper, SURVEY.submitted ? $.Localize("#services_promo_already_sent") : $.Localize("#services_promo_send"), "PromoActionButton2", function()
    {
        if (SURVEY.submitted) return
        CURRENT_TAB = TAB_SURVEY
        SURVEY.submitted = true
        SURVEY.feedback = String(feedbackEntry.text || "")
        let feedback = NormalizeSurveyFeedback(SURVEY.feedback)
        let answers = { sources: SURVEY.selected, recommend: SURVEY.recommend }
        if (feedback)
        {
            answers.feedback = feedback
        }
        GameEvents.SendCustomGameEventToServer("event_services_submit_survey", { answers: answers })
        RenderContent()
    })
    send.SetHasClass("PromoButtonDisabled", SURVEY.submitted)
}

function SplitRoot(title, subtitle, progress, extraClass)
{
    let root = $.CreatePanel("Panel", SectionBody, "")
    root.AddClass("PromoSplitRoot")

    let PromoQuestBG = $.CreatePanel("Panel", root, "")
    PromoQuestBG.AddClass("PromoQuestBG")
    PromoQuestBG.hittest = false

    let left = $.CreatePanel("Panel", root, "")
    left.AddClass("PromoShowcase")
    left.AddClass(extraClass)

    let left_progress = $.CreatePanel("Panel", left, "PromoLeftProgress")
    left_progress.AddClass("left_progress")
    left_progress.id = "PromoLeftProgress"

    let wrap = $.CreatePanel("Panel", left, "")
    wrap.AddClass("PromoShowcaseTitleWrap")
    let big = $.CreatePanel("Label", wrap, "")
    big.AddClass("PromoShowcaseTitle")
    big.text = title
    let sub = $.CreatePanel("Label", wrap, "")
    sub.AddClass("PromoShowcaseSubtitle")
    sub.text = subtitle
    let info = $.CreatePanel("Label", wrap, "PromoShowcaseProgress")
    info.AddClass("PromoShowcaseProgress")
    info.text = progress
    let right = $.CreatePanel("Panel", root, "")
    return { root: root, left: left, right: right }
}

function GetWeeklyProgressWidth(completed)
{
    completed = Math.max(0, Math.min(50, Number(completed) || 0))
    if (completed <= 20) return completed / 20 * 30
    if (completed <= 30) return 30 + (completed - 20) / 10 * 20
    if (completed <= 40) return 50 + (completed - 30) / 10 * 20
    return 70 + (completed - 40) / 10 * 30
}

function SetWeeklyProgressWidth(parent, completed)
{
    let progress = parent && parent.FindChildTraverse("PromoLeftProgress")
    if (progress)
    {
        progress.style.width = GetWeeklyProgressWidth(completed) + "%"
    }
}

function TaskPanel(parent, tabs, active, callback)
{
    parent.AddClass("PromoTaskListPanel")
    let head = $.CreatePanel("Panel", parent, "")
    head.AddClass("PromoTaskListTabs")
    for (let i = 0; i < tabs.length; i++)
    {
        let tab = tabs[i]
        let btn = $.CreatePanel("Panel", head, "")
        btn.AddClass("PromoInnerTab")
        btn.SetHasClass("PromoInnerTabActive", tab.id === active)
        btn.SetPanelEvent("onactivate", (function(id) { return function() { callback(id) } })(tab.id))
        let label = $.CreatePanel("Label", btn, "")
        label.text = tab.title
        if (Game.SetServiceNotifyDot)
        {
            Game.SetServiceNotifyDot(btn, IsPromoTaskGroupClaimable(tab.id))
        }
    }
    let body = $.CreatePanel("Panel", parent, "")
    body.AddClass("PromoTaskListBody")
    let footer = $.CreatePanel("Panel", parent, "")
    footer.AddClass("PromoTaskListFooter")
    return { body: body, footer: footer }
}

function RenderTaskCard(parent, task)
{
    let card = $.CreatePanel("Panel", parent, "")
    card.AddClass("PromoCompactTaskCard")
    card.SetHasClass("PromoCompactTaskCardReady", task.can_claim)
    card.SetHasClass("PromoCompactTaskCardClaimed", task.claimed)
    card.SetHasClass("PromoCompactTaskCardLocked", task.locked)
    let card_bg = $.CreatePanel("Panel", card, "")
    card_bg.AddClass("PromoCompactTaskCardBG")
    let card_content = $.CreatePanel("Panel", card, "")
    card_content.AddClass("PromoCompactTaskCardContent")
    let left = $.CreatePanel("Panel", card_content, "")
    left.AddClass("PromoCompactTaskLeft")
    let title = $.CreatePanel("Label", left, "")
    title.AddClass("PromoCompactTaskTitle")
    title.text = task.title
    if (task.description) { let d = $.CreatePanel("Label", left, ""); d.AddClass("PromoCompactTaskDescription"); d.text = task.description }
    let bar = $.CreatePanel("Panel", left, "")
    bar.AddClass("PromoCompactProgressBar")
    let fill = $.CreatePanel("Panel", bar, "")
    fill.AddClass("PromoCompactProgressFill")
    fill.style.width = Math.min(100, (task.progress / Math.max(1, task.goal)) * 100) + "%"
    let value = $.CreatePanel("Label", bar, "")
    value.AddClass("PromoCompactProgressValue")
    value.text = task.progress + "/" + task.goal
    let rewards = $.CreatePanel("Panel", card_content, "")
    rewards.AddClass("PromoCompactRewards")
    RenderRewards(rewards, task.rewards, "PromoRewardTask")
    if (task.can_claim)
    {
        MakeButton(card_content, $.Localize("#services_promo_take"), "PromoTaskClaimButton", function()
        {
            GameEvents.SendCustomGameEventToServer("event_services_claim_quest", { group_id: task.group_id, quest_id: task.id })
        })
    }
    else
    {
        let state = $.CreatePanel("Label", card_content, "")
        state.AddClass("PromoCompactTaskState")
        state.text = task.locked ? $.Localize("#services_common_locked") : (task.claimed ? $.Localize("#services_common_claimed") : $.Localize("#services_common_not_completed"))
    }
}

function SurveyBlock(parent, title)
{
    let block = $.CreatePanel("Panel", parent, "")
    block.AddClass("PromoSurveyBlock")
    let label = $.CreatePanel("Label", block, "")
    label.AddClass("PromoSurveyBlockTitle")
    label.text = title
    return block
}

function BinaryChoice(parent, title, value)
{
    let item = $.CreatePanel("Panel", parent, "")
    item.AddClass("PromoSurveyChoice")
    item.AddClass("PromoSurveyBinaryChoice")
    item.SetHasClass("PromoSurveyChoiceActive", SURVEY.recommend === value)
    item.SetPanelEvent("onactivate", function() { if (SURVEY.submitted) return; CacheCurrentSurveyFeedback(); SURVEY.recommend = value; RenderContent() })
    $.CreatePanel("Panel", item, "").AddClass("PromoSurveyCheckbox")
    let label = $.CreatePanel("Label", item, "")
    label.AddClass("PromoSurveyChoiceLabel")
    label.text = title
}

function ToggleSource(name)
{
    let index = SURVEY.selected.indexOf(name)
    if (index === -1) SURVEY.selected.push(name)
    else SURVEY.selected.splice(index, 1)
}

function Cost(parent, amount)
{
    let row = $.CreatePanel("Panel", parent, "")
    row.AddClass("PromoAheadCost")
    let icon = $.CreatePanel("Panel", row, "")
    icon.AddClass("PromoAheadCostIcon")
    SetImage(icon, "file://{images}/game_hud/icons/wood.png")
    let label = $.CreatePanel("Label", row, "")
    label.AddClass("PromoAheadCostLabel")
    label.text = "x" + amount
}

function RenderRewards(parent, rewards, cls)
{
    for (let i = 0; i < rewards.length; i++)
    {
        let reward = rewards[i]
        let panel = $.CreatePanel("Panel", parent, "")
        panel.AddClass(cls)
        SetServiceItemTooltip(panel, reward.id, reward.count)

        let panel_bg1 = $.CreatePanel("Panel", panel, "")
        panel_bg1.AddClass("reward_bg_1")

        let panel_bg2 = $.CreatePanel("Panel", panel, "")
        panel_bg2.AddClass("reward_bg_2")
        AddRarityClass(panel_bg2, GetRewardRarity(reward))

        let icon = $.CreatePanel("Panel", panel, "")
        icon.AddClass("PromoRewardIcon")
        SetImage(icon, reward.icon)
        let count = $.CreatePanel("Label", panel, "")
        count.AddClass("PromoRewardCount")
        count.text = "x" + String(reward.count || 1)
    }
}

function MakeButton(parent, text, cls, callback, id)
{
    let button = $.CreatePanel("Panel", parent, id || "")
    if (cls) 
    {
        let classes = cls.split(/\s+/);
        for (let i = 0; i < classes.length; i++) 
        {
            if (classes[i]) 
            {
                button.AddClass(classes[i]);
            }
        }
    }
    
    button.SetPanelEvent("onactivate", function()
    {
        Game.EmitSound("General.ButtonClick")
        callback()
    })
    let label = $.CreatePanel("Label", button, "ButtonLabel")
    label.text = text
    return button
}

function SetButtonText(button, text)
{
    if (!button) return
    let label = button.FindChildTraverse("ButtonLabel")
    if (!label)
    {
        let children = button.Children()
        for (let i = 0; i < children.length; i++)
        {
            if (children[i].paneltype === "Label")
            {
                label = children[i]
                break
            }
        }
    }
    if (label) label.text = text
}

function SetImage(panel, path)
{
    panel.style.backgroundImage = "url('" + path + "')"
    panel.style.backgroundSize = "contain"
    panel.style.backgroundRepeat = "no-repeat"
    panel.style.backgroundPosition = "center"
}

InitPromo()