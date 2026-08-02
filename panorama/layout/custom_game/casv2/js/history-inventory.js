--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


(function() {
    "use strict";
    // Инвентарь казино: сетка предметов, вкладки (new/sold/claimed/jackpots), sell/claim, уведомления о выигрышах.
    var shared = GameUI.CustomUIConfig().Casv2Shared;
    var state = shared.state;
    var casv2 = GameUI.CustomUIConfig().Casv2;
    var NOTIFICATION_DURATION_SEC = 10;
    var NOTIFICATION_JACKPOT_DURATION_SEC = 10;
    var NOTIFICATION_MAX_COUNT = 3;
    var NOTIFICATION_HIDE_ANIM_SEC = 0.3;
    var shownRollHistoryIds = {};
    var shownRecentJackpotIds = {};
    var DEFAULT_INVENTORY_ROW_SNIPPET = "inventory_item_row_aaa";
    var JACKPOT_ROW_SNIPPET = "inventory_item_row_jackpot";
    var RECEIVED_ICON_PATH = "file://{images}/custom_game/casv2/received_icon_2.png";
    var CLAIM_ONLY_SELL_LOCALE = "#ui_casv2_claim_only_sell";

    function getDotaHUD() {
        try { return GameUI.CustomUIConfig().DotaHUD; } catch (e) { return null; }
    }
    function showClaimError() {
        var hud = getDotaHUD();
        if (hud && typeof hud.ShowError === "function") {
            hud.ShowError($.Localize(CLAIM_ONLY_SELL_LOCALE));
        }
    }

    function isJackpotItem(itemName) {
        if (!itemName) return false;
        var n = String(itemName);
        return n === "item_crystal_jackpot" || n === "item_jackpot_pet" || n === "item_mimic_pet";
    }

    function getItemDisplayName(itemName) {
        if (itemName == null || itemName === "") return "\u2014";
        var s = String(itemName).replace(/^\s*em\s+/i, "").trim();
        if (!s) return "\u2014";
        try {
            if (typeof $.Localize === "function") {
                var locKey = "DOTA_Tooltip_ability_" + s;
                var loc = $.Localize("#" + locKey);
                if (loc && loc !== ("#" + locKey) && loc !== locKey) return loc;
            }
        } catch (e) {}
        return s;
    }

    function getFeature(name) {
        var features = GameUI.CustomUIConfig().Casv2Features;
        return features && features[name] || null;
    }

    function collectButtonsFromGrid(grid, childId) {
        var list = [];
        if (!grid || !grid.IsValid()) return list;
        for (var i = 0; i < grid.GetChildCount(); i++) {
            var card = grid.GetChild(i);
            if (!card || !card.IsValid()) continue;
            var btn = card.FindChildTraverse(childId);
            if (btn && btn.IsValid()) list.push(btn);
        }
        return list;
    }

    function collectPanelsByClass(panel, className) {
        var list = [];
        if (!panel || !panel.IsValid()) return list;
        if (panel.BHasClass && panel.BHasClass(className)) list.push(panel);
        for (var i = 0; i < panel.GetChildCount(); i++) {
            list = list.concat(collectPanelsByClass(panel.GetChild(i), className));
        }
        return list;
    }

    function getAllSellAndClaimButtons(root) {
        var sell = [], claim = [];
        var invGrid = root.FindChildTraverse("InventoryGrid");
        var jpGrid = root.FindChildTraverse("JackpotGrid");
        if (invGrid) {
            sell = sell.concat(collectButtonsFromGrid(invGrid, "InvRowBtnSell"));
            claim = claim.concat(collectButtonsFromGrid(invGrid, "InvRowBtnClaim"));
        }
        if (jpGrid) {
            sell = sell.concat(collectPanelsByClass(jpGrid, "item-card-jackpot-btn-sell"));
            claim = claim.concat(collectPanelsByClass(jpGrid, "item-card-jackpot-btn-claim"));
        }
        return { sell: sell, claim: claim };
    }

    var COOLDOWN_TOOLTIP_WAIT = "#ui_casv2_cooldown_wait";

    function applySellCooldownVisual() {
        var root = $.GetContextPanel();
        if (!root) return;
        var btns = getAllSellAndClaimButtons(root).sell;
        for (var i = 0; i < btns.length; i++) {
            btns[i].enabled = false;
            btns[i].AddClass("casv2-sell-cooldown");
            btns[i].tooltip_text = $.Localize(COOLDOWN_TOOLTIP_WAIT);
        }
        GameUI.LoopTime.Schedule(1, function() {
            for (var j = 0; j < btns.length; j++) {
                if (btns[j] && btns[j].IsValid()) {
                    btns[j].RemoveClass("casv2-sell-cooldown");
                    btns[j].enabled = true;
                    btns[j].tooltip_text = $.Localize("#ui_casv2_sell_for_currency");
                }
            }
        });
    }

    function applyClaimCooldownVisual() {
        var root = $.GetContextPanel();
        if (!root) return;
        var btns = getAllSellAndClaimButtons(root).claim;
        for (var i = 0; i < btns.length; i++) {
            btns[i].enabled = false;
            btns[i].AddClass("casv2-claim-cooldown");
            btns[i].tooltip_text = $.Localize(COOLDOWN_TOOLTIP_WAIT);
        }
        GameUI.LoopTime.Schedule(1, function() {
            for (var j = 0; j < btns.length; j++) {
                if (btns[j] && btns[j].IsValid()) {
                    btns[j].RemoveClass("casv2-claim-cooldown");
                    btns[j].enabled = true;
                    btns[j].tooltip_text = $.Localize("#ui_casv2_claim_to_inventory");
                }
            }
        });
    }

    function updateHistoryDisplay(history, replaceAll) {
        var root = $.GetContextPanel();
        if (!root) return;
        history = history || [];
        replaceAll = replaceAll === true;
        var winnersPanel = root.FindChildTraverse("WinnersPanel");
        if (!winnersPanel) return;
        var winnersListPanel = null;
        for (var i = 0; i < winnersPanel.GetChildCount(); i++) {
            var child = winnersPanel.GetChild(i);
            if (child && child.BHasClass("winners-list-panel")) { winnersListPanel = child; break; }
        }
        if (!winnersListPanel) return;
        var winnersGrid = null;
        for (var i = 0; i < winnersListPanel.GetChildCount(); i++) {
            var child = winnersListPanel.GetChild(i);
            if (child && child.BHasClass("winners-grid")) { winnersGrid = child; break; }
        }
        if (!winnersGrid) return;
        var column1 = null, column2 = null;
        for (var i = 0; i < winnersGrid.GetChildCount(); i++) {
            var child = winnersGrid.GetChild(i);
            if (child && child.BHasClass("winners-column")) {
                if (!column1) column1 = child;
                else if (!column2) { column2 = child; break; }
            }
        }
        if (!column1 || !column2) return;
        if (replaceAll) {
            column1.RemoveAndDeleteChildren();
            column2.RemoveAndDeleteChildren();
        }
        var currentCardCount = 0;
        if (!replaceAll) currentCardCount = column1.GetChildCount() + column2.GetChildCount();
        for (var i = 0; i < history.length; i++) {
            var historyItem = history[i];
            var cardIndex = currentCardCount + i + 1;
            var targetColumn = (cardIndex % 2 === 1) ? column1 : column2;
            try {
                var cardContainer = $.CreatePanel("Panel", targetColumn, "WinnerCardContainer" + cardIndex);
                if (!cardContainer) continue;
                cardContainer.BLoadLayoutSnippet("winner_card");
                var timeLabel = cardContainer.FindChildTraverse("winner-time");
                if (timeLabel && historyItem && historyItem.roll_date && shared && typeof shared.formatTimeAgo === "function") {
                    timeLabel.text = shared.formatTimeAgo(historyItem.roll_date);
                }
                var avatar = cardContainer.FindChildTraverse("winner-avatar");
                if (avatar && historyItem.user_steamid) avatar.steamid = historyItem.user_steamid;
                var itemName = (historyItem.is_win && historyItem.winning_item && historyItem.winning_item.item_name) ? historyItem.winning_item.item_name : (historyItem.item1 && historyItem.item1.item_name ? historyItem.item1.item_name : null);
                if (itemName) {
                    var winnerItem = cardContainer.FindChildTraverse("winner-item");
                    if (winnerItem) winnerItem.itemname = itemName;
                }
            } catch (e) {}
        }
    }

    function loadMoreHistory() {
        if (state.isLoadingHistory) return;
        if (!state.historyHasMore && state.historyLastId === null) return;
        state.isLoadingHistory = true;
        var root = $.GetContextPanel();
        var loadMoreButton = root ? root.FindChildTraverse("LoadMoreWinnersButton") : null;
        if (loadMoreButton) loadMoreButton.enabled = false;
        var requestData = { limit: 10 };
        if (state.historyLastId !== null) requestData.last_id = state.historyLastId;
        GameEvents.SendCustomGameEventToServer("casv2_load_history", requestData);
    }

    function onCasinoHistoryReceived(data) {
        state.isLoadingHistory = false;
        var root = $.GetContextPanel();
        var loadMoreButton = root ? root.FindChildTraverse("LoadMoreWinnersButton") : null;
        if (data && data.success) {
            var history = shared.normalizeToArray(data.history);
            if (history && history.length > 0) {
                if (data.last_id !== null && data.last_id !== undefined) state.historyLastId = data.last_id;
                else {
                    var lastItem = history[history.length - 1];
                    if (lastItem && lastItem.id) state.historyLastId = lastItem.id;
                }
                state.historyHasMore = data.has_more === true;
                updateHistoryDisplay(history, false);
            } else {
                state.historyHasMore = false;
                if (data.last_id !== null && data.last_id !== undefined) state.historyLastId = data.last_id;
            }
        } else state.historyHasMore = false;
        updateLoadMoreButtonVisibility();
        if (loadMoreButton) loadMoreButton.enabled = true;
    }

    function updateLoadMoreButtonVisibility() {
        var root = $.GetContextPanel();
        var loadMoreButton = root ? root.FindChildTraverse("LoadMoreWinnersButton") : null;
        if (loadMoreButton) loadMoreButton.style.visibility = state.historyHasMore ? "visible" : "collapse";
    }

    function updateInventoryButtonText() {
    }

    function applyInventoryTab() {
        var InventoryTabController = getFeature("InventoryTabController");
        
        if (InventoryTabController) {
            InventoryTabController.refreshCurrentTab();
        } else {
            var root = $.GetContextPanel();
            if (!root) return;
            var itemsPanel = root.FindChildTraverse("InventoryItemsPanel");
            var claimedPanel = root.FindChildTraverse("InventoryClaimedPanel");
            var jackpotsPanel = root.FindChildTraverse("InventoryJackpotsPanel");
            var bulkActions = root.FindChildTraverse("InventoryBulkActions");
            var inventoryLoadMoreContainer = root.FindChildTraverse("InventoryLoadMoreContainer");
            var claimedLoadMoreContainer = root.FindChildTraverse("ClaimedLoadMoreContainer");
            
            var dropdownText = root.FindChildTraverse("InventoryTabDropdownText");
            var dropdownIcon = root.FindChildTraverse("InventoryTabDropdownIcon");
            
            if (state.inventoryActiveTab === "items") {
                if (itemsPanel) itemsPanel.style.visibility = "visible";
                if (claimedPanel) claimedPanel.style.visibility = "collapse";
                var optionItems = root.FindChildTraverse("InventoryTabItems");
                if (dropdownText && optionItems) {
                    var optionText = optionItems.FindChildTraverse("custom-dropdown-option-text");
                    if (optionText) dropdownText.text = optionText.text;
                }
                if (dropdownIcon && optionItems) {
                    var optionIcon = optionItems.FindChildTraverse("custom-dropdown-option-icon");
                    if (optionIcon) dropdownIcon.src = optionIcon.src;
                }
                if (bulkActions) bulkActions.style.visibility = "visible";
                if (claimedLoadMoreContainer) claimedLoadMoreContainer.style.visibility = "collapse";
                if (jackpotsPanel) jackpotsPanel.style.visibility = "collapse";
            } else {
                if (itemsPanel) itemsPanel.style.visibility = "collapse";
                if (claimedPanel) claimedPanel.style.visibility = (state.inventoryActiveTab === "jackpots" ? "collapse" : "visible");
                if (jackpotsPanel) jackpotsPanel.style.visibility = (state.inventoryActiveTab === "jackpots" ? "visible" : "collapse");
                if (state.inventoryActiveTab === "claimed_history") {
                    var optionHistory = root.FindChildTraverse("InventoryTabClaimedHistory");
                    if (dropdownText && optionHistory) {
                        var optionText = optionHistory.FindChildTraverse("custom-dropdown-option-text");
                        if (optionText) dropdownText.text = optionText.text;
                    }
                    if (dropdownIcon && optionHistory) {
                        var optionIcon = optionHistory.FindChildTraverse("custom-dropdown-option-icon");
                        if (optionIcon) dropdownIcon.src = optionIcon.src;
                    }
                } else if (state.inventoryActiveTab === "claimed") {
                    var optionClaimed = root.FindChildTraverse("InventoryTabClaimed");
                    if (dropdownText && optionClaimed) {
                        var optionText = optionClaimed.FindChildTraverse("custom-dropdown-option-text");
                        if (optionText) dropdownText.text = optionText.text;
                    }
                    if (dropdownIcon && optionClaimed) {
                        var optionIcon = optionClaimed.FindChildTraverse("custom-dropdown-option-icon");
                        if (optionIcon) dropdownIcon.src = optionIcon.src;
                    }
                } else if (state.inventoryActiveTab === "jackpots") {
                    var optionJackpots = root.FindChildTraverse("InventoryTabJackpots");
                    if (dropdownText && optionJackpots) {
                        var optionText = optionJackpots.FindChildTraverse("custom-dropdown-option-text");
                        if (optionText) dropdownText.text = optionText.text;
                    }
                    if (dropdownIcon && optionJackpots) {
                        var optionIcon = optionJackpots.FindChildTraverse("custom-dropdown-option-icon");
                        if (optionIcon) dropdownIcon.src = optionIcon.src;
                    }
                }
                if (bulkActions) bulkActions.style.visibility = "collapse";
                if (inventoryLoadMoreContainer) inventoryLoadMoreContainer.style.visibility = "collapse";
            }
        }
    }

    if (!state.inventoryVisibleCount) state.inventoryVisibleCount = 10;
    if (!state.claimedVisibleCount) state.claimedVisibleCount = 10;

    function createInventoryLoadMoreButton() {
        var root = $.GetContextPanel();
        if (!root) return;
        var loadMoreContainer = root.FindChildTraverse("InventoryLoadMoreContainer");
        if (!loadMoreContainer) return;
        
        var currentInv = shared.normalizeToArray(state.casinoData.inventory);
        
        loadMoreContainer.RemoveAndDeleteChildren();
        
        var inventoryHasMoreEffective = state.inventoryHasMore === true ||
            (state.inventoryTotalCount != null && !isNaN(state.inventoryTotalCount) && currentInv.length < state.inventoryTotalCount);
        
        if (inventoryHasMoreEffective && currentInv.length > 0) {
            loadMoreContainer.style.visibility = "visible";
            
            var btn = $.CreatePanel("Panel", loadMoreContainer, "InventoryLoadMoreButton");
            btn.AddClass("load-more-items-button");
            btn.AddClass("BSAButtonGoldSecondary");
            btn.acceptsfocus = false;
            
            var btnLabel = $.CreatePanel("Label", btn, "InventoryLoadMoreButtonLabel");
            btnLabel.AddClass("load-more-items-label");
            btnLabel.AddClass("BSAButtonLabelGold");
            btnLabel.text = "Загрузить еще";
            
            btn.SetPanelEvent("onactivate", function() {
                if (state.inventoryLoadMorePending) return;
                state.inventoryLoadMorePending = true;
                if (typeof GameUI !== "undefined" && GameUI.CasUiClickSound) GameUI.CasUiClickSound(); else Game.EmitSound("General.ButtonClick");
                if (btn.AddClass) btn.AddClass("load-more-button--loading");
                if (btnLabel) btnLabel.text = "Загрузка...";
                var inventoryBody = root.FindChildTraverse("InventoryItemsPanel");
                var scrollContainer = inventoryBody ? inventoryBody.GetParent() : null;
                var scrollTop = 0;
                if (scrollContainer && scrollContainer.GetScrollTop) {
                    scrollTop = scrollContainer.GetScrollTop();
                }
                
                var currentInv = shared.normalizeToArray(state.casinoData.inventory);
                var offset = currentInv.length;
                
                GameEvents.SendCustomGameEventToServer("casv2_load_inventory_paginated", {
                    status: "received",
                    offset: offset,
                    limit: 10
                });
                
                GameUI.LoopTime.Schedule(0.02, function() {
                    if (scrollContainer && scrollContainer.IsValid() && scrollContainer.SetScrollTop) {
                        scrollContainer.SetScrollTop(scrollTop);
                    }
                });
            });
        } else if (currentInv.length > 0 && !inventoryHasMoreEffective) {
            loadMoreContainer.style.visibility = "visible";
            var endMsg = $.CreatePanel("Label", loadMoreContainer, "InventoryLoadMoreEndMessage");
            endMsg.AddClass("load-more-end-message");
            endMsg.text = "Больше предметов нет";
        } else {
            loadMoreContainer.style.visibility = "collapse";
        }
    }

    function createClaimedLoadMoreButton() {
        var root = $.GetContextPanel();
        if (!root) return;
        var claimedLoadMoreContainer = root.FindChildTraverse("ClaimedLoadMoreContainer");
        if (!claimedLoadMoreContainer) return;
        
        var InventoryTabController = getFeature("InventoryTabController");
        var currentTab = InventoryTabController ? InventoryTabController.getTab() : state.inventoryActiveTab;
        
        if (currentTab === "items") currentTab = "new";
        else if (currentTab === "claimed_history") currentTab = "sold";
        
        var currentClaimed = shared.normalizeToArray(state.casinoData.claimed_history);
        var currentSold = shared.normalizeToArray(state.casinoData.sold_history);
        var currentHist = (currentTab === "sold") ? currentSold : currentClaimed;
        var hasMoreFromServer = (currentTab === "sold") ? (state.soldHasMore === true) : (state.claimedHasMore === true);
        var totalForTab = (currentTab === "sold") ? state.soldTotalCount : state.claimedTotalCount;
        var hasMoreForTab = hasMoreFromServer ||
            (totalForTab != null && !isNaN(totalForTab) && currentHist.length < totalForTab);
        
        claimedLoadMoreContainer.RemoveAndDeleteChildren();
        
        if (hasMoreForTab && currentHist.length > 0) {
            claimedLoadMoreContainer.style.visibility = "visible";
            
            var btnClaimed = $.CreatePanel("Panel", claimedLoadMoreContainer, "ClaimedLoadMoreButton");
            btnClaimed.AddClass("load-more-items-button");
            btnClaimed.AddClass("BSAButtonGoldSecondary");
            btnClaimed.acceptsfocus = false;
            
            var btnClaimedLabel = $.CreatePanel("Label", btnClaimed, "ClaimedLoadMoreButtonLabel");
            btnClaimedLabel.AddClass("load-more-items-label");
            btnClaimedLabel.AddClass("BSAButtonLabelGold");
            btnClaimedLabel.text = "Загрузить еще";
            
            btnClaimed.SetPanelEvent("onactivate", function() {
                if (state.inventoryLoadMorePending) return;
                state.inventoryLoadMorePending = true;
                if (typeof GameUI !== "undefined" && GameUI.CasUiClickSound) GameUI.CasUiClickSound(); else Game.EmitSound("General.ButtonClick");
                if (btnClaimed.AddClass) btnClaimed.AddClass("load-more-button--loading");
                if (btnClaimedLabel) btnClaimedLabel.text = "Загрузка...";
                var claimedPanel = root.FindChildTraverse("InventoryClaimedPanel");
                var scrollContainer = claimedPanel ? claimedPanel.GetParent() : null;
                var scrollTop = 0;
                if (scrollContainer && scrollContainer.GetScrollTop) {
                    scrollTop = scrollContainer.GetScrollTop();
                }
                
                var InventoryTabController = getFeature("InventoryTabController");
                var currentTab = InventoryTabController ? InventoryTabController.getTab() : state.inventoryActiveTab;
                
                if (currentTab === "items") currentTab = "new";
                else if (currentTab === "claimed_history") currentTab = "sold";
                
                var status = (currentTab === "sold") ? "exchanged" : "claimed";
                
                var currentClaimed = shared.normalizeToArray(state.casinoData.claimed_history);
                var currentSold = shared.normalizeToArray(state.casinoData.sold_history);
                var currentHist = (currentTab === "sold") ? currentSold : currentClaimed;
                var offset = currentHist.length;
                
                GameEvents.SendCustomGameEventToServer("casv2_load_inventory_paginated", {
                    status: status,
                    offset: offset,
                    limit: 10
                });
                
                GameUI.LoopTime.Schedule(0.02, function() {
                    if (scrollContainer && scrollContainer.IsValid() && scrollContainer.SetScrollTop) {
                        scrollContainer.SetScrollTop(scrollTop);
                    }
                });
            });
        } else if (currentHist.length > 0 && !hasMoreForTab) {
            claimedLoadMoreContainer.style.visibility = "visible";
            var endMsgClaimed = $.CreatePanel("Label", claimedLoadMoreContainer, "ClaimedLoadMoreEndMessage");
            endMsgClaimed.AddClass("load-more-end-message");
            endMsgClaimed.text = "Больше предметов нет";
        } else {
            claimedLoadMoreContainer.style.visibility = "collapse";
        }
    }

    function getDisplayPrice(item) {
        var value = (item.reward_value !== undefined && item.reward_value !== null) ? (item.reward_value | 0) : (item.price || 0) | 0;
        var currency = (item.reward_currency) ? String(item.reward_currency).toLowerCase() : (item.currency || "ruby");
        return { value: value, currency: currency };
    }

    function getCurrencyIconPath(currency) {
        var c = (currency != null && currency !== "") ? String(currency).toLowerCase() : "ruby";
        return (c === "ruby" || c === "crystal") ? "file://{images}/custom_game/currency_icon/currency_ruby_16x16.png" : "file://{images}/custom_game/currency_icon/currency_shield_16x16.png";
    }

    function mergeJackpotHistoryWithLocal(serverList) {
        var list = shared.normalizeToArray(serverList);
        if (!list.length) return [];
        var current = shared.normalizeToArray(state.casinoData && state.casinoData.jackpot_history);
        if (!current.length) return list;
        var merged = [];
        for (var s = 0; s < list.length; s++) {
            var serverItem = list[s];
            var useLocal = false;
            for (var c = 0; c < current.length; c++) {
                if (String(current[c].id) === String(serverItem.id) && (current[c].status === "exchanged" || current[c].status === "claimed")) {
                    merged.push(current[c]);
                    useLocal = true;
                    break;
                }
            }
            if (!useLocal) merged.push(serverItem);
        }
        return merged;
    }

    function loadInventoryItems() {
        var root = $.GetContextPanel();
        if (!root) return;
        var inv = shared.normalizeToArray(state.casinoData.inventory);
        var claimed = shared.normalizeToArray(state.casinoData.claimed_history);
        var sold = shared.normalizeToArray(state.casinoData.sold_history);
        var formatNumber = shared.formatNumber, formatTimeAgo = shared.formatTimeAgo;
        var sumRuby = 0, sumShield = 0;
        var totalsAll = state.casinoData && state.casinoData.inventory_sell_totals;
        if (totalsAll && (totalsAll.ruby !== undefined || totalsAll.shield !== undefined)) {
            sumRuby = Math.max(0, Math.floor(Number(totalsAll.ruby) || 0));
            sumShield = Math.max(0, Math.floor(Number(totalsAll.shield) || 0));
        } else {
            for (var i = 0; i < inv.length; i++) {
                var dp = getDisplayPrice(inv[i]);
                if (dp.currency === "ruby") sumRuby += dp.value;
                else sumShield += dp.value;
            }
        }
        var lblRuby = root.FindChildTraverse("InventorySellAllRubyVal");
        var lblShield = root.FindChildTraverse("InventorySellAllShieldVal");
        if (lblRuby) { lblRuby.text = formatNumber(sumRuby); var parent = lblRuby.GetParent(); if (parent) parent.visible = (sumRuby > 0); }
        if (lblShield) { lblShield.text = formatNumber(sumShield); var parent = lblShield.GetParent(); if (parent) parent.visible = (sumShield > 0); }
        var grid = root.FindChildTraverse("InventoryGrid");
        var emptyMsg = root.FindChildTraverse("InventoryEmptyMessage");
        if (grid) grid.RemoveAndDeleteChildren();
        if (emptyMsg) emptyMsg.visible = (inv.length === 0);
        
        for (var i = 0; i < inv.length; i++) {
            var it = inv[i];
            var card = $.CreatePanel("Panel", grid, "InvRow" + (it.id || i));
            card.BLoadLayoutSnippet(isJackpotItem(it.item_name) ? JACKPOT_ROW_SNIPPET : DEFAULT_INVENTORY_ROW_SNIPPET);
            var histChipNew = card.FindChildTraverse("InvRowHistChip");
            if (histChipNew) histChipNew.style.visibility = "collapse";
            var btnsNew = card.FindChildTraverse("InvRowItemButtons");
            if (btnsNew) btnsNew.style.visibility = "visible";
            var img = card.FindChildTraverse("InvRowItemImage");
            if (img) img.itemname = it.item_name || "";
            var lblName = card.FindChildTraverse("InvRowItemName");
            if (lblName) lblName.text = getItemDisplayName(it.item_name);
            var lblTime = card.FindChildTraverse("InvRowItemTime");
            if (lblTime) lblTime.text = formatTimeAgo(it.received_at);
            var dp = getDisplayPrice(it);
            var sellPrice = card.FindChildTraverse("InvRowSellPrice");
            if (sellPrice) sellPrice.text = formatNumber(dp.value);
            var sellCur = card.FindChildTraverse("InvRowSellCurrency");
            if (sellCur) sellCur.SetImage(getCurrencyIconPath(dp.currency));
            
            var btnSell = card.FindChildTraverse("InvRowBtnSell");
            if (btnSell) {
                btnSell.style.visibility = "visible";
                var canSell = (it.can_sell !== undefined) ? (it.can_sell !== false) : (it.can_claim !== false);
                btnSell.enabled = canSell;
                
                if (!canSell) {
                    btnSell.tooltip_text = $.Localize("#ui_casv2_item_already_processed");
                } else {
                    btnSell.tooltip_text = $.Localize("#ui_casv2_sell_for_currency");
                }
                
                btnSell.SetPanelEvent("onactivate", (function(cardPanel, id) { 
                    return function() { 
                        var now = Date.now();
                        if (state.lastSellClickTime && (now - state.lastSellClickTime) < 1000) return;
                        state.lastSellClickTime = now;
                        applySellCooldownVisual();
                        if (typeof GameUI !== "undefined" && GameUI.CasUiClickSound) GameUI.CasUiClickSound(); else Game.EmitSound("General.ButtonClick");
                        Game.EmitSound("cas.item_has_been_sold");
                        if (!state.pendingSellIds) state.pendingSellIds = [];
                        state.pendingSellIds.push(id);
                        if (cardPanel && cardPanel.IsValid()) cardPanel.DeleteAsync(0);
                        GameEvents.SendCustomGameEventToServer("casv2_sell_item", { inventory_id: id }); 
                    }; 
                })(card, it.id));
            }
            var btnClaim = card.FindChildTraverse("InvRowBtnClaim");
            if (btnClaim) {
                var isCrystalJackpot = (it.item_name === "item_crystal_jackpot");
                if (isCrystalJackpot) {
                    btnClaim.style.visibility = "collapse";
                } else {
                    btnClaim.style.visibility = "visible";
                    var canClaim = (it.can_claim !== false);
                    btnClaim.enabled = true;
                    if (canClaim) {
                        btnClaim.RemoveClass("Disabled");
                        btnClaim.style.opacity = "1";
                        btnClaim.style.washColor = "white";
                        btnClaim.tooltip_text = $.Localize("#ui_casv2_claim_to_inventory");
                    } else {
                        btnClaim.AddClass("Disabled");
                        btnClaim.style.opacity = "0.6";
                        btnClaim.style.washColor = "rgba(0,0,0,0.5)";
                        btnClaim.tooltip_text = $.Localize(CLAIM_ONLY_SELL_LOCALE);
                    }
                    btnClaim.SetPanelEvent("onactivate", (function(cardPanel, id, allowed) {
                        return function() {
                            if (!allowed) {
                                showClaimError();
                                return;
                            }
                            var now = Date.now();
                            if (state.lastClaimClickTime && (now - state.lastClaimClickTime) < 1000) return;
                            state.lastClaimClickTime = now;
                            applyClaimCooldownVisual();
                            if (typeof GameUI !== "undefined" && GameUI.CasUiClickSound) GameUI.CasUiClickSound(); else Game.EmitSound("General.ButtonClick");
                            Game.EmitSound("cas.item_collect");
                            if (!state.pendingClaimIds) state.pendingClaimIds = [];
                            state.pendingClaimIds.push(id);
                            if (cardPanel && cardPanel.IsValid()) cardPanel.DeleteAsync(0);
                            GameEvents.SendCustomGameEventToServer("casv2_claim_item", { inventory_id: id });
                        };
                    })(card, it.id, canClaim));
                }
            }
        }
        
        var InventoryTabController = getFeature("InventoryTabController");
        var currentTab = InventoryTabController ? InventoryTabController.getTab() : state.inventoryActiveTab;
        
        if (currentTab === "items") currentTab = "new";
        else if (currentTab === "claimed_history") currentTab = "sold";
        
        if (currentTab === "jackpots") {
            var jackpotGrid = root.FindChildTraverse("JackpotGrid");
            var jackpotEmpty = root.FindChildTraverse("JackpotEmptyMessage");
            if (jackpotGrid) jackpotGrid.RemoveAndDeleteChildren();
            var jackpotList = shared.normalizeToArray(state.casinoData.jackpot_history);
            if (jackpotEmpty) jackpotEmpty.visible = (jackpotList.length === 0);
            for (var j = 0; j < jackpotList.length; j++) {
                var jp = jackpotList[j];
                var cardJ = $.CreatePanel("Panel", jackpotGrid, "JackpotRow" + (jp.id || j));
                cardJ.BLoadLayoutSnippet(JACKPOT_ROW_SNIPPET);
                var rootJ = cardJ.FindChildTraverse("InvRowRoot");
                var isReceived = (jp.status === "received");
                var imgJ = cardJ.FindChildTraverse("InvRowItemImage");
                if (imgJ) imgJ.itemname = jp.item_name || "";
                var nameJ = cardJ.FindChildTraverse("InvRowItemName");
                if (nameJ) nameJ.text = getItemDisplayName(jp.item_name);
                var dpJ = { value: jp.reward_value || 0, currency: (jp.reward_currency || "ruby").toLowerCase() };

                if (isReceived) {
                    var btnsJ = cardJ.FindChildTraverse("InvRowItemButtons");
                    if (btnsJ) btnsJ.style.visibility = "visible";
                    var histChipJ = cardJ.FindChildTraverse("InvRowHistChip");
                    if (histChipJ) histChipJ.style.visibility = "collapse";
                    var lblTimeJ = cardJ.FindChildTraverse("InvRowItemTime");
                    if (lblTimeJ) lblTimeJ.text = "Новый • " + formatTimeAgo(jp.received_at);
                    var sellPriceJ = cardJ.FindChildTraverse("InvRowSellPrice");
                    if (sellPriceJ) sellPriceJ.text = formatNumber(dpJ.value);
                    var sellCurJ = cardJ.FindChildTraverse("InvRowSellCurrency");
                    if (sellCurJ) sellCurJ.SetImage(getCurrencyIconPath(dpJ.currency));
                    var btnSellJ = cardJ.FindChildTraverse("InvRowBtnSell");
                    if (btnSellJ) {
                        btnSellJ.style.visibility = "visible";
                        btnSellJ.enabled = true;
                        btnSellJ.tooltip_text = $.Localize("#ui_casv2_sell_for_currency");
                        btnSellJ.SetPanelEvent("onactivate", (function(jpItem) {
                            return function() {
                                var now = Date.now();
                                if (state.lastSellClickTime && (now - state.lastSellClickTime) < 1000) return;
                                state.lastSellClickTime = now;
                                if (typeof GameUI !== "undefined" && GameUI.CasUiClickSound) GameUI.CasUiClickSound(); else Game.EmitSound("General.ButtonClick");
                                Game.EmitSound("cas.item_has_been_sold");
                                var invId = jpItem.id;
                                if (!state.pendingSellIds) state.pendingSellIds = [];
                                state.pendingSellIds.push(invId);
                                var soldAtIso = new Date().toISOString();
                                jpItem.status = "exchanged";
                                jpItem.sold_at = soldAtIso;
                                var list = state.casinoData && state.casinoData.jackpot_history;
                                if (list && list.length) {
                                    for (var i = 0; i < list.length; i++) {
                                        if (String(list[i].id) === String(invId)) {
                                            list[i].status = "exchanged";
                                            list[i].sold_at = soldAtIso;
                                            break;
                                        }
                                    }
                                }
                                state.inventoryActiveTab = "jackpots";
                                loadInventoryItems();
                                applySellCooldownVisual();
                                GameEvents.SendCustomGameEventToServer("casv2_sell_item", { inventory_id: invId });
                            };
                        })(jp));
                    }
                    var btnClaimJ = cardJ.FindChildTraverse("InvRowBtnClaim");
                    if (btnClaimJ) {
                        if (jp.item_name === "item_crystal_jackpot") {
                            btnClaimJ.style.visibility = "collapse";
                        } else {
                            btnClaimJ.style.visibility = "visible";
                            var canClaimJ = (jp.can_claim !== false);
                            btnClaimJ.enabled = true;
                            if (canClaimJ) {
                                btnClaimJ.RemoveClass("Disabled");
                                btnClaimJ.style.opacity = "1";
                                btnClaimJ.style.washColor = "white";
                                btnClaimJ.tooltip_text = $.Localize("#ui_casv2_claim_to_inventory");
                            } else {
                                btnClaimJ.AddClass("Disabled");
                                btnClaimJ.style.opacity = "0.6";
                                btnClaimJ.style.washColor = "rgba(0,0,0,0.5)";
                                btnClaimJ.tooltip_text = $.Localize(CLAIM_ONLY_SELL_LOCALE);
                            }
                            btnClaimJ.SetPanelEvent("onactivate", (function(jpItem, allowed) {
                                return function() {
                                    if (!allowed) {
                                        showClaimError();
                                        return;
                                    }
                                    var now = Date.now();
                                    if (state.lastClaimClickTime && (now - state.lastClaimClickTime) < 1000) return;
                                    state.lastClaimClickTime = now;
                                    if (typeof GameUI !== "undefined" && GameUI.CasUiClickSound) GameUI.CasUiClickSound(); else Game.EmitSound("General.ButtonClick");
                                    Game.EmitSound("cas.item_collect");
                                    var invId = jpItem.id;
                                    if (!state.pendingClaimIds) state.pendingClaimIds = [];
                                    state.pendingClaimIds.push(invId);
                                    var claimedAtIso = new Date().toISOString();
                                    jpItem.status = "claimed";
                                    jpItem.claimed_at = claimedAtIso;
                                    var list = state.casinoData && state.casinoData.jackpot_history;
                                    if (list && list.length) {
                                        for (var idx = 0; idx < list.length; idx++) {
                                            if (String(list[idx].id) === String(invId)) {
                                                list[idx].status = "claimed";
                                                list[idx].claimed_at = claimedAtIso;
                                                break;
                                            }
                                        }
                                    }
                                    state.inventoryActiveTab = "jackpots";
                                    loadInventoryItems();
                                    applyClaimCooldownVisual();
                                    GameEvents.SendCustomGameEventToServer("casv2_claim_item", { inventory_id: invId });
                                };
                            })(jp, canClaimJ));
                        }
                    }
                } else {
                    if (rootJ) rootJ.AddClass("inventory-item-row--claimed");
                    var btnSellJ = cardJ.FindChildTraverse("InvRowBtnSell");
                    if (btnSellJ) btnSellJ.style.visibility = "collapse";
                    var btnClaimJ = cardJ.FindChildTraverse("InvRowBtnClaim");
                    if (btnClaimJ) btnClaimJ.style.visibility = "collapse";
                    var statusLabel = (jp.status === "claimed") ? "Получен" : "Продан";
                    var timeIsoJ = jp.claimed_at || jp.sold_at || jp.received_at;
                    var tJ = cardJ.FindChildTraverse("InvRowItemTime");
                    if (tJ) tJ.text = statusLabel + " • " + formatTimeAgo(timeIsoJ);
                    var histChipJ = cardJ.FindChildTraverse("InvRowHistChip");
                    if (histChipJ) histChipJ.style.visibility = "visible";
                    var histPriceJ = cardJ.FindChildTraverse("InvRowHistPrice");
                    if (histPriceJ) histPriceJ.text = formatNumber(dpJ.value);
                    var histCurJ = cardJ.FindChildTraverse("InvRowHistCurrency");
                    if (histCurJ) histCurJ.SetImage(getCurrencyIconPath(dpJ.currency));
                }
            }
        }
        
        if (currentTab === "new" && inv.length > 0) {
            createInventoryLoadMoreButton();
        } else {
            var loadMoreContainer = root.FindChildTraverse("InventoryLoadMoreContainer");
            if (loadMoreContainer) loadMoreContainer.style.visibility = "collapse";
        }
        var sellAllBtn = root.FindChildTraverse("InventorySellAll");
        var claimAllBtn = root.FindChildTraverse("InventoryClaimAll");
        if (sellAllBtn) {
            sellAllBtn.enabled = (inv.length > 0);
            if (inv.length > 0) {
                sellAllBtn.AddClass("inventory-btn-sell-all--amounts-only");
            } else {
                sellAllBtn.RemoveClass("inventory-btn-sell-all--amounts-only");
            }
        }
        var hasClaimable = false;
        for (var k = 0; k < inv.length; k++) {
            if (inv[k].item_name === "item_crystal_jackpot") continue;
            if (inv[k].can_claim !== false) { hasClaimable = true; break; }
        }
        if (claimAllBtn) claimAllBtn.enabled = hasClaimable;
        var claimedGrid = root.FindChildTraverse("ClaimedGrid");
        var claimedEmpty = root.FindChildTraverse("ClaimedEmptyMessage");
        if (claimedGrid) claimedGrid.RemoveAndDeleteChildren();
        
        var hist = (currentTab === "sold") ? sold : claimed;
        if (claimedEmpty) {
            claimedEmpty.visible = (currentTab === "jackpots" ? false : (hist.length === 0));
            claimedEmpty.text = (currentTab === "sold") ? "Нет проданных предметов" : "Нет полученных предметов";
        }
        
        if (currentTab !== "jackpots") for (var j = 0; j < hist.length; j++) {
            var c = hist[j];
            var cardC = $.CreatePanel("Panel", claimedGrid, "ClaimedRow" + (c.id || j));
            cardC.BLoadLayoutSnippet(isJackpotItem(c.item_name) ? JACKPOT_ROW_SNIPPET : DEFAULT_INVENTORY_ROW_SNIPPET);
            var rootC = cardC.FindChildTraverse("InvRowRoot");
            if (rootC) {
                rootC.AddClass("inventory-item-row--claimed");
                if (currentTab === "sold") rootC.AddClass("inventory-item-row--sold"); else rootC.AddClass("inventory-item-row--received");
            }
            var btnSellC = cardC.FindChildTraverse("InvRowBtnSell");
            if (btnSellC) btnSellC.style.visibility = "collapse";
            var btnClaimC = cardC.FindChildTraverse("InvRowBtnClaim");
            if (btnClaimC) btnClaimC.style.visibility = "collapse";
            var imgC = cardC.FindChildTraverse("InvRowItemImage");
            if (imgC) imgC.itemname = c.item_name || "";
            var nameC = cardC.FindChildTraverse("InvRowItemName");
            if (nameC) nameC.text = getItemDisplayName(c.item_name);
            var timeIso = (currentTab === "sold") ? c.sold_at : c.claimed_at;
            var tC = cardC.FindChildTraverse("InvRowItemTime");
            if (tC) tC.text = formatTimeAgo(timeIso);
            var histChip = cardC.FindChildTraverse("InvRowHistChip");
            if (histChip) histChip.style.visibility = "visible";
            var histPrice = cardC.FindChildTraverse("InvRowHistPrice");
            var histCur = cardC.FindChildTraverse("InvRowHistCurrency");
            if (currentTab === "sold") {
                var dpC = getDisplayPrice(c);
                if (histPrice) histPrice.text = formatNumber(dpC.value);
                if (histCur) histCur.SetImage(getCurrencyIconPath(dpC.currency));
            } else {
                if (histPrice) histPrice.style.visibility = "collapse";
                if (histCur) {
                    histCur.style.visibility = "visible";
                    histCur.SetImage(RECEIVED_ICON_PATH);
                    histCur.AddClass("inventory-item-row-hist-received-icon");
                }
            }
        }
        
        if ((currentTab === "sold" || currentTab === "claimed") && hist.length > 0) {
            createClaimedLoadMoreButton();
        } else {
            var claimedLoadMoreContainer = root.FindChildTraverse("ClaimedLoadMoreContainer");
            if (claimedLoadMoreContainer) claimedLoadMoreContainer.style.visibility = "collapse";
        }
        
        if (InventoryTabController) {
            InventoryTabController.refreshCurrentTab();
        } else {
            applyInventoryTab();
        }
    }

    function filterInventoryByPending(serverInventory) {
        var list = shared.normalizeToArray(serverInventory);
        var pendingSell = state.pendingSellIds || [];
        var pendingClaim = state.pendingClaimIds || [];
        function idInPending(id, pending) {
            var sid = String(id);
            for (var i = 0; i < pending.length; i++) if (String(pending[i]) === sid) return true;
            return false;
        }
        return list.filter(function(it) {
            var id = it.id;
            return !idInPending(id, pendingSell) && !idInPending(id, pendingClaim);
        });
    }

    function onCasinoSellResult(data) {
        if (!data) return;
        if (data.success) {
            if (state.pendingSellIds && state.pendingSellIds.length > 0) state.pendingSellIds.shift();
            state.casinoData.inventory = filterInventoryByPending(data.inventory || []);
            state.casinoData.claimed_history = shared.normalizeToArray(data.claimed_history);
            state.casinoData.sold_history = shared.normalizeToArray(data.sold_history);
            state.casinoData.sold_totals = data.sold_totals || { ruby: 0, shield: 0 };
            if (data.inventory_sell_totals !== undefined && data.inventory_sell_totals !== null) {
                state.casinoData.inventory_sell_totals = data.inventory_sell_totals || { ruby: 0, shield: 0 };
            }
            if (data.inventory_total !== undefined && data.inventory_total !== null) state.inventoryTotalCount = parseInt(data.inventory_total, 10);
            if (data.claimed_total !== undefined && data.claimed_total !== null) state.claimedTotalCount = parseInt(data.claimed_total, 10);
            if (data.sold_total !== undefined && data.sold_total !== null) state.soldTotalCount = parseInt(data.sold_total, 10);
            if (data.jackpot_history !== undefined) state.casinoData.jackpot_history = mergeJackpotHistoryWithLocal(data.jackpot_history || []);
            if (data.jackpot_total !== undefined && data.jackpot_total !== null) state.jackpotTotalCount = parseInt(data.jackpot_total, 10);
            if (data.inventory_has_more !== undefined) state.inventoryHasMore = data.inventory_has_more === true;
            if (data.claimed_has_more !== undefined) state.claimedHasMore = data.claimed_has_more === true;
            if (data.sold_has_more !== undefined) state.soldHasMore = data.sold_has_more === true;
            if (data.profile && casv2.updatePlayerProfile) casv2.updatePlayerProfile(data.profile);
            updateInventoryButtonText();
            loadInventoryItems();
            
            var InventoryTabController = getFeature("InventoryTabController");
            if (InventoryTabController) {
                InventoryTabController.refreshCurrentTab();
            }
        } else {
            if (state.pendingSellIds && state.pendingSellIds.length > 0) state.pendingSellIds.shift();
            var errMsg = data.message || data.error;
            if (errMsg) {
                var hud = getDotaHUD();
                if (hud && typeof hud.ShowError === "function") hud.ShowError(errMsg);
            }
            if (data.inventory && (data.inventory.length !== undefined || typeof data.inventory === "object")) {
                state.casinoData.inventory = filterInventoryByPending(data.inventory);
                updateInventoryButtonText();
                loadInventoryItems();
                var InventoryTabController = getFeature("InventoryTabController");
                if (InventoryTabController) InventoryTabController.refreshCurrentTab();
            } else {
                if (casv2.requestCasinoData) casv2.requestCasinoData();
            }
        }
    }

    function onCasinoClaimResult(data) {
        if (!data) return;
        if (data.success) {
            if (state.pendingClaimIds && state.pendingClaimIds.length > 0) state.pendingClaimIds.shift();
            state.casinoData.inventory = filterInventoryByPending(data.inventory || []);
            state.casinoData.claimed_history = shared.normalizeToArray(data.claimed_history);
            state.casinoData.sold_history = shared.normalizeToArray(data.sold_history);
            state.casinoData.sold_totals = data.sold_totals || { ruby: 0, shield: 0 };
            if (data.inventory_sell_totals !== undefined && data.inventory_sell_totals !== null) {
                state.casinoData.inventory_sell_totals = data.inventory_sell_totals || { ruby: 0, shield: 0 };
            }
            if (data.inventory_total !== undefined && data.inventory_total !== null) state.inventoryTotalCount = parseInt(data.inventory_total, 10);
            if (data.claimed_total !== undefined && data.claimed_total !== null) state.claimedTotalCount = parseInt(data.claimed_total, 10);
            if (data.sold_total !== undefined && data.sold_total !== null) state.soldTotalCount = parseInt(data.sold_total, 10);
            if (data.jackpot_history !== undefined) state.casinoData.jackpot_history = mergeJackpotHistoryWithLocal(data.jackpot_history || []);
            if (data.jackpot_total !== undefined && data.jackpot_total !== null) state.jackpotTotalCount = parseInt(data.jackpot_total, 10);
            if (data.inventory_has_more !== undefined) state.inventoryHasMore = data.inventory_has_more === true;
            if (data.claimed_has_more !== undefined) state.claimedHasMore = data.claimed_has_more === true;
            if (data.sold_has_more !== undefined) state.soldHasMore = data.sold_has_more === true;
            if (data.profile && casv2.updatePlayerProfile) casv2.updatePlayerProfile(data.profile);
            updateInventoryButtonText();
            loadInventoryItems();
            
            var InventoryTabController = getFeature("InventoryTabController");
            if (InventoryTabController) {
                InventoryTabController.refreshCurrentTab();
            }
        } else {
            if (state.pendingClaimIds && state.pendingClaimIds.length > 0) state.pendingClaimIds.shift();
            var errMsg = data.message || data.error;
            if (errMsg) {
                var hud = getDotaHUD();
                if (hud && typeof hud.ShowError === "function") hud.ShowError(errMsg);
            }
            if (data.inventory && (data.inventory.length !== undefined || typeof data.inventory === "object")) {
                state.casinoData.inventory = filterInventoryByPending(data.inventory);
                updateInventoryButtonText();
                loadInventoryItems();
                var InventoryTabController = getFeature("InventoryTabController");
                if (InventoryTabController) InventoryTabController.refreshCurrentTab();
            } else {
                if (casv2.requestCasinoData) casv2.requestCasinoData();
            }
        }
    }

    function createNotificationUI(data, isJackpot) {
        var rollHistoryId = (data && data.roll_history_id != null && data.roll_history_id !== "") ? data.roll_history_id : null;
        if (rollHistoryId != null && shownRollHistoryIds[rollHistoryId]) return;
        var cfg = GameUI.CustomUIConfig();
        var mainPanel = (cfg && cfg.Casv2 && cfg.Casv2.main) ? cfg.Casv2.main : (casv2 && casv2.main);
        if (!mainPanel || !mainPanel.IsValid()) {
            mainPanel = $.GetContextPanel();
        }
        if (!mainPanel || !mainPanel.IsValid()) {
            return;
        }
        mainPanel.visible = true;
        mainPanel.style.visibility = "visible";
        var notifContainer = mainPanel.FindChildTraverse("CasinoNotificationsContainer");
        if (notifContainer) {
            notifContainer.visible = true;
            notifContainer.style.visibility = "visible";
        }
        var list = mainPanel.FindChildTraverse("CasinoNotificationsList");
        if (!list) {
            return;
        }
        var noHero = !!(data && data.no_hero);
        var steamid = (data && data.steamid) ? String(data.steamid) : "0";
        var heroname = (data && data.heroname) ? String(data.heroname) : "npc_dota_hero_axe";
        var itemName = (data && data.item_name) ? String(data.item_name) : "item_branches";
        var titleText = isJackpot
            ? ($.Localize ? $.Localize("#ui_casv2_jackpot_win_inscription") : "Игрок выиграл джекпот!")
            : ((data && data.title) ? String(data.title) : "Игрок выиграл!");
        if (rollHistoryId != null) shownRollHistoryIds[rollHistoryId] = true;
        if (list.GetChildCount() >= NOTIFICATION_MAX_COUNT) {
            var oldest = list.GetChild(list.GetChildCount() - 1);
            var inner = oldest.GetChild(0);
            if (inner) inner.AddClass("hiding");
            GameUI.LoopTime.Schedule(NOTIFICATION_HIDE_ANIM_SEC, function() { if (oldest && oldest.IsValid()) oldest.DeleteAsync(0); });
        }
        var id = (isJackpot ? "jackpot_win_" : "ally_win_") + Date.now() + "_" + Math.floor(Math.random() * 10000);
        var snippetName = isJackpot ? "jackpot_win_notification" : (noHero ? "ally_win_notification_no_hero" : "ally_win_notification");
        var wrap = $.CreatePanel("Panel", list, id);
        if (wrap.BLoadLayoutSnippet(snippetName) === false) return;
        if (isJackpot && typeof Game !== "undefined" && Game.EmitSound) {
            Game.EmitSound("cas.jackpot_win_notification");
        }
        var card = wrap.GetChild(0);
        if (!card) return;
        var avatarId = isJackpot ? "JackpotWinNotifAvatar" : "AllyWinNotifAvatar";
        var heroId = isJackpot ? "JackpotWinNotifHero" : "AllyWinNotifHero";
        var itemId = isJackpot ? "JackpotWinNotifItem" : "AllyWinNotifItem";
        var nameId = isJackpot ? "JackpotWinNotifName" : "AllyWinNotifName";
        var titleId = isJackpot ? "JackpotWinNotifTitle" : "AllyWinNotifTitle";
        var avatar = wrap.FindChildTraverse(avatarId);
        var hero = wrap.FindChildTraverse(heroId);
        var item = wrap.FindChildTraverse(itemId);
        var name = wrap.FindChildTraverse(nameId);
        var titleEl = wrap.FindChildTraverse(titleId);
        if (avatar) avatar.steamid = steamid;
        if (item) item.itemname = itemName;
        if (name) name.steamid = steamid;
        if (titleEl) titleEl.text = titleText;
        var itemNameEl = wrap.FindChildTraverse("JackpotWinNotifItemName");
        if (itemNameEl) itemNameEl.text = getItemDisplayName(itemName);
        var rewardValue = 0;
        var rewardCurrency = "ruby";
        if (data) {
            var rawVal = (data.reward_value !== undefined && data.reward_value !== null) ? data.reward_value : data.value;
            rewardValue = (rawVal !== undefined && rawVal !== null) ? (Number(rawVal) | 0) : 0;
            var rawCur = data.reward_currency || data.currency;
            rewardCurrency = (rawCur !== undefined && rawCur !== null && rawCur !== "") ? String(rawCur).toLowerCase() : "ruby";
        }
        var priceWrapId = isJackpot ? "JackpotWinNotifPriceWrap" : "AllyWinNotifPriceWrap";
        var priceLabelId = isJackpot ? "JackpotWinNotifPrice" : "AllyWinNotifPrice";
        var priceIconId = isJackpot ? "JackpotWinNotifCurrency" : "AllyWinNotifCurrency";
        var priceWrap = wrap.FindChildTraverse(priceWrapId);
        var priceLabel = wrap.FindChildTraverse(priceLabelId);
        var priceIcon = wrap.FindChildTraverse(priceIconId);
        if (priceWrap && priceLabel && priceIcon) {
            var showPrice = isJackpot || rewardValue > 0 || rewardCurrency;
            if (showPrice) {
                priceWrap.visible = true;
                priceLabel.text = shared.formatNumber ? shared.formatNumber(rewardValue) : String(rewardValue);
                var iconPath = getCurrencyIconPath(rewardCurrency);
                if (typeof priceIcon.SetImage === "function") priceIcon.SetImage(iconPath); else priceIcon.src = iconPath;
            } else {
                priceWrap.visible = false;
            }
        }
        if (list.GetChildCount() > 1) list.MoveChildBefore(wrap, list.GetChild(0));
        var heroPanel = hero;
        var heroNameVal = heroname;
        GameUI.LoopTime.Schedule(0, function() {
            if (wrap && wrap.IsValid()) {
                if (heroPanel && heroPanel.IsValid() && heroNameVal) heroPanel.heroname = heroNameVal;
                wrap.AddClass("visible");
                if (card && card.IsValid()) card.AddClass("visible");
                if (mainPanel && mainPanel.IsValid()) {
                    mainPanel.visible = true;
                    mainPanel.style.visibility = "visible";
                }
            }
        });
        var durationSec = isJackpot ? NOTIFICATION_JACKPOT_DURATION_SEC : NOTIFICATION_DURATION_SEC;
        GameUI.LoopTime.Schedule(durationSec, function() {
            if (!wrap.IsValid()) return;
            if (card && card.IsValid()) card.AddClass("hiding");
            GameUI.LoopTime.Schedule(NOTIFICATION_HIDE_ANIM_SEC, function() { if (wrap && wrap.IsValid()) wrap.DeleteAsync(0); });
        });
    }

    function showWinNotification(data) {
        if (!data || (!data.steamid && !data.item_name)) return;
        createNotificationUI(data || {}, false);
    }

    function showJackpotNotification(data) {
        if (!data || (!data.steamid && !data.item_name)) return;
        createNotificationUI(data || {}, true);
    }

    function onRecentJackpots() {
        var payload = (arguments.length > 1 && arguments[1] && (arguments[1].jackpots || arguments[1].Jackpots)) ? arguments[1] : arguments[0];
        if (!payload || (typeof payload !== "object")) return;
        var raw = payload.jackpots || payload.Jackpots || [];
        var jackpots = Array.isArray(raw) ? raw : (typeof raw === "object" && raw !== null ? Object.keys(raw).map(function(k) { return raw[k]; }) : []);
        var localSteamid = "0";
        try {
            var localInfo = Game.GetPlayerInfo && Game.GetLocalPlayerID !== undefined ? Game.GetPlayerInfo(Game.GetLocalPlayerID()) : null;
            if (localInfo && localInfo.player_steamid) localSteamid = String(localInfo.player_steamid);
        } catch (e) {}
        var cd = state.casinoData || {};
        var showRecentJackpotToWinner = cd.notify_show_recent_jackpot_to_winner !== false;
        for (var i = 0; i < jackpots.length; i++) {
            var j = jackpots[i];
            var rid = j.roll_history_id != null ? j.roll_history_id : null;
            var winnerSteamid = (j.steamid != null && j.steamid !== "") ? String(j.steamid) : "0";
            if (!showRecentJackpotToWinner && winnerSteamid === localSteamid) continue;
            var skipOwnAlreadyShown = !showRecentJackpotToWinner && (rid != null && shownRollHistoryIds[rid] && winnerSteamid === localSteamid);
            if (rid != null && (shownRecentJackpotIds[rid] || skipOwnAlreadyShown)) {
                continue;
            }
            if (rid != null) shownRecentJackpotIds[rid] = true;
            GameUI.LoopTime.Schedule(0, function(jackpotEntry) {
                showJackpotNotification({
                    steamid: jackpotEntry.steamid || "0",
                    item_name: jackpotEntry.item_name || "item_branches",
                    title: "Джекпот!",
                    heroname: jackpotEntry.heroname || "npc_dota_hero_axe",
                    roll_history_id: jackpotEntry.roll_history_id != null ? jackpotEntry.roll_history_id : null,
                    reward_value: jackpotEntry.reward_value,
                    reward_currency: jackpotEntry.reward_currency
                });
            }.bind(null, j));
        }
    }

    function onCasinoInventoryPaginated(data) {
        state.inventoryLoadMorePending = false;
        if (!data || !data.success) return;
        
        var root = $.GetContextPanel();
        if (!root) return;
        
        var items = shared.normalizeToArray(data.items || []);
        var status = data.status || "received";
        var hasMore = data.has_more || false;
        var totalCount = (data.total_count !== undefined && data.total_count !== null) ? parseInt(data.total_count, 10) : null;
        if (data.inventory_sell_totals !== undefined && data.inventory_sell_totals !== null) {
            state.casinoData.inventory_sell_totals = data.inventory_sell_totals || { ruby: 0, shield: 0 };
        }
        
        if (status === "received") {
            state.inventoryHasMore = hasMore;
            if (totalCount !== null && !isNaN(totalCount)) state.inventoryTotalCount = totalCount;
        } else if (status === "claimed") {
            state.claimedHasMore = hasMore;
            if (totalCount !== null && !isNaN(totalCount)) state.claimedTotalCount = totalCount;
        } else if (status === "exchanged") {
            state.soldHasMore = hasMore;
            if (totalCount !== null && !isNaN(totalCount)) state.soldTotalCount = totalCount;
        }
        
        if (items.length === 0) {
            GameUI.LoopTime.Schedule(0.01, function() {
                if (status === "received") createInventoryLoadMoreButton();
                else createClaimedLoadMoreButton();
            });
            return;
        }
        
        if (status === "received") {
            var currentInv = shared.normalizeToArray(state.casinoData.inventory || []);
            var existingIds = {};
            for (var i = 0; i < currentInv.length; i++) { if (currentInv[i].id) existingIds[currentInv[i].id] = true; }
            for (var j = 0; j < items.length; j++) {
                if (!items[j].id || !existingIds[items[j].id]) {
                    currentInv.push(items[j]);
                    if (items[j].id) existingIds[items[j].id] = true;
                }
            }
            state.casinoData.inventory = currentInv;
            
            var grid = root.FindChildTraverse("InventoryGrid");
            if (grid) {
                var formatNumber = shared.formatNumber;
                for (var k = 0; k < items.length; k++) {
                    var it = items[k];
                    if (!it) continue;
                    
                    var card = $.CreatePanel("Panel", grid, "InvRow" + (it.id || ("paginated_" + k)));
                    card.BLoadLayoutSnippet(isJackpotItem(it.item_name) ? JACKPOT_ROW_SNIPPET : DEFAULT_INVENTORY_ROW_SNIPPET);
                    var histChipNew = card.FindChildTraverse("InvRowHistChip");
                    if (histChipNew) histChipNew.style.visibility = "collapse";
                    var btnsNew = card.FindChildTraverse("InvRowItemButtons");
                    if (btnsNew) btnsNew.style.visibility = "visible";
                    var imgNew = card.FindChildTraverse("InvRowItemImage");
                    if (imgNew) imgNew.itemname = it.item_name || "";
                    var nameNew = card.FindChildTraverse("InvRowItemName");
                    if (nameNew) nameNew.text = getItemDisplayName(it.item_name);
                    var timeNew = card.FindChildTraverse("InvRowItemTime");
                    if (timeNew) timeNew.text = shared.formatTimeAgo(it.received_at);
                    var dpNew = getDisplayPrice(it);
                    var sellPriceNew = card.FindChildTraverse("InvRowSellPrice");
                    if (sellPriceNew) sellPriceNew.text = formatNumber(dpNew.value);
                    var sellCurNew = card.FindChildTraverse("InvRowSellCurrency");
                    if (sellCurNew) sellCurNew.SetImage(getCurrencyIconPath(dpNew.currency));
                    var btnSellNew = card.FindChildTraverse("InvRowBtnSell");
                    if (btnSellNew) {
                        var canSellNew = (it.can_sell !== undefined) ? (it.can_sell !== false) : (it.can_claim !== false);
                        btnSellNew.enabled = canSellNew;
                        btnSellNew.tooltip_text = canSellNew ? $.Localize("#ui_casv2_sell_for_currency") : $.Localize("#ui_casv2_item_already_processed");
                        
                        btnSellNew.SetPanelEvent("onactivate", (function(cardPanel, itemId) {
                            return function() {
                                var now = Date.now();
                                if (state.lastSellClickTime && (now - state.lastSellClickTime) < 1000) return;
                                state.lastSellClickTime = now;
                                applySellCooldownVisual();
                                if (typeof GameUI !== "undefined" && GameUI.CasUiClickSound) GameUI.CasUiClickSound(); else Game.EmitSound("General.ButtonClick");
                                Game.EmitSound("cas.item_has_been_sold");
                                if (!state.pendingSellIds) state.pendingSellIds = [];
                                state.pendingSellIds.push(itemId);
                                if (cardPanel && cardPanel.IsValid()) cardPanel.DeleteAsync(0);
                                GameEvents.SendCustomGameEventToServer("casv2_sell_item", { inventory_id: itemId });
                            };
                        })(card, it.id));
                    }
                    var btnClaimNew = card.FindChildTraverse("InvRowBtnClaim");
                    if (btnClaimNew) {
                        if (it.item_name === "item_crystal_jackpot") {
                            btnClaimNew.style.visibility = "collapse";
                        } else {
                            var canClaimNew = (it.can_claim !== false);
                            btnClaimNew.enabled = true;
                            if (canClaimNew) {
                                btnClaimNew.RemoveClass("Disabled");
                                btnClaimNew.style.opacity = "1";
                                btnClaimNew.style.washColor = "white";
                                btnClaimNew.tooltip_text = $.Localize("#ui_casv2_claim_to_inventory");
                            } else {
                                btnClaimNew.AddClass("Disabled");
                                btnClaimNew.style.opacity = "0.6";
                                btnClaimNew.style.washColor = "rgba(0,0,0,0.5)";
                                btnClaimNew.tooltip_text = $.Localize(CLAIM_ONLY_SELL_LOCALE);
                            }
                            btnClaimNew.SetPanelEvent("onactivate", (function(cardPanel, itemId, allowed) {
                                return function() {
                                    if (!allowed) {
                                        showClaimError();
                                        return;
                                    }
                                    var now = Date.now();
                                    if (state.lastClaimClickTime && (now - state.lastClaimClickTime) < 1000) return;
                                    state.lastClaimClickTime = now;
                                    applyClaimCooldownVisual();
                                    if (typeof GameUI !== "undefined" && GameUI.CasUiClickSound) GameUI.CasUiClickSound(); else Game.EmitSound("General.ButtonClick");
                                    Game.EmitSound("cas.item_collect");
                                    if (!state.pendingClaimIds) state.pendingClaimIds = [];
                                    state.pendingClaimIds.push(itemId);
                                    if (cardPanel && cardPanel.IsValid()) cardPanel.DeleteAsync(0);
                                    GameEvents.SendCustomGameEventToServer("casv2_claim_item", { inventory_id: itemId });
                                };
                            })(card, it.id, canClaimNew));
                        }
                    }
                    card.style.visibility = "visible";
                }
            }
            GameUI.LoopTime.Schedule(0.01, function() { createInventoryLoadMoreButton(); });
        } else if (status === "claimed" || status === "exchanged") {
            var currentClaimed = shared.normalizeToArray(state.casinoData.claimed_history || []);
            var currentSold = shared.normalizeToArray(state.casinoData.sold_history || []);
            
            if (status === "claimed") {
                var existingClaimedIds = {};
                for (var i = 0; i < currentClaimed.length; i++) { if (currentClaimed[i].id) existingClaimedIds[currentClaimed[i].id] = true; }
                for (var j = 0; j < items.length; j++) { if (!items[j].id || !existingClaimedIds[items[j].id]) currentClaimed.push(items[j]); }
                state.casinoData.claimed_history = currentClaimed;
            } else {
                var existingSoldIds = {};
                for (var i = 0; i < currentSold.length; i++) { if (currentSold[i].id) existingSoldIds[currentSold[i].id] = true; }
                for (var j = 0; j < items.length; j++) { if (!items[j].id || !existingSoldIds[items[j].id]) currentSold.push(items[j]); }
                state.casinoData.sold_history = currentSold;
            }
            
            var claimedGrid = root.FindChildTraverse("ClaimedGrid");
            if (claimedGrid) {
                var formatNumber = shared.formatNumber;
                var formatTimeAgo = shared.formatTimeAgo;
                var InventoryTabController = getFeature("InventoryTabController");
                var currentTab = InventoryTabController ? InventoryTabController.getTab() : state.inventoryActiveTab;
                
                if (currentTab === "items") currentTab = "new";
                else if (currentTab === "claimed_history") currentTab = "sold";
                
                var currentHist = (currentTab === "sold") ? currentSold : currentClaimed;
                var startIndex = currentHist.length - items.length;
                
                for (var k = 0; k < items.length; k++) {
                    var c = items[k];
                    if (!c) continue;
                    
                    var cardC = $.CreatePanel("Panel", claimedGrid, "ClaimedRow" + (c.id || (startIndex + k)));
                    cardC.BLoadLayoutSnippet(isJackpotItem(c.item_name) ? JACKPOT_ROW_SNIPPET : DEFAULT_INVENTORY_ROW_SNIPPET);
                    var rootC = cardC.FindChildTraverse("InvRowRoot");
                    if (rootC) {
                        rootC.AddClass("inventory-item-row--claimed");
                        if (currentTab === "sold") rootC.AddClass("inventory-item-row--sold"); else rootC.AddClass("inventory-item-row--received");
                    }
                    var btnSellC = cardC.FindChildTraverse("InvRowBtnSell");
                    if (btnSellC) btnSellC.style.visibility = "collapse";
                    var btnClaimC = cardC.FindChildTraverse("InvRowBtnClaim");
                    if (btnClaimC) btnClaimC.style.visibility = "collapse";
                    var imgC = cardC.FindChildTraverse("InvRowItemImage");
                    if (imgC) imgC.itemname = c.item_name || "";
                    var nameC = cardC.FindChildTraverse("InvRowItemName");
                    if (nameC) nameC.text = getItemDisplayName(c.item_name);
                    
                    var timeIso = (currentTab === "sold") ? c.sold_at : c.claimed_at;
                    var tC = cardC.FindChildTraverse("InvRowItemTime");
                    if (tC) tC.text = formatTimeAgo(timeIso);
                    var histChip = cardC.FindChildTraverse("InvRowHistChip");
                    if (histChip) histChip.style.visibility = "visible";
                    var histPrice = cardC.FindChildTraverse("InvRowHistPrice");
                    var histCur = cardC.FindChildTraverse("InvRowHistCurrency");
                    if (currentTab === "sold") {
                        var dpPag = getDisplayPrice(c);
                        if (histPrice) histPrice.text = formatNumber(dpPag.value);
                        if (histCur) histCur.SetImage(getCurrencyIconPath(dpPag.currency));
                    } else {
                        if (histPrice) histPrice.style.visibility = "collapse";
                        if (histCur) {
                            histCur.style.visibility = "visible";
                            histCur.SetImage(RECEIVED_ICON_PATH);
                            histCur.AddClass("inventory-item-row-hist-received-icon");
                        }
                    }
                    cardC.style.visibility = "visible";
                }
            }
            GameUI.LoopTime.Schedule(0.01, function() { createClaimedLoadMoreButton(); });
        }
    }

    casv2.historyInventory = {
        loadMoreHistory: loadMoreHistory,
        loadInventoryItems: loadInventoryItems,
        updateInventoryButtonText: updateInventoryButtonText,
        updateHistoryDisplay: updateHistoryDisplay,
        updateLoadMoreButtonVisibility: updateLoadMoreButtonVisibility,
        mergeJackpotHistoryWithLocal: mergeJackpotHistoryWithLocal
    };

    GameEvents.Subscribe("casv2_history", onCasinoHistoryReceived);
    GameEvents.Subscribe("casv2_sell_result", onCasinoSellResult);
    GameEvents.Subscribe("casv2_claim_result", onCasinoClaimResult);
    GameEvents.Subscribe("casv2_show_win_notification", showWinNotification);
    GameEvents.Subscribe("casv2_show_jackpot_notification", showJackpotNotification);
    GameEvents.Subscribe("casv2_recent_jackpots", onRecentJackpots);
    GameEvents.Subscribe("casv2_inventory_paginated", onCasinoInventoryPaginated);
})();