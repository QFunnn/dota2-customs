--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_crellas_crozier_custom_stats", "abilities/items/item_crellas_crozier_custom.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_crellas_crozier_custom_active", "abilities/items/item_crellas_crozier_custom.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_crellas_crozier_custom_aura", "abilities/items/item_crellas_crozier_custom.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_crellas_crozier_custom_health_reduce", "abilities/items/item_crellas_crozier_custom.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_crellas_crozier_custom_health_bonus", "abilities/items/item_crellas_crozier_custom.lua", LUA_MODIFIER_MOTION_NONE )

item_crellas_crozier_custom = class({})

function item_crellas_crozier_custom:GetIntrinsicModifierName()
return "modifier_item_crellas_crozier_custom_stats" 
end

function item_crellas_crozier_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items8_fx/crellas_crozier_pulses.vpcf", context )
PrecacheResource( "particle","particles/items8_fx/crellas_crozier_pulses_target.vpcf", context )
PrecacheResource( "particle","particles/items8_fx/crellas_crozier_debuff.vpcf", context )
end

function item_crellas_crozier_custom:OnSpellStart()
local caster = self:GetCaster()

caster:EmitSound("item_crozier.cast")
caster:AddNewModifier(caster, self, "modifier_item_crellas_crozier_custom_active", {duration = self.duration})
caster:AddNewModifier(caster, self, "modifier_ghost_state", {duration = self.duration})
end

modifier_item_crellas_crozier_custom_stats = class(mod_hidden)
function modifier_item_crellas_crozier_custom_stats:RemoveOnDeath() return false end
function modifier_item_crellas_crozier_custom_stats:OnCreated(keys)
self.parent = self:GetParent()
self.ability = self:GetAbility()
         
self.ability.bonus_all_stats = self.ability:GetSpecialValueFor("bonus_all_stats")
self.ability.bonus_health = self.ability:GetSpecialValueFor("bonus_health")
self.ability.bonus_mana = self.ability:GetSpecialValueFor("bonus_mana")
self.ability.duration = self.ability:GetSpecialValueFor("duration")
self.ability.extra_spell_damage_percent = self.ability:GetSpecialValueFor("extra_spell_damage_percent")
self.ability.radius = self.ability:GetSpecialValueFor("radius")
self.ability.health_steal = self.ability:GetSpecialValueFor("health_steal")
self.ability.interval = self.ability:GetSpecialValueFor("interval")
self.ability.active_radius = self.ability:GetSpecialValueFor("active_radius")
self.ability.active_health_steal = self.ability:GetSpecialValueFor("active_health_steal")

self.ability.movement_slow = self.ability:GetSpecialValueFor("movement_slow")
self.ability.health_reduce = self.ability:GetSpecialValueFor("health_reduce")
self.ability.effect_duration = self.ability:GetSpecialValueFor("effect_duration")
self.ability.max = self.ability:GetSpecialValueFor("max")
end

function modifier_item_crellas_crozier_custom_stats:DeclareFunctions()
return 
{ 
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	MODIFIER_PROPERTY_HEALTH_BONUS,
	MODIFIER_PROPERTY_MANA_BONUS,
}
end

function modifier_item_crellas_crozier_custom_stats:GetModifierBonusStats_Agility()
return self.ability.bonus_all_stats
end

function modifier_item_crellas_crozier_custom_stats:GetModifierBonusStats_Intellect()
return self.ability.bonus_all_stats
end

function modifier_item_crellas_crozier_custom_stats:GetModifierBonusStats_Strength()
return self.ability.bonus_all_stats
end

function modifier_item_crellas_crozier_custom_stats:GetModifierHealthBonus()
return self.ability.bonus_health
end

function modifier_item_crellas_crozier_custom_stats:GetModifierManaBonus()
return self.ability.bonus_mana
end

function modifier_item_crellas_crozier_custom_stats:GetAuraRadius() return self.ability.radius end
function modifier_item_crellas_crozier_custom_stats:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_item_crellas_crozier_custom_stats:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_item_crellas_crozier_custom_stats:GetModifierAura() return "modifier_item_crellas_crozier_custom_aura" end
function modifier_item_crellas_crozier_custom_stats:IsAura() return IsServer() and self.parent:IsRealHero() and self.parent:IsAlive() end


modifier_item_crellas_crozier_custom_aura = class(mod_visible)
function modifier_item_crellas_crozier_custom_aura:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()
self.caster = self:GetCaster()

self.heal_reduction = self.ability.health_steal
self.active_reduce = self.ability.active_health_steal
self.slow = self.ability.movement_slow
if not IsServer() then return end
self.parent:GenericParticle("particles/items8_fx/crellas_crozier_debuff.vpcf", self)
end

function modifier_item_crellas_crozier_custom_aura:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
} 
end

function modifier_item_crellas_crozier_custom_aura:GetModifierMoveSpeedBonus_Percentage()
if not self.caster:HasModifier("modifier_item_crellas_crozier_custom_active") then return end
return self.slow
end

function modifier_item_crellas_crozier_custom_aura:GetModifierHealChange()
return (self.caster:HasModifier("modifier_item_crellas_crozier_custom_active") and self.active_reduce or self.heal_reduction)
end

function modifier_item_crellas_crozier_custom_aura:GetModifierHPRegenAmplify_Percentage()
return (self.caster:HasModifier("modifier_item_crellas_crozier_custom_active") and self.active_reduce or self.heal_reduction)
end


modifier_item_crellas_crozier_custom_active = class(mod_hidden)
function modifier_item_crellas_crozier_custom_active:IsPurgable() return true end
function modifier_item_crellas_crozier_custom_active:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.active_radius = self.ability.active_radius
self.duration = self.ability.effect_duration
if not IsServer() then return end
self:OnIntervalThink()
self:StartIntervalThink(self.ability.interval - FrameTime())
end

function modifier_item_crellas_crozier_custom_active:OnIntervalThink()
if not IsServer() then return end

local particle = ParticleManager:CreateParticle("particles/items8_fx/crellas_crozier_pulses.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(particle, 1, Vector(self.active_radius, 0, 0))
ParticleManager:ReleaseParticleIndex(particle)

self.parent:EmitSound("item_crozier.pulse")

local targets = self.parent:FindTargets(self.active_radius) 
for _,target in pairs(targets) do
	if target:IsRealHero() then
		local dir = (self.parent:GetAbsOrigin() - target:GetAbsOrigin()):Normalized()

		local particle = ParticleManager:CreateParticle("particles/items8_fx/crellas_crozier_pulses_target.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
		ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), false)
		ParticleManager:SetParticleControlEnt(particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), false)
		ParticleManager:SetParticleControlEnt(particle, 2, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), false)
		ParticleManager:SetParticleControlEnt(particle, 3, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false)
		ParticleManager:ReleaseParticleIndex(particle)

		target:AddNewModifier(self.parent, self.ability, "modifier_item_crellas_crozier_custom_health_reduce", {duration = self.duration})
	end
end

end

modifier_item_crellas_crozier_custom_health_reduce = class(mod_visible)
function modifier_item_crellas_crozier_custom_health_reduce:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max_health = self.parent:GetMaxHealth()
self.max = self.ability.max
self.health = (self.ability.health_reduce*self.ability.duration)/self.max

if not IsServer() then return end
self.RemoveForDuel = true
self.duration = self:GetRemainingTime()

self:AddStack(table)
end

function modifier_item_crellas_crozier_custom_health_reduce:OnRefresh(table)
if not IsServer() then return end
self:AddStack(table)
end

function modifier_item_crellas_crozier_custom_health_reduce:AddStack(table)
if not IsServer() then return end

if self:GetStackCount() < self.max then
	self:IncrementStackCount()
end

self:SendHealth()
end

function modifier_item_crellas_crozier_custom_health_reduce:SendHealth()
if not IsServer() then return end

local health = self.max_health*self.health*self:GetStackCount()/100

if not IsValid(self.health_mod) then
  self.health_mod = self.caster:AddNewModifier(self.caster, self.ability, "modifier_item_crellas_crozier_custom_health_bonus", {duration = self.duration, health = health})
else
  self.health_mod:SetDuration(self.duration, true)
  self.health_mod:AddHealth({health = health})
end

end

function modifier_item_crellas_crozier_custom_health_reduce:OnStackCountChanged(iStackCount)
if not IsServer() then return end
if not self.parent:IsHero() then return end
self.parent:CalculateStatBonus(true)
end

function modifier_item_crellas_crozier_custom_health_reduce:OnDestroy()
if not IsServer() then return end
if IsValid(self.health_mod) then
  self.health_mod:Destroy()
end

self:OnStackCountChanged()
end

function modifier_item_crellas_crozier_custom_health_reduce:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE
}
end

function modifier_item_crellas_crozier_custom_health_reduce:GetModifierExtraHealthPercentage()
return self.health*self:GetStackCount()*-1
end


modifier_item_crellas_crozier_custom_health_bonus = class(mod_visible)
function modifier_item_crellas_crozier_custom_health_bonus:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_crellas_crozier_custom_health_bonus:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self:AddHealth(table)
end

function modifier_item_crellas_crozier_custom_health_bonus:AddHealth(table)
if not IsServer() then return end
self:SetStackCount(table.health)
self.parent:CalculateStatBonus(true)
end

function modifier_item_crellas_crozier_custom_health_bonus:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_HEALTH_BONUS,
}
end

function modifier_item_crellas_crozier_custom_health_bonus:GetModifierHealthBonus()
return self:GetStackCount()
end