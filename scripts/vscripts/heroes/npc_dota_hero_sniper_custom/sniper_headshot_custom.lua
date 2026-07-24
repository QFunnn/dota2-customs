--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_sniper_headshot_custom", "heroes/npc_dota_hero_sniper_custom/sniper_headshot_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_headshot_custom_slow", "heroes/npc_dota_hero_sniper_custom/sniper_headshot_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_headshot_custom_disarmed", "heroes/npc_dota_hero_sniper_custom/sniper_headshot_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_headshot_custom_active_attack", "heroes/npc_dota_hero_sniper_custom/sniper_headshot_custom", LUA_MODIFIER_MOTION_NONE )

sniper_headshot_custom = class({})
sniper_headshot_custom.modifier_sniper_1_disarm_duration = 3
sniper_headshot_custom.modifier_sniper_1_range = 450
sniper_headshot_custom.modifier_sniper_1_cooldown = 6
sniper_headshot_custom.modifier_sniper_2 = {0,30,60}
sniper_headshot_custom.modifier_sniper_2_per_str = 1.5
sniper_headshot_custom.modifier_sniper_7 = 1
sniper_headshot_custom.modifier_sniper_7_range = 50
sniper_headshot_custom.modifier_sniper_5_base = 1
sniper_headshot_custom.modifier_sniper_5_attack_bonus = 1
sniper_headshot_custom.modifier_sniper_5_str = {300,200}

function sniper_headshot_custom:GetCastRange(vLocation, hTarget)
    if IsClient() then
        if self:GetCaster():HasModifier("modifier_sniper_1") then
            return self.modifier_sniper_1_range + 200
        end
    end
end

function sniper_headshot_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_sniper_1") then
        return "sniper_1"
    end
    return "sniper_headshot"
end

function sniper_headshot_custom:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    if point == caster:GetAbsOrigin() then
        point = point + caster:GetForwardVector()
    end
    local distance = self.modifier_sniper_1_range + self:GetCaster():GetCastRangeBonus()
    local blast_width_initial = 225 / 2
    local blast_width_end = 400 / 2
    local blast_speed = 3000
    local particle = "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun.vpcf"
    local reverse = 0
    local sound = "Hero_Snapfire.Shotgun.Fire"
    local direction = point-caster:GetAbsOrigin()
    direction.z = 0
    direction = direction:Normalized()    
    local info = 
    {
        Source = caster,
        Ability = self,
        vSpawnOrigin = caster:GetAbsOrigin(),
        bDeleteOnHit = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        EffectName = particle,
        fDistance = distance,
        fStartRadius = blast_width_initial,
        fEndRadius =blast_width_end,
        vVelocity = direction * blast_speed,
        bProvidesVision = false,
        ExtraData = {x = caster:GetAbsOrigin().x, y = caster:GetAbsOrigin().y}
    }
    local proj = ProjectileManager:CreateLinearProjectile(info)
    caster:EmitSound(sound)
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_sniper_headshot_custom_disarmed", {duration = self.modifier_sniper_1_disarm_duration * (1 - self:GetCaster():GetStatusResistance())})
    self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 2)
    Timers:CreateTimer(0.25, function()
        self:GetCaster():FadeGesture(ACT_DOTA_ATTACK)
    end)
end

function sniper_headshot_custom:OnProjectileHit_ExtraData( target, location, extraData )
    if not IsServer() then return end
    if not target then return end
    local caster = self:GetCaster()
    local attack_count = 1
    if self:GetCaster():HasModifier("modifier_sniper_5") then
        attack_count = attack_count + self.modifier_sniper_5_base + ( (self:GetCaster():GetStrength() / self.modifier_sniper_5_str[caster:GetTalentLevel("modifier_sniper_5")]) * self.modifier_sniper_5_attack_bonus )
    end
    local modifier_sniper_headshot_custom_active_attack = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_sniper_headshot_custom_active_attack", {})
    if modifier_sniper_headshot_custom_active_attack then
        for i=1, attack_count do
            self:GetCaster():PerformAttack(target, true, true, true, false, false, false, true)
        end
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
        ParticleManager:ReleaseParticleIndex(particle)
        target:EmitSound("Hero_Snapfire.Shotgun.Target")
        modifier_sniper_headshot_custom_active_attack:Destroy()
    end
end

function sniper_headshot_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_sniper_1") then
        return self.modifier_sniper_1_cooldown
    end
end

function sniper_headshot_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_sniper_1") then
        return DOTA_ABILITY_BEHAVIOR_POINT
    end
    return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function sniper_headshot_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_sniper/sniper_headshot_slow.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_sniper/concussive_grenade_disarm.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_impact.vpcf", context )
end

function sniper_headshot_custom:GetIntrinsicModifierName()
    return "modifier_sniper_headshot_custom"
end

modifier_sniper_headshot_custom = class({})
function modifier_sniper_headshot_custom:IsHidden() return true end
function modifier_sniper_headshot_custom:IsPurgable() return false end
function modifier_sniper_headshot_custom:IsPurgeException() return false end
function modifier_sniper_headshot_custom:RemoveOnDeath() return false end
function modifier_sniper_headshot_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
    }
end

function modifier_sniper_headshot_custom:GetModifierProcAttack_BonusDamage_Physical(params)
    if self:GetCaster():HasModifier("modifier_sniper_17") then return end
    if not IsServer() then return end
    local target = params.target
    if not self:GetParent():HasModifier("modifier_sniper_headshot_custom_active_attack") then
        if self:GetParent():PassivesDisabled() then return 0 end
    end
    if self:GetParent():IsIllusion() then return end
    local chance = self:GetAbility():GetSpecialValueFor("proc_chance")
    if self:GetParent():HasModifier("modifier_sniper_headshot_custom_active_attack") then
        chance = 100
    end
    if not self:GetParent():HasModifier("modifier_sniper_take_aim_custom_active") then 
        if not RollPseudoRandomPercentage(chance, 285, self:GetParent()) then 
            return 
        end
    end
    local knockback_dist = self:GetAbility():GetSpecialValueFor("knockback_distance")
    local damage = self:GetAbility():GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_sniper_2") then
        damage = damage + (self:GetAbility().modifier_sniper_2[self:GetCaster():GetTalentLevel("modifier_sniper_2")] + (self:GetCaster():GetStrength() * self:GetAbility().modifier_sniper_2_per_str))
    end
    local slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
    if self:GetCaster():HasModifier("modifier_sniper_7") then
        slow_duration = slow_duration + self:GetAbility().modifier_sniper_7
        knockback_dist = knockback_dist + self:GetAbility().modifier_sniper_7_range
    end
    target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_sniper_headshot_custom_slow", { duration = slow_duration * (1 - target:GetStatusResistance())})

    local distance_end = (target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D()
    knockback_dist = math.max(5, (1 - distance_end / 800) * knockback_dist)

    local knockback =	
    {
        should_stun = 0,
        knockback_duration = 0.1,
        duration = 0.1,
        knockback_distance = knockback_dist,
        knockback_height = 0,
        center_x = self:GetParent():GetAbsOrigin().x,
        center_y = self:GetParent():GetAbsOrigin().y,
        center_z = self:GetParent():GetAbsOrigin().z,
    }
    if not target:IsCurrentlyHorizontalMotionControlled() and not target:IsCurrentlyVerticalMotionControlled() then 
        target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_knockback", knockback)
    end     
    return damage
end

modifier_sniper_headshot_custom_slow = class({})

function modifier_sniper_headshot_custom_slow:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_sniper_headshot_custom_slow:OnCreated(table)
    self.slow = self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_sniper_headshot_custom_slow:GetModifierMoveSpeedBonus_Percentage()
    return self.slow
end

function modifier_sniper_headshot_custom_slow:GetModifierAttackSpeedBonus_Constant()
    return self.slow
end

function modifier_sniper_headshot_custom_slow:GetEffectName()
    return "particles/units/heroes/hero_sniper/sniper_headshot_slow.vpcf"
end

function modifier_sniper_headshot_custom_slow:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

modifier_sniper_headshot_custom_disarmed = class({})
function modifier_sniper_headshot_custom_disarmed:GetEffectName()
    return "particles/units/heroes/hero_sniper/concussive_grenade_disarm.vpcf"
end
function modifier_sniper_headshot_custom_disarmed:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end
function modifier_sniper_headshot_custom_disarmed:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
    }
end

modifier_sniper_headshot_custom_active_attack = class({})
function modifier_sniper_headshot_custom_active_attack:IsHidden() return true end
function modifier_sniper_headshot_custom_active_attack:IsPurgable() return false end
function modifier_sniper_headshot_custom_active_attack:IsPurgeException() return false end
function modifier_sniper_headshot_custom_active_attack:RemoveOnDeath() return false end