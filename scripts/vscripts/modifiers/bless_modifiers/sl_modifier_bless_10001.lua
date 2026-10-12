--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10001.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10001.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "7:1",
		["16"] = "8:14",
		["17"] = "7:1",
		["18"] = "8:38",
		["19"] = "8:14",
		["20"] = "7:2",
		["21"] = "7:2",
		["22"] = "7:19",
		["23"] = "7:2",
		["25"] = "7:2",
		["26"] = "8:14",
		["28"] = "8:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_override_attack_range = ____sl_modifier_simple.sl_modifier_override_attack_range
--- 移动速度和攻击速度
____exports.sl_modifier_bless_10001 = __TS__Class()
local sl_modifier_bless_10001 = ____exports.sl_modifier_bless_10001
sl_modifier_bless_10001.name = "sl_modifier_bless_10001"
__TS__ClassExtends(sl_modifier_bless_10001, sl_modifier_override_attack_range)
sl_modifier_bless_10001 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10001", nil, getfenv()) },
	sl_modifier_bless_10001
)
____exports.sl_modifier_bless_10001 = sl_modifier_bless_10001
return ____exports