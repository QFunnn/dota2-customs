--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5a808f3 · 2026-08-08 04:09:05 UTC
  ~ auto-generated — do not edit
]]


--[[
    Спец-эффекты помощников (итерация 3), управляются конфигом item.special,
    который SpawnAssistant кладёт на юнит в поле unit.levelup_assistant_special.

    Поддерживаемые proc_trigger:
    - "assistant_attack_landed" / "assistant_attack_counter": счётчик атак на самом
      помощнике, каждая N-я атака -> эффект (с опциональным cooldown);
    - "while_assistant_alive": пока помощник жив, тик поддержки (golem -> здание);
    - "interval_while_enemy_available": раз в cooldown, если есть валидная цель.

    Эффекты (по effect_id):
    - assistant_training_archer_fifth_shot: доп. физ. урон по цели атаки;
    - assistant_flame_dragon_fire_breath:   AoE-урон вокруг цели;
    - assistant_void_dragoon_piercing_shot: урон по линии;
    - assistant_minor_golem_building_support: реген главному зданию пока жив.

    Весь урон идёт через ApplyDamage с attacker = помощник, поэтому killing
    credit (gold/xp/kills) уходит владельцу, а hero-only procs не триггерятся
    (помощник не герой; дополнительно гейтим CanAssistantTriggerAssistantSpecial).
]]
modifier_levelup_assistant_special = class({})

function modifier_levelup_assistant_special:IsHidden()
	return true
end
function modifier_levelup_assistant_special:IsPurgable()
	return false
end
function modifier_levelup_assistant_special:IsPurgeException()
	return false
end
function modifier_levelup_assistant_special:RemoveOnDeath()
	return false
end

local function get_assistant_damage(unit)
	local dmax = tonumber(unit._levelup_custom_attack_damage_max) or 0
	local dmin = tonumber(unit._levelup_custom_attack_damage_min) or dmax
	return math.max(0, (dmin + dmax) * 0.5)
end

function modifier_levelup_assistant_special:OnCreated()
	if not IsServer() then
		return
	end

	local unit = self:GetParent()
	self.special = unit.levelup_assistant_special
	self.player_id = tonumber(unit.levelup_assistant_owner_player_id) or GetLevelUpUnitOwnerPlayerID(unit) or -1
	self._cooldown_end = 0
	unit.levelup_assistant_attack_count = 0

	-- звезда компаньона - snapshot на ран, кешируем (способности скейлятся по ней)
	self.star = (
		AssistantManager
		and AssistantManager.GetAssistantStarLevel
		and AssistantManager:GetAssistantStarLevel(self.player_id)
	) or 1

	if type(self.special) ~= "table" then
		return
	end

	local trigger = tostring(self.special.proc_trigger or "")
	if trigger == "while_assistant_alive" then
		self:StartIntervalThink(1.0) -- поддержка здания: pct% от макс HP в секунду
	elseif trigger == "interval_while_enemy_available" then
		self:StartIntervalThink(0.5) -- проверяем кулдаун/наличие цели
	end
end

function modifier_levelup_assistant_special:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end

-- Скейл значения по звезде: base + per_star * (star - 1).
function modifier_levelup_assistant_special:Scaled(base, per_star)
	local s = math.max(1, tonumber(self.star) or 1)
	return (tonumber(base) or 0) + (tonumber(per_star) or 0) * (s - 1)
end

--[[ ---------- общий нанос урона с кредитом владельцу ---------- ]]

function modifier_levelup_assistant_special:DealDamage(unit, victim, amount, damage_type_str, is_aoe)
	if not IsValid(victim) or (tonumber(amount) or 0) <= 0 then
		return
	end

	local is_magical = tostring(damage_type_str or "magical") == "magical"
	if is_magical then
		amount = amount * (1 + (tonumber(unit.levelup_assistant_magic_damage_pct) or 0) * 0.01)
	end
	ApplyDamage({
		victim = victim,
		attacker = unit, -- кредит за килл -> владельцу помощника
		ability = nil,
		damage = amount,
		damage_type = is_magical and DAMAGE_TYPE_MAGICAL or DAMAGE_TYPE_PHYSICAL,
		damage_kind = is_magical and "magical_spell" or "physical_spell",
		is_aoe_damage = is_aoe == true,
	}, "assistant_special")
end

--[[ ---------- attack-based триггеры ---------- ]]

function modifier_levelup_assistant_special:OnAttackLanded(params)
	if not IsServer() then
		return
	end
	if type(self.special) ~= "table" then
		return
	end

	local unit = self:GetParent()
	if params.attacker ~= unit then
		return
	end
	if not IsValid(unit) or not unit:IsAlive() then
		return
	end
	if not CanAssistantTriggerAssistantSpecial(unit) then
		return
	end

	local trigger = tostring(self.special.proc_trigger or "")
	if trigger ~= "assistant_attack_landed" and trigger ~= "assistant_attack_counter" then
		return
	end

	local target = params.target
	-- Атака должна быть по ВРАГУ, но НЕ требуем, чтобы он был ещё жив: при one-shot
	-- к моменту нашего обработчика creep_base_handler уже добивает цель (victim:Kill
	-- синхронно), и строгая проверка "жив" роняла счётчик -> спецэффект не срабатывал.
	if not IsValid(target) then
		return
	end
	if target:GetTeamNumber() == unit:GetTeamNumber() then
		return
	end
	if target:GetTeamNumber() == DOTA_TEAM_NEUTRALS then
		return
	end

	local required = math.max(1, math.floor(tonumber(self.special.attacks_required) or 5))
	local count = (tonumber(unit.levelup_assistant_attack_count) or 0) + 1
	if count < required then
		unit.levelup_assistant_attack_count = count
		return
	end

	-- порог достигнут: уважаем cooldown, если задан
	local cooldown = tonumber(self.special.cooldown) or 0
	if cooldown > 0 and GameRules:GetGameTime() < (self._cooldown_end or 0) then
		unit.levelup_assistant_attack_count = required -- держим у порога, перепроверим со след. атакой
		return
	end

	unit.levelup_assistant_attack_count = 0
	if cooldown > 0 then
		self._cooldown_end = GameRules:GetGameTime() + cooldown
	end

	self:FireAttackEffect(unit, target)
end

function modifier_levelup_assistant_special:FireAttackEffect(unit, target)
	local effect_id = tostring(self.special.effect_id or "")
	if effect_id == "assistant_training_archer_fifth_shot" then
		self:DoBonusShot(unit, target)
	elseif effect_id == "assistant_flame_dragon_fire_breath" then
		self:DoFireBreath(unit, target)
	elseif effect_id == "assistant_pika_thunderbolt" then
		self:DoThunderbolt(unit, target)
	elseif effect_id == "assistant_meow_payday" then
		self:DoPayDay(unit, target)
	elseif effect_id == "assistant_slow_yawn" then
		self:DoSlow(unit, target)
	elseif effect_id == "assistant_bulba_leech_seed" then
		self:DoLeechSeed(unit, target)
	end
end

--[[ ---------- interval / while-alive триггеры ---------- ]]

function modifier_levelup_assistant_special:OnIntervalThink()
	if not IsServer() then
		return
	end
	if type(self.special) ~= "table" then
		return
	end

	local unit = self:GetParent()
	if not IsValid(unit) or not unit:IsAlive() then
		return
	end

	local trigger = tostring(self.special.proc_trigger or "")
	if trigger == "while_assistant_alive" then
		self:DoBuildingSupport(unit)
		return
	end

	if trigger == "interval_while_enemy_available" then
		if not CanAssistantTriggerAssistantSpecial(unit) then
			return
		end
		if GameRules:GetGameTime() < (self._cooldown_end or 0) then
			return
		end

		local effect_id = tostring(self.special.effect_id or "")
		if effect_id == "assistant_puff_burst" then
			-- взрыв вокруг себя: нужны враги в радиусе
			local radius = self:Scaled(self.special.radius, self.special.radius_per_star)
			if not self:HasEnemyNear(unit, radius) then
				return
			end
			self._cooldown_end = GameRules:GetGameTime() + (tonumber(self.special.cooldown) or 5.0)
			self:DoBurst(unit, radius)
		else
			-- линия (драгун): нужна направленная цель
			local target = self:ResolvePiercingTarget(unit)
			if not IsValid(target) then
				return
			end
			self._cooldown_end = GameRules:GetGameTime() + (tonumber(self.special.cooldown) or 6.0)
			self:DoPiercingShot(unit, target)
		end
	end
end

--[[ ---------- конкретные эффекты ---------- ]]

-- Учебный лучник: каждая 5-я атака - доп. физ. урон по цели.
function modifier_levelup_assistant_special:DoBonusShot(unit, target)
	if not IsValid(target) or not target:IsAlive() then
		return
	end
	local pct = tonumber(self.special.bonus_damage_pct_of_assistant_damage) or 0
	self:DealDamage(unit, target, get_assistant_damage(unit) * pct * 0.01, "physical", false)
end

-- Пламенный дракон: каждая 4-я атака - огненное дыхание (AoE вокруг цели). Скейл по звезде.
function modifier_levelup_assistant_special:DoFireBreath(unit, target)
	if not IsValid(target) then
		return
	end

	local radius = self:Scaled(self.special.radius, self.special.radius_per_star)
	local pct = self:Scaled(self.special.damage_pct_of_assistant_damage, self.special.damage_pct_per_star)
	local dmg = get_assistant_damage(unit) * pct * 0.01
	local center = target:GetAbsOrigin()

	local enemies = FindUnitsInRadius(
		unit:GetTeamNumber(),
		center,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)
	for _, enemy in ipairs(enemies or {}) do
		if AssistantManager and AssistantManager:IsValidAssistantTarget(unit, enemy, self.player_id) then
			self:DealDamage(unit, enemy, dmg, self.special.damage_type, true)
		end
	end

	local fx = LevelUpParticleManager:CreateParticle(
		"particles/units/heroes/hero_jakiro/jakiro_dual_breath_firebreath.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	LevelUpParticleManager:SetParticleControl(fx, 1, center)
	LevelUpParticleManager:SetParticleControl(fx, 3, center)
	LevelUpParticleManager:ReleaseParticleIndex(fx)
end

-- Призрачный драгун: пронизывающий снаряд по линии.
function modifier_levelup_assistant_special:DoPiercingShot(unit, target)
	if not IsValid(target) then
		return
	end

	local line_distance = tonumber(self.special.line_distance) or 900
	local line_width = tonumber(self.special.line_width) or 140
	local pct = tonumber(self.special.damage_pct_of_assistant_damage) or 0
	local dmg = get_assistant_damage(unit) * pct * 0.01

	local start_pos = unit:GetAbsOrigin()
	local dir = target:GetAbsOrigin() - start_pos
	dir.z = 0
	if dir:Length2D() < 1 then
		return
	end
	dir = dir:Normalized()
	local end_pos = start_pos + dir * line_distance

	local enemies = FindUnitsInLine(
		unit:GetTeamNumber(),
		start_pos,
		end_pos,
		nil,
		line_width,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		0
	)
	for _, enemy in ipairs(enemies or {}) do
		if AssistantManager and AssistantManager:IsValidAssistantTarget(unit, enemy, self.player_id) then
			self:DealDamage(unit, enemy, dmg, self.special.damage_type, true)
		end
	end

	local fx =
		LevelUpParticleManager:CreateParticle("particles/wraith_king/wk_ultimate_erupt.vpcf", PATTACH_WORLDORIGIN, nil)
	LevelUpParticleManager:SetParticleControl(fx, 0, start_pos)
	LevelUpParticleManager:SetParticleControl(fx, 1, end_pos)
	LevelUpParticleManager:ReleaseParticleIndex(fx)
end

-- Малый голем: пока жив, регенерирует главное здание владельца.
function modifier_levelup_assistant_special:DoBuildingSupport(unit)
	if not wave_manager or not wave_manager.GetMainBuilding then
		return
	end

	local building = wave_manager:GetMainBuilding()
	if not IsValid(building) or not building:IsAlive() then
		return
	end

	local pct = tonumber(self.special.building_health_regen_pct) or 0
	local max_hp = tonumber(building._levelup_max_health) or 0
	if pct <= 0 or max_hp <= 0 then
		return
	end

	local cur = tonumber(building._levelup_current_health) or 0
	if cur >= max_hp then
		return
	end

	if building.LevelUpModifyHealth then
		building:LevelUpModifyHealth(max_hp * pct * 0.01) -- think раз в 1.0с -> pct% в секунду
	end
end

--[[ ---------- покемон-способности (со скейлом по звезде) ---------- ]]

function modifier_levelup_assistant_special:FindChainNext(unit, pos, range, hit)
	local enemies = FindUnitsInRadius(
		unit:GetTeamNumber(),
		pos,
		nil,
		range,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		0,
		FIND_CLOSEST,
		false
	)
	for _, e in ipairs(enemies or {}) do
		if
			not hit[e:entindex()]
			and AssistantManager
			and AssistantManager:IsValidAssistantTarget(unit, e, self.player_id)
		then
			return e
		end
	end
	return nil
end

function modifier_levelup_assistant_special:ArcFx(from_ent, to_ent, is_head)
	if not IsValid(from_ent) or not IsValid(to_ent) then
		return
	end
	local from_attach = is_head and "attach_attack1" or "attach_hitloc"
	local fx =
		LevelUpParticleManager:CreateParticle("particles/companions/pika_arc_.vpcf", PATTACH_ABSORIGIN_FOLLOW, from_ent)
	LevelUpParticleManager:SetParticleControlEnt(
		fx,
		0,
		from_ent,
		PATTACH_POINT_FOLLOW,
		from_attach,
		from_ent:GetAbsOrigin(),
		true
	)
	LevelUpParticleManager:SetParticleControlEnt(
		fx,
		1,
		to_ent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		to_ent:GetAbsOrigin(),
		true
	)
	LevelUpParticleManager:ReleaseParticleIndex(fx)
end

-- Пикачу: цепная молния.
function modifier_levelup_assistant_special:DoThunderbolt(unit, target)
	if not IsValid(target) then
		return
	end

	local jumps = math.max(1, math.floor(self:Scaled(self.special.jumps, self.special.jumps_per_star)))
	local jump_range = tonumber(self.special.jump_range) or 500
	local jump_delay = math.max(0.05, tonumber(self.special.jump_delay) or 0.2)
	local pct = self:Scaled(self.special.damage_pct_of_assistant_damage, self.special.damage_pct_per_star)
	local dmg = get_assistant_damage(unit) * pct * 0.01
	local player_id = self.player_id

	local start = target
	if
		not (target:IsAlive() and AssistantManager and AssistantManager:IsValidAssistantTarget(unit, target, player_id))
	then
		start = self:FindChainNext(unit, target:GetAbsOrigin(), jump_range, {})
	end
	if not IsValid(start) then
		return
	end

	unit:EmitSound("Hero_Zuus.ArcLightning.Cast")
	self:ArcFx(unit, start, true)
	self:DealDamage(unit, start, dmg, "magical", true)

	local hit = { [start:entindex()] = true }
	local current = start
	local previous = nil
	local remaining = jumps - 1
	if remaining <= 0 then
		return
	end

	Timers:CreateTimer(jump_delay, function()
		if not IsValid(unit) or not IsValid(current) or remaining <= 0 then
			return nil
		end

		local next_enemy = nil
		local enemies = FindUnitsInRadius(
			unit:GetTeamNumber(),
			current:GetAbsOrigin(),
			nil,
			jump_range,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_BASIC,
			0,
			FIND_CLOSEST,
			false
		)
		for _, e in ipairs(enemies or {}) do
			if
				e ~= current
				and e ~= previous
				and not hit[e:entindex()]
				and AssistantManager
				and AssistantManager:IsValidAssistantTarget(unit, e, player_id)
			then
				next_enemy = e
				break
			end
		end
		if not IsValid(next_enemy) then
			return nil
		end

		next_enemy:EmitSound("Hero_Zuus.ArcLightning.Target")
		self:ArcFx(current, next_enemy, false)
		self:DealDamage(unit, next_enemy, dmg, "magical", true)

		previous = current
		current = next_enemy
		hit[next_enemy:entindex()] = true
		remaining = remaining - 1

		if remaining <= 0 then
			return nil
		end
		return jump_delay
	end)
end

-- Джигглипафф: надувается и взрывается AoE вокруг СЕБЯ.
function modifier_levelup_assistant_special:HasEnemyNear(unit, radius)
	local enemies = FindUnitsInRadius(
		unit:GetTeamNumber(),
		unit:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		0,
		FIND_ANY_ORDER,
		false
	)
	for _, e in ipairs(enemies or {}) do
		if AssistantManager and AssistantManager:IsValidAssistantTarget(unit, e, self.player_id) then
			return true
		end
	end
	return false
end

function modifier_levelup_assistant_special:DoBurst(unit, radius)
	radius = radius or self:Scaled(self.special.radius, self.special.radius_per_star)
	local pct = self:Scaled(self.special.damage_pct_of_assistant_damage, self.special.damage_pct_per_star)
	local dmg = get_assistant_damage(unit) * pct * 0.01
	local center = unit:GetAbsOrigin()

	local enemies = FindUnitsInRadius(
		unit:GetTeamNumber(),
		center,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)
	for _, enemy in ipairs(enemies or {}) do
		if AssistantManager and AssistantManager:IsValidAssistantTarget(unit, enemy, self.player_id) then
			self:DealDamage(unit, enemy, dmg, "magical", true)
		end
	end

	local fx = LevelUpParticleManager:CreateParticle("particles/companions/puff_song.vpcf", PATTACH_WORLDORIGIN, nil)
	LevelUpParticleManager:SetParticleControl(fx, 0, center)
	LevelUpParticleManager:ReleaseParticleIndex(fx)
end

-- Мяут: Pay Day - каждая N-я атака даёт владельцу бонусное золото.
function modifier_levelup_assistant_special:DoPayDay(unit, target)
	local gold = math.floor(self:Scaled(self.special.gold, self.special.gold_per_star) + 0.5)
	if gold <= 0 then
		return
	end

	if PlayerResource and PlayerResource.LevelUpModifyGold and self.player_id and self.player_id >= 0 then
		PlayerResource:LevelUpModifyGold(self.player_id, gold)
	end
	if CreateMessageResources then
		CreateMessageResources(IsValid(target) and target or unit, gold, "gold", true)
	end
end

-- Слоупок: замедляет атакованную цель. Боссы иммунны. Slow держим ОДНОЙ refreshing
-- инстанцией от этого Слоупока - иначе modifier_generic_slow_lua (MULTIPLE) застакался
-- бы на каждой атаке во фриз.
function modifier_levelup_assistant_special:DoSlow(unit, target)
	if not IsValid(target) or not target:IsAlive() then
		return
	end
	if IsLevelUpControlImmuneUnit and IsLevelUpControlImmuneUnit(target) then
		return
	end

	local slow_pct = self:Scaled(self.special.slow_pct, self.special.slow_pct_per_star)
	local duration = self:Scaled(self.special.slow_duration, self.special.slow_duration_per_star)
	if slow_pct <= 0 or duration <= 0 then
		return
	end

	local existing = target.FindModifierByNameAndCaster
			and target:FindModifierByNameAndCaster("modifier_generic_slow_lua", unit)
		or nil
	if existing and existing.SetDuration then
		existing:SetDuration(duration, true)
	else
		target:AddNewModifier(unit, nil, "modifier_generic_slow_lua", { duration = duration, slow_pct = slow_pct })
	end
end

-- Выпускает из точки семени tracking projectiles ко всем союзным героям и basic-юнитам.
-- Само лечение выполняет levelup_assistant_special_handler при попадании снаряда.
function modifier_levelup_assistant_special:LaunchLeechHealProjectiles(unit, origin, amount, radius, speed)
	if not IsValid(unit) or (tonumber(amount) or 0) <= 0 then
		return
	end

	local ability = unit:FindAbilityByName("levelup_assistant_special_handler")
	if not IsValid(ability) then
		return
	end

	local allies = FindUnitsInRadius(
		unit:GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, ally in ipairs(allies or {}) do
		if
			IsValid(ally)
			and ally:IsAlive()
			and not (IsLevelUpGameplayInteractionIgnored and IsLevelUpGameplayInteractionIgnored(ally))
		then
			ProjectileManager:CreateTrackingProjectile({
				Target = ally,
				vSourceLoc = origin,
				Ability = ability,
				EffectName = "particles/units/heroes/hero_treant/treant_leech_seed_projectile.vpcf",
				iMoveSpeed = speed,
				bDodgeable = false,
				bIsAttack = false,
				bReplaceExisting = false,
				bVisibleToEnemies = true,
				bProvidesVision = false,
				ExtraData = {
					assistant_leech_seed = 1,
					heal = amount,
				},
			})
		end
	end
end

-- Bulbasaur: Leech Seed - сажает семя на атакованного врага. Пока жертва жива,
-- семя наносит DoT и следует за ней; после смерти остаётся в точке смерти и до
-- конца действия продолжает выпускать лечебные снаряды ко всем ближайшим союзникам.
function modifier_levelup_assistant_special:DoLeechSeed(unit, target)
	if not IsValid(unit) or not IsValid(target) then
		return
	end
	if target:GetTeamNumber() == unit:GetTeamNumber() or target:GetTeamNumber() == DOTA_TEAM_NEUTRALS then
		return
	end

	local ticks = math.max(1, math.floor(self:Scaled(self.special.ticks, self.special.ticks_per_star)))
	local tick_interval = math.max(0.1, tonumber(self.special.tick_interval) or 0.5)
	local tick_pct = self:Scaled(self.special.tick_damage_pct, self.special.tick_damage_per_star)
	local heal_pct = tonumber(self.special.heal_pct) or 50
	local heal_radius = math.max(0, tonumber(self.special.heal_radius) or 500)
	local projectile_speed = math.max(1, tonumber(self.special.projectile_speed) or 600)
	local tick_damage = get_assistant_damage(unit) * tick_pct * 0.01
	local heal = tick_damage * heal_pct * 0.01
	local seed_origin = target:GetAbsOrigin()
	local target_was_alive = target:IsAlive()

	-- посадка семени
	unit:EmitSound("Hero_Treant.LeechSeed.Cast")
	if target_was_alive then
		target:EmitSound("Hero_Treant.LeechSeed.Target")
	else
		EmitSoundOnLocationWithCaster(seed_origin, "Hero_Treant.LeechSeed.Target", unit)
	end

	local seed_fx
	if target_was_alive then
		seed_fx = LevelUpParticleManager:CreateParticle(
			"particles/units/heroes/hero_treant/treant_leech_seed.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			unit
		)
		LevelUpParticleManager:SetParticleControlEnt(
			seed_fx,
			0,
			target,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			seed_origin,
			true
		)
	else
		seed_fx = LevelUpParticleManager:CreateParticle(
			"particles/units/heroes/hero_treant/treant_leech_seed.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		LevelUpParticleManager:SetParticleControl(seed_fx, 0, seed_origin)
	end
	local attack_attachment = unit:ScriptLookupAttachment("attach_attack1")
	local cast_origin = attack_attachment and attack_attachment > 0 and unit:GetAttachmentOrigin(attack_attachment)
		or unit:GetAbsOrigin()
	LevelUpParticleManager:SetParticleControl(seed_fx, 1, cast_origin)
	LevelUpParticleManager:ReleaseParticleIndex(seed_fx)

	local remaining = ticks
	Timers:CreateTimer(tick_interval, function()
		if not IsValid(unit) or remaining <= 0 then
			return nil
		end

		local target_alive = IsValid(target) and target:IsAlive()
		if target_alive then
			seed_origin = target:GetAbsOrigin()
			self:DealDamage(unit, target, tick_damage, "magical", false) -- одиночный DoT-тик
			target_alive = IsValid(target) and target:IsAlive()
		elseif target_was_alive and IsValid(target) then
			-- Первый тик после смерти фиксирует фактическую позицию трупа.
			seed_origin = target:GetAbsOrigin()
		end
		target_was_alive = target_alive

		local pulse
		if target_alive then
			target:EmitSound("Hero_Treant.LeechSeed.Tick")
			pulse = LevelUpParticleManager:CreateParticle(
				"particles/units/heroes/hero_treant/treant_leech_seed_damage_pulse.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				target
			)
		else
			EmitSoundOnLocationWithCaster(seed_origin, "Hero_Treant.LeechSeed.Tick", unit)
			pulse = LevelUpParticleManager:CreateParticle(
				"particles/units/heroes/hero_treant/treant_leech_seed_damage_pulse.vpcf",
				PATTACH_WORLDORIGIN,
				nil
			)
			LevelUpParticleManager:SetParticleControl(pulse, 0, seed_origin)
		end
		LevelUpParticleManager:ReleaseParticleIndex(pulse)

		if heal > 0 then
			self:LaunchLeechHealProjectiles(unit, seed_origin, heal, heal_radius, projectile_speed)
		end

		remaining = remaining - 1
		if remaining <= 0 then
			return nil
		end
		return tick_interval
	end)
end

--[[ ---------- выбор цели для interval piercing shot ---------- ]]

function modifier_levelup_assistant_special:ResolvePiercingTarget(unit)
	-- 1. текущая боевая цель помощника
	local order_target = unit.levelup_assistant_order_target
	if AssistantManager and AssistantManager:IsValidAssistantTarget(unit, order_target, self.player_id) then
		return order_target
	end
	local aggro = unit.GetAggroTarget and unit:GetAggroTarget() or nil
	if AssistantManager and AssistantManager:IsValidAssistantTarget(unit, aggro, self.player_id) then
		return aggro
	end

	-- 2. опорная точка по режиму
	local mode = AssistantManager and AssistantManager:GetAssistantMode(self.player_id)
		or ASSISTANT_AI_MODE_LANE_DEFENSE
	local ref_pos
	if mode == ASSISTANT_AI_MODE_FOLLOW_HERO then
		local hero = GetLevelUpUnitOwnerHero(unit) or PlayerResource:GetSelectedHeroEntity(self.player_id)
		local hero_target = IsValid(hero) and hero.GetAggroTarget and hero:GetAggroTarget() or nil
		if AssistantManager and AssistantManager:IsValidAssistantTarget(unit, hero_target, self.player_id) then
			return hero_target
		end
		ref_pos = IsValid(hero) and hero:GetAbsOrigin() or unit:GetAbsOrigin()
	else
		ref_pos = (AssistantManager and AssistantManager:GetAssistantHomePos(self.player_id)) or unit:GetAbsOrigin()
	end

	-- 3. самый дальний валидный враг в зоне (макс. покрытие линии)
	local radius = tonumber(self.special.line_distance) or 900
	local enemies = FindUnitsInRadius(
		unit:GetTeamNumber(),
		ref_pos,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		FIND_ANY_ORDER,
		false
	)
	local best, best_dist = nil, nil
	local unit_pos = unit:GetAbsOrigin()
	for _, enemy in ipairs(enemies or {}) do
		if AssistantManager and AssistantManager:IsValidAssistantTarget(unit, enemy, self.player_id) then
			local d = (enemy:GetAbsOrigin() - unit_pos):Length2D()
			if best_dist == nil or d > best_dist then
				best_dist = d
				best = enemy
			end
		end
	end

	return best
end