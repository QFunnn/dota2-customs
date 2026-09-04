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
local ____elite_075 = require("abilities.monster.elite.elite_075")
local elite_075 = ____elite_075.elite_075
local PrecacheDireTowerVisual = ____elite_075.PrecacheDireTowerVisual
--- 精英技能 76 - 2022 天灾防御塔：复用通用天灾塔表现逻辑。
____exports.elite_076 = __TS__Class()
local elite_076 = ____exports.elite_076
elite_076.name = "elite_076"
__TS__ClassExtends(elite_076, elite_075)
function elite_076.prototype.Precache(self, context)
	PrecacheDireTowerVisual(nil, context, self:GetAbilityName())
end
elite_076 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_076)
____exports.elite_076 = elite_076
return ____exports