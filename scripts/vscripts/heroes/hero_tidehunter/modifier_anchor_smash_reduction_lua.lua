--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_anchor_smash_reduction_lua = class({})

function modifier_anchor_smash_reduction_lua:OnCreated()
	if not IsServer() then return end

	local caster = self:GetCaster()
	if not caster or caster:IsNull() then return end

	local ability = self:GetAbility()
	if not ability or ability:IsNull() then return end

	local damage_reduction = ability:GetSpecialValueFor("damage_reduction")
	self:SetStackCount(damage_reduction)
end

function modifier_anchor_smash_reduction_lua:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE
	}
end

function modifier_anchor_smash_reduction_lua:GetModifierBaseDamageOutgoing_Percentage()
	return self:GetStackCount()
end