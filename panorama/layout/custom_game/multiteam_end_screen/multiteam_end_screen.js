--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
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
	$("#WodaLogo").SetHasClass("ArenaLogo", /^(arena|1_player|4_player)$/.test(Game.GetMapInfo().map_display_name));
	
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
	 
	var local_player_id = Players.GetLocalPlayer();
	var end_player_table = GameUI.CustomUIConfig().DATA_TABLE_SERVER["end_game_player"];
	var local_stats = end_player_table ? end_player_table[String(local_player_id)] : null;
	if (local_stats)
	{
		var stats_data = {};
		for (var stats_key in local_stats)
		{
			stats_data[stats_key] = local_stats[stats_key];
		}
		var local_rating_end = GameUI.CustomUIConfig().DATA_TABLE_SERVER["rating_end"][String(local_player_id)];
		if (local_rating_end) 
		{
			stats_data.rating_change = local_rating_end.rating || 0;
			stats_data.is_double = (local_rating_end.is_double === 1 || local_rating_end.is_double === true) ? 1 : 0;
		}
		var local_coins_end = GameUI.CustomUIConfig().DATA_TABLE_SERVER["coins_end"][String(local_player_id)];
		if (local_coins_end)
		{
			stats_data.coins_change = local_coins_end.coin || 0;
		}
		var local_stats_panel = PlayerStatsPanel_Create($("#LocalPlayerStats"), true);
		PlayerStatsPanel_Fill(local_stats_panel, stats_data);
		ShowArenaResult(local_stats_panel)
		$("#LocalPlayerStats").visible = true;
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

    WodaShowAdBanner($("#WowBanner"))

    UpdateStoreBackground()
})();

var END_SCREEN_IS_DEFAULT_STATS = true

function ChangeGameStats()
{
    END_SCREEN_IS_DEFAULT_STATS = !END_SCREEN_IS_DEFAULT_STATS
    $.GetContextPanel().SetHasClass("AltStats", !END_SCREEN_IS_DEFAULT_STATS)
}

function ShowArenaResult(stats_panel)
{
    if (!stats_panel) { return }
    var block = stats_panel.FindChildTraverse("PlayerStatsArenaResult")
    var badge = stats_panel.FindChildTraverse("PlayerStatsArenaResultBadge")
    var number = stats_panel.FindChildTraverse("PlayerStatsArenaResultNumber")
    if (!block || !badge || !number) { return }
    var results = GameUI.CustomUIConfig().DATA_TABLE_SERVER["arena_pve_result"]
    var result = results ? results[String(Players.GetLocalPlayer())] : null
    if (!result || result.difficulty === undefined) { return }
    var difficulty = Number(result.difficulty) || 1
    number.text = String(difficulty)
    block.SetHasClass("Victory", Number(result.victory) == 1)
    block.AddClass("Visible")
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