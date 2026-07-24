--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if Spawner == nil then Spawner = class({}) end ---@class Spawner

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
        local exp = math.floor((GameRulesCustom.xpTable[safeLevel + 1] - GameRulesCustom.xpTable[safeLevel]) /
            self.round.creatureCount * self.round.flExpMulti)
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
    local spawnVector = GameMode.teamLocationMap[self.teamNumber] + RandomVector(spawnRandomRange)
    return CreateUnitByName(unitName, spawnVector, true, nil, nil, DOTA_TEAM_NEUTRALS)
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
        evalue = self.totalCreatureCount
    })
end

---@param self Spawner
local function LinkPlayersToSpawner(self)
    if SpawnerPlayerMap == nil then _G.SpawnerPlayerMap = {} end

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
        local unitName = vData.UnitName
        local totalUnitCount = tonumber(vData.UnitNumber)

        if totalUnitCount <= 0 then
            logger:Log("Invalid UnitNumber for " .. tostring(unitName))
            goto continue
        end

        local spawnInterval = tonumber(vData.SpawnInterval) or 1
        local unitSpawnInterval = GetUnitSpawnInterval(spawnInterval)

        local currentCreatureNumber = 0
        Timers:CreateTimer(RandomFloat(0, unitSpawnInterval), function()
            if self.isForceStop then return nil end

            currentCreatureNumber = currentCreatureNumber + 1
            local unit = CreateUnitAtSpawn(self, unitName, spawnRandomRange)
            SetupCreature(self, unit)
            unit:SetForwardVector(RandomVector(1))
            if trueSightCount < totalTrueSightCount then
                AddTrueSightForUnit(unit)
                trueSightCount = trueSightCount + 1
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
        if self.isForceStop then return nil end

        for _ = 1, Spawner.ExtraSpawnDispatchPerTick do
            currentIndex = currentIndex + 1
            local extraCreatureName = extraCreatureList[currentIndex]
            if not extraCreatureName then
                return nil
            end

            local unit = CreateUnitAtSpawn(self, extraCreatureName, spawnRandomRange)

            if IsValid(unit) and not self.isProgressFinished then
                SetupCreature(self, unit)
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

    for _, playerId in ipairs(GameMode.teamPlayerMap[self.teamNumber]) do
        local hero = PlayerResource:GetSelectedHeroEntity(playerId)

        if IsValid(hero) then ---@cast hero CDOTA_BaseNPC_Hero
            local bulletData = {
                type = "round_finish",
                gold_value = math.ceil(tostring(bonusGold) *
                    (100 + Util:GetPlayerBonusGoldPercentage(hero:GetPlayerOwnerID())) * 0.01),
                playerId = playerId
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
                        Util:MoveHeroToCenter(playerId)
                        if IsValid(hero) then
                            if not hero:IsAlive() then
                                hero:RespawnHero(false, false)
                            end
                            if not Features:GetFeatureState(Features.Keys.HeroRefreshingDisabled) then
                                hero:AddNewModifier(hero, nil, "modifier_hero_refreshing", {})
                            end
                        end
                        return nil
                    end
                })
            end
        end

        DataManager:EndRecord(playerId)
    end

    CustomGameEventManager:Send_ServerToTeam(self.teamNumber, "RemoveQuest", {
        name = "RoundProgress"
    })
end

---@param event OnEnitityKilledEvent
function Spawner:OnEntityKilled(event)
    local killedUnit = nil

    if event.entindex_killed then
        killedUnit = EntIndexToHScript(event.entindex_killed)
    end

    if not IsValid(killedUnit) then return end ---@cast killedUnit CDOTA_BaseNPC

    if killedUnit:IsHero() or killedUnit.nSpawnerTeamNumber ~= self.teamNumber then
        return
    end

    killedUnit:StopThink("CreepThink")

    self.killProgress = self.killProgress + 1

    SendQuestProgressEvent(self, "RefreshQuest", self.killProgress)

    if self.killProgress == self.totalCreatureCount then
        GiveMadstoneToTeam(self.teamNumber)
        self:Finish()
    end
end

--- @param teamNumber integer
--- @param round Round
function Spawner:Init(teamNumber, round)
    self.round = round
    self.teamNumber = teamNumber
    self.killProgress = 0
    self.extraCreatureCount = 0
    self.isProgressFinished = false
    self.isForceStop = false

    self.entityKilledEvent = ListenToGameEvent("entity_killed", function(event) self:OnEntityKilled(event) end, nil)
    LinkPlayersToSpawner(self)
    SpawnMainWaveUnits(self)
    SpawnExtraWaveUnits(self)
    self.totalCreatureCount = self.round.creatureCount + self.extraCreatureCount
    CreateProgressQuestUI(self)
end