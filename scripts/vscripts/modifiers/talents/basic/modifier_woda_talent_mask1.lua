--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_mask1 = class({})

function modifier_woda_talent_mask1:IsHidden()
	return true
end
function modifier_woda_talent_mask1:IsPurgable()
	return false
end
function modifier_woda_talent_mask1:IsPurgeException()
	return false
end
function modifier_woda_talent_mask1:RemoveOnDeath()
	return false
end

function modifier_woda_talent_mask1:OnCreated()
	self.bonus = { 7, 14 }
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_woda_talent_mask1:OnRefresh()
	self.bonus = { 7, 14 }
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_mask1:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL,
	}
end

function modifier_woda_talent_mask1:GetModifierProperty_PhysicalLifesteal()
	return self.bonus[self:GetStackCount()]
end