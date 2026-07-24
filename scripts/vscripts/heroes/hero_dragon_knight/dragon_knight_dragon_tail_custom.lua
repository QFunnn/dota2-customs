--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


dragon_knight_dragon_tail_custom = class({})

function dragon_knight_dragon_tail_custom:GetCastRange( vLocation, hTarget )
	if self:GetCaster():HasModifier( "modifier_dragon_knight_elder_dragon_form_custom" ) then
		return 400
	else
		return self.BaseClass.GetCastRange( self, vLocation, hTarget )
	end
end

function dragon_knight_dragon_tail_custom:GetAOERadius()
	-- if self:GetCaster():HasTalent("special_bonus_unique_dragon_knight_8") then
	-- 	return 400
	-- end
	return 0
end

function dragon_knight_dragon_tail_custom:GetBehavior()
	-- local modifier = self:GetCaster():HasModifier("modifier_dragon_knight_elder_dragon_form_custom")
    -- if self:GetCaster():HasTalent("special_bonus_unique_dragon_knight_8") and modifier then
    --     return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
    -- else
        return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
    -- end
end

function dragon_knight_dragon_tail_custom:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- check dragon modifier
	local modifier = caster:FindModifierByNameAndCaster( "modifier_dragon_knight_elder_dragon_form_custom", caster )

	-- check if simple form
	if not modifier then
		-- cancel if linken
		if target:TriggerSpellAbsorb( self ) then return end

		-- directly hit
		self:Hit( target, false )

		-- play effects
		caster:EmitSound("Hero_DragonKnight.DragonTail.Cast")
		return
	end

	-- dragon form

	-- get data
	local projectile_name = "particles/units/heroes/hero_dragon_knight/dragon_knight_dragon_tail_dragonform_proj.vpcf"
	local projectile_speed = self:GetSpecialValueFor( "projectile_speed" )

	-- create projectile
	local info = {
		Target = target,
		Source = caster,
		Ability = self,
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2,
		
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = true,                           -- Optional
		}

	if self:GetCaster():HasTalent("special_bonus_unique_dragon_knight_8") then
		if modifier then
			local targets = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCursorPosition(), nil, 400, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	    	for _,enemy in pairs(targets) do
	    		info.Target = enemy
	    		ProjectileManager:CreateTrackingProjectile(info)
	    	end
	    else
	    	ProjectileManager:CreateTrackingProjectile(info)
	    end
	else
		ProjectileManager:CreateTrackingProjectile(info)
	end
end

-- Helper
function dragon_knight_dragon_tail_custom:Hit( target, dragonform )
	local caster = self:GetCaster()

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- load data
	local damage = self:GetAbilityDamage()
	local duration = self:GetSpecialValueFor( "stun_duration" ) + self:GetCaster():FindTalentValue("special_bonus_unique_dragon_knight_2")

	-- damage
	local damageTable = {
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	-- stun
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_stunned", -- modifier name
		{ duration = duration } -- kv
	)

	-- Play effects
	self:PlayEffects( target, dragonform )
	target:EmitSound("Hero_DragonKnight.DragonTail.Target")
end

--------------------------------------------------------------------------------
-- Projectile
function dragon_knight_dragon_tail_custom:OnProjectileHit( target, location )
	if not target then return end

	self:Hit( target, true )
end

--------------------------------------------------------------------------------
function dragon_knight_dragon_tail_custom:PlayEffects( target, dragonform )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dragon_knight/dragon_knight_dragon_tail.vpcf"

	-- Get Data
	local vec = target:GetOrigin()-self:GetCaster():GetOrigin()
	local attach = "attach_attack1"
	if dragonform then
		attach = "attach_attack2"
	end

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 3, vec )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		attach,
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		4,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end