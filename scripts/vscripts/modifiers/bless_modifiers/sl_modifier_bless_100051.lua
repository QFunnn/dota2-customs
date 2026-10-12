--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_100051.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_100051.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:26",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:39",
		["18"] = "6:5",
		["19"] = "7:9",
		["20"] = "6:5",
		["21"] = "10:5",
		["22"] = "11:9",
		["23"] = "10:5",
		["24"] = "14:5",
		["25"] = "15:9",
		["26"] = "14:5",
		["27"] = "5:14",
		["28"] = "4:2",
		["29"] = "4:2",
		["30"] = "4:19",
		["31"] = "4:2",
		["33"] = "4:2",
		["34"] = "5:14",
		["36"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
____exports.sl_modifier_bless_100051 = __TS__Class()
local sl_modifier_bless_100051 = ____exports.sl_modifier_bless_100051
sl_modifier_bless_100051.name = "sl_modifier_bless_100051"
__TS__ClassExtends(sl_modifier_bless_100051, SLModifierBase_Debuff)
function sl_modifier_bless_100051.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_100051.prototype.GetTexture(self)
	return "buff/bless/100051"
end
function sl_modifier_bless_100051.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_PASSIVES_DISABLED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
	}
end
sl_modifier_bless_100051 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_100051", nil, getfenv()) },
	sl_modifier_bless_100051
)
____exports.sl_modifier_bless_100051 = sl_modifier_bless_100051
return ____exports