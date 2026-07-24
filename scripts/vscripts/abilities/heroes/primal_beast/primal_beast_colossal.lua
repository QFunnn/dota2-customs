--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


primal_beast_colossal = primal_beast_colossal or class({})
LinkLuaModifier("modifier_primal_beast_colossal_custom", "abilities/heroes/primal_beast/primal_beast_colossal", LUA_MODIFIER_MOTION_NONE)


function primal_beast_colossal:GetIntrinsicModifierName()
	return "modifier_primal_beast_colossal_custom"
end



modifier_primal_beast_colossal_custom = modifier_primal_beast_colossal_custom or class({})


function modifier_primal_beast_colossal_custom:IsHidden() return (IsValidEntity(self.parent) and not self.parent:HasModifier("modifier_capturing_orb_custom")) end
function modifier_primal_beast_colossal_custom:IsPurgable() return false end
function modifier_primal_beast_colossal_custom:RemoveOnDeath() return false end


function modifier_primal_beast_colossal_custom:OnCreated()
	local ability = self:GetAbility()
	self.damage_reduction = -ability:GetSpecialValueFor("damage_reduction")

	self.parent = self:GetParent()
end


function modifier_primal_beast_colossal_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE, -- GetModifierIncomingDamage_Percentage
	}
end


function modifier_primal_beast_colossal_custom:GetModifierIncomingDamage_Percentage()
	if not IsValidEntity(self.parent) then return 0 end
	if self.parent:HasModifier("modifier_capturing_orb_custom") then return self.damage_reduction end
	return 0
end