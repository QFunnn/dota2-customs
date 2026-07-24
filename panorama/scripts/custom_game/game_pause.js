--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
const TOGGLE_PAUSE_COMMAND = "rr_toggle_game_pause";
const TOGGLE_PAUSE_FALLBACK_KEY = "F9";
function requestTogglePause() {
    GameEvents.SendCustomGameEventToServer("toggle_game_pause", {});
}
function registerTogglePauseKeyBind() {
    Game.AddCommand(TOGGLE_PAUSE_COMMAND, requestTogglePause, "Toggle custom game pause", 0);
    const dotaPauseKey = Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_PAUSE);
    const pauseKey = dotaPauseKey !== "" ? dotaPauseKey : TOGGLE_PAUSE_FALLBACK_KEY;
    Game.CreateCustomKeyBind(pauseKey, TOGGLE_PAUSE_COMMAND);
}
function onUnpauseDenied(event) {
    const message = $.Localize("#rr_pause_unpause_denied").replace("{seconds}", String(event.remainingSeconds));
    GameEvents.SendEventClientSide("dota_hud_error_message", {
        reason: 80,
        message,
        sequenceNumber: 1,
    });
}
registerTogglePauseKeyBind();
GameEvents.Subscribe("pause_unpause_denied", onUnpauseDenied);