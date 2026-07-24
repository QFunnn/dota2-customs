--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--==============================================
-- Универсальный модуль игроков и команд
-- Создано Nears
--==============================================

Players = class({})

-- [A61] Вотчер NO_UNIT_COLLISION для ванильного полёта Winter Wyvern Arctic Burn (вешается в OnNPCSpawned).
LinkLuaModifier("modifier_arctic_burn_no_collision", "modifiers/modifier_arctic_burn_no_collision", LUA_MODIFIER_MOTION_NONE)

-- Локальный лог-хелпер для disconnect/реконнект-диагностики.
-- Все строки начинаются с `[HeroBuilder/Disc]`, чтобы grep'ом одной командой
-- собирать полную картину одного цикла теста из console.log.
local function DiscLog(fmt, ...)
    print("[HeroBuilder/Disc] " .. string.format(fmt, ...))
end

function Players:Init()
    print("[PLAYERS] Module loaded!")
    self.bStarted = false

    -- Стейт конца игры
    self.bGameEnded = false

    -- Список всех игроков
    self.Players = {}

    -- Список всех наблюдателей
    -- self.Spectators = {}

    -- Список всех команд
    self.Teams = {}

    -- Владелец текущей паузы
    self.PauseOwner = -1
    -- Последнее время, после которого каждый может отжать паузу
    self.UnpauseLastTime = 0
    --Следующий заряд паузы
    self.NextPauseChargeTime = 0
    -- Последнее время, после которого владелец паузы может отжать паузу
    self.AllUnpauseTime = 0
    -- Начался ли отсчёт конца паузы или нет
    self.UnpauseDelayStarted = false

    -- Функция регистрации команд
    self:RegisterTeams()

    self.Dump = {}

    --=======================================
    -- Подпись на эвенты
    --=======================================
    
    -- Полностью подключился игрок
    ListenToGameEvent('player_connect_full', Dynamic_Wrap(Players, 'OnPlayerConnected'), self)

    -- Подключился бот
    -- ListenToGameEvent('player_connect', Dynamic_Wrap(Players, 'OnBotConnected'), self) -- DEPRECATED

    -- Игрок отключился, но не до конца
    ListenToGameEvent('player_disconnect', Dynamic_Wrap( Players, 'OnPlayerDisconnected' ), self )

    -- Игрок вернулся в игру.
    -- В Dota Source 2 событий несколько имён: `player_reconnected` (с -ed) и `player_reconnect` (без -ed)
    -- + `player_connect_full` который тоже может фаерить при реконнекте.
    -- Слушаем все три, обработчик одинаковый -- идемпотентный (Reassign на уже-перехваченном hero no-op).
    ListenToGameEvent('player_reconnected', Dynamic_Wrap( Players, "OnPlayerReconnected"), self)
    ListenToGameEvent('player_reconnect',   Dynamic_Wrap( Players, "OnPlayerReconnected"), self)
    ListenToGameEvent('player_connect_full', Dynamic_Wrap( Players, "OnPlayerReconnected"), self)

    -- Заспавнился юнит
    ListenToGameEvent("npc_spawned", Dynamic_Wrap(Players, "OnNPCSpawned"), self)

    -- Смена стадии игры
    ListenToGameEvent("game_rules_state_change", Dynamic_Wrap( Players, 'OnGameRulesStateChange' ), self )

    CustomGameEventManager:RegisterListener("players_player_want_pause_game",function(source, event) self:OnPlayerWantPauseGame(event) end)

    CustomGameEventManager:RegisterListener("players_player_want_tip_player",function(source, event) self:OnPlayerWantTipPlayer(event) end)

    -- Создание юнита и таймера на нём
    self.TimerEnt = Entities:CreateByClassname("info_target")
    self.TimerEnt:SetThink("AbandonThink", self, "PLAYERS_THINK", PLAYERS_ABANDON_INTERVAL)

end

-- Отслеживание изменения стейтов игры
function Players:OnGameRulesStateChange()
    local State = GameRules:State_Get()

    if State == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        self.TimerEnt:SetThink("PauseThink", self, "PAUSE_THINK", PLAYERS_PAUSE_CHARGE_COOLDOWN)
        self.NextPauseChargeTime = GameRules:GetGameTime() + PLAYERS_PAUSE_CHARGE_COOLDOWN
    end
end

-- Каждый промежуток времени увеличивает кол-во зарядов пауз у всех активных игроков
function Players:PauseThink()
    for _, PlayerID in ipairs(self:GetAllActivePlayers(true)) do
        self:ModifyPauseCharges(PlayerID, PLAYERS_PAUSE_CHARGES_PER_COOLDOWN)
    end

    self.NextPauseChargeTime = GameRules:GetGameTime() + PLAYERS_PAUSE_CHARGE_COOLDOWN

    return PLAYERS_PAUSE_CHARGE_COOLDOWN
end

-- Регистрация команд
function Players:RegisterTeams()
    for _, TeamID in ipairs(TEAM_LIST) do

        -- Выставление максимального количества игроков в команде
        GameRules:SetCustomGameTeamMaxPlayers(TeamID, PLAYERS_PER_TEAM )

        -- Регистрация команды, выставление базовых параметров
        self.Teams[TeamID] = {
            state = TEAM_STATE.UNKNOWN, -- Дефолтный стейт, это означает что команда зарегистрирована, но еще не используется
            players = {}, -- Список игроков
            place = 0, -- Текущее место
            arena = "team_"..TeamID.."_arena" -- Название арены команды
        }

        PlayerTables:CreateTable("team_"..TeamID, {})
    end

    --Регистрация таблицы для спектаторов
    PlayerTables:CreateTable("team_1", {})
end

--Карта команды загружена
function Players:OnTeamArenaLoaded(TeamID, SpawnGroup)
    local TeamInfo = self:GetTeam(TeamID)
    if TeamInfo == nil then return end

    -- self.Teams[TeamID].spawn_group_handle = SpawnGroup

    -- local AllEnts = Entities:FindAllByClassname("info_target")
    -- for _, ent in ipairs(AllEnts) do
    --     if ent:GetSpawnGroupHandle() == SpawnGroup then
    --         table.insert(self.Teams[TeamID].ents_on_arena, ent)
    --     end
    -- end
end

-- Вызывается после 100 раунда если не активирован режим последней дуэли, проверяет метрики команд и выставляет победителя
function Players:TryEndGame()
    local TeamsStats = {}
    local TeamsToLose = {}
    for _, TeamID in ipairs(self:GetAllActiveTeams(true)) do
        TeamsStats[_] = {
            team = TeamID,
            aegis = 0,
            loser_curse = 0,
            win_buffs = 0,
            kd = 0,
            networth = 0,
        }
        for PlayerID, PlayerInfo in pairs(self:GetTeamActivePlayers(TeamID)) do
            local HeroInfo = HeroBuilder:GetPlayerInfo(PlayerID)
            if HeroInfo then
                TeamsStats[_].aegis = TeamsStats[_].aegis + HeroInfo.lifes_count
                TeamsStats[_].loser_curse = TeamsStats[_].loser_curse + HeroInfo.loser_curse_count
                TeamsStats[_].win_buffs = TeamsStats[_].win_buffs + HeroInfo.minigames_wins
                if PlayerInfo.pvp_wins ~= 0 and PlayerInfo.pvp_loses ~= 0 then
                    TeamsStats[_].kd = TeamsStats[_].kd + PlayerInfo.pvp_wins/PlayerInfo.pvp_loses
                elseif PlayerInfo.pvp_wins ~= 0 and PlayerInfo.pvp_loses == 0 then
                    TeamsStats[_].kd = TeamsStats[_].kd + PlayerInfo.pvp_wins
                end
                TeamsStats[_].networth = TeamsStats[_].networth + self:GetPlayerNetworth(PlayerID)
            end
        end
    end

    if #TeamsStats <= 0 then return end

    local Values = {"aegis", "loser_curse", "win_buffs", "kd", "networth", "random"}
    for _, Value in ipairs(Values) do
        if #TeamsStats == 1 then
            if #TeamsToLose > 0 then
                for _, TeamToLoseID in ipairs(TeamsToLose) do
                    self:MakeTeamLose(TeamToLoseID)
                end
                TeamsToLose = {}
            else
                self:MakeTeamWin(TeamsStats[1].team)
            end

            break
        elseif Value ~= "random" then
            if Value == "loser_curse" then
                table.sort(TeamsStats, function(a, b) return a[Value] > b[Value] end)
            else
                table.sort(TeamsStats, function(a, b) return a[Value] < b[Value] end)
            end
            local Top1 = TeamsStats[#TeamsStats][Value]
            TeamsStats = ArrayRemove(TeamsStats, function(t, i, j)
                if t[i][Value] ~= Top1 then
                    table.insert(TeamsToLose, t[i].team)

                    return false
                end

                return true
            end)
        elseif Value == "random" then
            local RandomTeamIndex = table.random_key(TeamsStats)

            table.remove(TeamsStats, RandomTeamIndex)

            for _TeamNum, TeamInfo in ipairs(TeamsStats) do
                self:MakeTeamLose(TeamInfo.team)
            end
        end
    end
end

-- Попытка сделать команду проигравшей
function Players:TryMakeTeamLose(TeamID)
    if not self:IsActiveTeam(TeamID) then return end

    local AllActiveTeamPlayers = self:GetTeamActivePlayers(TeamID, true)

    if #AllActiveTeamPlayers == 0 then
        self:MakeTeamLose(TeamID)
    end
end

-- Попытка сделать команду победившей
function Players:TryMakeTeamWin(TeamID)
    if not self:IsActiveTeam(TeamID) then return end

    self:MakeTeamWin(TeamID)
end

-- Делаем команду проигравшей
function Players:MakeTeamLose(TeamID)
    DiscLog("!!! MakeTeamLose(team=%d) CALLED, gameState=%d, gameTime=%.2f",
        TeamID, GameRules:State_Get(), GameRules:GetGameTime())

    if not self:IsActiveTeam(TeamID) then return end

    local TeamInfo = self:GetTeam(TeamID)
    if TeamInfo == nil then return end

    -- Выставляем текущее место команды
    local CurrentPlace = #self:GetAllActiveTeams(true)
    TeamInfo.place = CurrentPlace

    TeamInfo.state = TEAM_STATE.LOSE

    print("TEAM LOSE:", TeamID)

    local data =
    {
        type = "team_lose",
        nTeamNumber = TeamID
    }
    Barrage:FireBullet(data)

    CustomNetTables:SetTableValue("team_rank", tostring(TeamID), {rank = CurrentPlace, defeat_round = Rounds:GetCurrentRound()})

    for _, PlayerID in ipairs(self:GetTeamPlayers(TeamID, true)) do
        if self:PlayerStateIs(PlayerID, PLAYER_STATE.IN_GAME) or self:PlayerStateIs(PlayerID, PLAYER_STATE.LEAVED) then
            self:UpdatePlayerState(PlayerID, PLAYER_STATE.LOSER)

            Server:SetPlayerValue(PlayerID, "player_die_round", Rounds:GetCurrentRound())
        end

        Server:CreatePlayerData(PlayerID, CurrentPlace)

        if CurrentPlace - 1 > 1 then
            local hPlayer = PlayerResource:GetPlayer(PlayerID)
            if hPlayer then
                CustomGameEventManager:Send_ServerToPlayer(hPlayer, "ShowPlayerLose", {game_rank=CurrentPlace,valid_team=#self:GetAllActivatedTeams(true)})
            end
        end

        Rounds:KillAllExtraCreepsByPlayerID(PlayerID)

        HeroBuilder:UpdatePlayerExtraCreeps(PlayerID)
    end

    if Rounds:IsTeamInPVPDuel(TeamID) then
        Rounds:EndPVPPair(TeamID, Rounds:StateIs(GAME_STATES.PREPARING))
    end

    Rounds:ClearTeamPVPPairs(TeamID)

    Rounds:EndTeam(TeamID, true)

    CurrentPlace = #self:GetAllActiveTeams(true)

    local VisionRevealer = CreateUnitByName(
        "arena_vision_revelear",
        Vector(0,0,0),
        false,
        nil,
        nil,
        TeamID
    )
    TeamInfo.vision_revealer = VisionRevealer
    VisionRevealer:AddNewModifier(VisionRevealer, nil, "modifier_custom_truesight", {radius = 99999})

    -- Если после поражения команды осталась одна команда - она автоматически побеждает, если 0 - значит завершаем игру
    if CurrentPlace == 1 then
        self:MakeTeamWin(self:GetAllActiveTeams(true)[1])
    elseif CurrentPlace == 0 then
        --Заканчиваем игру
        self:OnGameEnd(TeamID, false)
    end
end

-- Делаем команду победившей
function Players:MakeTeamWin(TeamID)
    DiscLog("!!! MakeTeamWin(team=%d) CALLED, gameState=%d, gameTime=%.2f",
        TeamID, GameRules:State_Get(), GameRules:GetGameTime())

    if not self:IsActiveTeam(TeamID) then return end

    local TeamInfo = self:GetTeam(TeamID)
    if TeamInfo == nil then return end

    TeamInfo.place = 1

    CustomNetTables:SetTableValue("team_rank", tostring(TeamID), {rank = 1, defeat_round = Rounds:GetCurrentRound()})

    TeamInfo.state = TEAM_STATE.WIN

    for _, PlayerID in ipairs(self:GetTeamPlayers(TeamID, true)) do
        if self:PlayerStateIs(PlayerID, PLAYER_STATE.IN_GAME) or self:PlayerStateIs(PlayerID, PLAYER_STATE.LEAVED) then
            self:UpdatePlayerState(PlayerID, PLAYER_STATE.WINNER)

            Server:SetPlayerValue(PlayerID, "player_die_round", Rounds:GetCurrentRound())
        end

        Server:CreatePlayerData(PlayerID, 1)

        self:UpdateArena(PlayerID, "MAIN", nil)
    end

    --Заканчиваем игру
    self:OnGameEnd(TeamID, true)
end

function Players:OnGameEnd(TeamID, bWin)
    DiscLog("!!! OnGameEnd(team=%d, bWin=%s) CALLED, gameState=%d, gameTime=%.2f",
        TeamID, tostring(bWin), GameRules:State_Get(), GameRules:GetGameTime())

    if self.bGameEnded == true then return end

    self.bGameEnded = true

    --Здесь можно отправлять данные на сервер
    -- ...
    Server:SendDataToServer(TeamID, bWin)

    Rounds:UpdateGameState(GAME_STATES.ENDED)

    -- Задержка перед концом игры из-за того, что если завершить игру, то сервер мгновенно закроется
    self.TimerEnt:SetThink(function()
        if bWin then
            GameRules:SetGameWinner(TeamID)
        else
            GameRules:MakeTeamLose(TeamID)
        end
    end, nil, "PLAYER_GAME_END", GAME_END_DELAY)
end

-- Регистрация игрока
function Players:RegisterPlayer(PlayerID, bIsBot)
    -- GameRules:SendCustomMessage("Запрос игрока "..PlayerID.." на регистрацию! bIsBot = "..tostring(bIsBot), 0, 0)
    -- GameRules:SendCustomMessage("Изначальные данные: команда "..PlayerResource:GetTeam(PlayerID), 0, 0)

    print("Player "..PlayerID.." registered to players")

    -- Регистрация только если игрок еще не зарегистрирован
    if self.Players[PlayerID] == nil then

        --Регистрация игрока, выставление базовых параметров
        self.Players[PlayerID] = {
            state = PLAYER_STATE.IN_GAME, -- Если игрока зарегистрировали, значит он уже в игре
            is_bot = bIsBot == true, -- Игрок - бот?
            team = DOTA_TEAM_NOTEAM, -- Изначально игрок без команды
            networth = 0, -- Нетворс игрока
            hero = nil, -- Герой игрока
            secondary_unit = nil, -- Юнит для мини-игр

            arena = "", -- Текущая арена
            position = Vector(0,0,0), -- Текущая позиция на арене

            -- Всяческая стата
            pvp_wins = 0,
            pvp_loses = 0,

            last_duel_wins = 0,
            last_duel_loses = 0,

            bet_rewards = 0,
            bet_history = {},

            spell_damage_outgoing = {},
            spell_damage_incoming = {},

            pause_count = 0,

            tip_cooldown = 0,

            getted_extra_creeps = false,
        }

        PlayerTables:CreateTable("player_"..PlayerID, {}, {PlayerID})

        PlayerTables:CreateTable("player_"..PlayerID.."_global", {}, {})

        -- GameRules:SendCustomMessage("Игрок "..PlayerID.." успешно создал свои таблицы", 0, 0)

        local All = self:GetAllPlayers(true)
        for i, _PlayerID in ipairs(All) do
            for j, __PlayerID in ipairs(All) do
                -- print(_PlayerID, __PlayerID)
                PlayerTables:AddPlayerSubscription("player_".._PlayerID.."_global", __PlayerID)
            end
        end

        -- for SpectatorID, Info in pairs(self.Spectators) do
        --     for i, _PlayerID in ipairs(All) do
        --         self:SubscibeSpectatorToPlayerGlobal(SpectatorID, _PlayerID)
        --     end
        -- end

        -- GameRules:SendCustomMessage("Игрок "..PlayerID.." успешно добавил таблицы в глобальный контекст", 0, 0)

        --Регистрация игрока в команду
        for _, TeamID in ipairs(self:GetAllTeams(true)) do
            if self:AssignPlayerToTeam(PlayerID, TeamID) then
                -- GameRules:SendCustomMessage("Игрок "..PlayerID.." зачислен в команду "..TeamID, 0, 0)
                break
            end
        end

        -- Зачисление базового нетворса игроку
        self:ModifyPlayerNetworth(PlayerID, 600)

        -- Зачисление базового кол-ва пауз игроку
        self:ModifyPauseCharges(PlayerID, PLAYER_INIT_PAUSES)

        -- Если каким-то образом игрока не закинуло в команду
        if self.Players[PlayerID].team == DOTA_TEAM_NOTEAM then
            print("[PLAYERS] Failed to assign PlayerID " .. PlayerID .. " to any team!")
        end

        --Регистрация игрока на сервере
        if not bIsBot and PlayerResource:IsValidPlayerID(PlayerID) then
            local SteamID = PlayerResource:GetSteamAccountID(PlayerID)

            -- Это точно не бот
            if SteamID ~= 0 then
                ChatWheel:LoadPlayer(PlayerID, {})

                Server:RegisterPlayer(PlayerID)
            end

            --Регистрация различных систем
            Votes:SetupDefaultPlayerVotes(PlayerID)

            --Установка сколько банов имеет игрок изначально.
            --
            --Турнирный override (PLAYER_BANS_OVERRIDES в constants/main.lua) перебивает
            --base+battlepass: если SteamID игрока в этой таблице, ставим АБСОЛЮТНЫЕ значения
            --оттуда; иначе обычный flow (base PLAYER_INIT_BANS + BP-бонус из OnPlayerProfileLoaded).
            local nSteamID = PlayerResource:GetSteamAccountID(PlayerID)
            local OverrideBans = PLAYER_BANS_OVERRIDES and PLAYER_BANS_OVERRIDES[nSteamID]
            if OverrideBans then
                print(string.format("[Players] Tournament ban override applied for SteamID=%d (PID=%d): heroes=%s abilities=%s random_heroes=%s random_abilities=%s",
                    nSteamID, PlayerID,
                    tostring(OverrideBans.heroes), tostring(OverrideBans.abilities),
                    tostring(OverrideBans.random_heroes), tostring(OverrideBans.random_abilities)))
                Bans:SetPlayerBanCount(PlayerID, {
                    heroes = OverrideBans.heroes,
                    abilities = OverrideBans.abilities,
                    random_heroes = OverrideBans.random_heroes,
                    random_abilities = OverrideBans.random_abilities,
                })
            else
                Bans:ModifyPlayerBanCount(PlayerID, {
                    heroes=PLAYER_INIT_BANS.HEROES,
                    abilities=PLAYER_INIT_BANS.ABILITIES,
                    random_heroes=PLAYER_INIT_BANS.RANDOM_HEROES,
                    random_abilities=PLAYER_INIT_BANS.RANDOM_ABILITIES
                })
            end

            --Пока не ясно, но наверно нужно
            if PlayerResource:GetPartyID(PlayerID) and tostring(PlayerResource:GetPartyID(PlayerID)) ~= "0" then
                local sPartyID = tostring(PlayerResource:GetPartyID(PlayerID))
                if GameMode.partyListMap[sPartyID]==nil then
                    GameMode.nPartyNumber = GameMode.nPartyNumber + 1
                    GameMode.partyListMap[sPartyID] = GameMode.nPartyNumber
                end
                GameMode.partyNumberMap[PlayerID] = GameMode.partyListMap[sPartyID]
            end

            CustomNetTables:SetTableValue("hero_info", "party_map", GameMode.partyNumberMap)
        end

        --Регистрация различных систем
        HeroBuilder:LoadPlayer(PlayerID)
        NeutralItems:SetupPlayer(PlayerID)
        Items:SetupPlayer(PlayerID)
    end

    self:UpdatePlayerNetTable(PlayerID)
end

function Players:UnregisterPlayer(PlayerID)
    if self.Players[PlayerID] == nil then return end

    self:UnassignPlayerFromTeam(PlayerID)

    self.Players[PlayerID] = nil

    CustomNetTables:SetTableValue("players", "player_"..PlayerID.."_pvp_info", nil)

    PlayerTables:DeleteTable("player_"..PlayerID)

    HeroBuilder:UnloadPlayer(PlayerID)
end

-- Изменение зарядов паузы
function Players:ModifyPauseCharges(PlayerID, value)
    local PlayerInfo = self:GetPlayer(PlayerID)

    if not self:IsActivePlayer(PlayerID) then return end

    PlayerInfo.pause_count = math.min(math.max(PlayerInfo.pause_count + value, 0), PLAYER_MAX_PAUSES)
end

--Профиль игрока загружен
function Players:OnPlayerProfileLoaded(PlayerID, PlayerProfile)
    -- Турнирный override (PLAYER_BANS_OVERRIDES) выставляет абсолютные финальные баны и
    -- игнорирует И BP-бонус, И доп.баны по аккаунту -- иначе турнирные числа поедут.
    local nSteamID = PlayerResource:GetSteamAccountID(PlayerID)
    local bHasOverride = PLAYER_BANS_OVERRIDES and PLAYER_BANS_OVERRIDES[nSteamID] ~= nil

    if Server:IsPlayerBattlePassSubscribed(PlayerID) then
        if not bHasOverride then
            --Установка дополнительных банов если игрок имеет батл пасс
            Bans:ModifyPlayerBanCount(PlayerID, {
                heroes=PLAYER_INIT_BANS.BONUS_HEROES,
                abilities=PLAYER_INIT_BANS.BONUS_ABILITIES,
                random_heroes=PLAYER_INIT_BANS.RANDOM_BONUS_HEROES,
                random_abilities=PLAYER_INIT_BANS.RANDOM_BONUS_ABILITIES
            })
        end

        -- Если есть батл пасс, то даём 1 доп заряд паузы изначально
        self:ModifyPauseCharges(PlayerID, 1)
    end

    -- Доп. баны по аккаунту (player_extra_bans в БД -> profile.extra_bans). Прибавляются
    -- ПОВЕРХ base+BP, независимо от наличия батл пасса. Override их не получает.
    if not bHasOverride and PlayerProfile and PlayerProfile.profile and PlayerProfile.profile.extra_bans then
        local ExtraBans = PlayerProfile.profile.extra_bans
        local ExtraHeroes = tonumber(ExtraBans.heroes) or 0
        local ExtraAbilities = tonumber(ExtraBans.abilities) or 0
        if ExtraHeroes > 0 or ExtraAbilities > 0 then
            print(string.format("[Players] Extra bans applied for SteamID=%d (PID=%d): +%d heroes, +%d abilities",
                nSteamID, PlayerID, ExtraHeroes, ExtraAbilities))
            Bans:ModifyPlayerBanCount(PlayerID, {
                heroes = ExtraHeroes,
                abilities = ExtraAbilities,
                random_heroes = 0,
                random_abilities = 0,
            })
        end
    end

    -- MF-2: публикуем статус наказаний за репорты на клиент (для UI дуэли).
    self:PublishPunishmentInfo(PlayerID)

    -- MF-2: профиль приходит async-запросом (Server:CreatePlayerProfile). Если герой успел
    -- заспавниться ДО ответа, ApplyPunishmentModifiers в InitPlayerHero прочитал пустой
    -- profile.punishments → наказания молча не применились бы за всю игру (при этом бейдж в
    -- дуэли уже показывал бы их из нет-таблицы). Довешиваем сейчас; функция идемпотентна.
    local info = self.Players[PlayerID]
    if info and info.hero and not info.hero:IsNull() then
        self:ApplyPunishmentModifiers(info.hero, PlayerID)
    end
end

-- MF-2: возвращает массив активных наказаний игрока (profile.punishments) или {}.
function Players:GetPunishments(PlayerID)
    local info = Server and Server.GetPlayerInfo and Server:GetPlayerInfo(PlayerID)
    if info and info.profile and type(info.profile.punishments) == "table" then
        return info.profile.punishments
    end
    return {}
end

-- MF-2: публикует сводку наказаний в CustomNetTables (видно всем клиентам, ключ = PlayerID).
-- warning/curse — есть ли; curse_stacks — суммарные стаки курсы;
-- curse_until/warning_until — ДАТА снятия (строка от сервера, expires_text; берём самую позднюю по типу).
function Players:PublishPunishmentInfo(PlayerID)
    local punishments = self:GetPunishments(PlayerID)
    local hasWarning, curseStacks = false, 0
    local curseUntil, warningUntil = "", ""
    local curseMax, warnMax = -1, -1
    for _, p in ipairs(punishments) do
        local rem = tonumber(p.remaining_seconds) or 0
        local until_text = tostring(p.expires_text or "")
        if p.type == "warning" then
            hasWarning = true
            if rem > warnMax then warnMax = rem; warningUntil = until_text end
        elseif p.type == "curse" then
            curseStacks = curseStacks + (tonumber(p.stacks) or 0)
            if rem > curseMax then curseMax = rem; curseUntil = until_text end
        end
    end
    CustomNetTables:SetTableValue("punishments", "player_"..PlayerID, {
        warning = hasWarning,
        warning_until = warningUntil,
        curse = curseStacks > 0,
        curse_stacks = curseStacks,
        curse_until = curseUntil,
    })
end

-- MF-2: вешает модификаторы наказаний на героя (курса/предупреждение) при спавне.
-- Курса — MULTIPLE: по экземпляру на строку наказания (эффекты суммируются).
-- БЕЗ длительности: срок живёт в БД (expires_at), в игре показываем ДАТУ снятия в меню дуэли.
-- Модификатор перевешивается каждую игру из БД, пока наказание активно.
function Players:ApplyPunishmentModifiers(hHero, PlayerID)
    if not hHero or hHero:IsNull() then return end

    -- ИДЕМПОТЕНТНОСТЬ: modifier_report_curse — MULTIPLE, поэтому повторный вызов (реконнект,
    -- ре-инициализация героя, довешивание из OnPlayerProfileLoaded) наложил бы ВТОРОЙ комплект
    -- и удвоил наказание. Остальные модификаторы в InitPlayerHero не-MULTIPLE и просто
    -- рефрешатся, поэтому такой проблемы не имеют. Снимаем свои перед выдачей.
    while hHero:HasModifier("modifier_report_curse") do
        hHero:RemoveModifierByName("modifier_report_curse")
    end
    hHero:RemoveModifierByName("modifier_report_warning")

    local punishments = self:GetPunishments(PlayerID)
    for _, p in ipairs(punishments) do
        if p.type == "curse" then
            local stacks = tonumber(p.stacks) or 0
            if stacks > 0 then
                local mod = hHero:AddNewModifier(hHero, nil, "modifier_report_curse", {})
                if mod then mod:SetStackCount(stacks) end
            end
        elseif p.type == "warning" then
            hHero:AddNewModifier(hHero, nil, "modifier_report_warning", {})
        end
    end
end

-- Регистрация обычных игроков
function Players:OnPlayerConnected(event)
    local PlayerID = event.PlayerID

    -- GameRules:SendCustomMessage("Клиент с PlayerID = "..PlayerID.." подключился к игре", 0, 0)

    -- PlayerResource:SetCustomTeamAssignment(PlayerID, 1)

    if self.Players[PlayerID] == nil and PlayerResource:IsValidPlayerID(PlayerID) and PlayerResource:GetTeam(PlayerID) ~= 1 then
        self:RegisterPlayer(PlayerID)
    end

    --Если это спектатор - подключить его к данным
    -- if PlayerResource:GetTeam(PlayerID) == 1 or not PlayerResource:IsValidTeamPlayerID(PlayerID) then
    --     self:LoadSpectator(PlayerID)
    -- end
end

function Players:LoadSpectator(PlayerID)
    if PlayerResource:GetTeam(PlayerID) ~= 1 or PlayerResource:IsValidTeamPlayerID(PlayerID) or self.Spectators[PlayerID] ~= nil then return end

    print("SPECTATOR IS LOADED")

    self.Spectators[PlayerID] = {}

    self:SubscribeSpectatorToGameData(PlayerID)
end

function Players:SubscribeSpectatorToGameData(PlayerID)
    if self.Spectators[PlayerID] == nil then return end

    PlayerTables:AddPlayerSubscription("notifications", PlayerID)
    PlayerTables:AddPlayerSubscription("chat_wheel", PlayerID)
    PlayerTables:AddPlayerSubscription("round_info", PlayerID)
    PlayerTables:AddPlayerSubscription("globals", PlayerID)
    PlayerTables:AddPlayerSubscription("items", PlayerID)

    for _, RealPlayerID in ipairs(self:GetAllPlayers(true)) do
        self:SubscibeSpectatorToPlayerGlobal(PlayerID, RealPlayerID)
    end
end

function Players:SubscibeSpectatorToPlayerGlobal(SpectatorID, PlayerID)
    if self.Spectators[SpectatorID] == nil then return end
    
    PlayerTables:AddPlayerSubscription("player_"..PlayerID.."_global", SpectatorID)
end

function Players:SubscribeAllSpectatorsToGameData()
    for SpectatorID, Info in pairs(self.Spectators) do
        self:SubscribeSpectatorToGameData(SpectatorID)
    end
end

-- Регистрация ботов -- DEPRECATED
-- function Players:OnBotConnected(event)
--     -- print(event.index, event.userid)
--     -- GameRules:SendCustomMessage(tostring(event.index).." "..tostring(event.userid), 0, 0)
--     table.insert(self.Dump, {
--         index = event.index, 
--         userid = event.userid, 
--     })
--     local PlayerID = event.userid-1
--     if IsLocalServer() then
--         PlayerID = event.userid
--     end
--     if (IsInToolsMode() or GameRules:IsCheatMode()) and PlayerID > -1 and event.bot == 1 and self.Players[PlayerID] == nil then
--         self:RegisterPlayer(PlayerID, true)
--     end
-- end

-- Игрок отключился
function Players:OnPlayerDisconnected(event)
    local PlayerID = event.PlayerID

    -- ДИАГ 1.1: первый замер -- ловим hPlayer и conn на самом входе handler-а.
    -- Гипотеза: на момент event'а CDOTAPlayer entity ЕЩЁ ЖИВА (event прилетает ДО
    -- "Dropped client"). Если так -- у нас есть окно вызвать SetSelectedHero
    -- пока engine может его принять.
    local hPlayerEntry = PlayerResource:GetPlayer(PlayerID)
    local connEntry = PlayerResource:GetConnectionState(PlayerID)
    DiscLog("DC@ENTRY: PID=%d, gameTime=%.2f, hPlayer=%s(null=%s), conn=%d",
        PlayerID, GameRules:GetGameTime(), tostring(hPlayerEntry),
        hPlayerEntry and tostring(hPlayerEntry:IsNull()) or "n/a",
        connEntry or -1)

    local PlayerInfo = self:GetPlayer(PlayerID)
    local connState = PlayerResource:GetConnectionState(PlayerID)

    -- Логируем сразу состояние подключения и PlayerInfo.state, потому что
    -- разные сценарии (workshop test reconnect button, реальный disconnect, abandon)
    -- дают разные комбинации значений на момент события.
    print(string.format(
        "[HeroBuilder/Disc] OnPlayerDisconnected: PID=%d, gameState=%d, hasInfo=%s, conn=%d, state=%s",
        PlayerID, GameRules:State_Get(), tostring(PlayerInfo ~= nil),
        connState or -1,
        PlayerInfo and tostring(PlayerInfo.state) or "?"))

    -- Помечаем `was_disconnected` независимо от точного состояния connection.
    -- Этот флаг используется в OnPlayerReconnected как надёжный сигнал
    -- "этот игрок реально проходил через disconnect" (не полагаемся на PlayerInfo.state).
    if PlayerInfo then
        PlayerInfo.was_disconnected = true
    end

    -- ВАЖНО: в Source 2 Dota event player_disconnect приходит ДО того как
    -- connState реально переключится в DISCONNECTED -- мы видели в логе:
    -- `OnPlayerDisconnected: conn=2 (CONNECTED)` за миллисекунду до
    -- `PR:SetConnectionState DOTA_CONNECTION_STATE_DISCONNECTED`.
    -- Поэтому НЕ проверяем connState -- сам факт event'а достаточен.
    if PlayerInfo and self:PlayerStateIs(PlayerID, PLAYER_STATE.IN_GAME) then
        self:UpdatePlayerState(PlayerID, PLAYER_STATE.LEAVED)
    end

    -- Disconnect hero fix v5 (BRANCH A + умная memoization): на DC engine-level
    -- SetSelectedHero, но с учётом ВЫБОРА ИГРОКА если он успел сделать его в UI до DC.
    --
    -- Приоритет (от высокого к низкому):
    --   1) HeroBuilder.selected_hero -- игрок выбрал в UI (через 4-героя пик-окно).
    --      Это ключевое: до HERO_SELECTION engine не знает про UI-выбор игрока
    --      (он передаётся в engine только через HERO_SELECTION-хук в addon_game_mode.lua).
    --      Если игрок успел выбрать heroX и потом DC -- мы должны использовать heroX,
    --      иначе будет рассинхрон HeroBuilder=heroX vs engine=randomY -> сломанная
    --      продажа/крафт/UI (heroBuilder code думает что hero heroX, а реально heroY).
    --   2) engine уже знает hero -- значит мы уже сделали SetSelectedHero на прошлом DC.
    --      Не перевыбираем (memoization, чтобы рандом не мелькал в чате на каждом DC).
    --   3) Иначе -- выбираем random из 4-х в его UI пик-окне.
    local gameState = GameRules:State_Get()
    if gameState < DOTA_GAMERULES_STATE_HERO_SELECTION then
        local hPlayerNow = PlayerResource:GetPlayer(PlayerID)
        local engineHero = PlayerResource:GetSelectedHeroName(PlayerID)
        local hbInfo = HeroBuilder.Players and HeroBuilder.Players[PlayerID]
        local hbHero = hbInfo and hbInfo.selected_hero

        DiscLog("DC@FORCE_PICK: PID=%d, hPlayer=%s(null=%s), engineHero='%s', hbHero='%s', gameState=%d",
            PlayerID, tostring(hPlayerNow),
            hPlayerNow and tostring(hPlayerNow:IsNull()) or "n/a",
            tostring(engineHero), tostring(hbHero), gameState)

        local heroToSet = nil
        local reason = nil
        if hbHero and hbHero ~= "" then
            -- Приоритет 1: игрок ВЫБРАЛ в UI -- используем его выбор.
            heroToSet = hbHero
            reason = "HeroBuilder.selected_hero (UI choice)"
        elseif engineHero and engineHero ~= "" then
            -- Приоритет 2: engine уже знает (memoization прошлого DC) -- не перевыбираем.
            DiscLog("DC@FORCE_PICK(PID=%d): engine уже знает hero='%s', НЕ перевыбираем", PlayerID, engineHero)
        elseif hPlayerNow and not hPlayerNow:IsNull() then
            -- Приоритет 3: ничего нет -- random из 4 в его пик-UI окне.
            local randomHero = nil
            if hbInfo and hbInfo.random_heroes and #hbInfo.random_heroes > 0 then
                randomHero = table.random(hbInfo.random_heroes)
            elseif HeroBuilder.GenerateListRandomHeroes then
                local generated = HeroBuilder:GenerateListRandomHeroes(PlayerID)
                if generated and #generated > 0 then
                    randomHero = table.random(generated)
                end
            end
            if randomHero and randomHero ~= "" then
                heroToSet = randomHero
                reason = "random fallback"
            else
                DiscLog("DC@FORCE_PICK(PID=%d): random pool пустой, SKIPPED", PlayerID)
            end
        else
            DiscLog("DC@FORCE_PICK(PID=%d): hPlayer уже мёртв, SKIPPED", PlayerID)
        end

        if heroToSet then
            if hPlayerNow and not hPlayerNow:IsNull() then
                PrecacheUnitByNameAsync(heroToSet, function() end, PlayerID)
                local ok, err = pcall(function() hPlayerNow:SetSelectedHero(heroToSet) end)
                DiscLog("DC@FORCE_PICK(PID=%d): SetSelectedHero(%s) -> ok=%s err=%s (reason=%s)",
                    PlayerID, heroToSet, tostring(ok), tostring(err), reason)
            else
                DiscLog("DC@FORCE_PICK(PID=%d): heroToSet=%s, но hPlayer мёртв -- engine может не запомнить (reason=%s)",
                    PlayerID, heroToSet, reason)
            end
        end
    else
        DiscLog("OnPlayerDisconnected(PID=%d): gameState>=HERO_SELECTION (%d), engine forced pick пропускаем",
            PlayerID, gameState)
    end

    -- ДИАГ 1.4: периодические снапшоты состояния первые 90с после DC.
    -- Покажут: (а) в какой момент команда disconnected игрока меняет state (если меняет),
    -- (б) точное время когда unsettled-список становится пустым (= когда стартует ability selection),
    -- (в) переходы gameState (если ванильный движок что-то делает с lobby-state).
    do
        for _, dt in ipairs({2, 5, 10, 20, 30, 45, 60, 75, 90}) do
            Timers:CreateTimer(dt, function()
                local teams = {}
                for _, tid in ipairs(self:GetAllActiveTeams(true) or {}) do
                    local ti = self:GetTeam(tid)
                    local activePlayers = #self:GetTeamPlayers(tid, true)
                    table.insert(teams, string.format("T%d:state=%s,active=%d",
                        tid, tostring(ti and ti.state), activePlayers))
                end
                local unsettled = {}
                for pid, info in pairs(HeroBuilder:GetAllPlayers() or {}) do
                    if info.settled == false then table.insert(unsettled, tostring(pid)) end
                end
                DiscLog("SNAP T+%ds: gameState=%d, teams=[%s], unsettled=[%s], idealAbils=%d",
                    dt, GameRules:State_Get(),
                    table.concat(teams, " | "),
                    table.concat(unsettled, ","),
                    HeroBuilder.IdealAbilitiesList and #HeroBuilder.IdealAbilitiesList or 0)
            end)
        end
    end

    -- Abandon-таймер: если через 60с игрок всё ещё LEAVED (не вернулся)
    -- -- считаем что он точно abandoned. Делаем hero dead + force settled=true,
    -- чтобы AllSettled-блок в HeroBuilder мог завершиться и игра продолжилась.
    -- Если за 60с игрок вернулся (PlayerState != LEAVED) -- ничего не делаем.
    Timers:CreateTimer(60.0, function()
        if not self:PlayerStateIs(PlayerID, PLAYER_STATE.LEAVED) then
            print(string.format(
                "[HeroBuilder/Disc] AbandonTimer(PID=%d): игрок вернулся (state не LEAVED), skip",
                PlayerID))
            return
        end
        local connState = PlayerResource:GetConnectionState(PlayerID)
        print(string.format(
            "[HeroBuilder/Disc] AbandonTimer(PID=%d): 60с истекли, state=LEAVED, conn=%d -- помечаю abandoned",
            PlayerID, connState or -1))
        HeroBuilder:MarkPlayerAbandoned(PlayerID)
    end)

    store_system:PauseDisconnectPlayer(PlayerID)
end

-- Игрок переподключился.
-- Этот обработчик ловит сразу несколько событий: player_reconnected, player_reconnect,
-- player_connect_full. У разных событий немного разные поля, поэтому делаем robust-извлечение PID.
function Players:OnPlayerReconnected(event)
    -- Извлекаем PID из разных возможных источников.
    local PlayerID = event.PlayerID
    if not PlayerID or PlayerID < 0 then
        if event.userid then
            -- player_connect_full event использует userid -> player slot
            local user_pid = (event.userid - 1) -- userid обычно PID+1, но не гарантировано
            if PlayerResource:IsValidPlayerID(user_pid) then PlayerID = user_pid end
        end
    end

    if not PlayerID or PlayerID < 0 then
        print(string.format(
            "[HeroBuilder/Disc] OnPlayerReconnected: не удалось извлечь PID (event=%s)",
            EncodeEventForLog(event)))
        return
    end

    local PlayerInfo = self:GetPlayer(PlayerID)
    local hbPlayer = HeroBuilder.Players and HeroBuilder.Players[PlayerID]

    print(string.format(
        "[HeroBuilder/Disc] OnPlayerReconnected: PID=%d, gameState=%d, hasInfo=%s, conn=%d, state=%s, hb.selected_hero=%s, was_disconnected=%s",
        PlayerID, GameRules:State_Get(),
        tostring(PlayerInfo ~= nil),
        PlayerResource:GetConnectionState(PlayerID) or -1,
        PlayerInfo and tostring(PlayerInfo.state) or "?",
        hbPlayer and tostring(hbPlayer.selected_hero) or "?",
        PlayerInfo and tostring(PlayerInfo.was_disconnected) or "?"))

    if PlayerInfo and self:PlayerStateIs(PlayerID, PLAYER_STATE.LEAVED) and PlayerResource:GetConnectionState(PlayerID) ~= DOTA_CONNECTION_STATE_ABANDONED then
        self:UpdatePlayerState(PlayerID, PLAYER_STATE.IN_GAME)
    end

    -- Если игрок вернулся ДО конца стадии пика -- ничего не делаем активного.
    -- HeroBuilder.selected_hero пуст (мы не записывали при DC, см. OnPlayerDisconnected),
    -- так что UI выбора героев у него работает как у обычных игроков -- может пикнуть
    -- из 4 случайных через тот же стандартный flow.
    --
    -- Engine-side forced pick (что мы ставили на DC через hPlayer:SetSelectedHero)
    -- будет автоматически перезаписан в HERO_SELECTION-хуке addon_game_mode.lua,
    -- когда сработает `Player:SetSelectedHero(HeroBuilder.selected_hero)` для CONNECTED.
    local gameState = GameRules:State_Get()
    if gameState < DOTA_GAMERULES_STATE_HERO_SELECTION then
        DiscLog("OnPlayerReconnected(PID=%d): gameState=%d < HERO_SELECTION -- игрок успел вернуться в стадию пика, UI должен отработать как обычно",
            PlayerID, gameState)
        return
    end

    -- Стадия пика уже закончилась -- идём по стандартному пути перехвата hero/control.
    HeroBuilder:HandleReconnectMissingHero(PlayerID)
end

-- Маленький хелпер для лога события (не критично, выдаёт читаемый дамп).
function EncodeEventForLog(event)
    local s = "{"
    for k, v in pairs(event or {}) do
        s = s .. tostring(k) .. "=" .. tostring(v) .. ","
    end
    return s .. "}"
end

-- Юнит появлися
function Players:OnNPCSpawned(event)
    local iUnit = event.entindex
    local bIsRespawn = event.is_respawn == 1

    if iUnit == nil then return end

    local hUnit = EntIndexToHScript(iUnit)

    if hUnit == nil then return end

    -- Проверка на то, что это именно герой и это его первое появление
    if IsRealHero(hUnit) and not bIsRespawn and hUnit.GetPlayerID then
        local PlayerID = hUnit:GetPlayerID()

        -- Белый список hero-class юнитов которые легитимно спавнятся вторично для
        -- уже-залогиненного PID. На них disc-fix orphan/duplicate guard НЕ распространяется.
        -- Сейчас в списке только target_dummy (создаётся через чит-панель Hero_Demo).
        local DISC_FIX_HERO_EXCEPTIONS = {
            ["npc_dota_hero_target_dummy"] = true,
        }
        if DISC_FIX_HERO_EXCEPTIONS[hUnit:GetUnitName()] then
            return
        end

        -- Disconnect hero fix: orphan/duplicate guard.
        -- 1) Hero без PID (PID == -1) -- остатки CreateUnitByName, удаляем.
        if PlayerID < 0 then
            print(string.format(
                "[HeroBuilder/Disc] OnNPCSpawned: orphan hero (PID=%d) name=%s, удаляю",
                PlayerID, hUnit:GetUnitName()))
            UTIL_Remove(hUnit)
            return
        end
        -- 2) Для PID уже есть валидный hero -- значит engine спавнит второй (дубль).
        --    Удаляем только что появившийся, оригинальный оставляем.
        if self.Players[PlayerID] and self.Players[PlayerID].hero
           and not self.Players[PlayerID].hero:IsNull()
           and self.Players[PlayerID].hero ~= hUnit then
            print(string.format(
                "[HeroBuilder/Disc] OnNPCSpawned: duplicate hero для PID=%d (old=%s, new=%s), удаляю NEW",
                PlayerID, self.Players[PlayerID].hero:GetUnitName(), hUnit:GetUnitName()))
            UTIL_Remove(hUnit)
            return
        end

        -- 3) Спавн hero для PID, который прошёл через disconnect.
        -- Используем `was_disconnected` флаг (не PlayerInfo.state), потому что
        -- OnPlayerReconnected обычно выполняется ДО OnNPCSpawned и переводит state
        -- в IN_GAME -- то есть PlayerStateIs(LEAVED) уже false на момент спавна.
        -- `was_disconnected` ставится в OnPlayerDisconnected и остаётся `true` пока
        -- мы явно не отработаем реконнект.
        local hbPInfo = HeroBuilder and HeroBuilder.Players and HeroBuilder.Players[PlayerID]
        local pInfo = self.Players and self.Players[PlayerID]
        local was_disconnected = pInfo and pInfo.was_disconnected == true
        if was_disconnected then
            print(string.format(
                "[HeroBuilder/Disc] OnNPCSpawned: hero для was_disconnected PID=%d (hero=%s), считаю реконнектом",
                PlayerID, hUnit:GetUnitName()))
            local connState = PlayerResource:GetConnectionState(PlayerID)
            if connState ~= DOTA_CONNECTION_STATE_ABANDONED and self:PlayerStateIs(PlayerID, PLAYER_STATE.LEAVED) then
                self:UpdatePlayerState(PlayerID, PLAYER_STATE.IN_GAME)
            end

            -- Disconnect fix v2: синхронизируем HeroBuilder.Players[PID].selected_hero
            -- с фактически заспавненным героем. Раньше на DC мы записывали туда random
            -- hero и блокировали игроку выбор при реконнекте. Теперь мы НЕ пишем туда
            -- на DC (только engine-side forced pick), а сюда попадаем уже когда engine
            -- сам определил кого спавнить (наш forced либо собственный выбор реконнектнувшегося).
            -- Без этой синхронизации HeroBuilder.selected_hero может остаться пустым,
            -- и дальнейшая логика (отображение в UI, проверки в HeroBuilder) сломается.
            if hbPInfo and (not hbPInfo.selected_hero or hbPInfo.selected_hero == "") then
                hbPInfo.selected_hero = hUnit:GetUnitName()
                if HeroBuilder.UpdatePlayerNetTable then
                    HeroBuilder:UpdatePlayerNetTable(PlayerID)
                end
                DiscLog("OnNPCSpawned(PID=%d): sync HeroBuilder.selected_hero = '%s' (engine spawn winner)",
                    PlayerID, hUnit:GetUnitName())
            end

            -- Отложенный Reassign -- даём engine завершить спавн, потом перехватываем control.
            Timers:CreateTimer(0.2, function()
                HeroBuilder:ReassignHeroControlOnReconnect(PlayerID)
                -- Очищаем флаг, чтобы повторные спавны (если есть) не дёргали handler заново.
                if pInfo then pInfo.was_disconnected = false end
            end)
        end

        if self.Players[PlayerID] == nil and PlayerResource:GetSteamAccountID(PlayerID) == 0 then -- Это бот, регистрируем игрока
            self:RegisterPlayer(PlayerID, true)
        end
        if self.Players[PlayerID] ~= nil and self.Players[PlayerID].hero == nil then
            self.Players[PlayerID].hero = hUnit

            -- Изменение команды для ботов, т.к они появляются не в той команде, в которой нужно
            hUnit:SetContextThink(DoUniqueString("HeroSpawned"), function()
                if hUnit and not hUnit:IsNull() and hUnit.REPLACING_HERO == nil and GameRules:State_Get() >= DOTA_GAMERULES_STATE_PRE_GAME then
                    local PlayerInfo = self:GetPlayer(hUnit:GetPlayerID())
                    if PlayerInfo and PlayerInfo.is_bot then
                        hUnit:SetTeam(PlayerInfo.team)
                    end

                    self:UpdateArena(hUnit:GetPlayerID(), "MAIN", nil, true)
                    HeroBuilder:InitPlayerSettings(hUnit:GetPlayerID())
                    HeroBuilder:InitPlayerHero(hUnit)

                    return -1
                end
                if hUnit and not hUnit:IsNull() then
                    return 1
                end
            end, 0.01)
        end
    end

    if hUnit:IsHero() then
        hUnit:SetContextThink(DoUniqueString("UnitSpawned"), function()
            if hUnit and not hUnit:IsNull() then
                hUnit:RemoveModifierByName("modifier_fountain_invulnerability")
                Illusion:InitIllusion(hUnit)
            end
        end, 0.01)
    end

    local hOwner = hUnit:GetOwner()
    if hOwner and hOwner.HasModifier and hOwner:HasModifier("modifier_hero_refreshing") then
        if hUnit and hUnit:GetUnitName()=="npc_dota_phoenix_sun" then
            hUnit:AddNewModifier(hUnit, nil, "modifier_hero_refreshing", {})
        end
        if hUnit and (hUnit:GetName() == "npc_dota_brewmaster_storm" or hUnit:GetName() == "npc_dota_brewmaster_fire" or hUnit:GetName() == "npc_dota_brewmaster_earth")  then
            hUnit:AddNewModifier(unit, nil, "modifier_hero_refreshing", {})
        end
    end

    if hUnit and hUnit:GetUnitName() == "npc_dota_techies_land_mine" then
        hUnit:AddNewModifier(hUnit, nil, "modifier_techies_mines_health_pips", {})
    end

    -- [A61/MF-16] Вотчер Arctic Burn — вешаем на КАЖДОГО реального героя (не по имени юнита, чтобы
    -- гарантированно навесился независимо от возможных различий в имени). Его think сам делает
    -- early-return, если у героя нет способности winter_wyvern_arctic_burn → накладных почти нет.
    -- Отвечает за NO_UNIT_COLLISION на время полёта + дрейн 3% маны у аганим-формы.
    if hUnit and not hUnit:IsNull() and hUnit:IsHero() and not hUnit:IsIllusion() then
        hUnit:AddNewModifier(hUnit, nil, "modifier_arctic_burn_no_collision", {})
    end

    if hUnit and not hUnit:IsNull() and hUnit.GetUnitName and hUnit:GetUnitName() and not hUnit:IsIllusion() and not hUnit:IsTempestDouble() and not hUnit:HasModifier("modifier_arc_warden_tempest_double_lua") then
        if hUnit:IsSummoned() or SUMMON_UPGRADES_MULT[hUnit:GetUnitName()] then
            local flWaitTime = 0
            if "npc_dota_clinkz_skeleton_archer" == hUnit:GetUnitName() then
                hUnit:AddNewModifier(hUnit, nil, "modifier_clinkz_skeletons", {})
                flWaitTime=0.1  
            end
            Timers:CreateTimer(flWaitTime, function()
                if not hUnit or hUnit:IsNull() then return end
                local hOwner = GetRealUnit(hUnit)
                if hOwner and hOwner.IsRealHero ~= nil and hOwner:IsRealHero() then
                    if hOwner:HasModifier("modifier_item_summoner_crown") or hOwner:HasModifier("modifier_item_wraith_dominator") then
                        -- Phoenix Supernova egg НЕ улучшается саммон-предметами:
                        -- иначе яйцо становится практически неубиваемым (его HP =
                        -- кол-во атак для разрушения, любая прибавка от Str/eff
                        -- ломает баланс). Просто пропускаем буст-блок, остальные
                        -- саммоны героя обрабатываются как раньше.
                        if hUnit:GetUnitName() == "npc_dota_phoenix_sun" then
                            return
                        end
                        local flEfficiency = SUMMON_UPGRADES_MULT[hUnit:GetUnitName()] or 1.0
                        if hOwner:HasAbility("special_bonus_unique_furion") and TREANT_LIST[hUnit:GetUnitName()] then
                            local hTalent = hOwner:FindAbilityByName("special_bonus_unique_furion")
                            if hTalent:GetLevel() > 0 then
                                flEfficiency = flEfficiency * 0.6
                            end
                        end
                        local hSourceItem = hOwner:FindItemInInventory("item_wraith_dominator") or hOwner:FindItemInInventory("item_summoner_crown_3") or hOwner:FindItemInInventory("item_summoner_crown_2") or hOwner:FindItemInInventory("item_summoner_crown_1")
                        if hSourceItem and not hSourceItem:IsNull() then
                            local hBuffAgi = hUnit:AddNewModifier(hOwner, hSourceItem, "modifier_item_summoner_crown_buff_agi", {})
                            if (not hBuffAgi) or hBuffAgi:IsNull() then
                                return nil
                            end
                            hBuffAgi:SetStackCount(hOwner:GetAgility() * flEfficiency)                          
                            local hBuffInt = hUnit:AddNewModifier(hOwner, hSourceItem, "modifier_item_summoner_crown_buff_int", {})
                            hBuffInt:SetStackCount(hOwner:GetIntellect(false) * flEfficiency)
                            hUnit:AddNewModifier(hOwner, hSourceItem, "modifier_item_summoner_crown_model_size", {})
                            Timers:CreateTimer(FrameTime(), function()                             
                                if hSourceItem and not hSourceItem:IsNull() then
                                    if hUnit and not hUnit:IsNull() and hUnit:IsAlive() then
                                        local nCurrentHealth = hUnit:GetMaxHealth()
                                        if hUnit:GetName() == "npc_dota_lone_druid_bear" then
                                            nCurrentHealth = 2000 + 75 * hUnit:GetLevel()
                                        end
                                        if nCurrentHealth>1 or hUnit:GetName() == "npc_dota_techies_mines" then
                                            hUnit.nOldHealth = nCurrentHealth
                                            local nNewHealth = math.floor(nCurrentHealth * (1 + 0.01 * hOwner:GetStrength() * flEfficiency * hSourceItem:GetSpecialValueFor("hp_bonus_per_str") ))
                                            if nNewHealth>1 then
                                                hUnit:SetBaseMaxHealth(nNewHealth)
                                                hUnit:SetMaxHealth(nNewHealth)
                                                hUnit:SetHealth(nNewHealth)
                                            end
                                        end
                                    end
                                end
                            end)
                            if hUnit:GetName() == "npc_dota_lone_druid_bear" then 
                                if hOwner and hOwner:IsRealHero() and hOwner.bUsedBearDarkMoon and  not hUnit:HasModifier("modifier_item_dark_moon_shard") then
                                    hUnit:AddNewModifier(hUnit, nil, "modifier_item_dark_moon_shard", {})
                                end
                            end     
                        end               
                    else
                        hUnit:RemoveModifierByName("modifier_item_summoner_crown_buff_agi")
                        hUnit:RemoveModifierByName("modifier_item_summoner_crown_buff_int")
                        hUnit:RemoveModifierByName("modifier_item_summoner_crown_model_size")
                        Timers:CreateTimer(FrameTime(), function()
                            if hUnit and not hUnit:IsNull() and hUnit:GetName() == "npc_dota_lone_druid_bear" then
                                local nCurrentHealth = 2000 + 75 * hUnit:GetLevel()
                                hUnit:SetBaseMaxHealth(nCurrentHealth)
                                hUnit:SetMaxHealth(nCurrentHealth)
                                hUnit:SetHealth(nCurrentHealth)
                            end
                        end)
                    end
                    if hUnit:GetName() == "npc_dota_lone_druid_bear" then 
                        if hOwner and hOwner:IsRealHero() and hOwner.bUsedBearDarkMoon and  not hUnit:HasModifier("modifier_item_dark_moon_shard") then
                            hUnit:AddNewModifier(hUnit, nil, "modifier_item_dark_moon_shard", {})
                        end
                    end
                end
            end)
            if hUnit:GetName() == "npc_dota_lone_druid_bear" then 
                Timers:CreateTimer(2.0, function()
                    if hUnit and not hUnit:IsNull() and hUnit:IsAlive() then
                        Players:RefreshBear(hUnit)
                        return 2.0
                    else
                        return nil
                    end
                end)
            end
        end
    end
end

function Players:OnPlayerWantPauseGame(event)
    local PlayerID = event.PlayerID

    local PlayerInfo = self:GetPlayer(PlayerID)
    if not self:IsActivePlayer(PlayerID) then return end

    local CurrentTime = Time()

    local MakeGamePaused = function()
        if PlayerInfo.pause_count > 0 then
            PauseGame(true)
            self:ModifyPauseCharges(PlayerID, -1)

            self.PauseOwner = PlayerID
            self.UnpauseLastTime = CurrentTime + PLAYERS_MIN_PAUSE_DURATION
            self.AllUnpauseTime = CurrentTime + PLAYERS_MIN_UNPAUSE_DURATION

            Timers:RemoveTimer("UNPAUSE_DELAY")
            self.UnpauseDelayStarted = false

            CustomNetTables:SetTableValue("globals", "pause_owner", {owner_pid = PlayerID})
            CustomNetTables:SetTableValue("globals", "pause_unpause_delay", {time = 0})
        else
            local player = PlayerResource:GetPlayer(PlayerID)
            if player then
                if self.NextPauseChargeTime == 0 then
                    CustomGameEventManager:Send_ServerToPlayer(player, "PauseNotification", {message = "#dota_hud_error_no_pause_charges_no_time", time = ""})
                else
                    CustomGameEventManager:Send_ServerToPlayer(player, "PauseNotification", {message = "#dota_hud_error_no_pause_charges", time = math.floor(self.NextPauseChargeTime - CurrentTime)})
                end
            end
        end
    end

    if GameRules:IsGamePaused() then
        if self.AllUnpauseTime > CurrentTime then
            local player = PlayerResource:GetPlayer(PlayerID)
            if player then
                CustomGameEventManager:Send_ServerToPlayer(player, "PauseNotification", {message = "#dota_hud_error_not_time_pause", time = math.floor(self.AllUnpauseTime - CurrentTime)})
            end
            return
        end
        if self.PauseOwner == PlayerID or self.UnpauseLastTime <= CurrentTime or self.UnpauseDelayStarted == true then
            if self.UnpauseDelayStarted == false then
                self.UnpauseDelayStarted = true

                CustomNetTables:SetTableValue("globals", "pause_unpause_delay", {time = CurrentTime + PLAYERS_MIN_UNPAUSE_DELAY})
                CustomGameEventManager:Send_ServerToAllClients("player_unpause_chat", {id = PlayerID})

                Timers:CreateTimer("UNPAUSE_DELAY", { useGameTime = false, endTime = 3, callback = function()
                    PauseGame(false)
                    CustomNetTables:SetTableValue("globals", "pause_owner", {owner_pid = -1})

                    self.PauseOwner = -1
                    self.UnpauseLastTime = 0
                    self.AllUnpauseTime = 0
                    self.UnpauseDelayStarted = false

                    CustomNetTables:SetTableValue("globals", "pause_unpause_delay", {time = 0})
                end})
            else
                MakeGamePaused()
            end
        elseif self.PauseOwner ~= PlayerID and self.UnpauseLastTime > CurrentTime then
            local player = PlayerResource:GetPlayer(PlayerID)
            if player then
                CustomGameEventManager:Send_ServerToPlayer(player, "PauseNotification", {message = "#dota_hud_error_not_pause_owner", time = math.floor(self.UnpauseLastTime - CurrentTime)})
            end
        end
    else
        MakeGamePaused()
    end
end

function Players:OnPlayerWantTipPlayer(event)
    local TipsPlayerID = event.tips_player
    local TippedPlayerID = event.tipped_player

    local TipsPlayerInfo = self:GetPlayer(TipsPlayerID)
    if not TipsPlayerInfo then return end

    local CurrentTime = GameRules:GetGameTime()
    if CurrentTime >= TipsPlayerInfo.tip_cooldown then
        TipsPlayerInfo.tip_cooldown = CurrentTime + PLAYER_TIP_COOLDOWN

        CustomGameEventManager:Send_ServerToAllClients( 'TipPlayerNotification', {player_id_1 = TipsPlayerID, player_id_2 = TippedPlayerID})
    else
        SendErrorToPlayer(event.tips_player, "#PLAYER_HUD_Error_Tip_Cooldown")
    end
end

function Players:KillSummonedCreatureAsyn(vLocation)
    if vLocation then
        local vCleanLocation = Vector(vLocation.x,vLocation.y,vLocation.z)
        Timers:CreateTimer({ endTime = 5,
            callback = function()
            local summonedCreature = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, vCleanLocation, nil, 2500, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_CLOSEST, false)
            for _,hUnit in ipairs(summonedCreature) do
                if hUnit and not hUnit:IsNull() and hUnit.GetUnitName and hUnit:GetUnitName() and (hUnit:IsSummoned() or SUMMON_UPGRADES_MULT[hUnit:GetUnitName()]) and not hUnit:IsIllusion() and not hUnit:IsTempestDouble() and not hUnit:HasModifier("modifier_arc_warden_tempest_double_lua") then
                    if hUnit:IsAlive() then
                        if string.find(hUnit:GetUnitName(),"npc_dota_lone_druid_bear") == 1 then
                            local hOwner = hUnit:GetOwner()
                            if hOwner and hOwner:IsRealHero() and hOwner:HasAbility("lone_druid_spirit_bear") then
                                local hAbility = hOwner:FindAbilityByName("lone_druid_spirit_bear")
                                hAbility:EndCooldown()
                            end
                        end

                        if string.find(hUnit:GetUnitName(),"npc_dota_visage_familiar") == 1 then
                            local hOwner = hUnit:GetOwner()
                            if hOwner and hOwner:IsRealHero() and hOwner:HasAbility("visage_summon_familiars") then
                                local hAbility = hOwner:FindAbilityByName("visage_summon_familiars")
                                hAbility:EndCooldown()
                            end
                        end

                        if string.find(hUnit:GetUnitName(),"npc_dota_warlock_golem") == 1 then
                            local hOwner = hUnit:GetOwner()
                            if hOwner and hOwner:IsRealHero() and hOwner:HasAbility("warlock_rain_of_chaos") then
                                local hAbility = hOwner:FindAbilityByName("warlock_rain_of_chaos")
                                hAbility:EndCooldown()
                            end
                        end

              
                        if string.find(hUnit:GetUnitName(),"npc_dota_shadow_shaman_ward") == 1 then
                            local hOwner = hUnit:GetOwner()
                            if hOwner and hOwner:IsRealHero() and hOwner:HasAbility("shadow_shaman_mass_serpent_ward") then
                                local hAbility = hOwner:FindAbilityByName("shadow_shaman_mass_serpent_ward")
                                hAbility:EndCooldown()
                            end
                        end

                        if string.find(hUnit:GetUnitName(),"npc_dota_brewmaster") == 1 then
                            local hOwner = hUnit:GetOwner()
                            if hOwner and hOwner:IsRealHero() and hOwner:HasAbility("brewmaster_primal_split") then
                                local hAbility = hOwner:FindAbilityByName("brewmaster_primal_split")
                                hAbility:EndCooldown()
                            end
                        end

                        hUnit:ForceKill(false)
                    end
                end
            end
        end})
    end
end

function Players:RefreshBear(hBear)
    local hOwner = hBear:GetOwner()
    if hOwner and hOwner:IsRealHero() then
        if hOwner:HasModifier("modifier_item_summoner_crown") or hOwner:HasModifier("modifier_item_wraith_dominator") then
            local flEfficiency = SUMMON_UPGRADES_MULT[hBear:GetUnitName()] or 1.0
            local hSourceItem = hOwner:FindItemInInventory("item_wraith_dominator") or hOwner:FindItemInInventory("item_summoner_crown_3") or hOwner:FindItemInInventory("item_summoner_crown_2") or hOwner:FindItemInInventory("item_summoner_crown_1")
            if hSourceItem and not hSourceItem:IsNull() then
                local hBuffAgi = hBear:FindModifierByName("modifier_item_summoner_crown_buff_agi")
                if not hBuffAgi or hBuffAgi:IsNull() then
                    hBuffAgi = hBear:AddNewModifier(hOwner, hSourceItem, "modifier_item_summoner_crown_buff_agi", {}) 
                end
                hBuffAgi:SetStackCount(hOwner:GetAgility() * flEfficiency)   
                local hBuffInt = hBear:FindModifierByName("modifier_item_summoner_crown_buff_int")
                if not hBuffInt or hBuffInt:IsNull() then
                   hBuffInt = hBear:AddNewModifier(hOwner, hSourceItem, "modifier_item_summoner_crown_buff_int", {}) 
                end
                hBuffInt:SetStackCount(hOwner:GetIntellect(false) * flEfficiency)   
                local nCurrentHealth = 2000 + 75 * hBear:GetLevel()
                local nNewHealth = math.floor(nCurrentHealth * (1 + 0.01 * hOwner:GetStrength() * flEfficiency * hSourceItem:GetSpecialValueFor("hp_bonus_per_str") ))
                if nNewHealth>1 then
                   hBear:SetBaseMaxHealth(nNewHealth)
                   hBear:SetMaxHealth(nNewHealth)
                end
            end
        end
    end
end

function Players:GiveExtraCretures(PlayerID)
    if PlayerID == nil then return end

    local PlayerInfo = self:GetPlayer(PlayerID)
    if PlayerInfo == nil or PlayerInfo.getted_extra_creeps == true or not self:IsActivePlayer(PlayerID) then return end

    if Rounds:GetCurrentRound() >= GetGameSetting("ROUND_WHEN_CAN_SUMMON_CREEPS") or #self:GetAllActivePlayers(true) <= PLAYERS_WHEN_CAN_SUMMON_CREEPS then
        PlayerInfo.getted_extra_creeps = true
        for ItemName, _ in pairs(EXTRA_CREATURES_LIST) do
            GameRules:IncreaseItemStock(PlayerInfo.team, ItemName, 2, PlayerID)
        end
	end
end

function Players:UpdatePlayersNetTableDamage()
    if not GAME_DAMAGE_TABLE_ENABLED then return end
    for PlayerID, PlayerInfo in pairs(self:GetAllActivePlayers()) do
        if #PlayerInfo.spell_damage_outgoing > 0 then
            table.sort( PlayerInfo.spell_damage_outgoing, function(x,y) return y.damage < x.damage end )
            PlayerTables:SetTableValue("player_"..PlayerID, "outgoing_damage", PlayerInfo.spell_damage_outgoing)
        end
        if #PlayerInfo.spell_damage_incoming > 0 then
            table.sort( PlayerInfo.spell_damage_incoming, function(x,y) return y.damage < x.damage end )
            PlayerTables:SetTableValue("player_"..PlayerID, "incoming_damage", PlayerInfo.spell_damage_incoming)
        end
    end
end

function Players:ClearPlayersNetTableDamage()
    if not GAME_DAMAGE_TABLE_ENABLED then return end
    for PlayerID, PlayerInfo in pairs(self:GetAllPlayers()) do
        PlayerInfo.spell_damage_outgoing = {}
        PlayerTables:SetTableValue("player_"..PlayerID, "outgoing_damage", PlayerInfo.spell_damage_outgoing)
        PlayerInfo.spell_damage_incoming = {}
        PlayerTables:SetTableValue("player_"..PlayerID, "incoming_damage", PlayerInfo.spell_damage_incoming)
    end
end

-- Суммирует в dict по имени post-armor вклад PreAttack_BonusDamage источника.
-- OnDamageEvent обрабатывает весь dict за раз и очищает. Это предотвращает
-- unbounded growth если атака ушла в промах/блок и damage event не сработал.
function Players:QueueAttackBonus(attacker, target, bonus, name, damage_type)
    if not attacker or not target then return end
    if not bonus or bonus <= 0 then return end
    if not name then return end
    local armor = (target.GetPhysicalArmorValue and target:GetPhysicalArmorValue(false)) or 0
    local mult = 1
    local dt = damage_type or DAMAGE_TYPE_PHYSICAL
    if dt == DAMAGE_TYPE_PHYSICAL then
        mult = 1 - (0.06 * armor) / (1 + 0.06 * math.abs(armor))
    end
    -- Перезаписываем значение для ключа (не суммируем) — если предыдущая атака была заблокирована
    -- и damage event не сработал, старое значение будет заменено вкладом новой атаки.
    attacker._pending_bonus_map = attacker._pending_bonus_map or {}
    attacker._pending_bonus_map[name] = {
        amount = bonus * mult,
        damage_type = dt,
    }
end

-- Ставит в очередь оценку доп. урона от крита (crit_mult - 100) * average_attack_damage.
-- Вычисляется приблизительно через GetAverageTrueAttackDamage, точного доступа к итоговой атаке
-- на стадии PreAttack нет. Бонусы от других модификаторов уже в average attack не учтены —
-- крит умножает сумму, но это лучшее приближение без парса engine-side.
function Players:QueueCritBonus(attacker, target, crit_mult, name)
    if not attacker or not target then return end
    if not crit_mult or crit_mult <= 100 then return end
    if not attacker.GetAverageTrueAttackDamage then return end
    local base = attacker:GetAverageTrueAttackDamage(target) or 0
    local extra = base * (crit_mult - 100) / 100
    if extra <= 0 then return end
    self:QueueAttackBonus(attacker, target, extra, name, DAMAGE_TYPE_PHYSICAL)
end

function Players:OnDamageEvent(attacker, target, params)
    if not GAME_DAMAGE_TABLE_ENABLED then return end
    if params.damage <= 0 or attacker == nil or target == nil or attacker == target then return end

    local sAbilityName = nil
    local sAbilityType = "attack"
    local nDamageType = params.damagetype_const
    local nDamage = params.damage
    if params.entindex_inflictor_const ~= nil then
        local ability = EntIndexToHScript(params.entindex_inflictor_const)
        if ability == nil then return end

        sAbilityName = ability:GetAbilityName()

        sAbilityType = ability:IsItem() and "item" or "ability"
    else
        sAbilityName = "attack"
        sAbilityType = "attack"
    end

    -- Выделяем PreAttack_BonusDamage вклад всех модификаторов атакующего в отдельные строки,
    -- вычитаем их из "attack" чтобы не было двойного счёта. Обрабатываем весь dict за раз и чистим.
    if sAbilityName == "attack" and attacker._pending_bonus_map then
        local map = attacker._pending_bonus_map
        attacker._pending_bonus_map = nil
        for bonus_name, info in pairs(map) do
            local split = math.min(info.amount or 0, nDamage)
            if split > 0 then
                nDamage = nDamage - split
                if attacker:IsRealHero() then
                    self:UpdatePlayerDamage(attacker:GetPlayerOwnerID(), "spell_damage_outgoing", split, bonus_name, "ability", info.damage_type or DAMAGE_TYPE_PHYSICAL)
                end
                if target and target:IsRealHero() then
                    self:UpdatePlayerDamage(target:GetPlayerOwnerID(), "spell_damage_incoming", split, bonus_name, "ability", info.damage_type or DAMAGE_TYPE_PHYSICAL)
                end
            end
        end
    end

    if nDamage > 0 then
        if attacker:IsRealHero() then
            self:UpdatePlayerDamage(attacker:GetPlayerOwnerID(), "spell_damage_outgoing", nDamage, sAbilityName, sAbilityType, nDamageType)
        elseif not attacker:IsHero() and attacker.GetPlayerOwnerID and attacker:GetPlayerOwnerID() and attacker:GetOwner() then
            self:UpdatePlayerDamage(attacker:GetPlayerOwnerID(), "spell_damage_outgoing", nDamage, attacker:GetUnitName(), "unit", nDamageType)
        end
        if target and target:IsRealHero() then
            self:UpdatePlayerDamage(target:GetPlayerOwnerID(), "spell_damage_incoming", nDamage, sAbilityName, sAbilityType, nDamageType)
        end
    end
end

function Players:UpdatePlayerDamage(PlayerID, nType, nDamage, sAbilityName, sAbilityType, nDamageType)
    if PlayerID == nil then return end

    local PlayerInfo = self:GetPlayer(PlayerID)
    if PlayerInfo == nil then return end

    -- Если игрок не подписан на батл пасс, то его значения не записываем (в читах разрешаем всем)
    if not Server:IsPlayerBattlePassSubscribed(PlayerID) and not IsCheatsEnabled() then return end

    local Container = PlayerInfo[nType]
    if Container == nil then return end


    local Damage = tonumber(nDamage)
    if Damage == nil then return end

    if sAbilityName == nil or sAbilityType == nil or nDamageType == nil then return end

    local bIsNew = true
    for _, DamageInfo in ipairs(Container) do
        if DamageInfo.name == sAbilityName then
            bIsNew = false

            DamageInfo.damage = DamageInfo.damage + Damage

            break
        end
    end

    if bIsNew then
        table.insert(Container, {
            name = sAbilityName,
            damage = Damage,
            damage_type = nDamageType,
            type = sAbilityType
        })
    end
end

-- Каждую секунду проверяем соединение игрока, и если он полностью ливнул из игры - изменяет его стейт
function Players:AbandonThink()
    local AllLeavedPlayers = self:GetAllLeavedPlayers(true)
    for _, PlayerID in ipairs(AllLeavedPlayers) do
        if PlayerResource:IsValidPlayerID(PlayerID) and PlayerResource:GetConnectionState(PlayerID) == DOTA_CONNECTION_STATE_ABANDONED then
            self:UpdatePlayerState(PlayerID, PLAYER_STATE.ABANDONED)
        end
    end

    return 1
end

-- Изменение золота игрока
function Players:ModifyPlayerGold(PlayerID, gold, reliable, useTarget, useSound, target)
    local PlayerInfo = self:GetPlayer(PlayerID)
    if PlayerInfo == nil or not self:IsActivePlayer(PlayerID) then return -1 end

    local ResultGold = GameRules:ModifyGoldFiltered(PlayerID, gold, reliable, DOTA_ModifyGold_Unspecified)

    if useTarget then
        local PlayerTarget
        local Hero = PlayerInfo.hero
        if self:IsValidHero(Hero) then
            PlayerTarget = Hero
        end
        local Target = target and target or PlayerTarget
        local RealPlayer = PlayerResource:GetPlayer(PlayerID)
        if RealPlayer and Target then
            if useSound then
                EmitSoundOnEntityForPlayer( "General.Sell", Target, PlayerID )
            end
            
            local sequence = 10
            if math.ceil(gold) < 0 then
                sequence = 11
            end
            local normalizedGold = math.abs(math.ceil(gold))
            local fxCoins = ParticleManager:CreateParticleForPlayer("particles/generic_gameplay/lasthit_coins.vpcf", PATTACH_CUSTOMORIGIN, nil, RealPlayer)
            ParticleManager:SetParticleControl(fxCoins, 1, Target:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(fxCoins)
            local num = #tostring(normalizedGold) + 1
            local fxGold = ParticleManager:CreateParticleForPlayer("particles/msg_fx/msg_goldbounty.vpcf", PATTACH_CUSTOMORIGIN, nil, RealPlayer)
            ParticleManager:SetParticleControl(fxGold, 0, Target:GetAbsOrigin() + Vector(0, 0, Target:GetBaseHealthBarOffset()))
            ParticleManager:SetParticleControl(fxGold, 1, Vector(sequence, normalizedGold, 0))
            ParticleManager:SetParticleControl(fxGold, 2, Vector(1, num, 0))
            ParticleManager:SetParticleControl(fxGold, 3, Vector(255, 215, 0))
            ParticleManager:ReleaseParticleIndex(fxGold)
        end
    end

    return ResultGold
end

-- Изменение нетворса игрока
function Players:ModifyPlayerNetworth(PlayerID, value)
	if self.Players[PlayerID] == nil or not self:IsActivePlayer(PlayerID) then return end

    self.Players[PlayerID].networth = math.max(self.Players[PlayerID].networth + value, 0)
    CustomNetTables:SetTableValue("player_info", tostring(PlayerID), {gold = self.Players[PlayerID].networth})

    local hPlayer = PlayerResource:GetPlayer(PlayerID)
    if hPlayer then
        CustomGameEventManager:Send_ServerToPlayer(hPlayer, "UpdateBetInput", {})
    end
end

-- Обновление состояния игрока и соответственно обновление состояния команды, если нужно
function Players:UpdatePlayerState(PlayerID, STATE)
    local PlayerInfo = self:GetPlayer(PlayerID)

    if PlayerInfo == nil then return end

    PlayerInfo.state = STATE

    print(string.format("[PLAYERS] Player %d state changed to %s", PlayerID, STATE))

    if STATE == PLAYER_STATE.ABANDONED or STATE == PLAYER_STATE.LOSER then
        self:TryMakeTeamLose(self:GetPlayerTeamNumber(PlayerID))

        self:UpdatePlayerHero(PlayerID, "KILL")

        Votes:CancelPlayerVote(PlayerID)

        Server:SetPlayerValue(PlayerID, "player_die_round", Rounds:GetCurrentRound())
    elseif STATE == PLAYER_STATE.WINNER then
        self:TryMakeTeamWin(self:GetPlayerTeamNumber(PlayerID))
    end
end

function Players:UpdateLastDuelScore(WinnerTeam)
    local RoundsLastDuelInfo = Rounds:GetLastDuelInfo()

    if RoundsLastDuelInfo == nil then return end

    for _, PlayerID in pairs(RoundsLastDuelInfo) do
        local PlayerInfo = self:GetPlayer(PlayerID)
        if PlayerInfo then
            local Team = PlayerInfo.team

            if Team == WinnerTeam then
                PlayerInfo.last_duel_wins = PlayerInfo.last_duel_wins + 1
            else
                PlayerInfo.last_duel_loses = PlayerInfo.last_duel_loses + 1
            end

            self:UpdatePlayerNetTable(PlayerID)
        end
    end

    for _, PlayerID in pairs(RoundsLastDuelInfo) do
        local PlayerInfo = self:GetPlayer(PlayerID)
        if PlayerInfo then
            local Team = PlayerInfo.team

            if PlayerInfo.last_duel_loses >= LAST_DUEL_LOSES_TO_LOSE then
                self:MakeTeamLose(Team)
            end
        end
    end
end

-- Обновление арены игрока
function Players:UpdateArena(PlayerID, ArenaName, Position, bNeedSetRespawnPoint, bNeedRefresh)
    local PlayerInfo = self:GetPlayer(PlayerID)
    if not PlayerInfo then return end
    if PlayerInfo.arena == ArenaName then return end

    local ArenaInfo = Map:GetArenaInfo(ArenaName)
    if ArenaInfo == nil then return end

    PlayerInfo.arena = ArenaName

    local Pos = Position

    -- Если арена - MAIN то принудительно установить положение по местам спавна игроков
    if ArenaName == "MAIN" then
        local PlayerTeam = self:GetPlayerTeamNumber(PlayerID)
        local filtered = table.filter_list(Entities:FindAllByClassname( "info_player_start_dota" ), true, function(k, v)
            return (v and PlayerTeam == v:GetTeam())
        end)
        if filtered[1] then
            Pos = filtered[1]:GetAbsOrigin()
        end
    end

    if Pos == nil then
        Pos = ArenaInfo.center + RandomVector(RandomFloat(350, 900))
    elseif Pos == "center" then
        Pos = ArenaInfo.center
    end

    PlayerInfo.position = Pos

    self:UpdatePlayerHero(PlayerID, "ARENA_CHANGE", bNeedSetRespawnPoint, bNeedRefresh)
end

-- Обновление героя по разным критериям
function Players:UpdatePlayerHero(PlayerID, CustomCriteria, bNeedSetRespawnPoint, bNeedRefresh)
    local PlayerInfo = self:GetPlayer(PlayerID)

    if PlayerInfo == nil then return end

    local Hero = PlayerInfo.hero
    if self:IsValidHero(Hero) then
        Hero:StopThink("HERO_UPDATING_PLAYER_"..PlayerID)

        Hero:SetContextThink("HERO_UPDATING_PLAYER_"..PlayerID, function()
            if CustomCriteria == "VISUAL_KILL" then
                CustomNetTables:SetTableValue("players", "player_".. PlayerID .."_minigame_dead", {dead = 1})
            end
            if (self:PlayerStateIs(PlayerID, PLAYER_STATE.ABANDONED) or self:PlayerStateIs(PlayerID, PLAYER_STATE.LOSER)) and CustomCriteria == "KILL" then
                if not Hero:IsAlive() then
                    Hero:RespawnUnit()
                end

                Hero:AddNewModifier(Hero, nil, "modifier_duel_curse_cooldown", {})
                Hero:SetContextThink(DoUniqueString("HeroLeaved"), function()
                    Hero:ForceKill(false)
                end, 0.1)
            end

            if self:IsActivePlayer(PlayerID) and CustomCriteria == "ARENA_CHANGE" then
                local ArenaInfo = Map:GetArenaInfo(PlayerInfo.arena)
                if ArenaInfo then
                    if bNeedSetRespawnPoint then
                        Hero:SetRespawnPosition(PlayerInfo.position)
                    end

                    if not Hero:IsAlive() then
                        Hero:RespawnUnit()
                    end

                    if PlayerInfo.arena == "MAIN" then
                        Hero:AddNewModifier(Hero, nil, "modifier_hero_refreshing", {})
                    end

                    if PlayerInfo.arena ~= "MAIN" and Rounds:IsPlayerInPVPDuel(PlayerID) then
                        EmitSoundOn("Hero_LegionCommander.Duel", Hero)
                        Hero:SetContextThink(DoUniqueString("DuelSound"), function()
                            if Hero and not Hero:IsNull() then
                                StopSoundOn("Hero_LegionCommander.Duel", Hero)
                            end
                        end, 1.5)
                    end

                    --Стан перед началом раунда
                    if PlayerInfo.arena ~= "MAIN" and GAME_ROUNDS_TIMINGS[PlayerInfo.arena] ~= nil then
                        local Dur = GAME_ROUNDS_TIMINGS[PlayerInfo.arena]
                        if PlayerInfo.arena == "MINIGAMES" then
                            Dur = Dur + GAME_ROUNDS_TIMINGS["MINIGAMES_DELAY"]
                        end
                        Hero:AddNewModifier(Hero, nil, "modifier_arenas_pre_stun", {duration=Dur})
                    end

                    Hero:SetAngles(0, VectorAngles(ArenaInfo.center - PlayerInfo.position).y, 0)
                    Hero:Stop()

                    ProjectileManager:ProjectileDodge(Hero)

                    Hero:StopThink("HERO_UPDATING_ARENA_PLAYER_"..PlayerID)

                    Hero:SetContextThink("HERO_UPDATING_ARENA_PLAYER_"..PlayerID, function()
                        if PlayerInfo.arena ~= "MAIN" then
                            Hero:RemoveModifierByName("modifier_hero_refreshing")
                        else
                            Hero:RemoveModifierByName("modifier_duel_curse")
                            Hero:RemoveModifierByName("modifier_duel_curse_cooldown")
                        end

                        if PlayerInfo.arena == "MASS_ARENA" then
                            Hero:AddNewModifier(Hero, nil, "modifier_mass_arena_player", {win_buffs=HeroBuilder:GetMinigamesWins(PlayerID)})
                        else
                            Hero:RemoveModifierByName("modifier_mass_arena_player")
                        end

                        if bNeedRefresh then
                            Util:RefreshAbilityAndItem( Hero )
                        end
                        
                        Util:MoveHeroToLocation(PlayerID, PlayerInfo.position)
                        Hero:SetAngles(0, VectorAngles(ArenaInfo.center - Hero:GetAbsOrigin()).y, 0)
                        Hero:Stop()
                    end, 0.1)
                end
            end
        end, 0.1)
    end
end

-- Обновление NetTables для игрока
function Players:UpdatePlayerNetTable(PlayerID)
    if self.Players[PlayerID] == nil then return end

    -- Обновление информации о пвп
    CustomNetTables:SetTableValue("players", "player_"..PlayerID.."_pvp_info", {
        bet_total = self.Players[PlayerID].bet_rewards,
        pvp_wins = self.Players[PlayerID].pvp_wins,
        pvp_loses = self.Players[PlayerID].pvp_loses,
        last_duel_wins = self.Players[PlayerID].last_duel_wins,
        last_duel_loses = self.Players[PlayerID].last_duel_loses,
    })

    PlayerTables:SetTableValue("player_"..PlayerID, "bet_history", self.Players[PlayerID].bet_history)
end

function Players:ClearBets()
    for PlayerID, PlayerInfo in pairs(self:GetAllPlayers()) do
        PlayerInfo.bet_history = {}

        PlayerTables:SetTableValue("player_"..PlayerID, "bet_history", {})
    end
end

function Players:ChangePlayerSelectedUnit(PlayerID, UnitName, bReplace, bCamera)
    local PlayerInfo = self:GetPlayer(PlayerID)
    if PlayerInfo == nil then return end

    local Hero = PlayerInfo.hero
    if Hero == nil then return end

    local UnitToCameraAndSelection = nil

    if bReplace then
        if PlayerInfo.secondary_unit ~= nil then
            UTIL_Remove(PlayerInfo.secondary_unit)
            PlayerInfo.secondary_unit = nil
        end

        -- Прячем оригинального героя
        Hero:AddNewModifier(Hero, nil, "modifier_hero_change", {})
        Hero:AddNoDraw()

        local Arena = PlayerInfo.arena
        local OriginalOrigin = Hero:GetAbsOrigin()

        PlayerInfo.arena = "UNDERWORLD"

        Hero:SetAbsOrigin(Vector(999699, 999699, 0))

        -- Создаём юнита для игрока
        local unit = CreateUnitByName(UnitName, OriginalOrigin, true, Hero, Hero, self:GetPlayerTeamNumber(PlayerID))
        if unit then
            unit:SetEntityName("secondary_unit_"..PlayerID)
            PlayerInfo.secondary_unit = unit
            UnitToCameraAndSelection = unit
            unit.Arena = Arena

            if not unit:HasModifier("modifier_player_cosmetics") then
                unit:AddNewModifier(Hero, nil, "modifier_player_cosmetics", {})
            end

            unit:SetControllableByPlayer(PlayerID, true)
            unit:SetOwner(Hero)

            unit:AddNewModifier(Hero, nil, "modifier_minigames_unit", {team=self:GetPlayerTeamNumber(PlayerID), win_buffs = HeroBuilder:GetMinigamesWins(PlayerID)})
            unit:AddNewModifier(Hero, nil, "modifier_cha_vision", {})

            local ModifName = "modifier_minigames_arena"
            if UnitName == "npc_minigames_pudge" then
                ModifName = "modifier_minigames_pudge"
            elseif UnitName == "npc_minigames_mirana" then
                ModifName = "modifier_minigames_mirana"
            end

            unit:AddNewModifier(Hero, nil, ModifName, {})

            unit:SetIdleAcquire(false)
            unit:SetAcquisitionRange(-150)

            local StunModif = Hero:FindModifierByName("modifier_arenas_pre_stun")
            if StunModif ~= nil then
                unit:AddNewModifier(Hero, nil, "modifier_arenas_pre_stun", {duration=StunModif:GetRemainingTime()})
            end

            local UnitArena = self:GetUnitArena(unit)
            if UnitArena ~= nil then
                local ArenaInfo = Map:GetArenaInfo(UnitArena)
                if ArenaInfo then
                    unit:SetAngles(0, VectorAngles(ArenaInfo.center - unit:GetAbsOrigin()).y, 0)
                end
            end

            CustomNetTables:SetTableValue("players", "player_".. PlayerID .."_select_unit", {entity = unit:entindex()})

            FindClearSpaceForUnit(unit, OriginalOrigin, true)
            ResolveNPCPositions(OriginalOrigin, 300)
        end
    else
        if PlayerInfo.secondary_unit ~= nil then
            UTIL_Remove(PlayerInfo.secondary_unit)
            PlayerInfo.secondary_unit = nil
        end

        CustomNetTables:SetTableValue("players", "player_".. PlayerID .."_select_unit", {entity = Hero:entindex()})

        UnitToCameraAndSelection = Hero

        -- Отображаем оригинального героя
        Hero:RemoveModifierByName("modifier_hero_change")
        Hero:RemoveModifierByName("modifier_cha_vision")
        Hero:RemoveNoDraw()

        CustomNetTables:SetTableValue("players", "player_".. PlayerID .."_minigame_dead", nil)
    end

    if UnitToCameraAndSelection ~= nil and bCamera then
        if PlayerResource:GetConnectionState(PlayerID) == DOTA_CONNECTION_STATE_CONNECTED then 
            PlayerResource:SetCameraTarget(PlayerID, UnitToCameraAndSelection)
            Timers:CreateTimer({ endTime = 0.1, callback = function()
                PlayerResource:SetCameraTarget(PlayerID, nil) 
            end})
        end

        PlayerSelectUnit(PlayerID, UnitToCameraAndSelection, false)
    end
end

function Players:RemoveSecondaryPlayerUnit(PlayerID)
    local PlayerInfo = self:GetPlayer(PlayerID)
    if PlayerInfo == nil then return end
    if PlayerInfo.secondary_unit ~= nil then
        UTIL_Remove(PlayerInfo.secondary_unit)
        PlayerInfo.secondary_unit = nil
    end
end

-- Регистрация игрока в команду, если смогло добавить игрока в команду - возвращает true
function Players:AssignPlayerToTeam(PlayerID, TeamID)
    local PlayerInfo = self:GetPlayer(PlayerID)
    local TeamInfo = self:GetTeam(TeamID)

    if PlayerInfo == nil or TeamInfo == nil then return false end
    
    -- Если игроков уже больше чем нужно, ничего не делать
    if #TeamInfo.players >= PLAYERS_PER_TEAM then return false end

    -- Если игрок уже состоит в какой-то команде - ничего не делать
    if PlayerInfo.team ~= DOTA_TEAM_NOTEAM then return false end

    -- Установка команды для игрока
    PlayerInfo.team = TeamID
    PlayerResource:SetCustomTeamAssignment(PlayerID, TeamID)

    -- Цвет игрока на миникарте/в HUD = цвет его команды. Иконки героев красятся по
    -- цвету ИГРОКА (SetCustomPlayerColor), а не по цвету хелсбара команды — без этого
    -- кастомные команды (6..13) не получают свой цвет на миникарте.
    local c = GameMode and GameMode.GetTeamColor and GameMode:GetTeamColor(TeamID)
    if c then
        PlayerResource:SetCustomPlayerColor(PlayerID, c[1], c[2], c[3])
    end

    -- Добавление игрока в команду, активация команды
    if TeamInfo.state == TEAM_STATE.UNKNOWN then
        TeamInfo.state = TEAM_STATE.IN_GAME
    end
    table.insert(TeamInfo.players, PlayerID)

    PlayerTables:AddPlayerSubscription("team_"..TeamID, PlayerID)

    return true
end

-- Убираем игрока из команды
function Players:UnassignPlayerFromTeam(PlayerID)
    local PlayerInfo = self:GetPlayer(PlayerID)
    if PlayerInfo == nil then return end

    local TeamID = PlayerInfo.team
    local TeamInfo = self:GetTeam(TeamID)
    if TeamInfo == nil then return end

    PlayerInfo.team = DOTA_TEAM_NOTEAM
    PlayerResource:SetCustomTeamAssignment(PlayerID, DOTA_TEAM_NOTEAM)

    table.remove_item(TeamInfo.players, PlayerID)

    if #self:GetTeamPlayers(TeamID, true) == 0 and self:TeamStateIs(TeamID, TEAM_STATE.IN_GAME) then
        TeamInfo.state = TEAM_STATE.UNKNOWN
    end
end

function Players:GetFreeTeam()
    for TeamID, TeamInfo in pairs(self:GetAllTeams()) do
        if #TeamInfo.players < PLAYERS_PER_TEAM then
            return TeamID
        end
    end

    return nil
end

-- Вернуть информацию о игроке
function Players:GetPlayer(PlayerID)
    return self.Players[PlayerID]
end

-- Вернуть информацию о команде
function Players:GetTeam(TeamID)
    return self.Teams[TeamID]
end

-- Вернуть всех игроков
function Players:GetAllPlayers(bList)
    return table.filter_list(self.Players, bList, nil, false)
end

-- Вернуть всех активных игроков
function Players:GetAllActivePlayers(bList)
    return table.filter_list(self.Players, bList, function (k, v)
        return self:IsActivePlayer(k)
    end, false)
end

-- Вернуть всех ливнувших игроков
function Players:GetAllLeavedPlayers(bList)
    return table.filter_list(self.Players, bList, function (k, v)
        return self:PlayerStateIs(k, PLAYER_STATE.LEAVED)
    end, false)
end

-- Вернуть все команды
function Players:GetAllTeams(bList)
    return table.filter_list(self.Teams, bList, nil, false)
end

-- Вернуть все активные команды
function Players:GetAllActiveTeams(bList)
    return table.filter_list(self.Teams, bList, function (k, v)
        return self:IsActiveTeam(k)
    end, false)
end

-- Вернуть все активированные команды
function Players:GetAllActivatedTeams(bList)
    return table.filter_list(self.Teams, bList, function (k, v)
        return v.state ~= TEAM_STATE.UNKNOWN
    end, false)
end

-- Вернуть все активные команды отсортированные по золоту
function Players:GetSortedByGoldActiveTeams(bList, bBigger)
    local Sorted = {}
    for _, TeamID in ipairs(self:GetAllActiveTeams(true)) do
        local data = {
            gold = 0,
            team = TeamID,
        }
        for _, PlayerID in ipairs(self:GetTeamActivePlayers(TeamID, true)) do
            data.gold = data.gold + self:GetPlayerNetworth(PlayerID)
        end
        table.insert(Sorted, data)
    end
    
    if not bBigger then
        table.sort(Sorted, function(a, b) return a.gold < b.gold end)
    else
        table.sort(Sorted, function(a, b) return a.gold > b.gold end)
    end

    if bList then
        return table.map(Sorted, function(k, v)
            return Sorted[k].team
        end, false)
    end

    return Sorted
end

-- Взять игроков из команды
function Players:GetTeamPlayers(TeamID, bList)
    local TeamInfo = self:GetTeam(TeamID)

    if TeamInfo == nil then return {} end

    if bList then
        return TeamInfo.players
    end

    return table.map(TeamInfo.players, function(_, PlayerID)
        return self:GetPlayer(PlayerID)
    end, true), false
end

-- Взять активных игроков из команды
function Players:GetTeamActivePlayers(TeamID, bList)
    local PlayersList, isArray = self:GetTeamPlayers(TeamID, bList)
    return table.filter_list(PlayersList, bList, function (k, v)
        local PlayerID = k
        if bList then
            PlayerID = v
        end
        return self:IsActivePlayer(PlayerID)
    end, isArray)
end

-- Взять команду игрока
function Players:GetPlayerTeam(PlayerID)
    local PlayerInfo = self:GetPlayer(PlayerID)

    if PlayerInfo == nil then return end

    local TeamInfo = self:GetTeam(PlayerInfo.team)

    return TeamInfo
end

-- Взять команду игрока
function Players:GetPlayerTeamNumber(PlayerID)
    local PlayerInfo = self:GetPlayer(PlayerID)

    if PlayerInfo == nil then return DOTA_TEAM_NOTEAM end

    return PlayerInfo.team
end

-- Взять игрока из команды по номеру
function Players:GetTeamPlayerByNum(TeamID, Num)
    local TeamPlayers = table.filter_list(Players:GetTeamPlayers(TeamID, true), true)

    return TeamPlayers[Num], self:GetPlayer(TeamPlayers[Num])
end

-- Взять активного игрока из команды по номеру
function Players:GetTeamActivePlayerByNum(TeamID, Num)
    local TeamPlayers = table.filter_list(Players:GetTeamActivePlayers(TeamID, true), true)

    return TeamPlayers[Num], self:GetPlayer(TeamPlayers[Num])
end

-- Взять нетворс игрока
function Players:GetPlayerNetworth(PlayerID)
    local PlayerInfo = self:GetPlayer(PlayerID)

    if PlayerInfo == nil then return 0 end

    return PlayerInfo.networth
end

-- Взять арену юнита
function Players:GetUnitArena(Unit)
    if not self:IsValidHero(Unit) or not Unit:IsBaseNPC() then return end

    local Arena = Unit.Arena
    local RealUnit = GetRealUnit(Unit)
    local UnitPID = nil
    if Arena == nil and RealUnit and IsRealHero(RealUnit) then
        UnitPID = RealUnit:GetPlayerOwnerID()
        local PlayerInfo = self:GetPlayer(UnitPID)
        if PlayerInfo then
            Arena = PlayerInfo.arena
        end
    end

    return Arena, UnitPID
end

-- Может ли юнит атаковать или кастовать способность в этого юнита или на эту позицию
function Players:IsUnitCanAttackOrCastOnThis(Unit, Target)
    if not self:IsValidHero(Unit) or Target == nil then return false end

    local UnitArena, UnitPID = self:GetUnitArena(Unit)
    local TargetArena = nil
    if Target.IsBaseNPC ~= nil then
        TargetArena = self:GetUnitArena(Target)
    else
        TargetArena = Map:GetPositionArena(Target)
    end
    
    if TargetArena ~= UnitArena and UnitArena ~= nil and TargetArena ~= nil then
        return false, UnitPID
    end

    return true
end

-- Эта команда всё-еще активна?
function Players:IsActiveTeam(TeamID)
    local TeamInfo = self:GetTeam(TeamID)

    if TeamInfo == nil then return false end

    if TeamInfo.state ~= TEAM_STATE.IN_GAME then return false end

    return true
end

-- Этот игрок всё-еще активен?
function Players:IsActivePlayer(PlayerID)
    local PlayerInfo = self:GetPlayer(PlayerID)

    if PlayerInfo == nil or PlayerInfo.team == DOTA_TEAM_NOTEAM then return false end

    if PlayerInfo.state ~= PLAYER_STATE.IN_GAME and PlayerInfo.state ~= PLAYER_STATE.LEAVED then return false end

    if not self:IsActiveTeam(PlayerInfo.team) then return false end

    return true
end

-- Проверка на стейт игрока
function Players:PlayerStateIs(PlayerID, STATE)
    local PlayerInfo = self:GetPlayer(PlayerID)

    if PlayerInfo == nil then return false end

    return PlayerInfo.state == STATE
end

-- Проверка на арену игрока
function Players:PlayerArenaIs(PlayerID, ARENA_NAME)
    local PlayerInfo = self:GetPlayer(PlayerID)

    if PlayerInfo == nil then return false end

    return PlayerInfo.arena == ARENA_NAME
end

-- Проверка на стейт команды
function Players:TeamStateIs(TeamID, STATE)
    local TeamInfo = self:GetTeam(TeamID)

    if TeamInfo == nil then return false end

    return TeamInfo.state == STATE
end

-- Этот юнит - это вторичный юнит игрока
function Players:IsSecondaryUnit(Unit)
    if Unit == nil or Unit:IsNull() then return false end

    for PlayerID, PlayerInfo in pairs(self:GetAllActivePlayers()) do
        if PlayerInfo.secondary_unit == Unit then
            return true
        end
    end

    return false
end

-- Взять героя игрока, который породил этого вторичного юнита
function Players:GetSecondaryUnitHeroPlayer(Unit)
    if Unit == nil or Unit:IsNull() then return nil end

    for PlayerID, PlayerInfo in pairs(self:GetAllActivePlayers()) do
        if PlayerInfo.secondary_unit == Unit then
            return PlayerInfo.hero
        end
    end

    return nil
end

-- Проверка на валидностью героя
function Players:IsValidHero(Hero)
    return Hero and not Hero:IsNull()
end

-- Запуск модуля если он еще не запущен (запускается буквально сразу после require)
if not Players.bStarted then Players:Init() end