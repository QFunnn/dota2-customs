--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
$.GetContextPanel().SetParent(parentHUDElements);


function init() {
	GameEvents.Subscribe_custom('show_skill_event', show_skill)
	GameEvents.Subscribe_custom('ShowAltTalents', ShowAltTalents)
}

init();
var table = [0,0,0,0,0,0]

function show_skill(kv) 
{
	let hero = kv.hero
	let is_general = false

	let data = Game.talents_values[hero][kv.skill] 
	if (data == undefined)
	{
		is_general = true
		data = Game.talents_values["general"][kv.skill] 
	}

	let n = Math.abs($("#PickEvent").GetChildCount())
	if (n >= 5)
		return

	for (var i = 1; i <= 6; i++)
		if (table[i] == 0) {
			table[i] = 1
			break 
		}

	let text = ""
	let margin = String((i - 1)*16.6666)

	let event = $.CreatePanel("Panel",$("#PickEvent"),"event")
	event.AddClass("event")

	let skill_icon = $.CreatePanel("Panel",event,"skill_icon")
	skill_icon.style.backgroundSize = "contain"
	skill_icon.AddClass("skill_icon")

	let text_box = $.CreatePanel("Panel",event,"text_box")
	text_box.AddClass("text_box")


	let text_skill = $.CreatePanel("Label",text_box,"text_skill")
	text_skill.html = true
	text_skill.AddClass("text_skill")

	// text_skill.text = "Эпические сферы улучшения содержат дополнительный выбор"
	text_skill.text = $.Localize("#mini_disc_" + kv.skill)

	if (is_general == false)
	 {
		if (data["rarity"] == "orange") 
			skill_icon.style.boxShadow = "fill #f29400 0px 0px 2px 1px"
		
		skill_icon.style.backgroundImage = 'url( "file://{images}/custom_game/icons/mini/' + hero + '/' + data["mini_icon"] + '.png" );'
	}else
	{
		skill_icon.style.backgroundImage = 'url( "file://{images}/custom_game/icons/mini/general/' + data["skill_icon"] + '.png" );'
	}	


	text = margin + '%'
	event.style.marginTop = text
	event.style.backgroundImage = 'url("s2r://panorama/images/hud/reborn/item_purchase_bg_psd.vtex")'

	let portrait = $.CreatePanel("Panel",event,"portrait")
	portrait.AddClass("portrait")
	portrait.style.backgroundImage = 'url( "file://{images}/heroes/icons/' + hero + '.png" );'
	portrait.style.backgroundSize = "contain"


	$.Schedule( 7.55, function(){ 
		event.RemoveClass("event");
		event.AddClass("event_close");
		table[i] = 0
	})
	event.DeleteAsync( 8 );

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
		let level = Game.HasTalent(hero_name, name, true)

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

		talent_text.text = Game.ShowTalentValues("#upgrade_disc_" + name, name, level, false, false, false, false, legendary)
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