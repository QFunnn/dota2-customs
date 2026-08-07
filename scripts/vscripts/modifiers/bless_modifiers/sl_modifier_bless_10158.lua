--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
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
____exports.sl_modifier_bless_10158 = __TS__Class()
local sl_modifier_bless_10158 = ____exports.sl_modifier_bless_10158
sl_modifier_bless_10158.name = "sl_modifier_bless_10158"
__TS__ClassExtends(sl_modifier_bless_10158, SLModifierBase)
function sl_modifier_bless_10158.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_DAMAGE_CALCULATED,
		MODIFIER_PROPERTY_IGNORE_ATTACKSPEED_LIMIT,
	}
end
function sl_modifier_bless_10158.prototype.GetModifierAttackSpeed_Limit(self)
	return 1
end
function sl_modifier_bless_10158.prototype.OnDamageCalculated(self, event)
	self:Destroy()
end
function sl_modifier_bless_10158.prototype.GetModifierAttackSpeedBonus_Constant(self)
	return 500
end
function sl_modifier_bless_10158.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local ____table_GetParent_result_AttackNoEarlierThan_result_0 = self:GetParent()
	if ____table_GetParent_result_AttackNoEarlierThan_result_0 ~= nil then
		____table_GetParent_result_AttackNoEarlierThan_result_0 =
			____table_GetParent_result_AttackNoEarlierThan_result_0:AttackNoEarlierThan(0, 0)
	end
end
sl_modifier_bless_10158 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10158") },
	sl_modifier_bless_10158
)
____exports.sl_modifier_bless_10158 = sl_modifier_bless_10158
return ____exports