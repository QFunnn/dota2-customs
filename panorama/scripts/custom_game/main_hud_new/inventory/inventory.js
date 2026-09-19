--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";
var _a;
const inventoryHeaderButtons = $("#HeaderButtons");
const inventoryItemsContainer = $("#ItemsContainer");
const inventoryPreviewParamsPopup = $("#InventoryPreviewParamsPopup");
const inventoryPreviewParamsItemName = $("#InventoryPreviewParamsItemName");
const inventoryPreviewParamsFov = $("#InventoryPreviewParamsFov");
const inventoryPreviewParamsOriginX = $("#InventoryPreviewParamsOriginX");
const inventoryPreviewParamsOriginY = $("#InventoryPreviewParamsOriginY");
const inventoryPreviewParamsOriginZ = $("#InventoryPreviewParamsOriginZ");
const inventoryPreviewParamsLookAtX = $("#InventoryPreviewParamsLookAtX");
const inventoryPreviewParamsLookAtY = $("#InventoryPreviewParamsLookAtY");
const inventoryPreviewParamsLookAtZ = $("#InventoryPreviewParamsLookAtZ");
const inventoryPreviewParamsLuaOutput = $("#InventoryPreviewParamsLuaOutput");
let CURRENT_INVENTORY_PREVIEW_PARAMS_ITEM = undefined;
const DEFAULT_INVENTORY_PREVIEW_PARAMS = {
    origin: "0 0 0",
    look_at: "0 0 0",
    fov: "60",
};
const INVENTORY_PREVIEW_PARAMS_VECTOR_STEP = 5;
const INVENTORY_PREVIEW_PARAMS_FOV_STEP = 1;
const INVENTORY_PREVIEW_PARAMS_OVERRIDES = {};
const CATEGORY_FILTERS = {
    Title: { slotType: 2, slotName: "title" },
    FXHero: { slotType: 3 },
    FXAttacks: { slotType: 4 },
    TopEffects: { slotType: 6, slotName: "icons" },
    Cases: { slotType: 0 },
};
let INVENTORY_LOADED = false;
//@ts-ignore
let CurrentSelectedInventoryPage = undefined;
let INVENTORY_ITEMS_LIST = {};
let INVENTORY_CASES_STATE;
function GetPlayerInfoKey() {
    return `player_${Players.GetLocalPlayer()}_cosmetic_info`;
}
function inventoryCasesToArray(data) {
    if (!data) {
        return [];
    }
    if (Array.isArray(data)) {
        return data;
    }
    return Object.keys(data).map(key => data[key]).filter(Boolean);
}
function getInventoryCaseName(caseInfo) {
    const rawName = caseInfo.name ? $.Localize(caseInfo.name) : caseInfo.id;
    return rawName === caseInfo.name ? caseInfo.id : rawName;
}
function getInventoryOwnedCaseCount(caseId) {
    var _a, _b;
    const playerCases = (_a = INVENTORY_CASES_STATE === null || INVENTORY_CASES_STATE === void 0 ? void 0 : INVENTORY_CASES_STATE.player_cases) === null || _a === void 0 ? void 0 : _a[String(Players.GetLocalPlayer())];
    return Number((_b = playerCases === null || playerCases === void 0 ? void 0 : playerCases[caseId]) !== null && _b !== void 0 ? _b : 0);
}
function copyInventoryPreviewParams(params) {
    var _a, _b, _c;
    return {
        fov: String((_a = params.fov) !== null && _a !== void 0 ? _a : DEFAULT_INVENTORY_PREVIEW_PARAMS.fov),
        origin: String((_b = params.origin) !== null && _b !== void 0 ? _b : DEFAULT_INVENTORY_PREVIEW_PARAMS.origin),
        look_at: String((_c = params.look_at) !== null && _c !== void 0 ? _c : DEFAULT_INVENTORY_PREVIEW_PARAMS.look_at),
    };
}
function getInventoryItemPreviewParams(itemName, itemInfo) {
    return copyInventoryPreviewParams(INVENTORY_PREVIEW_PARAMS_OVERRIDES[itemName] || itemInfo.preview_params || DEFAULT_INVENTORY_PREVIEW_PARAMS);
}
function formatInventoryPreviewParamsLua(params) {
    return `preview_params = {\n    fov = "${params.fov}",\n    origin = "${params.origin}",\n    look_at = "${params.look_at}"\n},`;
}
function updateInventoryPreviewParamsOutput(params) {
    if (inventoryPreviewParamsLuaOutput) {
        inventoryPreviewParamsLuaOutput.text = formatInventoryPreviewParamsLua(params);
    }
}
function splitInventoryPreviewVector(value) {
    var _a, _b, _c;
    const parts = String(value || "0 0 0").split(" ").filter(part => part !== "");
    return [
        (_a = parts[0]) !== null && _a !== void 0 ? _a : "0",
        (_b = parts[1]) !== null && _b !== void 0 ? _b : "0",
        (_c = parts[2]) !== null && _c !== void 0 ? _c : "0",
    ];
}
function joinInventoryPreviewVector(x, y, z) {
    return `${x.text || "0"} ${y.text || "0"} ${z.text || "0"}`;
}
function setInventoryPreviewVectorInputs(prefix, value) {
    const parts = splitInventoryPreviewVector(value);
    if (prefix === "Origin") {
        inventoryPreviewParamsOriginX.text = parts[0];
        inventoryPreviewParamsOriginY.text = parts[1];
        inventoryPreviewParamsOriginZ.text = parts[2];
    }
    else {
        inventoryPreviewParamsLookAtX.text = parts[0];
        inventoryPreviewParamsLookAtY.text = parts[1];
        inventoryPreviewParamsLookAtZ.text = parts[2];
    }
}
function formatInventoryPreviewNumber(value) {
    const rounded = Math.round(value * 1000) / 1000;
    return String(rounded);
}
function adjustInventoryPreviewInput(input, delta) {
    const currentValue = Number(input.text || 0);
    input.text = formatInventoryPreviewNumber((isNaN(currentValue) ? 0 : currentValue) + delta);
    applyCurrentInventoryPreviewParams();
}
function readInventoryPreviewParamsInputs() {
    return {
        fov: inventoryPreviewParamsFov.text || DEFAULT_INVENTORY_PREVIEW_PARAMS.fov,
        origin: joinInventoryPreviewVector(inventoryPreviewParamsOriginX, inventoryPreviewParamsOriginY, inventoryPreviewParamsOriginZ),
        look_at: joinInventoryPreviewVector(inventoryPreviewParamsLookAtX, inventoryPreviewParamsLookAtY, inventoryPreviewParamsLookAtZ),
    };
}
function renderInventoryItemFxPreview(panel, itemInfo, previewParams) {
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
function renderInventoryItemScenePreview(panel, itemInfo, previewParams) {
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
function refreshInventoryPreviewForItem(itemName) {
    const panel = inventoryItemsContainer.FindChildTraverse(`Item_${itemName}`);
    const itemInfo = INVENTORY_ITEMS_LIST[itemName];
    if (!panel || !itemInfo) {
        return;
    }
    const previewParams = getInventoryItemPreviewParams(itemName, itemInfo);
    if (itemInfo.preview_type == 2) {
        renderInventoryItemFxPreview(panel, itemInfo, previewParams);
    }
    else if (itemInfo.preview_type == 3) {
        renderInventoryItemScenePreview(panel, itemInfo, previewParams);
    }
}
function applyCurrentInventoryPreviewParams() {
    if (!CURRENT_INVENTORY_PREVIEW_PARAMS_ITEM) {
        return;
    }
    const previewParams = readInventoryPreviewParamsInputs();
    INVENTORY_PREVIEW_PARAMS_OVERRIDES[CURRENT_INVENTORY_PREVIEW_PARAMS_ITEM] = previewParams;
    updateInventoryPreviewParamsOutput(previewParams);
    refreshInventoryPreviewForItem(CURRENT_INVENTORY_PREVIEW_PARAMS_ITEM);
}
function openInventoryPreviewParamsTool(itemName) {
    const itemInfo = INVENTORY_ITEMS_LIST[itemName];
    if (!itemInfo) {
        return;
    }
    CURRENT_INVENTORY_PREVIEW_PARAMS_ITEM = itemName;
    const previewParams = getInventoryItemPreviewParams(itemName, itemInfo);
    inventoryPreviewParamsItemName.text = $.Localize(`#INVENTORY_ITEM_${itemName}`);
    inventoryPreviewParamsFov.text = previewParams.fov;
    setInventoryPreviewVectorInputs("Origin", previewParams.origin);
    setInventoryPreviewVectorInputs("LookAt", previewParams.look_at);
    updateInventoryPreviewParamsOutput(previewParams);
    inventoryPreviewParamsPopup.AddClass("Visible");
}
function closeInventoryPreviewParamsTool() {
    inventoryPreviewParamsPopup.RemoveClass("Visible");
    CURRENT_INVENTORY_PREVIEW_PARAMS_ITEM = undefined;
}
function setSelectedCategory(category) {
    for (let i = 0; i < inventoryHeaderButtons.GetChildCount(); i++) {
        const button = inventoryHeaderButtons.GetChild(i);
        if (!button) {
            continue;
        }
        button.SetHasClass("Selected", button.id === `${category}Button`);
    }
}
function InventoryOpenPage(category, forceRefresh = false) {
    // $.Msg(`Inventory open page: ${category}`)
    if (CurrentSelectedInventoryPage === category && !forceRefresh) {
        // $.Msg(`Inventory already on page: ${category}. Return...`)
        return;
    }
    CurrentSelectedInventoryPage = category;
    setSelectedCategory(category);
    if (inventoryItemsContainer) {
        inventoryItemsContainer.RemoveAndDeleteChildren();
    }
    LoadInventoryItemsByPage();
}
function HandleInventoryLocalPlayerItemsUpdate(value) {
    PLAYERS_ITEMS_LISTS[Players.GetLocalPlayer()] = value !== null && value !== void 0 ? value : { owned: [], slots: {} };
    if (!INVENTORY_LOADED) {
        return;
    }
    LoadInventoryItemsByPage();
}
function LoadInventoryItemsByPage() {
    if (!INVENTORY_LOADED || CurrentSelectedInventoryPage === undefined) {
        $.Msg(`Inventory loaded: ${INVENTORY_LOADED}, current page: ${CurrentSelectedInventoryPage}`);
        return;
    }
    if (CurrentSelectedInventoryPage === "Cases") {
        LoadInventoryCases();
        return;
    }
    let itemNames = Object.keys(INVENTORY_ITEMS_LIST);
    const conds = [];
    conds.push(item => {
        const itemInfo = INVENTORY_ITEMS_LIST[item];
        if (!itemInfo) {
            return false;
        }
        //@ts-ignore
        const categoryFilter = CATEGORY_FILTERS[CurrentSelectedInventoryPage];
        if (itemInfo.slot_type != categoryFilter.slotType) {
            return false;
        }
        if (categoryFilter.slotName && itemInfo.slot_name != categoryFilter.slotName) {
            return false;
        }
        return true;
    });
    conds.push(item => PlayerHasItem(Players.GetLocalPlayer(), item));
    itemNames = filterItems(itemNames, conds);
    itemNames.sort((a, b) => {
        const aWeared = IsItemWeared(Players.GetLocalPlayer(), a) ? 1 : 0;
        const bWeared = IsItemWeared(Players.GetLocalPlayer(), b) ? 1 : 0;
        if (aWeared !== bWeared) {
            return bWeared - aWeared;
        }
        const aName = $.Localize(`#INVENTORY_ITEM_${a}`);
        const bName = $.Localize(`#INVENTORY_ITEM_${b}`);
        if (aName < bName)
            return -1;
        if (aName > bName)
            return 1;
        return 0;
    });
    for (const itemName of itemNames) {
        // $.Msg(`Loading inventory item: ${itemName}`)
        const itemInfo = INVENTORY_ITEMS_LIST[itemName];
        if (!itemInfo) {
            continue;
        }
        const p = GetOrCreateInventoryItem(itemName);
        p.ItemName = itemName;
        const localizedName = $.Localize(`#INVENTORY_ITEM_${itemName}`);
        p.SetDialogVariable("item_name", localizedName);
        const localizedSlotName = $.Localize(`#INVENTORY_SLOT_${itemInfo.slot_name}`);
        p.SetDialogVariable("item_slot", localizedSlotName);
        const isImagePreview = itemInfo.preview_type == 1;
        const isFxPreview = itemInfo.preview_type == 2;
        const isScenePreview = itemInfo.preview_type == 3;
        const isVideoPreview = itemInfo.preview_type == 4;
        const isChatWheelPreview = itemInfo.preview_type == 5;
        const isHeroIconPreview = itemInfo.slot_type == 6;
        const canTunePreviewParams = Game.IsInToolsMode() && (isFxPreview || isScenePreview);
        p.SetHasClass("ImagePreview", isImagePreview);
        p.SetHasClass("FxPreview", isFxPreview);
        p.SetHasClass("ScenePreview", isScenePreview);
        p.SetHasClass("VideoPreview", isVideoPreview);
        p.SetHasClass("ChatWheelPreview", isChatWheelPreview);
        p.SetHasClass("HeroIconPreview", isHeroIconPreview);
        p.SetHasClass("CanTunePreviewParams", canTunePreviewParams);
        const previewParamsButton = p.FindChildTraverse("PreviewParamsButton");
        if (previewParamsButton) {
            previewParamsButton.SetPanelEvent("onactivate", () => openInventoryPreviewParamsTool(itemName));
        }
        if (isHeroIconPreview) {
            const playerInfo = Game.GetPlayerInfo(Players.GetLocalPlayer());
            if (playerInfo) {
                const heroIconPreview = p.FindChildTraverse("HeroIconPreview");
                if (heroIconPreview) {
                    heroIconPreview.heroname = playerInfo.player_selected_hero;
                }
            }
        }
        if (isImagePreview) {
            const pPanel = p.FindChildTraverse("ImagePreview");
            if (pPanel) {
                pPanel.style.backgroundImage = `url('${itemInfo.preview_value}');`;
            }
        }
        else if (isFxPreview) {
            const pPanel = p.FindChildTraverse("FxPreview");
            if (pPanel) {
                renderInventoryItemFxPreview(p, itemInfo, getInventoryItemPreviewParams(itemName, itemInfo));
            }
        }
        else if (isScenePreview) {
            const pPanel = p.FindChildTraverse("ScenePreview");
            if (pPanel) {
                renderInventoryItemScenePreview(p, itemInfo, getInventoryItemPreviewParams(itemName, itemInfo));
            }
        }
        else if (isVideoPreview) {
            const pPanel = p.FindChildTraverse("VideoPreview");
            if (pPanel) {
                pPanel.RemoveAndDeleteChildren();
                if (pPanel.IsValid()) {
                    const movieP = $.CreatePanel("Movie", pPanel, "", {
                        class: "PreviewPanelSize",
                        src: itemInfo.preview_value,
                        repeat: "true",
                        autoplay: "onload",
                        hittest: "false",
                    });
                    movieP.style.width = "100%";
                    movieP.style.height = "100%";
                }
            }
        }
        const itemWearButton = p.FindChildTraverse("ItemWearButton");
        if (itemWearButton) {
            itemWearButton.SetPanelEvent("onactivate", () => ToggleWearItem(itemName));
        }
    }
    UpdateInventoryItems();
}
function LoadInventoryCases() {
    var _a;
    if (!inventoryItemsContainer) {
        return;
    }
    INVENTORY_CASES_STATE = (_a = CustomNetTables.GetTableValue("cases", "state")) !== null && _a !== void 0 ? _a : INVENTORY_CASES_STATE;
    inventoryItemsContainer.RemoveAndDeleteChildren();
    const cases = inventoryCasesToArray(INVENTORY_CASES_STATE === null || INVENTORY_CASES_STATE === void 0 ? void 0 : INVENTORY_CASES_STATE.cases)
        .filter(caseInfo => getInventoryOwnedCaseCount(caseInfo.id) > 0)
        .sort((a, b) => getInventoryCaseName(a) < getInventoryCaseName(b) ? -1 : 1);
    for (const caseInfo of cases) {
        const panel = $.CreatePanel("Panel", inventoryItemsContainer, `InventoryCase_${caseInfo.id}`);
        panel.AddClass("CaseInventoryItem");
        const preview = $.CreatePanel("Panel", panel, "", { class: "CaseInventoryPreview" });
        $.CreatePanel("Panel", preview, "", { class: "CaseInventoryPreviewImage", hittest: "false" });
        const slot = $.CreatePanel("Panel", panel, "", { class: "CaseInventorySlotName", hittest: "false" });
        $.CreatePanel("Label", slot, "", { class: "ItemSlotNameText", text: $.Localize("#HUD_Cases_title"), hittest: "false" });
        const info = $.CreatePanel("Panel", panel, "", { class: "CaseInventoryInfo" });
        const name = $.CreatePanel("Label", info, "", { class: "CaseInventoryName", hittest: "false" });
        name.text = getInventoryCaseName(caseInfo);
        const meta = $.CreatePanel("Panel", info, "", { class: "CaseInventoryMeta", hittest: "false" });
        const owned = $.CreatePanel("Label", meta, "", { class: "CaseInventoryMetaText", hittest: "false" });
        owned.text = `${$.Localize("#HUD_Cases_owned_prefix")} ${getInventoryOwnedCaseCount(caseInfo.id)}`;
        const openButton = $.CreatePanel("Button", info, "", { class: "CaseInventoryAction" });
        openButton.SetPanelEvent("onactivate", () => {
            GameUI.OpenCustomCaseFromInventory(caseInfo.id);
        });
        $.CreatePanel("Label", openButton, "", { text: $.Localize("#HUD_Cases_open"), hittest: "false" });
    }
}
function ToggleWearItem(itemName) {
    var _a;
    const localPlayer = Players.GetLocalPlayer();
    const playerInfo = CustomNetTables.GetTableValue("player_info_shop", String(localPlayer));
    if (Number((_a = playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.shop_available) !== null && _a !== void 0 ? _a : 0) !== 1) {
        return;
    }
    const itemInfo = INVENTORY_ITEMS_LIST[itemName];
    if (!itemInfo) {
        return;
    }
    if (!PlayerHasItem(localPlayer, itemName)) {
        return;
    }
    const isWeared = IsItemWeared(localPlayer, itemName);
    const localData = PLAYERS_ITEMS_LISTS[localPlayer];
    if (isWeared) {
        GameEvents.SendCustomGameEventToServer("server_unequip_item", { name: itemName, slot_name: itemInfo.slot_name });
        if (localData && localData.slots) {
            for (const slotName in localData.slots) {
                if (localData.slots[slotName] == itemName) {
                    localData.slots[slotName] = "";
                }
            }
        }
    }
    else {
        GameEvents.SendCustomGameEventToServer("server_equip_item", { name: itemName, slot_name: itemInfo.slot_name });
        if (localData) {
            localData.slots = localData.slots || {};
            localData.slots[itemInfo.slot_name] = itemName;
        }
    }
    UpdateInventoryItems();
    ReorderInventoryPanels(inventoryItemsContainer, SortFunc);
}
function GetOrCreateInventoryItem(itemName) {
    const current = inventoryItemsContainer.FindChildTraverse(`Item_${itemName}`);
    if (current) {
        return current;
    }
    const panel = $.CreatePanel("Panel", inventoryItemsContainer, `Item_${itemName}`, {});
    panel.BLoadLayoutSnippet("ShopItem");
    return panel;
}
function UpdateInventoryItems() {
    for (let i = 0; i < inventoryItemsContainer.GetChildCount(); i++) {
        const p = inventoryItemsContainer.GetChild(i);
        if (!p || p.ItemName == undefined) {
            continue;
        }
        const itemName = p.ItemName;
        p.SetHasClass("Buyed", PlayerHasItem(Players.GetLocalPlayer(), itemName));
        p.SetHasClass("Weared", IsItemWeared(Players.GetLocalPlayer(), itemName));
    }
}
function ReorderInventoryPanels(container, sortFunc) {
    const count = container.GetChildCount();
    if (count <= 0) {
        return;
    }
    for (let i = 0; i < count; i++) {
        for (let j = i + 1; j < count; j++) {
            const prev = container.GetChild(i);
            const child = container.GetChild(j);
            if (prev && child) {
                sortFunc(container, prev, child);
            }
        }
    }
}
//@ts-ignore
function SortFunc(container, a, b) {
    if (!a.ItemName || !b.ItemName) {
        return;
    }
    const aItemName = a.ItemName;
    const bItemName = b.ItemName;
    const aWeared = IsItemWeared(Players.GetLocalPlayer(), aItemName) ? 1 : 0;
    const bWeared = IsItemWeared(Players.GetLocalPlayer(), bItemName) ? 1 : 0;
    if (aWeared !== bWeared) {
        if (aWeared < bWeared) {
            container.MoveChildBefore(b, a);
        }
        return;
    }
    const aName = $.Localize(`#INVENTORY_ITEM_${aItemName}`);
    const bName = $.Localize(`#INVENTORY_ITEM_${bItemName}`);
    if (aName > bName) {
        container.MoveChildBefore(b, a);
    }
}
const inventoryPreviewParamsInputs = [
    inventoryPreviewParamsFov,
    inventoryPreviewParamsOriginX,
    inventoryPreviewParamsOriginY,
    inventoryPreviewParamsOriginZ,
    inventoryPreviewParamsLookAtX,
    inventoryPreviewParamsLookAtY,
    inventoryPreviewParamsLookAtZ,
];
for (const input of inventoryPreviewParamsInputs) {
    input.SetPanelEvent("ontextentrychange", applyCurrentInventoryPreviewParams);
}
$("#InventoryPreviewParamsFovMinus").SetPanelEvent("onactivate", () => adjustInventoryPreviewInput(inventoryPreviewParamsFov, -INVENTORY_PREVIEW_PARAMS_FOV_STEP));
$("#InventoryPreviewParamsFovPlus").SetPanelEvent("onactivate", () => adjustInventoryPreviewInput(inventoryPreviewParamsFov, INVENTORY_PREVIEW_PARAMS_FOV_STEP));
$("#InventoryPreviewParamsOriginXMinus").SetPanelEvent("onactivate", () => adjustInventoryPreviewInput(inventoryPreviewParamsOriginX, -INVENTORY_PREVIEW_PARAMS_VECTOR_STEP));
$("#InventoryPreviewParamsOriginXPlus").SetPanelEvent("onactivate", () => adjustInventoryPreviewInput(inventoryPreviewParamsOriginX, INVENTORY_PREVIEW_PARAMS_VECTOR_STEP));
$("#InventoryPreviewParamsOriginYMinus").SetPanelEvent("onactivate", () => adjustInventoryPreviewInput(inventoryPreviewParamsOriginY, -INVENTORY_PREVIEW_PARAMS_VECTOR_STEP));
$("#InventoryPreviewParamsOriginYPlus").SetPanelEvent("onactivate", () => adjustInventoryPreviewInput(inventoryPreviewParamsOriginY, INVENTORY_PREVIEW_PARAMS_VECTOR_STEP));
$("#InventoryPreviewParamsOriginZMinus").SetPanelEvent("onactivate", () => adjustInventoryPreviewInput(inventoryPreviewParamsOriginZ, -INVENTORY_PREVIEW_PARAMS_VECTOR_STEP));
$("#InventoryPreviewParamsOriginZPlus").SetPanelEvent("onactivate", () => adjustInventoryPreviewInput(inventoryPreviewParamsOriginZ, INVENTORY_PREVIEW_PARAMS_VECTOR_STEP));
$("#InventoryPreviewParamsLookAtXMinus").SetPanelEvent("onactivate", () => adjustInventoryPreviewInput(inventoryPreviewParamsLookAtX, -INVENTORY_PREVIEW_PARAMS_VECTOR_STEP));
$("#InventoryPreviewParamsLookAtXPlus").SetPanelEvent("onactivate", () => adjustInventoryPreviewInput(inventoryPreviewParamsLookAtX, INVENTORY_PREVIEW_PARAMS_VECTOR_STEP));
$("#InventoryPreviewParamsLookAtYMinus").SetPanelEvent("onactivate", () => adjustInventoryPreviewInput(inventoryPreviewParamsLookAtY, -INVENTORY_PREVIEW_PARAMS_VECTOR_STEP));
$("#InventoryPreviewParamsLookAtYPlus").SetPanelEvent("onactivate", () => adjustInventoryPreviewInput(inventoryPreviewParamsLookAtY, INVENTORY_PREVIEW_PARAMS_VECTOR_STEP));
$("#InventoryPreviewParamsLookAtZMinus").SetPanelEvent("onactivate", () => adjustInventoryPreviewInput(inventoryPreviewParamsLookAtZ, -INVENTORY_PREVIEW_PARAMS_VECTOR_STEP));
$("#InventoryPreviewParamsLookAtZPlus").SetPanelEvent("onactivate", () => adjustInventoryPreviewInput(inventoryPreviewParamsLookAtZ, INVENTORY_PREVIEW_PARAMS_VECTOR_STEP));
$("#InventoryPreviewParamsApplyButton").SetPanelEvent("onactivate", applyCurrentInventoryPreviewParams);
$("#InventoryPreviewParamsCloseButton").SetPanelEvent("onactivate", closeInventoryPreviewParamsTool);
$("#InventoryPreviewParamsBackdrop").SetPanelEvent("onactivate", closeInventoryPreviewParamsTool);
SubscribeAndFireNetTableByKey("items", "list", (_, __, value) => {
    INVENTORY_ITEMS_LIST = (value !== null && value !== void 0 ? value : {});
    if (INVENTORY_LOADED && CurrentSelectedInventoryPage !== undefined) {
        LoadInventoryItemsByPage();
    }
});
SubscribeAndFireNetTableByKey("cases", "state", (_, __, value) => {
    INVENTORY_CASES_STATE = value;
    if (INVENTORY_LOADED && CurrentSelectedInventoryPage === "Cases") {
        LoadInventoryItemsByPage();
    }
});
//@ts-ignore
const currentLocalPlayerData = (_a = CustomNetTables.GetTableValue("players", GetPlayerInfoKey())) !== null && _a !== void 0 ? _a : {};
// $.Msg(`Current local player items: ${JSON.stringify(currentLocalPlayerData, null, "\t")}`)
if (currentLocalPlayerData) {
    HandleInventoryLocalPlayerItemsUpdate(currentLocalPlayerData);
}
CustomNetTables.SubscribeNetTableListener("players", (tableName, key, value) => {
    if (tableName !== "players" || key !== GetPlayerInfoKey()) {
        return;
    }
    HandleInventoryLocalPlayerItemsUpdate(value);
});
function OnLoadInventoryPage() {
    // $.Msg("Inventory OnLoad call.")
    if (INVENTORY_LOADED == true) {
        return;
    }
    INVENTORY_LOADED = true;
    if (CurrentSelectedInventoryPage == undefined) {
        InventoryOpenPage("FXHero");
    }
    else {
        LoadInventoryItemsByPage();
    }
}
$.GetContextPanel().Data().OnLoad = () => OnLoadInventoryPage();
GameUI.OpenCustomInventoryCasesPage = () => {
    if (!INVENTORY_LOADED) {
        OnLoadInventoryPage();
    }
    InventoryOpenPage("Cases", true);
};
$.GetContextPanel().Data().OnShow = () => {
    if (!INVENTORY_LOADED) {
        return;
    }
    if (CurrentSelectedInventoryPage == undefined) {
        InventoryOpenPage("FXHero");
    }
    else {
        InventoryOpenPage(CurrentSelectedInventoryPage, true);
    }
};
$.GetContextPanel().Data().OnUnLoad = () => {
    // $.Msg("Inventory OnUnLoad call.")
    if (INVENTORY_LOADED == false) {
        return;
    }
    INVENTORY_LOADED = false;
    inventoryItemsContainer.RemoveAndDeleteChildren();
};
OnLoadInventoryPage();