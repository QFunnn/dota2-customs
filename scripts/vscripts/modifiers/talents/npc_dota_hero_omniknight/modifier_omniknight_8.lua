--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_omniknight_8=class({})

function modifier_omniknight_8:IsHidden() return true end
function modifier_omniknight_8:IsPurgable() return false end
function modifier_omniknight_8:IsPurgeException() return false end
function modifier_omniknight_8:RemoveOnDeath() return false end

function modifier_omniknight_8:OnCreated()
	self.bonus={10,20,30}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_omniknight_8:OnRefresh()
	self.bonus={10,20,30}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_omniknight_8:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE
	}
end

function modifier_omniknight_8:GetModifierBaseAttack_BonusDamage()
	return self.bonus[self:GetStackCount()]
end