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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- MG002 被幽灵抓到后的短暂停顿状态。
____exports.modifier_minigame_ghost_hit_freeze = __TS__Class()
local modifier_minigame_ghost_hit_freeze = ____exports.modifier_minigame_ghost_hit_freeze
modifier_minigame_ghost_hit_freeze.name = "modifier_minigame_ghost_hit_freeze"
__TS__ClassExtends(modifier_minigame_ghost_hit_freeze, BaseModifier_CS)
function modifier_minigame_ghost_hit_freeze.prototype.IsHidden(self)
	return false
end
function modifier_minigame_ghost_hit_freeze.prototype.IsPurgable(self)
	return false
end
function modifier_minigame_ghost_hit_freeze.prototype.RemoveOnDeath(self)
	return false
end
function modifier_minigame_ghost_hit_freeze.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FROZEN] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
modifier_minigame_ghost_hit_freeze = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_minigame_ghost_hit_freeze)
____exports.modifier_minigame_ghost_hit_freeze = modifier_minigame_ghost_hit_freeze
return ____exports