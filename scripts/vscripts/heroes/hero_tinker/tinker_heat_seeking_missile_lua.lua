--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


tinker_heat_seeking_missile_lua = class({})

function tinker_heat_seeking_missile_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	if not caster or caster:IsNull() then return end

	-- load data
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("damage")	
	local targets = self:GetSpecialValueFor("targets")

	-- talents
	targets = targets + caster:GetTalentValue("special_bonus_unique_tinker_6")	-- one extra rocket
	
	-- find enemies
	local enemies = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false)
	
	-- precache projectile data
	local projectile_name = "particles/units/heroes/hero_tinker/tinker_missile.vpcf"
	local projectile_speed = self:GetSpecialValueFor("speed")
	local projectile = {
		Source = caster,
		-- Target = target,
		Ability = self,
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = true,
		ExtraData = {
			damage = damage,
		}
	}
	
	-- create projectile for each enemy
	for i=1,math.min(targets,#enemies) do
		if enemies[i] and not enemies[i]:IsNull() then
			projectile.Target = enemies[i]
			ProjectileManager:CreateTrackingProjectile( projectile )
		end
	end

	-- effects
	if #enemies<1 then
		local attach = "attach_attack1"
		if caster:ScriptLookupAttachment( "attach_attack3" )~=0 then attach = "attach_attack3" end
		local point = caster:GetAttachmentOrigin( self:GetCaster():ScriptLookupAttachment( attach ) )
		local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_tinker/tinker_missile_dud.vpcf", PATTACH_WORLDORIGIN, caster )
		ParticleManager:SetParticleControl( effect_cast, 0, point )
		ParticleManager:SetParticleControlForward( effect_cast, 0, caster:GetForwardVector() )
		ParticleManager:ReleaseParticleIndex( effect_cast )
		EmitSoundOn( "Hero_Tinker.Heat-Seeking_Missile_Dud", caster )
	else
		EmitSoundOn( "Hero_Tinker.Heat-Seeking_Missile", caster )
	end
end

function tinker_heat_seeking_missile_lua:OnProjectileHit_ExtraData( target, location, extraData )

	local caster = self:GetCaster()
	if not caster or caster:IsNull() then return end
	if not target or target:IsNull() then return end

	-- Apply damage
	local damage = {
		victim = target,
		attacker = self:GetCaster(),
		damage = extraData.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self
	}
	ApplyDamage( damage )

	-- talent
	if caster:HasTalent("special_bonus_unique_tinker_3") then							-- 0.25s mini stun
		local stun_duration = caster:FindTalentValue("special_bonus_unique_tinker_3")
		target:AddNewModifier(caster, self, "modifier_bashed", {duration = stun_duration})
	end

	-- effects
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_tinker/tinker_missle_explosion.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	EmitSoundOn( "Hero_Tinker.Heat-Seeking_Missile.Impact", target )
end