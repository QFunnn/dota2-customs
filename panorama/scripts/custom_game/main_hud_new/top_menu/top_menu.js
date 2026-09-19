--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
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
function updateRouletteButton(_state) {
    const button = findHudPanel("RouletteRebornButton");
    if (button) {
        button.SetHasClass("Hidden", false);
    }
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
function showExclusive(targetId, otherIds) {
    const target = findHudPanel(targetId);
    if (!target) {
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
function openInventoryCasesPage() {
    showExclusive("CustomInventoryOverlay", ["CustomSettingsOverlay", "CustomRouletteOverlay", "CustomCasesOverlay"]);
    $.Schedule(0.03, () => {
        const switchInventoryTab = GameUI.SwitchCustomInventoryTab;
        if (typeof switchInventoryTab === "function") {
            switchInventoryTab("inventory");
        }
        $.Schedule(0.03, () => {
            const openCasesPage = GameUI.OpenCustomInventoryCasesPage;
            if (typeof openCasesPage === "function") {
                openCasesPage();
            }
        });
    });
}
GameUI.ToggleCustomSettingsHud = () => {
    openExclusive("CustomSettingsOverlay", ["CustomInventoryOverlay", "CustomRouletteOverlay", "CustomCasesOverlay"]);
};
GameUI.ToggleCustomInventoryHud = () => {
    openExclusive("CustomInventoryOverlay", ["CustomSettingsOverlay", "CustomRouletteOverlay", "CustomCasesOverlay"]);
};
GameUI.ToggleCustomRouletteHud = () => {
    openExclusive("CustomRouletteOverlay", ["CustomSettingsOverlay", "CustomInventoryOverlay", "CustomCasesOverlay"]);
};
GameUI.ToggleCustomCasesHud = () => {
    openInventoryCasesPage();
};
GameUI.OpenCustomCaseFromInventory = (caseId) => {
    showExclusive("CustomCasesOverlay", ["CustomSettingsOverlay", "CustomInventoryOverlay", "CustomRouletteOverlay"]);
    $.Schedule(0.03, () => GameUI.OpenCustomCase(caseId));
};
GameUI.CloseCustomCaseOpening = () => {
    openInventoryCasesPage();
};
CustomNetTables.SubscribeNetTableListener("roulette", (_, key, value) => {
    if (key === "state") {
        updateRouletteButton(value);
    }
});
updateRouletteButton(CustomNetTables.GetTableValue("roulette", "state"));