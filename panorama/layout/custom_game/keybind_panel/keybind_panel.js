--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const KeyBinderList = $("#KeyBinderList")
const SettingsOtherList = $("#SettingsOtherList")
const KeyBindsList =
{
    ["abilities"]:
    [
        ["key_bind_label_1", "ability", 1, "abilities/levelup_select_card"],
        ["key_bind_label_2", "ability", 2, "abilities/firework_splitshot_0"],
        ["key_bind_label_3", "ability", 3, "abilities/levelup_upgrade_artifacts_0"],
        ["key_bind_label_4", "ability", 4, "abilities/levelup_blink"],
        ["key_bind_label_6", "ability", 6, "spellicons/omniknight_purification"],
    ],
    ["items"]:
    [
        ["key_bind_label_10", "item", 1, ""],
        ["key_bind_label_11", "item", 2, ""],
        ["key_bind_label_12", "item", 3, ""],
        ["key_bind_label_13", "item", 4, ""],
        ["key_bind_label_14", "item", 5, ""],
        ["key_bind_label_15", "item", 6, ""],
    ],
    ["another_abilities"]:
    [
        ["key_bind_label_5", "ability", 5, "abilities/card_bag"],
        ["key_bind_label_7", "ability", 7, "abilities/wood_challenge"],
        ["key_bind_label_8", "ability", 8, "abilities/wood_challenge_cancel"],
        ["key_bind_label_9", "ability", 9, "abilities/teleport_to_base"],
    ]
}

const keys_numb = 
[
    "key_a", "key_b", "key_c", "key_d", "key_e", "key_f", "key_g",
    "key_h", "key_i", "key_j", "key_k", "key_l", "key_m", "key_n",
    "key_o", "key_p", "key_q", "key_r", "key_s", "key_t", "key_u",
    "key_v", "key_w", "key_x", "key_y", "key_z",
    "key_0", "key_1","key_2","key_3","key_4","key_5","key_6","key_7","key_8","key_9",
    "key_f2", "key_f3", "key_f4", "key_f5", "key_f6", "key_f7", "key_f8",
];

var save_changes_list = {}
var player_settings_state = null
var camera_distance_state = 1134
var camera_distance_save_token = 0

const CAMERA_DISTANCE_DEFAULT = 1134
const CAMERA_DISTANCE_MIN = 900
const CAMERA_DISTANCE_MAX = 1800

function GetPlayerSettings()
{
    return player_settings_state || Game.GetCustomTable("player_settings", String(Game.GetLocalPlayerID())) || {}
}

function IsSettingEnabled(setting_name, default_value)
{
    let settings = GetPlayerSettings()
    let value = settings[setting_name]
    if (value === undefined || value === null)
    {
        return default_value
    }
    return value !== false && value !== 0
}

function NormalizeCameraDistance(distance)
{
    let normalized = Math.round(Number(distance))
    if (!isFinite(normalized)) normalized = CAMERA_DISTANCE_DEFAULT
    return Math.max(CAMERA_DISTANCE_MIN, Math.min(CAMERA_DISTANCE_MAX, normalized))
}

function GetCameraDistance()
{
    return NormalizeCameraDistance(GetPlayerSettings().camera_distance)
}

function UpdateCameraDistanceValue(distance)
{
    let normalized = NormalizeCameraDistance(distance)
    camera_distance_state = normalized
    GameUI.SetCameraDistance(normalized)

    let value_label = SettingsOtherList && SettingsOtherList.FindChildTraverse("CameraDistanceValue")
    if (value_label) value_label.text = String(normalized)
}

function UpdateCameraDistanceSlider()
{
    let distance = GetCameraDistance()
    let slider = SettingsOtherList && SettingsOtherList.FindChildTraverse("CameraDistanceSlider")
    if (slider)
    {
        slider.SetValueNoEvents(distance)
    }
    UpdateCameraDistanceValue(distance)
}

function QueueCameraDistanceSave(distance)
{
    let normalized = NormalizeCameraDistance(distance)
    let token = ++camera_distance_save_token
    $.Schedule(0.25, function()
    {
        if (token != camera_distance_save_token) return
        GameEvents.SendCustomGameEventToServer("event_game_set_player_setting",
        {
            setting_name: "camera_distance",
            value: normalized,
        })
    })
}

function EnforceCameraDistance()
{
    GameUI.SetCameraDistance(camera_distance_state)
    $.Schedule(0, EnforceCameraDistance)
}

function IsParticlesEnabled()
{
    return IsSettingEnabled("particles_enabled", true)
}

function IsDamageNumbersEnabled()
{
    return IsSettingEnabled("damage_numbers_enabled", true)
}

function UpdateSettingsToggle(row_id, toggle_id, status_id, enabled)
{
    let row = SettingsOtherList.FindChildTraverse(row_id)
    let toggle = SettingsOtherList.FindChildTraverse(toggle_id)
    if (toggle)
    {
        toggle.checked = enabled
        toggle.SetHasClass("settings_toggle_button_active", enabled)
    }

    if (row)
    {
        row.SetHasClass("settings_toggle_row_active", enabled)
    }

    let status = SettingsOtherList.FindChildTraverse(status_id)
    if (status)
    {
        status.text = $.Localize(enabled ? "#settings_state_enabled" : "#settings_state_disabled")
    }

}

function UpdateSettingsOtherPanel()
{
    if (!SettingsOtherList) return

    UpdateSettingsToggle("ParticlesSettingRow", "ParticlesToggle", "ParticlesToggleStatus", IsParticlesEnabled())
    UpdateSettingsToggle("DamageNumbersSettingRow", "DamageNumbersToggle", "DamageNumbersToggleStatus", IsDamageNumbersEnabled())
    UpdateCameraDistanceSlider()
}

function CreateSettingsToggle(row_id, toggle_id, status_id, label_token, setting_name, get_enabled, checked_value_enabled)
{
    let row = $.CreatePanel("Panel", SettingsOtherList, row_id)
    row.AddClass("settings_toggle_row")

    let toggle = $.CreatePanel("ToggleButton", row, toggle_id)
    toggle.AddClass("settings_toggle_button")
    toggle.checked = get_enabled()
    toggle.SetPanelEvent("onactivate", function()
    {
        GameEvents.SendCustomGameEventToServer("event_game_set_player_setting",
        {
            setting_name: setting_name,
            value: checked_value_enabled === false ? (toggle.checked ? 0 : 1) : (toggle.checked ? 1 : 0),
        })
        Game.EmitSound("General.ButtonClick")
    })

    let label = $.CreatePanel("Label", toggle, "")
    label.AddClass("settings_toggle_label")
    label.text = $.Localize(label_token)

    let status_button = $.CreatePanel("Label", toggle, status_id + "Button")
    status_button.AddClass("settings_toggle_status_button")

    let status = $.CreatePanel("Label", status_button, status_id)
    status.AddClass("settings_toggle_status")
}

function InitSettingsOtherPanel()
{
    if (!SettingsOtherList) return

    SettingsOtherList.RemoveAndDeleteChildren()

    CreateSettingsToggle("ParticlesSettingRow", "ParticlesToggle", "ParticlesToggleStatus", "#settings_particles_enabled", "particles_enabled", IsParticlesEnabled, true)
    CreateSettingsToggle("DamageNumbersSettingRow", "DamageNumbersToggle", "DamageNumbersToggleStatus", "#settings_damage_numbers_enabled", "damage_numbers_enabled", IsDamageNumbersEnabled, true)

    let camera_row = $.CreatePanel("Panel", SettingsOtherList, "CameraDistanceSettingRow")
    camera_row.AddClass("settings_slider_row")

    let camera_header = $.CreatePanel("Panel", camera_row, "")
    camera_header.AddClass("settings_slider_header")

    let camera_label = $.CreatePanel("Label", camera_header, "")
    camera_label.AddClass("settings_slider_label")
    camera_label.text = $.Localize("#settings_camera_distance")

    let camera_value = $.CreatePanel("Label", camera_header, "CameraDistanceValue")
    camera_value.AddClass("settings_slider_value")

    let camera_slider = $.CreatePanel("Slider", camera_row, "CameraDistanceSlider", { direction: "horizontal" })
    camera_slider.AddClass("HorizontalSlider")
    camera_slider.AddClass("settings_slider")
    camera_slider.min = CAMERA_DISTANCE_MIN
    camera_slider.max = CAMERA_DISTANCE_MAX
    camera_slider.increment = 1
    camera_slider.default = CAMERA_DISTANCE_DEFAULT
    camera_slider.SetValueNoEvents(GetCameraDistance())
    camera_slider.SetPanelEvent("onvaluechanged", function()
    {
        let distance = NormalizeCameraDistance(camera_slider.value)
        UpdateCameraDistanceValue(distance)
        QueueCameraDistanceSave(distance)
    })

    UpdateSettingsOtherPanel()
}
function InitKeyBinderWindow()
{
    let keybind_is_init = Game.GetKeySet()
    if (!keybind_is_init.ability)
    {
        $.Schedule(0.1, InitKeyBinderWindow)
        return
    }

    KeyBinderList.RemoveAndDeleteChildren()
    InitSettingsOtherPanel()
 
    let keybinds_title_category_panel = $.CreatePanel("Label", KeyBinderList, "keybinds_title_category_panel")
    keybinds_title_category_panel.AddClass("keybinds_title_category_panel")
    keybinds_title_category_panel.text = $.Localize("#key_binds_category_abilities")

    let keybinds_category_panel = $.CreatePanel("Panel", KeyBinderList, "")
    keybinds_category_panel.AddClass("keybinds_category_panel")

    let keybinds_title_category_panel_items = $.CreatePanel("Label", KeyBinderList, "keybinds_title_category_panel_items")
    keybinds_title_category_panel_items.AddClass("keybinds_title_category_panel")
    keybinds_title_category_panel_items.text = $.Localize("#key_binds_category_items")

    let keybinds_category_items = $.CreatePanel("Panel", KeyBinderList, "")
    keybinds_category_items.AddClass("keybinds_category_items")

    let keybinds_title_category_panel_other = $.CreatePanel("Label", KeyBinderList, "keybinds_title_category_panel_other")
    keybinds_title_category_panel_other.AddClass("keybinds_title_category_panel")
    keybinds_title_category_panel_other.text = $.Localize("#key_binds_category_other")

    let keybinds_category_other = $.CreatePanel("Panel", KeyBinderList, "")
    keybinds_category_other.AddClass("keybinds_category_items")

    for (let keybind_data of KeyBindsList["abilities"])
    {
        let keybind_ability_panel = $.CreatePanel("Panel", keybinds_category_panel, "")
        keybind_ability_panel.AddClass("keybind_ability_panel")
        keybind_ability_panel.keybind_type = keybind_data[1]
        keybind_ability_panel.keybind_id = keybind_data[2]
        ShowTextForPanel(keybind_ability_panel, "#"+keybind_data[0])

        let keybind_ability_icon = $.CreatePanel("Image", keybind_ability_panel, "")
        keybind_ability_icon.AddClass("keybind_ability_icon")
        keybind_ability_icon.SetImage("file://{images}/" +keybind_data[3] + ".png")

        let keybind_ability_icon_border = $.CreatePanel("Panel", keybind_ability_panel, "")
        keybind_ability_icon_border.AddClass("keybind_ability_icon_border")

        if (keybind_data[0] == "key_bind_label_1")
        {
            keybind_ability_icon_border.AddClass("keybind_ability_icon_border_golden")
        }
        if (keybind_data[0] == "key_bind_label_2")
        {
            keybind_ability_icon_border.AddClass("keybind_ability_icon_border_golden")
        }
        if (keybind_data[0] == "key_bind_label_6")
        {
            keybind_ability_icon_border.AddClass("keybind_ability_icon_border_golden")
        }

        let key_bind_button = $.CreatePanel("Button", keybind_ability_panel, "")
        key_bind_button.AddClass("key_bind_button")

        let key_bind_button_text = $.CreatePanel("Label", key_bind_button, "key_bind_button_text")
        key_bind_button_text.AddClass("key_bind_button_text")
        key_bind_button_text.text = GetLevelUpKeyBind(keybind_data[1], keybind_data[2])

        keybind_ability_panel.SetPanelEvent("onactivate", function()
        {
            KeyBindChangerActive(keybind_ability_panel, key_bind_button, key_bind_button_text, keybind_data) 
        })
    }
    
    for (let keybind_data of KeyBindsList["items"])
    {
        let keybind_item_panel = $.CreatePanel("Panel", keybinds_category_items, "")
        keybind_item_panel.AddClass("keybind_item_panel")
        keybind_item_panel.keybind_type = keybind_data[1]
        keybind_item_panel.keybind_id = keybind_data[2]
        ShowTextForPanel(keybind_item_panel, "#"+keybind_data[0])
 
        let keybind_item_icon = $.CreatePanel("Panel", keybind_item_panel, "")
        keybind_item_icon.AddClass("keybind_item_icon")

        let keybind_ability_item_border = $.CreatePanel("Panel", keybind_item_panel, "")
        keybind_ability_item_border.AddClass("keybind_ability_item_border")

        let key_bind_button = $.CreatePanel("Button", keybind_item_panel, "")
        key_bind_button.AddClass("key_bind_button")

        let key_bind_button_text = $.CreatePanel("Label", key_bind_button, "key_bind_button_text")
        key_bind_button_text.AddClass("key_bind_button_text")
        key_bind_button_text.text = GetLevelUpKeyBind(keybind_data[1], keybind_data[2])
 
        keybind_item_panel.SetPanelEvent("onactivate", function()
        {
            KeyBindChangerActive(keybind_item_panel, key_bind_button, key_bind_button_text, keybind_data) 
        })
    }

    for (let keybind_data of KeyBindsList["another_abilities"])
    {
        let keybind_item_panel = $.CreatePanel("Panel", keybinds_category_other, "")
        keybind_item_panel.AddClass("keybind_item_panel")
        keybind_item_panel.AddClass("keybind_item_panel_other")
        keybind_item_panel.keybind_type = keybind_data[1]
        keybind_item_panel.keybind_id = keybind_data[2]

        ShowTextForPanel(keybind_item_panel, "#"+keybind_data[0])

        let keybind_item_icon = $.CreatePanel("Image", keybind_item_panel, "")
        keybind_item_icon.AddClass("keybind_item_icon")
        keybind_item_icon.SetImage("file://{images}/" +keybind_data[3] + ".png")

        let keybind_ability_item_border = $.CreatePanel("Panel", keybind_item_panel, "")
        keybind_ability_item_border.AddClass("keybind_ability_item_border")
        keybind_ability_item_border.style.saturation = "0.5"

        let key_bind_button = $.CreatePanel("Button", keybind_item_panel, "")
        key_bind_button.AddClass("key_bind_button")

        let key_bind_button_text = $.CreatePanel("Label", key_bind_button, "key_bind_button_text")
        key_bind_button_text.AddClass("key_bind_button_text")
        key_bind_button_text.text = GetLevelUpKeyBind(keybind_data[1], keybind_data[2])
 
        keybind_item_panel.SetPanelEvent("onactivate", function()
        {
            KeyBindChangerActive(keybind_item_panel, key_bind_button, key_bind_button_text, keybind_data) 
        })
    }
}

function KeyBindChangerActive(keybind_line, key_bind_button, key_bind_button_text, keybind_data) 
{
    for (let key_name of keys_numb)
    {
        $.RegisterKeyBind(key_bind_button, key_name, () => 
        {
            let key_number = key_name.replace("key_", "")
            key_bind_button_text.text = key_number.toUpperCase()
            save_changes_list[keybind_line.keybind_type+"_"+keybind_line.keybind_id] = {value : key_number, keybind_type : keybind_line.keybind_type, keybind_id : keybind_line.keybind_id}
            $.DispatchEvent("DropInputFocus");
        });
    }
    key_bind_button.SetFocus();
}

function UpdateKeybindButtonsInPanel(panel) 
{
    for (const child of panel.Children()) 
    {
        const textPanel = child.FindChildTraverse("key_bind_button_text");
        if (!textPanel) continue;
        textPanel.text = GetLevelUpKeyBind(child.keybind_type, child.keybind_id);
    }
}

Game.SubscribeCustomTableListener("keybinds_data", (table, key, val, old) => 
{
    if (key == String(Game.GetLocalPlayerID()))
    {
        let keybinds_title_category_panel = KeyBinderList.FindChildTraverse("keybinds_title_category_panel")
        if (keybinds_title_category_panel)
        {
            UpdateKeybindButtonsInPanel(keybinds_title_category_panel)
        }
        let keybinds_title_category_panel_items = KeyBinderList.FindChildTraverse("keybinds_title_category_panel_items")
        if (keybinds_title_category_panel_items)
        {
            UpdateKeybindButtonsInPanel(keybinds_title_category_panel_items)
        }
        let keybinds_title_category_panel_other = KeyBinderList.FindChildTraverse("keybinds_title_category_panel_other")
        if (keybinds_title_category_panel_other)
        {
            UpdateKeybindButtonsInPanel(keybinds_title_category_panel_other)
        }
    }
});

Game.SubscribeCustomTableListener("player_settings", (table, key, val, old) =>
{
    if (key == String(Game.GetLocalPlayerID()))
    {
        player_settings_state = val || {}
        UpdateSettingsOtherPanel()
    }
});

function RestoreDefaultHotkeys()
{
    GameEvents.SendCustomGameEventToServer("event_game_restore_default_keybinds", {})
    save_changes_list = {}
    Game.EmitSound("General.ButtonClick")
}

function ServerSaveHotkeys()
{
    GameEvents.SendCustomGameEventToServer("event_game_set_new_keybinds", {new_hotkeys : save_changes_list})
    save_changes_list = {}
    Game.EmitSound("General.ButtonClick")
}

camera_distance_state = GetCameraDistance()
EnforceCameraDistance()
InitKeyBinderWindow()