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
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_override_attack_rate = ____sl_modifier_simple.sl_modifier_override_attack_rate
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10031 = __TS__Class()
local sl_modifier_bless_10031 = ____exports.sl_modifier_bless_10031
sl_modifier_bless_10031.name = "sl_modifier_bless_10031"
__TS__ClassExtends(sl_modifier_bless_10031, SLModifierBase)
function sl_modifier_bless_10031.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10031.prototype.GetTexture(self)
	return "buff/bless/10031"
end
function sl_modifier_bless_10031.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._factor = params.factor
	self:SetHasCustomTransmitterData(true)
end
function sl_modifier_bless_10031.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE }
end
function sl_modifier_bless_10031.prototype.HandleCustomTransmitterData(self, data)
	self._factor = data.factor
end
function sl_modifier_bless_10031.prototype.AddCustomTransmitterData(self)
	return { factor = self._factor }
end
function sl_modifier_bless_10031.prototype.GetModifierPreAttack_BonusDamage(self)
	local ____self__factor_0 = self._factor
	if ____self__factor_0 == nil then
		____self__factor_0 = 0
	end
	local factor = ____self__factor_0
	return self:GetParent():GetAttackSpeed(false) * 100 * factor
end
sl_modifier_bless_10031 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10031") },
	sl_modifier_bless_10031
)
____exports.sl_modifier_bless_10031 = sl_modifier_bless_10031
____exports.sl_modifier_bless_10031_override_attack_rate = __TS__Class()
local sl_modifier_bless_10031_override_attack_rate = ____exports.sl_modifier_bless_10031_override_attack_rate
sl_modifier_bless_10031_override_attack_rate.name = "sl_modifier_bless_10031_override_attack_rate"
__TS__ClassExtends(sl_modifier_bless_10031_override_attack_rate, sl_modifier_override_attack_rate)
sl_modifier_bless_10031_override_attack_rate = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10031") },
	sl_modifier_bless_10031_override_attack_rate
)
____exports.sl_modifier_bless_10031_override_attack_rate = sl_modifier_bless_10031_override_attack_rate
return ____exports