--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


modifier_pumpkin_king_passive = class({})

function modifier_pumpkin_king_passive:IsHidden()
	return true
end

function modifier_pumpkin_king_passive:IsDebuff()
	return true
end

function modifier_pumpkin_king_passive:StatusEffectPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_pumpkin_king_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
end

function modifier_pumpkin_king_passive:GetMinHealth()
	return 1000
end