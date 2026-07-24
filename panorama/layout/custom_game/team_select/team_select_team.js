--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";


//--------------------------------------------------------------------------------------------------
// Handle the team panel button press and assign the player to the team
//--------------------------------------------------------------------------------------------------
function OnJoinTeamPressed()
{
	// Get the team id asscociated with the team button that was pressed
	var teamId = $.GetContextPanel().GetAttributeInt( "team_id", -1 );

	// Request to join the team of the button that was pressed
	Game.PlayerJoinTeam( teamId );
}


//--------------------------------------------------------------------------------------------------
// Entry point function for a team panel, there is one team panel per-team, so this will be called 
// once for each each of the teams.
//--------------------------------------------------------------------------------------------------
(function ()
{	
	var teamId = $.GetContextPanel().GetAttributeInt( "team_id", -1 );
	var teamDetails = Game.GetTeamDetails( teamId );

	// Set the team name
	var teamDetails = Game.GetTeamDetails( teamId );
	
	// Get the player list and add player slots so that there are upto team_max_player slots
	var playerListNode = $.GetContextPanel().FindChildInLayoutFile( "PlayerList" );

	var numPlayerSlots = teamDetails.team_max_players;
	for ( var i = 0; i < numPlayerSlots; ++i )
	{
		// Add the slot itself
		var slot = $.CreatePanel( "Panel", playerListNode, "" );
		slot.AddClass( "player_slot" );
		slot.SetAttributeInt( "player_slot", i );
	}

	if ( GameUI.CustomUIConfig().team_colors )
	{
		var teamColor = GameUI.CustomUIConfig().team_colors[ teamId ];
		teamColor = teamColor.replace( ";", "" );
		
		var teamBackgroundGradient = $( "#TeamBackgroundGradient" );
		if ( teamBackgroundGradient )
		{
			var gradientText = 'gradient( linear, -800% -1600%, 90% 100%, from( ' + teamColor + ' ), to( #00000088 ) );';
			teamBackgroundGradient.style.backgroundColor = gradientText;	
		}

		var teamBackgroundGradientHighlight = $( "#TeamBackgroundGradientHighlight" );
		if ( teamBackgroundGradientHighlight )
		{
			var gradientText = 'gradient( linear, -800% -1600%, 90% 100%, from( ' + teamColor + ' ), to( #00000088 ) );';
			teamBackgroundGradientHighlight.style.backgroundColor = gradientText;
		}		
	}
	

})();