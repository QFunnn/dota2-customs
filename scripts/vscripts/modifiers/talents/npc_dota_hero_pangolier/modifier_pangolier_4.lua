--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_pangolier_4=class({})

function modifier_pangolier_4:IsHidden() return true end
function modifier_pangolier_4:IsPurgable() return false end
function modifier_pangolier_4:IsPurgeException() return false end
function modifier_pangolier_4:RemoveOnDeath() return false end

function modifier_pangolier_4:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local pangolier_gyroshell_custom = self:GetParent():FindAbilityByName("pangolier_gyroshell_custom")
    if pangolier_gyroshell_custom then
        self:GetParent():RemoveModifierByName("modifier_pangolier_gyroshell_custom")
        pangolier_gyroshell_custom:SetHidden(true)
    end
end

function modifier_pangolier_4:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end