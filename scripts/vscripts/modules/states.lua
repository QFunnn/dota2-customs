--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if States == nil then
    _G.States = class({})
end

function States:Init()
    print('[States] Module is active!')
    self.bStarted = true

    self.CurrentState = "PLAYERS_LOADING"
    self.StateTimer = nil
end

function States:StartSettingsState()
    self.CurrentState = "SETTINGS"

    local DefaultDuration = SETTINGS_STATE_DURATIONS["START_VOTING"]

    if IsCheatsEnabled() then
        DefaultDuration = 0
    end

    -- Применяем оверрайды для high-rating лобби ДО любых ветвлений.
    -- Если потом случится custom-settings vote — он перепишет нужные ключи
    -- голосованием (и игроки 4000+ смогут выбрать любое значение).
    self:ApplyHighRatingDefaults()

    -- Если условия для кастомных настроек не выполнены (нет BP / низкий рейтинг) — сразу в баны
    if DefaultDuration == 0 or not self:IsCustomSettingsAllowed() then
        self:StartBansState()
        return
    end

    local VoteDuration = DefaultDuration + 2

    Votes:CreateVote("SETTINGS_STATE", VoteDuration)

    CustomNetTables:SetTableValue("globals", "current_state", {state_name=self.CurrentState, last_time=99999})

    self.StateTimer = Timers:CreateTimer(VoteDuration, function()
        if self.CurrentState == "SETTINGS" then
            self.StateTimer = nil
            local Result, Progress, ResultCount = Votes:EndVote("SETTINGS_STATE", true, true)
            Votes:ClearVote("SETTINGS_STATE")

            if Result == 0 then
                States:StartBansState()
            else
                self.StateTimer = Timers:CreateTimer(1, function()
                    self.StateTimer = nil
                    States:StartCustomDifficultSelection()
                end)
            end
        end
    end)
end

-- Возвращает средний рейтинг активных игроков лобби, либо nil если посчитать
-- невозможно (нет игроков / нет Server API).
function States:GetAverageLobbyRating()
    -- Передаём true -- получаем массив PlayerID-ов с 1-based ключами (можно ipairs).
    -- Без true возвращается таблица {[PID] = info} -- если PID=0 (типичный для
    -- одиночного теста) или PID-ы не consecutive, #players ломается и ipairs
    -- ничего не итерирует.
    local players = Players:GetAllActivePlayers(true)
    if players == nil or #players == 0 then return nil end

    local totalRating = 0
    local count = 0
    for _, PlayerID in ipairs(players) do
        local rating = 0
        if Server and Server.GetPlayerRating then
            rating = Server:GetPlayerRating(PlayerID) or 0
        end
        totalRating = totalRating + rating
        count = count + 1
    end

    if count == 0 then return nil end
    return totalRating / count
end

function States:IsCustomSettingsAllowed()
    local MinAverageRating = 4000

    local players = Players:GetAllActivePlayers(true)
    if players == nil or #players == 0 then return false end

    for _, PlayerID in ipairs(players) do
        if Server and Server.IsPlayerBattlePassSubscribed then
            if not Server:IsPlayerBattlePassSubscribed(PlayerID) then
                return false
            end
        end
    end

    local avgRating = self:GetAverageLobbyRating()
    if avgRating == nil then return false end
    return avgRating > MinAverageRating
end

-- При среднем рейтинге лобби > 3500 в DEFAULT-настройках убираем выдачу SSS
-- способности на первый выбор (игроки получают только базовые). При рейтинге
-- 4000+ лобби может включить custom-голосование и выбрать любое значение
-- SSS_FIRST_ABILITY_COUNT (0/1/2/3) — оно перепишет наш дефолт.
function States:ApplyHighRatingDefaults()
    local avgRating = self:GetAverageLobbyRating()
    if avgRating ~= nil and avgRating > 3500 then
        GAME_SETTINGS["DEFAULT"].SSS_FIRST_ABILITY_COUNT = 0
    end
end

function States:StartCustomDifficultSelection()
    if self.StateTimer ~= nil then
        Timers:RemoveTimer(self.StateTimer)
        self.StateTimer = nil
    end

    local VoteDuration = SETTINGS_STATE_DURATIONS["CUSTOM_VOTING"]

    Votes:CreateVote("INIT_REROLLS", VoteDuration)
    Votes:CreateVote("INIT_LIFES", VoteDuration)
    Votes:CreateVote("SSS_COUNT_FIRST", VoteDuration)
    Votes:CreateVote("FIRST_ABILITY_IS_GENERAL", VoteDuration)
    Votes:CreateVote("HAS_SKILLS_SELECT", VoteDuration)
    Votes:CreateVote("CREEP_BONUS_ARMOR", VoteDuration)
    Votes:CreateVote("CREEP_BONUS_MAGIC_RESISTANCE", VoteDuration)
    Votes:CreateVote("ROUND_WHEN_LOSE_AEGIS", VoteDuration)
    Votes:CreateVote("ROUND_WHEN_CAN_SUMMON_CREEPS", VoteDuration)

    self.StateTimer = Timers:CreateTimer(VoteDuration, function()
        if self.CurrentState == "SETTINGS" then
            self.StateTimer = nil
            local Result, Progress, ResultCount = Votes:EndVote("INIT_REROLLS", true, true)
            Votes:ClearVote("INIT_REROLLS")
            GAME_SETTINGS["DEFAULT"].PLAYER_INIT_REROLLS = Result

            Result, Progress, ResultCount = Votes:EndVote("INIT_LIFES", true, true)
            Votes:ClearVote("INIT_LIFES")
            GAME_SETTINGS["DEFAULT"].PLAYER_INIT_LIFES = Result

            Result, Progress, ResultCount = Votes:EndVote("SSS_COUNT_FIRST", true, true)
            Votes:ClearVote("SSS_COUNT_FIRST")
            GAME_SETTINGS["DEFAULT"].SSS_FIRST_ABILITY_COUNT = Result

            Result, Progress, ResultCount = Votes:EndVote("FIRST_ABILITY_IS_GENERAL", true, true)
            Votes:ClearVote("FIRST_ABILITY_IS_GENERAL")
            GAME_SETTINGS["DEFAULT"].FIRST_ABILITY_IS_GENERAL = Result

            Result, Progress, ResultCount = Votes:EndVote("HAS_SKILLS_SELECT", true, true)
            Votes:ClearVote("HAS_SKILLS_SELECT")
            GAME_SETTINGS["DEFAULT"].HAS_SKILLS_SELECT = Result

            Result, Progress, ResultCount = Votes:EndVote("CREEP_BONUS_ARMOR", true, true)
            Votes:ClearVote("CREEP_BONUS_ARMOR")
            GAME_SETTINGS["DEFAULT"].CREEP_BONUS_ARMOR_PER_LATE_ROUND = Result

            Result, Progress, ResultCount = Votes:EndVote("CREEP_BONUS_MAGIC_RESISTANCE", true, true)
            Votes:ClearVote("CREEP_BONUS_MAGIC_RESISTANCE")
            GAME_SETTINGS["DEFAULT"].CREEP_BONUS_MAGIC_RESISTANCE_PER_LATE_ROUND = Result

            Result, Progress, ResultCount = Votes:EndVote("ROUND_WHEN_LOSE_AEGIS", true, true)
            Votes:ClearVote("ROUND_WHEN_LOSE_AEGIS")
            GAME_SETTINGS["DEFAULT"].ROUND_WHEN_LOSE_AEGIS = Result

            Result, Progress, ResultCount = Votes:EndVote("ROUND_WHEN_CAN_SUMMON_CREEPS", true, true)
            Votes:ClearVote("ROUND_WHEN_CAN_SUMMON_CREEPS")
            GAME_SETTINGS["DEFAULT"].ROUND_WHEN_CAN_SUMMON_CREEPS = Result

            self.StateTimer = Timers:CreateTimer(1, function()
                self.StateTimer = nil
                States:StartCustomSelectionResults()
            end)
        end
    end)
end

function States:StartCustomSelectionResults()
    if self.StateTimer ~= nil then
        Timers:RemoveTimer(self.StateTimer)
        self.StateTimer = nil
    end

    local ResultsDuration = SETTINGS_STATE_DURATIONS["CUSTOM_VOTE_RESULTS"]

    local CurrentSettings = {}
    for SETTING_NAME, SETTING_VALUE in pairs(GAME_SETTINGS.DEFAULT) do
        if SETTING_NAME ~= "DIFFICULT" then
            table.insert(CurrentSettings, {name = SETTING_NAME, value = GetGameSetting(SETTING_NAME)})
        end
    end
    
    CustomNetTables:SetTableValue("globals", "current_game_settings", CurrentSettings)
    CustomNetTables:SetTableValue("globals", "current_state_time", {last_time = GameRules:GetGameTime() + ResultsDuration})

    self.StateTimer = Timers:CreateTimer(ResultsDuration, function()
        if self.CurrentState == "SETTINGS" then
            self.StateTimer = nil
            States:StartBansState()
        end
    end)
end

function States:StartBansState()
    if self.StateTimer ~= nil then
        Timers:RemoveTimer(self.StateTimer)
        self.StateTimer = nil
    end

    self.CurrentState = "BANS"

    -- if IsInToolsMode() then
    --     HeroDemo:FillLobyWithBots()
    -- end

    HeroBuilder:InitPlayersAfterSettings()

    local CurrentSettings = {}
    for SETTING_NAME, SETTING_VALUE in pairs(GAME_SETTINGS.DEFAULT) do
        if SETTING_NAME ~= "DIFFICULT" then
            table.insert(CurrentSettings, {name = SETTING_NAME, value = GetGameSetting(SETTING_NAME)})
        end
    end

    Rounds:UpdateDynamicSettings()

    CustomNetTables:SetTableValue("globals", "current_game_settings", CurrentSettings)

    local BanStateDuration = GetGameSetting("BANNING_STATE_DURATION")

    if IsCheatsEnabled() then
        BanStateDuration = 0
    end

    if BanStateDuration == 0 then
        self:StartHeroPickState()
        return
    end
 
    local LastTime = GameRules:GetGameTime() + BanStateDuration + 2

    CustomNetTables:SetTableValue("globals", "current_state", {state_name=self.CurrentState, last_time=LastTime})

    self.StateTimer = Timers:CreateTimer(BanStateDuration + 2, function()
        if self.CurrentState == "BANS" then
            self.StateTimer = nil
            States:StartHeroPickState()
        end
    end)
end

function States:StartHeroPickState()
    if self.StateTimer ~= nil then
        Timers:RemoveTimer(self.StateTimer)
        self.StateTimer = nil
    end

    self.CurrentState = "HERO_PICK"

    local TierTable = {}

    if SPEICAL_TIERS_TABLE and SPEICAL_TIERS_TABLE.ABILITIES and SPEICAL_TIERS_TABLE.ABILITIES.SSS then
        for CategoryName, List in pairs(SPEICAL_TIERS_TABLE.ABILITIES.SSS) do
            TierTable[CategoryName] = {}
            for _, AbilityName in ipairs(List) do
                if not KeyValues:IsBannedAbility(AbilityName) then
                    table.insert(TierTable[CategoryName], AbilityName)
                end
            end
        end
    end

    -- CustomNetTables:SetTableValue("globals", "unbanned_sss_abilities", TierTable)
    PlayerTables:SetTableValue("globals", "unbanned_sss_abilities", TierTable)

    HeroBuilder:UpdateHeroPick()

    local PickStateDuration = GetGameSetting("PICK_STATE_DURATION")

    -- Раньше в чит-режиме (тулзы / sv_cheats 1) фаза пиков пропускалась моментально.
    -- Это мешало тестировать UI и логику пика (например, SSS-лимит в пуле героев,
    -- рероллы, локи) -- приходилось публиковать в Workshop. Теперь пик идёт штатно
    -- с дефолтной длительностью даже в тулзах.
    -- Если нужно вернуть автоскип для конкретных сессий -- используй sv_cheats 1
    -- и в консоли: script GetGameSetting("PICK_STATE_DURATION") чтобы посмотреть значение,
    -- либо вручную ускорь через выбор героя.
    -- Settings и Bans фазы по-прежнему скипаются (см. StartSettingsState/StartBansState).
    if PickStateDuration == 0 then
        self:FinishCustomStates()
        return
    end

    local LastTime = GameRules:GetGameTime() + PickStateDuration + 2

    CustomNetTables:SetTableValue("globals", "current_state", {state_name=self.CurrentState, last_time=LastTime})

    self.StateTimer = Timers:CreateTimer(PickStateDuration + 2, function()
        if self.CurrentState == "HERO_PICK" then
            self.StateTimer = nil
            States:FinishCustomStates()
        end
    end)
end

function States:FinishCustomStates()
    if self.StateTimer ~= nil then
        Timers:RemoveTimer(self.StateTimer)
        self.StateTimer = nil
    end

    self.CurrentState = "FINISH"

    HeroBuilder:SelectRandomHeroesForPlayers()

    CustomNetTables:SetTableValue("globals", "current_state", {state_name=self.CurrentState, last_time=0})

    -- Disconnect hero fix: до перехода в HERO_SELECTION пробегаем по PID'ам с state != IN_GAME
    -- и для каждого зовём `Player:SetSelectedHero` (если hPlayer ещё валиден).
    -- Engine запоминает selection и при transition сам спавнит hero с правильным PID-binding.
    -- Без этого engine не знает про их выбор -> hero не спавнится -> flow ломается.
    -- Делаем синхронно, без таймера: SetSelectedHero идемпотентен, engine разрулит.
    if HeroBuilder and HeroBuilder.HandleDisconnectedPicksAtFinish then
        HeroBuilder:HandleDisconnectedPicksAtFinish()
    end

    -- [ANTI-TAMPER] belt-and-suspenders: на локальном (не Valve-dedicated, не tools) сервере
    -- НЕ завершаем сетап — кастомка остаётся на загрузке (основной гейт — в addon_game_mode.lua
    -- на старте CUSTOM_GAME_SETUP; сюда поток в норме даже не дойдёт).
    if not IsInToolsMode() and not IsDedicatedServer() then
        print("[ANTI-TAMPER] local/listen server -> FinishCustomGameSetup blocked")
        return
    end

    GameRules:FinishCustomGameSetup()
end

function States:GetState()
    return self.CurrentState
end

if not States.bStarted then States:Init() end