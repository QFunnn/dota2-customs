--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("npc_arc_field_passive", "abilities/creeps_lane/npc_arc_field", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("npc_arc_field_passive2", "abilities/creeps_lane/npc_arc_field", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_arc_field", "abilities/creeps_lane/npc_arc_field", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_arc_field_buf", "abilities/creeps_lane/npc_arc_field", LUA_MODIFIER_MOTION_NONE)

npc_arc_field = class({})

function npc_arc_field:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_arc_warden/arc_warden_magnetic.vpcf", context)
end

function npc_arc_field:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.radius = self:GetLevelSpecialValueFor("radius", 1)
	self.speed = self:GetLevelSpecialValueFor("speed", 1)
	self.evasion = self:GetLevelSpecialValueFor("evasion", 1)
	self.duration = self:GetLevelSpecialValueFor("duration", 1)
end

function npc_arc_field:GetIntrinsicModifierName()
	return "npc_arc_field_passive"
end

function npc_arc_field:OnSpellStart()
	self.caster:EmitSound("Hero_ArcWarden.MagneticField.Cast")
	CreateModifierThinker(
		self.caster,
		self,
		"modifier_arc_field",
		{ duration = self.duration },
		self.caster:GetAbsOrigin(),
		self.caster:GetTeamNumber(),
		false
	)
end

npc_arc_field_passive = class(mod_hidden)
function npc_arc_field_passive:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.parent:AddNewModifier(self.parent, self.ability, "npc_arc_field_passive2", {})
end

function npc_arc_field_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
end

function npc_arc_field_passive:GetActivityTranslationModifiers()
	return "walk"
end

npc_arc_field_passive2 = class(mod_hidden)
function npc_arc_field_passive2:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
end

function npc_arc_field_passive2:GetActivityTranslationModifiers()
	return "fast"
end

modifier_arc_field = class(mod_hidden)
function modifier_arc_field:IsAura()
	return true
end
function modifier_arc_field:GetAuraDuration()
	return 0.1
end
function modifier_arc_field:GetAuraRadius()
	return self.ability.radius
end
function modifier_arc_field:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_arc_field:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_arc_field:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	self.parent:EmitSound("Hero_ArcWarden.MagneticField")

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_arc_warden/arc_warden_magnetic.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControl(particle, 1, Vector(self.ability.radius, 1, 1))
	self:AddParticle(particle, false, false, 1, false, false)
end

function modifier_arc_field:GetModifierAura()
	return "modifier_arc_field_buf"
end

modifier_arc_field_buf = class(mod_visible)
function modifier_arc_field_buf:OnCreated()
	self.ability = self:GetAbility()
	if not self.ability then
		return
	end

	self.speed = self.ability.speed
	self.evasion = -self.ability.evasion
	self.radius = self.ability.radius
end

function modifier_arc_field_buf:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_arc_field_buf:GetModifierIncomingDamage_Percentage(params)
	if not self.radius or not params.attacker then
		return
	end

	if not IsValid(self.owner) then
		self.owner = self:GetAuraOwner()
	end

	if not IsValid(self.owner) then
		return
	end
	if (params.attacker:GetAbsOrigin() - self.owner:GetAbsOrigin()):Length2D() <= self.radius then
		return
	end
	return self.evasion
end

function modifier_arc_field_buf:GetModifierAttackSpeedBonus_Constant()
	return self.speed
end

function modifier_arc_field_buf:GetActivityTranslationModifiers()
	return "faster"
end

function modifier_arc_field_buf:OnTooltip()
	return self.speed
end