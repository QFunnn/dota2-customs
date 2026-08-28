--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_new_player = class({})

function modifier_new_player:IsHidden()
	return false
end

function modifier_new_player:IsPurgable()
	return false
end

function modifier_new_player:RemoveOnDeath()
	return false
end

function modifier_new_player:GetTexture()
	return "new_player"
end

function modifier_new_player:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_EXP_RATE_BOOST,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
	return funcs
end

function modifier_new_player:OnTooltip()
	return self:GetStackCount()
end

function modifier_new_player:GetModifierIncomingDamage_Percentage()
	return -10
end

function modifier_new_player:GetModifierPercentageExpRateBoost()
	return 10
end

function modifier_new_player:GetModifierTotalDamageOutgoing_Percentage()
	return 10
end