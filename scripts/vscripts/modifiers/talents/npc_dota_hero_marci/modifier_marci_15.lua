--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_marci_15=class({})

function modifier_marci_15:IsHidden() return true end
function modifier_marci_15:IsPurgable() return false end
function modifier_marci_15:IsPurgeException() return false end
function modifier_marci_15:RemoveOnDeath() return false end

function modifier_marci_15:OnCreated()
    self.bonus={100,150,200}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(true)
    local marci_unleash_custom = self:GetParent():FindAbilityByName("marci_unleash_custom")
    if marci_unleash_custom then
        marci_unleash_custom:SetActivated(false)
    end
    local modifier_marci_unleash_custom = self:GetParent():FindModifierByName("modifier_marci_unleash_custom")
    if modifier_marci_unleash_custom then
        modifier_marci_unleash_custom:Destroy()
    end
    self:GetParent():SwapAbilities("marci_unleash_custom", "marci_beatiful_illusion_custom", false, true)
    local marci_beatiful_illusion_custom = self:GetParent():FindAbilityByName("marci_beatiful_illusion_custom")
    if marci_beatiful_illusion_custom then
        marci_beatiful_illusion_custom:SetLevel(self:GetStackCount())
    end
end
function modifier_marci_15:OnRefresh()
    self.bonus={100,150,200}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
    local marci_beatiful_illusion_custom = self:GetParent():FindAbilityByName("marci_beatiful_illusion_custom")
    if marci_beatiful_illusion_custom then
        marci_beatiful_illusion_custom:SetLevel(self:GetStackCount())
    end
end

function modifier_marci_15:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_HEALTH_BONUS
    }
end

function modifier_marci_15:GetModifierHealthBonus()
    return self.bonus[self:GetStackCount()]
end