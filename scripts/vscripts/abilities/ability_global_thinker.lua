--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local BaseAbility = ____dota_ts_adapter.BaseAbility
____exports.ability_global_thinker = __TS__Class()
local ability_global_thinker = ____exports.ability_global_thinker
ability_global_thinker.name = "ability_global_thinker"
__TS__ClassExtends(ability_global_thinker, BaseAbility)
function ability_global_thinker.prototype.OnProjectileHit_ExtraData(self, target, location, extraData)
	if not extraData then
		return
	end
	return SLModules.CustomProjectile:OnHit(target, location, extraData)
end
function ability_global_thinker.prototype.OnProjectileThink_ExtraData(self, location, extraData)
	if not extraData then
		return
	end
	SLModules.CustomProjectile:OnThink(location, extraData)
end
ability_global_thinker = __TS__Decorate({ registerAbility(nil) }, ability_global_thinker)
____exports.ability_global_thinker = ability_global_thinker
return ____exports