--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


(function() {
    "use strict";
    // Пробел = спин/стоп, стрелки вверх/вниз = ставка +/- (когда окно казино активно).
    var hiddenPanel = null;
    var hiddenTextEntry = null;
    var lastInputText = "";
    var isTracking = false;
    var focusIntervalId = null;
    var blurTimeoutId = null;
    var lastFocusTime = 0;
    var onSpaceCallback = null;
    var isVisibleCallback = null;
    var arrowCallbacks = { up: null, down: null };

    var FOCUS_UPDATE_INTERVAL_SEC = 3.0;

    function isKeyboardInput(char) {
        if (!char || char.length === 0) return false;
        var code = char.charCodeAt(0);
        return (code === 32) || (code >= 33 && code <= 126) || (code >= 128);
    }

    function onSpacePressed() {
        if (isVisibleCallback && typeof isVisibleCallback === "function" && !isVisibleCallback()) return;
        if (onSpaceCallback && typeof onSpaceCallback === "function") onSpaceCallback();
    }

    var ARROW_KEYS = { onmoveup: "up", onmovedown: "down" };

    function makeArrowHandler(eventName) {
        return function() {
            if (!isTracking || (isVisibleCallback && typeof isVisibleCallback === "function" && !isVisibleCallback())) return;
            var key = ARROW_KEYS[eventName];
            var cb = key && arrowCallbacks[key];
            if (typeof cb === "function") cb();
        };
    }

    function onTextChanged() {
        if (!hiddenTextEntry) return;
        if (!isTracking) {
            if ((hiddenTextEntry.text || "").length > 0) { hiddenTextEntry.text = ""; lastInputText = ""; }
            return;
        }
        try {
            var cur = hiddenTextEntry.text || "";
            if (cur.length > lastInputText.length) {
                var newChar = cur.substring(lastInputText.length);
                var code = newChar.charCodeAt(0);
                if (newChar === " " || code === 32) {
                    onSpacePressed();
                    hiddenTextEntry.text = "";
                    lastInputText = "";
                    return;
                }
                if (isKeyboardInput(newChar)) {
                    isTracking = false;
                    if (typeof hiddenTextEntry.Blur === "function") hiddenTextEntry.Blur();
                    hiddenTextEntry.text = "";
                    lastInputText = "";
                    var timeoutId = GameUI.LoopTime.Schedule(2.0, function() {
                        if (blurTimeoutId !== timeoutId) return;
                        if (hiddenTextEntry && isVisibleCallback && typeof isVisibleCallback === "function" && isVisibleCallback()) {
                            isTracking = true;
                            hiddenTextEntry.SetFocus();
                            lastFocusTime = Game.GetGameTime();
                            if (!focusIntervalId) focusIntervalId = GameUI.LoopTime.Schedule(3.0, maintainFocus);
                        }
                        blurTimeoutId = null;
                    });
                    blurTimeoutId = timeoutId;
                    return;
                }
                hiddenTextEntry.text = "";
                lastInputText = "";
                return;
            }
            if (cur.length < lastInputText.length) { lastInputText = cur; return; }
            if (cur.length > 10) { hiddenTextEntry.text = ""; lastInputText = ""; return; }
            lastInputText = cur;
        } catch (e) {}
    }

    function safeSetFocus() {
        if (!hiddenTextEntry) return false;
        try {
            var now = Game.GetGameTime();
            if (now - lastFocusTime < FOCUS_UPDATE_INTERVAL_SEC) return false;
            hiddenTextEntry.SetFocus();
            lastFocusTime = now;
            return true;
        } catch (e) { return false; }
    }

    function stopFocusMaintenance() {
        if (focusIntervalId != null) { if (typeof GameUI.LoopTime !== "undefined" && GameUI.LoopTime.DelTime) GameUI.LoopTime.DelTime(focusIntervalId); focusIntervalId = null; }
    }

    function maintainFocus() {
        if (!hiddenTextEntry || !isTracking) { stopFocusMaintenance(); return; }
        if (isVisibleCallback && typeof isVisibleCallback === "function" && !isVisibleCallback()) {
            deactivate();
            stopFocusMaintenance();
            return;
        }
        safeSetFocus();
        if (focusIntervalId !== null) focusIntervalId = GameUI.LoopTime.Schedule(3.0, maintainFocus);
    }

    function createTracker() {
        if (hiddenPanel) return hiddenTextEntry;
        var root = $.GetContextPanel();
        if (!root) return null;
        hiddenPanel = $.CreatePanel("Panel", root, "SpaceKeyTrackerPanel");
        if (!hiddenPanel) return null;
        hiddenPanel.style.width = "1px";
        hiddenPanel.style.height = "1px";
        hiddenPanel.style.opacity = "0";
        hiddenPanel.style.visibility = "visible";
        hiddenPanel.style.position = "0px 0px 0px";
        hiddenPanel.style.zIndex = "-9999";
        if (typeof hiddenPanel.SetAcceptsFocus === "function") hiddenPanel.SetAcceptsFocus(false);
        hiddenTextEntry = $.CreatePanel("TextEntry", hiddenPanel, "SpaceKeyTracker");
        if (!hiddenTextEntry) return null;
        hiddenTextEntry.style.width = "1px";
        hiddenTextEntry.style.height = "1px";
        hiddenTextEntry.style.opacity = "0";
        hiddenTextEntry.style.visibility = "visible";
        hiddenTextEntry.style.position = "0px 0px 0px";
        hiddenTextEntry.style.zIndex = "-9999";
        if (typeof hiddenTextEntry.SetAcceptsFocus === "function") hiddenTextEntry.SetAcceptsFocus(true);
        hiddenTextEntry.SetPanelEvent("ontextentrychange", onTextChanged);
        hiddenTextEntry.SetPanelEvent("onmoveup", makeArrowHandler("onmoveup"));
        hiddenTextEntry.SetPanelEvent("onmovedown", makeArrowHandler("onmovedown"));
        return hiddenTextEntry;
    }

    function activate() {
        if (!hiddenTextEntry) createTracker();
        if (!hiddenTextEntry) return false;
        try {
            isTracking = true;
            if (typeof hiddenTextEntry.SetAcceptsFocus === "function") hiddenTextEntry.SetAcceptsFocus(true);
            hiddenTextEntry.SetFocus();
            lastFocusTime = Game.GetGameTime();
            if (!focusIntervalId) focusIntervalId = GameUI.LoopTime.Schedule(3.0, maintainFocus);
            return true;
        } catch (e) { return false; }
    }

    function deactivate() {
        if (!hiddenTextEntry) return;
        try {
            isTracking = false;
            blurTimeoutId = null;
            stopFocusMaintenance();
            if (typeof hiddenPanel.Blur === "function") hiddenPanel.Blur();
            if (hiddenTextEntry) { if (typeof hiddenTextEntry.Blur === "function") hiddenTextEntry.Blur(); hiddenTextEntry.text = ""; }
            lastInputText = "";
        } catch (e) {}
    }

    function register(callback, visibilityCheck) {
        onSpaceCallback = callback;
        isVisibleCallback = visibilityCheck;
        if (!hiddenTextEntry) createTracker();
    }

    function registerArrows(handlers) {
        if (!handlers) return;
        if (handlers.up != null) arrowCallbacks.up = handlers.up;
        if (handlers.down != null) arrowCallbacks.down = handlers.down;
        if (!hiddenTextEntry) createTracker();
    }

    if (!GameUI.CustomUIConfig().SpaceKeyHandler) GameUI.CustomUIConfig().SpaceKeyHandler = {};
    var api = GameUI.CustomUIConfig().SpaceKeyHandler;
    api.register = register;
    api.activate = activate;
    api.deactivate = deactivate;
    api.registerArrows = registerArrows;
})();