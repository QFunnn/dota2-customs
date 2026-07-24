--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
function GetPlayerStashKey(playerId = currentStashOwnerPID) {
    return `player_${playerId}_bonus_stash_items`;
}
function IsCurrentStashReadOnly() {
    return currentStashOwnerPID !== Players.GetLocalPlayer();
}
function ResolveCurrentStashOwnerPID() {
    if (!FEATURE_SHOW_SELECTED_PLAYER_STASH) {
        return Players.GetLocalPlayer();
    }
    const unit = Players.GetLocalPlayerPortraitUnit();
    if (unit != -1) {
        const owner = Entities.GetPlayerOwnerID(unit);
        if (owner != -1) {
            return owner;
        }
    }
    return Players.GetLocalPlayer();
}
function RefreshCurrentStash(force = false) {
    var _a;
    const nextOwner = ResolveCurrentStashOwnerPID();
    if (!force && nextOwner === currentStashOwnerPID) {
        return;
    }
    currentStashOwnerPID = nextOwner;
    UpdateSlots((_a = CustomNetTables.GetTableValue("players", GetPlayerStashKey(currentStashOwnerPID))) !== null && _a !== void 0 ? _a : {});
}
function OpenBonusStash() {
    BonusStashPanel.SetHasClass("Show", true);
    BonusStashButton.SetHasClass("Show", true);
}
CustomNetTables.SubscribeNetTableListener("players", (name, key, values) => {
    if (key == GetPlayerStashKey(currentStashOwnerPID)) {
        UpdateSlots(values !== null && values !== void 0 ? values : {});
    }
});
function CleanPanel(panel) {
    if (!panel || !panel.IsValid())
        return;
    //@ts-ignore
    panel.SetPanelEvent("onmouseup", () => { });
    panel.SetPanelEvent("onactivate", () => { });
    //@ts-ignore
    panel.SetPanelEvent("onmousedown", () => { });
    for (let i = 0; i < panel.GetChildCount(); i++) {
        const Child = panel.GetChild(i);
        if (Child) {
            CleanPanel(Child);
        }
    }
}
function IsPortraitUnitTempestDouble() {
    const unit = Players.GetLocalPlayerPortraitUnit();
    if (unit == -1) {
        return false;
    }
    try {
        //@ts-ignore
        if (Entities.HasModifier && (Entities.HasModifier(unit, "modifier_arc_warden_tempest_double_lua") || Entities.HasModifier(unit, "modifier_arc_warden_tempest_double_lua_illusion"))) {
            return true;
        }
    }
    catch (e) {
    }
    return false;
}
function ComputeStashSignature(items) {
    let sig = `${currentStashOwnerPID}|`;
    for (let i = 0; i < 12; i++) {
        const info = items[`SLOT_${i}`];
        if (info) {
            const valid = info.item != undefined && Entities.IsValidEntity(info.item) ? 1 : 0;
            sig += `${i}:${info.item_name}:${info.item}:${valid};`;
        }
    }
    return sig;
}
function GetOrCreateFallbackIcon(itemSlot) {
    const existing = itemSlot.FindChild("StashFallbackIcon");
    if (existing) {
        return existing;
    }
    const icon = $.CreatePanel("DOTAItemImage", itemSlot, "StashFallbackIcon", { hittest: false });
    icon.style.width = "100%";
    icon.style.height = "100%";
    icon.style.zIndex = 5;
    return icon;
}
function UpdateSlots(items = {}) {
    var _a;
    const hasItems = Object.keys(items).some((key) => !!items[key]);
    const hadItemsBefore = (_a = stashHasItemsByOwner[currentStashOwnerPID]) !== null && _a !== void 0 ? _a : false;
    lastStashSignature = ComputeStashSignature(items);
    if (currentStashOwnerPID === Players.GetLocalPlayer() && !hadItemsBefore && hasItems) {
        OpenBonusStash();
    }
    stashHasItemsByOwner[currentStashOwnerPID] = hasItems;
    // $.Msg(JSON.stringify(items, null, "\t"))
    for (let i = 0; i < 12; i++) {
        const itemSlot = GetOrCreateSlot(i);
        InitializeCustomSlotHandlers(itemSlot, i);
        itemSlot.FindChildTraverse("HotkeyContainer").style.visibility = "collapse";
        CleanPanel(itemSlot);
        const itemInfo = items[`SLOT_${i}`];
        if (itemInfo) {
            itemSlot.SetPanelEvent("onmouseover", () => {
                $.DispatchEvent("DOTAShowAbilityTooltip", itemSlot, itemInfo.item_name);
            });
            itemSlot.SetPanelEvent("onmouseout", () => {
                $.DispatchEvent("DOTAHideAbilityTooltip", itemSlot);
            });
            const image2 = itemSlot.FindChildTraverse("ItemImage");
            if (image2) {
                image2.SetPanelEvent("onmouseover", () => {
                    $.DispatchEvent("DOTAShowAbilityTooltip", image2, itemInfo.item_name);
                });
                image2.SetPanelEvent("onmouseout", () => {
                    $.DispatchEvent("DOTAHideAbilityTooltip", image2);
                });
            }
            $.Schedule(0.1, function () {
                itemSlot.SetPanelEvent("onmouseover", () => {
                    $.DispatchEvent("DOTAShowAbilityTooltip", itemSlot, itemInfo.item_name);
                });
                itemSlot.SetPanelEvent("onmouseout", () => {
                    $.DispatchEvent("DOTAHideAbilityTooltip", itemSlot);
                });
                const image = itemSlot.FindChildTraverse("ItemImage");
                if (image) {
                    image.SetPanelEvent("onmouseover", () => {
                        $.DispatchEvent("DOTAShowAbilityTooltip", image, itemInfo.item_name);
                    });
                    image.SetPanelEvent("onmouseout", () => {
                        $.DispatchEvent("DOTAHideAbilityTooltip", image);
                    });
                }
            });
            if (itemInfo.item != undefined) {
                itemSlot.contextEntityIndex = Players.GetLocalPlayerPortraitUnit();
                itemSlot.overrideentityindex = itemInfo.item;
            }
            itemSlot.stashItemInfo = itemInfo;
            const fallbackIcon = GetOrCreateFallbackIcon(itemSlot);
            fallbackIcon.itemname = itemInfo.item_name;
            fallbackIcon.visible = !(itemInfo.item != undefined && Entities.IsValidEntity(itemInfo.item));
            $.Schedule(0.01, function () {
                if (itemSlot && itemSlot.IsValid()) {
                    const image = itemSlot.FindChildTraverse("ItemImage");
                    if (image) {
                        image.contextEntityIndex = itemInfo.item;
                    }
                }
            });
            const image = itemSlot.FindChildTraverse("ItemImage");
            if (image) { //@ts-ignore
                image.SetPanelEvent("onmousedown", function () {
                    if (IsCurrentStashReadOnly()) {
                        return;
                    }
                    if (GameUI.IsMouseDown(1)) {
                        $.DispatchEvent("DOTAHideAbilityTooltip", itemSlot);
                        const isInRangeOfShop = Entities.IsInRangeOfShop(Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer()), DOTA_SHOP_TYPE.DOTA_SHOP_HOME, false);
                        const isSellable = Items.IsSellable(itemInfo.item) && isInRangeOfShop;
                        const isShowInShop = Items.IsPurchasable(itemInfo.item);
                        // $.Msg(`ItemName = ${itemInfo.item_name}. IsSell=${isSellable}. IsShow=${isShowInShop}`);
                        if (!isSellable && !isShowInShop) {
                            return;
                        }
                        const contextMenu = $.CreatePanel("ContextMenuScript", $.GetContextPanel(), "");
                        contextMenu.AddClass("ContextMenu_NoArrow");
                        contextMenu.AddClass("ContextMenu_NoBorder");
                        //@ts-ignore
                        contextMenu.GetContentsPanel().Item = itemInfo.item;
                        contextMenu.GetContentsPanel().SetHasClass("bSellable", isSellable);
                        contextMenu.GetContentsPanel().SetHasClass("bShowInShop", isShowInShop);
                        contextMenu.GetContentsPanel().BLoadLayout("file://{resources}/layout/custom_game/extender_stash/custom_item_context_menu.xml", false, false);
                    }
                });
            }
        }
        else {
            itemSlot.contextEntityIndex = -1;
            itemSlot.overrideentityindex = -1;
            itemSlot.stashItemInfo = undefined;
            const fallbackIcon = GetOrCreateFallbackIcon(itemSlot);
            fallbackIcon.visible = false;
            $.Schedule(0.01, function () {
                if (itemSlot && itemSlot.IsValid()) {
                    const image = itemSlot.FindChildTraverse("ItemImage");
                    if (image) {
                        image.contextEntityIndex = -1;
                    }
                }
            });
            itemSlot.SetPanelEvent("onmouseover", () => {
            });
            itemSlot.SetPanelEvent("onmouseout", () => {
            });
            let image = itemSlot.FindChildTraverse("ItemImage");
            if (image) {
                image.SetPanelEvent("onmouseover", () => {
                });
                image.SetPanelEvent("onmouseout", () => {
                });
            }
        }
    }
}
function InitializeCustomSlotHandlers(itemSlot, slotIndex) {
    itemSlot.stashSlotIndex = slotIndex;
    if (itemSlot.stashHandlersInitialized) {
        return;
    }
    itemSlot.stashHandlersInitialized = true;
    $.RegisterEventHandler('DragStart', itemSlot, function (a, dragCallbacks) {
        const itemInfo = itemSlot.stashItemInfo;
        if (!itemInfo || IsCurrentStashReadOnly()) {
            return false;
        }
        $.DispatchEvent("DOTAHideAbilityTooltip", itemSlot);
        itemSlot.AddClass("dragging_from");
        const panel = $.CreatePanel("DOTAItemImage", $.GetContextPanel(), "", { class: "DragImage", itemname: itemInfo.item_name });
        panel.contextEntityIndex = itemInfo.item;
        panel.is_from_custom = true;
        dragCallbacks.displayPanel = panel;
        dragCallbacks.offsetX = 0;
        dragCallbacks.offsetY = 0;
        return true;
    });
    $.RegisterEventHandler('DragEnd', itemSlot, function (a, draggedPanel) {
        itemSlot.RemoveClass("dragging_from");
        SafeDeleteAsync(draggedPanel);
        return true;
    });
    $.RegisterEventHandler('DragDrop', itemSlot, function (a, draggedPanel) {
        if (IsCurrentStashReadOnly()) {
            return true;
        }
        const abilityIndex = draggedPanel.contextEntityIndex;
        if (abilityIndex >= 0) {
            if (Entities.IsControllableByPlayer(Players.GetLocalPlayerPortraitUnit(), Players.GetLocalPlayer()) && !IsPortraitUnitTempestDouble()) {
                GameEvents.SendCustomGameEventToServer("items_move_to_custom_stash", { source: Players.GetLocalPlayerPortraitUnit(), item: abilityIndex, slot: "SLOT_" + itemSlot.stashSlotIndex });
            }
        }
        return true;
    });
    $.RegisterEventHandler('DragEnter', itemSlot, function (a, draggedPanel) {
        itemSlot.AddClass("potential_drop_target");
        return true;
    });
    $.RegisterEventHandler('DragLeave', itemSlot, function (a, draggedPanel) {
        itemSlot.RemoveClass("potential_drop_target");
        return true;
    });
}
function UpdateAllDOTASlots() {
    let itemsPanelList = Inventory.FindChildrenWithClassTraverse("InventoryItem");
    itemsPanelList = itemsPanelList.concat(RightItems.FindChildrenWithClassTraverse("InventoryItem"));
    itemsPanelList = itemsPanelList.concat(StashDota.FindChildrenWithClassTraverse("InventoryItem"));
    for (const itemSlot of itemsPanelList) {
        if (itemSlot.id == "inventory_tpscroll_slot" || itemSlot.id == "inventory_neutral_slot")
            continue;
        $.RegisterEventHandler('DragEnter', itemSlot, function (a, draggedPanel) {
            if (draggedPanel.is_from_custom) {
                itemSlot.AddClass("potential_drop_target");
            }
        });
        $.RegisterEventHandler('DragLeave', itemSlot, function (a, draggedPanel) {
            if (draggedPanel.is_from_custom) {
                itemSlot.RemoveClass("potential_drop_target");
            }
        });
        //@ts-ignore
        $.RegisterEventHandler('DragDrop', itemSlot, MoveItemFromCustomStash);
    }
}
function MoveItemFromCustomStash(targetPanel, draggedPanel) {
    if (IsCurrentStashReadOnly()) {
        return;
    }
    if (draggedPanel.is_from_custom) {
        const abilityIndex = draggedPanel.contextEntityIndex;
        const inventorySlotPanel = GetInventorySlotPanel(targetPanel);
        let slot = undefined;
        if (inventorySlotPanel != null) {
            slot = inventorySlotPanel.id.replace("inventory_slot_", "");
            if (slot && parseInt(slot) != undefined) {
                const s = inventorySlotPanel.GetParent();
                if (s != null && s.id == "stash_row") {
                    slot = 9 + parseInt(slot);
                }
                else {
                    slot = parseInt(slot);
                }
            }
        }
        if (abilityIndex >= 0) {
            if (Entities.IsControllableByPlayer(Players.GetLocalPlayerPortraitUnit(), Players.GetLocalPlayer()) && !IsPortraitUnitTempestDouble()) {
                GameEvents.SendCustomGameEventToServer("items_move_from_custom_stash", { source: Players.GetLocalPlayerPortraitUnit(), item: abilityIndex, slot: slot });
            }
        }
    }
}
function GetOrCreateSlot(slotNum) {
    const panel = stash.FindChildTraverse(`SLOT_${slotNum}`);
    if (panel) {
        return panel;
    }
    else {
        return $.CreatePanel("DOTAAbilityPanel", stash, `SLOT_${slotNum}`, {
            class: "InventoryItem Stash AbilityMaxLevel0 no_level",
            hittest: true,
            draggable: true
        });
    }
}
function GetInventorySlotPanel(panel) {
    while (panel != undefined && panel.type != "DOTAAbilityPanel") {
        panel = panel.GetParent();
    }
    return panel;
}
function UpdateSpecialSlots() {
    RefreshCurrentStash();
    const unit = Players.GetLocalPlayerPortraitUnit();
    if (unit != -1) {
        let bHasAbility = Entities.GetAbilityByName(unit, "techies_spoons_stash_custom");
        if (bHasAbility != -1) {
            ManipulateOverInventory(true);
        }
        else {
            ManipulateOverInventory(false);
        }
    }
    else {
        ManipulateOverInventory(false);
    }
}
function ManipulateOverInventory(isChangeSlots) {
    let slots = [];
    slots.push(Inventory.FindChildTraverse("inventory_slot_6"));
    slots.push(Inventory.FindChildTraverse("inventory_slot_7"));
    $.Schedule(0.01, function () {
        for (const slot of slots) {
            if (!slot || !slot.IsValid())
                continue;
            if (isChangeSlots) {
                slot.RemoveClass("BackpackSlot");
                slot.style.width = "60px";
                slot.style.height = "34px";
                slot.style.marginLeft = "3px";
                slot.style.marginRight = "3px";
                slot.style.borderBottom = "1px solid #ffffff06";
                slot.style.horizontalAlign = "right";
                slot.style.transform = "translateX(-4px)";
                const ButtonWell = slot.FindChildTraverse("ButtonWell");
                if (ButtonWell) {
                    ButtonWell.style.backgroundImage = `none`;
                    // ButtonWell.style.boxShadow = `inset #000 -1px 1px 8px`
                }
                const ButtonSize = slot.FindChildTraverse("ButtonSize");
                if (ButtonSize) {
                    ButtonSize.style.margin = "0px 0px 0px 0px";
                    ButtonSize.style.backgroundImage = `url("s2r://panorama/images/hud/reborn/bg_backpack_psd.vtex")`;
                    // ButtonSize.style.boxShadow = `inset #000000aa 0px 2px 16px 0px`
                }
                const AbilityBevel = slot.FindChildTraverse("AbilityBevel");
                if (AbilityBevel) {
                    AbilityBevel.style.backgroundImage = `none`;
                }
                const AbilityButton = slot.FindChildTraverse("AbilityButton");
                if (AbilityButton) {
                    AbilityButton.style.saturation = `1`;
                    AbilityButton.style.brightness = `1`;
                    AbilityButton.style.contrast = `1`;
                }
                const Hotkey = slot.FindChildTraverse("HotkeyContainer");
                if (Hotkey) {
                    Hotkey.style.visibility = "collapse";
                }
            }
            else {
                slot.AddClass("BackpackSlot");
                const AbilityButton = slot.FindChildTraverse("AbilityButton");
                if (AbilityButton) {
                    AbilityButton.style.saturation = `0`;
                    AbilityButton.style.brightness = `0.6`;
                    AbilityButton.style.contrast = `0.95`;
                }
            }
        }
    });
}
function AlignStash() {
    const isHudFlipped = Game.IsHUDFlipped();
    BonusStashPanel.SetHasClass("Flip", isHudFlipped);
    BonusStashButton.SetHasClass("Flip", isHudFlipped);
    bonusStashButtonIcon.SetHasClass("Flip", isHudFlipped);
    bonusStashButtonLabel.SetHasClass("Flip", isHudFlipped);
    infoButton.SetHasClass("Flip", isHudFlipped);
    BonusStashButton.MoveChildBefore(isHudFlipped ? bonusStashButtonLabel : bonusStashButtonIcon, isHudFlipped ? bonusStashButtonIcon : bonusStashButtonLabel);
}
const DotaHUDHUD = findElement("Hud");
const Inventory = DotaHUDHUD.FindChildTraverse("inventory");
const RightItems = DotaHUDHUD.FindChildTraverse("inventory_composition_layer_container");
const StashDota = DotaHUDHUD.FindChildTraverse("stash_row");
const BonusStashPanel = $("#BonusStashPanel");
const BonusStashButton = $("#BonusStashButton");
const bonusStashButtonLabel = BonusStashButton.FindChild("BonusStashButtonLabel");
const bonusStashButtonIcon = BonusStashButton.FindChild("BonusStashButtonIcon");
const infoButton = BonusStashPanel.FindChild("InfoButton");
//Фича переключения. Надо ли отображать чужие тайники
const FEATURE_SHOW_SELECTED_PLAYER_STASH = true;
let handlers = {};
let isStarted = false;
let currentStashOwnerPID = Players.GetLocalPlayer();
let stashHasItemsByOwner = {};
let lastStashSignature = "";
const stash = $("#stash");
$.GetContextPanel().SetParent(FindDotaHudElement("HUDElements"));
RefreshCurrentStash(true);
UpdateAllDOTASlots();
GameEvents.SubscribeUnprotected('dota_player_update_selected_unit', UpdateSpecialSlots);
GameUI.ToggleStash = () => {
    AlignStash();
    BonusStashPanel.ToggleClass("Show");
    BonusStashButton.ToggleClass("Show");
};
function StashWatchdogTick() {
    var _a;
    const resolvedOwner = ResolveCurrentStashOwnerPID();
    if (resolvedOwner !== currentStashOwnerPID) {
        currentStashOwnerPID = resolvedOwner;
    }
    const items = (_a = CustomNetTables.GetTableValue("players", GetPlayerStashKey(currentStashOwnerPID))) !== null && _a !== void 0 ? _a : {};
    const sig = ComputeStashSignature(items);
    if (sig !== lastStashSignature) {
        UpdateSlots(items);
    }
    $.Schedule(1.0, StashWatchdogTick);
}
StashWatchdogTick();