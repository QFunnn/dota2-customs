--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


(function() {
    "use strict";
    // Переключение вкладок инвентаря: new / sold / claimed / jackpots, обновление счётчиков и гридов.
    var shared = GameUI.CustomUIConfig().Casv2Shared;
    if (!shared) return;
    
    var state = shared.state;
    var normalizeToArray = shared.normalizeToArray;
    
    var TABS = { NEW: "new", SOLD: "sold", CLAIMED: "claimed", JACKPOTS: "jackpots" };
    
    var TAB_METADATA = {
        "new": {
            labelKey: "#ui_casv2_tab_new",
            icon: "file://{images}/custom_game/casv2/new_icon_2.png",
            optionId: "InventoryTabItems",
            panelId: "InventoryItemsPanel",
            gridId: "InventoryGrid",
            emptyMessageId: "InventoryEmptyMessage",
            emptyMessageKey: "#ui_casv2_empty_new",
            loadMoreContainerId: "InventoryLoadMoreContainer",
            dataKey: "inventory"
        },
        "sold": {
            labelKey: "#ui_casv2_tab_sold",
            icon: "file://{images}/custom_game/casv2/sold_icon_2.png",
            optionId: "InventoryTabClaimedHistory",
            panelId: "InventoryClaimedPanel",
            gridId: "ClaimedGrid",
            emptyMessageId: "ClaimedEmptyMessage",
            emptyMessageKey: "#ui_casv2_empty_sold",
            loadMoreContainerId: "ClaimedLoadMoreContainer",
            dataKey: "sold_history"
        },
        "claimed": {
            labelKey: "#ui_casv2_tab_claimed",
            icon: "file://{images}/custom_game/casv2/received_icon_2.png",
            optionId: "InventoryTabClaimed",
            panelId: "InventoryClaimedPanel",
            gridId: "ClaimedGrid",
            emptyMessageId: "ClaimedEmptyMessage",
            emptyMessageKey: "#ui_casv2_empty_claimed",
            loadMoreContainerId: "ClaimedLoadMoreContainer",
            dataKey: "claimed_history"
        },
        "jackpots": {
            labelKey: "#ui_casv2_tab_jackpots",
            icon: "file://{images}/custom_game/casv2/jackpot_icon.png",
            optionId: "InventoryTabJackpots",
            panelId: "InventoryJackpotsPanel",
            gridId: "JackpotGrid",
            emptyMessageId: "JackpotEmptyMessage",
            emptyMessageKey: "#ui_casv2_empty_jackpots",
            loadMoreContainerId: null,
            dataKey: "jackpot_history"
        }
    };
    
    var cachedPanels = { root: null, dropdown: null, dropdownText: null, dropdownIcon: null, dropdownMenu: null, itemsPanel: null, claimedPanel: null, jackpotsPanel: null, bulkActions: null };
    
    function getCachedPanels() {
        if (!cachedPanels.root) cachedPanels.root = $.GetContextPanel();
        if (cachedPanels.root) {
            if (!cachedPanels.dropdown) cachedPanels.dropdown = cachedPanels.root.FindChildTraverse("InventoryTabDropdown");
            if (!cachedPanels.dropdownText) cachedPanels.dropdownText = cachedPanels.root.FindChildTraverse("InventoryTabDropdownText");
            if (!cachedPanels.dropdownIcon) cachedPanels.dropdownIcon = cachedPanels.root.FindChildTraverse("InventoryTabDropdownIcon");
            if (!cachedPanels.dropdownMenu) cachedPanels.dropdownMenu = cachedPanels.root.FindChildTraverse("InventoryTabDropdownMenu");
            if (!cachedPanels.itemsPanel) cachedPanels.itemsPanel = cachedPanels.root.FindChildTraverse("InventoryItemsPanel");
            if (!cachedPanels.claimedPanel) cachedPanels.claimedPanel = cachedPanels.root.FindChildTraverse("InventoryClaimedPanel");
            if (!cachedPanels.jackpotsPanel) cachedPanels.jackpotsPanel = cachedPanels.root.FindChildTraverse("InventoryJackpotsPanel");
            if (!cachedPanels.bulkActions) cachedPanels.bulkActions = cachedPanels.root.FindChildTraverse("InventoryBulkActions");
        }
        return cachedPanels;
    }
    
    function getCurrentTab() {
        var tab = state.inventoryActiveTab;
        if (tab === "items") tab = TABS.NEW;
        else if (tab === "claimed_history") tab = TABS.SOLD;
        else if (tab === "jackpots") tab = TABS.JACKPOTS;
        if (!TAB_METADATA[tab]) tab = TABS.NEW;
        state.inventoryActiveTab = tab;
        return tab;
    }
    
    function getTabCount(tab) {
        if (!TAB_METADATA[tab]) return 0;
        if (tab === TABS.NEW && state.inventoryTotalCount != null && !isNaN(state.inventoryTotalCount)) return state.inventoryTotalCount;
        if (tab === TABS.SOLD && state.soldTotalCount != null && !isNaN(state.soldTotalCount)) return state.soldTotalCount;
        if (tab === TABS.CLAIMED && state.claimedTotalCount != null && !isNaN(state.claimedTotalCount)) return state.claimedTotalCount;
        if (tab === TABS.JACKPOTS && state.jackpotTotalCount != null && !isNaN(state.jackpotTotalCount)) return state.jackpotTotalCount;
        return normalizeToArray(state.casinoData[TAB_METADATA[tab].dataKey]).length;
    }
    
    function updateDropdown(tab) {
        var panels = getCachedPanels();
        if (!panels.root) return;
        var metadata = TAB_METADATA[tab];
        if (!metadata) return;
        
        var formatNumber = (shared && shared.formatNumber) ? shared.formatNumber : function(n) { return String(n); };
        function formatCount(n) {
            return formatNumber(Math.max(0, Math.floor(Number(n) || 0)));
        }
        
        var tabIds = ["new", "sold", "claimed", "jackpots"];
        for (var i = 0; i < tabIds.length; i++) {
            var t = tabIds[i], meta = TAB_METADATA[t];
            if (!meta || !meta.labelKey) continue;
            var optionPanel = panels.root.FindChildTraverse(meta.optionId);
            if (!optionPanel) continue;
            for (var j = 0; j < optionPanel.GetChildCount(); j++) {
                var ch = optionPanel.GetChild(j);
                if (ch && ch.BHasClass && ch.BHasClass("custom-dropdown-option-text")) {
                    ch.text = $.Localize(meta.labelKey) + " (" + formatCount(getTabCount(t)) + ")";
                    break;
                }
            }
        }
        
        if (panels.dropdownText && metadata.labelKey) panels.dropdownText.text = $.Localize(metadata.labelKey) + " (" + formatCount(getTabCount(tab)) + ")";
        if (panels.dropdownIcon && metadata.icon) {
            if (typeof panels.dropdownIcon.SetImage === "function") panels.dropdownIcon.SetImage(metadata.icon);
            else panels.dropdownIcon.src = metadata.icon;
        }
    }
    
    function updatePanelVisibility(tab) {
        var panels = getCachedPanels();
        if (!panels.root) return;
        var metadata = TAB_METADATA[tab];
        if (!metadata) return;
        var isNew = (tab === TABS.NEW);
        var isJackpots = (tab === TABS.JACKPOTS);
        if (panels.itemsPanel) panels.itemsPanel.style.visibility = isNew ? "visible" : "collapse";
        if (panels.claimedPanel) panels.claimedPanel.style.visibility = (tab === TABS.SOLD || tab === TABS.CLAIMED) ? "visible" : "collapse";
        if (panels.jackpotsPanel) panels.jackpotsPanel.style.visibility = isJackpots ? "visible" : "collapse";
        if (panels.bulkActions) panels.bulkActions.style.visibility = isNew ? "visible" : "collapse";
        var emptyMessage = panels.root.FindChildTraverse(metadata.emptyMessageId);
        if (emptyMessage && metadata.emptyMessageKey) emptyMessage.text = $.Localize(metadata.emptyMessageKey);
    }
    
    function updateEmptyState(tab) {
        var panels = getCachedPanels();
        if (!panels.root) return;
        var metadata = TAB_METADATA[tab];
        if (!metadata) return;
        var emptyMessage = panels.root.FindChildTraverse(metadata.emptyMessageId);
        if (emptyMessage) emptyMessage.visible = (getTabCount(tab) === 0);
    }
    
    function setActiveTab(tab) {
        if (!TAB_METADATA[tab]) return false;
        state.inventoryActiveTab = tab;
        updateDropdown(tab);
        updatePanelVisibility(tab);
        updateEmptyState(tab);
        var casv2 = GameUI.CustomUIConfig().Casv2;
        if (casv2 && casv2.historyInventory && casv2.historyInventory.loadInventoryItems) casv2.historyInventory.loadInventoryItems();
        return true;
    }
    
    function refreshCurrentTab() {
        var tab = getCurrentTab();
        updateDropdown(tab);
        updateEmptyState(tab);
    }
    
    var InventoryTabController = {
        setActiveTab: setActiveTab,
        getTab: function() { return getCurrentTab(); },
        refreshCurrentTab: refreshCurrentTab,
        getTabMetadata: function(tab) { return TAB_METADATA[tab] || null; },
        getAllTabs: function() { return [TABS.NEW, TABS.SOLD, TABS.CLAIMED, TABS.JACKPOTS]; },
        getCurrentTabCount: function() { return getTabCount(getCurrentTab()); },
        getTabCount: getTabCount,
        TABS: TABS,
        TAB_METADATA: TAB_METADATA
    };
    
    if (!GameUI.CustomUIConfig().Casv2Features) GameUI.CustomUIConfig().Casv2Features = {};
    GameUI.CustomUIConfig().Casv2Features.InventoryTabController = InventoryTabController;
})();