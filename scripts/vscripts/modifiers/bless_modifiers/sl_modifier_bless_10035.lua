--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10035.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10035.lua",
	{
		["10"] = "1:1",
		["11"] = "1:24",
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
		["24"] = "16:5",
		["25"] = "17:14",
		["28"] = "18:9",
		["29"] = "19:9",
		["30"] = "16:5",
		["31"] = "22:5",
		["32"] = "23:14",
		["35"] = "24:9",
		["36"] = "22:5",
		["37"] = "27:5",
		["38"] = "28:14",
		["41"] = "29:14",
		["42"] = "29:14",
		["43"] = "29:14",
		["45"] = "29:14",
		["48"] = "30:9",
		["49"] = "31:9",
		["50"] = "27:5",
		["51"] = "34:5",
		["52"] = "35:9",
		["53"] = "34:5",
		["54"] = "38:5",
		["55"] = "39:9",
		["56"] = "38:5",
		["57"] = "42:5",
		["58"] = "43:9",
		["59"] = "42:5",
		["60"] = "46:5",
		["61"] = "47:9",
		["62"] = "46:5",
		["63"] = "50:5",
		["64"] = "51:9",
		["65"] = "50:5",
		["66"] = "5:14",
		["67"] = "4:2",
		["68"] = "4:2",
		["69"] = "4:19",
		["70"] = "4:2",
		["72"] = "4:2",
		["73"] = "5:14",
		["75"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10035 = __TS__Class()
local sl_modifier_bless_10035 = ____exports.sl_modifier_bless_10035
sl_modifier_bless_10035.name = "sl_modifier_bless_10035"
__TS__ClassExtends(sl_modifier_bless_10035, SLModifierBase)
function sl_modifier_bless_10035.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10035.prototype.GetTexture(self)
	return "buff/bless/10035"
end
function sl_modifier_bless_10035.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParam(params)
end
function sl_modifier_bless_10035.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParam(params)
end
function sl_modifier_bless_10035.prototype._ApplyParam(self, params)
	if not IsServer() then
		return
	end
	local ____params_value_0 = params
	if ____params_value_0 ~= nil then
		____params_value_0 = ____params_value_0.value
	end
	if not ____params_value_0 then
		return
	end
	self._params = params
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10035.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE, MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_10035.prototype.HandleCustomTransmitterData(self, data)
	self._params = data
end
function sl_modifier_bless_10035.prototype.AddCustomTransmitterData(self)
	return self._params
end
function sl_modifier_bless_10035.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self._params.value
end
function sl_modifier_bless_10035.prototype.OnTooltip(self)
	return self._params.max
end
sl_modifier_bless_10035 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10035", nil, getfenv()) },
	sl_modifier_bless_10035
)
____exports.sl_modifier_bless_10035 = sl_modifier_bless_10035
return ____exports