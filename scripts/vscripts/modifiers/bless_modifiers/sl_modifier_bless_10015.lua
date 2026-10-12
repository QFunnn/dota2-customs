--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10015.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10015.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "7:1",
		["16"] = "8:14",
		["17"] = "7:1",
		["18"] = "8:38",
		["19"] = "9:5",
		["20"] = "10:9",
		["21"] = "9:5",
		["22"] = "13:5",
		["23"] = "14:9",
		["24"] = "13:5",
		["25"] = "17:5",
		["26"] = "18:9",
		["27"] = "19:9",
		["28"] = "17:5",
		["29"] = "22:5",
		["30"] = "23:9",
		["31"] = "22:5",
		["32"] = "26:5",
		["33"] = "27:14",
		["36"] = "28:14",
		["39"] = "29:9",
		["40"] = "30:9",
		["41"] = "26:5",
		["42"] = "35:5",
		["43"] = "36:9",
		["44"] = "35:5",
		["45"] = "39:5",
		["46"] = "40:9",
		["47"] = "39:5",
		["48"] = "43:5",
		["49"] = "44:9",
		["50"] = "43:5",
		["51"] = "47:5",
		["52"] = "48:16",
		["53"] = "48:16",
		["54"] = "48:16",
		["56"] = "48:9",
		["57"] = "47:5",
		["58"] = "51:5",
		["59"] = "52:16",
		["60"] = "52:16",
		["61"] = "52:16",
		["63"] = "52:9",
		["64"] = "51:5",
		["65"] = "55:5",
		["66"] = "56:9",
		["67"] = "55:5",
		["68"] = "8:14",
		["69"] = "7:2",
		["70"] = "7:2",
		["71"] = "7:19",
		["72"] = "7:2",
		["74"] = "7:2",
		["75"] = "8:14",
		["77"] = "8:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- 10015 伤害减免
____exports.sl_modifier_bless_10015 = __TS__Class()
local sl_modifier_bless_10015 = ____exports.sl_modifier_bless_10015
sl_modifier_bless_10015.name = "sl_modifier_bless_10015"
__TS__ClassExtends(sl_modifier_bless_10015, SLModifierBase)
function sl_modifier_bless_10015.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10015.prototype.GetTexture(self)
	return "buff/bless/10015"
end
function sl_modifier_bless_10015.prototype.OnCreated(self, params)
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParam(params)
end
function sl_modifier_bless_10015.prototype.OnRefresh(self, params)
	self:_ApplyParam(params)
end
function sl_modifier_bless_10015.prototype._ApplyParam(self, params)
	if not IsServer() then
		return
	end
	if not params.value or not params.mp then
		return
	end
	self._params = params
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10015.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE, MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT }
end
function sl_modifier_bless_10015.prototype.AddCustomTransmitterData(self)
	return self._params
end
function sl_modifier_bless_10015.prototype.HandleCustomTransmitterData(self, data)
	self._params = data
end
function sl_modifier_bless_10015.prototype.GetModifierIncomingDamage_Percentage(self, event)
	local ____table__params_value_0 = self._params
	if ____table__params_value_0 ~= nil then
		____table__params_value_0 = ____table__params_value_0.value
	end
	return ____table__params_value_0
end
function sl_modifier_bless_10015.prototype.GetModifierMoveSpeedBonus_Constant(self)
	local ____table__params_mp_2 = self._params
	if ____table__params_mp_2 ~= nil then
		____table__params_mp_2 = ____table__params_mp_2.mp
	end
	return ____table__params_mp_2
end
function sl_modifier_bless_10015.prototype.GetEffectName(self)
	return GENERIC_PARTICLES.damage_dmgreduce
end
sl_modifier_bless_10015 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10015", nil, getfenv()) },
	sl_modifier_bless_10015
)
____exports.sl_modifier_bless_10015 = sl_modifier_bless_10015
return ____exports