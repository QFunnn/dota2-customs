--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_21002.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_21002.lua",
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
		["19"] = "6:44",
		["20"] = "7:5",
		["21"] = "8:9",
		["22"] = "7:5",
		["23"] = "11:5",
		["24"] = "12:9",
		["25"] = "11:5",
		["26"] = "6:14",
		["27"] = "5:2",
		["28"] = "5:2",
		["29"] = "5:19",
		["30"] = "5:2",
		["32"] = "5:2",
		["33"] = "6:14",
		["35"] = "6:14",
		["36"] = "16:1",
		["37"] = "17:14",
		["38"] = "16:1",
		["39"] = "17:41",
		["40"] = "18:5",
		["41"] = "19:9",
		["42"] = "18:5",
		["43"] = "22:5",
		["44"] = "23:9",
		["45"] = "22:5",
		["46"] = "17:14",
		["47"] = "16:2",
		["48"] = "16:2",
		["49"] = "16:19",
		["50"] = "16:2",
		["52"] = "16:2",
		["53"] = "17:14",
		["55"] = "17:14",
		["56"] = "27:1",
		["57"] = "28:14",
		["58"] = "27:1",
		["59"] = "28:43",
		["60"] = "29:5",
		["61"] = "30:9",
		["62"] = "29:5",
		["63"] = "33:5",
		["64"] = "34:9",
		["65"] = "33:5",
		["66"] = "28:14",
		["67"] = "27:2",
		["68"] = "27:2",
		["69"] = "27:19",
		["70"] = "27:2",
		["72"] = "27:2",
		["73"] = "28:14",
		["75"] = "28:14",
		["76"] = "38:1",
		["77"] = "39:14",
		["78"] = "38:1",
		["79"] = "39:48",
		["80"] = "39:14",
		["81"] = "38:2",
		["82"] = "38:2",
		["83"] = "38:19",
		["84"] = "38:2",
		["86"] = "38:2",
		["87"] = "39:14",
		["89"] = "39:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_custom_knockback = require("modifiers.game_modifiers.sl_modifier_custom_knockback")
local sl_modifier_custom_knockback = ____sl_modifier_custom_knockback.sl_modifier_custom_knockback
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_21002_ready = __TS__Class()
local sl_modifier_bless_21002_ready = ____exports.sl_modifier_bless_21002_ready
sl_modifier_bless_21002_ready.name = "sl_modifier_bless_21002_ready"
__TS__ClassExtends(sl_modifier_bless_21002_ready, SLModifierBase)
function sl_modifier_bless_21002_ready.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_21002_ready.prototype.GetTexture(self)
	return "buff/bless/21002"
end
sl_modifier_bless_21002_ready = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21002", nil, getfenv()) },
	sl_modifier_bless_21002_ready
)
____exports.sl_modifier_bless_21002_ready = sl_modifier_bless_21002_ready
____exports.sl_modifier_bless_21002_cd = __TS__Class()
local sl_modifier_bless_21002_cd = ____exports.sl_modifier_bless_21002_cd
sl_modifier_bless_21002_cd.name = "sl_modifier_bless_21002_cd"
__TS__ClassExtends(sl_modifier_bless_21002_cd, SLModifierBase)
function sl_modifier_bless_21002_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_21002_cd.prototype.GetTexture(self)
	return "buff/bless/21002"
end
sl_modifier_bless_21002_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21002", nil, getfenv()) },
	sl_modifier_bless_21002_cd
)
____exports.sl_modifier_bless_21002_cd = sl_modifier_bless_21002_cd
____exports.sl_modifier_bless_21002_buff = __TS__Class()
local sl_modifier_bless_21002_buff = ____exports.sl_modifier_bless_21002_buff
sl_modifier_bless_21002_buff.name = "sl_modifier_bless_21002_buff"
__TS__ClassExtends(sl_modifier_bless_21002_buff, SLModifierBase)
function sl_modifier_bless_21002_buff.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_21002_buff.prototype.GetTexture(self)
	return "buff/bless/21002"
end
sl_modifier_bless_21002_buff = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21002", nil, getfenv()) },
	sl_modifier_bless_21002_buff
)
____exports.sl_modifier_bless_21002_buff = sl_modifier_bless_21002_buff
____exports.sl_modifier_bless_21002_knockback = __TS__Class()
local sl_modifier_bless_21002_knockback = ____exports.sl_modifier_bless_21002_knockback
sl_modifier_bless_21002_knockback.name = "sl_modifier_bless_21002_knockback"
__TS__ClassExtends(sl_modifier_bless_21002_knockback, sl_modifier_custom_knockback)
sl_modifier_bless_21002_knockback = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21002", nil, getfenv()) },
	sl_modifier_bless_21002_knockback
)
____exports.sl_modifier_bless_21002_knockback = sl_modifier_bless_21002_knockback
return ____exports