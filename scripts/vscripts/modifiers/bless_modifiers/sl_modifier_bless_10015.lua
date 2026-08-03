--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10015") },
	sl_modifier_bless_10015
)
____exports.sl_modifier_bless_10015 = sl_modifier_bless_10015
return ____exports