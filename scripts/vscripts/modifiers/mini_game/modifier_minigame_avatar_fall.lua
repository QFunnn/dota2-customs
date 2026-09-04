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
--- 小游戏马甲坠落演出，持续降低单位高度来模拟掉入深渊。
____exports.modifier_minigame_avatar_fall = __TS__Class()
local modifier_minigame_avatar_fall = ____exports.modifier_minigame_avatar_fall
modifier_minigame_avatar_fall.name = "modifier_minigame_avatar_fall"
__TS__ClassExtends(modifier_minigame_avatar_fall, BaseModifier_CS)
function modifier_minigame_avatar_fall.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.startTime = 0
	self.duration = 0.6
	self.fallDistance = 600
	self.startPosition = Vector(0, 0, 0)
	self.finishedNaturally = false
end
function modifier_minigame_avatar_fall.prototype.IsHidden(self)
	return true
end
function modifier_minigame_avatar_fall.prototype.IsPurgable(self)
	return false
end
function modifier_minigame_avatar_fall.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true, [MODIFIER_STATE_COMMAND_RESTRICTED] = true }
end
function modifier_minigame_avatar_fall.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function modifier_minigame_avatar_fall.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_FLAIL
end
function modifier_minigame_avatar_fall.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self.startTime = GameRules:GetGameTime()
	self.startPosition = parent:GetAbsOrigin()
	self.duration = math.max(0.03, tonumber(params and params.duration) or self.duration)
	self.fallDistance = math.max(0, tonumber(params and params.fall_distance) or self.fallDistance)
	self.finishedNaturally = false
	self:StartIntervalThink(FrameTime())
	self:OnIntervalThink()
end
function modifier_minigame_avatar_fall.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		self:Destroy()
		return
	end
	local progress = math.min((GameRules:GetGameTime() - self.startTime) / self.duration, 1)
	local easedProgress = progress * progress
	parent:SetAbsOrigin(
		Vector(self.startPosition.x, self.startPosition.y, self.startPosition.z - self.fallDistance * easedProgress)
	)
	if progress >= 1 then
		self.finishedNaturally = true
		self:Destroy()
	end
end
function modifier_minigame_avatar_fall.prototype.OnDestroy(self)
	if not IsServer() or not self.finishedNaturally then
		return
	end
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	if MyGameMiniGame ~= nil then
		MyGameMiniGame:NotifyAvatarFallFinished(parent)
	end
end
modifier_minigame_avatar_fall = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_minigame_avatar_fall)
____exports.modifier_minigame_avatar_fall = modifier_minigame_avatar_fall
--- 小游戏马甲胜利演出，锁定单位并播放胜利动作。
____exports.modifier_minigame_avatar_victory = __TS__Class()
local modifier_minigame_avatar_victory = ____exports.modifier_minigame_avatar_victory
modifier_minigame_avatar_victory.name = "modifier_minigame_avatar_victory"
__TS__ClassExtends(modifier_minigame_avatar_victory, BaseModifier_CS)
function modifier_minigame_avatar_victory.prototype.IsHidden(self)
	return true
end
function modifier_minigame_avatar_victory.prototype.IsPurgable(self)
	return false
end
function modifier_minigame_avatar_victory.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}
end
function modifier_minigame_avatar_victory.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function modifier_minigame_avatar_victory.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_VICTORY
end
modifier_minigame_avatar_victory = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_minigame_avatar_victory)
____exports.modifier_minigame_avatar_victory = modifier_minigame_avatar_victory
return ____exports