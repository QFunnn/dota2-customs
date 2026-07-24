--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_specialists_array_custom", "abilities/items/item_specialists_array_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_specialists_array_custom_damage", "abilities/items/item_specialists_array_custom", LUA_MODIFIER_MOTION_NONE)

item_specialists_array_custom = class({})

function item_specialists_array_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_specialists_array_custom"
end

function item_specialists_array_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items8_fx/specialists_array_follower.vpcf", context )
end

function item_specialists_array_custom:OnProjectileHit(target, location)
if not target then return end
local caster = self:GetCaster()

caster:AddNewModifier(caster, self, "modifier_item_specialists_array_custom_damage", {})
caster:PerformAttack(target, true, false, true, true, false, false, true)
caster:RemoveModifierByName("modifier_item_specialists_array_custom_damage")
end


modifier_item_specialists_array_custom = class(mod_hidden)
function modifier_item_specialists_array_custom:RemoveOnDeath() return false end
function modifier_item_specialists_array_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.ability.agility = self.ability:GetSpecialValueFor("agility")
self.ability.damage = self.ability:GetSpecialValueFor("damage")
self.ability.count = self.ability:GetSpecialValueFor("count")
self.ability.secondary_target_range_bonus = self.ability:GetSpecialValueFor("secondary_target_range_bonus")
self.ability.secondary_target_angle = self.ability:GetSpecialValueFor("secondary_target_angle")
self.ability.proc_chance = self.ability:GetSpecialValueFor("proc_chance")
self.ability.proc_damage = self.ability:GetSpecialValueFor("proc_damage")
self.ability.melee_count = self.ability:GetSpecialValueFor("melee_count")

if not IsServer() then return end
if not self.parent:IsRealHero() then return end
self.parent:AddAttackStartEvent_out(self, true)
end

function modifier_item_specialists_array_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
}
end

function modifier_item_specialists_array_custom:GetModifierBonusStats_Agility()
return self.ability.agility
end

function modifier_item_specialists_array_custom:GetModifierPreAttack_BonusDamage()
return self.ability.damage
end

function modifier_item_specialists_array_custom:AttackStartEvent_out(params)
if not IsServer() then return end
if self.parent:HasModifier("modifier_item_hydras_breath_custom") then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
if params.no_attack_cooldown then return end
if not RollPseudoRandomPercentage(self.ability.proc_chance, 9403, self.parent) then return end

local count = 0
local target = params.target
local speed = 900
local max = self.ability.melee_count
if self.parent:IsRangedAttacker() then
    speed = self.parent:GetProjectileSpeed()
    max = self.ability.count 
end

local info = 
{
    EffectName = "particles/items8_fx/specialists_array_follower.vpcf",
    Ability = self.ability,
    iMoveSpeed = speed,
    Source = self.parent,
    Target = self.parent,
    bDodgeable = true,
    iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1, 
}

local radius = self.parent:Script_GetAttackRange() + self.ability.secondary_target_range_bonus
local cast_direction = (target:GetAbsOrigin() - self.parent:GetAbsOrigin()):Normalized()
local cast_angle = VectorToAngles( cast_direction ).y

for _,aoe_target in pairs(self.parent:FindTargets(radius)) do
    if aoe_target ~= target then
        local enemy_direction = (aoe_target:GetAbsOrigin() - self.parent:GetAbsOrigin()):Normalized()
        local enemy_angle = VectorToAngles( enemy_direction ).y
        local angle_diff = math.abs( AngleDiff( cast_angle, enemy_angle ) )

        if angle_diff <= self.ability.secondary_target_angle / 2 then
            info.Target = aoe_target
            ProjectileManager:CreateTrackingProjectile(info)
            count = count + 1
            if count >= max then
                break
            end
        end
    end
end

end


modifier_item_specialists_array_custom_damage = class(mod_hidden)
function modifier_item_specialists_array_custom_damage:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.damage = self.ability.proc_damage - 100
end

function modifier_item_specialists_array_custom_damage:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
}
end

function modifier_item_specialists_array_custom_damage:GetModifierTotalDamageOutgoing_Percentage(params)
if params.inflictor then return end
return self.damage
end