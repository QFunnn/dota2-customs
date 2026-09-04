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
--- 玩家断线宽限期专用保护：彻底退出战斗交互，但保留英雄实体供重连恢复。
____exports.modifier_player_disconnect_protection = __TS__Class()
local modifier_player_disconnect_protection = ____exports.modifier_player_disconnect_protection
modifier_player_disconnect_protection.name = "modifier_player_disconnect_protection"
__TS__ClassExtends(modifier_player_disconnect_protection, BaseModifier_CS)
function modifier_player_disconnect_protection.prototype.IsHidden(self)
	return true
end
function modifier_player_disconnect_protection.prototype.IsPurgable(self)
	return false
end
function modifier_player_disconnect_protection.prototype.IsPurgeException(self)
	return false
end
function modifier_player_disconnect_protection.prototype.IsPermanent(self)
	return true
end
function modifier_player_disconnect_protection.prototype.RemoveOnDeath(self)
	return false
end
function modifier_player_disconnect_protection.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	parent:Stop()
	parent:AddNoDrawWithWearables()
end
function modifier_player_disconnect_protection.prototype.OnRefresh(self)
	self:OnCreated()
end
function modifier_player_disconnect_protection.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:RemoveNoDrawWithWearables()
end
function modifier_player_disconnect_protection.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
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
	}
end
modifier_player_disconnect_protection =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_player_disconnect_protection)
____exports.modifier_player_disconnect_protection = modifier_player_disconnect_protection
return ____exports