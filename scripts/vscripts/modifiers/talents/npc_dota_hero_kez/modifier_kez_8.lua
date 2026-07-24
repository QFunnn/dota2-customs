--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_kez_8=class({})

function modifier_kez_8:IsHidden() return true end
function modifier_kez_8:IsPurgable() return false end
function modifier_kez_8:IsPurgeException() return false end
function modifier_kez_8:RemoveOnDeath() return false end

function modifier_kez_8:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local kez_switch_weapons_custom = self:GetParent():FindAbilityByName("kez_switch_weapons_custom")
    if kez_switch_weapons_custom then
        self:GetCaster():AddNewModifier(self:GetCaster(), kez_switch_weapons_custom, "modifier_kez_switch_weapons_custom", {})
    end
end

function modifier_kez_8:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end