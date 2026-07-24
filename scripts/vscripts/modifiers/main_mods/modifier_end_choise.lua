--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




modifier_end_choise = class({})


function modifier_end_choise:IsHidden() return false end
function modifier_end_choise:IsPurgable() return false end
function modifier_end_choise:RemoveOnDeath() return false end
function modifier_end_choise:GetTexture() return "buffs/purple" end


function modifier_end_choise:OnDestroy()
if not IsServer() then return end
if self:GetRemainingTime() > 0.1 then return end

local player = players[self:GetParent():GetId()]

if not player or not player.choise or #player.choise == 0 then return end 

local data = {}
data.PlayerID = self:GetParent():GetPlayerOwnerID()
data.chosen = RandomInt(1, #player.choise)

upgrade:make_choise(data)
end