--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
$.GetContextPanel().SetParent(parentHUDElements);

function init()
{
	GameEvents.Subscribe_custom('duel_timer_progress', OnDuelTimer)
	var HeaderText = $.GetContextPanel().FindChildTraverse("DuelHeaderText");
	HeaderText.text = "РАУНД 1"

	var DuelText = $.GetContextPanel().FindChildTraverse("DuelTimerText");
	DuelText.text = "1:00"
	



}

init();





function OnDuelTimer( kv )
{
let time = kv.time
let max = kv.max
let show = kv.show 
let prepair = kv.prepair
let round = kv.round
let hero1 = kv.hero1
let hero2 = kv.hero2 
let wins1 = kv.wins1
let wins2 = kv.wins2


var text = ''


var DuelHero = $.GetContextPanel().FindChildTraverse("DuelHeroLeft");
DuelHero.style.backgroundImage =  'url( "file://{images}/heroes/' + hero1 + '.png")'
DuelHero.style.backgroundSize = '100%'

var DuelHero2 = $.GetContextPanel().FindChildTraverse("DuelHeroRight");
DuelHero2.style.backgroundImage =  'url( "file://{images}/heroes/' + hero2 + '.png")'
DuelHero2.style.backgroundSize = '100%'


var DuelTextLeft = $.GetContextPanel().FindChildTraverse("DuelTimerTextLeft");
DuelTextLeft.text = String(wins1)

var DuelTextRight = $.GetContextPanel().FindChildTraverse("DuelTimerTextRight");
DuelTextRight.text = String(wins2)



var HeaderText = $.GetContextPanel().FindChildTraverse("DuelHeaderText");

if (prepair == 1)
{
	HeaderText.text = $.Localize('#duel_prepair')
}
else 
{
	HeaderText.text = $.Localize('#duel_round') + String(round)
}

$.Schedule(0.9, function (){ 
if (show == 1)
{
	var timer_panel = $.GetContextPanel().FindChildTraverse("AllDuelTimer");

	if (timer_panel.BHasClass("AllDuelTimer"))
	{
		timer_panel.RemoveClass("AllDuelTimer")
		timer_panel.AddClass("AllDuelTimer_show")


	}

}
})

var Timer = $.GetContextPanel().FindChildTraverse("DuelTimerTime");
var TimerText = $.GetContextPanel().FindChildTraverse("DuelTimerText");


text = String(max - time)

var DuelText = $.GetContextPanel().FindChildTraverse("DuelTimerText");
DuelText.text = text

var number = 0
number = 100 - (time/(max)) * 100
text = String(number)+'%'
Timer.style.width = text


}	