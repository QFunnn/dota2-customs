--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_techies_9=class({})

function modifier_techies_9:IsHidden() return true end
function modifier_techies_9:IsPurgable() return false end
function modifier_techies_9:IsPurgeException() return false end
function modifier_techies_9:RemoveOnDeath() return false end

function modifier_techies_9:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():SwapAbilities("techies_land_mines_custom", "techies_mutually_assured_destruction_custom", false, true)
    local techies_mutually_assured_destruction_custom = self:GetCaster():FindAbilityByName("techies_mutually_assured_destruction_custom")
    if techies_mutually_assured_destruction_custom then
        techies_mutually_assured_destruction_custom:SetHidden(false)
    end
    local techies_land_mines_custom = self:GetCaster():FindAbilityByName("techies_land_mines_custom")
    if techies_land_mines_custom then
        techies_land_mines_custom:SetHidden(true)
    end
end

function modifier_techies_9:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end