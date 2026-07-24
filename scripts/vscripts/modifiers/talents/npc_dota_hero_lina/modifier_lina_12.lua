--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lina_12=class({})

function modifier_lina_12:IsHidden() return true end
function modifier_lina_12:IsPurgable() return false end
function modifier_lina_12:IsPurgeException() return false end
function modifier_lina_12:RemoveOnDeath() return false end

function modifier_lina_12:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local lina_flame_cloak_custom = self:GetParent():FindAbilityByName("lina_flame_cloak_custom")
    if lina_flame_cloak_custom then
        lina_flame_cloak_custom:SetLevel(1)
        lina_flame_cloak_custom:SetHidden(false)
    end
end

function modifier_lina_12:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end