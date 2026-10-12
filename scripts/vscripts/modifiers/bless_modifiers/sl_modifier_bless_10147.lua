--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10147.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10147.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["14"] = "3:37",
		["15"] = "4:1",
		["16"] = "4:10",
		["17"] = "6:1",
		["18"] = "7:14",
		["19"] = "6:1",
		["20"] = "7:38",
		["21"] = "8:5",
		["22"] = "9:9",
		["23"] = "8:5",
		["24"] = "12:5",
		["25"] = "13:9",
		["26"] = "12:5",
		["27"] = "16:5",
		["28"] = "17:16",
		["29"] = "17:16",
		["30"] = "17:16",
		["32"] = "17:16",
		["34"] = "17:16",
		["36"] = "17:9",
		["37"] = "16:5",
		["38"] = "20:5",
		["39"] = "21:16",
		["40"] = "21:16",
		["41"] = "21:16",
		["43"] = "21:16",
		["45"] = "21:16",
		["47"] = "21:9",
		["48"] = "20:5",
		["49"] = "24:5",
		["50"] = "25:9",
		["51"] = "24:5",
		["52"] = "7:14",
		["53"] = "6:2",
		["54"] = "6:2",
		["55"] = "6:19",
		["56"] = "6:2",
		["58"] = "6:2",
		["59"] = "7:14",
		["61"] = "7:14",
		["62"] = "33:1",
		["63"] = "34:14",
		["64"] = "33:1",
		["65"] = "34:52",
		["66"] = "35:5",
		["67"] = "36:9",
		["68"] = "35:5",
		["69"] = "39:5",
		["70"] = "40:9",
		["71"] = "39:5",
		["72"] = "34:14",
		["73"] = "33:2",
		["74"] = "33:2",
		["75"] = "33:19",
		["76"] = "33:2",
		["78"] = "33:2",
		["79"] = "34:14",
		["81"] = "34:14",
		["82"] = "44:1",
		["83"] = "45:14",
		["84"] = "44:1",
		["85"] = "45:41",
		["86"] = "46:5",
		["87"] = "47:9",
		["88"] = "46:5",
		["89"] = "50:5",
		["90"] = "51:9",
		["91"] = "50:5",
		["92"] = "45:14",
		["93"] = "44:2",
		["94"] = "44:2",
		["95"] = "44:19",
		["96"] = "44:2",
		["98"] = "44:2",
		["99"] = "45:14",
		["101"] = "45:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_debuff_immune = ____sl_modifier_simple.sl_modifier_debuff_immune
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10147 = __TS__Class()
local sl_modifier_bless_10147 = ____exports.sl_modifier_bless_10147
sl_modifier_bless_10147.name = "sl_modifier_bless_10147"
__TS__ClassExtends(sl_modifier_bless_10147, sl_modifier_transmitter_data)
function sl_modifier_bless_10147.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10147.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE, MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end
function sl_modifier_bless_10147.prototype.GetModifierDamageOutgoing_Percentage(self, event)
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	local ____table__params_pct_0_2 = ____table__params_pct_0
	if ____table__params_pct_0_2 == nil then
		____table__params_pct_0_2 = 0
	end
	return ____table__params_pct_0_2
end
function sl_modifier_bless_10147.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	local ____table__params_pct_3 = self._params
	if ____table__params_pct_3 ~= nil then
		____table__params_pct_3 = ____table__params_pct_3.pct
	end
	local ____table__params_pct_3_5 = ____table__params_pct_3
	if ____table__params_pct_3_5 == nil then
		____table__params_pct_3_5 = 0
	end
	return ____table__params_pct_3_5
end
function sl_modifier_bless_10147.prototype.GetTexture(self)
	return "buff/bless/10147"
end
sl_modifier_bless_10147 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10147", nil, getfenv()) },
	sl_modifier_bless_10147
)
____exports.sl_modifier_bless_10147 = sl_modifier_bless_10147
____exports.sl_modifier_bless_10147_debuff_immune = __TS__Class()
local sl_modifier_bless_10147_debuff_immune = ____exports.sl_modifier_bless_10147_debuff_immune
sl_modifier_bless_10147_debuff_immune.name = "sl_modifier_bless_10147_debuff_immune"
__TS__ClassExtends(sl_modifier_bless_10147_debuff_immune, sl_modifier_debuff_immune)
function sl_modifier_bless_10147_debuff_immune.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10147_debuff_immune.prototype.GetTexture(self)
	return "buff/bless/10147"
end
sl_modifier_bless_10147_debuff_immune = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10147", nil, getfenv()) },
	sl_modifier_bless_10147_debuff_immune
)
____exports.sl_modifier_bless_10147_debuff_immune = sl_modifier_bless_10147_debuff_immune
____exports.sl_modifier_bless_10147_cd = __TS__Class()
local sl_modifier_bless_10147_cd = ____exports.sl_modifier_bless_10147_cd
sl_modifier_bless_10147_cd.name = "sl_modifier_bless_10147_cd"
__TS__ClassExtends(sl_modifier_bless_10147_cd, SLModifierBase)
function sl_modifier_bless_10147_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10147_cd.prototype.GetTexture(self)
	return "buff/bless/10147"
end
sl_modifier_bless_10147_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10147", nil, getfenv()) },
	sl_modifier_bless_10147_cd
)
____exports.sl_modifier_bless_10147_cd = sl_modifier_bless_10147_cd
return ____exports