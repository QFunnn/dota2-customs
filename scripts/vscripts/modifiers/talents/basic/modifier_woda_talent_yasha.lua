--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_yasha=class({})

function modifier_woda_talent_yasha:IsHidden() return true end
function modifier_woda_talent_yasha:IsPurgable() return false end
function modifier_woda_talent_yasha:IsPurgeException() return false end
function modifier_woda_talent_yasha:RemoveOnDeath() return false end

function modifier_woda_talent_yasha:OnCreated()
	self.bonus={1}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_woda_talent_yasha:OnRefresh()
	self.bonus={1}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_yasha:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
	}
end

function modifier_woda_talent_yasha:GetModifierTotalDamageOutgoing_Percentage()
	local count = self:GetParent():GetAgility() / 30
	count = math.min(count, 10)
	return self.bonus[self:GetStackCount()] * count
end