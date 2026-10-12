--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10026.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10026.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:38",
		["18"] = "6:5",
		["19"] = "7:9",
		["20"] = "6:5",
		["21"] = "10:5",
		["22"] = "11:9",
		["23"] = "10:5",
		["24"] = "14:5",
		["25"] = "15:9",
		["26"] = "14:5",
		["27"] = "18:5",
		["28"] = "19:9",
		["29"] = "18:5",
		["30"] = "5:14",
		["31"] = "4:2",
		["32"] = "4:2",
		["33"] = "4:19",
		["34"] = "4:2",
		["36"] = "4:2",
		["37"] = "5:14",
		["39"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_damage_output_debuff = ____sl_modifier_simple.sl_modifier_damage_output_debuff
____exports.sl_modifier_bless_10026 = __TS__Class()
local sl_modifier_bless_10026 = ____exports.sl_modifier_bless_10026
sl_modifier_bless_10026.name = "sl_modifier_bless_10026"
__TS__ClassExtends(sl_modifier_bless_10026, sl_modifier_damage_output_debuff)
function sl_modifier_bless_10026.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10026.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10026.prototype.GetEffectName(self)
	return BLESS_PARTICLES.bless_10026_debuff
end
function sl_modifier_bless_10026.prototype.GetTexture(self)
	return "buff/bless/10026"
end
sl_modifier_bless_10026 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10026", nil, getfenv()) },
	sl_modifier_bless_10026
)
____exports.sl_modifier_bless_10026 = sl_modifier_bless_10026
return ____exports