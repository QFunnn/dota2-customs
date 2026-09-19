--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";
const PLAYER_LOSE_WINDOW_NAME = "HUD_PlayerLose";
const playerLoseRoot = $("#HUD_PlayerLose_root");
const playerLoseRankText = $("#rank_main_text");
const playerLoseScoreOrigin = $("#DotaMind_main_origin");
const playerLoseScoreNew = $("#DotaMind_main_new");
const playerLoseConfirmButton = $("#PlayerLose_ConfirmButton");
let playerLoseWindowState = false;
let playerLoseGameRank = 8;
let playerLoseTeamCount = 8;
let playerLoseNewScore = 0;
let playerLoseOriginScore = 0;
function updatePlayerLoseLabels() {
    playerLoseRankText.text = `${playerLoseGameRank} / ${playerLoseTeamCount}`;
    playerLoseScoreOrigin.text = playerLoseOriginScore.toFixed(0);
    playerLoseScoreNew.text = playerLoseNewScore.toFixed(0);
}
function showPlayerLoseWindow(show) {
    playerLoseWindowState = show;
    if (show) {
        playerLoseRoot.visible = true;
        $.Schedule(0, () => {
            if (playerLoseWindowState) {
                playerLoseRoot.AddClass("Show");
            }
        });
    }
    else {
        playerLoseRoot.RemoveClass("Show");
        playerLoseRoot.visible = false;
    }
}
function togglePlayerLoseWindow(wishState) {
    if (typeof ToggleWindows === "function") {
        ToggleWindows(PLAYER_LOSE_WINDOW_NAME, wishState);
        return;
    }
    showPlayerLoseWindow(typeof wishState === "boolean" ? wishState : !playerLoseWindowState);
}
(() => {
    playerLoseRoot.visible = false;
    playerLoseConfirmButton.SetPanelEvent("onactivate", () => {
        togglePlayerLoseWindow(false);
    });
    GameEvents.Subscribe("custom_ui_toggle_windows", (event) => {
        const data = event;
        if (data.window_name === PLAYER_LOSE_WINDOW_NAME) {
            showPlayerLoseWindow(typeof data.show_state === "boolean" ? data.show_state : !playerLoseWindowState);
        }
        else {
            showPlayerLoseWindow(false);
        }
    });
    GameEvents.Subscribe("ShowPlayerLose", (event) => {
        var _a, _b;
        playerLoseGameRank = event.game_rank;
        playerLoseTeamCount = event.valid_team;
        playerLoseNewScore = (_a = event.score) !== null && _a !== void 0 ? _a : 0;
        playerLoseOriginScore = (_b = event.originScore) !== null && _b !== void 0 ? _b : 0;
        updatePlayerLoseLabels();
        togglePlayerLoseWindow(true);
    });
    updatePlayerLoseLabels();
})();