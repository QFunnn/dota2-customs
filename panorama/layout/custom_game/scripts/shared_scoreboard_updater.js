--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";

function HighlightByParty(player_id, party_icon) 
{
    if (party_icon)
    {
	    var party_map = CustomNetTables.GetTableValue("hero_info","party_map") 
	    if (party_map!= undefined)
	    {   
		    var party_id = party_map[player_id];
			if (party_id != undefined && parseInt(party_id)>0 && parseInt(party_id)<=10) {
				party_icon.SetHasClass("NoParty",false)
				party_icon.SetHasClass("Party_" + party_id, true);
				party_icon.style.visibility = "visible"
			} else {
				party_icon.SetHasClass("NoParty", true);
				party_icon.style.visibility = "collapse"
			}
		} else {
			party_icon.SetHasClass("NoParty", true);
			party_icon.style.visibility = "collapse"
		}
	}
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

	let PlayerInfo = GetPlayerTablesValue(`player_${playerId}_global`, `builder_info`)
	if(PlayerInfo){
		if (PlayerInfo.lifes_count > 0)
		{
			let AegisCountPanel = playerPanel.FindChildTraverse("AegisCountPanel")
			if (AegisCountPanel)
			{
				AegisCountPanel.RemoveAndDeleteChildren()
				for (var i = 1; i <= PlayerInfo.lifes_count; ++i) 
				{
					let aegis = $.CreatePanel("Panel", AegisCountPanel, "");
					aegis.AddClass("AegisIcon")
				}
			}
		} 
		else
		{
			let AegisCountPanel = playerPanel.FindChildTraverse("AegisCountPanel")
			if (AegisCountPanel) 
			{
				AegisCountPanel.RemoveAndDeleteChildren()
			}
		}
	}

	var PlayerInfoServer = CustomNetTables.GetTableValue("players_server_info", `player_${playerId}`)
	if (PlayerInfoServer)
	{
		ChangeBorderPlayer(playerPanel, PlayerInfoServer.frame, playerId)
		ChangeNickNamePlayer(playerPanel, PlayerInfoServer.nickname, playerId)

		SetupPlayerHeroIcon(playerId, playerPanel)
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
		}else{
			let PlayerTeamInfo = CustomNetTables.GetTableValue("globals", `team_${playerInfo.player_team_id}_round_info`)
			playerPanel.SetHasClass("ShowTimer", PlayerTeamInfo != undefined && (PlayerTeamInfo.current_state == 2 || PlayerTeamInfo.current_state == 3))
			if(PlayerTeamInfo != undefined && (PlayerTeamInfo.current_state == 2 || PlayerTeamInfo.current_state == 3)){
				let RawDif = PlayerTeamInfo.last_time - Game.GetGameTime()
    			let Diff = Math.max(Math.ceil(Math.abs(RawDif)), 0)
				playerPanel.SetDialogVariable("last_time_team", GetTimeString(Diff))
				playerPanel.SetHasClass("TimerWarning", RawDif < 0 || Diff <= 5)
			}
		}
        // goldValue 使用后台统计值
		var goldData = CustomNetTables.GetTableValue( "player_info", playerId )
		if (goldData!=undefined) {
			goldValue = goldData.gold
		} else{
			goldValue = 600
		}
		
		var minigameDeadData = CustomNetTables.GetTableValue("players", "player_" + playerId + "_minigame_dead");
		var isMinigameDead = (minigameDeadData != undefined && minigameDeadData.dead == 1);
		playerPanel.SetHasClass( "player_dead", ( playerInfo.player_respawn_seconds >= 0 ) );
		playerPanel.SetHasClass( "player_minigame_dead", isMinigameDead );
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

        _ScoreboardUpdater_SetTextSafe( playerPanel, "PlayerName", playerInfo.player_name);
	
		_ScoreboardUpdater_SetTextSafe( playerPanel, "Level", playerInfo.player_level );

		if (playerPanel.FindChildInLayoutFile("PartyIcon_team"))
		{
			HighlightByParty(playerId, playerPanel.FindChildInLayoutFile("PartyIcon_team"));
		}

		var PvpInfo = CustomNetTables.GetTableValue( "players", `player_${playerId}_pvp_info` )

        if (PvpInfo) {
          _ScoreboardUpdater_SetTextSafe( playerPanel, "Kills", PvpInfo.pvp_wins );
		  _ScoreboardUpdater_SetTextSafe( playerPanel, "Deaths", PvpInfo.pvp_loses );
		  _ScoreboardUpdater_SetTextSafe( playerPanel, "PlayerBetRewardAmount", PvpInfo.bet_total );
        }

        var BooksAndPages = CustomNetTables.GetTableValue("players", `player_${playerId}_collected_data`);
        if (BooksAndPages)
        {
		    _ScoreboardUpdater_SetTextSafe( playerPanel, "BookCounter", BooksAndPages.books || 0 );
		    _ScoreboardUpdater_SetTextSafe( playerPanel, "PagesCounter", BooksAndPages.pages || 0 );
        }
        else
        {
            _ScoreboardUpdater_SetTextSafe( playerPanel, "BookCounter", 0 );
            _ScoreboardUpdater_SetTextSafe( playerPanel, "PagesCounter", 0 );
        }

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

		var PlayerRank = playerPanel.FindChildInLayoutFile( "PlayerRank" );
		if ( PlayerRank )
		{
			var rank_info = CustomNetTables.GetTableValue("players_server_info", `player_${playerId}`)
    		if (rank_info != null) 
            {
		       if (rank_info && rank_info.profile)
		       {     
					if ( (rank_info.profile.rating_number_in_top > 0 && rank_info.profile.rating_number_in_top <= 10) && rank_info.profile.rating >= 5420)
					{
						PlayerRank.style.backgroundImage = 'url("file://{images}/custom_game/ranks/' + GetImageRank(10000) + '.png")';
					} 
					else 
					{
						PlayerRank.style.backgroundImage = 'url("file://{images}/custom_game/ranks/' + GetImageRank(rank_info.profile.rating) + '.png")';
					}
					PlayerRank.style.backgroundSize = "100%" 
		            // }
		       }
		       var rank_number = playerPanel.FindChildInLayoutFile( "rank_number" );
		       if (rank_number)
		       {
                    rank_number.text = rank_info.profile.rating_number_in_top
		       }
		    } else {
		        PlayerRank.style.backgroundImage = 'url("file://{images}/custom_game/ranks/' + "rank0" + '.png")';
		        PlayerRank.style.backgroundSize = "100%" 
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
        
        SetPlayerCreeps(playerPanel, playerId)

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
		let ContainerForAghanim = playerItemsContainer.FindChild("PlayerAghanimContainer")
		if(ContainerForAghanim == undefined){
			ContainerForAghanim = playerItemsContainer
		}

		let shard_and_scepter_upgrade_name = "_shard_and_scepter_upgrade_" + playerId
		let shard_and_scepter_upgrade_panel = ContainerForAghanim.FindChild(shard_and_scepter_upgrade_name)

		if (shard_and_scepter_upgrade_panel === null) {
			shard_and_scepter_upgrade_panel = $.CreatePanel("Panel", ContainerForAghanim, shard_and_scepter_upgrade_name, {class: "PlayerAghanimPanel"})    
		}

		let scepter_upgrade_name = "_scepter_upgrade_" + playerId
		let scepter_upgrade_panel = shard_and_scepter_upgrade_panel.FindChild(scepter_upgrade_name)

		if (scepter_upgrade_panel === null) {
			scepter_upgrade_panel = $.CreatePanel("Panel", shard_and_scepter_upgrade_panel, scepter_upgrade_name)    
			scepter_upgrade_panel.style.width = "100%"
			scepter_upgrade_panel.style.height = "65%"
			scepter_upgrade_panel.style.backgroundImage = 'url("s2r://panorama/images/hud/reborn/aghsstatus_scepter_psd.vtex")';
			scepter_upgrade_panel.style.backgroundSize = "contain"
			scepter_upgrade_panel.style.backgroundRepeat = "no-repeat"
			scepter_upgrade_panel.style.backgroundPosition = "center"
		}

		let shard_upgrade_name = "_shard_and_scepter_upgrade_" + playerId
		let shard_upgrade_panel = shard_and_scepter_upgrade_panel.FindChild(shard_upgrade_name)

		if (shard_upgrade_panel === null) {

			shard_upgrade_panel = $.CreatePanel("Panel", shard_and_scepter_upgrade_panel, shard_upgrade_name)    
			shard_upgrade_panel.style.width = "100%"
			shard_upgrade_panel.style.height = "35%"
			shard_upgrade_panel.style.verticalAlign = "bottom"
			shard_upgrade_panel.style.backgroundImage = 'url("s2r://panorama/images/hud/reborn/aghsstatus_shard_psd.vtex")';
			shard_upgrade_panel.style.backgroundSize = "contain"
			shard_upgrade_panel.style.backgroundRepeat = "no-repeat"
			shard_upgrade_panel.style.backgroundPosition = "center"
		}

		if (Entities.HasScepter( heroIndex ))
		{
			scepter_upgrade_panel.style.backgroundImage = 'url("s2r://panorama/images/hud/reborn/aghsstatus_scepter_on_psd.vtex")';
			scepter_upgrade_panel.style.backgroundSize = "contain"
		}

		if (HasModifier(heroIndex, "modifier_item_aghanims_shard"))
		{
			shard_upgrade_panel.style.backgroundImage = 'url("s2r://panorama/images/hud/reborn/aghsstatus_shard_on_psd.vtex")';
			shard_upgrade_panel.style.backgroundSize = "contain"
		}

		let ContainerForBasicItems = playerItemsContainer.FindChild("PlayerBasicItemsContainer")
		if(ContainerForBasicItems == undefined){
			ContainerForBasicItems = playerItemsContainer
		}
		
		let ContainerForBackpackItems = playerItemsContainer.FindChild("PlayerBackpackItemsContainer")
		if(ContainerForBackpackItems == undefined){
			ContainerForBackpackItems = playerItemsContainer
		}
		
		for ( var i = 0; i < 9; ++i )
		{
			var itemPanelName = "_dynamic_item_" + i;
			let Container = i >= 6 ? ContainerForBackpackItems : ContainerForBasicItems
			var itemPanel = Container.FindChild( itemPanelName );
			if ( itemPanel === null )
			{
				itemPanel = $.CreatePanel( "DOTAItemImage", Container, itemPanelName, {class: "PlayerItem"} );
			}

			var ItemEnt = Entities.GetItemInSlot(heroIndex, i);
			if ( ItemEnt != undefined && ItemEnt != -1 )
			{
				itemPanel.itemname = Abilities.GetAbilityName(ItemEnt)
				itemPanel.RemoveClass("empty_item")
			}
			else
			{
				itemPanel.itemname = ""
				itemPanel.AddClass("empty_item")
			}
		}

		var neutral_item = Entities.GetItemInSlot(heroIndex, 16)
		var itemPanelName = "_dynamic_item_16";
		var itemPanel = playerItemsContainer.FindChild( itemPanelName );
		if ( itemPanel === null )
		{	
			itemPanel = $.CreatePanel( "DOTAItemImage", playerItemsContainer, itemPanelName, {class: "PlayerItem NeutralItem", scaling: "stretch-to-fit-y-preserve-aspect"} );
		}
		if (neutral_item != -1) {
			itemPanel.itemname = Abilities.GetAbilityName(neutral_item)
			itemPanel.RemoveClass("empty_item")
		}
		else {
			itemPanel.SetImage( "" );
			itemPanel.AddClass("empty_item")
		}

		let ActiveSlot = Entities.GetItemInSlot(heroIndex, 16)
		let PassiveSlot = Entities.GetItemInSlot(heroIndex, 17)

		let ActiveID = -1
		let PassiveID = -1

		if(ActiveSlot && ActiveSlot != -1){
			ActiveID = GetItemID(Abilities.GetAbilityName(ActiveSlot)) || -1
		}

		if(PassiveSlot && PassiveSlot != -1){
			PassiveID = GetItemID(Abilities.GetAbilityName(PassiveSlot)) || -1
		}

		itemPanel.SetPanelEvent("onmouseover", () =>{
			if(ActiveID != -1 && PassiveID != -1){
				var neutralTier = 0;
				var GetCraftedItemInfo = GameUI.CustomUIConfig().GetCraftedItemInfo;
				if(GetCraftedItemInfo){
					var ownerID = Entities.GetPlayerOwnerID(heroIndex);
					var craftedInfo = GetCraftedItemInfo(ownerID, ActiveSlot);
					if(craftedInfo && craftedInfo.tier){
						neutralTier = craftedInfo.tier;
					}
				}
				$.DispatchEvent( "DOTAShowNeutralItemTooltip", itemPanel, ActiveID, PassiveID, neutralTier, Abilities.GetLevel( PassiveSlot ) )
			}
			if(ActiveID != -1 && PassiveID == -1){
				$.DispatchEvent( "DOTAShowAbilityInventoryItemTooltip", itemPanel, heroIndex, 16 )
			}
		})

		itemPanel.SetPanelEvent("onmouseout", () =>{
			$.DispatchEvent( "DOTAHideNeutralItemTooltip", itemPanel );
			$.DispatchEvent( "DOTAHideAbilityTooltip", itemPanel );
		})

		let last_container = playerItemsContainer.FindChild("_dynamic_item_8")
		if (last_container) {
			playerItemsContainer.MoveChildAfter(itemPanel, last_container)
		}
	}

	if(scoreboardConfig.bIsEndScreen){
		let EndData = GetPlayerTablesValue("globals", `player_${playerId}_end_data`)
		if(EndData && EndData.player_data){
			_ScoreboardUpdater_SetTextSafe( playerPanel, "SmokesCounter", String(EndData.player_data.smokes) );
			_ScoreboardUpdater_SetTextSafe( playerPanel, "AegisesCounter", String(EndData.player_data.lifes) );
			_ScoreboardUpdater_SetTextSafe( playerPanel, "CursesCounter", String(EndData.player_data.loser_curse) );

			let OtherInfo = playerPanel.FindChildInLayoutFile("InfoPanel")
			if(OtherInfo){
				OtherInfo.SetPanelEvent("onmouseover", function(){
					$.DispatchEvent(
						"UIShowCustomLayoutParametersTooltip",
						OtherInfo,
						"PlayerBonusInfoTooltip",
						"file://{resources}/layout/custom_game/player_bonus_info_tooltip.xml",
						`playerid=${playerId}`
					);
				})
				OtherInfo.SetPanelEvent("onmouseout", function(){
					$.DispatchEvent("UIHideCustomLayoutTooltip", OtherInfo, "PlayerBonusInfoTooltip");
				})
			}
		}
	}

	let playerAbilitiesContainer = playerPanel.FindChildInLayoutFile( "AbilitiesContainer" )
	if ( playerAbilitiesContainer && heroIndex) {
		let NeedMax = playerAbilitiesContainer.GetParent().id == "PlayerAbilitiesEndGame"
		let Num = 0
		for (var i = 0; i < 30; i++) {
			let ability = Entities.GetAbility(heroIndex, i)
			if (ability != -1 && !Abilities.IsHidden(ability) && !Abilities.GetAbilityName(ability).includes("special_bonus")) {
				if(NeedMax && Num >= 7){break}

				var ability_panel_name = "_dynamic_ability_" + Num
				var ability_panel = playerAbilitiesContainer.FindChild(ability_panel_name)
				if ( ability_panel === null ) {
					ability_panel = $.CreatePanel("DOTAAbilityImage", playerAbilitiesContainer, ability_panel_name, {class: "PlayerAbility"})
				}
				ability_panel.SetHasClass("empty_ability", false)
				ability_panel.abilityname = Abilities.GetAbilityName(ability)
				ability_panel.contextEntityIndex = ability
				ability_panel.SetPanelEvent("onmouseover", _ShowTooltip(ability_panel, Abilities.GetAbilityName(ability), heroIndex))
				ability_panel.SetPanelEvent("onmouseout", _HideTooltip(ability_panel))
				ability_panel.SetPanelEvent("onactivate", _Ping(ability))

				Num++;
			}
		}

		let Num2 = 0
		for (let i = 0; i < playerAbilitiesContainer.GetChildCount(); i++) {
			let Child = playerAbilitiesContainer.FindChildTraverse(`_dynamic_ability_${i}`)
			if(Child){
				if((Num-1) < Num2){
					SafeDeleteAsync(Child)
				}
				Num2++;
			}
		}
	}

	if ( isTeammate )
	{
		_ScoreboardUpdater_SetTextSafe( playerPanel, "TeammateGoldAmount", goldValue );
	}

	_ScoreboardUpdater_SetTextSafe( playerPanel, "PlayerGoldAmount", goldValue );


    var RatingsContainer = playerPanel.FindChildInLayoutFile( "RatingsContainer" );
	if ( RatingsContainer )
	{
		 var player_data = CustomNetTables.GetTableValue("mmr_player", String(playerId));
		 var player_data_main = CustomNetTables.GetTableValue("players_server_info", `player_${playerId}`)

		 if ( player_data && player_data_main)
		 {
		 	let change_rate = player_data.new_rating - player_data.original_rating
		 	if ( change_rate > -1 )
		 	{
				if(change_rate > 0){
					playerPanel.AddClass("RatingPlus")
				}
		 		change_rate = "+ " + change_rate
		 	}else{
				playerPanel.AddClass("RatingMinus")
			}
		    _ScoreboardUpdater_SetTextSafe(playerPanel, "PlayerRating", player_data.original_rating)
			_ScoreboardUpdater_SetTextSafe(playerPanel, "PlayerRatingBonus", String(change_rate))
		}
    }

    var Coins = playerPanel.FindChildInLayoutFile( "Coins" );
	if ( Coins )
	{
		var coins_table = CustomNetTables.GetTableValue("coins_table", String(playerId));
	 	if ( coins_table )
	 	{
			let CoinsNum = coins_table.coins_bonus || 0
			if(CoinsNum > 0){
				playerPanel.AddClass("CoinsPlus")
			}
	 		Coins.FindChildTraverse("Coins_Number").text = "+ " + CoinsNum
		}
    }

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
	// team_name уже приходит с ведущим '#' (#DOTA_GoodGuys) — нормализуем, чтобы не
	// получить '##DOTA_*' (двойной #) и не сыпать CLocalize-ошибки в консоль каждый апдейт.
	var _teamNameToken = teamDetails.team_name || "";
	if ( _teamNameToken.substring( 0, 1 ) !== "#" ) { _teamNameToken = "#" + _teamNameToken; }
	_ScoreboardUpdater_SetTextSafe( teamPanel, "TeamName", $.Localize( _teamNameToken ) )
	
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

		var teamColor_Left = teamPanel.FindChildInLayoutFile( "teamColor_Left" );
		if ( teamColor_Left )
		{
			teamColor_Left.style.backgroundColor = teamColor;
			teamColor_Left.style.boxShadow = `0px 0px 10px 1px ${withAlpha(teamColor, 0.2)}`;
		}
	}

	if (teamId == 12)
	{
		teamPanel.visible = false
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
	var teamsList = [];
	for ( var teamId of Game.GetAllTeamIDs() )
	{   
		var  team =  Game.GetTeamDetails( teamId )
        var teamPlayers = Game.GetPlayerIDsOnTeam( teamId )
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
		team.total_gold = total_gold;

        var rankData = CustomNetTables.GetTableValue( "team_rank", teamId )
        if (rankData!=undefined && rankData.rank!=undefined) {
            team.rank = rankData.rank
        } else {
        	team.rank = 0
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

function HasModifier(unit, modifier) {
    for (var i = 0; i < Entities.GetNumBuffs(unit); i++) {
        if (Buffs.GetName(unit, Entities.GetBuff(unit, i)) == modifier){
            return Entities.GetBuff(unit, i)
        }
    }
	return false
}

function ChangeBorderPlayer(panel, frame_id, player_id)
{	
	var playerPortrait = panel.FindChildInLayoutFile( "TopHero" );
	if (playerPortrait)
	{
		var HeroPortrait = playerPortrait.FindChildTraverse('HeroIcon');
		if (HeroPortrait.FindChildTraverse("RevengeTargetFrame"))
		{
			HeroPortrait.FindChildTraverse("RevengeTargetFrame").DeleteAsync(0)
		}
		if (frame_id == 1)
		{
			if ( GameUI.CustomUIConfig().team_colors )
			{
				var teamColor = GameUI.CustomUIConfig().team_colors[ Players.GetTeam( Number(player_id) ) ];
				if ( teamColor )
				{
					$.CreatePanel("DOTAParticleScenePanel", HeroPortrait, "RevengeTargetFrame", { style: "width:100%;height:100%;"+ "wash-color:"+teamColor, particleName: "particles/donate/gold_icon_white", particleonly:"true", startActive:"true", cameraOrigin:"0 0 165", lookAt:"0 0 0",  fov:"55", squarePixels:"true" });
				}
			}
		}
		else if (frame_id == 2)
		{
			$.CreatePanel("DOTAParticleScenePanel", HeroPortrait, "RevengeTargetFrame", { style: "width:100%;height:100%;", particleName: "particles/donate/gold_icon_bp_rainbow.vpcf", particleonly:"true", startActive:"true", cameraOrigin:"0 0 165", lookAt:"0 0 0",  fov:"55", squarePixels:"true" });
		}
		else if (frame_id == 3)
		{
			$.CreatePanel("DOTAParticleScenePanel", HeroPortrait, "RevengeTargetFrame", { style: "width:100%;height:100%;", particleName: "particles/donate/gold_icon_bp_3.vpcf", particleonly:"true", startActive:"true", cameraOrigin:"0 0 165", lookAt:"0 0 0",  fov:"55", squarePixels:"true" });
		}
        else if (frame_id == 4)
        {
            $.CreatePanel("DOTAParticleScenePanel", HeroPortrait, "RevengeTargetFrame", { style: "width:100%;height:100%;", particleName: "particles/borders/border_effect_4.vpcf", particleonly:"true", startActive:"true", cameraOrigin:"0 0 165", lookAt:"0 0 0",  fov:"37", squarePixels:"true" });
        }
        else if (frame_id == 5)
        {
            $.CreatePanel("DOTAParticleScenePanel", HeroPortrait, "RevengeTargetFrame", { style: "width:100%;height:100%;", particleName: "particles/borders/border_effect_5.vpcf", particleonly:"true", startActive:"true", cameraOrigin:"0 0 165", lookAt:"0 0 0",  fov:"35", squarePixels:"true" });
        }
        else if (frame_id == 6)
        {
            $.CreatePanel("DOTAParticleScenePanel", HeroPortrait, "RevengeTargetFrame", { style: "width:100%;height:100%;", particleName: "particles/borders/electric_border.vpcf", particleonly:"true", startActive:"true", cameraOrigin:"0 0 165", lookAt:"0 0 0",  fov:"45", squarePixels:"true" });
        }
	}
	var playerPortraitFlyout = panel.FindChildInLayoutFile( "Hero" );
	if (playerPortraitFlyout)
	{
		if (playerPortraitFlyout.FindChildTraverse("RevengeTargetFrame"))
		{
			playerPortraitFlyout.FindChildTraverse("RevengeTargetFrame").DeleteAsync(0)
		}
		if (frame_id == 1)
		{
			if ( GameUI.CustomUIConfig().team_colors )
			{
				var teamColor = GameUI.CustomUIConfig().team_colors[ Players.GetTeam( Number(player_id) ) ];
				if ( teamColor )
				{
					$.CreatePanel("DOTAParticleScenePanel", playerPortraitFlyout, "RevengeTargetFrame", { style: "width:100%;height:100%;" + "wash-color:"+teamColor, particleName: "particles/donate/gold_icon_white", particleonly:"true", startActive:"true", cameraOrigin:"0 0 165", lookAt:"0 0 0",  fov:"55", squarePixels:"true" });
				}
			}
		}
		else if (frame_id == 2)
		{
			$.CreatePanel("DOTAParticleScenePanel", playerPortraitFlyout, "RevengeTargetFrame", { style: "width:100%;height:100%;", particleName: "particles/donate/gold_icon_bp_rainbow.vpcf", particleonly:"true", startActive:"true", cameraOrigin:"0 0 165", lookAt:"0 0 0",  fov:"55", squarePixels:"true" });
		}
		else if (frame_id == 3)
		{
			$.CreatePanel("DOTAParticleScenePanel", playerPortraitFlyout, "RevengeTargetFrame", { style: "width:100%;height:100%;", particleName: "particles/donate/gold_icon_bp_3.vpcf", particleonly:"true", startActive:"true", cameraOrigin:"0 0 165", lookAt:"0 0 0",  fov:"55", squarePixels:"true" });
		}
        else if (frame_id == 4)
        {
            $.CreatePanel("DOTAParticleScenePanel", playerPortraitFlyout, "RevengeTargetFrame", { style: "width:100%;height:100%;", particleName: "particles/borders/border_effect_4.vpcf", particleonly:"true", startActive:"true", cameraOrigin:"0 0 165", lookAt:"0 0 0",  fov:"37", squarePixels:"true" });
        }
        else if (frame_id == 5)
        {
            $.CreatePanel("DOTAParticleScenePanel", playerPortraitFlyout, "RevengeTargetFrame", { style: "width:100%;height:100%;", particleName: "particles/borders/border_effect_5.vpcf", particleonly:"true", startActive:"true", cameraOrigin:"0 0 165", lookAt:"0 0 0",  fov:"35", squarePixels:"true" });
        }
        else if (frame_id == 6)
        {
            $.CreatePanel("DOTAParticleScenePanel", playerPortraitFlyout, "RevengeTargetFrame", { style: "width:100%;height:100%;", particleName: "particles/borders/electric_border.vpcf", particleonly:"true", startActive:"true", cameraOrigin:"0 0 165", lookAt:"0 0 0",  fov:"45", squarePixels:"true" });
        }
	}
}

function ChangeNickNamePlayer(panel, frame_id, player_id)
{
	var PlayerName = panel.FindChildInLayoutFile( "PlayerName" );
	if (PlayerName)
	{
		PlayerName.SetHasClass("rainbow_nickname_animate", false)
		PlayerName.SetHasClass("rainbow_nickname", false)
		PlayerName.style.color = "white"

		if (frame_id == 1)
		{
			if ( GameUI.CustomUIConfig().team_colors )
			{
				var teamColor = GameUI.CustomUIConfig().team_colors[ Players.GetTeam( Number(player_id) ) ];
				if ( teamColor )
				{
					PlayerName.style.color = teamColor
				}
			}
		}
		else if (frame_id == 2)
		{
			PlayerName.SetHasClass("rainbow_nickname", true)
			PlayerName.style.color = "gradient( linear, 100% 0%, 0% 0%, from( rgb(0, 183, 255)), color-stop( 0.5, rgb(0, 255, 85)), to( rgb(255, 196, 0)))"
		}
		else if (frame_id == 3)
		{
			PlayerName.SetHasClass("rainbow_nickname_animate", true)
		}
	}
}

function SetPlayerCreeps(panel, id)
{
    panel.SetPanelEvent('onmouseover', function() {
        if (GameUI.CustomUIConfig().HeroFindCreeps != null)
        {
            GameUI.CustomUIConfig().HeroFindCreeps(id)
        }
    });
    panel.SetPanelEvent('onmouseout', function() 
    {
        if (GameUI.CustomUIConfig().HeroFindCreepsClose != null)
        {
            GameUI.CustomUIConfig().HeroFindCreepsClose()
        }
    });       
}

function Updater(){
	var bAltPressed = IsDotaAltPressed();
	$.GetContextPanel().SetHasClass( "AltPressed", bAltPressed == true );

	$.Schedule(0, Updater)
}

Updater()