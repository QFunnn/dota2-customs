--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


(function() {
    "use strict";
    // Цепочка спина: anticipation → запрос casino_spin → handleSpinResult → анимация слотов → finishSpin (autospin/запрос данных).
    var shared = GameUI.CustomUIConfig().Casv2Shared;
    if (!shared || !shared.state) return;
    
    var state = shared.state;
    var FSM_STATE = shared.FSM_STATE;
    var transitionTo = shared.transitionTo;
    var formatNumber = shared.formatNumber;
    
    var TimerRegistry = GameUI.CustomUIConfig().Casv2Utils && 
                        GameUI.CustomUIConfig().Casv2Utils.TimerRegistry;
    if (!TimerRegistry) return;
    
    var AutospinController = GameUI.CustomUIConfig().Casv2Features && 
                             GameUI.CustomUIConfig().Casv2Features.AutospinController;
    if (!AutospinController) return;
    
    function getCasv2() { return GameUI.CustomUIConfig().Casv2 || null; }
    
    if (typeof clearAllSlots !== "function" || 
        typeof startAllSlotsAnimation !== "function" || 
        typeof stopSpinAnimation !== "function") {
        return;
    }
    
    var activeSpin = {
        isActive: false,
        requestId: null,
        timeoutTimer: null,
        anticipationTimer: null,
        skipTimer: null,
        continuationTimer: null,
        startedAt: null,
        spinningSoundHandle: null,
        winAnimationFinishedSent: false
    };
    
    function canStartSpin() {
        if (activeSpin.isActive) return false;
        if (state.fsmState !== FSM_STATE.IDLE && state.fsmState !== FSM_STATE.RESULT) return false;
        if (state.playButtonDebounce) return false;
        return true;
    }
    
    function clearSpinTimers() {
        TimerRegistry.clearAll("spin");
        activeSpin.timeoutTimer = null;
        activeSpin.anticipationTimer = null;
        activeSpin.skipTimer = null;
        activeSpin.continuationTimer = null;
    }
    
    function ensureSpinLoadingOverlay(root) {
        if (!root) return null;
        var overlay = root.FindChildTraverse("SpinLoadingOverlay");
        if (overlay) return overlay;
        
        var slotsContainer = root.FindChildTraverse("SlotsContainer");
        if (!slotsContainer && state.slotCardIds && state.slotCardIds.length > 0) {
            var firstCard = root.FindChildTraverse(state.slotCardIds[0]);
            if (firstCard) slotsContainer = firstCard.GetParent();
        }
        
        if (!slotsContainer) return null;
        
        overlay = $.CreatePanel("Panel", slotsContainer, "SpinLoadingOverlay");
        overlay.hittest = false;
        overlay.style.width = "100%";
        overlay.style.height = "100%";
        overlay.style.backgroundColor = "rgba(0, 0, 0, 0.5)";
        overlay.style.zIndex = "100";
        
        var loadingText = $.CreatePanel("Label", overlay, "SpinLoadingText");
        loadingText.text = $.Localize("#ui_casv2_loading");
        loadingText.style.fontSize = "24px";
        loadingText.style.color = "white";
        loadingText.style.textAlign = "center";
        loadingText.style.verticalAlign = "center";
        loadingText.style.width = "100%";
        loadingText.style.height = "100%";
        
        return overlay;
    }
    
    function setSpinLoading(root, on) {
        if (!root) return;
        var overlay = ensureSpinLoadingOverlay(root);
        if (!overlay) return;
        overlay.visible = on;
        overlay.hittest = !on;
    }

    function triggerCrystalJackpotValuePop(root) {
        if (!root) return;
        var banner = root.FindChildTraverse("CrystalJackpotBanner");
        if (!banner) return;
        
        var isRuby = (state.selectedCurrency === "crystal");
        var clsShield = "CrystalStartPop--Shield";
        var clsCrystal = "CrystalStartPop--Crystal";

        banner.RemoveClass(clsShield);
        banner.RemoveClass(clsCrystal);
        banner.AddClass(isRuby ? clsCrystal : clsShield);

        TimerRegistry.schedule(0.45, function() {
            var r = $.GetContextPanel();
            if (!r) return;
            var b = r.FindChildTraverse("CrystalJackpotBanner");
            if (!b) return;
            b.RemoveClass(clsShield);
            b.RemoveClass(clsCrystal);
        }, "spin");
    }

    function triggerRewardStartFlash(root) {
        if (!root) return;
        
        var isRuby = (state.selectedCurrency === "crystal");
        var isShield = (state.selectedCurrency === "shield");
        
        function flash(panelId) {
            var p = root.FindChildTraverse(panelId);
            if (!p) return;
            p.RemoveClass("RewardStartFlash");
            p.AddClass("RewardStartFlash");
        }

        if (isRuby) flash("RewardCardDragon");
        if (isRuby || isShield) flash("RewardCardSecond");

        TimerRegistry.schedule(0.45, function() {
            var r = $.GetContextPanel();
            if (!r) return;
            var c1 = r.FindChildTraverse("RewardCardDragon");
            var c2 = r.FindChildTraverse("RewardCardSecond");
            if (c1) c1.RemoveClass("RewardStartFlash");
            if (c2) c2.RemoveClass("RewardStartFlash");
        }, "spin");
    }
    
    function startSpin(options) {
        options = options || {};
        var casv2 = getCasv2();
        var root = $.GetContextPanel();
        if (!root || !root.FindChildTraverse("PlayButton")) {
            if (casv2 && casv2.main && casv2.main.IsValid()) root = casv2.main;
        }
        if (!root || !canStartSpin()) {
            return false;
        }

        var isAutospinReason = options.reason === "autospin_continue" || options.reason === "autospin_start";
        if (!isAutospinReason && !state.isDataReady) {
            return false;
        }

        clearSpinTimers();
        
        activeSpin.isActive = true;
        activeSpin.startedAt = Date.now();
        activeSpin.requestId = "req_" + Date.now() + "_" + Math.random();
        activeSpin.winAnimationFinishedSent = false;
        
        if (!options.skipDebounce) {
            state.playButtonDebounce = true;
            TimerRegistry.schedule(0.1, function() {
                state.playButtonDebounce = false;
            }, "spin");
        }
        
        AutospinController.decrementAutospin();
        clearAllSlots(root);
        AutospinController.updatePlayButton();
        if (casv2) casv2.updateBetControlsState(root);
        
        setupSafetyTimeout();
        
        var transitionOk = transitionTo(FSM_STATE.ANTICIPATION, options.reason || "spin_start");
        if (!transitionOk) {
            activeSpin.isActive = false;
            return false;
        }
        
        if (AutospinController && AutospinController.updatePlayButton) {
            AutospinController.updatePlayButton();
        }

        startAnticipationPhase(root);
        return true;
    }
    
    function startAnticipationPhase(root) {
        var casv2 = getCasv2();
        (typeof GameUI !== "undefined" && GameUI.CasUiClickSound ? GameUI.CasUiClickSound() : Game.EmitSound("General.ButtonClick"));
        
        for (var i = 0; i < state.slotCardIds.length; i++) {
            var card = root.FindChildTraverse(state.slotCardIds[i]);
            if (card) card.AddClass("anticipation");
        }
        
        var anticipationCallback = function() {
            if (!activeSpin.isActive || state.fsmState !== FSM_STATE.ANTICIPATION) {
                return;
            }
            
            for (var i = 0; i < state.slotCardIds.length; i++) {
                var card = root.FindChildTraverse(state.slotCardIds[i]);
                if (card) card.RemoveClass("anticipation");
            }
            
            if (!transitionTo(FSM_STATE.SPINNING, "anticipation_to_spinning")) {
                activeSpin.isActive = false;
                clearSpinTimers();
                return;
            }
            
            state.skipEnabled = false;
            AutospinController.updatePlayButton();
            if (casv2) {
                casv2.updateBetControlsState(root);
                casv2.setWinMessage($.Localize("#ui_casv2_game_started"), null);
            }

            sendSpinRequest();
        };
        
        activeSpin.anticipationTimer = TimerRegistry.schedule(0.05, anticipationCallback, "spin");
    }
    
    function sendSpinRequest() {
        var root = $.GetContextPanel();
        if (!root && getCasv2() && getCasv2().main) root = getCasv2().main;
        setSpinLoading(root, true);
        
        GameEvents.SendCustomGameEventToServer("casino_spin", {
            currency: state.selectedCurrency === "shield" ? "shield" : "ruby",
            bet: state.selectedBet,
            request_id: activeSpin.requestId
        });
    }
    
    function setupSafetyTimeout() {
        var casv2 = getCasv2();
        var savedRequestId = activeSpin.requestId;
        var timeoutCallback = function() {
            if (!activeSpin.isActive || activeSpin.requestId !== savedRequestId) return;
            
            var root = $.GetContextPanel();
            if (state.fsmState === FSM_STATE.SPINNING) {
                setSpinLoading(root, false);
                finishSpin("timeout");
            } else if (state.fsmState === FSM_STATE.ANTICIPATION) {
                setSpinLoading(root, false);
                cancelSpin();
                if (transitionTo(FSM_STATE.RESULT, "timeout_anticipation")) {
                    if (root) {
                        AutospinController.updatePlayButton();
                        if (casv2) casv2.updateBetControlsState(root);
                    }
                }
            }
        };
        
        activeSpin.timeoutTimer = TimerRegistry.create("spin", 10.0, timeoutCallback);
    }
    
    function handleSpinResult(result) {
        var casv2 = getCasv2();
        if (!casv2) return;
        var root = $.GetContextPanel();
        setSpinLoading(root, false);
        
        if (state.fsmState !== FSM_STATE.SPINNING) return;
        if (result.request_id && activeSpin.requestId !== result.request_id) return;
        
        state.lastSpinIsWin = (result.is_win === true || result.is_win === 1);
        state.lastSpinIsJackpot = !!(result.reward && result.reward.is_jackpot);
        if (state.lastSpinIsWin && result.reward && result.currency) {
            state.lastWinValue = result.reward.value;
            state.lastWinCurrency = result.currency;
        } else {
            state.lastWinValue = null;
            state.lastWinCurrency = null;
        }
        
        if (result.error) {
            var errRaw = result.error_message || result.error || "";
            var errMsg = errRaw.toLowerCase();
            var isInsufficient = (errMsg.indexOf("insufficient") !== -1 || errMsg.indexOf("недостаточно") !== -1);
            if (state.autospinMode !== "off") AutospinController.stopAutospin("no_balance");
            if (isInsufficient) {
                casv2.setWinMessage($.Localize("#ui_casv2_insufficient_funds"), state.selectedCurrency === "shield" ? "shield" : "ruby");
            } else {
                var displayError = (errRaw && errRaw.indexOf("#") === 0) ? $.Localize(errRaw) : ($.Localize("#ui_casv2_error_prefix") + " " + errRaw);
                casv2.setWinMessage(displayError, null);
            }
            finishSpin("error");
            return;
        }
        
        if (!result.item1 || !result.item2 || !result.item3) {
            finishSpin("no_items");
            return;
        }
        
        if (!root) {
            finishSpin("no_root");
            return;
        }
        
        if (result.profile) {
            casv2.updatePlayerProfile(result.profile);
            state.casinoData.profile = result.profile;
        }
        
        if (result.rewards) casv2.fillRewardCards(result.rewards);
        if (result.crystal_jackpot_amount !== undefined) casv2.updateCrystalJackpotFromSpin(result.crystal_jackpot_amount);

        triggerCrystalJackpotValuePop(root);
        triggerRewardStartFlash(root);
        
        var thirdSlotDuration = result.item1 === result.item2 ? 1.7 : 1.3;
        startResultAnimation(root, result, thirdSlotDuration);
    }
    
    function startResultAnimation(root, result, thirdSlotDuration) {
        var handle = Game.EmitSound("cas.sound_spinning");
        if (handle != null && handle !== undefined) activeSpin.spinningSoundHandle = handle;
        
        state.skipEnabled = false;
        
        if (state.selectedSpeed === "skip") {
            var isWin = result.is_win === true || result.is_win === 1;
            startAllSlotsAnimation(root, [
                { item: result.item1, duration: 0.7, speed: 1 },
                { item: result.item2, duration: 1.0, speed: 1 },
                { item: result.item3, duration: thirdSlotDuration, speed: 1 }
            ], null, function() {}, null);
            
            var skipCallback = function() {
                if (!activeSpin.isActive || state.fsmState !== FSM_STATE.SPINNING) return;
                if (isWin && !activeSpin.winAnimationFinishedSent && typeof GameEvents !== "undefined" && GameEvents.SendCustomGameEventToServer) {
                    GameEvents.SendCustomGameEventToServer("casv2_win_animation_finished", {});
                    activeSpin.winAnimationFinishedSent = true;
                }
                stopSpinAnimation(root, true);
                finishSpin("skip_mode");
            };
            
            activeSpin.skipTimer = TimerRegistry.schedule(0.15, skipCallback, "spin");
        } else {
            var onAnimationComplete = function() { finishSpin("animation_complete"); };
            var onAnimationStarted = function() {
                state.skipEnabled = true;
                AutospinController.updatePlayButton();
            };
            
            startAllSlotsAnimation(root, [
                { item: result.item1, duration: 0.7, speed: state.selectedSpeed },
                { item: result.item2, duration: 1.0, speed: state.selectedSpeed },
                { item: result.item3, duration: thirdSlotDuration, speed: state.selectedSpeed }
            ], null, onAnimationComplete, onAnimationStarted);
        }
    }
    
    function skipAnimation(force) {
        if (state.fsmState !== FSM_STATE.SPINNING) return false;
        if (!force && !state.skipEnabled) return false;
        var root = $.GetContextPanel();
        if (!root) {
            var c = getCasv2();
            if (c && c.main && c.main.IsValid()) root = c.main;
        }
        if (!root) return false;
        stopSpinAnimation(root, true);
        finishSpin(force ? "skip_on_close" : "skip");
        return true;
    }
    
    function finishSpin(reason) {
        var root = $.GetContextPanel();
        var wasWin = state.lastSpinIsWin;
        if (activeSpin.spinningSoundHandle != null && activeSpin.spinningSoundHandle !== undefined && typeof Game.StopSound === "function") {
            Game.StopSound(activeSpin.spinningSoundHandle);
            activeSpin.spinningSoundHandle = null;
        }
        
        setSpinLoading(root, false);
        
        if (state.fsmState !== FSM_STATE.SPINNING && 
            state.fsmState !== FSM_STATE.ANTICIPATION && 
            state.fsmState !== FSM_STATE.RESULT) {
            return;
        }
        
        if (!root) {
            if (wasWin && !activeSpin.winAnimationFinishedSent && typeof GameEvents !== "undefined" && GameEvents.SendCustomGameEventToServer) {
                GameEvents.SendCustomGameEventToServer("casv2_win_animation_finished", {});
                activeSpin.winAnimationFinishedSent = true;
            }
            return;
        }
        
        var casv2 = getCasv2();
        clearSpinTimers();
        
        for (var i = 0; i < state.slotCardIds.length; i++) {
            var card = root.FindChildTraverse(state.slotCardIds[i]);
            if (card) {
                card.RemoveClass("spinning");
                card.RemoveClass("winning");
                card.RemoveClass("hovering");
                card.RemoveClass("anticipation");
                card.RemoveClass("stopped");
                card.RemoveClass("slowing");
            }
        }
        
        if (state.lastSpinIsWin) {
            var msg = $.Localize("#ui_casv2_congrats_win");
            var cur = null;
            var winValue = state.lastWinValue != null && state.lastWinValue !== undefined ? Number(state.lastWinValue) : 0;
            if (winValue > 0 && state.lastWinCurrency) {
                var v = Math.floor(winValue);
                msg = $.Localize("#ui_casv2_congrats_plus") + " " + formatNumber(v) + " ";
                cur = state.lastWinCurrency;
            }
            var bet = state.selectedBet != null && state.selectedBet !== undefined ? Number(state.selectedBet) : 1;
            
            if (state.lastSpinIsJackpot) {
                Game.EmitSound("cas.casino_jackpot");
            } else if (bet > 0 && winValue >= bet * 10) {
                Game.EmitSound("cas.you_win_sequence_3");
            } else if (bet > 0 && winValue >= bet * 4) {
                Game.EmitSound("cas.you_win_sequence_2");
            } else {
                Game.EmitSound("cas.you_win_sequence_1");
            }
            
            if (casv2) casv2.setWinMessage(msg, cur);
            state.lastSpinIsWin = false;
            state.lastSpinIsJackpot = false;
            state.lastWinValue = null;
            state.lastWinCurrency = null;
        } else {
            Game.EmitSound("cas.game_lost");
            if (casv2) casv2.setWinMessage($.Localize("#ui_casv2_no_win"), null);
        }
        
        if (state.fsmState !== FSM_STATE.RESULT) transitionTo(FSM_STATE.RESULT, reason);
        
        state.skipEnabled = false;
        activeSpin.isActive = false;
        activeSpin.requestId = null;
        activeSpin.startedAt = null;
        activeSpin.winAnimationFinishedSent = false;
        
        AutospinController.updatePlayButton();
        if (casv2) casv2.updateBetControlsState(root);
        
        if (casv2 && casv2.requestCasinoData) casv2.requestCasinoData();
        
        if (wasWin && !activeSpin.winAnimationFinishedSent && typeof GameEvents !== "undefined" && GameEvents.SendCustomGameEventToServer) {
            GameEvents.SendCustomGameEventToServer("casv2_win_animation_finished", {});
            activeSpin.winAnimationFinishedSent = true;
        }
        
        if (AutospinController.checkAutospinContinue()) {
            var continueCallback = function() {
                if (state.fsmState !== FSM_STATE.RESULT || state.autospinPaused) return;
                if (!AutospinController.checkAutospinContinue()) return;
                var r = $.GetContextPanel();
                if (r && state.fsmState === FSM_STATE.RESULT && !state.autospinPaused) {
                    startSpin({ reason: "autospin_continue", skipDebounce: true });
                }
            };
            activeSpin.continuationTimer = TimerRegistry.schedule(0.5, continueCallback, "spin");
        }
    }
    
    function cancelSpin() {
        var root = $.GetContextPanel();
        setSpinLoading(root, false);
        if (!activeSpin.isActive) return;
        clearSpinTimers();
        activeSpin.isActive = false;
        activeSpin.requestId = null;
        activeSpin.startedAt = null;
        state.skipEnabled = false;
    }
    
    function resumeSpin() {
        if (state.fsmState === FSM_STATE.SPINNING && !activeSpin.isActive) {
            finishSpin("resume_no_animation");
            return;
        }
        if (state.fsmState === FSM_STATE.ANTICIPATION && !activeSpin.isActive) {
            finishSpin("resume_no_animation");
            return;
        }
        if (activeSpin.isActive && state.fsmState !== FSM_STATE.SPINNING && state.fsmState !== FSM_STATE.ANTICIPATION) {
            cancelSpin();
        }
    }
    
    var SpinFlow = {
        startSpin: startSpin,
        handleSpinResult: handleSpinResult,
        skipAnimation: skipAnimation,
        finishSpin: finishSpin,
        cancelSpin: cancelSpin,
        resumeSpin: resumeSpin,
        canStartSpin: canStartSpin,
        isSpinning: function() { return activeSpin.isActive; }
    };
    
    if (!GameUI.CustomUIConfig().Casv2Features) GameUI.CustomUIConfig().Casv2Features = {};
    GameUI.CustomUIConfig().Casv2Features.SpinFlow = SpinFlow;
})();