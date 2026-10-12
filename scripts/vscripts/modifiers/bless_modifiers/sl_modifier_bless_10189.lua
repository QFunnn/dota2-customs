--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10189.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10189.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "7:1",
		["16"] = "8:14",
		["17"] = "7:1",
		["18"] = "8:38",
		["19"] = "9:5",
		["20"] = "10:9",
		["21"] = "9:5",
		["22"] = "13:5",
		["23"] = "14:9",
		["24"] = "13:5",
		["25"] = "8:14",
		["26"] = "7:2",
		["27"] = "7:2",
		["28"] = "7:19",
		["29"] = "7:2",
		["31"] = "7:2",
		["32"] = "8:14",
		["34"] = "8:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- 10189
____exports.sl_modifier_bless_10189 = __TS__Class()
local sl_modifier_bless_10189 = ____exports.sl_modifier_bless_10189
sl_modifier_bless_10189.name = "sl_modifier_bless_10189"
__TS__ClassExtends(sl_modifier_bless_10189, SLModifierBase)
function sl_modifier_bless_10189.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_IGNORE_ATTACKSPEED_LIMIT }
end
function sl_modifier_bless_10189.prototype.GetModifierAttackSpeed_Limit(self)
	return 1
end
sl_modifier_bless_10189 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10189", nil, getfenv()) },
	sl_modifier_bless_10189
)
____exports.sl_modifier_bless_10189 = sl_modifier_bless_10189
return ____exports