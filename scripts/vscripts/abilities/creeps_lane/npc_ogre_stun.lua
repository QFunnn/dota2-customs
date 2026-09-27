--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_strike", "abilities/creeps_lane/npc_ogre_stun", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_strike_debuff", "abilities/creeps_lane/npc_ogre_stun", LUA_MODIFIER_MOTION_NONE)

npc_ogre_stun = class({})

function npc_ogre_stun:Precache(context)
	PrecacheResource("particle", "particles/act_2/ogre_seal_suprise.vpcf", context)
end

function npc_ogre_stun:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.duration = self:GetLevelSpecialValueFor("duration", 1)
	self.damage = self:GetLevelSpecialValueFor("damage", 1)
	self.radius = self:GetLevelSpecialValueFor("radius", 1)
	self.range = self:GetLevelSpecialValueFor("range", 1)
end

function npc_ogre_stun:OnSpellStart()
	CreateModifierThinker(
		self.caster,
		self,
		"modifier_strike",
		{ duration = FrameTime() },
		self.caster:GetAbsOrigin() + self.caster:GetForwardVector() * self.range,
		self.caster:GetTeamNumber(),
		false
	)
end

modifier_strike = class(mod_hidden)
function modifier_strike:IsAura()
	return true
end
function modifier_strike:GetAuraDuration()
	return 0.1
end
function modifier_strike:GetAuraRadius()
	return self.ability.radius
end
function modifier_strike:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_strike:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_strike:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
end

function modifier_strike:OnDestroy()
	if not IsServer() then
		return
	end
	self.caster:EmitSound("Hero_Centaur.HoofStomp")

	local particle =
		ParticleManager:CreateParticle("particles/act_2/ogre_seal_suprise.vpcf", PATTACH_WORLDORIGIN, self.caster)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(50, 50, 50))
	ParticleManager:ReleaseParticleIndex(particle)
end

function modifier_strike:GetModifierAura()
	return "modifier_strike_debuff"
end

modifier_strike_debuff = class(mod_hidden)
function modifier_strike_debuff:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.parent:AddNewModifier(
		self.caster,
		self.ability,
		"modifier_stunned",
		{ duration = self.ability.duration * (1 - self.parent:GetStatusResistance()) }
	)
	DoDamage({
		victim = self.parent,
		attacker = self.caster,
		damage = self.ability.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability,
	})
end