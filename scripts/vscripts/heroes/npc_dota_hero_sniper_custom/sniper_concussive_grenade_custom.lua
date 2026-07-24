--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier("modifier_sniper_concussive_grenade_custom_debuff", "heroes/npc_dota_hero_sniper_custom/sniper_concussive_grenade_custom", LUA_MODIFIER_MOTION_BOTH )

sniper_concussive_grenade_custom = class({})

function sniper_concussive_grenade_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_slow.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_model.vpcf", context )
end

function sniper_concussive_grenade_custom:GetAOERadius()
    return self:GetSpecialValueFor( "radius" )
end

function sniper_concussive_grenade_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local direction = (point - self:GetCaster():GetAbsOrigin())
    direction.z = 0
    local distance = direction:Length2D()
    direction = direction:Normalized()
    local speed = 1200


    local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_model.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
    ParticleManager:SetParticleControlEnt(pfx, 0, self:GetCaster(), PATTACH_POINT, "attach_attack1", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(pfx, 1, Vector(speed,speed,speed))
    ParticleManager:SetParticleControl(pfx, 5, self:GetCursorPosition())

    local options = 
    {
        Ability = self,
        vSpawnOrigin = self:GetCaster():GetAbsOrigin(),
        fDistance = distance,
        fStartRadius = 0,
        fEndRadius = 0,
        Source = self:GetCaster(),
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_NONE,
        fExpireTime = GameRules:GetGameTime() + 1.7,
        bDeleteOnHit = false,
        vVelocity = direction * speed,
        bProvidesVision = true,
        iVisionRadius = 10,
        iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
        ExtraData = {fx = pfx}
    }
    local knockback_height = self:GetSpecialValueFor("knockback_height")
    local knockback_distance = self:GetSpecialValueFor("knockback_distance")
    local knockback_duration = self:GetSpecialValueFor("knockback_duration")
    local knockback = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_generic_knockback_lua", { duration = knockback_duration, distance = knockback_distance, height = knockback_height, IsStun = false, direction_x = -direction.x, direction_y = -direction.y} )
    local callback = function()
        FindClearSpaceForUnit(self:GetCaster(), self:GetCaster():GetAbsOrigin(), true)
    end
    if knockback then
        knockback:SetEndCallback( callback )
    end
    self:GetCaster():EmitSound("Hero_Sniper.ConcussiveGrenade.Cast")
    ProjectileManager:CreateLinearProjectile(options)
    -- Grenade cooldown
    if self:GetCaster():HasModifier("modifier_sniper_3") and self:GetCaster():HasModifier("modifier_sniper_10") and self:GetCaster():HasModifier("modifier_sniper_16") and self:GetCaster():HasModifier("modifier_sniper_17") then
        local grenades = 
        {
            "sniper_concussive_grenade_custom",
            "sniper_smoke_grenade",
            "sniper_molotov_grenade",
            "sniper_flashbang_grenade",
        }
        for _, grenade_name in pairs(grenades) do
            local grenade_ability = self:GetCaster():FindAbilityByName(grenade_name)
            if grenade_ability and grenade_ability ~= self then
                local new_cooldown = grenade_ability:GetCooldownTimeRemaining() - 2
                grenade_ability:EndCooldown()
                if new_cooldown > 0 then
                    grenade_ability:StartCooldown(new_cooldown)
                end
            end
        end
    end
end

function sniper_concussive_grenade_custom:OnProjectileHit_ExtraData(hTarget, vLocation, table)
    if not IsServer() then return end
    local knockback_height = self:GetSpecialValueFor("knockback_height")
    local knockback_distance = self:GetSpecialValueFor("knockback_distance")
    local knockback_duration = self:GetSpecialValueFor("knockback_duration")
    if table.fx then
        ParticleManager:DestroyParticle(table.fx, false)
        ParticleManager:ReleaseParticleIndex(table.fx)
    end
    local radius = self:GetSpecialValueFor("radius")
    local damage = self:GetSpecialValueFor("damage")
    local attack_damage = self:GetSpecialValueFor("attack_damage")
    local duration = self:GetSpecialValueFor("debuff_duration")
    local end_damage = damage + (self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * attack_damage)
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), vLocation, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    for _,unit in pairs(units) do
        local direction = (unit:GetOrigin() - vLocation)
        direction.z = 0
        direction = direction:Normalized()
        local knockback = unit:AddNewModifier(self:GetCaster(), self, "modifier_generic_knockback_lua", {duration = knockback_duration, distance = knockback_distance, height = knockback_height, IsStun = false, direction_x = direction.x, direction_y = direction.y} )
        local callback = function()
            FindClearSpaceForUnit(unit, unit:GetAbsOrigin(), true)
        end
        if knockback then
            knockback:SetEndCallback( callback )
        end
        unit:EmitSound("Hero_Sniper.ConcussiveGrenade.Target")
        ApplyDamage({ victim = unit, attacker = self:GetCaster(), damage = end_damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
        unit:AddNewModifier(self:GetCaster(), self, "modifier_sniper_concussive_grenade_custom_debuff", {duration = duration * (1-unit:GetStatusResistance())})
    end
    EmitSoundOnLocationWithCaster(vLocation, "Hero_Sniper.ConcussiveGrenade", self:GetCaster())
end

modifier_sniper_concussive_grenade_custom_debuff = class({})

function modifier_sniper_concussive_grenade_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_sniper_concussive_grenade_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_sniper_concussive_grenade_custom_debuff:GetEffectName()
    return "particles/units/heroes/hero_sniper/sniper_shard_concussive_grenade_slow.vpcf"
end

function modifier_sniper_concussive_grenade_custom_debuff:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_sniper_concussive_grenade_custom_debuff:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
    }
end