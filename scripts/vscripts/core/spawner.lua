--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


if Spawner == nil then
	Spawner = class({})
end ---@class Spawner

Spawner.ExtraSpawnDispatchPerTick = 2
Spawner.ExtraSpawnTickInterval = 0.1

---@class CDOTA_BaseNPC
---@field nSpawnerTeamNumber integer

---@class CDOTA_BaseNPC_Hero
---@field bJoiningPvp boolean

---@param unit CDOTA_BaseNPC
local function AddTrueSightForUnit(unit)
	unit:AddNewModifier(unit, nil, "modifier_creature_true_sight", {})
end

local function GetUnitSpawnRange()
	if GameMode:GetMatchType() == MATCH_TYPE_DUO then
		return RandomInt(400, 600)
	end

	return RandomInt(450, 550)
end

---@param baseInterval number
---@return number
local function GetUnitSpawnInterval(baseInterval)
	if GameMode:GetMatchType() == MATCH_TYPE_DUO then
		return baseInterval / 1.2
	end

	return baseInterval
end

---@param self Spawner
---@param unit CDOTA_BaseNPC
---@param level integer
local function CreaturePowerUp(self, unit, level)
	unit:SetAcquisitionRange(1500)

	local flGoldBountyMultiple = 0.6
	unit:SetMinimumGoldBounty(math.floor(unit:GetMinimumGoldBounty() * flGoldBountyMultiple))
	unit:SetMaximumGoldBounty(math.floor(unit:GetMaximumGoldBounty() * flGoldBountyMultiple))

	if self.round and self.round.creatureCount and self.round.flExpMulti then
		local safeLevel = math.min(level, 999)
		local exp = math.floor(
			(GameRulesCustom.xpTable[safeLevel + 1] - GameRulesCustom.xpTable[safeLevel])
				/ self.round.creatureCount
				* self.round.flExpMulti
		)
		unit:SetDeathXP(exp)
	end

	unit:AddAbility("neutral_upgrade_lua"):SetLevel(1)

	if level > 100 then
		local desolateAbility = unit:AddAbility("creature_tear_armor")
		local abilityLevel = math.min(math.floor(level / 100), 10)
		desolateAbility:SetLevel(abilityLevel)
	end

	if level + 1 > 60 then
		unit:AddNewModifier(unit, nil, "modifier_creature_after60", {})
	end

	if level > 1 then
		unit:AddNewModifier(unit, nil, "modifier_creature_spell_amplify", {}):SetStackCount(level)
	end
end

---@param self Spawner
---@param unitName string
---@param spawnRandomRange integer
local function CreateUnitAtSpawn(self, unitName, spawnRandomRange)
	local spawnVector = self.round.match:GetTeamLocation(self.teamNumber) + RandomVector(spawnRandomRange)
	return CreateUnitByName(unitName, spawnVector, true, nil, nil, DOTA_TEAM_NEUTRALS), spawnVector
end

---@param self Spawner
---@param unit CDOTA_BaseNPC
local function SetupCreature(self, unit)
	unit.nSpawnerTeamNumber = self.teamNumber
	CreaturePowerUp(self, unit, self.round.roundNumber - 1)
end

---@param self Spawner
---@param eventName string
---@param svalue integer
local function SendQuestProgressEvent(self, eventName, svalue)
	CustomGameEventManager:Send_ServerToTeam(self.teamNumber, eventName, {
		name = "RoundProgress",
		text = "#round_progress",
		svalue = svalue,
		evalue = self.totalCreatureCount,
	})
end

---@param self Spawner
local function LinkPlayersToSpawner(self)
	if SpawnerPlayerMap == nil then
		_G.SpawnerPlayerMap = {}
	end

	for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:IsValidPlayer(playerId) then
			SpawnerPlayerMap[playerId] = self
		end
	end
end

---@param self Spawner
local function CreateProgressQuestUI(self)
	SendQuestProgressEvent(self, "CreateQuest", 0)
end

---@param self Spawner
local function SpawnMainWaveUnits(self)
	local spawnRandomRange = GetUnitSpawnRange()
	local trueSightCount = 0
	local totalTrueSightCount = math.floor(self.round.roundNumber / 15)

	for _, vData in pairs(GameMode.RoundList[self.round.roundNumber].RoundData) do
		local unitName = vData.unitName
		local totalUnitCount = tonumber(vData.unitNumber)

		if totalUnitCount <= 0 then
			logger:Log("Invalid unitNumber for " .. tostring(unitName))
			goto continue
		end

		local spawnInterval = tonumber(vData.spawnInterval) or 1
		local unitSpawnInterval = GetUnitSpawnInterval(spawnInterval)

		local currentCreatureNumber = 0
		Timers:CreateTimer(RandomFloat(0, unitSpawnInterval), function()
			if self.isForceStop then
				return nil
			end

			currentCreatureNumber = currentCreatureNumber + 1

			local spawnVector
			local ok, err = pcall(function()
				local unit
				unit, spawnVector = CreateUnitAtSpawn(self, unitName, spawnRandomRange)
				if not IsValid(unit) then
					error("CreateUnitByName returned invalid unit")
				end
				self.spawnedCount = self.spawnedCount + 1
				SetupCreature(self, unit)
				unit:SetForwardVector(RandomVector(1))
				if trueSightCount < totalTrueSightCount then
					AddTrueSightForUnit(unit)
					trueSightCount = trueSightCount + 1
				end
			end)

			if not ok then
				local posText = spawnVector
						and string.format("(%.0f,%.0f,%.0f)", spawnVector.x, spawnVector.y, spawnVector.z)
					or "nil"
				logger:Logf(
					"[SpawnDiag] main spawn stopped: team=%d round=%d unit=%s idx=%d/%d pos=%s err=%s",
					self.teamNumber,
					self.round.roundNumber,
					tostring(unitName),
					currentCreatureNumber,
					totalUnitCount,
					posText,
					tostring(err)
				)
				return nil
			end

			if currentCreatureNumber == totalUnitCount then
				return nil
			else
				return unitSpawnInterval
			end
		end)

		::continue::
	end
end

---@param self Spawner
local function SpawnExtraWaveUnits(self)
	local spawnRandomRange = GetUnitSpawnRange()
	local extraCreatureList = {}

	for creatureMapTeamNumber, list in pairs(ExtraCreature.teamCreatureMap) do
		if creatureMapTeamNumber ~= self.teamNumber then
			for _, extraCreatureName in ipairs(list) do
				table.insert(extraCreatureList, extraCreatureName)
				self.extraCreatureCount = self.extraCreatureCount + 1
			end
		end
	end

	if #extraCreatureList <= 0 then
		return
	end

	local currentIndex = 0
	Timers:CreateTimer(0, function()
		if self.isForceStop then
			return nil
		end

		for _ = 1, Spawner.ExtraSpawnDispatchPerTick do
			currentIndex = currentIndex + 1
			local extraCreatureName = extraCreatureList[currentIndex]
			if not extraCreatureName then
				return nil
			end

			local unit = CreateUnitAtSpawn(self, extraCreatureName, spawnRandomRange)

			if not IsValid(unit) then
				logger:Logf(
					"[SpawnDiag] extra CreateUnit invalid: team=%d round=%d unit=%s",
					self.teamNumber,
					self.round.roundNumber,
					tostring(extraCreatureName)
				)
			elseif self.isProgressFinished then
				logger:Logf(
					"[SpawnDiag] extra creep created but NOT setup (isProgressFinished): team=%d round=%d unit=%s",
					self.teamNumber,
					self.round.roundNumber,
					tostring(extraCreatureName)
				)
			else
				local ok, err = pcall(SetupCreature, self, unit)
				if ok then
					self.spawnedCount = self.spawnedCount + 1
				else
					logger:Logf(
						"[SpawnDiag] extra SetupCreature failed: team=%d round=%d unit=%s err=%s",
						self.teamNumber,
						self.round.roundNumber,
						tostring(extraCreatureName),
						tostring(err)
					)
				end
			end
		end

		return Spawner.ExtraSpawnTickInterval
	end)
end

---@param teamNumber DOTATeam_t
local function GiveMadstoneToTeam(teamNumber)
	local palyerCountInTeam = PlayerResource:GetPlayerCountForTeam(teamNumber)

	for i = 0, palyerCountInTeam - 1 do
		local playerId = PlayerResource:GetNthPlayerIDOnTeam(teamNumber, i + 1)
		if playerId ~= -1 and PlayerResource:IsValidPlayerID(playerId) then
			local hero = PlayerResource:GetSelectedHeroEntity(playerId)
			if IsValid(hero) then ---@cast hero CDOTA_BaseNPC_Hero
				hero:AddItemByName("item_madstone_bundle")
			end
		end
	end
end

function Spawner:Finish()
	logger:Log(string.format("Spawner finish called for team %d.", self.teamNumber))
	self.round.playerRank = self.round.playerRank + 1
	self.isProgressFinished = true
	self.isForceStop = true

	StopListeningToGameEvent(self.entityKilledEvent)

	local flReducePerRank = 0
	if self.round.aliveTeamCount >= 1 then
		flReducePerRank = 1 / self.round.aliveTeamCount
	end

	local bonusGold = math.ceil(self.round.flBonus * (1 - (self.round.playerRank - 1) * flReducePerRank))

	for _, playerId in ipairs(self.round.match:GetTeam(self.teamNumber):GetPlayers()) do
		local hero = PlayerResource:GetSelectedHeroEntity(playerId)

		if IsValid(hero) then ---@cast hero CDOTA_BaseNPC_Hero
			local bulletData = {
				type = "round_finish",
				gold_value = math.ceil(
					tostring(bonusGold)
						* (100 + GoldService:GetPlayerBonusGoldPercentage(hero:GetPlayerOwnerID()))
						* 0.01
				),
				playerId = playerId,
			}

			Barrage:FireBullet(bulletData)

			hero:ModifyGoldFiltered(bonusGold, true, DOTA_ModifyGold_Unspecified)

			if not hero.bJoiningPvp then
				if not hero:IsAlive() then
					hero:RespawnHero(false, false)
				end

				Timers:CreateTimer({
					endTime = 0.5,
					callback = function()
						HeroPlacementService:MoveHeroToCenter(playerId)
						if IsValid(hero) then
							if not hero:IsAlive() then
								hero:RespawnHero(false, false)
							end
							if not Features:GetFeatureState(Features.Keys.HeroRefreshingDisabled) then
								hero:AddNewModifier(hero, nil, "modifier_hero_refreshing", {})
							end
						end
						return nil
					end,
				})
			end
		end

		DataManager:EndRecord(playerId)
	end

	CustomGameEventManager:Send_ServerToTeam(self.teamNumber, "RemoveQuest", {
		name = "RoundProgress",
	})
end

---@param event OnEnitityKilledEvent
function Spawner:OnEntityKilled(event)
	local killedUnit = nil

	if event.entindex_killed then
		killedUnit = EntIndexToHScript(event.entindex_killed)
	end

	if not IsValid(killedUnit) then
		return
	end ---@cast killedUnit CDOTA_BaseNPC

	if killedUnit:IsHero() or killedUnit.nSpawnerTeamNumber ~= self.teamNumber then
		return
	end

	killedUnit:StopThink("CreepThink")

	self.killProgress = self.killProgress + 1
	killedUnit.nSpawnerTeamNumber = nil

	SendQuestProgressEvent(self, "RefreshQuest", self.killProgress)

	if self.killProgress == self.totalCreatureCount then
		GiveMadstoneToTeam(self.teamNumber)
		self:Finish()
	end
end

---@param reason string
function Spawner:LogProgressDump(reason)
	local aliveOwn = 0
	local units = FindUnitsInRadius(
		DOTA_TEAM_NEUTRALS,
		Vector(0, 0, 0),
		nil,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, unit in pairs(units) do
		if IsValid(unit) and unit.nSpawnerTeamNumber == self.teamNumber and unit:IsAlive() then
			aliveOwn = aliveOwn + 1
			local pos = unit:GetAbsOrigin()
			logger:Logf(
				"[SpawnDiag] aliveOwn: team=%d round=%d unit=%s pos=(%.0f,%.0f,%.0f) hp=%d/%d",
				self.teamNumber,
				self.round.roundNumber,
				unit:GetUnitName(),
				pos.x,
				pos.y,
				pos.z,
				unit:GetHealth(),
				unit:GetMaxHealth()
			)
		end
	end

	local center = self.round.match:GetTeamLocation(self.teamNumber)
	local centerText = center and string.format("(%.0f,%.0f,%.0f)", center.x, center.y, center.z) or "nil"
	logger:Logf(
		"[SpawnDiag] dump(%s) team=%d round=%d spawned=%d kill=%d total=%d extra=%d aliveOwn=%d finished=%s center=%s",
		tostring(reason),
		self.teamNumber,
		self.round.roundNumber,
		self.spawnedCount,
		self.killProgress,
		self.totalCreatureCount,
		self.extraCreatureCount,
		aliveOwn,
		tostring(self.isProgressFinished),
		centerText
	)
end

--- @param teamNumber integer
--- @param round Round
function Spawner:Init(teamNumber, round)
	self.round = round
	self.teamNumber = teamNumber
	self.killProgress = 0
	self.spawnedCount = 0
	self.extraCreatureCount = 0
	self.isProgressFinished = false
	self.isForceStop = false

	self.entityKilledEvent = ListenToGameEvent("entity_killed", function(event)
		self:OnEntityKilled(event)
	end, nil)
	LinkPlayersToSpawner(self)
	SpawnMainWaveUnits(self)
	SpawnExtraWaveUnits(self)
	self.totalCreatureCount = self.round.creatureCount + self.extraCreatureCount
	CreateProgressQuestUI(self)
end