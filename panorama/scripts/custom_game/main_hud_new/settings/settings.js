--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
var _a;
const SETTINGS_TAB_BUTTONS = {
    camera: "CustomSettingsTabCamera",
    interface: "CustomSettingsTabInterface",
    controls: "CustomSettingsTabControls",
    bans: "CustomSettingsTabBans",
};
const SETTINGS_TAB_PANELS = {
    camera: "SettingsTabCamera",
    interface: "SettingsTabInterface",
    controls: "SettingsTabControls",
    bans: "SettingsTabBans",
};
function showSettingsTab(nextTab) {
    var _a, _b;
    for (const [tab, buttonId] of Object.entries(SETTINGS_TAB_BUTTONS)) {
        (_a = panel(buttonId)) === null || _a === void 0 ? void 0 : _a.SetHasClass("Selected", tab === nextTab);
    }
    for (const [tab, panelId] of Object.entries(SETTINGS_TAB_PANELS)) {
        (_b = panel(panelId)) === null || _b === void 0 ? void 0 : _b.SetHasClass("Hidden", tab !== nextTab);
    }
}
GameUI.SwitchCustomSettingsTab = (tabId) => showSettingsTab(tabId);
function getInitialSettingsTab() {
    var _a;
    for (const [tab, buttonId] of Object.entries(SETTINGS_TAB_BUTTONS)) {
        if ((_a = panel(buttonId)) === null || _a === void 0 ? void 0 : _a.BHasClass("Selected"))
            return tab;
    }
    return "camera";
}
const autoPvpCheckbox = panel("AutoPvpWatch");
const autoPveCheckbox = panel("AutoPveWatch");
const disableChatWheelMessagesCheckbox = panel("DisableChatWheelMessages");
const hidePvpOnRoundStartCheckbox = panel("HidePvpOnRoundStart");
const newExtraCreatureDropDown = panel("NewExtraCreatureDropDown");
const abilitySelectPositionDropDown = panel("AbilitySelectPositionDropDown");
const abilityReplaceSelectHeroPanelRadio = panel("AbilityReplaceSelectModeHeroPanel");
const abilityReplaceSelectWindowRadio = panel("AbilityReplaceSelectModeWindow");
const barragePanel = (_a = findElement("Hud")) === null || _a === void 0 ? void 0 : _a.FindChildTraverse("BarrgeMainPanel");
const barrageSlider = panel("BarrageOpacity");
const BARRAGE_OPACITY_UPDATE_DEBOUNCE = 1.5;
let barrageOpacityUpdateRequestId = 0;
GameUI.OnCheckBoxAutoPvpWatch = () => sendSettingsUpdateToServer();
GameUI.OnCheckBoxAutoPveWatch = () => sendSettingsUpdateToServer();
GameUI.OnCheckBoxDisableChatWheelMessages = () => sendSettingsUpdateToServer();
GameUI.OnCheckBoxHidePvpOnRoundStart = () => sendSettingsUpdateToServer();
GameUI.OnDropDownNewExtraCreature = () => sendSettingsUpdateToServer();
GameUI.OnDropDownAbilitySelectPosition = () => {
    ApplyAbilitySelectPositionDropDown();
    sendSettingsUpdateToServer();
};
GameUI.OnRadioAbilityReplaceSelectMode = () => {
    ApplyAbilityReplaceSelectModeRadio();
    sendSettingsUpdateToServer();
};
GameUI.OnBarrageOpacityChanged = () => {
    const barrageValue = barrageSlider.value;
    barragePanel.style.opacity = String(barrageValue * 0.01);
    barrageOpacityUpdateRequestId += 1;
    const requestId = barrageOpacityUpdateRequestId;
    $.Schedule(BARRAGE_OPACITY_UPDATE_DEBOUNCE, () => {
        if (requestId !== barrageOpacityUpdateRequestId) {
            return;
        }
        sendSettingsUpdateToServer();
    });
};
function sendSettingsUpdateToServer() {
    var _a;
    barragePanel.style.opacity = String(barrageSlider.value * 0.01);
    const data = {
        barrageOpacity: barrageSlider.value,
        autoViewPvp: autoPvpCheckbox.checked,
        autoViewPve: autoPveCheckbox.checked,
        extraCreatureOption: Number(newExtraCreatureDropDown.GetSelected().id),
        disableChatWheelMessages: disableChatWheelMessagesCheckbox.checked,
        abilitySelectPosition: NormalizeAbilitySelectPosition((_a = abilitySelectPositionDropDown.GetSelected()) === null || _a === void 0 ? void 0 : _a.id),
        abilityReplaceSelectMode: GetAbilityReplaceSelectMode(),
        hidePvpOnRoundStart: hidePvpOnRoundStartCheckbox.checked
    };
    GameEvents.SendCustomGameEventToServer("update_player_settings", data);
}
const banAbilitiesContainer = $.GetContextPanel().FindChildTraverse("BanAbilitiesContainer");
function NormalizeAbilitySelectPosition(position) {
    return position === "top" || position === "center" || position === "bottom" ? position : "bottom";
}
function ApplyAbilitySelectPositionDropDown() {
    var _a, _b;
    const position = NormalizeAbilitySelectPosition((_a = abilitySelectPositionDropDown.GetSelected()) === null || _a === void 0 ? void 0 : _a.id);
    GameUI.abilitySelectDockPosition = position;
    (_b = GameUI.SetAbilitySelectDockPosition) === null || _b === void 0 ? void 0 : _b.call(GameUI, position);
}
function GetAbilityReplaceSelectMode() {
    return abilityReplaceSelectWindowRadio.checked ? "select_window" : "hero_panel";
}
function ApplyAbilityReplaceSelectModeRadio() {
    var _a;
    const mode = GetAbilityReplaceSelectMode();
    GameUI.abilityReplaceSelectMode = mode;
    (_a = GameUI.SetAbilityReplaceSelectMode) === null || _a === void 0 ? void 0 : _a.call(GameUI, mode);
}
function applyPlayerSettings(playersSettings) {
    if (!playersSettings)
        return;
    autoPvpCheckbox.checked = readNetBool(playersSettings.autoViewPvp);
    autoPveCheckbox.checked = readNetBool(playersSettings.autoViewPve);
    disableChatWheelMessagesCheckbox.checked = readNetBool(playersSettings.disableChatWheelMessages);
    hidePvpOnRoundStartCheckbox.checked = readNetBool(playersSettings.hidePvpOnRoundStart);
    newExtraCreatureDropDown.SetSelected(String(playersSettings.extraCreatureOption));
    abilitySelectPositionDropDown.SetSelected(playersSettings.abilitySelectPosition);
    ApplyAbilitySelectPositionDropDown();
    abilityReplaceSelectHeroPanelRadio.checked = playersSettings.abilityReplaceSelectMode === "hero_panel";
    abilityReplaceSelectWindowRadio.checked = playersSettings.abilityReplaceSelectMode === "select_window";
    ApplyAbilityReplaceSelectModeRadio();
    barrageSlider.value = playersSettings.barrageOpacity;
    barragePanel.style.opacity = (playersSettings.barrageOpacity * 0.01).toString();
}
function RenderBannedAbilities() {
    const bannedAbilitiesTable = CustomNetTables.GetAllTableValues("player_bans");
    banAbilitiesContainer.RemoveAndDeleteChildren();
    if (!bannedAbilitiesTable)
        return;
    let isBannedAbilityExist = false;
    for (const entry of bannedAbilitiesTable) {
        const playerId = Number(entry.key);
        const abilities = entry.value.abilities.list;
        const heroName = Players.GetPlayerSelectedHero(playerId);
        const heroImageSrc = `file://{images}/heroes/icons/${heroName}.png`;
        Object.values(abilities).forEach(abilityName => {
            isBannedAbilityExist = true;
            const abilityPanel = $.CreatePanel("DOTAAbilityImage", banAbilitiesContainer, "BanAbilityIcon");
            const heroImage = $.CreatePanel("Image", abilityPanel, "HeroImage");
            heroImage.SetImage(heroImageSrc);
            abilityPanel.abilityname = abilityName;
            abilityPanel.SetPanelEvent("onmouseover", () => {
                heroImage.style.visibility = "visible";
                $.DispatchEvent("DOTAShowAbilityTooltip", abilityPanel, abilityName);
            });
            abilityPanel.SetPanelEvent("onmouseout", () => {
                heroImage.style.visibility = "collapse";
                $.DispatchEvent("DOTAHideAbilityTooltip", abilityPanel);
            });
        });
    }
    if (!isBannedAbilityExist) {
        const banAbilitiesNotFound = $.CreatePanel("Label", banAbilitiesContainer, "BanNotFoundLabel");
        banAbilitiesNotFound.text = $.Localize("#HUD_Settings_NoBans");
    }
}
RenderBannedAbilities();
showSettingsTab(getInitialSettingsTab());
SubscribeAndFireNetTableByKey("player_settings", String(getSteamId32(Players.GetLocalPlayer())), (_, __, value) => applyPlayerSettings(value));