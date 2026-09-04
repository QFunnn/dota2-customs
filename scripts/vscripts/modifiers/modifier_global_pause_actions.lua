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
____exports.modifier_global_pause_actions = __TS__Class()
local modifier_global_pause_actions = ____exports.modifier_global_pause_actions
modifier_global_pause_actions.name = "modifier_global_pause_actions"
__TS__ClassExtends(modifier_global_pause_actions, BaseModifier)
function modifier_global_pause_actions.prototype.IsDebuff(self)
	return false
end
function modifier_global_pause_actions.prototype.IsPurgable(self)
	return false
end
function modifier_global_pause_actions.prototype.IsPurgeException(self)
	return false
end
function modifier_global_pause_actions.prototype.IsHidden(self)
	return true
end
function modifier_global_pause_actions.prototype.RemoveOnDeath(self)
	return false
end
function modifier_global_pause_actions.prototype.CheckState(self)
	local state = {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
	}
	return state
end
modifier_global_pause_actions = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_global_pause_actions)
____exports.modifier_global_pause_actions = modifier_global_pause_actions
return ____exports