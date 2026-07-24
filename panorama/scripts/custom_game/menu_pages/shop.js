--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const LocalPID = Players.GetLocalPlayer()
const HeaderButtons = $("#HeaderButtons")
const ItemsBody = $("#ItemsBody")

const PANELS_TO_TYPES = {
    ChatWheel: 1,
    Pets: 2,
    FXHero: 3,
    FXAttacks: 4,
    Weather: 5,
    TopEffects: 6,
}

let LOADED = false

let CHAT_WHEEL_ITEMS = {}
CHAT_WHEEL_ITEMS = GetPlayerTablesValue("chat_wheel", "list") || {}

SubscribeAndFirePlayerTableByKey(`chat_wheel`, `list`, function(v){
    CHAT_WHEEL_ITEMS = v || {}
})

let ITEMS_LIST = {}
SubscribeAndFirePlayerTableByKey(`items`, `list`, function(v){
    ITEMS_LIST = v
})

SubscribeAndFireNetTableByKey(`players_server_info`, `player_${LocalPID}`, function(v){
    if(!LOADED){
        return
    }

    if(v.player_owned_items){
        UpdateItems()

        ReorderPanels(ItemsBody, SortFunc)
    }
})

let CurrentSelectedPage = undefined

function OpenPage(page){
    if(CurrentSelectedPage == page){
        return
    }

    CurrentSelectedPage = page

    for (let i = 0; i < HeaderButtons.GetChildCount(); i++) {
        const Child = HeaderButtons.GetChild(i)
        if(Child){
            Child.SetHasClass("Selected", Child.id == `${page}Button`)
        }
    }

    ItemsBody.RemoveAndDeleteChildren()

    LoadItemsByPage()
}

GameUI.CustomUIConfig().OpenShopPageSpecial = OpenPage

function SetFocusToItem(ItemName){
    for (let i = 0; i < ItemsBody.GetChildCount(); i++) {
        let p = ItemsBody.GetChild(i)
        if(p && p.ItemName != undefined && ItemName == p.ItemName){
            p.AddClass("Focused")

            p.ScrollParentToMakePanelFit(3, false)
        }
    }
}

GameUI.CustomUIConfig().SetFocusToItemShopSpecial = SetFocusToItem

function LoadItemsByPage(){
    if(!LOADED){
        return
    }

    let List = Object.keys(ITEMS_LIST)
    let conds = []
    conds.push(item => ITEMS_LIST[item] && ITEMS_LIST[item].slot_type == PANELS_TO_TYPES[CurrentSelectedPage] && ITEMS_LIST[item].buyable == 1 )

    List = filterItems(List, conds)

    List.sort((a, b)=>{
        let aBuyed = PlayerHasItem(LocalPID, a) ? 1 : 0;
        let bBuyed = PlayerHasItem(LocalPID, b) ? 1 : 0;

        if (aBuyed !== bBuyed) {
            return aBuyed - bBuyed
        }

        let aNew = ITEMS_LIST[a].is_new == 1 ? 0 : 1;
        let bNew = ITEMS_LIST[b].is_new == 1 ? 0 : 1;

        if (aNew !== bNew) {
            return aNew - bNew
        }

        // [shop] У фраз колеса (slot_type==1) имя лежит в CUSTOM_CHAT_WHEEL_Item_, а не в
        // INVENTORY_ITEM_ — иначе алфавитная сортировка фраз не работает.
        let aName = $.Localize(`#${ITEMS_LIST[a].slot_type == 1 ? "CUSTOM_CHAT_WHEEL_Item_" : "INVENTORY_ITEM_"}${a}`)
		let bName = $.Localize(`#${ITEMS_LIST[b].slot_type == 1 ? "CUSTOM_CHAT_WHEEL_Item_" : "INVENTORY_ITEM_"}${b}`)

		if (aName !== bName) {
            if (aName < bName) return -1;
            if (aName > bName) return 1;
		}

        return 0;
    })

    let panel_height = PANELS_TO_TYPES[CurrentSelectedPage] == 1 ? 195 : 285
    let height = Math.ceil(List.length / 5) * panel_height
    ItemsBody.style.height = height + "px"

    for (const ItemName of List) {
        let ItemInfo = ITEMS_LIST[ItemName]

        if(!ItemInfo){continue}

        let p = GetOrCreateItem(ItemName)

        p.ItemName = ItemName

        p.RemoveClass("Focused")

        p.SetHasClass("IsNew", ItemInfo.is_new == 1)

        p.SetHasClass("ChatWheelItem", ItemInfo.slot_type == 1)
        if(ItemInfo.slot_type == 1){
            let ChatItemInfo = CHAT_WHEEL_ITEMS ? CHAT_WHEEL_ITEMS[ItemName] : undefined
            if(!ChatItemInfo) continue

            p.SetHasClass("TypeText", ChatItemInfo.Type == 1)
            p.SetHasClass("TypeSound", ChatItemInfo.Type == 2)

            if(ChatItemInfo.Type == 2){
                let SoundIcon = p.FindChildTraverse("SoundIcon")
                if(SoundIcon){
                    SoundIcon.SetPanelEvent("onactivate", function(){
                        Game.EmitSound(ChatItemInfo.Sound)
                    })
                }
            }

            p.SetDialogVariable("chat_line", $.Localize(`#CUSTOM_CHAT_WHEEL_Item_${ItemName}`))
        }

        let ItemBuyButton = p.FindChildTraverse("ItemBuyButton")
        if(ItemBuyButton){
            ItemBuyButton.SetPanelEvent("onactivate", function(){
                GameEvents.SendCustomGameEventToServer("server_buy_item", {name:ItemName})
            })
        }

        let LocalizedName = $.Localize(`#INVENTORY_ITEM_${ItemName}`)
        p.SetDialogVariable("item_name", LocalizedName)

        let LocalizedSlotName = $.Localize(`#INVENTORY_SLOT_${ItemInfo.slot_name}`)
        p.SetDialogVariable("item_slot", LocalizedSlotName)

        let Cost = ItemInfo.cost ?? 0
        p.SetDialogVariable("buy_cost", Cost)

        let bIsImagePreview = ItemInfo.preview_type == 1
        let bIsFxPreview = ItemInfo.preview_type == 2
        let bIsScenePreview = ItemInfo.preview_type == 3
        let bIsVideoPreview = ItemInfo.preview_type == 4
        let bIsChatWheelPreview = ItemInfo.preview_type == 5
        let bIsHeroIconPreview = ItemInfo.slot_type == 6

        p.SetHasClass("ImagePreview", bIsImagePreview)
        p.SetHasClass("FxPreview", bIsFxPreview)
        p.SetHasClass("ScenePreview", bIsScenePreview)
        p.SetHasClass("VideoPreview", bIsVideoPreview)
        p.SetHasClass("ChatWheelPreview", bIsChatWheelPreview)
        p.SetHasClass("HeroIconPreview", bIsHeroIconPreview)

        if(bIsHeroIconPreview){
            let PlayerInfo = Game.GetPlayerInfo( LocalPID )
            if(PlayerInfo){
                let HeroIconPreview = p.FindChildTraverse("HeroIconPreview")
                if(HeroIconPreview){
                    HeroIconPreview.heroname = PlayerInfo.player_selected_hero
                }
            }
        }

        if(bIsImagePreview){
            let pPanel = p.FindChildTraverse("ImagePreview")
            if(pPanel){
                pPanel.style.backgroundImage = "url('" + ItemInfo.preview_value + "');"
            }
        }else if(bIsFxPreview){
            let pPanel = p.FindChildTraverse("FxPreview")
            if(pPanel){
                pPanel.RemoveAndDeleteChildren()

                let PreviewParams = ItemInfo.preview_params || {
                    origin: "0 0 0",
                    look_at: "0 0 0",
                    fov: "60",
                }

                if(pPanel && pPanel.IsValid()){
                    $.CreatePanel("DOTAParticleScenePanel", pPanel, "", {
                        class: "PreviewPanelSize",
                        hittest: "false",
                        particleName: ItemInfo.preview_value,
                        startActive: "true",
                        particleonly: "false",
                        cameraOrigin: PreviewParams.origin,
                        lookAt: PreviewParams.look_at,
                        fov: PreviewParams.fov,
                        squarePixels: "true",
                        drawbackground: "true"
                    });
                }
            }
        }else if(bIsScenePreview){
            let pPanel = p.FindChildTraverse("ScenePreview")
            if(pPanel){
                pPanel.RemoveAndDeleteChildren()

                if(pPanel && pPanel.IsValid()){
                    $.CreatePanel("DOTAScenePanel", pPanel, "", {
                        class: "PreviewPanelSize",
                        hittest: "false",
                        renderdeferred: "false",
                        antialias: "false",
                        particleonly: "false",
                        drawbackground: "false",
                        light: "light",
                        camera: "camera1",
                        unit: ItemInfo.preview_value
                    });
                }
            }
        }else if(bIsVideoPreview){
            let pPanel = p.FindChildTraverse("VideoPreview")
            if(pPanel){
                pPanel.RemoveAndDeleteChildren()

                if(pPanel && pPanel.IsValid()){
                    let MovieP = $.CreatePanel("Movie", pPanel, "", {
                        class: "PreviewPanelSize",
                        src: ItemInfo.preview_value,
                        repeat: "true",
                        autoplay: "onload",
                        hittest: "false",
                    });
                    MovieP.style.width = "100%";
                    MovieP.style.height = "100%";
                }
            }
        }
    }

    UpdateItems()
}

function GetOrCreateItem(ItemName){
    let f = ItemsBody.FindChildTraverse(`Item_${ItemName}`)
    if(f){
        return f
    }else{
        let panel = $.CreatePanel("Panel", ItemsBody, `Item_${ItemName}`, {})
        panel.BLoadLayoutSnippet("ShopItem")
        return panel
    }
}

function UpdateItems(){
    for (let i = 0; i < ItemsBody.GetChildCount(); i++) {
        let p = ItemsBody.GetChild(i)
        if(p && p.ItemName != undefined){
            let ItemName = p.ItemName
            let ItemInfo = ITEMS_LIST[ItemName]

            if(!ItemInfo){continue}

            p.SetHasClass("Buyed", PlayerHasItem(LocalPID, ItemName))

            p.RemoveClass("Focused")
        }
    }
}

function ReorderPanels(Container, SortFunc){
    var count = Container.GetChildCount()
	if (count > 0) {
		for (var i = 0; i < count; i++) {
            for (var j = i+1; j < count; j++) {
                let prev = Container.GetChild(i);
                let child = Container.GetChild(j);
                if(child != undefined){
                    SortFunc(Container, prev, child);
                }
            }
        }
	}
}

function SortFunc(Container, a, b){
    if (!a.ItemName || !b.ItemName) return;

    let aItemName = a.ItemName
    let bItemName = b.ItemName

    let aBuyed = PlayerHasItem(LocalPID, aItemName) ? 1 : 0;
    let bBuyed = PlayerHasItem(LocalPID, bItemName) ? 1 : 0;

    if (aBuyed !== bBuyed) {
        if (aBuyed > bBuyed) {
            Container.MoveChildBefore(b, a);
        }
        return;
    }

    let aNew = ITEMS_LIST[aItemName] && ITEMS_LIST[aItemName].is_new == 1 ? 0 : 1;
    let bNew = ITEMS_LIST[bItemName] && ITEMS_LIST[bItemName].is_new == 1 ? 0 : 1;

    if (aNew !== bNew) {
        if (aNew < bNew) {
            Container.MoveChildBefore(a, b);
        } else {
            Container.MoveChildBefore(b, a);
        }
        return;
    }

    // [shop] Имя фраз колеса (slot_type==1) — в CUSTOM_CHAT_WHEEL_Item_, иначе INVENTORY_ITEM_.
    let aIsChat = ITEMS_LIST[aItemName] && ITEMS_LIST[aItemName].slot_type == 1
    let bIsChat = ITEMS_LIST[bItemName] && ITEMS_LIST[bItemName].slot_type == 1
    let aName = $.Localize(`#${aIsChat ? "CUSTOM_CHAT_WHEEL_Item_" : "INVENTORY_ITEM_"}${aItemName}`)
    let bName = $.Localize(`#${bIsChat ? "CUSTOM_CHAT_WHEEL_Item_" : "INVENTORY_ITEM_"}${bItemName}`)

	if (aName < bName) {
        Container.MoveChildBefore(b, a);
    }
}

$.GetContextPanel().Data().OnLoad = ()=>{
    if(LOADED == true){return}
    LOADED = true

    if(CurrentSelectedPage == undefined){
        OpenPage("FXHero")
    }else{
        LoadItemsByPage()
    }
}

$.GetContextPanel().Data().OnUnLoad = ()=>{
    if(LOADED == false){return}
    LOADED = false

    ItemsBody.RemoveAndDeleteChildren()
}