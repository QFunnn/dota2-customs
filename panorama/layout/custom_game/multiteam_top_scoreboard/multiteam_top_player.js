--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const LocalPlayer = Players.GetLocalPlayer()

function HeroIconClicked(bDoubleClick)
{
    var targetPlayerId = $.GetContextPanel().GetAttributeInt( "player_id", -1 )
    var targetHero = Players.GetPlayerHeroEntityIndex(targetPlayerId)
    if (targetHero != undefined && Entities.IsValidEntity(targetHero)) {
        GameUI.SelectUnit(targetHero, false)
        // [A48] Камера — только по ДВОЙНОМУ клику, клиентски (без серверного лока → без дрейфа).
        if (bDoubleClick) {
            GameUI.MoveCameraToEntity(targetHero)
        }
    }
    GameEvents.SendCustomGameEventToServer('HeroIconClicked', {
        playerId:LocalPlayer,
        targetPlayerId:targetPlayerId,
        doubleClick:bDoubleClick,
        controldown:GameUI.IsControlDown(),
        altdown:GameUI.IsAltDown(),
        is_spectator:Players.IsSpectator( LocalPlayer )
    })
}

function UpdatePlayerReadyList(data)
{
    var targetPlayerId= $.GetContextPanel().GetAttributeInt( "player_id", -1 )
    var playerIsReady = data.readyPlayers[targetPlayerId]
    var playerTick = $("#PlayerIsReady")
    if (playerTick)
    {
        if (playerIsReady != undefined)
        {
            playerTick.visible = true
        }
        else
        {
            playerTick.visible = false
        }
    }
}

function ResetPlayerReadyList(data)
{
    if ($("#PlayerIsReady"))
    {
        $("#PlayerIsReady").visible = false;
    }
}

function TipClicked(){
    GameEvents.SendCustomGameEventToServer( "players_player_want_tip_player", {tips_player:LocalPlayer, tipped_player: $.GetContextPanel().GetAttributeInt("player_id", -1)} )
}

GameEvents.Subscribe('UpdatePlayerReadyList', UpdatePlayerReadyList);
GameEvents.Subscribe('ResetPlayerReadyList', ResetPlayerReadyList);