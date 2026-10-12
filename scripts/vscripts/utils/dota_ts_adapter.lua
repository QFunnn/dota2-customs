--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/dota_ts_adapter.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
____debugRuntime.register(
	"utils/dota_ts_adapter.lua",
	{
		["9"] = "93:10",
		["10"] = "93:1",
		["11"] = "94:25",
		["12"] = "94:11",
		["13"] = "95:12",
		["14"] = "96:20",
		["15"] = "99:18",
		["16"] = "100:21",
		["17"] = "101:21",
		["21"] = "106:9",
		["24"] = "2:1",
		["25"] = "2:14",
		["26"] = "2:1",
		["28"] = "2:1",
		["29"] = "5:1",
		["30"] = "5:14",
		["31"] = "5:1",
		["33"] = "5:1",
		["34"] = "8:1",
		["35"] = "8:14",
		["36"] = "8:1",
		["38"] = "8:1",
		["39"] = "11:1",
		["40"] = "11:14",
		["41"] = "11:1",
		["42"] = "11:43",
		["43"] = "14:1",
		["44"] = "14:14",
		["45"] = "14:1",
		["46"] = "14:41",
		["47"] = "17:1",
		["48"] = "17:14",
		["49"] = "17:1",
		["50"] = "17:37",
		["51"] = "20:1",
		["52"] = "20:14",
		["53"] = "20:48",
		["55"] = "20:48",
		["57"] = "20:1",
		["58"] = "21:1",
		["59"] = "21:14",
		["60"] = "21:45",
		["62"] = "21:45",
		["64"] = "21:1",
		["65"] = "22:1",
		["66"] = "25:14",
		["67"] = "26:9",
		["68"] = "28:9",
		["70"] = "30:9",
		["72"] = "33:17",
		["74"] = "33:17",
		["76"] = "33:11",
		["77"] = "35:5",
		["78"] = "37:5",
		["79"] = "39:11",
		["80"] = "40:5",
		["81"] = "41:9",
		["82"] = "42:13",
		["83"] = "43:13",
		["85"] = "40:23",
		["86"] = "25:69",
		["88"] = "49:14",
		["89"] = "50:5",
		["90"] = "51:9",
		["91"] = "53:9",
		["93"] = "55:9",
		["95"] = "57:17",
		["97"] = "57:17",
		["99"] = "57:11",
		["100"] = "59:5",
		["101"] = "61:5",
		["102"] = "63:11",
		["103"] = "64:5",
		["104"] = "65:9",
		["105"] = "66:13",
		["106"] = "67:13",
		["108"] = "64:27",
		["109"] = "71:9",
		["110"] = "72:9",
		["111"] = "73:12",
		["112"] = "74:22",
		["113"] = "74:22",
		["114"] = "74:22",
		["116"] = "74:15",
		["117"] = "75:13",
		["118"] = "76:13",
		["120"] = "78:20",
		["121"] = "79:13",
		["123"] = "81:20",
		["124"] = "82:13",
		["127"] = "85:9",
		["129"] = "88:5",
		["130"] = "89:12",
		["131"] = "90:5",
		["132"] = "49:90",
	}
)
local ____exports = {}
local toDotaClassInstance
function toDotaClassInstance(self, instance, ____table)
	local ____table_10 = ____table
	local prototype = ____table_10.prototype
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
____exports.registerAbility = function(____, name, file_scope)
	return function(____, ability)
		if name ~= nil then
			ability.name = name
		else
			name = ability.name
		end
		local ____file_scope_6 = file_scope
		if ____file_scope_6 == nil then
			____file_scope_6 = getfenv(0)
		end
		local env = ____file_scope_6
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
--- 省略路径时由编译插件填写当前文件；已有显式路径用法保持兼容，第二参数可指定注册名。
____exports.registerModifier = function(____, file_path, name, file_scope)
	return function(____, modifier)
		assert(file_path, "registerModifier 缺少脚本路径，请使用项目 TSTL 插件或显式传入路径")
		if name ~= nil then
			modifier.name = name
		else
			name = modifier.name
		end
		local ____file_scope_7 = file_scope
		if ____file_scope_7 == nil then
			____file_scope_7 = getfenv(0)
		end
		local env = ____file_scope_7
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
			local ____base_name_8 = base
			if ____base_name_8 ~= nil then
				____base_name_8 = ____base_name_8.name
			end
			local name = ____base_name_8
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