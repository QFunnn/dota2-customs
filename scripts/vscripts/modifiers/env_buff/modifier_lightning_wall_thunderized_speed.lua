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
local THUNDERIZED_BOOST_MOVESPEED_PCT = 300
--- 雷化穿越雷墙后的短暂加速 Buff
____exports.modifier_lightning_wall_thunderized_speed = __TS__Class()
local modifier_lightning_wall_thunderized_speed = ____exports.modifier_lightning_wall_thunderized_speed
modifier_lightning_wall_thunderized_speed.name = "modifier_lightning_wall_thunderized_speed"
__TS__ClassExtends(modifier_lightning_wall_thunderized_speed, BaseModifier_CS)
function modifier_lightning_wall_thunderized_speed.prototype.IsHidden(self)
	return false
end
function modifier_lightning_wall_thunderized_speed.prototype.IsPurgable(self)
	return false
end
function modifier_lightning_wall_thunderized_speed.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = THUNDERIZED_BOOST_MOVESPEED_PCT }
end
function modifier_lightning_wall_thunderized_speed.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_lightning_wall_thunderized_speed.prototype.GetTexture(self)
	return "item_icon_m223"
end
modifier_lightning_wall_thunderized_speed =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_lightning_wall_thunderized_speed)
____exports.modifier_lightning_wall_thunderized_speed = modifier_lightning_wall_thunderized_speed
return ____exports