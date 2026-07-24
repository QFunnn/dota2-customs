--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameEvents.Subscribe_custom('SendSettingsChange', GetSettingsChange)

function window_init()
{
	var player_stats = $.GetContextPanel().FindChildTraverse("info_button_player_stats")
	var hero_stats = $.GetContextPanel().FindChildTraverse("info_button_achivments")
	var gamelist = $.GetContextPanel().FindChildTraverse("info_button_gamelist")		
	var settings = $.GetContextPanel().FindChildTraverse("info_button_settings")	
	var info_window = $.GetContextPanel().FindChildTraverse("window_info")
	player_stats.SetPanelEvent("onactivate", function() 
	{	
		init_player_stats(false)
	});
	hero_stats.SetPanelEvent("onactivate", function() 
	{	
		init_achivments()
	});
	gamelist.SetPanelEvent("onactivate", function() 
	{	
		init_gamelist()
	});
	settings.SetPanelEvent("onactivate", function() 
	{	
		init_settings();
	});

	init_player_stats(true)

	var player_icon = $.GetContextPanel().FindChildTraverse("button_icon_1")
    player_icon.steamid = Game.GetPlayerInfo( Players.GetLocalPlayer() ).player_steamid

	var heroes = CustomNetTables.GetTableValue("players_heroes",  Players.GetLocalPlayer());
	var hero = heroes.hero

}
function Info_window_show()
{
    if (cd) { return }
    Game.EmitSound("UI.Info_Open")
    cd = true
    var info_button = $.GetContextPanel().FindChildTraverse("info_button")
    var leaderbord_button = $.GetContextPanel().FindChildTraverse("leaderbord_button")
    var shop_button = $.GetContextPanel().FindChildTraverse("shop_button")
    var info_window = $.GetContextPanel().FindChildTraverse("window_info")
    var leaderbord_window = $.GetContextPanel().FindChildTraverse("leaderbord_window")
    var shop_window = $.GetContextPanel().FindChildTraverse("window_shop")

    info_button.AddClass("button_active")
    leaderbord_button.RemoveClass("button_active")
    shop_button.RemoveClass("button_active")

    var close_button = $.GetContextPanel().FindChildTraverse("close_button")

    if (leaderbord_window.BHasClass("leaderbord_window_show"))
    {
        leaderbord_window.RemoveClass("leaderbord_window_show")
        leaderbord_window.AddClass("leaderbord_window_hidden")

        leaderbord_button.SetPanelEvent("onactivate", function() 
        {	
            leaderbord_window_show()
        });
    }
    if (shop_window.BHasClass("shop_window_show"))
    {
        shop_window.RemoveClass("shop_window_show")
        shop_window.AddClass("shop_window_hidden")

        shop_button.SetPanelEvent("onactivate", function() 
        {	
            GameUI.CustomUIConfig().OpenShop()
        });
    }
    info_window.RemoveClass("info_window_hidden")
    info_window.AddClass("info_window_show")
    info_button.SetPanelEvent("onactivate", function() 
    {	
        Info_window_hide()
    });
    close_button.SetPanelEvent("onactivate", function() 
    {	
        Info_window_hide()
    });
    init_player_stats(true)
    $.Schedule(0.5, function ()
    {
        cd = false

    })
    if (first_time == false)
    {
        window_init()
        first_time = true
    }
}

function Info_window_hide()
{
	if (cd) { return }
    cd = true
    Game.EmitSound("UI.Info_Close")
    var info_button = $.GetContextPanel().FindChildTraverse("info_button")
    var info_window = $.GetContextPanel().FindChildTraverse("window_info")

    info_button.RemoveClass("button_active")

    info_window.RemoveClass("info_window_show")
    info_window.AddClass("info_window_hidden")
    info_button.SetPanelEvent("onactivate", function() 
    {	
        Info_window_show()
    });
    $.Schedule(0.5, function ()
    {
        cd = false
    })
}

function clear_window(button)
{
	var content = $.GetContextPanel().FindChildTraverse("info_window_content")
	var content_clearing = $.GetContextPanel().FindChildTraverse("content_clearing")

	if (content_clearing)
	{
		content_clearing.DeleteAsync(0)
	}
	var player_stats = $.GetContextPanel().FindChildTraverse("info_button_player_stats")
	var achivments = $.GetContextPanel().FindChildTraverse("info_button_achivments")	
	var gamelist = $.GetContextPanel().FindChildTraverse("info_button_gamelist")	
	var settings = $.GetContextPanel().FindChildTraverse("info_button_settings")	
	player_stats.RemoveClass("window_info_button_chosen")
	achivments.RemoveClass("window_info_button_chosen")
	gamelist.RemoveClass("window_info_button_chosen")
	settings.RemoveClass("window_info_button_chosen")
	button.AddClass("window_info_button_chosen")
}


function init_player_stats(auto)
{
	if (chosen_label == 1) {return}
	chosen_label = 1
	if (auto === false)
	{
		Game.EmitSound("UI.Click_Hero")
	}


	var number = 0
	var text = ''
	var server_data = CustomNetTables.GetTableValue("server_data",  Game.GetLocalPlayerID().toString());
	var medal_number = server_data.ranked_tier // Math.floor(server_data.rank_tier / 10)
	var calibration_games = server_data.competitive_calibration_games_remaining
	var rating = 1000
	var stat_total_games = 0
	var stats_player_places = [0,0,0,0,0,0]
	var best_hero = null
	if (server_data !== undefined )
	{
		rating = String(server_data.rating)
		stat_total_games = String(server_data.total_games)
		stats_player_places = server_data.places
		best_hero = server_data.favorite_hero
	}
	var leaderboard = CustomNetTables.GetTableValue("leaderboard", "leaderboard");
	var rating_50 = 999999
	var rating_10 = 999999
	var rating_1 = 999999
	if (leaderboard != undefined)
	{
		if (leaderboard[50] != undefined)
		{
			rating_50 = leaderboard[50].rating
		}
		if (leaderboard[10] != undefined)
		{
			rating_10 = leaderboard[10].rating
		}
		if (leaderboard[1] != undefined)
		{
			rating_1 = leaderboard[1].rating
		}
	}
	if (rating >= rating_1)
	{
		medal_number = 10
	}else 
		{
		if (rating >= rating_10)
		{
			medal_number = 9
		}else 
			{
			if (rating >= rating_50)
			{
				medal_number = 8
			}
		}
	}
	var total_games = 0
	var max = 0
	var score = 0
	var avg_place = 0
	for (var i = 0; i < 6; i++) 
	{

		if (stats_player_places[i] >= max)
		{
			max = stats_player_places[i]
		}
		total_games = total_games + stats_player_places[i]
		score = stats_player_places[i]*(i+1) + score
	}
	if (total_games > 0 )
	{
		avg_place = score/total_games
	}

	var heroes = CustomNetTables.GetTableValue("players_heroes",  Players.GetLocalPlayer());
	var hero = heroes.hero

	var player_stats = $.GetContextPanel().FindChildTraverse("info_button_player_stats")
	clear_window(player_stats)

	var content = $.GetContextPanel().FindChildTraverse("info_window_content")
	var content_clearing =  $.CreatePanel("Panel",content,"content_clearing")
	content_clearing.AddClass("content_clearing")

	var player_stats_top_content = $.CreatePanel("Panel", content_clearing, "")
	player_stats_top_content.AddClass("player_stats_top_content")

	var player_stats_top_left = $.CreatePanel("Panel", player_stats_top_content, "")
	player_stats_top_left.AddClass("player_stats_top_content_panel")

	var player_stats_top_right = $.CreatePanel("Panel", player_stats_top_content, "")
	player_stats_top_right.AddClass("player_stats_top_content_panel")

	var player_stats_top_button_left = $.CreatePanel("Panel",player_stats_top_left,"")
	player_stats_top_button_left.AddClass("player_stats_top_button")
	player_stats_top_button_left.AddClass("player_stats_top_button_selected")

	var player_stats_top_content_left = $.CreatePanel("Panel",player_stats_top_left,"")
	player_stats_top_content_left.AddClass("player_stats_top_content_tempo")

	var player_name = $.CreatePanel("Label",player_stats_top_button_left,"")
	player_name.AddClass("player_name")
	player_name.text = Players.GetPlayerName(Game.GetLocalPlayerID())

	var player_icon_panel = $.CreatePanel("Panel",player_stats_top_button_left,"")
	player_icon_panel.AddClass("player_icon_panel")

	var player_icon = $.CreatePanel("DOTAAvatarImage",player_icon_panel,"")
	player_icon.style.width = "100%"
    player_icon.style.height = "100%"
    player_icon.steamid = Game.GetPlayerInfo( Players.GetLocalPlayer() ).player_steamid

	var player_stats_top_button_right = $.CreatePanel("Panel",player_stats_top_right,"")
	player_stats_top_button_right.AddClass("player_stats_top_button")

	var hero_name = $.CreatePanel("Label",player_stats_top_button_right,"")
	hero_name.AddClass("player_name")
	hero_name.AddClass("player_name_hero")
	hero_name.text = $.Localize('#' + hero)

	var hero_icon = $.CreatePanel("Panel",player_stats_top_button_right,"")
	hero_icon.AddClass("hero_icon")
	hero_icon.style.backgroundImage = "url('file://{images}/heroes/" + Game.GetHeroImage(Players.GetLocalPlayer(), hero) + ".png')"
	hero_icon.style.backgroundSize = "contain"

	var text_label_1 = $.CreatePanel("Panel",player_stats_top_content_left,"text_label_1")
	text_label_1.AddClass("text_label")

	var text_label_2 = $.CreatePanel("Panel",player_stats_top_content_left,"text_label_2")
	text_label_2.AddClass("text_label")

	var text_label_3 = $.CreatePanel("Panel",player_stats_top_content_left,"text_label_3")
	text_label_3.AddClass("text_label")

	var text_label_4 = $.CreatePanel("Panel",player_stats_top_content_left,"text_label_4")
	text_label_4.AddClass("text_label")

	var text_1 = $.CreatePanel("Label",text_label_1,"text_1")
	text_1.AddClass("simple_text")
    text_1.text = $.Localize("#total_games") + '  ' + stat_total_games

	var text_2 = $.CreatePanel("Label",text_label_2,"text_2")
	text_2.AddClass("simple_text")

	var medal = $.CreatePanel("Label",text_label_2,"text_2")
	medal.AddClass("rank_medal")

	if (calibration_games <= 0)
	{
    	text_2.text = $.Localize("#rating") + '  ' + rating
	}
	else 
	{
    	text_2.text = $.Localize("#rating") + ' ' + $.Localize("#calibration") + ' (' + String(calibration_games)  + ')'
    	medal_number = 0
	}

	medal.AddClass("rank_medal_" + String(medal_number))

	var text_3 = $.CreatePanel("Label",text_label_3,"text_3")
	text_3.AddClass("simple_text")
    text_3.text = $.Localize("#favor_hero")
	var text_4 = $.CreatePanel("Label",text_label_4,"text_4")
	text_4.AddClass("simple_text")
    text_4.text = $.Localize("#Avg_place") + '  ' + String(avg_place.toFixed(1))

    if (avg_place >= 3.5)
    {
		text_4.AddClass("stats_text_color_4")
    }else
		text_4.AddClass("stats_text_color_1")

	var favor_hero = $.CreatePanel("Panel",text_label_3,"favor_hero")
	favor_hero.AddClass("favor_hero")

	if (best_hero != null && best_hero != '')
	{
		favor_hero.style.backgroundImage = "url('file://{images}/heroes/icons/" + best_hero + ".png')"
	}
    favor_hero.style.backgroundSize = "100%";



	var table = Game.GetLocalPlayerID().toString() + '_' + hero
	var hero_data = CustomNetTables.GetTableValue("server_hero_stats", table);

	var stats_hero_places = [0,0,0,0,0,0]
	var total_games_hero = 0
	var rating_hero = 0
	var	kills_hero = 0
	var	death_hero = 0

	if (hero_data !== undefined )
	{
		stats_hero_places = hero_data.places
		rating_hero = hero_data.rating
		kills_hero = hero_data.kills
		death_hero = hero_data.deaths
	}

	var score_hero = 0
	var avg_place_hero = 0

	for (var i = 0; i < 6; i++) 
	{
		total_games_hero = total_games_hero + stats_hero_places[i]
		score_hero = stats_hero_places[i]*(i+1) + score_hero
	}

	if (total_games_hero > 0 )
	{
		avg_place_hero = score_hero/total_games_hero
		if (kills_hero > 0)
		{
			kills_hero = (kills_hero/total_games_hero)
			if (kills_hero%1 !== 0)
				kills_hero = kills_hero
		}

		if (death_hero > 0)
		{
			death_hero = (death_hero/total_games_hero)
			if (death_hero%1 !== 0)
				death_hero = death_hero
		}	
	}

	var kd = kills_hero
	if (death_hero !== 0)
		kd = kills_hero/death_hero

	kd = roundPlus(kd,1)
	kills_hero = roundPlus(kills_hero,1)
	death_hero = roundPlus(death_hero,1)
	avg_place_hero = roundPlus(avg_place_hero,1)


	var player_stats_top_content_right = $.CreatePanel("Panel",player_stats_top_right,"")
	player_stats_top_content_right.AddClass("player_stats_top_content_tempo")

	var text_label_1 = $.CreatePanel("Panel",player_stats_top_content_right,"")
	text_label_1.AddClass("text_label")

	var text_label_2 = $.CreatePanel("Panel",player_stats_top_content_right,"")
	text_label_2.AddClass("text_label")

	var text_label_3 = $.CreatePanel("Panel",player_stats_top_content_right,"")
	text_label_3.AddClass("text_label")

	var text_label_4 = $.CreatePanel("Panel",player_stats_top_content_right,"")
	text_label_4.AddClass("text_label")

	var text_1 = $.CreatePanel("Label",text_label_1,"text_1")
	text_1.AddClass("simple_text")
    text_1.text = $.Localize("#total_games") + '  ' + String(total_games_hero)

	var text_2 = $.CreatePanel("Label",text_label_2,"text_2")
	text_2.AddClass("simple_text")
    text_2.text = $.Localize("#rating")

    if (score_hero >= 0)
	{
		text_2.text = $.Localize("#rating") + ' +' + String(Math.abs(score_hero))
	}
	else
	{
		text_2.text = $.Localize("#rating") + ' -' + String(Math.abs(score_hero))
	}

	var text_3 = $.CreatePanel("Label",text_label_3,"text_2")
	text_3.AddClass("simple_text")
	text_3.text = $.Localize("#k_d") + ' ' + String(kills_hero) + '/' + String(death_hero) + ' (' +  String(kd) + ')'

	var text_4 = $.CreatePanel("Label",text_label_4,"text_4")
	text_4.AddClass("simple_text")
    text_4.text = $.Localize("#Avg_place") + '  ' + String(avg_place_hero)

    if (avg_place_hero >= 3.5)
    {
		text_4.AddClass("stats_text_color_4")
    }else
		text_4.AddClass("stats_text_color_1")


	player_stats_top_button_left.SetPanelEvent("onactivate", function() 
	{	
		Game.EmitSound("UI.Click")
		player_stats_top_button_right.RemoveClass("player_stats_top_button_selected")
		player_stats_top_button_left.AddClass("player_stats_top_button_selected")
		player_stats_top_content_left.RemoveClass("player_stats_top_content_tempo_hidden")
		player_stats_top_content_right.AddClass("player_stats_top_content_tempo_hidden")
		draw_places(stats_player_places, content_clearing)
	});	

	player_stats_top_button_right.SetPanelEvent("onactivate", function() 
	{	
		Game.EmitSound("UI.Click")
		player_stats_top_button_left.RemoveClass("player_stats_top_button_selected")
		player_stats_top_button_right.AddClass("player_stats_top_button_selected")
		player_stats_top_content_right.RemoveClass("player_stats_top_content_tempo_hidden")
		player_stats_top_content_left.AddClass("player_stats_top_content_tempo_hidden")
		draw_places(stats_hero_places, content_clearing)
	});	

	player_stats_top_content_right.AddClass("player_stats_top_content_tempo_hidden")
	draw_places(stats_player_places, content_clearing)
}




function draw_places(places, panel)
{

	var places_label = panel.FindChildTraverse("places_label")
	if (!places_label || places_label == undefined)
	{
		places_label = $.CreatePanel("Panel",panel,"places_label")
		places_label.AddClass("places_label")
	}
	let max = 0
	let total_games = 0

	for (let data in places)
	{
		let places_number = places[data]
		total_games = places_number + total_games

		max = places_number > max ? places_number : max
	}

	for (var i = 1; i <= 6; i++) 
	{

		let place = places_label.FindChildTraverse("place" + i)
		if (!place || place == undefined)
		{
			place = $.CreatePanel("Panel",places_label, "place"+i)
			place.AddClass("place")
		}

		let places_text_block = places_label.FindChildTraverse("places_text_block" + i)
		if (!places_text_block || places_text_block == undefined)
		{
			places_text_block = $.CreatePanel("Panel", place, "places_text_block"+i)
			places_text_block.AddClass("stats_left_text_block")
		}

		let places_text = places_label.FindChildTraverse("places_text" + i)
		if (!places_text || places_text == undefined)
		{
			places_text = $.CreatePanel("Label", places_text_block, "places_text"+i)
			places_text.AddClass("stats_left_place_text")
			places_text.text = String(i)
		}
 
		let places_game = places_label.FindChildTraverse("places_game" + i)
		if (!places_game || places_game == undefined)
		{
			places_game = $.CreatePanel("Panel", place, "places_game"+i)
			places_game.AddClass("stats_left_place_all")
			places_game.AddClass("stats_left_place_"+i)
		}

		let number = 0
		if (max > 0)
		{
			number = (places[i-1]/max)*100
		}	
		number = number + 0.01
		text = String(number) + '%'

		places_game.style.height = text

		let places_game_text = places_label.FindChildTraverse("places_game_text" + i)
		if (!places_game_text || places_game_text == undefined)
		{
			places_game_text = $.CreatePanel("Label", places_game, "places_game_text"+i)
			places_game_text.AddClass("stats_left_game_text")
		}

		places_game_text.text = String(places[i-1])
	}
}


function init_achivments()
{
	if (chosen_label == 2) {return}
	chosen_label = 2

	Game.EmitSound("UI.Click_Hero")

	var button_achivments = $.GetContextPanel().FindChildTraverse("info_button_achivments")
	clear_window(button_achivments)

	var content = $.GetContextPanel().FindChildTraverse("info_window_content")

	var content_clearing =  $.CreatePanel("Panel",content,"content_clearing")
	content_clearing.AddClass("content_clearing")

	let local_id = Game.GetLocalPlayerID()
	let completed = {}
	let achivments = {}

	var achivment_header = $.CreatePanel("Panel", content_clearing, "")
	achivment_header.AddClass("achivment_header")

	var achivment_header_text = $.CreatePanel("Label", achivment_header, "")
	achivment_header_text.AddClass("achivment_header_text")

	var achivment_content = $.CreatePanel("Panel", content_clearing, "")
	achivment_content.AddClass("achivment_content")

	for (key in Game.achivment_table)
	{
		if (key == "completed")
		{
			for (id in Game.achivment_table["completed"])
			{
				if (local_id == Number(id))
				{
					completed = Game.achivment_table["completed"][id]
				}
			}
		}else
			achivments[key] = Game.achivment_table[key]	
	}

	let header_text = $.Localize("#Player_achivments")
	achivment_header_text.text = header_text + ": " + Object.keys(completed).length + "/" + Object.keys(achivments).length


	let last_completed
	for (achivment_id in achivments)
	{
		let data = achivments[achivment_id]
		
		let achivment_panel = $.CreatePanel("Panel", achivment_content, "")
		achivment_panel.AddClass("achivment_panel")

		let show_text = $.Localize("#achivment_disc_" + achivment_id) + $.Localize("#achivment_reward") + data.awardAmount
		if (data.awardType)
			show_text = show_text + $.Localize("#achivment_reward_shards")

		achivment_panel.SetPanelEvent('onmouseover', function() {
	    	$.DispatchEvent('DOTAShowTextTooltip', achivment_panel, show_text)
	    });
	    
		achivment_panel.SetPanelEvent('onmouseout', function() {
	    	$.DispatchEvent('DOTAHideTextTooltip', achivment_panel); 
	    });

		let icon = $.CreatePanel("Panel", achivment_panel, "")
		icon.AddClass("achivment_icon")
		icon.style.backgroundImage = "url('file://{images}/custom_game/icons/mini/achivments/achivment_icon_" + achivment_id + ".png')"
		icon.style.backgroundSize = "100%"

		let text = $.CreatePanel("Label", achivment_panel, "")
		text.AddClass("achivment_text")
		text.text = $.Localize("#achivment_name_" + achivment_id)

		if (completed[achivment_id] == 1)
		{
			achivment_panel.AddClass("achivment_panel_completed")
			icon.AddClass("achivment_icon_completed")

			if (last_completed)
				achivment_content.MoveChildAfter( achivment_panel, last_completed)

			last_completed = achivment_panel
		}
	}
}


function init_gamelist()
{
	if (chosen_label == 3) {return}
	chosen_label = 3

	Game.EmitSound("UI.Click_Hero")

	var server_data = CustomNetTables.GetTableValue("server_data",  Game.GetLocalPlayerID().toString());
	var total_games = 0

	if (server_data !== undefined )
	{
		total_games = String(server_data.total_games)
	}

	var button_gamelist = $.GetContextPanel().FindChildTraverse("info_button_gamelist")
	
	clear_window(button_gamelist)

	var content = $.GetContextPanel().FindChildTraverse("info_window_content")

	var content_clearing =  $.CreatePanel("Panel",content,"content_clearing")
	content_clearing.AddClass("content_clearing")

	var text_label_1 = $.CreatePanel("Panel",content_clearing,"text_label_1")
	text_label_1.AddClass("text_label")
	text_label_1.AddClass("text_label_games")

	var text_2 = $.CreatePanel("Label",text_label_1,"text_2")
	text_2.AddClass("simple_text")
	text_2.AddClass("text_left")
	if (server_data)
	{
    	text_2.text = $.Localize("#50_games") + Object.keys(server_data.player_matches).length + $.Localize("#games")
    }

	var text_1 = $.CreatePanel("Label",text_label_1,"text_1")
	text_1.AddClass("simple_text")
	text_1.AddClass("text_right")
    text_1.text = $.Localize("#total_games") + '  ' + total_games

	var gamelist_stat_info = $.CreatePanel("Panel",content_clearing,"gamelist_stat_info")
	gamelist_stat_info.AddClass("gamelist_stat_info")

	var gamelist_label = $.CreatePanel("Panel",content_clearing,"gamelist_label")
	gamelist_label.AddClass("gamelist_label")

	var gamelist_info_hero = $.CreatePanel("Panel",gamelist_stat_info,"gamelist_info_hero")
	gamelist_info_hero.AddClass("gamelist_stat_info_hero")

	var gamelist_stat_info_hero_text = $.CreatePanel("Label",gamelist_info_hero,"gamelist_stat_info_hero_text")
	gamelist_stat_info_hero_text.AddClass("gamelist_stat_info_text")
    gamelist_stat_info_hero_text.text = $.Localize("#gamelist_hero")

    var gamelist_stat_info_kills = $.CreatePanel("Panel",gamelist_stat_info,"gamelist_stat_info_kills")
	gamelist_stat_info_kills.AddClass("gamelist_stat_info_kills")

	var gamelist_stat_info_kills_text = $.CreatePanel("Label",gamelist_stat_info_kills,"gamelist_stat_info_kills_text")
	gamelist_stat_info_kills_text.AddClass("gamelist_stat_info_text")
    gamelist_stat_info_kills_text.text = $.Localize("#gamelist_kills")

    var gamelist_stat_info_death = $.CreatePanel("Panel",gamelist_stat_info,"gamelist_stat_info_death")
	gamelist_stat_info_death.AddClass("gamelist_stat_info_kills")

	var gamelist_stat_info_death_text = $.CreatePanel("Label",gamelist_stat_info_death,"gamelist_stat_info_death_text")
	gamelist_stat_info_death_text.AddClass("gamelist_stat_info_text")
    gamelist_stat_info_death_text.text = $.Localize("#gamelist_death")

	var gamelist_info_place = $.CreatePanel("Panel",gamelist_stat_info,"gamelist_info_place")
	gamelist_info_place.AddClass("gamelist_stat_info_place")

	var gamelist_stat_info_place_text = $.CreatePanel("Label",gamelist_info_place,"gamelist_stat_info_place_text")
	gamelist_stat_info_place_text.AddClass("gamelist_stat_info_text")
    gamelist_stat_info_place_text.text = $.Localize("#gamelist_place")

	var gamelist_info_rating = $.CreatePanel("Panel",gamelist_stat_info,"gamelist_info_rating")
	gamelist_info_rating.AddClass("gamelist_stat_info_rating")

	var gamelist_stat_info_rating_text = $.CreatePanel("Label",gamelist_info_rating,"gamelist_stat_info_rating_text")
	gamelist_stat_info_rating_text.AddClass("gamelist_stat_info_text")
    gamelist_stat_info_rating_text.text = $.Localize("#gamelist_rating")

	var gamelist_info_time = $.CreatePanel("Panel",gamelist_stat_info,"gamelist_info_time")
	gamelist_info_time.AddClass("gamelist_stat_info_time")

	var gamelist_stat_info_time_text = $.CreatePanel("Label",gamelist_info_time,"gamelist_stat_info_time_text")
	gamelist_stat_info_time_text.AddClass("gamelist_stat_info_text")
    gamelist_stat_info_time_text.text = $.Localize("#gamelist_time")

	var gamelist_info_date = $.CreatePanel("Panel",gamelist_stat_info,"gamelist_info_date")
	gamelist_info_date.AddClass("gamelist_stat_info_date")

	var gamelist_stat_info_date_text = $.CreatePanel("Label",gamelist_info_date,"gamelist_stat_info_date_text")
	gamelist_stat_info_date_text.AddClass("gamelist_stat_info_text")
    gamelist_stat_info_date_text.text = $.Localize("#gamelist_date")

	if (server_data == undefined )
	{
		return
	}

	var gamelist_player_label
	var gamelist_player_hero_icon
	var gamelist_player_hero
	var gamelist_player_skill_icon
	var gamelist_player_skill

	var gamelist_player_kills
	var gamelist_player_death
	var gamelist_player_kills_text
	var gamelist_player_death_text
	var gamelist_player_place
	var gamelist_player_place_text
	var gamelist_player_rating
	var gamelist_player_rating_text
	var gamelist_player_duration
	var gamelist_player_duration_text
	var gamelist_player_items
	var gamelist_player_items_row_1
	var gamelist_player_items_row_2
	var gamelist_player_items_array = [] 
	var gamelist_player_date_text
	var gamelist_player_year_text
	var gamelist_player_date

	for (var i = 1; i <= Object.keys(server_data.player_matches).length; i++) 
	{
		gamelist_player_label = $.CreatePanel("Panel",gamelist_label,"gamelist_player_label"+i)
		gamelist_player_label.AddClass("gamelist_player_label")

		gamelist_player_hero = $.CreatePanel("Panel",gamelist_player_label,"gamelist_player_hero"+i)
		gamelist_player_hero.AddClass("gamelist_player_hero_skill")

		gamelist_player_skill = $.CreatePanel("Panel",gamelist_player_label,"gamelist_player_skill"+i)
		gamelist_player_skill.AddClass("gamelist_player_hero_skill")


		gamelist_player_hero_icon = $.CreatePanel("Panel",gamelist_player_hero,"gamelist_player_hero_icon"+i)
		gamelist_player_hero_icon.AddClass("gamelist_player_hero")

		gamelist_player_skill_icon = $.CreatePanel("Panel",gamelist_player_skill,"gamelist_player_skill_icon"+i)
		gamelist_player_skill_icon.AddClass("gamelist_player_skill")

		var hero = server_data.player_matches[i].hero


		if (server_data.player_matches[i].orange_talent ) {
		        gamelist_player_skill_icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/'  + hero +'/' + server_data.player_matches[i].orange_talent + '.png")'
		}


		gamelist_player_skill_icon.style.backgroundSize = "contain";

		gamelist_player_hero_icon.style.backgroundImage = "url('file://{images}/heroes/icons/" + hero + ".png')"
		gamelist_player_hero_icon.style.backgroundSize = "contain";

		gamelist_player_items = $.CreatePanel("Panel",gamelist_player_label,"gamelist_player_items"+i)
		gamelist_player_items.AddClass("gamelist_items")

		gamelist_player_items_row_1 = $.CreatePanel("Panel",gamelist_player_items,"gamelist_player_items_row_1"+i)
		gamelist_player_items_row_1.AddClass("gamelist_items_row")

		gamelist_player_items_row_2 = $.CreatePanel("Panel",gamelist_player_items,"gamelist_player_items_row_2"+i)
		gamelist_player_items_row_2.AddClass("gamelist_items_row")

		const items = server_data.player_matches[i].items
		if (items)
		    for (var j = 0; j <= 6; j++) 
		    {
		        var row = j <= 2 ? gamelist_player_items_row_1 : gamelist_player_items_row_2
		        $.CreatePanel("DOTAItemImage",row,"gamelist_item_"+i+"_"+(j-1)).itemname = items[j]
		    }

		gamelist_player_kills = $.CreatePanel("Panel",gamelist_player_label,"gamelist_player_kills"+i)
		gamelist_player_kills.AddClass("gamelist_player_stat")


		gamelist_player_kills_text = $.CreatePanel("Label",gamelist_player_kills,"gamelist_player_kills_text"+i)
		gamelist_player_kills_text.AddClass("gamelist_number")
		gamelist_player_kills_text.text = server_data.player_matches[i].kills +' / ' + server_data.player_matches[i].deaths

		gamelist_player_place = $.CreatePanel("Panel",gamelist_player_label,"gamelist_player_place"+i)
		gamelist_player_place.AddClass("gamelist_player_stat_place")

		gamelist_player_place_text = $.CreatePanel("Label",gamelist_player_place,"gamelist_player_place_text"+i)
		gamelist_player_place_text.AddClass("gamelist_number")
		gamelist_player_place_text.AddClass("gamelist_number_big")

		let place = server_data.player_matches[i].place
		gamelist_player_place_text.text = place

		if (place <= 3)
		{
			gamelist_player_place_text.AddClass("gamelist_number_place_win")
			gamelist_player_label.AddClass("gamelist_player_label_win")
		}else
		{
			gamelist_player_place_text.AddClass("gamelist_number_place_lose")
			gamelist_player_label.AddClass("gamelist_player_label_lose")
		}

		gamelist_player_rating = $.CreatePanel("Panel",gamelist_player_label,"gamelist_player_rating"+i)
		gamelist_player_rating.AddClass("gamelist_player_stat_rating")
		
		gamelist_player_rating_text = $.CreatePanel("Label",gamelist_player_rating,"gamelist_player_rating_text"+i)
		gamelist_player_rating_text.AddClass("gamelist_number")
		gamelist_player_rating_text.AddClass("gamelist_number_big")

		let rating = server_data.player_matches[i].rating || 0
		gamelist_player_rating_text.text = String(rating)

		if (rating > 0)
		{
			gamelist_player_rating_text.AddClass("gamelist_number_place_win")
			gamelist_player_rating_text.text = '+' + String(Math.abs(rating))
		}
		else if (rating < 0)
		{
			gamelist_player_rating_text.AddClass("gamelist_number_place_lose")
			gamelist_player_rating_text.text = '-' + String(Math.abs(rating))
		}

		let duration = server_data.player_matches[i].endTime
		
		var min = Math.trunc((duration)/60) 
		var sec_n =  (duration) - 60*Math.trunc((duration)/60) 

		var hour = String( Math.trunc((min)/60) )

		var min = String(min - 60*( Math.trunc(min/60) ))

		var sec = String(sec_n)
		if (sec_n < 10) 
		{
			sec = '0' + sec

		}
		if (min < 10) 
		{
			min = '0' + min

		}

		gamelist_player_duration = $.CreatePanel("Panel",gamelist_player_label,"gamelist_player_duration"+i)
		gamelist_player_duration.AddClass("gamelist_player_duration")

		gamelist_player_duration_text = $.CreatePanel("Label",gamelist_player_duration,"gamelist_player_duration_text"+i)
		gamelist_player_duration_text.AddClass("gamelist_number")
		if (hour > 0)
		{
			gamelist_player_duration_text.text = hour + ':' + min + ':' + sec
		}
		else 
		{
			gamelist_player_duration_text.AddClass("gamelist_number_big")
			gamelist_player_duration_text.text =  min + ':' + sec
		}

		gamelist_player_date = $.CreatePanel("Panel",gamelist_player_label,"gamelist_player_date"+i)
		gamelist_player_date.AddClass("gamelist_player_date")

		gamelist_player_year_text = $.CreatePanel("Label",gamelist_player_date,"gamelist_player_year_text"+i)
		gamelist_player_year_text.AddClass("gamelist_number")

		var date = new Date(Number(server_data.player_matches[i].date))
		var month = $.Localize("#month_" + padNumber(date.getUTCMonth()))

		gamelist_player_year_text.text = padNumber(date.getUTCDate()) + " "  + month + " " + date.getUTCFullYear()
	}

}



function init_settings()
{
	if (chosen_label == 4) {return}
	chosen_label = 4

	Game.EmitSound("UI.Click_Hero")

	var button_settings = $.GetContextPanel().FindChildTraverse("info_button_settings")
	
	clear_window(button_settings)

	var content = $.GetContextPanel().FindChildTraverse("info_window_content")
	var content_clearing =  $.CreatePanel("Panel",content,"content_clearing")
	content_clearing.AddClass("content_clearing")

	var header = $.CreatePanel("Panel", content_clearing, "")
	header.AddClass("achivment_header")

	var header_text = $.CreatePanel("Label", header, "")
	header_text.AddClass("achivment_header_text")
	header_text.text = $.Localize("#settings_header")

	var bottom_content = $.CreatePanel("Label", content_clearing, "")
	bottom_content.AddClass("settings_bottom_content")

	var settings_labels = $.CreatePanel("Panel", bottom_content, "")
	settings_labels.AddClass("settings_labels")


	var TalentView_text = $.Localize("#TalentView_info")
	var Level_text = $.Localize("#shop_show_level_info")
	var Quest_text = $.Localize("#shop_disable_quest_info")
	var tips_text = $.Localize("#shop_disable_tips_info")
	var wavealert_text = $.Localize("#shop_disable_wavealert_info")

	var settings_label_talents = $.CreatePanel("Panel", settings_labels, "settings_label_talents")
	settings_label_talents.AddClass("settings_label")
	ShowInfo(settings_label_talents, TalentView_text)

	settings_label_talents.SetPanelEvent("onactivate", function() 
	{	
		send_change_settings(1);
	});

	var settings_checkbox_talents = $.CreatePanel("Panel", settings_label_talents, "settings_checkbox_talents")
	settings_checkbox_talents.AddClass("settings_checkbox")

	var settings_text_talents = $.CreatePanel("Label", settings_label_talents, "")
	settings_text_talents.AddClass("settings_text")
	settings_text_talents.text = $.Localize("#TalentViewText")



	var settings_label_level = $.CreatePanel("Panel", settings_labels, "settings_label_level")
	settings_label_level.AddClass("settings_label")
	ShowInfo(settings_label_level, Level_text)

	settings_label_level.SetPanelEvent("onactivate", function() 
	{	
		send_change_settings(2);
	});

	var settings_checkbox_level = $.CreatePanel("Panel", settings_label_level, "settings_checkbox_level")
	settings_checkbox_level.AddClass("settings_checkbox")

	var settings_text_level = $.CreatePanel("Label", settings_label_level, "")
	settings_text_level.AddClass("settings_text")
	settings_text_level.text = $.Localize("#Shop_Heroes_Show")


	var settings_label_quest = $.CreatePanel("Panel", settings_labels, "settings_label_quest")
	settings_label_quest.AddClass("settings_label")
	ShowInfo(settings_label_quest, Quest_text)

	settings_label_quest.SetPanelEvent("onactivate", function() 
	{	
		send_change_settings(3);
	});

	var settings_checkbox_quest = $.CreatePanel("Panel", settings_label_quest, "settings_checkbox_quest")
	settings_checkbox_quest.AddClass("settings_checkbox")

	var settings_text_quest = $.CreatePanel("Label", settings_label_quest, "")
	settings_text_quest.AddClass("settings_text")
	settings_text_quest.text = $.Localize("#Disable_quest_setting")



	var settings_label_tips = $.CreatePanel("Panel", settings_labels, "settings_label_tips")
	settings_label_tips.AddClass("settings_label")
	ShowInfo(settings_label_tips, tips_text)

	settings_label_tips.SetPanelEvent("onactivate", function() 
	{	
		send_change_settings(4);
	});

	var settings_checkbox_tips = $.CreatePanel("Panel", settings_label_tips, "settings_checkbox_tips")
	settings_checkbox_tips.AddClass("settings_checkbox")

	var settings_text_tips = $.CreatePanel("Label", settings_label_tips, "")
	settings_text_tips.AddClass("settings_text")
	settings_text_tips.text = $.Localize("#Disable_tips_setting")


	var settings_label_wavealert = $.CreatePanel("Panel", settings_labels, "settings_label_wavealert")
	settings_label_wavealert.AddClass("settings_label")
	ShowInfo(settings_label_wavealert, wavealert_text)

	settings_label_wavealert.SetPanelEvent("onactivate", function() 
	{	
		send_change_settings(7);
	});

	var settings_checkbox_wavealert = $.CreatePanel("Panel", settings_label_wavealert, "settings_checkbox_wavealert")
	settings_checkbox_wavealert.AddClass("settings_checkbox")

	var settings_text_wavealert = $.CreatePanel("Label", settings_label_wavealert, "")
	settings_text_wavealert.AddClass("settings_text")
	settings_text_wavealert.text = $.Localize("#Disable_wavealert_setting")

	GameEvents.SendCustomGameEventToServer_custom("RequestSettings", {})
}



function send_change_settings(type)
{
	Game.EmitSound("UI.Click")
	GameEvents.SendCustomGameEventToServer_custom("ChangeSettings", {type : type})
}

function ShowInfo(panel, text)
{
	panel.SetPanelEvent('onmouseover', function() {
    $.DispatchEvent('DOTAShowTextTooltip', panel, text) });
    
	panel.SetPanelEvent('onmouseout', function() {
    $.DispatchEvent('DOTAHideTextTooltip', panel); });
}


function GetSettingsChange(data)
{
	let button_talents = $.GetContextPanel().FindChildTraverse("settings_checkbox_talents")
	let button_level = $.GetContextPanel().FindChildTraverse("settings_checkbox_level")
	let button_quest = $.GetContextPanel().FindChildTraverse("settings_checkbox_quest")
	let button_tips = $.GetContextPanel().FindChildTraverse("settings_checkbox_tips")
	let button_wavealert = $.GetContextPanel().FindChildTraverse("settings_checkbox_wavealert")
    let settings_checkbox_hide_player_pet_names = $.GetContextPanel().FindChildTraverse("settings_checkbox_hide_player_pet_names")
    let settings_checkbox_set_pet_movement_base = $.GetContextPanel().FindChildTraverse("settings_checkbox_set_pet_movement_base")

    if (button_talents)
    {
        button_talents.SetHasClass("settings_checkbox_inactive", data.talent_view == 0)
	    button_talents.SetHasClass("settings_checkbox_active", data.talent_view == 1)
    }
    if (button_level)
    {
        button_level.SetHasClass("settings_checkbox_inactive", data.level_view == 0)
	    button_level.SetHasClass("settings_checkbox_active", data.level_view == 1)
    }
    if (button_quest)
    {
        button_quest.SetHasClass("settings_checkbox_inactive", data.quest_view == 0)
	    button_quest.SetHasClass("settings_checkbox_active", data.quest_view == 1)
    }
    if (button_tips)
    {
        button_tips.SetHasClass("settings_checkbox_inactive", data.tips_view == 0)
	    button_tips.SetHasClass("settings_checkbox_active", data.tips_view == 1)
    }
    if (settings_checkbox_hide_player_pet_names)
    {
        settings_checkbox_hide_player_pet_names.SetHasClass("settings_checkbox_inactive", data.hide_pet_names == 0)
	    settings_checkbox_hide_player_pet_names.SetHasClass("settings_checkbox_active", data.hide_pet_names == 1)
    }
    if (settings_checkbox_set_pet_movement_base)
    {
        settings_checkbox_set_pet_movement_base.SetHasClass("settings_checkbox_inactive", data.pet_movement == 0)
	    settings_checkbox_set_pet_movement_base.SetHasClass("settings_checkbox_active", data.pet_movement == 1)
    }
    if (button_wavealert)
    {
        button_wavealert.SetHasClass("settings_checkbox_inactive", data.wavealert_hide == 0)
	    button_wavealert.SetHasClass("settings_checkbox_active", data.wavealert_hide == 1)
    }
}