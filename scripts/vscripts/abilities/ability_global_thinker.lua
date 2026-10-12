--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/ability_global_thinker.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"abilities/ability_global_thinker.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "1:27",
		["13"] = "3:1",
		["14"] = "4:14",
		["15"] = "3:1",
		["16"] = "4:37",
		["17"] = "6:5",
		["18"] = "7:14",
		["21"] = "8:9",
		["22"] = "6:5",
		["23"] = "11:5",
		["24"] = "12:14",
		["27"] = "13:9",
		["28"] = "11:5",
		["29"] = "4:14",
		["30"] = "3:2",
		["31"] = "3:2",
		["32"] = "3:2",
		["34"] = "3:2",
		["35"] = "4:14",
		["37"] = "4:14",
	}
)
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
ability_global_thinker = __TS__Decorate({ registerAbility(nil, nil, getfenv()) }, ability_global_thinker)
____exports.ability_global_thinker = ability_global_thinker
return ____exports