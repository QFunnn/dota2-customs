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
--- 老莫的守护完成复活后的短暂无敌。
____exports.modifier_magic_tower_revive_invulnerable = __TS__Class()
local modifier_magic_tower_revive_invulnerable = ____exports.modifier_magic_tower_revive_invulnerable
modifier_magic_tower_revive_invulnerable.name = "modifier_magic_tower_revive_invulnerable"
__TS__ClassExtends(modifier_magic_tower_revive_invulnerable, BaseModifier_CS)
function modifier_magic_tower_revive_invulnerable.prototype.IsHidden(self)
	return true
end
function modifier_magic_tower_revive_invulnerable.prototype.IsPurgable(self)
	return false
end
function modifier_magic_tower_revive_invulnerable.prototype.IsPurgeException(self)
	return false
end
function modifier_magic_tower_revive_invulnerable.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
modifier_magic_tower_revive_invulnerable =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_magic_tower_revive_invulnerable)
____exports.modifier_magic_tower_revive_invulnerable = modifier_magic_tower_revive_invulnerable
return ____exports