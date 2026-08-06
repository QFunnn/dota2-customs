--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


"use strict";


//--------------------------------------------------------------------------------------------------
// Handeler for when the unssigned players panel is clicked that causes the player to be reassigned
// to the unssigned players team
//--------------------------------------------------------------------------------------------------
function OnLeaveTeamPressed() {
	Game.PlayerJoinTeam(5); // 5 == unassigned ( DOTA_TEAM_NOTEAM )
}

var COLOR_STR = {
	"0": '#b0c3d9',//"gradient( linear, 0% 0%, 100% 0%, from( #b0c3d9 ), color-stop( 0.5, #eeeeee  ), to( #b0c3d9 ) )",
	"1": '#b0c3d9',//"gradient( linear, 0% 0%, 100% 0%, from( #4b69ff ), color-stop( 0.5, #5555ff  ), to( #4b69ff ) )",
	"2": '#5e98d9',//"gradient( linear, 0% 0%, 100% 0%, from( #5e98d9 ), color-stop( 0.5, #bbbbff  ), to( #5e98d9 ) )",
	"3": '#d32ce6',//"gradient( linear, 0% 0%, 100% 0%, from( #d32ce6 ), color-stop( 0.5, #ff22ff  ), to( #d32ce6 ) )",
	"4": '#e4ae39',//"gradient( linear, 0% 0%, 100% 0%, from( #e4ae39 ), color-stop( 0.5, #ff8800  ), to( #e4ae39 ) )",
}
//--------------------------------------------------------------------------------------------------
// Update the contents of the player panel when the player information has been modified.
//--------------------------------------------------------------------------------------------------
function OnPlayerDetailsChanged() {
	var playerId = $.GetContextPanel().GetAttributeInt("player_id", -1);
	var playerInfo = Game.GetPlayerInfo(playerId);
	if (!playerInfo)
		return;
	$("#PlayerName").text = playerInfo.player_name;
	$("#PlayerAvatar").steamid = playerInfo.player_steamid;

	// var chessboard = CustomNetTables.GetTableValue( "player_id_table", 'chessboard_'+playerId );
	// if (chessboard){
	// 	chessboard = chessboard.chessboard;
	// 	$( "#PlayerChessBoard" ).text = $.Localize('#'+chessboard);
	// 	$( "#PlayerChessBoard" ).style.color = COLOR_STR[chessboard.slice(1,2)];
	// }
	// else{
	// 	$( "#PlayerChessBoard" ).text = '';
	// }

	var mmr_level_info = CustomNetTables.GetTableValue("player_id_table", 'mmr_level_' + playerId);

	if (Game.GetMapInfo().map_display_name == 'candy_5_1x8' && mmr_level_info) {
		$('#ImageMMRLevel').style['background-image'] = "url('file://{images}/custom_game/candy.png')";
		$('#TextMMRLevel').text = ' × ' + mmr_level_info.candy;
		if (parseInt(mmr_level_info.candy) < 5) {
			$('#TextMMRLevel').style['color'] = '#ff4444';
		}
	}
	else if (mmr_level_info) {

		$('#ImageMMRLevel').style['background-image'] = "url('file://{images}/custom_game/level_" + mmr_level_info.mmr_level + ".png')";
		if (mmr_level_info.mmr_level >= 38 && mmr_level_info.queen_rank) {
			$('#TextMMRLevel').text = $.Localize('#' + 'text_player_level_' + mmr_level_info.mmr_level) + '#' + mmr_level_info.queen_rank;
		}
		else {
			$('#TextMMRLevel').text = $.Localize('#' + 'text_player_level_' + mmr_level_info.mmr_level);
		}

		if (mmr_level_info.mmr_level > 0) {
			$('#TextMMRLevel').style['color'] = '#fff';
		}
		else {
			$('#TextMMRLevel').style['color'] = '#888';
		}

		var min_level = GetCurrMapMinMMrlevelLimit() || 0;
		if (mmr_level_info.mmr_level < min_level) {
			$('#TextMMRLevel').style['color'] = '#ff4444';
		}
	}

	$.GetContextPanel().SetHasClass("player_is_local", playerInfo.player_is_local);
	$.GetContextPanel().SetHasClass("player_has_host_privileges", playerInfo.player_has_host_privileges);
}

function GetCurrMapMinMMrlevelLimit() {
	var map = Game.GetMapInfo().map_display_name;
	if (map == 'casual_1x8') {
		return 0;
	}
	if (map == 'casual_1x8_ob') {
		return 0;
	}
	if (map == 'ranked_1x8') {
		return 0;
	}
	if (map == 'ranked_1x8_bishop+') {
		return 19;
	}
	if (map == 'ranked_1x8_rook+') {
		return 28;
	}
	if (map == 'ranked_1x8_king+') {
		return 37;
	}
}


//--------------------------------------------------------------------------------------------------
// Entry point, update a player panel on creation and register for callbacks when the player details
// are changed.
//--------------------------------------------------------------------------------------------------
OnPlayerDetailsChanged();
$.RegisterForUnhandledEvent("DOTAGame_PlayerDetailsChanged", OnPlayerDetailsChanged);
