--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---Прекеширует героя-владельца способности если ещё не закешировали
---@param abilityName string
function HeroBuilderService:PrecacheAbilityHero(abilityName)
	local shortHeroName = AbilityPool:GetAbilityHero(abilityName)
	if shortHeroName ~= nil and not self.PrecachedHeroList[shortHeroName] then
		self.PrecachedHeroList[shortHeroName] = true
		PrecacheUnitByNameAsync("npc_dota_hero_" .. shortHeroName, function(spawnGroupHandle)
			logger:Log("precache:", shortHeroName, "done")
			self.SpawnGroupsByHeroNames[shortHeroName] = spawnGroupHandle
		end)
	end
end

---Проверяет, нужен ли ещё прекеш героя-владельца абилок кому-либо на карте:
---либо это модель чьего-то героя, либо кто-то держит его абилку.
---@param shortHeroName string
---@return boolean
local function IsHeroPrecacheStillNeeded(shortHeroName)
	local fullHeroName = "npc_dota_hero_" .. shortHeroName
	for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:IsValidPlayer(playerId) then
			local hero = PlayerResource:GetSelectedHeroEntity(playerId)
			if IsValid(hero) then ---@cast hero CDOTA_BaseNPC_Hero
				if hero:GetUnitName() == fullHeroName then
					return true
				end
				for _, ownAbilityName in ipairs(hero.abilitiesList or {}) do
					if AbilityPool:GetAbilityHero(ownAbilityName) == shortHeroName then
						return true
					end
				end
			end
		end
	end
	return false
end

---Выгружает spawn group прекеша героя-владельца абилки, если абилками этого героя
---больше никто не пользуется
---@param abilityName string
function HeroBuilderService:UnloadHeroPrecacheIfUnused(abilityName)
	local shortHeroName = AbilityPool:GetAbilityHero(abilityName)
	if shortHeroName == nil then
		return
	end

	local spawnGroupHandle = self.SpawnGroupsByHeroNames[shortHeroName]
	if spawnGroupHandle == nil then
		return
	end

	if IsHeroPrecacheStillNeeded(shortHeroName) then
		return
	end

	self.PrecachedHeroList[shortHeroName] = nil
	self.SpawnGroupsByHeroNames[shortHeroName] = nil
	SafeUnloadSpawnGroup(spawnGroupHandle)
	logger:Log("precache unloaded:", shortHeroName)
end