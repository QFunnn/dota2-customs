--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_oracle_10=class({})

function modifier_oracle_10:IsHidden() return true end
function modifier_oracle_10:IsPurgable() return false end
function modifier_oracle_10:IsPurgeException() return false end
function modifier_oracle_10:RemoveOnDeath() return false end

function modifier_oracle_10:OnCreated()
	self.bonus={11}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_oracle_10:OnRefresh()
	self.bonus={11}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_oracle_10:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE
	}
end

function modifier_oracle_10:GetModifierBaseAttack_BonusDamage()
	return self.bonus[self:GetStackCount()]
end