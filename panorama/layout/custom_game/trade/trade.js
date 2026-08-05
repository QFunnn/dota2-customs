--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


var trade_panel_main = $("#trade_panel_main")
var trade_panel_start = $("#trade_panel_start")
var trade_panel_buy = $("#trade_panel_buy")
var trade_panel_sell = $("#trade_panel_sell")
var trade_panel_order = $("#trade_panel_order")
trade_panel_main.visible = false
trade_panel_start.visible = false
trade_panel_buy.visible = false
trade_panel_sell.visible = false
trade_panel_order.visible = false

const DotaHUD = GameUI.CustomUIConfig().DotaHUD;

DotaHUD.ListenToMouseEvent(
    DotaHUD.GetCloseWindowOnOutsideClick(trade_panel_main, "trade")
);

var tabs = ["head", "armor", "legs", "boots", "weapon", "shield"]

const attributes = [
	{key: "crit"},
	{key: "mkb"},
	{key: "desolator"},
	{key: "magic_desolator"},
	{key: "mjolnir"},
	{key: "mjolnir_armor"},
	{key: "hp_regen"},
	{key: "hp_regen_amp"},
	{key: "lifesteal"},
	{key: "magic_lifesteal"},
	{key: "damage_block"},
	{key: "reflect"},
	{key: "multicast"},
	{key: "manacost"},
	{key: "magic_crit"},
]

function ActivateTrade(){
	DotaHUD.WindowOpen("trade");
}

function DeactivateTrade(){
	DotaHUD.WindowClose("trade");
}

DotaHUD.windowControllers["trade"] = {
    is_open: false,
    open: function(){
        trade_panel_main.visible = true;
        buy_open(); 
    },
    close: function(){
        close();
    }
}

function UpdateTabVisuals(activeTabId) {
    var tradeHeader = $("#TabButtons");
    if (!tradeHeader) return;
    var children = tradeHeader.Children();
    for (var i = 0; i < children.length; i++) {
        var child = children[i];
        
        if (child.BHasClass("TabBtn")) {
            if (child.id === activeTabId) {
                child.AddClass("selected_tab");
            } else {
                child.RemoveClass("selected_tab");
            }
        }
    }
}

function buy_open(){
    if (trade_panel_main.visible === false) {
        trade_panel_main.visible = true;
    }

	UpdateTabVisuals("BuyTab");
	
    GameEvents.SendCustomGameEventToServer("get_trade_items", {type:'head'})
    
    $("#trade_panel_content").RemoveAndDeleteChildren()
    $("#trade_panel_sort").RemoveAndDeleteChildren()
    
    for (let i = 0; i < tabs.length; i++)
    {
        CreateTab($("#trade_panel_sort"), tabs[i])
    }
    
    trade_panel_order.visible = false
    trade_panel_start.visible = false
    trade_panel_buy.visible = true
    trade_panel_sell.visible = false
    
    // let loading = $.CreatePanel("Panel", $("#trade_panel_content"), '');
    // loading.AddClass("trade_panel_element_item_loading");

    DotaHUD.WindowCloseAnyway("inventory_hud")
}

function open_back(){
    trade_panel_order.visible = false
    trade_panel_start.visible = true
    trade_panel_buy.visible = false
    trade_panel_sell.visible = false
}

function sell_open(){
	UpdateTabVisuals("SellTab");
	clear()
	GameEvents.SendCustomGameEventToServer("get_inventory_for_sell", {})
	trade_panel_order.visible = false
	trade_panel_start.visible = false
	trade_panel_buy.visible = false
	trade_panel_sell.visible = true

	DotaHUD.WindowCloseAnyway("inventory_hud")
}

function order_open(){
	UpdateTabVisuals("OrderTab");
	GameEvents.SendCustomGameEventToServer("get_order", {})
	trade_panel_order.visible = true
	trade_panel_start.visible = false
	trade_panel_buy.visible = false
	trade_panel_sell.visible = false

	DotaHUD.WindowCloseAnyway("inventory_hud")
}

function close(){
	trade_panel_main.visible = false
	trade_panel_order.visible = false
	trade_panel_start.visible = false
	trade_panel_buy.visible = false
	trade_panel_sell.visible = false
}

current_filters = {}

create_filters_toggle()

function init_buy(data){
	current_filters = data
	show_items(data.listings, data.type, true)
}	

function update_buy(data){
	init_buy(data)
	show(data.type)
}

function CreateTab(main, type_name) {
    let tab_sort = $.CreatePanel("Panel", main, type_name);
    tab_sort.AddClass("tab_sort");
    tab_sort.SetPanelEvent("onmouseactivate", function() {
        show(type_name);
    });
	
	let equip_slot_label = $.CreatePanel("Label", tab_sort, "");
    equip_slot_label.text = $.Localize("#" + type_name + "_tab");
    equip_slot_label.AddClass("tab_text");
}

let showItemsTimerId

function show_items(data, type, isInitial) {
	if (isInitial) {
		_show_items(data, type)
	} else {
		if (showItemsTimerId)
			$.CancelScheduled(showItemsTimerId)

		showItemsTimerId = $.Schedule(1, () => {
			showItemsTimerId = undefined
			_show_items(data, type)
		})
	}
}

function _show_items(data, type) {
	$("#trade_panel_content").RemoveAndDeleteChildren()
	let tab_sort_content = $.CreatePanel("Panel", $("#trade_panel_content"), type + "_content");
    tab_sort_content.AddClass("content");

	tab_sort_content.visible = true;

	if (data){
		var new_data = filterAndSortData(data, true);
		let data_tabs_array = Object.values(new_data);

		data_tabs_array.sort((a, b) => {
			if (b.item.set_number === a.item.set_number) {
				return b.price - a.price;
			}
			return b.item.set_number - a.item.set_number;
		});

		for (const item of data_tabs_array) {
			// loading.visible = false;
			var item_panel = $.CreatePanel("Panel", tab_sort_content, item.id);
			item_panel.BLoadLayoutSnippet("items_for_trade");
			item_panel.FindChildTraverse("trade_panel_element_image").style.backgroundImage = "url('file://{resources}/images/sets/" + item.item.set_type + "/" + item.item.item_type +".png')";
			item_panel.FindChildTraverse("trade_panel_element_image").style.backgroundSize = "95%";
			item_panel.FindChildTraverse("trade_panel_element_image").style.backgroundPosition = "center center";
			item_panel.FindChildTraverse("trade_panel_element_image").AddClass("equipped_item_shadow_level_" + item.item.level)
			item_panel.FindChildTraverse("trade_panel_element_item_name").text = $.Localize("#"+item.item.set_type+"_"+item.item.item_type) + " " + item.item.level;
			item_panel.FindChildTraverse("trade_panel_element_item_seller").steamid = item.seller_steam_id;
			item_panel.FindChildTraverse("name_data_label").text = $.Localize("#order_open") + " " + date_conv(item.created_at)
			item_panel.FindChildTraverse("trade_panel_element_item_price_count").text = item.price;
			item_panel.FindChildTraverse("trade_panel_element_image").SetPanelEvent("onmouseover", onAbilityMouseOver.bind(this, item_panel.FindChildTraverse("trade_panel_element_image"), item));
			item_panel.FindChildTraverse("trade_panel_element_image").SetPanelEvent("onmouseout", onAbilityMouseOut.bind(this, item_panel.FindChildTraverse("trade_panel_element_image")));
			item_panel.FindChildTraverse("trade_panel_element_item_loading").visible = false;
			item_panel.FindChildTraverse("trade_panel_element_item_price_button_buy").SetPanelEvent("onmouseactivate", buy.bind(this, item, item_panel, item.item.item_type));
		}
    }   
}

let a = 10

function create_filters_toggle(){
	$("#trade_panel_filter_sets").RemoveAndDeleteChildren()
	$("#trade_panel_filter_bonuses").RemoveAndDeleteChildren()
	$("#trade_panel_filter_stats").RemoveAndDeleteChildren()
	for (let i = 1; i <= 6; i++)
    {
        let toggle = $.CreatePanel("ToggleButton", $("#trade_panel_filter_sets"), i)
		toggle.AddClass("CheckBox")
		toggle.checked = true
		toggle.SetPanelEvent("onactivate", function() {
			show_items(current_filters.listings, current_filters.type)

        });
		
		toggle.SetPanelEvent("onmouseover", function() { $.DispatchEvent("DOTAShowTextTooltip", toggle, $.Localize("#set") + " " + i )});
		toggle.SetPanelEvent("onmouseout", TipsOut)
	}
	
	for (let i = 0; i <= 5; i++)
    {
        let toggle = $.CreatePanel("ToggleButton", $("#trade_panel_filter_bonuses"), i)
		toggle.AddClass("CheckBox")
		toggle.checked = true
		toggle.SetPanelEvent("onactivate", function() {
			show_items(current_filters.listings, current_filters.type)

        });
		
		toggle.SetPanelEvent("onmouseover", function() { $.DispatchEvent("DOTAShowTextTooltip", toggle, $.Localize("#bonus_count") + " " + i )});
		toggle.SetPanelEvent("onmouseout", TipsOut)
	}

	for (let i = 0; i < attributes.length; i++)
    {
        let toggle = $.CreatePanel("ToggleButton", $("#trade_panel_filter_stats"), i)
		toggle.AddClass("CheckBox")
		toggle.checked = false
		toggle.SetPanelEvent("onactivate", function() {
			show_items(current_filters.listings, current_filters.type)
        });
		
		toggle.SetPanelEvent("onmouseover", function() { $.DispatchEvent("DOTAShowTextTooltip", toggle, $.Localize("#"+attributes[i].key +"_sort") )});
		toggle.SetPanelEvent("onmouseout", TipsOut)
	}
}

function filterAndSortData(data, sortByPrice = true) {
    var tradePanelFilterSets = $("#trade_panel_filter_sets");
    var filterSetNumbers = [];

    for (let i = 0; i < tradePanelFilterSets.GetChildCount(); i++) {
        let child = tradePanelFilterSets.GetChild(i);
        if (child && child.checked) {
            filterSetNumbers.push(child.id);
        }
    }

    var tradePanelFilterBonuses = $("#trade_panel_filter_bonuses");
    var filterBonusAttributeCounts = [];

    for (let i = 0; i < tradePanelFilterBonuses.GetChildCount(); i++) {
        let child = tradePanelFilterBonuses.GetChild(i);
        if (child && child.checked) {
            filterBonusAttributeCounts.push(parseInt(child.id));
        }
    }

    var tradePanelFilterStats = $("#trade_panel_filter_stats");
    var filterStats = [];

    for (let i = 0; i < tradePanelFilterStats.GetChildCount(); i++) {
        let child = tradePanelFilterStats.GetChild(i);
        if (child && child.checked) {
            filterStats.push(attributes[parseInt(child.id)].key);
        }
    }

	let result = Object.values(data);

    if (filterSetNumbers.length > 0) {
        result = result.filter(item => {
            if (!item.item) {
                return false;
            }
            return filterSetNumbers.includes(String(item.item.set_number));
        });
    }

	if (filterBonusAttributeCounts.length > 0) {
		result = result.filter(item => {
            if (!item.item || !item.item.bonus_attribute) {
                return false;
            }
			const bonusCount = Object.keys(item.item.bonus_attribute).length;
			return filterBonusAttributeCounts.some(count => bonusCount === count);
		});
	}

	if (filterStats.length > 0) {
		result = result.filter(item => {
			if (!item.item || !item.item.bonus_attribute) {
				return false;
			}

			const itemStats = Object.keys(item.item.bonus_attribute)

			return !filterStats.some((stat) => !itemStats.includes(stat))
		});
	}

    if (sortByPrice) {
        result.sort((a, b) => a.price - b.price);
    }
    return result;
}

function TipsOver(message, pos)
{
    if ($("#"+pos) != undefined){
		$.DispatchEvent( "DOTAShowTextTooltip", $("#"+pos), $.Localize('#'+message));
    }
}

function TipsOut()
{
    $.DispatchEvent( "DOTAHideTitleTextTooltip");
    $.DispatchEvent( "DOTAHideTextTooltip");
}

//////////////////////////////////////////////////////////////////////////////////////////


function buy(item, panel, tab){
	panel.FindChildTraverse("trade_panel_element_item_loading").visible = true
	panel.FindChildTraverse("trade_panel_element_item_price_button_buy").visible = false
	
	// Получаем listing_id и item_id
	let listing_id = item.id // ID листинга
	let item_id = item.item.id // ID предмета
	
	GameEvents.SendCustomGameEventToServer("buy_trade_items", {
		listing_id: listing_id,
		item_id: item_id,
		tab: tab
	})
}

///////////////////////////////////////////////// SELL /////////////////////////////////////////////////

var inventory;  

function init_sell(data){
	inventory = data.hero_inventory
	$("#trade_panel_content_inventory").RemoveAndDeleteChildren()
	UpdateInventorySlots()
	UpdateInventoryItems(data.hero_inventory)
}

function UpdateInventorySlots()
{
    for (let i = 1; i <= 30; i++)
    {
        let inventory_slot = $.CreatePanel("Panel", $("#trade_panel_content_inventory"), "inventory_slot_"+i)
		inventory_slot.AddClass("inventory_slot")
		inventory_slot.slot_count = i
		inventory_slot.SetPanelEvent("onmouseover", onAbilityMouseOver.bind(this, inventory_slot));
		inventory_slot.SetPanelEvent("onmouseout", onAbilityMouseOut.bind(this, inventory_slot));
    }
}

function UpdateInventoryItems(inventory_list)
{	
	clear()
    for (let i = 0; i <= Object.keys(inventory_list).length; i++)
    {
        if (Object.keys(inventory_list)[i] != null)
        {
            let inventory_key_slot = Object.keys(inventory_list)[i]
            let item_info = inventory_list[inventory_key_slot]
            if (item_info != null)
            {
                let item_icon = item_info.set_type + "/" + item_info.item_type
                
                let find_slot = $("#trade_panel_content_inventory").FindChildTraverse("inventory_slot_"+inventory_key_slot)
    
                let item_panel = $.CreatePanel("Panel", find_slot, "")
                item_panel.AddClass("item_panel")
				item_panel.style.backgroundSize = "100%"
                if (item_info.set_type == 'jewell'){
					item_panel.style.backgroundImage = "url('file://{resources}/images/sets/"+item_info.item_type+".png')";
				}else{
					item_panel.style.backgroundImage = "url('file://{resources}/images/sets/" + item_info.set_type + "/" + item_info.item_type +".png')";
					item_panel.AddClass("equipped_item_shadow_level_" + item_info.level)
                    item_panel.style.backgroundSize = "95%"
                    item_panel.style.backgroundPosition = "center center"
				}
                
                item_panel.item_icon = item_icon
                item_panel.hittest = false
				
				if (item_info.set_type != 'jewell'){
				
					find_slot.SetPanelEvent("onmouseactivate", function() {
						set_item_for_sale(inventory_key_slot);
					});
				}
            }
        }
    }
}

var decription_attributes = CustomNetTables.GetTableValue( "set_attributes", 'set_attributes')
var boost_attributes = CustomNetTables.GetTableValue( "boost_attributes", 'boost_attributes')

var textEntry;
var textPrice;
var textHint;
var sellButton;
var price = 2
var trade = $("#trade_panel_content_sell")
var current_selling_item = null

function clear(){
	trade.RemoveAndDeleteChildren()
}

function set_item_for_sale(number){
	var data = inventory[number];

    current_selling_item = data

    var percent = ['lifesteal', 'magic_lifesteal', 'reflect', 'spell_amplify', 'magic_desolator', 'hp_regen', 'legs', 'shield', 'manacost', 'hp_regen_amp', 'crit', 'multicast', 'magic_crit'];
    var int_num = ['head', 'legs', 'weapon'];
	
	if (percent.includes(data.item_type)){
		perc = '%'
	}else{
		perc = ''
	}
	if (int_num.includes(data.item_type)){
		num = 0
	}else{
		num = 1
	}

	clear()
	// ------------------------------------- TARGET ---------------------------------
	
	var pan = $.CreatePanel("Panel", trade, '');
	pan.BLoadLayoutSnippet("sell_snippet");
	
	pan.FindChildTraverse('sell_item_panel_name').text = $.Localize("#"+data.set_type+"_"+data.item_type) + " " + data.level
	pan.FindChildTraverse('sell_item_panel_image').SetImage('file://{resources}/images/sets/' + data.set_type + '/' + data.item_type + '.png');
	pan.FindChildTraverse('sell_item_panel_base').text = $.Localize("#"+data.item_type+"_description") + " " + (decription_attributes[[data.item_type]] * data.level * data.set_number) + perc
	
	var bonus_panel = pan.FindChildTraverse('sell_item_panel_bonus')
	for (const attrKey in data.bonus_attribute) {
		let label = $.CreatePanel("Label", bonus_panel, "")
		label.AddClass('bonus_label')
		
		if (percent.includes(attrKey)){
			perc = '%'
		}else{
			perc = ''
		}
		if (int_num.includes(attrKey)){
			num = 0
		}else{
			num = 1
		}

		label.text = $.Localize("#"+attrKey+"_description") + " " + (decription_attributes[attrKey] * data.set_number +  boost_attributes[attrKey][data.set_number] * (data.level - 1)).toFixed(num) + perc  

		let hr = $.CreatePanel("Panel", bonus_panel, "SourceValueLine") 
	}	
	
	// ------------------------------------- DESCRIPTION ---------------------------------
	

	textEntry = pan.FindChildTraverse('buy_text_input')
	textPrice = pan.FindChildTraverse('sell_item_panel_price_label')
	textHint = pan.FindChildTraverse('sell_item_panel_input_hint')
	sellButton = pan.FindChildTraverse('sell_item_panel_desc_button')


	pan.FindChildTraverse('sell_item_panel_desc_button').SetPanelEvent("onmouseactivate", function() {sell_item_request(data, number)});
}

function sell_item_request(item, number) {
    let item_id = item.id || item.item_id || null;
    let slot_number = parseInt(number);
    
    let setNumber = item.set_number ? item.set_number : 1;
    let minAllowed = MIN_PRICES_BY_SET[setNumber] || 2;

    let currentInput = parseInt(textEntry.text);

    let buyer_price = (Number.isNaN(currentInput) || currentInput < minAllowed) 
                      ? minAllowed 
                      : currentInput;

    GameEvents.SendCustomGameEventToServer("sell_item", {
        item_id: item_id,
        slot_number: slot_number,
        price: buyer_price
    });
}

const MIN_PRICES_BY_SET = {
    1: 2,
    2: 5,
    3: 10,
    4: 15,
    5: 20,
    6: 25
};

function InputCount() {
    let text = textEntry.text;

    if (text.includes(".")) {
        text = text.replaceAll(".", "");
        textEntry.text = text;
    }

    let textInt = parseInt(text);

    let setNumber = (current_selling_item && current_selling_item.set_number) ? current_selling_item.set_number : 1;
    let minAllowed = MIN_PRICES_BY_SET[setNumber] || 2;

    if (Number.isNaN(textInt) || textInt < minAllowed) {
        textInt = minAllowed;
        if (textHint) {
            textHint.text = $.Localize("#min_price_hint") + " " + minAllowed;
            textHint.AddClass("input_hint_error");
        }
        if (sellButton) {
            sellButton.enabled = false;
            sellButton.AddClass("sell_button_disabled");
        }
    } else {
        if (textHint) {
            textHint.text = $.Localize("#input_sell");
            textHint.RemoveClass("input_hint_error");
        }
        if (sellButton) {
            sellButton.enabled = true;
            sellButton.RemoveClass("sell_button_disabled");
        }
        if (textInt > 1500) {
            textInt = 1500;
            textEntry.text = "1500";
        }
    }

    price = textInt - Math.ceil(textInt * 0.1);
    price = Math.max(price, 0);
    price = Math.min(price, 1500);

    textPrice.text = $.Localize("#give_coins_after_sell") + " " + price;
}

///////////////////////////////////////// ORDER //////////////////////////////////////////////////////////

function update_order(data){
	init_order(data)
}

function init_order(data){
	$("#trade_panel_order_container").RemoveAndDeleteChildren()
	
	// Инициализируем счетчики
	let sold_count = 0;
	let active_count = 0;
	
	// Сначала считаем количество по статусам
	for (const key in data) {
		if (data.hasOwnProperty(key)) {
			const item = data[key];
			if (item.status == "SOLD") {
				sold_count++;
			} else if (item.status == "ACTIVE" || item.status == "EXPIRED") {
				active_count++;
			}
		}
	}
	
	// Сортируем данные: EXPIRED → ACTIVE → SOLD
	let sortedData = Object.values(data).sort((a, b) => {
		const statusOrder = { "EXPIRED": 0, "ACTIVE": 1, "SOLD": 2 };
		const aOrder = statusOrder[a.status] !== undefined ? statusOrder[a.status] : 999;
		const bOrder = statusOrder[b.status] !== undefined ? statusOrder[b.status] : 999;
		return aOrder - bOrder;
	});
	
	// Теперь создаем панели и отображаем данные
	for (const item of sortedData) {
		var item_panel = $.CreatePanel("Panel", $("#trade_panel_order_container"), item.id);
		item_panel.BLoadLayoutSnippet("items_orders");
		item_panel.FindChildTraverse("trade_panel_element_image").style.backgroundImage = "url('file://{resources}/images/sets/" + item.item.set_type + "/" + item.item.item_type +".png')";
		item_panel.FindChildTraverse("trade_panel_element_image").style.backgroundSize = "95%"
		item_panel.FindChildTraverse("trade_panel_element_image").style.backgroundPosition = "center center"
		item_panel.FindChildTraverse("trade_panel_element_image").AddClass("equipped_item_shadow_level_" + item.item.level)
		item_panel.FindChildTraverse("trade_panel_element_item_name").text = $.Localize("#"+item.item.set_type+"_"+item.item.item_type)
		item_panel.FindChildTraverse("trade_panel_element_item_seller").steamid = item.seller_steam_id
		item_panel.FindChildTraverse("name_data_label").text = $.Localize("#order_open") + " " + date_conv(item.created_at)
		item_panel.FindChildTraverse("trade_panel_element_item_price_count").text = item.price
		item_panel.FindChildTraverse("trade_panel_element_image").SetPanelEvent("onmouseover", onAbilityMouseOver.bind(this, item_panel.FindChildTraverse("trade_panel_element_image"), item));
		item_panel.FindChildTraverse("trade_panel_element_image").SetPanelEvent("onmouseout", onAbilityMouseOut.bind(this, item_panel.FindChildTraverse("trade_panel_element_image")));
		item_panel.FindChildTraverse("trade_panel_element_item_loading").visible = false

		if (item.status == "ACTIVE"){
			item_panel.BLoadLayoutSnippet("trade_panel_element_items_orders_active");
			item_panel.FindChildTraverse("trade_panel_element_items_orders_active_btn").SetPanelEvent("onmouseactivate", close_order.bind(this, item, item_panel));
		}else if (item.status == "EXPIRED"){
			item_panel.BLoadLayoutSnippet("trade_panel_element_items_orders_expired");
			item_panel.FindChildTraverse("trade_panel_element_items_orders_expired_btn").SetPanelEvent("onmouseactivate", close_order.bind(this, item, item_panel));
			item_panel.style.backgroundColor = "#c97910b4";
		}else if (item.status == "SOLD"){
			item_panel.BLoadLayoutSnippet("trade_panel_element_items_orders_sold");
			item_panel.style.backgroundColor = "#65b10fb4";
		}
	}
	
	// Обновляем счетчики в UI
	$("#trade_panel_order").FindChildTraverse("trade_panel_order_sold_label").SetDialogVariable("sold", sold_count)
	$("#trade_panel_order").FindChildTraverse("trade_panel_order_active_label").SetDialogVariable("active", active_count)
}

function close_order(item, panel){
	$.Msg(item)
	panel.FindChildTraverse("trade_panel_element_item_loading").visible = true
	GameEvents.SendCustomGameEventToServer("close_order", {
		listing_id: item.id,
		item_id: item.item.id,
	})
}

///////////////////////////////////////////////////////////////////////////////////////////////////

function date_conv(dateString){
	let date = new Date(dateString);
	let year = date.getFullYear();
	let month = String(date.getMonth() + 1).padStart(2, '0');
	let day = String(date.getDate()).padStart(2, '0');

	let formattedDate = `${year}-${month}-${day}`;
	return formattedDate	
}

function show(type_name) {
	loading = $.CreatePanel("Panel", $("#trade_panel_content"), 'loading');
    loading.AddClass("trade_panel_element_item_loading");
	loading.visible = true
	
	GameEvents.SendCustomGameEventToServer("get_trade_items", {type:type_name})
    g = $("#trade_panel_content").Children()
    for (const key in g) {
		 if(g[key].id  == "loading"){
			  g[key].visible = true
		 }else{
			  g[key].visible = false
		}
	}  

	var sort_children = $("#trade_panel_sort").Children();
	for (var i = 0; i < sort_children.length; i++) {
		var child = sort_children[i];
		
		if (child.id === type_name) {
			child.AddClass("selected");
			// child.SetSelected(true); 
		} else {
			child.RemoveClass("selected");
			// child.SetSelected(false);
		}
	}
}

function showTooltip(panel, data) {
    if (data) {
        let params = `&item_data=` + JSON.stringify(data.item)
        $.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, "SetCreepTooltip", "file://{resources}/layout/custom_game/custom_tooltip/custom_tooltip.xml", params);
    }
}

function onAbilityMouseOver(panel, data) {
	if(!data){
		data = inventory[panel.slot_count]
		if (data){
			let params = `&item_data=` + JSON.stringify(data)
			$.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, "SetCreepTooltip", "file://{resources}/layout/custom_game/custom_tooltip/custom_tooltip.xml", params);
		}
	}else{
		showTooltip(panel, data);
	}
}

function onAbilityMouseOut(panel) {
	$.DispatchEvent("UIHideCustomLayoutTooltip", panel, "SetCreepTooltip");
}

(function(){
	GameEvents.Subscribe( "update_order", update_order)
	GameEvents.Subscribe( "init_order", init_order)
	GameEvents.Subscribe( "update_buy", update_buy)
	GameEvents.Subscribe( "init_buy", init_buy)
	GameEvents.Subscribe( "init_sell", init_sell)
	GameEvents.Subscribe( "ActivateTrade", ActivateTrade)
	GameEvents.Subscribe( "DeactivateTrade", DeactivateTrade)
	GameUI.CustomUIConfig.CloseOrders = close;
})();