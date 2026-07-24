--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_visage_21=class({})

function modifier_visage_21:IsHidden() return true end
function modifier_visage_21:IsPurgable() return false end
function modifier_visage_21:IsPurgeException() return false end
function modifier_visage_21:RemoveOnDeath() return false end

function modifier_visage_21:OnCreated()
	self.bonus={500}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
    local modifier_visage_soul_assumption_custom = self:GetParent():FindModifierByName("modifier_visage_soul_assumption_custom")
    if modifier_visage_soul_assumption_custom then
        modifier_visage_soul_assumption_custom:UpdateFastPfx()
    end
end

function modifier_visage_21:OnRefresh()
	self.bonus={500}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_visage_21:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_BONUS
	}
end

function modifier_visage_21:GetModifierHealthBonus()
	return self.bonus[self:GetStackCount()]
end