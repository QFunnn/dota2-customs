--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_sniper_assassinate_custom", "abilities/sniper_assassinate_custom", LUA_MODIFIER_MOTION_NONE)

sniper_assassinate_custom = class({})

function sniper_assassinate_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function sniper_assassinate_custom:OnAbilityPhaseInterrupted()
    if not IsServer() then return end
    self:GetCaster():FadeGesture(ACT_DOTA_CAST_ABILITY_1)
    self:GetCaster():FadeGesture(ACT_DOTA_CAST_ABILITY_4)
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
    for _,enemy in pairs(enemies) do
        if enemy:HasModifier("modifier_sniper_assassinate_custom") then
            enemy:RemoveModifierByName("modifier_sniper_assassinate_custom")
        end
    end
end

function sniper_assassinate_custom:OnAbilityPhaseStart()
    if not IsServer() then return end
    self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_4)

    if true then
        local point = self:GetCursorPosition()
        self.targets = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)

        for _, target in pairs(self.targets) do
            target:AddNewModifier(self:GetCaster(), self, "modifier_sniper_assassinate_custom", {duration = 4})
        end
        return true
    end

    self.target = self:GetCursorTarget()
    self.target:AddNewModifier(self:GetCaster(), self, "modifier_sniper_assassinate_custom", {duration = 4})
    return true
end

function sniper_assassinate_custom:OnSpellStart()
    if not IsServer() then return end

    self:GetCaster():EmitSound("Ability.Assassinate")

    local info = 
    {
        Source = self:GetCaster(),
        Ability = self, 
        bVisibleToEnemies = true,
        bReplaceExisting = false,
        bProvidesVision = false,
        EffectName = "particles/units/heroes/hero_sniper/sniper_assassinate.vpcf",
        iMoveSpeed = 2500,
        bDodgeable = true,
    }

    if true then
        for _,target in pairs(self.targets) do
            info.Target = target
            ProjectileManager:CreateTrackingProjectile(info)
            target:EmitSound("Hero_Sniper.AssassinateProjectile")
        end
        return
    end

    info.Target = self.target
    ProjectileManager:CreateTrackingProjectile(info)
    self.target:EmitSound("Hero_Sniper.AssassinateProjectile")
end

function sniper_assassinate_custom:OnProjectileHit_ExtraData( target, location, extradata )
    if target == nil then return end
    if target:HasModifier("modifier_sniper_assassinate_custom") then
        target:RemoveModifierByName("modifier_sniper_assassinate_custom")
    end
    if target:IsInvulnerable() then return end
    if target:TriggerSpellAbsorb(self) then return end
    target:EmitSound("Hero_Sniper.AssassinateDamage")
    local damage = self:GetSpecialValueFor("damage")
    if self:GetCaster():HasScepter() then
        damage = damage + (self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * self:GetSpecialValueFor("scepter_crit"))
        SendOverheadEventMessage(nil, OVERHEAD_ALERT_CRITICAL, target, damage, nil)
    end
    target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = self:GetSpecialValueFor('scepter_stun_duration') * (1-target:GetStatusResistance())})
    self:GetCaster():PerformAttack(target, true, true, true, false, false, true, true)
    ApplyDamage({victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
end

modifier_sniper_assassinate_custom = class({})

function modifier_sniper_assassinate_custom:IsPurgable()
    return false
end

function modifier_sniper_assassinate_custom:OnCreated( kv )
    if IsServer() then
        local particle = ParticleManager:CreateParticleForTeam( "particles/units/heroes/hero_sniper/sniper_crosshair.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent(), self:GetCaster():GetTeamNumber() )
        self:AddParticle(particle, false, false, -1, false, true )
        self:StartIntervalThink(0.1)
    end
end

function modifier_sniper_assassinate_custom:OnIntervalThink( kv )
    if IsServer() then
        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_truesight", {duration = 0.1})
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), 50, 0.1, false)
    end
end