--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_zuus_lightning_bolt_custom_true_sight", "heroes/npc_dota_hero_zuus_custom/zuus_lightning_bolt_custom" , LUA_MODIFIER_MOTION_NONE)

zuus_lightning_bolt_custom = class({})

zuus_lightning_bolt_custom.modifier_zuus_16 = {15,30}
zuus_lightning_bolt_custom.modifier_zuus_17 = 325

function zuus_lightning_bolt_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuus_lightning_bolt_glow_fx.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuus_lightning_bolt_aoe.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuus_arc_lightning_impact.vpcf", context)
end

function zuus_lightning_bolt_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_zuus_17") then
        return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT
end

function zuus_lightning_bolt_custom:GetAOERadius()
    return self:GetCaster():GetAoeBonus(self.modifier_zuus_17)
end

function zuus_lightning_bolt_custom:OnAbilityPhaseStart()
	self:GetCaster():EmitSound("Hero_Zuus.LightningBolt.Cast")
	return true
end

function zuus_lightning_bolt_custom:OnSpellStart(new_target)
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	if new_target then 
		target = new_target
	end
	local point = self:GetCursorPosition()
	self:CastLightningBolt(self:GetCaster(), target, point, false)
end

function zuus_lightning_bolt_custom:CastLightningBolt(caster, target, target_point, nimbus)
    if not IsServer() then return end
    local spread_aoe = self:GetSpecialValueFor("spread_aoe")
    local true_sight_radius = self:GetSpecialValueFor("true_sight_radius")
    local sight_radius_day = self:GetSpecialValueFor("sight_radius_day")
    local sight_radius_night = self:GetSpecialValueFor("sight_radius_night")
    local sight_duration = self:GetSpecialValueFor("sight_duration")
    local stun_duration = 0.35
    local z_pos = 3000
    if nimbus then
        nimbus:EmitSound("Hero_Zuus.LightningBolt")
    end
    local sound = "Hero_Zuus.LightningBolt"
    if self:GetCaster():HasModifier("modifier_zuus_lightning_weapon_custom") then
        sound = "Hero_Zuus.LightningBolt.Righteous"
    end
    AddFOWViewer(caster:GetTeamNumber(), target_point, true_sight_radius, sight_duration, false)
    if target ~= nil then
        target_point = target:GetAbsOrigin()
        if target == caster then
            z_pos = 2050
        end
    end
    if target == nil then
        local nearby_enemy_units = FindUnitsInRadius( caster:GetTeamNumber(),  target_point,  nil,  spread_aoe,  DOTA_UNIT_TARGET_TEAM_ENEMY,  DOTA_UNIT_TARGET_HERO,  DOTA_UNIT_TARGET_FLAG_NONE,  FIND_CLOSEST,  false )
        for i,unit in pairs(nearby_enemy_units) do
            target = unit
            break
        end
    end
    if target == nil then
        local nearby_enemy_units = FindUnitsInRadius( caster:GetTeamNumber(),  target_point,  nil,  spread_aoe,  DOTA_UNIT_TARGET_TEAM_ENEMY,  self:GetAbilityTargetType(), DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
        for i,unit in pairs(nearby_enemy_units) do
            target = unit
            break
        end
    end
    if not nimbus and target then
        if not self:GetCaster():HasModifier("modifier_zuus_17") then
            if target:GetTeam() ~= caster:GetTeam() then
                if target:TriggerSpellAbsorb(self) then
                    return nil
                end
            end
        end
    end
    if nimbus then
        if target then
            local nimbus_point = nimbus:GetAbsOrigin()
            local target_point = target:GetAbsOrigin()
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", PATTACH_ABSORIGIN_FOLLOW, nimbus)
            ParticleManager:SetParticleControlEnt(particle, 0, parent, PATTACH_OVERHEAD_FOLLOW, "attach_hitloc", Vector(0,0,0), false)
            ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
            EmitSoundOnLocationWithCaster(target_point, sound, nimbus)
        end
    else
        if not self:GetCaster():HasModifier("modifier_zuus_17") then
            if target and not target:IsMagicImmune() then 
                target_point = target:GetAbsOrigin()
            end
        end
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particle, 0, Vector(target_point.x, target_point.y, z_pos))
        ParticleManager:SetParticleControl(particle, 1, Vector(target_point.x, target_point.y, target_point.z))
        ParticleManager:ReleaseParticleIndex(particle)

        local particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_lightning_bolt_glow_fx.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particle2, 0, Vector(target_point.x, target_point.y, z_pos))
        ParticleManager:SetParticleControl(particle2, 1, Vector(target_point.x, target_point.y, target_point.z))
        ParticleManager:ReleaseParticleIndex(particle2)

        if self:GetCaster():HasModifier("modifier_zuus_17") then
            local aoe = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_lightning_bolt_aoe.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager:SetParticleControl(aoe, 0, target_point)
            ParticleManager:SetParticleControl(aoe, 1, Vector( self:GetCaster():GetAoeBonus(self.modifier_zuus_17), self:GetCaster():GetAoeBonus(self.modifier_zuus_17), self:GetCaster():GetAoeBonus(self.modifier_zuus_17)))
            ParticleManager:ReleaseParticleIndex(aoe)
        end

	    EmitSoundOnLocationWithCaster(target_point, sound, caster)
    end

    AddFOWViewer(self:GetCaster():GetTeamNumber(), target_point, sight_radius_day, sight_duration, false)

    local damage = self:GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_zuus_16") then
        damage = damage + (self:GetCaster():GetIntellect(true) / 100 * self.modifier_zuus_16[self:GetCaster():GetTalentLevel("modifier_zuus_16")])
    end

    if self:GetCaster():HasModifier("modifier_zuus_17") and not nimbus then
        CreateModifierThinker(caster, self, "modifier_zuus_lightning_bolt_custom_true_sight", {duration = sight_duration}, target_point, self:GetCaster():GetTeamNumber(), false)
        local units = FindUnitsInRadius(caster:GetTeamNumber(), target_point, nil, self:GetCaster():GetAoeBonus(self.modifier_zuus_17), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
        for _, target_unit in pairs(units) do
            local ifx = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_arc_lightning_impact.vpcf",PATTACH_ABSORIGIN_FOLLOW,target_unit)
            ParticleManager:SetParticleControlEnt(ifx,1,target_unit,PATTACH_ABSORIGIN_FOLLOW,nil,target_unit:GetAbsOrigin(),true)
            ParticleManager:ReleaseParticleIndex(ifx)
            target_unit:AddNewModifier(caster, self, "modifier_stunned", {duration = stun_duration * (1 - target_unit:GetStatusResistance())})
            ApplyDamage({attacker = caster, ability = self, damage_type = self:GetAbilityDamageType(), damage = damage, victim = target_unit})
        end
    else
        if target ~= nil and target:GetTeam() ~= caster:GetTeam() then
            local ifx = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_arc_lightning_impact.vpcf",PATTACH_ABSORIGIN_FOLLOW,target)
            ParticleManager:SetParticleControlEnt(ifx,1,target,PATTACH_ABSORIGIN_FOLLOW,nil,target:GetAbsOrigin(),true)
            ParticleManager:ReleaseParticleIndex(ifx)
            CreateModifierThinker(caster, self, "modifier_zuus_lightning_bolt_custom_true_sight", {duration = sight_duration}, target_point, self:GetCaster():GetTeamNumber(), false)
            target:AddNewModifier(caster, self, "modifier_stunned", {duration = stun_duration * (1 - target:GetStatusResistance())})
            ApplyDamage({attacker = caster, ability = self, damage_type = self:GetAbilityDamageType(), damage = damage, victim = target})
        end
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

function modifier_zuus_lightning_bolt_custom_true_sight:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("true_sight_radius")
end

function modifier_zuus_lightning_bolt_custom_true_sight:GetModifierAura()
    return "modifier_truesight"
end
   
function modifier_zuus_lightning_bolt_custom_true_sight:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_zuus_lightning_bolt_custom_true_sight:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_zuus_lightning_bolt_custom_true_sight:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_OTHER
end

function modifier_zuus_lightning_bolt_custom_true_sight:GetAuraDuration()
    return 0.5
end