--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


// Точка входа казино: кнопки, ставки, вкладки инвентаря, подписка на casv2_data / casino_spin_result.
function getFeature(name) {
    var features = GameUI.CustomUIConfig().Casv2Features;
    return features && features[name] || null;
}

function casUiClickSound() { try { Game.EmitSound("General.ButtonClick"); } catch (e) { Game.EmitSound("ui_generic_button_click"); } }
function casUiHoverSound() { Game.EmitSound("ui_generic_button_hover"); }
if (typeof GameUI !== "undefined") { GameUI.CasUiClickSound = casUiClickSound; GameUI.CasUiHoverSound = casUiHoverSound; }

function OnCustomDropdownToggle() {
    casUiClickSound();
    var root = $.GetContextPanel();
    if (!root) return;
    var dropdownMenu = root.FindChildTraverse("InventoryTabDropdownMenu");
    if (!dropdownMenu || !dropdownMenu.IsValid()) return;
    var dropdownText = root.FindChildTraverse("InventoryTabDropdownText");
    var isVisible = dropdownMenu.style.visibility === "visible";
    dropdownMenu.style.visibility = isVisible ? "collapse" : "visible";
    if (dropdownText && dropdownText.IsValid()) dropdownText.style.visibility = isVisible ? "visible" : "collapse";
}

function OnLevelUpClaimClick() {
    casUiClickSound();
    var shared = GameUI.CustomUIConfig().Casv2Shared;
    if (!shared || !shared.state) return;
    var profile = shared.state.casinoData && shared.state.casinoData.profile;
    var rewardId = profile && (profile.pending_reward_id !== undefined && profile.pending_reward_id !== null ? profile.pending_reward_id : null);
    if (rewardId == null) return;
    GameEvents.SendCustomGameEventToServer("casv2_claim_level_reward", { reward_id: rewardId });
}

function OnCustomDropdownSelect(tab, optionId) {
    casUiClickSound();
    var InventoryTabController = getFeature("InventoryTabController");
    if (InventoryTabController) {
        var root = $.GetContextPanel();
        if (root) {
            var dropdownMenu = root.FindChildTraverse("InventoryTabDropdownMenu");
            if (dropdownMenu && dropdownMenu.IsValid()) dropdownMenu.style.visibility = "collapse";
            var dropdownText = root.FindChildTraverse("InventoryTabDropdownText");
            if (dropdownText && dropdownText.IsValid()) dropdownText.style.visibility = "visible";
        }
        var mappedTab = tab;
        if (tab === "items") mappedTab = "new";
        else if (tab === "claimed_history") mappedTab = "sold";
        else if (tab === "jackpots") mappedTab = "jackpots";
        InventoryTabController.setActiveTab(mappedTab);
        if (root) {
            var meta = InventoryTabController.getTabMetadata ? InventoryTabController.getTabMetadata(mappedTab) : null;
            var iconPath = meta && meta.icon ? meta.icon : null;
            if (iconPath) {
                GameUI.LoopTime.Schedule(0, function() {
                    var r = $.GetContextPanel();
                    if (!r) return;
                    var dropdownIcon = r.FindChildTraverse("InventoryTabDropdownIcon");
                    if (dropdownIcon) {
                        if (typeof dropdownIcon.SetImage === "function") dropdownIcon.SetImage(iconPath);
                        else dropdownIcon.src = iconPath;
                    }
                });
            }
        }
    }
}

function setWinMessage(text, currency) {
    var root = $.GetContextPanel();
    if (!root || !text || text.length === 0) return;
    var winLabel = root.FindChildTraverse("WinMessageLabel");
    if (winLabel) { winLabel.text = text || ""; winLabel.RemoveClass("pop"); winLabel.AddClass("pop"); }
    var icon = root.FindChildTraverse("WinMessageCurrencyIcon");
    if (icon) {
        var isShield = (currency === "shield");
        var isRuby = (currency === "ruby" || currency === "crystal");
        if (isShield || isRuby) {
            var path = isShield ? "file://{images}/custom_game/currency_icon/currency_shield_32x32.png" : "file://{images}/custom_game/currency_icon/currency_ruby_32x32.png";
            if (typeof icon.SetImage === "function") icon.SetImage(path); else icon.src = path;
            icon.AddClass("visible");
        } else {
            icon.RemoveClass("visible");
        }
    }
}

(function() {
    "use strict";
    // Инициализация панели, обработчики (Play, ставки, автоспин, инвентарь), запрос данных при открытии.
    var mainPanel = $.GetContextPanel();
    if (!GameUI.CustomUIConfig().Casv2) GameUI.CustomUIConfig().Casv2 = {};
    GameUI.CustomUIConfig().Casv2.main = mainPanel;
    if (mainPanel) {
        mainPanel.visible = false;
        mainPanel.hittest = false;
        if (mainPanel.AddClass) mainPanel.AddClass("casino-closed");
        var economyInfoOverlayInit = mainPanel.FindChildTraverse("EconomyInfoOverlay");
        if (economyInfoOverlayInit) economyInfoOverlayInit.visible = false;
    }

    var dotaHud = GameUI.CustomUIConfig().DotaHUD;
    var shared = GameUI.CustomUIConfig().Casv2Shared;
    if (!shared || !shared.state) return;

    var state = shared.state;
    var FSM_STATE = shared.FSM_STATE;
    var transitionTo = shared.transitionTo;

    var casv2 = GameUI.CustomUIConfig().Casv2;
    
    var AutospinController = getFeature("AutospinController");
    var SpinFlow = getFeature("SpinFlow");
    var WindowLifecycle = getFeature("WindowLifecycle");

    dotaHud.windowControllers["casv2"] = {
        is_open: false,
        open: function() { 
            this.is_open = true;
            if (WindowLifecycle) WindowLifecycle.handleOpen(mainPanel, dotaHud); 
        },
        close: function() { 
            this.is_open = false;
            if (WindowLifecycle) WindowLifecycle.handleClose(); 
        }
    };
    dotaHud.ListenToMouseEvent(dotaHud.GetCloseWindowOnOutsideClick(mainPanel, "casv2"));
    
    if (mainPanel) { mainPanel.visible = false; mainPanel.hittest = false; }
    if (WindowLifecycle) WindowLifecycle.handleClose(mainPanel);
    function forceClosed() {
        var ctrl = dotaHud && dotaHud.windowControllers && dotaHud.windowControllers["casv2"];
        if (ctrl && ctrl.is_open) return;
        if (mainPanel && mainPanel.IsValid && mainPanel.IsValid()) {
            mainPanel.visible = false;
            mainPanel.hittest = false;
            if (mainPanel.AddClass) mainPanel.AddClass("casino-closed");
        }
        if (WindowLifecycle) WindowLifecycle.handleClose(mainPanel);
    }
    GameUI.LoopTime.Schedule(0, forceClosed);
    GameUI.LoopTime.Schedule(0.15, forceClosed);
    GameUI.LoopTime.Schedule(0.5, forceClosed);
    GameUI.LoopTime.Schedule(1.0, forceClosed);

    function initialize() {
        if (state.initialized) return;
        setupEventHandlers();
        var sh = GameUI.CustomUIConfig().SpaceKeyHandler;
        if (sh && sh.register) {
            sh.register(function() { 
                if (AutospinController) AutospinController.onPlayClick();
            }, function() { return mainPanel && mainPanel.visible; });
        }
        if (sh && sh.registerArrows) sh.registerArrows({ up: cycleBetNext, down: cycleBetPrev });
        state.initialized = true;
    }

    function setupEventHandlers() {
        var root = $.GetContextPanel();
        if (!root && casv2 && casv2.main) root = casv2.main;
        if (!root) { GameUI.LoopTime.Schedule(0.1, setupEventHandlers); return; }
        
        dotaHud.CreateTopBarButton("file://{images}/shop/cas.png", "casino", function() { if (dotaHud) dotaHud.WindowOpen("casv2"); }, "ui_casv2_casino_btn_tooltip");

        var economyInfoOverlay = root.FindChildTraverse("EconomyInfoOverlay");
        var closeBtn = root.FindChildTraverse("CasinoCloseButton");
        if (closeBtn) closeBtn.SetPanelEvent("onactivate", function() {
            casUiClickSound();
            if (economyInfoOverlay) economyInfoOverlay.visible = false;
            if (dotaHud) dotaHud.WindowClose("casv2");
        });

        var infoBtn = root.FindChildTraverse("InfoButton");
        var economyInfoCloseBtn = root.FindChildTraverse("EconomyInfoCloseButton");
        var instructionPages = [
            root.FindChildTraverse("InstructionPage0"),
            root.FindChildTraverse("InstructionPage1"),
            root.FindChildTraverse("InstructionPage2"),
            root.FindChildTraverse("InstructionPage3"),
            root.FindChildTraverse("InstructionPage4")
        ];
        var instructionPageIndicator = root.FindChildTraverse("InstructionPageIndicator");
        var instructionPrevBtn = root.FindChildTraverse("InstructionCarouselPrev");
        var instructionNextBtn = root.FindChildTraverse("InstructionCarouselNext");
        var instructionCurrentPage = 0;
        var instructionTotalPages = 5;

        function setInstructionPage(index) {
            if (index < 0 || index >= instructionTotalPages) return;
            instructionCurrentPage = index;
            for (var i = 0; i < instructionTotalPages; i++) {
                var p = instructionPages[i];
                if (p) {
                    if (i === index) p.RemoveClass("instruction-page--hidden");
                    else p.AddClass("instruction-page--hidden");
                }
            }
            if (instructionPageIndicator) instructionPageIndicator.text = (index + 1) + $.Localize("#ui_casv2_inst_page_sep") + instructionTotalPages;
            if (instructionPrevBtn) instructionPrevBtn.enabled = index > 0;
            if (instructionNextBtn) instructionNextBtn.enabled = index < instructionTotalPages - 1;
        }

        if (infoBtn && economyInfoOverlay) {
            infoBtn.SetPanelEvent("onactivate", function() {
                casUiClickSound();
                economyInfoOverlay.visible = true;
                setInstructionPage(0);
            });
        }
        if (economyInfoCloseBtn && economyInfoOverlay) {
            economyInfoCloseBtn.SetPanelEvent("onactivate", function() {
                casUiClickSound();
                economyInfoOverlay.visible = false;
            });
        }
        var economyInfoBackdrop = root.FindChildTraverse("EconomyInfoBackdrop");
        if (economyInfoBackdrop && economyInfoOverlay) {
            economyInfoBackdrop.SetPanelEvent("onactivate", function() {
                economyInfoOverlay.visible = false;
            });
        }
        if (economyInfoOverlay && dotaHud) {
            var economyInfoModal = economyInfoOverlay.GetChildCount() > 1 ? economyInfoOverlay.GetChild(1) : economyInfoOverlay.GetChild(0);
            var panelToCheck = (economyInfoModal && economyInfoModal.IsValid && economyInfoModal.IsValid()) ? economyInfoModal : economyInfoOverlay;
            dotaHud.ListenToMouseEvent(dotaHud.GetCloseWindowOnOutsideClick(panelToCheck, function() {
                if (economyInfoOverlay && economyInfoOverlay.IsValid && economyInfoOverlay.IsValid() && economyInfoOverlay.visible) {
                    economyInfoOverlay.visible = false;
                }
            }));
        }
        if (instructionPrevBtn) {
            instructionPrevBtn.SetPanelEvent("onactivate", function() {
                casUiClickSound();
                setInstructionPage(instructionCurrentPage - 1);
            });
        }
        if (instructionNextBtn) {
            instructionNextBtn.SetPanelEvent("onactivate", function() {
                casUiClickSound();
                setInstructionPage(instructionCurrentPage + 1);
            });
        }
        setInstructionPage(0);
        if (economyInfoOverlay) economyInfoOverlay.visible = false;

        var playBtn = root.FindChildTraverse("PlayButton");
        if (playBtn) {
            playBtn.SetPanelEvent("onactivate", function() {
                casUiClickSound();
                if (playBtn.enabled && AutospinController) {
                    AutospinController.onPlayClick();
                }
            });
        }

        var modesBtn = root.FindChildTraverse("ModesButton");
        var modesPanel = root.FindChildTraverse("ModesPanel");
        var playPanel = root.FindChildTraverse("PlayPanel");
        if (modesBtn && modesPanel) {
            modesBtn.SetPanelEvent("onmouseover", function() { casUiHoverSound(); });
            modesBtn.SetPanelEvent("onactivate", function() {
                casUiClickSound();
                if (modesPanel.BHasClass("modes-panel--open")) {
                    modesPanel.RemoveClass("modes-panel--open");
                    if (playPanel) playPanel.RemoveClass("casino-panel--expanded");
                } else {
                    modesPanel.AddClass("modes-panel--open");
                    if (playPanel) playPanel.AddClass("casino-panel--expanded");
                }
            });
        }

        var speedBtn1 = root.FindChildTraverse("Speed1x"), speedBtn2 = root.FindChildTraverse("Speed2x"), speedBtn4 = root.FindChildTraverse("Speed4x"), speedBtnInf = root.FindChildTraverse("SpeedInf");
        if (speedBtn1) speedBtn1.SetPanelEvent("onactivate", function() { casUiClickSound(); setSpinSpeed(1); });
        if (speedBtn2) speedBtn2.SetPanelEvent("onactivate", function() { casUiClickSound(); setSpinSpeed(2); });
        if (speedBtn4) speedBtn4.SetPanelEvent("onactivate", function() { casUiClickSound(); setSpinSpeed(4); });
        if (speedBtnInf) speedBtnInf.SetPanelEvent("onactivate", function() { casUiClickSound(); setSpinSpeed("skip"); });
        setSpinSpeed(1);

        var asOff = root.FindChildTraverse("AutoSpinOff"), as10 = root.FindChildTraverse("AutoSpin10"), as25 = root.FindChildTraverse("AutoSpin25"), asInf = root.FindChildTraverse("AutoSpinInf");
        if (asOff) asOff.SetPanelEvent("onactivate", function() { casUiClickSound(); if (AutospinController) AutospinController.setAutospinMode("off"); });
        if (as10) as10.SetPanelEvent("onactivate", function() { casUiClickSound(); if (AutospinController) AutospinController.setAutospinMode(10); });
        if (as25) as25.SetPanelEvent("onactivate", function() { casUiClickSound(); if (AutospinController) AutospinController.setAutospinMode(25); });
        if (asInf) asInf.SetPanelEvent("onactivate", function() { casUiClickSound(); if (AutospinController) AutospinController.setAutospinMode("infinite"); });
        
        if (AutospinController) AutospinController.applyAutospinSelection();

        var tabShield = root.FindChildTraverse("TabShield"), tabCrystal = root.FindChildTraverse("TabCrystal");
        if (tabShield) tabShield.SetPanelEvent("onactivate", function() { casUiClickSound(); setSelectedCurrency("shield"); });
        if (tabCrystal) tabCrystal.SetPanelEvent("onactivate", function() { casUiClickSound(); setSelectedCurrency("crystal"); });

        var betCompactSwitch = root.FindChildTraverse("BetCompactSwitch");
        if (betCompactSwitch) {
            betCompactSwitch.SetPanelEvent("onactivate", function() {
                casUiClickSound();
                betCompactSwitch.AddClass("BetCompactSwitch--flash");
                setSelectedCurrency(state.selectedCurrency === "crystal" ? "shield" : "crystal");
                GameUI.LoopTime.Schedule(0.2, function() {
                    var r = $.GetContextPanel();
                    if (r) { var sw = r.FindChildTraverse("BetCompactSwitch"); if (sw) sw.RemoveClass("BetCompactSwitch--flash"); }
                });
            });
        }

        var betDec = root.FindChildTraverse("BetDecrease"), betInc = root.FindChildTraverse("BetIncrease");
        if (betDec) betDec.SetPanelEvent("onactivate", function() { casUiClickSound(); adjustBet(-1); });
        if (betInc) betInc.SetPanelEvent("onactivate", function() { casUiClickSound(); adjustBet(1); });
        
        if (!state.selectedCurrency) state.selectedCurrency = "shield";
        if (tabShield) { if (state.selectedCurrency === "shield") tabShield.AddClass("CurrencyTab--Active"); else tabShield.RemoveClass("CurrencyTab--Active"); }
        if (tabCrystal) { if (state.selectedCurrency === "crystal") tabCrystal.AddClass("CurrencyTab--Active"); else tabCrystal.RemoveClass("CurrencyTab--Active"); }
        updateBetCurrencyIcon(root, state.selectedCurrency);

        if (!state.fsmState) transitionTo(FSM_STATE.IDLE, "initialization");
        
        updateBetControlsState(root);
        if (AutospinController) AutospinController.updatePlayButton();

        var InventoryTabController = getFeature("InventoryTabController");
        if (InventoryTabController) {
            var currentTab = InventoryTabController.getTab();
            if (!currentTab || currentTab === "items" || currentTab === "claimed_history") InventoryTabController.setActiveTab("new");
        }

        var sellAllBtn = root.FindChildTraverse("InventorySellAll"), claimAllBtn = root.FindChildTraverse("InventoryClaimAll");
        if (sellAllBtn) sellAllBtn.SetPanelEvent("onactivate", function() {
            casUiClickSound();
            GameEvents.SendCustomGameEventToServer("casv2_sell_all", {});
        });
        if (claimAllBtn) claimAllBtn.SetPanelEvent("onactivate", function() {
            casUiClickSound();
            GameEvents.SendCustomGameEventToServer("casv2_claim_all", {});
        });

        if (casv2.historyInventory && casv2.historyInventory.updateInventoryButtonText) casv2.historyInventory.updateInventoryButtonText();
    }

    function setSpinSpeed(speed) {
        var root = $.GetContextPanel();
        if (!root) return;
        var speedBtn1 = root.FindChildTraverse("Speed1x"), speedBtn2 = root.FindChildTraverse("Speed2x"), speedBtn4 = root.FindChildTraverse("Speed4x"), speedBtnInf = root.FindChildTraverse("SpeedInf");
        if (speedBtn1) speedBtn1.RemoveClass("selected");
        if (speedBtn2) speedBtn2.RemoveClass("selected");
        if (speedBtn4) speedBtn4.RemoveClass("selected");
        if (speedBtnInf) speedBtnInf.RemoveClass("selected");
        var activeBtn = (speed === 1) ? speedBtn1 : (speed === 2) ? speedBtn2 : (speed === 4) ? speedBtn4 : (speed === "skip") ? speedBtnInf : null;
        if (activeBtn) activeBtn.AddClass("selected");
        if (state.selectedSpeed !== speed) {
            state.selectedSpeed = speed;
            if (speed === "skip" && state.fsmState === FSM_STATE.SPINNING && state.skipEnabled && SpinFlow) SpinFlow.skipAnimation();
        }
    }

    function getBetConfig() {
        return state.selectedCurrency === "shield" ? { min: 10, max: 160, step: 10 } : { min: 1, max: 10, step: 1 };
    }

    function adjustBet(delta) {
        if (!state.isDataReady) return;
        var cfg = getBetConfig();
        setSelectedBet(state.selectedBet + delta * cfg.step);
    }

    function updateBetCurrencyIcon(root, currency) {
        var path = currency === "shield" ? "file://{images}/custom_game/currency_icon/currency_shield_32x32.png" : "file://{images}/custom_game/currency_icon/currency_ruby_32x32.png";
        var icon = root && root.FindChildTraverse("BetValueCurrencyIcon");
        if (icon) { if (typeof icon.SetImage === "function") icon.SetImage(path); else icon.src = path; }
    }

    function setSelectedCurrency(currency) {
        if (state.selectedCurrency === currency || !state.isDataReady || state.fsmState === FSM_STATE.ANTICIPATION || state.fsmState === FSM_STATE.SPINNING) return;
        var root = $.GetContextPanel();
        if (!root) return;
        var tabShield = root.FindChildTraverse("TabShield"), tabCrystal = root.FindChildTraverse("TabCrystal");
        if (tabShield) { if (currency === "shield") tabShield.AddClass("CurrencyTab--Active"); else tabShield.RemoveClass("CurrencyTab--Active"); }
        if (tabCrystal) { if (currency === "crystal") tabCrystal.AddClass("CurrencyTab--Active"); else tabCrystal.RemoveClass("CurrencyTab--Active"); }
        state.selectedCurrency = currency;
        updateBetCurrencyIcon(root, currency);
        var saved = currency === "shield" ? state.selectedBetShield : state.selectedBetCrystal;
        setSelectedBet(saved != null ? saved : (currency === "shield" ? 10 : 1));
        if (AutospinController) AutospinController.updatePlayButton();
        updateBetControlsState(root);
    }

    function setSelectedBet(betValue) {
        if (!state.isDataReady) return;
        var cfg = getBetConfig();
        var v = Math.max(cfg.min, Math.min(cfg.max, Math.floor(Number(betValue) || cfg.min)));
        var root = $.GetContextPanel();
        if (!root) return;
        var lab = root.FindChildTraverse("BetValue");
        if (lab) lab.text = String(v);
        
        if (state.selectedBet === v) return;
        state.selectedBet = v;
        if (state.selectedCurrency === "shield") state.selectedBetShield = v;
        else state.selectedBetCrystal = v;
        updateBetControlsState(root);
        if (AutospinController) AutospinController.updatePlayButton();
    }

    function cycleBetPrev() { adjustBet(-1); }
    function cycleBetNext() { adjustBet(1); }

    function updateBetControlsState(root) {
        if (!root) return;
        var isBlocked = !state.isDataReady || state.fsmState === FSM_STATE.ANTICIPATION || state.fsmState === FSM_STATE.SPINNING;
        var betDec = root.FindChildTraverse("BetDecrease"), betInc = root.FindChildTraverse("BetIncrease");

        if (betDec) betDec.enabled = state.isDataReady && state.selectedBet > getBetConfig().min;
        if (betInc) betInc.enabled = state.isDataReady && state.selectedBet < getBetConfig().max;
        
        var tabShield = root.FindChildTraverse("TabShield"), tabCrystal = root.FindChildTraverse("TabCrystal"), betSwitch = root.FindChildTraverse("BetCompactSwitch");
        if (tabShield) tabShield.enabled = !isBlocked;
        if (tabCrystal) tabCrystal.enabled = !isBlocked;
        if (betSwitch) betSwitch.enabled = !isBlocked;
        var asOff = root.FindChildTraverse("AutoSpinOff"), as10 = root.FindChildTraverse("AutoSpin10"), as25 = root.FindChildTraverse("AutoSpin25"), asInf = root.FindChildTraverse("AutoSpinInf");
        if (asOff) asOff.enabled = state.isDataReady;
        if (as10) as10.enabled = state.isDataReady;
        if (as25) as25.enabled = state.isDataReady;
        if (asInf) asInf.enabled = state.isDataReady;
        var tooltipText = isBlocked ? $.Localize("#ui_casv2_cannot_change_during_spin") : "";
        if (tabShield) tabShield.tooltip_text = isBlocked ? tooltipText : $.Localize("#ui_casv2_currency_shields");
        if (tabCrystal) tabCrystal.tooltip_text = isBlocked ? tooltipText : $.Localize("#ui_casv2_currency_crystals");
        if (betSwitch) betSwitch.tooltip_text = isBlocked ? tooltipText : $.Localize("#ui_casv2_switch_currency");
        if (betDec) betDec.tooltip_text = isBlocked ? tooltipText : $.Localize("#ui_casv2_tooltip_decrease_bet");
        if (betInc) betInc.tooltip_text = isBlocked ? tooltipText : $.Localize("#ui_casv2_tooltip_increase_bet");
    }

    function updatePlayerProfile(profile) {
        if (!profile) return;
        var root = $.GetContextPanel();
        if (!root) return;
        var format = shared.formatNumber;
        var levelLabel = root.FindChildTraverse("PlayerLevelText");
        if (levelLabel && profile.level !== undefined) levelLabel.text = $.Localize("#ui_casv2_level_prefix") + " " + profile.level;
        var expLabel = root.FindChildTraverse("ExpValues");
        if (expLabel) {
            var current = profile.current_experience_in_level !== undefined ? profile.current_experience_in_level : (profile.experience || 0);
            var toNext = profile.total_experience_for_next_level !== undefined ? profile.total_experience_for_next_level : (profile.experience_to_next_level || 0);
            expLabel.text = format(Math.max(0, Math.floor(current))) + " / " + format(Math.max(0, Math.floor(toNext)));
        }
        var expBar = root.FindChildTraverse("ExpProgressFill");
        if (expBar) {
            var percent = 0;
            if (profile.level_progress_percent !== undefined) percent = Math.max(0, Math.min(100, profile.level_progress_percent));
            else if (profile.current_experience_in_level !== undefined && profile.total_experience_for_next_level !== undefined) {
                var tot = profile.total_experience_for_next_level || 1;
                percent = Math.max(0, Math.min(100, ((profile.current_experience_in_level || 0) / tot) * 100));
            }
            expBar.style.width = percent + "%";
        }
        var rewardLabel = root.FindChildTraverse("LevelUpReward");
        var rewardIcon = root.FindChildTraverse("LevelUpRewardIcon");
        if (rewardLabel || rewardIcon) {
            var amount = profile.next_level_reward_amount !== undefined ? profile.next_level_reward_amount : (profile.reward_amount || 0);
            var nextCurrency = profile.next_level_reward_currency || profile.reward_currency || "shield";
            var iconPath16 = (nextCurrency === "ruby" || nextCurrency === "crystal") ? "file://{images}/custom_game/currency_icon/currency_ruby_16x16.png" : "file://{images}/custom_game/currency_icon/currency_shield_16x16.png";
            if (amount > 0) {
                if (rewardLabel) rewardLabel.text = "+" + format(amount) + " " + (nextCurrency === "shield" ? "\uD83D\uDEE1" : "\uD83D\uDC8E");
                if (rewardIcon) { if (typeof rewardIcon.SetImage === "function") rewardIcon.SetImage(iconPath16); else rewardIcon.src = iconPath16; }
            } else {
                if (rewardLabel) rewardLabel.text = "";
                if (rewardIcon) { if (typeof rewardIcon.SetImage === "function") rewardIcon.SetImage(iconPath16); else rewardIcon.src = iconPath16; }
            }
        }
        var claimBtn = root.FindChildTraverse("LevelUpClaimBtn");
        if (claimBtn) {
            var showClaim = !!(profile.is_reward_available === true || profile.is_reward_available === 1);
            claimBtn.style.visibility = showClaim ? "visible" : "collapse";
            if (showClaim) {
                var amount = profile.reward_amount !== undefined ? profile.reward_amount : 0;
                var currency = profile.reward_currency || "shield";
                var claimText = root.FindChildTraverse("LevelUpClaimBtnText");
                if (claimText) claimText.text = $.Localize("#ui_casv2_claim_plus") + format(amount);
                var claimIcon = root.FindChildTraverse("LevelUpClaimBtnIcon");
                if (claimIcon) {
                    var claimIconPath = (currency === "ruby" || currency === "crystal") ? "file://{images}/custom_game/currency_icon/currency_ruby_16x16.png" : "file://{images}/custom_game/currency_icon/currency_shield_16x16.png";
                    if (typeof claimIcon.SetImage === "function") claimIcon.SetImage(claimIconPath); else claimIcon.src = claimIconPath;
                }
            }
        }
        var crystalsLabel = root.FindChildTraverse("PlayerCrystals"), shieldsLabel = root.FindChildTraverse("PlayerShields");
        if (crystalsLabel && profile.rubies !== undefined) crystalsLabel.text = format(profile.rubies);
        if (shieldsLabel && profile.shields !== undefined) shieldsLabel.text = format(profile.shields);
    }

    function fillRewardCards(rewards) {
        if (!rewards) return;
        var root = $.GetContextPanel();
        if (!root) return;
        var dragonCard = root.FindChildTraverse("RewardCardDragon");
        if (rewards.dragon && dragonCard) {
            dragonCard.visible = true;
            var pDragon = parseFloat(rewards.dragon.progress) || 0;
            var bar = root.FindChildTraverse("RewardProgressFillDragon");
            if (bar && rewards.dragon.progress !== undefined) bar.style.height = Math.max(0, Math.min(100, pDragon)) + "%";
            var barDragonOverflow = root.FindChildTraverse("RewardProgressFillDragonOverflow");
            if (barDragonOverflow) barDragonOverflow.style.height = (pDragon > 100 ? Math.min(100, pDragon - 100) : 0) + "%";
            var progressColDragon = root.FindChildTraverse("RewardProgressColumnDragon");
            if (progressColDragon) {
                var dragonTooltipText = $.Localize("#ui_casv2_progress_filled") + " " + pDragon.toFixed(1) + "%";
                progressColDragon.SetPanelEvent("onmouseover", function() { $.DispatchEvent("DOTAShowTextTooltip", progressColDragon, dragonTooltipText); });
                progressColDragon.SetPanelEvent("onmouseout", function() { $.DispatchEvent("DOTAHideTextTooltip"); });
            }
            var chanceLabel = root.FindChildTraverse("RewardChanceTextDragon");
            var avatar = root.FindChildTraverse("RewardWinnerAvatarDragon");
            if (avatar) avatar.steamid = rewards.dragon.winner_steamid || "";
            var itemIcon = root.FindChildTraverse("RewardIconDragon");
            if (itemIcon) { itemIcon.itemname = rewards.dragon.item_name || ""; itemIcon.visible = !!rewards.dragon.item_name; }
        } else if (dragonCard) dragonCard.visible = false;
        var secondCard = root.FindChildTraverse("RewardCardSecond");
        if (rewards.second && secondCard) {
            secondCard.visible = true;
            var pSecond = parseFloat(rewards.second.progress) || 0;
            var bar2 = root.FindChildTraverse("RewardProgressFillSecond");
            if (bar2 && rewards.second.progress !== undefined) bar2.style.height = Math.max(0, Math.min(100, pSecond)) + "%";
            var barSecondOverflow = root.FindChildTraverse("RewardProgressFillSecondOverflow");
            if (barSecondOverflow) barSecondOverflow.style.height = (pSecond > 100 ? Math.min(100, pSecond - 100) : 0) + "%";
            var progressColSecond = root.FindChildTraverse("RewardProgressColumnSecond");
            if (progressColSecond) {
                var secondTooltipText = $.Localize("#ui_casv2_progress_filled") + " " + pSecond.toFixed(1) + "%";
                progressColSecond.SetPanelEvent("onmouseover", function() { $.DispatchEvent("DOTAShowTextTooltip", progressColSecond, secondTooltipText); });
                progressColSecond.SetPanelEvent("onmouseout", function() { $.DispatchEvent("DOTAHideTextTooltip"); });
            }
            var avatar2 = root.FindChildTraverse("RewardWinnerAvatarSecond");
            if (avatar2) avatar2.steamid = rewards.second.winner_steamid || "";
            var itemIcon2 = root.FindChildTraverse("RewardIconSecond");
            if (itemIcon2) { itemIcon2.itemname = rewards.second.item_name || ""; itemIcon2.visible = !!rewards.second.item_name; }
        } else if (secondCard) secondCard.visible = false;
    }

    function updateCrystalJackpot(crystal_jackpots) {
        if (!crystal_jackpots) return;
        var root = $.GetContextPanel();
        if (!root) return;
        var jackpotsArray = Array.isArray(crystal_jackpots) ? crystal_jackpots : Object.keys(crystal_jackpots).map(function(k) { return crystal_jackpots[k]; });
        if (jackpotsArray.length === 0) return;
        var rubyJackpot = jackpotsArray.find(function(j) { return j.currency === "ruby"; }) || jackpotsArray[0];
        if (rubyJackpot && rubyJackpot.accumulated_amount != null) {
            var jackpotValueLabel = root.FindChildTraverse("JackpotValue");
            if (jackpotValueLabel) jackpotValueLabel.text = shared.formatNumber(Math.floor(rubyJackpot.accumulated_amount || 0));
        }
    }

    function updateCrystalJackpotFromSpin(amount) {
        var root = $.GetContextPanel();
        if (!root) return;
        var jackpotValueLabel = root.FindChildTraverse("JackpotValue");
        if (jackpotValueLabel && amount != null) jackpotValueLabel.text = shared.formatNumber(Math.floor(amount || 0));
    }

    function onCasinoDataReceived(data) {
        var root = $.GetContextPanel();
        if (!root && casv2 && casv2.main) root = casv2.main;
        if (!root) return;
        if (data && data.request_key !== undefined && state.lastCasinoDataRequestKey != null && String(data.request_key) !== String(state.lastCasinoDataRequestKey)) return;
        state.isLoading = false;
        if (state.casinoLeftLoadingPanelId) {
            var leftLoadingPanel = root.FindChildTraverse(state.casinoLeftLoadingPanelId);
            if (leftLoadingPanel) leftLoadingPanel.visible = false;
            if (dotaHud && typeof dotaHud.HideLoadingPanel === "function") {
                try { dotaHud.HideLoadingPanel(state.casinoLeftLoadingPanelId); } catch (e) {}
            }
            state.casinoLeftLoadingPanelId = null;
        }
        if (state.casinoRightLoadingPanelId) {
            var rightLoadingPanel = root.FindChildTraverse(state.casinoRightLoadingPanelId);
            if (rightLoadingPanel) rightLoadingPanel.visible = false;
            if (dotaHud && typeof dotaHud.HideLoadingPanel === "function") {
                try { dotaHud.HideLoadingPanel(state.casinoRightLoadingPanelId); } catch (e) {}
            }
            state.casinoRightLoadingPanelId = null;
        }
        if (!data || !data.success) {
            state.isDataReady = false;
            state.casinoDataReady = false;
            setWinMessage($.Localize("#ui_casv2_casino_data_failed"), null);
            if (state.slotsLoadingPanelId && dotaHud && typeof dotaHud.HideLoadingPanel === "function") {
                try { dotaHud.HideLoadingPanel(state.slotsLoadingPanelId); state.slotsLoadingPanelId = null; } catch (e) {}
            }
            return;
        }
        state.isDataReady = true;
        state.casinoDataReady = true;
        state.pendingSellIds = [];
        state.pendingClaimIds = [];
        if (data.profile) state.casinoData.profile = data.profile;
        state.casinoData.inventory = data.inventory || [];
        state.casinoData.claimed_history = data.claimed_history || [];
        state.casinoData.sold_history = data.sold_history || [];
        state.casinoData.sold_totals = data.sold_totals || { ruby: 0, shield: 0 };
        state.casinoData.inventory_sell_totals = data.inventory_sell_totals || state.casinoData.inventory_sell_totals || { ruby: 0, shield: 0 };
        if (data.inventory_total != null) state.inventoryTotalCount = parseInt(data.inventory_total, 10);
        if (data.claimed_total != null) state.claimedTotalCount = parseInt(data.claimed_total, 10);
        if (data.sold_total != null) state.soldTotalCount = parseInt(data.sold_total, 10);
        var hi = casv2.historyInventory;
        state.casinoData.jackpot_history = (hi && hi.mergeJackpotHistoryWithLocal) ? hi.mergeJackpotHistoryWithLocal(data.jackpot_history || []) : (data.jackpot_history || []);
        if (data.jackpot_total != null) state.jackpotTotalCount = parseInt(data.jackpot_total, 10);
        state.inventoryHasMore = data.inventory_has_more === true;
        state.claimedHasMore = data.claimed_has_more === true;
        state.soldHasMore = data.sold_has_more === true;
        state.casinoData.notify_show_win_to_winner = data.notify_show_win_to_winner !== false;
        state.casinoData.notify_show_jackpot_to_winner = data.notify_show_jackpot_to_winner !== false;
        state.casinoData.notify_show_recent_jackpot_to_winner = data.notify_show_recent_jackpot_to_winner !== false;
        var serverNowStr = data.server_now_utc || data.server_now || null;
        if (serverNowStr) {
            var serverDate = shared.parseIsoDate(serverNowStr);
            if (serverDate) { state.serverNowDate = serverDate; state.serverNowClientMs = (new Date()).getTime(); }
        }
        var history = shared.normalizeToArray(data && data.history);
        if (history && history.length > 0) {
            var last = history[history.length - 1];
            if (last && last.id) { state.historyLastId = last.id; state.historyHasMore = true; }
            else { state.historyLastId = null; state.historyHasMore = false; }
        } else { state.historyLastId = null; state.historyHasMore = false; }
        try {
            if (data.profile) updatePlayerProfile(data.profile);
            if (data.rewards) fillRewardCards(data.rewards);
            if (data.crystal_jackpots) updateCrystalJackpot(data.crystal_jackpots);
            var hi = casv2.historyInventory;
            if (hi) {
                if (hi.updateHistoryDisplay) hi.updateHistoryDisplay(history, true);
                if (hi.updateLoadMoreButtonVisibility) hi.updateLoadMoreButtonVisibility();
                if (hi.updateInventoryButtonText) hi.updateInventoryButtonText();
                if (hi.loadInventoryItems) hi.loadInventoryItems();
            }
            var itc = getFeature("InventoryTabController");
            if (itc) {
                var ct = itc.getTab();
                if (!ct || ct === "items" || ct === "claimed_history") itc.setActiveTab("new");
                else itc.refreshCurrentTab();
            }
            if (state.slotsLoadingPanelId && dotaHud && typeof dotaHud.HideLoadingPanel === "function") {
                try { dotaHud.HideLoadingPanel(state.slotsLoadingPanelId); state.slotsLoadingPanelId = null; } catch (e) {}
            }
            if (state.selectedCurrency === "shield" && (state.selectedBet < 10 || state.selectedBet == null)) { state.selectedBet = 10; state.selectedBetShield = 10; }
            setSelectedBet(state.selectedBet);
            updateBetCurrencyIcon(root, state.selectedCurrency);
            
            var winLabel = root.FindChildTraverse("WinMessageLabel");
            var currentMsg = (winLabel && winLabel.text) ? winLabel.text.toUpperCase() : "";
            var loadingKey = $.Localize("#ui_casv2_loading");
            if (winLabel && (currentMsg === "" || currentMsg.indexOf(loadingKey.toUpperCase()) !== -1)) {
                setWinMessage($.Localize("#ui_casv2_ready_to_play"), null);
            }
            
            if (state.casinoOpenPending && state.casinoMainPanel) {
                state.casinoMainPanel.visible = true;
                state.casinoMainPanel.hittest = true;
                state.casinoMainPanel.style.opacity = "1";
                var gh = state.casinoMainPanel.FindChildTraverse("GameHeader"), gc = state.casinoMainPanel.FindChildTraverse("GameContentWrapper");
                if (gh) { gh.visible = true; gh.style.opacity = "1"; }
                if (gc) { gc.visible = true; gc.style.opacity = "1"; }
                if (state.loadingPanelId && dotaHud && typeof dotaHud.HideLoadingPanel === "function") {
                    try { dotaHud.HideLoadingPanel(state.loadingPanelId); state.loadingPanelId = null; } catch (e) {}
                }
                state.casinoOpenPending = false;
                state.casinoDataReady = true;
            }
            
            var winnersPanel = root.FindChildTraverse("WinnersPanel");
            var statsPanel = root.FindChildTraverse("StatsPanel");
            if (winnersPanel) {
                var pc = winnersPanel.FindChildTraverse("PlayerCard");
                var dd = winnersPanel.FindChildTraverse("InventoryTabDropdown");
                var inv = winnersPanel.FindChildTraverse("InventoryPanel");
                if (pc) pc.visible = true;
                if (dd) dd.visible = true;
                if (inv) inv.visible = true;
            }
            if (statsPanel) {
                var banner = statsPanel.FindChildTraverse("CrystalJackpotBanner");
                var card1 = statsPanel.FindChildTraverse("RewardCardDragon");
                var card2 = statsPanel.FindChildTraverse("RewardCardSecond");
                if (banner) banner.visible = true;
                if (card1) card1.visible = true;
                if (card2) card2.visible = true;
            }
        } finally {
            updateBetControlsState(root);
            if (AutospinController) AutospinController.updatePlayButton();
        }
    }

    function requestCasinoData() {
        var key = Date.now() + "_" + Math.random().toString(36).substr(2, 9);
        state.lastCasinoDataRequestKey = key;
        GameEvents.SendCustomGameEventToServer("casv2_load_data", { request_key: key });
    }

    casv2.updatePlayerProfile = updatePlayerProfile;
    casv2.requestCasinoData = requestCasinoData;
    casv2.updateBetCurrencyIcon = updateBetCurrencyIcon;
    casv2.setupEventHandlers = setupEventHandlers;
    casv2.setWinMessage = setWinMessage;
    casv2.updateBetControlsState = updateBetControlsState;
    casv2.fillRewardCards = fillRewardCards;
    casv2.updateCrystalJackpotFromSpin = updateCrystalJackpotFromSpin;
    casv2.onPlayButtonClicked = function() { if (AutospinController) AutospinController.onPlayClick(); };
    casv2.cycleBetNext = cycleBetNext;
    casv2.cycleBetPrev = cycleBetPrev;

    GameEvents.Subscribe("casino_spin_result", function(r) { if (SpinFlow) SpinFlow.handleSpinResult(r); });
    GameEvents.Subscribe("casv2_data", onCasinoDataReceived);
    GameEvents.Subscribe("casv2_level_reward_claimed", function(d) { if (d && d.success && d.profile) { state.casinoData.profile = d.profile; updatePlayerProfile(d.profile); } });

    GameUI.LoopTime.Schedule(0.0, initialize);
})();