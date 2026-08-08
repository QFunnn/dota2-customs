--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5a808f3 · 2026-08-08 04:09:05 UTC
  ~ auto-generated — do not edit
]]


abyss_self_nova = class({})

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

local function create_warning(origin, radius, time)
	local warning_fx =
		ParticleManager:CreateParticle("particles/aoe_ability_boss/aoe_ability_boss.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(warning_fx, 0, origin)
	ParticleManager:SetParticleControl(warning_fx, 2, Vector(radius, time, radius / time))
	return warning_fx
end

local function create_explosion(origin, radius)
	local explosion_fx =
		ParticleManager:CreateParticle("particles/aoe_ability_boss/explosion_aoe.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(explosion_fx, 0, origin)
	ParticleManager:SetParticleControl(explosion_fx, 1, Vector(radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(explosion_fx)
end

local function get_blast_radius(caster, proc_params)
	if IsValid(caster) and caster:GetUnitName() == "npc_levelup_wave_boss" then
		return tonumber(proc_params.final_boss_blast_radius) or tonumber(proc_params.blast_radius) or 900
	end

	return tonumber(proc_params.blast_radius) or 900
end

function abyss_self_nova:Spawn()
	if not IsServer() then
		return
	end
	if self:IsTrained() then
		return
	end
	self:SetLevel(1)
end

function abyss_self_nova:GetCooldown(level)
	local definition = boss_ability_system and boss_ability_system:GetAbilityDefinitionByName(self:GetAbilityName())
		or nil
	return tonumber(definition and definition.cooldown) or 0
end

function abyss_self_nova:GetInitialBossCooldown()
	return self:GetCooldown(math.max(0, self:GetLevel() - 1)) * 0.5
end

function abyss_self_nova:FindBestCastTarget()
	local caster = self:GetCaster()
	local definition = boss_ability_system and boss_ability_system:GetAbilityDefinitionByName(self:GetAbilityName())
		or nil
	if not IsValid(caster) or not definition then
		return nil
	end

	local search_radius = tonumber(definition.proc_params and definition.proc_params.search_radius) or 1000
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		search_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)

	for _, enemy in ipairs(enemies or {}) do
		if enemy:IsRealHero() then
			return enemy
		end
	end

	return nil
end

function abyss_self_nova:CastFromBossAI(target)
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
	local cast_duration = tonumber(proc_params.cast_duration) or 1.5
	local blast_radius = get_blast_radius(caster, proc_params)
	local damage_pct = tonumber(proc_params.damage_pct) or 50
	local origin = caster:GetAbsOrigin()
	local warning_fx = create_warning(origin, blast_radius, cast_duration)

	EmitSoundOn("Hero_DarkWillow.Fear.Cast", caster)

	if IsValid(target) then
		local direction = target:GetAbsOrigin() - origin
		direction.z = 0
		if direction:Length2D() > 0.01 then
			direction = direction:Normalized()
		else
			direction = nil
		end
		if boss_ability_system and boss_ability_system.BeginCastLock then
			boss_ability_system:BeginCastLock(caster, self, cast_duration, direction)
		end
	elseif boss_ability_system and boss_ability_system.BeginCastLock then
		boss_ability_system:BeginCastLock(caster, self, cast_duration)
	end
	play_cast_gesture(caster, ACT_DOTA_AREA_DENY)

	self:StartCooldown(self:GetCooldown(math.max(0, self:GetLevel() - 1)))

	Timers:CreateTimer(cast_duration, function()
		ParticleManager:DestroyParticle(warning_fx, false)
		ParticleManager:ReleaseParticleIndex(warning_fx)
		stop_cast_gesture(caster, ACT_DOTA_AREA_DENY)

		if not IsValid(caster, self) or not caster:IsAlive() then
			return
		end

		create_explosion(origin, blast_radius)
		EmitSoundOn("Hero_DarkWillow.Fear.FP", caster)

		local victims = FindUnitsInRadius(
			caster:GetTeamNumber(),
			origin,
			nil,
			blast_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			0,
			0,
			false
		)

		for _, victim in ipairs(victims or {}) do
			if victim:GetUnitName() ~= "npc_levelup_main_building" then
				local damage = tonumber(victim._levelup_max_health or 0) * damage_pct * 0.01
				if boss_ability_system and boss_ability_system.ApplyPureBossDamage then
					boss_ability_system:ApplyPureBossDamage(caster, self, victim, damage, "abyss_self_nova")
				end
			end
		end
	end)

	return true
end