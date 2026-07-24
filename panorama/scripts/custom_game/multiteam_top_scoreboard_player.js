--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function HeroIconClicked(bDoubleClick)
{

    var targetPlayerId= $.GetContextPanel().GetAttributeInt( "player_id", -1 )
    var targetHero =Players.GetPlayerHeroEntityIndex(targetPlayerId)
    if  (targetHero!=undefined) {
        GameUI.SelectUnit(targetHero, false)
    }
    GameEvents.SendCustomGameEventToServer('HeroIconClicked', {targetPlayerId:targetPlayerId,doubleClick:bDoubleClick,controldown:GameUI.IsControlDown(),altdown:GameUI.IsAltDown()})
}


function UpdatePlayerReadyList(data)
{
    var targetPlayerId= $.GetContextPanel().GetAttributeInt( "player_id", -1 )
    var playerIsReady = data.readyPlayers[targetPlayerId]
    if (playerIsReady != undefined){
        var playerTick = $("#PlayerIsReady")
        if(playerIsReady == 1){
            playerTick.visible = true
        }else{
            playerTick.visible = false
        }
    }
}

function ResetPlayerReadyList(data)
{
    $("#PlayerIsReady").visible = false;;
}

GameEvents.Subscribe('UpdatePlayerReadyList', UpdatePlayerReadyList);
GameEvents.Subscribe('ResetPlayerReadyList', ResetPlayerReadyList);