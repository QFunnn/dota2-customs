--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local BaseModifier = ____dota_ts_adapter.BaseModifier
____exports.modifier_pending_native_death_state = __TS__Class()
local modifier_pending_native_death_state = ____exports.modifier_pending_native_death_state
modifier_pending_native_death_state.name = "modifier_pending_native_death_state"
__TS__ClassExtends(modifier_pending_native_death_state, BaseModifier)
function modifier_pending_native_death_state.prototype.IsDebuff(self)
	return false
end
function modifier_pending_native_death_state.prototype.IsPurgable(self)
	return false
end
function modifier_pending_native_death_state.prototype.IsPurgeException(self)
	return false
end
function modifier_pending_native_death_state.prototype.IsHidden(self)
	return true
end
function modifier_pending_native_death_state.prototype.RemoveOnDeath(self)
	return false
end
function modifier_pending_native_death_state.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
	}
end
modifier_pending_native_death_state =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_pending_native_death_state)
____exports.modifier_pending_native_death_state = modifier_pending_native_death_state
return ____exports