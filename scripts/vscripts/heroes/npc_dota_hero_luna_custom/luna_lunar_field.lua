--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


luna_lunar_field = class({})

function luna_lunar_field:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function luna_lunar_field:OnSpellStart()
	local point = self:GetCursorPosition()
	local luna_lunar_orbit_custom = self:GetCaster():FindAbilityByName("luna_lunar_orbit_custom")
	CreateModifierThinker(
		self:GetCaster(),
		luna_lunar_orbit_custom,
		"modifier_luna_lunar_orbit_custom",
		{ duration = self:GetSpecialValueFor("duration") },
		point,
		self:GetCaster():GetTeamNumber(),
		false
	)
end