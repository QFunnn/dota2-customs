--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_custom_pudge_meat_hook", "abilities/pudge/custom_pudge_meat_hook", LUA_MODIFIER_MOTION_NONE  )
LinkLuaModifier( "modifier_custom_pudge_meat_hook_debuff", "abilities/pudge/custom_pudge_meat_hook", LUA_MODIFIER_MOTION_HORIZONTAL  )
LinkLuaModifier( "modifier_custom_pudge_meat_hook_blood", "abilities/pudge/custom_pudge_meat_hook", LUA_MODIFIER_MOTION_NONE  )
LinkLuaModifier( "modifier_custom_pudge_meat_hook_root", "abilities/pudge/custom_pudge_meat_hook", LUA_MODIFIER_MOTION_NONE  )
LinkLuaModifier( "modifier_custom_pudge_meat_hook_speed", "abilities/pudge/custom_pudge_meat_hook", LUA_MODIFIER_MOTION_NONE  )
LinkLuaModifier( "modifier_custom_pudge_meat_hook_tracker", "abilities/pudge/custom_pudge_meat_hook", LUA_MODIFIER_MOTION_NONE  )
LinkLuaModifier( "modifier_custom_pudge_meat_hook_perma", "abilities/pudge/custom_pudge_meat_hook", LUA_MODIFIER_MOTION_NONE  )
LinkLuaModifier( "modifier_custom_pudge_meat_hook_stack", "abilities/pudge/custom_pudge_meat_hook", LUA_MODIFIER_MOTION_NONE  )
LinkLuaModifier( "modifier_custom_pudge_meat_hook_hidden", "abilities/pudge/custom_pudge_meat_hook", LUA_MODIFIER_MOTION_NONE  )
LinkLuaModifier( "modifier_custom_pudge_meat_hook_move_speed", "abilities/pudge/custom_pudge_meat_hook", LUA_MODIFIER_MOTION_NONE  )
LinkLuaModifier( "modifier_custom_pudge_meat_hook_move_slow", "abilities/pudge/custom_pudge_meat_hook", LUA_MODIFIER_MOTION_NONE  )
LinkLuaModifier( "modifier_custom_pudge_meat_hook_move_vision", "abilities/pudge/custom_pudge_meat_hook", LUA_MODIFIER_MOTION_NONE  )

custom_pudge_meat_hook = class({})

custom_pudge_meat_hook.hooks = {}
custom_pudge_meat_hook.legendary_hooks = {}
custom_pudge_meat_hook.legendary_targets = {}

function custom_pudge_meat_hook:GetAbilityTextureName()
local caster = self:GetCaster()
return wearables_system:GetAbilityIconReplacement(self.caster, "pudge_meat_hook", self)
end



function custom_pudge_meat_hook:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_pudge/pudge_meathook.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pudge/pudge_meathook_impact.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/hook_root.vpcf", context )
PrecacheResource( "particle","particles/lc_odd_proc_.vpcf", context )
PrecacheResource( "particle","particles/general/generic_armor_reduction.vpcf", context )
PrecacheResource( "particle","particles/pudge/hook_stack.vpcf", context )
PrecacheResource( "particle","particles/pudge/hook_no_model.vpcf", context )

--PrecacheResource( "particle","particles/econ/items/pudge/pudge_ti6_immortal/pudge_meathook_impact_ti6.vpcf", context )
--PrecacheResource( "particle","particles/econ/items/pudge/pudge_ti6_immortal/pudge_meathook_witness_impact_ti6.vpcf", context )
--PrecacheResource( "particle","particles/econ/items/pudge/pudge_ti6_immortal_gold/pudge_ti6_meathook_gold.vpcf", context )

--PrecacheResource( "particle","particles/econ/items/pudge/pudge_ti6_immortal/pudge_ti6_meathook.vpcf", context )
--PrecacheResource( "particle","particles/econ/items/pudge/pudge_ti6_immortal/pudge_ti6_witness_meathook.vpcf", context )
--PrecacheResource( "particle","particles/econ/items/pudge/pudge_hook_whale/pudge_meathook_whale.vpcf", context )

dota1x6:PrecacheShopItems("npc_dota_hero_pudge", context)
end



function custom_pudge_meat_hook:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_pudge_meat_hook_tracker"
end


function custom_pudge_meat_hook:GetCooldown(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_pudge_hook_4") then 
    bonus = self:GetCaster():GetTalentValue("modifier_pudge_hook_4", "cd")
end
return self.BaseClass.GetCooldown( self, level ) + bonus
end

function custom_pudge_meat_hook:GetCastPoint(iLevel)
local bonus = 1
if self:GetCaster():HasTalent("modifier_pudge_hook_2") then 
    bonus = 1 + self:GetCaster():GetTalentValue("modifier_pudge_hook_2", "cast")/100
end
return self.BaseClass.GetCastPoint(self)*bonus
end

function custom_pudge_meat_hook:GetManaCost(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_pudge_hook_3") then 
    bonus = self:GetCaster():GetTalentValue("modifier_pudge_hook_3", "mana")
end
return self.BaseClass.GetManaCost(self,level) + bonus
end

function custom_pudge_meat_hook:GetCastRange(location, target)
return self:GetRange()
end

function custom_pudge_meat_hook:GetRange()
return self:GetSpecialValueFor("hook_distance")*(1 + self:GetCaster():GetTalentValue("modifier_pudge_hook_2", "range")/100)
end


function custom_pudge_meat_hook:OnAbilityPhaseStart()
self:GetCaster():StartGesture( ACT_DOTA_OVERRIDE_ABILITY_1 )
return true
end

function custom_pudge_meat_hook:OnAbilityPhaseInterrupted()
self:GetCaster():RemoveGesture( ACT_DOTA_OVERRIDE_ABILITY_1 )
end

function custom_pudge_meat_hook:OnSpellStart()
local caster = self:GetCaster()

self.hook_sound_extend = wearables_system:GetSoundReplacement(self:GetCaster(), "Hero_Pudge.AttackHookExtend", self)
self.hook_sound_retract = wearables_system:GetSoundReplacement(self:GetCaster(), "Hero_Pudge.AttackHookRetract", self)

for id, hook in pairs(self.hooks) do
    if hook ~= nil then
        if self.hooks[id].hVictim and not self.hooks[id].hVictim:IsNull() then
    
            self.hooks[id].hVictim:RemoveModifierByName("modifier_custom_pudge_meat_hook_debuff")
        
            if self.hooks[id].hVictim and self.hooks[id].hVictim:GetUnitName() == "npc_dota_companion" then 
                UTIL_Remove(self.hooks[id].hVictim)
            end

             if self.hooks[id].thinker then 
                UTIL_Remove(self.hooks[id].thinker)
            end
        end
        ProjectileManager:DestroyLinearProjectile(id)
    end
end

self.hooks = {}
self.legendary_hooks = {}

local caster_position = caster:GetOrigin()
local point = self:GetCursorPosition()

if point == caster_position then 
    point = point + caster:GetForwardVector()*5
end

local direction = CalculateDirection(point, caster_position)
local distance = (point - caster:GetAbsOrigin()):Length2D()

self:UseHook(direction, distance)

if caster and caster:IsHero() then
    local hHook = caster:GetTogglableWearable( DOTA_LOADOUT_TYPE_WEAPON )
    if hHook ~= nil then
        hHook:AddEffects( EF_NODRAW )
    end
    caster:AddNewModifier(caster, self, "modifier_custom_pudge_meat_hook_hidden", {})
    local pudge_hook = caster:GetItemWearableHandle("weapon")
    if caster:GetModelName() == "models/heroes/pudge_cute/pudge_cute.vmdl" then
        pudge_hook = caster:GetItemWearableHandle("weapon_persona_1")
    end
    if pudge_hook then
        pudge_hook:AddNoDraw()
    end
end

if caster:HasTalent("modifier_pudge_hook_legendary") then  
    local angle = caster:GetTalentValue("modifier_pudge_hook_legendary", "angle")
    local hook_count = caster:GetTalentValue("modifier_pudge_hook_legendary", "count")
    for i = 1, hook_count do
        local newAngle = angle * math.ceil(i / 2) * (-1)^i
        local newDir = RotateVector2D( direction, ToRadians( newAngle ) )
        self:UseHook( newDir, distance )
    end
end

end


function custom_pudge_meat_hook:CheckHooksLegendary()
local targets_hit = {}
local clear_index = {}

for _,index in pairs(self.legendary_hooks) do
    if index == 0 then
        return
    else
        targets_hit[index] = true
    end
end

for index,_ in pairs(self.legendary_targets) do
    if not targets_hit[index] then
        clear_index[#clear_index + 1] = index
    end
end

if #clear_index == 0 then return end

for i = 1,#clear_index do
    local target = EntIndexToHScript(clear_index[i])
    if target and not target:IsNull() then
        target:RemoveModifierByName("modifier_custom_pudge_meat_hook_stack")
    end
end

end



function RotateVector2D(vector, theta)
local xp = vector.x*math.cos(theta)-vector.y*math.sin(theta)
local yp = vector.x*math.sin(theta)+vector.y*math.cos(theta)

return Vector(xp,yp,vector.z):Normalized()
end

function ToRadians(degrees)
return degrees * math.pi / 180
end

function CalculateDirection(ent1, ent2)
local pos1 = ent1
local pos2 = ent2
if ent1.GetAbsOrigin then pos1 = ent1:GetAbsOrigin() end
if ent2.GetAbsOrigin then pos2 = ent2:GetAbsOrigin() end
local direction = (pos1 - pos2)
direction.z = 0

return direction:Normalized()
end



function custom_pudge_meat_hook:UseHook( direction, distance )

local caster = self:GetCaster()
self.hook_width = self:GetSpecialValueFor( "hook_width" )
self.hook_distance = self:GetRange() + caster:GetCastRangeBonus()
self.hook_speed = self:GetSpecialValueFor( "hook_speed" )*(1 + caster:GetTalentValue("modifier_pudge_hook_2", "speed")/100)

self.hook_followthrough_constant = 0.65

local caster_location = caster:GetOrigin()
local flFollowthroughDuration = ( self.hook_distance / self.hook_speed ) * self.hook_followthrough_constant 

caster:AddNewModifier( caster, self, "modifier_custom_pudge_meat_hook", { duration = flFollowthroughDuration } )

self.vHookOffset = Vector( 0, 0, 96 )
local vHookTarget = (caster_location + (direction * self.hook_distance)) + self.vHookOffset
local vKillswitch = Vector( ( ( self.hook_distance / self.hook_speed ) * 2 ), 0, 0 )

local pudge_meat_hook_particle = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/units/heroes/hero_pudge/pudge_meathook.vpcf", self)

local attach_point = "attach_weapon_chain_rt"
if caster:GetUnitName() ~= "npc_dota_hero_pudge" then
    pudge_meat_hook_particle = "particles/pudge/hook_no_model.vpcf"
    attach_point = "attach_attack1"
end

local hook_particle = ParticleManager:CreateParticle( pudge_meat_hook_particle, PATTACH_CUSTOMORIGIN, nil )
ParticleManager:SetParticleAlwaysSimulate( hook_particle )

ParticleManager:SetParticleControlEnt( hook_particle, 0, caster, PATTACH_POINT_FOLLOW, attach_point, caster:GetOrigin() + self.vHookOffset, true )
ParticleManager:SetParticleControl( hook_particle, 1, vHookTarget )
ParticleManager:SetParticleControl( hook_particle, 2, Vector( self.hook_speed, self.hook_distance, self.hook_width ) )
ParticleManager:SetParticleControl( hook_particle, 3, vKillswitch )
ParticleManager:SetParticleControl( hook_particle, 4, Vector( 1, 0, 0 ) )
ParticleManager:SetParticleControl( hook_particle, 5, Vector( 0, 0, 0 ) )
ParticleManager:SetParticleControlEnt( hook_particle, 7, caster, PATTACH_CUSTOMORIGIN, nil, caster:GetOrigin(), true )

local hHook = caster:GetTogglableWearable( DOTA_LOADOUT_TYPE_WEAPON )
if hHook ~= nil then    
    ParticleManager:SetParticleControlEnt( hook_particle, 7, hHook, PATTACH_CUSTOMORIGIN, nil, hHook:GetOrigin(), true )
end

local pudge_hook = caster:GetItemWearableHandle("weapon")
if caster:GetModelName() == "models/heroes/pudge_cute/pudge_cute.vmdl" then
    pudge_hook = caster:GetItemWearableHandle("weapon_persona_1")
end
if pudge_hook then
    ParticleManager:SetParticleControlEnt( hook_particle, 7, pudge_hook, PATTACH_CUSTOMORIGIN, nil, pudge_hook:GetOrigin(), true )
end

ParticleManager:SetParticleShouldCheckFoW( hook_particle, false )
ParticleManager:SetParticleAlwaysSimulate(hook_particle)
ParticleManager:SetParticleFoWProperties( hook_particle, 0, 7, 3000 )
local thinker = CreateModifierThinker(caster, self, "modifier_invulnerable",  {}, caster:GetOrigin(), caster:GetTeamNumber(), false )

local info = 
{
    Ability = self,
    vSpawnOrigin = caster:GetOrigin(),
    vVelocity = direction * self.hook_speed,
    fDistance = self.hook_distance,
    fStartRadius = self.hook_width ,
    fEndRadius = self.hook_width ,
    Source = caster,
    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_BOTH,
    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
    iVisionRadius = 300,--
    iVisionTeamNumber = caster:GetTeamNumber(),
    bProvidesVision = true,
}

local projectileIndex = ProjectileManager:CreateLinearProjectile( info )

if caster:HasTalent("modifier_pudge_hook_legendary") then
    self.legendary_hooks[projectileIndex] = 0
end

self.hooks[projectileIndex] = {}
self.hooks[projectileIndex].particleIndex = hook_particle
self.hooks[projectileIndex].hook_speed = self.hook_speed
self.hooks[projectileIndex].hook_width = self.hook_width
self.hooks[projectileIndex].bRetracting = false
self.hooks[projectileIndex].hVictim = nil
self.hooks[projectileIndex].bDiedInHook = false
self.hooks[projectileIndex].direction = caster_location * (direction * self.hook_distance)
self.hooks[projectileIndex].start_position = caster_location
self.hooks[projectileIndex].proj_location = nil
self.hooks[projectileIndex].thinker = thinker
EmitSoundOn(self.hook_sound_extend, self.hooks[projectileIndex].thinker)
end


function custom_pudge_meat_hook:OnProjectileHitHandle( target, position, projectileIndex )
if not IsServer() then return end

local caster = self:GetCaster()
if target == caster then return false end
if self.hooks[projectileIndex] == nil then return true end
if not self.hooks[projectileIndex].thinker or self.hooks[projectileIndex].thinker:IsNull() then return end

if self.hooks[projectileIndex].bRetracting == false then

    if target ~= nil and (not (target:IsCreep() or target:IsConsideredHero())) then
        return false
    end

    local target_index = -1

    local bTargetPulled = false
    if target ~= nil then

        if target:HasModifier("modifier_custom_pudge_meat_hook_debuff") or  target:GetUnitName() == "npc_teleport" or target:GetUnitName() == "npc_psi_blades_crystal" or target:GetUnitName() == "npc_psi_blades_crystal_mini" then 
            return false
        end

        self.hooks[projectileIndex].thinker:StopSound(self.hook_sound_extend)

        if caster:HasModifier("modifier_custom_pudge_meat_hook") then 
            caster:RemoveModifierByName("modifier_custom_pudge_meat_hook")
        end

        target:EmitSound(wearables_system:GetSoundReplacement(self:GetCaster(), "Hero_Pudge.AttackHookImpact", self))

        if not target:HasModifier("modifier_waveupgrade_boss") and not target:IsFieldInvun(caster) then 

            local dist = 0
            if self.hooks[projectileIndex].start_position then
                dist = (self.hooks[projectileIndex].start_position - target:GetAbsOrigin()):Length2D()
            end
            target:AddNewModifier( caster, self, "modifier_custom_pudge_meat_hook_debuff", {dist = dist} )
        end

        local damage = self:GetSpecialValueFor("damage") + caster:GetAverageTrueAttackDamage(nil)*caster:GetTalentValue("modifier_pudge_hook_1", "damage")/100
        local vision_radius = self:GetSpecialValueFor( "vision_radius" )  
        local vision_duration = self:GetSpecialValueFor( "vision_duration" )  

        if target:GetTeamNumber() ~= caster:GetTeamNumber() then

            local damage_table = {  victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self }

            if caster:GetQuest() == "Pudge.Quest_5" and target:IsRealHero() and (caster:GetAbsOrigin() - target:GetAbsOrigin()):Length2D() >= caster.quest.number then 
                caster:UpdateQuest(1)
            end

            if target:IsValidKill(caster) then 
                caster:AddNewModifier(caster, self, "modifier_custom_pudge_meat_hook_perma", {})
            end

            DoDamage( damage_table )

            if caster:HasTalent("modifier_pudge_hook_legendary") then 
                target:AddNewModifier(caster, self, "modifier_custom_pudge_meat_hook_stack", {duration = caster:GetTalentValue("modifier_pudge_hook_legendary", "duration")})
            end 

            if caster:HasTalent("modifier_pudge_hook_1") or caster:HasTalent("modifier_pudge_hook_3") then 
                caster:AddNewModifier(caster, self, "modifier_custom_pudge_meat_hook_speed", {duration = caster:GetTalentValue("modifier_pudge_hook_1", "duration", true)})
            end

            if caster:HasTalent("modifier_pudge_hook_5") then
                local duration = caster:GetTalentValue("modifier_pudge_hook_5", "duration")
                caster:AddNewModifier(caster, self, "modifier_custom_pudge_meat_hook_move_speed", {duration = duration})
                target:AddNewModifier(caster, self, "modifier_custom_pudge_meat_hook_move_slow", {duration = duration})
            end

            if not target:IsAlive() then self.hooks[projectileIndex].bDiedInHook = true end
            if not target:IsMagicImmune() then target:Interrupt() end

            local impact_particle_d = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/units/heroes/hero_pudge/pudge_meathook_impact.vpcf", self)
            local nFXIndex = ParticleManager:CreateParticle( impact_particle_d, PATTACH_CUSTOMORIGIN, target )
            ParticleManager:SetParticleControlEnt( nFXIndex, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetOrigin(), true )
            ParticleManager:ReleaseParticleIndex( nFXIndex )
        end

        AddFOWViewer( caster:GetTeamNumber(), target:GetOrigin(), vision_radius, vision_duration, false )

        if not target:HasModifier("modifier_waveupgrade_boss") and not target:IsFieldInvun(caster) then 
            self.hooks[projectileIndex].hVictim = target
            bTargetPulled = true
            target_index = target:entindex()
        end
    end

    if self.legendary_hooks[projectileIndex] then
        self.legendary_hooks[projectileIndex] = target_index
        self:CheckHooksLegendary()
    end

    if self.hooks[projectileIndex].hVictim == nil then
        local dummy = CreateUnitByName("npc_dota_companion", position, false, nil, nil, caster:GetTeamNumber())
        dummy:AddNewModifier(self, nil, "modifier_phased", {})
        dummy:AddNewModifier(self, nil, "modifier_no_healthbar", {})
        dummy:AddNewModifier(self, nil, "modifier_invulnerable", {})
        self.hooks[projectileIndex].hVictim = dummy
        target = dummy
    end

    local vHookPos = self.hooks[projectileIndex].direction
    local flPad = caster:GetPaddedCollisionRadius()

    if target ~= nil then
        vHookPos = target:GetOrigin()
        flPad = flPad + target:GetPaddedCollisionRadius()
    end

    local vVelocity = self.hooks[projectileIndex].start_position - vHookPos
    vVelocity.z = 0.0

    local flDistance = vVelocity:Length2D() - flPad
    vVelocity = vVelocity:Normalized() * self.hook_speed

    if bTargetPulled then
        ParticleManager:SetParticleControlEnt( self.hooks[projectileIndex].particleIndex, 0, caster, PATTACH_ABSORIGIN, "attach_weapon_chain_rt", self.hooks[projectileIndex].start_position + self.vHookOffset, true )
        ParticleManager:SetParticleControl( self.hooks[projectileIndex].particleIndex, 0, self.hooks[projectileIndex].start_position + self.vHookOffset )

        ParticleManager:SetParticleControlEnt( self.hooks[projectileIndex].particleIndex, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin() + self.vHookOffset, true )
        ParticleManager:SetParticleControl( self.hooks[projectileIndex].particleIndex, 4, Vector( 0, 0, 0 ) )
        ParticleManager:SetParticleControl( self.hooks[projectileIndex].particleIndex, 5, Vector( 1, 0, 0 ) )
    else
        ParticleManager:SetParticleControlEnt( self.hooks[projectileIndex].particleIndex, 1, caster, PATTACH_POINT_FOLLOW, "attach_weapon_chain_rt", caster:GetOrigin() + self.vHookOffset, true);
    end

    EmitSoundOn(self.hook_sound_retract,  self.hooks[projectileIndex].thinker)

    if caster:IsAlive() then
        caster:RemoveGesture( ACT_DOTA_OVERRIDE_ABILITY_1 )
        caster:StartGesture( ACT_DOTA_CHANNEL_ABILITY_1 )
    end

    self.hooks[projectileIndex].bRetracting = true

    local info = 
    {
        Ability = self,
        vSpawnOrigin = vHookPos,
        vVelocity = vVelocity,
        fDistance = flDistance,
        Source = caster,
    }

    local back_proj = ProjectileManager:CreateLinearProjectile( info )

    self.hooks[back_proj] = {}
    self.hooks[back_proj].hook_speed = self.hooks[projectileIndex].hook_speed
    self.hooks[back_proj].hook_width = self.hooks[projectileIndex].hook_width
    self.hooks[back_proj].particleIndex = self.hooks[projectileIndex].particleIndex
    self.hooks[back_proj].bRetracting =  self.hooks[projectileIndex].bRetracting
    self.hooks[back_proj].hVictim = self.hooks[projectileIndex].hVictim
    self.hooks[back_proj].bDiedInHook = self.hooks[projectileIndex].bDiedInHook
    self.hooks[back_proj].direction = self.hooks[projectileIndex].direction
    self.hooks[back_proj].start_position = self.hooks[projectileIndex].start_position
    self.hooks[back_proj].thinker = self.hooks[projectileIndex].thinker 
    self.hooks[back_proj].proj_location = position
    self.hooks[back_proj].hit_target = target_index
    self.hooks[projectileIndex] = nil
else
    if caster and caster:IsHero() then
        local hHook = caster:GetTogglableWearable( DOTA_LOADOUT_TYPE_WEAPON )
        if hHook ~= nil then
            hHook:RemoveEffects( EF_NODRAW )
        end
        caster:RemoveModifierByName("modifier_custom_pudge_meat_hook_hidden")
        local pudge_hook = caster:GetItemWearableHandle("weapon")
        if caster:GetModelName() == "models/heroes/pudge_cute/pudge_cute.vmdl" then
            pudge_hook = caster:GetItemWearableHandle("weapon_persona_1")
        end
        if pudge_hook then
            pudge_hook:RemoveNoDraw()
        end
    end

    if self.hooks[projectileIndex].hVictim ~= nil and not self.hooks[projectileIndex].hVictim:IsNull() then

        local vFinalHookPos = position
        self.hooks[projectileIndex].hVictim:InterruptMotionControllers( true )
        
        self.hooks[projectileIndex].thinker:StopSound(self.hook_sound_retract)

        self.hooks[projectileIndex].hVictim:RemoveModifierByName( "modifier_custom_pudge_meat_hook_debuff" )

        local vVictimPosCheck = self.hooks[projectileIndex].hVictim:GetOrigin() - vFinalHookPos 
        local flPad = caster:GetPaddedCollisionRadius() + self.hooks[projectileIndex].hVictim:GetPaddedCollisionRadius()
        if vVictimPosCheck:Length2D() > flPad then
            local check_dir = (self.hooks[projectileIndex].start_position - self.hooks[projectileIndex].hVictim:GetAbsOrigin()):Normalized()
            local origin = self.hooks[projectileIndex].start_position + (check_dir * 75)
            origin.z = 0
            FindClearSpaceForUnit( self.hooks[projectileIndex].hVictim, origin, false )

            local angel =(self.hooks[projectileIndex].start_position - self.hooks[projectileIndex].hVictim:GetAbsOrigin())
            angel.z = 0.0
            angel = angel:Normalized()
            self.hooks[projectileIndex].hVictim:SetForwardVector(angel)
        end
    end

    if not self.hooks[projectileIndex].hVictim:IsNull() and self.hooks[projectileIndex].hVictim:GetUnitName() == "npc_dota_companion" then 
        UTIL_Remove(self.hooks[projectileIndex].hVictim)
    end

    self.hooks[projectileIndex].thinker:StopSound(self.hook_sound_retract)
    self.hooks[projectileIndex].thinker:StopSound(self.hook_sound_extend)
    UTIL_Remove(self.hooks[projectileIndex].thinker)

    self.hooks[projectileIndex].hVictim = nil

    ParticleManager:DestroyParticle( self.hooks[projectileIndex].particleIndex, true )
    EmitSoundOn("Hero_Pudge.AttackHookRetractStop", caster)
end

return true
end




function custom_pudge_meat_hook:OnProjectileThinkHandle( projectileIndex )
if not IsServer() then return end

if self.hooks[projectileIndex] then

    if not self.hooks[projectileIndex].thinker or self.hooks[projectileIndex].thinker:IsNull() then return end

    local position = ProjectileManager:GetLinearProjectileLocation( projectileIndex )

    self.hooks[projectileIndex].thinker:SetAbsOrigin(position)

    if self.hooks[projectileIndex].bRetracting then
        local caster = self:GetCaster()
        local speed = self.hooks[projectileIndex].hook_speed or 0
        local width = self.hooks[projectileIndex].hook_width or 0
        local position = ProjectileManager:GetLinearProjectileLocation( projectileIndex )

        self.hooks[projectileIndex].thinker:SetAbsOrigin(position)

        if self.hooks[projectileIndex].hVictim then
            if not self.hooks[projectileIndex].hVictim:HasModifier("modifier_custom_pudge_meat_hook_debuff") then

                local dist = 0
                if self.hooks[projectileIndex].start_position then
                    dist = (self.hooks[projectileIndex].start_position - self.hooks[projectileIndex].hVictim:GetAbsOrigin()):Length2D()
                end
                self.hooks[projectileIndex].hVictim:AddNewModifier( caster, self, "modifier_custom_pudge_meat_hook_debuff", {dist = dist} )
            end

            local check_dir_2 = (self.hooks[projectileIndex].start_position - self.hooks[projectileIndex].hVictim:GetAbsOrigin()):Normalized()

            self.hooks[projectileIndex].hVictim:SetOrigin(GetGroundPosition(position, self.hooks[projectileIndex].hVictim))
            self.hooks[projectileIndex].hVictim:SetForwardVector(check_dir_2)

            local vFinalHookPos = self.hooks[projectileIndex].start_position 

            local vVictimPosCheck = vFinalHookPos - self.hooks[projectileIndex].hVictim:GetOrigin() 
            local flPad = caster:GetPaddedCollisionRadius() + self.hooks[projectileIndex].hVictim:GetPaddedCollisionRadius()
            if vVictimPosCheck:Length2D() < flPad then

                local check_dir = (self.hooks[projectileIndex].start_position - self.hooks[projectileIndex].hVictim:GetAbsOrigin()):Normalized()
                local origin = self.hooks[projectileIndex].start_position + (check_dir * 150)
                origin.z = 0

                FindClearSpaceForUnit( self.hooks[projectileIndex].hVictim, origin, false )

                local angel = (self.hooks[projectileIndex].start_position - self.hooks[projectileIndex].hVictim:GetAbsOrigin())
                angel.z = 0.0
                angel = angel:Normalized()
                self.hooks[projectileIndex].hVictim:SetForwardVector(angel)

                self.hooks[projectileIndex].hVictim:InterruptMotionControllers( true )
                self.hooks[projectileIndex].hVictim:RemoveModifierByName( "modifier_custom_pudge_meat_hook_debuff" )
                if self.hooks[projectileIndex].hVictim:GetUnitName() == "npc_dota_companion" then
                    UTIL_Remove(self.hooks[projectileIndex].hVictim)
                end
            end
        end
        ParticleManager:SetParticleControl(self.hooks[projectileIndex].particleIndex, 1, caster:GetAbsOrigin())
    end
end

end

function custom_pudge_meat_hook:OnOwnerDied()
self:GetCaster():RemoveGesture( ACT_DOTA_OVERRIDE_ABILITY_1 )
self:GetCaster():RemoveGesture( ACT_DOTA_CHANNEL_ABILITY_1 )
end


modifier_custom_pudge_meat_hook = class({})
function modifier_custom_pudge_meat_hook:IsHidden()  return true end
function modifier_custom_pudge_meat_hook:IsPurgable() return false end
function modifier_custom_pudge_meat_hook:CheckState()
return 
{
    [MODIFIER_STATE_STUNNED] = true,
}
end



modifier_custom_pudge_meat_hook_debuff = class({})
function modifier_custom_pudge_meat_hook_debuff:IsHidden() return true end
function modifier_custom_pudge_meat_hook_debuff:IsPurgable() return false end

function modifier_custom_pudge_meat_hook_debuff:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if not IsServer() then return end

self.dist = table.dist
end


function modifier_custom_pudge_meat_hook_debuff:OnDestroy()
if not IsServer() then return end

FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), false)

local angel = (self.caster:GetAbsOrigin() - self.parent:GetAbsOrigin())
angel.z = 0.0
angel = angel:Normalized()
self.parent:SetForwardVector(angel)

if self.parent:GetUnitName() ~= "npc_dota_companion" and self.caster:HasTalent("modifier_pudge_hook_6") and self.parent:GetTeamNumber() ~= self.caster:GetTeamNumber() then 
    local duration = self.caster:GetTalentValue("modifier_pudge_hook_6", "min_duration")

    if self.dist and self.dist > 0 then
        local max = self.caster:GetTalentValue("modifier_pudge_hook_6", "max_duration")
        local max_dist = self.caster:GetTalentValue("modifier_pudge_hook_6", "max_dist")

        self.dist = math.min(max_dist, self.dist)

        duration = duration + (max - duration)*(self.dist/max_dist)
    end
    self.parent:AddNewModifier(self.caster, self.ability, "modifier_custom_pudge_meat_hook_root", {duration = (1 - self.parent:GetStatusResistance())*duration})
end

end

function modifier_custom_pudge_meat_hook_debuff:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
}
end

function modifier_custom_pudge_meat_hook_debuff:GetOverrideAnimation( params )
return ACT_DOTA_FLAIL
end

function modifier_custom_pudge_meat_hook_debuff:CheckState()
if self.caster ~= nil and self.parent ~= nil then
    if self.caster:GetTeamNumber() ~= self.parent:GetTeamNumber() then
        return  
        {
            [MODIFIER_STATE_STUNNED] = true,
        }
    end
end

return {}
end



modifier_custom_pudge_meat_hook_speed = class({})
function modifier_custom_pudge_meat_hook_speed:IsHidden() return false end
function modifier_custom_pudge_meat_hook_speed:IsPurgable() return false end
function modifier_custom_pudge_meat_hook_speed:GetTexture() return "buffs/hook_speed" end
function modifier_custom_pudge_meat_hook_speed:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
}
end

function modifier_custom_pudge_meat_hook_speed:GetModifierAttackSpeedBonus_Constant()
if not self.parent:HasTalent("modifier_pudge_hook_1") then return end
return self.speed
end

function modifier_custom_pudge_meat_hook_speed:GetModifierHealthRegenPercentage()
if not self.parent:HasTalent("modifier_pudge_hook_3") then return end
return self.heal
end

function modifier_custom_pudge_meat_hook_speed:OnCreated()
self.parent = self:GetParent()

self.speed = self.parent:GetTalentValue("modifier_pudge_hook_1", "speed")
self.heal = self.parent:GetTalentValue("modifier_pudge_hook_3", "heal")/self:GetRemainingTime()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_pudge_hook_3") then return end

self:StartIntervalThink(0.98)
end

function modifier_custom_pudge_meat_hook_speed:OnIntervalThink()
if not IsServer() then return end
self.parent:GenericParticle("particles/generic_gameplay/generic_lifesteal.vpcf")
self.parent:SendNumber(10, self.heal*self.parent:GetMaxHealth()/100)
end





modifier_custom_pudge_meat_hook_root = class({})
function modifier_custom_pudge_meat_hook_root:IsHidden() return true end
function modifier_custom_pudge_meat_hook_root:IsPurgable() return true end
function modifier_custom_pudge_meat_hook_root:GetTexture() return "buffs/hook_root" end

function modifier_custom_pudge_meat_hook_root:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_custom_pudge_meat_hook_root:GetModifierAttackSpeedBonus_Constant()
return self.speed
end

function modifier_custom_pudge_meat_hook_root:CheckState()
return
{
    [MODIFIER_STATE_ROOTED] = true
}
end

function modifier_custom_pudge_meat_hook_root:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()

self.speed = self.caster:GetTalentValue("modifier_pudge_hook_6", "speed")

if not IsServer() then return end
self.parent:EmitSound("Pudge.Hook_Root")

self:StartIntervalThink(0.1)
end

function modifier_custom_pudge_meat_hook_root:OnIntervalThink()
if not IsServer() then return end
self.parent:GenericParticle("particles/items3_fx/hook_root.vpcf", self)
self:StartIntervalThink(-1)
end


modifier_custom_pudge_meat_hook_tracker = class({})
function modifier_custom_pudge_meat_hook_tracker:IsHidden() return true end
function modifier_custom_pudge_meat_hook_tracker:IsPurgable() return false end
function modifier_custom_pudge_meat_hook_tracker:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
}
end


function modifier_custom_pudge_meat_hook_tracker:GetModifierAttackRangeBonus()
if not self.parent:HasTalent("modifier_pudge_hook_5") then return end
return self.range
end

function modifier_custom_pudge_meat_hook_tracker:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.range = self.parent:GetTalentValue("modifier_pudge_hook_5", "range", true)
self.vision_duration = self.parent:GetTalentValue("modifier_pudge_hook_5", "vision", true)
self.speed_duration = self.parent:GetTalentValue("modifier_pudge_hook_5", "duration", true)

self.legendary_cd = self.parent:GetTalentValue("modifier_pudge_hook_legendary", "cd", true)
self.parent:AddAttackEvent_out(self)
end

function modifier_custom_pudge_meat_hook_tracker:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

local mod = self.parent:FindModifierByName("modifier_custom_pudge_meat_hook_move_speed")
local target_mod = params.target:FindModifierByName("modifier_custom_pudge_meat_hook_move_slow")

if mod then
    mod:SetDuration(self.speed_duration, true)
end
if target_mod then
    target_mod:SetDuration(self.speed_duration, true)
end

if self.parent:HasTalent("modifier_pudge_hook_5") then
    params.target:AddNewModifier(self.parent, self.ability, "modifier_custom_pudge_meat_hook_move_vision", {duration = self.vision_duration})
end

if not self.parent:HasTalent("modifier_pudge_hook_legendary") then return end
self.parent:CdAbility(self.ability, self.legendary_cd)
end



modifier_custom_pudge_meat_hook_move_speed = class({})
function modifier_custom_pudge_meat_hook_move_speed:IsHidden() return false end
function modifier_custom_pudge_meat_hook_move_speed:IsPurgable() return false end
function modifier_custom_pudge_meat_hook_move_speed:GetTexture() return "buffs/edict_speed" end
function modifier_custom_pudge_meat_hook_move_speed:OnCreated()
self.speed = self:GetParent():GetTalentValue("modifier_pudge_hook_5", "speed")
end

function modifier_custom_pudge_meat_hook_move_speed:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_custom_pudge_meat_hook_move_speed:GetEffectName()
return "particles/generic_gameplay/rune_haste_owner.vpcf"
end

function modifier_custom_pudge_meat_hook_move_speed:GetModifierMoveSpeedBonus_Percentage()
return self.speed
end

modifier_custom_pudge_meat_hook_move_slow = class({})
function modifier_custom_pudge_meat_hook_move_slow:IsHidden() return true end
function modifier_custom_pudge_meat_hook_move_slow:IsPurgable() return true end
function modifier_custom_pudge_meat_hook_move_slow:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_pudge_hook_5", "slow")
if not IsServer() then return end
self:GetParent():GenericParticle("particles/items2_fx/sange_maim.vpcf", self)
end

function modifier_custom_pudge_meat_hook_move_slow:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_custom_pudge_meat_hook_move_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end


modifier_custom_pudge_meat_hook_move_vision = class({})
function modifier_custom_pudge_meat_hook_move_vision:IsHidden() return true end
function modifier_custom_pudge_meat_hook_move_vision:IsPurgable() return false end
function modifier_custom_pudge_meat_hook_move_vision:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
if not IsServer() then return end
self.interval = 0.2
self:StartIntervalThink(self.interval)
end

function modifier_custom_pudge_meat_hook_move_vision:OnIntervalThink()
if not IsServer() then return end
AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), 10, self.interval*2, false)
end




modifier_custom_pudge_meat_hook_perma = class({})
function modifier_custom_pudge_meat_hook_perma:IsHidden() return not self:GetCaster():HasTalent("modifier_pudge_hook_4") end
function modifier_custom_pudge_meat_hook_perma:IsPurgable() return false end
function modifier_custom_pudge_meat_hook_perma:RemoveOnDeath() return false end
function modifier_custom_pudge_meat_hook_perma:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_custom_pudge_meat_hook_perma:GetModifierSpellAmplify_Percentage() 
if not self.parent:HasTalent("modifier_pudge_hook_4") then return 0 end 
return self:GetStackCount()*self.parent:GetTalentValue("modifier_pudge_hook_4", "damage")/self.max
end

function modifier_custom_pudge_meat_hook_perma:OnCreated(table)
self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_pudge_hook_4", "max", true)

if not IsServer() then return end 
self:SetStackCount(1)
self:StartIntervalThink(0.5)
end

function modifier_custom_pudge_meat_hook_perma:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_custom_pudge_meat_hook_perma:OnIntervalThink()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_pudge_hook_4") then return end
if self:GetStackCount() < self.max then return end

local particle_peffect = ParticleManager:CreateParticle("particles/lc_odd_proc_.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(particle_peffect, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_peffect, 2, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_peffect)

self.parent:EmitSound("BS.Thirst_legendary_active")
self:StartIntervalThink(-1)
end





modifier_custom_pudge_meat_hook_stack = class({})
function modifier_custom_pudge_meat_hook_stack:IsHidden() return false end
function modifier_custom_pudge_meat_hook_stack:IsPurgable() return false end
function modifier_custom_pudge_meat_hook_stack:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.damage = self.caster:GetTalentValue("modifier_pudge_hook_legendary", "damage")
self.max = self.caster:GetTalentValue("modifier_pudge_hook_legendary", "max")

if not IsServer() then return end 

self.particle = self.parent:GenericParticle("particles/pudge/hook_stack.vpcf", self, true)
self.ability.legendary_targets[self.parent:entindex()] = true

self.RemoveForDuel = true
self:SetStackCount(1)
end 

function modifier_custom_pudge_meat_hook_stack:OnRefresh()
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 
self:IncrementStackCount()
end 


function modifier_custom_pudge_meat_hook_stack:OnDestroy()
if not IsServer() then return end
self.ability.legendary_targets[self.parent:entindex()] = nil
end

function modifier_custom_pudge_meat_hook_stack:OnStackCountChanged(iStackCount)
if not self.particle then return end
ParticleManager:SetParticleControl(self.particle, 1, Vector( 0, self:GetStackCount(), 0 ) )
end

function modifier_custom_pudge_meat_hook_stack:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_custom_pudge_meat_hook_stack:GetModifierIncomingDamage_Percentage(params)
if IsServer() and (not params.attacker or params.attacker:FindOwner() ~= self.caster) then return end 
return self:GetStackCount()*self.damage
end




modifier_custom_pudge_meat_hook_hidden = class({})
function modifier_custom_pudge_meat_hook_hidden:IsHidden() return true end
function modifier_custom_pudge_meat_hook_hidden:IsPurgable() return false end
function modifier_custom_pudge_meat_hook_hidden:IsPurgeException() return false end