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
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 同步最终攻击距离加成的间隔（秒）
local TECHIES_RANGE_THINK_INTERVAL = 0.1
--- 每点智力提升{amp_per_int}%技能增强，每点智力或敏捷提升{batk_per_int_agi}基础攻击力<br>
-- 每1点攻击速度增加{gjjl}点攻击距离（含超上限攻速，对齐替身攻击 Custom_GetTotalAttackSpeed）<br>
-- 最终攻击距离加成经 CustomTransmitterData 下发，供 tooltip 显示；不用 stack/图标层数
____exports.sl_modifier_rune_techies = __TS__Class()
local sl_modifier_rune_techies = ____exports.sl_modifier_rune_techies
sl_modifier_rune_techies.name = "sl_modifier_rune_techies"
__TS__ClassExtends(sl_modifier_rune_techies, sl_modifier_rune_base)
function sl_modifier_rune_techies.prototype.____constructor(self, ...)
	sl_modifier_rune_base.prototype.____constructor(self, ...)
	self._range_bonus = 0
end
function sl_modifier_rune_techies.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end
function sl_modifier_rune_techies.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
end
function sl_modifier_rune_techies.prototype.GetModifierBaseAttack_BonusDamage(self)
	local int_atk = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"int_atk",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("batk_per_int_agi")
		end
	)
	local agi_atk = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_AGILITY,
		"agi_atk",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("batk_per_int_agi")
		end
	)
	return int_atk + agi_atk
end
function sl_modifier_rune_techies.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(TECHIES_RANGE_THINK_INTERVAL)
	self:OnIntervalThink()
end
function sl_modifier_rune_techies.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local range_bonus = self:_CalculateAttackRangeBonus()
	if range_bonus == self._range_bonus then
		return
	end
	self._range_bonus = range_bonus
	self:SendBuffRefreshToClients()
end
function sl_modifier_rune_techies.prototype.GetModifierAttackRangeBonus(self)
	return self._range_bonus
end
function sl_modifier_rune_techies.prototype.OnTooltip(self)
	return self._range_bonus
end
function sl_modifier_rune_techies.prototype._CalculateAttackRangeBonus(self)
	local parent = self:GetParent()
	if not IsValid(parent) then
		return 0
	end
	local gjjl = self:_GetRuneSpecialValue("gjjl")
	local total_ats_display = math.floor(parent:Custom_GetTotalAttackSpeed(false) * 100)
	return math.floor(math.max(0, total_ats_display - 100) * gjjl)
end
function sl_modifier_rune_techies.prototype.HandleCustomTransmitterData(self, data)
	sl_modifier_rune_base.prototype.HandleCustomTransmitterData(self, data)
	local ____data_range_bonus_0 = data
	if ____data_range_bonus_0 ~= nil then
		____data_range_bonus_0 = ____data_range_bonus_0.range_bonus
	end
	local ____data_range_bonus_0_2 = ____data_range_bonus_0
	if ____data_range_bonus_0_2 == nil then
		____data_range_bonus_0_2 = 0
	end
	self._range_bonus = ____data_range_bonus_0_2
end
function sl_modifier_rune_techies.prototype.AddCustomTransmitterData(self)
	return __TS__ObjectAssign(
		{},
		sl_modifier_rune_base.prototype.AddCustomTransmitterData(self),
		{ range_bonus = self._range_bonus }
	)
end
sl_modifier_rune_techies = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_techies") },
	sl_modifier_rune_techies
)
____exports.sl_modifier_rune_techies = sl_modifier_rune_techies
return ____exports