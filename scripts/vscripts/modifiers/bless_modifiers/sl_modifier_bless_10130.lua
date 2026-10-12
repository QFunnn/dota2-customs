--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10130.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10130.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["14"] = "3:37",
		["15"] = "5:1",
		["16"] = "6:14",
		["17"] = "5:1",
		["18"] = "6:38",
		["19"] = "7:5",
		["20"] = "8:9",
		["21"] = "7:5",
		["22"] = "11:5",
		["23"] = "12:9",
		["24"] = "11:5",
		["25"] = "15:5",
		["26"] = "16:9",
		["27"] = "15:5",
		["28"] = "19:5",
		["29"] = "20:16",
		["30"] = "20:16",
		["31"] = "20:16",
		["33"] = "20:9",
		["34"] = "19:5",
		["35"] = "6:14",
		["36"] = "5:2",
		["37"] = "5:2",
		["38"] = "5:19",
		["39"] = "5:2",
		["41"] = "5:2",
		["42"] = "6:14",
		["44"] = "6:14",
		["45"] = "28:1",
		["46"] = "29:14",
		["47"] = "28:1",
		["48"] = "29:45",
		["49"] = "30:5",
		["50"] = "31:9",
		["51"] = "30:5",
		["52"] = "34:5",
		["53"] = "35:9",
		["54"] = "34:5",
		["55"] = "29:14",
		["56"] = "28:2",
		["57"] = "28:2",
		["58"] = "28:19",
		["59"] = "28:2",
		["61"] = "28:2",
		["62"] = "29:14",
		["64"] = "29:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_debuff_immune = ____sl_modifier_simple.sl_modifier_debuff_immune
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10130 = __TS__Class()
local sl_modifier_bless_10130 = ____exports.sl_modifier_bless_10130
sl_modifier_bless_10130.name = "sl_modifier_bless_10130"
__TS__ClassExtends(sl_modifier_bless_10130, sl_modifier_transmitter_data)
function sl_modifier_bless_10130.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10130.prototype.GetTexture(self)
	return "buff/bless/10130"
end
function sl_modifier_bless_10130.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE }
end
function sl_modifier_bless_10130.prototype.GetModifierExtraHealthPercentage(self)
	local ____table__params_hp_pct_0 = self._params
	if ____table__params_hp_pct_0 ~= nil then
		____table__params_hp_pct_0 = ____table__params_hp_pct_0.hp_pct
	end
	return ____table__params_hp_pct_0
end
sl_modifier_bless_10130 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10130", nil, getfenv()) },
	sl_modifier_bless_10130
)
____exports.sl_modifier_bless_10130 = sl_modifier_bless_10130
____exports.sl_modifier_bless_10130_immune = __TS__Class()
local sl_modifier_bless_10130_immune = ____exports.sl_modifier_bless_10130_immune
sl_modifier_bless_10130_immune.name = "sl_modifier_bless_10130_immune"
__TS__ClassExtends(sl_modifier_bless_10130_immune, sl_modifier_debuff_immune)
function sl_modifier_bless_10130_immune.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10130_immune.prototype.GetTexture(self)
	return "buff/bless/10130"
end
sl_modifier_bless_10130_immune = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10130", nil, getfenv()) },
	sl_modifier_bless_10130_immune
)
____exports.sl_modifier_bless_10130_immune = sl_modifier_bless_10130_immune
return ____exports