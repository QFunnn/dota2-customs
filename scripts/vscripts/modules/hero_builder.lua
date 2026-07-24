--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if HeroBuilder == nil then
    HeroBuilder = class({})
end

-- Сколько БЕСПЛАТНЫХ офферов героев на игрока гарантированно уникальны между всеми
-- игроками лобби (стартовый оффер + бесплатные рероллы). Дефолт 2 = стартовый + 1
-- бесплатный реролл → на 8 игроков резервируется 2*8*4 = 64 разных героя.
-- Ограничение сознательное: даже если кастомные настройки дают больше бесплатных
-- рероллов, уникальность держим только на первых FREE_UNIQUE_HERO_OFFERS офферах
-- (иначе на 3+ офферах пула героев физически не хватит на всех). Рероллы сверх
-- этого и все платные — обычные случайные (без банов), уникальность не гарантируется.
local FREE_UNIQUE_HERO_OFFERS = 2

function HeroBuilder:Init()
    print('[HeroBuilder] Module is active!')
    self.bStarted = true

    CustomGameEventManager:RegisterListener("builder_reroll_heroes", function(_, event) self:OnPlayerWantRerollHeroes(event) end)
    CustomGameEventManager:RegisterListener("builder_random_hero", function(_, event) self:OnPlayerWantRandomHero(event) end)
    CustomGameEventManager:RegisterListener("builder_select_hero",function(_, event) self:OnPlayerWantSelectHero(event) end)
    CustomGameEventManager:RegisterListener("builder_lock_hero",function(_, event) self:OnPlayerWantLockHero(event) end)
    CustomGameEventManager:RegisterListener("AbilitySelected",function(_, event) self:AbilitySelected(event) end)
    CustomGameEventManager:RegisterListener("builder_relearn_book_selected",function(_, event) self:RelearnBookAbilitySelected(event) end)
    CustomGameEventManager:RegisterListener("builder_omniscient_selected",function(_, event) self:OnPlayerOmniscientSelectedAbility(event) end)
    CustomGameEventManager:RegisterListener("builder_omniscient_closed",function(_, event) self:OnPlayerOmniscientClosed(event) end)
    CustomGameEventManager:RegisterListener("SwapAbility",function(_, event) self:SwapAbility(event) end)
    CustomGameEventManager:RegisterListener("RefreshHeroBindings",function(userID, event) self:OnRefreshHeroBindings(userID, event) end)
    CustomGameEventManager:RegisterListener("ReorderComplete",function(_, event) self:ReorderComplete(event) end)

    CustomGameEventManager:RegisterListener("builder_skill_selected",function(_, event) self:OnPlayerSelectedSkill(event) end)

    CustomGameEventManager:RegisterListener("ability_selection_ability_selected",function(_, event) self:OnPlayerAbilitySelected(event) end)

    self.AbilitiesCounter = {
        bloodseeker_thirst = 1,
    }

    self.Precache = {}

    self.SpawnGroupsByHeroNames = {}

    self.Players = {}

    -- Набор героев, уже выданных в БЕСПЛАТНЫЕ офферы любому игроку в этой фазе пика.
    -- Нужен, чтобы бесплатные выборы (стартовый + бесплатные рероллы) не пересекались
    -- между игроками — у всех уникальные герои. Сбрасывается в UpdateHeroPick.
    -- Платные рероллы его игнорируют (там герои полностью случайные, только без банов).
    self.FreeUsedHeroes = {}

    self.IdealAbilitiesList = {}
end

function HeroBuilder:LoadPlayer(PlayerID)
    if not self.Players[PlayerID] and PlayerResource:GetTeam(PlayerID) ~= 1 then
        self.Players[PlayerID] = {
            ability_select_count = PLAYER_INIT_SELECTION_ABILITIES_COUNT,
            lifes_count = 0,
            reroll_count = 0,
            selected_hero = "",
            selected_hero_ent = nil,
            settled = false,
            random_heroes = {},
            random_abilities = {},
            attack_capability = DOTA_UNIT_CAP_NO_ATTACK,
            attack_capability_changed = false,
            has_scepter = false,
            books = 0,
            pages = 0,
            smoke_count = 0,
            lifes_count_server = 0,
            loser_curse_count = 0,

            abilities_selection_schedule = {},
            abilities_selection_current = nil,

            SSS_ability_select_count = 1,

            minigames_wins = 0,

            locked_hero = nil,
            reroll_times = 0,
            reroll_count_free = 1,

            -- Сколько уникальных (зарезервированных) бесплатных офферов уже выдано
            -- этому игроку. Стартовый оффер = 1; ограничен FREE_UNIQUE_HERO_OFFERS.
            free_offers_reserved = 0,

            abilities_list = {},
            abilities_list_server = {},

            skills_list = {},
            skills_points = 0,
            skills_current_selecting = nil,

            attribute_book_str = 0,
            attribute_book_agi = 0,
            attribute_book_int = 0,

            extra_creeps = {},
        }
    end
end

function HeroBuilder:UnloadPlayer(PlayerID)
    self.Players[PlayerID] = nil
end

function HeroBuilder:InitPlayersAfterSettings()
    local FreeRerolls = GetGameSetting("PLAYER_INIT_REROLLS")
    for PlayerID, PlayerInfo in pairs(self.Players) do
        PlayerInfo.reroll_count = FreeRerolls + PLAYER_EXTRA_PAID_REROLLS
        PlayerInfo.reroll_count_free = FreeRerolls
        PlayerInfo.smoke_count = GetGameSetting("PLAYER_INIT_SMOKES")
        PlayerInfo.lifes_count = GetGameSetting("PLAYER_INIT_LIFES")
        PlayerInfo.lifes_count_server = GetGameSetting("PLAYER_INIT_LIFES")
    end
end

function HeroBuilder:InitPlayerSettings(PlayerID)
    local PlayerInfo = self:GetPlayerInfo(PlayerID)
    if PlayerInfo == nil then return end

    local FreeRerolls = GetGameSetting("PLAYER_INIT_REROLLS")
    PlayerInfo.reroll_count = FreeRerolls + PLAYER_EXTRA_PAID_REROLLS
    PlayerInfo.reroll_count_free = FreeRerolls
    PlayerInfo.smoke_count = GetGameSetting("PLAYER_INIT_SMOKES")
    PlayerInfo.lifes_count = GetGameSetting("PLAYER_INIT_LIFES")
    PlayerInfo.lifes_count_server = GetGameSetting("PLAYER_INIT_LIFES")
end

function HeroBuilder:OnPlayerAddedExtraCreep(PlayerID, CreepName, Round)
    if self.Players[PlayerID] == nil then return end

    table.insert(self.Players[PlayerID].extra_creeps, {creep_name = CreepName, round = Round, deleted = false})
end

function HeroBuilder:UpdatePlayerExtraCreeps(PlayerID)
    if self.Players[PlayerID] == nil then return end

    for _, ExtraCreepInfo in ipairs(self.Players[PlayerID].extra_creeps) do
        if not Rounds:IsThisExtraCreepCanBeLive(PlayerID, ExtraCreepInfo.round) then
            ExtraCreepInfo.deleted = true
        end
    end
end

function HeroBuilder:UpdateLoserCurseCount(PlayerID)
    if self.Players[PlayerID] == nil then return false end

    local Hero = self.Players[PlayerID].selected_hero_ent

    if Hero == nil then return end
    
    local Modif = Hero:FindModifierByName("modifier_loser_curse")
    if Modif then
        self.Players[PlayerID].loser_curse_count = Modif:GetStackCount() or 0
    else
        self.Players[PlayerID].loser_curse_count = 0
    end
end

function HeroBuilder:UpdateMinigamesWins(PlayerID, value)
    if self.Players[PlayerID] == nil then return false end

    local Hero = self.Players[PlayerID].selected_hero_ent

    if Hero == nil then return end

    self.Players[PlayerID].minigames_wins = math.max(self.Players[PlayerID].minigames_wins + value, 0)

    local UpdateWins = function()
        if self.Players[PlayerID].minigames_wins > 0 then
            local Modif = Hero:FindModifierByName("modifier_minigames_win_buff") or Hero:AddNewModifier(Hero, nil, "modifier_minigames_win_buff", {})
            if Modif then
                Modif:SetStackCount(self.Players[PlayerID].minigames_wins)
            end
        else
            Hero:RemoveModifierByName("modifier_minigames_win_buff")
        end
    end

    if Hero:IsAlive() then
        UpdateWins()
    else
        Hero:StopThink("PLAYER_MINIGAMES_WINS_UPDATE")

        Hero:SetContextThink("PLAYER_MINIGAMES_WINS_UPDATE", function(unit)
        if unit and not unit:IsNull() and Players:IsActivePlayer(PlayerID) then
            if not unit:IsAlive() then
                return 0.1
            else
                UpdateWins()
            end
        end
    end, 0)
    end
end

function HeroBuilder:GetMinigamesWins(PlayerID)
    if self.Players[PlayerID] == nil then return 0 end

    return self.Players[PlayerID].minigames_wins
end

function HeroBuilder:UpdateSmokeCount(PlayerID)
    if self.Players[PlayerID] == nil then return false end

    local Hero = self.Players[PlayerID].selected_hero_ent

    if Hero == nil then return end
    
    local Item = Hero:FindItemInInventory("item_smoke_of_deceit_custom")
    if Item and not Item:IsNull() then
        self.Players[PlayerID].smoke_count = Item:GetCurrentCharges() or 0
    else
        self.Players[PlayerID].smoke_count = 0
    end
end

function HeroBuilder:GetAllPlayers()
    return self.Players
end

function HeroBuilder:GetAllPlayersWhoSelectedHero()
    local All = {}

    for PID, PI in pairs(self.Players) do
        if PI.selected_hero ~= "" then
            All[PID] = PI
        end
    end

    return All
end

function HeroBuilder:TriggerEndHeroPick()
    local AllPicked = true

    for PlayerID, PlayerInfo in pairs(self.Players) do
        if PlayerInfo.selected_hero == "" and PlayerResource:GetConnectionState(PlayerID) == DOTA_CONNECTION_STATE_CONNECTED then
            AllPicked = false
        end
    end

    if AllPicked and States:GetState() ~= "FINISH" then
        Timers:CreateTimer(2, function ()
            if States:GetState() ~= "FINISH" then
                States:FinishCustomStates()
            end
        end)
    end
end

function HeroBuilder:SelectRandomHeroesForPlayers()
    for PlayerID, PlayerInfo in pairs(self.Players) do
        if self.Players[PlayerID].selected_hero ==  "" then
            -- Disc-fix v5: для disconnected игроков engine мог УЖЕ запомнить hero
            -- через `SetSelectedHero` в OnPlayerDisconnected (DC@FORCE_PICK ветка).
            -- Если так -- ОБЯЗАТЕЛЬНО синхронизируем HeroBuilder.selected_hero с engine,
            -- иначе будет рассинхрон (HeroBuilder=random_новый, engine=DC_random) и
            -- любая логика которая полагается на HeroBuilder.selected_hero (продажа,
            -- крафт нейтралки, UI меню дуэлей) сломается / крашит клиент.
            local engineHero = PlayerResource:GetSelectedHeroName(PlayerID)
            if engineHero and engineHero ~= "" then
                self.Players[PlayerID].selected_hero = engineHero
                -- NOTE: используем print напрямую, потому что local DiscLog объявлена ниже
                -- в файле (стр. ~368) и в SelectRandomHeroesForPlayers ещё не видна.
                print(string.format("[HeroBuilder/Disc] SelectRandomHeroesForPlayers(PID=%d): sync HeroBuilder.selected_hero <- engineHero='%s'",
                    PlayerID, engineHero))
            else
                if #self.Players[PlayerID].random_heroes == 0 then
                    self.Players[PlayerID].random_heroes = self:GenerateListRandomHeroes(PlayerID)
                end
                self.Players[PlayerID].selected_hero = table.random(self.Players[PlayerID].random_heroes)
            end

            self:UpdatePlayerNetTable(PlayerID)
        end
    end
end

function HeroBuilder:GetPlayerInfo(PlayerID)
    return self.Players[PlayerID]
end

function HeroBuilder:IsPlayerSelectingAbility(PlayerID)
    if self.Players[PlayerID] == nil then return false end

    return self.Players[PlayerID].selecting_ability_instance ~= ""
end

function HeroBuilder:IsPlayerHasSelectAbilitiesPoints(PlayerID)
    if self.Players[PlayerID] == nil then return false end

    return self.Players[PlayerID].ability_select_count > 0
end

function HeroBuilder:IsPlayerCanSelectAbilities(PlayerID)
    return (self:IsPlayerHasSelectAbilitiesPoints(PlayerID) and not self:IsPlayerSelectingAbility(PlayerID))
end

function HeroBuilder:IsPlayerHasAbilities(PlayerID)
    if self.Players[PlayerID] == nil then return false end

    return #self.Players[PlayerID].abilities_list > 0
end

function HeroBuilder:GetPlayerAbilities(PlayerID)
    if self.Players[PlayerID] == nil then return {} end

    return self.Players[PlayerID].abilities_list or {}
end

function HeroBuilder:SetSelectingInstance(PlayerID, instance)
    if self.Players[PlayerID] == nil then return end

    self.Players[PlayerID].selecting_ability_instance = instance
end

function HeroBuilder:IsPlayerSelectAbilities(PlayerID)
    if self.Players[PlayerID] == nil then return false end

    return self.Players[PlayerID].abilities_selection_current ~= nil
end

function HeroBuilder:IncrementBooks(PlayerID)
    if self.Players[PlayerID] == nil then return end

    self.Players[PlayerID].books = self.Players[PlayerID].books + 1

    CustomNetTables:SetTableValue("players", "player_".. PlayerID .."_collected_data", {books = self.Players[PlayerID].books, pages = self.Players[PlayerID].pages})
end

function HeroBuilder:IncrementPages(PlayerID)
    if self.Players[PlayerID] == nil then return end

    self.Players[PlayerID].pages = self.Players[PlayerID].pages + 1

    CustomNetTables:SetTableValue("players", "player_".. PlayerID .."_collected_data", {books = self.Players[PlayerID].books, pages = self.Players[PlayerID].pages})
end

function HeroBuilder:IncrementAttributeBook(PlayerID, BookName)
    if self.Players[PlayerID] == nil or self.Players[PlayerID][BookName] == nil then return end

    self.Players[PlayerID][BookName] = self.Players[PlayerID][BookName] + 1
end

function HeroBuilder:OnPlayerWantSelectHero(event)
    local PlayerID = event.PlayerID
    local HeroName = event.hero_name
    if HeroName == nil or self.Players[PlayerID] == nil or self.Players[PlayerID].selected_hero ~= "" then return end

    self.Players[PlayerID].selected_hero = HeroName

    self:UpdatePlayerNetTable(PlayerID)

    self:TriggerEndHeroPick()
end

function HeroBuilder:OnPlayerWantLockHero(event)
    local PlayerID = event.PlayerID
    if self.Players[PlayerID] == nil then return end

    if not Server:IsPlayerBattlePassSubscribed(PlayerID) then return end

    if self.Players[PlayerID].locked_hero == event.heroname then
        self.Players[PlayerID].locked_hero = nil
    else
        self.Players[PlayerID].locked_hero = event.heroname
    end

    self:UpdatePlayerNetTable(PlayerID)
end

function HeroBuilder:OnPlayerWantRandomHero(event)
    local PlayerID = event.PlayerID
    if self.Players[PlayerID] == nil or self.Players[PlayerID].selected_hero ~= "" then return end

    self.Players[PlayerID].random_heroes = self:GenerateListRandomHeroes(PlayerID)

    self.Players[PlayerID].selected_hero = table.random(self.Players[PlayerID].random_heroes)

    self:UpdatePlayerNetTable(PlayerID)

    self:TriggerEndHeroPick()
end

--------------------------------------------------------------------------------
-- DISCONNECT / RECONNECT / FORCE-CREATE LOGIC
--------------------------------------------------------------------------------
-- Все строки логов префиксованы `[HeroBuilder/Disc]`, чтобы grep'ом по console.log
-- было легко вытащить полную картину одного цикла теста.
--
-- Архитектура:
--   1. На дисконнекте пикаем рандомного героя в `selected_hero` (PreSelect).
--   2. На переходе HERO_SELECTION в addon_game_mode.lua SkipSetSelectedHero для disconnected
--      (иначе engine queue'ит async-спавн => дубль с нашим STRATEGY_TIME ForceCreate).
--   3. На STRATEGY_TIME для PID без hero-entity делаем ForceCreate с retry.
--   4. На реконнекте либо перехватываем control, либо ForceCreate если hero нет.
--------------------------------------------------------------------------------

local function DiscLog(fmt, ...)
    print("[HeroBuilder/Disc] " .. string.format(fmt, ...))
end

-- Удобный шорткат для строки имени состояния подключения (только для логов).
local CONN_STATE_NAMES = {
    [DOTA_CONNECTION_STATE_UNKNOWN]      = "UNKNOWN",
    [DOTA_CONNECTION_STATE_NOT_YET_CONNECTED] = "NOT_YET",
    [DOTA_CONNECTION_STATE_CONNECTED]    = "CONNECTED",
    [DOTA_CONNECTION_STATE_DISCONNECTED] = "DISCONNECTED",
    [DOTA_CONNECTION_STATE_ABANDONED]    = "ABANDONED",
    [DOTA_CONNECTION_STATE_FAILED]       = "FAILED",
}
local function ConnName(PlayerID)
    if not PlayerResource:IsValidPlayerID(PlayerID) then return "INVALID_PID" end
    return CONN_STATE_NAMES[PlayerResource:GetConnectionState(PlayerID)] or "?"
end

--- Проверка наличия валидного hero-entity у PID через 3 источника:
---   * PlayerResource:GetSelectedHeroEntity (стандартный API)
---   * Players.Players[PID].hero (модуль Players)
---   * Линейный проход HeroList с фильтром GetPlayerID
--- В edge-cases один источник может врать -- проверяем все.
function HeroBuilder:HasHeroForPlayer(PlayerID)
    if PlayerID == nil or PlayerID < 0 then return false end

    local entA = PlayerResource:GetSelectedHeroEntity(PlayerID)
    if entA and not entA:IsNull() then
        return true, "GetSelectedHeroEntity"
    end

    local pInfo = Players and Players.Players and Players.Players[PlayerID]
    if pInfo and pInfo.hero and not pInfo.hero:IsNull() then
        return true, "Players.Players[PID].hero"
    end

    for _, h in ipairs(HeroList:GetAllHeroes() or {}) do
        if h and not h:IsNull() and h.GetPlayerID and h:GetPlayerID() == PlayerID then
            return true, "HeroList sweep"
        end
    end

    return false, nil
end

--- Пикает случайного героя для disconnected/leaved игрока, чтобы стандартный flow
--- спавна (HERO_SELECTION) мог его подхватить. НЕ зовёт SetSelectedHero -- это
--- произойдёт в addon_game_mode.lua и только для CONNECTED, иначе дубль-спавн.
function HeroBuilder:PreSelectHeroForDisconnected(PlayerID)
    if not self.Players[PlayerID] then
        DiscLog("PreSelectHero(PID=%d): нет записи в HeroBuilder.Players, skip", PlayerID)
        return
    end

    if self.Players[PlayerID].selected_hero ~= nil
       and self.Players[PlayerID].selected_hero ~= "" then
        DiscLog("PreSelectHero(PID=%d): selected_hero уже '%s', skip",
            PlayerID, tostring(self.Players[PlayerID].selected_hero))
        return
    end

    self.Players[PlayerID].random_heroes = self:GenerateListRandomHeroes(PlayerID)
    local pick = table.random(self.Players[PlayerID].random_heroes)
    if not pick or pick == "" then
        DiscLog("PreSelectHero(PID=%d): random pool пустой -- не смогли пикнуть", PlayerID)
        return
    end

    self.Players[PlayerID].selected_hero = pick
    self:UpdatePlayerNetTable(PlayerID)

    -- Прекэш на всякий случай (модели/звуки), чтобы спавн в HERO_SELECTION не споткнулся.
    PrecacheUnitByNameAsync(pick, function() end, PlayerID)

    DiscLog("PreSelectHero(PID=%d): назначен '%s'", PlayerID, pick)
end

--- Попытка создать hero-entity для PID, у которого его до сих пор нет.
--- Раньше тут был retry-loop на 60 попыток, но по логам CDOTAPlayer для disconnected
--- НИКОГДА не воскресает (16+ retry с hPlayer=nil подряд) -- так что бесполезно.
--- Теперь делаем 1 попытку: если hPlayer жив -- CreateHeroForPlayer, иначе сразу выходим.
--- Сценарий fully-abandoned игрока обрабатывает `MarkPlayerAbandoned` через 60с таймер.
function HeroBuilder:ForceCreateHeroForDisconnectedPlayer(PlayerID)
    if not self.Players[PlayerID] then
        DiscLog("ForceCreate(PID=%d): нет записи HeroBuilder, abort", PlayerID)
        return
    end

    -- Защита от дублей: 3-source check
    local hasHero, source = self:HasHeroForPlayer(PlayerID)
    if hasHero then
        DiscLog("ForceCreate(PID=%d): hero уже есть (источник: %s), skip", PlayerID, source)
        return
    end

    local heroName = self.Players[PlayerID].selected_hero
    if not heroName or heroName == "" then
        DiscLog("ForceCreate(PID=%d): selected_hero пустой -- пикаю сейчас", PlayerID)
        self:PreSelectHeroForDisconnected(PlayerID)
        heroName = self.Players[PlayerID].selected_hero
        if not heroName or heroName == "" then
            DiscLog("ForceCreate(PID=%d): даже после PreSelect пусто, abort", PlayerID)
            return
        end
    end

    local hPlayer = PlayerResource:GetPlayer(PlayerID)
    DiscLog("ForceCreate(PID=%d): heroName=%s, hPlayer=%s, conn=%s",
        PlayerID, heroName, tostring(hPlayer), ConnName(PlayerID))

    if hPlayer and not hPlayer:IsNull() then
        -- Используем ТОЛЬКО `SetSelectedHero` -- стандартный engine-путь, который сам
        -- создаёт hero-entity + биндит к PID + даёт control + ставит в engine-slot.
        --
        -- Раньше пробовали `CreateHeroForPlayer` + `SetSelectedHero` подряд, но это
        -- создавало hero, которым клиент не управлял (entity видна, но команды не
        -- проходили, способности не давались). Видимо двойная установка конфликтует
        -- в Source 2 (CreateHeroForPlayer уже делает свою привязку, поверх неё
        -- SetSelectedHero ломает binding).
        --
        -- Дальше всё стандартно: engine спавнит -> наш OnNPCSpawned ловит спавн
        -- (с веткой was_disconnected) -> InitPlayerHero через SetContextThink.
        local ok, err = pcall(function()
            hPlayer:SetSelectedHero(heroName)
        end)
        if ok then
            DiscLog("ForceCreate(PID=%d): SetSelectedHero(%s) OK -- engine спавнит сам", PlayerID, heroName)
        else
            DiscLog("ForceCreate(PID=%d): SetSelectedHero FAILED: %s", PlayerID, tostring(err))
        end
    else
        DiscLog("ForceCreate(PID=%d): hPlayer=nil (CDOTAPlayer entity уже уничтожен engine'ом) -- спавн отложен до реконнекта (engine спавнит сам) или MarkAbandoned через 60с", PlayerID)
    end
end

--- На реконнекте: перехват control или ForceCreate.
--- Если реконнект случается ВО ВРЕМЯ GAME_IN_PROGRESS (gameState=8) -- engine
--- НЕ спавнит героя сам (HERO_SELECTION давно прошёл). Поэтому если hero нет --
--- зовём ForceCreate СИНХРОННО, без ожидания. CDOTAPlayer уже жив (CONNECTED).
function HeroBuilder:HandleReconnectMissingHero(PlayerID)
    local heroName = self.Players[PlayerID] and self.Players[PlayerID].selected_hero
    DiscLog("Reconnect(PID=%d): conn=%s, selected_hero=%s, gameState=%d",
        PlayerID, ConnName(PlayerID), tostring(heroName), GameRules:State_Get())

    local hasHero, source = self:HasHeroForPlayer(PlayerID)
    if hasHero then
        DiscLog("Reconnect(PID=%d): hero существует (%s), перехватываю control", PlayerID, source)
        self:ReassignHeroControlOnReconnect(PlayerID)
        return
    end

    DiscLog("Reconnect(PID=%d): hero нет -- сразу делаю ForceCreate", PlayerID)
    self:ForceCreateHeroForDisconnectedPlayer(PlayerID)

    -- Через 1с проверяем результат:
    --   - hero появился (engine спавнил или re-linked старого) -> зовём Reassign,
    --     чтобы гарантированно вызвать SetControllableByPlayer (иначе игрок не управляет).
    --   - hero нет -> повторный ForceCreate.
    Timers:CreateTimer(1.0, function()
        local stillNoHero, src = self:HasHeroForPlayer(PlayerID)
        if stillNoHero then
            DiscLog("Reconnect(PID=%d): через 1с hero всё ещё нет, повторный ForceCreate", PlayerID)
            self:ForceCreateHeroForDisconnectedPlayer(PlayerID)
        else
            DiscLog("Reconnect(PID=%d): через 1с hero есть (%s) -- зову Reassign для control", PlayerID, src)
            -- ВАЖНО: engine при reconnect-ре-линке существующего героя НЕ зовёт
            -- SetControllableByPlayer автоматически. Без этого игрок видит героя,
            -- но не управляет (нельзя двигать, кастить, покупать). Reassign это исправит.
            self:ReassignHeroControlOnReconnect(PlayerID)
        end
    end)
end

--- В конце пик-фазы для disconnected игроков с выбранным selected_hero -- вызываем
--- Player:SetSelectedHero на оставшемся живом hPlayer (если жив), чтобы engine
--- успел запомнить выбор до перехода в HERO_SELECTION.
---
--- Обычно hPlayer мёртв давно (DC случился раньше) -- тогда skip. Engine-side
--- selection уже был установлен в OnPlayerDisconnected на самом DC event'е
--- (там hPlayer ещё жив). Этой функции остаётся быть safety-net для редкого случая
--- "игрок DC за миллисекунды до FinishCustomStates" -- проверка hPlayer и попытка
--- SetSelectedHero на свежий выбор от SelectRandomHeroesForPlayers.
function HeroBuilder:HandleDisconnectedPicksAtFinish()
    DiscLog("FinishPicks: ENTRY -- проверяю всех PID'ов на disconnect-признаки")

    if not Players or not Players.Players then
        DiscLog("FinishPicks: Players module недоступен, skip")
        return
    end

    local handled = 0
    local skipped = 0
    for PlayerID, hbInfo in pairs(self.Players) do
        local pInfo = Players.Players[PlayerID]
        local stateName = pInfo and pInfo.state or nil
        local connState = PlayerResource:GetConnectionState(PlayerID)

        -- Проверяем по фактическому состоянию подключения.
        local isDisc = connState ~= nil and connState ~= DOTA_CONNECTION_STATE_CONNECTED
        local hasHero = hbInfo.selected_hero and hbInfo.selected_hero ~= ""

        DiscLog("FinishPicks(PID=%d): state=%s conn=%s hero=%s -> isDisc=%s hasHero=%s",
            PlayerID, tostring(stateName), ConnName(PlayerID),
            tostring(hbInfo.selected_hero), tostring(isDisc), tostring(hasHero))

        if isDisc and hasHero then
            local hPlayer = PlayerResource:GetPlayer(PlayerID)
            if hPlayer and not hPlayer:IsNull() then
                local ok, err = pcall(function()
                    hPlayer:SetSelectedHero(hbInfo.selected_hero)
                end)
                DiscLog("FinishPicks(PID=%d): SetSelectedHero(%s) -> ok=%s err=%s",
                    PlayerID, hbInfo.selected_hero, tostring(ok), tostring(err))
                hbInfo.pick_handled_at_finish = true
                handled = handled + 1
            else
                -- hPlayer мёртв (что обычно так). Engine уже знает hero name через
                -- SetSelectedHero на самом DC event'е (см. OnPlayerDisconnected v4) --
                -- engine спавнит hero на HERO_SELECTION самостоятельно.
                DiscLog("FinishPicks(PID=%d): hPlayer мёртв -- engine уже знает selected hero, спавн пройдёт сам", PlayerID)
                skipped = skipped + 1
            end
        end
    end

    DiscLog("FinishPicks: EXIT -- handled=%d, skipped=%d", handled, skipped)
end

--- Через 60с после disconnect, если игрок ещё не вернулся, выполняем мягкий "unstick":
--- - settled=true чтобы AllSettled-флаг мог сработать и flow «всех остальных» не залип
---   (без этого OnPlayerSettled никогда не запустит ability selection -- игра ломается).
---
--- НЕ ДЕЛАЕМ:
--- - НЕ убиваем hero (он должен оставаться живым на AI-автоатаке, дефать креепов).
--- - НЕ меняем PlayerState на ABANDONED (оставляем LEAVED, чтобы игрок мог вернуться
---   через 5-10 минут и наш `OnPlayerReconnected` спокойно перехватил control обратно).
---
--- Эффект для round-logic: игрок остаётся "активным" (IsActivePlayer=true т.к. LEAVED),
--- его арена/дуэли работают как обычно. BERSERK_FORCE_KILL_DELAY=120 это safety-net если
--- его hero не справится с волной креепов -- команда force-kill'нется и раунд продолжится.
function HeroBuilder:MarkPlayerAbandoned(PlayerID)
    if not self.Players[PlayerID] then
        DiscLog("MarkAbandoned(PID=%d): нет записи в HeroBuilder, skip", PlayerID)
        return
    end

    self.Players[PlayerID].settled = true
    DiscLog("MarkAbandoned(PID=%d): settled=true (hero оставлен живым, state остаётся LEAVED)", PlayerID)

    -- Сразу пытаемся прокинуть OnPlayerSettled, если все остальные уже settled.
    self:OnPlayerSettled(PlayerID)
end

--- Перехват управления героя после реконнекта.
---
--- 13.05.2026 v6: ПРАВИЛЬНЫЙ engine binding через SetAssignedHeroEntity вместо SetSelectedHero.
---
--- Раньше использовали `hPlayer:SetSelectedHero(name)` -- это ломало engine binding для
--- уже-заспавненного hero (engine думал "игрок выбрал новый, надо re-spawn" -> сбрасывал
--- старый binding -> ждал нового спавна -> binding оставался nil -> продажа крашит).
---
--- Правильный API для реконнекта на существующий hero (паттерн из hero_demo/demo_core.lua:275-285):
---   hero:SetPlayerID(PID)             -- engine знает кому unit принадлежит
---   hero:SetControllableByPlayer(PID, true)  -- даёт control
---   hero:SetOwner(hPlayer)            -- owner reference
---   hPlayer:SetAssignedHeroEntity(hero)  -- "этот hero привязан к этому player"
--- Это НЕ запускает re-spawn -- чистое восстановление binding без сайд-эффектов.
function HeroBuilder:ReassignHeroControlOnReconnect(PlayerID)
    local hHero = PlayerResource:GetSelectedHeroEntity(PlayerID)
    local source = "GetSelectedHeroEntity"
    if not hHero or hHero:IsNull() then
        local pInfo = Players and Players.Players and Players.Players[PlayerID]
        if pInfo and pInfo.hero and not pInfo.hero:IsNull() then
            hHero = pInfo.hero
            source = "Players.Players[PID].hero"
            DiscLog("Reassign(PID=%d): GetSelectedHeroEntity nil, fallback к %s", PlayerID, source)
        end
    end
    if not hHero or hHero:IsNull() then
        DiscLog("Reassign(PID=%d): hero нигде не найден -- нечего перехватывать", PlayerID)
        return
    end

    local hPlayer = PlayerResource:GetPlayer(PlayerID)
    if not hPlayer or hPlayer:IsNull() then
        DiscLog("Reassign(PID=%d): hPlayer nil, skip", PlayerID)
        return
    end

    -- Полное engine binding БЕЗ SetSelectedHero (см. описание функции).
    hHero:SetPlayerID(PlayerID)
    hHero:SetControllableByPlayer(PlayerID, true)
    hHero:SetOwner(hPlayer)
    if hPlayer.SetAssignedHeroEntity then
        hPlayer:SetAssignedHeroEntity(hHero)
    end

    DiscLog("Reassign(PID=%d): full binding restored (hero=%s, source=%s) [SetPlayerID+Owner+AssignedHeroEntity, БЕЗ SetSelectedHero]",
        PlayerID, hHero:GetUnitName(), source)
end

function HeroBuilder:InitPlayerHero( hHero )
    local PlayerID = hHero:GetPlayerID()

    if not self.Players[PlayerID] then
        print(string.format("[HeroBuilder/Disc] InitPlayerHero(PID=%d): нет HeroBuilder.Players entry, ВЫХОД",
            PlayerID))
        return
    end

    -- Лог входа: видно когда post-spawn init реально стартует для каждого PID.
    print(string.format("[HeroBuilder/Disc] InitPlayerHero(PID=%d, hero=%s) START",
        PlayerID, hHero:GetUnitName()))

    -- table.insert(GameMode.vTeamPlayerMap[hHero:GetTeamNumber()], PlayerID)

    hHero:AddNewModifier(hHero, nil, "modifier_hero_refreshing", {})
    -- hHero:AddNewModifier(hHero, nil, "modifier_cha_vision", {})
    hHero:AddNewModifier(hHero, nil, "modifier_gaben_int_fixed", {})
    hHero:AddNewModifier(hHero, nil, "modifier_skills_bonuses", {})
    hHero:AddNewModifier(hHero, nil, "modifier_base_attack_speed_custom", {})
    hHero:AddNewModifier(hHero, nil, "modifier_cashback_creep_count", {})
    hHero:AddNewModifier(hHero, nil, "modifier_player_controller", {})

    -- MF-2: наказания за репорты (курса/предупреждение) с самого начала игры.
    Players:ApplyPunishmentModifiers(hHero, PlayerID)

    if hHero:HasModifier("modifier_muerta_gunslinger") then
        hHero:RemoveModifierByName("modifier_muerta_gunslinger")
    end
    if hHero:GetUnitName() == "npc_dota_hero_gyrocopter" then
        hHero:AddNewModifier(hHero, nil, "modifier_gyrocopter_flak_cannon_lua_scepter", {})
    end

    -- Lone Druid:
    -- 1. lone_druid_starter_innate — пассивный placeholder с INNATE_UI флагом
    --    (показывается в innate-панели UI, не занимает Q/W/E/R слот)
    -- 2. lone_druid_entangle — сама активная способность, всегда у LD
    -- НЕ добавляем в npc_abilities_list.txt чтобы:
    --   - Другие герои не могли получить через random/relearn pool
    --   - Книги не "видели" её в abilities_list игрока (нет в списке = нельзя заменить)
    -- Циклический think восстанавливает обе если CleanupAfterAddAbility их удалит.
    if hHero:GetUnitName() == "npc_dota_hero_lone_druid" then
        hHero:SetContextThink(DoUniqueString("LoneDruidStarterGuard"), function()
            if not hHero or hHero:IsNull() then return nil end

            -- Placeholder во innate-слоте — добавляем через AddAbilityFacetsAndInnate
            -- (как у Ogre/Chen): он делает ClearInnateModifiers + CalculateStatBonus +
            -- SetRefCountsModifiers + правильный SetLevel, без чего innate-панель UI
            -- не подхватывает иконку.
            if not hHero:HasAbility("lone_druid_starter_innate") then
                HeroBuilder:AddAbilityFacetsAndInnate(hHero, "lone_druid_starter_innate")
            end

            -- Сама Entangle
            if not hHero:HasAbility("lone_druid_entangle") then
                local hAbility = hHero:AddAbility("lone_druid_entangle")
                if hAbility and not hAbility:IsNull() then
                    hAbility:SetLevel(1)
                end
            else
                local hAbility = hHero:FindAbilityByName("lone_druid_entangle")
                if hAbility and not hAbility:IsNull() then
                    if hAbility:IsHidden() then hAbility:SetHidden(false) end
                    if hAbility:GetLevel() == 0 then hAbility:SetLevel(1) end
                end
            end

            return 0.5
        end, 0)
    end

    if hHero:GetUnitName() == "npc_dota_hero_ogre_magi" then
        local function RemoveDumbLuck()
            if hHero and not hHero:IsNull() and hHero:HasAbility("ogre_magi_dumb_luck") then
                hHero:RemoveAbility("ogre_magi_dumb_luck")
            end
            if hHero and not hHero:IsNull() and not hHero:HasAbility("innate_disabled_placeholder") then
                local hPlaceholder = hHero:AddAbility("innate_disabled_placeholder")
                if hPlaceholder and not hPlaceholder:IsNull() then
                    hPlaceholder:SetLevel(1)
                end
            end
        end
        RemoveDumbLuck()
        hHero:SetContextThink(DoUniqueString("RemoveOgreDumbLuck"), function()
            if not hHero or hHero:IsNull() then return nil end
            RemoveDumbLuck()
            return nil
        end, 0.1)
    end

    if not hHero:HasModifier("modifier_player_cosmetics") then
        hHero:AddNewModifier(hHero, nil, "modifier_player_cosmetics", {})
    end

    -- hHero:AddNewModifier(hHero, nil, "modifier_test_nears", {})

    if hHero:GetUnitName() == "npc_dota_hero_warlock" and hHero:GetHeroFacetID() == 2 then
        local Item = hHero:AddItemByName("item_black_grimoire_custom")
        if Item then
            hHero:SetContextThink(DoUniqueString("Swap"), function(ent)
                if hHero and not hHero:IsNull() and Item and not Item:IsNull() then
                    hHero:SwapItems(Item:GetItemSlot(), DOTA_ITEM_NEUTRAL_ACTIVE_SLOT)
                end
            end, 0)
        end
    end

    local PlayerInfo = Server:GetPlayerInfo(PlayerID)

    local RatingTop = Server:GetCurrentSeasonRatingTop()
    if PlayerInfo and RatingTop ~= nil then
        for i=1, 5 do
            if RatingTop[i] ~= nil and tostring(RatingTop[i].steamid) == tostring(PlayerInfo.steamid) then
                hHero:AddNewModifier(hHero, nil, "modifier_cha_top_rating", {})
            end
        end
    end

    local HasAbilities = {}

    for i=0,hHero:GetAbilityCount()-1 do
        local ability_name = hHero:GetAbilityByIndex(i)
        if ability_name then
            print(i, ability_name:GetAbilityName())
            table.insert(HasAbilities, ability_name:GetAbilityName())
        end
    end
    
    for i = 0, hHero:GetAbilityCount()-1 do
        local hAbility = hHero:GetAbilityByIndex(i)
        if hAbility then
            local sAbilityName = hAbility:GetAbilityName()
            if not string.find(sAbilityName, "special_bonus") then
                hHero:RemoveAbility(sAbilityName)
            end
        end
    end

    local hTp = hHero:FindItemInInventory('item_tpscroll')
    if hTp then
        hTp:RemoveSelf()
    end

    Timers:CreateTimer(1, function()
        for _, AbilityName in ipairs(KeyValues:GetHeroInnatesAndFacetsAbilities(hHero:GetUnitName())) do
            if not hHero:HasAbility(AbilityName) and table.contains(HasAbilities, AbilityName) then
                HeroBuilder:AddAbilityFacetsAndInnate(hHero, AbilityName)
            end
        end

    end)

    hHero:AddNewModifier(hHero, nil, "modifier_spell_amplify_controller", {})
    HeroBuilder:RefreshAbilityOrder(PlayerID)
    HeroBuilder:SettleCurrentHero(PlayerID)
end

function HeroBuilder:AddAbilityFacetsAndInnate(hero, ability_name)
    if hero:IsNull() then return end
    if hero and hero:IsTempestDouble() and hero:HasModifier("modifier_arc_warden_tempest_double_lua") then
        return
    end
    local bHasInvulnerable = false
    if hero:HasModifier("modifier_hero_refreshing") then
        bHasInvulnerable = true
        hero:RemoveModifierByName("modifier_hero_refreshing")
    end
    local valve_broken_abilities = 
    {
        ["earth_spirit_stone_caller"] = true,
        ["techies_minefield_sign"] = true,
    }

    local new_ability = hero:AddAbility(ability_name)
    if new_ability and (not new_ability:IsNull()) then
        new_ability:ClearInnateModifiers()
        new_ability:MarkAbilityButtonDirty()
        hero:CalculateStatBonus(false)

        local AbilitySettings = ABILITIES_SETTINGS[ability_name]
        if AbilitySettings and AbilitySettings.BonusModifiers ~= nil then
            for _, ModifierName in ipairs(AbilitySettings.BonusModifiers) do
                if ModifierName == "modifier_muerta_pierce_the_veil" then
                    if hero:IsRealHero() then
                        hero:AddNewModifier(hero, new_ability, ModifierName, {})
                    end
                else
                    hero:AddNewModifier(hero, new_ability, ModifierName, {})
                end
            end
        end
        new_ability:SetRefCountsModifiers(true)
        if new_ability then
            new_ability:SetLevel(1)
        end
        if (not new_ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_PASSIVE) and not new_ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_HIDDEN) and new_ability:GetBehaviorInt() > 0) or valve_broken_abilities[ability_name] then
            Timers:CreateTimer(0.1, function()
                new_ability:UpdateAbilitySlot()
                HeroBuilder:RefreshAbilityOrder(hero:GetPlayerOwnerID())
            end)
        else
            new_ability.ignore_ability_structure = true
        end
    end
    if bHasInvulnerable then
        hero:AddNewModifier(hero, nil, "modifier_hero_refreshing", {})
    end
end

--//////////////////////////////////////////////////////////////////////////////
-- Создание выбора героя
--//////////////////////////////////////////////////////////////////////////////

-- Принимает уже сформированный пул RandomHeroes (4 героя по 4 атрибутам) и
-- словарь HeroesByAttributes[Attribute] = { имена кандидатов того же атрибута }.
-- Если в RandomHeroes больше 1 SSS-героя, оставляет первого, остальных заменяет
-- на случайных не-SSS героев той же атрибутной группы. Мутирует RandomHeroes на месте.
function HeroBuilder:LimitSSSInRandomPool(RandomHeroes, HeroesByAttributes)
    local sss_count = 0
    for i, hero in ipairs(RandomHeroes) do
        if hero and KeyValues:IsHeroInSSSTier(hero) then
            sss_count = sss_count + 1
            if sss_count > 1 then
                -- Этот SSS — лишний. Подменяем на не-SSS из той же атрибутной группы.
                local HeroInfo = KeyValues:GetHero(hero)
                if not HeroInfo then break end -- защита от мусора, не должна срабатывать
                local Attribute = HeroInfo.primary_attribute

                local non_sss_pool = {}
                for _, candidate in ipairs(HeroesByAttributes[Attribute] or {}) do
                    if candidate ~= hero and not KeyValues:IsHeroInSSSTier(candidate) then
                        table.insert(non_sss_pool, candidate)
                    end
                end

                if #non_sss_pool > 0 then
                    RandomHeroes[i] = table.random(non_sss_pool)
                    sss_count = sss_count - 1 -- успешно сняли SSS со слота
                end
                -- Иначе атрибутная группа состоит почти полностью из SSS —
                -- оставляем как есть, не блокируем игру.
            end
        end
    end
end

-- bReserveUnique = true для БЕСПЛАТНЫХ офферов (стартовый + бесплатные рероллы):
-- тянем героев так, чтобы они не пересекались с уже выданными другим игрокам
-- (self.FreeUsedHeroes), и добавляем свои в этот набор. Для платных рероллов и
-- прочих путей (random-кнопка, дисконнект) флаг не ставим → поведение как раньше.
function HeroBuilder:GenerateListRandomHeroes(PlayerID, LockedHero, bReserveUnique)
    if not self.Players[PlayerID] then return {} end

    if bReserveUnique and not self.FreeUsedHeroes then self.FreeUsedHeroes = {} end

    local RandomHeroes = {}

    local AllGameHeroes = KeyValues:GetAllHeroes()

    -- HeroesByAttributes — полный пул по атрибутам (только без банов): фолбэк-источник
    -- и пул для LimitSSS/Locked. PickPools — из чего РЕАЛЬНО тянем оффер: дополнительно
    -- исключает уже показанных этому игроку и (для бесплатных офферов) зарезервированных
    -- другим игрокам, чтобы у всех были уникальные герои.
    local HeroesByAttributes = {
        [DOTA_ATTRIBUTE_STRENGTH] = {},
        [DOTA_ATTRIBUTE_AGILITY] = {},
        [DOTA_ATTRIBUTE_INTELLECT] = {},
        [DOTA_ATTRIBUTE_ALL] = {},
    }
    local PickPools = {
        [DOTA_ATTRIBUTE_STRENGTH] = {},
        [DOTA_ATTRIBUTE_AGILITY] = {},
        [DOTA_ATTRIBUTE_INTELLECT] = {},
        [DOTA_ATTRIBUTE_ALL] = {},
    }

    for HeroName, HeroInfo in pairs(AllGameHeroes) do
        if not KeyValues:IsBannedHero(HeroName) then
            local Attr = HeroInfo.primary_attribute
            table.insert(HeroesByAttributes[Attr], HeroName)

            local bReserved = bReserveUnique and self.FreeUsedHeroes[HeroName]
            if not bReserved and not table.contains(self.Players[PlayerID].random_heroes, HeroName) then
                table.insert(PickPools[Attr], HeroName)
            end
        end
    end

    for Attribute, Pool in pairs(PickPools) do
        local r = table.random(Pool)
        if r == nil then
            -- Уникальный пул этого атрибута исчерпан (много игроков/бесплатных
            -- рероллов/банов) — берём из полного пула атрибута, допуская повтор,
            -- лишь бы не отдать пустой слот и не сломать пик.
            r = table.random(HeroesByAttributes[Attribute])
        end
        table.insert(RandomHeroes, r)
    end

    --------------------------------------------------------------------------------
    -- Лимит SSS-героев: не больше 1 в "свежей" выборке.
    --------------------------------------------------------------------------------
    -- Применяется ДО подмены LockedHero — лок не учитывается, поэтому если игрок
    -- залочил SSS и реролит, в новом пуле может быть до 2 SSS (лок + 1 свежий).
    -- Это сознательно: за реролл с SSS-локом игрок платит коинами и получает
    -- небольшое преимущество в виде второго возможного SSS, но не больше.
    --
    -- Алгоритм: если в свежей выборке ≥2 SSS — оставляем первого попавшегося
    -- (он остаётся в своей атрибутной группе), остальные заменяем на случайного
    -- не-SSS героя из той же атрибутной группы. Если в группе нет не-SSS
    -- кандидатов (крайний случай при сильно перекошенной таблице) — оставляем
    -- SSS как есть, не падаем.
    -- SSS-замену тянем из PickPools (уже без банов/повторов/резерва), чтобы
    -- подменённый герой тоже оставался уникальным для бесплатных офферов.
    self:LimitSSSInRandomPool(RandomHeroes, PickPools)

    if LockedHero ~= nil and #self.Players[PlayerID].random_heroes > 0 then
        local Index = table.findkey(self.Players[PlayerID].random_heroes, LockedHero)
        local HeroInfo = KeyValues:GetHero(LockedHero)

        if Index ~= nil and HeroInfo then
            local HeroAttribute = HeroInfo.primary_attribute
            local CurrentAttributeHeroName = ""
            for _, rHeroName in ipairs(RandomHeroes) do
                if table.contains(HeroesByAttributes[HeroAttribute], rHeroName) then
                    CurrentAttributeHeroName = rHeroName
                    break
                end
            end

            local CurrentAttributeIndex = table.findkey(RandomHeroes, CurrentAttributeHeroName)
            if CurrentAttributeIndex ~= nil then
                if CurrentAttributeIndex ~= Index then
                    local TempValue = RandomHeroes[CurrentAttributeIndex]
                    local TempValue2 = RandomHeroes[Index]

                    RandomHeroes[Index] = LockedHero
                    RandomHeroes[CurrentAttributeIndex] = TempValue2
                else
                    RandomHeroes[Index] = LockedHero
                end
            end
        end
    end

    -- Фиксируем выданных героев в общий резерв, чтобы следующие бесплатные офферы
    -- (у этого же или других игроков) их не повторяли. Накапливается за фазу пика:
    -- у каждого игрока оба бесплатных выбора остаются зарезервированными.
    if bReserveUnique then
        for _, HeroName in ipairs(RandomHeroes) do
            if HeroName ~= nil then
                self.FreeUsedHeroes[HeroName] = true
            end
        end
    end

    return RandomHeroes
end

function HeroBuilder:UpdateHeroPick()
    -- Новая фаза пика — обнуляем резерв бесплатных офферов и раздаём стартовый
    -- оффер всем игрокам уникально (bReserveUnique=true).
    self.FreeUsedHeroes = {}

    for PlayerID, PlayerInfo in pairs(self.Players) do
        if not self.Players[PlayerID] then return end

        self.Players[PlayerID].random_heroes = self:GenerateListRandomHeroes(PlayerID, nil, true)
        self.Players[PlayerID].free_offers_reserved = 1 -- стартовый оффер = первый уникальный

        self:UpdatePlayerNetTable(PlayerID)
    end
end

function HeroBuilder:UpdatePlayerNetTable(PlayerID)
    if not self.Players[PlayerID] then return end

    PlayerTables:SetTableValue("player_"..PlayerID.."_global", "builder_info", self.Players[PlayerID])
end

function HeroBuilder:OnPlayerWantRerollHeroes(event)
    local PlayerID = event.PlayerID

    if not self.Players[PlayerID] or self.Players[PlayerID].selected_hero ~= "" or self.Players[PlayerID].reroll_count <= 0 then return end

    local LockedHero = self.Players[PlayerID].locked_hero

    local Price = LockedHero == nil and SERVER_REROLL_PRICE or SERVER_REROLL_PRICE_LOCKED_HERO

    local bIsFree = true

    if self.Players[PlayerID].reroll_count_free <= 0 or LockedHero ~= nil then
        local PlayerInfo = Server:GetPlayerInfo(PlayerID)
        if PlayerInfo == nil then return end
        if PlayerInfo.profile.coins < Price then return end

        bIsFree = false

        Server:OnAttemptRerollHeroes(PlayerID, Price)
    end

    if bIsFree and self.Players[PlayerID].reroll_count_free > 0 then
        self.Players[PlayerID].reroll_count_free = self.Players[PlayerID].reroll_count_free - 1
    end

    self.Players[PlayerID].reroll_count = self.Players[PlayerID].reroll_count - 1

    self.Players[PlayerID].reroll_times = self.Players[PlayerID].reroll_times + 1

    -- Уникальным (зарезервированным без пересечений с другими игроками) делаем только
    -- бесплатный реролл И только пока не выбрали лимит FREE_UNIQUE_HERO_OFFERS офферов
    -- (стартовый уже учтён как 1). Бесплатные рероллы сверх лимита и все платные —
    -- обычные случайные (без банов), как раньше.
    local bUniqueOffer = bIsFree and self.Players[PlayerID].free_offers_reserved < FREE_UNIQUE_HERO_OFFERS
    if bUniqueOffer then
        self.Players[PlayerID].free_offers_reserved = self.Players[PlayerID].free_offers_reserved + 1
    end

    self.Players[PlayerID].random_heroes = self:GenerateListRandomHeroes(PlayerID, LockedHero, bUniqueOffer)

    self.Players[PlayerID].locked_hero = nil

    self:UpdatePlayerNetTable(PlayerID)
end

function HeroBuilder:SettleCurrentHero(PlayerID)
    if not self.Players[PlayerID] then
        print(string.format("[HeroBuilder/Disc] SettleCurrentHero(PID=%d): нет HeroBuilder.Players entry, ВЫХОД",
            PlayerID))
        return
    end

    -- Видно когда PlayerInfo.settled выставляется true для каждого PID.
    -- Это критичная точка: пока не все settled, OnPlayerSettled не запустит ability selection.
    print(string.format("[HeroBuilder/Disc] SettleCurrentHero(PID=%d) -- ставлю settled=true",
        PlayerID))

    -- Disc-fix v3: для CreateUnitByName-героя engine player binding отсутствует ->
    -- PlayerResource:GetSelectedHeroEntity возвращает nil -> hHero:GetAttackCapability()
    -- крашит SettleCurrentHero, settled остаётся false, AllSettled never true,
    -- ability selection не стартует для всех игроков. Поэтому fallback на наш трекинг.
    local hHero = PlayerResource:GetSelectedHeroEntity(PlayerID)
    if not hHero or hHero:IsNull() then
        local pInfo = Players and Players.Players and Players.Players[PlayerID]
        if pInfo and pInfo.hero and not pInfo.hero:IsNull() then
            hHero = pInfo.hero
            DiscLog("SettleCurrentHero(PID=%d): GetSelectedHeroEntity nil -> fallback на Players.Players[PID].hero", PlayerID)
        end
    end
    if not hHero or hHero:IsNull() then
        DiscLog("SettleCurrentHero(PID=%d): hero не найден нигде, форсирую settled=true чтобы не блокировать AllSettled", PlayerID)
        self.Players[PlayerID].settled = true
        HeroBuilder:OnPlayerSettled(PlayerID)
        return
    end

    self.Players[PlayerID].attack_capability = hHero:GetAttackCapability()
    self.Players[PlayerID].selected_hero_ent = hHero
    -- Disc-fix v5: синхронизируем selected_hero (имя) с фактически заспавненным юнитом.
    -- Раньше для рассинхрон-кейсов (DC + SelectRandomHeroesForPlayers выбрал отличный
    -- random) selected_hero оставался "виртуальным" -- продажа/крафт читали его и
    -- крашились, потому что реальный hero был другим. Здесь синхронизируем как finally.
    local actualName = hHero:GetUnitName()
    if self.Players[PlayerID].selected_hero ~= actualName then
        DiscLog("SettleCurrentHero(PID=%d): sync selected_hero '%s' -> '%s' (фактический unit)",
            PlayerID, tostring(self.Players[PlayerID].selected_hero), actualName)
        self.Players[PlayerID].selected_hero = actualName
    end
    self.Players[PlayerID].settled = true

    self:UpdatePlayerLifesCount(PlayerID, self.Players[PlayerID].lifes_count, "set")

    for i=1, self.Players[PlayerID].smoke_count do
        local Item = CreateItem("item_smoke_of_deceit_custom", hHero, hHero)
        hHero:AddItem(Item)
        Item = hHero:FindItemInInventory("item_smoke_of_deceit_custom")
        if Item and not Item:IsNull() then
            Item:SetPurchaseTime(0)
            Item:SetSellable(false)
        end
    end

    self:UpdatePlayerNetTable(PlayerID)

    -- self:GiveRandomAbility(PlayerID)
    -- HeroBuilder:ShowRandomAbilitySelection(PlayerID)
    HeroBuilder:OnPlayerSettled()
end

function HeroBuilder:OnPlayerSettled(SettledPlayerID)
    -- ДИАГ 1.5: timestamp каждого вызова. Если ability selection появляется через 60с --
    -- здесь будет видно последовательность: AbandonTimer (T+60) -> SettleCurrentHero(disc PID)
    -- -> OnPlayerSettled -> AllSettled=true -> ability selection.
    DiscLog("OnPlayerSettled@ENTRY: triggered_by=%s, gameTime=%.2f",
        tostring(SettledPlayerID), GameRules:GetGameTime())

    local AllSettled = true
    local unsettled = {}

    for PlayerID, PlayerInfo in pairs(self:GetAllPlayers()) do
        if PlayerInfo.settled == false then
            AllSettled = false
            table.insert(unsettled, tostring(PlayerID))
        end
    end

    -- Видно кто блокирует AllSettled. Если ability selection не стартует --
    -- здесь будет список PID'ов которые «застряли» без settled=true.
    print(string.format("[HeroBuilder/Disc] OnPlayerSettled(triggered_by=%s): AllSettled=%s, unsettled=[%s], idealAbilitiesList_count=%d",
        tostring(SettledPlayerID), tostring(AllSettled), table.concat(unsettled, ","),
        self.IdealAbilitiesList and #self.IdealAbilitiesList or 0))

    if AllSettled and (self.IdealAbilitiesList == nil or #self.IdealAbilitiesList == 0) then
        -- ДИАГ 1.5: точный timestamp когда unblock'нулась пик-фаза. Расстояние
        -- от DC@ENTRY до этого момента = задержка для пользователя.
        DiscLog("OnPlayerSettled: AllSettled HIT! ability selection стартует через 0.5с (gameTime=%.2f)",
            GameRules:GetGameTime())
        local BasicAbilitiesPool = self:GenerateIdealAbilitiesForAllPlayers()
        local SSSAbilitiesPool = self:GenerateIdealAbilitiesForAllPlayers(true)

        local SSSCount = GetGameSetting("SSS_FIRST_ABILITY_COUNT")
        local SSSRandom = table.random_some(SSSAbilitiesPool, SSSCount)

        for _, AbilityName in ipairs(SSSRandom) do
            table.remove_item(BasicAbilitiesPool, AbilityName)
        end

        local BasicCount = 8 - SSSCount

        local Result = table.join(table.random_some(BasicAbilitiesPool, BasicCount), SSSRandom)

        self.IdealAbilitiesList = Result

        Timers:CreateTimer(0.5, function()
            for PlayerID, PlayerInfo in pairs(HeroBuilder:GetAllPlayers()) do
                local MaxCount = PlayerInfo.ability_select_count
                PlayerInfo.ability_select_count = 0
                for i=1, MaxCount do
                    local type = PlayerInfo.SSS_ability_select_count > 0 and ABILITY_SELECTION_TYPE.BASIC_SSS or ABILITY_SELECTION_TYPE.BASIC
                    if PlayerInfo.SSS_ability_select_count > 0 then
                        PlayerInfo.SSS_ability_select_count = PlayerInfo.SSS_ability_select_count - 1
                    end

                    HeroBuilder:AddAbilitiesSelectionToSchedule(PlayerID, type)
                end
            end
        end)
    elseif AllSettled and self.IdealAbilitiesList ~= nil and #self.IdealAbilitiesList > 0 then
        Timers:CreateTimer(0.5, function()
            local PlayerInfo = HeroBuilder:GetPlayerInfo(SettledPlayerID)
            if PlayerInfo then
                local MaxCount = PlayerInfo.ability_select_count
                PlayerInfo.ability_select_count = 0
                for i=1, MaxCount do
                    local type = PlayerInfo.SSS_ability_select_count > 0 and ABILITY_SELECTION_TYPE.BASIC_SSS or ABILITY_SELECTION_TYPE.BASIC
                    if PlayerInfo.SSS_ability_select_count > 0 then
                        PlayerInfo.SSS_ability_select_count = PlayerInfo.SSS_ability_select_count - 1
                    end
                    
                    HeroBuilder:AddAbilitiesSelectionToSchedule(SettledPlayerID, type)
                end
            end
        end)
    end
end

function HeroBuilder:UpdatePlayerLifesCount(PlayerID, value, set_type)
    if not self.Players[PlayerID] then return end

    local Hero = self.Players[PlayerID].selected_hero_ent

    if Hero == nil then return end

    if set_type == "set" then
        self.Players[PlayerID].lifes_count = value
    else
        self.Players[PlayerID].lifes_count = self.Players[PlayerID].lifes_count + value

        if value < 0 then
            self:UpdateMinigamesWins(PlayerID, -MINIGAMES_REDUCE_WIN_BUFF_STACKS_PER_LOSE_AEGIS)
        end

        local NotificationType = NOTIFICATION_TYPE.AEGIS_LOST
        if value > 0 then
            NotificationType = NOTIFICATION_TYPE.AEGIS_GET
        end
        Notifications:AddNotification(NotificationType, Rounds:GetCurrentRound(), {
            player1 = PlayerID,
            value1 = value
        })
    end

    self.Players[PlayerID].lifes_count = math.max(0, self.Players[PlayerID].lifes_count)

    local Modif = Hero:FindModifierByName("modifier_aegis")

    if not Modif then
        Modif = Hero:AddNewModifier(Hero, nil, "modifier_aegis", {})
    end

    if Modif then
        Modif:SetStackCount(self.Players[PlayerID].lifes_count)
    end

    if not Rounds:IsLastDuelActive() then
        self.Players[PlayerID].lifes_count_server = self.Players[PlayerID].lifes_count
    end

    self:UpdatePlayerNetTable(PlayerID)
end

function HeroBuilder:ForceFinishHeroBuild()
    for nTeamNumber,bAlive in pairs(GameMode.vAliveTeam) do
        for _,nPlayerID in ipairs(GameMode.vTeamPlayerMap[nTeamNumber]) do
            local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
            if hHero and self.Players[nPlayerID] and not self.Players[nPlayerID].settled then                
                self:SettleCurrentHero(nPlayerID)
            end
        end
    end    
end

function HeroBuilder:ShowRandomSkillSelectionFree(PlayerID)
    if not self.Players[PlayerID] then return end

    self.Players[PlayerID].skills_points = self.Players[PlayerID].skills_points + 1

    local CurrentRound = math.max(1, Rounds:GetCurrentRound())
    local PlayerInfo = Server:GetPlayerInfo(PlayerID)
    if CurrentRound == 5 and self.Players[PlayerID].skills_points == 1 and PlayerInfo and PlayerInfo.settings and PlayerInfo.settings.settings_hints_enabled ~= 0 then
        local Player = PlayerResource:GetPlayer(PlayerID)
        if Player then
            Timers:CreateTimer(1.0, function()
                if Player and Player:IsAlive() then
                    CustomGameEventManager:Send_ServerToPlayer(Player, "cha_hint_visible", {hint = "skills"})
                end
            end)
        end
    end

    HeroBuilder:ShowRandomSkillSelection(PlayerID)
end

function HeroBuilder:ShowRandomSkillSelection(PlayerID)
    if not self.Players[PlayerID] then return end

    local SkillsList = self.Players[PlayerID].skills_list

    if self.Players[PlayerID].skills_current_selecting ~= nil or self.Players[PlayerID].skills_points <= 0 then return end

    local AvailableSkills = {}

    -- Дефолтный лимит на количество взятий одного навыка = 8.
    -- Если у навыка явно прописано SkillInfo.max (например 4), используем его.
    local DEFAULT_SKILL_MAX = 8
    for SkillName, SkillInfo in pairs(SKILLS_LIST_TABLE) do
        if not SkillInfo.disabled then                      -- навык не должен предлагаться (напр. universal_evasion)
            local MaxTakes = SkillInfo.max or DEFAULT_SKILL_MAX
            local CurrentTakes = SkillsList[SkillName] or 0
            if CurrentTakes < MaxTakes then
                table.insert(AvailableSkills, SkillName)
            end
        end
    end

    -- Не предлагаем те же навыки, что в ПРЕДЫДУЩЕМ показанном наборе — для равномерности выбора.
    -- Исключаем ТОЛЬКО прошлый набор: то, что было 2 выбора назад, снова доступно.
    -- Работает и при "накопленных" очках навыков (выборы идут по одному последовательно,
    -- skills_last_offered обновляется на каждом показе).
    local SKILLS_PER_SELECTION = 5
    local LastOffered = self.Players[PlayerID].skills_last_offered or {}
    local ExcludeSet = {}
    for _, s in ipairs(LastOffered) do ExcludeSet[s] = true end

    local Candidates = {}
    for _, s in ipairs(AvailableSkills) do
        if not ExcludeSet[s] then table.insert(Candidates, s) end
    end

    -- Если после исключения осталось меньше полного набора (поздняя игра — много навыков в максе),
    -- берём из полного доступного пула, чтобы всё равно предложить полный выбор.
    local Pool = (#Candidates >= SKILLS_PER_SELECTION) and Candidates or AvailableSkills

    local RandomSkills = table.random_some(Pool, SKILLS_PER_SELECTION)

    self.Players[PlayerID].skills_current_selecting = RandomSkills
    self.Players[PlayerID].skills_last_offered = RandomSkills   -- запоминаем набор, чтобы исключить в следующем выборе

    PlayerTables:SetTableValue("player_"..PlayerID, "skills_selecting", self.Players[PlayerID].skills_current_selecting)
end

function HeroBuilder:UpdateSkillsNetTableInfo()
    local CurrentTable = table.deepcopy(SKILLS_LIST_TABLE)
    for SkillName, SkillInfo in pairs(CurrentTable) do
        local NewValue = GetSkillValue(SkillName)
        SkillInfo.value = NewValue
    end

    for _, PlayerID in ipairs(Players:GetAllPlayers(true)) do
        if self.Players[PlayerID] and self.Players[PlayerID].selected_hero_ent ~= nil then
            self.Players[PlayerID].selected_hero_ent:AddNewModifier(self.Players[PlayerID].selected_hero_ent, nil, "modifier_skills_bonuses", {})
        end
    end

    CustomNetTables:SetTableValue("globals", "skills_info", CurrentTable)
end

function HeroBuilder:OnPlayerSelectedSkill(event)
    local PlayerID = event.PlayerID
    local SkillName = event.skill_name

    if SKILLS_LIST_TABLE[SkillName] == nil or not self.Players[PlayerID] then return end

    local Hero = self.Players[PlayerID].selected_hero_ent

    if Hero == nil then return end

    if self.Players[PlayerID].skills_list[SkillName] == nil then
        self.Players[PlayerID].skills_list[SkillName] = 0
    end

    self.Players[PlayerID].skills_list[SkillName] = self.Players[PlayerID].skills_list[SkillName] + 1

    self.Players[PlayerID].skills_points = self.Players[PlayerID].skills_points - 1

    PlayerTables:SetTableValue("player_"..PlayerID.."_global", "skills", self.Players[PlayerID].skills_list)

    Hero:AddNewModifier(Hero, nil, "modifier_skills_bonuses", {})

    self.Players[PlayerID].skills_current_selecting = nil

    if self.Players[PlayerID].skills_points > 0 then
        self:ShowRandomSkillSelection(PlayerID)
    else
        PlayerTables:SetTableValue("player_"..PlayerID, "skills_selecting", self.Players[PlayerID].skills_current_selecting)
    end
end

function HeroBuilder:AddAbilitiesSelectionToSchedule(PlayerID, Type, sUsedItemName)
    if not self.Players[PlayerID] then return false end

    if self:IsPlayerSelectAbilities(PlayerID) then
        table.insert(self.Players[PlayerID].abilities_selection_schedule, {
            type = Type,
            sUsedItemName = sUsedItemName
        })
    else
        return self:ShowRandomAbilitiesSelection(PlayerID, Type, 0, nil, sUsedItemName)
    end

    return true
end

function HeroBuilder:ShowRandomAbilitiesSelection(PlayerID, Type, State, sDeletedAbility, sUsedItemName)
    if not self.Players[PlayerID] then return false end

    if Type == ABILITY_SELECTION_TYPE.FAST_RELEARN and State == 0 then
        local hHero = self.Players[PlayerID].selected_hero_ent
        if hHero == nil or hHero:IsNull() then return false end

        local AllPlayerAbilities = self:GetPlayerAbilities(PlayerID)

        local tempList = table.deepcopy(AllPlayerAbilities)

        -- Получаем имена украденных способностей Рубика (текущая + история)
        local rubick_skill = hHero:FindAbilityByName("rubick_spell_steal_custom")
        local stolen_abilities = {}
        if rubick_skill then
            if rubick_skill.currentSpell ~= nil and not rubick_skill.currentSpell:IsNull() then
                stolen_abilities[rubick_skill.currentSpell:GetName()] = true
            end
            if hHero.spell_steal_history then
                for _, hSpell in pairs(hHero.spell_steal_history) do
                    if hSpell and not hSpell:IsNull() then
                        stolen_abilities[hSpell:GetAbilityName()] = true
                    end
                end
            end
        end

        for _,AbilityName in pairs(AllPlayerAbilities) do
            local ability = hHero:FindAbilityByName(AbilityName)
            -- Исключаем неудаляемые способности, скрытые, украденные через Spell Steal и способности не на герое
            if (ABILITIES_SETTINGS[AbilityName] and ABILITIES_SETTINGS[AbilityName].bUnremovable) or
            (ability and ability.IsHiddenAbility and ability:IsHiddenAbility()) or
            (ability and ability.rubick_spell) or
            stolen_abilities[AbilityName] or
            (ability == nil) then
                table.remove_item(tempList, AbilityName)
            end
        end

        if #tempList == 0 then
            return false
        end

        local RandomAbility = table.random(tempList)

        local Data = {
            state = "SHOW",
            type_state = State,
            type = Type,
            sUsedItemName = sUsedItemName
        }

        self.Players[PlayerID].abilities_selection_current = Data

        self:OnPlayerAbilitySelected({PlayerID = PlayerID, abilityname = RandomAbility})

        return true
    end


    if Type ~= ABILITY_SELECTION_TYPE.BASIC and Type ~= ABILITY_SELECTION_TYPE.BASIC_SSS and State == 0 then
        local Data = {
            state = "SHOW",
            type_state = State,
            type = Type,
            sUsedItemName = sUsedItemName
        }

        self.Players[PlayerID].abilities_selection_current = Data

        PlayerTables:SetTableValue("player_"..PlayerID, "ability_selection", Data)
        return true
    else
        local Abilities = {}
        local sss_count = 0
        if Type == ABILITY_SELECTION_TYPE.BASIC_SSS then
            if GetGameSetting("FIRST_ABILITY_IS_GENERAL") == 1 then
                Abilities = self.IdealAbilitiesList
            else
                Abilities, sss_count = self:GenerateAbilitiesListForRandom(PlayerID, sDeletedAbility, false, true, true)
            end
        else
            Abilities, sss_count = self:GenerateAbilitiesListForRandom(PlayerID, sDeletedAbility, Type == ABILITY_SELECTION_TYPE.RELEARN_RETURN, Type == ABILITY_SELECTION_TYPE.RELEARN_SSS)
        end

        local Data = {
            state = "SHOW",
            type_state = State,
            type = Type,
            abilities = Abilities,
            sUsedItemName = sUsedItemName,
            sss_count = sss_count,
        }

        self.Players[PlayerID].abilities_selection_current = Data

        PlayerTables:SetTableValue("player_"..PlayerID, "ability_selection", Data)
    end

    return true
end

function HeroBuilder:ReturnUsedItemInSelection(PlayerID)
    if not self.Players[PlayerID] or not self:IsPlayerSelectAbilities(PlayerID) then return end

    local SelectionInfo = self.Players[PlayerID].abilities_selection_current
    if SelectionInfo.sUsedItemName == nil then return end

    local Hero = self.Players[PlayerID].selected_hero_ent
    if Hero == nil or Hero:IsNull() then return end

    local Item = CreateItem(SelectionInfo.sUsedItemName, Hero, Hero)
    Hero:AddItem(Item)
end

function HeroBuilder:OnPlayerAbilitySelected(event)
    local PlayerID = event.PlayerID
    local AbilityName = event.abilityname

    if not self.Players[PlayerID] or not self:IsPlayerSelectAbilities(PlayerID) then return end

    local SelectionInfo = self.Players[PlayerID].abilities_selection_current
    local bReplaceAbility = SelectionInfo.type ~= ABILITY_SELECTION_TYPE.BASIC and SelectionInfo.type ~= ABILITY_SELECTION_TYPE.BASIC_SSS and SelectionInfo.type_state == 0

    SelectionInfo.state = "HIDE"

    PlayerTables:SetTableValue("player_"..PlayerID, "ability_selection", SelectionInfo)

    if (bReplaceAbility and SelectionInfo.replace_selected == true) or SelectionInfo.select_selected == true then return end

    if bReplaceAbility then
        local Hero = self.Players[PlayerID].selected_hero_ent
        if Hero == nil or Hero:IsNull() then
            self:ReturnUsedItemInSelection(PlayerID)

            self:NextAbilitySelection(PlayerID)
            return
        end

        if AbilityName == nil then
            self:ReturnUsedItemInSelection(PlayerID)

            self:NextAbilitySelection(PlayerID)

            return
        end

        local bDelete = true
        if AbilityName == "DONT_DELETE" then
            bDelete = false
        end

        local hook = Hero:FindAbilityByName("pudge_meat_hook")
        if hook then
            hook:SetActivated(true)
        end

        -- Проверяем, не является ли способность украденной через Spell Steal
        local rubick_skill = Hero:FindAbilityByName("rubick_spell_steal_custom")
        if rubick_skill and rubick_skill.currentSpell ~= nil and not rubick_skill.currentSpell:IsNull() then
            local stolen_name = rubick_skill.currentSpell:GetName()
            if AbilityName == stolen_name then
                self:ReturnUsedItemInSelection(PlayerID)
                self:NextAbilitySelection(PlayerID)
                return
            end
        end

        -- Если у игрока нет абилки
        if AbilityName ~= "DONT_DELETE" and not table.contains(self.Players[PlayerID].abilities_list, AbilityName) then
            AbilityName = nil 
        end

        self.Players[PlayerID].selecting_ability_deleted_index = nil

        if bDelete and not GetAbilitySetting(AbilityName, "bUnremovable") then

            local fAbility = Hero:FindAbilityByName(AbilityName)
            if fAbility then
                local nAbilityLevel = fAbility:GetLevel()
                local nAbilityPoints = Hero:GetAbilityPoints() + nAbilityLevel
                Hero:SetAbilityPoints(nAbilityPoints)
                self:RemoveAbility(PlayerID, AbilityName)
                self.Players[PlayerID].abilities_list_server[AbilityName] = nil
                self.Players[PlayerID].selecting_ability_deleted_index = fAbility:GetAbilityIndex()
                table.remove_item(self.Players[PlayerID].abilities_list, AbilityName)
            end
        end

        if SelectionInfo.type == ABILITY_SELECTION_TYPE.DEV then
            self:ShowOmniscientSelection(PlayerID)
        else
            Timers:CreateTimer(0.25, function()
                self:ShowRandomAbilitiesSelection(PlayerID, SelectionInfo.type, 1, AbilityName, SelectionInfo.sUsedItemName)
            end)
        end

        SelectionInfo.replace_selected = true

        self:RefreshAbilityOrder(PlayerID)
    else
        if AbilityName == nil then
            SelectionInfo.abilities, SelectionInfo.sss_count = self:GenerateAbilitiesListForRandom(PlayerID)
            AbilityName = table.random(SelectionInfo.abilities)
        end

        if not table.contains(SelectionInfo.abilities, AbilityName) then 
            self:ReturnUsedItemInSelection(PlayerID)

            self:NextAbilitySelection(PlayerID)
            return 
        end

        if self.AbilitiesCounter[AbilityName] then
            self.AbilitiesCounter[AbilityName] = self.AbilitiesCounter[AbilityName] - 1
        end

        local bPutInIndex = nil
        if self.Players[PlayerID].selecting_ability_deleted_index ~= nil then
            bPutInIndex = self.Players[PlayerID].selecting_ability_deleted_index
            self.Players[PlayerID].selecting_ability_deleted_index = nil
        end

        table.insert(self.Players[PlayerID].abilities_list, AbilityName)
        local CurrentRound = math.max(1, Rounds:GetCurrentRound())
        self.Players[PlayerID].abilities_list_server[AbilityName] = CurrentRound

        self:AddAbility(PlayerID, AbilityName, nil, nil, bPutInIndex)

        SelectionInfo.select_selected = true

        self:NextAbilitySelection(PlayerID)

        local PlayerInfo = Server:GetPlayerInfo(PlayerID)
        if CurrentRound == 9 and #self.Players[PlayerID].abilities_selection_schedule > 0 and PlayerInfo and PlayerInfo.settings and PlayerInfo.settings.settings_hints_enabled ~= 0 then
            local Player = PlayerResource:GetPlayer(PlayerID)
            if Player then
                Timers:CreateTimer(1.0, function()
                    if Player and Player:IsAlive() then
                        CustomGameEventManager:Send_ServerToPlayer(Player, "cha_hint_visible", {hint = "swap"})
                    end
                end)
            end
        end

        -- Подсказка о способностях с полетом для дефа крипов
        local FlyAbilities = {
            "winter_wyvern_arctic_burn_lua",
            "dragon_knight_elder_dragon_form_custom",
            "undying_flesh_golem_custom",
            "sven_gods_strength_custom",
            "lina_laguna_blade_lua",
            "lycan_shapeshift_custom",
            "keeper_of_the_light_spirit_form_custom",
            "terrorblade_metamorphosis_lua"
        }
        if table.contains(FlyAbilities, AbilityName) and PlayerInfo and PlayerInfo.settings and PlayerInfo.settings.settings_hints_enabled ~= 0 then
            local Player = PlayerResource:GetPlayer(PlayerID)
            if Player then
                Timers:CreateTimer(1.0, function()
                    if Player and Player:IsAlive() then
                        CustomGameEventManager:Send_ServerToPlayer(Player, "cha_hint_visible", {hint = "creeps"})
                    end
                end)
            end
        end

        local NotificationItem = SelectionInfo.sUsedItemName

        local sType = SelectionInfo.type
        if (sType == ABILITY_SELECTION_TYPE.RELEARN_SSS or sType == ABILITY_SELECTION_TYPE.RELEARN_RETURN or sType == ABILITY_SELECTION_TYPE.BASIC) and NotificationItem ~= nil then
            Notifications:AddNotification(NOTIFICATION_TYPE.USED_BOOK, Rounds:GetCurrentRound(), {
                player1 = PlayerID,
                item1 = NotificationItem
            })
        end

        if sType == ABILITY_SELECTION_TYPE.RELEARN_SSS or sType == ABILITY_SELECTION_TYPE.RELEARN_RETURN or sType == ABILITY_SELECTION_TYPE.RELEARN then
            self:IncrementBooks(PlayerID)
        end
    end
end

function HeroBuilder:NextAbilitySelection(PlayerID)
    if not self.Players[PlayerID] then return end

    Timers:CreateTimer(0.25, function()
        if not self.Players[PlayerID] then return end

        self.Players[PlayerID].abilities_selection_current = nil

        local Next = self.Players[PlayerID].abilities_selection_schedule[1]
        if Next ~= nil then
            table.remove(self.Players[PlayerID].abilities_selection_schedule, 1)

            self:ShowRandomAbilitiesSelection(PlayerID, Next.type, 0, nil, Next.sUsedItemName)
        end
    end)
end

function HeroBuilder:ShowRandomAbilitySelectionFree(PlayerID, AbilityToDelete, bIsRelearnBook, bIsMainSSS, nParagonType)
    if not self.Players[PlayerID] then return false end

    if bIsMainSSS and self.Players[PlayerID].SSS_ability_select_count <= 0 then return false end

    if not self:IsPlayerSelectingAbility(PlayerID) or bIsRelearnBook then
        self.Players[PlayerID].ability_select_count = self.Players[PlayerID].ability_select_count + 1

        self:ShowRandomAbilitySelection(PlayerID, AbilityToDelete, bIsRelearnBook, bIsMainSSS, nParagonType)

        return true
    end

    return false
end

-- Выбор способности
-- Создание окна с выбором способности
function HeroBuilder:ShowRandomAbilitySelection(PlayerID, AbilityToDelete, bIsRelearnBook, bIsMainSSS, nParagonType)
    if not self.Players[PlayerID] or (not bIsRelearnBook and not bIsMainSSS and not self:IsPlayerCanSelectAbilities(PlayerID)) or not self.Players[PlayerID].selected_hero_ent then return end

    if bIsMainSSS and self.Players[PlayerID].SSS_ability_select_count <= 0 then return end

    local Player = self.Players[PlayerID].selected_hero_ent:GetPlayerOwner()

    if not Player then return end

    if bIsMainSSS then
        self.Players[PlayerID].selecting_ability_instance = "main_sss"
    end

    if nParagonType == 1 then
        self.Players[PlayerID].selecting_ability_instance = "paragon"
    elseif nParagonType == 2 then
        self.Players[PlayerID].selecting_ability_instance = "paragon_2"
    end

    local bIsRelearnReturnBook = self.Players[PlayerID].selecting_ability_instance == "relearn_return"
    local bIsRelearnSSSBook = self.Players[PlayerID].selecting_ability_instance == "relearn_sss"

    local RandomAbilities = {}
    if bIsMainSSS then
        if GetGameSetting("FIRST_ABILITY_IS_GENERAL") == 1 then
            RandomAbilities = self.IdealAbilitiesList
        else
            RandomAbilities = self:GenerateAbilitiesListForRandom(PlayerID, AbilityToDelete, bIsRelearnReturnBook, true, true)
        end
    else
        RandomAbilities = self:GenerateAbilitiesListForRandom(PlayerID, AbilityToDelete, bIsRelearnReturnBook, bIsRelearnSSSBook)
    end

    self.Players[PlayerID].random_abilities = RandomAbilities

    local dataList = {}
    for _, randomAbilityName in pairs(self.Players[PlayerID].random_abilities) do
        local data = {}

        data.ability_name = randomAbilityName
        
        if KeyValues.AbilitiesList[randomAbilityName] and KeyValues.AbilitiesList[randomAbilityName].LinkedAbilities then
            data.linked_abilities = KeyValues.AbilitiesList[randomAbilityName].LinkedAbilities
        end

        table.insert(dataList, data)
    end
    if self.Players[PlayerID].selecting_ability_instance == "" or self.Players[PlayerID].selecting_ability_instance == nil then
        self.Players[PlayerID].selecting_ability_instance = "main"
    end

    if self.Players[PlayerID].selecting_ability_instance == "relearn_return" or self.Players[PlayerID].selecting_ability_instance == "relearn_sss" or self.Players[PlayerID].selecting_ability_instance == "relearn" then
        self:IncrementBooks(PlayerID)
    end

    local Instance = self.Players[PlayerID].selecting_ability_instance
    local bCanRandom = true
    if Instance == "relearn" or Instance == "relearn_return" or Instance == "relearn_sss" then
        bCanRandom = self.Players[PlayerID].selecting_ability_deleted_index ~= nil
    end

    -- PlayerTables:SetTableValue("player_"..PlayerID, "ability_selection", {
    --     state = "SHOW",
    --     abilities = self.Players[PlayerID].random_abilities,
    --     instance = self.Players[PlayerID].selecting_ability_instance
    -- })

    -- CustomGameEventManager:Send_ServerToPlayer(Player, "ShowRandomAbilitySelection", {data_list = dataList, ability_number = 1, can_random = bCanRandom})
end

function HeroBuilder:AbilitySelected(event)
    local AbilityName = event.ability_name
    local PlayerID = event.player_id

    if not self.Players[PlayerID] or not 
    self:IsPlayerSelectingAbility(PlayerID) then return end

    local Instance = self.Players[PlayerID].selecting_ability_instance

    -- Если это закрытие окна (AbilityName == nil) и ещё не выбрана способность на замену,
    -- то блокируем случайный выбор, но разрешаем закрытие окна и возвращаем книгу
    if AbilityName == nil and (Instance == "relearn" or Instance == "relearn_return" or Instance == "relearn_sss") and self.Players[PlayerID].selecting_ability_deleted_index == nil then
        local Hero = self.Players[PlayerID].selected_hero_ent
        if Hero and not Hero:IsNull() then
            local ItemName = "item_relearn_book_lua"
            if Instance == "relearn_return" then
                ItemName = "item_relearn_book_return"
            elseif Instance == "relearn_sss" then
                ItemName = "item_relearn_book_sss"
            end
            local Item = CreateItem(ItemName, Hero, Hero)
            Hero:AddItem(Item)
        end
        self:SetSelectingInstance(PlayerID, "")
        return
    end

    if AbilityName == nil then
        self.Players[PlayerID].random_abilities = {}
        self.Players[PlayerID].random_abilities = self:GenerateAbilitiesListForRandom(PlayerID)
        AbilityName = table.random(self.Players[PlayerID].random_abilities)
    end

    if not table.contains(self.Players[PlayerID].random_abilities, AbilityName) then return end

    self.Players[PlayerID].random_abilities = {}

    self.Players[PlayerID].selecting_ability_instance = ""

    table.insert(self.Players[PlayerID].abilities_list, AbilityName)
    local CurrentRound = math.max(1, Rounds:GetCurrentRound())
    self.Players[PlayerID].abilities_list_server[AbilityName] = CurrentRound

    local PlayerInfo = Server:GetPlayerInfo(PlayerID)
    if CurrentRound == 9 and self.Players[PlayerID].ability_select_count > 0 and PlayerInfo and PlayerInfo.settings and PlayerInfo.settings.settings_hints_enabled ~= 0 then
        local Player = PlayerResource:GetPlayer(PlayerID)
        if Player then
            Timers:CreateTimer(1.0, function()
                if Player and Player:IsAlive() then
                    CustomGameEventManager:Send_ServerToPlayer(Player, "cha_hint_visible", {hint = "swap"})
                end
            end)
        end
    end

    -- Подсказка о способностях с полетом для дефа крипов
    local FlyAbilities = {
        "winter_wyvern_arctic_burn_lua",
        "dragon_knight_elder_dragon_form_custom",
        "undying_flesh_golem_custom",
        "sven_gods_strength_custom",
        "lina_laguna_blade_lua",
        "lycan_shapeshift_custom",
        "keeper_of_the_light_spirit_form_custom",
        "terrorblade_metamorphosis_lua"
    }
    if table.contains(FlyAbilities, AbilityName) and PlayerInfo and PlayerInfo.settings and PlayerInfo.settings.settings_hints_enabled ~= 0 then
        local Player = PlayerResource:GetPlayer(PlayerID)
        if Player then
            Timers:CreateTimer(1.0, function()
                if Player and Player:IsAlive() then
                    CustomGameEventManager:Send_ServerToPlayer(Player, "cha_hint_visible", {hint = "creeps"})
                end
            end)
        end
    end
    if self.AbilitiesCounter[AbilityName] then
        self.AbilitiesCounter[AbilityName] = self.AbilitiesCounter[AbilityName] - 1
    end

    local bPutInIndex = nil
    if self.Players[PlayerID].selecting_ability_deleted_index ~= nil then
        bPutInIndex = self.Players[PlayerID].selecting_ability_deleted_index
        self.Players[PlayerID].selecting_ability_deleted_index = nil
    end

    self:AddAbility(PlayerID, AbilityName, nil, nil, bPutInIndex)

    if Instance == "main_sss" then
        self.Players[PlayerID].SSS_ability_select_count = self.Players[PlayerID].SSS_ability_select_count - 1
    else
        self.Players[PlayerID].ability_select_count = self.Players[PlayerID].ability_select_count - 1
    end

    local NotificationItem = ""
    if Instance == "relearn_sss" then
        NotificationItem = "item_relearn_book_sss"
    elseif Instance == "relearn_return" then
        NotificationItem = "item_relearn_book_return"
    elseif Instance == "paragon" then
        NotificationItem = "item_paragon_book"
    elseif Instance == "paragon_2" then
        NotificationItem = "item_paragon_book_2"
    end

    if (Instance == "relearn_sss" or Instance == "relearn_return" or Instance == "paragon" or Instance == "paragon_2") and NotificationItem ~= "" then
        Notifications:AddNotification(NOTIFICATION_TYPE.USED_BOOK, Rounds:GetCurrentRound(), {
            player1 = PlayerID,
            item1 = NotificationItem
        })
    end
    
    self:ShowRandomAbilitySelection(PlayerID)
end

function HeroBuilder:GiveRandomAbility(PlayerID)
    if not self.Players[PlayerID] then return end

    local AbilityName = table.random(self:GenerateAbilitiesListForRandom(PlayerID))

    if self.AbilitiesCounter[AbilityName] then
        self.AbilitiesCounter[AbilityName] = self.AbilitiesCounter[AbilityName] - 1
    end

    table.insert(self.Players[PlayerID].abilities_list, AbilityName)
    local CurrentRound = math.max(1, Rounds:GetCurrentRound())
    self.Players[PlayerID].abilities_list_server[AbilityName] = CurrentRound
    self:AddAbility(PlayerID, AbilityName)
end

function HeroBuilder:GetAllAbilities(hHero)
    local abilities = {}
    for i = 0, hHero:GetAbilityCount() - 1 do
        local hAbility = hHero:GetAbilityByIndex(i)
        if hAbility and not hAbility:IsNull() then
            abilities[hAbility:GetAbilityName()] = true
        end
    end
    return abilities
end

function HeroBuilder:IsInnateOrFacetAbility(abilityName)
    -- Проверяем через abilities_settings (bIgnoredInnate)
    local settings = ABILITIES_SETTINGS[abilityName]
    if settings and settings.bIgnoredInnate then
        return true
    end

    -- Проверяем через KeyValues
    for heroName, heroData in pairs(KeyValues.HeroesList) do
        if heroData.innate_abilities then
            for _, innate in ipairs(heroData.innate_abilities) do
                if innate == abilityName then return true end
            end
        end
        if heroData.facet_abilities then
            for _, facet in ipairs(heroData.facet_abilities) do
                if facet == abilityName then return true end
            end
        end
    end
    return false
end

function HeroBuilder:CleanupAfterAddAbility(hHero, abilitiesBefore, sAddedAbilityName)
    local heroInnateList = KeyValues:GetHeroInnatesAndFacetsAbilities(hHero:GetUnitName())

    -- Собираем список суб-способностей добавляемой способности
    local linkedAbilities = {}
    local AbilityInfo = KeyValues:GetAbility(sAddedAbilityName)
    if AbilityInfo and AbilityInfo.LinkedAbilities then
        for linkedName, _ in pairs(AbilityInfo.LinkedAbilities) do
            linkedAbilities[linkedName] = true
        end
    end

    -- Шаг 1: Удаляем чужие innate/facet, суб-способности оставляем скрытыми, обычные связанные делаем видимыми
    for i = hHero:GetAbilityCount() - 1, 0, -1 do
        local hAbility = hHero:GetAbilityByIndex(i)
        if hAbility and not hAbility:IsNull() then
            local abilityName = hAbility:GetAbilityName()
            if not abilitiesBefore[abilityName] and abilityName ~= sAddedAbilityName then
                if self:IsInnateOrFacetAbility(abilityName) then
                    hHero:RemoveAbility(abilityName)
                elseif linkedAbilities[abilityName] then
                    -- Суб-способность (launch_snowball, return_custom и т.д.) — оставляем скрытой
                    hAbility:SetHidden(true)
                elseif not KeyValues:GetAbility(abilityName) then
                    -- Способность не в основном пуле — это суб-способность движка, оставляем скрытой
                    hAbility:SetHidden(true)
                else
                    -- Обычная связанная способность (напр. Equilibrium) — делаем видимой
                    hAbility:SetHidden(false)
                    hAbility:SetLevel(1)
                    hAbility:MarkAbilityButtonDirty()
                    hAbility:UpdateAbilitySlot()
                end
            end
        end
    end

    -- Шаг 2: Восстанавливаем врождённые способности героя, если они пропали
    for _, abilityName in ipairs(heroInnateList) do
        if abilitiesBefore[abilityName] and not hHero:HasAbility(abilityName) then
            -- Удаляем чужую способность, которая заменила врождённую (появилась на её месте)
            for i = hHero:GetAbilityCount() - 1, 0, -1 do
                local hAbility = hHero:GetAbilityByIndex(i)
                if hAbility and not hAbility:IsNull() then
                    local name = hAbility:GetAbilityName()
                    if not abilitiesBefore[name] and name ~= sAddedAbilityName then
                        hHero:RemoveAbility(name)
                    end
                end
            end
            -- Восстанавливаем врождённую
            local restored = hHero:AddAbility(abilityName)
            if restored and not restored:IsNull() then
                restored:ClearInnateModifiers()
                restored:SetLevel(1)
                restored:MarkAbilityButtonDirty()
                restored.ignore_ability_structure = true
            end
        end
    end
end

function HeroBuilder:ShowEngineLinkedAbilities(hHero, abilitiesBefore, sAddedAbilityName)
    -- Собираем суб-способности добавляемой способности
    local linkedAbilities = {}
    local AbilityInfo = KeyValues:GetAbility(sAddedAbilityName)
    if AbilityInfo and AbilityInfo.LinkedAbilities then
        for linkedName, _ in pairs(AbilityInfo.LinkedAbilities) do
            linkedAbilities[linkedName] = true
        end
    end

    for i = 0, hHero:GetAbilityCount() - 1 do
        local hAbility = hHero:GetAbilityByIndex(i)
        if hAbility and not hAbility:IsNull() then
            local abilityName = hAbility:GetAbilityName()
            -- Способность добавлена движком, не innate героя, не talent, не суб-способность — делаем видимой
            if not abilitiesBefore[abilityName] and abilityName ~= sAddedAbilityName
                and not string.find(abilityName, "special_bonus")
                and not self:IsInnateOrFacetAbility(abilityName)
                and not linkedAbilities[abilityName]
                and KeyValues:GetAbility(abilityName)
                and hAbility:IsHidden() then
                hAbility:SetHidden(false)
                if hAbility:GetLevel() < 1 then
                    hAbility:SetLevel(1)
                end
                hAbility:MarkAbilityButtonDirty()
                hAbility:UpdateAbilitySlot()
            end
        end
    end
end

function HeroBuilder:AddAbility(PlayerID, sAbilityName, nLevel, flCoolDown, nPutInIndex)
    if not self.Players[PlayerID] then return end

    local hHero = self.Players[PlayerID].selected_hero_ent
    if hHero == nil or hHero:IsNull() then return end

    local status, err = pcall(function()
        local bHasInvulnerable = false
        if hHero:HasModifier("modifier_hero_refreshing") then
            bHasInvulnerable = true
            hHero:RemoveModifierByName("modifier_hero_refreshing")
        end
        local abilitiesBefore = HeroBuilder:GetAllAbilities(hHero)
        local hNewAbility = hHero:AddAbility(sAbilityName)
        HeroBuilder:CleanupAfterAddAbility(hHero, abilitiesBefore, sAbilityName)
        if hNewAbility and (not hNewAbility:IsNull()) then
            hNewAbility:MarkAbilityButtonDirty()
            hNewAbility:ClearInnateModifiers()
            hHero:CalculateStatBonus(false) 
            if flCoolDown and flCoolDown > 0 then
                hNewAbility:StartCooldown(flCoolDown)
            end
            local AbilitySettings = ABILITIES_SETTINGS[sAbilityName]
            if AbilitySettings and AbilitySettings.BonusModifiers then
                for _, BonusModifierName in pairs(AbilitySettings.BonusModifiers) do
                    hHero:AddNewModifier(hHero, hNewAbility, BonusModifierName, {})
                end
            end
            hNewAbility:SetRefCountsModifiers(true)
            if nLevel and nLevel>0 then
                hNewAbility:SetLevel(nLevel)
            end
            Timers:CreateTimer(0.1, function()
                if not hNewAbility or hNewAbility:IsNull() then return 1 end
                hNewAbility:SetHidden(false)
                if nPutInIndex ~= nil then
                    hNewAbility:SetAbilityToSlot(nPutInIndex)
                else
                    hNewAbility:UpdateAbilitySlot()
                end
                HeroBuilder:AddLinkedAbilities(hHero,sAbilityName,nLevel)
                HeroBuilder:AddScepterLinkAbilities(hHero)
                HeroBuilder:AddShardLinkAbilities(hHero)
                HeroBuilder:FixShardAbilities(hHero)
                HeroBuilder:ShowEngineLinkedAbilities(hHero, abilitiesBefore, sAbilityName)
                HeroBuilder:RefreshAbilityOrder(PlayerID)
            end)
        end
        if bHasInvulnerable then
            hHero:AddNewModifier(hHero, nil, "modifier_hero_refreshing", {})
        end
        local AbilityInfo = KeyValues.AbilitiesList[sAbilityName]
        if AbilityInfo and AbilityInfo.HeroName and self.Precache[AbilityInfo.HeroName] == nil then
            self.Precache[AbilityInfo.HeroName] = false
        end
    end)

    if not status then
        print("Произошла ошибка: " .. err)
    end
end

function HeroBuilder:AddAbilityToUnit(hHero, sAbilityName, nLevel, flCoolDown)
    if hHero == nil or hHero:IsNull() then return end

    local status, err = pcall(function()
        local bHasInvulnerable = false
        if hHero:HasModifier("modifier_hero_refreshing") then
            bHasInvulnerable = true
            hHero:RemoveModifierByName("modifier_hero_refreshing")
        end
        local abilitiesBefore = HeroBuilder:GetAllAbilities(hHero)
        local hNewAbility = hHero:AddAbility(sAbilityName)
        HeroBuilder:CleanupAfterAddAbility(hHero, abilitiesBefore, sAbilityName)
        if hNewAbility and (not hNewAbility:IsNull()) then
            hNewAbility:MarkAbilityButtonDirty()
            hNewAbility:ClearInnateModifiers()
            hHero:CalculateStatBonus(false) 
            if flCoolDown and flCoolDown > 0 then
                hNewAbility:StartCooldown(flCoolDown)
            end
            local AbilitySettings = ABILITIES_SETTINGS[sAbilityName]
            if AbilitySettings and AbilitySettings.BonusModifiers then
                for _, BonusModifierName in pairs(AbilitySettings.BonusModifiers) do
                    hHero:AddNewModifier(hHero, hNewAbility, BonusModifierName, {})
                end
            end
            hNewAbility:SetRefCountsModifiers(true)
            if nLevel and nLevel>0 then
                hNewAbility:SetLevel(nLevel)
            end
            Timers:CreateTimer(0.1, function()
                if not hNewAbility or hNewAbility:IsNull() then return 1 end
                hNewAbility:SetHidden(false)
                hNewAbility:UpdateAbilitySlot()
                HeroBuilder:AddLinkedAbilities(hHero,sAbilityName,nLevel)
                HeroBuilder:AddScepterLinkAbilities(hHero)
                HeroBuilder:AddShardLinkAbilities(hHero)
                HeroBuilder:FixShardAbilities(hHero)
                if hHero.GetPlayerOwnerID and hHero:GetPlayerOwnerID() ~= -1 then
                    HeroBuilder:RefreshAbilityOrder(hHero:GetPlayerOwnerID())
                end
            end)
        end
        if bHasInvulnerable then
            hHero:AddNewModifier(hHero, nil, "modifier_hero_refreshing", {})
        end
        local AbilityInfo = KeyValues.AbilitiesList[sAbilityName]
        if AbilityInfo and AbilityInfo.HeroName and self.Precache[AbilityInfo.HeroName] == nil then
            self.Precache[AbilityInfo.HeroName] = false
        end
    end)

    if not status then
        print("Произошла ошибка: " .. err)
    end
end

function HeroBuilder:ShowOmniscientSelection(PlayerID)
    if not self.Players[PlayerID] then return end

    local Hero = self.Players[PlayerID].selected_hero_ent
    if not Hero then return end

    local hPlayer = PlayerResource:GetPlayer(PlayerID)
    if not hPlayer then return end

    if not self:IsPlayerSelectAbilities(PlayerID) then return end

    -- if self.Players[PlayerID].selecting_ability_instance ~= "omniscient" and self.Players[PlayerID].selecting_ability_instance ~= "" then return end

    -- self:SetSelectingInstance(PlayerID, "omniscient")

    -- SECURITY: серверный маркер «dev/omniscient-меню реально открыто этим игроком».
    -- Меню легитимно открывается только отсюда (через чит-итем item_omniscient_book).
    -- Без этого флага обработчик builder_omniscient_selected принимал ивент от ЛЮБОГО
    -- клиента → чит-панель выдавала себе любую способность. Флаг снимается при выборе/закрытии.
    self.Players[PlayerID].omniscient_open = true

    CustomGameEventManager:Send_ServerToPlayer(hPlayer, "builder_show_omniscient", {})
end

function HeroBuilder:OnPlayerOmniscientSelectedAbility(event)
    local AbilityName = event.ability_name
    local PlayerID=event.PlayerID

    if not self.Players[PlayerID] then return end

    -- SECURITY: принимаем выбор только если сервер реально открыл этому игроку
    -- dev/omniscient-меню (флаг ставится в ShowOmniscientSelection). Иначе сторонний
    -- клиент мог послать этот CustomGameEvent и выдать себе любую способность.
    if not self.Players[PlayerID].omniscient_open then return end
    if not self:IsPlayerSelectAbilities(PlayerID) then return end
    if type(AbilityName) ~= "string" or AbilityName == "" then return end
    self.Players[PlayerID].omniscient_open = nil

    -- self.Players[PlayerID].selecting_ability_instance = ""

    table.insert(self.Players[PlayerID].abilities_list, AbilityName)
    local CurrentRound = math.max(1, Rounds:GetCurrentRound())
    self.Players[PlayerID].abilities_list_server[AbilityName] = CurrentRound
    self:AddAbility(PlayerID, AbilityName)

    self:NextAbilitySelection(PlayerID)
end

function HeroBuilder:OnPlayerOmniscientClosed(event)
    local PlayerID=event.PlayerID

    if not self.Players[PlayerID] then return end

    -- SECURITY: реагируем на закрытие только если меню реально было открыто сервером,
    -- иначе спуфнутый ивент мог продвигать чужую очередь выбора способностей.
    if not self.Players[PlayerID].omniscient_open then return end
    self.Players[PlayerID].omniscient_open = nil

    -- self.Players[PlayerID].selecting_ability_instance = ""

    self:NextAbilitySelection(PlayerID)
end

function HeroBuilder:RelearnBookAbilitySelected(params)
    local PlayerID = params.player_id

    if not self.Players[PlayerID] then return end

    local Hero = self.Players[PlayerID].selected_hero_ent

    if Hero == nil or Hero:IsNull() then return end

    local AbilityName = params.ability_name
    local bDelete = true
    if AbilityName == "DONT_DELETE" then
        bDelete = false
    end
    local BookType = params.book_type

    -- Отключение хука
    local hook = Hero:FindAbilityByName("pudge_meat_hook")
    if hook then
        hook:SetActivated(true)
    end

    -- -- Удаление Ice Blast
    -- if AbilityName == "ancient_apparition_ice_blast" then
    --     local ancient_apparition_ice_blast = Hero:FindAbilityByName(AbilityName)
    --     if ancient_apparition_ice_blast and ancient_apparition_ice_blast:IsHidden() then
    --         AbilityName = nil
    --     end
    -- end

    -- Проверяем, не является ли способность украденной через Spell Steal
    local rubick_skill = Hero:FindAbilityByName("rubick_spell_steal_custom")
    if rubick_skill and rubick_skill.currentSpell ~= nil and not rubick_skill.currentSpell:IsNull() then
        local stolen_name = rubick_skill.currentSpell:GetName()
        print("[HeroBuilder] Checking relearn for: " .. (AbilityName or "nil") .. ", stolen: " .. stolen_name)
        if AbilityName == stolen_name then
            print("[HeroBuilder] Blocking relearn of stolen ability!")
            AbilityName = nil
        end
    end

    -- Если у игрока нет абилки
    if AbilityName ~= "DONT_DELETE" and not table.contains(self.Players[PlayerID].abilities_list, AbilityName) then
        AbilityName = nil 
    end

    if AbilityName == nil and self.Players[PlayerID].selecting_ability_instance == "relearn" then
        local Item = CreateItem("item_relearn_book_lua", Hero, Hero)
        Hero:AddItem(Item)

        self:SetSelectingInstance(PlayerID, "")

        return 
    end

    if AbilityName == nil and self.Players[PlayerID].selecting_ability_instance == "relearn_return" then
        local Item = CreateItem("item_relearn_book_return", Hero, Hero)
        Hero:AddItem(Item)

        self:SetSelectingInstance(PlayerID, "")

        return 
    end

    if AbilityName == nil and self.Players[PlayerID].selecting_ability_instance == "relearn_sss" then
        local Item = CreateItem("item_relearn_book_sss", Hero, Hero)
        Hero:AddItem(Item)

        self:SetSelectingInstance(PlayerID, "")

        return 
    end

    -- Онли с читами
    if AbilityName == nil and self.Players[PlayerID].selecting_ability_instance == "omniscient" then
        local Item = CreateItem("item_omniscient_book", Hero, Hero)
        Hero:AddItem(Item)

        self:SetSelectingInstance(PlayerID, "")

        return 
    end

    self.Players[PlayerID].selecting_ability_deleted_index = nil

    if bDelete and not GetAbilitySetting(AbilityName, "bUnremovable") then

        local fAbility = Hero:FindAbilityByName(AbilityName)
        if fAbility then
            local nAbilityLevel = fAbility:GetLevel()
            local nAbilityPoints = Hero:GetAbilityPoints() + nAbilityLevel
            Hero:SetAbilityPoints(nAbilityPoints)
            self:RemoveAbility(PlayerID, AbilityName)
            self.Players[PlayerID].abilities_list_server[AbilityName] = nil
            self.Players[PlayerID].selecting_ability_deleted_index = fAbility:GetAbilityIndex()
            table.remove_item(self.Players[PlayerID].abilities_list, AbilityName)
        end
    end

    if BookType == 1 then
        self:ShowOmniscientSelection(PlayerID)     
    elseif BookType == 2 then
        self:ShowRandomAbilitySelectionFree(PlayerID, AbilityName, true)
    else
        self:ShowRandomAbilitySelectionFree(PlayerID, AbilityName, true)
    end

    self:RefreshAbilityOrder(PlayerID)
end

-- Other Functions
function HeroBuilder:RefreshAbilityOrder(nPlayerID)
    local hPlayer = PlayerResource:GetPlayer(nPlayerID)
    local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
    if hPlayer and hHero then
        Timers:CreateTimer(0.1, function()
            CustomGameEventManager:Send_ServerToPlayer(hPlayer,"RefreshAbilityOrder",{})
        end)
    end
end

-- DOTA_ABILITY_BEHAVIOR_INNATE_UI = 2^43 — хеш-флаг placeholder-иконок
-- врождённых способностей (Сила Силлы, innate_disabled_placeholder и т.п.)
local DOTA_ABILITY_BEHAVIOR_INNATE_UI_BIT = 8796093022208

-- "Не-спелл" = таланты (special_bonus_*) и иконки врождённых-плейсхолдеров.
-- Они не должны конкурировать с пиками за слоты Q/W/E/R/D/F.
function HeroBuilder:IsNonSpellAbility(hAbility)
    if not hAbility or hAbility:IsNull() then return false end
    local sName = hAbility:GetAbilityName()
    if sName and string.find(sName, "special_bonus") then return true end
    if hAbility.HasBehaviorUint and hAbility:HasBehaviorUint(DOTA_ABILITY_BEHAVIOR_INNATE_UI_BIT) then
        return true
    end
    return false
end

function HeroBuilder:OnRefreshHeroBindings(userID, event)
    local nPlayerID = event and event.PlayerID
    if nPlayerID == nil or nPlayerID < 0 then return end

    local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
    if hHero == nil or hHero:IsNull() then return end

    -- Собираем имена видимых способностей (без special_bonus и hidden)
    -- чтобы дёрнуть их через SwapAbilities — это форсит движок переприсвоить
    -- слот-индексы (то, что обычно делает замена способности через книгу).
    local visibleAbilities = {}
    for i = 0, hHero:GetAbilityCount()-1 do
        local hAbility = hHero:GetAbilityByIndex(i)
        if hAbility and not hAbility:IsNull() and not hAbility:IsHidden() then
            local name = hAbility:GetName()
            if name and name ~= "" and not name:find("special_bonus") and name ~= "generic_hidden" then
                table.insert(visibleAbilities, name)
            end
        end
    end

    -- "No-op" swap каждой соседней пары и обратно: слот-порядок не меняется,
    -- но движок отмечает слоты dirty и перепривязывает биндинги
    if #visibleAbilities >= 2 then
        for i = 1, #visibleAbilities - 1 do
            local a, b = visibleAbilities[i], visibleAbilities[i+1]
            hHero:SwapAbilities(a, b, true, true)
            hHero:SwapAbilities(a, b, true, true)
        end
    end

    -- ВАЖНО: UpdateAbilitySlot для passive-талантов (IsAttributeBonus) ищет
    -- первый hidden+passive+не-attribute-bonus слот для свопа. Innate-плейсхолдеры
    -- (lone_druid_starter_innate с INNATE_UI) подходят под условие → талант
    -- засасывается в слот W/E/R, ломая хоткеи. Поэтому для не-спеллов вызов
    -- UpdateAbilitySlot НЕ делаем — оставляем их движку как есть.
    for i = 0, hHero:GetAbilityCount()-1 do
        local hAbility = hHero:GetAbilityByIndex(i)
        if hAbility and not hAbility:IsNull() then
            hAbility:MarkAbilityButtonDirty()
            if not self:IsNonSpellAbility(hAbility) then
                hAbility:UpdateAbilitySlot()
            end
        end
    end

    HeroBuilder:RefreshAbilityOrder(nPlayerID)
end

function HeroBuilder:SwapAbility(keys)
    local nPlayerID=keys.player_id
    local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
    local sSwap_1=keys.swap_1
    local sSwap_2=keys.swap_2
    if hHero then
        local hAbility1 = hHero:FindAbilityByName(sSwap_1)
        local hAbility2 = hHero:FindAbilityByName(sSwap_2)
        if hAbility1 and hAbility2  and not hAbility1:IsHidden() and not hAbility2:IsHidden() then
            hHero:SwapAbilities(sSwap_1, sSwap_2, true, true)
        end
    end
    HeroBuilder:RefreshAbilityOrder(nPlayerID)
end

function HeroBuilder:RegisterAttackCapabilityChanged(hHero)
    if not hHero:IsRealHero() then return end
    if not hHero or hHero:IsTempestDouble() or hHero:HasModifier("modifier_arc_warden_tempest_double_lua") then 
        return 
    end
    local PlayerID = hHero:GetPlayerID()

    if self.Players[PlayerID] == nil then return end

    self.Players[PlayerID].attack_capability_changed = true
end

function HeroBuilder:FixAttackCapability()
    for PlayerID, PlayerInfo in pairs(self.Players) do
        if PlayerInfo.selected_hero_ent ~= nil and PlayerInfo.attack_capability_changed and not self:HasAttackCapabilityModifiers(PlayerInfo.selected_hero_ent) then
            PlayerInfo.selected_hero_ent:SetAttackCapability(PlayerInfo.attack_capability)
        end
    end
end

function HeroBuilder:HasAttackCapabilityModifiers(hHero)
    for _, hModifier in ipairs(hHero:FindAllModifiers()) do
        if IsModifierChangesAttackCap(hModifier:GetName()) then
            return true
        end
    end
    return false
end

-- Scepters

function HeroBuilder:ProcessScepterOwners()
    for PlayerID, PlayerInfo in pairs(self.Players) do
        if PlayerInfo.has_scepter and PlayerInfo.selected_hero_ent and not PlayerInfo.selected_hero_ent:HasScepter() then
            self:OnScepterLost(PlayerInfo.selected_hero_ent)
        end
    end
end

function HeroBuilder:OnScepterLost(hHero)
    if not hHero or not hHero:IsMainHero() then return end

    self:UnregisterScepterOwner(hHero)

    for i = 0, hHero:GetAbilityCount() - 1 do
        local hAbility = hHero:GetAbilityByIndex(i)
        if hAbility and hAbility.bScepterAbility then
            local sAbilityName = hAbility:GetAbilityName()
            hHero:RemoveAbilityWithRestructure(sAbilityName) -- Удаление способности
        end
    end
    self:RefreshAbilityOrder(hHero:GetPlayerOwnerID())

    if hHero:HasModifier("modifier_bloodseeker_blood_mist_custom") then
        hHero:RemoveModifierByName("modifier_bloodseeker_blood_mist_custom")
    end

    EventDriver:Dispatch("Hero:scepter_lost", { hero = hHero } )
end

function HeroBuilder:RegisterScepterOwner(hHero)
    if not hHero or not hHero:IsMainHero() or not hHero:IsRealHero() then return end
    local PlayedID = hHero:GetPlayerID()
    
    if not self.Players[PlayedID] then return end

    self.Players[PlayedID].has_scepter = true
end

function HeroBuilder:UnregisterScepterOwner(hHero)
    if not hHero or not hHero:IsMainHero() or not hHero:IsRealHero() then return end
    local PlayedID = hHero:GetPlayerID()
    
    if not self.Players[PlayedID] then return end

    self.Players[PlayedID].has_scepter = false
end

function HeroBuilder:AddScepterAbility(hHero)
    if hHero and hHero:IsRealHero() and hHero:GetUnitName() then
        if HEROES_SETTINGS[hHero:GetUnitName()] and HEROES_SETTINGS[hHero:GetUnitName()].ScepterAbilities then
            for i,sAbilityName in ipairs(HEROES_SETTINGS[hHero:GetUnitName()].ScepterAbilities) do
                local hAbility = hHero:FindAbilityByName(sAbilityName)
                if not hAbility then
                  local hScepterAbility = hHero:AddAbility(sAbilityName)
                  if hScepterAbility and (not hScepterAbility:IsNull()) then
                        hScepterAbility:SetLevel(1)
                        hScepterAbility.bScepterAbility = true
                        hScepterAbility:MarkAbilityButtonDirty()
                        local AbilitySettings = ABILITIES_SETTINGS[sAbilityName]
                        if AbilitySettings and AbilitySettings.BonusModifiers then
                            for _, BonusModifierName in pairs(AbilitySettings.BonusModifiers) do
                                hHero:AddNewModifier(hHero, hScepterAbility, BonusModifierName, {})
                            end
                        end
                        if i == 1 then
                            Timers:CreateTimer(0.1, function()
                                if not hScepterAbility or hScepterAbility:IsNull() then return end
                                hScepterAbility:SetHidden(false)
                                hScepterAbility:UpdateAbilitySlot()
                            end)
                        end
                    end
                end
            end
        end
        if hHero.GetPlayerID and hHero:GetPlayerID() then
            Timers:CreateTimer(FrameTime(), function()
                HeroBuilder:RefreshAbilityOrder(hHero:GetPlayerID())
            end)
        end
    end
end

function HeroBuilder:AddScepterShardAbility(nHeroIndex)
    local hHero = EntIndexToHScript(nHeroIndex)
    if hHero and hHero:IsRealHero() and hHero:GetUnitName() and HEROES_SETTINGS[hHero:GetUnitName()] and HEROES_SETTINGS[hHero:GetUnitName()].ShardAbilities then
        for i,sAbilityName in ipairs(HEROES_SETTINGS[hHero:GetUnitName()].ShardAbilities) do
            local hAbility = hHero:FindAbilityByName(sAbilityName)
            if not hAbility then
              local hScepterShardAbility= hHero:AddAbility(sAbilityName)
                if hScepterShardAbility then
                    hScepterShardAbility:SetLevel(1)
                    hScepterShardAbility:MarkAbilityButtonDirty()
                    local AbilitySettings = ABILITIES_SETTINGS[sAbilityName]
                    if AbilitySettings and AbilitySettings.BonusModifiers then
                        for _, BonusModifierName in pairs(AbilitySettings.BonusModifiers) do
                            hHero:AddNewModifier(hHero, hScepterShardAbility, BonusModifierName, {})
                        end
                    end
                    if i == 1 then
                        Timers:CreateTimer(0.1, function()
                            if not hScepterShardAbility or hScepterShardAbility:IsNull() then return end
                            hScepterShardAbility:SetHidden(false)
                            hScepterShardAbility:UpdateAbilitySlot()
                        end)
                    end
                end
            end
        end
        if hHero.GetPlayerID and hHero:GetPlayerID() then
            Timers:CreateTimer(FrameTime(), function()
                HeroBuilder:RefreshAbilityOrder(hHero:GetPlayerID())
            end)
        end
    end
    if hHero and hHero:IsRealHero() and hHero:GetUnitName() then
        HeroBuilder:FixShardAbilities(hHero)
    end
    --if hHero:IsRealHero() and hHero:GetUnitName() and hHero:GetUnitName()=="npc_dota_hero_lycan" and not hHero:IsTempestDouble() and not hHero:HasModifier("modifier_arc_warden_tempest_double_lua") then
    --    if not hHero.bElfWolf then
    --        hHero.bElfWolf = true
    --        Rounds:AddExtraCreature(hHero:GetPlayerID(),"npc_dota_elf_wolf")
    --    end
    --end
end

function HeroBuilder:FixShardAbilities(hHero)
    if hHero:HasModifier("modifier_item_aghanims_shard") then
        if hHero:HasAbility("sandking_epicenter") then
            if not hHero:HasModifier("modifier_sand_king_shard") then
                hHero:AddNewModifier(hHero, hHero:FindAbilityByName("sandking_epicenter"), "modifier_sand_king_shard", {})
            end
        end
        if hHero:HasAbility("dragon_knight_elder_dragon_form_custom") then
            if not hHero:HasAbility("dragon_knight_fireball") then
                hHero:AddAbility("dragon_knight_fireball")
            end
        end
    end
end

function HeroBuilder:RemoveScepterLinkAbilities(hHero,sRawAbilityName)
    if hHero and  hHero:IsRealHero() and hHero:GetUnitName() and ABILITIES_SETTINGS[sRawAbilityName] and ABILITIES_SETTINGS[sRawAbilityName].ScepterAbilities then
        for i,sAbilityName in ipairs(ABILITIES_SETTINGS[sRawAbilityName].ScepterAbilities) do
            local hAbility = hHero:FindAbilityByName(sAbilityName)
            if hAbility then
                if HEROES_SETTINGS[hHero:GetUnitName()] == nil or (not table.contains(HEROES_SETTINGS[hHero:GetUnitName()].ScepterAbilities, sAbilityName)) then
                    hHero:RemoveAbilityWithRestructure(sAbilityName) -- Удаление способности
                end
            end
        end
        if hHero.GetPlayerID and hHero:GetPlayerID() then
            Timers:CreateTimer(FrameTime(), function()
                HeroBuilder:RefreshAbilityOrder(hHero:GetPlayerID())
            end)
        end
    end
end

function HeroBuilder:RemoveShardLinkAbilities(hHero,sRawAbilityName)
    if hHero and hHero:IsRealHero() and hHero:GetUnitName() and ABILITIES_SETTINGS[sRawAbilityName] and ABILITIES_SETTINGS[sRawAbilityName].ShardAbilities then
        for i,sAbilityName in ipairs(ABILITIES_SETTINGS[sRawAbilityName].ShardAbilities) do
            local hAbility = hHero:FindAbilityByName(sAbilityName)
            if hAbility then
                if HEROES_SETTINGS[hHero:GetUnitName()] == nil or (not table.contains(HEROES_SETTINGS[hHero:GetUnitName()].ShardAbilities,sAbilityName)) then
                    hHero:RemoveAbilityWithRestructure(sAbilityName)
                end
            end
        end
        if hHero.GetPlayerID and hHero:GetPlayerID() then
            Timers:CreateTimer(FrameTime(), function()
                HeroBuilder:RefreshAbilityOrder(hHero:GetPlayerID())
            end)
        end
    end
end

--===========================================
-- Аганимные и шардовые способности 
--===========================================
function HeroBuilder:AddScepterLinkAbilities(hHero)
    if hHero and hHero:IsRealHero() and hHero:GetUnitName() and hHero:HasScepter() then
        for AbilityName, AbilityInfo in pairs(ABILITIES_SETTINGS) do
            local hLoopAbility = hHero:FindAbilityByName(AbilityName)
            if hLoopAbility and not hLoopAbility:IsNull() and hLoopAbility.sRemovalTimer==nil and AbilityInfo.ScepterAbilities then
                for i,sAbilityName in ipairs(AbilityInfo.ScepterAbilities) do
                    local hAbility = hHero:FindAbilityByName(sAbilityName)
                    if not (hAbility and hAbility.sRemovalTimer==nil) then
                        if hLoopAbility.rubick_spell == nil then
                            local hScepterAbility= hHero:AddAbility(sAbilityName)
                            if hScepterAbility and (not hScepterAbility:IsNull()) then
                                hScepterAbility:SetLevel(1)
                                hScepterAbility.bScepterAbility = true

                                local AbilitySettings = ABILITIES_SETTINGS[sAbilityName]
                                if AbilitySettings and AbilitySettings.BonusModifiers then
                                    for _, BonusModifierName in pairs(AbilitySettings.BonusModifiers) do
                                        hHero:AddNewModifier(hHero, hScepterAbility, BonusModifierName, {})
                                    end
                                end
                                if i == 1 then
                                    Timers:CreateTimer(0.1, function()
                                        if not hScepterAbility or hScepterAbility:IsNull() then return end
                                        hScepterAbility:SetHidden(false)
                                        hScepterAbility:UpdateAbilitySlot()
                                    end)
                                end
                            end
                        end
                    end
                end
            end
        end
        if hHero.GetPlayerID and hHero:GetPlayerID() then
            Timers:CreateTimer(FrameTime(), function()
                HeroBuilder:RefreshAbilityOrder(hHero:GetPlayerID())
            end)
        end
    end
end

function HeroBuilder:AddShardLinkAbilities(hHero)
    if hHero and hHero:IsRealHero() and hHero:GetUnitName() and hHero:HasShard() then
        for AbilityName, AbilityInfo in pairs(ABILITIES_SETTINGS) do
            local hLoopAbility = hHero:FindAbilityByName(AbilityName)
            if hLoopAbility and not hLoopAbility:IsNull() and hLoopAbility.sRemovalTimer==nil and AbilityInfo.ShardAbilities then
                for i,sAbilityName in ipairs(AbilityInfo.ShardAbilities) do
                    local hAbility = hHero:FindAbilityByName(sAbilityName)
                    if not (hAbility and hAbility.sRemovalTimer==nil) then
                        if hLoopAbility.rubick_spell == nil then
                            local hShardAbility= hHero:AddAbility(sAbilityName)
                            if hShardAbility and (not hShardAbility:IsNull()) then                        
                                
                                if sAbilityName ~= "shadow_demon_demonic_cleanse" then
                                    hShardAbility:SetLevel(1)
                                else
                                    local shadow_demon_demonic_purge = hHero:FindAbilityByName("shadow_demon_demonic_purge")
                                    if shadow_demon_demonic_purge then
                                        hShardAbility:SetLevel(shadow_demon_demonic_purge:GetLevel())
                                    end
                                end
                                local AbilitySettings = ABILITIES_SETTINGS[sAbilityName]
                                if AbilitySettings and AbilitySettings.BonusModifiers then
                                    for _, BonusModifierName in pairs(AbilitySettings.BonusModifiers) do
                                        hHero:AddNewModifier(hHero, hShardAbility, BonusModifierName, {})
                                    end
                                end
                             
                                if i == 1 then
                                    Timers:CreateTimer(0.1, function()
                                        if not hShardAbility or hShardAbility:IsNull() then return end
                                        hShardAbility:SetHidden(false)
                                        hShardAbility:UpdateAbilitySlot()
                                    end)
                                end
                            end
                        end
                    end
                end
            end
        end
        if hHero.GetPlayerID and hHero:GetPlayerID() then
            Timers:CreateTimer(FrameTime(), function()
                HeroBuilder:RefreshAbilityOrder(hHero:GetPlayerID())
            end)
        end
    end
end

function HeroBuilder:ReorderComplete(keys)
    if not keys.PlayerID then
        return
    end
    local nPlayerID=keys.PlayerID
    local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
    local sSwap_1=keys.moved_ability
    local sSwap_2=keys.ref_ability
    if hHero then
        local hAbility1 = hHero:FindAbilityByName(sSwap_1)
        local hAbility2 = hHero:FindAbilityByName(sSwap_2)

        if hAbility1 and hAbility2 and not hAbility1:IsHidden() and not hAbility2:IsHidden() then
            hHero:SwapAbilities(sSwap_1, sSwap_2, true, true)
        end
    end
    HeroBuilder:RefreshAbilityOrder(nPlayerID)
end

function HeroBuilder:AddLinkedAbilities(hHero, sAbilityName, nLevel)
    local AbilityInfo = KeyValues:GetAbility(sAbilityName)
    if AbilityInfo and AbilityInfo.LinkedAbilities then
        for LinkedAbilityName,LinkedAbilityLevel in pairs(AbilityInfo.LinkedAbilities) do
            if not hHero:HasAbility(LinkedAbilityName) then
                local abilitiesBefore = HeroBuilder:GetAllAbilities(hHero)
                local hNewLinkedAbility = hHero:AddAbility(LinkedAbilityName)
                HeroBuilder:CleanupAfterAddAbility(hHero, abilitiesBefore, LinkedAbilityName)
                if LinkedAbilityName=="lone_druid_true_form_druid" or  LinkedAbilityName=="lone_druid_true_form_battle_cry" then
                    hNewLinkedAbility:SetHidden(false)
                end
                if LinkedAbilityLevel>0 then
                    hNewLinkedAbility:SetLevel(LinkedAbilityLevel)
                end
                if nLevel and nLevel>0 then
                    hNewLinkedAbility:SetLevel(nLevel)
                end
                if hNewLinkedAbility and not hNewLinkedAbility:IsNull() then
                    hNewLinkedAbility:MarkAbilityButtonDirty()
                end
                local AbilitySettings = ABILITIES_SETTINGS[LinkedAbilityName]
                if AbilitySettings and AbilitySettings.BonusModifiers then
                    for _, BonusModifierName in pairs(AbilitySettings.BonusModifiers) do
                        hHero:AddNewModifier(hHero, hNewLinkedAbility, BonusModifierName, {})
                    end
                end
                Timers:CreateTimer(0.1, function()
                    if hNewLinkedAbility and not hNewLinkedAbility:IsNull() and not hNewLinkedAbility:IsHidden() then 
                        hNewLinkedAbility:UpdateAbilitySlot()
                    end
                end)
            end
        end
    end
end

function HeroBuilder:GenerateAbilitiesListForRandom(PlayerID, delete_ability, bAddDeletedAbilityToPull, bMoreSSSSpells, bIsMainSSS)
    if not self.Players[PlayerID] then return {} end

    local Hero = self.Players[PlayerID].selected_hero_ent

    if not Hero then return {} end

    local HeroInfo = KeyValues:GetHero(Hero:GetUnitName())

    local AllRelevantAbilities = {}
    local SSSSpells = {}
    local HeroAbilities = HeroInfo.abilities ~= nil and table.deepcopy(HeroInfo.abilities) or {}

    local AllAbilities = KeyValues:GetAllAbilities()

    if bMoreSSSSpells then
        local FreeSSSAbilities = Bans:GetAllRandomBansGroupUnbanned("ABILITIES", "SSS")
        for _, AbilityName in pairs(FreeSSSAbilities) do
            if not KeyValues:IsBannedAbility(AbilityName) and delete_ability ~= AbilityName and not table.contains(self.Players[PlayerID].abilities_list, AbilityName) and not Hero:HasAbility(AbilityName) then
                table.insert(SSSSpells, AbilityName)
            end
        end
    end

    for AbilityName, AbilityInfo in pairs(AllAbilities) do
        if not KeyValues:IsBannedAbility(AbilityName) and delete_ability ~= AbilityName and not table.contains(self.Players[PlayerID].abilities_list, AbilityName) and not Hero:HasAbility(AbilityName) then
            table.insert(AllRelevantAbilities, AbilityName)
        else
            table.remove_item(HeroAbilities, AbilityName)
        end
    end

    -- Проверяем, какая способность украдена через Spell Steal (у любого героя)
    local rubick_skill = Hero:FindAbilityByName("rubick_spell_steal_custom")
    local rubick_stolen_ability = nil
    if rubick_skill and rubick_skill.currentSpell ~= nil and not rubick_skill.currentSpell:IsNull() then
        rubick_stolen_ability = rubick_skill.currentSpell:GetName()
        print("[HeroBuilder] Stolen ability detected: " .. rubick_stolen_ability)
    end

    print("[HeroBuilder] Checking abilities_list for PlayerID " .. PlayerID)
    for _, AbilityName in pairs(self.Players[PlayerID].abilities_list) do
        print("[HeroBuilder] - Ability in list: " .. AbilityName)
        -- Проверяем, есть ли способность у героя физически
        local hasAbility = Hero:FindAbilityByName(AbilityName) ~= nil
        if not hasAbility then
            print("[HeroBuilder] - WARNING: " .. AbilityName .. " in list but not on hero!")
        end
        -- Пропускаем украденную способность и способности, которых нет у героя
        if AbilityName ~= rubick_stolen_ability and hasAbility then
            local AbilitySettings = ABILITIES_SETTINGS[AbilityName]
            if AbilitySettings then
                if AbilitySettings.bIsBlackKingBarAbility then
                    print("[HeroBuilder] - " .. AbilityName .. " is BKB ability, blocking others")
                end
                if AbilitySettings.Exceptions then
                    for i, ExceptionName in pairs(AbilitySettings.Exceptions) do
                        table.remove_item(AllRelevantAbilities, ExceptionName)
                        table.remove_item(HeroAbilities, ExceptionName)
                        table.remove_item(SSSSpells, ExceptionName)
                    end
                end
                if AbilitySettings.bIsPercentAbility == true then
                    for SettingsName, SettingsInfo  in pairs(ABILITIES_SETTINGS) do
                        if SettingsInfo.bIsPercentAbility == true then
                            table.remove_item(AllRelevantAbilities, SettingsName)
                            table.remove_item(HeroAbilities, SettingsName)
                            table.remove_item(SSSSpells, SettingsName)
                        end
                    end
                end
                if AbilitySettings.bIsBlackKingBarAbility == true then
                    for SettingsName, SettingsInfo  in pairs(ABILITIES_SETTINGS) do
                        if SettingsInfo.bIsBlackKingBarAbility == true then
                            table.remove_item(AllRelevantAbilities, SettingsName)
                            table.remove_item(HeroAbilities, SettingsName)
                            table.remove_item(SSSSpells, SettingsName)
                        end
                    end
                end
            end
        end
    end

    if rubick_skill and rubick_skill.currentSpell ~= nil then
        table.remove_item(AllRelevantAbilities, rubick_skill.currentSpell:GetName())
        table.remove_item(HeroAbilities, rubick_skill.currentSpell:GetName())
        table.remove_item(SSSSpells, rubick_skill.currentSpell:GetName())
    end

    local HeroSettings = HEROES_SETTINGS[Hero:GetUnitName()]
    if HeroSettings and HeroSettings.Exceptions then
        for i, ExceptionName in pairs(HeroSettings.Exceptions) do
            table.remove_item(AllRelevantAbilities, ExceptionName)
            table.remove_item(HeroAbilities, ExceptionName)
            table.remove_item(SSSSpells, ExceptionName)
        end
    end

    for AbilityName, Count in pairs(self.AbilitiesCounter) do
        if Count <= 0 then
            table.remove_item(AllRelevantAbilities, AbilityName)
            table.remove_item(HeroAbilities, AbilityName)
            table.remove_item(SSSSpells, AbilityName)
        end
    end

    local ResultCountAbilities = 8
    local RandomAbilities = {}
    local sss_count = 0  -- сколько SSS-способностей реально вставлено в начало списка (для UI-группировки)

    if #SSSSpells > 0 then
        local Count = SSS_RELEARN_BOOK_COUNT
        if bIsMainSSS then
            Count = GetGameSetting("SSS_FIRST_ABILITY_COUNT")
        end
        if Count > 0 then
            local rSpells = table.random_some(SSSSpells, Count)
            sss_count = #rSpells

            for _, SpellName in ipairs(rSpells) do
                table.remove_item(AllRelevantAbilities, SpellName)
                table.remove_item(HeroAbilities, SpellName)
            end

            ResultCountAbilities = ResultCountAbilities - #rSpells

            RandomAbilities = table.join(RandomAbilities, rSpells)
        end
    end

    if delete_ability ~= nil and bAddDeletedAbilityToPull and ResultCountAbilities > 0 then
        if not table.contains(self.Players[PlayerID].abilities_list, delete_ability) then
            table.remove_item(AllRelevantAbilities, delete_ability)
            table.remove_item(HeroAbilities, delete_ability)

            ResultCountAbilities = ResultCountAbilities - 1

            table.insert(RandomAbilities, delete_ability)
        end
    end

    if RollPercentage(90) and #HeroAbilities > 0 and ResultCountAbilities > 0 then
        local HeroAbility = table.random(HeroAbilities)

        table.remove_item(AllRelevantAbilities, HeroAbility)
        table.remove_item(HeroAbilities, HeroAbility)
        ResultCountAbilities = ResultCountAbilities - 1

        table.insert(RandomAbilities, HeroAbility)
    end

    local OtherAbilities = table.random_some(AllRelevantAbilities, ResultCountAbilities)

    RandomAbilities = table.join(RandomAbilities, OtherAbilities)

    return RandomAbilities, sss_count
end

function HeroBuilder:GenerateIdealAbilitiesForAllPlayers(bUseOnlySSS)
    local Abilities = {}

    local Pool = bUseOnlySSS and Bans:GetAllRandomBansGroupUnbanned("ABILITIES", "SSS") or table.make_key_table(KeyValues:GetAllAbilities())

    Pool = ArrayRemove(Pool, function(t, i, j)
        return not KeyValues:IsBannedAbility(t[i])
    end)

    for AbilityName, Count in pairs(self.AbilitiesCounter) do
        table.remove_item(Pool, AbilityName)
    end

    for PlayerID, PlayerInfo in pairs(self:GetAllPlayers()) do
        local Hero = PlayerInfo.selected_hero_ent
        if Hero then
            Pool = ArrayRemove(Pool, function(t, i, j)
                return not table.contains(PlayerInfo.abilities_list, t[i]) and not Hero:HasAbility(AbilityName)
            end)

            -- Проверяем, какая способность украдена через Spell Steal (у любого героя)
            local rubick_skill = Hero:FindAbilityByName("rubick_spell_steal_custom")
            local rubick_stolen_ability = nil
            if rubick_skill and rubick_skill.currentSpell ~= nil and not rubick_skill.currentSpell:IsNull() then
                rubick_stolen_ability = rubick_skill.currentSpell:GetName()
                print("[HeroBuilder] Stolen ability detected (Ideal): " .. rubick_stolen_ability)
            end

            for _, AbilityName in pairs(PlayerInfo.abilities_list) do
                -- Проверяем, есть ли способность у героя физически
                local hasAbility = Hero:FindAbilityByName(AbilityName) ~= nil
                -- Пропускаем украденную способность и способности, которых нет у героя
                if AbilityName ~= rubick_stolen_ability and hasAbility then
                    local AbilitySettings = ABILITIES_SETTINGS[AbilityName]
                    if AbilitySettings then
                        if AbilitySettings.Exceptions then
                            for i, ExceptionName in pairs(AbilitySettings.Exceptions) do
                                table.remove_item(Pool, ExceptionName)
                            end
                        end
                        if AbilitySettings.bIsPercentAbility == true then
                            for SettingsName, SettingsInfo  in pairs(ABILITIES_SETTINGS) do
                                if SettingsInfo.bIsPercentAbility == true then
                                    table.remove_item(Pool, SettingsName)
                                end
                            end
                        end
                        if AbilitySettings.bIsBlackKingBarAbility == true then
                            for SettingsName, SettingsInfo  in pairs(ABILITIES_SETTINGS) do
                                if SettingsInfo.bIsBlackKingBarAbility == true then
                                    table.remove_item(Pool, SettingsName)
                                end
                            end
                        end
                    end
                end
            end

            if rubick_skill and rubick_skill.currentSpell ~= nil then
                table.remove_item(Pool, rubick_skill.currentSpell:GetName())
            end

            local HeroSettings = HEROES_SETTINGS[Hero:GetUnitName()]
            if HeroSettings and HeroSettings.Exceptions then
                for i, ExceptionName in pairs(HeroSettings.Exceptions) do
                    table.remove_item(Pool, ExceptionName)
                end
            end
        end
    end

    Abilities = table.random_some(Pool, 8)

    return Abilities
end

function HeroBuilder:RemoveAbility(PlayerID, AbilityName)
    if not self.Players[PlayerID] then return end

    local Hero = self.Players[PlayerID].selected_hero_ent
    if Hero == nil then return end

    local hAbility = Hero:FindAbilityByName(AbilityName)
    if hAbility == nil then return end
    
    -- Если удаляется Spell Steal, очищаем abilities_list от способностей, которых нет у героя
    if AbilityName == "rubick_spell_steal_custom" then
        print("[HeroBuilder] Removing Spell Steal, cleaning up stolen abilities from list")
        local abilitiesToRemove = {}
        for _, checkAbilityName in pairs(self.Players[PlayerID].abilities_list) do
            if not Hero:FindAbilityByName(checkAbilityName) then
                print("[HeroBuilder] - Removing " .. checkAbilityName .. " from abilities_list (not on hero)")
                table.insert(abilitiesToRemove, checkAbilityName)
            end
        end
        for _, abilityToRemove in pairs(abilitiesToRemove) do
            table.remove_item(self.Players[PlayerID].abilities_list, abilityToRemove)
            self.Players[PlayerID].abilities_list_server[abilityToRemove] = nil
        end
    end
    if self.AbilitiesCounter[AbilityName] then
        self.AbilitiesCounter[AbilityName] = self.AbilitiesCounter[AbilityName] + 1
    end
    local AbilityInfo = KeyValues.AbilitiesList[AbilityName]
    if AbilityInfo and AbilityInfo.LinkedAbilities then
        for sLinkedAbilityName, Level in pairs(AbilityInfo.LinkedAbilities) do
            local hLinkedAbility = Hero:FindAbilityByName(sLinkedAbilityName)
            local bStillUsing = false
            for _,sOtherAbility in ipairs(self.Players[PlayerID].abilities_list) do
                if (sOtherAbility~=AbilityName) and KeyValues.AbilitiesList[sOtherAbility] and KeyValues.AbilitiesList[sOtherAbility].LinkedAbilities and KeyValues.AbilitiesList[sOtherAbility].LinkedAbilities[sLinkedAbilityName] then
                    bStillUsing = true
                end
            end
            if hLinkedAbility and (not bStillUsing) then
                if hLinkedAbility:IsHidden() then
                    Hero:RemoveAbilityForEmpty(sLinkedAbilityName)
                else
                    Hero:RemoveAbilityWithRestructure(sLinkedAbilityName)
                end
            end
        end
    end
    if hAbility and hAbility:GetIntrinsicModifierName() ~= nil then
        local modifier_intrinsic = Hero:FindModifierByName(hAbility:GetIntrinsicModifierName())
        if modifier_intrinsic then
            Hero:RemoveModifierByName(modifier_intrinsic:GetName())
        end
    end
    -- Сброс накопленных стаков Лагуны (bonus-урон за килы) при РЕАЛЬНОМ удалении
    -- способности через relearn: иначе сохранённое на герое значение восстановит их
    -- при повторном взятии. При отражении (Lotus/Mirror/Counterspell) способность
    -- не удаляется, поэтому сюда не попадаем и стаки сохраняются.
    if AbilityName == "lina_laguna_blade_custom" then
        Hero.laguna_kill_stacks = nil
    end
    Hero:RemoveAbilityForEmpty(AbilityName)
    Util:RemoveAbilityClean(Hero, AbilityName)
    self:RemoveScepterLinkAbilities(Hero, AbilityName)
    self:RemoveShardLinkAbilities(Hero, AbilityName)

    for _, modif in ipairs(Hero:FindAllModifiers()) do
        if modif.OnAbilityDeleted then
            modif:OnAbilityDeleted(AbilityName)
        end
    end
end

function HeroBuilder:RunAbilitySoundPrecache()
    for HeroName, Precached in pairs(self.Precache) do
        if not Precached then
            self.Precache[HeroName] = true
            PrecacheUnitByNameAsync("npc_precache_"..HeroName, function(precacheId)
                print(precacheId, "Precache "..HeroName)
                
                self.SpawnGroupsByHeroNames[HeroName] = precacheId
            end)
        end
    end
end

function HeroBuilder:GetSpawnGroup(HeroName)
    return self.SpawnGroupsByHeroNames[HeroName]
end

function HeroBuilder:UnPrecacheHero(HeroName)
    self.Precache[HeroName] = nil
end

if not HeroBuilder.bStarted then HeroBuilder:Init() end