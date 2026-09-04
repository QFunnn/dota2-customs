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
--- 小游戏内通过自定义属性覆盖玩家移动速度。
____exports.modifier_minigame_speed_fixed = __TS__Class()
local modifier_minigame_speed_fixed = ____exports.modifier_minigame_speed_fixed
modifier_minigame_speed_fixed.name = "modifier_minigame_speed_fixed"
__TS__ClassExtends(modifier_minigame_speed_fixed, BaseModifier_CS)
function modifier_minigame_speed_fixed.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.fixedMoveSpeed = 1
end
function modifier_minigame_speed_fixed.prototype.IsHidden(self)
	return false
end
function modifier_minigame_speed_fixed.prototype.IsPurgable(self)
	return false
end
function modifier_minigame_speed_fixed.prototype.RemoveOnDeath(self)
	return false
end
function modifier_minigame_speed_fixed.prototype.OnCreated(self, params)
	self.fixedMoveSpeed = math.max(1, params and params.fixed_movespeed or 0)
end
function modifier_minigame_speed_fixed.prototype.OnRefresh(self, params)
	self:OnCreated(params)
end
function modifier_minigame_speed_fixed.prototype.GetAttributeBonus(self)
	return { override_movespeed = self.fixedMoveSpeed }
end
modifier_minigame_speed_fixed = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_minigame_speed_fixed)
____exports.modifier_minigame_speed_fixed = modifier_minigame_speed_fixed
return ____exports