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
--- 水晶室女技能 004（空白）
____exports.cm_004 = __TS__Class()
local cm_004 = ____exports.cm_004
cm_004.name = "cm_004"
__TS__ClassExtends(cm_004, BaseHeroAbility)
function cm_004.prototype.Precache(self, context) end
function cm_004.prototype.GetAbilityConfig(self)
	return { castPoint = 0, castAnimation = ACT_DOTA_CAST_ABILITY_4, behavior = DOTA_ABILITY_BEHAVIOR_POINT }
end
function cm_004.prototype.OnSpellStart(self) end
cm_004 = __TS__DecorateLegacy({ registerAbility(nil) }, cm_004)
____exports.cm_004 = cm_004
return ____exports