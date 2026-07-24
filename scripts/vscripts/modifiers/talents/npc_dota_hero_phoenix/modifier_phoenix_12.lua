--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_phoenix_12=class({})

function modifier_phoenix_12:IsHidden() return true end
function modifier_phoenix_12:IsPurgable() return false end
function modifier_phoenix_12:IsPurgeException() return false end
function modifier_phoenix_12:RemoveOnDeath() return false end

function modifier_phoenix_12:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local modifier_phoenix_fire_spirits_custom_count = self:GetParent():FindModifierByName("modifier_phoenix_fire_spirits_custom_count")
    if modifier_phoenix_fire_spirits_custom_count then
        modifier_phoenix_fire_spirits_custom_count:Destroy()
    end
    local phoenix_fire_spirits_custom = self:GetParent():FindAbilityByName("phoenix_fire_spirits_custom")
    if phoenix_fire_spirits_custom and phoenix_fire_spirits_custom:GetLevel() > 0 then
        self:GetParent():AddNewModifier(self:GetParent(), phoenix_fire_spirits_custom, "modifier_phoenix_fire_spirits_custom_count", {})
    end
end

function modifier_phoenix_12:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end