--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_war_drums_aura", "neutrals/woda_neutral_war_drums_aura", LUA_MODIFIER_MOTION_NONE)

woda_neutral_war_drums_aura = class({})

function woda_neutral_war_drums_aura:GetIntrinsicModifierName()
	return "modifier_woda_neutral_war_drums_aura"
end

modifier_woda_neutral_war_drums_aura = class({})

function modifier_woda_neutral_war_drums_aura:IsHidden() return true end

function modifier_woda_neutral_war_drums_aura:CheckState()
	return {
		[MODIFIER_STATE_CANNOT_MISS] = true
	}
end