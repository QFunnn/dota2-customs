--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
function findHudPanel(id) {
    var _a;
    let root = $.GetContextPanel();
    while (root === null || root === void 0 ? void 0 : root.GetParent()) {
        root = root.GetParent();
    }
    return (_a = root === null || root === void 0 ? void 0 : root.FindChildTraverse(id)) !== null && _a !== void 0 ? _a : null;
}
function isHidden(panel) {
    return panel.BHasClass("Hidden");
}
function openExclusive(targetId, otherIds) {
    const target = findHudPanel(targetId);
    if (!target) {
        return;
    }
    const shouldOpen = isHidden(target);
    if (!shouldOpen) {
        target.AddClass("Hidden");
        return;
    }
    target.RemoveClass("Hidden");
    for (const otherId of otherIds) {
        const other = findHudPanel(otherId);
        if (!other || other === target) {
            continue;
        }
        other.AddClass("Hidden");
    }
}
GameUI.ToggleCustomSettingsHud = () => {
    openExclusive("CustomSettingsOverlay", ["CustomInventoryOverlay"]);
};
GameUI.ToggleCustomInventoryHud = () => {
    openExclusive("CustomInventoryOverlay", ["CustomSettingsOverlay"]);
};