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
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Delete = ____lualib.__TS__Delete
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseAbility = ____dota_ts_adapter.BaseAbility
local registerAbility = ____dota_ts_adapter.registerAbility
____exports.projectile_system_ability = __TS__Class()
local projectile_system_ability = ____exports.projectile_system_ability
projectile_system_ability.name = "projectile_system_ability"
__TS__ClassExtends(projectile_system_ability, BaseAbility)
function projectile_system_ability.prototype.RegisterProjectileCallbackId(self, cb, ttlSeconds)
	if ttlSeconds == nil then
		ttlSeconds = 11
	end
	if self.__projectileCallbacks == nil then
		self.__projectileCallbacks = {}
	end
	self:PruneProjectileCallbacks()
	local id = DoUniqueString("proj_cb")
	self.__projectileCallbacks[id] = {
		cb = cb,
		expireAt = GameRules:GetGameTime() + ttlSeconds,
	}
	return id
end
function projectile_system_ability.prototype.RegisterProjectileThinkCallbackId(self, cb, ttlSeconds)
	if ttlSeconds == nil then
		ttlSeconds = 11
	end
	if self.__projectileThinkCallbacks == nil then
		self.__projectileThinkCallbacks = {}
	end
	self:PruneProjectileThinkCallbacks()
	local id = DoUniqueString("proj_think_cb")
	self.__projectileThinkCallbacks[id] = {
		cb = cb,
		expireAt = GameRules:GetGameTime() + ttlSeconds,
	}
	return id
end
function projectile_system_ability.prototype.BindProjectileRuntimeByHitCbId(self, hitCbId, runtime, ttlSeconds)
	if ttlSeconds == nil then
		ttlSeconds = 11
	end
	if not hitCbId then
		return
	end
	if self.__projectileRuntimeByHitCbId == nil then
		self.__projectileRuntimeByHitCbId = {}
	end
	self:PruneProjectileHitRuntimeMap()
	self.__projectileRuntimeByHitCbId[hitCbId] = __TS__ObjectAssign(
		{},
		runtime,
		{ expireAt = GameRules:GetGameTime() + ttlSeconds }
	)
end
function projectile_system_ability.prototype.BindProjectileRuntimeByThinkCbId(self, thinkCbId, runtime, ttlSeconds)
	if ttlSeconds == nil then
		ttlSeconds = 11
	end
	if not thinkCbId then
		return
	end
	if self.__projectileRuntimeByThinkCbId == nil then
		self.__projectileRuntimeByThinkCbId = {}
	end
	self:PruneProjectileRuntimeMap()
	self.__projectileRuntimeByThinkCbId[thinkCbId] = __TS__ObjectAssign(
		{},
		runtime,
		{ expireAt = GameRules:GetGameTime() + ttlSeconds }
	)
end
function projectile_system_ability.prototype.PruneProjectileCallbacks(self)
	local map = self.__projectileCallbacks
	if not map then
		return
	end
	local now = GameRules:GetGameTime()
	for id in pairs(map) do
		if map[id].expireAt <= now then
			__TS__Delete(map, id)
		end
	end
end
function projectile_system_ability.prototype.PruneProjectileThinkCallbacks(self)
	local map = self.__projectileThinkCallbacks
	if not map then
		return
	end
	local now = GameRules:GetGameTime()
	for id in pairs(map) do
		if map[id].expireAt <= now then
			__TS__Delete(map, id)
		end
	end
end
function projectile_system_ability.prototype.PruneProjectileRuntimeMap(self)
	local map = self.__projectileRuntimeByThinkCbId
	if not map then
		return
	end
	local now = GameRules:GetGameTime()
	for id in pairs(map) do
		if map[id].expireAt <= now then
			__TS__Delete(map, id)
		end
	end
end
function projectile_system_ability.prototype.PruneProjectileHitRuntimeMap(self)
	local map = self.__projectileRuntimeByHitCbId
	if not map then
		return
	end
	local now = GameRules:GetGameTime()
	for id in pairs(map) do
		if map[id].expireAt <= now then
			__TS__Delete(map, id)
		end
	end
end
function projectile_system_ability.prototype.OnProjectileHit_ExtraData(self, target, location, extraData)
	if not extraData then
		return true
	end
	local cbId = extraData.__cb_id
	if not cbId then
		return true
	end
	self:PruneProjectileCallbacks()
	local ____opt_0 = self.__projectileCallbacks
	local entry = ____opt_0 and ____opt_0[cbId]
	self:PruneProjectileHitRuntimeMap()
	local ____opt_2 = self.__projectileRuntimeByHitCbId
	local hitRuntime = ____opt_2 and ____opt_2[cbId]
	if hitRuntime and IsValidAlive(nil, hitRuntime.caster) then
		local eventData = {
			caster = hitRuntime.caster,
			ability = nil,
			target = target,
			location = location,
			effect_name = hitRuntime.effectName,
			extraData = extraData,
			projectile_type = hitRuntime.projType,
			prevent_hit = false,
			destroy_projectile = false,
		}
		MyGameEvent:FireEvent(
			BusinessEvents.ON_PROJECTILE_HIT_PRE_APPLY,
			eventData,
			{ scope = "entity", entity = hitRuntime.caster }
		)
		if target and IsValidAlive(nil, target) and target ~= hitRuntime.caster then
			MyGameEvent:FireEvent(
				BusinessEvents.ON_PROJECTILE_HIT_PRE_APPLY,
				eventData,
				{ scope = "entity", entity = target }
			)
		end
		if eventData.prevent_hit or eventData.destroy_projectile then
			if entry then
				__TS__Delete(self.__projectileCallbacks, cbId)
			end
			__TS__Delete(self.__projectileRuntimeByHitCbId, cbId)
			return true
		end
	end
	if not entry then
		return true
	end
	local ret = entry:cb(target, location, extraData)
	local shouldConsume = ret ~= false
	if shouldConsume then
		__TS__Delete(self.__projectileCallbacks, cbId)
		__TS__Delete(self.__projectileRuntimeByHitCbId, cbId)
	else
		entry.expireAt = GameRules:GetGameTime() + 11
		if hitRuntime then
			hitRuntime.expireAt = GameRules:GetGameTime() + 11
		end
	end
	return shouldConsume
end
function projectile_system_ability.prototype.OnProjectileThink_ExtraData(self, location, extraData)
	local extra = extraData
	if not extra then
		return
	end
	local cbId = extra.__think_cb_id
	if not cbId then
		return
	end
	self:PruneProjectileThinkCallbacks()
	local ____opt_4 = self.__projectileThinkCallbacks
	local entry = ____opt_4 and ____opt_4[cbId]
	if not entry then
		return
	end
	local ret = entry:cb(location, extra)
	if ret == true then
		__TS__Delete(self.__projectileThinkCallbacks, cbId)
		self:PruneProjectileRuntimeMap()
		local ____opt_6 = self.__projectileRuntimeByThinkCbId
		local runtime = ____opt_6 and ____opt_6[cbId]
		if runtime then
			if runtime.projType == "linear" then
				ProjectileManager:DestroyLinearProjectile(runtime.projId)
			elseif runtime.projType == "tracking" or runtime.projType == "collideground" then
				ProjectileManager:DestroyTrackingProjectile(runtime.projId)
			end
			local hitCbId = runtime.hitCbId
			if hitCbId and self.__projectileCallbacks and self.__projectileCallbacks[hitCbId] then
				__TS__Delete(self.__projectileCallbacks, hitCbId)
			end
			__TS__Delete(self.__projectileRuntimeByThinkCbId, cbId)
		end
	else
		entry.expireAt = GameRules:GetGameTime() + 11
		local ____opt_8 = self.__projectileRuntimeByThinkCbId
		local runtime = ____opt_8 and ____opt_8[cbId]
		if runtime then
			runtime.expireAt = GameRules:GetGameTime() + 11
		end
	end
end
projectile_system_ability = __TS__DecorateLegacy({ registerAbility(nil) }, projectile_system_ability)
____exports.projectile_system_ability = projectile_system_ability
return ____exports