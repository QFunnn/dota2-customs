--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameEvents.Subscribe_custom("woda_pause_start", woda_pause_start)
GameEvents.Subscribe_custom("woda_pause_end", woda_pause_end)
GameEvents.Subscribe_custom("woda_pause_think", woda_pause_think)

function woda_pause_start(data)
{
	let time = data.time
	let hero = Players.GetPlayerHeroEntityIndex(data.id)
	let hero_name = Entities.GetUnitName(hero)
	$("#PauseInfoBlock").style.visibility = "visible"
	$("#HeroIcon").style.backgroundImage = 'url( "file://{images}/heroes/icons/' + hero_name + '.png" );'
	$("#HeroIcon").style.backgroundSize = "100%"
	$("#PauseTime").text = String(data.time)
}

function woda_pause_end(data)
{
	$("#PauseInfoBlock").style.visibility = "collapse"
}

function woda_pause_think(data)
{
	let time = data.time
	$("#PauseTime").text = String(data.time)
}
