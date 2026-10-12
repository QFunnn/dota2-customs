--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/sunlight/ts_utils/SunLightExtend_HeroList.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
____debugRuntime.register(
	"utils/sunlight/ts_utils/SunLightExtend_HeroList.lua",
	{
		["8"] = "32:5",
		["9"] = "33:15",
		["10"] = "34:15",
		["11"] = "35:9",
		["12"] = "36:17",
		["13"] = "37:17",
		["16"] = "40:9",
		["17"] = "32:40",
		["18"] = "42:5",
		["19"] = "43:9",
		["20"] = "42:40",
		["21"] = "45:5",
		["22"] = "46:9",
		["23"] = "45:43",
		["24"] = "48:5",
		["25"] = "49:9",
		["26"] = "48:47",
	}
)
local ____exports = {}
do
	CScriptHeroList.GetAllRealHeroes = function(self)
		local return_array = {}
		local allHeroes = self:GetAllHeroes()
		for ____, hero in ipairs(allHeroes) do
			if hero:IsRealHero() then
				return_array[#return_array + 1] = hero
			end
		end
		return return_array
	end
	CScriptHeroList.GetRealHeroCount = function(self)
		return #self:GetAllRealHeroes()
	end
	CScriptHeroList.GetAllHeroesShuffle = function(self)
		return table.shuffle(self:GetAllHeroes())
	end
	CScriptHeroList.GetAllRealHeroesShuffle = function(self)
		return table.shuffle(self:GetAllRealHeroes())
	end
end
return ____exports