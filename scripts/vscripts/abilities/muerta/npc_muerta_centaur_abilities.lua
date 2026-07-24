--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_npc_muerta_centaur_chrarge", "abilities/muerta/npc_muerta_centaur_abilities", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_npc_muerta_centaur_stuns_cast", "abilities/muerta/npc_muerta_centaur_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_npc_muerta_centaur_passive", "abilities/muerta/npc_muerta_centaur_abilities", LUA_MODIFIER_MOTION_NONE)

npc_muerta_centaur_charge = class({})

function npc_muerta_centaur_charge:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/generic_gameplay/generic_has_quest.vpcf", context )
PrecacheResource( "particle", "particles/items_fx/force_staff.vpcf", context )
PrecacheResource( "particle", "particles/lc_odd_charge.vpcf", context )
PrecacheResource( "particle", "particles/status_fx/status_effect_forcestaff.vpcf", context )
PrecacheResource( "particle", "particles/neutral_fx/neutral_centaur_khan_war_stomp.vpcf", context )
PrecacheResource( "particle", "particles/red_zone.vpcf", context )

end

function npc_muerta_centaur_charge:Spawn()
if not self:GetCaster() then return end
self.caster = self:GetCaster()

self.range = self:GetLevelSpecialValueFor("range", 1)
self.speed = self:GetLevelSpecialValueFor("speed", 1)
self.stun = self:GetLevelSpecialValueFor("stun", 1)
self.additional_range = self:GetLevelSpecialValueFor("additional_range", 1)
end

function npc_muerta_centaur_charge:OnAbilityPhaseStart()
self.sign = ParticleManager:CreateParticle("particles/generic_gameplay/generic_has_quest.vpcf", PATTACH_OVERHEAD_FOLLOW, self.caster)
self.caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 0.7)
self.caster:EmitSound("n_creep_Centaur.Stomp")
return true
end 

function npc_muerta_centaur_charge:OnAbilityPhaseInterrupted()
if self.sign then
    ParticleManager:DestroyParticle(self.sign, true)
    ParticleManager:ReleaseParticleIndex(self.sign)
    self.sign = nil
end

self.caster:FadeGesture(ACT_DOTA_CAST_ABILITY_1)
end

function npc_muerta_centaur_charge:OnSpellStart()

if self.sign then
    ParticleManager:DestroyParticle(self.sign, true)
    ParticleManager:ReleaseParticleIndex(self.sign)
end
self.sign = nil

local point =  self.caster:CastPosition(self:GetCursorPosition())
local vec = (point - self.caster:GetAbsOrigin())

point = point + vec:Normalized()*self.additional_range

local distance = (point - self.caster:GetAbsOrigin()):Length2D()
local duration = distance/self.speed

self.caster:AddNewModifier(self.caster, self, "modifier_npc_muerta_centaur_chrarge", {x = point.x, y = point.y, distance = distance, duration = duration})
end
    
modifier_npc_muerta_centaur_chrarge = class(mod_hidden)
function modifier_npc_muerta_centaur_chrarge:GetStatusEffectName() return "particles/status_fx/status_effect_forcestaff.vpcf" end
function modifier_npc_muerta_centaur_chrarge:StatusEffectPriority() return MODIFIER_PRIORITY_NORMAL end
function modifier_npc_muerta_centaur_chrarge:OnCreated(kv)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:GenericParticle("particles/items_fx/force_staff.vpcf", self)
self.parent:GenericParticle("particles/lc_odd_charge.vpcf", self)

self.point = GetGroundPosition(Vector(kv.x, kv.y, 0), nil)

self.parent:EmitSound("Lc.Odds_Charge")

self.angle = (self.point - self.parent:GetAbsOrigin()):Normalized() 
self.parent:SetForwardVector(self.angle)
self.parent:FaceTowards(self.point)

self.stun = self.ability.stun

self.targets = {}

if self:ApplyHorizontalMotionController() == false then
    self:Destroy()
end

end

function modifier_npc_muerta_centaur_chrarge:CheckState()
return
{
    [MODIFIER_STATE_SILENCED] = true,
    [MODIFIER_STATE_DISARMED] = true
}
end

function modifier_npc_muerta_centaur_chrarge:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_DISABLE_TURNING
}
end

function modifier_npc_muerta_centaur_chrarge:GetModifierDisableTurning() return 1 end

function modifier_npc_muerta_centaur_chrarge:UpdateHorizontalMotion( me, dt )
if not IsServer() then return end
local pos = self.parent:GetAbsOrigin()
GridNav:DestroyTreesAroundPoint(pos, 80, false)

local next_pos = GetGroundPosition(pos + self.angle * self.ability.speed*dt, self.parent)
self.parent:SetAbsOrigin(next_pos)

for _,unit in pairs(self.parent:FindTargets(170)) do
    if not self.targets[unit] then
        self.targets[unit] = true

        unit:AddNewModifier( self.parent, self.ability, "modifier_stunned", { duration = self.stun*(1 - unit:GetStatusResistance()) } )

        if not (unit:IsCurrentlyHorizontalMotionControlled() or unit:IsCurrentlyVerticalMotionControlled()) then
            local direction = unit:GetOrigin() - self.parent:GetOrigin()
            direction.z = 0
            direction = direction:Normalized()

            local knockbackProperties =
            {
                center_x = unit:GetOrigin().x,
                center_y = unit:GetOrigin().y,
                center_z = unit:GetOrigin().z,
                duration = 0.3,
                knockback_duration = 0.3,
                knockback_distance = 100,
                knockback_height = 50
            }
            unit:AddNewModifier( self.parent, self.ability, "modifier_knockback", knockbackProperties )
            unit:EmitSound("Hero_PrimalBeast.Onslaught.Hit")
        end
    end
end

end


function modifier_npc_muerta_centaur_chrarge:OnDestroy()
if not IsServer() then return end
self.parent:InterruptMotionControllers( true )
self.parent:FadeGesture(ACT_DOTA_RUN)
self.parent:FacePoint()
ResolveNPCPositions(self.parent:GetAbsOrigin(), 128)
end



npc_muerta_centaur_stun = class({})

function npc_muerta_centaur_stun:Spawn()
if not self:GetCaster() then return end
self.caster = self:GetCaster()

self.radius = self:GetLevelSpecialValueFor("radius", 1)
self.delay = self:GetLevelSpecialValueFor("delay", 1)
self.stun = self:GetLevelSpecialValueFor("stun", 1)
self.damage = self:GetLevelSpecialValueFor("damage", 1)/100
self.amount = self:GetLevelSpecialValueFor("amount", 1)
self.AbilityChannelTime = self:GetLevelSpecialValueFor("AbilityChannelTime", 1)
end

function npc_muerta_centaur_stun:GetChannelTime()
return self.AbilityChannelTime and self.AbilityChannelTime or 0
end

function npc_muerta_centaur_stun:OnSpellStart()
self.caster:AddNewModifier(self.caster, self, "modifier_npc_muerta_centaur_stuns_cast", {})
end

function npc_muerta_centaur_stun:OnChannelFinish(bInterrupted)
if not IsServer() then return end
if not bInterrupted then return end
self.caster:RemoveModifierByName("modifier_npc_muerta_centaur_stuns_cast")
end

modifier_npc_muerta_centaur_stuns_cast = class(mod_hidden)
function modifier_npc_muerta_centaur_stuns_cast:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.delay = self.ability.delay
self.damage = self.ability.damage
self.stun = self.ability.stun
self.radius = self.ability.radius
self.max = self.ability.amount

self.damageTable = {attacker = self.parent, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}

self:CastAnim()
self:SetStackCount(0)
self.count = 0

self:StartIntervalThink(self.delay)
end

function modifier_npc_muerta_centaur_stuns_cast:OnIntervalThink()
if not IsServer() then return end

self:IncrementStackCount()

self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_1)

if self.effect_cast then
    ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast)
end

local trail_pfx = ParticleManager:CreateParticle("particles/neutral_fx/neutral_centaur_khan_war_stomp.vpcf",  PATTACH_ABSORIGIN, self.parent)
ParticleManager:SetParticleControl(trail_pfx, 1, Vector(self.radius, 0, 0))
ParticleManager:ReleaseParticleIndex(trail_pfx)

for _,unit in pairs(self.parent:FindTargets(self.radius)) do 

    local damage = self.damage*unit:GetMaxHealth()
    self.damageTable.victim = unit
    self.damageTable.damage = damage

    unit:SendNumber(6, damage)

    DoDamage(self.damageTable)
    unit:AddNewModifier(self.parent, self.ability, "modifier_stunned", {duration = (1 - unit:GetStatusResistance())*self.stun})
end

if self:GetStackCount() < self.max then 
    self:CastAnim()
end

self.count = self.count + 1
if self.count >= self.max then 
    self:Destroy()
    return
end

end

function modifier_npc_muerta_centaur_stuns_cast:CastAnim()
if not IsServer() then return end
self.parent:EmitSound("n_creep_Centaur.Stomp")
self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 0.8)

self.effect_cast = ParticleManager:CreateParticle("particles/red_zone.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster())
ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetCaster():GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 0, -self.radius/self.delay) )
ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( self.delay, 0, 0 ) )
self:AddParticle(self.effect_cast, false, false, -1, false, false)
end

function modifier_npc_muerta_centaur_stuns_cast:OnDestroy()
if not IsServer() then return end
self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_1)
end



npc_muerta_centaur_passive = class({})

function npc_muerta_centaur_passive:GetIntrinsicModifierName()
return "modifier_npc_muerta_centaur_passive"
end

function npc_muerta_centaur_passive:Spawn()
if not self:GetCaster() then return end
self.caster = self:GetCaster()

self.attacks = self:GetLevelSpecialValueFor("attacks", 1)
self.stun = self:GetLevelSpecialValueFor("stun", 1)
end

modifier_npc_muerta_centaur_passive = class(mod_hidden)
function modifier_npc_muerta_centaur_passive:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
}
end

function modifier_npc_muerta_centaur_passive:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self:SetStackCount(0)
end

function modifier_npc_muerta_centaur_passive:GetModifierProcAttack_Feedback(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end

self:IncrementStackCount()

if self:GetStackCount() < self.ability.attacks then return end

self:SetStackCount(0)

params.target:EmitSound("Hero_Slardar.Bash")
params.target:AddNewModifier(self.parent, self.ability, "modifier_bashed", {duration = (1 - params.target:GetStatusResistance())*self.ability.stun})
end
