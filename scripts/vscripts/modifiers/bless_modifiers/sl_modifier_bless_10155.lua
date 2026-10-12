--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10155.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10155.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "2:37",
		["15"] = "3:1",
		["16"] = "3:10",
		["17"] = "5:1",
		["18"] = "6:14",
		["19"] = "5:1",
		["20"] = "6:41",
		["21"] = "7:5",
		["22"] = "8:9",
		["23"] = "7:5",
		["24"] = "11:5",
		["25"] = "12:9",
		["26"] = "11:5",
		["27"] = "6:14",
		["28"] = "5:2",
		["29"] = "5:2",
		["30"] = "5:19",
		["31"] = "5:2",
		["33"] = "5:2",
		["34"] = "6:14",
		["36"] = "6:14",
		["37"] = "16:1",
		["38"] = "17:14",
		["39"] = "16:1",
		["40"] = "17:38",
		["41"] = "18:5",
		["42"] = "19:9",
		["43"] = "18:5",
		["44"] = "17:14",
		["45"] = "16:2",
		["46"] = "16:2",
		["47"] = "16:19",
		["48"] = "16:2",
		["50"] = "16:2",
		["51"] = "17:14",
		["53"] = "17:14",
		["54"] = "23:1",
		["55"] = "24:14",
		["56"] = "23:1",
		["57"] = "24:45",
		["58"] = "24:14",
		["59"] = "23:2",
		["60"] = "23:2",
		["61"] = "23:19",
		["62"] = "23:2",
		["64"] = "23:2",
		["65"] = "24:14",
		["67"] = "24:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_damage_income = ____sl_modifier_simple.sl_modifier_damage_income
local sl_modifier_shield_all = ____sl_modifier_simple.sl_modifier_shield_all
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10155_cd = __TS__Class()
local sl_modifier_bless_10155_cd = ____exports.sl_modifier_bless_10155_cd
sl_modifier_bless_10155_cd.name = "sl_modifier_bless_10155_cd"
__TS__ClassExtends(sl_modifier_bless_10155_cd, SLModifierBase)
function sl_modifier_bless_10155_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10155_cd.prototype.GetTexture(self)
	return "buff/bless/10155"
end
sl_modifier_bless_10155_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10155", nil, getfenv()) },
	sl_modifier_bless_10155_cd
)
____exports.sl_modifier_bless_10155_cd = sl_modifier_bless_10155_cd
____exports.sl_modifier_bless_10155 = __TS__Class()
local sl_modifier_bless_10155 = ____exports.sl_modifier_bless_10155
sl_modifier_bless_10155.name = "sl_modifier_bless_10155"
__TS__ClassExtends(sl_modifier_bless_10155, sl_modifier_damage_income)
function sl_modifier_bless_10155.prototype.GetEffectName(self)
	return GENERIC_PARTICLES.damage_dmgreduce
end
sl_modifier_bless_10155 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10155", nil, getfenv()) },
	sl_modifier_bless_10155
)
____exports.sl_modifier_bless_10155 = sl_modifier_bless_10155
____exports.sl_modifier_bless_10155_shield = __TS__Class()
local sl_modifier_bless_10155_shield = ____exports.sl_modifier_bless_10155_shield
sl_modifier_bless_10155_shield.name = "sl_modifier_bless_10155_shield"
__TS__ClassExtends(sl_modifier_bless_10155_shield, sl_modifier_shield_all)
sl_modifier_bless_10155_shield = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10155", nil, getfenv()) },
	sl_modifier_bless_10155_shield
)
____exports.sl_modifier_bless_10155_shield = sl_modifier_bless_10155_shield
return ____exports