--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_npc_muerta_ogre_hit_slow", "abilities/muerta/npc_muerta_ogre_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_npc_muerta_ogre_passive", "abilities/muerta/npc_muerta_ogre_abilities", LUA_MODIFIER_MOTION_NONE)

npc_muerta_ogre_hit = class({})

function npc_muerta_ogre_hit:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/generic_gameplay/generic_has_quest.vpcf", context )
PrecacheResource( "particle", "particles/act_2/ogre_seal_suprise.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf", context )
PrecacheResource( "particle", "particles/status_fx/status_effect_snapfire_slow.vpcf", context )
PrecacheResource( "particle", "particles/generic_gameplay/generic_has_quest.vpcf", context )
PrecacheResource( "particle", "particles/red_zone.vpcf", context )
PrecacheResource( "particle", "particles/act_2/ogre_seal_suprise.vpcf", context )
end


function npc_muerta_ogre_hit:Spawn()
if not self:GetCaster() then return end
self.caster = self:GetCaster()

self.range = self:GetLevelSpecialValueFor("range", 1)
self.aoe = self:GetLevelSpecialValueFor("aoe", 1)
self.duration = self:GetLevelSpecialValueFor("duration", 1)
self.damage = self:GetLevelSpecialValueFor("damage", 1)/100
self.slow = self:GetLevelSpecialValueFor("slow", 1)
self.heal = self:GetLevelSpecialValueFor("heal", 1)
self.stun = self:GetLevelSpecialValueFor("stun", 1)
end
  
function npc_muerta_ogre_hit:OnAbilityPhaseStart()
self.sign = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_has_quest.vpcf", PATTACH_OVERHEAD_FOLLOW, self.caster)
return true
end 

function npc_muerta_ogre_hit:OnAbilityPhaseInterrupted()

if self.sign then
    ParticleManager:DestroyParticle(self.sign, true)
    ParticleManager:ReleaseParticleIndex(self.sign)
    self.sign = nil
end

end

function npc_muerta_ogre_hit:OnSpellStart()

if self.sign then
    ParticleManager:DestroyParticle(self.sign, true)
    ParticleManager:ReleaseParticleIndex(self.sign)
    self.sign = nil
end

local point = self.caster:GetAbsOrigin() + self.caster:GetForwardVector()*self.range

EmitSoundOnLocationWithCaster(point, "Hero_Centaur.HoofStomp", self.caster)

local nFXIndex = ParticleManager:CreateParticle( "particles/act_2/ogre_seal_suprise.vpcf", PATTACH_WORLDORIGIN, self.caster)
ParticleManager:SetParticleControl( nFXIndex, 0, point )
ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 50, 50, 50 ) )
ParticleManager:ReleaseParticleIndex( nFXIndex )

local damageTable = {attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}

for _,unit in pairs(self.caster:FindTargets(self.aoe, point)) do 
    local damage = self.damage*unit:GetMaxHealth()
    damageTable.victim = unit
    damageTable.damage = damage
    unit:SendNumber(6, damage)

    DoDamage(damageTable)

    unit:AddNewModifier(self.caster, self, "modifier_npc_muerta_ogre_hit_slow", {duration = self.duration})
   
    local knockbackProperties =
    {
        center_x = unit:GetOrigin().x,
        center_y = unit:GetOrigin().y,
        center_z = unit:GetOrigin().z,
        duration = self.stun,
        knockback_duration = self.stun,
        knockback_distance = 0,
        knockback_height = 70,
        isStun = true,
    }
    unit:AddNewModifier( self.caster, self, "modifier_knockback", knockbackProperties)
end

end

modifier_npc_muerta_ogre_hit_slow = class(mod_visible)
function modifier_npc_muerta_ogre_hit_slow:IsPurgable() return true end
function modifier_npc_muerta_ogre_hit_slow:GetStatusEffectName() return "particles/status_fx/status_effect_snapfire_slow.vpcf" end
function modifier_npc_muerta_ogre_hit_slow:StatusEffectPriority() return MODIFIER_PRIORITY_NORMAL end
function modifier_npc_muerta_ogre_hit_slow:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.slow = self.ability.slow
self.heal = self.ability.heal
if not IsServer() then return end
self.parent:GenericParticle("particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf", self)

end

function modifier_npc_muerta_ogre_hit_slow:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
}
end

function modifier_npc_muerta_ogre_hit_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_npc_muerta_ogre_hit_slow:GetModifierHealChange()
return self.heal
end

function modifier_npc_muerta_ogre_hit_slow:GetModifierHPRegenAmplify_Percentage() 
return self.heal
end



npc_muerta_ogre_jump = class({})

function npc_muerta_ogre_jump:Spawn()
if not self:GetCaster() then return end
self.caster = self:GetCaster()

self.stun = self:GetLevelSpecialValueFor("stun", 1)
self.slow = self:GetLevelSpecialValueFor("slow", 1)
self.heal = self:GetLevelSpecialValueFor("heal", 1)
self.damage = self:GetLevelSpecialValueFor("damage", 1)/100
self.duration = self:GetLevelSpecialValueFor("duration", 1)
self.radius = self:GetLevelSpecialValueFor("radius", 1)
end

function npc_muerta_ogre_jump:OnAbilityPhaseStart()
self.sign = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_has_quest.vpcf", PATTACH_OVERHEAD_FOLLOW, self.caster)

self.effect_cast = ParticleManager:CreateParticle("particles/red_zone.vpcf", PATTACH_CUSTOMORIGIN, self.caster)
ParticleManager:SetParticleControl( self.effect_cast, 0, self.caster:GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 0, -self.radius))
ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( 1, 0, 0 ) )

return true
end 


function npc_muerta_ogre_jump:OnAbilityPhaseInterrupted()

if self.sign then
    ParticleManager:DestroyParticle(self.sign, true)
    ParticleManager:ReleaseParticleIndex(self.sign)
    self.sign = nil
end

if self.effect_cast then
    ParticleManager:DestroyParticle(self.effect_cast, true)
    ParticleManager:ReleaseParticleIndex(self.effect_cast)
    self.effect_cast = nil
end

end

function npc_muerta_ogre_jump:OnSpellStart()

if self.sign then
    ParticleManager:DestroyParticle(self.sign, true)
    ParticleManager:ReleaseParticleIndex(self.sign)
    self.sign = nil
end

if self.effect_cast then
    ParticleManager:DestroyParticle(self.effect_cast, true)
    ParticleManager:ReleaseParticleIndex(self.effect_cast)
    self.effect_cast = nil
end

local point = self.caster:GetAbsOrigin()
EmitSoundOnLocationWithCaster(point, "Hero_Centaur.HoofStomp", self.caster)

local nFXIndex = ParticleManager:CreateParticle( "particles/act_2/ogre_seal_suprise.vpcf", PATTACH_WORLDORIGIN,  self.caster  )
ParticleManager:SetParticleControl( nFXIndex, 0, point )
ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 200, 200, 200 ) )
ParticleManager:ReleaseParticleIndex( nFXIndex )

local damageTable = {attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}

for _,unit in pairs(self.caster:FindTargets(self.radius)) do 
    local damage = self.damage*unit:GetMaxHealth()
    damageTable.victim = unit
    damageTable.damage = damage
    unit:SendNumber(6, damage)

    DoDamage(damageTable)

    unit:AddNewModifier(self.caster, self, "modifier_npc_muerta_ogre_hit_slow", {duration = self.duration})
   
    local knockbackProperties =
    {
        center_x = unit:GetOrigin().x,
        center_y = unit:GetOrigin().y,
        center_z = unit:GetOrigin().z,
        duration = self.stun,
        knockback_duration = self.stun,
        knockback_distance = 0,
        knockback_height = 70,
        isStun = true,
    }
    unit:AddNewModifier( self.caster, self, "modifier_knockback", knockbackProperties)
end

end


npc_muerta_ogre_passive = class({})

function npc_muerta_ogre_passive:GetIntrinsicModifierName()
return "modifier_npc_muerta_ogre_passive"
end

function npc_muerta_ogre_passive:Spawn()
if not self:GetCaster() then return end
self.caster = self:GetCaster()

self.speed = self:GetLevelSpecialValueFor("speed", 1)
self.move = self:GetLevelSpecialValueFor("move", 1)
end

modifier_npc_muerta_ogre_passive = class(mod_hidden)
function modifier_npc_muerta_ogre_passive:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move = self.ability.move
self.speed = self.ability.speed
end

function modifier_npc_muerta_ogre_passive:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_npc_muerta_ogre_passive:GetModifierMoveSpeedBonus_Percentage()
return self.move*(1 - self.parent:GetHealthPercent()/100)
end

function modifier_npc_muerta_ogre_passive:GetModifierAttackSpeedBonus_Constant()
return self.speed*(1 - self.parent:GetHealthPercent()/100)
end
