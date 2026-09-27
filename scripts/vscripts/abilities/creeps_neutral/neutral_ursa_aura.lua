--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ursa_aura", "abilities/creeps_neutral/neutral_ursa_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ursa_aura_buff", "abilities/creeps_neutral/neutral_ursa_aura", LUA_MODIFIER_MOTION_NONE)

neutral_ursa_aura = class({})

function neutral_ursa_aura:GetIntrinsicModifierName()
	return "modifier_ursa_aura"
end

modifier_ursa_aura = class(mod_hidden)
function modifier_ursa_aura:IsAura()
	return true
end
function modifier_ursa_aura:GetAuraDuration()
	return 0.1
end
function modifier_ursa_aura:GetAuraRadius()
	return 500
end
function modifier_ursa_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_ursa_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_ursa_aura:OnCreated()
	self.ability = self:GetAbility()

	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.speed = self.ability:GetSpecialValueFor("speed")
end

function modifier_ursa_aura:GetModifierAura()
	return "modifier_ursa_aura_buff"
end

modifier_ursa_aura_buff = class(mod_visible)
function modifier_ursa_aura_buff:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_ursa_aura_buff:OnCreated()
	self.ability = self:GetAbility()

	self.damage = self.ability.damage
	self.speed = self.ability.speed
end

function modifier_ursa_aura_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_ursa_aura_buff:GetModifierAttackSpeedBonus_Constant()
	return self.speed
end

function modifier_ursa_aura_buff:GetModifierPreAttack_BonusDamage()
	return self.damage
end