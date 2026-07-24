--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var STORE_SECTION_MONTHLY = "monthly_card"
var STORE_SECTION_ITEMS = "items"
var STORE_SECTION_BLESSINGS = "blessings"
var STORE_SECTION_SETS = "sets"
var STORE_SECTION_IDLE = "idle_shop"
var STORE_SECTION_GOLD = "gold_shop"
var STORE_SECTION_BURNING = "burning_shop"
var STORE_SECTION_TOPUP = "top_up"

var store_menu_sections =
[
    { id: STORE_SECTION_MONTHLY, title: $.Localize("#services_store_section_monthly") },
    { id: STORE_SECTION_ITEMS, title: $.Localize("#services_store_section_items") },
    { id: STORE_SECTION_BLESSINGS, title: $.Localize("#services_store_section_blessings") },
    { id: STORE_SECTION_SETS, title: $.Localize("#services_store_section_sets") },
    { id: STORE_SECTION_IDLE, title: $.Localize("#services_store_section_idle") },
    { id: STORE_SECTION_GOLD, title: $.Localize("#services_store_section_gold") },
    { id: STORE_SECTION_TOPUP, title: $.Localize("#services_store_section_topup") },
]

var store_currency_data = []

var store_monthly_cards = []

var store_product_data = {}

const StoreSidebar = $("#StoreSidebar")
const StoreCurrencyRow = $("#StoreCurrencyRow")
const StoreSectionBody = $("#StoreSectionBody")

var current_store_section = STORE_SECTION_MONTHLY
var store_services_ready = false
var store_sidebar_signature = ""
var store_currency_signature = ""
var store_section_signature = ""
var store_purchase_modal_item = null
var store_purchase_quantity = 1
var store_payment_modal_item = null
var store_payment_quantity = 1
var store_payment_selected_provider = null
var store_player_data_override = null
var store_render_deferred = false
var store_payment_pending = false
var store_payment_error = ""

var STORE_PAYMENT_PROVIDERS =
[
    { id: "rollypay", title: "#services_store_payment_provider_rollypay_title", dynamic: true, icon: "file://{images}/game_hud/services/rolly.png", description: "#services_store_payment_provider_rollypay" },
    { id: "afdian", title: "Afdian", icon: "file://{images}/game_hud/services/afdian.png", description: "#services_store_payment_provider_afdian" },
    { id: "patreon", title: "Patreon", icon: "file://{images}/game_hud/services/patreon.png", description: "#services_store_payment_provider_patreon" },
    { id: "funpay", title: "Funpay", icon: "file://{images}/game_hud/services/funpay.png", description: "#services_store_payment_provider_funpay" },
    { id: "discord", title: "Discord", icon: "file://{images}/game_hud/services/discord.png", description: "#services_store_payment_provider_discord" },
]

function GetLocalPlayerKey()
{
    return String(Players.GetLocalPlayer())
}

function GetServiceItems()
{
    return Game.GetCustomTable ? Game.GetCustomTable("services_config", "items") : {}
}

function GetServiceStoreConfig()
{
    return Game.GetCustomTable ? Game.GetCustomTable("services_config", "store") : {}
}

function GetServicePlayerData()
{
    if (store_player_data_override)
    {
        return store_player_data_override
    }
    return Game.GetCustomTable ? Game.GetCustomTable("services_player", GetLocalPlayerKey()) : {}
}

function HasCompletedStoreDifficulty(difficulty_id)
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

function IsStoreExternalPaymentUnlocked()
{
    return HasCompletedStoreDifficulty("1-1")
}

function MergeStorePlayerData(base_data, patch_data)
{
    let result = {}
    base_data = base_data || {}
    patch_data = patch_data || {}

    for (let key in base_data)
    {
        result[key] = base_data[key]
    }
    for (let key in patch_data)
    {
        result[key] = patch_data[key]
    }

    for (let key of ["economy_data", "items_store_buying_history", "monthly_cards_data"])
    {
        result[key] = {}
        let base_block = base_data[key] || {}
        let patch_block = patch_data[key] || {}
        for (let id in base_block) result[key][id] = base_block[id]
        for (let id in patch_block) result[key][id] = patch_block[id]
    }

    return result
}

function OnStorePartialUpdate(data)
{
    let base_data = store_player_data_override || (Game.GetCustomTable ? Game.GetCustomTable("services_player", GetLocalPlayerKey()) : {})
    store_player_data_override = MergeStorePlayerData(base_data, data || {})
    RenderStoreFromServices()
}

function GetCurrencyIcon(currency_name)
{
    let item = GetServiceItems()[currency_name]
    return item && item.icon ? item.icon : "file://{images}/game_hud/icons/gold.png"
}

function NormalizeRewardForStore(reward)
{
    let item = GetServiceItems()[reward.id || reward.item_id] || {}
    return {
        item_id: reward.id || reward.item_id,
        icon: item.icon || "file://{images}/game_hud/icons/gold.png",
        count: Number(reward.count) || 1,
        label: LocalizeServiceItemName(item, reward.id || reward.item_id),
        rarity: item.rarity || "common",
    }
}

function AddRarityClass(panel, rarity)
{
    if (panel && rarity && rarity !== "common")
    {
        panel.AddClass("RareColor_" + rarity)
    }
}

function HasActiveStoreMonthlyCard(card_id, player_data)
{
    if (!card_id) return true
    let card = (player_data.monthly_cards_data || {})[card_id] || {}
    return !!card.active || Number(card.remaining_days) > 0 || Number(card.remaining_seconds) > 0
}

function BuildStoreRewards(raw_item)
{
    let raw_rewards = Object.values(raw_item.rewards || {})
    if (!raw_rewards.length)
    {
        raw_rewards.push({ id: raw_item.item_id, count: Number(raw_item.count) || 1 })
    }
    return raw_rewards.map(NormalizeRewardForStore)
}

function ScaleStoreRewards(rewards, quantity)
{
    return (rewards || []).map(function(reward)
    {
        let scaled = {}
        for (let key in reward)
        {
            scaled[key] = reward[key]
        }
        scaled.count = (Number(reward.count) || 1) * quantity
        return scaled
    })
}

function FormatStoreWebPriceForQuantity(price_data, quantity)
{
    quantity = Math.max(1, Number(quantity) || 1)
    if (!price_data || typeof price_data !== "object")
    {
        return FormatWebPrice(price_data)
    }

    let real = price_data.real !== undefined ? price_data.real : price_data
    if (!real || typeof real !== "object")
    {
        return FormatWebPrice(price_data)
    }

    let scaled = {}
    for (let key in real)
    {
        let value = Number(real[key])
        scaled[key] = isNaN(value) ? real[key] : String(Math.round(value * quantity))
    }
    return FormatWebPrice({ real: scaled })
}

function GetStoreExternalPlayerAccountId()
{
    let player_data = GetServicePlayerData() || {}
    return String(player_data.steam_id || player_data.account_id || player_data.invite_code || "")
}

function ResolveStoreExternalPaymentUrl(item, provider_id, quantity)
{
    item = item || {}
    let links = item.payment_links || item.paymentLinks || {}
    provider_id = String(provider_id || "")

    let url = ""
    if (typeof links === "string")
    {
        url = links
    }
    else if (links && typeof links === "object")
    {
        url = links[provider_id] || links[provider_id.toLowerCase()] || links.default || ""
        url = SelectLocalizedServiceValue(url, url)
    }

    quantity = Math.max(1, Number(quantity) || 1)
    let product_id = String(item.store_product_id || item.id || item.item_id || "")
    let steam_id = GetStoreExternalPlayerAccountId()
    return String(url)
        .replace(/\{product\}/g, encodeURIComponent(product_id))
        .replace(/\{item_id\}/g, encodeURIComponent(String(item.item_id || product_id)))
        .replace(/\{count\}/g, encodeURIComponent(String(quantity)))
        .replace(/\{steam_id\}/g, encodeURIComponent(steam_id))
        .replace(/\{provider\}/g, encodeURIComponent(provider_id))
}

function RefreshStoreDataFromServices()
{
    let store_config = GetServiceStoreConfig()
    let player_data = GetServicePlayerData()
    let service_items = GetServiceItems()
    if (!store_config || !store_config.categories)
    {
        return false
    }

    let currencies = player_data.economy_data || {}
    store_currency_data = []
    for (let currency_id of ["coin", "stone", "moon", "sand_time", "magic_crystal"])
    {
        let item = service_items[currency_id] || {}
        store_currency_data.push({
            id: currency_id,
            icon: item.icon || GetCurrencyIcon(currency_id),
            amount: String(currencies[currency_id] || 0),
        })
    }

    store_monthly_cards = []
    let monthly_order = ["monthly_basic", "monthly_idle", "monthly_premium"]
    for (let card_id of monthly_order)
    {
        let card = store_config.monthly_cards[card_id]
        if (!card) continue
        let subscription = (player_data.monthly_cards_data || {})[card.id || card_id] || {}
        let remaining_days = Number(subscription.remaining_days) || 0
        let remaining_seconds = Number(subscription.remaining_seconds) || 0
        let active = !!subscription.active || remaining_days > 0 || remaining_seconds > 0
        let perks = []
        for (let perk_name in (card.perks || {}))
        {
            perks.push({
                name: perk_name,
                value: card.perks[perk_name],
            })
        }
        store_monthly_cards.push({
            id: card.id || card_id,
            item_id: card.id || card_id,
            icon: card.icon || "file://{images}/game_hud/services/stone.png",
            title: LocalizeServiceKeyOrText(card.name || card.id || card_id, card_id),
            name: LocalizeServiceKeyOrText(card.name || card.id || card_id, card_id),
            subtitle: LocalizeServiceKeyOrText((card.description || (card.id || card_id) + "_description"), ""),
            theme: card_id.indexOf("premium") >= 0 ? "premium" : (card_id.indexOf("idle") >= 0 ? "slacking" : "basic"),
            price: card.site_only ? FormatWebPrice(card.price) : "0",
            site_only: !!card.site_only,
            real_price: card.site_only ? card.price : null,
            payment_links: card.payment_links || {},
            active: active,
            remaining_days: remaining_days,
            perks: perks,
            instant_rewards: Object.values(card.instant_rewards || {}).map(NormalizeRewardForStore),
            daily_rewards: Object.values(card.daily_rewards || {}).map(NormalizeRewardForStore),
        })
    }

    store_product_data = {}
    let history = player_data.items_store_buying_history || {}
    for (let section_id in store_config.categories)
    {
        store_product_data[section_id] = []
        for (let raw_item of Object.values(store_config.categories[section_id] || {}))
        {
            let item = service_items[raw_item.item_id] || {}
            let item_history = history[raw_item.id] || {}
            let purchases = Number(item_history.purchases) || 0
            let limit = Number(raw_item.limit) || 0
            if (section_id === STORE_SECTION_TOPUP)
            {
                let topup_count = String(raw_item.count || 0)
                store_product_data[section_id].push(BuildTopUpCard(raw_item.id, LocalizeServiceItemName(item, raw_item.item_id), raw_item.site_only ? FormatWebPrice(raw_item.price) : "0", topup_count, item.icon || GetCurrencyIcon(raw_item.item_id), topup_count, raw_item))
            }
            else
            {
                let rewards = BuildStoreRewards(raw_item)
                let normalized = BuildStoreItem(raw_item.id, raw_item.item_id, LocalizeServiceItemName(item, raw_item.item_id), item.icon || GetCurrencyIcon(raw_item.price && raw_item.price.currency), raw_item.site_only ? FormatWebPrice(raw_item.price) : raw_item.price && raw_item.price.amount || 0, limit > 0 && purchases >= limit, purchases, limit)
                normalized.count = Number(raw_item.count) || 1
                normalized.price_amount = Number(raw_item.price && raw_item.price.amount) || 0
                normalized.price_currency = raw_item.price && raw_item.price.currency || ""
                normalized.currency_icon = raw_item.site_only ? "" : GetCurrencyIcon(raw_item.price && raw_item.price.currency)
                normalized.site_only = !!raw_item.site_only
                normalized.real_price = raw_item.site_only ? raw_item.price : null
                normalized.payment_links = raw_item.payment_links || {}
                normalized.rewards = rewards
                normalized.locked = !HasActiveStoreMonthlyCard(raw_item.required_monthly_card, player_data)
                normalized.required_monthly_card = raw_item.required_monthly_card || ""
                normalized.limit_period = raw_item.limit_period || ""
                store_product_data[section_id].push(normalized)
            }
        }
    }

    store_services_ready = true
    return true
}

function RenderStoreFromServices(table_name, key, data)
{
    if (table_name === "services_player" && String(key) === GetLocalPlayerKey() && data)
    {
        store_player_data_override = data
    }

    if (typeof IsContextWindowVisible === "function" && !IsContextWindowVisible("StoreWindow"))
    {
        store_render_deferred = true
        if (RefreshStoreDataFromServices())
        {
            RenderStoreCurrencies()
        }
        return
    }

    if (!RefreshStoreDataFromServices())
    {
        return
    }

    let sidebar_signature = BuildStoreSidebarSignature()
    if (sidebar_signature !== store_sidebar_signature)
    {
        RenderStoreSidebar()
    }
    else
    {
        UpdateStoreSidebarActive()
    }

    let currency_signature = BuildStoreCurrencySignature()
    if (currency_signature !== store_currency_signature)
    {
        RenderStoreCurrencies()
    }

    let section_signature = BuildStoreSectionSignature(current_store_section)
    if (section_signature !== store_section_signature)
    {
        RenderStoreSection()
    }
}

function RenderStoreIfDeferred()
{
    if (!store_render_deferred)
    {
        return
    }
    store_render_deferred = false
    RenderStoreFromServices()
}

if (typeof Game !== 'undefined') Game.RenderStoreIfDeferred = RenderStoreIfDeferred

function BuildStoreItem(id, item_id, name, icon, cost, purchased, purchases, limit)
{
    return {
        id: id,
        item_id: item_id,
        name: name,
        icon: icon,
        cost: cost,
        purchased: !!purchased,
        purchases: Number(purchases) || 0,
        limit: Number(limit) || 0,
        currency_icon: "file://{images}/game_hud/icons/gold.png",
        rewards: [],
        locked: false,
    }
}

function BuildTopUpCard(id, title, price, crystals, icon, badge, raw_item)
{
    raw_item = raw_item || {}
    return {
        id: id,
        item_id: raw_item.item_id || "",
        name: title,
        title: title,
        price: price,
        cost: price,
        crystals: crystals,
        count: Number(raw_item.count) || Number(crystals) || 1,
        icon: icon,
        badge: badge,
        site_only: !!raw_item.site_only,
        real_price: raw_item.site_only ? raw_item.price : null,
        payment_links: raw_item.payment_links || {},
    }
}

function InitStore()
{
    RefreshStoreDataFromServices()
    RenderStoreSidebar()
    RenderStoreCurrencies()
    NavigateStoreSection(current_store_section)
    $("#StoreContent").SetHasClass("IsSubWindow", current_store_section === STORE_SECTION_MONTHLY)

    if (Game.SubscribeCustomTableListener)
    {
        Game.SubscribeCustomTableListener("services_config", "store", RenderStoreFromServices)
        Game.SubscribeCustomTableListener("services_config", "items", RenderStoreFromServices)
        Game.SubscribeCustomTableListener("services_player", GetLocalPlayerKey(), RenderStoreFromServices)
        Game.SubscribeCustomTableListener("player_difficult_complete", GetLocalPlayerKey(), RenderStoreFromServices)
    }
    GameEvents.Subscribe("event_services_store_update", OnStorePartialUpdate)
    GameEvents.Subscribe("event_services_inventory_update", OnStorePartialUpdate)
    GameEvents.Subscribe("event_services_payment_link", OnStorePaymentLink)
    GameEvents.Subscribe("event_services_payment_link_error", OnStorePaymentLinkError)
}

function RenderStoreSidebar()
{
    StoreSidebar.RemoveAndDeleteChildren()
    store_sidebar_signature = BuildStoreSidebarSignature()

    for (let section of store_menu_sections)
    {
        let button = $.CreatePanel("Panel", StoreSidebar, "store_nav_" + section.id)
        button.AddClass("StoreNavButton")
        button.SetHasClass("StoreNavButtonActive", section.id === current_store_section)
        button.SetPanelEvent("onactivate", function()
        {
            NavigateStoreSection(section.id)
            $("#StoreContent").SetHasClass("IsSubWindow", section.id === STORE_SECTION_MONTHLY)
        })

        let label = $.CreatePanel("Label", button, "")
        label.text = section.title
    }
    UpdateStoreSidebarDots()
}

function UpdateStoreSidebarActive()
{
    for (let section of store_menu_sections)
    {
        let button = $("#store_nav_" + section.id)
        if (button)
        {
            button.SetHasClass("StoreNavButtonActive", section.id === current_store_section)
        }
    }
    UpdateStoreSidebarDots()
}

function UpdateStoreSidebarDots()
{
    if (!Game || !Game.SetServiceNotifyDot) return
    let gold_btn = $("#store_nav_" + STORE_SECTION_GOLD)
    if (!gold_btn) return
    let items = store_product_data[STORE_SECTION_GOLD] || []
    let has_daily = items.some(function(item)
    {
        return item.limit_period === "daily" && !item.locked && item.limit > 0 && item.purchases < item.limit
    })
    Game.SetServiceNotifyDot(gold_btn, has_daily)
}

function RenderStoreCurrencies()
{
    StoreCurrencyRow.RemoveAndDeleteChildren()
    if (typeof RenderServiceServerSyncButton === "function")
    {
        RenderServiceServerSyncButton(StoreCurrencyRow)
    }
    store_currency_signature = BuildStoreCurrencySignature()

    for (let currency of store_currency_data)
    {
        let panel = $.CreatePanel("Panel", StoreCurrencyRow, "")
        panel.AddClass("StoreCurrencyPanel")

        let icon = $.CreatePanel("Panel", panel, "")
        icon.AddClass("StoreCurrencyIcon")
        ApplyBackgroundImage(icon, currency.icon)

        let label = $.CreatePanel("Label", panel, "")
        label.AddClass("StoreCurrencyAmount")
        label.text = currency.amount

        if (typeof SetServiceItemTooltip === "function")
        {
            SetServiceItemTooltip(panel, currency.id, currency.amount)
        }
    }
    if (typeof RenderServiceCurrencyMoreButton === "function")
    {
        RenderServiceCurrencyMoreButton(StoreCurrencyRow, (GetServicePlayerData().economy_data || {}))
    }
}

function NavigateStoreSection(section_id)
{
    current_store_section = section_id
    UpdateStoreSidebarActive()
    RenderStoreSection()
}

if (typeof Game !== 'undefined') Game.NavigateStoreSection = NavigateStoreSection

function RenderStoreSection()
{
    let section_data = store_menu_sections.find(function(section)
    {
        return section.id === current_store_section
    })

    StoreSectionBody.RemoveAndDeleteChildren()
    store_section_signature = BuildStoreSectionSignature(current_store_section)

    if (current_store_section === STORE_SECTION_MONTHLY)
    {
        RenderMonthlyCardsSection()
        return
    }

    if (current_store_section === STORE_SECTION_TOPUP)
    {
        RenderTopUpSection()
        return
    }

    RenderProductGridSection(store_product_data[current_store_section] || [])
}

function BuildStoreSidebarSignature()
{
    return store_menu_sections.map(function(section)
    {
        return [section.id, section.title].join(":")
    }).join("|")
}

function BuildStoreCurrencySignature()
{
    return store_currency_data.map(function(currency)
    {
        return [currency.icon, currency.amount].join(":")
    }).join("|")
}

function BuildStoreRewardSignature(rewards)
{
    return (rewards || []).map(function(reward)
    {
        return [reward.icon, reward.count, reward.label, reward.rarity].join(":")
    }).join(",")
}

function BuildStoreSectionSignature(section_id)
{
    let payment_unlocked = IsStoreExternalPaymentUnlocked() ? "1" : "0"
    if (section_id === STORE_SECTION_MONTHLY)
    {
        return section_id + "|" + payment_unlocked + "|" + store_monthly_cards.map(function(card)
        {
            return [
                card.id,
                card.title,
                card.subtitle,
                card.theme,
                card.price,
                card.active,
                card.remaining_days,
                card.perks.map(function(perk) { return perk.name + "=" + perk.value }).join(","),
                BuildStoreRewardSignature(card.instant_rewards),
                BuildStoreRewardSignature(card.daily_rewards),
            ].join(":")
        }).join("|")
    }

    let products = store_product_data[section_id] || []
    return section_id + "|" + payment_unlocked + "|" + products.map(function(item)
    {
        return [
            item.id,
            item.name || item.title,
            item.icon,
            item.cost || item.price,
            item.crystals || "",
            item.purchased,
            item.purchases,
            item.limit,
            item.currency_icon || "",
            item.site_only,
            item.locked,
            item.required_monthly_card || "",
            item.limit_period || "",
            BuildStoreRewardSignature(item.rewards),
        ].join(":")
    }).join("|")
}

function RenderMonthlyCardsSection()
{
    let container = $.CreatePanel("Panel", StoreSectionBody, "")
    container.AddClass("StoreMonthlyCardsWrap")

    for (let card_data of store_monthly_cards)
    {
        let panel = $.CreatePanel("Panel", container, "monthly_" + card_data.id)
        panel.AddClass("MonthlyCardPanel")
        panel.AddClass("MonthlyCardTheme" + GetThemeClass(card_data.theme))

        $.CreatePanel("DOTAParticleScenePanel", panel, "", 
        { 
            class: "ParticleSubFx",
            particleName: "particles/sub_card_fx/sub_card_fx.vpcf", 
            particleonly:"true", 
            startActive:"true", 
            cameraOrigin:"0 0 100", 
            lookAt:"0 0 0",  
            fov:"64", 
            squarePixels:"true",
            hittest: "false"
        });

        let smoke_fx = $.CreatePanel("DOTAParticleScenePanel", container, "", 
        { 
            class: "ParticleSubFxSmoke",
            particleName: "particles/sub_card_fx/sub_card_fx_smoke.vpcf", 
            particleonly:"true", 
            startActive:"true", 
            cameraOrigin:"0 0 200", 
            lookAt:"0 0 0",  
            fov:"64", 
            squarePixels:"true",
            hittest: "false"
        });
        smoke_fx.AddClass("ParticleSubFxSmoke" + GetThemeClass(card_data.theme))

        let panel_card_data = $.CreatePanel("Panel", panel, "")
        panel_card_data.AddClass("MonthlyCardData")

        let header = $.CreatePanel("Panel", panel_card_data, "")
        header.AddClass("MonthlyCardHeader")

        let title = $.CreatePanel("Label", header, "")
        title.AddClass("MonthlyCardTitle")
        title.text = card_data.title

        let subtitle = $.CreatePanel("Label", header, "")
        subtitle.AddClass("MonthlyCardSubtitle")
        subtitle.text = card_data.subtitle

        let body = $.CreatePanel("Panel", panel_card_data, "")
        body.AddClass("MonthlyCardBody")

        let perksTitle = $.CreatePanel("Label", body, "")
        perksTitle.AddClass("MonthlyCardBlockTitle")
        perksTitle.text = $.Localize("#services_store_perks")

        let perksList = $.CreatePanel("Panel", body, "")
        perksList.AddClass("MonthlyCardPerks")

        for (let perk of card_data.perks)
        {
            let perkLabel = $.CreatePanel("Label", perksList, "")
            perkLabel.AddClass("MonthlyCardPerk")
            perkLabel.SetDialogVariable("value", String(perk.value))
            let perkText = $.Localize("#services_monthly_perk_" + perk.name, perkLabel)
            if (perkText === "#services_monthly_perk_" + perk.name)
            {
                perkText = perk.name + " +" + perk.value
            }
            perkLabel.text = "◈ " + perkText
        }

        RenderMonthlyRewardGroup(body, $.Localize("#services_store_instant_rewards"), card_data.instant_rewards)
        RenderMonthlyRewardGroup(body, $.Localize("#services_store_daily_rewards"), card_data.daily_rewards)

        if (card_data.active)
        {
            let daysLabel = $.CreatePanel("Label", panel_card_data, "")
            daysLabel.AddClass("StoreSubscriptionDaysLabel")
            daysLabel.SetDialogVariable("value", String(card_data.remaining_days))
            daysLabel.text = $.Localize("#services_store_subscription_days_left", daysLabel)
        }
        else
        {
            let buyButton = $.CreatePanel("Panel", panel_card_data, "")
            buyButton.AddClass("StoreBuyButton")
            let external_locked = card_data.site_only && !IsStoreExternalPaymentUnlocked()
            buyButton.SetHasClass("StoreBuyButtonDisabled", external_locked)
            buyButton.SetPanelEvent("onactivate", function()
            {
                if (external_locked)
                {
                    Game.EmitSound("General.ButtonClick")
                    return
                }
                ShowStoreExternalPaymentModal(card_data, 1)
                Game.EmitSound("General.ButtonClick")
            })

            let buyLabel = $.CreatePanel("Label", buyButton, "")
            buyLabel.text = card_data.price
        }
    }
}

function RenderMonthlyRewardGroup(parent_panel, title_text, rewards)
{
    if (!rewards || !rewards.length)
    {
        return
    }

    let blockTitle = $.CreatePanel("Label", parent_panel, "")
    blockTitle.AddClass("MonthlyCardBlockTitle")
    blockTitle.text = title_text

    let rewardsRow = $.CreatePanel("Panel", parent_panel, "")
    rewardsRow.AddClass("MonthlyCardRewardRow")

    for (let reward of rewards)
    {
        let rewardPanel = $.CreatePanel("Panel", rewardsRow, "")
        rewardPanel.AddClass("MonthlyRewardPanel")
        SetServiceItemTooltip(rewardPanel, reward.item_id, reward.count)

        let rewardPanelBG1 = $.CreatePanel("Panel", rewardPanel, "")
        rewardPanelBG1.AddClass("MonthlyRewardPanelBG1")

        let rewardPanelBG2 = $.CreatePanel("Panel", rewardPanel, "")
        rewardPanelBG2.AddClass("MonthlyRewardPanelBG2")
        AddRarityClass(rewardPanelBG2, reward.rarity)

        let icon = $.CreatePanel("Panel", rewardPanel, "")
        icon.AddClass("MonthlyRewardIcon")
        ApplyBackgroundImage(icon, reward.icon)

        let count = $.CreatePanel("Label", rewardPanel, "")
        count.AddClass("MonthlyRewardCount")
        count.text = String(reward.count)
    }
}

function RenderMonthlyRewardGroupModal(parent_panel, title_text, rewards)
{
    if (!rewards || !rewards.length)
    {
        return
    }

    let rewardsRow = $.CreatePanel("Panel", parent_panel, "")
    rewardsRow.AddClass("MonthlyCardRewardRow1")

    for (let reward of rewards)
    {
        let rewardPanel = $.CreatePanel("Panel", rewardsRow, "")
        rewardPanel.AddClass("MonthlyRewardPanel")
        SetServiceItemTooltip(rewardPanel, reward.item_id, reward.count)

        let rewardPanelBG1 = $.CreatePanel("Panel", rewardPanel, "")
        rewardPanelBG1.AddClass("MonthlyRewardPanelBG1")

        let rewardPanelBG2 = $.CreatePanel("Panel", rewardPanel, "")
        rewardPanelBG2.AddClass("MonthlyRewardPanelBG2")
        AddRarityClass(rewardPanelBG2, reward.rarity)

        let icon = $.CreatePanel("Panel", rewardPanel, "")
        icon.AddClass("MonthlyRewardIcon")
        ApplyBackgroundImage(icon, reward.icon)

        let count = $.CreatePanel("Label", rewardPanel, "")
        count.AddClass("MonthlyRewardCount")
        count.text = String(reward.count)
    }
}

function RenderProductGridSection(items)
{
    let grid = $.CreatePanel("Panel", StoreSectionBody, "")
    grid.AddClass("StoreProductGrid")

    for (let item of items)
    {
        let panel = $.CreatePanel("Panel", grid, "store_item_" + item.id)
        panel.AddClass("StoreItemCard")
        let external_locked = item.site_only && !IsStoreExternalPaymentUnlocked()
        let disabled = item.purchased || item.locked || external_locked
        panel.SetHasClass("StoreItemPurchased", disabled)
        panel.SetPanelEvent("onactivate", function()
        {
            if (disabled) return
            ShowStorePurchaseModal(item)
            Game.EmitSound("General.ButtonClick")
        })
        if (typeof SetServiceItemTooltip === "function")
        {
            SetServiceItemTooltip(panel, item.item_id, item.count)
        }

        let iconWrap = $.CreatePanel("Panel", panel, "")
        iconWrap.AddClass("StoreItemImageWrap")

        let icon = $.CreatePanel("Panel", iconWrap, "")
        icon.AddClass("StoreItemImage")
        ApplyBackgroundImage(icon, item.icon)

        if (item.purchased || item.locked)
        {
            let purchasedOverlay = $.CreatePanel("Label", iconWrap, "")
            purchasedOverlay.AddClass("StoreItemPurchasedLabel")
            purchasedOverlay.text = item.locked ? $.Localize("#services_store_unavailable") : $.Localize("#services_store_purchased")
        }

        let name = $.CreatePanel("Label", panel, "")
        name.AddClass("StoreItemName")
        name.text = item.name

        if (item.limit > 0)
        {
            let limit = $.CreatePanel("Label", panel, "")
            limit.AddClass("StoreItemLimit")
            limit.text = item.purchases + " / " + item.limit
        }

        let buyButton = $.CreatePanel("Panel", panel, "")
        buyButton.AddClass("StoreItemBuyButton")
        buyButton.SetHasClass("StoreItemBuyButtonDisabled", disabled)
        buyButton.hittest = false
        buyButton.SetPanelEvent("onactivate", function()
        {
            Game.EmitSound("General.ButtonClick")
        })

        let buyButton_body = $.CreatePanel("Panel", buyButton, "")
        buyButton_body.AddClass("StoreItemBuyButtonBody")

        if (!item.site_only && item.currency_icon)
        {
            let currencyIcon = $.CreatePanel("Panel", buyButton_body, "")
            currencyIcon.AddClass("StoreItemBuyCurrency")
            ApplyBackgroundImage(currencyIcon, item.currency_icon)
        }

        let price = $.CreatePanel("Label", buyButton_body, "")
        price.AddClass("StoreItemBuyPrice")
        price.text = item.cost
    }
}

function FindStoreProductById(store_item_id)
{
    if (!store_services_ready)
    {
        RefreshStoreDataFromServices()
    }
    for (let section_id in store_product_data)
    {
        let items = store_product_data[section_id] || []
        for (let i = 0; i < items.length; i++)
        {
            if (items[i].id === store_item_id)
            {
                return items[i]
            }
        }
    }
    return null
}

function ShowStorePurchaseModalById(store_item_id)
{
    let item = FindStoreProductById(store_item_id)
    if (!item || item.purchased || item.locked)
    {
        return false
    }
    ShowStorePurchaseModal(item)
    return true
}

if (typeof Game !== 'undefined') Game.ShowStorePurchaseModalById = ShowStorePurchaseModalById
var STORE_UNLIMITED_MAX_QUANTITY = 9999

function GetStoreItemAvailableQuantity(item)
{
    if (!item) return 1
    if (item.locked) return 0
    if (!item.limit || item.limit <= 0) return STORE_UNLIMITED_MAX_QUANTITY
    return Math.max(0, item.limit - (Number(item.purchases) || 0))
}

// Шаг степпера: Shift = 100, Ctrl = 10, иначе 1.
function GetStoreStepperStep()
{
    if (GameUI && GameUI.IsShiftDown && GameUI.IsShiftDown()) return 100
    if (GameUI && GameUI.IsControlDown && GameUI.IsControlDown()) return 10
    return 1
}

function SetStorePurchaseStepperHint(panel)
{
    panel.SetPanelEvent("onmouseover", function()
    {
        $.DispatchEvent("DOTAShowTextTooltip", panel, $.Localize("#services_store_stepper_hint"))
    })
    panel.SetPanelEvent("onmouseout", function()
    {
        $.DispatchEvent("DOTAHideTextTooltip", panel)
    })
}

function ShowStorePurchaseModal(item)
{
    store_purchase_modal_item = item
    store_purchase_quantity = 1
    RenderStorePurchaseModal()
}

function CloseStorePurchaseModal()
{
    let modal = $("#StorePurchaseModal")
    if (modal) modal.DeleteAsync(0)
    store_purchase_modal_item = null
    store_purchase_quantity = 1
    Game.EmitSound("General.ButtonClick")
}

function RenderStorePurchaseModal()
{
    let old = $("#StorePurchaseModal")
    if (old) old.DeleteAsync(0)
    let item = store_purchase_modal_item
    if (!item) return

    let max_quantity = GetStoreItemAvailableQuantity(item)
    store_purchase_quantity = Math.max(1, Math.min(max_quantity, store_purchase_quantity))

    let modal = $.CreatePanel("Panel", $("#StoreContent"), "StorePurchaseModal")
    modal.AddClass("StorePurchaseModal")
    let body = $.CreatePanel("Panel", modal, "")
    body.AddClass("StorePurchaseModalBody")

    let body1 = $.CreatePanel("Panel", body, "")
    body1.AddClass("StorePurchaseModalBodyBG1")

    let body2 = $.CreatePanel("Panel", body, "")
    body2.AddClass("StorePurchaseModalBodyBG2")

    let bodycontent = $.CreatePanel("Panel", body, "")
    bodycontent.AddClass("StorePurchaseModalBodyContent")

    let icon = $.CreatePanel("Panel", bodycontent, "")
    icon.AddClass("StorePurchaseModalIcon")
    ApplyBackgroundImage(icon, item.icon)

    let title = $.CreatePanel("Label", bodycontent, "")
    title.AddClass("StorePurchaseModalTitle")
    title.text = item.name

    if (item.rewards && item.rewards.length > 1)
    {
        RenderMonthlyRewardGroupModal(bodycontent, $.Localize("#services_store_rewards"), ScaleStoreRewards(item.rewards, store_purchase_quantity))
    }
    else
    {
        RenderMonthlyRewardGroupModal(bodycontent, $.Localize("#services_store_rewards"), ScaleStoreRewards(item.rewards, store_purchase_quantity))
        // let count = $.CreatePanel("Label", body, "")
        // count.AddClass("StorePurchaseModalText")
        // count.text = "x" + String((Number(item.count) || 1) * store_purchase_quantity)
    }

    let priceRow = $.CreatePanel("Panel", bodycontent, "")
    priceRow.AddClass("StorePurchaseModalPriceRow")
    if (!item.site_only && item.currency_icon)
    {
        let currencyIcon = $.CreatePanel("Panel", priceRow, "")
        currencyIcon.AddClass("StoreItemBuyCurrency")
        ApplyBackgroundImage(currencyIcon, item.currency_icon)
    }
    let price = $.CreatePanel("Label", priceRow, "")
    price.AddClass("StorePurchaseModalPrice")
    price.text = item.site_only ? FormatStoreWebPriceForQuantity(item.real_price, store_purchase_quantity) : String((Number(item.price_amount) || Number(item.cost) || 0) * store_purchase_quantity)

    if (max_quantity > 1)
    {
        let is_unlimited = !item.limit || Number(item.limit) <= 0
        let stepper = $.CreatePanel("Panel", bodycontent, "")
        stepper.AddClass("StorePurchaseStepper")
        let minus = $.CreatePanel("Panel", stepper, "")
        minus.AddClass("StorePurchaseStepButton")
        minus.AddClass("StorePurchaseStepButtonMinus")
        minus.SetPanelEvent("onactivate", function()
        {
            store_purchase_quantity = Math.max(1, store_purchase_quantity - GetStoreStepperStep())
            RenderStorePurchaseModal()
            Game.EmitSound("General.ButtonClick")
        })
        SetStorePurchaseStepperHint(minus)
        let quantity = $.CreatePanel("Label", stepper, "")
        quantity.AddClass("StorePurchaseQuantity")
        quantity.text = is_unlimited ? String(store_purchase_quantity) : (String(store_purchase_quantity) + " / " + String(max_quantity))
        let plus = $.CreatePanel("Panel", stepper, "")
        plus.AddClass("StorePurchaseStepButton")
        plus.AddClass("StorePurchaseStepButtonPlus")
        plus.SetPanelEvent("onactivate", function()
        {
            store_purchase_quantity = Math.min(max_quantity, store_purchase_quantity + GetStoreStepperStep())
            RenderStorePurchaseModal()
            Game.EmitSound("General.ButtonClick")
        })
        SetStorePurchaseStepperHint(plus)
    }

    let actions = $.CreatePanel("Panel", bodycontent, "")
    actions.AddClass("StorePurchaseActions")
    let buy = $.CreatePanel("Panel", actions, "")
    buy.AddClass("StorePurchaseActionButton")
    let external_locked = item.site_only && !IsStoreExternalPaymentUnlocked()
    buy.SetHasClass("StorePurchaseActionButtonDisabled", external_locked)
    buy.SetPanelEvent("onactivate", function()
    {
        if (external_locked)
        {
            Game.EmitSound("General.ButtonClick")
            return
        }
        if (item.site_only)
        {
            ShowStoreExternalPaymentModal(item, store_purchase_quantity)
        }
        else
        {
            GameEvents.SendCustomGameEventToServer("event_services_buy_store_item", { store_item_id: item.id, count: store_purchase_quantity })
            CloseStorePurchaseModal()
        }
    })
    $.CreatePanel("Label", buy, "").text = $.Localize("#services_common_buy")
    let cancel = $.CreatePanel("Panel", actions, "")
    cancel.AddClass("StorePurchaseActionButton")
    cancel.AddClass("StorePurchaseCancelButton")
    cancel.SetPanelEvent("onactivate", CloseStorePurchaseModal)
    $.CreatePanel("Label", cancel, "").text = $.Localize("#services_common_cancel")
}

function ShowStoreExternalPaymentModal(item, quantity)
{
    let purchase_modal = $("#StorePurchaseModal")
    if (purchase_modal) purchase_modal.DeleteAsync(0)
    store_purchase_modal_item = null
    store_purchase_quantity = 1

    store_payment_modal_item = item
    store_payment_quantity = Math.max(1, Number(quantity) || 1)
    store_payment_selected_provider = null
    store_payment_pending = false
    store_payment_error = ""
    RenderStoreExternalPaymentModal()
}

if (typeof Game !== "undefined")
{
    Game.ShowStoreExternalPaymentModal = ShowStoreExternalPaymentModal
}

function CloseStoreExternalPaymentModal()
{
    let modal = $("#StoreExternalPaymentModal")
    if (modal) modal.DeleteAsync(0)
    store_payment_modal_item = null
    store_payment_quantity = 1
    store_payment_selected_provider = null
    store_payment_pending = false
    store_payment_error = ""
    Game.EmitSound("General.ButtonClick")
}

function OpenStoreExternalPaymentProvider(provider)
{
    if (!store_payment_modal_item || !provider) return

    if (!IsStoreExternalPaymentUnlocked())
    {
        ShowStoreExternalPaymentLocked()
        return
    }

    let url = ResolveStoreExternalPaymentUrl(store_payment_modal_item, provider.id, store_payment_quantity)
    if (!url || String(url).trim() === "") return

    store_payment_selected_provider = {
        id: provider.id,
        title: provider.title,
        url: url,
    }

    $.DispatchEvent("ExternalBrowserGoToURL", url)
    RenderStoreExternalPaymentModal()
}

function ShowStoreExternalPaymentProviderUnavailable(provider)
{
    let error = $("#StoreExternalPaymentProviderError")
    if (error)
    {
        error.text = $.Localize("#services_store_payment_provider_unavailable")
    }
    Game.EmitSound("General.ButtonClick")
}

function ShowStoreExternalPaymentLocked()
{
    Game.EmitSound("General.ButtonClick")
}

function ConfirmStoreExternalPaymentPaid()
{
    GameEvents.SendCustomGameEventToServer("event_web_server_force_sync", {})
    if (typeof GetServiceServerSyncNow === "function")
    {
        Game.service_server_sync_cooldown_until = GetServiceServerSyncNow() + SERVICE_SERVER_SYNC_COOLDOWN_SECONDS
    }
    CloseStoreExternalPaymentModal()
}

// Динамическая касса (RollyPay/Enot): просим сервер создать заказ и вернуть
// ссылку на оплату. Пока ждём ответ — показываем "генерируем ссылку".
function RequestStorePaymentOrder(item, provider)
{
    if (!item || !provider) return
    if (!IsStoreExternalPaymentUnlocked())
    {
        ShowStoreExternalPaymentLocked()
        return
    }
    if (store_payment_pending) return
    store_payment_pending = true
    store_payment_error = ""
    GameEvents.SendCustomGameEventToServer("event_services_create_store_payment", {
        store_item_id: String(item.id || ""),
        provider: String(provider.id || "rollypay"),
        count: Math.max(1, Number(store_payment_quantity) || 1),
    })
    RenderStoreExternalPaymentModal()
}

function OnStorePaymentLink(data)
{
    store_payment_pending = false
    store_payment_error = ""
    if (!store_payment_modal_item) return
    if (data && data.store_item_id && String(data.store_item_id) !== String(store_payment_modal_item.id || "")) return

    let url = data && data.url ? String(data.url) : ""
    if (url === "")
    {
        store_payment_error = $.Localize("#services_store_payment_link_error")
        RenderStoreExternalPaymentModal()
        return
    }

    store_payment_selected_provider = {
        id: (data && data.provider) || "rollypay",
        title: LocalizeServiceKeyOrText("#services_store_payment_provider_rollypay_title", "RollyPay"),
        url: url,
    }
    $.DispatchEvent("ExternalBrowserGoToURL", url)
    RenderStoreExternalPaymentModal()
}

function OnStorePaymentLinkError(data)
{
    store_payment_pending = false
    if (store_payment_modal_item && data && data.store_item_id && String(data.store_item_id) !== String(store_payment_modal_item.id || "")) return
    store_payment_error = $.Localize("#services_store_payment_link_error")
    RenderStoreExternalPaymentModal()
}

function RenderStoreExternalPaymentModal()
{
    let old = $("#StoreExternalPaymentModal")
    if (old) old.DeleteAsync(0)
    let item = store_payment_modal_item
    if (!item) return

    let modal = $.CreatePanel("Panel", $("#StoreContent"), "StoreExternalPaymentModal")
    modal.AddClass("StoreExternalPaymentModal")

    let body = $.CreatePanel("Panel", modal, "")
    body.AddClass("StoreExternalPaymentBody")

    let close = $.CreatePanel("Panel", body, "")
    close.AddClass("StoreExternalPaymentClose")
    close.SetPanelEvent("onactivate", CloseStoreExternalPaymentModal)

    let header = $.CreatePanel("Panel", body, "")
    header.AddClass("StoreExternalPaymentHeader")

    let icon = $.CreatePanel("Panel", header, "")
    icon.AddClass("StoreExternalPaymentIcon")
    ApplyBackgroundImage(icon, item.icon || "file://{images}/game_hud/services/stone.png")

    let titleWrap = $.CreatePanel("Panel", header, "")
    titleWrap.AddClass("StoreExternalPaymentTitleWrap")

    let title = $.CreatePanel("Label", titleWrap, "")
    title.AddClass("StoreExternalPaymentTitle")
    title.text = item.title || item.name || item.id

    let price = $.CreatePanel("Label", titleWrap, "")
    price.AddClass("StoreExternalPaymentPrice")
    price.text = item.site_only ? FormatStoreWebPriceForQuantity(item.real_price, store_payment_quantity) : String(item.price || item.cost || "")

    if (!store_payment_selected_provider)
    {
        let payment_unlocked = IsStoreExternalPaymentUnlocked()
        let hint = $.CreatePanel("Label", body, "")
        hint.AddClass("StoreExternalPaymentHint")
        hint.html = true
        hint.text = $.Localize("#services_store_payment_choose")

        let providers = $.CreatePanel("Panel", body, "")
        providers.AddClass("StoreExternalPaymentProviders")

        for (let provider of STORE_PAYMENT_PROVIDERS)
        {
            let is_dynamic = provider.dynamic === true
            let provider_url = is_dynamic ? "" : ResolveStoreExternalPaymentUrl(item, provider.id, store_payment_quantity)
            let has_target = is_dynamic || (provider_url && String(provider_url).trim() !== "")
            let providerButton = $.CreatePanel("Panel", providers, "")
            providerButton.AddClass("StoreExternalPaymentProvider")

            if (!payment_unlocked || !has_target || store_payment_pending)
            {
                providerButton.AddClass("StoreExternalPaymentProviderDisabled")
                providerButton.SetPanelEvent("onactivate", function()
                {
                    if (store_payment_pending) { return }
                    if (!payment_unlocked)
                    {
                        ShowStoreExternalPaymentLocked()
                    }
                    else
                    {
                        ShowStoreExternalPaymentProviderUnavailable(provider)
                    }
                })
            }
            else
            {
                providerButton.SetPanelEvent("onactivate", function()
                {
                    if (is_dynamic)
                    {
                        RequestStorePaymentOrder(item, provider)
                    }
                    else
                    {
                        OpenStoreExternalPaymentProvider(provider)
                    }
                    Game.EmitSound("General.ButtonClick")
                })
            }

            let providerIcon = $.CreatePanel("Panel", providerButton, "")
            providerIcon.AddClass("StoreExternalPaymentProviderIcon")
            ApplyBackgroundImage(providerIcon, provider.icon)

            let providerContent = $.CreatePanel("Panel", providerButton, "")
            providerContent.AddClass("StoreExternalPaymentProviderContent")

            let providerTitle = $.CreatePanel("Label", providerContent, "")
            providerTitle.AddClass("StoreExternalPaymentProviderTitle")
            providerTitle.text = LocalizeServiceKeyOrText(provider.title, provider.title)

            let providerDesc = $.CreatePanel("Label", providerContent, "")
            providerDesc.AddClass("StoreExternalPaymentProviderDesc")
            providerDesc.text = LocalizeServiceKeyOrText(provider.description, "")
        }

        let providerError = $.CreatePanel("Label", body, "StoreExternalPaymentProviderError")
        providerError.AddClass("StoreExternalPaymentProviderError")
        providerError.text = store_payment_pending
            ? $.Localize("#services_store_payment_generating")
            : (store_payment_error || "")
    }
    else
    {
        let opened = $.CreatePanel("Label", body, "")
        opened.AddClass("StoreExternalPaymentHint")
        opened.text = $.Localize("#services_store_payment_opened")

        let urlBox = $.CreatePanel("Panel", body, "StoreExternalPaymentUrl")
        urlBox.AddClass("StoreExternalPaymentUrl")

        let urlLabel = $.CreatePanel("Label", urlBox, "StoreExternalPaymentUrlLabel", {acceptsfocus:true, allowtextselection:true})
        urlLabel.AddClass("StoreExternalPaymentUrlLabel")
        urlLabel.SetAttributeString("acceptsfocus", "true")
        urlLabel.SetAttributeString("allowtextselection", "true")
        urlLabel.text = store_payment_selected_provider.url

        let copyStatus = $.CreatePanel("Label", body, "StoreExternalPaymentCopyStatus")
        copyStatus.AddClass("StoreExternalPaymentCopyStatus")
        copyStatus.text = $.Localize("#services_store_payment_copy_hint")

        let actions = $.CreatePanel("Panel", body, "")
        actions.AddClass("StoreExternalPaymentActions")

        let paid = $.CreatePanel("Panel", actions, "")
        paid.AddClass("StoreExternalPaymentAction")
        paid.SetPanelEvent("onactivate", ConfirmStoreExternalPaymentPaid)
        $.CreatePanel("Label", paid, "").text = $.Localize("#services_store_payment_paid")

        let back = $.CreatePanel("Panel", actions, "")
        back.AddClass("StoreExternalPaymentAction")
        back.AddClass("StoreExternalPaymentBack")
        back.SetPanelEvent("onactivate", function()
        {
            store_payment_selected_provider = null
            RenderStoreExternalPaymentModal()
            Game.EmitSound("General.ButtonClick")
        })
        $.CreatePanel("Label", back, "").text = $.Localize("#services_store_payment_back")
    }
}

function RenderTopUpSection()
{
    let grid = $.CreatePanel("Panel", StoreSectionBody, "")
    grid.AddClass("StoreTopUpGrid")

    for (let card of store_product_data.top_up)
    {
        let panel = $.CreatePanel("Panel", grid, "top_up_" + card.id)
        panel.AddClass("TopUpCard")
        let external_locked = card.site_only && !IsStoreExternalPaymentUnlocked()
        panel.SetHasClass("TopUpCardDisabled", external_locked)
        panel.SetPanelEvent("onactivate", function()
        {
            if (external_locked)
            {
                Game.EmitSound("General.ButtonClick")
                return
            }
            ShowStoreExternalPaymentModal(card, 1)
            Game.EmitSound("General.ButtonClick")
        })

        let panel_bgup = $.CreatePanel("Panel", panel, "")
        panel_bgup.AddClass("TopUpCardBG")
        panel_bgup.hittest = false

        let panel_content = $.CreatePanel("Panel", panel, "")
        panel_content.AddClass("TopUpCardContent")
        panel_content.hittest = false

        let image = $.CreatePanel("Panel", panel_content, "")
        image.AddClass("TopUpImage")
        ApplyBackgroundImage(image, card.icon)

        let badge = $.CreatePanel("Label", panel_content, "")
        badge.AddClass("TopUpBadge")
        badge.text = card.badge

        let title = $.CreatePanel("Label", panel_content, "")
        title.AddClass("TopUpTitle")
        title.text = card.title

        let buyButton = $.CreatePanel("Panel", panel_content, "")
        buyButton.AddClass("TopUpBuyButton")
        buyButton.hittest = false

        let price = $.CreatePanel("Label", buyButton, "")
        price.AddClass("TopUpPrice")
        price.text = card.price
    }
}

function GetThemeClass(theme_name)
{
    if (theme_name === "premium")
    {
        return "Premium"
    }

    if (theme_name === "slacking")
    {
        return "Slacking"
    }

    return "Basic"
}

function ApplyBackgroundImage(panel, image_path)
{
    panel.style.backgroundImage = "url('" + image_path + "')"
    panel.style.backgroundSize = "contain"
    panel.style.backgroundRepeat = "no-repeat"
    panel.style.backgroundPosition = "center"
}

InitStore()