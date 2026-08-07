--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
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
--- 自动攻击的目标筛选条件（可见、非攻击免疫）
local SNAPFIRE_TARGET_FLAGS = DOTA_UNIT_TARGET_FLAG_CAN_BE_SEEN + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE
--- 自动攻击的目标优先级：英雄 > 小兵/信使 > 建筑
local SNAPFIRE_TARGET_TYPES = { DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_BUILDING }
--- 每点力量提升{hp_per_str}生命值，每点敏捷提升{batk_per_agi}基础攻击力，每点智力提升{amp_per_int}%技能增强<br>
-- 电炎绝手无法手动选择敌人，持续自动攻击射程内距离自身最近的敌人，优先攻击英雄；自动攻击不影响移动
--
-- 实现要点：
-- - 常驻缴械 + DISABLE_AUTOATTACK，禁止手动点选/引擎自动索敌打断移动
-- - 计时器间隔固定为 FrameTime（一帧），不用攻速折算间隔（攻速会频繁变化）
-- - 每帧按当前 GetSecondsPerAttack 累进攻击 CD 进度，就绪后对最近目标强制 PerformAttack
____exports.sl_modifier_rune_snapfire = __TS__Class()
local sl_modifier_rune_snapfire = ____exports.sl_modifier_rune_snapfire
sl_modifier_rune_snapfire.name = "sl_modifier_rune_snapfire"
__TS__ClassExtends(sl_modifier_rune_snapfire, sl_modifier_rune_base)
function sl_modifier_rune_snapfire.prototype.____constructor(self, ...)
	sl_modifier_rune_base.prototype.____constructor(self, ...)
	self._think_interval = 0
	self._attack_progress = 0
end
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
function sl_modifier_rune_snapfire.prototype.GetDisableAutoAttack(self)
	return 1
end
function sl_modifier_rune_snapfire.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
function sl_modifier_rune_snapfire.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._think_interval = FrameTime()
	self._attack_progress = 1
	self:StartIntervalThink(self._think_interval)
end
function sl_modifier_rune_snapfire.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(parent) then
		return
	end
	self:_AdvanceAttackProgress(parent)
	if self._attack_progress < 1 then
		return
	end
	if parent:IsStunned() or parent:IsHexed() or parent:IsNightmared() then
		return
	end
	local target = self:_FindAttackTarget(parent)
	if not IsValidAlive(target) then
		return
	end
	self._attack_progress = 0
	local use_projectile = parent:GetAttackCapability() ~= DOTA_UNIT_CAP_MELEE_ATTACK
	parent:PerformAttackWithFixedParams(
		{ record_context = self, fix_miss_on_out_of_attack_range = true },
		target,
		true,
		true,
		true,
		true,
		use_projectile,
		false,
		false
	)
end
function sl_modifier_rune_snapfire.prototype._AdvanceAttackProgress(self, parent)
	local seconds_per_attack = parent:GetSecondsPerAttack(false)
	if seconds_per_attack <= 0 then
		return
	end
	self._attack_progress = math.min(1, self._attack_progress + self._think_interval / seconds_per_attack)
end
function sl_modifier_rune_snapfire.prototype._FindAttackTarget(self, parent)
	local attack_range = parent:GetTotalAttackRangeWithBuffer()
	for ____, target_type in ipairs(SNAPFIRE_TARGET_TYPES) do
		local target = FindUnitsInRadius(
			parent:GetTeam(),
			parent:GetAbsOrigin(),
			nil,
			attack_range,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			target_type,
			SNAPFIRE_TARGET_FLAGS,
			FIND_CLOSEST,
			false
		)[1]
		if IsValidAlive(target) then
			return target
		end
	end
	return nil
end
sl_modifier_rune_snapfire = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_snapfire") },
	sl_modifier_rune_snapfire
)
____exports.sl_modifier_rune_snapfire = sl_modifier_rune_snapfire
return ____exports