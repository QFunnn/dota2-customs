--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_21006.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_21006.lua",
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
		["25"] = "16:9",
		["26"] = "15:5",
		["27"] = "19:5",
		["28"] = "20:16",
		["29"] = "20:16",
		["30"] = "20:16",
		["32"] = "20:9",
		["33"] = "19:5",
		["34"] = "23:5",
		["35"] = "24:9",
		["36"] = "23:5",
		["37"] = "27:5",
		["38"] = "28:9",
		["39"] = "27:5",
		["40"] = "6:14",
		["41"] = "5:2",
		["42"] = "5:2",
		["43"] = "5:19",
		["44"] = "5:2",
		["46"] = "5:2",
		["47"] = "6:14",
		["49"] = "6:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_21006 = __TS__Class()
local sl_modifier_bless_21006 = ____exports.sl_modifier_bless_21006
sl_modifier_bless_21006.name = "sl_modifier_bless_21006"
__TS__ClassExtends(sl_modifier_bless_21006, sl_modifier_transmitter_data)
function sl_modifier_bless_21006.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_21006.prototype.GetTexture(self)
	return "buff/bless/21006"
end
function sl_modifier_bless_21006.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end
function sl_modifier_bless_21006.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	local ____table__params_ys_0 = self._params
	if ____table__params_ys_0 ~= nil then
		____table__params_ys_0 = ____table__params_ys_0.ys
	end
	return ____table__params_ys_0
end
function sl_modifier_bless_21006.prototype.GetEffectName(self)
	return BLESS_PARTICLES.bless_21006_buff
end
function sl_modifier_bless_21006.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
sl_modifier_bless_21006 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21006", nil, getfenv()) },
	sl_modifier_bless_21006
)
____exports.sl_modifier_bless_21006 = sl_modifier_bless_21006
return ____exports