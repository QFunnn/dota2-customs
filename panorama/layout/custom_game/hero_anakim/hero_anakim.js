--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


$("#hero_anakim_container").visible = false

function Anakim_show(t) {
	$.Msg("D")
    $("#hero_anakim_container").visible = true
}

function Anakim_hide(t) {
	$.Msg("Da")
    $("#hero_anakim_container").visible = false
}

GameEvents.Subscribe("Anakim_show", Anakim_show);
GameEvents.Subscribe("Anakim_hide", Anakim_hide);