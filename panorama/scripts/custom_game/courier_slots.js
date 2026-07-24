--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const LPID = Players.GetLocalPlayer();
const DotaHUDHUD = GetDotaHud();
const Inventory = DotaHUDHUD.FindChildTraverse("inventory");
const RightItems = DotaHUDHUD.FindChildTraverse("inventory_composition_layer_container");
const StashDota = DotaHUDHUD.FindChildTraverse("stash_row");

const BonusStashPanel = $("#BonusStashPanel")
const BonusStashButton = $("#BonusStashButton")

const RESERVED_BOOK_SLOTS = {
    "SLOT_0": "item_relearn_torn_page_lua",
    "SLOT_1": "item_relearn_book_lua",
}

let Handlers = {}

let bStarted = false
// const QuickbuyRow = Quickbuy.FindChildTraverse("QuickBuyRows");

// $.GetContextPanel().SetParent(QuickbuyRow)

// $.RegisterEventHandler( 'DragDrop', Quickbuy, function(a, draggedPanel ){
//     if(a && a.id && a.id.match("StickySlot")){
//         return false
//     }
//     return true
// })

// for (let i = 0; i < QuickbuyRow.GetChildCount(); i++) {
//     const Child = QuickbuyRow.GetChild(i)
//     if(Child && i != 0 && !Child.BHasClass("QuickBuyHUD")){
//         Child.style.visibility = "collapse"
//     }
// }

const stash = $("#stash")

// [NP-24] Пинг предмета бонусного тайника. У draggable-слота (DOTAAbilityPanel, hittest=false)
// onactivate не срабатывает (драг съедает клик), поэтому ловим Alt+ЛКМ поллингом мыши по
// координатам слота — тем же приёмом, что Updater в hud.Js для магазина/квикбая.
let StashItemEnts = {}   // i -> entity предмета в слоте (заполняется в UpdateSlots)
let _stashMDown = false
function StashPingPoll(){
    $.Schedule(0.0, StashPingPoll)
    if(IsDotaAltPressed() && GameUI.IsMouseDown(0)){
        if(_stashMDown) return
        _stashMDown = true
        try {
            let cur = GameUI.GetCursorPosition()
            let cx = ToAbsPixelValue(cur[0]), cy = ToAbsPixelValue(cur[1])
            for(let i in StashItemEnts){
                if(StashItemEnts[i] == undefined) continue
                let slot = stash.FindChildTraverse("SLOT_"+i)
                if(!slot || !slot.IsValid() || !slot.visible) continue
                let b = GetAbsPanelBounds(slot)
                if(cx>=b.minX && cx<=b.maxX && cy>=b.minY && cy<=b.maxY){
                    let cfg = GameUI.CustomUIConfig()
                    if(cfg && cfg.PingAbilityToChat){ cfg.PingAbilityToChat(StashItemEnts[i], Players.GetLocalPlayerPortraitUnit()) }
                    break
                }
            }
        } catch(e){}
    } else if(!GameUI.IsMouseDown(0)){
        _stashMDown = false
    }
}
StashPingPoll()

$.GetContextPanel().SetParent(FindDotaHudElement("HUDElements"));

SubscribeAndFirePlayerTableByKey(`player_${LPID}`, `bonus_stash_items`, function(v){
    UpdateSlots(v)
})

// Рендер количества чарджей у предметов в кастомном тайнике. Стандартный
// DOTAAbilityPanel не показывает чарджи, если entity не в инвентаре героя.
// Источник чарджей: server-side ItemInfo.charges (Lua UpdatePlayerNetTable).
// Фолбэк: Items.GetCurrentCharges если сервер не прислал.
// Скрываем нативный charges-label внутри DOTAAbilityPanel — иначе после
// возврата предмета в зарезервированный слот видны ДВА числа (наше +
// нативное). Точные имена найдены через STASH_TREE-диагностику:
// ButtonSize > CostContainer > CostChildren > ItemChargesContainer (Panel)
//   > ItemChargesBorder + ItemCharges (Label)
// Также рядом лежит ItemAltCharges (Label) для альт-чарджей.
function HideNativeCharges(panel){
    if(!panel || !panel.IsValid()) return
    const names = ["ItemChargesContainer", "ItemCharges", "ItemChargesBorder", "ItemAltCharges"]
    for (const n of names) {
        const el = panel.FindChildTraverse(n)
        if(el) el.style.visibility = "collapse"
    }
}

function UpdateStashChargesLabel(panel, serverCharges, itemEntIndex){
    try {
        if(!panel || !panel.IsValid()) return
        HideNativeCharges(panel)
        // Повторно скрываем после тика — DOTAAbilityPanel пересоздаёт нативных
        // детей при смене overrideentityindex, и они могут появиться позже.
        $.Schedule(0.05, function(){ HideNativeCharges(panel) })
        $.Schedule(0.2,  function(){ HideNativeCharges(panel) })

        let wrap = panel.GetParent()
        if(!wrap || !wrap.IsValid()) return
        let label = wrap.FindChild("StashChargesLabel")
        if(!label){
            label = $.CreatePanel("Label", wrap, "StashChargesLabel")
            label.AddClass("StashChargesLabel")
            label.hittest = false
        }
        let charges = 0
        if(typeof serverCharges === "number"){
            charges = serverCharges
        } else if(itemEntIndex != null && itemEntIndex >= 0){
            charges = Items.GetCurrentCharges(itemEntIndex)
        }
        if(charges > 1){
            label.text = String(charges)
            label.style.visibility = "visible"
        } else {
            label.style.visibility = "collapse"
        }
    } catch(e){ $.Msg("[StashCharges err] ", String(e)) }
}

function CleanPanel(panel){
    if(!panel || !panel.IsValid()){return}

    panel.SetPanelEvent("onmouseup", ()=>{})
    panel.SetPanelEvent("onactivate", ()=>{})
    panel.SetPanelEvent("onmousedown", ()=>{})

    for (let i = 0; i < panel.GetChildCount(); i++) {
        const Child = panel.GetChild(i);
        if(Child){
            CleanPanel(Child)
        }
    }
}

function UpdateSlots(v){
    for (let i = 0; i < 12; i++) {
        let p = GetOrCreateSlot(i)

        p.FindChildTraverse("HotkeyContainer").style.visibility = "collapse";

        CleanPanel(p)

        let slotId = `SLOT_${i}`
        if(RESERVED_BOOK_SLOTS[slotId]){
            let hasItem = !!v[slotId]

            // Иконка-подложка книги когда слот пуст
            let reservedIcon = p.FindChildTraverse("ReservedBookIcon")
            if(!reservedIcon){
                reservedIcon = $.CreatePanel("DOTAItemImage", p, "ReservedBookIcon")
                reservedIcon.itemname = RESERVED_BOOK_SLOTS[slotId]
                reservedIcon.style.width = "100%"
                reservedIcon.style.height = "100%"
                reservedIcon.style.opacity = "0.25"
                reservedIcon.style.saturation = "0"
                reservedIcon.hittest = false
                reservedIcon.style.ignoreParentFlow = "true"
            }
            reservedIcon.style.visibility = hasItem ? "collapse" : "visible"

            p.style.boxShadow = "inset rgba(116, 80, 208, 0.3) 0px 0px 6px 0px"
        }

        let ItemInfo = v[slotId]

        StashItemEnts[i] = undefined   // [NP-24] сбрасываем; заполним ниже, если в слоте есть предмет

        if(ItemInfo){
            // p.itemname = ItemInfo.item_name

            if(!ItemIsNeutral(ItemInfo.item_name)){
                p.SetPanelEvent("onmouseover", () =>{
                })

                p.SetPanelEvent("onmouseout", () =>{
                })

                let image = p.FindChildTraverse("ItemImage")
                if(image){
                    image.SetPanelEvent("onmouseover", () =>{
                    })

                    image.SetPanelEvent("onmouseout", () =>{
                    })
                }
                $.Schedule(0.1, function(){
                    p.SetPanelEvent("onmouseover", () =>{
                    })

                    p.SetPanelEvent("onmouseout", () =>{
                    })

                    let image = p.FindChildTraverse("ItemImage")
                    if(image){
                        image.SetPanelEvent("onmouseover", () =>{
                        })

                        image.SetPanelEvent("onmouseout", () =>{
                        })
                    }
                })
            }

            if(ItemInfo.item != undefined){
                p.contextEntityIndex = Players.GetLocalPlayerPortraitUnit()
                p.overrideentityindex = ItemInfo.item

                // [NP-24] entity предмета слота — для пинга через поллинг мыши (onactivate у
                // draggable-слота не срабатывает, поэтому ловим Alt+ЛКМ по координатам, см. ниже).
                StashItemEnts[i] = ItemInfo.item
            }

            // Чарджи (количество) у стакаемых предметов в кастомном тайнике не
            // рендерятся стандартно — entity вне инвентаря героя. Рендерим вручную
            // через Label. Источник: server-side ItemInfo.charges (обновляется в
            // Lua UpdatePlayerNetTable). Фолбэк на Items.GetCurrentCharges если
            // сервер не прислал (старая запись или гонка).
            UpdateStashChargesLabel(p, ItemInfo.charges, ItemInfo.item)

            // p.SetPanelEvent("onmouseover", function(){
            //     $.Msg("fffff")
            //     $.DispatchEvent("DOTAShowAbilityShopItemTooltip", p, ItemInfo.item_name, 0, 0)
            // });
            // p.SetPanelEvent("onmouseout", function(){
            //     $.DispatchEvent("DOTAHideAbilityTooltip", p)
            // });

            $.Schedule(0.01, function(){
                if(p && p.IsValid()){
                    let image = p.FindChildTraverse("ItemImage")
                    if(image){
                        image.contextEntityIndex = ItemInfo.item
                    }

                    if(GameUI.CustomUIConfig().UpdateNeutralTooltip && ItemIsNeutral(ItemInfo.item_name)){
                        GameUI.CustomUIConfig().UpdateNeutralTooltip(p)
                    }
                }
            })

            $.RegisterEventHandler( 'DragStart', p, function(a, dragCallbacks ){
                $.DispatchEvent( "DOTAHideAbilityTooltip", p );

                p.AddClass("dragging_from")
                let panel = $.CreatePanel( "DOTAItemImage", $.GetContextPanel(), "", {class:"DragImage", itemname: ItemInfo.item_name});
                panel.contextEntityIndex = ItemInfo.item
                panel.is_from_custom = true

                dragCallbacks.displayPanel = panel;
                dragCallbacks.offsetX = 0;
                dragCallbacks.offsetY = 0;
                return true
            } );

            $.RegisterEventHandler( 'DragEnd', p, function(a, draggedPanel ){
                p.RemoveClass("dragging_from")
                SafeDeleteAsync(draggedPanel)
                return true
            } );

            // Реальный click-target внутри DOTAAbilityPanel зависит от состояния:
            // при первом показе предмета клик ловит ItemImage, после пересоздания
            // (продажа → новый предмет) — overlay-панель FixCast. Вешаем handler
            // на обе + на родительскую p как fallback. Отложенные регистрации —
            // для случаев, когда Dota пересоздаёт внутренних детей не сразу.
            let rclickHandler = function(){
                if(!GameUI.IsMouseDown( 1 )) return;

                $.DispatchEvent( "DOTAHideAbilityTooltip", p );

                let bIsNeutral = ItemIsNeutral(ItemInfo.item_name)
                // Непродаваемые предметы (ItemSellable 0, напр. книги/страницы-награды)
                // не должны показывать пункт «Продать» — иначе кнопка есть, а сервер
                // продажу отклоняет (молча). Доверяем реальному флагу предмета.
                let bSellable = !bIsNeutral && Items.IsSellable( ItemInfo.item );
                let bShowInShop = Items.IsPurchasable( ItemInfo.item );

                if ( !bSellable && !bShowInShop && !bIsNeutral) return;

                let contextMenu = $.CreatePanel( "ContextMenuScript", $.GetContextPanel(), "" );
                contextMenu.AddClass( "ContextMenu_NoArrow" );
                contextMenu.AddClass( "ContextMenu_NoBorder" );
                contextMenu.GetContentsPanel().Item = ItemInfo.item;
                contextMenu.GetContentsPanel().SetHasClass( "bSellable", bSellable );
                contextMenu.GetContentsPanel().SetHasClass( "bShowInShop", bShowInShop );
                contextMenu.GetContentsPanel().SetHasClass( "bIsNeutral", bIsNeutral );
                contextMenu.GetContentsPanel().BLoadLayout( "file://{resources}/layout/custom_game/custom_item_context_menu.xml", false, false );
            }

            let registerRClickHandler = function(){
                if(!p || !p.IsValid()) return;
                p.SetPanelEvent("onmousedown", rclickHandler);
                let image = p.FindChildTraverse("ItemImage")
                if(image) image.SetPanelEvent("onmousedown", rclickHandler);
                let fixCast = p.FindChildTraverse("FixCast")
                if(fixCast) fixCast.SetPanelEvent("onmousedown", rclickHandler);
            }
            registerRClickHandler()
            $.Schedule(0.02, registerRClickHandler)
            $.Schedule(0.15, registerRClickHandler)
        }else{
            // Сбрасываем overrideentityindex и contextEntityIndex в -1 — иначе
            // остаются "отпечатки" предыдущего предмета (мана-стоимость, чарджи).
            // Для пустых слотов click-pipeline не критичен, так что прежний
            // комментарий про "не трогаем" больше не актуален.
            p.overrideentityindex = -1
            p.contextEntityIndex = -1

            // Скрыть наш кастомный charges-label
            UpdateStashChargesLabel(p, null, null)

            $.Schedule(0.01, function(){
                if(p && p.IsValid()){
                    p.overrideentityindex = -1
                    p.contextEntityIndex = -1
                    let image = p.FindChildTraverse("ItemImage")
                    if(image){
                        image.contextEntityIndex = -1
                    }
                }
            })

            $.RegisterEventHandler( 'DragStart', p, function(a, dragCallbacks ){
                return true
            } );

            $.RegisterEventHandler( 'DragEnd', p, function(a, draggedPanel ){
                return true
            } );

            p.SetPanelEvent("onmouseover", () =>{
            })

            p.SetPanelEvent("onmouseout", () =>{
            })

            let image = p.FindChildTraverse("ItemImage")
            if(image){
                image.SetPanelEvent("onmouseover", () =>{
                })

                image.SetPanelEvent("onmouseout", () =>{
                })
            }
        }
        
        $.RegisterEventHandler( 'DragDrop', p, function(a, draggedPanel ){
            let slotId = `SLOT_${i}`
            // Блокируем перетаскивание чужих предметов в зарезервированные слоты
            if(RESERVED_BOOK_SLOTS[slotId]){
                let abilityIndex = draggedPanel.contextEntityIndex;
                if(abilityIndex >= 0){
                    let ItemName = Abilities.GetAbilityName(abilityIndex)
                    if(ItemName !== RESERVED_BOOK_SLOTS[slotId]){
                        // Моментальный фидбек через HUD-ошибку (без roundtrip на сервер).
                        GameEvents.SendEventClientSide("dota_hud_error_message", {
                            splitscreenplayer: 0,
                            reason: 80,
                            message: "#error_stash_reserved_slot",
                        });
                        return true
                    }
                }
            }

            let abilityIndex = draggedPanel.contextEntityIndex;
            if(abilityIndex >= 0){
                let ItemName = Abilities.GetAbilityName( abilityIndex )
                if(Entities.IsControllableByPlayer(Players.GetLocalPlayerPortraitUnit(), LPID)){
                    GameEvents.SendCustomGameEventToServer("items_move_to_custom_stash", { source: Players.GetLocalPlayerPortraitUnit(), item: abilityIndex, slot: "SLOT_"+i});
                }
            }

            return true
        })

        $.RegisterEventHandler( 'DragEnter', p, function(a, draggedPanel ){
            p.AddClass("potential_drop_target")
            return true
        });

        $.RegisterEventHandler( 'DragLeave', p, function(a, draggedPanel ){
            p.RemoveClass("potential_drop_target")
            return true
        });
    }
}

function UpdateAllDOTASlots(){
    let List = Inventory.FindChildrenWithClassTraverse("InventoryItem")
    List = List.concat(RightItems.FindChildrenWithClassTraverse("InventoryItem"))
    List = List.concat(StashDota.FindChildrenWithClassTraverse("InventoryItem"))

    for (const ItemSlot of List) {
        if(ItemSlot.id == "inventory_tpscroll_slot"){continue;}
        $.RegisterEventHandler( 'DragEnter', ItemSlot, function(a, draggedPanel ){
            if(draggedPanel.is_from_custom){
                ItemSlot.AddClass("potential_drop_target")
            }
        });

        $.RegisterEventHandler( 'DragLeave', ItemSlot, function(a, draggedPanel ){
            if(draggedPanel.is_from_custom){
                ItemSlot.RemoveClass("potential_drop_target")
            }
        });

        $.RegisterEventHandler( 'DragDrop', ItemSlot, MoveItemFromCustomStash)
    }
}

function MoveItemFromCustomStash(a, draggedPanel){
    if(draggedPanel.is_from_custom){
        let abilityIndex = draggedPanel.contextEntityIndex;

        let p = GetInventorySlotPanel(a)
        let Slot = undefined
        if(p){
            if(p.id == "inventory_neutral_slot"){
                Slot = 16
            }else{
                Slot = p.id.replace("inventory_slot_", "")
                if(Slot && parseInt(Slot) != undefined){
                    if(p.GetParent() && p.GetParent().id == "stash_row"){
                        Slot = 9 + parseInt(Slot)
                    }else{
                        Slot = parseInt(Slot)
                    }
                }
            }
        }
        if(abilityIndex >= 0){
            let ItemName = Abilities.GetAbilityName( abilityIndex )
            if(Entities.IsControllableByPlayer(Players.GetLocalPlayerPortraitUnit(), LPID)){
                GameEvents.SendCustomGameEventToServer("items_move_from_custom_stash", { source: Players.GetLocalPlayerPortraitUnit(), item: abilityIndex, slot: Slot});
            }
        }
    }
}

UpdateAllDOTASlots()

function GetOrCreateSlot(SlotNum){
    let slotId = `SLOT_${SlotNum}`
    let f = stash.FindChildTraverse(slotId)
    if(f){
        return f
    }else{
        // Оборачиваем DOTAAbilityPanel в Panel-родитель, чтобы можно было
        // класть Label с чарджами рядом (sibling). Внутри DOTAAbilityPanel
        // нативные дети (AbilityButton/ButtonWell/ItemImage) перекрывают любые
        // кастомные оверлеи, поэтому Label обязан жить снаружи.
        let wrap = $.CreatePanel("Panel", stash, slotId + "_wrap", {class: "StashSlotWrap"})
        let panel = $.CreatePanel("DOTAAbilityPanel", wrap, slotId, {class: "InventoryItem Stash AbilityMaxLevel0 no_level", hittest: false, draggable: true})
        return panel
    }
}

function GetInventorySlotPanel(panel){
    while(panel != undefined && panel.type != "DOTAAbilityPanel"){
        panel = panel.GetParent()
    }

    return panel
}

GameEvents.Subscribe('dota_player_update_selected_unit', UpdateSpecialSlots);

function UpdateSpecialSlots(){
    let Unit = Players.GetLocalPlayerPortraitUnit()
    
    if(Unit != -1){
        let bHasAbility = Entities.GetAbilityByName( Unit, "techies_spoons_stash_custom" )
        if(bHasAbility != -1){
            ManipulateOverInventory(true)
        }else{
            ManipulateOverInventory(false)
        }
    }else{
        ManipulateOverInventory(false)
    }
}

function ManipulateOverInventory(bChangeSlots){
    let Slots = []
    Slots.push(Inventory.FindChildTraverse("inventory_slot_6"))
    Slots.push(Inventory.FindChildTraverse("inventory_slot_7"))

    $.Schedule(0.01, function(){
        for (const Slot of Slots) {
            if(!Slot || !Slot.IsValid()){continue}

            if(bChangeSlots){
                Slot.RemoveClass("BackpackSlot")
                Slot.style.width = "60px"
                Slot.style.height = "34px"
                Slot.style.marginLeft = "3px"
                Slot.style.marginRight = "3px"
                Slot.style.borderBottom = "1px solid #ffffff06"
                Slot.style.horizontalAlign = "right"
                Slot.style.transform = "translateX(-4px)"

                let ButtonWell = Slot.FindChildTraverse("ButtonWell")
                if(ButtonWell){
                    ButtonWell.style.backgroundImage = `none`
                    // ButtonWell.style.boxShadow = `inset #000 -1px 1px 8px`
                }
                let ButtonSize = Slot.FindChildTraverse("ButtonSize")
                if(ButtonSize){
                    ButtonSize.style.margin = "0px 0px 0px 0px"
                    ButtonSize.style.backgroundImage = `url("s2r://panorama/images/hud/reborn/bg_backpack_psd.vtex")`
                    // ButtonSize.style.boxShadow = `inset #000000aa 0px 2px 16px 0px`
                }
                let AbilityBevel = Slot.FindChildTraverse("AbilityBevel")
                if(AbilityBevel){
                    AbilityBevel.style.backgroundImage = `none`
                }
                let AbilityButton = Slot.FindChildTraverse("AbilityButton")
                if(AbilityButton){
                    AbilityButton.style.saturation = `1`
                    AbilityButton.style.brightness = `1`
                    AbilityButton.style.contrast = `1`
                }
                let Hotkey = Slot.FindChildTraverse("HotkeyContainer")
                if(Hotkey){
                    Hotkey.style.visibility = "collapse"
                }
            }else{
                Slot.AddClass("BackpackSlot")
                let AbilityButton = Slot.FindChildTraverse("AbilityButton")
                if(AbilityButton){
                    AbilityButton.style.saturation = `0`
                    AbilityButton.style.brightness = `0.6`
                    AbilityButton.style.contrast = `0.95`
                }
            }
        }
    })
}

function ToggleStash(){
    BonusStashPanel.ToggleClass("Show")
    BonusStashButton.ToggleClass("Show")
}

// Регистрируем функцию для использования в настройках
GameUI.CustomUIConfig().ToggleStash = ToggleStash

// Открытие бонусного тайника при получении книг
GameEvents.Subscribe("open_bonus_stash", function(){
    if(!BonusStashPanel.BHasClass("Show")){
        BonusStashPanel.AddClass("Show")
        BonusStashButton.AddClass("Show")
    }
})

// Обработка подсказок для бонусного тайника
GameEvents.Subscribe("cha_hint_visible", function(params) {
    if (params.hint == "bonus_stash")
    {
        if (!GameUI.CustomUIConfig().HintOutlineParticles) {
            GameUI.CustomUIConfig().HintOutlineParticles = {}
        }
        // Используем глобальную функцию из hints.js с передачей контекста
        if (GameUI.CustomUIConfig().CreateHintParticle) {
            GameUI.CustomUIConfig().HintOutlineParticles["bonus_stash"] = GameUI.CustomUIConfig().CreateHintParticle(BonusStashButton, $.GetContextPanel())
        }
    }
})