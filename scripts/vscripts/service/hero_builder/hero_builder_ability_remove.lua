--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local AbilityLinks = require("service.hero_builder.ability_links")

---@param unit CDOTA_BaseNPC
---@param rawAbilityName string
---@param linkTable table<string, string[]>
---@param keepTable table<string, string[]>
local function RemoveLinkedAbilities(unit, rawAbilityName, linkTable, keepTable)
	if not (unit and unit:IsRealHero() and unit:GetUnitName() and linkTable[rawAbilityName]) then
		return
	end
	for _, abilityName in ipairs(linkTable[rawAbilityName]) do
		local ability = unit:FindAbilityByName(abilityName)
		if ability then
			local keep = keepTable[unit:GetUnitName()]
			if keep == nil or not table.contains(keep, abilityName) then
				unit:RemoveAbilityWithRestructure(abilityName)
			end
		end
	end
	if unit.GetPlayerID and unit:GetPlayerID() then
		Timers:CreateTimer(FrameTime(), function()
			HeroBuilderService:RefreshAbilityOrder(unit:GetPlayerID())
			return nil
		end)
	end
end

---@param hero CDOTA_BaseNPC
---@param linkedAbilityName string
---@param excludingAbilityName string
---@return boolean
local function IsLinkedAbilityStillUsed(hero, linkedAbilityName, excludingAbilityName)
	for _, otherAbility in pairs(hero.abilitiesList) do
		local otherLinked = AbilityPool:GetLinkedAbilities(otherAbility)
		if otherAbility ~= excludingAbilityName and otherLinked and table.contains(otherLinked, linkedAbilityName) then
			return true
		end
	end
	return false
end

---Удалить все навыки стандартным образом (не затрагивая счётчик умений).
---@param playerId integer
---@param abilityName string
---@param unit CDOTA_BaseNPC | nil
function HeroBuilderService:RemoveAbility(playerId, abilityName, unit)
	local hero = unit or PlayerResource:GetSelectedHeroEntity(playerId)
	if not hero then
		return
	end
	local ability = hero:FindAbilityByName(abilityName)
	if not ability then
		return
	end
	-- Удалить связанные способности
	local linkedAbilities = AbilityPool:GetLinkedAbilities(abilityName)
	if linkedAbilities then
		for _, linkedAbilityName in ipairs(linkedAbilities) do
			local linkedAbility = hero:FindAbilityByName(linkedAbilityName)
			local isStillUsing = IsLinkedAbilityStillUsed(hero, linkedAbilityName, abilityName)

			if linkedAbility and not isStillUsing then
				if linkedAbility:IsHidden() then
					hero:RemoveAbilityForEmpty(linkedAbilityName)
				else
					hero:RemoveAbilityWithRestructure(linkedAbilityName)
				end
			end
		end
	end

	if abilityName == "jakiro_liquid_fire" then
		hero:RemoveAbilityForEmpty("jakiro_liquid_ice") --todo
	end

	if abilityName == "jakiro_liquid_ice" then
		hero:RemoveAbilityForEmpty("jakiro_liquid_fire")
	end

	hero:RemoveAbilityForEmpty(abilityName)
	HeroRefreshService:RemoveAbilityClean(hero, abilityName)
	RemoveLinkedAbilities(hero, abilityName, AbilityLinks.scepterLinked, AbilityLinks.scepterByHero)
	RemoveLinkedAbilities(hero, abilityName, AbilityLinks.shardLinked, AbilityLinks.scepterShardByHero)

	-- abilitiesList очищается вызывающим кодом уже после возврата из RemoveAbility,
	-- поэтому выгрузку прекеша откладываем на кадр.
	Timers:CreateTimer(FrameTime(), function()
		HeroBuilderService:UnloadHeroPrecacheIfUnused(abilityName)
		return nil
	end)
end

---Удалить все способности у героя
---@param playerId integer
---@return integer
function HeroBuilderService:RemoveAllAbility(playerId)
	local hero = PlayerResource:GetSelectedHeroEntity(playerId)

	if IsValid(hero) then ---@cast hero CDOTA_BaseNPC_Hero
		local abilitylist = {}
		for i = 0, hero:GetAbilityCount() - 1 do
			local ability = hero:GetAbilityByIndex(i)
			if ability ~= nil then
				hero:RemoveAbilityByHandle(ability)
			end
		end
		return #abilitylist
	end
	return 0
end