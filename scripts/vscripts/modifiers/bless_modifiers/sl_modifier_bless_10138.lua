--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10138.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10138.lua",
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
		["22"] = "12:16",
		["23"] = "12:16",
		["24"] = "12:16",
		["26"] = "12:9",
		["27"] = "11:5",
		["28"] = "15:5",
		["29"] = "16:16",
		["30"] = "16:16",
		["31"] = "16:16",
		["33"] = "16:9",
		["34"] = "15:5",
		["35"] = "19:5",
		["36"] = "20:9",
		["37"] = "19:5",
		["38"] = "23:5",
		["39"] = "24:9",
		["40"] = "23:5",
		["41"] = "6:14",
		["42"] = "5:2",
		["43"] = "5:2",
		["44"] = "5:19",
		["45"] = "5:2",
		["47"] = "5:2",
		["48"] = "6:14",
		["50"] = "6:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10138 = __TS__Class()
local sl_modifier_bless_10138 = ____exports.sl_modifier_bless_10138
sl_modifier_bless_10138.name = "sl_modifier_bless_10138"
__TS__ClassExtends(sl_modifier_bless_10138, sl_modifier_transmitter_data)
function sl_modifier_bless_10138.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP, MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE }
end
function sl_modifier_bless_10138.prototype.GetModifierSpellAmplify_Percentage(self, event)
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	return ____table__params_pct_0
end
function sl_modifier_bless_10138.prototype.OnTooltip(self)
	local ____table__params_max_2 = self._params
	if ____table__params_max_2 ~= nil then
		____table__params_max_2 = ____table__params_max_2.max
	end
	return ____table__params_max_2
end
function sl_modifier_bless_10138.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10138.prototype.GetTexture(self)
	return "buff/bless/10138"
end
sl_modifier_bless_10138 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10138", nil, getfenv()) },
	sl_modifier_bless_10138
)
____exports.sl_modifier_bless_10138 = sl_modifier_bless_10138
return ____exports