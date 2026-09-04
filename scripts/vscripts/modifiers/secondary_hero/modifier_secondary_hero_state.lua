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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.modifier_secondary_hero_state = __TS__Class()
local modifier_secondary_hero_state = ____exports.modifier_secondary_hero_state
modifier_secondary_hero_state.name = "modifier_secondary_hero_state"
__TS__ClassExtends(modifier_secondary_hero_state, BaseModifier_CS)
function modifier_secondary_hero_state.prototype.IsHidden(self)
	return true
end
function modifier_secondary_hero_state.prototype.IsPurgable(self)
	return false
end
function modifier_secondary_hero_state.prototype.IsPurgeException(self)
	return false
end
function modifier_secondary_hero_state.prototype.IsPermanent(self)
	return true
end
function modifier_secondary_hero_state.prototype.RemoveOnDeath(self)
	return false
end
function modifier_secondary_hero_state.prototype.CheckState(self)
	return { [MODIFIER_STATE_UNSELECTABLE] = true }
end
modifier_secondary_hero_state = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_secondary_hero_state)
____exports.modifier_secondary_hero_state = modifier_secondary_hero_state
return ____exports