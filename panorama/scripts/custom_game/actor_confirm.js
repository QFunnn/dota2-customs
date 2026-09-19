--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";
const actorInfoPanel = $("#ActorPanel");
const actorInfoReportButton = $("#ActorReportButton");
const actorInfoAvatarImage = $("#ActorInfoAvatarImage");
const actorInfoHeroImage = $("#ActorInfoHeroImage");
const actorInfoPlayerNameLabel = $("#ActorInfoPlayerName");
const actorInfoTeamLogo = $("#ActorInfoTeamLogo");
const actorInfoHeroNameLabel = $("#ActorInfoHeroName");
const actorInfoMatchesLabel = $("#ActorInfoMatches");
const actorInfoRankLabel = $("#ActorInfoRank");
let actorInfoLastTeamId = -1;
GameUI.ShowActorPanel = (targetPlayerId) => ShowActorPanel(targetPlayerId);
function ShowActorPanel(targetPlayerId) {
    const targetPlayerInfo = Game.GetPlayerInfo(targetPlayerId);
    actorInfoReportButton.enabled = false;
    if (targetPlayerInfo != undefined) {
        const heroName = targetPlayerInfo.player_selected_hero || "";
        actorInfoAvatarImage.steamid = targetPlayerInfo.player_steamid;
        actorInfoHeroImage.heroname = heroName;
        actorInfoPlayerNameLabel.text = targetPlayerInfo.player_name;
        const teamColor = getPlayerTeamColor(targetPlayerInfo);
        actorInfoPlayerNameLabel.style.color = teamColor;
        updateTeamLogo(targetPlayerInfo.player_team_id);
        actorInfoHeroNameLabel.text = heroName
            ? $.Localize("#hero_level") + " " + targetPlayerInfo.player_level + " " + $.Localize("#" + heroName)
            : $.Localize("#PlayerInfo_no_hero");
        const rankData = getPlayerRankData(targetPlayerId);
        actorInfoMatchesLabel.text = formatStatValue(rankData === null || rankData === void 0 ? void 0 : rankData.play_time);
        actorInfoRankLabel.text = formatStatValue(rankData === null || rankData === void 0 ? void 0 : rankData.score);
    }
    actorInfoPanel.RemoveClass("Hidden");
}
function getPlayerRankData(playerId) {
    const rankTable = CustomNetTables.GetTableValue("service", "player_rank");
    return rankTable === null || rankTable === void 0 ? void 0 : rankTable[String(getSteamId32(playerId))];
}
function getPlayerTeamColor(playerInfo) {
    var _a;
    const teamId = playerInfo.player_team_id;
    const teamColors = GameUI.CustomUIConfig().team_colors;
    return (_a = teamColors === null || teamColors === void 0 ? void 0 : teamColors[teamId]) !== null && _a !== void 0 ? _a : "#dde6f0";
}
function updateTeamLogo(teamId) {
    if (actorInfoLastTeamId === teamId) {
        return;
    }
    const logoXml = GameUI.CustomUIConfig().team_logo_xml;
    if (!logoXml) {
        return;
    }
    actorInfoLastTeamId = teamId;
    actorInfoTeamLogo.RemoveAndDeleteChildren();
    actorInfoTeamLogo.SetAttributeInt("team_id", teamId);
    actorInfoTeamLogo.BLoadLayout(logoXml, false, false);
}
function formatStatValue(value) {
    return value == null ? "-" : String(value);
}
// function Confirm() {
//     var target_player_id = $("#ActorPanel").target_player_id
//     if (max_time > used_time) {
//         GameEvents.SendCustomGameEventToServer("ConfirmActor", {
//             player_id: Game.GetLocalPlayerInfo().player_id,
//             target_player_id: target_player_id,
//             actor_ui_secret: $("#ActorPanel").actor_ui_secret
//         });
//         $("#ActorPanel").AddClass("Hidden")
//         used_time = used_time + 1
//     }
// }
function Cancel() {
    actorInfoPanel.AddClass("Hidden");
}