--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
const teamSelectRoot = $("#TeamSelect");
const playerPanelById = {};
const gameSetupListeners = [];
const gameSetupNetTableListeners = [];
function createPlayerPanels() {
    // for (let i = 0; i < 8; i++)
    for (const teamId of Game.GetAllTeamIDs()) {
        const teamPlayerIds = Game.GetPlayerIDsOnTeam(teamId);
        if (teamPlayerIds.length === 0) {
            continue;
        }
        const teamContainer = $.CreatePanel("Panel", teamSelectRoot, "");
        teamContainer.AddClass("TeamContainer");
        createTeamBadge(teamContainer, teamId);
        const teamPlayersContainer = $.CreatePanel("Panel", teamContainer, "");
        teamPlayersContainer.AddClass("TeamPlayers");
        // for (let i = 0; i < 2; i++)
        for (const playerId of teamPlayerIds) {
            createPlayerPanel(teamPlayersContainer, playerId);
        }
    }
}
function createTeamBadge(teamPanel, teamId) {
    const teamBadge = $.CreatePanel("Panel", teamPanel, "");
    teamBadge.AddClass("TeamBadge");
    const teamIcon = $.CreatePanel("Panel", teamBadge, "");
    teamIcon.AddClass("TeamIconMount");
    teamIcon.SetAttributeInt("team_id", teamId);
    teamIcon.BLoadLayout("file://{resources}/layout/custom_game/team_icon.xml", false, false);
    const divider = $.CreatePanel("Panel", teamBadge, "");
    divider.AddClass("TeamBadgeDivider");
}
function createPlayerPanel(teamPanel, playerId) {
    const playerPanel = $.CreatePanel("Panel", teamPanel, "player_panel_" + playerId);
    playerPanel.BLoadLayoutSnippet("Player");
    setPlayerStatsLoaded(playerPanel, false);
    const playerSteamId = getSteamId32(playerId);
    const avatar = playerPanel.FindChildTraverse("Avatar");
    avatar.accountid = playerSteamId.toString();
    const usernamePanel = playerPanel.FindChildTraverse("Username");
    usernamePanel.accountid = playerSteamId.toString();
    playerPanelById[playerSteamId] = playerPanel;
}
function clearPlayerPanels() {
    teamSelectRoot.RemoveAndDeleteChildren();
    Object.keys(playerPanelById).forEach(playerUid => {
        delete playerPanelById[Number(playerUid)];
    });
}
function subscribeToRatingUpdate() {
    applyCurrentPlayerRating();
    gameSetupNetTableListeners.push(CustomNetTables.SubscribeNetTableListener("service", (_, keyName, data) => {
        if (keyName !== "player_rank")
            return;
        updatePlayerRating(data);
    }));
}
function applyCurrentPlayerRating() {
    var _a;
    const data = ((_a = CustomNetTables.GetTableValue("service", "player_rank")) !== null && _a !== void 0 ? _a : {});
    updatePlayerRating(data);
}
function updatePlayerRating(rankInfo) {
    // $.Msg("updatePlayerRating call")
    Object.entries(rankInfo).forEach(([playerUidStr, info]) => {
        const panel = playerPanelById[Number(playerUidStr)];
        if (!panel) {
            return;
        }
        setPanelLabelText(panel, "Rating", info.score.toString());
        setPanelLabelText(panel, "PlayTime", info.play_time.toString());
        setPlayerStatsLoaded(panel, true);
    });
}
function setPlayerStatsLoaded(panel, isLoaded) {
    const ratingInfo = panel.FindChildTraverse("RatingInfo");
    if (!ratingInfo) {
        return;
    }
    ratingInfo.SetHasClass("StatsLoaded", isLoaded);
}
function setPanelLabelText(panel, childId, text) {
    const label = panel.FindChildTraverse(childId);
    if (!label) {
        return;
    }
    label.text = text;
}
function RecreatePlayerPanel() {
    clearPlayerPanels();
    createPlayerPanels();
    applyCurrentPlayerRating();
}
Game.AutoAssignPlayersToTeams();
$.Schedule(1, () => {
    RecreatePlayerPanel();
    subscribeToRatingUpdate();
});
gameSetupListeners.push(GameEvents.Subscribe("dota_player_team_changed", () => {
    updateGameSetupState();
}));
const DOTAGame_TeamPlayerListChangedListenerId = $.RegisterForUnhandledEvent("DOTAGame_TeamPlayerListChanged", () => {
    $.Schedule(0, () => updateGameSetupState());
});
gameSetupListeners.push(GameEvents.Subscribe("dota_player_connection_state_changed", () => {
    updateGameSetupState();
}));
gameSetupListeners.push(GameEvents.Subscribe("dota_game_state_change", (event) => {
    if (Game.GameStateIsAfter(DOTA_GameState.DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD)) {
        gameSetupListeners.forEach(listenerId => {
            GameEvents.Unsubscribe(listenerId);
        });
        gameSetupNetTableListeners.forEach(listenerId => {
            CustomNetTables.UnsubscribeNetTableListener(listenerId);
        });
        $.UnregisterForUnhandledEvent("DOTAGame_TeamPlayerListChanged", DOTAGame_TeamPlayerListChangedListenerId);
        $.Msg("GameSetup listeners was closed.");
    }
}));
function updateGameSetupState() {
    Game.AutoAssignPlayersToTeams();
    RecreatePlayerPanel();
}