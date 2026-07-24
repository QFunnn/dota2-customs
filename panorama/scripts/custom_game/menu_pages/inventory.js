--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const LocalPID = Players.GetLocalPlayer()
const HeaderButtons = $("#HeaderButtons")
const ItemsContainer = $("#ItemsContainer")

const PANELS_TO_TYPES = {
    Pets: 2,
    FXHero: 3,
    FXAttacks: 4,
    Weather: 5,
    TopEffects: 6,
}

let LOADED = false

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

    ItemsContainer.RemoveAndDeleteChildren()

    LoadItemsByPage()
}

function LoadItemsByPage(){
    if(!LOADED){
        return
    }

    let List = Object.keys(ITEMS_LIST)
    let conds = []
    conds.push(item => ITEMS_LIST[item] && ITEMS_LIST[item].slot_type == PANELS_TO_TYPES[CurrentSelectedPage] && (PlayerHasItem(LocalPID, item) || ITEMS_LIST[item].free == 1 && ITEMS_LIST[item].buyable == 0) )

    List = filterItems(List, conds)

    List.sort((a, b)=>{
        let aName = $.Localize(`#INVENTORY_ITEM_${a}`)
		let bName = $.Localize(`#INVENTORY_ITEM_${b}`)

		if (aName !== bName) {
            if (aName < bName) return -1;
            if (aName > bName) return 1;
		}

        return 0;
    })

    for (const ItemName of List) {
        let ItemInfo = ITEMS_LIST[ItemName]

        if(!ItemInfo){continue}

        let p = GetOrCreateItem(ItemName)

        p.ItemName = ItemName

        let ItemWearButton = p.FindChildTraverse("ItemWearButton")
        if(ItemWearButton){
            ItemWearButton.SetPanelEvent("onactivate", function(){
                GameEvents.SendCustomGameEventToServer("server_wear_item", {name:ItemName})
            })
        }

        let LocalizedName = $.Localize(`#INVENTORY_ITEM_${ItemName}`)
        p.SetDialogVariable("item_name", LocalizedName)

        let LocalizedSlotName = $.Localize(`#INVENTORY_SLOT_${ItemInfo.slot_name}`)
        p.SetDialogVariable("item_slot", LocalizedSlotName)

        let bIsImagePreview = ItemInfo.preview_type == 1
        let bIsFxPreview = ItemInfo.preview_type == 2
        let bIsScenePreview = ItemInfo.preview_type == 3
        let bIsVideoPreview = ItemInfo.preview_type == 4
        let bIsHeroIconPreview = ItemInfo.slot_type == 6

        p.SetHasClass("ImagePreview", bIsImagePreview)
        p.SetHasClass("FxPreview", bIsFxPreview)
        p.SetHasClass("ScenePreview", bIsScenePreview)
        p.SetHasClass("VideoPreview", bIsVideoPreview)

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
                DeleteAllChildren(pPanel)

                let PreviewParams = ItemInfo.preview_params || {
                    origin: "0 0 0",
                    look_at: "0 0 0",
                    fov: "60",
                }

                $.Schedule(0.1, function() {
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
                })
            }
        }else if(bIsScenePreview){
            let pPanel = p.FindChildTraverse("ScenePreview")
            if(pPanel){
                DeleteAllChildren(pPanel)

                $.Schedule(0.1, function() {
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
                })
            }
        }else if(bIsVideoPreview){
            let pPanel = p.FindChildTraverse("VideoPreview")
            if(pPanel){
                DeleteAllChildren(pPanel)

                $.Schedule(0.1, function() {
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
                })
            }
        }
    }
 
    UpdateItems()
}

function GetOrCreateItem(ItemName){
    let f = ItemsContainer.FindChildTraverse(`Item_${ItemName}`)
    if(f){
        return f
    }else{
        let panel = $.CreatePanel("Panel", ItemsContainer, `Item_${ItemName}`, {})
        panel.BLoadLayoutSnippet("ShopItem")
        return panel
    }
}

function UpdateItems(){
    for (let i = 0; i < ItemsContainer.GetChildCount(); i++) {
        let p = ItemsContainer.GetChild(i)
        if(p && p.ItemName != undefined){
            let ItemName = p.ItemName
            let ItemInfo = ITEMS_LIST[ItemName]

            if(!ItemInfo){continue}

            p.SetHasClass("Weared", IsItemWeared(LocalPID, ItemName))
        }
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

    ItemsContainer.RemoveAndDeleteChildren()
}