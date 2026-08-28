--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


var item_reward_panel = $("#item_reward_panel")
item_reward_panel.visible = false
item_reward_panel.RemoveAndDeleteChildren()

$("#InventoryPanel").SetHasClass("CloseInventory", true)

var percent = ['lifesteal', 'magic_lifesteal', 'reflect', 'spell_amplify', 'magic_desolator', 'hp_regen', 'legs', 'shield', 'manacost', 'hp_regen_amp', 'crit', 'multicast', 'magic_crit'];
var int_num = ['head', 'legs', 'weapon'];

function GetDotaHud()
{
	let hPanel = $.GetContextPanel();
	while ( hPanel && hPanel.id !== 'Hud')
	{
        hPanel = hPanel.GetParent();
	}
	if (!hPanel)
	{
        throw new Error('Could not find Hud root from panel with id: ' + $.GetContextPanel().id);
	}
	return hPanel;
}

function FindDotaHudElement(sId)
{
	return GetDotaHud().FindChildTraverse(sId);
}

FindDotaHudElement("AghsStatusContainer").visible = false;

var current_selected_player = null // Выбранный текущий герой
var default_inventory_slots = 30 // Дефолтное количество слотов
var is_local_inventory = true // локальный ли инвентарь
var ENABLE_VIEW_OTHER_INVENTORY = false // хз нужно ли видеть предметы игрока в инвентаре
var EQUIP_ITEMS_TYPES_COLUMN_1 = ["head", "armor", "legs", "boots", "weapon", "shield"] // Первая колонка слотов, в которые можно надевать предметы
var TABLE_HERO = null
var HERO_LEVEL = 1
var IS_OPEN_NOW = false

const DotaHUD = GameUI.CustomUIConfig().DotaHUD;
DotaHUD.windowControllers["inventory_hud"] = {
    is_open: false,
    open: function(){
        IS_OPEN_NOW = true
        GameEvents.SendCustomGameEventToServer("Get_hero_inventory", {pid : Entities.GetPlayerOwnerID(current_selected_player), send_id : current_selected_player})
    },
    close: function(){
        IS_OPEN_NOW = false
        $("#InventoryPanel").SetHasClass("CloseInventory", true)
        UpdateInventoryButton()
    }
}
DotaHUD.ListenToMouseEvent(
    DotaHUD.GetCloseWindowOnOutsideClick($("#InventoryPanel"), "inventory_hud")
);

function InitInventoryButton() // Перенос кнопки в слот способностей
{
    let AbilitiesAndStatBranch = FindDotaHudElement("AbilitiesAndStatBranch");
    if (AbilitiesAndStatBranch)
    {
        let InventoryButtonHud = AbilitiesAndStatBranch.FindChildTraverse("InventoryButtonHud");
        if (InventoryButtonHud == null)
        {
            $("#InventoryButtonHud").SetParent(FindDotaHudElement("AbilitiesAndStatBranch").GetChild(0));
        }
    }

    UpdateInventoryButton();
	
	$.RegisterEventHandler( 'DragStart', $("#InventoryDust"), OnDragStart );
	$.RegisterEventHandler( 'DragEnd', $("#InventoryDust"), OnDragEnd );
	$.RegisterEventHandler( 'DragEnter', $("#InventoryDust"), OnDragEnter );
	$.RegisterEventHandler( 'DragDrop', $("#InventoryDust"), OnDragDrop );
	$.RegisterEventHandler( 'DragLeave', $("#InventoryDust"), OnDragLeave );
}

function UpdateInventoryButton() // Апдейтер кнопки инвентаря, чтоб не отображать на крипах вдруг
{
    let InventoryButtonHud = FindDotaHudElement("InventoryButtonHud");
    if (InventoryButtonHud)
    {
        if (Entities.IsRealHero( Players.GetLocalPlayerPortraitUnit() ))
        {
            InventoryButtonHud.style.visibility = "visible"
        }
        else
        {
            InventoryButtonHud.style.visibility = "collapse"
        }
    }   

    if (IS_OPEN_NOW == false)
    {
        current_selected_player = Players.GetLocalPlayerPortraitUnit()
        
    }
	
	if (!$("#InventoryPanel").BHasClass("CloseInventory")){
		FindDotaHudElement("trade_panel_main").visible = false;
		FindDotaHudElement("trade_panel_start").visible = false;
		FindDotaHudElement("trade_panel_buy").visible = false;
		FindDotaHudElement("trade_panel_sell").visible = false;
		FindDotaHudElement("trade_panel_order").visible = false;
		FindDotaHudElement("blacksmith_panel_main").visible = false;
	}
}


function OpenInventory()
{   
    DotaHUD.WindowOpen("inventory_hud");
}

function open_inv(t){
    IS_OPEN_NOW = true
	$("#InventoryPanel").ToggleClass("CloseInventory")
    UpdateInventoryMain(t)
    DotaHUD.WindowCloseAnyway("blacksmith")
    DotaHUD.WindowCloseAnyway("trade")
}


function UpdateInventoryMain(t)
{
    $("#DustPaneLabel").text = t.data.dust
    
	TABLE_HERO = t.data
	HERO_LEVEL = t.diff
	
	if (current_selected_player != t.data.send_id){
		return
	}

    let player_id = Entities.GetPlayerOwnerID(current_selected_player)
    if (player_id != Players.GetLocalPlayer())
    {
        is_local_inventory = false
		$("#DustPaneLabel").visible = false
    }
    else
    {
        is_local_inventory = true
		$("#DustPaneLabel").visible = true
    }
	
    $("#InventorySlots").RemoveAndDeleteChildren()
    if (is_local_inventory || ENABLE_VIEW_OTHER_INVENTORY)
    {
        UpdateInventorySlots()
        UpdateInventoryItems(TABLE_HERO.hero_inventory)
        $("#InventoryMain").SetHasClass("HideInventory", false)
		$("#AutoDismantlingToggle").SetHasClass("HideInventory", false)
    }else{
        $("#InventoryMain").SetHasClass("HideInventory", true)
		$("#AutoDismantlingToggle").SetHasClass("HideInventory", true)
    }
    EquipCreateSlots()
    UpdateEquipItems(TABLE_HERO.hero_enquip)
	update_description()
}


var decription_attributes = CustomNetTables.GetTableValue( "set_attributes", 'set_attributes')
var boost_attributes = CustomNetTables.GetTableValue( "boost_attributes", 'boost_attributes')

function CheckFullSet() {
    var data = TABLE_HERO.hero_enquip;
    var filledItems = 0;
    var setType = null;

    for (const itemKey in data) {
        const itemData = data[itemKey];
        if (itemData != null) {
            filledItems++;
            if (setType == null) {
                setType = itemData.set_type;
            } else if (setType !== itemData.set_type) {
                return false;
            }
        }
    }
    return filledItems === 6;
}

var can_use_sets = CustomNetTables.GetTableValue( "can_use_sets", 'can_use_sets')
	
function update_description(){
	var data = TABLE_HERO.hero_enquip
	description_panel =	$("#QuipDescription")
	description_panel.RemoveAndDeleteChildren()

	const attributeSum = {};
	
	for (const itemKey in data) {
		const itemData = data[itemKey];
		if (itemData == null){
			continue
		}
		for (const attributesKey of ["bonus_attribute", "base_attribute"]) {
			const attributes = itemData[attributesKey];
			
			for (const attrKey in attributes) {
				const value = decription_attributes[attrKey]
				
				if (HERO_LEVEL < can_use_sets[itemData.set_number.toString()].min) {
                    continue;
                }
				
				if (attributesKey == "base_attribute"){
					if (!attributeSum[attrKey]) {
						attributeSum[attrKey] = itemData.level * itemData.set_number * value
					}
				}else{
					if (!attributeSum[attrKey]) {
						attributeSum[attrKey] = value * itemData.set_number +  boost_attributes[attrKey][itemData.set_number] * (itemData.level - 1)
						// attributeSum[attrKey] = value + (itemData.set_number * 0.1 * itemData.level) - itemData.set_number * 0.1
					}else{
						attributeSum[attrKey] = attributeSum[attrKey] + value * itemData.set_number +  boost_attributes[attrKey][itemData.set_number] * (itemData.level - 1)
						// attributeSum[attrKey] = attributeSum[attrKey] + value + (itemData.set_number * 0.1 * itemData.level) - itemData.set_number * 0.1
					}
				// $.Msg(attributeSum[attrKey], attrKey)
				}
			}
		}
	}
	
	const simple_color = ['head', 'legs', 'armor', 'boots', 'weapon', 'shield'];
	
	let lastHr

	for (const attrKey in attributeSum) {
		let label = $.CreatePanel("Label", description_panel, "")
		label.AddClass('font_desr')
		
		if (simple_color.includes(attrKey)){
			color = "#ffd700bf"
		}else{
			color = "#00f704bf"
		}
		
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
		if (CheckFullSet()){
			mult = 2
		}else{
			mult = 1
		}
		
		label.text = $.Localize("#"+attrKey+"_description") + " " + (attributeSum[attrKey].toFixed(num) * mult) + perc
		label.style.color = color
		lastHr = $.CreatePanel("Panel", description_panel, "hr") 
	}

	if (lastHr)
		lastHr.DeleteAsync(0)
}

function UpdateInventorySlots() // Апдейт количество слотов, если вдруг у игроков они разные
{
    for (let i = 1; i <= default_inventory_slots; i++)
    {
        CreateSlot(i)
    }
}

function CreateSlot(i) // Создание слота для инвентаря
{
    let inventory_slot = $.CreatePanel("Panel", $("#InventorySlots"), "inventory_slot_"+i)
    inventory_slot.AddClass("inventory_slot")
	
	inventory_slot.SetPanelEvent("onmouseover", onAbilityMouseOver.bind(this, inventory_slot));
	inventory_slot.SetPanelEvent("onmouseout", onAbilityMouseOut.bind(this, inventory_slot));
	
    inventory_slot.is_slot = true
    inventory_slot.hittestchildren = false
    inventory_slot.slot_count = i
    inventory_slot.is_inventory_slot = true
    inventory_slot.SetDraggable(true)
    $.RegisterEventHandler( 'DragStart', inventory_slot, OnDragStart );
    $.RegisterEventHandler( 'DragEnd', inventory_slot, OnDragEnd );
    $.RegisterEventHandler( 'DragEnter', inventory_slot, OnDragEnter );
    $.RegisterEventHandler( 'DragDrop', inventory_slot, OnDragDrop );
    $.RegisterEventHandler( 'DragLeave', inventory_slot, OnDragLeave );
}

function UpdateInventoryItems(inventory_list) // Апдейт всех предметов инвентаря
{
    for (let i = 0; i <= Object.keys(inventory_list).length; i++)
    {
        if (Object.keys(inventory_list)[i] != null)
        {
            let inventory_key_slot = Object.keys(inventory_list)[i]
            let item_info = inventory_list[inventory_key_slot]
            if (item_info != null)
            {
                let item_icon = item_info.set_type + "/" + item_info.item_type
                
                let find_slot = $("#InventorySlots").FindChildTraverse("inventory_slot_"+inventory_key_slot)
    
                let item_panel = $.CreatePanel("Panel", find_slot, "")
                item_panel.AddClass("item_panel")

                item_panel.style.backgroundSize = "100%"
                item_panel.item_icon = item_icon
                item_panel.hittest = false
                find_slot.item_in_slot = item_panel

                if (item_info.set_type == 'jewell'){
					item_panel.style.backgroundImage = "url('file://{resources}/images/sets/"+item_info.item_type+".png')";
				}else{
					item_panel.style.backgroundImage = "url('file://{resources}/images/sets/" + item_info.set_type + "/" + item_info.item_type +".png')";
                    item_panel.AddClass("equipped_item_shadow_level_" + item_info.level)
                    item_panel.style.backgroundSize = "95%"
                    item_panel.style.backgroundPosition = "center center"
				}
                
            }
        }
    }
}

function OnDragStart( panelId, dragCallbacks )
{
	onAbilityMouseOut(panelId) 
    // Если нет предмета в слоте
    if (panelId.item_in_slot == null)
    {
        return
    }
    // Если инвентарь не локального игрока
    if (!is_local_inventory)
    {
        return
    }
	var displayPanel = $.CreatePanel( "Panel", $.GetContextPanel(), "dragImage" );
    displayPanel.AddClass("dragImage")
	
	// $.Msg(panelId.item_in_slot.item_icon)
	
    displayPanel.style.backgroundImage = "url('file://{resources}/images/sets/" + panelId.item_in_slot.item_icon +".png')";
    // displayPanel.style.backgroundImage = 'url("' + panelId.item_in_slot.item_icon + '")';
    displayPanel.style.backgroundSize = "100%"
    displayPanel.original_slot = panelId;
	dragCallbacks.displayPanel = displayPanel;
	dragCallbacks.offsetX = 0;
	dragCallbacks.offsetY = 0;
	return true;
}

function OnDragEnd( panelId, draggedPanel )
{
	draggedPanel.DeleteAsync( 0 );
	return true;
} 

function OnDragEnter( panelId, draggedPanel )
{
	return true;
}

function OnDragLeave( panelId, draggedPanel )
{
	return true;
}

function OnDragDrop( panelId, draggedPanel )
{
    let new_panel = panelId // Куда перенес
    let old_panel = draggedPanel.original_slot // Откуда перенес
    // Если инвентарь не локального игрока
	
	// $.Msg(old_panel.GetChild(0))
	
	if (new_panel.id == 'InventoryDust')
    {
		let old_panel_item = old_panel.GetChild(0) // Переносимый итем
		if (old_panel_item) {
			dust_item(old_panel, new_panel, old_panel_item)
		}
		return
    }
	
    if (!is_local_inventory)
    {
        return
    }

    // Если перенос не в слот для предмета
    if (new_panel.is_slot == null)
    {
        return
    }

    // Если перносимый предмет вернулся в ту же ячейку
    if (new_panel == old_panel)
    {
        return
    }

    let old_panel_item = old_panel.GetChild(0) // Переносимый итем
    let new_panel_item = panelId.GetChild(0) // Есть ли уже предмет в переносимом слоте

    // Если перенос из инвентаря в инвентарь
    if (new_panel.is_inventory_slot != null && old_panel.is_inventory_slot != null)
    {
        SwapItemsInventoryOnly(old_panel, new_panel, old_panel_item, new_panel_item)
    }
    // Если перенос из инвентаря в слот экипировки
    else if (new_panel.is_quip_slot != null && old_panel.is_inventory_slot != null)
    {
        SwapItemsFromInventoryToEquip(old_panel, new_panel, old_panel_item, new_panel_item)
    }
    // Если перенос из экипировки в инвентарь
    else if (new_panel.is_inventory_slot != null && old_panel.is_quip_slot != null)
    {
        SwapItemsFromEquipToInventory(old_panel, new_panel, old_panel_item, new_panel_item)
    }

	return true;
}

function dust_item(old_panel, new_panel, old_panel_item)
{
    // Проверяем, что все необходимые объекты существуют
    if (!old_panel || !old_panel_item || !TABLE_HERO || !TABLE_HERO['hero_inventory']) {
        return
    }
    
    let old_slot_num = old_panel.slot_count
    let old_item_info = TABLE_HERO['hero_inventory'][old_slot_num]
    
    // Проверяем, что old_panel_item имеет родительский элемент
    if (old_panel_item.GetParent) {
        old_panel_item.GetParent().RemoveAndDeleteChildren()
    }
    old_panel.item_in_slot = null

    TABLE_HERO['hero_inventory'][old_slot_num] = null
	
	Game.EmitSound("Hero_ObsidianDestroyer.projectileImpact")
	
	update_description()
	
	// Отправляем информацию о свапе в слот распыления
	let swapped_items = []
	if (old_item_info && old_item_info.id) {
		swapped_items = [{
			item_id: old_item_info.id,
			from_slot: old_slot_num,
			to_slot: "dust" // слот распыления/мусор
		}]
		send_swap_inventory_items(swapped_items)
	}
	
	// Отправляем общие данные с информацией о свапе
	let event_data = {data:TABLE_HERO, target:old_item_info}
	if (swapped_items.length > 0) {
		event_data.swapped_items = swapped_items
	}
	GameEvents.SendCustomGameEventToServer("update_hero_inventory", event_data) //---------------------------------------DUST ITEM 
}

function SwapItemsInventoryOnly(old_panel, new_panel, old_panel_item, new_panel_item) // Если перенос из инвентаря в инвентарь
{
    // Номера слотов
    let old_slot_num = old_panel.slot_count
    let new_slot_num = new_panel.slot_count

    // Информация слотов
    let old_item_info = TABLE_HERO['hero_inventory'][old_slot_num]
    let new_item_info = TABLE_HERO['hero_inventory'][new_slot_num]

    // Перенос предмета
    old_panel_item.SetParent(new_panel)
    new_panel.item_in_slot = old_panel_item

    // Если уже в новом слоте был итем
    if (new_panel_item != null)
    {
        new_panel_item.SetParent(old_panel)
        old_panel.item_in_slot = new_panel_item
    }
    else
    {
        old_panel.item_in_slot = null
    }

    // Апдейт массива
    TABLE_HERO['hero_inventory'][old_slot_num] = new_item_info
    TABLE_HERO['hero_inventory'][new_slot_num] = old_item_info
    
    // Получаем информацию о свапнутых предметах (ID и номера слотов)
    let swapped_items = []
    if (old_item_info && old_item_info.id && new_item_info && new_item_info.id) {
        // Если оба предмета существуют - это полный свап
        swapped_items.push({
            item_id: old_item_info.id,
            from_slot: old_slot_num,
            to_slot: new_slot_num,
        })
        // swapped_items.push({
        //     item_id: new_item_info.id,
        //     from_slot: old_slot_num,
        //     to_slot: new_slot_num,
        // })
    } else if (old_item_info && old_item_info.id) {
        // Если только один предмет - это перемещение в пустой слот
        swapped_items.push({
            item_id: old_item_info.id,
            from_slot: old_slot_num,
            to_slot: new_slot_num
        })
    }
    
    // Отправляем отдельное событие для свапа предметов только если есть предметы
    if (swapped_items.length > 0) {
        send_swap_inventory_items(swapped_items)
    }
    // Обновляем описание и отправляем общие данные с информацией о свапе
	send_update_hero(swapped_items)
}

function SwapItemsFromEquipToInventory(old_panel, new_panel, old_panel_item, new_panel_item)
{
    let new_slot_num = new_panel.slot_count
    let old_slot_type = old_panel.type_slot
    
    if (TABLE_HERO['hero_inventory'][new_slot_num] != null) // Если слот занят
    {
        return
    }

    // Перенос предмета
    old_panel_item.SetParent(new_panel)
    new_panel.item_in_slot = old_panel_item
    old_panel.item_in_slot = null

    let old_item_info = TABLE_HERO['hero_enquip'][old_slot_type]
    TABLE_HERO['hero_inventory'][new_slot_num] = old_item_info
    TABLE_HERO['hero_enquip'][old_slot_type] = null
    
    // Получаем информацию о перемещенном предмете (ID и номера слотов)
    let swapped_items = []
    if (old_item_info && old_item_info.id) {
        swapped_items.push({
            item_id: old_item_info.id,
            from_slot: old_slot_type, // тип слота экипировки
            to_slot: new_slot_num
        })
    }
    
    // Отправляем отдельное событие для свапа предметов только если есть предметы
    if (swapped_items.length > 0) {
        send_swap_inventory_items(swapped_items)
    }
    // Обновляем описание и отправляем общие данные с информацией о свапе
	send_update_hero(swapped_items)
}

function SwapItemsFromInventoryToEquip(old_panel, new_panel, old_panel_item, new_panel_item)
{
	
    let old_slot_num = old_panel.slot_count
    let new_slot_type = new_panel.type_slot
    let old_item_info = TABLE_HERO['hero_inventory'][old_slot_num]
    if (old_item_info.item_type != new_slot_type) // Если не тот тип экипировки
    {
        return
    }
    if (TABLE_HERO['hero_enquip'][new_slot_type] != null) // Если слот занят
    {
        return
    }
    old_panel_item.SetParent(new_panel)
    new_panel.item_in_slot = old_panel_item
    old_panel.item_in_slot = null

    TABLE_HERO['hero_enquip'][new_slot_type] = old_item_info
    TABLE_HERO['hero_inventory'][old_slot_num] = null
    
    // Получаем информацию о перемещенном предмете (ID и номера слотов)
    let swapped_items = []
    if (old_item_info && old_item_info.id) {
        swapped_items.push({
            item_id: old_item_info.id,
            from_slot: old_slot_num,
            to_slot: new_slot_type // тип слота экипировки
        })
    }
    
    // Отправляем отдельное событие для свапа предметов только если есть предметы
    if (swapped_items.length > 0) {
        send_swap_inventory_items(swapped_items)
    }
    // Обновляем описание и отправляем общие данные с информацией о свапе
	send_update_hero(swapped_items)
}

function EquipCreateSlots() // Создание слотов для экипировки
{
    $("#ItemsColumn_1").RemoveAndDeleteChildren()
    for (let i = 0; i < EQUIP_ITEMS_TYPES_COLUMN_1.length; i++)
    {
        CreateSlotEquip(i, $("#ItemsColumn_1"), EQUIP_ITEMS_TYPES_COLUMN_1[i])
    }
}

function CreateSlotEquip(i, main, type_name) // Создание слота для экипировки
{
    // $.Msg(EQUIP_ITEMS_TYPES_COLUMN_1[i])
    let equip_slot_main = $.CreatePanel("Panel", main, type_name)
    equip_slot_main.AddClass("equip_slot_main")

    let equip_slot_label = $.CreatePanel("Label", equip_slot_main, "")
    equip_slot_label.AddClass("equip_slot_label")
    equip_slot_label.text = $.Localize("#" + type_name + "_slot")

    let equip_slot = $.CreatePanel("Panel", equip_slot_main, "equip_slot_"+type_name)
    equip_slot.AddClass("equip_slot")
	
	equip_slot.SetPanelEvent("onmouseover", onAbilityMouseOver.bind(this, equip_slot));
	equip_slot.SetPanelEvent("onmouseout", onAbilityMouseOut.bind(this, equip_slot));

    equip_slot.SetDraggable(true)
    equip_slot.is_slot = true
    equip_slot.hittestchildren = false
    equip_slot.is_quip_slot = true
    equip_slot.type_slot = type_name

    $.RegisterEventHandler( 'DragStart', equip_slot, OnDragStart );
    $.RegisterEventHandler( 'DragEnd', equip_slot, OnDragEnd );
    $.RegisterEventHandler( 'DragEnter', equip_slot, OnDragEnter );
    $.RegisterEventHandler( 'DragDrop', equip_slot, OnDragDrop );
    $.RegisterEventHandler( 'DragLeave', equip_slot, OnDragLeave );
}

function UpdateEquipItems(equip_list) // Обновить экипированные предметы
{
	// $.Msg(current_selected_player)

    for (let i = 0; i <= Object.keys(equip_list).length; i++)
    {
        if (Object.keys(equip_list)[i] != null)
        {
            let equip_slot_name = Object.keys(equip_list)[i]
            let item_info = equip_list[equip_slot_name]
			let find_slot = $("#EquipMain").FindChildTraverse("equip_slot_"+equip_slot_name)
            if (item_info != null)
            {
                let item_name = item_info.name
                let item_type = item_info.type
                let item_attributes = item_info.attributes
                let item_icon = item_info.set_type + "/" + item_info.item_type
                
               
                let item_panel = $.CreatePanel("Panel", find_slot, "")
                item_panel.AddClass("item_panel")
                item_panel.style.backgroundImage = "url('file://{resources}/images/sets/" + item_info.set_type + "/" + item_info.item_type +".png')";
                item_panel.style.backgroundSize = "95%"
                item_panel.style.backgroundPosition = "center center"
                item_panel.item_icon = item_icon
                item_panel.hittest = false
                find_slot.item_in_slot = item_panel
                item_panel.AddClass("equipped_item_shadow_level_" + item_info.level)
            }
        }
    } 
}

function showTooltip(panel, data) {
    if (data) {
        let params = `&item_data=` + JSON.stringify(data) + 
					`&all_data=` + JSON.stringify(TABLE_HERO);
        $.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, "SetCreepTooltip", "file://{resources}/layout/custom_game/custom_tooltip/custom_tooltip.xml", params);
    }
}

function onAbilityMouseOver(panel) {
    // $.Msg(panel)
    if (panel.type_slot) {
        let data = TABLE_HERO.hero_enquip[panel.type_slot];
        showTooltip(panel, data);
    }
    
    if (panel.slot_count) {
        let data = TABLE_HERO.hero_inventory[panel.slot_count];
        showTooltip(panel, data);
    }
}

function onAbilityMouseOut(panel) {
	$.DispatchEvent("UIHideCustomLayoutTooltip", panel, "SetCreepTooltip");
}

function CloseInventory() // Закрыть инвентарь
{
    DotaHUD.WindowClose("inventory_hud");
}

function send_update_hero(swapped_items = null){
	// $.Msg(TABLE_HERO)
	let player_id = Entities.GetPlayerOwnerID(current_selected_player)
    if (player_id == Players.GetLocalPlayer()){
		update_description()
		let event_data = {data:TABLE_HERO}
		if (swapped_items && swapped_items.length > 0) {
			event_data.swapped_items = swapped_items
		}
		GameEvents.SendCustomGameEventToServer("update_hero_inventory", event_data)
	}
}

function send_swap_inventory_items(swapped_items){
	let player_id = Entities.GetPlayerOwnerID(current_selected_player)
    if (player_id == Players.GetLocalPlayer() && swapped_items && swapped_items.length > 0){
		GameEvents.SendCustomGameEventToServer("swap_inventory_items", {swapped_items: swapped_items})
	}
}


function show_item_reward(data){

    // var data = data.data
    var data = data.data ? data.data : data;
	
	item_reward_panel.visible = true
	
	Game.EmitSound("Item.PickUpGemWorld")
	
	
	let panel = $.CreatePanel("Panel", item_reward_panel, "dynamicItemPanel");
	panel.BLoadLayoutSnippet("reward")
	panel.AddClass("content")
	
	color = null
	
	if (data.level < 3){
		color = "#b0c3d9"
	}else if(data.level == 3 || data.level == 4){
		color = "#5e98d9"
	}else if(data.level == 5 || data.level == 6){
		color = "#4b69ff"
	}else if(data.level == 7 || data.level == 8){
		color = "#8847ff"
	}else if(data.level == 9 ){
		color = "#d32ce6"
	}else if(data.level == 10 ){
		color = "#e4ae39"
	}else if(data.level == 11 ){
		color = "#ed0c2e"
	}
	
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
	
	// panel.FindChildTraverse("TooltipImage").style.height = "90px"
	
	if (data.set_type == 'jewell'){
		panel.FindChildTraverse("TooltipImage").SetImage('file://{resources}/images/sets/'+data.item_type+'.png');
		panel.FindChildTraverse("TooltipName").text = $.Localize("#"+data.set_type+"_"+data.item_type)
		panel.FindChildTraverse("TooltipName").style.color = 'violet'
		panel.FindChildTraverse("MainInfo").style.backgroundColor = "gradient(linear, 50% 0%, 50% 100%, from(" + "#8847ff" + "), to(transparent))";
		panel.FindChildTraverse("BaseAttribute").text = $.Localize("#"+data.item_type+"_description") + ": " + data.level
		panel.FindChildTraverse("Descr").visible = false
	}else{
		panel.FindChildTraverse("TooltipImage").SetImage('file://{resources}/images/sets/' + data.set_type + '/' + data.item_type + '.png');
		panel.FindChildTraverse("TooltipName").text = $.Localize("#"+data.set_type+"_"+data.item_type) + " " + data.level
		panel.FindChildTraverse("TooltipName").style.color = 'white'
		panel.FindChildTraverse("MainInfo").style.backgroundColor = "gradient(linear, 50% 0%, 50% 100%, from(" + color + "), to(transparent))";
		panel.FindChildTraverse("BaseAttribute").text = $.Localize("#"+data.item_type+"_description") + " " + (decription_attributes[[data.item_type]] * data.level * data.set_number) + perc
		
		const minLevelToUse = can_use_sets[data.set_number.toString()].min
		if (minLevelToUse <= 0) {
			panel.FindChildTraverse("Descr").visible = false
			panel.FindChildTraverse("DescrSourceValueLine").visible = false
		} else {
			panel.FindChildTraverse("Descr").visible = true
			panel.FindChildTraverse("Descr").text = $.Localize("#min_level_use") + " " + minLevelToUse
		}
	}
	
	const bonus_attr = panel.FindChildTraverse("BonusAttribute")
	bonus_attr.RemoveAndDeleteChildren()

	let lastHr
	
	for (const attrKey in data.bonus_attribute) {
		let label = $.CreatePanel("Label", bonus_attr, "")
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
		lastHr = $.CreatePanel("Panel", bonus_attr, "hr") 
	}

	if (lastHr) {
		lastHr.DeleteAsync(0)
	} else {
		panel.FindChildTraverse("BonusSourceValueLine").visible = false
	}

	panel.DeleteAsync(5)
	// $.Schedule(2, function(){
		// item_reward_panel.visible = false
    // });
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

(function() {
	// GameUI.CustomUIConfig.CloseInventory = CloseInventory;
   	GameEvents.Subscribe("show_item_reward", show_item_reward)
   	GameEvents.Subscribe("UpdateInventoryMain", UpdateInventoryMain)
   	GameEvents.Subscribe("open_inv", open_inv)
    GameEvents.Subscribe("dota_player_update_query_unit", UpdateInventoryButton);
    GameEvents.Subscribe('dota_player_update_hero_selection', UpdateInventoryButton);
    GameEvents.Subscribe('dota_player_update_selected_unit', UpdateInventoryButton);
    $("#AutoDismantlingToggle").SetPanelEvent("onactivate", ()=>{
        const toggle_state = $("#AutoDismantlingToggle").checked 
        GameEvents.SendCustomGameEventToServer( "auto_dismantling_toggle", {toggle_state : toggle_state} )
    })
})();


InitInventoryButton()

