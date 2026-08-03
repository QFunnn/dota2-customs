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
--- 火箭飞行器（Lil' Shredder）激活时的强制攻击检测间隔
local SNAPFIRE_SHREDDER_ATTACK_INTERVAL = 0.1
--- 每点力量提升{hp_per_str}生命值，每点敏捷提升{batk_per_agi}基础攻击力，每点智力提升{amp_per_int}%技能增强<br>
-- 火箭飞行器（Lil' Shredder）激活期间无法手动攻击，改为每{SNAPFIRE_SHREDDER_ATTACK_INTERVAL}秒自动强制攻击范围内敌人（优先英雄）
-- TODO(API不确定): "modifier_snapfire_lil_shredder_buff" 为约定命名，未在项目 Dota2Modifier 枚举中找到对应声明，建议实机验证具体 buff 名称是否一致。
____exports.sl_modifier_rune_snapfire = __TS__Class()
local sl_modifier_rune_snapfire = ____exports.sl_modifier_rune_snapfire
sl_modifier_rune_snapfire.name = "sl_modifier_rune_snapfire"
__TS__ClassExtends(sl_modifier_rune_snapfire, sl_modifier_rune_base)
function sl_modifier_rune_snapfire.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
	}
end
function sl_modifier_rune_snapfire.prototype.GetModifierHealthBonus(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_STRENGTH, "hp_per_str", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("hp_per_str")
	end)
end
function sl_modifier_rune_snapfire.prototype.GetModifierBaseAttack_BonusDamage(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_AGILITY, "batk_per_agi", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("batk_per_agi")
	end)
end
function sl_modifier_rune_snapfire.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
end
function sl_modifier_rune_snapfire.prototype._IsShredderActive(self)
	local parent = self:GetParent()
	return IsValid(parent) and parent:HasModifier(____exports.sl_modifier_rune_snapfire.SHREDDER_BUFF_NAME)
end
function sl_modifier_rune_snapfire.prototype.GetDisableAutoAttack(self)
	return self:_IsShredderActive() and 1 or 0
end
function sl_modifier_rune_snapfire.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(SNAPFIRE_SHREDDER_ATTACK_INTERVAL)
end
function sl_modifier_rune_snapfire.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(parent) then
		return
	end
	if not self:_IsShredderActive() then
		return
	end
	local attack_range = parent:GetTotalAttackRangeWithBuffer()
	local candidates = FindUnitsInRadius(
		parent:GetTeam(),
		parent:GetAbsOrigin(),
		nil,
		attack_range,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	if #candidates == 0 then
		return
	end
	local target
	for ____, unit in ipairs(candidates) do
		if unit:IsHero() then
			target = unit
			break
		end
		if target == nil then
			target = unit
		end
	end
	if not IsValidAlive(target) then
		return
	end
	parent:PerformAttackWithFixedParams({ record_context = self }, target, true, true, true, true, false, false, false)
end
sl_modifier_rune_snapfire.SHREDDER_BUFF_NAME = "modifier_snapfire_lil_shredder_buff"
sl_modifier_rune_snapfire = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_snapfire") },
	sl_modifier_rune_snapfire
)
____exports.sl_modifier_rune_snapfire = sl_modifier_rune_snapfire
return ____exports