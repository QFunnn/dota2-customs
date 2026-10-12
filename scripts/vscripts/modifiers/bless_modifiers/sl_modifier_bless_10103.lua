--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10103.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10103.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "3:1",
		["15"] = "3:10",
		["16"] = "53:1",
		["17"] = "54:14",
		["18"] = "53:1",
		["19"] = "54:52",
		["20"] = "54:14",
		["21"] = "53:2",
		["22"] = "53:2",
		["23"] = "53:19",
		["24"] = "53:2",
		["26"] = "53:2",
		["27"] = "54:14",
		["29"] = "54:14",
		["30"] = "56:1",
		["31"] = "57:14",
		["32"] = "56:1",
		["33"] = "57:41",
		["34"] = "58:5",
		["35"] = "59:9",
		["36"] = "58:5",
		["37"] = "62:5",
		["38"] = "63:9",
		["39"] = "62:5",
		["40"] = "57:14",
		["41"] = "56:2",
		["42"] = "56:2",
		["43"] = "56:19",
		["44"] = "56:2",
		["46"] = "56:2",
		["47"] = "57:14",
		["49"] = "57:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_immune_damage = ____sl_modifier_simple.sl_modifier_immune_damage
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10103_immune_damage = __TS__Class()
local sl_modifier_bless_10103_immune_damage = ____exports.sl_modifier_bless_10103_immune_damage
sl_modifier_bless_10103_immune_damage.name = "sl_modifier_bless_10103_immune_damage"
__TS__ClassExtends(sl_modifier_bless_10103_immune_damage, sl_modifier_immune_damage)
sl_modifier_bless_10103_immune_damage = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10103", nil, getfenv()) },
	sl_modifier_bless_10103_immune_damage
)
____exports.sl_modifier_bless_10103_immune_damage = sl_modifier_bless_10103_immune_damage
____exports.sl_modifier_bless_10103_cd = __TS__Class()
local sl_modifier_bless_10103_cd = ____exports.sl_modifier_bless_10103_cd
sl_modifier_bless_10103_cd.name = "sl_modifier_bless_10103_cd"
__TS__ClassExtends(sl_modifier_bless_10103_cd, SLModifierBase)
function sl_modifier_bless_10103_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10103_cd.prototype.GetTexture(self)
	return "buff/bless/10103"
end
sl_modifier_bless_10103_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10103", nil, getfenv()) },
	sl_modifier_bless_10103_cd
)
____exports.sl_modifier_bless_10103_cd = sl_modifier_bless_10103_cd
return ____exports