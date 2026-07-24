--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_life_stealer_ursa_clap_slow", "abilities/life_stealer/infest_creeps_ursa", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_life_stealer_ursa_overpower", "abilities/life_stealer/infest_creeps_ursa", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_life_stealer_ursa_crit", "abilities/life_stealer/infest_creeps_ursa", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_life_stealer_ursa_crit_armor", "abilities/life_stealer/infest_creeps_ursa", LUA_MODIFIER_MOTION_NONE )

life_stealer_ursa_clap = class({})

function life_stealer_ursa_clap:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf", context )
PrecacheResource( "particle", "particles/hoodwink/bush_damage.vpcf", context )
end

function life_stealer_ursa_clap:GetCastRange(vector, hTarget)
return self:GetSpecialValueFor("aoe")
end

function life_stealer_ursa_clap:OnAbilityPhaseStart()
local caster = self:GetCaster()
caster:EmitSound("n_creep_Ursa.Clap")

caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.3)
return true
end

function life_stealer_ursa_clap:OnAbilityPhaseInterrupted()
self:GetCaster():StopSound("n_creep_Ursa.Clap")
self:GetCaster():FadeGesture(ACT_DOTA_CAST_ABILITY_1)
end

function life_stealer_ursa_clap:GetCooldown(level)
local bonus = 0
if self.caster.infest_ability and self.caster.infest_ability.talents.r1_cd_creep then
	bonus = self.caster.infest_ability.talents.r1_cd_creep
end
return self.BaseClass.GetCooldown( self, level ) + bonus
end

function life_stealer_ursa_clap:OnSpellStart()
local caster = self:GetCaster()
local duration = self:GetSpecialValueFor("duration")
local radius = self:GetSpecialValueFor("aoe")

local trail_pfx = ParticleManager:CreateParticle("particles/neutral_fx/ursa_thunderclap.vpcf", PATTACH_ABSORIGIN, caster)
ParticleManager:SetParticleControl(trail_pfx, 1, Vector(radius, radius, radius))
ParticleManager:ReleaseParticleIndex(trail_pfx) 

for _,target in pairs(caster:FindTargets(radius)) do
	target:RemoveModifierByName("modifier_life_stealer_ursa_clap_slow")
	target:AddNewModifier(caster, self, "modifier_life_stealer_ursa_clap_slow", { duration = duration })
end
      
end


modifier_life_stealer_ursa_clap_slow = class({})
function modifier_life_stealer_ursa_clap_slow:IsPurgable() return false end
function modifier_life_stealer_ursa_clap_slow:IsHidden() return false end
function modifier_life_stealer_ursa_clap_slow:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_life_stealer_ursa_clap_slow:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.crit = self.ability:GetSpecialValueFor("damage")
self.slow = self.ability:GetSpecialValueFor("slow")
if not IsServer() then return end
self:SetStackCount(self.ability:GetSpecialValueFor("count"))
self.effect = self.parent:GenericParticle("particles/hoodwink/bush_damage.vpcf", self)
end

function modifier_life_stealer_ursa_clap_slow:RemoveEffect()
if not IsServer() then return end
if not self.effect then return end

ParticleManager:DestroyParticle(self.effect, false)
ParticleManager:ReleaseParticleIndex(self.effect)
self.effect = nil
end

function modifier_life_stealer_ursa_clap_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_life_stealer_ursa_clap_slow:GetEffectName()
return "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf"
end

function modifier_life_stealer_ursa_clap_slow:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_life_stealer_ursa_clap_slow:GetStatusEffectName()
return "particles/status_fx/status_effect_snapfire_slow.vpcf"
end

function modifier_life_stealer_ursa_clap_slow:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL
end






life_stealer_ursa_overpower = class({})

function life_stealer_ursa_overpower:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_overpower_buff.vpcf", context )
end


function life_stealer_ursa_overpower:OnSpellStart()
local caster = self:GetCaster()
local duration = self:GetSpecialValueFor("duration")

if self.caster.infest_ability and self.caster.infest_ability.talents.has_h6 == 1 then
	duration = duration + self.caster.infest_ability.talents.h6_duration_creep
end

if self.caster.infest_ability and self.caster.infest_ability.talents.has_r4 == 1 then
	self.caster:GenericHeal(self.caster.infest_ability.talents.r4_heal_creep*self.caster:GetMaxHealth(), self.caster.infest_ability, nil, nil, "modifier_lifestealer_infest_4")
end

caster:EmitSound("Lifestealer.Infest_ursa_overpower")
caster:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_3)
caster:RemoveModifierByName("modifier_life_stealer_infest_custom_legendary_creep_status")
caster:RemoveModifierByName("modifier_life_stealer_ursa_overpower")
caster:AddNewModifier(caster, self, "modifier_life_stealer_ursa_overpower", {duration = duration})
end


modifier_life_stealer_ursa_overpower = class(mod_visible)
function modifier_life_stealer_ursa_overpower:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move = self.ability:GetSpecialValueFor("move")
self.speed = self.ability:GetSpecialValueFor("speed")

if not IsServer() then return end

local ursa_overpower_buff_particle_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_ursa/ursa_overpower_buff.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
ParticleManager:SetParticleControlEnt(ursa_overpower_buff_particle_fx, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(ursa_overpower_buff_particle_fx, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(ursa_overpower_buff_particle_fx, 2, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(ursa_overpower_buff_particle_fx, 3, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
self:AddParticle(ursa_overpower_buff_particle_fx, false, false, -1, false, false)
end

function modifier_life_stealer_ursa_overpower:OnDestroy()
if not IsServer() then return end
self.parent:AddNewModifier(self.parent, self.ability, "modifier_life_stealer_infest_custom_legendary_creep_status", {})
end

function modifier_life_stealer_ursa_overpower:CheckState()
return
{
	[MODIFIER_STATE_CANNOT_MISS] = true,
	[MODIFIER_STATE_UNSLOWABLE] = true
}
end

function modifier_life_stealer_ursa_overpower:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
}
end

function modifier_life_stealer_ursa_overpower:GetModifierMoveSpeedBonus_Constant()
return self.move
end

function modifier_life_stealer_ursa_overpower:GetModifierAttackSpeedBonus_Constant()
return self.speed
end

function modifier_life_stealer_ursa_overpower:GetStatusEffectName()
return "particles/status_fx/status_effect_overpower.vpcf"
end

function modifier_life_stealer_ursa_overpower:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA
end




life_stealer_ursa_crit = class({})

function life_stealer_ursa_crit:GetIntrinsicModifierName()
return "modifier_life_stealer_ursa_crit"
end

modifier_life_stealer_ursa_crit = class(mod_hidden)
function modifier_life_stealer_ursa_crit:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.duration = self.ability:GetSpecialValueFor("duration")
self.record = nil

if not IsServer() then return end
self:StartIntervalThink(0.1)
end

function modifier_life_stealer_ursa_crit:OnIntervalThink()
if not IsServer() then return end
if not self.parent.owner then return end
self.parent.owner:AddAttackEvent_out(self, true)
self.parent.owner:AddAttackStartEvent_out(self)
self:StartIntervalThink(-1)
end

function modifier_life_stealer_ursa_crit:OnRefresh(table)
self.crit = self.ability:GetSpecialValueFor("damage")
end

function modifier_life_stealer_ursa_crit:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
	MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
}
end

function modifier_life_stealer_ursa_crit:GetModifierPreAttack_CriticalStrike(params)
if not IsServer() then return end
self.record = nil
local mod = params.target:FindModifierByName("modifier_life_stealer_ursa_clap_slow")
if not mod or mod:GetStackCount() <= 0 then return end

self.record = params.record
local damage = mod.crit

local mod = params.target:FindModifierByName("modifier_life_stealer_infest_custom_legendary_bonus")
if mod then
	damage = damage + mod.bonus*mod:GetStackCount()*100
end
return damage
end

function modifier_life_stealer_ursa_crit:AttackStartEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end

if self.record == params.record then
	local mod = params.target:FindModifierByName("modifier_life_stealer_ursa_clap_slow")
	if mod then
		mod:DecrementStackCount()
		if mod:GetStackCount() <= 0 then
			mod:RemoveEffect()
			if self.parent.infest_ability and self.parent.infest_ability.talents.has_r3 == 1 then
				params.target:AddNewModifier(self.parent, self.parent.infest_ability, "modifier_life_stealer_infest_custom_legendary_bonus", {duration = self.parent.infest_ability.talents.r3_duration})
			end
		end
	end
end

end

function modifier_life_stealer_ursa_crit:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end

if self.record == params.record then
	params.target:EmitSound("DOTA_Item.Daedelus.Crit")
end

params.target:AddNewModifier(self.parent, self.ability, "modifier_life_stealer_ursa_crit_armor", {duration = self.duration})
end


modifier_life_stealer_ursa_crit_armor = class(mod_visible)
function modifier_life_stealer_ursa_crit_armor:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability:GetSpecialValueFor("max")
self.armor = self.ability:GetSpecialValueFor("armor")
if not IsServer() then return end
self:OnRefresh()
end

function modifier_life_stealer_ursa_crit_armor:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max then
	self.parent:EmitSound("Hoodwink.Acorn_armor")
end

end

function modifier_life_stealer_ursa_crit_armor:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_life_stealer_ursa_crit_armor:GetModifierPhysicalArmorBonus()
return self:GetStackCount()*self.armor
end