--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




modifier_patrol_reward_1_orb = class({})
function modifier_patrol_reward_1_orb:IsHidden() return false end
function modifier_patrol_reward_1_orb:IsPurgable() return false end
function modifier_patrol_reward_1_orb:RemoveOnDeath() return false end
function modifier_patrol_reward_1_orb:GetTexture() return "buffs/restrained_orb" end

function modifier_patrol_reward_1_orb:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.parent:AddDeathEvent(self, true)

self.gold = self.parent:GetTalentValue("modifier_patrol_reward_orb", "gold")
self.blue = self.parent:GetTalentValue("modifier_patrol_reward_orb", "blue")

self:IncStack()
end

function modifier_patrol_reward_1_orb:OnRefresh(table)
if not IsServer() then return end

self:IncStack()
end

function modifier_patrol_reward_1_orb:IncStack()
if not IsServer() then return end
self:IncrementStackCount()

self.parent:EmitSound("Lina.Array_triple")
self.parent:GenericParticle("particles/rare_orb_patrol.vpcf")
end


function modifier_patrol_reward_1_orb:DeathEvent(params)
if not IsServer() then return end
if not IsValid(params.attacker) then return end

local attacker = players[params.attacker:GetId()]

if not attacker then return end
if self.parent ~= attacker then return end
if not params.unit:IsValidKill(self.parent) then return end

self.parent:GiveGold(self.gold, true)
dota1x6:AddBluePoints(self.parent, self.blue)

self:DecrementStackCount()

if self:GetStackCount() <= 0 then 
    self:Destroy()
    return
end

end