--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_kez_1=class({})

function modifier_kez_1:IsHidden() return true end
function modifier_kez_1:IsPurgable() return false end
function modifier_kez_1:IsPurgeException() return false end
function modifier_kez_1:RemoveOnDeath() return false end

function modifier_kez_1:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local modifier_kez_switch_weapons_custom = self:GetParent():FindModifierByName("modifier_kez_switch_weapons_custom")
    if modifier_kez_switch_weapons_custom then
        modifier_kez_switch_weapons_custom:Destroy()
    end
end

function modifier_kez_1:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end