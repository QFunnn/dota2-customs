--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


GameEvents.Subscribe_custom( 'event_new_area', SetNewArea );

function SetNewArea(data) 
{
	$("#new_area_label").text = $.Localize("#name_arena_" + data.arena)
	$("#new_area_stage").text = $.Localize("#arena_room_stage") + " " + (Number(data.arena) || 1) + " / " + (Number(data.stages) || 6)
	$("#new_area").RemoveClass("Visible")
	$.Schedule( 0.5, function(){
		Game.EmitSound("ui.badge_levelup")
		$("#new_area").AddClass("Visible")
	})
	$.Schedule( 4.9, function(){
		$("#new_area").RemoveClass("Visible")
	})
}

GameEvents.Subscribe_custom( 'event_new_area_duel', SetNewAreaDuel );

function SetNewAreaDuel(data) 
{
	$("#new_area_duel_label").text = $.Localize((data && data.final == 1) ? "#name_final_duel" : "#name_arena_7")
	$("#new_area_duel").RemoveClass("Visible")
	$.Schedule( 0.5, function(){
		Game.EmitSound("ui.badge_levelup")
		$("#new_area_duel").AddClass("Visible")
	})
	$.Schedule( 4.9, function(){
		$("#new_area_duel").RemoveClass("Visible")
	})
}

GameEvents.Subscribe_custom( 'event_new_area_gamemode', SetNewAreaGameMode );

function SetNewAreaGameMode(data) 
{
	$.Schedule( 0.5, function()
	{
		Game.EmitSound("ui.badge_levelup")
		$("#new_area_gamemode").style.opacity = "1"
	})

	if (/^(arena|1_player|4_player)$/.test(Game.GetMapInfo().map_display_name))
	{
		$("#new_area_gamemode").AddClass("ArenaLogo")
	}

	if (Game.GetMapInfo().map_display_name == "overthrow")
	{
		$("#new_area_gamemode").style.backgroundImage = 'url("file://{images}/custom_game/talents/' + 'logo_overthrow.png")';
		$("#new_area_gamemode").style.backgroundSize = "100%"
	}

	if (Game.GetMapInfo().map_display_name.includes("rating"))
	{
		$("#new_area_gamemode").style.backgroundImage = 'url("file://{images}/custom_game/talents/' + 'logo_rating.png")';
		$("#new_area_gamemode").style.backgroundSize = "100%"
	}

	$.Schedule( 4.9, function()
	{
		$("#new_area_gamemode").style.opacity = "0"
	})
}