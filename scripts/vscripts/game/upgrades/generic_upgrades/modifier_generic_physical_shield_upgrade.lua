--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_shield_handler")
modifier_generic_physical_shield_upgrade = modifier_generic_physical_shield_upgrade or class(modifier_base_shield_handler)

function modifier_generic_physical_shield_upgrade:GetTexture() return "physical_shield" end


function modifier_generic_physical_shield_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT, -- GetModifierIncomingPhysicalDamageConstant
	}
end


function modifier_generic_physical_shield_upgrade:GetModifierIncomingPhysicalDamageConstant(event)
	return self:HandleShieldDamage(event)
end