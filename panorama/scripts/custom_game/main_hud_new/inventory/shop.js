--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";
const shopHeaderButtons = $("#HeaderButtons");
let SHOP_LOADED = false;
//@ts-ignore
let CurrentSelectedPage = undefined;
const shopItemsBody = $("#ItemsBody");
const previewParamsPopup = $("#PreviewParamsPopup");
const previewParamsItemName = $("#PreviewParamsItemName");
const previewParamsFov = $("#PreviewParamsFov");
const previewParamsOriginX = $("#PreviewParamsOriginX");
const previewParamsOriginY = $("#PreviewParamsOriginY");
const previewParamsOriginZ = $("#PreviewParamsOriginZ");
const previewParamsLookAtX = $("#PreviewParamsLookAtX");
const previewParamsLookAtY = $("#PreviewParamsLookAtY");
const previewParamsLookAtZ = $("#PreviewParamsLookAtZ");
const previewParamsLuaOutput = $("#PreviewParamsLuaOutput");
let CURRENT_PREVIEW_PARAMS_ITEM = undefined;
const DEFAULT_PREVIEW_PARAMS = {
    origin: "0 0 0",
    look_at: "0 0 0",
    fov: "60",
};
const PREVIEW_PARAMS_VECTOR_STEP = 5;
const PREVIEW_PARAMS_FOV_STEP = 1;
const PREVIEW_PARAMS_OVERRIDES = {};
const PANELS_TO_TYPES = {
    ChatWheel: 1,
    FXHero: 3,
    FXAttacks: 4,
    TopEffects: 6,
    Cases: 0,
};
let SHOP_CASES_STATE;
let shopKnownOwnedItems = {};
let shopKnownOwnedCases = {};
let shopPurchaseSoundReady = false;
const SHOP_PURCHASE_SOUND = "ui_generic_button_click";
function playShopPurchaseSound() {
    Game.EmitSound(SHOP_PURCHASE_SOUND);
}
function collectOwnedItems(value) {
    const result = {};
    const owned = value === null || value === void 0 ? void 0 : value.owned;
    if (Array.isArray(owned)) {
        for (const itemName of owned) {
            result[String(itemName)] = true;
        }
    }
    else if (owned) {
        for (const itemName in owned) {
            result[String(itemName)] = true;
        }
    }
    return result;
}
function collectOwnedCases(state) {
    var _a, _b;
    return (_b = (_a = state === null || state === void 0 ? void 0 : state.player_cases) === null || _a === void 0 ? void 0 : _a[String(Players.GetLocalPlayer())]) !== null && _b !== void 0 ? _b : {};
}
function updateOwnedItemsPurchaseSound(value) {
    const nextOwned = collectOwnedItems(value);
    if (shopPurchaseSoundReady) {
        for (const itemName in nextOwned) {
            if (!shopKnownOwnedItems[itemName]) {
                playShopPurchaseSound();
                break;
            }
        }
    }
    shopKnownOwnedItems = nextOwned;
}
function updateOwnedCasesPurchaseSound(state) {
    var _a, _b;
    const nextOwned = collectOwnedCases(state);
    if (shopPurchaseSoundReady) {
        for (const caseId in nextOwned) {
            if (Number((_a = nextOwned[caseId]) !== null && _a !== void 0 ? _a : 0) > Number((_b = shopKnownOwnedCases[caseId]) !== null && _b !== void 0 ? _b : 0)) {
                playShopPurchaseSound();
                break;
            }
        }
    }
    shopKnownOwnedCases = nextOwned;
}
function isShopAvailable() {
    var _a;
    const playerInfo = CustomNetTables.GetTableValue("player_info_shop", String(Players.GetLocalPlayer()));
    return Number((_a = playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.shop_available) !== null && _a !== void 0 ? _a : 0) === 1;
}
function shopCasesToArray(data) {
    if (!data) {
        return [];
    }
    if (Array.isArray(data)) {
        return data;
    }
    return Object.keys(data).map(key => data[key]).filter(Boolean);
}
function isCasesShopAvailable() {
    return isShopAvailable() && ((SHOP_CASES_STATE === null || SHOP_CASES_STATE === void 0 ? void 0 : SHOP_CASES_STATE.enabled) === 1 || (SHOP_CASES_STATE === null || SHOP_CASES_STATE === void 0 ? void 0 : SHOP_CASES_STATE.enabled) === true);
}
function getShopCaseName(caseInfo) {
    const rawName = caseInfo.name ? $.Localize(caseInfo.name) : caseInfo.id;
    return rawName === caseInfo.name ? caseInfo.id : rawName;
}
function copyPreviewParams(params) {
    var _a, _b, _c;
    return {
        fov: String((_a = params.fov) !== null && _a !== void 0 ? _a : DEFAULT_PREVIEW_PARAMS.fov),
        origin: String((_b = params.origin) !== null && _b !== void 0 ? _b : DEFAULT_PREVIEW_PARAMS.origin),
        look_at: String((_c = params.look_at) !== null && _c !== void 0 ? _c : DEFAULT_PREVIEW_PARAMS.look_at),
    };
}
function getItemPreviewParams(itemName, itemInfo) {
    return copyPreviewParams(PREVIEW_PARAMS_OVERRIDES[itemName] || itemInfo.preview_params || DEFAULT_PREVIEW_PARAMS);
}
function formatPreviewParamsLua(params) {
    return `preview_params = {\n    fov = "${params.fov}",\n    origin = "${params.origin}",\n    look_at = "${params.look_at}"\n},`;
}
function updatePreviewParamsOutput(params) {
    if (previewParamsLuaOutput) {
        previewParamsLuaOutput.text = formatPreviewParamsLua(params);
    }
}
function splitPreviewVector(value) {
    var _a, _b, _c;
    const parts = String(value || "0 0 0").split(" ").filter(part => part !== "");
    return [
        (_a = parts[0]) !== null && _a !== void 0 ? _a : "0",
        (_b = parts[1]) !== null && _b !== void 0 ? _b : "0",
        (_c = parts[2]) !== null && _c !== void 0 ? _c : "0",
    ];
}
function joinPreviewVector(x, y, z) {
    return `${x.text || "0"} ${y.text || "0"} ${z.text || "0"}`;
}
function setPreviewVectorInputs(prefix, value) {
    const parts = splitPreviewVector(value);
    if (prefix === "Origin") {
        previewParamsOriginX.text = parts[0];
        previewParamsOriginY.text = parts[1];
        previewParamsOriginZ.text = parts[2];
    }
    else {
        previewParamsLookAtX.text = parts[0];
        previewParamsLookAtY.text = parts[1];
        previewParamsLookAtZ.text = parts[2];
    }
}
function formatPreviewNumber(value) {
    const rounded = Math.round(value * 1000) / 1000;
    return String(rounded);
}
function adjustPreviewInput(input, delta) {
    const currentValue = Number(input.text || 0);
    input.text = formatPreviewNumber((isNaN(currentValue) ? 0 : currentValue) + delta);
    applyCurrentPreviewParams();
}
function readPreviewParamsInputs() {
    return {
        fov: previewParamsFov.text || DEFAULT_PREVIEW_PARAMS.fov,
        origin: joinPreviewVector(previewParamsOriginX, previewParamsOriginY, previewParamsOriginZ),
        look_at: joinPreviewVector(previewParamsLookAtX, previewParamsLookAtY, previewParamsLookAtZ),
    };
}
function renderItemFxPreview(panel, itemInfo, previewParams) {
    const previewPanel = panel.FindChildTraverse("FxPreview");
    if (!previewPanel) {
        return;
    }
    previewPanel.RemoveAndDeleteChildren();
    if (previewPanel.IsValid()) {
        $.CreatePanel("DOTAParticleScenePanel", previewPanel, "", {
            class: "PreviewPanelSize",
            hittest: "false",
            particleName: itemInfo.preview_value,
            startActive: "true",
            particleonly: "false",
            cameraOrigin: previewParams.origin,
            lookAt: previewParams.look_at,
            fov: previewParams.fov,
            squarePixels: "true",
            drawbackground: "true"
        });
    }
}
function renderItemScenePreview(panel, itemInfo, previewParams) {
    const previewPanel = panel.FindChildTraverse("ScenePreview");
    if (!previewPanel) {
        return;
    }
    previewPanel.RemoveAndDeleteChildren();
    if (previewPanel.IsValid()) {
        $.CreatePanel("DOTAScenePanel", previewPanel, "", {
            class: "PreviewPanelSize",
            hittest: "false",
            renderdeferred: "false",
            antialias: "false",
            particleonly: "false",
            drawbackground: "false",
            light: "light",
            camera: "camera1",
            cameraOrigin: previewParams.origin,
            lookAt: previewParams.look_at,
            fov: previewParams.fov,
            unit: itemInfo.preview_value
        });
    }
}
function refreshPreviewForItem(itemName) {
    const panel = shopItemsBody.FindChildTraverse(`Item_${itemName}`);
    //@ts-ignore
    const itemInfo = SHOP_ITEMS_LIST[itemName];
    if (!panel || !itemInfo) {
        return;
    }
    const previewParams = getItemPreviewParams(itemName, itemInfo);
    if (itemInfo.preview_type == 2) {
        renderItemFxPreview(panel, itemInfo, previewParams);
    }
    else if (itemInfo.preview_type == 3) {
        renderItemScenePreview(panel, itemInfo, previewParams);
    }
}
function applyCurrentPreviewParams() {
    if (!CURRENT_PREVIEW_PARAMS_ITEM) {
        return;
    }
    const previewParams = readPreviewParamsInputs();
    PREVIEW_PARAMS_OVERRIDES[CURRENT_PREVIEW_PARAMS_ITEM] = previewParams;
    updatePreviewParamsOutput(previewParams);
    refreshPreviewForItem(CURRENT_PREVIEW_PARAMS_ITEM);
}
function openPreviewParamsTool(itemName) {
    //@ts-ignore
    const itemInfo = SHOP_ITEMS_LIST[itemName];
    if (!itemInfo) {
        return;
    }
    CURRENT_PREVIEW_PARAMS_ITEM = itemName;
    const previewParams = getItemPreviewParams(itemName, itemInfo);
    previewParamsItemName.text = $.Localize(`#INVENTORY_ITEM_${itemName}`);
    previewParamsFov.text = previewParams.fov;
    setPreviewVectorInputs("Origin", previewParams.origin);
    setPreviewVectorInputs("LookAt", previewParams.look_at);
    updatePreviewParamsOutput(previewParams);
    previewParamsPopup.AddClass("Visible");
}
function closePreviewParamsTool() {
    previewParamsPopup.RemoveClass("Visible");
    CURRENT_PREVIEW_PARAMS_ITEM = undefined;
}
function setSelectedShopCategory(category) {
    for (let i = 0; i < shopHeaderButtons.GetChildCount(); i++) {
        const button = shopHeaderButtons.GetChild(i);
        if (!button) {
            continue;
        }
        button.SetHasClass("Selected", button.id === `${category}Button`);
    }
}
function ShopOpenPage(category, forceRefresh = false) {
    if (CurrentSelectedPage === category && !forceRefresh) {
        return;
    }
    //@ts-ignore
    CurrentSelectedPage = category;
    setSelectedShopCategory(category);
    shopItemsBody.RemoveAndDeleteChildren();
    LoadShopItemsByPage();
}
let SHOP_CHAT_WHEEL_ITEMS = {};
SubscribeAndFireNetTableByKey("chat_wheel", "list", (_, __, value) => {
    SHOP_CHAT_WHEEL_ITEMS = value !== null && value !== void 0 ? value : {};
    if (SHOP_LOADED && CurrentSelectedPage !== undefined) {
        LoadShopItemsByPage();
    }
});
let SHOP_ITEMS_LIST = {};
SubscribeAndFireNetTableByKey("items", "list", (_, __, value) => {
    SHOP_ITEMS_LIST = value !== null && value !== void 0 ? value : {};
    if (SHOP_LOADED && CurrentSelectedPage !== undefined) {
        LoadShopItemsByPage();
    }
});
SubscribeAndFireNetTableByKey("cases", "state", (_, __, value) => {
    SHOP_CASES_STATE = value;
    updateOwnedCasesPurchaseSound(SHOP_CASES_STATE);
    if (SHOP_LOADED && CurrentSelectedPage === "Cases") {
        LoadShopItemsByPage();
    }
});
//@ts-ignore
const localPlayerInfoKey = `player_${Players.GetLocalPlayer()}_cosmetic_info`;
//@ts-ignore
function HandleShopLocalPlayerItemsUpdate(value) {
    updateOwnedItemsPurchaseSound(value);
    PLAYERS_ITEMS_LISTS[Players.GetLocalPlayer()] = value !== null && value !== void 0 ? value : { owned: [], slots: {} };
    if (!SHOP_LOADED) {
        return;
    }
    UpdateShopItems();
    ReorderShopPanels(shopItemsBody, SortFunc);
}
//@ts-ignore
const currentLocalPlayerData = CustomNetTables.GetTableValue("players", localPlayerInfoKey);
if (currentLocalPlayerData) {
    HandleShopLocalPlayerItemsUpdate(currentLocalPlayerData);
}
CustomNetTables.SubscribeNetTableListener("players", (tableName, key, value) => {
    if (tableName !== "players" || key !== localPlayerInfoKey) {
        return;
    }
    HandleShopLocalPlayerItemsUpdate(value);
});
CustomNetTables.SubscribeNetTableListener("player_info_shop", (tableName, key) => {
    if (tableName !== "player_info_shop" || key !== String(Players.GetLocalPlayer())) {
        return;
    }
    if (SHOP_LOADED && CurrentSelectedPage === "Cases") {
        LoadShopItemsByPage();
    }
});
GameUI.CustomUIConfig().OpenShopPageSpecial = (category) => ShopOpenPage(category);
function SetFocusToShopItem(ItemName) {
    for (let i = 0; i < shopItemsBody.GetChildCount(); i++) {
        let p = shopItemsBody.GetChild(i);
        if (p && p.ItemName != undefined && ItemName == p.ItemName) {
            p.AddClass("Focused");
            p.ScrollParentToMakePanelFit(3, false);
        }
    }
}
GameUI.CustomUIConfig().SetFocusToItemShopSpecial = (itemName) => SetFocusToShopItem(itemName);
function LoadShopItemsByPage() {
    var _a;
    if (!SHOP_LOADED || CurrentSelectedPage === undefined) {
        return;
    }
    if (CurrentSelectedPage === "Cases") {
        LoadShopCases();
        return;
    }
    let List = Object.keys(SHOP_ITEMS_LIST);
    const conds = [];
    //@ts-ignore
    conds.push(item => SHOP_ITEMS_LIST[item] && SHOP_ITEMS_LIST[item].slot_type == PANELS_TO_TYPES[CurrentSelectedPage] && SHOP_ITEMS_LIST[item].buyable == 1);
    List = filterItems(List, conds);
    List.sort((a, b) => {
        let aBuyed = PlayerHasItem(Players.GetLocalPlayer(), a) ? 1 : 0;
        let bBuyed = PlayerHasItem(Players.GetLocalPlayer(), b) ? 1 : 0;
        if (aBuyed !== bBuyed) {
            return aBuyed - bBuyed;
        }
        const aName = $.Localize(`#INVENTORY_ITEM_${a}`);
        const bName = $.Localize(`#INVENTORY_ITEM_${b}`);
        if (aName !== bName) {
            if (aName < bName)
                return -1;
            if (aName > bName)
                return 1;
        }
        return 0;
    });
    for (const ItemName of List) {
        //@ts-ignore
        const ItemInfo = SHOP_ITEMS_LIST[ItemName];
        if (!ItemInfo)
            continue;
        const p = GetOrCreateShopItem(ItemName);
        p.ItemName = ItemName;
        p.RemoveClass("Focused");
        p.SetHasClass("ChatWheelItem", ItemInfo.slot_type == 1);
        if (ItemInfo.slot_type == 1) {
            //@ts-ignore
            const ChatItemInfo = SHOP_CHAT_WHEEL_ITEMS[ItemName];
            p.SetHasClass("TypeText", (ChatItemInfo === null || ChatItemInfo === void 0 ? void 0 : ChatItemInfo.Type) == 1);
            p.SetHasClass("TypeSound", (ChatItemInfo === null || ChatItemInfo === void 0 ? void 0 : ChatItemInfo.Type) == 2);
            if ((ChatItemInfo === null || ChatItemInfo === void 0 ? void 0 : ChatItemInfo.Type) == 2) {
                const soundIcon = p.FindChildTraverse("SoundIcon");
                if (soundIcon) {
                    soundIcon.SetPanelEvent("onactivate", function () {
                        Game.EmitSound(ChatItemInfo.Sound);
                    });
                }
            }
            p.SetDialogVariable("chat_line", $.Localize(`#CUSTOM_CHAT_WHEEL_Item_${ItemName}`));
        }
        let ItemBuyButton = p.FindChildTraverse("ItemBuyButton");
        if (ItemBuyButton) {
            ItemBuyButton.SetPanelEvent("onactivate", function () {
                if (!isShopAvailable()) {
                    return;
                }
                GameEvents.SendCustomGameEventToServer("server_buy_item", { name: ItemName });
            });
        }
        let LocalizedName = $.Localize(`#INVENTORY_ITEM_${ItemName}`);
        p.SetDialogVariable("item_name", LocalizedName);
        let LocalizedSlotName = $.Localize(`#INVENTORY_SLOT_${ItemInfo.slot_name}`);
        p.SetDialogVariable("item_slot", LocalizedSlotName);
        let Cost = (_a = ItemInfo.cost) !== null && _a !== void 0 ? _a : 0;
        p.SetDialogVariable("buy_cost", Cost);
        const bIsImagePreview = ItemInfo.preview_type == 1;
        const bIsFxPreview = ItemInfo.preview_type == 2;
        const bIsScenePreview = ItemInfo.preview_type == 3;
        const bIsVideoPreview = ItemInfo.preview_type == 4;
        const bIsChatWheelPreview = ItemInfo.preview_type == 5;
        const bIsHeroIconPreview = ItemInfo.slot_type == 6;
        const bCanTunePreviewParams = Game.IsInToolsMode() && (bIsFxPreview || bIsScenePreview);
        p.SetHasClass("ImagePreview", bIsImagePreview);
        p.SetHasClass("FxPreview", bIsFxPreview);
        p.SetHasClass("ScenePreview", bIsScenePreview);
        p.SetHasClass("VideoPreview", bIsVideoPreview);
        p.SetHasClass("ChatWheelPreview", bIsChatWheelPreview);
        p.SetHasClass("HeroIconPreview", bIsHeroIconPreview);
        p.SetHasClass("CanTunePreviewParams", bCanTunePreviewParams);
        const previewParamsButton = p.FindChildTraverse("PreviewParamsButton");
        if (previewParamsButton) {
            previewParamsButton.SetPanelEvent("onactivate", function () {
                openPreviewParamsTool(ItemName);
            });
        }
        if (bIsHeroIconPreview) {
            let PlayerInfo = Game.GetPlayerInfo(Players.GetLocalPlayer());
            if (PlayerInfo) {
                const HeroIconPreview = p.FindChildTraverse("HeroIconPreview");
                if (HeroIconPreview) {
                    HeroIconPreview.heroname = PlayerInfo.player_selected_hero;
                }
            }
        }
        if (bIsImagePreview) {
            let pPanel = p.FindChildTraverse("ImagePreview");
            if (pPanel) {
                pPanel.style.backgroundImage = "url('" + ItemInfo.preview_value + "');";
            }
        }
        else if (bIsFxPreview) {
            let pPanel = p.FindChildTraverse("FxPreview");
            if (pPanel) {
                renderItemFxPreview(p, ItemInfo, getItemPreviewParams(ItemName, ItemInfo));
            }
        }
        else if (bIsScenePreview) {
            let pPanel = p.FindChildTraverse("ScenePreview");
            if (pPanel) {
                renderItemScenePreview(p, ItemInfo, getItemPreviewParams(ItemName, ItemInfo));
            }
        }
        else if (bIsVideoPreview) {
            let pPanel = p.FindChildTraverse("VideoPreview");
            if (pPanel) {
                pPanel.RemoveAndDeleteChildren();
                if (pPanel && pPanel.IsValid()) {
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
    UpdateShopItems();
}
function LoadShopCases() {
    var _a, _b, _c, _d;
    shopItemsBody.RemoveAndDeleteChildren();
    const cases = shopCasesToArray(SHOP_CASES_STATE === null || SHOP_CASES_STATE === void 0 ? void 0 : SHOP_CASES_STATE.cases);
    cases.sort((a, b) => getShopCaseName(a) < getShopCaseName(b) ? -1 : 1);
    for (const caseInfo of cases) {
        const panel = $.CreatePanel("Panel", shopItemsBody, `ShopCase_${caseInfo.id}`);
        panel.BLoadLayoutSnippet("ShopItem");
        panel.AddClass("CaseShopItem");
        panel.AddClass("ImagePreview");
        panel.SetDialogVariable("item_name", getShopCaseName(caseInfo));
        panel.SetDialogVariable("item_slot", $.Localize("#HUD_Cases_title"));
        panel.SetDialogVariable("buy_cost", String((_a = caseInfo.cost) !== null && _a !== void 0 ? _a : 0));
        const imagePreview = panel.FindChildTraverse("ImagePreview");
        if (imagePreview) {
            imagePreview.style.backgroundImage = "url('file://{images}/custom_game/cases/summer_2026_preview.png');";
            imagePreview.style.backgroundSize = "contain";
            imagePreview.style.backgroundRepeat = "no-repeat";
            imagePreview.style.backgroundPosition = "center";
        }
        const buyButton = panel.FindChildTraverse("ItemBuyButton");
        if (!buyButton) {
            continue;
        }
        buyButton.enabled = isCasesShopAvailable() && Number((_b = caseInfo.cost) !== null && _b !== void 0 ? _b : 0) <= Number((_d = (_c = CustomNetTables.GetTableValue("player_info_shop", String(Players.GetLocalPlayer()))) === null || _c === void 0 ? void 0 : _c.gold) !== null && _d !== void 0 ? _d : 0);
        buyButton.SetPanelEvent("onactivate", () => {
            if (!isCasesShopAvailable()) {
                return;
            }
            GameEvents.SendCustomGameEventToServer("cases_buy", {
                case_id: caseInfo.id,
                quantity: 1,
            });
        });
    }
}
function GetOrCreateShopItem(itemName) {
    const f = shopItemsBody.FindChildTraverse(`Item_${itemName}`);
    if (f) {
        return f;
    }
    else {
        let panel = $.CreatePanel("Panel", shopItemsBody, `Item_${itemName}`, {});
        panel.BLoadLayoutSnippet("ShopItem");
        return panel;
    }
}
function UpdateShopItems() {
    for (let i = 0; i < shopItemsBody.GetChildCount(); i++) {
        let p = shopItemsBody.GetChild(i);
        if (p && p.ItemName != undefined) {
            const ItemName = p.ItemName;
            //@ts-ignore
            const ItemInfo = SHOP_ITEMS_LIST[ItemName];
            if (!ItemInfo) {
                continue;
            }
            p.SetHasClass("Buyed", PlayerHasItem(Players.GetLocalPlayer(), ItemName));
            p.RemoveClass("Focused");
        }
    }
}
function ReorderShopPanels(container, SortFunc) {
    const count = container.GetChildCount();
    if (count > 0) {
        for (var i = 0; i < count; i++) {
            for (var j = i + 1; j < count; j++) {
                let prev = container.GetChild(i);
                let child = container.GetChild(j);
                if (child != undefined) {
                    //@ts-ignore
                    SortFunc(container, prev, child);
                }
            }
        }
    }
}
//@ts-ignore
function SortFunc(Container, a, b) {
    if (!a.ItemName || !b.ItemName)
        return;
    let aItemName = a.ItemName;
    let bItemName = b.ItemName;
    let aBuyed = PlayerHasItem(Players.GetLocalPlayer(), aItemName) ? 1 : 0;
    let bBuyed = PlayerHasItem(Players.GetLocalPlayer(), bItemName) ? 1 : 0;
    let aName = $.Localize(`#INVENTORY_ITEM_${aItemName}`);
    let bName = $.Localize(`#INVENTORY_ITEM_${bItemName}`);
    if (aBuyed !== bBuyed) {
        if (aBuyed > bBuyed) {
            Container.MoveChildBefore(b, a);
        }
        return;
    }
    if (aName > bName) {
        Container.MoveChildBefore(b, a);
    }
}
const previewParamsInputs = [
    previewParamsFov,
    previewParamsOriginX,
    previewParamsOriginY,
    previewParamsOriginZ,
    previewParamsLookAtX,
    previewParamsLookAtY,
    previewParamsLookAtZ,
];
for (const input of previewParamsInputs) {
    input.SetPanelEvent("ontextentrychange", applyCurrentPreviewParams);
}
$("#PreviewParamsFovMinus").SetPanelEvent("onactivate", () => adjustPreviewInput(previewParamsFov, -PREVIEW_PARAMS_FOV_STEP));
$("#PreviewParamsFovPlus").SetPanelEvent("onactivate", () => adjustPreviewInput(previewParamsFov, PREVIEW_PARAMS_FOV_STEP));
$("#PreviewParamsOriginXMinus").SetPanelEvent("onactivate", () => adjustPreviewInput(previewParamsOriginX, -PREVIEW_PARAMS_VECTOR_STEP));
$("#PreviewParamsOriginXPlus").SetPanelEvent("onactivate", () => adjustPreviewInput(previewParamsOriginX, PREVIEW_PARAMS_VECTOR_STEP));
$("#PreviewParamsOriginYMinus").SetPanelEvent("onactivate", () => adjustPreviewInput(previewParamsOriginY, -PREVIEW_PARAMS_VECTOR_STEP));
$("#PreviewParamsOriginYPlus").SetPanelEvent("onactivate", () => adjustPreviewInput(previewParamsOriginY, PREVIEW_PARAMS_VECTOR_STEP));
$("#PreviewParamsOriginZMinus").SetPanelEvent("onactivate", () => adjustPreviewInput(previewParamsOriginZ, -PREVIEW_PARAMS_VECTOR_STEP));
$("#PreviewParamsOriginZPlus").SetPanelEvent("onactivate", () => adjustPreviewInput(previewParamsOriginZ, PREVIEW_PARAMS_VECTOR_STEP));
$("#PreviewParamsLookAtXMinus").SetPanelEvent("onactivate", () => adjustPreviewInput(previewParamsLookAtX, -PREVIEW_PARAMS_VECTOR_STEP));
$("#PreviewParamsLookAtXPlus").SetPanelEvent("onactivate", () => adjustPreviewInput(previewParamsLookAtX, PREVIEW_PARAMS_VECTOR_STEP));
$("#PreviewParamsLookAtYMinus").SetPanelEvent("onactivate", () => adjustPreviewInput(previewParamsLookAtY, -PREVIEW_PARAMS_VECTOR_STEP));
$("#PreviewParamsLookAtYPlus").SetPanelEvent("onactivate", () => adjustPreviewInput(previewParamsLookAtY, PREVIEW_PARAMS_VECTOR_STEP));
$("#PreviewParamsLookAtZMinus").SetPanelEvent("onactivate", () => adjustPreviewInput(previewParamsLookAtZ, -PREVIEW_PARAMS_VECTOR_STEP));
$("#PreviewParamsLookAtZPlus").SetPanelEvent("onactivate", () => adjustPreviewInput(previewParamsLookAtZ, PREVIEW_PARAMS_VECTOR_STEP));
$("#PreviewParamsApplyButton").SetPanelEvent("onactivate", applyCurrentPreviewParams);
$("#PreviewParamsCloseButton").SetPanelEvent("onactivate", closePreviewParamsTool);
$("#PreviewParamsBackdrop").SetPanelEvent("onactivate", closePreviewParamsTool);
$.GetContextPanel().Data().OnLoad = () => {
    if (SHOP_LOADED == true)
        return;
    SHOP_LOADED = true;
    if (CurrentSelectedPage == undefined) {
        ShopOpenPage("FXHero");
    }
    else {
        LoadShopItemsByPage();
    }
    $.Schedule(0.1, () => {
        shopPurchaseSoundReady = true;
    });
};
$.GetContextPanel().Data().OnShow = () => {
    if (!SHOP_LOADED) {
        return;
    }
    if (CurrentSelectedPage == undefined) {
        ShopOpenPage("FXHero");
    }
    else {
        ShopOpenPage(CurrentSelectedPage, true);
    }
};
$.GetContextPanel().Data().OnUnLoad = () => {
    if (SHOP_LOADED == false) {
        return;
    }
    SHOP_LOADED = false;
    shopItemsBody.RemoveAndDeleteChildren();
};