--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_creep_hide_attribute", "abilities/creeps/creep_hide_attribute", LUA_MODIFIER_MOTION_NONE)

creep_hide_attribute = class({})

function creep_hide_attribute:GetIntrinsicModifierName()
	return "modifier_creep_hide_attribute"
end

------------------------------------------------------------------------------

modifier_creep_hide_attribute = class({})

function modifier_creep_hide_attribute:IsHidden()
	return true
end
function modifier_creep_hide_attribute:IsPurgable()
	return false
end
function modifier_creep_hide_attribute:CheckState()
	return {
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}
end