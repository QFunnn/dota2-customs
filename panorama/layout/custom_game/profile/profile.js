--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var pass_blocks = {}

var achivement_list = {}

var atlas_list = {}

var vip_offer_list = []
var vip_offer_page = 0

var vip_progress_data =
{
    level: 0,
    current_exp: 0,
    next_level_exp: 1,
    shop_button_text: $.Localize("#services_profile_go_store"),
}

var blessing_level_data =
{
    level: 0,
    current_exp: 0,
    next_level_exp: 1,
}

var blessing_privileges_data = []

var demo_mail_messages = []

const PassRewardsPanel = $("#PassRewardsPanel")
const NavigationPanel = $("#NavigationPanel")
const ContentWindows = $("#ContentWindows")
const AchivementList = $("#AchivementList")
const AchivementPanelInfo = $("#AchivementPanelInfo")
const AtlasList = $("#AtlasList")
const AtlasItemInfo = $("#AtlasItemInfo")
const LevelBlessingBadgeValue = $("#LevelBlessingBadgeValue")
const LevelBlessingExpText = $("#LevelBlessingExpText")
const LevelBlessingProgressFill = $("#LevelBlessingProgressFill")
const LevelBlessingClaimButton = $("#LevelBlessingClaimButton")
const LevelBlessingPrivilegesList = $("#LevelBlessingPrivilegesList")
const VipOffersRow = $("#VipOffersRow")
const VipLevelLabel = $("#VipLevelLabel")
const VipProgressText = $("#VipProgressText")
const VipProgressHint = $("#VipProgressHint")
const VipProgressBarFill = $("#VipProgressBarFill")
const VipShopButton = $("#VipShopButton")
const MailInboxList = $("#MailInboxList")
const MailClaimAllButton = $("#MailClaimAllButton")
const MailSenderValue = $("#MailSenderValue")
const MailSubjectValue = $("#MailSubjectValue")
const MailBodyText = $("#MailBodyText")
const MailRewardsSection = $("#MailRewardsSection")
const MailRewardsList = $("#MailRewardsList")
const MailStatusText = $("#MailStatusText")
const MailClaimButton = $("#MailClaimButton")
const ButtonAcceptReward = $("#ButtonAcceptReward")
const ProfileCurrencyRow = $("#ProfileCurrencyRow")

var mail_messages = []
var selected_mail_id = null
var selected_achievement_id = null
var selected_atlas_id = null
var current_achievement_category = "achievement_1"
var ATLAS_PURCHASE_CONFIG =
{
    atlas_2: { currency: "moon", prices: { legendary: 95, immortal: 190, super: 699 } },
    atlas_3: { currency: "night_crystal", prices: { legendary: 195, immortal: 299, super: 599 } },
    atlas_5: { currency: "leaf", prices: { legendary: 90, immortal: 200, super: 379 } },
}

var SERVICE_DISPLAY_ONLY_STATS =
{
    atlas_scrolls_001_dynamic_effect: true,
    atlas_scrolls_002_dynamic_effect: true,
    atlas_scrolls_003_dynamic_effect: true,
    atlas_scrolls_004_dynamic_effect: true,
    atlas_scrolls_005_dynamic_effect: true,
    nature_opened_spheres_str_coefficient_bonus: true,
    nature_opened_spheres_agi_coefficient_bonus: true,
    nature_opened_spheres_int_coefficient_bonus: true,
}

var current_atlas_category = "atlas_1"
var profile_currency_data = []
var profile_render_deferred = false
var profile_player_data_override = null

function GetLocalPlayerKey()
{
    return String(Players.GetLocalPlayer())
}

function GetServiceItems()
{
    return Game.GetCustomTable ? Game.GetCustomTable("services_config", "items") : {}
}

function GetServiceProfileConfig()
{
    return Game.GetCustomTable ? Game.GetCustomTable("services_config", "profile") : {}
}

function GetServicePlayerData()
{
    if (profile_player_data_override)
    {
        return profile_player_data_override
    }
    return Game.GetCustomTable ? Game.GetCustomTable("services_player", GetLocalPlayerKey()) : {}
} 

function HasCompletedProfileDifficulty(difficulty_id)
{
    difficulty_id = String(difficulty_id || "1-1")
    let player_data = GetServicePlayerData() || {}
    let completed_sources = [
        player_data.difficult_complete,
        Game.GetCustomTable ? Game.GetCustomTable("player_difficult_complete", GetLocalPlayerKey()) : null,
    ]

    for (let i = 0; i < completed_sources.length; i++)
    {
        let completed = completed_sources[i]
        if (!completed) continue

        if (completed instanceof Array)
        {
            for (let j = 0; j < completed.length; j++)
            {
                if (String(completed[j]) === difficulty_id) return true
            }
        }
        else if (typeof completed === "object")
        {
            for (let key in completed)
            {
                if (String(key) === difficulty_id || String(completed[key]) === difficulty_id) return true
            }
        }
        else if (String(completed) === difficulty_id)
        {
            return true
        }
    }

    return false
}

function IsProfileExternalPaymentUnlocked()
{
    return HasCompletedProfileDifficulty("1-1")
}

function MergeProfilePlayerData(base_data, patch_data)
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

function OnProfileInventoryUpdate(data)
{
    let base_data = profile_player_data_override || (Game.GetCustomTable ? Game.GetCustomTable("services_player", GetLocalPlayerKey()) : {})
    profile_player_data_override = MergeProfilePlayerData(base_data, data || {})
    RenderProfileFromServices()
}

function LocalizeOrId(name)
{
    let text = String(name || "")
    let localization_key = text.charAt(0) === "#" ? text : "#" + text
    return $.CanLocalize(localization_key) ? $.Localize(localization_key) : text
}

function LocalizeOrFallback(localization_key, fallback_key)
{
    let key = String(localization_key || "")
    if (key.charAt(0) !== "#")
    {
        key = "#" + key
    }
    return $.CanLocalize(key) ? $.Localize(key) : $.Localize(fallback_key)
}

function NormalizeServiceReward(reward)
{
    let item = GetServiceItems()[reward.id] || {}
    return {
        item_id: reward.id,
        reward_name: LocalizeServiceItemName(item, reward.id),
        reward_count: Number(reward.count) || 1,
        icon: item.icon || "file://{images}/game_hud/icons/gold.png",
        rarity: item.rarity || "common",
    }
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

function GetAchievementIcon(achievement)
{
    let achievement_id = achievement && (achievement.id || achievement.name)
    return (achievement && achievement.icon) || ("file://{images}/achivements/" + achievement_id + ".png")
}

function StatListToLabels(stats)
{
    let result = []
    for (let stat_name in (stats || {}))
    {
        let value = Number(stats[stat_name])
        let formatted = isNaN(value)
            ? String(stats[stat_name] || "")
            : (typeof FormatPrecisionValue === "function" ? FormatPrecisionValue(value) : String(Math.round(value * 100) / 100))
        let sign = !isNaN(value) && value >= 0 ? "+" : ""
        let unit = !isNaN(value) && IsLevelUpPercentStatName(stat_name) ? "%" : ""
        let stat_key = "#services_stat_" + stat_name
        let stat_label = ($.CanLocalize && $.CanLocalize(stat_key)) ? $.Localize(stat_key) : stat_name
        if (SERVICE_DISPLAY_ONLY_STATS[stat_name])
        {
            result.push(stat_label)
            continue
        }
        result.push(stat_label + " " + sign + formatted + unit)
    }
    return result
}

function GetAtlasPurchaseData(item, player_data)
{
    item = item || {}
    player_data = player_data || {}
    let category = item.atlas_category || item.category || ""
    let rarity = item.rarity || ""
    let config = ATLAS_PURCHASE_CONFIG[category]
    if (!config || !config.prices || config.prices[rarity] === undefined)
    {
        return null
    }
    let amount = Number(config.prices[rarity]) || 0
    let currency_id = config.currency
    let currencies = player_data.economy_data || {}
    let player_amount = Number(currencies[currency_id]) || 0
    let currency_item = GetServiceItems()[currency_id] || {}
    return {
        currency: currency_id,
        amount: amount,
        player_amount: player_amount,
        can_afford: player_amount >= amount,
        icon: currency_item.icon || "file://{images}/game_hud/icons/gold.png",
    }
}

function RenderAtlasPurchaseBlock(parent, atlas_item_name, atlas_data)
{
    if (!parent || !atlas_data || !atlas_data.purchase)
    {
        return
    }

    let purchase = atlas_data.purchase
    let owned = !!atlas_data.owned
    let can_buy = !owned && !!purchase.can_afford

    let block = $.CreatePanel("Panel", parent, "")
    block.AddClass("AtlasPurchaseBlock")

    let price = $.CreatePanel("Panel", block, "")
    price.AddClass("AtlasPurchasePrice")

    let icon = $.CreatePanel("Panel", price, "")
    icon.AddClass("AtlasPurchaseCurrencyIcon")
    SetPanelImage(icon, purchase.icon)

    let amount = $.CreatePanel("Label", price, "")
    amount.AddClass("AtlasPurchasePriceAmount")
    amount.text = String(purchase.amount)

    let button = $.CreatePanel("Panel", block, "")
    button.AddClass("AtlasPurchaseButton")
    button.SetHasClass("AtlasPurchaseButtonDisabled", !can_buy)
    button.hittest = can_buy
    button.SetPanelEvent("onactivate", function()
    {
        if (!can_buy) return
        GameEvents.SendCustomGameEventToServer("event_services_buy_atlas_item", { item_id: atlas_item_name })
        Game.EmitSound("General.ButtonClick")
    })

    let label = $.CreatePanel("Label", button, "")
    label.AddClass("AtlasPurchaseButtonLabel")
    if (owned)
    {
        label.text = $.Localize("#services_atlas_owned")
    }
    else if (!purchase.can_afford)
    {
        label.text = $.Localize("#services_atlas_buy_unavailable")
    }
    else
    {
        label.text = $.Localize("#services_atlas_buy_button")
    }
}
function RefreshProfileDataFromServices()
{
    let config = GetServiceProfileConfig()
    let player_data = GetServicePlayerData()
    let items = GetServiceItems()
    if (!config || !Object.keys(config).length)
    {
        return false
    }

    profile_currency_data = BuildServiceCurrencyData(player_data)

    pass_blocks = {}
    for (let level in (config.level_rewards || {}))
    {
        let rewards_list = {}
        let index = 1
        for (let reward of Object.values(config.level_rewards[level] || {}))
        {
            rewards_list[index++] = NormalizeServiceReward(reward)
        }
        pass_blocks[level] = { level: Number(level), rewards_list: rewards_list }
    }

    achivement_list = {}
    for (let achievement_id in (config.achievements || {}))
    {
        let achievement = config.achievements[achievement_id]
        let real_achievement_id = achievement.id || achievement_id
        let achievement_name = achievement.name || real_achievement_id
        let state = (player_data.achievements || {})[real_achievement_id] || {}
        let rewards_list = {}
        for (let i = 0; i < Object.values(achievement.levels || {}).length; i++)
        {
            let level_data = Object.values(achievement.levels)[i]
            rewards_list[i + 1] = {}
            let reward_index = 1
            for (let reward of Object.values(level_data.rewards || {}))
            {
                rewards_list[i + 1][reward_index++] = NormalizeServiceReward(reward)
            }
        }
        achivement_list[real_achievement_id] = {
            id: real_achievement_id,
            achivement_name: achievement_name,
            icon: GetAchievementIcon(achievement),
            progress: Number(state.progress) || 0,
            claimed_level: Number(state.claimed_level) || 0,
            has_reclaimable: !!state.has_reclaimable,
            category: achievement.category || "achievement_1",
            hidden: achievement.hidden === true,
            levels: achievement.levels || {},
            rewards_list: rewards_list,
        }
    }

    atlas_list = {}
    for (let item_id in items)
    {
        let item = items[item_id]
        if (item.item_type === "atlas" && !item.hidden_from_atlas)
        {
            let buffs = {}
            let buff_index = 1
            if (Number(item.blessing_exp) > 0)
            {
                buffs[buff_index++] = { altas_buff_title: $.Localize("#services_stat_blessing_exp") + " +" + item.blessing_exp }
            }
            for (let text of StatListToLabels(item.stats))
            {
                buffs[buff_index++] = { altas_buff_title: text }
            }
            atlas_list[item_id] = {
                atlas_name: LocalizeServiceItemName(item, item_id),
                id: item_id,
                icon: item.icon || "file://{images}/game_hud/icons/gold.png",
                rarity: item.rarity || "common",
                category: item.atlas_category || item.category || "atlas_1",
                order_index: Number(item.order_index) || 0,
                owned: Number((player_data.atlas_items || {})[item_id]) > 0,
                purchase: GetAtlasPurchaseData(item, player_data),
                buffs: buffs,
            }
        }
    }

    let blessing_stats = player_data.service_stats && player_data.service_stats.blessing || {}
    blessing_level_data = {
        level: Number(player_data.buffs_level && player_data.buffs_level.level) || 0,
        current_exp: Number(player_data.buffs_level && player_data.buffs_level.experience) || 0,
        next_level_exp: Number(player_data.buffs_next_exp) || 1,
        level_exp_table: (GetServiceProfileConfig().blessing_levels || {}),
        can_claim: !!player_data.buffs_pending_level,
    }
    blessing_privileges_data = StatListToLabels(blessing_stats).map(function(text, index)
    {
        return { id: "blessing_stat_" + index, text: text, active: true }
    })

    vip_progress_data = {
        level: Number(player_data.vip_current_level) || 0,
        current_exp: Number(player_data.vip_level && player_data.vip_level.experience) || 0,
        next_level_exp: Number(player_data.vip_next_exp) || 1,
        level_exp_table: (config.vip_levels || {}),
        shop_button_text: $.Localize("#services_profile_go_store"),
    }
    vip_offer_list = Object.values(config.vip_offers || {}).map(function(offer)
    {
        let purchases = Number(((player_data.vip_level && player_data.vip_level.chest_openeds) || {})[offer.id]) || 0
        let is_small = IsVipSmallOffer(offer)
        let rewards = Object.values(offer.rewards || {}).map(NormalizeServiceReward)
        let is_stone = !is_small && offer.price && offer.price.currency === "stone"
        let stone_amount = is_stone ? Number(offer.price.amount) || 0 : 0
        let price_text = is_small ? $.Localize("#services_common_free") : (offer.site_only ? FormatWebPrice(offer.price) : (is_stone ? String(stone_amount) : "0"))
        return {
            id: offer.id,
            item_id: offer.id,
            title: LocalizeServiceKey(offer.title || offer.name || offer.id),
            name: LocalizeServiceKey(offer.title || offer.name || offer.id),
            icon: rewards[0] ? rewards[0].icon : "file://{images}/game_hud/services/stone.png",
            price: price_text,
            real_price: offer.site_only ? offer.price : null,
            payment_links: offer.payment_links || {},
            sale_text: $.Localize("#services_common_limit"),
            purchases: purchases,
            purchase_limit: Number(offer.purchase_limit) || 0,
            required_level: Number(offer.required_level) || 0,
            is_small: is_small,
            is_stone: is_stone,
            stone_amount: stone_amount,
            currency_icon: is_stone ? "file://{images}/game_hud/services/stone.png" : "",
            site_only: !is_small && !!offer.site_only,
            sort_order: GetVipOfferSortOrder(offer),
            locked: (Number(player_data.vip_current_level) || 0) < (Number(offer.required_level) || 0),
            purchased: (Number(offer.purchase_limit) || 0) > 0 && purchases >= (Number(offer.purchase_limit) || 0),
            rewards: rewards,
        }
    })
    vip_offer_list.sort(function(a, b)
    {
        if (a.required_level !== b.required_level) return a.required_level - b.required_level
        if (a.sort_order !== b.sort_order) return a.sort_order - b.sort_order
        return String(a.id) < String(b.id) ? -1 : 1
    })

    demo_mail_messages = Object.values(player_data.email_data || {}).map(function(mail)
    {
        return {
            id: mail.id,
            sender: GetLocalizedMailField(mail, "sender", "System"),
            subject: GetLocalizedMailField(mail, "title", GetLocalizedMailField(mail, "subject", mail.id)),
            body: GetLocalizedMailField(mail, "text", GetLocalizedMailField(mail, "body", "")),
            is_new: !mail.read && !mail.claimed,
            is_read: !!mail.read,
            rewards_claimed: !!mail.claimed,
            created_at: mail.created_at || "",
            rewards: Object.values(mail.rewards || {}).map(NormalizeServiceReward),
        }
    })

    return true
}

function IsVipSmallOffer(offer)
{
    return String(offer && offer.id || "").indexOf("_small_") !== -1
}

function GetVipOfferSortOrder(offer)
{
    let id = String(offer && offer.id || "")
    if (id.indexOf("_small_") !== -1) return 1
    if (id.indexOf("_big_") !== -1) return 2
    return 3
}

function GetLocalizedMailField(mail, field_name, fallback)
{
    if (!mail) return fallback || ""

    let localized = mail.localized || mail.localization || mail.localizations || mail.languages
    if (localized)
    {
        let language_data = SelectLocalizedServiceValue(localized, null)
        if (language_data && language_data[field_name] !== undefined)
        {
            return language_data[field_name]
        }
    }

    return SelectLocalizedServiceValue(mail[field_name], fallback)
}

function LocalizeServiceKey(value)
{
    let key = String(value || "")
    if (key === "") return ""
    let localize_key = key.charAt(0) === "#" ? key : "#" + key
    return $.CanLocalize && $.CanLocalize(localize_key) ? $.Localize(localize_key) : key
}

function UpdateProfileClaimNotifications()
{
    if (!Game.GetServiceClaimState || !Game.SetServiceNotifyDot)
    {
        return
    }

    let state = (Game.GetServiceClaimState().profile || {})
    Game.SetServiceNotifyDot($("#NavigationButton1"), !!state.profile_level)
    Game.SetServiceNotifyDot($("#NavigationButton2"), !!state.achievements)
    Game.SetServiceNotifyDot($("#NavigationButton3"), false)
    Game.SetServiceNotifyDot($("#NavigationButton4"), !!state.blessing_level)
    Game.SetServiceNotifyDot($("#NavigationButton5"), !!state.vip_free)
    let has_unread_mail = !!state.mail
    if (mail_messages && mail_messages.length > 0)
    {
        has_unread_mail = mail_messages.some(function(mail_data) { return mail_data && !mail_data.is_read })
    }
    Game.SetServiceNotifyDot($("#NavigationButton6"), has_unread_mail)

    let achievement_categories = ["achievement_1", "achievement_2", "achievement_3", "achievement_4", "achievement_5", "achievement_6"]
    for (let i = 0; i < achievement_categories.length; i++)
    {
        let category = achievement_categories[i]
        Game.SetServiceNotifyDot($("#AchievementSubButton_" + category), !!(state.achievement_categories && state.achievement_categories[category]))
    }

    if (Game.UpdateServiceTopClaimNotifications)
    {
        Game.UpdateServiceTopClaimNotifications()
    }
}

function RenderProfileFromServices(table_name, key, data)
{
    if (table_name === "services_player" && String(key) === GetLocalPlayerKey() && data)
    {
        profile_player_data_override = data
    }
    if (typeof IsContextWindowVisible === "function" && !IsContextWindowVisible("PlayerProfile"))
    {
        profile_render_deferred = true
        if (RefreshProfileDataFromServices())
        {
            RenderProfileCurrencies()
            UpdateProfileClaimNotifications()
        }
        return
    }

    if (!RefreshProfileDataFromServices())
    {
        return
    }
    InitPassRewards()
    RenderProfileLevel()
    InitAchivements()
    RefreshSelectedAchievementInfo()
    InitAtlas()
    RefreshSelectedAtlasInfo()
    InitBlessingLevel()
    InitVip()
    InitMail()
    RenderProfileCurrencies()
    UpdateProfileSubNavigation()
    UpdateProfileClaimNotifications()
}

function RenderProfileIfDeferred()
{
    if (!profile_render_deferred)
    {
        return
    }
    profile_render_deferred = false
    RenderProfileFromServices()
}

if (typeof Game !== 'undefined') Game.RenderProfileIfDeferred = RenderProfileIfDeferred

function Init()
{
    RefreshProfileDataFromServices()
    InitPassRewards()
    RenderProfileLevel()
    InitAchivements()
    InitAtlas()
    RefreshSelectedAtlasInfo()
    InitBlessingLevel()
    InitVip()
    InitMail()
    RenderProfileCurrencies()
    UpdateProfileSubNavigation()
    UpdateProfileClaimNotifications()

    if (Game.SubscribeCustomTableListener)
    {
        Game.SubscribeCustomTableListener("services_config", "profile", RenderProfileFromServices)
        Game.SubscribeCustomTableListener("services_config", "items", RenderProfileFromServices)
        Game.SubscribeCustomTableListener("services_player", GetLocalPlayerKey(), RenderProfileFromServices)
        Game.SubscribeCustomTableListener("player_difficult_complete", GetLocalPlayerKey(), RenderProfileFromServices)
    }
    GameEvents.Subscribe("event_services_inventory_update", OnProfileInventoryUpdate)
}

function RenderProfileLevel()
{
    let player_data = GetServicePlayerData()
    let profile_config = GetServiceProfileConfig()
    let profile = player_data.profile_level || {}
    let current_exp = Number(profile.experience) || 0
    let next_exp = Math.max(1, Number(player_data.profile_next_exp) || 1)
    let current_level = Number(player_data.profile_current_level)
    if (isNaN(current_level)) current_level = 0
    let prev_exp = Number((profile_config.level_exp || {})[current_level]) || 0
    let level_exp = Math.max(0, current_exp - prev_exp)
    let level_need = Math.max(1, next_exp - prev_exp)
    let progress = Math.max(0, Math.min(1, level_exp / level_need))
    let level_labels = ContentWindows.FindChildrenWithClassTraverse("PassLevelLabel")
    if (level_labels && level_labels[0])
    {
        level_labels[0].text = String(current_level)
    }
    let exp_labels = ContentWindows.FindChildrenWithClassTraverse("LevelLineTitleInfo")
    if (exp_labels && exp_labels[0])
    {
        exp_labels[0].text = level_exp + "/" + level_need
    }
    let fills = ContentWindows.FindChildrenWithClassTraverse("LevelLineSync")
    if (fills && fills[0])
    {
        fills[0].style.width = (progress * 100) + "%"
    }

    let can_claim = !!player_data.profile_has_claim
    if (ButtonAcceptReward)
    {
        ButtonAcceptReward.SetHasClass("ButtonAcceptRewardActive", can_claim)
    }
}

function ClaimProfileLevelRewards()
{
    let player_data = GetServicePlayerData()
    if (!player_data || !player_data.profile_has_claim)
    {
        return
    }
    GameEvents.SendCustomGameEventToServer("event_services_claim_profile_rewards", {})
    Game.EmitSound("General.ButtonClick")
}

function RenderProfileCurrencies()
{
    if (!ProfileCurrencyRow)
    {
        return
    }

    ProfileCurrencyRow.RemoveAndDeleteChildren()
    if (typeof RenderServiceServerSyncButton === "function")
    {
        RenderServiceServerSyncButton(ProfileCurrencyRow)
    }
    for (let currency of profile_currency_data)
    {
        let panel = $.CreatePanel("Panel", ProfileCurrencyRow, "")
        panel.AddClass("ProfileCurrencyPanel")

        let icon = $.CreatePanel("Panel", panel, "")
        icon.AddClass("ProfileCurrencyIcon")
        SetPanelImage(icon, currency.icon)

        let label = $.CreatePanel("Label", panel, "")
        label.AddClass("ProfileCurrencyAmount")
        label.text = currency.amount

        if (typeof SetServiceItemTooltip === "function")
        {
            SetServiceItemTooltip(panel, currency.id, currency.amount)
        }
    }
    if (typeof RenderServiceCurrencyMoreButton === "function")
    {
        RenderServiceCurrencyMoreButton(ProfileCurrencyRow, (GetServicePlayerData().economy_data || {}))
    }
}

function InitAchivements()
{
    AchivementList.RemoveAndDeleteChildren()
    let achivements_data = Object.values(achivement_list).filter(function(data)
    {
        return (data.category || "achievement_1") === current_achievement_category
    })

    let AchivementDesc = $.CreatePanel("Panel", AchivementList, "")
    AchivementDesc.AddClass("AchivementDesc")

    let counter_achivements = 0

    for (let achivement_data of achivements_data)
    {
        let AchivementPanel = CreateAchivementPanel(AchivementDesc, achivement_data.achivement_name, achivement_data)
        AchivementPanel.AddClass("HasAchivimentHover")
        AchivementPanel.SetPanelEvent("onactivate", function()
        {
            RequestInfoAchivement(achivement_data.achivement_name, achivement_data)
        })
        counter_achivements += 1
        if (counter_achivements >= 4)
        {
            AchivementDesc.style.horizontalAlign = "center"
            AchivementDesc = $.CreatePanel("Panel", AchivementList, "")
            AchivementDesc.AddClass("AchivementDesc")
            counter_achivements = 0
        }
    }
}

function GetAchievementProgressDisplay(achivement_data)
{
    let claimed_level = Number(achivement_data && achivement_data.claimed_level) || 0
    let levels = (achivement_data && achivement_data.levels) || {}
    let next_level = claimed_level + 1
    let next_level_data = levels[next_level]
    let progress = Number(achivement_data && achivement_data.progress) || 0
    let goal = Number(next_level_data && next_level_data.goal) || 0

    if (achivement_data && achivement_data.hidden === true)
    {
        if (!next_level_data)
        {
            return {
                claimed_level: claimed_level,
                next_level: next_level,
                next_level_data: next_level_data,
                progress: 1,
                goal: 1,
            }
        }

        return {
            claimed_level: claimed_level,
            next_level: next_level,
            next_level_data: next_level_data,
            progress: goal > 0 && progress >= goal ? 1 : 0,
            goal: 1,
        }
    }

    if (!next_level_data)
    {
        let level_keys = Object.keys(levels).map(function(level) { return Number(level) || 0 }).filter(function(level) { return level > 0 }).sort(function(a, b) { return a - b })
        let last_level = level_keys.length > 0 ? level_keys[level_keys.length - 1] : 0
        let last_level_data = levels[last_level]
        goal = Number(last_level_data && last_level_data.goal) || 0
        progress = goal > 0 ? goal : progress
    }
    else if (goal > 0)
    {
        progress = Math.min(progress, goal)
    }

    return {
        claimed_level: claimed_level,
        next_level: next_level,
        next_level_data: next_level_data,
        progress: progress,
        goal: goal,
    }
}

function CreateAchivementPanel(parent_panel, achivement_name, achivement_data)
{
    let AchivementPanel = $.CreatePanel("Panel", parent_panel, "achivement_"+achivement_name)
    AchivementPanel.AddClass("AchivementPanel")
    AchivementPanel.achivement_name = achivement_name

    let AchivementPanelBG = $.CreatePanel("Panel", AchivementPanel, "")
    AchivementPanelBG.AddClass("AchivementPanelBG")

    let AchivementPanelBGBorder = $.CreatePanel("Panel", AchivementPanel, "")
    AchivementPanelBGBorder.AddClass("AchivementPanelBGBorder")

    let Achivement_Body = $.CreatePanel("Panel", AchivementPanel, "")
    Achivement_Body.AddClass("Achivement_Body")

    let AchivementIcon = $.CreatePanel("Panel", Achivement_Body, "")
    AchivementIcon.AddClass("AchivementIcon")
    SetPanelImage(AchivementIcon, achivement_data && achivement_data.icon)

    let AchivementData = $.CreatePanel("Panel", Achivement_Body, "")
    AchivementData.AddClass("AchivementData")
    
    let AchivementDataHeader = $.CreatePanel("Panel", AchivementData, "")
    AchivementDataHeader.AddClass("AchivementDataHeader")
    
    let AchivementDataHeaderLevel = $.CreatePanel("Label", AchivementDataHeader, "")
    AchivementDataHeaderLevel.AddClass("AchivementDataHeaderLevel")
    let progress_display = GetAchievementProgressDisplay(achivement_data)
    AchivementDataHeaderLevel.text = progress_display.claimed_level
    let _can_claim = (!!progress_display.next_level_data && progress_display.goal > 0 && (Number(achivement_data && achivement_data.progress) || 0) >= progress_display.goal) || !!(achivement_data && achivement_data.has_reclaimable)
    if (Game.SetServiceNotifyDot) Game.SetServiceNotifyDot(AchivementPanel, _can_claim)

    let AchivementDataHeaderProgressLabel = $.CreatePanel("Label", AchivementDataHeader, "")
    AchivementDataHeaderProgressLabel.AddClass("AchivementDataHeaderProgressLabel")
    AchivementDataHeaderProgressLabel.text = progress_display.progress + "/" + progress_display.goal

    let AchivementDataLine = $.CreatePanel("Panel", AchivementData, "")
    AchivementDataLine.AddClass("AchivementDataLine")

    let AchivementDataLineSync = $.CreatePanel("Panel", AchivementDataLine, "")
    AchivementDataLineSync.AddClass("AchivementDataLineSync")
    AchivementDataLineSync.style.width = (progress_display.goal > 0 ? Math.min(100, progress_display.progress / progress_display.goal * 100) : 0) + "%"

    let AchivementName = $.CreatePanel("Label", Achivement_Body, "")
    AchivementName.AddClass("AchivementName")
    AchivementName.text = LocalizeOrId(achivement_name)

    return AchivementPanel
}

function RequestInfoAchivement(achivement_name, achivement_data)
{
    selected_achievement_id = achivement_data && achivement_data.id ? achivement_data.id : null
    for (let child of AchivementList.FindChildrenWithClassTraverse("AchivementPanel"))
    {
        child.SetHasClass("AchivementActive", child.achivement_name == achivement_name)
    }
    AchivementPanelInfo.RemoveAndDeleteChildren()
    CreateAchivementPanel(AchivementPanelInfo, achivement_name, achivement_data)

    let AchivementBlockInfo = $.CreatePanel("Panel", AchivementPanelInfo, "")
    AchivementBlockInfo.AddClass("AchivementBlockInfo")

    let AchivementBlockInfo_1 = $.CreatePanel("Panel", AchivementBlockInfo, "")
    AchivementBlockInfo_1.AddClass("AchivementBlockInfoHeader")
    
    let AchivementBlockInfoHeaderLabel_1 = $.CreatePanel("Label", AchivementBlockInfo_1, "")
    AchivementBlockInfoHeaderLabel_1.AddClass("AchivementBlockInfoHeaderLabel")
    AchivementBlockInfoHeaderLabel_1.text = $.Localize("#services_achievement_rewards")

    let AchivementRewardScroll = $.CreatePanel("Panel", AchivementBlockInfo, "")
    AchivementRewardScroll.AddClass("AchivementRewardScroll")

    if (achivement_data && achivement_data.rewards_list)
    {
        let claimed_level = Number(achivement_data.claimed_level) || 0
        for (let reward_level of Object.keys(achivement_data.rewards_list))
        {
            let reward_level_number = Number(reward_level) || 0
            let AchivementRewardItem = $.CreatePanel("Panel", AchivementRewardScroll, "")
            AchivementRewardItem.AddClass("AchivementRewardItem")
            AchivementRewardItem.SetHasClass("AchivementRewardItemLocked", reward_level_number > claimed_level)

            let AchivementRewardItemBG = $.CreatePanel("Panel", AchivementRewardItem, "")
            AchivementRewardItemBG.AddClass("AchivementRewardItemBG")
            AchivementRewardItemBG.SetHasClass("AchivementRewardItemBGLocked", reward_level_number > claimed_level)

            let AchivementRewardLevel = $.CreatePanel("Label", AchivementRewardItem, "")
            AchivementRewardLevel.AddClass("AchivementRewardLevel")
            AchivementRewardLevel.text = reward_level

            let AchivementRewardRewardsList = $.CreatePanel("Panel", AchivementRewardItem, "")
            AchivementRewardRewardsList.AddClass("AchivementRewardRewardsList")

            for (let reward_data of Object.values(achivement_data.rewards_list[reward_level]))
            {
                let AchivementRewardPanel = $.CreatePanel("Panel", AchivementRewardRewardsList, "")
                AchivementRewardPanel.AddClass("AchivementRewardPanel")
                SetServiceItemTooltip(AchivementRewardPanel, reward_data.item_id, reward_data.reward_count)

                let AchivementRewardIcon = $.CreatePanel("Panel", AchivementRewardPanel, "")
                AchivementRewardIcon.AddClass("AchivementRewardIcon")
                SetPanelImage(AchivementRewardIcon, reward_data.icon)

                let AchivementRewardCount = $.CreatePanel("Label", AchivementRewardPanel, "")
                AchivementRewardCount.AddClass("AchivementRewardCount")
                AchivementRewardCount.text = "x" + String(reward_data.reward_count || 1)

                let AchivementRewardBorder_1 = $.CreatePanel("Panel", AchivementRewardPanel, "")
                AchivementRewardBorder_1.AddClass("AchivementRewardBorder_1")

                let AchivementRewardBorder_2 = $.CreatePanel("Panel", AchivementRewardPanel, "")
                AchivementRewardBorder_2.AddClass("AchivementRewardBorder_2")
                if (reward_data.rarity && reward_data.rarity != "common")
                {
                    AchivementRewardBorder_2.AddClass("RareColor_" + reward_data.rarity)
                }
            }
        }
    }

    let AchivementBlockInfoSecond = $.CreatePanel("Panel", AchivementPanelInfo, "")
    AchivementBlockInfoSecond.AddClass("AchivementBlockInfoSecond")

    let AchivementBlockInfoHeader = $.CreatePanel("Panel", AchivementBlockInfoSecond, "")
    AchivementBlockInfoHeader.AddClass("AchivementBlockInfoHeader")
    
    let AchivementBlockInfoHeaderLabel = $.CreatePanel("Label", AchivementBlockInfoHeader, "")
    AchivementBlockInfoHeaderLabel.AddClass("AchivementBlockInfoHeaderLabel")
    AchivementBlockInfoHeaderLabel.text = $.Localize("#services_achievement_how_to_get")

    let AchivementBodyText = $.CreatePanel("Label", AchivementBlockInfoSecond, "")
    AchivementBodyText.AddClass("AchivementBodyText")
    AchivementBodyText.html = true
    AchivementBodyText.text = achivement_data && achivement_data.hidden === true
        ? $.Localize("#services_achievement_body_hint")
        : LocalizeOrFallback(achivement_name + "_description", "#services_achievement_body_hint")

    let AchivementBlockButtonClaim = $.CreatePanel("Panel", AchivementPanelInfo, "")
    AchivementBlockButtonClaim.AddClass("AchivementBlockButtonClaim")
    let progress_display = GetAchievementProgressDisplay(achivement_data)
    let new_level_claim = !!progress_display.next_level_data && progress_display.goal > 0 && (Number(achivement_data && achivement_data.progress) || 0) >= progress_display.goal
    let can_claim = new_level_claim || !!(achivement_data && achivement_data.has_reclaimable)
    AchivementBlockButtonClaim.SetHasClass("AchivementBlockButtonClaimDisabled", !can_claim)
    AchivementBlockButtonClaim.SetPanelEvent("onactivate", function()
    {
        if (!can_claim)
        {
            return
        }
        if (new_level_claim)
        {
            achivement_data.claimed_level = progress_display.next_level
        }
        achivement_data.has_reclaimable = false
        achivement_list[achivement_data.id] = achivement_data
        RequestInfoAchivement(achivement_name, achivement_data)
        GameEvents.SendCustomGameEventToServer("event_services_claim_achievement", { achievement_id: achivement_data.id || achivement_name })
        Game.EmitSound("General.ButtonClick")
    })
    
    let AchivementBlockButtonClaimLabel = $.CreatePanel("Label", AchivementBlockButtonClaim, "")
    AchivementBlockButtonClaimLabel.AddClass("AchivementBlockButtonClaimLabel")
    AchivementBlockButtonClaimLabel.text = $.Localize("#services_common_claim")
}

function RefreshSelectedAchievementInfo()
{
    if (!selected_achievement_id || !achivement_list[selected_achievement_id] || (achivement_list[selected_achievement_id].category || "achievement_1") !== current_achievement_category)
    {
        let first_achievement = Object.values(achivement_list).filter(function(data)
        {
            return (data.category || "achievement_1") === current_achievement_category
        })[0]
        if (first_achievement)
        {
            selected_achievement_id = first_achievement.id
            RequestInfoAchivement(first_achievement.achivement_name, first_achievement)
        }
        return
    }
    let achivement_data = achivement_list[selected_achievement_id]
    RequestInfoAchivement(achivement_data.achivement_name, achivement_data)
}

function InitPassRewards()
{
    PassRewardsPanel.RemoveAndDeleteChildren()
    let pass_data = Object.values(pass_blocks)
    let player_data = GetServicePlayerData()
    let current_level = Number(player_data.profile_current_level) || 0
    let claimed_levels = ((player_data.profile_level || {}).levels_reached) || {}
    for (let reward_data of pass_data)
    {
        let PassRewardPanel = $.CreatePanel("Panel", PassRewardsPanel, "pass_level_"+reward_data.level)
        PassRewardPanel.AddClass("PassRewardPanel")
        let reward_level = Number(reward_data.level) || 0
        let reward_claimed = !!claimed_levels[String(reward_level)]
        let reward_available = reward_level <= current_level && !reward_claimed
        PassRewardPanel.SetHasClass("PassRewardPanelLocked", reward_level > current_level)
        PassRewardPanel.SetHasClass("PassRewardPanelReady", reward_available)
        PassRewardPanel.SetHasClass("PassRewardPanelClaimed", reward_claimed)

        if (reward_available || reward_claimed)
        {
            $.CreatePanel("DOTAParticleScenePanel", PassRewardPanel, "", 
            { 
                class: "ParticlePassFx",
                particleName: "particles/ui/pass_flares.vpcf", 
                particleonly:"true", 
                startActive:"true", 
                cameraOrigin:"0 0 100", 
                lookAt:"0 0 0",  
                fov:"64", 
                squarePixels:"true",
                hittest: "false"
            });
        }

        let PassRewardLevel = $.CreatePanel("Label", PassRewardPanel, "")
        PassRewardLevel.AddClass("PassRewardLevel")
        PassRewardLevel.text = reward_data.level

        let PassRewardItemsList = $.CreatePanel("Panel", PassRewardPanel, "")
        PassRewardItemsList.AddClass("PassRewardItemsList")

        for (let reward_item of Object.values(reward_data.rewards_list))
        {
            let PassRewardItem = $.CreatePanel("Panel", PassRewardItemsList, "")
            PassRewardItem.AddClass("PassRewardItem")
            SetServiceItemTooltip(PassRewardItem, reward_item.item_id, reward_item.reward_count)
            PassRewardItem.SetHasClass("PassRewardItemLocked", reward_level > current_level)
            PassRewardItem.SetHasClass("PassRewardItemReady", reward_available)
            PassRewardItem.SetHasClass("PassRewardItemClaimed", reward_claimed)

            let PassRewardBorder = $.CreatePanel("Panel", PassRewardItem, "")
            PassRewardBorder.AddClass("PassRewardBorder")

            let PassRewardBorderBG = $.CreatePanel("Panel", PassRewardItem, "")
            PassRewardBorderBG.AddClass("PassRewardBorderBG")
            if (reward_item.rarity && reward_item.rarity != "common")
            {
                PassRewardBorderBG.AddClass("RareColor_" + reward_item.rarity)
            }

            let PassRewardItemIcon = $.CreatePanel("Panel", PassRewardItem, "")
            PassRewardItemIcon.AddClass("PassRewardItemIcon")
            SetPanelImage(PassRewardItemIcon, reward_item.icon)

            let PassRewardItemCount = $.CreatePanel("Label", PassRewardItem, "")
            PassRewardItemCount.AddClass("PassRewardItemCount")
            PassRewardItemCount.text = reward_item.reward_count
        }
    }
}

function InitAtlas()
{
    AtlasList.RemoveAndDeleteChildren()
    let atlas_data = Object.values(atlas_list).filter(function(data)
    {
        return (data.category || "atlas_1") === current_atlas_category
    })
    let rarity_order = { common: 0, rare: 1, mythical: 2, legendary: 3, immortal: 4, super: 5, unique: 6 }
    atlas_data.sort(function(a, b)
    {
        let rarity_a = rarity_order[a.rarity] === undefined ? 99 : rarity_order[a.rarity]
        let rarity_b = rarity_order[b.rarity] === undefined ? 99 : rarity_order[b.rarity]
        if (rarity_a !== rarity_b) return rarity_a - rarity_b
        return (Number(a.order_index) || 0) - (Number(b.order_index) || 0)
    })

    let AtlasDesc = $.CreatePanel("Panel", AtlasList, "")
    AtlasDesc.AddClass("AtlasDesc")

    let counter_atlas_items = 0

    for (let atlas_item_data of atlas_data)
    {
        let AtlasItemPanel = CreateAtlasItemPanel(AtlasDesc, atlas_item_data.id, atlas_item_data)
        AtlasItemPanel.AddClass("HasAtlasItemHover")
        
        AtlasItemPanel.SetPanelEvent("onactivate", function()
        {
            RequestInfoAtlasItem(atlas_item_data.id, atlas_item_data)
        })
        counter_atlas_items += 1
        if (counter_atlas_items >= 4)
        {
            AtlasDesc.style.horizontalAlign = "center"
            AtlasDesc = $.CreatePanel("Panel", AtlasList, "")
            AtlasDesc.AddClass("AtlasDesc")
            counter_atlas_items = 0
        }
    }
}

function RefreshSelectedAtlasInfo()
{
    if (!selected_atlas_id)
    {
        return
    }
    let atlas_data = atlas_list[selected_atlas_id]
    if (!atlas_data || (atlas_data.category || "atlas_1") !== current_atlas_category)
    {
        AtlasItemInfo.RemoveAndDeleteChildren()
        return
    }
    RequestInfoAtlasItem(selected_atlas_id, atlas_data, true)
}
function InitBlessingLevel()
{
    RenderBlessingLevelHeader()
    SetBlessingPrivileges(blessing_privileges_data)

    if (LevelBlessingClaimButton)
    {
        LevelBlessingClaimButton.SetPanelEvent("onactivate", function()
        {
            if (!blessing_level_data.can_claim) return
            GameEvents.SendCustomGameEventToServer("event_services_claim_blessing_level", {})
            Game.EmitSound("General.ButtonClick")
        })
    }
}

function RenderBlessingLevelHeader()
{
    if (!LevelBlessingBadgeValue || !LevelBlessingExpText || !LevelBlessingProgressFill)
    {
        return
    }

    let level = Math.max(0, Number(blessing_level_data.level) || 0)
    let current_exp = Math.max(0, Number(blessing_level_data.current_exp) || 0)
    let next_level_exp = Math.max(1, Number(blessing_level_data.next_level_exp) || 1)
    let current_level_exp = Number((blessing_level_data.level_exp_table || {})[level] && (blessing_level_data.level_exp_table || {})[level].exp) || 0
    let level_exp = Math.max(0, current_exp - current_level_exp)
    let level_need = Math.max(1, next_level_exp - current_level_exp)
    let progress = Math.min(1, level_exp / level_need)

    LevelBlessingBadgeValue.text = String(level)
    LevelBlessingExpText.text = level_exp + " / " + level_need
    LevelBlessingProgressFill.style.width = (progress * 100) + "%"
    if (LevelBlessingClaimButton)
    {
        LevelBlessingClaimButton.SetHasClass("LevelBlessingClaimButtonDisabled", !blessing_level_data.can_claim)
        LevelBlessingClaimButton.SetHasClass("LevelBlessingClaimButtonActive", !!blessing_level_data.can_claim)
    }
}

function NormalizeBlessingPrivilege(privilege_data, index)
{
    return {
        id: String(privilege_data && privilege_data.id || ("blessing_privilege_" + index)),
        text: String(privilege_data && privilege_data.text || ""),
        active: !!(privilege_data && privilege_data.active),
    }
}

function SetBlessingPrivileges(privileges_list)
{
    blessing_privileges_data = (privileges_list || []).map(function(privilege_data, index)
    {
        return NormalizeBlessingPrivilege(privilege_data, index)
    })

    RenderBlessingPrivileges()
}

function RenderBlessingPrivileges()
{
    if (!LevelBlessingPrivilegesList)
    {
        return
    }

    LevelBlessingPrivilegesList.RemoveAndDeleteChildren()

    for (let privilege_data of blessing_privileges_data)
    {
        let BlessingPrivilegeItem = $.CreatePanel("Panel", LevelBlessingPrivilegesList, "blessing_privilege_" + privilege_data.id)
        BlessingPrivilegeItem.AddClass("LevelBlessingPrivilegeItem")
        BlessingPrivilegeItem.SetHasClass("LevelBlessingPrivilegeInactive", !privilege_data.active)

        let BlessingPrivilegeText = $.CreatePanel("Label", BlessingPrivilegeItem, "")
        BlessingPrivilegeText.AddClass("LevelBlessingPrivilegeText")
        BlessingPrivilegeText.text = privilege_data.text
    }
}

function InitVip()
{
    RenderVipOffers()
    RenderVipProgress()

    if (VipShopButton)
    {
        VipShopButton.SetPanelEvent("onactivate", function()
        {
            if (Game.SwitchAnothersPanel)
            {
                Game.SwitchAnothersPanel("StoreWindow")
                Game.EmitSound("General.ButtonClick")
            }
        })
    }
}

function RenderVipOffers()
{
    if (!VipOffersRow)
    {
        return
    }

    VipOffersRow.RemoveAndDeleteChildren()

    let page_count = Math.max(1, Math.ceil(vip_offer_list.length / 2))
    vip_offer_page = Math.max(0, Math.min(page_count - 1, vip_offer_page))

    let leftArrow = CreateVipOfferArrow(VipOffersRow, "<", vip_offer_page <= 0, function()
    {
        vip_offer_page = Math.max(0, vip_offer_page - 1)
        RenderVipOffers()
    })

    let VipOffersViewport = $.CreatePanel("Panel", VipOffersRow, "")
    VipOffersViewport.AddClass("VipOffersViewport")

    let visible_offers = vip_offer_list.slice(vip_offer_page * 2, vip_offer_page * 2 + 2)
    let chest_id = 1
    for (let vip_offer of visible_offers)
    {
        let VipOfferPanel = $.CreatePanel("Panel", VipOffersViewport, "vip_offer_" + vip_offer.id)
        VipOfferPanel.AddClass("VipOfferPanel")
        VipOfferPanel.AddClass("VipOfferPanel"+chest_id)
        VipOfferPanel.SetHasClass("VipOfferPanelLocked", !!vip_offer.locked)
        VipOfferPanel.SetHasClass("VipOfferPanelPurchased", !!vip_offer.purchased)
        chest_id = chest_id + 1

        if (!vip_offer.locked && !vip_offer.purchased)
        {
            $.CreatePanel("DOTAParticleScenePanel", VipOfferPanel, "",
            {
                class: "ParticleChest",
                particleName: "particles/chest_ui/chest_ui_rays_upd.vpcf",
                particleonly: "true",
                startActive: "true",
                cameraOrigin: "0 0 550",
                lookAt: "0 0 0",
                fov: "65",
                squarePixels: "true",
                hittest: "false"
            })
        }

        let VipOfferTitle = $.CreatePanel("Label", VipOfferPanel, "")
        VipOfferTitle.AddClass("VipOfferTitle")
        VipOfferTitle.text = vip_offer.title

        let VipOfferRewardsFrame = $.CreatePanel("Panel", VipOfferPanel, "")
        VipOfferRewardsFrame.AddClass("VipOfferRewardsFrame")

        let VipOfferRewardsList = $.CreatePanel("Panel", VipOfferRewardsFrame, "")
        VipOfferRewardsList.AddClass("VipOfferRewardsList")
        if (vip_offer.rewards.length >= 4)
        {
            VipOfferRewardsList.AddClass("VipOfferRewardsListSmall")
        }
        
        for (let reward_data of vip_offer.rewards)
        {
            let VipRewardItem = $.CreatePanel("Panel", VipOfferRewardsList, "")
            VipRewardItem.AddClass("VipRewardItem")
            VipRewardItem.SetHasClass("ServiceRewardClaimed", !!vip_offer.purchased)
            SetServiceItemTooltip(VipRewardItem, reward_data.item_id, reward_data.reward_count)

            let VipRewardItemBG1 = $.CreatePanel("Panel", VipRewardItem, "")
            VipRewardItemBG1.AddClass("VipRewardItemBG1")

            let VipRewardItemBG2 = $.CreatePanel("Panel", VipRewardItem, "")
            VipRewardItemBG2.AddClass("VipRewardItemBG2")

            if (reward_data.rarity && reward_data.rarity != "common")
            {
                VipRewardItemBG2.AddClass("RareColor_" + reward_data.rarity)
            }

            let VipRewardIcon = $.CreatePanel("Panel", VipRewardItem, "")
            VipRewardIcon.AddClass("VipRewardIcon")
            ApplyRewardIcon(VipRewardIcon, reward_data.icon)

            let VipRewardCount = $.CreatePanel("Label", VipRewardItem, "")
            VipRewardCount.AddClass("VipRewardCount")
            VipRewardCount.text = String(reward_data.reward_count || 1)

            if (vip_offer.purchased)
            {
                let check = $.CreatePanel("Panel", VipRewardItem, "")
                check.AddClass("ServiceRewardClaimCheck")
            }
        }

        let VipOfferBuyButton = $.CreatePanel("Panel", VipOfferPanel, "")
        VipOfferBuyButton.AddClass("VipOfferBuyButton")
        let external_locked = vip_offer.site_only && !IsProfileExternalPaymentUnlocked()
        VipOfferBuyButton.SetHasClass("VipOfferBuyButtonDisabled", vip_offer.locked || vip_offer.purchased || external_locked)
        VipOfferBuyButton.hittest = !vip_offer.locked && !vip_offer.purchased && !external_locked
        VipOfferBuyButton.SetPanelEvent("onactivate", function()
        {
            if (vip_offer.locked || vip_offer.purchased || external_locked) return
            if (vip_offer.is_small)
            {
                GameEvents.SendCustomGameEventToServer("event_services_claim_vip_offer", { offer_id: vip_offer.id })
                Game.EmitSound("General.ButtonClick")
                return
            }

            if (vip_offer.is_stone)
            {
                GameEvents.SendCustomGameEventToServer("event_services_buy_vip_offer", { offer_id: vip_offer.id })
                Game.EmitSound("General.ButtonClick")
                return
            }

            if (vip_offer.site_only)
            {
                OpenProfileExternalPaymentModal(vip_offer, 1)
                Game.EmitSound("General.ButtonClick")
                return
            }
        })

        let VipOfferBuyBody = $.CreatePanel("Panel", VipOfferBuyButton, "")
        VipOfferBuyBody.AddClass("VipOfferBuyBody")
        if (!vip_offer.purchased && vip_offer.is_stone && vip_offer.currency_icon)
        {
            let currencyIcon = $.CreatePanel("Panel", VipOfferBuyBody, "")
            currencyIcon.AddClass("VipOfferBuyCurrencyIcon")
        }
        let VipOfferBuyPrice = $.CreatePanel("Label", VipOfferBuyBody, "")
        VipOfferBuyPrice.AddClass("VipOfferBuyPrice")
        if (vip_offer.purchased)
        {
            VipOfferBuyPrice.text = $.Localize("#services_store_purchased")
        }
        else
        {
            VipOfferBuyPrice.text = vip_offer.price
        }

        let VipOfferLimit = $.CreatePanel("Label", VipOfferPanel, "")
        VipOfferLimit.AddClass("VipOfferLimit")
        VipOfferLimit.text = vip_offer.sale_text + ": " + vip_offer.purchases + " / " + vip_offer.purchase_limit

        if (vip_offer.locked || vip_offer.purchased)
        {
            let stateLabel = $.CreatePanel("Label", VipOfferPanel, "")
            stateLabel.AddClass("VipOfferStateLabel")
            stateLabel.SetHasClass("VipOfferStateLabelPurchased", !!vip_offer.purchased)
            stateLabel.text = vip_offer.purchased ? $.Localize("#services_store_purchased") : ("VIP " + String(vip_offer.required_level))
        }
    }

    CreateVipOfferArrow(VipOffersRow, ">", vip_offer_page >= page_count - 1, function()
    {
        vip_offer_page = Math.min(page_count - 1, vip_offer_page + 1)
        RenderVipOffers()
    })
}

function OpenProfileExternalPaymentModal(item, quantity)
{
    if (typeof Game.ShowStoreExternalPaymentModal === "function")
    {
        Game.ShowStoreExternalPaymentModal(item, quantity || 1)
        return
    }

    if (typeof Game.SwitchAnothersPanel === "function")
    {
        Game.SwitchAnothersPanel("StoreWindow")
    }

    let tries = 0
    function tryOpenPayment()
    {
        tries++
        if (typeof Game.ShowStoreExternalPaymentModal === "function")
        {
            Game.ShowStoreExternalPaymentModal(item, quantity || 1)
            return
        }
        if (tries < 12)
        {
            $.Schedule(0.05, tryOpenPayment)
        }
    }
    $.Schedule(0.03, tryOpenPayment)
}

function CreateVipOfferArrow(parent, text, disabled, callback)
{
    let arrow = $.CreatePanel("Panel", parent, "")
    arrow.AddClass("VipOffersArrow")
    arrow.SetHasClass("VipOffersArrowDisabled", !!disabled)
    arrow.hittest = !disabled
    arrow.SetPanelEvent("onactivate", function()
    {
        if (disabled) return
        callback()
    })

    let label = $.CreatePanel("Label", arrow, "")
    label.text = text
    return arrow
}

function RenderVipProgress()
{
    if (!VipLevelLabel || !VipProgressText || !VipProgressHint || !VipProgressBarFill)
    {
        return
    }

    let current_exp = Math.max(0, Number(vip_progress_data.current_exp) || 0)
    let next_level_exp = Math.max(1, Number(vip_progress_data.next_level_exp) || 1)
    let level = Math.max(0, Number(vip_progress_data.level) || 0)
    let current_level_exp = Number((vip_progress_data.level_exp_table || {})[level] && (vip_progress_data.level_exp_table || {})[level].exp) || 0
    let level_exp = Math.max(0, current_exp - current_level_exp)
    let level_need = Math.max(1, next_level_exp - current_level_exp)
    let progress = Math.min(1, level_exp / level_need)
    let remaining = Math.max(0, level_need - level_exp)
    VipLevelLabel.SetDialogVariable("value", String(level))
    VipLevelLabel.text = $.Localize("#services_profile_level_value", VipLevelLabel)
    VipProgressText.text = level_exp + " / " + level_need
    VipProgressHint.SetDialogVariable("value", String(remaining))
    VipProgressHint.text = $.Localize("#services_profile_vip_next_hint", VipProgressHint)
    VipProgressBarFill.style.width = (progress * 100) + "%"

    if (VipShopButton && vip_progress_data.shop_button_text)
    {
        let label = VipShopButton.GetChild(0)
        if (label)
        {
            label.text = vip_progress_data.shop_button_text
        }
    }
}

function CreateAtlasItemPanel(parent_panel, atlas_item_name, atlas_data)
{
    let AtlasItemPanel = $.CreatePanel("Panel", parent_panel, "atlas_item_"+atlas_item_name)
    AtlasItemPanel.AddClass("AtlasItemPanel")
    AtlasItemPanel.SetHasClass("AtlasItemPanelOwned", !!(atlas_data && atlas_data.owned))
    AtlasItemPanel.atlas_item_name = atlas_item_name

    let AtlasItemPanelBorderBG = $.CreatePanel("Panel", AtlasItemPanel, "")
    AtlasItemPanelBorderBG.AddClass("AtlasItemPanelBorderBG")

    let AtlasItemPanelBorder = $.CreatePanel("Panel", AtlasItemPanel, "")
    AtlasItemPanelBorder.AddClass("AtlasItemPanelBorder")

    let AtlasItemPanelBorderBottom = $.CreatePanel("Panel", AtlasItemPanel, "")
    AtlasItemPanelBorderBottom.AddClass("AtlasItemPanelBorderBottom")

    let AtlasItemPanelIcon = $.CreatePanel("Panel", AtlasItemPanel, "")
    AtlasItemPanelIcon.AddClass("AtlasItemPanelIcon")

    let AtlasItemPanelIconImage = $.CreatePanel("Panel", AtlasItemPanel, "")
    AtlasItemPanelIconImage.AddClass("AtlasItemPanelIconImage")
    SetPanelImage(AtlasItemPanelIconImage, atlas_data && atlas_data.icon)

    let AtlasItemPanelName = $.CreatePanel("Label", AtlasItemPanel, "")
    AtlasItemPanelName.AddClass("AtlasItemPanelName")
    AtlasItemPanelName.text = $.Localize("#"+atlas_item_name)

    if (atlas_data && atlas_data.rarity && atlas_data.rarity != "common")
    {
        AtlasItemPanelBorder.AddClass("RareColor_" + atlas_data.rarity)
        AtlasItemPanelIcon.AddClass("RareColor_" + atlas_data.rarity)
        AtlasItemPanelBorderBottom.AddClass("RareColor_" + atlas_data.rarity)
        if (atlas_data.rarity == "super")
        {
            AtlasItemPanel.AddClass("RareColor_" + atlas_data.rarity)
        }
    }

    return AtlasItemPanel
}

function RequestInfoAtlasItem(atlas_item_name, atlas_data, keep_selection)
{
    if (!keep_selection)
    {
        selected_atlas_id = atlas_item_name
    }
    for (let child of AtlasList.FindChildrenWithClassTraverse("AtlasItemPanel"))
    {
        child.SetHasClass("AtlasItemActive", child.atlas_item_name == atlas_item_name)
    }

    AtlasItemInfo.RemoveAndDeleteChildren()

    CreateAtlasItemPanel(AtlasItemInfo, atlas_item_name, atlas_data)

    let AtlasItemBlockInformation = $.CreatePanel("Panel", AtlasItemInfo, "")
    AtlasItemBlockInformation.AddClass("AtlasItemBlockInformation")

    let AtlasItemBlockInformationHeader = $.CreatePanel("Panel", AtlasItemBlockInformation, "")
    AtlasItemBlockInformationHeader.AddClass("AtlasItemBlockInformationHeader")
    
    let AtlasItemBlockInformationHeaderLabel = $.CreatePanel("Label", AtlasItemBlockInformationHeader, "")
    AtlasItemBlockInformationHeaderLabel.AddClass("AtlasItemBlockInformationHeaderLabel")
    AtlasItemBlockInformationHeaderLabel.text = $.Localize("#services_atlas_extra_effects")

    let AtlasItemBlockInformationBody = $.CreatePanel("Panel", AtlasItemBlockInformation, "")
    AtlasItemBlockInformationBody.AddClass("AtlasItemBlockInformationBody")

    if (atlas_data.buffs)
    {
        for (let atlas_buff of Object.values(atlas_data.buffs))
        {
            let atlas_buff_panel = $.CreatePanel("Panel", AtlasItemBlockInformationBody, "")
            atlas_buff_panel.AddClass("atlas_buff_panel")
            atlas_buff_panel.SetHasClass("AtlasBuffOwned", !!atlas_data.owned)

            let atlas_buff_panel_BG = $.CreatePanel("Panel", atlas_buff_panel, "")
            atlas_buff_panel_BG.AddClass("atlas_buff_panel_BG")
            atlas_buff_panel_BG.SetHasClass("AtlasBuffOwned", !!atlas_data.owned)

            let atlas_buff_panel_BG_border = $.CreatePanel("Panel", atlas_buff_panel, "")
            atlas_buff_panel_BG_border.AddClass("atlas_buff_panel_BG_border")
            atlas_buff_panel_BG_border.SetHasClass("AtlasBuffOwned", !!atlas_data.owned)

            let atlas_buff_panel_label = $.CreatePanel("Label", atlas_buff_panel, "")
            atlas_buff_panel_label.AddClass("atlas_buff_panel_label")
            atlas_buff_panel_label.SetHasClass("AtlasBuffOwned", !!atlas_data.owned)
            atlas_buff_panel_label.text = atlas_buff.altas_buff_title
        }
    }

    RenderAtlasPurchaseBlock(AtlasItemInfo, atlas_item_name, atlas_data)
}

function InitMail()
{
    mail_messages = []
    selected_mail_id = null

    if (MailClaimButton)
    {
        MailClaimButton.SetPanelEvent("onactivate", function()
        {
            ClaimSelectedMailRewards()
            Game.EmitSound("General.ButtonClick")
        })
    }

    if (MailClaimAllButton)
    {
        MailClaimAllButton.SetPanelEvent("onactivate", function()
        {
            ClaimAllMailRewards()
            Game.EmitSound("General.ButtonClick")
        })
    }

    for (let mail_data of demo_mail_messages)
    {
        CreateIncomingMessage(mail_data)
    }
}

function NormalizeMailMessage(mail_data)
{
    let rewards = Array.isArray(mail_data.rewards) ? mail_data.rewards.slice(0) : []
    let has_rewards = rewards.length > 0
    let normalized_mail =
    {
        id: String(mail_data.id || ("mail_" + mail_messages.length)),
        sender: String(mail_data.sender || $.Localize("#services_mail_unknown_sender")),
        subject: String(mail_data.subject || $.Localize("#services_mail_no_subject")),
        body: String(mail_data.body || ""),
        created_at: String(mail_data.created_at || ""),
        is_new: !!mail_data.is_new,
        is_read: !!mail_data.is_read,
        rewards_claimed: has_rewards ? !!mail_data.rewards_claimed : true,
        rewards: rewards,
    }

    if (normalized_mail.is_read)
    {
        normalized_mail.is_new = false
    }

    return normalized_mail
}

function CreateIncomingMessage(mail_data)
{
    let normalized_mail = NormalizeMailMessage(mail_data || {})
    let existing_index = mail_messages.findIndex(function(entry)
    {
        return entry.id === normalized_mail.id
    })

    if (existing_index >= 0)
    {
        mail_messages[existing_index] = normalized_mail
    }
    else
    {
        mail_messages.push(normalized_mail)
    }

    SortMailMessages()
    RenderMailInbox()

    if (!selected_mail_id)
    {
        SelectMailMessage(normalized_mail.id)
    }
    else
    {
        RefreshMailDetail()
    }

    return normalized_mail.id
}

function SortMailMessages()
{
    mail_messages.sort(function(left, right)
    {
        let left_priority = GetMailPriority(left)
        let right_priority = GetMailPriority(right)

        if (left_priority !== right_priority)
        {
            return right_priority - left_priority
        }

        return left.id < right.id ? 1 : -1
    })
}

function GetMailPriority(mail_data)
{
    if (mail_data.is_new)
    {
        return 3
    }

    if (MailHasUnclaimedRewards(mail_data))
    {
        return 2
    }

    if (!mail_data.is_read)
    {
        return 1
    }

    return 0
}

function MailHasRewards(mail_data)
{
    return !!(mail_data && mail_data.rewards && mail_data.rewards.length > 0)
}

function MailHasUnclaimedRewards(mail_data)
{
    return MailHasRewards(mail_data) && !mail_data.rewards_claimed
}

function RenderMailInbox()
{
    if (!MailInboxList)
    {
        return
    }

    MailInboxList.RemoveAndDeleteChildren()

    for (let mail_data of mail_messages)
    {
        let MailInboxItem = $.CreatePanel("Panel", MailInboxList, "mail_inbox_" + mail_data.id)
        MailInboxItem.AddClass("MailInboxItem")
        MailInboxItem.SetHasClass("MailInboxItemSelected", mail_data.id === selected_mail_id)
        MailInboxItem.SetHasClass("MailInboxItemNew", mail_data.is_new)
        MailInboxItem.SetPanelEvent("onactivate", function()
        {
            SelectMailMessage(mail_data.id)
        })

        let MailInboxHeader = $.CreatePanel("Panel", MailInboxItem, "")
        MailInboxHeader.AddClass("MailInboxHeader")

        let MailInboxSubject = $.CreatePanel("Label", MailInboxHeader, "")
        MailInboxSubject.AddClass("MailInboxSubject")
        MailInboxSubject.text = mail_data.subject

        let badge_text = GetMailBadgeText(mail_data)
        if (badge_text)
        {
            let MailInboxBadge = $.CreatePanel("Panel", MailInboxHeader, "")
            MailInboxBadge.AddClass("MailInboxBadge")

            let MailInboxBadgeLabel = $.CreatePanel("Label", MailInboxBadge, "")
            MailInboxBadgeLabel.text = badge_text
        }

        let MailInboxSender = $.CreatePanel("Label", MailInboxItem, "")
        MailInboxSender.AddClass("MailInboxSender")
        MailInboxSender.text = mail_data.sender

        let MailInboxPreview = $.CreatePanel("Label", MailInboxItem, "")
        MailInboxPreview.AddClass("MailInboxPreview")
        MailInboxPreview.text = GetMailPreviewText(mail_data.body)

        let MailInboxMeta = $.CreatePanel("Label", MailInboxItem, "")
        MailInboxMeta.AddClass("MailInboxMeta")
        MailInboxMeta.text = GetMailMetaText(mail_data)
    }

    UpdateMailActionButtons()
}

function GetMailPreviewText(body_text)
{
    let preview_text = String(body_text || "").replace(/\n+/g, " ")
    if (preview_text.length > 70)
    {
        preview_text = preview_text.slice(0, 67) + "..."
    }

    return preview_text
}

function GetMailBadgeText(mail_data)
{
    if (mail_data.is_new)
    {
        return $.Localize("#services_mail_badge_new")
    }

    if (MailHasUnclaimedRewards(mail_data))
    {
        return $.Localize("#services_mail_badge_reward")
    }

    if (mail_data.is_read)
    {
        return $.Localize("#services_mail_badge_read")
    }

    return ""
}

function GetMailMetaText(mail_data)
{
    let status_parts = []

    if (mail_data.created_at)
    {
        status_parts.push(mail_data.created_at)
    }

    if (MailHasUnclaimedRewards(mail_data))
    {
        status_parts.push($.Localize("#services_mail_status_not_claimed"))
    }
    else if (MailHasRewards(mail_data) && mail_data.rewards_claimed)
    {
        status_parts.push($.Localize("#services_mail_status_claimed"))
    }

    return status_parts.join(" ? ")
}

function SelectMailMessage(mail_id)
{
    selected_mail_id = mail_id

    let mail_data = GetSelectedMailMessage()
    if (mail_data && !mail_data.is_read)
    {
        mail_data.is_read = true
        mail_data.is_new = false
        Game.service_read_mail_local = Game.service_read_mail_local || {}
        Game.service_read_mail_local[mail_data.id] = true
        GameEvents.SendCustomGameEventToServer("event_services_read_mail", { mail_id: mail_data.id })
    }

    SortMailMessages()
    RenderMailInbox()
    RefreshMailDetail()
    UpdateProfileClaimNotifications()
}

function GetSelectedMailMessage()
{
    return mail_messages.find(function(entry)
    {
        return entry.id === selected_mail_id
    }) || null
}

function RefreshMailDetail()
{
    let mail_data = GetSelectedMailMessage()

    if (!mail_data)
    {
        MailSenderValue.text = "-"
        MailSubjectValue.text = "-"
        MailBodyText.text = $.Localize("#services_mail_select_message")
        MailRewardsList.RemoveAndDeleteChildren()
        MailRewardsSection.style.visibility = "collapse"
        MailStatusText.text = ""
        UpdateMailActionButtons()
        return
    }

    MailSenderValue.text = mail_data.sender
    MailSubjectValue.text = mail_data.subject
    MailBodyText.text = mail_data.body

    RenderMailRewards(mail_data)
    MailStatusText.text = GetMailDetailStatus(mail_data)
    UpdateMailActionButtons()
}

function RenderMailRewards(mail_data)
{
    MailRewardsList.RemoveAndDeleteChildren()

    let has_rewards = MailHasRewards(mail_data)
    MailRewardsSection.style.visibility = has_rewards ? "visible" : "collapse"

    if (!has_rewards)
    {
        return
    }

    for (let reward_data of mail_data.rewards)
    {
        let MailRewardItem = $.CreatePanel("Panel", MailRewardsList, "")
        MailRewardItem.AddClass("MailRewardItem")
        MailRewardItem.SetHasClass("ServiceRewardClaimed", !!mail_data.rewards_claimed)
        SetServiceItemTooltip(MailRewardItem, reward_data.item_id, reward_data.reward_count)

        let MailRewardItemBG1 = $.CreatePanel("Panel", MailRewardItem, "")
        MailRewardItemBG1.AddClass("MailRewardItemBG1")

        let MailRewardItemBG2 = $.CreatePanel("Panel", MailRewardItem, "")
        MailRewardItemBG2.AddClass("MailRewardItemBG2")

        if (reward_data.rarity && reward_data.rarity != "common")
        {
            MailRewardItemBG2.AddClass("RareColor_" + reward_data.rarity)
        }

        let MailRewardIcon = $.CreatePanel("Panel", MailRewardItem, "")
        MailRewardIcon.AddClass("MailRewardIcon")
        ApplyRewardIcon(MailRewardIcon, reward_data.icon)

        let MailRewardCount = $.CreatePanel("Label", MailRewardItem, "")
        MailRewardCount.AddClass("MailRewardCount")
        MailRewardCount.text = String(reward_data.reward_count || 1)

        if (mail_data.rewards_claimed)
        {
            let check = $.CreatePanel("Label", MailRewardItem, "")
            check.AddClass("ServiceRewardClaimCheck")
            check.text = "✓"
        }
    }
}

function ApplyRewardIcon(panel, icon_path)
{
    let fallback_icon = "file://{images}/game_hud/icons/refresh.png"
    panel.style.backgroundImage = "url('" + (icon_path || fallback_icon) + "')"
    panel.style.backgroundSize = "100%"
}

function GetMailDetailStatus(mail_data)
{
    if (MailHasUnclaimedRewards(mail_data))
    {
        return $.Localize("#services_mail_detail_rewards_available")
    }

    if (MailHasRewards(mail_data) && mail_data.rewards_claimed)
    {
        return $.Localize("#services_mail_detail_rewards_claimed")
    }

    if (mail_data.is_read)
    {
        return $.Localize("#services_mail_detail_read")
    }

    return $.Localize("#services_mail_detail_new")
}

function ClaimSelectedMailRewards()
{
    let mail_data = GetSelectedMailMessage()
    if (!MailHasUnclaimedRewards(mail_data))
    {
        return
    }

    mail_data.rewards_claimed = true
    mail_data.is_read = true
    mail_data.is_new = false
    Game.service_read_mail_local = Game.service_read_mail_local || {}
    Game.service_read_mail_local[mail_data.id] = true
    GameEvents.SendCustomGameEventToServer("event_services_claim_mail", { mail_id: mail_data.id })

    SortMailMessages()
    RenderMailInbox()
    RefreshMailDetail()
    UpdateProfileClaimNotifications()
}

function ClaimAllMailRewards()
{
    let has_changes = false

    for (let mail_data of mail_messages)
    {
        if (!MailHasUnclaimedRewards(mail_data))
        {
            continue
        }

        has_changes = true
    }

    if (!has_changes)
    {
        return
    }

    GameEvents.SendCustomGameEventToServer("event_services_claim_all_mail", {})

    for (let mail_data of mail_messages)
    {
        if (!MailHasUnclaimedRewards(mail_data))
        {
            continue
        }

        mail_data.rewards_claimed = true
        mail_data.is_read = true
        mail_data.is_new = false
        Game.service_read_mail_local = Game.service_read_mail_local || {}
        Game.service_read_mail_local[mail_data.id] = true
    }

    SortMailMessages()
    RenderMailInbox()
    RefreshMailDetail()
    UpdateProfileClaimNotifications()
}

function UpdateMailActionButtons()
{
    let selected_mail = GetSelectedMailMessage()
    let can_claim_selected = MailHasUnclaimedRewards(selected_mail)
    let can_claim_all = mail_messages.some(function(mail_data)
    {
        return MailHasUnclaimedRewards(mail_data)
    })

    MailClaimButton.SetHasClass("MailActionButtonDisabled", !can_claim_selected)
    MailClaimAllButton.SetHasClass("MailActionButtonDisabled", !can_claim_all)
}

GameUI.CustomUIConfig().CreateIncomingMessage = CreateIncomingMessage
GameUI.CustomUIConfig().SetBlessingPrivileges = SetBlessingPrivileges
















function NavigateSwitch(button, window)
{
    for (let child of ContentWindows.Children())
    {
        child.SetHasClass("ContentWindowVisible", child.id == window)
    }
    for (let child of NavigationPanel.Children())
    {
        child.SetHasClass("Active", child.id == button)
    }
    UpdateProfileSubNavigation()
}

function SelectProfileSubCategory(type, category)
{
    if (type === "achievement")
    {
        current_achievement_category = category
        selected_achievement_id = null
        UpdateProfileSubNavigation()
        InitAchivements()
        RefreshSelectedAchievementInfo()
        return
    }

    if (type === "atlas")
    {
        current_atlas_category = category
        UpdateProfileSubNavigation()
        InitAtlas()
    }
}

function UpdateProfileSubNavigation()
{
    let achievement_sub = $("#AchievementSubNavigation")
    if (achievement_sub)
    {
        achievement_sub.SetHasClass("ProfileSubNavigationVisible", $("#AchivementtPanel") && $("#AchivementtPanel").BHasClass("ContentWindowVisible"))
    }

    let atlas_sub = $("#AtlasSubNavigation")
    if (atlas_sub)
    {
        atlas_sub.SetHasClass("ProfileSubNavigationVisible", $("#AtlasPanel") && $("#AtlasPanel").BHasClass("ContentWindowVisible"))
    }

    let achievement_categories = ["achievement_1", "achievement_2", "achievement_3", "achievement_4", "achievement_5", "achievement_6"]
    for (let i = 0; i < achievement_categories.length; i++)
    {
        let button = $("#AchievementSubButton_" + achievement_categories[i])
        if (button) button.SetHasClass("Active", achievement_categories[i] === current_achievement_category)
    }

    let atlas_categories = ["atlas_1", "atlas_2", "atlas_3", "atlas_4", "atlas_5", "atlas_6"]
    for (let i = 0; i < atlas_categories.length; i++)
    {
        let button = $("#AtlasSubButton_" + atlas_categories[i])
        if (button) button.SetHasClass("Active", atlas_categories[i] === current_atlas_category)
    }
}

function SetPanelImage(panel, path)
{
    if (!panel || !path) return
    panel.style.backgroundImage = "url('" + path + "')"
    panel.style.backgroundSize = "contain"
    panel.style.backgroundRepeat = "no-repeat"
    panel.style.backgroundPosition = "center"
}

Init()