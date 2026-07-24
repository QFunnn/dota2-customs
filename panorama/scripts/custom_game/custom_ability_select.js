--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
const ability_select_state = Object.freeze({
    none: 0,
    add: 1,
    remove: 2,
    hide: 3,
});
const reorder_types = Object.freeze({
    after: 1,
    before: 2,
});
const ABILITY_BAR_GAP = 54;
const FALLBACK_BAR_OFFSET_FROM_BOTTOM = 130;
const DRAG_OFFSET = 10;
const REORDER_HEADER_OFFSET = 60;
const localizableTokens = {
    close: "#HUD_AbilitySelect_Close",
    random: "#HUD_AbilitySelect_Random",
    hideSelect: "#HUD_AbilitySelect_HideSelect",
    unhideSelect: "#HUD_AbilitySelect_UnhideSelect",
    makeYourChoiceAbility: "#HUD_AbilitySelect_SelectNewAbility",
    selectAbilityToRemove: "#HUD_AbilitySelect_SelectAbilityToRemove",
};
let replace_mode = false;
let replace_action = ability_select_state.none;
let add_select_mode = false;
let add_select_collapsed = false;
let add_select_ability_list = [];
let replace_select_ability_list = [];
let last_replace_state = ability_select_state.none;
let reorder_mode = false;
let reorder_swap_ui_secret;
let blocked_replace_abilities = {};
let replace_allowed_abilities = {};
let replace_allowed_initialized = false;
let abilities_panel;
let inventory_panel;
let ability_replace_prompt;
let ability_replace_prompt_text;
let ability_replace_cancel_button;
let ability_select_dock;
let ability_select_title;
let ability_select_rows = [];
let ability_select_show_button;
let ability_select_hide_button;
let ability_select_random_button;
let ability_select_random_icon;
let ability_select_dock_position = "bottom";
let ability_replace_select_mode = "hero_panel";
let draggable_delimiter;
let reorder_active_overlay;
let overlay_base;
let draggable_initialized = false;
let replace_reinit_token = 0;
let reorder_mouse_callback_set = false;
let selected_unit_poll_token = 0;
let last_polled_portrait_unit = -1;
function IsBlockedForReplace(abilityName) {
    if (replace_mode && replace_allowed_initialized) {
        return !replace_allowed_abilities[abilityName];
    }
    return !!blocked_replace_abilities[abilityName];
}
function EnsureHudRefs() {
    if (!abilities_panel || !abilities_panel.IsValid()) {
        abilities_panel = FindDotaHudElement("abilities") || undefined;
    }
    return !!abilities_panel;
}
function EnsureInventoryRef() {
    if (!inventory_panel || !inventory_panel.IsValid()) {
        inventory_panel = FindDotaHudElement("inventory") || undefined;
    }
    return !!inventory_panel;
}
function EnsureOverlayBaseRef() {
    if (!overlay_base || !overlay_base.IsValid()) {
        overlay_base = FindDotaHudElement("AbilitiesAndStatBranch") || undefined;
    }
    return !!overlay_base;
}
function IsLocalHeroSelected() {
    return Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer()) === Players.GetLocalPlayerPortraitUnit();
}
function ShouldPollSelectedUnit() {
    return replace_mode || reorder_mode;
}
function StopSelectedUnitPoll() {
    selected_unit_poll_token += 1;
    last_polled_portrait_unit = -1;
}
function StartSelectedUnitPoll() {
    if (!ShouldPollSelectedUnit()) {
        StopSelectedUnitPoll();
        return;
    }
    selected_unit_poll_token += 1;
    const currentToken = selected_unit_poll_token;
    last_polled_portrait_unit = Players.GetLocalPlayerPortraitUnit();
    const tick = () => {
        if (currentToken !== selected_unit_poll_token || !ShouldPollSelectedUnit()) {
            return;
        }
        const portraitUnit = Players.GetLocalPlayerPortraitUnit();
        if (portraitUnit !== last_polled_portrait_unit) {
            last_polled_portrait_unit = portraitUnit;
            RebuildCovers();
        }
        $.Schedule(0.1, tick);
    };
    $.Schedule(0.1, tick);
}
function RefreshSelectedUnitPoll() {
    if (ShouldPollSelectedUnit()) {
        StartSelectedUnitPoll();
        return;
    }
    StopSelectedUnitPoll();
}
function GetAbsoluteY(panel) {
    var _a;
    let y = 0;
    let cur = panel;
    const rootParent = $.GetContextPanel().GetParent();
    while (cur && cur !== rootParent) {
        const scale = cur.actualuiscale_y || 1;
        y += (cur.actualyoffset || 0) / scale;
        cur = (_a = cur.GetParent()) !== null && _a !== void 0 ? _a : undefined;
    }
    return y;
}
function GetAbilityBarTopY(fallbackY) {
    if (!EnsureInventoryRef() || ((inventory_panel === null || inventory_panel === void 0 ? void 0 : inventory_panel.actuallayoutheight) || 0) <= 0) {
        return fallbackY;
    }
    const top = GetAbsoluteY(inventory_panel);
    return top > 0 ? top : fallbackY;
}
function ComputeAnchorMarginBottom() {
    const ctx = $.GetContextPanel();
    const scaleY = ctx.actualuiscale_y || 1;
    const screenH = ctx.actuallayoutheight / scaleY;
    const abilityBarTop = GetAbilityBarTopY(screenH - FALLBACK_BAR_OFFSET_FROM_BOTTOM);
    const anchorY = abilityBarTop - ABILITY_BAR_GAP;
    return `${screenH - anchorY}px`;
}
function PositionReplacePrompt() {
    if (!ability_replace_prompt || !ability_replace_prompt.visible) {
        return;
    }
    ability_replace_prompt.style.marginBottom = ComputeAnchorMarginBottom();
}
function PositionAbilitySelectDock() {
    EnsureAbilitySelectDock();
    const marginBottom = ComputeAnchorMarginBottom();
    const dock = ability_select_dock;
    const showButton = ability_select_show_button;
    if (ability_select_dock_position === "top") {
        dock.style.verticalAlign = "top";
        dock.style.marginTop = "60px";
        dock.style.marginBottom = "0px";
        showButton.style.verticalAlign = "top";
        showButton.style.marginTop = "60px";
        showButton.style.marginBottom = "0px";
        return;
    }
    if (ability_select_dock_position === "center") {
        dock.style.verticalAlign = "center";
        dock.style.marginTop = "0px";
        dock.style.marginBottom = "0px";
        showButton.style.verticalAlign = "center";
        showButton.style.marginTop = "0px";
        showButton.style.marginBottom = "0px";
        return;
    }
    dock.style.verticalAlign = "bottom";
    dock.style.marginTop = "0px";
    dock.style.marginBottom = marginBottom;
    showButton.style.verticalAlign = "bottom";
    showButton.style.marginTop = "0px";
    showButton.style.marginBottom = marginBottom;
}
function NormalizeAbilitySelectDockPosition(position) {
    return position === "top" || position === "center" || position === "bottom" ? position : "bottom";
}
function SetAbilitySelectDockPosition(position) {
    ability_select_dock_position = NormalizeAbilitySelectDockPosition(position);
    GameUI.abilitySelectDockPosition = ability_select_dock_position;
    PositionAbilitySelectDock();
}
function NormalizeAbilityReplaceSelectMode(mode) {
    return mode === "select_window" ? "select_window" : "hero_panel";
}
function SetAbilityReplaceSelectMode(mode) {
    ability_replace_select_mode = NormalizeAbilityReplaceSelectMode(mode);
    GameUI.abilityReplaceSelectMode = ability_replace_select_mode;
    UpdateAbilitySelectDock();
    UpdateReplacePrompt();
    if (EnsureHudRefs()) {
        RebuildCovers();
    }
}
function IsReplaceSelectionInDock() {
    return replace_mode && ability_replace_select_mode === "select_window";
}
function GetLocalPlayerSettingsKey() {
    return String(getSteamId32(Players.GetLocalPlayer()));
}
function ApplyAbilitySelectSettingsFromSettings() {
    const settings = CustomNetTables.GetTableValue("player_settings", GetLocalPlayerSettingsKey());
    const position = NormalizeAbilitySelectDockPosition((settings === null || settings === void 0 ? void 0 : settings.abilitySelectPosition) || GameUI.abilitySelectDockPosition);
    const replaceSelectMode = NormalizeAbilityReplaceSelectMode((settings === null || settings === void 0 ? void 0 : settings.abilityReplaceSelectMode) || GameUI.abilityReplaceSelectMode);
    SetAbilitySelectDockPosition(position);
    SetAbilityReplaceSelectMode(replaceSelectMode);
}
function OnPlayerSettingsChanged(tableName, key) {
    if (tableName !== "player_settings" || key !== GetLocalPlayerSettingsKey()) {
        return;
    }
    ApplyAbilitySelectSettingsFromSettings();
}
function EnsureDragDescriptionOverlay() {
    if (!reorder_active_overlay || !reorder_active_overlay.IsValid()) {
        reorder_active_overlay = $("#drag_desc_container") || undefined;
    }
    if (reorder_active_overlay) {
        reorder_active_overlay.visible = reorder_mode;
    }
}
function EnsureDraggableDelimiter() {
    if (draggable_delimiter && draggable_delimiter.IsValid()) {
        return;
    }
    draggable_delimiter = $.CreatePanel("Panel", $.GetContextPanel(), "DraggableDelimiter");
    draggable_delimiter.visible = false;
}
function EnsureReorderToggleButton() {
    if (FindDotaHudElement("ReorderToggler")) {
        return;
    }
    const portraitPanel = FindDotaHudElement("portraitHUD");
    if (!portraitPanel) {
        $.Schedule(0.2, EnsureReorderToggleButton);
        return;
    }
    const toggler = $.CreatePanel("Image", portraitPanel, "ReorderToggler");
    toggler.hittest = true;
    toggler.style.width = "24px";
    toggler.style.height = "24px";
    toggler.style.margin = "0px 0px 35px 20px";
    toggler.style.verticalAlign = "bottom";
    toggler.style.horizontalAlign = "left";
    toggler.SetImage("file://{images}/control_icons/24px/shuffle.vsvg");
    toggler.SetPanelEvent("onmouseover", () => {
        toggler.style.brightness = "2";
        toggler.style.transform = "scaleX(1.1) scaleY(1.1)";
    });
    toggler.SetPanelEvent("onmouseout", () => {
        toggler.style.brightness = "1";
        toggler.style.transform = "scaleX(1) scaleY(1)";
    });
    toggler.SetPanelEvent("onactivate", () => ToggleAbilitiesReorder());
}
function DisableReorderMode() {
    if (!reorder_mode) {
        return;
    }
    ToggleAbilitiesReorder({ state: false });
}
function EnsureReorderInterruptHook() {
    if (!reorder_mouse_callback_set) {
        GameUI.SetMouseCallback((eventName, value) => {
            if (!reorder_mode || eventName !== "pressed") {
                return false;
            }
            const button = value;
            const behavior = GameUI.GetClickBehaviors();
            if (button === 1) {
                DisableReorderMode();
                return false;
            }
            if (button === 0 &&
                behavior !== CLICK_BEHAVIORS.DOTA_CLICK_BEHAVIOR_NONE &&
                behavior !== CLICK_BEHAVIORS.DOTA_CLICK_BEHAVIOR_DRAG) {
                DisableReorderMode();
            }
            return false;
        });
        reorder_mouse_callback_set = true;
    }
}
function EnsureReplacePrompt() {
    if (ability_replace_prompt) {
        return;
    }
    ability_replace_prompt = $.CreatePanel("Panel", $.GetContextPanel(), "AbilityReplacePrompt");
    ability_replace_prompt.visible = false;
    ability_replace_prompt_text = $.CreatePanel("Label", ability_replace_prompt, "AbilityReplacePromptText");
    ability_replace_cancel_button = $.CreatePanel("TextButton", ability_replace_prompt, "AbilityReplaceCancelButton");
    ability_replace_cancel_button.text = $.Localize(localizableTokens.close);
    ability_replace_cancel_button.SetPanelEvent("onactivate", CancelReplaceModeSelection);
}
function EnsureAbilitySelectDock() {
    if (ability_select_dock) {
        return;
    }
    ability_select_dock = $.CreatePanel("Panel", $.GetContextPanel(), "AbilitySelectDock");
    ability_select_dock.hittest = true;
    ability_select_dock.visible = false;
    const header = $.CreatePanel("Panel", ability_select_dock, "AbilitySelectDockHeader");
    const hideButton = $.CreatePanel("Panel", header, "AbilitySelectDockHide");
    ability_select_hide_button = hideButton;
    hideButton.AddClass("AbilitySelectHeaderButton");
    hideButton.hittest = true;
    hideButton.SetPanelEvent("onactivate", HideAbilitySelectDock);
    hideButton.SetPanelEvent("onmouseover", () => {
        $.DispatchEvent("DOTAShowTextTooltip", hideButton, $.Localize(localizableTokens.hideSelect));
    });
    hideButton.SetPanelEvent("onmouseout", () => {
        $.DispatchEvent("DOTAHideTextTooltip", hideButton);
    });
    $.CreatePanel("Panel", hideButton, "AbilitySelectDockHideIcon").AddClass("AbilitySelectIcon");
    $.CreatePanel("Panel", hideButton, "AbilitySelectDockHideSlash").AddClass("AbilitySelectIconSlash");
    const titleMid = $.CreatePanel("Panel", header, "AbilitySelectDockTitleMid");
    $.CreatePanel("Panel", titleMid, "").AddClass("AbilitySelectTitleLine");
    $.CreatePanel("Panel", titleMid, "").AddClass("AbilitySelectTitleGap");
    ability_select_title = $.CreatePanel("Label", titleMid, "AbilitySelectDockTitle");
    $.CreatePanel("Panel", titleMid, "").AddClass("AbilitySelectTitleGap");
    $.CreatePanel("Panel", titleMid, "").AddClass("AbilitySelectTitleLine");
    const randomButton = $.CreatePanel("Panel", header, "AbilitySelectRandomButton");
    ability_select_random_button = randomButton;
    randomButton.AddClass("AbilitySelectHeaderButton");
    randomButton.hittest = true;
    randomButton.SetPanelEvent("onactivate", CloseAddSelection);
    randomButton.SetPanelEvent("onmouseover", () => {
        $.DispatchEvent("DOTAShowTextTooltip", randomButton, $.Localize(localizableTokens.random));
    });
    randomButton.SetPanelEvent("onmouseout", () => {
        $.DispatchEvent("DOTAHideTextTooltip", randomButton);
    });
    ability_select_random_icon = $.CreatePanel("Image", randomButton, "AbilitySelectRandomIcon");
    ability_select_random_icon.AddClass("AbilitySelectIcon");
    ability_select_random_icon.SetImage("s2r://panorama/images/control_icons/random_dice_psd.vtex");
    const body = $.CreatePanel("Panel", ability_select_dock, "AbilitySelectDockBody");
    const list = $.CreatePanel("Panel", body, "AbilitySelectDockList");
    const rowTop = $.CreatePanel("Panel", list, "AbilitySelectRowTop");
    rowTop.AddClass("AbilitySelectRow");
    const rowBottom = $.CreatePanel("Panel", list, "AbilitySelectRowBottom");
    rowBottom.AddClass("AbilitySelectRow");
    ability_select_rows = [rowTop, rowBottom];
    ability_select_show_button = $.CreatePanel("Panel", $.GetContextPanel(), "AbilitySelectShowButton");
    ability_select_show_button.hittest = true;
    ability_select_show_button.visible = false;
    ability_select_show_button.SetPanelEvent("onactivate", ShowAbilitySelectDock);
    ability_select_show_button.SetAcceptsFocus(true);
    const showIcon = $.CreatePanel("Image", ability_select_show_button, "AbilitySelectShowIcon");
    showIcon.SetImage("s2r://panorama/images/control_icons/eye_png.vtex");
    const showLabel = $.CreatePanel("Label", ability_select_show_button, "AbilitySelectShowLabel");
    showLabel.text = $.Localize(localizableTokens.unhideSelect);
}
function CreateAbilitySelectCard(parent, abilityName) {
    const card = $.CreatePanel("Panel", parent, "");
    card.AddClass("AbilitySelectCard");
    card.hittest = true;
    card.SetPanelEvent("onactivate", () => OnAbilitySelectCardActivate(abilityName));
    card.SetPanelEvent("onmouseover", () => {
        $.DispatchEvent("DOTAShowAbilityTooltip", card, abilityName);
    });
    card.SetPanelEvent("onmouseout", () => {
        $.DispatchEvent("DOTAHideAbilityTooltip");
    });
    const iconWrap = $.CreatePanel("Panel", card, "");
    iconWrap.AddClass("AbilitySelectCardIconWrap");
    const mainIcon = $.CreatePanel("DOTAAbilityImage", iconWrap, "");
    mainIcon.AddClass("AbilitySelectCardIcon");
    mainIcon.abilityname = abilityName;
    const label = $.CreatePanel("Label", card, "");
    label.AddClass("AbilitySelectCardLabel");
    label.text = $.Localize("#DOTA_Tooltip_ability_" + abilityName);
}
function RenderAbilitySelectCards() {
    EnsureAbilitySelectDock();
    ability_select_rows.forEach((column) => column.RemoveAndDeleteChildren());
    const replaceSelectionInDock = IsReplaceSelectionInDock();
    const distribution = replaceSelectionInDock ? [6] : [5, 5];
    const list = (IsReplaceSelectionInDock()
        ? replace_select_ability_list.filter((abilityName) => !IsBlockedForReplace(abilityName))
        : add_select_ability_list).slice(0, replaceSelectionInDock ? 6 : 10);
    let idx = 0;
    ability_select_rows.forEach((row, index) => {
        row.visible = index < distribution.length;
    });
    for (let colIdx = 0; colIdx < distribution.length; colIdx++) {
        const col = ability_select_rows[colIdx];
        for (let i = 0; i < distribution[colIdx] && idx < list.length; i++, idx++) {
            CreateAbilitySelectCard(col, list[idx]);
        }
    }
}
function UpdateAbilitySelectDock() {
    EnsureAbilitySelectDock();
    const replaceSelectionInDock = IsReplaceSelectionInDock();
    const hasDockMode = add_select_mode || replaceSelectionInDock;
    const visibleDock = hasDockMode && !add_select_collapsed;
    const dock = ability_select_dock;
    const showButton = ability_select_show_button;
    dock.visible = visibleDock;
    showButton.visible = hasDockMode && add_select_collapsed;
    if (ability_select_hide_button) {
        ability_select_hide_button.visible = hasDockMode;
    }
    if (ability_select_random_button) {
        ability_select_random_button.visible = hasDockMode;
        ability_select_random_button.SetPanelEvent("onactivate", replaceSelectionInDock ? CancelReplaceModeSelection : CloseAddSelection);
        ability_select_random_button.SetPanelEvent("onmouseover", () => {
            $.DispatchEvent("DOTAShowTextTooltip", ability_select_random_button, $.Localize(replaceSelectionInDock ? localizableTokens.close : localizableTokens.random));
        });
    }
    if (ability_select_random_icon) {
        ability_select_random_icon.SetImage(replaceSelectionInDock
            ? "s2r://panorama/images/control_icons/x_close_png.vtex"
            : "s2r://panorama/images/control_icons/random_dice_psd.vtex");
    }
    if (!add_select_mode && !replaceSelectionInDock) {
        return;
    }
    const title = ability_select_title;
    title.text = $.Localize(replaceSelectionInDock ? localizableTokens.selectAbilityToRemove : localizableTokens.makeYourChoiceAbility);
    if (visibleDock) {
        RenderAbilitySelectCards();
        $.Schedule(0.0, PositionAbilitySelectDock);
        $.Schedule(0.05, PositionAbilitySelectDock);
        $.Schedule(0.15, PositionAbilitySelectDock);
        $.Schedule(0.35, PositionAbilitySelectDock);
    }
    else {
        $.Schedule(0.0, PositionAbilitySelectDock);
        $.Schedule(0.1, PositionAbilitySelectDock);
    }
}
function UpdateReplacePrompt() {
    EnsureReplacePrompt();
    const prompt = ability_replace_prompt;
    prompt.visible = replace_mode && !IsReplaceSelectionInDock();
    if (!replace_mode || IsReplaceSelectionInDock()) {
        return;
    }
    const promptText = ability_replace_prompt_text;
    promptText.text = $.Localize(localizableTokens.selectAbilityToRemove);
    PositionReplacePrompt();
    $.Schedule(0.0, PositionReplacePrompt);
    $.Schedule(0.1, PositionReplacePrompt);
}
// ====== Cover system =================================================
function _GetAbilityButton(ability_panel) {
    var _a;
    if (!ability_panel) {
        return undefined;
    }
    return (_a = ability_panel.FindChildTraverse("AbilityButton")) !== null && _a !== void 0 ? _a : undefined;
}
function _GetAbilityCoverAnchor(ability_panel) {
    var _a;
    if (!ability_panel) {
        return undefined;
    }
    return (_a = ability_panel.FindChildTraverse("ButtonWell")) !== null && _a !== void 0 ? _a : _GetAbilityButton(ability_panel);
}
function _GetAbilityParams(ability_panel) {
    const ability_button = _GetAbilityButton(ability_panel);
    if (!ability_button || ability_button.GetChildCount() <= 0) {
        return undefined;
    }
    const ability_image = ability_button.GetChild(0);
    if (!ability_image) {
        return undefined;
    }
    return {
        index: ability_image.contextEntityIndex,
        name: ability_image.abilityname,
        id: ability_image.abilityid,
    };
}
function _GetVisibleChildren(children) {
    return children.filter((panel) => !panel.BHasClass("Hidden") && !!_GetAbilityCoverAnchor(panel));
}
function GetCoverPanel(coverName) {
    let coverPanel = $("#" + coverName);
    if (!coverPanel) {
        coverPanel = $.CreatePanel("Panel", $.GetContextPanel(), coverName);
        coverPanel.SetHasClass("Cover", true);
        coverPanel.BLoadLayoutSnippet("draggable_overlay");
        coverPanel.hittest = true;
        coverPanel.SetAcceptsFocus(true);
        coverPanel.SetDisableFocusOnMouseDown(false);
        coverPanel.SetPanelEvent("onactivate", () => OnCoverActivate(coverPanel));
    }
    if (!coverPanel.drag_events_set) {
        $.RegisterEventHandler("DragStart", coverPanel, OnDragStart);
        $.RegisterEventHandler("DragEnd", coverPanel, OnDragEnd);
        coverPanel.drag_events_set = true;
    }
    return coverPanel;
}
function PositionCoverFromPanel(target, src) {
    const initialPosition = src.GetPositionWithinWindow();
    const xPos = initialPosition.x / (src.actualuiscale_x || 1);
    const yPos = initialPosition.y / (src.actualuiscale_y || 1);
    target.style.position = `${xPos}px ${yPos}px 0px`;
}
function ResetCoverPanels() {
    $.Each($.GetContextPanel().Children(), function (child) {
        if (!child ||
            child.id === "AbilityReplacePrompt" ||
            child.id === "AbilitySelectDock" ||
            child.id === "AbilitySelectShowButton" ||
            child.id === "DraggableDelimiter" ||
            child.id === "drag_desc_container") {
            return;
        }
        if (child.BHasClass("Cover")) {
            child.DeleteAsync(0);
        }
    });
}
function PositionReorderOverlay() {
    if (!reorder_active_overlay || !EnsureOverlayBaseRef()) {
        return;
    }
    const overlayAnchor = overlay_base;
    PositionCoverFromPanel(reorder_active_overlay, overlayAnchor);
    const xPos = overlayAnchor.GetPositionWithinWindow().x / (overlayAnchor.actualuiscale_x || 1) + REORDER_HEADER_OFFSET;
    const yPos = overlayAnchor.GetPositionWithinWindow().y / (overlayAnchor.actualuiscale_y || 1) + overlayAnchor.actuallayoutheight / 4 + 4;
    reorder_active_overlay.style.position = `${xPos}px ${yPos}px 0px`;
    reorder_active_overlay.style.width = `${overlayAnchor.actuallayoutwidth / overlayAnchor.actualuiscale_x - REORDER_HEADER_OFFSET}px`;
    reorder_active_overlay.style.height = `${overlayAnchor.actuallayoutheight / 4 / overlayAnchor.actualuiscale_y}px`;
}
function RebuildCovers(keys) {
    if ((keys === null || keys === void 0 ? void 0 : keys.swap_ui_secret) !== undefined) {
        reorder_swap_ui_secret = keys.swap_ui_secret;
    }
    if (!EnsureHudRefs()) {
        return;
    }
    EnsureDragDescriptionOverlay();
    const children = abilities_panel.Children();
    const coversAllowed = IsLocalHeroSelected();
    const visibleChildren = _GetVisibleChildren(children);
    $.Each(visibleChildren, function (child, index) {
        const coverPanel = GetCoverPanel(`AbilityCover_${index}`);
        const abilityAnchor = _GetAbilityCoverAnchor(child);
        if (!abilityAnchor) {
            coverPanel.ability_params = undefined;
            coverPanel.visible = false;
            return;
        }
        coverPanel.style.width = `${abilityAnchor.actuallayoutwidth / child.actualuiscale_x}px`;
        coverPanel.style.height = `${abilityAnchor.actuallayoutheight / child.actualuiscale_y}px`;
        PositionCoverFromPanel(coverPanel, abilityAnchor);
        const abilityChild = child;
        abilityChild.ability_params = _GetAbilityParams(child);
        if (!abilityChild.ability_params || !abilityChild.ability_params.name) {
            coverPanel.ability_params = undefined;
            coverPanel.visible = false;
            return;
        }
        coverPanel.ability_params = abilityChild.ability_params;
        const replaceSelectionOnHeroPanel = replace_mode && !IsReplaceSelectionInDock();
        const isBlocked = replaceSelectionOnHeroPanel && IsBlockedForReplace(abilityChild.ability_params.name);
        const reorderEnabled = reorder_mode && !replace_mode;
        const coverVisible = coversAllowed && (reorderEnabled || (replaceSelectionOnHeroPanel && !isBlocked));
        coverPanel.visible = coverVisible;
        coverPanel.hittest = coversAllowed && (reorderEnabled || (replaceSelectionOnHeroPanel && !isBlocked));
        coverPanel.SetDraggable(coversAllowed && reorderEnabled);
        coverPanel.SetHasClass("ReplaceMode", replaceSelectionOnHeroPanel);
        coverPanel.SetHasClass("ReorderMode", reorderEnabled);
    });
    for (let i = visibleChildren.length;; i++) {
        const extraCover = $(`#AbilityCover_${i}`);
        if (!extraCover) {
            break;
        }
        extraCover.ability_params = undefined;
        extraCover.visible = false;
        extraCover.hittest = false;
        extraCover.SetDraggable(false);
    }
    if (reorder_active_overlay) {
        reorder_active_overlay.visible = coversAllowed && reorder_mode;
    }
    if (coversAllowed && reorder_mode) {
        PositionReorderOverlay();
    }
}
function ForceRefreshReplaceModeCovers() {
    replace_reinit_token += 1;
    const currentToken = replace_reinit_token;
    abilities_panel = undefined;
    ResetCoverPanels();
    const retryRefresh = (attempt) => {
        if (currentToken !== replace_reinit_token || !replace_mode) {
            return;
        }
        if (EnsureHudRefs()) {
            RebuildCovers();
        }
        if (attempt < 20) {
            $.Schedule(0.1, () => retryRefresh(attempt + 1));
        }
    };
    $.Schedule(0.0, () => retryRefresh(0));
}
function CancelDraggablePositionUpdater() {
    if (draggable_delimiter) {
        draggable_delimiter.visible = false;
    }
}
function UpdateDraggablePosition() {
    if (!reorder_mode || !abilities_panel || !draggable_delimiter) {
        return;
    }
    const position = GameUI.GetCursorPosition();
    const children = _GetVisibleChildren(abilities_panel.Children());
    let updated = false;
    for (let i = 0; i < children.length; i++) {
        const child = children[i];
        if (child.GetPositionWithinWindow().x + child.actuallayoutwidth / 2 > position[0]) {
            const anchor = _GetAbilityCoverAnchor(child);
            if (!anchor) {
                break;
            }
            PositionCoverFromPanel(draggable_delimiter, anchor);
            draggable_delimiter.style.position = `${anchor.GetPositionWithinWindow().x / (anchor.actualuiscale_x || 1) - 2}px ${anchor.GetPositionWithinWindow().y / (anchor.actualuiscale_y || 1)}px 0px`;
            updated = true;
            break;
        }
    }
    if (!updated && children.length > 0) {
        const last = children[children.length - 1];
        const lastButton = _GetAbilityButton(last);
        if (lastButton) {
            const xPos = lastButton.GetPositionWithinWindow().x / (lastButton.actualuiscale_x || 1) + last.actuallayoutwidth + 2;
            const yPos = lastButton.GetPositionWithinWindow().y / (lastButton.actualuiscale_y || 1);
            draggable_delimiter.style.position = `${xPos}px ${yPos}px 0px`;
        }
    }
    if (reorder_mode) {
        $.Schedule(0.1, UpdateDraggablePosition);
    }
}
function OnDragStart(panel, dragCallbacks) {
    var _a;
    if (!reorder_mode || !abilities_panel || replace_mode) {
        return false;
    }
    const coverPanel = panel;
    if (!((_a = coverPanel.ability_params) === null || _a === void 0 ? void 0 : _a.name)) {
        return false;
    }
    const displayPanel = $.CreatePanel("DOTAAbilityImage", $.GetContextPanel(), `${panel.id}_drag_preview`);
    displayPanel.style.width = `${panel.actuallayoutwidth}px`;
    displayPanel.style.height = `${panel.actuallayoutheight}px`;
    displayPanel.abilityname = coverPanel.ability_params.name;
    dragCallbacks.displayPanel = displayPanel;
    dragCallbacks.offsetX = panel.actuallayoutwidth / 2 - DRAG_OFFSET;
    dragCallbacks.offsetY = panel.actuallayoutheight / 2 - DRAG_OFFSET;
    $.GetContextPanel().SetHasClass("Dragging", true);
    CancelDraggablePositionUpdater();
    EnsureDraggableDelimiter();
    if (draggable_delimiter)
        draggable_delimiter.visible = true;
    UpdateDraggablePosition();
    return true;
}
function OnDragEnd(data, displayed) {
    var _a, _b, _c;
    const draggedCover = data;
    if (!((_a = draggedCover.ability_params) === null || _a === void 0 ? void 0 : _a.name) || !abilities_panel) {
        return false;
    }
    const position = GameUI.GetCursorPosition();
    const children = _GetVisibleChildren(abilities_panel.Children());
    const eventTable = {
        moved_ability: draggedCover.ability_params.name,
        swap_ui_secret: reorder_swap_ui_secret,
    };
    CancelDraggablePositionUpdater();
    $.GetContextPanel().SetHasClass("Dragging", false);
    data.SetParent($.GetContextPanel());
    displayed.DeleteAsync(0);
    if (!reorder_mode) {
        return true;
    }
    let swapped = false;
    for (let i = 0; i < children.length; i++) {
        const child = children[i];
        if (child.GetPositionWithinWindow().x + child.actuallayoutwidth / 2 > position[0]) {
            if (!child.ability_params) {
                child.ability_params = _GetAbilityParams(child);
            }
            if (!((_b = child.ability_params) === null || _b === void 0 ? void 0 : _b.name)) {
                break;
            }
            swapped = true;
            eventTable.reorder_type = reorder_types.before;
            eventTable.ref_ability = child.ability_params.name;
            break;
        }
    }
    if (!swapped && children.length > 0) {
        const last = children[children.length - 1];
        if (!last.ability_params) {
            last.ability_params = _GetAbilityParams(last);
        }
        if ((_c = last.ability_params) === null || _c === void 0 ? void 0 : _c.name) {
            eventTable.reorder_type = reorder_types.after;
            eventTable.ref_ability = last.ability_params.name;
        }
    }
    if (eventTable.reorder_type && eventTable.ref_ability) {
        GameEvents.SendCustomGameEventToServer("ReorderComplete", eventTable);
    }
    return true;
}
function SetDraggableEvents(stateFlag, childPanel, index) {
    if (childPanel.BHasClass("Hidden")) {
        return;
    }
    const coverPanel = GetCoverPanel(`AbilityCover_${index}`);
    const abilityAnchor = _GetAbilityCoverAnchor(childPanel);
    if (!abilityAnchor) {
        return;
    }
    coverPanel.style.width = `${abilityAnchor.actuallayoutwidth / childPanel.actualuiscale_x}px`;
    coverPanel.style.height = `${abilityAnchor.actuallayoutheight / childPanel.actualuiscale_y}px`;
    if (!stateFlag) {
        coverPanel.SetDraggable(false);
        return;
    }
    const child = childPanel;
    if (child.events_set) {
        coverPanel.SetDraggable(true);
        return;
    }
    child.ability_params = _GetAbilityParams(child);
    PositionCoverFromPanel(coverPanel, abilityAnchor);
    child.events_set = true;
    coverPanel.SetDraggable(true);
}
function ToggleAbilitiesReorder(data) {
    var _a;
    if (!EnsureHudRefs()) {
        return;
    }
    reorder_mode = (_a = data === null || data === void 0 ? void 0 : data.state) !== null && _a !== void 0 ? _a : !reorder_mode;
    if ((data === null || data === void 0 ? void 0 : data.swap_ui_secret) !== undefined) {
        reorder_swap_ui_secret = data.swap_ui_secret;
    }
    EnsureDragDescriptionOverlay();
    EnsureDraggableDelimiter();
    if (!reorder_mode) {
        CancelDraggablePositionUpdater();
    }
    const playerHero = Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer());
    const portraitUnit = Players.GetLocalPlayerPortraitUnit();
    if (reorder_active_overlay) {
        reorder_active_overlay.visible = reorder_mode;
    }
    RefreshSelectedUnitPoll();
    if (playerHero !== portraitUnit) {
        RebuildCovers(data);
        return;
    }
    $.Each(abilities_panel.Children(), (child, index) => {
        SetDraggableEvents(reorder_mode, child, index);
    });
    RebuildCovers(data);
}
// ====== State sync ===================================================
function GetRawAbilitySelectionData() {
    return CustomNetTables.GetTableValue("ability_select", String(Players.GetLocalPlayer()));
}
function BuildAbilityListFromSelectionData(data) {
    if (!data || !data.abilitylist) {
        return [];
    }
    return Object.keys(data.abilitylist)
        .sort((a, b) => Number(a) - Number(b))
        .map((key) => { var _a, _b; return (_b = (_a = data.abilitylist) === null || _a === void 0 ? void 0 : _a[key]) === null || _b === void 0 ? void 0 : _b.ability_name; })
        .filter((name) => !!name);
}
function UpdateReplaceModeFromSelectionData(data) {
    const previousState = last_replace_state;
    const state = Number(data && data.state != undefined ? data.state : ability_select_state.none);
    last_replace_state = state;
    add_select_mode = state === ability_select_state.add;
    add_select_ability_list = add_select_mode ? BuildAbilityListFromSelectionData(data) : [];
    if ((add_select_mode && previousState !== ability_select_state.add) || (replace_mode && previousState !== state)) {
        add_select_collapsed = false;
    }
    replace_mode = state === ability_select_state.remove || state === ability_select_state.hide;
    replace_action = replace_mode ? state : ability_select_state.none;
    replace_select_ability_list = replace_mode ? BuildAbilityListFromSelectionData(data) : [];
    blocked_replace_abilities = {};
    if (data && data.blocked_abilities) {
        Object.keys(data.blocked_abilities).forEach((abilityName) => {
            blocked_replace_abilities[abilityName] = true;
        });
    }
    replace_allowed_abilities = {};
    replace_allowed_initialized = false;
    if (replace_mode && data && data.abilitylist) {
        replace_allowed_initialized = true;
        Object.values(data.abilitylist).forEach((entry) => {
            if (entry && entry.ability_name) {
                replace_allowed_abilities[entry.ability_name] = true;
            }
        });
    }
    UpdateAbilitySelectDock();
    UpdateReplacePrompt();
    RefreshSelectedUnitPoll();
    if (replace_mode) {
        ForceRefreshReplaceModeCovers();
    }
    else if (EnsureHudRefs()) {
        RebuildCovers();
    }
}
function SyncReplaceModeFromNettable() {
    const data = GetRawAbilitySelectionData();
    const state = Number(data && data.state != undefined ? data.state : ability_select_state.none);
    if (state !== last_replace_state) {
        UpdateReplaceModeFromSelectionData(data);
    }
    return data;
}
// ====== Player actions ===============================================
function SelectAbilityFromDock(abilityName) {
    GameEvents.SendCustomGameEventToServer("ability_selected", {
        ability_name: abilityName,
    });
}
function OnAbilitySelectCardActivate(abilityName) {
    if (IsReplaceSelectionInDock()) {
        SendReplaceSelection(abilityName);
        replace_mode = false;
        replace_action = ability_select_state.none;
        replace_select_ability_list = [];
        add_select_collapsed = false;
        UpdateAbilitySelectDock();
        UpdateReplacePrompt();
        RebuildCovers();
        return;
    }
    SelectAbilityFromDock(abilityName);
}
function CloseAddSelection() {
    GameEvents.SendCustomGameEventToServer("ability_selected", {});
}
function HideAbilitySelectDock() {
    add_select_collapsed = true;
    UpdateAbilitySelectDock();
}
function ShowAbilitySelectDock() {
    add_select_collapsed = false;
    UpdateAbilitySelectDock();
}
function SendReplaceSelection(abilityName) {
    const payload = {};
    if (abilityName) {
        payload.ability_name = abilityName;
    }
    if (replace_action === ability_select_state.remove) {
        GameEvents.SendCustomGameEventToServer("relearn_book_ability_selected", payload);
    }
}
function CancelReplaceModeSelection() {
    if (!replace_mode) {
        return;
    }
    SendReplaceSelection(undefined);
    replace_mode = false;
    replace_action = ability_select_state.none;
    add_select_collapsed = false;
    UpdateAbilitySelectDock();
    UpdateReplacePrompt();
    RebuildCovers();
}
function OnCoverActivate(panel) {
    var _a;
    if (reorder_mode || !replace_mode || !EnsureHudRefs()) {
        return;
    }
    const coverPanel = panel;
    if (!((_a = coverPanel.ability_params) === null || _a === void 0 ? void 0 : _a.name)) {
        return;
    }
    if (IsBlockedForReplace(coverPanel.ability_params.name)) {
        return;
    }
    SendReplaceSelection(coverPanel.ability_params.name);
    replace_mode = false;
    replace_action = ability_select_state.none;
    UpdateReplacePrompt();
    RebuildCovers();
}
// ====== Event handlers ===============================================
function OnAbilitySelectChanged(table_name, key) {
    if (table_name !== "ability_select" || key !== String(Players.GetLocalPlayer())) {
        return;
    }
    UpdateReplaceModeFromSelectionData(GetRawAbilitySelectionData());
}
function OnAbilityReplaceModeEvent(data) {
    UpdateReplaceModeFromSelectionData(data);
}
// ====== Initialization ===============================================
function InitializeDraggableAbilities() {
    if (draggable_initialized)
        return;
    if (!EnsureHudRefs()) {
        $.Schedule(0.2, InitializeDraggableAbilities);
        return;
    }
    draggable_initialized = true;
    EnsureReplacePrompt();
    EnsureAbilitySelectDock();
    EnsureDragDescriptionOverlay();
    EnsureDraggableDelimiter();
    EnsureReorderToggleButton();
    EnsureReorderInterruptHook();
    UpdateReplacePrompt();
    SyncReplaceModeFromNettable();
    GameEvents.Subscribe("RefreshAbilityOrder", (event) => RebuildCovers(event));
    GameEvents.Subscribe("ReorderToggle", (event) => ToggleAbilitiesReorder(event));
    // GameEvents.Subscribe("AbilityReplaceMode", (event) => OnAbilityReplaceModeEvent(event as AbilitySelectionData))
    CustomNetTables.SubscribeNetTableListener("ability_select", (tableName, key) => OnAbilitySelectChanged(tableName, String(key)));
    CustomNetTables.SubscribeNetTableListener("player_settings", (tableName, key) => OnPlayerSettingsChanged(tableName, String(key)));
    ApplyAbilitySelectSettingsFromSettings();
    CreateKeyCommand("F8", ToggleAbilitiesReorder);
    if (replace_mode || reorder_mode) {
        RebuildCovers();
    }
}
(() => {
    GameUI.SetAbilitySelectDockPosition = SetAbilitySelectDockPosition;
    GameUI.SetAbilityReplaceSelectMode = SetAbilityReplaceSelectMode;
    InitializeDraggableAbilities();
})();