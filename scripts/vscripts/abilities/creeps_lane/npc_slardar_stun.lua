--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_stun_thinker", "abilities/creeps_lane/npc_slardar_stun", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_stun_kdr", "abilities/creeps_lane/npc_slardar_stun", LUA_MODIFIER_MOTION_NONE)

npc_slardar_stun = class({})

function npc_slardar_stun:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_slardar/slardar_crush.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_slardar/slardar_water_puddle.vpcf", context)
end

function npc_slardar_stun:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.damage = self:GetLevelSpecialValueFor("damage", 1)
	self.stun = self:GetLevelSpecialValueFor("stun", 1)
	self.radius = self:GetLevelSpecialValueFor("radius", 1)
	self.kdr = self:GetLevelSpecialValueFor("kdr", 1)
	self.heal = self:GetLevelSpecialValueFor("heal", 1)
	self.duration = self:GetLevelSpecialValueFor("duration", 1)
end

function npc_slardar_stun:OnSpellStart()
	self.caster:EmitSound("Hero_Slardar.Slithereen_Crush")

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_slardar/slardar_crush.vpcf",
		PATTACH_ABSORIGIN,
		self.caster
	)
	ParticleManager:SetParticleControl(particle, 1, Vector(self.radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)

	for _, target in pairs(self.caster:FindTargets(self.radius)) do
		DoDamage({
			victim = target,
			attacker = self.caster,
			damage = self.damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = self,
		})
		target:AddNewModifier(
			self.caster,
			self,
			"modifier_stunned",
			{ duration = self.stun * (1 - target:GetStatusResistance()) }
		)
	end

	CreateModifierThinker(
		self.caster,
		self,
		"modifier_stun_thinker",
		{ duration = self.duration },
		self.caster:GetAbsOrigin(),
		self.caster:GetTeamNumber(),
		false
	)
end

modifier_stun_thinker = class(mod_hidden)
function modifier_stun_thinker:IsAura()
	return true
end
function modifier_stun_thinker:GetAuraDuration()
	return 0.1
end
function modifier_stun_thinker:GetAuraRadius()
	return 600
end
function modifier_stun_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_stun_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_stun_thinker:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_slardar/slardar_water_puddle.vpcf",
		PATTACH_WORLDORIGIN,
		self.parent
	)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(600, 0, 0))
	self:AddParticle(particle, true, false, -1, false, false)
end

function modifier_stun_thinker:GetModifierAura()
	return "modifier_stun_kdr"
end

modifier_stun_kdr = class(mod_visible)
function modifier_stun_kdr:GetTexture()
	return "slardar_slithereen_crush"
end
function modifier_stun_kdr:OnCreated()
	self.ability = self:GetAbility()
	if not self.ability then
		return
	end

	self.kdr = self.ability.kdr
	self.heal = self.ability.heal
end

function modifier_stun_kdr:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end

function modifier_stun_kdr:GetModifierPercentageCooldown()
	return self.kdr
end

function modifier_stun_kdr:GetModifierHealthRegenPercentage()
	return self.heal
end

function modifier_stun_kdr:OnTooltip()
	return self.kdr
end

function modifier_stun_kdr:OnTooltip2()
	return self.heal
end