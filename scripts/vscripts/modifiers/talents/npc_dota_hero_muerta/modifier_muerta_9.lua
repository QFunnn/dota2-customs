--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_muerta_9=class({})

function modifier_muerta_9:IsHidden() return true end
function modifier_muerta_9:IsPurgable() return false end
function modifier_muerta_9:IsPurgeException() return false end
function modifier_muerta_9:RemoveOnDeath() return false end

function modifier_muerta_9:OnCreated()
	self.bonus={5,10,15}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_muerta_9:OnRefresh()
	self.bonus={5,10,15}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_muerta_9:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function modifier_muerta_9:GetModifierMagicalResistanceBonus()
	return self.bonus[self:GetStackCount()]
end