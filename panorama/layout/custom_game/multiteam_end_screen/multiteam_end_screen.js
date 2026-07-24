--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";

(function()
{
	if ( ScoreboardUpdater_InitializeScoreboard === null ) { $.Msg( "WARNING: This file requires shared_scoreboard_updater.js to be included." ); }

	var scoreboardConfig =
	{
		"teamXmlName" : "file://{resources}/layout/custom_game/multiteam_end_screen/multiteam_end_screen_team.xml",
		"playerXmlName" : "file://{resources}/layout/custom_game/multiteam_end_screen/multiteam_end_screen_player.xml",
	};

	var endScoreboardHandle = ScoreboardUpdater_InitializeScoreboard( scoreboardConfig, $( "#TeamsContainer" ) );
	$.GetContextPanel().SetHasClass( "endgame", 1 );
	
	var teamInfoList = ScoreboardUpdater_GetSortedTeamInfoList( endScoreboardHandle );
	var delay = 0.2;
	var delay_per_panel = 1 / teamInfoList.length;
	for ( var teamInfo of teamInfoList )
	{
		var teamPanel = ScoreboardUpdater_GetTeamPanel( endScoreboardHandle, teamInfo.team_id );
		if (teamPanel) {
			teamPanel.SetHasClass( "team_endgame", false );
			var callback = function( panel )
			{
				return function(){ panel.SetHasClass( "team_endgame", 1 ); }
			}( teamPanel ); 
			$.Schedule( delay, callback )
			delay += delay_per_panel;
		}
	}
	
	var winningTeamId = Game.GetGameWinner();
	var winningTeamDetails = Game.GetTeamDetails( winningTeamId );
	var endScreenVictory = $( "#EndScreenVictory" );
	if ( endScreenVictory )
	{
		endScreenVictory.SetDialogVariable( "winning_team_name", $.Localize( "#" + winningTeamDetails.team_name ) );
		if ( GameUI.CustomUIConfig().team_colors )
		{
			var teamColor = GameUI.CustomUIConfig().team_colors[ winningTeamId ];
			teamColor = teamColor.replace( ";", "" );
			endScreenVictory.style.color = teamColor + ";";
		}
	}

    if (GameUI.CustomUIConfig().DATA_TABLE_SERVER["tournament_data"] && GameUI.CustomUIConfig().DATA_TABLE_SERVER["tournament_data"]["IsTournamentGame"])
    {
        $("#IsTournamentGame").visible = true
        $("#TornamentBansCounter").text = $.Localize("#tournament_ban_in_game") + " " + "<font color='" + "gold" + "'>" + GameUI.CustomUIConfig().DATA_TABLE_SERVER["tournament_data"]["bans_counter"] + "</font>"
        if (GameUI.CustomUIConfig().DATA_TABLE_SERVER["tournament_data"]["random"])
        {
            $("#TournamentRandomHero").visible = true
        }
    }

	var winningTeamLogo = $( "#WinningTeamLogo" );
	if ( winningTeamLogo )
	{
		var logo_xml = GameUI.CustomUIConfig().team_logo_large_xml;
		if ( logo_xml )
		{
			winningTeamLogo.SetAttributeInt( "team_id", winningTeamId );
			winningTeamLogo.BLoadLayout( logo_xml, false, false );
		}
	}
    
    if (IsPlayerHasSubscribe(Game.GetLocalPlayerID())) 
    {
        let StatsButton = $("#StatsButton");
        if (StatsButton) 
        {
            StatsButton.visible = true
        }
    }

    UpdateStoreBackground()
})();

var IS_DEFAULT_STATS = true

function ChangeGameStats()
{
    IS_DEFAULT_STATS = !IS_DEFAULT_STATS
    $.GetContextPanel().SetHasClass("AltStats", !IS_DEFAULT_STATS)
}

function UpdateStoreBackground()
{
    let PLAYER_DATA = Game.GetCustomTable("woda_player_data", String(Players.GetLocalPlayer()));
    let CustomBg = $("#CustomBg")
    let MovieBackground = $("#MovieBackground")
    if (PLAYER_DATA && PLAYER_DATA.background_id)
    {
        CustomBg.style.backgroundImage = 'url("' + Background_Images[PLAYER_DATA.background_id] + '")'
        CustomBg.style.backgroundSize = "100%"
        MovieBackground.visible = false
        MovieBackground.style.opacity = "0"
    }
    else
    {
        MovieBackground.style.opacity = "1"
    }
}