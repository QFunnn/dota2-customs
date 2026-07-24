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
	GameEvents.Subscribe('alchemist_progress_update', OnProgress)
	GameEvents.Subscribe('alchemist_progress_close', OnClose)
	FlipInit()
}

function FlipInit()
{
	var parentHUDElements = $.GetContextPanel().GetParent().GetParent().FindChildTraverse("QuickBuyRows");
	var stash = $.GetContextPanel().GetParent().GetParent().FindChildTraverse("stash_bg");
	var Row = parentHUDElements.FindChildTraverse("Row1") 
	var Info = $.GetContextPanel().FindChildTraverse("AlchemistPoints");
	var alchemist_flip = $.GetContextPanel().FindChildTraverse("AlchemistPanel");



	var bonus = 0
	var margin = 0

	if (Row.visible)
	{	
		margin = 57
		bonus = 0
	}
	else
	{
		margin = 57
		bonus = 0
	}

	if (stash.visible)
	{	
		margin = 41 - bonus
	}

	var text = String(margin) + '%'
	alchemist_flip.style.marginTop = text

    $.Schedule(0.3, FlipInit)
	
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

init();