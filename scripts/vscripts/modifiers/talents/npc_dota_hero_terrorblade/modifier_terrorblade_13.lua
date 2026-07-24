--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_terrorblade_13=class({})

function modifier_terrorblade_13:IsHidden() return true end
function modifier_terrorblade_13:IsPurgable() return false end
function modifier_terrorblade_13:IsPurgeException() return false end
function modifier_terrorblade_13:RemoveOnDeath() return false end

function modifier_terrorblade_13:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local terrorblade_terror_wave_custom = self:GetCaster():FindAbilityByName("terrorblade_terror_wave_custom")
    if terrorblade_terror_wave_custom then
        terrorblade_terror_wave_custom:SetHidden(false)
        terrorblade_terror_wave_custom:SetLevel(1)
    end
end

function modifier_terrorblade_13:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end