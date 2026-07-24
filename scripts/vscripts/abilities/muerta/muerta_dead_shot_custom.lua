--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_muerta_dead_shot_custom_debuff", "abilities/muerta/muerta_dead_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_muerta_dead_shot_custom_fear", "abilities/muerta/muerta_dead_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_muerta_dead_shot_custom_thinker", "abilities/muerta/muerta_dead_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_muerta_dead_shot_custom_tracker", "abilities/muerta/muerta_dead_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_muerta_dead_shot_custom_legendary_stack", "abilities/muerta/muerta_dead_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_muerta_dead_shot_custom_damage_reduce", "abilities/muerta/muerta_dead_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_muerta_dead_shot_custom_speed", "abilities/muerta/muerta_dead_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_muerta_dead_shot_custom_auto_cd", "abilities/muerta/muerta_dead_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_muerta_dead_shot_custom_burn", "abilities/muerta/muerta_dead_shot_custom", LUA_MODIFIER_MOTION_NONE)

muerta_dead_shot_custom = class({})
muerta_dead_shot_custom.talents = {}

function muerta_dead_shot_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_deadshot_tracking_proj.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_deadshot_creep_impact.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_deadshot_linear.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_spell_fear_debuff.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_spell_fear_debuff_status.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_spell_fear_debuff.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_parting_shot_projectile.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_parting_shot_soul.vpcf", context )
PrecacheResource( "particle", "particles/status_fx/status_effect_muerta_parting_shot.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_parting_shot_soul.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_parting_shot_tether.vpcf", context )
PrecacheResource( "particle", "particles/muerta/dead_legendary_stun.vpcf", context )
PrecacheResource( "particle", "particles/muerta/dead_refresh.vpcf", context )
PrecacheResource( "particle", "particles/muerta/shot_legendary.vpcf", context )
PrecacheResource( "particle", "particles/muerta/gun_evasion.vpcf", context )
PrecacheResource( "particle", "particles/muerta/dead_shot_stack.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_spell_fear_debuff.vpcf", context )
PrecacheResource( "particle", "particles/muerta/shot_damage_reduce.vpcf", context )
PrecacheResource( "particle", "particles/wk_burn.vpcf", context )

end

function muerta_dead_shot_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_q1 = 0,
    q1_spell = 0,
    q1_damage = 0,
    
    has_q2 = 0,
    q2_cd = 0,
    q2_range = 0,
    
    has_q3 = 0,
    q3_damage = 0,
    q3_heal_reduce = 0,
    q3_duration = caster:GetTalentValue("modifier_muerta_dead_3", "duration", true),
    q3_health = caster:GetTalentValue("modifier_muerta_dead_3", "health", true),
    q3_bonus = caster:GetTalentValue("modifier_muerta_dead_3", "bonus", true),
    
    has_q4 = 0,
    q4_cd_items = caster:GetTalentValue("modifier_muerta_dead_4", "cd_items", true),
    q4_width = caster:GetTalentValue("modifier_muerta_dead_4", "width", true)/100,
    q4_move = caster:GetTalentValue("modifier_muerta_dead_4", "move", true),
    q4_duration = caster:GetTalentValue("modifier_muerta_dead_4", "duration", true),
    q4_cd_items_legendary = caster:GetTalentValue("modifier_muerta_dead_4", "cd_items_legendary", true),
    q4_speed = caster:GetTalentValue("modifier_muerta_dead_4", "speed", true)/100,
    
    has_q7 = 0,
    q7_fear_reduce = caster:GetTalentValue("modifier_muerta_dead_7", "fear_reduce", true)/100,
    q7_fear = caster:GetTalentValue("modifier_muerta_dead_7", "fear", true),
    q7_mana = caster:GetTalentValue("modifier_muerta_dead_7", "mana", true)/100,
    q7_max = caster:GetTalentValue("modifier_muerta_dead_7", "max", true),
    q7_damage_reduce = caster:GetTalentValue("modifier_muerta_dead_7", "damage_reduce", true)/100,
    q7_cd = caster:GetTalentValue("modifier_muerta_dead_7", "cd", true)/100,
    q7_duration = caster:GetTalentValue("modifier_muerta_dead_7", "duration", true),
    q7_damage = caster:GetTalentValue("modifier_muerta_dead_7", "damage", true)/100,
    q7_width = caster:GetTalentValue("modifier_muerta_dead_7", "width", true),
    q7_cd_proc = caster:GetTalentValue("modifier_muerta_dead_7", "cd_proc", true),
    q7_heal = caster:GetTalentValue("modifier_muerta_dead_7", "heal", true)/100,
    
    has_h1 = 0,
    h1_fear = 0,
    
    has_h4 = 0,
    h4_talent_cd = caster:GetTalentValue("modifier_muerta_hero_4", "talent_cd", true),
    h4_damage_reduce = caster:GetTalentValue("modifier_muerta_hero_4", "damage_reduce", true),
    h4_fear = caster:GetTalentValue("modifier_muerta_hero_4", "fear", true),
    h4_duration = caster:GetTalentValue("modifier_muerta_hero_4", "duration", true),
    
  }
end

if caster:HasTalent("modifier_muerta_dead_1") then
  self.talents.has_q1 = 1
  self.talents.q1_spell = caster:GetTalentValue("modifier_muerta_dead_1", "spell")
  self.talents.q1_damage = caster:GetTalentValue("modifier_muerta_dead_1", "damage")/100
end

if caster:HasTalent("modifier_muerta_dead_2") then
  self.talents.has_q2 = 1
  self.talents.q2_cd = caster:GetTalentValue("modifier_muerta_dead_2", "cd")
  self.talents.q2_range = caster:GetTalentValue("modifier_muerta_dead_2", "range")
end

if caster:HasTalent("modifier_muerta_dead_3") then
  self.talents.has_q3 = 1
  self.talents.q3_damage = caster:GetTalentValue("modifier_muerta_dead_3", "damage")/100
  self.talents.q3_heal_reduce = caster:GetTalentValue("modifier_muerta_dead_3", "heal_reduce")
end

if caster:HasTalent("modifier_muerta_dead_4") then
  self.talents.has_q4 = 1
end

if caster:HasTalent("modifier_muerta_dead_7") then
  self.talents.has_q7 = 1
end

if caster:HasTalent("modifier_muerta_hero_1") then
  self.talents.has_h1 = 1
  self.talents.h1_fear = caster:GetTalentValue("modifier_muerta_hero_1", "fear")
end

if caster:HasTalent("modifier_muerta_hero_4") then
  self.talents.has_h4 = 1
  caster:AddSpellEvent(self.tracker, true)
end

end

function muerta_dead_shot_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_muerta_dead_shot_custom_tracker"
end

function muerta_dead_shot_custom:GetCooldown(level)
return (self.BaseClass.GetCooldown( self, level ) + (self.talents.q2_cd and self.talents.q2_cd or 0)) * (1 + (self.talents.has_q7 == 1 and self.talents.q7_mana or 0))
end

function muerta_dead_shot_custom:GetManaCost(iLevel)
return self.BaseClass.GetManaCost(self, iLevel) * (1 + (self.talents.has_q7 == 1 and self.talents.q7_cd or 0))
end

function muerta_dead_shot_custom:CastFilterResultTarget(target)
local flag = target:HasModifier("modifier_item_muerta_quest_item_illusion") and DOTA_UNIT_TARGET_FLAG_INVULNERABLE or 0
local team = target:IsBuilding() and DOTA_UNIT_TARGET_TEAM_BOTH or DOTA_UNIT_TARGET_TEAM_ENEMY
local nResult = UnitFilter(target, team, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_TREE + DOTA_UNIT_TARGET_BUILDING, flag, self.caster:GetTeamNumber())
return nResult
end

function muerta_dead_shot_custom:GetWidth()
return self.ricochet_radius_start * (1 + (self.talents.has_q4 == 1 and self.talents.q4_width or 0))
end

function muerta_dead_shot_custom:GetSpeed()
return self.speed * (1 + (self.talents.has_q4 == 1 and self.talents.q4_speed or 0))
end

function muerta_dead_shot_custom:OnAbilityPhaseStart()
self.targetcast = self:GetCursorTarget()
end

function muerta_dead_shot_custom:OnAbilityPhaseInterrupted()
self.targetcast = nil
end

function muerta_dead_shot_custom:OnVectorCastStart(vStartLocation, vDirection)

local target = self.targetcast and self.targetcast or self:GetCursorTarget()

if not target then return end

if not target:IsBaseNPC() then
	local dummy = CreateUnitByName("npc_dota_companion", target:GetAbsOrigin(), false, nil, nil, self.caster:GetTeamNumber())
    dummy:AddNewModifier(self.caster, self, "modifier_muerta_dead_shot_custom_thinker", {})
    dummy:SetAbsOrigin(dummy:GetAbsOrigin() + Vector(0,0,100))
    dummy.tree = target
    target = dummy
end

AddFOWViewer(self.caster:GetTeamNumber(), target:GetAbsOrigin(), 100, 3, false)

local vec = vDirection
if self.vectorTargetPosition2 then
    vec = self.vectorTargetPosition2 - target:GetAbsOrigin()
    vec.z = 0
    vec = vec:Normalized()
end

local info = 
{
    EffectName = "particles/units/heroes/hero_muerta/muerta_deadshot_tracking_proj.vpcf",
    Ability = self,
    iMoveSpeed = self:GetSpeed(),
    Source = self.caster,
    Target = target,
    iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
    ExtraData = { x = vec.x, y = vec.y, tracking = 1 }
}

self.caster:EmitSound("Hero_Muerta.DeadShot.Cast")
ProjectileManager:CreateTrackingProjectile( info )
self.targetcast = nil
end

function muerta_dead_shot_custom:DealDamage(target, damage_ability)
if not target:IsUnit() then return end

target:EmitSound("Hero_Muerta.DeadShot.Damage")

local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_muerta/muerta_deadshot_creep_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
ParticleManager:SetParticleControlEnt( particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
ParticleManager:ReleaseParticleIndex(particle)

local damage = (self.damage + self.talents.q1_damage*self.caster:GetIntellect(false))

if damage_ability == "modifier_muerta_dead_7" then
    damage = damage * self.talents.q7_damage
elseif self.talents.has_q7 == 1 then
    damage = damage * (1 + self.talents.q7_damage_reduce)
end

if target:IsCreep() then 
    damage = damage*(1 + self.creeps_damage)
end 

self:ApplyBurn(target, damage)

local real_damage = DoDamage({victim = target, attacker = self.caster, ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL}, damage_ability)
if damage_ability == "modifier_muerta_dead_7" then
    target:SendNumber(107, real_damage)
end

if damage_ability == "modifier_muerta_dead_7" then
    local result = self.caster:CanLifesteal(target)
    if result then
        self.caster:GenericHeal(result*self.talents.q7_heal*real_damage, self.ability, false, "particles/items3_fx/octarine_core_lifesteal.vpcf", "modifier_muerta_dead_7")
    end
end

end

function muerta_dead_shot_custom:RicochetShot(x, y, target, damage_k)
if not IsServer() then return end

local vel = Vector(x, y, 0)
local width = self:GetWidth()
local speed = self:GetSpeed()
local range = self.range + self.caster:GetCastRangeBonus()
local spawn_origin = target:GetAbsOrigin()

local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_muerta/muerta_deadshot_linear.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(particle, 0, GetGroundPosition(target:GetAbsOrigin(), nil))
ParticleManager:SetParticleControlForward(particle, 0, vel)
ParticleManager:SetParticleControl(particle, 1, vel * speed)
ParticleManager:SetParticleControl(particle, 4, Vector(width, width, range/speed))

local info = 
{
    Source = self.caster,
    Ability = self,
    EffectName = "",
    vSpawnOrigin = target:GetAbsOrigin(),
    fDistance = range,
    vVelocity = vel * speed,
    fStartRadius = width,
    fEndRadius = width,
    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    bProvidesVision = true,
    iVisionRadius = 115,
    iVisionTeamNumber = self.caster:GetTeamNumber(),
    fExpireTime  = GameRules:GetGameTime() + 5.0,
    bDeleteOnHit = false,
    ExtraData = {x = vel.x, y = vel.y, tracking = 0, source = target:entindex(), particle = particle},
}

ProjectileManager:CreateLinearProjectile( info )
end

function muerta_dead_shot_custom:OnProjectileHit_ExtraData( target, location, data )
if not IsServer() then return end
if not target then
    if data.particle then
        ParticleManager:DestroyParticle(data.particle, false)
        ParticleManager:ReleaseParticleIndex(data.particle)
    end 
    return 
end

if data.is_auto == 1 then
    self:ApplyFear(target, self.talents.h4_fear)
    return
elseif data.tracking == 1 then
    if target:TriggerSpellAbsorb(self) then return end

    if target:IsUnit() then
        target:AddNewModifier(self.caster, self, "modifier_muerta_dead_shot_custom_debuff", {duration = self.impact_slow_duration})
    end
    self:DealDamage(target)

    target:EmitSound("Hero_Muerta.DeadShot.Ricochet")

    self:RicochetShot(data.x, data.y, target)

    if target:GetUnitName() == "npc_dota_companion" then
        EmitSoundOnLocationWithCaster(location, "Hero_Muerta.DeadShot.Tree", self.caster)
        target:RemoveModifierByName("modifier_muerta_dead_shot_custom_thinker")
    	target:ForceKill(false)
    else
        target:EmitSound("Hero_Muerta.DeadShot.Slow")
    end
elseif data.is_legendary == 1 then

    target:EmitSound("Muerta.Dead_proc_target")
    self:ApplyFear(target, self.talents.q7_fear, data.x, data.y)
    self:DealDamage(target, "modifier_muerta_dead_7")

elseif data.source and target:entindex() ~= data.source then

    local is_hero = target:IsRealHero()
    local source = EntIndexToHScript(data.source)
    local new_y 
    local new_x

    if source then 
        new_x = source:GetAbsOrigin().x
        new_y = source:GetAbsOrigin().y
    end

    local duration = (self.ricochet_fear_duration + self.talents.h1_fear) * (1 + (self.talents.has_q7 == 1 and self.talents.q7_fear_reduce or 0))
    self:ApplyFear(target, duration, new_x, new_y)
    self:DealDamage(target)

    if self.talents.has_q4 == 1 then
        self.caster:AddNewModifier(self.caster, self, "modifier_muerta_dead_shot_custom_speed", {duration = self.talents.q4_duration})
        if is_hero then
            self.caster:CdItems(self.talents.has_q7 == 1 and self.talents.q4_cd_items_legendary or self.talents.q4_cd_items)
        end
    end

    if is_hero then
        if self.caster:GetQuest() == "Muerta.Quest_5" then 
            self.caster:UpdateQuest(1)
        end
        if IsValid(self.caster.veil_ability) then
            self.caster.veil_ability:LegendaryStack(true)
        end
    end

    if (is_hero or target:HasModifier("modifier_muerta_innate_custom_creep")) then
        if self.talents.has_q7 == 1 then
            self.caster:AddNewModifier(self.caster, self, "modifier_muerta_dead_shot_custom_legendary_stack", {duration = self.ability.talents.q7_duration})
        end
        if data.particle then
            ParticleManager:DestroyParticle(data.particle, false)
            ParticleManager:ReleaseParticleIndex(data.particle)
        end 
        return true
    end
    return false
end

end

function muerta_dead_shot_custom:ApplyFear(target, duration, x, y, no_sound)
if not IsServer() then return end
if not target:IsUnit() then return end
if not self:IsTrained() then return end

target:EmitSound("Hero_Muerta.DeadShot.Fear")
if not no_sound then
    target:EmitSound("Hero_Muerta.DeadShot.Ricochet.Impact")
end
target:AddNewModifier(self.caster, self, "modifier_muerta_dead_shot_custom_fear", {duration = duration * (1 - target:GetStatusResistance()), x = x, y = y})
end


function muerta_dead_shot_custom:ApplyBurn(target, damage)
if not IsServer() then return end
if not self:IsTrained() then return end
if self.ability.talents.has_q3 == 0 then return end

target:AddNewModifier(self.caster, self, "modifier_muerta_dead_shot_custom_burn", {damage = damage*self.talents.q3_damage})
end


modifier_muerta_dead_shot_custom_debuff = class({})
function modifier_muerta_dead_shot_custom_debuff:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH  end
function modifier_muerta_dead_shot_custom_debuff:GetStatusEffectName() return "particles/units/heroes/hero_muerta/muerta_spell_fear_debuff_status.vpcf" end
function modifier_muerta_dead_shot_custom_debuff:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.slow = self.ability.impact_slow_percent

if not IsServer() then return end
self.parent:GenericParticle("particles/units/heroes/hero_muerta/muerta_spell_fear_debuff.vpcf", self)
self:StartIntervalThink(0.1)
end

function modifier_muerta_dead_shot_custom_debuff:OnIntervalThink()
if not IsServer() then return end
AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), 10, 0.2, false)
end

function modifier_muerta_dead_shot_custom_debuff:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_muerta_dead_shot_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end


modifier_muerta_dead_shot_custom_fear = class(mod_hidden)
function modifier_muerta_dead_shot_custom_fear:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH end
function modifier_muerta_dead_shot_custom_fear:GetStatusEffectName() return "particles/units/heroes/hero_muerta/muerta_spell_fear_debuff_status.vpcf" end
function modifier_muerta_dead_shot_custom_fear:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

local source_point = self.caster:GetAbsOrigin()
if table.x and table.y then
    source_point = GetGroundPosition(Vector(table.x, table.y, 0), nil)
end

local vec = (self.parent:GetAbsOrigin() - source_point):Normalized()
self.position = GetGroundPosition(self.parent:GetAbsOrigin() + vec * 500, nil)

if not self.parent:IsHero() then
    self.parent:AddNewModifier(self.caster, self.ability, "modifier_disarmed", {duration = 0.1})
end

if not self.parent:IsDebuffImmune() then 
    self.parent:MoveToPosition( self.position )
end

self.parent:GenericParticle("particles/units/heroes/hero_muerta/muerta_spell_fear_debuff.vpcf", self)
end

function modifier_muerta_dead_shot_custom_fear:OnRefresh(table)
if not IsServer() then return end
self:OnCreated(table)
end

function modifier_muerta_dead_shot_custom_fear:CheckState()
return
{
    [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
    [MODIFIER_STATE_FEARED] = true,
    [MODIFIER_STATE_DISARMED] = true,
    [MODIFIER_STATE_SILENCED] = true,
    [MODIFIER_STATE_UNSLOWABLE] = true,
}
end

function modifier_muerta_dead_shot_custom_fear:OnDestroy()
if not IsServer() then return end

if self.ability.talents.has_h4 == 1 then
    self.parent:AddNewModifier(self.caster, self.ability, "modifier_muerta_dead_shot_custom_damage_reduce", {duration = self.ability.talents.h4_duration})
end

if self.parent:IsDebuffImmune() then return end
self.parent:Stop()
end


modifier_muerta_dead_shot_custom_thinker = class(mod_hidden)
function modifier_muerta_dead_shot_custom_thinker:CheckState()
return 
{
    [MODIFIER_STATE_INVULNERABLE] = true,
    [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
    [MODIFIER_STATE_STUNNED] = true,
    [MODIFIER_STATE_UNSELECTABLE] = true,
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
}
end

function modifier_muerta_dead_shot_custom_thinker:OnDestroy()
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()

if self.parent.tree then
    self.parent.tree:CutDown(self.caster:GetTeamNumber())
end
GridNav:DestroyTreesAroundPoint(self.parent:GetAbsOrigin(), 25, true)
end



modifier_muerta_dead_shot_custom_speed = class(mod_visible)
function modifier_muerta_dead_shot_custom_speed:GetTexture() return "buffs/muerta/dead_4" end
function modifier_muerta_dead_shot_custom_speed:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move = self.ability.talents.q4_move
if not IsServer() then return end
self.parent:GenericParticle("particles/muerta/gun_evasion.vpcf", self)
end 

function modifier_muerta_dead_shot_custom_speed:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_muerta_dead_shot_custom_speed:GetModifierMoveSpeedBonus_Percentage()
return self.move
end


modifier_muerta_dead_shot_custom_legendary_stack = class(mod_hidden)
function modifier_muerta_dead_shot_custom_legendary_stack:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.talents.q7_max
self.stack = 0

if not IsServer() then return end 
self.RemoveForDuel = true
self.effect = self.parent:GenericParticle("particles/muerta/dead_shot_stack.vpcf", self, true)
self:OnRefresh()

self.max_time = self.ability.talents.q7_duration
self:OnIntervalThink()
self:StartIntervalThink(0.1)
end

function modifier_muerta_dead_shot_custom_legendary_stack:OnRefresh()
if not IsServer() then return end 
if self.stack >= self.max then return end 
self.stack = self.stack + 1
ParticleManager:SetParticleControl(self.effect, 1, Vector(0, self.stack, 0))

if self.stack >= self.max and not self.ability:IsHidden() and IsValid(self.parent.dead_ability_legendary) then
    self.parent:SwapAbilities(self.ability:GetName(), self.parent.dead_ability_legendary:GetName(), false, true)
    self.parent.dead_ability_legendary:StartCooldown(self.ability.talents.q7_cd_proc)
end

end 

function modifier_muerta_dead_shot_custom_legendary_stack:OnIntervalThink()
if not IsServer() then return end

self.parent:UpdateUIshort({max_time = self.max_time, time = self:GetRemainingTime(), stack = self.stack, active = self.stack >= self.max, style = "MuertaDead"})
end

function modifier_muerta_dead_shot_custom_legendary_stack:OnDestroy()
if not IsServer() then return end
self.parent:UpdateUIshort({hide = 1, hide_full = 1, style = "MuertaDead"})

if self.ability:IsHidden() and IsValid(self.parent.dead_ability_legendary)  then
    self.parent:SwapAbilities(self.ability:GetName(), self.parent.dead_ability_legendary:GetName(), true, false)
    self.ability:EndCooldown()
    self.ability:StartCooldown(self.ability.talents.q7_cd_proc)
end

end


muerta_dead_shot_custom_proc = class({})

function muerta_dead_shot_custom_proc:GetCastRange(vLocation, hTarget)
return self.caster.dead_ability and self.caster.dead_ability.range or 0
end

function muerta_dead_shot_custom_proc:OnSpellStart()
if not self.caster.dead_ability then return end

self.caster:RemoveModifierByName("modifier_muerta_dead_shot_custom_legendary_stack")

local point = self.caster:CastPosition(self:GetCursorPosition())
local vel = (point - self.caster:GetAbsOrigin()):Normalized()
vel.z = 0

local width = self.caster.dead_ability:GetWidth()
local end_width = width * self.caster.dead_ability.talents.q7_width

local speed = self.caster.dead_ability:GetSpeed()*0.75
local range = self.caster.dead_ability.range + self.caster:GetCastRangeBonus()
local spawn_origin = self.caster:GetAbsOrigin()

local particle = ParticleManager:CreateParticle("particles/muerta/shot_legendary.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(particle, 0, GetGroundPosition(spawn_origin, nil))
ParticleManager:SetParticleControlForward(particle, 0, vel)
ParticleManager:SetParticleControl(particle, 1, vel * speed)
ParticleManager:SetParticleControl(particle, 4, Vector(width, end_width, range/speed))

local info = 
{
    Source = self.caster,
    Ability = self.caster.dead_ability,
    EffectName = "",
    vSpawnOrigin = spawn_origin,
    fDistance = range,
    vVelocity = vel * speed,
    fStartRadius = width,
    fEndRadius = end_width,
    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    bProvidesVision = true,
    iVisionRadius = end_width,
    iVisionTeamNumber = self.caster:GetTeamNumber(),
    fExpireTime  = GameRules:GetGameTime() + 5.0,
    bDeleteOnHit = false,
    ExtraData = {is_legendary = 1, x = self.caster:GetAbsOrigin().x, y = self.caster:GetAbsOrigin().y, particle = particle},
}

self.caster:EmitSound("Muerta.Dead_proc")
self.caster:EmitSound("Muerta.Dead_proc2")
self.caster:EmitSound("Muerta.Dead_proc_vo")
ProjectileManager:CreateLinearProjectile( info )
end




modifier_muerta_dead_shot_custom_tracker = class(mod_hidden)
function modifier_muerta_dead_shot_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.dead_ability = self.ability

self.parent.dead_ability_legendary = self.parent:FindAbilityByName("muerta_dead_shot_custom_proc")

self.ability.damage = self.ability:GetSpecialValueFor("damage" )
self.ability.ricochet_fear_duration = self.ability:GetSpecialValueFor("ricochet_fear_duration")
self.ability.range = self.ability:GetSpecialValueFor("range")
self.ability.speed = self.ability:GetSpecialValueFor("speed")
self.ability.radius = self.ability:GetSpecialValueFor("radius" )
self.ability.ricochet_radius_start = self.ability:GetSpecialValueFor("ricochet_radius_start")
self.ability.ricochet_radius_end = self.ability:GetSpecialValueFor("ricochet_radius_end")
self.ability.impact_slow_percent = self.ability:GetSpecialValueFor("impact_slow_percent")
self.ability.impact_slow_duration = self.ability:GetSpecialValueFor("impact_slow_duration")
self.ability.creeps_damage = self.ability:GetSpecialValueFor("creeps_damage")/100
end

function modifier_muerta_dead_shot_custom_tracker:OnRefresh()
self.ability.damage = self.ability:GetSpecialValueFor("damage" )
self.ability.ricochet_fear_duration = self.ability:GetSpecialValueFor("ricochet_fear_duration")
end

function modifier_muerta_dead_shot_custom_tracker:SpellEvent(params)
if not IsServer() then return end
if self.ability.talents.has_h4 == 0 then return end
if self.parent:HasModifier("modifier_muerta_dead_shot_custom_auto_cd") then return end

local attacker = params.unit
if attacker:GetTeamNumber() == self.parent:GetTeamNumber() then return end
if not params.target or params.target ~= self.parent then return end
if not attacker:IsHero() then return end
if attacker:IsDebuffImmune() then return end

local info = 
{
    EffectName = "particles/units/heroes/hero_muerta/muerta_deadshot_tracking_proj.vpcf",
    Ability = self.ability,
    iMoveSpeed = self.ability.speed,
    Source = self.parent,
    Target = attacker,
    ExtraData = {is_auto = 1 }
}

self.parent:EmitSound("Hero_Muerta.DeadShot.Cast")
ProjectileManager:CreateTrackingProjectile( info )

self.parent:AddNewModifier(self.parent, self.ability, "modifier_muerta_dead_shot_custom_auto_cd", {duration = self.ability.talents.h4_talent_cd})
end

function modifier_muerta_dead_shot_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_muerta_dead_shot_custom_tracker:GetModifierCastRangeBonusStacking()
return self.ability.talents.q2_range
end

function modifier_muerta_dead_shot_custom_tracker:GetModifierSpellAmplify_Percentage()
return self.ability.talents.q1_spell
end




modifier_muerta_dead_shot_custom_damage_reduce = class(mod_hidden)
function modifier_muerta_dead_shot_custom_damage_reduce:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.damage_reduce = self.ability.talents.h4_damage_reduce
if not IsServer() then return end
self.parent:GenericParticle("particles/muerta/shot_damage_reduce.vpcf", self, true)
self.parent:GenericParticle("particles/units/heroes/hero_muerta/muerta_spell_fear_debuff.vpcf", self)
end

function modifier_muerta_dead_shot_custom_damage_reduce:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_muerta_dead_shot_custom_damage_reduce:GetModifierDamageOutgoing_Percentage()
return self.damage_reduce
end

function modifier_muerta_dead_shot_custom_damage_reduce:GetModifierSpellAmplify_Percentage()
return self.damage_reduce
end


modifier_muerta_dead_shot_custom_auto_cd = class(mod_cd)
function modifier_muerta_dead_shot_custom_auto_cd:GetTexture() return "buffs/muerta/hero_4" end



modifier_muerta_dead_shot_custom_burn = class(mod_visible)
function modifier_muerta_dead_shot_custom_burn:GetTexture() return "buffs/muerta/dead_3" end
function modifier_muerta_dead_shot_custom_burn:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.interval = 1
self.duration = self.ability.talents.q3_duration
self.health = self.ability.talents.q3_health
self.heal_reduce = self.ability.talents.q3_heal_reduce
self.bonus = self.ability.talents.q3_bonus

self.count = 0
self.tick = 0
self.total_damage = 0

self.damageTable = {victim = self.parent, attacker = self.caster, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability}
if not IsServer() then return end

self.parent:GenericParticle("particles/wk_burn.vpcf", self)

self:OnRefresh(table)
self:StartIntervalThink(self.interval)
end

function modifier_muerta_dead_shot_custom_burn:OnRefresh(table)
if not IsServer() then return end
self.total_damage = self.total_damage + table.damage
self.tick = self.total_damage/self.duration
self.count = self.duration/self.interval
self.damageTable.damage = self.tick
end

function modifier_muerta_dead_shot_custom_burn:OnIntervalThink()
if not IsServer() then return end

self.damageTable.damage = self.tick * (self.parent:GetHealthPercent() <= self.health and self.bonus or 1)

local real_damage = DoDamage(self.damageTable, "modifier_muerta_dead_3")
self.parent:SendNumber(9, real_damage)

self.total_damage = self.total_damage - self.tick
self.count = self.count - 1

if self.count <= 0 then
    self:Destroy()
    return
end

end

function modifier_muerta_dead_shot_custom_burn:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE
}
end

function modifier_muerta_dead_shot_custom_burn:GetModifierHPRegenAmplify_Percentage()
return self.heal_reduce * (self.parent:GetHealthPercent() <= self.health and self.bonus or 1)
end

function modifier_muerta_dead_shot_custom_burn:GetModifierHealChange()
return self.heal_reduce * (self.parent:GetHealthPercent() <= self.health and self.bonus or 1)
end