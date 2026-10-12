--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10022.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10022.lua",
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
		["30"] = "8:1",
		["31"] = "9:14",
		["32"] = "8:1",
		["33"] = "9:41",
		["34"] = "10:5",
		["35"] = "11:9",
		["36"] = "10:5",
		["37"] = "14:5",
		["38"] = "15:9",
		["39"] = "14:5",
		["40"] = "9:14",
		["41"] = "8:2",
		["42"] = "8:2",
		["43"] = "8:19",
		["44"] = "8:2",
		["46"] = "8:2",
		["47"] = "9:14",
		["49"] = "9:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_shield_all = ____sl_modifier_simple.sl_modifier_shield_all
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10022 = __TS__Class()
local sl_modifier_bless_10022 = ____exports.sl_modifier_bless_10022
sl_modifier_bless_10022.name = "sl_modifier_bless_10022"
__TS__ClassExtends(sl_modifier_bless_10022, sl_modifier_shield_all)
sl_modifier_bless_10022 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10022", nil, getfenv()) },
	sl_modifier_bless_10022
)
____exports.sl_modifier_bless_10022 = sl_modifier_bless_10022
____exports.sl_modifier_bless_10022_cd = __TS__Class()
local sl_modifier_bless_10022_cd = ____exports.sl_modifier_bless_10022_cd
sl_modifier_bless_10022_cd.name = "sl_modifier_bless_10022_cd"
__TS__ClassExtends(sl_modifier_bless_10022_cd, SLModifierBase)
function sl_modifier_bless_10022_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10022_cd.prototype.GetTexture(self)
	return "buff/bless/10022"
end
sl_modifier_bless_10022_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10022", nil, getfenv()) },
	sl_modifier_bless_10022_cd
)
____exports.sl_modifier_bless_10022_cd = sl_modifier_bless_10022_cd
return ____exports