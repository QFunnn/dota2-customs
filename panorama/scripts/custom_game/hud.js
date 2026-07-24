--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
const mainHud = findElement("Hud");
(function () {
    hideDefaultElements();
    hideRoshanGlyphScanElements();
    moveClockToLeft();
    hideDefaultScoreBoard();
    fixShopScroll();
})();
const pickScreenListenerId = GameEvents.SubscribeUnprotected("game_rules_state_change", HidePickScreen);
function HidePickScreen() {
    var _a;
    const dotaHud = (_a = $.GetContextPanel().GetParent()) === null || _a === void 0 ? void 0 : _a.GetParent(); // id="Hud"
    if (!dotaHud) {
        $.Schedule(0.5, () => HidePickScreen());
        return;
    }
    if (Game.GameStateIsBefore(DOTA_GameState.DOTA_GAMERULES_STATE_HERO_SELECTION)) {
        $.Msg("HidePickScreen - PreGame visible = false");
        dotaHud.FindChild("PreGame").visible = false;
    }
    else if (Game.GameStateIs(DOTA_GameState.DOTA_GAMERULES_STATE_HERO_SELECTION)) {
        $.Msg("HidePickScreen - PreGame visible = true");
        dotaHud.FindChild("PreGame").visible = true;
    }
    else if (Game.GameStateIs(DOTA_GameState.DOTA_GAMERULES_STATE_PRE_GAME)) {
        $.Msg("HidePickScreen - PreGame visible = false");
        dotaHud.FindChild("PreGame").visible = false;
        GameEvents.Unsubscribe(pickScreenListenerId);
    }
}
function hideDefaultElements() {
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ENDGAME, false);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_BAR_BACKGROUND, false);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, false);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_QUICK_STATS, false);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_HEADER, false);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_TEAMS, false);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_KILLCAM, false);
    //GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD, false)
}
function hideRoshanGlyphScanElements() {
    const roshanTimer = mainHud === null || mainHud === void 0 ? void 0 : mainHud.FindChildTraverse("RoshanTimerContainer");
    const glyphScan = mainHud === null || mainHud === void 0 ? void 0 : mainHud.FindChildTraverse("GlyphScanContainer");
    const toastManager = mainHud === null || mainHud === void 0 ? void 0 : mainHud.FindChildTraverse("ToastManager");
    const tormentor = mainHud === null || mainHud === void 0 ? void 0 : mainHud.FindChildTraverse('TormentorTimerContainer');
    if (roshanTimer)
        roshanTimer.visible = false;
    if (glyphScan)
        glyphScan.visible = false;
    if (toastManager)
        toastManager.visible = false;
    if (tormentor)
        tormentor.visible = false;
}
function fixShopScroll() {
    const hudShop = mainHud === null || mainHud === void 0 ? void 0 : mainHud.FindChildTraverse("shop");
    if (hudShop) {
        const guideFlyoutPanel = hudShop.FindChildTraverse("GuideFlyout");
        if (guideFlyoutPanel) {
            guideFlyoutPanel.style.visibility = "collapse";
        }
        const gridBasicItemsCategory = hudShop.FindChildTraverse("GridBasicItemsCategory");
        if (gridBasicItemsCategory) {
            gridBasicItemsCategory.style.overflow = "squish scroll";
        }
        const gridUpgradesItemsCategory = hudShop.FindChildTraverse("GridUpgradesCategory");
        if (gridUpgradesItemsCategory) {
            gridUpgradesItemsCategory.style.overflow = "squish scroll";
        }
    }
}
function moveClockToLeft() {
    const offset = "300px";
    const dayClock = mainHud === null || mainHud === void 0 ? void 0 : mainHud.FindChildTraverse('TimeOfDay');
    const clockBg = mainHud === null || mainHud === void 0 ? void 0 : mainHud.FindChildTraverse('TimeOfDayBG');
    const dayGlow = mainHud === null || mainHud === void 0 ? void 0 : mainHud.FindChildTraverse('DayGlow');
    const nightGlow = mainHud === null || mainHud === void 0 ? void 0 : mainHud.FindChildTraverse('NightGlow');
    const timeUntil = mainHud === null || mainHud === void 0 ? void 0 : mainHud.FindChildTraverse('TimeUntil');
    if (dayClock) {
        dayClock.style.horizontalAlign = "left";
        dayClock.style.marginLeft = offset;
    }
    if (clockBg) {
        clockBg.style.horizontalAlign = "left";
        clockBg.style.marginLeft = offset;
    }
    if (dayGlow) {
        dayGlow.style.horizontalAlign = "left";
        dayGlow.style.marginLeft = offset;
    }
    if (nightGlow) {
        nightGlow.style.horizontalAlign = "left";
        nightGlow.style.marginLeft = offset;
    }
    if (timeUntil) {
        timeUntil.style.horizontalAlign = "left";
        timeUntil.style.marginLeft = offset;
    }
}
function hideDefaultScoreBoard() {
    const baseScoreBoard = mainHud === null || mainHud === void 0 ? void 0 : mainHud.FindChildTraverse("scoreboard");
    if (baseScoreBoard)
        baseScoreBoard.visible = false;
}
/**
 * Turn a table object into an array.
 * @param obj The object to transform to an array.
 * @returns An array with items of the value type of the original object.
 */
function toArray(obj) {
    const result = [];
    let key = 1;
    while (obj[key]) {
        result.push(obj[key]);
        key++;
    }
    return result;
}