--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_shield_handler")
modifier_generic_magical_shield_upgrade = modifier_generic_magical_shield_upgrade or class(modifier_base_shield_handler)

function modifier_generic_magical_shield_upgrade:GetTexture()
	return "magical_shield"
end

function modifier_generic_magical_shield_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT, -- GetModifierIncomingSpellDamageConstant
	}
end

function modifier_generic_magical_shield_upgrade:GetModifierIncomingSpellDamageConstant(event)
	return self:HandleShieldDamage(event)
end