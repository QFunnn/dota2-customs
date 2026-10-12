--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/sunlight/ts_utils/SunLightType.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
____debugRuntime.register(
	"utils/sunlight/ts_utils/SunLightType.lua",
	{
		["6"] = "13:11",
		["11"] = "18:5",
		["12"] = "19:9",
		["13"] = "18:5",
		["17"] = "25:5",
		["18"] = "26:9",
		["19"] = "25:5",
		["23"] = "32:5",
		["24"] = "33:9",
		["25"] = "32:5",
		["29"] = "39:5",
		["30"] = "40:9",
		["31"] = "39:5",
		["35"] = "52:5",
		["36"] = "53:9",
		["37"] = "52:5",
	}
)
SLType = SLType or {}
do
	--- 是否是 CBaseEntity
	--
	-- @both
	function SLType.Is_CBaseEntity(self, param)
		return type(param) == "table" and param.GetEntityIndex ~= nil
	end
	--- 是否是 CDOTA_BaseNPC
	--
	-- @both
	function SLType.Is_CDOTA_BaseNPC(self, param)
		return type(param) == "table" and param.GetUnitName ~= nil
	end
	--- 是否是 Vector
	--
	-- @both
	function SLType.Is_Vector(self, param)
		return type(param) == "userdata" and param.Length2D ~= nil
	end
	--- 是否是 CDOTA_BaseNPC_Hero
	--
	-- @both
	function SLType.Is_CDOTA_BaseNPC_Hero(self, param)
		return type(param) == "table"
			and param.GetStrength ~= nil
			and param.GetAgility ~= nil
			and param.GetIntellect ~= nil
	end
	--- 是否是 CDOTA_BaseNPC_Building
	--
	-- @both
	function SLType.Is_CDOTA_BaseNpc_Building(self, param)
		return type(param) == "table" and param.GetInvulnCount ~= nil and param.SetInvulnCount ~= nil
	end
end