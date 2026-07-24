--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if RoundController == nil then 
    RoundController = class({}) 
end

function RoundController:constructor(RoundNum, RoundInfo, CurrentPVPPair, PrepareTime)
    self.RoundNum = RoundNum
    self.RoundInfo = RoundInfo
    self.TeamsData = {}
    self.nEntityKilledEvent = ListenToGameEvent( "entity_killed", Dynamic_Wrap( RoundController, 'OnEntityKilled' ), self )
    self.TeamRankInRound = 0
    self.TeamsCount = 0
    self.CurrentPVPPair = CurrentPVPPair
    self.PrepareTime = PrepareTime

    self.AdditionalEntities = {}
    self.AdditionalEntities2 = {}

    self.LastRune = nil
    self.LastRuneItem = nil

    self.FxCircle = nil
    self.FxPreCircle = nil
    self.FxCircleEnd = nil

    self.instanceID = DoUniqueString("round_controller")

    -- [STASHFIX] Баг: после смерти движок ошибочно оставляет интринсик-модификаторы у
    -- предметов в рюкзаке(6-8)/тайнике(9-14), и без изменения инвентаря сам их не снимает.
    -- Решение: ОДИН раз после респа героя снимаем такие модификаторы (не оправданные
    -- предметом в активном слоте 0-5). Снятие держится (движок без смены слота заново не
    -- добавит). Глобальный хук на смерть, регистрируем один раз.
    if not _G.__stashfix_started then
        _G.__stashfix_started = true

        local function CleanupBackpackMods(h)
            if not h or h:IsNull() then return end
            local activeMods = {}
            for slot = 0, 5 do
                local it = h:GetItemInSlot(slot)
                if it and not it:IsNull() and it.GetIntrinsicModifierName then
                    local m = it:GetIntrinsicModifierName()
                    if m and m ~= "" then activeMods[m] = true end
                end
            end
            for slot = 6, 14 do
                local it = h:GetItemInSlot(slot)
                if it and not it:IsNull() and it.GetIntrinsicModifierName then
                    local m = it:GetIntrinsicModifierName()
                    if m and m ~= "" and not activeMods[m] and h:HasModifier(m) then
                        h:RemoveModifierByName(m)
                    end
                end
            end
        end

        ListenToGameEvent("entity_killed", function(event)
            local killed = EntIndexToHScript(event.entindex_killed or -1)
            if not killed or killed:IsNull() then return end
            if not killed.IsRealHero or not killed:IsRealHero() then return end
            -- ждём респа, затем один раз чистим (с маленькой задержкой, чтобы движок
            -- успел ошибочно восстановить модификаторы на респе — и мы их сняли ПОСЛЕ).
            local attempts = 0
            Timers:CreateTimer(0.5, function()
                if killed:IsNull() then return end
                if killed:IsAlive() then
                    Timers:CreateTimer(0.2, function()
                        if not killed:IsNull() then CleanupBackpackMods(killed) end
                    end)
                    return
                end
                attempts = attempts + 1
                if attempts > 120 then return end -- ~60с страховка, если не ожил
                return 0.5
            end)
        end, nil)
    end

    self:PrepareRound()
end

function RoundController:PrepareRound()
    local SpectatorsTeams = Players:GetAllActivatedTeams(true)
    table.insert(SpectatorsTeams, 1)

    for _, TeamID in ipairs(SpectatorsTeams) do
        local PrevData = CustomNetTables:GetTableValue("globals", "team_"..TeamID.."_round_info")
        if not Players:IsActiveTeam(TeamID) then
            local LastTime = GameRules:GetGameTime()
            if PrevData and PrevData.last_time ~= nil then
                LastTime = PrevData.last_time
            end
            local Data = {
                creeps = {},
                extra_creeps = {},
                creeps_info = {},
                max_creeps = 0,
                killed_creeps = 0,
                is_duel = false,
                duel_opponent = nil,
                duel_spectator_pair = nil,

                time = LastTime,

                start_delay = 0,

                state = GAME_STATES.SPECTATE,
            }

            if self.CurrentPVPPair ~= nil then
                local Pair = {
                    fPlayer = 0,
                    sPlayer = 0,
                }

                local fTeam = self.CurrentPVPPair.fTeam
                local sTeam = self.CurrentPVPPair.sTeam

                local fPlayer = Players:GetTeamPlayerByNum(fTeam, 1)
                local sPlayer = Players:GetTeamPlayerByNum(sTeam, 1)

                Pair.fPlayer = fPlayer
                Pair.sPlayer = sPlayer

                Data.duel_spectator_pair = Pair
            end

            if self.RoundInfo.type == ROUND_TYPES.BASIC and not Rounds:IsTeamInPVPDuel(TeamID) and self.RoundInfo.creeps ~= nil then
                for UnitName, UnitInfo in pairs(self.RoundInfo.creeps) do
                    Data.max_creeps = Data.max_creeps + UnitInfo.count
                end

                local ExtraCreepsList = Rounds:GetExtraCreepsForTeam(TeamID)

                Data.max_creeps = Data.max_creeps + #ExtraCreepsList

                Data.creeps = table.keys(self.RoundInfo.creeps)

                local ExtraCreeps = {}
                for _, Info in ipairs(ExtraCreepsList) do
                    if not table.contains(ExtraCreeps, Info.name) then
                        table.insert(ExtraCreeps, Info.name)
                    end
                end

                Data.extra_creeps = ExtraCreeps
                Data.creeps_info = self:GetCreepsInfo(self.RoundInfo.creeps, ExtraCreepsList)
            end

            PlayerTables:SetTableValue("team_"..TeamID, "round_info", Data)

            CustomNetTables:SetTableValue("globals", "team_"..TeamID.."_round_info", {last_time = Data.time, current_state = Data.state})
        end
    end
    for TeamID, TeamInfo in pairs(Players:GetAllActiveTeams()) do
        self.TeamsData[TeamID] = {
            arena = "",
            creeps_list = {},
            creeps_info = {},
            extra_creeps_info = {},
            max_in_round = 0,
            killed_in_round = 0,
            panorama_info = {
                creeps = {},
                extra_creeps = {},
                creeps_info = {},
                max_creeps = 0,
                killed_creeps = 0,
                is_duel = Rounds:IsTeamInPVPDuel(TeamID),
                duel_opponent = nil,

                time = GameRules:GetGameTime() + self.PrepareTime,

                start_delay = Rounds:GetTeamStartDelay(TeamID),

                state = GAME_STATES.PREPARING,
            },

            begined = false,
            start_time = 0,
            time_over = false,
        }

        if self.RoundInfo.type == ROUND_TYPES.BASIC then
            local ArenaName = TeamInfo.arena
            local Arena = Map:GetArenaInfo(ArenaName)
            if Arena and not Rounds:IsTeamInPVPDuel(TeamID) and self.RoundInfo.creeps ~= nil then

                self.TeamsData[TeamID].arena = ArenaName


                for UnitName, UnitInfo in pairs(self.RoundInfo.creeps) do
                    self.TeamsData[TeamID].max_in_round = self.TeamsData[TeamID].max_in_round + UnitInfo.count
                end

                local ExtraCreepsList = Rounds:GetExtraCreepsForTeam(TeamID)

                self.TeamsData[TeamID].max_in_round = self.TeamsData[TeamID].max_in_round + #ExtraCreepsList

                self.TeamsData[TeamID].panorama_info.creeps = table.keys(self.RoundInfo.creeps)

                local ExtraCreeps = {}
                for _, Info in ipairs(ExtraCreepsList) do
                    if not table.contains(ExtraCreeps, Info.name) then
                        table.insert(ExtraCreeps, Info.name)
                    end
                end

                self.TeamsData[TeamID].panorama_info.extra_creeps = ExtraCreeps
                self.TeamsData[TeamID].panorama_info.max_creeps = self.TeamsData[TeamID].max_in_round

                self.TeamsData[TeamID].panorama_info.creeps_info = self:GetCreepsInfo(self.RoundInfo.creeps, ExtraCreepsList)

                GameRules:GetGameModeEntity():SetThink(function()
                    if Players:IsActiveTeam(TeamID) then
                        local i = 0
                        for UnitName, UnitInfo in pairs(self.RoundInfo.creeps) do
                            if not self.TeamsData[TeamID].creeps_info[UnitName] then
                                self.TeamsData[TeamID].creeps_info[UnitName] = {next_spawn = GameRules:GetGameTime()+0.4+(i*0.05), count=1}

                                local RandomPos = Arena.center + RandomVector(RandomFloat(450, 550))

                                self:SpawnCreep(UnitName, TeamID, RandomPos, false, nil, self.RoundNum)
                                break
                            elseif UnitInfo.count > self.TeamsData[TeamID].creeps_info[UnitName].count then
                                local diff = self.TeamsData[TeamID].creeps_info[UnitName].next_spawn - GameRules:GetGameTime()
                                if diff <= 0 then
                                    self.TeamsData[TeamID].creeps_info[UnitName].next_spawn = GameRules:GetGameTime()+0.4+(i*0.05)
                                    self.TeamsData[TeamID].creeps_info[UnitName].count = self.TeamsData[TeamID].creeps_info[UnitName].count + 1

                                    local RandomPos = Arena.center + RandomVector(RandomFloat(450, 550))

                                    self:SpawnCreep(UnitName, TeamID, RandomPos, false, nil, self.RoundNum)
                                    break
                                end
                            end
                            i = i + 1
                        end
                    end
                    if self.TeamsData[TeamID].max_in_round > #self.TeamsData[TeamID].creeps_list and Players:IsActiveTeam(TeamID) then
                        return 0.1
                    else
                        return -1
                    end
                end, nil, "ROUND_SPAWNER_"..TeamID, 0.1+(TeamID*0.05))

                GameRules:GetGameModeEntity():SetThink(function()
                    if #ExtraCreepsList > 0 and Players:IsActiveTeam(TeamID) then
                        local Unit = ExtraCreepsList[1]
                        if Rounds:IsThisExtraCreepCanBeLive(Unit.player_id, Unit.round) then
                            local RandomPos = Arena.center + RandomVector(RandomFloat(450, 550))

                            self:SpawnCreep(Unit.name, TeamID, RandomPos, true, Unit.player_id, Unit.round)
                        else
                            self.TeamsData[TeamID].max_in_round = self.TeamsData[TeamID].max_in_round - 1

                            self.TeamsData[TeamID].panorama_info.max_creeps = self.TeamsData[TeamID].max_in_round

                            self.TeamsData[TeamID].panorama_info.extra_creeps = ArrayRemove(self.TeamsData[TeamID].panorama_info.extra_creeps, function(t, i, j)
                                if t[i].name == Unit.name and t[i].player_id == Unit.player_id and t[i].round == Unit.round then
                                    return false
                                end
                                return true
                            end)

                            PlayerTables:SetTableValue("team_"..TeamID, "round_info", self.TeamsData[TeamID].panorama_info)
                        end

                        table.remove(ExtraCreepsList, 1)
                        return 0.2+(TeamID*0.05)
                    end
                end, nil, "ROUND_SPAWNER_EXTRA_"..TeamID, 0.2)
            end

            if Rounds:IsTeamInPVPDuel(TeamID) then
                local Opponent = Rounds:GetPairOpponent(TeamID)
                if Opponent then
                    local OpponentPlayerID = Players:GetTeamPlayerByNum(Opponent, 1)
                    if OpponentPlayerID ~= nil then
                        self.TeamsData[TeamID].panorama_info.duel_opponent = OpponentPlayerID
                    end
                end
            end
        elseif self.RoundInfo.type == ROUND_TYPES.BOSS then
            local BossArena = Map:GetArenaInfo("BOSS_ARENA")
            if BossArena then
                self.TeamsData[TeamID].arena = "BOSS_ARENA"

                self.TeamsData[TeamID].max_in_round = 1

                local SpawnPos = BossArena.center + Vector(-2000, 0, 0) + RandomVector(RandomFloat(250, 600))

                local RandomBoss = RandomInt(1, 2) == 1 and "npc_dota_roshan" or "npc_dota_nian"

                self.TeamsData[TeamID].panorama_info.creeps = {RandomBoss}
                self.TeamsData[TeamID].panorama_info.max_creeps = 1

                self.TeamsData[TeamID].panorama_info.creeps_info = self:GetCreepsInfo({[RandomBoss] = {count = 1}})

                self:SpawnCreep(RandomBoss, TeamID, SpawnPos)
            end
        end

        PlayerTables:SetTableValue("team_"..TeamID, "round_info", self.TeamsData[TeamID].panorama_info)

        self:UpdateGlobalTeamTable(TeamID)

        self.TeamsCount = self.TeamsCount + 1
    end
end

function RoundController:UpdateGlobalTeamTable(TeamID)
    if not self.TeamsData[TeamID] or not self.TeamsData[TeamID].panorama_info then return end

    local Time = self.TeamsData[TeamID].panorama_info.time + self.TeamsData[TeamID].panorama_info.start_delay
    -- if self.TeamsData[TeamID].panorama_info.state == GAME_STATES.ENDED then
    --     Time = 0
    -- end

    -- print(self.TeamsData[TeamID].panorama_info.state)

    local Data = {
        last_time = Time,
        current_state = self.TeamsData[TeamID].panorama_info.state
    }

    CustomNetTables:SetTableValue("globals", "team_"..TeamID.."_round_info", Data)
end

function RoundController:SetTimeToAll(Time)
    for TeamID, TeamInfo in pairs(self.TeamsData) do
        TeamInfo.panorama_info.time = Time

        PlayerTables:SetTableValue("team_"..TeamID, "round_info", self.TeamsData[TeamID].panorama_info)

        self:UpdateGlobalTeamTable(TeamID)
    end
end

function RoundController:PrepareUnit(hUnit)
    if hUnit and not hUnit:IsNull() and hUnit:IsAlive() then
        hUnit:RemoveModifierByName("modifier_creep_spawner_cha_ready")
        
        -- Проверяем, активен ли режим -allstop после снятия модификатора готовности
        if Debugger and Debugger.allStopActive then
            -- Устанавливаем флаг для крипа
            hUnit.allStopActive = true
            
            -- Определяем целевую позицию для крипа
            local targetPos = nil
            local creepTeam = hUnit.Team
            
            -- Если у крипа есть команда, используем центр арены этой команды
            if creepTeam and Debugger.playerArenas[creepTeam] then
                targetPos = Debugger.playerArenas[creepTeam]
            else
                -- Если не можем определить команду крипа, ищем ближайшую арену
                local creepPos = hUnit:GetAbsOrigin()
                local creepArena = Map:GetPositionArena(creepPos)
                
                if creepArena and Debugger.playerArenas[creepArena] then
                    targetPos = Debugger.playerArenas[creepArena]
                else
                    -- Если не можем определить арену, выбираем ближайшую
                    local closestDist = 999999
                    local closestArena = nil
                    
                    for _, centerPos in pairs(Debugger.playerArenas) do
                        local dist = (creepPos - centerPos):Length2D()
                        if dist < closestDist then
                            closestDist = dist
                            closestArena = centerPos
                        end
                    end
                    
                    if closestArena then
                        targetPos = closestArena
                    elseif Debugger.playerArenas["default"] then
                        targetPos = Debugger.playerArenas["default"]
                    end
                end
            end
            
            -- Если нашли целевую позицию, отправляем крипа туда
            if targetPos then
                hUnit.allStopTargetPos = targetPos
                
                -- Отправляем крипа в центр соответствующей арены
                ExecuteOrderFromTable({
                    UnitIndex = hUnit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                    Position = targetPos,
                    Queue = false
                })
            end
        end
        
        if hUnit:GetUnitName() == "npc_dota_nian" then
            local nian_apocalypse = hUnit:FindAbilityByName("nian_apocalypse")
            if nian_apocalypse then
                nian_apocalypse:EndCooldown()
                nian_apocalypse:StartCooldown(RandomInt(5, 10))
            end
            for ability_slot=0, hUnit:GetAbilityCount()-1 do
                local ability = hUnit:GetAbilityByIndex(ability_slot)
                if ability then
                    ability:UseResources(false, false, false, true)
                end
            end
        end
    end
end

function RoundController:BeginTeamArena(TeamID, MaxDuration)
    local TeamInfo = self.TeamsData[TeamID]
    if not TeamInfo then return end

    TeamInfo.begined = true
    TeamInfo.start_time = GameRules:GetGameTime()

    -- [камера] Снап камеры на арену при старте раунда НЕ делаем здесь намеренно.
    -- Его уже выполняет Util:MoveHeroToLocation (вызывается из Players:UpdateArena для каждого
    -- активного игрока при смене арены): камера ставится на героя УЖЕ в центре (после переноса),
    -- держится 0.3с, затем отпускается. Это поведение было до патча 16.06 и работало чисто.
    -- Добавленный в том патче ранний снап здесь дублировал его и вдобавок цеплял камеру за героя
    -- ещё на MAIN → она ехала через угол арены (position-clamp) к центру = дёрганье. Убран.

    if TeamInfo.creeps_list then
        for _, unit in pairs(TeamInfo.creeps_list) do
            if unit and not unit:IsNull() and unit:IsAlive() then
                unit:SetContextThink(DoUniqueString("RoundBeginUnit"), function()
                    self:PrepareUnit(unit)
                end, 0.1*_)
            end
        end
    end

    if TeamInfo.panorama_info then
        TeamInfo.panorama_info.time = GameRules:GetGameTime() + MaxDuration

        TeamInfo.panorama_info.state = GAME_STATES.IN_ACTION

        local TeamArena = TeamInfo.arena
        if Rounds:IsTeamInPVPDuel(TeamID) then
            TeamArena = Rounds.CurrentRoundInfo.duel_arena
        end
        
        if TeamArena ~= nil then
            self.TeamsData[TeamID].panorama_info.current_arena = TeamArena
        end

        PlayerTables:SetTableValue("team_"..TeamID, "round_info", self.TeamsData[TeamID].panorama_info)

        self:UpdateGlobalTeamTable(TeamID)
    end

    -- [#16] Вижн против инвиза с волны 20 (как было). Логика вынесена в SpawnArenaVisionRevealer,
    -- чтобы ТУ ЖЕ модель применить и при берсерке (см. TeamRoundOverTime).
    if self.RoundInfo.type == ROUND_TYPES.BASIC and self.RoundNum >= 20 then
        self:SpawnArenaVisionRevealer(TeamID)
    end
end

-- [#16] Спавнит ревилер арены (arena_vision_revelear + modifier_custom_truesight = truesight
-- против инвиза) для команды. Идемпотентно: один на команду за раунд (RoundController
-- пересоздаётся каждый раунд → флаг свежий; сущность чистится с AdditionalEntities2 в конце
-- раунда). Та же модель, что для вижна с 20й волны.
function RoundController:SpawnArenaVisionRevealer(TeamID)
    local TeamInfo = self.TeamsData[TeamID]
    if not TeamInfo then return end
    if TeamInfo.vision_revealer_spawned then return end
    if TeamInfo.arena == nil or TeamInfo.arena == "" then return end
    if Rounds:IsTeamInPVPDuel(TeamID) then return end
    local ArenaInfo = Map:GetArenaInfo(TeamInfo.arena)
    if not ArenaInfo then return end

    local VisionRevealer = CreateUnitByName(
        "arena_vision_revelear",
        ArenaInfo.center,
        false,
        nil,
        nil,
        DOTA_TEAM_NEUTRALS
    )
    VisionRevealer:AddNewModifier(VisionRevealer, nil, "modifier_custom_truesight", {})
    table.insert(self.AdditionalEntities2, VisionRevealer)
    TeamInfo.vision_revealer_spawned = true
end

function RoundController:BeginRound()
    if Rounds.CurrentRoundInfo.duel_arena ~= nil then
        local ArenaInfo = Map:GetArenaInfo(Rounds.CurrentRoundInfo.duel_arena)
        if ArenaInfo then
            local newItem = CreateItem("item_bag_of_gold", nil, nil)
            if newItem then
                local Drop = CreateItemOnPositionForLaunch(ArenaInfo.center, newItem)
                newItem:LaunchLootInitialHeight(false, 0, 200, 0.25, ArenaInfo.center)

                table.insert(self.AdditionalEntities, newItem)
                table.insert(self.AdditionalEntities, Drop)
            end
        end
    end
end

function RoundController:BeginMinigames()
    GameRules:GetGameModeEntity():SetThink("Think", self, "ROUND_CONTROLLER_THINKER", 0)
    
    self:BeginCircle("MINIGAMES")
end

function RoundController:BeginCircle(Arena)
    self.CircleArena = Arena
    self.CircleArenaCenter = Vector(0,0,0)
    local ArenaInfo = Map:GetArenaInfo(Arena)
    if ArenaInfo then
        self.CircleArenaCenter = ArenaInfo.center
    end

    local Settings = GAME_ROUNDS_CIRCLE_SETTINGS[Arena]

    self.CircleSpeed = (Settings.MAX_SIZE - Settings.MIN_SIZE) / (Settings.END - Settings.START)

    local Delay = Arena == "MINIGAMES" and GAME_ROUNDS_TIMINGS["MINIGAMES_DELAY"] or GAME_ROUNDS_TIMINGS["MASS_ARENA"]
    self.StopCircleTime = GameRules:GetGameTime() + Delay + Settings.END
    self.CircleStopped = false

    self.CurrentRadius = Settings.MAX_SIZE

    GameRules:GetGameModeEntity():SetThink("CircleThink", self, "ROUND_CIRCLE_THINK", Delay + Settings.START)

    GameRules:GetGameModeEntity():SetThink("PreCircle", self, "ROUND_PRE_CIRCLE_THINK", Delay + Settings.PREPARE_VISUAL)
end

function RoundController:BeginMassArena()
    self:BeginCircle("MASS_ARENA")
end

function RoundController:PreCircle()
    local Settings = GAME_ROUNDS_CIRCLE_SETTINGS[self.CircleArena]
    if self.FxPreCircle == nil and Settings then
        self.FxPreCircle = ParticleManager:CreateParticle("particles/minigames_circle/minigames_pre_circle.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(self.FxPreCircle, 0, self.CircleArenaCenter)
        ParticleManager:SetParticleControl(self.FxPreCircle, 1, Vector(Settings.MAX_SIZE, Settings.MAX_SIZE, Settings.MAX_SIZE))
    end
end

function RoundController:CircleThink()
    local Settings = GAME_ROUNDS_CIRCLE_SETTINGS[self.CircleArena]
    if not Settings then return end

    if self.FxCircle == nil then
        self.FxCircle = ParticleManager:CreateParticle("particles/minigames_circle/minigames_circle.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(self.FxCircle, 0, self.CircleArenaCenter)
        ParticleManager:SetParticleControl(self.FxCircle, 1, Vector(Settings.MAX_SIZE, Settings.MIN_SIZE, -self.CircleSpeed))
        ParticleManager:SetParticleControl(self.FxCircle, 2, Vector(0, 250, Settings.MAX_SIZE+768))

        if self.FxPreCircle ~= nil then
            ParticleManager:DestroyParticle(self.FxPreCircle, false)
            self.FxPreCircle = nil
        end

        if self.FxCircleEnd == nil then
            self.FxCircleEnd = ParticleManager:CreateParticle("particles/minigames_circle/minigames_pre_circle.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager:SetParticleControl(self.FxCircleEnd, 0, self.CircleArenaCenter)
            ParticleManager:SetParticleControl(self.FxCircleEnd, 1, Vector(Settings.MIN_SIZE, Settings.MIN_SIZE+75, Settings.MIN_SIZE+200))
        end
    end
    if self.CircleStopped == false and self.StopCircleTime < GameRules:GetGameTime() then
        self.CircleStopped = true

        if self.FxCircleEnd ~= nil then
            ParticleManager:DestroyParticle(self.FxCircleEnd, false)
            self.FxCircleEnd = nil
        end

        if self.FxCircle ~= nil then
            ParticleManager:SetParticleControl(self.FxCircle, 2, Vector(1, 0, 0))
        end
    end

    if self.CurrentRadius > Settings.MIN_SIZE then
        self.CurrentRadius = self.CurrentRadius - (self.CircleSpeed * 0.033)
    end

    local Units = FindUnitsInRadius(
        DOTA_TEAM_GOODGUYS, 
        self.CircleArenaCenter, 
        nil, 
        3000, 
        DOTA_UNIT_TARGET_TEAM_BOTH, 
        DOTA_UNIT_TARGET_HEROES_AND_CREEPS, 
        DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 
        FIND_ANY_ORDER, 
        false
    )

    for _, unit in ipairs(Units) do
        local Arena = Players:GetUnitArena(unit)
        if Arena == self.CircleArena then
            if CalculateDistance(self.CircleArenaCenter, unit) > self.CurrentRadius-50 then
                unit:AddNewModifier(unit, nil, Settings.MODIFIER, {duration=1})
            else
                unit:RemoveModifierByName(Settings.MODIFIER)
            end
        end
    end

    return 0.033
end

function RoundController:Think()
    local Runes = {
        "item_custom_rune_haste",
        "item_custom_rune_double_damage",
        "item_custom_rune_illusion",
        "item_custom_rune_invisibility",
        "item_custom_rune_regeneration",
        "item_custom_rune_arcane",
        "item_custom_rune_shield",
    }

    local ArenaInfo = Map:GetArenaInfo("MINIGAMES")
    if ArenaInfo then
        if self.LastRune and not self.LastRune:IsNull() then
            table.remove_item(self.AdditionalEntities, self.LastRune)
            UTIL_Remove(self.LastRune)
            self.LastRune = nil
        end
        if self.LastRuneItem and not self.LastRuneItem:IsNull() then
            table.remove_item(self.AdditionalEntities, self.LastRuneItem)
            UTIL_Remove(self.LastRuneItem)
            self.LastRuneItem = nil
        end
        local RuneItem = CreateItem(table.random(Runes), nil, nil)
        self.LastRuneItem = RuneItem
        table.insert(self.AdditionalEntities, RuneItem)
        if RuneItem then
            local RunePhysical = CreateItemOnPositionSync(ArenaInfo.center, RuneItem)
            if RunePhysical then
                for _, TeamID in ipairs(Players:GetAllActivatedTeams(true)) do
                    GameRules:ExecuteTeamPing(TeamID, ArenaInfo.center.x, ArenaInfo.center.y, RunePhysical, 0)
                end
                local fx = ParticleManager:CreateParticle("particles/ping_custom.vpcf", PATTACH_WORLDORIGIN, nil)
                ParticleManager:SetParticleControl(fx, 0, ArenaInfo.center)
                ParticleManager:SetParticleControl(fx, 3, Vector(0, 0, 0))
                ParticleManager:SetParticleControl(fx, 5, Vector(0, 0, 0))
                ParticleManager:SetParticleControl(fx, 7, Vector(1, 1, 1))
                ParticleManager:ReleaseParticleIndex(fx)

                self.LastRune = RunePhysical
                table.insert(self.AdditionalEntities, RunePhysical)
            end
        end
    end
    return 10
end

function RoundController:KillAllExtraCreeepsByPlayerID(PlayerID)
    for TeamID, TeamInfo in pairs(self.TeamsData) do
        local TeamPlayerID, PlayerInfo = Players:GetTeamPlayerByNum(TeamID, 1)
        if TeamPlayerID ~= nil and PlayerInfo ~= nil and TeamInfo.extra_creeps_info then
            local Hero = PlayerInfo.hero
            if Players:IsValidHero(Hero) then
                for _, ExtraCreatureInfo in ipairs(TeamInfo.extra_creeps_info) do
                    if not Rounds:IsThisExtraCreepCanBeLive(ExtraCreatureInfo.player_id, ExtraCreatureInfo.round) and ExtraCreatureInfo.unit and not ExtraCreatureInfo.unit:IsNull() and ExtraCreatureInfo.unit:IsAlive() then
                        ExtraCreatureInfo.unit:Kill(nil, Hero)
                    end
                end
            end
        end
    end
end

function RoundController:TeamRoundOverTime(TeamID, bRoundTimeOver)
    local TimeOvered = false
    if self.TeamsData[TeamID] then
        if bRoundTimeOver then
            if self.TeamsData[TeamID].time_over  == false then
                self.TeamsData[TeamID].time_over = true

                TimeOvered = true
            end

            -- [#16] При берсерке сразу даём арене truesight (та же модель, что вижн с 20й волны).
            -- Идемпотентно: если ревилер уже заспавнен на раунде >=20 — повторно не создастся.
            -- Чинит зависание перманентно-инвиз героя, которого крипы не видят и ждут смерти от проклятия.
            self:SpawnArenaVisionRevealer(TeamID)

            if self.TeamsData[TeamID].creeps_list then
                for _, unit in pairs(self.TeamsData[TeamID].creeps_list) do
                    if unit and not unit:IsNull() and unit:IsAlive() then
                        local modif = unit:FindModifierByName("modifier_creep_controll")
                        if modif and not modif:IsBerserked() then
                            modif:OnRoundOverTime(self.RoundNum >= 70)
                        end
                    end
                end
            end
        end
    end

    for PlayerID, PlayerInfo in pairs(Players:GetTeamActivePlayers(TeamID)) do
        if not Rounds:IsPlayerInPVPDuel(PlayerID) and not Rounds:IsFinishedTeam(PlayerInfo.team) and TimeOvered then
            EmitSoundOnClient("Berserk.Start", PlayerResource:GetPlayer(PlayerID))
            EmitSoundOnClient("Berserk.Start2", PlayerResource:GetPlayer(PlayerID))
        end
        if Rounds:IsPlayerInPVPDuel(PlayerID) and not Rounds:IsFinishedTeam(PlayerInfo.team) and not Rounds:IsPvpPairEnded() then
            local Hero = PlayerInfo.hero
            if Players:IsValidHero(Hero) and Hero:IsAlive() then
                local Summons = self:FindAllOwnedUnits(PlayerID)

                Hero:AddNewModifier(Hero, nil, "modifier_duel_curse_cooldown", {})
                for _, summon in pairs(Summons) do
                    summon:AddNewModifier(Hero, nil, "modifier_duel_curse_cooldown", {})
                end

                if bRoundTimeOver then
                    Hero:AddNewModifier(Hero, nil, "modifier_duel_curse", {})
                    for _, summon in pairs(Summons) do
                        summon:AddNewModifier(Hero, nil, "modifier_duel_curse", {})
                    end
                end
            end
        end
    end
end

function RoundController:GetCreepsInfo(RoundCreeps, ExtraCreeps)
    local Creeps = {}

    local GetUnitInfo = function(UnitName, Count, RoundNum)
        local data = {
            count = Count,
            mana = 0,
            mana_regen = 0,
            health = 0,
            health_regen = 0,
            damage_min = 0,
            damage_max = 0,
            attack_range = 0,
            attack_speed = 0,
            physical_resist = 0,
            magical_resist = 0,
            resist = 0,
            abilities = {},
        }

        local KV = GetUnitKeyValuesByName(UnitName)
        if KV then
            data.mana = KV.StatusMana or 0
            data.mana_regen = KV.StatusManaRegen or 0

            local BaseHealth = KV.StatusHealth or 0
            local MaxHealth, CurrentHealth = self:CalculateHealth(BaseHealth, RoundNum)

            data.health = MaxHealth
            data.health_regen = KV.StatusHealthRegen or 0
            data.damage_min = self:CalculateDamage((KV.AttackDamageMin or 0), RoundNum, BaseHealth)
            data.damage_max = self:CalculateDamage((KV.AttackDamageMax or 0), RoundNum, BaseHealth)
            data.attack_range = KV.AttackRange or 0

            local Armor = (KV.ArmorPhysical or 0) + (GetGameSetting("CREEP_BONUS_ARMOR_PER_LATE_ROUND") * math.max(0, RoundNum-50))

            data.physical_resist = math.round((0.06 * Armor) / (1 + 0.06 * math.abs(Armor)) * 100)

            local baseResist = (KV.MagicalResistance or 0) * 0.01
            local roundBonus = (GetGameSetting("CREEP_BONUS_MAGIC_RESISTANCE_PER_LATE_ROUND") * math.max(0, RoundNum - 50)) * 0.01
            local totalResist = 1 - (1 - baseResist) * (1 - roundBonus)

            data.magical_resist = math.round(totalResist*100)

            data.attack_speed = (KV.AttackRate or 0)/math.pow(1.062, RoundNum)

            data.resist = self:CalculateDamageReduction(CurrentHealth, RoundNum)
            
            for Key, value in pairs(KV) do
                if string.match(Key, "Ability") and value ~= "" and value ~= "generic_hidden" then
                    local AbilityKV = GetAbilityKeyValuesByName(value)
                    if AbilityKV and string.match(AbilityKV.AbilityBehavior, "DOTA_ABILITY_BEHAVIOR_HIDDEN") == nil then
                        table.insert(data.abilities, value)
                    end
                end
            end
        end

        return data
    end

    if RoundCreeps ~= nil then
        for CreepName, Info in pairs(RoundCreeps) do
            Creeps[CreepName] = GetUnitInfo(CreepName, Info.count, self.RoundNum)
        end
    end

    if ExtraCreeps ~= nil then
        local ExtraCreepsCount = {}

        for _, Info in pairs(ExtraCreeps) do
            if ExtraCreepsCount[Info.name] == nil then
                ExtraCreepsCount[Info.name] = 1
            else
                ExtraCreepsCount[Info.name] = ExtraCreepsCount[Info.name] + 1
            end
        end

        for _, Info in pairs(ExtraCreeps) do
            if Creeps[Info.name] == nil then
                Creeps[Info.name] = GetUnitInfo(Info.name, ExtraCreepsCount[Info.name], self.RoundNum)
            end
        end
    end

    return Creeps
end

-- =========================================================
-- ФОРМУЛА ЗДОРОВЬЯ КРИПОВ (единая: BaseHP * рост^волну, кап MAX_CREEP_HEALTH)
-- =========================================================

function RoundController:CalculateHealth(BaseHealth, RoundNum)
    -- Единая формула: HP = BaseHP * CREEP_HP_GROWTH_PER_ROUND ^ (номер волны).
    -- Возвращаем (капнутое, некапнутое) — некапнутое нужно для заморозки урона.
    local uncapped = math.floor(BaseHealth * math.pow(CREEP_HP_GROWTH_PER_ROUND, RoundNum))
    return math.min(uncapped, MAX_CREEP_HEALTH), uncapped
end

-- =========================================================
-- ФОРМУЛА УРОНА КРИПОВ
-- =========================================================

-- Если HP крипа упёрся в MAX_CREEP_HEALTH, его урон не должен расти дальше —
-- иначе способности с отражением/иллюзии при кепнутом HP получают
-- непропорциональный урон. Возвращает раунд, на котором HP крипа с этой
-- BaseHealth впервые достиг бы MAX_CREEP_HEALTH (или RoundNum, если не достиг).
function RoundController:GetEffectiveDamageRound(BaseHealth, RoundNum)
    if not BaseHealth or BaseHealth <= 0 then return RoundNum end

    local _, uncappedHealth = self:CalculateHealth(BaseHealth, RoundNum)
    if uncappedHealth < MAX_CREEP_HEALTH then return RoundNum end

    -- Бинарный поиск раунда, где HP впервые достигает кепа
    local lo, hi = 1, RoundNum
    while lo < hi do
        local mid = math.floor((lo + hi) / 2)
        local _, hpAtMid = self:CalculateHealth(BaseHealth, mid)
        if hpAtMid >= MAX_CREEP_HEALTH then
            hi = mid
        else
            lo = mid + 1
        end
    end
    return lo
end

function RoundController:CalculateDamage(BaseDamage, RoundNum, BaseHealth)
    -- Единая формула: урон = BaseDamage * CREEP_DAMAGE_GROWTH_PER_ROUND ^ (волну),
    -- при этом рост замораживается на волне, где HP крипа упёрся в кеп.
    local effectiveRound = self:GetEffectiveDamageRound(BaseHealth, RoundNum)
    local dmg = math.floor(BaseDamage * math.pow(CREEP_DAMAGE_GROWTH_PER_ROUND, effectiveRound))
    return math.min(dmg, MAX_CREEP_DAMAGE)
end

-- =========================================================
-- =========================================================

function RoundController:CalculateDamageReduction(Health, RoundNum)
    if GAME_DAMAGE_REDUCTION_ENABLED == false then return 0 end
    
    local ReductionFromOverHealth = math.min(MAX_CREEP_HEALTH / Health, 1)

    return math.round((1 - (ReductionFromOverHealth/(1 + ((CREEP_DAMAGE_REDUCTION_PER_LATE_ROUND * 0.01) * math.max(0, RoundNum-50))))) * 100)
end

function RoundController:FindAllOwnedUnits(player)
    local summons = {}
    local pid = type(player) == "number" and player or player:GetPlayerID()
    local hero = PlayerResource:GetSelectedHeroEntity(pid)
    local units = FindUnitsInRadius(PlayerResource:GetTeam(pid), Vector(0, 0, 0), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED, FIND_ANY_ORDER, false)
    for _, v in ipairs(units) do
        if type(player) == "number" and ((v.GetPlayerID ~= nil and v:GetPlayerID() or v:GetPlayerOwnerID()) == pid) or v:GetPlayerOwner() == player then
            if not v:HasModifier("modifier_dummy_unit") and v ~= hero then
                table.insert(summons, v)
            end
        end
    end
    return summons
end


function RoundController:OnEntityKilled(event)
    local hKilledUnit = EntIndexToHScript( event.entindex_killed )
    if hKilledUnit == nil or hKilledUnit:IsNull() then return end

    -- Базовая логика обычных раундов (деф крипов, массовое убийство боссов)
    if self.RoundInfo.type == ROUND_TYPES.BASIC or self.RoundInfo.type == ROUND_TYPES.BOSS then
        if hKilledUnit and not hKilledUnit:IsHero() then
            local bIsRoundSpawned = false
            local bIsLastCreep = false

            local TeamID = hKilledUnit.Team

            if TeamID ~= nil then
                local CreepsInfo = self.TeamsData[TeamID]
                if CreepsInfo and CreepsInfo.creeps_list and table.contains(CreepsInfo.creeps_list, hKilledUnit) then
                    bIsRoundSpawned = true

                    self.TeamsData[TeamID].killed_in_round = self.TeamsData[TeamID].killed_in_round + 1
                    table.remove_item(self.TeamsData[TeamID].creeps_list, hKilledUnit)

                    self.TeamsData[TeamID].panorama_info.killed_creeps = self.TeamsData[TeamID].killed_in_round

                    PlayerTables:SetTableValue("team_"..TeamID, "round_info", self.TeamsData[TeamID].panorama_info)

                    if self.TeamsData[TeamID].killed_in_round == self.TeamsData[TeamID].max_in_round then
                        bIsLastCreep = true
                        self:TeamFinished(TeamID)
                    end
                end
            end

            -- После TeamFinished для последнего крипа entity уже уничтожен через EndRound → ClearSpawnGroups → UTIL_Remove
            -- Нельзя вызывать нативные методы на невалидном entity — это вызывает native crash
            if bIsLastCreep then return end
            if hKilledUnit:IsNull() then return end

            Creeps:DeleteUnitAsync(hKilledUnit, bIsRoundSpawned)
        end
        if hKilledUnit and IsRealHero(hKilledUnit) then
            local PlayerID = hKilledUnit:GetPlayerID()
            local TeamID = Players:GetPlayerTeamNumber(PlayerID)
            if TeamID ~= nil and Players:IsActiveTeam(TeamID) and self.TeamsData[TeamID] ~= nil then

                local iKiller = event.entindex_attacker
                if iKiller ~= nil then
                    local hKiller = EntIndexToHScript(iKiller)
                    if hKiller then
                        local RealKiller = GetRealUnit(hKiller)
                        if RealKiller and RealKiller:IsRealHero() and Rounds:IsPlayerInPVPDuel(PlayerID) and Rounds:IsPlayerInPVPDuel(RealKiller:GetPlayerID()) then
                            if PlayerID == RealKiller:GetPlayerID() then
                                Notifications:AddNotification(NOTIFICATION_TYPE.DUEL_KILL_SELF, self.RoundNum, {
                                    player1 = RealKiller:GetPlayerID(),
                                })
                            else
                                Notifications:AddNotification(NOTIFICATION_TYPE.DUEL_KILL, self.RoundNum, {
                                    player1 = RealKiller:GetPlayerID(),
                                    player2 = PlayerID,
                                })
                            end
                        elseif RealKiller and RealKiller:IsRealHero() then
                            Notifications:AddNotification(NOTIFICATION_TYPE.KILL, self.RoundNum, {
                                player1 = RealKiller:GetPlayerID(),
                                player2 = PlayerID,
                            })
                        else
                            Notifications:AddNotification(NOTIFICATION_TYPE.CREEP_KILL, self.RoundNum, {
                                creep1 = hKiller:GetUnitName(),
                                player1 = PlayerID,
                            })
                        end
                    end
                end

                local AllTeamAFK = true
                local sAfkLog = ""
                for TeamPlayerID, TeamPlayerInfo in pairs(Players:GetTeamActivePlayers(TeamID)) do
                    local Hero = TeamPlayerInfo.hero
                    local bValid = Players:IsValidHero(Hero)
                    local bAlive = bValid and Hero:IsAlive() or false
                    local bReinc = bValid and (not bAlive) and Hero:IsReincarnating() or false
                    if ROUND_DEBUG_ENABLED then
                        local hbInfo = HeroBuilder and HeroBuilder.Players and HeroBuilder.Players[TeamPlayerID]
                        local nLifes = hbInfo and hbInfo.lifes_count or 0
                        sAfkLog = sAfkLog .. string.format(" PID=%d{valid=%s alive=%s reinc=%s lifes=%d}", TeamPlayerID, tostring(bValid), tostring(bAlive), tostring(bReinc), nLifes)
                    end

                    if bValid and (bAlive or bReinc) then
                        AllTeamAFK = false
                    elseif not Rounds:IsPlayerInPVPDuel(TeamPlayerID) then

                        GameRules:GetGameModeEntity():StopThink("ROUND_LOSE_DELAY_PLAYERID_"..PlayerID)

                        GameRules:GetGameModeEntity():SetThink(function()
                            if Players:IsActivePlayer(TeamPlayerID) then
                                Players:UpdatePlayerState(TeamPlayerID, PLAYER_STATE.LOSER)
                            end
                        end, nil, "ROUND_LOSE_DELAY_PLAYERID_"..PlayerID, GAME_PLAYER_LOSE_DELAY)
                    end
                end

                if ROUND_DEBUG_ENABLED then
                    print(string.format("[ROUND_DEBUG] AFK_CHECK: TeamID=%d killedPID=%d round=%d AllTeamAFK=%s players={%s}",
                        TeamID, PlayerID, self.RoundNum, tostring(AllTeamAFK), sAfkLog))
                end

                if AllTeamAFK then
                    if Rounds:IsTeamInPVPDuel(TeamID) then
                        if not Rounds:IsPvpPairEnded() then
                            Rounds:EndPVPPair(TeamID)
                        end
                    else
                        GameRules:GetGameModeEntity():StopThink("ROUND_LOSE_DELAY_TEAMID_"..TeamID)

                        GameRules:GetGameModeEntity():SetThink(function()
                            if Players:IsActiveTeam(TeamID) then
                                Players:MakeTeamLose(TeamID)
                            end
                        end, nil, "ROUND_LOSE_DELAY_TEAMID_"..TeamID, GAME_PLAYER_LOSE_DELAY)
                    end
                end

                -- AEGIS-FALLBACK SAFETY-NET (исправление регрессии после disc-патча):
                -- Штатный AllTeamAFK-flow выше иногда не отрабатывает -- скорее всего
                -- `Hero:IsReincarnating()` race-condition'ит и возвращает true даже когда
                -- modifier_aegis уже не вернёт ReincarnateTime (стек=0). Симптом: команда
                -- висит на берсерке до 120-сек ForceKillStuckTeam.
                --
                -- Защита: если у убитого PID lifes_count=0 -- через AEGIS_REINCARNATE_DELAY+5с
                -- (после которого реальный engine reincarnate уже точно случился бы) проверяем
                -- ВСЕХ active-игроков команды по жёсткому критерию: hero NOT IsAlive (без проверки
                -- IsReincarnating, чтобы обойти баг). Если все мертвы и команда ещё активна --
                -- форсим MakeTeamLose. Не трогает PVP-дуэли, мини-игры и команды с живыми героями.
                if not Rounds:IsTeamInPVPDuel(TeamID) then
                    local hbKilled = HeroBuilder and HeroBuilder.Players and HeroBuilder.Players[PlayerID]
                    local nLifesKilled = hbKilled and hbKilled.lifes_count or 0
                    if nLifesKilled <= 0 then
                        local sFallbackThink = "ROUND_LOSE_FALLBACK_TEAMID_"..TeamID
                        GameRules:GetGameModeEntity():StopThink(sFallbackThink)

                        local fFallbackDelay = (AEGIS_REINCARNATE_DELAY or 5) + 5
                        if ROUND_DEBUG_ENABLED then
                            print(string.format("[ROUND_DEBUG] AEGIS_FALLBACK_SCHEDULED: TeamID=%d killedPID=%d lifes=0 delay=%.1fs",
                                TeamID, PlayerID, fFallbackDelay))
                        end

                        GameRules:GetGameModeEntity():SetThink(function()
                            -- Перепроверяем условие: команда ещё активна, не в дуэли, и все
                            -- активные игроки команды реально мертвы (только IsAlive, без
                            -- IsReincarnating чтобы обойти возможный баг race-condition).
                            if not Players:IsActiveTeam(TeamID) then
                                if ROUND_DEBUG_ENABLED then print("[ROUND_DEBUG] AEGIS_FALLBACK_SKIP: TeamID="..tostring(TeamID).." team уже не активна (видимо штатный flow отработал)") end
                                return
                            end
                            if Rounds:IsTeamInPVPDuel(TeamID) then
                                if ROUND_DEBUG_ENABLED then print("[ROUND_DEBUG] AEGIS_FALLBACK_SKIP: TeamID="..tostring(TeamID).." команда в PVP дуэли") end
                                return
                            end

                            local bAnyAlive = false
                            local sCheckLog = ""
                            for FbPlayerID, FbPlayerInfo in pairs(Players:GetTeamActivePlayers(TeamID)) do
                                local FbHero = FbPlayerInfo.hero
                                local bFbValid = Players:IsValidHero(FbHero)
                                local bFbAlive = bFbValid and FbHero:IsAlive() or false
                                if ROUND_DEBUG_ENABLED then
                                    local hbFb = HeroBuilder and HeroBuilder.Players and HeroBuilder.Players[FbPlayerID]
                                    local nFbLifes = hbFb and hbFb.lifes_count or 0
                                    sCheckLog = sCheckLog .. string.format(" PID=%d{valid=%s alive=%s lifes=%d}", FbPlayerID, tostring(bFbValid), tostring(bFbAlive), nFbLifes)
                                end
                                if bFbValid and bFbAlive then
                                    bAnyAlive = true
                                    break
                                end
                            end

                            if ROUND_DEBUG_ENABLED then
                                print(string.format("[ROUND_DEBUG] AEGIS_FALLBACK_CHECK: TeamID=%d anyAlive=%s players={%s}",
                                    TeamID, tostring(bAnyAlive), sCheckLog))
                            end

                            if not bAnyAlive then
                                if ROUND_DEBUG_ENABLED then
                                    print(string.format("[ROUND_DEBUG] AEGIS_FALLBACK_FIRE: TeamID=%d -- форсирую MakeTeamLose (штатный AFK-flow не сработал)", TeamID))
                                end
                                Players:MakeTeamLose(TeamID)
                            end
                        end, nil, sFallbackThink, fFallbackDelay)
                    end
                end
            end
        end
    end

    -- Логика раундов с мини-играми или масс ареной
    if self.RoundInfo.type == ROUND_TYPES.VOTING then
        if hKilledUnit and IsRealHero(hKilledUnit) then
            local PlayerID = hKilledUnit:GetPlayerID()
            local TeamID = Players:GetPlayerTeamNumber(PlayerID)
            if TeamID ~= nil and Players:IsActiveTeam(TeamID) then
                local AllTeamAFK = true
                for TeamPlayerID, TeamPlayerInfo in pairs(Players:GetTeamActivePlayers(TeamID)) do
                    local Hero = TeamPlayerInfo.hero
                    if Players:IsValidHero(Hero) and (Hero:IsAlive() or (not Hero:IsAlive() and Hero:IsReincarnating())) then
                        AllTeamAFK = false
                    end
                end

                if AllTeamAFK then
                    self:EndControllerForTeam(TeamID)
                end
            end
        elseif hKilledUnit and not hKilledUnit:IsIllusion() and Players:IsSecondaryUnit(hKilledUnit) then
            -- Убиваем иллюзии погибшего юнита
            local allUnits = FindUnitsInRadius(hKilledUnit:GetTeamNumber(), hKilledUnit:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
            for _, unit in ipairs(allUnits) do
                if unit:IsIllusion() and unit:GetOwner() == hKilledUnit:GetOwner() then
                    unit:ForceKill(false)
                end
            end

            local RealHero = GetRealUnit(hKilledUnit)
            if RealHero and IsRealHero(RealHero) then
                local PlayerID = RealHero:GetPlayerID()
                local TeamID = Players:GetPlayerTeamNumber(PlayerID)
                if TeamID ~= nil and Players:IsActiveTeam(TeamID) then
                    local AllTeamAFK = true
                    for TeamPlayerID, TeamPlayerInfo in pairs(Players:GetTeamActivePlayers(TeamID)) do
                        local Unit = TeamPlayerInfo.secondary_unit
                        if Players:IsValidHero(Unit) and (Unit:IsAlive() or (not Unit:IsAlive() and Unit:IsReincarnating())) then
                            AllTeamAFK = false
                        else
                            Players:UpdatePlayerHero(TeamPlayerID, "VISUAL_KILL")
                        end
                    end

                    if AllTeamAFK then
                        self:EndControllerForTeam(TeamID)
                    end
                end
            end
        end
    end
end

function RoundController:SpawnCreep(UnitName, TeamID, Position, bIsExtra, PlayerID, Round)
    Creeps:SpawnUnitByName(UnitName, Position, true, nil, nil, DOTA_TEAM_NEUTRALS, function()
        if Rounds:GetCurrentControllerInstance() ~= self.instanceID then
            return true
        end

        if self.TeamsData[TeamID] == nil then
            return true
        end

        if bIsExtra and not Rounds:IsThisExtraCreepCanBeLive(PlayerID, Round) then
            return true
        end

        return false
    end, function(hUnit)    
        hUnit.Arena = self.TeamsData[TeamID].arena
        hUnit.Team = TeamID
        hUnit._is_round_spawned = true

        -- Проверяем, активна ли команда -allstop
        if Debugger and Debugger.allStopActive then
            hUnit.allStopActive = true
            
            -- Определяем целевую позицию для крипа
            local arenaInfo = Map:GetArenaInfo(self.TeamsData[TeamID].arena)
            if arenaInfo and arenaInfo.center then
                hUnit.allStopTargetPos = arenaInfo.center
            end
        end

        if self.TeamsData[TeamID].begined == false then
            hUnit:AddNewModifier(hUnit, nil, "modifier_creep_spawner_cha_ready", {})
        else
            self:PrepareUnit(hUnit)
        end

        local FullMove = nil
        if self.RoundNum >= 60 then
            FullMove = 1
        end

        local BaseHealth = hUnit:GetMaxHealth()
        local MaxHealth, CurrentHealth = self:CalculateHealth(BaseHealth, self.RoundNum)
        local Resist = self:CalculateDamageReduction(CurrentHealth, self.RoundNum)

        hUnit:SetBaseMaxHealth(MaxHealth)
        hUnit:SetMaxHealth(MaxHealth)
        hUnit:SetHealth(MaxHealth)

        hUnit:SetPhysicalArmorBaseValue(hUnit:GetPhysicalArmorBaseValue() + (GetGameSetting("CREEP_BONUS_ARMOR_PER_LATE_ROUND") * math.max(0, self.RoundNum-50)))

        hUnit:SetAcquisitionRange(0)
        hUnit:SetIdleAcquire(false)

        local flGoldBountyMultiple = 0.9
        local bonus_gold = 0
        if self.RoundNum >= 10 then
            bonus_gold = 50
        end

        hUnit:SetMinimumGoldBounty(math.floor(hUnit:GetMinimumGoldBounty() * flGoldBountyMultiple ) + bonus_gold)
        hUnit:SetMaximumGoldBounty(math.floor(hUnit:GetMaximumGoldBounty() * flGoldBountyMultiple ) + bonus_gold)

        local flDamageMin = self:CalculateDamage(hUnit:GetBaseDamageMin(), self.RoundNum, BaseHealth)
        hUnit:SetBaseDamageMin(flDamageMin)

        local flDamageMax = self:CalculateDamage(hUnit:GetBaseDamageMax(), self.RoundNum, BaseHealth)
        hUnit:SetBaseDamageMax(flDamageMax)

        hUnit:SetDeathXP(math.floor((GameRules.xpTable[self.RoundNum + 1] - GameRules.xpTable[self.RoundNum]) / self.TeamsData[TeamID].max_in_round))

        local flSpeedMultiple = math.pow(1.062, self.RoundNum) -- 1.058
        hUnit:SetBaseAttackTime(GetUnitBaseAttackTime(hUnit)/flSpeedMultiple)

        hUnit:AddNewModifier(hUnit, nil, "modifier_creep_controll", {
            upgrader_stacks = math.max(self.RoundNum-50, 0),
            spell_amplify_stacks = math.max(self.RoundNum-1, 0),
            resist_stacks = Resist,
            full_move = FullMove,
            spawn_round = self.RoundNum,
            team_id = TeamID,
        })

        if bIsExtra then
            hUnit:AddNewModifier(hUnit, nil, "modifier_skill_call_of_the_ancient_buff", {})

            table.insert(self.TeamsData[TeamID].extra_creeps_info, {
                unit = hUnit,
                player_id = PlayerID,
                round = Round
            })
        end

        if UnitName == "npc_dota_roshan" or UnitName == "npc_dota_nian" then
            hUnit:AddNewModifier(hUnit, nil, "modifier_skill_call_of_the_ancient_buff", {})
        end
        
        table.insert(self.TeamsData[TeamID].creeps_list, hUnit)
    end)
end

function RoundController:GiveRoundReward(TeamID, Place)
    -- Доля за место: 1-е место (быстрее всех зачистило) — 100%, каждое следующее
    -- место минус 12%. При 8 командах: 100/88/76/64/52/40/28/16%. Ниже 0 не уходит.
    local TopShare = 1.00
    local StepShare = 0.12
    local Share = math.max(TopShare - (Place - 1) * StepShare, 0)

    local BonusGold = 200

    local MultNum = self.RoundNum
    if MultNum > 90 then
        MultNum = 90
    end

    BonusGold = BonusGold * math.pow(1.03, MultNum)

    Gold = math.ceil(math.max(BonusGold * Share, 0))

    for PlayerID, PlayerInfo in pairs(Players:GetTeamActivePlayers(TeamID)) do
        local hHero = PlayerInfo.hero 
        if Players:IsValidHero(hHero) then
            local vBulletData = {}
            vBulletData.type = "round_finish"
            vBulletData.gold_value = tostring(Gold)
            vBulletData.playerId = PlayerID
            Barrage:FireBullet(vBulletData)

            local ResultGold = Players:ModifyPlayerGold(PlayerID, Gold, true, true, true)

            Notifications:AddNotification(NOTIFICATION_TYPE.ROUND_ENDED, self.RoundNum, {
                player1 = PlayerID,
                gold1 = ResultGold,
                time1 = Rounds:GetTeamDefDurationByRound(TeamID, self.RoundNum)
            })
        end
    end
end

function RoundController:TeamFinished(TeamID)
    if self.TeamsData[TeamID] ~= nil then
        local DefDuration = GameRules:GetGameTime() - self.TeamsData[TeamID].start_time
        Rounds:TeamFinishedQueue(TeamID, DefDuration)
    end

    if not Rounds:IsQueueRound(self.RoundNum) then
        self.TeamRankInRound = self.TeamRankInRound + 1

        self:GiveRoundReward(TeamID, self.TeamRankInRound)
    end

    for PlayerID, PlayerInfo in pairs(Players:GetTeamActivePlayers(TeamID)) do
        local hHero = PlayerInfo.hero
        if Players:IsValidHero(hHero) then
            if not hHero:IsAlive() then
                hHero:RespawnHero(false, false)
            end

            Timers:CreateTimer({ endTime = 0.5, callback = function()
                Players:UpdateArena(PlayerID, "MAIN", nil)
            end})
        end
    end

    -- [NP-23] Наблюдение за дуэлью после дефа крипов (по настройке игрока): не-дуэлянтам,
    -- закончившим деф, ставим камеру в ТОЧКУ МЕЖДУ двумя дуэлянтами (через невидимый dummy,
    -- т.к. SetCameraTarget следит за юнитом, не за точкой). Задержка 0.7с — чтобы не перебилось
    -- перемещением на MAIN-арену выше (0.5с).
    local _dPair = Rounds.PVPPairsHistory and Rounds.PVPPairsHistory.currentPair
    local _hasDuel = Rounds.CurrentRoundInfo and Rounds.CurrentRoundInfo.info and Rounds.CurrentRoundInfo.info.has_duel
    if _hasDuel and _dPair and TeamID ~= _dPair.fTeam and TeamID ~= _dPair.sTeam then
        local fHero, sHero = nil, nil
        for _, dInfo in pairs(Players:GetTeamActivePlayers(_dPair.fTeam)) do
            if Players:IsValidHero(dInfo.hero) then fHero = dInfo.hero break end
        end
        for _, dInfo in pairs(Players:GetTeamActivePlayers(_dPair.sTeam)) do
            if Players:IsValidHero(dInfo.hero) then sHero = dInfo.hero break end
        end
        if fHero or sHero then
            local _watchers = {}
            for hWatchPID, _ in pairs(Players:GetTeamActivePlayers(TeamID)) do
                if Server:GetPlayerSettingValue(hWatchPID, "watch_duel_after_round") == 1 then
                    table.insert(_watchers, hWatchPID)
                end
            end
            if #_watchers > 0 then
                Timers:CreateTimer(0.7, function()
                    -- Камеру переводим ТОЛЬКО если дуэлянты уже на арене дуэли, а НЕ на стартовой
                    -- локации (MAIN). Дуэлянта, ещё стоящего на старте, не берём; если оба на старте —
                    -- камеру не трогаем вовсе (фикс: при дефе последним камера кидалась на дуэлянтов,
                    -- которые ещё на стартовой локации).
                    local f = (fHero and not fHero:IsNull() and Map:GetPositionArena(fHero) ~= "MAIN") and fHero or nil
                    local sd = (sHero and not sHero:IsNull() and Map:GetPositionArena(sHero) ~= "MAIN") and sHero or nil
                    if not f and not sd then return end
                    local camPos
                    if f and sd then
                        camPos = (f:GetAbsOrigin() + sd:GetAbsOrigin()) * 0.5   -- середина между дуэлянтами
                    elseif f then
                        camPos = f:GetAbsOrigin()
                    else
                        camPos = sd:GetAbsOrigin()
                    end
                    local camDummy = CreateUnitByName("npc_dummy", camPos, false, nil, nil, DOTA_TEAM_NOTEAM)
                    if not camDummy then return end
                    for _, wPID in ipairs(_watchers) do
                        PlayerResource:SetCameraTarget(wPID, camDummy)
                    end
                    Timers:CreateTimer(0.3, function()
                        for _, wPID in ipairs(_watchers) do
                            PlayerResource:SetCameraTarget(wPID, nil)
                        end
                        if camDummy and not camDummy:IsNull() then UTIL_Remove(camDummy) end
                    end)
                end)
            end
        end
    end

    self:EndControllerForTeam(TeamID)
end

function RoundController:EndController()
    StopListeningToGameEvent(self.nEntityKilledEvent)

    GameRules:GetGameModeEntity():StopThink("ROUND_CONTROLLER_THINKER")
    GameRules:GetGameModeEntity():StopThink("ROUND_PRE_CIRCLE_THINK")
    GameRules:GetGameModeEntity():StopThink("ROUND_CIRCLE_THINK")

    if self.FxCircle ~= nil then
        ParticleManager:DestroyParticle(self.FxCircle, true)
        self.FxCircle = nil
    end

    if self.FxPreCircle ~= nil then
        ParticleManager:DestroyParticle(self.FxPreCircle, true)
        self.FxPreCircle = nil
    end

    if self.FxCircleEnd ~= nil then
        ParticleManager:DestroyParticle(self.FxCircleEnd, true)
        self.FxCircleEnd = nil
    end

    for _, TeamID in ipairs(Players:GetAllTeams(true)) do
        self:EndControllerForTeam(TeamID, true)
    end

    for _, Entity in ipairs(self.AdditionalEntities) do
        if Entity and not Entity:IsNull() then
            if Entity.GetContainedItem ~= nil then
                UTIL_Remove(Entity)
            end
        end
    end

    self.AdditionalEntities = {}

    for _, Entity in ipairs(self.AdditionalEntities2) do
        if Entity and not Entity:IsNull() then
            UTIL_Remove(Entity)
        end
    end

    self.AdditionalEntities2 = {}
end

function RoundController:EndControllerForTeam(TeamID, bIsEnd, bIsLose)
    if self.TeamsData[TeamID] == nil then return end

    if not bIsEnd then
        self.TeamsData[TeamID].panorama_info.state = GAME_STATES.ENDED
        self.TeamsData[TeamID].panorama_info.time = GameRules:GetGameTime()

        if bIsLose then
            self.TeamsData[TeamID].panorama_info.state = GAME_STATES.SPECTATE
        end

        PlayerTables:SetTableValue("team_"..TeamID, "round_info", self.TeamsData[TeamID].panorama_info)
        self:UpdateGlobalTeamTable(TeamID)

        Rounds:TeamFinished(TeamID)
    else
        self.TeamsData[TeamID].panorama_info.creeps = {}
        self.TeamsData[TeamID].panorama_info.extra_creeps = {}
        self.TeamsData[TeamID].panorama_info.max_creeps = 0
        self.TeamsData[TeamID].panorama_info.killed_creeps = 0
        self.TeamsData[TeamID].panorama_info.state = GAME_STATES.ENDED

        if bIsLose then
            self.TeamsData[TeamID].panorama_info.state = GAME_STATES.SPECTATE
            self.TeamsData[TeamID].panorama_info.time = GameRules:GetGameTime()
        end

        -- CustomNetTables:SetTableValue("globals", "team_"..TeamID.."_round_info", self.TeamsData[TeamID].panorama_info)
        PlayerTables:SetTableValue("team_"..TeamID, "round_info", self.TeamsData[TeamID].panorama_info)

        self:UpdateGlobalTeamTable(TeamID)
    end

    if self.RoundInfo.type == ROUND_TYPES.BASIC or self.RoundInfo.type == ROUND_TYPES.BOSS then
        if self.TeamsData[TeamID] then
            GameRules:GetGameModeEntity():StopThink("ROUND_SPAWNER_"..TeamID)
            GameRules:GetGameModeEntity():StopThink("ROUND_SPAWNER_EXTRA_"..TeamID)

            GameRules:GetGameModeEntity():StopThink("ROUND_LOSE_DELAY_TEAMID_"..TeamID)
            -- Чистим и aegis-fallback safety-net (см. OnEntityKilled выше) -- если команда
            -- штатно закончила раунд (пройдя через TeamFinished/EndControllerForTeam),
            -- fallback больше не нужен, иначе он может ошибочно сработать на след. раунде.
            GameRules:GetGameModeEntity():StopThink("ROUND_LOSE_FALLBACK_TEAMID_"..TeamID)

            for _, PlayerID in ipairs(Players:GetTeamActivePlayers(TeamID, true)) do
                GameRules:GetGameModeEntity():StopThink("ROUND_LOSE_DELAY_PLAYERID_"..PlayerID)
            end

            for _, unit in pairs(self.TeamsData[TeamID].creeps_list) do
                if unit and not unit:IsNull() then
                    if unit:IsAlive() then
                        Creeps:DeleteUnitAsync(unit)
                    end

                    if unit and not unit:IsNull() then
                        UTIL_Remove(unit)
                    end
                end
            end

            if Rounds:IsTeamInPVPDuel(TeamID) then
                if Rounds.CurrentRoundInfo and Rounds.CurrentRoundInfo.duel_arena ~= nil then
                    self:ClearTeamArena(TeamID, Rounds.CurrentRoundInfo.duel_arena)
                end
            else
                self:ClearTeamArena(TeamID)
            end

            self.TeamsData[TeamID] = nil
        end
    end
end

function RoundController:ClearTeamArena(TeamID, _Arena)
    if not self.TeamsData[TeamID] then return end

    local Arena = _Arena
    if Arena == nil or Arena == "" then
        Arena = self.TeamsData[TeamID].arena
    end
    if Arena == "" then return end

    local ArenaInfo = Map:GetArenaInfo(Arena)
    if not ArenaInfo then return end

    local Radius = 1750
    local UnitsToRemove = {
        "npc_dota_shadow_shaman_ward_1",
        "npc_dota_shadow_shaman_ward_2",
        "npc_dota_shadow_shaman_ward_3",
    }

    local All = FindUnitsInRadius(
        TeamID, 
        ArenaInfo.center, 
        nil, 
        Radius, 
        DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
        DOTA_UNIT_TARGET_ALL, 
        DOTA_UNIT_TARGET_FLAG_DEAD + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, 
        FIND_ANY_ORDER, 
        false
    )

    for _, unit in ipairs(All) do
        if unit and not unit:IsNull() and table.contains(UnitsToRemove, unit:GetUnitName()) then
            UTIL_Remove(unit)
        end
    end
end