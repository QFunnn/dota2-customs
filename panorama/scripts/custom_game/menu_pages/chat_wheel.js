--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const LocalPID = Players.GetLocalPlayer()

const MAIN_PANEL = $.GetContextPanel()

const SettingsBody = $("#SettingsBody")
const SearchByNameEntry = $("#SearchByNameEntry")
const SearchDelete = $("#SearchDelete")
const SettingsVariantsTable = $("#SettingsVariantsTable")

const HeaderContainer = $("#HeaderContainer")
const Body = $("#Body")

const OnlyHasItemsButton = $("#OnlyHasItemsButton")
const FilterBox = $("#FilterBox")

let CHAT_WHEEL_ITEMS = {}

let bOnlyHas = false

let PlayerChatItems = []

const CallKeyBind = {
    Default: "",
    Dota: DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL,
    Current: "",
    Slot: "CallKeyBind"
}

let CurrentOpenedPage = undefined
let CurrentSelectLine = 0

let CurrentSearchText = undefined
let CurrentType = undefined

let LOADED = false

let Sub = -1

function OpenMenuPage(page){
    if(CurrentOpenedPage == page){
        return
    }

    CurrentOpenedPage = page
    if(CurrentOpenedPage == "Text"){
        CurrentType = 1
    }else if(CurrentOpenedPage == "Sounds"){
        CurrentType = 2
    }

    DeselectMenusExceptOf(page)

    UpdateItemsList()

    Body.ScrollToTop()
}

function DeselectMenusExceptOf(page){
    for (let i = 0; i < HeaderContainer.GetChildCount(); i++) {
		let Child = HeaderContainer.GetChild(i)
		if(Child){
			Child.SetHasClass("Selected", Child.id == `${page}MenuButton`)
		}
	}
	// for (let i = 0; i < Body.GetChildCount(); i++) {
	// 	let Child = Body.GetChild(i)
	// 	if(Child){
	// 		Child.SetHasClass("Selected", Child.id == `Items${page}`)
	// 	}
	// }
}

function StartSelectItem(LineNum){
    if(CurrentSelectLine == LineNum || LineNum == 0){
        SettingsVariantsTable.RemoveClass("SelectingTime")
        CurrentSelectLine = 0
        DeselectLinesExceptOf(CurrentSelectLine)
        return
    }

    CurrentSelectLine = LineNum

    SettingsVariantsTable.AddClass("SelectingTime")
    DeselectLinesExceptOf(LineNum)
}

function SelectItem(ItemName){
    if(CurrentSelectLine == 0){
        return
    }

    GameEvents.SendCustomGameEventToServer("chat_wheel_item_selected", {line_id:CurrentSelectLine, item_name: ItemName})

    StartSelectItem(0)
}

function DeselectLinesExceptOf(LineNum){
    for (let i = 1; i < 9; i++) {
        let LinePanel = $(`#LineButton${i}`)
        if(LinePanel){
            LinePanel.SetHasClass("SelectingTime", i == LineNum)
        }
    }
}

function UpdateItemsList(){
    Body.RemoveAndDeleteChildren()

    let List = Object.keys(CHAT_WHEEL_ITEMS)

    let conds = []
    conds.push(item => {
        if(CurrentSearchText == undefined || CurrentSearchText == ""){
            return true
        }
        let ItemName = $.Localize(`#CUSTOM_CHAT_WHEEL_Item_${item}`)
        let SearchWords = CurrentSearchText.trim().toLowerCase().split(/\s+/);
        return SearchWords.every(word => ItemName.toLowerCase().includes(word));
    })
    conds.push(item => CHAT_WHEEL_ITEMS[item] && CHAT_WHEEL_ITEMS[item].Type == CurrentType )

    if(bOnlyHas){
        conds.push(item => CHAT_WHEEL_ITEMS[item] && (CHAT_WHEEL_ITEMS[item].free == 1 || (CHAT_WHEEL_ITEMS[item].free == 0 && PlayerHasItem(LocalPID, item))))
    }

	List = filterItems(List, conds)

    List.sort((a, b)=>{
        if(CHAT_WHEEL_ITEMS[a] == undefined || CHAT_WHEEL_ITEMS[b] == undefined){return 0}
		let aCategoryName = $.Localize(`#MENU_CHAT_WHEEL_Category_${CHAT_WHEEL_ITEMS[a].Category}`)
		let bCategoryName = $.Localize(`#MENU_CHAT_WHEEL_Category_${CHAT_WHEEL_ITEMS[b].Category}`)

		let aName = $.Localize(`#CUSTOM_CHAT_WHEEL_Item_${a}`)
		let bName = $.Localize(`#CUSTOM_CHAT_WHEEL_Item_${b}`)

		if (aCategoryName !== bCategoryName) {
            if (aCategoryName < bCategoryName) return -1;
            if (aCategoryName > bCategoryName) return 1;
		}

		if (aName !== bName) {
			if (aName < bName) return -1;
			if (aName > bName) return 1;
		}

		return 0;
	})
    
    let i = 0
    for (const ItemName of List) {
        let ItemInfo = CHAT_WHEEL_ITEMS[ItemName]

        let Category = ItemInfo.Category ?? 0

        let CategoryPanel = GetOrCreateCategory(Body, Category)
        if(CategoryPanel){
            CategoryPanel.SetDialogVariable("category_name", $.Localize(`#MENU_CHAT_WHEEL_Category_${Category}`))
            let Container = CategoryPanel.FindChildTraverse("CategoryContainer")
            let panel = GetOrCreateItem(Container, ItemName)
            panel.SetHasClass("TypeText", ItemInfo.Type == 1)
            panel.SetHasClass("TypeSound", ItemInfo.Type == 2)

            let bHasItem = (ItemInfo.free == 1 || (ItemInfo.free == 0 && PlayerHasItem(LocalPID, ItemName)))

            panel.SetHasClass("Locked", !bHasItem)

            panel.style.zIndex = -999999

            i++;
            panel.SetHasClass("Odd", i%2==0)

            panel.SetDialogVariable("itemtext", $.Localize(`#CUSTOM_CHAT_WHEEL_Item_${ItemName}`))

            if(ItemInfo.Type == 2){
                let SoundIcon = panel.FindChildTraverse("SoundIcon")
                if(SoundIcon){
                    SoundIcon.SetPanelEvent("onactivate", function(){
                        Game.EmitSound(ItemInfo.Sound)
                    })
                }
            }

            panel.SetPanelEvent("onactivate", function(){
                if(!panel.BHasClass("Locked") && bHasItem){
                    SelectItem(ItemName)
                }else if(!bHasItem && ItemInfo.buyable == 1 && !SettingsVariantsTable.BHasClass("SelectingTime")){
                    GameUI.CustomUIConfig().OpenMenuPageSpecial("Shop")
                    $.Schedule(0.01, function(){
                        GameUI.CustomUIConfig().OpenShopPageSpecial("ChatWheel")
                        GameUI.CustomUIConfig().SetFocusToItemShopSpecial(ItemName)
                    })
                }
            })

            if(!bHasItem){
                panel.SetPanelEvent("onmouseover", function(){
                    if(!SettingsVariantsTable.BHasClass("SelectingTime") && !bHasItem){
                        $.DispatchEvent('DOTAShowTextTooltip', panel, "#MENU_CHAT_WHEEL_Buy_to_use"); 
                    }
                })
                panel.SetPanelEvent('onmouseout', function() 
                {
                    $.DispatchEvent('DOTAHideTextTooltip', panel);
                })
            }
        }
    }
}

function GetOrCreateItem(Container, ItemID){
    let f = Container.FindChildTraverse(`chat_wheel_item_${ItemID}`)
    if(f){
        return f
    }else{
        let panel = $.CreatePanel("Panel", Container, `chat_wheel_item_${ItemID}`, {})
        panel.BLoadLayoutSnippet("Item")
        return panel
    }
}

function GetOrCreateCategory(Container, CategoryID){
    let f = Container.FindChildTraverse(`chat_wheel_category_${CategoryID}`)
    if(f){
        return f
    }else{
        let panel = $.CreatePanel("Panel", Container, `chat_wheel_category_${CategoryID}`, {})
        panel.BLoadLayoutSnippet("Category")
        return panel
    }
}

function UpdateChatWheel(PlayerInfo){
    for (const LineID in PlayerInfo) {
        let ItemName = PlayerInfo[LineID]
        if(ItemName != ""){
            let ItemInfo = CHAT_WHEEL_ITEMS[ItemName]
            if(ItemInfo){
                let LinePanel = $(`#LineButton${LineID}`)
                if(LinePanel){
                    let MainText = $.Localize(`#CUSTOM_CHAT_WHEEL_Item_${ItemName}`)
                    // let Prefix = ItemInfo.ForAll == 1 ? $.Localize(`#CUSTOM_CHAT_WHEEL_Prefix`)+" " : ""
                    LinePanel.SetDialogVariable("linetext", `${MainText}`)
                    LinePanel.SetHasClass("TypeSound", ItemInfo.Type == 2)
                }
            }
        }
    }
}

function CreateKeyBind(){
    $.Schedule(0.5, CreateKeyBind)

    let oldKey = CallKeyBind.Current;
    let DotaKey = Game.GetKeybindForCommand(CallKeyBind.Dota);
    if (CallKeyBind.Current == "") {
        CallKeyBind.Current = CallKeyBind.Default;
    }
    if (DotaKey != "") {
        CallKeyBind.Current = DotaKey;
    }
    if (oldKey != CallKeyBind.Current) {
        let PanelForBind = SettingsBody.FindChildTraverse(CallKeyBind.Slot);
        if (PanelForBind) {
            PanelForBind.SetDialogVariable("callkeybind", CallKeyBind.Current+"")
        }
        const cmd_name = "CastDFGMText" + Math.floor(Math.random() * 99999999);
        Game.CreateCustomKeyBind(CallKeyBind.Current, "+"+cmd_name);
        Game.AddCommand("+"+cmd_name, function(){
            if(GameUI.CustomUIConfig().OpenChatWheel != undefined){
                GameUI.CustomUIConfig().OpenChatWheel()
            }
        }, "", 0);
        Game.AddCommand("-"+cmd_name, function(){
            if(GameUI.CustomUIConfig().CloseChatWheel != undefined){
                GameUI.CustomUIConfig().CloseChatWheel()
            }
        }, "", 0);
    }
}

MAIN_PANEL.Data().OnLoad = ()=>{
    if(LOADED == true){return}
    LOADED = true

    if(Count(CHAT_WHEEL_ITEMS) == 0){
        CHAT_WHEEL_ITEMS = GetPlayerTablesValue("chat_wheel", "list")
    }

    UpdateItemsList()

    if(CurrentOpenedPage == undefined){
        OpenMenuPage("Text")
    }else{
        OpenMenuPage(CurrentOpenedPage)
    }

    if(Sub != -1){
        UnsubscribeFromPlayerTable(Sub)
        Sub = -1
    }
    Sub = SubscribeAndFirePlayerTableByKey(`player_${LocalPID}`, `chat_wheel`, function(v){
        UpdateChatWheel(v)
    })
}

MAIN_PANEL.Data().OnUnLoad = ()=>{
    if(LOADED == false){return}
    LOADED = false

    Body.RemoveAndDeleteChildren()

    if(Sub != -1){
        UnsubscribeFromPlayerTable(Sub)
        Sub = -1
    }
}

function OnSearchTextChanged(){
    if(CurrentSearchText == SearchByNameEntry.text){
        return
    }
    CurrentSearchText = SearchByNameEntry.text

    SearchDelete.SetHasClass("HasText", CurrentSearchText != undefined && CurrentSearchText != "")

    UpdateItemsList()
}

function ClearSearch(){
    SearchByNameEntry.text = ""

    // OnSearchTextChanged()
}

function ToggleFilter(){
    bOnlyHas = !bOnlyHas

    OnlyHasItemsButton.SetHasClass("Checked", bOnlyHas)
    FilterBox.SetSelected(bOnlyHas)

    UpdateItemsList()
}

(function(){
    Body.RemoveAndDeleteChildren()

    OnlyHasItemsButton.SetHasClass("Checked", bOnlyHas)
    FilterBox.SetSelected(bOnlyHas)

    SearchByNameEntry.SetPanelEvent("ontextentrychange", ()=>{
        OnSearchTextChanged()
    })

    for (let i = 1; i < 9; i++) {
        let LinePanel = $(`#LineButton${i}`)
        if(LinePanel){
            LinePanel.SetDialogVariable("linetext", $.Localize("#CUSTOM_CHAT_WHEEL_Default"))
        }
    }

    CreateKeyBind()
})();