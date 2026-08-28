--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


(function() {
    "use strict";
    // Автоспин: режимы off/10/25/∞, счётчик оставшихся, кнопка Play/Stop/Skip.
    var shared = GameUI.CustomUIConfig().Casv2Shared;
    if (!shared || !shared.state) return;
    
    var state = shared.state;
    var FSM_STATE = shared.FSM_STATE;
    var transitionTo = shared.transitionTo;
    var getIsSpinning = shared.getIsSpinning;
    
    function getFeature(name) {
        var features = GameUI.CustomUIConfig().Casv2Features;
        return features && features[name] || null;
    }
    
    var cachedPanels = {
        root: null,
        playButton: null,
        playButtonText: null,
        autoSpinOff: null,
        autoSpin10: null,
        autoSpin25: null,
        autoSpinInf: null
    };
    
    function getCachedPanels() {
        var root = $.GetContextPanel();
        if (!root || !root.FindChildTraverse("PlayButton")) {
            var c = GameUI.CustomUIConfig().Casv2;
            if (c && c.main && c.main.IsValid()) root = c.main;
        }
        if (!root) return null;
        if (cachedPanels.root !== root) {
            cachedPanels.root = root;
            cachedPanels.playButton = root.FindChildTraverse("PlayButton");
            cachedPanels.playButtonText = root.FindChildTraverse("PlayButtonText");
            cachedPanels.autoSpinOff = root.FindChildTraverse("AutoSpinOff");
            cachedPanels.autoSpin10 = root.FindChildTraverse("AutoSpin10");
            cachedPanels.autoSpin25 = root.FindChildTraverse("AutoSpin25");
            cachedPanels.autoSpinInf = root.FindChildTraverse("AutoSpinInf");
        }
        return cachedPanels;
    }
    
    function isAutospinActive() {
        return (state.autospinMode !== "off") && 
               !state.autospinPaused &&
               (state.autospinRemaining === -1 || (state.autospinRemaining !== undefined && state.autospinRemaining > 0));
    }
    
    function getRemainingDisplay() {
        if (!isAutospinActive()) return null;
        if (state.autospinRemaining === -1) return "∞";
        return state.autospinRemaining > 0 ? state.autospinRemaining : null;
    }
    
    function checkBalance() {
        if (!state.isDataReady || !state.casinoData || !state.casinoData.profile) return false;
        var profile = state.casinoData.profile || {};
        var currency = state.selectedCurrency === "shield" ? "shield" : "ruby";
        var balance = currency === "shield" ? (profile.shields || 0) : (profile.rubies || 0);
        return balance >= state.selectedBet;
    }
    
    function setAutospinMode(mode) {
        var panels = getCachedPanels();
        if (!panels) return;
        
        var currentState = state.fsmState;
        var isOff = (mode === "off");
        
        if (isOff) {
            state.autospinMode = "off";
            state.autospinRemaining = 0;
            state.autospinPaused = false;
        } else if (mode === "infinite") {
            state.autospinMode = "infinite";
            state.autospinRemaining = -1;
            state.autospinPaused = false;
        } else if (typeof mode === "number" && mode > 0) {
            state.autospinMode = mode;
            state.autospinRemaining = mode;
            state.autospinPaused = false;
        } else return;
        
        applyAutospinSelection(panels);
        (typeof GameUI !== "undefined" && GameUI.CasUiClickSound ? GameUI.CasUiClickSound() : Game.EmitSound("General.ButtonClick"));
        
        if (!isOff && (currentState === FSM_STATE.IDLE || currentState === FSM_STATE.RESULT)) {
            state.playButtonDebounce = false;
            if (!state.isDataReady) return;
            
            var SpinFlow = getFeature("SpinFlow");
            if (SpinFlow) {
                SpinFlow.startSpin({ reason: "autospin_start" });
            }
        } else {
            updatePlayButton(panels);
        }
    }
    
    function stopAutospin(reason) {
        reason = reason || "manual";
        var panels = getCachedPanels();
        if (!panels) return;
        
        state.autospinMode = "off";
        state.autospinRemaining = 0;
        state.autospinPaused = false;
        
        applyAutospinSelection(panels);
        
        var casv2 = GameUI.CustomUIConfig().Casv2;
        if (casv2 && casv2.setWinMessage) {
            var message = "";
            var currency = null;
            
            if (reason === "no_balance") {
                message = $.Localize("#ui_casv2_insufficient_autospin");
                currency = state.selectedCurrency === "shield" ? "shield" : "ruby";
            } else if (reason === "user_stop") message = $.Localize("#ui_casv2_autospin_stopped");
            else if (reason === "finished") message = $.Localize("#ui_casv2_autospin_finished");
            else if (reason === "window_closed") message = $.Localize("#ui_casv2_autospin_stopped");
            else if (reason === "server_error" || reason === "error") message = $.Localize("#ui_casv2_server_error_autospin");
            else if (reason === "sanity_reset") message = "";
            else message = $.Localize("#ui_casv2_autospin_stopped");
            
            if (message) casv2.setWinMessage(message, currency);
        }
        
        updatePlayButtonText(panels);
        updatePlayButtonState(panels);
    }
    
    function decrementAutospin() {
        if (state.autospinRemaining !== undefined && state.autospinRemaining > 0) {
            state.autospinRemaining--;
            var panels = getCachedPanels();
            if (panels) updatePlayButtonText(panels);
        }
    }
    
    function checkAutospinContinue() {
        if (state.autospinMode !== "off" && state.autospinRemaining === 0 && state.autospinRemaining !== -1) {
            stopAutospin("sanity_reset");
            return false;
        }
        
        if (state.autospinMode === "off" || state.autospinPaused) return false;
        
        var shouldContinue = (state.autospinMode === "infinite") || 
                             (state.autospinRemaining !== undefined && state.autospinRemaining > 0);
        
        if (!shouldContinue) {
            stopAutospin("finished");
            return false;
        }
        return true;
    }
    
    function applyAutospinSelection(panels) {
        if (!panels) panels = getCachedPanels();
        if (!panels) return;
        
        if (panels.autoSpinOff) panels.autoSpinOff.RemoveClass("selected");
        if (panels.autoSpin10) panels.autoSpin10.RemoveClass("selected");
        if (panels.autoSpin25) panels.autoSpin25.RemoveClass("selected");
        if (panels.autoSpinInf) panels.autoSpinInf.RemoveClass("selected");
        
        var isActive = isAutospinActive();
        var selectedButton = null;
        
        if (isActive) {
            if (state.autospinMode === 10) selectedButton = panels.autoSpin10;
            else if (state.autospinMode === 25) selectedButton = panels.autoSpin25;
            else if (state.autospinMode === "infinite") selectedButton = panels.autoSpinInf;
        }
        
        if (selectedButton) selectedButton.AddClass("selected");
    }
    
    function updatePlayButtonText(panels) {
        if (!panels) panels = getCachedPanels();
        if (!panels || !panels.playButtonText) return;
        
        var currentState = state.fsmState;
        var remaining = getRemainingDisplay();
        var isActive = isAutospinActive();
        
        if (currentState === FSM_STATE.ANTICIPATION) panels.playButtonText.text = $.Localize("#ui_casv2_roll");
        else if (currentState === FSM_STATE.SPINNING) panels.playButtonText.text = $.Localize("#ui_casv2_skip");
        else if (currentState === FSM_STATE.RESULT) {
            if (isActive && remaining !== null) panels.playButtonText.text = $.Localize("#ui_casv2_stop_with_count") + remaining + ")";
            else panels.playButtonText.text = $.Localize("#ui_casv2_play_more");
        } else if (currentState === FSM_STATE.IDLE) {
            if (isActive && remaining !== null) panels.playButtonText.text = $.Localize("#ui_casv2_play_with_count") + remaining + ")";
            else panels.playButtonText.text = $.Localize("#ui_casv2_play");
        } else panels.playButtonText.text = $.Localize("#ui_casv2_play");
    }
    
    function updatePlayButtonState(panels) {
        if (!panels) panels = getCachedPanels();
        if (!panels || !panels.playButton) return;
        
        var currentState = state.fsmState;
        var isSpinning = getIsSpinning();
        var casv2 = GameUI.CustomUIConfig().Casv2;
        
        if (isSpinning) {
            panels.playButton.AddClass("skip-mode");
            if (currentState === FSM_STATE.SPINNING && state.skipEnabled) {
                panels.playButton.AddClass("skip-active");
                panels.playButton.enabled = true;
                if (casv2 && casv2.setWinMessage) casv2.setWinMessage("");
            } else {
                panels.playButton.RemoveClass("skip-active");
                panels.playButton.enabled = false;
                if (casv2 && casv2.setWinMessage) {
                    if (currentState === FSM_STATE.ANTICIPATION) casv2.setWinMessage($.Localize("#ui_casv2_wait_spin_start"));
                    else if (currentState === FSM_STATE.SPINNING && !state.skipEnabled) casv2.setWinMessage($.Localize("#ui_casv2_wait_animation"));
                }
            }
        } else {
            panels.playButton.RemoveClass("skip-mode");
            panels.playButton.RemoveClass("skip-active");
            
            if (currentState === FSM_STATE.IDLE || currentState === FSM_STATE.RESULT || currentState === FSM_STATE.PAUSED) {
                if (!state.isDataReady) panels.playButton.enabled = false;
                else {
                    var hasBalance = checkBalance();
                    panels.playButton.enabled = hasBalance;
                    
                    if (!hasBalance && casv2 && casv2.setWinMessage) {
                        var currencyName = state.selectedCurrency === "shield" ? $.Localize("#ui_casv2_currency_shields_short") : $.Localize("#ui_casv2_currency_crystals_short");
                        casv2.setWinMessage($.Localize("#ui_casv2_insufficient_prefix") + currencyName + $.Localize("#ui_casv2_for_game_suffix"));
                    } else if (hasBalance && casv2 && casv2.setWinMessage) {
                        var currentMsg = panels.root ? panels.root.FindChildTraverse("WinMessageLabel") : null;
                        var insufficientKey = $.Localize("#ui_casv2_insufficient_prefix");
                        if (currentMsg && currentMsg.text && currentMsg.text.indexOf(insufficientKey) !== -1) casv2.setWinMessage("");
                    }
                }
            } else if (currentState === FSM_STATE.ANTICIPATION || currentState === FSM_STATE.SPINNING) panels.playButton.enabled = false;
            else panels.playButton.enabled = true;
        }
        updatePlayButtonText(panels);
    }
    
    function onPlayClick() {
        var currentState = state.fsmState;
        if (currentState === FSM_STATE.ANTICIPATION) {
            return;
        }
        if (currentState === FSM_STATE.PAUSED) {
            if (transitionTo(FSM_STATE.IDLE, "resume_from_paused")) {
                currentState = FSM_STATE.IDLE;
            } else {
                return;
            }
        }

        var panels = getCachedPanels();
        if (!panels || !panels.playButton || !panels.playButton.enabled || state.playButtonDebounce) {
            return;
        }
        
        if (currentState === FSM_STATE.SPINNING) {
            if (state.skipEnabled) {
                var SpinFlow = getFeature("SpinFlow");
                if (SpinFlow) SpinFlow.skipAnimation();
            }
            return;
        }
        
        if (currentState === FSM_STATE.RESULT) {
            if (isAutospinActive()) {
                stopAutospin("user_stop");
                return;
            } else {
                var SpinFlow = getFeature("SpinFlow");
                if (SpinFlow) SpinFlow.startSpin({ reason: "result_to_anticipation" });
                return;
            }
        }
        
        if (currentState === FSM_STATE.IDLE) {
            if (!state.isDataReady) {
                var casv2 = GameUI.CustomUIConfig().Casv2;
                if (casv2 && casv2.setWinMessage) casv2.setWinMessage($.Localize("#ui_casv2_loading_data"), state.selectedCurrency);
                return;
            }

            var hasBalance = checkBalance();
            if (!hasBalance) {
                var casv2 = GameUI.CustomUIConfig().Casv2;
                if (casv2 && casv2.setWinMessage) casv2.setWinMessage($.Localize("#ui_casv2_insufficient_funds"), state.selectedCurrency === "shield" ? "shield" : "ruby");
                return;
            }

            var SpinFlow = getFeature("SpinFlow");
            if (SpinFlow) {
                var started = SpinFlow.startSpin({ reason: "idle_to_anticipation" });
                if (started) updatePlayButton(panels);
            }
            return;
        }
    }
    
    function updatePlayButton(panels) {
        if (!panels) panels = getCachedPanels();
        if (!panels) return;
        updatePlayButtonState(panels);
        applyAutospinSelection(panels);
    }
    
    function pauseAutospin() {
        if (isAutospinActive()) state.autospinPaused = true;
    }
    
    function resumeAutospin() {
        if (state.autospinPaused) state.autospinPaused = false;
    }
    
    var AutospinController = {
        setAutospinMode: setAutospinMode,
        stopAutospin: stopAutospin,
        decrementAutospin: decrementAutospin,
        checkAutospinContinue: checkAutospinContinue,
        pauseAutospin: pauseAutospin,
        resumeAutospin: resumeAutospin,
        onPlayClick: onPlayClick,
        updatePlayButton: updatePlayButton,
        updatePlayButtonText: updatePlayButtonText,
        updatePlayButtonState: updatePlayButtonState,
        applyAutospinSelection: applyAutospinSelection,
        isAutospinActive: isAutospinActive,
        getRemainingDisplay: getRemainingDisplay
    };
    
    if (!GameUI.CustomUIConfig().Casv2Features) GameUI.CustomUIConfig().Casv2Features = {};
    GameUI.CustomUIConfig().Casv2Features.AutospinController = AutospinController;
})();