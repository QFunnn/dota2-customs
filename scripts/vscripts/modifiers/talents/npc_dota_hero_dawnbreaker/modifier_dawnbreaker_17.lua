--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dawnbreaker_17=class({})

function modifier_dawnbreaker_17:IsHidden() return true end
function modifier_dawnbreaker_17:IsPurgable() return false end
function modifier_dawnbreaker_17:IsPurgeException() return false end
function modifier_dawnbreaker_17:RemoveOnDeath() return false end

function modifier_dawnbreaker_17:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local dawnbreaker_fire_wreath_custom = self:GetCaster():FindAbilityByName("dawnbreaker_fire_wreath_custom")
    if dawnbreaker_fire_wreath_custom then
        dawnbreaker_fire_wreath_custom:SetHidden(true)
        dawnbreaker_fire_wreath_custom:SetActivated(false)
    end
end

function modifier_dawnbreaker_17:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end