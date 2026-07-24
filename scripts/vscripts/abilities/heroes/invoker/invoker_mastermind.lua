--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


invoker_mastermind = invoker_mastermind or class({})
LinkLuaModifier("modifier_invoker_mastermind_custom", "abilities/heroes/invoker/invoker_mastermind", LUA_MODIFIER_MOTION_NONE)


function invoker_mastermind:GetIntrinsicModifierName()
	return "modifier_invoker_mastermind_custom"
end



modifier_invoker_mastermind_custom = modifier_invoker_mastermind_custom or class({})


function modifier_invoker_mastermind_custom:IsHidden() return true end
function modifier_invoker_mastermind_custom:IsPurgable() return false end
function modifier_invoker_mastermind_custom:RemoveOnDeath() return false end


function modifier_invoker_mastermind_custom:OnCreated()
	self:OnRefresh()
end


function modifier_invoker_mastermind_custom:OnRefresh()
	local ability = self:GetAbility()
	self.xp_gain = ability:GetSpecialValueFor("xp_gain")
end


function modifier_invoker_mastermind_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_EXP_RATE_BOOST, -- GetModifierPercentageExpRateBoost
	}
end


function modifier_invoker_mastermind_custom:GetModifierPercentageExpRateBoost()
	return self.xp_gain
end