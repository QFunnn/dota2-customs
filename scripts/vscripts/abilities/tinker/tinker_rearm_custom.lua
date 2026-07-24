--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_tinker_rearm_custom_tracker", "abilities/tinker/tinker_rearm_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tinker_rearm_custom", "abilities/tinker/tinker_rearm_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tinker_rearm_custom_damage_cd", "abilities/tinker/tinker_rearm_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tinker_rearm_custom_damage_cd_creeps", "abilities/tinker/tinker_rearm_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tinker_rearm_custom_mana_bonus", "abilities/tinker/tinker_rearm_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tinker_rearm_custom_auto_cast", "abilities/tinker/tinker_rearm_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tinker_rearm_custom_invun_cd", "abilities/tinker/tinker_rearm_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tinker_rearm_custom_spell_damage", "abilities/tinker/tinker_rearm_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tinker_rearm_custom_quest", "abilities/tinker/tinker_rearm_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tinker_rearm_custom_invun", "abilities/tinker/tinker_rearm_custom", LUA_MODIFIER_MOTION_NONE )

tinker_rearm_custom = class({})
tinker_rearm_custom.talents = {}

function tinker_rearm_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_tinker/tinker_rearm.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_tinker/tinker_missile.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_tinker/tinker_missile_dud.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_tinker/tinker_missle_explosion.vpcf", context )
end

function tinker_rearm_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents = 
  {
    has_r1 = 0,
    r1_base = 0,
    r1_damage = 0,
    r1_talent_cd = caster:GetTalentValue("modifier_tinker_rearm_1", "talent_cd", true),
    r1_damage_type = caster:GetTalentValue("modifier_tinker_rearm_1", "damage_type", true),
    r1_radius = caster:GetTalentValue("modifier_tinker_rearm_1", "radius", true),
    
    has_r2 = 0,
    r2_cast = 0,
    r2_heal = 0,
    
    has_r3 = 0,
    r3_damage = 0,
    r3_health = 0,
    r3_duration = caster:GetTalentValue("modifier_tinker_rearm_3", "duration", true),
    
    has_r4 = 0,
    r4_mana = caster:GetTalentValue("modifier_tinker_rearm_4", "mana", true),
    r4_duration = caster:GetTalentValue("modifier_tinker_rearm_4", "duration", true),
    r4_cd_items = caster:GetTalentValue("modifier_tinker_rearm_4", "cd_items", true),
    r4_cdr = caster:GetTalentValue("modifier_tinker_rearm_4", "cdr", true),
    
    has_h1 = 0,
    h1_regen = 0,

    h4_cd_inc = caster:GetTalentValue("modifier_tinker_hero_4", "cd_inc", true)/100,
    h4_talent_cd = caster:GetTalentValue("modifier_tinker_hero_4", "talent_cd", true),

    has_h6 = 0,
    h6_damage_reduce = caster:GetTalentValue("modifier_tinker_hero_6", "damage_reduce", true),
    h6_duration = caster:GetTalentValue("modifier_tinker_hero_6", "duration", true),
    h6_talent_cd = caster:GetTalentValue("modifier_tinker_hero_6", "talent_cd", true),
  }
end

if caster:HasTalent("modifier_tinker_rearm_1") then
  self.talents.has_r1 = 1
  self.talents.r1_base = caster:GetTalentValue("modifier_tinker_rearm_1", "base")
  self.talents.r1_damage = caster:GetTalentValue("modifier_tinker_rearm_1", "damage")/100
  caster:AddDamageEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_tinker_rearm_2") then
  self.talents.has_r2 = 1
  self.talents.r2_cast = caster:GetTalentValue("modifier_tinker_rearm_2", "cast")/100
  self.talents.r2_heal = caster:GetTalentValue("modifier_tinker_rearm_2", "heal")/100
end

if caster:HasTalent("modifier_tinker_rearm_3") then
  self.talents.has_r3 = 1
  self.talents.r3_damage = caster:GetTalentValue("modifier_tinker_rearm_3", "damage")
  self.talents.r3_health = caster:GetTalentValue("modifier_tinker_rearm_3", "health")
end

if caster:HasTalent("modifier_tinker_rearm_4") then
  self.talents.has_r4 = 1
end

if caster:HasTalent("modifier_tinker_rearm_7") then
  self.talents.has_r7 = 1
end

if caster:HasTalent("modifier_tinker_hero_1") then
  self.talents.has_h1 = 1
  self.talents.h1_regen = caster:GetTalentValue("modifier_tinker_hero_1", "regen")/100
end

if caster:HasTalent("modifier_tinker_hero_6") then
  self.talents.has_h6 = 1
end

end


function tinker_rearm_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_tinker_rearm_custom_tracker"
end

function tinker_rearm_custom:GetAbilityTextureName()
if self.talents.has_h6 == 1 and not self.caster:HasModifier("modifier_tinker_rearm_custom_invun_cd") then
    return "rearm_bkb"
end
return "tinker_rearm"
end

function tinker_rearm_custom:GetChannelTime()
return self.channel_time*(1 + self.talents.r2_cast)
end

function tinker_rearm_custom:GetBehavior()
local bonus = 0
if self.talents.has_h6 == 1 and not self.caster:HasModifier("modifier_tinker_rearm_custom_invun_cd") then
  bonus = DOTA_ABILITY_BEHAVIOR_AUTOCAST
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_CHANNELLED + bonus
end

function tinker_rearm_custom:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel)
end

function tinker_rearm_custom:GetManaCost(level)
if not self.mana_cost then return end
return self.mana_cost*self.caster:GetMaxMana()
end

function tinker_rearm_custom:CheckToggle()
if self.caster:HasModifier("modifier_tinker_rearm_custom_invun_cd") then
    return false
end
return true
end

function tinker_rearm_custom:OnSpellStart()
local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_tinker/tinker_rearm.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
ParticleManager:SetParticleControlEnt(particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_attack2", self.caster:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(particle, 1, self.caster, PATTACH_POINT_FOLLOW, "attach_attack3", self.caster:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(particle)

self.caster:EmitSound("Hero_Tinker.Rearm")
local bkb = self.use_bkb and 1 or 0
self.use_bkb = nil

self.caster:AddNewModifier(self.caster, self, "modifier_tinker_rearm_custom", {duration = self:GetChannelTime(), bkb = bkb})
end

function tinker_rearm_custom:OnChannelFinish(interrupted)
self.caster:StopSound("Hero_Tinker.Rearm")

if interrupted then
    self.caster:RemoveModifierByName("modifier_tinker_rearm_custom")
    return
end

local count = 0
for i = 0, self.caster:GetAbilityCount() - 1 do
    local ability = self.caster:GetAbilityByIndex(i)
    if ability then
        if ability:GetCooldownTimeRemaining() > 0 then
            count = count + 1
        end

        if ability:GetName() == "tinker_warp_grenade_custom" and ability.rearm_cd then
            self.caster:CdAbility(ability, nil, ability.rearm_cd)
        else
            ability:EndCd(0)
            ability:RefreshCharges()
        end
    end
end

local mod = self.caster:FindModifierByName("modifier_tinker_laser_custom_stun_cd")
if mod then
    mod:SetDuration(mod:GetRemainingTime() + self.talents.h4_talent_cd*self.talents.h4_cd_inc, true)
end

local tp_scroll = self.caster:FindItemInInventory("item_tpscroll_custom")
if tp_scroll then
	tp_scroll:EndCd(0)
end

self.caster:RemoveModifierByName("modifier_tinker_innate_custom_shield")
self.caster:RemoveModifierByName("modifier_tinker_innate_custom_shield_cd")
if IsValid(self.caster.tinker_innate, self.caster.tinker_innate.tracker) then
    self.caster.tinker_innate.tracker:OnIntervalThink()
end

if self.talents.has_h1 == 1 then
    local mana = self.caster:GetMaxMana()*self.talents.h1_regen*count
    self.caster:GiveMana(mana)
    self.caster:SendNumber(OVERHEAD_ALERT_MANA_ADD, mana)
end

if self.talents.has_r2 == 1 then
    self.caster:GenericHeal(self.caster:GetIntellect(false)*count*self.ability.talents.r2_heal, self, false, "particles/items3_fx/octarine_core_lifesteal.vpcf", "modifier_tinker_rearm_2")
end

if self.talents.has_r4 == 1 then
    self.caster:CdItems(self.talents.r4_cd_items)
    self.caster:AddNewModifier(self.caster, self, "modifier_tinker_rearm_custom_mana_bonus", {duration = self.talents.r4_duration})
end

if self.talents.has_r3 == 1 and count > 0 then
    self.caster:AddNewModifier(self.caster, self, "modifier_tinker_rearm_custom_spell_damage", {duration = self.talents.r3_duration, stack = count})
end

if self.caster:HasModifier("modifier_tinker_rearm_custom_quest") and self.caster:GetQuest() == "Tinker.Quest_8" then
    self.caster:UpdateQuest(1)
end

self.caster:RemoveModifierByName("modifier_tinker_rearm_custom_damage_cd")
self.caster:RemoveModifierByName("modifier_tinker_rearm_custom_damage_cd_creeps")
end



modifier_tinker_rearm_custom = class(mod_hidden)
function modifier_tinker_rearm_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self.channel_time = self.ability:GetChannelTime()
self.anim = ACT_DOTA_TINKER_REARM2
self.anim_k = 1
if self.channel_time < 1.9 then
    self.anim = ACT_DOTA_TINKER_REARM3
end
if self.channel_time <= 1.2 then
    self.anim_k = 1.2/self.channel_time
end
self.parent:StartGestureWithPlaybackRate(self.anim, self.anim_k)

if table.bkb == 1 then 
    self.parent:GenericParticle("particles/tinker/scepter_proc.vpcf")
    self.mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_tinker_rearm_custom_invun", {effect = 2})
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_tinker_rearm_custom_invun_cd", {duration = self.ability.talents.h6_talent_cd})
elseif self.ability.talents.has_h6 == 1 then
    self.parent:GenericParticle("particles/items2_fx/vindicators_axe_armor.vpcf", self)
end

end

function modifier_tinker_rearm_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_tinker_rearm_custom:GetModifierIncomingDamage_Percentage()
if self.ability.talents.has_h6 == 0 then return end
return self.ability.talents.h6_damage_reduce
end

function modifier_tinker_rearm_custom:OnDestroy()
if not IsServer() then return end
self.parent:FadeGesture(self.anim)

if not IsValid(self.mod) then return end
self.mod:SetDuration(self.ability.talents.h6_duration, true)
end



modifier_tinker_rearm_custom_tracker = class(mod_hidden)
function modifier_tinker_rearm_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.ability.channel_time = self.ability:GetSpecialValueFor("AbilityChannelTime")
self.ability.mana_cost = self.ability:GetSpecialValueFor("mana_cost")/100

self.int_per_cdr = self.ability:GetSpecialValueFor("int_per_one_cdr")
self.max_cdr = self.ability:GetSpecialValueFor("max_cdr")
   
self.legendary_ability = self.parent:FindAbilityByName("tinker_heat_seeking_missile_custom")
if self.legendary_ability then
    self.legendary_ability:UpdateTalents()
end

end

function modifier_tinker_rearm_custom_tracker:OnRefresh(table)
self.int_per_cdr = self.ability:GetSpecialValueFor("int_per_one_cdr")
self.ability.channel_time = self.ability:GetSpecialValueFor("AbilityChannelTime")
end

function modifier_tinker_rearm_custom_tracker:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
}
end

function modifier_tinker_rearm_custom_tracker:GetModifierPercentageCooldown(params)
if not params.ability or not params.ability:IsItem() or NoCdItems[params.ability:GetName()] then return end
return math.min(self.parent:GetIntellect(false) / self.int_per_cdr, self.max_cdr) + (self.ability.talents.has_r4 == 1 and self.ability.talents.r4_cdr or 0)
end

function modifier_tinker_rearm_custom_tracker:DamageEvent_out(params)
if not IsServer() then return end
if self.ability.talents.has_r1 == 0 then return end
if not params.unit:IsUnit() then return end
if self.parent ~= params.attacker then return end
if not self.parent:IsAlive() then return end

local unit = params.unit

local mod_name = "modifier_tinker_rearm_custom_damage_cd_creeps"
if unit:IsHero() then
    mod_name = "modifier_tinker_rearm_custom_damage_cd"
end

if self.parent:HasModifier(mod_name) then return end
if not params.inflictor or params.inflictor:IsItem() then return end
if params.custom_flag == CUSTOM_FLAG_TINKER_REARM then return end

local damage = self.ability.talents.r1_base + self.ability.talents.r1_damage*self.parent:GetIntellect(false)
local damageTable = {attacker = self.parent, damage = damage, ability = self.ability, damage_type = self.ability.talents.r1_damage_type, custom_flag = CUSTOM_FLAG_TINKER_REARM}

local effect_cast = ParticleManager:CreateParticle( "particles/tinker/laser_proc_damage.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, unit )
ParticleManager:SetParticleControlEnt(effect_cast, 0, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetOrigin(),true)
ParticleManager:ReleaseParticleIndex(effect_cast)

for _,aoe_target in pairs(self.parent:FindTargets(self.ability.talents.r1_radius, unit:GetAbsOrigin())) do
    damageTable.victim = aoe_target
    local real_damage = DoDamage(damageTable, "modifier_tinker_rearm_1")
    aoe_target:SendNumber(4, real_damage)
end

unit:EmitSound("Tinker.Laser_damage_stack")
self.parent:AddNewModifier(self.parent, self.ability, mod_name, {duration = self.ability.talents.r1_talent_cd})
end



tinker_heat_seeking_missile_custom = class({})
tinker_heat_seeking_missile_custom.talents = {}

function tinker_heat_seeking_missile_custom:CreateTalent()
self:SetHidden(false)
self:SetLevel(1)
end

function tinker_heat_seeking_missile_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  { 
    has_r7 = 0,
    r7_range = caster:GetTalentValue("modifier_tinker_rearm_7", "range", true),
    r7_damage_inc = caster:GetTalentValue("modifier_tinker_rearm_7", "damage_inc", true)/100,
    r7_damage_base = caster:GetTalentValue("modifier_tinker_rearm_7", "damage_base", true),
    r7_talent_cd = caster:GetTalentValue("modifier_tinker_rearm_7", "talent_cd", true),
    r7_stack = caster:GetTalentValue("modifier_tinker_rearm_7", "stack", true),
    r7_stun = caster:GetTalentValue("modifier_tinker_rearm_7", "stun", true),
    r7_damage_type = caster:GetTalentValue("modifier_tinker_rearm_7", "damage_type", true),
    r7_damage = caster:GetTalentValue("modifier_tinker_rearm_7", "damage", true)/100,
  }
  if IsServer() then
    self:SetLevel(1)
  end
  self.targets = self.ability:GetSpecialValueFor("targets")
  self.speed = self.ability:GetSpecialValueFor("speed")
end

end


function tinker_heat_seeking_missile_custom:GetCooldown()
return self.talents.r7_talent_cd and self.talents.r7_talent_cd or 0
end

function tinker_heat_seeking_missile_custom:OnSpellStart()
local caster = self:GetCaster()
local radius = self.talents.r7_range + caster:GetCastRangeBonus()
local speed = self.speed

local heroes = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false)
local targets = self.targets

local result = {}
for _,hero in pairs(heroes) do
    if #result < targets then
        table.insert(result, hero)
    end
end

if #result < targets then
    local creeps = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false)
    for _,creep in pairs(creeps) do
        if #result < targets then
            table.insert(result, creep)
        end
    end
end

if #result <= 0 then
    caster:EmitSound("Hero_Tinker.Heat-Seeking_Missile_Dud")

    local attach = caster:ScriptLookupAttachment( "attach_attack3" ) ~=0 and "attach_attack3" or "attach_attack1"
    local point = caster:GetAttachmentOrigin(caster:ScriptLookupAttachment( attach ))

    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_tinker/tinker_missile_dud.vpcf", PATTACH_WORLDORIGIN, caster )
    ParticleManager:SetParticleControl( effect_cast, 0, point )
    ParticleManager:SetParticleControlForward( effect_cast, 0, caster:GetForwardVector() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    return
end

caster:EmitSound("Hero_Tinker.Heat-Seeking_Missile")

local count = 0
for i = 0, 6 do
    local current_ability = caster:GetAbilityByIndex(i)
    if current_ability and current_ability ~= self and current_ability:GetCooldownTimeRemaining() > 0 then
        count = count + 1
    end
end

local info = 
{
  EffectName = "particles/units/heroes/hero_tinker/tinker_missile.vpcf",
  Ability = self,
  iMoveSpeed = speed,
  Source = caster,
  bDodgeable = true,
  iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_3, 
  ExtraData = {count = count}
}

for _,target in pairs(result) do
    info.Target = target
    ProjectileManager:CreateTrackingProjectile(info)
end

end

function tinker_heat_seeking_missile_custom:OnProjectileHit_ExtraData(target, vLocation, table)
if not target then return end
local caster = self:GetCaster()
local count = table.count
local damage = self.talents.r7_damage_base + caster:GetIntellect(false)*self.talents.r7_damage
damage = damage*(1 + count*self.talents.r7_damage_inc)

local damage_table = {victim = target, damage = damage, attacker = caster, ability = self, damage_type = self.talents.r7_damage_type}
local real_damage = DoDamage(damage_table)

if count >= self.talents.r7_stack then
    target:AddNewModifier(caster, self, "modifier_stunned", {duration = (1 - target:GetStatusResistance())*self.talents.r7_stun})
end

local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_tinker/tinker_missle_explosion.vpcf", PATTACH_POINT_FOLLOW, target)
ParticleManager:SetParticleControlEnt( particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(particle)

target:EmitSound("Hero_Tinker.Heat-Seeking_Missile.Impact")
end


modifier_tinker_rearm_custom_damage_cd = class(mod_hidden)
modifier_tinker_rearm_custom_damage_cd_creeps = (mod_hidden)

modifier_tinker_rearm_custom_mana_bonus = class(mod_visible)
function modifier_tinker_rearm_custom_mana_bonus:GetTexture() return "buffs/tinker/rearm_4" end
function modifier_tinker_rearm_custom_mana_bonus:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.mana_bonus = self.ability.talents.r4_mana
self.parent:AddSpellEvent(self)
end

function modifier_tinker_rearm_custom_mana_bonus:SpellEvent(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end
if params.ability:GetManaCost(params.ability:GetLevel()) <= 0 then return end
self:Destroy()
end

function modifier_tinker_rearm_custom_mana_bonus:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING
}
end

function modifier_tinker_rearm_custom_mana_bonus:GetModifierPercentageManacostStacking(params)
if not params.ability or params.ability == self.ability then return end
return self.mana_bonus
end


modifier_tinker_rearm_custom_auto_cast = class(mod_hidden)
function modifier_tinker_rearm_custom_auto_cast:RemoveOnDeath() return false end


modifier_tinker_rearm_custom_auto_cast = class(mod_hidden)
function modifier_tinker_rearm_custom_auto_cast:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability:ToggleAutoCast()

self.ability.use_bkb = true
self.parent:CastAbilityNoTarget(self.ability, 1)
self:Destroy()
end

modifier_tinker_rearm_custom_invun_cd = class(mod_cd)
function modifier_tinker_rearm_custom_invun_cd:GetTexture() return "buffs/tinker/hero_6" end


modifier_tinker_rearm_custom_spell_damage = class(mod_visible)
function modifier_tinker_rearm_custom_spell_damage:GetTexture() return "buffs/tinker/rearm_3" end
function modifier_tinker_rearm_custom_spell_damage:OnCreated(table)
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.duration = self.ability.talents.r3_duration
if not IsServer() then return end
self:AddStack(table.stack)
end

function modifier_tinker_rearm_custom_spell_damage:OnRefresh(table)
if not IsServer() then return end 
self:AddStack(table.stack)
end 

function modifier_tinker_rearm_custom_spell_damage:AddStack(stack)
if not IsServer() then return end

for i = 1, stack do
    Timers:CreateTimer(self.duration, function() 
        if IsValid(self) then 
            self:DecrementStackCount()
            if self:GetStackCount() <= 0 then 
                self:Destroy()
            end 
        end 
    end)
    self:IncrementStackCount()
end

end 

function modifier_tinker_rearm_custom_spell_damage:OnStackCountChanged(iStackCount)
if not IsServer() then return end
self.parent:CalculateStatBonus(true)
end

function modifier_tinker_rearm_custom_spell_damage:OnDestroy()
if not IsServer() then return end
self.parent:CalculateStatBonus(true)
end

function modifier_tinker_rearm_custom_spell_damage:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE
}
end

function modifier_tinker_rearm_custom_spell_damage:GetModifierSpellAmplify_Percentage()
return self.ability.talents.r3_damage*self:GetStackCount()
end

function modifier_tinker_rearm_custom_spell_damage:GetModifierExtraHealthPercentage()
return self.ability.talents.r3_health*self:GetStackCount()
end

modifier_tinker_rearm_custom_quest = class(mod_hidden)


modifier_tinker_rearm_custom_invun = class(mod_hidden)
function modifier_tinker_rearm_custom_invun:CheckState()
return
{
    [MODIFIER_STATE_INVULNERABLE] = true,
    [MODIFIER_STATE_NO_HEALTH_BAR] = true
}
end