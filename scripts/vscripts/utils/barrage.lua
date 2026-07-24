--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if Barrage == nil then 
    Barrage = class({}) 
end

function Barrage:Init()
    ListenToGameEvent("player_chat", Dynamic_Wrap(Barrage, "OnPlayerSay"), self)   
end

function Barrage:OnPlayerSay(params) 
    local hPlayer = PlayerResource:GetPlayer( params.playerid )
    if not hPlayer or hPlayer:IsNull() then return end
    local hHero = hPlayer:GetAssignedHero()
    if hHero==nil then return end
    local nPlayerId= hHero:GetPlayerID()
    local szText = string.trim(params.text)
    if ( GetMapName()=="2x6" or  GetMapName()=="5v5" )  and  1 == params.teamonly then
        return
    end
    local vData={}
    vData.type = "player_say"
    vData.playerId = nPlayerId
    vData.content =szText
    self:FireBullet(vData)
end

function Barrage:FireBullet(vData, Exceptions)
    if not GAME_BARRAGE_ENABLED then return end
    
    if not Exceptions then
        CustomGameEventManager:Send_ServerToAllClients("FireBullet", vData);
    else
        for _, PlayerID in ipairs(Players:GetAllPlayers(true)) do
            if not table.contains(Exceptions, PlayerID) then
                CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(PlayerID), "FireBullet", vData)
            end
        end
    end
end