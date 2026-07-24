--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";

var g_ScoreboardHandle = null;

function UpdateScoreboard() {
    if(Game.GameStateIsAfter( DOTA_GameState.DOTA_GAMERULES_STATE_GAME_IN_PROGRESS )){
        $.GetContextPanel().AddClass("EndScreen");
        return;
    }
    ScoreboardUpdater_SetScoreboardActive(g_ScoreboardHandle, true);

    $.Schedule(0.2, UpdateScoreboard);
}

(function () {
    var shouldSort = true;

    if (GameUI.CustomUIConfig().multiteam_top_scoreboard) {
        var cfg = GameUI.CustomUIConfig().multiteam_top_scoreboard;
        if (cfg.LeftInjectXMLFile) {
            $("#LeftInjectXMLFile").BLoadLayout(cfg.LeftInjectXMLFile, false, false);
        }
        if (cfg.RightInjectXMLFile) {
            $("#RightInjectXMLFile").BLoadLayout(cfg.RightInjectXMLFile, false, false);
        }

        if (typeof cfg.shouldSort !== "undefined") {
            shouldSort = cfg.shouldSort;
        }
    }
    
    var scoreboardConfig = {
        "teamXmlName": "file://{resources}/layout/custom_game/multiteam_top_scoreboard/multiteam_top_scoreboard_team.xml",
        "playerXmlName": "file://{resources}/layout/custom_game/multiteam_top_scoreboard/multiteam_top_scoreboard_player.xml",
        "shouldSort": shouldSort,
    };
    g_ScoreboardHandle = ScoreboardUpdater_InitializeScoreboard(scoreboardConfig, $("#MultiteamScoreboard"));
    
    UpdateScoreboard();
})();