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
--- 猫咪专用无碰撞状态，不改变移动、选择或其他单位行为。
____exports.modifier_cat_no_collision = __TS__Class()
local modifier_cat_no_collision = ____exports.modifier_cat_no_collision
modifier_cat_no_collision.name = "modifier_cat_no_collision"
__TS__ClassExtends(modifier_cat_no_collision, BaseModifier_CS)
function modifier_cat_no_collision.prototype.IsHidden(self)
	return true
end
function modifier_cat_no_collision.prototype.IsPurgable(self)
	return false
end
function modifier_cat_no_collision.prototype.IsPermanent(self)
	return true
end
function modifier_cat_no_collision.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
modifier_cat_no_collision = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_cat_no_collision)
____exports.modifier_cat_no_collision = modifier_cat_no_collision
return ____exports