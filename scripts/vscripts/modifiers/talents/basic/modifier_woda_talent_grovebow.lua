--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_grovebow=class({})

function modifier_woda_talent_grovebow:IsHidden() return true end
function modifier_woda_talent_grovebow:IsPurgable() return false end
function modifier_woda_talent_grovebow:IsPurgeException() return false end
function modifier_woda_talent_grovebow:RemoveOnDeath() return false end

function modifier_woda_talent_grovebow:OnCreated()
	self.bonusmeele={50,100}
	self.bonusrange={100,200}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_woda_talent_grovebow:OnRefresh()
	self.bonusmeele={50,100}
	self.bonusrange={100,200}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_grovebow:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
	}
end

function modifier_woda_talent_grovebow:GetModifierAttackRangeBonus()
	if self:GetParent():IsRangedAttacker() then
		return self.bonusrange[self:GetStackCount()] end
	return self.bonusmeele[self:GetStackCount()]
end