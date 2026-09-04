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
--- 水晶室女技能 002（空白）
____exports.cm_002 = __TS__Class()
local cm_002 = ____exports.cm_002
cm_002.name = "cm_002"
__TS__ClassExtends(cm_002, BaseHeroAbility)
function cm_002.prototype.Precache(self, context) end
function cm_002.prototype.GetAbilityConfig(self)
	return { castPoint = 0, castAnimation = ACT_DOTA_CAST_ABILITY_2, behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function cm_002.prototype.OnSpellStart(self) end
cm_002 = __TS__DecorateLegacy({ registerAbility(nil) }, cm_002)
____exports.cm_002 = cm_002
return ____exports