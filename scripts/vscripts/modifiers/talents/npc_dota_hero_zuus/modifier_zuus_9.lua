--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_zuus_9=class({})

function modifier_zuus_9:IsHidden() return true end
function modifier_zuus_9:IsPurgable() return false end
function modifier_zuus_9:IsPurgeException() return false end
function modifier_zuus_9:RemoveOnDeath() return false end

function modifier_zuus_9:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local zuus_lightning_hands_custom = self:GetParent():FindAbilityByName("zuus_lightning_hands_custom")
    if zuus_lightning_hands_custom then
        zuus_lightning_hands_custom:SetLevel(self:GetStackCount())
        zuus_lightning_hands_custom:SetHidden(false)
    end
end

function modifier_zuus_9:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local zuus_lightning_hands_custom = self:GetParent():FindAbilityByName("zuus_lightning_hands_custom")
    if zuus_lightning_hands_custom then
        zuus_lightning_hands_custom:SetLevel(self:GetStackCount())
        zuus_lightning_hands_custom:SetHidden(false)
    end
end