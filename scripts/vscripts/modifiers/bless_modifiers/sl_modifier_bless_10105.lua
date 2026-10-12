--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10105.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10105.lua",
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
		["39"] = "27:13",
		["41"] = "27:44",
		["42"] = "27:44",
		["43"] = "27:44",
		["45"] = "27:44",
		["50"] = "28:9",
		["51"] = "29:9",
		["52"] = "25:5",
		["53"] = "32:5",
		["54"] = "33:9",
		["55"] = "32:5",
		["56"] = "36:5",
		["57"] = "37:9",
		["58"] = "36:5",
		["59"] = "40:5",
		["60"] = "41:9",
		["61"] = "40:5",
		["62"] = "44:5",
		["63"] = "45:16",
		["64"] = "45:40",
		["65"] = "45:40",
		["66"] = "45:40",
		["68"] = "45:40",
		["70"] = "45:40",
		["72"] = "45:9",
		["73"] = "44:5",
		["74"] = "48:5",
		["75"] = "49:16",
		["76"] = "49:40",
		["77"] = "49:40",
		["78"] = "49:40",
		["80"] = "49:40",
		["82"] = "49:40",
		["84"] = "49:9",
		["85"] = "48:5",
		["86"] = "5:14",
		["87"] = "4:2",
		["88"] = "4:2",
		["89"] = "4:19",
		["90"] = "4:2",
		["92"] = "4:2",
		["93"] = "5:14",
		["95"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10105 = __TS__Class()
local sl_modifier_bless_10105 = ____exports.sl_modifier_bless_10105
sl_modifier_bless_10105.name = "sl_modifier_bless_10105"
__TS__ClassExtends(sl_modifier_bless_10105, SLModifierBase)
function sl_modifier_bless_10105.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE, MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10105.prototype.OnCreated(self, params)
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10105.prototype.OnRefresh(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10105.prototype.GetTexture(self)
	return "buff/bless/10105"
end
function sl_modifier_bless_10105.prototype._ApplyParams(self, params)
	if not IsServer() then
		return
	end
	local ____params_dmg_out_per_stack_0 = params
	if ____params_dmg_out_per_stack_0 ~= nil then
		____params_dmg_out_per_stack_0 = ____params_dmg_out_per_stack_0.dmg_out_per_stack
	end
	local ____temp_4 = not ____params_dmg_out_per_stack_0
	if not ____temp_4 then
		local ____params_dmg_in_per_stack_2 = params
		if ____params_dmg_in_per_stack_2 ~= nil then
			____params_dmg_in_per_stack_2 = ____params_dmg_in_per_stack_2.dmg_in_per_stack
		end
		____temp_4 = not ____params_dmg_in_per_stack_2
	end
	if ____temp_4 then
		return
	end
	self._params = params
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10105.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10105.prototype.AddCustomTransmitterData(self)
	return self._params
end
function sl_modifier_bless_10105.prototype.HandleCustomTransmitterData(self, data)
	self._params = data
end
function sl_modifier_bless_10105.prototype.GetModifierIncomingDamage_Percentage(self, event)
	local ____temp_8 = self:GetStackCount()
	local ____table__params_dmg_in_per_stack_5 = self._params
	if ____table__params_dmg_in_per_stack_5 ~= nil then
		____table__params_dmg_in_per_stack_5 = ____table__params_dmg_in_per_stack_5.dmg_in_per_stack
	end
	local ____table__params_dmg_in_per_stack_5_7 = ____table__params_dmg_in_per_stack_5
	if ____table__params_dmg_in_per_stack_5_7 == nil then
		____table__params_dmg_in_per_stack_5_7 = 0
	end
	return ____temp_8 * ____table__params_dmg_in_per_stack_5_7
end
function sl_modifier_bless_10105.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	local ____temp_12 = self:GetStackCount()
	local ____table__params_dmg_out_per_stack_9 = self._params
	if ____table__params_dmg_out_per_stack_9 ~= nil then
		____table__params_dmg_out_per_stack_9 = ____table__params_dmg_out_per_stack_9.dmg_out_per_stack
	end
	local ____table__params_dmg_out_per_stack_9_11 = ____table__params_dmg_out_per_stack_9
	if ____table__params_dmg_out_per_stack_9_11 == nil then
		____table__params_dmg_out_per_stack_9_11 = 0
	end
	return ____temp_12 * ____table__params_dmg_out_per_stack_9_11
end
sl_modifier_bless_10105 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10105", nil, getfenv()) },
	sl_modifier_bless_10105
)
____exports.sl_modifier_bless_10105 = sl_modifier_bless_10105
return ____exports