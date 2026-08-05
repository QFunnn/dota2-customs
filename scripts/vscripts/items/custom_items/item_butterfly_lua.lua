--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


item_butterfly_lua1 = item_butterfly_lua1 or class({})
item_butterfly_lua2 = item_butterfly_lua1 or class({})
item_butterfly_lua3 = item_butterfly_lua1 or class({})

LinkLuaModifier("modifier_item_butterfly_lua", "items/custom_items/item_butterfly_lua.lua", LUA_MODIFIER_MOTION_NONE)

function item_butterfly_lua1:GetIntrinsicModifierName()
	return "modifier_item_butterfly_lua"
end

----------------------------------------------------------------------------------

modifier_item_butterfly_lua = class({})

function modifier_item_butterfly_lua:IsHidden()
	return true
end
function modifier_item_butterfly_lua:IsPurgable()
	return false
end
function modifier_item_butterfly_lua:RemoveOnDeath()
	return false
end

function modifier_item_butterfly_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_butterfly_lua:OnCreated()
	local ability = self:GetAbility()

	self.bonus_agility = ability:GetSpecialValueFor("bonus_agility")
	self.bonus_damage = ability:GetSpecialValueFor("bonus_damage")
	self.bonus_evasion = ability:GetSpecialValueFor("bonus_evasion")
	self.bonus_attack_speed = ability:GetSpecialValueFor("bonus_attack_speed")
end

function modifier_item_butterfly_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_item_butterfly_lua:GetModifierBonusStats_Agility()
	return self.bonus_agility
end

function modifier_item_butterfly_lua:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_item_butterfly_lua:GetModifierEvasion_Constant()
	return self.bonus_evasion
end

function modifier_item_butterfly_lua:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed
end