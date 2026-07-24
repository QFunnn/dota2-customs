--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
const loadingProgressFill = $("#LoadingProgressFill");
const loadingPanel = $("#BottomLoadingProgress");
updateLoadingProgress();
function updateLoadingProgress() {
    if (!loadingProgressFill) {
        return;
    }
    const playerIds = Game.GetAllPlayerIDs();
    let totalPlayers = playerIds.length;
    let connectedPlayers = 0;
    for (const playerId of playerIds) {
        if (!Players.IsValidPlayerID(playerId) || Game.GetPlayerInfo(playerId).player_steamid === "0") {
            continue;
        }
        if (Game.GetPlayerInfo(playerId).player_connection_state === DOTAConnectionState_t.DOTA_CONNECTION_STATE_CONNECTED) {
            connectedPlayers++;
        }
    }
    const progress = totalPlayers === 0 ? 0 : Math.min(100, Math.max(0, (connectedPlayers / totalPlayers) * 100));
    loadingProgressFill.style.width = `${progress}%`;
    $.Schedule(2, () => loadingPanel.visible = 100 !== progress);
    $.Schedule(0.5, updateLoadingProgress);
}