--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_box_ability", "abilities/box_ability.lua", LUA_MODIFIER_MOTION_NONE)

box_ability = class({})

function box_ability:GetIntrinsicModifierName()
	return "modifier_box_ability"
end

--------------------------------------------------------------------------------

modifier_box_ability = class({})

function modifier_box_ability:IsHidden()
	return true
end
function modifier_box_ability:IsPurgable()
	return false
end
function modifier_box_ability:RemoveOnDeath()
	return false
end

function modifier_box_ability:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_box_ability:GetPriority()
	return MODIFIER_PRIORITY_ULTRA
end

function modifier_box_ability:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end