--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
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