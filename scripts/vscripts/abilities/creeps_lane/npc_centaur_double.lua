--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_centaur_double_heal", "abilities/creeps_lane/npc_centaur_double", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_centaur_double_slow", "abilities/creeps_lane/npc_centaur_double", LUA_MODIFIER_MOTION_NONE)

npc_centaur_double = class({})

function npc_centaur_double:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_centaur/centaur_double_edge_phase.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_centaur/centaur_double_edge.vpcf", context)
end

function npc_centaur_double:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.heal = self:GetLevelSpecialValueFor("heal", 1)
	self.slow = self:GetLevelSpecialValueFor("slow", 1)
	self.duration = self:GetLevelSpecialValueFor("duration", 1)
	self.duration_heal = self:GetLevelSpecialValueFor("duration_heal", 1)
	self.damage = self:GetLevelSpecialValueFor("damage", 1)
end

function npc_centaur_double:OnAbilityPhaseStart()
	local point = self.caster:GetAbsOrigin()

	self.phase_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_centaur/centaur_double_edge_phase.vpcf",
		PATTACH_CUSTOMORIGIN,
		self.caster
	)
	ParticleManager:SetParticleControl(self.phase_particle, 0, point)
	ParticleManager:SetParticleControl(self.phase_particle, 3, point)
	ParticleManager:SetParticleControl(self.phase_particle, 9, point)
	return true
end

function npc_centaur_double:OnAbilityPhaseInterrupted()
	ParticleManager:Delete(self.phase_particle, 1)
end

function npc_centaur_double:OnSpellStart()
	local target = self:GetCursorTarget()
	local point = target:GetAbsOrigin()

	ParticleManager:Delete(self.phase_particle)

	if target:TriggerSpellAbsorb(self) then
		return
	end

	self.caster:EmitSound("Hero_Centaur.DoubleEdge")

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_centaur/centaur_double_edge.vpcf",
		PATTACH_ABSORIGIN,
		self.caster
	)
	ParticleManager:SetParticleControl(particle, 0, point)
	ParticleManager:SetParticleControl(particle, 1, point)
	ParticleManager:SetParticleControl(particle, 2, point)
	ParticleManager:SetParticleControl(particle, 3, point)
	ParticleManager:SetParticleControl(particle, 4, point)
	ParticleManager:SetParticleControl(particle, 5, point)
	ParticleManager:SetParticleControl(particle, 9, point)
	ParticleManager:ReleaseParticleIndex(particle)

	target:AddNewModifier(self.caster, self, "modifier_centaur_double_slow", { duration = self.duration })
	target:AddNewModifier(self.caster, self, "modifier_centaur_double_heal", { duration = self.duration_heal })

	if target:IsIllusion() then
		DoDamage({
			victim = target,
			attacker = self.caster,
			damage = self.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		})
	end
end

modifier_centaur_double_slow = class(mod_visible)
function modifier_centaur_double_slow:IsPurgable()
	return true
end
function modifier_centaur_double_slow:OnCreated()
	self.ability = self:GetAbility()

	self.slow = self.ability.slow
end

function modifier_centaur_double_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_centaur_double_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

modifier_centaur_double_heal = class(mod_visible)
function modifier_centaur_double_heal:IsPurgable()
	return true
end
function modifier_centaur_double_heal:OnCreated()
	self.ability = self:GetAbility()

	self.heal = -self.ability.heal

	if not IsServer() then
		return
	end
	self.RemoveForDuel = true
	self:OnRefresh()
end

function modifier_centaur_double_heal:OnRefresh()
	if not IsServer() then
		return
	end
	self:IncrementStackCount()
end

function modifier_centaur_double_heal:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
end

function modifier_centaur_double_heal:GetModifierHPRegenAmplify_Percentage()
	return self.heal * self:GetStackCount()
end

function modifier_centaur_double_heal:GetModifierHealChange()
	return self.heal * self:GetStackCount()
end