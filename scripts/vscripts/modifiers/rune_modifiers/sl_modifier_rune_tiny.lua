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
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 投树命中点附近寻找目标发起强制攻击的范围
local TINY_TOSS_TREE_ATTACK_RADIUS = 250
--- 每点力量提升{hp_per_str}生命值，每点力量或敏捷提升{batk_per_str_agi}基础攻击力<br>
-- 投树命中位置生成一棵持续{temporary_tree_duration}秒的临时树，并对附近敌人发起一次强制攻击<br>
-- 18级以上获得强制飞行视野
____exports.sl_modifier_rune_tiny = __TS__Class()
local sl_modifier_rune_tiny = ____exports.sl_modifier_rune_tiny
sl_modifier_rune_tiny.name = "sl_modifier_rune_tiny"
__TS__ClassExtends(sl_modifier_rune_tiny, sl_modifier_rune_base)
function sl_modifier_rune_tiny.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_HEALTH_BONUS, MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE }
end
function sl_modifier_rune_tiny.prototype.GetModifierHealthBonus(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_STRENGTH, "hp_per_str", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("hp_per_str")
	end)
end
function sl_modifier_rune_tiny.prototype.GetModifierBaseAttack_BonusDamage(self)
	local str_atk = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_STRENGTH,
		"str_atk",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("batk_per_str_agi")
		end
	)
	local agi_atk = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_AGILITY,
		"agi_atk",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("batk_per_str_agi")
		end
	)
	return str_atk + agi_atk
end
function sl_modifier_rune_tiny.prototype.CheckState(self)
	local parent = self:GetParent()
	return { [MODIFIER_STATE_FORCED_FLYING_VISION] = IsValid(parent) and parent:GetLevel() >= 18 }
end
function sl_modifier_rune_tiny.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	LocalEvents:Register(tostring(self), "ability_fully_cast", function(____, event)
		local ability = event.ability
		if not IsValid(ability) or ability:GetAbilityName() ~= "tiny_toss_tree" then
			return
		end
		self:_OnTossTree(parent, ability)
	end, self, parent:GetEntityIndex())
end
function sl_modifier_rune_tiny.prototype._OnTossTree(self, parent, ability)
	local pos = ability:GetCursorPosition()
	local temporary_tree_duration = self:_GetRuneSpecialValue("temporary_tree_duration")
	if temporary_tree_duration > 0 then
		CreateTempTree(pos, temporary_tree_duration)
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeam(),
		pos,
		nil,
		TINY_TOSS_TREE_ATTACK_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	local target = enemies[1]
	if IsValidAlive(target) and IsValidAlive(parent) then
		parent:PerformAttackWithFixedParams(
			{ record_context = self },
			target,
			true,
			true,
			true,
			true,
			false,
			false,
			false
		)
	end
end
function sl_modifier_rune_tiny.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(parent) then
		LocalEvents:Remove("ability_fully_cast", self, parent:GetEntityIndex())
	end
end
sl_modifier_rune_tiny =
	__TS__Decorate({ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_tiny") }, sl_modifier_rune_tiny)
____exports.sl_modifier_rune_tiny = sl_modifier_rune_tiny
return ____exports