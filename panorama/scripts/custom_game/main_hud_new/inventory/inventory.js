--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
var _a;
const inventoryHeaderButtons = $("#HeaderButtons");
const inventoryItemsContainer = $("#ItemsContainer");
const CATEGORY_FILTERS = {
    Title: { slotType: 2, slotName: "title" },
    FXHero: { slotType: 3 },
    FXAttacks: { slotType: 4 },
    TopEffects: { slotType: 6, slotName: "icons" },
};
let INVENTORY_LOADED = false;
//@ts-ignore
let CurrentSelectedPage = undefined;
let INVENTORY_ITEMS_LIST = {};
function GetPlayerInfoKey() {
    return `player_${Players.GetLocalPlayer()}_cosmetic_info`;
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
function InventoryOpenPage(category) {
    $.Msg(`Inventory open page: ${category}`);
    if (CurrentSelectedPage === category) {
        $.Msg(`Inventory already on page: ${category}. Return...`);
        return;
    }
    CurrentSelectedPage = category;
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
    if (!INVENTORY_LOADED || CurrentSelectedPage === undefined) {
        $.Msg(`Inventory loaded: ${INVENTORY_LOADED}, current page: ${CurrentSelectedPage}`);
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
        const categoryFilter = CATEGORY_FILTERS[CurrentSelectedPage];
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
    const panelHeight = 285;
    const height = Math.ceil(itemNames.length / 5) * panelHeight;
    inventoryItemsContainer.style.height = `${height}px`;
    for (const itemName of itemNames) {
        $.Msg(`Loading inventory item: ${itemName}`);
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
        p.SetHasClass("ImagePreview", isImagePreview);
        p.SetHasClass("FxPreview", isFxPreview);
        p.SetHasClass("ScenePreview", isScenePreview);
        p.SetHasClass("VideoPreview", isVideoPreview);
        p.SetHasClass("ChatWheelPreview", isChatWheelPreview);
        p.SetHasClass("HeroIconPreview", isHeroIconPreview);
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
                pPanel.RemoveAndDeleteChildren();
                const previewParams = itemInfo.preview_params || {
                    origin: "0 0 0",
                    look_at: "0 0 0",
                    fov: "60",
                };
                if (pPanel.IsValid()) {
                    $.CreatePanel("DOTAParticleScenePanel", pPanel, "", {
                        class: "PreviewPanelSize",
                        hittest: "false",
                        particleName: itemInfo.preview_value,
                        startActive: "true",
                        particleonly: "false",
                        cameraOrigin: previewParams.origin || "0 0 0",
                        lookAt: previewParams.look_at || "0 0 0",
                        fov: previewParams.fov || "60",
                        squarePixels: "true",
                        drawbackground: "true"
                    });
                }
            }
        }
        else if (isScenePreview) {
            const pPanel = p.FindChildTraverse("ScenePreview");
            if (pPanel) {
                pPanel.RemoveAndDeleteChildren();
                if (pPanel.IsValid()) {
                    $.CreatePanel("DOTAScenePanel", pPanel, "", {
                        class: "PreviewPanelSize",
                        hittest: "false",
                        renderdeferred: "false",
                        antialias: "false",
                        particleonly: "false",
                        drawbackground: "false",
                        light: "light",
                        camera: "camera1",
                        unit: itemInfo.preview_value
                    });
                }
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
function ToggleWearItem(itemName) {
    const localPlayer = Players.GetLocalPlayer();
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
SubscribeAndFireNetTableByKey("items", "list", (_, __, value) => {
    INVENTORY_ITEMS_LIST = (value !== null && value !== void 0 ? value : {});
    if (INVENTORY_LOADED && CurrentSelectedPage !== undefined) {
        LoadInventoryItemsByPage();
    }
});
//@ts-ignore
const currentLocalPlayerData = (_a = CustomNetTables.GetTableValue("players", GetPlayerInfoKey())) !== null && _a !== void 0 ? _a : {};
$.Msg(`Current local player items: ${JSON.stringify(currentLocalPlayerData, null, "\t")}`);
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
    $.Msg("Inventory OnLoad call.");
    if (INVENTORY_LOADED == true) {
        return;
    }
    INVENTORY_LOADED = true;
    if (CurrentSelectedPage == undefined) {
        InventoryOpenPage("FXHero");
    }
    else {
        LoadInventoryItemsByPage();
    }
}
$.GetContextPanel().Data().OnLoad = () => OnLoadInventoryPage();
$.GetContextPanel().Data().OnUnLoad = () => {
    $.Msg("Inventory OnUnLoad call.");
    if (INVENTORY_LOADED == false) {
        return;
    }
    INVENTORY_LOADED = false;
    inventoryItemsContainer.RemoveAndDeleteChildren();
};
OnLoadInventoryPage();