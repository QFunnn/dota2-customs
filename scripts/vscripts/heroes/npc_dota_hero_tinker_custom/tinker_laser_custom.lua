--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tinker_laser_custom", "heroes/npc_dota_hero_tinker_custom/tinker_laser_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_tinker_laser_custom_debuff", "heroes/npc_dota_hero_tinker_custom/tinker_laser_custom", LUA_MODIFIER_MOTION_NONE )

tinker_laser_custom = class({})
tinker_laser_custom.modifier_tinker_19_damage = 150
tinker_laser_custom.modifier_tinker_19 = 300
tinker_laser_custom.modifier_tinker_20_model_scale = -12
tinker_laser_custom.modifier_tinker_20 = {-3,-6,-9}

function tinker_laser_custom:Precache(context)
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_tinker.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_tinker.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_tinker.vpcf", context)
end

function tinker_laser_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_tinker_19") then
        return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AOE
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end

function tinker_laser_custom:GetAOERadius()
    if self:GetCaster():HasModifier("modifier_tinker_19") then
        return self:GetCaster():GetAoeBonus(self.modifier_tinker_19)
    end
    return 0
end

function tinker_laser_custom:OnAbilityPhaseStart()
	self:GetCaster():EmitSound("Hero_Tinker.LaserAnim")
	return true
end

function tinker_laser_custom:OnAbilityPhaseInterrupted()
    self:GetCaster():StopSound("Hero_Tinker.LaserAnim")
end

function tinker_laser_custom:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb( self ) then return end
	self:GetCaster():EmitSound("Hero_Tinker.Laser")
    target:EmitSound("Hero_Tinker.LaserImpact")
    self:ApplyLaserEffect(target)
	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_tinker/tinker_laser.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( particle, 9, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack2", self:GetCaster():GetAbsOrigin(), true )
	ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true )
	ParticleManager:ReleaseParticleIndex( particle )
    if self:GetCaster():HasModifier("modifier_tinker_19") then
        local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, self:GetCaster():GetAoeBonus(self.modifier_tinker_19), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
        for _, unit in pairs(units) do
            if unit ~= target then
                self:ApplyLaserEffect(unit)
            end
        end
    end
end

function tinker_laser_custom:ApplyLaserEffect(target)
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
	local damage = self:GetSpecialValueFor("laser_damage")
    if self:GetCaster():HasModifier("modifier_tinker_19") then
        damage = damage + self.modifier_tinker_19_damage
    end
    target:AddNewModifier(caster, self, "modifier_tinker_laser_custom", { duration = duration * (1 - target:GetStatusResistance()) })
    if self:GetCaster():HasModifier("modifier_tinker_20") then
        target:AddNewModifier(caster, self, "modifier_tinker_laser_custom_debuff", { duration = duration * (1 - target:GetStatusResistance()) })
    end
    ApplyDamage( { victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self } )
end

modifier_tinker_laser_custom = class({})

function modifier_tinker_laser_custom:OnCreated( kv )
	self.miss_rate = self:GetAbility():GetSpecialValueFor( "miss_rate" )
end

function modifier_tinker_laser_custom:OnRefresh( kv )
	self.miss_rate = self:GetAbility():GetSpecialValueFor( "miss_rate" )
end

function modifier_tinker_laser_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MISS_PERCENTAGE,
	}
end

function modifier_tinker_laser_custom:GetModifierMiss_Percentage()
	return self.miss_rate
end

modifier_tinker_laser_custom_debuff = class({})
function modifier_tinker_laser_custom_debuff:GetTexture() return "tinker_20" end
function modifier_tinker_laser_custom_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_tinker_laser_custom_debuff:OnCreated()
    self.health = self:GetParent():GetMaxHealth() / 100 * self:GetAbility().modifier_tinker_20[self:GetCaster():GetTalentLevel("modifier_tinker_20")]
end

function modifier_tinker_laser_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
        MODIFIER_PROPERTY_MODEL_SCALE,
    }
end

function modifier_tinker_laser_custom_debuff:GetModifierExtraHealthBonus()
    return self.health
end

function modifier_tinker_laser_custom_debuff:GetModifierModelScale()
    return self:GetAbility().modifier_tinker_20_model_scale
end