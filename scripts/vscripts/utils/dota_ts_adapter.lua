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
local __TS__Delete = ____lualib.__TS__Delete
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local ____exports = {}
local getFileScopeEnv, toDotaClassInstance
function getFileScopeEnv(self)
	local function safeGetFenv(____, level)
		local ok, env = pcall(function()
			return getfenv(level)
		end)
		if ok and env then
			return env
		end
		return nil
	end
	local debugLib = _G.debug
	local getInfoFn = debugLib and debugLib.getinfo
	if getInfoFn then
		local level = 1
		while level <= 50 do
			local ok, info = pcall(getInfoFn, level, "S")
			if not ok then
				break
			end
			if info and info.what == "main" and info.source and __TS__StringStartsWith(info.source, "@") then
				local ____safeGetFenv_result_10 = safeGetFenv(nil, level)
				if ____safeGetFenv_result_10 == nil then
					____safeGetFenv_result_10 = _G
				end
				return ____safeGetFenv_result_10
			end
			level = level + 1
		end
	end
	local selfEnv = safeGetFenv(nil, 1)
	do
		local level = 2
		while level <= 20 do
			local env = safeGetFenv(nil, level)
			if env and env ~= selfEnv then
				return env
			end
			level = level + 1
		end
	end
	local ____selfEnv_11 = selfEnv
	if ____selfEnv_11 == nil then
		____selfEnv_11 = _G
	end
	return ____selfEnv_11
end
function toDotaClassInstance(self, instance, ____table)
	local ____table_12 = ____table
	local prototype = ____table_12.prototype
	while prototype do
		for key in pairs(prototype) do
			if not (rawget(instance, key) ~= nil) then
				if key ~= "__index" then
					instance[key] = prototype[key]
				end
			end
		end
		prototype = getmetatable(prototype)
	end
end
____exports.BaseAbility = __TS__Class()
local BaseAbility = ____exports.BaseAbility
BaseAbility.name = "BaseAbility"
function BaseAbility.prototype.____constructor(self) end
____exports.BaseItem = __TS__Class()
local BaseItem = ____exports.BaseItem
BaseItem.name = "BaseItem"
function BaseItem.prototype.____constructor(self) end
____exports.BaseModifier = __TS__Class()
local BaseModifier = ____exports.BaseModifier
BaseModifier.name = "BaseModifier"
function BaseModifier.prototype.____constructor(self)
	self._is_removed = false
end
function BaseModifier.applys(self, target, caster, ability, modifierTable)
	return target:AddNewModifier(caster, ability, self.name, modifierTable)
end
function BaseModifier.find_on(self, target)
	return target:FindModifierByName(self.name)
end
function BaseModifier.remove(self, target)
	target:RemoveModifierByName(self.name)
end
function BaseModifier.prototype.IsRemoved(self)
	return self._is_removed
end
function BaseModifier.prototype.GetName(self)
	return self.constructor.name
end
function BaseModifier.prototype.GetAddAttributesEntity(self)
	return {}
end
function BaseModifier.prototype.GetAddTagRulesEntity(self)
	return {}
end
function BaseModifier.prototype.GetEntity(self)
	return self
end
function BaseModifier.prototype.Spawn(self) end
____exports.BaseModifierMotionHorizontal = __TS__Class()
local BaseModifierMotionHorizontal = ____exports.BaseModifierMotionHorizontal
BaseModifierMotionHorizontal.name = "BaseModifierMotionHorizontal"
__TS__ClassExtends(BaseModifierMotionHorizontal, ____exports.BaseModifier)
____exports.BaseModifierMotionVertical = __TS__Class()
local BaseModifierMotionVertical = ____exports.BaseModifierMotionVertical
BaseModifierMotionVertical.name = "BaseModifierMotionVertical"
__TS__ClassExtends(BaseModifierMotionVertical, ____exports.BaseModifier)
____exports.BaseModifierMotionBoth = __TS__Class()
local BaseModifierMotionBoth = ____exports.BaseModifierMotionBoth
BaseModifierMotionBoth.name = "BaseModifierMotionBoth"
__TS__ClassExtends(BaseModifierMotionBoth, ____exports.BaseModifier)
local MODIFIER_LOCALIZATION_METHOD = "GetLocalizationCN"
setmetatable(____exports.BaseAbility.prototype, { __index = CDOTA_Ability_Lua or C_DOTA_Ability_Lua })
setmetatable(____exports.BaseItem.prototype, { __index = CDOTA_Item_Lua or C_DOTA_Item_Lua })
setmetatable(____exports.BaseModifier.prototype, { __index = CDOTA_Modifier_Lua })
____exports.registerAbility = function(____, name)
	return function(____, ability)
		if name ~= nil then
			ability.name = name
		else
			name = ability.name
		end
		local env = getFileScopeEnv(nil)
		env[name] = {}
		toDotaClassInstance(nil, env[name], ability)
		local originalGetCooldown = env[name].GetCooldown
		if originalGetCooldown then
			env[name].GetCooldown = function(self, level)
				local baseCd = originalGetCooldown(self, level)
				local ____opt_0 = self.GetCaster
				local caster = ____opt_0 and ____opt_0(self)
				if not caster then
					return baseCd
				end
				if caster:IsNull() then
					return baseCd
				end
				local reduction = 0
				if IsServer() then
					if MyGameAttribute and MyGameAttribute:HasAttributes(caster) then
						reduction = MyGameAttribute:GetAttribute(caster, "cooldown_reduction_pct") or 0
					end
				else
					local attrs = CustomNetTables:GetTableValue("unit_attributes", tostring(caster:entindex()))
					reduction = attrs and attrs.cooldown_reduction_pct or 0
				end
				return baseCd * math.max(0, 1 - reduction / 100)
			end
		end
		local originalSpawn = env[name].Spawn
		env[name].Spawn = function(self)
			self:____constructor()
			if originalSpawn then
				originalSpawn(self)
			end
		end
	end
end
____exports.registerModifier = function(____, name)
	return function(____, modifier)
		if name ~= nil then
			modifier.name = name
		else
			name = modifier.name
		end
		if IsServer() and IsInToolsMode() then
			local modifierCtor = modifier
			local hasStaticLocalization = type(modifierCtor[MODIFIER_LOCALIZATION_METHOD]) == "function"
			local ____opt_6 = modifierCtor.prototype
			if ____opt_6 ~= nil then
				____opt_6 = ____opt_6[MODIFIER_LOCALIZATION_METHOD]
			end
			local hasInstanceLocalization = type(____opt_6) == "function"
			if hasStaticLocalization and hasInstanceLocalization then
				print(
					(
						(
							("[警告!!!!!!!] " .. name)
							.. ': 本地化方法必须声明为静态方法。请改为 "public static '
						) .. MODIFIER_LOCALIZATION_METHOD
					) .. '() { ... }"。'
				)
			end
		end
		local env = getFileScopeEnv(nil)
		env[name] = {}
		toDotaClassInstance(nil, env[name], modifier)
		local originalOnCreated = env[name].OnCreated
		local initializeAttributes = env[name].InitializeAttributes
		local initializeTagRules = env[name].InitializeTagRules
		local initializeEvents = env[name].InitializeEvents
		local autoWearablesOnCreated = env[name].OnCreated_AutoWearablesInvisibilitySync
		local autoWearablesOnRefresh = env[name].OnRefresh_AutoWearablesInvisibilitySync
		local autoWearablesOnDestroy = env[name].OnDestroy_AutoWearablesInvisibilitySync
		local autoModifierMutexOnCreated = env[name].OnCreated_AutoModifierMutex
		local autoModifierMutexOnRefresh = env[name].OnRefresh_AutoModifierMutex
		local autoModifierMutexOnDestroy = env[name].OnDestroy_AutoModifierMutex
		local spawn = env[name].Spawn
		env[name].OnCreated = function(self, parameters)
			self:____constructor()
			if spawn then
				spawn(self)
			end
			if originalOnCreated then
				originalOnCreated(self, parameters)
			end
			if IsServer() and autoWearablesOnCreated then
				autoWearablesOnCreated(self, parameters)
			end
			local ____self = self
			local shouldContinueInit = true
			if IsServer() and autoModifierMutexOnCreated then
				shouldContinueInit = autoModifierMutexOnCreated(self, parameters) ~= false
			end
			if not shouldContinueInit then
				____self.__RunDeferredModifierInit = function(self)
					if ____self.__ak_post_create_inited then
						return
					end
					if IsServer() and initializeEvents then
						initializeEvents(____self)
					end
					if IsServer() and initializeAttributes then
						initializeAttributes(____self)
					end
					if IsServer() and initializeTagRules then
						initializeTagRules(____self)
					end
					____self.__ak_post_create_inited = true
				end
				return
			end
			if IsServer() and initializeEvents then
				initializeEvents(self)
			end
			if IsServer() and initializeAttributes then
				initializeAttributes(self)
			end
			if IsServer() and initializeTagRules then
				initializeTagRules(self)
			end
			____self.__ak_post_create_inited = true
		end
		local originalOnRefresh = env[name].OnRefresh
		local refreshAttributes = env[name].RefreshAttributes
		local refreshTagRules = env[name].RefreshTagRules
		env[name].OnRefresh = function(self, parameters)
			if originalOnRefresh then
				originalOnRefresh(self, parameters)
			end
			if IsServer() and autoWearablesOnRefresh then
				autoWearablesOnRefresh(self, parameters)
			end
			local shouldRefreshPostInit = true
			if IsServer() and autoModifierMutexOnRefresh then
				shouldRefreshPostInit = autoModifierMutexOnRefresh(self, parameters) ~= false
			end
			local ____self = self
			if shouldRefreshPostInit and ____self.__ak_post_create_inited then
				if IsServer() and refreshAttributes then
					refreshAttributes(self, parameters)
				end
				if IsServer() and refreshTagRules then
					refreshTagRules(self, parameters)
				end
			end
		end
		local originalOnDestroy = env[name].OnDestroy
		local cleanupAttributes = env[name].CleanupAttributes
		local cleanupTagRules = env[name].CleanupTagRules
		local unregisterAllEvents = env[name].UnregisterAllEvents
		env[name].OnDestroy = function(self)
			if self._is_removed == false then
				self._is_removed = true
			end
			if IsServer() and autoWearablesOnDestroy then
				autoWearablesOnDestroy(self)
			end
			if IsServer() and autoModifierMutexOnDestroy then
				autoModifierMutexOnDestroy(self)
			end
			local ____self = self
			if ____self.__ak_post_create_inited then
				if IsServer() and cleanupAttributes then
					cleanupAttributes(self)
				end
				if IsServer() and cleanupTagRules then
					cleanupTagRules(self)
				end
				if IsServer() and unregisterAllEvents then
					unregisterAllEvents(self)
				end
			end
			if originalOnDestroy then
				originalOnDestroy(self)
			end
		end
	end
end
local function clearTable(self, ____table)
	for key in pairs(____table) do
		__TS__Delete(____table, key)
	end
end
return ____exports