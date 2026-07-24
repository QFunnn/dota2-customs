--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom_gobble", "abilities/snapfire/snapfire_gobble_up_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom_gobble_caster", "abilities/snapfire/snapfire_gobble_up_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom_gobble_slow", "abilities/snapfire/snapfire_gobble_up_custom", LUA_MODIFIER_MOTION_NONE )



snapfire_gobble_up_custom = class({})

function snapfire_gobble_up_custom:GetCastRange(vLocation, hTarget)

if not self:GetCaster():HasModifier("modifier_snapfire_mortimer_kisses_custom_gobble_caster") then 
    return self:GetSpecialValueFor("cast_range_eat")
end

if IsClient() then 
    return self:GetSpecialValueFor("cast_range_spit")
else 
    return 999999
end

end

function snapfire_gobble_up_custom:GetCastAnimation()

if not self:GetCaster():HasModifier("modifier_snapfire_mortimer_kisses_custom_gobble_caster") then 
    return ACT_DOTA_CAST_ABILITY_1
end
return ACT_DOTA_CAST_ABILITY_4
end


function snapfire_gobble_up_custom:GetBehavior()
if not self:GetCaster():HasModifier("modifier_snapfire_mortimer_kisses_custom_gobble_caster") then 
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE
end
return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE
end

function snapfire_gobble_up_custom:GetManaCost(iLevel)
if not self:GetCaster():HasModifier("modifier_snapfire_mortimer_kisses_custom_gobble_caster") then 
    return self.BaseClass.GetManaCost(self, iLevel)
end
return 0
end

function snapfire_gobble_up_custom:CastFilterResultTarget(target)
if not IsServer() then return end
local caster = self:GetCaster()

if target:GetTeamNumber() == DOTA_TEAM_CUSTOM_5 then
    return UF_FAIL_OTHER
end

return UnitFilter( target, self:GetAbilityTargetTeam(), self:GetAbilityTargetType(), self:GetAbilityTargetFlags(), self:GetCaster():GetTeamNumber() )
end


function snapfire_gobble_up_custom:OnSpellStart()
local caster = self:GetCaster()

if not caster:HasModifier("modifier_snapfire_mortimer_kisses_custom_gobble_caster") then 

    local target = self:GetCursorTarget()

    if target:TriggerSpellReflect(self) then 
        return
    end

    if target:TriggerSpellAbsorb(self) then 
        return
    end

    if caster:HasModifier("modifier_snapfire_mortimer_kisses_custom_gobble") then 
        return
    end

    caster:EmitSound("Hero_Snapfire.GobbleUp.Cast")

    local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_doom_bringer/doom_bringer_devour.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControlEnt(pfx, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(pfx, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(pfx)

    self.target = target

    self.target:AddNewModifier(caster, self, "modifier_snapfire_mortimer_kisses_custom_gobble", {duration = self:GetSpecialValueFor("duration")})
    caster:AddNewModifier(caster, self, "modifier_snapfire_mortimer_kisses_custom_gobble_caster", {duration = self:GetSpecialValueFor("duration")})

    self:EndCd(0)
    self:StartCooldown(0.5)
    return
end

self:ThrowTarget(self:GetCursorPosition())
end


function snapfire_gobble_up_custom:ThrowTarget(spit_point)
if not self.target or self.target:IsNull() then return end

local caster = self:GetCaster()
local distance = self:GetSpecialValueFor("cast_range_spit")

local point = caster:GetAbsOrigin() + caster:GetForwardVector()*distance

if spit_point then
    point = spit_point
end

if point == caster:GetAbsOrigin() then 
    point = caster:GetAbsOrigin() + caster:GetForwardVector()*10
end
point = GetGroundPosition(point, nil)

local dir = (point - caster:GetAbsOrigin())
local point = caster:GetAbsOrigin() + dir:Normalized()*distance
local speed = self:GetSpecialValueFor("speed")
local height = 150  

local main_ability = caster:FindAbilityByName("snapfire_mortimer_kisses_custom")
if main_ability and main_ability:IsTrained() then 
    main_ability:LauchBall(caster:GetAbsOrigin() + caster:GetForwardVector()*distance, "scepter")
end

local target_mod = self.target:FindModifierByName("modifier_snapfire_mortimer_kisses_custom_gobble")

if target_mod then 
    target_mod.throw = true
    target_mod:Destroy()
end

self.target:EmitSound("Hero_Snapfire.SpitOut.Projectile")
self.target:EmitSound("Hero_Snapfire.MortimerGrunt")

FindClearSpaceForUnit(self.target, caster:GetAbsOrigin() + caster:GetForwardVector()*5, false)

local arc = self.target:AddNewModifier(caster, self, "modifier_generic_arc",
{
    target_x = point.x,
    target_y = point.y,
    distance = distance,
    speed = speed,
    height = height,
    fix_end = false,
    isStun = true,
    activity = ACT_DOTA_FLAIL,
})

local target = self.target

if arc then 
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_snapfire/snapfire_flaming_creep.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.target )
    ParticleManager:SetParticleControlEnt( effect_cast, 3, self.target, PATTACH_POINT_FOLLOW, "attach_hitloc", self.target:GetOrigin(), true )
    ParticleManager:SetParticleControlEnt( effect_cast, 5, self.target, PATTACH_POINT_FOLLOW, "attach_hitloc", self.target:GetOrigin(), true )
    arc:AddParticle( effect_cast, false, false, -1, false, false)

    arc:SetEndCallback(function()
        GridNav:DestroyTreesAroundPoint( target:GetAbsOrigin(), 400, true )
        target:AddNewModifier(target, nil, "modifier_generic_passing", {duration = 3})
        target:AddNewModifier(target, self, "modifier_snapfire_mortimer_kisses_custom_gobble_slow", {duration = (1 - target:GetStatusResistance())*self:GetSpecialValueFor("move_slow_duration")})
    end)
end

self.target = nil
self:UseResources(false, false, false, true)
end



modifier_snapfire_mortimer_kisses_custom_gobble = class({})
function modifier_snapfire_mortimer_kisses_custom_gobble:IsHidden() return false end
function modifier_snapfire_mortimer_kisses_custom_gobble:IsPurgable() return false end
function modifier_snapfire_mortimer_kisses_custom_gobble:CheckState()
return
{
    [MODIFIER_STATE_INVULNERABLE] = true,
    [MODIFIER_STATE_OUT_OF_GAME] = true,
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    [MODIFIER_STATE_STUNNED] = true,
    [MODIFIER_STATE_SILENCED] = true,
    [MODIFIER_STATE_DISARMED] = true,
    [MODIFIER_STATE_MUTED] = true,
    [MODIFIER_STATE_MAGIC_IMMUNE] = true,
    [MODIFIER_STATE_UNSELECTABLE] = true,
}
end




function modifier_snapfire_mortimer_kisses_custom_gobble:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.parent:NoDraw(self)

self.parent:AddNoDraw()
self.range = self.ability:GetSpecialValueFor("cast_range_eat")
self.throw = false

self.RemoveForDuel = true
self.max_time = self:GetRemainingTime()

self:StartIntervalThink(FrameTime())
end

function modifier_snapfire_mortimer_kisses_custom_gobble:OnIntervalThink()
if not IsServer() then return end

if not self.caster or self.caster:IsNull() or not self.caster:IsAlive() then
    self:Destroy()
    return
end

if not self.parent or self.parent:IsNull() or not self.parent:IsAlive() then
    self:Destroy()
    return
end

self.caster:UpdateUIshort({max_time = self.max_time, time = self:GetRemainingTime(), stack = self:GetRemainingTime(), priority = 1, use_zero = 1, style = "SnapfireScepter"})
self.parent:SetAbsOrigin(self.caster:GetAbsOrigin())
end

function modifier_snapfire_mortimer_kisses_custom_gobble:OnDestroy()
if not IsServer() then return end

self.caster:UpdateUIshort({hide = 1, hide_full = 1, priority = 1, style = "SnapfireScepter"})
self.caster:RemoveModifierByName("modifier_snapfire_mortimer_kisses_custom_gobble_caster")
self.parent:RemoveNoDraw()

if self.throw == true then return end
self.ability:ThrowTarget()
end



modifier_snapfire_mortimer_kisses_custom_gobble_caster = class({})
function modifier_snapfire_mortimer_kisses_custom_gobble_caster:IsHidden() return false end
function modifier_snapfire_mortimer_kisses_custom_gobble_caster:IsPurgable() return false end
function modifier_snapfire_mortimer_kisses_custom_gobble_caster:GetEffectName()
return "particles/units/heroes/hero_life_stealer/life_stealer_infested_unit_icon.vpcf"
end

function modifier_snapfire_mortimer_kisses_custom_gobble_caster:GetEffectAttachType()
return PATTACH_OVERHEAD_FOLLOW
end






modifier_snapfire_mortimer_kisses_custom_gobble_slow = class({})
function modifier_snapfire_mortimer_kisses_custom_gobble_slow:IsHidden() return true end
function modifier_snapfire_mortimer_kisses_custom_gobble_slow:IsPurgable() return true end
function modifier_snapfire_mortimer_kisses_custom_gobble_slow:OnCreated(table)
self.slow = self:GetAbility():GetSpecialValueFor("move_slow")
end

function modifier_snapfire_mortimer_kisses_custom_gobble_slow:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_snapfire_mortimer_kisses_custom_gobble_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end