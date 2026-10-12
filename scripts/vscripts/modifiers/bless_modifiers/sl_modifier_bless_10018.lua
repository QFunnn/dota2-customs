--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10018.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10018.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "3:1",
		["15"] = "3:10",
		["17"] = "8:1",
		["18"] = "9:14",
		["19"] = "8:1",
		["20"] = "9:38",
		["21"] = "10:5",
		["22"] = "11:9",
		["23"] = "10:5",
		["24"] = "14:5",
		["25"] = "15:9",
		["26"] = "14:5",
		["27"] = "9:14",
		["28"] = "8:2",
		["29"] = "8:2",
		["30"] = "8:19",
		["31"] = "8:2",
		["33"] = "8:2",
		["34"] = "9:14",
		["36"] = "9:14",
		["38"] = "22:1",
		["39"] = "23:14",
		["40"] = "22:1",
		["41"] = "23:41",
		["42"] = "24:5",
		["43"] = "25:9",
		["44"] = "24:5",
		["45"] = "28:5",
		["46"] = "29:9",
		["47"] = "28:5",
		["48"] = "23:14",
		["49"] = "22:2",
		["50"] = "22:2",
		["51"] = "22:19",
		["52"] = "22:2",
		["54"] = "22:2",
		["55"] = "23:14",
		["57"] = "23:14",
		["59"] = "36:1",
		["60"] = "37:14",
		["61"] = "36:1",
		["62"] = "37:45",
		["63"] = "37:14",
		["64"] = "36:2",
		["65"] = "36:2",
		["66"] = "36:19",
		["67"] = "36:2",
		["69"] = "36:2",
		["70"] = "37:14",
		["72"] = "37:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_shield_all = ____sl_modifier_simple.sl_modifier_shield_all
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- 10018 层数
____exports.sl_modifier_bless_10018 = __TS__Class()
local sl_modifier_bless_10018 = ____exports.sl_modifier_bless_10018
sl_modifier_bless_10018.name = "sl_modifier_bless_10018"
__TS__ClassExtends(sl_modifier_bless_10018, SLModifierBase)
function sl_modifier_bless_10018.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10018.prototype.GetTexture(self)
	return "buff/bless/10018"
end
sl_modifier_bless_10018 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10018", nil, getfenv()) },
	sl_modifier_bless_10018
)
____exports.sl_modifier_bless_10018 = sl_modifier_bless_10018
--- 10018 cd
____exports.sl_modifier_bless_10018_cd = __TS__Class()
local sl_modifier_bless_10018_cd = ____exports.sl_modifier_bless_10018_cd
sl_modifier_bless_10018_cd.name = "sl_modifier_bless_10018_cd"
__TS__ClassExtends(sl_modifier_bless_10018_cd, SLModifierBase)
function sl_modifier_bless_10018_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10018_cd.prototype.GetTexture(self)
	return "buff/bless/10018_cd"
end
sl_modifier_bless_10018_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10018", nil, getfenv()) },
	sl_modifier_bless_10018_cd
)
____exports.sl_modifier_bless_10018_cd = sl_modifier_bless_10018_cd
--- 护盾
____exports.sl_modifier_bless_10018_shield = __TS__Class()
local sl_modifier_bless_10018_shield = ____exports.sl_modifier_bless_10018_shield
sl_modifier_bless_10018_shield.name = "sl_modifier_bless_10018_shield"
__TS__ClassExtends(sl_modifier_bless_10018_shield, sl_modifier_shield_all)
sl_modifier_bless_10018_shield = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10018", nil, getfenv()) },
	sl_modifier_bless_10018_shield
)
____exports.sl_modifier_bless_10018_shield = sl_modifier_bless_10018_shield
return ____exports