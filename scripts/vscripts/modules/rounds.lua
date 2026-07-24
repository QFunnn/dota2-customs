--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if Rounds == nil then
    Rounds = class({})
end

-- Сколько секунд после начала берсерка раунда команде дозволено "висеть" живой.
-- Если команда не закончила раунд за это время после старта берсерка -- значит её
-- поле/крипы забаглись (никто не выживает на берсерке так долго) -- принудительно
-- завершаем раунд для команды и убиваем оставшихся игроков, чтобы крипы очистились.
BERSERK_FORCE_KILL_DELAY = 120

function Rounds:Init()
    print('[Rounds] Module is active!')
    self.bStarted = true

    self.DuelJoins = {}

    -- [дуэлянты] Лог всех дуэлей за игру: {round, a (SteamAccountID), b, winner} —
    -- пишется в EndPVPPair, уходит в on_game_end -> game_match.duel_log (для сайта).
    self.DuelLog = {}

    self.PVPPairs = {}

    self.PVPPairsHistory = {
        history = {},
        teams_joins = {}
    }

    -- Состояние подбора дуэлей (см. Rounds:GetRandomPVPPair): глобальный счётчик дуэлей,
    -- всего дуэлей на игрока (ровная частота), seq последней встречи каждой ПАРЫ (тайбрейк
    -- по давности пары), множество сыгранных соперников в текущем круге (round-robin, уникальность).
    self.DuelSeq = 0
    self.DuelCount = {}
    self.DuelPairLastSeq = {}
    self.DuelCycleMet = {}

    self.SpawnSchedule = {}

    self.BetsHistory = {}

    self.RoundID = 0
    self.CurrentRound = 0
    self.CurrentRoundInfo = {}
    self.CurrentState = GAME_STATES.NONE

    self.LastDuelState = "NONE"
    self.LastDuelInfo = {}

    self.ExtraCreepsData = {}

    self.PrepareReadyList = {}
    self.AlreadyAllPrepared = false

    self.RoundSpawnGroups = {}

    self.PvpPairEnded = false

    -- Установка сида данной игры
    self.nSeed = math.floor(GetSystemTimeMS())
    math.randomseed(self.nSeed)
    self.RandomStream = CreateUniformRandomStream(self.nSeed)

    print("SEED: "..self.nSeed)

    self.RoundsByGroupsList = {}
    self:PrepareRoundsByGroupsList()

    self.FixedRoundOverride = nil
    
    self.LastDuelRound = 0

    self.VoteSelected = {}

    self.TeamsDefDurations = {}

    ListenToGameEvent("game_rules_state_change", Dynamic_Wrap( Rounds, 'OnGameRulesStateChange' ), self )

    CustomGameEventManager:RegisterListener("ConfirmBet",function(_, event) self:OnPlayerConfirmBet(event) end)

    CustomGameEventManager:RegisterListener("duel_notification_closed", function(_, event) self:OnDuelNotificationClosed(event) end)
    CustomGameEventManager:RegisterListener("rounds_player_ready", function(_, event) self:OnPlayerReady(event) end)
end

-- Подготовка раундов в начале игры - определяем порядок заранее
function Rounds:PrepareRoundsByGroupsList()
    local RoundsList = {}
    local AvailableRounds = {}
    for i=1, GAME_MAX_ROUNDS do
        local CurrentRoundInfo = GAME_ROUNDS_LIST[i]
        if CurrentRoundInfo and CurrentRoundInfo.type == ROUND_TYPES.VOTING then
            RoundsList[i] = GAME_ROUNDS_LIST[i]
        else
            local GroupID, GroupInfo = self:GetRoundGroup(i)
            if not GroupID or not GroupInfo or not GroupInfo.randomize then
                RoundsList[i] = GAME_ROUNDS_LIST[i]
            else
                AvailableRounds[GroupID] = AvailableRounds[GroupID] or self:GetRoundsInGroup(GroupID)

                if AvailableRounds[GroupID] ~= nil and #AvailableRounds[GroupID] > 0 then
                    local RandomRoundIndex = self.RandomStream:RandomInt(1, #AvailableRounds[GroupID])
                    local RandomRound = AvailableRounds[GroupID][RandomRoundIndex]
                    table.remove(AvailableRounds[GroupID], RandomRoundIndex)
                    RoundsList[i] = GAME_ROUNDS_LIST[RandomRound]
                end
            end
        end
    end

    self.RoundsByGroupsList = RoundsList
end

function Rounds:OnGameRulesStateChange()
    local State = GameRules:State_Get()

    if State == DOTA_GAMERULES_STATE_PRE_GAME then
        for _, TeamID in ipairs(Players:GetAllActiveTeams(true)) do
            AddFOWViewer(TeamID, Vector(0,0,0), 99999, 99999, false)
        end

        CreateModifierThinker(nil, nil, "modifier_abilities_optimization_thinker", {}, Vector(0,0,0), DOTA_TEAM_NEUTRALS, false)
    end

    if State == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        if self.CurrentRound == 0 and self.CurrentState == GAME_STATES.NONE and self.LastDuelState == "NONE" then
            self:PrepareRound(1)
        end
    end

    -- if State == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
    --     States:FinishCustomStates()
    -- end
end

-- Вспомогательная функция для отправки подсказок игроку с задержкой
function Rounds:SendHintToPlayer(PlayerID, PlayerEnt, HintName, Delay)
    if not PlayerEnt or not PlayerEnt:IsAlive() then return end
    
    local PlayerServerInfo = Server:GetPlayerInfo(PlayerID)
    if not PlayerServerInfo or not PlayerServerInfo.settings or PlayerServerInfo.settings.settings_hints_enabled == 0 then
        return
    end
    
    Delay = Delay or 1.0
    
    Timers:CreateTimer(Delay, function()
        if PlayerEnt and PlayerEnt:IsAlive() then
            CustomGameEventManager:Send_ServerToPlayer(PlayerEnt, "cha_hint_visible", {hint = HintName})
        end
    end)
end

-- Таблица соответствий раундов и подсказок
local ROUND_HINTS = {
    [1] = "wiki",
    [11] = "tips",
    [12] = "items",
    [15] = "info_panel",
    [20] = "settings",
    [25] = "creeps_info",
    [31] = "queue_rounds",
    [40] = "shop_neutrals",
    [45] = "paragon_book_2",
    [50] = "bonus_stash",
    [70] = "paragon_book",
    [71] = "neutral_book"
}

function Rounds:PrepareRound(RoundNum, BonusPrepareTime)
    if self.CurrentState ~= GAME_STATES.NONE then return end

    local AllActivePlayers = Players:GetAllActivePlayers()
    local AllActiveTeams = Players:GetAllActiveTeams(true)

    -- [NP-1] Ровно 2 живые команды (а не <=2): при 1 живой команде финальная дуэль
    -- не нужна (игра по сути закончена) — голосование больше не предлагается.
    if #AllActiveTeams == 2 and #Players:GetAllActivatedTeams(true) >= 2 and self.LastDuelState == "NONE" then
        self.LastDuelState = "VOTING"

        Votes:ClearVote("LAST_DUEL")
        Votes:CreateVote("LAST_DUEL", 15)

        -- [NP-1] Список живых участников финальной дуэли. Нет-таблица голосования
        -- глобальная (видна всем клиентам), поэтому помечаем, кому голосование
        -- релевантно — клиенты вылетевших игроков скроют его (см. votes.js).
        if Votes.VotesProgress["LAST_DUEL"] then
            local eligible = {}
            for _, PlayerID in ipairs(Players:GetAllActivePlayers(true)) do
                eligible[tostring(PlayerID)] = 1
            end
            Votes.VotesProgress["LAST_DUEL"].eligible_players = eligible
            Votes:UpdateVoteNetTable("LAST_DUEL")
        end

        GameRules:GetGameModeEntity():SetThink(function()
            self:RoundLastDuelVoting(RoundNum)
        end, nil, "GAME_ROUND_LAST_DUEL_VOTING", 15)

        return
    end

    local RoundInfo = self:GetRoundInfo(RoundNum)

    self.RoundID = self.RoundID + 1

    if self:IsLastDuelActive() then
        RoundInfo = {
            name = "#ROUNDS_Duel",
            type = ROUND_TYPES.BASIC,
            has_duel = true,
        }
    elseif RoundNum >= GAME_MAX_ROUNDS+1 then
        if Players:TryEndGame() then
            self:EndRound()
            return
        end
    end

    if not RoundInfo then
        self:EndRound()
        return
    end

    print("Preparing for round "..RoundNum)

    if BonusPrepareTime == nil then
        BonusPrepareTime = 0
    end

    local PrepareTime = GAME_ROUNDS_PRE_ROUND_PREPARE_DURATION[RoundInfo.type] + BonusPrepareTime
    if IsCheatsEnabled() then
        PrepareTime = 999999
    end
    
    self.CurrentRoundInfo = {
        round_id = self.RoundID,
        current_duration = 0,
        max_duration = GAME_ROUNDS_DURATION[RoundInfo.type],
        info = RoundInfo,
        controller = nil,
        teams = AllActiveTeams,
        max_teams = #AllActiveTeams,
        bet_info = {
            state = "PREPARING",
            bets = {},
        },
        bets = {},
        bet_bonus = (152 + 142 * #AllActiveTeams) * math.pow(1.024, (RoundNum-1)),
        panorama_info = {},
        prepare_time = PrepareTime,
        game_mode_selected = false,
    }

    self.TeamsDefDurations[RoundNum] = {}

    self.CurrentRound = RoundNum
    self.CurrentState = GAME_STATES.PREPARING

    self.PrepareReadyList = {}
    self.AlreadyAllPrepared = false
    CustomGameEventManager:Send_ServerToAllClients("ResetPlayerReadyList", {})

    self.CurrentRoundInfo.panorama_info = {
        num = self.CurrentRound,
        state = self.CurrentState,
        start_time = GameRules:GetGameTime(),
        begin_start_time = GameRules:GetGameTime() + PrepareTime,
        teams = AllActiveTeams,
        info = RoundInfo
    }

    if table.contains(GIVE_BONUSES_FOR_LAST_PLACES_ROUNDS, RoundNum) then
        self:BonusesForLastPlaces(RoundNum)
    end

    for PlayerID, PlayerInfo in pairs(AllActivePlayers) do
        local PlayerTeam = PlayerInfo.team
        Players:UpdateArena(PlayerID, "MAIN", nil, true)

        local Hero = PlayerInfo.hero
        if Players:IsValidHero(Hero) then
            if table.contains(GIVE_NEUTRALS_ROUNDS, RoundNum) then
                NeutralItems:IncreaseNeutralTier(PlayerID)
                NeutralItems:GiveNeutral(PlayerID, nil, nil, nil, nil, nil, nil, true)
            end

            if table.contains(GIVE_ABILITY_SELECTION_ROUNDS, RoundNum) then
                HeroBuilder:AddAbilitiesSelectionToSchedule(PlayerID, ABILITY_SELECTION_TYPE.BASIC)
            end

            if RoundNum > 0 and RoundNum % 5 == 0 and GetGameSetting("HAS_SKILLS_SELECT") == 1 then
                HeroBuilder:ShowRandomSkillSelectionFree(PlayerID)
            end
        end

        if table.contains(GIVE_NEUTRAL_BOOK_ROUNDS, RoundNum) then
            GameRules:SetItemStockCount(GameRules:GetItemStockCount(PlayerTeam, "item_reroll_neutral_book", PlayerID)+1, PlayerTeam, "item_reroll_neutral_book", PlayerID)
        end
        if table.contains(GIVE_PARAGON_BOOK_ROUNDS, RoundNum) then
            GameRules:IncreaseItemStock(PlayerTeam, "item_paragon_book_2", 1, PlayerID)
        end

        if table.contains(GIVE_SSS_RELEARN_BOOK_ROUNDS, RoundNum) then
            GameRules:SetItemStockCount(GameRules:GetItemStockCount(PlayerTeam, "item_relearn_book_sss", PlayerID)+1, PlayerTeam, "item_relearn_book_sss", PlayerID)
        end

        Players:GiveExtraCretures(PlayerID)
    end

    -- Уведомление о включении беспрепятственного передвижения крипов на 60+ раундах
    -- (см. modifier_creep_controll.lua → CheckState — FLYING_FOR_PATHING активируется
    -- для крипов с SpawnRound >= 60 без ожидания берсерка). Шлём один раз — на самом
    -- 60 раунде, когда механика впервые включается.
    if RoundNum == 60 then
        CustomGameEventManager:Send_ServerToAllClients("set_hint_dota_style", {
            text = "#hint_late_round_creeps_free_move",
            duration = 10,
            image = "awarn",
        })
    end

    if RoundInfo.has_duel == true and #AllActiveTeams > 1 then
        self.LastDuelRound = RoundNum
        local NewPVPPair = self:GetRandomPVPPair(AllActiveTeams)
        if NewPVPPair and NewPVPPair[1] ~= nil and NewPVPPair[2] ~= nil then
            self.PVPPairsHistory.currentPair = {fTeam=NewPVPPair[1], sTeam=NewPVPPair[2]}

            self.PVPPairsHistory.lastPair = self.PVPPairsHistory.currentPair

            local hKey = MakeKey(NewPVPPair[1], NewPVPPair[2])
            self.PVPPairsHistory.history[hKey] = (self.PVPPairsHistory.history[hKey] or 0) + 1

            self.DuelJoins[NewPVPPair[1]] = (self.DuelJoins[NewPVPPair[1]] or 0) + 1
            self.DuelJoins[NewPVPPair[2]] = (self.DuelJoins[NewPVPPair[2]] or 0) + 1

            local DuelPlayers={}
            for _, TeamID in ipairs({NewPVPPair[1], NewPVPPair[2]}) do
                for _, PlayerID in ipairs(Players:GetTeamActivePlayers(TeamID, true)) do
                    table.insert(DuelPlayers, {
                        PlayerID = PlayerID,
                        TeamID = TeamID,
                    })
                end
            end

            if #DuelPlayers == 2 then
                for _, PlayerInfo in ipairs(DuelPlayers) do
                    for _, PlayerInfoEnemy in ipairs(DuelPlayers) do
                        if PlayerInfo.TeamID ~= PlayerInfoEnemy.TeamID then
                            local Duration = Server:GetPlayerSettingValue(PlayerInfo.PlayerID, "duel_notification_duration")
                            CustomNetTables:SetTableValue("players", "player_" .. PlayerInfo.PlayerID .. "_duel_info", {
                                bCanBeShowed = Duration > 0,
                                LastTime = GameRules:GetGameTime()+Duration,
                                EnemyPlayerID = PlayerInfoEnemy.PlayerID,
                            })
                        end
                    end
                end
            end

            self.CurrentRoundInfo.bet_info.fTeamID = NewPVPPair[1]
            self.CurrentRoundInfo.bet_info.sTeamID = NewPVPPair[2]
            self.CurrentRoundInfo.bet_info.PlayersList = DuelPlayers
            self.CurrentRoundInfo.bet_info.BetJackpot = self.CurrentRoundInfo.bet_bonus

            PlayerTables:SetTableValue("globals", "duel_info", self.CurrentRoundInfo.bet_info)

            -- A8: волна потери аегиса строго из настроек (штраф −5 за недостающих игроков убран)
            local RoundWhenLoseAegis = GetGameSetting("ROUND_WHEN_LOSE_AEGIS")

            if self.CurrentRound >= RoundWhenLoseAegis then
                -- [NP-23] Аегис-хинт пер-игрока: пропускаем тех, у кого включена настройка
                -- "скрыть хинт о потере аегиса" (запись в ленте уведомлений не затрагивается).
                for _, hPlyID in ipairs(Players:GetAllPlayers(true)) do
                    if Server:GetPlayerSettingValue(hPlyID, "hide_aegis_notification") ~= 1 then
                        local hPlyEnt = PlayerResource:GetPlayer(hPlyID)
                        if hPlyEnt then
                            CustomGameEventManager:Send_ServerToPlayer(hPlyEnt, "set_hint_dota_style", {text = "#hint_duel_notification_aegis", duration = ROUND_PVP_AEGIS_LOST_NOTIFICATION_DURATION-1, image = "aegis"})
                        end
                    end
                end
            end
        end
    end

    if self:IsQueueRound() and RoundInfo.type == ROUND_TYPES.BASIC then
        local Queue, Durations = self:GetTopTeamsByAvgDuration(AllActiveTeams)
        self.CurrentRoundInfo.queue = Queue

        self.CurrentRoundInfo.teams_delay = {}

        for _, TeamID in ipairs(Queue) do
            local Group = math.ceil(_ / 2)
            local Delay = math.max(Group-1, 0)*10
            self.CurrentRoundInfo.teams_delay[TeamID] = Delay
        end

        self.CurrentRoundInfo.panorama_info.is_queue = true

    end

    PlayerTables:SetTableValue("round_info", "round_info", self.CurrentRoundInfo.panorama_info)

    self.CurrentRoundInfo.controller = RoundController(RoundNum, RoundInfo, self.PVPPairsHistory.currentPair, PrepareTime)

    CustomNetTables:SetTableValue("round_info", "round_number", {round = RoundNum})
    HeroBuilder:UpdateSkillsNetTableInfo()

    GameRules:GetGameModeEntity():SetThink("BeginRound", self, "GAME_ROUND_BEGIN_TIMER", PrepareTime)

    self:UpdateDynamicSettings()

    for PlayerID, PlayerInfo in pairs(AllActivePlayers) do
        local PlayerEnt = PlayerResource:GetPlayer(PlayerID)
        if PlayerEnt and Server:IsPlayerNotificationsEnabled(PlayerID) then
            if RoundInfo.notification_text ~= nil then
                CustomGameEventManager:Send_ServerToPlayer(PlayerEnt, "set_hint_dota_style", {text = RoundInfo.notification_text, duration = ROUND_HARD_ENEMY_NOTIFICATION_DURATION, image = "awarn"})
            end

            -- Специальное уведомление для первого раунда
            --if RoundNum == 1 then
            --    CustomGameEventManager:Send_ServerToPlayer(PlayerEnt, "set_hint_dota_style", {text = "#band_notification", duration = 5, image = "awarn"})
            --end
            
            -- Отправка подсказок на основе таблицы ROUND_HINTS
            local HintName = ROUND_HINTS[RoundNum]
            if HintName then
                self:SendHintToPlayer(PlayerID, PlayerEnt, HintName, 1.0)
            end
        end
    end

    if #AllActiveTeams == 1 and RoundInfo.type == ROUND_TYPES.VOTING and not IsCheatsEnabled() then
        self:EndRound(true)
        return
    end

    if RoundInfo.type == ROUND_TYPES.VOTING then
        Votes:ClearVote("ROUND_MODE")

        local Exceptions = {}
        -- if self.VoteSelected.MINIGAME_0 == true and self.VoteSelected.MINIGAME_1 == true and self.VoteSelected.MINIGAME_2 == true then
        --     table.insert(Exceptions, 0)
        -- end
        -- if self.VoteSelected.MASSARENA == true then
        --     table.insert(Exceptions, 1)
        -- end

        -- if #Exceptions == 2 then
        --     self.VoteSelected = {}
        --     Exceptions = {}
        -- end

        Votes:CreateVote("ROUND_MODE", GAME_ROUNDS_TIMINGS["ROUND_TYPE_SELECTING"], Exceptions)
        GameRules:GetGameModeEntity():SetThink("RoundVoting", self, "GAME_ROUND_VOTING", GAME_ROUNDS_TIMINGS["ROUND_TYPE_SELECTING"])
    end
end

function Rounds:RoundVoting()
    if self.CurrentRoundInfo == nil or self.CurrentRoundInfo.info == nil then
        self:EndRound()
        return
    end
    
    local VoteResult, VoteSettings = Votes:EndVote("ROUND_MODE")
    Votes:ClearVote("ROUND_MODE")
    if VoteResult == 0 then
        self.CurrentRoundInfo.arena = "MINIGAMES"
    else
        self.VoteSelected.MASSARENA = true
        self.CurrentRoundInfo.arena = "MASS_ARENA"
    end

    self.CurrentRoundInfo.game_mode_selected = true
end

function Rounds:RoundLastDuelVoting(RoundNum)
    local VoteResult, VoteSettings, VoteCount = Votes:EndVote("LAST_DUEL", true)
    if VoteResult == 1 and (VoteCount >= 2 or IsInToolsMode() or GameRules:IsCheatMode()) then
        self.LastDuelState = "ACTIVATED"

        CustomGameEventManager:Send_ServerToAllClients("vote_result_show", {
            vote = "LAST_DUEL",
            option = 1,
            values = VoteSettings
        })
    else
        self.LastDuelState = "CANCELED"

        CustomGameEventManager:Send_ServerToAllClients("vote_result_show", {
            vote = "LAST_DUEL",
            option = 0,
            values = VoteSettings
        })
    end
    Votes:ClearVote("LAST_DUEL")

    if self:IsLastDuelActive() then
        for PlayerID, PlayerInfo in pairs(Players:GetAllActivePlayers()) do
            HeroBuilder:UpdateSmokeCount(PlayerID)
            HeroBuilder:UpdateLoserCurseCount(PlayerID)
            local Hero = PlayerInfo.hero
            if Players:IsValidHero(Hero) then
                Hero:ModifyGoldFiltered(LAST_DUEL_GOLD, true, 0)
                for i=1,LAST_DUEL_RELEARN_BOOKS do
                    local hItem = CreateItem("item_relearn_book_lua", Hero, Hero)
                    Hero:AddItem(hItem)
                end

                table.insert(self.LastDuelInfo, PlayerID)
            end
        end

        Server.LastRoundBeforeDuel = RoundNum - 1
    end

    GameRules:GetGameModeEntity():SetThink(function()
        if self:IsLastDuelActive() then
            CustomNetTables:SetTableValue("globals", "last_duel_players", self.LastDuelInfo)

            self:PrepareRound(LAST_DUEL_STARTING_ROUND_NUM, LAST_DUEL_PREPARE_DURATION)
        else
            self:PrepareRound(RoundNum)
        end
    end, nil, "GAME_ROUND_LAST_DUEL_VOTING_END", 6)
end

function Rounds:RoundVotingMinigames()
    if self.CurrentRoundInfo == nil or self.CurrentRoundInfo.info == nil then
        self:EndRound()
        return
    end
    
    local VoteResult = Votes:EndVote("MINIGAME_TYPE")
    Votes:ClearVote("MINIGAME_TYPE")
    self.CurrentRoundInfo.minigame_type = VoteResult

    self.VoteSelected["MINIGAME_"..VoteResult] = true

    self.CurrentRoundInfo.panorama_info.minigame_type = self.CurrentRoundInfo.minigame_type

    for PlayerID, PlayerInfo in pairs(Players:GetAllActivePlayers()) do
        if not Rounds:IsFinishedTeam(PlayerInfo.team) then
            if VoteResult == 0 then
                Players:ChangePlayerSelectedUnit(PlayerID, "npc_minigames_arena", true, true)
            elseif VoteResult == 1 then
                Players:ChangePlayerSelectedUnit(PlayerID, "npc_minigames_pudge", true, true)
            else
                Players:ChangePlayerSelectedUnit(PlayerID, "npc_minigames_mirana", true, true)
            end
        end
    end

    if self.CurrentRoundInfo and self.CurrentRoundInfo.controller then
        self.CurrentRoundInfo.controller:BeginMinigames()
    end

    -- CustomNetTables:SetTableValue("globals", "round_info", self.CurrentRoundInfo.panorama_info)
    PlayerTables:SetTableValue("round_info", "round_info", self.CurrentRoundInfo.panorama_info)
end

function Rounds:BeginRound()
    if self.CurrentState ~= GAME_STATES.PREPARING then return end

    print("Round has begun", self.CurrentRound)

    self:CalculateBets()
 
    Players:ClearPlayersNetTableDamage()
    CustomGameEventManager:Send_ServerToAllClients("ResetPlayerReadyList", {})

    --Если каким-то образом нет данных раунда - закончить его
    if self.CurrentRoundInfo == nil or self.CurrentRoundInfo.info == nil then
        self:EndRound()
        return
    end

    self.CurrentRoundInfo.bet_info.state = "IN_GAME"
    PlayerTables:SetTableValue("globals", "duel_info", self.CurrentRoundInfo.bet_info)

    --Установка типа арены, которая будет использоваться в этом раунде
    local Arena = nil
    if self.CurrentRoundInfo.info.type == ROUND_TYPES.VOTING then
        if self.CurrentRoundInfo.arena == nil then
            self:EndRound()
            return
        end
        Arena = self.CurrentRoundInfo.arena
    elseif self.CurrentRoundInfo.info.type == ROUND_TYPES.BOSS then
        Arena = "BOSS_ARENA"
    elseif self.CurrentRoundInfo.info.type == ROUND_TYPES.BASIC then
        Arena = "SELF"
    end

    --Если каким-то образом арена не была установлена - закончить раунд
    if Arena == nil then
        self:EndRound()
        return
    end

    --Установка текущей длительности раунда
    if GAME_ROUNDS_TIMINGS[Arena] then
        self.CurrentRoundInfo.max_duration = self.CurrentRoundInfo.max_duration + GAME_ROUNDS_TIMINGS[Arena]
        if Arena == "MINIGAMES" then
            self.CurrentRoundInfo.max_duration = self.CurrentRoundInfo.max_duration + GAME_ROUNDS_TIMINGS["MINIGAMES_DELAY"]
        end
    end

    --Взятие возможных позиций игроков в минииграх и масс-арене
    local AvailablePositions = nil
    if Arena == "MINIGAMES" or Arena == "MASS_ARENA" then
        local ArenaInfo = Map:GetArenaInfo(Arena)
        if ArenaInfo then
            AvailablePositions = table.deepcopy(ArenaInfo.positions)
        end
    end

    --Взятие возможных позиций игроков если этот раунд имеет дуэль
    local AvailablePositionsDuel = {}
    local DuelArena = nil
    if Arena == "SELF" and self.CurrentRoundInfo.info.has_duel == true and self.PVPPairsHistory.currentPair ~= nil then
        local DuelArenaTeam = table.random({self.PVPPairsHistory.currentPair.fTeam, self.PVPPairsHistory.currentPair.sTeam})

        local DuelTeamInfo = Players:GetTeam(DuelArenaTeam)
        if DuelTeamInfo then
            DuelArena = DuelTeamInfo.arena
            local ArenaInfo = Map:GetArenaInfo(DuelArena)
            if ArenaInfo then
                local Left = GetGroundPosition(ArenaInfo.center, nil) - Vector(500, 0, 0)
                local Right = GetGroundPosition(ArenaInfo.center, nil) + Vector(500, 0, 0)

                table.insert(AvailablePositionsDuel, Left)
                table.insert(AvailablePositionsDuel, Right)
            end
        end
    end

    if DuelArena ~= nil then
        self.CurrentRoundInfo.duel_arena = DuelArena
    end

    -- local PairPlayers = {}
    -- local SpecialBetMap = {}
    -- if self.PVPPairsHistory.currentPair ~= nil then

    --     SpecialBetMap[self.PVPPairsHistory.currentPair.fTeam] = {}
    --     SpecialBetMap[self.PVPPairsHistory.currentPair.sTeam] = {}

    --     local Teams = {self.PVPPairsHistory.currentPair.fTeam, self.PVPPairsHistory.currentPair.sTeam}

    --     for _, TeamID in ipairs(Teams) do
    --         for _, PlayerID in ipairs(Players:GetTeamActivePlayers(TeamID, true)) do
    --             table.insert(PairPlayers, {
    --                 playerID = PlayerID,
    --                 teamID = TeamID
    --             })
    --         end
    --     end

    --     for PlayerID, BetInfo in pairs(self.CurrentRoundInfo.bets) do
    --         table.insert(SpecialBetMap[BetInfo.team], {
    --             nPlayerId = PlayerID,
    --             nValue = BetInfo.value,
    --             sType = BetInfo.bet_type,
    --             flRatio = BetInfo.ratio
    --         })
    --     end
    -- end

    --Перебор игроков
    for PlayerID, PlayerInfo in pairs(Players:GetAllPlayers()) do
        -- Проверяем, закончила ли команда уже этот раунд или нет (особые случаи)
        if not Rounds:IsFinishedTeam(PlayerInfo.team) then

            -- local hPlayer = PlayerResource:GetPlayer(PlayerID)
            -- if hPlayer then
            --     CustomGameEventManager:Send_ServerToPlayer(hPlayer, "HidePvpBet", {})

            --     if self.PVPPairsHistory.currentPair ~= nil then
            --         if not self:IsPlayerInPVPDuel(PlayerID) then
            --             CustomGameEventManager:Send_ServerToPlayer(hPlayer, "ShowPvpBrief", {
            --                 players = PairPlayers, 
            --                 firstTeamId = self.PVPPairsHistory.currentPair.fTeam, 
            --                 secondTeamId = self.PVPPairsHistory.currentPair.sTeam, 
            --                 betMap = SpecialBetMap, 
            --                 bonusPool = math.floor(self.CurrentRoundInfo.bet_bonus)
            --             })
            --         end
            --     end
            -- end

            if Players:IsActivePlayer(PlayerID) then
                --Если арена == SELF, тогда выставить арену игрока
                local SelfArena = Arena
                if SelfArena == "SELF" then
                    local TeamInfo = Players:GetTeam(PlayerInfo.team)
                    if TeamInfo then
                        SelfArena = TeamInfo.arena
                    end
                end

                --Если нету арены - закончить раунд
                if Map:GetArenaInfo(SelfArena) == nil then self:EndRound() return end

                --Позиция игрока в зависимости от арены - если своя, то в центре, иначе рядом с центом в случайной позиции
                local Position = Arena == "SELF" and "center" or nil

                --Позиция игрока если это миниигра или масс-арена
                if Arena ~= "SELF" and AvailablePositions ~= nil then
                    local rKey = table.random_key(AvailablePositions)
                    local rPos = AvailablePositions[rKey]
                    Position = rPos

                    table.remove(AvailablePositions, rKey)
                end

                --Позиция игрока если это обычный раунд но он учавствует в дуэли
                if Arena == "SELF" and self:IsPlayerInPVPDuel(PlayerID) and table.count(AvailablePositionsDuel) > 0 and DuelArena then

                    SelfArena = DuelArena
                    
                    local rKey = 1
                    if PlayerInfo.team == self.PVPPairsHistory.currentPair.sTeam and table.count(AvailablePositionsDuel) > 1 then
                        rKey = 2
                    end
                    local rPos = AvailablePositionsDuel[rKey]
                    Position = rPos

                    table.remove(AvailablePositionsDuel, rKey)

                    self:OnDuelNotificationClosed({PlayerID = PlayerID})

                    local fx = ParticleManager:CreateParticle("particles/econ/items/legion/legion_weapon_voth_domosh/legion_duel_ring_arcana.vpcf", PATTACH_WORLDORIGIN, nil)
                    ParticleManager:SetParticleControl(fx, 0, Position)
                    Timers:CreateTimer({ endTime = 1, callback = function()
                        if fx then
                            ParticleManager:DestroyParticle(fx, false)
                            ParticleManager:ReleaseParticleIndex(fx)
                        end
                    end})
                end

                if Arena == "BOSS_ARENA" then
                    local ArenaInfo = Map:GetArenaInfo("BOSS_ARENA")
                    if ArenaInfo then
                        Position = ArenaInfo.center + Vector(2000, 0, 0) + RandomVector(RandomFloat(250, 600))
                    end
                end

                local Delay = self:GetTeamStartDelay(PlayerInfo.team)
                if Delay > 0 then
                    GameRules:GetGameModeEntity():SetThink(function()
                        Players:UpdateArena(PlayerID, SelfArena, Position)

                        if self.CurrentRoundInfo.controller then
                            self.CurrentRoundInfo.controller:BeginTeamArena(PlayerInfo.team, self.CurrentRoundInfo.max_duration-Delay)
                        end
                    end, nil, "PLAYER_"..PlayerID.."_START_DELAY_TIMER", Delay)
                else
                    --Установка арены и позиции игроку
                    Players:UpdateArena(PlayerID, SelfArena, Position)

                    if self.CurrentRoundInfo.controller then
                        self.CurrentRoundInfo.controller:BeginTeamArena(PlayerInfo.team, self.CurrentRoundInfo.max_duration)
                    end
                end
            end
        end
    end

    --Переключение текущей стадии раундов
    self.CurrentState = GAME_STATES.IN_ACTION

    if self.CurrentRoundInfo.controller then
        self.CurrentRoundInfo.controller:BeginRound()

        if Arena == "MASS_ARENA" then
            self.CurrentRoundInfo.controller:BeginMassArena()
        end
    end

    self.CurrentRoundInfo.panorama_info.state = self.CurrentState
    self.CurrentRoundInfo.panorama_info.arena = Arena

    -- CustomNetTables:SetTableValue("globals", "round_info", self.CurrentRoundInfo.panorama_info)
    PlayerTables:SetTableValue("round_info", "round_info", self.CurrentRoundInfo.panorama_info)

    --Таймер раунда
    GameRules:GetGameModeEntity():SetThink("TimerRound", self, "GAME_ROUND_TIMER", 1)

    --Таймер для голосования
    if self.CurrentRoundInfo.info.type == ROUND_TYPES.VOTING and Arena == "MINIGAMES" then
        Votes:ClearVote("MINIGAME_TYPE")

        local Exceptions = {}
        -- for i = 0, 2 do
        --     if self.VoteSelected["MINIGAME_"..i] == true then
        --         table.insert(Exceptions, i)
        --     end
        -- end

        Votes:CreateVote("MINIGAME_TYPE", GAME_ROUNDS_TIMINGS["MINIGAMES"], Exceptions)
        GameRules:GetGameModeEntity():SetThink("RoundVotingMinigames", self, "GAME_ROUND_VOTING_MINIGAMES", GAME_ROUNDS_TIMINGS["MINIGAMES"])
    end
end

function Rounds:TimerRound()
    --Если каким-то образом нет данных раунда - закончить его
    if self.CurrentRoundInfo == nil or self.CurrentRoundInfo.info == nil then
        self:EndRound()
        return
    end

    Players:UpdatePlayersNetTableDamage()

    self.CurrentRoundInfo.current_duration = self.CurrentRoundInfo.current_duration + 1

    if self.CurrentRoundInfo.current_duration >= self.CurrentRoundInfo.max_duration then
        if self.CurrentRoundInfo.info.type == ROUND_TYPES.VOTING then
            self:RoundDurationEnded()
            return
        end
    end
    if self.CurrentRoundInfo.info.type ~= ROUND_TYPES.VOTING then
        if self.CurrentRoundInfo ~= nil and self.CurrentRoundInfo.controller ~= nil then
            -- Используем копию списка teams, потому что ForceKillStuckTeam может
            -- модифицировать self.CurrentRoundInfo.teams (через TeamFinished), что
            -- сломает итерацию по массиву.
            local TeamsSnapshot = {}
            for _, TeamID in ipairs(self.CurrentRoundInfo.teams) do
                table.insert(TeamsSnapshot, TeamID)
            end

            for _, TeamID in ipairs(TeamsSnapshot) do
                if not self:IsFinishedTeam(TeamID) then
                    local CurrentDuration = math.max(self.CurrentRoundInfo.current_duration - self:GetTeamStartDelay(TeamID), 0)
                    if CurrentDuration >= self.CurrentRoundInfo.max_duration - 5 then
                        local bRoundTimeOver = CurrentDuration >= self.CurrentRoundInfo.max_duration
                        self.CurrentRoundInfo.controller:TeamRoundOverTime(TeamID, bRoundTimeOver)
                    end

                    -- Force-kill застрявших на берсерке команд: дисконнектнутый игрок
                    -- иногда оставляет за собой крипов/энтити, которые не убираются и
                    -- раунд для его команды не заканчивается. Никто не выживает на
                    -- берсерке 2 минуты -- если выжил, значит поле забаглось.
                    if CurrentDuration >= self.CurrentRoundInfo.max_duration + BERSERK_FORCE_KILL_DELAY then
                        self:ForceKillStuckTeam(TeamID)
                    end
                end
            end
        end
    end
    return 1
end

-- Принудительно завершает раунд для зависшей на берсерке команды:
--   1) убивает всех живых героев команды (запускает обычный lose-flow через OnEntityKilled)
--   2) если через GAME_PLAYER_LOSE_DELAY команда всё ещё в раунде -- напрямую вызывает EndTeam,
--      чтобы EndControllerForTeam очистил оставшихся крипов.
--
-- ВАЖНО про задержку: OnEntityKilled при гибели последнего живого героя команды ставит
-- SetThink на GAME_PLAYER_LOSE_DELAY секунд, и только потом вызывает Players:MakeTeamLose
-- (где Send_ServerToPlayer "ShowPlayerLose" + TEAM_STATE.LOSE + top-bar обновление).
-- Если EndTeam вызвать СРАЗУ после Hero:Kill, мы успеваем удалить команду из
-- CurrentRoundInfo.teams и MakeTeamLose потом отстреливается в IsActiveTeam-проверку
-- (или просто после end of round). Игрок не видит экран смерти и top-bar не обновляется.
function Rounds:ForceKillStuckTeam(TeamID)
    if self:IsFinishedTeam(TeamID) then return end

    -- Защита от повторных срабатываний на каждом тике TimerRound пока действует условие
    if self.CurrentRoundInfo == nil then return end
    if self.CurrentRoundInfo.force_kill_initiated == nil then
        self.CurrentRoundInfo.force_kill_initiated = {}
    end
    if self.CurrentRoundInfo.force_kill_initiated[TeamID] then return end
    self.CurrentRoundInfo.force_kill_initiated[TeamID] = true

    if ROUND_DEBUG_ENABLED then
        print("[ROUND_DEBUG] FORCE KILL STUCK TEAM: TeamID=" .. tostring(TeamID) ..
            " round=" .. tostring(self.CurrentRound) ..
            " duration=" .. tostring(self.CurrentRoundInfo.current_duration or "?") ..
            " (>" .. BERSERK_FORCE_KILL_DELAY .. "s on berserk)")
    end

    -- Убиваем всех живых героев команды -- это запустит штатный flow (OnEntityKilled -> AFK-check -> MakeTeamLose)
    local bAnyAlive = false
    for _, PlayerID in ipairs(Players:GetTeamActivePlayers(TeamID, true)) do
        local PlayerInfo = Players:GetPlayer(PlayerID)
        if PlayerInfo and Players:IsValidHero(PlayerInfo.hero) and PlayerInfo.hero:IsAlive() then
            if ROUND_DEBUG_ENABLED then print("[ROUND_DEBUG] FORCE KILL: killing hero of PlayerID=" .. tostring(PlayerID)) end
            PlayerInfo.hero:Kill(nil, PlayerInfo.hero)
            bAnyAlive = true
        end
    end

    if bAnyAlive then
        -- Дать AFK-flow время отработать: OnEntityKilled делает SetThink(GAME_PLAYER_LOSE_DELAY),
        -- потом MakeTeamLose показывает ShowPlayerLose и обновляет top-bar.
        -- Через delay+буфер проверяем -- если штатный flow не закрыл раунд (например aegis-реинкарнация
        -- спасла героев и они стоят на берсерке вечно), форсим EndTeam.
        Timers:CreateTimer(GAME_PLAYER_LOSE_DELAY + 1.5, function()
            if not self:IsFinishedTeam(TeamID) then
                if ROUND_DEBUG_ENABLED then print("[ROUND_DEBUG] FORCE KILL: team still in round after AFK delay, force EndTeam TeamID=" .. tostring(TeamID)) end
                self:EndTeam(TeamID, true)
            else
                if ROUND_DEBUG_ENABLED then print("[ROUND_DEBUG] FORCE KILL: AFK-flow закрыл раунд штатно для TeamID=" .. tostring(TeamID)) end
            end
        end)
    else
        -- Все игроки команды уже мертвы -- Hero:Kill ничего не сделал, штатный flow не запустится.
        -- Сразу форсим EndTeam, чтобы зависшие крипы очистились.
        if ROUND_DEBUG_ENABLED then print("[ROUND_DEBUG] FORCE KILL: no living heroes, EndTeam directly TeamID=" .. tostring(TeamID)) end
        self:EndTeam(TeamID, true)
    end
end

function Rounds:EndTeam(TeamID, bIsLose)
    if self.CurrentRoundInfo and self.CurrentRoundInfo.controller then
        self.CurrentRoundInfo.controller:EndControllerForTeam(TeamID, nil, bIsLose)
    end
end

function Rounds:TeamFinished(TeamID)
    --Если каким-то образом нет данных раунда - закончить его
    if self.CurrentRoundInfo == nil or self.CurrentRoundInfo.info == nil then
        self:EndRound()
        return
    end

    if self:IsFinishedTeam(TeamID) then return end

    local Place = #self.CurrentRoundInfo.teams

    table.remove_item(self.CurrentRoundInfo.teams, TeamID)

    if self:RoundTypeIs(ROUND_TYPES.VOTING) then
        self:TeamFinishedMinigames(TeamID, Place)
    end

    if #self.CurrentRoundInfo.teams <= 0 then
        self:EndRound(true)
        return
    end
end

function Rounds:TeamFinishedQueue(TeamID, DefDuration)
    if self:IsFinishedTeam(TeamID) then return end

    self.TeamsDefDurations[self.CurrentRound][TeamID] = DefDuration
end

-- Логика конца раунда мини-игр и масс арены
function Rounds:RoundDurationEnded()
    if self.CurrentState ~= GAME_STATES.IN_ACTION or self.CurrentRoundInfo == nil then self:EndRound() return end

    local HealthData = {}

    for _, TeamID in ipairs(self.CurrentRoundInfo.teams) do
        local Health = 0
        for PlayerID, PlayerInfo in pairs(Players:GetTeamActivePlayers(TeamID)) do
            local Hero = PlayerInfo.hero
            local SecondaryUnit = PlayerInfo.secondary_unit
            if self.CurrentRoundInfo.arena == "MASS_ARENA" and Players:IsValidHero(Hero) then -- Если это масс арена, то проверяем по процентам хп героев
                Health = Health + Hero:GetHealthPercent()
            elseif Players:IsValidHero(SecondaryUnit) then -- Иначе (это мини-игра) проверка по оставшися хп вторичных юнитов
                Health = Health + SecondaryUnit:GetHealth()
            end
        end
        table.insert(HealthData, {
            health = Health,
            team = TeamID
        })
    end

    -- Если не нашло ни одного игрока
    if #HealthData == 0 then self:EndRound() return end

    table.sort(HealthData, function(a, b) return a.health < b.health end)

    local Top1 = HealthData[#HealthData].health

    HealthData = ArrayRemove(HealthData, function(t, i, j)
        if t[i].health < Top1 then
            self:EndTeam(t[i].team)

            return false
        end

        return true
    end)

    if #HealthData > 1 then
        local RandomTeamKey = table.random_key(HealthData)
        local RandomTeam = HealthData[RandomTeamKey].team

        HealthData = ArrayRemove(HealthData, function(t, i, j)
            if t[i].team ~= RandomTeam then
                self:EndTeam(t[i].team)

                return false
            end

            return true
        end)
    end
end

function Rounds:TeamFinishedMinigames(TeamID, Place)
    if self.CurrentRoundInfo == nil or self.CurrentRoundInfo.max_teams == nil then return end

    for TeamPlayerID, TeamPlayerInfo in pairs(Players:GetTeamPlayers(TeamID)) do

        local FinishType = 1
        -- if Place == self.CurrentRoundInfo.max_teams then
        --     FinishType = 2
        -- else
        if Place == 1 then
            FinishType = 3
        end
        
        local data = {
            type = "minigames_finish",
            playerId = TeamPlayerID,
            finish_type = FinishType
        }
        Barrage:FireBullet(data)
        
        local Hero = TeamPlayerInfo.hero
        if Players:IsValidHero(Hero) then
            local Bonus = 0
            local TeamsCategory = MINIGAMES_WIN_BUFF_STACKS[self.CurrentRoundInfo.max_teams]
            if TeamsCategory ~= nil then
                Bonus = TeamsCategory[Place]
            end

            HeroBuilder:UpdateMinigamesWins(TeamPlayerID, Bonus)

            local NotificationType = NOTIFICATION_TYPE.MINIGAMES_LOSE
            if Place == 1 then
                NotificationType = NOTIFICATION_TYPE.MINIGAMES_WIN
            end
            if self.CurrentRoundInfo.arena == "MASS_ARENA" then
                NotificationType = NOTIFICATION_TYPE.MASS_ARENA_LOSE
                if Place == 1 then
                    NotificationType = NOTIFICATION_TYPE.MASS_ARENA_WIN
                end
            end

            Notifications:AddNotification(NotificationType, self:GetCurrentRound(), {
                player1 = TeamPlayerID,
                value1 = Bonus
            })
        end

        Players:RemoveSecondaryPlayerUnit(TeamPlayerID)
    end

    if #self:GetRoundTeams() == 1 then
        self:EndTeam(self:GetRoundTeams()[1])

        return true
    end

    return false
end

function Rounds:EndRound(bStartNextRound)
    print("Round ended "..self.CurrentRound)
    self.CurrentState = GAME_STATES.NONE
    GameRules:GetGameModeEntity():StopThink("GAME_ROUND_BEGIN_TIMER")
    GameRules:GetGameModeEntity():StopThink("GAME_ROUND_TIMER")
    GameRules:GetGameModeEntity():StopThink("GAME_ROUND_VOTING")
    GameRules:GetGameModeEntity():StopThink("GAME_ROUND_VOTING_MINIGAMES")
    GameRules:GetGameModeEntity():StopThink("GAME_ROUND_LAST_DUEL_VOTING")
    GameRules:GetGameModeEntity():StopThink("GAME_ROUND_LAST_DUEL_VOTING_END")
    
    if self.LastDuelState == "VOTING" then
        self.LastDuelState = "NONE"
    end

    local RoundType = ROUND_TYPES.BASIC

    if self.CurrentRoundInfo ~= nil and self.CurrentRoundInfo.controller ~= nil then
        RoundType = self.CurrentRoundInfo.info.type
        self.CurrentRoundInfo.panorama_info.state = self.CurrentState
        -- CustomNetTables:SetTableValue("globals", "round_info", self.CurrentRoundInfo.panorama_info)
        PlayerTables:SetTableValue("round_info", "round_info", self.CurrentRoundInfo.panorama_info)

        self.CurrentRoundInfo.bet_info.state = "FINISHED"
        self.CurrentRoundInfo.bet_info.winner = nil
        PlayerTables:SetTableValue("globals", "duel_info", self.CurrentRoundInfo.bet_info)

        if bStartNextRound and self.TeamsDefDurations[self.CurrentRound] and table.count(self.TeamsDefDurations[self.CurrentRound]) > 0 and self:IsQueueRound() then
            local List = table.keys(self.TeamsDefDurations[self.CurrentRound])

            table.sort(List, function(a, b) return self.TeamsDefDurations[self.CurrentRound][a] < self.TeamsDefDurations[self.CurrentRound][b] end)

            for _, TeamID in ipairs(List) do
                self.CurrentRoundInfo.controller:GiveRoundReward(TeamID, _)
            end
        end

        self.CurrentRoundInfo.controller:EndController()

        self.CurrentRoundInfo = nil
    end

    CustomGameEventManager:Send_ServerToAllClients("ResetPlayerReadyList", {})

    Votes:ClearVote("ROUND_MODE")
    Votes:ClearVote("MINIGAME_TYPE")
    Votes:ClearVote("LAST_DUEL")

    self.PVPPairsHistory.currentPair = nil
    self.PvpPairEnded = false

    self.PrepareReadyList = {}
    self.AlreadyAllPrepared = false

    for _, PlayerID in ipairs(Players:GetAllPlayers(true)) do
        if Players:IsActivePlayer(PlayerID) then
            local HeroInfo = HeroBuilder:GetPlayerInfo(PlayerID)
            if HeroInfo then
                local Hero = HeroInfo.selected_hero_ent
                if Hero then
                    Hero:RemoveModifierByName("modifier_arenas_pre_stun")
                end
            end

            if bStartNextRound and self:GetRoundInfo(self.CurrentRound+1) == nil then
                Players:UpdateArena(PlayerID, "MAIN", nil)
            elseif RoundType == ROUND_TYPES.VOTING then
                Players:UpdateArena(PlayerID, "MAIN", nil, nil, true)
            end

            -- Убираем юнита из мини-игры у игрока
            Players:ChangePlayerSelectedUnit(PlayerID, nil, false, false)
        end

        self:OnDuelNotificationClosed({PlayerID = PlayerID})

        GameRules:GetGameModeEntity():StopThink("PLAYER_"..PlayerID.."_START_DELAY_TIMER")
    end

    -- CustomGameEventManager:Send_ServerToAllClients("TeamWin",{winnerTeamID=nil,loserTeamID=nil} );
    -- CustomGameEventManager:Send_ServerToAllClients("CloseTopInfo",{} );

    Util:CleanFurArmySoldier()
    Util:ThinkerClean()

    Players:UpdatePlayersNetTableDamage()

    -- Откладываем ClearSpawnGroups и PrepareRound на следующий фрейм
    -- Причина: если EndRound вызван из OnEntityKilled (смерть последнего крипа),
    -- то UnloadSpawnGroupByHandle нельзя вызывать синхронно — движок ещё обрабатывает
    -- смерть entity из этого spawn group, и UnloadSpawnGroup в этот момент = native crash
    local nextRound = bStartNextRound and (self.CurrentRound+1) or nil

    Timers:CreateTimer({ endTime = 0, callback = function()
        self:ClearSpawnGroups()

        if nextRound then
            self:PrepareRound(nextRound)
        end
    end})
end

function Rounds:CreatePlayersPVPPairs()
    self.PVPPairs = {}

    local AllActiveTeams = Players:GetAllActiveTeams(true)

    if #AllActiveTeams < 2 then return end

    for i, TeamID in ipairs(AllActiveTeams) do
        for j, TeamID2 in ipairs(AllActiveTeams) do
            if j < i then
                table.insert(self.PVPPairs, {
                    fTeam = TeamID,
                    sTeam = TeamID2,
                    Joins = 0
                })
            end
        end
    end
end

function Rounds:BonusesForLastPlaces(nRoundNumber)
    local dataList = Players:GetSortedByGoldActiveTeams()

    local teams = {}

    -- Фильтруем команды, которым будем выдавать бонусы и
    -- добавляем кроме золота к стате команды - смоки
    for _, TeamInfo in ipairs(dataList) do
        if #dataList > _ and _ <= 3 then
            TeamInfo.smokes = 0
            for PlayerID, PlayerInfo in pairs(Players:GetTeamActivePlayers(TeamInfo.team)) do
                local hHero = PlayerInfo.hero
                if Players:IsValidHero(hHero) then
                    local Item = hHero:FindItemInInventory("item_smoke_of_deceit_custom")
                    if Item then
                        TeamInfo.smokes = TeamInfo.smokes + (Item:GetCurrentCharges() or 0)
                    end
                end
            end
            teams[_] = TeamInfo
        end
    end

    local TeamForSmoke = nil

    local TeamsCopy = table.deepcopy(teams)

    -- Для того, чтобы понять кому выдать смоки, сортируем команды по статам в порядке: смоки, золото, случайность - если и смоки и золото одинаковы
    if #TeamsCopy > 0 then
        local Values = {"smokes", "gold", "random"}
        for _, Value in ipairs(Values) do
            if #TeamsCopy == 1 then
                TeamForSmoke = TeamsCopy[1].team
                break
            elseif Value ~= "random" then
                table.sort(TeamsCopy, function(a, b) return a[Value] < b[Value] end)
                local Top1 = TeamsCopy[1][Value]
                TeamsCopy = ArrayRemove(TeamsCopy, function(t, i, j)
                    if t[i][Value] > Top1 then return false end

                    return true
                end)
            elseif Value == "random" then
                local RandomTeamIndex = table.random_key(TeamsCopy)
                TeamForSmoke = TeamsCopy[RandomTeamIndex].team

                break
            end
        end
    end

    -- Выдача предметов
    for _, TeamInfo in ipairs(teams) do
        for PlayerID, PlayerInfo in pairs(Players:GetTeamActivePlayers(TeamInfo.team)) do
            local hHero = PlayerInfo.hero
            if Players:IsValidHero(hHero) then
                -- Книги всегда кладутся в зарезервированные слоты бонусного тайника (SLOT_0, SLOT_1)
                for slotName, itemName in pairs(RESERVED_BOOK_SLOTS) do
                    local existingItem = Items.Players[PlayerID] and Items.Players[PlayerID].items[slotName]
                    if existingItem then
                        -- Книга уже есть — добавляем заряд
                        local hExisting = EntIndexToHScript(existingItem.item)
                        if hExisting and not hExisting:IsNull() then
                            hExisting:SetCurrentCharges(hExisting:GetCurrentCharges() + 1)
                            -- [#38] use-only награда (книга), нетворс НЕ повышаем
                            -- ВАЖНО: иначе клиент не узнаёт о новом charges-count.
                            Items:UpdatePlayerNetTable(PlayerID)
                            print("[BOOK DEBUG] PlayerID:" .. PlayerID .. " " .. itemName .. " +1 charge in " .. slotName .. " (now " .. hExisting:GetCurrentCharges() .. ")")
                        end
                    else
                        local hItem = CreateItem(itemName, nil, nil)
                        if hItem then
                            hItem:SetPurchaseTime(0)
                            hItem._dont_auto_consume_alt = true
                            hItem:SetCurrentCharges(1)
                            -- [#38] use-only награда (новая книга), нетворс НЕ повышаем
                            Items:AddItemToCustomStash(PlayerID, hItem, slotName)
                            print("[BOOK DEBUG] PlayerID:" .. PlayerID .. " " .. itemName .. " placed in " .. slotName)
                        end
                    end
                end

                -- Открываем бонусный тайник чтобы игрок увидел книги
                local Player = PlayerResource:GetPlayer(PlayerID)
                if Player then
                    CustomGameEventManager:Send_ServerToPlayer(Player, "open_bonus_stash", {})
                end

                -- Подсказка о книге переобучения для отстающих игроков
                local PlayerServerInfo = Server:GetPlayerInfo(PlayerID)
                if PlayerServerInfo and PlayerServerInfo.settings and PlayerServerInfo.settings.settings_hints_enabled ~= 0 then
                    local Player = PlayerResource:GetPlayer(PlayerID)
                    if Player then
                        Timers:CreateTimer(1.0, function()
                            if Player and Player:IsAlive() then
                                CustomGameEventManager:Send_ServerToPlayer(Player, "cha_hint_visible", {hint = "reroll_book"})
                            end
                        end)
                    end
                end
                local vData = {
                    type = "compensate_relearn_book",
                    round_number = tostring(nRoundNumber),
                    playerId = PlayerID,
                    book_type = 3
                }
                Barrage:FireBullet(vData)

                local NotificationType = NOTIFICATION_TYPE.LAST_PLACE_BONUS
                if TeamForSmoke == TeamInfo.team then
                    NotificationType = NOTIFICATION_TYPE.LAST_PLACE_BONUS_WITH_SMOKE

                    local hSmoke = hHero:AddItemByName("item_smoke_of_deceit_custom")
                    local vData = {
                        type = "compensate_smoke",
                        round_number = tostring(nRoundNumber),
                        playerId = PlayerID
                    }
                    Barrage:FireBullet(vData)
                    if hSmoke then
                        -- [#38] use-only награда (смок), нетворс НЕ повышаем
                    end
                end

                Notifications:AddNotification(NotificationType, self:GetCurrentRound(), {
                    player1 = PlayerID,
                    item1 = "item_relearn_book_lua",
                    item2 = "item_relearn_torn_page_lua",
                    item3 = "item_smoke_of_deceit_custom"
                })
            end
        end
    end
end

function MakeKey(a, b)
    if a < b then return a.."_"..b else return b.."_"..a end
end


-- Подбор соперника на дуэль. Круговой (round-robin) подход: игрок проходит ВСЕХ
-- живых соперников, прежде чем повторить любого. Приоритет выбора пары:
--   1. УНИКАЛЬНОСТЬ (жёстко): только пары, ещё не встречавшиеся в текущем круге.
--   2. РОВНАЯ ЧАСТОТА: среди них — минимальная сумма проведённых дуэлей игроков.
--   3. КТО ДОЛЬШЕ ЖДАЛ: при равенстве — макс. суммарный «простой» (давно не дрался).
--   4. Полная ничья -> случайно.
-- Круг пройден (все живые пары сыграны) -> сброс, новый круг. При смерти игрока
-- круг просто продолжается на живых — старый алгоритм тут раскалывал лобби на две
-- четвёрки, которые не пересекались (разбор: [[Duel Matchmaking]] A63).
function Rounds:GetRandomPVPPair(Teams)
    if not Teams or #Teams < 2 then return end

    self.DuelSeq = (self.DuelSeq or 0) + 1
    self.DuelCount = self.DuelCount or {}             -- всего дуэлей игрока за игру (ровная частота)
    self.DuelPairLastSeq = self.DuelPairLastSeq or {} -- seq последней встречи ПАРЫ (тайбрейк: давность пары)
    self.DuelCycleMet = self.DuelCycleMet or {}       -- [t] = { [opp]=true } — с кем дрался в этом круге
    local seq = self.DuelSeq
    local n = #Teams
    local HUGE = 1000000

    local function met(a, b)
        local s = self.DuelCycleMet[a]
        return s ~= nil and s[b] == true
    end

    -- Пары среди живых, ещё не встречавшиеся в текущем круге.
    local function buildUnmet()
        local out = {}
        for i = 1, n do
            for j = i + 1, n do
                local a, b = Teams[i], Teams[j]
                if not met(a, b) then out[#out + 1] = { a, b } end
            end
        end
        return out
    end

    local cand = buildUnmet()
    if #cand == 0 then
        -- Круг пройден на текущем ростере -> сброс встреч живых, начинаем новый круг.
        for _, t in ipairs(Teams) do self.DuelCycleMet[t] = {} end
        for i = 1, n do
            for j = i + 1, n do cand[#cand + 1] = { Teams[i], Teams[j] } end
        end
    end

    local function duels(t) return self.DuelCount[t] or 0 end
    -- Давность пары: сколько дуэлей назад ЭТА пара встречалась (ещё не встречались -> «бесконечно»).
    local function pairAge(a, b) return seq - (self.DuelPairLastSeq[MakeKey(a, b)] or -HUGE) end

    -- (1) мин сумма дуэлей (ровная частота) -> (2) макс давность ПАРЫ (кто дольше всех не
    -- встречался; сглаживает стык кругов — хвостовая четвёрка не повторяется в начале
    -- следующего круга, как было по «простою игроков») -> (3) random.
    local best, bestDuel, bestAge
    for _, p in ipairs(cand) do
        local d = duels(p[1]) + duels(p[2])
        local age = pairAge(p[1], p[2])
        local replace
        if best == nil then
            replace = true
        elseif d < bestDuel then
            replace = true
        elseif d == bestDuel and age > bestAge then
            replace = true
        elseif d == bestDuel and age == bestAge then
            replace = self.RandomStream and self.RandomStream:RandomInt(0, 1) == 1
        else
            replace = false
        end
        if replace then best = p; bestDuel = d; bestAge = age end
    end

    local a, b = best[1], best[2]
    self.DuelCycleMet[a] = self.DuelCycleMet[a] or {}
    self.DuelCycleMet[b] = self.DuelCycleMet[b] or {}
    self.DuelCycleMet[a][b] = true
    self.DuelCycleMet[b][a] = true
    self.DuelCount[a] = duels(a) + 1
    self.DuelCount[b] = duels(b) + 1
    self.DuelPairLastSeq[MakeKey(a, b)] = seq

    return { a, b }
end

function Rounds:ShuffleAndGetRandomPVPPair()
    -- Если пар нет, то ничего не выбираем
    if not self.PVPPairs or #self.PVPPairs == 0 then
        return
    end

    -- Сортируем по числу сражений пар
    table.sort(self.PVPPairs, function(a, b) return a.Joins < b.Joins end)

    DeepPrintTable(self.PVPPairs)

    local ResultPairKey = nil

    -- Если пары до этого перебора нет - берём любую случайную пару
    local LastPair = self.PVPPairsHistory.lastPair
    if LastPair == nil then
        ResultPairKey = table.random_key(self.PVPPairs)
    else
        -- Если есть позапрошлая катка, то сначала ищем идеальные пары - которые не учавствовали в предыдущих двуъ сражениях
        local PreLastPair = self.PVPPairsHistory.preLastPair
        if PreLastPair ~= nil then
            for _, PairInfo in ipairs(self.PVPPairs) do
                local fTeamLastJoined = PairInfo.fTeam == LastPair.fTeam or PairInfo.fTeam == LastPair.sTeam
                local sTeamLastJoined = PairInfo.sTeam == LastPair.fTeam or PairInfo.sTeam == LastPair.sTeam

                local fTeamPreLastJoined = PairInfo.fTeam == PreLastPair.fTeam or PairInfo.fTeam == PreLastPair.sTeam
                local sTeamPreLastJoined = PairInfo.sTeam == PreLastPair.fTeam or PairInfo.sTeam == PreLastPair.sTeam

                if not fTeamLastJoined and not sTeamLastJoined and not fTeamPreLastJoined and not sTeamPreLastJoined then
                    ResultPairKey = _
                    break
                end
            end
        end

        -- Потом ищем идеальные пары - которые не учавствовали в предыдущем сражении
        if ResultPairKey == nil then
            for _, PairInfo in ipairs(self.PVPPairs) do
                local fTeamLastJoined = PairInfo.fTeam == LastPair.fTeam or PairInfo.fTeam == LastPair.sTeam
                local sTeamLastJoined = PairInfo.sTeam == LastPair.fTeam or PairInfo.sTeam == LastPair.sTeam

                if not fTeamLastJoined and not sTeamLastJoined then
                    ResultPairKey = _
                    break
                end
            end
        end

        -- А потом уже выбираем лучшую по Joins
        if ResultPairKey == nil then
            ResultPairKey = 1
        end
    end

    local ResultPair = self.PVPPairs[ResultPairKey]

    return ResultPair, ResultPairKey
end

function Rounds:ClearTeamPVPPairs(TeamID)
    self.PVPPairs = ArrayRemove(self.PVPPairs, function(t, i, j)
        local PairInfo = t[i]
        return not (TeamID == PairInfo.fTeam or TeamID == PairInfo.sTeam)
    end)
end

function Rounds:EndPVPPair(LoserTeamID, bFast)
    if self.PVPPairsHistory.currentPair == nil or self:IsPvpPairEnded() then return end

    local CurrentRound = self.CurrentRound
    local MaxTeamsInRound = self.CurrentRoundInfo.max_teams

    local fTeam = self.PVPPairsHistory.currentPair.fTeam
    local sTeam = self.PVPPairsHistory.currentPair.sTeam

    -- [дуэлянты] Запись пары для БД/сайта: раунд, оба SteamAccountID, победитель.
    -- Здесь известны и пара (currentPair), и проигравший (LoserTeamID) -> один раз на дуэль.
    do
        local fPID = Players:GetTeamPlayerByNum(fTeam, 1)
        local sPID = Players:GetTeamPlayerByNum(sTeam, 1)
        local fSteam = fPID and PlayerResource:GetSteamAccountID(fPID) or 0
        local sSteam = sPID and PlayerResource:GetSteamAccountID(sPID) or 0
        local winnerTeam = (LoserTeamID == fTeam) and sTeam or fTeam
        local winnerSteam = (winnerTeam == fTeam) and fSteam or sSteam
        table.insert(self.DuelLog, { round = CurrentRound, a = fSteam, b = sSteam, winner = winnerSteam })
    end

    if bFast then
        self:CalculateBets()

        -- local PairPlayers = {}
        -- local SpecialBetMap = {}

        -- SpecialBetMap[self.PVPPairsHistory.currentPair.fTeam] = {}
        -- SpecialBetMap[self.PVPPairsHistory.currentPair.sTeam] = {}

        -- local Teams = {self.PVPPairsHistory.currentPair.fTeam, self.PVPPairsHistory.currentPair.sTeam}

        -- for _, TeamID in ipairs(Teams) do
        --     for _, PlayerID in ipairs(Players:GetTeamActivePlayers(TeamID, true)) do
        --         table.insert(PairPlayers, {
        --             playerID = PlayerID,
        --             teamID = TeamID
        --         })
        --     end
        -- end

        -- for PlayerID, BetInfo in pairs(self.CurrentRoundInfo.bets) do
        --     table.insert(SpecialBetMap[BetInfo.team], {
        --         nPlayerId = PlayerID,
        --         nValue = BetInfo.value,
        --         sType = BetInfo.bet_type,
        --         flRatio = BetInfo.ratio
        --     })
        -- end

        -- for _, PlayerID in ipairs(Players:GetAllPlayers(true)) do
        --     local hPlayer = PlayerResource:GetPlayer(PlayerID)
        --     if hPlayer then
        --         CustomGameEventManager:Send_ServerToPlayer(hPlayer, "HidePvpBet", {})
        --     end

        --     if not self:IsPlayerInPVPDuel(PlayerID) then
        --         CustomGameEventManager:Send_ServerToPlayer(hPlayer, "ShowPvpBrief", {
        --             players = PairPlayers, 
        --             firstTeamId = self.PVPPairsHistory.currentPair.fTeam, 
        --             secondTeamId = self.PVPPairsHistory.currentPair.sTeam, 
        --             betMap = SpecialBetMap, 
        --             bonusPool = math.floor(self.CurrentRoundInfo.bet_bonus)
        --         })
        --     end
        -- end
    end

    local WinnerTeamID = self:GetPairOpponent(LoserTeamID)

    if bFast then
        self.PVPPairsHistory.currentPair = nil
    end

    self.PvpPairEnded = true

    -- if self.CurrentRoundInfo and self.CurrentRoundInfo.duel_arena ~= nil then
    --     local info = Map:GetArenaInfo(self.CurrentRoundInfo.duel_arena)
    --     if info then
    --         Players:KillSummonedCreatureAsyn(info.center)
    --     end
    -- end

    local Teams = {WinnerTeamID, LoserTeamID}

    for _, TeamID in ipairs(Teams) do
        local bIsWinner = TeamID == WinnerTeamID

        for PlayerID, PlayerInfo in pairs(Players:GetTeamActivePlayers(TeamID)) do
            local hHero = PlayerInfo.hero
            if Players:IsValidHero(hHero) then
                if hHero:IsAlive() then
                    hHero:RemoveModifierByName("modifier_razor_static_link")
                    ProjectileManager:ProjectileDodge(hHero)
                    hHero:AddNewModifier(hHero, nil, "modifier_hero_refreshing", {})

                    hHero:SetHealth(hHero:GetMaxHealth())
                    hHero:SetMana(hHero:GetMaxMana())

                    hHero:AddNewModifier(hHero, nil, "modifier_duel_teleporting_2", {duration = 0.6})
                end
                hHero:SetContextThink(DoUniqueString("HeroPVPEndedDelay"), function()
                    if Players:IsValidHero(hHero) then
                        if not hHero:IsAlive() then
                            local Origin = hHero:GetAbsOrigin()
                            hHero:RespawnHero(false, false)
                            hHero:SetAbsOrigin(Origin)
                        end

                        hHero:SetHealth(hHero:GetMaxHealth())
                        hHero:SetMana(hHero:GetMaxMana())

                        if GameRules.xpTable[self.CurrentRound+1] and GameRules.xpTable[self.CurrentRound] then
                            local nExp = math.floor((GameRules.xpTable[self.CurrentRound+1] - GameRules.xpTable[self.CurrentRound]) * 0.7)
                            hHero:AddExperience(nExp, 0, false, false)
                        end

                        if bIsWinner then
                            ParticleManager:ReleaseParticleIndex(ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf", PATTACH_OVERHEAD_FOLLOW, hHero))
                            EmitSoundOn("Hero_LegionCommander.Duel.Victory", hHero)
                            
                            hHero:SetContextThink(DoUniqueString("HeroPVPEndedWinSound"), function()
                                if Players:IsValidHero(hHero) then
                                    if HEROES_PVP_WIN_SOUNDS[hHero:GetUnitName()]~=nil then
                                        EmitGlobalSound(HEROES_PVP_WIN_SOUNDS[hHero:GetUnitName()])
                                    end
                                end
                            end, 2)
                        end

                        if not bFast then
                            hHero:AddNewModifier(hHero, nil, "modifier_duel_teleporting", {duration = 1})
                        end

                        hHero:RemoveModifierByName("modifier_razor_static_link")
                        ProjectileManager:ProjectileDodge(hHero)
                        hHero:AddNewModifier(hHero, nil, "modifier_hero_refreshing", {})

                        local Delay = 1
                        if bFast then
                            Delay = 0.1
                        end

                        hHero:SetContextThink(DoUniqueString("HeroPVPEnded"), function()
                            if Players:IsValidHero(hHero) then
                                Players:UpdateArena(PlayerID, "MAIN", nil, nil, true)
                                self:EndTeam(TeamID)

                                hHero:SetHealth(hHero:GetMaxHealth())
                                hHero:SetMana(hHero:GetMaxMana())

                                -- A8: волна потери аегиса строго из настроек (штраф −5 за недостающих игроков убран)
                                local RoundWhenLoseAegis = GetGameSetting("ROUND_WHEN_LOSE_AEGIS")

                                if not bIsWinner and CurrentRound >= RoundWhenLoseAegis then
                                    self:PunishPVPPairLoser(PlayerID)
                                end
                            end
                        end, Delay)

                        local ignores_mods =
                        {
                            ["modifier_elder_titan_ancestral_spirit"] = true,
                            ["modifier_elder_titan_ancestral_spirit_buff"] = true,
                            ["modifier_elder_titan_ancestral_spirit_cast_time"] = true,
                            ["modifier_elder_titan_ancestral_spirit_hidden"] = true,
                        }
                        for _, modifier in pairs( hHero:FindAllModifiers() ) do
                            if modifier and modifier:GetCaster() ~= hHero and modifier:IsDebuff() and not ignores_mods[modifier:GetName()] then
                                modifier:Destroy()
                            end
                        end

                        hHero:Purge(false, true, false, true, true)
                    end
                end, 0.5)

                if bIsWinner then
                    PlayerInfo.pvp_wins = PlayerInfo.pvp_wins + 1
                else
                    PlayerInfo.pvp_loses = PlayerInfo.pvp_loses + 1

                    if self:IsLastDuelActive() then
                        local MultNum = self.CurrentRound
                        if MultNum > 65 then
                            MultNum = 65
                        end

                        local Bonus = math.ceil(300 * math.pow(1.031, MultNum))

                        if Bonus > 0 then
                            Players:ModifyPlayerGold(PlayerID, Bonus, true, true, true)
                        end
                    end


                    Players:UpdatePlayerNetTable(PlayerID)
                end
            end
        end
    end

    if not self:IsLastDuelActive() then
        local i = 0
        for PlayerID, BetInfo in pairs(self.CurrentRoundInfo.bets) do
            local PlayerInfo = Players:GetPlayer(PlayerID)
            local hHero = PlayerInfo.hero
            if PlayerInfo and Players:IsValidHero(hHero) then
                if BetInfo.team == WinnerTeamID then
                    if BetInfo.ratio ~= nil then
                        local Gold = math.floor(self.CurrentRoundInfo.bet_bonus * BetInfo.ratio)
                        local data = {}
                        data.type = "bet_win"

                        local NotificationType = NOTIFICATION_TYPE.BET_WIN
                        if BetInfo.bet_type and BetInfo.bet_type == "free" then
                            NotificationType = NOTIFICATION_TYPE.BET_WIN_SELF
                            if BetInfo.ratio >= 0.99 then
                                data.type = "bet_jackpot"
                            else
                                data.type = "pvp_win"
                                Gold = Gold + math.floor(self.CurrentRoundInfo.bet_bonus*0.20)
                            end

                            local fx1 = ParticleManager:CreateParticle("particles/econ/events/ti6/teleport_start_ti6.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, hHero)
                            ParticleManager:SetParticleControlEnt(fx1, 0, hHero, PATTACH_POINT_FOLLOW, "attach_hitloc", hHero:GetOrigin(), true)
                            local fx2 = ParticleManager:CreateParticle("particles/econ/events/ti6/teleport_start_ti6_lvl3_rays.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, hHero)
                            ParticleManager:SetParticleControlEnt(fx2, 0, hHero, PATTACH_POINT_FOLLOW, "attach_hitloc", hHero:GetOrigin(), true)
                            ParticleManager:DestroyParticle(fx1, false)
                            ParticleManager:DestroyParticle(fx2, false)
                            ParticleManager:ReleaseParticleIndex(fx1)
                            ParticleManager:ReleaseParticleIndex(fx2)
                        else
                            ParticleManager:ReleaseParticleIndex(ParticleManager:CreateParticle("particles/econ/items/ogre_magi/ogre_magi_jackpot/ogre_magi_jackpot_spindle_rig.vpcf", PATTACH_OVERHEAD_FOLLOW, hHero))
                        end

                        local ResultGold = Players:ModifyPlayerGold(PlayerID, Gold, true, true, true)

                        data.playerId = PlayerID
                        data.gold_value = ResultGold

                        Notifications:AddNotification(NotificationType, CurrentRound, {
                            player1 = data.playerId,
                            gold1 = data.gold_value
                        })

                        Timers:CreateTimer(i*0.3, function()
                            Barrage:FireBullet(data)
                        end)

                        i = i + 1

                        PlayerInfo.bet_rewards = PlayerInfo.bet_rewards + ResultGold

                        self:BetRecordInHistory(PlayerID, ResultGold-BetInfo.value, WinnerTeamID, LoserTeamID, BetInfo.team, fTeam, sTeam)
                    end
                else
                    if BetInfo.ratio ~= nil then
                        self:BetRecordInHistory(PlayerID, -BetInfo.value, WinnerTeamID, LoserTeamID, BetInfo.team, fTeam, sTeam)
                    end
                end
            end
        end
    else
        Players:UpdateLastDuelScore(WinnerTeamID)
    end

    -- Timers:CreateTimer(0.25, function()
    --     CustomGameEventManager:Send_ServerToAllClients("TeamWin",{winnerTeamID=WinnerTeamID,loserTeamID=LoserTeamID} );
    --     CustomGameEventManager:Send_ServerToAllClients("CloseTopInfo",{} );
    -- end)

    if self.CurrentRoundInfo and self.CurrentRoundInfo.bet_info then
        self.CurrentRoundInfo.bet_info.winner = WinnerTeamID
        self.CurrentRoundInfo.bet_info.state = "FINISHED"
        PlayerTables:SetTableValue("globals", "duel_info", self.CurrentRoundInfo.bet_info)
    end
end

function Rounds:BetRecordInHistory(PlayerID, BetValue, WinnerTeamID, LoserTeamID, BettedToTeam, fTeam, sTeam)
    local PlayerInfo = Players:GetPlayer(PlayerID)

    if PlayerInfo == nil then return end

    local data = {
        winner_team = WinnerTeamID,
        loser_team = LoserTeamID,
        bets = {},
        value = BetValue,
        round = self:GetCurrentRound(),
        betted_team = BettedToTeam,
        fTeam = fTeam,
        sTeam = sTeam
    }

    for PlayerID, BetInfo in pairs(self.CurrentRoundInfo.bets) do
        table.insert(data.bets, {PlayerID = PlayerID, TeamID = Players:GetPlayerTeamNumber(PlayerID)})
    end

    if GAME_BETS_HISTORY_ENABLED then
        table.insert(PlayerInfo.bet_history, data)
    end

    Players:UpdatePlayerNetTable(PlayerID)

    local hPlayer = PlayerResource:GetPlayer(PlayerID)
    if hPlayer and Server:IsPlayerAutoOpenBetHistoryEnabled(PlayerID) then
        CustomGameEventManager:Send_ServerToPlayer(hPlayer, "AUTO_OPEN_BET_HISTORY", {})
    end
end

function Rounds:PunishPVPPairLoser(PlayerID)
    local PlayerInfo = Players:GetPlayer(PlayerID)
    local Hero = PlayerInfo.hero
    if PlayerInfo and Players:IsValidHero(Hero) then
        local fx = ParticleManager:CreateParticle("particles/econ/items/necrolyte/necro_sullen_harvest/necro_ti7_immortal_scythe_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, Hero)
        ParticleManager:SetParticleControl(fx, 0, Hero:GetAbsOrigin())
        ParticleManager:SetParticleControl(fx, 1, Hero:GetAbsOrigin())
        ParticleManager:SetParticleControlEnt(fx, 0, Hero, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Hero:GetAbsOrigin(), true)
        ParticleManager:SetParticleControlEnt(fx, 1, Hero, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Hero:GetAbsOrigin(), true)
        ParticleManager:ReleaseParticleIndex(fx)

        local hAegis = Hero:FindModifierByName("modifier_aegis")
        if hAegis and hAegis:GetStackCount() > 0 then
            local data={}
            data.type = "pvp_lose_aegis"
            data.playerId = PlayerID
            Barrage:FireBullet(data)
            HeroBuilder:UpdatePlayerLifesCount(PlayerID, -1, "add")
        else
            local data={}
            data.type = "pvp_stack_curse"
            data.playerId = PlayerID
            Barrage:FireBullet(data)

            local hDebuff = Hero:FindModifierByName("modifier_loser_curse")
            if hDebuff == nil then
                hDebuff = Hero:AddNewModifier(Hero, curse_ability, "modifier_loser_curse", {})
                if hDebuff ~= nil then
                    hDebuff:SetStackCount(0)
                end
            end
            if hDebuff ~= nil then
                hDebuff:SetStackCount(hDebuff:GetStackCount() + 1)
            end
        end
    end
end

function Rounds:OnPlayerConfirmBet(event)
    if self.CurrentRoundInfo == nil or self.CurrentRoundInfo.bets == nil or self.CurrentRoundInfo.bet_info == nil then return end

    local PlayerID = event.PlayerID
    local BetSum = event.value
    local BetTeamID = event.wish_team_id

    if PlayerID == nil or 
        BetSum == nil or 
        type(BetSum) ~= "number" or 
        self.CurrentState ~= GAME_STATES.PREPARING or 
        not Players:IsActivePlayer(PlayerID) or 
        BetSum <= 0 or 
    self.CurrentRoundInfo.bets[PlayerID] ~= nil then return end

    local PlayerInfo = Players:GetPlayer(PlayerID)

    if not PlayerInfo or PlayerInfo.team == BetTeamID or self.CurrentRoundInfo.bet_info.fTeamID == PlayerInfo.team or self.CurrentRoundInfo.bet_info.sTeamID == PlayerInfo.team then return end

    local hHero = PlayerInfo.hero
    if not Players:IsValidHero(hHero) then
        return
    end

    BetSum = math.floor(BetSum)

    local MaxGold = math.floor(PlayerResource:GetGold(PlayerID)/2)

    if BetSum > MaxGold then
        BetSum = MaxGold
    end

    self.CurrentRoundInfo.bets[PlayerID] = {
        value = BetSum,
        team = BetTeamID,
    }

    self.CurrentRoundInfo.bet_info.bets[PlayerID] = {
        value = BetSum,
        team = BetTeamID,
    }

    PlayerTables:SetTableValue("globals", "duel_info", self.CurrentRoundInfo.bet_info)

    hHero:SpendGold(BetSum, DOTA_ModifyGold_Unspecified)
    hHero:EmitSound("DOTA_Item.Hand_Of_Midas")
    local particle = ParticleManager:CreateParticle("particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_midas_coinshower.vpcf", PATTACH_ABSORIGIN, hHero)
    ParticleManager:ReleaseParticleIndex(particle)
end

function Rounds:OnDuelNotificationClosed(event)
    local PlayerID = event.PlayerID

    -- SECURITY/robustness: пишем неттейбл только для валидного игрока (event.PlayerID
    -- инжектится движком = отправитель). Отсекает запись по nil/-1 ключу.
    if not PlayerResource:IsValidPlayerID(PlayerID) then return end

    CustomNetTables:SetTableValue("players", "player_" .. PlayerID .. "_duel_info", {
        bCanBeShowed = false,
        LastTime = 0,
        EnemyPlayerID = PlayerID,
    })
end

function Rounds:CalculateBets()
    if self.PVPPairsHistory.currentPair == nil or self.CurrentRoundInfo == nil or self.CurrentRoundInfo.bets == nil or self.CurrentState ~= GAME_STATES.PREPARING then return end
    
    local Teams = {self.PVPPairsHistory.currentPair.fTeam, self.PVPPairsHistory.currentPair.sTeam}
    local TeamsSum = {0,0}
    for _, TeamID in ipairs(Teams) do
        for PlayerID, BetInfo in pairs(self.CurrentRoundInfo.bets) do
            if BetInfo.team == TeamID then
                TeamsSum[_] = TeamsSum[_] + BetInfo.value
            end
        end

        self.CurrentRoundInfo.bet_bonus = self.CurrentRoundInfo.bet_bonus + TeamsSum[_]

        local fTeamPlayersID = Players:GetTeamPlayerByNum(TeamID, 1)
        if fTeamPlayersID ~= nil then
            local data={}
            data.type = "bet_summary_solo"
            data.playerId = fTeamPlayersID
            data.gold_value = TeamsSum[_]
            Barrage:FireBullet(data, self:GetCurrentPairPlayers())
        end
    end
    
    for _, TeamID in ipairs(Teams) do
        for _PlayerNum, PlayerID in ipairs(Players:GetTeamPlayers(TeamID, true)) do
            local Gold = math.floor(self.CurrentRoundInfo.bet_bonus*0.05)
            self.CurrentRoundInfo.bets[PlayerID] = {
                value = Gold,
                team = TeamID,
                bet_type = "free",
            }

            self.CurrentRoundInfo.bet_info.bets[PlayerID] = {
                value = Gold,
                team = TeamID,
            }

            TeamsSum[_] = TeamsSum[_] + Gold
            self.CurrentRoundInfo.bet_bonus = self.CurrentRoundInfo.bet_bonus + Gold
        end

        for PlayerID, BetInfo in pairs(self.CurrentRoundInfo.bets) do
            if BetInfo.team == TeamID then
                self.CurrentRoundInfo.bets[PlayerID].ratio = BetInfo.value/TeamsSum[_]
            end
        end
    end

    self.CurrentRoundInfo.bet_info.BetJackpot = self.CurrentRoundInfo.bet_bonus
    PlayerTables:SetTableValue("globals", "duel_info", self.CurrentRoundInfo.bet_info)
end

function Rounds:AddExtraCreep(PlayerID, UnitName)
    local PlayerInfo = Players:GetPlayer(PlayerID)

    if PlayerInfo == nil then return false end

    local Team = PlayerInfo.team

    if self.ExtraCreepsData[Team] == nil then
        self.ExtraCreepsData[Team] = {}
    end

    local UnitCountInTeam = 0
    for _, UnitInfo in ipairs(self.ExtraCreepsData[Team]) do
        if UnitInfo.name == UnitName then
            UnitCountInTeam = UnitCountInTeam + 1
        end
    end

    if UnitCountInTeam >= 2 then
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(PlayerID), "CreateIngameErrorMessage", {message = "#cha_data_error_most_have_creep"})
        return false
    end

    table.insert(self.ExtraCreepsData[Team], {
        name = UnitName,
        round = self:GetCurrentRound(),
        player_id = PlayerID
    })

    CustomGameEventManager:Send_ServerToAllClients("ExtraCreatureAdded",{creatureName=UnitName, caller = PlayerID})

    local vData={}
    vData.type = "add_extra_creature"
    vData.playerId = PlayerID
    vData.creatureName = UnitName
    Barrage:FireBullet(vData)

    HeroBuilder:OnPlayerAddedExtraCreep(PlayerID, UnitName, self:GetCurrentRound())

    Util:RecordConsumableItem(PlayerID, "item_extra_creature_"..string.sub(UnitName,10,string.len(UnitName)))

    if UnitName == "npc_dota_warpine_cone_custom" then
        Util:RecordCreepLaunch(PlayerID, "item_extra_creature_warpine")
    else
        Util:RecordCreepLaunch(PlayerID, "item_extra_creature_"..string.sub(UnitName,10,string.len(UnitName)))
    end

    Notifications:AddNotification(NOTIFICATION_TYPE.CREEP_SENDED, self:GetCurrentRound(), {
        creep1 = UnitName,
        player1 = PlayerID,
    })

    return true
end

function Rounds:GetExtraCreepsForTeam(TeamID)
    local Creeps = {}
    for ExtraTeamID, CreepsList in pairs(self.ExtraCreepsData) do
        if ExtraTeamID ~= TeamID then
            for _, ExtraCreepInfo in ipairs(CreepsList) do
                if self:IsThisExtraCreepCanBeLive(ExtraCreepInfo.player_id, ExtraCreepInfo.round) then
                    table.insert(Creeps, ExtraCreepInfo)
                end
            end
        end
    end

    return Creeps
end

function Rounds:KillAllExtraCreepsByPlayerID(PlayerID)
    local PlayerInfo = Server:GetPlayerInfo(PlayerID)

    if not Players:IsActivePlayer(PlayerID) and PlayerInfo and PlayerInfo.player_die_round ~= nil and self.CurrentRoundInfo and self.CurrentRoundInfo.controller then
        self.CurrentRoundInfo.controller:KillAllExtraCreeepsByPlayerID(PlayerID)
    end
end

function Rounds:IsThisExtraCreepCanBeLive(PlayerID, Round)
    local PlayerInfo = Server:GetPlayerInfo(PlayerID)

    if PlayerInfo == nil then return true end

    if not Players:IsActivePlayer(PlayerID) and PlayerInfo.player_die_round ~= nil and math.abs(PlayerInfo.player_die_round - Round) <= 3 then
        return false
    end

    return true
end

function Rounds:OnPlayerReady(event)
    if self.CurrentRoundInfo == nil then return end
    if self.CurrentState ~= GAME_STATES.PREPARING then return end

    local PlayerID = event.PlayerID

    if not Players:IsActivePlayer(PlayerID) then return end

    if self.PrepareReadyList[PlayerID] ~= nil and not IsCheatsEnabled() then return end

    if self.PrepareReadyList[PlayerID] == nil then
        self.PrepareReadyList[PlayerID] = true
    elseif IsCheatsEnabled() then
        self.PrepareReadyList[PlayerID] = nil
    end

    local AllReady = true
    for _, TeamID in ipairs(self.CurrentRoundInfo.teams) do
        if Players:IsActiveTeam(TeamID) then
            for _, TeamPlayerID in ipairs(Players:GetTeamActivePlayers(TeamID, true)) do
                if self.PrepareReadyList[TeamPlayerID] == nil then
                    AllReady = false
                end
            end
        end
    end

    if IsCheatsEnabled() and self.PrepareReadyList[PlayerID] == true then
        AllReady = true
    end

    if AllReady then
        if self.CurrentRoundInfo.controller then
            self.CurrentRoundInfo.controller:SetTimeToAll(GameRules:GetGameTime() + 5)
        end

        GameRules:GetGameModeEntity():StopThink("GAME_ROUND_BEGIN_TIMER")

        GameRules:GetGameModeEntity():SetThink("BeginRound", self, "GAME_ROUND_BEGIN_TIMER", 5)

        if self.AlreadyAllPrepared == false then
            self.AlreadyAllPrepared = true
            if self.CurrentRoundInfo.info.type == ROUND_TYPES.VOTING and self.CurrentRoundInfo.game_mode_selected == false then
                GameRules:GetGameModeEntity():StopThink("GAME_ROUND_VOTING")
                Rounds:RoundVoting()
            end
        end
    elseif IsCheatsEnabled() then
        if self.CurrentRoundInfo.controller then
            self.CurrentRoundInfo.controller:SetTimeToAll(GameRules:GetGameTime() + self.CurrentRoundInfo.prepare_time)
        end

        GameRules:GetGameModeEntity():StopThink("GAME_ROUND_BEGIN_TIMER")
        GameRules:GetGameModeEntity():SetThink("BeginRound", self, "GAME_ROUND_BEGIN_TIMER", self.CurrentRoundInfo.prepare_time)
    end

    CustomGameEventManager:Send_ServerToAllClients("UpdatePlayerReadyList", { readyPlayers = self.PrepareReadyList })

    -- CustomNetTables:SetTableValue("globals", "round_info", self.CurrentRoundInfo.panorama_info)
    PlayerTables:SetTableValue("round_info", "round_info", self.CurrentRoundInfo.panorama_info)
end

function Rounds:UpdateDynamicSettings()
    local PrevData = CustomNetTables:GetTableValue("globals", "dynamic_settings_values")
    local DynamicSettingsTable = {
        aegis = 0,
        creeps = 0,
        magical_resist = 0,
        physical_resist = 0,
    }
    -- A8 (реворк): аегисы теряются строго с волны из настроек (деф. 70) — штраф −5 за
    -- выбывших/недостающих игроков УБРАН везде; неполные лобби играют по той же волне.
    -- Другую волну можно выбрать только кастомной настройкой (GetGameSetting её учитывает).
    local RoundWhenLoseAegis = GetGameSetting("ROUND_WHEN_LOSE_AEGIS")
    if PrevData and PrevData.aegis and self:GetCurrentRound() >= PrevData.aegis then
        RoundWhenLoseAegis = PrevData.aegis
    end
    DynamicSettingsTable["aegis"] = RoundWhenLoseAegis
    DynamicSettingsTable["creeps"] = GetGameSetting("ROUND_WHEN_CAN_SUMMON_CREEPS")
    DynamicSettingsTable["magical_resist"] = GetGameSetting("CREEP_BONUS_MAGIC_RESISTANCE_PER_LATE_ROUND") * math.max(0, self:GetCurrentRound() - 50)
    DynamicSettingsTable["physical_resist"] = GetGameSetting("CREEP_BONUS_ARMOR_PER_LATE_ROUND") * math.max(0, self:GetCurrentRound()-50)

    CustomNetTables:SetTableValue("globals", "dynamic_settings_values", DynamicSettingsTable)
end

function Rounds:GetPairOpponent(TeamID)
    local Pair = self.PVPPairsHistory.currentPair

    if Pair == nil then return end

    local Opponent = nil
    if Pair.fTeam == TeamID then
        Opponent = Pair.sTeam
    elseif Pair.sTeam == TeamID then
        Opponent = Pair.fTeam
    end

    return Opponent
end

-- Список игроков, учавствовующих в текущей дуэли
function Rounds:GetCurrentPairPlayers()
    local PlayersList = {}

    local Pair = self.PVPPairsHistory.currentPair

    if Pair == nil then return PlayersList end

    local fTeamPlayers = Players:GetTeamActivePlayers(Pair.fTeam, true)
    local sTeamPlayers = Players:GetTeamActivePlayers(Pair.sTeam, true)

    PlayersList = table.join(fTeamPlayers, sTeamPlayers)

    return PlayersList
end

function Rounds:IsPlayerInPVPDuel(PlayerID)
    if self.PVPPairsHistory.currentPair ~= nil then
        local PlayerInfo = Players:GetPlayer(PlayerID)
        if PlayerInfo and (PlayerInfo.team == self.PVPPairsHistory.currentPair.fTeam or PlayerInfo.team == self.PVPPairsHistory.currentPair.sTeam) then
            return true
        end
    end

    return false
end

function Rounds:IsTeamInPVPDuel(TeamID)
    if self.PVPPairsHistory.currentPair ~= nil then
        if TeamID == self.PVPPairsHistory.currentPair.fTeam or TeamID == self.PVPPairsHistory.currentPair.sTeam then
            return true
        end
    end

    return false
end

function Rounds:IsLastDuelActive()
    return self.LastDuelState == "ACTIVATED"
end

function Rounds:GetCurrentState()
    return self.CurrentState
end

function Rounds:GetCurrentRound()
    return self.CurrentRound
end

function Rounds:GetRoundGroup(roundNum)
    for groupId, groupInfo in pairs(GAME_ROUND_GROUPS) do
        if roundNum >= groupInfo.min_round and roundNum < groupInfo.max_round then
            return groupId, groupInfo
        end
    end
    return nil, nil
end

-- RoundSpawnGroups — map по handle (id), не array. Дедупликация:
-- повторное добавление того же id обновляет/обогащает запись, но не
-- создаёт дубль. Это устраняет источник спама "no such spawn group"
-- (раньше один id мог попасть в массив 10+ раз и Unload вызывался столько же).
function Rounds:AddSpawnGroupToRound(spawngroup, unit_name, unit)
    if spawngroup == nil or spawngroup == 0 then return end

    -- Активную spawn group карты трогать нельзя
    if GetActiveSpawnGroupHandle ~= nil then
        local ok, activeHandle = pcall(GetActiveSpawnGroupHandle)
        if ok and activeHandle ~= nil and spawngroup == activeHandle then
            return
        end
    end

    -- npc_precache_<hero> — это хендлер из HeroBuilder, не наш
    if unit_name ~= nil and string.sub(unit_name, 1, 12) == "npc_precache" then
        return
    end

    local existing = self.RoundSpawnGroups[spawngroup]
    if existing then
        if existing.precache_unit_name == nil then existing.precache_unit_name = unit_name end
        if existing.unit == nil then existing.unit = unit end
        return
    end

    self.RoundSpawnGroups[spawngroup] = {
        spawngroup = spawngroup,
        precache_unit_name = unit_name,
        unit = unit,
    }
end

function Rounds:RemoveSpawnGroupFromRound(spawngroup)
    if spawngroup == nil then return end
    self.RoundSpawnGroups[spawngroup] = nil
end

function Rounds:ClearSpawnGroups()
    for _, GroupInfo in pairs(self.RoundSpawnGroups) do
        if GroupInfo.spawngroup ~= nil then
            if GroupInfo.unit ~= nil then
                UTIL_Remove(GroupInfo.unit)
            end

            SafeUnloadSpawnGroup(GroupInfo.spawngroup)
            if GroupInfo.precache_unit_name ~= nil then
                _G.PrecachedUnits[GroupInfo.precache_unit_name] = nil
            end
        end
    end

    self.RoundSpawnGroups = {}
end

function Rounds:GetRoundsInGroup(groupId)
    local groupInfo = GAME_ROUND_GROUPS[groupId]
    if not groupInfo then return {} end
    
    local rounds = {}
    for i = groupInfo.min_round, groupInfo.max_round-1 do
        if GAME_ROUNDS_LIST[i] and GAME_ROUNDS_LIST[i].type == ROUND_TYPES.BASIC then
            table.insert(rounds, i)
        end
    end

    return rounds
end

function Rounds:CanRoundHaveDuel(roundInfo)
    if not roundInfo then return false end
    
    if roundInfo.type == ROUND_TYPES.VOTING then
        return false
    end
    
    if roundInfo.creeps then
        for creepName, _ in pairs(roundInfo.creeps) do
            if creepName == "npc_dota_roshan" or creepName == "npc_dota_nian" then
                return false
            end
        end
    end
    
    return true
end

function Rounds:ShouldRoundHaveDuel(roundNum, roundInfo)
    if roundNum <= 1 then
        return false
    end
    
    if not self:CanRoundHaveDuel(roundInfo) then
        return false
    end
    
    local activePlayersCount = #Players:GetAllActivePlayers(true)
    
    if activePlayersCount > 4 then
        return true
    elseif activePlayersCount <= 4 then
        if self.LastDuelRound == 0 then
            return true
        end

        -- A25: при <=4 игроках дуэли идут через раунд (дуэль → обычный → дуэль).
        -- Кадэнс считаем по КОЛИЧЕСТВУ нормальных (не VOTING) раундов после прошлой
        -- дуэли, а не по разнице номеров раундов: иначе VOTING-раунд, попавший между
        -- дуэлями, ошибочно засчитывается как "пропущенный" раунд и дуэли идут подряд
        -- (дуэль → голосование → дуэль). VOTING сам по себе дуэль иметь не может
        -- (CanRoundHaveDuel), поэтому в кадэнс он не должен входить.
        local nonVotingRoundsSinceDuel = 0
        for r = self.LastDuelRound + 1, roundNum do
            local rInfo = self.RoundsByGroupsList[r]
            if not rInfo or rInfo.type ~= ROUND_TYPES.VOTING then
                nonVotingRoundsSinceDuel = nonVotingRoundsSinceDuel + 1
            end
        end

        if nonVotingRoundsSinceDuel >= 2 then
            return true
        end
    end

    return false
end

function Rounds:GetRoundInfo(RoundNum)
    if self.FixedRoundOverride then
        local fixedRound = self.FixedRoundOverride
        self.FixedRoundOverride = nil
        return GAME_ROUNDS_LIST[fixedRound]
    end
    
    local RoundInfo = self.RoundsByGroupsList[RoundNum]
    
    if RoundInfo then
        local dynamicRoundInfo = table.deepcopy(RoundInfo)
        
        local shouldHaveDuel = self:ShouldRoundHaveDuel(RoundNum, dynamicRoundInfo)
        dynamicRoundInfo.has_duel = shouldHaveDuel
        
        return dynamicRoundInfo
    end
    
    return RoundInfo
end

function Rounds:GetLastDuelInfo()
    return self.LastDuelInfo
end

function Rounds:GetGameState()
    return self.CurrentState
end

function Rounds:GetRoundTeams()
    if self.CurrentRoundInfo == nil or self.CurrentRoundInfo.teams == nil then return {} end
    return self.CurrentRoundInfo.teams
end

function Rounds:GetCurrentControllerInstance()
    if self.CurrentRoundInfo and self.CurrentRoundInfo.controller then
        return self.CurrentRoundInfo.controller.instanceID or ""
    end

    return ""
end

function Rounds:UpdateGameState(State)
    self.CurrentState = State

    if State == GAME_STATES.ENDED then
        self:EndRound()

        for _, PlayerID in ipairs(Players:GetAllActivePlayers(true)) do
            Players:UpdateArena(PlayerID, "MAIN", nil)
        end
    end
end

function Rounds:IsFinishedTeam(TeamID)
    if self.CurrentRoundInfo == nil or self.CurrentRoundInfo.teams == nil or #self.CurrentRoundInfo.teams == 0 then return true end
    return not table.contains(self.CurrentRoundInfo.teams, TeamID)
end

function Rounds:IsPvpPairEnded()
    return self.PvpPairEnded
end

function Rounds:StateIs(STATE)
    return self.CurrentState == STATE
end

function Rounds:RoundTypeIs(TYPE)
    if self.CurrentRoundInfo == nil or self.CurrentRoundInfo.info == nil or self.CurrentRoundInfo.info.type == nil then return false end
    return self.CurrentRoundInfo.info.type == TYPE
end

function Rounds:GetRandomSeed()
    return self.nSeed
end

function Rounds:GetTopTeamsByAvgDuration(Teams)
    local averages = {}
    local totalRounds = self.CurrentRound

    local Top = {}

    for _, TeamID in ipairs(Teams) do
        if not self:IsTeamInPVPDuel(TeamID) then
            table.insert(Top, TeamID)
            local sum, count = 0, 0
            for round = math.max(1, totalRounds - 4), totalRounds do
                local roundDurations = self.TeamsDefDurations[round]
                if roundDurations and roundDurations[TeamID] then
                    sum = sum + roundDurations[TeamID]
                    count = count + 1
                end
            end

            if count > 0 then
                averages[TeamID] = sum / count
            end
        end
    end

    table.sort(Top, function(a, b) return (averages[a] or 99999) < (averages[b] or 99999) end)

    return Top, averages
end

function Rounds:GetTeamDefDurationByRound(TeamID, RoundNum)
    if self.TeamsDefDurations ~= nil and self.TeamsDefDurations[RoundNum] ~= nil and self.TeamsDefDurations[RoundNum][TeamID] ~= nil then
        return self.TeamsDefDurations[RoundNum][TeamID]
    end

    return 0
end

function Rounds:GetTeamStartDelay(TeamID)
    if self.CurrentRoundInfo == nil or self.CurrentRoundInfo.teams_delay == nil or self.CurrentRoundInfo.teams_delay[TeamID] == nil or not self:IsQueueRound() then return 0 end
    return self.CurrentRoundInfo.teams_delay[TeamID]
end

function Rounds:IsBossRound(RoundNum)
    if RoundNum == nil then
        RoundNum = self.CurrentRound
    end

    local Info = self:GetRoundInfo(RoundNum)
    if Info then
        return Info.is_boss == true
    end

    return false
end

function Rounds:IsQueueRound(RoundNum)
    if RoundNum == nil then
        RoundNum = self.CurrentRound
    end
    return GAME_QUEUE_ROUNDS_ENABLED and RoundNum >= GetGameSetting("ROUND_WHEN_QUEUE_START") and not self:IsBossRound(RoundNum)
end

if not Rounds.bStarted then Rounds:Init() end