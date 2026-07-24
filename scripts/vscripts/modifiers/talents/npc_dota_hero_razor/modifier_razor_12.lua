--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_razor_12=class({})

function modifier_razor_12:IsHidden() return true end
function modifier_razor_12:IsPurgable() return false end
function modifier_razor_12:IsPurgeException() return false end
function modifier_razor_12:RemoveOnDeath() return false end

function modifier_razor_12:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local razor_spell_link_custom = self:GetParent():FindAbilityByName("razor_spell_link_custom")
    if razor_spell_link_custom then
        razor_spell_link_custom:SetLevel(self:GetStackCount())
    end
    local razor_plasma_field_custom = self:GetParent():FindAbilityByName("razor_plasma_field_custom")
    if razor_plasma_field_custom then
        razor_plasma_field_custom:SetActivated(false)
        razor_plasma_field_custom:SetHidden(true)
    end
    self:GetCaster():SwapAbilities("razor_plasma_field_custom", "razor_spell_link_custom", false, true)
end

function modifier_razor_12:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local razor_spell_link_custom = self:GetParent():FindAbilityByName("razor_spell_link_custom")
    if razor_spell_link_custom then
        razor_spell_link_custom:SetLevel(self:GetStackCount())
    end
end