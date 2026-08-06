--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


final_boss_zap = class({})

local function play_cast_gesture(caster, activity)
	if not IsValid(caster) or not activity then
		return
	end

	local previous_gesture = caster._levelup_boss_cast_gesture
	if previous_gesture then
		caster:FadeGesture(previous_gesture)
	end

	caster:StartGesture(activity)
	caster._levelup_boss_cast_gesture = activity
end

local function stop_cast_gesture(caster, activity)
	if not IsValid(caster) then
		return
	end
	if caster._levelup_boss_cast_gesture ~= activity then
		return
	end

	caster:FadeGesture(activity)
	caster._levelup_boss_cast_gesture = nil
end

function final_boss_zap:Spawn()
	if not IsServer() then
		return
	end
	if self:IsTrained() then
		return
	end
	self:SetLevel(1)
end

function final_boss_zap:GetCooldown(level)
	local definition = boss_ability_system and boss_ability_system:GetAbilityDefinitionByName(self:GetAbilityName())
		or nil
	return tonumber(definition and definition.cooldown) or 0
end

function final_boss_zap:FindBestCastTarget()
	local caster = self:GetCaster()
	local definition = boss_ability_system and boss_ability_system:GetAbilityDefinitionByName(self:GetAbilityName())
		or nil
	if not IsValid(caster) or not definition then
		return nil
	end

	local proc_params = definition.proc_params or {}
	local search_radius = tonumber(proc_params.search_radius) or 1200
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		search_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		0,
		0,
		false
	)

	for _, enemy in ipairs(enemies or {}) do
		if enemy:IsRealHero() then
			return true
		end
	end

	return nil
end

function final_boss_zap:CastFromBossAI(cast_data)
	local caster = self:GetCaster()
	local definition = boss_ability_system and boss_ability_system:GetAbilityDefinitionByName(self:GetAbilityName())
		or nil
	if not IsValid(caster, self) or not definition then
		return false
	end
	if not caster:IsAlive() then
		return false
	end

	local proc_params = definition.proc_params or {}
	local search_radius = tonumber(proc_params.search_radius) or 1200
	local cast_duration = tonumber(proc_params.cast_duration) or 1.5
	local sample_interval = tonumber(proc_params.sample_interval) or 0.5
	local strike_delay = tonumber(proc_params.strike_delay) or 1.0
	local strike_radius = tonumber(proc_params.strike_radius) or 200
	local damage_pct = tonumber(proc_params.damage_pct) or 25
	local sample_count = math.floor(cast_duration / sample_interval)
	local token = DoUniqueString("final_boss_zap")

	caster._levelup_final_boss_zap_token = token
	if boss_ability_system and boss_ability_system.BeginCastLock then
		boss_ability_system:BeginCastLock(caster, self, cast_duration)
	end
	play_cast_gesture(caster, ACT_DOTA_CAST_ABILITY_5)

	self:StartCooldown(self:GetCooldown(math.max(0, self:GetLevel() - 1)))

	for sample_index = 1, sample_count do
		local sample_delay = sample_index * sample_interval
		Timers:CreateTimer(sample_delay, function()
			if not IsValid(caster, self) or not caster:IsAlive() then
				return nil
			end
			if caster._levelup_final_boss_zap_token ~= token then
				return nil
			end

			local enemies = FindUnitsInRadius(
				caster:GetTeamNumber(),
				caster:GetAbsOrigin(),
				nil,
				search_radius,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)

			local strike_points = {}
			local warning_particles = {}
			for _, enemy in ipairs(enemies or {}) do
				if enemy:IsRealHero() then
					local point = GetGroundPosition(enemy:GetAbsOrigin(), nil)
					strike_points[#strike_points + 1] = point

					local warning_particle = ParticleManager:CreateParticle(
						"particles/boss/boss_ability_zap_warning.vpcf",
						PATTACH_WORLDORIGIN,
						nil
					)
					ParticleManager:SetParticleControl(warning_particle, 0, point)
					warning_particles[#warning_particles + 1] = warning_particle
				end
			end

			if #strike_points <= 0 then
				return nil
			end

			Timers:CreateTimer(strike_delay, function()
				for _, warning_particle in ipairs(warning_particles) do
					ParticleManager:DestroyParticle(warning_particle, false)
					ParticleManager:ReleaseParticleIndex(warning_particle)
				end

				if not IsValid(caster, self) or not caster:IsAlive() then
					return nil
				end

				EmitSoundOn("FinalBoss.Zap", caster)

				for _, point in ipairs(strike_points) do
					local strike_particle =
						ParticleManager:CreateParticle("particles/boss/boss_ability_zap.vpcf", PATTACH_WORLDORIGIN, nil)
					ParticleManager:SetParticleControl(strike_particle, 0, point)
					ParticleManager:SetParticleControl(
						strike_particle,
						1,
						Vector(strike_radius + 50, strike_radius + 50, strike_radius + 50)
					)
					ParticleManager:ReleaseParticleIndex(strike_particle)

					local victims = FindUnitsInRadius(
						caster:GetTeamNumber(),
						point,
						nil,
						strike_radius,
						DOTA_UNIT_TARGET_TEAM_ENEMY,
						DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
						0,
						0,
						false
					)

					for _, victim in ipairs(victims or {}) do
						if victim:GetUnitName() ~= "npc_levelup_main_building" then
							local damage = tonumber(victim._levelup_max_health or 0) * damage_pct * 0.01
							if boss_ability_system then
								boss_ability_system:ApplyPureBossDamage(caster, self, victim, damage, "final_boss_zap")
							end
						end
					end
				end

				return nil
			end)

			return nil
		end)
	end

	Timers:CreateTimer(cast_duration + 0.03, function()
		if IsValid(caster) and caster._levelup_final_boss_zap_token == token then
			caster._levelup_final_boss_zap_token = nil
		end
		stop_cast_gesture(caster, ACT_DOTA_CAST_ABILITY_5)
		return nil
	end)

	return true
end