--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


/******/ (() => { // webpackBootstrap
/*!*********************************!*\
  !*** ./utils/hidePickScreen.js ***!
  \*********************************/
(function () {
  HidePickScreen();
  function HidePickScreen() {
    var PreGame = $.GetContextPanel().GetParent().GetParent().FindChildTraverse("PreGame");
    if (Game.GetState() <= DOTA_GameState.DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP) {
      if (PreGame) {
        PreGame.style.opacity = "0";
      }
      $.Schedule(1.0, HidePickScreen);
    } else {
      if (PreGame) {
        PreGame.style.opacity = "1";
      }
    }
  }
})();
/******/ })()
;