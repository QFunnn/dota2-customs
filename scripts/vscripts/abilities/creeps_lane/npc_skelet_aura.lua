--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skeletaura", "abilities/creeps_lane/npc_skelet_aura", LUA_MODIFIER_MOTION_NONE)

npc_skelet_aura = class({})

function npc_skelet_aura:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_hands_glow.vpcf",
		context
	)
end

function npc_skelet_aura:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.move = self:GetLevelSpecialValueFor("move", 1)
	self.damage = self:GetLevelSpecialValueFor("damage", 1)
	self.duration = self:GetLevelSpecialValueFor("duration", 1)
	self.radius = self:GetLevelSpecialValueFor("radius", 1)
end

function npc_skelet_aura:OnSpellStart()
	self.caster:EmitSound("Hero_OgreMagi.Bloodlust.Target")
	self.caster:AddNewModifier(self.caster, self, "modifier_skeletaura", { duration = self.duration })
end

modifier_skeletaura = class(mod_visible)
function modifier_skeletaura:IsPurgable()
	return true
end
function modifier_skeletaura:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.move = self.ability.move
	self.damage = self.ability.damage

	if not IsServer() then
		return
	end
	self:SetStackCount(
		#FindUnitsInRadius(
			self.parent:GetTeamNumber(),
			self.parent:GetAbsOrigin(),
			nil,
			self.ability.radius,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
	)

	local particle = ParticleManager:CreateParticle(
		"particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_hands_glow.vpcf",
		PATTACH_CUSTOMORIGIN,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		self.parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_skeletaura:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
	}
end

function modifier_skeletaura:GetModifierMoveSpeedBonus_Percentage()
	return self.move * self:GetStackCount()
end

function modifier_skeletaura:GetModifierDamageOutgoing_Percentage()
	return self.damage * self:GetStackCount()
end

function modifier_skeletaura:GetModifierModelScale()
	return 40
end