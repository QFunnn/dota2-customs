--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


lm_take_no_damage = class({})

function lm_take_no_damage:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	}

	return funcs
end

function lm_take_no_damage:GetTexture()
	return "modifier_invulnerable"
end

function lm_take_no_damage:GetAbsoluteNoDamageMagical(params)
	return 1
end

function lm_take_no_damage:GetAbsoluteNoDamagePhysical(params)
	return 1
end

function lm_take_no_damage:GetAbsoluteNoDamagePure(params)
	return 1
end