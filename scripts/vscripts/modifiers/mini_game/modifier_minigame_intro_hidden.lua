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
--- 小游戏入场隐藏保护，不播放任何演出特效。
____exports.modifier_minigame_intro_hidden = __TS__Class()
local modifier_minigame_intro_hidden = ____exports.modifier_minigame_intro_hidden
modifier_minigame_intro_hidden.name = "modifier_minigame_intro_hidden"
__TS__ClassExtends(modifier_minigame_intro_hidden, BaseModifier_CS)
function modifier_minigame_intro_hidden.prototype.IsHidden(self)
	return true
end
function modifier_minigame_intro_hidden.prototype.IsPurgable(self)
	return false
end
function modifier_minigame_intro_hidden.prototype.RemoveOnDeath(self)
	return false
end
function modifier_minigame_intro_hidden.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
	}
end
function modifier_minigame_intro_hidden.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:GetParent():AddNoDrawWithWearables()
end
function modifier_minigame_intro_hidden.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:RemoveNoDrawWithWearables()
end
modifier_minigame_intro_hidden = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_minigame_intro_hidden)
____exports.modifier_minigame_intro_hidden = modifier_minigame_intro_hidden
return ____exports