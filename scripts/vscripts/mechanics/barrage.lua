--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if Barrage == nil then Barrage = class({}) end ---@class Barrage

function Barrage:FireBullet(vData, tExcelusion)
    if tExcelusion then
        for iPlayerID = 0, DOTA_MAX_TEAM_PLAYERS do
            local player = PlayerResource:GetPlayer(iPlayerID)
            if player and TableFindKey(tExcelusion, PlayerResource:GetTeam(iPlayerID)) == nil then
                CustomGameEventManager:Send_ServerToPlayer(player, "FireBullet", vData)
            end
        end
    else
        CustomGameEventManager:Send_ServerToAllClients("FireBullet", vData);
    end
end