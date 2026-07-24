--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_cosmetic_pet = class( {} )

function modifier_cosmetic_pet:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
	}
end

function modifier_cosmetic_pet:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE }
end

function modifier_cosmetic_pet:GetModifierMoveSpeed_Absolute()
	if self:GetParent() and not self:GetParent():IsNull() and self:GetParent():GetOwner() and not self:GetParent():GetOwner():IsNull() then
		return self:GetParent():GetOwner():GetIdealSpeed()
	end 
	return 300
end