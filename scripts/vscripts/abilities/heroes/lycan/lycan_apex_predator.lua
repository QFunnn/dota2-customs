--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


lycan_apex_predator = lycan_apex_predator or class({})
LinkLuaModifier("modifier_lycan_apex_predator_custom", "abilities/heroes/lycan/lycan_apex_predator", LUA_MODIFIER_MOTION_NONE)


function lycan_apex_predator:GetIntrinsicModifierName()
	return "modifier_lycan_apex_predator_custom"
end



modifier_lycan_apex_predator_custom = modifier_lycan_apex_predator_custom or class({})


function modifier_lycan_apex_predator_custom:IsHidden() return true end
function modifier_lycan_apex_predator_custom:IsPurgable() return false end
function modifier_lycan_apex_predator_custom:RemoveOnDeath() return false end


function modifier_lycan_apex_predator_custom:OnCreated()
	self:OnRefresh()
end


function modifier_lycan_apex_predator_custom:OnRefresh()
	self.parent = self:GetParent()
	local ability = self:GetAbility()

	self.bonus_damage_per_level = ability:GetSpecialValueFor("damage_per_level")

end


function modifier_lycan_apex_predator_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE, -- GetModifierTotalDamageOutgoing_Percentage
	}
end


function modifier_lycan_apex_predator_custom:GetModifierTotalDamageOutgoing_Percentage(params)
	if IsValidEntity(self.parent) and IsValidEntity(params.target) and params.target:HasModifier("modifier_capturing_orb_custom") then
		return self.bonus_damage_per_level * self.parent:GetLevel()
	end

	return 0
end