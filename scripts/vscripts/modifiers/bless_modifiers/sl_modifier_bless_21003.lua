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
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_21003_ready = __TS__Class()
local sl_modifier_bless_21003_ready = ____exports.sl_modifier_bless_21003_ready
sl_modifier_bless_21003_ready.name = "sl_modifier_bless_21003_ready"
__TS__ClassExtends(sl_modifier_bless_21003_ready, SLModifierBase)
function sl_modifier_bless_21003_ready.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_21003_ready.prototype.GetTexture(self)
	return "buff/bless/21003"
end
sl_modifier_bless_21003_ready = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21003") },
	sl_modifier_bless_21003_ready
)
____exports.sl_modifier_bless_21003_ready = sl_modifier_bless_21003_ready
____exports.sl_modifier_bless_21003_cd = __TS__Class()
local sl_modifier_bless_21003_cd = ____exports.sl_modifier_bless_21003_cd
sl_modifier_bless_21003_cd.name = "sl_modifier_bless_21003_cd"
__TS__ClassExtends(sl_modifier_bless_21003_cd, SLModifierBase)
function sl_modifier_bless_21003_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_21003_cd.prototype.GetTexture(self)
	return "buff/bless/21003"
end
function sl_modifier_bless_21003_cd.prototype.SetSourceBless(self, bless)
	self._source_bless = bless
end
function sl_modifier_bless_21003_cd.prototype.OnDestroy(self)
	if self._source_bless and self._source_bless:IsValid() then
		self._source_bless:ReadyForShoot()
	end
end
sl_modifier_bless_21003_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21003") },
	sl_modifier_bless_21003_cd
)
____exports.sl_modifier_bless_21003_cd = sl_modifier_bless_21003_cd
____exports.sl_modifier_bless_21003_shooting = __TS__Class()
local sl_modifier_bless_21003_shooting = ____exports.sl_modifier_bless_21003_shooting
sl_modifier_bless_21003_shooting.name = "sl_modifier_bless_21003_shooting"
__TS__ClassExtends(sl_modifier_bless_21003_shooting, sl_modifier_transmitter_data)
function sl_modifier_bless_21003_shooting.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DISABLE_TURNING }
end
function sl_modifier_bless_21003_shooting.prototype.GetModifierDisableTurning(self)
	return 1
end
function sl_modifier_bless_21003_shooting.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
sl_modifier_bless_21003_shooting = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21003") },
	sl_modifier_bless_21003_shooting
)
____exports.sl_modifier_bless_21003_shooting = sl_modifier_bless_21003_shooting
return ____exports