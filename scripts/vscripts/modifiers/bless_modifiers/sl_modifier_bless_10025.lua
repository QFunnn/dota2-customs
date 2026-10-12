--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10025.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10025.lua",
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
		["20"] = "6:14",
		["21"] = "5:2",
		["22"] = "5:2",
		["23"] = "5:19",
		["24"] = "5:2",
		["26"] = "5:2",
		["27"] = "6:14",
		["29"] = "6:14",
		["30"] = "7:1",
		["31"] = "8:14",
		["32"] = "7:1",
		["33"] = "8:41",
		["34"] = "9:5",
		["35"] = "10:9",
		["36"] = "9:5",
		["37"] = "13:5",
		["38"] = "14:9",
		["39"] = "13:5",
		["40"] = "8:14",
		["41"] = "7:2",
		["42"] = "7:2",
		["43"] = "7:19",
		["44"] = "7:2",
		["46"] = "7:2",
		["47"] = "8:14",
		["49"] = "8:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_immune_damage = ____sl_modifier_simple.sl_modifier_immune_damage
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10025 = __TS__Class()
local sl_modifier_bless_10025 = ____exports.sl_modifier_bless_10025
sl_modifier_bless_10025.name = "sl_modifier_bless_10025"
__TS__ClassExtends(sl_modifier_bless_10025, sl_modifier_immune_damage)
sl_modifier_bless_10025 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10025", nil, getfenv()) },
	sl_modifier_bless_10025
)
____exports.sl_modifier_bless_10025 = sl_modifier_bless_10025
____exports.sl_modifier_bless_10025_cd = __TS__Class()
local sl_modifier_bless_10025_cd = ____exports.sl_modifier_bless_10025_cd
sl_modifier_bless_10025_cd.name = "sl_modifier_bless_10025_cd"
__TS__ClassExtends(sl_modifier_bless_10025_cd, SLModifierBase)
function sl_modifier_bless_10025_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10025_cd.prototype.GetTexture(self)
	return "buff/bless/10025"
end
sl_modifier_bless_10025_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10025", nil, getfenv()) },
	sl_modifier_bless_10025_cd
)
____exports.sl_modifier_bless_10025_cd = sl_modifier_bless_10025_cd
return ____exports