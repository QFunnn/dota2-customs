--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local AbilityExclusions = require("service.ability.ability_exclusions")

---@param event any
local function SwapNotValide(event)
	if not event.own or not event.other then
		return
	end

	if event.proposer_id then
		local proposeHero = PlayerResource:GetSelectedHeroEntity(event.proposer_id)
		proposeHero.swappingItemIndex = nil
	end
	local player = PlayerResource:GetPlayer(event.PlayerID)
	CustomGameEventManager:Send_ServerToPlayer(player, "SwapNotValide", event)
end

---@param event any
---@param accept boolean
local function ResetSwapStatus(event, accept)
	if not event.own or not event.other then
		return
	end
	local verification = tostring(event.own) .. "_" .. tostring(event.other)
	if not HeroBuilderService.pendingSwaps[verification] then
		return
	end

	if event.proposer_id then
		local proposeHero = PlayerResource:GetSelectedHeroEntity(event.proposer_id)
		proposeHero.swappingItemIndex = nil
	end

	if event.item_index and accept then
		local swapItem = EntIndexToHScript(event.item_index)
		if swapItem and swapItem.SpendCharge then
			swapItem:SpendCharge()
		end
	end

	event.accepted = accept
	HeroBuilderService.pendingSwaps[verification] = nil
	CustomGameEventManager:Send_ServerToTeam(event.team_nubmer, "UnlockAbilities", event)
end

---@param exclusionList string[]
---@param predicate fun(exclusion: string): boolean
---@return boolean
local function SwapConflictEvent(exclusionList, predicate)
	for _, exclusion in ipairs(exclusionList) do
		if predicate(exclusion) then
			return true
		end
	end
	return false
end

---Обработчик инициализации командного свапа
---@param event any
function HeroBuilderService:ProposeTeammateSwap(event)
	if not event.own or not event.other then
		return
	end
	local proposeHero = PlayerResource:GetSelectedHeroEntity(event.PlayerID)

	if not proposeHero then
		logger:Log("proposeHero is nil")
		return
	end

	if proposeHero.teamSwapUiSecret ~= event.ui_secret then
		logger:Log("event.ui_secret" .. event.ui_secret .. "is wrong")
		return
	end

	if not proposeHero.swappingItemIndex then
		logger:Log("proposeHero.swappingItemIndex is false")
		return
	end

	local firstAbility = EntIndexToHScript(event.own)

	if not firstAbility then
		return
	end
	if not firstAbility:GetCaster() then
		return
	end

	if event.PlayerID ~= firstAbility:GetCaster():GetPlayerID() then
		logger:Log("event.PlayerID is wrong")
		return
	end

	event.team_nubmer = PlayerResource:GetTeam(event.PlayerID)
	event.proposer_id = event.PlayerID

	local secondAbility = EntIndexToHScript(event.other)
	if not secondAbility then
		logger:Log("secondAbility is nil")
		return
	end

	local firstPlayer = firstAbility:GetCaster():GetPlayerOwner()
	local secondPlayer = secondAbility:GetCaster():GetPlayerOwner()

	local firstHero = firstAbility:GetCaster()
	local secondHero = secondAbility:GetCaster()

	local firstAbilityName = firstAbility:GetAbilityName()
	local secondAbilityName = secondAbility:GetAbilityName()

	local conflicts = {
		{
			AbilityExclusions.byAbility[secondAbilityName],
			function(ex)
				return table.contains(firstHero.abilitiesList, ex) and ex ~= firstAbilityName
			end,
			"ConflictAbility",
		},
		{
			AbilityExclusions.byAbility[firstAbilityName],
			function(ex)
				return table.contains(secondHero.abilitiesList, ex) and ex ~= secondAbilityName
			end,
			"ConflictTeammateAbility",
		},
		{
			AbilityExclusions.byHeroModel[firstHero:GetUnitName()],
			function(ex)
				return ex == secondAbilityName
			end,
			"ConflictModel",
		},
		{
			AbilityExclusions.byHeroModel[secondHero:GetUnitName()],
			function(ex)
				return ex == firstAbilityName
			end,
			"ConflictTeammateModel",
		},
	}

	for _, c in ipairs(conflicts) do
		if c[1] and SwapConflictEvent(c[1], c[2]) then
			if firstPlayer then
				CustomGameEventManager:Send_ServerToPlayer(firstPlayer, c[3], {})
			end
			SwapNotValide(event)
			return
		end
	end

	local verification = tostring(event.own) .. "_" .. tostring(event.other)
	self.pendingSwaps[verification] = event

	if PlayerResource:IsFakeClient(secondHero:GetPlayerID()) then
		self:AcceptTeammateSwap(event)
	else
		CustomGameEventManager:Send_ServerToTeam(secondAbility:GetCaster():GetTeamNumber(), "LockAbilities", event)
		Timers:CreateTimer(1 / 15, function()
			CustomGameEventManager:Send_ServerToPlayer(secondPlayer, "SwapProposed", event)
			return nil
		end)

		Timers:CreateTimer(verification, {
			useGameTime = false,
			endTime = 19.8,
			callback = function()
				ResetSwapStatus(event, false)
				return nil
			end,
		})
	end
end

---Обрабатывает событие свапа способности
---@param event any
function HeroBuilderService:AcceptTeammateSwap(event)
	xpcall(function()
		if not event.own or not event.other then
			return
		end

		local verification = tostring(event.own) .. "_" .. tostring(event.other)
		if not self.pendingSwaps[verification] then
			return
		end

		local swapData = self.pendingSwaps[verification]
		if swapData.own ~= event.own or swapData.other ~= event.other then
			return
		end

		Timers:RemoveTimer(verification)

		local firstAbility = EntIndexToHScript(event.own)
		local secondAbility = EntIndexToHScript(event.other)

		if not firstAbility or not secondAbility then
			logger:Log("firstAbility or secondAbility not there")
			event.team_nubmer = PlayerResource:GetTeam(event.PlayerID)
			ResetSwapStatus(event, false)
			return
		end

		if event.item_index and type(event.item_index) == "number" then
			local swapItem = EntIndexToHScript(event.item_index)
			if not swapItem then
				logger:Log("swapItem not there")
				ResetSwapStatus(event, false)
				return
			end
		else
			logger:Log("event.item_index is wrong")
			ResetSwapStatus(event, false)
			return
		end

		local firstHero = firstAbility:GetCaster()
		local secondHero = secondAbility:GetCaster()

		local firstAbilityName = firstAbility:GetAbilityName()
		local secondAbilityName = secondAbility:GetAbilityName()

		local secondPlayerId = secondHero:GetPlayerOwnerID()
		if event.PlayerID ~= secondPlayerId and not PlayerResource:IsFakeClient(secondPlayerId) then
			return
		end

		local firstPlayerId = firstHero:GetPlayerOwnerID()

		if not table.contains(firstHero.abilitiesList, firstAbilityName) then
			ResetSwapStatus(event, false)
			return
		end

		if not table.contains(secondHero.abilitiesList, secondAbilityName) then
			ResetSwapStatus(event, false)
			return
		end

		if not firstHero:HasAbility(firstAbilityName) then
			ResetSwapStatus(event, false)
			return
		end

		if not secondHero:HasAbility(secondAbilityName) then
			ResetSwapStatus(event, false)
			return
		end

		event.team_nubmer = PlayerResource:GetTeam(event.PlayerID)
		event.proposer_id = firstHero:GetPlayerOwnerID()

		local firstCooldown = firstAbility:GetCooldownTimeRemaining()
		local secondCooldown = secondAbility:GetCooldownTimeRemaining()

		firstHero:SetAbilityPoints(firstHero:GetAbilityPoints() + firstAbility:GetLevel())
		secondHero:SetAbilityPoints(secondHero:GetAbilityPoints() + secondAbility:GetLevel())

		self:RemoveAbility(firstPlayerId, firstAbilityName)
		self:RemoveAbility(secondPlayerId, secondAbilityName)

		self:AddAbility(firstPlayerId, secondAbilityName, nil, secondCooldown)
		self:AddAbility(secondPlayerId, firstAbilityName, nil, firstCooldown)

		self:ReplaceAbilityList(firstHero, firstAbilityName, secondAbilityName)
		self:ReplaceAbilityList(secondHero, secondAbilityName, firstAbilityName)

		Timers:CreateTimer(0.02, function()
			self:RefreshAbilityOrder(firstHero:GetPlayerOwnerID())
			self:RefreshAbilityOrder(secondHero:GetPlayerOwnerID())
			return nil
		end)

		ResetSwapStatus(event, true)
	end, function(e)
		logger:LogError(e)
		ResetSwapStatus(event, false)
	end)
end

function HeroBuilderService:DeclineTeammateSwap(keys)
	local playerId = keys.PlayerID
	keys.team_nubmer = PlayerResource:GetTeam(playerId)
	ResetSwapStatus(keys, false)
end