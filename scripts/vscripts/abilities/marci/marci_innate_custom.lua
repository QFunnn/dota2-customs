--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_marci_innate_custom_tracker", "abilities/marci/marci_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_marci_innate_custom_active", "abilities/marci/marci_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_marci_innate_custom_regen", "abilities/marci/marci_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_marci_innate_custom_move", "abilities/marci/marci_innate_custom", LUA_MODIFIER_MOTION_NONE )

marci_innate_custom = class({})
marci_innate_custom.talents = {}

function marci_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_marci.vsndevts", context )
PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_marci.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_marci", context)
end

function marci_innate_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_w1 = 0,
    w1_damage = 0,
      
    has_w4 = 0,
    w4_cd_items = caster:GetTalentValue("modifier_marci_rebound_4", "cd_items", true),
    w4_cdr = caster:GetTalentValue("modifier_marci_rebound_4", "cdr", true),
    w4_mana = caster:GetTalentValue("modifier_marci_rebound_4", "mana", true)/100,

    has_h1 = 0,
    h1_move = 0,
    h1_cd = 0,

    has_h3 = 0,
    h3_regen = 0,
    h3_max = caster:GetTalentValue("modifier_marci_hero_3", "max", true),
    h3_duration = caster:GetTalentValue("modifier_marci_hero_3", "duration", true),

    has_h4 = 0,
    h4_move = caster:GetTalentValue("modifier_marci_hero_4", "move", true),
    h4_duration = caster:GetTalentValue("modifier_marci_hero_4", "duration", true),
    h4_slow_resist = caster:GetTalentValue("modifier_marci_hero_4", "slow_resist", true),
    h4_range = caster:GetTalentValue("modifier_marci_hero_4", "range", true),
    h4_move_max = caster:GetTalentValue("modifier_marci_hero_4", "move_max", true),
    h4_move_max_real = caster:GetTalentValue("modifier_marci_hero_4", "move_max_real", true),
  }
end

if caster:HasTalent("modifier_marci_rebound_1") then
  self.talents.has_w1 = 1
  self.talents.w1_damage = caster:GetTalentValue("modifier_marci_rebound_1", "damage")
end

if caster:HasTalent("modifier_marci_rebound_4") then
  self.talents.has_w4 = 1
end

if caster:HasTalent("modifier_marci_hero_1") then
  self.talents.has_h1 = 1
  self.talents.h1_move = caster:GetTalentValue("modifier_marci_hero_1", "move")
  self.talents.h1_cd = caster:GetTalentValue("modifier_marci_hero_1", "cd")
end

if caster:HasTalent("modifier_marci_hero_3") then
  self.talents.has_h3 = 1
  self.talents.h3_regen = caster:GetTalentValue("modifier_marci_hero_3", "regen")
end

if caster:HasTalent("modifier_marci_hero_4") then
  self.talents.has_h4 = 1
end

end  

function marci_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_marci_innate_custom_tracker"
end

function marci_innate_custom:GetRange()
return (self.range and self.range or 0) + (self.talents.has_h4 == 1 and self.talents.h4_range or 0)
end

function marci_innate_custom:GetCastRange(vLocation, hTarget)
if IsClient() then 
    return self:GetRange() - self.caster:GetCastRangeBonus()
end
return 999999
end

function marci_innate_custom:GetAOERadius()
return self.radius and self.radius or 0
end

function marci_innate_custom:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel) + (self.talents.h1_cd and self.talents.h1_cd or 0)
end

function marci_innate_custom:OnSpellStart()

local point = self:GetCursorPosition()
if point == self.caster:GetAbsOrigin() then 
    point = self.caster:GetAbsOrigin() + self.caster:GetForwardVector()*10
end

local dir = (point - self.caster:GetAbsOrigin())

self.caster:RemoveModifierByName("modifier_marci_innate_custom_active")
self.caster:EmitSound("Marci.Launge_start")

local distance = math.max(100, math.min(dir:Length2D(), self:GetRange()))
local speed = distance/self.duration_jump

local duration = (distance/speed)
local height = 60
if distance < 100 then 
    height = 0
end 

dir = dir:Normalized()
self.caster:FaceTowards(point)
self.caster:SetForwardVector(dir)
self.caster:RemoveGesture(ACT_DOTA_CAST_ABILITY_3)
self.caster:RemoveGesture(ACT_DOTA_ATTACK)

if self.talents.has_w4 == 1 then
    local mana = self.talents.w4_mana*self.caster:GetMaxMana()
    self.caster:GiveMana(mana)
    self.caster:SendNumber(OVERHEAD_ALERT_MANA_ADD, mana)

    self.caster:CdItems(self.talents.w4_cd_items)
end

local arc = self.caster:AddNewModifier( self.caster, self, "modifier_generic_arc",
{ 
    dir_x = dir.x,
    dir_y = dir.y,
    duration = duration,
    distance = distance,
    height = height,
    fix_end = false,
    isStun = true,
    isForward = true,
})

if not arc then return end

self.caster:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_2)

arc:SetEndCallback( function( interrupted )

    if IsValid(self.caster.unleash_ability) then
        self.caster.unleash_ability:Pulse(self.caster:GetAbsOrigin(), true)
    end

    self.caster:RemoveGesture(ACT_DOTA_OVERRIDE_ABILITY_2)
    self.caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2_END, 1.2)

    if self.talents.has_h4 == 1 then
        self.caster:RemoveModifierByName("modifier_marci_innate_custom_move")
        self.caster:AddNewModifier(self.caster, self, "modifier_marci_innate_custom_move", {duration = self.talents.h4_duration})
    end

    local point = self.caster:GetAbsOrigin()
    local damageTable = {attacker = self.caster, ability = self, damage = self.damage + self.ability.talents.w1_damage, damage_type = DAMAGE_TYPE_MAGICAL}
    for _,target in pairs(self.caster:FindTargets(self.radius, point)) do
        damageTable.victim = target
        DoDamage(damageTable)

        if IsValid(self.caster.rebound_ability) then
            self.caster.rebound_ability:ApplyProc(target, true)
        end
    end

    local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_unleash_pulse.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( particle, 0, point )
    ParticleManager:SetParticleControl( particle, 1, Vector(self.radius*1.4, self.radius*1.4, self.radius*1.4))
    ParticleManager:DestroyParticle(particle, false)
    ParticleManager:ReleaseParticleIndex( particle )

    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_rebound_bounce_impact.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, point)
    ParticleManager:SetParticleControl( effect_cast, 1, point )
    ParticleManager:SetParticleControl( effect_cast, 9, Vector(self.radius, self.radius, self.radius) )
    ParticleManager:SetParticleControl( effect_cast, 10, point )
    ParticleManager:DestroyParticle(effect_cast, false)
    ParticleManager:ReleaseParticleIndex( effect_cast )
    EmitSoundOnLocationWithCaster( point, "Marci.Launge_end", self.caster )
end)

end


modifier_marci_innate_custom_tracker = class(mod_hidden)
function modifier_marci_innate_custom_tracker:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.ability.damage = self.ability:GetSpecialValueFor("damage")
self.ability.range = self.ability:GetSpecialValueFor("range")
self.ability.timer = self.ability:GetSpecialValueFor("timer")
self.ability.radius = self.ability:GetSpecialValueFor("radius")
self.ability.duration_jump = self.ability:GetSpecialValueFor("duration_jump")
if not IsServer() then return end

self.ability:SetActivated(false)
self.parent:AddSpellEvent(self, true)
end

function modifier_marci_innate_custom_tracker:SpellEvent(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end
if params.ability:IsItem() then return end

if self.ability.talents.has_h3 == 1 then
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_marci_innate_custom_regen", {duration = self.ability.talents.h3_duration})
end

if self.ability == params.ability then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_marci_innate_custom_active", {duration = self.ability.timer})
end

function modifier_marci_innate_custom_tracker:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
    MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING,
    MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE
}
end

function modifier_marci_innate_custom_tracker:GetModifierMoveSpeedBonus_Constant()
return self.ability.talents.h1_move
end

function modifier_marci_innate_custom_tracker:GetModifierSlowResistance_Stacking()
if self.ability.talents.has_h4 == 0 then return end
return self.ability.talents.h4_slow_resist
end

function modifier_marci_innate_custom_tracker:GetModifierPercentageCooldown() 
if self.ability.talents.has_w4 == 0 then return end
return self.ability.talents.w4_cdr
end

function modifier_marci_innate_custom_tracker:GetModifierProcAttack_Feedback(params)
if not IsServer() then return end
if params.no_attack_cooldown then return end
params.target:EmitSound("Hero_Marci.Attack_custom")
end

modifier_marci_innate_custom_active = class(mod_hidden)
function modifier_marci_innate_custom_active:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self.ability:SetActivated(true)
end

function modifier_marci_innate_custom_active:OnDestroy()
if not IsServer() then return end
self.ability:SetActivated(false)
end



modifier_marci_innate_custom_regen = class(mod_visible)
function modifier_marci_innate_custom_regen:GetTexture() return "buffs/marci/hero_3" end
function modifier_marci_innate_custom_regen:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.talents.h3_max
self.regen = self.ability.talents.h3_regen

if not IsServer() then return end
self:OnRefresh()
end

function modifier_marci_innate_custom_regen:OnRefresh()
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_marci_innate_custom_regen:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
}
end

function modifier_marci_innate_custom_regen:GetModifierConstantHealthRegen()
return self:GetStackCount()*self.regen
end


modifier_marci_innate_custom_move = class(mod_hidden)
function modifier_marci_innate_custom_move:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move = self.ability.talents.h4_move
self.max_move = self.ability.talents.h4_move_max_real

if not IsServer() then return end
self.parent:GenericParticle("particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", self)
self.parent:EmitSound("Hero_Marci.Rebound.Ally")
end

function modifier_marci_innate_custom_move:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
    MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
    MODIFIER_PROPERTY_MOVESPEED_LIMIT,
    MODIFIER_PROPERTY_MOVESPEED_MAX,
}
end

function modifier_marci_innate_custom_move:GetActivityTranslationModifiers()
return "haste"
end

function modifier_marci_innate_custom_move:GetModifierMoveSpeedBonus_Percentage()
return self.move
end

function modifier_marci_innate_custom_move:GetModifierIgnoreMovespeedLimit( params )
return 1
end

function modifier_marci_innate_custom_move:GetModifierMoveSpeed_Max( params )
return self.max_move
end

function modifier_marci_innate_custom_move:GetModifierMoveSpeed_Limit()
return self.max_move
end

