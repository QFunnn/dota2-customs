--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";
const CHAT_WHEEL_MAIN_PANEL = $.GetContextPanel();
const SettingsBody = $("#SettingsBody");
const searchByNameEntry = $("#SearchByNameEntry");
const SearchDelete = $("#SearchDelete");
const SettingsVariantsTable = $("#SettingsVariantsTable");
const HeaderContainer = $("#HeaderContainer");
const Body = $("#Body");
const OnlyHasItemsButton = $("#OnlyHasItemsButton");
const filterCheckBox = $("#FilterBox");
let CHAT_WHEEL_ITEMS = {};
let isOnlyHas = false;
let PlayerChatItems = [];
const chatWheelCallKeyBind = {
    Default: "",
    Dota: DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL,
    Current: "",
    Slot: "CallKeyBind"
};
let currentOpenedPage = undefined;
let CurrentSelectLine = 0;
let currentSearchText = undefined;
let CurrentType = undefined;
let LOADED = false;
let listenerId = -1;
//@ts-ignore
const localPlayerInfoKey = `player_${Players.GetLocalPlayer()}_cosmetic_info`;
function refreshChatWheelItems(value) {
    var _a, _b;
    CHAT_WHEEL_ITEMS = (_a = value !== null && value !== void 0 ? value : CustomNetTables.GetTableValue("chat_wheel", "list")) !== null && _a !== void 0 ? _a : {};
    if (LOADED) {
        UpdateItemsList();
        const chatWheelPlayerTable = (_b = CustomNetTables.GetTableValue("chat_wheel", String(Players.GetLocalPlayer()))) !== null && _b !== void 0 ? _b : {};
        UpdateChatWheel(chatWheelPlayerTable);
    }
}
//@ts-ignore
function HandleChatWheelLocalPlayerItemsUpdate(value) {
    PLAYERS_ITEMS_LISTS[Players.GetLocalPlayer()] = value !== null && value !== void 0 ? value : { owned: [], slots: {} };
    if (!LOADED) {
        return;
    }
    UpdateItemsList();
}
function OpenMenuPage(page) {
    if (currentOpenedPage == page) {
        return;
    }
    currentOpenedPage = page;
    if (currentOpenedPage == "Text") {
        CurrentType = 1;
    }
    else if (currentOpenedPage == "Sounds") {
        CurrentType = 2;
    }
    DeselectMenusExceptOf(page);
    UpdateItemsList();
    Body.ScrollToTop();
}
function DeselectMenusExceptOf(page) {
    for (let i = 0; i < HeaderContainer.GetChildCount(); i++) {
        let Child = HeaderContainer.GetChild(i);
        if (Child) {
            Child.SetHasClass("Selected", Child.id == `${page}MenuButton`);
        }
    }
    // for (let i = 0; i < Body.GetChildCount(); i++) {
    // 	let Child = Body.GetChild(i)
    // 	if(Child){
    // 		Child.SetHasClass("Selected", Child.id == `Items${page}`)
    // 	}
    // }
}
function StartSelectItem(LineNum) {
    if (CurrentSelectLine == LineNum || LineNum == 0) {
        SettingsVariantsTable.RemoveClass("SelectingTime");
        CurrentSelectLine = 0;
        DeselectLinesExceptOf(CurrentSelectLine);
        return;
    }
    CurrentSelectLine = LineNum;
    SettingsVariantsTable.AddClass("SelectingTime");
    DeselectLinesExceptOf(LineNum);
}
function SelectItem(ItemName) {
    var _a;
    if (CurrentSelectLine == 0) {
        return;
    }
    const playerInfo = CustomNetTables.GetTableValue("player_info_shop", String(Players.GetLocalPlayer()));
    if (Number((_a = playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.shop_available) !== null && _a !== void 0 ? _a : 0) !== 1) {
        StartSelectItem(0);
        return;
    }
    GameEvents.SendCustomGameEventToServer("chat_wheel_item_selected", { PlayerID: Players.GetLocalPlayer(), line_id: CurrentSelectLine, item_name: ItemName });
    StartSelectItem(0);
}
function DeselectLinesExceptOf(LineNum) {
    for (let i = 1; i < 9; i++) {
        const linePanel = $(`#LineButton${i}`);
        if (linePanel) {
            linePanel.SetHasClass("SelectingTime", i == LineNum);
        }
    }
}
function UpdateItemsList() {
    var _a;
    Body.RemoveAndDeleteChildren();
    let chatWheelItems = Object.keys(CHAT_WHEEL_ITEMS);
    const conds = [];
    conds.push(item => {
        if (currentSearchText == undefined || currentSearchText == "") {
            return true;
        }
        const itemName = $.Localize(`#CUSTOM_CHAT_WHEEL_Item_${item}`);
        const searchWords = currentSearchText.trim().toLowerCase().split(/\s+/);
        return searchWords.every(word => itemName.toLowerCase().includes(word));
    });
    conds.push(item => CHAT_WHEEL_ITEMS[item] && CHAT_WHEEL_ITEMS[item].Type == CurrentType);
    if (isOnlyHas) {
        conds.push(item => CHAT_WHEEL_ITEMS[item] && (CHAT_WHEEL_ITEMS[item].free == 1 || (CHAT_WHEEL_ITEMS[item].free == 0 && PlayerHasItem(Players.GetLocalPlayer(), item))));
    }
    chatWheelItems = filterItems(chatWheelItems, conds);
    chatWheelItems.sort((a, b) => {
        if (CHAT_WHEEL_ITEMS[a] == undefined || CHAT_WHEEL_ITEMS[b] == undefined)
            return 0;
        const aCategoryName = $.Localize(`#MENU_CHAT_WHEEL_Category_${CHAT_WHEEL_ITEMS[a].Category}`);
        const bCategoryName = $.Localize(`#MENU_CHAT_WHEEL_Category_${CHAT_WHEEL_ITEMS[b].Category}`);
        const aName = $.Localize(`#CUSTOM_CHAT_WHEEL_Item_${a}`);
        const bName = $.Localize(`#CUSTOM_CHAT_WHEEL_Item_${b}`);
        if (aCategoryName !== bCategoryName) {
            if (aCategoryName < bCategoryName)
                return -1;
            if (aCategoryName > bCategoryName)
                return 1;
        }
        if (aName !== bName) {
            if (aName < bName)
                return -1;
            if (aName > bName)
                return 1;
        }
        return 0;
    });
    let i = 0;
    for (const itemName of chatWheelItems) {
        const itemInfo = CHAT_WHEEL_ITEMS[itemName];
        const category = (_a = itemInfo.Category) !== null && _a !== void 0 ? _a : 0;
        const categoryPanel = GetOrCreateCategory(Body, category);
        if (!categoryPanel)
            continue;
        categoryPanel.SetDialogVariable("category_name", $.Localize(`#MENU_CHAT_WHEEL_Category_${category}`));
        const container = categoryPanel.FindChildTraverse("CategoryContainer");
        const panel = GetOrCreateItem(container, itemName);
        panel.SetHasClass("TypeText", itemInfo.Type == 1);
        panel.SetHasClass("TypeSound", itemInfo.Type == 2);
        let isHasItem = (itemInfo.free == 1 || (itemInfo.free == 0 && PlayerHasItem(Players.GetLocalPlayer(), itemName)));
        panel.SetHasClass("Locked", !isHasItem);
        panel.style.zIndex = -999999;
        i++;
        panel.SetHasClass("Odd", i % 2 == 0);
        panel.SetDialogVariable("itemtext", $.Localize(`#CUSTOM_CHAT_WHEEL_Item_${itemName}`));
        if (itemInfo.Type == 2) {
            const soundIcon = panel.FindChildTraverse("SoundIcon");
            if (soundIcon) {
                soundIcon.SetPanelEvent("onactivate", function () {
                    Game.EmitSound(itemInfo.Sound);
                });
            }
        }
        panel.SetPanelEvent("onactivate", function () {
            if (!panel.BHasClass("Locked") && isHasItem) {
                SelectItem(itemName);
            }
            else if (!isHasItem && itemInfo.buyable == 1 && !SettingsVariantsTable.BHasClass("SelectingTime")) {
                GameUI.SwitchCustomInventoryTab("shop");
                $.Schedule(0.01, function () {
                    GameUI.CustomUIConfig().OpenShopPageSpecial("ChatWheel");
                    GameUI.CustomUIConfig().SetFocusToItemShopSpecial(itemName);
                });
            }
        });
        if (!isHasItem) {
            panel.SetPanelEvent("onmouseover", function () {
                if (!SettingsVariantsTable.BHasClass("SelectingTime") && !isHasItem) {
                    $.DispatchEvent('DOTAShowTextTooltip', panel, "#MENU_CHAT_WHEEL_Buy_to_use");
                }
            });
            panel.SetPanelEvent('onmouseout', function () {
                $.DispatchEvent('DOTAHideTextTooltip', panel);
            });
        }
    }
}
function GetOrCreateItem(Container, ItemID) {
    const target = Container.FindChildTraverse(`chat_wheel_item_${ItemID}`);
    if (target) {
        return target;
    }
    else {
        const panel = $.CreatePanel("Panel", Container, `chat_wheel_item_${ItemID}`, {});
        panel.BLoadLayoutSnippet("Item");
        return panel;
    }
}
function GetOrCreateCategory(Container, CategoryID) {
    const target = Container.FindChildTraverse(`chat_wheel_category_${CategoryID}`);
    if (target) {
        return target;
    }
    else {
        const panel = $.CreatePanel("Panel", Container, `chat_wheel_category_${CategoryID}`, {});
        panel.BLoadLayoutSnippet("Category");
        return panel;
    }
}
function UpdateChatWheel(PlayerInfo) {
    for (const LineID in PlayerInfo) {
        const itemName = PlayerInfo[LineID];
        if (itemName == "")
            continue;
        const itemInfo = CHAT_WHEEL_ITEMS[itemName];
        if (!itemInfo)
            continue;
        const linePanel = $(`#LineButton${LineID}`);
        if (!linePanel)
            continue;
        const mainText = $.Localize(`#CUSTOM_CHAT_WHEEL_Item_${itemName}`);
        // let Prefix = ItemInfo.ForAll == 1 ? $.Localize(`#CUSTOM_CHAT_WHEEL_Prefix`)+" " : ""
        linePanel.SetDialogVariable("linetext", `${mainText}`);
        linePanel.SetHasClass("TypeSound", itemInfo.Type == 2);
    }
}
function CreateKeyBind() {
    // $.Schedule(0.5, CreateKeyBind)
    $.Msg("[ChatWheel] Creating chat wheel key bind");
    const oldKey = chatWheelCallKeyBind.Current;
    const dotaKeyBind = Game.GetKeybindForCommand(chatWheelCallKeyBind.Dota);
    if (chatWheelCallKeyBind.Current == "") {
        chatWheelCallKeyBind.Current = chatWheelCallKeyBind.Default;
    }
    if (dotaKeyBind != "") {
        chatWheelCallKeyBind.Current = dotaKeyBind;
    }
    if (oldKey != chatWheelCallKeyBind.Current) {
        let PanelForBind = SettingsBody.FindChildTraverse(chatWheelCallKeyBind.Slot);
        if (PanelForBind) {
            PanelForBind.SetDialogVariable("callkeybind", chatWheelCallKeyBind.Current + "");
        }
        const cmd_name = "CastDFGMText" + Math.floor(Math.random() * 99999999);
        Game.CreateCustomKeyBind(chatWheelCallKeyBind.Current, "+" + cmd_name);
        Game.AddCommand("+" + cmd_name, GameUI.CustomUIConfig().OpenChatWheel, "", 0);
        Game.AddCommand("-" + cmd_name, GameUI.CustomUIConfig().CloseChatWheel, "", 0);
        $.Msg("[ChatWheel] Key bind for chat wheel set to " + chatWheelCallKeyBind.Current);
    }
}
CHAT_WHEEL_MAIN_PANEL.Data().OnLoad = () => {
    if (LOADED == true)
        return;
    LOADED = true;
    if (Count(CHAT_WHEEL_ITEMS) == 0) {
        refreshChatWheelItems();
    }
    UpdateItemsList();
    if (currentOpenedPage == undefined) {
        OpenMenuPage("Text");
    }
    else {
        OpenMenuPage(currentOpenedPage);
    }
    if (listenerId != -1) {
        CustomNetTables.UnsubscribeNetTableListener(listenerId);
        listenerId = -1;
    }
    listenerId = SubscribeAndFireNetTableByKey("chat_wheel", String(Players.GetLocalPlayer()), function (t, k, v) {
        UpdateChatWheel(v);
    });
};
CustomNetTables.SubscribeNetTableListener("chat_wheel", (_, key, value) => {
    if (key === "list") {
        refreshChatWheelItems(value);
    }
});
//@ts-ignore
const currentLocalPlayerData = CustomNetTables.GetTableValue("players", localPlayerInfoKey);
if (currentLocalPlayerData) {
    HandleChatWheelLocalPlayerItemsUpdate(currentLocalPlayerData);
}
CustomNetTables.SubscribeNetTableListener("players", (tableName, key, value) => {
    if (tableName !== "players" || key !== localPlayerInfoKey) {
        return;
    }
    HandleChatWheelLocalPlayerItemsUpdate(value);
});
CHAT_WHEEL_MAIN_PANEL.Data().OnUnLoad = () => {
    if (LOADED == false)
        return;
    LOADED = false;
    Body.RemoveAndDeleteChildren();
    if (listenerId != -1) {
        CustomNetTables.UnsubscribeNetTableListener(listenerId);
        listenerId = -1;
    }
};
function OnSearchTextChanged() {
    if (currentSearchText == searchByNameEntry.text) {
        return;
    }
    currentSearchText = searchByNameEntry.text;
    SearchDelete.SetHasClass("HasText", currentSearchText != undefined && currentSearchText != "");
    UpdateItemsList();
}
function ClearSearch() {
    searchByNameEntry.text = "";
    // OnSearchTextChanged()
}
function ToggleFilter() {
    isOnlyHas = !isOnlyHas;
    OnlyHasItemsButton.SetHasClass("Checked", isOnlyHas);
    filterCheckBox.SetSelected(isOnlyHas);
    UpdateItemsList();
}
(function () {
    Body.RemoveAndDeleteChildren();
    OnlyHasItemsButton.SetHasClass("Checked", isOnlyHas);
    filterCheckBox.SetSelected(isOnlyHas);
    searchByNameEntry.SetPanelEvent("ontextentrychange", () => {
        OnSearchTextChanged();
    });
    for (let i = 1; i < 9; i++) {
        let LinePanel = $(`#LineButton${i}`);
        if (LinePanel) {
            LinePanel.SetDialogVariable("linetext", $.Localize("#CUSTOM_CHAT_WHEEL_Default"));
        }
    }
    CreateKeyBind();
})();