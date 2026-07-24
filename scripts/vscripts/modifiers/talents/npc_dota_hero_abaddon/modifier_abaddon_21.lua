--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_abaddon_21=class({})

function modifier_abaddon_21:IsHidden() return true end
function modifier_abaddon_21:IsPurgable() return false end
function modifier_abaddon_21:IsPurgeException() return false end
function modifier_abaddon_21:RemoveOnDeath() return false end

function modifier_abaddon_21:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    if self:GetCaster():HasModifier("modifier_abaddon_8") then return end
    local abaddon_rain_of_coil = self:GetCaster():FindAbilityByName("abaddon_rain_of_coil")
    if abaddon_rain_of_coil then
        abaddon_rain_of_coil:SetLevel(1)
    end
    self:GetParent():SwapAbilities("abaddon_borrowed_time_custom", "abaddon_rain_of_coil", false, true)
    local abaddon_borrowed_time_custom = self:GetCaster():FindAbilityByName("abaddon_borrowed_time_custom")
    if abaddon_borrowed_time_custom then
        abaddon_borrowed_time_custom:SetLevel(0)
    end
    self:GetCaster():RemoveModifierByName("modifier_abaddon_borrowed_time_custom")
    self:GetCaster():RemoveModifierByName("modifier_abaddon_borrowed_time_custom_buff")
end

function modifier_abaddon_21:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end