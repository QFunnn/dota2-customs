--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
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
const playerNameLabel = panel("CustomInventoryPlayerName");
const coinsLabel = panel("CustomInventoryCoinsValue");
const avatarImage = panel("CustomInventoryAvatar");
const promoInput = panel("CustomInventoryPromoInput");
const promoButton = panel("CustomInventoryPromoActivate");
const promoStatusLabel = panel("CustomInventoryPromoStatus");
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
function resolvePromoStatusText(text) {
    if (text.startsWith("#")) {
        return $.Localize(text);
    }
    return text;
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
    setPromoControlsEnabled(!promoState.pending);
}
function normalizePromoCode(code) {
    return code.trim().toUpperCase();
}
function activatePromoCode() {
    if (!promoInput || promoSubmitInFlight) {
        return;
    }
    const normalizedCode = normalizePromoCode(promoInput.text);
    promoInput.text = normalizedCode;
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
    if (!tabBody) {
        return;
    }
    activeTab = nextTab;
    setActiveTabButton(nextTab);
    for (const [tab, panelInstance] of Object.entries(loadedTabPanels)) {
        panelInstance.visible = tab === nextTab;
    }
    if (loadedTabPanels[nextTab]) {
        return;
    }
    const contentPanel = $.CreatePanel("Panel", tabBody, "");
    contentPanel.AddClass("CustomInventoryTabContent");
    contentPanel.BLoadLayout(INVENTORY_TAB_LAYOUTS[nextTab], false, false);
    loadedTabPanels[nextTab] = contentPanel;
    contentPanel.Data().OnLoad();
}
function initInventoryHud() {
    updateHeaderInfo();
    updateCoins();
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
            updatePromoStatus();
        }
    });
    showTab("inventory");
}
GameUI.SwitchCustomInventoryTab = (tabId) => {
    showTab(tabId);
};
GameUI.ActivateInventoryPromoCode = () => {
    activatePromoCode();
};
initInventoryHud();