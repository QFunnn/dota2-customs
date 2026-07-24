--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_marci_14=class({})

function modifier_marci_14:IsHidden() return true end
function modifier_marci_14:IsPurgable() return false end
function modifier_marci_14:IsPurgeException() return false end
function modifier_marci_14:RemoveOnDeath() return false end

function modifier_marci_14:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    if self:GetParent():HasModifier("modifier_marci_15") then return end
    local modifier_marci_unleash_custom = self:GetParent():FindModifierByName("modifier_marci_unleash_custom")
    if modifier_marci_unleash_custom then
        modifier_marci_unleash_custom:Destroy()
    end
    local marci_unleash_custom = self:GetParent():FindAbilityByName("marci_unleash_custom")
    if marci_unleash_custom and marci_unleash_custom:GetLevel() > 0 then
        self:GetParent():AddNewModifier(self:GetCaster(), marci_unleash_custom, "modifier_marci_unleash_custom", {})
    end
end

function modifier_marci_14:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end