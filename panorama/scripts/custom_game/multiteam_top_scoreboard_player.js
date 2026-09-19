--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";
const PLAYER_TIP_COST = 50;
const PLAYER_TIP_COOLDOWN_SECONDS = 15;
let playerTipAltScheduleStarted = false;
let playerTipPanelInitialized = false;
function getPlayerTipConfig() {
    return GameUI.CustomUIConfig();
}
function getPlayerTipCooldownEnd() {
    var _a;
    return (_a = getPlayerTipConfig().playerTipCooldownEnd) !== null && _a !== void 0 ? _a : 0;
}
function setPlayerTipCooldown(seconds) {
    getPlayerTipConfig().playerTipCooldownEnd = Game.GetGameTime() + seconds;
}
function OnHeroIconClicked(isDoubleClick) {
    const targetPlayerId = $.GetContextPanel().GetAttributeInt("player_id", -1);
    $.Msg(`ContextPanelId is ${$.GetContextPanel().id}`);
    const targetHeroEnt = Players.GetPlayerHeroEntityIndex(targetPlayerId);
    $.Msg(`Target Hero is ${Entities.GetUnitName(targetHeroEnt)}. PlayerId = ${targetPlayerId}`);
    if (GameUI.IsAltDown()) {
        GameUI.ShowActorPanel(targetPlayerId);
        return;
    }
    if (targetHeroEnt != undefined) {
        GameUI.SelectUnit(targetHeroEnt, false);
        GameUI.SetCameraTargetPosition(Entities.GetAbsOrigin(targetHeroEnt), -1);
    }
}
function DOTAPlayerTip() {
    var _a;
    const targetPlayerId = $.GetContextPanel().GetAttributeInt("player_id", -1);
    const localPlayerId = Players.GetLocalPlayer();
    if (targetPlayerId < 0 || targetPlayerId === localPlayerId) {
        return;
    }
    const now = Game.GetGameTime();
    const cooldownEnd = getPlayerTipCooldownEnd();
    if (cooldownEnd > now) {
        const remaining = Math.ceil(cooldownEnd - now);
        GameEvents.SendEventClientSide("dota_hud_error_message", {
            reason: 80,
            message: $.Localize("#dota_hud_error_tip_cooldown").replace("{seconds}", String(remaining)),
            sequenceNumber: 1,
        });
        return;
    }
    const playerInfo = CustomNetTables.GetTableValue("player_info_shop", String(localPlayerId));
    if (((_a = playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.gold) !== null && _a !== void 0 ? _a : 0) < PLAYER_TIP_COST) {
        GameEvents.SendEventClientSide("dota_hud_error_message", {
            reason: 80,
            message: $.Localize("#dota_hud_error_not_enough_coins"),
            sequenceNumber: 1,
        });
        return;
    }
    setPlayerTipCooldown(PLAYER_TIP_COOLDOWN_SECONDS);
    updateTipButtonState();
    GameEvents.SendCustomGameEventToServer("player_tip_request", {
        target_player_id: targetPlayerId,
    });
}
function initPlayerTipPanel() {
    if (playerTipPanelInitialized) {
        return;
    }
    const context = $.GetContextPanel();
    const host = $("#TipPanelHost");
    if (!host) {
        $.Schedule(0.1, initPlayerTipPanel);
        return;
    }
    playerTipPanelInitialized = true;
    host.BLoadLayout("file://{resources}/layout/custom_game/hud_top_bar/tip.xml", false, false);
    const tipButton = host.FindChildTraverse("TipButton");
    tipButton === null || tipButton === void 0 ? void 0 : tipButton.SetPanelEvent("onactivate", DOTAPlayerTip);
    tipButton === null || tipButton === void 0 ? void 0 : tipButton.SetPanelEvent("onmouseover", () => {
        $.DispatchEvent("DOTAShowTextTooltip", tipButton, $.Localize("#DOTA_TipPlayer"));
    });
    tipButton === null || tipButton === void 0 ? void 0 : tipButton.SetPanelEvent("onmouseout", () => {
        $.DispatchEvent("DOTAHideTextTooltip", tipButton);
    });
    context.SetDialogVariable("tip_name", "+++");
    host.SetDialogVariable("tip_name", "+++");
    updateTipButtonState();
    if (!playerTipAltScheduleStarted) {
        playerTipAltScheduleStarted = true;
        updateAltTipVisibility();
    }
}
function updateAltTipVisibility() {
    const context = $.GetContextPanel();
    const host = $("#TipPanelHost");
    const targetPlayerId = context.GetAttributeInt("player_id", -1);
    const isVisible = GameUI.IsAltDown() && targetPlayerId >= 0 && targetPlayerId !== Players.GetLocalPlayer();
    host === null || host === void 0 ? void 0 : host.SetHasClass("TipsAvailable", isVisible);
    host === null || host === void 0 ? void 0 : host.SetHasClass("AltPressed", isVisible);
    setTipPanelVisibility(host, isVisible);
    updateTipButtonState();
    $.Schedule(0.05, updateAltTipVisibility);
}
function setTipPanelVisibility(host, isVisible) {
    const visibility = isVisible ? "visible" : "collapse";
    const tipButton = host === null || host === void 0 ? void 0 : host.FindChildTraverse("TipButton");
    const tipContainer = tipButton === null || tipButton === void 0 ? void 0 : tipButton.GetParent();
    if (tipContainer) {
        tipContainer.style.visibility = visibility;
    }
    if (tipButton) {
        tipButton.style.visibility = visibility;
    }
}
function updateTipButtonState() {
    var _a, _b;
    const tipButton = (_a = $("#TipPanelHost")) === null || _a === void 0 ? void 0 : _a.FindChildTraverse("TipButton");
    if (!tipButton) {
        return;
    }
    const localPlayerId = Players.GetLocalPlayer();
    const playerInfo = CustomNetTables.GetTableValue("player_info_shop", String(localPlayerId));
    const hasCoins = ((_b = playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.gold) !== null && _b !== void 0 ? _b : 0) >= PLAYER_TIP_COST;
    const ready = Game.GetGameTime() >= getPlayerTipCooldownEnd();
    tipButton.enabled = hasCoins && ready;
}
function UpdatePlayerReadyList(data) {
    const targetPlayerId = $.GetContextPanel().GetAttributeInt("player_id", -1);
    const playerIsReady = data.readyPlayers[targetPlayerId];
    if (playerIsReady != undefined) {
        const playerTick = $("#PlayerIsReady");
        if (playerIsReady == 1) {
            playerTick.visible = true;
            return;
        }
        playerTick.visible = false;
    }
}
function ResetPlayerReadyList(data) {
    $("#PlayerIsReady").visible = false;
    ;
}
GameEvents.Subscribe('UpdatePlayerReadyList', UpdatePlayerReadyList);
GameEvents.Subscribe('ResetPlayerReadyList', ResetPlayerReadyList);
GameEvents.Subscribe("player_tip_denied", (event) => {
    var _a;
    const cooldownRemaining = Math.max(0, (_a = event.cooldown_remaining) !== null && _a !== void 0 ? _a : 0);
    setPlayerTipCooldown(cooldownRemaining);
    if (event.message) {
        GameEvents.SendEventClientSide("dota_hud_error_message", {
            reason: 80,
            message: $.Localize(`#${event.message}`).replace("{seconds}", String(Math.ceil(cooldownRemaining))),
            sequenceNumber: 1,
        });
    }
    updateTipButtonState();
});
CustomNetTables.SubscribeNetTableListener("player_info_shop", (_, key) => {
    if (key === String(Players.GetLocalPlayer())) {
        updateTipButtonState();
    }
});
initPlayerTipPanel();