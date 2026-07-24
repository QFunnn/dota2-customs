--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";

//=============================================================================
//=============================================================================
function _ScoreboardUpdater_SetTextSafe( panel, childName, textValue )
{
	if ( panel === null )
		return;
	var childPanel = panel.FindChildInLayoutFile( childName )
	if ( childPanel === null )
		return;

	childPanel.text = textValue;
}

function _ScoreboardUpdater_SetHtmlSafe( panel, childName, textValue )
{
	if ( panel === null )
		return;
	var childPanel = panel.FindChildInLayoutFile( childName )
	if ( childPanel === null )
		return;

	childPanel.html=true;
	childPanel.text = textValue;
}


function parseBigNumber(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


//=============================================================================
//=============================================================================
function _ScoreboardUpdater_UpdatePlayerPanel( scoreboardConfig, playersContainer, playerId, localPlayerTeamId )
{
	var playerPanelName = "_dynamic_player_" + playerId;
	var playerPanel = playersContainer.FindChild( playerPanelName );
	if ( playerPanel === null )
	{
		playerPanel = $.CreatePanel( "Panel", playersContainer, playerPanelName );
		playerPanel.SetAttributeInt( "player_id", playerId );
		playerPanel.BLoadLayout( scoreboardConfig.playerXmlName, false, false );
	}

	playerPanel.SetHasClass( "is_local_player", ( playerId == Game.GetLocalPlayerID() ) );

	var ultStateOrTime = PlayerUltimateStateOrTime_t.PLAYER_ULTIMATE_STATE_HIDDEN; // values > 0 mean on cooldown for that many seconds
	var goldValue
	var isTeammate = false;

	var playerInfo = Game.GetPlayerInfo( playerId );
	var heroIndex = Players.GetPlayerHeroEntityIndex(playerId)
	if ( playerInfo )
	{
		isTeammate = ( playerInfo.player_team_id == localPlayerTeamId );
		if ( isTeammate )
		{
			ultStateOrTime = Game.GetPlayerUltimateStateOrTime( playerId );
		}
        // goldValue 使用后台统计值
		var goldData = CustomNetTables.GetTableValue( "player_info", playerId )
		if (goldData!=undefined) {
			goldValue = goldData.gold
		} else{
			goldValue = 600
		}

		playerPanel.SetHasClass( "player_dead", ( playerInfo.player_respawn_seconds >= 0 ) );
		playerPanel.SetHasClass( "local_player_teammate", isTeammate && ( playerId != Game.GetLocalPlayerID() ) );

		_ScoreboardUpdater_SetTextSafe( playerPanel, "RespawnTimer", ( playerInfo.player_respawn_seconds + 1 ) ); // value is rounded down so just add one for rounded-up

		if (playerInfo.player_respawn_seconds>10)
		{
           _ScoreboardUpdater_SetTextSafe( playerPanel, "RespawnTimer", "K.O." );
		}
		else
		{
            _ScoreboardUpdater_SetTextSafe( playerPanel, "RespawnTimer", ( playerInfo.player_respawn_seconds + 1 ) );
		}

		// if (typeof GetEarlyLeaver === "function")
		// {
		// 	_ScoreboardUpdater_SetTextSafe( playerPanel, "PlayerName", playerInfo.player_name+GetEarlyLeaver(playerId) );
		// }
		// else
		// {
        //     _ScoreboardUpdater_SetTextSafe( playerPanel, "PlayerName", playerInfo.player_name);
		// }

		_ScoreboardUpdater_SetTextSafe( playerPanel, "Level", playerInfo.player_level );

		var pvpRecord = CustomNetTables.GetTableValue( "pvp_record", playerId )

        if (pvpRecord!=undefined) {
          _ScoreboardUpdater_SetTextSafe( playerPanel, "Kills", pvpRecord.win );
		  _ScoreboardUpdater_SetTextSafe( playerPanel, "Deaths", pvpRecord.lose );
		  _ScoreboardUpdater_SetTextSafe( playerPanel, "PlayerBetRewardAmount", pvpRecord.total_bet_reward );
        }

		_ScoreboardUpdater_SetTextSafe( playerPanel, "Assists", playerInfo.player_assists );

		var playerPortrait = playerPanel.FindChildInLayoutFile( "HeroIcon" );
		if ( playerPortrait )
		{
			if ( playerInfo.player_selected_hero !== "" )
			{
				playerPortrait.SetImage( "file://{images}/heroes/" + playerInfo.player_selected_hero + ".png" );
			}
			else
			{
				playerPortrait.SetImage( "file://{images}/custom_game/unassigned.png" );
			}
		}

		if ( playerInfo.player_selected_hero_id == -1 )
		{
			_ScoreboardUpdater_SetTextSafe( playerPanel, "HeroName", $.Localize( "#DOTA_Scoreboard_Picking_Hero" ) )
		}
		else
		{
			_ScoreboardUpdater_SetTextSafe( playerPanel, "HeroName", $.Localize( "#"+playerInfo.player_selected_hero ) )
		}

		var heroNameAndDescription = playerPanel.FindChildInLayoutFile( "HeroNameAndDescription" );
		if ( heroNameAndDescription )
		{
			if ( playerInfo.player_selected_hero_id == -1 )
			{
				heroNameAndDescription.SetDialogVariable( "hero_name", $.Localize( "#DOTA_Scoreboard_Picking_Hero" ) );
			}
			else
			{
				heroNameAndDescription.SetDialogVariable( "hero_name", $.Localize( "#"+playerInfo.player_selected_hero ) );
			}
			heroNameAndDescription.SetDialogVariableInt( "hero_level",  playerInfo.player_level );
		}

		playerPanel.SetHasClass( "player_connection_abandoned", playerInfo.player_connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_ABANDONED );
		playerPanel.SetHasClass( "player_connection_failed", playerInfo.player_connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_FAILED );
		playerPanel.SetHasClass( "player_connection_disconnected", playerInfo.player_connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_DISCONNECTED );

		var playerAvatar = playerPanel.FindChildInLayoutFile( "AvatarImage" );
		if ( playerAvatar )
		{
			playerAvatar.steamid = playerInfo.player_steamid;
		}

		var playerColorBar = playerPanel.FindChildInLayoutFile( "PlayerColorBar" );
		if ( playerColorBar !== null )
		{
			if ( GameUI.CustomUIConfig().team_colors )
			{
				var teamColor = GameUI.CustomUIConfig().team_colors[ playerInfo.player_team_id ];
				if ( teamColor )
				{
					playerColorBar.style.backgroundColor = teamColor;
				}
			}
			else
			{
				var playerColor = "#000000";
				playerColorBar.style.backgroundColor = playerColor;
			}
		}
	}

	var playerItemsContainer = playerPanel.FindChildInLayoutFile( "PlayerItemsContainer" );
	if ( playerItemsContainer )
	{
		var playerItems = Game.GetPlayerItems( playerId );
		if ( playerItems )
		{
			for ( var i = playerItems.inventory_slot_min; i < playerItems.inventory_slot_max; ++i )
			{
				var itemPanelName = "_dynamic_item_" + i;
				var itemPanel = playerItemsContainer.FindChild( itemPanelName );
				if ( itemPanel === null )
				{
					itemPanel = $.CreatePanel( "DOTAItemImage", playerItemsContainer, itemPanelName );
					itemPanel.AddClass( "PlayerItem" );
				}

				var itemInfo = playerItems.inventory[i];
				if ( itemInfo )
				{
					itemPanel.itemname = itemInfo.item_name
					itemPanel.SetHasClass("empty_item", false)
				}
				else
				{
					itemPanel.itemname = ""
					itemPanel.SetHasClass("empty_item", true)
				}
			}
		}
		var neutral_item = Entities.GetItemInSlot(heroIndex, 16)
		var itemPanelName = "_dynamic_item_16";
		var itemPanel = playerItemsContainer.FindChild( itemPanelName );
		if ( itemPanel === null )
		{
			itemPanel = $.CreatePanel( "DOTAItemImage", playerItemsContainer, itemPanelName );
			itemPanel.AddClass( "PlayerItem" );
			itemPanel.AddClass( "NeutralItem");
		}
		if (neutral_item != -1) {
			itemPanel.itemname = Abilities.GetAbilityName(neutral_item)
			itemPanel.SetHasClass("empty_item", false)
		}
		else {
			itemPanel.SetImage( "" );
			itemPanel.SetHasClass("empty_item", true)
		}
		let last_container = playerItemsContainer.FindChild("_dynamic_item_8")
		if (last_container) {
			playerItemsContainer.MoveChildAfter(itemPanel, last_container)
		}
	}

	let playerAbilitiesContainer = playerPanel.FindChildInLayoutFile( "AbilitiesContainer" )
	if ( playerAbilitiesContainer && heroIndex) {

		let talent_tree_name = "_dynamic_talent_tree_" + playerId
		let talent_display = playerAbilitiesContainer.FindChild(talent_tree_name)
		if (talent_display === null) {

			talent_display = $.CreatePanel("DOTAHudTalentDisplay", playerAbilitiesContainer, talent_tree_name)
			talent_display.style.height = "36px"
			talent_display.style.width = "36px"
			let container = talent_display.FindChildTraverse("StatPipContainer")
			let tree_parts = talent_display.FindChildrenWithClassTraverse("StatBranchPip")
			tree_parts.forEach(panel=>{
				panel.style.width = "36px"
				panel.style.height = "36px"
			})
			talent_display.AddClass("TalentTree")
		}
		talent_display.SetPanelEvent("onmouseover", _ShowTalentsTooltip(talent_display, playerInfo.player_selected_hero_id))
		talent_display.SetPanelEvent("onmouseout", _HideTalentsTooltip(talent_display))
		talent_display.heroname = playerInfo.player_selected_hero
		talent_display.contextEntityIndex = playerInfo.player_selected_hero_id

		for (var i = 0; i < 30; i++) {
			if (playerInfo.player_selected_hero == "npc_dota_hero_invoker") {
				if (i == 16) {i=25}
			}
			else {
				if (i == 6) {i=14} // skip talent panels, we don't need extra 8 panels per hero that will be hidden anyways
			}
			let ability = Entities.GetAbility(heroIndex, i)
			var ability_panel_name = "_dynamic_ability_" + i
			var ability_panel = playerAbilitiesContainer.FindChild(ability_panel_name)
			if ( ability_panel === null ) {
				ability_panel = $.CreatePanel("DOTAAbilityImage", playerAbilitiesContainer, ability_panel_name)
				ability_panel.AddClass("PlayerAbility")
			}
			if (ability != -1 && !Abilities.IsHidden(ability) && !Abilities.GetAbilityName(ability).includes("special_bonus")) {
				ability_panel.SetHasClass("empty_ability", false)
				ability_panel.abilityname = Abilities.GetAbilityName(ability)
				ability_panel.contextEntityIndex = ability
				ability_panel.SetPanelEvent("onmouseover", _ShowTooltip(ability_panel, Abilities.GetAbilityName(ability), heroIndex))
				ability_panel.SetPanelEvent("onmouseout", _HideTooltip(ability_panel))
				ability_panel.SetPanelEvent("onactivate", _Ping(ability))
			}
			else {
				ability_panel.SetHasClass("empty_ability", true)
			}
		}
	}

	var damageContainer = playerPanel.FindChildInLayoutFile( "DamageContainer" )
	if ( damageContainer && heroIndex) {
		 var damageCount = CustomNetTables.GetTableValue("hero_info", "damage_count")
		 var maxDamage = CustomNetTables.GetTableValue("hero_info", "max_damage")
		 if (maxDamage && maxDamage["max_damage"]&&maxDamage["max_damage"]>0&&damageCount[playerId])
		 {
            damageContainer.FindChildTraverse("DamageProgressBar").value = damageCount[playerId]/maxDamage["max_damage"];
            damageContainer.FindChildTraverse("DamageValue").text = Math.round(damageCount[playerId]);
		 }
		 else
		 {
		 	damageContainer.FindChildTraverse("DamageProgressBar").value = 0;
            damageContainer.FindChildTraverse("DamageValue").text = 0;
		 }
	}

	if ( isTeammate )
	{
		_ScoreboardUpdater_SetTextSafe( playerPanel, "TeammateGoldAmount", goldValue );
	}

	_ScoreboardUpdater_SetTextSafe( playerPanel, "PlayerGoldAmount", goldValue );


    var RatingsContainer = playerPanel.FindChildInLayoutFile( "RatingsContainer" );
	// if ( RatingsContainer )
	// {
    //     var end_game_data = CustomNetTables.GetTableValue("end_game_data", "end_game_data");
    //     if (end_game_data['type']=='pve')
	// 	{
	// 		  $( "#dota_mind_label" ).text=$.Localize("#custom_end_screen_legend_round_number")
	// 		   var steam_id = playerInfo.player_steamid;
    //            steam_id = ConvertToSteamId32(steam_id);
    //            var round_number=end_game_data['round_number'][steam_id]
	// 		  //_ScoreboardUpdater_SetTextSafe( playerPanel, "PlayerRating", round_number );
	// 		  _ScoreboardUpdater_SetTextSafe( playerPanel, "DotaMindScore", round_number );

	// 	} else  {
    //           if ($( "#dota_mind_label" )!=undefined)
    //           {
    //           	  $( "#dota_mind_label" ).text=$.Localize("#custom_end_screen_legend_ratings")
    //           }
	// 		  var steam_id = playerInfo.player_steamid;
    //            steam_id = ConvertToSteamId32(steam_id);
    //            var score=end_game_data['score'][steam_id]
    //            var score_change=end_game_data['score_change'][steam_id]
    //            var score_change_type=end_game_data['score_change_type'][steam_id] //1加 2减 0平
    //            /**
    //            if (score_change_type=='0')
    //            {
    //            	  _ScoreboardUpdater_SetHtmlSafe( playerPanel, "PlayerRating", score+"("+score_change+")" );
    //            }
    //            if (score_change_type=='1')
    //            {
    //            	  //红
    //            	  _ScoreboardUpdater_SetHtmlSafe( playerPanel, "PlayerRating", score+"(<font color='#EA7070'>"+score_change+"</font>)" );
    //            }
	// 		   if (score_change_type=='2')
    //            {
    //            	  //绿
    //            	  _ScoreboardUpdater_SetHtmlSafe( playerPanel, "PlayerRating", score+"(<font color='#70EA72'>"+score_change+"</font>)" );
    //            }
    //            **/
    //            //处理Dota Mind分数
    //            var dotaMindData = CustomNetTables.GetTableValue("end_game_data","dota_mind_score_"+steam_id);
	// 		   if (dotaMindData!=undefined)
	// 		   {
	// 		         //如果分数下降
	// 			     if (parseInt(dotaMindData.origin)>parseInt(dotaMindData.score))
	// 			     {
	// 			     	//绿
	// 			     	var dotaMindScoreChange="-"+(parseInt(dotaMindData.origin)-parseInt(dotaMindData.score));
    //            	        _ScoreboardUpdater_SetHtmlSafe( playerPanel, "DotaMindScore", parseInt(dotaMindData.score)+"(<font color='#70EA72'>"+dotaMindScoreChange+"</font>)" );
	// 			     }
	// 			     if (parseInt(dotaMindData.origin)<parseInt(dotaMindData.score))
	// 			     {
	// 			     	 //红
	// 			     	 var dotaMindScoreChange="+"+(parseInt(dotaMindData.score)-parseInt(dotaMindData.origin));
    //            	        _ScoreboardUpdater_SetHtmlSafe( playerPanel, "DotaMindScore", parseInt(dotaMindData.score)+"(<font color='#EA7070'>"+dotaMindScoreChange+"</font>)" );
	// 			     }
	// 			     if (parseInt(dotaMindData.origin)==parseInt(dotaMindData.score))
	// 			     {
	// 			     	 //白
    //            	        _ScoreboardUpdater_SetHtmlSafe( playerPanel, "DotaMindScore", parseInt(dotaMindData.score)+"(+0)" );
	// 			     }
	// 		   }
	// 	}

    //     var free_money=end_game_data['free_money'][steam_id]
	//     _ScoreboardUpdater_SetTextSafe( playerPanel, "MoneyChangeLabel", "+"+free_money );

    // }

	playerPanel.SetHasClass( "player_ultimate_ready", ( ultStateOrTime == PlayerUltimateStateOrTime_t.PLAYER_ULTIMATE_STATE_READY ) );
	playerPanel.SetHasClass( "player_ultimate_no_mana", ( ultStateOrTime == PlayerUltimateStateOrTime_t.PLAYER_ULTIMATE_STATE_NO_MANA) );
	playerPanel.SetHasClass( "player_ultimate_not_leveled", ( ultStateOrTime == PlayerUltimateStateOrTime_t.PLAYER_ULTIMATE_STATE_NOT_LEVELED) );
	playerPanel.SetHasClass( "player_ultimate_hidden", ( ultStateOrTime == PlayerUltimateStateOrTime_t.PLAYER_ULTIMATE_STATE_HIDDEN) );
	playerPanel.SetHasClass( "player_ultimate_cooldown", ( ultStateOrTime > 0 ) );
	_ScoreboardUpdater_SetTextSafe( playerPanel, "PlayerUltimateCooldown", ultStateOrTime );
}


//=============================================================================
//=============================================================================
function _ScoreboardUpdater_UpdateTeamPanel( scoreboardConfig, containerPanel, teamDetails, teamsInfo )
{
	if ( !containerPanel )
		return;

	var teamId = teamDetails.team_id;
//	$.Msg( "_ScoreboardUpdater_UpdateTeamPanel: ", teamId );

	var teamPanelName = "_dynamic_team_" + teamId;
	var teamPanel = containerPanel.FindChild( teamPanelName );
	if ( teamPanel === null )
	{
//		$.Msg( "UpdateTeamPanel.Create: ", teamPanelName, " = ", scoreboardConfig.teamXmlName );
		teamPanel = $.CreatePanel( "Panel", containerPanel, teamPanelName );
		teamPanel.SetAttributeInt( "team_id", teamId );
		teamPanel.BLoadLayout( scoreboardConfig.teamXmlName, false, false );

		var logo_xml = GameUI.CustomUIConfig().team_logo_xml;
		if ( logo_xml )
		{
			var teamLogoPanel = teamPanel.FindChildInLayoutFile( "TeamLogo" );
			if ( teamLogoPanel )
			{
				teamLogoPanel.SetAttributeInt( "team_id", teamId );
				teamLogoPanel.BLoadLayout( logo_xml, false, false );
			}
		}
	}

	var localPlayerTeamId = -1;
	var localPlayer = Game.GetLocalPlayerInfo();
	if ( localPlayer )
	{
		localPlayerTeamId = localPlayer.player_team_id;
	}
	teamPanel.SetHasClass( "local_player_team", localPlayerTeamId == teamId );
	teamPanel.SetHasClass( "not_local_player_team", localPlayerTeamId != teamId );

	var teamPlayers = Game.GetPlayerIDsOnTeam( teamId )
	var playersContainer = teamPanel.FindChildInLayoutFile( "PlayersContainer" );

	if ( playersContainer )
	{
		for ( var playerId of teamPlayers )
		{
			_ScoreboardUpdater_UpdatePlayerPanel( scoreboardConfig, playersContainer, playerId, localPlayerTeamId )
		}
	}

	teamPanel.SetHasClass( "no_players", (teamPlayers.length == 0) )
	teamPanel.SetHasClass( "one_player", (teamPlayers.length == 1) )

	if ( teamsInfo.max_team_players < teamPlayers.length )
	{
		teamsInfo.max_team_players = teamPlayers.length;
	}

	_ScoreboardUpdater_SetTextSafe( teamPanel, "TeamScore", teamDetails.total_gold )
	// _ScoreboardUpdater_SetTextSafe( teamPanel, "TeamName", $.Localize("#"+ teamDetails.team_name ) )

	if ( GameUI.CustomUIConfig().team_colors )
	{
		var teamColor = GameUI.CustomUIConfig().team_colors[ teamId ];
		var teamColorPanel = teamPanel.FindChildInLayoutFile( "TeamColor" );

		teamColor = teamColor.replace( ";", "" );

		if ( teamColorPanel )
		{
			teamNamePanel.style.backgroundColor = teamColor + ";";
		}

		var teamColor_GradentFromTransparentLeft = teamPanel.FindChildInLayoutFile( "TeamColor_GradentFromTransparentLeft" );
		if ( teamColor_GradentFromTransparentLeft )
		{
			var gradientText = 'gradient( linear, 0% 0%, 800% 0%, from( #00000000 ), to( ' + teamColor + ' ) );';
//			$.Msg( gradientText );
			teamColor_GradentFromTransparentLeft.style.backgroundColor = gradientText;
		}
	}

	return teamPanel;
}

//=============================================================================
//=============================================================================
function _ScoreboardUpdater_ReorderTeam( scoreboardConfig, teamsParent, teamPanel, teamId, newPlace, prevPanel )
{
//	$.Msg( "UPDATE: ", GameUI.CustomUIConfig().teamsPrevPlace );
	var oldPlace = null;
	if ( GameUI.CustomUIConfig().teamsPrevPlace.length > teamId )
	{
		oldPlace = GameUI.CustomUIConfig().teamsPrevPlace[ teamId ];
	}
	GameUI.CustomUIConfig().teamsPrevPlace[ teamId ] = newPlace;

	if ( newPlace != oldPlace )
	{
//		$.Msg( "Team ", teamId, " : ", oldPlace, " --> ", newPlace );
		teamPanel.RemoveClass( "team_getting_worse" );
		teamPanel.RemoveClass( "team_getting_better" );
		if ( newPlace > oldPlace )
		{
			teamPanel.AddClass( "team_getting_worse" );
		}
		else if ( newPlace < oldPlace )
		{
			teamPanel.AddClass( "team_getting_better" );
		}
	}

	teamsParent.MoveChildAfter( teamPanel, prevPanel );
}

// sort / reorder as necessary
function compareFunc( a, b ) // GameUI.CustomUIConfig().sort_teams_compare_func;
{

	if (a.rank > b.rank)
	{
		return 1;
	}
	else if ( a.rank < b.rank )
	{
       return -1;
	}
	else
	{
        if ( a.total_gold < b.total_gold )
		{
			return 1; // [ B, A ]
		}
		else if ( a.total_gold > b.total_gold )
		{
			return -1; // [ A, B ]
		}
		else
		{
			return 0;
		}
	}
};

function stableCompareFunc( a, b )
{
	var unstableCompare = compareFunc( a, b );
	if ( unstableCompare != 0 )
	{
		return unstableCompare;
	}

	if ( GameUI.CustomUIConfig().teamsPrevPlace.length <= a.team_id )
	{
		return 0;
	}

	if ( GameUI.CustomUIConfig().teamsPrevPlace.length <= b.team_id )
	{
		return 0;
	}

//			$.Msg( GameUI.CustomUIConfig().teamsPrevPlace );

	var a_prev = GameUI.CustomUIConfig().teamsPrevPlace[ a.team_id ];
	var b_prev = GameUI.CustomUIConfig().teamsPrevPlace[ b.team_id ];
	if ( a_prev < b_prev ) // [ A, B ]
	{
		return -1; // [ A, B ]
	}
	else if ( a_prev > b_prev ) // [ B, A ]
	{
		return 1; // [ B, A ]
	}
	else
	{
		return 0;
	}
};

//=============================================================================
//=============================================================================
function _ScoreboardUpdater_UpdateAllTeamsAndPlayers( scoreboardConfig, teamsContainer )
{
//	$.Msg( "_ScoreboardUpdater_UpdateAllTeamsAndPlayers: ", scoreboardConfig );

	var teamsList = [];
	for ( var teamId of Game.GetAllTeamIDs() )
	{
		var  team =  Game.GetTeamDetails( teamId )
        var teamPlayers = Game.GetPlayerIDsOnTeam( teamId )
	    //统计全队获得全部金币
		var total_gold = 0
		for ( var playerId of teamPlayers )
		{
			var goldData = CustomNetTables.GetTableValue( "player_info", playerId )
			if (goldData!=undefined) {
				total_gold = total_gold+goldData.gold
			} else{
				total_gold = total_gold +600
			}
		}
		team.total_gold= total_gold;

        //队伍最终排名（先按排名排序，如果排名都是0，按照经济排序 ）
        var rankData = CustomNetTables.GetTableValue( "team_rank", teamId )
        if (rankData!=undefined && rankData.rank!=undefined) {
            team.rank=rankData.rank
        } else {
        	team.rank=99
        }

		teamsList.push(team);
	}



	// update/create team panels
	var teamsInfo = { max_team_players: 0 };
	var panelsByTeam = [];
	for ( var i = 0; i < teamsList.length; ++i )
	{
		var teamPanel = _ScoreboardUpdater_UpdateTeamPanel( scoreboardConfig, teamsContainer, teamsList[i], teamsInfo );
		if ( teamPanel )
		{
			panelsByTeam[ teamsList[i].team_id ] = teamPanel;
		}
	}

	if ( teamsList.length > 1 )
	{
//		$.Msg( "panelsByTeam: ", panelsByTeam );

		// sort
		if ( scoreboardConfig.shouldSort )
		{
			teamsList.sort( stableCompareFunc );
		}

//		$.Msg( "POST: ", teamsAndPanels );

		// reorder the panels based on the sort
		var prevPanel = panelsByTeam[ teamsList[0].team_id ];
		for ( var i = 0; i < teamsList.length; ++i )
		{
			var teamId = teamsList[i].team_id;
			var teamPanel = panelsByTeam[ teamId ];
			_ScoreboardUpdater_ReorderTeam( scoreboardConfig, teamsContainer, teamPanel, teamId, i, prevPanel );
			prevPanel = teamPanel;
		}
//		$.Msg( GameUI.CustomUIConfig().teamsPrevPlace );
	}

}


//=============================================================================
//=============================================================================
function ScoreboardUpdater_InitializeScoreboard( scoreboardConfig, scoreboardPanel )
{
	GameUI.CustomUIConfig().teamsPrevPlace = [];
	if ( typeof(scoreboardConfig.shouldSort) === 'undefined')
	{
		// default to true
		scoreboardConfig.shouldSort = true;
	}
	_ScoreboardUpdater_UpdateAllTeamsAndPlayers( scoreboardConfig, scoreboardPanel );
	return { "scoreboardConfig": scoreboardConfig, "scoreboardPanel":scoreboardPanel }
}


//=============================================================================
//=============================================================================
function ScoreboardUpdater_SetScoreboardActive( scoreboardHandle, isActive )
{
	if ( scoreboardHandle.scoreboardConfig === null || scoreboardHandle.scoreboardPanel === null )
	{
		return;
	}

	if ( isActive )
	{
		_ScoreboardUpdater_UpdateAllTeamsAndPlayers( scoreboardHandle.scoreboardConfig, scoreboardHandle.scoreboardPanel );
	}
}

//=============================================================================
//=============================================================================
function ScoreboardUpdater_GetTeamPanel( scoreboardHandle, teamId )
{
	if ( scoreboardHandle.scoreboardPanel === null )
	{
		return;
	}

	var teamPanelName = "_dynamic_team_" + teamId;
	return scoreboardHandle.scoreboardPanel.FindChild( teamPanelName );
}

//=============================================================================
//=============================================================================
function ScoreboardUpdater_GetSortedTeamInfoList( scoreboardHandle )
{
	var teamsList = [];
	for ( var teamId of Game.GetAllTeamIDs() )
	{
		teamsList.push( Game.GetTeamDetails( teamId ) );
	}

	if ( teamsList.length > 1 )
	{
		teamsList.sort( stableCompareFunc );
	}

	return teamsList;
}



function _ShowTooltip(panel, abilityName, heroIndex) {
	return () => {
		$.DispatchEvent("DOTAShowAbilityTooltipForEntityIndex", panel, abilityName, heroIndex);
	}
}

function _HideTooltip(panel) {
	return () => {
		$.DispatchEvent("DOTAHideAbilityTooltip");
	}
}

function _Ping(ability_entindex) {
	return () => {
		Abilities.PingAbility(ability_entindex)
	}
}

function _ShowTalentsTooltip(panel, heroIndex) {
	return () => {
		$.DispatchEvent("DOTAHUDShowHeroStatBranchTooltip", panel, heroIndex);
	}
}

function _HideTalentsTooltip(panel) {
	return () => {
		$.DispatchEvent("DOTAHUDHideStatBranchTooltip");
	}
}