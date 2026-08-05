--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


// var iIndexTip = 1; 
// var LOADINGTIP_CHANGE_DELAY = 6;

// var availableIndexTable = 
// [
    // 1,2,3,4,5,6,7,8,9,10
// ]

// function NextTip_Delay()
// {
    // NextTip();
    // $.Schedule(LOADINGTIP_CHANGE_DELAY, NextTip_Delay);
// }

// function RandomTipIndex()
// {
    // var randomIndex = Math.floor(Math.random()*availableIndexTable.length);
    // while(availableIndexTable[(randomIndex).toString()] == iIndexTip)
    // {
        
        // randomIndex = Math.floor(Math.random()*availableIndexTable.length);
    // }
    // return availableIndexTable[(randomIndex).toString()];
// }

// function NextTip()
// {
    // iIndexTip = RandomTipIndex();
    // var sTip = "#LoadingTip_" + iIndexTip;
    // $("#TipLabel").text=$.Localize(sTip);
// }

// (function()
// {
    // iIndexTip = RandomTipIndex();
    // var sTip = "#LoadingTip_" + iIndexTip;
    // $("#TipLabel").text=$.Localize(sTip);
    // NextTip_Delay();
// })();

function init_diff(id){
	var diff = id[1]
	var hittestBlocker = $.GetContextPanel().GetParent().FindChild("SidebarAndBattleCupLayoutContainer");
	hittestBlocker.visible = false

	var parentPanel = $.GetContextPanel().FindChildTraverse("Diff_container");
	var childPanels = parentPanel.Children();

	for (var i = 0; i < diff; i++) {
		var allD = childPanels[i];
		var difIcons = allD.FindChildrenWithClassTraverse("dif_icon");
		for (var j = 0; j < difIcons.length; j++) {
			var childPanel = difIcons[j];
		
			childPanel.style.backgroundImage = "url('file://{resources}/images/custom_game/loading_screen/num_unlock.png')";
			var id = childPanel.id;
			var index = childPanel.tabindex;
			childPanel.SetHasClass("lock", false);
			
			childPanel.SetPanelEvent("onmouseover", function(panel) {
				return function() {
					panel.SetHasClass("hovered", true);
					TipsOver(panel, panel)
				};
			}(childPanel));
					
			childPanel.SetPanelEvent("onmouseout", function(panel) {
				return function() {
					panel.SetHasClass("hovered", false);
					TipsOut()
				};
			}(childPanel));
		
			childPanel.SetPanelEvent("onmouseactivate", function(index, id) {
				return function() {
					select_diff(index, id);
				};
			}(index, id));
		}
	}
}

function TipsOver(pos, message)
{
	if (typeof(pos) == 'object'){
		pos = pos.id
	}
	$.DispatchEvent( "DOTAShowTextTooltip", $("#"+pos), $.Localize('#'+pos));
}

function TipsOut()
{
    $.DispatchEvent( "DOTAHideTitleTextTooltip");
    $.DispatchEvent( "DOTAHideTextTooltip");
}

function select_diff(index, id){
	if ( Players.GetLocalPlayer() == 0) {
		var parentPanel = $.GetContextPanel().FindChildTraverse("Diff_container");
		var difIcons = parentPanel.FindChildrenWithClassTraverse("dif_icon");
		for (var i = 0; i < difIcons.length; i++) {
			var difIcon = difIcons[i];
			difIcon.ClearPanelEvent("onmouseactivate")
		}
		GameEvents.SendCustomGameEventToServer("choise_diff", {index, id})	
	}
}

function update_diff(t){
	panel = $("#"+t.id)
	panel.style.boxShadow = '0px 0px 20px green';
	var TabPanel = $.CreatePanel("Panel", panel.GetParent(), "Target");
}	


function back(t){
	c = $("#"+t).Children("images-back")
	c[1].visible = true;
	TipsOver($("#"+t), "sad")
}

function unback(t){
	c = $("#"+t).Children("images-back")
	c[1].visible = false;
	TipsOut()
}


(function(){
	GameEvents.Subscribe( "init_diff", init_diff)
	GameEvents.Subscribe( "update_diff", update_diff)
})();