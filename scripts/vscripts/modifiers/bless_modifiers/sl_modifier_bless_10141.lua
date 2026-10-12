--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10141.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10141.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["14"] = "3:40",
		["15"] = "5:1",
		["16"] = "6:14",
		["17"] = "5:1",
		["18"] = "6:38",
		["19"] = "7:5",
		["20"] = "8:9",
		["21"] = "7:5",
		["22"] = "11:5",
		["23"] = "12:9",
		["24"] = "11:5",
		["25"] = "15:5",
		["26"] = "16:9",
		["27"] = "15:5",
		["28"] = "19:5",
		["29"] = "20:16",
		["30"] = "20:16",
		["31"] = "20:16",
		["33"] = "20:9",
		["34"] = "19:5",
		["35"] = "23:5",
		["36"] = "24:16",
		["37"] = "24:16",
		["38"] = "24:16",
		["40"] = "24:9",
		["41"] = "23:5",
		["42"] = "6:14",
		["43"] = "5:2",
		["44"] = "5:2",
		["45"] = "5:19",
		["46"] = "5:2",
		["48"] = "5:2",
		["49"] = "6:14",
		["51"] = "6:14",
		["52"] = "33:1",
		["53"] = "34:14",
		["54"] = "33:1",
		["55"] = "34:45",
		["56"] = "35:5",
		["57"] = "36:9",
		["58"] = "35:5",
		["59"] = "39:5",
		["60"] = "40:9",
		["61"] = "39:5",
		["62"] = "43:5",
		["63"] = "44:9",
		["64"] = "43:5",
		["65"] = "47:5",
		["66"] = "48:16",
		["67"] = "48:16",
		["68"] = "48:16",
		["70"] = "48:9",
		["71"] = "47:5",
		["72"] = "34:14",
		["73"] = "33:2",
		["74"] = "33:2",
		["75"] = "33:19",
		["76"] = "33:2",
		["78"] = "33:2",
		["79"] = "34:14",
		["81"] = "34:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
local sl_modifier_transmitter_data_debuff = ____sl_modifier_simple.sl_modifier_transmitter_data_debuff
____exports.sl_modifier_bless_10141 = __TS__Class()
local sl_modifier_bless_10141 = ____exports.sl_modifier_bless_10141
sl_modifier_bless_10141.name = "sl_modifier_bless_10141"
__TS__ClassExtends(sl_modifier_bless_10141, sl_modifier_transmitter_data)
function sl_modifier_bless_10141.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10141.prototype.GetTexture(self)
	return "buff/bless/10141"
end
function sl_modifier_bless_10141.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE, MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT }
end
function sl_modifier_bless_10141.prototype.GetModifierDamageOutgoing_Percentage(self, event)
	local ____table__params_atk_pct_0 = self._params
	if ____table__params_atk_pct_0 ~= nil then
		____table__params_atk_pct_0 = ____table__params_atk_pct_0.atk_pct
	end
	return ____table__params_atk_pct_0 * self:GetStackCount()
end
function sl_modifier_bless_10141.prototype.GetModifierMoveSpeedBonus_Constant(self)
	local ____table__params_spd_2 = self._params
	if ____table__params_spd_2 ~= nil then
		____table__params_spd_2 = ____table__params_spd_2.spd
	end
	return ____table__params_spd_2 * self:GetStackCount()
end
sl_modifier_bless_10141 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10141", nil, getfenv()) },
	sl_modifier_bless_10141
)
____exports.sl_modifier_bless_10141 = sl_modifier_bless_10141
____exports.sl_modifier_bless_10141_debuff = __TS__Class()
local sl_modifier_bless_10141_debuff = ____exports.sl_modifier_bless_10141_debuff
sl_modifier_bless_10141_debuff.name = "sl_modifier_bless_10141_debuff"
__TS__ClassExtends(sl_modifier_bless_10141_debuff, sl_modifier_transmitter_data_debuff)
function sl_modifier_bless_10141_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10141_debuff.prototype.GetTexture(self)
	return "buff/bless/10141"
end
function sl_modifier_bless_10141_debuff.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end
function sl_modifier_bless_10141_debuff.prototype.GetModifierPhysicalArmorBonus(self, event)
	local ____table__params_armor_4 = self._params
	if ____table__params_armor_4 ~= nil then
		____table__params_armor_4 = ____table__params_armor_4.armor
	end
	return ____table__params_armor_4 * self:GetStackCount()
end
sl_modifier_bless_10141_debuff = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10141", nil, getfenv()) },
	sl_modifier_bless_10141_debuff
)
____exports.sl_modifier_bless_10141_debuff = sl_modifier_bless_10141_debuff
return ____exports