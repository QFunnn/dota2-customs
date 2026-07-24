--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_flying", "neutrals/woda_neutral_flying", LUA_MODIFIER_MOTION_NONE)

woda_neutral_flying = class({})

function woda_neutral_flying:GetIntrinsicModifierName()
	return "modifier_woda_neutral_flying"
end

modifier_woda_neutral_flying = class({})
function modifier_woda_neutral_flying:IsHidden() return true end
function modifier_woda_neutral_flying:IsPurgable() return false end
function modifier_woda_neutral_flying:IsPurgeException() return false end

function modifier_woda_neutral_flying:CheckState()
	return
	{
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_FLYING] = true,
	}
end