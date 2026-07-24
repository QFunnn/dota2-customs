--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function init_team_report() 
{
	var content_main = $.GetContextPanel().FindChildTraverse("reports_window_content")
	var content = $.GetContextPanel().FindChildTraverse("content_clearing_report")
	var report = CustomNetTables.GetTableValue("reports", Players.GetLocalPlayer());
	var player_count = 0
	for (var i = 0; i <= 24; i++) 
    {
		var player_info = Game.GetPlayerInfo(i)
		if (player_info !== undefined && player_info.player_steamid !== "0")
			player_count++
	}

	var no_players = false// player_count <= 6
	var not_valid = report.max_map == 1 || no_players || report.report < 1

	var reports_left = report.report

	Hero_1 = null
	Hero_2 = null

	if (content)
		content.DeleteAsync(0)


	content = $.CreatePanel("Panel", content_main, "content_clearing_report")
	content.AddClass("content_clearing")

	var top_label = $.CreatePanel("Panel", content, "top_label")
	top_label.AddClass("reports_top_label")

	var top_text = $.CreatePanel("Label", top_label, "top_text")
	top_text.AddClass("report_team_top")
	top_text.html = true
	top_text.text = $.Localize("#report_team_top")


	var hero_label_1 = $.CreatePanel("Panel", content, "hero_label_1")
	hero_label_1.AddClass("reports_hero_label")

	var mid_label = $.CreatePanel("Panel", content, "mid_label")
	mid_label.AddClass("reports_mid_label")

	var mid_text = $.CreatePanel("Label", mid_label, "mid_text")
	mid_text.AddClass("report_mid_text")
	mid_text.html = true


	if (reports_left < 1)
		top_text.text = $.Localize("#no_reports")

	if (no_players)
		top_text.text = $.Localize("#no_players_reports")

	if (report.max_map == 1)
		top_text.text = $.Localize("#reports_max_map")

	if (!not_valid)
		mid_text.text = '+'

	var hero_label_2 = $.CreatePanel("Panel", content, "hero_label_2")
	hero_label_2.AddClass("reports_hero_label")
	hero_label_2.AddClass("report_border_white")

	var heroes = []
	var heroes2 = []

	var bottom_label = $.CreatePanel("Panel", content, "bottom_label")
	bottom_label.AddClass("reports_bottom_label")

	var bottom_label_left = $.CreatePanel("Panel", bottom_label, "bottom_label_left")
	bottom_label_left.AddClass("reports_bottom_left")

	var bottom_button = $.CreatePanel("Panel", bottom_label, "bottom_button")
	bottom_button.AddClass("reports_bottom_button")

	bottom_button.style.saturation = "0"
	bottom_button.style.washColor = "#666666";


	var bottom_button_text = $.CreatePanel("Label", bottom_button, "bottom_button_text")
	bottom_button_text.AddClass("reports_bottom_button_text")
	bottom_button_text.text = $.Localize("#Send_report")


	var bottom_left_text = $.CreatePanel("Label", bottom_label_left, "bottom_left_text")
	bottom_left_text.AddClass("reports_bottom_left_text")
	bottom_left_text.text = $.Localize("#Reports_left") + String(reports_left)


	bottom_button.SetPanelEvent("onactivate", function() {
		if ((Hero_1 === null) || (Hero_2 === null)) {
			return
		}

		Reports_window_hide()


		GameEvents.SendCustomGameEventToServer_custom("send_report", {
			Hero_1,
			Hero_2
		})
	});



	if (not_valid)
		return
	for (var i = 0; i <= 24; i++) {
		
		  if (i === Players.GetLocalPlayer())
            continue
        var player_info = Game.GetPlayerInfo(i)
        if (player_info === undefined || player_info.player_steamid === "0")
            continue

		heroes[i] = $.CreatePanel("Panel", hero_label_1, "hero" + i)
		heroes2[i] = $.CreatePanel("Panel", hero_label_2, "hero2" + i)
		heroes[i].AddClass("reports_hero_portrait")
		heroes2[i].AddClass("reports_hero_portrait")

		heroes[i].style.backgroundImage = "url('file://{images}/heroes/" + Players.GetPlayerSelectedHero(i) + ".png')"
		if (Players.GetPlayerSelectedHero(i) === 'invalid index')
			heroes[i].style.backgroundImage = "url('file://{images}/heroes/npc_dota_hero_juggernaut.png')"

		heroes2[i].style.backgroundImage = "url('file://{images}/heroes/" + Players.GetPlayerSelectedHero(i) + ".png')"
		if (Players.GetPlayerSelectedHero(i) === 'invalid index')
			heroes2[i].style.backgroundImage = "url('file://{images}/heroes/npc_dota_hero_juggernaut.png')"


		heroes[i].style.backgroundSize = "contain";
		heroes2[i].style.backgroundSize = "contain";
		heroes2[i].style.saturation = "0"
		heroes2[i].style.washColor = "#666666";

		set_report_player_1(heroes, heroes2, i)
		set_report_player_2(heroes2, bottom_button, i)
	}
}


function set_report_player_1(heroes, heroes2, i)
{
	heroes[i].SetPanelEvent("onactivate", function() 
	{	
		if (Hero_2 === i)
		{
			return
		}
		Game.EmitSound("UI.Click")
	

		Hero_1 = i
		for (var j = 0; j <= 24; j++) 
		{
			if (heroes[j])
			{
				heroes[j].style.saturation = "1"
				heroes[j].style.washColor = "none";

				if ((heroes[j]) && (j !== i))
				{	
					heroes[j].style.saturation = "0"
					heroes[j].style.washColor = "#666666";	
				}
			}
		}

		if (Hero_2 === null)
		{
			for (var j = 0; j <= 24; j++) 
			{
				if (heroes[j])
				{
					heroes2[j].style.saturation = "0"
					heroes2[j].style.washColor = "#666666";
					if (j !== Hero_1)
					{
						heroes2[j].style.saturation = "1"
						heroes2[j].style.washColor = "none";
					}
				}
			}
		}
	});	
}

function set_report_player_2(heroes2, button, i)
{
	heroes2[i].SetPanelEvent("onactivate", function() 
	{	
		if ((Hero_1 === null)||(Hero_1 === i))
		{
			return
		} 
		Hero_2 = i
		Game.EmitSound("UI.Click")
		for (var j = 0; j <= 24; j++) 
		{		
			if (heroes2[j])
			{
				heroes2[j].style.saturation = "1"
				heroes2[j].style.washColor = "none";
				if ((heroes2[j]) && (j !== i))
				{	
					heroes2[j].style.saturation = "0"	
					heroes2[j].style.washColor = "#666666";
				}
			}
		}
		if ((Hero_1 !== null)&&(Hero_2 !== null))
		{
			button.style.saturation = "1"
			button.style.washColor = "none";
		}
	});	
}

function Reports_window_hide()
{
	if (cd == false)
	{
		cd = true
		Game.EmitSound("UI.Info_Close")
		var info_button = $.GetContextPanel().FindChildTraverse("info_button")
		var report_button = $.GetContextPanel().FindChildTraverse("report_button")
		var info_window = $.GetContextPanel().FindChildTraverse("window_info")
		var window_reports = $.GetContextPanel().FindChildTraverse("window_reports")
		report_button.style.backgroundImage = "url('file://{images}/custom_game/report.png')"
		window_reports.RemoveClass("reports_window_show")
		window_reports.AddClass("reports_window_hidden")
		report_button.SetPanelEvent("onactivate", function() 
		{	
			Reports_window_show()
		});
		$.Schedule(0.5, function ()
		{
			cd = false
		})
	}
}

function Reports_window_show()
{
	if (cd == false)
	{
		Game.EmitSound("UI.Info_Open")
		cd = true
		var info_button = $.GetContextPanel().FindChildTraverse("info_button")
		var report_button = $.GetContextPanel().FindChildTraverse("report_button")
		var shop_button = $.GetContextPanel().FindChildTraverse("shop_button")
		var info_window = $.GetContextPanel().FindChildTraverse("window_info")
		var window_reports = $.GetContextPanel().FindChildTraverse("window_reports")
		var shop_window = $.GetContextPanel().FindChildTraverse("window_shop")
		info_button.style.backgroundImage = "url('file://{images}/custom_game/profile.png')"
		report_button.style.backgroundImage = "url('file://{images}/custom_game/report_chose.png')"
		var close_button = $.GetContextPanel().FindChildTraverse("close_button_report")
		var close_text = $.GetContextPanel().FindChildTraverse("close_text_report")
		close_text.text = $.Localize("#close_text")
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
		window_reports.RemoveClass("reports_window_hidden")
		window_reports.AddClass("reports_window_show")
		report_button.SetPanelEvent("onactivate", function() 
		{	
			Reports_window_hide()
		});
		init_team_report()
		close_button.SetPanelEvent("onactivate", function() 
		{	
			Reports_window_hide()
		});
		$.Schedule(0.5, function ()
		{
			cd = false
		})
	}
}