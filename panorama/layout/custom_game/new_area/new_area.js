--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameEvents.Subscribe_custom( 'event_new_area', SetNewArea );

function SetNewArea(data) 
{
	$.Schedule( 0.5, function(){
		Game.EmitSound("ui.badge_levelup")
		$("#new_area").style.opacity = "1"
	})
	let language = $.Language()
	if (language == "russian")
	{
		$("#new_area").style.backgroundImage = 'url("file://{images}/custom_game/talents/' + data.arena + 'arearussian.png")';
		$("#new_area").style.backgroundSize = "100%"
	} else {
		$("#new_area").style.backgroundImage = 'url("file://{images}/custom_game/talents/' + data.arena + 'areaenglish.png")';
		$("#new_area").style.backgroundSize = "100%"
	}
	$.Schedule( 4.9, function(){
		$("#new_area").style.opacity = "0" 
	})
}

GameEvents.Subscribe_custom( 'event_new_area_duel', SetNewAreaDuel );

function SetNewAreaDuel(data) 
{
	$.Schedule( 0.5, function(){
		Game.EmitSound("ui.badge_levelup")
		$("#new_area_duel").style.opacity = "1"
	})
	let language = $.Language()
	if (language == "russian")
	{
		$("#new_area_duel").style.backgroundImage = 'url("file://{images}/custom_game/talents/' + 'areaduelrussian.png")';
		$("#new_area_duel").style.backgroundSize = "100%"
	} else {
		$("#new_area_duel").style.backgroundImage = 'url("file://{images}/custom_game/talents/' + 'areaduelenglish.png")';
		$("#new_area_duel").style.backgroundSize = "100%"
	}
	$.Schedule( 4.9, function(){
		$("#new_area_duel").style.opacity = "0"
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

	if (Game.GetMapInfo().map_display_name == "arena")
	{
		$("#new_area_gamemode").style.backgroundImage = 'url("file://{images}/custom_game/talents/' + 'logo_arena.png")';
		$("#new_area_gamemode").style.backgroundSize = "100%"
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