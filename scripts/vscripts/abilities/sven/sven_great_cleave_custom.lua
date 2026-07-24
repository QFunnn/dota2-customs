--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_sven_great_cleave_custom", "abilities/sven/sven_great_cleave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_great_cleave_custom_slow", "abilities/sven/sven_great_cleave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_great_cleave_custom_slow_count", "abilities/sven/sven_great_cleave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_great_cleave_custom_speed", "abilities/sven/sven_great_cleave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_great_cleave_custom_speed_cd", "abilities/sven/sven_great_cleave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_great_cleave_custom_damage_perma", "abilities/sven/sven_great_cleave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_great_cleave_custom_armor", "abilities/sven/sven_great_cleave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_great_cleave_custom_legendary_slow", "abilities/sven/sven_great_cleave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_great_cleave_custom_legendary", "abilities/sven/sven_great_cleave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_great_cleave_custom_parry", "abilities/sven/sven_great_cleave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_great_cleave_custom_parry_cd", "abilities/sven/sven_great_cleave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_great_cleave_custom_vision_move", "abilities/sven/sven_great_cleave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_great_cleave_custom_vision", "abilities/sven/sven_great_cleave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_great_cleave_custom_break_cd", "abilities/sven/sven_great_cleave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_great_cleave_custom_break", "abilities/sven/sven_great_cleave_custom", LUA_MODIFIER_MOTION_NONE )



sven_great_cleave_custom = class({})
sven_great_cleave_custom_legendary = class({})



function sven_great_cleave_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/sven_wave_normal.vpcf", context )
PrecacheResource( "particle","particles/sven_wave_cast.vpcf", context )
PrecacheResource( "particle","particles/sven_wave_god.vpcf", context )
PrecacheResource( "particle","particles/sven_wave_cast_god.vpcf", context )
PrecacheResource( "particle","particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_static_field.vpcf", context )
PrecacheResource( "particle","particles/sven_wave_god_damage.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sven/sven_spell_great_cleave.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/sange_maim.vpcf", context )
PrecacheResource( "particle","particles/lc_odd_proc_.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_egg.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_streaks.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_lifesteal.vpcf", context )
PrecacheResource( "particle","particles/jugg_parry.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_axe/axe_cullingblade_sprint.vpcf", context )
PrecacheResource( "particle","particles/sven/cleave_refresh.vpcf", context )
PrecacheResource( "particle","particles/sven/cleave_refresh_red.vpcf", context )
PrecacheResource( "particle","particles/lc_odd_proc_.vpcf", context )
PrecacheResource( "particle","particles/sven/cleave_speed.vpcf", context )
PrecacheResource( "particle","particles/sven/cleave_speed_ready.vpcf", context )
PrecacheResource( "particle","particles/sven/cleave_speed_attack.vpcf", context )
PrecacheResource( "particle","particles/sven/cleave_speed_attack_range.vpcf", context )

end

function sven_great_cleave_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_sven_great_cleave_custom"
end




sven_great_cleave_custom_legendary = class({})

function sven_great_cleave_custom_legendary:CreateTalent()
self:GetCaster():SwapAbilities(self:GetName(), "sven_great_cleave_custom", true, false)
end


function sven_great_cleave_custom_legendary:GetCastRange(vLocation, hTarget)
local caster = self:GetCaster()
if IsClient() then 
    return caster:GetTalentValue("modifier_sven_cleave_7", "distance") - caster:GetTalentValue("modifier_sven_cleave_7", "width")
else 
    return 999999
end

end

function sven_great_cleave_custom_legendary:GetAbilityChargeRestoreTime(level)
if self:GetCaster():HasTalent("modifier_sven_cleave_7") then 
    return self:GetCaster():GetTalentValue("modifier_sven_cleave_7", "cd")
end 
return
end

function sven_great_cleave_custom_legendary:OnAbilityPhaseStart()
local caster = self:GetCaster()
caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.3)
caster:EmitSound("Sven.Cleave_wave_pre")
return true
end

function sven_great_cleave_custom_legendary:OnAbilityPhaseInterrupted()
self:GetCaster():FadeGesture(ACT_DOTA_ATTACK)
end


function sven_great_cleave_custom_legendary:OnSpellStart()
local caster = self:GetCaster()
local point = self:GetCursorPosition()

if point == caster:GetAbsOrigin() then
    point = caster:GetAbsOrigin() + caster:GetForwardVector()
end

local part = "particles/sven_wave_normal.vpcf"
local part_cast = "particles/sven_wave_cast.vpcf"

if caster:HasModifier("modifier_sven_gods_strength_custom") then 
    part = "particles/sven_wave_god.vpcf"
    part_cast = "particles/sven_wave_cast_god.vpcf"
end

local clown03_effect = ParticleManager:CreateParticle(part_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
ParticleManager:SetParticleControl(clown03_effect, 0, caster:GetAbsOrigin() )
ParticleManager:ReleaseParticleIndex(clown03_effect)

local width = caster:GetTalentValue("modifier_sven_cleave_7", "width")
local speed = caster:GetTalentValue("modifier_sven_cleave_7", "speed")

local parry_mod = caster:FindModifierByName("modifier_sven_great_cleave_custom_parry_cd")
if parry_mod then
    parry_mod:ReduceCd()
end

ProjectileManager:CreateLinearProjectile({
    EffectName = part,
    Ability = self,
    vSpawnOrigin = caster:GetAbsOrigin(),
    fStartRadius = width,
    fEndRadius = width,
    vVelocity = (point - caster:GetAbsOrigin()):Normalized() * speed,
    fDistance = caster:GetTalentValue("modifier_sven_cleave_7", "distance") - width,
    Source = caster,
    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
    bProvidesVision = true,
    iVisionTeamNumber = caster:GetTeamNumber(),
    iVisionRadius = width,
    ExtraData = {x = caster:GetAbsOrigin().x, y = caster:GetAbsOrigin().y}
})

caster:EmitSound("Sven.Cleave_wave")
end



function sven_great_cleave_custom_legendary:OnProjectileHit_ExtraData(target, location, table)
if not IsServer() then return end
if not target then return end

local caster = self:GetCaster()
local point_start = GetGroundPosition(Vector(table.x, table.y, table.z), nil)
local point_end = target:GetAbsOrigin()

local distance = (point_end - point_start):Length2D()
local k = math.max(0, math.min(1, distance/(caster:GetTalentValue("modifier_sven_cleave_7", "distance")*0.9) ))
local damage_min = caster:GetTalentValue("modifier_sven_cleave_7",  "damage_min")/100
local damage_max = caster:GetTalentValue("modifier_sven_cleave_7", "damage_max")/100

if target:IsRealHero() then
    caster:AddNewModifier(caster, self, "modifier_sven_great_cleave_custom_damage_perma", {})
end

if caster:HasTalent("modifier_sven_cleave_1") then
    target:AddNewModifier(caster, self, "modifier_sven_great_cleave_custom_slow_count", {duration = caster:GetTalentValue("modifier_sven_cleave_1", "count_duration")})
end

target:AddNewModifier(caster, self, "modifier_sven_great_cleave_custom_legendary_slow", {duration = caster:GetTalentValue("modifier_sven_cleave_7", "duration") *(1 - target:GetStatusResistance())})

local damage = caster:GetAverageTrueAttackDamage(nil)*(damage_min + (damage_max - damage_min)*k)
DoDamage({victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self}, "modifier_sven_cleave_7")

local part = "particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_static_field.vpcf"
if caster:HasModifier("modifier_sven_gods_strength_custom") then 
    part = "particles/sven_wave_god_damage.vpcf"
end

local particle = ParticleManager:CreateParticle( part, PATTACH_POINT_FOLLOW, target )
ParticleManager:SetParticleControlEnt( particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
ParticleManager:ReleaseParticleIndex( particle )

target:EmitSound("Sven.Cry_shield_damage")
end




modifier_sven_great_cleave_custom = class({})
function modifier_sven_great_cleave_custom:IsHidden() return true end
function modifier_sven_great_cleave_custom:IsPurgable() return false end

function modifier_sven_great_cleave_custom:OnCreated( kv )

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:AddAttackEvent_out(self)
self.parent:AddAttackEvent_inc(self)

self.great_cleave_start = self.ability:GetSpecialValueFor( "cleave_starting_width" )
self.great_cleave_end = self.ability:GetSpecialValueFor( "cleave_ending_width" )
self.great_cleave_distance = self.ability:GetSpecialValueFor( "cleave_distance" )

self.speed_cd = self.parent:GetTalentValue("modifier_sven_cleave_4", "cd", true)
self.speed_bonus = self.parent:GetTalentValue("modifier_sven_cleave_4", "bonus", true)

self.legendary_chance = self.parent:GetTalentValue("modifier_sven_cleave_7", "chance", true)

self.parry_duration = self.parent:GetTalentValue("modifier_sven_cleave_5", "duration", true)

self.slow_count = self.parent:GetTalentValue("modifier_sven_cleave_1", "count_duration", true)

self.vision_radius = self.parent:GetTalentValue("modifier_sven_cleave_6", "radius", true)
self.vision_health = self.parent:GetTalentValue("modifier_sven_cleave_6", "health", true)
self.vision_cd = self.parent:GetTalentValue("modifier_sven_cleave_6", "cd", true)
self.vision_break = self.parent:GetTalentValue("modifier_sven_cleave_6", "duration", true)

if not IsServer() then return end
self:StartIntervalThink(1)
end

function modifier_sven_great_cleave_custom:OnRefresh( kv )
self.great_cleave_damage = self.ability:GetSpecialValueFor( "great_cleave_damage" )
end

function modifier_sven_great_cleave_custom:OnIntervalThink()
if not IsServer() then return end
if not self.parent:IsAlive() then return end
if not self.parent:HasTalent("modifier_sven_cleave_4") then return end
if self.parent:HasModifier("modifier_sven_great_cleave_custom_speed") then return end
if self.parent:HasModifier("modifier_sven_great_cleave_custom_speed_cd") then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_sven_great_cleave_custom_speed", {})
self:StartIntervalThink(0.2)
end

function modifier_sven_great_cleave_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
}
end

function modifier_sven_great_cleave_custom:GetModifierBonusStats_Strength()
if not self.parent:HasTalent("modifier_sven_cleave_3") then return end
return self.parent:GetTalentValue("modifier_sven_cleave_3", "str")
end

function modifier_sven_great_cleave_custom:GetModifierAttackRangeBonus()
if not self.parent:HasTalent("modifier_sven_cleave_4") then return end
local bonus = self.parent:GetTalentValue("modifier_sven_cleave_4", "range")
if self.parent:HasModifier("modifier_sven_great_cleave_custom_speed") then
    bonus = bonus*self.speed_bonus
end
return bonus
end


function modifier_sven_great_cleave_custom:AttackEvent_inc( params )
if not IsServer() then return end
if self.parent:PassivesDisabled() then return end

if params.attacker:IsUnit() and self.parent == params.target then

    if self.parent:HasTalent("modifier_sven_cleave_5") and not self.parent:HasModifier("modifier_sven_great_cleave_custom_parry_cd") then
        self.parent:AddNewModifier(self.parent, self.ability, "modifier_sven_great_cleave_custom_parry_cd", {})
        self.parent:AddNewModifier(self.parent, self.ability, "modifier_sven_great_cleave_custom_parry", {duration = self.parry_duration})
    end
end

end


function modifier_sven_great_cleave_custom:AttackEvent_out( params )
if not IsServer() then return end
if self.parent:PassivesDisabled() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

local target = params.target

local cleaveDamage = ( params.damage * self.great_cleave_damage ) / 100

target:EmitSound("Hero_Sven.GreatCleave")

if not self.parent:HasModifier("modifier_no_cleave") then 
    DoCleaveAttack( self.parent, target, self.ability, cleaveDamage, self.great_cleave_start, self.great_cleave_end, self.great_cleave_distance, "particles/units/heroes/hero_sven/sven_spell_great_cleave.vpcf" )
end

if self.parent:HasTalent("modifier_sven_cleave_4") then
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_sven_great_cleave_custom_speed_cd", {duration = self.speed_cd})
end

if target:IsRealHero() then
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_sven_great_cleave_custom_damage_perma", {})
end

if params.no_attack_cooldown then return end

local parry_mod = self.parent:FindModifierByName("modifier_sven_great_cleave_custom_parry_cd")
if parry_mod then
    parry_mod:ReduceCd()
end

local mod = self.parent:FindModifierByName("modifier_sven_great_cleave_custom_speed")
if mod then
    mod:DecrementStackCount()

    for i = 1,2 do
        local particle = ParticleManager:CreateParticle( "particles/sven/cleave_speed_attack_range.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
        ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
        ParticleManager:DestroyParticle(particle, false)
        ParticleManager:ReleaseParticleIndex( particle )
    end

    local dir =  (target:GetOrigin() - self.parent:GetOrigin() ):Normalized()
    local particle = ParticleManager:CreateParticle( "particles/sven/cleave_speed_attack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
    ParticleManager:SetParticleControl( particle, 0, self.parent:GetAbsOrigin() )
    ParticleManager:SetParticleControl( particle, 1, self.parent:GetAbsOrigin() )
    ParticleManager:SetParticleControlForward( particle, 1, dir)
    ParticleManager:SetParticleControl( particle, 2, Vector(1,1,1) )
    ParticleManager:SetParticleControlForward( particle, 5, dir )
    ParticleManager:ReleaseParticleIndex(particle)

    if mod:GetStackCount() <= 0 then
        mod:Destroy()
    end
end

if self.parent:HasTalent("modifier_sven_cleave_1") then
    target:AddNewModifier(self.parent, self.ability, "modifier_sven_great_cleave_custom_slow_count", {duration = self.slow_count})
end

if self.parent:HasTalent("modifier_sven_cleave_6") and target:GetHealthPercent() <= self.vision_health and target:IsHero() and not target:HasModifier("modifier_sven_great_cleave_custom_break_cd") then
    target:AddNewModifier(self.parent, self.ability, "modifier_sven_great_cleave_custom_break_cd", {duration = self.vision_cd})
    target:AddNewModifier(self.parent, self.ability, "modifier_sven_great_cleave_custom_break", { duration = self.vision_break*(1 - target:GetStatusResistance())})
end


if self.parent:HasTalent("modifier_sven_cleave_7") then

    local ability = self.parent:FindAbilityByName("sven_great_cleave_custom_legendary")
    if ability and ability:IsTrained() and RollPseudoRandomPercentage(self.legendary_chance,5251,self.parent) then
        local part = "particles/sven/cleave_refresh.vpcf"
        if self.parent:HasModifier("modifier_sven_gods_strength_custom") then 
            part = "particles/sven/cleave_refresh_red.vpcf"
        end
        ability:AddCharge(1, part, "Sven.Cleave_refresh")
    end
end

end


function modifier_sven_great_cleave_custom:GetAuraRadius()
return self.vision_radius
end

function modifier_sven_great_cleave_custom:GetAuraSearchTeam()
return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_sven_great_cleave_custom:GetAuraSearchType() 
return DOTA_UNIT_TARGET_HERO
end

function modifier_sven_great_cleave_custom:GetModifierAura()
return "modifier_sven_great_cleave_custom_vision"
end

function modifier_sven_great_cleave_custom:IsAura()
return self.parent:HasTalent("modifier_sven_cleave_6")
end

function modifier_sven_great_cleave_custom:GetAuraSearchFlags()
return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO
end

function modifier_sven_great_cleave_custom:GetAuraEntityReject(hEntity)
return hEntity:GetHealthPercent() > self.vision_health
end



modifier_sven_great_cleave_custom_vision = class({})
function modifier_sven_great_cleave_custom_vision:IsHidden() return true end
function modifier_sven_great_cleave_custom_vision:IsPurgable() return false end
function modifier_sven_great_cleave_custom_vision:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if not IsServer() then return end

self:StartIntervalThink(0.2)
self:OnIntervalThink()
end

function modifier_sven_great_cleave_custom_vision:OnIntervalThink()
if not IsServer() then return end
AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), 10, 0.3, false)
self.caster:AddNewModifier(self.caster, self.ability, "modifier_sven_great_cleave_custom_vision_move", {duration = 1})
end



modifier_sven_great_cleave_custom_slow_count = class({})
function modifier_sven_great_cleave_custom_slow_count:IsHidden() return true end
function modifier_sven_great_cleave_custom_slow_count:IsPurgable() return false end
function modifier_sven_great_cleave_custom_slow_count:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.max = self.caster:GetTalentValue("modifier_sven_cleave_1", "max")
self.duration = self.caster:GetTalentValue("modifier_sven_cleave_1", "duration")

if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_sven_great_cleave_custom_slow_count:OnRefresh()
if not IsServer() then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max then
    self.parent:AddNewModifier(self.caster, self:GetAbility(), "modifier_sven_great_cleave_custom_slow", {duration = (1 - self.parent:GetStatusResistance())*self.duration})
    self:Destroy()
end

end


modifier_sven_great_cleave_custom_slow = class({}) 
function modifier_sven_great_cleave_custom_slow:IsHidden() return false end
function modifier_sven_great_cleave_custom_slow:IsPurgable() return true end
function modifier_sven_great_cleave_custom_slow:GetTexture() return "buffs/cleave_slow" end
function modifier_sven_great_cleave_custom_slow:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT 
}
end

function modifier_sven_great_cleave_custom_slow:OnCreated()
self.caster = self:GetCaster()

self.slow = self.caster:GetTalentValue("modifier_sven_cleave_1", "slow")
self.attack = self.caster:GetTalentValue("modifier_sven_cleave_1", "attack")
if not IsServer() then return end
self:GetParent():EmitSound("DOTA_Item.Maim")
end

function modifier_sven_great_cleave_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_sven_great_cleave_custom_slow:GetModifierAttackSpeedBonus_Constant()
return self.attack
end

function modifier_sven_great_cleave_custom_slow:GetEffectName()
return "particles/items2_fx/sange_maim.vpcf"
end

function modifier_sven_great_cleave_custom_slow:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end



modifier_sven_great_cleave_custom_speed = class({})
function modifier_sven_great_cleave_custom_speed:IsHidden() return false end
function modifier_sven_great_cleave_custom_speed:IsPurgable() return false end
function modifier_sven_great_cleave_custom_speed:GetTexture() return "buffs/cleave_speed" end
function modifier_sven_great_cleave_custom_speed:OnCreated(table)

self.parent = self:GetParent()
self.max =  self.parent:GetTalentValue("modifier_sven_cleave_4", "attacks")

if not IsServer() then return end
self.parent:EmitSound("Sven.Cleave_speed")
self.parent:GenericParticle("particles/sven/cleave_speed.vpcf")
self.particle_peffect = self.parent:GenericParticle("particles/sven/cleave_speed_ready.vpcf", self, true)

self:SetStackCount(1)
self:StartIntervalThink(1)
end


function modifier_sven_great_cleave_custom_speed:OnIntervalThink()
if not IsServer() then return end
if self.parent:HasModifier("modifier_sven_great_cleave_custom_speed_cd") then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()
end


function modifier_sven_great_cleave_custom_speed:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
}
end

function modifier_sven_great_cleave_custom_speed:GetModifierAttackSpeedBonus_Constant()
return self.parent:GetTalentValue("modifier_sven_cleave_4", "speed")
end




modifier_sven_great_cleave_custom_legendary_slow = class({})
function modifier_sven_great_cleave_custom_legendary_slow:IsHidden() return true end
function modifier_sven_great_cleave_custom_legendary_slow:IsPurgable() return true end
function modifier_sven_great_cleave_custom_legendary_slow:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_sven_great_cleave_custom_legendary_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_sven_great_cleave_custom_legendary_slow:GetEffectName()
return "particles/items2_fx/sange_maim.vpcf"
end

function modifier_sven_great_cleave_custom_legendary_slow:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_sven_great_cleave_custom_legendary_slow:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_sven_cleave_7", "slow")
end 




modifier_sven_great_cleave_custom_damage_perma = class({})
function modifier_sven_great_cleave_custom_damage_perma:IsHidden() return not self:GetParent():HasTalent("modifier_sven_cleave_3") end
function modifier_sven_great_cleave_custom_damage_perma:IsPurgable() return false end
function modifier_sven_great_cleave_custom_damage_perma:RemoveOnDeath() return false end
function modifier_sven_great_cleave_custom_damage_perma:GetTexture() return "buffs/cleave_stack" end
function modifier_sven_great_cleave_custom_damage_perma:OnCreated()

self.parent = self:GetParent()

self.max = self.parent:GetTalentValue("modifier_sven_cleave_3", "max", true)

if not IsServer() then return end 
self:StartIntervalThink(0.5)
self:SetStackCount(1)
end 

function modifier_sven_great_cleave_custom_damage_perma:OnRefresh()
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 
self:IncrementStackCount()
end 

function modifier_sven_great_cleave_custom_damage_perma:OnIntervalThink()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_sven_cleave_3") then return end 
if self:GetStackCount() < self.max then return end 

self.parent:GenericParticle("particles/lc_odd_proc_.vpcf")
self.parent:EmitSound("BS.Thirst_legendary_active")
self:StartIntervalThink(-1)
end 


function modifier_sven_great_cleave_custom_damage_perma:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
}
end

function modifier_sven_great_cleave_custom_damage_perma:GetModifierPreAttack_BonusDamage()
if not self.parent:HasTalent("modifier_sven_cleave_3") then return end
return self:GetStackCount()*self.parent:GetTalentValue("modifier_sven_cleave_3", "damage")/self.max
end






modifier_sven_great_cleave_custom_parry = class({})
function modifier_sven_great_cleave_custom_parry:IsHidden() return false end
function modifier_sven_great_cleave_custom_parry:IsPurgable() return false end
function modifier_sven_great_cleave_custom_parry:GetTexture() return "buffs/cleave_parry" end
function modifier_sven_great_cleave_custom_parry:OnCreated(table)

self.parent = self:GetParent()
self.heal = self.parent:GetTalentValue("modifier_sven_cleave_5", "heal")/self:GetRemainingTime()
self.damage_reduce = self.parent:GetTalentValue("modifier_sven_cleave_5", "damage_reduce")

if not IsServer() then return end
self.buff_particles = {}

self:GetParent():EmitSound("Sven.Cleave_parry")

self.buff_particles[1] = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.buff_particles[1], 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), false) 
self:AddParticle(self.buff_particles[1], false, false, -1, true, false)
ParticleManager:SetParticleControl( self.buff_particles[1], 3, Vector( 255, 255, 255 ) )

self.buff_particles[2] = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_egg.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.buff_particles[2], 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), false) 
self:AddParticle(self.buff_particles[2], false, false, -1, true, false)

self.buff_particles[3] = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_streaks.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.buff_particles[3], 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), false) 
self:AddParticle(self.buff_particles[3], false, false, -1, true, false)
end


function modifier_sven_great_cleave_custom_parry:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
}
end


function modifier_sven_great_cleave_custom_parry:GetModifierHealthRegenPercentage()
return self.heal
end

function modifier_sven_great_cleave_custom_parry:GetModifierIncomingDamage_Percentage(params)
if not IsServer() then return end

self.parent:EmitSound("Juggernaut.Parry")
local particle = ParticleManager:CreateParticle( "particles/jugg_parry.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_attack1", self.parent:GetAbsOrigin(), true )
ParticleManager:SetParticleControl( particle, 1, self.parent:GetAbsOrigin() )
ParticleManager:ReleaseParticleIndex(particle)

return self.damage_reduce
end



modifier_sven_great_cleave_custom_parry_cd = class({})
function modifier_sven_great_cleave_custom_parry_cd:IsHidden() return false end
function modifier_sven_great_cleave_custom_parry_cd:IsPurgable() return false end
function modifier_sven_great_cleave_custom_parry_cd:GetTexture() return "buffs/cleave_parry" end
function modifier_sven_great_cleave_custom_parry_cd:IsDebuff() return true end
function modifier_sven_great_cleave_custom_parry_cd:OnCreated()
if not IsServer() then return end
self.RemoveForDuel = true
self:SetStackCount(self:GetParent():GetTalentValue("modifier_sven_cleave_5", "cd"))
self:StartIntervalThink(1)
end

function modifier_sven_great_cleave_custom_parry_cd:OnIntervalThink()
if not IsServer() then return end
self:ReduceCd()
end

function modifier_sven_great_cleave_custom_parry_cd:ReduceCd()
if not IsServer() then return end
self:DecrementStackCount()

if self:GetStackCount() <= 0 then
    self:Destroy()
    return
end

end



modifier_sven_great_cleave_custom_vision_move = class({})
function modifier_sven_great_cleave_custom_vision_move:IsHidden() return false end
function modifier_sven_great_cleave_custom_vision_move:IsPurgable() return false end
function modifier_sven_great_cleave_custom_vision_move:GetTexture() return "buffs/cleave_healing" end
function modifier_sven_great_cleave_custom_vision_move:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
}
end

function modifier_sven_great_cleave_custom_vision_move:OnCreated()
self.speed = self:GetCaster():GetTalentValue("modifier_sven_cleave_6", "move")
end



function modifier_sven_great_cleave_custom_vision_move:GetModifierMoveSpeedBonus_Constant()
return self.speed
end

function modifier_sven_great_cleave_custom_vision_move:GetEffectName()
return "particles/units/heroes/hero_axe/axe_cullingblade_sprint.vpcf"
end

function modifier_sven_great_cleave_custom_vision_move:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end





modifier_sven_great_cleave_custom_speed_cd = class({})
function modifier_sven_great_cleave_custom_speed_cd:IsHidden() return true end
function modifier_sven_great_cleave_custom_speed_cd:IsPurgable() return false end
function modifier_sven_great_cleave_custom_speed_cd:RemoveOnDeath() return false end
function modifier_sven_great_cleave_custom_speed_cd:GetTexture() return "buffs/cleave_speed" end
function modifier_sven_great_cleave_custom_speed_cd:IsDebuff() return true end
function modifier_sven_great_cleave_custom_speed_cd:OnCreated()
self.RemoveForDuel = true
end


modifier_sven_great_cleave_custom_break_cd = class({})
function modifier_sven_great_cleave_custom_break_cd:IsHidden() return true end
function modifier_sven_great_cleave_custom_break_cd:IsPurgable() return false end
function modifier_sven_great_cleave_custom_break_cd:RemoveOnDeath() return false end




modifier_sven_great_cleave_custom_break = class({})
function modifier_sven_great_cleave_custom_break:IsHidden() return true end
function modifier_sven_great_cleave_custom_break:IsPurgable() return false end
function modifier_sven_great_cleave_custom_break:CheckState() return {[MODIFIER_STATE_PASSIVES_DISABLED] = true} end
function modifier_sven_great_cleave_custom_break:GetEffectName() return "particles/items3_fx/silver_edge.vpcf" end


function modifier_sven_great_cleave_custom_break:OnCreated(table)
self.parent = self:GetParent()
if not IsServer() then return end
self.parent:EmitSound("DOTA_Item.SilverEdge.Target")
self.parent:GenericParticle("particles/generic_gameplay/generic_break.vpcf", self, true)
end
