--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]


abyss_double_blast = class({})

local function get_direction(caster, target)
	local direction = target:GetAbsOrigin() - caster:GetAbsOrigin()
	direction.z = 0
	if direction:Length2D() <= 0.01 then
		direction = caster:GetForwardVector()
		direction.z = 0
	end
	return direction:Normalized()
end

function abyss_double_blast:Spawn()
	if not IsServer() then
		return
	end
	if self:IsTrained() then
		return
	end
	self:SetLevel(1)
end

function abyss_double_blast:GetCooldown(level)
	local definition = boss_ability_system and boss_ability_system:GetAbilityDefinitionByName(self:GetAbilityName())
		or nil
	return tonumber(definition and definition.cooldown) or 0
end

function abyss_double_blast:GetInitialBossCooldown()
	return self:GetCooldown(math.max(0, self:GetLevel() - 1)) * 0.5
end

function abyss_double_blast:FindBestCastTarget()
	local caster = self:GetCaster()
	local definition = boss_ability_system and boss_ability_system:GetAbilityDefinitionByName(self:GetAbilityName())
		or nil
	if not IsValid(caster) or not definition then
		return nil
	end

	local search_radius = tonumber(definition.proc_params and definition.proc_params.search_radius) or 1200
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		search_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)

	for _, enemy in ipairs(enemies or {}) do
		if IsValid(enemy) and enemy:IsAlive() and enemy:IsRealHero() then
			return enemy
		end
	end

	return nil
end

function abyss_double_blast:CastFromBossAI(target)
	local caster = self:GetCaster()
	local definition = boss_ability_system and boss_ability_system:GetAbilityDefinitionByName(self:GetAbilityName())
		or nil
	if not IsValid(caster, self, target) or not definition then
		return false
	end
	if not caster:IsAlive() or not target:IsAlive() then
		return false
	end

	local proc_params = definition.proc_params or {}
	local cast_duration = tonumber(proc_params.cast_duration) or 1.5
	local line_length = tonumber(proc_params.line_length) or 3000
	local line_width = tonumber(proc_params.line_width) or 225
	local damage_pct = tonumber(proc_params.damage_pct) or 50
	local update_interval = 0.03
	local origin = caster:GetAbsOrigin()
	local direction = get_direction(caster, target)
	local warning_token = DoUniqueString("abyss_double_blast_warning")
	local started_at = GameRules:GetGameTime()
	local warning_fx =
		ParticleManager:CreateParticle("particles/boss/boss_linear_range_finder.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(warning_fx, 2, Vector(line_width, 0, 0))
	local warning_destroyed = false

	local function destroy_warning()
		if warning_destroyed then
			return
		end
		warning_destroyed = true
		ParticleManager:DestroyParticle(warning_fx, false)
		ParticleManager:ReleaseParticleIndex(warning_fx)
	end

	caster._levelup_abyss_double_blast_warning_token = warning_token
	if boss_ability_system and boss_ability_system.BeginCastLock then
		boss_ability_system:BeginCastLock(caster, self, cast_duration, direction)
	end

	self:StartCooldown(self:GetCooldown(math.max(0, self:GetLevel() - 1)))

	Timers:CreateTimer(0, function()
		if not IsValid(caster, self) or not caster:IsAlive() then
			destroy_warning()
			return nil
		end
		if caster._levelup_abyss_double_blast_warning_token ~= warning_token then
			destroy_warning()
			return nil
		end

		local elapsed = math.max(0, GameRules:GetGameTime() - started_at)
		local k = math.min(1, elapsed / math.max(0.01, cast_duration))
		local current_target = origin + direction * line_length * k
		ParticleManager:SetParticleControl(warning_fx, 0, origin)
		ParticleManager:SetParticleControl(warning_fx, 1, current_target)

		if elapsed >= cast_duration then
			return nil
		end

		return update_interval
	end)

	Timers:CreateTimer(cast_duration, function()
		destroy_warning()

		if not IsValid(caster, self) or not caster:IsAlive() then
			return
		end
		if caster._levelup_abyss_double_blast_warning_token ~= warning_token then
			return
		end
		caster._levelup_abyss_double_blast_warning_token = nil

		local line_end = origin + direction * line_length

		local p = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_magnataur/magnataur_shockwave_erupt.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(p, 0, origin)
		ParticleManager:SetParticleControl(p, 1, line_end)
		ParticleManager:SetParticleControl(p, 2, Vector(line_width, 0, 0))
		ParticleManager:ReleaseParticleIndex(p)

		EmitSoundOn("Hero_Magnataur.Sockwave.Erupt", caster)

		local victims = FindUnitsInLine(
			caster:GetTeamNumber(),
			origin,
			line_end,
			nil,
			line_width,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE
		)
		for _, victim in ipairs(victims or {}) do
			if victim:GetUnitName() ~= "npc_levelup_main_building" then
				local damage = tonumber(victim._levelup_max_health or 0) * damage_pct * 0.01
				if boss_ability_system then
					boss_ability_system:ApplyPureBossDamage(caster, self, victim, damage, "abyss_double_blast")
				end
				victim:AddNewModifier(caster, ability, "modifier_generic_root_lua", { duration = 1 })
			end
		end
	end)

	return true
end