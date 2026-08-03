--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
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