--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


item_rapier_lua1_base = item_rapier_lua1_base or class({})
item_rapier_lua2_base = item_rapier_lua1_base or class({})
item_rapier_lua3_base = item_rapier_lua1_base or class({})

LinkLuaModifier(
	"modifier_item_rapier_lua_base",
	"items/custom_items/item_rapier_lua_base.lua",
	LUA_MODIFIER_MOTION_NONE
)

function item_rapier_lua1_base:GetIntrinsicModifierName()
	return "modifier_item_rapier_lua_base"
end

------------------------------------------------------------------------------------------------

modifier_item_rapier_lua_base = class({})

function modifier_item_rapier_lua_base:IsHidden()
	return true
end
function modifier_item_rapier_lua_base:IsPurgable()
	return false
end
function modifier_item_rapier_lua_base:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_rapier_lua_base:RemoveOnDeath()
	return false
end

function modifier_item_rapier_lua_base:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_item_rapier_lua_base:GetModifierBaseAttack_BonusDamage()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_damage")
	end
end

function modifier_item_rapier_lua_base:GetModifierSpellAmplify_Percentage()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_ampl")
	end
end