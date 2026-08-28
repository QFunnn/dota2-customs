--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
--- 仅在连击 PerformAttack 期间短暂存在的隐藏致命一击 Buff
____exports.sl_modifier_bless_10203 = __TS__Class()
local sl_modifier_bless_10203 = ____exports.sl_modifier_bless_10203
sl_modifier_bless_10203.name = "sl_modifier_bless_10203"
__TS__ClassExtends(sl_modifier_bless_10203, SLModifierBase)
function sl_modifier_bless_10203.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._crit_pct = 0
end
function sl_modifier_bless_10203.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE }
end
function sl_modifier_bless_10203.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local ____params_crit_pct_0 = params
	if ____params_crit_pct_0 ~= nil then
		____params_crit_pct_0 = ____params_crit_pct_0.crit_pct
	end
	local ____params_crit_pct_0_2 = ____params_crit_pct_0
	if ____params_crit_pct_0_2 == nil then
		____params_crit_pct_0_2 = 0
	end
	self._crit_pct = ____params_crit_pct_0_2
end
function sl_modifier_bless_10203.prototype.GetModifierPreAttack_CriticalStrike(self, _event)
	return self._crit_pct
end
sl_modifier_bless_10203 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10203") },
	sl_modifier_bless_10203
)
____exports.sl_modifier_bless_10203 = sl_modifier_bless_10203
return ____exports