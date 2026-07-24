--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_pudge_meat_hook_custom", "heroes/npc_dota_hero_pudge_custom/pudge_meat_hook_custom", LUA_MODIFIER_MOTION_NONE  )
LinkLuaModifier( "modifier_pudge_meat_hook_custom_thinker", "heroes/npc_dota_hero_pudge_custom/pudge_meat_hook_custom", LUA_MODIFIER_MOTION_NONE  )
LinkLuaModifier( "modifier_pudge_meat_hook_custom_fart_debuff", "heroes/npc_dota_hero_pudge_custom/pudge_meat_hook_custom", LUA_MODIFIER_MOTION_NONE  )
LinkLuaModifier( "modifier_pudge_meat_hook_custom_cooldown_talent", "heroes/npc_dota_hero_pudge_custom/pudge_meat_hook_custom", LUA_MODIFIER_MOTION_NONE  )
LinkLuaModifier( "modifier_pudge_meat_hook_custom_debuff", "heroes/npc_dota_hero_pudge_custom/pudge_meat_hook_custom", LUA_MODIFIER_MOTION_HORIZONTAL  )
LinkLuaModifier( "modifier_pudge_hook_custom_dummy", "heroes/npc_dota_hero_pudge_custom/pudge_meat_hook_custom", LUA_MODIFIER_MOTION_HORIZONTAL  )
LinkLuaModifier( "modifier_pudge_meat_hook_boss_abuse", "heroes/npc_dota_hero_pudge_custom/pudge_meat_hook_custom", LUA_MODIFIER_MOTION_HORIZONTAL  )

pudge_meat_hook_custom = class({})
pudge_meat_hook_custom.hooks = {}

function pudge_meat_hook_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_pudge/pudge_meathook.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_pudge/pudge_meathook_impact.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_pudge/pudge_rot.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_crimson_nasal_goo_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/pudge_chain_hook.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_pudge.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_pudge.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_pudge.vpcf", context)
end

pudge_meat_hook_custom.modifier_pudge_17 = {15,25,25}
pudge_meat_hook_custom.modifier_pudge_18 = {40,60,80}
pudge_meat_hook_custom.modifier_pudge_19 = {2.5,5}

function pudge_meat_hook_custom:OnAbilityPhaseStart()
    self:GetCaster():StartGesture( ACT_DOTA_OVERRIDE_ABILITY_1 )
    return true
end

function pudge_meat_hook_custom:OnAbilityPhaseInterrupted()
    self:GetCaster():RemoveGesture( ACT_DOTA_OVERRIDE_ABILITY_1 )
end

function pudge_meat_hook_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_pudge_21") then
        return "pudge_21"
    end
    return "pudge_meat_hook"
end

function pudge_meat_hook_custom:OnSpellStart()
    for id, hook in pairs(self.hooks) do
        if hook ~= nil then

            if self.hooks[id].hVictim and not self.hooks[id].hVictim:IsNull() then
                

                self.hooks[id].hVictim:RemoveModifierByName("modifier_pudge_meat_hook_custom_debuff")
            
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

    local caster_position = self:GetCaster():GetOrigin()

    local point = self:GetCursorPosition()
    if point == caster_position then 
        point = point + self:GetCaster():GetForwardVector()*5
    end

    local direction = CalculateDirection(point, caster_position)

    self:UseHook(direction)

    if self:GetCaster() and self:GetCaster():IsHero() then
        local hHook = self:GetCaster():GetTogglableWearable( DOTA_LOADOUT_TYPE_WEAPON )
        if hHook ~= nil then
            hHook:AddEffects( EF_NODRAW )
        end
    end

    if self:GetCaster():HasModifier("modifier_pudge_21") then
        local angle = 30
        local hook_count = 11
        for i = 1, hook_count do
            local newAngle = angle * math.ceil(i / 2) * (-1)^i
            local newDir = RotateVector2D( direction, ToRadians( newAngle ) )
            self:UseHook( newDir )
        end
    end
end

------------------------ Функции


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

------------------------------------

function pudge_meat_hook_custom:UseHook( direction )
    self.hook_damage = self:GetSpecialValueFor( "damage" )
    self.hook_speed = self:GetSpecialValueFor( "hook_speed" )
    self.hook_width = self:GetSpecialValueFor( "hook_width" )
    self.hook_distance = self:GetEffectiveCastRange(self:GetCaster():GetAbsOrigin(), self:GetCaster())
    self.hook_followthrough_constant = 0.65
    self.vision_radius = self:GetSpecialValueFor( "vision_radius" )  
    self.vision_duration = self:GetSpecialValueFor( "vision_duration" )  

    local caster_location = self:GetCaster():GetOrigin()
    local flFollowthroughDuration = ( self.hook_distance / self.hook_speed * self.hook_followthrough_constant )

    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_pudge_meat_hook_custom", { duration = flFollowthroughDuration } )

    if self:GetCaster():HasModifier("modifier_pudge_19") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_pudge_meat_hook_custom_cooldown_talent", { duration = (self.hook_distance / self.hook_speed) + 0.6 })
    end

    self.vHookOffset = Vector( 0, 0, 96 )
    local vHookTarget = (caster_location + (direction * self.hook_distance)) + self.vHookOffset
    local vKillswitch = Vector( ( ( self.hook_distance / self.hook_speed ) * 2 ), 0, 0 )

    local hook_particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_pudge/pudge_meathook.vpcf", PATTACH_CUSTOMORIGIN, nil )
    ParticleManager:SetParticleAlwaysSimulate( hook_particle )

    ParticleManager:SetParticleControlEnt( hook_particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_weapon_chain_rt", self:GetCaster():GetOrigin() + self.vHookOffset, true )
    ParticleManager:SetParticleControl( hook_particle, 1, vHookTarget )
    ParticleManager:SetParticleControl( hook_particle, 2, Vector( self.hook_speed, self.hook_distance, self.hook_width ) )
    ParticleManager:SetParticleControl( hook_particle, 3, vKillswitch )
    ParticleManager:SetParticleControl( hook_particle, 4, Vector( 1, 0, 0 ) )
    ParticleManager:SetParticleControl( hook_particle, 5, Vector( 0, 0, 0 ) )
    ParticleManager:SetParticleControlEnt( hook_particle, 7, self:GetCaster(), PATTACH_CUSTOMORIGIN, nil, self:GetCaster():GetOrigin(), true )


    --ParticleManager:SetParticleShouldCheckFoW( hook_particle, false )
    local thinker = CreateModifierThinker(
        self:GetCaster(),
        self,
        "modifier_invulnerable",
        {},
        self:GetCaster():GetOrigin(),
        self:GetCaster():GetTeamNumber(),
        false
    )



    local info = {
        Ability = self,
        vSpawnOrigin = self:GetCaster():GetOrigin(),
        vVelocity = direction * self.hook_speed,
        fDistance = self.hook_distance,
        fStartRadius = self.hook_width ,
        fEndRadius = self.hook_width ,
        Source = self:GetCaster(),
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_BOTH,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,

    }

    local projectileIndex = ProjectileManager:CreateLinearProjectile( info )

    self.hooks[projectileIndex] = {}
    self.hooks[projectileIndex].particleIndex = hook_particle
    self.hooks[projectileIndex].hook_speed = self.hook_speed
    self.hooks[projectileIndex].hook_width = self.hook_width
    self.hooks[projectileIndex].bRetracting = false
    self.hooks[projectileIndex].hVictim = nil
    self.hooks[projectileIndex].bDiedInHook = false
    self.hooks[projectileIndex].direction = caster_location * (direction * self.hook_distance)
    self.hooks[projectileIndex].start_position = caster_location
    self.hooks[projectileIndex].origin = caster_location
    self.hooks[projectileIndex].distance = 0
    self.hooks[projectileIndex].proj_location = nil
    self.hooks[projectileIndex].thinker = thinker
    self.hooks[projectileIndex].thinker:EmitSound("Hero_Pudge.AttackHookExtend")
end


function pudge_meat_hook_custom:OnProjectileHitHandle( target, position, projectileIndex )
if not IsServer() then return end

    local caster = self:GetCaster()

    if target == caster then return false end


    if not self.hooks[projectileIndex].thinker or  self.hooks[projectileIndex].thinker:IsNull() then return end

    if self.hooks[projectileIndex] == nil then return true end


    if self.hooks[projectileIndex].bRetracting == false then
        if target ~= nil and ( not ( target:IsCreep() or target:IsConsideredHero() ) ) then
            return false
        end
        if target and target:GetUnitName() == "npc_dota_bounty_hunter_gold_bag" then return false end
        if target and target:GetUnitName() == "npc_dota_kunkka_mark" then return false end
        local bTargetPulled = false
        if target ~= nil then

            local modifier_pudge_meat_hook_custom_cooldown_talent = self:GetCaster():FindModifierByName("modifier_pudge_meat_hook_custom_cooldown_talent")

            if modifier_pudge_meat_hook_custom_cooldown_talent then
                modifier_pudge_meat_hook_custom_cooldown_talent:SetStackCount(1)
            end

            if target:HasModifier("modifier_pudge_meat_hook_custom_debuff") then 
                return false
            end

            if target:HasModifier("modifier_pudge_meat_hook_boss_abuse") then 
                return false
            end

            if target:HasModifier("modifier_wodarelax") then
                return false
            end

            if target:HasModifier("modifier_wodarelax_invul") then
                return false
            end

            if target:HasModifier("modifier_stunned_duel_custom") then
                return false
            end

            if target:HasModifier("modifier_techies_remote_mines_custom") then
                return false
            end

            if target:GetUnitName() == "npc_dota_creature_barrel" or target:GetUnitName() == "small_barrel" or target:GetUnitName() == "small_barrel_side" or target:GetUnitName() == "big_barrel" then
                return false
            end

            self.hooks[projectileIndex].thinker:StopSound("Hero_Pudge.AttackHookExtend")

            if self:GetCaster():HasModifier("modifier_pudge_meat_hook_custom") then 
                self:GetCaster():RemoveModifierByName("modifier_pudge_meat_hook_custom")
            end

            target:EmitSound("Hero_Pudge.AttackHookImpact")

            if target:GetUnitName() ~= "npc_dota_creature_barrel" and target:GetUnitName() ~= "small_barrel" and target:GetUnitName() ~= "small_barrel_side" and target:GetUnitName() ~= "big_barrel" and target:GetUnitName() ~= "boss_1_pve" and target:GetUnitName() ~= "boss_2_pve" and target:GetUnitName() ~= "boss_3_pve" and target:GetUnitName() ~= "boss_4_pve" and target:GetUnitName() ~= "boss_5_pve" and target:GetUnitName() ~= "boss_6_pve" and target:GetUnitName() ~= "boss_3" and target:GetUnitName() ~= "boss_5" then 
                if not target:HasModifier("modifier_wodarelax") and not target:HasModifier("modifier_wodarelax_invul") and not target:HasModifier("modifier_stunned_duel_custom") then

                    local distance = (target:GetAbsOrigin() - self.hooks[projectileIndex].start_position )
                    distance.z = 0
                    local direction = distance:Normalized()
                    distance = distance:Length2D()

                    local flFollowthroughDuration = ( distance / self:GetSpecialValueFor("hook_speed") ) + 0.1
                    local damage = 0
                    if self:GetCaster():HasModifier("modifier_pudge_17") then
                        damage = ((distance / 100 * self.modifier_pudge_17[self:GetCaster():GetTalentLevel("modifier_pudge_17")]) / flFollowthroughDuration) * FrameTime()
                    end
                    target:AddNewModifier( self:GetCaster(), self, "modifier_pudge_meat_hook_custom_debuff", {duration = flFollowthroughDuration, damage = damage} )
                end
            else
                target:AddNewModifier( self:GetCaster(), self, "modifier_pudge_meat_hook_boss_abuse", {duration = 1} )
            end

            if self:GetCaster():HasModifier("modifier_pudge_18") then 
                local distance = (target:GetAbsOrigin() - self.hooks[projectileIndex].start_position )
                distance.z = 0
                local direction = distance:Normalized()
                CreateModifierThinker(self:GetCaster(), self, "modifier_pudge_meat_hook_custom_thinker", {duration = 5, x = direction.x, y = direction.y}, target:GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
            end

            if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then

                local damage = self.hook_damage

                local damage_table = {  victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self }

                ApplyDamage( damage_table )
                if target:IsIllusion() then
                    target:Kill(self, self:GetCaster())
                end

                if not target:IsAlive() 
                 then self.hooks[projectileIndex].bDiedInHook = true end

                if not target:IsMagicImmune() then target:Interrupt() end

                local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_pudge/pudge_meathook_impact.vpcf", PATTACH_CUSTOMORIGIN, target )
                ParticleManager:SetParticleControlEnt( nFXIndex, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetOrigin(), true )
                ParticleManager:ReleaseParticleIndex( nFXIndex )
            end
            AddFOWViewer( self:GetCaster():GetTeamNumber(), target:GetOrigin(), self.vision_radius, self.vision_duration, false )
            if target:GetUnitName() ~= "npc_dota_creature_barrel" and target:GetUnitName() ~= "small_barrel" and target:GetUnitName() ~= "small_barrel_side" and target:GetUnitName() ~= "big_barrel" and target:GetUnitName() ~= "boss_1_pve" and target:GetUnitName() ~= "boss_2_pve" and target:GetUnitName() ~= "boss_3_pve" and target:GetUnitName() ~= "boss_4_pve" and target:GetUnitName() ~= "boss_5_pve" and target:GetUnitName() ~= "boss_6_pve" and target:GetUnitName() ~= "boss_3" and target:GetUnitName() ~= "boss_5" then
                self.hooks[projectileIndex].hVictim = target
                bTargetPulled = true
            end
        end

        if self.hooks[projectileIndex].hVictim == nil then
            local dummy = CreateUnitByName("npc_dota_companion", position, false, nil, nil, self:GetCaster():GetTeamNumber())
            dummy:AddNewModifier(self, nil, "modifier_pudge_hook_custom_dummy", {})
            self.hooks[projectileIndex].hVictim = dummy
            target = dummy
        end

        local vHookPos = self.hooks[projectileIndex].direction
        local flPad = self:GetCaster():GetPaddedCollisionRadius()

        if target ~= nil then
            vHookPos = target:GetOrigin()
            flPad = flPad + target:GetPaddedCollisionRadius()
        end

        local vVelocity = self.hooks[projectileIndex].start_position - vHookPos
        vVelocity.z = 0.0

        local flDistance = vVelocity:Length2D() - flPad
        vVelocity = vVelocity:Normalized() * self.hook_speed

        --self.vProjectileLocation = vHookPos

        if bTargetPulled then

            ParticleManager:SetParticleControlEnt( self.hooks[projectileIndex].particleIndex, 0, self:GetCaster(), PATTACH_ABSORIGIN, "attach_weapon_chain_rt", self.hooks[projectileIndex].start_position + self.vHookOffset, true )
            ParticleManager:SetParticleControl( self.hooks[projectileIndex].particleIndex, 0, self.hooks[projectileIndex].start_position + self.vHookOffset )

            ParticleManager:SetParticleControlEnt( self.hooks[projectileIndex].particleIndex, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin() + self.vHookOffset, true )
            ParticleManager:SetParticleControl( self.hooks[projectileIndex].particleIndex, 4, Vector( 0, 0, 0 ) )
            ParticleManager:SetParticleControl( self.hooks[projectileIndex].particleIndex, 5, Vector( 1, 0, 0 ) )
        else
            ParticleManager:SetParticleControlEnt( self.hooks[projectileIndex].particleIndex, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_weapon_chain_rt", self:GetCaster():GetOrigin() + self.vHookOffset, true);
        end


        self.hooks[projectileIndex].thinker:EmitSound("Hero_Pudge.AttackHookRetract")
     

        if self:GetCaster():IsAlive() then
            self:GetCaster():RemoveGesture( ACT_DOTA_OVERRIDE_ABILITY_1 );
            self:GetCaster():StartGesture( ACT_DOTA_CHANNEL_ABILITY_1 );
        end

        self.hooks[projectileIndex].bRetracting = true

        local info = {
            Ability = self,
            vSpawnOrigin = vHookPos,
            vVelocity = vVelocity,
            fDistance = flDistance,
            Source = self:GetCaster(),
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
        self.hooks[back_proj].origin = vHookPos
        self.hooks[back_proj].distance = 0
        self.hooks[back_proj].proj_location = position

        self.hooks[projectileIndex] = nil
    else


        if self:GetCaster() and self:GetCaster():IsHero() then
            local hHook = self:GetCaster():GetTogglableWearable( DOTA_LOADOUT_TYPE_WEAPON )
            if hHook ~= nil then
                hHook:RemoveEffects( EF_NODRAW )
            end
        end

        if self.hooks[projectileIndex].hVictim ~= nil and not self.hooks[projectileIndex].hVictim:IsNull() then

            local vFinalHookPos = position
            self.hooks[projectileIndex].hVictim:InterruptMotionControllers( true )
            
            self.hooks[projectileIndex].thinker:StopSound("Hero_Pudge.AttackHookRetract")

            self.hooks[projectileIndex].hVictim:RemoveModifierByName( "modifier_pudge_meat_hook_custom_debuff" )

            local vVictimPosCheck = self.hooks[projectileIndex].hVictim:GetOrigin() - vFinalHookPos 
            local flPad = self:GetCaster():GetPaddedCollisionRadius() + self.hooks[projectileIndex].hVictim:GetPaddedCollisionRadius()
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


        self.hooks[projectileIndex].thinker:StopSound("Hero_Pudge.AttackHookRetract")
        self.hooks[projectileIndex].thinker:StopSound("Hero_Pudge.AttackHookExtend")
        UTIL_Remove(self.hooks[projectileIndex].thinker)

        self.hooks[projectileIndex].hVictim = nil


        ParticleManager:DestroyParticle( self.hooks[projectileIndex].particleIndex, true )
        self:GetCaster():EmitSound("Hero_Pudge.AttackHookRetractStop")
    end

    return true
end


function pudge_meat_hook_custom:OnProjectileThinkHandle( projectileIndex )
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
                --if not self.hooks[projectileIndex].hVictim:HasModifier("modifier_pudge_meat_hook_custom_debuff") and not self.hooks[projectileIndex].hVictim:HasModifier("modifier_wodarelax") and not self.hooks[projectileIndex].hVictim:HasModifier("modifier_wodarelax_invul") and not self.hooks[projectileIndex].hVictim:HasModifier("modifier_stunned_duel_custom") then
                --    self.hooks[projectileIndex].hVictim:AddNewModifier( self:GetCaster(), self, "modifier_pudge_meat_hook_custom_debuff", {} )
                --end

                if self:GetCaster():HasModifier("modifier_pudge_18") and self.hooks[projectileIndex].hVictim:GetUnitName() ~= "npc_dota_companion" then
                    local distance = (self.hooks[projectileIndex].origin - position):Length2D()
                    local direction = (position - self.hooks[projectileIndex].origin):Normalized()
                    self.hooks[projectileIndex].origin = position

                    self.hooks[projectileIndex].distance = self.hooks[projectileIndex].distance + distance
                    if self.hooks[projectileIndex].distance >= 150 then 
                        self.hooks[projectileIndex].distance = 0
                        CreateModifierThinker(self:GetCaster(), self, "modifier_pudge_meat_hook_custom_thinker", {duration = 5, x = direction.x, y = direction.y}, position, self:GetCaster():GetTeamNumber(), false)
                    end
                end

                local check_dir_2 = (self.hooks[projectileIndex].start_position - self.hooks[projectileIndex].hVictim:GetAbsOrigin()):Normalized()

                if not self.hooks[projectileIndex].hVictim:HasModifier("modifier_wodarelax") and not self.hooks[projectileIndex].hVictim:HasModifier("modifier_wodarelax_invul") and not self.hooks[projectileIndex].hVictim:HasModifier("modifier_stunned_duel_custom") then
                    self.hooks[projectileIndex].hVictim:SetOrigin(GetGroundPosition(position, self.hooks[projectileIndex].hVictim))
                    self.hooks[projectileIndex].hVictim:SetForwardVector(check_dir_2)
                end

                local vFinalHookPos = self.hooks[projectileIndex].start_position 

                local vVictimPosCheck = vFinalHookPos - self.hooks[projectileIndex].hVictim:GetOrigin() 
                local flPad = self:GetCaster():GetPaddedCollisionRadius() + self.hooks[projectileIndex].hVictim:GetPaddedCollisionRadius()

                if vVictimPosCheck:Length2D() < flPad then

                    local check_dir = (self.hooks[projectileIndex].start_position - self.hooks[projectileIndex].hVictim:GetAbsOrigin()):Normalized()


                    local origin = self.hooks[projectileIndex].start_position + (check_dir * 150)
                    origin.z = 0

                    if not self.hooks[projectileIndex].hVictim:HasModifier("modifier_wodarelax") and not self.hooks[projectileIndex].hVictim:HasModifier("modifier_wodarelax_invul") and not self.hooks[projectileIndex].hVictim:HasModifier("modifier_stunned_duel_custom") then
                        FindClearSpaceForUnit( self.hooks[projectileIndex].hVictim, origin, false )
                    end

                    local angel = (self.hooks[projectileIndex].start_position - self.hooks[projectileIndex].hVictim:GetAbsOrigin())
                    angel.z = 0.0
                    angel = angel:Normalized()
                    if not self.hooks[projectileIndex].hVictim:HasModifier("modifier_wodarelax") and not self.hooks[projectileIndex].hVictim:HasModifier("modifier_wodarelax_invul") and not self.hooks[projectileIndex].hVictim:HasModifier("modifier_stunned_duel_custom") then
                        self.hooks[projectileIndex].hVictim:SetForwardVector(angel)
                    end




                    self.hooks[projectileIndex].hVictim:InterruptMotionControllers( true )
                    self.hooks[projectileIndex].hVictim:RemoveModifierByName( "modifier_pudge_meat_hook_custom_debuff" )
                    if self.hooks[projectileIndex].hVictim:GetUnitName() == "npc_dota_companion" then
                        UTIL_Remove(self.hooks[projectileIndex].hVictim)
                    end
                end
            end
            ParticleManager:SetParticleControl(self.hooks[projectileIndex].particleIndex, 1, self:GetCaster():GetAbsOrigin())
        else
            --if self:GetCaster():HasModifier("modifier_pudge_18") then 
            --    local distance = (self.hooks[projectileIndex].origin - position):Length2D()
            --    local direction = (position - self.hooks[projectileIndex].origin):Normalized()
            --    self.hooks[projectileIndex].origin = position
            --    self.hooks[projectileIndex].distance = self.hooks[projectileIndex].distance + distance
            --    if self.hooks[projectileIndex].distance >= 150 then 
            --        self.hooks[projectileIndex].distance = 0
            --        CreateModifierThinker(self:GetCaster(), self, "modifier_pudge_meat_hook_custom_thinker", {duration = 5, x = direction.x, y = direction.y}, position, self:GetCaster():GetTeamNumber(), false)
            --    end
            --end
        end
    end
end

modifier_pudge_meat_hook_custom_thinker = class({})

function modifier_pudge_meat_hook_custom_thinker:IsHidden() return true end
function modifier_pudge_meat_hook_custom_thinker:IsPurgable() return false end

function modifier_pudge_meat_hook_custom_thinker:OnCreated(params)
    if not IsServer() then return end
    self.radius = 180
    self.duration = 10
    self.interval = 0.5
    self.duration_debuff= 2
    self.dir = Vector(params.x, params.y, 0)
    self.start_pos = self:GetParent():GetAbsOrigin() - self.dir*self.radius/2
    self.end_pos = self:GetParent():GetAbsOrigin() + self.dir*self.radius/2

    self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_pudge/pudge_rot.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(self.pfx, 1, Vector(self.radius, 1, self.radius))
    self:AddParticle(self.pfx, false, false, -1, false, false)  

    self:StartIntervalThink(self.interval)
end

function modifier_pudge_meat_hook_custom_thinker:OnIntervalThink()
    if not IsServer() then return end
    local enemies = FindUnitsInLine(self:GetCaster():GetTeamNumber(), self.start_pos, self.end_pos, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0)
    for _,enemy in pairs(enemies) do
        enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_pudge_meat_hook_custom_fart_debuff", {duration = self.duration_debuff})
    end
end

modifier_pudge_meat_hook_custom_fart_debuff = class({})

function modifier_pudge_meat_hook_custom_fart_debuff:IsHidden() return false end
function modifier_pudge_meat_hook_custom_fart_debuff:IsPurgable() return false end

function modifier_pudge_meat_hook_custom_fart_debuff:OnCreated(table)
    if not IsServer() then return end
    self:StartIntervalThink(0.5)

    local particle = ParticleManager:CreateParticle( "particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_crimson_nasal_goo_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, nil )
    ParticleManager:SetParticleControlEnt( particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true )
    ParticleManager:SetParticleControlEnt( particle, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true )
    self:AddParticle(particle, false, false, -1, false, false) 
end

function modifier_pudge_meat_hook_custom_fart_debuff:OnIntervalThink()
    if not IsServer() then return end
    local damage = self:GetCaster():GetIntellect(false) / 100 * self:GetAbility().modifier_pudge_18[self:GetCaster():GetTalentLevel("modifier_pudge_18")]
    ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = damage * 0.5, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end

function modifier_pudge_meat_hook_custom_fart_debuff:GetEffectName()
    return "particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_crimson_nasal_goo_debuff.vpcf"
end

function modifier_pudge_meat_hook_custom_fart_debuff:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_pudge_meat_hook_custom_fart_debuff:GetTexture()
    return "pudge_18"
end

function pudge_meat_hook_custom:OnOwnerDied()
    self:GetCaster():RemoveGesture( ACT_DOTA_OVERRIDE_ABILITY_1 );
    self:GetCaster():RemoveGesture( ACT_DOTA_CHANNEL_ABILITY_1 );
end

modifier_pudge_meat_hook_custom = class({})

function modifier_pudge_meat_hook_custom:IsHidden()
    return true
end

function modifier_pudge_meat_hook_custom:IsPurgable()
    return false
end

function modifier_pudge_meat_hook_custom:CheckState()
    local state = 
    {
        [MODIFIER_STATE_STUNNED] = true,
    }

    return state
end

modifier_pudge_meat_hook_custom_debuff = class({})

function modifier_pudge_meat_hook_custom_debuff:IsDebuff()
    return true
end

function modifier_pudge_meat_hook_custom_debuff:RemoveOnDeath()
    return false
end

function modifier_pudge_meat_hook_custom_debuff:OnDestroy()
    if not IsServer() then return end
    FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), false)
    local angel = (self:GetCaster():GetAbsOrigin() - self:GetParent():GetAbsOrigin())
    angel.z = 0.0
    angel = angel:Normalized()
    self:GetParent():SetForwardVector(angel)
end

function modifier_pudge_meat_hook_custom_debuff:IsPurgable()
    return false
end

function modifier_pudge_meat_hook_custom_debuff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
    }

    return funcs
end

function modifier_pudge_meat_hook_custom_debuff:GetOverrideAnimation( params )
    return ACT_DOTA_FLAIL
end

function modifier_pudge_meat_hook_custom_debuff:CheckState()
    if self:GetCaster() ~= nil and self:GetParent() ~= nil then
        if self:GetCaster():GetTeamNumber() ~= self:GetParent():GetTeamNumber() and ( not self:GetParent():IsMagicImmune() ) then
            local state = {
            [MODIFIER_STATE_STUNNED] = true,
            }

            return state
        end
    end
    local state = {}
    return state
end

function modifier_pudge_meat_hook_custom_debuff:OnCreated(params)
    if not IsServer() then return end
    self.damage = params.damage
    self:StartIntervalThink(FrameTime())
end

function modifier_pudge_meat_hook_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_wodarelax") then
        self:Destroy()
        return
    end
    if self:GetParent():HasModifier("modifier_wodarelax_invul") then
        self:Destroy()
        return
    end
    if self:GetParent():HasModifier("modifier_stunned_duel_custom") then
        self:Destroy()
        return
    end
    if self:GetCaster():HasModifier("modifier_wodarelax") then
        self:Destroy()
        return
    end
    if self:GetCaster():HasModifier("modifier_wodarelax_invul") then
        self:Destroy()
        return
    end
    if self:GetCaster():HasModifier("modifier_stunned_duel_custom") then
        self:Destroy()
        return
    end
    if not self.damage then return end
    if self.damage <= 0 then return end
    if self:GetParent():GetTeamNumber() == self:GetCaster():GetTeamNumber() then return end
    ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), ability = self:GetAbility(), damage = self.damage, damage_type = DAMAGE_TYPE_PURE })
end

modifier_pudge_meat_hook_boss_abuse = class({})
function modifier_pudge_meat_hook_boss_abuse:IsHidden() return true end
function modifier_pudge_meat_hook_boss_abuse:IsPurgable() return false end
function modifier_pudge_meat_hook_boss_abuse:RemoveOnDeath() return false end

modifier_pudge_hook_custom_dummy = class({})

function modifier_pudge_hook_custom_dummy:IsHidden() return true end
function modifier_pudge_hook_custom_dummy:IsPurgable() return false end

function modifier_pudge_hook_custom_dummy:CheckState()
    return {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
    }
end

LinkLuaModifier( "modifier_pudge_chain_binding",  "heroes/npc_dota_hero_pudge_custom/pudge_meat_hook_custom", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier( "modifier_pudge_chain_binding_damage",  "heroes/npc_dota_hero_pudge_custom/pudge_meat_hook_custom", LUA_MODIFIER_MOTION_BOTH)

pudge_chain_binding = class({})

--pudge_chain_binding.modifier_pudge_10_agi = {27,21,15}
--pudge_chain_binding.modifier_pudge_10_cd = 0.5
--
--function pudge_chain_binding:GetCooldown(level)
--    local cooldown = self.BaseClass.GetCooldown( self, level )
--
--    if self:GetCaster():HasModifier("modifier_pudge_10") then
--        local agility_count = self:GetCaster():GetAgility() / self.modifier_pudge_10_agi[self:GetCaster():GetTalentLevel("modifier_pudge_10")]
--        cooldown = cooldown - (agility_count * self.modifier_pudge_10_cd)
--        if cooldown < 0 then
--            cooldown = 0
--        end
--    end
--
--    return cooldown
--end

function pudge_chain_binding:OnAbilityPhaseStart()
    self:GetCaster():StartGesture( ACT_DOTA_OVERRIDE_ABILITY_1 )
    return true
end

function pudge_chain_binding:OnAbilityPhaseInterrupted()
    self:GetCaster():RemoveGesture( ACT_DOTA_OVERRIDE_ABILITY_1 )
end

function pudge_chain_binding:OnSpellStart()
    if not IsServer() then return end

    local point = self:GetCursorPosition()

    local direction = point - self:GetCaster():GetAbsOrigin()
    direction.z = 0
    local distance = direction:Length2D()
    direction = direction:Normalized()

    local hookshot_duration = (distance / self:GetSpecialValueFor("speed"))

    local hHook = self:GetCaster():GetTogglableWearable( DOTA_LOADOUT_TYPE_WEAPON )
    if hHook ~= nil then
        hHook:AddEffects( EF_NODRAW )
    end

    local hookshot_particle = ParticleManager:CreateParticle("particles/pudge_chain_hook.vpcf", PATTACH_CUSTOMORIGIN, nil)
    ParticleManager:SetParticleControlEnt(hookshot_particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_weapon_chain_rt", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(hookshot_particle, 1, point)
    ParticleManager:SetParticleControl(hookshot_particle, 2, Vector(self:GetSpecialValueFor("speed"), 0, 0))
    ParticleManager:SetParticleControl(hookshot_particle, 3, Vector(hookshot_duration*5, 0, 0))

    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_pudge_meat_hook_custom", {duration = hookshot_duration + 0.1})

    self.projectile = ProjectileManager:CreateLinearProjectile(
    {
        Ability = self,
        EffectName = "",
        vSpawnOrigin = self:GetCaster():GetOrigin(),
        vVelocity = direction * self:GetSpecialValueFor("speed") * Vector(1, 1, 0),
        fDistance = distance,
        fStartRadius = 0,
        fEndRadius = 0,
        Source = self:GetCaster(),
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_BOTH,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        iUnitTargetFlags    = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
        fExpireTime         = GameRules:GetGameTime() + 10.0,
        bDeleteOnHit = false,
        ExtraData = {hookshot_particle = hookshot_particle}
    })

    self:GetCaster():EmitSound("Hero_Pudge.AttackHookExtend")
end

function pudge_chain_binding:OnProjectileHit_ExtraData(hTarget, vLocation, ExtraData)
    if not IsServer() then return end
    if hTarget == nil then
        if ExtraData.hookshot_particle then
            if self:GetCaster():HasModifier("modifier_wodarelax") then
                ParticleManager:DestroyParticle(ExtraData.hookshot_particle, true)
                return
            end
            if self:GetCaster():HasModifier("modifier_wodarelax_invul") then
                ParticleManager:DestroyParticle(ExtraData.hookshot_particle, true)
                return
            end
            if self:GetCaster():HasModifier("modifier_stunned_duel_custom") then
                ParticleManager:DestroyParticle(ExtraData.hookshot_particle, true)
                return
            end
            self:GetCaster():StopSound("Hero_Pudge.AttackHookExtend")
            self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_pudge_chain_binding", {particle1 = ExtraData.hookshot_particle, x = vLocation.x, y = vLocation.y, z = vLocation.z})
            ParticleManager:SetParticleControl(ExtraData.hookshot_particle, 1, vLocation)
        end
    end
end

modifier_pudge_chain_binding = {}

function modifier_pudge_chain_binding:IsHidden()         return true end
function modifier_pudge_chain_binding:IsPurgable()       return true end
function modifier_pudge_chain_binding:RemoveOnDeath()    return true end
function modifier_pudge_chain_binding:IsDebuff()     return false end

function modifier_pudge_chain_binding:OnCreated(params)
    if not IsServer() then return end

    self.vector = Vector(params.x,params.y,params.z)
    self.speed = self:GetAbility():GetSpecialValueFor("speed") * FrameTime()
    local vec = (self.vector - self:GetCaster():GetAbsOrigin()):Normalized()
    self:GetParent():SetForwardVector(vec)

    self:StartIntervalThink(FrameTime())

    if params.particle1 then
        self:AddParticle(params.particle1, false, false, -1, false, false)
    end
end

function modifier_pudge_chain_binding:OnIntervalThink()
    if not IsServer() then return end

    if self:GetParent():HasModifier("modifier_knockback") then self:Destroy() return end
    if not self:GetParent():IsAlive() then self:Destroy() return end
    if self:GetParent():HasModifier("modifier_wodarelax_invul") then self:Destroy() return end

    local vec = (self.vector - self:GetCaster():GetAbsOrigin()):Normalized()

    if (self:GetCaster():GetOrigin() - self.vector):Length2D() <= 50 then
        FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
        self:GetParent():MoveToPositionAggressive(self:GetParent():GetAbsOrigin())
        self:Destroy()
    else
        self:GetCaster():SetAbsOrigin(self:GetCaster():GetAbsOrigin() + vec * self.speed)
    end
end

function modifier_pudge_chain_binding:OnDestroy()
    if not IsServer() then return end
    local hHook = self:GetCaster():GetTogglableWearable( DOTA_LOADOUT_TYPE_WEAPON )
    if hHook ~= nil then
        hHook:RemoveEffects( EF_NODRAW )
    end
    local parent = self:GetParent()
    Timers:CreateTimer(FrameTime(), function()
        FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
    end)
    self:GetCaster():RemoveGesture( ACT_DOTA_OVERRIDE_ABILITY_1 )
end

function modifier_pudge_chain_binding:OnHorizontalMotionInterrupted()
    if not self:IsNull() then
        self:Destroy()
    end
end

function modifier_pudge_chain_binding:CheckState()
    local state = {
        [MODIFIER_STATE_ROOTED] = true,
        --[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }

    return state
end

function modifier_pudge_chain_binding:IsAura() return true end

function modifier_pudge_chain_binding:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY 
end

function modifier_pudge_chain_binding:GetAuraSearchType()
    return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_pudge_chain_binding:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_pudge_chain_binding:GetModifierAura()
    return "modifier_pudge_chain_binding_damage"
end

function modifier_pudge_chain_binding:GetAuraRadius()
    return self:GetCaster():Script_GetAttackRange()
end

modifier_pudge_chain_binding_damage = class({})

function modifier_pudge_chain_binding_damage:IsPurgable() return false end
function modifier_pudge_chain_binding_damage:IsHidden() return true end

function modifier_pudge_chain_binding_damage:OnCreated()
    if not IsServer() then return end
    self:GetCaster():PerformAttack(self:GetParent(), true, true, true, false, false, false, true)
    if self:GetAbility():GetLevel() == 2 then
        self:GetCaster():PerformAttack(self:GetParent(), true, true, true, false, false, false, true)
    end
end


modifier_pudge_meat_hook_custom_cooldown_talent = class({})

function modifier_pudge_meat_hook_custom_cooldown_talent:RemoveOnDeath() return false end
function modifier_pudge_meat_hook_custom_cooldown_talent:IsPurgable() return false end
function modifier_pudge_meat_hook_custom_cooldown_talent:IsHidden() return true end

function modifier_pudge_meat_hook_custom_cooldown_talent:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(0)
end

function modifier_pudge_meat_hook_custom_cooldown_talent:OnDestroy()
    if not IsServer() then return end
    if self:GetStackCount() == 0 then
        local meathook = self:GetParent():FindAbilityByName("pudge_meat_hook_custom")
        if meathook then
            local cooldown = meathook:GetCooldownTimeRemaining()
            if cooldown - self:GetAbility().modifier_pudge_19[self:GetCaster():GetTalentLevel("modifier_pudge_19")] <= 0 then
                meathook:EndCooldown()
            else
                meathook:EndCooldown()
                meathook:StartCooldown(cooldown - self:GetAbility().modifier_pudge_19[self:GetCaster():GetTalentLevel("modifier_pudge_19")])
            end
        end
    end
end