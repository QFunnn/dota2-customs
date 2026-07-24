--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pangolier_shield_crash_custom_tracker", "abilities/pangolier/pangolier_shield_crash_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_shield_crash_custom_buff", "abilities/pangolier/pangolier_shield_crash_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_shield_crash_custom_slow", "abilities/pangolier/pangolier_shield_crash_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_shield_crash_custom_scepter", "abilities/pangolier/pangolier_shield_crash_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_shield_crash_custom_immune", "abilities/pangolier/pangolier_shield_crash_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_shield_crash_custom_damage", "abilities/pangolier/pangolier_shield_crash_custom", LUA_MODIFIER_MOTION_NONE)

pangolier_shield_crash_custom = class({})


function pangolier_shield_crash_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_tailthump_cast.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_tailthump.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_tailthump_hero.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_egg.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_streaks.vpcf", context )
PrecacheResource( "particle","particles/jugg_parry.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_snapfire_slow.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_tailthump_cast.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_tailthump.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/blink_overwhelming_burst.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/blink_overwhelming_burst.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_swashbuckler.vpcf", context )
PrecacheResource( "particle","particles/mars_revenge_proc_hands.vpcf", context )
PrecacheResource( "particle","particles/lc_odd_proc_.vpcf", context )
PrecacheResource( "particle","particles/lc_lowhp.vpcf", context )
end


function pangolier_shield_crash_custom:UpdateTalents()
local caster = self:GetCaster()

if caster:HasTalent("modifier_pangolier_shield_3") then 
  caster:AddPercentStat({str = caster:GetTalentValue("modifier_pangolier_shield_3", "str")/100}, self.tracker)
end

end 


function pangolier_shield_crash_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_pangolier_shield_crash_custom_tracker"
end

function pangolier_shield_crash_custom:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel)
end

function pangolier_shield_crash_custom:GetBehavior()
if self:GetCaster():HasTalent("modifier_pangolier_shield_5") then 
    return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end

function pangolier_shield_crash_custom:GetManaCost(level)
if self:GetCaster():HasTalent("modifier_pangolier_shield_5") then 
    return 0
end 
return self.BaseClass.GetManaCost(self,level)
end

function pangolier_shield_crash_custom:GetDamage()
return self:GetSpecialValueFor("damage") + self:GetCaster():GetTalentValue("modifier_pangolier_shield_3", "damage")*self:GetCaster():GetStrength()/100
end

function pangolier_shield_crash_custom:GetAOERadius()
return self:GetSpecialValueFor("radius")
end

function pangolier_shield_crash_custom:GetCastRange(vLocation, hTarget)
local range = self:GetSpecialValueFor("jump_horizontal_distance")
if self:GetCaster():HasTalent("modifier_pangolier_shield_5") then 
    range = range + self:GetCaster():GetTalentValue("modifier_pangolier_shield_5", "distance")
end
if IsServer() then 
    return 999999
else 
    return range - self:GetCaster():GetCastRangeBonus()
end
end


function pangolier_shield_crash_custom:OnSpellStart(is_legendary)

local caster = self:GetCaster()
local distance = self:GetSpecialValueFor("jump_horizontal_distance")
local duration = self:GetSpecialValueFor("jump_duration")
local height = self:GetSpecialValueFor("jump_height")
local radius = self:GetSpecialValueFor("radius")
local buff_duration = self:GetSpecialValueFor("duration")
local slow_duration = self:GetSpecialValueFor("slow_duration") + caster:GetTalentValue("modifier_pangolier_shield_2", "duration")

local damage = self:GetDamage()

local passive = caster:FindAbilityByName("pangolier_lucky_shot_custom")
local ulti = caster:FindAbilityByName("pangolier_gyroshell_custom")

if caster:HasTalent("modifier_pangolier_shield_5") and not is_legendary then 
    local point = self:GetCursorPosition()
    if point == caster:GetAbsOrigin() then 
        point = caster:GetAbsOrigin() + caster:GetForwardVector()*10
    end

    local dir = point - caster:GetAbsOrigin()
    local dist = distance + caster:GetTalentValue("modifier_pangolier_shield_5", "distance")

    if dir:Length2D() > dist then 
        point = caster:GetAbsOrigin() + dir:Normalized()*dist
    end

    dir.z = 0

    caster:SetForwardVector(dir:Normalized())
    caster:FaceTowards(caster:GetAbsOrigin() + dir:Normalized()*10)
    distance = (point - caster:GetAbsOrigin()):Length2D()
end

caster:StartGesture(ACT_DOTA_CAST_ABILITY_2)
caster:EmitSound("Hero_Pangolier.TailThump.Cast")

local ulti_mod = caster:FindModifierByName("modifier_pangolier_gyroshell_custom")
if ulti_mod  then 
    duration = self:GetSpecialValueFor("jump_duration_gyroshell")
    height = self:GetSpecialValueFor("jump_height_gyroshell")
    distance = ulti_mod.max_speed*duration
end

if caster:HasModifier("modifier_pangolier_rollup_custom") then 
    duration = self:GetSpecialValueFor("jump_duration_gyroshell")
    height = self:GetSpecialValueFor("jump_height_gyroshell")
    distance = 1
    caster:StartGesture(ACT_DOTA_RUN)
end

if caster:IsRooted() or caster:IsStunned() or caster:IsLeashed() then  
    distance = 1
    height = height*0.7
end

local speed = math.max(1, distance/duration)
local point = caster:GetAbsOrigin() + caster:GetForwardVector()*distance

local arc = caster:AddNewModifier( caster, self, "modifier_generic_arc",
{
  target_x = point.x,
  target_y = point.y,
  distance = distance,
  speed = speed,
  height = height,
  fix_end = false,
  isStun = true,

})

caster:GenericParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump_cast.vpcf", arc)

local swash = caster:FindAbilityByName("pangolier_swashbuckle_custom")
if swash and swash:GetLevel() > 0 and caster:HasScepter() and not is_legendary then 
    caster:AddNewModifier(caster, swash, "modifier_pangolier_swashbuckle_custom_scepter", {})
end

if not arc then return end

arc:SetEndCallback(function()

    if not caster:HasModifier(("modifier_pangolier_gyroshell_custom")) then 
        caster:FadeGesture(ACT_DOTA_RUN)
    else 
        caster:AddNewModifier(caster, ulti, "modifier_pangolier_gyroshell_custom_turn_boost", {duration = ulti:GetSpecialValueFor("jump_recover_time")})
    end

    local enemies = caster:FindTargets(radius)

    if not is_legendary then 
        caster:AddNewModifier(caster, self, "modifier_pangolier_shield_crash_custom_buff", {duration = buff_duration})
    else 
        local mod = caster:FindModifierByName("modifier_pangolier_shield_crash_custom_buff")
        if #enemies > 0 and mod and mod.legendary_stacks then 
            mod.legendary_stacks = mod.legendary_stacks + 1
        end
    end

    for _,enemy in pairs(enemies) do
        if passive and passive:GetLevel() > 0 then 
            passive:ProcPassive(enemy, false)
        end
        if swash and caster:HasTalent("modifier_pangolier_buckle_4") then 
            enemy:AddNewModifier(caster, swash, "modifier_pangolier_swashbuckle_custom_blood", {duration = caster:GetTalentValue("modifier_pangolier_buckle_4", "duration")})
        end
        enemy:AddNewModifier(caster, self, "modifier_pangolier_shield_crash_custom_slow", {duration = (1 - enemy:GetStatusResistance())*slow_duration})
        DoDamage({victim = enemy, attacker = caster, ability = self, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL })
    end

    local smash = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump_hero.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(smash, 0, caster:GetAbsOrigin())
    ParticleManager:DestroyParticle(smash, false)
    ParticleManager:ReleaseParticleIndex(smash)
    EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), "Hero_Pangolier.TailThump", caster)
end)

end





modifier_pangolier_shield_crash_custom_buff = class({})

function modifier_pangolier_shield_crash_custom_buff:IsHidden() return false end
function modifier_pangolier_shield_crash_custom_buff:IsPurgable() return false end
function modifier_pangolier_shield_crash_custom_buff:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max_shield = self.ability:GetSpecialValueFor("hero_stacks") + self.parent:GetMaxHealth()*self.parent:GetTalentValue("modifier_pangolier_shield_1", "shield")/100

self.regen = self.parent:GetTalentValue("modifier_pangolier_shield_6", "heal")

if not IsServer() then return end

self.RemoveForDuel = true
self:SetStackCount(self.max_shield)
self.ability:EndCd()

if self.parent:HasTalent("modifier_pangolier_shield_6") then 
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_shield_crash_custom_immune", {duration = self.parent:GetTalentValue("modifier_pangolier_shield_6", "duration")})
end 

if self.parent:HasTalent("modifier_pangolier_shield_7") and not self.ability:IsHidden() then 
    self.parent:SwapAbilities("pangolier_shield_crash_custom", "pangolier_shield_crash_custom_legendary", false, true)
end

if self.parent:HasTalent("modifier_pangolier_shield_1") then 
    self.parent:AddDamageEvent_out(self)
end

if self.parent:HasTalent("modifier_pangolier_shield_7") then 
    self.parent:AddSpellEvent(self)
end

self.cd_inc = false
self.cd_duration = self.parent:GetTalentValue("modifier_pangolier_shield_4", "duration")
self.cd_timer = self.parent:GetTalentValue("modifier_pangolier_shield_4", "timer")
self.cd_reduce = self.parent:GetTalentValue("modifier_pangolier_shield_4", "cd_inc")

self.heal = self.parent:GetTalentValue("modifier_pangolier_shield_1", "heal")/100
self.heal_creeps = self.parent:GetTalentValue("modifier_pangolier_shield_1", "creeps")

self.damage_reduce = self.parent:GetTalentValue("modifier_pangolier_shield_6", "damage_reduce", true)/100

self.time = self:GetRemainingTime()
self.legendary_stacks = 0

self.damage = 0
self.buff_particles = {}

self.parent:EmitSound("Hero_Pangolier.TailThump.Shield")

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

self:SetHasCustomTransmitterData(true)
self:OnIntervalThink()
self:StartIntervalThink(0.1)
end




function modifier_pangolier_shield_crash_custom_buff:GetModifierIncomingDamageConstant( params )
if self:GetStackCount() == 0 then return end

if IsClient() then 
    if params.report_max then 
        return self.max_shield
    else 
        return self:GetStackCount()
    end 
end

if not IsServer() then return end

local damage = math.min(params.damage, self:GetStackCount())

local real_damage = damage
if self.parent:HasModifier("modifier_pangolier_shield_crash_custom_immune") then 
    real_damage = real_damage*(1 + self.damage_reduce)

    self.parent:EmitSound("Juggernaut.Parry")
    local particle = ParticleManager:CreateParticle( "particles/jugg_parry.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
    ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_attack1", self.parent:GetAbsOrigin(), true )
    ParticleManager:SetParticleControl( particle, 1, self.parent:GetAbsOrigin() )
    ParticleManager:ReleaseParticleIndex(particle)
end

if self.parent:GetQuest() == "Pangolier.Quest_6" and params.attacker:IsRealHero() then 
    self.parent:UpdateQuest(math.abs(damage))
end
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self:SetStackCount(self:GetStackCount() - real_damage)
if self:GetStackCount() <= 0 then
  self:Destroy()
end

return -damage
end




function modifier_pangolier_shield_crash_custom_buff:DamageEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end 
if not params.unit:IsUnit() then return end
if params.unit:IsIllusion() then return end 
if params.damage < 0 then return end

local shield_k = self.heal

if params.unit:IsCreep() then 
    shield_k = shield_k/self.heal_creeps
end 

self:SetStackCount(math.min(self.max_shield, self:GetStackCount() + shield_k*params.damage))
end 


function modifier_pangolier_shield_crash_custom_buff:SpellEvent(params)
if not IsServer() then return end
if params.unit ~= self.parent then return end
if params.ability:IsItem() then return end
if params.ability:GetName() == "pangolier_shield_crash_custom_legendary" then return end

self.legendary_stacks = self.legendary_stacks + 1
end



function modifier_pangolier_shield_crash_custom_buff:OnIntervalThink()
if not IsServer() then return end

if self.parent:HasTalent("modifier_pangolier_shield_4") and self.cd_inc == false and self:GetElapsedTime() >= self.cd_timer then 
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_shield_crash_custom_damage", {duration = self.cd_duration})
    self.cd_inc = true
end 

if self.parent:HasTalent("modifier_pangolier_shield_7") then 
    self.parent:UpdateUIshort({max_time = self.time, time = self:GetRemainingTime(), stack = self.legendary_stacks, style = "PangolierShield"})
end

end

function modifier_pangolier_shield_crash_custom_buff:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
    MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
}
end

function modifier_pangolier_shield_crash_custom_buff:GetModifierHealthRegenPercentage()
if not self.parent:HasTalent("modifier_pangolier_shield_6") then return end 
return self.regen
end



function modifier_pangolier_shield_crash_custom_buff:OnDestroy()
if not IsServer() then return end

if self.parent:HasTalent("modifier_pangolier_shield_7") then
    if self.ability:IsHidden() then 
        self.parent:SwapAbilities("pangolier_shield_crash_custom", "pangolier_shield_crash_custom_legendary", true, false)
    end

    self.parent:UpdateUIshort({hide = 1, hide_full = 1, style = "PangolierShield"})

    if self.legendary_stacks > 0 then 

        local radius = self.parent:GetTalentValue("modifier_pangolier_shield_7", "radius")
        local damage = self.legendary_stacks*self.ability:GetDamage()*self.parent:GetTalentValue("modifier_pangolier_shield_7", "damage")/100

        for _,target in pairs(self.parent:FindTargets(radius)) do 
            DoDamage({victim = target, attacker = self.parent, ability = self.ability, damage = damage, damage_type = DAMAGE_TYPE_PURE}, "modifier_pangolier_shield_7")
        end

        local smash = ParticleManager:CreateParticle(part, PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(smash, 0, self.parent:GetAbsOrigin())
        ParticleManager:DestroyParticle(smash, false)
        ParticleManager:ReleaseParticleIndex(smash)

        EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "Pango.Shield_legendary", self.parent)
        EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "Pango.Shield_legendary2", self.parent)

        for i = 1,2 do 
            local smash2 = ParticleManager:CreateParticle("particles/items3_fx/blink_overwhelming_burst.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager:SetParticleControl(smash2, 0, self.parent:GetAbsOrigin())
            ParticleManager:SetParticleControl(smash2, 1, Vector(radius*(i * 0.5), radius*(i * 0.5), radius*(i * 0.5)))
            ParticleManager:DestroyParticle(smash2, false)
            ParticleManager:ReleaseParticleIndex(smash2)
        end
    end
end

if self.parent:HasTalent("modifier_pangolier_shield_5") then 
    self.parent:GenericParticle("particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf")
    self.parent:Purge(false, true, false, true, true)
    self.parent:EmitSound("Pango.Shield_purge")
end

self.ability:StartCd()

if self.cd_inc == true then 
    self.parent:CdAbility(self.ability, self.cd_reduce)
end

end





pangolier_shield_crash_custom_legendary = class({})

function pangolier_shield_crash_custom_legendary:GetCooldown()
return self:GetCaster():GetTalentValue("modifier_pangolier_shield_7", "cd")
end


function pangolier_shield_crash_custom_legendary:OnSpellStart()
local caster = self:GetCaster()
local ability = caster:FindAbilityByName("pangolier_shield_crash_custom")
local mod = caster:FindModifierByName("modifier_pangolier_shield_crash_custom_buff")

if not mod or not ability then 
    return
end

ability:OnSpellStart(true)
end






modifier_pangolier_shield_crash_custom_slow = class({})

function modifier_pangolier_shield_crash_custom_slow:IsPurgable() return true end
function modifier_pangolier_shield_crash_custom_slow:IsHidden() return false end


function modifier_pangolier_shield_crash_custom_slow:OnCreated(table)
self.slow = self:GetAbility():GetSpecialValueFor("slow")*-1
self.damage_reduce = self:GetCaster():GetTalentValue("modifier_pangolier_shield_2", "damage_reduce")
end

function modifier_pangolier_shield_crash_custom_slow:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_pangolier_shield_crash_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_pangolier_shield_crash_custom_slow:GetModifierDamageOutgoing_Percentage()
return self.damage_reduce
end

function modifier_pangolier_shield_crash_custom_slow:GetModifierSpellAmplify_Percentage()
return self.damage_reduce
end

function modifier_pangolier_shield_crash_custom_slow:GetEffectName()
return "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf"
end

function modifier_pangolier_shield_crash_custom_slow:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_pangolier_shield_crash_custom_slow:GetStatusEffectName()
return "particles/status_fx/status_effect_snapfire_slow.vpcf"
end

function modifier_pangolier_shield_crash_custom_slow:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL
end












modifier_pangolier_shield_crash_custom_tracker = class({})
function modifier_pangolier_shield_crash_custom_tracker:IsHidden() return true end
function modifier_pangolier_shield_crash_custom_tracker:IsPurgable() return false end


function modifier_pangolier_shield_crash_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

end







modifier_pangolier_shield_crash_custom_immune = class({})
function modifier_pangolier_shield_crash_custom_immune:IsHidden() return true end
function modifier_pangolier_shield_crash_custom_immune:IsPurgable() return false end
function modifier_pangolier_shield_crash_custom_immune:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()

self:SetStackCount(0)

self.particle = ParticleManager:CreateParticle("particles/pangolier/linken_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
self:AddParticle(self.particle, false, false, -1, false, false)
end


function modifier_pangolier_shield_crash_custom_immune:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ABSORB_SPELL,
    MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_pangolier_shield_crash_custom_immune:GetAbsorbSpell(params) 
if self:GetStackCount() == 1 then return end 
if params.ability:GetCaster():GetTeamNumber() == self.parent:GetTeamNumber() then return end

self:SetStackCount(1)

local particle = ParticleManager:CreateParticle("particles/pangolier/linken_proc.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(particle)

if self.particle then 
    ParticleManager:DestroyParticle(self.particle, true)
    ParticleManager:ReleaseParticleIndex(self.particle)
end

self.parent:EmitSound("DOTA_Item.LinkensSphere.Activate")
return 1 
end





modifier_pangolier_shield_crash_custom_damage = class({})
function modifier_pangolier_shield_crash_custom_damage:IsHidden() return false end
function modifier_pangolier_shield_crash_custom_damage:IsPurgable() return false end
function modifier_pangolier_shield_crash_custom_damage:GetTexture() return "buffs/shield_damage" end
function modifier_pangolier_shield_crash_custom_damage:OnCreated()

self.parent = self:GetParent()

self.damage = self.parent:GetTalentValue("modifier_pangolier_shield_4", "damage")

if not IsServer() then return end 

self.parent:GenericParticle("particles/lc_odd_proc_.vpcf")
self.parent:GenericParticle("particles/lc_lowhp.vpcf", self)

self.parent:EmitSound("Pango.Shield_damage_proc")
self.parent:EmitSound("Pango.Shield_damage_proc2")
end 


function modifier_pangolier_shield_crash_custom_damage:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_pangolier_shield_crash_custom_damage:GetModifierSpellAmplify_Percentage()
return self.damage
end

function modifier_pangolier_shield_crash_custom_damage:GetModifierDamageOutgoing_Percentage()
return self.damage
end