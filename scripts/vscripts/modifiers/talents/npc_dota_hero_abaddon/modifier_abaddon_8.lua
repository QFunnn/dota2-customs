--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_abaddon_8=class({})

function modifier_abaddon_8:IsHidden() return true end
function modifier_abaddon_8:IsPurgable() return false end
function modifier_abaddon_8:IsPurgeException() return false end
function modifier_abaddon_8:RemoveOnDeath() return false end

function modifier_abaddon_8:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local abaddon_death_coil_custom = self:GetCaster():FindAbilityByName("abaddon_death_coil_custom")
    if abaddon_death_coil_custom then
        abaddon_death_coil_custom:SetHidden(true)
        abaddon_death_coil_custom:SetLevel(0)
    end
    local abaddon_aphotic_shield_custom = self:GetCaster():FindAbilityByName("abaddon_aphotic_shield_custom")
    if abaddon_aphotic_shield_custom then
        abaddon_aphotic_shield_custom:SetHidden(true)
        abaddon_aphotic_shield_custom:SetLevel(0)
    end
    local abaddon_frostmourne_custom = self:GetCaster():FindAbilityByName("abaddon_frostmourne_custom")
    if abaddon_frostmourne_custom then
        abaddon_frostmourne_custom:SetHidden(true)
        abaddon_frostmourne_custom:SetLevel(0)
    end
    local abaddon_borrowed_time_custom = self:GetCaster():FindAbilityByName("abaddon_borrowed_time_custom")
    if abaddon_borrowed_time_custom then
        abaddon_borrowed_time_custom:SetHidden(true)
        abaddon_borrowed_time_custom:SetLevel(0)
    end
    local abaddon_rain_of_coil = self:GetCaster():FindAbilityByName("abaddon_rain_of_coil")
    if abaddon_rain_of_coil then
        abaddon_rain_of_coil:SetHidden(true)
        abaddon_rain_of_coil:SetLevel(0)
    end
    local abaddon_jousting = self:GetCaster():FindAbilityByName("abaddon_jousting")
    if abaddon_jousting then
        abaddon_jousting:SetLevel(1)
        abaddon_jousting:SetHidden(false)
    end
    self:GetCaster():RemoveModifierByName("modifier_abaddon_aphotic_shield_custom")
    self:GetCaster():RemoveModifierByName("modifier_abaddon_aphotic_shield_custom_handler")
    self:GetCaster():RemoveModifierByName("modifier_abaddon_borrowed_time_custom")
    self:GetCaster():RemoveModifierByName("modifier_abaddon_borrowed_time_custom_buff")
    self:GetCaster():RemoveModifierByName("modifier_abaddon_frostmourne_custom")
end

function modifier_abaddon_8:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end