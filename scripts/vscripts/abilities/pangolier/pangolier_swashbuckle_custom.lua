--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pangolier_swashbuckle_custom_dash", "abilities/pangolier/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_pangolier_swashbuckle_custom_attacks", "abilities/pangolier/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_swashbuckle_custom_tracker", "abilities/pangolier/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_swashbuckle_custom_stun", "abilities/pangolier/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_swashbuckle_custom_parry", "abilities/pangolier/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_swashbuckle_custom_blood", "abilities/pangolier/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_swashbuckle_custom_legendary_combat", "abilities/pangolier/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_swashbuckle_custom_speed", "abilities/pangolier/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_swashbuckle_custom_scepter", "abilities/pangolier/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_swashbuckle_custom_range", "abilities/pangolier/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_swashbuckle_custom_leash", "abilities/pangolier/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_swashbuckle_custom_blink", "abilities/pangolier/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_pangolier_swashbuckle_custom_slow", "abilities/pangolier/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_NONE)

pangolier_swashbuckle_custom = class({})


function pangolier_swashbuckle_custom:CreateTalent()
self:ToggleAutoCast()
end

function pangolier_swashbuckle_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/jugg_legendary_proc_.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_swashbuckler_dash.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_swashbuckler_dash.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_swashbuckler.vpcf", context )
PrecacheResource( "particle","particles/pangolier/buckle_stacks.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pangolier/pangolier_swashbuckler.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sniper/sniper_headshot_slow.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_snapfire_slow.vpcf", context )
PrecacheResource( "particle","particles/pangolier/linken_active.vpcf", context )
PrecacheResource( "particle","particles/pangolier/linken_proc.vpcf", context )
PrecacheResource( "particle","particles/jugg_parry.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/iron_talon_active.vpcf", context )
PrecacheResource( "particle","particles/brist_proc.vpcf", context )
end


function pangolier_swashbuckle_custom:GetIntrinsicModifierName()
return "modifier_pangolier_swashbuckle_custom_tracker"
end


function pangolier_swashbuckle_custom:GetBehavior()
local bonus = 0

if self:GetCaster():HasTalent("modifier_pangolier_buckle_5") then 
    bonus = DOTA_ABILITY_BEHAVIOR_AUTOCAST
end
return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_MOVEMENT + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES + DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING + bonus
end


function pangolier_swashbuckle_custom:GetCooldown(iLevel)
local upgrade_cooldown = 0
if self:GetCaster():HasTalent("modifier_pangolier_buckle_1") then  
  upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_pangolier_buckle_1", "cd")
end 
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown
end

function pangolier_swashbuckle_custom:GetCastRange(vLocation, hTarget)
local upgrade = 0
if self:GetCaster():HasModifier("modifier_slark_saltwater_shiv_custom_legendary_steal") then
    upgrade = upgrade + 300
end
if self:GetCaster():HasTalent("modifier_pangolier_buckle_2") then 
  upgrade = upgrade +  self:GetCaster():GetTalentValue("modifier_pangolier_buckle_2", "range")
end
return self.BaseClass.GetCastRange(self , vLocation , hTarget) + upgrade 
end


function pangolier_swashbuckle_custom:GetManaCost(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_pangolier_buckle_1") then 
    bonus = self:GetCaster():GetTalentValue("modifier_pangolier_buckle_1", "mana")
end 
return self.BaseClass.GetManaCost(self,level) + bonus
end


function pangolier_swashbuckle_custom:GetCastPoint(iLevel)
if self:GetCaster():HasTalent("modifier_pangolier_buckle_6") or self:GetCaster():HasModifier("modifier_pangolier_gyroshell_custom") or self:GetCaster():HasModifier("modifier_pangolier_rollup_custom") then 
   return 0
end
return self.BaseClass.GetCastPoint(self)
end



function pangolier_swashbuckle_custom:DealDamage(target, stun, scepter)
if not IsServer() then return end
local caster = self:GetCaster()

self.passive = caster:FindAbilityByName("pangolier_lucky_shot_custom")

if self.passive and self.passive:GetLevel() > 0 then 
    self.passive:ProcPassive(target, false)
end

if stun and stun == true then 

    target:GenericParticle("particles/jugg_legendary_proc_.vpcf")

    local trail_pfx = ParticleManager:CreateParticle("particles/items3_fx/iron_talon_active.vpcf", PATTACH_ABSORIGIN, target)
    ParticleManager:SetParticleControlEnt(trail_pfx, 0, target, PATTACH_ABSORIGIN_FOLLOW, nil, target:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt( trail_pfx, 1, target, PATTACH_ABSORIGIN_FOLLOW, nil, target:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(trail_pfx)

    target:EmitSound("Pango.Lucky_dash2")
    target:EmitSound("DOTA_Item.Daedelus.Crit")

    target:AddNewModifier(caster, self, "modifier_stunned", {duration = (1 - target:GetStatusResistance())*caster:GetTalentValue("modifier_pangolier_buckle_7", "stun")})
end 

target:AddNewModifier(caster, self, "modifier_pangolier_swashbuckle_custom_slow", {duration = self:GetSpecialValueFor("slow_duration")})

caster:PerformAttack( target, true, true, true, false, false, false, true )
target:EmitSound("Hero_Pangolier.Swashbuckle.Damage")
end



function pangolier_swashbuckle_custom:OnVectorCastStart(vStartLocation, vDirection)

local caster = self:GetCaster()

caster:RemoveModifierByName("modifier_pangolier_rollup_custom")
caster:RemoveModifierByName("modifier_pangolier_gyroshell_custom")

local stacks = 0
local mod = caster:FindModifierByName("modifier_pangolier_swashbuckle_custom_tracker")

if mod then 
    stacks = mod:GetStackCount()
    mod:SetStackCount(0)
end

caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)

local point = vStartLocation
local vector_point = point + vDirection*self:GetSpecialValueFor("range")

local speed = self:GetSpecialValueFor( "dash_speed" )
local direction = vDirection

local vector = (point-caster:GetOrigin())
local dist = vector:Length2D()
vector.z = 0
vector = vector:Normalized()

caster:SetForwardVector( direction )

caster:AddNewModifier(caster, self, "modifier_pangolier_swashbuckle_custom_dash", 
{
    x = point.x, 
    y = point.y, 
    z = point.z, 
    dist = dist,
    attacks_x = direction.x,
    attacks_y = direction.y,
    duration = dist/speed,
    stacks = stacks,
})

end



modifier_pangolier_swashbuckle_custom_dash = class({})

function modifier_pangolier_swashbuckle_custom_dash:IsDebuff() return false end
function modifier_pangolier_swashbuckle_custom_dash:IsHidden() return true end
function modifier_pangolier_swashbuckle_custom_dash:IsPurgable() return false end

function modifier_pangolier_swashbuckle_custom_dash:OnCreated(kv)
if not IsServer() then return end

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:EmitSound("Hero_Pangolier.Swashbuckle.Cast")
self.parent:EmitSound("Hero_Pangolier.Swashbuckle.Layer")

self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_swashbuckle_custom_stun", {duration = self:GetRemainingTime() + 0.1})

if self.parent:HasTalent("modifier_pangolier_buckle_6") then 
    ProjectileManager:ProjectileDodge(self.parent)
end

self.point = Vector(kv.x, kv.y, kv.z)
self.angle = (self.point - self.parent:GetAbsOrigin()):Normalized()
self.distance = kv.dist / ( self:GetDuration() / FrameTime())
self.direction = Vector(kv.attacks_x, kv.attacks_y, 0):Normalized()
self.stacks = kv.stacks

self.targets = {}

if self:ApplyHorizontalMotionController() == false then
    self:Destroy()
end

end


function modifier_pangolier_swashbuckle_custom_dash:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_DISABLE_TURNING,
    MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end

function modifier_pangolier_swashbuckle_custom_dash:CheckState()
if self.parent:HasTalent("modifier_pangolier_buckle_6") then 
    return
    {
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true
    }
else 
    return
    {
        [MODIFIER_STATE_STUNNED] = true
    }
end

end

function modifier_pangolier_swashbuckle_custom_dash:GetOverrideAnimation() return ACT_DOTA_CAST_ABILITY_1 end
function modifier_pangolier_swashbuckle_custom_dash:GetModifierDisableTurning() return 1 end
function modifier_pangolier_swashbuckle_custom_dash:GetEffectName() return "particles/units/heroes/hero_pangolier/pangolier_swashbuckler_dash.vpcf" end
function modifier_pangolier_swashbuckle_custom_dash:OnDestroy()
if not IsServer() then return end

self.parent:InterruptMotionControllers( true )

local dir = self.parent:GetForwardVector()
dir.z = 0
self.parent:SetForwardVector(dir)
self.parent:FaceTowards(self.parent:GetAbsOrigin() + dir*10)

FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), false)

self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_1)

if self:GetRemainingTime() < 0.1 then 
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_swashbuckle_custom_attacks", {dir_x = self.direction.x, dir_y = self.direction.y,  duration = 3, stacks = self.stacks})
else 
    self.parent:RemoveModifierByName("modifier_pangolier_swashbuckle_custom_stun")
end

end


function modifier_pangolier_swashbuckle_custom_dash:UpdateHorizontalMotion( me, dt )
if not IsServer() then return end

local pos = self.parent:GetAbsOrigin()

local pos_p = self.angle * self.distance
local next_pos = GetGroundPosition(pos + pos_p,self.parent)
self.parent:SetAbsOrigin(next_pos)

end

function modifier_pangolier_swashbuckle_custom_dash:OnHorizontalMotionInterrupted()
self:Destroy()
end





modifier_pangolier_swashbuckle_custom_attacks = class({})
function modifier_pangolier_swashbuckle_custom_attacks:IsHidden() return true end
function modifier_pangolier_swashbuckle_custom_attacks:IsPurgable() return false end
function modifier_pangolier_swashbuckle_custom_attacks:OnCreated( kv )

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.range = self.ability:GetSpecialValueFor( "range" ) + self.parent:GetTalentValue("modifier_pangolier_buckle_2", "range")
self.speed = self.ability:GetSpecialValueFor( "dash_speed" )
self.radius = self.ability:GetSpecialValueFor( "start_radius" )

self.interval = self.ability:GetSpecialValueFor( "attack_interval" )
self.damage = self.ability:GetSpecialValueFor( "damage" )
self.strikes = self.ability:GetSpecialValueFor( "strikes" )

self.stun = false

if not IsServer() then return end

if kv.stacks then 
    self.strikes = self.strikes + kv.stacks
    if self.parent:HasTalent("modifier_pangolier_buckle_7") and kv.stacks >= self.parent:GetTalentValue("modifier_pangolier_buckle_7", "max") then 
        self.stun = true
    end 
end


if self.parent:HasTalent("modifier_pangolier_buckle_3") then 
    self.damage = self.damage + self.parent:GetTalentValue("modifier_pangolier_buckle_3", "damage")*self.parent:GetAverageTrueAttackDamage(nil)/100
    self.crit  = self.parent:GetTalentValue("modifier_pangolier_buckle_3", "crit")
end

if self.parent:HasTalent("modifier_pangolier_buckle_6") then 
    self.damage_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_swashbuckle_custom_parry", {})
end

self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_1_END)

self.origin = self.parent:GetOrigin()
self.direction = Vector( kv.dir_x, kv.dir_y, 0 )
self.target = self.origin + self.direction*self.range

self.count = 0

self:StartIntervalThink( self.interval )
self:OnIntervalThink()
end

function modifier_pangolier_swashbuckle_custom_attacks:OnDestroy()
if not IsServer() then return end

if self.parent:HasTalent("modifier_pangolier_buckle_2") then 
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_swashbuckle_custom_speed", {duration = self.parent:GetTalentValue("modifier_pangolier_buckle_2", "duration")})
end

if self.parent:HasTalent("modifier_pangolier_buckle_5") then 
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_swashbuckle_custom_range", {duration = self.parent:GetTalentValue("modifier_pangolier_buckle_5", "duration")})
end

if self.damage_mod and not self.damage_mod:IsNull() then 
    self.damage_mod:SetDuration(self.parent:GetTalentValue("modifier_pangolier_buckle_6", "duration"), true)
end

end


function modifier_pangolier_swashbuckle_custom_attacks:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_OVERRIDE_ATTACK_DAMAGE,
    MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE
}
end

function modifier_pangolier_swashbuckle_custom_attacks:GetCritDamage() 
if not self.crit then return end
if self.count < self.strikes then return end
return self.crit
end

function modifier_pangolier_swashbuckle_custom_attacks:GetModifierPreAttack_CriticalStrike(params)
if not self.crit then return end
if self.count < self.strikes then return end
params.target:EmitSound("DOTA_Item.Daedelus.Crit")
return self.crit
end

function modifier_pangolier_swashbuckle_custom_attacks:GetModifierOverrideAttackDamage()
return self.damage
end

function modifier_pangolier_swashbuckle_custom_attacks:CheckState()
return 
{
    [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
    [MODIFIER_STATE_DISARMED] = true,
}
end



function modifier_pangolier_swashbuckle_custom_attacks:OnIntervalThink()
if not IsServer() then return end

if self.parent:IsHexed() then 
    self:Destroy()
    return
end

self.count = self.count+1
if self.count>self.strikes then
    self:Destroy()
    return
end

if self.count%6 == 0 then 
    self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_1_END)
    self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_1_END)
end

local enemies = FindUnitsInLine(self.parent:GetTeamNumber(), self.origin, self.target, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY,  DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,  0 )

self.parent:EmitSound("Hero_Pangolier.Swashbuckle")

for _,enemy in pairs(enemies) do
    self.ability:DealDamage(enemy, self.stun)
end

self:PlayEffects()

if self.count == 1 then 
    self.stun = false
end 

end


function modifier_pangolier_swashbuckle_custom_attacks:GetEffectName() return "particles/units/heroes/hero_pangolier/pangolier_swashbuckler_dash.vpcf" end

function modifier_pangolier_swashbuckle_custom_attacks:PlayEffects()
local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_pangolier/pangolier_swashbuckler.vpcf", PATTACH_POINT_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( effect_cast, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
ParticleManager:SetParticleControl( effect_cast, 1, self.direction*self.ability:GetSpecialValueFor("range") )
ParticleManager:SetParticleControl( effect_cast, 3, self.direction*self.ability:GetSpecialValueFor("range") )
    
self:AddParticle( effect_cast, false,  false, -1,  false, false )

Timers:CreateTimer(0.2, function()
    if effect_cast then
        ParticleManager:DestroyParticle(effect_cast, false)
        ParticleManager:ReleaseParticleIndex(effect_cast)
    end
end)

self.parent:EmitSound("Hero_Pangolier.Swashbuckle.Attack")
end






modifier_pangolier_swashbuckle_custom_tracker = class({})
function modifier_pangolier_swashbuckle_custom_tracker:IsHidden() return true end
function modifier_pangolier_swashbuckle_custom_tracker:IsPurgable() return false end


function modifier_pangolier_swashbuckle_custom_tracker:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()

if self.parent:IsRealHero() then
    self.parent:AddDamageEvent_out(self)
    self.parent:AddDamageEvent_inc(self)
    self.parent:AddAttackEvent_out(self)
end

self.max = self.parent:GetTalentValue("modifier_pangolier_buckle_7", "max", true)
self.max_distance = self.parent:GetTalentValue("modifier_pangolier_buckle_7", "distance", true)
self.timer = self.parent:GetTalentValue("modifier_pangolier_buckle_7", "timer", true)
self.radius = self.parent:GetTalentValue("modifier_pangolier_buckle_7", "radius", true)

self.move_bonus = self.parent:GetTalentValue("modifier_pangolier_buckle_2", "bonus", true)

self.blood_duration = self.parent:GetTalentValue("modifier_pangolier_buckle_4", "duration", true)

if not IsServer() then return end
self.pos = self.parent:GetAbsOrigin()

self.distance = 0
self.stack = 0
self.total = 0

self.old_pos = self.parent:GetAbsOrigin()

self:StartIntervalThink(1)
end


function modifier_pangolier_swashbuckle_custom_tracker:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
}
end


function modifier_pangolier_swashbuckle_custom_tracker:GetModifierMoveSpeedBonus_Constant()
if not self.parent:HasTalent("modifier_pangolier_buckle_2") then return end 
local bonus = self.parent:GetTalentValue("modifier_pangolier_buckle_2", "speed")
if self.parent:HasModifier("modifier_pangolier_swashbuckle_custom_speed") then 
    bonus = bonus * self.move_bonus
end
return bonus
end

function modifier_pangolier_swashbuckle_custom_tracker:DamageEvent_inc(params)
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_pangolier_buckle_7") then return end
if self.parent ~= params.unit then return end 
if (params.attacker:GetAbsOrigin() - params.unit:GetAbsOrigin()):Length2D() > self.radius then return end
if not params.attacker:IsUnit() then return end 

self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_swashbuckle_custom_legendary_combat", {duration = self.timer})
end


function modifier_pangolier_swashbuckle_custom_tracker:DamageEvent_out(params)
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_pangolier_buckle_7") then return end
if self.parent ~= params.attacker then return end 
if (params.attacker:GetAbsOrigin() - params.unit:GetAbsOrigin()):Length2D() > self.radius then return end
if not params.unit:IsUnit() then return end 
if params.inflictor and (params.inflictor:IsItem() or params.inflictor:GetName() == "generic_aoe_damage") and params.unit:IsCreep() then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_swashbuckle_custom_legendary_combat", {duration = self.timer})
end


function modifier_pangolier_swashbuckle_custom_tracker:OnIntervalThink()
if not IsServer() then return end

local pass = (self.parent:GetAbsOrigin() - self.pos):Length2D()
self.pos = self.parent:GetAbsOrigin()

if not self.parent:HasTalent("modifier_pangolier_buckle_7") then return end

if not self.particle then 
    self.parent:UpdateUIlong({max = self.max*self.max_distance, stack = self.max_distance*self:GetStackCount() + self.distance, override_stack = self:GetStackCount(), style = "PangolierSwash"})
    self.particle = ParticleManager:CreateParticle("particles/pangolier/buckle_stacks.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
    self:AddParticle(self.particle, false, false, -1, false, false)
    self:OnStackCountChanged()
end

local heroes = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false )

if #heroes > 0 then 
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_swashbuckle_custom_legendary_combat", {duration = self.timer})
end

if not self.parent:HasModifier("modifier_pangolier_swashbuckle_custom_legendary_combat") then
    if self:GetStackCount() > 0 then 
        self:DecrementStackCount()
    else
        self.distance = 0 
    end
    self:StartIntervalThink(0.1)
    return
end

if pass > 1500 then return end
if self.parent:HasModifier("modifier_pangolier_swashbuckle_custom_dash") then return end
if self.parent:HasModifier("modifier_pangolier_swashbuckle_custom_attacks") then return end

local final = self.distance + pass

if final >= self.max_distance then 

    local delta = math.floor(final/self.max_distance)

    for i = 1, delta do 

        if self:GetStackCount() < self.max then 
            self:IncrementStackCount()
        end
    end 

    self.distance = final - delta*self.max_distance
else 
    self.distance = final
end 

self.parent:UpdateUIlong({max = self.max*self.max_distance, stack = self.max_distance*self:GetStackCount() + self.distance, override_stack = self:GetStackCount(), style = "PangolierSwash"})
self:StartIntervalThink(0.1)
end


function modifier_pangolier_swashbuckle_custom_tracker:OnStackCountChanged(iStackCount)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_pangolier_buckle_7") then return end

if self:GetStackCount() == 0 then 
    self.distance = 0
end

self.parent:UpdateUIlong({max = self.max*self.max_distance, stack = self.max_distance*self:GetStackCount() + self.distance, override_stack = self:GetStackCount(), style = "PangolierSwash"})
   
if not self.particle then return end
for i = 1, self.max do 
    if i <= self:GetStackCount() then 
        ParticleManager:SetParticleControl(self.particle, i, Vector(1, 0, 0))   
    else 
        ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0))   
    end
end

end



function modifier_pangolier_swashbuckle_custom_tracker:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end 

local mod = self.parent:FindModifierByName("modifier_pangolier_swashbuckle_custom_range")
if mod and not params.no_attack_cooldown then 
    local dir = (params.target:GetAbsOrigin() - self.parent:GetAbsOrigin()):Normalized()
    local range = 800

    for i = 1,2 do
        local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_pangolier/pangolier_swashbuckler.vpcf", PATTACH_POINT_FOLLOW, self.parent )
        ParticleManager:SetParticleControlEnt( effect_cast, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
        ParticleManager:SetParticleControl( effect_cast, 1, dir*range )
        ParticleManager:SetParticleControl( effect_cast, 3, dir*range )

        Timers:CreateTimer(0.2, function()
            if effect_cast then 
                ParticleManager:DestroyParticle(effect_cast, false)
                ParticleManager:ReleaseParticleIndex(effect_cast)
            end
        end)
    end

    if self.ability:GetAutoCastState() then 
        self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_swashbuckle_custom_blink", {target = params.target:entindex(), duration = self.parent:GetTalentValue("modifier_pangolier_buckle_5", "blink_duration")})
    end
    
    params.target:AddNewModifier(self.parent, self.ability, "modifier_pangolier_swashbuckle_custom_leash", {duration = (1 - params.target:GetStatusResistance())*self.parent:GetTalentValue("modifier_pangolier_buckle_5", "leash")})

    self.parent:EmitSound("Hero_Pangolier.Swashbuckle")
    self.parent:EmitSound("Hero_Pangolier.Swashbuckle.Attack")
    params.target:EmitSound("Hero_Pangolier.LuckyShot.Proc")
    mod:Destroy()
end


if not self.parent:HasTalent("modifier_pangolier_buckle_4") then return end



params.target:AddNewModifier(self.parent, self.ability, "modifier_pangolier_swashbuckle_custom_blood", {duration = self.blood_duration})
end







modifier_pangolier_swashbuckle_custom_stun = class({})
function modifier_pangolier_swashbuckle_custom_stun:IsHidden() return true end
function modifier_pangolier_swashbuckle_custom_stun:IsPurgable() return false end
function modifier_pangolier_swashbuckle_custom_stun:CheckState()
return
{
    [MODIFIER_STATE_STUNNED] = true
}
end









modifier_pangolier_swashbuckle_custom_blood = class({})

function modifier_pangolier_swashbuckle_custom_blood:IsHidden() return false end
function modifier_pangolier_swashbuckle_custom_blood:IsPurgable() return false end
function modifier_pangolier_swashbuckle_custom_blood:GetTexture() return "buffs/spray_slow" end
function modifier_pangolier_swashbuckle_custom_blood:OnCreated(table)

self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.interval = self.caster:GetTalentValue("modifier_pangolier_buckle_4", "interval")
self.duration = self.caster:GetTalentValue("modifier_pangolier_buckle_4", "duration")
self.damage = self.interval*((self.caster:GetTalentValue("modifier_pangolier_buckle_4", "damage")/self.duration)/100)
self.heal = self.caster:GetTalentValue("modifier_pangolier_buckle_4", "heal")/100
self.max = self.caster:GetTalentValue("modifier_pangolier_buckle_4", "max") 

if self.parent:IsCreep() then 
    self.heal = self.heal/self.caster:GetTalentValue("modifier_pangolier_buckle_4", "creeps")
end

self.damage_table = {victim = self.parent, attacker = self.caster, ability = self.ability,  damage_type = DAMAGE_TYPE_MAGICAL}


if not IsServer() then return end
self:SetStackCount(1)
self:StartIntervalThink(self.interval)
end


function modifier_pangolier_swashbuckle_custom_blood:OnIntervalThink()
if not IsServer() then return end 

self.damage_table.damage = self.damage*self.caster:GetAverageTrueAttackDamage(nil)*self:GetStackCount()

local real_damage = DoDamage(self.damage_table, "modifier_pangolier_buckle_4")
self.caster:GenericHeal(real_damage*self.heal, self.ability, true, nil, "modifier_pangolier_buckle_4")
end



function modifier_pangolier_swashbuckle_custom_blood:OnRefresh()
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 

self:IncrementStackCount()

if self:GetStackCount() >= self.max then 
    self.parent:EmitSound("DOTA_Item.Maim")
    self.parent:GenericParticle("particles/items2_fx/sange_maim.vpcf", self)
    self.parent:GenericParticle("particles/items2_fx/sange_maim.vpcf", self)
    self.parent:GenericParticle("particles/brist_proc.vpcf")
end

end





modifier_pangolier_swashbuckle_custom_legendary_combat = class({})
function modifier_pangolier_swashbuckle_custom_legendary_combat:IsHidden() return false end
function modifier_pangolier_swashbuckle_custom_legendary_combat:IsPurgable() return false end
function modifier_pangolier_swashbuckle_custom_legendary_combat:IsDebuff() return true end
function modifier_pangolier_swashbuckle_custom_legendary_combat:RemoveOnDeath() return false end







modifier_pangolier_swashbuckle_custom_speed = class({})
function modifier_pangolier_swashbuckle_custom_speed:IsHidden() return true end
function modifier_pangolier_swashbuckle_custom_speed:IsPurgable() return false end
function modifier_pangolier_swashbuckle_custom_speed:GetTexture() return "buffs/buckle_move" end
function modifier_pangolier_swashbuckle_custom_speed:GetEffectName()
return "particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf"
end







modifier_pangolier_swashbuckle_custom_parry = class({})
function modifier_pangolier_swashbuckle_custom_parry:IsHidden() return true end
function modifier_pangolier_swashbuckle_custom_parry:IsPurgable() return false end
function modifier_pangolier_swashbuckle_custom_parry:GetEffectName()
return "particles/items2_fx/vindicators_axe_armor.vpcf"
end

function modifier_pangolier_swashbuckle_custom_parry:OnCreated()
self.parent = self:GetParent()
self.damage_reduce = self.parent:GetTalentValue("modifier_pangolier_buckle_6", "damage_reduce")
end

function modifier_pangolier_swashbuckle_custom_parry:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_pangolier_swashbuckle_custom_parry:GetModifierIncomingDamage_Percentage()
if not IsServer() then return end

self.parent:EmitSound("Juggernaut.Parry")
local particle = ParticleManager:CreateParticle( "particles/jugg_parry.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_attack1", self.parent:GetAbsOrigin(), true )
ParticleManager:SetParticleControl( particle, 1, self.parent:GetAbsOrigin() )
ParticleManager:ReleaseParticleIndex(particle)

return self.damage_reduce
end

function modifier_pangolier_swashbuckle_custom_parry:GetStatusEffectName()
return "particles/status_fx/status_effect_minotaur_horn.vpcf"
end

function modifier_pangolier_swashbuckle_custom_parry:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end





modifier_pangolier_swashbuckle_custom_scepter = class({})
function modifier_pangolier_swashbuckle_custom_scepter:IsHidden() return true end
function modifier_pangolier_swashbuckle_custom_scepter:IsPurgable() return false end
function modifier_pangolier_swashbuckle_custom_scepter:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_pangolier_swashbuckle_custom_scepter:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self.range = self.ability:GetSpecialValueFor( "range" ) + self.parent:GetTalentValue("modifier_pangolier_buckle_2", "range")
self.radius = self.ability:GetSpecialValueFor( "start_radius" )

self.interval = self.ability:GetSpecialValueFor( "attack_interval" )
self.damage = self.ability:GetSpecialValueFor( "damage" )
self.strikes = self.ability:GetSpecialValueFor("scepter_strikes")

if self.parent:HasTalent("modifier_pangolier_buckle_3") then 
    self.damage = self.damage + self.parent:GetTalentValue("modifier_pangolier_buckle_3", "damage")*self.parent:GetAverageTrueAttackDamage(nil)/100
    self.crit  = self.parent:GetTalentValue("modifier_pangolier_buckle_3", "crit")
end

self.origin = self.parent:GetAbsOrigin()

self.count = 0

self:StartIntervalThink(self.interval)
self:OnIntervalThink()
end


function modifier_pangolier_swashbuckle_custom_scepter:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_OVERRIDE_ATTACK_DAMAGE,
    MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE
}
end


function modifier_pangolier_swashbuckle_custom_scepter:GetModifierOverrideAttackDamage()
return self.damage
end


function modifier_pangolier_swashbuckle_custom_scepter:GetCritDamage() 
if not self.crit then return end
if self.count < self.strikes then return end
return self.crit
end

function modifier_pangolier_swashbuckle_custom_scepter:GetModifierPreAttack_CriticalStrike(params)
if not self.crit then return end
if self.count < self.strikes then return end
params.target:EmitSound("DOTA_Item.Daedelus.Crit")
return self.crit
end

function modifier_pangolier_swashbuckle_custom_scepter:OnIntervalThink()
if not IsServer() then return end

if self.parent:IsHexed() then 
    self:Destroy()
    return
end

self.count = self.count+1
if self.count>self.strikes then
    self:Destroy()
    return
end

self.parent:EmitSound("Hero_Pangolier.Swashbuckle")

self.targets = {}

for i = 1,4 do 

    self.dir = Vector(self.parent:GetForwardVector().x, self.parent:GetForwardVector().y, 0)
    self.target = self.origin + self.dir*self.range

    if i == 2 then
        self.target = RotatePosition(self.origin , QAngle(0, -90, 0), self.target)
    end
    if i == 3 then
        self.dir = Vector(self.parent:GetForwardVector().x, self.parent:GetForwardVector().y, 0) * -1
        self.target = self.origin + self.dir*self.range
    end
    if i == 4 then
        self.target = RotatePosition(self.origin , QAngle(0, 90, 0), self.target)
    end

    self.dir = (self.target - self.origin):Normalized()

    local enemies = FindUnitsInLine(self.parent:GetTeamNumber(), self.origin, self.target, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY,  DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,  0 )

    for _,enemy in pairs(enemies) do
        if not self.targets[enemy] then 
            self.targets[enemy] = true
            self.ability:DealDamage(enemy, false, true)
        end
    end

    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_pangolier/pangolier_swashbuckler.vpcf", PATTACH_POINT, self.parent )
    ParticleManager:SetParticleControlEnt( effect_cast, 0, self.parent, PATTACH_ABSORIGIN, "attach_hitloc", self.parent:GetOrigin(), true )
    ParticleManager:SetParticleControl( effect_cast, 1, self.dir*self.range )
    ParticleManager:SetParticleControl( effect_cast, 3, self.dir*self.range )
        
    self:AddParticle( effect_cast, false,  false, -1,  false, false )

    Timers:CreateTimer(0.2, function()
        if effect_cast then
            ParticleManager:DestroyParticle(effect_cast, false)
            ParticleManager:ReleaseParticleIndex(effect_cast)
        end
    end)

    self.parent:EmitSound("Hero_Pangolier.Swashbuckle.Attack")
end

end





modifier_pangolier_swashbuckle_custom_range = class({})
function modifier_pangolier_swashbuckle_custom_range:IsHidden() return false end
function modifier_pangolier_swashbuckle_custom_range:IsPurgable() return false end
function modifier_pangolier_swashbuckle_custom_range:GetTexture() return "buffs/buckle_attacks" end
function modifier_pangolier_swashbuckle_custom_range:OnCreated()
self.parent = self:GetParent()
self.range = self.parent:GetTalentValue("modifier_pangolier_buckle_5", "range")
self.RemoveForDuel = true
end

function modifier_pangolier_swashbuckle_custom_range:CheckState()
return
{
    [MODIFIER_STATE_CANNOT_MISS] = true
}
end

function modifier_pangolier_swashbuckle_custom_range:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
}
end

function modifier_pangolier_swashbuckle_custom_range:GetModifierAttackRangeBonus()
return self.range
end




modifier_pangolier_swashbuckle_custom_leash = class({})
function modifier_pangolier_swashbuckle_custom_leash:IsHidden() return true end
function modifier_pangolier_swashbuckle_custom_leash:IsPurgable() return true end
function modifier_pangolier_swashbuckle_custom_leash:CheckState()
return
{
    [MODIFIER_STATE_TETHERED] = true
}
end

function modifier_pangolier_swashbuckle_custom_leash:GetStatusEffectName()
return "particles/status_fx/status_effect_huskar_lifebreak.vpcf"
end

function modifier_pangolier_swashbuckle_custom_leash:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end

function modifier_pangolier_swashbuckle_custom_leash:GetEffectName()
return "particles/units/heroes/hero_sniper/sniper_headshot_slow.vpcf"
end

function modifier_pangolier_swashbuckle_custom_leash:GetEffectAttachType()
return PATTACH_OVERHEAD_FOLLOW
end

function modifier_pangolier_swashbuckle_custom_leash:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_pangolier_buckle_5", "slow")
end

function modifier_pangolier_swashbuckle_custom_leash:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_pangolier_swashbuckle_custom_leash:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end






modifier_pangolier_swashbuckle_custom_blink = class({})
function modifier_pangolier_swashbuckle_custom_blink:IsHidden() return true end
function modifier_pangolier_swashbuckle_custom_blink:IsPurgable() return true end

function modifier_pangolier_swashbuckle_custom_blink:OnCreated(kv)
if not IsServer() then return end

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:GenericParticle("particles/items_fx/force_staff.vpcf", self)

self.parent:EmitSound("Pango.Swash_blink")

local target = EntIndexToHScript(kv.target)

self.angle = -1*(target:GetAbsOrigin() - self.parent:GetAbsOrigin()):Normalized()
self.distance = self.parent:GetTalentValue("modifier_pangolier_buckle_5", "distance") / ( self:GetDuration() / FrameTime())

if self:ApplyHorizontalMotionController() == false then
    self:Destroy()
end

end

function modifier_pangolier_swashbuckle_custom_blink:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_DISABLE_TURNING,
    MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end

function modifier_pangolier_swashbuckle_custom_blink:CheckState()
return
{
    [MODIFIER_STATE_STUNNED] = true,
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
end

function modifier_pangolier_swashbuckle_custom_blink:GetOverrideAnimation() return ACT_DOTA_CAST_ABILITY_1 end


function modifier_pangolier_swashbuckle_custom_blink:GetModifierDisableTurning() return 1 end
function modifier_pangolier_swashbuckle_custom_blink:GetStatusEffectName() return "particles/status_fx/status_effect_forcestaff.vpcf" end
function modifier_pangolier_swashbuckle_custom_blink:StatusEffectPriority() return MODIFIER_PRIORITY_NORMAL  end
function modifier_pangolier_swashbuckle_custom_blink:GetEffectName() return "particles/units/heroes/hero_pangolier/pangolier_swashbuckler_dash.vpcf" end

function modifier_pangolier_swashbuckle_custom_blink:OnDestroy()
if not IsServer() then return end
self.parent:InterruptMotionControllers( true )
local dir = self.parent:GetForwardVector()
dir.z = 0
self.parent:SetForwardVector(dir)
self.parent:FaceTowards(self.parent:GetAbsOrigin() + dir*10)

ResolveNPCPositions(self.parent:GetAbsOrigin(), 128)
end


function modifier_pangolier_swashbuckle_custom_blink:UpdateHorizontalMotion( me, dt )
if not IsServer() then return end
local pos = self.parent:GetAbsOrigin()
GridNav:DestroyTreesAroundPoint(pos, 80, false)
local pos_p = self.angle * self.distance
local next_pos = GetGroundPosition(pos + pos_p,self.parent)
self.parent:SetAbsOrigin(next_pos)
end

function modifier_pangolier_swashbuckle_custom_blink:OnHorizontalMotionInterrupted()
self:Destroy()
end


modifier_pangolier_swashbuckle_custom_slow = class(mod_hidden)
function modifier_pangolier_swashbuckle_custom_slow:IsPurgable() return true end
function modifier_pangolier_swashbuckle_custom_slow:OnCreated()
self.slow = self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_pangolier_swashbuckle_custom_slow:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_pangolier_swashbuckle_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end