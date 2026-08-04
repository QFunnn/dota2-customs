--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_aghanim_boss_bubble", "abilities/aghanim_boss_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_aghanim_boss_puddle", "abilities/aghanim_boss_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_aghanim_boss_fear", "abilities/aghanim_boss_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_aghanim_boss_mad_reflect", "abilities/aghanim_boss_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_aghanim_boss_mech_shield", "abilities/aghanim_boss_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_aghanim_boss_smith_overdrive", "abilities/aghanim_boss_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_aghanim_boss_shard_crystal", "abilities/aghanim_boss_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_aghanim_boss_beam_endpoint", "abilities/aghanim_boss_abilities", LUA_MODIFIER_MOTION_NONE)

aghanim_boss_shard = class({})
aghanim_boss_ray = class({})
aghanim_boss_blink_stomp = class({})
aghanim_boss_bath_bubble = class({})
aghanim_boss_puddle = class({})
aghanim_boss_waves_storm = class({})
aghanim_boss_water_ray = class({})
aghanim_boss_mad_wrench = class({})
aghanim_boss_chain = class({})
aghanim_boss_mad_chains = class({})
aghanim_boss_mad_siled = class({})
aghanim_boss_mech_sword = class({})
aghanim_boss_mech_force = class({})
aghanim_boss_mech_shield = class({})
aghanim_boss_mech_attack = class({})
aghanim_boss_smith_mech = class({})
aghanim_boss_smith_jetpack = class({})
aghanim_boss_smith_crange = class({})
aghanim_boss_smith_bomb = class({})

local function get_definition(ability)
	if not boss_ability_system or not IsValid(ability) then
		return nil
	end
	return boss_ability_system:GetAbilityDefinitionByName(ability:GetAbilityName())
end

local function get_params(ability)
	local definition = get_definition(ability)
	return (definition and definition.proc_params) or {}
end

local function get_cooldown(ability)
	local definition = get_definition(ability)
	return tonumber(definition and definition.cooldown) or 0
end

local function setup_boss_ability(ability_class)
	ability_class.Spawn = function(self)
		if not IsServer() then
			return
		end
		if self:IsTrained() then
			return
		end
		self:SetLevel(1)
	end

	ability_class.GetCooldown = function(self, level)
		return get_cooldown(self)
	end
end

local function max_health(unit)
	if not IsValid(unit) then
		return 0
	end
	return tonumber(unit._levelup_max_health) or 0
end

local function pct_damage(victim, pct, flat)
	return max_health(victim) * (tonumber(pct) or 0) * 0.01 + (tonumber(flat) or 0)
end

local function can_hit(victim)
	return IsValid(victim)
		and victim:IsAlive()
		and victim:GetUnitName() ~= "npc_levelup_main_building"
		and not victim:IsOutOfGame()
end

local function resolve_activity(activity_name)
	if type(activity_name) == "number" then
		return activity_name
	end
	if type(activity_name) ~= "string" or activity_name == "" then
		return nil
	end
	return _G[activity_name]
end

local function get_cast_animation(ability)
	local params = get_params(ability)
	return resolve_activity(params.cast_animation), tonumber(params.cast_animation_rate)
end

local function play_cast_gesture(caster, activity_name, animation_rate)
	if not IsValid(caster) then
		return
	end
	local activity = resolve_activity(activity_name)
	if not activity then
		return
	end

	local previous_gesture = caster._levelup_boss_cast_gesture
	if previous_gesture then
		caster:FadeGesture(previous_gesture)
	end

	caster:StartGestureWithPlaybackRate(activity, tonumber(animation_rate) or 1)
	caster._levelup_boss_cast_gesture = activity
end

local function stop_cast_gesture(caster)
	if not IsValid(caster) then
		return
	end
	local gesture = caster._levelup_boss_cast_gesture
	if not gesture then
		return
	end
	caster:FadeGesture(gesture)
	caster._levelup_boss_cast_gesture = nil
end

local function apply_damage(caster, ability, victim, damage, source_name, options)
	if not IsValid(caster, ability) or not can_hit(victim) then
		return false
	end
	if boss_ability_system and boss_ability_system.ApplyPureBossDamage then
		return boss_ability_system:ApplyPureBossDamage(
			caster,
			ability,
			victim,
			math.max(0, tonumber(damage) or 0),
			source_name,
			options
		)
	end

	return false
end

local function has_reflection_damage_flag(event)
	local flags = tonumber(event and event.damage_flags) or 0
	local reflection_flag = tonumber(DOTA_DAMAGE_FLAG_REFLECTION) or 0
	if flags <= 0 or reflection_flag <= 0 then
		return false
	end

	if bit and bit.band then
		return bit.band(flags, reflection_flag) ~= 0
	end

	return math.floor(flags / reflection_flag) % 2 >= 1
end

local function heal_unit(unit, amount)
	if not IsValid(unit) or not unit:IsAlive() then
		return
	end
	amount = math.max(0, tonumber(amount) or 0)
	if amount <= 0 then
		return
	end

	if unit.LevelUpModifyHealth and unit._levelup_max_health then
		unit:LevelUpModifyHealth(amount)
	end
end

local function direction_to(caster, target_or_point)
	local target_point = target_or_point
	if target_or_point and target_or_point.GetAbsOrigin then
		target_point = target_or_point:GetAbsOrigin()
	end

	local direction = target_point - caster:GetAbsOrigin()
	direction.z = 0
	if direction:Length2D() <= 0.01 then
		direction = caster:GetForwardVector()
		direction.z = 0
	end
	return direction:Normalized()
end

local function attachment_origin(unit, attachment_name)
	if IsValid(unit) and unit.ScriptLookupAttachment and unit.GetAttachmentOrigin then
		local attachment = unit:ScriptLookupAttachment(attachment_name)
		if attachment and attachment > 0 then
			return unit:GetAttachmentOrigin(attachment)
		end
	end

	return IsValid(unit) and unit:GetAbsOrigin() or Vector(0, 0, 0)
end

local function set_particle_forward(fx, control_point, direction)
	if not fx then
		return
	end
	direction = direction or Vector(1, 0, 0)
	direction.z = 0
	if direction:Length2D() <= 0.01 then
		direction = Vector(1, 0, 0)
	end

	local forward = direction:Normalized()
	ParticleManager:SetParticleControlForward(fx, control_point, forward)
end

local function find_best_enemy(caster, radius, target_type)
	if not IsValid(caster) then
		return nil
	end

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		tonumber(radius) or 1200,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		target_type or (DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC),
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)

	for _, enemy in ipairs(enemies or {}) do
		if can_hit(enemy) and enemy:IsRealHero() then
			return enemy
		end
	end

	for _, enemy in ipairs(enemies or {}) do
		if can_hit(enemy) then
			return enemy
		end
	end

	return nil
end

local function begin_cast(caster, ability, duration, direction)
	if boss_ability_system and boss_ability_system.BeginCastLock then
		boss_ability_system:BeginCastLock(caster, ability, tonumber(duration) or 0, direction)
	end
	local animation, animation_rate = get_cast_animation(ability)
	play_cast_gesture(caster, animation, animation_rate)
	ability:StartCooldown(ability:GetCooldown(math.max(0, ability:GetLevel() - 1)))
end

local function set_cast_lock_animation(caster, activity_name, animation_rate)
	play_cast_gesture(caster, activity_name, animation_rate)
end

local function destroy_fx(fx)
	if not fx then
		return
	end
	ParticleManager:DestroyParticle(fx, false)
	ParticleManager:ReleaseParticleIndex(fx)
end

local function attach_temporary_fx(target, particle_name, duration, attach_type)
	if not IsValid(target) or not particle_name then
		return nil
	end

	local fx = ParticleManager:CreateParticle(particle_name, attach_type or PATTACH_ABSORIGIN_FOLLOW, target)
	Timers:CreateTimer(math.max(0.03, tonumber(duration) or 0.03), function()
		destroy_fx(fx)
		return nil
	end)
	return fx
end

local function apply_slow(caster, ability, victim, slow_pct, duration)
	slow_pct = tonumber(slow_pct) or 0
	duration = tonumber(duration) or 0
	if slow_pct <= 0 or duration <= 0 or not can_hit(victim) then
		return
	end
	victim:AddNewModifier(caster, ability, "modifier_generic_slow_lua", { duration = duration, slow_pct = slow_pct })
end

local function apply_non_stacking_slow(caster, ability, victim, slow_pct, duration)
	slow_pct = tonumber(slow_pct) or 0
	duration = tonumber(duration) or 0
	if slow_pct <= 0 or duration <= 0 or not can_hit(victim) then
		return
	end

	for _, modifier in ipairs(victim:FindAllModifiersByName("modifier_generic_slow_lua") or {}) do
		if IsValid(modifier) and modifier:GetCaster() == caster and modifier:GetAbility() == ability then
			modifier:Destroy()
		end
	end

	victim:AddNewModifier(caster, ability, "modifier_generic_slow_lua", { duration = duration, slow_pct = slow_pct })
end

local function apply_root(caster, ability, victim, duration)
	duration = tonumber(duration) or 0
	if duration <= 0 or not can_hit(victim) then
		return
	end
	victim:AddNewModifier(caster, ability, "modifier_generic_root_lua", { duration = duration })
end

local function apply_stun(caster, ability, victim, duration)
	duration = tonumber(duration) or 0
	if duration <= 0 or not can_hit(victim) then
		return
	end
	victim:AddNewModifier(caster, ability, "modifier_generic_stunned_lua", { duration = duration })
end

local function apply_knockback(caster, ability, victim, distance, height, duration, toward_point)
	if not can_hit(victim) then
		return
	end
	distance = tonumber(distance) or 0
	if distance <= 0 then
		return
	end

	local direction
	if toward_point then
		direction = toward_point - victim:GetAbsOrigin()
	else
		direction = victim:GetAbsOrigin() - caster:GetAbsOrigin()
	end
	direction.z = 0
	if direction:Length2D() <= 0.01 then
		direction = caster:GetForwardVector()
	end

	victim:AddNewModifier(caster, ability, "modifier_generic_knockback_lua", {
		duration = tonumber(duration) or 0.35,
		distance = distance,
		height = tonumber(height) or 0,
		direction_x = direction.x,
		direction_y = direction.y,
		IsStun = 1,
		IsFlail = 1,
	})
end

local function register_runtime_dot(caster, ability, victim, duration, damage_pct_per_second, source_name)
	if not IsValid(caster, ability) or not can_hit(victim) then
		return
	end
	if not card_system or not card_system.RegisterRuntimeDot then
		return
	end

	local player_id = victim:GetPlayerOwnerID()
	if player_id == nil or player_id < 0 then
		return
	end
	if not card_system.players_info or not card_system.players_info[player_id] then
		return
	end

	duration = tonumber(duration) or 0
	local tick_interval = 1
	local damage_per_second = pct_damage(victim, damage_pct_per_second)
	if duration <= 0 or damage_per_second <= 0 then
		return
	end

	local status_fx = ParticleManager:CreateParticle(
		"particles/status_fx/status_effect_rupture.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		victim
	)
	local blood_fx =
		ParticleManager:CreateParticle("particles/shard/aghanim_blood.vpcf", PATTACH_ABSORIGIN_FOLLOW, victim)
	ParticleManager:SetParticleControlEnt(
		blood_fx,
		0,
		victim,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		victim:GetAbsOrigin(),
		true
	)
	local end_time = GameRules:GetGameTime() + duration
	Timers:CreateTimer(tick_interval, function()
		if GameRules:GetGameTime() >= end_time or not can_hit(victim) then
			destroy_fx(status_fx)
			destroy_fx(blood_fx)
			return nil
		end

		return tick_interval
	end)

	card_system:RegisterRuntimeDot(player_id, {
		source_key = source_name or ability:GetAbilityName(),
		target_entindex = victim:entindex(),
		attacker_entindex = caster:entindex(),
		ability_entindex = ability:entindex(),
		duration = duration,
		damage_per_second = damage_per_second,
		tick_interval = tick_interval,
		initial_delay = tick_interval,
		damage_type = DAMAGE_TYPE_PURE,
		damage_kind = "pure",
		ability_str_name = source_name or ability:GetAbilityName(),
	})
end

local function explode_at(caster, ability, center, radius, damage_pct, source_name, extra)
	if extra and extra.particle then
		local fx = ParticleManager:CreateParticle(extra.particle, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(fx, 0, center)
		ParticleManager:SetParticleControl(fx, 1, Vector(radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(fx)
	end

	local victims = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, victim in ipairs(victims or {}) do
		if can_hit(victim) then
			apply_damage(caster, ability, victim, pct_damage(victim, damage_pct), source_name)
			if extra then
				apply_slow(caster, ability, victim, extra.slow_pct, extra.slow_duration)
				apply_stun(caster, ability, victim, extra.stun_duration)
				apply_root(caster, ability, victim, extra.root_duration)
				apply_knockback(caster, ability, victim, extra.knockback_distance, 0, 0.35)
				if extra.victim_particle then
					local victim_fx =
						ParticleManager:CreateParticle(extra.victim_particle, PATTACH_ABSORIGIN_FOLLOW, victim)
					ParticleManager:ReleaseParticleIndex(victim_fx)
				end
				if extra.silence_duration and extra.silence_duration > 0 then
					victim:AddNewModifier(
						caster,
						ability,
						"modifier_generic_silence_lua",
						{ duration = extra.silence_duration }
					)
				end
			end
		end
	end
end

local function launch_smith_bomb(caster, ability, spawn_point, target_point, options)
	if not IsValid(caster, ability) then
		return
	end

	options = options or {}
	local explosion_delay = tonumber(options.explosion_delay) or 0.6
	local radius = tonumber(options.radius) or 220
	local damage_pct = tonumber(options.damage_pct) or 10
	local source_name = options.source_name or ability:GetAbilityName()
	local flight_direction = target_point - spawn_point
	flight_direction.z = 0
	local distance = flight_direction:Length2D()
	if distance <= 1 then
		flight_direction = caster:GetForwardVector()
		distance = 1
	else
		flight_direction = flight_direction:Normalized()
	end

	local bomb = CreateUnitByName("npc_dota_companion", spawn_point, false, nil, nil, caster:GetTeamNumber())
	if IsValid(bomb) then
		bomb:SetAbsOrigin(spawn_point)
		bomb:SetModel("models/heroes/techies/fx_techies_remotebomb_underhollow.vmdl")
		bomb:SetOriginalModel("models/heroes/techies/fx_techies_remotebomb_underhollow.vmdl")
		bomb:SetModelScale(tonumber(options.model_scale) or 0.75)
		bomb:SetHullRadius(0)
		bomb:AddNewModifier(caster, ability, "modifier_invulnerable", {})
		bomb:AddNewModifier(caster, ability, "modifier_phased", {})
		bomb:AddNewModifier(caster, ability, "modifier_no_healthbar", {})
		bomb:AddNewModifier(caster, ability, "modifier_not_on_minimap", {})
		bomb:AddNewModifier(caster, ability, "modifier_generic_knockback_lua", {
			duration = explosion_delay,
			distance = distance,
			height = tonumber(options.height) or 120,
			direction_x = flight_direction.x,
			direction_y = flight_direction.y,
			IsStun = 0,
			IsFlail = options.is_flail and 1 or 0,
		})
	end

	Timers:CreateTimer(explosion_delay, function()
		local explosion_point = IsValid(bomb) and bomb:GetAbsOrigin() or target_point

		if IsValid(caster, ability) then
			EmitSoundOnLocationWithCaster(explosion_point, "Aghanim.MineBomb", caster)
		end

		if IsValid(caster, ability) and caster:IsAlive() then
			explode_at(caster, ability, explosion_point, radius, damage_pct, source_name, {
				slow_pct = options.slow_pct,
				slow_duration = options.slow_duration,
				silence_duration = options.silence_duration,
				particle = options.particle or "particles/units/heroes/hero_techies/techies_land_mine_explode.vpcf",
			})
		else
			local fx = ParticleManager:CreateParticle(
				options.particle or "particles/units/heroes/hero_techies/techies_land_mine_explode.vpcf",
				PATTACH_WORLDORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(fx, 0, explosion_point)
			ParticleManager:SetParticleControl(fx, 1, Vector(radius, 0, 0))
			ParticleManager:ReleaseParticleIndex(fx)
		end

		if IsValid(bomb) then
			UTIL_Remove(bomb)
		end
		return nil
	end)
end

local function create_beam_linger(
	caster,
	ability,
	point,
	radius,
	duration,
	damage_pct_per_second,
	damage_interval,
	source_name
)
	local fx =
		ParticleManager:CreateParticle("particles/creatures/aghanim/staff_beam_linger.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(fx, 0, point + Vector(0, 0, 500))
	ParticleManager:SetParticleControl(fx, 1, Vector(radius, 1, 1) + Vector(0, 0, 500))
	EmitSoundOnLocationWithCaster(point, "n_black_dragon.Fireball.Target", caster)

	local end_time = GameRules:GetGameTime() + duration
	caster._levelup_aghanim_linger_damage_time = caster._levelup_aghanim_linger_damage_time or {}
	caster._levelup_aghanim_linger_damage_time[source_name] = caster._levelup_aghanim_linger_damage_time[source_name]
		or {}
	Timers:CreateTimer(0, function()
		if not IsValid(caster, ability) or not caster:IsAlive() or GameRules:GetGameTime() >= end_time then
			destroy_fx(fx)
			return nil
		end

		local now = GameRules:GetGameTime()
		local damage_times = caster._levelup_aghanim_linger_damage_time
				and caster._levelup_aghanim_linger_damage_time[source_name]
			or nil
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			point,
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for _, enemy in ipairs(enemies or {}) do
			local enemy_index = enemy:entindex()
			local last_damage_time = damage_times and tonumber(damage_times[enemy_index]) or nil
			if can_hit(enemy) and (not last_damage_time or now - last_damage_time >= damage_interval * 0.9) then
				if damage_times then
					damage_times[enemy_index] = now
				end
				local burn_fx = ParticleManager:CreateParticle(
					"particles/creatures/aghanim/aghanim_beam_burn.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					enemy
				)
				ParticleManager:SetParticleControlEnt(
					burn_fx,
					1,
					enemy,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					enemy:GetAbsOrigin(),
					true
				)
				ParticleManager:ReleaseParticleIndex(burn_fx)
				apply_damage(
					caster,
					ability,
					enemy,
					pct_damage(enemy, damage_pct_per_second * damage_interval),
					source_name
				)
			end
		end

		return damage_interval
	end)
end

local function cast_delayed_line(caster, ability, target, options)
	if not IsValid(caster, ability, target) or not target:IsAlive() then
		return false
	end

	local params = get_params(ability)
	local cast_duration = tonumber(params.cast_duration) or options.default_cast_duration or 0.5
	local line_length = tonumber(params.line_length) or options.default_length or 1200
	local line_width = tonumber(params.line_width) or options.default_width or 120
	local damage_pct = tonumber(params.damage_pct) or options.default_damage_pct or 8
	local direction = direction_to(caster, target)
	local origin = caster:GetAbsOrigin()

	if options.sound_cast then
		EmitSoundOn(options.sound_cast, caster)
	end
	begin_cast(caster, ability, cast_duration, direction)

	Timers:CreateTimer(cast_duration, function()
		if not IsValid(caster, ability) or not caster:IsAlive() then
			return nil
		end

		if options.sound_stop_on_impact then
			StopSoundOn(options.sound_stop_on_impact, caster)
		end

		local fan_count = math.max(1, math.floor(tonumber(params.fan_count) or 1))
		local fan_angle = tonumber(params.fan_angle) or 0
		local angle_step = fan_count > 1 and fan_angle / (fan_count - 1) or 0
		local half_count = (fan_count - 1) * 0.5
		local hit_targets = {}

		for i = 1, fan_count do
			local line_direction = direction
			if fan_count > 1 then
				local angle = (i - 1 - half_count) * angle_step
				line_direction = RotatePosition(Vector(0, 0, 0), QAngle(0, angle, 0), direction)
			end

			local end_point = origin + line_direction * line_length
			if options.sound_impact_location then
				EmitSoundOnLocationWithCaster(end_point, options.sound_impact_location, caster)
			end
			local fx = ParticleManager:CreateParticle(options.particle, PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleControl(fx, 0, origin)
			ParticleManager:SetParticleControl(fx, 1, end_point)
			if options.cp3 then
				ParticleManager:SetParticleControl(fx, 3, options.cp3)
			end
			ParticleManager:ReleaseParticleIndex(fx)

			local victims = FindUnitsInLine(
				caster:GetTeamNumber(),
				origin,
				end_point,
				nil,
				line_width,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_NONE
			)

			for _, victim in ipairs(victims or {}) do
				local entindex = victim:entindex()
				if can_hit(victim) and not hit_targets[entindex] then
					hit_targets[entindex] = true
					apply_damage(caster, ability, victim, pct_damage(victim, damage_pct), options.source_name)
					if options.sound_target then
						EmitSoundOn(options.sound_target, victim)
					end
					apply_slow(caster, ability, victim, params.slow_pct, params.slow_duration)
					apply_root(caster, ability, victim, params.root_duration)
					apply_stun(caster, ability, victim, params.stun_duration)
					if params.armor_debuff_duration then
						attach_temporary_fx(
							victim,
							"particles/shard/armor_debufff_aghanim.vpcf",
							tonumber(params.armor_debuff_duration) or 3,
							PATTACH_OVERHEAD_FOLLOW
						)
					end
					if params.cast_range_debuff_duration then
						attach_temporary_fx(
							victim,
							"particles/shard/aghs_cast_range_debuff.vpcf",
							tonumber(params.cast_range_debuff_duration) or 3,
							PATTACH_ABSORIGIN_FOLLOW
						)
					end
					if params.cart_explode_on_hit then
						local cart_fx = ParticleManager:CreateParticle(
							"particles/units/heroes/hero_techies/techies_remote_cart_explode.vpcf",
							PATTACH_ABSORIGIN_FOLLOW,
							victim
						)
						ParticleManager:ReleaseParticleIndex(cart_fx)
					end
					if params.chainpair_on_hit then
						local chainpair_fx = ParticleManager:CreateParticle(
							"particles/shard/aghanim_wrength_chainpair.vpcf",
							PATTACH_ABSORIGIN_FOLLOW,
							victim
						)
						ParticleManager:ReleaseParticleIndex(chainpair_fx)
					end
					if params.pull_distance then
						apply_knockback(caster, ability, victim, params.pull_distance, 0, 0.35, caster:GetAbsOrigin())
					elseif params.knockback_distance then
						apply_knockback(caster, ability, victim, params.knockback_distance, 0, 0.35)
					end
				end
			end

			local explosion_radius = tonumber(params.explosion_radius or params.splash_radius)
			local splash_damage_pct = tonumber(params.splash_damage_pct)
			if explosion_radius and explosion_radius > 0 and splash_damage_pct and splash_damage_pct > 0 then
				explode_at(caster, ability, end_point, explosion_radius, splash_damage_pct, options.source_name, {
					slow_pct = params.slow_pct,
					slow_duration = params.slow_duration,
				})
			end
		end
	end)

	return true
end

local function cast_tracking_beam(caster, ability, target, options)
	if not IsValid(caster, ability, target) or not target:IsAlive() then
		return false
	end

	local params = get_params(ability)
	local windup_duration = tonumber(params.windup_duration) or 0.9
	local active_duration = tonumber(params.cast_duration) or 3
	local search_radius = tonumber(params.search_radius) or 1600
	local beam_radius = tonumber(params.beam_radius) or 120
	local beam_speed = tonumber(params.beam_speed) or 550
	local damage_interval = tonumber(params.damage_interval) or 0.2
	local damage_pct_per_second = tonumber(params.damage_pct_per_second) or 5
	local linger_time = tonumber(params.linger_time) or 0.8
	local linger_create_interval = tonumber(params.linger_create_interval) or 0.15
	local linger_damage_pct_per_second = tonumber(params.linger_damage_pct_per_second) or damage_pct_per_second
	local heal_pct_per_second = tonumber(params.heal_pct_per_second) or 0
	local token = DoUniqueString(options.source_name)
	local target_positions = {}
	local warning_fxs = {}
	local beams = {}
	local windup_done = false

	caster._levelup_aghanim_beam_token = token
	begin_cast(caster, ability, windup_duration + active_duration, direction_to(caster, target))

	local avatar_fx = ParticleManager:CreateParticle(
		"particles/items_fx/black_king_bar_avatar_aghanim.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	local status_fx = ParticleManager:CreateParticle(
		"particles/shard/status_effect_avatar_aghanim.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	local channel_fx = ParticleManager:CreateParticle(
		"particles/creatures/aghanim/aghanim_beam_channel.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)

	local function cleanup()
		if IsValid(caster) then
			StopSoundOn("Hero_Phoenix.SunRay.Cast", caster)
			StopSoundOn("Hero_Phoenix.SunRay.Loop", caster)
			stop_cast_gesture(caster)
		end
		destroy_fx(avatar_fx)
		destroy_fx(status_fx)
		destroy_fx(channel_fx)
		for _, fx in pairs(warning_fxs) do
			destroy_fx(fx)
		end
		for _, beam in pairs(beams) do
			destroy_fx(beam.fx)
			if IsValid(beam.thinker) then
				UTIL_Remove(beam.thinker)
			end
		end
	end

	Timers:CreateTimer(0, function()
		if windup_done then
			return nil
		end
		if not IsValid(caster, ability) or not caster:IsAlive() or caster._levelup_aghanim_beam_token ~= token then
			cleanup()
			return nil
		end

		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster:GetAbsOrigin(),
			nil,
			search_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO,
			DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS,
			FIND_CLOSEST,
			false
		)
		for _, enemy in ipairs(enemies or {}) do
			if can_hit(enemy) then
				local entindex = enemy:entindex()
				target_positions[entindex] = enemy:GetAbsOrigin()
				if not warning_fxs[entindex] then
					warning_fxs[entindex] = ParticleManager:CreateParticle(
						"particles/creatures/aghanim/aghanim_debug_ring.vpcf",
						PATTACH_CUSTOMORIGIN,
						caster
					)
				end
				ParticleManager:SetParticleControl(warning_fxs[entindex], 0, enemy:GetAbsOrigin())
			end
		end

		return 0.03
	end)

	Timers:CreateTimer(windup_duration, function()
		if not IsValid(caster, ability) or not caster:IsAlive() or caster._levelup_aghanim_beam_token ~= token then
			cleanup()
			return nil
		end

		windup_done = true
		if params.channel_animation then
			set_cast_lock_animation(caster, params.channel_animation, params.channel_animation_rate)
		end
		EmitSoundOn("Hero_Phoenix.SunRay.Cast", caster)
		EmitSoundOn("Hero_Phoenix.SunRay.Loop", caster)
		for _, fx in pairs(warning_fxs) do
			destroy_fx(fx)
		end
		warning_fxs = {}
		caster._levelup_aghanim_linger_damage_time = caster._levelup_aghanim_linger_damage_time or {}
		caster._levelup_aghanim_linger_damage_time[options.source_name] = {}

		local active_end_time = GameRules:GetGameTime() + active_duration
		local damage_elapsed = 0
		local linger_elapsed = 0
		local impact_elapsed = 0

		local function add_beam(enemy)
			local entindex = enemy:entindex()
			if beams[entindex] then
				return
			end

			local start_point = target_positions[entindex] or enemy:GetAbsOrigin()
			local thinker = CreateModifierThinker(
				caster,
				ability,
				"modifier_aghanim_boss_beam_endpoint",
				{ duration = active_duration + 0.5 },
				start_point,
				caster:GetTeamNumber(),
				false
			)
			if not IsValid(thinker) then
				return
			end
			local fx = ParticleManager:CreateParticle(options.particle, PATTACH_CUSTOMORIGIN, caster)
			ParticleManager:SetParticleControlEnt(
				fx,
				0,
				caster,
				PATTACH_POINT_FOLLOW,
				"attach_staff_fx",
				caster:GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(
				fx,
				1,
				thinker,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				thinker:GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(
				fx,
				2,
				caster,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				thinker:GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(
				fx,
				9,
				caster,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				caster:GetAbsOrigin(),
				true
			)

			beams[entindex] = {
				target = enemy,
				thinker = thinker,
				fx = fx,
				point = start_point,
			}
		end

		for _, enemy in
			ipairs(
				FindUnitsInRadius(
					caster:GetTeamNumber(),
					caster:GetAbsOrigin(),
					nil,
					search_radius,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO,
					DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS,
					FIND_CLOSEST,
					false
				) or {}
			)
		do
			if can_hit(enemy) then
				add_beam(enemy)
			end
		end

		Timers:CreateTimer(0, function()
			if
				not IsValid(caster, ability)
				or not caster:IsAlive()
				or caster._levelup_aghanim_beam_token ~= token
				or GameRules:GetGameTime() >= active_end_time
			then
				caster._levelup_aghanim_beam_token = nil
				EmitSoundOn("Hero_Phoenix.SunRay.Stop", caster)
				cleanup()
				return nil
			end

			local frame_time = FrameTime()
			for _, enemy in
				ipairs(
					FindUnitsInRadius(
						caster:GetTeamNumber(),
						caster:GetAbsOrigin(),
						nil,
						search_radius,
						DOTA_UNIT_TARGET_TEAM_ENEMY,
						DOTA_UNIT_TARGET_HERO,
						DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS,
						FIND_CLOSEST,
						false
					) or {}
				)
			do
				if can_hit(enemy) then
					add_beam(enemy)
				end
			end

			for entindex, beam in pairs(beams) do
				if not IsValid(beam.target, beam.thinker) or not beam.target:IsAlive() then
					destroy_fx(beam.fx)
					if IsValid(beam.thinker) then
						UTIL_Remove(beam.thinker)
					end
					beams[entindex] = nil
				else
					local direction = beam.target:GetAbsOrigin() - beam.point
					direction.z = 0
					local distance = direction:Length2D()
					if distance > 0.01 then
						beam.point = beam.point + direction:Normalized() * math.min(distance, beam_speed * frame_time)
					end
					beam.point = GetGroundPosition(beam.point, beam.thinker)
					beam.thinker:SetAbsOrigin(beam.point)
					AddFOWViewer(caster:GetTeamNumber(), beam.point, beam_radius, frame_time, false)
				end
			end

			damage_elapsed = damage_elapsed + frame_time
			linger_elapsed = linger_elapsed + frame_time
			impact_elapsed = impact_elapsed + frame_time

			if damage_elapsed >= damage_interval then
				local damaged_targets = {}
				for _, beam in pairs(beams) do
					local beam_origin = caster:GetAbsOrigin()
					local enemies = FindUnitsInLine(
						caster:GetTeamNumber(),
						beam_origin,
						beam.point,
						nil,
						beam_radius,
						DOTA_UNIT_TARGET_TEAM_ENEMY,
						DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
						DOTA_UNIT_TARGET_FLAG_NONE
					)
					for _, enemy in ipairs(enemies or {}) do
						local enemy_index = enemy:entindex()
						if can_hit(enemy) and not damaged_targets[enemy_index] then
							damaged_targets[enemy_index] = true
							apply_damage(
								caster,
								ability,
								enemy,
								pct_damage(enemy, damage_pct_per_second * damage_elapsed),
								options.source_name
							)
							apply_non_stacking_slow(
								caster,
								ability,
								enemy,
								params.slow_pct,
								math.max(damage_elapsed + 0.1, tonumber(params.slow_duration) or 0)
							)
							if options.impact_particle and impact_elapsed >= 0.4 then
								local impact_fx = ParticleManager:CreateParticle(
									options.impact_particle,
									PATTACH_ABSORIGIN_FOLLOW,
									enemy
								)
								ParticleManager:SetParticleControl(impact_fx, 0, enemy:GetAbsOrigin())
								ParticleManager:SetParticleControl(impact_fx, 3, enemy:GetAbsOrigin())
								ParticleManager:ReleaseParticleIndex(impact_fx)
							end
						end
					end
				end
				if heal_pct_per_second > 0 then
					heal_unit(caster, max_health(caster) * heal_pct_per_second * damage_elapsed * 0.01)
				end
				damage_elapsed = 0
				if impact_elapsed >= 0.4 then
					impact_elapsed = 0
				end
			end

			if linger_elapsed >= linger_create_interval then
				for _, beam in pairs(beams) do
					create_beam_linger(
						caster,
						ability,
						beam.point,
						beam_radius,
						linger_time,
						linger_damage_pct_per_second,
						damage_interval,
						options.source_name
					)
				end
				linger_elapsed = 0
			end

			local first_key = next(beams)
			local first_beam = first_key and beams[first_key] or nil
			if first_beam then
				local forward = first_beam.point - caster:GetAbsOrigin()
				forward.z = 0
				if forward:Length2D() > 0.01 then
					caster:SetForwardVector(forward:Normalized())
				end
			end

			return frame_time
		end)
	end)

	return true
end

function aghanim_boss_shard:FindBestCastTarget()
	return find_best_enemy(self:GetCaster(), get_params(self).search_radius)
end

function aghanim_boss_shard:CastFromBossAI(target)
	local caster = self:GetCaster()
	if not IsValid(caster, self, target) or not target:IsAlive() then
		return false
	end

	local params = get_params(self)
	local cast_duration = tonumber(params.cast_duration) or 0.25
	local distance = tonumber(params.line_length) or 1200
	local radius = tonumber(params.line_width) or 105
	local projectile_speed = tonumber(params.projectile_speed) or 900
	local fan_count = math.max(1, math.floor(tonumber(params.fan_count) or 1))
	local fan_angle = tonumber(params.fan_angle) or 0
	local center_multiplier = tonumber(params.center_damage_multiplier_pct) or 100
	local edge_multiplier = tonumber(params.edge_damage_multiplier_pct) or center_multiplier
	local direction = direction_to(caster, target)

	EmitSoundOn("Hero_Winter_Wyvern.SplinterBlast.Cast", caster)
	begin_cast(caster, self, cast_duration, direction)

	self._shard_cast_id = (tonumber(self._shard_cast_id) or 0) + 1
	local shard_cast_id = self._shard_cast_id
	self._shard_hero_splinter_hits = self._shard_hero_splinter_hits or {}
	self._shard_hero_splinter_hits[shard_cast_id] = {}

	local cleanup_delay = cast_duration + (distance / math.max(projectile_speed, 1)) + 4.0
	Timers:CreateTimer(cleanup_delay, function()
		if self._shard_hero_splinter_hits then
			self._shard_hero_splinter_hits[shard_cast_id] = nil
		end
		return nil
	end)

	Timers:CreateTimer(cast_duration, function()
		if not IsValid(caster, self) or not caster:IsAlive() then
			return nil
		end
		local half_count = (fan_count - 1) * 0.5
		local angle_step = fan_count > 1 and (fan_angle / (fan_count - 1)) or 0
		for i = 1, fan_count do
			local offset_index = i - 1 - half_count
			local angle = offset_index * angle_step
			local fan_direction = RotatePosition(Vector(0, 0, 0), QAngle(0, angle, 0), direction)
			local distance_from_center = half_count > 0 and math.abs(offset_index) / half_count or 0
			local damage_multiplier_pct = center_multiplier
				+ (edge_multiplier - center_multiplier) * distance_from_center
			local projectile = ProjectileManager:CreateLinearProjectile({
				Source = caster,
				Ability = self,
				vSpawnOrigin = caster:GetAbsOrigin(),
				bDeleteOnHit = false,
				iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
				iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
				iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				fDistance = distance,
				fStartRadius = radius,
				fEndRadius = radius,
				vVelocity = fan_direction * projectile_speed,
				iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
				bHasFrontalCone = false,
				bReplaceExisting = false,
				bProvidesVision = false,
				ExtraData = {
					main = 1,
					shard_cast_id = shard_cast_id,
					damage_multiplier_pct = damage_multiplier_pct,
				},
			})
			CreateProjectileFx(caster, projectile, "particles/shard/aghanim_crystal_attack.vpcf", nil, {
				origin = caster:GetAbsOrigin(),
				direction = fan_direction,
				speed = projectile_speed,
			})
		end
	end)

	return true
end

function aghanim_boss_shard:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then
		return true
	end

	local caster = self:GetCaster()
	if not IsValid(caster, self) then
		return true
	end

	local params = get_params(self)
	local main = tonumber(extra_data and extra_data.main) or 0
	local damage_multiplier_pct = tonumber(extra_data and extra_data.damage_multiplier_pct) or 100

	if main == 1 then
		local point = GetGroundPosition(location, nil)
		local impact_fx = ParticleManager:CreateParticle(
			"particles/creatures/aghanim/aghanim_crystal_attack_impact.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(impact_fx, 0, point)
		ParticleManager:ReleaseParticleIndex(impact_fx)
		EmitSoundOnLocationWithCaster(point, "Hero_Winter_Wyvern.SplinterBlast.Splinter", caster)

		local center = target and target:GetAbsOrigin() or point
		local shard_cast_id = tonumber(extra_data and extra_data.shard_cast_id) or 0
		local max_hero_hits = math.max(1, math.floor(tonumber(params.max_hero_splinter_hits_per_cast) or 2))
		self._shard_hero_splinter_hits = self._shard_hero_splinter_hits or {}
		local hero_hits = self._shard_hero_splinter_hits[shard_cast_id]
		if not hero_hits then
			hero_hits = {}
			self._shard_hero_splinter_hits[shard_cast_id] = hero_hits
		end

		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			center,
			nil,
			tonumber(params.splash_radius) or 450,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			0,
			FIND_ANY_ORDER,
			false
		)
		for _, enemy in ipairs(enemies or {}) do
			if can_hit(enemy) then
				local should_create_splinter = true
				if enemy:IsRealHero() then
					local entindex = enemy:entindex()
					local hit_count = tonumber(hero_hits[entindex]) or 0
					if hit_count >= max_hero_hits then
						should_create_splinter = false
					else
						hero_hits[entindex] = hit_count + 1
					end
				end

				if should_create_splinter then
					local projectile = ProjectileManager:CreateTrackingProjectile({
						Target = enemy,
						vSourceLoc = center,
						Ability = self,
						iMoveSpeed = 800,
						bReplaceExisting = false,
						ExtraData = {
							main = 0,
							shard_cast_id = shard_cast_id,
							damage_multiplier_pct = damage_multiplier_pct,
						},
					})
					CreateProjectileFx(
						caster,
						projectile,
						"particles/units/heroes/hero_winter_wyvern/wyvern_splinter_blast.vpcf",
						{
							origin = center,
							target = enemy,
							speed = 800,
						}
					)
				end
			end
		end
		return false
	end

	if main == 0 and can_hit(target) then
		EmitSoundOn("Hero_Winter_Wyvern.SplinterBlast.Target", target)
		local damage_pct = tonumber(params.damage_pct) or 10
		if target:HasModifier("modifier_aghanim_boss_shard_crystal") then
			damage_pct = damage_pct + (tonumber(params.bonus_damage_pct) or 4)
		end
		target:AddNewModifier(
			caster,
			self,
			"modifier_aghanim_boss_shard_crystal",
			{ duration = tonumber(params.crystal_duration) or 8 }
		)
		apply_damage(
			caster,
			self,
			target,
			pct_damage(target, damage_pct * damage_multiplier_pct * 0.01),
			"aghanim_boss_shard"
		)
		return true
	end

	return false
end

function aghanim_boss_ray:FindBestCastTarget()
	return find_best_enemy(self:GetCaster(), get_params(self).search_radius)
end

function aghanim_boss_ray:CastFromBossAI(target)
	return cast_tracking_beam(self:GetCaster(), self, target, {
		source_name = "aghanim_boss_ray",
		particle = "particles/creatures/aghanim/staff_beam.vpcf",
		impact_particle = "particles/shard/aghanim_ray_impact.vpcf",
	})
end

function aghanim_boss_blink_stomp:FindBestCastTarget()
	return find_best_enemy(self:GetCaster(), get_params(self).search_radius)
end

function aghanim_boss_blink_stomp:CastFromBossAI(target)
	local caster = self:GetCaster()
	if not IsValid(caster, self, target) or not target:IsAlive() then
		return false
	end

	local params = get_params(self)
	local cast_duration = tonumber(params.cast_duration) or 0.35
	local stomp_delay = tonumber(params.stomp_delay) or 1.0
	local radius = tonumber(params.stomp_radius) or 420
	local blink_distance = tonumber(params.blink_distance) or 450
	local direction = direction_to(caster, target)
	local distance_to_target = (target:GetAbsOrigin() - caster:GetAbsOrigin()):Length2D()
	local travel_distance = math.max(blink_distance, distance_to_target + radius * 0.35)
	local target_point = GetGroundPosition(caster:GetAbsOrigin() + direction * travel_distance, caster)
	local stomp_warning_fx = nil
	local point_attack_fx = nil

	begin_cast(caster, self, cast_duration + stomp_delay, direction)

	Timers:CreateTimer(cast_duration, function()
		if not IsValid(caster, self) or not caster:IsAlive() then
			return nil
		end

		EmitSoundOn("Hero_FacelessVoid.TimeWalk", caster)
		local out_fx = ParticleManager:CreateParticle(
			"particles/creatures/aghanim/aghanim_preimage.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(out_fx, 0, caster:GetAbsOrigin())
		ParticleManager:SetParticleControl(out_fx, 1, target_point)
		ParticleManager:ReleaseParticleIndex(out_fx)

		caster:SetAbsOrigin(target_point)
		FindClearSpaceForUnit(caster, target_point, true)
		ProjectileManager:ProjectileDodge(caster)
		if IsValid(target) then
			caster:FaceTowards(target:GetAbsOrigin())
		end

		point_attack_fx = ParticleManager:CreateParticle(
			"particles/shard/aghanim_point_attack/aghanim_point_attack.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(point_attack_fx, 0, caster:GetAbsOrigin())
		ParticleManager:SetParticleControl(point_attack_fx, 1, Vector(radius, 0, 0))
		if params.impact_animation then
			set_cast_lock_animation(caster, params.impact_animation, params.impact_animation_rate)
		end

		stomp_warning_fx = ParticleManager:CreateParticle(
			"particles/econ/items/elder_titan/elder_titan_ti7/elder_titan_echo_stomp_cast_combined_detail_ti7.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(stomp_warning_fx, 0, caster:GetAbsOrigin())
		ParticleManager:SetParticleControl(stomp_warning_fx, 1, Vector(radius, 0, 0))
		ParticleManager:SetParticleControl(stomp_warning_fx, 6, caster:GetAbsOrigin())

		Timers:CreateTimer(stomp_delay, function()
			if not IsValid(caster, self) or not caster:IsAlive() then
				destroy_fx(point_attack_fx)
				destroy_fx(stomp_warning_fx)
				return nil
			end
			destroy_fx(point_attack_fx)
			destroy_fx(stomp_warning_fx)
			EmitSoundOn("Hero_ElderTitan.EchoStomp", caster)
			explode_at(
				caster,
				self,
				caster:GetAbsOrigin(),
				radius,
				params.damage_pct or 30,
				"aghanim_boss_blink_stomp",
				{
					slow_pct = params.slow_pct,
					slow_duration = params.slow_duration,
					knockback_distance = params.knockback_distance,
					particle = "particles/creatures/aghanim/aghanim_stomp_magical.vpcf",
					victim_particle = "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_impact_magical.vpcf",
				}
			)
		end)
	end)

	return true
end

function aghanim_boss_bath_bubble:FindBestCastTarget()
	return find_best_enemy(self:GetCaster(), get_params(self).search_radius)
end

function aghanim_boss_bath_bubble:CastFromBossAI(target)
	local caster = self:GetCaster()
	if not IsValid(caster, self, target) or not target:IsAlive() then
		return false
	end

	local params = get_params(self)
	local cast_duration = tonumber(params.cast_duration) or 0.8
	local distance = tonumber(params.line_length) or 1200
	local radius = tonumber(params.radius) or 180
	local projectile_speed = tonumber(params.projectile_speed) or 900
	local barrage_count = math.max(1, math.floor(tonumber(params.barrage_count) or 1))
	local direction = direction_to(caster, target)
	EmitSoundOn("Birzha.WaterBubble", caster)
	begin_cast(caster, self, cast_duration, direction)

	Timers:CreateTimer(cast_duration, function()
		if not IsValid(caster, self) or not caster:IsAlive() then
			return nil
		end

		local function launch_bubble(barrage_direction)
			local projectile = ProjectileManager:CreateLinearProjectile({
				Source = caster,
				Ability = self,
				vSpawnOrigin = caster:GetAbsOrigin(),
				bDeleteOnHit = true,
				iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
				iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
				iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				fDistance = distance,
				fStartRadius = radius,
				fEndRadius = radius,
				vVelocity = barrage_direction * projectile_speed,
				iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
				bHasFrontalCone = false,
				bReplaceExisting = false,
				bProvidesVision = false,
			})
			CreateProjectileFx(caster, projectile, "particles/shard/aghanim_bubble.vpcf", nil, {
				origin = caster:GetAbsOrigin(),
				direction = barrage_direction,
				speed = projectile_speed,
			})
		end

		for i = 1, barrage_count do
			local angle = (i - 1) * 360 / barrage_count
			local barrage_direction = RotatePosition(Vector(0, 0, 0), QAngle(0, angle, 0), direction)
			launch_bubble(barrage_direction)
		end
	end)

	return true
end

function aghanim_boss_bath_bubble:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then
		return true
	end
	local caster = self:GetCaster()
	if not IsValid(caster, self) then
		return true
	end

	if can_hit(target) then
		local params = get_params(self)
		target:AddNewModifier(caster, self, "modifier_aghanim_boss_bubble", {
			duration = tonumber(params.disable_duration) or 2.2,
			damage_pct = tonumber(params.damage_pct) or 12,
		})
	else
		local pop_fx = ParticleManager:CreateParticle(
			"particles/econ/taunts/snapfire/snapfire_taunt_bubble_pop.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(pop_fx, 0, GetGroundPosition(location, nil))
		ParticleManager:ReleaseParticleIndex(pop_fx)
	end

	return true
end

function aghanim_boss_puddle:FindBestCastTarget()
	local caster = self:GetCaster()
	if not IsValid(caster) then
		return nil
	end

	local params = get_params(self)
	local count = math.max(1, math.floor(tonumber(params.puddle_count) or 1))
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		tonumber(params.search_radius) or 2000,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	local targets = {}

	for _, enemy in ipairs(enemies or {}) do
		if can_hit(enemy) and enemy:IsRealHero() then
			targets[#targets + 1] = enemy
			if #targets >= count then
				return targets
			end
		end
	end

	for _, enemy in ipairs(enemies or {}) do
		if can_hit(enemy) and not enemy:IsRealHero() then
			targets[#targets + 1] = enemy
			if #targets >= count then
				return targets
			end
		end
	end

	return #targets > 0 and targets or nil
end

function aghanim_boss_puddle:CastFromBossAI(targets)
	local caster = self:GetCaster()
	if not IsValid(caster, self) then
		return false
	end
	if IsValid(targets) then
		targets = { targets }
	elseif type(targets) ~= "table" then
		targets = { targets }
	end
	if not can_hit(targets[1]) then
		return false
	end

	local params = get_params(self)
	EmitSoundOn("Aghanim.Water", caster)
	begin_cast(caster, self, 0.2, direction_to(caster, targets[1]))
	for _, target in ipairs(targets) do
		if can_hit(target) then
			local center = GetGroundPosition(target:GetAbsOrigin(), nil)
			CreateModifierThinker(caster, self, "modifier_aghanim_boss_puddle", {
				duration = tonumber(params.duration) or 5,
				radius = tonumber(params.radius) or 420,
				slow_pct = tonumber(params.slow_pct) or 25,
				damage_pct_per_second = tonumber(params.damage_pct_per_second) or 4,
			}, center, caster:GetTeamNumber(), false)
		end
	end
	return true
end

function aghanim_boss_waves_storm:FindBestCastTarget()
	return find_best_enemy(self:GetCaster(), get_params(self).search_radius)
end

function aghanim_boss_waves_storm:CastFromBossAI(target)
	local caster = self:GetCaster()
	if not IsValid(caster, self, target) or not target:IsAlive() then
		return false
	end

	local params = get_params(self)
	local cast_duration = tonumber(params.cast_duration) or 4
	local wave_count = tonumber(params.wave_count) or 6
	local wave_interval = tonumber(params.wave_interval) or 0.55
	local line_length = tonumber(params.line_length) or 1500
	local line_width = tonumber(params.line_width) or 220
	local projectile_speed = tonumber(params.projectile_speed) or 1400
	local base_direction = direction_to(caster, target)

	local channel_fx =
		ParticleManager:CreateParticle("particles/act_2/siltbreaker_channel.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	begin_cast(caster, self, cast_duration, base_direction)
	if params.channel_animation then
		Timers:CreateTimer(tonumber(params.channel_animation_delay) or 0.2, function()
			if not IsValid(caster, self) or not caster:IsAlive() then
				return nil
			end
			set_cast_lock_animation(caster, params.channel_animation, params.channel_animation_rate)
			return nil
		end)
	end
	Timers:CreateTimer(cast_duration, function()
		destroy_fx(channel_fx)
		stop_cast_gesture(caster)
	end)

	for i = 1, wave_count do
		Timers:CreateTimer((i - 1) * wave_interval, function()
			if not IsValid(caster, self) or not caster:IsAlive() then
				return nil
			end

			local angle = (i - (wave_count + 1) * 0.5) * 11
			local direction = RotatePosition(Vector(0, 0, 0), QAngle(0, angle, 0), base_direction)
			local origin = caster:GetAbsOrigin()

			EmitSoundOn("Ability.GushCast", caster)
			local projectile = ProjectileManager:CreateLinearProjectile({
				Source = caster,
				Ability = self,
				vSpawnOrigin = origin + Vector(0, 0, 80),
				bDeleteOnHit = false,
				iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
				iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
				iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				fDistance = line_length,
				fStartRadius = line_width,
				fEndRadius = line_width,
				vVelocity = direction * projectile_speed,
				bHasFrontalCone = false,
				bReplaceExisting = false,
				bProvidesVision = false,
				ExtraData = { waves_storm = 1 },
			})
			CreateProjectileFx(
				caster,
				projectile,
				"particles/units/heroes/hero_tidehunter/tidehunter_gush_upgrade.vpcf",
				nil,
				{
					origin = origin + Vector(0, 0, 80),
					direction = direction,
					speed = projectile_speed,
				}
			)
		end)
	end

	return true
end

function aghanim_boss_waves_storm:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then
		return true
	end
	if tonumber(extra_data and extra_data.waves_storm) ~= 1 then
		return false
	end

	local caster = self:GetCaster()
	if not IsValid(caster, self) then
		return true
	end
	if not can_hit(target) then
		return false
	end

	local params = get_params(self)
	apply_damage(caster, self, target, pct_damage(target, params.damage_pct or 7), "aghanim_boss_waves_storm")
	EmitSoundOn("Ability.GushImpact", target)
	apply_slow(caster, self, target, params.slow_pct, params.slow_duration)
	apply_knockback(caster, self, target, params.knockback_distance, 0, 0.25)
	return false
end

function aghanim_boss_water_ray:FindBestCastTarget()
	return find_best_enemy(self:GetCaster(), get_params(self).search_radius)
end

function aghanim_boss_water_ray:CastFromBossAI(target)
	return cast_tracking_beam(self:GetCaster(), self, target, {
		source_name = "aghanim_boss_water_ray",
		particle = "particles/creatures/aghanim/staff_beam_water.vpcf",
		impact_particle = "particles/units/heroes/hero_tidehunter/tidehunter_gush_splash.vpcf",
	})
end

function aghanim_boss_mad_wrench:FindBestCastTarget()
	return find_best_enemy(self:GetCaster(), get_params(self).search_radius)
end

function aghanim_boss_mad_wrench:CastFromBossAI(target)
	local caster = self:GetCaster()
	if not IsValid(caster, self, target) or not target:IsAlive() then
		return false
	end

	local params = get_params(self)
	local cast_duration = tonumber(params.cast_duration) or 0.45
	local distance = tonumber(params.line_length) or 1200
	local radius = tonumber(params.line_width) or 130
	local projectile_speed = tonumber(params.projectile_speed) or 1200
	local fan_count = math.max(1, math.floor(tonumber(params.fan_count) or 1))
	local fan_angle = tonumber(params.fan_angle) or 0
	local angle_step = fan_count > 1 and fan_angle / (fan_count - 1) or 0
	local half_count = (fan_count - 1) * 0.5
	local direction = direction_to(caster, target)

	EmitSoundOn("Aghanim.EmberChain", caster)
	begin_cast(caster, self, cast_duration, direction)

	self._mad_wrench_token = (self._mad_wrench_token or 0) + 1
	local token = self._mad_wrench_token
	self._mad_wrench_hit_targets = self._mad_wrench_hit_targets or {}
	self._mad_wrench_hit_targets[token] = {}

	Timers:CreateTimer(cast_duration, function()
		if not IsValid(caster, self) or not caster:IsAlive() then
			return nil
		end

		local origin = attachment_origin(caster, "attach_staff_fx")
		for i = 1, fan_count do
			local line_direction = direction
			if fan_count > 1 then
				local angle = (i - 1 - half_count) * angle_step
				line_direction = RotatePosition(Vector(0, 0, 0), QAngle(0, angle, 0), direction)
			end

			local projectile = ProjectileManager:CreateLinearProjectile({
				Source = caster,
				Ability = self,
				vSpawnOrigin = origin,
				bDeleteOnHit = false,
				iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
				iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
				iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				fDistance = distance,
				fStartRadius = radius,
				fEndRadius = radius,
				vVelocity = line_direction * projectile_speed,
				iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
				bHasFrontalCone = false,
				bReplaceExisting = false,
				bProvidesVision = false,
				ExtraData = {
					mad_wrench = 1,
					token = token,
				},
			})
			CreateProjectileFx(caster, projectile, "particles/shard/dddd_chain.vpcf", nil, {
				origin = origin,
				direction = line_direction,
				speed = projectile_speed,
			})
		end

		Timers:CreateTimer(distance / projectile_speed + 1, function()
			if IsValid(self) and self._mad_wrench_hit_targets then
				self._mad_wrench_hit_targets[token] = nil
			end
			return nil
		end)
	end)

	return true
end

function aghanim_boss_mad_wrench:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then
		return true
	end
	if tonumber(extra_data and extra_data.mad_wrench) ~= 1 then
		return false
	end

	local caster = self:GetCaster()
	if not IsValid(caster, self) or not can_hit(target) then
		return false
	end

	local token = tonumber(extra_data and extra_data.token) or 0
	self._mad_wrench_hit_targets = self._mad_wrench_hit_targets or {}
	self._mad_wrench_hit_targets[token] = self._mad_wrench_hit_targets[token] or {}
	local hit_targets = self._mad_wrench_hit_targets[token]
	local target_index = target:entindex()
	if hit_targets[target_index] then
		return false
	end
	hit_targets[target_index] = true

	local params = get_params(self)
	apply_damage(caster, self, target, pct_damage(target, tonumber(params.damage_pct) or 15), "aghanim_boss_mad_wrench")
	apply_root(caster, self, target, params.root_duration)
	if params.chainpair_on_hit then
		local chainpair_fx = ParticleManager:CreateParticle(
			"particles/shard/aghanim_wrength_chainpair.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			target
		)
		ParticleManager:ReleaseParticleIndex(chainpair_fx)
	end
	apply_knockback(caster, self, target, params.pull_distance, 0, 0.35, caster:GetAbsOrigin())
	return false
end

function aghanim_boss_chain:FindBestCastTarget()
	local caster = self:GetCaster()
	if not IsValid(caster) then
		return nil
	end

	local params = get_params(self)
	local target_count = math.max(1, math.floor(tonumber(params.target_count) or 1))
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		tonumber(params.search_radius) or 1500,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	local targets = {}

	for pass = 1, 2 do
		for _, enemy in ipairs(enemies or {}) do
			if can_hit(enemy) and ((pass == 1 and enemy:IsRealHero()) or (pass == 2 and not enemy:IsRealHero())) then
				targets[#targets + 1] = enemy
				if #targets >= target_count then
					return targets
				end
			end
		end
	end

	if #targets > 0 then
		return targets
	end
	return nil
end

function aghanim_boss_chain:CastFromBossAI(targets)
	local caster = self:GetCaster()
	if not IsValid(caster, self) then
		return false
	end

	if type(targets) ~= "table" then
		targets = { targets }
	end

	local valid_targets = {}
	for _, target in ipairs(targets) do
		if IsValid(target) and target:IsAlive() and can_hit(target) then
			valid_targets[#valid_targets + 1] = target
		end
	end
	if #valid_targets == 0 then
		return false
	end

	local params = get_params(self)
	local cast_duration = tonumber(params.cast_duration) or 2.5
	local tick = tonumber(params.tick_interval) or 0.5
	local tick_count = math.max(1, math.floor(cast_duration / tick))
	local damage_pct_per_tick = tonumber(params.damage_pct_per_tick)
	if damage_pct_per_tick == nil then
		damage_pct_per_tick = (tonumber(params.damage_pct_per_second) or 5) * tick
	end

	EmitSoundOn("Aghanim.LichChain", caster)
	begin_cast(caster, self, cast_duration, direction_to(caster, valid_targets[1]))

	local chains = {}
	for _, target in ipairs(valid_targets) do
		EmitSoundOn("Aghanim.LichChain", target)
		chains[#chains + 1] = {
			target = target,
			fx = ParticleManager:CreateParticle("particles/shard/aghanim_new_chain.vpcf", PATTACH_CUSTOMORIGIN, nil),
		}
	end

	for _, chain in ipairs(chains) do
		Timers:CreateTimer(0, function()
			if not IsValid(caster, chain.target) or not caster:IsAlive() or not chain.target:IsAlive() then
				destroy_fx(chain.fx)
				return nil
			end
			ParticleManager:SetParticleControl(chain.fx, 0, caster:GetAbsOrigin() + Vector(0, 0, 120))
			ParticleManager:SetParticleControl(chain.fx, 1, chain.target:GetAbsOrigin() + Vector(0, 0, 80))
			return 0.03
		end)
	end

	for i = 1, tick_count do
		Timers:CreateTimer(i * tick, function()
			if not IsValid(caster, self) or not caster:IsAlive() then
				return nil
			end
			for _, target in ipairs(valid_targets) do
				if IsValid(target) and target:IsAlive() and can_hit(target) then
					apply_damage(caster, self, target, pct_damage(target, damage_pct_per_tick), "aghanim_boss_chain")
					apply_root(caster, self, target, params.root_duration)
					apply_knockback(caster, self, target, params.pull_distance_per_tick, 0, 0.25, caster:GetAbsOrigin())
				end
			end
		end)
	end

	Timers:CreateTimer(cast_duration, function()
		for _, chain in ipairs(chains) do
			destroy_fx(chain.fx)
		end
	end)

	return true
end

function aghanim_boss_mad_chains:FindBestCastTarget()
	return find_best_enemy(self:GetCaster(), get_params(self).search_radius)
end

function aghanim_boss_mad_chains:CastFromBossAI(target)
	local caster = self:GetCaster()
	if not IsValid(caster, self, target) or not target:IsAlive() then
		return false
	end

	local params = get_params(self)
	local cast_duration = tonumber(params.cast_duration) or 1.6
	local radius = tonumber(params.radius) or 650
	local center = caster:GetAbsOrigin()
	begin_cast(caster, self, cast_duration, direction_to(caster, target))
	local aoe_fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_leshrac/leshrac_split_earth_aoe.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(aoe_fx, 0, center)
	ParticleManager:SetParticleControl(aoe_fx, 1, Vector(radius, 0, 0))

	Timers:CreateTimer(cast_duration, function()
		if not IsValid(caster, self) or not caster:IsAlive() then
			return nil
		end
		destroy_fx(aoe_fx)
		explode_at(caster, self, caster:GetAbsOrigin(), radius, params.damage_pct or 18, "aghanim_boss_mad_chains", {
			stun_duration = params.stun_duration,
			particle = "particles/shard/aghanim_lesh_tormented.vpcf",
		})
		EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), "Hero_Leshrac.Split_Earth", caster)

		local victims = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster:GetAbsOrigin(),
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			0,
			FIND_ANY_ORDER,
			false
		)
		for _, victim in ipairs(victims or {}) do
			if can_hit(victim) then
				register_runtime_dot(
					caster,
					self,
					victim,
					params.dot_duration or 3,
					params.dot_damage_pct_per_second or 4,
					"aghanim_boss_mad_chains"
				)
			end
		end
	end)

	return true
end

function aghanim_boss_mad_siled:FindBestCastTarget()
	local caster = self:GetCaster()
	if not find_best_enemy(caster, get_params(self).search_radius) then
		return nil
	end
	return true
end

function aghanim_boss_mad_siled:CastFromBossAI(cast_data)
	local caster = self:GetCaster()
	if not IsValid(caster, self) or not caster:IsAlive() then
		return false
	end

	local params = get_params(self)
	local duration = tonumber(params.duration) or 4
	EmitSoundOn("Birzha.Ostrie", caster)
	begin_cast(caster, self, 0.25)
	caster:AddNewModifier(caster, self, "modifier_aghanim_boss_mad_reflect", {
		duration = duration,
		reflect_pct = tonumber(params.reflect_pct) or 25,
		fear_duration = tonumber(params.fear_duration) or 0.8,
		heal_pct_per_second = tonumber(params.heal_pct_per_second) or 2,
	})
	return true
end

function aghanim_boss_mech_sword:FindBestCastTarget()
	return find_best_enemy(self:GetCaster(), get_params(self).search_radius)
end

function aghanim_boss_mech_sword:CastFromBossAI(target)
	local caster = self:GetCaster()
	if not IsValid(caster, self, target) or not target:IsAlive() then
		return false
	end

	local params = get_params(self)
	local cast_duration = tonumber(params.cast_duration) or 0.35
	local radius = tonumber(params.radius) or 550
	local damage_pct = tonumber(params.damage_pct) or 10
	local cone_angle = tonumber(params.cone_angle) or 90
	local direction = direction_to(caster, target)

	begin_cast(caster, self, cast_duration, direction)

	Timers:CreateTimer(cast_duration, function()
		if not IsValid(caster, self) or not caster:IsAlive() then
			return nil
		end

		local fx = ParticleManager:CreateParticle("particles/shard/aghs_bash.vpcf", PATTACH_WORLDORIGIN, caster)
		ParticleManager:SetParticleControl(fx, 0, caster:GetOrigin())
		set_particle_forward(fx, 0, direction)
		ParticleManager:ReleaseParticleIndex(fx)
		EmitSoundOnLocationWithCaster(caster:GetOrigin(), "Hero_Mars.Shield.Cast", caster)

		local victims = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster:GetAbsOrigin(),
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			0,
			FIND_ANY_ORDER,
			false
		)
		for _, victim in ipairs(victims or {}) do
			if can_hit(victim) then
				local to_victim = direction_to(caster, victim)
				local dot = direction.x * to_victim.x + direction.y * to_victim.y
				if dot >= math.cos(math.rad(cone_angle * 0.5)) then
					apply_damage(caster, self, victim, pct_damage(victim, damage_pct), "aghanim_boss_mech_sword")
					local crit_fx =
						ParticleManager:CreateParticle("particles/shard/aghs_crit.vpcf", PATTACH_WORLDORIGIN, victim)
					ParticleManager:SetParticleControl(crit_fx, 0, victim:GetOrigin())
					ParticleManager:SetParticleControl(crit_fx, 1, victim:GetOrigin())
					set_particle_forward(crit_fx, 1, direction)
					ParticleManager:ReleaseParticleIndex(crit_fx)
					EmitSoundOn("Hero_Mars.Shield.Crit", victim)
					apply_slow(caster, self, victim, params.slow_pct, params.slow_duration)
					apply_knockback(caster, self, victim, params.knockback_distance, 0, 0.3)
				end
			end
		end
	end)

	return true
end

function aghanim_boss_mech_force:FindBestCastTarget()
	return find_best_enemy(self:GetCaster(), get_params(self).search_radius)
end

function aghanim_boss_mech_force:CastFromBossAI(target)
	local caster = self:GetCaster()
	if not IsValid(caster, self, target) or not target:IsAlive() then
		return false
	end

	local params = get_params(self)
	local direction = direction_to(caster, target)
	local distance = tonumber(params.dash_distance) or 550
	local duration = tonumber(params.dash_duration) or 0.45
	local origin = caster:GetAbsOrigin()
	local end_point = GetGroundPosition(origin + direction * distance, caster)

	EmitSoundOn("Hero_FacelessVoid.TimeWalk", caster)
	begin_cast(caster, self, duration, direction)
	local trail_fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_mars/mars_spear_burning_trail.vpcf",
		PATTACH_CUSTOMORIGIN,
		caster
	)
	ParticleManager:SetParticleControl(trail_fx, 0, origin)
	ParticleManager:SetParticleControl(trail_fx, 1, end_point)
	ParticleManager:SetParticleControl(trail_fx, 2, Vector(duration, 0, 0))
	ParticleManager:SetParticleControl(trail_fx, 3, Vector((tonumber(params.line_width) or 280) * 0.5, 0, 0))
	ParticleManager:SetParticleControl(trail_fx, 60, Vector(0, 0, 255))
	ParticleManager:SetParticleControl(trail_fx, 61, Vector(1, 1, 1))

	caster:AddNewModifier(caster, self, "modifier_generic_knockback_lua", {
		duration = duration,
		distance = distance,
		height = 0,
		direction_x = direction.x,
		direction_y = direction.y,
		IsStun = 0,
		IsFlail = 0,
		aplly_pcf = 1,
		pcf_name = "particles/econ/events/fall_2021/force_staff_fall_2021.vpcf",
	})

	Timers:CreateTimer(duration, function()
		destroy_fx(trail_fx)
		if not IsValid(caster, self) or not caster:IsAlive() then
			return nil
		end
		local victims = FindUnitsInLine(
			caster:GetTeamNumber(),
			origin,
			end_point,
			nil,
			tonumber(params.line_width) or 220,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			0
		)
		for _, victim in ipairs(victims or {}) do
			if can_hit(victim) then
				apply_damage(
					caster,
					self,
					victim,
					pct_damage(victim, params.damage_pct or 12),
					"aghanim_boss_mech_force"
				)
				apply_slow(caster, self, victim, params.slow_pct, params.slow_duration)
				if params.fire_debuff_duration then
					attach_temporary_fx(
						victim,
						"particles/shard/aghs_fire_debuff.vpcf",
						tonumber(params.fire_debuff_duration) or 3,
						PATTACH_ABSORIGIN_FOLLOW
					)
				end
				apply_knockback(caster, self, victim, 120, 0, 0.25)
			end
		end
	end)

	return true
end

function aghanim_boss_mech_shield:FindBestCastTarget()
	local caster = self:GetCaster()
	if not find_best_enemy(caster, get_params(self).search_radius) then
		return nil
	end
	return true
end

function aghanim_boss_mech_shield:CastFromBossAI(cast_data)
	local caster = self:GetCaster()
	if not IsValid(caster, self) or not caster:IsAlive() then
		return false
	end

	local params = get_params(self)
	EmitSoundOn("Hero_Tinker.GridEffect", caster)
	begin_cast(caster, self, 0.25)
	caster:AddNewModifier(caster, self, "modifier_aghanim_boss_mech_shield", {
		duration = tonumber(params.duration) or 5,
		heal_pct_per_second = tonumber(params.heal_pct_per_second) or 3,
		nova_radius = tonumber(params.nova_radius) or 500,
		nova_damage_pct = tonumber(params.nova_damage_pct) or 8,
		nova_slow_pct = tonumber(params.nova_slow_pct) or 30,
		nova_slow_duration = tonumber(params.nova_slow_duration) or 1.2,
		nova_knockback_distance = tonumber(params.nova_knockback_distance) or 160,
	})
	return true
end

function aghanim_boss_mech_attack:FindBestCastTarget()
	return find_best_enemy(self:GetCaster(), get_params(self).search_radius)
end

function aghanim_boss_mech_attack:CastFromBossAI(target)
	return cast_delayed_line(self:GetCaster(), self, target, {
		default_cast_duration = 2.0,
		default_length = 2000,
		default_width = 180,
		default_damage_pct = 25,
		source_name = "aghanim_boss_mech_attack",
		particle = "particles/shard/elder_aghs.vpcf",
		cp3 = Vector(0, 0, 0),
		sound_cast = "Aghanim.MechAttackStart",
		sound_stop_on_impact = "Aghanim.MechAttackStart",
		sound_impact_location = "Aghanim.MechAttackEnd",
	})
end

function aghanim_boss_smith_mech:FindBestCastTarget()
	return find_best_enemy(self:GetCaster(), get_params(self).search_radius)
end

function aghanim_boss_smith_mech:CastFromBossAI(target)
	local caster = self:GetCaster()
	if not IsValid(caster, self, target) or not target:IsAlive() then
		return false
	end

	local params = get_params(self)
	local cast_duration = tonumber(params.cast_duration) or 0.5
	local distance = tonumber(params.line_length) or 1200
	local radius = tonumber(params.line_width) or 100
	local speed = tonumber(params.projectile_speed) or 1200
	local projectile_count = math.max(1, math.floor(tonumber(params.projectile_count) or 3))
	local side_angle = tonumber(params.side_projectile_angle) or 120
	local direction = direction_to(caster, target)

	EmitSoundOn("Birzha.MarchTin", caster)
	begin_cast(caster, self, cast_duration, direction)

	Timers:CreateTimer(cast_duration, function()
		if not IsValid(caster, self) or not caster:IsAlive() then
			return nil
		end
		local spawn_origin = caster:GetAbsOrigin()
		local staff_attachment = caster:ScriptLookupAttachment("attach_staff_fx")
		if staff_attachment and staff_attachment > 0 then
			spawn_origin = caster:GetAttachmentOrigin(staff_attachment)
		end

		local projectile_angles = { 0 }
		if projectile_count >= 3 then
			projectile_angles = { 0, -side_angle, side_angle }
		elseif projectile_count == 2 then
			projectile_angles = { 0, side_angle }
		end

		for _, angle in ipairs(projectile_angles) do
			local projectile_direction = RotatePosition(Vector(0, 0, 0), QAngle(0, angle, 0), direction)
			local projectile = ProjectileManager:CreateLinearProjectile({
				Source = caster,
				Ability = self,
				vSpawnOrigin = spawn_origin,
				bDeleteOnHit = false,
				iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
				iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
				iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				fDistance = distance,
				fStartRadius = radius,
				fEndRadius = radius,
				vVelocity = projectile_direction * speed,
				iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
				bHasFrontalCone = false,
				bReplaceExisting = false,
				bProvidesVision = false,
				ExtraData = { main = angle == 0 and 1 or 0 },
			})
			CreateProjectileFx(caster, projectile, "particles/shard/tinker_mech.vpcf", nil, {
				origin = spawn_origin,
				direction = projectile_direction,
				speed = speed,
			})
		end
	end)

	return true
end

function aghanim_boss_smith_mech:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then
		return true
	end

	local caster = self:GetCaster()
	if not IsValid(caster, self) then
		return true
	end

	local params = get_params(self)
	local radius = tonumber(params.explosion_radius) or 300
	local secondary_radius = tonumber(params.secondary_search_radius) or radius
	local main = tonumber(extra_data and extra_data.main) or 0

	if not can_hit(target) then
		EmitSoundOnLocationWithCaster(location, "Birzha.BrokenMach", caster)
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			location,
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			0,
			FIND_ANY_ORDER,
			false
		)
		for _, enemy in ipairs(enemies or {}) do
			if can_hit(enemy) then
				apply_damage(
					caster,
					self,
					enemy,
					pct_damage(enemy, params.splash_damage_pct or params.damage_pct or 10),
					"aghanim_boss_smith_mech"
				)
			end
		end
		return true
	end

	local cart_fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_techies/techies_remote_cart_explode.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:ReleaseParticleIndex(cart_fx)
	attach_temporary_fx(
		target,
		"particles/shard/aghs_cast_range_debuff.vpcf",
		tonumber(params.cast_range_debuff_duration) or 3,
		PATTACH_ABSORIGIN_FOLLOW
	)
	local damage_pct = main == 1 and (params.damage_pct or 25)
		or (params.secondary_damage_pct or params.damage_pct or 15)
	apply_damage(caster, self, target, pct_damage(target, damage_pct), "aghanim_boss_smith_mech")

	if main == 1 then
		EmitSoundOn("Birzha.MechAttack", target)
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			target:GetAbsOrigin(),
			nil,
			secondary_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			0,
			FIND_ANY_ORDER,
			false
		)
		for _, enemy in ipairs(enemies or {}) do
			if can_hit(enemy) and enemy ~= target then
				local projectile = ProjectileManager:CreateTrackingProjectile({
					Target = enemy,
					vSourceLoc = target:GetAbsOrigin(),
					Ability = self,
					iMoveSpeed = 800,
					bReplaceExisting = false,
					ExtraData = { main = 0 },
				})
				CreateProjectileFx(caster, projectile, "particles/shard/aghs_mech_tr.vpcf", {
					origin = target:GetAbsOrigin(),
					target = enemy,
					speed = 800,
				})
			end
		end
	end

	return true
end

function aghanim_boss_smith_jetpack:FindBestCastTarget()
	return find_best_enemy(self:GetCaster(), get_params(self).search_radius)
end

function aghanim_boss_smith_jetpack:CastFromBossAI(target)
	local caster = self:GetCaster()
	if not IsValid(caster, self, target) or not target:IsAlive() then
		return false
	end

	local params = get_params(self)
	local direction = direction_to(caster, target)
	local distance = tonumber(params.leap_distance) or 650
	local duration = tonumber(params.leap_duration) or 0.55
	local radius = tonumber(params.landing_radius) or 260
	local bomb_count = math.max(2, math.min(3, math.floor(tonumber(params.trail_bomb_count) or 3)))

	begin_cast(caster, self, duration, direction)
	local jetpack_fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_rattletrap/rattletrap_jetpack.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	caster:AddNewModifier(caster, self, "modifier_generic_knockback_lua", {
		duration = duration,
		distance = distance,
		height = 220,
		direction_x = direction.x,
		direction_y = direction.y,
		IsStun = 0,
		IsFlail = 1,
	})

	local side_direction = Vector(-direction.y, direction.x, 0)
	for i = 1, bomb_count do
		Timers:CreateTimer(duration * i / (bomb_count + 1), function()
			if not IsValid(caster, self) or not caster:IsAlive() then
				return nil
			end

			local side_multiplier = 0
			if bomb_count == 2 then
				side_multiplier = i == 1 and -1 or 1
			else
				side_multiplier = i == 2 and 0 or (i == 1 and -1 or 1)
			end
			local spawn_point = caster:GetAbsOrigin()
			local drop_point = GetGroundPosition(
				spawn_point
					- direction * 80
					+ side_direction * (tonumber(params.trail_bomb_side_offset) or 120) * side_multiplier,
				nil
			)
			launch_smith_bomb(caster, self, spawn_point, drop_point, {
				explosion_delay = params.trail_bomb_explosion_delay,
				radius = params.trail_bomb_radius,
				damage_pct = params.trail_bomb_damage_pct,
				slow_pct = params.slow_pct,
				slow_duration = params.slow_duration,
				source_name = "aghanim_boss_smith_jetpack_trail_bomb",
				model_scale = 0.65,
				height = 80,
				is_flail = true,
			})
			return nil
		end)
	end

	Timers:CreateTimer(duration, function()
		destroy_fx(jetpack_fx)
		if not IsValid(caster, self) or not caster:IsAlive() then
			return nil
		end
		FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), true)
		explode_at(caster, self, caster:GetAbsOrigin(), radius, params.damage_pct or 13, "aghanim_boss_smith_jetpack", {
			slow_pct = params.slow_pct,
			slow_duration = params.slow_duration,
			knockback_distance = params.knockback_distance,
		})
	end)

	return true
end

function aghanim_boss_smith_crange:FindBestCastTarget()
	local caster = self:GetCaster()
	if not find_best_enemy(caster, get_params(self).search_radius) then
		return nil
	end
	return true
end

function aghanim_boss_smith_crange:CastFromBossAI(cast_data)
	local caster = self:GetCaster()
	if not IsValid(caster, self) or not caster:IsAlive() then
		return false
	end

	local params = get_params(self)
	EmitSoundOn("Aghanim.TinkerPortal", caster)
	begin_cast(caster, self, 0.25)
	caster:AddNewModifier(caster, self, "modifier_aghanim_boss_smith_overdrive", {
		duration = tonumber(params.duration) or 5,
		radius = tonumber(params.radius) or tonumber(params.search_radius) or 1200,
		heal_pct_per_second = tonumber(params.heal_pct_per_second) or 2,
		cooldown_reduction_per_second = tonumber(params.cooldown_reduction_per_second) or 1,
	})
	return true
end

function aghanim_boss_smith_bomb:FindBestCastTarget()
	return find_best_enemy(self:GetCaster(), get_params(self).search_radius)
end

function aghanim_boss_smith_bomb:CastFromBossAI(target)
	local caster = self:GetCaster()
	if not IsValid(caster, self) then
		return false
	end
	if IsValid(target) and not target:IsAlive() then
		target = nil
	end

	local params = get_params(self)
	local cast_duration = tonumber(params.cast_duration) or 1.2
	local explosion_delay = tonumber(params.explosion_delay) or 0.8
	local radius = tonumber(params.radius) or 280
	local bomb_count = math.max(1, math.floor(tonumber(params.bomb_count) or 1))
	local bomb_throw_interval = tonumber(params.bomb_throw_interval) or 0.1
	local bomb_min_distance = tonumber(params.bomb_min_distance) or 450
	local bomb_max_distance = tonumber(params.bomb_max_distance) or 650
	local bomb_spiral_step_degrees = tonumber(params.bomb_spiral_step_degrees) or 137.5
	local bomb_angle_jitter_degrees = tonumber(params.bomb_angle_jitter_degrees) or 0
	local base_angle = RandomFloat(0, 360)
	local throw_duration = (bomb_count - 1) * bomb_throw_interval
	local cast_direction = IsValid(target) and direction_to(caster, target) or caster:GetForwardVector()
	begin_cast(caster, self, cast_duration + throw_duration, cast_direction)

	Timers:CreateTimer(cast_duration, function()
		if not IsValid(caster, self) or not caster:IsAlive() then
			return nil
		end

		EmitSoundOn("Aghanim.BombStart", caster)
		for i = 1, bomb_count do
			Timers:CreateTimer((i - 1) * bomb_throw_interval, function()
				if not IsValid(caster, self) or not caster:IsAlive() then
					return nil
				end

				local spawn_point = caster:GetAbsOrigin()
				local staff_attachment = caster:ScriptLookupAttachment("attach_staff_fx")
				if staff_attachment and staff_attachment > 0 then
					spawn_point = caster:GetAttachmentOrigin(staff_attachment)
					spawn_point.z = caster:GetAbsOrigin().z
				end

				local angle = base_angle
					+ (i - 1) * bomb_spiral_step_degrees
					+ RandomFloat(-bomb_angle_jitter_degrees, bomb_angle_jitter_degrees)
				local distance = RandomFloat(bomb_min_distance, bomb_max_distance)
				local bomb_direction =
					RotatePosition(Vector(0, 0, 0), QAngle(0, angle, 0), Vector(1, 0, 0)):Normalized()
				local bomb_target_point = GetGroundPosition(caster:GetAbsOrigin() + bomb_direction * distance, nil)

				launch_smith_bomb(caster, self, spawn_point, bomb_target_point, {
					explosion_delay = explosion_delay,
					radius = radius,
					damage_pct = params.damage_pct or 30,
					silence_duration = params.silence_duration,
					slow_pct = params.slow_pct,
					slow_duration = params.slow_duration,
					source_name = "aghanim_boss_smith_bomb",
					model_scale = 1,
					height = 250,
					is_flail = true,
				})
				return nil
			end)
		end
	end)

	return true
end

modifier_aghanim_boss_bubble = class({})
function modifier_aghanim_boss_bubble:IsDebuff()
	return true
end
function modifier_aghanim_boss_bubble:IsPurgable()
	return false
end
function modifier_aghanim_boss_bubble:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.damage_pct = tonumber(kv.damage_pct) or 12
	self.particle = ParticleManager:CreateParticle(
		"particles/econ/taunts/snapfire/snapfire_taunt_bubble.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_ice_slide", {})
end
function modifier_aghanim_boss_bubble:OnDestroy()
	if not IsServer() then
		return
	end
	destroy_fx(self.particle)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local parent = self:GetParent()
	if IsValid(caster, ability) and can_hit(parent) then
		apply_damage(caster, ability, parent, pct_damage(parent, self.damage_pct), "aghanim_boss_bath_bubble")
	end
	self:GetParent():RemoveModifierByName("modifier_ice_slide")
	EmitSoundOn("Birzha.VoidBubble", self:GetParent())
end
function modifier_aghanim_boss_bubble:CheckState()
	return {
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_FLYING] = true,
		[MODIFIER_STATE_SILENCED] = true,
	}
end

modifier_aghanim_boss_shard_crystal = class({})
function modifier_aghanim_boss_shard_crystal:IsDebuff()
	return true
end
function modifier_aghanim_boss_shard_crystal:IsPurgable()
	return true
end
function modifier_aghanim_boss_shard_crystal:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end
function modifier_aghanim_boss_shard_crystal:OnRefresh()
	if not IsServer() then
		return
	end
	self:IncrementStackCount()
end
function modifier_aghanim_boss_shard_crystal:GetTexture()
	return "shard_debuff"
end

modifier_aghanim_boss_puddle = class({})
function modifier_aghanim_boss_puddle:IsHidden()
	return true
end
function modifier_aghanim_boss_puddle:IsPurgable()
	return false
end
function modifier_aghanim_boss_puddle:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.radius = tonumber(kv.radius) or 420
	self.slow_pct = tonumber(kv.slow_pct) or 25
	self.damage_pct_per_second = tonumber(kv.damage_pct_per_second) or 4
	self.tick = 0.5
	self.particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_slardar/slardar_water_puddle.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(self.particle, 1, Vector(self.radius, 0, 0))
	self:StartIntervalThink(self.tick)
end
function modifier_aghanim_boss_puddle:OnIntervalThink()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValid(caster, ability) then
		return
	end

	caster._levelup_aghanim_puddle_damage_times = caster._levelup_aghanim_puddle_damage_times or {}
	local now = GameRules:GetGameTime()
	local victims = FindUnitsInRadius(
		caster:GetTeamNumber(),
		self:GetParent():GetAbsOrigin(),
		nil,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		FIND_ANY_ORDER,
		false
	)
	for _, victim in ipairs(victims or {}) do
		local victim_index = victim:entindex()
		local last_damage_time = tonumber(caster._levelup_aghanim_puddle_damage_times[victim_index]) or nil
		if can_hit(victim) and (not last_damage_time or now - last_damage_time >= self.tick * 0.9) then
			caster._levelup_aghanim_puddle_damage_times[victim_index] = now
			apply_damage(
				caster,
				ability,
				victim,
				pct_damage(victim, self.damage_pct_per_second * self.tick),
				"aghanim_boss_puddle"
			)
			apply_slow(caster, ability, victim, self.slow_pct, self.tick + 0.2)
		end
	end
end
function modifier_aghanim_boss_puddle:OnDestroy()
	if not IsServer() then
		return
	end
	destroy_fx(self.particle)
end

modifier_aghanim_boss_beam_endpoint = class({})
function modifier_aghanim_boss_beam_endpoint:IsHidden()
	return true
end
function modifier_aghanim_boss_beam_endpoint:IsPurgable()
	return false
end
function modifier_aghanim_boss_beam_endpoint:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function modifier_aghanim_boss_beam_endpoint:OnDestroy()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(parent) then
		UTIL_Remove(parent)
	end
end

modifier_aghanim_boss_fear = class({})
function modifier_aghanim_boss_fear:IsDebuff()
	return true
end
function modifier_aghanim_boss_fear:IsPurgable()
	return false
end
function modifier_aghanim_boss_fear:OnCreated()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	if IsValid(caster, parent) then
		local direction = parent:GetAbsOrigin() - caster:GetAbsOrigin()
		direction.z = 0
		if direction:Length2D() <= 0.01 then
			direction = parent:GetForwardVector()
		end
		self.position = parent:GetAbsOrigin() + direction:Normalized() * 500
		parent:MoveToPosition(self.position)
	end
	self.effect_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_muerta/muerta_spell_fear_debuff.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	self.status_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_muerta/muerta_spell_fear_debuff_status.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	self:StartIntervalThink(0.1)
end
function modifier_aghanim_boss_fear:OnIntervalThink()
	local parent = self:GetParent()
	if not IsValid(parent) or not self.position then
		return
	end
	parent:MoveToPosition(self.position)
end
function modifier_aghanim_boss_fear:CheckState()
	return {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_FEARED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}
end
function modifier_aghanim_boss_fear:OnDestroy()
	if not IsServer() then
		return
	end
	destroy_fx(self.effect_particle)
	destroy_fx(self.status_particle)
	if IsValid(self:GetParent()) then
		self:GetParent():Stop()
	end
end

modifier_aghanim_boss_mad_reflect = class({})
function modifier_aghanim_boss_mad_reflect:IsPurgable()
	return false
end
function modifier_aghanim_boss_mad_reflect:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.reflect_pct = tonumber(kv.reflect_pct) or 25
	self.fear_duration = tonumber(kv.fear_duration) or 0.8
	self.heal_pct_per_second = tonumber(kv.heal_pct_per_second) or 2
	self.feared_attackers = {}
	self.tick = 1
	self.particle = ParticleManager:CreateParticle(
		"particles/shard/aghanim_hedhehohg.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		self.particle,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	self:StartIntervalThink(self.tick)
end
function modifier_aghanim_boss_mad_reflect:OnIntervalThink()
	heal_unit(self:GetParent(), max_health(self:GetParent()) * self.heal_pct_per_second * self.tick * 0.01)
end
function modifier_aghanim_boss_mad_reflect:DeclareFunctions()
	return { MODIFIER_EVENT_ON_TAKEDAMAGE }
end
function modifier_aghanim_boss_mad_reflect:ReflectDamage(event)
	if
		not event
		or event.unit ~= self:GetParent()
		or not can_hit(event.attacker)
		or event.attacker:GetTeamNumber() == self:GetParent():GetTeamNumber()
	then
		return
	end
	if
		event.is_reflected_damage == true
		or event.magic_mirror_reflected == true
		or has_reflection_damage_flag(event)
	then
		return
	end

	local damage = (tonumber(event.damage) or 0) * self.reflect_pct * 0.01
	if damage > 0 then
		apply_damage(self:GetParent(), self:GetAbility(), event.attacker, damage, "aghanim_boss_mad_siled", {
			damage_flags = DOTA_DAMAGE_FLAG_REFLECTION,
			is_reflected_damage = true,
		})
		EmitSoundOn("DOTA_Item.BladeMail.Damage", event.attacker)
		local attacker_index = event.attacker:entindex()
		if not self.feared_attackers[attacker_index] then
			self.feared_attackers[attacker_index] = true
			EmitSoundOn("Aghanim.Fear", event.attacker)
			event.attacker:AddNewModifier(
				self:GetParent(),
				self:GetAbility(),
				"modifier_aghanim_boss_fear",
				{ duration = self.fear_duration }
			)
		end
	end
end
function modifier_aghanim_boss_mad_reflect:OnTakeDamage(event)
	if not IsServer() then
		return
	end
	self:ReflectDamage(event)
end
function modifier_aghanim_boss_mad_reflect:OnLevelUpCustomDamageTaken(event)
	if not IsServer() then
		return
	end
	self:ReflectDamage(event)
end
function modifier_aghanim_boss_mad_reflect:OnDestroy()
	if not IsServer() then
		return
	end
	destroy_fx(self.particle)
end

modifier_aghanim_boss_mech_shield = class({})
function modifier_aghanim_boss_mech_shield:IsPurgable()
	return false
end
function modifier_aghanim_boss_mech_shield:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.heal_pct_per_second = tonumber(kv.heal_pct_per_second) or 3
	self.nova_radius = tonumber(kv.nova_radius) or 500
	self.nova_damage_pct = tonumber(kv.nova_damage_pct) or 8
	self.nova_slow_pct = tonumber(kv.nova_slow_pct) or 30
	self.nova_slow_duration = tonumber(kv.nova_slow_duration) or 1.2
	self.nova_knockback_distance = tonumber(kv.nova_knockback_distance) or 160
	self.tick = 1
	self.particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_tinker/tinker_defense_matrix.vpcf",
		PATTACH_POINT_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		self.particle,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	self:StartIntervalThink(self.tick)
end
function modifier_aghanim_boss_mech_shield:OnIntervalThink()
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(parent, ability) or not parent:IsAlive() then
		return
	end

	heal_unit(parent, max_health(parent) * self.heal_pct_per_second * self.tick * 0.01)
	EmitSoundOnLocationWithCaster(parent:GetAbsOrigin(), "DOTA_Item.Mekansm.Activate", parent)
	explode_at(
		parent,
		ability,
		parent:GetAbsOrigin(),
		self.nova_radius,
		self.nova_damage_pct,
		"aghanim_boss_mech_shield",
		{
			particle = "particles/creatures/aghanim/aghanim_pulse_nova.vpcf",
			slow_pct = self.nova_slow_pct,
			slow_duration = self.nova_slow_duration,
			knockback_distance = self.nova_knockback_distance,
		}
	)
end
function modifier_aghanim_boss_mech_shield:OnDestroy()
	if not IsServer() then
		return
	end
	destroy_fx(self.particle)
end

modifier_aghanim_boss_smith_overdrive = class({})
function modifier_aghanim_boss_smith_overdrive:IsPurgable()
	return false
end
function modifier_aghanim_boss_smith_overdrive:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.heal_pct_per_second = tonumber(kv.heal_pct_per_second) or 2
	self.cooldown_reduction_per_second = tonumber(kv.cooldown_reduction_per_second) or 1
	self.radius = tonumber(kv.radius) or 1200
	self.tick = 1
	self.cooldown_particle = ParticleManager:CreateParticle(
		"particles/shard/aghanim_cooldown.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(self.cooldown_particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(self.cooldown_particle, 1, Vector(self.radius, self.radius, self.radius))
	self.particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_wisp/wisp_overcharge.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		self.particle,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	self:StartIntervalThink(self.tick)
end
function modifier_aghanim_boss_smith_overdrive:OnIntervalThink()
	local parent = self:GetParent()
	heal_unit(parent, max_health(parent) * self.heal_pct_per_second * self.tick * 0.01)

	for i = 0, parent:GetAbilityCount() - 1 do
		local ability = parent:GetAbilityByIndex(i)
		if IsValid(ability) and ability ~= self:GetAbility() and ability:GetCooldownTimeRemaining() > 0 then
			local remaining =
				math.max(0, ability:GetCooldownTimeRemaining() - self.cooldown_reduction_per_second * self.tick)
			ability:EndCooldown()
			if remaining > 0 then
				ability:StartCooldown(remaining)
			end
		end
	end
end
function modifier_aghanim_boss_smith_overdrive:OnDestroy()
	if not IsServer() then
		return
	end
	destroy_fx(self.particle)
	destroy_fx(self.cooldown_particle)
end

setup_boss_ability(aghanim_boss_shard)
setup_boss_ability(aghanim_boss_ray)
setup_boss_ability(aghanim_boss_blink_stomp)
setup_boss_ability(aghanim_boss_bath_bubble)
setup_boss_ability(aghanim_boss_puddle)
setup_boss_ability(aghanim_boss_waves_storm)
setup_boss_ability(aghanim_boss_water_ray)
setup_boss_ability(aghanim_boss_mad_wrench)
setup_boss_ability(aghanim_boss_chain)
setup_boss_ability(aghanim_boss_mad_chains)
setup_boss_ability(aghanim_boss_mad_siled)
setup_boss_ability(aghanim_boss_mech_sword)
setup_boss_ability(aghanim_boss_mech_force)
setup_boss_ability(aghanim_boss_mech_shield)
setup_boss_ability(aghanim_boss_mech_attack)
setup_boss_ability(aghanim_boss_smith_mech)
setup_boss_ability(aghanim_boss_smith_jetpack)
setup_boss_ability(aghanim_boss_smith_crange)
setup_boss_ability(aghanim_boss_smith_bomb)