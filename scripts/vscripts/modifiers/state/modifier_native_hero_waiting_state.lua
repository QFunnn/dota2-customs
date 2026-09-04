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
--- 原生英雄等待态：职业英雄创建前彻底隔离玩家初始英雄。
____exports.modifier_native_hero_waiting_state = __TS__Class()
local modifier_native_hero_waiting_state = ____exports.modifier_native_hero_waiting_state
modifier_native_hero_waiting_state.name = "modifier_native_hero_waiting_state"
__TS__ClassExtends(modifier_native_hero_waiting_state, BaseModifier_CS)
function modifier_native_hero_waiting_state.prototype.IsHidden(self)
	return true
end
function modifier_native_hero_waiting_state.prototype.IsDebuff(self)
	return false
end
function modifier_native_hero_waiting_state.prototype.IsPurgable(self)
	return false
end
function modifier_native_hero_waiting_state.prototype.IsPurgeException(self)
	return false
end
function modifier_native_hero_waiting_state.prototype.IsPermanent(self)
	return true
end
function modifier_native_hero_waiting_state.prototype.RemoveOnDeath(self)
	return false
end
function modifier_native_hero_waiting_state.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
	}
end
function modifier_native_hero_waiting_state.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:Stop()
	parent:AddNoDrawWithWearables()
end
function modifier_native_hero_waiting_state.prototype.OnRefresh(self)
	self:OnCreated()
end
modifier_native_hero_waiting_state = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_native_hero_waiting_state)
____exports.modifier_native_hero_waiting_state = modifier_native_hero_waiting_state
return ____exports