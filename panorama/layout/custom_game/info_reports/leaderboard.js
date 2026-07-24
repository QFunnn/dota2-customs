--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let current_mode = 1

function init_leaderbord_ranked(mode) 
{
	let header = $("#leaderbord_header_text_panel")

	let leaderboard_window_season_panel = $("#leaderboard_window_season_panel")
	if (leaderboard_window_season_panel)
		leaderboard_window_season_panel.RemoveAndDeleteChildren()

	let leaderboard_window_season_text = $.CreatePanel("Label", leaderboard_window_season_panel, "")
	leaderboard_window_season_text.AddClass("leaderboard_window_season_text")
	leaderboard_window_season_text.text = $.Localize("#current_season")

	let leaderboard_window_season_icon = $.CreatePanel("Panel", leaderboard_window_season_panel, "")
	leaderboard_window_season_icon.AddClass("leaderboard_window_season_icon")

	let leaderboard_window_season_icon_text = $.CreatePanel("Label", leaderboard_window_season_icon, "")
	leaderboard_window_season_icon_text.AddClass("leaderboard_window_season_icon_text")
	leaderboard_window_season_icon_text.text = "?"

	let text_mouse = $.Localize("#current_season_info")

	leaderboard_window_season_panel.SetPanelEvent('onmouseover', function() {
    $.DispatchEvent('DOTAShowTextTooltip', leaderboard_window_season_panel, text_mouse) });
    
	leaderboard_window_season_panel.SetPanelEvent('onmouseout', function() {
    $.DispatchEvent('DOTAHideTextTooltip', leaderboard_window_season_panel); });

	let content_clearing = $.GetContextPanel().FindChildTraverse("leaderbord_window_content")
	content_clearing.RemoveAndDeleteChildren()

    let leaderboard_stat_info = $.CreatePanel("Panel",content_clearing,"leaderboard_stat_info")
    leaderboard_stat_info.AddClass("leaderboard_stat_info")

	let leaderboard_info_place = $.CreatePanel("Panel",leaderboard_stat_info,"leaderboard_info_place")
	leaderboard_info_place.AddClass("leaderboard_stat_info_place")

	let leaderboard_info_place_text = $.CreatePanel("Label",leaderboard_info_place,"leaderboard_info_place_text")
	leaderboard_info_place_text.AddClass("leaderboard_stat_info_text")
    leaderboard_info_place_text.text = "#"

	let leaderboard_info_rating = $.CreatePanel("Panel",leaderboard_stat_info,"leaderboard_info_rating")
	leaderboard_info_rating.AddClass("leaderboard_stat_info_rating")

	let leaderboard_info_rating_text = $.CreatePanel("Label",leaderboard_info_rating,"leaderboard_info_rating_text")
	leaderboard_info_rating_text.AddClass("leaderboard_stat_info_text")
    leaderboard_info_rating_text.text = $.Localize("#gamelist_rating")

	let leaderboard_info_games = $.CreatePanel("Panel",leaderboard_stat_info,"leaderboard_info_games")
	leaderboard_info_games.AddClass("leaderboard_stat_info_games")

	let leaderboard_info_games_text = $.CreatePanel("Label",leaderboard_info_games,"leaderboard_info_games_text")
	leaderboard_info_games_text.AddClass("leaderboard_stat_info_text")
    leaderboard_info_games_text.text = $.Localize("#gamelist_games")

	let leaderboard_info_player = $.CreatePanel("Panel",leaderboard_stat_info,"leaderboard_info_player")
	leaderboard_info_player.AddClass("leaderboard_stat_info_player")

	let leaderboard_info_player_text = $.CreatePanel("Label",leaderboard_info_player,"leaderboard_info_player_text")
	leaderboard_info_player_text.AddClass("leaderboard_stat_info_text")
    leaderboard_info_player_text.text = $.Localize("#gamelist_player")

	let leaderboard_info_hero = $.CreatePanel("Panel",leaderboard_stat_info,"leaderboard_info_hero")
	leaderboard_info_hero.AddClass("leaderboard_stat_info_hero")


	let leaderboard_info_hero_text = $.CreatePanel("Label",leaderboard_info_hero,"leaderboard_info_hero_text")
	leaderboard_info_hero_text.AddClass("leaderboard_stat_info_text")
    leaderboard_info_hero_text.text = $.Localize("#gamelist_hero")	


	let leaderboard_label = $.CreatePanel("Panel",content_clearing,"leaderboard_label")
	leaderboard_label.AddClass("leaderboard_label")

	let leaderboard_player_label
	let leaderboard_player_place
	let leaderboard_player_place_text
	let leaderboard_player_name
	let leaderboard_player_icon
	let leaderboard_player_games
	let leaderboard_player_games_text
	let leaderboard_player_rating
	let leaderboard_player_rating_text
	let leaderboard_player_name_text
	let leaderboard_player_hero
	let leaderboard_player_hero_label

	let table_name = "leaderboard"
	if (mode == 2)
	{
		table_name = "leaderboard_duo"
	} 

	let leaderboard_data = CustomNetTables.GetTableValue("leaderboard", table_name);

	if (leaderboard_data == undefined) {return}
	for (let i = 1; i <= Object.keys(leaderboard_data).length; i++) 
	{
		let hero = leaderboard_data[i].favorite_hero
		let count = 0
		leaderboard_data[i].count_hero = 0
		for (let j = 1; j <= Object.keys(leaderboard_data).length; j++)
		{
			if (leaderboard_data[j].favorite_hero === hero)
			{
				count += 1
			}
		}
		leaderboard_data[i].count_hero = count
	}

	let length = Math.min(Object.keys(leaderboard_data).length, 50)

	for (let i = 1; i <= length; i++) 
	{
		leaderboard_player_label = $.CreatePanel("Panel",leaderboard_label,"leaderboard_player_label"+i)
		leaderboard_player_label.AddClass("leaderboard_player_label")

		leaderboard_player_place = $.CreatePanel("Panel",leaderboard_player_label,"leaderboard_player_place"+i)
		leaderboard_player_place.AddClass("leaderboard_player_place")

		leaderboard_player_place_text = $.CreatePanel("Label",leaderboard_player_place,"leaderboard_player_place_text"+i)
		leaderboard_player_place_text.AddClass("leaderboard_number")
		leaderboard_player_place_text.text = String(i)
		
		leaderboard_player_rating = $.CreatePanel("Panel",leaderboard_player_label,"leaderboard_player_rating"+i)
		leaderboard_player_rating.AddClass("leaderboard_player_rating")

		leaderboard_player_rating_text = $.CreatePanel("Label",leaderboard_player_rating,"leaderboard_player_rating_text"+i)
		leaderboard_player_rating_text.AddClass("leaderboard_number")
		leaderboard_player_rating_text.text = leaderboard_data[i].rating

		leaderboard_player_games = $.CreatePanel("Panel",leaderboard_player_label,"leaderboard_player_games"+i)
		leaderboard_player_games.AddClass("leaderboard_player_games")

		leaderboard_player_games_text = $.CreatePanel("Label",leaderboard_player_games,"leaderboard_player_games_text"+i)
		leaderboard_player_games_text.AddClass("leaderboard_number")
		leaderboard_player_games_text.text = leaderboard_data[i].total_matches

		let leaderboard_player_icon_panel = $.CreatePanel("Panel",leaderboard_player_label,"leaderboard_player_icon"+i)
		leaderboard_player_icon_panel.AddClass("leaderboard_player_icon_panel")

		let leaderboard_player_icon = $.CreatePanel("DOTAAvatarImage",leaderboard_player_icon_panel,"leaderboard_player_icon"+i)
		leaderboard_player_icon.style.width = "100%"
    	leaderboard_player_icon.style.height = "100%"
    	leaderboard_player_icon.accountid = leaderboard_data[i].playerId

		leaderboard_player_name = $.CreatePanel("Panel",leaderboard_player_label,"leaderboard_player_name"+i)
		leaderboard_player_name.AddClass("leaderboard_player_name")

		leaderboard_player_name_text = $.CreatePanel("DOTAUserName",leaderboard_player_name,"leaderboard_player_name_text"+i)
		leaderboard_player_name_text.AddClass("leaderboard_name_text")
		leaderboard_player_name_text.accountid = leaderboard_data[i].playerId

		leaderboard_player_hero_label = $.CreatePanel("Panel",leaderboard_player_label,"leaderboard_player_hero_label"+i)
		leaderboard_player_hero_label.AddClass("leaderboard_player_hero_label")
		
		if (i <= 10)
		{
			leaderboard_player_icon_panel.AddClass("leaderboard_player_icon_panel_gold")
			leaderboard_player_name_text.AddClass("leaderboard_player_place_gold")
			leaderboard_player_games_text.AddClass("leaderboard_player_place_gold")
			leaderboard_player_rating_text.AddClass("leaderboard_player_place_gold")
			leaderboard_player_place_text.AddClass("leaderboard_player_place_gold")
		}

		leaderboard_player_hero = $.CreatePanel("Panel",leaderboard_player_hero_label,"leaderboard_player_hero"+i)
		leaderboard_player_hero.AddClass("leaderboard_player_hero")
		
		let hero = leaderboard_data[i].favorite_hero
		if ((hero != null)&&(hero != ''))
		{
			leaderboard_player_hero.style.backgroundImage = "url('file://{images}/heroes/icons/" + hero + ".png')"
		}
		leaderboard_player_hero.style.backgroundSize = "contain";
	}
}


function leaderbord_window_hide()
{
	if (cd == true)
		return
	
	cd = true
	Game.EmitSound("UI.Info_Close")
	let info_button = $.GetContextPanel().FindChildTraverse("info_button")
	let leaderbord_button = $.GetContextPanel().FindChildTraverse("leaderbord_button")
	let leaderbord_window = $.GetContextPanel().FindChildTraverse("leaderbord_window")
	leaderbord_button.RemoveClass("button_active")
	leaderbord_window.RemoveClass("leaderbord_window_show")
	leaderbord_window.AddClass("leaderbord_window_hidden")
	leaderbord_button.SetPanelEvent("onactivate", function() 
	{	
		leaderbord_window_show()
	});
	$.Schedule(0.5, function ()
	{
		cd = false
	})	
}


function leaderbord_window_show()
{
	if (cd == true)
		return

	Game.EmitSound("UI.Info_Open")
	cd = true
	let info_button = $.GetContextPanel().FindChildTraverse("info_button")
	let leaderbord_button = $.GetContextPanel().FindChildTraverse("leaderbord_button")
	let shop_button = $.GetContextPanel().FindChildTraverse("shop_button")
	let info_window = $.GetContextPanel().FindChildTraverse("window_info")
	let leaderbord_window = $.GetContextPanel().FindChildTraverse("leaderbord_window")
	let shop_window = $.GetContextPanel().FindChildTraverse("window_shop")
	shop_button.RemoveClass("button_active")
	info_button.RemoveClass("button_active")
	leaderbord_button.AddClass("button_active")
	if (info_window.BHasClass("info_window_show"))
	{
		info_window.RemoveClass("info_window_show")
		info_window.AddClass("info_window_hidden")

		info_button.SetPanelEvent("onactivate", function() 
		{	
			Info_window_show()
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

	leaderbord_window.RemoveClass("leaderbord_window_hidden")
	leaderbord_window.AddClass("leaderbord_window_show")
	leaderbord_button.SetPanelEvent("onactivate", function() 
	{	
		leaderbord_window_hide()
	});

	leaderbord_change_mode(current_mode, true)

	$.Schedule(0.5, function ()
	{
		cd = false
	})
}


function leaderbord_change_mode(mode, forced)
{
	if (current_mode == mode && !forced)
		return

	if (!forced)
		Game.EmitSound("UI.Click_Hero")

	current_mode = mode

	let button_solo = $("#leaderbord_button_solo")
	let button_duo = $("#leaderbord_button_duo")

	button_solo.RemoveClass("leaderbord_header_mode_button_chosen")
	button_duo.RemoveClass("leaderbord_header_mode_button_chosen")

	if (mode == 1)
	{
		button_solo.AddClass("leaderbord_header_mode_button_chosen")
		init_leaderbord_ranked(1)
	}

	if (mode == 2)
	{
		button_duo.AddClass("leaderbord_header_mode_button_chosen")
		init_leaderbord_ranked(2)
	}
}