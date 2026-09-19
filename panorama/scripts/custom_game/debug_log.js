--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";
const MAX_VISIBLE_LINES = 800;
let windowPanel;
let bodyPanel;
let copyBox;
let copyHint;
const allLines = [];
let copyMode = false;
function ensureRefs() {
    if (!windowPanel || !windowPanel.IsValid()) {
        windowPanel = $("#DebugLogWindow") || undefined;
    }
    if (!bodyPanel || !bodyPanel.IsValid()) {
        bodyPanel = $("#DebugLogBody") || undefined;
    }
    if (!copyBox || !copyBox.IsValid()) {
        copyBox = $("#DebugLogCopyBox") || undefined;
    }
    if (!copyHint || !copyHint.IsValid()) {
        copyHint = $("#DebugLogCopyHint") || undefined;
    }
    return !!windowPanel && !!bodyPanel;
}
function setVisible(visible) {
    if (!ensureRefs()) {
        return;
    }
    windowPanel.visible = visible;
    windowPanel.hittest = visible;
}
function appendLine(text) {
    if (!ensureRefs()) {
        return;
    }
    allLines.push(text);
    while (allLines.length > MAX_VISIBLE_LINES) {
        allLines.shift();
    }
    const label = $.CreatePanel("Label", bodyPanel, "");
    label.text = text;
    label.style.width = "100%";
    label.style.color = "#c8d0e8";
    label.style.fontSize = "13px";
    label.style.whiteSpace = "normal";
    label.style.marginBottom = "2px";
    while (bodyPanel.GetChildCount() > MAX_VISIBLE_LINES) {
        const oldest = bodyPanel.GetChild(0);
        if (!oldest) {
            break;
        }
        oldest.DeleteAsync(0);
    }
    bodyPanel.ScrollToBottom();
}
function setCopyMode(enabled) {
    if (!ensureRefs() || !copyBox) {
        return;
    }
    copyMode = enabled;
    copyBox.text = enabled ? allLines.join("\n") : "";
    copyBox.visible = enabled;
    if (copyHint) {
        copyHint.visible = enabled;
    }
    if (enabled) {
        copyBox.SetFocus();
    }
}
function toggleCopy() {
    setCopyMode(!copyMode);
}
function clearLog() {
    if (!ensureRefs()) {
        return;
    }
    allLines.length = 0;
    bodyPanel.RemoveAndDeleteChildren();
    if (copyMode && copyBox) {
        copyBox.text = "";
    }
}
function closeWindow() {
    setCopyMode(false);
    setVisible(false);
    GameEvents.SendCustomGameEventToServer("debug_log_close", {});
}
function onOpen() {
    setCopyMode(false);
    clearLog();
    setVisible(true);
}
function onLine(event) {
    appendLine(event.line);
}
(function () {
    setVisible(false);
    const copyButton = $("#DebugLogCopy");
    if (copyButton) {
        copyButton.SetPanelEvent("onactivate", toggleCopy);
    }
    const clearButton = $("#DebugLogClear");
    if (clearButton) {
        clearButton.SetPanelEvent("onactivate", clearLog);
    }
    const closeButton = $("#DebugLogClose");
    if (closeButton) {
        closeButton.SetPanelEvent("onactivate", closeWindow);
    }
    GameEvents.Subscribe("debug_log_open", onOpen);
    GameEvents.Subscribe("debug_log_line", onLine);
})();