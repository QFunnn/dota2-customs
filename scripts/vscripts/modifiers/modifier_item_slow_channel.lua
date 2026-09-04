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
local ____modifier_item_channel_ambient_effect = require("modifiers.modifier_item_channel_ambient_effect")
local modifier_item_channel_ambient_effect =
	____modifier_item_channel_ambient_effect.modifier_item_channel_ambient_effect
local ____Sync = require("modules.Sync")
local SyncGameEvent = ____Sync.SyncGameEvent
--- 模拟持续施法 modifier
-- - channel 模式：完全不能移动（ROOTED），移动即打断
-- - slow 模式：可缓慢移动，其他操作打断
____exports.modifier_item_slow_channel = __TS__Class()
local modifier_item_slow_channel = ____exports.modifier_item_slow_channel
modifier_item_slow_channel.name = "modifier_item_slow_channel"
__TS__ClassExtends(modifier_item_slow_channel, BaseModifier_CS)
function modifier_item_slow_channel.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._bonusMovespeed = -30
	self._is_rooted = false
	self._is_free_mode = false
	self._animation_play_once = false
	self._channel_id = "default"
	self._is_interrupted = false
end
function modifier_item_slow_channel.prototype.IsHidden(self)
	return true
end
function modifier_item_slow_channel.prototype.IsDebuff(self)
	return false
end
function modifier_item_slow_channel.prototype.IsPurgable(self)
	return false
end
function modifier_item_slow_channel.prototype.IsPurgeException(self)
	return false
end
function modifier_item_slow_channel.prototype.GetTexture(self)
	return "item_heavens_halberd"
end
function modifier_item_slow_channel.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_EVENT_ON_ORDER }
end
function modifier_item_slow_channel.prototype.GetOverrideAnimation(self)
	if self._animation_play_once then
		return 0
	end
	return self:GetStackCount()
end
function modifier_item_slow_channel.prototype.CheckState(self)
	local state = {}
	if self._is_free_mode then
		return state
	end
	state[MODIFIER_STATE_DISARMED] = true
	if self._is_rooted == true then
		state[MODIFIER_STATE_ROOTED] = true
	end
	return state
end
function modifier_item_slow_channel.prototype.OnOrder(self, event)
	if not IsServer() then
		return
	end
	if self._is_free_mode then
		return
	end
	local parent = self:GetParent()
	if event.unit ~= parent then
		return
	end
	local orderType = event.order_type
	local isMoveOrder = orderType == DOTA_UNIT_ORDER_MOVE_TO_POSITION
		or orderType == DOTA_UNIT_ORDER_MOVE_TO_TARGET
		or orderType == DOTA_UNIT_ORDER_MOVE_TO_DIRECTION
		or orderType == DOTA_UNIT_ORDER_PATROL
	if isMoveOrder then
		if self._is_rooted == true then
			self:Interrupted()
		end
		return
	end
	self:Interrupted()
end
function modifier_item_slow_channel.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._animation_play_once = (params and params.animation_play_once) == 1
	self._channel_id = params and params.channel_id or "default"
	if (params and params.animation_stack_count) ~= nil and params.animation_stack_count ~= -1 then
		local anim = params.animation_stack_count
		if self._animation_play_once then
			self:GetParent():StartGesture(anim)
		else
			self:SetStackCount(anim or 0)
		end
	end
	local rootedFlag = params and params.is_rooted or 0
	self._is_rooted = rootedFlag == 1
	self._is_free_mode = (params and params.is_free_mode) == 1
	self:StartIntervalThink(0.03)
	self:OnIntervalThink()
end
function modifier_item_slow_channel.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) then
		local activeChannelId = parent.__channel_id__
		local isCurrentChannel = activeChannelId == nil or activeChannelId == self._channel_id
		if isCurrentChannel then
			modifier_item_channel_ambient_effect:remove(parent)
			if not IsValidAlive(nil, parent) then
				self._is_interrupted = true
			end
			if not self._is_interrupted then
				SafelyCall(nil, function()
					return parent.__channel_success__ and parent.__channel_success__(parent)
				end)
			else
				SafelyCall(nil, function()
					return parent.__channel_interrupted__ and parent.__channel_interrupted__(parent)
				end)
			end
			parent.__channel_id__ = nil
			parent.__channel_success__ = nil
			parent.__channel_interrupted__ = nil
		end
		local playerId = parent:GetPlayerOwnerID()
		local player = PlayerResource:GetPlayer(playerId)
		if player then
			SyncGameEvent:Send_ServerToPlayer(
				player,
				"s2c_custom_channel_bar_play",
				{ action = "stop", channel_id = self._channel_id, channel_time = 0, interrupted = self._is_interrupted }
			)
		end
	end
end
function modifier_item_slow_channel.prototype.GetAttributeBonus(self)
	if self._is_rooted == true or self._is_free_mode then
		return {}
	end
	return { bonus_movespeed_pct = self._bonusMovespeed }
end
function modifier_item_slow_channel.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if self._is_free_mode then
		if not IsValidAlive(nil, parent) then
			self:Interrupted()
		end
	else
		if not IsValidAlive(nil, parent) or parent:IsStunned() then
			self:Interrupted()
		end
	end
end
function modifier_item_slow_channel.prototype.Interrupted(self)
	self._is_interrupted = true
	self:Destroy()
end
modifier_item_slow_channel = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_slow_channel)
____exports.modifier_item_slow_channel = modifier_item_slow_channel
return ____exports