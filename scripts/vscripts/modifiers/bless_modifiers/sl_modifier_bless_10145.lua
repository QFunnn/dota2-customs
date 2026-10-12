--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10145.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10145.lua",
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
		["32"] = "20:9",
		["33"] = "19:5",
		["34"] = "23:5",
		["35"] = "24:29",
		["36"] = "24:29",
		["37"] = "24:29",
		["39"] = "24:29",
		["41"] = "24:29",
		["43"] = "24:15",
		["44"] = "25:9",
		["45"] = "29:9",
		["46"] = "23:5",
		["47"] = "6:14",
		["48"] = "5:2",
		["49"] = "5:2",
		["50"] = "5:19",
		["51"] = "5:2",
		["53"] = "5:2",
		["54"] = "6:14",
		["56"] = "6:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10145 = __TS__Class()
local sl_modifier_bless_10145 = ____exports.sl_modifier_bless_10145
sl_modifier_bless_10145.name = "sl_modifier_bless_10145"
__TS__ClassExtends(sl_modifier_bless_10145, sl_modifier_transmitter_data)
function sl_modifier_bless_10145.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10145.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE }
end
function sl_modifier_bless_10145.prototype.GetTexture(self)
	return "buff/bless/10145"
end
function sl_modifier_bless_10145.prototype.GetModifierPercentageCooldown(self, event)
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	return ____table__params_pct_0
end
function sl_modifier_bless_10145.prototype.ModifyAttr(self, value)
	local ____table__params_pct_2 = self._params
	if ____table__params_pct_2 ~= nil then
		____table__params_pct_2 = ____table__params_pct_2.pct
	end
	local ____table__params_pct_2_4 = ____table__params_pct_2
	if ____table__params_pct_2_4 == nil then
		____table__params_pct_2_4 = 0
	end
	local current_pct = ____table__params_pct_2_4
	self._params = { pct = current_pct + value, update_data = 1 }
	self:_ApplyParams(self._params)
end
sl_modifier_bless_10145 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10145", nil, getfenv()) },
	sl_modifier_bless_10145
)
____exports.sl_modifier_bless_10145 = sl_modifier_bless_10145
return ____exports