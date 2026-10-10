--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


var parentHUDElements = FindDotaHudElement("HUDElements");

var pick_event_panel = $.CreatePanel("Panel", $.GetContextPanel(), "PickEvent")
var pick_event_branches = ["H", "Q", "W", "E", "R"]

function init() {
	pick_event_panel.AddClass("PickEvent")
	pick_event_panel.hittest = false

	$.Schedule(0, function()
	{
		if ($.GetContextPanel().GetParent().id != "HUDElements")
			$.GetContextPanel().SetParent(parentHUDElements)

		let old_panel = parentHUDElements.FindChild("PickEvent")
		if (old_panel)
			old_panel.DeleteAsync(0)

		pick_event_panel.SetParent(parentHUDElements)
		parentHUDElements.MoveChildBefore(pick_event_panel, parentHUDElements.GetChild(0))
	})

	GameEvents.Subscribe_custom('show_skill_event', show_skill)
	GameEvents.Subscribe_custom('ShowAltTalents', ShowAltTalents)
}

init();

function show_skill(kv)
{
	let hero = kv.hero
	let player_id = kv.id
	let name = kv.skill

	let table_name = hero
	let data = Game.talents_values[hero] ? Game.talents_values[hero][name] : undefined

	if (data == undefined)
	{
		for (let find_table_name in Game.talents_values)
		{
			if (Game.talents_values[find_table_name][name] != undefined)
			{
				data = Game.talents_values[find_table_name][name]
				table_name = find_table_name
				break
			}
		}
	}

	if (data == undefined)
		return

	if (pick_event_panel.GetChildCount() >= 6)
		return

	let rarity = data["rarity"]
	let skill_number = data["skill_number"]
	let build_type = data["build_type"]

	let event = $.CreatePanel("Panel", $.GetContextPanel(), "")
	event.AddClass("PickEventRow")
	event.AddClass("PickEventRow_open")
	event.AddClass("PickEventRow_" + rarity)

	let holder = $.CreatePanel("Panel", event, "")
	holder.AddClass("PickEventIconHolder")

	let column = $.CreatePanel("Panel", holder, "")
	column.AddClass("PickEventIconColumn")

	let icon
	let spell = Game.spells_by_number[hero] ? Game.spells_by_number[hero][skill_number] : undefined

	if (rarity == "orange" && spell && spell["name"])
	{
		icon = $.CreatePanel("DOTAAbilityImage", column, "")

		let ability = Entities.GetAbilityByName(Players.GetPlayerHeroEntityIndex(player_id), spell["name"])
		if (ability)
			icon.contextEntityIndex = ability

		icon.abilityname = spell["name"]
	}
	else
	{
		let icon_path = table_name == "general" ? "general/" + data["skill_icon"] : hero + "/" + data["mini_icon"]

		icon = $.CreatePanel("Panel", column, "")
		icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/' + icon_path + '.png")'
	}

	icon.AddClass("PickEventIcon")

	if (pick_event_branches[skill_number])
	{
		let branch = $.CreatePanel("Panel", holder, "")
		branch.AddClass("PickEventBranch")

		let branch_text = $.CreatePanel("Label", branch, "")
		branch_text.AddClass("PickEventBranchText")
		branch_text.text = pick_event_branches[skill_number]
	}

	if (rarity == "orange" && build_type != undefined)
	{
		let build = $.CreatePanel("Label", column, "")
		build.AddClass("PickEventBuild")
		build.AddClass("PickEventBuild_" + build_type)
		build.text = $.Localize("#talent_build_type_" + build_type)
	}
	else if (rarity != "orange")
	{
		let levels = $.CreatePanel("Panel", column, "")
		levels.AddClass("PickEventLevels")

		for (let i = 1; i <= Math.max(Game.GetMaxLevel(data), 1); i++)
		{
			let level = $.CreatePanel("Panel", levels, "")
			level.AddClass("PickEventLevel")
			level.SetHasClass("PickEventLevel_active", i <= kv.level)
		}
	}

	let text = $.CreatePanel("Label", event, "")
	text.html = true
	text.AddClass("PickEventText")
	text.text = $.Localize("#mini_disc_" + name)

	let portrait = $.CreatePanel("Panel", event, "")
	portrait.AddClass("PickEventPortrait")
	portrait.style.backgroundImage = 'url("file://{images}/heroes/icons/' + Game.GetHeroImage(player_id, hero) + '.png")'

	event.SetParent(pick_event_panel)

	$.Schedule(7.55, function()
	{
		event.RemoveClass("PickEventRow_open")
		event.AddClass("PickEventRow_close")
	})

	$.Schedule(8, function()
	{
		event.AddClass("PickEventRow_collapse")
	})

	event.DeleteAsync(8.3)
}

var alt_talent_panel

function ShowAltTalents(data)
{
	let main = $("#AltTalentPanel")
	main.RemoveAndDeleteChildren()

	Game.EmitSound("UI.Alt_talent_info")

	let panel = $.CreatePanel("Panel", main, "")
	panel.AddClass("AltTalentPanel_main")
	panel.AddClass("AltTalentPanel_main_open")

	$.Schedule( 0.45, function(){
		panel.AddClass("AltTalentPanel_main_shadow")
	})

	alt_talent_panel = panel

	let top = $.CreatePanel("Panel", panel, "AltTalentPanel_top")
	let content = $.CreatePanel("Panel", panel, "AltTalentPanel_content")

	let legendary = data.talent
	let talents = data.alt_talents

	let hero = Players.GetLocalPlayerPortraitUnit();
	let hero_name = Entities.GetUnitName(hero)
	let legendary_data = Game.talents_values[hero_name][legendary] 
	let length = Object.keys(talents).length

	let legendary_icon = $.CreatePanel("Panel", top, "AltTalentPanel_legendary_icon")
	legendary_icon.style.backgroundImage = 'url( "file://{images}/custom_game/icons/mini/' + hero_name + '/' + legendary_data["mini_icon"] + '.png" );'
	legendary_icon.style.backgroundSize = "contain"

	let top_text = $.CreatePanel("Panel", top, "AltTalentPanel_top_text")

	let spell_label = $.CreatePanel("Panel", top_text, "AltTalentPanel_top_label")
	let spell_name = $.CreatePanel("Label", spell_label, "AltTalentPanel_spell_name")
	spell_name.text = $.Localize("#DOTA_Tooltip_ability_" + legendary_data["skill_name"])

	let header_label = $.CreatePanel("Panel", top_text, "AltTalentPanel_top_label")
	let header_text = $.CreatePanel("Label", header_label, "AltTalentPanel_header_text")
	header_text.text = $.Localize("#AltTalent_header")

	for (let i in talents)
	{
		let name = talents[i]
		let talent_data = Game.talents_values[hero_name][name] 
		let level = Game.HasTalent(Game.GetLocalPlayerID(), name, true)

		let talent_panel = $.CreatePanel("Panel", content, "AltTalentPanel_talent")

		if (i < length)
			talent_panel.AddClass("AltTalentPanel_talent_border")

		let talent_icon = $.CreatePanel("Panel", talent_panel, "")
		talent_icon.AddClass("AltTalentPanel_talent_icon")
		talent_icon.AddClass("AltTalentPanel_talent_icon_" + talent_data["rarity"])
		talent_icon.style.backgroundImage = 'url( "file://{images}/custom_game/icons/mini/' + hero_name + '/' + talent_data["mini_icon"] + '.png" );'
		talent_icon.style.backgroundSize = "contain"

		let talent_label = $.CreatePanel("Panel", talent_panel, "AltTalentPanel_talent_label")
		let talent_text = $.CreatePanel("Label", talent_label, "AltTalentPanel_talent_text")
		talent_text.html = true

		talent_text.text = Game.ShowTalentValues(Game.GetTalentTextKey("#upgrade_disc_" + name, name), name, level, false, false, false, false, legendary)
	}

	let timer = 7 + length * 3

	panel.DeleteAsync(timer);
	$.Schedule(timer - 0.45, function()
	{ 
		if (alt_talent_panel == panel)
		{
			panel.RemoveClass("AltTalentPanel_main_open");
			panel.RemoveClass("AltTalentPanel_main_shadow");
			panel.AddClass("AltTalentPanel_main_close");
		}
	})
}