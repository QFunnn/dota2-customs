--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10053.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10053.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "3:1",
		["15"] = "3:10",
		["16"] = "5:1",
		["17"] = "6:14",
		["18"] = "5:1",
		["19"] = "6:38",
		["20"] = "7:5",
		["21"] = "8:9",
		["22"] = "7:5",
		["23"] = "6:14",
		["24"] = "5:2",
		["25"] = "5:2",
		["26"] = "5:19",
		["27"] = "5:2",
		["29"] = "5:2",
		["30"] = "6:14",
		["32"] = "6:14",
		["33"] = "12:1",
		["34"] = "13:14",
		["35"] = "12:1",
		["36"] = "13:41",
		["37"] = "14:5",
		["38"] = "15:9",
		["39"] = "14:5",
		["40"] = "18:5",
		["41"] = "19:9",
		["42"] = "18:5",
		["43"] = "13:14",
		["44"] = "12:2",
		["45"] = "12:2",
		["46"] = "12:19",
		["47"] = "12:2",
		["49"] = "12:2",
		["50"] = "13:14",
		["52"] = "13:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_shield_all = ____sl_modifier_simple.sl_modifier_shield_all
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10053 = __TS__Class()
local sl_modifier_bless_10053 = ____exports.sl_modifier_bless_10053
sl_modifier_bless_10053.name = "sl_modifier_bless_10053"
__TS__ClassExtends(sl_modifier_bless_10053, sl_modifier_shield_all)
function sl_modifier_bless_10053.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
sl_modifier_bless_10053 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10053", nil, getfenv()) },
	sl_modifier_bless_10053
)
____exports.sl_modifier_bless_10053 = sl_modifier_bless_10053
____exports.sl_modifier_bless_10053_cd = __TS__Class()
local sl_modifier_bless_10053_cd = ____exports.sl_modifier_bless_10053_cd
sl_modifier_bless_10053_cd.name = "sl_modifier_bless_10053_cd"
__TS__ClassExtends(sl_modifier_bless_10053_cd, SLModifierBase)
function sl_modifier_bless_10053_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10053_cd.prototype.GetTexture(self)
	return "buff/bless/10053"
end
sl_modifier_bless_10053_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10053", nil, getfenv()) },
	sl_modifier_bless_10053_cd
)
____exports.sl_modifier_bless_10053_cd = sl_modifier_bless_10053_cd
return ____exports