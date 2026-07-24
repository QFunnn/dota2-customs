--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



function init()
{

  GameEvents.Subscribe('marci_rage_change', marci_rage_change)

  GameEvents.Subscribe('alchemist_progress_update', OnProgress)
  GameEvents.Subscribe('alchemist_progress_close', OnClose)
}

function marci_rage_change(kv)
{
  let main = $.GetContextPanel().FindChildTraverse("MarciRage_Panel")
  if (main.BHasClass("MarciRage_Panel_hidden"))
  {
    main.RemoveClass("MarciRage_Panel_hidden")
    main.AddClass("MarciRage_Panel")
  }


  let filler = $.GetContextPanel().FindChildTraverse("MarciRage_Filler")

  let width = (kv.rage/kv.max) * 95
  let text = String(width)+'%'

  filler.style.width = text

  let number = $.GetContextPanel().FindChildTraverse("MarciRage_Number")
  number.text = String(kv.rage)
}


function OnProgress(data)
{
  $('#AlchemistPanel').visible = true
  $('#AlchemistNumber').text = data.current_gold + " / " + data.max_gold
  let gold_percentage = ((data.max_gold-data.current_gold)*95)/data.max_gold
  $('#AlchemistProgress').style['width'] = (95 - gold_percentage) +'%';
} 

function OnClose(data)
{
  $.Msg('qqqq')
  $('#AlchemistPanel').visible = false
} 


init()