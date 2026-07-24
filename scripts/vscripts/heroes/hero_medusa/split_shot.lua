--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("util")

function SplitShotLaunch( keys )
	local caster = keys.caster
	local caster_location = caster:GetAbsOrigin()
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1

	-- Targeting variables
	local target_type = ability:GetAbilityTargetType()
	local target_team = ability:GetAbilityTargetTeam()
	local target_flags = ability:GetAbilityTargetFlags()
	local attack_target = caster:GetAttackTarget()

	-- Ability variables
	local radius = ability:GetLevelSpecialValueFor("range", ability_level)
	local max_targets = ability:GetLevelSpecialValueFor("arrow_count", ability_level)
	local projectile_speed = ability:GetLevelSpecialValueFor("projectile_speed", ability_level)
	local split_shot_projectile = keys.split_shot_projectile

	local split_shot_targets = FindUnitsInRadius(caster:GetTeam(), caster_location, nil, radius, target_team, target_type, target_flags, FIND_CLOSEST, false)

    if not caster:IsRealHero() then
       print("caster:GetAverageTrueAttackDamage()"..caster:GetAverageTrueAttackDamage(caster))
    end
	-- Create projectiles for units that are not the casters current attack target
	for _,v in pairs(split_shot_targets) do
		if v ~= attack_target then
			local projectile_info = 
			{
				EffectName = split_shot_projectile,
				Ability = ability,
				vSpawnOrigin = caster_location,
				Target = v,
				Source = caster,
				bHasFrontalCone = false,
				iMoveSpeed = projectile_speed,
				bReplaceExisting = false,
				bProvidesVision = false
			}
			local time= (caster_location-v:GetAbsOrigin()):Length() /projectile_speed
			ProjectileManager:CreateTrackingProjectile(projectile_info)
			max_targets = max_targets - 1
		    if not caster:IsRealHero() then
		         Timers:CreateTimer(time, function()
		            local damage_table = {}
					damage_table.attacker = caster
					damage_table.victim = v
					damage_table.damage_type = ability:GetAbilityDamageType()			
					damage_table.damage = caster:GetAttackDamage()*0.8*0.6 --幻象0.7倍修正
					ApplyDamage(damage_table)
		         end)
            else
            	 Timers:CreateTimer(time, function()
		            local damage_table = {}
					damage_table.attacker = caster
					damage_table.victim = v
					damage_table.damage_type = ability:GetAbilityDamageType()			
					damage_table.damage = caster:GetAverageTrueAttackDamage(nil)*0.8 --本体伤害
					ApplyDamage(damage_table)
		         end)
            end
		end
		-- If we reached the maximum amount of targets then break the loop
		if max_targets == 0 then break end
	end
end