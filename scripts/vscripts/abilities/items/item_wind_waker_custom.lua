--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_wind_waker_custom", "abilities/items/item_wind_waker_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_wind_waker_custom_active", "abilities/items/item_wind_waker_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_wind_waker_custom_speed", "abilities/items/item_wind_waker_custom", LUA_MODIFIER_MOTION_NONE)

item_wind_waker_custom = class({})

function item_wind_waker_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/econ/events/seasonal_reward_line_fall_2025/phase_boots_fallrewardline_2025.vpcf", context )
end

function item_wind_waker_custom:GetIntrinsicModifierName()
return "modifier_item_wind_waker_custom"
end

function item_wind_waker_custom:Spawn()
self.bonus_movement_speed = self:GetSpecialValueFor("bonus_movement_speed")
self.bonus_mana_regen = self:GetSpecialValueFor("bonus_mana_regen")
self.bonus_intellect = self:GetSpecialValueFor("bonus_intellect")
self.bonus_damage = self:GetSpecialValueFor("bonus_damage")
self.cyclone_duration = self:GetSpecialValueFor("cyclone_duration")
self.tooltip_drop_damage = self:GetSpecialValueFor("tooltip_drop_damage")
self.tornado_speed = self:GetSpecialValueFor("tornado_speed")
self.speed_duration = self:GetSpecialValueFor("speed_duration")
self.speed_move = self:GetSpecialValueFor("speed_move")
end

function item_wind_waker_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

if target:TriggerSpellAbsorb(self) then return end
target:EmitSound("DOTA_Item.Cyclone.Activate")

if target == caster then
  caster:Purge(false, true, false, false, false)
end

local player_id = caster:GetPlayerOwnerID()
local custom_effect_data = shop:GetCurrentEffectData(player_id, "effect_eul")
local pfx_name = "particles/items_fx/cyclone_custom.vpcf"
if custom_effect_data then
    pfx_name = custom_effect_data[1]
end
target:AddNewModifier(caster, self, "modifier_item_wind_waker_custom_active", {duration = self.cyclone_duration, particle_name = pfx_name})
target:AddNewModifier(caster, self, "modifier_wind_waker", {duration = self.cyclone_duration})
end

modifier_item_wind_waker_custom_active = class(mod_hidden)
function modifier_item_wind_waker_custom_active:IsPurgable() return true end
function modifier_item_wind_waker_custom_active:OnCreated(params)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if IsServer() then
    self.particle_name = params.particle_name
    self:SetHasCustomTransmitterData(true)
    self:SendBuffRefreshToClients()
    self:OnIntervalThink()
    self:StartIntervalThink(0.1)
else
    self:StartIntervalThink(0.01)
end

end

function modifier_item_wind_waker_custom_active:OnIntervalThink()
local origin = self.parent:GetAbsOrigin()

if IsServer() then
    self:SetStackCount(GetGroundPosition(origin, nil).z)
    return
end

origin.z = self:GetStackCount()

if self.particle_name and not self.pfx_handle then
    local particle = ParticleManager:CreateParticle(self.particle_name, PATTACH_WORLDORIGIN, self.parent)
    ParticleManager:SetParticleControl(particle, 0, origin)
    self:AddParticle(particle, false, false, -1, false, false)
    self.pfx_handle = particle
end
if self.pfx_handle then
    ParticleManager:SetParticleControl(self.pfx_handle, 0, origin)
end

end

function modifier_item_wind_waker_custom_active:AddCustomTransmitterData()
return 
{
    particle_name = self.particle_name,
}
end

function modifier_item_wind_waker_custom_active:HandleCustomTransmitterData( data )
self.particle_name = data.particle_name
end


function modifier_item_wind_waker_custom_active:OnDestroy()
if not IsServer() then return end
if not IsValid(self.ability) then return end
if self.caster ~= self.parent then return end
--self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_wind_waker_custom_speed", {duration = self.ability.speed_duration})
end




modifier_item_wind_waker_custom_speed = class(mod_visible)
function modifier_item_wind_waker_custom_speed:IsPurgable() return true end
function modifier_item_wind_waker_custom_speed:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move = self.ability.speed_move
if not IsServer() then return end
self.parent:GenericParticle("particles/econ/events/seasonal_reward_line_fall_2025/phase_boots_fallrewardline_2025.vpcf", self)
end

function modifier_item_wind_waker_custom_speed:CheckState()
return
{
  [MODIFIER_STATE_UNSLOWABLE] = true
}
end

function modifier_item_wind_waker_custom_speed:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_item_wind_waker_custom_speed:GetModifierMoveSpeedBonus_Percentage()
return self.move
end



modifier_item_wind_waker_custom = class(mod_hidden)
function modifier_item_wind_waker_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
  MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
}
end

function modifier_item_wind_waker_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not self.parent.cdr_items then
  self.parent.cdr_items = {}
end
self.parent.cdr_items[self] = self.ability:GetSpecialValueFor("cdr_bonus")
end

function modifier_item_wind_waker_custom:GetModifierConstantManaRegen()
return self.ability.bonus_mana_regen
end

function modifier_item_wind_waker_custom:GetModifierBonusStats_Intellect()
return self.ability.bonus_intellect
end

function modifier_item_wind_waker_custom:GetModifierMoveSpeedBonus_Constant()
return self.ability.bonus_movement_speed
end