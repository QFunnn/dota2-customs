--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--fl 浮点数
--n 整数
--s 字符串
--h 句柄,指针
--v 向量

pcall(require, "encrypt")
if GameMode == nil then
    _G.GameMode = class({})
end

-- _G.old_debug_traceback = old_debug_traceback or debug.traceback
-- if not IsInToolsMode() then
--     _G.tError = {}
--     debug.traceback = function(error, ...)
--         local a = old_debug_traceback(error, ...)
--         local sMsg = tostring(error)
--         -- print("[debug error]:", a)
--         if not tError[sMsg] then
--             tError[sMsg] = pcall(function()
--                 Service:UploadError(a)
--             end)
--         end
--         return a
--     end
-- end
--

require("utils/utility_functions")
require("utils/timers")
require("utils/bit")
require("utils/json")
require("utils/table")
require("utils/notifications")
require("utils/cdota_base_npc")
require("utils/cdota_base_ability")
require("utils/cdota_modifier_lua")
require("security")
require("hero_builder_modifiers")
require("hero_builder")
require("round")
require("spawner")
require("barrage")
require("pvp_module")
require("util")
require("econ")
require("madstone")
require("summon")
require("pass")
require("illusion")
require("extra_creature")
require("bot_ai")
require("filter/damage_filter")
require("filter/order_filter")
require("filter/modifier_filter")
require("filter/add_to_inventory_filter")
require("utils/sha")
-- require("utils/keyvalues")
-- require("halloween")
-- require("dota_mind")
require("setting")
require("utils/custom_chat")
require("utils/error_tracking")
require("utils/event_driver")
require("wearable")
require("libraries/activity_modifier")
require('service.index')
require("ItemsRecord")
require("kv")
require("modifiers")
require("utils")
require("Wearable_System.main") --新增的外观系统，用于替换身心
require('data_manager.main')

require('timer_manager')
require("game_pause_manager")

local m = collectgarbage('count')
print(string.format("[Lua Memory]  %.3f KB  %.3f MB", m, m / 1024))

--英雄池
GameRules.allHeroesKV = LoadKeyValues("scripts/npc/herolist.txt")
GameRules.heroesPoolList = {}

--全部加入英雄池，并且全部禁用
for k, _ in pairs(GameRules.allHeroesKV) do
    table.insert(GameRules.heroesPoolList, k)
    -- GameRules:AddHeroToBlacklist(k)
end

--为生成前台的安全码
Security:Init()

-- if IsInToolsMode() then
--	 local sc = LoadKeyValues("resource/addon_schinese.txt").Tokens
--	 local ru = LoadKeyValues("resource/addon_russian.txt").Tokens
--	 local en = LoadKeyValues("resource/addon_english.txt").Tokens
--	 for key, value in pairs(sc) do
-- 		local bRUFound = false
-- 		local bENFound = false
-- 		local v_en = ""
--		 for k, v in pairs(ru) do
-- 			if string.lower(key) == string.lower(k) then
-- 				bRUFound = true
-- 				break
-- 			end
-- 		end
-- 		for k, v in pairs(en) do
-- 			if string.lower(key) == string.lower(k) then
-- 				bENFound = true
-- 				v_en = v
-- 				break
-- 			end
-- 		end
-- 		if not bRUFound then
-- 			print(key, v_en, value)
-- 		end
--	 end
-- end

-- Precache = require "Precache"
require "precache"
require "precache_default"

function Precache(context)
    -- PrecacheResource("particle", "particles/units/heroes/hero_rubick/rubick_attack_blur_left_to_right_01.vpcf", context)
    -- PrecacheResource("particle", "particles/units/heroes/hero_rubick/rubick_attack_blur_right_to_left_01.vpcf", context)
    -- PrecacheResource("particle", "particles/units/heroes/hero_rubick/rubick_attack_blur_right_to_left_02.vpcf", context)
    -- PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_elder_titan.vsndevts", context)
    -- PrecacheResource("model", "models/heroes/lycan/summon_wolves.vmdl", context)
    for k, v in pairs(tPrecacheList) do
        for _, vv in ipairs(v) do
            PrecacheResource(k, vv, context)
        end
    end
    for k, v in pairs(tDefaultPrecacheList) do
        for _, vv in ipairs(v) do
            PrecacheResource(k, vv, context)
        end
    end
    _G.tPrecacheList = nil
    _G.tDefaultPrecacheList = nil
end

function Activate()
    Initialize(false)
    GameMode:InitGameMode()

    _G.MODIFIER_EVENTS_DUMMY = CreateModifierThinker((not IsDedicatedServer() and GameRules:GetGameModeEntity() or nil),
        nil, "modifier_events", nil, Vector(0, 0, 0), DOTA_TEAM_NOTEAM, false)
    _G.RECORD_SYSTEM_DUMMY = CreateModifierThinker((not IsDedicatedServer() and GameRules:GetGameModeEntity() or nil),
        nil, "modifier_record_system_dummy", nil, Vector(0, 0, 0), DOTA_TEAM_NOTEAM, false)
    _G.CLIENT_ABILITY = MODIFIER_EVENTS_DUMMY:AddAbility("client_ability")
    if IsValid(CLIENT_ABILITY) then
        CustomNetTables:SetTableValue("common", "client_ability", {
            _ = CLIENT_ABILITY:entindex()
        })
    end

    _G.ATTACK_SYSTEM_DUMMY = CreateModifierThinker(nil, nil, "modifier_dummy", nil, Vector(0, 0, 0), DOTA_TEAM_NOTEAM,
        false)
    -- _G.ATTACK_EVENTS_DUMMY = CreateModifierThinker(nil, nil, "modifier_events", nil, Vector(0, 0, 0), DOTA_TEAM_NOTEAM, false)
    _G.ABILITY_EVENTS_DUMMY = CreateModifierThinker(nil, nil, "modifier_wearable_material_effect", nil, Vector(0, 0, 0),
        DOTA_TEAM_NOTEAM, false)
end

function Require(requireList, bReload)
    for k, v in pairs(requireList) do
        local t = require(v)
        if t ~= nil and type(t) == "table" then
            _G[k] = t
            if t.init ~= nil then
                t:init(bReload)
            end
        end
    end
end

_G.Tester = {}

function Initialize(bReload)
    _G.CustomUIEventListenerIDs = {}
    _G.GameEventListenerIDs = {}
    _G.TimerEventListenerIDs = {}
    _G.Activated = true

    Require({
        -- Request = "libraries/request",
        -- HPack = "libraries/hpack",
        "class/weight_pool",
        -- "class/lz77",
        -- "class/behavior_tree",
        -- "class/spawner",
        -- "class/round",
    }, bReload)

    Require({
        -- Settings = "settings",
        -- Filters = "filters",
        -- Game = "game",
    }, bReload)

    Require({
        Mechanics = "mechanics/main",
    }, bReload)

    if Service then
        Service:init(bReload)
    end
end

require("game_mode_server")

function Reload()
    local state = GameRules:State_Get()
    if state > DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD then
        GameRules:Playtesting_UpdateAddOnKeyValues()
        FireGameEvent("client_reload_game_keyvalues", {})

        _ClearEventListenerIDs()
        Initialize(true)

        local tUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, Vector(0, 0, 0), nil, -1, DOTA_UNIT_TARGET_TEAM_BOTH,
            DOTA_UNIT_TARGET_ALL,
            DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE +
            DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, 0, false)
        for n, hUnit in pairs(tUnits) do
            if IsValid(hUnit) then
                for i = 0, hUnit:GetAbilityCount() - 1, 1 do
                    local hAbility = hUnit:GetAbilityByIndex(i)
                    if IsValid(hAbility) and hAbility:GetLevel() > 0 then
                        if hAbility:GetIntrinsicModifierName() ~= nil and hAbility:GetIntrinsicModifierName() ~= "" then
                            -- hUnit:RemoveModifierByName(hAbility:GetIntrinsicModifierName())
                            hAbility:RefreshIntrinsicModifier()
                        end
                    end
                end
                for i = DOTA_ITEM_SLOT_1, DOTA_STASH_SLOT_6, 1 do
                    local hItem = hUnit:GetItemInSlot(i)
                    if IsValid(hItem) then
                        if hItem:GetIntrinsicModifierName() ~= nil and hItem:GetIntrinsicModifierName() ~= "" then
                            -- hUnit:RemoveModifierByName(hItem:GetIntrinsicModifierName())
                            hItem:RefreshIntrinsicModifier()
                        end
                    end
                end
            end
        end

        print("Reload Scripts")
    end
end

if Activated == true then
    Reload()
end

function GameMode:GetMatchID()
    return self.MatchID
end

function GameMode:InitGameMode()
    --声明全局变量
    _G.Game_type = ""
    _G.PlayerLang = {}
    _G.MAX_ABILITY_INDEX = 19
    _G.DOTA_ITEM_NEUTRAL_SLOT = 16

    -- DEVRandomChoice()
    if IsInToolsMode() then
        self.MatchID = RandomInt(1, 999999999)
    else
        self.MatchID = GameRules:Script_GetMatchID()
    end
    --阶段时间
    _G.BAN_PHASE_TIME = IsInToolsMode() and 10 or 25
    _G.BAN_PHASE_TIME_REMAIN = BAN_PHASE_TIME
    _G.SELECT_PHASE_TIME = IsInToolsMode() and 10 or 30
    _G.SELECT_PHASE_TIME_REMAIN = SELECT_PHASE_TIME
    _G.STRATEGY_PHASE_TIME = IsInToolsMode() and 5 or 10
    _G.STRATEGY_PHASE_TIME_REMAIN = STRATEGY_PHASE_TIME

    _G.CHC_MAX_PLAYER_COUNT = 8
    if GetMapName() == "2x6" then
        _G.CHC_MAX_PLAYER_COUNT = 12
    elseif GetMapName() == "5v5" then
        _G.CHC_MAX_PLAYER_COUNT = 10
    end

    _G.CHC_HERO_LOAD_COUNT = CHC_MAX_PLAYER_COUNT * 7

    GameRules:GetGameModeEntity().GameMode = self
    GameRules:GetGameModeEntity().GameMode.sVersion = "07.01"
    GameRules:GetGameModeEntity().GameMode.sPasswordLobby = "false"

    TimerManager:Init()
    HeroBuilder:Init()
    Barrage:Init()
    PvpModule:Init()
    Econ:Init()
    -- ItemLoot:Init()
    MadStone:Init()
    GamePauseManager:Init()
    Summon:Init()
    Pass:Init()
    Illusion:Init()
    ExtraCreature:Init()
    BotAI:Init()
    -- Halloween:Init()
    -- DotaMind:Init()
    Setting:Init()
    Wearable_System:Init()
    DataManager:Init()

    --声明全局变量
    _G.Game_type = ""
    _G.PlayerLang = {}

    -- DEVRandomChoice()

    LimitPathingSearchDepth(0.1)

    GameRules:SetSameHeroSelectionEnabled(true)
    GameRules:SetHeroSelectionTime(BAN_PHASE_TIME + SELECT_PHASE_TIME + 1)
    GameRules:SetHeroSelectPenaltyTime(0)
    GameRules:SetShowcaseTime(0)
    GameRules:SetStrategyTime(STRATEGY_PHASE_TIME)
    GameRules:SetSafeToLeave(true)

    if IsInToolsMode() then
        GameRules:SetPreGameTime(10)
        GameRules:SetStartingGold(600)
    else
        GameRules:SetPreGameTime(20)
        GameRules:SetStartingGold(600)
    end
    GameRules:GetGameModeEntity():SetUseCustomHeroLevels(true)
    GameRules:GetGameModeEntity():SetCustomHeroMaxLevel(999)

    -- local chn = LoadKeyValues("scripts/npc/schinese.txt")["Tokens"]
    -- local eng = LoadKeyValues("scripts/npc/english.txt")["Tokens"]

    -- local count = 0
    -- for key, value in pairs(chn) do
    --	 if (eng[key] == nil) then
    --		 print(key)
    --		 count = count + 1
    --	 end
    -- end
    -- print("N2O", count)



    --有哪些队伍 所有玩家放弃了比赛 key teamID value Boolean
    GameRules.teamAbandonMap = {}

    --伤害统计表 key nPlayerID value 伤害值
    GameMode.damageCount = {}

    --标记演员的次数
    -- GameMode.reportActorTime = {}

    --feedback的次数
    GameMode.feedbackTime = {}

    --Key为ParytyID, Value为PartyNumber
    GameMode.partyListMap = {}

    -- 有多少个组队队伍参与游戏
    GameMode.nPartyNumber = 0

    --玩家组队情况的Map表，key nPlayerID value为PartyNumber（编号）
    GameMode.partyNumberMap = {}

    --

    --GameRules:GetGameModeEntity():SetCustomGameForceHero("npc_dota_hero_wisp")
    local xpTable = {}

    xpTable[0] = 0
    xpTable[1] = 230
    xpTable[2] = 600
    xpTable[3] = 1080
    xpTable[4] = 1660
    xpTable[5] = 2260
    xpTable[6] = 2980
    xpTable[7] = 3730
    xpTable[8] = 4510
    xpTable[9] = 5320
    xpTable[10] = 6160
    xpTable[11] = 7030
    xpTable[12] = 7930
    xpTable[13] = 9155
    xpTable[14] = 10405
    xpTable[15] = 11680
    xpTable[16] = 12980
    xpTable[17] = 14305
    xpTable[18] = 15805
    xpTable[19] = 17395
    xpTable[20] = 18995
    xpTable[21] = 20845
    xpTable[22] = 22945
    xpTable[23] = 25295
    xpTable[24] = 27895
    for i = 25, 1000 do
        xpTable[i] = xpTable[i - 1] + (i - 24) * 1000 + 2500
    end

    GameRules.xpTable = xpTable

    GameRules:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel(xpTable)

    -- GameMode:AssembleHeroesData()
    --根据出生点 设置队伍玩家数量
    GameMode:SetTeam()

    --读取Round KV
    GameMode:ReadRoundConfigurations()

    --禁止复活
    GameRules:SetHeroRespawnEnabled(false)
    --设置复活时间
    GameRules:GetGameModeEntity():SetFixedRespawnTime(99990000)

    --商店
    GameRules:SetUseUniversalShopMode(true)

    --开全图
    GameRules:GetGameModeEntity():SetFogOfWarDisabled(true)

    -- 锁定以后迅速进入游戏
    if IsInToolsMode() then
        GameRules:SetCustomGameSetupAutoLaunchDelay(300)
        GameRules:EnableCustomGameSetupAutoLaunch(true)
        GameRules:LockCustomGameSetupTeamAssignment(false)
    else
        GameRules:SetCustomGameSetupAutoLaunchDelay(300)
        GameRules:EnableCustomGameSetupAutoLaunch(true)
        GameRules:LockCustomGameSetupTeamAssignment(false)
    end

    SendToServerConsole("dota_max_physical_items_purchase_limit 9999")

    ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(GameMode, 'OnGameRulesStateChange'), self)
    ListenToGameEvent("dota_item_purchased", Dynamic_Wrap(GameMode, "OnItemPurchased"), self)
    ListenToGameEvent("dota_player_gained_level", Dynamic_Wrap(GameMode, "OnHeroLevelUp"), self)
    ListenToGameEvent("player_connect_full", Dynamic_Wrap(GameMode, "OnPlayerConnectFull"), self)
    -- ListenToGameEvent("player_reconnected", Dynamic_Wrap(GameMode, "OnPlayerReconnected"), self)
    ListenToGameEvent("dota_player_used_ability", Dynamic_Wrap(GameMode, "OnPlayerUsedAbility"), self)
    ListenToGameEvent("dota_player_learned_ability", Dynamic_Wrap(GameMode, "OnHeroLearnAbility"), self)
    ListenToGameEvent("npc_spawned", Dynamic_Wrap(GameMode, "OnNPCSpawned"), self)
    ListenToGameEvent("dota_item_purchased", Dynamic_Wrap(GameMode, "OnDotaItemPurchased"), self)
    ListenToGameEvent("dota_item_combined", Dynamic_Wrap(GameMode, "OnDotaItemCombined"), self)
    -- ListenToGameEvent("dota_inventory_item_added", Dynamic_Wrap(GameMode, "OnDotaInventoryItemAdded"), self)

    --CustomGameEventManager:RegisterListener("GetPayPalLink",Dynamic_Wrap(GameMode, 'GetPayPalLink'))
    --CustomGameEventManager:RegisterListener("GetPassPayPalLink",Dynamic_Wrap(GameMode, 'GetPassPayPalLink'))
    CustomGameEventManager:RegisterListener("HeroIconClicked", Dynamic_Wrap(GameMode, 'HeroIconClicked'))
    CustomGameEventManager:RegisterListener("ToggleAutoDuel", Dynamic_Wrap(GameMode, 'ToggleAutoDuel'))
    CustomGameEventManager:RegisterListener("ToggleAutoCreep", Dynamic_Wrap(GameMode, 'ToggleAutoCreep'))
    --CustomGameEventManager:RegisterListener("ClientReconnected", Dynamic_Wrap(GameMode, 'ClientReconnected'))
    CustomGameEventManager:RegisterListener("SendFeedback", Dynamic_Wrap(GameMode, 'SendFeedback'))
    CustomGameEventManager:RegisterListener("FeedbackRead", Dynamic_Wrap(GameMode, 'FeedbackRead'))


    GameRules:GetGameModeEntity():SetDamageFilter(Dynamic_Wrap(GameMode, "DamageFilter"), self)
    GameRules:GetGameModeEntity():SetExecuteOrderFilter(Dynamic_Wrap(GameMode, "OrderFilter"), self)
    GameRules:GetGameModeEntity():SetModifierGainedFilter(Dynamic_Wrap(GameMode, "ModifierGainedFilter"), self)
    GameRules:GetGameModeEntity():SetItemAddedToInventoryFilter(Dynamic_Wrap(GameMode, "AddedToInventoryFilter"), self)
    GameRules:GetGameModeEntity():SetSelectionGoldPenaltyEnabled(false)

    GameRules:SetFilterMoreGold(true)
    GameRules:GetGameModeEntity():SetModifyGoldFilter(Dynamic_Wrap(GameMode, "ModifyGoldFilter"), self)
    GameRules:GetGameModeEntity():SetModifyExperienceFilter(Dynamic_Wrap(GameMode, "ModifyExpFilter"), self)
    GameRules:GetGameModeEntity():SetBuybackEnabled(false)
    GameRules:GetGameModeEntity():SetTPScrollSlotItemOverride("item_smoke_of_deceit_lua")
    GameRules:GetGameModeEntity():SetGiveFreeTPOnDeath(false)
    GameRules:GetGameModeEntity():SetLoseGoldOnDeath(false)
    -- GameRules:GetGameModeEntity():SetFreeCourierModeEnabled(true)
    GameRules:SetTreeRegrowTime(60)
    -- GameRules:SetGoldPerTick(0)--因为新增了信使，需要取消掉每秒工资
    -- GameRules:GetGameModeEntity():SetNeutralStashEnabled(false)


	-- 加载时间
	local SETUP_TIME = 10

    Timers:CreateTimer(0.5, function()
        local nNewState = GameRules:State_Get()
        if nNewState > DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
            return nil
        end
        if (GameRules:GetStateTransitionTime() - GameRules:GetGameTime()) > SETUP_TIME then
            GameRules:SetCustomGameSetupRemainingTime(SETUP_TIME)
        end
        return 0.5
    end)
    -- for heroName, _ in pairs(HeroBuilder.AllHeroList) do
    -- 	PrecacheUnitByNameAsync(heroName, function()
    -- 		HeroBuilder.AllHeroList[heroName] = true
    -- 		print("LOAD", heroName, "Precache done.")
    -- 		CHC_HERO_LOAD_COUNT = CHC_HERO_LOAD_COUNT - 1
    -- 		if CHC_HERO_LOAD_COUNT <= 0 then
    -- 			local LoadTime = 10
    -- 			if IsInToolsMode() then
    -- 				LoadTime = 10
    -- 			end
    -- 			GameRules:SetCustomGameSetupRemainingTime(LoadTime)
    -- 			Timers:CreateTimer(0.5, function()
    -- 				local nNewState = GameRules:State_Get()
    -- 				if nNewState > DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
    -- 					return nil
    -- 				end
    -- 				if (GameRules:GetStateTransitionTime() - GameRules:GetGameTime()) > LoadTime then
    -- 					GameRules:SetCustomGameSetupRemainingTime(LoadTime)
    -- 				end
    -- 				return 0.5
    -- 			end)
    -- 		end
    -- 	end, nil)
    -- end

    for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS do
        GameMode.feedbackTime[nPlayerID] = 10
    end
end

--读取英雄KV，组装数据
-- function GameMode:AssembleHeroesData()

--	 local heroKV = LoadKeyValues("scripts/npc/npc_heroes.txt")
--	 local abilityKV = LoadKeyValues("scripts/npc/npc_abilities.txt")

--	 for szHeroName, data in pairs(heroKV) do
--		 if data and type(data) == "table" then
--			 local heroInfo = {}
--			 heroInfo.szHeroName = szHeroName
--			 heroInfo.szAttributePrimary = data.AttributePrimary
--			 heroInfo.talentNames = {}
--			 heroInfo.talentValues = {}
--			 for i = 1, 24 do
--				 if data["Ability" .. i] and string.find(data["Ability" .. i], "special_bonus_") then
--					 local sTalentName = data["Ability" .. i]
--					 table.insert(heroInfo.talentNames, sTalentName)
--					 table.insert(heroInfo.talentValues, FindTalentValue(abilityKV, heroKV, sTalentName, szHeroName))
--				 end
--			 end
--			 -- CustomNetTables:SetTableValue("hero_info", szHeroName, heroInfo)
--		 end
--	 end

-- end


--读取天赋 value 值传给前台，做国际化用
function FindTalentValue(abilityKV, heroKV, sTalentName, szHeroName)
    local result = {}

    if abilityKV[sTalentName] and abilityKV[sTalentName]["AbilitySpecial"] then
        local specialVal = abilityKV[sTalentName]["AbilitySpecial"]
        for l, m in pairs(specialVal) do
            for k, v in pairs(m) do
                if k ~= "var_type" and k ~= "ad_linked_ability" and k ~= "ad_linked_abilities" and k ~= "linked_ad_abilities" then
                    --整数直接输出 小数保留一位
                    if tonumber(v) then
                        if v == math.floor(v) then
                            table.insert(result, v)
                        else
                            table.insert(result, string.format("%.1f", v))
                        end
                    else
                        table.insert(result, v)
                    end
                end
            end
        end
    else
        local data = heroKV[szHeroName]
        for i = 1, 24 do
            if data["Ability" .. i] and not string.find(data["Ability" .. i], "special_bonus_") then
                local sAbilityName = data["Ability" .. i]
                if abilityKV[sAbilityName] then
                    local abilityValues = abilityKV[sAbilityName]["AbilityValues"]
                    if abilityValues then
                        for k, v in pairs(abilityValues) do
                            if type(v) == "table" then
                                local value = v[sTalentName]
                                if value then
                                    table.insert(result, value)
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return result
end

--读取Round数据
function GameMode:ReadRoundConfigurations()
    GameMode.RoundList = {}

    GameMode.vRoundData = {}

    --原始
    GameMode.vRoundListRaw = {}
    --最终
    GameMode.vRoundList = {}
    --最全
    GameMode.vRoundListFull = {}

    --定义Phase1 ---> Phase50 定义，后面就重复了
    for i = 1, 50 do
        GameMode.vRoundListRaw[i] = {}
        GameMode.vRoundList[i] = {}
    end

    if roundsKV == nil then
        _G.roundsKV = LoadKeyValues("scripts/kv/rounds.txt")
    end

    function GetMainRoundPool(iPhase)
        return table.deepcopy(roundsKV[tostring(iPhase)] or {})
    end

    function GetBonusRoundPool(iPhase)
        local t = {}
        for i = 1, iPhase - 1 do
            if i > 5 then
                break
            end
            local data = roundsKV[tostring(i)]
            for k, v in pairs(data) do
                t[k] = v
            end
        end
        return t
    end

    for iPhase = 1, 50 do
        local MainPool = GetMainRoundPool(iPhase) or {}
        local BonusPool = GetBonusRoundPool(iPhase) or {}
        for i = 1, 10 do
            local iRound = 10 * (iPhase - 1) + i --实际回合数
            local result = ""
            if table.count(MainPool) > 0 then
                result = table.random_key(MainPool)
                local result_data = table.deepcopy(MainPool[result])

                if GetMapName() == "2x6" then
                    for _, unitData in pairs(result_data) do
                        unitData.UnitNumber = math.ceil(tonumber(unitData.UnitNumber) * 2)
                    end
                end

                -- 五人模式怪物x5
                if GetMapName() == "5v5" then
                    for _, unitData in pairs(result_data) do
                        if result == "Round_Roshan" then
                            unitData.UnitNumber = math.ceil(tonumber(unitData.UnitNumber) * 3)
                        else
                            unitData.UnitNumber = math.ceil(tonumber(unitData.UnitNumber) * 5)
                        end
                        unitData.UnitNumber = math.ceil(tonumber(unitData.UnitNumber) * 2)
                    end
                end

                GameMode.RoundList[iRound] = {
                    RoundName = result,
                    RoundData = result_data,
                    Done = false,
                }
                MainPool = table.remove_item_bykey(MainPool, result)
            else
                result = table.random_key(BonusPool)
                local result_data = table.deepcopy(BonusPool[result])

                if GetMapName() == "2x6" then
                    for _, unitData in pairs(result_data) do
                        unitData.UnitNumber = math.ceil(tonumber(unitData.UnitNumber) * 2)
                    end
                end

                -- 五人模式怪物x5
                if GetMapName() == "5v5" then
                    for _, unitData in pairs(result_data) do
                        if result == "Round_Roshan" then
                            unitData.UnitNumber = math.ceil(tonumber(unitData.UnitNumber) * 3)
                        else
                            unitData.UnitNumber = math.ceil(tonumber(unitData.UnitNumber) * 5)
                        end
                    end
                end

                GameMode.RoundList[iRound] = {
                    RoundName = result,
                    RoundData = result_data,
                }
                BonusPool = table.remove_item_bykey(BonusPool, result)
            end
        end
    end

    -- for sPhase, phaseData in pairs(roundsKV) do
    -- 	if phaseData and type(phaseData) == "table" then
    -- 		for sRoundName, roundData in pairs(phaseData) do
    -- 			if roundData and type(roundData) == "table" then
    -- 				table.insert(GameMode.vRoundListRaw[tonumber(sPhase)], sRoundName)
    -- 				table.insert(GameMode.vRoundList[tonumber(sPhase)], sRoundName)

    -- 				--两人模式怪物x2
    -- 				if GetMapName() == "2x6" then
    -- 					for k, vData in pairs(roundData) do
    -- 						vData.UnitNumber = math.ceil(tonumber(vData.UnitNumber) * 2)
    -- 					end
    -- 				end

    -- 				-- 五人模式怪物x5
    -- 				if GetMapName() == "5v5" then
    -- 					for k, vData in pairs(roundData) do
    -- 						--肉山轮三只 其他轮五倍
    -- 						if sRoundName == "Round_Roshan" then
    -- 							vData.UnitNumber = math.ceil(tonumber(vData.UnitNumber) * 3)
    -- 						else
    -- 							vData.UnitNumber = math.ceil(tonumber(vData.UnitNumber) * 5)
    -- 						end
    -- 					end
    -- 				end

    -- 				GameMode.vRoundData[sRoundName] = roundData
    -- 			end
    -- 		end
    -- 	end

    -- end

    -- 数量不足 补足数量
    -- for i = 2, 50 do
    -- 	if #GameMode.vRoundList[i] < 10 then
    -- 		local randomPool = {}
    -- 		for j = 1, i - 1 do
    -- 			randomPool = table.join(randomPool, GameMode.vRoundListRaw[j])
    -- 		end
    -- 		-- 缺少的数量
    -- 		local nToSupplement = 10 - #GameMode.vRoundList[i]
    -- 		local supplementList = table.random_some(randomPool, nToSupplement)
    -- 		GameMode.vRoundList[i] = table.join(GameMode.vRoundList[i], supplementList)
    -- 	end
    -- end
    -- -- 深拷贝一份，如果主关卡用光从这里面随机选
    -- GameMode.vRoundListFull = table.deepcopy(GameMode.vRoundList)
end

function GameMode:OnHeroLevelUp(keys)
    local hHero = PlayerResource:GetSelectedHeroEntity(keys.player_id)
    local nLevel = hHero:GetLevel()
    if keys.level == nLevel then
        if nLevel > 25 then
            --为25级以上补足技能点数
            local nAbilityPoints = hHero:GetAbilityPoints()
            nAbilityPoints = nAbilityPoints + 1
            hHero:SetAbilityPoints(nAbilityPoints)
        end
    end
end

-- function GameMode:OnPlayerReconnected(keys)
--	 --为重连玩家重新展示选技能页面
--	 local retryTimes = 0
--	 local nPlayerID = keys.PlayerID

--	 --表示重连成功的表示
--	 if GameMode.reconnectedConfirm == nil then
--		 GameMode.reconnectedConfirm = {}
--	 end

--	 --刚重连的玩家
--	 GameMode.reconnectedConfirm[nPlayerID] = false

--	 --重置UI状态，还原技能书等
--	 local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
--	 if hHero and hHero.bSettled then
--		 HeroBuilder:ReconnectRefundBook(hHero)
--	 end

--	 Timers:CreateTimer({
--		 endTime = 5,
--		 callback = function()
--			 local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
--			 --循环等待英雄选择
--			 if hHero then
--				 --如果客户端确认已经重连，或者重复次数过多 结束本次定时任务
--				 if true == GameMode.reconnectedConfirm[nPlayerID] or retryTimes > 50 then
--					 return nil
--				 end

--				 if true ~= hHero.bSettled then
--					 return nil
--				 end

--				 --必须是英雄已经确定的情况下重发请求
--				 if hHero.nAbilityNumber then
--					 --如果技能数量不足，弹出窗口选技能
--					 if hHero.nAbilityNumber < HeroBuilder.totalAbilityNumber[nPlayerID] then
--						 HeroBuilder:ShowRandomAbilitySelection(nPlayerID)
--					 end
--				 end
--			 end

--			 retryTimes = retryTimes + 1
--			 return 1

--		 end
--	 })

-- end


function GameMode:OnGameRulesStateChange()
    --debug top
    xpcall(
        function()
            --debug top
            local nNewState = GameRules:State_Get()
            print("N2O", nNewState)
            print("N2O_State_Get", GameRules:GetGameTime())
            if nNewState == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
                -- 心跳计时器
                Timers:CreateTimer(60, function()
                    for nPlayerID = 0, (DOTA_MAX_TEAM_PLAYERS - 1) do
                        if PlayerResource and PlayerResource:IsValidPlayer(nPlayerID) and PlayerResource:GetConnectionState(nPlayerID) == DOTA_CONNECTION_STATE_CONNECTED then
                            Service:HTTP_PUT("https://metric.eomgames.net/heart_beat", nPlayerID,
                                { project = "p2", uid = PlayerResource:GetSteamAccountID(nPlayerID) })
                        end
                    end
                    return 60
                end)
                if Service.tPlayerConnected == nil then
                    Service.tPlayerConnected = {}
                end
                for nPlayerID = 0, (DOTA_MAX_TEAM_PLAYERS - 1) do
                    if PlayerResource:IsValidPlayer(nPlayerID) and Service.tPlayerConnected[nPlayerID] == true then
                        local nPlayerSteamId = PlayerResource:GetSteamAccountID(nPlayerID)

                        GameRules.sValidePlayerSteamIds[nPlayerID] = nPlayerSteamId
                        GameMode.nValidPlayerNumber = GameMode.nValidPlayerNumber + 1

                        if Econ.vPlayerData[nPlayerID] == nil then
                            Econ.vPlayerData[nPlayerID] = {}
                        end
						

                    end
                end

                print("N2O", "GameRules.sValidePlayerSteamIds:↓")
                PrintTable(GameRules.sValidePlayerSteamIds)

                -- if GameMode.nValidPlayerNumber > 1 then
				Service:StartRank()
                -- end

                -- --测试rank
                -- if IsInToolsMode() then
                -- 	Service:StartRank()
                -- end
                -- Server:StartGame()
                -- Server:GetEconRarity()
                -- DotaMind:GameStart()
            end

            if nNewState == DOTA_GAMERULES_STATE_HERO_SELECTION then
                -- Activate 时真人玩家尚未加入，过早 BotPopulate 会让机器人占满所有位置。
                -- 等队伍设置完成并进入英雄选择后，再在工具模式中自动补齐机器人。
                if IsInToolsMode() then
                    GameMode:SetUpBots()
                end

                -- 进入游戏才允许暂停
                if GameMode.nValidPlayerNumber > 1 and (not IsInToolsMode()) then
                    GameRules:GetGameModeEntity():SetPauseEnabled(false)
                end

                local vTeamColors = {}
                vTeamColors[DOTA_TEAM_GOODGUYS] = { 61, 210, 150 } --	Teal
                vTeamColors[DOTA_TEAM_BADGUYS] = { 243, 201, 9 }   --	Yellow
                vTeamColors[DOTA_TEAM_CUSTOM_1] = { 197, 77, 168 } --	Pink
                vTeamColors[DOTA_TEAM_CUSTOM_2] = { 255, 108, 0 }  --	Orange
                vTeamColors[DOTA_TEAM_CUSTOM_3] = { 52, 85, 255 }  --	Blue
                vTeamColors[DOTA_TEAM_CUSTOM_4] = { 101, 212, 19 } --	Green
                vTeamColors[DOTA_TEAM_CUSTOM_5] = { 129, 83, 54 }  --	Brown
                vTeamColors[DOTA_TEAM_CUSTOM_6] = { 27, 192, 216 } --	Cyan
                vTeamColors[DOTA_TEAM_CUSTOM_7] = { 199, 228, 13 } --	Olive
                vTeamColors[DOTA_TEAM_CUSTOM_8] = { 140, 42, 244 } --	Purple

                -- 设置队伍颜色
                -- for nTeamNumber = 0, (DOTA_TEAM_COUNT - 1) do
                -- 	local color = vTeamColors[nTeamNumber]
                -- 	if color then
                -- 		SetTeamCustomHealthbarColor(nTeamNumber, color[1], color[2], color[3])
                -- 	end
                -- end
                for iPlayerID = 0, CHC_MAX_PLAYER_COUNT - 1 do
                    local iTeam = PlayerResource:GetTeam(iPlayerID)
                    local color = vTeamColors[iTeam]
                    if color then
                        SetTeamCustomHealthbarColor(iTeam, color[1], color[2], color[3])
                        PlayerResource:SetCustomPlayerColor(iPlayerID, color[1], color[2], color[3])
                    end
                    --初始化ban位
                    if not PlayerResource:IsFakeClient(iPlayerID) then
                        if Pass.ActionTimes[iPlayerID] == nil then
                            Pass:InitPlayerData(iPlayerID, { level = 0 })
                        end
                    end
                end

                --初始化队伍分配
                for iPlayerID = 0, CHC_MAX_PLAYER_COUNT - 1 do
                    local iTeam = PlayerResource:GetTeam(iPlayerID)
                    if GameMode.vTeamPlayerMap[iTeam] then
                        table.insert(GameMode.vTeamPlayerMap[iTeam], iPlayerID)
                        --激活有效队伍，统计的时候只统计一次
                        if GameMode.vAliveTeam[iTeam] ~= true then
                            GameMode.vAliveTeam[iTeam] = true
                            GameMode.nRank = GameMode.nRank + 1
                            GameMode.nValidTeamNumber = GameMode.nValidTeamNumber + 1
                            CustomNetTables:SetTableValue("team_rank", tostring(iTeam), { rank = 0, defeat_round = 0 })
                        end

                        --PVP 战绩
                        CustomNetTables:SetTableValue("pvp_record", tostring(iPlayerID),
                            { win = 0, lose = 0, total_bet_reward = 0 })

                        --玩家开黑组队
                        if PlayerResource:GetPartyID(iPlayerID) and tostring(PlayerResource:GetPartyID(iPlayerID)) ~= "0" then
                            local sPartyID = tostring(PlayerResource:GetPartyID(iPlayerID))
                            if GameMode.partyListMap[sPartyID] == nil then
                                GameMode.nPartyNumber = GameMode.nPartyNumber + 1
                                GameMode.partyListMap[sPartyID] = GameMode.nPartyNumber
                            end
                            GameMode.partyNumberMap[iPlayerID] = GameMode.partyListMap[sPartyID]
                        end

                        -- 自动观战决斗的选择
                        if GameMode.autoDuelMap == nil then
                            GameMode.autoDuelMap = {}
                        end
                        GameMode.autoDuelMap[iTeam] = true

                        -- 自动观战PVE的选择
                        if GameMode.autoCreepMap == nil then
                            GameMode.autoCreepMap = {}
                        end
                        GameMode.autoCreepMap[iTeam] = false
                    end
                end
                CustomNetTables:SetTableValue("hero_info", "party_map", GameMode.partyNumberMap)
                GameRules:GetGameModeEntity():SetAnnouncerDisabled(true)

                --新版英雄选择
                Timers:CreateTimer(0, function()
                    if GameRules:State_Get() > DOTA_GAMERULES_STATE_HERO_SELECTION then
                        return nil
                    end
                    if BAN_PHASE_TIME_REMAIN >= 0 then
                        if BAN_PHASE_TIME_REMAIN == BAN_PHASE_TIME then
                            EmitAnnouncerSound("announcer_announcer_ban_yr")
                        elseif BAN_PHASE_TIME_REMAIN == 10 then
                            EmitAnnouncerSound("announcer_announcer_count_pick_10")
                        elseif BAN_PHASE_TIME_REMAIN == 5 then
                            EmitAnnouncerSound("announcer_announcer_count_pick_5")
                        end
                        CustomGameEventManager:Send_ServerToAllClients("UpdatePhaseTime",
                            { time = BAN_PHASE_TIME_REMAIN, phase = 1 })
                        BAN_PHASE_TIME_REMAIN = BAN_PHASE_TIME_REMAIN - 1
                    elseif SELECT_PHASE_TIME_REMAIN >= 0 then
                        if SELECT_PHASE_TIME_REMAIN == SELECT_PHASE_TIME then
                            EmitAnnouncerSound("announcer_announcer_choose_hero")
                        elseif SELECT_PHASE_TIME_REMAIN == 10 then
                            EmitAnnouncerSound("announcer_announcer_count_pick_10")
                        elseif SELECT_PHASE_TIME_REMAIN == 5 then
                            EmitAnnouncerSound("announcer_announcer_count_pick_5")
                        end

                        CustomGameEventManager:Send_ServerToAllClients("UpdatePhaseTime",
                            { time = SELECT_PHASE_TIME_REMAIN, phase = 2 })
                        SELECT_PHASE_TIME_REMAIN = SELECT_PHASE_TIME_REMAIN - 1
                    else
                        CustomGameEventManager:Send_ServerToAllClients("UpdatePhaseTime", { time = -1, phase = 0 })
                    end

                    if SELECT_PHASE_TIME_REMAIN < 0 then
                        return nil
                    else
                        return 1
                    end
                end)

                -- Timers:CreateTimer(0.1 + BAN_PHASE_TIME, function()
                -- 	for nPlayerNumber = 0, DOTA_MAX_TEAM_PLAYERS do
                -- 		Timers:CreateTimer(0, function()
                -- 			local hPlayer = PlayerResource:GetPlayer(nPlayerNumber)
                -- 			if hPlayer or true then
                -- 				local no_random = false
                -- 				local nSteamID = PlayerResource:GetSteamAccountID(nPlayerNumber)
                -- 				--单机模式 并且是通行证玩家 可以自选英雄
                -- 				if ServerKey == nil then
                -- 					_G.ServerKey = GetDedicatedServerKeyV2("CustomChaos")
                -- 				end

                -- 				if IsInToolsMode() then
                -- 					no_random = true
                -- 				end
                -- 				if 1 == GameMode.nValidPlayerNumber and (Pass:IsVip(nPlayerNumber) or GameRules:IsCheatMode()) then
                -- 					no_random = true
                -- 				end

                -- 				-- print("N2O", should_random)
                -- 				if not no_random and not PlayerResource:IsFakeClient(nPlayerNumber) then
                -- 					HeroBuilder.MadeSelection[nPlayerNumber] = HeroBuilder.RANDOM_STATE_DONE
                -- 					HeroBuilder:MakeRandomHeroSelection(nPlayerNumber)
                -- 				else
                -- 					HeroBuilder.MadeSelection[nPlayerNumber] = HeroBuilder.RANDOM_STATE_NO_RANDOM
                -- for k, _ in pairs(GameRules.allHeroesKV) do
                -- 	GameRules:RemoveHeroFromBlacklist(k)
                -- end
                -- 				end

                -- 				Timers:CreateTimer(1, function()

                -- 					if GameRules:IsGamePaused() then
                -- 						return 0.03
                -- 					end

                -- 					local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerNumber)

                -- 					if not hHero then
                -- 						return 0.03
                -- 					end

                -- 					Timers:CreateTimer(function()
                -- 						if not IsValidAlive(hHero) then
                -- 							hHero:RespawnHero(false, false)
                -- 						end
                -- 					end)

                -- 					-- 自动观战决斗的选择
                -- 					if GameMode.autoDuelMap == nil then
                -- 						GameMode.autoDuelMap = {}
                -- 					end
                -- 					GameMode.autoDuelMap[nPlayerNumber] = true

                -- 					-- 自动观战PVE的选择
                -- 					if GameMode.autoCreepMap == nil then
                -- 						GameMode.autoCreepMap = {}
                -- 					end
                -- 					GameMode.autoCreepMap[nPlayerNumber] = false

                -- 					--初始化伤害统计
                -- 					GameMode.damageCount[nPlayerNumber] = 0

                -- 					--玩家加入队伍表
                -- 					table.insert(GameMode.vTeamPlayerMap[hHero:GetTeamNumber()], nPlayerNumber)


                -- 					--激活有效队伍，统计的时候只统计一次
                -- 					if true ~= GameMode.vAliveTeam[hHero:GetTeamNumber()] then
                -- 						GameMode.vAliveTeam[hHero:GetTeamNumber()] = true
                -- 						GameMode.nRank = GameMode.nRank + 1
                -- 						GameMode.nValidTeamNumber = GameMode.nValidTeamNumber + 1
                -- 						CustomNetTables:SetTableValue("team_rank", tostring(hHero:GetTeamNumber()), { rank = 0, defeat_round = 0 })
                -- 					end

                -- 					--PVP 战绩
                -- 					CustomNetTables:SetTableValue("pvp_record", tostring(nPlayerNumber), { win = 0, lose = 0, total_bet_reward = 0 })

                -- 					--玩家组队
                -- 					if PlayerResource:GetPartyID(nPlayerNumber) and tostring(PlayerResource:GetPartyID(nPlayerNumber)) ~= "0" then
                -- 						local sPartyID = tostring(PlayerResource:GetPartyID(nPlayerNumber))
                -- 						if GameMode.partyListMap[sPartyID] == nil then
                -- 							GameMode.nPartyNumber = GameMode.nPartyNumber + 1
                -- 							GameMode.partyListMap[sPartyID] = GameMode.nPartyNumber
                -- 						end
                -- 						GameMode.partyNumberMap[nPlayerNumber] = GameMode.partyListMap[sPartyID]
                -- 						--print("nPlayerID:"..nPlayerNumber.."  sPartyID:"..sPartyID)
                -- 					end

                -- 					CustomNetTables:SetTableValue("hero_info", "party_map", GameMode.partyNumberMap)

                -- 					Timers:CreateTimer(RandomFloat(0, 0.2), function()
                -- 						if not hHero.bInited then
                -- 							HeroBuilder:InitPlayerHero(hHero)
                -- 						end
                -- 					end)

                -- 				end)
                -- 				return nil
                -- 			end
                -- 			return 0.1
                -- 		end)
                -- 	end
                -- end)
            end

            if nNewState == DOTA_GAMERULES_STATE_STRATEGY_TIME then
                for iPlayerID = 0, CHC_MAX_PLAYER_COUNT - 1 do
                    local heroName = PlayerResource:GetSelectedHeroName(iPlayerID)
                    if not PlayerResource:IsFakeClient(iPlayerID) then
                        if HeroBuilder.Hero[iPlayerID] == "" or (PlayerResource:GetRealPlayerCount() > 1 and HeroBuilder.Hero[iPlayerID] ~= "" and not table.contains(HeroBuilder.PlayerHeroList[iPlayerID], HeroBuilder.Hero[iPlayerID])) then
                            local hPlayer = PlayerResource:GetPlayer(iPlayerID)
                            if hPlayer then
                                hPlayer:SetSelectedHero(HeroBuilder.PlayerHeroList[iPlayerID][1])
                            end
                        end
                    end
                end

                --新版英雄选择
                Timers:CreateTimer(0, function()
                    if GameRules:State_Get() > DOTA_GAMERULES_STATE_STRATEGY_TIME then
                        return nil
                    end
                    if STRATEGY_PHASE_TIME_REMAIN >= 0 then
                        CustomGameEventManager:Send_ServerToAllClients("UpdatePhaseTime",
                            { time = STRATEGY_PHASE_TIME_REMAIN, phase = 3 })
                        STRATEGY_PHASE_TIME_REMAIN = STRATEGY_PHASE_TIME_REMAIN - 1
                    end

                    if STRATEGY_PHASE_TIME_REMAIN < 0 then
                        return nil
                    else
                        return 1
                    end
                end)
            end

            if nNewState == DOTA_GAMERULES_STATE_PRE_GAME then
                GameRules:GetGameModeEntity():SetAnnouncerDisabled(false)
                local SnowmanEntity = Entities:FindByName(nil, "snowman")
                if GoodFrogPos == nil then
                    _G.GoodFrogPos = Vector(0, 0, 128)
                end
                if SnowmanEntity then
                    _G.GoodFrogPos = SnowmanEntity:GetAbsOrigin()
                end
                _G.GoodFrog = CreateUnitByName("npc_dota_frog", GoodFrogPos, true, nil, nil, DOTA_TEAM_NEUTRALS)
                GoodFrog:SetForwardVector(RandomVector(1))

                _G.FountainThinker = CreateModifierThinker(nil, nil, "modifier_fountain_thinker", {}, Vector(0, 0, 128),
                    DOTA_TEAM_NEUTRALS, false)

                -- for iPlayerID = 0, CHC_MAX_PLAYER_COUNT - 1 do
                -- 	local heroName = PlayerResource:GetSelectedHeroName(iPlayerID)
                -- 	if not PlayerResource:IsFakeClient(iPlayerID) then
                -- 		if (HeroBuilder.Hero[iPlayerID] == "" or PlayerResource:GetRealPlayerCount() > 1 and HeroBuilder.Hero[iPlayerID] ~= "" and not table.contains(HeroBuilder.PlayerHeroList[iPlayerID], heroName)) and PlayerResource:GetConnectionState(iPlayerID) ~= DOTA_CONNECTION_STATE_ABANDONED then
                -- 			if PlayerResource:GetPlayer(iPlayerID) then
                -- 				PlayerResource:GetPlayer(iPlayerID):SetSelectedHero(HeroBuilder.PlayerHeroList[iPlayerID][1])
                -- 			else
                -- 				Timers:CreateTimer(0.5, function()
                -- 					local hPlayer = PlayerResource:GetPlayer(iPlayerID)
                -- 					if hPlayer then
                -- 						hPlayer:SetSelectedHero(HeroBuilder.PlayerHeroList[iPlayerID][1])
                -- 						CreateHeroForPlayer(HeroBuilder.PlayerHeroList[iPlayerID][1], hPlayer)
                -- 						return nil
                -- 					else
                -- 						return 0.5
                -- 					end
                -- 				end)
                -- 			end
                -- 		end
                -- 	end
                -- end

                --展示被禁用的技能/英雄
                Timers:CreateTimer(2, function()
                    for _, abilityName in ipairs(Pass.banAbilityList) do
                        Notifications:BottomToAll({ continue = true, text = "#DOTA_Tooltip_ability_" .. abilityName, duration = 10, style = { color = "Red", ["margin-right"] = "30px;" } })
                    end

                    for _, heroName in ipairs(Pass.banHeroList) do
                        Notifications:BottomToAll({ continue = true, text = "#" .. heroName, duration = 10, style = { color = "Red", ["margin-right"] = "30px;" } })
                    end

                    if #Pass.banAbilityList > 0 or #Pass.banHeroList > 0 then
                        Notifications:BottomToAll({ continue = true, text = "#banned_in_game", duration = 10, style = { color = "Red" } })
                    end
                end)

                -- 斗鱼活动地铺
                --GameMode:AddDouyuBanner()

                --为玩家 显示随机英雄面板 此处多次尝试 避免前台接受不到
                -- for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS do
                -- 	-- local hPlayer = PlayerResource:GetPlayer(nPlayerID)
                -- 	HeroBuilder:ShowRandomHeroSelection(nPlayerID)
                -- end

                -- Timers:CreateTimer(3, function()
                --	 for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS do
                --		 -- local hPlayer = PlayerResource:GetPlayer(nPlayerID)
                --		 HeroBuilder:ShowRandomHeroSelection(nPlayerID)
                --	 end
                -- end)
            end
            if nNewState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then

				GameRules:GetGameModeEntity():SetPauseEnabled(true)
                -- if not IsInToolsMode() then
                --     DataAnchor:UploadPlayerLoginData()
                -- end
                for iTeam, bAlive in pairs(GameMode.vAliveTeam) do
                    local bValid = false
                    if bAlive then
                        for i = 1, PlayerResource:GetPlayerCountForTeam(iTeam) do
                            local iPlayerID = PlayerResource:GetNthPlayerIDOnTeam(iTeam, i)
                            local hHero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
                            if IsValid(hHero) then
                                bValid = true
                            end
                        end
                        if not bValid then
                            GameMode:TeamLose(iTeam)
                        end
                    end
                end

                --调整游戏时间
                GameRules:SetTimeOfDay(0.26)
                GameRules:GetGameModeEntity():SetDaynightCycleAdvanceRate(1)

                for iPlayerID = 0, DOTA_MAX_TEAM_PLAYERS do
                    if not PlayerResource:IsFakeClient(iPlayerID) then
                        Econ:RefreshAllEcon(iPlayerID)
                    end
                end

                --开始预载入声音
                -- HeroBuilder:RunAbilitySoundPrecache()

                if GameMode.nValidTeamNumber == 1 then
                    --单队伍的提示
                    if string.find(GetMapName(), "1x8") then
                        Notifications:BottomToAll({ text = "#suicide_note", duration = 10, style = { color = "Red" } })
                    end
                    if GetMapName() == "2x6" or GetMapName() == "5v5" then
                        Notifications:BottomToAll({ text = "#one_team_in_multi_map_no_record", duration = 10, style = { color = "Red" } })
                    end
                else
                    --if GameMode.nValidTeamNumber>=5 then
                    --Notifications:BottomToAll({ text = "#marked_actor_note", duration = 15, style = { color = "Red" }})
                    --end
                end

                if GameRules:IsCheatMode() then
                    Notifications:BottomToAll({ text = "#cheat_lobby_note", duration = 60, style = { color = "Red" } })
                end

                GameRules.nGameStartTime = GameRules:GetGameTime()
                GameMode.currentRound = Round()
                --第一回合开始
                GameMode.currentRound:Prepare(1)

                --启动电子围栏
                -- Util:InitHeroFence()

                --不重要的全局计时器
                Timers:CreateTimer(1, function()
                    --修复攻击范围
                    HeroBuilder:FixAttackCapability()
                    --监控A杖是否存在
                    HeroBuilder:ProcessScepterOwners()

                    --更新伤害
                    -- local flMaxDamage = 0
                    -- for nPlayerID, flDamage in pairs(GameMode.damageCount) do
                    --	 if flDamage > flMaxDamage then
                    --		 flMaxDamage = flDamage
                    --	 end
                    -- end

                    -- CustomNetTables:SetTableValue("hero_info", "damage_count", GameMode.damageCount)
                    -- CustomNetTables:SetTableValue("hero_info", "max_damage", { max_damage = flMaxDamage })

                    return 1
                end)

                --重要的全计时器
                Timers:CreateTimer(1.5, function()
                    --判断是否整支队伍 全部放弃游戏
                    for nTeamNumber, bAlive in pairs(GameMode.vAliveTeam) do
                        local bTeamAbandon = true
                        for _, nPlayerID in ipairs(GameMode.vTeamPlayerMap[nTeamNumber]) do
                            if PlayerResource:GetConnectionState(nPlayerID) ~= DOTA_CONNECTION_STATE_ABANDONED then
                                bTeamAbandon = false
                            end
                            --如果一个玩家已经被AI接管 直接踢出游戏
                            local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
                            if hHero and hHero.bTakenOverByBot then
                                if PlayerResource:GetPlayer(nPlayerID) then
                                    -- CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(nPlayerID), "KickPlayer", { security_key = Security:GetSecurityKey(nPlayerID), player_id = nPlayerID })
                                end
                            end
                            --不允许泉水无敌
                            -- if hHero and not hHero:IsNull() and hHero.HasModifier then
                            -- 	if hHero:HasModifier("modifier_fountain_invulnerability") then
                            -- 		hHero:RemoveModifierByName("modifier_fountain_invulnerability")
                            -- 	end
                            -- end
                        end

                        if bTeamAbandon then
                            --整只队伍全部放弃游戏
                            GameRules.teamAbandonMap[nTeamNumber] = true
                        end
                    end
                    local bAllLeave = true
                    for i = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
                        if PlayerResource:GetConnectionState(i) == DOTA_CONNECTION_STATE_CONNECTED then
                            bAllLeave = false
                            break
                        end
                    end
                    -- if bAllLeave then
                    --     DataAnchor:UploadButtonClickedData()
                    -- end

                    return 1
                end)

                -- for nPlayerID = 0, (DOTA_MAX_TEAM_PLAYERS - 1) do
                --	 if PlayerResource:IsValidPlayer(nPlayerID) then
                --		 local sPlayerSteamId = PlayerResource:GetSteamAccountID(nPlayerID)
                --		 --重发一下数据，保证前台数据完整
                --		 local bucketData = CustomNetTables:GetTableValue("econ_data", "econ_total_bucket_" .. sPlayerSteamId)
                --		 if bucketData and bucketData.total_bucket then
                --			 local nBucketNumber = tonumber(bucketData.total_bucket)
                --			 for i = 1, nBucketNumber do
                --				 local playerData = CustomNetTables:GetTableValue("econ_data", "econ_info_" .. sPlayerSteamId .. "_" .. i)
                --				 if playerData then
                --					 CustomNetTables:SetTableValue("econ_data", "econ_info_" .. sPlayerSteamId .. "_" .. i, playerData)
                --					 --给玩家装备饰品
                --					 for nIndex, v in pairs(playerData) do
                --						 if v.type == "Particle" and v.equip == "true" then
                --							 Econ:EquipParticleEcon(v.name, nPlayerID)
                --						 end
                --						 if v.type == "KillEffect" and v.equip == "true" then
                --							 Econ:EquipKillEffectEcon(v.name, nPlayerID)
                --						 end
                --						 if v.type == "KillSound" and v.equip == "true" then
                --							 Econ:EquipKillSoundEcon(v.name, nPlayerID)
                --						 end
                --						 if v.type == "Barrage" and v.equip == "true" then
                --							 Econ:EquipBarrageEcon(v.name, nPlayerID)
                --						 end
                --						 if v.type == "Pet" and v.equip == "true" then
                --							 Econ:EquipPetEcon(v.name, nPlayerID)
                --						 end
                --						 if v.type == "CosmeticsAbility" and v.equip == "true" then
                --							 Econ:EquipCosmeticsAbilityEcon(v.name, nPlayerID)
                --						 end
                --					 end
                --				 end
                --			 end
                --		 end

                --		 local moneyData = CustomNetTables:GetTableValue("econ_data", "money_" .. sPlayerSteamId)
                --		 if moneyData then
                --			 CustomNetTables:SetTableValue("econ_data", "money_" .. sPlayerSteamId, moneyData)
                --		 end
                --	 end
                -- end
            end

            --debug down
        end,
        function(e)
            print("-------------Error-------------")
            print(e)
            Service:UploadError(e)
        end)
    --debug down
end

function GameMode:FinishRound()
    local nRoundNumber = GameMode.currentRound.nRoundNumber

    --关卡完成 清空定时任务
    GameMode.currentRound:End()

    if nRoundNumber >= 500 and GameMode.nValidTeamNumber == 1 and GameMode.nRank == 1 then
        for nTeamNumber, bAlive in pairs(GameMode.vAliveTeam) do
            if bAlive then
                GameMode:TeamLose(nTeamNumber)
            end
        end
    else
        nRoundNumber = nRoundNumber + 1
        GameMode.currentRound = Round()
        GameMode.currentRound:Prepare(nRoundNumber)
    end
end

function GameMode:SetTeam()
    --汇总玩家的steamID
    GameRules.sValidePlayerSteamIds = {}

    --汇总秒退玩家的steamID
    --在bot_ai.lua中处理
    GameRules.sEarlyLeavePlayerSteamIds = {}

    --汇总秒退率20%玩家的SteamID
    GameRules.sAlwaysEarlyLeavePlayerSteamIds = ""

    GameMode.vTeamList = {}
    -- key为team, value 为玩家ID队列
    GameMode.vTeamPlayerMap = {}

    --纪录队伍是否存活
    GameMode.vAliveTeam = {}

    --排名
    GameMode.nRank = 0

    --排名表  key为名次 value为teamNumber
    GameMode.rankMap = {}

    --有效队伍总数
    GameMode.nValidTeamNumber = 0

    --有效玩家总数
    GameMode.nValidPlayerNumber = 0

    --纪录Team的刷怪中心点
    GameMode.vTeamLocationMap = {}

    --纪录Team的出生点
    GameMode.vTeamStartLocationMap = {}

    --根据地图出生点，设置队伍
    for _, hPlayerStart in pairs(Entities:FindAllByClassname("info_player_start_dota")) do
        table.insert(GameMode.vTeamList, hPlayerStart:GetTeam())
        GameMode.vTeamStartLocationMap[hPlayerStart:GetTeam()] = hPlayerStart:GetOrigin()
    end

    local nTeamMaxPlayers = 1
    if string.find(GetMapName(), "1x8") then
        nTeamMaxPlayers = 1
    end

    if GetMapName() == "2x6" then
        nTeamMaxPlayers = 2
    end

    if GetMapName() == "5v5" then
        nTeamMaxPlayers = 5
    end

    for i = 1, #GameMode.vTeamList do
        local nTeamNumber = GameMode.vTeamList[i]
        GameRules:SetCustomGameTeamMaxPlayers(nTeamNumber, nTeamMaxPlayers)
        GameMode.vAliveTeam[nTeamNumber] = false
        GameMode.vTeamPlayerMap[nTeamNumber] = {}
        local wayPoint = Entities:FindByName(nil, "center_" .. nTeamNumber)
        GameMode.vTeamLocationMap[nTeamNumber] = wayPoint:GetOrigin()
        --初始化额外生物队列
        ExtraCreature.teamCreatureMap[nTeamNumber] = {}
    end
end

--玩家金币变化
function GameMode:ModifyGoldFilter(keys)
    -- PrintTable(keys)
    if PlayersGold == nil then
        _G.PlayersGold = {}
    end
    local iPlayerID = keys.player_id_const
    local nGold = keys.gold
    local reason = keys.reason_const
    if PlayersGold[iPlayerID] == nil then
        PlayersGold[iPlayerID] = 600
    end


    local hHero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
    if IsValid(hHero) then
        if keys.gold > 0 and reason ~= DOTA_ModifyGold_SellItem and hHero:HasModifier("modifier_relief_fund") then
            local stack = hHero:FindModifierByName("modifier_relief_fund"):GetStackCount() or 0
            keys.gold = math.ceil(keys.gold * (100 + stack * 8) * 0.01)
        end
    end
    if (keys.gold > 0 and reason ~= DOTA_ModifyGold_SellItem) or reason == DOTA_ModifyGold_Unspecified then
        PlayersGold[iPlayerID] = PlayersGold[iPlayerID] + keys.gold
    end

    if reason == DOTA_ModifyGold_Unspecified and keys.gold > 0 then
        if IsValid(hHero) then
            SendOverheadEventMessage(hHero, OVERHEAD_ALERT_GOLD, hHero, keys.gold, nil)
        end
    end

    GameMode:UpdatePlayerGold(keys.player_id_const)
    return true
end

--向前台更新玩家金币信息
function GameMode:UpdatePlayerGold(nPlayerID)
    local hPlayer = PlayerResource:GetPlayer(nPlayerID)
    --游戏开始阶段才开始计算
    if hPlayer and GameRules.nGameStartTime then
        -- CustomGameEventManager:Send_ServerToPlayer(hPlayer, "UpdateBetInput", {})
        --local nGold = PlayerResource:GetGold(nPlayerID)+PlayerResource:GetGoldSpentOnItems(nPlayerID)+PlayerResource:GetGoldSpentOnConsumables(nPlayerID)
        -- local nGold = math.ceil(PlayerResource:GetGoldPerMin(nPlayerID) * (GameRules:GetGameTime() - GameRules.nGameStartTime) / 60) + 600 - PvpModule.betValueSum[nPlayerID]
        CustomNetTables:SetTableValue("player_info", tostring(nPlayerID), { gold = PlayersGold[nPlayerID] })
    end
end

--玩家经验变化
function GameMode:ModifyExpFilter(keys)
    local hero = EntIndexToHScript(keys.hero_entindex_const)
    local exp = keys.experience
    local reason = keys.reason_const
    --风暴双雄不分摊经验
    if hero:IsTempestDouble() then
        local main_hero = PlayerResource:GetSelectedHeroEntity(hero:GetPlayerOwnerID())
        main_hero:AddExperience(exp, reason, false, false)
        return false
    end

    return true
end

--玩家购买物品
function GameMode:OnItemPurchased(keys)
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(keys.PlayerID), "UpdateBetInput", {})
end

function GameMode:HeroIconClicked(keys)
    local nPlayerID = VerifyClientEventHeroOwner(keys)
    local nTargetPlayerID = keys.targetPlayerId
    if nPlayerID == nil or type(nTargetPlayerID) ~= "number" or not PlayerResource:IsValidPlayerID(nTargetPlayerID) then
        return
    end
    if not CheckClientEventRateLimit(nPlayerID, "HeroIconClicked", 0.05) then return end
    local nDoubleClick = keys.doubleClick
    local nControldown = keys.controldown
    local nAltDown = keys.altdown

    local hTargetHero = PlayerResource:GetSelectedHeroEntity(nTargetPlayerID)
    if hTargetHero then
        --如果按住ctrl 或者双击，定位到目标位置
        if nDoubleClick == 1 or nControldown == 1 then
            PlayerResource:SetCameraTarget(nPlayerID, hTargetHero)
            Timers:CreateTimer({
                endTime = 0.1,
                callback = function()
                    PlayerResource:SetCameraTarget(nPlayerID, nil)
                end
            })
        end
    end
    if hTargetHero and nAltDown == 1 then
        if PlayerResource:GetPlayer(nPlayerID) then
            local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
            if hHero then
                if nPlayerID ~= nTargetPlayerID then
                    hHero.sActorUISecret = CreateSecretKey()
                    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(nPlayerID), "ShowActorPanel",
                        { target_player_id = nTargetPlayerID, security_key = Security:GetSecurityKey(nPlayerID) });
                end
            end
        end
    end
end

function GameMode:ToggleAutoDuel(keys)
    local nPlayerID = VerifyClientEventHeroOwner(keys)
    local bSelected = (1 == keys.selected)
    if nPlayerID and GameMode.autoDuelMap then
        GameMode.autoDuelMap[nPlayerID] = bSelected
    end
end

function GameMode:ToggleAutoCreep(keys)
    local nPlayerID = VerifyClientEventHeroOwner(keys)
    local bSelected = (1 == keys.selected)
    if nPlayerID and GameMode.autoCreepMap then
        GameMode.autoCreepMap[nPlayerID] = bSelected
    end
end

--[[function GameMode:GetPayPalLink(keys)
	local nPlayerID = keys.PlayerID
	Server:GetPayPalLink(nPlayerID)
end

function GameMode:GetPassPayPalLink(keys)
	local nPlayerID = keys.PlayerID
	Server:GetPassPayPalLink(nPlayerID)
end
]]
--队伍失败
function GameMode:TeamLose(nTeamNumber)
    GameMode.vAliveTeam[nTeamNumber] = false
    local data = {}
    data.type = "team_lose"
    data.nTeamNumber = nTeamNumber
    Barrage:FireBullet(data)


    local match_id = tostring(GameMode:GetMatchID())
    --淘汰玩家清空金币
    for _, nPlayerID in ipairs(GameMode.vTeamPlayerMap[nTeamNumber]) do
        local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
        if hHero then
            hHero:SetGold(0, true)
        end
    end

    if GameMode.currentRound == nil then
        GameMode.currentRound = {
            nRoundNumber = 0
        }
    end

    if GameMode.currentRound and GameMode.currentRound.spanwers and GameMode.currentRound.spanwers[nTeamNumber] then
        --强制停机
        GameMode.currentRound.spanwers[nTeamNumber].bForceStop = true

        for i, hCreep in ipairs(GameMode.currentRound.spanwers[nTeamNumber].vCurrentCreeps) do
            if hCreep and (not hCreep:IsNull()) and hCreep:IsAlive() then
                --不会被击杀监听到
                hCreep.nSpawnerTeamNumber = nil
                hCreep:ForceKill(false)
            end
        end
    end

    --清理数据
    Util:CleanPvpPair(nTeamNumber)

    --单人模式 游戏结束
    if GameMode.nValidTeamNumber == 1 and GameMode.nRank == 1 then
        if string.find(GetMapName(), "1x8") then
            -- 获取玩家SteamId
            local nPlayerID = GameMode.vTeamPlayerMap[nTeamNumber][1]
            local nPlayerSteamId = PlayerResource:GetSteamAccountID(nPlayerID)
            if not (GameRules:IsCheatMode() or IsInToolsMode()) then
                -- Server:EndPveGame(nTeamNumber, GameMode.currentRound.nRoundNumber, nPlayerSteamId)
                _G.nWinnerTeam = nTeamNumber
                Service:EndPve(nPlayerID)
            else
                Notifications:BottomToAll({ text = "#cheat_no_record", duration = 4, style = { color = "Red" } })
                _G.nWinnerTeam = nTeamNumber
                Service:EndPve(nPlayerID)
                -- Timers:CreateTimer(4, function()
                --	 GameRules:SetGameWinner(nTeamNumber)
                -- end)
            end
        end
        if GetMapName() == "2x6" or GetMapName() == "5v5" then
            _G.nWinnerTeam = nTeamNumber
            -- Service:EndRank()
            -- Notifications:BottomToAll({ text = "#one_team_in_multi_map_no_record", duration = 4, style = { color = "Red" } })
            -- Timers:CreateTimer(4, function()
            -- 	GameRules:SetGameWinner(nTeamNumber)
            -- end)
        end
        --单人模式上传技能数据
        -- DataAnchor:UploadAbilityData()
        -- DataAnchor:UploadRoundData()
    else
        -- 多人模式 第二名已经淘汰，结束游戏
        if GameMode.nValidTeamNumber >= 2 and GameMode.nRank == 2 then
            _G.nWinnerTeam = -1
            for nAliveTeamNumber, bAlive in pairs(GameMode.vAliveTeam) do
                if bAlive then
                    nWinnerTeam = nAliveTeamNumber
                end
            end
            --前两名 名次已出
            GameMode.rankMap[2] = nTeamNumber
            CustomNetTables:SetTableValue("team_rank", tostring(nTeamNumber),
                { rank = 2, defeat_round = GameMode.currentRound.nRoundNumber })
            GameMode.rankMap[1] = nWinnerTeam
            CustomNetTables:SetTableValue("team_rank", tostring(nWinnerTeam),
                { rank = 1, defeat_round = GameMode.currentRound.nRoundNumber })

            -- if not GameRules:IsCheatMode() and not IsInToolsMode() and not GetMapName() == "5v5" then
            if GetMapName() ~= "5v5" and not GameRules:IsCheatMode() and not IsInToolsMode() then
                local finCount = 0
                local allCount = 0
                local updataRank = function(teamNumber, rank)
                    for _, playerID in ipairs(GameMode.vTeamPlayerMap[teamNumber]) do
                        GameMode.playerRank = GameMode.playerRank or {}
                        GameMode.playerRank[playerID] = rank
                        allCount = allCount + 1
                        Service:CallAction("calc_rank", playerID, { match_id = match_id, ranking = rank },
                            function(_, iPlayerID, response)
                                if response and response.Body then
                                    local data = json.decode(response.Body)
                                    if data and data.code == 0 and data.data then
                                        local score = data.data.score
                                        if data.data.add_score then
                                            score = score + data.data.add_score
                                        end
                                        Service:SaveData(iPlayerID, "score", score)
                                        Service:SaveData(iPlayerID, "origin_score", data.data.score)

                                        -- print("iPlayerID", iPlayerID, "score", Service:LoadData(iPlayerID, "score"), "origin_score", Service:LoadData(iPlayerID, "origin_score"))

                                        finCount = finCount + 1
                                        if finCount == allCount then
                                            -- Timers:CreateTimer(1, function()
                                            Service:EndRank()
                                            -- end)
                                        end
                                    end
                                end
                            end)
                    end
                end
                updataRank(nWinnerTeam, 1)
                updataRank(nTeamNumber, 2)
                -- Timers:CreateTimer(1, function()
                -- 	Service:EndRank()
                -- end)

                -- for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
                -- 	for rank = 1, 2 do
                -- 		if GameMode.rankMap[rank] == PlayerResource:GetTeam(playerID) then
                -- 			GameMode.playerRank = GameMode.playerRank or {}
                -- 			GameMode.playerRank[playerID] = rank
                -- 			Service:CallAction("calc_rank", playerID, { match_id = match_id, ranking = rank }, function(_, iPlayerID, response)
                -- 				if response and response.Body then
                -- 					local data = json.decode(response.Body)
                -- 					if data and data.code == 0 and data.data then
                -- 						local score = data.data.score
                -- 						if data.data.add_score then
                -- 							score = score + data.data.add_score
                -- 						end
                -- 						Service:SaveData(iPlayerID, "score", score)
                -- 						Service:SaveData(iPlayerID, "origin_score", data.data.score)
                -- 					end
                -- 				end
                -- 			end)
                -- 			-- local hero = PlayerResource:GetSelectedHeroEntity(i)
                -- 			-- if IsValid(hero) then
                -- 			-- 	for p = 0, hero:GetAbilityCount() - 1 do
                -- 			-- 		local ability = hero:GetAbilityByIndex(p)
                -- 			-- 		if ability ~= nil and not ability:IsHidden() and string.find(ability:GetAbilityName(), "special_bonus_") == nil then
                -- 			-- 			DataAnchor:RecordAbilityData(ability:GetAbilityName(), DATA_KEYS.ABILITY_WIN, 1)
                -- 			-- 		end
                -- 			-- 	end
                -- 			-- end
                -- 		end
                -- 	end
                -- end
            end

            -- DotaMind:UpdateScore(true)

            --5v5 地图不记录天梯
            if GameRules:IsCheatMode() or IsInToolsMode() then
                -- Timers:CreateTimer(4, function()
                -- 	GameRules:SetGameWinner(nWinnerTeam)
                -- end)
                -- else
                -- Timers:CreateTimer(1, function()
                -- 	Service:EndRank()
                -- end)
                -- Timers:CreateTimer(0.05, function()
                -- 	--总共等待30秒
                -- 	DotaMind.nWaitFinalScoreUpdate = DotaMind.nWaitFinalScoreUpdate + 1
                -- 	--如果有返回 或者等待超时，则结算游戏
                -- 	if DotaMind.bFinalScoreUpdateSuccess or DotaMind.nWaitFinalScoreUpdate > 600 then
                -- 		--Dota Mind游戏结束
                -- 		DotaMind:GamePost()
                -- 		-- Server:EndPvpGame(nWinnerTeam)
                -- 		Service:EndRank()
                -- 		return nil
                -- 	else
                -- 		return 0.05
                -- 	end
                -- end)
                -- end
                Notifications:BottomToAll({ text = "#cheat_no_record", duration = 4, style = { color = "Red" } })
            else
                if GetMapName() == "5v5" then
                    Notifications:BottomToAll({ text = "#5v5_no_record", duration = 4, style = { color = "Red" } })
                end
                -- Service:EndRank()
                -- Timers:CreateTimer(4, function()
                -- 	GameRules:SetGameWinner(nWinnerTeam)
                -- end)
            end
            GameMode.nRank = GameMode.nRank - 1
            --多人模式上传技能数据
            -- DataAnchor:UploadAbilityData()
            -- DataAnchor:UploadRoundData()
            -- DataAnchor:UploadItemData()
        else
            -- 以上都不是 淘汰玩家 游戏继续
            -- 遍历败者队伍 玩家弹出结算页面
            for _, nPlayerID in ipairs(GameMode.vTeamPlayerMap[nTeamNumber]) do
                GameMode.playerRank = GameMode.playerRank or {}
                GameMode.playerRank[nPlayerID] = GameMode.nRank
                local rank = GameMode.nRank
                Service:CallAction("calc_rank", nPlayerID, { match_id = match_id, ranking = rank },
                    function(_, iPlayerID, response)
                        local params = {
                            game_rank = rank,
                            valid_team = GameMode.nValidTeamNumber,
                            -- security_key = Security:GetSecurityKey(nPlayerID)
                        }
                        if response and response.Body then
                            local data = json.decode(response.Body)
                            if data and data.code == 0 and data.data then
                                local score = data.data.score
                                if data.data.add_score then
                                    score = score + data.data.add_score
                                end
                                params.score = score
                                params.origin_score = data.data.score

                                Service:SaveData(iPlayerID, "score", score)
                                Service:SaveData(iPlayerID, "origin_score", data.data.score)
                            end
                        end
                        local hPlayer = PlayerResource:GetPlayer(nPlayerID)
                        if hPlayer then
                            CustomGameEventManager:Send_ServerToPlayer(hPlayer, "ShowPlayerLose", params)
                        end
                    end)
            end
            -- 纪录名次
            GameMode.rankMap[GameMode.nRank] = nTeamNumber
            CustomNetTables:SetTableValue("team_rank", tostring(nTeamNumber),
                { rank = GameMode.nRank, defeat_round = GameMode.currentRound.nRoundNumber })
            GameMode.nRank = GameMode.nRank - 1
            --Dota Mind更新分数
            -- DotaMind:UpdateScore(false)
        end
    end
end

--添加活动地铺
function GameMode:AddDouyuBanner()
    local mapCenter = Entities:FindByName(nil, "map_center")
    if mapCenter then
        local nParticleIndex = ParticleManager:CreateParticle("particles/econ/douyu_cup.vpcf", PATTACH_ABSORIGIN_FOLLOW,
            mapCenter)
        ParticleManager:SetParticleControlEnt(nParticleIndex, 0, mapCenter, PATTACH_ABSORIGIN_FOLLOW, "follow_origin",
            mapCenter:GetAbsOrigin(), true)
        ParticleManager:ReleaseParticleIndex(nParticleIndex)
    end
end

--监听使用技能,禁止长距离位移连招
function GameMode:OnPlayerUsedAbility(keys)
    --[[   if ("phoenix_icarus_dive"==keys.abilityname or "morphling_waveform"==keys.abilityname or "slark_pounce"==keys.abilityname or "earth_spirit_rolling_boulder"==keys.abilityname ) and keys.PlayerID then
	  local hHero = PlayerResource:GetSelectedHeroEntity(keys.PlayerID)
	  if hHero then
		  -- 施加闭锁 禁止长距离位移连招
		   hHero:AddNewModifier(hHero, nil, "modifier_generic_muted_lua", {duration=2.0})
		  for i = 0, 20 do --遍历技能
			 local hAbility = hHero:GetAbilityByIndex(i)
			 if hAbility and hAbility.GetAbilityName then
				if "antimage_blink"==hAbility:GetAbilityName()  or "queenofpain_blink"==hAbility:GetAbilityName() or
				   "ember_spirit_fire_remnant"==hAbility:GetAbilityName()  or "puck_illusory_orb"==hAbility:GetAbilityName() or
				   "morphling_waveform" ==hAbility:GetAbilityName()  or "slark_pounce" ==hAbility:GetAbilityName() or
				   "faceless_void_time_walk" ==hAbility:GetAbilityName() or "magnataur_skewer" ==hAbility:GetAbilityName() or
				   "phoenix_icarus_dive" ==hAbility:GetAbilityName() or "void_spirit_astral_step" ==hAbility:GetAbilityName() or
				   "earth_spirit_rolling_boulder" == hAbility:GetAbilityName() or "techies_suicide" == hAbility:GetAbilityName() or
				   "sandking_burrowstrike" == hAbility:GetAbilityName() or "rattletrap_overclocking" == hAbility:GetAbilityName() then
				   if hAbility:GetCooldownTimeRemaining() <2 then
					 hAbility:StartCooldown(2)
				   end
				end
				if hHero.HasScepter and hHero:HasScepter() and "earthshaker_enchant_totem" == hAbility:GetAbilityName() then
				  if hAbility:GetCooldownTimeRemaining() <2 then
					 hAbility:StartCooldown(2)
				  end
				end
			 end
		  end
	  end
   end
   ]]
    --修复不稳定化合物 交换位置无CD的BUG
    HeroBuilder:RefreshAbilityOrder(keys.PlayerID)
end

function GameMode:ClientReconnected(keys)
    local nPlayerID = keys.PlayerID
    if GameMode.reconnectedConfirm then
        GameMode.reconnectedConfirm[nPlayerID] = true
    end
end

--学习真熊形态附赠技能
function GameMode:OnHeroLearnAbility(keys)
    -- print("OnHeroLearnAbility", keys.abilityname)
    -- local hHero = PlayerResource:GetSelectedHeroEntity(keys.PlayerID)
    -- if "lone_druid_true_form" == keys.abilityname and hHero and hHero:IsRealHero() and not hHero:IsTempestDouble() and not hHero:HasModifier("modifier_arc_warden_tempest_double_lua") then
    -- 	local hAbility1 = hHero:FindAbilityByName("lone_druid_true_form_druid")
    -- 	if hAbility1 then
    -- 		hAbility1:SetLevel(hAbility1:GetLevel() + 1)
    -- 	end
    -- 	local hAbility2 = hHero:FindAbilityByName("lone_druid_true_form_battle_cry")
    -- 	if hAbility2 then
    -- 		hAbility2:SetLevel(hAbility2:GetLevel() + 1)
    -- 	end
    -- end
    -- if "lone_druid_true_form_druid" == keys.abilityname and hHero and hHero:IsRealHero() and not hHero:IsTempestDouble() and not hHero:HasModifier("modifier_arc_warden_tempest_double_lua") then
    -- 	local hAbility1 = hHero:FindAbilityByName("lone_druid_true_form_battle_cry")
    -- 	if hAbility1 then
    -- 		hAbility1:SetLevel(hAbility1:GetLevel() + 1)
    -- 	end
    -- end
end

function GameMode:GetAllTeamInfo()
    local nMaxTeamNumber = 8
    local nMaxPerTeam = 1

    if string.find(GetMapName(), "1x8") then
        nMaxTeamNumber = 8
        nMaxPerTeam = 1
    end
    if GetMapName() == "2x6" then
        nMaxTeamNumber = 6
        nMaxPerTeam = 2
    end
    if GetMapName() == "5v5" then
        nMaxTeamNumber = 2
        nMaxPerTeam = 5
    end

    return nMaxTeamNumber, nMaxPerTeam
end

--设置机器人
function GameMode:SetUpBots()
    if GameRules.bStartBoot then
        return
    end

    GameRules.bStartBoot = true

    GameMode.teamSet = {}

    local nMaxTeamNumber, nMaxPerTeam = GameMode:GetAllTeamInfo()
    local nBotCount = nMaxTeamNumber * nMaxPerTeam - PlayerResource:GetPlayerCount()
    -- local nBotCount = 1
    GameRules:BotPopulate()
    for i = 1, nBotCount do
        --local result = table.random(HeroBuilder.allHeroeNames)
        --Tutorial:AddBot(result, '', '', true)
        GameMode.nValidPlayerNumber = GameMode.nValidPlayerNumber + 1
    end
    -- print("SetUpBots", GameMode.nValidPlayerNumber)

    for i = 1, #GameMode.vTeamList do
        local nTeamNumber = GameMode.vTeamList[i]
        local nCurrentPlayerNumber = PlayerResource:GetPlayerCountForTeam(nTeamNumber)
        for j = 1, nMaxPerTeam - nCurrentPlayerNumber do
            GameMode:FillTeamWithBot(nTeamNumber)
        end
    end
end

--设置机器人
function GameMode:FillTeamWithBot(nTeamNumber)
    --寻找一个编号最大的Bot
    for nPlayerID = CHC_MAX_PLAYER_COUNT - 1, 0, -1 do
        if PlayerResource:IsFakeClient(nPlayerID) and GameMode.teamSet[nPlayerID] == nil then
            GameMode.teamSet[nPlayerID] = true
            PlayerResource:SetCustomTeamAssignment(nPlayerID, nTeamNumber)

            --延迟一小段时间 给英雄改队伍
            Timers:CreateTimer(0.05, function()
                local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
                if hHero ~= nil then
                    hHero:SetTeam(nTeamNumber)
                    return nil
                end
                return 0.01
            end)

            break;
        end
    end
end

function GameMode:OnNPCSpawned(keys)
    local hSpawnedUnit = EntIndexToHScript(keys.entindex)
    if hSpawnedUnit then
        -- 如果是召唤术士魔像，且装备了17000028皮肤，则替换模型
        if hSpawnedUnit:GetUnitName() and string.find(hSpawnedUnit:GetUnitName(), "npc_dota_warlock_golem") == 1 then
            local playerID = hSpawnedUnit:GetPlayerOwnerID()
            if playerID and playerID ~= -1 then
                local skinID = Wearable_System:GetPlayerHeroSkin(playerID, "npc_dota_hero_warlock")
                if skinID == "17000028" then
                    hSpawnedUnit:AddNewModifier(hSpawnedUnit, nil, "modifier_warlock_golem_burning_puppet", {})
                end
            end
        end

        if IsInToolsMode() then
            if hSpawnedUnit:GetName() == "npc_dota_thinker" then
                -- SendToConsole(string.format("ent_text %d", hSpawnedUnit:entindex()))
            end
        end
        -- 肉山删除扔帽子 -- 2024/12/25
        -- 肉山删除扔英雄 -- 2025/2/19
        if hSpawnedUnit:GetUnitName() == "npc_dota_roshan" then
            hSpawnedUnit:RemoveAbility("roshan_grab_and_throw")
        end

        -- 记录风暴双雄的召唤物
        if hSpawnedUnit:GetOwner() and hSpawnedUnit:GetOwner().IsTempestDouble and hSpawnedUnit:GetOwner():IsTempestDouble() then
            local owner = hSpawnedUnit:GetOwner()
            owner.__summon = owner.__summon or {}
            owner.__summon[hSpawnedUnit:entindex()] = true
        end
        --去掉多重施法分身的宠物
        if hSpawnedUnit:GetName() == "npc_dota_companion" and hSpawnedUnit:GetOwner() ~= PlayerResource:GetSelectedHeroEntity(hSpawnedUnit:GetPlayerOwnerID()) then
            hSpawnedUnit:RemoveSelf()
        end

        if string.find(hSpawnedUnit:GetUnitName(), "npc_dota_lone_druid_bear") then
            Timers:CreateTimer(FrameTime(), function()
                hSpawnedUnit:RemoveModifierByName("modifier_lone_druid_spirit_bear_attack_check")
            end)
        end
        --如果英雄无敌 给蛋 / 熊猫分身 也加上无敌
        local hOwner = hSpawnedUnit:GetOwner()
        -- local kv = GetUnitKeyValuesByName(hSpawnedUnit:GetUnitName())

        -- 奶绿移除幻象的被动BUFF
        -- if hSpawnedUnit:IsIllusion() then
        if hSpawnedUnit:IsIllusion() and hSpawnedUnit:GetUnitName() == "npc_dota_hero_muerta" then
            Timers:CreateTimer(FrameTime(), function()
                hSpawnedUnit:RemoveAbility("muerta_supernatural")
                hSpawnedUnit:RemoveAbility("muerta_pierce_the_veil")
                hSpawnedUnit:RemoveModifierByName("modifier_muerta_supernatural")
                hSpawnedUnit:RemoveModifierByName("modifier_muerta_gunslinger")
                hSpawnedUnit:RemoveModifierByName("modifier_muerta_pierce_the_veil")
                hSpawnedUnit:RemoveModifierByName("modifier_muerta_pierce_the_veil_buff")
            end)
            -- hSpawnedUnit:RemoveAllModifiers(0, true, true, false)
        end
        -- end

        --英雄和幻象直接添加
        if hSpawnedUnit:IsHero() and hSpawnedUnit:GetTeam() ~= DOTA_TEAM_NEUTRALS then
            Timers:CreateTimer(1, function()
                if IsValid(hSpawnedUnit) then
                    hSpawnedUnit:AddNewModifier(hSpawnedUnit, nil, "modifier_wearable_model", {})
                    local hHero = PlayerResource:GetSelectedHeroEntity(hSpawnedUnit:GetPlayerOwnerID())
                    if IsValid(hHero) and hHero ~= hSpawnedUnit then
                        hHero:RemoveModifierByName("modifier_wearable_model_refresh")
                        hHero:AddNewModifier(hHero, nil, "modifier_wearable_model_refresh",
                            { model = hHero:GetModelName() })
                        hHero:RemoveModifierByName("modifier_wearable_model_refresh")
                    end
                end
            end)

            if hSpawnedUnit:IsRealHero() then
                hSpawnedUnit:AddNewModifier(hSpawnedUnit, nil, "modifier_escape_controller", {})
                if not hSpawnedUnit:IsTempestDouble() then
                    hSpawnedUnit:AddNewModifier(hSpawnedUnit, nil, "modifier_relief_fund", {})
                end
            end
            if hSpawnedUnit:GetUnitName() == "npc_dota_roshan" then
                hSpawnedUnit:AddNewModifier(hSpawnedUnit, nil, "modifier_escape_controller", {})
            end
            local playerID = hSpawnedUnit:GetPlayerOwnerID()
            local hHero = PlayerResource:GetSelectedHeroEntity(playerID)

            if playerID ~= -1 and hHero ~= nil then
                if hHero:HasModifier("modifier_hero_refreshing") then
                    hSpawnedUnit:AddNewModifier(hSpawnedUnit, nil, "modifier_hero_refreshing", {})
                end
            end
        else
            -- if hOwner and hOwner.HasModifier then
            -- 	--剔除雷云、饰品单位等一些特殊
            -- 	if UnitFilter(hSpawnedUnit, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING + DOTA_UNIT_TARGET_OTHER + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, hOwner:GetTeamNumber()) == UF_SUCCESS and hSpawnedUnit:GetUnitName() ~= "npc_dummy_cosmetic_caster" then
            -- 		if hOwner:HasModifier("modifier_hero_refreshing") and hSpawnedUnit:GetUnitName() ~= "npc_dota_zeus_cloud" and hSpawnedUnit:GetUnitName() ~= "npc_dota_thinker" and hSpawnedUnit:GetUnitName() ~= "npc_dota_weaver_swarm" then
            -- 			if hSpawnedUnit then
            -- 				hSpawnedUnit:AddNewModifier(hSpawnedUnit, nil, "modifier_hero_refreshing", {})
            -- 			end
            -- 			-- if hSpawnedUnit and hSpawnedUnit:GetUnitName() == "npc_dota_phoenix_sun" then
            -- 			--	 hSpawnedUnit:AddNewModifier(hSpawnedUnit, nil, "modifier_hero_refreshing", {})
            -- 			-- end
            -- 			-- if hSpawnedUnit and (hSpawnedUnit:GetName() == "npc_dota_brewmaster_storm" or hSpawnedUnit:GetName() == "npc_dota_brewmaster_fire" or hSpawnedUnit:GetName() == "npc_dota_brewmaster_earth") then
            -- 			--	 hSpawnedUnit:AddNewModifier(hSpawnedUnit, nil, "modifier_hero_refreshing", {})
            -- 			-- end
            -- 		end
            -- 	elseif hSpawnedUnit:GetUnitName() == "npc_dota_courier" then
            -- 		hSpawnedUnit:AddNewModifier(hSpawnedUnit, nil, "modifier_hero_refreshing", {})
            -- 	end
            -- end
        end
    end
end

-- function GameMode:SendFeedback(keys)
--	 local nPlayerID = keys.PlayerID
--	 if GameMode.feedbackTime[tonumber(nPlayerID)] >= 1 then
--		 Server:SendFeedback(nPlayerID, keys.text)
--		 GameMode.feedbackTime[tonumber(nPlayerID)] = GameMode.feedbackTime[tonumber(nPlayerID)] - 1
--	 end
-- end

--玩家已读
-- function GameMode:FeedbackRead(keys)
--	 local nPlayerID = keys.PlayerID
--	 if nPlayerID then
--		 Server:FeedbackRead(nPlayerID)
--	 end
-- end

function GameMode:OnDotaItemPurchased(event)
    -- for categoryName, group in pairs(ItemsShouldRecord) do
    --     if group[event.itemname] ~= nil and group[event.itemname] == false then
    --         DataAnchor:RecordItemData(event.itemname, DATA_KEYS.ITEM_BUY, 1)
    --     end
    -- end
end

function GameMode:OnDotaItemCombined(event)
    -- if event.itemname == "item_demonicon" then
    -- 	table.remove_item(ItemLoot.NeutralItemPool[event.PlayerID][tostring(5)], "item_demonicon")
    -- end

    -- for categoryName, group in pairs(ItemsShouldRecord) do
    --     if group[event.itemname] ~= nil and group[event.itemname] == true then
    --         DataAnchor:RecordItemData(event.itemname, DATA_KEYS.ITEM_BUY, 1)
    --     end
    -- end
end

function GameMode:OnPlayerConnectFull(event)

	-- 标记玩家已连接
	if Service.tPlayerConnected == nil then
        Service.tPlayerConnected = {}
    end
	Service.tPlayerConnected[event.PlayerID] = true
	

	if Service.tPlayerLoginConnected == nil then
        Service.tPlayerLoginConnected = {}
    end
    if Service.tPlayerLoginConnected[event.PlayerID] == true then
        return
    end
    Service:CallAction("login", event.PlayerID, {}, function(_, iPlayerID, response)
        Service:CommonCallBack(iPlayerID, response)
        Service.tPlayerLoginConnected[iPlayerID] = true
        local tBody = json.decode(response.Body)
        if tBody and tBody.data and tBody.data.tester == 1 then
            -- _G.Tester[iPlayerID] = true
        end
        Service:CallAction("activity_info", iPlayerID, { activity_id = 1001 })
        Timers:CreateTimer(1, function()
            for _, item_type in pairs(Econ_type) do
                Service:CallAction("item_list", iPlayerID, { item_type = item_type }, function(_, iPlayerID, response)
                    Service:EconCallback(iPlayerID, response, item_type)
                end)
            end
        end)
    end, 3)

	-- local hHero = PlayerResource:GetSelectedHeroEntity(event.PlayerID)
    -- if IsValid(hHero) then
    --     local tBuffs = hHero:FindAllModifiers()
    --     for key, buff in pairs(tBuffs) do
    --         if IsValid(buff) and buff.ForceRefresh and type(buff.ForceRefresh) == "function" then
    --             local hAbility = buff:GetAbility()
    --             if not IsValid(hAbility) then
    --                 buff:ForceRefresh()
    --             end
    --         end
    --     end
    -- end
end

function GameMode:OnDotaInventoryItemAdded(event)
    if IsServer() then
        local hItem = EntIndexToHScript(event.item_entindex)
        local hUnit = EntIndexToHScript(event.inventory_parent_entindex)
        if IsValid(hItem) and IsValid(hUnit) then
            if GANG_LETTER_ITEMS == nil then
                _G.GANG_LETTER_ITEMS = {
                    item_gang_ghost_letter = true,
                    item_gang_dinner_invitation_letter = true,
                    item_gang_gauntlet = true,
                    item_gang_plane_ticket = true,
                }
            end
            local sItemName = hItem:GetAbilityName()
            if GANG_LETTER_ITEMS[sItemName] then
                for i = DOTA_ITEM_SLOT_1, DOTA_ITEM_SLOT_9 do
                    local hSlotItem = hUnit:GetItemInSlot(i)
                    if IsValid(hSlotItem) and GANG_LETTER_ITEMS[hSlotItem:GetAbilityName()] and hSlotItem ~= hItem then
                        hUnit:DropItemAtPositionImmediate(hItem, hUnit:GetAbsOrigin() + hUnit:GetForwardVector() * 100)
                    end
                end
            end
        end
    end
end