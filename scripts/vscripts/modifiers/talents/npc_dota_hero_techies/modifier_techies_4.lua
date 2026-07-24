--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_techies_4 = class({})

function modifier_techies_4:IsHidden() return true end
function modifier_techies_4:IsPurgable() return false end
function modifier_techies_4:IsPurgeException() return false end
function modifier_techies_4:RemoveOnDeath() return false end

function modifier_techies_4:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():RemoveModifierByName("modifier_techies_reactive_tazer_custom")
    local techies_burn_out_custom = self:GetCaster():FindAbilityByName("techies_burn_out_custom")
    if techies_burn_out_custom then
        techies_burn_out_custom:SetLevel(1)
    end
    self:GetCaster():SwapAbilities("techies_reactive_tazer_custom", "techies_burn_out_custom", false, true)
end

function modifier_techies_4:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end