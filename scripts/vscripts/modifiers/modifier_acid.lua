--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_acid = class({})

function modifier_acid:IsHidden()
	return false
end
function modifier_acid:IsDebuff()
	return true
end

function modifier_acid:IsPurgable()
	return false
end

function modifier_acid:GetTexture()
	return "acid"
end

function modifier_acid:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_acid:GetModifierDamageOutgoing_Percentage(params)
	return -40
end

function modifier_acid:GetModifierMoveSpeedBonus_Percentage(params)
	return -25
end