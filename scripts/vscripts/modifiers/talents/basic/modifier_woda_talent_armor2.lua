--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_armor2=class({})

function modifier_woda_talent_armor2:IsHidden() return true end
function modifier_woda_talent_armor2:IsPurgable() return false end
function modifier_woda_talent_armor2:IsPurgeException() return false end
function modifier_woda_talent_armor2:RemoveOnDeath() return false end

function modifier_woda_talent_armor2:OnCreated()
	self.bonus={4,8,12}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_woda_talent_armor2:OnRefresh()
	self.bonus={4,8,12}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_armor2:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
end

function modifier_woda_talent_armor2:GetModifierIncomingDamage_Percentage()
	return self.bonus[self:GetStackCount()] * -1
end