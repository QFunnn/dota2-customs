--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_vengefulspirit_2=class({})

function modifier_vengefulspirit_2:IsHidden() return true end
function modifier_vengefulspirit_2:IsPurgable() return false end
function modifier_vengefulspirit_2:IsPurgeException() return false end
function modifier_vengefulspirit_2:RemoveOnDeath() return false end

function modifier_vengefulspirit_2:OnCreated()
	self.bonus={10,20,30}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_vengefulspirit_2:OnRefresh()
	self.bonus={10,20,30}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_vengefulspirit_2:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE
	}
end

function modifier_vengefulspirit_2:GetModifierBaseAttack_BonusDamage()
	return self.bonus[self:GetStackCount()]
end