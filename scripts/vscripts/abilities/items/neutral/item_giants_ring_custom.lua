--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_giants_ring_custom", "abilities/items/neutral/item_giants_ring_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_giants_ring_custom", "abilities/items/neutral/item_giants_ring_custom", LUA_MODIFIER_MOTION_NONE)

item_giants_ring_custom = class({})


function item_giants_ring_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_sandking/sandking_epicenter.vpcf", context )
end

function item_giants_ring_custom:GetIntrinsicModifierName()
return "modifier_item_giants_ring_custom"
end

function item_giants_ring_custom:OnSpellStart()
local caster = self:GetCaster()

caster:EmitSound("Giant.Ring")
caster:AddNewModifier(caster, self, "modifier_giants_ring_custom", {duration = self:GetSpecialValueFor("duration")})
end


modifier_item_giants_ring_custom = class({})
function modifier_item_giants_ring_custom:IsHidden() return true end
function modifier_item_giants_ring_custom:IsPurgable() return false end
function modifier_item_giants_ring_custom:RemoveOnDeath() return false end

function modifier_item_giants_ring_custom:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.radius = self.ability:GetSpecialValueFor("radius")
self.str_damage = self.ability:GetSpecialValueFor("str_damage")/100
self.max_damage = self.ability:GetSpecialValueFor("max_damage")
self.interval = 0.5

self.str_bonus = self.ability:GetSpecialValueFor("str_bonus")
self.model_scale = self.ability:GetSpecialValueFor("model_scale")
self.model_scale_bonus = self.ability:GetSpecialValueFor("active_scale")

self.damageTable = {attacker = self.parent, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability}

if not IsServer() then return end
if self.parent:IsTempestDouble() then return end
if not self.parent:IsRealHero() then return end

self:StartIntervalThink(0.5)
end

function modifier_item_giants_ring_custom:OnIntervalThink()
if not IsServer() then return end
if not self.parent:IsAlive() then return end 

local damage = math.min(self.max_damage, self.parent:GetStrength()*self.str_damage)*self.interval

for _,enemy in pairs(self.parent:FindTargets(self.radius)) do
    self.damageTable.damage = damage
    self.damageTable.victim = enemy
    DoDamage(self.damageTable)
end

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_sandking/sandking_epicenter.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl( effect_cast, 1, Vector(150,1,1))
ParticleManager:ReleaseParticleIndex( effect_cast )
end


function modifier_item_giants_ring_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_MODEL_SCALE
}
end


function modifier_item_giants_ring_custom:GetModifierBonusStats_Strength()
return self.str_bonus
end

function modifier_item_giants_ring_custom:GetModifierModelScale() 
if self.parent:HasModifier("modifier_primal_beast_innate_custom") then return end
local bonus = self.model_scale
if self.parent:HasModifier("modifier_giants_ring_custom") then 
    bonus = bonus*self.model_scale_bonus
end
return bonus
end


modifier_giants_ring_custom = class({})
function modifier_giants_ring_custom:IsHidden() return false end
function modifier_giants_ring_custom:IsPurgable() return false end
function modifier_giants_ring_custom:CheckState()
return
{
    [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
    [MODIFIER_STATE_UNSLOWABLE] = true,
}
end

function modifier_giants_ring_custom:OnCreated()
self.parent = self:GetParent()
if not IsServer() then return end
self:StartIntervalThink(0.2)
self:OnIntervalThink()
end

function modifier_giants_ring_custom:OnIntervalThink()
if not IsServer() then return end
GridNav:DestroyTreesAroundPoint(self.parent:GetAbsOrigin(), 100, true)
end