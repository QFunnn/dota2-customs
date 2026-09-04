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
____exports.modifier_minigame_avatar_hero_follow = __TS__Class()
local modifier_minigame_avatar_hero_follow = ____exports.modifier_minigame_avatar_hero_follow
modifier_minigame_avatar_hero_follow.name = "modifier_minigame_avatar_hero_follow"
__TS__ClassExtends(modifier_minigame_avatar_hero_follow, BaseModifier_CS)
function modifier_minigame_avatar_hero_follow.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.zOffset = 50
end
function modifier_minigame_avatar_hero_follow.prototype.IsHidden(self)
	return true
end
function modifier_minigame_avatar_hero_follow.prototype.IsPurgable(self)
	return false
end
function modifier_minigame_avatar_hero_follow.prototype.RemoveOnDeath(self)
	return false
end
function modifier_minigame_avatar_hero_follow.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
	}
end
function modifier_minigame_avatar_hero_follow.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.zOffset = tonumber(params and params.z_offset) or 50
	self:GetParent():AddNoDrawWithWearables()
	self:StartIntervalThink(0.03)
	self:OnIntervalThink()
end
function modifier_minigame_avatar_hero_follow.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local hero = self:GetParent()
	if not hero or not IsValid(nil, hero) then
		return
	end
	hero:RemoveNoDrawWithWearables()
	local avatar = self:GetCaster()
	if avatar and IsValid(nil, avatar) and not avatar:IsNull() then
		FindClearSpaceForUnit(hero, avatar:GetAbsOrigin(), true)
	end
end
function modifier_minigame_avatar_hero_follow.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local hero = self:GetParent()
	local avatar = self:GetCaster()
	if not hero or not IsValid(nil, hero) or not avatar or not IsValid(nil, avatar) or avatar:IsNull() then
		self:Destroy()
		return
	end
	local avatarOrigin = avatar:GetAbsOrigin()
	hero:SetAbsOrigin(Vector(avatarOrigin.x, avatarOrigin.y, avatarOrigin.z + self.zOffset))
	hero:SetForwardVector(avatar:GetForwardVector())
end
modifier_minigame_avatar_hero_follow =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_minigame_avatar_hero_follow)
____exports.modifier_minigame_avatar_hero_follow = modifier_minigame_avatar_hero_follow
____exports.modifier_minigame_avatar_rooted = __TS__Class()
local modifier_minigame_avatar_rooted = ____exports.modifier_minigame_avatar_rooted
modifier_minigame_avatar_rooted.name = "modifier_minigame_avatar_rooted"
__TS__ClassExtends(modifier_minigame_avatar_rooted, BaseModifier_CS)
function modifier_minigame_avatar_rooted.prototype.IsHidden(self)
	return true
end
function modifier_minigame_avatar_rooted.prototype.IsPurgable(self)
	return false
end
function modifier_minigame_avatar_rooted.prototype.RemoveOnDeath(self)
	return false
end
function modifier_minigame_avatar_rooted.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_HEALTH_BAR] = true, [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_DISARMED] = true }
end
modifier_minigame_avatar_rooted = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_minigame_avatar_rooted)
____exports.modifier_minigame_avatar_rooted = modifier_minigame_avatar_rooted
return ____exports