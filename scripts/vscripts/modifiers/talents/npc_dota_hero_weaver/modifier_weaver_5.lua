--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_weaver_5=class({})

function modifier_weaver_5:IsHidden() return true end
function modifier_weaver_5:IsPurgable() return false end
function modifier_weaver_5:IsPurgeException() return false end
function modifier_weaver_5:RemoveOnDeath() return false end

function modifier_weaver_5:OnCreated()
	self.bonus={6,12,18}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_weaver_5:OnRefresh()
	self.bonus={6,12,18}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_weaver_5:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL
	}
end

function modifier_weaver_5:GetModifierProperty_PhysicalLifesteal(params)
    return self.bonus[self:GetStackCount()]
end