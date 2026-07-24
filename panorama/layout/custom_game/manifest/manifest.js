--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
/******/ 	// The require scope
/******/ 	var __webpack_require__ = {};
/******/ 	
/************************************************************************/
/******/ 	/* webpack/runtime/define property getters */
/******/ 	(() => {
/******/ 		// define getter functions for harmony exports
/******/ 		__webpack_require__.d = (exports, definition) => {
/******/ 			for(var key in definition) {
/******/ 				if(__webpack_require__.o(definition, key) && !__webpack_require__.o(exports, key)) {
/******/ 					Object.defineProperty(exports, key, { enumerable: true, get: definition[key] });
/******/ 				}
/******/ 			}
/******/ 		};
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/hasOwnProperty shorthand */
/******/ 	(() => {
/******/ 		__webpack_require__.o = (obj, prop) => (Object.prototype.hasOwnProperty.call(obj, prop))
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/make namespace object */
/******/ 	(() => {
/******/ 		// define __esModule on exports
/******/ 		__webpack_require__.r = (exports) => {
/******/ 			if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 				Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 			}
/******/ 			Object.defineProperty(exports, '__esModule', { value: true });
/******/ 		};
/******/ 	})();
/******/ 	
/************************************************************************/
var __webpack_exports__ = {};
/*!**********************!*\
  !*** ./manifest.tsx ***!
  \**********************/
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   FindDotaHudElement: () => (/* binding */ FindDotaHudElement)
/* harmony export */ });
GameUI.CustomUIConfig().team_logo_xml = "file://{resources}/layout/custom_game/team_icon.xml";
GameUI.CustomUIConfig().team_logo_large_xml = "file://{resources}/layout/custom_game/team_icon_large.xml";
GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, false);
GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD, false);
GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_TEAMS, false);
GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_GAME_NAME, false);
GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_BAR_BACKGROUND, false);
GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_QUICK_STATS, false);
GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ENDGAME, false);
GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_MINIMAP, false);
GameUI.CustomUIConfig().team_colors = {
    [DOTATeam_t.DOTA_TEAM_GOODGUYS]: "#3dd296;",
    [DOTATeam_t.DOTA_TEAM_BADGUYS]: "#F3C909;",
    [DOTATeam_t.DOTA_TEAM_CUSTOM_1]: "#c54da8;",
    [DOTATeam_t.DOTA_TEAM_CUSTOM_2]: "#FF6C00;",
    [DOTATeam_t.DOTA_TEAM_CUSTOM_3]: "#3455FF;",
    [DOTATeam_t.DOTA_TEAM_CUSTOM_4]: "#65d413;",
    [DOTATeam_t.DOTA_TEAM_CUSTOM_5]: "#815336;",
    [DOTATeam_t.DOTA_TEAM_CUSTOM_6]: "#1bc0d8;",
    [DOTATeam_t.DOTA_TEAM_CUSTOM_7]: "#c7e40d;",
    [DOTATeam_t.DOTA_TEAM_CUSTOM_8]: "#8c2af4;",
    [DOTATeam_t.DOTA_TEAM_NEUTRALS]: "",
};
GameUI.CustomUIConfig().team_icons = {
    [DOTATeam_t.DOTA_TEAM_GOODGUYS]: "s2r://panorama/images/custom_game/team_icons/team_icon_tiger_01.png",
    [DOTATeam_t.DOTA_TEAM_BADGUYS]: "s2r://panorama/images/custom_game/team_icons/team_icon_monkey_01.png",
    [DOTATeam_t.DOTA_TEAM_CUSTOM_1]: "file://{images}/custom_game/team_icons/team_icon_dragon_01.png",
    [DOTATeam_t.DOTA_TEAM_CUSTOM_2]: "file://{images}/custom_game/team_icons/team_icon_dog_01.png",
    [DOTATeam_t.DOTA_TEAM_CUSTOM_3]: "file://{images}/custom_game/team_icons/team_icon_rooster_01.png",
    [DOTATeam_t.DOTA_TEAM_CUSTOM_4]: "file://{images}/custom_game/team_icons/team_icon_ram_01.png",
    [DOTATeam_t.DOTA_TEAM_CUSTOM_5]: "file://{images}/custom_game/team_icons/team_icon_rat_01.png",
    [DOTATeam_t.DOTA_TEAM_CUSTOM_6]: "file://{images}/custom_game/team_icons/team_icon_boar_01.png",
    [DOTATeam_t.DOTA_TEAM_CUSTOM_7]: "file://{images}/custom_game/team_icons/team_icon_snake_01.png",
    [DOTATeam_t.DOTA_TEAM_CUSTOM_8]: "file://{images}/custom_game/team_icons/team_icon_horse_01.png",
    [DOTATeam_t.DOTA_TEAM_NEUTRALS]: "",
};
let pHud = $.GetContextPanel();
while (pHud != null && pHud.id != "Hud") {
    pHud = pHud.GetParent();
}
function FindDotaHudElement(id) {
    return pHud === null || pHud === void 0 ? void 0 : pHud.FindChildTraverse(id);
}
(pHud === null || pHud === void 0 ? void 0 : pHud.FindChildTraverse('TimeOfDay')).style.horizontalAlign = 'left';
(pHud === null || pHud === void 0 ? void 0 : pHud.FindChildTraverse('TimeOfDayBG')).style.horizontalAlign = 'left';
(pHud === null || pHud === void 0 ? void 0 : pHud.FindChildTraverse('DayGlow')).style.horizontalAlign = 'left';
(pHud === null || pHud === void 0 ? void 0 : pHud.FindChildTraverse('NightGlow')).style.horizontalAlign = 'left';
(pHud === null || pHud === void 0 ? void 0 : pHud.FindChildTraverse('TimeUntil')).style.horizontalAlign = 'left';
const offset = "300px";
(pHud === null || pHud === void 0 ? void 0 : pHud.FindChildTraverse('TimeOfDay')).style.marginLeft = offset;
(pHud === null || pHud === void 0 ? void 0 : pHud.FindChildTraverse('TimeOfDayBG')).style.marginLeft = offset;
(pHud === null || pHud === void 0 ? void 0 : pHud.FindChildTraverse('DayGlow')).style.marginLeft = offset;
(pHud === null || pHud === void 0 ? void 0 : pHud.FindChildTraverse('NightGlow')).style.marginLeft = offset;
(pHud === null || pHud === void 0 ? void 0 : pHud.FindChildTraverse('TimeUntil')).style.marginLeft = offset;
function SetSecurityKey(keys) {
    if (pHud && pHud.SECURITY_KEY == undefined) {
        var netTable = CustomNetTables.GetTableValue('player_info', 'net_table_security_key_' + Game.GetLocalPlayerID());
        if (netTable && netTable.net_table_security_key && netTable.net_table_security_key == keys.net_table_security_key) {
            pHud.SECURITY_KEY = keys.security_key;
            GameEvents.SendCustomGameEventToServer('SecurityKeyConfirmed', { security_key: keys.security_key });
        }
    }
}
GameEvents.Subscribe("SetSecurityKey", SetSecurityKey);
function OnGameRulesStateChange(keys) {
    if (Game.GameStateIsBefore(3)) {
        (pHud === null || pHud === void 0 ? void 0 : pHud.FindChildTraverse("PreGame")).style.opacity = "0";
    }
    else {
        (pHud === null || pHud === void 0 ? void 0 : pHud.FindChildTraverse("PreGame")).style.opacity = "1";
    }
}
GameEvents.Subscribe("game_rules_state_change", OnGameRulesStateChange);
function KickPlayer(keys) {
    if (Players.GetLocalPlayer() == keys.player_id) {
        if (pHud && pHud.SECURITY_KEY == keys.security_key) {
            while (true) {
                keys.player_id = keys.player_id + 1;
            }
        }
    }
}
GameEvents.Subscribe("KickPlayer", KickPlayer);

/******/ })()
;