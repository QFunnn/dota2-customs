--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const DotaHUDHUD = GetDotaHud();
const Shop = DotaHUDHUD.FindChildTraverse("shop");
const Quickbuy = DotaHUDHUD.FindChildTraverse("quickbuy");
const Inventory = DotaHUDHUD.FindChildTraverse("inventory");
let ShopItemsPanels = []
let MouseDown = false
let LeftMouseDown = false

let QuickBuyPanel = undefined

function GetAllShopItemsPanels(){
    let Panels = []

    if(Shop){
        let BasicGrid = Shop.FindChildTraverse("GridBasicItemsCategory")
        let UpgradeGrid = Shop.FindChildTraverse("GridUpgradesCategory")

        if(BasicGrid){
            Panels = Panels.concat(BasicGrid.FindChildrenWithClassTraverse("MainShopItem"))
        }

        if(UpgradeGrid){
            Panels = Panels.concat(UpgradeGrid.FindChildrenWithClassTraverse("MainShopItem"))
        }
    }
    // if(Quickbuy){
    //     Panels = Panels.concat(Quickbuy.FindChildTraverse("StickySlot"))
    //     // for (const Slot of Quickbuy.FindChildrenWithClassTraverse("QuickBuySlot")) {
    //     //     let ItemSlot = Slot.GetChild(1)
    //     //     if(ItemSlot){
    //     //         Panels = Panels.concat(ItemSlot)
    //     //     }
    //     // }
    // }

    ShopItemsPanels = Panels

    // for (const ShopItem of ShopItemsPanels) {
    //     $.RegisterEventHandler( 'DragStart', ShopItem, function(a, dragCallbacks ){
    //         let p = GetQuickBuyPanel()
    //         if(p){
    //             p.AddClass("Drag")
    //         }
    //     })

    //     $.RegisterEventHandler( 'DragEnd', ShopItem, function(a, draggedPanel ){
    //         let p = GetQuickBuyPanel()
    //         if(p){
    //             p.RemoveClass("Drag")
    //         }
    //     });
    // }
}

function GetQuickBuyPanel(){
    return Quickbuy.FindChildrenWithClassTraverse("QuickBuyHUD")[0]
}

// [NP-22] ЛКМ по предмету в инвентаре при открытом магазине → показать предмет
// в магазине вместе с деревом сборки/улучшений (нативное поведение Доты).
// Только для ПАССИВНЫХ предметов: активные должны применяться кликом (как в ваниле),
// поэтому их не трогаем. Реализовано неинтрузивно через поллинг мыши (как Updater),
// без перехвата нативных onactivate/onmousedown — применение активок не ломается.
function GetItemEntFromInventoryPanel(panel, unit){
    let id = panel.id || ""
    let slot = -1
    if(id == "inventory_neutral_slot"){
        slot = 16
    }else if(id.indexOf("inventory_slot_") == 0){
        slot = parseInt(id.substring("inventory_slot_".length))
    }
    if(isNaN(slot) || slot < 0){ return -1 }
    return Entities.GetItemInSlot(unit, slot)
}

function HandleInventoryShowInShop(){
    if(!Inventory){ return }
    let unit = Players.GetLocalPlayerPortraitUnit()
    if(unit == -1){ return }

    let cursorPos = GameUI.GetCursorPosition()
    let CPX = ToAbsPixelValue(cursorPos[0])
    let CPY = ToAbsPixelValue(cursorPos[1])

    let Slots = Inventory.FindChildrenWithClassTraverse("InventoryItem")
    for (const Slot of Slots) {
        if(Slot.id == "inventory_tpscroll_slot"){ continue }

        let Bounds = GetAbsPanelBounds(Slot)
        if(CPX >= Bounds.minX && CPX <= Bounds.maxX && CPY >= Bounds.minY && CPY <= Bounds.maxY){
            let itemEnt = GetItemEntFromInventoryPanel(Slot, unit)
            if(itemEnt != undefined && itemEnt != -1 && Abilities.IsPassive(itemEnt)){
                let name = Abilities.GetAbilityName(itemEnt)
                if(name && name != ""){
                    GameEvents.SendEventClientSide("dota_link_clicked", {
                        link: ("dota.item." + name),
                        shop: 0,
                        recipe: 0,
                    })
                }
            }
            return
        }
    }
}

function Updater(){
    $.Schedule(0.0, Updater)

    // [NP-22] Левый клик по предмету в инвентаре при открытом магазине → показать в магазине.
    if(GameUI.IsMouseDown( 0 ) && Shop && Shop.BHasClass("ShopOpen") && LeftMouseDown == false){
        LeftMouseDown = true
        HandleInventoryShowInShop()
    }else if(!GameUI.IsMouseDown( 0 )){
        LeftMouseDown = false
    }

    if(GameUI.IsMouseDown( 1 ) && Shop && Shop.BHasClass("ShopOpen") && MouseDown == false){
        MouseDown = true
        let PortraitUnit = Players.GetLocalPlayerPortraitUnit()
        if(PortraitUnit != -1){
            let Name = Entities.GetUnitName( PortraitUnit )
            if(Name == "npc_dota_hero_target_dummy"){
                for (const ShopItem of ShopItemsPanels) {
                    let cursorPos = GameUI.GetCursorPosition();
                    let Bounds = GetAbsPanelBounds(ShopItem)
                    let CPX = ToAbsPixelValue(cursorPos[0])
                    let CPY = ToAbsPixelValue(cursorPos[1])
                    if(CPX >= Bounds.minX && CPX <= Bounds.maxX && CPY >= Bounds.minY && CPY <= Bounds.maxY){
                        let ParentPanel = FindParentByID(ShopItem, "GridBasicItemsCategory")
                        let ParentPanel2 = FindParentByID(ShopItem, "GridUpgradesCategory")

                        let bCanBeBuyed = (ParentPanel && ParentPanel.IsSelected()) || (ParentPanel2 && ParentPanel2.IsSelected())

                        let ItemImage = ShopItem.FindChildTraverse("ItemImage")
                        if(ItemImage && ItemImage.itemname != undefined && ItemImage.itemname != "" && bCanBeBuyed){
                            GameEvents.SendCustomGameEventToServer("debugger_give_item_to_dummy_from_shop", {ItemName: ItemImage.itemname, DummyEnt: PortraitUnit}); 
                        }
                    }
                }
            }
        }
    }else if(!GameUI.IsMouseDown( 1 )){
        MouseDown = false
    }
}

$.Schedule(0.1, GetAllShopItemsPanels)

Updater()