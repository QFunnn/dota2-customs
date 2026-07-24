--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skeleton_king_reincarnation_custom", "abilities/wraith_king/skeleton_king_reincarnation", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeleton_king_reincarnation_custom_slow", "abilities/wraith_king/skeleton_king_reincarnation", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeleton_king_reincarnation_custom_aura_damage", "abilities/wraith_king/skeleton_king_reincarnation", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeleton_king_reincarnation_custom_legendary", "abilities/wraith_king/skeleton_king_reincarnation", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeleton_king_reincarnation_custom_legendary_target", "abilities/wraith_king/skeleton_king_reincarnation", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeleton_king_reincarnation_custom_aura_str", "abilities/wraith_king/skeleton_king_reincarnation", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeleton_king_reincarnation_custom_perma", "abilities/wraith_king/skeleton_king_reincarnation", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeleton_king_reincarnation_custom_scepter", "abilities/wraith_king/skeleton_king_reincarnation", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeleton_king_reincarnation_custom_shield_cd", "abilities/wraith_king/skeleton_king_reincarnation", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeleton_king_reincarnation_custom_magic", "abilities/wraith_king/skeleton_king_reincarnation", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeleton_king_reincarnation_custom_move", "abilities/wraith_king/skeleton_king_reincarnation", LUA_MODIFIER_MOTION_NONE)

skeleton_king_reincarnation_custom = class({})
skeleton_king_reincarnation_custom.talents = {}

function skeleton_king_reincarnation_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/sand_king/sand_pull.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_skeletonking/wraith_king_reincarnate.vpcf", context )
PrecacheResource( "particle","particles/wraith_king_custom/wraith_king_tombstone_default.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_skeletonking/wraith_king_reincarnate_slow_debuff.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_muerta/muerta_parting_shot_tether.vpcf", context )
PrecacheResource( "particle","particles/wk_burn.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_wraithking_ghosts.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_muerta/muerta_ultimate_form_ethereal.vpcf", context )
PrecacheResource( "particle","particles/muerta/muerta_calling_caster_end.vpcf", context )
PrecacheResource( "particle","particles/wraith_king/ult_legendary_damage.vpcf", context )
PrecacheResource( "particle","particles/troll_warlord/rage_unslow.vpcf", context )
PrecacheResource( "particle","particles/muerta/dead_refresh.vpcf", context )
PrecacheResource( "particle","particles/muerta/muerta_attack_slow.vpcf", context )
PrecacheResource( "particle","particles/wraith_king/reinc_shield.vpcf", context )
PrecacheResource( "particle","particles/wraith_king/reinc_shield_base.vpcf", context )
PrecacheResource( "particle","particles/wraith_king/reinc_magic.vpcf", context )

end

function skeleton_king_reincarnation_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_r1 = 0,
    r1_damage = 0,
    r1_base = 0,
    r1_interval = caster:GetTalentValue("modifier_skeleton_reincarnation_1", "interval", true),
    r1_damage_type = caster:GetTalentValue("modifier_skeleton_reincarnation_1", "damage_type", true),
    r1_creeps = caster:GetTalentValue("modifier_skeleton_reincarnation_1", "creeps", true),
    r1_radius = caster:GetTalentValue("modifier_skeleton_reincarnation_1", "radius", true),
    
    has_r2 = 0,
    r2_shield = 0,
    r2_talent_cd = caster:GetTalentValue("modifier_skeleton_reincarnation_2", "talent_cd", true),
    r2_bonus = caster:GetTalentValue("modifier_skeleton_reincarnation_2", "bonus", true)/100,
    
    has_r3 = 0,
    r3_str = 0,
    r3_magic = 0,
    r3_duration = caster:GetTalentValue("modifier_skeleton_reincarnation_3", "duration", true),
    r3_stun = caster:GetTalentValue("modifier_skeleton_reincarnation_3", "stun", true),
    r3_max = caster:GetTalentValue("modifier_skeleton_reincarnation_3", "max", true),
    
    has_r4 = 0,
    r4_cd = caster:GetTalentValue("modifier_skeleton_reincarnation_4", "cd", true),
    r4_cdr = caster:GetTalentValue("modifier_skeleton_reincarnation_4", "cdr", true),
    r4_max = caster:GetTalentValue("modifier_skeleton_reincarnation_4", "max", true),
    
    has_r7 = 0,
    r7_cd_inc = caster:GetTalentValue("modifier_skeleton_reincarnation_7", "cd_inc", true)/100,
    
    has_h3 = 0,
    h3_status = 0,
    h3_move = 0,
    h3_bonus = caster:GetTalentValue("modifier_skeleton_hero_3", "bonus", true),
    
    has_h6 = 0,
    h6_duration = caster:GetTalentValue("modifier_skeleton_hero_6", "duration", true),
    h6_distance = caster:GetTalentValue("modifier_skeleton_hero_6", "distance", true),
    h6_delay = caster:GetTalentValue("modifier_skeleton_hero_6", "delay", true),
    h6_fear = caster:GetTalentValue("modifier_skeleton_hero_6", "fear", true),
    h6_move = caster:GetTalentValue("modifier_skeleton_hero_6", "move", true),
    h6_move_duration = caster:GetTalentValue("modifier_skeleton_hero_6", "move_duration", true),
  }
end

if caster:HasTalent("modifier_skeleton_reincarnation_1") then
  self.talents.has_r1 = 1
  self.talents.r1_damage = caster:GetTalentValue("modifier_skeleton_reincarnation_1", "damage")/100
  self.talents.r1_base = caster:GetTalentValue("modifier_skeleton_reincarnation_1", "base")
end

if caster:HasTalent("modifier_skeleton_reincarnation_2") then
  self.talents.has_r2 = 1
  self.talents.r2_shield = caster:GetTalentValue("modifier_skeleton_reincarnation_2", "shield")/100
end

if caster:HasTalent("modifier_skeleton_reincarnation_3") then
  self.talents.has_r3 = 1
  self.talents.r3_str = caster:GetTalentValue("modifier_skeleton_reincarnation_3", "str")
  self.talents.r3_magic = caster:GetTalentValue("modifier_skeleton_reincarnation_3", "magic")
end

if caster:HasTalent("modifier_skeleton_reincarnation_4") then
  self.talents.has_r4 = 1
end

if caster:HasTalent("modifier_skeleton_reincarnation_7") then
  self.talents.has_r7 = 1
end

if caster:HasTalent("modifier_skeleton_hero_3") then
  self.talents.has_h3 = 1
  self.talents.h3_status = caster:GetTalentValue("modifier_skeleton_hero_3", "status")
  self.talents.h3_move = caster:GetTalentValue("modifier_skeleton_hero_3", "move")
end

if caster:HasTalent("modifier_skeleton_hero_6") then
  self.talents.has_h6 = 1
end

end

function skeleton_king_reincarnation_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "skeleton_king_reincarnation", self)
end


function skeleton_king_reincarnation_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_skeleton_king_reincarnation_custom"
end

function skeleton_king_reincarnation_custom:GetCooldown(level)
return self.BaseClass.GetCooldown( self, level ) + (self.caster:HasShard() and self.shard_cd or 0)
end

function skeleton_king_reincarnation_custom:GetBehavior()
if self.caster:HasScepter() then
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
end
return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function skeleton_king_reincarnation_custom:GetManaCost(level)
return self.BaseClass.GetManaCost(self, level)
end

function skeleton_king_reincarnation_custom:GetCastRange(vLocation, hTarget)
return (self.slow_radius and self.slow_radius or 0) - self.caster:GetCastRangeBonus()
end

function skeleton_king_reincarnation_custom:OnSpellStart()
self.caster:Purge(false, true, false, true, true)
self:RefundManaCost()
self.caster:AddNewModifier(self.caster, self, "modifier_skeleton_king_reincarnation_custom_scepter", {duration = 6})
self.caster:Kill(nil, self.caster)
end


function skeleton_king_reincarnation_custom:ReincarnationStart( params, modifier )
local reincarnate = params.reincarnate

if not reincarnate then
    modifier.reincarnation_death = false   
    return
end

modifier.reincarnation_death = true
self.caster.reincarnate_res = true

local attacker = params.attacker
if IsValid(attacker) and players[attacker:GetId()] then
    self.caster:AddNewModifier(self.caster, self, "modifier_skeleton_king_reincarnation_custom_perma", {})
    if self.caster:GetQuest() == "Wraith.Quest_8" then
        self.caster:UpdateQuest(1)
    end
end

if self.talents.has_r4 == 1 then
    local cd = self.talents.r4_cd
    self.caster:CdItems(cd)
    for i = 0, 20 do
        local current_ability = self.caster:GetAbilityByIndex(i)
        if current_ability then
            self.caster:CdAbility(current_ability, cd)
        else
            break
        end
    end
end

self.caster:RemoveModifierByName("modifier_skeleton_king_reincarnation_custom_shield_cd")
self.caster:RemoveModifierByName("modifier_skeleton_king_reincarnation_custom_scepter")

self:UseResources(true, false, false, true)
local reincarnation_time = self.reincarnate_time
local slow_duration = self.slow_duration + (self.caster:HasShard() and self.shard_duration or 0)

if self.talents.has_h6 == 1 then 
    reincarnation_time =  reincarnation_time + self.talents.h6_delay
    local effect_cast = ParticleManager:CreateParticle( "particles/sand_king/sand_pull.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self.caster:GetAbsOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.slow_radius, self.slow_radius, self.slow_radius ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

for _, target in pairs(self.caster:FindTargets(self.slow_radius)) do
    target:AddNewModifier(self.caster, self.caster:BkbAbility(self, self.caster:HasShard()), "modifier_skeleton_king_reincarnation_custom_slow", {duration = self.slow_duration})

    if self.talents.has_h6 == 1 then 
        local dir = (self.caster:GetAbsOrigin() -  target:GetAbsOrigin()):Normalized()
        local point = self.caster:GetAbsOrigin() - dir*100

        local distance = (point - target:GetAbsOrigin()):Length2D()

        distance = math.min(self.talents.h6_distance,  math.max(100, distance))
        point = target:GetAbsOrigin() + dir*distance

        target:AddNewModifier( self.caster, self.caster:BkbAbility(self, true),  "modifier_generic_arc",  
        {
          target_x = point.x,
          target_y = point.y,
          distance = distance,
          duration = self.talents.h6_duration,
          height = 0,
          fix_end = false,
          isStun = false,
          activity = ACT_DOTA_FLAIL,
        })
    end
end

local particle_name = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_skeletonking/wraith_king_reincarnate.vpcf", self)
local tomb_effect = wearables_system:GetParticleReplacementAbility(self.caster, "particles/wraith_king_custom/wraith_king_tombstone_default.vpcf", self)
local sound_reinc = wearables_system:GetSoundReplacement(self.caster, "Hero_SkeletonKing.Reincarnate", self)

local particle_tombstone = ParticleManager:CreateParticle(tomb_effect, PATTACH_CUSTOMORIGIN, self.caster)
ParticleManager:SetParticleAlwaysSimulate(particle_tombstone)
ParticleManager:SetParticleControl(particle_tombstone, 0, self.caster:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_tombstone, 2, Vector(reincarnation_time, 0, 0))
ParticleManager:ReleaseParticleIndex(particle_tombstone)

local particle = ParticleManager:CreateParticle(particle_name, PATTACH_CUSTOMORIGIN, self.caster)
ParticleManager:SetParticleAlwaysSimulate(particle)
ParticleManager:SetParticleControl(particle, 0, self.caster:GetAbsOrigin())
ParticleManager:SetParticleControl(particle, 1, Vector(reincarnation_time, 0, 0))
ParticleManager:SetParticleControl(particle, 11, Vector(200, 0, 0))
ParticleManager:ReleaseParticleIndex(particle)

self.caster:EmitSound(sound_reinc)
AddFOWViewer(self.caster:GetTeamNumber(), self.caster:GetAbsOrigin(), 1800, reincarnation_time, true)
end



modifier_skeleton_king_reincarnation_custom = class(mod_hidden)
function modifier_skeleton_king_reincarnation_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent:AddDeathEvent(self)
self.parent:AddRespawnEvent(self)

self.parent.reincarnate_ability = self.ability

self.legendary_ability = self.parent:FindAbilityByName("skeleton_king_reincarnation_custom_legendary")
if self.legendary_ability then
    self.legendary_ability:UpdateTalents()
end

self.ability.reincarnate_time = self.ability:GetSpecialValueFor("reincarnate_time")
self.ability.slow_radius = self.ability:GetSpecialValueFor("slow_radius")
self.ability.movespeed = self.ability:GetSpecialValueFor("movespeed")
self.ability.attackslow = self.ability:GetSpecialValueFor("attackslow")
self.ability.slow_duration = self.ability:GetSpecialValueFor("slow_duration")
self.ability.shard_duration = self.ability:GetSpecialValueFor("shard_duration")
self.ability.shard_cd = self.ability:GetSpecialValueFor("shard_cd")

if not IsServer() then return end
self.str_mods = {}
self.count = 0

self.parent.reincarnate_res = false
self.interval = 0.5
self:StartIntervalThink(self.interval)
end

function modifier_skeleton_king_reincarnation_custom:OnIntervalThink()
if not IsServer() then return end

if not self.parent:HasModifier("modifier_skeleton_king_reincarnation_custom_perma") then
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_skeleton_king_reincarnation_custom_perma", {})
end

local is_cd = self.ability:GetCooldownTimeRemaining() > 0 and 1 or 0
if is_cd ~= self:GetStackCount() then
    self:SetStackCount(is_cd)
end

if is_cd == 1 and self.ability.talents.has_r7 == 1 and self.legendary_ability and self.legendary_ability:GetCooldownTimeRemaining() > 0 then
    self.parent:CdAbility(self.legendary_ability, self.interval*self.ability.talents.r7_cd_inc)
end

if self.ability.talents.has_r2 == 1 then
    local max_shield = self.ability.talents.r2_shield*self.parent:GetMaxHealth()
    if is_cd == 1 then
        max_shield = max_shield*(1 + self.ability.talents.r2_bonus)
    end

    if self.parent:IsAlive() and not IsValid(self.ability.shield_mod) and not self.parent:HasModifier("modifier_skeleton_king_reincarnation_custom_shield_cd") then
        self.ability.shield_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_shield",
        {
          max_shield = max_shield,
          start_full = 1,
          shield_talent = "modifier_skeleton_reincarnation_2",
          refresh_timer = self.ability.talents.r2_talent_cd/2,
        })

        if self.ability.shield_mod then
          self.parent:EmitSound("WK.Skelet_shield")

          self.particle = ParticleManager:CreateParticle(wearables_system:GetParticleReplacementAbility(self.parent, "particles/wraith_king/reinc_shield_base.vpcf", self.ability), PATTACH_CUSTOMORIGIN_FOLLOW, self.parent )
          ParticleManager:SetParticleControlEnt( self.particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
          self.ability.shield_mod:AddParticle(self.particle,false, false, -1, false, false)

          self.ability.shield_mod:SetEndFunction(function()
            self.parent:AddNewModifier(self.parent, self.ability, "modifier_skeleton_king_reincarnation_custom_shield_cd", {duration = self.ability.talents.r2_talent_cd})
          end)
        end
    end

    if IsValid(self.ability.shield_mod) and self.ability.shield_mod.max_shield ~= max_shield then
        self.ability.shield_mod:AddShield(0, max_shield)
    end
end

if self.ability.talents.has_r3 == 0 then return end
if not self.parent:IsAlive() and not self.parent:IsReincarnating() then return end

local has_mod = false
for mod,_ in pairs(self.str_mods) do
    if IsValid(mod) then
        has_mod = true
    else
        self.str_mods[mod] = nil
    end
end

if has_mod then
    self.count = self.count + self.interval
    if self.count >= 1 then
        self.count = 0
        self.parent:AddNewModifier(self.parent, self.ability, "modifier_skeleton_king_reincarnation_custom_aura_str", {duration = self.ability.talents.r3_duration, stack = 1})
    end
end

end

function modifier_skeleton_king_reincarnation_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_REINCARNATION,
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,                     
    MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
}
end

function modifier_skeleton_king_reincarnation_custom:GetModifierStatusResistanceStacking()
return self.ability.talents.h3_status*(self:GetStackCount() == 1 and self.ability.talents.h3_bonus or 1)
end

function modifier_skeleton_king_reincarnation_custom:GetModifierMoveSpeedBonus_Percentage()
return self.ability.talents.h3_move*(self:GetStackCount() == 1 and self.ability.talents.h3_bonus or 1)
end

function modifier_skeleton_king_reincarnation_custom:RespawnEvent(params)
if not IsServer() then return end
if params.unit ~= self.parent then return end

self.reincarnation_death = false
if self.parent.reincarnate_res == false then return end
self.parent.reincarnate_res = false
self:OnIntervalThink()

if self.ability.talents.has_h6 == 0 then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_skeleton_king_reincarnation_custom_move", {duration = self.ability.talents.h6_move_duration})

for _,target in pairs(self.parent:FindTargets(self.ability.talents.h6_distance)) do
    target:EmitSound("Generic.Fear")
    local mod = target:AddNewModifier(self.parent, self.parent:BkbAbility(self.ability, true), "modifier_nevermore_requiem_fear", {duration = (1 - target:GetStatusResistance())*self.ability.talents.h6_fear})
    if mod then
        target:GenericParticle("particles/wraith_king/scepter_skelet.vpcf", mod)
    end
end

end

function modifier_skeleton_king_reincarnation_custom:ReincarnateTime()
if not IsServer() then return end
if self.parent:IsRealHero() and (not self.parent:HasModifier("modifier_death") or self.parent:HasModifier("modifier_axe_culling_blade_custom_aegis")) and self.ability:IsFullyCastable() then
    return self.ability.reincarnate_time + (self.ability.talents.has_h6 == 1 and self.ability.talents.h6_delay or 0)
end
return nil
end

function modifier_skeleton_king_reincarnation_custom:GetActivityTranslationModifiers()
if self.reincarnation_death then return "reincarnate" end
return nil
end

function modifier_skeleton_king_reincarnation_custom:DeathEvent(params)
if not IsServer() then return end
local unit = params.unit
local reincarnate = params.reincarnate
if self.parent ~= unit then return end
if not self.ability:IsFullyCastable() then return end

self.ability:ReincarnationStart( params, self )
end

function modifier_skeleton_king_reincarnation_custom:GetAuraRadius() return self.ability.talents.r1_radius end
function modifier_skeleton_king_reincarnation_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_skeleton_king_reincarnation_custom:GetAuraSearchType()  return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_skeleton_king_reincarnation_custom:GetModifierAura() return "modifier_skeleton_king_reincarnation_custom_aura_damage" end
function modifier_skeleton_king_reincarnation_custom:IsAura() return self.ability.talents.has_r1 == 1 or self.ability.talents.has_r3 == 1 end


modifier_skeleton_king_reincarnation_custom_aura_damage = class(mod_hidden)
function modifier_skeleton_king_reincarnation_custom_aura_damage:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.interval = self.ability.talents.r1_interval

if self.ability.talents.has_r1 == 1 then
    self.parent:GenericParticle("particles/wk_burn.vpcf", self)
end

if self.ability.talents.has_r3 == 1 and self.parent:IsHero() then
    self.ability.tracker.str_mods[self] = true
end

self.count = 0
self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = self.ability.talents.r1_damage_type}
self:StartIntervalThink(self.interval)
end

function modifier_skeleton_king_reincarnation_custom_aura_damage:OnIntervalThink()
if not IsServer() then return end

if self.ability.talents.has_r3 == 1 then
    self.count = self.count + self.interval
    if self.count >= 1 then
        self.count = 0
        self.parent:AddNewModifier(self.caster, self.ability, "modifier_skeleton_king_reincarnation_custom_magic", {duration = self.ability.talents.r3_duration, stack = 1})
    end
end

if self.ability.talents.has_r1 == 0 then return end
local damage = (self.ability.talents.r1_base + self.caster:GetHealth()*self.ability.talents.r1_damage)*self.interval 
if self.parent:IsCreep() then 
    damage = damage/self.ability.talents.r1_creeps
end
self.damageTable.damage = damage
DoDamage(self.damageTable, "modifier_skeleton_reincarnation_1")
end



modifier_skeleton_king_reincarnation_custom_slow = class(mod_visible)
function modifier_skeleton_king_reincarnation_custom_slow:IsPurgable() return not self.caster:HasShard() end
function modifier_skeleton_king_reincarnation_custom_slow:GetTexture() return self.ability:GetAbilityTextureName() end
function modifier_skeleton_king_reincarnation_custom_slow:OnCreated()    
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self.caster.reincarnate_ability
if not self.ability then
    self:Destroy()
    return
end

self.move_slow = self.ability.movespeed
self.attack_slow = self.ability.attackslow

if not IsServer() then return end
self.parent:GenericParticle(wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_skeletonking/wraith_king_reincarnate_slow_debuff.vpcf", self), self)

if self.ability.talents.has_h6 == 0 then return end

self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_muerta/muerta_parting_shot_tether.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
ParticleManager:SetParticleControlEnt( self.particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetOrigin(), true )
ParticleManager:SetParticleControlEnt( self.particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
self:AddParticle(self.particle, false, false, -1, false, false)  
self:StartIntervalThink(self.ability.talents.h6_duration + 0.4)
end

function modifier_skeleton_king_reincarnation_custom_slow:OnIntervalThink()
if not IsServer() then return end
if not self.particle then return end
ParticleManager:DestroyParticle(self.particle, false)
ParticleManager:ReleaseParticleIndex(self.particle)
self.particle = nil
end

function modifier_skeleton_king_reincarnation_custom_slow:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_skeleton_king_reincarnation_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.move_slow
end

function modifier_skeleton_king_reincarnation_custom_slow:GetModifierAttackSpeedBonus_Constant()
return self.attack_slow
end






skeleton_king_reincarnation_custom_legendary = class({})
skeleton_king_reincarnation_custom_legendary.talents = {}

function skeleton_king_reincarnation_custom_legendary:CreateTalent()
self:SetHidden(false)
end

function skeleton_king_reincarnation_custom_legendary:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_r7 = 0,
    r7_heal = caster:GetTalentValue("modifier_skeleton_reincarnation_7", "heal", true)/100,
    r7_base = caster:GetTalentValue("modifier_skeleton_reincarnation_7", "base", true),
    r7_damage = caster:GetTalentValue("modifier_skeleton_reincarnation_7", "damage", true)/100,
    r7_talent_cd = caster:GetTalentValue("modifier_skeleton_reincarnation_7", "talent_cd", true),
    r7_cd_inc = caster:GetTalentValue("modifier_skeleton_reincarnation_7", "cd_inc", true),
    r7_duration = caster:GetTalentValue("modifier_skeleton_reincarnation_7", "duration", true),
    r7_radius = caster:GetTalentValue("modifier_skeleton_reincarnation_7", "radius", true),
    r7_slow = caster:GetTalentValue("modifier_skeleton_reincarnation_7", "slow", true),
    r7_move = caster:GetTalentValue("modifier_skeleton_reincarnation_7", "move", true),
    r7_damage_type = caster:GetTalentValue("modifier_skeleton_reincarnation_7", "damage_type", true),
  }
end

end

function skeleton_king_reincarnation_custom_legendary:Init()
self.caster = self:GetCaster()
end

function skeleton_king_reincarnation_custom_legendary:GetCooldown()
return (self.talents.r7_talent_cd and self.talents.r7_talent_cd or 0)
end

function skeleton_king_reincarnation_custom_legendary:OnSpellStart()
self.caster:AddNewModifier(self.caster, self, "modifier_skeleton_king_reincarnation_custom_legendary", {duration = self.talents.r7_duration})
end

modifier_skeleton_king_reincarnation_custom_legendary = class(mod_visible)
function modifier_skeleton_king_reincarnation_custom_legendary:GetStatusEffectName() return "particles/status_fx/status_effect_wraithking_ghosts.vpcf" end
function modifier_skeleton_king_reincarnation_custom_legendary:StatusEffectPriority() return MODIFIER_PRIORITY_SUPER_ULTRA  end
function modifier_skeleton_king_reincarnation_custom_legendary:GetEffectName() return "particles/units/heroes/hero_muerta/muerta_ultimate_form_ethereal.vpcf" end
function modifier_skeleton_king_reincarnation_custom_legendary:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MODEL_SCALE,
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
}
end

function modifier_skeleton_king_reincarnation_custom_legendary:GetModifierConstantHealthRegen()
return self.heal
end

function modifier_skeleton_king_reincarnation_custom_legendary:GetModifierMoveSpeedBonus_Percentage()
return self.move
end

function modifier_skeleton_king_reincarnation_custom_legendary:GetModifierModelScale()
return 30
end

function modifier_skeleton_king_reincarnation_custom_legendary:OnCreated(table)
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.base = self.ability.talents.r7_base
self.heal = (self.base + (self.parent:GetMaxHealth() - self.parent:GetHealth())*self.ability.talents.r7_heal)/self:GetRemainingTime()
self.move = self.ability.talents.r7_move
self.radius = self.ability.talents.r7_radius
self.damage = self.ability.talents.r7_damage
self.interval = 0.5

if not IsServer() then return end

self.radius_visual = ParticleManager:CreateParticle("particles/wraith_king/blast_radius.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.radius_visual, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.radius_visual, 1, Vector(self.radius, 0, 0))
self:AddParticle(self.radius_visual, false, false, -1, false, false)

self.RemoveForDuel = true
self.parent:EmitSound("WK.Ult_legendary_start")

self.damageTable = {attacker = self.parent, ability = self.ability, damage_type = self.ability.talents.r7_damage_type}

self:OnIntervalThink()
self:StartIntervalThink(self.interval - FrameTime())
end

function modifier_skeleton_king_reincarnation_custom_legendary:OnIntervalThink()
if not IsServer() then return end 

for _,unit in pairs(self.parent:FindTargets(self.radius)) do
    self.damageTable.damage = self.interval*self.heal*self.damage
    self.damageTable.victim = unit
    DoDamage(self.damageTable)
end

end 

function modifier_skeleton_king_reincarnation_custom_legendary:OnDestroy()
if not IsServer() then return end
self.parent:EmitSound("WK.Ult_end")
self.parent:GenericParticle("particles/muerta/muerta_calling_caster_end.vpcf")
end

function modifier_skeleton_king_reincarnation_custom_legendary:CheckState()
return
{
    [MODIFIER_STATE_DISARMED] = true,
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    [MODIFIER_STATE_UNSLOWABLE] = true,
}
end

function modifier_skeleton_king_reincarnation_custom_legendary:GetAuraDuration() return 0 end
function modifier_skeleton_king_reincarnation_custom_legendary:GetAuraRadius() return self.radius end
function modifier_skeleton_king_reincarnation_custom_legendary:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_skeleton_king_reincarnation_custom_legendary:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_skeleton_king_reincarnation_custom_legendary:GetModifierAura() return "modifier_skeleton_king_reincarnation_custom_legendary_target" end
function modifier_skeleton_king_reincarnation_custom_legendary:IsAura() return true end


modifier_skeleton_king_reincarnation_custom_legendary_target = class(mod_hidden)
function modifier_skeleton_king_reincarnation_custom_legendary_target:OnCreated()
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
local mod = self.caster:FindModifierByName("modifier_skeleton_king_reincarnation_custom_legendary")
if not mod then return end

local particle = ParticleManager:CreateParticle("particles/wraith_king/ult_legendary_damage.vpcf", PATTACH_CUSTOMORIGIN, self.caster)
ParticleManager:SetParticleControlEnt(particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControl(particle, 5, Vector(mod:GetRemainingTime(), 0, 0))
self:AddParticle(particle, false, false, -1, false, false)    
end

function modifier_skeleton_king_reincarnation_custom_legendary_target:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_skeleton_king_reincarnation_custom_legendary_target:GetModifierMoveSpeedBonus_Percentage()
return self.ability.talents.r7_slow
end


modifier_skeleton_king_reincarnation_custom_aura_str = class(mod_visible)
function modifier_skeleton_king_reincarnation_custom_aura_str:GetTexture() return "buffs/wraith_king/reincarnation_3" end
function modifier_skeleton_king_reincarnation_custom_aura_str:RemoveOnDeath() return false end
function modifier_skeleton_king_reincarnation_custom_aura_str:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.talents.r3_max
self:AddStack(table.stack)
end

function modifier_skeleton_king_reincarnation_custom_aura_str:OnRefresh(table)
if not IsServer() then return end
self:AddStack(table.stack)
end

function modifier_skeleton_king_reincarnation_custom_aura_str:AddStack(stack)
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end
self:SetStackCount(math.min(self.max, self:GetStackCount() + stack))
end

function modifier_skeleton_king_reincarnation_custom_aura_str:OnStackCountChanged(iStackCount)
if not IsServer() then return end
self.parent:CalculateStatBonus(true)
end

function modifier_skeleton_king_reincarnation_custom_aura_str:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
}
end

function modifier_skeleton_king_reincarnation_custom_aura_str:GetModifierBonusStats_Strength()
return self.ability.talents.r3_str*self:GetStackCount()
end


modifier_skeleton_king_reincarnation_custom_perma = class(mod_hidden)
function modifier_skeleton_king_reincarnation_custom_perma:IsHidden() return self.ability.talents.has_r4 == 0 or self:GetStackCount() == 0 or self:GetStackCount() >= self.max end
function modifier_skeleton_king_reincarnation_custom_perma:RemoveOnDeath() return false end
function modifier_skeleton_king_reincarnation_custom_perma:GetTexture() return "buffs/wraith_king/reincarnation_4" end
function modifier_skeleton_king_reincarnation_custom_perma:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.talents.r4_max
self.cdr = self.ability.talents.r4_cdr

if not IsServer() then return end
self:StartIntervalThink(1)
end

function modifier_skeleton_king_reincarnation_custom_perma:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end 

self:IncrementStackCount()
end

function modifier_skeleton_king_reincarnation_custom_perma:OnIntervalThink()
if not IsServer() then return end 
if self:GetStackCount() < self.max then return end
if self.ability.talents.has_r4 == 0 then return end

self.parent:GenericParticle("particles/lc_odd_proc_.vpcf")
self.parent:EmitSound("BS.Thirst_legendary_active")
self:StartIntervalThink(-1)
end 

function modifier_skeleton_king_reincarnation_custom_perma:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
}
end

function modifier_skeleton_king_reincarnation_custom_perma:GetModifierPercentageCooldown() 
if self.ability.talents.has_r4 == 0 then return end
return self:GetStackCount()*self.cdr
end


modifier_skeleton_king_reincarnation_custom_scepter = class(mod_hidden)
function modifier_skeleton_king_reincarnation_custom_scepter:OnCreated()
self.ability = self:GetAbility()
if not IsServer() then return end
self.RemoveForDuel = true
self.ability:EndCd()
end

function modifier_skeleton_king_reincarnation_custom_scepter:OnDestroy()
if not IsServer() then return end
self.ability:StartCd()
end


modifier_skeleton_king_reincarnation_custom_shield_cd = class(mod_cd)
function modifier_skeleton_king_reincarnation_custom_shield_cd:GetTexture() return "buffs/wraith_king/reincarnation_2" end
function modifier_skeleton_king_reincarnation_custom_shield_cd:OnDestroy()
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not self.ability.tracker then return end
self.ability.tracker:OnIntervalThink()
end


modifier_skeleton_king_reincarnation_custom_magic = class(mod_visible)
function modifier_skeleton_king_reincarnation_custom_magic:GetTexture() return "buffs/wraith_king/reincarnation_3" end
function modifier_skeleton_king_reincarnation_custom_magic:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max = self.ability.talents.r3_max
if not IsServer() then return end
self:AddStack(table.stack)
end

function modifier_skeleton_king_reincarnation_custom_magic:OnRefresh(table)
if not IsServer() then return end
self:AddStack(table.stack)
end

function modifier_skeleton_king_reincarnation_custom_magic:AddStack(stack)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:SetStackCount(math.min(self.max, self:GetStackCount() + stack))

if self:GetStackCount() >= self.max then
    self.parent:GenericParticle("particles/wraith_king/reinc_magic.vpcf", self)
end

end

function modifier_skeleton_king_reincarnation_custom_magic:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_skeleton_king_reincarnation_custom_magic:GetModifierMagicalResistanceBonus()
return self:GetStackCount()*self.ability.talents.r3_magic
end



modifier_skeleton_king_reincarnation_custom_move = class(mod_hidden)
function modifier_skeleton_king_reincarnation_custom_move:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.move = self.ability.talents.h6_move
end

function modifier_skeleton_king_reincarnation_custom_move:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE
}
end

function modifier_skeleton_king_reincarnation_custom_move:GetModifierMoveSpeed_Absolute()
return self.move
end