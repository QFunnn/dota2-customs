--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


"use strict";

// --- Константы и конфигурация ---
const ATTR_CONFIG = {
    percent: ['lifesteal', 'magic_lifesteal', 'reflect', 'spell_amplify', 'magic_desolator', 'hp_regen', 'legs', 'shield', 'manacost', 'hp_regen_amp', 'crit', 'multicast', 'magic_crit'],
    integer: ['head', 'legs', 'weapon']
};

const UI = {
    main: $("#blacksmith_panel_main"),
    target: $("#blacksmith_target"),
    result: $("#blacksmith_result"),
    desc: $("#blacksmith_description"),
    desc_text: $("#blacksmith_description_text"),
    error: $("#blacksmith_errors_label"),
    dust: $("#DustPaneLabel"),
    inv_container: $("#BlacksmithInventorySlots")
};

UI.main.visible = false;

let HERO_INVENTORY = {};
let UPGRADE_BOOST = 0;
let LOADING_PANEL = null;
let LOADING_PANEL_MERGE = null;
let LOADING_PANEL_ENCHANT = null;
let MERGE_ITEMS_DATA = { 1: null, 2: null, 3: null };
let LOCKED_SLOTS = [];

const DECRIPTION_ATTRS = CustomNetTables.GetTableValue("set_attributes", "set_attributes") || {};
const BOOST_ATTRS = CustomNetTables.GetTableValue("boost_attributes", "boost_attributes") || {};
const DOTA_HUD = GameUI.CustomUIConfig().DotaHUD;

// --- Инициализация интерфейса ---
const DotaHUD = GameUI.CustomUIConfig().DotaHUD;

DotaHUD.windowControllers["blacksmith"] = {
    is_open: false,
    open: function() {
        UI.main.visible = true;
        GameEvents.SendCustomGameEventToServer("get_items_upgrade", {});
    },
    close: function() {
        UI.main.visible = false;
    }
};

function ActivateBlacksmith() {	
	DotaHUD.WindowOpen("blacksmith");
}

function close() {
    DotaHUD.WindowClose("blacksmith");
}

function DeactivateBlacksmith() {
    close();
}

// --- Вспомогательные функции ---
const getSuffix = (type) => ATTR_CONFIG.percent.includes(type) ? '%' : '';
const getPrecision = (type) => ATTR_CONFIG.integer.includes(type) ? 0 : 1;

function clearAllPanels() {
    [UI.target, UI.result, UI.desc].forEach(p => p.RemoveAndDeleteChildren());
    
    // Снимаем визуальную блокировку со всех панелей в инвентаре
    LOCKED_SLOTS.forEach(slotIdx => {
        const p = UI.inv_container.FindChildTraverse(`inventory_slot_${slotIdx}`);
        if (p) p.RemoveClass("SlotLocked");
    });
    
    LOCKED_SLOTS = []; 
    MERGE_ITEMS_DATA = { 1: null, 2: null, 3: null };
}



// ------------------------------------------ Инициализация слотов и отрисовка ------------------------------------------

function UpdateInventorySlots()
{
    UI.inv_container.RemoveAndDeleteChildren();
    for (let i = 1; i <= 30; i++)
    {
        let inventory_slot = $.CreatePanel("Panel", $("#BlacksmithInventorySlots"), "inventory_slot_"+i)
		inventory_slot.AddClass("inventory_slot")
		inventory_slot.slot_count = i
    }
}

function UpdateInventoryUI(tabData) {
    HERO_INVENTORY = tabData.hero_inventory;
    UPGRADE_BOOST = tabData.upgrade_boost;
    UI.dust.text = tabData.dust

    const resultItem = Object.values(tabData.hero_inventory).find(item => item && item.id === tabData.result_id);
    if (resultItem) {

    }

    let allSlots = $("#BlacksmithInventorySlots").Children();
    allSlots.forEach(slot => {
        // Удаляем старую панель предмета, если она была
        if (slot.item_in_slot) {
            slot.item_in_slot.DeleteAsync(0);
            slot.item_in_slot = null;
        }
        // Сбрасываем события и классы
        slot.RemoveClass("SlotLocked");
        slot.ClearPanelEvent("onmouseactivate");
        slot.ClearPanelEvent("onmouseover");
        slot.ClearPanelEvent("onmouseout");
    });
	
    for (let i = 0; i <= Object.keys(HERO_INVENTORY).length; i++)
    {
        if (Object.keys(HERO_INVENTORY)[i] != null)
        {
            let slotIdx = Object.keys(HERO_INVENTORY)[i]
            let item = HERO_INVENTORY[slotIdx]
            if (item != null)
            {
   
                let slotPanel = $("#BlacksmithInventorySlots").FindChildTraverse("inventory_slot_"+slotIdx)

                if (LOCKED_SLOTS.indexOf(slotIdx) !== -1) {
                    slotPanel.AddClass("SlotLocked");
                }

           
                let item_panel = $.CreatePanel("Panel", slotPanel, "")
                item_panel.AddClass("item_panel")
                item_panel.hittest = false;

                if (resultItem == item){
                    AddParticleEffect(item_panel, 4)
                } 

                const isJewel = item.set_type === 'jewell';
                const imgPath = isJewel 
                    ? `file://{resources}/images/sets/${item.item_type}.png`
                    : `file://{resources}/images/sets/${item.set_type}/${item.item_type}.png`;
                item_panel.AddClass("equipped_item_shadow_level_" + item.level)
                item_panel.style.backgroundImage = `url('${imgPath}')`;
                item_panel.style.backgroundSize = isJewel ? "100%" : "95%";

                item_panel.hittest = false
				
                if (!isJewel) {

                    item_panel.AddClass(`equipped_item_shadow_level_${item.level}`);
                    slotPanel.SetPanelEvent("onmouseactivate", () => draw(slotIdx));

                    let item_icon = item.set_type + "/" + item.item_type

                    item_panel.item_icon = item_icon
                    slotPanel.item_in_slot = item_panel
                    
                    slotPanel.is_slot = true
                    slotPanel.hittestchildren = false
                    slotPanel.slot_count = slotIdx
                    slotPanel.is_inventory_slot = true
                    slotPanel.SetDraggable(true)

                    $.RegisterEventHandler( 'DragStart', slotPanel, OnDragStart );
                    $.RegisterEventHandler( 'DragEnd', slotPanel, OnDragEnd );
                    $.RegisterEventHandler( 'DragEnter', slotPanel, OnDragEnter );
                    $.RegisterEventHandler( 'DragDrop', slotPanel, OnDragDrop );
                    $.RegisterEventHandler( 'DragLeave', slotPanel, OnDragLeave );
                }

                slotPanel.SetPanelEvent("onmouseover", () => {
                    const params = `&item_data=${JSON.stringify(item)}`;
                    $.DispatchEvent("UIShowCustomLayoutParametersTooltip", slotPanel, "SetCreepTooltip", "file://{resources}/layout/custom_game/custom_tooltip/custom_tooltip.xml", params);
                });
                slotPanel.SetPanelEvent("onmouseout", () => $.DispatchEvent("UIHideCustomLayoutTooltip", slotPanel, "SetCreepTooltip"));
            }
        }
    }
}

function draw(slotIndex) {
    const data = HERO_INVENTORY[slotIndex];
    if (!data || current_tab === 'reforge') return;

    UI.desc_text.AddClass("hidden");
    clearAllPanels();

    renderItemPanel(UI.target, data);

    switch (current_tab) {
        case 'upgrade':
            if (data.level < 11) {
                renderItemPanel(UI.result, data, data.level + 1);
                setupUpgradeControls(data, slotIndex);
            }
            break;

        case 'enchant':
            renderItemPanel(UI.result, data);
            setupEnchantControls(data, slotIndex);
            break;
    }
}

// ------------------------------------------ Универсальный рендер карточки предмета ------------------------------------------

function renderItemPanel(container, data, levelOverride, setTypeOverride) {
    if (!data) return;

    const level = levelOverride || data.level;
    const setType = setTypeOverride || data.set_type;
    const setNumber = setTypeOverride ? (data.set_number + 1) : data.set_number;

    const panel = $.CreatePanel("Panel", container, '');
    panel.BLoadLayoutSnippet("blacksmith_up_snippet");

    const nameStr = $.Localize(`#${setType}_${data.item_type}`) + " " + level;
    const imgPath = `file://{resources}/images/sets/${setType}/${data.item_type}.png`;
    
    panel.FindChildTraverse('blacksmith_up_panel_name').text = nameStr;
    panel.FindChildTraverse('blacksmith_up_panel_image').SetImage(imgPath);
    
    // Базовый атрибут
    const baseVal = (DECRIPTION_ATTRS[data.item_type] || 0) * level * setNumber;
    panel.FindChildTraverse('blacksmith_up_panel_base').text = $.Localize(`#${data.item_type}_description`) + baseVal + getSuffix(data.item_type);

    // Бонусные атрибуты
    const bonusContainer = panel.FindChildTraverse('blacksmith_up_panel_bonus');
    if (data.bonus_attribute) {
        Object.keys(data.bonus_attribute).forEach(attrKey => {
            const val = (DECRIPTION_ATTRS[attrKey] * setNumber + (BOOST_ATTRS[attrKey]?.[setNumber] || 0) * (level - 1)).toFixed(getPrecision(attrKey));
            const label = $.CreatePanel("Label", bonusContainer, "");
            label.AddClass('bonus_label');
            label.text = `${$.Localize("#" + attrKey + "_description")} ${val}${getSuffix(attrKey)}`;
            $.CreatePanel("Panel", bonusContainer, "SourceValueLine");
        });
    }
    return panel;
}

// ------------------------------------------ Основная логика вкладок ------------------------------------------ 

let current_tab = 'upgrade';

function SwitchBlacksmithTab(tab) {
    current_tab = tab;
    ["Upgrade", "Enchant", "Reforge"].forEach(t => $(`#Tab${t}Btn`).SetHasClass("Active", tab === t.toLowerCase()));
    clearAllPanels();
    UI.desc_text.RemoveClass("hidden");

    const isReforge = (tab === 'reforge');

    UI.target.visible = !isReforge;
    UI.result.visible = !isReforge;
    UI.desc.visible = !isReforge;
    
    const mergeAltar = $("#blacksmith_merge_altar");
    mergeAltar.visible = isReforge;

    if (isReforge) {
        UI.desc_text.AddClass("hidden");
        LOCKED_SLOTS = []; 
        MERGE_ITEMS_DATA = { 1: null, 2: null, 3: null };
        initMergeAltar();
    }
}

// ------------------------------------------ MERGE LOGIC ------------------------------------------ 

function initMergeAltar() {
    $.Msg("initMergeAltar")
    const altar = $("#blacksmith_merge_altar");
    altar.RemoveAndDeleteChildren();
    altar.BLoadLayoutSnippet("blacksmith_merge_desc");

    const executeBtn = altar.FindChildTraverse("MergeExecuteButton");
    executeBtn.enabled = false;
    executeBtn.ClearPanelEvent("onmouseactivate");

    LOADING_PANEL_MERGE = altar.FindChildTraverse('blacksmith_merge_panel_desc_loading');
    LOADING_PANEL_MERGE.visible = false;
    
    for (let i = 1; i <= 3; i++) {
        const slot = altar.FindChildTraverse("MergeSlot_" + i);
        slot.is_merge_target = true;
        slot.merge_index = i;
        $.RegisterEventHandler( 'DragDrop', slot, OnDragDrop );
    }
}

function OnMergeUpdate(tab) {
    LOCKED_SLOTS = []; 
    MERGE_ITEMS_DATA = { 1: null, 2: null, 3: null };

    $.Msg(tab.result_id)

    const resultItem = Object.values(tab.hero_inventory).find(item => item && item.id === tab.result_id);

    UpdateInventoryUI(tab);

    const altar = $("#blacksmith_merge_altar");
    const executeBtn = altar.FindChildTraverse("MergeExecuteButton");
    executeBtn.enabled = false;
    executeBtn.ClearPanelEvent("onmouseactivate");
    executeBtn.visible = true;
    LOADING_PANEL_MERGE.visible = false;

    for (let i = 1; i <= 3; i++) {
        const slot = altar.FindChildTraverse("MergeSlot_" + i);
        slot.RemoveAndDeleteChildren();
    }

    if (tab.status === 'success') {
        const fx = $.CreatePanel("DOTAParticleScenePanel", $("#blacksmith_select_panel"), "", {
            particleName: "particles/ui/ui_generic_treasure_impact.vpcf",
            startActive: "true"
        });
        fx.style.width = "100%";
        fx.style.height = "100%";
        fx.DeleteAsync(3);
        Game.EmitSound("ui.treasure_01");
        UI.error.style.color = "#14b814";
  
        const resultSlot = altar.FindChildTraverse("MergeResultPreview");
        resultSlot.RemoveAndDeleteChildren();
        const img = $.CreatePanel("Image", resultSlot, "PreviewImage");
        img.SetImage(`file://{resources}/images/sets/${resultItem.set_type}/${resultItem.item_type}.png`);
        img.style.washColor = "white";


        resultSlot.SetPanelEvent("onmouseover", () => {
        const params = `&item_data=${JSON.stringify(resultItem)}`;
            $.DispatchEvent("UIShowCustomLayoutParametersTooltip", resultSlot, "SetCreepTooltip", "file://{resources}/layout/custom_game/custom_tooltip/custom_tooltip.xml", params);
        });

        resultSlot.SetPanelEvent("onmouseout", () => $.DispatchEvent("UIHideCustomLayoutTooltip", resultSlot, "SetCreepTooltip"));
    }
}

function loadingMergeAltar() {
    const altar = $("#blacksmith_merge_altar");

    const executeBtn = altar.FindChildTraverse("MergeExecuteButton");
    executeBtn.visible = false;
    LOADING_PANEL_MERGE.visible = true;

    for (let i = 1; i <= 3; i++) {
        const slot = altar.FindChildTraverse("MergeSlot_" + i);
        AddParticleEffect(slot, 0)
    }
}

function AddParticleEffect(slot, time){
    const fx = $.CreatePanel("DOTAParticleScenePanel", slot, "", {
        particleName: "particles/ui/hud/autocasting_square.vpcf",
        startActive: "true",
        cameraOrigin: "0 0 90",
        lookAt: "0 0 0",
        fov: "60"
    });
    fx.AddClass('particle')
    fx.DeleteAsync(time);
}


function updateMergeResult() {
    const altar = $("#blacksmith_merge_altar");
    const resultSlot = altar.FindChildTraverse("MergeResultPreview");
    const executeBtn = altar.FindChildTraverse("MergeExecuteButton");
    const priceLabelSoul = altar.FindChildTraverse("MergePriceLabel"); // Находим лейбл цены
    const priceLabelDust = altar.FindChildTraverse("MergePriceLabelDust"); // Находим лейбл цены
    
    // 1. Полная очистка
    resultSlot.RemoveAndDeleteChildren();
    executeBtn.enabled = false;
    if (priceLabelSoul) priceLabelSoul.text = "= 0"; // Сбрасываем цену
    if (priceLabelDust) priceLabelDust.text = "= 0"; // Сбрасываем цену
    
    executeBtn.ClearPanelEvent("onmouseactivate");

    const m1 = MERGE_ITEMS_DATA[1] ? MERGE_ITEMS_DATA[1].data : null;
    const m2 = MERGE_ITEMS_DATA[2] ? MERGE_ITEMS_DATA[2].data : null;
    const m3 = MERGE_ITEMS_DATA[3] ? MERGE_ITEMS_DATA[3].data : null;

    if (m1 && m2 && m3) {
        if (m1.set_type === m2.set_type && m2.set_type === m3.set_type && m1.level === m2.level) {
            
            const parts = m1.set_type.split('_'); 
            const currentTier = parseInt(parts[1]);

            if (currentTier >= 6) return; 

            const price_soul = 5 + 5 * currentTier;
            if (priceLabelSoul) {
                priceLabelSoul.text = "= " + price_soul;
            }

            const price_dust = 20 + 20 * currentTier;
            if (priceLabelDust) {
                priceLabelDust.text = "= " + price_dust;
            }

            const nextTier = currentTier + 1;
            const nextSet = `${parts[0]}_${nextTier}`;
            
            let isSameType = (m1.item_type === m2.item_type && m2.item_type === m3.item_type);
            let resultItemType = isSameType ? m1.item_type : "random";

            // Визуализация
            const img = $.CreatePanel("Image", resultSlot, "PreviewImage");
            if (resultItemType === "random") {
                img.SetImage("s2r://panorama/images/status_icons/fow_viewer_question_psd.vtex");
                img.style.washColor = "#e5d1a0"; 
                const questionLabel = $.CreatePanel("Label", resultSlot, "");
                questionLabel.text = "?";
                questionLabel.AddClass("MergeQuestionMark"); // Лучше вынести стили в CSS
            } else {
                img.SetImage(`file://{resources}/images/sets/${nextSet}/${resultItemType}.png`);
                img.style.washColor = "white";
            }
            
            img.style.width = "100%"; 
            img.style.height = "100%";


            const soulJewel = Object.values(HERO_INVENTORY).find(item => 
                item && item.set_type === 'jewell' && item.item_type === 'soul'
            );

            if (!soulJewel || soulJewel.level < price_soul){
                priceLabelSoul.style.color ='red'
                return;
            }

            if (Number(UI.dust.text) < price_dust) {
                priceLabelDust.style.color ='red'
                return;
            }

            priceLabelDust.style.color = '#e5e0c5'
            priceLabelSoul.style.color = '#e5e0c5'

            executeBtn.enabled = true;
            executeBtn.SetPanelEvent("onmouseactivate", () => {
                loadingMergeAltar();
                GameEvents.SendCustomGameEventToServer("try_merge_items", { 
                    ids: [
                        MERGE_ITEMS_DATA[1].data.id || MERGE_ITEMS_DATA[1].data.item_id,
                        MERGE_ITEMS_DATA[2].data.id || MERGE_ITEMS_DATA[2].data.item_id,
                        MERGE_ITEMS_DATA[3].data.id || MERGE_ITEMS_DATA[3].data.item_id
                    ],
                    result_type: resultItemType,
                });                
                Game.EmitSound("ui_generic_button_click");
            });
        }
    }
}

// ------------------------------------------ UPGRADE LOGIC ------------------------------------------ 

function setupUpgradeControls(data, slot) {
    const ctrl = $.CreatePanel("Panel", UI.desc, 'up_ctrl');
    ctrl.BLoadLayoutSnippet("blacksmith_up_desc");

    let chance = (100 - (data.level - 1) * 10);
    let chanceHtml = `${$.Localize("#up_chance")} ${chance}%`;

    if (UPGRADE_BOOST > 0) chanceHtml += `<font color='#14b814'> + ${UPGRADE_BOOST}%</font>`;

    ctrl.FindChildTraverse('blacksmith_up_panel_desc_label_chance').text = chanceHtml;
    ctrl.FindChildTraverse('blacksmith_up_panel_price_label').text = ` = ${data.level}`;
    ctrl.FindChildTraverse('blacksmith_up_panel_price_dust_label').text = ` = ${data.set_number * 10}`;
    
    const gemType = data.level >= 8 ? 'soul' : 'bless';
    ctrl.FindChildTraverse('blacksmith_up_panel_price_image').SetImage(`file://{resources}/images/sets/${gemType}.png`);

    LOADING_PANEL = ctrl.FindChildTraverse('blacksmith_up_panel_desc_loading');
    LOADING_PANEL.visible = false;

    const btn = ctrl.FindChildTraverse('blacksmith_up_panel_desc_button');
    btn.SetPanelEvent("onmouseactivate", () => {
        LOADING_PANEL.visible = true;
        btn.visible = false;
        GameEvents.SendCustomGameEventToServer("try_items_upgrade", { item_id: data.id || data.item_id, slot_number: parseInt(slot) });
    });
}

let error_hide_thread = null;

function OnBlacksmithUpdate(tab) {
    UpdateInventoryUI(tab);

    if(tab.status){
    
        UI.error.text = $.Localize("#" + tab.status);
        UI.error.visible = true;

        if (error_hide_thread !== null) {
            $.CancelScheduled(error_hide_thread);
            error_hide_thread = null;
        }

        error_hide_thread = $.Schedule(2.0, function() {
            if (UI.error) {
                UI.error.visible = false;
            }
            error_hide_thread = null;
        });
    }

    draw(tab.item_number);

    if (tab.status === 'success') {
        const fx = $.CreatePanel("DOTAParticleScenePanel", $("#blacksmith_select_panel"), "", {
            particleName: "particles/ui/ui_generic_treasure_impact.vpcf",
            startActive: "true"
        });
        fx.DeleteAsync(3);
        Game.EmitSound("ui.treasure_01");
        UI.error.style.color = "#14b814";
    } else if (tab.status === 'fail') {
        Game.EmitSound("high_five.fail");
        UI.error.style.color = "#ff4d4d";

    }
}

// ------------------------------------------ ENCHANT LOGIC ------------------------------------------ 

function OnEnchantUpdate(tab) {
    UpdateInventoryUI(tab);

}

function setupEnchantControls(data, slot) {
    const ctrl = $.CreatePanel("Panel", UI.desc, 'enchant_ctrl');
    ctrl.BLoadLayoutSnippet("blacksmith_Enchant_desc");

    const count = data.bonus_attribute ? Object.keys(data.bonus_attribute).length : 0;
    const max = 5;
    const price = (data.set_number * 5) * (count + 1);

    ctrl.FindChildTraverse("Enchant_count").text = $.Localize("#bonuses_count") + count +"/"+ max;
    ctrl.FindChildTraverse("Enchant_price_row_text").text = ` = ${price}`;

    LOADING_PANEL_ENCHANT = ctrl.FindChildTraverse('blacksmith_enchant_panel_desc_loading');
    LOADING_PANEL_ENCHANT.visible = false;

    const btn = ctrl.FindChildTraverse("Enchant_execute_button");
    const maxLabel = ctrl.FindChildTraverse("Enchant_max_label");
    maxLabel.visible = false;
    if (count >= max) {
        btn.visible = false;
        maxLabel.visible = true;
    } else {
        btn.SetPanelEvent("onmouseactivate", () => {
            LOADING_PANEL_ENCHANT.visible = true;
            btn.visible = false;
            GameEvents.SendCustomGameEventToServer("try_enchant_items", { 
                item_id: data.id || data.item_id, 
                slot_number: parseInt(slot), 
            });
            Game.EmitSound("ui_generic_button_click");
        });
    }
}

// ------------------------------------------ DRAG DROP LOGIC ------------------------------------------ 

function onAbilityMouseOut(panel) {
	$.DispatchEvent("UIHideCustomLayoutTooltip", panel, "SetCreepTooltip");
}

function OnDragStart(panelId, dragCallbacks) {
    // ПРОВЕРКА БЛОКИРОВКИ
    if (LOCKED_SLOTS.indexOf(panelId.slot_count) !== -1) {
        return false; // Не даем начать перетаскивание
    }

    onAbilityMouseOut(panelId);
    if (panelId.item_in_slot == null) return;

	var displayPanel = $.CreatePanel( "Panel", $.GetContextPanel(), "dragImage" );
    displayPanel.AddClass("dragImage")

    displayPanel.style.backgroundImage = "url('file://{resources}/images/sets/" + panelId.item_in_slot.item_icon +".png')";
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

function OnDragEnter( panelId, draggedPanel ){	return true;}
function OnDragLeave( panelId, draggedPanel ){	return true;}

function OnDragDrop(panelId, draggedPanel) {
    panelId.RemoveClass("drag_hover");

    const old_inventory_slot = draggedPanel.original_slot;
    const slot_index = panelId.merge_index;
    
    if (!panelId.BHasClass("MergeSlotTarget")) {
        return false;
    }

    // Это те самые данные предмета, который мы держим в руках
    const item_data = HERO_INVENTORY[old_inventory_slot.slot_count];

    if (!item_data || item_data.set_type === 'jewell') return false;

    // --- 1. ОЧИСТКА ---
    const oldImg = panelId.FindChildTraverse("ItemImage");
    if (oldImg) { oldImg.DeleteAsync(0); }
    panelId.RemoveAndDeleteChildren();

    // --- 2. РАЗБЛОКИРОВКА СТАРОГО ---
    const existing_entry = MERGE_ITEMS_DATA[slot_index];
    if (existing_entry && existing_entry.original_slot_idx !== undefined) {
        const old_idx = existing_entry.original_slot_idx;
        LOCKED_SLOTS = LOCKED_SLOTS.filter(idx => idx !== old_idx);
        
        const allSlots = UI.inv_container.Children();
        allSlots.forEach(slot => {
            if (slot.slot_count == old_idx) {
                slot.RemoveClass("SlotLocked");
            }
        });
    }

    // --- 3. БЛОКИРОВКА НОВОГО ---
    LOCKED_SLOTS.push(old_inventory_slot.slot_count);
    old_inventory_slot.AddClass("SlotLocked");

    // --- 4. КАРТИНКА ---
    const img = $.CreatePanel("Image", panelId, "ItemImage"); 
    img.SetImage(`file://{resources}/images/sets/${item_data.set_type}/${item_data.item_type}.png`);
    img.style.width = "90%"; img.style.height = "90%"; img.style.align = "center center";
    img.hittest = false;

    // --- ИСПРАВЛЕННЫЙ ТУЛТИП ---
    // Используем item_data (тот, что положили), а не HERO_INVENTORY[slot_index]
    panelId.SetPanelEvent("onmouseover", () => {
        const params = `&item_data=${JSON.stringify(item_data)}`;
        $.DispatchEvent("UIShowCustomLayoutParametersTooltip", panelId, "SetCreepTooltip", "file://{resources}/layout/custom_game/custom_tooltip/custom_tooltip.xml", params);
    });

    panelId.SetPanelEvent("onmouseout", () => $.DispatchEvent("UIHideCustomLayoutTooltip", panelId, "SetCreepTooltip"));

    // --- 5. СОХРАНЕНИЕ ---
    MERGE_ITEMS_DATA[slot_index] = {
        data: item_data,
        original_slot_idx: old_inventory_slot.slot_count 
    };

    updateMergeResult();
    Game.EmitSound("ui_add_item_to_slot");
    
    return true;
}


// ------------------------------------------ Инициализация ------------------------------------------ 

(function() {
    GameEvents.Subscribe("blacksmith_update", OnBlacksmithUpdate);
    GameEvents.Subscribe("merge_update", OnMergeUpdate);
    GameEvents.Subscribe("enchant_update", OnEnchantUpdate);
    GameEvents.Subscribe("blacksmith_init", (tab) => {
        clearAllPanels();
        UpdateInventorySlots();
        SwitchBlacksmithTab(tab);
        UI.desc_text.RemoveClass("hidden");
        DOTA_HUD.WindowCloseAnyway("inventory_hud");
        UpdateInventoryUI(tab);
        UI.main.visible = true;
    });
    GameEvents.Subscribe("ActivateBlacksmith", () => DOTA_HUD.WindowOpen("blacksmith"));
    GameEvents.Subscribe("DeactivateBlacksmith", () => DOTA_HUD.WindowClose("blacksmith"));
    GameUI.CustomUIConfig.CloseOrders = () => DOTA_HUD.WindowClose("blacksmith");
})();