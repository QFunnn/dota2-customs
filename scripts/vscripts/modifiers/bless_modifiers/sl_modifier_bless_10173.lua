--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10173.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10173.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["15"] = "8:1",
		["16"] = "9:14",
		["17"] = "8:1",
		["18"] = "9:38",
		["19"] = "10:5",
		["20"] = "11:9",
		["21"] = "10:5",
		["22"] = "14:5",
		["23"] = "15:9",
		["24"] = "14:5",
		["25"] = "18:5",
		["26"] = "19:9",
		["27"] = "18:5",
		["28"] = "22:5",
		["29"] = "23:16",
		["30"] = "23:40",
		["31"] = "23:40",
		["32"] = "23:40",
		["34"] = "23:40",
		["36"] = "23:40",
		["38"] = "23:9",
		["39"] = "22:5",
		["40"] = "9:14",
		["41"] = "8:2",
		["42"] = "8:2",
		["43"] = "8:19",
		["44"] = "8:2",
		["46"] = "8:2",
		["47"] = "9:14",
		["49"] = "9:14",
		["50"] = "27:1",
		["51"] = "28:14",
		["52"] = "27:1",
		["53"] = "28:43",
		["54"] = "29:5",
		["55"] = "30:9",
		["56"] = "29:5",
		["57"] = "33:5",
		["58"] = "34:9",
		["59"] = "33:5",
		["60"] = "37:5",
		["61"] = "38:9",
		["62"] = "37:5",
		["63"] = "41:5",
		["64"] = "42:9",
		["65"] = "41:5",
		["66"] = "45:5",
		["67"] = "46:16",
		["68"] = "46:16",
		["69"] = "46:16",
		["71"] = "46:16",
		["73"] = "46:16",
		["75"] = "46:9",
		["76"] = "45:5",
		["77"] = "28:14",
		["78"] = "27:2",
		["79"] = "27:2",
		["80"] = "27:19",
		["81"] = "27:2",
		["83"] = "27:2",
		["84"] = "28:14",
		["86"] = "28:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
--- 10173
____exports.sl_modifier_bless_10173 = __TS__Class()
local sl_modifier_bless_10173 = ____exports.sl_modifier_bless_10173
sl_modifier_bless_10173.name = "sl_modifier_bless_10173"
__TS__ClassExtends(sl_modifier_bless_10173, sl_modifier_transmitter_data)
function sl_modifier_bless_10173.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10173.prototype.GetTexture(self)
	return "buff/bless/10173"
end
function sl_modifier_bless_10173.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10173.prototype.GetModifierDamageOutgoing_Percentage(self, event)
	local ____temp_3 = self:GetStackCount()
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	local ____table__params_pct_0_2 = ____table__params_pct_0
	if ____table__params_pct_0_2 == nil then
		____table__params_pct_0_2 = 0
	end
	return ____temp_3 * ____table__params_pct_0_2
end
sl_modifier_bless_10173 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10173", nil, getfenv()) },
	sl_modifier_bless_10173
)
____exports.sl_modifier_bless_10173 = sl_modifier_bless_10173
____exports.sl_modifier_bless_10173_ally = __TS__Class()
local sl_modifier_bless_10173_ally = ____exports.sl_modifier_bless_10173_ally
sl_modifier_bless_10173_ally.name = "sl_modifier_bless_10173_ally"
__TS__ClassExtends(sl_modifier_bless_10173_ally, sl_modifier_transmitter_data)
function sl_modifier_bless_10173_ally.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10173_ally.prototype.GetTexture(self)
	return self:GetCaster():GetUnitName()
end
function sl_modifier_bless_10173_ally.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10173_ally.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10173_ally.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	local ____table__params_pct_4 = self._params
	if ____table__params_pct_4 ~= nil then
		____table__params_pct_4 = ____table__params_pct_4.pct
	end
	local ____table__params_pct_4_6 = ____table__params_pct_4
	if ____table__params_pct_4_6 == nil then
		____table__params_pct_4_6 = 0
	end
	return ____table__params_pct_4_6
end
sl_modifier_bless_10173_ally = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10173", nil, getfenv()) },
	sl_modifier_bless_10173_ally
)
____exports.sl_modifier_bless_10173_ally = sl_modifier_bless_10173_ally
return ____exports