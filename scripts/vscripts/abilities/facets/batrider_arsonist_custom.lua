--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


batrider_arsonist_custom = batrider_arsonist_custom or class({})
LinkLuaModifier("modifier_batrider_arsonist_custom", "abilities/facets/batrider_arsonist_custom", LUA_MODIFIER_MOTION_NONE)


function batrider_arsonist_custom:GetIntrinsicModifierName()
	return "modifier_batrider_arsonist_custom"
end


modifier_batrider_arsonist_custom = modifier_batrider_arsonist_custom or class({})

function modifier_batrider_arsonist_custom:IsHidden() return true end
function modifier_batrider_arsonist_custom:IsPurgable() return false end
function modifier_batrider_arsonist_custom:RemoveOnDeath() return false end


function modifier_batrider_arsonist_custom:OnCreated()
	local ability = self:GetAbility()

	self.bonus_damage = ability:GetSpecialValueFor("bonus_damage")
end


function modifier_batrider_arsonist_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE, -- GetModifierTotalDamageOutgoing_Percentage
	}
end


function modifier_batrider_arsonist_custom:GetModifierTotalDamageOutgoing_Percentage(params)
	if IsValidEntity(params.target) and params.target:HasModifier("modifier_capturing_orb_custom") then
		return self.bonus_damage
	end

	return 0
end