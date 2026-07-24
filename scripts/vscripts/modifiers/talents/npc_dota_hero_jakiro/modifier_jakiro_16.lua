--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_jakiro_16=class({})

function modifier_jakiro_16:IsHidden() return true end
function modifier_jakiro_16:IsPurgable() return false end
function modifier_jakiro_16:IsPurgeException() return false end
function modifier_jakiro_16:RemoveOnDeath() return false end

function modifier_jakiro_16:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local jakiro_ice_embrace = self:GetCaster():FindAbilityByName("jakiro_ice_embrace")
    if jakiro_ice_embrace then
        jakiro_ice_embrace:SetLevel(self:GetStackCount())
    end
    self:GetCaster():SwapAbilities("jakiro_macropyre_custom", "jakiro_ice_embrace", false, true)
    local jakiro_macropyre_custom = self:GetParent():FindAbilityByName("jakiro_macropyre_custom")
    if jakiro_macropyre_custom then
        jakiro_macropyre_custom:SetLevel(0)
        self:GetParent():RemoveModifierByName("modifier_jakiro_macropyre_custom_handler")
    end
end

function modifier_jakiro_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local jakiro_ice_embrace = self:GetCaster():FindAbilityByName("jakiro_ice_embrace")
    if jakiro_ice_embrace then
        jakiro_ice_embrace:SetHidden(false)
        jakiro_ice_embrace:SetLevel(self:GetStackCount())
    end
end