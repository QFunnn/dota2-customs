--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_aghanim_ray", "heroes/npc_dota_hero_meepo_custom/aghanim_ray", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_aghanim_ray_caster", "heroes/npc_dota_hero_meepo_custom/aghanim_ray", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_aghanim_shard_thinker", "heroes/npc_dota_hero_meepo_custom/aghanim_shard", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_aghanim_ray_magic_immune", "heroes/npc_dota_hero_meepo_custom/aghanim_ray", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_aghanim_ray_21_talent_buff", "heroes/npc_dota_hero_meepo_custom/aghanim_ray", LUA_MODIFIER_MOTION_NONE )

aghanim_ray = class({})
aghanim_ray.modifier_meepo_4 = {450,600}
aghanim_ray.modifier_meepo_16 = {5}
aghanim_ray.modifier_meepo_20 = {40,80}
aghanim_ray.modifier_meepo_19 = {25,50}
aghanim_ray.modifier_meepo_15 = {-3,-6}
aghanim_ray.modifier_meepo_2 = {1,2,3}
aghanim_ray.modifier_meepo_17 = {400,600}

function aghanim_ray:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/creatures/aghanim/staff_beam.vpcf", context )
    PrecacheResource( "particle", "particles/creatures/aghanim/aghanim_beam_channel.vpcf", context )
    PrecacheResource( "particle", "particles/creatures/aghanim/aghanim_beam_burn.vpcf", context )
    PrecacheResource( "particle", "particles/creatures/aghanim/staff_beam_linger.vpcf", context )
    PrecacheResource( "particle", "particles/creatures/aghanim/staff_beam_tgt_ring.vpcf", context )
    PrecacheResource( "particle", "particles/creatures/aghanim/aghanim_debug_ring.vpcf", context )
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_phoenix.vsndevts", context )
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_huskar.vsndevts", context )
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_jakiro.vsndevts", context )
end

function aghanim_ray:OnAbilityPhaseStart()
    --if IsServer() then
    --    self.nChannelFX = ParticleManager:CreateParticle( "particles/creatures/aghanim/aghanim_beam_channel.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    --end
    return true
end

function aghanim_ray:OnAbilityPhaseInterrupted()
    --if IsServer() then
    --    if self.nChannelFX then
    --        ParticleManager:DestroyParticle(self.nChannelFX, true)
    --    end
    --end
end

function aghanim_ray:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_meepo_2") then
        return "aghanim_2"
    end
    return "aghanims_ray"
end

function aghanim_ray:GetBehavior()
    if self:GetCaster():HasModifier("modifier_meepo_6") then
        return DOTA_ABILITY_BEHAVIOR_PASSIVE
    end
    if self:GetCaster():HasModifier("modifier_meepo_4") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET
    end
    return DOTA_ABILITY_BEHAVIOR_POINT
end

function aghanim_ray:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_meepo_6") then
        return 0
    end
end

function aghanim_ray:GetCooldown(level)
    if self:GetCaster():HasModifier("modifier_meepo_6") then
        return 0
    end
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_meepo_15") then
		bonus = self.modifier_meepo_15[self:GetCaster():GetTalentLevel("modifier_meepo_15")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function aghanim_ray:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local direction = point - self:GetCaster():GetAbsOrigin()
    local distance = direction:Length2D()
    direction = direction:Normalized()
    if distance > (self:GetSpecialValueFor("max_distance") + self:GetCaster():GetCastRangeBonus()) then
        point = self:GetCaster():GetAbsOrigin() + direction * (self:GetSpecialValueFor("max_distance") + self:GetCaster():GetCastRangeBonus())
    end
    if distance < self:GetSpecialValueFor("min_distance") then
        point = self:GetCaster():GetAbsOrigin() + direction * self:GetSpecialValueFor("min_distance")
    end
    if self:GetCaster():HasModifier("modifier_meepo_16") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_aghanim_ray_magic_immune", {duration = self.modifier_meepo_16[self:GetCaster():GetTalentLevel("modifier_meepo_16")]})
    end
    if self:GetCaster():HasModifier("modifier_meepo_4") then
        point = self:GetCaster():GetAbsOrigin()
        self:GetCaster():RemoveModifierByName("modifier_aghanim_ray_caster")
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_aghanim_ray_caster", {duration = self:GetSpecialValueFor("duration"), x = point.x, y = point.y, z = point.z })
        return
    end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_aghanim_ray", {duration = self:GetSpecialValueFor("duration"), x = point.x, y = point.y, z = point.z })
end

function aghanim_ray:SetPassive()
    local point = self:GetCaster():GetAbsOrigin()
    self:GetCaster():RemoveModifierByName("modifier_aghanim_ray_caster")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_aghanim_ray_caster", {x = point.x, y = point.y, z = point.z })
end

aghanim_ray_stop = class({})
function aghanim_ray_stop:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_meepo_2") then
        return "aghanim_2"
    end
    return "aghanims_ray"
end
function aghanim_ray_stop:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():RemoveModifierByName("modifier_aghanim_ray")
end

modifier_aghanim_ray = class({})
function modifier_aghanim_ray:IsPurgable() return false end
function modifier_aghanim_ray:OnCreated(params)
    if not IsServer() then return end
    local aghanim_ray_stop = self:GetCaster():FindAbilityByName("aghanim_ray_stop")
    if aghanim_ray_stop then
        aghanim_ray_stop:SetLevel(1)
    end
    self.point = Vector(params.x, params.y, params.z)
    self:GetParent():SwapAbilities("aghanim_ray", "aghanim_ray_stop", false, true)
    self.dummy = CreateUnitByName( "npc_dota_companion", self.point, false, nil, nil, self:GetCaster():GetTeamNumber() )
    self.dummy:SetAbsOrigin(self.point)
    self.dummy:AddNewModifier(self.dummy, self:GetAbility(), "modifier_aghanim_shard_thinker", {duration = self:GetAbility():GetSpecialValueFor("duration")})
    self.effect_time = 0
    local particle_name = "particles/creatures/aghanim/staff_beam.vpcf"
    if self:GetCaster():HasModifier("modifier_meepo_2") then
        particle_name = "particles/creatures/aghanim/staff_beam_red.vpcf"
    end
    self.nBeamFXIndex = ParticleManager:CreateParticle( particle_name, PATTACH_CUSTOMORIGIN, nil )
    ParticleManager:SetParticleControlEnt( self.nBeamFXIndex, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_staff_fx", self:GetCaster():GetAbsOrigin(), true )
    ParticleManager:SetParticleControlEnt( self.nBeamFXIndex, 1, self.dummy, PATTACH_ABSORIGIN_FOLLOW, nil, self.dummy:GetOrigin(), true )
    ParticleManager:SetParticleControlEnt( self.nBeamFXIndex, 2, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, self.dummy:GetOrigin(), true )
    ParticleManager:SetParticleControlEnt( self.nBeamFXIndex, 9, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true )
    EmitSoundOn( "woda_aghanim_ray_cast", self:GetCaster() )
    self.tick_damage = 0
    self.tick_buff = 0
    self:StartIntervalThink(FrameTime())
end

function modifier_aghanim_ray:OnIntervalThink()
    if not IsServer() then return end
    if self.dummy and self.dummy:IsNull() then return end
    if self:GetParent():IsStunned() or self:GetParent():IsSilenced() or self:GetParent():IsHexed() or self:GetParent():IsTaunted() then
        self:Destroy()
        return
    end

    self.tick_buff = self.tick_buff + FrameTime()
    
    if self.tick_buff >= 0.5 then
        if self:GetCaster():HasModifier("modifier_meepo_21") then
            self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_aghanim_ray_21_talent_buff", {duration = 3})
        end
        self.tick_buff = 0
    end

    local direction = self.point - self.dummy:GetAbsOrigin()
    direction.z = 0
    direction = direction:Normalized()

    local ray_speed = self:GetAbility():GetSpecialValueFor("ray_speed")
    if self:GetCaster():HasModifier("modifier_meepo_17") then
        ray_speed = ray_speed + self:GetAbility().modifier_meepo_17[self:GetCaster():GetTalentLevel("modifier_meepo_17")]
    end

    local new_point = self.dummy:GetAbsOrigin() + direction * (ray_speed * FrameTime())
    local dir_min_c = new_point - self:GetCaster():GetAbsOrigin()
    local distance = dir_min_c:Length2D()
    dir_min_c.z = 0
    local direction_min = dir_min_c:Normalized()
    if distance < self:GetAbility():GetSpecialValueFor("min_distance") - 50 then
        local dir = new_point - self:GetCaster():GetAbsOrigin()
        local len = dir:Length2D()
        dir.z = 0
        dir = dir:Normalized()
        new_point = new_point + dir * (self:GetAbility():GetSpecialValueFor("min_distance") - 150)
    end
    new_point = GetGroundPosition(new_point, nil)
    AddFOWViewer(self:GetCaster():GetTeamNumber(), self.dummy:GetAbsOrigin(), 100, FrameTime(), false)
    self.dummy:SetAbsOrigin(new_point)
    if self.effect_time <= 0.4 then
        self.effect_time = self.effect_time + FrameTime()
    end

    self.tick_damage = self.tick_damage + FrameTime()

    local health_ever = self:GetAbility():GetSpecialValueFor("health_aver")
    if self:GetCaster():HasModifier("modifier_meepo_19") then
        health_ever = health_ever + self:GetAbility().modifier_meepo_19[self:GetCaster():GetTalentLevel("modifier_meepo_19")]
    end

    if self.tick_damage >= 0.25 then
        local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), new_point, nil, self:GetAbility():GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
        for _,enemy in pairs( enemies ) do
            local damage = self:GetAbility():GetSpecialValueFor("damage")
            if self:GetCaster():HasModifier("modifier_meepo_20") then
                damage = damage + (self:GetCaster():GetIntellect(false) / 100 * self:GetAbility().modifier_meepo_20[self:GetCaster():GetTalentLevel("modifier_meepo_20")])
            end
            if self:GetCaster():HasModifier("modifier_meepo_2") then
                damage = damage + (self:GetCaster():GetMaxHealth() / 100 * self:GetAbility().modifier_meepo_2[self:GetCaster():GetTalentLevel("modifier_meepo_2")])
            end
            if not self:GetCaster():HasModifier("modifier_meepo_2") then
                if enemy:GetHealthPercent() <= health_ever then
                    damage = damage * self:GetAbility():GetSpecialValueFor("damage_multiple")
                end
            end
            if self.effect_time >= 0.4 then
                --local particle = ParticleManager:CreateParticle("particles/aghanim_ray_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
                --ParticleManager:SetParticleControl(particle, 0, enemy:GetAbsOrigin())
                --ParticleManager:ReleaseParticleIndex(particle)
                self.effect_time = 0
            end
            local damageInfo = 
            {
                victim = enemy,
                attacker = self:GetCaster(),
                damage = damage * 0.25,
                damage_type = DAMAGE_TYPE_MAGICAL,
                ability = self:GetAbility(),
            }
            ApplyDamage( damageInfo )
        end
        self.tick_damage = 0
    end
    local direction2 = self.dummy:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()
    direction2.z = 0
    direction2 = direction2:Normalized()
    if not self:GetCaster():HasModifier("modifier_generic_knockback_lua") then
        self:GetCaster():SetForwardVector(direction2)
    end
end

function modifier_aghanim_ray:OnDestroy()
    if not IsServer() then return end
    self:GetParent():SwapAbilities("aghanim_ray_stop", "aghanim_ray", false, true)
    self:GetCaster():RemoveGesture(ACT_DOTA_CHANNEL_ABILITY_3)
    if self.dummy and not self.dummy:IsNull() then
        self.dummy:RemoveModifierByName("modifier_aghanim_shard_thinker")
    end
    self:GetCaster():RemoveModifierByName("modifier_aghanim_ray_magic_immune")
    --if self:GetAbility().nChannelFX then
    --    ParticleManager:DestroyParticle(self:GetAbility().nChannelFX, false)
    --end
    local modifier_meepo_21 = self:GetCaster():FindModifierByName("modifier_meepo_21")
    if modifier_meepo_21 and modifier_meepo_21:GetStackCount() < 2 then
        self:GetCaster():RemoveModifierByName("modifier_aghanim_ray_21_talent_buff")
    end
    if self.nBeamFXIndex then
        ParticleManager:DestroyParticle(self.nBeamFXIndex, true)
    end
    StopSoundOn( "woda_aghanim_ray_cast", self:GetCaster() )
end

function modifier_aghanim_ray:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_DISABLE_TURNING,
    }
end

function modifier_aghanim_ray:CheckState()
    local state = 
    {
        [ MODIFIER_STATE_DISARMED ] = true,
        [ MODIFIER_STATE_ROOTED ] = true,
    }
    return state
end

function modifier_aghanim_ray:GetOverrideAnimation()
    return ACT_DOTA_CHANNEL_ABILITY_3
end

function modifier_aghanim_ray:GetModifierDisableTurning()
    return 1
end

function modifier_aghanim_ray:OnOrder( params )
    if not IsServer() then return end

    if params.unit == self:GetParent() then
        local validMoveOrders =
        {
            [DOTA_UNIT_ORDER_ATTACK_TARGET] = true,
            [DOTA_UNIT_ORDER_MOVE_TO_TARGET] = true,
            [DOTA_UNIT_ORDER_MOVE_TO_POSITION] = true,
            [DOTA_UNIT_ORDER_ATTACK_MOVE] = true,
            [DOTA_UNIT_ORDER_PICKUP_ITEM] = true,
            [DOTA_UNIT_ORDER_PICKUP_RUNE] = true,
        }

        local stop_orders =
        {
            [DOTA_UNIT_ORDER_STOP] = true,
            [DOTA_UNIT_ORDER_HOLD_POSITION] = true,
            [DOTA_UNIT_ORDER_CONTINUE] = true,
            [DOTA_UNIT_ORDER_CAST_POSITION] = true,
            [DOTA_UNIT_ORDER_CAST_TARGET] = true,
            [DOTA_UNIT_ORDER_CAST_NO_TARGET] = true,
            [DOTA_UNIT_ORDER_HOLD_POSITION] = true,
        }

        if self:GetCaster():HasModifier("modifier_meepo_21") then
            stop_orders =
            {
                [DOTA_UNIT_ORDER_STOP] = true,
                [DOTA_UNIT_ORDER_HOLD_POSITION] = true,
                [DOTA_UNIT_ORDER_CONTINUE] = true,
                [DOTA_UNIT_ORDER_HOLD_POSITION] = true,
            }
        end

        if stop_orders[params.order_type] then
            self:Destroy()
            self:GetParent():Stop()
            return
        end

        if validMoveOrders[params.order_type] then
            local vTargetPos = params.new_pos
            if params.target ~= nil and params.target:IsNull() == false then
                vTargetPos = params.target:GetAbsOrigin()
            end
            local direction = vTargetPos - self:GetCaster():GetAbsOrigin()
            local distance = direction:Length2D()
            direction = direction:Normalized()
            if distance > (self:GetAbility():GetSpecialValueFor("max_distance")+ self:GetCaster():GetCastRangeBonus()) then
                vTargetPos = self:GetCaster():GetAbsOrigin() + direction * (self:GetAbility():GetSpecialValueFor("max_distance")+ self:GetCaster():GetCastRangeBonus())
            end
            if distance < self:GetAbility():GetSpecialValueFor("min_distance") then
                vTargetPos = self:GetCaster():GetAbsOrigin() + direction * self:GetAbility():GetSpecialValueFor("min_distance")
            end
            self.point = vTargetPos
        end
    end
end

modifier_aghanim_ray_magic_immune = class({})
function modifier_aghanim_ray_magic_immune:IsPurgable() return false end
function modifier_aghanim_ray_magic_immune:GetTexture() return "aghanim_16" end
function modifier_aghanim_ray_magic_immune:CheckState()
 	return 
 	{
 		[MODIFIER_STATE_DEBUFF_IMMUNE] = true
	}
end
function modifier_aghanim_ray_magic_immune:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar_aghanim.vpcf"
end


modifier_aghanim_ray_caster = class({})
function modifier_aghanim_ray_caster:IsPurgable() return false end
function modifier_aghanim_ray_caster:IsPurgeException() return false end
function modifier_aghanim_ray_caster:RemoveOnDeath() return not self:GetCaster():HasModifier("modifier_meepo_6") end
function modifier_aghanim_ray_caster:OnCreated(params)
    if not IsServer() then return end
    self.point = Vector(params.x, params.y, params.z)
    self.dummy = CreateUnitByName( "npc_dota_companion", self.point, false, nil, nil, self:GetCaster():GetTeamNumber() )
    self.dummy:SetAbsOrigin(self.point)
    if not self:GetCaster():HasModifier("modifier_meepo_6") then
        self.dummy:AddNewModifier(self.dummy, self:GetAbility(), "modifier_aghanim_shard_thinker", {duration = self:GetAbility():GetSpecialValueFor("duration")})
    else
        self.dummy:AddNewModifier(self.dummy, self:GetAbility(), "modifier_aghanim_shard_thinker", {})
    end
    self.effect_time = 0
    local particle_name = "particles/creatures/aghanim/staff_beam.vpcf"
    if self:GetCaster():HasModifier("modifier_meepo_2") then
        particle_name = "particles/creatures/aghanim/staff_beam_red.vpcf"
    end
    self.nBeamFXIndex = ParticleManager:CreateParticle( particle_name, PATTACH_CUSTOMORIGIN, nil )
    ParticleManager:SetParticleControlEnt( self.nBeamFXIndex, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_staff_fx", self:GetCaster():GetAbsOrigin(), true )
    ParticleManager:SetParticleControlEnt( self.nBeamFXIndex, 1, self.dummy, PATTACH_ABSORIGIN_FOLLOW, nil, self.dummy:GetOrigin(), true )
    ParticleManager:SetParticleControlEnt( self.nBeamFXIndex, 2, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, self.dummy:GetOrigin(), true )
    ParticleManager:SetParticleControlEnt( self.nBeamFXIndex, 9, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true )
    EmitSoundOn( "woda_aghanim_ray_cast", self:GetCaster() )
    self.tick_damage = 0
    self:StartIntervalThink(FrameTime())
end

function modifier_aghanim_ray_caster:OnIntervalThink()
    if not IsServer() then return end
    if self.dummy and self.dummy:IsNull() then return end

    if self:GetCaster():HasModifier("modifier_meepo_9") then
        self:Destroy()
        return
    end

    local passive_disabled = self:GetParent():PassivesDisabled()
    if not self:GetCaster():HasModifier("modifier_meepo_6") then
        passive_disabled = false
    end

    if self:GetCaster():IsAlive() and not self:GetCaster():HasModifier("modifier_wodawisp") and not self:GetCaster():HasModifier("modifier_smoke_of_deceit") and not passive_disabled then
        if self.nBeamFXIndex == nil then
            local particle_name = "particles/creatures/aghanim/staff_beam.vpcf"
            if self:GetCaster():HasModifier("modifier_meepo_2") then
                particle_name = "particles/creatures/aghanim/staff_beam_red.vpcf"
            end
            self.nBeamFXIndex = ParticleManager:CreateParticle( particle_name, PATTACH_CUSTOMORIGIN, nil )
            ParticleManager:SetParticleControlEnt( self.nBeamFXIndex, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_staff_fx", self:GetCaster():GetAbsOrigin(), true )
            ParticleManager:SetParticleControlEnt( self.nBeamFXIndex, 1, self.dummy, PATTACH_ABSORIGIN_FOLLOW, nil, self.dummy:GetOrigin(), true )
            ParticleManager:SetParticleControlEnt( self.nBeamFXIndex, 2, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, self.dummy:GetOrigin(), true )
            ParticleManager:SetParticleControlEnt( self.nBeamFXIndex, 9, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true )
        end
    else
        if self.nBeamFXIndex ~= nil then
            ParticleManager:DestroyParticle(self.nBeamFXIndex, true)
            ParticleManager:ReleaseParticleIndex(self.nBeamFXIndex)
            self.nBeamFXIndex = nil
        end
    end

    if not self:GetCaster():IsAlive() then return end

    local heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetAbility().modifier_meepo_4[self:GetCaster():GetTalentLevel("modifier_meepo_4")], DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, FIND_CLOSEST, false)
	local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetAbility().modifier_meepo_4[self:GetCaster():GetTalentLevel("modifier_meepo_4")], DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false)
    if #heroes > 0 then
        self.point = heroes[1]:GetAbsOrigin()
        self.dummy:SetAbsOrigin(self.point)
    elseif #units > 0 then
        self.point = units[1]:GetAbsOrigin()
        self.dummy:SetAbsOrigin(self.point)
    else
        self.point = self:GetCaster():GetAbsOrigin()
        self.dummy:SetAbsOrigin(self.point)
    end

    local direction = self.point - self.dummy:GetAbsOrigin()
    direction.z = 0
    direction = direction:Normalized()

    local ray_speed = self:GetAbility():GetSpecialValueFor("ray_speed")
    if self:GetCaster():HasModifier("modifier_meepo_17") then
        ray_speed = ray_speed + self:GetAbility().modifier_meepo_17[self:GetCaster():GetTalentLevel("modifier_meepo_17")]
    end

    local new_point = self.dummy:GetAbsOrigin() + direction * (ray_speed * FrameTime())
    local dir_min_c = new_point - self:GetCaster():GetAbsOrigin()
    local distance = dir_min_c:Length2D()

    dir_min_c.z = 0

    local direction_min = dir_min_c:Normalized()
    if distance < self:GetAbility():GetSpecialValueFor("min_distance") - 50 then
        local dir = new_point - self:GetCaster():GetAbsOrigin()
        local len = dir:Length2D()
        dir.z = 0
        dir = dir:Normalized()
        new_point = new_point + dir * (self:GetAbility():GetSpecialValueFor("min_distance") - 150)
    end

    new_point = GetGroundPosition(new_point, nil)

    AddFOWViewer(self:GetCaster():GetTeamNumber(), self.dummy:GetAbsOrigin(), 100, FrameTime(), false)

    self.dummy:SetAbsOrigin(new_point)

    if self.effect_time <= 0.4 then
        self.effect_time = self.effect_time + FrameTime()
    end

    self.tick_damage = self.tick_damage + FrameTime()

    local health_ever = self:GetAbility():GetSpecialValueFor("health_aver")
    if self:GetCaster():HasModifier("modifier_meepo_19") then
        health_ever = health_ever + self:GetAbility().modifier_meepo_19[self:GetCaster():GetTalentLevel("modifier_meepo_19")]
    end

    local passive_disabled = self:GetParent():PassivesDisabled()
    if not self:GetCaster():HasModifier("modifier_meepo_6") then
        passive_disabled = false
    end
    if passive_disabled then return end
    if self.tick_damage >= 0.25 then
        local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), new_point, nil, self:GetAbility():GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
        for _,enemy in pairs( enemies ) do
            local damage = self:GetAbility():GetSpecialValueFor("damage")
            if self:GetCaster():HasModifier("modifier_meepo_20") then
                damage = damage + (self:GetCaster():GetIntellect(false) / 100 * self:GetAbility().modifier_meepo_20[self:GetCaster():GetTalentLevel("modifier_meepo_20")])
            end
            if self:GetCaster():HasModifier("modifier_meepo_2") then
                damage = damage + (self:GetCaster():GetMaxHealth() / 100 * self:GetAbility().modifier_meepo_2[self:GetCaster():GetTalentLevel("modifier_meepo_2")])
            end
            if not self:GetCaster():HasModifier("modifier_meepo_2") then
                if enemy:GetHealthPercent() <= health_ever then
                    damage = damage * self:GetAbility():GetSpecialValueFor("damage_multiple")
                end
            end
            if self.effect_time >= 0.4 then
                --local particle = ParticleManager:CreateParticle("particles/aghanim_ray_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
                --ParticleManager:SetParticleControl(particle, 0, enemy:GetAbsOrigin())
                --ParticleManager:ReleaseParticleIndex(particle)
                self.effect_time = 0
            end
            local damage_type = DAMAGE_TYPE_MAGICAL
            local flags = 0
            if self:GetCaster():HasModifier("modifier_meepo_6") then
                damage_type = DAMAGE_TYPE_PHYSICAL
                flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK
            end
            local damageInfo = 
            {
                victim = enemy,
                attacker = self:GetCaster(),
                damage = damage * 0.25,
                damage_type = damage_type,
                ability = self:GetAbility(),
                damage_flags = flags,
            }
            ApplyDamage( damageInfo )
        end
        self.tick_damage = 0
    end
end

function modifier_aghanim_ray_caster:OnDestroy()
    if not IsServer() then return end
    self:GetCaster():RemoveGesture(ACT_DOTA_CHANNEL_ABILITY_3)
    if self.dummy and not self.dummy:IsNull() then
        self.dummy:RemoveModifierByName("modifier_aghanim_shard_thinker")
    end
    self:GetCaster():RemoveModifierByName("modifier_aghanim_ray_caster_magic_immune")
    if self.nBeamFXIndex then
        ParticleManager:DestroyParticle(self.nBeamFXIndex, true)
    end
    StopSoundOn( "woda_aghanim_ray_cast", self:GetCaster() )
end

modifier_aghanim_ray_21_talent_buff = class({})
function modifier_aghanim_ray_21_talent_buff:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
end
function modifier_aghanim_ray_21_talent_buff:OnRefresh()
    if not IsServer() then return end
    if self:GetStackCount() < 12 then
        self:IncrementStackCount()
    end
end
function modifier_aghanim_ray_21_talent_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
    }
end
function modifier_aghanim_ray_21_talent_buff:GetModifierSpellAmplify_Percentage()
    return self:GetStackCount() * 4
end