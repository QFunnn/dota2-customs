--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameEvents.Subscribe_custom("notification_duel_lose", notification_duel_lose)

function notification_duel_lose(data) {
	var player = Game.GetPlayerInfo(data.id)
	if (player) {
		let notification = $.CreatePanel("Panel",$("#notification"), "")
		notification.AddClass("notification_duel_lose")
		$.Schedule(0.4, function() {
			notification.style.opacity = "1"
		})
		let hero = $.CreatePanel("Panel", notification, "")
		hero.AddClass("heroicon")
		hero.style.backgroundImage = 'url( "file://{images}/heroes/icons/' + data.heroname + '.png" );'
		hero.style.backgroundSize = "100%"
		let label = $.CreatePanel("Label", notification, "")
		label.html = true
		let color = "white"
		if ( GameUI.CustomUIConfig().team_colors ) {
			var teamColor = GameUI.CustomUIConfig().team_colors[player.player_team_id]
			if (teamColor) {
				color = teamColor
			}
		}
		label.AddClass("label_duel_lose")
		label.text = "<font color='" + color + "'>" + player.player_name + "</font>" + " " + $.Localize("#duel_lose")
		$.Schedule(6.5, function() {
			notification.style.opacity = "0"
		})
		notification.DeleteAsync(7.4)
	}
}

GameEvents.Subscribe_custom("notification_boss_spawn", notification_boss_spawn)

function notification_boss_spawn(data) {
	let notification = $.CreatePanel("Panel",$("#notification"), "")
	notification.AddClass("notification_duel_lose")
	$.Schedule(0.4, function() {
		notification.style.opacity = "1"
	})
	$.CreatePanel("DOTAEmoticon", notification, "", { emoticonid:`19`, style:"width:30px;height:30px;vertical-align:center;margin-right:6px;margin-bottom:4px;" });
	let label = $.CreatePanel("Label", notification, "")
	label.html = true
	let color = "#cd0000"
	label.AddClass("label_duel_lose")
	if (data.appear == "true") {
		label.text = "<font color='" + color + "'>" + $.Localize("#bossspawn1") + "</font>" + " " + $.Localize("#bossspawn2")
	}	else {
		label.text = "<font color='" + color + "'>" + $.Localize("#bossspawn1") + "</font>" + " " + $.Localize("#bossspawn3")
	}
	$.Schedule(6.5, function() {
		notification.style.opacity = "0"
	})
	notification.DeleteAsync(7.4) 
}

GameEvents.Subscribe_custom("notification_player_hunt", notification_player_hunt)

function notification_player_hunt(data) {
	let notification = $.CreatePanel("Panel",$("#notification"), "")
	notification.AddClass("notification_duel_lose")
	$.Schedule(0.4, function() {
		notification.style.opacity = "1"
	})
	$.CreatePanel("DOTAEmoticon", notification, "", { emoticonid:`175`, style:"width:30px;height:30px;vertical-align:center;margin-right:6px;margin-bottom:4px;" });
	let label = $.CreatePanel("Label", notification, "")
	label.html = true
	let color = "#5cae16"
	label.AddClass("label_duel_lose")
	label.text = "<font color='" + color + "'>" + $.Localize("#playerhunt1") + "</font>" + " " + $.Localize("#playerhunt3")
	$.Schedule(6.5, function() {
		notification.style.opacity = "0"
	})
	notification.DeleteAsync(7.4) 
}


GameEvents.Subscribe_custom("notification_no_data_server", notification_no_data_server)

function notification_no_data_server(data) 
{
	let notification = $.CreatePanel("Panel",$("#notification"), "")
	notification.AddClass("notification_duel_lose")
	$.Schedule(0.4, function() {
		notification.style.opacity = "1"
	})
	$.CreatePanel("DOTAEmoticon", notification, "", { emoticonid:`340`, style:"width:30px;height:30px;vertical-align:center;margin-right:6px;margin-bottom:4px;" });
	let label = $.CreatePanel("Label", notification, "")
	label.html = true
	let color = "red"
	label.AddClass("label_duel_lose")
	label.style.textAlign = "center"

	if (data.server == "true") 
	{
		label.text = "<font color='" + color + "'>" + $.Localize("#player_connect_no_data") + "</font>"
	}	else {
		label.text = "<font color='" + color + "'>" + $.Localize("#player_connect_no_8") + "</font>"
	}

	$.Schedule(6.5, function() {
		notification.style.opacity = "0"
	})
	notification.DeleteAsync(7.4) 
}



GameEvents.Subscribe_custom("notification_pve_players_hard", notification_pve_players_hard)

function notification_pve_players_hard(data) 
{
	let notification = $.CreatePanel("Panel",$("#notification"), "")
	notification.AddClass("notification_duel_lose_pve")
	$.Schedule(0.4, function() {
		notification.style.opacity = "1"
	})
	$.CreatePanel("DOTAEmoticon", notification, "", { emoticonid:`146`, style:"width:30px;height:30px;vertical-align:center;margin-right:6px;margin-bottom:4px;" });
	let label = $.CreatePanel("Label", notification, "")
	label.html = true
	let color = "gold"
	label.AddClass("label_duel_lose")
	label.style.textAlign = "center"

	if (data.player == 1)
	{
		label.text = "<font color='" + color + "'>" + $.Localize("#notification_pve_players_hard_1") + "</font>"
	} else if (data.player == 2)
	{
		label.text = "<font color='" + color + "'>" + $.Localize("#notification_pve_players_hard_2") + "</font>"
	} else if (data.player == 3)
	{
		label.text = "<font color='" + color + "'>" + $.Localize("#notification_pve_players_hard_3") + "</font>"
	} else if (data.player == 4)
	{
		label.text = "<font color='" + color + "'>" + $.Localize("#notification_pve_players_hard_4") + "</font>"
	}

	$.Schedule(6.5, function() {
		notification.style.opacity = "0"
	})
	notification.DeleteAsync(7.4) 
}



GameEvents.Subscribe_custom("notification_player_ban_die", notification_player_ban_die)
function notification_player_ban_die(data) 
{
	let notification = $.CreatePanel("Panel",$("#notification"), "")
	notification.AddClass("notification_die")
	$.Schedule(0.4, function() {
		notification.style.opacity = "1"
	})
	$.CreatePanel("DOTAEmoticon", notification, "", { emoticonid:`101`, style:"width:30px;height:30px;vertical-align:center;margin-right:6px;margin-bottom:4px;" });
	let label = $.CreatePanel("Label", notification, "")
	label.html = true
	let color = "red"
	label.AddClass("label_duel_lose")
	label.style.textAlign = "center"

	label.text = "<font color='" + color + "'>" + $.Localize("#player_banned_die") + "</font>"

	$.Schedule(6.5, function() {
		notification.style.opacity = "0"
	})
	notification.DeleteAsync(7.4) 
}


GameEvents.Subscribe_custom("notification_free_disconnect", notification_free_disconnect)
function notification_free_disconnect(data) 
{
	let notification = $.CreatePanel("Panel",$("#notification"), "")
	notification.AddClass("notification_duel_lose")
	$.Schedule(0.4, function() {
		notification.style.opacity = "1"
	})
	$.CreatePanel("DOTAEmoticon", notification, "", { emoticonid:`171`, style:"width:30px;height:30px;vertical-align:center;margin-right:6px;margin-bottom:4px;" });
	let label = $.CreatePanel("Label", notification, "")
	label.html = true
	let color = "red"
	label.AddClass("label_duel_lose")
	label.style.textAlign = "center"

    if (data.rating == 1)
    {
        label.text = "<font color='" + color + "'>" + $.Localize("#is_game_free_disconnect_low_rating_detected") + "</font>"
    }
    else if (data.lose == 1)
    {
        label.text = "<font color='" + color + "'>" + $.Localize("#is_game_free_disconnect_team_detected") + "</font>"
    }
    else
    {
        label.text = "<font color='" + color + "'>" + $.Localize("#is_game_free_disconnect") + "</font>"
    }

	$.Schedule(6.5, function() {
		notification.style.opacity = "0"
	})
	notification.DeleteAsync(7.4) 
}

GameEvents.Subscribe_custom("notification_duel_lose_duo", notification_duel_lose_duo)

function notification_duel_lose_duo(data) 
{
	var player = Game.GetPlayerInfo(data.id)
	if (player) 
    {
		let notification = $.CreatePanel("Panel",$("#NotificationDuo"), "")
		notification.AddClass("notification_duel_lose_duo")
		$.Schedule(0.4, function() {
			notification.style.opacity = "1"
		})
		let hero = $.CreatePanel("Panel", notification, "")
		hero.AddClass("heroicon")
		hero.style.backgroundImage = 'url( "file://{images}/heroes/icons/' + data.heroname + '.png" );'
		hero.style.backgroundSize = "100%"
		let label = $.CreatePanel("Label", notification, "")
		label.html = true
		let color = "white"
		if ( GameUI.CustomUIConfig().team_colors ) {
			var teamColor = GameUI.CustomUIConfig().team_colors[player.player_team_id]
			if (teamColor) {
				color = teamColor
			}
		}
		label.AddClass("label_duel_lose")
		label.text = "<font color='" + color + "'>" + player.player_name + "</font>" + " " + $.Localize("#duel_lose")
		$.Schedule(6.5, function() {
			notification.style.opacity = "0"
		})
		notification.DeleteAsync(7.4)
	}
}

GameEvents.Subscribe_custom("notification_team_has_been_killed_boss", notification_team_has_been_killed_boss)

function notification_team_has_been_killed_boss(data) 
{
	var player = Game.GetPlayerInfo(data.id)
	if (player) 
    {
		let notification = $.CreatePanel("Panel",$("#NotificationDuo"), "")
		notification.AddClass("notification_duel_lose_duo")
		$.Schedule(0.4, function() {
			notification.style.opacity = "1"
		})
		let hero = $.CreatePanel("Panel", notification, "")
		hero.AddClass("heroicon")
		hero.style.backgroundImage = 'url( "file://{images}/heroes/icons/' + data.heroname + '.png" );'
		hero.style.backgroundSize = "100%"
		let label = $.CreatePanel("Label", notification, "")
		label.html = true
		let color = "white"
		if ( GameUI.CustomUIConfig().team_colors ) {
			var teamColor = GameUI.CustomUIConfig().team_colors[player.player_team_id]
			if (teamColor) {
				color = teamColor
			}
		}
		label.AddClass("label_duel_lose")
		label.text = "<font color='" + color + "'>" + player.player_name + "</font>" + " " + $.Localize("#kill_boss")
		$.Schedule(6.5, function() {
			notification.style.opacity = "0"
		})
		notification.DeleteAsync(7.4)
	}
}

GameEvents.Subscribe_custom("notification_tournament_data", notification_tournament_data)

function notification_tournament_data(data) 
{
	let notification = $.CreatePanel("Panel",$("#notification"), "")
	notification.AddClass("notification_duel_lose_pve")
	$.Schedule(0.4, function() 
    {
		notification.style.opacity = "1"
	})
	$.CreatePanel("DOTAEmoticon", notification, "", { emoticonid:`168`, style:"width:30px;height:30px;vertical-align:center;margin-right:6px;margin-bottom:4px;" });
	let label = $.CreatePanel("Label", notification, "")
	label.html = true
	let color = "gold"
	label.AddClass("label_duel_lose")
	label.style.textAlign = "center"

    if (data.random)
    {
        label.text = $.Localize("#tournament_ban_in_game") + " " + "<font color='" + color + "'>" + data.bans + "</font><br>" + $.Localize("#tournament_is_random_mode")
    }
    else
    {
        label.text = $.Localize("#tournament_ban_in_game") + " " + "<font color='" + color + "'>" + data.bans + "</font>"
    }

	$.Schedule(6.5, function() 
    {
		notification.style.opacity = "0"
	})
	notification.DeleteAsync(7.4) 
}

GameEvents.Subscribe_custom("notification_tournament_game", notification_tournament_game)

function notification_tournament_game(data) 
{
	let notification = $.CreatePanel("Panel",$("#notification"), "")
	notification.AddClass("notification_duel_lose_pve")
	$.Schedule(0.4, function() 
    {
		notification.style.opacity = "1"
	})
	$.CreatePanel("DOTAEmoticon", notification, "", { emoticonid:`168`, style:"width:30px;height:30px;vertical-align:center;margin-right:6px;margin-bottom:4px;" });
	let label = $.CreatePanel("Label", notification, "")
	label.html = true
	let color = "gold"
	label.AddClass("label_duel_lose")
	label.style.textAlign = "center"
    label.text = $.Localize("#tournament_is_tournament_game_mode")

	$.Schedule(6.5, function() 
    {
		notification.style.opacity = "0"
	})
	notification.DeleteAsync(7.4) 
}