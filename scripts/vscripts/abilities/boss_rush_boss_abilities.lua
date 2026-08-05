--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_rush_duel_protocol", "abilities/boss_rush_boss_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_rush_duel_damage_bonus", "abilities/boss_rush_boss_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_rush_quill_accumulator", "abilities/boss_rush_boss_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_boss_rush_overwhelming_odds_haste",
	"abilities/boss_rush_boss_abilities",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_boss_rush_counter_helix", "abilities/boss_rush_boss_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_rush_hydraulic_waveform", "abilities/boss_rush_boss_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_boss_rush_adaptive_strike_multi",
	"abilities/boss_rush_boss_abilities",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_boss_rush_viscous_nasal_goo", "abilities/boss_rush_boss_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_rush_false_promise_self", "abilities/boss_rush_boss_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_rush_laser_blind", "abilities/boss_rush_boss_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_rush_impalement_bleed", "abilities/boss_rush_boss_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_rush_wheel_zone", "abilities/boss_rush_boss_abilities", LUA_MODIFIER_MOTION_NONE)

boss_rush_duel_protocol = class({})
boss_rush_execution_blade = class({})
boss_rush_hydraulic_waveform = class({})
boss_rush_quill_overload = class({})
boss_rush_purifying_malfunction = class({})
boss_rush_rocket_salvo = class({})
boss_rush_wheel_of_wonder = class({})
boss_rush_overwhelming_odds = class({})
boss_rush_counter_helix = class({})
boss_rush_adaptive_strike_multi = class({})
boss_rush_viscous_nasal_goo = class({})
boss_rush_false_promise_self = class({})
boss_rush_laser = class({})
boss_rush_impalement_arts = class({})

local boss_rush_tinker_rocket_token = 0

--[[ ===================== Shared helpers ===================== ]]

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

local function max_health(unit)
	if not IsValid(unit) then
		return 0
	end
	return tonumber(unit._levelup_max_health) or 0
end

local function pct_damage(victim, pct)
	return max_health(victim) * (tonumber(pct) or 0) * 0.01
end

local function hp_pct(unit)
	if not IsValid(unit) then
		return 100
	end
	local maxhp = tonumber(unit._levelup_max_health) or unit:GetMaxHealth()
	if not maxhp or maxhp <= 0 then
		return 100
	end
	local cur = tonumber(unit._levelup_current_health) or unit:GetHealth()
	return 100 * cur / maxhp
end

-- Урон применяется только к юнитам с кастомным HP (герои/кастом-крипы) - иначе
-- ApplyPreparedDamage ругается в лог. Боссы и так не наносят урон самим себе.
local function can_damage(victim)
	return IsValid(victim)
		and victim:IsAlive()
		and victim._levelup_current_health ~= nil
		and victim:GetUnitName() ~= "npc_levelup_main_building"
		and not (victim.IsOutOfGame and victim:IsOutOfGame())
end

local function apply_damage(caster, ability, victim, pct, source_name)
	if not IsValid(caster) or not IsValid(ability) or not can_damage(victim) then
		return false
	end
	if not boss_ability_system or not boss_ability_system.ApplyPureBossDamage then
		return false
	end
	return boss_ability_system:ApplyPureBossDamage(
		caster,
		ability,
		victim,
		math.max(0, pct_damage(victim, pct)),
		source_name
	)
end

-- Среднее custom-attack damage босса (для способностей с base = урон атаки босса).
local function boss_attack_damage(caster)
	if not IsValid(caster) then
		return 0
	end
	local mn = tonumber(caster._levelup_custom_attack_damage_min) or 0
	local mx = tonumber(caster._levelup_custom_attack_damage_max) or mn
	return (mn + mx) * 0.5
end

local function apply_flat_damage(caster, ability, victim, amount, source_name)
	if not IsValid(caster) or not IsValid(ability) or not can_damage(victim) then
		return false
	end
	if not boss_ability_system or not boss_ability_system.ApplyPureBossDamage then
		return false
	end
	return boss_ability_system:ApplyPureBossDamage(
		caster,
		ability,
		victim,
		math.max(0, tonumber(amount) or 0),
		source_name
	)
end

local function heal_unit(unit, amount)
	if not IsValid(unit) or not unit:IsAlive() then
		return
	end
	amount = math.max(0, tonumber(amount) or 0)
	if amount <= 0 then
		return
	end
	if unit.LevelUpModifyHealth then
		unit:LevelUpModifyHealth(amount)
	end
end

local function resolve_activity(name)
	if type(name) == "number" then
		return name
	end
	if type(name) ~= "string" or name == "" then
		return nil
	end
	return _G[name]
end

local function play_cast_gesture(caster, activity_name)
	if not IsValid(caster) then
		return
	end
	local activity = resolve_activity(activity_name)
	if not activity then
		return
	end
	local previous = caster._levelup_boss_cast_gesture
	if previous then
		caster:FadeGesture(previous)
	end
	caster:StartGesture(activity)
	caster._levelup_boss_cast_gesture = activity
end

local function direction_to(caster, target_or_point)
	local point = target_or_point
	if target_or_point and target_or_point.GetAbsOrigin then
		point = target_or_point:GetAbsOrigin()
	end
	local dir = point - caster:GetAbsOrigin()
	dir.z = 0
	if dir:Length2D() <= 0.01 then
		dir = caster:GetForwardVector()
		dir.z = 0
	end
	return dir:Normalized()
end

local function destroy_fx(fx)
	if not fx then
		return
	end
	ParticleManager:DestroyParticle(fx, false)
	ParticleManager:ReleaseParticleIndex(fx)
end

local function is_active_combat()
	return BossRushActivity ~= nil and BossRushActivity:IsActiveCombat() == true
end

-- Дебаг-боссы (спавн из debug-панели) могут кастовать вне самой активности.
local function combat_allows_cast(caster)
	if is_active_combat() then
		return true
	end
	return IsValid(caster) and caster.levelup_boss_rush_debug == true
end

-- Caster жив + кастовать разрешено (для delayed timers / projectile hits).
local function cast_still_valid(caster)
	return combat_allows_cast(caster) and IsValid(caster) and caster:IsAlive()
end

local function valid_enemy(unit)
	return BossRushActivity ~= nil and BossRushActivity:IsValidBossRushEnemyTarget(unit) == true
end

local function valid_hero(unit)
	return BossRushActivity ~= nil and BossRushActivity:IsValidBossRushHeroTarget(unit) == true
end

-- Список живых участвующих real-героев в радиусе (single-target abilities).
local function find_hero_targets(caster, radius)
	local list = {}
	if not IsValid(caster) then
		return list
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		tonumber(radius) or 2000,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, enemy in ipairs(enemies or {}) do
		if valid_hero(enemy) then
			table.insert(list, enemy)
		end
	end
	return list
end

-- Любые валидные Boss Rush enemy-цели (герои + помощники + суммоны) в радиусе.
local function find_enemy_targets(caster, center, radius)
	local list = {}
	if not IsValid(caster) then
		return list
	end
	local units = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center or caster:GetAbsOrigin(),
		nil,
		tonumber(radius) or 500,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for _, u in ipairs(units or {}) do
		if valid_enemy(u) then
			table.insert(list, u)
		end
	end
	return list
end

local function begin_cast(caster, ability, lock_duration, direction)
	if boss_ability_system and boss_ability_system.BeginCastLock then
		boss_ability_system:BeginCastLock(caster, ability, tonumber(lock_duration) or 0, direction)
	end
	play_cast_gesture(caster, get_params(ability).cast_animation)
	ability:StartCooldown(get_cooldown(ability))
end

local function next_tinker_rocket_token()
	boss_rush_tinker_rocket_token = boss_rush_tinker_rocket_token + 1
	return boss_rush_tinker_rocket_token
end

local function unregister_tinker_rocket(target, token)
	token = tonumber(token)
	if not IsValid(target) or not token then
		return false
	end

	local projectiles = target._boss_rush_tinker_missiles
	if type(projectiles) ~= "table" or projectiles[token] == nil then
		return false
	end

	projectiles[token] = nil
	if next(projectiles) == nil then
		target._boss_rush_tinker_missiles = nil
	end
	return true
end

local function setup_boss_rush_ability(ability_class)
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

for _, cls in ipairs({
	boss_rush_duel_protocol,
	boss_rush_execution_blade,
	boss_rush_hydraulic_waveform,
	boss_rush_quill_overload,
	boss_rush_purifying_malfunction,
	boss_rush_rocket_salvo,
	boss_rush_wheel_of_wonder,
	boss_rush_overwhelming_odds,
	boss_rush_counter_helix,
	boss_rush_adaptive_strike_multi,
	boss_rush_viscous_nasal_goo,
	boss_rush_false_promise_self,
	boss_rush_laser,
	boss_rush_impalement_arts,
}) do
	setup_boss_rush_ability(cls)
end

--[[ ===================== 1. Legion - Duel Protocol ===================== ]]
-- Marked chase: НЕ контроль игрока. Force-attack только на самом боссе.

function boss_rush_duel_protocol:FindBestCastTarget()
	local caster = self:GetCaster()
	if not IsValid(caster) or not combat_allows_cast(caster) then
		return nil
	end

	local heroes = find_hero_targets(caster, get_params(self).search_radius or 2000)
	if #heroes <= 0 then
		return nil
	end
	return { target = heroes[RandomInt(1, #heroes)] }
end

function boss_rush_duel_protocol:CastFromBossAI(cast_data)
	local caster = self:GetCaster()
	local target = cast_data and cast_data.target
	if not cast_still_valid(caster) or not valid_hero(target) then
		return false
	end

	local params = get_params(self)
	begin_cast(caster, self, 0.2, direction_to(caster, target)) -- короткий стоп, потом погоня

	EmitSoundOn("Hero_LegionCommander.Duel", caster)
	EmitSoundOn("Hero_LegionCommander.Duel.Cast.Arcana", caster)
	caster:AddNewModifier(caster, self, "modifier_boss_rush_duel_protocol", {
		duration = tonumber(params.duration) or 5.0,
		target_entindex = target:entindex(),
	})
	target:AddNewModifier(caster, self, "modifier_generic_root_lua", { duration = tonumber(params.duration) or 5.0 })
	return true
end

--[[ ===================== 2. Axe - Execution Blade ===================== ]]
-- Цель: ближайший real hero в радиусе. Warning + delayed % урон, без cd reset.

function boss_rush_execution_blade:FindBestCastTarget()
	local caster = self:GetCaster()
	if not IsValid(caster) or not combat_allows_cast(caster) then
		return nil
	end

	local params = get_params(self)
	local best, best_distance = nil, nil
	for _, hero in ipairs(find_hero_targets(caster, params.search_radius or 2000)) do
		local distance = (hero:GetAbsOrigin() - caster:GetAbsOrigin()):Length2D()
		if best_distance == nil or distance < best_distance then
			best, best_distance = hero, distance
		end
	end
	if not best then
		return nil
	end
	return { target = best }
end

function boss_rush_execution_blade:CastFromBossAI(cast_data)
	local caster = self:GetCaster()
	local target = cast_data and cast_data.target
	if not cast_still_valid(caster) or not valid_hero(target) then
		return false
	end

	local params = get_params(self)
	local cast_duration = tonumber(params.cast_duration) or 1.2
	local damage_pct = tonumber(params.damage_pct_of_target_max_hp) or 35
	local target_index = target:entindex()

	begin_cast(caster, self, cast_duration, direction_to(caster, target))
	EmitSoundOn("Hero_Axe.Culling_Blade_Fail", caster)

	-- danger marker на цели
	local marker = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_axe/axe_culling_blade.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:SetParticleControlEnt(marker, 0, target, PATTACH_ABSORIGIN_FOLLOW, nil, target:GetAbsOrigin(), true)

	Timers:CreateTimer(cast_duration, function()
		destroy_fx(marker)
		if not cast_still_valid(caster) then
			return nil
		end

		local victim = EntIndexToHScript(target_index)
		if not valid_hero(victim) then
			return nil
		end

		apply_damage(caster, self, victim, damage_pct, "boss_rush_execution_blade")
		if IsValid(victim) and not victim:IsAlive() then
			local kfx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_axe/axe_culling_blade_kill.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				victim
			)
			ParticleManager:ReleaseParticleIndex(kfx)
			EmitSoundOn("Hero_Axe.Culling_Blade_Success", caster)
		else
			local ifx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_axe/axe_culling_blade.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				victim
			)
			ParticleManager:ReleaseParticleIndex(ifx)
		end
		return nil
	end)

	return true
end

--[[ ===================== 3. Morphling - Hydraulic Waveform ===================== ]]
-- Danger line -> delay -> invulnerable movement through enemies.

function boss_rush_hydraulic_waveform:FindBestCastTarget()
	local caster = self:GetCaster()
	if not IsValid(caster) or not combat_allows_cast(caster) then
		return nil
	end

	local params = get_params(self)
	local target = find_hero_targets(caster, params.search_radius or 1800)[1]
	if not IsValid(target) then
		-- fallback: ближайшая валидная enemy-цель (assistant/summon)
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster:GetAbsOrigin(),
			nil,
			tonumber(params.search_radius) or 1800,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_CLOSEST,
			false
		)
		for _, e in ipairs(enemies or {}) do
			if valid_enemy(e) then
				target = e
				break
			end
		end
	end
	if not IsValid(target) then
		return nil
	end
	return { target = target, direction = direction_to(caster, target) }
end

function boss_rush_hydraulic_waveform:CastFromBossAI(cast_data)
	local caster = self:GetCaster()
	if not cast_still_valid(caster) or type(cast_data) ~= "table" then
		return false
	end

	local params = get_params(self)
	local cast_duration = tonumber(params.cast_duration) or 0.7
	local line_length = tonumber(params.line_length) or 900
	local line_width = tonumber(params.line_width) or 220
	local movement_speed = tonumber(params.movement_speed) or 1250
	local damage_pct = tonumber(params.damage_pct) or 25
	local direction = cast_data.direction or direction_to(caster, cast_data.target)
	local origin = caster:GetAbsOrigin()

	begin_cast(caster, self, cast_duration, direction)

	local warning =
		ParticleManager:CreateParticle("particles/boss/boss_linear_range_finder.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(warning, 0, origin)
	ParticleManager:SetParticleControl(warning, 1, origin + direction * line_length)
	ParticleManager:SetParticleControl(warning, 2, Vector(line_width, 0, 0))

	Timers:CreateTimer(cast_duration, function()
		destroy_fx(warning)
		if not cast_still_valid(caster) then
			return nil
		end

		local launch_origin = caster:GetAbsOrigin()
		local target_position = launch_origin + direction * line_length

		ProjectileManager:ProjectileDodge(caster)
		EmitSoundOn("Hero_Morphling.Waveform", caster)

		caster:AddNewModifier(caster, self, "modifier_levelup_movement", {
			target_x = target_position.x,
			target_y = target_position.y,
			distance = line_length,
			speed = movement_speed,
		})

		if caster:HasModifier("modifier_levelup_movement") then
			caster:AddNewModifier(caster, self, "modifier_boss_rush_hydraulic_waveform", {
				duration = line_length / math.max(1, movement_speed) + FrameTime() * 2,
				direction_x = direction.x,
				direction_y = direction.y,
				speed = movement_speed,
				radius = line_width,
				damage_pct = damage_pct,
			})
		end
		return nil
	end)

	return true
end

--[[ ===================== 4. Bristleback - Quill Overload ===================== ]]
-- Триггер по накопленному входящему урону (managed style, Вариант A).

function boss_rush_quill_overload:GetIntrinsicModifierName()
	return "modifier_boss_rush_quill_accumulator"
end

function boss_rush_quill_overload:FindBestCastTarget()
	local caster = self:GetCaster()
	if not IsValid(caster) or not combat_allows_cast(caster) then
		return nil
	end

	local params = get_params(self)
	local accumulator = caster:FindModifierByName("modifier_boss_rush_quill_accumulator")
	if not accumulator or not accumulator.GetAccumulated then
		return nil
	end

	local threshold = pct_damage(caster, params.damage_taken_threshold_pct_of_max_hp or 6)
	if threshold <= 0 or accumulator:GetAccumulated() < threshold then
		return nil
	end
	return { ready = true }
end

function boss_rush_quill_overload:CastFromBossAI(cast_data)
	local caster = self:GetCaster()
	if not cast_still_valid(caster) then
		return false
	end

	local params = get_params(self)
	local radius = tonumber(params.radius) or 550
	local damage_pct = tonumber(params.damage_pct) or 13

	local accumulator = caster:FindModifierByName("modifier_boss_rush_quill_accumulator")
	if accumulator and accumulator.ResetAccumulated then
		accumulator:ResetAccumulated()
	end

	self:StartCooldown(get_cooldown(self))

	local fx = ParticleManager:CreateParticle(
		"particles/econ/items/bristleback/bristleback_dark_carnival/bristleback_carnival_quill_spray.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControlEnt(
		fx,
		1,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(fx)
	EmitSoundOn("Hero_Bristleback.QuillSpray.Cast", caster)

	local victims = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, victim in ipairs(victims or {}) do
		if valid_enemy(victim) then
			apply_damage(caster, self, victim, damage_pct, "boss_rush_quill_overload")
			local hit = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_bristleback/bristleback_quill_spray_impact.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				victim
			)
			ParticleManager:ReleaseParticleIndex(hit)
			EmitSoundOn("Hero_Bristleback.QuillSpray.Target", victim)
		end
	end

	return true
end

--[[ ===================== 5. Oracle - Purifying Malfunction ===================== ]]
-- Delayed AOE на позиции игрока + разовая починка ближайшего damaged enemy-юнита.

function boss_rush_purifying_malfunction:FindBestCastTarget()
	local caster = self:GetCaster()
	if not IsValid(caster) or not combat_allows_cast(caster) then
		return nil
	end

	local heroes = find_hero_targets(caster, get_params(self).search_radius or 2000)
	if #heroes <= 0 then
		return nil
	end
	local target = heroes[RandomInt(1, #heroes)]
	return { target = target, position = target:GetAbsOrigin() }
end

function boss_rush_purifying_malfunction:CastFromBossAI(cast_data)
	local caster = self:GetCaster()
	if not cast_still_valid(caster) or type(cast_data) ~= "table" or not cast_data.position then
		return false
	end

	local params = get_params(self)
	local cast_duration = tonumber(params.cast_duration) or 1.0
	local radius = tonumber(params.radius) or 280
	local damage_pct = tonumber(params.damage_pct) or 20
	local heal_pct = tonumber(params.heal_pct_of_target_max_hp) or 4
	local heal_radius = tonumber(params.heal_search_radius) or 900
	local position = cast_data.position

	begin_cast(caster, self, 0.2, direction_to(caster, position))
	EmitSoundOnLocationWithCaster(position, "Hero_Oracle.PurifyingFlames.Cast", caster)

	local warning =
		ParticleManager:CreateParticle("particles/aoe_ability_boss/aoe_ability_boss.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(warning, 0, position)
	ParticleManager:SetParticleControl(warning, 2, Vector(radius, cast_duration, radius / math.max(0.1, cast_duration)))

	Timers:CreateTimer(cast_duration, function()
		destroy_fx(warning)
		if not cast_still_valid(caster) then
			return nil
		end

		local explosion =
			ParticleManager:CreateParticle("particles/aoe_ability_boss/explosion_aoe.vpcf", PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(explosion, 0, position)
		ParticleManager:SetParticleControl(explosion, 1, Vector(radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(explosion)
		EmitSoundOnLocationWithCaster(position, "Hero_Oracle.PurifyingFlames.Damage", caster)

		local victims = FindUnitsInRadius(
			caster:GetTeamNumber(),
			position,
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for _, victim in ipairs(victims or {}) do
			if valid_enemy(victim) then
				apply_damage(caster, self, victim, damage_pct, "boss_rush_purifying_malfunction")
			end
		end

		local allies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster:GetAbsOrigin(),
			nil,
			heal_radius,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_CLOSEST,
			false
		)
		for _, ally in ipairs(allies or {}) do
			if
				IsValid(ally)
				and ally:IsAlive()
				and ally._levelup_max_health
				and (tonumber(ally._levelup_current_health) or 0) < tonumber(ally._levelup_max_health)
			then
				heal_unit(ally, tonumber(ally._levelup_max_health) * heal_pct * 0.01)
				local hfx = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_oracle/oracle_purifying_flames.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					ally
				)
				ParticleManager:ReleaseParticleIndex(hfx)
				break
			end
		end
		return nil
	end)

	return true
end

--[[ ===================== 6. Tinker - Rocket Salvo ===================== ]]

function boss_rush_rocket_salvo:FindBestCastTarget()
	local caster = self:GetCaster()
	if not IsValid(caster) or not combat_allows_cast(caster) then
		return nil
	end

	local heroes = find_hero_targets(caster, get_params(self).search_radius or 2500)
	if #heroes <= 0 then
		return nil
	end

	local max_targets = #heroes
	if BossRushActivity and BossRushActivity.GetScalingPlayerCount then
		max_targets = math.min(max_targets, BossRushActivity:GetScalingPlayerCount())
	end

	local targets = {}
	for i = 1, math.min(max_targets, #heroes) do
		targets[i] = heroes[i]
	end
	if #targets <= 0 then
		return nil
	end
	return { targets = targets }
end

function boss_rush_rocket_salvo:CastFromBossAI(cast_data)
	local caster = self:GetCaster()
	if not cast_still_valid(caster) or type(cast_data) ~= "table" or type(cast_data.targets) ~= "table" then
		return false
	end

	local params = get_params(self)
	local projectile_speed = tonumber(params.projectile_speed) or 900
	local damage_pct = tonumber(params.damage_pct) or 20

	begin_cast(caster, self, 0.3, direction_to(caster, cast_data.targets[1]))
	EmitSoundOn("Hero_Tinker.Heat-Seeking_Missile", caster)

	for _, target in ipairs(cast_data.targets) do
		if valid_hero(target) then
			local rocket_token = next_tinker_rocket_token()
			local projectile = ProjectileManager:CreateTrackingProjectile({
				Target = target,
				Source = caster,
				Ability = self,
				EffectName = "particles/units/heroes/hero_tinker/tinker_missile.vpcf",
				iMoveSpeed = projectile_speed,
				bDodgeable = false,
				bReplaceExisting = false,
				ExtraData = {
					dmg_pct = damage_pct,
					rocket_token = rocket_token,
					target_entindex = target:entindex(),
				},
			})
			if projectile then
				target._boss_rush_tinker_missiles = target._boss_rush_tinker_missiles or {}
				target._boss_rush_tinker_missiles[rocket_token] = projectile
			end
		end
	end

	return true
end

function boss_rush_rocket_salvo:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then
		return true
	end

	local registered_target = target
	if not IsValid(registered_target) and extra_data and extra_data.target_entindex then
		local target_entindex = tonumber(extra_data.target_entindex)
		if target_entindex and target_entindex > 0 then
			registered_target = EntIndexToHScript(target_entindex)
		end
	end
	local rocket_was_registered = unregister_tinker_rocket(registered_target, extra_data and extra_data.rocket_token)
	if not rocket_was_registered then
		return true
	end

	local caster = self:GetCaster()
	if not IsValid(target) or not cast_still_valid(caster) then
		if location then
			local dud = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_tinker/tinker_missile_dud.vpcf",
				PATTACH_WORLDORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(dud, 0, location)
			ParticleManager:ReleaseParticleIndex(dud)
		end
		return true
	end

	if valid_hero(target) then
		apply_damage(caster, self, target, tonumber(extra_data and extra_data.dmg_pct) or 20, "boss_rush_rocket_salvo")
		local boom = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_tinker/tinker_missle_explosion.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(boom, 0, location or target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(boom)
		EmitSoundOnLocationWithCaster(
			location or target:GetAbsOrigin(),
			"Hero_Tinker.Heat-Seeking_Missile.Impact",
			caster
		)
	end
	return true
end

--[[ ===================== 7. Ringmaster - Wheel of Wonder (rework) ===================== ]]
-- Колесо летит linear projectile к точке у героев -> зона DoT/slow -> взрыв и stun.

function boss_rush_wheel_of_wonder:FindBestCastTarget()
	local caster = self:GetCaster()
	if not IsValid(caster) or not combat_allows_cast(caster) then
		return nil
	end
	if caster._boss_rush_wheel_active then
		return nil
	end -- одно колесо за раз

	local params = get_params(self)
	local heroes = find_hero_targets(caster, params.search_radius or 1800)
	if #heroes <= 0 then
		return nil
	end

	local hero = heroes[RandomInt(1, #heroes)]
	local origin = caster:GetAbsOrigin()
	local offset = hero:GetAbsOrigin() - origin
	offset.z = 0
	local dist = math.max(0.01, offset:Length2D())
	local dir = offset / dist
	dist = math.min(math.max(dist, tonumber(params.min_distance) or 700), tonumber(params.max_distance) or 1400)
	return { position = GetGroundPosition(origin + dir * dist, nil), direction = dir }
end

function boss_rush_wheel_of_wonder:CastFromBossAI(cast_data)
	local caster = self:GetCaster()
	if not cast_still_valid(caster) or type(cast_data) ~= "table" or not cast_data.position then
		return false
	end

	local params = get_params(self)
	local direction = cast_data.direction or direction_to(caster, cast_data.position)
	begin_cast(caster, self, 0.3, direction)
	EmitSoundOn("Hero_RingMaster.TheWheel.Cast", caster)
	EmitSoundOn("Hero_RingMaster.TheWheel.Projectile", caster)

	local origin = caster:GetAbsOrigin()
	local target_pos = cast_data.position
	local wheel_speed = tonumber(params.wheel_speed) or 650
	local path_width = tonumber(params.path_width) or 220
	local total_dist = math.max(1, (target_pos - origin):Length2D())

	caster._boss_rush_wheel_active = true

	ProjectileManager:CreateLinearProjectile({
		Source = caster,
		Ability = self,
		vSpawnOrigin = origin,
		fDistance = total_dist,
		fStartRadius = path_width,
		fEndRadius = path_width,
		vVelocity = direction * wheel_speed,
		bHasFrontalCone = false,
		bDeleteOnHit = false,
		bProvidesVision = false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		EffectName = "particles/units/heroes/hero_ringmaster/ringmaster_wheel_projectile_linear.vpcf",
		ExtraData = {
			wheel_projectile = 1,
			target_x = target_pos.x,
			target_y = target_pos.y,
			target_z = target_pos.z,
		},
	})

	return true
end

function boss_rush_wheel_of_wonder:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then
		return false
	end
	if tonumber(extra_data and extra_data.wheel_projectile) ~= 1 then
		return false
	end

	-- Враги не блокируют колесо и не получают эффект во время полёта.
	if IsValid(target) then
		return false
	end

	local caster = self:GetCaster()
	if not cast_still_valid(caster) then
		if IsValid(caster) then
			caster._boss_rush_wheel_active = nil
		end
		return true
	end

	local fallback = location or caster:GetAbsOrigin()
	local position = Vector(
		tonumber(extra_data.target_x) or fallback.x,
		tonumber(extra_data.target_y) or fallback.y,
		tonumber(extra_data.target_z) or fallback.z
	)
	self:DeployWheelZone(caster, GetGroundPosition(position, nil))
	return true
end

-- Зона колеса: invuln-dummy + modifier_boss_rush_wheel_zone (DoT/slow + взрыв в OnDestroy).
function boss_rush_wheel_of_wonder:DeployWheelZone(caster, position)
	if not IsValid(caster) then
		return
	end

	local dummy = CreateUnitByName("npc_dota_companion", position, false, nil, nil, caster:GetTeamNumber())
	if not IsValid(dummy) then
		caster._boss_rush_wheel_active = nil
		return
	end
	dummy:SetAbsOrigin(position)
	dummy:AddNewModifier(caster, nil, "modifier_invulnerable", {})
	dummy:AddNewModifier(caster, nil, "modifier_phased", {})
	dummy:AddNewModifier(caster, nil, "modifier_no_healthbar", {})
	dummy:AddNewModifier(caster, nil, "modifier_not_on_minimap", {})
	dummy:AddNewModifier(caster, self, "modifier_boss_rush_wheel_zone", {
		duration = tonumber(get_params(self).duration) or 4.0,
		caster_index = caster:entindex(),
	})
end

--[[ ===================== Modifiers ===================== ]]

-- Дуэль на боссе: move/attack speed, force-attack только на боссе, victory bonus.
modifier_boss_rush_duel_protocol = class({})
function modifier_boss_rush_duel_protocol:IsHidden()
	return false
end
function modifier_boss_rush_duel_protocol:IsPurgable()
	return false
end
function modifier_boss_rush_duel_protocol:RemoveOnDeath()
	return true
end

function modifier_boss_rush_duel_protocol:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.caster = self:GetParent()
	local params = get_params(self:GetAbility())
	self.move_pct = tonumber(params.boss_move_speed_pct) or 0
	self.as_bonus = tonumber(params.boss_attack_speed_bonus) or 0
	self.damage_bonus_pct = tonumber(params.damage_bonus_pct_on_target_death) or 0
	self.damage_bonus_duration = tonumber(params.damage_bonus_duration) or 0
	self.target = kv and kv.target_entindex and EntIndexToHScript(kv.target_entindex) or nil
	self.rewarded = false

	if IsValid(self.target) then
		self.caster:SetForceAttackTarget(self.target)
	end
	local caster_origin = self.caster:GetAbsOrigin()
	local target_origin = self.target:GetAbsOrigin()
	self.fx = ParticleManager:CreateParticle(
		"particles/econ/items/legion/legion_dark_carnival/legion_duel_carnival_ring.vpcf",
		PATTACH_ABSORIGIN,
		self.caster
	)
	local center_point = (target_origin + caster_origin) * 0.5
	ParticleManager:SetParticleControl(self.fx, 0, center_point - Vector(75, 0, 0))
	ParticleManager:SetParticleControl(self.fx, 7, center_point - Vector(75, 0, 0))
	self:StartIntervalThink(0.25)
end

function modifier_boss_rush_duel_protocol:OnIntervalThink()
	if not IsServer() then
		return
	end
	if
		not IsValid(self.caster)
		or not self.caster:IsAlive()
		or (BossRushActivity and not BossRushActivity:IsActiveCombat())
	then
		self:Destroy()
		return
	end

	if IsValid(self.target) and self.target:IsAlive() then
		self.caster:SetForceAttackTarget(self.target)
	elseif not self.rewarded then
		self.rewarded = true
		if self.damage_bonus_pct > 0 and self.damage_bonus_duration > 0 then
			self.caster:AddNewModifier(self.caster, self:GetAbility(), "modifier_boss_rush_duel_damage_bonus", {
				duration = self.damage_bonus_duration,
				bonus_pct = self.damage_bonus_pct,
			})
		end
		EmitSoundOn("Hero_LegionCommander.Duel.Victory", self.caster)
		local vfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.caster
		)
		ParticleManager:ReleaseParticleIndex(vfx)
		self:Destroy()
	end
end

function modifier_boss_rush_duel_protocol:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end
function modifier_boss_rush_duel_protocol:GetModifierMoveSpeedBonus_Percentage()
	return self.move_pct or 0
end
function modifier_boss_rush_duel_protocol:GetModifierAttackSpeedBonus_Constant()
	return self.as_bonus or 0
end

function modifier_boss_rush_duel_protocol:OnDestroy()
	if not IsServer() then
		return
	end
	if IsValid(self.caster) then
		StopSoundOn("Hero_LegionCommander.Duel", self.caster)
		self.caster:SetForceAttackTarget(nil)
	end
	destroy_fx(self.fx)
	self.fx = nil
	self.target = nil
end

-- Временный бонус урона боссу после смерти duel-цели (масштабирует custom attack).
modifier_boss_rush_duel_damage_bonus = class({})
function modifier_boss_rush_duel_damage_bonus:IsHidden()
	return false
end
function modifier_boss_rush_duel_damage_bonus:IsPurgable()
	return false
end
function modifier_boss_rush_duel_damage_bonus:RemoveOnDeath()
	return true
end

function modifier_boss_rush_duel_damage_bonus:OnCreated(kv)
	if not IsServer() then
		return
	end
	local boss = self:GetParent()
	local mult = 1 + (tonumber(kv and kv.bonus_pct) or 0) / 100
	if not boss._boss_rush_duel_damage_applied and boss._levelup_custom_attack_damage_min then
		boss._boss_rush_duel_damage_orig_min = boss._levelup_custom_attack_damage_min
		boss._boss_rush_duel_damage_orig_max = boss._levelup_custom_attack_damage_max
		boss._levelup_custom_attack_damage_min = math.floor(boss._levelup_custom_attack_damage_min * mult)
		boss._levelup_custom_attack_damage_max =
			math.floor((boss._levelup_custom_attack_damage_max or boss._levelup_custom_attack_damage_min) * mult)
		boss._boss_rush_duel_damage_applied = true
	end
end

function modifier_boss_rush_duel_damage_bonus:OnDestroy()
	if not IsServer() then
		return
	end
	local boss = self:GetParent()
	if IsValid(boss) and boss._boss_rush_duel_damage_applied then
		boss._levelup_custom_attack_damage_min = boss._boss_rush_duel_damage_orig_min
		boss._levelup_custom_attack_damage_max = boss._boss_rush_duel_damage_orig_max
		boss._boss_rush_duel_damage_applied = nil
		boss._boss_rush_duel_damage_orig_min = nil
		boss._boss_rush_duel_damage_orig_max = nil
	end
end

-- Аккумулятор входящего урона для Quill Overload (intrinsic на Bristleback).
modifier_boss_rush_quill_accumulator = class({})
function modifier_boss_rush_quill_accumulator:IsHidden()
	return true
end
function modifier_boss_rush_quill_accumulator:IsPurgable()
	return false
end
function modifier_boss_rush_quill_accumulator:RemoveOnDeath()
	return true
end

function modifier_boss_rush_quill_accumulator:OnCreated()
	self.accumulated = 0
end

function modifier_boss_rush_quill_accumulator:OnLevelUpCustomDamageTaken(event)
	if not IsServer() then
		return
	end
	self.accumulated = (self.accumulated or 0) + math.max(0, tonumber(event and event.damage) or 0)
end

function modifier_boss_rush_quill_accumulator:GetAccumulated()
	return self.accumulated or 0
end

function modifier_boss_rush_quill_accumulator:ResetAccumulated()
	self.accumulated = 0
end

--[[ ----- Legion: Overwhelming Odds (active AOE around self) ----- ]]
function boss_rush_overwhelming_odds:FindBestCastTarget()
	local caster = self:GetCaster()
	if not IsValid(caster) or not combat_allows_cast(caster) then
		return nil
	end
	if #find_enemy_targets(caster, caster:GetAbsOrigin(), get_params(self).radius or 500) <= 0 then
		return nil
	end
	return { center = caster:GetAbsOrigin() }
end

function boss_rush_overwhelming_odds:CastFromBossAI(cast_data)
	local caster = self:GetCaster()
	if not cast_still_valid(caster) then
		return false
	end

	local params = get_params(self)
	local radius = tonumber(params.radius) or 500
	local cast_duration = tonumber(params.cast_duration) or 0.3
	begin_cast(caster, self, cast_duration, caster:GetForwardVector())

	local warn = ParticleManager:CreateParticle(
		"particles/aoe_ability_boss/aoe_ability_boss.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(warn, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(warn, 2, Vector(radius, cast_duration, radius / math.max(0.1, cast_duration)))

	EmitSoundOn("Hero_LegionCommander.Overwhelming.Cast", caster)

	Timers:CreateTimer(cast_duration, function()
		destroy_fx(warn)
		if not cast_still_valid(caster) then
			return nil
		end

		local enemies = find_enemy_targets(caster, caster:GetAbsOrigin(), radius)
		local counted = math.min(#enemies, tonumber(params.max_counted_enemies) or 8)
		local total_pct = (tonumber(params.base_damage_pct) or 20)
			+ counted * (tonumber(params.damage_pct_per_enemy) or 8)

		local impact = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_legion_commander/legion_commander_carnival_odds.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(impact, 0, caster:GetAbsOrigin())
		ParticleManager:SetParticleControl(impact, 3, Vector(radius, radius, radius))
		ParticleManager:SetParticleControl(impact, 4, Vector(radius, radius, radius))
		ParticleManager:SetParticleControl(impact, 5, Vector(radius, radius, radius))
		ParticleManager:SetParticleControl(impact, 6, Vector(radius, radius, radius))
		ParticleManager:ReleaseParticleIndex(impact)
		EmitSoundOn("Hero_LegionCommander.Overwhelming.Location", caster)

		for _, v in ipairs(enemies) do
			apply_damage(caster, self, v, total_pct, "boss_rush_overwhelming_odds")
		end

		local bonus_as = math.min(
			counted * (tonumber(params.attack_speed_bonus_per_enemy) or 12),
			tonumber(params.max_attack_speed_bonus) or 96
		)
		if bonus_as > 0 then
			caster:AddNewModifier(caster, self, "modifier_boss_rush_overwhelming_odds_haste", {
				duration = tonumber(params.attack_speed_bonus_duration) or 5.0,
				as_bonus = bonus_as,
			})
		end
		return nil
	end)

	return true
end

--[[ ----- Axe: Counter Helix (passive, every 8 received attacks) ----- ]]
function boss_rush_counter_helix:GetIntrinsicModifierName()
	return "modifier_boss_rush_counter_helix"
end
function boss_rush_counter_helix:FindBestCastTarget()
	return nil
end
function boss_rush_counter_helix:CastFromBossAI(cast_data)
	return false
end

--[[ ----- Morphling: Adaptive Strike Multi (passive, every 6 attacks) ----- ]]
function boss_rush_adaptive_strike_multi:GetIntrinsicModifierName()
	return "modifier_boss_rush_adaptive_strike_multi"
end
function boss_rush_adaptive_strike_multi:FindBestCastTarget()
	return nil
end
function boss_rush_adaptive_strike_multi:CastFromBossAI(cast_data)
	return false
end

function boss_rush_adaptive_strike_multi:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then
		return true
	end
	local caster = self:GetCaster()
	if not IsValid(target) or not cast_still_valid(caster) then
		return true
	end
	if valid_enemy(target) then
		local impact_position = target:GetAbsOrigin()
		EmitSoundOnLocationWithCaster(impact_position, "Hero_Morphling.AdaptiveStrikeAgi.Target", caster)

		local impact_fx = LevelUpParticleManager:CreateParticle(
			"particles/econ/items/morphling/morphling_ethereal/morphling_adaptive_strike_ethereal.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		LevelUpParticleManager:SetParticleControl(impact_fx, 0, caster:GetAbsOrigin())
		LevelUpParticleManager:SetParticleControl(impact_fx, 1, impact_position)
		LevelUpParticleManager:ReleaseParticleIndex(impact_fx)

		apply_damage(
			caster,
			self,
			target,
			tonumber(extra_data and extra_data.damage_pct) or 0,
			"boss_rush_adaptive_strike_multi"
		)
	end
	return true
end

--[[ ----- Bristleback: Viscous Nasal Goo (active projectile, stacking debuff) ----- ]]
function boss_rush_viscous_nasal_goo:FindBestCastTarget()
	local caster = self:GetCaster()
	if not IsValid(caster) or not combat_allows_cast(caster) then
		return nil
	end

	local search = get_params(self).search_radius or 1200
	-- приоритет: real hero без stacks > real hero с минимумом stacks > ближайший assistant/summon
	local best, best_stacks
	for _, h in ipairs(find_hero_targets(caster, search)) do
		local m = h:FindModifierByName("modifier_boss_rush_viscous_nasal_goo")
		local st = m and m:GetStackCount() or 0
		if best == nil or st < best_stacks then
			best, best_stacks = h, st
		end
		if st == 0 then
			break
		end
	end
	if IsValid(best) then
		return { target = best }
	end

	local enemies = find_enemy_targets(caster, caster:GetAbsOrigin(), search)
	if #enemies > 0 then
		return { target = enemies[1] }
	end
	return nil
end

function boss_rush_viscous_nasal_goo:CastFromBossAI(cast_data)
	local caster = self:GetCaster()
	local target = cast_data and cast_data.target
	if not cast_still_valid(caster) or not valid_enemy(target) then
		return false
	end

	local params = get_params(self)
	begin_cast(caster, self, 0.25, direction_to(caster, target))
	EmitSoundOn("Hero_Bristleback.ViscousGoo.Cast", caster)

	ProjectileManager:CreateTrackingProjectile({
		Target = target,
		Source = caster,
		Ability = self,
		EffectName = "particles/econ/items/bristleback/bristleback_dark_carnival/bristleback_carnival_nasal_goo_proj.vpcf",
		iMoveSpeed = tonumber(params.projectile_speed) or 1000,
		bDodgeable = false,
		bReplaceExisting = false,
		ExtraData = { dur = tonumber(params.duration) or 6.0 },
	})
	return true
end

function boss_rush_viscous_nasal_goo:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then
		return true
	end
	local caster = self:GetCaster()
	if not IsValid(target) or not cast_still_valid(caster) then
		return true
	end
	if valid_enemy(target) then
		target:AddNewModifier(caster, self, "modifier_boss_rush_viscous_nasal_goo", {
			duration = tonumber(extra_data and extra_data.dur) or 6.0,
		})
		EmitSoundOn("Hero_Bristleback.ViscousGoo.Target", target)
	end
	return true
end

--[[ ----- Oracle: False Promise Self (defensive, delays own incoming damage) ----- ]]
function boss_rush_false_promise_self:FindBestCastTarget()
	local caster = self:GetCaster()
	if not IsValid(caster) or not combat_allows_cast(caster) then
		return nil
	end
	if caster:HasModifier("modifier_boss_rush_false_promise_self") then
		return nil
	end
	if hp_pct(caster) > (tonumber(get_params(self).health_threshold_pct) or 70) then
		return nil
	end
	return { target = caster }
end

function boss_rush_false_promise_self:CastFromBossAI(cast_data)
	local caster = self:GetCaster()
	if not cast_still_valid(caster) then
		return false
	end

	local params = get_params(self)
	begin_cast(caster, self, 0.3, caster:GetForwardVector())
	EmitSoundOn("Hero_Oracle.FalsePromise.Cast", caster)
	local cfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_oracle/oracle_false_promise_cast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(cfx, 2, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(cfx)

	local cfx2 = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_oracle/oracle_false_promise_cast_enemy.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:ReleaseParticleIndex(cfx2)

	caster:AddNewModifier(caster, self, "modifier_boss_rush_false_promise_self", {
		duration = tonumber(params.duration) or 10.0,
	})
	return true
end

--[[ ----- Tinker: Laser (active single-target pure damage + blind) ----- ]]
function boss_rush_laser:FindBestCastTarget()
	local caster = self:GetCaster()
	if not IsValid(caster) or not combat_allows_cast(caster) then
		return nil
	end
	local heroes = find_hero_targets(caster, get_params(self).search_radius or 1200)
	if #heroes <= 0 then
		return nil
	end
	return { target = heroes[RandomInt(1, #heroes)] }
end

function boss_rush_laser:CastFromBossAI(cast_data)
	local caster = self:GetCaster()
	local target = cast_data and cast_data.target
	if not cast_still_valid(caster) or not valid_hero(target) then
		return false
	end

	local params = get_params(self)
	local cast_duration = tonumber(params.cast_duration) or 0.3
	local damage_pct = tonumber(params.damage_pct) or 30
	local target_index = target:entindex()

	begin_cast(caster, self, cast_duration, direction_to(caster, target))
	EmitSoundOn("Hero_Tinker.LaserAnim", caster)

	Timers:CreateTimer(cast_duration, function()
		if not cast_still_valid(caster) then
			return nil
		end
		local victim = EntIndexToHScript(target_index)
		if not valid_hero(victim) then
			return nil
		end

		local fx = ParticleManager:CreateParticle(
			"particles/econ/items/tinker/tinker_ti10_immortal_laser/tinker_ti10_immortal_laser.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			caster
		)
		ParticleManager:SetParticleControlEnt(
			fx,
			9,
			caster,
			PATTACH_POINT_FOLLOW,
			"attach_hand1",
			caster:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			fx,
			1,
			victim,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			victim:GetAbsOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(fx)
		EmitSoundOn("Hero_Tinker.Laser", caster)
		EmitSoundOn("Hero_Tinker.LaserImpact", victim)

		apply_damage(caster, self, victim, damage_pct, "boss_rush_laser")
		victim:AddNewModifier(caster, self, "modifier_boss_rush_laser_blind", {
			duration = tonumber(params.miss_duration) or 2.0,
			miss_pct = tonumber(params.miss_pct) or 100,
		})
		return nil
	end)

	return true
end

--[[ ----- Ringmaster: Impalement Arts (active line projectile + bleed) ----- ]]
function boss_rush_impalement_arts:FindBestCastTarget()
	local caster = self:GetCaster()
	if not IsValid(caster) or not combat_allows_cast(caster) then
		return nil
	end

	local search = get_params(self).search_radius or 1600
	local heroes = find_hero_targets(caster, search)
	local target = #heroes > 0 and heroes[RandomInt(1, #heroes)] or nil
	if not IsValid(target) then
		target = find_enemy_targets(caster, caster:GetAbsOrigin(), search)[1]
	end
	if not IsValid(target) then
		return nil
	end
	return { target = target, direction = direction_to(caster, target) }
end

function boss_rush_impalement_arts:CastFromBossAI(cast_data)
	local caster = self:GetCaster()
	if not cast_still_valid(caster) or type(cast_data) ~= "table" then
		return false
	end

	local params = get_params(self)
	local direction = cast_data.direction or direction_to(caster, cast_data.target)
	begin_cast(caster, self, 0.2, direction)
	EmitSoundOn("Hero_RingMaster.Impalement.Cast", caster)

	local width = tonumber(params.projectile_width) or 110
	ProjectileManager:CreateLinearProjectile({
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),
		fDistance = tonumber(params.projectile_distance) or 2000,
		fStartRadius = width,
		fEndRadius = width,
		vVelocity = direction * (tonumber(params.projectile_speed) or 1200),
		bDeleteOnHit = params.delete_on_hit ~= false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		EffectName = "particles/units/heroes/hero_ringmaster/ringmaster_wheel_dagger.vpcf",
		ExtraData = {
			impact = boss_attack_damage(caster) * (tonumber(params.impact_damage_pct) or 135) / 100,
		},
	})
	return true
end

function boss_rush_impalement_arts:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then
		return true
	end
	local caster = self:GetCaster()
	if not IsValid(target) or not target:IsAlive() then
		return true
	end
	if not cast_still_valid(caster) then
		return true
	end

	if valid_enemy(target) then
		apply_flat_damage(
			caster,
			self,
			target,
			tonumber(extra_data and extra_data.impact) or 0,
			"boss_rush_impalement_arts"
		)
		target:AddNewModifier(caster, self, "modifier_boss_rush_impalement_bleed", {
			duration = tonumber(get_params(self).bleed_duration) or 4.0,
		})
		EmitSoundOn("Hero_RingMaster.Impalement.Target.Hero", target)
	end
	return true
end

-- Legion attack speed после Overwhelming Odds.
modifier_boss_rush_overwhelming_odds_haste = class({})
function modifier_boss_rush_overwhelming_odds_haste:IsHidden()
	return false
end
function modifier_boss_rush_overwhelming_odds_haste:IsPurgable()
	return false
end
function modifier_boss_rush_overwhelming_odds_haste:RemoveOnDeath()
	return true
end
function modifier_boss_rush_overwhelming_odds_haste:OnCreated(kv)
	self.as_bonus = tonumber(kv and kv.as_bonus) or 0
end
function modifier_boss_rush_overwhelming_odds_haste:DeclareFunctions()
	return { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT }
end
function modifier_boss_rush_overwhelming_odds_haste:GetModifierAttackSpeedBonus_Constant()
	return self.as_bonus or 0
end

-- Axe Counter Helix: счётчик полученных атак, AOE pure damage каждые N.
modifier_boss_rush_counter_helix = class({})
function modifier_boss_rush_counter_helix:IsHidden()
	return true
end
function modifier_boss_rush_counter_helix:IsPurgable()
	return false
end
function modifier_boss_rush_counter_helix:RemoveOnDeath()
	return true
end
function modifier_boss_rush_counter_helix:OnCreated()
	self.count = 0
end
function modifier_boss_rush_counter_helix:OnLevelUpCustomDamageTaken(event)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	if not IsValid(caster) or not caster:IsAlive() then
		return
	end
	if not is_active_combat() and not caster.levelup_boss_rush_debug then
		return
	end

	local kind = event and event.damage_kind
	if kind ~= "physical_attack" and kind ~= "magical_attack" then
		return
	end
	local attacker = event and event.attacker
	if not IsValid(attacker) then
		return
	end
	if attacker:GetUnitName() == "npc_levelup_main_building" then
		return
	end

	self.count = (self.count or 0) + 1
	local p = get_params(self:GetAbility())
	if self.count < (tonumber(p.attacks_to_trigger) or 8) then
		return
	end
	self.count = 0

	caster:StartGesture(ACT_DOTA_CAST_ABILITY_3)
	local fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_axe/axe_counterhelix.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:ReleaseParticleIndex(fx)
	EmitSoundOn("Hero_Axe.CounterHelix", caster)

	local pct = tonumber(p.pure_damage_pct) or 20
	for _, v in ipairs(find_enemy_targets(caster, caster:GetAbsOrigin(), tonumber(p.radius) or 400)) do
		apply_damage(caster, self:GetAbility(), v, pct, "boss_rush_counter_helix")
	end
end

-- Morphling Waveform: invulnerability and path damage paired with the shared movement controller.
modifier_boss_rush_hydraulic_waveform = class({})
function modifier_boss_rush_hydraulic_waveform:IsHidden()
	return true
end
function modifier_boss_rush_hydraulic_waveform:IsPurgable()
	return false
end
function modifier_boss_rush_hydraulic_waveform:RemoveOnDeath()
	return true
end

function modifier_boss_rush_hydraulic_waveform:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end

function modifier_boss_rush_hydraulic_waveform:OnCreated(kv)
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	local direction = Vector(tonumber(kv and kv.direction_x) or 0, tonumber(kv and kv.direction_y) or 0, 0)
	if direction:Length2D() <= 0.01 then
		direction = parent:GetForwardVector()
		direction.z = 0
	end

	self.direction = direction:Normalized()
	self.speed = tonumber(kv and kv.speed) or 1250
	self.radius = tonumber(kv and kv.radius) or 220
	self.damage_pct = tonumber(kv and kv.damage_pct) or 25
	self.hit_targets = {}
	self.last_position = parent:GetAbsOrigin()

	self.pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_morphling/morphling_waveform.vpcf",
		PATTACH_CUSTOMORIGIN,
		parent
	)
	local pfx_pos = parent:GetAbsOrigin() + parent:GetUpVector() * 50
	ParticleManager:SetParticleControl(self.pfx, 0, pfx_pos)
	ParticleManager:SetParticleControl(self.pfx, 1, self.direction * self.speed)
	self:AddParticle(self.pfx, false, false, 15, false, false)

	self:DamageEnemiesAlongPath(self.last_position, self.last_position)
	self:StartIntervalThink(FrameTime())
end

function modifier_boss_rush_hydraulic_waveform:OnLevelUpCustomIncomingDamage(damage, event)
	if not IsServer() then
		return damage
	end
	return 0
end

function modifier_boss_rush_hydraulic_waveform:DamageEnemiesAlongPath(from_position, to_position)
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end

	local victims
	if (to_position - from_position):Length2D() <= 0.01 then
		victims = find_enemy_targets(parent, to_position, self.radius)
	else
		victims = FindUnitsInLine(
			parent:GetTeamNumber(),
			from_position,
			to_position,
			nil,
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE
		)
	end

	for _, victim in ipairs(victims or {}) do
		if valid_enemy(victim) then
			local entindex = victim:entindex()
			if not self.hit_targets[entindex] then
				self.hit_targets[entindex] = true
				apply_damage(parent, self:GetAbility(), victim, self.damage_pct, "boss_rush_hydraulic_waveform")
			end
		end
	end
end

function modifier_boss_rush_hydraulic_waveform:OnIntervalThink()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	if not cast_still_valid(parent) then
		self:Destroy()
		return
	end

	local current_position = parent:GetAbsOrigin()
	self:DamageEnemiesAlongPath(self.last_position or current_position, current_position)
	self.last_position = current_position

	if not parent:HasModifier("modifier_levelup_movement") then
		self:Destroy()
	end
end

function modifier_boss_rush_hydraulic_waveform:OnDestroy()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	if IsValid(parent) and parent:HasModifier("modifier_levelup_movement") then
		parent:RemoveModifierByName("modifier_levelup_movement")
	end

	self.hit_targets = nil
	self.pfx = nil
end

-- Morphling Adaptive Strike Multi: счётчик атак боссом, multi tracking-проджектайлы каждые N.
modifier_boss_rush_adaptive_strike_multi = class({})
function modifier_boss_rush_adaptive_strike_multi:IsHidden()
	return true
end
function modifier_boss_rush_adaptive_strike_multi:IsPurgable()
	return false
end
function modifier_boss_rush_adaptive_strike_multi:RemoveOnDeath()
	return true
end
function modifier_boss_rush_adaptive_strike_multi:OnCreated()
	self.count = 0
end
function modifier_boss_rush_adaptive_strike_multi:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end
function modifier_boss_rush_adaptive_strike_multi:OnAttackLanded(params)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	if params.attacker ~= caster then
		return
	end
	if not IsValid(caster) or not caster:IsAlive() then
		return
	end
	if not is_active_combat() and not caster.levelup_boss_rush_debug then
		return
	end
	if not valid_enemy(params.target) then
		return
	end

	self.count = (self.count or 0) + 1
	local p = get_params(self:GetAbility())
	if self.count < (tonumber(p.attacks_to_trigger) or 6) then
		return
	end
	self.count = 0

	local ability = self:GetAbility()
	local pc = (
		BossRushActivity
		and BossRushActivity.GetScalingPlayerCount
		and BossRushActivity:GetScalingPlayerCount()
	) or 1
	local target_count = pc <= 2 and (tonumber(p.target_count_1_2_players) or 3)
		or (tonumber(p.target_count_3_4_players) or 4)
	local projectile_speed = tonumber(p.projectile_speed) or 1100
	local damage_pct = tonumber(p.damage_pct) or 20

	local fired = 0
	local selected_targets = {}
	for _, v in ipairs(find_enemy_targets(caster, caster:GetAbsOrigin(), tonumber(p.search_radius) or 1000)) do
		if fired >= target_count then
			break
		end
		local entindex = v:entindex()
		if not selected_targets[entindex] then
			selected_targets[entindex] = true
			fired = fired + 1

			local projectile = ProjectileManager:CreateTrackingProjectile({
				Target = v,
				Source = caster,
				Ability = ability,
				vSourceLoc = GetProjectileFxSourceOrigin(caster),
				iMoveSpeed = projectile_speed,
				bDodgeable = false,
				bReplaceExisting = false,
				bProvidesVision = false,
				ExtraData = { damage_pct = damage_pct },
			})

			CreateProjectileFx(
				caster,
				projectile,
				"particles/units/heroes/hero_morphling/morphling_adaptive_strike_agi_proj.vpcf",
				{
					target = v,
					speed = projectile_speed,
				}
			)
		end
	end

	if fired > 0 then
		EmitSoundOn("Hero_Morphling.AdaptiveStrikeAgi.Cast", caster)
	end
end

-- Bristleback Viscous Nasal Goo: стек armor reduction + slow, refresh duration, cap.
modifier_boss_rush_viscous_nasal_goo = class({})
function modifier_boss_rush_viscous_nasal_goo:IsHidden()
	return false
end
function modifier_boss_rush_viscous_nasal_goo:IsPurgable()
	return false
end
function modifier_boss_rush_viscous_nasal_goo:RemoveOnDeath()
	return true
end

function modifier_boss_rush_viscous_nasal_goo:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self:ApplyArmor()
	local p = ParticleManager:CreateParticle(
		"particles/econ/items/bristleback/bristleback_dark_carnival/bristleback_carnival_nasal_goo_debuff.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	self:AddParticle(p, false, false, -1, false, false)
end
function modifier_boss_rush_viscous_nasal_goo:OnRefresh()
	if not IsServer() then
		return
	end
	local limit = tonumber(get_params(self:GetAbility()).stack_limit) or 6
	self:SetStackCount(math.min(limit, self:GetStackCount() + 1))
	self:ApplyArmor()
end
function modifier_boss_rush_viscous_nasal_goo:ApplyArmor()
	local p = get_params(self:GetAbility())
	local stacks = self:GetStackCount()
	local armor_red = (tonumber(p.base_armor_reduction) or 10)
		+ (stacks - 1) * (tonumber(p.armor_reduction_per_stack) or 5)
	local target = self:GetParent()
	if target:IsRealHero() and target.LevelUpSetCustomStatsBonus then
		target:LevelUpSetCustomStatsBonus("boss_rush_viscous_goo", { armor = -armor_red }, "base")
	elseif target._levelup_custom_armor ~= nil then
		self._base_armor = self._base_armor or tonumber(target._levelup_custom_armor) or 0
		target._levelup_custom_armor = self._base_armor - armor_red
	end
end
function modifier_boss_rush_viscous_nasal_goo:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end
function modifier_boss_rush_viscous_nasal_goo:GetModifierMoveSpeedBonus_Percentage()
	local p = get_params(self:GetAbility())
	local stacks = self:GetStackCount()
	return -((tonumber(p.base_slow_pct) or 12) + (stacks - 1) * (tonumber(p.slow_pct_per_stack) or 4))
end
function modifier_boss_rush_viscous_nasal_goo:OnDestroy()
	if not IsServer() then
		return
	end
	local target = self:GetParent()
	if not IsValid(target) then
		return
	end
	if target:IsRealHero() and target.LevelUpSetCustomStatsBonus then
		target:LevelUpSetCustomStatsBonus("boss_rush_viscous_goo", { armor = 0 }, "base")
	elseif self._base_armor ~= nil and target._levelup_custom_armor ~= nil then
		target._levelup_custom_armor = self._base_armor
	end
end

-- Oracle False Promise Self: поглощает входящий урон, возвращает 50% при истечении.
modifier_boss_rush_false_promise_self = class({})
function modifier_boss_rush_false_promise_self:IsHidden()
	return false
end
function modifier_boss_rush_false_promise_self:IsPurgable()
	return false
end
function modifier_boss_rush_false_promise_self:RemoveOnDeath()
	return true
end

function modifier_boss_rush_false_promise_self:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.total = 0
	self.by_attacker = {}
	self.fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_oracle/oracle_false_promise_indicator.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
	EmitSoundOn("Hero_Oracle.FalsePromise.Target", self:GetParent())
end

function modifier_boss_rush_false_promise_self:OnLevelUpCustomIncomingDamage(damage, event)
	if not IsServer() then
		return damage
	end
	damage = math.max(0, tonumber(damage) or 0)
	if damage <= 0 then
		return damage
	end

	self.total = (self.total or 0) + damage
	local key = (event and IsValid(event.attacker)) and event.attacker:entindex() or 0
	self.by_attacker[key] = (self.by_attacker[key] or 0) + damage
	return 0
end

function modifier_boss_rush_false_promise_self:OnDestroy()
	if not IsServer() then
		return
	end
	destroy_fx(self.fx)
	self.fx = nil

	local oracle = self:GetParent()

	if IsValid(oracle) then
		StopSoundOn("Hero_Oracle.FalsePromise.Target", oracle)
	end

	local dfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_oracle/oracle_false_promise_dmg.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		oracle
	)
	ParticleManager:ReleaseParticleIndex(dfx)

	local ability = self:GetAbility()
	local return_pct = tonumber(get_params(ability).delayed_damage_return_pct) or 50
	local by = self.by_attacker or {}
	self.total = 0
	self.by_attacker = {}

	Timers:CreateTimer(0, function()
		if not IsValid(oracle) or not oracle:IsAlive() then
			return nil
		end
		if BossRushActivity and not BossRushActivity:IsActiveCombat() and not oracle.levelup_boss_rush_debug then
			return nil
		end

		EmitSoundOn("Hero_Oracle.FalsePromise.Damaged", oracle)
		for key, amount in pairs(by) do
			local attacker = (key ~= 0) and EntIndexToHScript(key) or oracle
			local dmg = (tonumber(amount) or 0) * return_pct / 100
			if dmg > 0 then
				ApplyDamage({
					victim = oracle,
					attacker = IsValid(attacker) and attacker or oracle,
					ability = IsValid(ability) and ability or nil,
					damage = dmg,
					damage_type = DAMAGE_TYPE_PURE,
					damage_kind = "pure",
				}, "boss_rush_false_promise_self")
				if not oracle:IsAlive() then
					break
				end
			end
		end
		return nil
	end)
end

modifier_boss_rush_laser_blind = class({})
function modifier_boss_rush_laser_blind:IsHidden()
	return false
end
function modifier_boss_rush_laser_blind:IsPurgable()
	return true
end
function modifier_boss_rush_laser_blind:RemoveOnDeath()
	return true
end

function modifier_boss_rush_laser_blind:OnCreated(kv)
	self.miss_pct = tonumber(kv and kv.miss_pct) or 100
end

function modifier_boss_rush_laser_blind:DeclareFunctions()
	return { MODIFIER_PROPERTY_MISS_PERCENTAGE }
end
function modifier_boss_rush_laser_blind:GetModifierMiss_Percentage()
	return self.miss_pct or 0
end

modifier_boss_rush_impalement_bleed = class({})

function modifier_boss_rush_impalement_bleed:IsHidden()
	return false
end
function modifier_boss_rush_impalement_bleed:IsPurgable()
	return true
end
function modifier_boss_rush_impalement_bleed:RemoveOnDeath()
	return true
end

function modifier_boss_rush_impalement_bleed:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.tick = 1.0
	self.fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_dagger_target_bleed_parent.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	self:StartIntervalThink(self.tick)
end

function modifier_boss_rush_impalement_bleed:OnIntervalThink()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self:GetParent()
	if not is_active_combat() and not (IsValid(caster) and caster.levelup_boss_rush_debug) then
		self:Destroy()
		return
	end
	if not IsValid(caster) or not caster:IsAlive() or not IsValid(target) or not target:IsAlive() then
		return
	end

	EmitSoundOn("Hero_RingMaster.Impalement.Stab", target)

	local p = get_params(self:GetAbility())
	local dmg
	if target:IsRealHero() then
		dmg = pct_damage(target, (tonumber(p.bleed_max_health_damage_pct_per_second) or 3.0) * self.tick)
	else
		dmg = boss_attack_damage(caster) * (tonumber(p.bleed_flat_damage_pct_per_second) or 200) / 100 * self.tick
	end
	apply_flat_damage(caster, self:GetAbility(), target, dmg, "boss_rush_impalement_arts")
end

function modifier_boss_rush_impalement_bleed:OnDestroy()
	if not IsServer() then
		return
	end
	destroy_fx(self.fx)
	self.fx = nil
end

-- Ringmaster Wheel zone: persistent radius DoT/slow на dummy + взрыв в OnDestroy.
modifier_boss_rush_wheel_zone = class({})
function modifier_boss_rush_wheel_zone:IsHidden()
	return true
end
function modifier_boss_rush_wheel_zone:IsPurgable()
	return false
end
function modifier_boss_rush_wheel_zone:RemoveOnDeath()
	return true
end

function modifier_boss_rush_wheel_zone:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.caster = EntIndexToHScript(tonumber(kv and kv.caster_index) or 0)
	self.ability = self:GetAbility()
	local p = get_params(self.ability)
	self.radius = tonumber(p.radius) or 700
	self.tick = tonumber(p.tick_interval) or 0.5
	self.slow_pct = tonumber(p.slow_pct) or 50
	self.dps_pct = tonumber(p.damage_pct_per_second) or 8
	self.explosion_pct = tonumber(p.explosion_damage_pct) or 30
	self.explosion_stun_duration = tonumber(p.explosion_stun_duration) or 1.5

	local pos = self:GetParent():GetAbsOrigin()
	self.fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ringmaster/ringmaster_ult_custom.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(self.fx, 0, pos)
	ParticleManager:SetParticleControl(self.fx, 1, Vector(self.radius, self.radius, self.radius))
	ParticleManager:SetParticleControl(self.fx, 4, pos)
	self:StartIntervalThink(self.tick)
end

function modifier_boss_rush_wheel_zone:OnIntervalThink()
	if not IsServer() then
		return
	end
	local caster = self.caster
	local active = is_active_combat() or (IsValid(caster) and caster.levelup_boss_rush_debug)
	if not active or not IsValid(caster) or not caster:IsAlive() then
		self:Destroy()
		return
	end

	local pos = self:GetParent():GetAbsOrigin()
	for _, v in ipairs(find_enemy_targets(caster, pos, self.radius)) do
		apply_damage(caster, self.ability, v, self.dps_pct * self.tick, "boss_rush_wheel_of_wonder")
		v:AddNewModifier(caster, self.ability, "modifier_generic_slow_lua", {
			duration = self.tick + 0.1,
			slow_pct = self.slow_pct,
		})
	end
end

function modifier_boss_rush_wheel_zone:OnDestroy()
	if not IsServer() then
		return
	end
	destroy_fx(self.fx)
	self.fx = nil

	local parent = self:GetParent()
	local pos = IsValid(parent) and parent:GetAbsOrigin() or nil
	local caster = self.caster
	if IsValid(caster) then
		caster._boss_rush_wheel_active = nil
	end

	if pos and IsValid(caster) and caster:IsAlive() and combat_allows_cast(caster) then
		local efx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_ringmaster/ringmaster_wheel_aoe.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(efx, 0, pos)
		ParticleManager:SetParticleControl(efx, 1, Vector(self.radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(efx)
		EmitSoundOnLocationWithCaster(pos, "Hero_RingMaster.TheWheel.Destroy", caster)
		for _, v in ipairs(find_enemy_targets(caster, pos, self.radius)) do
			v:AddNewModifier(caster, self.ability, "modifier_generic_stunned_lua", {
				duration = self.explosion_stun_duration,
			})
			apply_damage(caster, self.ability, v, self.explosion_pct, "boss_rush_wheel_of_wonder")
		end
	end

	if IsValid(parent) then
		UTIL_Remove(parent)
	end
end