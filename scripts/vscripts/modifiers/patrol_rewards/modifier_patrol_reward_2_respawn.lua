--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_patrol_reward_2_respawn_cd", "modifiers/patrol_rewards/modifier_patrol_reward_2_respawn", LUA_MODIFIER_MOTION_NONE)

modifier_patrol_reward_2_respawn = class(mod_visible)
function modifier_patrol_reward_2_respawn:GetTexture() return "omniknight_guardian_angel" end
function modifier_patrol_reward_2_respawn:RemoveOnDeath() return false end
function modifier_patrol_reward_2_respawn:OnCreated(table)
self.parent = self:GetParent()
self.duration = 5*60
self.respawn_time = 3

if not IsServer() then return end

self.parent:AddRespawnEvent(self, true)
self.proced = false

self:SetDuration(self.duration, true)

EmitSoundOnEntityForPlayer("Patrol.Respawn", self.parent, self.parent:GetPlayerOwnerID())
if not self.particle then
	self.particle = self.parent:GenericParticle("particles/patrol_respawn.vpcf", self)
end

end

function modifier_patrol_reward_2_respawn:OnRefresh(table)
if not IsServer() then return end
if self.proced then return end
self:OnCreated()
end

function modifier_patrol_reward_2_respawn:Proc(params)
if not IsServer() then return end

self.proced = true
self:SetDuration(self.respawn_time + 0.3, true)

if self.particle then
	ParticleManager:DestroyParticle(self.particle, false)
	ParticleManager:ReleaseParticleIndex(self.particle)
	self.particle = nil
end

end


function modifier_patrol_reward_2_respawn:RespawnEvent(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end
if self.proced == false then return end

self.proced = false
--self.parent:AddNewModifier(self.parent, nil, "modifier_patrol_reward_2_respawn_cd", {duration = self.cd})

dota1x6:RefreshCooldowns(self.parent, true)
dota1x6:ResetOnRespawn(self.parent)
self:Destroy()
end

function modifier_patrol_reward_2_respawn:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TOOLTIP
}
end

function modifier_patrol_reward_2_respawn:OnTooltip()
return self.respawn_time
end




modifier_patrol_reward_2_respawn_cd = class({})
function modifier_patrol_reward_2_respawn_cd:IsHidden() return false end
function modifier_patrol_reward_2_respawn_cd:IsPurgable() return false end
function modifier_patrol_reward_2_respawn_cd:IsDebuff() return true end
function modifier_patrol_reward_2_respawn_cd:RemoveOnDeath() return false end
function modifier_patrol_reward_2_respawn_cd:GetTexture() return "omniknight_guardian_angel" end