--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/rune_modifiers/sl_modifier_rune_techies.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/rune_modifiers/sl_modifier_rune_techies.lua",
	{
		["11"] = "1:1",
		["12"] = "1:10",
		["13"] = "2:1",
		["14"] = "2:10",
		["16"] = "5:7",
		["20"] = "12:1",
		["21"] = "13:14",
		["22"] = "12:1",
		["23"] = "13:39",
		["25"] = "13:47",
		["26"] = "15:5",
		["27"] = "12:1",
		["28"] = "17:5",
		["29"] = "18:9",
		["30"] = "17:5",
		["31"] = "26:5",
		["32"] = "27:9",
		["33"] = "27:16",
		["34"] = "29:13",
		["35"] = "30:13",
		["36"] = "27:16",
		["37"] = "26:5",
		["38"] = "34:5",
		["39"] = "35:15",
		["40"] = "35:25",
		["41"] = "37:13",
		["42"] = "38:13",
		["43"] = "35:25",
		["44"] = "40:15",
		["45"] = "40:25",
		["46"] = "42:13",
		["47"] = "43:13",
		["48"] = "40:25",
		["49"] = "45:9",
		["50"] = "34:5",
		["51"] = "48:5",
		["52"] = "13:47",
		["53"] = "50:14",
		["56"] = "51:9",
		["57"] = "52:9",
		["58"] = "48:5",
		["59"] = "55:5",
		["60"] = "56:14",
		["63"] = "57:15",
		["64"] = "58:13",
		["67"] = "59:9",
		["68"] = "60:9",
		["69"] = "55:5",
		["70"] = "63:5",
		["71"] = "64:9",
		["72"] = "63:5",
		["73"] = "68:5",
		["74"] = "69:9",
		["75"] = "68:5",
		["76"] = "73:5",
		["77"] = "74:15",
		["78"] = "75:14",
		["79"] = "75:31",
		["81"] = "76:15",
		["82"] = "78:15",
		["83"] = "79:9",
		["84"] = "73:5",
		["85"] = "82:5",
		["86"] = "13:47",
		["87"] = "84:29",
		["88"] = "84:29",
		["89"] = "84:29",
		["91"] = "84:29",
		["93"] = "84:29",
		["95"] = "84:9",
		["96"] = "82:5",
		["97"] = "87:5",
		["98"] = "88:9",
		["99"] = "88:16",
		["100"] = "13:47",
		["101"] = "88:16",
		["102"] = "88:16",
		["103"] = "87:5",
		["104"] = "13:14",
		["105"] = "12:2",
		["106"] = "12:2",
		["107"] = "12:19",
		["108"] = "12:2",
		["110"] = "12:2",
		["111"] = "13:14",
		["113"] = "13:14",
	}
)
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
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_techies", nil, getfenv()) },
	sl_modifier_rune_techies
)
____exports.sl_modifier_rune_techies = sl_modifier_rune_techies
return ____exports