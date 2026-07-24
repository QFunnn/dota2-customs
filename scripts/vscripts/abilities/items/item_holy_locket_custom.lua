--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_holy_locket_custom", "abilities/items/item_holy_locket_custom", LUA_MODIFIER_MOTION_NONE)

item_holy_locket_custom = class({})

function item_holy_locket_custom:GetIntrinsicModifierName()
return "modifier_item_holy_locket_custom"
end

function item_holy_locket_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items2_fx/magic_stick.vpcf", context )
PrecacheResource( "particle","particles/items/holy_locket_beam.vpcf", context )
PrecacheResource( "particle","particles/items/holy_locket_caster.vpcf", context )
end


function item_holy_locket_custom:GetBehavior()
if not IsSoloMode() then 
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK
end 
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK
end


function item_holy_locket_custom:OnSpellStart()

local caster = self:GetCaster()
local target = caster
if self:GetCursorTarget() then
    target = self:GetCursorTarget()
end

local max = self:GetSpecialValueFor("max_charges")
local mana = (self:GetSpecialValueFor("restore_mana")/max)*self:GetCurrentCharges()
local heal = (self:GetSpecialValueFor("restore_health")/max) *self:GetCurrentCharges()*(target:GetMaxHealth() - target:GetHealth())/100

local real_heal = target:GenericHeal(heal, self, false, "")
target:GiveMana(mana)


local particle = ParticleManager:CreateParticle("particles/items2_fx/magic_stick.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
ParticleManager:SetParticleControl(particle, 1, Vector(self:GetCurrentCharges()/10, 0, 0))
ParticleManager:DestroyParticle(particle, false)
ParticleManager:ReleaseParticleIndex(particle)

self:SetCurrentCharges(0)

if real_heal <= 0 then return end

target:EmitSound("Item.Holy_Locket2")
target:EmitSound("Item.Holy_Locket1")

Timers:CreateTimer(2, function()
    if target and not target:IsNull() then
        target:StopSound("Item.Holy_Locket1")
    end
end)

local radius = self:GetSpecialValueFor("damage_radius")

local effect_target = ParticleManager:CreateParticle( "particles/items/holy_locket_caster.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
ParticleManager:SetParticleControl( effect_target, 1, Vector( radius/2, radius/2, radius/2 ) )
ParticleManager:ReleaseParticleIndex( effect_target )

local damageTable = {attacker = caster, damage = real_heal*self:GetSpecialValueFor("damage")/100, ability = self, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, damage_type = DAMAGE_TYPE_PURE}

for _,enemy in pairs(caster:FindTargets(radius, target:GetAbsOrigin())) do
    damageTable.victim = enemy
    DoDamage(damageTable)

    local particle = ParticleManager:CreateParticle( "particles/items/holy_locket_beam.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, target )
    ParticleManager:SetParticleControlEnt( particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
    ParticleManager:SetParticleControlEnt( particle, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
    ParticleManager:ReleaseParticleIndex( particle )
end

end


modifier_item_holy_locket_custom = class({})

function modifier_item_holy_locket_custom:IsHidden() return true end
function modifier_item_holy_locket_custom:IsPurgable() return false end
function modifier_item_holy_locket_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.radius = self.ability:GetSpecialValueFor("charge_radius")
self.cooldown = self.ability:GetSpecialValueFor("passive_cooldown")
self.max = self.ability:GetSpecialValueFor("max_charges")

self.agi = self.ability:GetSpecialValueFor("bonus_all_stats")
self.str = self.ability:GetSpecialValueFor("bonus_all_stats")
self.int = self.ability:GetSpecialValueFor("bonus_all_stats")
self.health = self.ability:GetSpecialValueFor("bonus_health")
self.heal_inc = self.ability:GetSpecialValueFor("heal_increase")

if not IsServer() then return end
if not self.parent:IsRealHero() then return end

self.parent:AddSpellEvent(self, true)
end


function modifier_item_holy_locket_custom:AddStack()
if not IsServer() then return end
if self.ability:GetCurrentCharges() >= self.max then return end

self.ability:SetCurrentCharges(self.ability:GetCurrentCharges() + 1)
end


function modifier_item_holy_locket_custom:SpellEvent(params)
if not IsServer() then return end
if not self.parent:IsAlive() then return end
if (self.parent ~= params.unit) and params.unit:GetTeamNumber() == self.parent:GetTeamNumber() then return end
if not self.parent:CanEntityBeSeenByMyTeam(params.unit) then return end
if params.ability:IsItem() then return end
if not params.unit:IsHero() then return end
if (params.unit:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > self.radius then return end

self:AddStack()
end

function modifier_item_holy_locket_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    MODIFIER_PROPERTY_HEALTH_BONUS,
    --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
    --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE
}
end

function modifier_item_holy_locket_custom:GetModifierBonusStats_Strength()
return self.str
end

function modifier_item_holy_locket_custom:GetModifierBonusStats_Agility()
return self.agi
end

function modifier_item_holy_locket_custom:GetModifierBonusStats_Intellect()
return self.int
end

function modifier_item_holy_locket_custom:GetModifierHealthBonus()
return self.health
end

function modifier_item_holy_locket_custom:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_inc
end

function modifier_item_holy_locket_custom:GetModifierHealChange() 
return self.heal_inc
end

function modifier_item_holy_locket_custom:GetModifierHPRegenAmplify_Percentage() 
return self.heal_inc
end
