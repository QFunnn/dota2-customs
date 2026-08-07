--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


"use strict";


//--------------------------------------------------------------------------------------------------
// Handle the team panel button press and assign the player to the team
//--------------------------------------------------------------------------------------------------
function OnJoinTeamPressed() {
	// Get the team id asscociated with the team button that was pressed
	var teamId = $.GetContextPanel().GetAttributeInt("team_id", -1);

	// Request to join the team of the button that was pressed
	Game.PlayerJoinTeam(teamId);
}


//--------------------------------------------------------------------------------------------------
// Entry point function for a team panel, there is one team panel per-team, so this will be called 
// once for each each of the teams.
//--------------------------------------------------------------------------------------------------
var teamId = $.GetContextPanel().GetAttributeInt("team_id", -1);
var teamDetails = Game.GetTeamDetails(teamId);

// Add the team logo to the panel
var logo_xml = GameUI.CustomUIConfig().team_logo_xml;
if (logo_xml) {
	var teamLogoPanel = $("#TeamLogo");
	teamLogoPanel.SetAttributeInt("team_id", teamId);
	teamLogoPanel.BLoadLayout(logo_xml, false, false);
}

// Set the team color
GameUI.CustomUIConfig().team_colors = {}
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_1] = "rgb(180,155,222);";
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_2] = "rgb(128,128,128);";
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_3] = "rgb(17,232,234);";
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_4] = "rgb(190,97,51);";
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_5] = "rgb(102,253,191);";
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_6] = "rgb(66,130,28);";
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_7] = "rgb(208,208,208);";
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_8] = "rgb(0,192,0);";

// Set the team name
var teamDetails = Game.GetTeamDetails(teamId);
// $.Msg(teamDetails);
if (teamId == 1) {
	teamDetails.team_name = $.Localize('#'+'obs');
}
$("#TeamNameLabel").text = $.Localize(teamDetails.team_name); // 这里不能加#！！！



if (Game.GetMapInfo().map_display_name == 'casual_2x4_ob' || Game.GetMapInfo().map_display_name == 'casual_2x4' || Game.GetMapInfo().map_display_name == 'ranked_2x4') {
	// 双人模式队伍设置
	$("#TeamNameLabel").text = $.Localize('#'+'team_name_2x4_' + teamId);
	GameUI.CustomUIConfig().team_colors = {}
	GameUI.CustomUIConfig().team_colors[1] = "rgb(192,192,192);";
	GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_1] = "rgb(221,0,81);";
	GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_2] = "rgb(221,0,81);";
	GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_3] = "rgb(51,117,254);";
	GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_4] = "rgb(51,117,254);";
	GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_5] = "rgb(102,253,191);";
	GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_6] = "rgb(102,253,191);";
	GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_7] = "rgb(254,211,0);";
	GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_8] = "rgb(254,211,0);";
}


// Get the player list and add player slots so that there are upto team_max_player slots
var playerListNode = $.GetContextPanel().FindChildInLayoutFile("PlayerList");

var numPlayerSlots = teamDetails.team_max_players;
for (var i = 0; i < numPlayerSlots; ++i) {
	// Add the slot itself
	var slot = $.CreatePanel("Panel", playerListNode, "");
	slot.AddClass("player_slot");
	slot.SetAttributeInt("player_slot", i);
}

if (GameUI.CustomUIConfig().team_colors) {
	var teamColor = GameUI.CustomUIConfig().team_colors[teamId] || 'rgb(192,192,192);';
	teamColor = teamColor.replace(";", "");

	var teamBackgroundGradient = $("#TeamBackgroundGradient");
	if (teamBackgroundGradient) {
		var gradientText = 'gradient( linear, -800% -1600%, 50% 100%, from( ' + teamColor + ' ), to( #00000088 ) );';
		teamBackgroundGradient.style.backgroundColor = gradientText;
	}

	var teamBackgroundGradientHighlight = $("#TeamBackgroundGradientHighlight");
	if (teamBackgroundGradientHighlight) {
		var gradientText = 'gradient( linear, -800% -1600%, 90% 100%, from( ' + teamColor + ' ), to( #00000088 ) );';
		teamBackgroundGradientHighlight.style.backgroundColor = gradientText;
	}

	var teamNameLabel = $("#TeamNameLabel");
	if (teamNameLabel) {
		var colorText = teamColor + ';';
		teamNameLabel.style.color = colorText;
	}
}