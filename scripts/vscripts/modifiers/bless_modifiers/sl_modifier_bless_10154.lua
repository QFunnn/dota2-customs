--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10154.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10154.lua",
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
		["28"] = "20:17",
		["29"] = "20:17",
		["30"] = "20:17",
		["32"] = "20:17",
		["34"] = "20:17",
		["36"] = "20:9",
		["37"] = "19:5",
		["38"] = "6:14",
		["39"] = "5:2",
		["40"] = "5:2",
		["41"] = "5:19",
		["42"] = "5:2",
		["44"] = "5:2",
		["45"] = "6:14",
		["47"] = "6:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10154 = __TS__Class()
local sl_modifier_bless_10154 = ____exports.sl_modifier_bless_10154
sl_modifier_bless_10154.name = "sl_modifier_bless_10154"
__TS__ClassExtends(sl_modifier_bless_10154, sl_modifier_transmitter_data)
function sl_modifier_bless_10154.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10154.prototype.GetTexture(self)
	return "buff/bless/10154"
end
function sl_modifier_bless_10154.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING }
end
function sl_modifier_bless_10154.prototype.GetModifierStatusResistanceStacking(self)
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	local ____table__params_pct_0_2 = ____table__params_pct_0
	if ____table__params_pct_0_2 == nil then
		____table__params_pct_0_2 = 0
	end
	return ____table__params_pct_0_2 * self:GetStackCount()
end
sl_modifier_bless_10154 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10154", nil, getfenv()) },
	sl_modifier_bless_10154
)
____exports.sl_modifier_bless_10154 = sl_modifier_bless_10154
return ____exports