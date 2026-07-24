--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dazzle_1=class({})

function modifier_dazzle_1:IsHidden() return true end
function modifier_dazzle_1:IsPurgable() return false end
function modifier_dazzle_1:IsPurgeException() return false end
function modifier_dazzle_1:RemoveOnDeath() return false end

function modifier_dazzle_1:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local dazzle_poison_touch_custom = self:GetCaster():FindAbilityByName("dazzle_poison_touch_custom")
    if dazzle_poison_touch_custom then
        dazzle_poison_touch_custom:SetHidden(true)
    end
    local dazzle_shallow_grave_custom = self:GetCaster():FindAbilityByName("dazzle_shallow_grave_custom")
    if dazzle_shallow_grave_custom then
        dazzle_shallow_grave_custom:SetHidden(true)
    end
    local dazzle_shadow_wave_custom = self:GetCaster():FindAbilityByName("dazzle_shadow_wave_custom")
    if dazzle_shadow_wave_custom then
        dazzle_shadow_wave_custom:SetHidden(true)
    end
    local dazzle_healing_step = self:GetCaster():FindAbilityByName("dazzle_healing_step")
    if dazzle_healing_step then
        dazzle_healing_step:SetHidden(true)
    end
    local dazzle_bad_juju_custom = self:GetCaster():FindAbilityByName("dazzle_bad_juju_custom")
    if dazzle_bad_juju_custom then
        dazzle_bad_juju_custom:SetHidden(true)
    end
    local dazzle_nothl_projection = self:GetCaster():FindAbilityByName("dazzle_nothl_projection")
    if dazzle_nothl_projection then
        dazzle_nothl_projection:SetHidden(true)
    end
    local dazzle_good_juju_custom = self:GetCaster():FindAbilityByName("dazzle_good_juju_custom")
    if dazzle_good_juju_custom then
        dazzle_good_juju_custom:SetHidden(false)
        dazzle_good_juju_custom:SetLevel(self:GetStackCount())
    end
end

function modifier_dazzle_1:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local dazzle_poison_touch_custom = self:GetCaster():FindAbilityByName("dazzle_poison_touch_custom")
    if dazzle_poison_touch_custom then
        dazzle_poison_touch_custom:SetHidden(true)
    end
    local dazzle_shallow_grave_custom = self:GetCaster():FindAbilityByName("dazzle_shallow_grave_custom")
    if dazzle_shallow_grave_custom then
        dazzle_shallow_grave_custom:SetHidden(true)
    end
    local dazzle_shadow_wave_custom = self:GetCaster():FindAbilityByName("dazzle_shadow_wave_custom")
    if dazzle_shadow_wave_custom then
        dazzle_shadow_wave_custom:SetHidden(true)
    end
    local dazzle_healing_step = self:GetCaster():FindAbilityByName("dazzle_healing_step")
    if dazzle_healing_step then
        dazzle_healing_step:SetHidden(true)
    end
    local dazzle_bad_juju_custom = self:GetCaster():FindAbilityByName("dazzle_bad_juju_custom")
    if dazzle_bad_juju_custom then
        dazzle_bad_juju_custom:SetHidden(true)
    end
    local dazzle_nothl_projection = self:GetCaster():FindAbilityByName("dazzle_nothl_projection")
    if dazzle_nothl_projection then
        dazzle_nothl_projection:SetHidden(true)
    end
    local dazzle_good_juju_custom = self:GetCaster():FindAbilityByName("dazzle_good_juju_custom")
    if dazzle_good_juju_custom then
        dazzle_good_juju_custom:SetHidden(false)
        dazzle_good_juju_custom:SetLevel(self:GetStackCount())
    end
end