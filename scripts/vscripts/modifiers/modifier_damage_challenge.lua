--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


-- game/scripts/vscripts/modifiers/modifier_damage_challenge.lua
-- Damage Challenge Modifier: Virtual HP system with doubling levels and BigNumber support
--
-- ПОВЕДЕНИЕ:
-- - Юнит всегда заблокирован (не может атаковать, двигаться, использовать способности)
-- - Служит "губкой для урона" - принимает весь урон на себя
-- - СИСТЕМА СТАДИЙ:
--   1. "Готов начать подсчет" - получение урона обнуляет счетчик и запускает подсчет
--   2. "Атакуют" - считает урон в течение 30 секунд
--   3. "Перезарядка" - 5 секунд не считает урон, затем возвращается к стадии 1
-- - Урон считается по виртуальной системе HP с удваивающимися уровнями

if modifier_damage_challenge == nil then
	modifier_damage_challenge = class({})
end

local BigNum = require("libraries/bignum")

function modifier_damage_challenge:IsHidden()
	return true
end

function modifier_damage_challenge:IsPurgable()
	return false
end

function modifier_damage_challenge:RemoveOnDeath()
	return false
end

function modifier_damage_challenge:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_MIN_HEALTH,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_PROPERTY_CASTTIME_PERCENTAGE,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_HEALING,
	}
end

function modifier_damage_challenge:CheckState()
	return {
		[MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
		[MODIFIER_STATE_ROOTED] = true,
	}
end

function modifier_damage_challenge:GetMinHealth()
	return 1
end

function modifier_damage_challenge:OnCreated(kv)
	if not IsServer() then
		return
	end

	self.parent = self:GetParent()
	self.base_hp = 1000
	self.level = 1
	self.level_hp = self.base_hp
	self.level_hp_left = self.level_hp
	self.stacks = 0
	self.total_damage = BigNum.zero()
	-- Система стадий
	self.stage = "ready" -- "ready", "attacking", "recharge"
	self.timer_started = false
	self.timer_remaining = 30
	self.recharge_remaining = 5
	self.is_disabled = true -- Всегда заблокирован
	self.is_movement_blocked = true -- Всегда заблокировано движение
	self.is_attack_blocked = true -- Всегда заблокированы атаки
	self.is_ability_blocked = true -- Всегда заблокированы способности

	self:_sync()

	-- Уведомляем клиент о создании health bar панели
	CustomGameEventManager:Send_ServerToAllClients("create_health_bar_panel", {
		unit_id = tostring(self.parent:entindex()),
	})
end

function modifier_damage_challenge:OnRefresh(kv)
	if not IsServer() then
		return
	end
	-- no-op; при необходимости обновить base_hp из kv
	self:_sync()
end

function modifier_damage_challenge:OnDestroy()
	if not IsServer() or self.parent:IsNull() then
		return
	end
	CustomNetTables:SetTableValue("health_bar", tostring(self.parent:entindex()), nil)

	-- Уведомляем клиент об удалении health bar панели
	CustomGameEventManager:Send_ServerToAllClients("remove_health_bar_panel", {
		unit_id = tostring(self.parent:entindex()),
	})
end

function modifier_damage_challenge:_sync()
	CustomNetTables:SetTableValue("health_bar", tostring(self.parent:entindex()), {
		level = self.level,
		stacks = self.stacks,
		level_hp = tostring(self.level_hp),
		level_hp_left = tostring(self.level_hp_left),
		base_hp = self.base_hp,
		total_damage = BigNum.toString(self.total_damage),
		stage = self.stage,
		timer_started = self.timer_started,
		timer_remaining = self.timer_remaining,
		recharge_remaining = self.recharge_remaining,
		is_disabled = self.is_disabled,
		is_movement_blocked = self.is_movement_blocked,
		is_attack_blocked = self.is_attack_blocked,
		is_ability_blocked = self.is_ability_blocked,
	})
end

function modifier_damage_challenge:OnTakeDamage(event)
	if not IsServer() then
		return
	end
	if event.unit ~= self.parent then
		return
	end

	local dmg = math.max(0, event.damage or 0)
	if dmg <= 0 then
		return
	end

	-- Откатить урон
	self.parent:SetHealth(self.parent:GetMaxHealth())

	-- Логика по стадиям
	if self.stage == "ready" then
		-- Стадия "Готов начать подсчет" - обнуляем счетчик и запускаем подсчет
		self:_reset_damage_counters()
		self.stage = "attacking"
		self.timer_started = true
		self.timer_remaining = 30
		self:_start_timer()
		self:_sync()
	elseif self.stage == "attacking" then
		-- Стадия "Атакуют" - считаем урон
		self:_process_damage(dmg)
	elseif self.stage == "recharge" then
		-- Стадия "Перезарядка" - игнорируем урон
		return
	end
end

-- Обнуление счетчиков урона
function modifier_damage_challenge:_reset_damage_counters()
	self.level = 1
	self.level_hp = self.base_hp
	self.level_hp_left = self.level_hp
	self.stacks = 0
	self.total_damage = BigNum.zero()
	self:SetStackCount(0)
end

-- Обработка урона
function modifier_damage_challenge:_process_damage(dmg)
	-- Учёт виртуального урона
	local remaining = dmg
	-- Быстрый «safety» лимит итераций
	local guard, GUARD_MAX = 0, 512

	while remaining > 0 do
		guard = guard + 1
		if guard > GUARD_MAX then
			-- Ускоренный переход: если remaining сильно больше остатка текущего уровня,
			-- можно оценить, сколько уровней перескочим. Для простоты — прерываем цикл.
			break
		end

		if remaining < self.level_hp_left then
			self.level_hp_left = self.level_hp_left - remaining
			remaining = 0
		else
			remaining = remaining - self.level_hp_left
			self.stacks = self.stacks + 1
			self.level = self.level + 1
			self.level_hp = self.base_hp * (1.2 ^ (self.level - 1))
			self.level_hp_left = self.level_hp
		end
	end

	-- Суммарный урон (BigNum)
	self.total_damage = BigNum.add(self.total_damage, BigNum.fromNumber(dmg))

	-- Отобразить стаки на иконке модификатора
	self:SetStackCount(self.stacks)

	self:_sync()
end

-- Запуск таймера
function modifier_damage_challenge:_start_timer()
	if not self.timer_started then
		return
	end

	-- Создаем таймер на 30 секунд
	self.timer_remaining = 30
	self:_sync()

	-- Запускаем таймер
	Timers:CreateTimer(1.0, function()
		if not self or not self.parent or not IsValidEntity(self.parent) then
			return nil
		end

		self.timer_remaining = self.timer_remaining - 1
		self:_sync()

		if self.timer_remaining <= 0 then
			self:_start_recharge()
			return nil
		else
			return 1.0 -- Повторяем каждую секунду
		end
	end)
end

-- Начало перезарядки
function modifier_damage_challenge:_start_recharge()
	self.stage = "recharge"
	self.timer_started = false
	self.timer_remaining = 0
	self.recharge_remaining = 5
	self:_sync()

	-- Запускаем таймер перезарядки
	Timers:CreateTimer(1.0, function()
		if not self or not self.parent or not IsValidEntity(self.parent) then
			return nil
		end

		self.recharge_remaining = self.recharge_remaining - 1
		self:_sync()

		if self.recharge_remaining <= 0 then
			self:_ready_to_start()
			return nil
		else
			return 1.0 -- Повторяем каждую секунду
		end
	end)
end

-- Готов к началу
function modifier_damage_challenge:_ready_to_start()
	self.stage = "ready"
	self.recharge_remaining = 0
	self:_sync()
end

-- Блокировка движения
function modifier_damage_challenge:GetModifierMoveSpeed_Absolute()
	if self.is_movement_blocked or self.is_disabled then
		return 0
	end
	return nil
end

function modifier_damage_challenge:GetModifierMoveSpeed_Limit()
	if self.is_movement_blocked or self.is_disabled then
		return 0
	end
	return nil
end

-- Блокировка атак
function modifier_damage_challenge:GetModifierAttackSpeedBonus_Constant()
	if self.is_attack_blocked or self.is_disabled then
		return -1000 -- Очень медленная атака
	end
	return nil
end

function modifier_damage_challenge:GetModifierAttackRangeBonus()
	if self.is_attack_blocked or self.is_disabled then
		return -1000 -- Нулевая дальность атаки
	end
	return nil
end

function modifier_damage_challenge:GetDisableAutoAttack()
	if self.is_attack_blocked or self.is_disabled then
		return 1
	end
	return nil
end

-- Блокировка способностей
function modifier_damage_challenge:GetModifierCastRangeBonusStacking()
	if self.is_ability_blocked or self.is_disabled then
		return -1000 -- Нулевая дальность каста
	end
	return nil
end

function modifier_damage_challenge:GetModifierPercentageCasttime()
	if self.is_ability_blocked or self.is_disabled then
		return 1000 -- Очень долгое время каста
	end
	return nil
end

function modifier_damage_challenge:GetModifierPercentageCooldown()
	if self.is_ability_blocked or self.is_disabled then
		return 1000 -- Очень долгий кулдаун
	end
	return nil
end

-- Блокировка регенерации
function modifier_damage_challenge:GetModifierPercentageManaRegen()
	if self.is_disabled then
		return -100 -- Блокируем регенерацию маны
	end
	return nil
end

function modifier_damage_challenge:GetModifierPercentageHealthRegen()
	if self.is_disabled then
		return -100 -- Блокируем регенерацию здоровья
	end
	return nil
end

-- Блокировка урона (для неуязвимости)
function modifier_damage_challenge:GetAbsoluteNoDamagePhysical()
	if self.is_invulnerable then
		return 1
	end
	return nil
end

function modifier_damage_challenge:GetAbsoluteNoDamageMagical()
	if self.is_invulnerable then
		return 1
	end
	return nil
end

function modifier_damage_challenge:GetAbsoluteNoDamagePure()
	if self.is_invulnerable then
		return 1
	end
	return nil
end

function modifier_damage_challenge:GetAbsoluteNoDamageHealing()
	if self.is_invulnerable then
		return 1
	end
	return nil
end

-- Функции для управления состояниями
-- Примеры использования:
-- self:SetMovementBlocked(true)  -- Блокирует только движение
-- self:SetAttackBlocked(true)    -- Блокирует только атаки
-- self:SetAbilityBlocked(true)    -- Блокирует только способности
-- self:SetFullyDisabled(true)     -- Блокирует ВСЕ действия

function modifier_damage_challenge:SetMovementBlocked(blocked)
	self.is_movement_blocked = blocked
	self:_sync()
end

function modifier_damage_challenge:SetAttackBlocked(blocked)
	self.is_attack_blocked = blocked
	self:_sync()
end

function modifier_damage_challenge:SetAbilityBlocked(blocked)
	self.is_ability_blocked = blocked
	self:_sync()
end

function modifier_damage_challenge:SetFullyDisabled(disabled)
	self.is_disabled = disabled
	if disabled then
		self.is_movement_blocked = true
		self.is_attack_blocked = true
		self.is_ability_blocked = true
	end
	self:_sync()
end