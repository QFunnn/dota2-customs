--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lina_1=class({})

function modifier_lina_1:IsHidden() return true end
function modifier_lina_1:IsPurgable() return false end
function modifier_lina_1:IsPurgeException() return false end
function modifier_lina_1:RemoveOnDeath() return false end

function modifier_lina_1:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():SwapAbilities("lina_light_strike_array_custom", "lina_brand_of_fire_custom", false, true)
    local lina_light_strike_array_custom = self:GetParent():FindAbilityByName("lina_light_strike_array_custom")
    if lina_light_strike_array_custom then
        lina_light_strike_array_custom:SetLevel(0)
        lina_light_strike_array_custom:SetHidden(true)
    end
    local lina_brand_of_fire_custom = self:GetParent():FindAbilityByName("lina_brand_of_fire_custom")
    if lina_brand_of_fire_custom then
        lina_brand_of_fire_custom:SetLevel(self:GetStackCount())
        lina_brand_of_fire_custom:SetHidden(false)
    end
end

function modifier_lina_1:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local lina_brand_of_fire_custom = self:GetParent():FindAbilityByName("lina_brand_of_fire_custom")
    if lina_brand_of_fire_custom then
        lina_brand_of_fire_custom:SetLevel(self:GetStackCount())
        lina_brand_of_fire_custom:SetHidden(false)
    end
end