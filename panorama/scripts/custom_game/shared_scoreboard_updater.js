--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";

CustomNetTables.SubscribeNetTableListener( "networth_players", update_networth_players );

var game_ended = false
var early_game_timer = 17*60
var game_started = false
var players_data = {}
let qwe = {}

var local_player_id = -1
var dota_time = 0
var is_spectator = false
var player_panels = {}

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

function GetChild(panel, childName)
{
	if (panel === null || panel === undefined) return null

	if (!panel.child_cache)
	{
		panel.child_cache = {}
	}

	let child = panel.child_cache[childName]
	if (child === undefined)
	{
		child = panel.FindChildInLayoutFile(childName)
		panel.child_cache[childName] = child
	}
	return child
}

function GetChildDeep(panel, childName)
{
	if (panel === null || panel === undefined) return null

	if (!panel.child_cache_deep)
	{
		panel.child_cache_deep = {}
	}

	let child = panel.child_cache_deep[childName]
	if (child === undefined)
	{
		child = panel.FindChildTraverse(childName)
		panel.child_cache_deep[childName] = child
	}
	return child
}

function _ScoreboardUpdater_SetTextSafe(panel, childName, textValue)
{
	var childPanel = GetChild(panel, childName)
	if (childPanel === null || childPanel === undefined) return

	var text = String(textValue)
	if (childPanel.text === text) return

	childPanel.text = text;
}

function init()
{
	GameEvents.Subscribe_custom('EndScreen_game_end', EndScreen_game_end)
}

function _ScoreboardUpdater_UpdateRespawnTimer(playerPanel, playerId)
{
	var respawn_seconds = Players.GetRespawnSeconds(playerId)
	var is_dead = respawn_seconds >= 0

	playerPanel.SetHasClass("player_dead", is_dead);

	var table = players_data[String(playerId)]
	var player_lost = table !== undefined && table.lost == 1

	var skull = GetChild(playerPanel, "LostSkull")
	if (skull)
	{
		skull.SetHasClass("LostSkull_show", player_lost)
	}

	if (!is_dead && !player_lost) return

	_ScoreboardUpdater_SetTextSafe(playerPanel, "RespawnTimer", player_lost ? "" : (respawn_seconds + 1));
}

function ScoreboardUpdater_UpdateRespawnTimers()
{
	for (var playerId in player_panels)
	{
		var playerPanel = player_panels[playerId]
		if (!playerPanel) continue

		_ScoreboardUpdater_UpdateRespawnTimer(playerPanel, Number(playerId))
	}
}

function _ScoreboardUpdater_InitPlayerPanel(playerPanel, playerId)
{
	player_panels[String(playerId)] = playerPanel

	var talentButton = GetChild(playerPanel, "TalentButton");
	if (talentButton)
	{
		playerPanel.SetPanelEvent('onactivate', function() {});
		SetShowTalent(talentButton, playerId)
	}
	else
	{
		playerPanel.SetPanelEvent('onactivate', function()
		{
			Players.PlayerPortraitClicked(playerPanel.GetAttributeInt("player_id", -1), false, false)
			Game.Upgrades(playerId)
		});
	}

	playerPanel.SetPanelEvent('onmouseover', function()
	{
		if (playerPanel.damage_tooltip)
		{
			$.DispatchEvent('DOTAShowTextTooltip', playerPanel, playerPanel.damage_tooltip)
		}
	});

	playerPanel.SetPanelEvent('onmouseout', function()
	{
		$.DispatchEvent('DOTAHideTextTooltip', playerPanel);
	});

	var tipButton = GetChildDeep(playerPanel, "PlayerTipButton");
	if (tipButton)
	{
		tipButton.SetPanelEvent('onmouseover', function()
		{
			$.DispatchEvent('DOTAShowTextTooltip', tipButton, tipButton.tip_text)
		});

		tipButton.SetPanelEvent('onmouseout', function()
		{
			$.DispatchEvent('DOTAHideTextTooltip', tipButton);
		});
	}
}

function _ScoreboardUpdater_UpdatePlayerPanel(scoreboardConfig, playersContainer, playerId, localPlayerTeamId)
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
		_ScoreboardUpdater_InitPlayerPanel(playerPanel, playerId)
	}

	playerPanel.SetHasClass("is_local_player", (playerId == local_player_id));

	var isTeammate = false;
	var networth_table_current = players_data[String(playerId)]
	var Player_Level = GetChild(playerPanel, "LevelIndicator");
	var Player_hunted = GetChildDeep(playerPanel, "HuntIndicator");
	var Player_hunted_shadow = GetChildDeep(playerPanel, "HuntIndicatorShadow");
	var Player_respawn_reward = GetChildDeep(playerPanel, "RespawnRewardIndicator");

	if (networth_table_current && Player_Level)
	{
		let tier_class = ""
		if (networth_table_current.hero_tier !== -1 && networth_table_current.hide_tier == 0)
		{
			Player_Level.style.backgroundImage = 'url("file://{images}/custom_game/hero_level_' + String(networth_table_current.hero_tier) + '.png")';
			Player_Level.style.backgroundSize = "contain";
			Player_Level.style.visibility = "visible";
			tier_class = "hero_tier_" + networth_table_current.hero_tier
		}
		else
		{
			Player_Level.style.visibility = "collapse";
		}

		if (playerPanel.tier_class !== tier_class)
		{
			if (playerPanel.tier_class)
			{
				playerPanel.RemoveClass(playerPanel.tier_class)
			}
			if (tier_class !== "")
			{
				playerPanel.AddClass(tier_class)
			}
			playerPanel.tier_class = tier_class
		}
	}

	if (networth_table_current && typeof networth_table_current.no_buyback !== 'undefined')
	{
		playerPanel.SetHasClass("no_buyback", networth_table_current.no_buyback == 1)
	}

	if (networth_table_current && typeof networth_table_current.hunted !== 'undefined' && Player_hunted)
	{
		Player_hunted.visible = networth_table_current.hunted == 1

		if (Player_hunted_shadow)
		{
			Player_hunted_shadow.visible = networth_table_current.hunted == 1
		}
	}

	if (networth_table_current && typeof networth_table_current.respawn_reward !== 'undefined' && Player_respawn_reward)
	{
		Player_respawn_reward.visible = networth_table_current.respawn_reward == 1
	}

	if (networth_table_current)
	{
		_ScoreboardUpdater_SetTextSafe(playerPanel, "TeamScore", networth_table_current.net)
	}

	if (playerInfo)
	{
		isTeammate = (playerInfo.player_team_id == localPlayerTeamId);

		if (networth_table_current && qwe[playerId] == undefined && game_ended == true)
		{
			const func = function()
			{
				networth_table_current = players_data[String(playerId)]
				_ScoreboardUpdater_SetTextSafe(playerPanel, "PlayerMmr", (networth_table_current.rating_before || 0));

				var mmrPlus = GetChildDeep(playerPanel, "MmrPlus")

				if (networth_table_current.rating_change < 0)
				{
					_ScoreboardUpdater_SetTextSafe(playerPanel, "MmrPlus", "- " + (networth_table_current.rating_change * -1));
					if (mmrPlus)
					{
						mmrPlus.text = "- " + (networth_table_current.rating_change * -1);
						mmrPlus.style.color = "gradient( linear, 90% 80%, 30% 20%, from( white ), to( red ) )"
					}
				}
				else
				{
					_ScoreboardUpdater_SetTextSafe(playerPanel, "MmrPlus", "+ " + networth_table_current.rating_change);
					if (mmrPlus)
					{
						mmrPlus.text = "+ " + networth_table_current.rating_change;
					}
				}
				qwe[playerId] = $.Schedule(0.5, func)
			}
			qwe[playerId] = $.Schedule(0.5, func)
		}

		let player_lost = players_data[String(playerId)] !== undefined && players_data[String(playerId)].lost == 1

		playerPanel.SetHasClass("player_lost", player_lost);
		playerPanel.SetHasClass("local_player_teammate", isTeammate && (playerId != local_player_id));

		_ScoreboardUpdater_UpdateRespawnTimer(playerPanel, playerId)
		_ScoreboardUpdater_SetTextSafe(playerPanel, "PlayerName", playerInfo.player_name);
		_ScoreboardUpdater_SetTextSafe(playerPanel, "Level", playerInfo.player_level);
		_ScoreboardUpdater_SetTextSafe(playerPanel, "Kills", playerInfo.player_kills);
		_ScoreboardUpdater_SetTextSafe(playerPanel, "Deaths", playerInfo.player_deaths);
		_ScoreboardUpdater_SetTextSafe(playerPanel, "Assists", playerInfo.player_assists);

		var playerPortrait = GetChild(playerPanel, "HeroIcon");
		if (playerPortrait)
		{
			var portrait_image = playerInfo.player_selected_hero !== ""
				? "file://{images}/heroes/" + Game.GetHeroImage(String(playerId), playerInfo.player_selected_hero) + ".png"
				: "file://{images}/custom_game/unassigned.png"

			if (playerPanel.portrait_image !== portrait_image)
			{
				playerPanel.portrait_image = portrait_image
				playerPortrait.SetImage(portrait_image);
			}
		}

		var hero_name = playerInfo.player_selected_hero_id == -1
			? $.Localize("#DOTA_Scoreboard_Picking_Hero")
			: $.Localize("#" + playerInfo.player_selected_hero)

		_ScoreboardUpdater_SetTextSafe(playerPanel, "HeroName", hero_name)

		var heroNameAndDescription = GetChild(playerPanel, "HeroNameAndDescription");
		if (heroNameAndDescription)
		{
			heroNameAndDescription.SetDialogVariable("hero_name", hero_name);
			heroNameAndDescription.SetDialogVariableInt("hero_level", playerInfo.player_level);
		}

		playerPanel.SetHasClass("player_connection_abandoned", playerInfo.player_connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_ABANDONED);
		playerPanel.SetHasClass("player_connection_failed", playerInfo.player_connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_FAILED);
		playerPanel.SetHasClass("player_connection_disconnected", playerInfo.player_connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_DISCONNECTED);

		var playerAvatar = GetChild(playerPanel, "AvatarImage");
		if (playerAvatar)
		{
			playerAvatar.steamid = playerInfo.player_steamid;
		}

		var playerColorBar = GetChild(playerPanel, "PlayerColorBar");
		if (playerColorBar !== null)
		{
			var barColor = "#000000";
			if (GameUI.CustomUIConfig().team_colors)
			{
				var teamColor = GameUI.CustomUIConfig().team_colors[playerInfo.player_team_id];
				if (teamColor)
				{
					barColor = teamColor;
				}
			}

			if (playerPanel.bar_color !== barColor)
			{
				playerPanel.bar_color = barColor
				playerColorBar.style.backgroundColor = barColor;
			}
		}
	}

	var playerItemsContainer = GetChild(playerPanel, "PlayerItemsContainer");
	if (playerItemsContainer && networth_table_current && networth_table_current.items)
	{
		var items_count = Object.keys(networth_table_current.items).length
		for (var i = 1; i <= items_count; ++i)
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

	var tableData = players_data[String(local_player_id)]
	var tipContainer = GetChildDeep(playerPanel, "PlayerTipContainer");

	if (tipContainer && is_spectator)
	{
		tipContainer.style.opacity = "0";
	}

	if (tableData && tipContainer)
	{
		var tipButton = GetChildDeep(playerPanel, "PlayerTipButton");
		if (tipButton)
		{
			var tip_state = String(tableData.subscribed) + "_" + String(tableData.tips_cooldown)
			if (tipButton.tip_state !== tip_state)
			{
				tipButton.tip_state = tip_state

				let text = $.Localize("#tip_info_unsub")
				if (tableData.subscribed == 1)
				{
					text = $.Localize("#tip_info_sub")
					if (tableData.tips_cooldown && tableData.tips_cooldown > 0)
					{
						text = $.Localize("#tip_cd") + String(tableData.tips_cooldown)
					}
				}
				tipButton.tip_text = text
			}
		}
	}

	var damage_box = GetChild(playerPanel, "PurpleScoreBox")
	var damage_icon = GetChild(playerPanel, "PurpleScoreIcon")

	let max_damage = 45
	let damage_bonus = 0
	if (networth_table_current && networth_table_current.damage_bonus && dota_time <= early_game_timer)
	{
		damage_bonus = networth_table_current.damage_bonus
	}

	playerPanel.damage_tooltip = null

	if (!damage_box) return

	damage_box.visible = damage_bonus != 0
	if (damage_bonus == 0) return

	let is_ally = playerId == local_player_id || isTeammate
	damage_box.SetHasClass("GreenText", is_ally)
	damage_box.SetHasClass("RedText", !is_ally)
	damage_icon.visible = damage_bonus == max_damage

	var text = ''
	if (is_ally)
	{
		text = $.Localize("#Incoming_damage") + Math.abs(damage_bonus) + '% ' + $.Localize("#Incoming_damage2") + Math.abs(damage_bonus) + '%'
		if (damage_bonus == max_damage)
		{
			text = text + $.Localize("#Incoming_damage3")
		}
		text = text + $.Localize("#Incoming_damage4")
	}
	else
	{
		text = $.Localize("#Outgoing_damage") + Math.abs(damage_bonus) + '% ' + $.Localize("#Outgoing_damage2") + Math.abs(damage_bonus) + '%'
		if (damage_bonus == max_damage)
		{
			text = text + $.Localize("#Outgoing_damage3")
		}
		text = text + $.Localize("#Outgoing_damage4")
	}

	playerPanel.damage_tooltip = text
	_ScoreboardUpdater_SetTextSafe(playerPanel, "PurpleScore", damage_bonus + '%')
}

function IsSpectator()
{
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

function _ScoreboardUpdater_UpdateTeamPanel(scoreboardConfig, containerPanel, teamDetails, teamsInfo)
{
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

	var playersContainer = GetChild(teamPanel, "PlayersContainer");
	let razor_counter = -1
	let networth_team = 0
	let player_count = 0
	let no_buyback_count = 0
	let lost_count = 0

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
				if (table.no_buyback == 1)
				{
					no_buyback_count = no_buyback_count + 1
				}
				if (table.lost == 1)
				{
					lost_count = lost_count + 1
				}
			}
			_ScoreboardUpdater_UpdatePlayerPanel(scoreboardConfig, playersContainer, playerId, localPlayerTeamId)
		}
	}

	let team_no_buyback = player_count > 0 && no_buyback_count == player_count
	let team_lost = player_count > 0 && lost_count == player_count
	let teamGoldPanel = GetChildDeep(teamPanel, "TeamNetworthSummary")
	if (teamGoldPanel)
	{
		teamGoldPanel.SetHasClass("TeamNetworthSummary_hidden", player_count <= 1)
		teamGoldPanel.SetHasClass("TeamNetworthSummary_no_buyback", team_no_buyback)
		teamGoldPanel.SetHasClass("TeamNetworthSummary_lost", team_lost)
	}

	let GoldTeamNetworth = GetChild(teamPanel, "GoldTeamNetworth");
	if (GoldTeamNetworth && GoldTeamNetworth.text !== String(networth_team))
	{
		GoldTeamNetworth.text = networth_team
	}

	let RazorIcon = GetChild(teamPanel, "RazorCount");
	let RazorCount = GetChild(teamPanel, "RazorCountLabel");
	if (RazorCount && RazorIcon)
	{
		let razor_text = razor_counter > 0 ? razor_counter.toString() : ""
		if (RazorCount.text !== razor_text)
		{
			RazorCount.text = razor_text
		}
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
		var teamColorPanel = GetChild(teamPanel, "TeamColor");
		teamColor = teamColor.replace(";", "");
		if (teamColorPanel)
		{
			teamColorPanel.style.backgroundColor = teamColor + ";";
		}

		var teamColor_GradentFromTransparentLeft = GetChild(teamPanel, "TeamColor_GradentFromTransparentLeft");
		if (teamColor_GradentFromTransparentLeft)
		{
			var gradientText = 'gradient( linear, 0% 0%, 800% 0%, from( #00000000 ), to( ' + teamColor + ' ) );';
			teamColor_GradentFromTransparentLeft.style.backgroundColor = gradientText;
		}
	}

	return teamPanel;
}

function _ScoreboardUpdater_ReorderTeam(scoreboardConfig, teamsParent, teamPanel, teamId, newPlace, prevPanel)
{
	var oldPlace = null;
	if (GameUI.CustomUIConfig().teamsPrevPlace.length > teamId)
	{
		oldPlace = GameUI.CustomUIConfig().teamsPrevPlace[teamId];
	}
	GameUI.CustomUIConfig().teamsPrevPlace[teamId] = newPlace;

	if (newPlace != oldPlace)
	{
		teamPanel.RemoveClass("team_getting_worse");
		teamPanel.RemoveClass("team_getting_better");
		if (newPlace > oldPlace)
		{
			teamPanel.AddClass("team_getting_worse");
		}
		else if (newPlace < oldPlace)
		{
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
		return -1
	if (teamPlayers_a.length === 0 && teamPlayers_b.length !== 0)
		return 1

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

	if (place1 < 0 && place2 < 0)
	{
		place1 = -gold1
		place2 = -gold2
	}
	else
	{
		if (place1 < 0 && place2 >= 0)
			return -1
		if (place1 >= 0 && place2 < 0)
			return 1
	}

	if (place1 < place2)
		return -1
	if (place1 > place2)
		return 1

	return 0
}

function stableCompareFunc(a, b)
{
	var unstableCompare = compareFunc(a, b);
	if (unstableCompare != 0)
	{
		return unstableCompare;
	}

	if (GameUI.CustomUIConfig().teamsPrevPlace.length <= a.team_id)
	{
		return 0;
	}

	if (GameUI.CustomUIConfig().teamsPrevPlace.length <= b.team_id)
	{
		return 0;
	}

	var a_prev = GameUI.CustomUIConfig().teamsPrevPlace[a.team_id];
	var b_prev = GameUI.CustomUIConfig().teamsPrevPlace[b.team_id];
	if (a_prev < b_prev)
	{
		return -1;
	}
	else if (a_prev > b_prev)
	{
		return 1;
	}

	return 0;
}

function _ScoreboardUpdater_UpdateAllTeamsAndPlayers(scoreboardConfig, teamsContainer)
{
	local_player_id = Game.GetLocalPlayerID()
	dota_time = Game.GetDOTATime(false, false)
	is_spectator = IsSpectator()

	var teamsList = [];
	for (var teamId of Game.GetAllTeamIDs())
	{
		teamsList.push(Game.GetTeamDetails(teamId));
	}

	var teamsInfo = {
		max_team_players: 0
	};

	var panelsByTeam = [];
	for (var i = 0; i < teamsList.length; ++i)
	{
		var teamId = teamsList[i].team_id;
		var teamPlayers = Game.GetPlayerIDsOnTeam(teamId)
		var n = 0

		for (var playerId of teamPlayers)
		{
			var playerInfo = Game.GetPlayerInfo(playerId);
			if ((playerInfo) && (playerInfo.player_selected_hero != "npc_dota_hero_wisp"))
			{
				n = n + 1
			}
		}

		if (n > 0)
		{
			var teamPanel = _ScoreboardUpdater_UpdateTeamPanel(scoreboardConfig, teamsContainer, teamsList[i], teamsInfo);
			if (teamPanel)
			{
				panelsByTeam[teamsList[i].team_id] = teamPanel;
			}
		}
	}

	if (teamsList.length > 1)
	{
		if (scoreboardConfig.shouldSort)
		{
			teamsList.sort(stableCompareFunc);
		}

		var prevPanel = panelsByTeam[teamsList[0].team_id];
		for (var i = 0; i < teamsList.length; ++i)
		{
			var teamId = teamsList[i].team_id;
			var teamPanel = panelsByTeam[teamId];
			if (teamPanel && prevPanel)
				_ScoreboardUpdater_ReorderTeam(scoreboardConfig, teamsContainer, teamPanel, teamId, i, prevPanel);
			prevPanel = teamPanel;
		}
	}
}

function ScoreboardUpdater_InitializeScoreboard(scoreboardConfig, scoreboardPanel)
{
	GameUI.CustomUIConfig().teamsPrevPlace = [];
	if (typeof(scoreboardConfig.shouldSort) === 'undefined')
	{
		scoreboardConfig.shouldSort = true;
	}

	_ScoreboardUpdater_UpdateAllTeamsAndPlayers(scoreboardConfig, scoreboardPanel);

	return {
		"scoreboardConfig": scoreboardConfig,
		"scoreboardPanel": scoreboardPanel
	}
}

function ScoreboardUpdater_SetScoreboardActive(scoreboardHandle, isActive)
{
	if (scoreboardHandle.scoreboardConfig === null || scoreboardHandle.scoreboardPanel === null)
	{
		return;
	}

	if (isActive)
	{
		_ScoreboardUpdater_UpdateAllTeamsAndPlayers(scoreboardHandle.scoreboardConfig, scoreboardHandle.scoreboardPanel);
	}
}

function ScoreboardUpdater_GetTeamPanel(scoreboardHandle, teamId)
{
	if (scoreboardHandle.scoreboardPanel === null)
	{
		return;
	}

	var teamPanelName = "_dynamic_team_" + teamId;
	return scoreboardHandle.scoreboardPanel.FindChild(teamPanelName);
}

function ScoreboardUpdater_GetSortedTeamInfoList(scoreboardHandle)
{
	var teamsList = [];
	for (var teamId of Game.GetAllTeamIDs())
	{
		teamsList.push(Game.GetTeamDetails(teamId));
	}

	if (teamsList.length > 1)
	{
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

function SetShowTalent(panel, player_id)
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
		Game.init_talent_panel(LayerGeneral, player_id)
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
		talents_panel.style.width = "fit-children"
		LayerGeneral = main_panel.FindChildTraverse("LayerGeneral")
	}

	return LayerGeneral
}

init()