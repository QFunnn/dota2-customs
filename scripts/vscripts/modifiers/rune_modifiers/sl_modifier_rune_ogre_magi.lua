--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 每点力量提升{hp_per_str}生命值，每点力量提升{amp_per_str}%技能增强
____exports.sl_modifier_rune_ogre_magi = __TS__Class()
local sl_modifier_rune_ogre_magi = ____exports.sl_modifier_rune_ogre_magi
sl_modifier_rune_ogre_magi.name = "sl_modifier_rune_ogre_magi"
__TS__ClassExtends(sl_modifier_rune_ogre_magi, sl_modifier_rune_base)
function sl_modifier_rune_ogre_magi.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_HEALTH_BONUS, MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE }
end
function sl_modifier_rune_ogre_magi.prototype.GetModifierHealthBonus(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_STRENGTH, "hp_per_str", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("hp_per_str")
	end)
end
function sl_modifier_rune_ogre_magi.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_STRENGTH, "amp_per_str", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("amp_per_str")
	end)
end
sl_modifier_rune_ogre_magi = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_ogre_magi") },
	sl_modifier_rune_ogre_magi
)
____exports.sl_modifier_rune_ogre_magi = sl_modifier_rune_ogre_magi
return ____exports