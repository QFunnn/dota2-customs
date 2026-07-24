--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_visage_11=class({})

function modifier_visage_11:IsHidden() return true end
function modifier_visage_11:IsPurgable() return false end
function modifier_visage_11:IsPurgeException() return false end
function modifier_visage_11:RemoveOnDeath() return false end

function modifier_visage_11:OnCreated()
	self.bonus_damage = {15,30}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_visage_11:OnRefresh()
	self.bonus_damage = {15,30}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_visage_11:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE
	}
end

function modifier_visage_11:GetModifierBaseAttack_BonusDamage()
	return self.bonus_damage[self:GetStackCount()]
end