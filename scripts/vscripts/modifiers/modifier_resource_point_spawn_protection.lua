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
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerModifier = ____dota_ts_adapter.registerModifier
--- 资源点刷怪保护 modifier
-- 在资源被采集到阈值触发刷怪期间，使资源点无敌
-- 由 RoomInstance 在刷怪时添加，刷怪完成后移除
____exports.modifier_resource_point_spawn_protection = __TS__Class()
local modifier_resource_point_spawn_protection = ____exports.modifier_resource_point_spawn_protection
modifier_resource_point_spawn_protection.name = "modifier_resource_point_spawn_protection"
__TS__ClassExtends(modifier_resource_point_spawn_protection, BaseModifier)
function modifier_resource_point_spawn_protection.prototype.IsDebuff(self)
	return false
end
function modifier_resource_point_spawn_protection.prototype.IsHidden(self)
	return true
end
function modifier_resource_point_spawn_protection.prototype.IsPurgable(self)
	return false
end
function modifier_resource_point_spawn_protection.prototype.IsPurgeException(self)
	return false
end
function modifier_resource_point_spawn_protection.prototype.IsPermanent(self)
	return false
end
function modifier_resource_point_spawn_protection.prototype.RemoveOnDeath(self)
	return true
end
function modifier_resource_point_spawn_protection.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
modifier_resource_point_spawn_protection =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_resource_point_spawn_protection)
____exports.modifier_resource_point_spawn_protection = modifier_resource_point_spawn_protection
return ____exports