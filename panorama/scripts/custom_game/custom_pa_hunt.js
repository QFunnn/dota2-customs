--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



function init()
{
  GameEvents.Subscribe('pa_hunt_think', pa_hunt_think)
  GameEvents.Subscribe('pa_hunt_end', pa_hunt_end)
}

function pa_hunt_think(kv)
{


  let main = $.GetContextPanel().FindChildTraverse("PA_Hunt_Panel")
  if (main.BHasClass("PA_Hunt_Panel_hidden"))
  {
    main.RemoveClass("PA_Hunt_Panel_hidden")
    main.AddClass("PA_Hunt_Panel")
  }



  let hero_icon = $.GetContextPanel().FindChildTraverse("PA_Hunt_Icon")
  hero_icon.style.backgroundImage = "url('file://{images}/heroes/" + kv.hero + ".png')"
  hero_icon.style.backgroundSize = "contain";

  let gold = $.GetContextPanel().FindChildTraverse("PA_Hunt_gold_number")
  gold.text = String(kv.gold)

  let text = '0:' + String(kv.timer)
  if (kv.timer < 10) 
  {
    text = '0:0' + String(kv.timer)
  }

  let timer = $.GetContextPanel().FindChildTraverse("PA_Hunt_gold_timer")
  timer.text = text

}


function pa_hunt_end(kv)
{


  let main = $.GetContextPanel().FindChildTraverse("PA_Hunt_Panel")
  
  if (main.BHasClass("PA_Hunt_Panel"))
  {
    main.RemoveClass("PA_Hunt_Panel")
    main.AddClass("PA_Hunt_Panel_hidden")
  }
}

init()