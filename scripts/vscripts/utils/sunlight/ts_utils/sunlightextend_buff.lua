--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/sunlight/ts_utils/SunLightExtend_Buff.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
____debugRuntime.register(
	"utils/sunlight/ts_utils/SunLightExtend_Buff.lua",
	{
		["8"] = "28:5",
		["9"] = "29:15",
		["10"] = "30:14",
		["13"] = "31:9",
		["14"] = "28:44",
		["15"] = "34:5",
		["16"] = "35:15",
		["17"] = "36:14",
		["20"] = "37:9",
		["21"] = "34:49",
		["22"] = "40:5",
		["23"] = "41:15",
		["24"] = "42:14",
		["27"] = "43:9",
		["28"] = "40:34",
	}
)
local ____exports = {}
do
	CDOTA_Buff.GetAbilitySpecialValueFor = function(self, name)
		local ability = self:GetAbility()
		if not IsValid(ability) then
			return
		end
		return ability:GetSpecialValueFor(name)
	end
	CDOTA_Buff.GetAbilityLevelSpecialValueFor = function(self, name, level)
		local ability = self:GetAbility()
		if not IsValid(ability) then
			return
		end
		return ability:GetLevelSpecialValueFor(name, level)
	end
	CDOTA_Buff.GetAbilityLevel = function(self)
		local ability = self:GetAbility()
		if not IsValid(ability) then
			return
		end
		return ability:GetLevel()
	end
end
return ____exports