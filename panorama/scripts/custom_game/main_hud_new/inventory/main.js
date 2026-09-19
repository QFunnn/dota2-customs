--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";
const INVENTORY_TAB_LAYOUTS = {
    inventory: "file://{resources}/layout/custom_game/main_hud_new/inventory/inventory/inventory.xml",
    chat_wheel: "file://{resources}/layout/custom_game/main_hud_new/inventory/chat_wheel/chat_wheel.xml",
    shop: "file://{resources}/layout/custom_game/main_hud_new/inventory/shop/shop.xml",
};
const tabBody = panel("CustomInventoryTabBody");
const inventoryOverlay = panel("CustomInventoryOverlay");
const shopUnavailableOverlay = panel("CustomInventoryShopUnavailableOverlay");
const playerNameLabel = panel("CustomInventoryPlayerName");
const coinsLabel = panel("CustomInventoryCoinsValue");
const avatarImage = panel("CustomInventoryAvatar");
const promoInput = panel("CustomInventoryPromoInput");
const promoButton = panel("CustomInventoryPromoActivate");
const promoStatusLabel = panel("CustomInventoryPromoStatus");
const subscriptionStatusPanel = panel("CustomInventorySubscriptionStatus");
const subscriptionStateLabel = panel("CustomInventorySubscriptionState");
const dailyRewardsTrackFill = panel("DailyRewardsTrackFill");
const dailyRewardStep1 = panel("DailyRewardStep1");
const dailyRewardStep4 = panel("DailyRewardStep4");
const dailyRewardStepPremium = panel("DailyRewardStepPremium");
const tabButtons = {
    inventory: "CustomInventoryTabInventory",
    chat_wheel: "CustomInventoryTabChatWheel",
    shop: "CustomInventoryTabShop",
};
let activeTab = "inventory";
let netTableListener;
const loadedTabPanels = {};
const tabOnLoadCalled = {};
let promoSubmitInFlight = false;
let promoStatusHideSchedule;
let dismissedPromoStatusKey = "";
let lastInventoryHiddenState = true;
const DAILY_REWARDS_FINAL_MATCHES = 8;
const DAILY_REWARDS_TRACK_WIDTH = 76;
function formatSubscriptionDate(rawDate) {
    const match = rawDate.match(/^(\d{4})-(\d{2})-(\d{2})/);
    if (!match) {
        return rawDate;
    }
    const [, year, month, day] = match;
    return `${day}.${month}.${year}`;
}
function getPromoCodeState() {
    var _a;
    const localPlayerId = Players.GetLocalPlayer();
    const playerInfo = CustomNetTables.GetTableValue("player_info_shop", String(localPlayerId));
    const pending = Number((_a = playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.promo_pending) !== null && _a !== void 0 ? _a : 0) === 1;
    return {
        pending,
        statusText: typeof (playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.promo_status_text) === "string" ? playerInfo.promo_status_text : "",
        statusType: typeof (playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.promo_status_type) === "string" ? playerInfo.promo_status_type : "",
        lastCode: typeof (playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.promo_last_code) === "string" ? playerInfo.promo_last_code : "",
    };
}
function isInventoryShopAvailable() {
    var _a;
    const localPlayerId = Players.GetLocalPlayer();
    const playerInfo = CustomNetTables.GetTableValue("player_info_shop", String(localPlayerId));
    return Number((_a = playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.shop_available) !== null && _a !== void 0 ? _a : 0) === 1;
}
function updateShopAvailability() {
    const available = isInventoryShopAvailable();
    if (shopUnavailableOverlay) {
        shopUnavailableOverlay.SetHasClass("Hidden", available);
    }
    if (!available) {
        promoSubmitInFlight = false;
    }
    updatePromoStatus();
}
function resolveLocalizedText(text) {
    if (text.startsWith("#")) {
        return $.Localize(text);
    }
    return text;
}
function getSubscriptionState() {
    var _a, _b;
    const localPlayerId = Players.GetLocalPlayer();
    const playerInfo = CustomNetTables.GetTableValue("player_info_shop", String(localPlayerId));
    const hasBackendState = (playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.subscription_active) !== undefined || typeof (playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.subscription_status) === "string";
    if (!hasBackendState) {
        return {
            active: false,
            status: "inactive",
            title: "#MENU_SHOP_Subscription_State_Inactive",
            until: "",
        };
    }
    const status = typeof (playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.subscription_status) === "string"
        ? playerInfo.subscription_status
        : Number((_a = playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.subscription_active) !== null && _a !== void 0 ? _a : 0) === 1 ? "active" : "inactive";
    const active = Number((_b = playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.subscription_active) !== null && _b !== void 0 ? _b : 0) === 1 || status === "active";
    const until = typeof (playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.subscription_until) === "string" ? playerInfo.subscription_until : "";
    const statusText = typeof (playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.subscription_status_text) === "string" ? playerInfo.subscription_status_text : "";
    if (statusText.length > 0) {
        return {
            active,
            status,
            title: getSubscriptionTitle(active, status, until),
            until,
        };
    }
    return {
        active,
        status,
        title: getSubscriptionTitle(active, status, until),
        until,
    };
}
function getSubscriptionTitle(active, status, until) {
    if (active) {
        if (until.length === 0) {
            return "#MENU_SHOP_Subscription_State_Active";
        }
        const formattedUntil = formatSubscriptionDate(until);
        const activeUntilTemplate = $.Localize("#MENU_SHOP_Subscription_Title_ActiveUntil");
        if (activeUntilTemplate.indexOf("{s:date}") !== -1) {
            return activeUntilTemplate.split("{s:date}").join(formattedUntil);
        }
        return `${activeUntilTemplate} ${formattedUntil}`;
    }
    if (status === "loading") {
        return "#MENU_SHOP_Subscription_Title_Loading";
    }
    if (status === "error") {
        return "#MENU_SHOP_Subscription_Title_Error";
    }
    return "#MENU_SHOP_Subscription_State_Inactive";
}
function getSubscriptionTooltipText(state) {
    if (state.active) {
        return $.Localize("#MENU_SHOP_Subscription_Tooltip_Active");
    }
    return $.Localize("#MENU_SHOP_Subscription_Tooltip_Inactive");
}
function openSubscriptionSiteIfInactive(state) {
    if (state.active || state.status !== "inactive") {
        return;
    }
    $.DispatchEvent("ExternalBrowserGoToURL", "https://ratten.run");
}
function resolvePromoStatusText(text) {
    return resolveLocalizedText(text);
}
function getPromoStatusKey(statusText, statusType, lastCode) {
    return `${statusType}|${statusText}|${lastCode}`;
}
function cancelPromoStatusHideTimer() {
    if (promoStatusHideSchedule !== undefined) {
        $.CancelScheduled(promoStatusHideSchedule);
        promoStatusHideSchedule = undefined;
    }
}
function hidePromoStatus() {
    cancelPromoStatusHideTimer();
    if (promoStatusLabel) {
        promoStatusLabel.text = "";
        promoStatusLabel.SetHasClass("Hidden", true);
        promoStatusLabel.SetHasClass("PromoStatusSuccess", false);
        promoStatusLabel.SetHasClass("PromoStatusError", false);
        promoStatusLabel.SetHasClass("PromoStatusPending", false);
    }
}
function dismissPromoStatus(statusKey) {
    dismissedPromoStatusKey = statusKey;
    hidePromoStatus();
}
function schedulePromoStatusHide(statusKey) {
    cancelPromoStatusHideTimer();
    promoStatusHideSchedule = $.Schedule(15, () => {
        dismissPromoStatus(statusKey);
    });
}
function renderPromoStatus(statusText, statusType, lastCode = "", keepVisible = false) {
    const hasStatus = statusText.length > 0;
    const statusKey = getPromoStatusKey(statusText, statusType, lastCode);
    if (!hasStatus) {
        dismissedPromoStatusKey = "";
        hidePromoStatus();
        return;
    }
    if (!keepVisible && dismissedPromoStatusKey === statusKey) {
        hidePromoStatus();
        return;
    }
    if (promoStatusLabel) {
        promoStatusLabel.text = resolvePromoStatusText(statusText);
        promoStatusLabel.SetHasClass("Hidden", false);
        promoStatusLabel.SetHasClass("PromoStatusSuccess", statusType === "success");
        promoStatusLabel.SetHasClass("PromoStatusError", statusType === "error");
        promoStatusLabel.SetHasClass("PromoStatusPending", statusType === "pending");
    }
    if (keepVisible) {
        dismissedPromoStatusKey = "";
        cancelPromoStatusHideTimer();
        return;
    }
    schedulePromoStatusHide(statusKey);
}
function watchInventoryVisibility() {
    $.Schedule(0.1, watchInventoryVisibility);
    if (!inventoryOverlay) {
        return;
    }
    const isHiddenNow = inventoryOverlay.BHasClass("Hidden");
    if (isHiddenNow && !lastInventoryHiddenState) {
        dismissPromoStatus(getPromoStatusKey(getPromoCodeState().statusText, getPromoCodeState().statusType, getPromoCodeState().lastCode));
    }
    lastInventoryHiddenState = isHiddenNow;
}
function updateHeaderInfo() {
    const localPlayerId = Players.GetLocalPlayer();
    const playerInfo = Game.GetPlayerInfo(localPlayerId);
    if (playerNameLabel) {
        playerNameLabel.text = Players.GetPlayerName(localPlayerId);
    }
    if (avatarImage && playerInfo) {
        avatarImage.steamid = playerInfo.player_steamid;
    }
}
function updateCoins() {
    var _a;
    const localPlayerId = Players.GetLocalPlayer();
    const playerInfo = CustomNetTables.GetTableValue("player_info_shop", String(localPlayerId));
    const gold = Number((_a = playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.gold) !== null && _a !== void 0 ? _a : 0);
    if (coinsLabel) {
        coinsLabel.text = String(gold);
    }
}
function updateSubscriptionStatus() {
    if (!subscriptionStatusPanel) {
        return;
    }
    const state = getSubscriptionState();
    subscriptionStatusPanel.SetHasClass("Active", state.active);
    subscriptionStatusPanel.SetHasClass("Inactive", !state.active && state.status === "inactive");
    subscriptionStatusPanel.SetHasClass("Loading", state.status === "loading");
    subscriptionStatusPanel.SetHasClass("Error", state.status === "error");
    if (subscriptionStateLabel) {
        subscriptionStateLabel.text = resolveLocalizedText(state.title);
    }
    subscriptionStatusPanel.SetPanelEvent("onactivate", () => openSubscriptionSiteIfInactive(state));
    subscriptionStatusPanel.SetPanelEvent("onmouseover", () => {
        $.DispatchEvent("DOTAShowTextTooltip", subscriptionStatusPanel, getSubscriptionTooltipText(state));
    });
    subscriptionStatusPanel.SetPanelEvent("onmouseout", () => {
        $.DispatchEvent("DOTAHideTextTooltip", subscriptionStatusPanel);
    });
}
function setPromoControlsEnabled(enabled) {
    if (promoInput) {
        promoInput.enabled = enabled;
    }
    if (promoButton) {
        promoButton.enabled = enabled;
    }
}
function updatePromoStatus() {
    const promoState = getPromoCodeState();
    promoSubmitInFlight = promoState.pending;
    renderPromoStatus(promoState.statusText, promoState.statusType, promoState.lastCode, promoState.pending);
    setPromoControlsEnabled(!promoState.pending && isInventoryShopAvailable());
}
function normalizePromoCode(code) {
    return code.trim();
}
function readNumberField(source, fieldNames) {
    if (!source) {
        return 0;
    }
    for (const fieldName of fieldNames) {
        const value = source[fieldName];
        if (value !== undefined && value !== null) {
            const parsed = Number(value);
            if (!Number.isNaN(parsed)) {
                return parsed;
            }
        }
    }
    return 0;
}
function getDailyRewardsState() {
    const localPlayerId = Players.GetLocalPlayer();
    const playerInfo = CustomNetTables.GetTableValue("player_info_shop", String(localPlayerId));
    const matches = readNumberField(playerInfo, [
        "matchesToday",
        "matches_today",
        "daily_matches",
        "daily_reward_matches",
        "daily_activity_matches",
        "daily_games",
        "daily_games_played",
    ]);
    const subscription = getSubscriptionState();
    return {
        matches: Math.max(0, Math.min(DAILY_REWARDS_FINAL_MATCHES, matches)),
        hasSubscription: subscription.active,
    };
}
function resetDailyRewardStepState(step) {
    if (!step) {
        return;
    }
    step.SetHasClass("Completed", false);
    step.SetHasClass("Active", false);
    step.SetHasClass("Locked", false);
    step.SetHasClass("PremiumLocked", false);
}
function updateDailyRewardStep(step, completed, active, locked, premiumLocked = false) {
    if (!step) {
        return;
    }
    resetDailyRewardStepState(step);
    step.SetHasClass("Completed", completed);
    step.SetHasClass("Active", active);
    step.SetHasClass("Locked", locked);
    step.SetHasClass("PremiumLocked", premiumLocked);
}
function updateDailyRewards() {
    const state = getDailyRewardsState();
    const matches = state.matches;
    const reachedFirst = matches >= 1;
    const reachedFourth = matches >= 4;
    const reachedPremium = matches >= DAILY_REWARDS_FINAL_MATCHES;
    const premiumCompleted = reachedPremium && state.hasSubscription;
    const premiumNeedsSubscription = reachedPremium && !state.hasSubscription;
    if (dailyRewardsTrackFill) {
        const fillWidth = Math.min(DAILY_REWARDS_TRACK_WIDTH, Math.max(0, matches / DAILY_REWARDS_FINAL_MATCHES * DAILY_REWARDS_TRACK_WIDTH));
        dailyRewardsTrackFill.style.width = `${fillWidth}%`;
    }
    updateDailyRewardStep(dailyRewardStep1, reachedFirst, !reachedFirst, !reachedFirst);
    updateDailyRewardStep(dailyRewardStep4, reachedFourth, reachedFirst && !reachedFourth, !reachedFourth);
    updateDailyRewardStep(dailyRewardStepPremium, premiumCompleted, reachedFourth && !reachedPremium, !premiumCompleted, premiumNeedsSubscription);
}
function bindDailyRewardTooltip(step, tooltipToken) {
    if (!step) {
        return;
    }
    step.SetPanelEvent("onmouseover", () => {
        $.DispatchEvent("DOTAShowTextTooltip", step, $.Localize(tooltipToken));
    });
    step.SetPanelEvent("onmouseout", () => {
        $.DispatchEvent("DOTAHideTextTooltip", step);
    });
}
function initDailyRewardTooltips() {
    bindDailyRewardTooltip(dailyRewardStep1, "#HUD_Inventory_DailyRewardsTooltipOneMatch");
    bindDailyRewardTooltip(dailyRewardStep4, "#HUD_Inventory_DailyRewardsTooltipFourMatches");
    bindDailyRewardTooltip(dailyRewardStepPremium, "#HUD_Inventory_DailyRewardsTooltipPremium");
}
function activatePromoCode() {
    if (!promoInput || promoSubmitInFlight) {
        return;
    }
    if (!isInventoryShopAvailable()) {
        renderPromoStatus("#HUD_Inventory_ShopUnavailable_Title", "error");
        return;
    }
    const normalizedCode = normalizePromoCode(promoInput.text);
    if (normalizedCode.length === 0) {
        renderPromoStatus("#HUD_Inventory_PromoEmpty", "error");
        return;
    }
    promoSubmitInFlight = true;
    setPromoControlsEnabled(false);
    renderPromoStatus("#HUD_Inventory_PromoPending", "pending", normalizedCode, true);
    GameEvents.SendCustomGameEventToServer("server_activate_promo_code", {
        code: normalizedCode,
    });
}
function initPromoControls() {
    if (!promoInput) {
        return;
    }
    promoInput.SetPanelEvent("oninputsubmit", activatePromoCode);
    updatePromoStatus();
}
function setActiveTabButton(nextTab) {
    for (const [tab, buttonId] of Object.entries(tabButtons)) {
        const button = panel(buttonId);
        if (!button) {
            continue;
        }
        button.SetHasClass("Selected", tab === nextTab);
    }
}
function showTab(nextTab) {
    var _a, _b, _c, _d, _e;
    if (!tabBody) {
        return;
    }
    activeTab = nextTab;
    setActiveTabButton(nextTab);
    for (const [tab, panelInstance] of Object.entries(loadedTabPanels)) {
        panelInstance.visible = tab === nextTab;
    }
    if (loadedTabPanels[nextTab]) {
        (_c = (_a = loadedTabPanels[nextTab]) === null || _a === void 0 ? void 0 : (_b = _a.Data()).OnShow) === null || _c === void 0 ? void 0 : _c.call(_b);
        return;
    }
    const contentPanel = $.CreatePanel("Panel", tabBody, "");
    contentPanel.AddClass("CustomInventoryTabContent");
    contentPanel.BLoadLayout(INVENTORY_TAB_LAYOUTS[nextTab], false, false);
    loadedTabPanels[nextTab] = contentPanel;
    contentPanel.Data().OnLoad();
    (_e = (_d = contentPanel.Data()).OnShow) === null || _e === void 0 ? void 0 : _e.call(_d);
}
function initInventoryHud() {
    updateHeaderInfo();
    updateCoins();
    updateSubscriptionStatus();
    updateDailyRewards();
    initDailyRewardTooltips();
    updateShopAvailability();
    initPromoControls();
    watchInventoryVisibility();
    if (netTableListener !== undefined) {
        CustomNetTables.UnsubscribeNetTableListener(netTableListener);
    }
    netTableListener = CustomNetTables.SubscribeNetTableListener("player_info_shop", (tableName, key) => {
        if (tableName !== "player_info_shop") {
            return;
        }
        const localPlayerId = String(Players.GetLocalPlayer());
        if (key === localPlayerId) {
            updateCoins();
            updateSubscriptionStatus();
            updateDailyRewards();
            updateShopAvailability();
        }
    });
    showTab("inventory");
}
GameUI.SwitchCustomInventoryTab = (tabId) => {
    if (!isInventoryShopAvailable()) {
        return;
    }
    showTab(tabId);
};
GameUI.ActivateInventoryPromoCode = () => {
    activatePromoCode();
};
initInventoryHud();