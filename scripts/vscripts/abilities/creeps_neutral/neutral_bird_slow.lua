--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bird_slow", "abilities/creeps_neutral/neutral_bird_slow", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bird_slow_buff", "abilities/creeps_neutral/neutral_bird_slow", LUA_MODIFIER_MOTION_NONE)

neutral_bird_slow = class({})

function neutral_bird_slow:GetIntrinsicModifierName()
	return "modifier_bird_slow"
end

modifier_bird_slow = class(mod_hidden)
function modifier_bird_slow:IsAura()
	return true
end
function modifier_bird_slow:GetAuraDuration()
	return 0.1
end
function modifier_bird_slow:GetAuraRadius()
	return self.ability.radius
end
function modifier_bird_slow:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_bird_slow:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_bird_slow:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.radius = self.ability:GetSpecialValueFor("radius")
	self.ability.move = self.ability:GetSpecialValueFor("move")
	self.ability.speed = self.ability:GetSpecialValueFor("speed")
end

function modifier_bird_slow:GetAuraEntityReject(target)
	return not target:CanEntityBeSeenByMyTeam(self.parent)
end

function modifier_bird_slow:GetModifierAura()
	return "modifier_bird_slow_buff"
end

modifier_bird_slow_buff = class(mod_visible)
function modifier_bird_slow_buff:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_bird_slow_buff:OnCreated()
	self.ability = self:GetAbility()

	self.move = self.ability.move
	self.speed = self.ability.speed
end

function modifier_bird_slow_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_bird_slow_buff:GetModifierAttackSpeedBonus_Constant()
	return self.speed
end

function modifier_bird_slow_buff:GetModifierMoveSpeedBonus_Percentage()
	return self.move
end