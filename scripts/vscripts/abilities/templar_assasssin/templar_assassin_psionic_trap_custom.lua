--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_templar_assassin_psionic_trap_custom_counter", "abilities/templar_assasssin/templar_assassin_psionic_trap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_psionic_trap_custom_trap", "abilities/templar_assasssin/templar_assassin_psionic_trap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_psionic_trap_custom_trap_debuff", "abilities/templar_assasssin/templar_assassin_psionic_trap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_psionic_trap_custom_trap_stun", "abilities/templar_assasssin/templar_assassin_psionic_trap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_psionic_trap_custom_trap_stun_cd", "abilities/templar_assasssin/templar_assassin_psionic_trap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_psionic_trap_custom_trap_legendary", "abilities/templar_assasssin/templar_assassin_psionic_trap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_psionic_trap_custom_trap_legendary_explosion", "abilities/templar_assasssin/templar_assassin_psionic_trap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_psionic_trap_custom_trap_legendary_heal_reduce", "abilities/templar_assasssin/templar_assassin_psionic_trap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_psionic_trap_custom_trap_speed", "abilities/templar_assasssin/templar_assassin_psionic_trap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_psionic_trap_custom_trap_cdr", "abilities/templar_assasssin/templar_assassin_psionic_trap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_psionic_trap_custom_trap_double", "abilities/templar_assasssin/templar_assassin_psionic_trap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_psionic_trap_custom_trap_double_effect", "abilities/templar_assasssin/templar_assassin_psionic_trap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_psionic_trap_custom_trap_double_attack", "abilities/templar_assasssin/templar_assassin_psionic_trap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_psionic_trap_custom_trap_scepter", "abilities/templar_assasssin/templar_assassin_psionic_trap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_psionic_trap_custom_trap_scepter_delay", "abilities/templar_assasssin/templar_assassin_psionic_trap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_psionic_trap_custom_trap_scepter_caster", "abilities/templar_assasssin/templar_assassin_psionic_trap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_psionic_trap_custom_trap_invun", "abilities/templar_assasssin/templar_assassin_psionic_trap_custom", LUA_MODIFIER_MOTION_NONE )


templar_assassin_psionic_trap_custom = class({})


function templar_assassin_psionic_trap_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/items3_fx/blink_arcane_start.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/blink_arcane_end.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_templar_assassin/templar_assassin_trap_explode.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_templar_assassin/templar_assassin_trap.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_templar_assassin/templar_assassin_trap_slow.vpcf", context )
PrecacheResource( "particle","particles/pa_vendetta.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_dark_seer_normal_punch_replica.vpcf", context )
PrecacheResource( "particle","particles/ta_trap_target.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_templar_assassin/templar_assassin_meld_armor.vpcf", context )
PrecacheResource( "particle","particles/ta_timer.vpcf", context )
PrecacheResource( "particle","particles/ta_trap_damage.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_faceless_chronosphere.vpcf", context )
PrecacheResource( "particle","particles/ta_psi_speed.vpcf", context )
PrecacheResource( "particle","particles/templar_assassin/double_attack.vpcf", context )
PrecacheResource( "particle","particles/templar_assassin/trap_stack.vpcf", context )
PrecacheResource( "particle","particles/templar_assasin/trap_refresh.vpcf", context )


end



function templar_assassin_psionic_trap_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_templar_assassin_psionic_trap_custom_counter"
end


function templar_assassin_psionic_trap_custom:GetCooldown(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_templar_assassin_psionic_2") then 
    bonus = self:GetCaster():GetTalentValue("modifier_templar_assassin_psionic_2", "cd")
end
return self.BaseClass.GetCooldown( self, level ) + bonus
end

function templar_assassin_psionic_trap_custom:GetMaxTime()
local max_timer = self:GetSpecialValueFor("trap_max_charge_duration")
if self:GetCaster():HasTalent("modifier_templar_assassin_psionic_2") then 
    max_timer = max_timer + self:GetCaster():GetTalentValue("modifier_templar_assassin_psionic_2", "charge")
end
return max_timer
end


function templar_assassin_psionic_trap_custom:GetCastPoint()
local bonus = 0
if self:GetCaster():HasTalent("modifier_templar_assassin_psionic_6") then 
    bonus = self:GetCaster():GetTalentValue("modifier_templar_assassin_psionic_6", "cast")
end
return self.BaseClass.GetCastPoint(self) + bonus
end


function templar_assassin_psionic_trap_custom:OnSpellStart()
if not IsServer() then return end

local caster = self:GetCaster()

if caster:HasTalent("modifier_templar_assassin_psionic_3") then
    caster:AddNewModifier(caster, self, "modifier_templar_assassin_psionic_trap_custom_trap_speed", {duration = caster:GetTalentValue("modifier_templar_assassin_psionic_3", "duration")})
end

if caster:HasTalent("modifier_templar_assassin_psionic_4") then
    caster:AddNewModifier(caster, self, "modifier_templar_assassin_psionic_trap_custom_trap_double", {duration = caster:GetTalentValue("modifier_templar_assassin_psionic_4", "duration")})
end

self:SetTrap(self:GetCursorPosition())
end







function templar_assassin_psionic_trap_custom:SetTrap(point, scepter)
if not IsServer() then return end

local caster = self:GetCaster()
caster:EmitSound("Hero_TemplarAssassin.Trap.Cast")


if not self.counter_modifier or self.counter_modifier:IsNull() then
    self.counter_modifier = caster:FindModifierByName("modifier_templar_assassin_psionic_trap_custom_counter")
end

if not self.counter_modifier or self.counter_modifier:IsNull() or not self.counter_modifier.trap_count then
    return
end

local trap_modifier = nil

if scepter ~= nil then

    local illusions = CreateIllusions( caster, caster, {duration=scepter, outgoing_damage= -100,incoming_damage=0}, 1, 0, false, false )  
    for _,illusion in pairs(illusions) do
        illusion.owner = caster
        illusion:SetControllableByPlayer(caster:GetPlayerOwnerID(), false)

        FindClearSpaceForUnit(illusion, point, true)
        illusion:EmitSound("Hero_TemplarAssassin.Trap")

        trap_modifier = illusion:AddNewModifier(caster, self, "modifier_templar_assassin_psionic_trap_custom_trap_scepter", {})
    end
else
    local trap = CreateUnitByName("npc_dota_templar_assassin_psionic_trap", point, false, nil, nil, caster:GetTeamNumber())
    trap.is_crystal = true
    trap.owner = caster
    FindClearSpaceForUnit(trap, trap:GetAbsOrigin(), false)

    trap_modifier = trap:AddNewModifier(caster, self, "modifier_templar_assassin_psionic_trap_custom_trap", {})
    trap:SetControllableByPlayer(caster:GetPlayerOwnerID(), true)

    EmitSoundOnLocationWithCaster(point, "Hero_TemplarAssassin.Trap", caster)

    local remove_default = trap:FindAbilityByName("templar_assassin_self_trap")
    if remove_default then
        trap:RemoveAbility("templar_assassin_self_trap")
    end

    local custom_ability = trap:AddAbility("templar_assassin_self_trap_custom")

    if trap:HasAbility("templar_assassin_self_trap_custom") then
        trap:FindAbilityByName("templar_assassin_self_trap_custom"):SetHidden(false)
        trap:FindAbilityByName("templar_assassin_self_trap_custom"):SetLevel(self:GetLevel())
    end
end

if not trap_modifier then return end

table.insert(self.counter_modifier.trap_count, trap_modifier)
local max_traps = self:GetSpecialValueFor("max_traps")

if #self.counter_modifier.trap_count > max_traps then
    if self.counter_modifier.trap_count[1]:GetParent() then
        self.counter_modifier.trap_count[1]:GetParent():ForceKill(false)
    end
end

self.counter_modifier:SetStackCount(#self.counter_modifier.trap_count)
end



function templar_assassin_psionic_trap_custom:ExplodeTrap(point, timer_k, is_legendary)
if not IsServer() then return end

local caster = self:GetCaster()
local k = math.min(timer_k, 1)

local min_silence = self:GetSpecialValueFor("shard_min_silence")
local max_silence = self:GetSpecialValueFor("shard_max_silence")

local explode_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_templar_assassin/templar_assassin_trap_explode.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(explode_particle, 0, point)
ParticleManager:ReleaseParticleIndex(explode_particle)

EmitSoundOnLocationWithCaster(point, "Hero_TemplarAssassin.Trap.Explode", caster)

local radius = self:GetSpecialValueFor("trap_radius")
local duration = self:GetSpecialValueFor("trap_duration_tooltip")
local damage_duration = duration


local stun = caster:GetTalentValue("modifier_templar_assassin_psionic_5", "stun", true)
local stun_cd = caster:GetTalentValue("modifier_templar_assassin_psionic_5", "cd", true)
local stun_sound = false

local legendary_duration = caster:GetTalentValue("modifier_templar_assassin_psionic_7", "heal_duration", true)
local legendary_max = caster:GetTalentValue("modifier_templar_assassin_psionic_7", "max", true)

local silence_duration = min_silence + (max_silence - min_silence) * k
local targets = caster:FindTargets(radius, point) 
local hit_hero = false


local damage = self:GetSpecialValueFor("trap_bonus_damage") + caster:GetTalentValue("modifier_templar_assassin_psionic_1", "damage")*caster:GetAverageTrueAttackDamage(nil)/100
local damage_heal = caster:GetTalentValue("modifier_templar_assassin_psionic_1", "heal")/100
local heal_creeps = caster:GetTalentValue("modifier_templar_assassin_psionic_1", "creeps", true)
local damageTable = {attacker = caster, damage = damage, ability = self, damage_type = DAMAGE_TYPE_MAGICAL}


for _, enemy in pairs(targets) do

    enemy:RemoveModifierByName("modifier_templar_assassin_psionic_trap_custom_trap_debuff")
    enemy:AddNewModifier(caster, self, "modifier_templar_assassin_psionic_trap_custom_trap_debuff", {duration = duration *(1 - enemy:GetStatusResistance()), k = k})
    
    if caster:HasShard() then
        enemy:AddNewModifier(caster, self, "modifier_generic_silence", {duration = silence_duration*(1 - enemy:GetStatusResistance())})
    end

    if k >= 0.99 then 

        if enemy:IsRealHero() then
            hit_hero = true
        end

        damageTable.victim = enemy
        local real_damage = DoDamage(damageTable)

        local legendary_mod = enemy:FindModifierByName("modifier_templar_assassin_psionic_trap_custom_trap_legendary")
        if legendary_mod and not is_legendary then

            if legendary_mod:GetStackCount() >= legendary_max then
                enemy:AddNewModifier(caster, self, "modifier_templar_assassin_psionic_trap_custom_trap_legendary_heal_reduce", {duration = legendary_duration})
            end

            enemy:AddNewModifier(caster, self, "modifier_templar_assassin_psionic_trap_custom_trap_legendary_explosion", {stack = legendary_mod:GetStackCount()})
            legendary_mod:Destroy()
        end

        if caster:IsAlive() and caster:HasTalent("modifier_templar_assassin_psionic_1") and not enemy:IsIllusion() then 
            local heal = real_damage*damage_heal
            if enemy:IsCreep() then
                heal = heal/heal_creeps
            end
            caster:GenericHeal(heal, self, true, "particles/items3_fx/octarine_core_lifesteal.vpcf", "modifier_templar_assassin_psionic_1")
        end

        if caster:HasTalent("modifier_templar_assassin_psionic_5") then
            enemy:Purge(true, false, false, false, false)
            enemy:GenericParticle("particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf")
            stun_sound = true
            if not enemy:HasModifier("modifier_templar_assassin_psionic_trap_custom_trap_stun_cd") then 
                enemy:AddNewModifier(caster, self, "modifier_templar_assassin_psionic_trap_custom_trap_stun_cd", {duration = stun_cd})
                enemy:AddNewModifier(caster, self, "modifier_templar_assassin_psionic_trap_custom_trap_stun", {duration = stun*(1 - enemy:GetStatusResistance())})
            end 
        end
    end 
end

if stun_sound == true then
    EmitSoundOnLocationWithCaster(point, "TA.Trap_stun", caster)
end


if #targets > 0 and k >= 0.99 then    
    if caster:HasTalent("modifier_templar_assassin_psionic_4") then
        caster:AddNewModifier(caster, self, "modifier_templar_assassin_psionic_trap_custom_trap_double", {duration = caster:GetTalentValue("modifier_templar_assassin_psionic_4", "duration")})
    end
end

if hit_hero == true then
    if caster:HasTalent("modifier_templar_assassin_psionic_6") then
        caster:CdItems(caster:GetTalentValue("modifier_templar_assassin_psionic_6", "cd_items"))
    end
    caster:AddNewModifier(caster, self, "modifier_templar_assassin_psionic_trap_custom_trap_cdr", {})
end

end


modifier_templar_assassin_psionic_trap_custom_trap_invun = class({})
function modifier_templar_assassin_psionic_trap_custom_trap_invun:IsPurgable() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_invun:IsHidden() return true end
function modifier_templar_assassin_psionic_trap_custom_trap_invun:CheckState()
return
{
    [MODIFIER_STATE_NO_HEALTH_BAR_FOR_ENEMIES] = true,
    [MODIFIER_STATE_UNTARGETABLE_ENEMY] = true 
}
end


modifier_templar_assassin_psionic_trap_custom_trap = class({})
function modifier_templar_assassin_psionic_trap_custom_trap:IsHidden() return true end
function modifier_templar_assassin_psionic_trap_custom_trap:IsPurgable() return false end
function modifier_templar_assassin_psionic_trap_custom_trap:OnCreated(params)
if not IsServer() then return end

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.charged = params.charged
self.vision = self.ability:GetSpecialValueFor("vision_radius")
self.invis_timer = self.ability:GetSpecialValueFor("trap_fade_time")
self.max_timer = self.ability:GetMaxTime()

self.parent:AddAttackEvent_inc(self)

self.trap_counter_modifier = self.caster:FindModifierByName("modifier_templar_assassin_psionic_trap_custom_counter")
self.activated = false
self.invis = false
self.timer = 0

if self.caster:HasShard() then
    self.parent:AddNewModifier(self.caster, self.ability, "modifier_templar_assassin_psionic_trap_custom_trap_invun", {duration = self.ability:GetSpecialValueFor("shard_invun")})
end

self.health = 4
self.parent:SetHealth(self.health)

self.self_particle  = ParticleManager:CreateParticle("particles/units/heroes/hero_templar_assassin/templar_assassin_trap.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.self_particle, 60, Vector(96, 0, 132))
ParticleManager:SetParticleControl(self.self_particle, 61, Vector(1, 0, 0))
self:AddParticle(self.self_particle, false, false, -1, false, false)

self.interval = 0.1
self:StartIntervalThink(self.interval)
end


function modifier_templar_assassin_psionic_trap_custom_trap:OnDestroy()
if not IsServer() then return end
if not self.trap_counter_modifier or self.trap_counter_modifier:IsNull() or not self.trap_counter_modifier.trap_count then return end

for trap_modifier = 1, #self.trap_counter_modifier.trap_count do
    if self.trap_counter_modifier.trap_count[trap_modifier] == self then
        table.remove(self.trap_counter_modifier.trap_count, trap_modifier)
        self.trap_counter_modifier:DecrementStackCount()
        break
    end
end

end

function modifier_templar_assassin_psionic_trap_custom_trap:CheckState()
return 
{
    [MODIFIER_STATE_INVISIBLE]          = self.invis,
    [MODIFIER_STATE_NO_UNIT_COLLISION]  = true,
    [MODIFIER_STATE_SPECIALLY_DENIABLE] = true,
}
end

function modifier_templar_assassin_psionic_trap_custom_trap:Explode()
if not IsServer() then return end

self.ability:ExplodeTrap(self.parent:GetAbsOrigin(), self.timer/self.max_timer)

self.parent:ForceKill(false)

if not self:IsNull() then
    self:Destroy()
end

end

function modifier_templar_assassin_psionic_trap_custom_trap:OnIntervalThink()
if not IsServer() then return end

AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), self.vision, self.interval, false)


if self.activated and self.invis then return end

self.timer = self.timer + self.interval

if self.timer >= self.invis_timer then
    self.invis = true
end
if self.activated == true then return end

if self.timer >= self.max_timer then
    self.activated = true
    ParticleManager:SetParticleControl(self.self_particle, 60, Vector(0, 0, 0))
    ParticleManager:SetParticleControl(self.self_particle, 61, Vector(0, 0, 0))
end

end

function modifier_templar_assassin_psionic_trap_custom_trap:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    MODIFIER_PROPERTY_HEALTHBAR_PIPS 
}
end

function modifier_templar_assassin_psionic_trap_custom_trap:GetAbsoluteNoDamagePhysical() return 1 end
function modifier_templar_assassin_psionic_trap_custom_trap:GetAbsoluteNoDamagePure() return 1 end
function modifier_templar_assassin_psionic_trap_custom_trap:GetAbsoluteNoDamageMagical() return 1 end
function modifier_templar_assassin_psionic_trap_custom_trap:GetModifierHealthBarPips()  return 2 end
function modifier_templar_assassin_psionic_trap_custom_trap:GetModifierIncomingDamage_Percentage() return -100 end


function modifier_templar_assassin_psionic_trap_custom_trap:AttackEvent_inc(params, self_attack)
if not IsServer() then return end

local target = params.target
if self_attack then
    target = params.unit
end
local attacker = params.attacker
if not target then return end
if self.parent ~= target then return end
if attacker:GetTeamNumber() == self.parent:GetTeamNumber() and not self_attack then return end

local damage = 4
if attacker:IsRangedAttacker() then
    damage = 2
end
if attacker:IsCreep() then
    damage = 1
end

self.health = self.health - damage
if self.health > 0 then 
    self.parent:SetHealth(self.health)
else
    self.parent:Kill(nil, attacker)
end

end





modifier_templar_assassin_psionic_trap_custom_counter = class({})

function modifier_templar_assassin_psionic_trap_custom_counter:OnCreated()
self.trap_count = {}
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.range_bonus = self.parent:GetTalentValue("modifier_templar_assassin_psionic_5", "range", true)

self.legendary_chance = self.parent:GetTalentValue("modifier_templar_assassin_psionic_7", "chance", true)
self.legendary_duration = self.parent:GetTalentValue("modifier_templar_assassin_psionic_7", "duration", true)

self.double_delay = self.parent:GetTalentValue("modifier_templar_assassin_psionic_4", "delay", true)
self.records = {}

if not IsServer() then return end

self.parent:AddRecordDestroyEvent(self)
self.parent:AddAttackStartEvent_out(self)
self.parent:AddAttackEvent_out(self)

end




function modifier_templar_assassin_psionic_trap_custom_counter:AttackEvent_out(params)
if not IsServer() then return end

if self.parent == params.attacker and self.parent:HasTalent("modifier_templar_assassin_psionic_7") and params.target:IsUnit() then
    if RollPseudoRandomPercentage(self.legendary_chance,2942,self.parent) then
        params.target:AddNewModifier(self.parent, self.ability, "modifier_templar_assassin_psionic_trap_custom_trap_legendary", {duration = self.legendary_duration})
    end
end

end


function modifier_templar_assassin_psionic_trap_custom_counter:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
}
end

function modifier_templar_assassin_psionic_trap_custom_counter:GetModifierCastRangeBonusStacking()
if not self.parent:HasTalent("modifier_templar_assassin_psionic_5") then return end 
return self.range_bonus
end


function modifier_templar_assassin_psionic_trap_custom_counter:AttackStartEvent_out(params)
if not IsServer() then return end 
if self.parent ~= params.attacker then return end 
if not params.target:IsUnit() then return end 
if params.target:GetUnitName() == "npc_psi_blades_crystal_mini" then return end

if self.parent:HasModifier("modifier_templar_assassin_psionic_trap_custom_trap_double_effect") then 
    self.records[params.record] = true
end 

local mod = self.parent:FindModifierByName("modifier_templar_assassin_psionic_trap_custom_trap_double")
if not self.parent:HasTalent("modifier_templar_assassin_psionic_4") then return end
if not mod then return end
if params.no_attack_cooldown then return end 

mod:DecrementStackCount()
if mod:GetStackCount() == 0 then 
    mod:Destroy()
end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_templar_assassin_psionic_trap_custom_trap_double_attack", {target = params.target:entindex(), duration = self.double_delay})
end 



function modifier_templar_assassin_psionic_trap_custom_counter:RecordDestroyEvent(params)
if not IsServer() then return end
if not self.records[params.record] then return end
self.records[params.record] = nil
end




templar_assassin_self_trap_custom = class({})



function templar_assassin_self_trap_custom:OnSpellStart()

local modifier = self:GetCaster():FindModifierByName("modifier_templar_assassin_psionic_trap_custom_trap")
if modifier then
    modifier:Explode()
end

end





templar_assassin_trap_custom  = class({})

function templar_assassin_trap_custom:OnSpellStart()
if not IsServer() then return end

if not self.trap_ability then
    self.trap_ability = self:GetCaster():FindAbilityByName("templar_assassin_psionic_trap_custom")
end

if not self.counter_modifier or self.counter_modifier:IsNull() then
    self.counter_modifier = self:GetCaster():FindModifierByName("modifier_templar_assassin_psionic_trap_custom_counter")
end


if self.trap_ability and self.counter_modifier and self.counter_modifier.trap_count and #self.counter_modifier.trap_count > 0 then

    local search_point = self:GetCaster():GetAbsOrigin()

    if self:GetAutoCastState() == true then 
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID()), "get_cursor_position", {ability = "templar_assassin_trap_custom"} ) 
    else 
        self:GetCursor(search_point)
    end

end 

end

function templar_assassin_trap_custom:GetCursor(search_point)
if not IsServer() then return end

local distance  = nil
local index     = nil
for trap_number = 1, #self.counter_modifier.trap_count do
    if self.counter_modifier.trap_count[trap_number] and not self.counter_modifier.trap_count[trap_number]:IsNull() then
        if not distance then
            index       = trap_number
            distance    = (search_point - self.counter_modifier.trap_count[trap_number]:GetParent():GetAbsOrigin()):Length2D()

        else
            if ((search_point - self.counter_modifier.trap_count[trap_number]:GetParent():GetAbsOrigin()):Length2D() < distance) then
                index       = trap_number
                distance    = (search_point - self.counter_modifier.trap_count[trap_number]:GetParent():GetAbsOrigin()):Length2D()
            end
        end
    end
end
if index then
    self.counter_modifier.trap_count[index]:Explode()
end

end



templar_assassin_trap_teleport_custom = class({})


function templar_assassin_trap_teleport_custom:GetBehavior()
if self:GetCaster():HasModifier("modifier_templar_assassin_psionic_trap_custom_trap_scepter_caster") then 
    return DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
end 
return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE
end 

function templar_assassin_trap_teleport_custom:GetManaCost(level)
if self:GetCaster():HasModifier("modifier_templar_assassin_psionic_trap_custom_trap_scepter_caster") then 
    return 0
end 
return self.BaseClass.GetManaCost(self,level)
end


function templar_assassin_trap_teleport_custom:GetCastRange(vLocation, hTarget)
if self:GetCaster():HasModifier("modifier_templar_assassin_psionic_trap_custom_trap_scepter_caster") then 
    return 0
end 

if IsClient() then 
    return self:GetSpecialValueFor( "range" ) 
end
return 99999
end



function templar_assassin_trap_teleport_custom:OnSpellStart()
local caster = self:GetCaster()

local mod = caster:FindModifierByName("modifier_templar_assassin_psionic_trap_custom_trap_scepter_caster")

if mod then 
    if mod.illusion and not mod.illusion:IsNull() then
        local illusion_mod = mod.illusion:FindModifierByName("modifier_templar_assassin_psionic_trap_custom_trap_scepter")
        if illusion_mod then
            illusion_mod:Explode(1)
        end
    end
    mod:Destroy()
    return
end

local ability = caster:FindAbilityByName("templar_assassin_psionic_trap_custom")

if ability then

    local point = self:GetCursorPosition()
    local origin = caster:GetAbsOrigin()

    if point == origin then
        point = origin + caster:GetForwardVector() 
    end

    local dist = self:GetSpecialValueFor("range") + caster:GetCastRangeBonus()
    local vec = point - caster:GetAbsOrigin()

    if vec:Length2D() > dist then
        point = origin + vec:Normalized()*dist
    end

    ability:SetTrap(point, self:GetSpecialValueFor("scepter_duration"))
end

self:EndCd(0)
self:StartCooldown(0.3)
end




modifier_templar_assassin_psionic_trap_custom_trap_debuff = class({})
function modifier_templar_assassin_psionic_trap_custom_trap_debuff:IsPurgable() return true end
function modifier_templar_assassin_psionic_trap_custom_trap_debuff:GetTexture()  return "templar_assassin_psionic_trap" end
function modifier_templar_assassin_psionic_trap_custom_trap_debuff:GetEffectName() return "particles/units/heroes/hero_templar_assassin/templar_assassin_trap_slow.vpcf" end

function modifier_templar_assassin_psionic_trap_custom_trap_debuff:OnCreated(params)
if not IsServer() then return end
if not params.k then return end

self.movement_speed_min = self:GetAbility():GetSpecialValueFor("movement_speed_min")
self.movement_speed_max = self:GetAbility():GetSpecialValueFor("movement_speed_max")

self.caster = self:GetCaster()
self.main_ability = self:GetAbility()
self.max_timer = self.main_ability:GetMaxTime()
self.movespeed_reduced = (self.movement_speed_min + (self.movement_speed_max - self.movement_speed_min)*params.k) + self.caster:GetTalentValue("modifier_templar_assassin_psionic_3", "slow")

self:SetStackCount(self.movespeed_reduced)
end


function modifier_templar_assassin_psionic_trap_custom_trap_debuff:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end


function modifier_templar_assassin_psionic_trap_custom_trap_debuff:GetModifierMoveSpeedBonus_Percentage()
return self:GetStackCount()*-1
end






modifier_templar_assassin_psionic_trap_custom_trap_legendary = class({})
function modifier_templar_assassin_psionic_trap_custom_trap_legendary:IsHidden() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_legendary:IsPurgable() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_legendary:GetTexture() return "buffs/coil_resist" end
function modifier_templar_assassin_psionic_trap_custom_trap_legendary:OnCreated()

self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.max = self.caster:GetTalentValue("modifier_templar_assassin_psionic_7", "max")
self.exploded = false

if not IsServer() then return end

self.effect_cast = self.parent:GenericParticle("particles/templar_assassin/trap_stack.vpcf", self, true)

self:SetStackCount(1)
end


function modifier_templar_assassin_psionic_trap_custom_trap_legendary:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
if self.exploded == true then return end

self:IncrementStackCount()

if self:GetStackCount() >= self.max then
    self.parent:GenericParticle("particles/ta_trap_target.vpcf", self)
end

end


function modifier_templar_assassin_psionic_trap_custom_trap_legendary:OnStackCountChanged(iStackCount)
if self:GetStackCount() == 0 then return end
if not self.effect_cast then return end
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )
end






modifier_templar_assassin_psionic_trap_custom_trap_legendary_explosion = class({})
function modifier_templar_assassin_psionic_trap_custom_trap_legendary_explosion:IsHidden() return true end
function modifier_templar_assassin_psionic_trap_custom_trap_legendary_explosion:IsPurgable() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_legendary_explosion:RemoveOnDeath() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_legendary_explosion:OnCreated(table)

self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.parent = self:GetParent()

if not IsServer() then return end

self:SetStackCount(table.stack)
self:StartIntervalThink(0.1)
end



function modifier_templar_assassin_psionic_trap_custom_trap_legendary_explosion:OnIntervalThink()
if not IsServer() then return end

local point = self.parent:GetAbsOrigin() + RandomVector(RandomInt(50, 250))
self.ability:ExplodeTrap(point, 1, true)

self:DecrementStackCount()
if self:GetStackCount() <= 0 then
    self:Destroy()
end

end







modifier_templar_assassin_psionic_trap_custom_trap_legendary_heal_reduce = class({})
function modifier_templar_assassin_psionic_trap_custom_trap_legendary_heal_reduce:IsHidden() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_legendary_heal_reduce:IsPurgable() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_legendary_heal_reduce:GetTexture() return "buffs/coil_resist" end
function modifier_templar_assassin_psionic_trap_custom_trap_legendary_heal_reduce:OnCreated()

self.caster = self:GetCaster()
self.parent = self:GetParent()

self.reduce = self.caster:GetTalentValue("modifier_templar_assassin_psionic_7", "heal_reduce")
end


function modifier_templar_assassin_psionic_trap_custom_trap_legendary_heal_reduce:DeclareFunctions()
return
{
    --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
    --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end


function modifier_templar_assassin_psionic_trap_custom_trap_legendary_heal_reduce:GetModifierLifestealRegenAmplify_Percentage() 
return self.reduce
end

function modifier_templar_assassin_psionic_trap_custom_trap_legendary_heal_reduce:GetModifierHealChange() 
return self.reduce
end

function modifier_templar_assassin_psionic_trap_custom_trap_legendary_heal_reduce:GetModifierHPRegenAmplify_Percentage() 
return self.reduce
end

function modifier_templar_assassin_psionic_trap_custom_trap_legendary_heal_reduce:GetEffectName()
return "particles/items4_fx/spirit_vessel_damage.vpcf"
end







modifier_templar_assassin_psionic_trap_custom_trap_stun = class({})
function modifier_templar_assassin_psionic_trap_custom_trap_stun:IsHidden() return true end
function modifier_templar_assassin_psionic_trap_custom_trap_stun:IsPurgable() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_stun:IsStunDebuff() return true end
function modifier_templar_assassin_psionic_trap_custom_trap_stun:IsPurgeException() return true end
function modifier_templar_assassin_psionic_trap_custom_trap_stun:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH  end
function modifier_templar_assassin_psionic_trap_custom_trap_stun:GetStatusEffectName() return "particles/status_fx/status_effect_faceless_chronosphere.vpcf" end
function modifier_templar_assassin_psionic_trap_custom_trap_stun:CheckState()
return
{
    [MODIFIER_STATE_FROZEN] = true,
    [MODIFIER_STATE_STUNNED] = true
}
end


modifier_templar_assassin_psionic_trap_custom_trap_stun_cd = class({})

function modifier_templar_assassin_psionic_trap_custom_trap_stun_cd:IsHidden() return true end
function modifier_templar_assassin_psionic_trap_custom_trap_stun_cd:IsPurgable() return false end





modifier_templar_assassin_psionic_trap_custom_trap_speed = class({})
function modifier_templar_assassin_psionic_trap_custom_trap_speed:IsHidden() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_speed:IsPurgable() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_speed:GetTexture() return "buffs/Step_mark" end
function modifier_templar_assassin_psionic_trap_custom_trap_speed:OnCreated()
self.speed = self:GetCaster():GetTalentValue("modifier_templar_assassin_psionic_3", "speed")
end

function modifier_templar_assassin_psionic_trap_custom_trap_speed:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_templar_assassin_psionic_trap_custom_trap_speed:GetModifierAttackSpeedBonus_Constant()
return self.speed
end







modifier_templar_assassin_psionic_trap_custom_trap_cdr = class({})
function modifier_templar_assassin_psionic_trap_custom_trap_cdr:IsHidden() return not self:GetCaster():HasTalent("modifier_templar_assassin_psionic_6") end
function modifier_templar_assassin_psionic_trap_custom_trap_cdr:IsPurgable() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_cdr:RemoveOnDeath() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_cdr:GetTexture() return "buffs/wrath_perma" end
function modifier_templar_assassin_psionic_trap_custom_trap_cdr:OnCreated(table)

self.parent = self:GetParent()

self.max = self.parent:GetTalentValue("modifier_templar_assassin_psionic_6", "max", true)
self.cdr = self.parent:GetTalentValue("modifier_templar_assassin_psionic_6", "cdr", true)

if not IsServer() then return end
self:SetStackCount(1)
self:StartIntervalThink(0.5)
end

function modifier_templar_assassin_psionic_trap_custom_trap_cdr:OnIntervalThink()
if not IsServer() then return end 
if self:GetStackCount() < self.max then return end
if not self.parent:HasTalent("modifier_templar_assassin_psionic_6") then return end

self.parent:GenericParticle("particles/lc_odd_proc_.vpcf")
self.parent:EmitSound("BS.Thirst_legendary_active")
self:StartIntervalThink(-1)
end 

function modifier_templar_assassin_psionic_trap_custom_trap_cdr:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_templar_assassin_psionic_trap_custom_trap_cdr:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
}
end


function modifier_templar_assassin_psionic_trap_custom_trap_cdr:GetModifierPercentageCooldown() 
if not self.parent:HasTalent("modifier_templar_assassin_psionic_6") then return end
return self:GetStackCount()*self.cdr
end






modifier_templar_assassin_psionic_trap_custom_trap_double_effect = class({})
function modifier_templar_assassin_psionic_trap_custom_trap_double_effect:IsHidden() return true end
function modifier_templar_assassin_psionic_trap_custom_trap_double_effect:IsPurgable() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_double_effect:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_PROJECTILE_NAME,
    MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_templar_assassin_psionic_trap_custom_trap_double_effect:GetPriority()
return MODIFIER_PRIORITY_NORMAL
end

function modifier_templar_assassin_psionic_trap_custom_trap_double_effect:GetModifierProjectileName()
return "particles/templar_assassin/double_attack.vpcf"
end

function modifier_templar_assassin_psionic_trap_custom_trap_double_effect:GetPriority()
return 9999999
end

function modifier_templar_assassin_psionic_trap_custom_trap_double_effect:GetModifierDamageOutgoing_Percentage()
return self.damage
end

function modifier_templar_assassin_psionic_trap_custom_trap_double_effect:OnCreated()
self.parent = self:GetParent()
self.damage = self.parent:GetTalentValue("modifier_templar_assassin_psionic_4", "damage") - 100
end





modifier_templar_assassin_psionic_trap_custom_trap_double = class({})
function modifier_templar_assassin_psionic_trap_custom_trap_double:IsHidden() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_double:IsPurgable() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_double:GetTexture() return "buffs/Shift_attacks" end
function modifier_templar_assassin_psionic_trap_custom_trap_double:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
}
end


function modifier_templar_assassin_psionic_trap_custom_trap_double:GetModifierAttackRangeBonus()
return self.range
end

function modifier_templar_assassin_psionic_trap_custom_trap_double:OnCreated()
self.parent = self:GetParent()
self.stack = self.parent:GetTalentValue("modifier_templar_assassin_psionic_4", "attacks")
self.max = self.parent:GetTalentValue("modifier_templar_assassin_psionic_4", "max")
self.range = self.parent:GetTalentValue("modifier_templar_assassin_psionic_4", "range")

if not IsServer() then return end
self:SetStackCount(self.stack)
end


function modifier_templar_assassin_psionic_trap_custom_trap_double:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

self:SetStackCount(math.min(self.max, self:GetStackCount() + self.stack))
end




modifier_templar_assassin_psionic_trap_custom_trap_double_attack = class({})
function modifier_templar_assassin_psionic_trap_custom_trap_double_attack:IsHidden() return true end
function modifier_templar_assassin_psionic_trap_custom_trap_double_attack:IsPurgable() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_double_attack:RemoveOnDeath() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_double_attack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_templar_assassin_psionic_trap_custom_trap_double_attack:OnCreated(table)
if not IsServer() then return end 
self.parent = self:GetParent()
self.target = EntIndexToHScript(table.target)
end 

function modifier_templar_assassin_psionic_trap_custom_trap_double_attack:OnDestroy()
if not IsServer() then return end
if not self.target then return end
if self.target:IsNull() then return end 

self.parent:EmitSound("TA.Trap_double")
self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_templar_assassin_psionic_trap_custom_trap_double_effect", {duration = FrameTime()})
self.parent:PerformAttack(self.target, true, true, true, true, true, false, false)
self.parent:RemoveModifierByName("modifier_templar_assassin_psionic_trap_custom_trap_double_effect")
end 



modifier_templar_assassin_psionic_trap_custom_trap_scepter = class({})
function modifier_templar_assassin_psionic_trap_custom_trap_scepter:IsHidden() return true end
function modifier_templar_assassin_psionic_trap_custom_trap_scepter:IsPurgable() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_scepter:GetStatusEffectName() return "particles/status_fx/status_effect_dark_seer_normal_punch_replica.vpcf" end
function modifier_templar_assassin_psionic_trap_custom_trap_scepter:StatusEffectPriority() return MODIFIER_PRIORITY_ILLUSION end
function modifier_templar_assassin_psionic_trap_custom_trap_scepter:CheckState()
return
{
    [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    [MODIFIER_STATE_INVULNERABLE] = true,
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    [MODIFIER_STATE_UNSLOWABLE] = true,
    [MODIFIER_STATE_DISARMED] = true,
    [MODIFIER_STATE_UNTARGETABLE] = true,
}
end


function modifier_templar_assassin_psionic_trap_custom_trap_scepter:OnCreated()

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.main_ability = self.caster:FindAbilityByName("templar_assassin_trap_teleport_custom")

self.speed = self.main_ability:GetSpecialValueFor("scepter_speed")
self.duration = self.main_ability:GetSpecialValueFor("scepter_duration")
self.max_timer = self.ability:GetMaxTime()


if not IsServer() then return end

self.exploded = false
self.range = self.parent:Script_GetAttackRange()*-1

self.caster:AddNewModifier(self.caster, self.main_ability, "modifier_templar_assassin_psionic_trap_custom_trap_scepter_caster", {duration = self.duration, illusion = self.parent:entindex()})

self.trap_counter_modifier = self.caster:FindModifierByName("modifier_templar_assassin_psionic_trap_custom_counter")
self.parent:AddNewModifier(self.parent, self.ability, "modifier_templar_assassin_psionic_trap_custom_trap_scepter_delay", {duration = self.max_timer})

self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_templar_assassin/templar_assassin_meld_armor.vpcf", PATTACH_POINT_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
self:AddParticle(self.particle, false, false, -1, false, false)

self.interval = 0.5
self.t = -1

self.timer = self.duration*2 
self:StartIntervalThink(self.interval)
self:OnIntervalThink()
end



function modifier_templar_assassin_psionic_trap_custom_trap_scepter:OnDestroy()
if not IsServer() then return end

self.caster:RemoveModifierByName("modifier_templar_assassin_psionic_trap_custom_trap_scepter_caster")

if not self.trap_counter_modifier or self.trap_counter_modifier:IsNull() or not self.trap_counter_modifier.trap_count then return end

for trap_modifier = 1, #self.trap_counter_modifier.trap_count do 
    if self.trap_counter_modifier.trap_count[trap_modifier] == self then
        table.remove(self.trap_counter_modifier.trap_count, trap_modifier)
        self.trap_counter_modifier:DecrementStackCount()
        break
    end
end

if self.exploded == false then
    self:Explode(0)
end

end

function modifier_templar_assassin_psionic_trap_custom_trap_scepter:Explode(teleport)
if not IsServer() then return end

self.exploded = true

local k = 1
local mod = self.parent:FindModifierByName("modifier_templar_assassin_psionic_trap_custom_trap_scepter_delay")
if mod then
    k = mod:GetElapsedTime()/self.max_timer
end

if teleport == 1 then
    local start_point = self.caster:GetAbsOrigin()
    local point = self.parent:GetAbsOrigin()

    ProjectileManager:ProjectileDodge(self.caster)

    EmitSoundOnLocationWithCaster( start_point, "Hero_Antimage.Blink_out", self.caster )

    local effect = ParticleManager:CreateParticle("particles/items3_fx/blink_arcane_start.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect, 0, start_point)

    effect = ParticleManager:CreateParticle("particles/items3_fx/blink_arcane_end.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect, 0, point)

    self.caster:SetAbsOrigin(point)
    FindClearSpaceForUnit(self.caster, point, true)

    self.caster:SetForwardVector(self.parent:GetForwardVector())
    self.caster:FaceTowards(self.caster:GetAbsOrigin() + self.parent:GetForwardVector()*10)

    self.ability:ExplodeTrap(start_point, k)

    self.caster:Stop()
end

self.ability:ExplodeTrap(self.parent:GetAbsOrigin(), k)
self.parent:ForceKill(false)

if not self:IsNull() then
    self:Destroy()
end

end


function modifier_templar_assassin_psionic_trap_custom_trap_scepter:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
    MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
}
end

function modifier_templar_assassin_psionic_trap_custom_trap_scepter:GetModifierAttackRangeBonus()
if not IsServer() then return end
if not self.range then return end
return self.range
end

function modifier_templar_assassin_psionic_trap_custom_trap_scepter:GetModifierMoveSpeed_Absolute()
return self.speed
end

function modifier_templar_assassin_psionic_trap_custom_trap_scepter:AddEffect()
if not IsServer() then return end

self.parent:GenericParticle("particles/ta_trap_target.vpcf", self)
self.parent:EmitSound("TA.Scepter_active")
end

function modifier_templar_assassin_psionic_trap_custom_trap_scepter:OnIntervalThink()
if not IsServer() then return end

self.t = self.t + 1

local number = (self.timer-self.t)/2 
local int = 0
int = number
if number % 1 ~= 0 then int = number - 0.5 end

local digits = math.floor(math.log10(number)) + 2

local decimal = number % 1

if decimal == 0.5 then
  decimal = 8
else 
  decimal = 1
end

local particle = ParticleManager:CreateParticle("particles/ta_timer.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(particle, 1, Vector(0, int, decimal))
ParticleManager:SetParticleControl(particle, 2, Vector(digits, 0, 0))
ParticleManager:ReleaseParticleIndex(particle)
end





modifier_templar_assassin_psionic_trap_custom_trap_scepter_delay = class({})
function modifier_templar_assassin_psionic_trap_custom_trap_scepter_delay:IsHidden() return true end
function modifier_templar_assassin_psionic_trap_custom_trap_scepter_delay:IsPurgable() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_scepter_delay:OnDestroy()
if not IsServer() then return end

local mod = self:GetParent():FindModifierByName("modifier_templar_assassin_psionic_trap_custom_trap_scepter")

if mod then
    mod:AddEffect()
end

end





modifier_templar_assassin_psionic_trap_custom_trap_scepter_caster = class({})
function modifier_templar_assassin_psionic_trap_custom_trap_scepter_caster:IsHidden() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_scepter_caster:IsPurgable() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_scepter_caster:RemoveOnDeath() return false end
function modifier_templar_assassin_psionic_trap_custom_trap_scepter_caster:OnCreated(table)
self.caster = self:GetCaster()

if not IsServer() then return end
self.illusion = EntIndexToHScript(table.illusion)
end


function modifier_templar_assassin_psionic_trap_custom_trap_scepter_caster:OnDestroy()
if not IsServer() then return end
self:GetAbility():StartCd()
end
