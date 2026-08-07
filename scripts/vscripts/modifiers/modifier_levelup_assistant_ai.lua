--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


--[[
    AI помощника (assistant).

    Два режима (определяются реальной фазой матча через AssistantManager):
    - LANE_DEFENSE: state machine (IDLE_PATROL / ACQUIRE_TARGET / ATTACK / KITE /
      RETURN_HOME) вокруг home_pos = levelup_assistant_spawner_i;
    - FOLLOW_HERO (final boss / post-stage): помощник отвязывается от home_pos и
      следует за героем как боевой питомец.

    Стабильность/производительность:
    - think раз в think_interval (>= 0.25с);
    - orders не чаще minimum_order_interval (0.75с) без причины (дедуп в IssueOrder);
    - FindUnitsInRadius только вокруг home_pos / героя, не по всей карте;
    - простая защита от застревания (stuck) с teleport fallback.

    Состояние и троттлинг order'ов хранятся на самом юните, чтобы переживать
    переключение режимов и читаться менеджером.
]]
modifier_levelup_assistant_ai = class({})

function modifier_levelup_assistant_ai:IsHidden()
	return true
end
function modifier_levelup_assistant_ai:IsPurgable()
	return false
end
function modifier_levelup_assistant_ai:IsPurgeException()
	return false
end
function modifier_levelup_assistant_ai:RemoveOnDeath()
	return false
end

--[[ ---------- защита от вражеских башен ---------- ]]

-- Радиус, ближе которого помощник не должен находиться у живой башни.
local function tower_danger_radius(circle)
	return circle.range + (tonumber(ASSISTANT_TOWER_AVOID_MARGIN) or 25)
end

local function pos_in_tower_danger(circles, pos)
	for _, c in ipairs(circles or {}) do
		if (pos - c.pos):Length2D() < tower_danger_radius(c) then
			return true
		end
	end
	return false
end

local function clamp_out_of_tower_danger(circles, pos)
	if not pos then
		return pos
	end
	local result = pos
	for _, c in ipairs(circles or {}) do
		local avoid = tower_danger_radius(c)
		local delta = result - c.pos
		delta.z = 0
		local d = delta:Length2D()
		if d < avoid then
			local dir = (d > 1) and delta:Normalized() or RandomVector(1):Normalized()
			result = c.pos + dir * (avoid + 16)
		end
	end
	return result
end

function modifier_levelup_assistant_ai:OnCreated()
	if not IsServer() then
		return
	end

	local unit = self:GetParent()
	self.player_id = tonumber(unit.levelup_assistant_owner_player_id) or GetLevelUpUnitOwnerPlayerID(unit) or -1
	self.cfg = unit.levelup_assistant_ai_config or ASSISTANT_DEFAULT_AI_CONFIG

	self._last_stuck_check = 0
	self._stuck_ref_pos = unit:GetAbsOrigin()
	self._stuck_since = nil

	unit.levelup_assistant_state = ASSISTANT_AI_STATE_IDLE_PATROL
	unit.levelup_assistant_force_reissue = true

	local interval = math.max(0.25, tonumber(self.cfg.think_interval) or 0.25)
	self:StartIntervalThink(interval)
end

--[[ ---------- выдача order'ов с дедупом ---------- ]]

function modifier_levelup_assistant_ai:IssueOrder(unit, cfg, order)
	local now = GameRules:GetGameTime()

	if order.pos and AssistantManager then
		order.pos = clamp_out_of_tower_danger(AssistantManager:GetTowerDangerCircles(unit, order.pos), order.pos)
	end

	local type_changed = (order.type ~= unit.levelup_assistant_order_type)
	local changed = type_changed or (order.target ~= unit.levelup_assistant_order_target)

	local far_move = false
	if order.pos then
		local cur_pos = unit.levelup_assistant_order_pos
		if cur_pos then
			far_move = (order.pos - cur_pos):Length2D() > 75
		else
			far_move = true
		end
	end

	local prev_target = unit.levelup_assistant_order_target
	local prev_target_dead = prev_target ~= nil
		and (not IsValid(prev_target) or (prev_target.IsAlive and not prev_target:IsAlive()))

	local force = unit.levelup_assistant_force_reissue == true
	local cooldown_passed = (now - (unit.levelup_assistant_last_order_time or 0))
		>= (tonumber(cfg.minimum_order_interval) or 0.75)

	if not (changed or far_move or force) then
		return
	end
	if not cooldown_passed and not force and not type_changed and not prev_target_dead then
		return
	end

	if order.type == "attack" and IsValid(order.target) then
		if unit.GetAggroTarget and unit:GetAggroTarget() == order.target then
			unit.levelup_assistant_order_type = "attack"
			unit.levelup_assistant_order_target = order.target
			unit.levelup_assistant_order_pos = nil
			unit.levelup_assistant_last_order_time = now
			unit.levelup_assistant_force_reissue = nil
			return
		end
		ExecuteOrderFromTable({
			UnitIndex = unit:entindex(),
			OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
			TargetIndex = order.target:entindex(),
			Queue = false,
		})
	elseif order.type == "move" and order.pos then
		ExecuteOrderFromTable({
			UnitIndex = unit:entindex(),
			OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
			Position = order.pos,
			Queue = false,
		})
	elseif order.type == "attack_move" and order.pos then
		-- отступаем, но продолжаем атаковать всё, что в радиусе
		ExecuteOrderFromTable({
			UnitIndex = unit:entindex(),
			OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
			Position = order.pos,
			Queue = false,
		})
	else
		return
	end

	unit.levelup_assistant_order_type = order.type
	unit.levelup_assistant_order_target = order.target
	unit.levelup_assistant_order_pos = order.pos
	unit.levelup_assistant_last_order_time = now
	unit.levelup_assistant_force_reissue = nil
end

--[[ ---------- helpers ---------- ]]

function modifier_levelup_assistant_ai:GetHomePos(unit)
	if unit.levelup_assistant_home_pos then
		return unit.levelup_assistant_home_pos
	end
	if AssistantManager then
		return AssistantManager:GetAssistantHomePos(self.player_id)
	end
	return nil
end

-- Ищет валидную точку отступления: базовое направление (от врага + к anchor)
-- и несколько отклонений на случай стены/дерева. Возвращает первую проходимую
-- точку, которая реально увеличивает дистанцию до врага и в пределах leash,
-- либо nil, если отступать некуда (тогда вызывающий просто атакует).
function modifier_levelup_assistant_ai:FindRetreatPos(unit, unit_pos, enemy_pos, anchor_pos, leash)
	local step = 250
	local away = (unit_pos - enemy_pos):Normalized()
	local toward_anchor = (anchor_pos - unit_pos):Normalized()
	local base_dir = (away + toward_anchor * 0.75):Normalized()
	if base_dir:Length2D() < 0.1 then
		base_dir = (away:Length2D() > 0.1) and away or RandomVector(1):Normalized()
	end

	local tower_circles = AssistantManager and AssistantManager:GetTowerDangerCircles(unit, unit_pos) or nil

	local cur_enemy_dist = (unit_pos - enemy_pos):Length2D()
	for _, deg in ipairs({ 0, 30, -30, 60, -60, 90, -90 }) do
		local dir = RotatePosition(Vector(0, 0, 0), QAngle(0, deg, 0), base_dir)
		local candidate = ClampPositionToRadius(unit_pos + dir * step, anchor_pos, leash)
		candidate = GetGroundPosition(candidate, unit)
		if
			(candidate - enemy_pos):Length2D() > cur_enemy_dist + 24
			and not pos_in_tower_danger(tower_circles, candidate)
			and GridNav:IsTraversable(candidate)
			and GridNav:CanFindPath(unit_pos, candidate)
		then
			return candidate
		end
	end

	return nil
end

function modifier_levelup_assistant_ai:MaybePatrol(unit, cfg, center_pos)
	local now = GameRules:GetGameTime()
	local cur_pos = unit:GetAbsOrigin()
	local move_pos = unit.levelup_assistant_order_pos

	local reached = (not move_pos) or (cur_pos - move_pos):Length2D() < 60
	local patrol_interval = math.max(tonumber(cfg.minimum_order_interval) or 0.75, 1.5)
	local cooldown_ok = (now - (unit.levelup_assistant_last_order_time or 0)) >= patrol_interval
	if not reached or not cooldown_ok then
		return
	end

	local patrol_radius = tonumber(cfg.patrol_radius) or 250
	local patrol_pos = center_pos + RandomVector(RandomFloat(80, patrol_radius))
	self:IssueOrder(unit, cfg, { type = "move", pos = patrol_pos })
end

--[[ ---------- stuck protection ---------- ]]

function modifier_levelup_assistant_ai:UpdateStuck(unit, cfg)
	local now = GameRules:GetGameTime()
	local interval = tonumber(cfg.stuck_check_interval) or 1.0
	if (now - (self._last_stuck_check or 0)) < interval then
		return
	end
	self._last_stuck_check = now

	-- застревание учитываем только если юнит должен двигаться (есть move order)
	if unit.levelup_assistant_order_type ~= "move" then
		self._stuck_ref_pos = unit:GetAbsOrigin()
		self._stuck_since = nil
		return
	end

	local pos = unit:GetAbsOrigin()
	local ref = self._stuck_ref_pos
	if ref and (pos - ref):Length2D() < 25 then
		self._stuck_since = self._stuck_since or now
		if (now - self._stuck_since) >= (tonumber(cfg.stuck_time_to_fix) or 2.5) then
			self:FixStuck(unit, cfg)
			self._stuck_since = nil
		end
	else
		self._stuck_since = nil
	end
	self._stuck_ref_pos = pos
end

function modifier_levelup_assistant_ai:FixStuck(unit, cfg)
	local mode = AssistantManager and AssistantManager:GetAssistantMode(self.player_id)
		or ASSISTANT_AI_MODE_LANE_DEFENSE

	local anchor
	if mode == ASSISTANT_AI_MODE_FOLLOW_HERO then
		local hero = GetLevelUpUnitOwnerHero(unit) or PlayerResource:GetSelectedHeroEntity(self.player_id)
		anchor = IsValid(hero) and hero:GetAbsOrigin() or unit:GetAbsOrigin()
	else
		anchor = self:GetHomePos(unit) or unit:GetAbsOrigin()
	end

	local dist = (unit:GetAbsOrigin() - anchor):Length2D()
	if dist > (tonumber(cfg.leash_radius) or 900) * 1.5 then
		-- явно плохой stuck -> teleport fallback (только как крайняя мера)
		FindClearSpaceForUnit(unit, anchor + RandomVector(150), true)
		unit.levelup_assistant_order_type = nil
		unit.levelup_assistant_order_target = nil
		unit.levelup_assistant_order_pos = nil
	else
		-- мягкий fallback: форс-move к точке рядом с anchor
		unit.levelup_assistant_force_reissue = true
		self:IssueOrder(unit, cfg, { type = "move", pos = anchor + RandomVector(120) })
	end
end

--[[ ---------- основной think ---------- ]]

function modifier_levelup_assistant_ai:OnIntervalThink()
	if not IsServer() then
		return
	end

	local unit = self:GetParent()
	if not IsValid(unit) or not unit:IsAlive() then
		return
	end

	local cfg = self.cfg
	local player_id = self.player_id

	local mode = ASSISTANT_AI_MODE_LANE_DEFENSE
	if AssistantManager then
		mode = AssistantManager:SyncAssistantMode(player_id)
	end

	self:UpdateStuck(unit, cfg)

	if mode == ASSISTANT_AI_MODE_FOLLOW_HERO then
		self:ThinkFollowHero(unit, player_id, cfg)
	else
		self:ThinkLaneDefense(unit, player_id, cfg)
	end
end

function modifier_levelup_assistant_ai:ThinkLaneDefense(unit, player_id, cfg)
	local home_pos = self:GetHomePos(unit)
	if not home_pos then
		return
	end

	local unit_pos = unit:GetAbsOrigin()
	local leash = tonumber(cfg.leash_radius) or 900

	-- Grace-окно: сколько секунд после исчезновения врагов помощник держится возле
	-- владельца, прежде чем вернуться на точку спавна.
	local now = GameRules:GetGameTime()
	local grace = tonumber(cfg.owner_grace_time) or 2.0
	local in_owner_grace = (now - (self._last_enemy_time or -100000)) < grace

	-- сам вышел за leash -> домой (во время grace-окна вместо этого тянемся к владельцу)
	if (unit_pos - home_pos):Length2D() > leash and not in_owner_grace then
		unit.levelup_assistant_state = ASSISTANT_AI_STATE_RETURN_HOME
		self:IssueOrder(unit, cfg, { type = "move", pos = home_pos })
		return
	end

	local target = AssistantManager
			and AssistantManager:AcquireAssistantTarget(
				unit,
				home_pos,
				player_id,
				tonumber(cfg.aggro_radius) or 900,
				tonumber(cfg.danger_range) or 300
			)
		or nil

	-- цель ушла за leash от home -> сбросить
	if IsValid(target) and (target:GetAbsOrigin() - home_pos):Length2D() > leash then
		target = nil
	end

	if IsValid(target) then
		self._last_enemy_time = now
		self:CombatStep(unit, cfg, target, home_pos, leash)
		return
	end

	-- Врагов нет. В течение grace-периода после боя держимся возле владельца
	-- (как в follow-режиме), и только после этого возвращаемся на точку спавна.
	if in_owner_grace then
		local hero = GetLevelUpUnitOwnerHero(unit)
		if not IsValid(hero) then
			hero = PlayerResource:GetSelectedHeroEntity(player_id)
		end
		if IsValid(hero) then
			local hero_pos = hero:GetAbsOrigin()
			if (unit_pos - hero_pos):Length2D() > (tonumber(cfg.follow_distance) or 350) then
				unit.levelup_assistant_state = ASSISTANT_AI_STATE_RETURN_HOME
				self:IssueOrder(unit, cfg, { type = "move", pos = hero_pos })
			else
				unit.levelup_assistant_state = ASSISTANT_AI_STATE_IDLE_PATROL
				self:MaybePatrol(unit, cfg, hero_pos)
			end
			return
		end
	end

	-- Grace истёк (или нет владельца): вернуться на спавн или мелко патрулировать возле него.
	if (unit_pos - home_pos):Length2D() > (tonumber(cfg.patrol_radius) or 250) then
		unit.levelup_assistant_state = ASSISTANT_AI_STATE_RETURN_HOME
		self:IssueOrder(unit, cfg, { type = "move", pos = home_pos })
	else
		unit.levelup_assistant_state = ASSISTANT_AI_STATE_IDLE_PATROL
		self:MaybePatrol(unit, cfg, home_pos)
	end
end

function modifier_levelup_assistant_ai:ThinkFollowHero(unit, player_id, cfg)
	local hero = GetLevelUpUnitOwnerHero(unit)
	if not IsValid(hero) then
		hero = PlayerResource:GetSelectedHeroEntity(player_id)
	end
	if not IsValid(hero) then
		return
	end

	local unit_pos = unit:GetAbsOrigin()
	local hero_pos = hero:GetAbsOrigin()
	local dist_to_hero = (hero_pos - unit_pos):Length2D()

	-- слишком далеко от героя -> safe teleport
	if dist_to_hero > (tonumber(cfg.follow_teleport_distance) or 1800) then
		FindClearSpaceForUnit(unit, hero_pos + RandomVector(150), true)
		unit.levelup_assistant_order_type = nil
		unit.levelup_assistant_order_target = nil
		unit.levelup_assistant_order_pos = nil
		unit.levelup_assistant_state = ASSISTANT_AI_STATE_RETURN_HOME
		return
	end

	-- цель героя или ближайший враг рядом с героем
	local target = AssistantManager and AssistantManager:AcquireFollowTarget(unit, hero, player_id, cfg) or nil
	if IsValid(target) then
		-- в follow-режиме "anchor" для отступления - сам герой, без жёсткого leash
		self:CombatStep(unit, cfg, target, hero_pos, 100000)
		return
	end

	-- врагов нет: держимся рядом с героем
	if dist_to_hero > (tonumber(cfg.follow_distance) or 350) then
		unit.levelup_assistant_state = ASSISTANT_AI_STATE_RETURN_HOME
		self:IssueOrder(unit, cfg, { type = "move", pos = hero_pos })
	else
		unit.levelup_assistant_state = ASSISTANT_AI_STATE_IDLE_PATROL
		self:MaybePatrol(unit, cfg, hero_pos)
	end
end

--[[
    Боевой шаг ranged-юнита. Приоритет ВСЕГДА у атаки; kite - вспомогательный,
    короткий и безопасный:
    - kite только по melee-врагу, который вплотную (dist < danger_range);
    - отступаем обычным MOVE строго ОТ врага (attack_move нельзя - это "наступай
      и атакуй", юнит побежал бы НА врагов);
    - если отступать некуда (стена/дерево - FindRetreatPos вернул nil) - просто бьём;
    - непрерывный kite ограничен kite_max_time;
    - при ЛЮБОМ выходе из kite в атаку держим атаку kite_commit_time, чтобы помощник
      успел нанести удары и не дёргался обратно в kite каждые пол-секунды (это и
      убирает "постоял после отхода и только потом ударил" вместе со снятием
      кулдауна на смену типа приказа в IssueOrder).
    anchor_pos/leash задают, куда отступать и докуда.
]]
function modifier_levelup_assistant_ai:CombatStep(unit, cfg, target, anchor_pos, leash)
	local now = GameRules:GetGameTime()
	local unit_pos = unit:GetAbsOrigin()
	local dist = (target:GetAbsOrigin() - unit_pos):Length2D()
	local attack_range = tonumber(cfg.attack_range) or 650
	local danger = tonumber(cfg.danger_range) or 280
	local was_kiting = unit.levelup_assistant_state == ASSISTANT_AI_STATE_KITE

	local function commit_attack()
		-- выходим из kite -> фиксируем окно атаки, чтобы успеть выстрелить
		if was_kiting then
			self._kite_commit_until = now + (tonumber(cfg.kite_commit_time) or 2.0)
			self._kite_since = nil
		end
		unit.levelup_assistant_state = ASSISTANT_AI_STATE_ATTACK
		self:IssueOrder(unit, cfg, { type = "attack", target = target })
	end

	-- цель вне радиуса атаки -> атакуем (ATTACK_TARGET сам подойдёт)
	if dist > attack_range then
		return commit_attack()
	end

	local enemy_is_ranged = target.IsRangedAttacker and target:IsRangedAttacker()
	local want_kite = (cfg.allow_kite ~= false)
		and dist < danger
		and not enemy_is_ranged -- кайтить ranged бессмысленно
		and not (self._kite_commit_until and now < self._kite_commit_until) -- окно атаки после kite

	if not want_kite then
		return commit_attack()
	end

	local retreat_pos = self:FindRetreatPos(unit, unit_pos, target:GetAbsOrigin(), anchor_pos, leash)
	if not retreat_pos then
		return commit_attack() -- отступать некуда -> бьём
	end

	-- ограничиваем длительность непрерывного kite (отсчёт от начала KITE-отрезка)
	if not was_kiting then
		self._kite_since = now
	end
	if (now - (self._kite_since or now)) >= (tonumber(cfg.kite_max_time) or 0.9) then
		return commit_attack()
	end

	unit.levelup_assistant_state = ASSISTANT_AI_STATE_KITE
	self:IssueOrder(unit, cfg, { type = "move", pos = retreat_pos })
end