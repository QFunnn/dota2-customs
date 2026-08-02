--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_player_exp = class({})

function modifier_player_exp:IsHidden()
	return false
end

function modifier_player_exp:IsPurgable()
	return false
end

function modifier_player_exp:RemoveOnDeath()
	return false
end

function modifier_player_exp:GetTexture()
	return "playerexp"
end

function modifier_player_exp:OnCreated()
	self:SetHasCustomTransmitterData(true)
	self:StartIntervalThink(0.3)
end

function modifier_player_exp:OnIntervalThink()
	if not IsServer() then
		return
	end
	if self:GetParent():GetPrimaryAttribute() == 2 then
		self.ampl = self:GetParent():GetIntellect(true) * 0.05
	else
		self.ampl = 0
	end
	self:SendBuffRefreshToClients()
end

function modifier_player_exp:AddCustomTransmitterData()
	return {
		ampl = self.ampl,
	}
end

function modifier_player_exp:HandleCustomTransmitterData(data)
	self.ampl = tonumber(data.ampl)
end

function modifier_player_exp:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EXP_RATE_BOOST,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
	return funcs
end

function modifier_player_exp:GetModifierPercentageExpRateBoost()
	return -(100 - self:GetStackCount())
end

function modifier_player_exp:OnTooltip()
	return self:GetStackCount()
end

function modifier_player_exp:GetModifierSpellAmplify_Percentage()
	return self.ampl
end