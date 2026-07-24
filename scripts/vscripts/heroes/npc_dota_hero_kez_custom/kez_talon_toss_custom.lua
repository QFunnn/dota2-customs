--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kez_talon_toss_custom", "heroes/npc_dota_hero_kez_custom/kez_talon_toss_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_talon_toss_custom_damage", "heroes/npc_dota_hero_kez_custom/kez_talon_toss_custom", LUA_MODIFIER_MOTION_NONE)

kez_talon_toss_custom = class({})

kez_talon_toss_custom.modifier_kez_15 = {50,100}
kez_talon_toss_custom.modifier_kez_15_radius = 175

function kez_talon_toss_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function kez_talon_toss_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_kez_15") then
        return DOTA_ABILITY_BEHAVIOR_HIDDEN + DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_AOE
    end
    return DOTA_ABILITY_BEHAVIOR_HIDDEN + DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_SHOW_IN_GUIDES
end

function kez_talon_toss_custom:GetAOERadius()
    return self.modifier_kez_15_radius
end

function kez_talon_toss_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_sai_toss.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_sai_toss_impact.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_silenced.vpcf", context )
end

function kez_talon_toss_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    local projectile = 
    {
        Target = target,
        Source = self:GetCaster(),
        Ability = self,
        EffectName = "particles/units/heroes/hero_kez/kez_sai_toss.vpcf",
        iMoveSpeed = self:GetSpecialValueFor("speed"),
        bDodgeable = true,
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2
    }
    self:GetCaster():EmitSound("Hero_Kez.TalonToss.Cast")
    ProjectileManager:CreateTrackingProjectile(projectile)
    ---------------------------------------------------------------------------------------------
    if self:GetCaster():HasModifier("modifier_kez_21") then return end
    local kez_grappling_claw_custom = self:GetCaster():FindAbilityByName("kez_grappling_claw_custom")
    if kez_grappling_claw_custom then
        kez_grappling_claw_custom:UseResources(false, false, false, true)
    end
end

function kez_talon_toss_custom:OnProjectileHit(target, location)
    if not IsServer() then return end
    if target == nil then return end
     if target:TriggerSpellAbsorb(self) then return end
    local radius = self:GetSpecialValueFor("radius")
    local silence_duration = self:GetSpecialValueFor("silence_duration")
    target:AddNewModifier(self:GetCaster(), self, "modifier_kez_talon_toss_custom", {duration = silence_duration * (1-target:GetStatusResistance())})
    self:GetCaster().spell_attack = true
    local modifier_kez_talon_toss_custom_damage = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kez_talon_toss_custom_damage", {})
    if modifier_kez_talon_toss_custom_damage then
        if self:GetCaster():HasModifier("modifier_kez_15") then
            local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, self.modifier_kez_15_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
            for _,unit in pairs(units) do
                self:GetCaster():PerformAttack(unit, true, true, true, false, false, false, true)
            end
        else
            self:GetCaster():PerformAttack(target, true, true, true, false, false, false, true)
        end
        modifier_kez_talon_toss_custom_damage:Destroy()
    end
    self:GetCaster().spell_attack = nil
    --local kez_shodo_sai_custom = self:GetCaster():FindAbilityByName("kez_shodo_sai_custom")
    --if kez_shodo_sai_custom and kez_shodo_sai_custom:GetLevel() > 0 then
    --    kez_shodo_sai_custom:AddTargetMark(target)
    --end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_sai_toss_impact.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, Vector(radius, 0, 0))
    ParticleManager:ReleaseParticleIndex(particle)
    EmitSoundOnLocationWithCaster(target:GetAbsOrigin(), "Hero_Kez.TalonToss.Target", self:GetCaster())
end

modifier_kez_talon_toss_custom = class({})

function modifier_kez_talon_toss_custom:CheckState()
    return
    {
        [MODIFIER_STATE_SILENCED] = true,
    }
end

function modifier_kez_talon_toss_custom:GetEffectName()
    return "particles/units/heroes/hero_kez/kez_silenced.vpcf"
end

function modifier_kez_talon_toss_custom:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

modifier_kez_talon_toss_custom_damage = class({})
function modifier_kez_talon_toss_custom_damage:IsHidden() return true end
function modifier_kez_talon_toss_custom_damage:IsPurgeException() return false end
function modifier_kez_talon_toss_custom_damage:IsPurgable() return false end
function modifier_kez_talon_toss_custom_damage:RemoveOnDeath() return false end
function modifier_kez_talon_toss_custom_damage:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_OVERRIDE_ATTACK_DAMAGE,
    }
end
function modifier_kez_talon_toss_custom_damage:GetModifierOverrideAttackDamage()
    if not IsServer() then return end
    local damage = self:GetAbility():GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_kez_15") then
        damage = damage + (self:GetCaster():GetIntellect(true) / 100 * self:GetAbility().modifier_kez_15[self:GetCaster():GetTalentLevel("modifier_kez_15")])
    end
    return damage
end