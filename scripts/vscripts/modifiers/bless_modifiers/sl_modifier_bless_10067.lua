--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10067.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10067.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["14"] = "5:1",
		["15"] = "6:14",
		["16"] = "5:1",
		["17"] = "6:38",
		["18"] = "7:5",
		["19"] = "8:9",
		["20"] = "7:5",
		["21"] = "11:5",
		["22"] = "12:9",
		["23"] = "11:5",
		["24"] = "15:5",
		["25"] = "20:14",
		["28"] = "6:46",
		["29"] = "15:5",
		["30"] = "24:5",
		["31"] = "29:9",
		["32"] = "6:46",
		["33"] = "24:5",
		["34"] = "6:14",
		["35"] = "5:2",
		["36"] = "5:2",
		["37"] = "5:19",
		["38"] = "5:2",
		["40"] = "5:2",
		["41"] = "6:14",
		["43"] = "6:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_shield_all = ____sl_modifier_simple.sl_modifier_shield_all
____exports.sl_modifier_bless_10067 = __TS__Class()
local sl_modifier_bless_10067 = ____exports.sl_modifier_bless_10067
sl_modifier_bless_10067.name = "sl_modifier_bless_10067"
__TS__ClassExtends(sl_modifier_bless_10067, sl_modifier_shield_all)
function sl_modifier_bless_10067.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10067.prototype.GetTexture(self)
	return "buff/bless/10067"
end
function sl_modifier_bless_10067.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	sl_modifier_shield_all.prototype.OnCreated(self, params)
end
function sl_modifier_bless_10067.prototype._ApplyParam(self, params)
	self:_SetParentAttr("ysI", params.msp)
	sl_modifier_shield_all.prototype._ApplyParam(self, params)
end
sl_modifier_bless_10067 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10067", nil, getfenv()) },
	sl_modifier_bless_10067
)
____exports.sl_modifier_bless_10067 = sl_modifier_bless_10067
return ____exports