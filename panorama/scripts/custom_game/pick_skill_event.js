--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
$.GetContextPanel().SetParent(parentHUDElements);


function init() {
	GameEvents.Subscribe_custom('show_skill_event', show_skill)
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