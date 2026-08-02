--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


var playerID = Players.GetLocalPlayer()
var main_panel = $("#menu_up_items")
main_panel.visible = false

function Upgrade_deactivate(){
	main_panel.visible = false
	Game.EmitSound("ui_select_arrow")
}

function Upgrade_activate(t){
	$.Msg(t)
	main_panel.visible = true
	var count = 0
	if (t.shop.now < 1){
		$("#item_kamen_text").text =  0
	}else{
		$("#item_kamen_text").text = $.Localize("#stone_in_storage")+t.shop.now
	}
	for (let i = 0; i < 5; i++) {
		count += 1
		if(Object.keys(t.items['set'])[i]){
			let item_name = Object.keys(t.items['set'])[i]
			let level = t.items['set'][Object.keys(t.items['set'])[i]]
			$.Msg(item_name)	
			$.Msg(level)	
			$("#item_"+count).itemname = item_name
			$("#item_"+count+"_text").text = $.Localize("#DOTA_Tooltip_ability_"+item_name) + " " +  level
			$("#item_"+count).SetPanelEvent("onmouseover", function(){		
			let params =
				`itemName=` +
				item_name +
				`&itemLevel=` +
				level;
				$.DispatchEvent("UIShowCustomLayoutParametersTooltip", $("#item_"+count), "SetItemTooltip", "file://{resources}/layout/custom_game/custom_tooltip/custom_tooltip.xml", params);
			});
			$("#item_"+count).SetPanelEvent("onmouseout", function(){ $.DispatchEvent("UIHideCustomLayoutTooltip", $("#item_"+count), "SetItemTooltip");});
		}else{
			$("#item_"+count).itemname = ''
			$("#item_"+count+"_text").text = ''
		}
	}
}

(function() {
   	GameEvents.Subscribe("Upgrade_activate", Upgrade_activate);
	GameEvents.Subscribe("Upgrade_deactivate", Upgrade_deactivate);
})();


function upItem(itemId) {
	item = $("#" + itemId).itemname;
	if (item) {
		GameEvents.SendCustomGameEventToServer("up_item_level", {item: item});
	} else {
		$.Msg(2);
	}
}
