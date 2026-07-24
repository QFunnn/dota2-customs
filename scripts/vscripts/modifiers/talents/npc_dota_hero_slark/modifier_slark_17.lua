--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_slark_17=class({})

function modifier_slark_17:IsHidden() return true end
function modifier_slark_17:IsPurgable() return false end
function modifier_slark_17:IsPurgeException() return false end
function modifier_slark_17:RemoveOnDeath() return false end

function modifier_slark_17:OnCreated()
	self.bonus = {15,30,45}
	self.bonus2 = {15,30,45}
	if not IsServer() then return end
	self:SetStackCount(1)
	local slark_essence_shift_custom = self:GetCaster():FindAbilityByName("slark_essence_shift_custom")
	if slark_essence_shift_custom then
		slark_essence_shift_custom:SetHidden(true)
	end
	self:GetCaster():CalculateStatBonus(true)
end

function modifier_slark_17:OnRefresh()
	self.bonus = {15,30,45}
	self.bonus2 = {15,30,45}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetCaster():CalculateStatBonus(true)
end

function modifier_slark_17:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_slark_17:GetModifierBonusStats_Intellect()
	return self.bonus[self:GetStackCount()]
end

function modifier_slark_17:GetModifierAttackSpeedBonus_Constant()
	return self.bonus2[self:GetStackCount()]
end