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
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 2,
		["11"] = 2,
		["13"] = 5,
		["14"] = 6,
		["15"] = 5,
		["16"] = 6,
		["17"] = 7,
		["18"] = 8,
		["19"] = 7,
		["20"] = 11,
		["21"] = 12,
		["22"] = 11,
		["23"] = 15,
		["24"] = 16,
		["25"] = 15,
		["26"] = 19,
		["27"] = 20,
		["28"] = 20,
		["29"] = 20,
		["30"] = 20,
		["31"] = 20,
		["32"] = 20,
		["33"] = 20,
		["34"] = 20,
		["35"] = 20,
		["36"] = 20,
		["37"] = 20,
		["38"] = 19,
		["39"] = 6,
		["40"] = 5,
		["41"] = 6,
		["43"] = 6,
		["45"] = 35,
		["46"] = 36,
		["47"] = 35,
		["48"] = 36,
		["49"] = 37,
		["50"] = 38,
		["51"] = 37,
		["52"] = 41,
		["53"] = 42,
		["54"] = 41,
		["55"] = 45,
		["56"] = 46,
		["57"] = 45,
		["58"] = 49,
		["59"] = 50,
		["60"] = 50,
		["61"] = 50,
		["62"] = 50,
		["63"] = 50,
		["64"] = 50,
		["65"] = 50,
		["66"] = 50,
		["67"] = 49,
		["68"] = 36,
		["69"] = 35,
		["70"] = 36,
		["72"] = 36,
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- MG004 展示单位的纯静态状态。
____exports.modifier_mg004_display_stunned = __TS__Class()
local modifier_mg004_display_stunned = ____exports.modifier_mg004_display_stunned
modifier_mg004_display_stunned.name = "modifier_mg004_display_stunned"
__TS__ClassExtends(modifier_mg004_display_stunned, BaseModifier_CS)
function modifier_mg004_display_stunned.prototype.IsHidden(self)
	return true
end
function modifier_mg004_display_stunned.prototype.IsPurgable(self)
	return false
end
function modifier_mg004_display_stunned.prototype.RemoveOnDeath(self)
	return false
end
function modifier_mg004_display_stunned.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
	}
end
modifier_mg004_display_stunned = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_mg004_display_stunned)
____exports.modifier_mg004_display_stunned = modifier_mg004_display_stunned
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