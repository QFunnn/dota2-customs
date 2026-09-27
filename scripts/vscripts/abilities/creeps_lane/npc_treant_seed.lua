--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_treant_seed", "abilities/creeps_lane/npc_treant_seed", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_treant_seed_slow", "abilities/creeps_lane/npc_treant_seed", LUA_MODIFIER_MOTION_NONE)

npc_treant_seed = class({})

function npc_treant_seed:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_treant/treant_leech_seed.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_treant/treant_leech_seed_damage_pulse.vpcf", context)
end

function npc_treant_seed:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.duration = self:GetLevelSpecialValueFor("duration", 1)
	self.slow = self:GetLevelSpecialValueFor("slow", 1)
	self.interval = self:GetLevelSpecialValueFor("interval", 1)
	self.slow_duration = self:GetLevelSpecialValueFor("slow_duration", 1)
end

function npc_treant_seed:OnSpellStart()
	local target = self:GetCursorTarget()

	if target:TriggerSpellAbsorb(self) then
		return
	end

	target:EmitSound("Hero_Treant.LeechSeed.Target")

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_treant/treant_leech_seed.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.caster
	)
	ParticleManager:SetParticleControl(
		particle,
		1,
		self.caster:GetAttachmentOrigin(self.caster:ScriptLookupAttachment("attach_attack1"))
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(particle)

	target:AddNewModifier(
		self.caster,
		self,
		"modifier_treant_seed",
		{ duration = self.duration * (1 - target:GetStatusResistance()) }
	)
end

modifier_treant_seed = class(mod_visible)
function modifier_treant_seed:IsPurgable()
	return true
end
function modifier_treant_seed:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.RemoveForDuel = true

	self:StartIntervalThink(self.ability.interval)
	self:OnIntervalThink()
end

function modifier_treant_seed:OnIntervalThink()
	if not IsServer() then
		return
	end
	self.parent:GenericParticle("particles/units/heroes/hero_treant/treant_leech_seed_damage_pulse.vpcf")
	self.parent:EmitSound("Hero_Treant.LeechSeed.Tick")
	self.parent:AddNewModifier(
		self.caster,
		self.ability,
		"modifier_treant_seed_slow",
		{ duration = self.ability.slow_duration }
	)
	self.parent:Purge(true, false, false, false, false)
end

modifier_treant_seed_slow = class(mod_visible)
function modifier_treant_seed_slow:IsPurgable()
	return true
end
function modifier_treant_seed_slow:OnCreated()
	self.ability = self:GetAbility()

	self.slow = -self.ability.slow
end

function modifier_treant_seed_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_treant_seed_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end