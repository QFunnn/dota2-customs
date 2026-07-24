--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_invoker_wex_custom", "abilities/invoker/invoker_wex_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_wex_custom_passive", "abilities/invoker/invoker_wex_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_emp_custom", "abilities/invoker/invoker_wex_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_emp_custom_legendary", "abilities/invoker/invoker_wex_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_emp_custom_legendary_attacks", "abilities/invoker/invoker_wex_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_emp_custom_legendary_damage", "abilities/invoker/invoker_wex_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_alacrity_custom", "abilities/invoker/invoker_wex_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_tornado_custom", "abilities/invoker/invoker_wex_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_invoker_emp_custom_teleport","abilities/invoker/invoker_wex_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_tornado_custom_thinker","abilities/invoker/invoker_wex_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_tornado_custom_silence","abilities/invoker/invoker_wex_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_alacrity_custom_stats","abilities/invoker/invoker_wex_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_alacrity_custom_damage","abilities/invoker/invoker_wex_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_tornado_custom_purge", "abilities/invoker/invoker_wex_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_invoker_emp_custom_invun", "abilities/invoker/invoker_wex_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_invoker_tornado_custom_scepter_count", "abilities/invoker/invoker_wex_custom", LUA_MODIFIER_MOTION_NONE)

invoker_wex_custom = class({})
invoker_wex_custom.talents = {}

function invoker_wex_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/invoker/emp_blink_start.vpcf", context )
PrecacheResource( "particle", "particles/items3_fx/blink_arcane_end.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_emp.vpcf", context )
PrecacheResource( "particle", "particles/invoker/emp_legendarya.vpcf", context )
PrecacheResource( "particle", "particles/cleance_blade.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_alacrity.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_alacrity_buff.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_tornado.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_tornado_child.vpcf", context )
PrecacheResource( "particle", "particles/void_astral_slow.vpcf", context )
PrecacheResource( "particle", "particles/invoker/alacrity_max.vpcf", context )
PrecacheResource( "particle", "particles/generic_gameplay/generic_break.vpcf", context )
PrecacheResource( "particle", "particles/items4_fx/nullifier_mute_debuff.vpcf", context )
PrecacheResource( "particle", "particles/invoker/emp_stack.vpcf", context )
PrecacheResource( "particle", "particles/hoodwink/bush_damage.vpcf", context )
PrecacheResource( "particle", "particles/invoker/wex_legendary_attack.vpcf", context )

end

function invoker_wex_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_w1 = 0,
    w1_stats = 0,
    w1_bonus = 0,
    w1_duration = caster:GetTalentValue("modifier_invoker_wex_1", "duration", true),
    w1_max = caster:GetTalentValue("modifier_invoker_wex_1", "max", true),

    has_w2 = 0,
    w2_range = 0,

    has_w3 = 0,
    w3_bonus = 0,
    w3_effect_duration = caster:GetTalentValue("modifier_invoker_wex_3", "effect_duration", true),

    has_w7 = 0,

    has_e7 = 0,
  }
end

if caster:HasTalent("modifier_invoker_wex_1") then
  self.talents.has_w1 = 1
  self.talents.w1_stats = caster:GetTalentValue("modifier_invoker_wex_1", "stats")
  self.talents.w1_bonus = caster:GetTalentValue("modifier_invoker_wex_1", "bonus")
  if IsServer() then
    caster:CalculateStatBonus(true)
  end
end

if caster:HasTalent("modifier_invoker_wex_2") then
  self.talents.has_w2 = 1
  self.talents.w2_range = caster:GetTalentValue("modifier_invoker_wex_2", "range")
end

if caster:HasTalent("modifier_invoker_wex_3") then
  self.talents.has_w3 = 1
  self.talents.w3_bonus = caster:GetTalentValue("modifier_invoker_wex_3", "bonus")
  caster:AddSpellEvent(self.tracker, true)
end

if caster:HasTalent("modifier_invoker_wex_7") then
  self.talents.has_w7 = 1
  self.tracker:UpdateUI()
  caster:AddAttackStartEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_invoker_exort_7") then
  self.talents.has_e7 = 1
  self.tracker:UpdateUI()
end

end

function invoker_wex_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "invoker_wex", self)
end

function invoker_wex_custom:ProcsMagicStick() return false end

function invoker_wex_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_invoker_wex_custom_passive"
end

function invoker_wex_custom:GetBehavior()
local bonus = 0
if self:GetCaster():HasShard() then
    bonus = DOTA_ABILITY_BEHAVIOR_IGNORE_SILENCE_CUSTOM + DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL + bonus
end

function invoker_wex_custom:OnSpellStart()
local caster = self:GetCaster()
local modifier = caster:AddNewModifier( caster, self,  "modifier_invoker_wex_custom", {})

if IsValid(caster.invoke_ability) then
    caster.invoke_ability:AddOrb( modifier )
end

end



modifier_invoker_wex_custom = class(mod_visible)
function modifier_invoker_wex_custom:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE  end
function modifier_invoker_wex_custom:OnCreated( kv )
self.parent = self:GetParent()
self.ability = self:GetAbility()
end

function modifier_invoker_wex_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_invoker_wex_custom:GetModifierMoveSpeedBonus_Percentage()
if self.parent:HasShard() then return end
return self.ability.move_speed_per_instance
end

function modifier_invoker_wex_custom:GetModifierAttackSpeedBonus_Constant()
if self.parent:HasShard() then return end
return self.ability.attack_speed
end


modifier_invoker_wex_custom_passive = class(mod_hidden)
function modifier_invoker_wex_custom_passive:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.wex_ability = self.ability

self.ability.move_speed_per_instance = self.ability:GetSpecialValueFor( "move_speed_per_instance" )
self.ability.attack_speed = self.ability:GetSpecialValueFor( "attack_speed" )
self.agi = self.ability:GetSpecialValueFor("agility_bonus")*self.ability:GetLevel()

InvokerAbilityManager(self.parent)
end

function modifier_invoker_wex_custom_passive:OnRefresh()
self:OnCreated()
end

function modifier_invoker_wex_custom_passive:UpdateUI()
if not IsServer() then return end
if self.ability.talents.has_e7 == 1 then return end

local max = 1
local current = 1
local override = ""
local hide = 0
local use_zero = 0
local interval = -1

if IsValid(self.parent.emp_ability) and self.parent.emp_ability:GetCooldownTimeRemaining() > 0 then
    current = 0
    override = self.parent.emp_ability:GetCooldownTimeRemaining()
    use_zero = 1
    interval = 0.1
end 

if self.parent:HasModifier("modifier_invoker_emp_custom_teleport") then
    hide = 1
end

self:StartIntervalThink(interval)
self.parent:UpdateUIlong({max = max, stack = current, override_stack = override, use_zero = use_zero, priority = 1, hide = hide, style = "InvokerWex"})
end

function modifier_invoker_wex_custom_passive:OnIntervalThink()
if not IsServer() then return end
if self.ability.talents.has_e7 == 1 then 
    self:StartIntervalThink(-1)
    return 
end
self:UpdateUI()
end

function modifier_invoker_wex_custom_passive:SpellEvent(params)
if not IsServer() then return end
if self.ability.talents.has_w3 == 0 then return end
if self.parent ~= params.unit then return end
if params.ability:IsItem() then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_invoker_alacrity_custom_damage", {duration = self.ability.talents.w3_effect_duration})
end

function modifier_invoker_wex_custom_passive:AttackStartEvent_out(params)
if not IsServer() then return end
if self.ability.talents.has_w7 == 0 then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
if not IsValid(self.parent.emp_ability) then return end
if params.no_attack_cooldown then return end

self.parent.emp_ability:ProcCd()
end

function modifier_invoker_wex_custom_passive:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
  MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
  MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
}
end

function modifier_invoker_wex_custom_passive:GetModifierBonusStats_Agility()
return self.agi + self.ability.talents.w1_stats + self.parent:GetUpgradeStack("modifier_invoker_alacrity_custom_stats")*self.ability.talents.w1_bonus
end

function modifier_invoker_wex_custom_passive:GetModifierBonusStats_Strength()
return self.ability.talents.w1_stats + self.parent:GetUpgradeStack("modifier_invoker_alacrity_custom_stats")*self.ability.talents.w1_bonus
end

function modifier_invoker_wex_custom_passive:GetModifierBonusStats_Intellect()
return self.ability.talents.w1_stats + self.parent:GetUpgradeStack("modifier_invoker_alacrity_custom_stats")*self.ability.talents.w1_bonus
end

function modifier_invoker_wex_custom_passive:GetModifierAttackRangeBonus()
return self.ability.talents.w2_range
end

function modifier_invoker_wex_custom_passive:GetModifierAttackSpeedBonus_Constant()
if not self.parent:HasShard() then return end
return 3*self.ability.attack_speed
end

function modifier_invoker_wex_custom_passive:GetModifierMoveSpeedBonus_Percentage()
if not self.parent:HasShard() then return end
return 3*self.ability.move_speed_per_instance
end


invoker_emp_custom = class({})
invoker_emp_custom.talents = {}

function invoker_emp_custom:CreateTalent()
self:ToggleAutoCast()
end

function invoker_emp_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_w4 = 0,
    w4_delay = caster:GetTalentValue("modifier_invoker_wex_4", "delay", true),
    w4_invun = caster:GetTalentValue("modifier_invoker_wex_4", "invun", true),
    w4_speed = caster:GetTalentValue("modifier_invoker_wex_4", "speed", true)/100,
    w4_knock_duration = caster:GetTalentValue("modifier_invoker_wex_4", "knock_duration", true),
    w4_min_distance = caster:GetTalentValue("modifier_invoker_wex_4", "min_distance", true),
    w4_max_distance = caster:GetTalentValue("modifier_invoker_wex_4", "max_distance", true),
    w4_legendary_stack = caster:GetTalentValue("modifier_invoker_wex_4", "legendary_stack", true),
    
    has_w7 = 0,
    w7_duration = caster:GetTalentValue("modifier_invoker_wex_7", "duration", true),
    w7_attacks = caster:GetTalentValue("modifier_invoker_wex_7", "attacks", true),
    w7_speed = caster:GetTalentValue("modifier_invoker_wex_7", "speed", true),
    w7_range = caster:GetTalentValue("modifier_invoker_wex_7", "range", true),
    w7_max = caster:GetTalentValue("modifier_invoker_wex_7", "max", true),
    w7_damage = caster:GetTalentValue("modifier_invoker_wex_7", "damage", true),
    w7_mana = caster:GetTalentValue("modifier_invoker_wex_7", "mana", true)/100,
    w7_cd = caster:GetTalentValue("modifier_invoker_wex_7", "cd", true)/100,

    has_q7 = 0,
  }
end

if caster:HasTalent("modifier_invoker_wex_4") then
  self.talents.has_w4 = 1
end

if caster:HasTalent("modifier_invoker_wex_7") then
  self.talents.has_w7 = 1
end

if caster:HasTalent("modifier_invoker_quas_7") then
  self.talents.has_q7 = 1
end

end

function invoker_emp_custom:GetCastRange(vLocation, hTarget)
if self.talents.has_w7 == 1 then 
  return self.talents.w7_range - self:GetCaster():GetCastRangeBonus()
end
return self.BaseClass.GetCastRange(self , vLocation , hTarget)
end

function invoker_emp_custom:GetCooldown(level)
return self.BaseClass.GetCooldown( self, level )
end

function invoker_emp_custom:GetAOERadius()
return self.area_of_effect
end

function invoker_emp_custom:GetAbilityTextureName()
if self:GetCaster():HasModifier("modifier_invoker_emp_custom_teleport") then 
    return "emp_blink"
end 
return wearables_system:GetAbilityIconReplacement(self.caster, "invoker_emp", self)
end 

function invoker_emp_custom:GetManaCost(iLevel)
if self:GetCaster():HasModifier("modifier_invoker_emp_custom_teleport") then 
    return 0
end
return self.BaseClass.GetManaCost(self,iLevel) 
end

function invoker_emp_custom:GetBehavior()
local bonus = 0
if self.talents.has_w4 == 1 then 
    bonus = DOTA_ABILITY_BEHAVIOR_AUTOCAST
end 
if self:GetCaster():HasModifier("modifier_invoker_emp_custom_teleport") then 
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_IGNORE_SILENCE_CUSTOM + bonus
end 
return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + bonus
end 

function invoker_emp_custom:ProcCd()
if not IsServer() then return end
if self.talents.has_w7 == 0 then return end
local caster = self:GetCaster()
caster:CdAbility(self, self:GetEffectiveCooldown(self:GetLevel())*self.talents.w7_cd)
end

function invoker_emp_custom:OnSpellStart()
local caster = self:GetCaster()

if caster:HasModifier("modifier_invoker_emp_custom_teleport") and IsValid(self.thinker) then 
    self.thinker:RemoveModifierByName("modifier_invoker_emp_custom")
    return
end 

local point = self:GetCursorPosition()
local delay = self.delay
if self.talents.has_w4 == 1 then
    delay = delay + self.talents.w4_delay
end

local target = Vector(0,0,0)

if self.talents.has_w7 == 1 then 
    point = caster:GetAbsOrigin()
    target = self:GetCursorPosition()
    if target == point then 
        target = caster:GetAbsOrigin() + caster:GetForwardVector()
    end 
    local dir = (target - point):Normalized()
    target = caster:GetAbsOrigin() + dir*self.talents.w7_range
    delay = -1
end 

caster:StartGesture(ACT_DOTA_CAST_EMP)
self.thinker = CreateModifierThinker( caster, self, "modifier_invoker_emp_custom", {x = target.x, y = target.y, duration = delay}, point, caster:GetTeamNumber(), false )
end


modifier_invoker_emp_custom = class(mod_hidden)
function modifier_invoker_emp_custom:OnCreated( kv )
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.teleport = false
self.parent:EmitSound("Hero_Invoker.EMP.Cast")
self.parent:EmitSound("Hero_Invoker.EMP.Charge")

self.creeps_damage = self.ability.creeps_damage
self.mana_burned = self.ability.mana_burned/100
self.self_mana = self.ability.self_mana
self.damage_per_mana_pct = self.ability.damage_per_mana_pct / 100
self.area_of_effect = self.ability.area_of_effect

local abs = self.parent:GetAbsOrigin()
abs.z = abs.z + 100

if self.ability.talents.has_w7 == 1 then 
    self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_invoker/invoker_emp.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
else 
    self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_invoker/invoker_emp.vpcf", PATTACH_WORLDORIGIN, nil )
end 

ParticleManager:SetParticleControl( self.effect_cast, 0, abs )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(self.area_of_effect, 0, 0 ) )
self:AddParticle(self.effect_cast, false, false, -1, false, true)

self.knock_duration = self.ability.talents.w4_knock_duration
self.min_distance = self.ability.talents.w4_min_distance
self.max_distance = self.ability.talents.w4_max_distance

if self.ability.talents.has_w7 == 0 then return end
self.caster:AddNewModifier(self.caster, self.ability, "modifier_invoker_emp_custom_teleport", {})

self.target_point = GetGroundPosition(Vector(kv.x, kv.y, 0), nil)
self.origin_point = self.parent:GetAbsOrigin()

self.origin_point.z = 0
self.target_point.z = 0

self.dir = (self.target_point - self.origin_point):Normalized()
self.speed = self.ability.talents.w7_speed
if self.ability.talents.has_w4 == 1 then
    self.speed = self.speed*(1 + self.ability.talents.w4_speed)
end

self.mana_burned = self.mana_burned*(1 + self.ability.talents.w7_mana)
self.interval = 0.03

self.max_time = (self.target_point - self.origin_point):Length2D()/self.speed

self.caster:UpdateUIshort({max_time = self.max_time, time = (self.max_time - self:GetElapsedTime()), style = "InvokerWex"})
self:StartIntervalThink(self.interval)
end

function modifier_invoker_emp_custom:OnIntervalThink()
if not IsServer() then return end 
if not self.max_time then return end
local original = (self.target_point - self.origin_point):Length2D()
local dist = (self.origin_point - self.parent:GetAbsOrigin()):Length2D()

self.caster:UpdateUIshort({max_time = self.max_time, time = (self.max_time - self:GetElapsedTime()), style = "InvokerWex"})

if (self.parent:GetAbsOrigin() - self.target_point):Length2D() <= 20 then 
    self:Destroy()
    return
end

local dist = self.speed*self.interval*self.dir
local point = GetGroundPosition((self.parent:GetAbsOrigin() + dist), nil)
point.z = point.z + 100

AddFOWViewer(self.caster:GetTeamNumber(), point, self.area_of_effect/2, self.interval, false)
self.parent:SetAbsOrigin(point)
end 

function modifier_invoker_emp_custom:OnDestroy()
if not IsServer() then return end
self.max_time = nil
local parent_abs = self.parent:GetAbsOrigin()

self.parent:EmitSound("Hero_Invoker.EMP.Discharge")
self.caster:UpdateUIshort({hide = 1, style = "InvokerWex", hide_full = 1})

ParticleManager:DestroyParticle(self.effect_cast, true)
ParticleManager:ReleaseParticleIndex(self.effect_cast)

local effect_cast = ParticleManager:CreateParticle( "particles/invoker/emp_legendarya.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl( effect_cast, 0, parent_abs )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.area_of_effect, 0, 0 ) )
ParticleManager:DestroyParticle(effect_cast, false)
ParticleManager:ReleaseParticleIndex(effect_cast)

self.caster:RemoveModifierByName("modifier_invoker_emp_custom_teleport")

if self.ability.talents.has_w4 == 1 and self.ability:GetAutoCastState() and self.caster:IsAlive() and not self.caster:IsRooted() and not self.caster:IsLeashed() then 
    local start_point = self.caster:GetAbsOrigin()

    EmitSoundOnLocationWithCaster(start_point, "Invoker.Tornado_blink_start" , self.caster)
    EmitSoundOnLocationWithCaster(start_point, "Invoker.Tornado_blink_start2" , self.caster)

    local particle = ParticleManager:CreateParticle( "particles/invoker/emp_blink_start.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl(particle, 0,  start_point)
    ParticleManager:ReleaseParticleIndex(particle)

    FindClearSpaceForUnit(self.caster, parent_abs, true)
    ProjectileManager:ProjectileDodge(self.caster)

    local particle4 = ParticleManager:CreateParticle( "particles/items3_fx/blink_arcane_end.vpcf", PATTACH_POINT_FOLLOW, self.caster )
    ParticleManager:SetParticleControlEnt( particle4, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetAbsOrigin(), true )
    ParticleManager:ReleaseParticleIndex(particle4)

    self.caster:StartGesture(ACT_DOTA_CAST_TORNADO)
    self.caster:AddNewModifier(self.caster, self.ability, "modifier_invoker_emp_custom_invun", {duration = self.ability.talents.w4_invun})
    self.caster:EmitSound("Invoker.Tornado_blink_end")
    self.caster:Stop()
    self.teleport = true
end

local damageTable = {attacker = self.caster, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability}
local hit = false

for _,enemy in pairs(self.caster:FindTargets(self.area_of_effect, parent_abs)) do
    local mana_burn = 0

    if enemy:GetMaxMana() > 0 then
        mana_burn = enemy:GetMaxMana()*self.mana_burned
        enemy:Script_ReduceMana(mana_burn, self.ability)
        self.caster:GiveMana(mana_burn * self.self_mana)
        self.caster:SendNumber(11, mana_burn * self.self_mana)
    end
    enemy:GenericParticle("particles/generic_gameplay/generic_manaburn.vpcf")

    local damage = mana_burn * self.damage_per_mana_pct 
    if enemy:IsCreep() then 
        damage = self.creeps_damage
    end

    damageTable.victim = enemy
    damageTable.damage = damage
    DoDamage(damageTable)

    if IsValid(self.caster.invoke_ability) then 
        self.caster.invoke_ability:AbilityHit(enemy)
    end 

    if self.ability.talents.has_w7 == 1 then
        local count = 1
        local mod = enemy:FindModifierByName("modifier_invoker_emp_custom_legendary")
        if mod then
            count = count + mod:GetStackCount()
        end
        enemy:AddNewModifier(self.caster, self.ability, "modifier_invoker_emp_custom_legendary_attacks", {count = count})
        enemy:AddNewModifier(self.caster, self.ability, "modifier_invoker_emp_custom_legendary", {duration = self.ability.talents.w7_duration})
    end

    if self.ability.talents.has_w4 == 1 then 
        if not hit and enemy:IsHero() then
            hit = true
            local mod = self.caster:FindModifierByName("modifier_invoker_chaos_meteor_custom_cataclysm_stack")
            if mod then
                mod:AddStack(self.ability.talents.w4_legendary_stack)
            end
        end

        local direction = enemy:GetOrigin() - parent_abs
        local center = parent_abs
        direction.z = 0
        direction = direction:Normalized()

        if enemy:GetOrigin() == parent_abs then 
            direction = enemy:GetForwardVector()
            center = enemy:GetAbsOrigin() - direction
        end 

        local length = (center - enemy:GetAbsOrigin()):Length2D()
        local distance = math.max(self.min_distance, self.area_of_effect*0.9 - length)

        if not self.teleport then
            center = enemy:GetAbsOrigin() + direction
            local vec = (enemy:GetAbsOrigin() - parent_abs)
            if vec:Length2D() <= self.min_distance then
                distance = vec:Length2D()
            else
                local point = parent_abs + direction*self.min_distance
                distance = (enemy:GetAbsOrigin() - point):Length2D()
            end
        end 

        distance = math.min(distance, self.max_distance)

        local knockbackProperties =
        {
          center_x = center.x,
          center_y = center.y,
          center_z = center.z,
          duration = self.knock_duration,
          knockback_duration = self.knock_duration,
          knockback_distance = distance,
          knockback_height = 0,
          should_stun = 0
        }
        enemy:AddNewModifier( self.caster, self, "modifier_knockback", knockbackProperties )
    end 
end

UTIL_Remove( self.parent)
end

modifier_invoker_emp_custom_invun = class(mod_hidden)
function modifier_invoker_emp_custom_invun:CheckState()
return
{
    [MODIFIER_STATE_INVULNERABLE] = true,
    [MODIFIER_STATE_NO_HEALTH_BAR] = true
}
end

modifier_invoker_emp_custom_teleport = class(mod_hidden)
function modifier_invoker_emp_custom_teleport:RemoveOnDeath() return false end
function modifier_invoker_emp_custom_teleport:OnCreated(table)
if not IsServer() then return end 
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability:EndCd(0)

if IsValid(self.parent.wex_ability) and self.parent.wex_ability.tracker then
    self.parent.wex_ability.tracker:UpdateUI()
end

end 

function modifier_invoker_emp_custom_teleport:OnDestroy()
if not IsServer() then return end 
self.ability:StartCd()

if IsValid(self.parent.wex_ability) and self.parent.wex_ability.tracker then
    self.parent.wex_ability.tracker:UpdateUI()
end

end 





invoker_alacrity_custom = class({})
invoker_alacrity_custom.talents = {}

function invoker_alacrity_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_w1 = 0,
    w1_duration = caster:GetTalentValue("modifier_invoker_wex_1", "duration", true),
    w1_max = caster:GetTalentValue("modifier_invoker_wex_1", "max", true),

    has_w3 = 0,
    w3_duration = 0,

    has_s2 = 0,
    s2_radius = caster:GetTalentValue("modifier_invoker_spells_2", "radius", true),
    s2_bonus = caster:GetTalentValue("modifier_invoker_spells_2", "bonus", true)/100,
  }
end

if caster:HasTalent("modifier_invoker_wex_1") then
  self.talents.has_w1 = 1
end

if caster:HasTalent("modifier_invoker_wex_3") then
  self.talents.has_w3 = 1
  self.talents.w3_duration = caster:GetTalentValue("modifier_invoker_wex_3", "duration")
end

if caster:HasTalent("modifier_invoker_spells_2") then
  self.talents.has_s2 = 1
end

end

function invoker_alacrity_custom:GetCooldown(level)
return self.BaseClass.GetCooldown( self, level ) 
end

function invoker_alacrity_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "invoker_alacrity", self)
end

function invoker_alacrity_custom:GetIntrinsicModifierName()
if self:GetCaster():GetUnitName() == "npc_dota_hero_invoker" then return end
if not self:GetCaster():IsRealHero() then return end
return "modifier_invoker_stolen_ability_tracker"
end

function invoker_alacrity_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

caster:StartGesture(ACT_DOTA_CAST_ALACRITY)

target:RemoveModifierByName("modifier_invoker_alacrity_custom")
target:AddNewModifier( caster, self, "modifier_invoker_alacrity_custom", {active_cast = 1, duration = self.duration + self.talents.w3_duration})
target:EmitSound("Hero_Invoker.Alacrity")
end

modifier_invoker_alacrity_custom = class(mod_visible)
function modifier_invoker_alacrity_custom:OnCreated( table )
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if IsServer() then
    self:SetStackCount(table.active_cast == 1 and 0 or 1)
end

self.bonus_damage = self.ability.bonus_damage
self.bonus_attack_speed = self.ability.bonus_attack_speed
self.damage_reduce = 0

if self:GetStackCount() == 1 then
    self.bonus_damage = self.bonus_damage*self.ability.talents.s2_bonus
    self.bonus_attack_speed = self.bonus_attack_speed*self.ability.talents.s2_bonus
else
    if self.ability.talents.has_w1 == 1 then
        self.caster:AddAttackStartEvent_out(self, true)
    end
end

if not IsServer() then return end
self.parent:GenericParticle(wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_invoker/invoker_alacrity_buff.vpcf", self), self, true)
self.parent:GenericParticle(wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_invoker/invoker_alacrity.vpcf", self), self)
end

function modifier_invoker_alacrity_custom:AttackStartEvent_out(params)
if not IsServer() then return end
if self.ability.talents.has_w1 == 0 then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
if params.no_attack_cooldown then return end

self.caster:AddNewModifier(self.caster, self.ability, "modifier_invoker_alacrity_custom_stats", {duration = self.ability.talents.w1_duration})
end

function modifier_invoker_alacrity_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
}
end

function modifier_invoker_alacrity_custom:GetModifierIncomingDamage_Percentage()
return self.damage_reduce
end

function modifier_invoker_alacrity_custom:GetModifierPreAttack_BonusDamage()
return self.bonus_damage
end

function modifier_invoker_alacrity_custom:GetModifierAttackSpeedBonus_Constant()
return self.bonus_attack_speed
end

function modifier_invoker_alacrity_custom:GetStatusEffectName()
return wearables_system:GetParticleReplacementAbility(self.caster, "particles/status_fx/status_effect_alacrity.vpcf", self)
end

function modifier_invoker_alacrity_custom:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end

function modifier_invoker_alacrity_custom:IsAura() return IsServer() and self.parent:IsAlive() and self:GetStackCount() == 0 and self.caster:HasScepter() and self.ability.talents.has_s2 == 1 end
function modifier_invoker_alacrity_custom:GetAuraDuration() return 0.1 end
function modifier_invoker_alacrity_custom:GetAuraRadius() return self.ability.talents.s2_radius end
function modifier_invoker_alacrity_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_invoker_alacrity_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC end
function modifier_invoker_alacrity_custom:GetModifierAura() return "modifier_invoker_alacrity_custom" end
function modifier_invoker_alacrity_custom:GetAuraEntityReject(target)
return target == self.parent or not target:HasModifier("modifier_forged_spirit_melting_strike_custom_range")
end



invoker_tornado_custom = class({})
invoker_tornado_custom.talents = {}

function invoker_tornado_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_h5 = 0,
    h5_cd = caster:GetTalentValue("modifier_invoker_hero_5", "cd", true),
    h5_silence = caster:GetTalentValue("modifier_invoker_hero_5", "silence", true),
    h5_slow = caster:GetTalentValue("modifier_invoker_hero_5", "slow", true),

    has_s3 = 0,
    s3_timer = caster:GetTalentValue("modifier_invoker_spells_3", "timer", true),
    s3_duration = caster:GetTalentValue("modifier_invoker_spells_3", "duration", true),
  }
end

if caster:HasTalent("modifier_invoker_hero_5") then
    self.talents.has_h5 = 1
end

if caster:HasTalent("modifier_invoker_spells_3") then
    self.talents.has_s3 = 1
end

end

function invoker_tornado_custom:GetCooldown(level)
return self.BaseClass.GetCooldown( self, level ) + (self.talents.has_h5 == 1 and self.talents.h5_cd or 0)
end

function invoker_tornado_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "invoker_tornado", self)
end

function invoker_tornado_custom:GetIntrinsicModifierName()
if self:GetCaster():GetUnitName() == "npc_dota_hero_invoker" then return end
if not self:GetCaster():IsRealHero() then return end
return "modifier_invoker_stolen_ability_tracker"
end

function invoker_tornado_custom:OnSpellStart()
local caster = self:GetCaster()
local point = self:GetCursorPosition()

if point == caster:GetAbsOrigin() then
    point = point + caster:GetForwardVector()
end

caster:StartGesture(ACT_DOTA_CAST_TORNADO)

self.caster_origin = caster:GetOrigin()
self.parent_origin = point
self.direction = self.parent_origin - self.caster_origin
self.direction.z = 0

self.direction = self.direction:Normalized()

self.radius = self.area_of_effect
self.distance = self.travel_distance
self.speed = self.travel_speed
self.vision = self.vision_distance  
self.vision_duration = self.end_vision_duration
self.duration = self.lift_duration

local thinker = CreateModifierThinker( caster, self, "modifier_invoker_tornado_custom_thinker", {}, caster:GetAbsOrigin(), caster:GetTeamNumber(), false )
thinker.hit_targets = {}

local sound = wearables_system:GetSoundReplacement(caster, "Hero_Invoker.Tornado.Cast", self)
EmitSoundOnLocationWithCaster(self.caster_origin, sound, caster)

local tornado_projectile = 
{
    Ability = self,
    EffectName = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_invoker/invoker_tornado.vpcf", self),
    vSpawnOrigin = self.caster_origin,
    fDistance = self.distance,
    fStartRadius = self.radius,
    fEndRadius = self.radius,
    Source = caster,
    bHasFrontalCone = false,
    bReplaceExisting = false,
    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    bDeleteOnHit = false,
    vVelocity = self.direction * self.speed,
    bProvidesVision = true,
    iVisionRadius = self.vision,
    iVisionTeamNumber = caster:GetTeamNumber(),
    fExpireTime = GameRules:GetGameTime() + 10,
    ExtraData = {thinker = thinker:entindex()}
}

ProjectileManager:CreateLinearProjectile(tornado_projectile)
end

function invoker_tornado_custom:OnProjectileHit_ExtraData(target, vLocation, table)
if not IsServer() then return end 
if not table.thinker then return end 

local caster = self:GetCaster()
local thinker = EntIndexToHScript(table.thinker)
if not thinker then return end

AddFOWViewer(caster:GetTeamNumber(), vLocation, self.vision, self.vision_duration, false)

if not target then
    UTIL_Remove(thinker)
    return nil
end

if not thinker.hit_targets[target] then 
    thinker.hit_targets[target] = true
end 

if target:IsCreep() then 
    DoDamage( {victim = target,  attacker = caster, damage = 1, damage_type = DAMAGE_TYPE_PURE, ability = self})
end 

if not target:IsDebuffImmune() then 
    target:InterruptMotionControllers(true)
    local duration = self.duration*(1 - target:GetStatusResistance())
    if self.talents.has_s3 == 1 and caster:HasScepter() then
        duration = self.duration
    end
    target:AddNewModifier(caster, self, "modifier_invoker_tornado_custom", {duration = duration})
end

return false
end

function invoker_tornado_custom:OnProjectileThink_ExtraData(location, data)
if not IsServer() then return end

if data.thinker then
    local thinker = EntIndexToHScript(data.thinker)
    thinker:SetAbsOrigin(location)
end

end


modifier_invoker_tornado_custom = class({})
function modifier_invoker_tornado_custom:IsMotionController() return true end
function modifier_invoker_tornado_custom:GetMotionControllerPriority() return DOTA_MOTION_CONTROLLER_PRIORITY_HIGH end
function modifier_invoker_tornado_custom:OnCreated(kv)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if not IsServer() then return end
local abs = GetGroundPosition(self.parent:GetAbsOrigin(), nil)
self.effect_cast = ParticleManager:CreateParticle(wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_invoker/invoker_tornado_child.vpcf", self), PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( self.effect_cast, 0, abs )
self:AddParticle(self.effect_cast, false, false, -1, false, true)

self.interval = 0.03

self.parent:EmitSound("Hero_Invoker.Tornado.Target" )
self.parent:Purge(true, false, false, false, false)

self.height = 450
self.height_duration = 0.3
self.rotate = 8*self.interval*100
self.height_inc = (self.height/(self.height_duration/self.interval))
self.damage = self.ability.base_damage + self.ability.wex_damage

self.angle = self.parent:GetAngles()
self.abs = self.parent:GetAbsOrigin()
self.cyc_pos = self.parent:GetAbsOrigin()
self:StartIntervalThink(self.interval)
end

function modifier_invoker_tornado_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end

function modifier_invoker_tornado_custom:GetOverrideAnimation()
return ACT_DOTA_FLAIL
end

function modifier_invoker_tornado_custom:OnIntervalThink()
if self.parent:IsDebuffImmune() then self:Destroy() return end
self:HorizontalMotion()
end

function modifier_invoker_tornado_custom:HorizontalMotion()
if not IsServer() then return end
local angle = self.parent:GetAngles()
local new_angle = RotateOrientation(angle, QAngle(0, self.rotate, 0))

self.parent:SetAngles(new_angle[1], new_angle[2], new_angle[3])

if self:GetElapsedTime() <= self.height_duration then
    self.cyc_pos.z = self.cyc_pos.z + self.height_inc
    self.parent:SetAbsOrigin(self.cyc_pos)

elseif self:GetDuration() - self:GetElapsedTime() < self.height_duration then
   
    self.cyc_pos.z = self.cyc_pos.z - self.height_inc*0.9
    self.parent:SetAbsOrigin(self.cyc_pos)
else
    local pos = self.parent:GetAbsOrigin() + RandomVector(4)
    if (pos - self.abs):Length2D() < self.height_inc  then
        self.parent:SetAbsOrigin(pos)
    end
end

end

function modifier_invoker_tornado_custom:OnDestroy()
if not IsServer() then return end
self.parent:Stop()

self.parent:StopSound("Hero_Invoker.Tornado.Target")
self.parent:EmitSound("Hero_Invoker.Tornado.LandDamage")

if not self.parent:IsDebuffImmune() then
    self.parent:SetAbsOrigin(self.abs)
    ResolveNPCPositions(self.parent:GetAbsOrigin(), 128)
    self.parent:SetAngles(self.angle[1], self.angle[2], self.angle[3])
end

if not self.caster or not self.ability then return end

if self.ability.talents.has_s3 == 1 and self.caster:HasScepter() then 
    self.parent:AddNewModifier(self.caster, self.ability, "modifier_invoker_tornado_custom_purge", {duration = self.ability.talents.s3_duration})
end 

if self.parent:IsRealHero() and self.ability.talents.has_s3 == 0 then
    self.parent:AddNewModifier(self.caster, self.ability, "modifier_invoker_tornado_custom_scepter_count", {duration = self.ability.talents.s3_timer})
end

DoDamage({victim = self.parent, attacker = self.caster, damage = self.damage, damage_type = self.ability:GetAbilityDamageType(), ability = self.ability })

if IsValid(self.caster.invoke_ability) then 
    self.caster.invoke_ability:AbilityHit(self.parent)
end 

if self.ability.talents.has_h5 == 1 then 
    self.parent:EmitSound("Sf.Raze_Silence")
    self.parent:AddNewModifier(self.caster, self.ability, "modifier_invoker_tornado_custom_silence", {duration = (1 - self.parent:GetStatusResistance())*self.ability.talents.h5_silence})
end

end

function modifier_invoker_tornado_custom:CheckState()
local state =    
{
    [MODIFIER_STATE_STUNNED] = true,
    [MODIFIER_STATE_INVULNERABLE] = true,
    [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
}
if self.ability.talents.has_h5 == 1 then 
    state[MODIFIER_STATE_SILENCED] = true
end
return state
end



modifier_invoker_tornado_custom_thinker = class(mod_hidden)
function modifier_invoker_tornado_custom_thinker:OnCreated()
if not IsServer() then return end 
self.parent = self:GetParent()
EmitSoundOn("Hero_Invoker.Tornado_custom", self.parent)
end 

function modifier_invoker_tornado_custom_thinker:OnDestroy()
if not IsServer() then return end
if not IsValid(self.parent) then return end 
StopSoundOn("Hero_Invoker.Tornado_custom", self.parent)
end


modifier_invoker_tornado_custom_silence = class(mod_hidden)
function modifier_invoker_tornado_custom_silence:IsPurgable() return true end
function modifier_invoker_tornado_custom_silence:GetEffectName() return "particles/generic_gameplay/generic_silenced.vpcf" end
function modifier_invoker_tornado_custom_silence:ShouldUseOverheadOffset() return true end
function modifier_invoker_tornado_custom_silence:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end
function modifier_invoker_tornado_custom_silence:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_invoker_tornado_custom_silence:CheckState()
return
{
    [MODIFIER_STATE_SILENCED] = true,
}
end

function modifier_invoker_tornado_custom_silence:GetModifierMoveSpeedBonus_Percentage()
return self.move
end 

function modifier_invoker_tornado_custom_silence:OnCreated()
self.move = self:GetAbility().talents.h5_slow
if not IsServer() then return end
self:GetParent():GenericParticle("particles/void_astral_slow.vpcf", self)
end





modifier_invoker_alacrity_custom_stats = class(mod_visible)
function modifier_invoker_alacrity_custom_stats:GetTexture() return "buffs/invoker/wex_1" end
function modifier_invoker_alacrity_custom_stats:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.talents.w1_max
if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_invoker_alacrity_custom_stats:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_invoker_alacrity_custom_stats:OnStackCountChanged()
if not IsServer() then return end
self.parent:CalculateStatBonus(true)
end

function modifier_invoker_alacrity_custom_stats:OnDestroy()
if not IsServer() then return end
self.parent:CalculateStatBonus(true)
end


modifier_invoker_tornado_custom_purge = class(mod_visible)
function modifier_invoker_tornado_custom_purge:GetEffectName() return "particles/items4_fx/nullifier_mute_debuff.vpcf" end 
function modifier_invoker_tornado_custom_purge:GetStatusEffectName() return "particles/status_fx/status_effect_nullifier.vpcf" end 
function modifier_invoker_tornado_custom_purge:StatusEffectPriority() return MODIFIER_PRIORITY_SUPER_ULTRA  end 
function modifier_invoker_tornado_custom_purge:OnCreated()
if not IsServer() then return end 
self.parent = self:GetParent()

self.parent:EmitSound("Invoker.Scepter_tornado")
self.parent:GenericParticle("particles/items4_fx/nullifier_mute.vpcf", self, true)

self:OnIntervalThink()
self:StartIntervalThink(0.1)
end 

function modifier_invoker_tornado_custom_purge:OnIntervalThink()
if not IsServer() then return end 
if self.parent:IsDebuffImmune() then return end
self.parent:Purge(true, false, false, false,false)
end 


modifier_invoker_emp_custom_legendary = class(mod_visible)
function modifier_invoker_emp_custom_legendary:OnCreated()
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.max = self.ability.talents.w7_max - 1

if not IsServer() then return end 

if self.ability.talents.has_q7 == 0 then
    self.effect_cast = self.parent:GenericParticle("particles/invoker/emp_stack.vpcf", self, true)
end

self:SetStackCount(1)
end

function modifier_invoker_emp_custom_legendary:OnRefresh()
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 
self:IncrementStackCount()
end

function modifier_invoker_emp_custom_legendary:OnStackCountChanged(iStackCount)
if not IsServer() then return end
if not self.effect_cast then return end
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )
end



modifier_invoker_emp_custom_legendary_attacks = class(mod_hidden)
function modifier_invoker_emp_custom_legendary_attacks:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_invoker_emp_custom_legendary_attacks:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.interval = 0.2
self.count = table.count
self:StartIntervalThink(self.interval)
end

function modifier_invoker_emp_custom_legendary_attacks:OnIntervalThink()
if not IsServer() then return end
if not self.caster:IsAlive() then
    self:Destroy()
    return
end

self.caster:AddNewModifier(self.caster, self.ability, "modifier_invoker_emp_custom_legendary_damage", {})
self.caster:PerformAttack(self.parent, true, true, true, true, false, false, false)
self.caster:RemoveModifierByName("modifier_invoker_emp_custom_legendary_damage")

self.parent:EmitSound("Invoker.Emp_legendary_attack")
self.parent:GenericParticle("particles/invoker/wex_legendary_attack.vpcf")

self.count = self.count - 1
if self.count <= 0 then
    self:Destroy()
    return
end

end


modifier_invoker_emp_custom_legendary_damage = class(mod_hidden)
function modifier_invoker_emp_custom_legendary_damage:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.damage = self.ability.talents.w7_damage - 100
end

function modifier_invoker_emp_custom_legendary_damage:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_invoker_emp_custom_legendary_damage:GetModifierTotalDamageOutgoing_Percentage(params)
if params.inflictor then return end
return self.damage
end




modifier_invoker_tornado_custom_scepter_count = class(mod_hidden)
function modifier_invoker_tornado_custom_scepter_count:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.parent:AddDamageEvent_inc(self, true)
end

function modifier_invoker_tornado_custom_scepter_count:DamageEvent_inc(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end
local attacker = params.attacker
if attacker.owner then
    attacker = attacker.owner
end

if attacker ~= self.caster then return end
if not IsValid(self.caster.invoke_ability) then return end
if params.damage <= 0 then return end

self.caster.invoke_ability.tracker:ScepterEvent("modifier_invoker_spells_3", params.damage)
end


modifier_invoker_alacrity_custom_damage = class(mod_visible)
function modifier_invoker_alacrity_custom_damage:GetTexture() return "buffs/invoker/wex_3" end
function modifier_invoker_alacrity_custom_damage:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self.max = 5
self.duration = self.ability.talents.w3_effect_duration
self:AddStack()
end

function modifier_invoker_alacrity_custom_damage:OnRefresh()
if not IsServer() then return end
self:AddStack()
end

function modifier_invoker_alacrity_custom_damage:OnStackCountChanged(params)
if not IsServer() then return end

if self:GetStackCount() >= self.max and not self.effect_cast then
    self.effect_cast =  self.parent:GenericParticle("particles/invoker/alacrity_max.vpcf", self)
end

if self:GetStackCount() < self.max and self.effect_cast then
    ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast)
    self.effect_cast = nil
end

end

function modifier_invoker_alacrity_custom_damage:AddStack()
if not IsServer() then return end

self:IncrementStackCount()
Timers:CreateTimer(self.duration, function()
    if IsValid(self) then
        self:DecrementStackCount()
        if self:GetStackCount() <= 0 then
            self:Destroy()
            return
        end
    end
end)

end

function modifier_invoker_alacrity_custom_damage:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
}
end

function modifier_invoker_alacrity_custom_damage:GetModifierAttackSpeedBonus_Constant()
return self.ability.talents.w3_bonus*self:GetStackCount()
end

function modifier_invoker_alacrity_custom_damage:GetModifierPreAttack_BonusDamage()
return self.ability.talents.w3_bonus*self:GetStackCount()
end