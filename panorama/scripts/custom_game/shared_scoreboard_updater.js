--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";

CustomNetTables.SubscribeNetTableListener( "networth_players", update_networth_players );
var game_ended = false
var early_game_timer = 17*60
var game_started = false
var players_data = {}
let qwe = {}


for (var i = 0; i <= 9; ++i) 
{
  players_data[String(i)] = CustomNetTables.GetTableValue("networth_players", String(i));
}

function update_networth_players(table, key, data)
{
	if (table != "networth_players") return
	if (key == "")
	{
		if (data && data.game_ended)
		{
			game_ended = true
		}
		return
	}
	if (key == -1 || key == "-1" || key == "") return
	players_data[key] = data
}

function _ScoreboardUpdater_SetTextSafe(panel, childName, textValue) {
	if (panel === null || panel == undefined)
		return;

	var childPanel = panel.FindChildInLayoutFile(childName)
	if (childPanel === null || childPanel == undefined)
		return;

	childPanel.text = textValue;
}

function HasHeroModifier(id, mod) 
{
	var hero = Players.GetPlayerHeroEntityIndex(id)
	for (var i = 0; i < Entities.GetNumBuffs(hero); i++) {
		var buffID = Entities.GetBuff(hero, i)
		if (Buffs.GetName(hero, buffID) == mod) {
			return true
		}
	}
	return false
}

function init()
{
	GameEvents.Subscribe('EndScreen_game_end', EndScreen_game_end)
}

function _ScoreboardUpdater_UpdatePlayerPanel(scoreboardConfig, playersContainer, playerId, localPlayerTeamId, teamPanel) 
{
	var playerInfo = Game.GetPlayerInfo(playerId);
	if (game_started == false)
	{
		var progress = CustomNetTables.GetTableValue("custom_pick", "pick_state");
		if (progress && progress.in_progress == true) 
		{
			return
		}
		game_started = true
	}

	var playerPanelName = "_dynamic_player_" + playerId;
	var playerPanel = playersContainer.FindChild(playerPanelName);
	if (playerPanel === null) 
	{
		playerPanel = $.CreatePanel("Panel", playersContainer, playerPanelName);
		playerPanel.SetAttributeInt("player_id", playerId);
		playerPanel.BLoadLayout(scoreboardConfig.playerXmlName, false, false);
	}

	playerPanel.SetHasClass("is_local_player", (playerId == Game.GetLocalPlayerID()));

	var isTeammate = false;
	var networth_table_current = players_data[String(playerId)]
	var Player_Level = playerPanel.FindChildInLayoutFile("LevelIndicator");
	var Player_no_Buyback = playerPanel.FindChildTraverse("BuybackIndicator");

	if (networth_table_current && Player_Level)
	{
		if (networth_table_current.hero_tier !== -1 && networth_table_current.hide_tier == 0)
		{
			Player_Level.style.backgroundImage = 'url("file://{images}/custom_game/hero_level_' + String(networth_table_current.hero_tier) + '.png")';
			Player_Level.style.backgroundSize = "contain";
			Player_Level.style.visibility = "visible";
		}	
		else 
		{
			Player_Level.style.visibility = "collapse";
		}
	}

	if (networth_table_current && typeof networth_table_current.no_buyback !== 'undefined' && Player_no_Buyback)
  {
		Player_no_Buyback.visible = networth_table_current.no_buyback == 1
  }

  if (networth_table_current) 
  {
  	_ScoreboardUpdater_SetTextSafe(playerPanel, "TeamScore", networth_table_current.net)
  }

	if (playerInfo) 
	{
		isTeammate = (playerInfo.player_team_id == localPlayerTeamId);
		var calibration_games = 0
		if (calibration_games > 0)
		{
			_ScoreboardUpdater_SetTextSafe(playerPanel, "PlayerMmr", $.Localize("#calibration_short") + ' (' + String(calibration_games) + ')');
			var panel = playerPanel.FindChildTraverse("PlayerMmr")
			if (panel)
			{
				panel.style.fontSize = "15px";
			}
		}
		else 
		{
			if (networth_table_current && qwe[playerId] == undefined && game_ended == true) 
			{
				const func = function()
				{
					networth_table_current = players_data[String(playerId)]
					_ScoreboardUpdater_SetTextSafe(playerPanel, "PlayerMmr", (networth_table_current.rating_before || 0));
					if (networth_table_current.rating_change < 0) 
          {
						_ScoreboardUpdater_SetTextSafe(playerPanel, "MmrPlus", "- " + (networth_table_current.rating_change * -1));
						if (playerPanel.FindChildTraverse("MmrPlus"))
						{
							playerPanel.FindChildTraverse("MmrPlus").text = "- " + (networth_table_current.rating_change * -1);
							playerPanel.FindChildInLayoutFile("MmrPlus").style.color = "gradient( linear, 90% 80%, 30% 20%, from( white ), to( red ) )"
						}
					}else 
          {
						_ScoreboardUpdater_SetTextSafe(playerPanel, "MmrPlus", "+ " + networth_table_current.rating_change);
						if (playerPanel.FindChildTraverse("MmrPlus"))
						{	
							playerPanel.FindChildTraverse("MmrPlus").text = "+ " + networth_table_current.rating_change;
						}
					}
					qwe[playerId] = $.Schedule(0.5, func)
				}
				qwe[playerId] = $.Schedule(0.5, func)
			}
		}
		playerPanel.SetHasClass("player_dead", (playerInfo.player_respawn_seconds >= 0));
		playerPanel.SetHasClass("local_player_teammate", isTeammate && (playerId != Game.GetLocalPlayerID()));
		playerPanel.SetPanelEvent('onactivate', function() 
    {
			Players.PlayerPortraitClicked(playerPanel.GetAttributeInt("player_id", -1), false, false)
			Game.Upgrades(playerInfo.player_selected_hero)
		});

		_ScoreboardUpdater_SetTextSafe(playerPanel, "RespawnTimer", (playerInfo.player_respawn_seconds + 1)); // value is rounded down so just add one for rounded-up
		_ScoreboardUpdater_SetTextSafe(playerPanel, "PlayerName", playerInfo.player_name);
		_ScoreboardUpdater_SetTextSafe(playerPanel, "Level", playerInfo.player_level);
		_ScoreboardUpdater_SetTextSafe(playerPanel, "Kills", playerInfo.player_kills);
		_ScoreboardUpdater_SetTextSafe(playerPanel, "Deaths", playerInfo.player_deaths);
		_ScoreboardUpdater_SetTextSafe(playerPanel, "Assists", playerInfo.player_assists);

		var playerPortrait = playerPanel.FindChildInLayoutFile("HeroIcon");

		if (playerPortrait) 
		{
			if (playerInfo.player_selected_hero !== "") 
			{
				playerPortrait.SetImage("file://{images}/heroes/" + Game.GetHeroImage(String(playerId), playerInfo.player_selected_hero) + ".png");
			}else 
			{
				playerPortrait.SetImage("file://{images}/custom_game/unassigned.png");
			}
		}

		if (playerInfo.player_selected_hero_id == -1) 
    {
			_ScoreboardUpdater_SetTextSafe(playerPanel, "HeroName", $.Localize("#DOTA_Scoreboard_Picking_Hero"))
		}else 
    {
			_ScoreboardUpdater_SetTextSafe(playerPanel, "HeroName", $.Localize("#" + playerInfo.player_selected_hero))
		}

		var heroNameAndDescription = playerPanel.FindChildInLayoutFile("HeroNameAndDescription");
		if (heroNameAndDescription) 
    {
			if (playerInfo.player_selected_hero_id == -1) 
      {
				heroNameAndDescription.SetDialogVariable("hero_name", $.Localize("#DOTA_Scoreboard_Picking_Hero"));
			}else 
      {
				heroNameAndDescription.SetDialogVariable("hero_name", $.Localize("#" + playerInfo.player_selected_hero));
			}
			heroNameAndDescription.SetDialogVariableInt("hero_level", playerInfo.player_level);
		}

		playerPanel.SetHasClass("player_connection_abandoned", playerInfo.player_connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_ABANDONED);
		playerPanel.SetHasClass("player_connection_failed", playerInfo.player_connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_FAILED);
		playerPanel.SetHasClass("player_connection_disconnected", playerInfo.player_connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_DISCONNECTED);

		var playerAvatar = playerPanel.FindChildInLayoutFile("AvatarImage");
		if (playerAvatar) 
    {
			playerAvatar.steamid = playerInfo.player_steamid;
		}


		var playerColorBar = playerPanel.FindChildInLayoutFile("PlayerColorBar");
		if (playerColorBar !== null) 
    {
			if (GameUI.CustomUIConfig().team_colors) 
      {
				var teamColor = GameUI.CustomUIConfig().team_colors[playerInfo.player_team_id];
				if (teamColor) 
        {
					playerColorBar.style.backgroundColor = teamColor;
				}
			}else
      {
				var playerColor = "#000000";
				playerColorBar.style.backgroundColor = playerColor;
			}
		}
	}
	var IdButton = playerPanel.FindChildInLayoutFile("TalentButton");
	if (IdButton) 
	{
		playerPanel.SetPanelEvent('onactivate', function(){});
		SetShowTalent(IdButton, playerInfo.player_selected_hero)
	}

	var playerItemsContainer = playerPanel.FindChildInLayoutFile("PlayerItemsContainer");

	if (playerItemsContainer && networth_table_current && networth_table_current.items) 
	{
		for (var i = 0; i <= Object.keys(networth_table_current.items).length; ++i) 
		{
			var itemPanelName = "_dynamic_item_" + i;
			var itemPanel = playerItemsContainer.FindChild(itemPanelName);
			if (itemPanel === null)
			{
				itemPanel = $.CreatePanel("DOTAItemImage", playerItemsContainer, itemPanelName)
				itemPanel.AddClass("PlayerItem");
				itemPanel.itemname = networth_table_current.items[i]
			}
		}
	}


	var goldValue = networth_table_current ? networth_table_current.net : -1;
	if (isTeammate) 
	{
		_ScoreboardUpdater_SetTextSafe(playerPanel, "TeammateGoldAmount", goldValue);
	}

	_ScoreboardUpdater_SetTextSafe(playerPanel, "PlayerGoldAmount", goldValue);

	// TIP BUTTON
	var tableData = players_data[Game.GetLocalPlayerID().toString()]
	var tipContainer = playerPanel.FindChildTraverse("PlayerTipContainer");
	if (IsSpectator())
	{
		tipContainer.style.opacity = "0";
	}

	if (tableData && tipContainer)  
	{
		tipContainer.style.opacity = GameUI.IsAltDown() ? "1" : "0";
		if ((Game.GetDOTATime(false, false) > early_game_timer) && tipContainer.BHasClass("PlayerTipContainer_low"))
		{
			tipContainer.RemoveClass("PlayerTipContainer_low")
			tipContainer.AddClass("PlayerTipContainer_high")
		}
		if (tableData)
		{
			let text = $.Localize("#tip_info_unsub")
			if (tableData.subscribed == 1)
			{
				text = $.Localize("#tip_info_sub")
				if (tableData.tips_cooldown && tableData.tips_cooldown > 0)
				{
					text = $.Localize("#tip_cd") + String(tableData.tips_cooldown)
				}
			}
			let tipButton = playerPanel.FindChildTraverse("PlayerTipButton");
			if (tipButton)
			{
				tipButton.SetPanelEvent('onmouseover', function() 
				{
					$.DispatchEvent('DOTAShowTextTooltip', tipButton, text) 
				});
				tipButton.SetPanelEvent('onmouseout', function() 
				{
					$.DispatchEvent('DOTAHideTextTooltip', tipButton);
				});
			}
		}
	}
	
    // New
	var panel_damage = playerPanel.FindChildInLayoutFile("BlackScreen")
	var text_damage = playerPanel.FindChildInLayoutFile("PurpleScore")
	var BlackScreen = playerPanel.FindChildInLayoutFile("BlackScreen")
	var LocalTeam = teamPanel.FindChildTraverse("LocalTeamOverlay")
	var PurpleIndicator = playerPanel.FindChildInLayoutFile("PurpleIndicator")
	let damage_bonus = 0
	if (networth_table_current && networth_table_current.damage_bonus)
	{
		damage_bonus = networth_table_current.damage_bonus
	}
	if ((Game.GetDOTATime(false, false) <= early_game_timer) && (text_damage) ) 
	{
		text_damage.style.visibility = "visible"
		text_damage.RemoveClass("RedText")
		text_damage.RemoveClass("GreenText")
		var text = ''
		let max_damage = 45
		if (PurpleIndicator)
		{
			if (damage_bonus == max_damage)
			{
				PurpleIndicator.style.visibility = "visible";
			}
			else 
			{
				PurpleIndicator.style.visibility = "collapse";
			}
		}
		if (playerId == Game.GetLocalPlayerID() || damage_bonus == 0 || isTeammate) 
		{
			text_damage.AddClass("GreenText")
			panel_damage.style.backgroundImage = 'url("file://{images}/custom_game/PanelGreen.png")';
			if (damage_bonus != 0)
			{
				text = $.Localize("#Incoming_damage") + Math.abs(damage_bonus) + '% ' + $.Localize("#Incoming_damage2") + Math.abs(damage_bonus) + '%'
				if (damage_bonus == max_damage)
				{
					text = text + $.Localize("#Incoming_damage3")
				}
				text = text + $.Localize("#Incoming_damage4")
				playerPanel.SetPanelEvent('onmouseover', function() {
					$.DispatchEvent('DOTAShowTextTooltip', playerPanel, text)
				});
				playerPanel.SetPanelEvent('onmouseout', function() {
					$.DispatchEvent('DOTAHideTextTooltip', playerPanel);
				});
			}
			else 
			{
				playerPanel.SetPanelEvent('onmouseover', function() {});
				playerPanel.SetPanelEvent('onmouseout', function() {});
			}
		}
		else 
		{
			damage_bonus = damage_bonus*-1
			text_damage.AddClass("RedText")
			panel_damage.style.backgroundImage = 'url("file://{images}/custom_game/PanelRed.png")';
			text = $.Localize("#Outgoing_damage") + Math.abs(damage_bonus) + '% ' + $.Localize("#Outgoing_damage2") + Math.abs(damage_bonus) + '%'
			if (damage_bonus == max_damage*-1)
			{
				text = text + $.Localize("#Outgoing_damage3")
			}
			text = text + $.Localize("#Outgoing_damage4")
			playerPanel.SetPanelEvent('onmouseover', function() {
				$.DispatchEvent('DOTAShowTextTooltip', playerPanel, text)
			});
			playerPanel.SetPanelEvent('onmouseout', function() {
				$.DispatchEvent('DOTAHideTextTooltip', playerPanel);
			});
		}
		_ScoreboardUpdater_SetTextSafe(playerPanel, "PurpleScore", damage_bonus + '%')
		text_damage.html = true
	} 
	else 
	{
		if (LocalTeam) 
		{
			if (PurpleIndicator)
			{
				PurpleIndicator.style.visibility = "collapse";
			}
			LocalTeam.style.height = "67px"
			if (BlackScreen)
			{
				BlackScreen.style.height = "25px"
			}
			if (text_damage)
			{
				text_damage.style.visibility = "collapse"
			}
			if (panel_damage)
			{
				panel_damage.style.backgroundImage = 'url("file://{images}/custom_game/Layer25.png")';
			}
			playerPanel.SetPanelEvent('onmouseover', function() {});
			playerPanel.SetPanelEvent('onmouseout', function() {});
		}
	}
}

function IsSpectator() {
	const localPlayer = Players.GetLocalPlayer()
	if (Players.IsSpectator(localPlayer))
		return true
	const localTeam = Players.GetTeam(localPlayer)
	return localTeam !== 2 &&
		localTeam !== 3 &&
		localTeam !== 6 &&
		localTeam !== 7 &&
		localTeam !== 12 &&
		localTeam !== 9
}

//=============================================================================
//=============================================================================
function _ScoreboardUpdater_UpdateTeamPanel(scoreboardConfig, containerPanel, teamDetails, teamsInfo) {
	if (!containerPanel)
		return;

	var teamId = teamDetails.team_id;
	var teamPlayers = Game.GetPlayerIDsOnTeam(teamId)
	var teamPanelName = "_dynamic_team_" + teamId;
	var teamPanel = containerPanel.FindChild(teamPanelName);
	if (teamPanel === null) 
	{
		teamPanel = $.CreatePanel("Panel", containerPanel, teamPanelName);
		teamPanel.SetAttributeInt("team_id", teamId);
		teamPanel.BLoadLayout(scoreboardConfig.teamXmlName, false, false);
	}
	var localPlayerTeamId = -1;
	var localPlayer = Game.GetLocalPlayerInfo();
	if (localPlayer) 
	{
		localPlayerTeamId = localPlayer.player_team_id;
	}
	teamPanel.SetHasClass("local_player_team", localPlayerTeamId == teamId);
	teamPanel.SetHasClass("not_local_player_team", localPlayerTeamId != teamId);
	var teamPlayers = Game.GetPlayerIDsOnTeam(teamId)
	var playersContainer = teamPanel.FindChildInLayoutFile("PlayersContainer");
	let razor_counter = -1
  let networth_team = 0
  let player_count = 0


	if (playersContainer) 
	{
		for (var playerId of teamPlayers) 
		{
			player_count = player_count + 1

			var table = players_data[String(playerId)]
			if (table) 
			{
				teamPanel.SetHasClass("has_streak", table.streak == 1);
				if (table.razor_count != undefined)
				{
					let count = table.razor_count
					if (razor_counter == -1)
					{
						razor_counter = Number(count)
					}
					else
					{
						razor_counter = razor_counter + Number(count)
					}
				}
        networth_team = networth_team + table.net
			}
			_ScoreboardUpdater_UpdatePlayerPanel(scoreboardConfig, playersContainer, playerId, localPlayerTeamId, teamPanel)
		}
	}
    
	teamPanel.SetHasClass("IsAltDown", GameUI.IsAltDown())

	let teamGoldPanel = teamPanel.FindChildTraverse("TeamNetworthSummary")
	if (teamGoldPanel)
		teamGoldPanel.SetHasClass("TeamNetworthSummary_hidden", GameUI.IsAltDown() || player_count <= 1)

  let GoldTeamNetworth = teamPanel.FindChildInLayoutFile("GoldTeamNetworth");
  if (GoldTeamNetworth)
  {
    GoldTeamNetworth.text = networth_team
  }

	let RazorIcon = teamPanel.FindChildInLayoutFile("RazorCount");
	let RazorCount = teamPanel.FindChildInLayoutFile("RazorCountLabel");
	if (RazorCount && RazorIcon)
	{
		RazorCount.text = razor_counter > 0 ? razor_counter.toString() : ""
		RazorIcon.SetHasClass("RazorCount_hidden", razor_counter == -1)
		RazorIcon.SetHasClass("RazorCount_zero", razor_counter <= 0)
	}

	teamPanel.SetHasClass("no_players", (teamPlayers.length == 0))
	teamPanel.SetHasClass("one_player", (teamPlayers.length == 1))
	if (teamsInfo.max_team_players < teamPlayers.length) 
	{
		teamsInfo.max_team_players = teamPlayers.length;
	}
	if (GameUI.CustomUIConfig().team_colors) 
	{
		var teamColor = GameUI.CustomUIConfig().team_colors[teamId];
		var teamColorPanel = teamPanel.FindChildInLayoutFile("TeamColor");
		teamColor = teamColor.replace(";", "");
		if (teamColorPanel) 
		{
			teamNamePanel.style.backgroundColor = teamColor + ";";
		}
		var teamColor_GradentFromTransparentLeft = teamPanel.FindChildInLayoutFile("TeamColor_GradentFromTransparentLeft");
		if (teamColor_GradentFromTransparentLeft) 
		{
			var gradientText = 'gradient( linear, 0% 0%, 800% 0%, from( #00000000 ), to( ' + teamColor + ' ) );';
			teamColor_GradentFromTransparentLeft.style.backgroundColor = gradientText;
		}
	}
	return teamPanel;
}

//=============================================================================
//=============================================================================
function _ScoreboardUpdater_ReorderTeam(scoreboardConfig, teamsParent, teamPanel, teamId, newPlace, prevPanel) {
	//	$.Msg( "UPDATE: ", GameUI.CustomUIConfig().teamsPrevPlace );
	var oldPlace = null;
	if (GameUI.CustomUIConfig().teamsPrevPlace.length > teamId) {
		oldPlace = GameUI.CustomUIConfig().teamsPrevPlace[teamId];
	}
	GameUI.CustomUIConfig().teamsPrevPlace[teamId] = newPlace;

	if (newPlace != oldPlace) {
		//		$.Msg( "Team ", teamId, " : ", oldPlace, " --> ", newPlace );
		teamPanel.RemoveClass("team_getting_worse");
		teamPanel.RemoveClass("team_getting_better");
		if (newPlace > oldPlace) {
			teamPanel.AddClass("team_getting_worse");
		} else if (newPlace < oldPlace) {
			teamPanel.AddClass("team_getting_better");
		}
	}

	teamsParent.MoveChildAfter(teamPanel, prevPanel);
}

function compareFunc(a, b) 
{
    const teamPlayers_a = Game.GetPlayerIDsOnTeam(a.team_id), teamPlayers_b = Game.GetPlayerIDsOnTeam(b.team_id)
	if (teamPlayers_a.length === 0 && teamPlayers_b.length === 0)
        return 0
	if (teamPlayers_a.length !== 0 && teamPlayers_b.length === 0)
        return -1 // [ A, B ]
	if (teamPlayers_a.length === 0 && teamPlayers_b.length !== 0)
        return 1 // [ B, A ]

    var table, table2
    var place1 = -1, place2 = -1, gold1 = 1, gold2 = 1

    for (var playerId of teamPlayers_a)
    {
        table = players_data[String(playerId)] || table
        if (table) 
        {
            place1 = table.place
            gold1 = gold1 + table.net
        }
    }

    for (var playerId of teamPlayers_b)
    {
        table2 = players_data[String(playerId)] || table2
        if (table2) 
        {
            place2 = table2.place
            gold2 = gold2 + table2.net
        }
    }

    if (place1 < 0 && place2 < 0) {
        place1 = -gold1
        place2 = -gold2
    } else {
        if (place1 < 0 && place2 >= 0)
            return -1 // [ A, B ] place <0 first
        if (place1 >= 0 && place2 < 0)
            return 1 // [ B, A ] place <0 first
    }
    if (place1 < place2)
        return -1 // [ A, B ]
    if (place1 > place2)
        return 1 // [ B, A ]
    return 0
}

function stableCompareFunc(a, b) {

	var unstableCompare = compareFunc(a, b);
	if (unstableCompare != 0) {
		return unstableCompare;
	}

	if (GameUI.CustomUIConfig().teamsPrevPlace.length <= a.team_id) {
		return 0;
	}

	if (GameUI.CustomUIConfig().teamsPrevPlace.length <= b.team_id) {
		return 0;
	}

	//			$.Msg( GameUI.CustomUIConfig().teamsPrevPlace );

	var a_prev = GameUI.CustomUIConfig().teamsPrevPlace[a.team_id];
	var b_prev = GameUI.CustomUIConfig().teamsPrevPlace[b.team_id];
	if (a_prev < b_prev) // [ A, B ]
	{
		return -1; // [ A, B ]
	} else if (a_prev > b_prev) // [ B, A ]
	{
		return 1; // [ B, A ]
	} else {
		return 0;
	}
};

//=============================================================================
//=============================================================================
function _ScoreboardUpdater_UpdateAllTeamsAndPlayers(scoreboardConfig, teamsContainer) {
	//	$.Msg( "_ScoreboardUpdater_UpdateAllTeamsAndPlayers: ", scoreboardConfig );

	var teamsList = [];
	for (var teamId of Game.GetAllTeamIDs()) {
		teamsList.push(Game.GetTeamDetails(teamId));
	}

	// update/create team panels
	var teamsInfo = {
		max_team_players: 0
	};
	var panelsByTeam = [];
	for (var i = 0; i < teamsList.length; ++i) {


		var teamId = teamsList[i].team_id;

		var teamPlayers = Game.GetPlayerIDsOnTeam(teamId)

		var n = 0

		for (var playerId of teamPlayers) {
			var playerInfo = Game.GetPlayerInfo(playerId);
			if ((playerInfo) && (playerInfo.player_selected_hero != "npc_dota_hero_wisp")) {
				n = n + 1
			}
		}
		if (n > 0) {

			var teamPanel = _ScoreboardUpdater_UpdateTeamPanel(scoreboardConfig, teamsContainer, teamsList[i], teamsInfo);
			if (teamPanel) {
				panelsByTeam[teamsList[i].team_id] = teamPanel;
			}
		}
	}

	if (teamsList.length > 1) {
		//		$.Msg( "panelsByTeam: ", panelsByTeam );

		// sort
		if (scoreboardConfig.shouldSort) {
			teamsList.sort(stableCompareFunc);
		}

		//		$.Msg( "POST: ", teamsAndPanels );

		// reorder the panels based on the sort
		var prevPanel = panelsByTeam[teamsList[0].team_id];
		for (var i = 0; i < teamsList.length; ++i) {

			var teamId = teamsList[i].team_id;
			var teamPanel = panelsByTeam[teamId];
			if (teamPanel && prevPanel)
				_ScoreboardUpdater_ReorderTeam(scoreboardConfig, teamsContainer, teamPanel, teamId, i, prevPanel);
			prevPanel = teamPanel;
		}
		//		$.Msg( GameUI.CustomUIConfig().teamsPrevPlace );
	}

	//	$.Msg( "END _ScoreboardUpdater_UpdateAllTeamsAndPlayers: ", scoreboardConfig );
}


//=============================================================================
//=============================================================================
function ScoreboardUpdater_InitializeScoreboard(scoreboardConfig, scoreboardPanel) {
	GameUI.CustomUIConfig().teamsPrevPlace = [];
	if (typeof(scoreboardConfig.shouldSort) === 'undefined') {
		// default to true
		scoreboardConfig.shouldSort = true;
	}
	_ScoreboardUpdater_UpdateAllTeamsAndPlayers(scoreboardConfig, scoreboardPanel);
	return {
		"scoreboardConfig": scoreboardConfig,
		"scoreboardPanel": scoreboardPanel
	}
}


//=============================================================================
//=============================================================================
function ScoreboardUpdater_SetScoreboardActive(scoreboardHandle, isActive) {
	if (scoreboardHandle.scoreboardConfig === null || scoreboardHandle.scoreboardPanel === null) {
		return;
	}

	if (isActive) {
		_ScoreboardUpdater_UpdateAllTeamsAndPlayers(scoreboardHandle.scoreboardConfig, scoreboardHandle.scoreboardPanel);
	}
}

//=============================================================================
//=============================================================================
function ScoreboardUpdater_GetTeamPanel(scoreboardHandle, teamId) {
	if (scoreboardHandle.scoreboardPanel === null) {
		return;
	}

	var teamPanelName = "_dynamic_team_" + teamId;
	return scoreboardHandle.scoreboardPanel.FindChild(teamPanelName);
}

//=============================================================================
//=============================================================================
function ScoreboardUpdater_GetSortedTeamInfoList(scoreboardHandle) {
	var teamsList = [];
	for (var teamId of Game.GetAllTeamIDs()) {
		teamsList.push(Game.GetTeamDetails(teamId));
	}

	if (teamsList.length > 1) {
		teamsList.sort(stableCompareFunc);
	}

	return teamsList;
}

function EndScreen_game_end(kv)
{
	var parent = $.GetContextPanel().FindChildTraverse("EndScreen_Points")
	if (!parent) return
	parent.RemoveClass("EndScreen_Points_collapse")

	let end_panel = parent.FindChildTraverse("end_panel")

	if (!end_panel)
	{
	  end_panel = $.CreatePanel("Panel", parent, "end_panel")
	  end_panel.BLoadLayout( "file://{resources}/layout/custom_game/end_screen_points/end_screen_points.xml", false, false );
	}

  Game.ShowEndWindow(kv, true)
}

function SetShowTalent(panel, hero)
{
	panel.SetPanelEvent('onactivate', function() 
	{
		let button = $.GetContextPanel().FindChildTraverse("EndHeroesData_HeaderTalentsButton")
		if (button)
			button.AddClass("EndScreen_Points_collapse")
		
		var EndScreenTalents = $.GetContextPanel().FindChildTraverse("EndScreenTalents")
		if (EndScreenTalents)
		{
			EndScreenTalents.RemoveClass("EndScreen_Points_collapse")
			EndScreenTalents.AddClass("EndScreenTalents_show")
		}
		let LayerGeneral = CreateTalentPanel()
		let LayerGeneralEnd = $.GetContextPanel().FindChildTraverse("LayerGeneralEnd");

    let use_new_system = false
    if (Game.new_talent_system[hero])
        use_new_system = true

    if (use_new_system == true)
    {
    	LayerGeneralEnd.RemoveClass("LayerGeneralEnd")
    	LayerGeneralEnd.AddClass("LayerGeneralEnd_HeroTalent")
    }else
    {
    	LayerGeneralEnd.AddClass("LayerGeneralEnd")
    	LayerGeneralEnd.RemoveClass("LayerGeneralEnd_HeroTalent")
    }

		Game.init_talent_panel(LayerGeneral, hero)
		Game.EmitSound("UI.Click_Hero")
	});
}


function CreateTalentPanel()
{
	var main_panel = $.GetContextPanel().FindChildTraverse("LayerGeneralEnd");
	let LayerGeneral = main_panel.FindChildTraverse("LayerGeneral")
	if (!LayerGeneral)
	{
		let talents_panel = $.CreatePanel("Panel", main_panel, "talents_panel")
		talents_panel.BLoadLayout( "file://{resources}/layout/custom_game/talents_panel/talents_panel.xml", false, false );
		LayerGeneral = main_panel.FindChildTraverse("LayerGeneral")
	}
	return LayerGeneral
}


init()