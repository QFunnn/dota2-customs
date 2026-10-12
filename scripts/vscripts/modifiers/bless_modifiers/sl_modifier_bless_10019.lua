--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10019.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10019.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "7:1",
		["16"] = "8:14",
		["17"] = "7:1",
		["18"] = "8:45",
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
local sl_modifier_shield_all = ____sl_modifier_simple.sl_modifier_shield_all
--- 护盾
____exports.sl_modifier_bless_10019_shield = __TS__Class()
local sl_modifier_bless_10019_shield = ____exports.sl_modifier_bless_10019_shield
sl_modifier_bless_10019_shield.name = "sl_modifier_bless_10019_shield"
__TS__ClassExtends(sl_modifier_bless_10019_shield, sl_modifier_shield_all)
sl_modifier_bless_10019_shield = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10019", nil, getfenv()) },
	sl_modifier_bless_10019_shield
)
____exports.sl_modifier_bless_10019_shield = sl_modifier_bless_10019_shield
return ____exports