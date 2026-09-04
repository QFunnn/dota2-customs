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
--- MG004 在入场、结算和重开阶段限制玩家操作。
____exports.modifier_mg004_player_lock = __TS__Class()
local modifier_mg004_player_lock = ____exports.modifier_mg004_player_lock
modifier_mg004_player_lock.name = "modifier_mg004_player_lock"
__TS__ClassExtends(modifier_mg004_player_lock, BaseModifier_CS)
function modifier_mg004_player_lock.prototype.IsHidden(self)
	return true
end
function modifier_mg004_player_lock.prototype.IsPurgable(self)
	return false
end
function modifier_mg004_player_lock.prototype.RemoveOnDeath(self)
	return false
end
function modifier_mg004_player_lock.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
	}
end
modifier_mg004_player_lock = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_mg004_player_lock)
____exports.modifier_mg004_player_lock = modifier_mg004_player_lock
return ____exports