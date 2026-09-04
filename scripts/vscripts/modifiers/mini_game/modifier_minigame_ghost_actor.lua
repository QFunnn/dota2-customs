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
--- MG002 鬼的展示单位状态：只作为演出实体，不参与玩家交互与战斗。
____exports.modifier_minigame_ghost_actor = __TS__Class()
local modifier_minigame_ghost_actor = ____exports.modifier_minigame_ghost_actor
modifier_minigame_ghost_actor.name = "modifier_minigame_ghost_actor"
__TS__ClassExtends(modifier_minigame_ghost_actor, BaseModifier_CS)
function modifier_minigame_ghost_actor.prototype.OnCreated(self, params)
	self:SetStackCount(math.floor(tonumber(params and params.visual_z_delta) or 0))
end
function modifier_minigame_ghost_actor.prototype.OnRefresh(self, params)
	self:OnCreated(params)
end
function modifier_minigame_ghost_actor.prototype.IsHidden(self)
	return true
end
function modifier_minigame_ghost_actor.prototype.IsPurgable(self)
	return false
end
function modifier_minigame_ghost_actor.prototype.RemoveOnDeath(self)
	return false
end
function modifier_minigame_ghost_actor.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_VISUAL_Z_DELTA }
end
function modifier_minigame_ghost_actor.prototype.GetVisualZDelta(self)
	return self:GetStackCount()
end
function modifier_minigame_ghost_actor.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
end
modifier_minigame_ghost_actor = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_minigame_ghost_actor)
____exports.modifier_minigame_ghost_actor = modifier_minigame_ghost_actor
return ____exports