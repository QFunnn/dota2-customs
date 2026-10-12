--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/sunlight/ts_utils/SunLightUnit.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
____debugRuntime.register(
	"utils/sunlight/ts_utils/SunLightUnit.lua",
	{
		["6"] = "1:11",
		["13"] = "8:5",
		["14"] = "21:15",
		["15"] = "21:41",
		["16"] = "21:47",
		["17"] = "21:57",
		["18"] = "21:68",
		["19"] = "21:76",
		["20"] = "21:88",
		["21"] = "21:100",
		["22"] = "21:112",
		["23"] = "21:119",
		["24"] = "21:23",
		["25"] = "22:15",
		["26"] = "23:9",
		["27"] = "24:19",
		["28"] = "25:19",
		["29"] = "26:19",
		["30"] = "26:56",
		["31"] = "26:85",
		["32"] = "26:46",
		["33"] = "27:17",
		["34"] = "28:17",
		["37"] = "31:9",
		["38"] = "8:5",
		["43"] = "39:5",
		["44"] = "40:15",
		["45"] = "41:13",
		["46"] = "42:13",
		["47"] = "43:9",
		["49"] = "44:18",
		["50"] = "44:33",
		["52"] = "45:19",
		["53"] = "46:27",
		["54"] = "46:27",
		["55"] = "46:38",
		["56"] = "46:38",
		["57"] = "46:59",
		["59"] = "46:66",
		["61"] = "46:37",
		["63"] = "46:81",
		["65"] = "46:13",
		["66"] = "47:23",
		["67"] = "47:23",
		["68"] = "47:34",
		["69"] = "47:34",
		["70"] = "47:55",
		["72"] = "47:66",
		["74"] = "47:33",
		["76"] = "47:77",
		["78"] = "47:13",
		["82"] = "49:9",
		["83"] = "39:5",
		["89"] = "58:5",
		["90"] = "59:15",
		["91"] = "60:15",
		["92"] = "61:9",
		["93"] = "62:19",
		["94"] = "63:17",
		["95"] = "64:17",
		["98"] = "67:9",
		["99"] = "58:5",
	}
)
SLUnit = SLUnit or {}
do
	--- 搜索扇形范围内的npc
	--
	-- @param direction 扇形方向(中心)
	-- @param angle 扇形角度
	-- @server
	function SLUnit.FindUnitsInSector(
		self,
		team,
		location,
		cacheUnit,
		radius,
		teamFilter,
		typeFilter,
		flagFilter,
		order,
		canGrowCache,
		direction,
		angle
	)
		local units = FindUnitsInRadius(
			team,
			location,
			cacheUnit,
			radius,
			teamFilter,
			typeFilter,
			flagFilter,
			order,
			canGrowCache
		)
		local returnTable = {}
		for ____, unit in ipairs(units) do
			local pos = unit:GetAbsOrigin()
			local unit2pointDirection = (pos - location):Normalized()
			local unit2pointAngle =
				math.abs(AngleDiff(VectorToAngles(direction).y, VectorToAngles(unit2pointDirection).y))
			if unit2pointAngle <= angle / 2 then
				returnTable[#returnTable + 1] = unit
			end
		end
		return returnTable
	end
	--- 获得最近的英雄
	--
	-- @param location
	-- @server
	function SLUnit.GetClosestHero(self, location)
		local heroList = HeroList:GetAllHeroes()
		local return_hero
		local min_dis
		for ____, hero in ipairs(heroList) do
			do
				if not IsValid(hero) then
					goto __continue8
				end
				local distance = (hero:GetAbsOrigin() - location):Length2D()
				local ____min_dis_1
				if min_dis then
					local ____temp_0
					if min_dis < distance then
						____temp_0 = hero
					else
						____temp_0 = return_hero
					end
					____min_dis_1 = ____temp_0
				else
					____min_dis_1 = hero
				end
				return_hero = ____min_dis_1
				local ____min_dis_3
				if min_dis then
					local ____temp_2
					if min_dis < distance then
						____temp_2 = distance
					else
						____temp_2 = min_dis
					end
					____min_dis_3 = ____temp_2
				else
					____min_dis_3 = distance
				end
				min_dis = ____min_dis_3
			end
			::__continue8::
		end
		return return_hero
	end
	--- 在范围内查找英雄
	--
	-- @param location
	-- @param radius
	-- @server
	function SLUnit.FindHeroInRadius(self, location, radius)
		local allHeroes = HeroList:GetAllHeroes()
		local result = {}
		for ____, hero in ipairs(allHeroes) do
			local distance = (hero:GetAbsOrigin() - location):Length2D()
			if distance <= radius then
				result[#result + 1] = hero
			end
		end
		return result
	end
end