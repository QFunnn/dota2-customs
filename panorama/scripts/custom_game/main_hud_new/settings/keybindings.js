--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
const LOCKED_KEY_BINDS = [
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY2),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY3),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY1),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY2),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_ULTIMATE),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY2_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY3_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY1_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY2_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_ULTIMATE_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1_EXPLICIT_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY2_EXPLICIT_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY3_EXPLICIT_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY1_EXPLICIT_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY2_EXPLICIT_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_ULTIMATE_EXPLICIT_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1_QUICKCAST_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY2_QUICKCAST_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY3_QUICKCAST_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY1_QUICKCAST_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY2_QUICKCAST_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_ULTIMATE_QUICKCAST_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1_AUTOMATIC_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY2_AUTOMATIC_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY3_AUTOMATIC_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY1_AUTOMATIC_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY2_AUTOMATIC_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_ULTIMATE_AUTOMATIC_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY1),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY2),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY3),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY4),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY5),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY6),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORYNEUTRAL),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY1_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY2_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY3_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY4_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY5_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY6_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORYNEUTRAL_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY1_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY2_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY3_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY4_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY5_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY6_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORYNEUTRAL_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY1_QUICKAUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY2_QUICKAUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY3_QUICKAUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY4_QUICKAUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY5_QUICKAUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY6_QUICKAUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORYNEUTRAL_QUICKAUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORYTP),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_STOP),
];
const russianToEnglishButtonsMap = {
    "й": "q",
    "ц": "w",
    "у": "e",
    "к": "r",
    "е": "t",
    "н": "y",
    "г": "u",
    "ш": "i",
    "щ": "o",
    "з": "p",
    "ф": "a",
    "ы": "s",
    "в": "d",
    "а": "f",
    "п": "g",
    "р": "h",
    "о": "j",
    "л": "k",
    "д": "l",
    "я": "z",
    "ч": "x",
    "с": "c",
    "м": "v",
    "и": "b",
    "т": "n",
    "ь": "m",
};
const englishToRussianButtonsMap = {
    "q": "й",
    "w": "ц",
    "e": "у",
    "r": "к",
    "t": "е",
    "y": "н",
    "u": "г",
    "i": "ш",
    "o": "щ",
    "p": "з",
    "a": "ф",
    "s": "ы",
    "d": "в",
    "f": "а",
    "g": "п",
    "h": "р",
    "j": "о",
    "k": "л",
    "l": "д",
    "z": "я",
    "x": "ч",
    "c": "с",
    "v": "м",
    "b": "и",
    "n": "т",
    "m": "ь",
};
let init_settings = false;
let abilities_settings = {};
let abilities_quickcast_settings = {};
let ability_bound_keys = {};
let ability_upgrade_bound_keys = {};
const registeredCommandNames = {};
let sharedEntryPanel;
var castAbilitiesList = ["cast_ability_7", "cast_ability_8", "cast_ability_9", "cast_ability_10"]; //"cast_ability_11", "cast_ability_12", "cast_ability_13", "cast_ability_14", "cast_ability_15", "cast_ability_16"]
var saves_buttons_name = {};
function CollectPanelsById(root, id, result) {
    if (!root) {
        return;
    }
    if (root.id === id) {
        result.push(root);
    }
    for (let i = 0; i < root.GetChildCount(); i++) {
        CollectPanelsById(root.GetChild(i), id, result);
    }
}
function GetOrCreateSharedEntryPanel() {
    const existingEntries = [];
    CollectPanelsById($.GetContextPanel(), "CustomKeybindEntry", existingEntries);
    const existingEntry = existingEntries[0];
    const entryPanel = existingEntry !== null && existingEntry !== void 0 ? existingEntry : $.CreatePanel("TextEntry", $.GetContextPanel(), "CustomKeybindEntry", { maxchars: 1 });
    entryPanel.AddClass("CustomKeybindEntry");
    for (let i = 1; i < existingEntries.length; i++) {
        const panel = existingEntries[i];
        if (panel && panel.IsValid()) {
            panel.DeleteAsync(0);
        }
    }
    return entryPanel;
}
function GetAbilityCommandName(abilityName) {
    return `KeyBind_Custom_${abilityName}`;
}
function GetUpgradeCommandName(abilityName) {
    return `KeyBind_Custom_Upgrade_${abilityName}`;
}
const KEYBIND_NOOP_COMMAND = "KeyBind_Custom_Noop";
const KEYBIND_UPGRADE_NOOP_COMMAND = "KeyBind_Custom_Upgrade_Noop";
function RegisterCommandOnce(commandName, callback) {
    if (registeredCommandNames[commandName]) {
        return;
    }
    Game.AddCommand(commandName, callback, "", 0);
    registeredCommandNames[commandName] = true;
}
function InitButtons() {
    $("#SettingsKeybindsList").RemoveAndDeleteChildren();
    for (const castAbilityName of castAbilitiesList) {
        CreateBindButton(castAbilityName);
    }
}
function CreateBindButton(abilityName) {
    const buttonContainer = $.CreatePanel("Panel", $("#SettingsKeybindsList"), "");
    buttonContainer.AddClass("CustomKeybindContainer");
    const buttonPanel = $.CreatePanel("Panel", buttonContainer, "");
    buttonPanel.AddClass("CustomKeybinder");
    buttonPanel.AddClass("HoverEffect");
    const abilityImage = $.CreatePanel("DOTAAbilityImage", buttonPanel, "");
    const abilityList = GetAbilityList();
    abilityImage.abilityname = Abilities.GetAbilityName(Entities.GetAbilityByName(Players.GetLocalPlayerPortraitUnit(), abilityList[abilityName]));
    if (abilityImage.abilityname != "") {
        abilityImage.style.washColor = "#666666";
        abilityImage.style.saturation = "0";
    }
    const bindNameLabel = $.CreatePanel("Label", buttonPanel, "bind_name_label");
    bindNameLabel.AddClass("bind_name");
    bindNameLabel.text = "";
    if (abilities_settings[abilityName]) {
        bindNameLabel.text = abilities_settings[abilityName].toUpperCase();
    }
    if (abilities_quickcast_settings[abilityName] == null) {
        abilities_quickcast_settings[abilityName] = false;
    }
    const quickcastCheckbox = $.CreatePanel("DOTASettingsCheckbox", buttonContainer, "");
    quickcastCheckbox.AddClass("CheckBox");
    quickcastCheckbox.AddClass("QuickcastAbilityCheckbox");
    quickcastCheckbox.checked = abilities_quickcast_settings[abilityName];
    quickcastCheckbox.SetPanelEvent("onactivate", () => {
        abilities_quickcast_settings[abilityName] = !!quickcastCheckbox.checked;
    });
    quickcastCheckbox.SetPanelEvent("onmouseover", () => {
        $.DispatchEvent("DOTAShowTextTooltip", quickcastCheckbox, $.Localize("#dota_settings_enable_quickcast"));
    });
    quickcastCheckbox.SetPanelEvent("onmouseout", () => {
        $.DispatchEvent("DOTAHideTextTooltip", quickcastCheckbox);
    });
    // const buttonNameLabel = $.CreatePanel("Label", buttonContainer, "")
    // buttonNameLabel.AddClass("CustomKeybindTitle")
    // buttonNameLabel.text = $.Localize(`#HUD_Settings_${abilityName}`)
    const entryPanel = sharedEntryPanel !== null && sharedEntryPanel !== void 0 ? sharedEntryPanel : GetOrCreateSharedEntryPanel();
    sharedEntryPanel = entryPanel;
    buttonPanel.SetPanelEvent("onactivate", function () {
        SetPreActivateBind(buttonPanel, entryPanel, abilityName, bindNameLabel);
    });
}
function SetPreActivateBind(buttonPanel, entryPanel, ability_name, bind_name) {
    ResetKeyBind(ability_name);
    bind_name.text = "";
    entryPanel.text = "";
    entryPanel.SetFocus();
    buttonPanel.SetHasClass("ActiveBind", true);
    buttonPanel.SetHasClass("HoverEffect", false);
    CheckFocusPanel(entryPanel, buttonPanel);
    entryPanel.SetPanelEvent("ontextentrychange", function () {
        OnSubmitted(bind_name, entryPanel, buttonPanel, ability_name);
    });
}
function OnSubmitted(bindName, entry_panel, button_panel, ability_name) {
    let get_key_bind_name = entry_panel.text.toLowerCase();
    if (russianToEnglishButtonsMap[get_key_bind_name]) {
        get_key_bind_name = russianToEnglishButtonsMap[get_key_bind_name];
    }
    if (get_key_bind_name == " ") {
        get_key_bind_name = "space";
    }
    if (IsKeyBindLocked(get_key_bind_name)) {
        button_panel.SetHasClass("ActiveBind", false);
        button_panel.SetHasClass("HoverEffect", true);
        $.DispatchEvent("DropInputFocus");
        GameEvents.SendEventClientSide("dota_hud_error_message", {
            reason: 80,
            message: "#Settings_custom_keybind_locked",
            sequenceNumber: 1,
        });
        return;
    }
    abilities_settings[ability_name] = get_key_bind_name;
    bindName.text = get_key_bind_name.toUpperCase();
    button_panel.SetHasClass("ActiveBind", false);
    button_panel.SetHasClass("HoverEffect", true);
    $.DispatchEvent("DropInputFocus");
    if (get_key_bind_name != "") {
        BindAbilityKey(ability_name);
    }
}
function CheckFocusPanel(panel, button_panel) {
    if (panel.BHasKeyFocus()) {
        $.Schedule(1 / 144, () => {
            CheckFocusPanel(panel, button_panel);
        });
        return;
    }
    button_panel.SetHasClass("ActiveBind", false);
    button_panel.SetHasClass("HoverEffect", true);
}
function UpdateSkillBar() {
    const hudAbilities = $.GetContextPanel().GetParent().GetParent().GetParent().FindChildTraverse("HUDElements");
    const hudAbilitiesPanel = hudAbilities.FindChildTraverse("abilities");
    const ability_list = GetAbilityList();
    if (hudAbilitiesPanel && hudAbilitiesPanel.GetChildCount() > 6) {
        for (var i = 6; i < hudAbilitiesPanel.GetChildCount(); i++) {
            let ability_panel = hudAbilitiesPanel.GetChild(i);
            if (ability_panel) {
                let Hotkey = ability_panel.FindChildTraverse("Hotkey");
                let HotkeyText = ability_panel.FindChildTraverse("HotkeyText");
                let ability_name = ability_panel.FindChildTraverse("AbilityImage").abilityname;
                for (const keybind_name of castAbilitiesList) {
                    if (ability_name && ability_name == ability_list[keybind_name] && abilities_settings[keybind_name] != null) {
                        if (HotkeyText) {
                            HotkeyText.text = String(abilities_settings[keybind_name]).toUpperCase();
                        }
                        if (Hotkey) {
                            Hotkey.style.visibility = "visible";
                        }
                        break;
                    }
                    else {
                        if (HotkeyText) {
                            HotkeyText.text = "";
                        }
                        if (Hotkey) {
                            Hotkey.style.visibility = "collapse";
                        }
                    }
                }
            }
        }
    }
    $.Schedule(1, UpdateSkillBar);
}
function GetAbilityList() {
    const resultAbilityList = {};
    const playerHeroIndex = Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID());
    let ability_index = 7;
    for (let i = 6; i <= 30; i++) {
        const ability = Entities.GetAbility(playerHeroIndex, i);
        const abilityName = Abilities.GetAbilityName(ability);
        if (IsValidAbilityCheck(ability)) {
            resultAbilityList["cast_ability_" + ability_index] = abilityName;
            ability_index = ability_index + 1;
        }
    }
    return resultAbilityList;
}
function IsValidAbilityCheck(abilityIndex) {
    let result = false;
    const abilityName = Abilities.GetAbilityName(abilityIndex);
    if (abilityName != null &&
        abilityName != "" &&
        abilityName.substring(0, 14) != "special_bonus_" &&
        abilityName != "generic_hidden" &&
        abilityName != "portal_base_custom" &&
        abilityName.substring(0, 6) != "empty_") {
        if (!Abilities.IsHidden(abilityIndex)) {
            result = true;
        }
        if (bitAnd(Abilities.GetBehavior(abilityIndex), DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_PASSIVE) == DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_PASSIVE) {
            result = false;
        }
    }
    return result;
}
function bitAnd(a, b) {
    return a & b;
}
function GetQuickcastHelper() {
    return GameUI.CustomUIConfig().QuickcastHelper;
}
function BindKeyFallback(ability_name, button_keypad) {
    const bindName = GetAbilityCommandName(ability_name);
    RegisterCommandOnce(bindName, () => {
        UseAbility(ability_name, true);
    });
    Game.CreateCustomKeyBind(button_keypad, bindName);
}
function BindCtrlUpgradeKey(ability_name, button_keypad) {
    const bindFormats = [("CTRL+" + button_keypad).toUpperCase(), ("CTRL-" + button_keypad).toUpperCase()];
    const bindName = GetUpgradeCommandName(ability_name);
    RegisterCommandOnce(bindName, () => {
        TryUpgradeAbility(ability_name);
    });
    for (const bindFormat of bindFormats) {
        Game.CreateCustomKeyBind(bindFormat, bindName);
    }
    return bindFormats;
}
function TryUpgradeAbility(ability_name) {
    const abilityList = GetAbilityList();
    const abilityNameInSkillBar = abilityList[ability_name];
    if (!abilityNameInSkillBar || abilityNameInSkillBar == "none") {
        return false;
    }
    const hero = Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID());
    const abilityName = Entities.GetAbilityByName(hero, abilityNameInSkillBar);
    return Abilities.AttemptToUpgrade(abilityName);
}
function BindAbilityKey(ability_name) {
    const button_keypad = abilities_settings[ability_name];
    if (!button_keypad) {
        return;
    }
    const keysToBind = [button_keypad];
    if (button_keypad != "space" && englishToRussianButtonsMap[button_keypad]) {
        keysToBind.push(englishToRussianButtonsMap[button_keypad]);
    }
    ability_bound_keys[ability_name] = keysToBind;
    ability_upgrade_bound_keys[ability_name] = [];
    const quickcastHelper = GetQuickcastHelper();
    for (const keyToBind of keysToBind) {
        const boundUpgradeFormats = BindCtrlUpgradeKey(ability_name, keyToBind);
        ability_upgrade_bound_keys[ability_name].push(...boundUpgradeFormats);
        if (quickcastHelper) {
            quickcastHelper.BindKey(keyToBind, (keyDown) => {
                UseAbility(ability_name, keyDown);
            });
        }
        else {
            BindKeyFallback(ability_name, keyToBind);
        }
    }
}
function UseAbility(ability_name, keyDown) {
    const abilityList = GetAbilityList();
    const abilityNameInSkillBar = abilityList[ability_name];
    if (!keyDown && !GetQuickcastHelper()) {
        return;
    }
    if (abilityNameInSkillBar && abilityNameInSkillBar != "none") {
        const caster = Players.GetLocalPlayerPortraitUnit();
        const abilityName = Entities.GetAbilityByName(caster, abilityNameInSkillBar);
        if (keyDown && (GameUI.IsControlDown() || Game.IsInAbilityLearnMode()) && TryUpgradeAbility(ability_name)) {
            return;
        }
        const quickcastHelper = GetQuickcastHelper();
        if (quickcastHelper) {
            quickcastHelper.CastAbility(abilityName, caster, abilities_quickcast_settings[ability_name] !== false, GameUI.IsShiftDown(), keyDown);
            return;
        }
        Abilities.ExecuteAbility(abilityName, caster, true);
    }
}
function ResetKeyBind(ability_name) {
    const bindKeys = ability_bound_keys[ability_name] || [];
    RegisterCommandOnce(KEYBIND_NOOP_COMMAND, () => { });
    for (const bindNameKey of bindKeys) {
        Game.CreateCustomKeyBind(bindNameKey, KEYBIND_NOOP_COMMAND);
    }
    ability_bound_keys[ability_name] = [];
    const upgradeBindKeys = ability_upgrade_bound_keys[ability_name] || [];
    RegisterCommandOnce(KEYBIND_UPGRADE_NOOP_COMMAND, () => { });
    for (const bindNameKey of upgradeBindKeys) {
        Game.CreateCustomKeyBind(bindNameKey, KEYBIND_UPGRADE_NOOP_COMMAND);
    }
    ability_upgrade_bound_keys[ability_name] = [];
    abilities_settings[ability_name] = null;
}
function GetGameKeybind(command) {
    if (command == null || command == undefined) {
        return "";
    }
    return Game.GetKeybindForCommand(command).toLowerCase();
}
function IsKeyBindLocked(button) {
    button = button.replace(/alt-/g, '');
    button = button.replace(/ctrl-/g, '');
    if (button == '') {
        return false;
    }
    for (const button_original of LOCKED_KEY_BINDS) {
        if (button_original == button || button_original == englishToRussianButtonsMap[button]) {
            return true;
        }
    }
    for (const button_original in abilities_settings) {
        let button_name = abilities_settings[button_original];
        if (button_name == button) {
            return true;
        }
    }
    return false;
}
GameEvents.Subscribe("RefreshAbilityOrder", () => {
    InitButtons();
});
sharedEntryPanel = GetOrCreateSharedEntryPanel();
UpdateSkillBar();
InitButtons();