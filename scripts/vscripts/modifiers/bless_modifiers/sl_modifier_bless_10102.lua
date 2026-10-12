--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10102.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10102.lua",
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
		["23"] = "12:9",
		["24"] = "10:5",
		["25"] = "15:5",
		["26"] = "16:9",
		["27"] = "15:5",
		["28"] = "19:5",
		["29"] = "20:9",
		["30"] = "19:5",
		["31"] = "25:5",
		["32"] = "26:14",
		["35"] = "27:14",
		["36"] = "27:14",
		["37"] = "27:14",
		["39"] = "27:14",
		["42"] = "28:9",
		["43"] = "29:9",
		["44"] = "25:5",
		["45"] = "32:5",
		["46"] = "33:9",
		["47"] = "32:5",
		["48"] = "36:5",
		["49"] = "37:9",
		["50"] = "36:5",
		["51"] = "40:5",
		["52"] = "41:9",
		["53"] = "40:5",
		["54"] = "44:5",
		["55"] = "45:14",
		["58"] = "46:17",
		["59"] = "46:17",
		["60"] = "46:17",
		["62"] = "46:17",
		["64"] = "46:17",
		["66"] = "46:9",
		["67"] = "44:5",
		["68"] = "49:5",
		["69"] = "50:14",
		["72"] = "51:17",
		["73"] = "51:17",
		["74"] = "51:17",
		["76"] = "51:17",
		["78"] = "51:17",
		["80"] = "51:9",
		["81"] = "49:5",
		["82"] = "5:14",
		["83"] = "4:2",
		["84"] = "4:2",
		["85"] = "4:19",
		["86"] = "4:2",
		["88"] = "4:2",
		["89"] = "5:14",
		["91"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10102 = __TS__Class()
local sl_modifier_bless_10102 = ____exports.sl_modifier_bless_10102
sl_modifier_bless_10102.name = "sl_modifier_bless_10102"
__TS__ClassExtends(sl_modifier_bless_10102, SLModifierBase)
function sl_modifier_bless_10102.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE, MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10102.prototype.OnCreated(self, params)
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10102.prototype.OnRefresh(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10102.prototype.GetTexture(self)
	return "buff/bless/10102"
end
function sl_modifier_bless_10102.prototype._ApplyParams(self, params)
	if not IsServer() then
		return
	end
	local ____params_pct_0 = params
	if ____params_pct_0 ~= nil then
		____params_pct_0 = ____params_pct_0.pct
	end
	if not ____params_pct_0 then
		return
	end
	self._params = params
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10102.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10102.prototype.AddCustomTransmitterData(self)
	return self._params
end
function sl_modifier_bless_10102.prototype.HandleCustomTransmitterData(self, data)
	self._params = data
end
function sl_modifier_bless_10102.prototype.GetModifierSpellAmplify_Percentage(self, event)
	if not self._params then
		return
	end
	local ____table__params_pct_2 = self._params
	if ____table__params_pct_2 ~= nil then
		____table__params_pct_2 = ____table__params_pct_2.pct
	end
	local ____table__params_pct_2_4 = ____table__params_pct_2
	if ____table__params_pct_2_4 == nil then
		____table__params_pct_2_4 = 0
	end
	return ____table__params_pct_2_4 * self:GetStackCount()
end
function sl_modifier_bless_10102.prototype.GetModifierBaseDamageOutgoing_Percentage(self, event)
	if not self._params then
		return
	end
	local ____table__params_pct_5 = self._params
	if ____table__params_pct_5 ~= nil then
		____table__params_pct_5 = ____table__params_pct_5.pct
	end
	local ____table__params_pct_5_7 = ____table__params_pct_5
	if ____table__params_pct_5_7 == nil then
		____table__params_pct_5_7 = 0
	end
	return ____table__params_pct_5_7 * self:GetStackCount()
end
sl_modifier_bless_10102 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10102", nil, getfenv()) },
	sl_modifier_bless_10102
)
____exports.sl_modifier_bless_10102 = sl_modifier_bless_10102
return ____exports