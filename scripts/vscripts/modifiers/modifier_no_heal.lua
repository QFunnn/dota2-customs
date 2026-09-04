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
--- 禁疗
____exports.modifier_no_heal = __TS__Class()
local modifier_no_heal = ____exports.modifier_no_heal
modifier_no_heal.name = "modifier_no_heal"
__TS__ClassExtends(modifier_no_heal, BaseModifier_CS)
function modifier_no_heal.GetLocalizationCN(self)
	return { name = "禁疗", description = "无法受到任何治疗效果。" }
end
function modifier_no_heal.prototype.GetAttributeBonus(self)
	return { disable_heal = 1 }
end
function modifier_no_heal.prototype.IsDebuff(self)
	return true
end
function modifier_no_heal.prototype.GetTexture(self)
	return "ancient_apparition_chilling_touch"
end
modifier_no_heal = __TS__DecorateLegacy({ registerModifier(nil, "modifier_no_heal") }, modifier_no_heal)
____exports.modifier_no_heal = modifier_no_heal
return ____exports