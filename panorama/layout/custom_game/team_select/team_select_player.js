--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";

var rating = 0;

//--------------------------------------------------------------------------------------------------
// Handeler for when the unssigned players panel is clicked that causes the player to be reassigned
// to the unssigned players team
//--------------------------------------------------------------------------------------------------
function OnLeaveTeamPressed()
{
    Game.PlayerJoinTeam( 5 ); // 5 == unassigned ( DOTA_TEAM_NOTEAM )
}

function GetCurrentSeason()
{
    // let tbl = CustomNetTables.GetTableValue("cha_server_data", "current_season")
    // if (tbl && tbl.season)
    // {
    //     return tbl.season
    // }
    return 1
}

function p(s){$.Msg(s);}
//--------------------------------------------------------------------------------------------------
// Update the contents of the player panel when the player information has been modified.
//--------------------------------------------------------------------------------------------------
function OnPlayerDetailsChanged()
{
    var playerId = $.GetContextPanel().GetAttributeInt("player_id", -1);
    var playerInfo = Game.GetPlayerInfo( playerId );
    if ( !playerInfo )
        return;

    $( "#PlayerName" ).text = playerInfo.player_name;
    $( "#PlayerAvatar" ).steamid = playerInfo.player_steamid;
    $.GetContextPanel().SetHasClass( "player_is_local", playerInfo.player_is_local );
    $.GetContextPanel().SetHasClass( "player_has_host_privileges", playerInfo.player_has_host_privileges );

    var rank_info = CustomNetTables.GetTableValue("players_server_info", `player_${playerId}`)
    

    if (rank_info != null) {
       
        if (rank_info && rank_info.profile)
       {    
            if ( (rank_info.profile.rating_number_in_top > 0 && rank_info.profile.rating_number_in_top <= 10) && rank_info.profile.rating >= 5420)
            {
                    $("#rank_image").style.backgroundImage = 'url("file://{images}/custom_game/ranks/' + GetImageRank(10000) + '.png")';
            } else {
                    $("#rank_image").style.backgroundImage = 'url("file://{images}/custom_game/ranks/' + GetImageRank(rank_info.profile.rating) + '.png")';
            }
            $("#rank_image").style.backgroundSize = "100%" 
            $("#PlayTime").text = (rank_info.profile.rating || $.Localize("#dota_mind_calibrating"))
            $("#EarlyLeave").text = (rank_info.profile.total_games)
            // }
            $("#rank_number").text = rank_info.profile.rating_number_in_top
       }

    } else {
        if (Game.GetState() == 2) {
            $.Schedule(0.3, OnPlayerDetailsChanged);
        }
    }
}


//--------------------------------------------------------------------------------------------------
// Entry point, update a player panel on creation and register for callbacks when the player details
// are changed.
//--------------------------------------------------------------------------------------------------
(function()
{
    OnPlayerDetailsChanged();
    $.RegisterForUnhandledEvent( "DOTAGame_PlayerDetailsChanged", OnPlayerDetailsChanged );
    CustomNetTables.SubscribeNetTableListener("player_rating_data", OnPlayerDetailsChanged);
    GameEvents.Subscribe('player_rating_data_arrived', OnPlayerDetailsChanged);
    GameEvents.Subscribe('player_stastics_data_arrived', OnPlayerDetailsChanged);
})();

function ShowRatingTooltip()
{
    $.DispatchEvent("DOTAShowTextTooltip", "#rating_tooltip_" + rating);
}

function HideRatingTooltip()
{
    $.DispatchEvent("DOTAHideTextTooltip");
}