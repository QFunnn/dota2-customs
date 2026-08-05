--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


(function() {
    "use strict";
    // Открытие/закрытие окна казино: загрузка данных, лоадеры, фоновый звук, Space/стрелки.
    var shared = GameUI.CustomUIConfig().Casv2Shared;
    if (!shared) return;
    
    var state = shared.state;
    var FSM_STATE = shared.FSM_STATE;
    var transitionTo = shared.transitionTo;
    
    function getFeature(name) {
        var features = GameUI.CustomUIConfig().Casv2Features;
        return features && features[name] || null;
    }
    
    function getUtil(name) {
        var utils = GameUI.CustomUIConfig().Casv2Utils;
        return utils && utils[name] || null;
    }
    
    var SpinFlow = getFeature("SpinFlow");
    var AutospinController = getFeature("AutospinController");
    var TimerRegistry = getUtil("TimerRegistry");
    
    var windowState = {
        isOpen: false,
        previousState: null,
        bgGameLoopSoundHandle: null,
        bgGameLoopRestartTimerId: null
    };
    
    var BG_GAME_LOOP_SOUND = "cas.bg_game_loop";
    var BG_GAME_LOOP_DURATION_SEC = 29;
    
    function stopBgGameLoopSound() {
        if (windowState.bgGameLoopRestartTimerId != null && windowState.bgGameLoopRestartTimerId !== undefined && TimerRegistry && typeof TimerRegistry.cancel === "function") {
            try { TimerRegistry.cancel(windowState.bgGameLoopRestartTimerId); } catch (e) {}
            windowState.bgGameLoopRestartTimerId = null;
        }
        if (windowState.bgGameLoopSoundHandle != null && windowState.bgGameLoopSoundHandle !== undefined && typeof Game.StopSound === "function") {
            try {
                Game.StopSound(windowState.bgGameLoopSoundHandle);
            } catch (e) {}
            windowState.bgGameLoopSoundHandle = null;
        }
    }
    
    function startBgGameLoopSound() {
        if (!windowState.isOpen) return;
        var dotaHud = GameUI.CustomUIConfig().DotaHUD;
        if (dotaHud && dotaHud.windowControllers && dotaHud.windowControllers["casv2"] && !dotaHud.windowControllers["casv2"].is_open) return;
        stopBgGameLoopSound();
        try {
            var handle = Game.EmitSound(BG_GAME_LOOP_SOUND);
            if (handle != null && handle !== undefined) windowState.bgGameLoopSoundHandle = handle;
            if (TimerRegistry && typeof TimerRegistry.schedule === "function") {
                windowState.bgGameLoopRestartTimerId = TimerRegistry.schedule(BG_GAME_LOOP_DURATION_SEC, function() {
                    windowState.bgGameLoopRestartTimerId = null;
                    if (windowState.isOpen) startBgGameLoopSound();
                }, "bg_loop");
            }
        } catch (e) {}
    }
    
    function handleClose(rootPanel) {
        if (state.fsmState === FSM_STATE.SPINNING && SpinFlow && SpinFlow.skipAnimation) {
            SpinFlow.skipAnimation(true);
        }
        windowState.isOpen = false;
        stopBgGameLoopSound();
        var dotaHud = GameUI.CustomUIConfig().DotaHUD;
        if (dotaHud && dotaHud.windowControllers["casv2"]) dotaHud.windowControllers["casv2"].is_open = false;
        
        var root = (rootPanel && rootPanel.IsValid && rootPanel.IsValid()) ? rootPanel : $.GetContextPanel();
        if (root) {
            if (root.AddClass) root.AddClass("casino-closed");
            var gameHeader = root.FindChildTraverse("GameHeader");
            var gameContent = root.FindChildTraverse("GameContentWrapper");
            if (gameHeader) { gameHeader.visible = false; gameHeader.style.visibility = "collapse"; }
            if (gameContent) { gameContent.visible = false; gameContent.style.visibility = "collapse"; }
        }

        state.isDataReady = false;
        state.casinoDataReady = false;
        state.casinoOpenPending = false;
        state.casinoMainPanel = null;
        
        windowState.previousState = state.fsmState;
        state.fsmStateBeforePause = state.fsmState;
        
        if (SpinFlow) SpinFlow.cancelSpin();
        else if (state.spinTimeoutId) {
            if (TimerRegistry) TimerRegistry.cancelTimer(state.spinTimeoutId);
            else GameUI.LoopTime.DelTime(state.spinTimeoutId.timerId || state.spinTimeoutId);
            state.spinTimeoutId = null;
        }
        
        if (TimerRegistry) {
            TimerRegistry.clearAll("spin");
            TimerRegistry.clearAll(null);
        }
        
        if (AutospinController && state.autospinMode !== "off") {
            AutospinController.stopAutospin("window_closed");
        } else if (state.autospinMode !== "off") {
            state.autospinMode = "off";
            state.autospinRemaining = 0;
            state.autospinPaused = false;
            var casv2 = GameUI.CustomUIConfig().Casv2;
            if (casv2 && casv2.setWinMessage) casv2.setWinMessage($.Localize("#ui_casv2_autospin_stopped"));
        }
        
        state.skipEnabled = false;
        
        if (state.slotsLoadingPanelId && dotaHud && typeof dotaHud.HideLoadingPanel === "function") {
            try {
                dotaHud.HideLoadingPanel(state.slotsLoadingPanelId);
                state.slotsLoadingPanelId = null;
            } catch (e) {}
        }
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
        
        transitionTo(FSM_STATE.PAUSED, "window_closed");
    }
    
    function handleOpen(mainPanel, dotaHud) {
        if (windowState.isOpen) return;
        windowState.isOpen = true;
        if (dotaHud && dotaHud.windowControllers["casv2"]) dotaHud.windowControllers["casv2"].is_open = true;
        startBgGameLoopSound();
        state.isLoading = true;
        state.isDataReady = false;
        state.casinoDataReady = false;

        if (mainPanel) {
            if (mainPanel.RemoveClass) mainPanel.RemoveClass("casino-closed");
            mainPanel.style.visibility = "visible";
            mainPanel.style.opacity = "1";
            var gameHeader = mainPanel.FindChildTraverse("GameHeader");
            var gameContent = mainPanel.FindChildTraverse("GameContentWrapper");
            if (gameHeader) {
                gameHeader.visible = true;
                gameHeader.style.visibility = "visible";
                gameHeader.style.opacity = "1";
            }
            if (gameContent) { gameContent.visible = true; gameContent.style.visibility = "visible"; gameContent.style.opacity = "1"; }
        }
        
        state.casinoMainPanel = mainPanel;
        state.casinoOpenPending = false;
        
        var root = $.GetContextPanel();
        if (!root && mainPanel) root = mainPanel;
        if (!root) return;
        
        var winnersPanel = root.FindChildTraverse("WinnersPanel");
        var statsPanel = root.FindChildTraverse("StatsPanel");
        if (winnersPanel) {
            var pc = winnersPanel.FindChildTraverse("PlayerCard");
            var dd = winnersPanel.FindChildTraverse("InventoryTabDropdown");
            var inv = winnersPanel.FindChildTraverse("InventoryPanel");
            if (pc) pc.visible = false;
            if (dd) dd.visible = false;
            if (inv) inv.visible = false;
        }
        if (statsPanel) {
            var banner = statsPanel.FindChildTraverse("CrystalJackpotBanner");
            var card1 = statsPanel.FindChildTraverse("RewardCardDragon");
            var card2 = statsPanel.FindChildTraverse("RewardCardSecond");
            if (banner) banner.visible = false;
            if (card1) card1.visible = false;
            if (card2) card2.visible = false;
        }
        
        if (dotaHud && typeof dotaHud.ShowLoadingPanel === "function") {
            try {
                if (winnersPanel) {
                    state.casinoLeftLoadingPanelId = dotaHud.ShowLoadingPanel("#ui_casv2_loading", winnersPanel);
                    if (state.casinoLeftLoadingPanelId) {
                        var lp = $.GetContextPanel().GetParent().FindChildTraverse(state.casinoLeftLoadingPanelId);
                        if (!lp && winnersPanel) lp = winnersPanel.FindChildTraverse(state.casinoLeftLoadingPanelId);
                        if (lp) lp.hittest = false;
                    }
                }
                if (statsPanel) {
                    state.casinoRightLoadingPanelId = dotaHud.ShowLoadingPanel("#ui_casv2_loading", statsPanel);
                    if (state.casinoRightLoadingPanelId) {
                        var rp = $.GetContextPanel().GetParent().FindChildTraverse(state.casinoRightLoadingPanelId);
                        if (!rp && statsPanel) rp = statsPanel.FindChildTraverse(state.casinoRightLoadingPanelId);
                        if (rp) rp.hittest = false;
                    }
                }
            } catch (e) {}
        }
        
        if (state.loadingPanelId && dotaHud && typeof dotaHud.HideLoadingPanel === "function") {
            try {
                dotaHud.HideLoadingPanel(state.loadingPanelId);
            } catch (e) {}
            state.loadingPanelId = null;
        }
        if (state.slotsLoadingPanelId && dotaHud && typeof dotaHud.HideLoadingPanel === "function") {
            try {
                dotaHud.HideLoadingPanel(state.slotsLoadingPanelId);
            } catch (e) {}
            state.slotsLoadingPanelId = null;
        }
        
        disableControlsUntilDataReady(root);
        
        requestCasinoDataSafe();
        
        var sh = GameUI.CustomUIConfig().SpaceKeyHandler;
        if (sh) {
            if (sh.register) {
                var AutospinController = getFeature("AutospinController");
                sh.register(function() {
                    if (!state.isDataReady) {
                        var casv2 = GameUI.CustomUIConfig().Casv2;
                        if (casv2 && casv2.setWinMessage) casv2.setWinMessage($.Localize("#ui_casv2_loading_data"), null);
                        return;
                    }
                    if (AutospinController && AutospinController.onPlayClick) AutospinController.onPlayClick();
                    else {
                        var casv2 = GameUI.CustomUIConfig().Casv2;
                        if (casv2 && casv2.onPlayButtonClicked) casv2.onPlayButtonClicked();
                    }
                }, function() { return state.casinoMainPanel && state.casinoMainPanel.visible; });
            }
            
            if (sh.registerArrows) {
                sh.registerArrows({
                    up: function() {
                        if (!state.isDataReady) return;
                        var casv2 = GameUI.CustomUIConfig().Casv2;
                        if (casv2 && casv2.cycleBetNext) casv2.cycleBetNext();
                    },
                    down: function() {
                        if (!state.isDataReady) return;
                        var casv2 = GameUI.CustomUIConfig().Casv2;
                        if (casv2 && casv2.cycleBetPrev) casv2.cycleBetPrev();
                    }
                });
            }
            
            if (sh.activate) GameUI.LoopTime.Schedule(0.5, function() { sh.activate(); });
        }
        
        var casv2ForIcon = GameUI.CustomUIConfig().Casv2;
        if (casv2ForIcon && casv2ForIcon.updateBetCurrencyIcon) casv2ForIcon.updateBetCurrencyIcon(root, state.selectedCurrency);
        
        if (state.fsmState === FSM_STATE.PAUSED) {
            var previousState = windowState.previousState || state.fsmStateBeforePause || FSM_STATE.IDLE;
            if (previousState === FSM_STATE.SPINNING || previousState === FSM_STATE.ANTICIPATION) {
                transitionTo(FSM_STATE.RESULT, "resume_from_paused");
                state.skipEnabled = false;
                if (SpinFlow) SpinFlow.resumeSpin();
            } else transitionTo(previousState, "resume_from_paused");
            
            if (AutospinController) AutospinController.resumeAutospin();
            else if (state.autospinPaused) state.autospinPaused = false;
        } else if (state.fsmState === undefined || state.fsmState === null) transitionTo(FSM_STATE.IDLE, "first_open");
        
        if (state.fsmState !== FSM_STATE.SPINNING) state.skipEnabled = false;
        
        GameUI.LoopTime.Schedule(0.1, function() {
            var casv2 = GameUI.CustomUIConfig().Casv2;
            if (casv2 && typeof casv2.setupEventHandlers === "function") casv2.setupEventHandlers();
        });
    }
    
    function disableControlsUntilDataReady(root) {
        if (!root) return;
        var playBtn = root.FindChildTraverse("PlayButton");
        if (playBtn) playBtn.enabled = false;
        
        var tabShield = root.FindChildTraverse("TabShield"), tabCrystal = root.FindChildTraverse("TabCrystal"), betSwitch = root.FindChildTraverse("BetCompactSwitch");
        if (tabShield) tabShield.enabled = false;
        if (tabCrystal) tabCrystal.enabled = false;
        if (betSwitch) betSwitch.enabled = false;
        
        var betDec = root.FindChildTraverse("BetDecrease"), betInc = root.FindChildTraverse("BetIncrease");
        if (betDec) betDec.enabled = false;
        if (betInc) betInc.enabled = false;
        
        var asOff = root.FindChildTraverse("AutoSpinOff"), as10 = root.FindChildTraverse("AutoSpin10"), as25 = root.FindChildTraverse("AutoSpin25"), asInf = root.FindChildTraverse("AutoSpinInf");
        if (asOff) asOff.enabled = false;
        if (as10) as10.enabled = false;
        if (as25) as25.enabled = false;
        if (asInf) asInf.enabled = false;
    }
    
    function reRenderUI(root) {
        if (!root) return;
        if (state.isDataReady) {
            if (AutospinController && AutospinController.updatePlayButton) AutospinController.updatePlayButton();
            else {
                var casv2 = GameUI.CustomUIConfig().Casv2;
                if (casv2 && casv2.updatePlayButtonState) casv2.updatePlayButtonState(root);
            }
            var casv2ForControls = GameUI.CustomUIConfig().Casv2;
            if (casv2ForControls && casv2ForControls.updateBetControlsState) casv2ForControls.updateBetControlsState(root);
        }
        if (AutospinController && AutospinController.applyAutospinSelection) AutospinController.applyAutospinSelection();
    }
    
    function requestCasinoDataSafe() {
        var casv2 = GameUI.CustomUIConfig().Casv2;
        if (!casv2 || !casv2.requestCasinoData) {
            var key = Date.now() + "_" + Math.random().toString(36).substr(2, 9);
            state.lastCasinoDataRequestKey = key;
            GameEvents.SendCustomGameEventToServer("casv2_load_data", { request_key: key });
            return;
        }
        casv2.requestCasinoData();
    }
    
    function isOpen() { return windowState.isOpen; }
    function getPreviousState() { return windowState.previousState || state.fsmStateBeforePause; }
    
    var WindowLifecycle = {
        handleOpen: handleOpen,
        handleClose: handleClose,
        reRenderUI: reRenderUI,
        requestCasinoDataSafe: requestCasinoDataSafe,
        isOpen: isOpen,
        getPreviousState: getPreviousState,
        getWindowState: function() { return JSON.parse(JSON.stringify(windowState)); },
        startBgGameLoopSound: startBgGameLoopSound,
        stopBgGameLoopSound: stopBgGameLoopSound
    };
    
    if (!GameUI.CustomUIConfig().Casv2Features) GameUI.CustomUIConfig().Casv2Features = {};
    GameUI.CustomUIConfig().Casv2Features.WindowLifecycle = WindowLifecycle;
})();