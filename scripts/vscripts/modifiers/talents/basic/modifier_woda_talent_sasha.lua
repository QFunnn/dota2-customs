--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_sasha=class({})

function modifier_woda_talent_sasha:IsHidden() return true end
function modifier_woda_talent_sasha:IsPurgable() return false end
function modifier_woda_talent_sasha:IsPurgeException() return false end
function modifier_woda_talent_sasha:RemoveOnDeath() return false end

function modifier_woda_talent_sasha:OnCreated()
	self.bonus={1}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_woda_talent_sasha:OnRefresh()
	self.bonus={1}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_sasha:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
end

function modifier_woda_talent_sasha:GetModifierIncomingDamage_Percentage()
	local count = self:GetParent():GetStrength() / 30
	count = math.min(count, 10)
	return self.bonus[self:GetStackCount()] * count * -1
end