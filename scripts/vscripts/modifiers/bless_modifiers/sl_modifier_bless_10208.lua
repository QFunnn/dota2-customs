--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10208 = __TS__Class()
local sl_modifier_bless_10208 = ____exports.sl_modifier_bless_10208
sl_modifier_bless_10208.name = "sl_modifier_bless_10208"
__TS__ClassExtends(sl_modifier_bless_10208, sl_modifier_transmitter_data)
function sl_modifier_bless_10208.prototype.____constructor(self, ...)
	sl_modifier_transmitter_data.prototype.____constructor(self, ...)
	self._last_action_time = 0
	self._enemy_stay = {}
	self._in_cd = false
end
function sl_modifier_bless_10208.prototype.IsHidden(self)
	return true
end
function sl_modifier_bless_10208.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	params.update_data = 1
	self:_ApplyParams(params)
	self._last_action_time = GameRules:GetGameTime()
	self:StartIntervalThink(0.25)
end
function sl_modifier_bless_10208.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	if not self._params then
		return
	end
	local ____self__params_1 = self._params
	local ____params_idle_time_0 = params.idle_time
	if ____params_idle_time_0 == nil then
		____params_idle_time_0 = self._params.idle_time
	end
	____self__params_1.idle_time = ____params_idle_time_0
	local ____self__params_3 = self._params
	local ____params_ys_2 = params.ys
	if ____params_ys_2 == nil then
		____params_ys_2 = self._params.ys
	end
	____self__params_3.ys = ____params_ys_2
	local ____self__params_5 = self._params
	local ____params_break_radius_4 = params.break_radius
	if ____params_break_radius_4 == nil then
		____params_break_radius_4 = self._params.break_radius
	end
	____self__params_5.break_radius = ____params_break_radius_4
	local ____self__params_7 = self._params
	local ____params_enemy_stay_time_6 = params.enemy_stay_time
	if ____params_enemy_stay_time_6 == nil then
		____params_enemy_stay_time_6 = self._params.enemy_stay_time
	end
	____self__params_7.enemy_stay_time = ____params_enemy_stay_time_6
	local ____self__params_9 = self._params
	local ____params_restore_cd_8 = params.restore_cd
	if ____params_restore_cd_8 == nil then
		____params_restore_cd_8 = self._params.restore_cd
	end
	____self__params_9.restore_cd = ____params_restore_cd_8
	self._params.update_data = 1
	self:_ApplyParams(self._params)
end
function sl_modifier_bless_10208.prototype.DeclareFunctions(self)
	return { MODIFIER_EVENT_ON_ORDER, MODIFIER_EVENT_ON_ATTACK_START, MODIFIER_EVENT_ON_ABILITY_FULLY_CAST }
end
function sl_modifier_bless_10208.prototype.OnOrder(self, event)
	if not IsServer() then
		return
	end
	if event.unit ~= self:GetParent() then
		return
	end
	local order = event.order_type
	if
		order == DOTA_UNIT_ORDER_ATTACK_TARGET
		or order == DOTA_UNIT_ORDER_ATTACK_MOVE
		or order == DOTA_UNIT_ORDER_CAST_TARGET
		or order == DOTA_UNIT_ORDER_CAST_POSITION
		or order == DOTA_UNIT_ORDER_CAST_NO_TARGET
		or order == DOTA_UNIT_ORDER_CAST_TOGGLE
		or order == DOTA_UNIT_ORDER_DROP_ITEM
		or order == DOTA_UNIT_ORDER_GIVE_ITEM
		or order == DOTA_UNIT_ORDER_PICKUP_ITEM
		or order == DOTA_UNIT_ORDER_MOVE_TO_TARGET
	then
		if
			order == DOTA_UNIT_ORDER_ATTACK_TARGET
			or order == DOTA_UNIT_ORDER_ATTACK_MOVE
			or order == DOTA_UNIT_ORDER_CAST_TARGET
			or order == DOTA_UNIT_ORDER_CAST_POSITION
			or order == DOTA_UNIT_ORDER_CAST_NO_TARGET
			or order == DOTA_UNIT_ORDER_CAST_TOGGLE
		then
			self:_BreakActive()
		end
		self:_MarkAction()
	end
	if
		order == DOTA_UNIT_ORDER_DROP_ITEM
		or order == DOTA_UNIT_ORDER_GIVE_ITEM
		or order == DOTA_UNIT_ORDER_PICKUP_ITEM
	then
		self:_MarkAction()
	end
end
function sl_modifier_bless_10208.prototype.OnAttackStart(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	self:_MarkAction()
	self:_BreakActive()
end
function sl_modifier_bless_10208.prototype.OnAbilityFullyCast(self, event)
	if not IsServer() then
		return
	end
	if event.unit ~= self:GetParent() then
		return
	end
	self:_MarkAction()
	self:_BreakActive()
end
function sl_modifier_bless_10208.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(parent) or not self._params then
		return
	end
	if self._in_cd then
		return
	end
	local now = GameRules:GetGameTime()
	local ____self__params_idle_time_10 = self._params.idle_time
	if ____self__params_idle_time_10 == nil then
		____self__params_idle_time_10 = 0
	end
	local idle_time = ____self__params_idle_time_10
	local active = parent:HasSLModifier(____exports.sl_modifier_bless_10208_active, parent)
	if not active then
		if now - self._last_action_time >= idle_time then
			parent:AddSLModifier(
				____exports.sl_modifier_bless_10208_active,
				{ caster = parent, modifierTable = { ys = self._params.ys, update_data = 1 } }
			)
			self._enemy_stay = {}
		end
		return
	end
	local ____self__params_break_radius_11 = self._params.break_radius
	if ____self__params_break_radius_11 == nil then
		____self__params_break_radius_11 = 0
	end
	local break_radius = ____self__params_break_radius_11
	local ____self__params_enemy_stay_time_12 = self._params.enemy_stay_time
	if ____self__params_enemy_stay_time_12 == nil then
		____self__params_enemy_stay_time_12 = 0
	end
	local enemy_stay_time = ____self__params_enemy_stay_time_12
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		break_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
			+ DOTA_UNIT_TARGET_FLAG_INVULNERABLE
			+ DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
		FIND_ANY_ORDER,
		false
	)
	local present = {}
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(enemy) or not enemy:IsRealHero() then
				goto __continue27
			end
			present[enemy] = true
			local ____self__enemy_stay_enemy_13 = self._enemy_stay[enemy]
			if ____self__enemy_stay_enemy_13 == nil then
				____self__enemy_stay_enemy_13 = 0
			end
			local stay = ____self__enemy_stay_enemy_13 + 0.25
			self._enemy_stay[enemy] = stay
			if stay >= enemy_stay_time then
				self:_BreakActive(true)
				return
			end
		end
		::__continue27::
	end
	for enemy in pairs(self._enemy_stay) do
		if not present[enemy] then
			self._enemy_stay[enemy] = nil
		end
	end
end
function sl_modifier_bless_10208.prototype._MarkAction(self)
	self._last_action_time = GameRules:GetGameTime()
end
function sl_modifier_bless_10208.prototype._BreakActive(self, enter_cd)
	if enter_cd == nil then
		enter_cd = false
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	local buff = parent:FindSLModifier(____exports.sl_modifier_bless_10208_active, parent)
	if buff then
		buff:Destroy()
	end
	self._enemy_stay = {}
	self:_MarkAction()
	if enter_cd and self._params then
		local ____self__params_restore_cd_14 = self._params.restore_cd
		if ____self__params_restore_cd_14 == nil then
			____self__params_restore_cd_14 = 0
		end
		local restore_cd = ____self__params_restore_cd_14
		self._in_cd = true
		parent:AddSLModifier(____exports.sl_modifier_bless_10208_cd, { caster = parent, duration = restore_cd })
		Timers:CreateTimer(restore_cd, function()
			if not IsValid(self) then
				return
			end
			self._in_cd = false
			self:_MarkAction()
		end)
	end
end
sl_modifier_bless_10208 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10208") },
	sl_modifier_bless_10208
)
____exports.sl_modifier_bless_10208 = sl_modifier_bless_10208
____exports.sl_modifier_bless_10208_active = __TS__Class()
local sl_modifier_bless_10208_active = ____exports.sl_modifier_bless_10208_active
sl_modifier_bless_10208_active.name = "sl_modifier_bless_10208_active"
__TS__ClassExtends(sl_modifier_bless_10208_active, sl_modifier_transmitter_data)
function sl_modifier_bless_10208_active.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10208_active.prototype.GetTexture(self)
	return "buff/bless/10208"
end
function sl_modifier_bless_10208_active.prototype.CheckState(self)
	return { [MODIFIER_STATE_UNSELECTABLE] = true, [MODIFIER_STATE_UNTARGETABLE_ENEMY] = true }
end
function sl_modifier_bless_10208_active.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT, MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_10208_active.prototype.GetModifierMoveSpeedBonus_Constant(self)
	local ____table__params_ys_15 = self._params
	if ____table__params_ys_15 ~= nil then
		____table__params_ys_15 = ____table__params_ys_15.ys
	end
	local ____table__params_ys_15_17 = ____table__params_ys_15
	if ____table__params_ys_15_17 == nil then
		____table__params_ys_15_17 = 0
	end
	return ____table__params_ys_15_17
end
function sl_modifier_bless_10208_active.prototype.OnTooltip(self)
	local ____table__params_ys_18 = self._params
	if ____table__params_ys_18 ~= nil then
		____table__params_ys_18 = ____table__params_ys_18.ys
	end
	local ____table__params_ys_18_20 = ____table__params_ys_18
	if ____table__params_ys_18_20 == nil then
		____table__params_ys_18_20 = 0
	end
	return ____table__params_ys_18_20
end
sl_modifier_bless_10208_active = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10208") },
	sl_modifier_bless_10208_active
)
____exports.sl_modifier_bless_10208_active = sl_modifier_bless_10208_active
____exports.sl_modifier_bless_10208_cd = __TS__Class()
local sl_modifier_bless_10208_cd = ____exports.sl_modifier_bless_10208_cd
sl_modifier_bless_10208_cd.name = "sl_modifier_bless_10208_cd"
__TS__ClassExtends(sl_modifier_bless_10208_cd, SLModifierBase)
function sl_modifier_bless_10208_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10208_cd.prototype.GetTexture(self)
	return "buff/bless/10208"
end
function sl_modifier_bless_10208_cd.prototype.IsPermanent(self)
	return false
end
function sl_modifier_bless_10208_cd.prototype.RemoveOnDeath(self)
	return true
end
sl_modifier_bless_10208_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10208") },
	sl_modifier_bless_10208_cd
)
____exports.sl_modifier_bless_10208_cd = sl_modifier_bless_10208_cd
return ____exports