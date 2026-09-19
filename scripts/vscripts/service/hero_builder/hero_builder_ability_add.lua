--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local AbilityLinks = require("service.hero_builder.ability_links")

---Добавляет способность герою, сохраняя modifier_hero_refreshing если он был снят на время добавления
---@param hero CDOTA_BaseNPC_Hero
---@param abilityName string
---@return CDOTABaseAbility?
local function AddAbilityPreservingRefresh(hero, abilityName)
	local hasInvulnerable = false
	if hero:HasModifier("modifier_hero_refreshing") then
		hasInvulnerable = true
		hero:RemoveModifierByName("modifier_hero_refreshing")
	end

	local ability = hero:AddAbility(abilityName)
	if hasInvulnerable then
		hero:AddNewModifier(hero, nil, "modifier_hero_refreshing", {})
	end

	return ability
end

---Настраивает только что добавленную способность: рефкаунт модификаторов, кулдаун, уровень, видимость
---@param hero CDOTA_BaseNPC_Hero
---@param ability CDOTABaseAbility
---@param levelNumber integer?
---@param cooldown float?
local function ConfigureAddedAbility(hero, ability, levelNumber, cooldown)
	ability:SetRefCountsModifiers(true)
	ability:ClearInnateModifiers()

	ability:MarkAbilityButtonDirty()
	if hero.CalculateStatBonus and type(hero.CalculateStatBonus) == "function" then
		hero:CalculateStatBonus(false)
	end

	if cooldown and cooldown > 0 then
		ability:StartCooldown(cooldown)
	end

	ability:SetLevel(0)
	if levelNumber and levelNumber > 0 then
		ability:SetLevel(levelNumber)
	end

	ability:SetHidden(false)
end

---Через кадр линкует способность: слот, связанные/скипетр/шард-способности и порядок в панели
---@param hero CDOTA_BaseNPC_Hero
---@param ability CDOTABaseAbility
---@param playerId integer
---@param abilityName string
---@param levelNumber integer?
local function ScheduleAbilityLinking(hero, ability, playerId, abilityName, levelNumber)
	Timers:CreateTimer(0.1, function()
		if not ability or ability:IsNull() then
			logger:Log("ability is null")
			return false
		end

		if ability.removalTimer then
			logger:Log("ability in RemovalTimer")
			return
		end
		HeroBuilderService:SetAbilityToSlot(hero, ability)
		HeroBuilderService:AddLinkedAbilities(hero, abilityName, levelNumber)
		HeroBuilderService:AddScepterLinkAbilities(hero)
		HeroBuilderService:AddShardLinkAbilities(hero, abilityName)
		HeroBuilderService:FixShardAbilities(hero)
		HeroBuilderService:RefreshAbilityOrder(playerId)

		return nil
	end)
end

---Довешивает на уже добавленную способность общий хвост: снятие intrinsic-модификатора,
---уровень, опциональные флаги и раскрытие в слот
---@param hero CDOTA_BaseNPC_Hero
---@param ability CDOTABaseAbility
---@param abilityName string
---@param options {level: integer, isScepterAbility: boolean?, markDirty: boolean?, revealInSlot: boolean?, revealDelay: number?}
local function MaterializeLinkedAbility(hero, ability, abilityName, options)
	hero:RemoveModifierByName(ability:GetIntrinsicModifierName() or "")
	ability:SetLevel(options.level)

	if options.isScepterAbility then
		ability.isScepterAbility = true
	end

	if options.markDirty then
		ability:MarkAbilityButtonDirty()
	end

	if options.revealInSlot then
		HeroBuilderService:SetAbilityToSlot(hero, ability)
		HeroBuilderService:RevealAbilityDelayed(hero, ability, abilityName, options.revealDelay)
	end
end

---@param playerId integer
---@param abilityName string
---@param levelNumber integer?
---@param cooldown float?
---@param unit CDOTA_BaseNPC?
function HeroBuilderService:AddAbility(playerId, abilityName, levelNumber, cooldown, unit)
	logger:Log("AbilityName = " .. abilityName)
	local hero = unit or PlayerResource:GetSelectedHeroEntity(playerId)
	if not hero then
		return
	end ---@cast hero CDOTA_BaseNPC_Hero

	self:PrecacheAbilityHero(abilityName)

	if not IsValidEntity(hero) or hero:HasAbility(abilityName) then
		return
	end

	local ability = AddAbilityPreservingRefresh(hero, abilityName)
	if not IsValid(ability) or (not hero:HasAbility(abilityName)) then
		return
	end
	---@cast ability CDOTABaseAbility

	ConfigureAddedAbility(hero, ability, levelNumber, cooldown)

	if not unit then
		AbilitySelectionService:Reset(playerId)
	end

	if
		AbilitySelectionService:GetPlayerAbilityCount(playerId) < AbilityQuota:GetTotal(playerId)
		and AbilitySelectionService:GetPlayerAbilityCount(playerId) < 6
	then
		AbilitySelectionService:ShowRandomAbilitySelection(playerId)
	end

	ScheduleAbilityLinking(hero, ability, playerId, abilityName, levelNumber)
end

---Добавляет способности связанные с аганим скиптером
---@param hero CDOTA_BaseNPC_Hero?
function HeroBuilderService:AddScepterAbility(hero)
	if (not hero) or (not hero:IsRealHero()) or (not hero:GetUnitName()) then
		return
	end

	local abilityList = AbilityLinks.scepterByHero[hero:GetUnitName()]
	for i, abilityName in ipairs(abilityList or {}) do
		if hero:FindAbilityByName(abilityName) then
			goto continue
		end

		local scepterAbility = hero:AddAbility(abilityName)
		if not IsValid(scepterAbility) then
			goto continue
		end

		local revealInSlot = i == 1
			or string.find(GetAbilityKeyValuesByName(abilityName).AbilityBehavior, "DOTA_ABILITY_BEHAVIOR_HIDDEN")
				== nil

		MaterializeLinkedAbility(hero, scepterAbility, abilityName, {
			level = 1,
			isScepterAbility = true,
			markDirty = true,
			revealInSlot = revealInSlot,
			revealDelay = 0.5,
		})

		::continue::
	end

	self:RefreshAbilityOrderNextFrame(hero)

	Timers:CreateTimer(FrameTime(), function()
		self:NormalizeScepterAbilityPairsVisibility(hero)
		return nil
	end)
end

-- Движок при поедании скипетра раскрывает обе половины toggle-пары, ломая свап
-- из modifier_abilities_fix — нормализуем видимость по состоянию героя
---@param hero CDOTA_BaseNPC_Hero?
function HeroBuilderService:NormalizeScepterAbilityPairsVisibility(hero)
	if not IsValid(hero) or not hero:GetUnitName() then
		return
	end ---@cast hero CDOTA_BaseNPC_Hero
	local abilityList = AbilityLinks.scepterByHero[hero:GetUnitName()]
	if not abilityList then
		return
	end

	local mainAbility = hero:FindAbilityByName(abilityList[1])
	if not IsValid(mainAbility) then
		return
	end ---@cast mainAbility CDOTABaseAbility

	local isActive = hero:HasModifier("modifier_" .. abilityList[1])
	for i = 2, #abilityList do
		local toggle = hero:FindAbilityByName(abilityList[i])
		local behavior = GetAbilityKeyValuesByName(abilityList[i]).AbilityBehavior
		if IsValid(toggle) and string.find(behavior, "DOTA_ABILITY_BEHAVIOR_HIDDEN") then ---@cast toggle CDOTABaseAbility
			mainAbility:SetHidden(isActive)
			toggle:SetHidden(not isActive)
		end
	end
end

---Добавить способность связанную с шардом
---@param hero CDOTA_BaseNPC_Hero?
---@param parentAbilityName string
function HeroBuilderService:AddShardLinkAbilities(hero, parentAbilityName)
	if not (hero and hero:IsRealHero() and hero:GetUnitName() and hero:HasShard()) then
		return
	end

	for loopAbilityName, abilityList in pairs(AbilityLinks.shardLinked) do
		local loopAbility = hero:FindAbilityByName(loopAbilityName)
		if not (loopAbility and not loopAbility:IsNull() and loopAbility.removalTimer == nil) then
			goto continueOuter
		end

		for i, abilityName in ipairs(abilityList) do
			local existingAbility = hero:FindAbilityByName(abilityName)
			if existingAbility and existingAbility.removalTimer == nil then
				goto continueInner
			end

			local shardAbility = hero:AddAbility(abilityName)
			if not (shardAbility and not shardAbility:IsNull()) then
				goto continueInner
			end

			local level = shardAbility:GetMaxLevel() == 1 and 1 or loopAbility:GetLevel()

			MaterializeLinkedAbility(hero, shardAbility, abilityName, {
				level = level,
				revealInSlot = i == 1,
				revealDelay = FrameTime(),
			})

			::continueInner::
		end

		::continueOuter::
	end

	self:RefreshAbilityOrderNextFrame(hero)
end

---Добавить способности от шарда и аганима героя
---@param heroIndex integer
function HeroBuilderService:AddScepterShardAbility(heroIndex)
	local hero = EntIndexToHScript(heroIndex) ---@type CDOTA_BaseNPC?
	if not (hero and hero:IsRealHero() and hero:GetUnitName()) then
		return
	end ---@cast hero CDOTA_BaseNPC_Hero

	local abilityList = AbilityLinks.scepterShardByHero[hero:GetUnitName()]
	if abilityList then
		for i, abilityName in ipairs(abilityList) do
			if hero:FindAbilityByName(abilityName) then
				goto continue
			end

			local scepterOrShardAbility = hero:AddAbility(abilityName)
			if not scepterOrShardAbility then
				goto continue
			end

			MaterializeLinkedAbility(hero, scepterOrShardAbility, abilityName, {
				level = 1,
				markDirty = true,
				revealInSlot = i == 1,
				revealDelay = 0.5,
			})

			::continue::
		end

		self:RefreshAbilityOrderNextFrame(hero)
	end

	if
		hero:GetUnitName() == "npc_dota_hero_lycan"
		and not hero:IsTempestDouble()
		and not hero:HasModifier("modifier_arc_warden_tempest_double_lua")
	then
		if not hero.elfWolfSpawned then
			hero.elfWolfSpawned = true
			ExtraCreature:AddExtraCreature(hero:GetPlayerID(), "npc_dota_elf_wolf")
		end
	end
end

---Добавляем абилку связанную с аганим скипетром
---@param hero CDOTA_BaseNPC_Hero?
function HeroBuilderService:AddScepterLinkAbilities(hero)
	if (not hero) or (not hero:IsRealHero()) or (not hero:GetUnitName()) or (not hero:HasScepter()) then
		return
	end

	for parentAbilityName, linkedAbilityList in pairs(AbilityLinks.scepterLinked) do
		local parentAbility = hero:FindAbilityByName(parentAbilityName)
		if not (parentAbility and not parentAbility:IsNull() and parentAbility.removalTimer == nil) then
			goto continueOuter
		end

		for i, linkedAbilityName in ipairs(linkedAbilityList) do
			local linkedAbility = hero:FindAbilityByName(linkedAbilityName)
			if linkedAbility and linkedAbility.removalTimer == nil then
				goto continueInner
			end

			local scepterAbility = hero:AddAbility(linkedAbilityName)
			if not scepterAbility or scepterAbility:IsNull() then
				logger:LogError("Can't add ScepterAbility" .. linkedAbilityName)
				goto continueInner
			end

			MaterializeLinkedAbility(hero, scepterAbility, linkedAbilityName, {
				level = 1,
				isScepterAbility = true,
				revealInSlot = i == 1,
				revealDelay = 0.5,
			})

			::continueInner::
		end

		::continueOuter::
	end

	self:RefreshAbilityOrderNextFrame(hero)
end

---Добавить герою свзяанные способности
---@param hero CDOTA_BaseNPC_Hero
---@param abilityName string
---@param levelNumber integer?
function HeroBuilderService:AddLinkedAbilities(hero, abilityName, levelNumber)
	local linkedAbilities = AbilityPool:GetLinkedAbilities(abilityName)
	if not linkedAbilities then
		return
	end

	for _, linkedAbilityName in ipairs(linkedAbilities) do
		if hero:HasAbility(linkedAbilityName) then
			goto continue
		end

		local newLinkedAbility = hero:AddAbility(linkedAbilityName)
		if not IsValid(newLinkedAbility) then
			logger:LogError("Failed to add LinkedAbility " .. (linkedAbilityName or "NOT VALID"))
			goto continue
		end

		if
			linkedAbilityName == "lone_druid_true_form_druid"
			or linkedAbilityName == "lone_druid_true_form_battle_cry"
		then
			newLinkedAbility:SetHidden(false)
		end

		if AbilityPool:GetLinkedAbilityLevel(linkedAbilityName) > 0 then
			newLinkedAbility:SetLevel(AbilityPool:GetLinkedAbilityLevel(linkedAbilityName))
		end
		if levelNumber and levelNumber > 0 then
			newLinkedAbility:SetLevel(levelNumber)
		end

		if newLinkedAbility and not newLinkedAbility:IsNull() then
			newLinkedAbility:MarkAbilityButtonDirty()
		end

		Timers:CreateTimer(0.1, function()
			if newLinkedAbility and not newLinkedAbility:IsNull() and not newLinkedAbility:IsHidden() then
				self:SetAbilityToSlot(hero, newLinkedAbility)
			end
			return nil
		end)

		::continue::
	end
end

---Чинит способности, связанные с шардом
---@param hero CDOTA_BaseNPC_Hero
function HeroBuilderService:FixShardAbilities(hero)
	if hero:HasModifier("modifier_item_aghanims_shard") then
		if hero:HasAbility("sandking_epicenter") then
			if not hero:HasModifier("modifier_sand_king_shard") then
				hero:AddNewModifier(hero, hero:FindAbilityByName("sandking_epicenter"), "modifier_sand_king_shard", {})
			end
		end
	end
end