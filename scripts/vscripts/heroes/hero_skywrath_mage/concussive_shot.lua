--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function concussive_shot_seek_target( keys )
	-- Variables
	local caster = keys.caster
	local ability = keys.ability
	local particle_name = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot.vpcf"
	local radius = ability:GetLevelSpecialValueFor( "launch_radius", ability:GetLevel() - 1 )
	local speed = ability:GetLevelSpecialValueFor( "speed", ability:GetLevel() - 1 )
	local targetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY
	local targetType = DOTA_UNIT_TARGET_ALL  
	local targetFlag = DOTA_UNIT_TARGET_FLAG_NO_INVIS
	
	-- pick up x nearest target heroes and create tracking projectile targeting the number of targets
	local units = FindUnitsInRadius(
		caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, radius, targetTeam,
		targetType, targetFlag, FIND_CLOSEST, false
	)
	
	-- Seek out target
	for k, v in pairs( units ) do
		local projTable = {
			EffectName = particle_name,
			Ability = ability,
			Target = v,
			Source = caster,
			bDodgeable = true,
			bProvidesVision = true,
			vSpawnOrigin = caster:GetAbsOrigin(),
			iMoveSpeed = speed,
			iVisionRadius = radius,
			iVisionTeamNumber = caster:GetTeamNumber(),
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
		}
		ProjectileManager:CreateTrackingProjectile( projTable )
		break
	end
end

--[[
	Author: kritth
	Date: 8.1.2015.
	Give post attack vision
]]
function concussive_shot_post_vision( keys )
	local target = keys.target:GetAbsOrigin()
	local ability = keys.ability
	local radius = ability:GetLevelSpecialValueFor( "launch_radius", ability:GetLevel() - 1 )
	local duration = ability:GetLevelSpecialValueFor( "vision_duration", ability:GetLevel() - 1 )

	-- Create node
	ability:CreateVisibilityNode( target, radius, duration )
end