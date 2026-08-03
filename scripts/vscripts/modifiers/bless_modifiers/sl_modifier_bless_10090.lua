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
local sl_modifier_disable_healing = ____sl_modifier_simple.sl_modifier_disable_healing
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10090 = __TS__Class()
local sl_modifier_bless_10090 = ____exports.sl_modifier_bless_10090
sl_modifier_bless_10090.name = "sl_modifier_bless_10090"
__TS__ClassExtends(sl_modifier_bless_10090, SLModifierBase)
function sl_modifier_bless_10090.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._record = {}
end
function sl_modifier_bless_10090.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10090.prototype.SetSpecialTargetPct(self, unit, pct)
	self._record[unit] = pct
end
function sl_modifier_bless_10090.prototype.RemoveSpecialTargetPct(self, unit)
	self._record[unit] = nil
end
function sl_modifier_bless_10090.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	if not IsServer() then
		return
	end
	local ____event_0 = event
	local attacker = ____event_0.attacker
	local target = ____event_0.target
	if attacker ~= self:GetParent() then
		return
	end
	local ____self__record_target_1 = self._record[target]
	if ____self__record_target_1 == nil then
		____self__record_target_1 = 0
	end
	return ____self__record_target_1
end
sl_modifier_bless_10090 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10090") },
	sl_modifier_bless_10090
)
____exports.sl_modifier_bless_10090 = sl_modifier_bless_10090
____exports.sl_modifier_bless_10090_debuff = __TS__Class()
local sl_modifier_bless_10090_debuff = ____exports.sl_modifier_bless_10090_debuff
sl_modifier_bless_10090_debuff.name = "sl_modifier_bless_10090_debuff"
__TS__ClassExtends(sl_modifier_bless_10090_debuff, sl_modifier_disable_healing)
function sl_modifier_bless_10090_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10090_debuff.prototype.GetTexture(self)
	return "buff/bless/10090"
end
sl_modifier_bless_10090_debuff = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10090") },
	sl_modifier_bless_10090_debuff
)
____exports.sl_modifier_bless_10090_debuff = sl_modifier_bless_10090_debuff
return ____exports