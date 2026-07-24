--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var DebugPanelWindow = {};
var DEBUG_PANEL_LAST_WTF_STATE_UNIT = -1;
var DEBUG_PANEL_LAST_AUTO_KILL_STATE_UNIT = -1;
var DEBUG_PANEL_PICKER_TYPE = "";
var DEBUG_PANEL_RARITY_CLASSES = [
    "CardRarityCommon",
    "CardRarityRare",
    "CardRarityEpic",
    "CardRarityLegendary",
    "CardRarityMythical",
    "CardRaritySSS"
];

function Init() {
    GameEvents.Subscribe("debug_panel_state_for_player_response", OnDebugPanelStateResponse);
    GameEvents.Subscribe("debug_panel_infinite_mana_state", OnInfiniteManaStateResponse);
    GameEvents.Subscribe("debug_panel_auto_kill_attack_state", OnAutoKillStateResponse);
    GameEvents.Subscribe("debug_panel_card_picker_state", OnCardPickerStateResponse);
    GameEvents.Subscribe("debug_panel_hero_picker_state", OnHeroPickerStateResponse);
    OnDebugPanelStateResponse({ disabled: 1, is_developer: 0 });
    GameEvents.SendCustomGameEventToServer("debug_panel_state_for_player", {});
    AwaitDebugWindowInit();
    UpdateWtfModeCheckboxState();
    UpdateAutoKillCheckboxState();
}

function GetSelectedUnit() {
    return Players.GetLocalPlayerPortraitUnit();
}

function PlayButtonSound() {
    Game.EmitSound("UI.Button.Pressed");
}

function SendEvent(eventName, payload) {
    GameEvents.SendCustomGameEventToServer(eventName, payload || {});
    PlayButtonSound();
}

function SendEventForSelectedUnit(eventName, payload) {
    var selectedUnit = GetSelectedUnit();
    if (selectedUnit === -1) {
        return;
    }

    var eventPayload = payload || {};
    eventPayload.unit = selectedUnit;
    SendEvent(eventName, eventPayload);
}

function SendDebugPickerEvent(eventName, payload) {
    var eventPayload = payload || {};
    var selectedUnit = GetSelectedUnit();
    if (selectedUnit !== -1) {
        eventPayload.unit = selectedUnit;
    }
    SendEvent(eventName, eventPayload);
}

function GetTextEntryValue(panelId) {
    var panel = $("#" + panelId);
    if (!panel) {
        return 0;
    }

    var value = parseInt(panel.text, 10);
    if (isNaN(value)) {
        value = 0;
    }

    return Math.floor(value);
}

function GetTextEntryText(panelId) {
    var panel = $("#" + panelId);
    if (!panel) {
        return "";
    }

    return String(panel.text || "");
}

function BuildResourcePayload(resourceName, value) {
    var payload = {};
    if (resourceName === "wood") {
        payload.wood = value;
    } else if (resourceName === "kills") {
        payload.kills = value;
    } else {
        payload.gold = value;
    }
    return payload;
}

function OnTeleportRequest() {
    var point = GameUI.GetCameraLookAtPosition();
    SendEventForSelectedUnit("debug_panel_teleport", {
        point_x: point[0],
        point_y: point[1],
        point_z: point[2]
    });
}

function OnChangeLevelRequest(levels) {
    SendEventForSelectedUnit("debug_panel_change_level", {
        levels: Math.floor(levels)
    });
}

function OnToggleModifierRequest(modifierName) {
    SendEventForSelectedUnit("debug_panel_toggle_modifier", {
        modifier_name: modifierName
    });
}

function OnWtfModeToggle() {
    var panel = $("#WtfModeCheckbox");
    if (!panel) {
        return;
    }

    SendEventForSelectedUnit("debug_panel_set_infinite_mana", {
        enabled: panel.checked ? 1 : 0
    });
}

function OnAutoKillToggle() {
    var panel = $("#AutoKillCheckbox");
    if (!panel) {
        return;
    }

    SendEventForSelectedUnit("debug_panel_set_auto_kill_attack", {
        enabled: panel.checked ? 1 : 0
    });
}

function OnSendNotificationPressed() {
    SendEvent("debug_panel_send_notification", {
        text: GetTextEntryText("DebugNotificationTextEntry")
    });
}

function OnHurtMeBadPressed() {
    SendEventForSelectedUnit("debug_panel_hurt_me_bad", {});
}

function OnKillPressed(forceKill) {
    SendEventForSelectedUnit("debug_panel_kill", {
        force: forceKill ? 1 : 0
    });
}

function OnRespawnPressed() {
    SendEventForSelectedUnit("debug_panel_respawn_hero", {});
}

function OnSetGoldRequest(value) {
    SendEventForSelectedUnit("debug_panel_set_gold", {
        gold: Math.floor(value)
    });
}

function OnChangeGoldRequest(isIncrease) {
    var value = GetTextEntryValue("GoldTextEntry");
    if (!isIncrease) {
        value = value * -1;
    }

    SendEventForSelectedUnit("debug_panel_change_gold", {
        gold: value
    });
}

function OnSetResourceRequest(resourceName, value) {
    SendEventForSelectedUnit(
        "debug_panel_set_" + resourceName,
        BuildResourcePayload(resourceName, Math.floor(value))
    );
}

function OnChangeResourceRequest(resourceName, isIncrease) {
    var entryId = resourceName === "wood" ? "WoodTextEntry" : "KillsTextEntry";
    var value = GetTextEntryValue(entryId);
    if (!isIncrease) {
        value = value * -1;
    }

    SendEventForSelectedUnit(
        "debug_panel_change_" + resourceName,
        BuildResourcePayload(resourceName, value)
    );
}

function OnStageNextRequest() {
    SendEvent("debug_panel_stage_next", {});
}

function OnStageRestartRequest() {
    SendEvent("debug_panel_stage_restart_current", {});
}

function OnGrantHeroChangeRoshanRequest() {
    SendEventForSelectedUnit("debug_panel_grant_hero_change_roshan", {});
}

function OnStageKillAllEnemiesRequest() {
    SendEvent("debug_panel_stage_kill_all_enemies", {});
}

function OnStageBossNowRequest() {
    SendEvent("debug_panel_stage_boss_now", {});
}

function OnSpawnAghanimBossRequest(bossId) {
    SendEvent("debug_panel_spawn_aghanim_boss", {
        boss_id: String(bossId || "")
    });
}

function OnSpawnBossRushBossRequest(bossId) {
    SendEvent("debug_panel_spawn_boss_rush_boss", {
        boss_id: String(bossId || "")
    });
}

function OnOpenCardChoiceWindowRequest() {
    SendEventForSelectedUnit("debug_panel_open_card_choice_window", {});
}

function NormalizeDebugRarityName(rarity) {
    switch (String(rarity || "").toLowerCase()) {
        case "rare":
        case "epic":
        case "legendary":
        case "mythical":
        case "sss":
            return String(rarity).toLowerCase();
        default:
            return "common";
    }
}

function GetDebugRarityClassName(rarity) {
    switch (NormalizeDebugRarityName(rarity)) {
        case "rare":
            return "CardRarityRare";
        case "epic":
            return "CardRarityEpic";
        case "legendary":
            return "CardRarityLegendary";
        case "mythical":
            return "CardRarityMythical";
        case "sss":
            return "CardRaritySSS";
        default:
            return "CardRarityCommon";
    }
}

function ApplyDebugRarityClass(panel, rarity) {
    if (!panel) {
        return;
    }

    for (var i = 0; i < DEBUG_PANEL_RARITY_CLASSES.length; i++) {
        panel.RemoveClass(DEBUG_PANEL_RARITY_CLASSES[i]);
    }
    panel.AddClass(GetDebugRarityClassName(rarity));
}

function GetCardDataForDebug(cardName) {
    var cardData = Game.GetCustomTable("game_data", "card_data") || {};
    return cardData[cardName] || null;
}

function CloseDebugPicker() {
    var panel = $("#DebugPickerPanel");
    if (panel) {
        panel.RemoveClass("Visible");
    }
    DEBUG_PANEL_PICKER_TYPE = "";
}

function OpenDebugPicker(pickerType, titleText, requestEventName) {
    var panel = $("#DebugPickerPanel");
    var title = $("#DebugPickerTitle");
    var grid = $("#DebugPickerGrid");
    var emptyLabel = $("#DebugPickerEmptyLabel");
    if (!panel || !title || !grid || !emptyLabel) {
        return;
    }

    if (panel.BHasClass("Visible") && DEBUG_PANEL_PICKER_TYPE === pickerType) {
        CloseDebugPicker();
        return;
    }

    DEBUG_PANEL_PICKER_TYPE = pickerType;
    title.text = titleText;
    grid.RemoveAndDeleteChildren();
    emptyLabel.visible = true;
    emptyLabel.text = "Loading...";
    panel.AddClass("Visible");
    SendEvent(requestEventName, {});
}

function OnChooseCardButtonPressed() {
    OpenDebugPicker("card", "Choose Card", "debug_panel_request_card_picker_state");
}

function OnChooseHeroButtonPressed() {
    OpenDebugPicker("hero", "Choose Hero", "debug_panel_request_hero_picker_state");
}

function CreateDebugCardPickerItem(parent, cardData) {
    var cardName = String(cardData.card_name || "");
    if (cardName === "") {
        return;
    }

    var fullCardData = GetCardDataForDebug(cardName) || cardData;
    var item = $.CreatePanel("Button", parent, "");
    item.AddClass("DebugPickerItem");
    item.AddClass("DebugCardPickerItem");
    ApplyDebugRarityClass(item, fullCardData.rarity || cardData.rarity);

    var image = $.CreatePanel("Image", item, "");
    image.AddClass("DebugPickerCardImage");
    image.SetImage("file://{images}/card_list/" + cardName + ".png");

    SetCustomTooltip(item, "card_tooltip", {card_name: cardName});

    item.SetPanelEvent("onactivate", function () {
        item.visible = false
        SendDebugPickerEvent("debug_panel_choose_card", {card_name: cardName});
        //CloseDebugPicker();
    });
}

function CreateDebugHeroPickerItem(parent, heroData) {
    var heroName = String(heroData.hero_name || "");
    if (heroName === "") {
        return;
    }

    var item = $.CreatePanel("Button", parent, "");
    item.AddClass("DebugPickerItem");
    item.AddClass("DebugHeroPickerItem");
    ApplyDebugRarityClass(item, heroData.rarity);

    var image = $.CreatePanel("Image", item, "");
    image.AddClass("DebugPickerHeroImage");
    image.SetImage("file://{images}/heroes_list/" + heroName + ".png");

    var quality = $.CreatePanel("Label", item, "");
    quality.AddClass("DebugPickerQualityLabel");
    quality.text = ReplaceQuallityString(heroData.quality || 1);

    var name = $.CreatePanel("Label", item, "");
    name.AddClass("DebugPickerHeroName");
    name.text = $.Localize("#" + heroName);

    if (heroData.ultimate_id) {
        var ability = $.CreatePanel("Image", item, "");
        ability.AddClass("DebugPickerHeroAbility");
        var abilityData = Game.GetCustomTable("ability_card_data", String(heroData.ultimate_id));
        if (abilityData && abilityData.icon) {
            ability.SetImage("file://{images}/spellicons/" + abilityData.icon + ".png");
        }
        SetCustomTooltip(ability, "ability_tooltip", {ability_name: heroData.ultimate_id});
    }

    item.SetPanelEvent("onactivate", function () {
        item.visible = false
        SendDebugPickerEvent("debug_panel_choose_hero", {hero_name: heroName});
        //CloseDebugPicker();
    });
}

function OnCardPickerStateResponse(kv) {
    if (DEBUG_PANEL_PICKER_TYPE !== "card") {
        return;
    }

    var grid = $("#DebugPickerGrid");
    var emptyLabel = $("#DebugPickerEmptyLabel");
    if (!grid || !emptyLabel) {
        return;
    }

    grid.RemoveAndDeleteChildren();
    var cards = Object.values(kv.cards || {});
    emptyLabel.visible = cards.length <= 0;
    emptyLabel.text = "No cards";
    for (var i = 0; i < cards.length; i++) {
        CreateDebugCardPickerItem(grid, cards[i]);
    }
}

function OnHeroPickerStateResponse(kv) {
    if (DEBUG_PANEL_PICKER_TYPE !== "hero") {
        return;
    }

    var grid = $("#DebugPickerGrid");
    var emptyLabel = $("#DebugPickerEmptyLabel");
    if (!grid || !emptyLabel) {
        return;
    }

    grid.RemoveAndDeleteChildren();
    var heroes = Object.values(kv.heroes || {});
    emptyLabel.visible = heroes.length <= 0;
    emptyLabel.text = "No heroes";
    for (var i = 0; i < heroes.length; i++) {
        CreateDebugHeroPickerItem(grid, heroes[i]);
    }
}

function UpdateWtfModeCheckboxState() {
    var panel = $("#WtfModeCheckbox");
    if (panel) {
        var selectedUnit = GetSelectedUnit();
        if (selectedUnit === -1) {
            panel.checked = false;
            DEBUG_PANEL_LAST_WTF_STATE_UNIT = -1;
        } else if (DEBUG_PANEL_LAST_WTF_STATE_UNIT !== selectedUnit) {
            DEBUG_PANEL_LAST_WTF_STATE_UNIT = selectedUnit;
            SendEventForSelectedUnit("debug_panel_request_infinite_mana_state", {});
        }
    }

    $.Schedule(0.1, UpdateWtfModeCheckboxState);
}

function UpdateAutoKillCheckboxState() {
    var panel = $("#AutoKillCheckbox");
    if (panel) {
        var selectedUnit = GetSelectedUnit();
        if (selectedUnit === -1) {
            panel.checked = false;
            DEBUG_PANEL_LAST_AUTO_KILL_STATE_UNIT = -1;
        } else if (DEBUG_PANEL_LAST_AUTO_KILL_STATE_UNIT !== selectedUnit) {
            DEBUG_PANEL_LAST_AUTO_KILL_STATE_UNIT = selectedUnit;
            SendEventForSelectedUnit("debug_panel_request_auto_kill_attack_state", {});
        }
    }

    $.Schedule(0.1, UpdateAutoKillCheckboxState);
}

function OnInfiniteManaStateResponse(kv) {
    var panel = $("#WtfModeCheckbox");
    if (!panel) {
        return;
    }

    var selectedUnit = GetSelectedUnit();
    if (selectedUnit === -1 || selectedUnit !== kv.unit) {
        return;
    }

    panel.checked = kv.enabled == 1;
}

function OnAutoKillStateResponse(kv) {
    var panel = $("#AutoKillCheckbox");
    if (!panel) {
        return;
    }

    var selectedUnit = GetSelectedUnit();
    if (selectedUnit === -1 || selectedUnit !== kv.unit) {
        return;
    }

    panel.checked = kv.enabled == 1;
}

function OnDebugPanelStateResponse(kv) {
    $("#DebugPanelRoot").style.visibility = kv.disabled == 1 ? "collapse" : "visible";
    $("#DebugPanelButton").style.visibility = kv.disabled == 1 ? "collapse" : "visible";
    if (kv.disabled == 1) {
        CloseDebugPicker();
    }
}

function Toggle() {
    var rootPanel = $("#DebugPanelRoot");
    var isMinimized = rootPanel.BHasClass("Minimized");

    Game.EmitSound(isMinimized ? "ui_settings_slide_out" : "ui_settings_slide_in");
    if (!isMinimized) {
        CloseDebugPicker();
    }
    rootPanel.SetHasClass("Minimized", !isMinimized);
}

DebugPanelWindow.Toggle = function () {
    Toggle();
};

function AwaitDebugWindowInit() {
    var rootPanel = $("#DebugPanelRoot");
    if (rootPanel && rootPanel.BReadyForDisplay()) {
        GameUI.CustomUIConfig().DebugPanelWindow = DebugPanelWindow;
    } else {
        $.Schedule(0.25, AwaitDebugWindowInit);
    }
}

Init();