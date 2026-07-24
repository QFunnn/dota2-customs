--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var max_time = 0
var used_time = 0
function ShowActorPanel(keys) {


     if (!IsSecurityKeyValid(keys.security_key)) {
          return
     }

     $("#ActorPanel").actor_ui_secret = keys.actor_ui_secret;

     var target_player_id = keys.target_player_id
     var targetPlayerInfo = Game.GetPlayerInfo(target_player_id);
     let vip_data = CustomNetTables.GetTableValue("service", "player_vip")
     if (vip_data != undefined && vip_data[String(Players.GetLocalPlayer())] != undefined) {
          if (vip_data[String(Players.GetLocalPlayer())].level == 1) {
               max_time = 3
          }
          else {
               max_time = 1
          }
     }
     else {
          max_time = 0
     }
     $("#ActorPanelTopLabel").SetDialogVariableInt("time", max_time - used_time);

     if (targetPlayerInfo != undefined) {
          $("#ActorPlayerImage").steamid = targetPlayerInfo.player_steamid;
          $("#ActorHeroImage").SetImage("file://{images}/heroes/" + targetPlayerInfo.player_selected_hero + ".png");
          $("#PlayerName").text = targetPlayerInfo.player_name;
          $("#HeroName").text = $.Localize("#hero_level") + " " + targetPlayerInfo.player_level + " " + $.Localize("#" + targetPlayerInfo.player_selected_hero);
     }
     $("#ActorPanel").target_player_id = target_player_id

     if (max_time - used_time == 0) {
          $("#ActorAcceptButton").enabled = false
     }

     $("#ActorPanel").RemoveClass("Hidden")
}


function Confirm() {
     var target_player_id = $("#ActorPanel").target_player_id
     if (max_time > used_time) {
          GameEvents.SendCustomGameEventToServer("ConfirmActor", {
               target_player_id: target_player_id,
               actor_ui_secret: $("#ActorPanel").actor_ui_secret
          });
          $("#ActorPanel").AddClass("Hidden")
          used_time = used_time + 1
     }
}



function Cancle() {
     $("#ActorPanel").AddClass("Hidden");
}



(function () {
     GameEvents.Subscribe("ShowActorPanel", ShowActorPanel);
})();