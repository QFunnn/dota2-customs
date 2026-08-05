--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 19:52:08 UTC
  ~ auto-generated — do not edit
]]


"use strict";
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