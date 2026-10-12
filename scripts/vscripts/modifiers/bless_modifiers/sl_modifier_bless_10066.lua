--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10066.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10066.lua",
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
		["25"] = "15:14",
		["28"] = "16:9",
		["29"] = "17:9",
		["30"] = "14:5",
		["31"] = "20:5",
		["32"] = "21:14",
		["35"] = "22:9",
		["36"] = "20:5",
		["37"] = "27:5",
		["38"] = "28:14",
		["39"] = "28:14",
		["40"] = "28:14",
		["42"] = "28:14",
		["45"] = "29:9",
		["46"] = "30:9",
		["47"] = "27:5",
		["48"] = "33:5",
		["49"] = "34:9",
		["50"] = "33:5",
		["51"] = "37:5",
		["52"] = "38:9",
		["53"] = "37:5",
		["54"] = "42:5",
		["55"] = "43:9",
		["56"] = "42:5",
		["57"] = "51:5",
		["58"] = "52:16",
		["59"] = "52:40",
		["60"] = "52:40",
		["61"] = "52:40",
		["63"] = "52:40",
		["65"] = "52:40",
		["67"] = "52:9",
		["68"] = "51:5",
		["69"] = "55:5",
		["70"] = "56:16",
		["71"] = "56:40",
		["72"] = "56:40",
		["73"] = "56:40",
		["75"] = "56:40",
		["77"] = "56:40",
		["79"] = "56:9",
		["80"] = "55:5",
		["81"] = "5:14",
		["82"] = "4:2",
		["83"] = "4:2",
		["84"] = "4:19",
		["85"] = "4:2",
		["87"] = "4:2",
		["88"] = "5:14",
		["90"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10066 = __TS__Class()
local sl_modifier_bless_10066 = ____exports.sl_modifier_bless_10066
sl_modifier_bless_10066.name = "sl_modifier_bless_10066"
__TS__ClassExtends(sl_modifier_bless_10066, SLModifierBase)
function sl_modifier_bless_10066.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10066.prototype.GetTexture(self)
	return "buff/bless/10066"
end
function sl_modifier_bless_10066.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10066.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParams(params)
end
function sl_modifier_bless_10066.prototype._ApplyParams(self, params)
	local ____params_pct_per_stack_0 = params
	if ____params_pct_per_stack_0 ~= nil then
		____params_pct_per_stack_0 = ____params_pct_per_stack_0.pct_per_stack
	end
	if not ____params_pct_per_stack_0 then
		return
	end
	self._params = params
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10066.prototype.AddCustomTransmitterData(self)
	return self._params
end
function sl_modifier_bless_10066.prototype.HandleCustomTransmitterData(self, data)
	self._params = data
end
function sl_modifier_bless_10066.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE, MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE }
end
function sl_modifier_bless_10066.prototype.GetModifierBaseDamageOutgoing_Percentage(self, event)
	local ____temp_5 = self:GetStackCount()
	local ____table__params_pct_per_stack_2 = self._params
	if ____table__params_pct_per_stack_2 ~= nil then
		____table__params_pct_per_stack_2 = ____table__params_pct_per_stack_2.pct_per_stack
	end
	local ____table__params_pct_per_stack_2_4 = ____table__params_pct_per_stack_2
	if ____table__params_pct_per_stack_2_4 == nil then
		____table__params_pct_per_stack_2_4 = 0
	end
	return ____temp_5 * ____table__params_pct_per_stack_2_4
end
function sl_modifier_bless_10066.prototype.GetModifierSpellAmplify_Percentage(self, event)
	local ____temp_9 = self:GetStackCount()
	local ____table__params_pct_per_stack_6 = self._params
	if ____table__params_pct_per_stack_6 ~= nil then
		____table__params_pct_per_stack_6 = ____table__params_pct_per_stack_6.pct_per_stack
	end
	local ____table__params_pct_per_stack_6_8 = ____table__params_pct_per_stack_6
	if ____table__params_pct_per_stack_6_8 == nil then
		____table__params_pct_per_stack_6_8 = 0
	end
	return ____temp_9 * ____table__params_pct_per_stack_6_8
end
sl_modifier_bless_10066 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10066", nil, getfenv()) },
	sl_modifier_bless_10066
)
____exports.sl_modifier_bless_10066 = sl_modifier_bless_10066
return ____exports