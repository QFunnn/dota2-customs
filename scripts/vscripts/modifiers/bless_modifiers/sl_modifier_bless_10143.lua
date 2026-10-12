--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10143.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10143.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["14"] = "5:1",
		["15"] = "6:14",
		["16"] = "5:1",
		["17"] = "6:38",
		["18"] = "7:5",
		["19"] = "8:9",
		["20"] = "7:5",
		["21"] = "11:5",
		["22"] = "12:9",
		["23"] = "11:5",
		["24"] = "15:5",
		["25"] = "16:9",
		["26"] = "15:5",
		["27"] = "19:5",
		["28"] = "20:16",
		["29"] = "20:16",
		["30"] = "20:16",
		["32"] = "20:16",
		["34"] = "20:16",
		["36"] = "20:9",
		["37"] = "19:5",
		["38"] = "23:5",
		["39"] = "24:16",
		["40"] = "24:16",
		["41"] = "24:16",
		["43"] = "24:16",
		["45"] = "24:16",
		["47"] = "24:9",
		["48"] = "23:5",
		["49"] = "27:5",
		["50"] = "28:16",
		["51"] = "28:16",
		["52"] = "28:16",
		["54"] = "28:16",
		["56"] = "28:16",
		["58"] = "28:9",
		["59"] = "27:5",
		["60"] = "31:5",
		["61"] = "32:16",
		["62"] = "32:16",
		["63"] = "32:16",
		["65"] = "32:9",
		["66"] = "31:5",
		["67"] = "35:5",
		["68"] = "36:14",
		["69"] = "37:13",
		["71"] = "41:9",
		["72"] = "41:22",
		["73"] = "41:29",
		["74"] = "41:38",
		["76"] = "41:38",
		["78"] = "41:29",
		["79"] = "41:64",
		["80"] = "41:73",
		["82"] = "41:73",
		["84"] = "41:9",
		["85"] = "42:9",
		["86"] = "35:5",
		["87"] = "6:14",
		["88"] = "5:2",
		["89"] = "5:2",
		["90"] = "5:19",
		["91"] = "5:2",
		["93"] = "5:2",
		["94"] = "6:14",
		["96"] = "6:14",
		["97"] = "58:1",
		["98"] = "59:14",
		["99"] = "58:1",
		["100"] = "59:39",
		["101"] = "59:14",
		["102"] = "58:2",
		["103"] = "58:2",
		["104"] = "58:19",
		["105"] = "58:2",
		["107"] = "58:2",
		["108"] = "59:14",
		["110"] = "59:14",
		["111"] = "60:1",
		["112"] = "61:14",
		["113"] = "60:1",
		["114"] = "61:39",
		["115"] = "61:14",
		["116"] = "60:2",
		["117"] = "60:2",
		["118"] = "60:19",
		["119"] = "60:2",
		["121"] = "60:2",
		["122"] = "61:14",
		["124"] = "61:14",
		["125"] = "62:1",
		["126"] = "63:14",
		["127"] = "62:1",
		["128"] = "63:39",
		["129"] = "63:14",
		["130"] = "62:2",
		["131"] = "62:2",
		["132"] = "62:19",
		["133"] = "62:2",
		["135"] = "62:2",
		["136"] = "63:14",
		["138"] = "63:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10143 = __TS__Class()
local sl_modifier_bless_10143 = ____exports.sl_modifier_bless_10143
sl_modifier_bless_10143.name = "sl_modifier_bless_10143"
__TS__ClassExtends(sl_modifier_bless_10143, sl_modifier_transmitter_data)
function sl_modifier_bless_10143.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10143.prototype.GetTexture(self)
	return "buff/bless/10143"
end
function sl_modifier_bless_10143.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end
function sl_modifier_bless_10143.prototype.GetModifierBonusStats_Strength(self)
	local ____table__params_str_0 = self._params
	if ____table__params_str_0 ~= nil then
		____table__params_str_0 = ____table__params_str_0.str
	end
	local ____table__params_str_0_2 = ____table__params_str_0
	if ____table__params_str_0_2 == nil then
		____table__params_str_0_2 = 0
	end
	return ____table__params_str_0_2
end
function sl_modifier_bless_10143.prototype.GetModifierBonusStats_Agility(self)
	local ____table__params_agi_3 = self._params
	if ____table__params_agi_3 ~= nil then
		____table__params_agi_3 = ____table__params_agi_3.agi
	end
	local ____table__params_agi_3_5 = ____table__params_agi_3
	if ____table__params_agi_3_5 == nil then
		____table__params_agi_3_5 = 0
	end
	return ____table__params_agi_3_5
end
function sl_modifier_bless_10143.prototype.GetModifierBonusStats_Intellect(self)
	local ____table__params_int_6 = self._params
	if ____table__params_int_6 ~= nil then
		____table__params_int_6 = ____table__params_int_6.int
	end
	local ____table__params_int_6_8 = ____table__params_int_6
	if ____table__params_int_6_8 == nil then
		____table__params_int_6_8 = 0
	end
	return ____table__params_int_6_8
end
function sl_modifier_bless_10143.prototype.Get10143BonusStats(self, key)
	local ____table__params_key_9 = self._params
	if ____table__params_key_9 ~= nil then
		____table__params_key_9 = ____table__params_key_9[key]
	end
	return ____table__params_key_9
end
function sl_modifier_bless_10143.prototype.Modify10143BonusStats(self, key, value)
	if not self._params then
		self._params = { update_data = 1 }
	end
	local ____self__params_16 = self._params
	local ____key_17 = key
	local ____tonumber_12 = tonumber
	local ____self__params_key_11 = self._params[key]
	if ____self__params_key_11 == nil then
		____self__params_key_11 = 0
	end
	local ____tonumber_12_result_15 = ____tonumber_12(____self__params_key_11)
	local ____tonumber_14 = tonumber
	local ____value_13 = value
	if ____value_13 == nil then
		____value_13 = 0
	end
	____self__params_16[____key_17] = ____tonumber_12_result_15 + ____tonumber_14(____value_13)
	self:_ApplyParams(self._params)
end
sl_modifier_bless_10143 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10143", nil, getfenv()) },
	sl_modifier_bless_10143
)
____exports.sl_modifier_bless_10143 = sl_modifier_bless_10143
____exports.sl_modifier_bless_10143a = __TS__Class()
local sl_modifier_bless_10143a = ____exports.sl_modifier_bless_10143a
sl_modifier_bless_10143a.name = "sl_modifier_bless_10143a"
__TS__ClassExtends(sl_modifier_bless_10143a, ____exports.sl_modifier_bless_10143)
sl_modifier_bless_10143a = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10143", nil, getfenv()) },
	sl_modifier_bless_10143a
)
____exports.sl_modifier_bless_10143a = sl_modifier_bless_10143a
____exports.sl_modifier_bless_10143b = __TS__Class()
local sl_modifier_bless_10143b = ____exports.sl_modifier_bless_10143b
sl_modifier_bless_10143b.name = "sl_modifier_bless_10143b"
__TS__ClassExtends(sl_modifier_bless_10143b, ____exports.sl_modifier_bless_10143)
sl_modifier_bless_10143b = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10143", nil, getfenv()) },
	sl_modifier_bless_10143b
)
____exports.sl_modifier_bless_10143b = sl_modifier_bless_10143b
____exports.sl_modifier_bless_10143c = __TS__Class()
local sl_modifier_bless_10143c = ____exports.sl_modifier_bless_10143c
sl_modifier_bless_10143c.name = "sl_modifier_bless_10143c"
__TS__ClassExtends(sl_modifier_bless_10143c, ____exports.sl_modifier_bless_10143)
sl_modifier_bless_10143c = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10143", nil, getfenv()) },
	sl_modifier_bless_10143c
)
____exports.sl_modifier_bless_10143c = sl_modifier_bless_10143c
return ____exports