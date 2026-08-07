--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


"use strict";

// Global list of panels representing each of the teams
var g_TeamPanels = [];

// Global list of panels representing each of the players (1 per-player). These are reparented
// to the appropriate team panel to indicate which team the player is on.
var g_PlayerPanels = [];

var g_TEAM_SPECATOR = 1;

//--------------------------------------------------------------------------------------------------
// Handeler for when the unssigned players panel is clicked that causes the player to be reassigned
// to the unssigned players team
//--------------------------------------------------------------------------------------------------
function OnLeaveTeamPressed() {
	Game.PlayerJoinTeam(DOTATeam_t.DOTA_TEAM_NOTEAM);
}


//--------------------------------------------------------------------------------------------------
// Handler for when the Lock and Start button is pressed
//--------------------------------------------------------------------------------------------------
function OnLockAndStartPressed() {
	// Don't allow a forced start if there are unassigned players
	if (Game.GetUnassignedPlayerIDs().length > 0)
		return;

	// Lock the team selection so that no more team changes can be made
	Game.SetTeamSelectionLocked(true);

	// Disable the auto start count down
	Game.SetAutoLaunchEnabled(false);

	// Set the remaining time before the game starts
	Game.SetRemainingSetupTime(4);
}


//--------------------------------------------------------------------------------------------------
// Handler for when the Cancel and Unlock button is pressed
//--------------------------------------------------------------------------------------------------
function OnCancelAndUnlockPressed() {
	// Unlock the team selection, allowing the players to change teams again
	Game.SetTeamSelectionLocked(false);

	// Stop the countdown timer
	Game.SetRemainingSetupTime(-1);
}


//--------------------------------------------------------------------------------------------------
// Handler for the auto assign button being pressed
//--------------------------------------------------------------------------------------------------
function OnAutoAssignPressed() {
	// Assign all of the currently unassigned players to a team, trying
	// to keep any players that are in a party on the same team.
	Game.AutoAssignPlayersToTeams();
}


//--------------------------------------------------------------------------------------------------
// Handler for the shuffle player teams button being pressed
//--------------------------------------------------------------------------------------------------
function OnShufflePlayersPressed() {
	// Shuffle the team assignments of any players which are assigned to a team, 
	// this will not assign any players to a team which are currently unassigned. 
	// This will also not attempt to keep players in a party on the same team.
	Game.ShufflePlayerTeamAssignments();
}


//--------------------------------------------------------------------------------------------------
// Find the player panel for the specified player in the global list or create the panel if there 
// is not already one in the global list. Make the new or existing panel a child panel of the 
// specified parent panel
//--------------------------------------------------------------------------------------------------
function FindOrCreatePanelForPlayer(playerId, parent) {
	// Search the list of player player panels for one witht the specified player id
	for (var i = 0; i < g_PlayerPanels.length; ++i) {
		var playerPanel = g_PlayerPanels[i];

		if (playerPanel.GetAttributeInt("player_id", -1) == playerId) {
			playerPanel.SetParent(parent);
			return playerPanel;
		}
	}

	// Create a new player panel for the specified player id if an existing one was not found
	var newPlayerPanel = $.CreatePanel("Panel", parent, "player_root");
	newPlayerPanel.SetAttributeInt("player_id", playerId);
	newPlayerPanel.BLoadLayout("file://{resources}/layout/custom_game/team_select_player.xml", false, false);

	// Add the panel to the global list of player planels so that we will find it next time
	g_PlayerPanels.push(newPlayerPanel);

	return newPlayerPanel;
}


//--------------------------------------------------------------------------------------------------
// Find player slot n in the specified team panel
//--------------------------------------------------------------------------------------------------
function FindPlayerSlotInTeamPanel(teamPanel, playerSlot) {
	var playerListNode = teamPanel.FindChildInLayoutFile("PlayerList");
	if (playerListNode == null)
		return null;

	var nNumChildren = playerListNode.GetChildCount();
	for (var i = 0; i < nNumChildren; ++i) {
		var panel = playerListNode.GetChild(i);
		if (panel.GetAttributeInt("player_slot", -1) == playerSlot) {
			return panel;
		}
	}

	return null;
}


//--------------------------------------------------------------------------------------------------
// Update the specified team panel ensuring that it has all of the players currently assigned to its
// team and the the remaining slots are marked as empty
//--------------------------------------------------------------------------------------------------
function UpdateTeamPanel(teamPanel) {
	// Get the id of team this panel is displaying
	var teamId = teamPanel.GetAttributeInt("team_id", -1);
	if (teamId <= 0)
		return;

	// Add all of the players currently assigned to the team 
	var teamPlayers = Game.GetPlayerIDsOnTeam(teamId);
	for (var i = 0; i < teamPlayers.length; ++i) {
		var playerSlot = FindPlayerSlotInTeamPanel(teamPanel, i);
		playerSlot.RemoveAndDeleteChildren();
		FindOrCreatePanelForPlayer(teamPlayers[i], playerSlot);
	}

	// Fill in the remaining player slots with the empty slot indicator
	var teamDetails = Game.GetTeamDetails(teamId);
	var nNumPlayerSlots = teamDetails.team_max_players;
	for (var i = teamPlayers.length; i < nNumPlayerSlots; ++i) {
		var playerSlot = FindPlayerSlotInTeamPanel(teamPanel, i);
		if (playerSlot.GetChildCount() == 0) {
			var empty_slot = $.CreatePanel("Panel", playerSlot, "player_root");
			empty_slot.BLoadLayout("file://{resources}/layout/custom_game/team_select_empty_slot.xml", false, false);
		}
	}

	// Change the display state of the panel to indicate the team is full
	teamPanel.SetHasClass("team_is_full", (teamPlayers.length === teamDetails.team_max_players));

	// If the local player is on this team change team panel to indicate this
	var localPlayerInfo = Game.GetLocalPlayerInfo()
	if (localPlayerInfo) {
		var localPlayerIsOnTeam = (localPlayerInfo.player_team_id === teamId);
		teamPanel.SetHasClass("local_player_on_this_team", localPlayerIsOnTeam);
	}
}


//--------------------------------------------------------------------------------------------------
// Update the unassigned players list and all of the team panels whenever a change is made to the
// player team assignments
//--------------------------------------------------------------------------------------------------
function OnTeamPlayerListChanged() {
	var unassignedPlayersContainerNode = $("#UnassignedPlayersContainer");
	if (unassignedPlayersContainerNode === null)
		return;

	// Move all existing player panels back to the unassigned player list
	for (var i = 0; i < g_PlayerPanels.length; ++i) {
		var playerPanel = g_PlayerPanels[i];
		playerPanel.SetParent(unassignedPlayersContainerNode);
	}

	// Make sure all of the unassigned player have a player panel 
	// and that panel is a child of the unassigned player panel.
	var unassignedPlayers = Game.GetUnassignedPlayerIDs();
	for (var i = 0; i < unassignedPlayers.length; ++i) {
		var playerId = unassignedPlayers[i];
		FindOrCreatePanelForPlayer(playerId, unassignedPlayersContainerNode);
	}

	// Update all of the team panels moving the player panels for the
	// players assigned to each team to the corresponding team panel.
	for (var i = 0; i < g_TeamPanels.length; ++i) {
		UpdateTeamPanel(g_TeamPanels[i]);
	}

	// Set the class on the panel to indicate if there are any unassigned players
	$("#GameAndPlayersRoot").SetHasClass("unassigned_players", unassignedPlayers.length != 0);
	$("#GameAndPlayersRoot").SetHasClass("no_unassigned_players", unassignedPlayers.length == 0);
}


//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
function OnPlayerSelectedTeam(nPlayerId, nTeamId, bSuccess) {
	var playerInfo = Game.GetLocalPlayerInfo();
	if (!playerInfo)
		return;

	// Check to see if the event is for the local player
	if (playerInfo.player_id === nPlayerId) {
		// Play a sound to indicate success or failure
		if (bSuccess) {
			Game.EmitSound("ui_team_select_pick_team");
		}
		else {
			Game.EmitSound("ui_team_select_pick_team_failed");
		}
	}
}


//--------------------------------------------------------------------------------------------------
// Check to see if the local player has host privileges and set the 'player_has_host_privileges' on
// the root panel if so, this allows buttons to only be displayed for the host.
//--------------------------------------------------------------------------------------------------
function CheckForHostPrivileges() {
	var playerInfo = Game.GetLocalPlayerInfo();
	if (!playerInfo)
		return;

	// Set the "player_has_host_privileges" class on the panel, this can be used 
	// to have some sub-panels on display or be enabled for the host player.
	$.GetContextPanel().SetHasClass("player_has_host_privileges", playerInfo.player_has_host_privileges);
}


//--------------------------------------------------------------------------------------------------
// Update the state for the transition timer periodically
//--------------------------------------------------------------------------------------------------
function UpdateTimer() {
	var gameTime = Game.GetGameTime();
	var transitionTime = Game.GetStateTransitionTime();

	CheckForHostPrivileges();

	var mapInfo = Game.GetMapInfo();
	$("#MapInfo").SetDialogVariable("map_name", mapInfo.map_display_name);

	if (transitionTime >= 0) {
		$("#StartGameCountdownTimer").SetDialogVariableInt("countdown_timer_seconds", Math.max(0, Math.floor(transitionTime - gameTime)));
		$("#StartGameCountdownTimer").SetHasClass("countdown_active", true);
		$("#StartGameCountdownTimer").SetHasClass("countdown_inactive", false);
	}
	else {
		$("#StartGameCountdownTimer").SetHasClass("countdown_active", false);
		$("#StartGameCountdownTimer").SetHasClass("countdown_inactive", true);
	}

	var autoLaunch = Game.GetAutoLaunchEnabled();
	$("#StartGameCountdownTimer").SetHasClass("auto_start", autoLaunch);
	$("#StartGameCountdownTimer").SetHasClass("forced_start", (autoLaunch == false));

	// Allow the ui to update its state based on team selection being locked or unlocked
	$.GetContextPanel().SetHasClass("teams_locked", Game.GetTeamSelectionLocked());
	$.GetContextPanel().SetHasClass("teams_unlocked", Game.GetTeamSelectionLocked() == false);

	$.Schedule(0.1, UpdateTimer);
}


//--------------------------------------------------------------------------------------------------
// Entry point called when the team select panel is created
//--------------------------------------------------------------------------------------------------

if (Game.GetMapInfo().map_display_name == 'casual_2x4_ob' || Game.GetMapInfo().map_display_name == 'casual_2x4' || Game.GetMapInfo().map_display_name == 'ranked_2x4') {
	// 双人模式，禁止洗牌
	$('#ShuffleTeamAssignmentButton').style.visibility = 'collapse';
}

if (GetPlayerCount() == 1 && Game.GetMapInfo().map_display_name != 'casual_1x8_ob') {
	$('#select-block-difficulty').SetHasClass('invisible', false);
	// 单人模式
	// $('#GameModeNameLabel').text = $.Localize('#'+'dac_1p');
	// $('#MapInfoLabel').text = $.Localize('#'+'dac_1p_desc');
	$("#GameModeNameLabel").text = $.Localize('#'+'dac_' + Game.GetMapInfo().map_display_name);
	$("#MapInfoLabel").text = $.Localize('#'+'dac_' + Game.GetMapInfo().map_display_name + '_desc').replaceAll('<br>','\n');
}
else {
	$('#select-block-difficulty').SetHasClass('invisible', true);
	$("#GameModeNameLabel").text = $.Localize('#'+'dac_' + Game.GetMapInfo().map_display_name);
	$("#MapInfoLabel").text = $.Localize('#'+'dac_' + Game.GetMapInfo().map_display_name + '_desc').replaceAll('<br>','\n');
}


var bShowSpectatorTeam = false;
var bAutoAssignTeams = true;

// get any custom config
if (GameUI.CustomUIConfig().team_select) {
	var cfg = GameUI.CustomUIConfig().team_select;
	if (cfg.bShowSpectatorTeam !== undefined) {
		bShowSpectatorTeam = cfg.bShowSpectatorTeam;
	}
	if (cfg.bAutoAssignTeams !== undefined) {
		bAutoAssignTeams = cfg.bAutoAssignTeams;
	}
}

$("#TeamSelectContainer").SetAcceptsFocus(true); // Prevents the chat window from taking focus by default
var teamsListRootNode = $("#TeamsListRoot");

// Construct the panels for each team
var allTeamIDs = Game.GetAllTeamIDs();

if (bShowSpectatorTeam) {
	allTeamIDs.unshift(g_TEAM_SPECATOR);
}

for (var teamId of allTeamIDs) {
	var teamNode = $.CreatePanel("Panel", teamsListRootNode, "");
	teamNode.AddClass("team_" + teamId); // team_1, etc.
	teamNode.SetAttributeInt("team_id", teamId);
	teamNode.BLoadLayout("file://{resources}/layout/custom_game/team_select_team.xml", false, false);

	// Add the team panel to the global list so we can get to it easily later to update it
	g_TeamPanels.push(teamNode);
}

// Automatically assign players to teams.
if (bAutoAssignTeams) {
	Game.AutoAssignPlayersToTeams();
}

// Do an initial update of the player team assignment
OnTeamPlayerListChanged();

// Start updating the timer, this function will schedule itself to be called periodically
UpdateTimer();

// Register a listener for the event which is brodcast when the team assignment of a player is actually assigned
$.RegisterForUnhandledEvent("DOTAGame_TeamPlayerListChanged", OnTeamPlayerListChanged);

// Register a listener for the event which is broadcast whenever a player attempts to pick a team
$.RegisterForUnhandledEvent("DOTAGame_PlayerSelectedCustomTeam", OnPlayerSelectedTeam);

var local_id;


$.Schedule(1, function () {
	get_local_id();
})
function get_local_id() {
	if (Game.GetPlayerInfo(Players.GetLocalPlayer())) {
		local_id = Game.GetPlayerInfo(Players.GetLocalPlayer()).player_steamid;
		RequestUpdateUserInfo();
		// RefreshHeroInfo();
	}
	else {
		$.Schedule(1, function () {
			get_local_id();
		})
	}
}
function GetPlayerCount() {
	var count = 0;
	for (var i = 0; i <= 7; i++) {
		var playerdata = Game.GetPlayerInfo(i);
		if (playerdata) {
			count++;
		}
	}
	return count;
}



// 请求服务器
function RequestUpdateUserInfo() {
	GameEvents.SendCustomGameEventToServer("request_update_user_info", {
		"hehe": Date.now(),
	});
}
GameEvents.Subscribe("update_user_info", UpdateUserInfo);
function UpdateUserInfo(keys) {
	var all_user_info = keys.user_info;
	var qq_list = keys.qq_list;
	for (var i in all_user_info) {
		var curr_player_id = parseInt(i);
		if (curr_player_id == Players.GetLocalPlayer()) {
			// 是当前玩家
			var my_user_info = all_user_info[i];

			var map_name = Game.GetMapInfo().map_display_name;

			// 判断是不是不符合房间段位要求
			var my_mmr_level = my_user_info.mmr_level || 0;
			var map_2_level = {
				'ranked_1x8_bishop+': 19,
				'ranked_1x8_rook+': 28,
				'ranked_1x8_king+': 37,
			};
			var required_level = map_2_level[map_name]||0;
			if (my_mmr_level < required_level){
				if ($('#LowPlayerNoticeContainer')){
					// $('#LowPlayerNoticeContainer').style['position'] = '0px 0px 0px';
					if ($.Language()=='schinese' || $.Language()=='tchinese'){
						$('#img_low_player').SetImage('file://{images}/custom_game/ui/warning_low_schinese.png');
						$('#img_low_player2').SetImage('file://{images}/custom_game/ui/a_game_list_schinese.png');
					}
					else{
						$('#img_low_player').SetImage('file://{images}/custom_game/ui/warning_low_english.png');
						$('#img_low_player2').SetImage('file://{images}/custom_game/ui/a_game_list_english.png');
					}
					$('#LowPlayerNoticeContainer').SetHasClass('show',true);

					if (required_level == 19){
						$('#require_rank_low_2').SetHasClass('invisible',false);
					}
					else if (required_level == 28){
						$('#require_rank_low_3').SetHasClass('invisible',false);
					}
					else if (required_level == 37){
						$('#require_rank_low_4').SetHasClass('invisible',false);
					}

					if (my_mmr_level <= 18){
						$('#your_rank_low_1').SetHasClass('invisible',false);
					}
					else if (my_mmr_level <= 27){
						$('#your_rank_low_2').SetHasClass('invisible',false);
					}
					else if (my_mmr_level <= 36){
						$('#your_rank_low_3').SetHasClass('invisible',false);
					}
				}
			}

			// 信使选择
			var text = '';		
			var hero_count = 0;
			var zhugong_list = (my_user_info['zhugong'] || '').split(',');

			// 排序信使！
			zhugong_list = sort_courier_list(zhugong_list);
			var onduty_zhugong = my_user_info['onduty_hero'];
			var onduty_hero = onduty_zhugong.split('_')[0];
			var onduty_effect = onduty_zhugong.split('_')[1];

			var onduty_index = zhugong_list.indexOf(onduty_zhugong);

			MY_COURIER_LIST = zhugong_list;
			MY_CURR_COURIER = onduty_zhugong;

			fill_my_courier_list();

			$('#select-board').style['position'] = '0px 0px 0px';

			// 徽章选择
			var badge_count = 0;
			var badge_list = (my_user_info['badgeall'] || '').split(',');
			if (my_user_info['bet_info']) {
				badge_list.push('bet_' + my_user_info['bet_info']);
			}
			MY_BADGE_LIST = ['donnot_show_badge'];
			for (var i = 0; i < badge_list.length; i++) {
				if (badge_list[i]) {
					MY_BADGE_LIST.push(badge_list[i]);
				}
			}

			fill_my_badge_list();
			if (my_user_info['chessboard_list']) {
				// 棋盘选择
				var chessboard_count = 0;
				var chessboard_list_string = JSON.parse(my_user_info['chessboard_list']);
				MY_CHESSBOARD_LIST = sort_chessboard_list(chessboard_list_string);
				MY_CURR_CHESSBOARD = my_user_info['onduty_chessboard'] || 'b101';
				// 判断MY_CHESSBOARD_LIST里有没有MY_CURR_CHESSBOARD
				var is_onduty_chessboard_ok = false;
				for (var i = 0; i < MY_CHESSBOARD_LIST.length; i++) {
					var c = MY_CHESSBOARD_LIST[i];
					if (c && c.id && c.id == MY_CURR_CHESSBOARD) {
						is_onduty_chessboard_ok = true;
					}
				}
				if (!is_onduty_chessboard_ok) {
					MY_CURR_CHESSBOARD = MY_CHESSBOARD_LIST[0].id || 'b101';
				}

				// GameEvents.SendCustomGameEventToServer("choose_chessboard", {
				// 	"chessboard": MY_CURR_CHESSBOARD,
				// });

				// fill_my_chessboard_list();
				if (MY_CURR_CHESSBOARD) {
					choose_chessboard(MY_CURR_CHESSBOARD);
				}
			}
			else {
				$('#select-block-chessboard').SetHasClass('invisible', true);
			}

			// //根据段位显示推荐的qq群列表
			// var language = $.Language();
			// if (language!='schinese'){
			// 	language = 'other';
			// }
			// // my_mmr_level = 31;
			// var my_group_list = [];
			// if (qq_list){
			// 	for (var j in qq_list){
			// 		//my_mmr_level
			// 		var q = qq_list[j];
			// 		if (q.language && q.language == language){
			// 			if ((q.min_level||q.min_level == 0) && q.min_level<=my_mmr_level){
			// 				if (q.max_level && q.max_level>=my_mmr_level){
			// 					my_group_list.push(q);
			// 				}
			// 			}
			// 		}
			// 	}
			// }
			// if (my_group_list && my_group_list.length>0){
			// 	$('#select-block-group').SetHasClass('invisible',false);
			// 	for (var ii = 0;ii<my_group_list.length;ii++){
			// 		var g = my_group_list[ii];
			// 		var one_group = CreateUIElement($('#select-block-group-inner'), "Panel", "", {
			// 			'class': 'hero_sea_top_panel_summary',
			// 			onactivate: 'go_browser_url("'+g.link+'")',
			// 		});
			// 		CreateUIElement(one_group, "Image", "", {
			// 			'class': 'img_loading_select_chesser',
			// 			'src': 'file://{images}/custom_game/'+(g.type||'qq')+'.png',
			// 			style: 'width:25px;height:25px;margin:5px;',
			// 		});
			// 		CreateUIElement(one_group, "Label", "", {
			// 			'class': "text_20",
			// 			'style': 'color:#bbb;',
			// 			'text': g.name+" "+g.qq,
			// 		});
			// 	}
			// 	var desc = $.Localize('#group_desc1');
			// 	if (g.default_password){
			// 		desc += ' '+ $.Localize('#group_desc2') +' '+ ('<font color="#fff" size="24px">'+g.default_password+'</font>');
			// 	}
			// 	CreateUIElement($('#select-block-group'), "Label", "", {
			// 		class: 'MapInfoLabel',
			// 		html: 'true',
			// 		text: desc,
			// 		style: 'margin-bottom:0px;',
			// 	});
			// }
			
		}
	}

	var notice = keys.notice[$.Language()] || keys.notice['default'];
	if (notice){
		// 显示通知与广告
		if ($('#AdNoticeContainer')){
			$('#AdNoticeContainer').style['position'] = '0px 0px 0px';
		}
		if ($('#logo')){
			$('#logo').style['position'] = '0px 0px 0px';
		}
		
		// 显示TIPS
		if (notice.notice){
			$('#gametips').text = $.Localize('#'+notice.notice);
		}
		else{
			$('#gametips').text = $.Localize('#'+'gametip'+Math.ceil(Math.random()*18));
		}

		if (notice.pic){
			// 显示广告图
			SetLoadingAD(
				notice.pic,
				notice.text,
				notice.text_color||'#fff',
			);
		}
	}
}
function SetLoadingAD(pic,text,text_color){
    if (pic){
        $('#image_loading_ad').SetImage(pic);
    }
    if (text){
        $('#text_loading_ad').text = $.Localize('#'+text);
        $('#text_loading_ad').style.color = text_color || '#bbb';
        $('#panel_loading_ad_text_brush').style['background-color'] = text_color || '#bbb';
        $('#panel_loading_ad_text_outer').SetHasClass('invisible',false);
    }
    else{
        $('#text_loading_ad').text = '';
        $('#panel_loading_ad_text_outer').SetHasClass('invisible',true);
    }
}

var DIFFICULTY;
function select_difficulty(lv) {
	DIFFICULTY = lv;
	$('#text_difficulty_1').text = $.Localize('#'+'text_difficulty_1');
	$('#text_difficulty_2').text = $.Localize('#'+'text_difficulty_2');
	$('#text_difficulty_3').text = $.Localize('#'+'text_difficulty_3');
	$('#text_difficulty_1').SetHasClass('text_20', true);
	$('#text_difficulty_2').SetHasClass('text_20', true);
	$('#text_difficulty_3').SetHasClass('text_20', true);
	$('#text_difficulty_1').SetHasClass('text_20_highlight', false);
	$('#text_difficulty_2').SetHasClass('text_20_highlight', false);
	$('#text_difficulty_3').SetHasClass('text_20_highlight', false);
	$('#panel_difficulty_1').SetHasClass('selected', false);
	$('#panel_difficulty_2').SetHasClass('selected', false);
	$('#panel_difficulty_3').SetHasClass('selected', false);


	$('#text_difficulty_' + lv).text = $.Localize('#'+'text_difficulty_' + lv);
	$('#text_difficulty_' + lv).SetHasClass('text_20', false);
	$('#text_difficulty_' + lv).SetHasClass('text_20_highlight', true);
	$('#panel_difficulty_' + lv).SetHasClass('selected', true);

	GameEvents.SendCustomGameEventToServer("select_difficulty",
		{
			player_id: Players.GetLocalPlayer(),
			difficulty: lv,
		}
	);
}


var TI9_TEAM_LIST = {
	1: {
		name: 'Team Secret',
		pic: 'file://{images}/teams/1838315.png',
		bet_rate: 3.75,
	},
	2: {
		name: 'ViCi Gaming',
		pic: 'file://{images}/teams/726228.png',
		bet_rate: 4.2,
	},
	3: {
		name: 'Team Liquid',
		pic: 'file://{images}/teams/2163.png',
		bet_rate: 5.5,
	},
	4: {
		name: 'Virtus Pro',
		pic: 'file://{images}/teams/1883502.png',
		bet_rate: 7.5,
	},
	5: {
		name: 'PSG LGD',
		pic: 'file://{images}/teams/15.png',
		bet_rate: 8,
	},
	6: {
		name: 'Evil Geniuses',
		pic: 'file://{images}/teams/39.png',
		bet_rate: 13,
	},
	7: {
		name: 'Team OG',
		pic: 'file://{images}/teams/2586976.png',
		bet_rate: 21,
	},
	8: {
		name: 'TNC Predator',
		pic: 'file://{images}/teams/2108395.png',
		bet_rate: 26,
	},
	9: {
		name: 'Fnatic',
		pic: 'file://{images}/teams/350190.png',
		bet_rate: 51,
	},
	10: {
		name: 'Team NIP',
		pic: 'file://{images}/teams/6214973.png',
		bet_rate: 51,
	},
	11: {
		name: 'Keen Gaming',
		pic: 'file://{images}/teams/2626685.png',
		bet_rate: 67,
	},
	12: {
		name: 'Team RNG',
		pic: 'file://{images}/teams/6209804.png',
		bet_rate: 81,
	},
	13: {
		name: 'Alliance',
		pic: 'file://{images}/teams/111474.png',
		bet_rate: 151,
	},
	14: {
		name: 'Chaos Esports',
		pic: 'file://{images}/teams/7203342.png',
		bet_rate: 151,
	},
	15: {
		name: 'Newbee',
		pic: 'file://{images}/teams/6214538.png',
		bet_rate: 151,
	},
	16: {
		name: 'Natus Vincere',
		pic: 'file://{images}/teams/36.png',
		bet_rate: 201,
	},
	17: {
		name: 'Mineski',
		pic: 'file://{images}/teams/543897.png',
		bet_rate: 251,
	},
	18: {
		name: 'Infamous',
		pic: 'file://{images}/teams/2672298.png',
		bet_rate: 1001,
	},
}

var COLOR = {
	"0": "rgba(128,128,128,0.8)",
	"1": "rgba(128,128,128,0.8)",
	"2": "rgba(96,96,255,0.8)",
	"3": "rgba(255,64,192,0.8)",
	"4": "rgba(255,128,0,0.8)",
};
var COLOR_STR = {
	"0": '#b0c3d9',//"gradient( linear, 0% 0%, 100% 0%, from( #b0c3d9 ), color-stop( 0.5, #eeeeee  ), to( #b0c3d9 ) )",
	"1": '#b0c3d9',//"gradient( linear, 0% 0%, 100% 0%, from( #4b69ff ), color-stop( 0.5, #5555ff  ), to( #4b69ff ) )",
	"2": '#5e98d9',//"gradient( linear, 0% 0%, 100% 0%, from( #5e98d9 ), color-stop( 0.5, #bbbbff  ), to( #5e98d9 ) )",
	"3": '#d32ce6',//"gradient( linear, 0% 0%, 100% 0%, from( #d32ce6 ), color-stop( 0.5, #ff22ff  ), to( #d32ce6 ) )",
	"4": '#e4ae39',//"gradient( linear, 0% 0%, 100% 0%, from( #e4ae39 ), color-stop( 0.5, #ff8800  ), to( #e4ae39 ) )",
}


function get_courier_info(courier_str) {
	if (!courier_str) {
		return null;
	}
	if (courier_str.slice(0, 1) != 'h') {
		return null;
	}
	var courier = courier_str.split('_')[0];
	var effect = courier_str.split('_')[1];
	if (effect == 'e000') {
		effect = null;
	}

	var level_exp = parseFloat(courier_str.split('_')[2]) || 1;
	var level = Math.floor(level_exp);
	var exp = level_exp - level;

	var projectile = courier_str.split('_')[3];
	if (projectile == 'p000') {
		projectile = null;
	}
	var pet = courier_str.split('_')[4];
	if (pet == 't000') {
		pet = null;
	}
	var animation = courier_str.split('_')[5];
	if (animation == 'n000') {
		animation = null;
	}

	var courier_info = {
		courier: courier,
		effect: effect,
		exp: exp,
		projectile: projectile,
		pet: pet,
		animation: animation,
		level_exp: level_exp,
		level: level,
		exp: exp,
		rarity: parseInt(courier.slice(1, 2)),
	};

	return courier_info;
}

function sort_courier_list(zhugong_list) {
	zhugong_list.sort(function (a, b) {
		var score_b = 0;
		var score_a = 0;

		var info_b = get_courier_info(b);
		var info_a = get_courier_info(a);

		if (info_a && info_a.level) {
			score_a += info_a.level * 1000000;
		}
		if (info_b && info_b.level) {
			score_b += info_b.level * 1000000;
		}

		if (info_a && info_a.courier) {
			score_a += parseInt(info_a.courier.slice(1, 4)) * 1000;
		}
		if (info_b && info_b.courier) {
			score_b += parseInt(info_b.courier.slice(1, 4)) * 1000;
		}

		if (info_a && info_a.effect) {
			score_a += parseInt(info_a.effect.slice(1, 4)) * 1;
		}
		if (info_b && info_b.effect) {
			score_b += parseInt(info_b.effect.slice(1, 4)) * 1;
		}

		if (info_a && info_a.projectile) {
			score_a += parseInt(info_a.projectile.slice(1, 4)) * 1;
		}
		if (info_b && info_b.projectile) {
			score_b += parseInt(info_b.projectile.slice(1, 4)) * 1;
		}

		if (info_a && info_a.animation) {
			score_a += parseInt(info_a.animation.slice(1, 4)) * 1;
		}
		if (info_b && info_b.animation) {
			score_b += parseInt(info_b.animation.slice(1, 4)) * 1;
		}

		if (info_a && info_a.pet) {
			score_a += parseInt(info_a.pet.slice(1, 4)) * 1;
		}
		if (info_b && info_b.pet) {
			score_b += parseInt(info_b.pet.slice(1, 4)) * 1;
		}
		return score_b - score_a;
	});

	return zhugong_list;
}
function sort_chessboard_list(chessboard_list) {
	chessboard_list.sort(function (a, b) {
		var score_b = 0;
		var score_a = 0;

		if (a && a.id) {
			score_a += parseInt(a.id.slice(1, 4)) * 1000;
		}
		if (b && b.id) {
			score_b += parseInt(b.id.slice(1, 4)) * 1000;
		}

		if (a && a.tag) {
			score_a += parseInt(a.tag.length || 1);
		}
		if (b && b.tag) {
			score_b += parseInt(b.tag.length || 1);
		}
		return score_b - score_a;
	});

	return chessboard_list;
}

function fill_my_chessboard_list() {
	if (MY_CHESSBOARD_LIST && MY_CHESSBOARD_LIST.length > 0) {

		ClearUIElement($('#select-block-chessboard-inner'));

		for (var i = 0; i < MY_CHESSBOARD_LIST.length; i++) {
			var chessboard = MY_CHESSBOARD_LIST[i];
			if (chessboard && chessboard.id) {
				var tip_title = $.Localize('#'+chessboard.id);

				tip_title += ' (' + $.Localize('#'+'rarity_' + chessboard.id.slice(1, 2));

				if (chessboard.tag) {
					tip_title += '/' + $.Localize('#'+'chessboard_tag_' + chessboard.tag);
				}

				tip_title += ')';

				var tip_text = '';
				if (chessboard.tag) {
					tip_text += $.Localize('#'+'chessboard_tag_' + chessboard.tag + '_desc');
				}
				else{
					tip_text += $.Localize('#owned_chessboard');
				}

				var one_chessboard = CreateUIElement($('#select-block-chessboard-inner'), "Panel", "", {
					'class': 'goods_list_one_outer_chessboard' + ((chessboard.id == MY_CURR_CHESSBOARD) ? ' selected' : ''),
					'onactivate': 'choose_chessboard(\'' + chessboard.id + '\')',
					'onmouseover': 'DOTAShowTitleTextTooltip(\'' + tip_title + '\',\'' + tip_text + '\')',
					'onmouseout': 'DOTAHideTitleTextTooltip()',
				});

				CreateUIElement(one_chessboard, "Panel", "", {
					'class': 'goods_list_one',
					'style': 'background-image:url(\'file://{images}/custom_game/chessboard/' + chessboard.id + '.png\');',
				});

				if (chessboard.id == MY_CURR_CHESSBOARD) {
					// 当前棋盘
					CreateUIElement(one_chessboard, "Panel", "", {
						'class': 'icon_equiped icon_one_equiped',
					});
				}

				// 棋盘名字条
				var one_chessboard_name_bar = CreateUIElement(one_chessboard, "Panel", "", {
					'class': 'goods_list_one_chessboard_name_bar',
				});

				CreateUIElement(one_chessboard_name_bar, "Label", "", {
					'text': $.Localize('#'+chessboard.id),
					'style': 'color:' + COLOR_STR[chessboard.id.slice(1, 2)] + ';',
				});
			}
		}
		$('#select-block-chessboard').SetHasClass('invisible', false);
	}
	else {
		// 木有棋盘
		$('#select-block-chessboard').SetHasClass('invisible', true);
	}
}
function fill_my_courier_list() {
	if (MY_COURIER_LIST && MY_COURIER_LIST.length > 0) {

		ClearUIElement($('#select-block-inner'));

		var my_courier_list_line = CreateUIElement($('#select-block-inner'), "Panel", "", {
			'class': 'my_courier_list_line',
		});

		for (var i = 0; i < MY_COURIER_LIST.length; i++) {
			var zhugong = MY_COURIER_LIST[i];
			var zhugong_info = get_courier_info(zhugong);

			var hero = zhugong.split('_')[0];
			var effect = zhugong.split('_')[1];
			var level_exp = parseFloat(zhugong.split('_')[2]) || 1.0;
			var level = Math.floor(level_exp);

			var tip_title = $.Localize('#'+hero);
			tip_title += ' (' + $.Localize('#'+'rarity_' + hero.slice(1, 2));
			tip_title += ')';
			var tip_text = '';
			tip_text += 'Lv.'+level;
			if (zhugong_info && zhugong_info.effect){
				tip_text += '<br>'+$.Localize('#type_e')+': '+$.Localize('#'+zhugong_info.effect);
			}
			if (zhugong_info && zhugong_info.projectile){
				tip_text += '<br>'+$.Localize('#type_p')+': '+$.Localize('#'+zhugong_info.projectile);
			}
			if (zhugong_info && zhugong_info.animation){
				tip_text += '<br>'+$.Localize('#type_n')+': '+$.Localize('#'+zhugong_info.animation);
			}
			if (zhugong_info && zhugong_info.pet){
				tip_text += '<br>'+$.Localize('#type_t')+': '+$.Localize('#'+zhugong_info.pet);
			}

			var my_courier_list_one = CreateUIElement(my_courier_list_line, "Panel", "my_courier_list_" + i, {
				"class": "my_courier_list_one" + ((zhugong == MY_CURR_COURIER) ? " selected" : ""),
				"onactivate": "choose_courier(\'" + zhugong + "\'," + i + ")",
			});
			SetMouseTips(my_courier_list_one,tip_title,tip_text);

			var my_courier_list_one_left = CreateUIElement(my_courier_list_one, "Panel", "", {
				"class": "my_courier_list_one_left",
				"style": "background-image:url(\'file://{images}/custom_game/skaters/" + hero + ".png\');"
			});

			var my_courier_list_one_right = CreateUIElement(my_courier_list_one, "Panel", "", {
				"class": "my_courier_list_one_right",
			});
			var my_courier_list_one_right_line1 = CreateUIElement(my_courier_list_one_right, "Panel", "", {
				"class": "my_courier_list_one_right_line1",
			});
			CreateUIElement(my_courier_list_one_right_line1, "Label", "", {
				"text": $.Localize('#'+hero),
				"style": "color:" + COLOR_STR[hero.slice(1, 2)] + ";",
			});

			var my_courier_list_one_right_line2 = CreateUIElement(my_courier_list_one_right, "Panel", "", {
				"class": "my_courier_list_one_right_line2",
			});
			CreateUIElement(my_courier_list_one_right_line2, "Label", "", {
				"text": "Lv." + level,
			});

			if (zhugong_info && zhugong_info.effect) {
				CreateUIElement(my_courier_list_one_right_line2, "Panel", "", {
					"class": "icon_effect",
					"style": "background-color:" + COLOR[zhugong_info.effect.slice(1, 2)] + ";",
				});
			}
			if (zhugong_info && zhugong_info.projectile) {
				CreateUIElement(my_courier_list_one_right_line2, "Panel", "", {
					"class": "icon_projectile",
					"style": "background-color:" + COLOR[zhugong_info.projectile.slice(1, 2)] + ";",
				});
			}
			if (zhugong_info && zhugong_info.animation) {
				CreateUIElement(my_courier_list_one_right_line2, "Panel", "", {
					"class": "icon_animation",
					"style": "background-color:" + COLOR[zhugong_info.animation.slice(1, 2)] + ";",
				});
			}
			if (zhugong_info && zhugong_info.pet) {
				CreateUIElement(my_courier_list_one_right_line2, "Panel", "", {
					"class": "icon_pet",
					"style": "background-color:" + COLOR[zhugong_info.pet.slice(1, 2)] + ";",
				});
			}

			if (zhugong == MY_CURR_COURIER) {
				// 当前信使标志
				CreateUIElement(my_courier_list_one_left, "Panel", "", {
					"class": "icon_equiped icon_one_equiped",
				});
			}

			if (i >= 99) {
				break;
			}
		}
	}
}

function fill_my_badge_list() {
	if (MY_BADGE_LIST.length > 1) {
		ClearUIElement($('#select-block-badge-inner'));

		// 有徽章
		var text = '';
		for (var i = 0; i < MY_BADGE_LIST.length; i++) {
			var badge = MY_BADGE_LIST[i];
			if (badge) {
				if (badge == 'donnot_show_badge') {
					// 不显示徽章
					var title = $.Localize('#'+'donnot_show_badge');
					var text = $.Localize('#donnot_show_badge_text');
					var one_badge = CreateUIElement($('#select-block-badge-inner'), "Panel", "", {
						'class': 'goods_list_one_outer_badge' + ((badge == MY_CURR_BADGE) ? " selected" : ""),
						'onactivate': 'choose_badge(\'donnot_show_badge\')',
						'onmouseover': 'DOTAShowTitleTextTooltip(\'' + title + '\',\'' + text + '\')',
						'onmouseout': 'DOTAHideTitleTextTooltip()',
					});
					CreateUIElement(one_badge, "Image", "", {
						'class': 'img_loading_select_badge',
						'src': 'file://{images}/custom_game/disable2.png',
					});
					// CreateUIElement(one_badge, "Label", "", {
					// 	'class': ((badge == MY_CURR_BADGE) ? "text_20_highlight" : "text_20"),
					// 	'text': $.Localize('#'+'donnot_show_badge'),
					// });

					if (badge == MY_CURR_BADGE) {
						CreateUIElement(one_badge, "Panel", "", {
							"class": "icon_equiped icon_one_equiped",
						});
					}
					
				}
				else {
					// 普通徽章
					var title = $.Localize('#'+'badge_title_' + badge);
					var text = $.Localize('#'+'badge_text_' + badge);
					var one_badge = CreateUIElement($('#select-block-badge-inner'), "Panel", "", {
						'class': 'goods_list_one_outer_badge' + ((badge == MY_CURR_BADGE) ? " selected" : ""),
						'onactivate': 'choose_badge(\'' + badge + '\')',
						'onmouseover': 'DOTAShowTitleTextTooltip(\'' + title + '\',\''+ text +'\')',
						'onmouseout': 'DOTAHideTitleTextTooltip()',
					});
					CreateUIElement(one_badge, "Image", "", {
						'class': 'img_loading_select_badge',
						'src': 'file://{images}/custom_game/badges/' + badge + '.png',
					});
					// CreateUIElement(one_badge, "Label", "", {
					// 	'class': ((badge == MY_CURR_BADGE) ? "text_20_highlight" : "text_20"),
					// 	'text': $.Localize('#'+'badge_title_' + badge),
					// });

					if (badge == MY_CURR_BADGE) {
						CreateUIElement(one_badge, "Panel", "", {
							"class": "icon_equiped icon_one_equiped",
						});
					}
				}

				
			}
		}
		$('#select-block-badge').SetHasClass('invisible', false);
	}
	else {
		// 木有徽章
		$('#select-block-badge').SetHasClass('invisible', true);
	}
}

var click_cd = false;

var MY_COURIER_LIST = [];
var MY_CURR_COURIER = null;
function choose_courier(hero) {
	MY_CURR_COURIER = hero;
	GameEvents.SendCustomGameEventToServer("choose_courier", {
		"courier": MY_CURR_COURIER,
	});
	fill_my_courier_list();

	$.Schedule(0.3, function () {
		$.DispatchEvent("DOTAGame_PlayerDetailsChanged");
	});
	$.Schedule(0.5, function () {
		$.DispatchEvent("DOTAGame_PlayerDetailsChanged");
	});
}

var MY_CHESSBOARD_LIST = [];
var MY_CURR_CHESSBOARD = null;
function choose_chessboard(chessboard) {
	MY_CURR_CHESSBOARD = chessboard;
	GameEvents.SendCustomGameEventToServer("choose_chessboard", {
		"chessboard": MY_CURR_CHESSBOARD,
	});
	fill_my_chessboard_list();
	$.Schedule(0.3, function () {
		$.DispatchEvent("DOTAGame_PlayerDetailsChanged");
	});
	$.Schedule(0.5, function () {
		$.DispatchEvent("DOTAGame_PlayerDetailsChanged");
	});
}

var MY_BADGE_LIST = ['donnot_show_badge'];
var MY_CURR_BADGE = null;
function choose_badge(badge) {
	MY_CURR_BADGE = badge;
	GameEvents.SendCustomGameEventToServer("choose_badge", {
		"badge": badge,
	});
	fill_my_badge_list();
}



function xmlToJson(xml) {
	// 新建返回的对象
	var obj = {};
	if (xml.nodeType == 1) {

		// 处理属性
		if (xml.attributes.length > 0) {
			obj["@attributes"] = {};
			for (var j = 0; j < xml.attributes.length; j++) {
				var attribute = xml.attributes.item(j);
				obj["@attributes"][attribute.nodeName] = attribute.nodeValue;
			}
		}
	} else if (xml.nodeType == 3) {
		// 文本
		obj = xml.nodeValue;
	}
	// 处理子节点
	// 如果所有子节点都是文本，则把它们拼接起来
	var textNodes = [].slice.call(xml.childNodes).filter(function (node) {
		return node.nodeType === 3;
	});
	if (xml.hasChildNodes() && xml.childNodes.length === textNodes.length) {
		obj = [].slice.call(xml.childNodes).reduce(function (text, node) {
			return text + node.nodeValue;
		}, "");
	} else if (xml.hasChildNodes()) {
		for (var i = 0; i < xml.childNodes.length; i++) {
			var item = xml.childNodes.item(i);
			var nodeName = item.nodeName;
			if (typeof obj[nodeName] == "undefined") {
				obj[nodeName] = xmlToJson(item);
			} else {
				if (typeof obj[nodeName].push == "undefined") {
					var old = obj[nodeName];
					obj[nodeName] = [];
					obj[nodeName].push(old);
				}
				obj[nodeName].push(xmlToJson(item));
			}
		}
	}
	return obj;
}

function go_browser_url(link){
	$.DispatchEvent('ExternalBrowserGoToURL', link);
}

function SetMouseTips(panel,tip_title,tip_text){
	panel.SetPanelEvent("onmouseover",
		function () {
			$.DispatchEvent("DOTAShowTitleTextTooltip",panel,tip_title,tip_text);
		}
	);
	panel.SetPanelEvent("onmouseout",
		function () {
			$.DispatchEvent("DOTAHideTitleTextTooltip");
		}
	);
}