--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if GameMode == nil then
	_G.GameMode = class({}) 
end

RequireFiles({
    "utils/error_tracking",
    "utils/utils",
    "utils/playertables",
    "utils/debugger",
    "utils/barrage",
    "utils/bit",
    "utils/timers",
    "utils/table",
    "utils/functions",
    "utils/damage_filter_util",
    "utils/key_values",
    "utils/util",
    "utils/cdota_base_npc",
    "utils/cdota_base_ability",
    "utils/cdota_modifier_lua",
    "utils/event_driver",

    "libs/filters",
    "libs/item",
    "libs/illusion",

    "web/zxc_requests",
    "web/zxc_server",
    "web/admins",
    "web/store_system",
    
    "hero_demo/demo_core",

    "modules/map",

    "modules/notifications",
    
    "modules/bans",
    "modules/states",
    "modules/votes",
    "modules/creeps",
    "modules/round_controller",
    "modules/rounds",
    "modules/players",
    "modules/hero_builder",
    "modules/neutrals",
    "modules/chat_wheel",
    "modules/items"
})

Precache = require('utils/precache')

function Activate()
    GameMode:InitGameMode()
    SendToServerConsole("tv_delay 0")
end

function GameMode:InitGameMode()
    local EndGameDuration = 9999999--120
    -- Настройки
    math.randomseed( math.floor( GetSystemTimeMS() ) )
    GameRules:SetSameHeroSelectionEnabled(true)
    GameRules:SetHeroSelectionTime(5)
    GameRules:SetStrategyTime(15)
    GameRules:SetShowcaseTime(0)
    GameRules:SetSafeToLeave(true)
    GameRules:SetCustomGameSetupRemainingTime(-1)
    GameRules:SetCustomGameSetupTimeout(-1)
    GameRules:EnableCustomGameSetupAutoLaunch(false)
    GameRules:SetCustomGameSetupAutoLaunchDelay(-1)
    GameRules:GetGameModeEntity():SetUseCustomHeroLevels(true)
    GameRules:GetGameModeEntity():SetCustomHeroMaxLevel(999)
    GameRules:SetHeroRespawnEnabled( false )
    GameRules:GetGameModeEntity():SetFixedRespawnTime(99990000)
    GameRules:SetUseUniversalShopMode( true )
    GameRules:GetGameModeEntity():SetFogOfWarDisabled(true) 
    GameRules:GetGameModeEntity():SetLoseGoldOnDeath(false) 
    GameRules:GetGameModeEntity():SetDaynightCycleDisabled(true) 
    GameRules:GetGameModeEntity():SetTPScrollSlotItemOverride("item_smoke_of_deceit_custom")
    GameRules:GetGameModeEntity():SetNeutralStashEnabled(true)
    GameRules:GetGameModeEntity():SetDefaultStickyItem( "item_smoke_of_deceit_custom" )
    -- GameRules:GetGameModeEntity():SetFreeCourierModeEnabled( true )
    GameRules:SetCustomGameEndDelay( EndGameDuration )
    GameRules:SetCustomVictoryMessageDuration(EndGameDuration)
    GameRules:SetPostGameTime(EndGameDuration)
    

    GameRules:SetFilterMoreGold(true)
    
    LimitPathingSearchDepth(0.1)
    GameRules:GetGameModeEntity():SetBuybackEnabled(false)
    GameRules:GetGameModeEntity():SetPauseEnabled(false)
    GameRules:GetGameModeEntity():SetGiveFreeTPOnDeath(false)
    SendToServerConsole("dota_max_physical_items_purchase_limit 9999")
    Convars:SetInt("sv_allchat", 1)
    Convars:SetInt("sv_alltalk", 1)
    GameRules:SetTreeRegrowTime(60)

    if IsInToolsMode() then
        GameRules:SetPreGameTime(12)
        GameRules:SetStartingGold(600)
    else
        -- [MF-21] Пауза между концом пиков и стартом 1-й волны: 65 -> 10 сек (2026-07-17).
        -- Это PRE_GAME: в нём мод грузит арены/рошанов/пингвинов (map.lua:238), вешает FOW и
        -- шлёт избранные баны на сервер (addon_game_mode.lua:411), а игроки закупаются на
        -- стартовые 600 золота. Первая волна стартует уже в GAME_IN_PROGRESS
        -- (rounds.lua:121 → PrepareRound(1)), т.е. этот таймер её только задерживает.
        GameRules:SetPreGameTime(10)
        GameRules:SetStartingGold(600)
    end

    local xpTable = {230,600,1080,1660,2260,2980,3730,4510,5320,6160,7030,7930,9155,10405,11680,12980,14305,15805,17395,18995,20845,22945,25295,27895}
    xpTable[0] = 0
    for i = 25, 1000 do
        xpTable[i] = xpTable[i-1]+(i-24)*1000+2500
    end
    GameRules.xpTable = xpTable
    GameRules:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel(xpTable)

    self.vTeamColors = 
    {
        [DOTA_TEAM_GOODGUYS] = { 61, 210, 150 },
        [DOTA_TEAM_BADGUYS]  = { 243, 201, 9 },
        [DOTA_TEAM_CUSTOM_1] = { 197, 77, 168 },
        [DOTA_TEAM_CUSTOM_2] = { 255, 108, 0 },
        [DOTA_TEAM_CUSTOM_3] = { 52, 85, 255 },
        [DOTA_TEAM_CUSTOM_4] = { 101, 212, 19 },
        [DOTA_TEAM_CUSTOM_5] = { 129, 83, 54 },
        [DOTA_TEAM_CUSTOM_6] = { 27, 192, 216 },
        [DOTA_TEAM_CUSTOM_7] = { 199, 228, 13 },
        [DOTA_TEAM_CUSTOM_8] = { 140, 42, 244 },
    }
    for nTeamNumber = 0, (DOTA_TEAM_COUNT-1) do
        local color = self.vTeamColors[ nTeamNumber ]
        if color then
            SetTeamCustomHealthbarColor( nTeamNumber, color[1], color[2], color[3] )
        end
    end

    -- Фильтры
    GameRules:GetGameModeEntity():SetDamageFilter(Dynamic_Wrap(GameMode, "DamageFilter"), self)
    GameRules:GetGameModeEntity():SetExecuteOrderFilter(Dynamic_Wrap(GameMode, "OrderFilter"), self)
    GameRules:GetGameModeEntity():SetModifierGainedFilter(Dynamic_Wrap(GameMode, "ModifierGainedFilter"), self)
    GameRules:GetGameModeEntity():SetModifyGoldFilter(Dynamic_Wrap(GameMode, "ModifyGoldFilter"), self)
    GameRules:GetGameModeEntity():SetModifyExperienceFilter(Dynamic_Wrap(GameMode, "ModifyExperienceFilter"), self)
    GameRules:GetGameModeEntity():SetItemAddedToInventoryFilter(Dynamic_Wrap(item_filter_check, "ItemAddedToInventoryFilter"), item_filter_check)
    GameRules:GetGameModeEntity():SetHealingFilter( Dynamic_Wrap(GameMode, "HealingFilter"), self )
    GameRules:GetGameModeEntity():SetBountyRunePickupFilter( Dynamic_Wrap( GameMode, "BountyRunePickupFilter" ), self )
    -- GameRules:GetGameModeEntity():SetAbilityTuningValueFilter( Dynamic_Wrap( GameMode, "AbilityTuningValueFilter" ), self )
    
    -- Ивенты
    ListenToGameEvent("game_rules_state_change", Dynamic_Wrap( GameMode, 'OnGameRulesStateChange' ), self )
    ListenToGameEvent("dota_item_purchased", Dynamic_Wrap(GameMode, "OnItemPurchased"), self)
    ListenToGameEvent("dota_player_gained_level", Dynamic_Wrap(GameMode, "OnHeroLevelUp"), self)
    ListenToGameEvent("dota_player_used_ability", Dynamic_Wrap(GameMode, "OnPlayerUsedAbility"), self)
    ListenToGameEvent("dota_item_picked_up", Dynamic_Wrap( GameMode, "OnItemPickUp"), self )
    ListenToGameEvent("dota_player_learned_ability", Dynamic_Wrap( GameMode, "OnLearnedAbility"), self )

    ListenToGameEvent("dota_item_combined", Dynamic_Wrap( item_filter_check, "OnItemCombined"), item_filter_check )

    -- Слушатели Panorama
    CustomGameEventManager:RegisterListener("HeroIconClicked", Dynamic_Wrap(GameMode, 'HeroIconClicked'))
    -- MF-18: ПКМ в таблице счёта → открыть панель игрока (ActorPanel) у кликнувшего.
    CustomGameEventManager:RegisterListener("actor_panel_open", Dynamic_Wrap(GameMode, 'OnActorPanelOpen'))
    CustomGameEventManager:RegisterListener("StartHighFive", Dynamic_Wrap(store_system, 'StartHighFive'))

    -- [DEBUG] Мост панорама->сервер для отладочного вывода. Панорама шлёт {tag, line},
    -- сервер печатает в консоль с префиксом [DEBUG-<tag>] (для фильтра в консоли).
    CustomGameEventManager:RegisterListener("zxc_debug_print", function(_, event)
        print("[DEBUG-"..tostring(event.tag).."] "..tostring(event.line))
    end)

    -- [SEC-EVT] ВРЕМЕННЫЙ probe (см. panorama/scripts/custom_game/sec_probe.js).
    -- Клиент шлёт заведомо чужой PlayerID=999 и свой реальный в поле real.
    -- claimed=999 -> клиентское поле переживает, импersonation возможен (аудит M2/M3).
    -- claimed=<real> -> движок перезаписывает PlayerID, дыры нет.
    -- Удалить вместе с sec_probe.js после того, как факт зафиксирован в vault.
    CustomGameEventManager:RegisterListener("zxc_sec_probe", function(source, event)
        -- Печатаем в обход DEBUG_PRINT_STATUS (probe и так шлётся только в тулзах).
        _ENGINE_PRINT_RAW(string.format("[SEC-EVT] PROBE claimed=%s real_from_client=%s src=%s",
            tostring(event.PlayerID), tostring(event.real), tostring(source)))
    end)

    -- Данные
    self.partyListMap= {}
    self.nPartyNumber= 0
    self.partyNumberMap= {}
    
    store_system:Init()
    Debugger:Init()
    Barrage:Init()
    HeroBuilder:UpdateSkillsNetTableInfo()


    GameRules:GetGameModeEntity():SetThink("GlobalThinker", self, "GAME_GLOBAL_THINKER", 0)
    GameRules:GetGameModeEntity():SetThink("FixUnitsPositions", Map, "GAME_UNITS_POSITION_FIX", 0)
    GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("collectgarbage"), function()
		collectgarbage("collect");
		return 300
	end, 300)
end

function GameMode:GlobalThinker()
    HeroBuilder:FixAttackCapability()
    HeroBuilder:ProcessScepterOwners()
    HeroBuilder:RunAbilitySoundPrecache()
    return 1
end

function GameMode:OnLearnedAbility(event)
    local AbilityName = event.abilityname
	local PlayerID = event.PlayerID
	local PlayerHero = PlayerResource:GetSelectedHeroEntity(PlayerID)
    if not PlayerHero then return end

    local ThinkerEnt = GameRules:GetGameModeEntity()

    local function WaitHeroAlive(PlayerID, callback)
        ThinkerEnt:SetContextThink(DoUniqueString("OnLearned_WaitHeroAlive_" .. tostring(PlayerID)), function()
            local hero = PlayerResource:GetSelectedHeroEntity(PlayerID)
            if not hero or hero:IsNull() then return nil end
            if not hero:IsAlive() then return 0.1 end

            callback(hero)
            return nil
        end, 0.00)
    end

    local WaitAbilityActions = {
        special_bonus_custom_debuff_amp_15                   = function(hero)
			local ability = hero:FindAbilityByName("special_bonus_custom_debuff_amp_15")
            if ability then
                hero:AddNewModifier(hero, ability, "modifier_special_bonus_custom_debuff_amp_15", {})
            end
		end,

        -- Лич: вариант на 10%. Модификатор тот же — он читает value из переданной абилки.
        special_bonus_custom_debuff_amp_10                   = function(hero)
			local ability = hero:FindAbilityByName("special_bonus_custom_debuff_amp_10")
            if ability then
                hero:AddNewModifier(hero, ability, "modifier_special_bonus_custom_debuff_amp_15", {})
            end
		end,

        special_bonus_custom_attack_range_150                   = function(hero)
			local ability = hero:FindAbilityByName("special_bonus_custom_attack_range_150")
            if ability then
                hero:AddNewModifier(hero, ability, "modifier_special_bonus_custom_attack_range_150", {})
            end
		end,

        special_bonus_unique_cha_obsidian_destroyer              = function(hero)
            local ability = hero:FindAbilityByName("special_bonus_unique_cha_obsidian_destroyer")
            if ability then
                hero:AddNewModifier(hero, ability, "modifier_special_bonus_cha_obsidian_destroyer", {})
            end
        end,

        special_bonus_unique_cha_ogre_magi                       = function(hero)
            local ability = hero:FindAbilityByName("special_bonus_unique_cha_ogre_magi")
            if ability then
                hero:AddNewModifier(hero, ability, "modifier_special_bonus_cha_ogre_magi", {})
            end
        end,

    }

    local AbilityActions = {
        special_bonus_unique_cha_night_stalker                   = function(hero) 
			local ability = hero:FindAbilityByName("night_stalker_void_custom")
            if ability then
                ability:RefreshCharges()
                ability:SetCurrentAbilityCharges(1)
            end
		end,
        special_bonus_unique_winter_wyvern_4                   = function(hero) 
			local ability = hero:FindAbilityByName("winter_wyvern_winters_curse")
            if ability then
                ability:RefreshCharges()
                ability:SetCurrentAbilityCharges(1)
            end
		end,
        special_bonus_unique_disruptor_9                   = function(hero) 
			local ability = hero:FindAbilityByName("disruptor_thunder_strike")
            if ability then
                ability:RefreshCharges()
                ability:SetCurrentAbilityCharges(1)
            end
		end,
        special_bonus_unique_magnus_7                   = function(hero)
			local ability = hero:FindAbilityByName("magnataur_shockwave")
            if ability then
                ability:RefreshCharges()
                ability:SetCurrentAbilityCharges(1)
            end
		end,

        -- [#21] Прыжки Зевса. Талант переводит способность с 0 зарядов на 3 — движок
        -- не инициализирует заряды сам (отсюда залипший КД 9999999999). Инициализируем
        -- штатно (как у остальных заряд-талантов). Логика по запросу: способность была
        -- готова → 3 заряда; была на КД → 2 готовых + 1 перезаряжается.
        special_bonus_unique_zeus_jump_charges                  = function(hero)
            local ability = hero:FindAbilityByName("zuus_heavenly_jump_custom")
            if ability then
                -- КД ДО реинициализации; залипший 9999999999 (>100) трактуем как «была готова».
                local cd = ability:GetCooldownTimeRemaining() or 0
                local bWasOnCooldown = cd > 0 and cd < 100

                ability:RefreshCharges()

                local maxCharges = ability:GetSpecialValueFor("AbilityCharges")
                if maxCharges <= 0 then maxCharges = 3 end
                if bWasOnCooldown then
                    ability:SetCurrentAbilityCharges(math.max(maxCharges - 1, 0))
                else
                    ability:SetCurrentAbilityCharges(maxCharges)
                end
            end
        end,

        -- [#22] Заряды Frost Shield. Талант lich_4 переводит способность с 0 зарядов на 2 —
        -- движок не инициализирует заряды сам (залипший КД 9999999999). Инициализируем штатно.
        special_bonus_unique_lich_4                             = function(hero)
            local ability = hero:FindAbilityByName("ability_lich_frost_shield")
            if ability then
                local cd = ability:GetCooldownTimeRemaining() or 0
                local bWasOnCooldown = cd > 0 and cd < 100

                ability:RefreshCharges()

                local maxCharges = ability:GetSpecialValueFor("AbilityCharges")
                if maxCharges <= 0 then maxCharges = 2 end
                if bWasOnCooldown then
                    ability:SetCurrentAbilityCharges(math.max(maxCharges - 1, 0))
                else
                    ability:SetCurrentAbilityCharges(maxCharges)
                end
            end
        end,
    }

    local ActionCallback = WaitAbilityActions[AbilityName]
    if ActionCallback then 
        WaitHeroAlive(PlayerID, ActionCallback)
        return 
    end

    local ActionCallback = AbilityActions[AbilityName]
    if ActionCallback then
        ActionCallback(PlayerHero)
    end
end

function GameMode:OnGameRulesStateChange()
    local nNewState = GameRules:State_Get() 
    HeroDemo:OnGameRulesStateChange()

    -- Загрузка
    if nNewState == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
        -- [ANTI-TAMPER] Локальный сервер (НЕ Valve-dedicated и НЕ tools-режим): не запускаем
        -- сетап вообще → кастомка навсегда висит на лоадинг-скрине (auto-launch выключен в
        -- InitGameMode, FinishCustomGameSetup тоже гейтнут в states.lua). Защита от поднятия
        -- своего сервера + тамперинга серверного Lua.
        if not IsInToolsMode() and not IsDedicatedServer() then
            print("[ANTI-TAMPER] local/listen server detected -> stuck on loading screen, setup not started")
            return
        end
        if ResetSpawnGroupTracking then ResetSpawnGroupTracking() end

        local MatchID = tostring(GameRules:Script_GetMatchID())
        
        CustomNetTables:SetTableValue("globals", "match_id", {id=MatchID})
        PlayerTables:CreateTable("notifications", {}, Players:GetAllPlayers(true))
        PlayerTables:CreateTable("chat_wheel", {list = CHAT_WHEEL_LIST}, Players:GetAllPlayers(true))
        PlayerTables:CreateTable("round_info", {}, Players:GetAllPlayers(true))
        PlayerTables:CreateTable("globals", {neutrals_rounds = GIVE_NEUTRALS_ROUNDS, bans_categories = SPEICAL_TIERS_TABLE}, Players:GetAllPlayers(true))

        KeyValues:LoadItemsList()
        KeyValues:LoadNeutrals()
        KeyValues:LoadHeroesList()
        KeyValues:LoadAbilities()
        KeyValues:LoadOtherAbilities()
        KeyValues:LoadModifiedAbilities()

        local NewTable = {}
        for key, value in pairs(ITEMS_LIST) do  
            NewTable[key] = value
        end  
        local ChatWheelList = {}
        for CHAT_ITEM_NAME, CHAT_ITEM_INFO in pairs(CHAT_WHEEL_LIST) do
            NewTable[CHAT_ITEM_NAME] = {
                slot_type = ITEMS_TYPES.CHAT_WHEEL,
                slot_name = "chat_wheel_item",
                preview_type = ITEMS_PREVIEW_TYPES.CHAT_WHEEL,
                preview_value = CHAT_ITEM_NAME,
                game_value = CHAT_ITEM_NAME,

                buyable = CHAT_ITEM_INFO.buyable,
                free = CHAT_ITEM_INFO.free,
                cost = CHAT_ITEM_INFO.cost,
                is_new = CHAT_ITEM_INFO.is_new
            }
        end
        PlayerTables:CreateTable("items", {list = NewTable}, Players:GetAllPlayers(true))
        
        Server:GetRatingSeasons()
        Admins:LoadFromServer()
        Timers:CreateTimer(3, function()
            States:StartSettingsState()
        end)

        -- Players:SubscribeAllSpectatorsToGameData()
    end

    -- Пре гейм гдет на выборе
    if nNewState == DOTA_GAMERULES_STATE_PRE_GAME then
        Server:UpdatePlayersPopularBans()
    end

    -- -- Старт игры
    if nNewState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        GameRules:SetTimeOfDay(0.5)

        -- Disconnect hero fix (поздний retry, последний шанс):
        -- если кому-то ещё не удалось создать hero -- пробуем ещё раз.
        for PlayerID, PlayerInfo in pairs(HeroBuilder:GetAllPlayers()) do
            local hasHero, source = HeroBuilder:HasHeroForPlayer(PlayerID)
            print(string.format(
                "[HeroBuilder/Disc] GAME_IN_PROGRESS check PID=%d: hasHero=%s (%s), selected_hero=%s, conn=%d",
                PlayerID, tostring(hasHero), tostring(source), tostring(PlayerInfo.selected_hero),
                PlayerResource:GetConnectionState(PlayerID) or -1))
            if not hasHero then
                HeroBuilder:ForceCreateHeroForDisconnectedPlayer(PlayerID)
            end
        end
    end

    -- -- Выбор героев
    if nNewState == DOTA_GAMERULES_STATE_HERO_SELECTION then
        if IsCheatsEnabled() then return end

        -- Disconnect hero fix: SetSelectedHero зовём ТОЛЬКО для CONNECTED.
        -- Для disconnected -- хера лысого: engine queue'ит async-спавн при живом CDOTAPlayer,
        -- и потом наш STRATEGY_TIME ForceCreate создаёт дубль (root cause из прошлой попытки).
        -- Disconnected обработает STRATEGY_TIME-ветка ниже через CreateHeroForPlayer напрямую.
        for PlayerID, PlayerInfo in pairs(HeroBuilder:GetAllPlayers()) do
            local Player = PlayerResource:GetPlayer(PlayerID)
            local connState = PlayerResource:GetConnectionState(PlayerID)
            local isConnected = (connState == DOTA_CONNECTION_STATE_CONNECTED)
            print(string.format(
                "[HeroBuilder/Disc] HERO_SELECTION PID=%d: selected_hero=%s, hasPlayer=%s, conn=%d, isConnected=%s",
                PlayerID, tostring(PlayerInfo.selected_hero),
                tostring(Player ~= nil), connState or -1, tostring(isConnected)))
            if PlayerInfo.selected_hero and PlayerInfo.selected_hero ~= "" and Player and isConnected then
                Player:SetSelectedHero(PlayerInfo.selected_hero)
                print(string.format(
                    "[HeroBuilder/Disc] HERO_SELECTION PID=%d: SetSelectedHero(%s) вызван",
                    PlayerID, PlayerInfo.selected_hero))
            else
                print(string.format(
                    "[HeroBuilder/Disc] HERO_SELECTION PID=%d: SetSelectedHero пропущен (disconnected или нет selected_hero)",
                    PlayerID))
            end
        end
    end

    -- Уж если игрок каким-то чудом не получил случайного героя - берём любого
    if nNewState == DOTA_GAMERULES_STATE_STRATEGY_TIME then
        for PlayerID, PlayerInfo in pairs(HeroBuilder:GetAllPlayers()) do
            local hPlayer = PlayerResource:GetPlayer(PlayerID)
            local heroName = PlayerResource:GetSelectedHeroName(PlayerID)
            local hasHero, source = HeroBuilder:HasHeroForPlayer(PlayerID)
            print(string.format(
                "[HeroBuilder/Disc] STRATEGY_TIME PID=%d: hasPlayer=%s, heroName=%s, hasHero=%s (%s), pi.selected_hero=%s, conn=%d",
                PlayerID, tostring(hPlayer ~= nil), tostring(heroName),
                tostring(hasHero), tostring(source), tostring(PlayerInfo.selected_hero),
                PlayerResource:GetConnectionState(PlayerID) or -1))

            if hPlayer then
                if heroName == nil or heroName == "" then
                    -- Обычная ветка: hero ещё не выбран (или movies cheats был включён)
                    HeroBuilder:OnPlayerWantRandomHero({PlayerID = PlayerID})

                    if PlayerInfo.selected_hero then
                        hPlayer:SetSelectedHero(PlayerInfo.selected_hero)
                        print(string.format(
                            "[HeroBuilder/Disc] STRATEGY_TIME PID=%d: late SetSelectedHero(%s)",
                            PlayerID, PlayerInfo.selected_hero))
                    end
                elseif PlayerInfo.selected_hero == "" or PlayerInfo.selected_hero == nil or PlayerInfo.selected_hero ~= heroName then
                    -- Для режима читов, чтобы понимать какой герой у игрока
                    PlayerInfo.selected_hero = heroName
                end
            else
                -- hPlayer nil -- значит игрок реально disconnected. Используем ForceCreate.
                if not hasHero and PlayerInfo.selected_hero and PlayerInfo.selected_hero ~= "" then
                    print(string.format(
                        "[HeroBuilder/Disc] STRATEGY_TIME PID=%d: hPlayer=nil, делаю ForceCreate(%s)",
                        PlayerID, PlayerInfo.selected_hero))
                    HeroBuilder:ForceCreateHeroForDisconnectedPlayer(PlayerID)
                end
            end
        end
    end
end

function GameMode:GetTeamColor(TeamID)
	return self.vTeamColors[TeamID]
end