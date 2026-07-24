--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_pudge_10=class({})

function modifier_pudge_10:IsHidden() return true end
function modifier_pudge_10:IsPurgable() return false end
function modifier_pudge_10:IsPurgeException() return false end
function modifier_pudge_10:RemoveOnDeath() return false end

function modifier_pudge_10:OnCreated()
	if not IsServer() then return end
	self.bonus={4,8,12}
	self:SetStackCount(1)
end

function modifier_pudge_10:OnRefresh()
	if not IsServer() then return end
	self.bonus={4,8,12}
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_pudge_10:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MAGICAL_LIFESTEAL,
        MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL
	}
end

function modifier_pudge_10:GetModifierProperty_PhysicalLifesteal(params)
    return self.bonus[self:GetStackCount()]
end

function modifier_pudge_10:GetModifierProperty_MagicalLifesteal(params)
    return self.bonus[self:GetStackCount()]
end