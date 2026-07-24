--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";

function InitEndScreen() 
{
	const CustomUIContainerHUD = $.GetContextPanel().GetParent()
	for (const panel of CustomUIContainerHUD.Children())
		if (panel.BHasClass("MainPick"))
			panel.style.visibility = "collapse"

	var dotahud = $.GetContextPanel().GetParent().GetParent().GetParent().GetParent()
    dotahud.FindChildTraverse("TopBarScoreboard").style.visibility = 'collapse'

    $.GetContextPanel().RemoveClass("EndScreen_Points_collapse")

	const CustomUIRoot = CustomUIContainerHUD.GetParent()

	const HeroSelection = CustomUIRoot.FindChild("CustomUIContainer_HeroSelection")
	if (HeroSelection !== null)
		HeroSelection.style.visibility = "collapse"

	const HudTopBar = CustomUIRoot.FindChild("CustomUIContainer_HudTopBar")
	if (HudTopBar !== null)
		HudTopBar.style.visibility = "collapse"


	if ( ScoreboardUpdater_InitializeScoreboard === null ) { $.Msg( "WARNING: This file requires shared_scoreboard_updater.js to be included." ); }

	var scoreboardConfig =
	{
		"teamXmlName" : "file://{resources}/layout/custom_game/multiteam_end_screen_team.xml",
		"playerXmlName" : "file://{resources}/layout/custom_game/multiteam_end_screen_player.xml",
	};

	var endScoreboardHandle = ScoreboardUpdater_InitializeScoreboard( scoreboardConfig, $( "#TeamsContainer" ) );
	$.GetContextPanel().SetHasClass( "endgame", 1 );
	
	var teamInfoList = ScoreboardUpdater_GetSortedTeamInfoList( endScoreboardHandle );
	var delay = 0.2;
	var delay_per_panel = 1 / teamInfoList.length;
	for ( var teamInfo of teamInfoList )
	{
		var teamPanel = ScoreboardUpdater_GetTeamPanel( endScoreboardHandle, teamInfo.team_id );
	
		if (teamPanel)
		{
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
		endScreenVictory.SetDialogVariable( "winning_team_name", $.Localize( winningTeamDetails.team_name ) );
		if ( GameUI.CustomUIConfig().team_colors )
		{
			var teamColor = GameUI.CustomUIConfig().team_colors[ winningTeamId ];
			teamColor = teamColor.replace( ";", "" );
			endScreenVictory.style.color = teamColor + ";";
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

	let kv = {"exp":0,"total_games":140,"kills":0,"expire":0,"place":1,"rating_before":0,"rating_change":0,"runes":0,"calibration_games":0,"valid_time":1,"level":1,"towers":0,"randomed":1,"points": 500,"subscribed":1,"achivment_table":{"1": {"amount":3000, "id":2, "completed":1}, "2": {"amount":3000, "id":1, "completed":1}}, "quest_table":{"shards":15,"icon":"Hook","exp":80,"completed":1,"name":"Pudge.Quest_5"},"n":625258387}
	//EndScreen_game_end(kv)
	
	let main_panel = $.GetContextPanel().FindChildTraverse("CustomBg")
	if (main_panel)
	{
		let BackgroundScene = $.CreatePanel("DOTAScenePanel", main_panel, 'BackgroundScene', {map:'maps/backgrounds/dashboard_parallax_ti6_initial.vmap', hittest:'true'})
		BackgroundScene.AddClass("BackgroundScene")
	}

	CreateTalentPanel()

	var EndScreenTalents = $.GetContextPanel().FindChildTraverse("EndScreenTalents")
	if (EndScreenTalents)
		EndScreenTalents.RemoveClass("EndScreenTalents_show")

	let button = $.GetContextPanel().FindChildTraverse("EndHeroesData_HeaderTalentsButton")
	if (button)
		button.RemoveClass("EndScreen_Points_collapse")

	var TalentButton = $.GetContextPanel().FindChildTraverse("EndHeroesData_HeaderTalentsPanel")
	if (TalentButton)
		SetShowTalent(TalentButton, Players.GetPlayerSelectedHero(Game.GetLocalPlayerID()))

	TryLoadChestGrantedPopup()
}

var CHEST_POPUP_DELAY = 1

function TryLoadChestGrantedPopup()
{
	if (!GameUI.CustomUIConfig().chest_popup_pending) { return }
	GameUI.CustomUIConfig().chest_popup_pending = false
	let parent = $.GetContextPanel()
	$.Schedule(CHEST_POPUP_DELAY, function()
	{
		let holder = parent.FindChildTraverse("chest_granted_popup_holder")
		if (!holder)
		{
			holder = $.CreatePanel("Panel", parent, "chest_granted_popup_holder")
			holder.AddClass("ChestGrantedPopupHolder")
			holder.hittest = false
		}
		holder.RemoveAndDeleteChildren()
		holder.BLoadLayout("file://{resources}/layout/custom_game/info_reports/chest_granted_popup/chest_granted_popup.xml", false, false)
	})
}


function init()
{
	GameEvents.Subscribe('GameEnded', InitEndScreen)

	const val = CustomNetTables.GetTableValue("networth_players", "")
	if (val !== undefined && val.game_ended) 
	{
		$.Msg("END SCREEN START")
		InitEndScreen()
		return
	}
}
init()