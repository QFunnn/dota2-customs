--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_zuus_lightning_bolt_custom_true_sight", "abilities/zuus_lightning_bolt_custom" , LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zuus_lightning_bolt_custom_true_sight_aura", "abilities/zuus_lightning_bolt_custom" , LUA_MODIFIER_MOTION_NONE)

zuus_lightning_bolt_custom = class({})

function zuus_lightning_bolt_custom:Precache(context)
    PrecacheResource( "particle", 'particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_zuus/zuus_lightning_bolt_glow_fx.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_zuus/zuus_arc_lightning_impact.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_zuus/zuus_lightning_bolt_aoe.vpcf', context )
end

function zuus_lightning_bolt_custom:GetAOERadius()
    return self:GetSpecialValueFor("spread_aoe")
end

function zuus_lightning_bolt_custom:OnAbilityPhaseStart()
    local sound = "Hero_Zuus.LightningBolt.Cast"
	self:GetCaster():EmitSound(sound)
	return true
end

function zuus_lightning_bolt_custom:OnSpellStart(new_target)
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()
	self:CastLightningBolt(self:GetCaster(), point)
end

function zuus_lightning_bolt_custom:CastLightningBolt(caster, target_point, nimbus, target)
    if not IsServer() then return end
    local spread_aoe 			= self:GetSpecialValueFor("spread_aoe")
    local true_sight_radius 	= self:GetSpecialValueFor("true_sight_radius")
    local sight_radius_day  	= self:GetSpecialValueFor("sight_radius_day")
    local sight_radius_night  	= self:GetSpecialValueFor("sight_radius_night")
    local sight_duration 		= self:GetSpecialValueFor("sight_duration")
    local damage_percent        = self:GetSpecialValueFor("damage_percent")
    local ministun_duration     = self:GetSpecialValueFor("ministun_duration")
    local z_pos 				= 3000
    if nimbus then
        nimbus:EmitSound("Hero_Zuus.LightningBolt")
    end
    AddFOWViewer(caster:GetTeam(), target_point, true_sight_radius, sight_duration, false)

    if nimbus then
        if target then
            local nimbus_point = nimbus:GetAbsOrigin()
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", PATTACH_ABSORIGIN_FOLLOW, nimbus)
            ParticleManager:SetParticleControl(particle, 0, nimbus:GetAbsOrigin())
            ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(particle)

            local ifx = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_arc_lightning_impact.vpcf",PATTACH_ABSORIGIN_FOLLOW,target)
            ParticleManager:SetParticleControlEnt(ifx,1,target,PATTACH_ABSORIGIN_FOLLOW,nil,target:GetAbsOrigin(),true)
            ParticleManager:ReleaseParticleIndex(ifx)

            target:AddNewModifier(caster, self, "modifier_zuus_lightning_bolt_custom_true_sight", {duration = sight_duration})
            local damage = self:GetAbilityDamage()
            local damage_percent = target:GetMaxHealth() / 100 * damage_percent
            if not target:IsHero() then
                damage = damage + (damage / 100 * self:GetSpecialValueFor("creep_damage_bonus_pct"))
            end
            target:AddNewModifier(caster, self, "modifier_stunned", {duration = ministun_duration * (1 - target:GetStatusResistance())})
            if nimbus and target:IsHero() then
                damage = damage / 2
            end
            ApplyDamage({attacker = caster, ability = self, damage_type = self:GetAbilityDamageType(), damage = damage, victim = target})
            ApplyDamage({attacker = caster, ability = self, damage_type = self:GetAbilityDamageType(), damage = damage_percent, victim = target, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION})
            nimbus:EmitSound("Hero_Zuus.LightningBolt")
        end
        -- Аганим-Nimbus тоже должен раскрывать инвиз в зоне удара, как обычный
        -- Lightning Bolt. Без этого ниже лежит ранний `return`, и thinker с
        -- modifier_truesight (см. строку ~88) не спавнится — отсюда и баг,
        -- что Nimbus давал только FOW-видимость через AddFOWViewer выше,
        -- но не true-sight на инвизных юнитов.
        CreateModifierThinker(caster, self, "modifier_zuus_lightning_bolt_custom_true_sight_aura", {duration = sight_duration}, target_point, caster:GetTeamNumber(), false)
        return
    else
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particle, 0, Vector(target_point.x, target_point.y, z_pos))
        ParticleManager:SetParticleControl(particle, 1, Vector(target_point.x, target_point.y, target_point.z))
        ParticleManager:ReleaseParticleIndex(particle)
        local particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_lightning_bolt_glow_fx.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particle2, 0, Vector(target_point.x, target_point.y, z_pos))
        ParticleManager:SetParticleControl(particle2, 1, Vector(target_point.x, target_point.y, target_point.z))
        ParticleManager:ReleaseParticleIndex(particle2)
        local aoe = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_lightning_bolt_aoe.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(aoe, 0, target_point)
        ParticleManager:SetParticleControl(aoe, 1, Vector(spread_aoe,spread_aoe,spread_aoe))
        ParticleManager:ReleaseParticleIndex(aoe)
        caster:EmitSound("Hero_Zuus.LightningBolt")
    end
    CreateModifierThinker(self:GetCaster(), self, "modifier_zuus_lightning_bolt_custom_true_sight_aura", {duration = sight_duration}, target_point, self:GetCaster():GetTeamNumber(), false)
    AddFOWViewer(self:GetCaster():GetTeamNumber(), target_point, sight_radius_day, sight_duration, false)
    local units = FindUnitsInRadius(caster:GetTeamNumber(), target_point, nil, spread_aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    for _, target in pairs(units) do
        local ifx = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_arc_lightning_impact.vpcf",PATTACH_ABSORIGIN_FOLLOW,target)
        ParticleManager:SetParticleControlEnt(ifx,1,target,PATTACH_ABSORIGIN_FOLLOW,nil,target:GetAbsOrigin(),true)
        ParticleManager:ReleaseParticleIndex(ifx)
        target:AddNewModifier(caster, self, "modifier_zuus_lightning_bolt_custom_true_sight", {duration = sight_duration})
        local damage = self:GetAbilityDamage()
        local damage_percent = target:GetMaxHealth() / 100 * damage_percent
        if not target:IsHero() then
            damage = damage + (damage / 100 * self:GetSpecialValueFor("creep_damage_bonus_pct"))
        end
        target:AddNewModifier(caster, self, "modifier_stunned", {duration = ministun_duration * (1 - target:GetStatusResistance())})
        ApplyDamage({attacker = caster, ability = self, damage_type = self:GetAbilityDamageType(), damage = damage, victim = target})
        ApplyDamage({attacker = caster, ability = self, damage_type = self:GetAbilityDamageType(), damage = damage_percent, victim = target, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION})
    end
end

modifier_zuus_lightning_bolt_custom_true_sight = class({})
function modifier_zuus_lightning_bolt_custom_true_sight:IsHidden() return true end
function modifier_zuus_lightning_bolt_custom_true_sight:IsPurgable() return false end
function modifier_zuus_lightning_bolt_custom_true_sight:OnCreated(table)
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end
function modifier_zuus_lightning_bolt_custom_true_sight:OnRefresh(table)
    if not IsServer() then return end
    self:OnCreated(table)
end
function modifier_zuus_lightning_bolt_custom_true_sight:OnIntervalThink()
    if not IsServer() then return end
    AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), 10, 0.2, false)
end

modifier_zuus_lightning_bolt_custom_true_sight_aura = class({})

function modifier_zuus_lightning_bolt_custom_true_sight_aura:IsAura()
    return true
end

function modifier_zuus_lightning_bolt_custom_true_sight_aura:IsHidden()
    return false
end

function modifier_zuus_lightning_bolt_custom_true_sight_aura:IsPurgable()
    return false
end

function modifier_zuus_lightning_bolt_custom_true_sight_aura:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("sight_radius_day")
end

function modifier_zuus_lightning_bolt_custom_true_sight_aura:GetModifierAura()
    return "modifier_truesight"
end
 
function modifier_zuus_lightning_bolt_custom_true_sight_aura:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_zuus_lightning_bolt_custom_true_sight_aura:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_zuus_lightning_bolt_custom_true_sight_aura:GetAuraSearchType()
    return DOTA_UNIT_TARGET_ALL
end

function modifier_zuus_lightning_bolt_custom_true_sight_aura:GetAuraDuration()
    return 0.1
end