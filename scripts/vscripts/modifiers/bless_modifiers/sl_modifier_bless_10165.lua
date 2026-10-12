--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10165.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10165.lua",
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
		["25"] = "15:16",
		["26"] = "15:16",
		["27"] = "15:16",
		["29"] = "15:9",
		["30"] = "14:5",
		["31"] = "18:5",
		["32"] = "19:16",
		["33"] = "19:16",
		["34"] = "19:16",
		["36"] = "19:9",
		["37"] = "18:5",
		["38"] = "22:5",
		["39"] = "23:9",
		["40"] = "22:5",
		["41"] = "26:5",
		["42"] = "27:9",
		["43"] = "26:5",
		["44"] = "5:14",
		["45"] = "4:2",
		["46"] = "4:2",
		["47"] = "4:19",
		["48"] = "4:2",
		["50"] = "4:2",
		["51"] = "5:14",
		["53"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10165 = __TS__Class()
local sl_modifier_bless_10165 = ____exports.sl_modifier_bless_10165
sl_modifier_bless_10165.name = "sl_modifier_bless_10165"
__TS__ClassExtends(sl_modifier_bless_10165, sl_modifier_transmitter_data)
function sl_modifier_bless_10165.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10165.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE, MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE }
end
function sl_modifier_bless_10165.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	return ____table__params_pct_0
end
function sl_modifier_bless_10165.prototype.GetModifierAttackSpeedPercentage(self)
	local ____table__params_pct_2 = self._params
	if ____table__params_pct_2 ~= nil then
		____table__params_pct_2 = ____table__params_pct_2.pct
	end
	return ____table__params_pct_2
end
function sl_modifier_bless_10165.prototype.GetTexture(self)
	return "buff/bless/10165"
end
function sl_modifier_bless_10165.prototype.GetEffectName(self)
	return BLESS_PARTICLES.bless_10165_buff
end
sl_modifier_bless_10165 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10165", nil, getfenv()) },
	sl_modifier_bless_10165
)
____exports.sl_modifier_bless_10165 = sl_modifier_bless_10165
return ____exports