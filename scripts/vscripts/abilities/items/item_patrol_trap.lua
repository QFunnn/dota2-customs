--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--LinkLuaModifier("", "abilities/items/item_patrol_trap", LUA_MODIFIER_MOTION_NONE)

item_patrol_trap                = class({})


function item_patrol_trap:OnAbilityPhaseStart()
local player = self:GetCaster()
local tower = towers[self:GetCaster():GetTeamNumber()]

if tower == nil then return false end


if tower.trap_wave == true  then 
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID()), "CreateIngameErrorMessage", {message = "#active_trap"}) 
    return false
end

if duel_data[tower.duel_data] and duel_data[tower.duel_data].finished == 0 then 
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID()), "CreateIngameErrorMessage", {message = "#active_duel"}) 
    return false
end

if tower.can_use_trap == false then 
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID()), "CreateIngameErrorMessage", {message = "#active_necro"}) 
    return false
end

return true 

end


function item_patrol_trap:OnSpellStart()
if not IsServer() then return end

local player = self:GetCaster()
local team = player:GetTeamNumber()
local tower = towers[self:GetCaster():GetTeamNumber()]

if not tower then return end

--CustomGameEventManager:Send_ServerToAllClients("TrapAlert",  {victim = self:GetCaster():GetUnitName()})

CustomGameEventManager:Send_ServerToAllClients("mini_alert_event",  {hero_1 = player:GetUnitName(), event_type = "trap"})

local ids = dota1x6:FindPlayers(team)
if ids then
    for _,id in pairs(ids) do
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "TrapAlert_start",  {})
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "TrapAlert_think",  {time = Trap_Duration, max = Trap_Duration})
    end
end


tower.trap_wave = true

self:SpendCharge(0)
end