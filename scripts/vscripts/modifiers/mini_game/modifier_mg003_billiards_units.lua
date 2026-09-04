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
____exports.modifier_mg003_billiards_ball_actor = __TS__Class()
local modifier_mg003_billiards_ball_actor = ____exports.modifier_mg003_billiards_ball_actor
modifier_mg003_billiards_ball_actor.name = "modifier_mg003_billiards_ball_actor"
__TS__ClassExtends(modifier_mg003_billiards_ball_actor, BaseModifier_CS)
function modifier_mg003_billiards_ball_actor.prototype.IsHidden(self)
	return true
end
function modifier_mg003_billiards_ball_actor.prototype.IsPurgable(self)
	return false
end
function modifier_mg003_billiards_ball_actor.prototype.RemoveOnDeath(self)
	return false
end
function modifier_mg003_billiards_ball_actor.prototype.GetAttributeBonus(self)
	return { min_health = 1 }
end
function modifier_mg003_billiards_ball_actor.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
end
modifier_mg003_billiards_ball_actor =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_mg003_billiards_ball_actor)
____exports.modifier_mg003_billiards_ball_actor = modifier_mg003_billiards_ball_actor
____exports.modifier_mg003_billiards_hidden_blocker = __TS__Class()
local modifier_mg003_billiards_hidden_blocker = ____exports.modifier_mg003_billiards_hidden_blocker
modifier_mg003_billiards_hidden_blocker.name = "modifier_mg003_billiards_hidden_blocker"
__TS__ClassExtends(modifier_mg003_billiards_hidden_blocker, BaseModifier_CS)
function modifier_mg003_billiards_hidden_blocker.prototype.IsHidden(self)
	return true
end
function modifier_mg003_billiards_hidden_blocker.prototype.IsPurgable(self)
	return false
end
function modifier_mg003_billiards_hidden_blocker.prototype.RemoveOnDeath(self)
	return false
end
function modifier_mg003_billiards_hidden_blocker.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
	}
end
modifier_mg003_billiards_hidden_blocker =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_mg003_billiards_hidden_blocker)
____exports.modifier_mg003_billiards_hidden_blocker = modifier_mg003_billiards_hidden_blocker
return ____exports