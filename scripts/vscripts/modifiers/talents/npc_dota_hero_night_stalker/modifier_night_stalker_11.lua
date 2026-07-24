--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_night_stalker_11=class({})

function modifier_night_stalker_11:IsHidden() return true end
function modifier_night_stalker_11:IsPurgable() return false end
function modifier_night_stalker_11:IsPurgeException() return false end
function modifier_night_stalker_11:RemoveOnDeath() return false end

function modifier_night_stalker_11:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local night_stalker_creaping_smile = self:GetCaster():FindAbilityByName("night_stalker_creaping_smile")
    if night_stalker_creaping_smile then
        night_stalker_creaping_smile:SetLevel(self:GetStackCount())
    end
    local night_stalker_crippling_fear_custom = self:GetCaster():FindAbilityByName("night_stalker_crippling_fear_custom")
    if night_stalker_crippling_fear_custom then
        night_stalker_crippling_fear_custom:SetLevel(0)
    end
    self:GetParent():RemoveModifierByName("modifier_night_stalker_crippling_fear_custom")
    self:GetParent():SwapAbilities("night_stalker_crippling_fear_custom", "night_stalker_creaping_smile", false, true)
end

function modifier_night_stalker_11:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local night_stalker_creaping_smile = self:GetCaster():FindAbilityByName("night_stalker_creaping_smile")
    if night_stalker_creaping_smile then
        night_stalker_creaping_smile:SetLevel(self:GetStackCount())
    end
end