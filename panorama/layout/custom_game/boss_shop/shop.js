--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


var PlayerCount = 0,
	// shop = CustomNetTables.GetAllTableValues( "shop" ),
	playerID = Players.GetLocalPlayer(),
	shopinfo = {},
	isShopOpen = false,
	first_start = true, 
	shopnumber = 0,
	count_buy = 1,
	last_page = 1,
	price_don = 0,
	price_rp = 0,
	don_panel = $('#don')
	DSPanel = $('#DSPanel'),
	BuyControl = $('#BuyControl'),
	textEntry = $("#buy_text_input")

don_panel.visible = false
DSPanel.visible = false
BuyControl.visible = false


const DotaHUD = GameUI.CustomUIConfig().DotaHUD;
DotaHUD.windowControllers["shop"] = {
    is_open: false,
    open: function(){
        GameEvents.SendCustomGameEventToServer("money_update", {})
		DSPanel.visible = true
		DSPanel.hittest = true
		DSPanel.hittestchildren = true
		if (shopinfo) {
			for(var i = 1; i <= Object.keys(shopinfo).length; i++){
				var panel = $('#TabPanel_' + i)
				var label = $('#TabLabel_' + i)
				var content = $('#DSContentPanel_' + i)
				if(i == shopnumber){
					content.visible = true
					panel.AddClass('selected_bd')
					label.AddClass('selected_text')
				}else{
					if(panel){
						panel.RemoveClass('selected_bd')
					}
					if(label){
						label.RemoveClass('selected_text')
					}
					if(content){
						content.visible = false
					}
				}
			}
		}
		DSPanel.AddClass('open_shop')
    },
    close: function(){
        last_page = 1
		DSPanel.RemoveClass('open_shop')
		DSPanel.AddClass('close_shop')
		$.Schedule(0.2, function(){
			DSPanel.RemoveClass('close_shop')
			DSPanel.visible = false
		})
		$('#BuyControl').visible = false
    }
}
DotaHUD.ListenToMouseEvent(
    DotaHUD.GetCloseWindowOnOutsideClick(DSPanel, "shop")
);

var rarity_color = // Цвет рарности
{
    common : "#b0c3d9",
    uncommon : "#5e98d9", 
    rare: "#4b69ff",
    mythical : "#8847ff", 
    legendary : "#d32ce6", 
    immortal : "#e4ae39", 
    ancient : "#ed0c2e", 
} 

function closeBuyControl(){
	BuyControl.visible = false
	count_buy = 1
	textEntry.text = "1"
	disableContentPanel(false)
}

function disableContentPanel(disable) {
	const contentPanel = $("#DSContentPanel")
	if (!contentPanel) return

	contentPanel.hittest = !disable
	contentPanel.hittestchildren = !disable
}

function openShopButton()
{
	if(DotaHUD.IsWindowOpen("shop")){
		closeShop()
	}else{
		openShop(shopnumber)
	}
}

function closeShop(){
	DotaHUD.WindowClose("shop");
}

function move_link(t){
	if(DotaHUD.IsWindowOpen("shop")){
		$.DispatchEvent( "DOTADisplayURL",  t);
	}
}

function openShop(n){
	shopnumber = n
	if(DotaHUD.IsWindowOpen("shop")){
		DotaHUD.windowControllers["shop"].is_open = false
	}
	DotaHUD.WindowOpen("shop");
	disableContentPanel(false)
}

var opn = (function(n)
{
	return function()
	{
		closeBuyControl()
		Game.EmitSound("ui_team_select_pick_team")
		shopnumber = n
		last_page = shopnumber
		openShop(shopnumber)	
	}
});

///////////////////////////////////////////

function initShop2(tab){
	first_start = true
	initShop(tab)
}

function initShop(tab){
	shopinfo = tab
	$.Msg("MMMRPointsLabel_1 = ", shopinfo.mmrpoints)
	$('#MMMRPointsLabel').text = shopinfo.mmrpoints
	
	$("#DSTabsPanel").RemoveAndDeleteChildren();
	$("#DSContentPanel").RemoveAndDeleteChildren();
	
	if (shopinfo.link['fr']){
		don_panel.visible = true
		var fr = $.CreatePanel("Panel", don_panel, "frsn");
        fr.BLoadLayoutSnippet("fr_snippet");
		fr.SetPanelEvent("onmouseactivate", function() {$.DispatchEvent("ExternalBrowserGoToURL", shopinfo.link['fr'])})
        fr.SetPanelEvent("onmouseover", function() { $.DispatchEvent("DOTAShowTextTooltip", fr, $.Localize('#fr'))});
        fr.SetPanelEvent("onmouseout", TipsOut)
		
		// Показываем кнопку пополнения и устанавливаем обработчик
		var addMoneyButton = $('#add_money_button')
		if (addMoneyButton) {
			addMoneyButton.visible = true
			addMoneyButton.SetPanelEvent("onmouseactivate", function() {
				$.DispatchEvent("ExternalBrowserGoToURL", shopinfo.link['fr'])
			})
		}
	} else {
		// Скрываем кнопку, если ссылки нет
		var addMoneyButton = $('#add_money_button')
		if (addMoneyButton) {
			addMoneyButton.visible = false
		}
	}
	for (const [key, value] of Object.entries(shopinfo)) {
		if(typeof(value) == 'object' && !["link", "rewards_list"].includes(key)){
			if($("#DSTabsPanel")){
				var TabPanel = $.CreatePanel("Panel", $("#DSTabsPanel"), "TabPanel_" + key);
				TabPanel.AddClass("TabPanel");
				TabPanel.SetPanelEvent("onmouseactivate",opn(key));
				var TabPanelLabel = $.CreatePanel("Label", TabPanel, "TabLabel_" + key);
				TabPanelLabel.AddClass('TabLabel');
				TabPanelLabel.text = $.Localize("#"+value.name);
			}
			var TabContent
			if($("#DSContentPanel")){
				TabContent = $.CreatePanel("Panel", $("#DSContentPanel"), "DSContentPanel_" + key);
				TabContent.AddClass('TabContent');
			}
			var n = 0
			var horizontal_panel = 0
			var hPanel
			var count_in_horizontal = 7
					
			for (const [tovarKey, tovarValue] of Object.entries(value)) {
				if (typeof(tovarValue) == 'object') {
					if (tovarValue.type == 'consumable' || tovarValue.type == 'pet'|| tovarValue.type == 'treasures') {
						count_in_horizontal = 6;
					}
					if (n % count_in_horizontal == 0) {
						horizontal_panel += 1
						if (TabContent) {
							var hPanel = $.CreatePanel("Panel", TabContent, "")
							hPanel.AddClass('horizontal_panel')
						}
					}			
					if(hPanel){
						var pan = $.CreatePanel("Panel", hPanel, "ShopItem" + key + '_' + tovarKey)
						if(tovarValue.type == 'consumable'){
							pan.BLoadLayoutSnippet("consumable_snippet")
							pan.FindChildTraverse('consumable_panel_image').itemname = tovarValue.itemname
							pan.FindChildTraverse('consumable_panel_name').text = $.Localize("#DOTA_Tooltip_ability_"+tovarValue.itemname)
							pan.FindChildTraverse('consumable_panel_count_label').text = tovarValue.now
							pan.FindChildTraverse('item_panel_return').SetPanelEvent("onmouseactivate", returnItem(key, tovarKey, pan))
							pan.FindChildTraverse('item_panel_take').SetPanelEvent("onmouseactivate", give(key, tovarKey))
							pan.FindChildTraverse('item_panel_buy').SetPanelEvent("onmouseactivate", buy(key, tovarKey, pan))			
						}else if (tovarValue.type == 'treasures'){
							pan.BLoadLayoutSnippet("treasure_snippet")
							pan.FindChildTraverse('treasure_panel_image').itemname = tovarValue.itemname
							// pan.FindChildTraverse('treasure_panel_image').SetImage('file://{resources}/images/treasures/' + tovarValue.itemname +'.png')
							pan.FindChildTraverse('treasure_panel_name').text = $.Localize("#DOTA_Tooltip_ability_"+tovarValue.itemname)
							pan.FindChildTraverse('treasure_panel_count_label').text = tovarValue.now
							pan.FindChildTraverse('item_panel_take').SetPanelEvent("onmouseactivate", use(tovarValue.itemname))
							pan.FindChildTraverse('item_panel_buy').SetPanelEvent("onmouseactivate", buy(key, tovarKey, pan))		
							
						}else if (tovarValue.type == 'pet'){
							pan.BLoadLayoutSnippet("pet_snippet")
							pan.FindChildTraverse('smart_toggle').visible = false
							pan.FindChildTraverse('pet_panel_take').visible = false
							pan.FindChildTraverse('pet_panel_return').visible = false
							
							pan.FindChildTraverse('pet_panel_image').itemname = tovarValue.itemname
							pan.FindChildTraverse('pet_panel_name').text = "<font color='"+rarity_color[tovarValue.level]+"'>"+$.Localize("#DOTA_Tooltip_ability_"+tovarValue.itemname)+"</font>"   
							if (tovarValue.itemname == 'item_mimic_pet' || tovarValue.itemname =='item_jackpot_pet'){
								pan.FindChildTraverse('pet_panel_label').text = $.Localize("#pet_unlock_casino")
							}else{
								pan.FindChildTraverse('pet_panel_label').text = $.Localize("#pet_unlock")
							}
							pan.FindChildTraverse('pet_panel_return').SetPanelEvent("onmouseactivate", returnItem(key, tovarKey, pan))
							pan.FindChildTraverse('pet_panel_take').SetPanelEvent("onmouseactivate", give(key, tovarKey))

							// Кол-во и кнопка улучшения
							var countBadge = pan.FindChildTraverse('pet_count_badge')
							var countLbl = pan.FindChildTraverse('pet_count_label')
							var upgradeBtn = pan.FindChildTraverse('pet_upgrade_btn')
							if (countBadge) countBadge.visible = tovarValue.now > 0
							if (countLbl) countLbl.text = String(tovarValue.now || 0)
							var upgradeThreshold = tovarValue.itemname === 'item_jackpot_pet' ? 3 : 5
							if (upgradeBtn) {
								if ((tovarValue.level !== 'ancient' && tovarValue.now >= 5) || (tovarValue.itemname === 'item_jackpot_pet' && tovarValue.now >= 3)) {
									upgradeBtn.visible = true
									;(function(name) {
										upgradeBtn.SetPanelEvent('onmouseactivate', function() {
											Game.EmitSound("cas.item_has_been_sold")
											GameEvents.SendCustomGameEventToServer('pet_upgrade', { item_name: name })
										})
									})(tovarValue.itemname)
								} else {
									upgradeBtn.visible = false
								}
							}

							if (tovarValue.now > 0){
								pan.FindChildTraverse('smart_toggle').visible = true
								item = pan.FindChildTraverse('smart_toggle')
								item.SetPanelEvent("onmouseactivate",check(key, tovarKey, pan, item, tovarValue.type))
								if (tovarValue.active){
									item.checked = true
								}
							}
				
							if(tovarValue.status == 'take_item'){
								pan.FindChildTraverse('pet_panel_take').visible = true
							}else if (tovarValue.status == 'takeoff'){
								pan.FindChildTraverse('pet_panel_return').visible = true
							}
							
						}else{
							pan.BLoadLayoutSnippet("items_snippet")
							pan.FindChildTraverse('item_panel_buy').visible = false
							pan.FindChildTraverse('item_panel_take').visible = false
							pan.FindChildTraverse('item_panel_return').visible = false
							pan.FindChildTraverse('item_panel_upgrade').visible = false
							pan.FindChildTraverse('smart_toggle').visible = false
							
							pan.FindChildTraverse('item_panel_image').itemname = tovarValue.itemname
							if (tovarValue.can_upgrade) {
								pan.FindChildTraverse('item_panel_return').SetPanelEvent("onmouseactivate", returnItem(key, tovarKey, pan))
								pan.FindChildTraverse('item_panel_take').SetPanelEvent("onmouseactivate", give(key, tovarKey))
								pan.FindChildTraverse('item_panel_buy').SetPanelEvent("onmouseactivate", buy(key, tovarKey, pan))
								pan.FindChildTraverse('item_panel_upgrade').SetPanelEvent("onmouseactivate", upgrade(key, tovarKey, pan))
								if (tovarValue.now > 1){
									pan.FindChildTraverse('item_panel_name').text = $.Localize("#DOTA_Tooltip_ability_"+tovarValue.itemname+tovarValue.now)
								}else{
									pan.FindChildTraverse('item_panel_name').text = $.Localize("#DOTA_Tooltip_ability_"+tovarValue.itemname)
								}
								if(tovarValue.now == 0){
									pan.FindChildTraverse('item_panel_buy').visible = true
								}else if(tovarValue.status == 'take_item'){
									pan.FindChildTraverse('item_panel_take').visible = true
								}else if (tovarValue.status == 'takeoff'){
									pan.FindChildTraverse('item_panel_return').visible = true
								}
								if (tovarValue.now > 0 && tovarValue.now < 5){
									pan.FindChildTraverse('item_panel_upgrade').visible = true
								}
							}else{
								pan.FindChildTraverse('item_panel_return').SetPanelEvent("onmouseactivate", returnItem(key, tovarKey, pan))
								pan.FindChildTraverse('item_panel_take').SetPanelEvent("onmouseactivate", give(key, tovarKey))
								pan.FindChildTraverse('item_panel_buy').SetPanelEvent("onmouseactivate", buy(key, tovarKey, pan))
								pan.FindChildTraverse('item_panel_name').text = $.Localize("#DOTA_Tooltip_ability_"+tovarValue.itemname)
								
								if (tovarValue.type == 'effect' || tovarValue.type == 'spray' || tovarValue.type == 'highfive' || tovarValue.type == 'tip'){          //-----------------------------------------------------
									pan.FindChildTraverse('item_panel_image2').SetImage('file://{resources}/' + tovarValue.image);
									pan.FindChildTraverse('item_panel_name').text = $.Localize("#"+tovarValue.type)
									if (tovarValue.now > 0){
										pan.FindChildTraverse('smart_toggle').visible = true
										item = pan.FindChildTraverse('smart_toggle')
										item.SetPanelEvent("onmouseactivate",check(key, tovarKey, pan, item, tovarValue.type))
										if (tovarValue.active){
											item.checked = true
										}
									}
								}
								if(tovarValue.now == 0){
									pan.FindChildTraverse('item_panel_buy').visible = true
								}else{
									if (tovarValue.cant_take){
										if(tovarValue.status == 'take_item'){
											pan.FindChildTraverse('item_panel_take').visible = false
										}else if (tovarValue.status == 'takeoff'){
											pan.FindChildTraverse('item_panel_return').visible = false
										}
									}else{
										if(tovarValue.status == 'take_item'){
											pan.FindChildTraverse('item_panel_take').visible = true
										}else if (tovarValue.status == 'takeoff'){
											pan.FindChildTraverse('item_panel_return').visible = true
										}
									}
								}
							}
						}		
					}
					n += 1
				}
			}
		}
	}
	for(var i = 1; i <= Object.keys( shopinfo ).length; i++){
		if(typeof(shopinfo[i] == 'object')){
			if($('#TabPanel_' + i)){
				$('#TabPanel_' + i).AddClass('TabPanelOnServ')
				$('#TabLabel_' + i).AddClass('TabLabelOnServ')
			}
			if($("#DSContentPanel_" + i)){
				$("#DSContentPanel_" + i).visible = false
			}
		}	
	}
	if (!first_start){
		openShop(last_page)
	}	
	var i = 1;
	while(shopinfo[i]){
		if($('#TabPanel_' + i)){
			shopnumber = i
			break;
		}
		i++;
	}
	first_start = false
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function InputCount() {
	if (textEntry.text == "") {
		textEntry.text = "1";
		return;
	}
	count_buy = textEntry.text
	
	BuyControl.FindChildTraverse('DNMoneyLabel').text = price_don * count_buy
	BuyControl.FindChildTraverse('MMMRPointsLabel').text = price_rp * count_buy
}

var buy = (function(i, n, pan)
{
	return function()
	{
		Game.EmitSound("ui_team_select_shuffle")
		BuyControl.visible = true;
		disableContentPanel(true)
		count_buy = 1
		textEntry.text = "1"
		var tovar = shopinfo[i][n]
		BuyControl.FindChildTraverse('item_buy_image2').visible = false
		BuyControl.FindChildTraverse('rp_button').visible = true
		BuyControl.FindChildTraverse('item_buy_image').itemname = tovar.itemname
		if (tovar.now > 1 && tovar.can_upgrade){
			BuyControl.FindChildTraverse('item_buy_label').text = $.Localize("#DOTA_Tooltip_ability_"+tovar.itemname+tovar.now)
		}else{
			BuyControl.FindChildTraverse('item_buy_label').text = $.Localize("#DOTA_Tooltip_ability_"+tovar.itemname)
		}
		if (tovar.type == 'effect' || tovar.type == 'spray' || tovar.type == 'highfive' || tovar.type == 'tip'){
			BuyControl.FindChildTraverse('item_buy_label').text = $.Localize("#"+tovar.type)
			BuyControl.FindChildTraverse('item_buy_image2').visible = true
			BuyControl.FindChildTraverse('item_buy_image2').SetImage('file://{resources}/' + tovar.image);
		}
		
		textEntry.visible = false
		if(tovar.type == 'consumable'){
			textEntry.visible = true
		}
		
		if(tovar.type == 'treasures'){
			textEntry.visible = true
			BuyControl.FindChildTraverse('rp_button').visible = false
			BuyControl.FindChildTraverse('item_buy_image2').visible = true
			BuyControl.FindChildTraverse('item_buy_image2').SetImage('file://{resources}/images/treasures/' + tovar.itemname +'.png')
			BuyControl.FindChildTraverse('item_buy_label').text = $.Localize("#DOTA_Tooltip_ability_"+tovar.itemname) //"<font color='"+rarity_color[tovar.itemname]+"'>"+tovar.itemname+"</font>" 
		}
		
		price_don = tovar.price.don
		price_rp = tovar.price.rp
		
		BuyControl.FindChildTraverse('DNMoneyLabel').text = price_don * count_buy
		BuyControl.FindChildTraverse('MMMRPointsLabel').text = price_rp * count_buy
		
		BuyControl.FindChildTraverse('don_button').SetPanelEvent("onmouseactivate",acceptBuy(i, n, 'don'))
		BuyControl.FindChildTraverse('rp_button').SetPanelEvent("onmouseactivate",acceptBuy(i, n, 'rp'))
	}
});

var acceptBuy = (function(i, n, currency)
{
	return function()
	{
		$('#BuyControl').visible = false;
		$.Msg(i, n, currency, count_buy)
		GameEvents.SendCustomGameEventToServer("buyItem", {i, n, currency, count_buy})
	}
});


var upgrade = (function(i, n, pan)
{
	return function()
	{
		$('#buy_text_input').visible = false;
		if (shopinfo[i][n].status == 'take_item'){
			Game.EmitSound("ui_team_select_shuffle")
			BuyControl.visible = true;
			var tovar = shopinfo[i][n]
			count_buy = 1
			textEntry.text = "1"
			BuyControl.FindChildTraverse('item_buy_image').itemname = tovar.itemname
			if (tovar.now > 1){
				BuyControl.FindChildTraverse('item_buy_label').text = $.Localize("#DOTA_Tooltip_ability_"+tovar.itemname+tovar.now)
			}else{
				BuyControl.FindChildTraverse('item_buy_label').text = $.Localize("#DOTA_Tooltip_ability_"+tovar.itemname)
			}
			BuyControl.FindChildTraverse('DNMoneyLabel').text = tovar.price.don
			BuyControl.FindChildTraverse('MMMRPointsLabel').text = tovar.price.rp
			BuyControl.FindChildTraverse('don_button').SetPanelEvent("onmouseactivate",acceptBuy(i, n, 'don'))
			BuyControl.FindChildTraverse('rp_button').SetPanelEvent("onmouseactivate",acceptBuy(i, n, 'rp'))
		}
	}
});

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var use = (function(item)
{
	return function()
	{	
		openShopButton()
		GameEvents.SendCustomGameEventToServer("show_treasure", {item : item})
	}
});

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var give = (function(i, n)
{
	return function()
	{	
		$.Msg("TAKE ITEM")
		Game.EmitSound("ui_team_select_shuffle")
		var tovarValue = shopinfo[i][n]
		
		if(tovarValue.type == 'consumable' && GameUI.IsShiftDown()){
			GameEvents.SendCustomGameEventToServer("giveItem", {i : i, n : n, all : "all"})
			return
		}
		
		if (tovarValue.type == 'effect' || tovarValue.type == 'spray' || tovarValue.type == 'tip' || tovarValue.type == 'highfive' || tovarValue.type == 'pet'){
			update_panels(i, n, tovarValue.type)
			return
		}
		
		let pan = $("#ShopItem" + i + '_' + n)
		pan.FindChildTraverse('item_panel_take').visible = false
		GameEvents.SendCustomGameEventToServer("giveItem", {i : i, n : n, all : null})
	}
});

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var returnItem = (function(i, n, pan){
    return function(){
		Game.EmitSound("ui_team_select_shuffle")
        GameEvents.SendCustomGameEventToServer("return_item", {i : i, n : n})
    }
})

function return_item_js(t){
    let pan = $("#ShopItem" + t.i + '_' + t.n)
    if(shopinfo[t.i][t.n].type == 'consumable'){
        shopinfo[t.i][t.n]['now'] += t.car
        pan.FindChildTraverse('DSItemButtonLabelStock').text = shopinfo[t.i][t.n]['now']
    }else{
		$.Msg("RETURN ITEM")
		pan.FindChildTraverse('item_panel_take').visible = true
		pan.FindChildTraverse('item_panel_return').visible = false
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function update_panels(i, n, type){
	var shopPanel = $("#DSContentPanel")
	for (const [categoryKey, categoryValue] of Object.entries(shopinfo)) {
		if(typeof(categoryValue) == 'object'){
			for (const [productKey, productValue] of Object.entries(categoryValue)) {
				if(typeof(productValue) == 'object' && productValue.type == type){
					if (shopinfo[categoryKey][productKey].status = 'takeoff'){
						GameEvents.SendCustomGameEventToServer("update_panels", {i : categoryKey, n : productKey})
					}
				}
			}
		}
	}
	GameEvents.SendCustomGameEventToServer("giveItem", {i : i, n : n, all : null})
}

var check = (function(i, n, pan, item, type)
{
	return function()
	{	
		if (!item.checked){
			GameEvents.SendCustomGameEventToServer("defaultCosmetic", {i : i, n : n, status : false, type : type})
		}else{
			var shopPanel = $("#DSContentPanel")
			for (const [categoryKey, categoryValue] of Object.entries(shopinfo)) {
				if(typeof(categoryValue) == 'object'){
					for (const [productKey, productValue] of Object.entries(categoryValue)) {
						if(typeof(productValue) == 'object' && productValue.type == type){
							pan = shopPanel.FindChildTraverse("ShopItem" + categoryKey + '_' + productKey)
							other = pan.FindChildTraverse('smart_toggle')
							if (other != item){
								other.checked = false
							}
						}
					}
				}
			}
			GameEvents.SendCustomGameEventToServer("defaultCosmetic", {i : i, n : n, status : true, type : type})
		}
	}
});	

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function money_update(){
	GameEvents.SendCustomGameEventToServer("money_update", {})
}

function updatecoins(t){
	shopinfo.coins = t.coins
	shopinfo.mmrpoints = t.rp
	$('#DNMoneyLabel').text = shopinfo.coins
	$('#MMMRPointsLabel').text = shopinfo.mmrpoints
}

function TipsOver(message, pos)
{
    if ($("#"+pos) != undefined)
    {
       $.DispatchEvent( "DOTAShowTextTooltip", $("#"+pos), $.Localize("#"+message));
    }
}

function TipsOut()
{
    $.DispatchEvent( "DOTAHideTitleTextTooltip");
    $.DispatchEvent( "DOTAHideTextTooltip");
}

function updatemmr(t){
	shopinfo.mmrpoints = t[1]
	$('#MMMRPointsLabel').text = shopinfo.mmrpoints
}

(function(){
	GameEvents.Subscribe( "initShop", initShop)
	GameEvents.Subscribe( "initShop2", initShop2)
	GameEvents.Subscribe( "updatemmr", updatemmr)
	GameEvents.Subscribe( "updatecoins", updatecoins)
	GameEvents.Subscribe( "return_item_shop", return_item_js)
	GameUI.CustomUIConfig.OpenShop = openShopButton;
	GameUI.LoopTime.Schedule(0.0, ()=>{
		DotaHUD.CreateTopBarButton("file://{images}/custom_game/DS/shopopen.png", "shop", openShopButton, "shop");
	});
})();

