--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_phoenix_15_buff", "modifiers/talents/npc_dota_hero_phoenix/modifier_phoenix_15", LUA_MODIFIER_MOTION_NONE)

modifier_phoenix_15=class({})

function modifier_phoenix_15:IsHidden() return true end
function modifier_phoenix_15:IsPurgable() return false end
function modifier_phoenix_15:IsPurgeException() return false end
function modifier_phoenix_15:RemoveOnDeath() return false end

function modifier_phoenix_15:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local modifier_phoenix_fire_spirits_custom_count = self:GetCaster():FindModifierByName("modifier_phoenix_fire_spirits_custom_count")
    if modifier_phoenix_fire_spirits_custom_count then
        modifier_phoenix_fire_spirits_custom_count:Destroy()
    end
    local modifier_phoenix_sun_ray_custom_caster_dummy = self:GetCaster():FindModifierByName("modifier_phoenix_sun_ray_custom_caster_dummy")
    if modifier_phoenix_sun_ray_custom_caster_dummy then
        modifier_phoenix_sun_ray_custom_caster_dummy:Destroy()
    end
    local phoenix_icarus_dive_custom = self:GetCaster():FindAbilityByName("phoenix_icarus_dive_custom")
    if phoenix_icarus_dive_custom then
        phoenix_icarus_dive_custom:SetActivated(false)
        phoenix_icarus_dive_custom:SetHidden(true)
    end
    local phoenix_fire_spirits_custom = self:GetCaster():FindAbilityByName("phoenix_fire_spirits_custom")
    if phoenix_fire_spirits_custom then
        phoenix_fire_spirits_custom:SetActivated(false)
        phoenix_fire_spirits_custom:SetHidden(true)
    end
    local phoenix_sun_ray_custom = self:GetCaster():FindAbilityByName("phoenix_sun_ray_custom")
    if phoenix_sun_ray_custom then
        phoenix_sun_ray_custom:SetActivated(false)
        phoenix_sun_ray_custom:SetHidden(true)
    end
    local phoenix_supernova_custom = self:GetCaster():FindAbilityByName("phoenix_supernova_custom")
    if phoenix_supernova_custom then
        phoenix_supernova_custom:SetActivated(false)
        phoenix_supernova_custom:SetHidden(true)
    end
    local phoenix_sun_ray_toggle_move_custom = self:GetCaster():FindAbilityByName("phoenix_sun_ray_toggle_move_custom")
    if phoenix_sun_ray_toggle_move_custom then
        phoenix_sun_ray_toggle_move_custom:SetActivated(false)
        phoenix_sun_ray_toggle_move_custom:SetHidden(true)
    end
    self:GetCaster():SwapAbilities("phoenix_icarus_dive_custom", "phoenix_icicle_shard", false, true)
    local phoenix_icicle_shard = self:GetCaster():FindAbilityByName("phoenix_icicle_shard")
    if phoenix_icicle_shard then
        phoenix_icicle_shard:SetLevel(self:GetStackCount())
    end
end

function modifier_phoenix_15:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local phoenix_icicle_shard = self:GetCaster():FindAbilityByName("phoenix_icicle_shard")
    if phoenix_icicle_shard then
        phoenix_icicle_shard:SetLevel(self:GetStackCount())
    end
end

function modifier_phoenix_15:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MANA_BONUS
    }
end

function modifier_phoenix_15:GetModifierManaBonus()
    return 1000
end