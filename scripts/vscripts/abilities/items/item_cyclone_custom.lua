--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_cyclone_custom", "abilities/items/item_cyclone_custom", LUA_MODIFIER_MOTION_NONE)

item_cyclone_custom = class({})

function item_cyclone_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","", context )
end

function item_cyclone_custom:GetIntrinsicModifierName()
return "modifier_item_cyclone_custom"
end

function item_cyclone_custom:Spawn()
self.bonus_intellect = self:GetSpecialValueFor("bonus_intellect")
self.bonus_mana_regen  = self:GetSpecialValueFor("bonus_mana_regen")
self.bonus_movement_speed = self:GetSpecialValueFor("bonus_movement_speed")
self.cyclone_duration = self:GetSpecialValueFor("cyclone_duration")
self.tooltip_drop_damage = self:GetSpecialValueFor("tooltip_drop_damage")
end

function item_cyclone_custom:CastFilterResultTarget(target)
if not IsServer() then return end
local caster = self:GetCaster()
if target and target:GetTeamNumber() == caster:GetTeamNumber() and target ~= caster then 
  return UF_FAIL_FRIENDLY
end
return UnitFilter( target, self:GetAbilityTargetTeam(), self:GetAbilityTargetType(), self:GetAbilityTargetFlags(), self:GetCaster():GetTeamNumber() )
end

function item_cyclone_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

if target:TriggerSpellAbsorb(self) then return end
target:EmitSound("DOTA_Item.Cyclone.Activate")

if target == caster then
  caster:Purge(false, true, false, false, false)
end
local modifier_eul_cyclone = target:AddNewModifier(caster, self, "modifier_eul_cyclone", {duration = self.cyclone_duration})
if modifier_eul_cyclone then
    local player_id = caster:GetPlayerOwnerID()
    local custom_effect_data = shop:GetCurrentEffectData(player_id, "effect_eul")
    local pfx_name = "particles/items_fx/cyclone_custom.vpcf"
    if custom_effect_data then
        pfx_name = custom_effect_data[1]
    end
    local particle = ParticleManager:CreateParticle(pfx_name, PATTACH_WORLDORIGIN, target)
    ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
    modifier_eul_cyclone:AddParticle(particle, false, false, -1, false, false)
end
end


modifier_item_cyclone_custom = class(mod_hidden)
function modifier_item_cyclone_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
  MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
}
end

function modifier_item_cyclone_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
end

function modifier_item_cyclone_custom:GetModifierConstantManaRegen()
return self.ability.bonus_mana_regen
end

function modifier_item_cyclone_custom:GetModifierBonusStats_Intellect()
return self.ability.bonus_intellect
end

function modifier_item_cyclone_custom:GetModifierMoveSpeedBonus_Constant()
return self.ability.bonus_movement_speed
end

