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
local ____exports = {}
local toDotaClassInstance
function toDotaClassInstance(self, instance, ____table)
	local ____table_8 = ____table
	local prototype = ____table_8.prototype
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
function BaseModifier.prototype.____constructor(self) end
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
local ____setmetatable_2 = setmetatable
local ____exports_BaseAbility_prototype_1 = ____exports.BaseAbility.prototype
local ____CDOTA_Ability_Lua_0 = CDOTA_Ability_Lua
if ____CDOTA_Ability_Lua_0 == nil then
	____CDOTA_Ability_Lua_0 = C_DOTA_Ability_Lua
end
____setmetatable_2(____exports_BaseAbility_prototype_1, { __index = ____CDOTA_Ability_Lua_0 })
local ____setmetatable_5 = setmetatable
local ____exports_BaseItem_prototype_4 = ____exports.BaseItem.prototype
local ____CDOTA_Item_Lua_3 = CDOTA_Item_Lua
if ____CDOTA_Item_Lua_3 == nil then
	____CDOTA_Item_Lua_3 = C_DOTA_Item_Lua
end
____setmetatable_5(____exports_BaseItem_prototype_4, { __index = ____CDOTA_Item_Lua_3 })
setmetatable(____exports.BaseModifier.prototype, { __index = CDOTA_Modifier_Lua })
____exports.registerAbility = function(____, name)
	return function(____, ability)
		if name ~= nil then
			ability.name = name
		else
			name = ability.name
		end
		local env = getfenv(0)
		env[name] = {}
		toDotaClassInstance(nil, env[name], ability)
		local originalSpawn = env[name].Spawn
		env[name].Spawn = function(self)
			self:____constructor()
			if originalSpawn then
				originalSpawn(self)
			end
		end
	end
end
____exports.registerModifier = function(____, file_path)
	return function(____, modifier)
		local name = modifier.name
		local env = getfenv(0)
		env[name] = {}
		toDotaClassInstance(nil, env[name], modifier)
		local originalOnCreated = env[name].OnCreated
		env[name].OnCreated = function(self, parameters)
			self:____constructor()
			if originalOnCreated then
				originalOnCreated(self, parameters)
			end
		end
		local ____type = LUA_MODIFIER_MOTION_NONE
		local base = modifier.____super
		while base do
			local ____base_name_6 = base
			if ____base_name_6 ~= nil then
				____base_name_6 = ____base_name_6.name
			end
			local name = ____base_name_6
			if name == "BaseModifierMotionBoth" or name == "SLModifierBase_MotionBoth" then
				____type = LUA_MODIFIER_MOTION_BOTH
				break
			elseif name == "BaseModifierMotionHorizontal" or name == "SLModifierBase_MotionHorizontal" then
				____type = LUA_MODIFIER_MOTION_HORIZONTAL
				break
			elseif name == "BaseModifierMotionVertical" or name == "SLModifierBase_MotionVertical" then
				____type = LUA_MODIFIER_MOTION_VERTICAL
				break
			end
			base = base.____super
		end
		LinkLuaModifier(name, file_path, ____type)
		local extra_file_path = string.gsub(file_path, "/", "\\")
		LinkLuaModifier(name, extra_file_path, ____type)
	end
end
return ____exports