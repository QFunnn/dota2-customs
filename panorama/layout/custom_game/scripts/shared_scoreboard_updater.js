--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";

function ScoreboardGetCustomTable(tableName, key)
{
    if (Game.GetCustomTable)
    {
        return Game.GetCustomTable(tableName, key);
    }
    return undefined;
}

let ended = false

if (!GameUI.CustomUIConfig().DATA_TABLE_SERVER)
{
    GameUI.CustomUIConfig().DATA_TABLE_SERVER = 
    {
        "end_game_damage" : {},
        "aegis_count" : {},
        "end_game_items" : {},
        "coins_end" : {},
        "rating_end" : {},
        "playersbet" : {},
        "duelplayers" : {},
        "huntplayers" : {},
        "visibleicon" : {},
        "playernetworths" : {},
        "playernetworths_end" : {},
        "playernetworths_team" : {},
        "reported_info" : {},
        "tournament_data" : {},
        "tip_cooldown" : 
        {
            "0" : {cooldown : 0},
            "1" : {cooldown : 0},
            "2" : {cooldown : 0},
            "3" : {cooldown : 0},
            "4" : {cooldown : 0},
            "5" : {cooldown : 0},
            "6" : {cooldown : 0},
            "7" : {cooldown : 0},
            "8" : {cooldown : 0},
            "9" : {cooldown : 0},
            "10" : {cooldown : 0},
        },
    }
}

var levels =
[
	0,
	10,
	20,
	30,
	40,
	50,

	60,
	70,
	80,
	90, 
	100,
	110,

	120,
	130,
	140,
	150,
	160,
	170,

	180,
	190,
	200,
	210,
	220,
	230,

	240,
	250,
	260,
	270,
	280,
	290,

	300,
]

function _ScoreboardUpdater_SetTextSafe(panel, childName, textValue) {
	if (panel === null)
		return;
	var childPanel = panel.FindChildInLayoutFile(childName)
	if (childPanel === null)
		return;
	childPanel.text = textValue;
}

function HasHeroModifier(id, mod) {
	var hero = Players.GetPlayerHeroEntityIndex(id)
	for (var i = 0; i < Entities.GetNumBuffs(hero); i++) {
		var buffID = Entities.GetBuff(hero, i)
		if (Buffs.GetName(hero, buffID) == mod) {
			return true
		}
	}
	return false
}

function _ScoreboardUpdater_UpdatePlayerPanel(scoreboardConfig, playersContainer, playerId, localPlayerTeamId, teamPanel, teamId) {
	var playerInfo = Game.GetPlayerInfo(playerId);
	var playerPanelName = "_dynamic_player_" + playerId;
	var playerPanel = playersContainer.FindChild(playerPanelName);

	if (playerPanel === null) {
		playerPanel = $.CreatePanel("Panel", playersContainer, playerPanelName);
		playerPanel.SetAttributeInt("player_id", playerId);
		playerPanel.BLoadLayout(scoreboardConfig.playerXmlName, false, false);
	}
	playerPanel.SetHasClass("is_local_player", (playerId == Game.GetLocalPlayerID()));
	var ultStateOrTime = PlayerUltimateStateOrTime_t.PLAYER_ULTIMATE_STATE_HIDDEN;
	var isTeammate = false;
	var player_networths = GameUI.CustomUIConfig().DATA_TABLE_SERVER["duelplayers"];
	var player_hunters = GameUI.CustomUIConfig().DATA_TABLE_SERVER["huntplayers"];
	if (playerInfo) {
		isTeammate = (playerInfo.player_team_id == localPlayerTeamId);
		if (isTeammate) {
			ultStateOrTime = Game.GetPlayerUltimateStateOrTime(playerId);
		}
		playerPanel.SetHasClass("player_dead", (playerInfo.player_respawn_seconds >= 0 && playerInfo.player_respawn_seconds <= 99));
		playerPanel.SetHasClass("player_lose", (playerInfo.player_respawn_seconds > 100));
		playerPanel.SetHasClass("local_player_teammate", isTeammate && (playerId != Game.GetLocalPlayerID()));
		_ScoreboardUpdater_SetTextSafe(playerPanel, "RespawnTimer", (playerInfo.player_respawn_seconds + 1));
		_ScoreboardUpdater_SetTextSafe(playerPanel, "PlayerName", playerInfo.player_name);
		_ScoreboardUpdater_SetTextSafe(playerPanel, "Level", playerInfo.player_level);
		_ScoreboardUpdater_SetTextSafe(playerPanel, "Kills", playerInfo.player_kills);
		_ScoreboardUpdater_SetTextSafe(playerPanel, "Deaths", playerInfo.player_deaths);
		_ScoreboardUpdater_SetTextSafe(playerPanel, "Assists", playerInfo.player_assists);
		let table_visible = GameUI.CustomUIConfig().DATA_TABLE_SERVER["visibleicon"]
		if ((Game.GetMapInfo().map_display_name.includes("rating")))
		{
			if (player_networths) 
			{
				if (player_networths[1] && player_networths[2]) 
				{
                    if (Game.GetMapInfo().map_display_name == "rating_duo" || Game.GetMapInfo().map_display_name == "rating_duo_300")
                    {
                        if (player_networths[1]["teamnumber"] == teamId) 
                        {
                            if (table_visible && table_visible.visible == "true")
                            {
                                playerPanel.SetHasClass("player_duel", true);
                            } 
                            else 
                            {
                                playerPanel.SetHasClass("player_duel", false);
                            }
                        } 
                        else if (player_networths[2]["teamnumber"] == teamId)
                        {
                            if (table_visible && table_visible.visible == "true")
                            {
                                playerPanel.SetHasClass("player_duel", true);
                            } 
                            else 
                            {
                                playerPanel.SetHasClass("player_duel", false);
                            }
                        } 
                        else
                        {
                            playerPanel.SetHasClass("player_duel", false);
                        } 
                    }
                    else
                    {
                        if (player_networths[1]["id"] == playerId) {
                            if (table_visible && table_visible.visible == "true")
                            {
                                playerPanel.SetHasClass("player_duel", true);
                            } else {
                                playerPanel.SetHasClass("player_duel", false);
                            }
                        } 
                        else if (player_networths[2]["id"] == playerId)
                        {
                            if (table_visible && table_visible.visible == "true")
                            {
                                playerPanel.SetHasClass("player_duel", true);
                            } else {
                                playerPanel.SetHasClass("player_duel", false);
                            }
                        } 
                        else
                        {
                            playerPanel.SetHasClass("player_duel", false);
                        }
                    }
				}
			}
			if (player_hunters) 
			{
                let has_hunt = false
                for (var i = 1; i <= Object.keys(player_hunters).length; i++) 
			    {
                    if (playerId == player_hunters[i].id)
                    {
                        has_hunt = true
                    }
                }
                if (has_hunt) 
				{
				    playerPanel.SetHasClass("player_hunt", true);
				} else {
                    playerPanel.SetHasClass("player_hunt", false);
                }
			}
		}
		let bettable = GameUI.CustomUIConfig().DATA_TABLE_SERVER["playersbet"][String(Players.GetLocalPlayer())]
		if (bettable) 
		{
            if (Game.GetMapInfo().map_display_name == "rating_duo" || Game.GetMapInfo().map_display_name == "rating_duo_300")
            {
                if (String(bettable.bet)) 
                {
                    if (String(bettable.bet) == String(playerInfo.player_team_id))
                    {
                        teamPanel.SetHasClass("player_bet", true)
                    } 
                    else 
                    {
                        teamPanel.SetHasClass("player_bet", false)
                    }
                } 
                else 
                {
                    teamPanel.SetHasClass("player_bet", false)
                }
            }
            else
            {
                if (String(bettable.bet)) 
                {
                    if (String(bettable.bet) == String(playerId))
                    {
                        teamPanel.SetHasClass("player_bet", true)
                    } 
                    else 
                    {
                        teamPanel.SetHasClass("player_bet", false)
                    }
                } 
                else 
                {
                    teamPanel.SetHasClass("player_bet", false)
                }
            }
		} 
		else 
		{
			teamPanel.SetHasClass("player_bet", false)
		}

		var playerPortrait = playerPanel.FindChildInLayoutFile("HeroIcon");

		if (playerPortrait) {
			if (playerInfo.player_selected_hero !== "") 
            {
				playerPortrait.SetImage("file://{images}/heroes/" + GetPortraitHero(playerInfo.player_selected_hero) + ".png");
			} else {
				playerPortrait.SetImage("file://{images}/custom_game/unassigned.png");
			}
		}

		if (GetHeroInformation(String(playerInfo.player_selected_hero), playerId) != null) 
		{
			let image_rank = playerPanel.FindChildTraverse("rank_icon")
			if (image_rank)
			{
				let info = GetHeroInformation(String(playerInfo.player_selected_hero), playerId)
				let hero_lvl = GetLevelByCoins(info.coins)
                if (hero_lvl > 0)
                {
                    image_rank.style.backgroundImage = 'url("s2r://panorama/images/hud/reborn/top_bar_hero_radiant_badge_' + GetHeroRankIcon(hero_lvl) + '_psd.vtex")'
                    image_rank.style.backgroundSize = "69px 47px"
                    image_rank.style.backgroundPosition = "-5px 7px"
                    image_rank.style.backgroundRepeat = "no-repeat"
                    image_rank.style.opacity = "1"
                }
                else
                {
                    image_rank.style.opacity = "0"
                }
			}
		}

        //"panorama/images/hud/reborn/top_bar_hero_radiant_badge_2.psd"

		var SteamAvatarImage = playerPanel.FindChildInLayoutFile( "SteamAvatarImage" );
		if ( SteamAvatarImage )
		{
			SteamAvatarImage.steamid = playerInfo.player_steamid
		}

        var table = GameUI.CustomUIConfig().DATA_TABLE_SERVER["playernetworths_end"][String(playerId)]
        if (table) 
        {
            let networths = table.networths 
            if (Game.GetMapInfo().map_display_name != "arena")
            {
                if (networths > 99999) 
                {
                    networths = 99999
                }
            }
            _ScoreboardUpdater_SetTextSafe(playerPanel, "TeamScore", networths)
            _ScoreboardUpdater_SetTextSafe(playerPanel, "NetworthsPlayer", networths)
        }

		if (playerInfo.player_selected_hero_id == -1) { 
			_ScoreboardUpdater_SetTextSafe(playerPanel, "HeroName", $.Localize("#DOTA_Scoreboard_Picking_Hero"))
		} else {
			_ScoreboardUpdater_SetTextSafe(playerPanel, "HeroName", $.Localize("#" + playerInfo.player_selected_hero))
		}

		var heroNameAndDescription = playerPanel.FindChildInLayoutFile("HeroNameAndDescription");
		if (heroNameAndDescription) 
		{
			if (playerInfo.player_selected_hero_id == -1) {
				heroNameAndDescription.SetDialogVariable("hero_name", $.Localize("#DOTA_Scoreboard_Picking_Hero"));
			} else {
				heroNameAndDescription.SetDialogVariable("hero_name", $.Localize("#" + playerInfo.player_selected_hero));
			}
			heroNameAndDescription.SetDialogVariableInt("hero_level", playerInfo.player_level);
		}

		var localplayer_data = ScoreboardGetCustomTable("woda_player_data", String(playerId));
	    if (localplayer_data)
	    {
	    	var PlayerRating = playerPanel.FindChildInLayoutFile("PlayerRating");
	    	if (PlayerRating)
	    	{
	    		if (Game.GetMapInfo().map_display_name.includes("rating"))
				{
	    			PlayerRating.text = String(localplayer_data.rating)
	    		} 
	    		else if (Game.GetMapInfo().map_display_name == "overthrow")
				{
	    			PlayerRating.text = String(localplayer_data.rating)
	    		}
	    		else 
	    		{
	    			PlayerRating.text = String(localplayer_data.pve_rating)
	    			PlayerRating.style.color = "orange"
	    		}
	    	}
	    }

		var LevelContainer = playerPanel.FindChildInLayoutFile("LevelContainer");
        if (LevelContainer) 
        {
            _ScoreboardUpdater_SetTextSafe(playerPanel, "hero_level", playerInfo.player_level)
        }

		var heroNameAndDescription2 = playerPanel.FindChildInLayoutFile("HeroLevel");
		if (heroNameAndDescription2) 
		{
			if (Game.GetMapInfo().map_display_name.includes("rating"))
			{
				heroNameAndDescription2.text=playerInfo.player_level
			}
			else
			{
				heroNameAndDescription2.visible = false
			}
		}

		var HeroAegis = playerPanel.FindChildInLayoutFile("HeroAegis");
		if (HeroAegis) 
		{
			if (Game.GetMapInfo().map_display_name == "arena")
			{
				let tables_aegis = GameUI.CustomUIConfig().DATA_TABLE_SERVER["aegis_count"][String(playerId)]
				if (tables_aegis)
				{
					HeroAegis.text = tables_aegis.aegis
					HeroAegis.visible = true
				}
			}
			else
			{
				HeroAegis.visible = false
			}
		}

		var HeroOverthrowKills = playerPanel.FindChildInLayoutFile("HeroOverthrowKills");
		if (HeroOverthrowKills) 
		{
			if (Game.GetMapInfo().map_display_name == "overthrow")
			{
				HeroOverthrowKills.text = Game.GetTeamDetails(playerInfo.player_team_id).team_score
				HeroOverthrowKills.visible = true
			}
			else
			{
				HeroOverthrowKills.visible = false
			}
		}

		let table_talents = ScoreboardGetCustomTable("playerstalents", String(playerId))
		if (table_talents) 
		{
			var PlayerTalentsStrength = playerPanel.FindChildInLayoutFile("PlayerTalentsStrength");
			if (PlayerTalentsStrength) 
			{
				_ScoreboardUpdater_SetTextSafe(playerPanel, "StengthTalentLabel", table_talents["str"] || 0)
			}
			var PlayerTalentsAgility = playerPanel.FindChildInLayoutFile("PlayerTalentsAgility");
			if (PlayerTalentsAgility) 
			{
				_ScoreboardUpdater_SetTextSafe(playerPanel, "AgilityTalentLabel", table_talents["agi"] || 0)
			}
			var PlayerTalentsIntellect = playerPanel.FindChildInLayoutFile("PlayerTalentsIntellect");
			if (PlayerTalentsIntellect) 
			{
				_ScoreboardUpdater_SetTextSafe(playerPanel, "IntellectTalentLabel", table_talents["int"] || 0)
			}
		}

        let WodaPlusContainer = playerPanel.FindChildInLayoutFile("WodaPlusContainer")
        if (WodaPlusContainer)
        {
            let table_player_info = ScoreboardGetCustomTable("woda_player_data", String(playerId))
            if (table_player_info && table_player_info.plus_days > 0)
            {
                WodaPlusContainer.visible = true
                SetTextWodaPlus(WodaPlusContainer)
            }
        }

        let BattlePassContainer = playerPanel.FindChildInLayoutFile("BattlePassContainer")
        if (BattlePassContainer)
        {
            let table_player_info = ScoreboardGetCustomTable("woda_player_data", String(playerId))
            if (table_player_info && table_player_info.has_battlepass_2026 > 0)
            {
                BattlePassContainer.visible = true
                SetTextBattlePass(BattlePassContainer)
            }
        }

		let coins_end = GameUI.CustomUIConfig().DATA_TABLE_SERVER["coins_end"][String(playerId)]
		if (coins_end) 
		{
			_ScoreboardUpdater_SetTextSafe(playerPanel, "Coins", coins_end.coin || 0)
		}

		let rating_end = GameUI.CustomUIConfig().DATA_TABLE_SERVER["rating_end"][String(playerId)]
		if (rating_end) 
		{
			if (Game.GetMapInfo().map_display_name.includes("rating"))
			{
				if (rating_end.rating > 0)
				{
					_ScoreboardUpdater_SetTextSafe(playerPanel, "RatingChange",  "+" + (rating_end.rating || 0))
				} 
				else if (rating_end.rating < 0)
				{
					let RatingChange = playerPanel.FindChildInLayoutFile( "RatingChange" )
					if ( RatingChange ) 
                    {
						RatingChange.style.color = "red"
					}
					_ScoreboardUpdater_SetTextSafe(playerPanel, "RatingChange",  rating_end.rating || 0)
				} 
                else 
				{
					let RatingChange = playerPanel.FindChildInLayoutFile( "RatingChange" )
					if ( RatingChange ) 
					{
						RatingChange.style.color = "white"
					}
					_ScoreboardUpdater_SetTextSafe(playerPanel, "RatingChange",  rating_end.rating || 0)
				}
                if (rating_end.is_double === 1)
                {
                    let RatingChange = playerPanel.FindChildInLayoutFile( "RatingChange" )
					if ( RatingChange ) 
					{
						RatingChange.style.color = "#f7d066"
					}
                }
			}
			else if (Game.GetMapInfo().map_display_name == "overthrow")
			{
				if (rating_end.rating > 0)
				{
					let RatingChange = playerPanel.FindChildInLayoutFile( "RatingChange" )
					_ScoreboardUpdater_SetTextSafe(playerPanel, "RatingChange",  "+" + (rating_end.rating || 0))
				} 
				else if (rating_end.rating < 0)
				{
					let RatingChange = playerPanel.FindChildInLayoutFile( "RatingChange" )
					_ScoreboardUpdater_SetTextSafe(playerPanel, "RatingChange",  rating_end.rating || 0)
				} else 
				{
					let RatingChange = playerPanel.FindChildInLayoutFile( "RatingChange" )
					_ScoreboardUpdater_SetTextSafe(playerPanel, "RatingChange",  rating_end.rating || 0)
				}
			}
			else 
			{
				let RatingChange = playerPanel.FindChildInLayoutFile( "RatingChange" )
				
				if ( RatingChange ) 
				{
					RatingChange.style.color = "orange"
				}

				_ScoreboardUpdater_SetTextSafe(playerPanel, "RatingChange",  rating_end.rating || 0)
			}
		}

		playerPanel.SetHasClass("player_connection_abandoned", playerInfo.player_connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_ABANDONED);
		playerPanel.SetHasClass("player_connection_failed", playerInfo.player_connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_FAILED);
		playerPanel.SetHasClass("player_connection_disconnected", playerInfo.player_connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_DISCONNECTED);
		var playerAvatar = playerPanel.FindChildInLayoutFile("AvatarImage");
		if (playerAvatar) {
			playerAvatar.steamid = playerInfo.player_steamid;
		}

		var playerColorBar = playerPanel.FindChildInLayoutFile("PlayerColorBar");
		if (playerColorBar !== null) {
			if (GameUI.CustomUIConfig().team_colors) {
				var teamColor = GameUI.CustomUIConfig().team_colors[playerInfo.player_team_id];
				if (teamColor) {
					playerColorBar.style.backgroundColor = teamColor;
				}
			} else {
				var playerColor = "#000000";
				playerColorBar.style.backgroundColor = playerColor;
			}
		}
	}

    let hero_name = playerInfo.player_selected_hero
    SetTalentSelectEvent(playerPanel, playerId, hero_name.replace("npc_dota_hero_", ''))

	var tip_cooldown_label = GameUI.CustomUIConfig().DATA_TABLE_SERVER["tip_cooldown"][String(Players.GetLocalPlayer())];
	if (tip_cooldown_label)
	{
		if (GameUI.IsAltDown() && (playerId != Game.GetLocalPlayerID()) ) 
		{
			if (!playerPanel.BHasClass("player_connection_abandoned") && !playerPanel.BHasClass("player_connection_failed") && !playerPanel.BHasClass("player_connection_disconnected"))
			{
				playerPanel.SetHasClass( "alt_health_check", true );
			} else {
				playerPanel.SetHasClass( "alt_health_check", false );
			}
		} 
		else 
		{
			playerPanel.SetHasClass( "alt_health_check", false );
		}  
		if (tip_cooldown_label.cooldown > 0)
		{
			SetPSelectEvent(playerPanel.FindChildInLayoutFile("TipButtonCustom"), true, playerId)
		} else {
			SetPSelectEvent(playerPanel.FindChildInLayoutFile("TipButtonCustom"), false, playerId)
			if (playerPanel.FindChildInLayoutFile("TipButtonCustom"))
			{
				playerPanel.FindChildInLayoutFile("TipButtonCustom").style.saturation = "1"
			}
		}
	}

	var report_button_player = playerPanel.FindChildInLayoutFile( "ReportButtonPlayer" );

	if (report_button_player) 
	{
		SetReportPlayerButton(report_button_player, playerId)

		if (Game.GetMapInfo().map_display_name == "arena" || playerInfo.player_team_id == localPlayerTeamId || Game.GetMapInfo().map_display_name == "rating_duo" || Game.GetMapInfo().map_display_name == "rating_duo_300")
		{
			report_button_player.style.opacity = "0"
		}
	}

	var playerItemsContainer = playerPanel.FindChildInLayoutFile( "playerItemsContainer" );
    if ( playerItemsContainer )
    {
        var item_table = GameUI.CustomUIConfig().DATA_TABLE_SERVER["end_game_items"][String(playerId)];
        if ( item_table )
        {

            for ( var i = 0; i < 6; ++i )
            {
                var itemPanelName = "_dynamic_item_" + i;
                var itemPanel = playerItemsContainer.FindChild( itemPanelName );
                if ( itemPanel === null )
                {
                    itemPanel = $.CreatePanel( "DOTAItemImage", playerItemsContainer, itemPanelName );
                    itemPanel.AddClass( "PlayerItem" );
                }
                itemPanel.itemname = item_table[i];
            }
            var itemPanelName = "_dynamic_item_18";
            var itemPanel = playerItemsContainer.FindChild( itemPanelName );
            if ( itemPanel === null )
            {
                itemPanel = $.CreatePanel( "DOTAItemImage", playerItemsContainer, itemPanelName );
                itemPanel.AddClass( "PlayerItem" ); 
            }
            itemPanel.itemname = item_table[16];


            let itemPanel_passive = playerItemsContainer.FindChild( "_dynamic_item_19" );
            if ( itemPanel_passive === null )
            {
                itemPanel_passive = $.CreatePanel( "DOTAItemImage", playerItemsContainer, itemPanelName );
                itemPanel_passive.AddClass( "PlayerItem" ); 
            }
            itemPanel_passive.itemname = item_table[17];
        }
    }

    var WodaPlayerDamageStats =  playerPanel.FindChildInLayoutFile( "WodaPlayerDamageStats" );
    if (WodaPlayerDamageStats)
    {
        let table_player_damage = GameUI.CustomUIConfig().DATA_TABLE_SERVER["end_game_damage"][String(playerId)]
        if (table_player_damage)
        {
            UpdateDamageFilter("Incoming", table_player_damage[1], WodaPlayerDamageStats)
            UpdateDamageFilter("Outgoing", table_player_damage[2], WodaPlayerDamageStats)
        }
    }

	playerPanel.SetHasClass("player_ultimate_ready", (ultStateOrTime == PlayerUltimateStateOrTime_t.PLAYER_ULTIMATE_STATE_READY));
	playerPanel.SetHasClass("player_ultimate_no_mana", (ultStateOrTime == PlayerUltimateStateOrTime_t.PLAYER_ULTIMATE_STATE_NO_MANA));
	playerPanel.SetHasClass("player_ultimate_not_leveled", (ultStateOrTime == PlayerUltimateStateOrTime_t.PLAYER_ULTIMATE_STATE_NOT_LEVELED));
	playerPanel.SetHasClass("player_ultimate_hidden", (ultStateOrTime == PlayerUltimateStateOrTime_t.PLAYER_ULTIMATE_STATE_HIDDEN));
	playerPanel.SetHasClass("player_ultimate_cooldown", (ultStateOrTime > 0));
	_ScoreboardUpdater_SetTextSafe(playerPanel, "PlayerUltimateCooldown", ultStateOrTime);
}

GameEvents.Subscribe_custom( 'event_update_scoreboard_data', event_update_scoreboard_data );
function event_update_scoreboard_data(data)
{
    if (GameUI.CustomUIConfig().DATA_TABLE_SERVER[data.table_name])
    {
        if (typeof data.player_id !== 'undefined')
        {
            GameUI.CustomUIConfig().DATA_TABLE_SERVER[data.table_name][String(data.player_id)] = data.data
            if (data.table_name == "reported_info" && String(data.player_id) == String(Players.GetLocalPlayer()))
            {
                UpdateReportVisual(data.data)
            }
        }
        else
        {
            GameUI.CustomUIConfig().DATA_TABLE_SERVER[data.table_name] = data.data
        }
    }
}

function UpdateDamageFilter(type, table, WodaPlayerDamageStats)
{
    let physical_damage = table[1] || 0
    let magical_damage = table[2] || 0
    let pure_damage = table[4] || 0
    let all_damage = physical_damage + magical_damage + pure_damage
    if (all_damage <= 0)
    {
        all_damage = 1
    }
    
    let PhysicalDamagePanel = WodaPlayerDamageStats.FindChildTraverse("PhysicalDamage"+type)
    let MagicalDamagePanel = WodaPlayerDamageStats.FindChildTraverse("MagicalDamage"+type)
    let PureDamagePanel = WodaPlayerDamageStats.FindChildTraverse("PureDamage"+type)

    PhysicalDamagePanel.style.width = Math.max(0, (physical_damage / all_damage * 100)) + "%";
    MagicalDamagePanel.style.width = Math.max(0, (magical_damage / all_damage * 100)) + "%";
    PureDamagePanel.style.width = Math.max(0, (pure_damage / all_damage * 100)) + "%";

    PhysicalDamagePanel.GetChild(0).text = Math.floor(physical_damage)
    MagicalDamagePanel.GetChild(0).text = Math.floor(magical_damage)
    PureDamagePanel.GetChild(0).text = Math.floor(pure_damage)
}

function SetReportPlayerButton(panel, id)
{
	panel.SetPanelEvent("onactivate", function() 
	{ 
		SelectReportPlayer(panel, id)
	});
	panel.SetPanelEvent('onmouseover', function() 
	{
        $.DispatchEvent('DOTAShowTextTooltip', panel, $.Localize("#report_button_description")); 
    });
    panel.SetPanelEvent('onmouseout', function() 
    {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    }); 
}

function SetTextWodaPlus(panel)
{
    panel.SetPanelEvent('onmouseover', function() 
	{
        $.DispatchEvent('DOTAShowTextTooltip', panel, $.Localize("#woda_plus_endgame_info")); 
    });
    panel.SetPanelEvent('onmouseout', function() 
    {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });
}

function SetTextBattlePass(panel)
{
    panel.SetPanelEvent('onmouseover', function() 
	{
        $.DispatchEvent('DOTAShowTextTooltip', panel, $.Localize("#battle_pass_2")); 
    });
    panel.SetPanelEvent('onmouseout', function() 
    {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });
}

function SelectReportPlayer(panel, id)
{
	GameEvents.SendCustomGameEventToServer_custom( "player_reported_select", {report_id : id} );
}

function UpdateReportVisual(data) 
{
    for ( var i = 0; i < 10; ++ i )
    {
        var playerPanelName = "_dynamic_player_" + i;
        if (playerPanelName) 
        {
            var playerPanel = $.GetContextPanel().FindChildTraverse(playerPanelName)
            if (playerPanel) 
            {
                var ReportButtonPlayer = playerPanel.FindChildInLayoutFile( "ReportButtonPlayer" );
                if (ReportButtonPlayer)
                {
                    ReportButtonPlayer.SetHasClass("PlayerReported", false)
                }
            }
        }
    }
    for (var i = 1; i <= Object.keys(data.reported_info).length; i++) 
    {
        var playerPanelName = "_dynamic_player_" + data.reported_info[i];
        if (playerPanelName) 
        {
            var playerPanel = $.GetContextPanel().FindChildTraverse(playerPanelName)
            if (playerPanel) 
            {
                var ReportButtonPlayer = playerPanel.FindChildInLayoutFile( "ReportButtonPlayer" );
                if (ReportButtonPlayer)
                {
                    ReportButtonPlayer.SetHasClass("PlayerReported", true)
                }
            }
        }
    }
}

var tip_cooldown_visual = true

function SetPSelectEvent(panel, cooldown, player_id_tip)
{
	if (panel)
	{
		if ( cooldown ) 
		{ 
			panel.SetPanelEvent("onactivate", function() {})
	    	return
		}
	    panel.SetPanelEvent("onactivate", function() 
	    { 
	    	if (tip_cooldown_visual)
	    	{
				GameEvents.SendCustomGameEventToServer_custom("PlayerTip", {player_id_tip : player_id_tip, });
	        	panel.SetPanelEvent("onactivate", function() {})
	        	tip_cooldown_visual = false
	        	$.Schedule( 1.5, function()
			    {
			       	tip_cooldown_visual = true
			    });
	    	}
	    })
	}
}

function SetTalentSelectEvent(panel, player_id, hero_name)
{
	if (panel)
	{
	    panel.SetPanelEvent("onactivate", function() 
	    { 
            GameUI.CustomUIConfig().CheckEnemyTalent(player_id, hero_name)
	    })
	}
}

function _ScoreboardUpdater_UpdateTeamPanel(scoreboardConfig, containerPanel, teamDetails, teamsInfo) 
{
	if (Game.GetMapInfo().map_display_name.includes("rating") || Game.GetMapInfo().map_display_name == "overthrow")
	{
		if (!containerPanel)
			return;
		let custompicktable = ScoreboardGetCustomTable("custom_pick", "pick_state")
		if (custompicktable && custompicktable.in_progress) {
			return
		} 
		var teamId = teamDetails.team_id;
		var teamPlayers = Game.GetPlayerIDsOnTeam(teamId)
		var teamPanelName = "_dynamic_team_" + teamId;
		var teamPanel = containerPanel.FindChild(teamPanelName);
		if (teamPanel === null) {
			teamPanel = $.CreatePanel("Panel", containerPanel, teamPanelName);
			teamPanel.SetAttributeInt("team_id", teamId);
			teamPanel.BLoadLayout(scoreboardConfig.teamXmlName, false, false);
			var logo_xml = GameUI.CustomUIConfig().team_logo_xml;
			if (logo_xml) {
				var teamLogoPanel = teamPanel.FindChildInLayoutFile("TeamLogo");
				if (teamLogoPanel) {
					teamLogoPanel.SetAttributeInt("team_id", teamId);
					teamLogoPanel.BLoadLayout(logo_xml, false, false);
				}
			}
		}

        if (Game.GetMapInfo().map_display_name == "rating_duo" || Game.GetMapInfo().map_display_name == "rating_duo_300")
        {
            let team_netw = GameUI.CustomUIConfig().DATA_TABLE_SERVER["playernetworths_team"][String(teamId)]
            if (team_netw)
            {
                let NetworthPanelTeamLabel = teamPanel.FindChildTraverse("NetworthPanelTeamLabel")
                if (NetworthPanelTeamLabel)
                {
                    NetworthPanelTeamLabel.text = team_netw.networths
                }
            }
        }

		var localPlayerTeamId = -1;
		var localPlayer = Game.GetLocalPlayerInfo();
		if (localPlayer) {
			localPlayerTeamId = localPlayer.player_team_id;
		}
		teamPanel.SetHasClass("local_player_team", localPlayerTeamId == teamId);
		teamPanel.SetHasClass("not_local_player_team", localPlayerTeamId != teamId);
        if (Game.GetMapInfo().map_display_name == "rating_duo" || Game.GetMapInfo().map_display_name == "rating_duo_300")
        {
            teamPanel.SetHasClass("set_team_networth_visible", GameUI.IsAltDown());
        }
        else
        {
            teamPanel.SetHasClass("team_fast_close_networth", true);
        }
		var teamPlayers = Game.GetPlayerIDsOnTeam(teamId)
		var playersContainer = teamPanel.FindChildInLayoutFile("PlayersContainer");
        let team_is_lose = true
        let team_counter_alive = 0
		if (playersContainer) 
        {
			for (var playerId of teamPlayers) 
            {
				_ScoreboardUpdater_UpdatePlayerPanel(scoreboardConfig, playersContainer, playerId, localPlayerTeamId, teamPanel, teamId)
                var playerInfo = Game.GetPlayerInfo(playerId);
                if (playerInfo && playerInfo.player_respawn_seconds <= 100)
                {
                    team_is_lose = false   
                    team_counter_alive = team_counter_alive + 1
                }
			}
		}
        teamPanel.SetHasClass("team_lose", team_is_lose);
		teamPanel.SetHasClass("no_players", (teamPlayers.length == 0))
		teamPanel.SetHasClass("one_player", (teamPlayers.length == 1))
        teamPanel.SetHasClass("one_player_alive", (team_counter_alive == 1))
		if (teamsInfo.max_team_players < teamPlayers.length) {
			teamsInfo.max_team_players = teamPlayers.length;
		}
		if (GameUI.CustomUIConfig().team_colors) {
			var teamColor = GameUI.CustomUIConfig().team_colors[teamId];
			var teamColorPanel = teamPanel.FindChildInLayoutFile("TeamColor");
			teamColor = teamColor.replace(";", "");
			if (teamColorPanel) {
				teamNamePanel.style.backgroundColor = teamColor + ";";
			}
			var teamColor_GradentFromTransparentLeft = teamPanel.FindChildInLayoutFile("TeamColor_GradentFromTransparentLeft");
			if (teamColor_GradentFromTransparentLeft) {
				var gradientText = teamColor
				teamColor_GradentFromTransparentLeft.style.backgroundColor = gradientText;
			}
		}
		return teamPanel;
	} else {
		if (!containerPanel)
			return;
		let custompicktable = ScoreboardGetCustomTable("custom_pick", "pick_state")
		if (custompicktable && custompicktable.in_progress) {
			return
		} 
		var teamId = teamDetails.team_id;

		var teamPlayers = Game.GetPlayerIDsOnTeam(teamId)

		for (var playerId of teamPlayers) 
		{
			var teamPanelName = "_dynamic_team_" + teamId + playerId;
			var teamPanel = containerPanel.FindChild(teamPanelName);

			if (teamPanel === null) 
			{
				teamPanel = $.CreatePanel("Panel", containerPanel, teamPanelName);
				teamPanel.SetAttributeInt("team_id", teamId);
				teamPanel.BLoadLayout(scoreboardConfig.teamXmlName, false, false);
				var logo_xml = GameUI.CustomUIConfig().team_logo_xml;
				if (logo_xml) 
				{
					var teamLogoPanel = teamPanel.FindChildInLayoutFile("TeamLogo");
					if (teamLogoPanel) {
						teamLogoPanel.SetAttributeInt("team_id", teamId);
						teamLogoPanel.BLoadLayout(logo_xml, false, false);
					}
				}
			}

			var localPlayerTeamId = -1;

			var localPlayer = Game.GetLocalPlayerInfo();

			if (localPlayer) 
			{
				localPlayerTeamId = localPlayer.player_team_id;
			}

			teamPanel.SetHasClass("local_player_team", Players.GetLocalPlayer() == playerId);
			teamPanel.SetHasClass("not_local_player_team", Players.GetLocalPlayer() != playerId);

			var playersContainer = teamPanel.FindChildInLayoutFile("PlayersContainer");

			_ScoreboardUpdater_UpdatePlayerPanel(scoreboardConfig, playersContainer, playerId, localPlayerTeamId, teamPanel, teamId)

			teamPanel.SetHasClass("no_players", (teamPlayers.length == 0))
			teamPanel.SetHasClass("one_player", (teamPlayers.length == 1))

			if (teamsInfo.max_team_players < teamPlayers.length) 
			{
				teamsInfo.max_team_players = teamPlayers.length;
			}

            teamPanel.SetHasClass("team_fast_close_networth", true);

			if (GameUI.CustomUIConfig().team_colors) 
			{
				var teamColor = GameUI.CustomUIConfig().team_colors[teamId];
				var teamColorPanel = teamPanel.FindChildInLayoutFile("TeamColor");
				teamColor = teamColor.replace(";", "");
				if (teamColorPanel) {
					teamNamePanel.style.backgroundColor = teamColor + ";";
				}
				var teamColor_GradentFromTransparentLeft = teamPanel.FindChildInLayoutFile("TeamColor_GradentFromTransparentLeft");
				if (teamColor_GradentFromTransparentLeft) {
					var gradientText = teamColor
					teamColor_GradentFromTransparentLeft.style.backgroundColor = gradientText;
				}
			}
		}
	}
}

function _ScoreboardUpdater_ReorderTeam(scoreboardConfig, teamsParent, teamPanel, teamId, newPlace, prevPanel) {
	var oldPlace = null;
	if (GameUI.CustomUIConfig().teamsPrevPlace.length > teamId) {
		oldPlace = GameUI.CustomUIConfig().teamsPrevPlace[teamId];
	}
	GameUI.CustomUIConfig().teamsPrevPlace[teamId] = newPlace;
	if (newPlace != oldPlace) {
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
	if (Game.GetMapInfo().map_display_name == "overthrow")
	{
		if ( a.team_score < b.team_score )
		{
			return 1; // [ B, A ]
		}
		else if ( a.team_score > b.team_score )
		{
			return -1; // [ A, B ]
		}
		else
		{
			return 0;
		}
	}
    const teamPlayers_a = Game.GetPlayerIDsOnTeam(a.team_id), teamPlayers_b = Game.GetPlayerIDsOnTeam(b.team_id)
	if (teamPlayers_a.length === 0 && teamPlayers_b.length === 0)
    {
        return 0
    }
	if (teamPlayers_a.length !== 0 && teamPlayers_b.length === 0)
    {
        return -1
    }
	if (teamPlayers_a.length === 0 && teamPlayers_b.length !== 0)
    {
        return 1
    }
	    
	let table, table2

	for (let playerId of teamPlayers_a)
    {
        table = GameUI.CustomUIConfig().DATA_TABLE_SERVER["playernetworths"][String(playerId)] || table
    }
	for (let playerId of teamPlayers_b)
    {
        table2 = GameUI.CustomUIConfig().DATA_TABLE_SERVER["playernetworths"][String(playerId)] || table2
    }

    if (Game.GetMapInfo().map_display_name == "rating_duo" || Game.GetMapInfo().map_display_name == "rating_duo_300")
    {
        table = GameUI.CustomUIConfig().DATA_TABLE_SERVER["playernetworths_team"][String(a.team_id)] || table
        table2 = GameUI.CustomUIConfig().DATA_TABLE_SERVER["playernetworths_team"][String(b.team_id)] || table2
    }
 
	let gold1 = 1, gold2 = 1

	if (table) 
    {
	    gold1 = table.networths
	}
	if (table2) 
    {
	    gold2 = table2.networths
	}

	if (gold1 < gold2)
    {
        return 1
    }
	if (gold1 > gold2)
    {
        return -1
    }
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

function _ScoreboardUpdater_UpdateAllTeamsAndPlayers(scoreboardConfig, teamsContainer) {
	var teamsList = [];

	for (var teamId of Game.GetAllTeamIDs()) 
	{
		teamsList.push(Game.GetTeamDetails(teamId));
	}

	var teamsInfo = 
	{
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
			if ((playerInfo)) {
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

function ScoreboardUpdater_InitializeScoreboard(scoreboardConfig, scoreboardPanel) {
	GameUI.CustomUIConfig().teamsPrevPlace = [];
	if (typeof(scoreboardConfig.shouldSort) === 'undefined') {
		scoreboardConfig.shouldSort = true;
	}
	_ScoreboardUpdater_UpdateAllTeamsAndPlayers(scoreboardConfig, scoreboardPanel);
	return {
		"scoreboardConfig": scoreboardConfig,
		"scoreboardPanel": scoreboardPanel
	}
}

function ScoreboardUpdater_SetScoreboardActive(scoreboardHandle, isActive) {
	if (scoreboardHandle.scoreboardConfig === null || scoreboardHandle.scoreboardPanel === null) {
		return;
	}

	if (isActive) {
		_ScoreboardUpdater_UpdateAllTeamsAndPlayers(scoreboardHandle.scoreboardConfig, scoreboardHandle.scoreboardPanel);
	}
}

function ScoreboardUpdater_GetTeamPanel(scoreboardHandle, teamId) {
	if (scoreboardHandle.scoreboardPanel === null) {
		return;
	}

	var teamPanelName = "_dynamic_team_" + teamId;
	return scoreboardHandle.scoreboardPanel.FindChild(teamPanelName);
}

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


function GetLevelByCoins(coins) {
	let full_sum = 0
	let level_end = 30
	for (var cc = 0; cc <= Object.keys(levels).length; cc++) {
		full_sum = full_sum + levels[cc]
		if (coins < full_sum) {
			level_end = cc - 1
			break
		}
	}
	return level_end
}

function GetHeroInformation(hero, id) {
	let woda_player_data = ScoreboardGetCustomTable("woda_player_data", String(id))
	if (woda_player_data && woda_player_data.heroes_level) {
		for (var i = 1; i <= Object.keys(woda_player_data.heroes_level).length; i++) {
			if (woda_player_data.heroes_level[i]["hero"] == hero) {
				return woda_player_data.heroes_level[i]
			}
		}
	}
	return null
}

function GetHeroRankIcon(level) 
{
	if (level >= 30) {
		return "6"
	} else if (level >= 25) {
		return "5"
	} else if (level >= 18) {
		return "4"
	} else if (level >= 12) {
		return "3"
	} else if (level >= 6) {
		return "2"
	} else if (level >= 1) {
		return "1"
	} else {
		return "0"
	}
}

GameEvents.Subscribe_custom( 'comeback_system_update', comeback_system_update ); 

function comeback_system_update(data)
{
    if (data && data.info)
    {
        for (var i = 0; i < Object.keys(data.info).length; i++) 
        {
            let player_id = Object.keys(data.info)[i]
            let percent = data.info[player_id]
            let player_panel = $.GetContextPanel().FindChildTraverse("_dynamic_player_"+player_id)
            if (player_panel)
            {
                let DamageComeback = player_panel.FindChildTraverse("DamageComeback")
                if (DamageComeback)
                {
                    if (percent > 0)
                    {
                        DamageComeback.text = "+" + percent + "%"
                    } 
                    else 
                    {
                        DamageComeback.text = percent + "%"
                    }
                    if (Number(percent) != 0 && data.duel == 0)
                    {
                        if (percent > 0)
                        {
                            DamageComeback.SetHasClass("GreenComeback", true)
                            DamageComeback.SetHasClass("RedComeback", false)
                        }
                        else if (percent <= 0)
                        {
                            DamageComeback.SetHasClass("GreenComeback", false)
                            DamageComeback.SetHasClass("RedComeback", true)
                        }
                    } else {
                        DamageComeback.SetHasClass("GreenComeback", false)
                        DamageComeback.SetHasClass("RedComeback", false)
                    }
                }
            }
        }
    }
}