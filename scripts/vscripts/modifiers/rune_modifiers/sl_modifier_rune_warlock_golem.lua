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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 每点智力提升{amp_per_int}%技能增强，每点智力或力量提升{hp_per_int_str}生命值<br>
-- 自身召唤的白牛额外继承自身{golem_hp_inherit_pct}%最大生命值，且每秒对周围300码敌人造成{dmg_hp_pct}%自身最大生命值的魔法伤害（受技能增强加成）
____exports.sl_modifier_rune_warlock_golem = __TS__Class()
local sl_modifier_rune_warlock_golem = ____exports.sl_modifier_rune_warlock_golem
sl_modifier_rune_warlock_golem.name = "sl_modifier_rune_warlock_golem"
__TS__ClassExtends(sl_modifier_rune_warlock_golem, sl_modifier_rune_base)
function sl_modifier_rune_warlock_golem.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE, MODIFIER_PROPERTY_HEALTH_BONUS }
end
function sl_modifier_rune_warlock_golem.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
end
function sl_modifier_rune_warlock_golem.prototype.GetModifierHealthBonus(self)
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
function sl_modifier_rune_warlock_golem.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	LocalEvents:Register(tostring(self), "unit_spawn", function(____, event)
		local unit = event.unit
		if not IsValid(unit) or unit:IsHero() then
			return
		end
		local parent = self:GetParent()
		if not IsValid(parent) or unit:GetOwner() ~= parent then
			return
		end
		if not __TS__StringIncludes(unit:GetUnitName(), "warlock_golem") then
			return
		end
		local golem_hp_inherit_pct = self:_GetRuneSpecialValue("golem_hp_inherit_pct")
		unit:AddSLModifier(____exports.sl_modifier_rune_warlock_golem_summon, {
			caster = parent,
			modifierTable = {
				hp_bonus = parent:GetMaxHealth() * golem_hp_inherit_pct / 100,
				dmg_hp_pct = self:_GetRuneSpecialValue("dmg_hp_pct"),
				jnzq_dmg_pct = self:_GetRuneSpecialValue("jnzq_dmg_pct"),
			},
		})
	end, self)
end
function sl_modifier_rune_warlock_golem.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	LocalEvents:Remove("unit_spawn", self)
end
sl_modifier_rune_warlock_golem = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_warlock_golem") },
	sl_modifier_rune_warlock_golem
)
____exports.sl_modifier_rune_warlock_golem = sl_modifier_rune_warlock_golem
--- 白牛专属：继承生命上限，并每秒对周围敌人造成AOE魔法伤害
____exports.sl_modifier_rune_warlock_golem_summon = __TS__Class()
local sl_modifier_rune_warlock_golem_summon = ____exports.sl_modifier_rune_warlock_golem_summon
sl_modifier_rune_warlock_golem_summon.name = "sl_modifier_rune_warlock_golem_summon"
__TS__ClassExtends(sl_modifier_rune_warlock_golem_summon, SLModifierBase)
function sl_modifier_rune_warlock_golem_summon.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._hp_bonus = 0
	self._dmg_hp_pct = 0
	self._jnzq_dmg_pct = 0
end
function sl_modifier_rune_warlock_golem_summon.prototype.IsHidden(self)
	return true
end
function sl_modifier_rune_warlock_golem_summon.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local ____params_hp_bonus_0 = params.hp_bonus
	if ____params_hp_bonus_0 == nil then
		____params_hp_bonus_0 = 0
	end
	self._hp_bonus = ____params_hp_bonus_0
	local ____params_dmg_hp_pct_1 = params.dmg_hp_pct
	if ____params_dmg_hp_pct_1 == nil then
		____params_dmg_hp_pct_1 = 0
	end
	self._dmg_hp_pct = ____params_dmg_hp_pct_1
	local ____params_jnzq_dmg_pct_2 = params.jnzq_dmg_pct
	if ____params_jnzq_dmg_pct_2 == nil then
		____params_jnzq_dmg_pct_2 = 0
	end
	self._jnzq_dmg_pct = ____params_jnzq_dmg_pct_2
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
	self:StartIntervalThink(1)
end
function sl_modifier_rune_warlock_golem_summon.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS }
end
function sl_modifier_rune_warlock_golem_summon.prototype.GetModifierExtraHealthBonus(self)
	return self._hp_bonus
end
function sl_modifier_rune_warlock_golem_summon.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local golem = self:GetParent()
	if not IsValidAlive(golem) then
		return
	end
	local caster = self:GetCaster()
	local ____IsValid_result_3
	if IsValid(caster) then
		____IsValid_result_3 = caster:GetSpellAmplification(false)
	else
		____IsValid_result_3 = 0
	end
	local spell_amp = ____IsValid_result_3
	local damage = golem:GetMaxHealth() * (self._dmg_hp_pct / 100) * (1 + spell_amp * 100 * self._jnzq_dmg_pct / 100)
	if damage <= 0 then
		return
	end
	local enemies = FindUnitsInRadius(
		golem:GetTeam(),
		golem:GetAbsOrigin(),
		nil,
		300,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		ApplyDamage({ attacker = golem, victim = enemy, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
	end
end
function sl_modifier_rune_warlock_golem_summon.prototype.AddCustomTransmitterData(self)
	return { hp_bonus = self._hp_bonus, dmg_hp_pct = self._dmg_hp_pct, jnzq_dmg_pct = self._jnzq_dmg_pct }
end
function sl_modifier_rune_warlock_golem_summon.prototype.HandleCustomTransmitterData(self, data)
	local ____data_hp_bonus_4 = data
	if ____data_hp_bonus_4 ~= nil then
		____data_hp_bonus_4 = ____data_hp_bonus_4.hp_bonus
	end
	local ____data_hp_bonus_4_6 = ____data_hp_bonus_4
	if ____data_hp_bonus_4_6 == nil then
		____data_hp_bonus_4_6 = 0
	end
	self._hp_bonus = ____data_hp_bonus_4_6
	local ____data_dmg_hp_pct_7 = data
	if ____data_dmg_hp_pct_7 ~= nil then
		____data_dmg_hp_pct_7 = ____data_dmg_hp_pct_7.dmg_hp_pct
	end
	local ____data_dmg_hp_pct_7_9 = ____data_dmg_hp_pct_7
	if ____data_dmg_hp_pct_7_9 == nil then
		____data_dmg_hp_pct_7_9 = 0
	end
	self._dmg_hp_pct = ____data_dmg_hp_pct_7_9
	local ____data_jnzq_dmg_pct_10 = data
	if ____data_jnzq_dmg_pct_10 ~= nil then
		____data_jnzq_dmg_pct_10 = ____data_jnzq_dmg_pct_10.jnzq_dmg_pct
	end
	local ____data_jnzq_dmg_pct_10_12 = ____data_jnzq_dmg_pct_10
	if ____data_jnzq_dmg_pct_10_12 == nil then
		____data_jnzq_dmg_pct_10_12 = 0
	end
	self._jnzq_dmg_pct = ____data_jnzq_dmg_pct_10_12
end
sl_modifier_rune_warlock_golem_summon = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_warlock_golem") },
	sl_modifier_rune_warlock_golem_summon
)
____exports.sl_modifier_rune_warlock_golem_summon = sl_modifier_rune_warlock_golem_summon
return ____exports