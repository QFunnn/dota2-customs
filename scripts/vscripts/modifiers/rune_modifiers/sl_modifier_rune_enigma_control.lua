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
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 弹道模拟飞行速度（TODO(API不确定): 目前没有可用的自定义弹道命中回调框架，接入 ability_global_thinker 后可替换为精确命中判定）
local ENIGMA_CONTROL_PROJECTILE_SPEED = 900
--- 每点智力或力量提升{hp_per_int_str}生命值<br>
-- 自身拥有的小黑球阵亡时，向最近的敌方英雄发射能量球，命中后造成{hps_pct}%目标当前生命值的伤害并眩晕{stun}秒<br>
-- 引力秒杀波将周围敌人眩晕{stun_mid}秒
____exports.sl_modifier_rune_enigma_control = __TS__Class()
local sl_modifier_rune_enigma_control = ____exports.sl_modifier_rune_enigma_control
sl_modifier_rune_enigma_control.name = "sl_modifier_rune_enigma_control"
__TS__ClassExtends(sl_modifier_rune_enigma_control, sl_modifier_rune_base)
function sl_modifier_rune_enigma_control.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_HEALTH_BONUS }
end
function sl_modifier_rune_enigma_control.prototype.GetModifierHealthBonus(self)
	local int_hp = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"int_hp",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("hp_per_int_str")
		end
	)
	local str_hp = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_STRENGTH,
		"str_hp",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("hp_per_int_str")
		end
	)
	return int_hp + str_hp
end
function sl_modifier_rune_enigma_control.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	LocalEvents:Register(tostring(self), "unit_death", function(____, event)
		local unit = event.unit
		if not IsValid(unit) then
			return
		end
		if not IsValid(parent) or unit:GetPlayerOwnerID() ~= parent:GetPlayerOwnerID() then
			return
		end
		if not __TS__StringIncludes(unit:GetUnitName(), "eidolon") then
			return
		end
		self:_OnEidolonDeath(parent, unit)
	end, self)
	LocalEvents:Register(tostring(self), "ability_fully_cast", function(____, event)
		local ability = event.ability
		if not IsValid(ability) or ability:GetAbilityName() ~= "enigma_midnight_pulse" then
			return
		end
		self:_OnMidnightPulse(parent, ability)
	end, self, parent:GetEntityIndex())
end
function sl_modifier_rune_enigma_control.prototype._OnEidolonDeath(self, parent, eidolon)
	local source_pos = eidolon:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		parent:GetTeam(),
		source_pos,
		nil,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	local target = enemies[1]
	if not IsValidAlive(target) then
		return
	end
	local hps_pct = self:_GetRuneSpecialValue("hps_pct")
	local stun = self:_GetRuneSpecialValue("stun")
	ProjectileManager:CreateTrackingProjectile({
		Source = eidolon,
		Target = target,
		vSourceLoc = source_pos,
		iMoveSpeed = ENIGMA_CONTROL_PROJECTILE_SPEED,
		bDodgeable = false,
		bVisibleToEnemies = true,
	})
	local distance = target:GetAbsOrigin():__sub(source_pos):Length2D()
	local travel_time = distance / ENIGMA_CONTROL_PROJECTILE_SPEED
	Timers:CreateTimer(travel_time, function()
		if not IsValid(parent) or not IsValidAlive(target) then
			return nil
		end
		local damage = target:GetHealth() * hps_pct / 100
		ApplyDamage({ attacker = parent, victim = target, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
		if stun > 0 then
			target:AddSLModifier(
				"modifier_stunned",
				{ caster = parent, duration = stun, calculate_status_resistance = true, no_error = true }
			)
		end
		return nil
	end)
end
function sl_modifier_rune_enigma_control.prototype._OnMidnightPulse(self, parent, ability)
	local stun_mid = self:_GetRuneSpecialValue("stun_mid")
	if stun_mid <= 0 then
		return
	end
	local radius = ability:GetSpecialValueFor("radius")
	local pos = ability:GetCursorPosition()
	local enemies = FindUnitsInRadius(
		parent:GetTeam(),
		pos,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		enemy:AddSLModifier("modifier_stunned", {
			caster = parent,
			ability = ability,
			duration = stun_mid,
			calculate_status_resistance = true,
			no_error = true,
		})
	end
end
function sl_modifier_rune_enigma_control.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	LocalEvents:Remove("unit_death", self)
	local parent = self:GetParent()
	if IsValid(parent) then
		LocalEvents:Remove("ability_fully_cast", self, parent:GetEntityIndex())
	end
end
sl_modifier_rune_enigma_control = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_enigma_control") },
	sl_modifier_rune_enigma_control
)
____exports.sl_modifier_rune_enigma_control = sl_modifier_rune_enigma_control
return ____exports