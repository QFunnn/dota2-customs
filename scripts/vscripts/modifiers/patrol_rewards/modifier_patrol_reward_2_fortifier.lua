--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_patrol_reward_2_fortifier_effect", "modifiers/patrol_rewards/modifier_patrol_reward_2_fortifier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_patrol_reward_2_fortifier_tower", "modifiers/patrol_rewards/modifier_patrol_reward_2_fortifier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_patrol_reward_2_fortifier_tower_leash", "modifiers/patrol_rewards/modifier_patrol_reward_2_fortifier", LUA_MODIFIER_MOTION_NONE)

modifier_patrol_reward_2_fortifier = class({})
function modifier_patrol_reward_2_fortifier:IsHidden() return false end
function modifier_patrol_reward_2_fortifier:RemoveOnDeath() return false end
function modifier_patrol_reward_2_fortifier:IsPurgable() return false end


function modifier_patrol_reward_2_fortifier:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()

local tower = towers[self.parent:GetTeamNumber()]
if not tower then 
	self:Destroy()
	return 
end

EmitSoundOnEntityForPlayer("Patrol.Fortifier_start", self.parent, self.parent:GetPlayerOwnerID())
local count = 4

local fillers = FindUnitsInRadius(self.parent:GetTeamNumber(), tower:GetAbsOrigin(), nil, 2000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)
for _,filler in pairs(fillers) do
	count = count - 1
	filler:RemoveModifierByName("modifier_patrol_reward_2_fortifier_effect")
	filler:AddNewModifier(self.parent, nil, "modifier_patrol_reward_2_fortifier_effect", {})
end 

if count > 0 then
	for i = 1, count do
		tower:AddNewModifier(self.parent, nil, "modifier_patrol_reward_2_fortifier_effect", {})
	end
end


self:Destroy()
end




modifier_patrol_reward_2_fortifier_effect = class({})
function modifier_patrol_reward_2_fortifier_effect:IsHidden() return true end
function modifier_patrol_reward_2_fortifier_effect:IsPurgable() return false end
function modifier_patrol_reward_2_fortifier_effect:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.stack = self.caster:GetTalentValue("modifier_patrol_reward_fortifier", "shield")
if not IsServer() then return end

self.tower = towers[self.parent:GetTeamNumber()]
if not self.tower then
	self:Destroy()
	return
end

self.particle_name = "particles/patrol/fortifier_stack.vpcf"
if self.parent == self.tower then
	self.parent:EmitSound("Patrol.Fortifier_start")
	self.particle_name = "particles/patrol/fortifier_stack_tower.vpcf"
end

self.tower_mod = self.tower:AddNewModifier(self.tower, nil, "modifier_patrol_reward_2_fortifier_tower", {})

self.particle = ParticleManager:CreateParticle("particles/patrol/fortifier_effect.vpcf" , PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 1, Vector(160,1,1))
self:AddParticle(self.particle, false, false, -1, false, false)

self:SetStackCount(self.stack)
end



function modifier_patrol_reward_2_fortifier_effect:OnRefresh(table)
if not IsServer() then return end
self:SetStackCount(self:GetStackCount() + self.stack)
end


function modifier_patrol_reward_2_fortifier_effect:OnStackCountChanged(iStackCount)
if not IsServer() then return end

if not self.pfx then
	self.pfx = self.parent:GenericParticle(self.particle_name, self, true)
end

local k1 = 0
local k2 = self:GetStackCount()

if k2 >= 10 then 
    k1 = 1
    k2 = self:GetStackCount() - 10
end

ParticleManager:SetParticleControl( self.pfx, 1, Vector( k1, k2, 0 ) )
end


function modifier_patrol_reward_2_fortifier_effect:ClearParticle()
if not IsServer() then return end
if not self.pfx then return end

ParticleManager:DestroyParticle(self.pfx, true)
ParticleManager:ReleaseParticleIndex(self.pfx)
self.pfx = nil

end

function modifier_patrol_reward_2_fortifier_effect:DealDamage()
if not IsServer() then return end
self:DecrementStackCount()

self.parent:EmitSound("Patrol.Fortifier_damage")
self.effect_cast = ParticleManager:CreateParticle("particles/patrol/fortifier_effect_damage.vpcf", PATTACH_ABSORIGIN, self.parent)
ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 200, 0, 0) )
ParticleManager:ReleaseParticleIndex(self.effect_cast)

if self:GetStackCount() > 0 then return end

self:Destroy()
end


function modifier_patrol_reward_2_fortifier_effect:OnDestroy()
if not IsServer() then return end

if self.tower_mod and not self.tower_mod:IsNull() then
	self.tower_mod:Destroy()
end

end

modifier_patrol_reward_2_fortifier_tower = class({})
function modifier_patrol_reward_2_fortifier_tower:IsHidden() return true end
function modifier_patrol_reward_2_fortifier_tower:IsPurgable() return false end
function modifier_patrol_reward_2_fortifier_tower:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end


modifier_patrol_reward_2_fortifier_tower_leash = class({})
function modifier_patrol_reward_2_fortifier_tower_leash:IsHidden() return true end
function modifier_patrol_reward_2_fortifier_tower_leash:IsPurgable() return true end
function modifier_patrol_reward_2_fortifier_tower_leash:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()

self.slow = self.caster:GetTalentValue("modifier_patrol_reward_fortifier", "slow", true)

if not IsServer() then return end
self.parent:GenericParticle("particles/patrol/fortifier_slow.vpcf", self)
end

function modifier_patrol_reward_2_fortifier_tower_leash:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_patrol_reward_2_fortifier_tower_leash:CheckState()
return
{
	[MODIFIER_STATE_TETHERED] = true
}
end

function modifier_patrol_reward_2_fortifier_tower_leash:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end