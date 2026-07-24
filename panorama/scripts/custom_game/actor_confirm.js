--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
GameUI.ShowActorPanel = (targetPlayerId) => ShowActorPanel(targetPlayerId);
function ShowActorPanel(targetPlayerId) {
    var targetPlayerInfo = Game.GetPlayerInfo(targetPlayerId);
    // $("#ActorPanelTopLabel").SetDialogVariableInt("time", max_time - used_time);
    if (targetPlayerInfo != undefined) {
        $("#ActorPlayerImage").steamid = targetPlayerInfo.player_steamid;
        $("#ActorHeroImage").SetImage("file://{images}/heroes/" + targetPlayerInfo.player_selected_hero + ".png");
        $("#PlayerName").text = targetPlayerInfo.player_name;
        $("#HeroName").text = $.Localize("#hero_level") + " " + targetPlayerInfo.player_level + " " + $.Localize("#" + targetPlayerInfo.player_selected_hero);
    }
    $("#ActorPanel").RemoveClass("Hidden");
}
// function Confirm() {
//     var target_player_id = $("#ActorPanel").target_player_id
//     if (max_time > used_time) {
//         GameEvents.SendCustomGameEventToServer("ConfirmActor", {
//             player_id: Game.GetLocalPlayerInfo().player_id,
//             target_player_id: target_player_id,
//             actor_ui_secret: $("#ActorPanel").actor_ui_secret
//         });
//         $("#ActorPanel").AddClass("Hidden")
//         used_time = used_time + 1
//     }
// }
function Cancel() {
    $("#ActorPanel").AddClass("Hidden");
}