--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_generic_arc_lua", "modifiers/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier("modifier_marci_grapple_custom_debuff", "heroes/npc_dota_hero_marci_custom/marci_grapple_custom", LUA_MODIFIER_MOTION_NONE)

marci_grapple_custom = class({})

marci_grapple_custom.modifier_marci_1 = {70,140}
marci_grapple_custom.modifier_marci_16 = 500
marci_grapple_custom.modifier_marci_16_mana = 20
marci_grapple_custom.modifier_marci_20 = {10,15,20}

function marci_grapple_custom:CastFilterResultTarget( target )
    if target == self:GetCaster() then
        return UF_FAIL_OTHER
    end

    if not IsServer() then return UF_SUCCESS end
    local nResult = UnitFilter(
        target,
        self:GetAbilityTargetTeam(),
        self:GetAbilityTargetType(),
        self:GetAbilityTargetFlags(),
        self:GetCaster():GetTeamNumber()
    )

    if nResult ~= UF_SUCCESS then
        return nResult
    end

    return UF_SUCCESS
end

function marci_grapple_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_marci.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_dispose_aoe_damage.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_dispose_debuff.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_dispose_land_aoe.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_grapple.vpcf", context )
end

function marci_grapple_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb( self ) then return end
	local air_duration = self:GetSpecialValueFor( "air_duration" )
	local air_height = self:GetSpecialValueFor( "air_height" )
	local throw_distance_behind = self:GetSpecialValueFor( "throw_distance_behind" )
	local landing_radius = self:GetSpecialValueFor( "landing_radius" )
	local debuff_duration = self:GetSpecialValueFor( "debuff_duration" )
	local impact_damage = self:GetSpecialValueFor( "impact_damage" )
    if self:GetCaster():HasModifier("modifier_marci_1") then
        impact_damage = impact_damage + self.modifier_marci_1[self:GetCaster():GetTalentLevel("modifier_marci_1")]
    end
    if self:GetCaster():HasModifier("modifier_marci_20") then
        impact_damage = impact_damage + (self:GetCaster():GetMaxMana() / 100 * self.modifier_marci_20[self:GetCaster():GetTalentLevel("modifier_marci_20")])
    end
	local targetpos = caster:GetOrigin() - caster:GetForwardVector() * throw_distance_behind
	
    if self:GetCaster():HasModifier("modifier_marci_16") and self:GetCaster():GetTeamNumber() == target:GetTeamNumber() then
        local find_radius = self.modifier_marci_16 + (self:GetCaster():GetMaxMana() / 100 * self.modifier_marci_16_mana)
        local find_enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, find_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false )
        local has_enemy = false
        for _, enemy in pairs(find_enemies) do
            if enemy:IsRealHero() and enemy:IsAlive() then
                targetpos = enemy:GetOrigin()
                has_enemy = true
                break
            end
        end
        if not has_enemy then
            for _, enemy in pairs(find_enemies) do
                targetpos = enemy:GetOrigin()
                has_enemy = true
                break
            end
        end
    end

    local totaldist = (target:GetOrigin() - targetpos):Length2D()

	local arc = target:AddNewModifier( caster, self, "modifier_generic_arc_lua",
		{
			target_x = targetpos.x,
			target_y = targetpos.y,
			duration = air_duration,
			distance = totaldist,
			height = air_height,
			fix_end = false,
			fix_duration = false,
			isStun = true,
			isForward = true,
			activity = ACT_DOTA_FLAIL,
		}
	)

	arc:SetEndCallback( function()
		local enemies = FindUnitsInRadius( caster:GetTeamNumber(), target:GetOrigin(), nil, landing_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		for _,enemy in pairs(enemies) do
			enemy:AddNewModifier( caster, self, "modifier_marci_grapple_custom_debuff", {duration = debuff_duration * (1-enemy:GetStatusResistance())})
			ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = impact_damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
            local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_dispose_aoe_damage.vpcf", PATTACH_WORLDORIGIN, nil )
            ParticleManager:SetParticleControl( effect_cast, 1, enemy:GetAbsOrigin() )
            ParticleManager:ReleaseParticleIndex( effect_cast )
		end

        EmitSoundOnLocationWithCaster( target:GetAbsOrigin(), "Hero_Marci.Grapple.Stun", self:GetCaster() )
		GridNav:DestroyTreesAroundPoint( target:GetOrigin(), landing_radius, false )

        local particle_3 = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_dispose_land_aoe.vpcf", PATTACH_WORLDORIGIN, nil )
        ParticleManager:SetParticleControl( particle_3, 0, target:GetAbsOrigin() )
        ParticleManager:SetParticleControl( particle_3, 1, Vector(landing_radius, 0, 0) )
        ParticleManager:ReleaseParticleIndex( particle_3 )
        EmitSoundOnLocationWithCaster( target:GetOrigin(), "Hero_Marci.Grapple.Impact", self:GetCaster() )

        if self:GetCaster():HasModifier("modifier_marci_7") and self:GetCaster():HasModifier("modifier_marci_unleash_custom") then
            local marci_unleash_custom = self:GetCaster():FindAbilityByName("marci_unleash_custom")
            if marci_unleash_custom then
                marci_unleash_custom:Pulse( target:GetOrigin() )
            end
        end
	end)

    local particle_2 = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_dispose_debuff.vpcf", PATTACH_POINT_FOLLOW, caster )
	ParticleManager:SetParticleControlEnt( particle_2, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControlEnt( particle_2, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( particle_2, 5, Vector( duration, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( particle_2 )
	EmitSoundOn( "Hero_Marci.Grapple.Target", target )

	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_grapple.vpcf", PATTACH_POINT_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( particle, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true)
	ParticleManager:SetParticleControlEnt( particle, 2, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack2", Vector(0,0,0), true)
	ParticleManager:ReleaseParticleIndex( particle )
	EmitSoundOn( "Hero_Marci.Grapple.Cast", self:GetCaster() )
end

modifier_marci_grapple_custom_debuff = class({})

function modifier_marci_grapple_custom_debuff:OnCreated()
    self.movement_slow_pct = self:GetAbility():GetSpecialValueFor("movement_slow_pct")
end

function modifier_marci_grapple_custom_debuff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_marci_grapple_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self.movement_slow_pct
end

function modifier_marci_grapple_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_marci/marci_rebound_bounce_impact_debuff.vpcf"
end

function modifier_marci_grapple_custom_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_marci_grapple_custom_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_snapfire_slow.vpcf"
end

function modifier_marci_grapple_custom_debuff:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end