--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10087.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10087.lua",
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
		["27"] = "23:5",
		["28"] = "24:9",
		["29"] = "25:9",
		["30"] = "23:5",
		["31"] = "28:5",
		["32"] = "29:9",
		["33"] = "28:5",
		["34"] = "33:5",
		["35"] = "34:14",
		["38"] = "35:14",
		["39"] = "35:14",
		["40"] = "35:14",
		["42"] = "35:14",
		["45"] = "36:9",
		["46"] = "33:5",
		["47"] = "39:5",
		["48"] = "40:9",
		["49"] = "39:5",
		["50"] = "43:5",
		["51"] = "44:9",
		["52"] = "43:5",
		["53"] = "47:5",
		["54"] = "48:17",
		["55"] = "48:17",
		["56"] = "48:17",
		["58"] = "48:17",
		["60"] = "48:17",
		["62"] = "48:9",
		["63"] = "47:5",
		["64"] = "51:5",
		["65"] = "52:17",
		["66"] = "52:17",
		["67"] = "52:17",
		["69"] = "52:17",
		["71"] = "52:17",
		["73"] = "52:9",
		["74"] = "51:5",
		["75"] = "5:14",
		["76"] = "4:2",
		["77"] = "4:2",
		["78"] = "4:19",
		["79"] = "4:2",
		["81"] = "4:2",
		["82"] = "5:14",
		["84"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10087 = __TS__Class()
local sl_modifier_bless_10087 = ____exports.sl_modifier_bless_10087
sl_modifier_bless_10087.name = "sl_modifier_bless_10087"
__TS__ClassExtends(sl_modifier_bless_10087, SLModifierBase)
function sl_modifier_bless_10087.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10087.prototype.GetTexture(self)
	return "buff/bless/10087"
end
function sl_modifier_bless_10087.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE, MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10087.prototype.OnCreated(self, params)
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10087.prototype.OnRefresh(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10087.prototype._ApplyParams(self, params)
	if not IsServer() then
		return
	end
	local ____params_bonus_pct_0 = params
	if ____params_bonus_pct_0 ~= nil then
		____params_bonus_pct_0 = ____params_bonus_pct_0.bonus_pct
	end
	if not ____params_bonus_pct_0 then
		return
	end
	self._params = params
end
function sl_modifier_bless_10087.prototype.AddCustomTransmitterData(self)
	return self._params
end
function sl_modifier_bless_10087.prototype.HandleCustomTransmitterData(self, data)
	self._params = data
end
function sl_modifier_bless_10087.prototype.GetModifierExtraHealthPercentage(self)
	local ____table__params_bonus_pct_2 = self._params
	if ____table__params_bonus_pct_2 ~= nil then
		____table__params_bonus_pct_2 = ____table__params_bonus_pct_2.bonus_pct
	end
	local ____table__params_bonus_pct_2_4 = ____table__params_bonus_pct_2
	if ____table__params_bonus_pct_2_4 == nil then
		____table__params_bonus_pct_2_4 = 0
	end
	return ____table__params_bonus_pct_2_4 * self:GetStackCount()
end
function sl_modifier_bless_10087.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	local ____table__params_bonus_pct_5 = self._params
	if ____table__params_bonus_pct_5 ~= nil then
		____table__params_bonus_pct_5 = ____table__params_bonus_pct_5.bonus_pct
	end
	local ____table__params_bonus_pct_5_7 = ____table__params_bonus_pct_5
	if ____table__params_bonus_pct_5_7 == nil then
		____table__params_bonus_pct_5_7 = 0
	end
	return ____table__params_bonus_pct_5_7 * self:GetStackCount()
end
sl_modifier_bless_10087 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10087", nil, getfenv()) },
	sl_modifier_bless_10087
)
____exports.sl_modifier_bless_10087 = sl_modifier_bless_10087
return ____exports