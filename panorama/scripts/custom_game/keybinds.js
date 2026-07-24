--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


// Указывать кнопки на дефолтные предметы в функции GetDefaultKeybind

// thx nibuja05, edited stranger

// https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Panorama/Javascript/API
// дефолтные кнопки игрока можно взять из переменных DOTAKeybindCommand_t

// this.lockedKeybinds - массив отключает какие-то кнопки для использование ( те что нужны игроку дефолтные аля инвентарь или абилки)
// this.keyList - массив клавиш которые блокируются навсегда и их можно использовать для выбора в настройке клавиш

const humanFriendlyToActualKeyMap = {
    TAB: "tab",
    BACKSPACE: "backspace",
    ENTER: "enter",
    SPACE: "space",
    CAPSLOCK: "capslock",
    PAGEUP: "pgup",
    PAGEDOWN: "pgdn",
    END: "end",
    HOME: "home",
    INSERT: "ins",
    DELETE: "del",
    LEFT: "leftarrow",
    UP: "uparrow",
    RIGHT: "rightarrow",
    DOWN: "downarrow",
    "KEYPAD 0": "kp_0",
    "KEYPAD 1": "kp_1",
    "KEYPAD 2": "kp_2",
    "KEYPAD 3": "kp_3",
    "KEYPAD 4": "kp_4",
    "KEYPAD 5": "kp_5",
    "KEYPAD 6": "kp_6",
    "KEYPAD 7": "kp_7",
    "KEYPAD 8": "kp_8",
    "KEYPAD 9": "kp_9",
    "KEYPAD /": "kp_divide",
    "KEYPAD +": "kp_plus",
    "KEYPAD -": "kp_minus",
    "KEYPAD *": "kp_multiply",
    "KEYPAD ENTER": "kp_enter",
};

function ConvertHumanFriendlyToActual(key) {
    return humanFriendlyToActualKeyMap[key] || key.toLowerCase();
}

function OnSettingsOpen() {
    let settings = $("#SettingsRoot");
    if (settings.BHasClass("open")) {
        OnSettingsClose();
        return;
    }
    settings.AddClass("open");
    settings.RemoveClass("closing");
}
function OnSettingsClose() {
    let settings = $("#SettingsRoot");
    settings.RemoveClass("open");
    settings.AddClass("closing");
    $.Schedule(0.4, () => {
        settings.RemoveClass("closing");
    });
}

let keybindRefs = new Map();

function RefreshKeybindSettings() {
    let keylist = $("#SettingsKeybindsList");
    for (let [name, [key, func]] of keybinds) {
        if (!keybindRefs.has(name)) {
            const keybind = new PanoramaKeybind(name, key, func, keylist);
            keybindRefs.set(name, keybind);
        }
        else {
            const keybind = keybindRefs.get(name);
            if (keybind.key !== key)
                keybind.changeKeybind(key);
            keybind.updateCallback(func);
        }
    }
}

class PanoramaKeybind {
    constructor(name, key, callback, parent) {
        this.name = name;
        this.key = key;
        this.callback = callback;
        const newPanel = $.CreatePanel("Panel", parent, "");
        newPanel.BLoadLayoutSnippet("CustomKeyRegister");
        const title = newPanel.FindChild("CustomKeybindTitle");
        title.text = $.Localize("keybind_" + name);
        const preview = newPanel.FindChildTraverse("title");
        preview.text = this.localizePreviewLetter();
        this.keyLabel = newPanel.FindChildTraverse("value");
        this.keyLabel.text = key;
        this.button = newPanel.FindChildTraverse("CustomBinder");
        this.button.SetPanelEvent("onactivate", () => this.onClick());
        let cancel = newPanel.FindChildTraverse("BindingClose");
        cancel.SetPanelEvent("onactivate", () => {
            this.button.RemoveClass("active");
            KeyEvents.StopListeningToKeybindChange();
        });
    }
    onClick() {
        if (KeyEvents.IsListeningToKeybindChange())
            return;
        this.button.AddClass("active");
        KeyEvents.ListenToKeybindChange((newKey) => this.changeKeybind(newKey));
    }
    changeKeybind(newKey, replaceOld = true) {
        this.button.RemoveClass("active");
        this.keyLabel.text = newKey.toUpperCase();
        KeyEvents.UnregisterKeybind(this.key);
        if (replaceOld) {
            for (const [_, keybind] of keybindRefs) {
                if (keybind === this)
                    continue;
                if (keybind.key === newKey) {
                    keybind.changeKeybind(this.key, false);
                }
            }
        }
        this.key = newKey;
        AddNewKeybind(newKey, this.name, this.callback);
        GameEvents.SendCustomGameEventToServer("custom_keybind_changed", { name: this.name, newKey: newKey });
    }
    updateCallback(callback) {
        if (callback === this.callback)
            return;
        this.callback = callback;
    }
    localizePreviewLetter() {
        let previewLetter
        previewLetter = $.Localize("keybind_" + this.name).slice(0, 1);
        return "";
    }
}

function GetGameKeybind(command) {
    return Game.GetKeybindForCommand(command);
}
let keybinds = new Map();

function AddNewKeybind(key, name, func) {
    key = ConvertHumanFriendlyToActual(key);
    const successful = KeyEvents.RegisterKeybind(key, func);
    keybinds.set(name, [successful ? key : "", func]);
    GameEvents.SendEventClientSide("on_keybind_changed", { name: name, key: successful ? key : "" });
}

class KeyLogger {
    constructor() {
        this.keyList = [
            "tab",
            "backspace",
            "space",
            "capslock",
            "pgup",
            "pgdn",
            "end",
            "home",
            "ins",
            "del",
            "leftarrow",
            "uparrow",
            "rightarrow",
            "downarrow",
            "0",
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "a",
            "b",
            "c",
            "d",
            "e",
            "f",
            "g",
            "h",
            "i",
            "j",
            "k",
            "l",
            "m",
            "n",
            "o",
            "p",
            "q",
            "r",
            "s",
            "t",
            "u",
            "v",
            "w",
            "x",
            "y",
            "z",
            "kp_0",
            "kp_1",
            "kp_2",
            "kp_3",
            "kp_4",
            "kp_5",
            "kp_6",
            "kp_7",
            "kp_8",
            "kp_9",
            "kp_divide",
            "kp_plus",
            "kp_minus",
            "kp_del",
            "f1",
            "f2",
            "f3",
            "f4",
            "f5",
            "f6",
            "f7",
            "f8",
            "f9",
            "f10",
            "f11",
            "f12",
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "0",
            "mouse1",
            "mouse2",
            "mouse4",
            "mouse6",
            "mouse7",
            "mouse8",
            "mouse9",
            "mouse10",
            "mouse11",
            "alt + z",
        ];
        this.lockedKeybinds = [
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_NONE        ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_FIRST   ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_UP       ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_DOWN     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_LEFT     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_RIGHT    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_GRIP     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_YAW_GRIP     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_SAVED_POSITION_1     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_SAVED_POSITION_2     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_SAVED_POSITION_3     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_SAVED_POSITION_4     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_SAVED_POSITION_5     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_SAVED_POSITION_6     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_SAVED_POSITION_7     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_SAVED_POSITION_8     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_SAVED_POSITION_9     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_SAVED_POSITION_10    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_ATTACK     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_MOVE   ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_MOVE_DIRECTION     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_PATROL  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_STOP   ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_HOLD   ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_SELECT     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_COURIER_SELECT  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_COURIER_DELIVER     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_COURIER_BURST       ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_COURIER_SHIELD      ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_PAUSE   ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_SELECT_ALL      ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_SELECT_ALL_OTHERS       ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_RECENT_EVENT        ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_TEAM       ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_GLOBAL         ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_TEAM2      ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_GLOBAL2        ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_VOICE_PARTY    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_VOICE_TEAM         ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL      ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL2         ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL_CARE         ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL_BACK     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL_NEED_WARDS       ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL_STUN         ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL_HELP         ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL_GET_PUSH         ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL_GOOD_JOB         ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL_MISSING      ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL_MISSING_TOP      ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL_MISSING_MIDDLE       ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL_MISSING_BOTTOM       ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_CHAT_WHEEL     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SPRAY_WHEEL     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY2        ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY3        ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY1      ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY2  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_ULTIMATE        ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1_QUICKCAST      ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY2_QUICKCAST      ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY3_QUICKCAST      ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY1_QUICKCAST        ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY2_QUICKCAST        ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_ULTIMATE_QUICKCAST      ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1_EXPLICIT_AUTOCAST  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY2_EXPLICIT_AUTOCAST  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY3_EXPLICIT_AUTOCAST  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY1_EXPLICIT_AUTOCAST    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY2_EXPLICIT_AUTOCAST    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_ULTIMATE_EXPLICIT_AUTOCAST  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1_QUICKCAST_AUTOCAST     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY2_QUICKCAST_AUTOCAST     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY3_QUICKCAST_AUTOCAST     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY1_QUICKCAST_AUTOCAST ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY2_QUICKCAST_AUTOCAST ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_ULTIMATE_QUICKCAST_AUTOCAST     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1_AUTOMATIC_AUTOCAST     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY2_AUTOMATIC_AUTOCAST     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY3_AUTOMATIC_AUTOCAST     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY1_AUTOMATIC_AUTOCAST ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY2_AUTOMATIC_AUTOCAST ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_ULTIMATE_AUTOMATIC_AUTOCAST     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY2  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY3  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY4  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY5  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY6  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORYTP     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORYNEUTRAL        ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY2_QUICKCAST    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY3_QUICKCAST    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY4_QUICKCAST    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY5_QUICKCAST    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY6_QUICKCAST    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORYTP_QUICKCAST ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORYNEUTRAL_QUICKCAST      ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY2_AUTOCAST     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY3_AUTOCAST     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY4_AUTOCAST     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY5_AUTOCAST     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY6_AUTOCAST     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORYTP_AUTOCAST    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORYNEUTRAL_AUTOCAST   ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY2_QUICKAUTOCAST    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY3_QUICKAUTOCAST    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY4_QUICKAUTOCAST    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY5_QUICKAUTOCAST    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY6_QUICKAUTOCAST    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORYTP_QUICKAUTOCAST   ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORYNEUTRAL_QUICKAUTOCAST  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP1  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP2  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP3  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP4  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP5  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP6  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP7  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP8  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP9  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP10     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUPCYCLE  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SELECT_ALLY1    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SELECT_ALLY2    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SELECT_ALLY3    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SELECT_ALLY4    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SELECT_ALLY5    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_TOGGLE     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SCOREBOARD_TOGGLE       ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SCREENSHOT  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ESCAPE      ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CONSOLE     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_DEATH_SUMMARY   ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_LEARN_ABILITIES     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_LEARN_STATS     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ACTIVATE_GLYPH  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ACTIVATE_RADAR  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_PURCHASE_QUICKBUY   ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_PURCHASE_STICKY     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_GRAB_STASH_ITEMS    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_TOGGLE_AUTOATTACK   ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_TAUNT   ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_CONSUMABLES    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_ATTRIBUTES     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_ARMAMENTS  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_ARCANE         ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_BASICS         ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SUPPORT        ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_CASTER         ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_WEAPONS        ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_ARMOR      ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_ARTIFACTS  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SIDE_PAGE_1    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SIDE_PAGE_2    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SECRET         ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SEARCHBOX  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SLOT_1     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SLOT_2     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SLOT_3     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SLOT_4     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SLOT_5     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SLOT_6     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SLOT_7     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SLOT_8     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SLOT_9     ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SLOT_10    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SLOT_11    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SLOT_12    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SLOT_13    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_SLOT_14    ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INSPECTHEROINWORLD  ),
GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUPCYCLEPREV),
        ];
        this.keybinds = new Map();
        for (let index = 0; index < this.lockedKeybinds.length; index++) {
            this.lockedKeybinds[index] = ConvertHumanFriendlyToActual(this.lockedKeybinds[index]);
            const keyListIndex = this.keyList.indexOf(this.lockedKeybinds[index]);
            if (keyListIndex !== -1) {
                delete this.keyList[keyListIndex];
            }
        }
        for (let key of this.keyList) {
            if (key) {
                Game.AddCommand("key_" + key, () => {
                    this.HandleKeyPressed(key);
                }, "", 0);
                Game.CreateCustomKeyBind(key, "key_" + key);
            }
        }
    }
    HandleKeyPressed(key) {
        if (this.listeningToKeybindChange) {
            this.listeningToKeybindChange(key);
            this.StopListeningToKeybindChange();
        }
        else {
            const keybind = this.keybinds.get(key);
            if (keybind) {
                keybind();
            }
        }
    }
    RegisterKeybind(key, func) {
        if (this.keyList.includes(key)) {
            this.keybinds.set(key, func);
            return true;
        }
        return false;
    }
    UnregisterKeybind(key) {
        this.keybinds.delete(key);
    }
    ListenToKeybindChange(callback) {
        this.listeningToKeybindChange = callback;
    }
    IsListeningToKeybindChange() {
        return this.listeningToKeybindChange !== undefined;
    }
    StopListeningToKeybindChange() {
        this.listeningToKeybindChange = undefined;
    }
}

let KeyEvents = new KeyLogger();
let checkboxCallbacks = new Map();
let checkBoxes = [];
$.RegisterForUnhandledEvent("StyleClassesChanged", (panel) => {
    if (!checkBoxes.includes(panel))
        return;
    let state = panel.checked;
    checkboxCallbacks.get(panel)(state);
});

function GetDefaultKeybind(name) {
    switch (name) {
        case "use_teleport":
            return 'ALT + Z';
        case "use_observer":
            return GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ACTIVATE_GLYPH) || "2";
        case "use_sentry":
            return GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ACTIVATE_RADAR) || "3";
    }
}

function ResetKeybinds() {
    for (const [name, keybind] of keybindRefs) {
        const defaultKey = GetDefaultKeybind(name);
        if (keybind.key !== GetDefaultKeybind(name)) {
            keybind.changeKeybind(defaultKey, false);
        }
    }
}

AddNewKeybind(GetDefaultKeybind("use_teleport"), "use_teleport", () => CastAbilityTeleport());
AddNewKeybind(GetDefaultKeybind("use_observer"), "use_observer", () => CastAbilityObserver());
AddNewKeybind(GetDefaultKeybind("use_sentry"), "use_sentry", () => CastAbilitySentry());
RefreshKeybindSettings();
ResetKeybinds();

function CastAbilityTeleport() {

    let ability_id = -1

    for (var i = 0; i < 45; i++) {
        var abilityId = Entities.GetAbility( Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID()), i )
        if (abilityId > -1) {
            var ability_name =  Abilities.GetAbilityName( abilityId )
            if (ability_name == "custom_ability_teleport" ) {
                ability_id = abilityId
                break
            }
        }
    }

    Abilities.ExecuteAbility(ability_id, Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ), false);
}

function CastAbilityObserver() {
    var table_hero = CustomNetTables.GetTableValue("custom_items_button", Players.GetLocalPlayer())
    if (table_hero) {
        if (table_hero.observer <= 0 ) {
            return
        }
    }

    let ability_id = -1

    for (var i = 0; i < 45; i++) {
        var abilityId = Entities.GetAbility( Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID()), i )
        if (abilityId > -1) {
            var ability_name =  Abilities.GetAbilityName( abilityId )
            if (ability_name == "custom_ability_observer" ) {
                ability_id = abilityId
                break
            }
        }
    }

    Abilities.ExecuteAbility(ability_id, Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ), false);
}

function CastAbilitySentry() {
    var table_hero = CustomNetTables.GetTableValue("custom_items_button", Players.GetLocalPlayer())
    if (table_hero) {
        if (table_hero.sentry <= 0 ) {
            return
        }
    }


    let ability_id = -1

    for (var i = 0; i < 45; i++) {
        var abilityId = Entities.GetAbility( Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID()), i )
        if (abilityId > -1) {
            var ability_name =  Abilities.GetAbilityName( abilityId )
            if (ability_name == "custom_ability_sentry" ) {
                ability_id = abilityId
                break
            }
        }
    }

    Abilities.ExecuteAbility(ability_id, Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ), false);
}