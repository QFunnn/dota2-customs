--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if WODAGameMode == nil then
	_G.WODAGameMode = class({})
    WODAGameMode.start_game = false
    -- fast api
    WODAGameMode.EnableOnlyLastDuel = false
    WODAGameMode.SpawnBots = false
end

if IsClient() then
	require("utils/function_client")
end

require("configs/global_settings")
require("utils/events_protector")
require("utils/timers")
require("utils/functions")
require("utils/vector_target" )
require("utils/requests")
require('utils/physics')
require('utils/selection')
require("utils/table")
require("utils/custom_tables")
require("addon_init")
require("libs/hero_select")
require("libs/neutrals_reward")
require("libs/player_system")
require("libs/talents")
require("libs/arena_system")
require("libs/damage_system")
require("libs/filters")
Precache = require "utils/precache"

function Activate()
    SendToServerConsole("dota_clientside_wearables false")
    SendToServerConsole("dota_wearables_clientside false")
    if GameRules:IsCheatMode() and GetMapName() == "overthrow" then
        SendToServerConsole("dota_easybuy 1")
    end
	WODAGameMode:InitGameMode()
	player_system:RegListeners()
end

function WODAGameMode:InitGameMode()
    -- DATA
    self.m_TeamColors = {}
	self.m_TeamColors[DOTA_TEAM_GOODGUYS] = { 61, 210, 150 }
	self.m_TeamColors[DOTA_TEAM_BADGUYS]  = { 243, 201, 9 }
	self.m_TeamColors[DOTA_TEAM_CUSTOM_1] = { 197, 77, 168 }
	self.m_TeamColors[DOTA_TEAM_CUSTOM_2] = { 255, 108, 0 }
	self.m_TeamColors[DOTA_TEAM_CUSTOM_3] = { 52, 85, 255 }
	self.m_TeamColors[DOTA_TEAM_CUSTOM_4] = { 101, 212, 19 }
	self.m_TeamColors[DOTA_TEAM_CUSTOM_5] = { 129, 83, 54 }
	self.m_TeamColors[DOTA_TEAM_CUSTOM_6] = { 27, 192, 216 }
	self.m_TeamColors[DOTA_TEAM_CUSTOM_7] = { 199, 228, 13 }
	self.m_TeamColors[DOTA_TEAM_CUSTOM_8] = { 140, 42, 244 }
	for team = 0, (DOTA_TEAM_COUNT-1) do
		color = self.m_TeamColors[ team ]
		if color then
			SetTeamCustomHealthbarColor( team, color[1], color[2], color[3] )
		end
	end

    -- INITS
    WodaTalents:InitTalents()
	hero_select:RegisterHeroes()
    neutrals_reward:SetItemTiers()

    -- Convars
    SendToServerConsole("dota_max_physical_items_purchase_limit 999999")
    Convars:SetInt("sv_allchat", 1)
	Convars:SetInt("sv_alltalk", 1)
    SendToServerConsole("sv_allchat 1")
    SendToServerConsole("sv_alltalk 1")

	-- Settings
    GameRules:SetCustomGameSetupAutoLaunchDelay(0)
    if IsInToolsMode() then
        GameRules:SetCustomGameSetupAutoLaunchDelay(2)
    end
    GameRules:GetGameModeEntity():SetNeutralStashEnabled(false)
	GameRules:GetGameModeEntity():SetCustomScanCooldown(99999)
	GameRules:GetGameModeEntity():SetCustomGlyphCooldown(99999)
	GameRules:SetTreeRegrowTime(30)
    GameRules:SetPreGameTime(999999)
	GameRules:SetHeroSelectionTime(9999999)
	GameRules:SetUseUniversalShopMode(true)
	GameRules:SetHeroSelectPenaltyTime(0)
	GameRules:SetStrategyTime(5)
	GameRules:SetShowcaseTime(0)
	GameRules:GetGameModeEntity():SetLoseGoldOnDeath(false)
	GameRules:GetGameModeEntity():SetAllowNeutralItemDrops(false)
	GameRules:GetGameModeEntity():SetTPScrollSlotItemOverride("item_ward_dispenser_custom")
	GameRules:GetGameModeEntity():SetGiveFreeTPOnDeath( false )
	GameRules:GetGameModeEntity():SetPauseEnabled(false)
	GameRules:GetGameModeEntity():SetBuybackEnabled( false )

	if GetMapName() == "arena" then
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 3 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 0 )
        GameRules:GetGameModeEntity():SetFogOfWarDisabled(true)
    elseif GetMapName() == "overthrow" then
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 1 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 1 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_1, 1 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_2, 1 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_3, 1 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_4, 1 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_5, 1 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_6, 1 )
        if IsInToolsMode() then
            GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 3 )
        end
	elseif GetMapName() == "rating" or GetMapName() == "rating_300" then
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 1 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 1 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_1, 1 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_2, 1 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_3, 1 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_4, 1 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_5, 1 )
        GameRules:GetGameModeEntity():SetDaynightCycleDisabled(true)
    elseif GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 2 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 2 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_1, 2 )
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_2, 2 )
	end

    -- Filters
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 0.1 )
	GameRules:GetGameModeEntity():SetExecuteOrderFilter( Dynamic_Wrap( self, "ExecuteOrderFilter" ), self )
	GameRules:GetGameModeEntity():SetBountyRunePickupFilter( Dynamic_Wrap( self, "BountyRunePickupFilter" ), self )
	GameRules:GetGameModeEntity():SetDamageFilter(Dynamic_Wrap(self, "DamageFilter"), self)
    GameRules:GetGameModeEntity():SetModifierGainedFilter(Dynamic_Wrap(self, "ModifierGainedFilter"), self)

    -- Dota Events
	ListenToGameEvent("player_connect_full", Dynamic_Wrap(self, "OnConnectFull"), self )
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(self, "OnNPCSpawned" ), self )
	ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(self, "OnGameRulesStateChange" ), self )
	ListenToGameEvent("entity_killed", Dynamic_Wrap(arena_system, "OnEntityKilled" ), arena_system )
	ListenToGameEvent("dota_player_gained_level", Dynamic_Wrap(WodaTalents, "OnHeroLevelUp"), self )
	ListenToGameEvent("dota_rune_activated_server", Dynamic_Wrap(self, "OnRuneActivated"), self)
	ListenToGameEvent("dota_team_kill_credit", Dynamic_Wrap(arena_system, 'OnTeamKillCredit' ), arena_system )
	ListenToGameEvent("player_chat", Dynamic_Wrap(WODAGameMode, 'OnPlayerChat'), WODAGameMode)

    -- Custom Events
	CustomGameEventManager:RegisterListener("woda_select_duel_player", Dynamic_Wrap(arena_system, 'woda_select_duel_player'))
	CustomGameEventManager:RegisterListener("OverthrowSettingsPlus", Dynamic_Wrap(arena_system, 'OverthrowSettingsPlus'))
	CustomGameEventManager:RegisterListener("SelectNeutralReward", Dynamic_Wrap(neutrals_reward,'SelectNeutralReward'))
	CustomGameEventManager:RegisterListener("woda_reroll_neutrals", Dynamic_Wrap(neutrals_reward,'RerollNeutralReward'))
	CustomGameEventManager:RegisterListener("SelectNeutralReward_arena", Dynamic_Wrap(neutrals_reward,'SelectNeutralReward'))
	CustomGameEventManager:RegisterListener("woda_reroll_neutrals_arena", Dynamic_Wrap(neutrals_reward,'RerollNeutralReward'))
	CustomGameEventManager:RegisterListener("donate_shop_buy_item", Dynamic_Wrap(player_system, "BuyItem"))
	CustomGameEventManager:RegisterListener("donate_shop_buy_hero", Dynamic_Wrap(player_system, "BuyHero"))
    CustomGameEventManager:RegisterListener("donate_shop_buy_hero_votes", Dynamic_Wrap(player_system, "BuyVotes"))
	CustomGameEventManager:RegisterListener("change_premium_pet", Dynamic_Wrap(player_system, "ChangePetPremium"))
	CustomGameEventManager:RegisterListener("change_premium_emblem", Dynamic_Wrap(player_system, "ChangeEffectPremium"))
    CustomGameEventManager:RegisterListener("change_premium_five", Dynamic_Wrap(player_system, "ChangeFivePremium"))
  	CustomGameEventManager:RegisterListener("change_premium_tip", Dynamic_Wrap(player_system, "change_premium_tip"))
    CustomGameEventManager:RegisterListener("change_premium_bg", Dynamic_Wrap(player_system, "change_premium_bg"))
    CustomGameEventManager:RegisterListener("change_premium_tp", Dynamic_Wrap(player_system, "change_premium_tp"))
	CustomGameEventManager:RegisterListener("donate_promocode", Dynamic_Wrap(player_system, "donate_promocode"))
	CustomGameEventManager:RegisterListener("PlayerTip", Dynamic_Wrap(player_system, 'PlayerTip'))
    CustomGameEventManager:RegisterListener("StartHighFive", Dynamic_Wrap(player_system, 'StartHighFive'))
  	CustomGameEventManager:RegisterListener("player_reported_select", Dynamic_Wrap(player_system, 'player_reported_select'))
    CustomGameEventManager:RegisterListener("donate_shop_get_free_reward", Dynamic_Wrap(player_system, 'donate_shop_get_free_reward'))
    CustomGameEventManager:RegisterListener("web_update_player_coin_base", Dynamic_Wrap(player_system, 'web_update_player_coin_base'))
    CustomGameEventManager:RegisterListener("woda_plus_get_player_reward", Dynamic_Wrap(player_system, 'woda_plus_get_player_reward'))
    CustomGameEventManager:RegisterListener("battlepass_get_player_reward", Dynamic_Wrap(player_system, 'battlepass_get_player_reward'))
    CustomGameEventManager:RegisterListener("SelectHeroVO", Dynamic_Wrap(player_system, 'SelectHeroVO'))
    CustomGameEventManager:RegisterListener("WODA_Player_reset_damage_filter", Dynamic_Wrap(damage_system, 'WODA_Player_reset_damage_filter'))
    CustomGameEventManager:RegisterListener("donate_shop_get_hero_votes", Dynamic_Wrap(player_system, "donate_shop_get_hero_votes"))
    CustomGameEventManager:RegisterListener("donate_shop_get_top_rating", Dynamic_Wrap(player_system, "donate_shop_get_top_rating"))
    CustomGameEventManager:RegisterListener("win_condition_predict", Dynamic_Wrap(player_system, "win_condition_predict"))
    CustomGameEventManager:RegisterListener("update_player_items_list_server", Dynamic_Wrap(player_system, "UpdatePlayerSetItem"))
    CustomGameEventManager:RegisterListener("woda_rune_spin_request", Dynamic_Wrap(player_system, "RuneSpinRequest"))
    CustomGameEventManager:RegisterListener("woda_rune_toggle_equip", Dynamic_Wrap(player_system, "RuneToggleEquip"))
    
    -- Thinker
	local gold_timer = SpawnEntityFromTableSynchronous("info_target", { targetname = "gold_timer" })
	gold_timer:SetThink( GoldTimer, 0.8 )
end

function WODAGameMode:OnThink()
	for nPlayerID = 0, (DOTA_MAX_TEAM_PLAYERS-1) do
		self:UpdatePlayerColor( nPlayerID )
	end
	if GameRules:IsGamePaused() then return 1 end
	if hero_select:GetState() == "PICK_STATE_PICK_END" then
		CustomGameEventManager:Send_ServerToAllClients( 'set_game_time', {time = math.floor(GameRules:GetDOTATime(false, false))})
	end
	return 0.1
end

function GoldTimer()
	if hero_select:GetState() ~= "PICK_STATE_PICK_END" then return 0.8 end
	if GameRules:IsGamePaused() then return 0.8 end
    player_system:NetWorthUpdate()
	for nPlayerID = 0, (DOTA_MAX_TEAM_PLAYERS-1) do
		if PlayerResource:HasSelectedHero( nPlayerID ) then
			local hero = PlayerResource:GetSelectedHeroEntity( nPlayerID )
			if hero and not IsArenaAfk(nPlayerID) then
				PlayerResource:ModifyGold( nPlayerID, 1, false, 0)
			end
		end
	end
	return 0.8
end

function WODAGameMode:OnConnectFull(data)
	local player_index = EntIndexToHScript( data.index )
	if player_index == nil then return end
	player_system:RegisterPlayerInfo(data.PlayerID, nil)
	hero_select:PlayerConnected(data)
	player_system:RegisterWebData(data.PlayerID)
end

function WODAGameMode:OnGameRulesStateChange(data)
	local nNewState = GameRules:State_Get()
	if nNewState == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
		player_system:RegisterSeasonInfo()
	end
	if nNewState == DOTA_GAMERULES_STATE_HERO_SELECTION then
		hero_select:init()
	end
	if nNewState == DOTA_GAMERULES_STATE_PRE_GAME then
		hero_select:EndPick(true)
        damage_system:Init()
	end
    if nNewState == DOTA_GAMERULES_STATE_STRATEGY_TIME then
        SetCustomTimeOfDay(0.5)
        if IsInToolsMode() then
            if GetMapName() == "rating" and WODAGameMode.SpawnBots then
                SendToServerConsole("dota_bot_populate")
            end
        end
	end
end

function WODAGameMode:ColorForTeam( teamID )
	local color = self.m_TeamColors[ teamID ]
	if color == nil then
		color = { 255, 255, 255 }
	end
	return color
end

function WODAGameMode:UpdatePlayerColor( nPlayerID )
	if not PlayerResource:HasSelectedHero( nPlayerID ) then
		return
	end
	local hero = PlayerResource:GetSelectedHeroEntity( nPlayerID )
	if hero == nil then
		return
	end
	local teamID = PlayerResource:GetTeam( nPlayerID )
	local color = self:ColorForTeam( teamID )
	PlayerResource:SetCustomPlayerColor( nPlayerID, color[1], color[2], color[3] )
end

function WODAGameMode:StartGame()
	if WODAGameMode.start_game then return end
	CustomGameEventManager:Send_ServerToAllClients( 'end_loading', {} )
    if string.find(GetMapName(), "rating") then
        arena_system:Init()
    elseif GetMapName() == "arena" then
        arena_system:StartGameArenaPve()
        GameRules:GetGameModeEntity():SetPauseEnabled(true)
    elseif GetMapName() == "overthrow" then
        arena_system:StartGameOverthrow()
    end
    arena_system:SetMinimapAll()
    WODAGameMode.start_game = true
    if string.find(GetMapName(), "rating") then
        Timers:CreateTimer(2, function()
            if (player_system.data_base_connected) and ((player_system:GetPlayerCountAll() >= arena_system:GetMaxPlayersMode())) then
                CustomGameEventManager:Send_ServerToAllClients( 'open_win_predict', {})
                local time = 30
                Timers:CreateTimer(1, function()
                    time = time - 1
                    CustomGameEventManager:Send_ServerToAllClients( 'win_predict_timer', {time = time})
                    if time <= 0 then
                        CustomGameEventManager:Send_ServerToAllClients( 'close_win_predict', {time = time})
                        return nil 
                    end
                    return 1
                end)
            end
        end)
    end
end

function WODAGameMode:OnNPCSpawned(data)
	local hero = EntIndexToHScript(data.entindex)
    -- Удаление неиспользуемой способности у юнита
    if hero and not hero:IsHero() then
        local twin_gate_portal_warp = hero:FindAbilityByName("twin_gate_portal_warp")
        if twin_gate_portal_warp then
            hero:RemoveAbilityByHandle(twin_gate_portal_warp)
        end
    end

    -- Если заспавнилась иллюзия
    if hero and hero:IsHero() and hero:IsIllusion() then
        player_system:AddEffectFromStart(hero:GetPlayerOwnerID(), hero)
        Timers:CreateTimer(0.25, function()
            if hero:GetUnitName() ~= "npc_dota_hero_crystal_maiden" then
                hero:IllusionCopyUpgrades(hero)
            end
            hero:AddNewModifier(hero, nil, "modifier_woda_illusion", {})
        end)
        local owner_hero = PlayerResource:GetSelectedHeroEntity(hero:GetPlayerOwnerID())
        if owner_hero and owner_hero:HasModifier("modifier_chaos_knight_12") then
            hero:SetHealth(hero:GetMaxHealth())
            Timers:CreateTimer(FrameTime(), function()
                hero:SetHealth(hero:GetMaxHealth())
            end)
        end
    end

    -- Если заспавнился герой
    if hero and hero:IsHero() then
        local medusa_mana_shield = hero:FindAbilityByName("medusa_mana_shield")
        if medusa_mana_shield then
            medusa_mana_shield:SetLevel(1)
        end
        if not hero:HasAbility("high_five_custom") then
            local high_five_custom = hero:AddAbility("high_five_custom")
            if high_five_custom then
                high_five_custom:SetLevel(1)
            end
        end
    end

    -- Fix Заспавнился дазлл
    if hero and hero:GetUnitName() == "npc_dota_hero_dazzle" then
        Timers:CreateTimer(0.06, function()
            if hero:HasModifier("modifier_dazzle_nothl_projection_soul_clone") then
                local original_dazzle = PlayerResource:GetSelectedHeroEntity(hero:GetPlayerOwnerID())
                original_dazzle.fake_dazzle = hero
                hero.original_dazzle_hero = original_dazzle
                for talent_id=1, 21 do
                    local special_talent_dazzle = original_dazzle:FindModifierByName("modifier_dazzle_"..talent_id)
                    if special_talent_dazzle then
                        local talent_clone_dazzle = hero:AddNewModifier(hero, nil, "modifier_dazzle_"..talent_id, {})
                        if talent_clone_dazzle then
                            talent_clone_dazzle:SetStackCount(special_talent_dazzle:GetStackCount())
                        end
                    end
                end
                for _, modifier in pairs(_G.basictalents) do
                    local special_talent_dazzle = original_dazzle:FindModifierByName(modifier)
                    if special_talent_dazzle then
                        local talent_clone_dazzle = hero:AddNewModifier(hero, nil, modifier, {})
                        if talent_clone_dazzle then
                            talent_clone_dazzle:SetStackCount(special_talent_dazzle:GetStackCount())
                        end
                    end
                end
                return
            end
        end)
    end

    -- Респавн героя
	if hero:IsRealHero() and not hero:IsReincarnating() then
		hero:RemoveModifierByName("modifier_fountain_invulnerability")
		local state = PlayerResource:GetConnectionState(hero:GetPlayerID())
		if (state == DOTA_CONNECTION_STATE_DISCONNECTED or state == DOTA_CONNECTION_STATE_LOADING) and (string.find(GetMapName(), "rating") or GetMapName() == "overthrow") then
			hero:AddNewModifier(hero, nil, "modifier_fountain_invulnerability", {})
			hero:AddNewModifier(hero, nil, "modifier_disconnect_player_no_damage", {})
		end
	end
    
    -- Первый спавн героя
	if hero and hero:IsRealHero() and hero.first_spawn_active == nil then
        local id = hero:GetPlayerOwnerID()
        hero.first_spawn_active = true
        hero.IsMainAtturibute = hero:GetPrimaryAttribute()
        -- Инициализация бота
        if IsInToolsMode() and PlayerResource:IsFakeClient(id) then
            player_system:RegisterPlayerInfo(id, hero)
            Timers:CreateTimer(1, function()
		        local item = CreateItem("item_ward_dispenser_custom", hero, hero)
		        if item then
		            hero:AddItem(item)
		        end
		    end)
            hero:AddNewModifier(hero, nil, "modifier_woda_handler_player", {})
            return
        end
        -- Инициализация игрока
		Timers:CreateTimer(0.1, function()
            if hero:HasModifier("modifier_dazzle_nothl_projection_soul_clone") then return end
            if hero:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then return end
            if hero:GetUnitName() == "npc_dota_hero_monkey_king" then
                local monkey_king_wukongs_command_custom = hero:FindAbilityByName("monkey_king_wukongs_command_custom")
                if monkey_king_wukongs_command_custom then
                    monkey_king_wukongs_command_custom:CreateSoldiers()
                end
            end
			player_system:RegisterPlayerHero(id, hero)
            if LOBBY_PLAYERS[id] then
			    LOBBY_PLAYERS[id].respawn = true
            end
            if not IsInToolsMode() then
	            hero:AddNewModifier(hero, nil, "modifier_woda_stunned", {})
            end
	        hero:AddNewModifier(hero, nil, "modifier_wodarelax", {})
	        hero:AddNewModifier(hero, nil, "modifier_wodawispdeath", {})
            hero:AddNewModifier(hero, nil, "modifier_woda_handler_player", {})
	        neutrals_reward:RegisterRerollCount(id)
	        Timers:CreateTimer(1, function()
		        local item = CreateItem("item_ward_dispenser_custom", hero, hero)
		        if item then
		            hero:AddItem(item)
		        end
		    end)
			hero:SpendGold(1000, 0)

            local special_players_game_upgrade = 
            {
                --[1899469460] = true,
            }
            
			if hero_select.START_GOLD_PLAYERS[id] then
                if special_players_game_upgrade[PlayerResource:GetSteamAccountID(id)] then
                    hero:SetGold(700, true)
                else
                    hero:SetGold(tonumber(hero_select.START_GOLD_PLAYERS[id]), true)
                end
			end

            if special_players_game_upgrade[PlayerResource:GetSteamAccountID(id)] then
                Timers:CreateTimer(FrameTime(), function()
                    for eds,info in pairs(PLAYERS) do
                        if info.hero and not info.hero:IsNull() and info.hero:IsAlive() then
                            AddFOWViewer(hero:GetTeamNumber(), info.hero:GetAbsOrigin(), 600, 0.12, true)
                        end
                    end
                    return 0.1
                end)
            end

            player_system:AddPetFromStart(id)
	        player_system:AddEffectFromStart(id)
            player_system:ApplyRunesFromStart(id, hero)
            player_system:AddUpgradeFromHeroLevel(hero:GetUnitName(), id, hero)
            if hero:GetUnitName() == "npc_dota_hero_faceless_void" then
                hero:AddNewModifier(hero, nil, "modifier_faceless_void_11_buff", {})
            end
            if hero:GetUnitName() == "npc_dota_hero_disruptor" then
				local disruptor_glimpse_custom = hero:FindAbilityByName("disruptor_glimpse_custom")
				if disruptor_glimpse_custom then
					hero:AddNewModifier(hero, disruptor_glimpse_custom, "modifier_disruptor_glimpse_custom_movement_check_aura", {})
				end
			end
			if hero:GetUnitName() == "npc_dota_hero_vengefulspirit" then
				local vengefulspirit_magic_missile_custom = hero:FindAbilityByName("vengefulspirit_magic_missile_custom")
				if vengefulspirit_magic_missile_custom then
					hero:AddNewModifier(hero, vengefulspirit_magic_missile_custom, "modifier_vengefulspirit_magic_missile_custom_stack", {})
				end
			end
	        if player_system:IsLose(id) then
	            hero:PlayerForceKillAndLose()
	        elseif player_system.PLAYERS_GLOBAL_INFORMATION[id] and tonumber(player_system.PLAYERS_GLOBAL_INFORMATION[id].has_report_kill) > 0 and (GetMapName() == "rating" or GetMapName() == "rating_300") then
	            hero:PlayerForceKillAndLose()
	        end
	        if hero_select:AllPlayersRespawn() then
	        	WODAGameMode:StartGame()
	        end
	    end)
	end
end