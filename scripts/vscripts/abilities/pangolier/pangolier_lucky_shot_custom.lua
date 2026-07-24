--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pangolier_lucky_shot_custom_tracker", "abilities/pangolier/pangolier_lucky_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_lucky_shot_custom_disarm", "abilities/pangolier/pangolier_lucky_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_lucky_shot_custom_dash", "abilities/pangolier/pangolier_lucky_shot_custom", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_pangolier_lucky_shot_custom_silence_cd", "abilities/pangolier/pangolier_lucky_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_lucky_shot_custom_legendary", "abilities/pangolier/pangolier_lucky_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_lucky_shot_custom_legendary_proc", "abilities/pangolier/pangolier_lucky_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_lucky_shot_custom_legendary_caster", "abilities/pangolier/pangolier_lucky_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_lucky_shot_custom_speed", "abilities/pangolier/pangolier_lucky_shot_custom", LUA_MODIFIER_MOTION_NONE)

pangolier_lucky_shot_custom = class({})


function pangolier_lucky_shot_custom:CreateTalent(name)

local caster = self:GetCaster()

if name == "modifier_pangolier_lucky_7" then 
    if caster:HasTalent("modifier_pangolier_rolling_7") then 
        if not caster:HasModifier("modifier_pangolier_gyroshell_custom") then 
            caster:SwapAbilities("pangolier_gyroshell_custom_legendary", "pangolier_heartpiercer_custom", false, true )
        else 
            return
        end 
        
    else 
        if caster:FindAbilityByName("pangolier_heartpiercer_custom") then 
            caster:FindAbilityByName("pangolier_heartpiercer_custom"):SetHidden(false)
        end
    end 
end

end



function pangolier_lucky_shot_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_luckyshot_disarm_cast.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_luckyshot_disarm_debuff.vpcf", context )
PrecacheResource( "particle","particles/items_fx/force_staff.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_swashbuckler_dash.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_swashbuckler.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_heartpiercer_delay.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_life_stealer_open_wounds.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/sange_maim.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", context )
PrecacheResource( "particle","particles/heroes/pango_v/pangolier_heartpiercer_v_front_models.vpcf", context )
PrecacheResource( "particle","particles/heroes/pango_v/pangolier_heartpiercer_v_right_models.vpcf", context )
PrecacheResource( "particle","particles/heroes/pango_v/pangolier_heartpiercer_v_back_models.vpcf", context )
PrecacheResource( "particle","particles/heroes/pango_v/pangolier_heartpiercer_v_left_models.vpcf", context )
PrecacheResource( "particle","particles/heroes/pango_v/pangolier_heartpiercer_v_front_end.vpcf", context )
PrecacheResource( "particle","particles/heroes/pango_v/pangolier_heartpiercer_v_right_end.vpcf", context )
PrecacheResource( "particle","particles/heroes/pango_v/pangolier_heartpiercer_v_back_end.vpcf", context )
PrecacheResource( "particle","particles/heroes/pango_v/pangolier_heartpiercer_v_left_end.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", context )
PrecacheResource( "particle","particles/econ/items/troll_warlord/troll_warlord_ti7_axe/troll_ti7_axe_bash_explosion.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact_mechanical.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/sange_maim.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_life_stealer_open_wounds.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", context )
PrecacheResource( "particle","particles/pangolier/lucky_stack_max.vpcf", context )
PrecacheResource( "particle","particles/pangolier/lucky_legendary_delay.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf", context )
PrecacheResource( "particle","particles/pangolier/lucky_cleave.vpcf", context )
end

function pangolier_lucky_shot_custom:GetCastRange(vLocation, hTarget)
if self:GetCaster():HasTalent("modifier_pangolier_lucky_6") then 
    return self:GetCaster():GetTalentValue("modifier_pangolier_lucky_6", "cast")
end
return 
end

function pangolier_lucky_shot_custom:GetCooldown(iLevel)
if self:GetCaster():HasTalent("modifier_pangolier_lucky_6") then 
    return self:GetCaster():GetTalentValue("modifier_pangolier_lucky_6", "cd")
end
return 
end

function pangolier_lucky_shot_custom:GetBehavior()
if self:GetCaster():HasTalent("modifier_pangolier_lucky_6") then 
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end
return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function pangolier_lucky_shot_custom:GetIntrinsicModifierName()
return "modifier_pangolier_lucky_shot_custom_tracker"
end


function pangolier_lucky_shot_custom:OnSpellStart()
local caster = self:GetCaster()
caster:RemoveModifierByName("modifier_pangolier_rollup_custom")
caster:RemoveModifierByName("modifier_pangolier_gyroshell_custom")

local target = self:GetCursorTarget()
local caster = caster
local dir = (target:GetAbsOrigin() - caster:GetAbsOrigin())

dir.z = 0
dir = dir:Normalized()

target:AddNewModifier(caster, self, "modifier_stunned", {duration = caster:GetTalentValue("modifier_pangolier_lucky_6", "stun")})

target:EmitSound("Pango.Lucky_dash2")

local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_CUSTOMORIGIN, target)
ParticleManager:SetParticleControlEnt(hit_effect, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
ParticleManager:SetParticleControlEnt(hit_effect, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
ParticleManager:ReleaseParticleIndex(hit_effect)

caster:AddNewModifier(caster, self, "modifier_pangolier_lucky_shot_custom_dash", 
{
    target = target:entindex(),
    x = dir.x,
    y = dir.y,
    duration = 3
})
end



function pangolier_lucky_shot_custom:ProcPassive(target, proc)
local caster = self:GetCaster()
if caster:PassivesDisabled() then return end

local chance = self:GetSpecialValueFor("chance_pct")
local duration = self:GetSpecialValueFor("duration")

if caster:HasTalent("modifier_pangolier_lucky_1") then 
    chance = chance + caster:GetTalentValue("modifier_pangolier_lucky_1", "chance")
end

duration = duration * (1 - target:GetStatusResistance())

if not proc then 
    if target:HasModifier("modifier_pangolier_lucky_shot_custom_cd") then 
        return
    else 
        if not RollPseudoRandomPercentage(chance, 842, caster) then 
            return 
        end
    end
end

if target:IsRealHero() and caster:GetQuest() == "Pangolier.Quest_7" then 
    caster:UpdateQuest(1) 
end 

target:AddNewModifier(caster, self, "modifier_pangolier_lucky_shot_custom_disarm", {duration = duration})  

target:EmitSound("Hero_Pangolier.LuckyShot.Proc")

if caster:HasTalent("modifier_pangolier_lucky_5") and not target:HasModifier("modifier_pangolier_lucky_shot_custom_silence_cd") then 

    target:EmitSound("Sf.Raze_Silence")
    target:AddNewModifier(caster, self, "modifier_pangolier_lucky_shot_custom_silence_cd", {duration = caster:GetTalentValue("modifier_pangolier_lucky_5", "cd")})
    target:AddNewModifier(caster, self, "modifier_generic_silence", {duration = (1 - target:GetStatusResistance())*caster:GetTalentValue("modifier_pangolier_lucky_5", "silence")})
end

if caster:HasTalent("modifier_pangolier_lucky_4") then 
    caster:AddNewModifier(caster, self, "modifier_pangolier_lucky_shot_custom_speed", {duration = caster:GetTalentValue("modifier_pangolier_lucky_4", "duration")})
end

local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_luckyshot_disarm_cast.vpcf", PATTACH_CUSTOMORIGIN, caster)
ParticleManager:SetParticleControlEnt( particle, 0, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetOrigin(), true )
ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
ParticleManager:SetParticleControlEnt( particle, 3, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
ParticleManager:ReleaseParticleIndex(particle)
end




modifier_pangolier_lucky_shot_custom_tracker = class({})
function modifier_pangolier_lucky_shot_custom_tracker:IsPurgable() return false end
function modifier_pangolier_lucky_shot_custom_tracker:IsHidden() return true end
function modifier_pangolier_lucky_shot_custom_tracker:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
    MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
}
end

function modifier_pangolier_lucky_shot_custom_tracker:OnCreated(table)
self.ability = self:GetAbility()
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.proc = false

if self.parent:IsRealHero() then 
    self.parent:AddAttackRecordEvent_out(self)
    self.parent:AddAttackEvent_out(self)
    self.parent:AddDamageEvent_out(self)
end

self.chance = self.ability:GetSpecialValueFor("chance_pct")

self.heal_creeps = self.parent:GetTalentValue("modifier_pangolier_lucky_3", "creeps", true)

self.cleave_radius = self.parent:GetTalentValue("modifier_pangolier_lucky_2", "radius", true)
self.cleave_chance = self.parent:GetTalentValue("modifier_pangolier_lucky_2", "chance", true)
end

function modifier_pangolier_lucky_shot_custom_tracker:GetModifierAttackRangeBonus()
if not self.parent:HasTalent("modifier_pangolier_lucky_2") then return end
return self.parent:GetTalentValue("modifier_pangolier_lucky_2", "range")
end


function modifier_pangolier_lucky_shot_custom_tracker:DamageEvent_out(params)
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_pangolier_lucky_3") then return end 
if self.parent ~= params.attacker then return end
if not params.unit:IsUnit() then return end 
if params.unit:IsIllusion() then return end
if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end
if not params.unit:HasModifier("modifier_pangolier_lucky_shot_custom_disarm") then return end

local heal = params.damage*self.parent:GetTalentValue("modifier_pangolier_lucky_3", "heal")/100
if params.unit:IsCreep() then
    heal = heal/self.heal_creeps
end
self.parent:GenericHeal(heal, self.ability, true, nil, "modifier_pangolier_lucky_3")
end


function modifier_pangolier_lucky_shot_custom_tracker:AttackRecordEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if self.parent:IsIllusion() then return end
if not params.target:IsUnit() then return end

self.proc = false

local chance = self.chance
if self.parent:HasTalent("modifier_pangolier_lucky_1") then 
    chance = chance + self.parent:GetTalentValue("modifier_pangolier_lucky_1", "chance")
end

if not RollPseudoRandomPercentage(chance, 842, self.caster) then return end

self.proc = true
if params.no_attack_cooldown then return end
self.parent:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK_EVENT, self.parent:GetAttackSpeed(true))
end




function modifier_pangolier_lucky_shot_custom_tracker:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end 

local mod = params.target:FindModifierByName("modifier_pangolier_lucky_shot_custom_legendary_proc")

if mod then 
    local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_CUSTOMORIGIN, params.target)
    ParticleManager:SetParticleControlEnt(hit_effect, 0, params.target, PATTACH_POINT_FOLLOW, "attach_hitloc", params.target:GetAbsOrigin(), false) 
    ParticleManager:SetParticleControlEnt(hit_effect, 1, params.target, PATTACH_POINT_FOLLOW, "attach_hitloc", params.target:GetAbsOrigin(), false) 
    ParticleManager:ReleaseParticleIndex(hit_effect)
    params.target:EmitSound("Pango.Lucky_legendary_proc_attack")
end

if self.parent:HasTalent("modifier_pangolier_lucky_2") and RollPseudoRandomPercentage(self.cleave_chance, 8432, self.parent) then 

    local damage = self.parent:GetAverageTrueAttackDamage(nil)*self.parent:GetTalentValue("modifier_pangolier_lucky_2", "damage")/100
    for _,target in pairs(self.parent:FindTargets(self.cleave_radius, params.target:GetAbsOrigin())) do
        DoDamage({victim = target, attacker = self.parent, ability = self.ability, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK}, "modifier_pangolier_lucky_2")
        target:SendNumber(4, damage)
    end 

    local particle = ParticleManager:CreateParticle("particles/pangolier/lucky_cleave.vpcf", PATTACH_WORLDORIGIN, nil)    
    ParticleManager:SetParticleControl(particle, 0, params.target:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
end

if not self.proc then return end
self.proc = false
self.ability:ProcPassive(params.target, true)
end






modifier_pangolier_lucky_shot_custom_disarm = class({})
function modifier_pangolier_lucky_shot_custom_disarm:IsHidden() return false end
function modifier_pangolier_lucky_shot_custom_disarm:IsPurgable() return true end
function modifier_pangolier_lucky_shot_custom_disarm:OnCreated()

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.armor  = self.ability:GetSpecialValueFor("armor")
self.speed = self.ability:GetSpecialValueFor("attack_slow")*-1 + self.caster:GetTalentValue("modifier_pangolier_lucky_1", "speed")

self.slow = self.caster:GetTalentValue("modifier_pangolier_lucky_3", "slow")

self.damage = self.caster:GetTalentValue("modifier_pangolier_lucky_5", "damage")

if not IsServer() then return end
self:OnIntervalThink()
self:StartIntervalThink(0.1)
end

function modifier_pangolier_lucky_shot_custom_disarm:OnIntervalThink()
if not IsServer() then return end

if self.particle then 
    if self.parent:HasModifier("modifier_pangolier_lucky_shot_custom_legendary") or self.parent:HasModifier("modifier_pangolier_heartpiercer_debuff") then 
        ParticleManager:DestroyParticle(self.particle, false)
        ParticleManager:ReleaseParticleIndex(self.particle)
    end
else 
    if not self.parent:HasModifier("modifier_pangolier_lucky_shot_custom_legendary") and not self.parent:HasModifier("modifier_pangolier_heartpiercer_debuff") then 
        self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_luckyshot_disarm_debuff.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
        self:AddParticle(self.particle, false, false, -1, false, false)
    end
end

end

function modifier_pangolier_lucky_shot_custom_disarm:DeclareFunctions()
return  
{
    MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_pangolier_lucky_shot_custom_disarm:GetModifierAttackSpeedBonus_Constant()
return self.speed
end

function modifier_pangolier_lucky_shot_custom_disarm:GetModifierSpellAmplify_Percentage() 
if not self.caster:HasTalent("modifier_pangolier_lucky_5") then return end
return self.damage
end

function modifier_pangolier_lucky_shot_custom_disarm:GetModifierPhysicalArmorBonus()
return (self.armor ) * (-1)
end

function modifier_pangolier_lucky_shot_custom_disarm:GetModifierMoveSpeedBonus_Percentage()
if not self.caster:HasTalent("modifier_pangolier_lucky_3") then return end
return self.slow
end



modifier_pangolier_lucky_shot_custom_dash = class({})
function modifier_pangolier_lucky_shot_custom_dash:IsHidden() return true end
function modifier_pangolier_lucky_shot_custom_dash:IsPurgable() return false end
function modifier_pangolier_lucky_shot_custom_dash:OnCreated(kv)
if not IsServer() then return end
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.pfx = ParticleManager:CreateParticle("particles/items_fx/force_staff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
self:AddParticle( self.pfx , false,  false, -1,  false, false )
self.parent:EmitSound("Pango.Lucky_dash")

self.target = EntIndexToHScript(kv.target)
self.dir = Vector(kv.x, kv.y, 0):Normalized()

self.range = self.parent:GetTalentValue("modifier_pangolier_lucky_6", "range")
self.point = self.target:GetAbsOrigin() + self.dir*self.range

self.parent:SetForwardVector(self.parent:GetForwardVector()*-1 )
self.parent:FaceTowards(self.parent:GetAbsOrigin() - self.parent:GetForwardVector()*10)

self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_1)
self.speed = self.parent:GetTalentValue("modifier_pangolier_lucky_6", "dash_speed")

if self:ApplyHorizontalMotionController() == false then
    self:Destroy()
end
end

function modifier_pangolier_lucky_shot_custom_dash:UpdateHorizontalMotion( me, dt )
if not IsServer() then return end

if not self.target or self.target:IsNull() or not self.target:IsAlive() then 
    self:Destroy()
    return 
end

local pos = self.parent:GetAbsOrigin()

self.point = self.target:GetAbsOrigin() + self.dir*self.range

local dir = (self.point - pos):Normalized()
local pos_p = self.parent:GetAbsOrigin() + dir*self.speed*dt

local next_pos = GetGroundPosition(pos_p,self.parent)
self.parent:SetAbsOrigin(next_pos)

if (self.point - self.parent:GetAbsOrigin()):Length2D() < self.speed*dt then
    self:Destroy()
    return
end

end

function modifier_pangolier_lucky_shot_custom_dash:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_DISABLE_TURNING,
    MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end

function modifier_pangolier_lucky_shot_custom_dash:CheckState()
return
{
    [MODIFIER_STATE_STUNNED] = true,
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
end

function modifier_pangolier_lucky_shot_custom_dash:GetOverrideAnimation() return ACT_DOTA_CAST_ABILITY_1 end
function modifier_pangolier_lucky_shot_custom_dash:GetModifierDisableTurning() return 1 end
function modifier_pangolier_lucky_shot_custom_dash:GetEffectName() return "particles/units/heroes/hero_pangolier/pangolier_swashbuckler_dash.vpcf" end

function modifier_pangolier_lucky_shot_custom_dash:OnDestroy()
if not IsServer() then return end

self.parent:InterruptMotionControllers( true )

if self.target then 
    self:GetAbility():ProcPassive(self.target, true)
    self.parent:SetForwardVector((self.target:GetAbsOrigin() - self.parent:GetAbsOrigin() ):Normalized())
    self.parent:FaceTowards(self.target:GetAbsOrigin())
end

ResolveNPCPositions(self.parent:GetAbsOrigin(), 128)
self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_1)
end


function modifier_pangolier_lucky_shot_custom_dash:OnHorizontalMotionInterrupted()
self:Destroy()
end





modifier_pangolier_lucky_shot_custom_silence_cd = class({})
function modifier_pangolier_lucky_shot_custom_silence_cd:IsHidden() return true end
function modifier_pangolier_lucky_shot_custom_silence_cd:IsPurgable() return false end
function modifier_pangolier_lucky_shot_custom_silence_cd:RemoveOnDeath() return false end
function modifier_pangolier_lucky_shot_custom_silence_cd:OnCreated(table)
if not IsServer() then return end
self.RemoveForDuel = true
end



pangolier_heartpiercer_custom = class({})

function pangolier_heartpiercer_custom:OnAbilityPhaseStart()
if not IsServer() then return end
self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK_EVENT, 1.3)
self:GetCaster():EmitSound("Hero_Pangolier.PreAttack")
return true
end

function pangolier_heartpiercer_custom:OnAbilityPhaseInterrupted()
self:GetCaster():FadeGesture(ACT_DOTA_ATTACK_EVENT)
end

function pangolier_heartpiercer_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

caster:EmitSound("Hero_Pangolier.PreAttack")

local dir = (target:GetAbsOrigin() - caster:GetAbsOrigin())

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_pangolier/pangolier_swashbuckler.vpcf", PATTACH_POINT_FOLLOW, caster )
ParticleManager:SetParticleControlEnt( effect_cast, 0, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetOrigin(), true )
ParticleManager:SetParticleControl( effect_cast, 1, dir:Normalized()*dir:Length2D() )
ParticleManager:SetParticleControl( effect_cast, 3, dir:Normalized()*dir:Length2D() )

Timers:CreateTimer(0.2, function()
    if effect_cast then
        ParticleManager:DestroyParticle(effect_cast, false)
        ParticleManager:ReleaseParticleIndex(effect_cast)
    end
end)

local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_luckyshot_disarm_cast.vpcf", PATTACH_CUSTOMORIGIN, caster)
ParticleManager:SetParticleControlEnt( particle, 0, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetOrigin(), true )
ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
ParticleManager:SetParticleControlEnt( particle, 3, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
ParticleManager:ReleaseParticleIndex(particle)

target:EmitSound("Pango.Lucky_legendary")
target:EmitSound("Pango.Lucky_legendary2")
target:AddNewModifier(caster, self, "modifier_pangolier_lucky_shot_custom_legendary", {duration = caster:GetTalentValue("modifier_pangolier_lucky_7", "duration")})
end



modifier_pangolier_lucky_shot_custom_legendary = class({})
function modifier_pangolier_lucky_shot_custom_legendary:IsHidden() return false end
function modifier_pangolier_lucky_shot_custom_legendary:IsPurgable() return false end
function modifier_pangolier_lucky_shot_custom_legendary:GetEffectName() 
return "particles/pangolier/lucky_legendary_delay.vpcf"
end

function modifier_pangolier_lucky_shot_custom_legendary:GetEffectAttachType()
return PATTACH_OVERHEAD_FOLLOW
end

function modifier_pangolier_lucky_shot_custom_legendary:GetStatusEffectName()
return "particles/status_fx/status_effect_life_stealer_open_wounds.vpcf"
end

function modifier_pangolier_lucky_shot_custom_legendary:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end



function modifier_pangolier_lucky_shot_custom_legendary:OnCreated(table)

self.ability = self:GetAbility()
self.parent = self:GetParent()
self.parent:AddAttackStartEvent_inc(self)

self.caster = self:GetCaster()

self.proc_duration = self.ability:GetSpecialValueFor("proc_duration")
self.RemoveForDuel = true

self.duration = self.caster:GetTalentValue("modifier_pangolier_lucky_7", "effect_duration")
self.heal = self.ability:GetSpecialValueFor("heal")/100

if not IsServer() then return end

self.ability:EndCd()

self.proced = false
self.sides = {}
self.sides_units = {}
self.facing_direction = self.parent:GetAnglesAsVector().y

self.parent:EmitSound("Pango.Lucky_legendary_lp")
self.parent:GenericParticle("particles/items2_fx/sange_maim.vpcf", self)


local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
ParticleManager:SetParticleControlEnt(hit_effect, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), false) 
ParticleManager:SetParticleControlEnt(hit_effect, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), false) 
ParticleManager:ReleaseParticleIndex(hit_effect)

self.particles_sides = {}
self.particles_sides[1] = ParticleManager:CreateParticle( "particles/heroes/pango_v/pangolier_heartpiercer_v_front_models.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
self.particles_sides[2] = ParticleManager:CreateParticle( "particles/heroes/pango_v/pangolier_heartpiercer_v_right_models.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
self.particles_sides[3] = ParticleManager:CreateParticle( "particles/heroes/pango_v/pangolier_heartpiercer_v_back_models.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
self.particles_sides[4] = ParticleManager:CreateParticle( "particles/heroes/pango_v/pangolier_heartpiercer_v_left_models.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )

for i = 1,4 do 
    ParticleManager:SetParticleControl(self.particles_sides[i], 1, Vector(self:GetRemainingTime(), 0, 0)) 
end

self.forward = self.parent:GetForwardVector()
self.interval = 0.1
self:StartIntervalThink(self.interval)
end


function modifier_pangolier_lucky_shot_custom_legendary:OnIntervalThink()
if not IsServer() then return end 
AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), 300, self.interval*2, false)
end


function modifier_pangolier_lucky_shot_custom_legendary:OnDestroy()
if not IsServer() then return end 

if self.proced == false then 
    self.ability:StartCd()
end

for i = 1,4 do 
    if self.particles_sides[i] then 
        ParticleManager:DestroyParticle(self.particles_sides[i], false)
        ParticleManager:ReleaseParticleIndex(self.particles_sides[i])
        self.particles_sides[i] = nil
    end
end

for _,unit in pairs(self.sides_units) do 
    if unit and not unit:IsNull() then 
        UTIL_Remove(unit)
    end
end

self.parent:StopSound("Pango.Lucky_legendary_lp")
end



function modifier_pangolier_lucky_shot_custom_legendary:AttackStartEvent_inc(params)
if not IsServer() then return end
if self.parent ~= params.target then return end
if self.caster ~= params.attacker then return end

local reduction = 0
local target = params.target

local attacker_vector = (params.attacker:GetOrigin() - self.parent:GetOrigin())
local attacker_direction = VectorToAngles( attacker_vector ).y
local angle_diff = AngleDiff( self.facing_direction, attacker_direction ) 

local side = 0
if (angle_diff < 45 and angle_diff > -45) then 
    side = 1
end 
if (angle_diff >= 45 and angle_diff <= 135) then 
    side = 2
end  
if (angle_diff > 135 or (angle_diff >= -180 and angle_diff < -135)) then 
    side = 3  

end  
if (angle_diff >= -135 and angle_diff <= -45) then 
    side = 4
end

if side ~= 0 then 
    if not self.sides[side] then 
        self.sides[side] = true

        if self.particles_sides[side] then 

            local end_part = "particles/heroes/pango_v/pangolier_heartpiercer_v_front_end.vpcf"
            if side == 2 then 
                end_part = "particles/heroes/pango_v/pangolier_heartpiercer_v_right_end.vpcf"
            end
            if side == 3 then 
                end_part = "particles/heroes/pango_v/pangolier_heartpiercer_v_back_end.vpcf"
            end
            if side == 4 then 
                end_part = "particles/heroes/pango_v/pangolier_heartpiercer_v_left_end.vpcf"
            end

            local hit_effect = ParticleManager:CreateParticle(end_part, PATTACH_ABSORIGIN_FOLLOW, self.parent)
            ParticleManager:SetParticleControlForward(hit_effect, 1, self.forward)
            ParticleManager:ReleaseParticleIndex(hit_effect)

            ParticleManager:DestroyParticle(self.particles_sides[side], false)
            ParticleManager:ReleaseParticleIndex(self.particles_sides[side])
            self.particles_sides[side] = nil
        end

        local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_CUSTOMORIGIN, target)
        ParticleManager:SetParticleControlEnt(hit_effect, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
        ParticleManager:SetParticleControlEnt(hit_effect, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
        ParticleManager:ReleaseParticleIndex(hit_effect)

        if self.sides_units[side] and not self.sides_units[side]:IsNull() then 
            UTIL_Remove(self.sides_units[side])
        end

        self.caster:GenericParticle("particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf")
        self.caster:GenericHeal(self.caster:GetMaxHealth()*self.heal, self.ability)
        self.parent:EmitSound("Pango.Lucky_legendary_hit")
    end

    local count = 0

    for i = 1,4 do
        if self.sides[i] then 
            count = count + 1
        end
    end

    if count >= 4 then
        local effect_cast = ParticleManager:CreateParticle( "particles/econ/items/troll_warlord/troll_warlord_ti7_axe/troll_ti7_axe_bash_explosion.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent )
        ParticleManager:SetParticleControl( effect_cast, 0,  self.parent:GetOrigin() )
        ParticleManager:SetParticleControl( effect_cast, 1, self.caster:GetOrigin() )
        ParticleManager:ReleaseParticleIndex(effect_cast)

        local coup_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact_mechanical.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
        ParticleManager:SetParticleControlEnt( coup_pfx, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
        ParticleManager:SetParticleControl( coup_pfx, 1, self.parent:GetOrigin() )
        ParticleManager:SetParticleControlForward( coup_pfx, 1, -1*self.caster:GetForwardVector() )
        ParticleManager:ReleaseParticleIndex( coup_pfx )

        self.caster:AddNewModifier(self.caster, self.ability, "modifier_pangolier_lucky_shot_custom_legendary_caster", {duration = self.duration})
        self.parent:AddNewModifier(self.caster, self.ability, "modifier_pangolier_lucky_shot_custom_legendary_proc", {duration = self.duration}) 
        self.proced = true
        self:Destroy()
    end
end

end


modifier_pangolier_lucky_shot_custom_legendary_proc = class({})
function modifier_pangolier_lucky_shot_custom_legendary_proc:IsHidden() return true end
function modifier_pangolier_lucky_shot_custom_legendary_proc:IsPurgable() return false end

function modifier_pangolier_lucky_shot_custom_legendary_proc:GetEffectName() 
return "particles/items2_fx/sange_maim.vpcf"
end

function modifier_pangolier_lucky_shot_custom_legendary_proc:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_pangolier_lucky_shot_custom_legendary_proc:GetStatusEffectName()
return "particles/status_fx/status_effect_rupture.vpcf"
end

function modifier_pangolier_lucky_shot_custom_legendary_proc:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end

function modifier_pangolier_lucky_shot_custom_legendary_proc:OnCreated(table)

self.ability = self:GetAbility()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.heal_reduce = self.ability:GetSpecialValueFor("heal_reduce")

if not IsServer() then return end
self.parent:AddNewModifier(self.caster, self.ability, "modifier_stunned", {duration = (1 - self.parent:GetStatusResistance())*self.caster:GetTalentValue("modifier_pangolier_lucky_7", "stun")})

self.parent:EmitSound("Pango.Lucky_legendary_proc")
self.parent:EmitSound("Pango.Lucky_dash2")
self.parent:EmitSound("Hero_Pangolier.LuckyShot.Proc")

self:OnIntervalThink()
self:StartIntervalThink(FrameTime())
end

function modifier_pangolier_lucky_shot_custom_legendary_proc:OnIntervalThink()
if not IsServer() then return end
if self.parent:HasModifier("modifier_pangolier_heartpiercer_debuff") then return end

self.parent:AddNewModifier(self.caster, self.ability, "modifier_pangolier_heartpiercer_debuff", {duration = self:GetRemainingTime()})
end


function modifier_pangolier_lucky_shot_custom_legendary_proc:OnDestroy()
if not IsServer() then return end 
self.ability:StartCd()
end


function modifier_pangolier_lucky_shot_custom_legendary_proc:DeclareFunctions()
return
{
    --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
    --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end



function modifier_pangolier_lucky_shot_custom_legendary_proc:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_pangolier_lucky_shot_custom_legendary_proc:GetModifierHealChange() 
return self.heal_reduce
end

function modifier_pangolier_lucky_shot_custom_legendary_proc:GetModifierHPRegenAmplify_Percentage() 
return self.heal_reduce
end







modifier_pangolier_lucky_shot_custom_speed = class({})
function modifier_pangolier_lucky_shot_custom_speed:IsHidden() return false end
function modifier_pangolier_lucky_shot_custom_speed:IsPurgable() return false end
function modifier_pangolier_lucky_shot_custom_speed:GetTexture() return "buffs/lucky_blood" end
function modifier_pangolier_lucky_shot_custom_speed:OnCreated()

self.parent = self:GetParent()

self.status = self.parent:GetTalentValue("modifier_pangolier_lucky_4", "status")
self.max = self.parent:GetTalentValue("modifier_pangolier_lucky_4", "max")
self.speed = self.parent:GetTalentValue("modifier_pangolier_lucky_4", "speed")
if not IsServer() then return end 
self:SetStackCount(1)
end 

function modifier_pangolier_lucky_shot_custom_speed:OnRefresh(table)
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 

self:IncrementStackCount()

if self:GetStackCount() >= self.max then 
    self.parent:EmitSound("Pango.Lucky_stack")
    self.parent:GenericParticle("particles/pangolier/lucky_stack_max.vpcf", self)
end 

end 

function modifier_pangolier_lucky_shot_custom_speed:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_pangolier_lucky_shot_custom_speed:GetModifierStatusResistanceStacking() 
if self:GetStackCount() < self.max then return end
return self.status
end

function modifier_pangolier_lucky_shot_custom_speed:GetModifierAttackSpeedBonus_Constant()
return self.speed*self:GetStackCount()
end



modifier_pangolier_lucky_shot_custom_legendary_caster = class({})
function modifier_pangolier_lucky_shot_custom_legendary_caster:IsHidden() return false end
function modifier_pangolier_lucky_shot_custom_legendary_caster:IsPurgable() return false end
function modifier_pangolier_lucky_shot_custom_legendary_caster:CheckState()
return
{
    [MODIFIER_STATE_CANNOT_MISS] = true
}
end