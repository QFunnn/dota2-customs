--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_legion_commander_1=class({})

function modifier_legion_commander_1:IsHidden() return true end
function modifier_legion_commander_1:IsPurgable() return false end
function modifier_legion_commander_1:IsPurgeException() return false end
function modifier_legion_commander_1:RemoveOnDeath() return false end

function modifier_legion_commander_1:OnCreated()
	self.bonus = {10,20}
	self.bonus2 = {5,10}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_legion_commander_1:OnRefresh()
	self.bonus = {10,20}
	self.bonus2 = {5,10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_legion_commander_1:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	}
end

function modifier_legion_commander_1:GetModifierMoveSpeedBonus_Constant()
	return self.bonus[self:GetStackCount()]
end

function modifier_legion_commander_1:GetModifierStatusResistanceStacking()
	return self.bonus2[self:GetStackCount()]
end