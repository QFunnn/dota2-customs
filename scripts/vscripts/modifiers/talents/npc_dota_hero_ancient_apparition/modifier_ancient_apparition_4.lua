--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_ancient_apparition_4=class({})

function modifier_ancient_apparition_4:IsHidden() return true end
function modifier_ancient_apparition_4:IsPurgable() return false end
function modifier_ancient_apparition_4:IsPurgeException() return false end
function modifier_ancient_apparition_4:RemoveOnDeath() return false end

function modifier_ancient_apparition_4:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local ancient_apparition_ice_vortex_custom = self:GetCaster():FindAbilityByName("ancient_apparition_ice_vortex_custom")
    if ancient_apparition_ice_vortex_custom then
        self:GetCaster():AddNewModifier(self:GetCaster(), ancient_apparition_ice_vortex_custom, "modifier_ancient_apparition_ice_vortex_custom_debuff_aura_talent", {})
        self:GetCaster():AddNewModifier(self:GetCaster(), ancient_apparition_ice_vortex_custom, "modifier_ancient_apparition_ice_vortex_custom_buff_aura_talent", {})
    end
end

function modifier_ancient_apparition_4:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local ancient_apparition_ice_vortex_custom = self:GetCaster():FindAbilityByName("ancient_apparition_ice_vortex_custom")
    if ancient_apparition_ice_vortex_custom then
        self:GetCaster():AddNewModifier(self:GetCaster(), ancient_apparition_ice_vortex_custom, "modifier_ancient_apparition_ice_vortex_custom_debuff_aura_talent", {})
        self:GetCaster():AddNewModifier(self:GetCaster(), ancient_apparition_ice_vortex_custom, "modifier_ancient_apparition_ice_vortex_custom_buff_aura_talent", {})
    end
end