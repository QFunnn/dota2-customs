--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


item_rapier_lua1 = item_rapier_lua1 or class({})
item_rapier_lua2 = item_rapier_lua1 or class({})
item_rapier_lua3 = item_rapier_lua1 or class({})

LinkLuaModifier("modifier_item_rapier_lua", "items/custom_items/item_rapier_lua.lua", LUA_MODIFIER_MOTION_NONE)

function item_rapier_lua1:GetIntrinsicModifierName()
	return "modifier_item_rapier_lua"
end

------------------------------------------------------------------------------------------------

modifier_item_rapier_lua = class({})

function modifier_item_rapier_lua:IsHidden()
	return true
end
function modifier_item_rapier_lua:IsPurgable()
	return false
end
function modifier_item_rapier_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_rapier_lua:RemoveOnDeath()
	return false
end

function modifier_item_rapier_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_item_rapier_lua:GetModifierPreAttack_BonusDamage()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_damage")
	end
end