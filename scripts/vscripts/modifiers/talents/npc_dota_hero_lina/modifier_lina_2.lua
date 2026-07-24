--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lina_2=class({})

function modifier_lina_2:IsHidden() return true end
function modifier_lina_2:IsPurgable() return false end
function modifier_lina_2:IsPurgeException() return false end
function modifier_lina_2:RemoveOnDeath() return false end

function modifier_lina_2:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local lina_dragon_slave_custom = self:GetParent():FindAbilityByName("lina_dragon_slave_custom")
    if lina_dragon_slave_custom then
        lina_dragon_slave_custom:SetLevel(0)
        lina_dragon_slave_custom:SetHidden(true)
    end
end

function modifier_lina_2:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end