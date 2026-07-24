--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chen_10=class({})

function modifier_chen_10:IsHidden() return true end
function modifier_chen_10:IsPurgable() return false end
function modifier_chen_10:IsPurgeException() return false end
function modifier_chen_10:RemoveOnDeath() return false end

function modifier_chen_10:OnCreated()
	if not IsServer() then return end
    self.bonus={100,200,300}
    self:GetParent():CalculateStatBonus(true)
	self:SetStackCount(1)
    local chen_creep_counterspell = self:GetCaster():FindAbilityByName("chen_creep_counterspell")
    if chen_creep_counterspell then
        chen_creep_counterspell:SetLevel(self:GetStackCount())
        chen_creep_counterspell:SetHidden(false)
    end
end

function modifier_chen_10:OnRefresh()
	if not IsServer() then return end
    self.bonus={100,200,300}
    self:GetParent():CalculateStatBonus(true)
	self:SetStackCount(self:GetStackCount() + 1)
    local chen_creep_counterspell = self:GetCaster():FindAbilityByName("chen_creep_counterspell")
    if chen_creep_counterspell then
        chen_creep_counterspell:SetLevel(self:GetStackCount())
        chen_creep_counterspell:SetHidden(false)
    end
end

function modifier_chen_10:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_HEALTH_BONUS
    }
end

function modifier_chen_10:GetModifierHealthBonus()
    return self.bonus[self:GetStackCount()]
end