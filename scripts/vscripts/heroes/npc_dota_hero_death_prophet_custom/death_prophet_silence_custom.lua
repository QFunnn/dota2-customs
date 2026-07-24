--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_death_prophet_silence_custom", "heroes/npc_dota_hero_death_prophet_custom/death_prophet_silence_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_death_prophet_silence_custom_debuff", "heroes/npc_dota_hero_death_prophet_custom/death_prophet_silence_custom", LUA_MODIFIER_MOTION_NONE )

death_prophet_silence_custom = class({})

death_prophet_silence_custom.modifier_death_prophet_9 = -2
death_prophet_silence_custom.modifier_death_prophet_10 = {175,350}

function death_prophet_silence_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_death_prophet/death_prophet_silence_projectile.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_death_prophet/death_prophet_silence.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_death_prophet/death_prophet_silence_impact.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_death_prophet/death_prophet_silence_custom.vpcf', context )
    PrecacheResource( "particle", 'particles/generic_gameplay/generic_silenced.vpcf', context )
end

function death_prophet_silence_custom:GetAOERadius()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_death_prophet_10") then
        bonus = self.modifier_death_prophet_10[self:GetCaster():GetTalentLevel("modifier_death_prophet_10")]
    end
    return self:GetSpecialValueFor("radius") + bonus
end

function death_prophet_silence_custom:GetCastRange(vLocation, hTarget)
    if self:GetCaster():HasModifier("modifier_death_prophet_10") then
        return self:GetSpecialValueFor("radius") + self.modifier_death_prophet_10[self:GetCaster():GetTalentLevel("modifier_death_prophet_10")]
    end
    return self.BaseClass.GetCastRange(self, vLocation, hTarget)
end

function death_prophet_silence_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_death_prophet_10") then
       return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    return DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_POINT
end

function death_prophet_silence_custom:GetCooldown(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_death_prophet_9") then
        bonus = bonus + self.modifier_death_prophet_9
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function death_prophet_silence_custom:OnSpellStart()
    if not IsServer() then return end

    if self:GetCaster():HasModifier("modifier_death_prophet_10") then
        self:Scream(self:GetCaster():GetAbsOrigin())
        self:GetCaster():EmitSound("Hero_DeathProphet.Silence.Cast")
        return
    end

    local point = self:GetCursorPosition()

    point = GetGroundPosition(point, nil)

    local target = CreateModifierThinker(self:GetCaster(), self, "modifier_death_prophet_silence_custom", nil, point, self:GetCaster():GetTeamNumber(), false)

    local info = 
    {
        EffectName = "",
        Ability = self,
        iMoveSpeed = self:GetSpecialValueFor("projectile_speed"),
        Source = self:GetCaster(),
        Target = target,
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
    }

    local point_start = self:GetCaster():GetAttachmentOrigin(self:GetCaster():ScriptLookupAttachment("attach_attack1"))

    local vDirection = target:GetAbsOrigin() - self:GetCaster():GetOrigin()
    local range = vDirection:Length2D()
    vDirection.z = 0.0
    vDirection = vDirection:Normalized()

    local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_death_prophet/death_prophet_silence_projectile.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster() )
    ParticleManager:SetParticleControl( particle, 0, point_start )
    ParticleManager:SetParticleControl( particle, 1, Vector(self:GetSpecialValueFor("projectile_speed"),self:GetSpecialValueFor("projectile_speed"),self:GetSpecialValueFor("projectile_speed")) )
    ParticleManager:SetParticleControl( particle, 5,  target:GetAbsOrigin() )

    self:GetCaster():EmitSound("Hero_DeathProphet.Silence.Cast")
    ProjectileManager:CreateTrackingProjectile( info )
end

function death_prophet_silence_custom:OnProjectileHit( target, vLocation )
    if not IsServer() then return end

    if target == nil then return end

    self:Scream(vLocation)

    UTIL_Remove(target)

    return true
end

function death_prophet_silence_custom:Scream(point)
    local duration = self:GetSpecialValueFor("duration")
    local radius = self:GetSpecialValueFor("radius")

    if self:GetCaster():HasModifier("modifier_death_prophet_10") then
        radius = radius + self.modifier_death_prophet_10[self:GetCaster():GetTalentLevel("modifier_death_prophet_10")]
    end

    EmitSoundOnLocationWithCaster( point, "Hero_DeathProphet.Silence", self:GetCaster() )

    local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_death_prophet/death_prophet_silence.vpcf", PATTACH_CUSTOMORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, point)
    ParticleManager:SetParticleControl(pfx, 1, Vector(radius+100, 0, 1))
    ParticleManager:ReleaseParticleIndex(pfx)

    local flag = 0

    if self:GetCaster():HasModifier("modifier_death_prophet_14") then
        flag = DOTA_UNIT_TARGET_FLAG_INVULNERABLE
    end

    local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, flag, FIND_ANY_ORDER, false )

    for _,enemy in pairs(enemies) do
        local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_death_prophet/death_prophet_silence_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
        ParticleManager:SetParticleControl(pfx, 0, enemy:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(pfx)
        enemy:AddNewModifier(self:GetCaster(), self, "modifier_death_prophet_silence_custom_debuff", {duration = duration * (1 - enemy:GetStatusResistance())})
        if self:GetCaster():HasModifier("modifier_death_prophet_9") then
            self:GetCaster():PerformAttack(enemy, true, true, true, true, false, false, true)
        end
        if self:GetCaster():HasModifier("modifier_death_prophet_14") then
            enemy:Purge(true, false, false, false, false)
        end
        local death_prophet_exorcism_custom = self:GetCaster():FindAbilityByName("death_prophet_exorcism_custom")
        if death_prophet_exorcism_custom and death_prophet_exorcism_custom:GetLevel() > 0 then
            if self:GetCaster():HasModifier("modifier_death_prophet_11") then
                death_prophet_exorcism_custom:CastGhostToTarget(enemy,death_prophet_exorcism_custom.modifier_death_prophet_13[self:GetCaster():GetTalentLevel("modifier_death_prophet_11")])
            end
        end
    end
end

modifier_death_prophet_silence_custom = class({})
function modifier_death_prophet_silence_custom:IsHidden() return true end

modifier_death_prophet_silence_custom_debuff = class({})

function modifier_death_prophet_silence_custom_debuff:CheckState() return 
    {
        [MODIFIER_STATE_SILENCED] = true,
    } 
end

function modifier_death_prophet_silence_custom_debuff:OnCreated()
    if not IsServer() then return end
    self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_death_prophet/death_prophet_silence_custom.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(self.pfx, 0, self:GetParent():GetAbsOrigin())
    self.pfx2 = ParticleManager:CreateParticle("particles/generic_gameplay/generic_silenced.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(self.pfx2, 0, self:GetParent():GetAbsOrigin())
    self:AddParticle(self.pfx, false, false, -1, false, false)
    self:AddParticle(self.pfx2, false, false, -1, false, false)
end