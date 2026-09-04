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
local registerAbility = ____dota_ts_adapter.registerAbility
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
--- 水晶室女技能 005（空白）
____exports.cm_005 = __TS__Class()
local cm_005 = ____exports.cm_005
cm_005.name = "cm_005"
__TS__ClassExtends(cm_005, BaseHeroAbility)
function cm_005.prototype.Precache(self, context) end
function cm_005.prototype.GetAbilityConfig(self)
	return { castPoint = 0, castAnimation = ACT_DOTA_CAST_ABILITY_5, behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function cm_005.prototype.OnSpellStart(self) end
cm_005 = __TS__DecorateLegacy({ registerAbility(nil) }, cm_005)
____exports.cm_005 = cm_005
return ____exports