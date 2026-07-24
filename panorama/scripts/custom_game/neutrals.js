--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const LPID = Players.GetLocalPlayer();
const DotaHUD = GetDotaHud();
const NeutralsCraftButton = $("#NeutralsCraftButton")
const NeutralsCraftButtonInfo = $("#NeutralsCraftButtonInfo")
const NeutralsCraftButtonCraft = $("#NeutralsCraftButtonCraft")
const CraftParticle = $("#CraftParticle")

const NeutralsCraftBody = $("#NeutralsCraftBody")
const ItemsList = $("#ItemsList")
const EnchantsList = $("#EnchantsList")

let SelectedItem = ""
let SelectedEnchant = ""

let PlayerItems = {}
let PlayersItems = {}

let Showed = {}

const NeutralPanel = $("#DFGMOldNeutralItems");
const DFGMOldNeutralItemsTiers = $("#DFGMOldNeutralItemsTiers")
const MaxTiers = 5

function SetupNeutrals(){
    if(DotaHUD){
        let CenterBlock = DotaHUD.FindChildTraverse("center_block")
        if(CenterBlock){
            let MainLayer = CenterBlock.FindChildTraverse("inventory_composition_layer_container")
            if(MainLayer){
                let findPanel = MainLayer.FindChildTraverse("NeutralsCraftButton");
                let ValveButton = MainLayer.FindChildTraverse("inventory_neutral_craft_holder");
                if(ValveButton){
                    ValveButton.style.visibility = "collapse"
                }
                if (findPanel) {
                    SafeDeleteAsync(findPanel)
                }
                NeutralsCraftButton.SetParent(MainLayer);
                MainLayer.MoveChildAfter(NeutralsCraftButton, MainLayer.FindChildTraverse("inventory_neutral_slot_container"))
            }
        }

        let Shop = DotaHUD.FindChildTraverse("shop");
        if (Shop != undefined) {
            let Category = Shop.FindChildTraverse("TeamNeutralItems");
            if (Category) {
                for (let i = 0; i < Category.GetChildCount(); i++) {
                    let Child = Category.GetChild(i);
                    if (Child && Child.id != "ViewAllButton" && Child.id != "DFGMOldNeutralItems") {
                        Child.style.visibility = "collapse";
                    }
                }
                let Button = Category.FindChildTraverse("ViewAllButton");
                if (Button) {
                    let FindNeutrals = Category.FindChildTraverse("DFGMOldNeutralItems");
                    if (FindNeutrals) {
                        SafeDeleteAsync(FindNeutrals);
                    }
                    NeutralPanel.SetParent(Category);
                    Category.MoveChildBefore(NeutralPanel, Button);
                    Button.SetParent(Category)

                    for (let i = 1; i <= MaxTiers; i++) {
                        let p = GetOrCreateNeutralTier(i)
                    }
                }
            }
        }
    }
}

SetupNeutrals()


function ToggleCraftMenu(){
    NeutralsCraftButton.ToggleClass("CraftOpened")
    NeutralsCraftBody.ToggleClass("CraftOpened")
}

function CloseCraftMenu(){
    NeutralsCraftButton.RemoveClass("CraftOpened")
    NeutralsCraftBody.RemoveClass("CraftOpened")

    for (let i = 0; i < ItemsList.GetChildCount(); i++) {
        let Child = ItemsList.GetChild(i)
        if(Child){
            Child.RemoveClass("SelectedForCraft")
        }
    }
    for (let i = 0; i < EnchantsList.GetChildCount(); i++) {
        let Child = EnchantsList.GetChild(i)
        if(Child){
            Child.RemoveClass("SelectedForCraft")
        }
    }
}

function UpdateNeutrals(v){
    let bRoundsEnded = v.next_round == 0
    NeutralsCraftButton.SetDialogVariable("next_round", v.next_round+"")

    let CraftCountText = v.craft_count > 0 ? `+${v.craft_count}` : ""

    NeutralsCraftButton.SetDialogVariable("craft_count", CraftCountText)

    NeutralsCraftButton.SetHasClass("RoundsEnd", bRoundsEnded)

    let Text = $.Localize("#NEUTRALS_NextDesc_Max")
    if(!bRoundsEnded){
        Text = $.Localize("#NEUTRALS_NextDesc")
        Text = Text.replace("%round%", v.next_round)
        Text = Text.replace("%tier%", v.next_tier)
    }

    NeutralsCraftButtonInfo.SetPanelEvent('onmouseover', function () {
        $.DispatchEvent("UIShowTextTooltip", NeutralsCraftButtonInfo, Text);
    });
 
    NeutralsCraftButtonInfo.SetPanelEvent('onmouseout', function () {
        $.DispatchEvent("UIHideTextTooltip", NeutralsCraftButtonInfo);
    });

    NeutralsCraftButtonCraft.SetPanelEvent('onmouseover', function () {
        $.DispatchEvent("UIShowTextTooltip", NeutralsCraftButtonCraft, "#NEUTRALS_Craft");
    });
 
    NeutralsCraftButtonCraft.SetPanelEvent('onmouseout', function () {
        $.DispatchEvent("UIHideTextTooltip", NeutralsCraftButtonCraft);
    });

    let bCraftEnabled = v.current_craft != undefined

    NeutralsCraftButton.SetHasClass("CraftEnabled", bCraftEnabled)

    if(bCraftEnabled){
        CraftParticle.StartParticles()

        NeutralsCraftBody.SetDialogVariable("tier", v.current_craft.tier)

        for (let i = 1; i <= 5; i++) {
            NeutralsCraftBody.SetHasClass(`NeutralItemTier${i}`, i==v.current_craft.tier)
        }

        ItemsList.RemoveAndDeleteChildren()
        EnchantsList.RemoveAndDeleteChildren()

        let VariableStart = "dota_ability_variable_"

        for (const _ in v.current_craft.items) {
            let ItemName = v.current_craft.items[_]

            let p = GetOrCreateItemLine(ItemName)

            p.SetPanelEvent("onactivate", function(){
                SetSelected("ITEM", ItemName)
            })
        }

        for (const _ in v.current_craft.enchants) {
            let EnchantInfo = v.current_craft.enchants[_]

            // $.Msg(EnchantInfo)

            let p = GetOrCreateEnchantLine(EnchantInfo.enchant)

            p.SetPanelEvent("onactivate", function(){
                SetSelected("ENCHANT", EnchantInfo.enchant)
            })

            let Stats = []
            let StatsText = ""
            for (const ValueName in EnchantInfo.values) {
                let value = EnchantInfo.values[ValueName]
                if(typeof value == "object"){
                    value = value.value
                }

                let values = value.split(" ")
                if(values && values[EnchantInfo.level-1] && values[EnchantInfo.level-1] != 0){
                    let ResultValue = values[EnchantInfo.level-1]
                    let text = $.Localize(`#DOTA_Tooltip_ability_${EnchantInfo.enchant}_${ValueName}`)
                    let variableText = text.match(/\$[a-zA-Z_]+/, "")
                    if(variableText){
                        variableText = $.Localize(`#${VariableStart}${variableText[0].substring(1)}`)
                        text = text.replace(/\$[a-zA-Z_]+/, variableText)
                    }
                    let bPct = text.charAt(0) == "%"
                    let pct = ""
                    if(bPct){
                        text = text.substring(1)
                        pct = "%"
                    }
                    let symbol = text.charAt(0)
                    text = text.substring(1)

                    text = `${symbol} <font class='GameplayVariable'>${Math.abs(ResultValue)}${pct}</font> ${text}`
                    Stats.push(text)
                }
            }
            Stats.sort()
            StatsText = Stats.join("<br>")

            p.SetDialogVariable("enchant_stats", StatsText)
        }

    }else{
        if(v.craft_count <= 0){
            CraftParticle.StopParticlesWithEndcaps()
            CloseCraftMenu()
        }
        SelectedEnchant = ""
        SelectedItem = ""
    }
}

function SetSelected(selectType, selectName){
    if(selectType == "ITEM" && SelectedItem == selectName){return}
    if(selectType == "ENCHANT" && SelectedEnchant == selectName){return}

    if(selectType == "ITEM"){
        SelectedItem = selectName
        SelectPanels(ItemsList, selectName)
    }
    if(selectType == "ENCHANT"){
        SelectedEnchant = selectName
        SelectPanels(EnchantsList, selectName)
    }

    if(SelectedItem != "" && SelectedEnchant != ""){
        // CloseCraftMenu()

        GameEvents.SendCustomGameEventToServer("neutrals_make_craft", {item: SelectedItem, enchant: SelectedEnchant});
    }
}

function SelectPanels(Container, Match){
    for (let i = 0; i < Container.GetChildCount(); i++) {
        let Child = Container.GetChild(i)
        if(Child){
            Child.SetHasClass("SelectedForCraft", Child.id.includes(Match))
        }
    }
}

function GetOrCreateItemLine(ItemName){
    let f = ItemsList.FindChildTraverse(`item_${ItemName}`)
    if(f){
        return f
    }else{
        let panel = $.CreatePanel("Panel", ItemsList, `item_${ItemName}`, {})
        panel.BLoadLayoutSnippet("ItemLine")

        panel.SetDialogVariable("item_name", $.Localize(`#DOTA_Tooltip_ability_${ItemName}`))

        let Image = panel.FindChildTraverse("ItemImage")
        if(Image){
            Image.itemname = ItemName

            Image.SetPanelEvent('onmouseover', function () {
                $.DispatchEvent("DOTAShowAbilityTooltip", Image, ItemName);
            });
        
            Image.SetPanelEvent('onmouseout', function () {
                $.DispatchEvent("DOTAHideAbilityTooltip", Image);
            });
        }
        
        return panel
    }
}

function GetOrCreateEnchantLine(ItemName){
    let f = EnchantsList.FindChildTraverse(`enchant_${ItemName}`)
    if(f){
        return f
    }else{
        let panel = $.CreatePanel("Panel", EnchantsList, `enchant_${ItemName}`, {})
        panel.BLoadLayoutSnippet("EnchantLine")

        panel.SetDialogVariable("item_name", $.Localize(`#DOTA_Tooltip_ability_${ItemName}`))

        let Image = panel.FindChildTraverse("EnchantImage")
        if(Image){
            Image.itemname = ItemName
        }
        
        return panel
    }
}

function GetOrCreateNeutralTier(Tier){
    let f = DFGMOldNeutralItemsTiers.FindChildTraverse(`tier_${Tier}`)
    if(f){
        return f
    }else{
        let panel = $.CreatePanel("Panel", DFGMOldNeutralItemsTiers, `tier_${Tier}`, {})
        panel.BLoadLayout("file://{resources}/layout/custom_game/neutral_tier.xml", false, false);
        panel.AddClass("NeutralItemTier" + Tier);
        panel.SetDialogVariable("tier", Tier)
        panel.SetDialogVariable("round", GetNeutralRound(Tier));
        
        return panel
    }
}

function GetOrCreateNeutralItem(Container, ItemEnt, Name){
    let f = Container.FindChildTraverse(`item_${ItemEnt}`)
    if(f){
        return f
    }else{
        let panel = $.CreatePanel("Panel", Container, `item_${ItemEnt}`, {})
        panel.BLoadLayout("file://{resources}/layout/custom_game/neutral_item.xml", false, false);

        let Image = panel.FindChildTraverse("DFGMImage")
        if(Image){
            Image.itemname = Name
        }
        
        return panel
    }
}

function UpdateNeutralStash(){
    for (let i = 1; i <= MaxTiers; i++) {
        let panel = GetOrCreateNeutralTier(i)

        let Container = panel.FindChildTraverse("DFGMNIContainer");
        if(Container){
            for (const ItemEnt in PlayerItems) {
                let ItemInfo = PlayerItems[ItemEnt]

                // $.Msg(ItemEnt, " ", ItemInfo)

                if(ItemInfo && ItemInfo.tier == i){
                    let item = GetOrCreateNeutralItem(Container, ItemEnt, ItemInfo.item_name)

                    let bEquipped = (ItemInfo.place == "INVENTORY");
                    let bInStash = (ItemInfo.place == "STASH");
                    item.SetHasClass("Equipped", bEquipped);
                    item.SetHasClass("InStash", bInStash);
                    let Text = bEquipped ? "#NEUTRALS_Item_Equipped"
                            : bInStash ? "#NEUTRALS_Item_Stash" : "";
                    item.SetDialogVariable("ItemStatus", $.Localize(Text));

                    let ActiveID = GetItemID(ItemInfo.item_name) || -1
                    let PassiveID = GetItemID(ItemInfo.enchant) || -1

                    let Image = item.FindChildTraverse("Images")
                    if(Image){
                        Image.SetPanelEvent("onmouseover", () =>{
                            $.DispatchEvent( "DOTAHideAbilityTooltip", Image );
                            if(ActiveID != -1 && PassiveID != -1){
                                $.DispatchEvent( "DOTAShowNeutralItemTooltip", Image, ActiveID, PassiveID, ItemInfo.tier || 0, ItemInfo.level )
                            }
                            if(ActiveID != -1 && PassiveID == -1){
                                let hero = Players.GetLocalPlayerPortraitUnit()
                                if(hero){
                                    $.DispatchEvent( "DOTAShowAbilityTooltipForEntityIndex", Image, ItemName, hero )
                                }
                            }
                        })

                        Image.SetPanelEvent("onmouseout", () =>{
                            $.DispatchEvent( "DOTAHideNeutralItemTooltip", Image );
                            $.DispatchEvent( "DOTAHideAbilityTooltip", Image );
                        })

                        Image.SetPanelEvent('oncontextmenu', function () {
                            if (bInStash) {
                                let Unit = Players.GetLocalPlayerPortraitUnit();
                                GameEvents.SendCustomGameEventToServer("neutrals_get_item_from_stash", { unit: Unit, item: ItemEnt});
                            }
                        });
                    }
                }
            }

            panel.SetHasClass("HasItems", Container.GetChildCount() > 0);
            panel.SetDialogVariable("DFGMTierItemsCount", "[ " + Container.GetChildCount() + " ]");
        }
    }
}

SubscribeAndFirePlayerTableByKey(`player_${LPID}`, `neutral`, function(v){
    // $.Msg(v)
    UpdateNeutrals(v)
})

SubscribeAndFirePlayerTableByKey(`player_${LPID}_global`, `neutrals_list`, function(v){
    PlayerItems = v

    UpdateNeutralStash()
})

for (const PlayerID of Game.GetAllPlayerIDs()) {
    SubscribeAndFirePlayerTableByKey(`player_${PlayerID}_global`, `neutrals_list`, function(v){
        PlayersItems[PlayerID] = v
    })
}

function GetCraftedItemInfo(PID, ItemEnt){
    if(!PlayersItems[PID]){return}

    return PlayersItems[PID][ItemEnt]
}

GameUI.CustomUIConfig().GetCraftedItemInfo = GetCraftedItemInfo

let LastDraggingFromItem = undefined
let LastDropTargetItem = undefined

$.RegisterForUnhandledEvent("StyleClassesChanged", function(panel){
    if(panel == null){return;}
    if(panel.id == "inventory_composition_layer_container"){
        let CenterBlock = DotaHUD.FindChildTraverse("center_block")
        if(CenterBlock){
            let MainLayer = CenterBlock.FindChildTraverse("inventory_composition_layer_container")
            if(MainLayer){
                let inventory_neutral_slot = MainLayer.FindChildTraverse("inventory_neutral_slot")
                if(inventory_neutral_slot){
                    UpdateNeutralContextMenu(inventory_neutral_slot)
                    $.Schedule(0.1, function(){
                        UpdateNeutralContextMenu(inventory_neutral_slot)
                    })
                    // [NP-24] Привязываем пинг ЗДЕСЬ (блок композиции срабатывает рано) — иначе
                    // пустой-с-старта слот ловит нативный командный пинг (его DOTAAbilityPanel-
                    // StyleClassesChanged ещё не сработал). Читаем слот 16 свежим на клике.
                    inventory_neutral_slot.SetPanelEvent("onactivate", function(){
                        let myUnit = Players.GetLocalPlayerPortraitUnit()
                        let idx = Entities.GetItemInSlot(myUnit, 16)
                        if(!IsDotaAltPressed()){
                            // [A11] Обычный клик — активируем нейтрал-предмет (дубль каста: этот
                            // обработчик и zxc_notifications перетирают друг друга, нужен в обоих).
                            // Пассивные предметы не кастуем.
                            if(idx != undefined && idx != -1 && !Abilities.IsPassive(idx)){
                                if(Entities.IsControllableByPlayer(myUnit, LPID)){
                                    Abilities.ExecuteAbility(idx, myUnit, false)
                                }
                            }
                            return
                        }
                        if(idx != undefined && idx != -1){
                            if(GameUI.CustomUIConfig().PingItemToChat) GameUI.CustomUIConfig().PingItemToChat(idx, myUnit)
                        } else if(GameUI.CustomUIConfig().SendPingTextToChat){
                            let hn = $.Localize("#"+Entities.GetUnitName(myUnit))
                            GameUI.CustomUIConfig().SendPingTextToChat($.Localize("#PING_NEUTRAL_NONE").replace("%s1", hn))
                        }
                    })
                }
            }
        }
    }
    if(panel.paneltype == "DOTAAbilityPanel" && (panel.GetParent() && panel.GetParent().id != 'stash')) {
        if(!Entities.IsRealHero(Players.GetLocalPlayerPortraitUnit())){return;}

        const itemImage = panel.FindChildTraverse("ItemImage")
		let abilityIndex = itemImage.contextEntityIndex;
        if(abilityIndex >= 0){
            let ItemName = Abilities.GetAbilityName( abilityIndex )
            if(Entities.IsControllableByPlayer(Players.GetLocalPlayerPortraitUnit(), LPID)){
                //SWAP MECHANIC
                let bIsPotentialDropTarget = panel.BHasClass("potential_drop_target")
                let bIsDragging = panel.BHasClass("dragging_from")

                if(bIsPotentialDropTarget && LastDraggingFromItem != undefined){
                    LastDropTargetItem = abilityIndex
                }
                if(bIsDragging){
                    if(panel.id == "inventory_neutral_slot"){
                        LastDraggingFromItem = abilityIndex
                    }
                    LastDropTargetItem = undefined
                }

                // $.Msg("Now Dragging: "+LastDraggingFromItem)
                // $.Msg("Now Drop Target: "+LastDropTargetItem)
                // $.Msg("Mouse Down: "+GameUI.IsMouseDown( 0 ))

                if(LastDraggingFromItem != undefined && LastDropTargetItem != undefined && !GameUI.IsMouseDown( 0 )){
                    let cursorPos = GameUI.GetCursorPosition();
                    let Bounds = GetAbsPanelBounds(panel)
                    let CPX = ToAbsPixelValue(cursorPos[0])
                    let CPY = ToAbsPixelValue(cursorPos[1])
                    if(CPX >= Bounds.minX && CPX <= Bounds.maxX && CPY >= Bounds.minY && CPY <= Bounds.maxY){
                        GameEvents.SendCustomGameEventToServer("neutrals_player_want_swap", {dragging: LastDraggingFromItem, drop: LastDropTargetItem}); 
                    }
                    LastDraggingFromItem = undefined
                    LastDropTargetItem = undefined
                }


                //CONTEXT MENU MECHANIC

                //STASH
                if(panel.BHasClass("ShowingItemContextMenu") && ItemIsNeutral(ItemName)){
                    let FindContextMenu = DotaHUD.FindChildTraverse("InventoryItemContextMenu")
                    if(FindContextMenu){
                        let Buttons = FindContextMenu.FindChildTraverse("Contents")
                        if(Buttons){
                            let FPanel = Buttons.FindChildTraverse("TestButton")
                            if(!FPanel){
                                let panel = $.CreatePanel("Button", Buttons, "TestButton")
                                panel.visible = true
                                $.CreatePanel("Label", panel, "TestText", {text:$.Localize("#NEUTRALS_GO_TO_STASH")})

                                panel.SetPanelEvent("onactivate", function() {
                                    GameEvents.SendCustomGameEventToServer( "neutrals_move_item_to_stash", {entindex: abilityIndex} )
                                    $.DispatchEvent("DismissAllContextMenus");
                                })
                            }
                        }
                    }
                }

                //ALL OTHER
                if(ItemIsNeutral(ItemName)){
                    // $.Msg("Updated ", abilityIndex)
                    // $.Msg("PanelID ", panel.id)
                    // panel.SetPanelEvent("oncontextmenu", function(){
                    //     $.Msg("Called ", abilityIndex)
                    //     $.DispatchEvent( "DOTAHideAbilityTooltip", panel );

                    //     let contextMenu = $.CreatePanel( "ContextMenuScript", panel, "" , {});
                    //     contextMenu.GetContentsPanel().Item = abilityIndex
                    //     // contextMenu.AddClass( "ContextMenu_NoArrow" );
                    //     // contextMenu.AddClass( "ContextMenu_NoBorder" );
                    //     contextMenu.GetContentsPanel().BLoadLayout( "file://{resources}/layout/custom_game/neutral_context_menu.xml", false, false );
                    // })
                    UpdateNeutralContextMenu(panel)
                    $.Schedule(0.1, function(){
                        UpdateNeutralContextMenu(panel)
                    })
                }
            }

            //NEUTRAL TOOLTIP MECHANIC
            if(ItemIsNeutral(ItemName) && panel.id != "inventory_neutral_slot"){
                UpdateNeutralTooltip(panel)
                $.Schedule(0.1, function(){
                    UpdateNeutralTooltip(panel)
                })
            }else if(!ItemIsNeutral(ItemName) && panel.id != "inventory_neutral_slot"){
                let slot = GetItemSlot(Players.GetLocalPlayerPortraitUnit(), abilityIndex)
                if(slot != -1){
                    itemImage.SetPanelEvent("onmouseover", () =>{
                        $.DispatchEvent( "DOTAHideAbilityTooltip", itemImage );
                        $.DispatchEvent( "DOTAShowAbilityInventoryItemTooltip", itemImage, Players.GetLocalPlayerPortraitUnit(), slot )
                    })
                    panel.SetPanelEvent("onmouseover", () =>{
                        $.DispatchEvent( "DOTAHideAbilityTooltip", panel );
                        $.DispatchEvent( "DOTAShowAbilityInventoryItemTooltip", panel, Players.GetLocalPlayerPortraitUnit(), slot )
                    })
                    $.Schedule(0.1, function(){
                        itemImage.SetPanelEvent("onmouseover", () =>{
                            $.DispatchEvent( "DOTAHideAbilityTooltip", itemImage );
                            $.DispatchEvent( "DOTAShowAbilityInventoryItemTooltip", itemImage, Players.GetLocalPlayerPortraitUnit(), slot )
                        })
                        panel.SetPanelEvent("onmouseover", () =>{
                            $.DispatchEvent( "DOTAHideAbilityTooltip", panel );
                            $.DispatchEvent( "DOTAShowAbilityInventoryItemTooltip", panel, Players.GetLocalPlayerPortraitUnit(), slot )
                        })
                    })
                }
            }
        }else{
            // panel.neutral_show_tooltip = undefined

            panel.SetPanelEvent("oncontextmenu", ()=>{})

            panel.SetPanelEvent("onmouseover", () =>{
                
            })

            panel.SetPanelEvent("onmouseout", () =>{
                
            })
        }
    }
})

function UpdateNeutralContextMenu(panel){
    const itemImage = panel.FindChildTraverse("ItemImage")
    let abilityIndex = itemImage.contextEntityIndex;
    if(abilityIndex >= 0){
        let ItemName = Abilities.GetAbilityName( abilityIndex )
        if(ItemIsNeutral(ItemName)){
            panel.SetPanelEvent("oncontextmenu", function(){
                $.DispatchEvent( "DOTAHideAbilityTooltip", panel );

                let contextMenu = $.CreatePanel( "ContextMenuScript", panel, "" , {});
                contextMenu.GetContentsPanel().Item = abilityIndex
                // contextMenu.AddClass( "ContextMenu_NoArrow" );
                // contextMenu.AddClass( "ContextMenu_NoBorder" );
                contextMenu.GetContentsPanel().BLoadLayout( "file://{resources}/layout/custom_game/neutral_context_menu.xml", false, false );
            })
        }
    }else{
        panel.SetPanelEvent("oncontextmenu", ()=>{})

        panel.SetPanelEvent("onmouseover", () =>{
            
        })

        panel.SetPanelEvent("onmouseout", () =>{
            
        })
    }
}

GameUI.CustomUIConfig().UpdateNeutralContextMenu = UpdateNeutralContextMenu

function UpdateNeutralTooltip(panel){
    let PID = Entities.GetPlayerOwnerID( Players.GetLocalPlayerPortraitUnit() )

    const itemImage = panel.FindChildTraverse("ItemImage")
    let abilityIndex = itemImage.contextEntityIndex;
    if(abilityIndex >= 0){
        let ItemName = Abilities.GetAbilityName( abilityIndex )
        if(ItemIsNeutral(ItemName) && panel.id != "inventory_neutral_slot"){
            let Info = GetCraftedItemInfo(PID, abilityIndex)
            if(Info){
                let ActiveID = GetItemID(ItemName) || -1
                let PassiveID = GetItemID(Info.enchant) || -1

                if(Showed[panel.id]){
                    $.DispatchEvent( "DOTAHideAbilityTooltip", itemImage );
                
                    if(ActiveID != -1 && PassiveID != -1){
                        $.DispatchEvent( "DOTAShowNeutralItemTooltip", itemImage, ActiveID, PassiveID, Info.tier || 0, Info.level )
                    }
                    if(ActiveID != -1 && PassiveID == -1){
                        let hero = Players.GetLocalPlayerPortraitUnit()
                        if(hero){
                            $.DispatchEvent( "DOTAShowAbilityTooltipForEntityIndex", itemImage, ItemName, hero )
                        }
                    }
                }

                itemImage.SetPanelEvent("onmouseover", () =>{
                    $.DispatchEvent( "DOTAHideAbilityTooltip", itemImage );
                    if(ActiveID != -1 && PassiveID != -1){
                        $.DispatchEvent( "DOTAShowNeutralItemTooltip", itemImage, ActiveID, PassiveID, Info.tier || 0, Info.level )
                    }
                    if(ActiveID != -1 && PassiveID == -1){
                        let hero = Players.GetLocalPlayerPortraitUnit()
                        if(hero){
                            $.DispatchEvent( "DOTAShowAbilityTooltipForEntityIndex", itemImage, ItemName, hero )
                        }
                    }
                })

                itemImage.SetPanelEvent("onmouseout", () =>{
                    $.DispatchEvent( "DOTAHideNeutralItemTooltip", itemImage );
                    $.DispatchEvent( "DOTAHideAbilityTooltip", itemImage );
                })

                panel.SetPanelEvent("onmouseover", () =>{
                    $.DispatchEvent( "DOTAHideAbilityTooltip", panel );
                    if(ActiveID != -1 && PassiveID != -1){
                        $.DispatchEvent( "DOTAShowNeutralItemTooltip", panel, ActiveID, PassiveID, Info.tier || 0, Info.level )
                    }
                    if(ActiveID != -1 && PassiveID == -1){
                        let hero = Players.GetLocalPlayerPortraitUnit()
                        if(hero){
                            $.DispatchEvent( "DOTAShowAbilityTooltipForEntityIndex", panel, ItemName, hero )
                        }
                    }
                })

                panel.SetPanelEvent("onmouseout", () =>{
                    $.DispatchEvent( "DOTAHideNeutralItemTooltip", panel );
                    $.DispatchEvent( "DOTAHideAbilityTooltip", panel );
                })

                if(panel.BHasClass("dragging_from")){
                    $.DispatchEvent( "DOTAHideNeutralItemTooltip", panel );
                    $.DispatchEvent( "DOTAHideAbilityTooltip", panel );
                }
            }
        }
    }else{
        panel.SetPanelEvent("oncontextmenu", ()=>{})

        panel.SetPanelEvent("onmouseover", () =>{
            
        })

        panel.SetPanelEvent("onmouseout", () =>{
            
        })
    }
}


GameUI.CustomUIConfig().UpdateNeutralTooltip = UpdateNeutralTooltip

function UpdateNeutralTooltipImage(panel, PID){
    let abilityIndex = panel.contextEntityIndex;
    if(abilityIndex >= 0){
        let ItemName = Abilities.GetAbilityName( abilityIndex )
        if(ItemIsNeutral(ItemName) && panel.id != "inventory_neutral_slot"){
            let Info = GetCraftedItemInfo(PID, abilityIndex)
            if(Info){
                let ActiveID = GetItemID(ItemName) || -1
                let PassiveID = GetItemID(Info.enchant) || -1

                if(Showed[panel.id]){
                    $.DispatchEvent( "DOTAHideAbilityTooltip", panel );
                
                    if(ActiveID != -1 && PassiveID != -1){
                        $.DispatchEvent( "DOTAShowNeutralItemTooltip", panel, ActiveID, PassiveID, Info.tier || 0, Info.level )
                    }
                    if(ActiveID != -1 && PassiveID == -1){
                        let hero = Players.GetLocalPlayerPortraitUnit()
                        if(hero){
                            $.DispatchEvent( "DOTAShowAbilityTooltipForEntityIndex", panel, ItemName, hero )
                        }
                    }
                }

                panel.SetPanelEvent("onmouseover", () =>{
                    $.DispatchEvent( "DOTAHideAbilityTooltip", panel );
                    if(ActiveID != -1 && PassiveID != -1){
                        $.DispatchEvent( "DOTAShowNeutralItemTooltip", panel, ActiveID, PassiveID, Info.tier || 0, Info.level )
                    }
                    if(ActiveID != -1 && PassiveID == -1){
                        let hero = Players.GetLocalPlayerPortraitUnit()
                        if(hero){
                            $.DispatchEvent( "DOTAShowAbilityTooltipForEntityIndex", panel, ItemName, hero )
                        }
                    }
                })

                panel.SetPanelEvent("onmouseout", () =>{
                    $.DispatchEvent( "DOTAHideNeutralItemTooltip", panel );
                    $.DispatchEvent( "DOTAHideAbilityTooltip", panel );
                })

                panel.SetPanelEvent("onmouseover", () =>{
                    $.DispatchEvent( "DOTAHideAbilityTooltip", panel );
                    if(ActiveID != -1 && PassiveID != -1){
                        $.DispatchEvent( "DOTAShowNeutralItemTooltip", panel, ActiveID, PassiveID, Info.tier || 0, Info.level )
                    }
                    if(ActiveID != -1 && PassiveID == -1){
                        let hero = Players.GetLocalPlayerPortraitUnit()
                        if(hero){
                            $.DispatchEvent( "DOTAShowAbilityTooltipForEntityIndex", panel, ItemName, hero )
                        }
                    }
                })

                panel.SetPanelEvent("onmouseout", () =>{
                    $.DispatchEvent( "DOTAHideNeutralItemTooltip", panel );
                    $.DispatchEvent( "DOTAHideAbilityTooltip", panel );
                })

                if(panel.BHasClass("dragging_from")){
                    $.DispatchEvent( "DOTAHideNeutralItemTooltip", panel );
                    $.DispatchEvent( "DOTAHideAbilityTooltip", panel );
                }
            }
        }
    }else{
        panel.SetPanelEvent("oncontextmenu", ()=>{})

        panel.SetPanelEvent("onmouseover", () =>{
            
        })

        panel.SetPanelEvent("onmouseout", () =>{
            
        })
    }
}

GameUI.CustomUIConfig().UpdateNeutralTooltipImage = UpdateNeutralTooltipImage

$.RegisterForUnhandledEvent("DOTAShowAbilityTooltipForEntityIndex", function(panel, ability_name, entindex){
	let p = GetInventorySlotPanel(panel)
    if(p != undefined){
        Showed[p.id] = true
    }
});

$.RegisterForUnhandledEvent("DOTAShowAbilityInventoryItemTooltip", function(panel){
    let p = GetInventorySlotPanel(panel)
    if(p != undefined){
        Showed[p.id] = true
    }
});

$.RegisterForUnhandledEvent("DOTAHideAbilityTooltip", function(panel){
    // Showed[panel.id] = false
    let p = GetInventorySlotPanel(panel)
    if(p != undefined){
        Showed[p.id] = false
    }
});

function GetItemSlot(UnitEnt, ItemEnt){
    if(UnitEnt == undefined || ItemEnt == undefined || UnitEnt == -1 || ItemEnt == -1){return -1}

    for (let i = 0; i < 15; i++) {
        if(Entities.GetItemInSlot( UnitEnt, i ) == ItemEnt){
            return i
        }
    }

    return -1
}

function GetInventorySlotPanel(panel){
    while(panel != undefined && panel.type != "DOTAAbilityPanel"){
        panel = panel.GetParent()
    }

    return panel
}