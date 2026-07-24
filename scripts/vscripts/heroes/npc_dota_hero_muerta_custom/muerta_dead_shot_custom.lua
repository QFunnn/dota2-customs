--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_muerta_dead_shot_custom_debuff", "heroes/npc_dota_hero_muerta_custom/muerta_dead_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_muerta_dead_shot_custom_fear", "heroes/npc_dota_hero_muerta_custom/muerta_dead_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_muerta_dead_shot_custom_thinker", "heroes/npc_dota_hero_muerta_custom/muerta_dead_shot_custom", LUA_MODIFIER_MOTION_NONE)

muerta_dead_shot_custom = class({})

function muerta_dead_shot_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_deadshot_tracking_proj.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_deadshot_creep_impact.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_deadshot_linear.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_ultimate_projectile_alternate.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_abaddon/abaddon_death_coil_explosion.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_deadshot_creep_impact.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_calling_debuff_slow.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_spell_fear_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_spell_fear_debuff_status.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_muerta.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_muerta.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_muerta.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_muerta/muerta_deadshot_linear_scepter.vpcf", context)
end

muerta_dead_shot_custom.modifier_muerta_15 = {40,60,80}
muerta_dead_shot_custom.modifier_muerta_15_radius = 175
muerta_dead_shot_custom.modifier_muerta_19 = {75,150,225}
muerta_dead_shot_custom.modifier_muerta_20 = {-2,-4}

function muerta_dead_shot_custom:GetCooldown(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_muerta_20") then
        bonus = self.modifier_muerta_20[self:GetCaster():GetTalentLevel("modifier_muerta_20")]
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function muerta_dead_shot_custom:CastFilterResultTarget( hTarget )
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end

	local nResult = UnitFilter(
		hTarget,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_TREE,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		self:GetCaster():GetTeamNumber()
	)

	if nResult ~= UF_SUCCESS then
		return nResult
	end

	self.targetcast = hTarget

	return UF_SUCCESS
end

function muerta_dead_shot_custom:OnAbilityPhaseInterrupted()
    self.targetcast = nil
end

function muerta_dead_shot_custom:OnVectorCastStart(vStartLocation, vDirection)
	if not IsServer() then return end

	local point = self:GetVector2Position()

	local point_check = self:GetTargetPositionCheck()

	local target = self.targetcast

	if self.targetcast == nil then
		target = self:GetCursorTarget()
	end

	if target == nil then return end

	if not target:IsBaseNPC() then
		local dummy = CreateUnitByName("npc_dota_companion", target:GetAbsOrigin(), false, nil, nil, self:GetCaster():GetTeamNumber())
        dummy:AddNewModifier(self:GetCaster(), self, "modifier_muerta_dead_shot_custom_thinker", {})
        dummy.tree = target
        target = dummy
        point_check = target:GetAbsOrigin()
	end

	local vel = point - point_check
	vel.z = 0
	vel = vel:Normalized()

    local info = 
    {
        EffectName = "particles/units/heroes/hero_muerta/muerta_deadshot_tracking_proj.vpcf",
        Ability = self,
        iMoveSpeed = self:GetSpecialValueFor("speed"),
        Source = self:GetCaster(),
        Target = target,
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2,
        ExtraData = { x = vel.x, y = vel.y, tracking = 1 }
    }

    self:GetCaster():EmitSound("Hero_Muerta.DeadShot.Cast")

    ProjectileManager:CreateTrackingProjectile( info )

    self.targetcast = nil
end

modifier_muerta_dead_shot_custom_thinker = class({})

function modifier_muerta_dead_shot_custom_thinker:IsHidden() return true end
function modifier_muerta_dead_shot_custom_thinker:IsPurgable() return false end

function modifier_muerta_dead_shot_custom_thinker:CheckState()
    return 
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_muerta_dead_shot_custom_thinker:OnDestroy()
	if not IsServer() then return end
	if self:GetParent().tree then
		self:GetParent().tree:CutDown(self:GetCaster():GetTeamNumber())
	end
    GridNav:DestroyTreesAroundPoint(self:GetParent():GetAbsOrigin(), 25, true)
end

function muerta_dead_shot_custom:OnProjectileHit_ExtraData( target, location, data )
    if not IsServer() then return end

    if target and data.tracking == 1 then

        if target:TriggerSpellAbsorb(self) then return end

    	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_muerta/muerta_deadshot_creep_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())

		if not target:IsMagicImmune() then
    		target:AddNewModifier(self:GetCaster(), self, "modifier_muerta_dead_shot_custom_debuff", {duration = self:GetSpecialValueFor("impact_slow_duration") * (1-target:GetStatusResistance())})
    	end

    	local vel = Vector(data.x, data.y, 0)

    	local effect = "particles/units/heroes/hero_muerta/muerta_deadshot_linear.vpcf"
        local radius_start = self:GetSpecialValueFor("ricochet_radius_start")
        local radius_end = self:GetSpecialValueFor("ricochet_radius_end")
        if self:GetCaster():HasModifier("modifier_muerta_16") then
			--effect = "particles/units/heroes/hero_muerta/muerta_deadshot_linear_scepter.vpcf"
            radius_start = radius_start
            radius_end = radius_end  + 300
		end
        local range = self:GetEffectiveCastRange(location, nil) * self:GetSpecialValueFor("ricochet_distance_multiplier")

    	local info = 
    	{
    		ExtraData = { x = vel.x, y = vel.y, tracking = 0, source = target:entindex() },
            Source = self:GetCaster(),
            Ability = self,
            EffectName = effect,
            vSpawnOrigin = target:GetAbsOrigin(),
            fDistance = range,
            vVelocity = vel * self:GetSpecialValueFor("speed"),
            fStartRadius = radius_start,
            fEndRadius = radius_end,
            iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
            iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            bProvidesVision = true,
            iVisionRadius = 115,
            iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
            fExpireTime         = GameRules:GetGameTime() + 5.0,
        	bDeleteOnHit        = false,
        }

        target:EmitSound("Hero_Muerta.DeadShot.Damage")
        target:EmitSound("Hero_Muerta.DeadShot.Ricochet")
        target:EmitSound("Hero_Muerta.DeadShot.Slow")

        if self:GetCaster():HasModifier("modifier_muerta_15") then
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_death_coil_explosion.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
            ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())

            local heroes = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetOrigin(), nil, self:GetCaster():GetAoeBonus(self.modifier_muerta_15_radius), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false)
            for _, hero in pairs(heroes) do
                ApplyDamage({ victim = hero, attacker = self:GetCaster(), ability = self, damage = self.modifier_muerta_15[self:GetCaster():GetTalentLevel("modifier_muerta_15")], damage_type = DAMAGE_TYPE_MAGICAL })
            end
        end

        local bonus_damage = 0
        if self:GetCaster():HasModifier("modifier_muerta_19") then
            bonus_damage = self.modifier_muerta_19[self:GetCaster():GetTalentLevel("modifier_muerta_19")]
        end

        if not target:IsMagicImmune() then
            ApplyDamage({ victim = target, attacker = self:GetCaster(), ability = self, damage = self:GetSpecialValueFor("damage") + bonus_damage, damage_type = DAMAGE_TYPE_MAGICAL })
        end

        ProjectileManager:CreateLinearProjectile( info )

        if target:GetUnitName() == "npc_dota_companion" then
            target:RemoveModifierByName("modifier_muerta_dead_shot_custom_thinker")
        	target:ForceKill(false)
        end
    end

    if target and data.tracking == 0 and target:entindex() ~= data.source then
    	target:EmitSound("Hero_Muerta.DeadShot.Damage")
    	target:EmitSound("Hero_Muerta.DeadShot.Fear")
    	target:EmitSound("Hero_Muerta.DeadShot.Impact")
    	target:EmitSound("Hero_Muerta.DeadShot.Ricochet.Impact")
    	target:EmitSound("Hero_Muerta.Impact")

        if self:GetCaster():HasModifier("modifier_muerta_15") then
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_death_coil_explosion.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
            ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())

            local heroes = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetOrigin(), nil, self.modifier_muerta_15_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false)
            for _, hero in pairs(heroes) do
                ApplyDamage({ victim = hero, attacker = self:GetCaster(), ability = self, damage = self.modifier_muerta_15[self:GetCaster():GetTalentLevel("modifier_muerta_15")], damage_type = DAMAGE_TYPE_MAGICAL })
            end
        end

        -- if self:GetCaster():HasModifier("modifier_muerta_16") then
        --     if not target:IsMagicImmune() then
        --         target:AddNewModifier(self:GetCaster(), self, "modifier_muerta_dead_shot_custom_debuff", {duration = self:GetSpecialValueFor("impact_slow_duration") * (1-target:GetStatusResistance())})
        --     end
        -- end
        if self:GetCaster():HasModifier("modifier_muerta_16") then
            target:AddNewModifier(self:GetCaster(), self, "modifier_muerta_dead_shot_custom_fear", {duration = self:GetSpecialValueFor("ricochet_fear_duration") * (1-target:GetStatusResistance()), x = self:GetCaster():GetAbsOrigin().x, y = self:GetCaster():GetAbsOrigin().y})
        end

        local bonus_damage = 0
        if self:GetCaster():HasModifier("modifier_muerta_19") then
            bonus_damage = self.modifier_muerta_19[self:GetCaster():GetTalentLevel("modifier_muerta_19")]
        end

    	ApplyDamage({ victim = target, attacker = self:GetCaster(), ability = self, damage = self:GetSpecialValueFor("damage") + bonus_damage, damage_type = DAMAGE_TYPE_MAGICAL })
    	target:AddNewModifier(self:GetCaster(), self, "modifier_muerta_dead_shot_custom_fear", {duration = self:GetSpecialValueFor("ricochet_fear_duration") * (1-target:GetStatusResistance()), x = location.x, y = location.y})
    	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_muerta/muerta_deadshot_creep_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())

        if not self:GetCaster():HasModifier("modifier_muerta_16") then
            if target:IsHero() then
        	   return true
            end
        end
    end
end

modifier_muerta_dead_shot_custom_debuff = class({})

function modifier_muerta_dead_shot_custom_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_muerta_dead_shot_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("impact_slow_percent")
end

function modifier_muerta_dead_shot_custom_debuff:GetEffectName()
    return "particles/units/heroes/hero_muerta/muerta_calling_debuff_slow.vpcf"
end

function modifier_muerta_dead_shot_custom_debuff:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

modifier_muerta_dead_shot_custom_fear = class({})

function modifier_muerta_dead_shot_custom_fear:OnCreated(data)
	if not IsServer() then return end

	local vector = Vector(data.x, data.y, 0)

	local pos = (self:GetParent():GetAbsOrigin() - vector)
	pos.z = 0
	pos = pos:Normalized()

	self.position = self:GetParent():GetAbsOrigin() + pos * 500

	if not self:GetParent():IsHero() then
		self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_disarmed", {duration = 0.1})
		self:GetParent():SetAggroTarget(nil)
	end
    if self:GetParent():IsDebuffImmune() then return end
	self:GetParent():MoveToPosition( self.position )
end

function modifier_muerta_dead_shot_custom_fear:OnIntervalThink()
	if not IsServer() then return end
    if self:GetParent():IsDebuffImmune() then return end
	self:GetParent():MoveToPosition( self.position )
end

function modifier_muerta_dead_shot_custom_fear:GetEffectName()
    return "particles/units/heroes/hero_muerta/muerta_spell_fear_debuff.vpcf"
end

function modifier_muerta_dead_shot_custom_fear:StatusEffectPriority()
    return 10
end

function modifier_muerta_dead_shot_custom_fear:GetStatusEffectName()
    return "particles/units/heroes/hero_muerta/muerta_spell_fear_debuff_status.vpcf"
end

function modifier_muerta_dead_shot_custom_fear:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_muerta_dead_shot_custom_fear:CheckState()
    local state = 
    {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_FEARED] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_SILENCED] = true,
    }
    return state
end

function modifier_muerta_dead_shot_custom_fear:OnDestroy()
    if not IsServer() then return end
    if self:GetParent():IsDebuffImmune() then return end
    self:GetParent():Stop()
end