--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10201.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10201.lua",
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
		["28"] = "19:17",
		["29"] = "19:17",
		["30"] = "19:17",
		["32"] = "19:17",
		["34"] = "19:17",
		["36"] = "19:9",
		["37"] = "18:5",
		["38"] = "5:14",
		["39"] = "4:2",
		["40"] = "4:2",
		["41"] = "4:19",
		["42"] = "4:2",
		["44"] = "4:2",
		["45"] = "5:14",
		["47"] = "5:14",
		["48"] = "27:1",
		["49"] = "28:14",
		["50"] = "27:1",
		["51"] = "28:42",
		["52"] = "29:5",
		["53"] = "30:9",
		["54"] = "29:5",
		["55"] = "33:5",
		["56"] = "34:9",
		["57"] = "33:5",
		["58"] = "37:5",
		["59"] = "38:9",
		["60"] = "37:5",
		["61"] = "41:5",
		["62"] = "42:16",
		["63"] = "42:16",
		["64"] = "42:16",
		["66"] = "42:9",
		["67"] = "41:5",
		["68"] = "28:14",
		["69"] = "27:2",
		["70"] = "27:2",
		["71"] = "27:19",
		["72"] = "27:2",
		["74"] = "27:2",
		["75"] = "28:14",
		["77"] = "28:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10201 = __TS__Class()
local sl_modifier_bless_10201 = ____exports.sl_modifier_bless_10201
sl_modifier_bless_10201.name = "sl_modifier_bless_10201"
__TS__ClassExtends(sl_modifier_bless_10201, sl_modifier_transmitter_data)
function sl_modifier_bless_10201.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10201.prototype.GetTexture(self)
	return "buff/bless/10201"
end
function sl_modifier_bless_10201.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function sl_modifier_bless_10201.prototype.GetModifierIncomingDamage_Percentage(self, event)
	local ____table__params_cs_pct_0 = self._params
	if ____table__params_cs_pct_0 ~= nil then
		____table__params_cs_pct_0 = ____table__params_cs_pct_0.cs_pct
	end
	local ____table__params_cs_pct_0_2 = ____table__params_cs_pct_0
	if ____table__params_cs_pct_0_2 == nil then
		____table__params_cs_pct_0_2 = 0
	end
	return ____table__params_cs_pct_0_2 * self:GetStackCount()
end
sl_modifier_bless_10201 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10201", nil, getfenv()) },
	sl_modifier_bless_10201
)
____exports.sl_modifier_bless_10201 = sl_modifier_bless_10201
____exports.sl_modifier_bless_10201_amp = __TS__Class()
local sl_modifier_bless_10201_amp = ____exports.sl_modifier_bless_10201_amp
sl_modifier_bless_10201_amp.name = "sl_modifier_bless_10201_amp"
__TS__ClassExtends(sl_modifier_bless_10201_amp, sl_modifier_transmitter_data)
function sl_modifier_bless_10201_amp.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10201_amp.prototype.GetTexture(self)
	return "buff/bless/10201"
end
function sl_modifier_bless_10201_amp.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE }
end
function sl_modifier_bless_10201_amp.prototype.GetModifierSpellAmplify_Percentage(self, event)
	local ____table__params_amp_3 = self._params
	if ____table__params_amp_3 ~= nil then
		____table__params_amp_3 = ____table__params_amp_3.amp
	end
	return ____table__params_amp_3
end
sl_modifier_bless_10201_amp = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10201", nil, getfenv()) },
	sl_modifier_bless_10201_amp
)
____exports.sl_modifier_bless_10201_amp = sl_modifier_bless_10201_amp
return ____exports