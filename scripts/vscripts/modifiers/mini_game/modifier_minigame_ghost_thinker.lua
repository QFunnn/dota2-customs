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
--- MG002 幽灵粒子的逻辑锚点，不参与原生单位碰撞。
____exports.modifier_minigame_ghost_thinker = __TS__Class()
local modifier_minigame_ghost_thinker = ____exports.modifier_minigame_ghost_thinker
modifier_minigame_ghost_thinker.name = "modifier_minigame_ghost_thinker"
__TS__ClassExtends(modifier_minigame_ghost_thinker, BaseModifier_CS)
function modifier_minigame_ghost_thinker.prototype.IsHidden(self)
	return true
end
function modifier_minigame_ghost_thinker.prototype.IsPurgable(self)
	return false
end
function modifier_minigame_ghost_thinker.prototype.RemoveOnDeath(self)
	return false
end
function modifier_minigame_ghost_thinker.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end
modifier_minigame_ghost_thinker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_minigame_ghost_thinker)
____exports.modifier_minigame_ghost_thinker = modifier_minigame_ghost_thinker
return ____exports