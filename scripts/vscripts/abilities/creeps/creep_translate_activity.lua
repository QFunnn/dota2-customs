--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_creep_translate_activity",
	"abilities/creeps/creep_translate_activity",
	LUA_MODIFIER_MOTION_NONE
)

creep_translate_activity = class({})

function creep_translate_activity:GetIntrinsicModifierName()
	return "modifier_creep_translate_activity"
end

--------------------------------------------------------------------------------------

modifier_creep_translate_activity = class({})

function modifier_creep_translate_activity:IsHidden()
	return true
end

function modifier_creep_translate_activity:IsPurgable()
	return false
end

function modifier_creep_translate_activity:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
	return funcs
end

function modifier_creep_translate_activity:GetActivityTranslationModifiers(params)
	return "run"
end