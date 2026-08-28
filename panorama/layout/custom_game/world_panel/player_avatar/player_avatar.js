--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


// function Update() {
// 	$.Schedule(0, Update);
// }
// function UpdatePlayerDataNetTable(tableName, tableKeyName, table) {
// 	$.GetContextPanel().style.width = null;
// 	$.GetContextPanel().style.height = null;

// 	var localPlayerID = Players.GetLocalPlayer();
// 	if (tableKeyName == "player_datas") {
// 		var localPlayerData = table[localPlayerID.toString()];

// 		for (var k in table) {
// 			var playerID = parseInt(k);
// 			var playerData = table[k];
// 			var playerPositionNumber = playerData.playerPositionNumber;
// 			var playerColor = intToARGB(Players.GetPlayerColor(playerID));

// 			if ($.GetContextPanel().BHasClass("player_position_"+playerPositionNumber)) {
// 				$.GetContextPanel().SetHasClass("Valid", true);
// 				var playerInfo = Game.GetPlayerInfo(playerID);
// 				$("#PlayerUserName").steamid = playerInfo.player_steamid;
// 				$("#PlayerAvatar").steamid = playerInfo.player_steamid;
// 				$("#PlayerAvatar").style.borderColor = "#"+playerColor;
// 			}
// 		}
// 	}
// }

function UpdatePlayerWorldPanel(data){
	return;
	if (!data){
		return;
	}
	var pve_round;
	if (data.pve_round){
		pve_round = data.pve_round;
	}
	for (var team_id in data) {
		if (team_id == 'pve_round'){
			continue;
		}
		var player_info = data[team_id];
		if (player_info.steam_id) {
			if ($("#world_panel_player_username_"+team_id)){
				$("#world_panel_player_username_"+team_id).style['opacity'] = '1';
				$("#world_panel_player_username_"+team_id).steamid = player_info.steam_id;
			}
			if ($("#world_panel_player_avatar_"+team_id)){
				$("#world_panel_player_avatar_"+team_id).style['opacity'] = '1';
				$("#world_panel_player_avatar_"+team_id).steamid = player_info.steam_id;
			}
			if ($("#world_panel_player_avatar_border_"+team_id)){
				$("#world_panel_player_avatar_border_"+team_id).style['opacity'] = '1';
			}
		}
		else{
			if ($("#world_panel_player_username_"+team_id)){
				$("#world_panel_player_username_"+team_id).style['opacity'] = '0';
			}
			if ($("#world_panel_player_avatar_"+team_id)){
				$("#world_panel_player_avatar_"+team_id).style['opacity'] = '0';
			}
			if ($("#world_panel_player_avatar_border_"+team_id)){
				$("#world_panel_player_avatar_border_"+team_id).style['opacity'] = '0';
			}
		}
		if (player_info.oppo_steam_id) {
			if ($("#world_panel_player_username_oppo_"+team_id)){
				$("#world_panel_player_username_oppo_"+team_id).style['opacity'] = '1';
				$("#world_panel_player_username_oppo_"+team_id).steamid = player_info.oppo_steam_id;
			}
			if ($("#world_panel_player_avatar_oppo_"+team_id)){
				$("#world_panel_player_avatar_oppo_"+team_id).style['opacity'] = '1';
				$("#world_panel_player_avatar_oppo_"+team_id).steamid = player_info.oppo_steam_id;
			}
			if ($("#world_panel_player_avatar_border_oppo_"+team_id)){
				$("#world_panel_player_avatar_border_oppo_"+team_id).style['opacity'] = '1';
			}
		}
		else{
			if ($("#world_panel_player_username_oppo_"+team_id)){
				$("#world_panel_player_username_oppo_"+team_id).style['opacity'] = '0';
			}
			if ($("#world_panel_player_avatar_oppo_"+team_id)){
				$("#world_panel_player_avatar_oppo_"+team_id).style['opacity'] = '0';
			}
			if ($("#world_panel_player_avatar_border_oppo_"+team_id)){
				$("#world_panel_player_avatar_border_oppo_"+team_id).style['opacity'] = '0';
			}
		}
		if (pve_round && player_info.steam_id){
			if ($("#world_panel_pve_"+team_id)){
				$("#world_panel_pve_"+team_id).style['opacity'] = '1';
				$("#world_panel_pve_"+team_id).SetImage('file://{images}/custom_game/pve_logo/'+pve_round+'.png');
			}
		}
		else{
			if ($("#world_panel_pve_"+team_id)){
				$("#world_panel_pve_"+team_id).style['opacity'] = '0'; 
				// $("#world_panel_pve_"+team_id).SetImage('file://{images}/custom_game/pve_logo/'+pve_round+'.png');
			}
		}
	}
}

GameEvents.Subscribe("update_player_worldpanel", UpdatePlayerWorldPanel);