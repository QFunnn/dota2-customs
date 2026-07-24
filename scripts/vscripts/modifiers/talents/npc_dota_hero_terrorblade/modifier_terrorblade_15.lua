--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_terrorblade_15=class({})

function modifier_terrorblade_15:IsHidden() return true end
function modifier_terrorblade_15:IsPurgable() return false end
function modifier_terrorblade_15:IsPurgeException() return false end
function modifier_terrorblade_15:RemoveOnDeath() return false end

function modifier_terrorblade_15:OnCreated()
	self.bonus = {10,20,30}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_terrorblade_15:OnRefresh()
	self.bonus = {10,20,30}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_terrorblade_15:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_terrorblade_15:GetModifierMoveSpeedBonus_Constant()
	return self.bonus[self:GetStackCount()]
end

function modifier_terrorblade_15:GetModifierAttackSpeedBonus_Constant()
	return self.bonus[self:GetStackCount()]
end