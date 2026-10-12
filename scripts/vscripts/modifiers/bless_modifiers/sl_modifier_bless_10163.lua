--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10163.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10163.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:38",
		["18"] = "6:5",
		["19"] = "7:9",
		["20"] = "6:5",
		["21"] = "10:5",
		["22"] = "11:9",
		["23"] = "10:5",
		["24"] = "5:14",
		["25"] = "4:2",
		["26"] = "4:2",
		["27"] = "4:19",
		["28"] = "4:2",
		["30"] = "4:2",
		["31"] = "5:14",
		["33"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10163 = __TS__Class()
local sl_modifier_bless_10163 = ____exports.sl_modifier_bless_10163
sl_modifier_bless_10163.name = "sl_modifier_bless_10163"
__TS__ClassExtends(sl_modifier_bless_10163, SLModifierBase)
function sl_modifier_bless_10163.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10163.prototype.GetTexture(self)
	return "buff/bless/10163"
end
sl_modifier_bless_10163 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10163", nil, getfenv()) },
	sl_modifier_bless_10163
)
____exports.sl_modifier_bless_10163 = sl_modifier_bless_10163
return ____exports