--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_custom_phantom_assassin_phantom_strike", "heroes/npc_dota_hero_phantom_assassin_custom/phantom_assassin_phantom_strike_custom", LUA_MODIFIER_MOTION_NONE )

phantom_assassin_phantom_strike_custom = class({})

function phantom_assassin_phantom_strike_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_phantom_assassin/phantom_assassin_phantom_strike_start.vpcf", context )
    PrecacheResource( "particle", "particles/phantom_8.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_phantom_assassin/phantom_assassin_phantom_strike_end.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf", context )
end

phantom_assassin_phantom_strike_custom.modifier_phantom_assassin_8_base = 50
phantom_assassin_phantom_strike_custom.modifier_phantom_assassin_8_perc = {100,200}
phantom_assassin_phantom_strike_custom.modifier_phantom_assassin_11 = {0.5,1,1.5}
phantom_assassin_phantom_strike_custom.modifier_phantom_assassin_11_lifesteal = {6,12,18}

function phantom_assassin_phantom_strike_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_phantom_assassin_10") then
        return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
end

function phantom_assassin_phantom_strike_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_phantom_assassin_8") then
        return "phantom_assassin_8"
    end
    return "phantom_assassin_phantom_strike"
end

function phantom_assassin_phantom_strike_custom:CastFilterResultTarget(target)
	if target == self:GetCaster() then
		return UF_FAIL_FRIENDLY
	end
    if target:IsOther() then
        return UF_FAIL_OTHER
    end
	return UF_SUCCESS
end

function phantom_assassin_phantom_strike_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration") 
    if self:GetCaster():HasModifier("modifier_phantom_assassin_11") then
        duration = duration + self.modifier_phantom_assassin_11[self:GetCaster():GetTalentLevel("modifier_phantom_assassin_11")]
    end
    local blinkPosition
    local target = self:GetCursorTarget()
    local point = self:GetCursorPosition()
    if target ~= nil then
        local blinkDistance = 50
        local blinkDirection = (self:GetCaster():GetOrigin() - target:GetOrigin()):Normalized() * blinkDistance
        blinkPosition = target:GetOrigin() + blinkDirection
    else
        blinkPosition = point
    end
    local origin = self:GetCaster():GetAbsOrigin()

    if target ~= nil and target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        if target:TriggerSpellAbsorb( self ) then return end
    end

    local particle_cast_start = "particles/units/heroes/hero_phantom_assassin/phantom_assassin_phantom_strike_start.vpcf"
    local particle_cast_end = "particles/units/heroes/hero_phantom_assassin/phantom_assassin_phantom_strike_end.vpcf"

    if self:GetCaster():GetModelName() == "models/heroes/phantom_assassin/pa_arcana.vmdl" then 
        particle_cast_start = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf"
        particle_cast_end = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf"
    end

    local particle_start = ParticleManager:CreateParticle( particle_cast_start, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( particle_start, 0, origin )
    ParticleManager:ReleaseParticleIndex( particle_start )
    EmitSoundOnLocationWithCaster( origin, "Hero_PhantomAssassin.Strike.Start", self:GetCaster() )

    local enemies = FindUnitsInLine(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), point, nil, 200, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE)

    if self:GetCaster():HasModifier('modifier_phantom_assassin_8') then
        local effect_cast = ParticleManager:CreateParticle(  "particles/phantom_8.vpcf", PATTACH_WORLDORIGIN, nil )
        ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetAbsOrigin() )
        ParticleManager:SetParticleControl( effect_cast, 1, blinkPosition )
        ParticleManager:ReleaseParticleIndex( effect_cast )
    end

    self:GetCaster():SetOrigin( blinkPosition )

    FindClearSpaceForUnit( self:GetCaster(), blinkPosition, true )

    if self:GetCaster():HasModifier('modifier_phantom_assassin_8') then
        for _,enemy in pairs(enemies) do
            local damage = self.modifier_phantom_assassin_8_base + (self:GetCaster():GetAgility() / 100 * self.modifier_phantom_assassin_8_perc[self:GetCaster():GetTalentLevel("modifier_phantom_assassin_8")])
            ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
        end
    end

    local particle_end = ParticleManager:CreateParticle( particle_cast_end, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( particle_end, 0, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( particle_end )
    EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_PhantomAssassin.Strike.End", self:GetCaster() )

    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_custom_phantom_assassin_phantom_strike", { duration = duration } )
    self:GetCaster():MoveToPositionAggressive(self:GetCaster():GetOrigin())
end

modifier_custom_phantom_assassin_phantom_strike = class({})

function modifier_custom_phantom_assassin_phantom_strike:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL,
    }
end

function modifier_custom_phantom_assassin_phantom_strike:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor( "bonus_attack_speed" )
end

function modifier_custom_phantom_assassin_phantom_strike:GetModifierProperty_PhysicalLifesteal(params)
    if not self:GetParent():HasModifier("modifier_phantom_assassin_11") then return end
    return self:GetAbility().modifier_phantom_assassin_11_lifesteal[self:GetCaster():GetTalentLevel("modifier_phantom_assassin_11")]
end