--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


$("#guild_event_container").visible = false

function start_event(){
	$.Msg("!")
	GameEvents.SendCustomGameEventToServer("TryStartTeamEvent", {})
	$("#guild_event_container").visible = false
}

function Guild_event_show(t) {
    $("#guild_event_container").visible = true
}

function Guild_event_hide(t) {
    $("#guild_event_container").visible = false
}

GameEvents.Subscribe("Guild_event_show", Guild_event_show);
GameEvents.Subscribe("Guild_event_hide", Guild_event_hide);

function ErrorMessage(data){
	GameEvents.SendEventClientSide("dota_hud_error_message",
	{
		"splitscreenplayer": 0,
		"reason": 80,
		"message": data.message
	})
}

GameEvents.Subscribe("CreateIngameErrorMessage", function(data) { ErrorMessage(data) })