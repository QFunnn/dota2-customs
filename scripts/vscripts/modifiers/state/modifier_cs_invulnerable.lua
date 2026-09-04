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
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.modifier_cs_invulnerable = __TS__Class()
local modifier_cs_invulnerable = ____exports.modifier_cs_invulnerable
modifier_cs_invulnerable.name = "modifier_cs_invulnerable"
__TS__ClassExtends(modifier_cs_invulnerable, BaseModifier)
function modifier_cs_invulnerable.prototype.IsDebuff(self)
	return false
end
function modifier_cs_invulnerable.prototype.IsHidden(self)
	return false
end
function modifier_cs_invulnerable.prototype.IsPurgable(self)
	return false
end
function modifier_cs_invulnerable.prototype.IsPurgeException(self)
	return false
end
function modifier_cs_invulnerable.prototype.IsPermanent(self)
	return false
end
function modifier_cs_invulnerable.prototype.RemoveOnDeath(self)
	return true
end
function modifier_cs_invulnerable.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
modifier_cs_invulnerable = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_cs_invulnerable)
____exports.modifier_cs_invulnerable = modifier_cs_invulnerable
return ____exports