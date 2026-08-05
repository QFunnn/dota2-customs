--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 19:52:08 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
if (parentHUDElements) {
	var center_block = parentHUDElements.FindChildTraverse("center_block");
	if (center_block) {
		$.GetContextPanel().SetParent(center_block);
	}
}

function OnRebindClicked() {
	GameEvents.SendCustomGameEventToServer("RefreshHeroBindings", {
		PlayerID: Players.GetLocalPlayer()
	});
	$.DispatchEvent("DropInputFocus");
}

function OnRebindMouseOver() {
	$.DispatchEvent("DOTAShowTextTooltip", $.GetContextPanel(), $.Localize("#rebind_button_tooltip"));
}

function OnRebindMouseOut() {
	$.DispatchEvent("DOTAHideTextTooltip");
}