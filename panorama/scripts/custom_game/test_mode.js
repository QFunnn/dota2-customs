--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


CustomNetTables.SubscribeNetTableListener( "test_mode", UpdateHeroInfo );

var BotHeroes = CustomNetTables.GetTableValue("test_mode", "bot_heroes")

var local_hero = null

function UpdateHeroInfo(table, key, data ) 
{
	if (table == "test_mode") 
	{
		if (key == "banned_heroes") 
        {	
        	CheckBannedHeroes()
		}

		if (key == "players_heroes") 
        {	
  			$.Schedule(0.1, UpdateTeamHeroes)
		}
		if (key == "team_status")
		{
			UpdateTeamSelector()
		}
	}
}


function CheckBannedHeroes()
{
	var banned_heroes = CustomNetTables.GetTableValue("test_mode", "banned_heroes")

	if (banned_heroes == undefined)
		return


	for (const name of Object.values(banned_heroes)) 
	{
		let panel = $.GetContextPanel().FindChildTraverse(name)

		if (panel && panel !== undefined)
		{
			panel.AddClass("NoTalent")
		}
	}

}


var selected_ent = -1

function CheckSelectedUnit()
{

	if (local_hero == null) 
    {	
		var PlayersHeroes = CustomNetTables.GetTableValue("test_mode", "players_heroes")

		if (PlayersHeroes)
    	{
	    	for (const lua_data of Object.values(PlayersHeroes))
			{
				if (lua_data.id == Game.GetLocalPlayerID())
				{
					let ent = lua_data.ent 

					let icon = $.GetContextPanel().FindChildTraverse("PlayerHero_icon")

					if (icon && icon !== undefined)
					{
						local_hero = Entities.GetUnitName(ent)
						let icon_name = "url('file://{images}/heroes/icons/" + String( Entities.GetUnitName(ent)) + ".png')"
						icon.style.backgroundImage = icon_name
					    icon.style.backgroundSize = "contain";
					    icon.style.backgroundRepeat = "no-repeat";
					}
					break
				}
			} 
		}
	}

  	let ent = Players.GetLocalPlayerPortraitUnit()
  	let is_bot = false

  	let old_ent = selected_ent

	var BotHeroes = CustomNetTables.GetTableValue("test_mode", "bot_heroes")

	if (BotHeroes && BotHeroes !== undefined)
	{
		for (const number of Object.values(BotHeroes)) 
		{
			if (ent == number)
			{
				is_bot = true
				break
			}
		}
		
	}

	let icon_name 

	let icon = $.GetContextPanel().FindChildTraverse("GiveBotTalent_icon")


	if (is_bot == false)
	{
		icon_name = "url('file://{images}/custom_game/no_hero.png')"
		selected_ent = -1
	}else 
	{
		icon_name = "url('file://{images}/heroes/icons/" + String( Entities.GetUnitName(ent)) + ".png')"
		selected_ent = ent
	}

	if (icon !== undefined)
	{
		icon.style.backgroundImage = icon_name
	    icon.style.backgroundSize = "contain";
	    icon.style.backgroundRepeat = "no-repeat";
	}


	if (old_ent !== selected_ent)
	{
		if (current_state == 5)
		{
			ChangeTalentWindow(5)
		}
		if (current_state == 4)
		{
			ChangeTalentWindow(4)
		}
	}

  	$.Schedule(0.1, CheckSelectedUnit)
}



function init()
{
	GameEvents.Subscribe_custom("update_test_talents", update_test_talents)
	GameEvents.Subscribe_custom("lua_timer_stop", lua_timer_stop)
	GameEvents.Subscribe_custom("lua_wtf_mode", lua_wtf_mode)
	GameEvents.Subscribe_custom("set_test_mode", set_test_mode)
	GameEvents.Subscribe_custom("update_hud_hidden", update_hud_hidden)
}

function lua_timer_stop(kv)
{
	let stop = kv.stop
	let button = $.GetContextPanel().FindChildTraverse("StopTimer")

	if (button == undefined)
		return

	if (stop == 1)
	{
		button.AddClass("TestMode_botton_pressed")
	}else 
	{
		button.RemoveClass("TestMode_botton_pressed")
	}

}

function lua_wtf_mode(kv)
{
	let wtf = kv.wtf
	let button = $.GetContextPanel().FindChildTraverse("WtfMode")

	if (button == undefined)
		return

	if (wtf == 1)
	{
		button.AddClass("TestMode_botton_pressed")
	}else 
	{
		button.RemoveClass("TestMode_botton_pressed")
	}

}


function set_test_mode(kv)
{
	let state = kv.state

	let main = $.GetContextPanel().FindChildTraverse("TestMode_panel_and_button")


	if (main == undefined)
	return

	if (state == 1 && !main.BHasClass("TestMode_open"))
	{
		main.RemoveClass("TestMode_disabled")
		ChangeState()
        if (Game.IsInToolsMode())
        {
            $("#PortraitButton_block").visible = true
            $("#TestMode_panel").style.height = "fit-children"
        }
	}
}

var cd = false

function ChangeState()
{
	if (cd == true)
	return
	
	let main = $.GetContextPanel().FindChildTraverse("TestMode_panel_and_button")
	let icon = $.GetContextPanel().FindChildTraverse("TestMode_button_icon")
	
	let content = $.GetContextPanel().FindChildTraverse("TestMode_Content")
	let list = $.GetContextPanel().FindChildTraverse("TalentsList")
	if (main == undefined)
	return

	cd = true

	$.Schedule( 0.25, function(){ 
		cd = false
 	})

	if (main.BHasClass("TestMode_open"))
	{
		main.RemoveClass("TestMode_open")
		main.AddClass("TestMode_close")
        Game.EmitSound("UI.Talent_hide")
        CloseContentWindow()

		$.Schedule( 0.20, function(){ 
			icon.AddClass("TestMode_button_closed")
			main.AddClass("TestMode_closed")
	 	})

	}else
	{
        Game.EmitSound("UI.Talent_show")
		main.RemoveClass("TestMode_close")
		main.RemoveClass("TestMode_closed")
		main.AddClass("TestMode_open")
		icon.RemoveClass("TestMode_button_closed")
	}
	

}


var orb_cd = false

function GiveOrb(type)
{
	if (orb_cd == true)
	return

	orb_cd = true

	$.Schedule( 0.2, function(){ 
		orb_cd = false
	})
	Game.EmitSound("UI.Click")	
   GameEvents.SendCustomGameEventToServer_custom("GiveOrb", {type})
}

var talent_cd = false

function ChangeTalentWindow(type)
{
	if (talent_cd == true)
	return

	talent_cd = true

	$.Schedule( 0.1, function(){ 
		talent_cd = false
	})


	let main = $.GetContextPanel().FindChildTraverse("TestMode_Content")

	if (main == undefined)
	return
	Game.EmitSound("UI.Click")	

	if (type == current_state)
	{
		CloseContentWindow()
		return
	}

	main.RemoveClass("TestMode_hidden")
	if (type == 1)
	{
		ShowTalents()
	}

	if (type == 2)
	{
		ShowItems()
	}

	if (type == 3)
	{
		ShowHeroes()
	}

	if (type == 4)
	{
		ShowBotItems()
	}

	if (type == 5)
	{
		ShowBotTalents()
	}

}


var current_state = 0

function ClearWindow()
{

	let talents_button = $.GetContextPanel().FindChildTraverse("TalentsList")
	let items_button = $.GetContextPanel().FindChildTraverse("GiveItem")
	let heroes_button = $.GetContextPanel().FindChildTraverse("CreateBot")
	let bot_items_button = $.GetContextPanel().FindChildTraverse("GiveBotItem")
	let bot_talents_button = $.GetContextPanel().FindChildTraverse("GiveBotTalent")

	let main = $.GetContextPanel().FindChildTraverse("TestMode_Content")

	heroes_button.RemoveClass("TestMode_botton_pressed")
	talents_button.RemoveClass("TestMode_botton_pressed")
	items_button.RemoveClass("TestMode_botton_pressed")
	bot_items_button.RemoveClass("TestMode_botton_pressed")
	bot_talents_button.RemoveClass("TestMode_botton_pressed")


	main.RemoveClass("TestMode_Content_Items")
	main.RemoveClass("TestMode_Content_Talents")
	main.RemoveClass("TestMode_Content_Hero_Talents")
	main.RemoveClass("TestMode_Content_Hero_Talents_Height")
	main.RemoveClass("TestMode_Content_Heroes")
	main.RemoveClass("TestMode_Content_BotItems")
	main.RemoveClass("TestMode_Content_BotTalents")
	main.RemoveClass("TestMode_Content_BotTalents_Hero_Talents")

	let tempo = $.GetContextPanel().FindChildTraverse("TestMode_content_tempo")

	if (tempo && tempo !== undefined)
	{
		tempo.DeleteAsync(0)
	}
}



function CloseContentWindow()
{
	let main = $.GetContextPanel().FindChildTraverse("TestMode_Content")
	current_state = 0


	main.AddClass("TestMode_hidden")
	main.RemoveClass("TestMode_Content_Items")
	main.RemoveClass("TestMode_Content_Talents")
	main.RemoveClass("TestMode_Content_Hero_Talents")
	main.RemoveClass("TestMode_Content_Hero_Talents_Height")

	ClearWindow()
}


var damage_items = 
[
	"item_moon_shard",
	"item_rapier",
	"item_monkey_king_bar_custom",
	"item_greater_crit_custom",
	"item_nullifier_custom",
	"item_celestial_spear_custom",
	"item_disperser_custom",
	"item_silver_edge_custom",
	"item_mjollnir_custom",
	"item_bloodthorn_custom",
	"item_hydras_breath_custom",
	"item_radiance_custom",
	"item_dagon_5_custom",
	"item_starforge_seal_custom",
	"item_devastator_custom",
	"item_angels_demise_custom"
]

var surv_items = 
[
	"item_black_king_bar_custom",
	"item_heart_custom",
	"item_satanic_custom",
	"item_shivas_guard_custom",
	"item_assault_custom",
	"item_crimson_guard_custom",
	"item_spell_breaker",
	"item_consecrated_wraps_custom",
	"item_pipe_custom",
	"item_guardian_greaves_custom",
	"item_soulguard_custom",
	"item_butterfly_custom",
	"item_skadi_custom",
	"item_sange_and_yasha_custom",
	"item_bloodstone_custom",
	"item_aeon_disk_custom",
]

var util_items = 
[
	"item_heavens_halberd_custom",
	"item_abyssal_blade_custom",
	"item_sheepstick_custom",
	"item_gungir_custom",
	"item_manta_custom",
	"item_lotus_orb_custom",
	"item_sphere_custom",
	"item_harpoon_custom",
	"item_hurricane_pike_custom",
	"item_wind_waker_custom",
	"item_ethereal_blade_custom",
	"item_octarine_core_custom",
	"item_blink_custom",
	"item_travel_boots_2_custom",
	"item_ultimate_scepter_2",
	"item_aghanims_shard"

]

var neutral_items = 
[
	"item_titan_sliver",
	"item_book_of_shadows",
	"item_mirror_shield",
	"item_force_boots_custom",
	"item_pirate_hat",

]

function ShowBotItems()
{

	if (selected_ent == -1)
	{	
		GameEvents.SendCustomGameEventToServer_custom("NoBot", {})
		return
	}


	let ent = selected_ent

	ClearWindow()

	let items_button = $.GetContextPanel().FindChildTraverse("GiveBotItem")

	items_button.AddClass("TestMode_botton_pressed")

	current_state = 4

	let main = $.GetContextPanel().FindChildTraverse("TestMode_Content")

	main.AddClass("TestMode_Content_BotItems")

	let tempo = $.CreatePanel("Panel", main, "TestMode_content_tempo")
	tempo.AddClass("TestMode_content_tempo")
	tempo.AddClass("flow_down")
	tempo.AddClass("ItemsList")


	let attribute_info = $.CreatePanel("Panel", tempo, "");
	attribute_info.AddClass("attribute_info")

	let hero_label_str = $.CreatePanel("Label", attribute_info, "");
	hero_label_str.AddClass("hero_label")
	hero_label_str.text = $.Localize("#item_damage")

	const damage_row = $.CreatePanel("Panel", tempo, "StrengthHeroes");


	let attribute_info_2 = $.CreatePanel("Panel", tempo, "");
	attribute_info_2.AddClass("attribute_info")

	let hero_label_agi = $.CreatePanel("Label", attribute_info_2, "");
	hero_label_agi.AddClass("hero_label")
	hero_label_agi.text =  $.Localize("#item_surv")

	const surv_row = $.CreatePanel("Panel", tempo, "AgilityHeroes");


	let attribute_info_3 = $.CreatePanel("Panel", tempo, "");
	attribute_info_3.AddClass("attribute_info")

	let hero_label_int = $.CreatePanel("Label", attribute_info_3, "");
	hero_label_int.AddClass("hero_label")
	hero_label_int.text =  $.Localize("#item_util")

	const util_row =  $.CreatePanel("Panel", tempo, "IntellectHeroes");




	//let attribute_info_4 = $.CreatePanel("Panel", tempo, "");
	//attribute_info_4.AddClass("attribute_info")

//	let neutral_labal = $.CreatePanel("Label", attribute_info_4, "");
//	neutral_labal.AddClass("hero_label")
//	neutral_labal.text = $.Localize("#item_neutral")

	//const neutral_row =  $.CreatePanel("Panel", tempo, "AllHeroes");




	for (var i = 0; i < Object.keys(damage_items).length; i++) 
	{
		CreateItemPanel(damage_row, damage_items[i], ent)
	}

	for (var i = 0; i < Object.keys(surv_items).length; i++) 
	{
		CreateItemPanel(surv_row, surv_items[i], ent)
	}

	for (var i = 0; i < Object.keys(util_items).length; i++) 
	{
		CreateItemPanel(util_row, util_items[i], ent)
	}

	//for (var i = 0; i < Object.keys(neutral_items).length; i++) 
	//{
//		CreateItemPanel(neutral_row, neutral_items[i], ent)
	//}
}


function CreateItemPanel(panel, item_name, ent) 
{



	var item = $.CreatePanel("DOTAItemImage", panel, item_name)
	item.AddClass("ItemImage")
	item.itemname = item_name

    SetClickEnt(item, item_name, "AddBotItem", ent)

}





var item_list = 
[	
	"item_aghanims_shard",
	"item_patrol_razor",
	"item_patrol_trap",
	"item_patrol_vision",
	"item_gem_custom",
	"item_gray_upgrade",
	"item_blue_upgrade",
	"item_purple_upgrade",
	"item_legendary_upgrade",
	"item_patrol_reward_1",
	"item_patrol_reward_2",
	"item_tier5_token",
	"item_tier4_token",
	"item_tier3_token",
	"item_tier2_token",
	"item_tier1_token",
	"item_alchemist_gold_heart",
	"item_alchemist_gold_octarine",
	"item_alchemist_gold_cuirass",
	"item_alchemist_gold_daedalus",
	"item_alchemist_gold_skadi",
	"item_alchemist_gold_shiva",
	"item_alchemist_gold_satanic",
	"item_alchemist_gold_khanda",
	"item_muerta_mercy_and_grace_full_custom",


]

function ShowItems()
{
	ClearWindow()

	let items_button = $.GetContextPanel().FindChildTraverse("GiveItem")

	items_button.AddClass("TestMode_botton_pressed")

	current_state = 2

	let main = $.GetContextPanel().FindChildTraverse("TestMode_Content")

	main.AddClass("TestMode_Content_Items")

	let tempo = $.CreatePanel("Panel", main, "TestMode_content_tempo")
	tempo.AddClass("TestMode_content_tempo")
	tempo.AddClass("flow_down")
	tempo.AddClass("HeroItemsList")



	const neutral_row =  $.CreatePanel("Panel", tempo, "AllHeroes");

	for (const name of Object.values(item_list)) 
	{
		
		let item = $.CreatePanel("DOTAItemImage", neutral_row, name)
		item.AddClass("ItemImage");
		item.itemname = name

		SetClick(item, name, "AddItem")
	}


}

function UpdateTeamHeroes()
{

	let team_selector = $.GetContextPanel().FindChildTraverse("team_selector")
	if (!team_selector) return

	let max_teams = Game.GetMaxTeams()
	let max_in_team = Game.GetGameMode()
	let players_heroes = CustomNetTables.GetTableValue("test_mode", "players_heroes")

    var max_heroes = max_teams*max_in_team

	for (var i = 1; i <= Object.keys(players_heroes).length; i++) 
	{
		if (players_heroes[i])
		{	
			var team = players_heroes[i].team
			var pos_in_team = players_heroes[i].pos_in_team
	    	var hero = Entities.GetUnitName(players_heroes[i].ent)

			let panel = $.GetContextPanel().FindChildTraverse("teams_panel_" + team + "_" + pos_in_team)
			if (panel)
			{
				panel.style.backgroundImage =  "url('file://{images}/heroes/icons/" + hero + ".png')"
			    panel.style.backgroundSize = "contain";
			    panel.style.backgroundRepeat = "no-repeat";
			}
		}
	}
}

var spawn_for_team = 1


function UpdateTeamSelector()
{
	let team_selector = $.GetContextPanel().FindChildTraverse("team_selector")
	if (!team_selector) return

	let team_status = CustomNetTables.GetTableValue("test_mode", "team_status")

	if (!team_status) return

	let spawn_data = team_status[spawn_for_team]
	if (spawn_data && spawn_data.is_full == 1)
	{
		spawn_for_team = -1
	}

	for (var i = 1; i <= Object.keys(team_status).length; i++) 
	{
		let data = team_status[i]
		let panel = $.GetContextPanel().FindChildTraverse("teams_panel_" + i)
		if (panel && data)
		{
			if (data.is_full == 1)
			{
				panel.AddClass("teams_panel_full")
				panel.RemoveClass("teams_panel_current")
				panel.SetPanelEvent("onactivate", function(){});
			}else
			{
				panel.RemoveClass("teams_panel_full")

				if (spawn_for_team == -1)
				{
					spawn_for_team = i
				} 

				if (spawn_for_team == i)
				{
					panel.AddClass("teams_panel_current")
				}else
				{
					panel.RemoveClass("teams_panel_current")
				}
				SetSelectTeam(panel, i)
			}
		}
	}
}

function SetSelectTeam(panel, i)
{
	panel.SetPanelEvent("onactivate", function() 
	{	
		spawn_for_team = i
		UpdateTeamSelector()
		Game.EmitSound("UI.Click")	
	});
}


function ShowHeroes()
{
	ClearWindow()

	let heroes_button = $.GetContextPanel().FindChildTraverse("CreateBot")
	heroes_button.AddClass("TestMode_botton_pressed")

	current_state = 3



	let main = $.GetContextPanel().FindChildTraverse("TestMode_Content")
	let max_teams = Game.GetMaxTeams()
	let max_in_team = Game.GetGameMode()

	main.AddClass("TestMode_Content_Heroes")

	let tempo = $.CreatePanel("Panel", main, "TestMode_content_tempo")
	tempo.AddClass("TestMode_content_tempo")
	tempo.AddClass("flow_down")
	tempo.AddClass("HeroList")

	let team_selector = $.CreatePanel("Panel", tempo, "team_selector")
	team_selector.AddClass("team_selector_panel")

	let team_label_panel = $.CreatePanel("Panel", team_selector, "")
	team_label_panel.AddClass("team_label_panel")

	let team_label = $.CreatePanel("Label", team_label_panel, "")
	team_label.AddClass("team_label")
	team_label.text = "Команда"

	let all_teams_panel = $.CreatePanel("Panel", team_selector, "")
	all_teams_panel.AddClass("all_teams_panel")

	let teams_panels = []

	for (var i = 1; i <= max_teams; i++) 
	{
		teams_panels[i] = $.CreatePanel("Panel", all_teams_panel, "teams_panel_" + i)
		teams_panels[i].AddClass("teams_panel")
		teams_panels[i].style.width = String(max_in_team*50) + "px"

		teams_panels[i].heroes = []

		for (var j = 1; j <= max_in_team; j++) 
		{
			teams_panels[i].heroes[j] = $.CreatePanel("Panel", teams_panels[i], "teams_panel_" + i + "_" + j)
			teams_panels[i].heroes[j].AddClass("teams_panel_hero")
		}
	}

	UpdateTeamHeroes()
	UpdateTeamSelector()

	let table_heroes = CustomNetTables.GetTableValue("custom_pick", "hero_list")

	const hero_names_sorted = [...Object.keys(table_heroes)].sort()

	let heroes_strength = []
	let heroes_agility = []
	let heroes_intellect = []
	let heroes_all = []

	for (const hero_name of hero_names_sorted)
	{
		if (table_heroes[hero_name] == 0)
		{
			heroes_strength.push(hero_name)
		} else if (table_heroes[hero_name] == 1) {
			heroes_agility.push(hero_name)
		} else if (table_heroes[hero_name] == 2) {
			heroes_intellect.push(hero_name)
		} else if (table_heroes[hero_name] == 3) {
			heroes_all.push(hero_name)
		}
	}



	let attribute_info = $.CreatePanel("Panel", tempo, "");
	attribute_info.AddClass("attribute_info")

	let hero_icon_str = $.CreatePanel("Panel", attribute_info, "");
	hero_icon_str.AddClass("hero_icon_str")

	let hero_label_str = $.CreatePanel("Label", attribute_info, "");
	hero_label_str.AddClass("hero_label")
	hero_label_str.text = $.Localize("#DOTA_Tooltip_Ability_item_power_treads_str")

	const str_row = $.CreatePanel("Panel", tempo, "StrengthHeroes");


	let attribute_info_2 = $.CreatePanel("Panel", tempo, "");
	attribute_info_2.AddClass("attribute_info")

	let hero_icon_agi = $.CreatePanel("Panel", attribute_info_2, "");
	hero_icon_agi.AddClass("hero_icon_agi")

	let hero_label_agi = $.CreatePanel("Label", attribute_info_2, "");
	hero_label_agi.AddClass("hero_label")
	hero_label_agi.text = $.Localize("#DOTA_Tooltip_Ability_item_power_treads_agi")



	const agi_row = $.CreatePanel("Panel", tempo, "AgilityHeroes");


	let attribute_info_3 = $.CreatePanel("Panel", tempo, "");
	attribute_info_3.AddClass("attribute_info")

	let hero_icon_int = $.CreatePanel("Panel", attribute_info_3, "");
	hero_icon_int.AddClass("hero_icon_int")

	let hero_label_int = $.CreatePanel("Label", attribute_info_3, "");
	hero_label_int.AddClass("hero_label")
	hero_label_int.text = $.Localize("#DOTA_Tooltip_Ability_item_power_treads_int")

	const int_row = $.CreatePanel("Panel", tempo, "IntellectHeroes");


	let attribute_info_4 = $.CreatePanel("Panel", tempo, "");
	attribute_info_4.AddClass("attribute_info")

	let hero_icon_all = $.CreatePanel("Panel", attribute_info_4, "");
	hero_icon_all.AddClass("hero_icon_all")

	let hero_label_all = $.CreatePanel("Label", attribute_info_4, "");
	hero_label_all.AddClass("hero_label")
	hero_label_all.text = $.Localize("#stats_all")

	const all_row = $.CreatePanel("Panel", tempo, "AllHeroes");

	for (var i = 0; i < Object.keys(heroes_strength).length; i++) 
	{
		CreateHeroPanel(str_row, heroes_strength[i], 1)
	}

	for (var i = 0; i < Object.keys(heroes_agility).length; i++) 
	{
		CreateHeroPanel(agi_row, heroes_agility[i], 2)
	}

	for (var i = 0; i < Object.keys(heroes_intellect).length; i++) 
	{
		CreateHeroPanel(int_row, heroes_intellect[i], 3)
	}

	for (var i = 0; i < Object.keys(heroes_all).length; i++) 
	{
		CreateHeroPanel(all_row, heroes_all[i], 4)
	}
	
	CheckBannedHeroes()
}





function CreateHeroPanel(panel, hero_name, stat) 
{

	var HeroImage = $.CreatePanel("Panel", panel, hero_name)
	HeroImage.AddClass("HeroImage")
	HeroImage.style.backgroundImage = "url('file://{images}/heroes/" + String(hero_name) + ".png')"
    HeroImage.style.backgroundSize = "contain";
    HeroImage.style.backgroundRepeat = "no-repeat";

    SetClick(HeroImage, hero_name, "AddHero")

}



function ShowBotTalents()
{

	if (selected_ent == -1)
	{
		GameEvents.SendCustomGameEventToServer_custom("NoBot", {})
		return
	}

	ClearWindow()
	current_state = 5

	let button = $.GetContextPanel().FindChildTraverse("GiveBotTalent")
	button.AddClass("TestMode_botton_pressed")

	let main = $.GetContextPanel().FindChildTraverse("TestMode_Content")
	main.AddClass("TestMode_Content_BotTalents")
	main.RemoveClass("TestMode_Content_BotTalents_Hero_Talents")

	let tempo = $.CreatePanel("Panel", main, "TestMode_content_tempo")
	tempo.AddClass("TestMode_content_tempo")
	tempo.AddClass("flow_down")


	DrawTalents(tempo, selected_ent, true)
}

function ShowTalents()
{


	var PlayersHeroes = CustomNetTables.GetTableValue("test_mode", "players_heroes")
	let ent = -1 

	if (PlayersHeroes && PlayersHeroes !== undefined)
	{
		for (const data of Object.values(PlayersHeroes))
		{
			if (data.id == Game.GetLocalPlayerID())
			{
				ent = data.ent 
				break
			}
		} 
	}


	if (ent == -1)
		return

	ClearWindow()
	current_state = 1

	let button = $.GetContextPanel().FindChildTraverse("TalentsList")
	button.AddClass("TestMode_botton_pressed")

	let main = $.GetContextPanel().FindChildTraverse("TestMode_Content")
	main.AddClass("TestMode_Content_Talents")
	main.RemoveClass("TestMode_Content_Hero_Talents")
	main.RemoveClass("TestMode_Content_Hero_Talents_Height")

	let tempo = $.CreatePanel("Panel", main, "TestMode_content_tempo")
	tempo.AddClass("TestMode_content_tempo")
	tempo.AddClass("flow_down")

	
	DrawTalents(tempo, ent)
}




function DrawTalents(main, ent, show_bot)
{

    var hero = Entities.GetUnitName(ent)
    var parent_panel = main.GetParent()

    let use_new_system = false
    if (Game.new_talent_system[hero])
        use_new_system = true

	let orange_layer = $.CreatePanel("Panel", main, "OrangeLayer")
	orange_layer.AddClass("OrangeLayer")

	let purple_layer = $.CreatePanel("Panel", main, "PurpleLayer")
	purple_layer.AddClass("PurpleLayer")

	let blue_layer = $.CreatePanel("Panel", main, "BlueLayer")
	blue_layer.AddClass("BlueLayer")

	let general_layer = $.CreatePanel("Panel", main, "GeneralLayer")
	let general_layer_purple 
	let general_layer_blue
	let general_layer_gray

	var more_talents = (hero == "npc_dota_hero_broodmother" || hero == "npc_dota_hero_invoker")
    var player_table = CustomNetTables.GetTableValue("upgrades_player", hero)


	if (use_new_system == false)
	{
		general_layer.AddClass("GeneralLayer")

		general_layer_purple = $.CreatePanel("Panel", general_layer, "")
		general_layer_purple.AddClass("GeneralPurple_Layer")

		general_layer_blue = $.CreatePanel("Panel", general_layer, "")
		general_layer_blue.AddClass("GeneralBlue_Layer")

		general_layer_gray = $.CreatePanel("Panel", general_layer, "")
		general_layer_gray.AddClass("GeneralGray_Layer")
	}else
	{
		parent_panel.RemoveClass("TestMode_Content_BotTalents")
		parent_panel.RemoveClass("TestMode_Content_Talents")

		if (show_bot)
		{	
			parent_panel.AddClass("TestMode_Content_BotTalents_Hero_Talents")
		}else
		{
			parent_panel.AddClass("TestMode_Content_Hero_Talents")
		}

		general_layer.AddClass("GeneralLayer_hero_talents")
		general_layer_gray = $.CreatePanel("Panel", general_layer, "")
		general_layer_gray.AddClass("GeneralGray_Layer_hero_talents")
		if (more_talents)
		{
			parent_panel.AddClass("TestMode_Content_Hero_Talents_Height")
			let more_talents_layer = $.CreatePanel("Panel", main, "")
			more_talents_layer.AddClass("more_talents_layer")

			let talent_table = Game.talents_values["broodmother_spiders"]
			if (hero == "npc_dota_hero_invoker")
				talent_table = Game.talents_values["invoker_spells"]

	        Object.entries(talent_table).map(([key, data]) => (data["name"] = key, data["name_number"] = key[Object.keys(key).length - 1], data))

	        talent_table = Object.values(talent_table)
	        talent_table.sort((a, b) => (a["name_number"] - b["name_number"]))

		    for (const data of talent_table)
		    {
		        let rarity = data["rarity"]
		        let mini_icon = data["mini_icon"]
		        let name = data["name"]
		        let max_lvl = data["max_level"]
		        let lvl
		        
		        if (player_table !== undefined)
		            lvl = player_table.upgrades[name]

		        var talent_panel = $.CreatePanel("Panel", more_talents_layer, name)
		        talent_panel.AddClass("GeneralTalent")

		        if (rarity == "blue")
		        {
					talent_panel.AddClass("blue_border")
				}else
				{
					talent_panel.AddClass("purple_border")
				}

		        talent_panel.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/' + hero + '/' + mini_icon + '.png")';
		        talent_panel.style.backgroundSize = "contain";
		        talent_panel.style.backgroundRepeat = "no-repeat";

	            let level = $.CreatePanel("Label", talent_panel, name + '_count')
	            level.AddClass("GeneralTalent_count")

		        if (lvl !== undefined) 
		        {
	        		talent_panel.RemoveClass("NoTalent")
	            	level.text = String(lvl)
		        }else
		        {
	        		talent_panel.AddClass("NoTalent")
		        }

	            MouseOverTalent(talent_panel, '#upgrade_disc_' + name, name, lvl, true, false)
	        	SetClickEnt(talent_panel, name, "AddTalent", ent)
		    }
		}
	}


    let purple_blocks = []
    let blue_blocks = []
    let orange_blocks = []

    if (use_new_system == false)
    {
	    for (var i = 1; i <= 4; i++)
	    {
	    	orange_blocks[i] = $.CreatePanel("Panel", orange_layer, "")
	    	orange_blocks[i].AddClass("Block_container")

	    	let container = $.CreatePanel("Panel", purple_layer, "")
	    	container.AddClass("Block_container")

	    	purple_blocks[i] = $.CreatePanel("Panel", container, "")
	    	purple_blocks[i].AddClass("TalentBlocks")
	    
			container = $.CreatePanel("Panel", blue_layer, "")
	    	container.AddClass("Block_container")

	    	blue_blocks[i] = $.CreatePanel("Panel", container, "")
	    	blue_blocks[i].AddClass("TalentBlocks")
	    }	
	}else
	{
	    for (var i = 0; i <= 4; i++)
	    {
	    	let block_class = "Block_container_hero_skill"
	    	if (i == 0)
	    		block_class = "Block_container_hero"

	    	orange_blocks[i] = $.CreatePanel("Panel", orange_layer, "")
	    	orange_blocks[i].AddClass(block_class)

	    	if (i == 0)
	    	{
	    		let icon = $.CreatePanel("Panel", orange_blocks[i], "")
	    		icon.AddClass("Hero_talents_hero")
		        icon.style.backgroundImage = 'url( "file://{images}/heroes/' + Game.GetHeroImage(Game.GetLocalPlayerID(), hero) + '.png" );'
		        icon.style.backgroundSize = 'contain';
		        icon.style.backgroundRepeat = 'no-repeat'
	    	}

	    	let container = $.CreatePanel("Panel", purple_layer, "")
	    	container.AddClass(block_class)

	    	purple_blocks[i] = $.CreatePanel("Panel", container, "")
	    	purple_blocks[i].AddClass("TalentBlocks")
	    
			container = $.CreatePanel("Panel", blue_layer, "")
	    	container.AddClass(block_class)

	    	blue_blocks[i] = $.CreatePanel("Panel", container, "")
	    	blue_blocks[i].AddClass("TalentBlocks")
	    }	
	}


    let talent_table = Game.talents_values[hero]
    Object.entries(talent_table).map(([key, data]) => (data["name"] = key, data["name_number"] = key[Object.keys(key).length - 1], data))

    talent_table = Object.values(talent_table)
    talent_table.sort((a, b) => (a["skill_number"] - b["skill_number"]))

    var skills_array = {}

    for (const index in talent_table)
    {
        let number = talent_table[index]["skill_number"]
        let name_number = talent_table[index]["name_number"]

        if (name_number == "y")  name_number = "7"
        if (!skills_array[number]) skills_array[number] = []   

        talent_table[index]["name_number"] = Number(name_number)

        skills_array[number].push(talent_table[index])
    }


    for (const skill in skills_array)
	{

        skills_array[skill].sort((a, b) => (a["name_number"] - b["name_number"]))

        for (const data of skills_array[skill])
        {
            let icon_name = data["mini_icon"]
            let skill_number = data["skill_number"]
            let rarity = data["rarity"]
            let name = data["name"]
            let max_level = Game.GetMaxLevel(data)

       		let lvl = undefined

            if (player_table !== undefined)
                lvl = player_table.upgrades[name]

			let icon 

			if (rarity == "orange")
			{
				icon = $.CreatePanel("Panel", orange_blocks[skill_number], name)
				icon.AddClass("OrangeLayer_icon")
	            MouseOverTalent(icon, '#upgrade_disc_' + name, name, lvl, false, true)
			}

			if (rarity == "purple")
			{

				let icon_and_level = $.CreatePanel("Panel", purple_blocks[skill_number], "")
				icon_and_level.AddClass("icon_and_level")
				icon_and_level.AddClass("purple_border")

				icon = $.CreatePanel("Panel", icon_and_level, name)
				icon.AddClass("PurpleBlueLayer_icon")

	            MouseOverTalent(icon, "#upgrade_disc_" + name, name, lvl, true)
	            
	            s = 'slevel_0'

	            if (lvl !== undefined) 
	            {
					s = 'epic_level_' + max_level + lvl

				}

	            let level = $.CreatePanel("Panel", icon_and_level, name + "_level")
	            level.AddClass("PurpleBlueLayer_level")
				level.AddClass("purple_border_top")
	            level.style.backgroundImage = 'url("file://{images}/custom_game/' + s + '.png")';
	            level.style.backgroundSize = "100%";
	            level.style.backgroundRepeat = "no-repeat";
			}


			if (rarity == "blue")
			{
				let icon_and_level = $.CreatePanel("Panel", blue_blocks[skill_number], "")
				icon_and_level.AddClass("icon_and_level")
				icon_and_level.AddClass("blue_border")

				icon = $.CreatePanel("Panel", icon_and_level, name)
				icon.AddClass("PurpleBlueLayer_icon")

	            MouseOverTalent(icon, '#upgrade_disc_' + name, name, lvl, true)
	            
	        	s = 'slevel_0'

	            if (lvl !== undefined) 
	            {
					s = 'blue_level_' + lvl
				}


				let level = $.CreatePanel("Panel", icon_and_level, name + "_level")
	            level.AddClass("PurpleBlueLayer_level")
				level.AddClass("blue_border_top")
	            level.style.backgroundImage = 'url("file://{images}/custom_game/' + s + '.png")';
	            level.style.backgroundSize = "100%";
	            level.style.backgroundRepeat = "no-repeat";
			}


			if (icon && icon !== undefined)
			{
		        icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/' + hero + '/' + icon_name + '.png")';
		        icon.style.backgroundSize = "contain";
		        icon.style.backgroundRepeat = "no-repeat";

		        if (lvl == undefined) 
		        {
		        	icon.AddClass("NoTalent")
		        }
		        SetClickEnt(icon, name, "AddTalent",  ent)
		    }
		}
	}



    for (const name in Game.talents_values["general"]) 
	{
        let data = Game.talents_values["general"][name]
        let rarity = data["rarity"]
        let icon_name = data["skill_icon"]

		let lvl
		
        if (player_table !== undefined)
			lvl = player_table.upgrades[name]

		let icon 

		if (rarity == "gray")
		{
			let general_bonus = data["general_bonus"]
			icon = $.CreatePanel("Panel", general_layer_gray, name)
			icon.AddClass("GeneralTalent")
			icon.AddClass("gray_border")

            var t = '+' + String(Math.trunc(general_bonus)) + $.Localize('#talent_disc_' + name)
            MouseOver(icon, t)

            let level = $.CreatePanel("Label", icon, name + '_count')
            level.AddClass("GeneralTalent_count")

            if (lvl !== undefined)
            level.text = String(lvl)

		}

		if (use_new_system == false)
		{

			if (rarity == "blue")
			{
				icon = $.CreatePanel("Panel", general_layer_blue, name)
				icon.AddClass("GeneralTalent")
				icon.AddClass("blue_border")
				let fake_lvl = lvl !== undefined ? lvl : 1
	            MouseOverTalent(icon, '#upgrade_disc_' + name, name, lvl, true)

	            let level = $.CreatePanel("Label", icon, name + '_count')
	            level.AddClass("GeneralTalent_count")

	            if (lvl !== undefined)
	            level.text = String(lvl)

			}
			if (rarity == "purple")
			{
				icon = $.CreatePanel("Panel", general_layer_purple, name)
				icon.AddClass("GeneralTalent")
				icon.AddClass("purple_border")
	            MouseOverTalent(icon, '#upgrade_disc_' + name, name, lvl, true)
			}
		}

		if (icon && icon !== undefined)
		{
	        icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/general/' + icon_name + '.png")';
	        icon.style.backgroundSize = "contain";
	        icon.style.backgroundRepeat = "no-repeat";

	        if (lvl == undefined) 
	        {
	        	icon.AddClass("NoTalent")
	        }
	        SetClickEnt(icon, name, "AddTalent", ent)
	    }
	}
}



function MouseOverTalent(panel, talent_text, name, lvl, all_levels, legendary) 
{

    panel.SetPanelEvent('onmouseover', function() 
    {
        let text = Game.ShowTalentValues(talent_text, name, lvl, all_levels, legendary)

        $.DispatchEvent('DOTAShowTextTooltip', panel, text)
    });

    panel.SetPanelEvent('onmouseout', function() 
    {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });

}

function MouseOver(panel, text) {
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', panel, text)
    });

    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });

}




function update_test_talents(data)
{

	let lvl = data.level
	let type = data.type
	let name = data.name
	let max = data.max

	let icon = $.GetContextPanel().FindChildTraverse(name)
	let level = $.GetContextPanel().FindChildTraverse(name + '_level')
	let count = $.GetContextPanel().FindChildTraverse(name + '_count')

	if (icon && icon !== undefined)
	{
		icon.RemoveClass("NoTalent")
	}

	if (level && level !== undefined)
	{
		if (type == "purple")
		{
			let s = 'slevel_0'

            if (lvl !== undefined) 
            {
				s = 'epic_level_' + max + lvl
			}
            level.style.backgroundImage = 'url("file://{images}/custom_game/' + s + '.png")';
            level.style.backgroundSize = "100%";
            level.style.backgroundRepeat = "no-repeat";
		}

		if (type == "blue")
		{
			s = 'slevel_0'

            if (lvl !== undefined) 
            {
				s = 'blue_level_' + lvl
			}
            level.style.backgroundImage = 'url("file://{images}/custom_game/' + s + '.png")';
            level.style.backgroundSize = "100%";
            level.style.backgroundRepeat = "no-repeat";
		}
	}
	if (count && count !== undefined)
	{
		count.text = String(lvl)
	}

}




var pick_cd = false


function SetClickEnt(panel, value, event, ent)
{


	panel.SetPanelEvent("onactivate", function() 
	{
		if (pick_cd == true)
		return

		pick_cd = true

		$.Schedule( 0.1, function(){ 
			pick_cd = false
		})

		Game.EmitSound("UI.Click")	
   		GameEvents.SendCustomGameEventToServer_custom(event, {value, ent})
	});
}


function SetClick(panel, value, event)
{


	panel.SetPanelEvent("onactivate", function() 
	{
		if (pick_cd == true)
		return

		pick_cd = true

		$.Schedule( 0.1, function(){ 
			pick_cd = false
		})

		Game.EmitSound("UI.Click")	
   		GameEvents.SendCustomGameEventToServer_custom(event, {value: value, spawn_for_team: spawn_for_team})
	});
}


function GiveLevel(value)
{

	Game.EmitSound("UI.Click")	
	GameEvents.SendCustomGameEventToServer_custom("AddLevel", {value})
}

function GiveGold(value)
{

	Game.EmitSound("UI.Click")	
	GameEvents.SendCustomGameEventToServer_custom("AddGold", {value})
}


function LevelBots(value)
{

	Game.EmitSound("UI.Click")	
	if (selected_ent == -1)
	{
		GameEvents.SendCustomGameEventToServer_custom("NoBot", {})
		return
	}

	let ent = selected_ent
	GameEvents.SendCustomGameEventToServer_custom("LevelBots", {value, ent})
}

function StopTimer()
{

	Game.EmitSound("UI.Click")	
	GameEvents.SendCustomGameEventToServer_custom("stop_timer", {})
}
function RefreshButton()
{

	Game.EmitSound("UI.Click")	
	GameEvents.SendCustomGameEventToServer_custom("RefreshButton", {})
}

function WtfMode()
{
	Game.EmitSound("UI.Click")	
	GameEvents.SendCustomGameEventToServer_custom("wtf_mode", {})
}

function HudButton()
{
	Game.EmitSound("UI.Click")	
	GameEvents.SendCustomGameEventToServer_custom("HudButton", {})
}

function update_hud_hidden(data)
{
	let state = data.state
	$("#HudButton").SetHasClass("TestMode_botton_pressed", state == 1)

	let main_hud = $.GetContextPanel().GetParent().GetParent().GetParent()
	let dota_hud = main_hud.FindChildTraverse("HUDElements")
	let top_hud = main_hud.FindChildTraverse("CustomUIContainer_HudTopBar")
	let TalentUI = main_hud.FindChildTraverse("TalentUI_long_Panel").GetParent()
	let button = $.GetContextPanel().FindChildTraverse("TestMode_button")

	if (dota_hud)
		dota_hud.style.visibility = state == 1 ? "collapse" : "visible"

	if (top_hud)
		top_hud.style.visibility = state == 1 ? "collapse" : "visible"

	if (button)
		button.SetHasClass("TestMode_button_no_hud", state == 1)

	if (TalentUI)
	{
		if (state == 1)
		{
			TalentUI.SetParent(main_hud)
			TalentUI.style.width = "30%"
			TalentUI.style.height = "30%"
			TalentUI.style.align = "center center"
			TalentUI.style.marginTop = "700px"
			TalentUI.style.marginLeft = "130px"
			TalentUI.style.uiScale = "140%"
		}else
		{
			TalentUI.SetParent(main_hud.FindChildTraverse("center_block"))
			TalentUI.style.width = "100%"
			TalentUI.style.height = "100%"
			TalentUI.style.marginTop = "0px"
			TalentUI.style.marginLeft = "0px"
			TalentUI.style.uiScale = "100%"
		}
	}
}


function GetDotaHud()
{
    let hPanel = $.GetContextPanel();
    while ( hPanel && hPanel.id !== 'Hud')
    {
        hPanel = hPanel.GetParent();
    }
    if (!hPanel)
    {
        throw new Error('Could not find Hud root from panel with id: ' + $.GetContextPanel().id);
    }
    return hPanel;
}

function FindDotaHudElement(sId)
{
    return GetDotaHud().FindChildTraverse(sId);
}

var PortraitSettings = $("#PortraitSettings")
var portraitHUD = FindDotaHudElement("portraitHUD")
PortraitSettings.SetParent(portraitHUD)
function OpenPortrait()
{
    Game.EmitSound("UI.Click")
    $("#PortraitButton").ToggleClass("TestMode_botton_pressed")
    PortraitSettings.visible = !PortraitSettings.visible
    for (let child of portraitHUD.Children())
    {
        if (child.id && child.id.includes("PortaitsScene_"))
        {
            child.visible = PortraitSettings.visible ? false : true
        }
    }
}

init()
CheckSelectedUnit()