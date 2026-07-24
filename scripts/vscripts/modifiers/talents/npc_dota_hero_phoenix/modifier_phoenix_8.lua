--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_phoenix_8=class({})

function modifier_phoenix_8:IsHidden() return true end
function modifier_phoenix_8:IsPurgable() return false end
function modifier_phoenix_8:IsPurgeException() return false end
function modifier_phoenix_8:RemoveOnDeath() return false end

function modifier_phoenix_8:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local modifier_phoenix_sun_ray_custom_caster_dummy = self:GetCaster():FindModifierByName("modifier_phoenix_sun_ray_custom_caster_dummy")
    if modifier_phoenix_sun_ray_custom_caster_dummy then
        modifier_phoenix_sun_ray_custom_caster_dummy:Destroy()
    end
    local phoenix_sun_ray_custom = self:GetCaster():FindAbilityByName("phoenix_sun_ray_custom")
    if phoenix_sun_ray_custom then
        phoenix_sun_ray_custom:SetActivated(false)
        phoenix_sun_ray_custom:SetHidden(true)
    end
    local phoenix_sun_ray_toggle_move_custom = self:GetCaster():FindAbilityByName("phoenix_sun_ray_toggle_move_custom")
    if phoenix_sun_ray_toggle_move_custom then
        phoenix_sun_ray_toggle_move_custom:SetActivated(false)
        phoenix_sun_ray_toggle_move_custom:SetHidden(true)
    end
end

function modifier_phoenix_8:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end