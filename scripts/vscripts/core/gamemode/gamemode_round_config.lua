--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function GameMode:ReadRoundConfigurations()
    self.RoundList = {} ---@type table<integer, {RoundName: string, RoundData: any, Done: boolean}>
    self.vRoundData = {}
    self.vRoundListRaw = {}
    self.vRoundList = {}
    self.vRoundListFull = {}

    for roundIndex = 1, 50 do
        self.vRoundListRaw[roundIndex] = {}
        self.vRoundList[roundIndex] = {}
    end

    if roundsKV == nil then
        _G.roundsKV = LoadKeyValues("scripts/kv/rounds.txt") ---@type table<string, table<string, table<string, {UnitName: string, SpawnInterval: float, UnitNumber: integer}>>>
    end

    ---@param roundIndex integer
    ---@return table<string, table<string, { UnitName: string, SpawnInterval: number, UnitNumber: integer}>>
    local function GetMainRoundPool(roundIndex)
        return table.deepcopy(roundsKV[tostring(roundIndex)] or {})
    end


    ---@param roundIndex integer
    ---@return table<string, table<string, { UnitName: string, SpawnInterval: number, UnitNumber: integer }>>
    local function GetBonusRoundPool(roundIndex)
        local bonusPool = {} ---@type table<string, table<string, { UnitName: string, SpawnInterval: number, UnitNumber: integer }>>
        for phase = 1, roundIndex - 1 do
            if phase > 5 then
                break
            end
            local roundData = roundsKV[tostring(phase)]
            if roundData then
                for key, value in pairs(roundData) do
                    bonusPool[key] = value
                end
            end
        end
        return bonusPool
    end

    for roundIndex = 1, 50 do
        local mainPool = GetMainRoundPool(roundIndex)
        local bonusPool = GetBonusRoundPool(roundIndex)

        for wave = 1, 10 do
            local absoluteIndex = (roundIndex - 1) * 10 + wave
            local roundName
            local roundData

            if table.count(mainPool) > 0 then
                roundName = table.random_key(mainPool)
                roundData = table.deepcopy(mainPool[roundName])
                mainPool = table.remove_item_bykey(mainPool, roundName)
            else
                roundName = table.random_key(bonusPool)
                roundData = table.deepcopy(bonusPool[roundName])
                bonusPool = table.remove_item_bykey(bonusPool, roundName)
            end

            if GetMapName() == "2x6" then
                for _, unit in pairs(roundData) do
                    unit.UnitNumber = math.ceil(unit.UnitNumber * 2)
                end
            end

            self.RoundList[absoluteIndex] = {
                RoundName = roundName,
                RoundData = roundData,
                Done = false
            }
        end
    end
end

function GameMode:StartGameRounds()
    logger:Log("StartGameRounds call.")
    GameRulesCustom:SetTimeOfDay(0.26)
    GameRulesCustom:GetGameModeEntity():SetDaynightCycleAdvanceRate(1)

    GameRulesCustom.gameStartTime = GameRulesCustom:GetGameTime()
    self.currentRound = Round(1) ---@type Round

    Timers:CreateTimer(1, function()
        HeroBuilder:FixAttackCapability()
        HeroBuilder:ProcessScepterOwners()
        return 1
    end)
end