--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


demo_dummy = class({})
LinkLuaModifier("modifier_demo_dummy", "creature_ability/demo_dummy", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_demo_dummy_debuff", "creature_ability/demo_dummy", LUA_MODIFIER_MOTION_NONE)
function demo_dummy:GetIntrinsicModifierName()
	return "modifier_demo_dummy"
end
---------------------------------------------------
modifier_demo_dummy = class({})
function modifier_demo_dummy:IsHidden()
	return true
end
function modifier_demo_dummy:IsPurgable()
	return false
end
function modifier_demo_dummy:IsPurgeException()
	return false
end
function modifier_demo_dummy:IsDebuff()
	return false
end
function modifier_demo_dummy:RemoveOnDeath()
	return false
end
function modifier_demo_dummy:OnCreated(kv)
end
function modifier_demo_dummy:OnRefresh(kv)
end
function modifier_demo_dummy:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH,
		MODIFIER_PROPERTY_REINCARNATION,
	}
end
function modifier_demo_dummy:CheckState()
	return {
		[MODIFIER_STATE_CANNOT_MISS] = true,
	}
end
function modifier_demo_dummy:GetMinHealth(params)
	return 1
end
function modifier_demo_dummy:ReincarnateTime()
	return 3
end