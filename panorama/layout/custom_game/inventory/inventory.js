--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


var invopened = false;
var GameTime = false;	
$("#TakeOffItem").visible = false


function OpenInv() {
	$.Msg("!")
	clickingloop()
	invopened = !invopened
	$("#heroequipment").SetHasClass("equipmentopened",invopened)
	update_hero_inv()
}


function ErrorMessage(t) {
	GameEvents.SendEventClientSide( "dota_hud_error_message",{reason: 80, message: t.message} )
}


var OnMouseOverItem = (function(pan, type){
    return function(){
        if(GameTime &&  Game.Time() - GameTime  < 0.25){
			let item = pan.FindChildTraverse('inv_'+type).itemname
			if (!item == ''){
				ErrorMessage("#xyitam")
				return
			}
            let event = {
                slot : ItemNumber,
                type : type,
            }
            GameEvents.SendCustomGameEventToServer("put_item_lua", event)
        }
    }
})


var ReturnItemBack = (function(k, v){
    return function(){	
		let item = k.FindChildTraverse('inv_'+v).itemname
		if (item){
			$("#TakeOffItem").visible = true
			$('#TakeOffItemYes').SetPanelEvent("onmouseactivate",yes(item, k, v))
			$('#TakeOffItemNo').SetPanelEvent("onmouseactivate",no(item, k, v))
		}
    }
})

var yes = (function(item, k, v){
	return function()
	{
		$("#TakeOffItem").visible = false
		$.Msg("yes")
		let event = {
            type : v,
            item : item,
        }
        GameEvents.SendCustomGameEventToServer("return_item_lua", event)
	}
})	

var no = (function(item, k, v){
	return function()
	{
		$("#TakeOffItem").visible = false
		$.Msg("no")
	}
})	

function FindDotaHudElement(panel) {
	return $.GetContextPanel().GetParent().GetParent().GetParent().FindChildTraverse(panel);
}


var lastLoop = false;
function clickingloop(){
    var dragg = false
	for(var i = 0; i < 9;i++){
        if(FindDotaHudElement("inventory_slot_"+i).BHasClass("dragging_from")){
            ItemNumber = i
            GameTime = Game.Time()
            if(GameUI.IsShiftDown()){
                dragg = true
            }
        }
    }
    lastLoop = dragg
	$.Schedule(1/20,function(){
        if(invopened){
            clickingloop()
        } 
	})
}

function put_item_js(t){
	$('#inv_'+t.slot).itemname = t.item_name;
	$('#inv_'+t.slot).SetPanelEvent("onmouseover", function(){
		
	let params =
		`itemName=` +
		t.item_name +
		`&itemLevel=` +
		t.item_level;

		$.DispatchEvent("UIShowCustomLayoutParametersTooltip", $('#inv_'+t.slot), "SetItemTooltip", "file://{resources}/layout/custom_game/custom_tooltip/custom_tooltip.xml", params);
	});

	$('#inv_'+t.slot).visible = true;
	$('#inv_'+t.slot).SetPanelEvent("onmouseout", function(){ $.DispatchEvent("UIHideCustomLayoutTooltip", $('#inv_'+t.slot), "SetItemTooltip");});
}

function return_item_js(t){
	$('#inv_'+t.slot).itemname = ''
	$('#inv_'+t.slot).visible = false
	$('#inv_'+t.slot).visible = true
}

function update_hero_inv(t){
	$.Msg("update")
	var playerID = Players.GetLocalPlayer()
	var tab = CustomNetTables.GetTableValue( "item_hero_set", "item_hero_set"+playerID);
	if (tab){
		let items = tab[playerID];

		for (const type in items) {
			const item = items[type];

			$('#inv_'+type).itemname = item.item;
			$('#inv_'+type).SetPanelEvent("onmouseover", function(){
				
			let params =
				`itemName=` +
				item.item +
				`&itemLevel=` +
				item.level;
				
				$.Msg(item.item, item.level)

				$.DispatchEvent("UIShowCustomLayoutParametersTooltip", $('#inv_'+type), "SetItemTooltip", "file://{resources}/layout/custom_game/custom_tooltip/custom_tooltip.xml", params);
			});

			$('#inv_'+type).visible = true;

			$('#inv_'+type).SetPanelEvent("onmouseout", function(){ $.DispatchEvent("UIHideCustomLayoutTooltip", $('#inv_'+type), "SetItemTooltip");});
		}
	}
}

function button_inv(){
    FindDotaHudElement("AghsStatusContainer").visible = false;
    FindDotaHudElement("ContentsContainer").GetParent().visible = false;
    var inv = FindDotaHudElement("AghsStatusContainer");
    invbtn = $.CreatePanel('Panel',inv.GetParent(),'inventorywrap')  
	invbtn.style.marginTop = "94px"
	invbtn.style.marginLeft = "5px"
	invbtn.style.width = "64px"
	invbtn.style.height = "64px"
	invbtn.style.backgroundColor = "gradient( linear, 0% 0%, 0% 100%, from( #25282a ), color-stop( .5, #25282a), to( #000000 ) );"
	invbtn.style.backgroundImage = "url('s2r://panorama/images/topbar/armory_icon_off_png.vtex')";
	invbtn.style.backgroundPosition = "57% center";
	invbtn.style.backgroundRepeat = "no-repeat";
	invbtn.style.backgroundSize = "75px 75px";
	invbtn.style.borderTop = "1px solid #ffffff04";
	invbtn.style.borderRight = "1px solid #ffffff04";
	invbtn.style.opacity = 0.75;
	invbtn.style.transitionProperty = "background-image, background-color, opacity";
	invbtn.style.transitionDuration = "0.2s";
	invbtn.style.transitionTimingFunction = "ease-in-out";
	
	invbtn.SetPanelEvent("onmouseover", function() {
	invbtn.style.opacity = 1;
	invbtn.style.backgroundColor = "gradient(linear, 0% 0%, 100% 0%, from(#000000), to(#25282a));"
	invbtn.style.backgroundImage = "url('s2r://panorama/images/topbar/armory_icon_on_png.vtex')";
	});

	invbtn.SetPanelEvent("onmouseout", function() {
	invbtn.style.opacity = 0.75;
	invbtn.style.backgroundColor = "gradient( linear, 0% 0%, 0% 100%, from( #25282a ), color-stop( .5, #25282a), to( #000000 ) );"
	invbtn.style.backgroundImage = "url('s2r://panorama/images/topbar/armory_icon_off_png.vtex')";
	});
	
	invbtn.SetPanelEvent("onmouseactivate",function(){ OpenInv()});
}

(function()
{
	button_inv()
	GameEvents.Subscribe("CustomError",ErrorMessage);

	GameEvents.Subscribe( "put_item_js", put_item_js )
	GameEvents.Subscribe( "return_item_js", return_item_js )
	GameEvents.Subscribe( "update_hero_inv", update_hero_inv )
	
    if($("#equipmentItems")){
		$("#head").SetPanelEvent("onmouseover", OnMouseOverItem($("#head"), "head"))
		$("#head").SetPanelEvent("onmouseactivate", ReturnItemBack($("#head"), "head"))

        $("#armor").SetPanelEvent("onmouseover", OnMouseOverItem($("#armor"), "armor"))
		$("#armor").SetPanelEvent("onmouseactivate", ReturnItemBack($("#armor"), "armor"))
		
        $("#glovers").SetPanelEvent("onmouseover", OnMouseOverItem($("#glovers"), "glovers"))
		$("#glovers").SetPanelEvent("onmouseactivate", ReturnItemBack($("#glovers"), "glovers"))
		
        $("#weapon").SetPanelEvent("onmouseover", OnMouseOverItem($("#weapon"), "weapon"))
		$("#weapon").SetPanelEvent("onmouseactivate", ReturnItemBack($("#weapon"), "weapon"))
		
        $("#pants").SetPanelEvent("onmouseover", OnMouseOverItem($("#pants"), "pants"))
		$("#pants").SetPanelEvent("onmouseactivate", ReturnItemBack($("#pants"), "pants"))
		
        $("#boots").SetPanelEvent("onmouseover", OnMouseOverItem($("#boots"), "boots"))
		$("#boots").SetPanelEvent("onmouseactivate", ReturnItemBack($("#boots"), "boots"))
		}
})()