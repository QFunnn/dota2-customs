--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_phoenix_18=class({})

function modifier_phoenix_18:IsHidden() return true end
function modifier_phoenix_18:IsPurgable() return false end
function modifier_phoenix_18:IsPurgeException() return false end
function modifier_phoenix_18:RemoveOnDeath() return false end

function modifier_phoenix_18:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local phoenix_frost_ray = self:GetCaster():FindAbilityByName("phoenix_frost_ray")
    if phoenix_frost_ray then
        phoenix_frost_ray:SetLevel(self:GetStackCount())
    end
    self:GetCaster():SwapAbilities("phoenix_sun_ray_custom", "phoenix_frost_ray", false, true)
end

function modifier_phoenix_18:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local phoenix_frost_ray = self:GetCaster():FindAbilityByName("phoenix_frost_ray")
    if phoenix_frost_ray then
        phoenix_frost_ray:SetLevel(self:GetStackCount())
    end
end