--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


CustomNetTables.SubscribeNetTableListener( "test_mode", UpdateHeroInfo );

var BotHeroes = CustomNetTables.GetTableValue("test_mode", "bot_heroes")

var local_ent = -1

function UpdateHeroInfo(table, key, data )
{
	if (table == "test_mode")
	{
		if (key == "players_heroes")
		{
			$.Schedule(0.1, UpdateTeamHeroes)
			$.Schedule(0.1, CheckSelectedUnit)
		}
		if (key == "team_status")
		{
			UpdateTeamSelector()
		}

		if (key == "target_dummy")
		{
			UpdateTargetDummy()
			CheckSelectedUnit()
		}
	}
}

var selected_ent = -1
var extra_heroes = {}
var selected_no_talents = false
var selected_dummy = false

function CheckSelectedUnit()
{
	var PlayersHeroes = CustomNetTables.GetTableValue("test_mode", "players_heroes")

	if (local_ent == -1 && PlayersHeroes)
	{
		for (const lua_data of Object.values(PlayersHeroes))
		{
			if (lua_data.id == Game.GetLocalPlayerID())
			{
				local_ent = lua_data.ent
				break
			}
		}
	}

	let ent = Players.GetLocalPlayerPortraitUnit()
	let is_dummy = target_dummy_ent !== -1 && ent == target_dummy_ent
	let is_hero = false

	let old_ent = selected_ent

	if (PlayersHeroes)
	{
		for (const lua_data of Object.values(PlayersHeroes))
		{
			if (ent == lua_data.ent)
			{
				is_hero = true
				break
			}
		}
	}

	if (is_dummy == false && is_hero == false)
		ent = local_ent

	selected_ent = ent
	selected_dummy = is_dummy
	selected_no_talents = is_dummy || (ent !== -1 && Game.IsNoTalentsHero(Entities.GetUnitName(ent)))

	let talents_button = $.GetContextPanel().FindChildTraverse("TalentsList")

	if (talents_button)
		talents_button.SetHasClass("TestMode_btn_disabled", selected_no_talents)

	let icon_name = "url('file://{images}/custom_game/no_hero.png')"

	if (is_dummy)
		icon_name = "url('file://{images}/heroes/icons/npc_dota_hero_tidehunter.png')"
	else if (selected_ent !== -1)
		icon_name = "url('file://{images}/heroes/icons/" + String(Entities.GetUnitName(selected_ent)) + ".png')"

	let icon = $.GetContextPanel().FindChildTraverse("GiveBotTalent_icon")

	if (icon !== undefined)
	{
		icon.style.backgroundImage = icon_name
		icon.style.backgroundSize = "contain";
		icon.style.backgroundRepeat = "no-repeat";
	}

	if (old_ent !== selected_ent)
	{
		if (current_state == 1)
			ShowTalents()

		if (current_state == 2)
			ShowItems()
	}
}

function update_selected_unit()
{
	$.Schedule(0, CheckSelectedUnit)
}

function init()
{
	GameEvents.Subscribe_custom("update_test_talents", update_test_talents)
	GameEvents.Subscribe_custom("lua_timer_stop", lua_timer_stop)
	GameEvents.Subscribe_custom("lua_wtf_mode", lua_wtf_mode)
	GameEvents.Subscribe_custom("set_test_mode", set_test_mode)
	GameEvents.Subscribe_custom("update_hud_hidden", update_hud_hidden)
	GameEvents.Subscribe_custom("update_time_scale", update_time_scale)
	GameEvents.Subscribe_custom("update_wave_number", update_wave_number)
	GameEvents.Subscribe_custom("update_particle_log", update_particle_log)
	GameEvents.Subscribe_custom("update_vision", update_vision)

	GameEvents.Subscribe("dota_player_update_selected_unit", update_selected_unit)
	GameEvents.Subscribe("dota_player_update_query_unit", update_selected_unit)
}

var timer_stopped = false
var wtf_mode = false
var time_scale_value = "1"
var wave_number_value = ""
var test_mode_inited = false

function lua_timer_stop(kv)
{
	timer_stopped = kv.stop == 1

	let button = $.GetContextPanel().FindChildTraverse("StopTimer")

	if (button)
		button.SetHasClass("TestMode_botton_pressed", timer_stopped)
}

function lua_wtf_mode(kv)
{
	wtf_mode = kv.wtf == 1

	let button = $.GetContextPanel().FindChildTraverse("WtfMode")

	if (button)
		button.SetHasClass("TestMode_botton_pressed", wtf_mode)
}

function set_test_mode(kv)
{
	let state = kv.state

	let main = $.GetContextPanel().FindChildTraverse("TestMode_panel_and_button")

	if (main == undefined)
		return

	if (state != 1 || test_mode_inited)
		return

	test_mode_inited = true

	if (!main.BHasClass("TestMode_open"))
	{
		main.RemoveClass("TestMode_disabled")
		ChangeState()
		if (Game.IsInToolsMode())
		{
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
		ShowInterface()
	}

	if (type == 5)
	{
		ShowObjects()
	}

	if (type == 6)
	{
		ShowTime()
	}
}

var current_state = 0

function ClearWindow()
{
	let talents_button = $.GetContextPanel().FindChildTraverse("TalentsList")
	let items_button = $.GetContextPanel().FindChildTraverse("GiveItem")
	let heroes_button = $.GetContextPanel().FindChildTraverse("CreateBot")
	let interface_button = $.GetContextPanel().FindChildTraverse("InterfaceWindow")
	let objects_button = $.GetContextPanel().FindChildTraverse("ObjectsWindow")
	let time_button = $.GetContextPanel().FindChildTraverse("TimeWindow")

	let main = $.GetContextPanel().FindChildTraverse("TestMode_Content")

	heroes_button.RemoveClass("TestMode_botton_pressed")
	talents_button.RemoveClass("TestMode_botton_pressed")
	items_button.RemoveClass("TestMode_botton_pressed")
	interface_button.RemoveClass("TestMode_botton_pressed")
	objects_button.RemoveClass("TestMode_botton_pressed")
	time_button.RemoveClass("TestMode_botton_pressed")

	main.RemoveClass("TestMode_Content_Items")
	main.RemoveClass("TestMode_Content_Talents")
	main.RemoveClass("TestMode_Content_Hero_Talents")
	main.RemoveClass("TestMode_Content_Hero_Talents_Height")
	main.RemoveClass("TestMode_Content_Heroes")
	main.RemoveClass("TestMode_Content_BotItems")
	main.RemoveClass("TestMode_Content_BotTalents")
	main.RemoveClass("TestMode_Content_BotTalents_Hero_Talents")
	main.RemoveClass("TestMode_Content_Buttons")

	let tempo = $.GetContextPanel().FindChildTraverse("TestMode_content_tempo")

	if (tempo && tempo !== undefined)
	{
		tempo.DeleteAsync(0)
	}

	CloseLaneWaves()
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

var shop_sections = ["basics", "support", "magics", "defense", "weapons", "artifacts"]
var shop_items = {}

GameEvents.Subscribe_custom('send_items', update_items)

GameEvents.OnLoaded(function()
{
	GameEvents.SendCustomGameEventToServer_custom("request_items", {})
})

var neutral_tiers = {}
var neutral_tier = 1
var neutral_items_row
var neutral_enhancements_row
var neutral_tier_label

function update_items(data)
{
	shop_items = data.shop
	neutral_tiers = data.neutral

	if (current_state == 2)
		ShowItems()
}

var neutral_items =
[
	"item_titan_sliver",
	"item_book_of_shadows",
	"item_mirror_shield",
	"item_force_boots_custom",
	"item_pirate_hat",

]

function CreateItemPanel(panel, item_name, ent, level)
{
	var item = $.CreatePanel("DOTAItemImage", panel, item_name)
	item.AddClass("ItemImage")
	item.itemname = item_name

	SetClickEnt(item, item_name, "AddBotItem", ent, level)
}

var unique_items =
[
	"item_ultimate_scepter_2",
	"item_aghanims_shard",
	"item_patrol_razor",
	"item_patrol_trap",
	"item_gem_custom",
	"item_gray_upgrade",
	"item_blue_upgrade",
	"item_purple_upgrade",
	"item_legendary_upgrade",
	"item_patrol_reward_1",
	"item_patrol_reward_2",
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
	if (selected_ent == -1)
	{
		GameEvents.SendCustomGameEventToServer_custom("NoBot", {})
		return
	}

	let ent = selected_ent

	ClearWindow()

	let items_button = $.GetContextPanel().FindChildTraverse("GiveItem")

	items_button.AddClass("TestMode_botton_pressed")

	current_state = 2

	let main = $.GetContextPanel().FindChildTraverse("TestMode_Content")

	main.AddClass("TestMode_Content_BotItems")

	let tempo = $.CreatePanel("Panel", main, "TestMode_content_tempo")
	tempo.AddClass("TestMode_content_tempo")
	tempo.AddClass("flow_down")
	tempo.AddClass("ItemsList")

	const columns = $.CreatePanel("Panel", tempo, "");
	columns.AddClass("ItemColumns")

	for (const section of shop_sections)
		CreateItemCategory(columns, "#shop_" + section, Object.values(shop_items[section] || {}), ent)

	const side = $.CreatePanel("Panel", tempo, "");
	side.AddClass("ItemSide")

	CreateItemCategory(side, "#item_unique", unique_items, ent)
	CreateNeutralCategory(side, ent)
}

function CreateCategoryLabel(parent, header)
{
	let attribute_info = $.CreatePanel("Panel", parent, "");
	attribute_info.AddClass("attribute_info")

	let label = $.CreatePanel("Label", attribute_info, "");
	label.AddClass("hero_label")
	label.text = $.Localize(header)
}

function CreateNeutralCategory(side, ent)
{
	const category = $.CreatePanel("Panel", side, "");
	category.AddClass("ItemCategory")

	CreateCategoryLabel(category, "#item_neutral")

	const switcher = $.CreatePanel("Panel", category, "");
	switcher.AddClass("NeutralTierSwitch")

	CreateTierButton(switcher, "-", -1, ent)

	neutral_tier_label = $.CreatePanel("Label", switcher, "");
	neutral_tier_label.AddClass("NeutralTierLabel")

	CreateTierButton(switcher, "+", 1, ent)

	neutral_items_row = $.CreatePanel("Panel", category, "");
	neutral_items_row.AddClass("NeutralRow")

	neutral_enhancements_row = $.CreatePanel("Panel", category, "");
	neutral_enhancements_row.AddClass("NeutralRow")

	FillNeutralTier(ent)
}

function CreateTierButton(switcher, text, delta, ent)
{
	const button = $.CreatePanel("Button", switcher, "");
	button.AddClass("NeutralTierButton")

	const label = $.CreatePanel("Label", button, "");
	label.text = text

	button.SetPanelEvent("onactivate", function()
	{
		neutral_tier = Math.min(5, Math.max(1, neutral_tier + delta))

		Game.EmitSound("UI.Click")
		FillNeutralTier(ent)
	})
}

function FillNeutralTier(ent)
{
	const tier = neutral_tiers[String(neutral_tier)] || {}
	const enhancements = tier.enhancements ? tier.enhancements.global : {}

	neutral_tier_label.text = $.Localize("#item_neutral_tier") + " " + String(neutral_tier)

	neutral_items_row.RemoveAndDeleteChildren()
	neutral_enhancements_row.RemoveAndDeleteChildren()

	for (const name in tier.items || {})
		CreateItemPanel(neutral_items_row, name, ent)

	for (const name in enhancements || {})
		CreateItemPanel(neutral_enhancements_row, name, ent, Number(enhancements[name]))
}

function CreateItemCategory(tempo, header, list, ent)
{
	const category = $.CreatePanel("Panel", tempo, "");
	category.AddClass("ItemCategory")

	CreateCategoryLabel(category, header)

	const row = $.CreatePanel("Panel", category, "");
	row.AddClass("ItemRow")

	for (const name of Object.values(list))
	{
		CreateItemPanel(row, name, ent)
	}
}

function CreateRow(parent, id)
{
	let block = $.CreatePanel("Panel", parent, id)
	block.AddClass("TestMode_block")

	return block
}

function CreateButton(parent, id, text, callback, pressed)
{
	let button = $.CreatePanel("Panel", parent, id)
	button.AddClass("TestMode_btn")
	button.SetHasClass("TestMode_botton_pressed", pressed == true)
	button.SetPanelEvent("onactivate", callback)

	let label = $.CreatePanel("Label", button, id + "_text")
	label.AddClass("TestMode_btn_text")
	label.text = $.Localize(text)

	return button
}

function CreateWindowButton(parent, id, text, callback, pressed)
{
	let block = CreateRow(parent, "")

	CreateButton(block, id, text, callback, pressed)

	return block
}

function CreateWindow(button_id, state)
{
	ClearWindow()

	let button = $.GetContextPanel().FindChildTraverse(button_id)

	button.AddClass("TestMode_botton_pressed")

	current_state = state

	let main = $.GetContextPanel().FindChildTraverse("TestMode_Content")

	main.AddClass("TestMode_Content_Buttons")

	let tempo = $.CreatePanel("Panel", main, "TestMode_content_tempo")
	tempo.AddClass("TestMode_window_list")

	return tempo
}

function ShowTime()
{
	let tempo = CreateWindow("TimeWindow", 6)

	let stop = CreateRow(tempo, "StopTimer_block")

	SetTooltip(CreateButton(stop, "StopTimer", "#stop_timer", StopTimer, timer_stopped), "#stop_timer_tooltip")

	let scale = CreateRow(tempo, "TimeScaleBlock")

	SetTooltip(scale, "#time_scale_tooltip")

	let minus = CreateButton(scale, "TimeScaleMinus", "-", function(){ TimeScale(-1) }, false)
	minus.AddClass("TestMode_btn_small")

	let value = $.CreatePanel("Panel", scale, "TimeScaleValue")
	value.AddClass("TestMode_btn_value")

	let value_label = $.CreatePanel("Label", value, "TimeScaleValue_text")
	value_label.AddClass("TestMode_btn_text")
	value_label.text = time_scale_value

	let plus = CreateButton(scale, "TimeScalePlus", "+", function(){ TimeScale(1) }, false)
	plus.AddClass("TestMode_btn_small")

	let wave = CreateRow(tempo, "WaveNumberBlock")

	SetTooltip(wave, "#wave_number_tooltip")

	let wave_minus = CreateButton(wave, "WaveNumberMinus", "-", function(){ WaveNumber(-1) }, false)
	wave_minus.AddClass("TestMode_btn_small")

	let wave_value = $.CreatePanel("Panel", wave, "WaveNumberValue")
	wave_value.AddClass("TestMode_btn_value")

	let wave_label = $.CreatePanel("Label", wave_value, "WaveNumberValue_text")
	wave_label.AddClass("TestMode_btn_text")
	wave_label.text = wave_number_value

	let wave_plus = CreateButton(wave, "WaveNumberPlus", "+", function(){ WaveNumber(1) }, false)
	wave_plus.AddClass("TestMode_btn_small")

	GameEvents.SendCustomGameEventToServer_custom("WaveNumber", {step: 0})

	let row = CreateRow(tempo, "WtfMode_block")

	let wtf = CreateButton(row, "WtfMode", "#wtf_mode", WtfMode, wtf_mode)
	wtf.AddClass("TestMode_btn_small")
	SetTooltip(wtf, "#wtf_mode_tooltip")

	let refresh = CreateButton(row, "RefreshButton", "#refresh_button", RefreshButton, false)
	refresh.AddClass("TestMode_btn_small")
	SetTooltip(refresh, "#refresh_button_tooltip")
}

function ShowInterface()
{
	let tempo = CreateWindow("InterfaceWindow", 4)

	CreateWindowButton(tempo, "HudButton", "#hud_button", HudButton, hud_hidden)
	CreateWindowButton(tempo, "PortraitButton", "#portrait_button", OpenPortrait, portrait_open)
	CreateWindowButton(tempo, "VisionButton", "#vision_button", Vision, vision_all)
	CreateWindowButton(tempo, "ParticleLog", "#particle_log", ParticleLog, particle_log)
}

var patrol_types = ["1", "2", "T"]
var patrol_type = 0
var lane_waves_open = false
var lane_waves_window = null

function ShowObjects()
{
	let tempo = CreateWindow("ObjectsWindow", 5)

	CreateWindowButton(tempo, "BountyRunes", "#bounty_runes", BountyRunes, false)
	CreateWindowButton(tempo, "OrbShrines", "#orb_shrines", OrbShrines, false)
	CreateWindowButton(tempo, "JungleCreeps", "#jungle_creeps", JungleCreeps, false)

	let block = CreateWindowButton(tempo, "SpawnPatrol", "#spawn_patrol", SpawnPatrol, false)

	let type_button = CreateButton(block, "PatrolType", patrol_types[patrol_type], TogglePatrolType, false)
	type_button.AddClass("TestMode_btn_type")

	CreateWindowButton(tempo, "LaneWaves", "#lane_waves", ToggleLaneWaves, lane_waves_open)

	if (lane_waves_open)
		ShowLaneWaves()
}

function ShowLaneWaves()
{
	let main = $.GetContextPanel().FindChildTraverse("TestMode_Content")

	lane_waves_window = $.CreatePanel("Panel", main.GetParent(), "")
	lane_waves_window.AddClass("TestMode_wave_window")

	let list = $.CreatePanel("Panel", lane_waves_window, "")
	list.AddClass("TestMode_wave_list")

	let waves = CustomNetTables.GetTableValue("test_mode", "lane_waves") || {}
	let keys = Object.keys(waves).sort((a, b) => (waves[a].creeps_type - waves[b].creeps_type) || (a - b))

	for (const key of keys)
	{
		let skills = Object.values(waves[key].skills || {})

		let icon = $.CreatePanel("DOTAAbilityImage", list, "")
		icon.AddClass("TestMode_wave")
		icon.abilityname = skills.length > 0 ? skills[0] : "kobold_taskmaster_speed_aura"
		icon.SetPanelEvent("onactivate", function(){ LaneWave(Number(key)) })

		SetTooltip(icon, "#wave_name_" + waves[key].creeps[1])
	}
}

function TogglePatrolType()
{
	Game.EmitSound("UI.Click")

	patrol_type = (patrol_type + 1) % patrol_types.length

	let label = $.GetContextPanel().FindChildTraverse("PatrolType_text")

	if (label)
		label.text = patrol_types[patrol_type]
}

function SpawnPatrol()
{
	Game.EmitSound("UI.Click")
	GameEvents.SendCustomGameEventToServer_custom("SpawnPatrol", {type: patrol_type + 1})
}

function ToggleLaneWaves()
{
	Game.EmitSound("UI.Click")

	lane_waves_open = !lane_waves_open

	let button = $.GetContextPanel().FindChildTraverse("LaneWaves")

	if (button)
		button.SetHasClass("TestMode_botton_pressed", lane_waves_open)

	if (lane_waves_open)
		ShowLaneWaves()
	else
		CloseLaneWaves()
}

function CloseLaneWaves()
{
	if (!lane_waves_window)
		return

	lane_waves_window.DeleteAsync(0)
	lane_waves_window = null
}

function LaneWave(index)
{
	Game.EmitSound("UI.Click")

	if (selected_ent == -1 || selected_dummy)
	{
		GameEvents.SendCustomGameEventToServer_custom("NoBot", {})
		return
	}

	GameEvents.SendCustomGameEventToServer_custom("LaneWave", {value: index, ent: selected_ent})
}

function UpdateTeamHeroes()
{
	let team_selector = $.GetContextPanel().FindChildTraverse("team_selector")
	if (!team_selector) return

	let max_teams = Game.GetMaxTeams()
	let max_in_team = Game.GetGameMode()
	let players_heroes = CustomNetTables.GetTableValue("test_mode", "players_heroes")

	if (!players_heroes) return

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
	let table_extra = CustomNetTables.GetTableValue("custom_pick", "hero_list_extra")

	extra_heroes = {}

	if (table_extra)
	{
		for (const hero_name of Object.keys(table_extra))
		{
			extra_heroes[hero_name] = true
			table_heroes[hero_name] = table_extra[hero_name]
		}
	}

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
		CreateHeroPanel(str_row, heroes_strength[i], 1, extra_heroes[heroes_strength[i]])
	}

	for (var i = 0; i < Object.keys(heroes_agility).length; i++)
	{
		CreateHeroPanel(agi_row, heroes_agility[i], 2, extra_heroes[heroes_agility[i]])
	}

	for (var i = 0; i < Object.keys(heroes_intellect).length; i++)
	{
		CreateHeroPanel(int_row, heroes_intellect[i], 3, extra_heroes[heroes_intellect[i]])
	}

	for (var i = 0; i < Object.keys(heroes_all).length; i++)
	{
		CreateHeroPanel(all_row, heroes_all[i], 4, extra_heroes[heroes_all[i]])
	}
}

function CreateHeroPanel(panel, hero_name, stat, no_talents)
{
	var HeroImage = $.CreatePanel("Panel", panel, hero_name)
	HeroImage.AddClass("HeroImage")

	let icon = $.CreatePanel("Panel", HeroImage, "")
	icon.AddClass("HeroImage_icon")
	icon.style.backgroundImage = "url('file://{images}/heroes/" + String(hero_name) + ".png')"
	icon.style.backgroundSize = "contain";
	icon.style.backgroundRepeat = "no-repeat";

	if (no_talents)
	{
		icon.AddClass("HeroImage_extra")

		let shade = $.CreatePanel("Panel", HeroImage, "")
		shade.AddClass("HeroImage_shade")

		let mark_bg = $.CreatePanel("Panel", shade, "")
		mark_bg.AddClass("HeroImage_mark_bg")

		let mark = $.CreatePanel("Label", mark_bg, "")
		mark.AddClass("HeroImage_mark")
		mark.text = "!"

		SetTooltip(HeroImage, "#hero_no_talents")
	}

	SetClick(HeroImage, hero_name, "AddHero")
}

function ShowTalents()
{
	if (selected_ent == -1 || selected_no_talents)
	{
		GameEvents.SendCustomGameEventToServer_custom("NoBot", {})
		return
	}

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

	DrawTalents(tempo, selected_ent)
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
	var player_id = Entities.GetPlayerOwnerID(ent)
	var player_table = CustomNetTables.GetTableValue("upgrades_player", String(player_id))

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
				let max_lvl = Game.GetMaxLevel(data)
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

				Game.MouseOverTalent(talent_panel, '#upgrade_disc_' + name, name, lvl, true, rarity, max_lvl, player_id, hero)
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
				Game.MouseOverTalent(icon, '#upgrade_disc_' + name, name, lvl, false, "legendary", max_level, player_id, hero)
			}

			if (rarity == "purple")
			{
				let icon_and_level = $.CreatePanel("Panel", purple_blocks[skill_number], "")
				icon_and_level.AddClass("icon_and_level")
				icon_and_level.AddClass("purple_border")

				icon = $.CreatePanel("Panel", icon_and_level, name)
				icon.AddClass("PurpleBlueLayer_icon")

				Game.MouseOverTalent(icon, "#upgrade_disc_" + name, name, lvl, true, rarity, max_level, player_id, hero)

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

				Game.MouseOverTalent(icon, '#upgrade_disc_' + name, name, lvl, true, rarity, max_level, player_id, hero)

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
		let max_level = Game.GetMaxLevel(data)

		let lvl

		if (player_table !== undefined)
			lvl = player_table.upgrades[name]

		let icon

		if (rarity == "gray")
		{
			icon = $.CreatePanel("Panel", general_layer_gray, name)
			icon.AddClass("GeneralTalent")
			icon.AddClass("gray_border")

			Game.MouseOverTalent(icon, '#upgrade_disc_' + name, name, lvl, true, "gray", max_level, player_id, hero)

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
				Game.MouseOverTalent(icon, '#upgrade_disc_' + name, name, lvl, true, rarity, max_level, player_id, hero)

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
				Game.MouseOverTalent(icon, '#upgrade_disc_' + name, name, lvl, true, rarity, max_level, player_id, hero)
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
		icon.SetHasClass("NoTalent", lvl == 0)
	}

	if (level && level !== undefined)
	{
		if (type == "purple")
		{
			let s = 'slevel_0'

			if (lvl > 0)
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

			if (lvl > 0)
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
		count.text = lvl > 0 ? String(lvl) : ""
	}
}

var pick_cd = false

function SetClickEnt(panel, value, event, ent, level)
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
		GameEvents.SendCustomGameEventToServer_custom(event, {value, ent, level: level || 0})
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

function GiveGold(value)
{
	Game.EmitSound("UI.Click")
	if (selected_ent == -1)
	{
		GameEvents.SendCustomGameEventToServer_custom("NoBot", {})
		return
	}

	let ent = selected_ent
	GameEvents.SendCustomGameEventToServer_custom("AddGold", {value, ent})
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

function StartHunt()
{
	Game.EmitSound("UI.Click")
	if (selected_ent == -1 || selected_dummy)
	{
		GameEvents.SendCustomGameEventToServer_custom("NoBot", {})
		return
	}

	let ent = selected_ent
	GameEvents.SendCustomGameEventToServer_custom("StartHunt", {ent})
}

function DestroyTower()
{
	Game.EmitSound("UI.Click")
	if (selected_ent == -1 || selected_dummy)
	{
		GameEvents.SendCustomGameEventToServer_custom("NoBot", {})
		return
	}

	let ent = selected_ent
	GameEvents.SendCustomGameEventToServer_custom("DestroyTower", {ent, cycle: tower_cycle ? 1 : 0})
}

function StartDuel()
{
	Game.EmitSound("UI.Click")
	if (selected_ent == -1 || selected_dummy)
	{
		GameEvents.SendCustomGameEventToServer_custom("NoBot", {})
		return
	}

	let ent = selected_ent
	GameEvents.SendCustomGameEventToServer_custom("StartDuel", {ent, final: duel_final ? 1 : 0})
}

var duel_final = false
var tower_cycle = false

function ToggleFinalDuel()
{
	duel_final = !duel_final

	Game.EmitSound("UI.Click")

	let check = $.GetContextPanel().FindChildTraverse("StartDuelFinal")

	if (check)
		check.SetHasClass("TestMode_check_on", duel_final)
}

function ToggleTowerCycle()
{
	tower_cycle = !tower_cycle

	Game.EmitSound("UI.Click")

	let check = $.GetContextPanel().FindChildTraverse("DestroyTowerCycle")

	if (check)
		check.SetHasClass("TestMode_check_on", tower_cycle)
}

function SetTooltip(panel, text)
{
	if (!panel)
		return

	panel.SetPanelEvent("onmouseover", function()
	{
		$.DispatchEvent("DOTAShowTextTooltip", panel, $.Localize(text))
	})

	panel.SetPanelEvent("onmouseout", function()
	{
		$.DispatchEvent("DOTAHideTextTooltip", panel)
	})
}

function SetCheckTooltip(id, text)
{
	SetTooltip($.GetContextPanel().FindChildTraverse(id), text)
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

function TimeScale(step)
{
	Game.EmitSound("UI.Click")
	GameEvents.SendCustomGameEventToServer_custom("TimeScale", {step: step})
}

function update_time_scale(data)
{
	time_scale_value = data.value

	let label = $.GetContextPanel().FindChildTraverse("TimeScaleValue_text")

	if (label)
		label.text = time_scale_value
}

function WaveNumber(step)
{
	Game.EmitSound("UI.Click")
	GameEvents.SendCustomGameEventToServer_custom("WaveNumber", {step: step})
}

function update_wave_number(data)
{
	wave_number_value = String(data.value)

	let label = $.GetContextPanel().FindChildTraverse("WaveNumberValue_text")

	if (label)
		label.text = wave_number_value
}

function BountyRunes()
{
	Game.EmitSound("UI.Click")
	GameEvents.SendCustomGameEventToServer_custom("BountyRunes", {})
}

function OrbShrines()
{
	Game.EmitSound("UI.Click")
	GameEvents.SendCustomGameEventToServer_custom("OrbShrines", {})
}

function JungleCreeps()
{
	Game.EmitSound("UI.Click")
	GameEvents.SendCustomGameEventToServer_custom("JungleCreeps", {})
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

function Vision()
{
	Game.EmitSound("UI.Click")
	GameEvents.SendCustomGameEventToServer_custom("Vision", {})
}

function update_vision(data)
{
	vision_all = data.state == 1

	let button = $.GetContextPanel().FindChildTraverse("VisionButton")

	if (button)
		button.SetHasClass("TestMode_botton_pressed", vision_all)
}

function ParticleLog()
{
	Game.EmitSound("UI.Click")
	GameEvents.SendCustomGameEventToServer_custom("ParticleLog", {})
}

var particle_log = false
var hud_hidden = false
var vision_all = false

function update_particle_log(data)
{
	particle_log = data.state == 1

	let button = $.GetContextPanel().FindChildTraverse("ParticleLog")

	if (button)
		button.SetHasClass("TestMode_botton_pressed", particle_log)
}

var target_dummy_ent = -1

function TargetDummy()
{
	Game.EmitSound("UI.Click")
	GameEvents.SendCustomGameEventToServer_custom("TargetDummy", {})
}

function UpdateTargetDummy()
{
	let data = CustomNetTables.GetTableValue("test_mode", "target_dummy")

	target_dummy_ent = data && data.ent ? data.ent : -1

	let button = $.GetContextPanel().FindChildTraverse("TargetDummy")

	if (button == undefined)
		return

	button.SetHasClass("TestMode_botton_pressed", target_dummy_ent !== -1)
}

function update_hud_hidden(data)
{
	let state = data.state
	hud_hidden = state == 1

	let hud_button = $.GetContextPanel().FindChildTraverse("HudButton")

	if (hud_button)
		hud_button.SetHasClass("TestMode_botton_pressed", hud_hidden)

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
var portraitHUD = null
var portrait_open = false

function InitPortrait()
{
	if (portraitHUD || !PortraitSettings)
		return

	let hud = $.GetContextPanel()
	while (hud && hud.id !== 'Hud')
	{
		hud = hud.GetParent()
	}

	if (!hud)
		return

	portraitHUD = hud.FindChildTraverse("portraitHUD")

	if (portraitHUD)
		PortraitSettings.SetParent(portraitHUD)
}

function OpenPortrait()
{
	InitPortrait()

	if (!portraitHUD)
		return

	Game.EmitSound("UI.Click")

	portrait_open = !portrait_open

	let button = $.GetContextPanel().FindChildTraverse("PortraitButton")

	if (button)
		button.SetHasClass("TestMode_botton_pressed", portrait_open)

	PortraitSettings.visible = portrait_open
	for (let child of portraitHUD.Children())
	{
		if (child.id && child.id.includes("PortaitsScene_"))
		{
			child.visible = PortraitSettings.visible ? false : true
		}
	}
}

init()
UpdateTargetDummy()
SetCheckTooltip("StartDuelFinal", "#start_duel_final_tooltip")
SetCheckTooltip("DestroyTowerCycle", "#destroy_tower_cycle_tooltip")
CheckSelectedUnit()
InitPortrait()