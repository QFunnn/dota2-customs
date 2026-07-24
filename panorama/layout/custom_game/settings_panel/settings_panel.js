--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
$.GetContextPanel().SetParent(parentHUDElements);

CustomNetTables.SubscribeNetTableListener( "TipsType", TypeChanged );

function init()
{

	let TalentView = $.GetContextPanel().FindChildTraverse("TalentView")
	let TipPanel = $.GetContextPanel().FindChildTraverse("TipPanel")
	let DuoInfo = $.GetContextPanel().FindChildTraverse("DuoInfo")

	let game_mode = Game.GetGameMode()

	var TalentView_text = $.Localize("#TalentView_info")
	var DuoInfo_text = $.Localize("#DuoInfo_info")


	if (!IsSpectator())
	{
		if (false)
		{
		    TipPanel.RemoveClass("Settings_Panel_collapse")
		}
			
		TalentView.SetPanelEvent('onmouseover', function() {
	    $.DispatchEvent('DOTAShowTextTooltip', TalentView, TalentView_text) });
	    
		TalentView.SetPanelEvent('onmouseout', function() {
	    $.DispatchEvent('DOTAHideTextTooltip', TalentView); });

		TalentView.RemoveClass("Settings_Panel_collapse")
	}

	if (game_mode != 1)
	{
	   // DuoInfo.RemoveClass("Settings_Panel_collapse")

		DuoInfo.SetPanelEvent('onmouseover', function() {
	    $.DispatchEvent('DOTAShowTextTooltip', DuoInfo, DuoInfo_text) });
	    
		DuoInfo.SetPanelEvent('onmouseout', function() {
	    $.DispatchEvent('DOTAHideTextTooltip', DuoInfo); });
	}

}
init()



function SwapTipType() 
{
	let table = CustomNetTables.GetTableValue("TipsType", Players.GetLocalPlayer())
	Game.EmitSound("UI.Click")

	if (table) {
		if (table.type == 1) {
			GameEvents.SendCustomGameEventToServer_custom("ChangeTipsType", {type:2});
		} else if (table.type == 2) {
			GameEvents.SendCustomGameEventToServer_custom("ChangeTipsType", {type:3});
		} else if (table.type == 3) {
			GameEvents.SendCustomGameEventToServer_custom("ChangeTipsType", {type:1});
		}
	}
}

function TypeChanged(table_name, key, data) 
{
	if (key == Players.GetLocalPlayer()) {
		$("#SwapTipType").SetHasClass("type_1", false)
		$("#SwapTipType").SetHasClass("type_2", false)
		$("#SwapTipType").SetHasClass("type_3", false)
		$("#SwapTipType").SetHasClass("type_"+data.type, true)
		SetText($("#TipPanel"), $.Localize("#button_tip_" + data.type))
	}
}


function SetText(panel, text) 
{
	panel.SetPanelEvent('onmouseover', function() 
	{
		$.DispatchEvent('DOTAShowTextTooltip', panel, text) 
	});
		panel.SetPanelEvent('onmouseout', function() 
	{
		$.DispatchEvent('DOTAHideTextTooltip', panel);
	});
}




function IsSpectator() {
	const localPlayer = Players.GetLocalPlayer()
	if (Players.IsSpectator(localPlayer))
		return true
	const localTeam = Players.GetTeam(localPlayer)
	return localTeam !== 2 &&
		localTeam !== 3 &&
		localTeam !== 6 &&
		localTeam !== 7 &&
		localTeam !== 8 &&
		localTeam !== 9
}






function SwapTalentView()
{

	Game.EmitSound("UI.Click")
	GameEvents.SendCustomGameEventToServer_custom("ChangeTalentView", {})
}

