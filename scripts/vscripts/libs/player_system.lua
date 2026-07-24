--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



require("configs/emblems_list")
require("configs/quest_data")
require("configs/pets_list")
require("configs/battlepass_data")
require("configs/runes_list")

if player_system == nil then
    _G.player_system = class({})
    _G.PLAYERS={}
    _G.PLAYERS_NETWORTHS={}
    _G.PLAYERS_NETWORTHS_TEAM={}
    _G.PLAYERS_WEB_DATA = {}
    _G.FREE_HEROES = {}
    _G.DISCONNECT_TIMEOUT_FREE_GAME = 395
    _G.DISCONNECT_FREE = false
    _G.HEROES_LIST_CUSTOM = LoadKeyValues("scripts/npc/npc_heroes_custom.txt")
    player_system.site_url = "data.world-of-dota.com"
    player_system.PLAYERS_GLOBAL_INFORMATION = {}
    player_system.data_base_connected = true
    player_system.SOUNDS_INFO = LoadKeyValues("scripts/chat_wheel_heroes.txt")["hero_messages"]
    player_system.HEROES_VOTES_DATA = {}
    player_system.TOP_RATING_DATA = 
    {
        ["top_rating"] = {},
        ["top_rating_pve"] = {},
        ["top_rating_overthrow"] = {},
    }
    _G.ALL_DONATES_ITEMS_DATA = require("configs/store_data")
end

function player_system:RegListeners()
    ListenToGameEvent( "player_disconnect", Dynamic_Wrap( self, 'OnDisconnect' ), self )
    ListenToGameEvent( "player_reconnected", Dynamic_Wrap( self, 'OnPlayerReconnect'), self)
end

--======================================================= Регистрация игроков и героев ========================================================================

function player_system:RegisterPlayerInfo(id,hero)
	if not IsInToolsMode() then 
		if not PlayerResource:IsValidPlayerID(id) then return end
   		if tostring( PlayerResource:GetSteamAccountID( id ) ) == nil then return end
    	if PlayerResource:GetSteamAccountID( id ) == 0 then return end
    	if PlayerResource:GetSteamAccountID( id ) == "0" then return end
    end

    local playerinfo = PLAYERS[id] or 
    {
    	hero= hero,
    	isduel= false,
    	isduelend= false,
    	losegame= false,
    	place = nil,
    	pause = 31,
    	leave_lose = false,
        teammate_leave = false,
        first_leave = false,
    	boss_kills_pve = 0,
    	partyid = PlayerResource:GetPartyID(id),
    	skip_arena = false,
        duel_streak = 0,
        player_doubled = false,
        current_hero_level = 0,
    }

    PLAYERS[id] = playerinfo
    return playerinfo
end

function player_system:RegisterPlayerHero(id, hero)
	PLAYERS[id].hero = hero
end

--======================================================= Дисконнект ========================================================================

function player_system:OnDisconnect(params)
    local player_id = params.PlayerID
    hero_select:DisconnectPlayer(player_id)
    player_system:LeaveEvent(player_id)
    UpdateDisconnect(player_id)
end    

function player_system:IsDisconnectFree()
    return DISCONNECT_FREE
end

function player_system:DisconnectPlayerChecked(team_check)
    if DISCONNECT_FREE then return end
    if GetMapName() == "rating_300" then
        local low_rate_count = 0
        for player_id, data in pairs(player_system.PLAYERS_GLOBAL_INFORMATION) do
            if data and data.rating < 300 then
                low_rate_count = low_rate_count + 1
            end
        end
        if low_rate_count >= 2 then
            CustomGameEventManager:Send_ServerToAllClients("notification_free_disconnect", {rating = 1})
            DISCONNECT_FREE = true
            return
        end
    end
    local disconnect_count = 0
    local lose_count = 0
    for player_id, player_info in pairs(PLAYERS) do
        if (PlayerResource:GetConnectionState(player_id) ~= nil and (PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_ABANDONED or PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_UNKNOWN )) then
            PLAYERS[player_id].first_leave = true
            disconnect_count = disconnect_count + 1
        end
        if player_info.losegame then
            lose_count = lose_count + 1
        end
    end
    if team_check then
        if lose_count >= 2 then
            CustomGameEventManager:Send_ServerToAllClients("notification_free_disconnect", {lose = 1})
            DISCONNECT_FREE = true
        end
        return
    end
    if disconnect_count >= 2 then
        CustomGameEventManager:Send_ServerToAllClients("notification_free_disconnect", {})
        DISCONNECT_FREE = true
    elseif lose_count >= 2 then
        CustomGameEventManager:Send_ServerToAllClients("notification_free_disconnect", {lose = 1})
        DISCONNECT_FREE = true
    end
end

function player_system:LeaveEvent(player_id)
	local disconnect_timeout = 0
    if not string.find(GetMapName(), "rating") then return end
    if GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
        Timers:CreateTimer({
            useGameTime = false,
            endTime = 0.5,
            callback = function()
            disconnect_timeout = disconnect_timeout + 0.5
            if disconnect_timeout >= 300 and self:GetTeamCountAlive() <= 2 then
                if not player_system:IsLose(player_id) then
                    PLAYERS[player_id].place = self:GetTeamCountAlive()
                end
                if player_system:IsLose(player_id) then
                    PLAYERS[player_id].leave_lose = true
                else
                    if self:GetPlayerCountAll() >= 7 and not GameRules:IsCheatMode() then
                        if player_system:HasLeavedTeammate(player_id) then
                            PLAYERS[player_id].teammate_leave = true
                        elseif not player_system:IsDisconnectFree() then
                            player_system:PlayerBanLeaved(player_id)
                        end
                    end
                end
                player_system:SetLosePlayer(player_id)
                PLAYERS[player_id].pause = 0
                if PLAYERS[player_id].hero ~= nil then
                    PLAYERS[player_id].hero:PlayerForceKillAndLose()
                end
                player_system:CheckOldLastPlayersDuo()
                return nil
            end
            if PlayerResource:GetConnectionState(player_id) ~= nil and (PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_ABANDONED or PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_UNKNOWN ) then
                if not player_system:IsLose(player_id) then
                    PLAYERS[player_id].place = self:GetTeamCountAlive()
                end
                if player_system:IsLose(player_id) then
                    PLAYERS[player_id].leave_lose = true
                else
                    if self:GetPlayerCountAll() >= 7 and not GameRules:IsCheatMode() then
                        if player_system:HasLeavedTeammate(player_id) then
                            PLAYERS[player_id].teammate_leave = true
                        elseif not player_system:IsDisconnectFree() then
                            player_system:PlayerBanLeaved(player_id)
                        end
                    end
                end
                player_system:SetLosePlayer(player_id)
                PLAYERS[player_id].pause = 0
                if PLAYERS[player_id].hero ~= nil then
                    PLAYERS[player_id].hero:PlayerForceKillAndLose()
                end
                player_system:CheckOldLastPlayersDuo()
                return nil
            end
            if PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_CONNECTED then
                  return nil 
              end
            return 0.5
        end})
        return
    end
	Timers:CreateTimer({
		useGameTime = false,
		endTime = 0.5,
		callback = function()
		disconnect_timeout = disconnect_timeout + 0.5
		if disconnect_timeout >= 300 and self:GetPlayerCount() <= 2 then
			if not player_system:IsLose(player_id) then
				PLAYERS[player_id].place = self:GetPlayerCount()
			end
			if player_system:IsLose(player_id) then
				PLAYERS[player_id].leave_lose = true
			else
				if self:GetPlayerCountAll() >= 7 and not GameRules:IsCheatMode() then
                    if not player_system:IsDisconnectFree() then
                        player_system:PlayerBanLeaved(player_id)
                    end
				end
			end
			player_system:SetLosePlayer(player_id)
			PLAYERS[player_id].pause = 0
			if PLAYERS[player_id].hero ~= nil then
				PLAYERS[player_id].hero:PlayerForceKillAndLose()
			end
			player_system:CheckOldLastPlayers()
			return nil
		end
		if PlayerResource:GetConnectionState(player_id) ~= nil and (PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_ABANDONED or PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_UNKNOWN ) then
			if not player_system:IsLose(player_id) then
				PLAYERS[player_id].place = self:GetPlayerCount()
			end
			if player_system:IsLose(player_id) then
				PLAYERS[player_id].leave_lose = true
			else
				if self:GetPlayerCountAll() >= 7 and not GameRules:IsCheatMode() then
                    if not player_system:IsDisconnectFree() then
                        player_system:PlayerBanLeaved(player_id)
                    end
                end
			end
			player_system:SetLosePlayer(player_id)
			PLAYERS[player_id].pause = 0
			if PLAYERS[player_id].hero ~= nil then
				PLAYERS[player_id].hero:PlayerForceKillAndLose()
			end
			player_system:CheckOldLastPlayers()
			return nil
		end
		if PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_CONNECTED then
  			return nil 
  		end
		return 0.5
	end})
end

function player_system:OnPlayerReconnect(params)
    local player_id = params.PlayerID
    local hero_player = PlayerResource:GetSelectedHeroEntity(player_id)
   	if PLAYERS[player_id] and PLAYERS[player_id].hero ~= nil then
		arena_system:SetMinimapPlayer(player_id, 4)
        WodaTalents:UpdateReconnectPoints(player_id)
   		local hero = PLAYERS[player_id].hero
		if hero then
   			hero:SetControllableByPlayer(player_id, true)
        	PlayerResource:GetPlayer(player_id):SetAssignedHeroEntity(hero)
        	hero:SetOwner(PlayerResource:GetPlayer(player_id))
		end
        Timers:CreateTimer(5, function()
	        if hero:HasModifier("modifier_nevermore_2") then
	            local nevermore_righteous_lord = hero:FindAbilityByName("nevermore_righteous_lord")
	            if nevermore_righteous_lord then
	                nevermore_righteous_lord:SetHidden(false)
	            end
	        end
	        local bear_roar = hero:FindAbilityByName("lone_druid_savage_roar_custom")
	        if bear_roar then
	            bear_roar:SetHidden(false)
	        end
            local fillers = FindUnitsInRadius(2, Vector(0,0,0), nil, -1, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
            for _,filler in pairs(fillers) do 
                if filler:GetUnitName() == "npc_filler_woda" then
                    if filler.modifier_capture then
                        filler.modifier_capture:UpdateParticleForPlayer(player_id)
                    end
                end
            end
	    end)
   	end
end

function player_system:HasLeavedTeammate(player_id)
    local get_teammate_id = nil
    for id, info in pairs(PLAYERS) do
        if PlayerResource:GetTeam(id) == PlayerResource:GetTeam(player_id) and id ~= player_id then
            get_teammate_id = id
            break
        end
    end
    if get_teammate_id and PlayerResource:GetConnectionState(get_teammate_id) == DOTA_CONNECTION_STATE_ABANDONED then
        return true
    end
    return false
end

--======================================================= Нетворсы ========================================================================

function player_system:NetWorthUpdate()
    local networth_team = {}

    for id,info in pairs(PLAYERS) do 
    	if info.hero ~= nil then
	        local networths = PlayerResource:GetNetWorth(id)
	        if info.hero and info.hero.book then 
	            networths = networths + (info.hero.book*500)
	        end
	        if info.hero and info.hero.exp_book then 
	            networths = networths + (info.hero.exp_book*350)
	        end
	        if info.hero and info.hero.attribute_book then 
	            networths = networths + (info.hero.attribute_book*500)
	        end
	        if info.hero and info.hero.consumble then
	        	networths = networths + info.hero.consumble
	        end
	        if info.hero and info.hero:HasModifier("modifier_item_royale_with_cheese") then
	        	networths = networths + 4500
	        end

            local get_enchantment = info.hero:GetItemInSlot(17)
            if get_enchantment then
                local tier_counter = neutrals_reward:GetNeutralTier(get_enchantment:GetAbilityName(), get_enchantment:GetLevel())
                networths = networths + (neutrals_reward.NEUTRALS_COST[tier_counter] or 0)
            end

            CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "playernetworths_end", player_id = id, data = {networths=networths}})

	        if info.losegame and info.place then 
	            networths = self:GetPlayerCountAll() - info.place
	        end

	        local networthsinfo = 
	        {
	            id = id,
	            networths = networths,
	            kills = GetTeamHeroKills(info.hero:GetTeamNumber())
	        }

	        PLAYERS_NETWORTHS[id] = networthsinfo

            if networth_team[info.hero:GetTeamNumber()] == nil then
                networth_team[info.hero:GetTeamNumber()] = 0
            end
            networth_team[info.hero:GetTeamNumber()] = networth_team[info.hero:GetTeamNumber()] + networths

            CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "playernetworths", player_id = id, data = {networths=networths}})
	    end
    end

    for team, netw in pairs(networth_team) do
        local information = 
        {
            teamnumber = team,
            networths = netw,
            kills = GetTeamHeroKills(team)
        }
        PLAYERS_NETWORTHS_TEAM[team] = information
        CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "playernetworths_team", player_id = team, data = {networths=netw}})
    end

    if GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
        player_system:GetPlayerLastNetworthsTeam()
    else
        player_system:GetPlayerLastNetworths()
    end
end

function player_system:GetPlayerLastNetworths()
	local playerstable = {}
	for _,info in pairs(PLAYERS_NETWORTHS) do 
		table.insert(playerstable, info)
	end
	
	for count = #playerstable, 1, -1 do
        if playerstable[count] and (self:IsLose(playerstable[count].id) or PlayerResource:GetConnectionState(playerstable[count].id) == DOTA_CONNECTION_STATE_ABANDONED)  then
            table.remove(playerstable, count)
        end
    end
    
	table.sort(playerstable, function(x,y) return y.networths < x.networths end)

	local result = {}

	result[1] = playerstable[#playerstable]
	result[2] = playerstable[#playerstable-1]
	
	if not arena_system:DuelActive() then
		CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "duelplayers", data = result})
	end

	return result
end

function player_system:GetPlayerLastNetworthsTeam()
	local playerstable = {}

	for _, info in pairs(PLAYERS_NETWORTHS_TEAM) do
        info.players = {}
		table.insert(playerstable, info)
	end

    for _, info in pairs(playerstable) do
        for id,pinfo in pairs(PLAYERS) do 
            if pinfo.hero ~= nil then
                if pinfo.hero:GetTeamNumber() == info.teamnumber then
                    table.insert(playerstable[_].players, id)
                end
            end
        end
    end
	
	for count = #playerstable, 1, -1 do
        if playerstable[count] then
            local team_is_lose = true
            for _, team_player in pairs(playerstable[count].players) do
                if (not self:IsLose(team_player) and PlayerResource:GetConnectionState(team_player) ~= DOTA_CONNECTION_STATE_ABANDONED) then
                    team_is_lose = false
                end
            end
            if team_is_lose then
                table.remove(playerstable, count)
            end
        end
    end
    
	table.sort(playerstable, function(x,y) return y.networths < x.networths end)

	local result = {}
	result[1] = playerstable[#playerstable]
	result[2] = playerstable[#playerstable-1]
	
	if not arena_system:DuelActive() then
		CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "duelplayers", data = result})
	end

	return result
end

function player_system:GetPlayerTopNetworths()
	local playerstable = {}

	for _,info in pairs(PLAYERS_NETWORTHS) do 
		table.insert(playerstable, info)
	end

	for count = #playerstable, 1, -1 do
        if playerstable[count] and self:IsLose(playerstable[count].id) then
            table.remove(playerstable, count)
        end
    end

	table.sort(playerstable, function(x,y) return y.networths < x.networths end)

	local result = {}

	table.insert(result, playerstable[1])
	table.insert(result, playerstable[2])

	return result
end

function player_system:GetPlayerPositionNetworths(player_id)
	local playerstable = {}

	for _,info in pairs(PLAYERS_NETWORTHS) do 
		table.insert(playerstable, info)
	end

	table.sort(playerstable, function(x,y) return y.networths < x.networths end)

	for pid,player in pairs(playerstable) do
		if player.id == player_id then
			return pid
		end
	end
end

function player_system:GetPlayerPositionKills(player_id)
	local playerstable = {}

	for _, info in pairs(PLAYERS_NETWORTHS) do 
		table.insert(playerstable, info)
	end

	table.sort(playerstable, function(x,y) return y.kills < x.kills end)

	for pid,player in pairs(playerstable) do
		if player.id == player_id then
			return pid
		end
	end
end

function player_system:GetPlayerPositionLevels(player_id)
	local playerstable = {}

	for ids,info in pairs(PLAYERS) do
		if info.hero ~= nil then
			local inf = info
			inf.id = ids
			table.insert(playerstable, inf)
		end
	end

	table.sort(playerstable, function(x,y) return y.hero:GetLevel() < x.hero:GetLevel() end)

	for pid,player in pairs(playerstable) do
		if player.id == player_id then
			return pid
		end
	end
end

--======================================================= Функции отвечающие за проигрыш вижен итд ========================================================================

function player_system:LoseVision(id)
	Timers:CreateTimer(FrameTime(), function()
		local hasparty = false
		for eds,info in pairs(PLAYERS) do
			if info.partyid == PLAYERS[id].partyid and eds ~= id then 
				hasparty = true 
			end
		end
		for eds,info in pairs(PLAYERS) do
			if hasparty and (GetMapName() == "rating" or GetMapName() == "rating_300") then 
				if info.partyid == PLAYERS[id].partyid and info.hero and info.hero:IsAlive() then 
					AddFOWViewer(PLAYERS[id].hero:GetTeamNumber(), info.hero:GetAbsOrigin(), 1800, 0.12, true)
				end
			else
				if info.hero and info.hero:IsAlive() then 
					AddFOWViewer(PLAYERS[id].hero:GetTeamNumber(), info.hero:GetAbsOrigin(), 1800, 0.12, true)
				end
			end
		end
		return 0.1
	end)
end

function player_system:SetLose(id)
	if (8 - player_system:GetPlayerCount() ) < arena_system:GetArena() then
		if self:GetPlayerCountAll() >= 7 and not GameRules:IsCheatMode() and ( player_system.PLAYERS_GLOBAL_INFORMATION[id] and player_system.PLAYERS_GLOBAL_INFORMATION[id].last_leave == 1 ) then
			player_system:PlayerUnBanLeaved(id)
		end
		PLAYERS[id].place = self:GetPlayerCount()
		player_system:SetLosePlayer(id)
		PLAYERS[id].pause = 0
	    PLAYERS[id].hero:PlayerForceKillAndLose()
		player_system:LoseVision(id)
		CustomGameEventManager:Send_ServerToAllClients("notification_duel_lose", {id = id, heroname = PLAYERS[id].hero:GetUnitName()})
	else
		local teleport_point=Entities:FindByName(nil,"relaxarena")
		if teleport_point then 
			PLAYERS[id].hero:ResetHealthAndMana()
			PLAYERS[id].hero:ResetCooldown()
			Timers:CreateTimer({ endTime = 0.07, 
            callback = function()
				PLAYERS[id].hero:RemoveModifierByName("modifier_wodaduel1")
				PLAYERS[id].hero:AddNewModifier(PLAYERS[id].hero, nil, "modifier_wodarelax", {})
				FindClearSpaceForUnit(PLAYERS[id].hero, teleport_point:GetAbsOrigin(), true)
				PLAYERS[id].hero:SetCamera(info.hero)
                PLAYERS[id].hero:AddNewModifier(PLAYERS[id].hero, nil, "modifier_wodarelax_invul", {duration = 2})
                local wardmodifier = PLAYERS[id].hero:FindModifierByName("modifier_item_ward_dispenser_custom_ward")
                if wardmodifier then
                    wardmodifier:GetAbility():SetCurrentCharges(3)
                    wardmodifier:GetAbility():SetSecondaryCharges(3)
                end
                if PLAYERS[id].hero and PLAYERS[id].hero.fake_dazzle then
                    local wardmodifier_dazzle = PLAYERS[id].hero.fake_dazzle:FindModifierByName("modifier_item_ward_dispenser_custom_ward")
                    if wardmodifier_dazzle then
                        wardmodifier_dazzle:GetAbility():SetCurrentCharges(3)
                        wardmodifier_dazzle:GetAbility():SetSecondaryCharges(3)
                    end
                end
	        end})
		end
	end
end

function player_system:CheckOldLastPlayers()
    local end_fast_game = false
	if GetMapName() ~= "arena" then
		if player_system:GetPlayerCount() <= 1 and player_system:GetPlayerCountAll() > 1 then
			for id, info in pairs(PLAYERS) do
				if info.losegame == false then
					end_fast_game = true
                    break
				end
			end
		end
	end
    if end_fast_game then
        Timers:CreateTimer(1, function()
            arena_system:CloseAndEndGame()
        end)
    end
end

function player_system:CheckOldLastPlayersDuo()
    local end_fast_game = false
	if GetMapName() ~= "arena" then
		if player_system:GetTeamCountAlive() <= 1 and player_system:GetPlayerCountAll() > 1 then
			for id, info in pairs(PLAYERS) do
				if info.losegame == false then
					end_fast_game = true
                    break
				end
			end
		end
	end
    if end_fast_game then
        Timers:CreateTimer(1, function()
            arena_system:CloseAndEndGame()
        end)
    end
end

function player_system:SetLoseDuo(id)
	if arena_system:IsLoseDuel() then
		if self:GetPlayerCountAll() >= 7 and not GameRules:IsCheatMode() and ( player_system.PLAYERS_GLOBAL_INFORMATION[id] and player_system.PLAYERS_GLOBAL_INFORMATION[id].last_leave == 1 ) then
			player_system:PlayerUnBanLeaved(id)
		end
		PLAYERS[id].place = self:GetTeamCountAlive()
		player_system:SetLosePlayer(id)
		PLAYERS[id].pause = 0
	    PLAYERS[id].hero:PlayerForceKillAndLose()
		player_system:LoseVision(id)
		CustomGameEventManager:Send_ServerToAllClients("notification_duel_lose_duo", {id = id, heroname = PLAYERS[id].hero:GetUnitName()})
	else
		local teleport_point=Entities:FindByName(nil,"relaxarena")
		if teleport_point then 
			PLAYERS[id].hero:ResetHealthAndMana()
			PLAYERS[id].hero:ResetCooldown()
			Timers:CreateTimer({ endTime = 0.07, 
            callback = function()
				PLAYERS[id].hero:RemoveModifierByName("modifier_wodaduel_duo")
				PLAYERS[id].hero:AddNewModifier(PLAYERS[id].hero, nil, "modifier_wodarelax", {})
				FindClearSpaceForUnit(PLAYERS[id].hero, teleport_point:GetAbsOrigin(), true)
				PLAYERS[id].hero:SetCamera(info.hero)
	        end})
		end
	end
end



--======================================================= Рейтинг ========================================================================

function player_system:RegisterWebData(player_id)
    if not PlayerResource:IsValidPlayerID(player_id) then return end
    if tostring( PlayerResource:GetSteamAccountID( player_id ) ) == nil then return end
    if PlayerResource:GetSteamAccountID( player_id ) == 0 then return end
    if PlayerResource:GetSteamAccountID( player_id ) == "0" then return end

    local set_data = function(data, id)

    	if data == nil then
    		player_system.data_base_connected = false
    		data = 
    		{
    			rating = {},
    			pve_rating = {},
    			overthrow_rating = {},
    			rating_history = {},
    			players_reported = {},
    			reports = {},
    			last_leave = 0,
    			has_report_random = 0,
    			has_report_kill = 0,
    			tips = {},
                free_reward = 1,
                donate_coins = 0,
                double_tokens = 0,
                runes = {},
                equipped_runes = {},

                -- Battlepass 2025
                has_battlepass = 0,
                battlepass_level = 0,
                battlepass_coins = 0,

                -- Battlepass 2026
                has_battlepass_2026 = 0,
                battlepass_level_2026 = 0,
                battlepass_coins_2026 = 0,

                game_time = 0,
                heroes_level = 
                {
                    {["hero"] = "npc_dota_hero_pudge", ["coins"] = 50000},
                    {["hero"] = "npc_dota_hero_sniper", ["coins"] = 300},
                    {["hero"] = "npc_dota_hero_drow", ["coins"] = 600},
                    {["hero"] = "npc_dota_hero_riki", ["coins"] = 900},
                    {["hero"] = "npc_dota_hero_juggernaut", ["coins"] = 1200},
                    {["hero"] = "npc_dota_hero_axe", ["coins"] = 2500},
                },
                quest_data = {},
    		}
    	end

        local fixed_quest_data = {}
        for quest_id, quest_value in pairs(data.quest_data) do
            fixed_quest_data[tonumber(quest_id)] = quest_value
        end

        local new_player_information = 
        {
        	steamid = PlayerResource:GetSteamAccountID(id),
        	crystals = tonumber(data.crystals) or 0,
        	coins = tonumber(data.coins) or 0,
        	plus_days = tonumber(data.plus_days) or 0,
        	rating_history = data.rating_history,
        	rating = data.rating[#data.rating] or 300,
        	pve_rating = data.pve_rating[#data.rating] or 0,
        	overthrow_rating = data.overthrow_rating[9] or 0,
        	donate_heroes = data.donate_heroes or {},
        	donate_items = data.donate_items or {},
        	pet_id = tonumber(data.pet_default) or 0,
            five_id = tonumber(data.five_id) or 0,
        	effect_id = tonumber(data.effect_default) or 0,
            background_id = tonumber(data.background_id) or 0,
            teleport_id = tonumber(data.teleport_id) or 0,
        	games = tonumber(data.games) or 0,
        	place = data.place or {0,0,0,0,0,0,0,0,0},
            place_duo = data.place_duo or {0,0,0,0,0,0,0,0,0},
        	talents_stats = data.talents_stats or {0,0,0},
        	top_heroes = data.top_heroes or {},
        	last_leave = tonumber(data.last_leave) or 0,
        	reports = data.reports or {},
        	players_repoted = {},
        	has_report_random = 0,
    		has_report_kill = 0,
    		tips = data.tips or {},
			heroes_level = data.heroes_level or {},
            free_reward = data.free_reward or 1,
            donate_coins = data.donate_coins or 0,

            -- Battlepass 2025
            battlepass_level = tonumber(data.battlepass_level) or 0,
            battlepass_coins = tonumber(data.battlepass_coins) or 0,
            has_battlepass = tonumber(data.has_battlepass) or 0,

            -- Battlepass 2026
            has_battlepass_2026 = tonumber(data.has_battlepass_2026) or 0,
            battlepass_level_2026 = tonumber(data.battlepass_level_2026) or 0,
            battlepass_coins_2026 = tonumber(data.battlepass_coins_2026) or 0,

            double_tokens = tonumber(data.double_tokens) or 0,
            runes = data.runes or {},
            equipped_runes = data.equipped_runes or {},
            game_time = tonumber(data.game_time) or 0,
            --
            quest_data = fixed_quest_data or {},
            quest_current_data = {},
        }

        if IsInToolsMode() then
        	new_player_information.crystals = 350000
			new_player_information.coins = 350000
            new_player_information.plus_days = 99999
            new_player_information.has_battlepass = 1
            new_player_information.battlepass_level = 100
            new_player_information.game_time = 100
            new_player_information.double_tokens = 100

            new_player_information.battlepass_level_2026 = 11
            new_player_information.battlepass_coins_2026 = 15
            new_player_information.has_battlepass_2026 = 1
            new_player_information.rating = 1000
    	end

        player_system.PLAYERS_GLOBAL_INFORMATION[id] = new_player_information

        CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "reported_info", player_id = id, data = {reported_info = new_player_information.players_repoted}})

        CustomTables:SetTableValue('woda_player_data', tostring(id), new_player_information)

        if hero_select:GetState() ~= "PICK_STATE_PICK_PRE_END" and hero_select:GetState() ~= "PICK_STATE_PICK_END" then
        	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "update_buy_heroes_from_lua", {} )
        end

        Timers:CreateTimer(3, function()
            player_system:UpdatePlayerBPLevelsHero(id)
        end)

        Timers:CreateTimer(1, function()
            if IsInToolsMode() or new_player_information.games >= 1 then
                CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "event_woda_open_links", {})
                if GameRules:State_Get() == DOTA_GAMERULES_STATE_HERO_SELECTION then return end
                return 1
            end
        end)
    end 

    CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "tip_cooldown", player_id = player_id, data = {cooldown = 0}})
    
    RequestData('https://' ..player_system.site_url .. '/data/get_player_data.php?steamid=' .. PlayerResource:GetSteamAccountID(player_id) .. '&token=' .. GetDedicatedServerKeyV3('woda'), function(data) set_data(data, player_id) end)
end

function player_system:RegisterSeasonInfo()
	RequestData('https://' ..player_system.site_url .. '/data/get_free_donate_heroes.php', function(data) player_system.SetFreeDonateHeroes(data) end)
	RequestData('https://' ..player_system.site_url .. '/data/get_top_rating_150.php', function(data) player_system.SetTopMmr(data) end)
	RequestData('https://' ..player_system.site_url .. '/data/get_top_rating_pve_arena.php', function(data) player_system.SetTopMmrPVE(data) end)
	RequestData('https://' ..player_system.site_url .. '/data/get_top_donaters.php', function(data) player_system.SetTopMmrOverthrow(data) end)
    RequestData('https://' ..player_system.site_url .. '/data/get_heroes_votes.php', function(data) player_system.SetVotesHeroesInfo(data) end)
end  

function player_system.SetFreeDonateHeroes(data)
    CustomTables:SetTableValue('custom_pick', 'donate_heroes_free', data)     
    FREE_HEROES = data   
end

function player_system.SetTopMmr(data)
    player_system.TOP_RATING_DATA["top_rating"] = data      
end

function player_system.SetTopMmrPVE(data)
    player_system.TOP_RATING_DATA["top_rating_pve"] = data      
end

function player_system.SetTopMmrOverthrow(data)
    player_system.TOP_RATING_DATA["top_rating_overthrow"] = data      
end

function player_system.SetVotesHeroesInfo(data)
    player_system.HEROES_VOTES_DATA = data       
end

function player_system:BuyVotes(data)
    if data.PlayerID == nil then return end
	local id = data.PlayerID
	local hero_name = data.hero_name
	local votes = tonumber(data.votes)
    if votes == nil or votes <= 0 or votes % 1 ~= 0 then
        return
    end
	local player =	PlayerResource:GetPlayer(id)
	local player_donate_table = player_system.PLAYERS_GLOBAL_INFORMATION[id]
    if not player_system.data_base_connected then return end
    if GameRules:IsCheatMode() then return end

    local UpdateHeroesVotes = function(data)
        if data ~= nil then
            local change_valute_crystall = 0
            local chance_valute_coins = 0
            local current_hero_votes = -1

            -- Проверка на количество голосов
            if data then
                for _, hero_check in pairs(data) do
                    if hero_check and hero_check["hero_name"] == hero_name then
                        current_hero_votes = hero_check["votes"]
                        break
                    end
                end
            end

            if current_hero_votes == -1 then
                CustomGameEventManager:Send_ServerToPlayer(player, "shop_error_notification", {error_name = "shop_error_no_hero_data", } )
                player_system.HEROES_VOTES_DATA = data
                return
            end
        
            if current_hero_votes + votes > 450000 then
                CustomGameEventManager:Send_ServerToPlayer(player, "shop_error_notification", {error_name = "shop_error_more_votes", } )
                player_system.HEROES_VOTES_DATA = data
                return
            end

            -- Ошибки недостаточно валюты
            if tonumber(player_donate_table.coins) < tonumber(votes) then
                CustomGameEventManager:Send_ServerToPlayer(player, "shop_error_notification", {error_name = "shop_error_no_coins", } )
                player_system.HEROES_VOTES_DATA = data
                return
            else
                if player_donate_table then
                    player_donate_table.coins = player_donate_table.coins - tonumber(votes)
                    chance_valute_coins = tonumber(votes) * -1
                end
            end

            if data then
                for _, hero_check in pairs(data) do
                    if hero_check and hero_check["hero_name"] == hero_name then
                        hero_check["votes"] = hero_check["votes"] + votes
                        break
                    end
                end
            end

            CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)
            CustomGameEventManager:Send_ServerToPlayer(player, "shop_set_currency", {crystall = player_donate_table.crystals, coin = player_donate_table.coins, plus_days = player_donate_table.plus_days, } )
            CustomGameEventManager:Send_ServerToPlayer(player, "shop_accept_notification", {} )
            player_system.HEROES_VOTES_DATA = data

            local post_data = 
            {
                player = {
                    {
                        steamid = PlayerResource:GetSteamAccountID(id),
                        player_crystall = change_valute_crystall,
                        player_coin = chance_valute_coins,
                        hero_name = tostring(hero_name),
                        votes = tonumber(votes),
                    }
                },
            }

            SendData('https://' ..player_system.site_url .. '/data/buy_hero_votes_server.php', post_data, nil)
        else
            CustomGameEventManager:Send_ServerToPlayer(player, "shop_error_notification", {error_name = "shop_error_no_hero_data", } )
        end
    end

    RequestData('https://' ..player_system.site_url .. '/data/get_heroes_votes.php', function(data) UpdateHeroesVotes(data) end)
end

function player_system:GetReportSystemRandom(data, pid)
    if not string.find(GetMapName(), "rating") then return 0 end
	for id, player_info in pairs(player_system.PLAYERS_GLOBAL_INFORMATION) do
		if id ~= pid then
		   	for _, info in pairs(data) do
		   		if tostring(info.player_1) == tostring(player_info.steamid) then
		   			return info.days_random
		   		end
		   		if tostring(info.player_2) == tostring(player_info.steamid) then
		   			return info.days_random
		   		end
		   	end
		end
	end
   	return 0
end

function player_system:GetReportSystemKill(data)
    if not string.find(GetMapName(), "rating") then return 0 end
    for id, player_info in pairs(player_system.PLAYERS_GLOBAL_INFORMATION) do
		if id ~= pid then
		   	for _, info in pairs(data) do
		   		if tostring(info.player_1) == tostring(player_info.steamid) then
		   			return info.days_kill
		   		end
		   		if tostring(info.player_2) == tostring(player_info.steamid) then
		   			return info.days_kill
		   		end
		   	end
		end
	end   
end

function player_system:UpdateReportsInfo()
	for id, player_info in pairs(player_system.PLAYERS_GLOBAL_INFORMATION) do
		player_system.PLAYERS_GLOBAL_INFORMATION[id].has_report_random = player_system:GetReportSystemRandom(player_info.reports, id)
		player_system.PLAYERS_GLOBAL_INFORMATION[id].has_report_kill = player_system:GetReportSystemRandom(player_info.reports, id)
		CustomTables:SetTableValue('woda_player_data', tostring(id), player_system.PLAYERS_GLOBAL_INFORMATION[id])
	end
end

function player_system:SendDataToServer()
	if GameRules:IsCheatMode() and not IsInToolsMode() then return end
	if player_system:GetPlayerCountAll() >= 7 or IsInToolsMode() then
	    local post_data = 
	    { 
	        players = {}
	    }

	    for id, player_info in pairs(player_system.PLAYERS_GLOBAL_INFORMATION) do
	        local player_table = 
	        {
	            steamid = player_info.steamid,
	            coins = player_system:GetCoinsPlace(id),
	            rating = player_system:GetRatingPlace(id),
	            pet_id = player_info.pet_id or 0,
	            effect_id = player_info.effect_id or 0,
                five_id = player_info.five_id or 0,
                background_id = player_info.background_id or 0,
                teleport_id = player_info.teleport_id or 0,
	            tips = player_info.tips or {},
                game_time = math.floor(GameRules:GetDOTATime(false, false) / 60),
	        }
	        table.insert(post_data.players, player_table)
	    end
	    SendData('https://' ..player_system.site_url .. '/data/player_data_upload.php', post_data, nil)
	end
end

function player_system:SendDataToServerPVE()
	if GameRules:IsCheatMode() and not IsInToolsMode() then return end
	
    local post_data =
    { 
        players = {}
    }
    for id, player_info in pairs(player_system.PLAYERS_GLOBAL_INFORMATION) do
        local hero_name = ""
        if PLAYERS[id] and PLAYERS[id].hero ~= nil then
            hero_name = PLAYERS[id].hero:GetUnitName()
        end
        local player_table =
        {
            steamid = player_info.steamid,
            coins = player_system:GetCoinsPlacePve(id),
            pve_rating = player_system:GetRatingPlacePve(id),
            pet_id = player_info.pet_id or 0,
            effect_id = player_info.effect_id or 0,
            five_id = player_info.five_id or 0,
            background_id = player_info.background_id or 0,
            teleport_id = player_info.teleport_id or 0,
            tips = player_info.tips or {},
            players_count = player_system:GetPlayerCountAll(),
            hero = hero_name,
            game_time = math.floor(GameRules:GetDOTATime(false, false) / 60),
        }
        if GetMapName() == "arena" then
            player_table.equipped_runes = player_info.equipped_runes or {}
        end
        table.insert(post_data.players, player_table)
    end

    SendData('https://' ..player_system.site_url .. '/data/player_data_upload_arena_pve.php', post_data, nil)
end

function player_system:SendDataToServerOverthrow()
	if GameRules:IsCheatMode() and not IsInToolsMode() then return end
	
    local post_data = 
    { 
        players = {}
    }

    for id, player_info in pairs(player_system.PLAYERS_GLOBAL_INFORMATION) do
        local player_table = 
        {
            steamid = player_info.steamid,
            coins = player_system:GetCoinsPlaceOverthrow(id),
            pve_rating = player_system:GetRatingPlaceOverthrow(id),
            pet_id = player_info.pet_id or 0,
            five_id = player_info.five_id or 0,
            effect_id = player_info.effect_id or 0,
            background_id = player_info.background_id or 0,
            teleport_id = player_info.teleport_id or 0,
            tips = player_info.tips or {},
            game_time = math.floor(GameRules:GetDOTATime(false, false) / 60),
        }
        table.insert(post_data.players, player_table)
    end

    SendData('https://' ..player_system.site_url .. '/data/player_data_upload_arena_overthrow.php', post_data, nil)
end

player_system.Coins_Table_overthrow  =
{
	[1] = 7,
	[2] = 6,
	[3] = 5,
	[4] = 4,
	[5] = 4,
	[6] = 4,
	[7] = 4,
	[8] = 4,
}

player_system.Rating_Table_overthrow = 
{
	[1] = 20,
	[2] = 15,
	[3] = 10,
	[4] = 5,
	[5] = 0,
	[6] = -5,
	[7] = -10,
	[8] = -15,
}

function player_system:GetCoinsPlaceOverthrow(id)
	
	--Если чел ливнул ( проверка на лив до конца игры или после )
	if PlayerResource:GetConnectionState(id) == DOTA_CONNECTION_STATE_ABANDONED then
		CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "coins_end", player_id = id, data = {coin = 0}})
		return 0
	end

	local get_team_place = 
    function(t)
		local teams = {}

		for team_n, kills in pairs(OVERTHROW_KILLS_COUNT_TEAM) do
	        table.insert(teams, {id = team_n, kills = kills} )
	    end

	    table.sort( teams, function(x,y) return y.kills < x.kills end )

        for i = 1, #teams do
            if teams[i].id == t then
                return i
            end    
        end    
    end

    local place = get_team_place(PlayerResource:GetTeam(id))  

    -- Если у человека нет места каким-то образом то пусть пока будет 0
	if place == nil then 
		CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "coins_end", player_id = id, data = {coin = 0}})
		return 0 
	end  

    local coin = player_system.Coins_Table_overthrow[place]
    local player_hero = player_system:GetHero(id)
    if player_hero and not player_hero:IsNull() then
        if PLAYERS[id] and PLAYERS[id].current_hero_level >= 30 then
            coin = coin + 1
        end
    end
	if player_system:HasSubscribePlus(id) then
        coin = math.floor(coin * 2)
    end

    if player_system:GetPlayerCountAll() < arena_system:GetMaxPlayersMode() then
		return 0
	end

    CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "coins_end", player_id = id, data = {coin = coin}})
    return coin
end

function player_system:GetRatingPlaceOverthrow(id)
	CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "rating_end", player_id = id, data = {rating = 0}})
	return 0
end

function player_system:GetCoinsPlacePve(id)
	local coin = PLAYERS[id].boss_kills_pve
    local player_hero = player_system:GetHero(id)
    if player_hero and not player_hero:IsNull() then
        if PLAYERS[id] and PLAYERS[id].current_hero_level >= 30 then
            coin = coin + 1
        end
    end
	if arena_system:GetPveWavesComplete() >= 10 then
		coin = coin + (math.floor(arena_system:GetPveWavesComplete() / 10 ))
	end
	if player_system:HasSubscribePlus(id) then
        coin = math.floor(coin * 2)
    end
    CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "coins_end", player_id = id, data = {coin = coin}})
    return coin
end

function player_system:GetRatingPlacePve(id)
	local rating = arena_system:GetPveWavesComplete()
	CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "rating_end", player_id = id, data = {rating = rating}})
	return rating
end

function player_system:SendDataPlayersHeroStats()
    if GameRules:IsCheatMode() and not IsInToolsMode() then return end
	if player_system:GetPlayerCountAll() >= 7 or IsInToolsMode() or GetMapName() == "arena" then
	    local post_data = 
	    { 
	        players = {}
	    }
        
	    for id, player_info in pairs(player_system.PLAYERS_GLOBAL_INFORMATION) do
	    	local hero_name = "undefined"
	    	local talents_str = 0
	    	local talents_agi = 0
	    	local talents_int = 0
	    	local place = 0
	    	local leave = 0
            local games = 1
			
			if PLAYERS[id] then
				if PLAYERS[id].hero then
					hero_name = PLAYERS[id].hero:GetUnitName()
				end
				if string.find(GetMapName(), "rating") then
					if PLAYERS[id].place ~= nil then
						place = PLAYERS[id].place
					end
				end
				if PlayerResource:GetConnectionState(id) and PlayerResource:GetConnectionState(id) == DOTA_CONNECTION_STATE_ABANDONED then
					if PLAYERS[id].leave_lose ~= true then
						leave = 1
					end
				end
			end
			
			if GetMapName() == "overthrow" then
				place = 0
                games = 0
                leave = 0
			end

			if GetMapName() == "arena" then
				place = 0
                games = 0
                leave = 0
			end

    		if WodaTalents.playerstalents[id] then
    			if WodaTalents.playerstalents[id]["str"] then
    				talents_str = WodaTalents.playerstalents[id]["str"]
    			end
    			if WodaTalents.playerstalents[id]["agi"] then
    				talents_agi = WodaTalents.playerstalents[id]["agi"]
    			end
    			if WodaTalents.playerstalents[id]["int"] then
    				talents_int = WodaTalents.playerstalents[id]["int"]
    			end
    		end

			local coins = 0
			
			if GetMapName() == "overthrow" then
				coins = player_system:GetCoinsPlaceOverthrow(id)
			elseif GetMapName() == "arena" then
				coins = player_system:GetCoinsPlacePve(id)
			elseif string.find(GetMapName(), "rating") then
				coins = player_system:GetCoinsPlace(id)
			end

	        local player_table = 
	        {
	            steamid = player_info.steamid,
	            hero_name = hero_name,
	            games = games,
	            talents_str = talents_str,
				talents_agi = talents_agi,
				talents_int = talents_int,
				place = tonumber(place),
				leave = leave,
				coins = coins,
                is_arena = GetMapName() == "arena" and 1 or 0,
                is_duo = (GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300") and 1 or 0,
	        }

	        table.insert(post_data.players, player_table)
	    end

	    SendData('https://' ..player_system.site_url .. '/data/player_heroinfo_upload.php', post_data, nil)
	end
end

player_system.Coins_Table = 
{
	[1] = 8,
	[2] = 7,
	[3] = 6,
	[4] = 5,
	[5] = 4,
	[6] = 3,
	[7] = 2,
	[8] = 1,
}

player_system.Rating_Table = 
{
	[1] = 20,
	[2] = 15,
	[3] = 10,
	[4] = 5,
	[5] = 0,
	[6] = -5,
	[7] = -10,
	[8] = -15,
}

if GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
    player_system.Rating_Table = 
    {
        [1] = 15,
        [2] = 5,
        [3] = 0,
        [4] = -10,
    }
end

function player_system:GetCoinsPlace(id)
	local place = PLAYERS[id].place

	if player_system:GetPlayerCountAll() < arena_system:GetMaxPlayersMode() then
		return 0
	end

    if player_system:IsDisconnectFree() then
        return 0
    end

	--Если чел ливнул ( проверка на лив до конца игры или после )
	if PlayerResource:GetConnectionState(id) == DOTA_CONNECTION_STATE_ABANDONED then
        if PLAYERS[id].teammate_leave then
            CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "coins_end", player_id = id, data = {coin = 0}})
			return 0
        end
		if not PLAYERS[id].leave_lose then
			CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "coins_end", player_id = id, data = {coin = 0}})
			return 0
		end
	end

	if player_system.PLAYERS_GLOBAL_INFORMATION[id] and (GetMapName() == "rating" or GetMapName() == "rating_300") then
		if player_system.PLAYERS_GLOBAL_INFORMATION[id].has_report_random > 0 then
			return 0
		end
		if player_system.PLAYERS_GLOBAL_INFORMATION[id].has_report_kill > 0 then
			return 0
		end
	end

	-- Если у человека нет места каким-то образом то пусть пока будет 0
	if place == nil then 
		CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "coins_end", player_id = id, data = {coin = 0}})
		return 0 
	end

	local coin = player_system.Coins_Table[place]

    local player_hero = player_system:GetHero(id)
    if player_hero and not player_hero:IsNull() then
        if PLAYERS[id] and PLAYERS[id].current_hero_level >= 30 then
            coin = coin + 1
        end
    end

    if GetMapName() == "rating_300" or GetMapName() == "rating_duo_300" then
        coin = coin + 2
    else
        if player_system.PLAYERS_GLOBAL_INFORMATION[id] and player_system.PLAYERS_GLOBAL_INFORMATION[id].rating >= 1000 then
            coin = math.max(coin - 1, 0)
        end
    end

	if player_system:HasSubscribePlus(id) then
        coin = math.floor(coin * 2)
    end

    CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "coins_end", player_id = id, data = {coin = coin}})
    return coin
end

function player_system:GetRatingPlace(id)
	local place = PLAYERS[id].place

	if player_system:GetPlayerCountAll() < arena_system:GetMaxPlayersMode() then
		return 0
	end

    if player_system:IsDisconnectFree() then
        if PLAYERS[id].first_leave then
            CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "rating_end", player_id = id, data = {rating = -60}})
            return -60
        end
        return 0
    end

    --Если чел ливнул ( проверка на лив до конца игры или после )
	if PlayerResource:GetConnectionState(id) == DOTA_CONNECTION_STATE_ABANDONED then
        if PLAYERS[id].teammate_leave then
            CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "rating_end", player_id = id, data = {rating = 0}})
			return 0
        end
		if not PLAYERS[id].leave_lose then
			CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "rating_end", player_id = id, data = {rating = -60}})
			return -60
		end
	end

	if player_system.PLAYERS_GLOBAL_INFORMATION[id] and (GetMapName() == "rating" or GetMapName() == "rating_300") then
		if player_system.PLAYERS_GLOBAL_INFORMATION[id].has_report_random > 0 then
            CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "rating_end", player_id = id, data = {rating = -60}})
			return -60
		end
		if player_system.PLAYERS_GLOBAL_INFORMATION[id].has_report_kill > 0 then
            CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "rating_end", player_id = id, data = {rating = -60}})
			return -60
		end
	end

	-- Если у человека нет места каким-то образом то пусть пока будет 0
	if place == nil then
		CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "rating_end", player_id = id, data = {rating = 0}})
		return 0 
	end

	local rating = player_system.Rating_Table[place]
	
	local local_rating = player_system.PLAYERS_GLOBAL_INFORMATION[id].rating

	local average_rating = 0

	for _, player_info in pairs(player_system.PLAYERS_GLOBAL_INFORMATION) do
		average_rating = average_rating + player_info.rating
	end

	average_rating = average_rating / #player_system.PLAYERS_GLOBAL_INFORMATION

	if local_rating < average_rating then
		if average_rating - local_rating > 2250 then
			if rating > 0 then
				rating = rating * 1.9
			elseif rating < 0 then
				rating = rating * 0.1
			end
		elseif average_rating - local_rating > 2000 then
			if rating > 0 then
				rating = rating * 1.8
			elseif rating < 0 then
				rating = rating * 0.2
			end
		elseif average_rating - local_rating > 1750 then
			if rating > 0 then
				rating = rating * 1.7
			elseif rating < 0 then
				rating = rating * 0.3
			end
		elseif average_rating - local_rating > 1500 then
			if rating > 0 then
				rating = rating * 1.6
			elseif rating < 0 then
				rating = rating * 0.4
			end
		elseif average_rating - local_rating > 1250 then
			if rating > 0 then
				rating = rating * 1.5
			elseif rating < 0 then
				rating = rating * 0.5
			end
		elseif average_rating - local_rating > 1000 then
			if rating > 0 then
				rating = rating * 1.4
			elseif rating < 0 then
				rating = rating * 0.6
			end
		elseif average_rating - local_rating > 750 then
			if rating > 0 then
				rating = rating * 1.3
			elseif rating < 0 then
				rating = rating * 0.7
			end
		elseif average_rating - local_rating > 500 then
			if rating > 0 then
				rating = rating * 1.2
			elseif rating < 0 then
				rating = rating * 0.8
			end
		elseif average_rating - local_rating > 250 then
			if rating > 0 then
				rating = rating * 1.1
			elseif rating < 0 then
				rating = rating * 0.9
			end
		end
	elseif local_rating > average_rating then
		if local_rating - average_rating > 2250 then
			if rating > 0 then
				rating = rating * 0.1
			elseif rating < 0 then
				rating = rating * 1.9
			end
		elseif local_rating - average_rating > 2000 then
			if rating > 0 then
				rating = rating * 0.2
			elseif rating < 0 then
				rating = rating * 1.8
			end
		elseif local_rating - average_rating > 1750 then
			if rating > 0 then
				rating = rating * 0.3
			elseif rating < 0 then
				rating = rating * 1.7
			end
		elseif local_rating - average_rating > 1500 then
			if rating > 0 then
				rating = rating * 0.4
			elseif rating < 0 then
				rating = rating * 1.6
			end
		elseif local_rating - average_rating > 1250 then
			if rating > 0 then
				rating = rating * 0.5
			elseif rating < 0 then
				rating = rating * 1.5
			end
		elseif local_rating - average_rating > 1000 then
			if rating > 0 then
				rating = rating * 0.6
			elseif rating < 0 then
				rating = rating * 1.4
			end
		elseif local_rating - average_rating > 750 then
			if rating > 0 then
				rating = rating * 0.7
			elseif rating < 0 then
				rating = rating * 1.3
			end
		elseif local_rating - average_rating > 500 then
			if rating > 0 then
				rating = rating * 0.8
			elseif rating < 0 then
				rating = rating * 1.2
			end
		elseif local_rating - average_rating > 250 then
			if rating > 0 then
				rating = rating * 0.9
			elseif rating < 0 then
				rating = rating * 1.1
			end
		end
	end

    if GetMapName() == "rating_300" or GetMapName() == "rating_duo_300" then
        --if rating > 0 then
        --    rating = rating * 1.5
        --end
    else
        if player_system.PLAYERS_GLOBAL_INFORMATION[id] and player_system.PLAYERS_GLOBAL_INFORMATION[id].rating >= 1000 then
            if rating > 0 then
                rating = rating * 0.5
            end
        end
    end

    local is_double = false
    if PLAYERS[id].player_doubled then
        is_double = true
        rating = rating * 2
    end

    rating = math.floor(rating)
	CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "rating_end", player_id = id, data = {rating = rating, is_double = is_double}})
	return rating
end

--======================================================= Вспомогательные функции для получения информации ========================================================================

function player_system:GetHero(id)
    if PLAYERS[id] then
	    return PLAYERS[id].hero
    end
    return nil
end

function player_system:IsLose(id)
    if PLAYERS[id] then
	    return PLAYERS[id].losegame
    end
    return true
end

function player_system:SetDuel(id,duel)
    if PLAYERS[id] then
	    PLAYERS[id].isduel = duel
    end
end

function player_system:IsDuel(id)
    if PLAYERS[id] then
	    return PLAYERS[id].isduel
    end
    return false
end

function player_system:SetDuelEnd(id,duel)
    if PLAYERS[id] then
	    PLAYERS[id].isduelend = duel
    end
end

function player_system:IsDuelEnd(id)
    if PLAYERS[id] then
	    return PLAYERS[id].isduelend
    end
    return false
end

function player_system:SetLosePlayer(id)
    if PLAYERS[id] then
	    PLAYERS[id].losegame = true
    end
end

function player_system:GetPlayerCount()
	local players = 0
	for id,info in pairs(PLAYERS) do
		if info.losegame == false then
			players = players + 1
		end
	end
	return players
end

function player_system:GetTeamCountAlive()
	local team_count_is_alive = 0
    local team_counter = {}
	for id,info in pairs(PLAYERS) do
		if info.losegame == false then
			local hero = info.hero
            if hero ~= nil and PlayerResource:GetConnectionState(id) ~= DOTA_CONNECTION_STATE_ABANDONED then
                if team_counter[hero:GetTeamNumber()] == nil then
                    team_count_is_alive = team_count_is_alive + 1
                    team_counter[hero:GetTeamNumber()] = true
                end
            end
		end
	end
	return team_count_is_alive
end

function player_system:GetPlayerCountAll()
	local players = 0
	for id,info in pairs(PLAYERS) do
		players = players + 1
	end
	return players
end

-- Функция для проверки убийства
function player_system:LoseTestForBB(player_id)

end

--======================================================= DONATE SHOP ========================================================================

function player_system:HasSubscribePlus(id)
	local player_table = player_system.PLAYERS_GLOBAL_INFORMATION[id]
    if player_table then
        if tonumber(player_table.plus_days) > 0 then
            return true
        else
            return false
        end
    else
        return false
    end
end

player_system.RUNE_SPIN_COST = 1000
player_system.RUNE_MAX_LEVEL = 3
player_system.RUNE_MAX_EQUIPPED = 3

function player_system:GetPlayerRuneLevel(player_info, rune_id)
    if not player_info or not player_info.runes then return 0 end
    local direct_level = player_info.runes[tostring(rune_id)]
    if type(direct_level) ~= "table" and direct_level ~= nil then
        return tonumber(direct_level) or 0
    end

    for _, rune_data in pairs(player_info.runes) do
        if type(rune_data) == "table" then
            local data_id = rune_data.id or rune_data.rune_id or rune_data.name
            if tostring(data_id) == tostring(rune_id) then
                return tonumber(rune_data.level or rune_data.count or rune_data.value) or 1
            end
        elseif tostring(rune_data) == tostring(rune_id) then
            return 1
        end
    end

    return 0
end

function player_system:HasAllRunesMaxed(player_info)
    if not player_info then return true end
    for rune_id, _ in pairs(WODA_RUNES_LIST) do
        if player_system:GetPlayerRuneLevel(player_info, rune_id) < player_system.RUNE_MAX_LEVEL then
            return false
        end
    end
    return true
end

function player_system:RollRuneForPlayer(player_info)
    local total_chance = 0
    local available_runes = {}

    for rune_id, rune_info in pairs(WODA_RUNES_LIST) do
        if player_system:GetPlayerRuneLevel(player_info, rune_id) < player_system.RUNE_MAX_LEVEL then
            local chance = tonumber(rune_info.chance) or 0
            if chance > 0 then
                total_chance = total_chance + chance
                table.insert(available_runes, {id = rune_id, chance = chance})
            end
        end
    end

    if total_chance <= 0 then return nil end

    local random_value = RandomInt(1, total_chance)
    local current_value = 0
    for _, rune_info in pairs(available_runes) do
        current_value = current_value + rune_info.chance
        if random_value <= current_value then
            return rune_info.id
        end
    end

    return available_runes[#available_runes].id
end

function player_system:RuneSpinRequest(data)
    if data.PlayerID == nil then return end
    local id = data.PlayerID
    local player = PlayerResource:GetPlayer(id)
    local player_info = player_system.PLAYERS_GLOBAL_INFORMATION[id]
    if not player then return end
    if not player_info then
        CustomGameEventManager:Send_ServerToPlayer(player, "woda_rune_spin_denied", {reason = "no_data"})
        return
    end
    if not IsInToolsMode() then
        if not player_system.data_base_connected then
            CustomGameEventManager:Send_ServerToPlayer(player, "woda_rune_spin_denied", {reason = "no_data"})
            return
        end
    end

    player_info.runes = player_info.runes or {}
    player_info.equipped_runes = player_info.equipped_runes or {}

    if player_system:HasAllRunesMaxed(player_info) then
        CustomGameEventManager:Send_ServerToPlayer(player, "woda_rune_spin_denied", {reason = "all_max"})
        return
    end

    local cost = player_system.RUNE_SPIN_COST

    if (tonumber(player_info.coins) or 0) < cost then
        CustomGameEventManager:Send_ServerToPlayer(player, "shop_error_notification", {error_name = "shop_error_no_coins"})
        CustomGameEventManager:Send_ServerToPlayer(player, "woda_rune_spin_denied", {reason = "no_coins"})
        return
    end

    local rune_id = player_system:RollRuneForPlayer(player_info)
    if not rune_id then
        CustomGameEventManager:Send_ServerToPlayer(player, "woda_rune_spin_denied", {reason = "all_max"})
        return
    end

    player_info.coins = tonumber(player_info.coins) - cost
    CustomTables:SetTableValue('woda_player_data', tostring(id), player_info)
    CustomGameEventManager:Send_ServerToPlayer(player, "shop_set_currency", {crystall = player_info.crystals, coin = player_info.coins, plus_days = player_info.plus_days})
    CustomGameEventManager:Send_ServerToPlayer(player, "woda_rune_spin_start", {rune_id = rune_id, cost = cost})

    Timers:CreateTimer(4.8, function()
        local current_info = player_system.PLAYERS_GLOBAL_INFORMATION[id]
        if not current_info then return end

        current_info.runes = current_info.runes or {}
        local old_level = tonumber(current_info.runes[tostring(rune_id)]) or 0
        local new_level = math.min(old_level + 1, player_system.RUNE_MAX_LEVEL)
        current_info.runes[tostring(rune_id)] = new_level

        CustomTables:SetTableValue('woda_player_data', tostring(id), current_info)
        CustomGameEventManager:Send_ServerToPlayer(player, "woda_rune_spin_complete", {rune_id = rune_id, level = new_level})

        local post_data =
        {
            player =
            {
                {
                    steamid = PlayerResource:GetSteamAccountID(id),
                    player_coin = cost * -1,
                    rune_id = tostring(rune_id),
                    rune_level = new_level,
                }
            },
        }
        SendData('https://' ..player_system.site_url .. '/data/buy_rune_server.php', post_data, nil)
    end)
end

function player_system:RuneToggleEquip(data)
    if data.PlayerID == nil then return end
    local id = data.PlayerID
    local rune_id = tostring(data.rune_id or "")
    local player = PlayerResource:GetPlayer(id)
    local player_info = player_system.PLAYERS_GLOBAL_INFORMATION[id]
    if not player_info or not WODA_RUNES_LIST[rune_id] then
        if player then
            CustomGameEventManager:Send_ServerToPlayer(player, "woda_rune_equip_denied", {reason = "no_data"})
        end
        return
    end

    player_info.runes = player_info.runes or {}
    player_info.equipped_runes = player_info.equipped_runes or {}

    if player_system:GetPlayerRuneLevel(player_info, rune_id) <= 0 then return end

    local removed = false
    for count = #player_info.equipped_runes, 1, -1 do
        if tostring(player_info.equipped_runes[count]) == rune_id then
            table.remove(player_info.equipped_runes, count)
            removed = true
        end
    end

    if not removed then
        if #player_info.equipped_runes >= player_system.RUNE_MAX_EQUIPPED then
            table.remove(player_info.equipped_runes, 1)
        end
        table.insert(player_info.equipped_runes, rune_id)
    end

    CustomTables:SetTableValue('woda_player_data', tostring(id), player_info)
end

function player_system:ApplyRunesFromStart(id, hero)
    if GetMapName() ~= "arena" then return end
    if not hero or hero:IsNull() then return end
    local player_info = player_system.PLAYERS_GLOBAL_INFORMATION[id]
    if not player_info or not player_info.equipped_runes then return end
    local runes_apply_table = {}
    for _, rune_id in pairs(player_info.equipped_runes) do
        local rune_info = WODA_RUNES_LIST[tostring(rune_id)]
        local rune_level = player_system:GetPlayerRuneLevel(player_info, rune_id)
        if rune_info and rune_info.modifier and rune_level > 0 then
            local modifier = hero:AddNewModifier(hero, nil, rune_info.modifier, {})
            if modifier then
                runes_apply_table[rune_id] = rune_level
                modifier:SetStackCount(rune_level)
                hero:CalculateStatBonus(true)
            end
        end
    end
    CustomTables:SetTableValue("arena_stones", tostring(id), runes_apply_table)
end

function player_system:GetArenaRuneTimeBonus()
    local bonus = 0
    local values = {10, 20, 30}
    for id, player_info in pairs(player_system.PLAYERS_GLOBAL_INFORMATION) do
        if player_info and player_info.equipped_runes then
            for _, rune_id in pairs(player_info.equipped_runes) do
                if tostring(rune_id) == "rune_time" then
                    local level = math.max(1, math.min(player_system:GetPlayerRuneLevel(player_info, "rune_time"), #values))
                    bonus = bonus + (values[level] or 0)
                    break
                end
            end
        end
    end
    return bonus
end

function player_system:GetArenaRuneBonusReroll(player_id)
    local bonus = 0
    local values = {2,4,6}
    local player_info = player_system.PLAYERS_GLOBAL_INFORMATION[player_id]
    if player_info then
        if player_info and player_info.equipped_runes then
            for _, rune_id in pairs(player_info.equipped_runes) do
                if tostring(rune_id) == "rune_creator" then
                    local level = math.max(1, math.min(player_system:GetPlayerRuneLevel(player_info, "rune_creator"), #values))
                    bonus = bonus + (values[level] or 0)
                    break
                end
            end
        end
    end
    return bonus
end

function player_system:GetArenaRuneBonusLife(player_id)
    local bonus = 0
    local values = {1,2,3}
    local player_info = player_system.PLAYERS_GLOBAL_INFORMATION[player_id]
    if player_info then
        if player_info and player_info.equipped_runes then
            for _, rune_id in pairs(player_info.equipped_runes) do
                if tostring(rune_id) == "rune_rebirth" then
                    local level = math.max(1, math.min(player_system:GetPlayerRuneLevel(player_info, "rune_rebirth"), #values))
                    bonus = bonus + (values[level] or 0)
                    break
                end
            end
        end
    end
    return bonus
end

function player_system:HasDonateItem(player_donate_table, item_id)
    if not player_donate_table or not player_donate_table.donate_items then return false end
    local target = tonumber(item_id)
    if target == nil then return false end
    for _, owned in pairs(player_donate_table.donate_items) do
        if tonumber(owned) == target then return true end
    end
    return false
end

player_system.ONE_TIME_STORE_ITEMS =
{
    ["99991"] = true,
    ["1091"] = true,
}

function player_system:BuyItem(data)
	if data.PlayerID == nil then return end
	local id = data.PlayerID
	local item_id = data.item_id
	local price = data.price
	local currency = data.currency
	local player =	PlayerResource:GetPlayer(id)
	local player_donate_table = player_system.PLAYERS_GLOBAL_INFORMATION[id]
    if not player_donate_table then return end
    local get_item_data_cost = _G.ALL_DONATES_ITEMS_DATA[tostring(item_id)]
    if not get_item_data_cost then return end
    if player_system.ONE_TIME_STORE_ITEMS[tostring(item_id)] and not IsInToolsMode() and player_system:HasDonateItem(player_donate_table, item_id) then
        CustomGameEventManager:Send_ServerToPlayer(player, "shop_error_notification", {error_name = "shop_error_you_get_reward"} )
        return
    end
	local change_valute_crystall = 0
	local chance_valute_coins = 0
    price = tonumber(get_item_data_cost[1])
    if IsInToolsMode() then
        price = 0
    end
    if get_item_data_cost[2] and not IsInToolsMode() then
        CustomGameEventManager:Send_ServerToPlayer(player, "shop_error_notification", {error_name = "shop_error_no_coins"} )
        return 
    end

	-- Ошибки недостаточно валюты
	if currency == "crystal" then
		if tonumber(player_donate_table.crystals) < price then
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_error_notification", {error_name = "shop_error_no_crystals", } )
			return
		else
			if player_donate_table then
				player_donate_table.crystals = player_donate_table.crystals - price
				change_valute_crystall = price * -1
			end
		end
	elseif currency == "coin" then
		if tonumber(player_donate_table.coins) < price then
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_error_notification", {error_name = "shop_error_no_coins", } )
			return
		else
			if player_donate_table then
				player_donate_table.coins = player_donate_table.coins - price
				chance_valute_coins = price * -1
			end
		end
	else
		CustomGameEventManager:Send_ServerToPlayer(player, "shop_error_notification", {error_name = "shop_error_no_coins", } )
		return
	end

    if item_id == "double_rating_pack" then
        if player_donate_table then
			player_donate_table.double_tokens = player_donate_table.double_tokens + 10
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_accept_notification", {} )
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_set_currency", {crystall = player_donate_table.crystals, coin = player_donate_table.coins, plus_days = player_donate_table.plus_days} )
			local post_data = 
            {
                player = 
                {
                    {
                        steamid = PlayerResource:GetSteamAccountID(id),
                        player_coin = chance_valute_coins,
                        item_id = 0,
                        days = 0,
                        tokens = 10,
                    }
                },
            }
            SendData('https://' ..player_system.site_url .. '/data/give_reward_bp.php', post_data, nil)
		end
		return
    end

    if item_id == "1091" then
        if player_donate_table then
            -- Прогрузка текущих предметов у игрока --
            local screen_ids = {1086, 1087, 1088, 1089, 1090, 1091}
			local player_items_table = {}
			for k, v in pairs(player_donate_table.donate_items) do
		        table.insert(player_items_table, v)
		    end
            for screen_f, screen_id in pairs(screen_ids) do
                table.insert(player_items_table, screen_id)
            end
			player_donate_table.donate_items = player_items_table
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_accept_notification", {} )
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_set_currency", {crystall = player_donate_table.crystals, coin = player_donate_table.coins, plus_days = player_donate_table.plus_days} )
			local post_data = 
            {
                player = 
                {
                    {
                        steamid = PlayerResource:GetSteamAccountID(id),
                        player_coin = chance_valute_coins,
                        item_id = 0,
                        days = 0,
                        tokens = 0,
                    }
                },
            }
            SendData('https://' ..player_system.site_url .. '/data/give_reward_bp.php', post_data, nil)

            for screen_f, screen_id in pairs(screen_ids) do
                local post_data = 
                {
                    player = 
                    {
                        {
                            steamid = PlayerResource:GetSteamAccountID(id),
                            player_coin = 0,
                            item_id = screen_id,
                            days = 0,
                            tokens = 0,
                        }
                    },
                }
                SendData('https://' ..player_system.site_url .. '/data/give_reward_bp.php', post_data, nil)
            end
		end
		return
    end

	-- Покупка подписки(1 месяц)
	if item_id == "subscribe_plus_1" then
		if player_donate_table then
			player_donate_table.plus_days = player_donate_table.plus_days + 30
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_accept_notification", {} )
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_set_currency", {crystall = player_donate_table.crystals, coin = player_donate_table.coins, plus_days = player_donate_table.plus_days,} )

			local post_data = {
				player = {
					{
						steamid = PlayerResource:GetSteamAccountID(id),
						player_coin = chance_valute_coins,
						player_crystall = 0,
						days = 30,
					}
				},
			}

			SendData('https://' ..player_system.site_url .. '/data/buy_plus_server.php', post_data, nil)
		end
		return
	end

    -- Покупка подписки(6 месяц)
	if item_id == "subscribe_plus_2" then
		if player_donate_table then
			player_donate_table.plus_days = player_donate_table.plus_days + (30 * 6)
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_accept_notification", {} )
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_set_currency", {crystall = player_donate_table.crystals, coin = player_donate_table.coins, plus_days = player_donate_table.plus_days,} )

			local post_data = {
				player = {
					{
						steamid = PlayerResource:GetSteamAccountID(id),
						player_coin = chance_valute_coins,
						player_crystall = 0,
						days = (30 * 6),
					}
				},
			}

			SendData('https://' ..player_system.site_url .. '/data/buy_plus_server.php', post_data, nil)
		end
		return
	end

    -- Набор новогодний
	if item_id == "1051" then
		if player_donate_table then
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_accept_notification", {} )
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_set_currency", {crystall = player_donate_table.crystals, coin = player_donate_table.coins, plus_days = player_donate_table.plus_days,} )

			-- Прогрузка текущих предметов у игрока --
			local player_items_table = {}
			for k, v in pairs(player_donate_table.donate_items) do
		        table.insert(player_items_table, v)
		    end
			table.insert(player_items_table, 48)
            table.insert(player_items_table, 205)
            table.insert(player_items_table, 1051)
			player_donate_table.donate_items = player_items_table
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)

			local post_data = 
            {
				player = {
					{
						steamid = PlayerResource:GetSteamAccountID(id),
						player_coin = chance_valute_coins,
						player_crystall = 0,
                        courier_item = 48,
                        emblem_item = 205,
                        bundle_id = 1051,
						days = 0,
					}
				},
			}
			SendData('https://' ..player_system.site_url .. '/data/buy_bundle_new_other.php', post_data, nil)
		end
		return
	end

    -- Набор новогодний
	if item_id == "1056" then
		if player_donate_table then
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_accept_notification", {} )
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_set_currency", {crystall = player_donate_table.crystals, coin = player_donate_table.coins, plus_days = player_donate_table.plus_days,} )

			-- Прогрузка текущих предметов у игрока --
			local player_items_table = {}
			for k, v in pairs(player_donate_table.donate_items) do
		        table.insert(player_items_table, v)
		    end
			table.insert(player_items_table, 35)
            table.insert(player_items_table, 129)
            table.insert(player_items_table, 1056)
			player_donate_table.donate_items = player_items_table
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)

			local post_data = 
            {
				player = {
					{
						steamid = PlayerResource:GetSteamAccountID(id),
						player_coin = chance_valute_coins,
						player_crystall = 0,
                        courier_item = 35,
                        emblem_item = 129,
                        bundle_id = 1056,
						days = 0,
					}
				},
			}
			SendData('https://' ..player_system.site_url .. '/data/buy_bundle_new_other.php', post_data, nil)
		end
		return
	end

    -- Набор новогодний
	if item_id == "1058" then
		if player_donate_table then
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_accept_notification", {} )
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_set_currency", {crystall = player_donate_table.crystals, coin = player_donate_table.coins, plus_days = player_donate_table.plus_days,} )

			-- Прогрузка текущих предметов у игрока --
			local player_items_table = {}
			for k, v in pairs(player_donate_table.donate_items) do
		        table.insert(player_items_table, v)
		    end
			table.insert(player_items_table, 50)
            table.insert(player_items_table, 990)
            table.insert(player_items_table, 1058)
			player_donate_table.donate_items = player_items_table
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)

			local post_data = 
            {
				player = {
					{
						steamid = PlayerResource:GetSteamAccountID(id),
						player_coin = chance_valute_coins,
						player_crystall = 0,
                        courier_item = 50,
                        emblem_item = 990,
                        bundle_id = 1058,
						days = 0,
					}
				},
			}
			SendData('https://' ..player_system.site_url .. '/data/buy_bundle_new_other.php', post_data, nil)
		end
		return
	end

    -- Набор зевс
	if item_id == "1052" then
		if player_donate_table then
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_accept_notification", {} )
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_set_currency", {crystall = player_donate_table.crystals, coin = player_donate_table.coins, plus_days = player_donate_table.plus_days,} )

			-- Прогрузка текущих предметов у игрока --
			local player_items_table = {}
			for k, v in pairs(player_donate_table.donate_items) do
		        table.insert(player_items_table, v)
		    end
			table.insert(player_items_table, 95)
            table.insert(player_items_table, 728)
            table.insert(player_items_table, 1052)
			player_donate_table.donate_items = player_items_table
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)

			local post_data = 
            {
				player = {
					{
						steamid = PlayerResource:GetSteamAccountID(id),
						player_coin = chance_valute_coins,
						player_crystall = 0,
                        courier_item = 95,
                        emblem_item = 728,
                        bundle_id = 1052,
						days = 0,
					}
				},
			}
			SendData('https://' ..player_system.site_url .. '/data/buy_bundle_new_other.php', post_data, nil)
		end
		return
	end

    -- Набор кез
	if item_id == "1053" then
		if player_donate_table then
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_accept_notification", {} )
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_set_currency", {crystall = player_donate_table.crystals, coin = player_donate_table.coins, plus_days = player_donate_table.plus_days,} )

			-- Прогрузка текущих предметов у игрока --
			local player_items_table = {}
			for k, v in pairs(player_donate_table.donate_items) do
		        table.insert(player_items_table, v)
		    end
			table.insert(player_items_table, 13)
            table.insert(player_items_table, 189)
            table.insert(player_items_table, 1053)
			player_donate_table.donate_items = player_items_table
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)

			local post_data = 
            {
				player = {
					{
						steamid = PlayerResource:GetSteamAccountID(id),
						player_coin = chance_valute_coins,
						player_crystall = 0,
                        courier_item = 13,
                        emblem_item = 189,
                        bundle_id = 1053,
						days = 0,
					}
				},
			}
			SendData('https://' ..player_system.site_url .. '/data/buy_bundle_new_other.php', post_data, nil)
		end
		return
	end
    
    -- Набор джакиро
	if item_id == "1054" then
		if player_donate_table then
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_accept_notification", {} )
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_set_currency", {crystall = player_donate_table.crystals, coin = player_donate_table.coins, plus_days = player_donate_table.plus_days,} )

			-- Прогрузка текущих предметов у игрока --
			local player_items_table = {}
			for k, v in pairs(player_donate_table.donate_items) do
		        table.insert(player_items_table, v)
		    end
			table.insert(player_items_table, 52)
            table.insert(player_items_table, 190)
            table.insert(player_items_table, 1054)
			player_donate_table.donate_items = player_items_table
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)

			local post_data = 
            {
				player = {
					{
						steamid = PlayerResource:GetSteamAccountID(id),
						player_coin = chance_valute_coins,
						player_crystall = 0,
                        courier_item = 52,
                        emblem_item = 190,
                        bundle_id = 1054,
						days = 0,
					}
				},
			}
			SendData('https://' ..player_system.site_url .. '/data/buy_bundle_new_other.php', post_data, nil)
		end
		return
	end

    -- Набор панголиер
	if item_id == "1055" then
		if player_donate_table then
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_accept_notification", {} )
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_set_currency", {crystall = player_donate_table.crystals, coin = player_donate_table.coins, plus_days = player_donate_table.plus_days,} )

			-- Прогрузка текущих предметов у игрока --
			local player_items_table = {}
			for k, v in pairs(player_donate_table.donate_items) do
		        table.insert(player_items_table, v)
		    end
			table.insert(player_items_table, 100)
            table.insert(player_items_table, 198)
            table.insert(player_items_table, 1055)
			player_donate_table.donate_items = player_items_table
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)

			local post_data = 
            {
				player = {
					{
						steamid = PlayerResource:GetSteamAccountID(id),
						player_coin = chance_valute_coins,
						player_crystall = 0,
                        courier_item = 100,
                        emblem_item = 198,
                        bundle_id = 1055,
						days = 0,
					}
				},
			}
			SendData('https://' ..player_system.site_url .. '/data/buy_bundle_new_other.php', post_data, nil)
		end
		return
	end

	-- Покупка подписки(NEW)
	if item_id == "99991" then
		if player_donate_table then
			player_donate_table.plus_days = player_donate_table.plus_days + 7
			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_accept_notification", {} )
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_set_currency", {crystall = player_donate_table.crystals, coin = player_donate_table.coins, plus_days = player_donate_table.plus_days,} )

			-- Прогрузка текущих предметов у игрока --
			local player_items_table = {}
			for k, v in pairs(player_donate_table.donate_items) do
		        table.insert(player_items_table, v)
		    end

			table.insert(player_items_table, 99991)

			player_donate_table.donate_items = player_items_table

			CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)

			local post_data = {
				player = {
					{
						steamid = PlayerResource:GetSteamAccountID(id),
						player_crystall = 0,
						player_coin = 0,
						days = 7,
					}
				},
			}

			SendData('https://' ..player_system.site_url .. '/data/buy_plus_server_new.php', post_data, nil)
		end
		return
	end

	-- Прогрузка текущих предметов у игрока --
	local player_items_table = {}
	for k, v in pairs(player_donate_table.donate_items) do
        table.insert(player_items_table, v)
    end

	table.insert(player_items_table, tonumber(item_id))
	player_donate_table.donate_items = player_items_table
	CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)
	CustomGameEventManager:Send_ServerToPlayer(player, "shop_accept_notification", {} )
	CustomGameEventManager:Send_ServerToPlayer(player, "shop_set_currency", {crystall = player_donate_table.crystals, coin = player_donate_table.coins, plus_days = player_donate_table.plus_days,} )

	local post_data = {
		player = {
			{
				steamid = PlayerResource:GetSteamAccountID(id),
				player_crystall = change_valute_crystall,
				player_coin = chance_valute_coins,
				item_id = item_id,
			}
		},
	}

	SendData('https://' ..player_system.site_url .. '/data/buy_item_server.php', post_data, nil)
end

function player_system:BuyHero(data)
	if data.PlayerID == nil then return end

	local id = data.PlayerID
	local hero_name = data.hero_name
	local days = tonumber(data.days)
	local price = tonumber(data.price)
	local currency = data.currency

	local player =	PlayerResource:GetPlayer(id)
	local player_donate_table = player_system.PLAYERS_GLOBAL_INFORMATION[id]
	if not player_donate_table then return end
	if type(hero_name) ~= "string" or _G.HEROES_LIST_CUSTOM[hero_name] == nil then return end
	if price == nil or price <= 0 or price % 1 ~= 0 then return end
	if days == nil or days <= 0 or days % 1 ~= 0 then return end

	local donate_heroes_table_old = {}

	for k, v in pairs(player_donate_table.donate_heroes) do
        table.insert(donate_heroes_table_old, v)
    end

	local change_valute_crystall = 0
	local chance_valute_coins = 0

	-- Ошибки недостаточно валюты
	if currency == "wodacrystal" then
		if tonumber(player_donate_table.crystals) < tonumber(price) then
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_error_notification", {error_name = "shop_error_no_crystals", } )
			return
		else
			if player_donate_table then
				player_donate_table.crystals = player_donate_table.crystals - tonumber(price)
				change_valute_crystall = tonumber(price) * -1
			end
		end
	elseif currency == "wodacoin" then
		if tonumber(player_donate_table.coins) < tonumber(price) then
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_error_notification", {error_name = "shop_error_no_coins", } )
			return
		else
			if player_donate_table then
				player_donate_table.coins = player_donate_table.coins - tonumber(price)
				chance_valute_coins = tonumber(price) * -1
			end
		end
	else
		CustomGameEventManager:Send_ServerToPlayer(player, "shop_error_notification", {error_name = "shop_error_no_coins", } )
		return
	end

	local new_hero =
	{
		hero_name = tostring(hero_name),
		days = tonumber(days),
	}

	table.insert(donate_heroes_table_old, new_hero)

	player_donate_table.donate_heroes = donate_heroes_table_old

	CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)

	CustomGameEventManager:Send_ServerToPlayer(player, "shop_set_currency", {crystall = player_donate_table.crystals, coin = player_donate_table.coins, plus_days = player_donate_table.plus_days, } )

	CustomGameEventManager:Send_ServerToPlayer(player, "shop_accept_notification", {} )

	local post_data = {
		player = {
			{
				steamid = PlayerResource:GetSteamAccountID(id),
				player_crystall = change_valute_crystall,
				player_coin = chance_valute_coins,
				hero_name = tostring(hero_name),
				days = tonumber(days),
			}
		},
	}

	SendData('https://' ..player_system.site_url .. '/data/buy_hero_server.php', post_data, nil)
end

function player_system:ChangePetPremium(data)
	if data.PlayerID == nil then return end
	local id = data.PlayerID
	local pet_id = tonumber(data.pet_id)				
	local player =	PlayerResource:GetPlayer(id)
	if player then
		if pet_id == nil or PETS_DATA_LIST[pet_id] == nil then return end
		local current_pet = player_system.PLAYERS_GLOBAL_INFORMATION[id] and player_system.PLAYERS_GLOBAL_INFORMATION[id].pet_id
		if pet_id ~= current_pet and not IsInToolsMode() and not player_system:HasDonateItem(player_system.PLAYERS_GLOBAL_INFORMATION[id], pet_id) then return end
		local hero = player:GetAssignedHero()
		if hero then
            local delete_pet = false
            if player_system.PLAYERS_GLOBAL_INFORMATION[ id ] and player_system.PLAYERS_GLOBAL_INFORMATION[ id ].pet_id == pet_id then
                delete_pet = true
            end
			if player.pet and player.pet ~= nil and not delete_pet then
				player_system.PLAYERS_GLOBAL_INFORMATION[ id ].pet_id = pet_id
				player.pet:SetModel(PETS_DATA_LIST[pet_id].model)
				player.pet:SetOriginalModel(PETS_DATA_LIST[pet_id].model)
                player.pet:SetModelScale(PETS_DATA_LIST[pet_id].scale or 0.65)
				if player.pet.particle then
					ParticleManager:DestroyParticle(player.pet.particle, true)
					player.pet.particle = nil
				end
				if PETS_DATA_LIST[pet_id].particle ~= nil then
					player.pet.particle = ParticleManager:CreateParticle(PETS_DATA_LIST[pet_id].particle, PATTACH_ABSORIGIN_FOLLOW, player.pet)
				end		
				if PETS_DATA_LIST[pet_id].style ~= nil then
					player.pet:SetMaterialGroup(PETS_DATA_LIST[pet_id].style)
				else
					player.pet:SetMaterialGroup("default")
				end	
			elseif player.pet and player.pet ~= nil and delete_pet then
				UTIL_Remove(player.pet)
				player.pet = nil
				player_system.PLAYERS_GLOBAL_INFORMATION[ id ].pet_id = nil
			else
				player_system.PLAYERS_GLOBAL_INFORMATION[ id ].pet_id = pet_id
				player.pet = CreateUnitByName("npc_dota_donate_pet", hero:GetAbsOrigin() + RandomVector(RandomFloat(0,100)), true, hero, nil, hero:GetTeamNumber())
				player.pet:SetOwner(hero)
				player.pet:AddNewModifier( hero, nil, "modifier_donate_pet", {} )
				player.pet:AddNewModifier( hero, nil, "modifier_pet", {} )
				player.pet:SetModel(PETS_DATA_LIST[pet_id].model)
				player.pet:SetOriginalModel(PETS_DATA_LIST[pet_id].model)
                player.pet:SetModelScale(PETS_DATA_LIST[pet_id].scale or 0.65)
				if PETS_DATA_LIST[pet_id].particle ~= nil then
					player.pet.particle = ParticleManager:CreateParticle(PETS_DATA_LIST[pet_id].particle, PATTACH_ABSORIGIN_FOLLOW, player.pet)
				end
				if PETS_DATA_LIST[pet_id].style ~= nil then
					player.pet:SetMaterialGroup(PETS_DATA_LIST[pet_id].style)
				else
					player.pet:SetMaterialGroup("default")
				end
			end
            local player_donate_table = player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID]
            if player_donate_table then
                CustomTables:SetTableValue('woda_player_data', tostring(data.PlayerID), player_donate_table)
            end
		end
	end
end

function player_system:AddPetFromStart(id)
	if (player_system.PLAYERS_GLOBAL_INFORMATION[id]) then
		local pet_id = player_system.PLAYERS_GLOBAL_INFORMATION[id].pet_id
		local player =	PlayerResource:GetPlayer(id)

		if player then
			local hero = player:GetAssignedHero()
			if pet_id ~= 0 and pet_id ~= nil and pet_id ~= "0" then
				player.pet = CreateUnitByName("npc_dota_donate_pet", hero:GetAbsOrigin() + RandomVector(RandomFloat(0,100)), true, hero, nil, hero:GetTeamNumber())
				player.pet:SetOwner(hero)
				player.pet:AddNewModifier( hero, nil, "modifier_donate_pet", {} )
				player.pet:AddNewModifier( hero, nil, "modifier_pet", {} )
				player.pet:SetModel(PETS_DATA_LIST[pet_id].model)
				player.pet:SetOriginalModel(PETS_DATA_LIST[pet_id].model)
                player.pet:SetModelScale(PETS_DATA_LIST[pet_id].scale or 0.65)
				if PETS_DATA_LIST[pet_id].particle ~= nil then
					player.pet.particle = ParticleManager:CreateParticle(PETS_DATA_LIST[pet_id].particle, PATTACH_ABSORIGIN_FOLLOW, player.pet)	
				end

				if PETS_DATA_LIST[pet_id].style ~= nil then
					player.pet:SetMaterialGroup(PETS_DATA_LIST[pet_id].style)
				else
					player.pet:SetMaterialGroup("default")
				end
			end
		end
	end
end

player_system.hero_levels_progress = 
{
    10,
    20,
    30,
    40,
    50,
    60,
    70,
    80,
    90,
    100,
    110,
    120,
    130,
    140,
    150,
    160,
    170,
    180,
    190,
    200,
    210,
    220,
    230,
    240,
    250,
    260,
    270,
    280,
    290,
    300,
}

function player_system:ChangeEffectPremium(data)
	if data.PlayerID == nil then return end
	local id = data.PlayerID
	local effect = tonumber(data.effect)				
	local player =	PlayerResource:GetPlayer(id)
	if player then
		if effect == nil then return end
		if effect ~= 0 and EMBLEMS_LIST[effect] == nil then return end
		local current_effect = player_system.PLAYERS_GLOBAL_INFORMATION[id] and player_system.PLAYERS_GLOBAL_INFORMATION[id].effect_id
		if effect ~= 0 and effect ~= current_effect and not IsInToolsMode() and not player_system:HasDonateItem(player_system.PLAYERS_GLOBAL_INFORMATION[id], effect) then return end
		local hero = player:GetAssignedHero()
		if hero then
            local delete_effect = false
            if player_system.PLAYERS_GLOBAL_INFORMATION[ id ] and player_system.PLAYERS_GLOBAL_INFORMATION[ id ].effect_id == effect then
                delete_effect = true
            end
			if not delete_effect then
				player_system.PLAYERS_GLOBAL_INFORMATION[ id ].effect_id = effect
			elseif delete_effect then
				player_system.PLAYERS_GLOBAL_INFORMATION[ id ].effect_id = 0
			else
				player_system.PLAYERS_GLOBAL_INFORMATION[ id ].effect_id = effect
			end
            local player_donate_table = player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID]
            if player_donate_table then
                CustomTables:SetTableValue('woda_player_data', tostring(data.PlayerID), player_donate_table)
            end
            player_system:AddPlayerEmblem(player_system.PLAYERS_GLOBAL_INFORMATION[id].effect_id, hero)
		end
	end
end

function player_system:ChangeFivePremium(data)
	if data.PlayerID == nil then return end
	local id = data.PlayerID
	local five_id = tonumber(data.five_id)				
	local player =	PlayerResource:GetPlayer(id)
	if player then
        if five_id == nil then return end
        local current_five = player_system.PLAYERS_GLOBAL_INFORMATION[id] and player_system.PLAYERS_GLOBAL_INFORMATION[id].five_id
        if five_id ~= 0 and five_id ~= current_five and not IsInToolsMode() and not player_system:HasDonateItem(player_system.PLAYERS_GLOBAL_INFORMATION[id], five_id) then return end
        local delete_effect = false
        if player_system.PLAYERS_GLOBAL_INFORMATION[ id ] and player_system.PLAYERS_GLOBAL_INFORMATION[ id ].five_id == five_id then
            delete_effect = true
        end
        if not delete_effect then
            player_system.PLAYERS_GLOBAL_INFORMATION[ id ].five_id = five_id
        elseif delete_effect then
            player_system.PLAYERS_GLOBAL_INFORMATION[ id ].five_id = 0
        else
            player_system.PLAYERS_GLOBAL_INFORMATION[ id ].five_id = five_id
        end
        local player_donate_table = player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID]
        if player_donate_table then
            CustomTables:SetTableValue('woda_player_data', tostring(data.PlayerID), player_donate_table)
        end
	end
end

function player_system:AddEffectFromStart(id, new_hero)
	if player_system.PLAYERS_GLOBAL_INFORMATION[id] then
		local effect_id = player_system.PLAYERS_GLOBAL_INFORMATION[id].effect_id
		local player =	PlayerResource:GetPlayer(id)
		if player then
			local hero = player:GetAssignedHero()
            if new_hero then
                hero = new_hero
            end
			if effect_id ~= 0 and effect_id ~= nil and effect_id ~= "0" then
                player_system:AddPlayerEmblem(effect_id, hero)
			end
		end
	end
end

function player_system:AddUpgradeFromHeroLevel(hero, id, unit)
	if player_system.PLAYERS_GLOBAL_INFORMATION[id] then
		local hero_level = player_system:GetHeroLevel(id, hero)
		local player = PlayerResource:GetPlayer(id)
		if player then
            if hero_level > 0 then
                hero_level = player_system:GetHeroLevelConvert(hero_level)
            end
            if GetMapName() == "arena" then
                local modifier_hero_level_upgrade_damage = unit:AddNewModifier(unit, nil, "modifier_hero_level_upgrade_damage", {})
                if modifier_hero_level_upgrade_damage then
                    if hero_level >= 30 then
                        modifier_hero_level_upgrade_damage:SetStackCount(3)
                    elseif hero_level >= 25 then
                        modifier_hero_level_upgrade_damage:SetStackCount(2)
                    elseif hero_level >= 18 then
                        modifier_hero_level_upgrade_damage:SetStackCount(1)
                    end
                end
            end
            if PLAYERS[id] then
                PLAYERS[id].current_hero_level = hero_level
            end
            local tier = 0
            if hero_level >= 30 then
                tier = 6
            elseif hero_level >= 25 then
                tier = 5
            elseif hero_level >= 18 then
                tier = 4
            elseif hero_level >= 12 then
                tier = 3
            elseif hero_level >= 6 then
                tier = 2
            elseif hero_level >= 1 then
                tier = 1
            end
            if tier > 0 then
                local particle = ParticleManager:CreateParticle( "particles/hero_spawn_hero_level_"..tier..".vpcf", PATTACH_ABSORIGIN_FOLLOW, unit )
                ParticleManager:ReleaseParticleIndex( particle )
            end
		end
	end
end

function player_system:GetHeroLevel(id, hero)
    if player_system.PLAYERS_GLOBAL_INFORMATION[id] and player_system.PLAYERS_GLOBAL_INFORMATION[id].heroes_level then
        for _, hero_table in pairs(player_system.PLAYERS_GLOBAL_INFORMATION[id].heroes_level) do
            if hero_table and hero_table.hero == hero then
                return tonumber(hero_table.coins)
            end
        end
    end
    return 0
end

function player_system:GetHeroLevelConvert(coins)
    local full_sum = 0
    local level_end = 30
    for _, exp in pairs(player_system.hero_levels_progress) do
        full_sum = full_sum + exp
        if (coins < full_sum) then
            level_end = _ - 1
            break
        end
    end
    return level_end
end

function player_system:donate_promocode(data)
	if data.PlayerID == nil then return end

	local id = data.PlayerID
	local promo = string.upper(data.promo)
	local player =	PlayerResource:GetPlayer(id)

	local promo_check = function(data, id, promo)
		if data ~= nil then
			if data.promo_code ~= nil then
				if data.promo_use == "0" then
					local player_donate_table = player_system.PLAYERS_GLOBAL_INFORMATION[id]
					if player_donate_table then
						player_donate_table.crystals = player_donate_table.crystals + tonumber(data.crystals)
						player_donate_table.coins = player_donate_table.coins + tonumber(data.coins)
						player_donate_table.plus_days = player_donate_table.plus_days + tonumber(data.sub)
                        if (tonumber(data.item_id) > 0) then
                            table.insert(player_donate_table.donate_items, tonumber(data.item_id))
                        end
                        if (tonumber(data.battlepass) > 0) then
                            if (player_donate_table.has_battlepass_2026 > 0) then
                                player_donate_table.battlepass_level_2026 = player_donate_table.battlepass_level_2026 + 49
                            else
                                player_donate_table.has_battlepass_2026 = 1
                                player_donate_table.battlepass_level_2026 = 1
                            end
                        end
						CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)

						CustomGameEventManager:Send_ServerToPlayer(player, "shop_accept_notification", {} )
						CustomGameEventManager:Send_ServerToPlayer(player, "shop_set_currency", {crystall = player_donate_table.crystals, coin = player_donate_table.coins, plus_days = player_donate_table.plus_days,} )

						local post_data = {
							player = {
								{
									steamid = PlayerResource:GetSteamAccountID(id),
									crystals = tonumber(data.crystals),
									coins = tonumber(data.coins),
									sub = tonumber(data.sub),
                                    item_id = tonumber(data.item_id),
									promo_code = promo,
                                    battlepass = tonumber(data.battlepass),
								}
							},
						}

						SendData('https://' ..player_system.site_url .. '/data/use_promocode_server.php', post_data, nil)
						return
					end
					CustomGameEventManager:Send_ServerToPlayer(player, "shop_error_notification", {error_name = "shop_error_nothing_player",} )
					return
				end
				CustomGameEventManager:Send_ServerToPlayer(player, "shop_error_notification", {error_name = "shop_error_promo_used",} )
				return
			end
			CustomGameEventManager:Send_ServerToPlayer(player, "shop_error_notification", {error_name = "shop_error_promo_null",} )
			return
		end
		CustomGameEventManager:Send_ServerToPlayer(player, "shop_error_notification", {error_name = "shop_error_promo_null",} )	
    end 

    RequestData('https://' ..player_system.site_url .. '/data/get_promo_code.php?promo=' .. promo .. '&token=' .. GetDedicatedServerKeyV3('woda') .. '&id=' .. PlayerResource:GetSteamAccountID(id), function(data) promo_check(data, id, promo) end)
end

function player_system:PlayerTip(keys)
	if keys.PlayerID == nil then return end
    local cooldown = 30

    if IsInToolsMode() then
      cooldown = 1
    end

    local id_caster = keys.PlayerID
    local id_target = keys.player_id_tip
    local secret_key = keys.secret_key

    if player_system.PLAYERS_GLOBAL_INFORMATION[id_caster] then
    	if #player_system.PLAYERS_GLOBAL_INFORMATION[id_caster].tips > 0 then
    		local tips = player_system.PLAYERS_GLOBAL_INFORMATION[id_caster].tips
    		CustomGameEventManager:Send_ServerToAllClients( 'TipPlayerNotification', {player_id_1 = id_caster, player_id_2 = id_target, tip = tips[RandomInt(1, #tips)]})
    	else
    		CustomGameEventManager:Send_ServerToAllClients( 'TipPlayerNotification', {player_id_1 = id_caster, player_id_2 = id_target, tip = 0})
    	end
    end

    CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "tip_cooldown", player_id = id_caster, data = {cooldown = cooldown}})

    Timers:CreateTimer(1, function()
      	cooldown = cooldown - 1
      	CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "tip_cooldown", player_id = id_caster, data = {cooldown = cooldown}})
      	if cooldown <= 0 then return nil end
      	return 1
    end)
end

function player_system:PlayerBanLeaved(id)
	if player_system.PLAYERS_GLOBAL_INFORMATION[id] == nil then return end
	if player_system.PLAYERS_GLOBAL_INFORMATION[id] and tostring(player_system.PLAYERS_GLOBAL_INFORMATION[id].steamid) == "883703644" then return end
    if player_system.PLAYERS_GLOBAL_INFORMATION[id] and tostring(player_system.PLAYERS_GLOBAL_INFORMATION[id].steamid) == "122413750" then return end
    if player_system.PLAYERS_GLOBAL_INFORMATION[id] and tostring(player_system.PLAYERS_GLOBAL_INFORMATION[id].steamid) == "181517303" then return end
    if player_system.PLAYERS_GLOBAL_INFORMATION[id] and tostring(player_system.PLAYERS_GLOBAL_INFORMATION[id].steamid) == "1442313314" then return end
    if player_system.PLAYERS_GLOBAL_INFORMATION[id] and tostring(player_system.PLAYERS_GLOBAL_INFORMATION[id].steamid) == "1602096619" then return end
    if player_system.PLAYERS_GLOBAL_INFORMATION[id] and tostring(player_system.PLAYERS_GLOBAL_INFORMATION[id].steamid) == "1899469460" then return end
	if player_system.PLAYERS_GLOBAL_INFORMATION[id].last_leave == 1 then return end
    if GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then return end
    if player_system:GetPlayerCountAll() < arena_system:GetMaxPlayersMode() then return end
	local post_data = 
	{
		player = 
		{
			{
				steamid = player_system.PLAYERS_GLOBAL_INFORMATION[id].steamid,
				leave = 1,
			}
		},
	}

	SendData('https://' ..player_system.site_url .. '/data/player_leave_system.php', post_data, nil)
end

function player_system:PlayerUnBanLeaved(id)
	if player_system.PLAYERS_GLOBAL_INFORMATION[id] == nil then return end
	if player_system.PLAYERS_GLOBAL_INFORMATION[id] and tostring(player_system.PLAYERS_GLOBAL_INFORMATION[id].steamid) == "883703644" then return end
    if player_system.PLAYERS_GLOBAL_INFORMATION[id] and tostring(player_system.PLAYERS_GLOBAL_INFORMATION[id].steamid) == "122413750" then return end
    if player_system.PLAYERS_GLOBAL_INFORMATION[id] and tostring(player_system.PLAYERS_GLOBAL_INFORMATION[id].steamid) == "181517303" then return end
    if player_system.PLAYERS_GLOBAL_INFORMATION[id] and tostring(player_system.PLAYERS_GLOBAL_INFORMATION[id].steamid) == "1442313314" then return end
    if player_system.PLAYERS_GLOBAL_INFORMATION[id] and tostring(player_system.PLAYERS_GLOBAL_INFORMATION[id].steamid) == "1602096619" then return end
    if player_system.PLAYERS_GLOBAL_INFORMATION[id] and tostring(player_system.PLAYERS_GLOBAL_INFORMATION[id].steamid) == "1899469460" then return end
	if player_system.PLAYERS_GLOBAL_INFORMATION[id].last_leave ~= 1 then return end
    if player_system:GetPlayerCountAll() < arena_system:GetMaxPlayersMode() then return end
	local post_data = 
	{
		player = 
		{
			{
				steamid = player_system.PLAYERS_GLOBAL_INFORMATION[id].steamid,
				leave = 0,
			}
		},
	}

	SendData('https://' ..player_system.site_url .. '/data/player_leave_system.php', post_data, nil)
end

function player_system:player_reported_select(data)
	local report_id = data.report_id
	if player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID] then
		if player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].players_repoted then
			local has_reported = false

			for count = #player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].players_repoted, 1, -1 do
		        if player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].players_repoted[count] and (player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].players_repoted[count] == report_id) then
		            table.remove(player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].players_repoted, count)
		            has_reported = true
		        end
		    end

			if #player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].players_repoted >= 2 then
				return
			end

			if not has_reported then
				table.insert(player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].players_repoted, report_id)
			end
            CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "reported_info", player_id = data.PlayerID, data = {reported_info = player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].players_repoted}})
		end
	end
end

function player_system:SendDataPlayerReports()
	if player_system:GetPlayerCountAll() >= 7 or IsInToolsMode() then
	    local post_data = 
	    { 
	        players = {}
	    }

		for id, player_info in pairs(player_system.PLAYERS_GLOBAL_INFORMATION) do
	    	if player_info.players_repoted and #player_info.players_repoted >= 2 then
	    		local player_1 = player_system.PLAYERS_GLOBAL_INFORMATION[player_info.players_repoted[1]].steamid
	    		local player_2 = player_system.PLAYERS_GLOBAL_INFORMATION[player_info.players_repoted[2]].steamid
		        local player_table = 
		        {
		            steamid = player_info.steamid,
		            player_1 = player_1,
		            player_2 = player_2,
		        }
		        table.insert(post_data.players, player_table)
		    end
	    end

	    SendData('https://' ..player_system.site_url .. '/data/player_reports_upload.php', post_data, nil)

	    return post_data
	end
end

function player_system:change_premium_tip(data)
	if data.PlayerID == nil then return end
	local tip = tonumber(data.tip)
	if tip == nil then return end
	if not IsInToolsMode() and not player_system:HasDonateItem(player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID], tip) then return end
	if player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID] then
		if player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].tips then
			local has_tip = false
			for count = #player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].tips, 1, -1 do
		        if player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].tips[count] and (player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].tips[count] == tip) then
		            table.remove(player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].tips, count)
		            has_tip = true
		        end
		    end
			if not has_tip then
				table.insert(player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].tips, tip)
			end
			local player_donate_table = player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID]
			if player_donate_table then
				CustomTables:SetTableValue('woda_player_data', tostring(data.PlayerID), player_donate_table)
			end
		end
	end
end

function player_system:change_premium_bg(data)
	if data.PlayerID == nil then return end
	local background_id = tonumber(data.background_id)
	if background_id == nil then return end
	local current_bg = player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID] and player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].background_id
	if background_id ~= 0 and background_id ~= current_bg and not IsInToolsMode() and not player_system:HasDonateItem(player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID], background_id) then return end
	if player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID] then
        if player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].background_id and player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].background_id == background_id then
            player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].background_id = 0
        else
            player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].background_id = background_id
        end
        local player_donate_table = player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID]
        if player_donate_table then
            CustomTables:SetTableValue('woda_player_data', tostring(data.PlayerID), player_donate_table)
        end
	end
end

function player_system:change_premium_tp(data)
	if data.PlayerID == nil then return end
	local teleport_id = tonumber(data.teleport_id)
	if teleport_id == nil then return end
	local current_tp = player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID] and player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].teleport_id
	if teleport_id ~= 0 and teleport_id ~= current_tp and not IsInToolsMode() and not player_system:HasDonateItem(player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID], teleport_id) then return end
	if player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID] then
        if player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].teleport_id and player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].teleport_id == teleport_id then
            player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].teleport_id = 0
        else
            player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID].teleport_id = teleport_id
        end
        local player_donate_table = player_system.PLAYERS_GLOBAL_INFORMATION[data.PlayerID]
        if player_donate_table then
            CustomTables:SetTableValue('woda_player_data', tostring(data.PlayerID), player_donate_table)
        end
	end
end

function player_system:donate_shop_get_free_reward(data)
	if data.PlayerID == nil then return end
	local id = data.PlayerID
	local player_object =	PlayerResource:GetPlayer(id)
    local player_donate_table = player_system.PLAYERS_GLOBAL_INFORMATION[id]
    if player_donate_table then
        if (player_donate_table.free_reward == 0 or player_donate_table.free_reward == "0") then
            player_donate_table.free_reward = 1
            player_donate_table.coins = player_donate_table.coins + tonumber(10)
            CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)
            CustomGameEventManager:Send_ServerToPlayer(player_object, "shop_accept_notification", {} )
            CustomGameEventManager:Send_ServerToPlayer(player_object, "shop_set_currency", {crystall = player_donate_table.crystals, coin = player_donate_table.coins, plus_days = player_donate_table.plus_days,} )
            local post_data = 
            {
                player = 
                {
                    {
                        steamid = PlayerResource:GetSteamAccountID(id),
                        coins = tonumber(10),
                    }
                },
            }
            SendData('https://' ..player_system.site_url .. '/data/use_free_reward_server.php', post_data, nil)
            return
        else
            CustomGameEventManager:Send_ServerToPlayer(player_object, "shop_error_notification", {error_name = "shop_error_you_get_reward",} )
        end
    else
        CustomGameEventManager:Send_ServerToPlayer(player_object, "shop_error_notification", {error_name = "shop_error_nothing_player",} )
    end
end

function player_system:StartHighFive(params)
    if params.PlayerID == nil then return end
    local hero = PlayerResource:GetSelectedHeroEntity(params.PlayerID)
    local high_five_custom = hero:FindAbilityByName("high_five_custom")
    if high_five_custom and high_five_custom:IsFullyCastable() then
        high_five_custom:OnSpellStart()
    end
end

function player_system:web_update_player_coin_base(data)
	if data.PlayerID == nil then return end
	local id = data.PlayerID
	local player_object = PlayerResource:GetPlayer(id)
    local player_donate_table = player_system.PLAYERS_GLOBAL_INFORMATION[id]
    if player_donate_table then
        local post_data = 
        {
            player = 
            {
                {
                    steamid = PlayerResource:GetSteamAccountID(id),
                }
            },
        }
        SendData('https://' ..player_system.site_url .. '/data/web_update_player_coin.php', post_data, function(data) player_system:UpdatePlayerCoinWeb(data, id) end)
    end
end

function player_system:UpdatePlayerCoinWeb(data, id)
    if data == nil then return end
    if data.update_data == nil or tonumber(data.update_data) == 0 then return end
    local player_object = PlayerResource:GetPlayer(id)
    local player_donate_table = player_system.PLAYERS_GLOBAL_INFORMATION[id]
    if player_donate_table and tonumber(data.coins) > player_donate_table.coins then
        player_donate_table.coins = tonumber(data.coins)
        CustomTables:SetTableValue('woda_player_data', tostring(id), player_donate_table)
        CustomGameEventManager:Send_ServerToPlayer(player_object, "shop_set_currency", {coin = player_donate_table.coins} )
    end
end

function player_system:AddPlayerEmblem(effect_id, hero)
    local modifier_woda_emblem_old = hero:FindModifierByName("modifier_woda_emblem")
    if modifier_woda_emblem_old then
        modifier_woda_emblem_old:Destroy()
    end
    if effect_id == 0 then return end
    local effect_info = EMBLEMS_LIST[effect_id]
    local modifier_woda_emblem = hero:AddNewModifier(hero, nil, "modifier_woda_emblem", {status_effect = effect_info["status_effect"], effect_id = effect_id})
    if modifier_woda_emblem then
        if effect_info["particle_name"] then
            local effect_real_name = effect_info["particle_name"]
            local effect_pattach = PATTACH_ABSORIGIN_FOLLOW
            if effect_real_name == "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient" then
                effect_real_name = "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_"..hero:GetUnitName()..".vpcf"
            end
            if effect_real_name == "particles/new_year/anniversary_10th_hat_ambient" then
                effect_real_name = "particles/new_year/anniversary_10th_hat_ambient_"..hero:GetUnitName()..".vpcf"
            end
            if effect_real_name == "particles/new_year_2/anniversary_10th_hat_ambient" then
                effect_real_name = "particles/new_year_2/anniversary_10th_hat_ambient_"..hero:GetUnitName()..".vpcf"
            end
            local particle_fx_1 = ParticleManager:CreateParticle(effect_real_name, effect_pattach, hero)
            if effect_info["is_hitloc"] then
                ParticleManager:SetParticleControlEnt(particle_fx_1, 0, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true )
            else
	            ParticleManager:SetParticleControl(particle_fx_1, 0, hero:GetAbsOrigin())
            end

            if effect_id == 1076 then
                ParticleManager:SetParticleControl(particle_fx_1, 4, Vector(255,255,255))
            end
            if effect_id == 1077 then -- красный
                ParticleManager:SetParticleControl(particle_fx_1, 4, Vector(255, 0, 0))
            end

            if effect_id == 1078 then -- оранжевый
                ParticleManager:SetParticleControl(particle_fx_1, 4, Vector(255, 127, 0))
            end

            if effect_id == 1079 then -- жёлтый
                ParticleManager:SetParticleControl(particle_fx_1, 4, Vector(255, 255, 0))
            end

            if effect_id == 1080 then -- зелёный
                ParticleManager:SetParticleControl(particle_fx_1, 4, Vector(0, 255, 0))
            end

            if effect_id == 1081 then -- голубой
                ParticleManager:SetParticleControl(particle_fx_1, 4, Vector(0, 191, 255))
            end

            if effect_id == 1082 then -- синий
                ParticleManager:SetParticleControl(particle_fx_1, 4, Vector(0, 0, 255))
            end

            if effect_id == 1083 then -- фиолетовый
                ParticleManager:SetParticleControl(particle_fx_1, 4, Vector(139, 0, 255))
            end
            if effect_real_name == "particles/woda_unique/pumpkin_head.vpcf" or effect_real_name == "particles/woda_unique/tiny_head.vpcf" or effect_real_name == "effect/crown/2_shield.vpcf" or effect_real_name == "particles/woda_unique/skull_head.vpcf" then
                if hero:GetUnitName() == "npc_dota_hero_meepo" then
                    ParticleManager:SetParticleControl(particle_fx_1, 1, Vector(0,90,90))
                end
                if hero:GetUnitName() == "npc_dota_hero_bounty_hunter" then
                    ParticleManager:SetParticleControl(particle_fx_1, 1, Vector(45,0,0))
                end
                if hero:GetUnitName() == "npc_dota_hero_earthshaker" then
                    ParticleManager:SetParticleControl(particle_fx_1, 1, Vector(45,0,0))
                end
            end
            if effect_real_name == "particles/woda_unique/snow_head.vpcf" then
                if hero:GetUnitName() == "npc_dota_hero_meepo" then
                    ParticleManager:SetParticleControl(particle_fx_1, 1, Vector(90,90,90))
                elseif hero:GetUnitName() == "npc_dota_hero_kez" then
                    ParticleManager:SetParticleControl(particle_fx_1, 1, Vector(0,-90,0))
                elseif hero:GetUnitName() == "npc_dota_hero_marci" then
                    ParticleManager:SetParticleControl(particle_fx_1, 1, Vector(0,-90,0))
                elseif hero:GetUnitName() == "npc_dota_hero_bounty_hunter" then
                    ParticleManager:SetParticleControl(particle_fx_1, 1, Vector(0,-90,-90))
                elseif hero:GetUnitName() == "npc_dota_hero_earthshaker" then
                    ParticleManager:SetParticleControl(particle_fx_1, 1, Vector(0,-90,-45))
                elseif hero:GetUnitName() == "npc_dota_hero_legion_commander" then
                    ParticleManager:SetParticleControl(particle_fx_1, 1, Vector(0,-90,0))
                elseif hero:GetUnitName() == "npc_dota_hero_dawnbreaker" then
                    ParticleManager:SetParticleControl(particle_fx_1, 1, Vector(90,-90,-90))
                else
                    ParticleManager:SetParticleControl(particle_fx_1, 1, Vector(0,-90,0))
                end
            end
            if effect_real_name == "particles/woda_fx/ember_ti9_flameguard_shield_outer.vpcf" then
                ParticleManager:SetParticleControlEnt( particle_fx_1, 1, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/items_fx/avianas_feather.vpcf" then
                ParticleManager:SetParticleControlEnt( particle_fx_1, 1, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/items2_fx/vindicators_axe_armor.vpcf" then
                ParticleManager:SetParticleControlEnt( particle_fx_1, 1, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_ancient_seal_debuff.vpcf" then
                ParticleManager:SetParticleControlEnt( particle_fx_1, 1, hero, PATTACH_ABSORIGIN_FOLLOW, nil, hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_ancient_seal_v2_debuff.vpcf" then
                ParticleManager:SetParticleControlEnt( particle_fx_1, 1, hero, PATTACH_ABSORIGIN_FOLLOW, nil, hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/econ/courier/courier_roshan_desert_sands/baby_roshan_desert_sands_rocks_model_loadout.vpcf" then
                ParticleManager:SetParticleControlEnt( particle_fx_1, 4, hero, PATTACH_ABSORIGIN_FOLLOW, nil, hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/items2_fx/vindicators_axe_damage.vpcf" then
                ParticleManager:SetParticleControlEnt( particle_fx_1, 1, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/econ/items/ember_spirit/ember_ti9/ember_ti9_flameguard_shield_core.vpcf" then
                ParticleManager:SetParticleControlEnt( particle_fx_1, 1, hero, PATTACH_ABSORIGIN_FOLLOW, nil, hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/econ/events/fall_2022/mjollnir/mjollnir_shield_fall2022_beam_zap.vpcf" then
                ParticleManager:SetParticleControlEnt( particle_fx_1, 1, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/woda_fx/tpscroll.vpcf" then
                ParticleManager:SetParticleControlEnt( particle_fx_1, 1, hero, PATTACH_ABSORIGIN_FOLLOW, nil, hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/units/heroes/hero_grimstroke/grimstroke_soulchain_ground_model.vpcf" then
                ParticleManager:SetParticleControlEnt( particle_fx_1, 2, hero, PATTACH_ABSORIGIN_FOLLOW, nil, hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/econ/items/pugna/pugna_ward_ti5/pugna_ambient_ti_5.vpcf" then
                local attach_name = "attach_attack1"
                if hero:GetUnitName() == "npc_dota_hero_juggernaut" then
                    attach_name = "attach_hand1"
                end
                ParticleManager:SetParticleControlEnt( particle_fx_1, 0, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 1, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 2, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/woda_fx/pugna_ambient_ti_5.vpcf" then
                local attach_name = "attach_attack1"
                if hero:GetUnitName() == "npc_dota_hero_juggernaut" then
                    attach_name = "attach_hand1"
                end
                ParticleManager:SetParticleControlEnt( particle_fx_1, 0, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 1, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 2, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/woda_fx/pugna_ambient_ti_5_purple.vpcf" then
                local attach_name = "attach_attack1"
                if hero:GetUnitName() == "npc_dota_hero_juggernaut" then
                    attach_name = "attach_hand1"
                end
                ParticleManager:SetParticleControlEnt( particle_fx_1, 0, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 1, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 2, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/woda_fx/pugna_ambient_ti_5_blue.vpcf" then
                local attach_name = "attach_attack1"
                if hero:GetUnitName() == "npc_dota_hero_juggernaut" then
                    attach_name = "attach_hand1"
                end
                ParticleManager:SetParticleControlEnt( particle_fx_1, 0, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 1, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 2, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/woda_fx/pugna_ambient_ti_5_yellow.vpcf" then
                local attach_name = "attach_attack1"
                if hero:GetUnitName() == "npc_dota_hero_juggernaut" then
                    attach_name = "attach_hand1"
                end
                ParticleManager:SetParticleControlEnt( particle_fx_1, 0, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 1, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 2, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
            end

            if effect_real_name == "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_wings_ambient.vpcf" then
                ParticleManager:SetParticleControlEnt( particle_fx_1, 2, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_wings_v2_ambient.vpcf" then
                ParticleManager:SetParticleControlEnt( particle_fx_1, 2, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/econ/items/wisp/calavera/io_calavera_ambient.vpcf" then
                ParticleManager:SetParticleControlEnt( particle_fx_1, 0, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 1, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/econ/items/wraith_king/wraith_king_arcana/wk_arc_ambient_custom.vpcf" then
                ParticleManager:SetParticleControlEnt( particle_fx_1, 1, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 2, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 3, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 4, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 5, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true )
            end
            if effect_real_name == "particles/econ/items/tiny/tiny_astral_order/tiny_astral_order_neck_ambient_custom.vpcf" then
                local attach_name = "attach_attack1"
                if hero:GetUnitName() == "npc_dota_hero_juggernaut" then
                    attach_name = "attach_hand1"
                end
                ParticleManager:SetParticleControlEnt( particle_fx_1, 1, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 2, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 3, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 4, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_1, 7, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetAbsOrigin(), true )
            end
	        modifier_woda_emblem:AddParticle(particle_fx_1, false, false, -1, false, false)
        end
        if effect_info["particle_name_2"] then
            local particle_fx_2 = ParticleManager:CreateParticle(effect_info["particle_name_2"], PATTACH_ABSORIGIN_FOLLOW, hero)
	        ParticleManager:SetParticleControl(particle_fx_2, 0, hero:GetAbsOrigin())
            if effect_info["particle_name_2"] == "particles/econ/items/pugna/pugna_ward_ti5/pugna_ambient_ti_5.vpcf" then
                local attach_name = "attach_attack2"
                if hero:GetUnitName() == "npc_dota_hero_juggernaut" then
                    attach_name = "attach_hand2"
                end
                if hero:GetUnitName() == "npc_dota_hero_drow_ranger" then
                    attach_name = "attach_mom_l"
                end
                if hero:GetUnitName() == "npc_dota_hero_chen" then
                    attach_name = "attach_attack1"
                end
                ParticleManager:SetParticleControlEnt( particle_fx_2, 0, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_2, 1, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_2, 2, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
            end
            if effect_info["particle_name_2"] == "particles/woda_fx/pugna_ambient_ti_5.vpcf" then
                local attach_name = "attach_attack2"
                if hero:GetUnitName() == "npc_dota_hero_juggernaut" then
                    attach_name = "attach_hand2"
                end
                if hero:GetUnitName() == "npc_dota_hero_drow_ranger" then
                    attach_name = "attach_mom_l"
                end
                if hero:GetUnitName() == "npc_dota_hero_chen" then
                    attach_name = "attach_attack1"
                end
                ParticleManager:SetParticleControlEnt( particle_fx_2, 0, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_2, 1, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_2, 2, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
            end
            if effect_info["particle_name_2"] == "particles/woda_fx/pugna_ambient_ti_5_purple.vpcf" then
                local attach_name = "attach_attack2"
                if hero:GetUnitName() == "npc_dota_hero_juggernaut" then
                    attach_name = "attach_hand2"
                end
                if hero:GetUnitName() == "npc_dota_hero_drow_ranger" then
                    attach_name = "attach_mom_l"
                end
                if hero:GetUnitName() == "npc_dota_hero_chen" then
                    attach_name = "attach_attack1"
                end
                ParticleManager:SetParticleControlEnt( particle_fx_2, 0, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_2, 1, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_2, 2, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
            end
            if effect_info["particle_name_2"] == "particles/woda_fx/pugna_ambient_ti_5_blue.vpcf" then
                local attach_name = "attach_attack2"
                if hero:GetUnitName() == "npc_dota_hero_juggernaut" then
                    attach_name = "attach_hand2"
                end
                if hero:GetUnitName() == "npc_dota_hero_drow_ranger" then
                    attach_name = "attach_mom_l"
                end
                if hero:GetUnitName() == "npc_dota_hero_chen" then
                    attach_name = "attach_attack1"
                end
                ParticleManager:SetParticleControlEnt( particle_fx_2, 0, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_2, 1, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_2, 2, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
            end
            if effect_info["particle_name_2"] == "particles/woda_fx/pugna_ambient_ti_5_yellow.vpcf" then
                local attach_name = "attach_attack2"
                if hero:GetUnitName() == "npc_dota_hero_juggernaut" then
                    attach_name = "attach_hand2"
                end
                if hero:GetUnitName() == "npc_dota_hero_drow_ranger" then
                    attach_name = "attach_mom_l"
                end
                if hero:GetUnitName() == "npc_dota_hero_chen" then
                    attach_name = "attach_attack1"
                end
                ParticleManager:SetParticleControlEnt( particle_fx_2, 0, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_2, 1, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
                ParticleManager:SetParticleControlEnt( particle_fx_2, 2, hero, PATTACH_POINT_FOLLOW, attach_name, hero:GetAbsOrigin(), true )
            end
	        modifier_woda_emblem:AddParticle(particle_fx_2, false, false, -1, false, false)
        end
    end
end

function player_system:woda_plus_get_player_reward(data)
	if data.PlayerID == nil then return end
    local player_id = data.PlayerID
    local quest_id = tonumber(data.quest_id)
    local reward_id = tonumber(data.reward_id)
    if _G.QUESTS_LIST[quest_id] == nil then return end
    local player_data = player_system.PLAYERS_GLOBAL_INFORMATION[player_id]
    if player_data == nil then return end
    if player_data.plus_days <= 0 then return end
    if player_data.quest_data[quest_id] == nil then return end
    if player_data.quest_data[quest_id] < _G.QUESTS_LIST[quest_id][1] then return end
    if _G.QUESTS_LIST[quest_id][2] ~= reward_id then return end
    if player_system:HasDonateItem(player_data, reward_id) then return end
    local player_donate_table = player_system.PLAYERS_GLOBAL_INFORMATION[player_id]
    local coin_reward = 0

    if _G.QUESTS_LIST[quest_id][3] then
        coin_reward = 100
        player_donate_table.coins = player_donate_table.coins + 100
    end

    local player_items_table = {}
    for k, v in pairs(player_donate_table.donate_items) do
        table.insert(player_items_table, v)
    end
    table.insert(player_items_table, tonumber(reward_id))
    player_donate_table.donate_items = player_items_table

    CustomTables:SetTableValue('woda_player_data', tostring(player_id), player_donate_table)

    local post_data = 
    {
        player = 
        {
            {
                steamid = PlayerResource:GetSteamAccountID(player_id),
                player_crystall = 0,
                player_coin = coin_reward,
                item_id = reward_id,
            }
        },
    }
    SendData('https://' ..player_system.site_url .. '/data/buy_item_server.php', post_data, nil)
    print("получил предмет", _G.QUESTS_LIST[quest_id][2], " js item", reward_id)
end

function player_system:PlayerQuestProgress(player_id, quest_id, progress, not_save)
    if player_system.PLAYERS_GLOBAL_INFORMATION[player_id] == nil then return end
    if not not_save then
        if GameRules:IsCheatMode() and not IsInToolsMode() then return end
        if GetMapName() == "overthrow" and not IsInToolsMode() then return end
    end
    local quest_data = player_system.PLAYERS_GLOBAL_INFORMATION[player_id].quest_data
    local quest_current_data = player_system.PLAYERS_GLOBAL_INFORMATION[player_id].quest_current_data
    local quest_information = _G.QUESTS_LIST[quest_id]
    if quest_information == nil then return end
    local current_value = 0
    local quest_value = 0
    if quest_current_data[quest_id] ~= nil then
        current_value = quest_current_data[quest_id]
    end
    if quest_data[quest_id] ~= nil then
        quest_value = quest_data[quest_id]
    end
    if not not_save then
        quest_current_data[quest_id] = math.min(current_value + progress, quest_information[1])
    end
    quest_data[quest_id] = math.min(quest_value + progress, quest_information[1])
    player_system.PLAYERS_GLOBAL_INFORMATION[player_id].quest_current_data = quest_current_data
    player_system.PLAYERS_GLOBAL_INFORMATION[player_id].quest_data = quest_data
    --CustomTables:SetTableValue('woda_player_data', tostring(player_id), player_system.PLAYERS_GLOBAL_INFORMATION[player_id])
end

function player_system:SendQuestToServer()
	if GameRules:IsCheatMode() and not IsInToolsMode() then return end
	if (player_system:GetPlayerCountAll() >= 7 or GetMapName() == "arena") or IsInToolsMode() then
        for id, player_info in pairs(player_system.PLAYERS_GLOBAL_INFORMATION) do
            player_system:UpdateQuestsEndGame(id)
        end
	    local post_data = 
	    { 
	        players = {}
	    }
	    for id, player_info in pairs(player_system.PLAYERS_GLOBAL_INFORMATION) do
	        local player_table = 
	        {
	            steamid = player_info.steamid,
                quest_current_data = player_info.quest_current_data,
	        }
	        table.insert(post_data.players, player_table)
	    end
	    SendData('https://' ..player_system.site_url .. '/data/player_data_quests.php', post_data, nil)
	end
end

function player_system:UpdateQuestsEndGame(player_id)
    if PLAYERS[player_id] == nil then return end
    local player_hero = PLAYERS[player_id].hero
    if player_hero == nil then return end
    if player_hero:IsNull() then return end
    local player_data = player_system.PLAYERS_GLOBAL_INFORMATION[player_id]
    if player_data == nil then return end
    if player_hero.IsMainAtturibute == nil then return end
    local player_place = 0
    local duel_streak = 0
    local player_networth = 0
    local current_map = GetMapName()
    if PLAYERS[player_id].place ~= nil then
        player_place = PLAYERS[player_id].place
    end
    if PLAYERS[player_id].duel_streak ~= nil then
        duel_streak = PLAYERS[player_id].duel_streak
    end
    if PLAYERS_NETWORTHS[player_id] then
        player_networth = PLAYERS_NETWORTHS[player_id].networths
    end
    if string.find(current_map, "rating") or IsInToolsMode() then
        if player_place == 1 then
            local get_hero_quest = _G.QUESTS_HERO_WIN[player_hero:GetUnitName()]
            if get_hero_quest then
                player_system:PlayerQuestProgress(player_id, get_hero_quest, 1)
            end
        end
    end

    if player_hero.IsMainAtturibute == 0 then
        if string.find(current_map, "rating") or IsInToolsMode() then
            if player_place == 1 then
                player_system:PlayerQuestProgress(player_id, 1, 1)
                player_system:PlayerQuestProgress(player_id, 2, 1)
                if player_hero:GetKills() <= 0 then
                    player_system:PlayerQuestProgress(player_id, 3, 1)
                end
                if player_hero:GetDeaths() <= 0 then
                    player_system:PlayerQuestProgress(player_id, 4, 1)
                end
                if player_networth >= 60000 then
                    player_system:PlayerQuestProgress(player_id, 14, 1)
                end
            end
            if player_hero:GetKills() >= 70 then
                player_system:PlayerQuestProgress(player_id, 9, 1)
            end
            if player_hero:GetLastHits() >= 550 then
                player_system:PlayerQuestProgress(player_id, 10, 1)
            end
            if duel_streak >= 7 then
                player_system:PlayerQuestProgress(player_id, 11, 1)
            end
        end
    end
    if player_hero.IsMainAtturibute == 1 then
        if string.find(current_map, "rating") or IsInToolsMode() then
            if player_place == 1 then
                player_system:PlayerQuestProgress(player_id, 23, 1)
                player_system:PlayerQuestProgress(player_id, 24, 1)
                if player_hero:GetKills() <= 0 then
                    player_system:PlayerQuestProgress(player_id, 25, 1)
                end
                if player_hero:GetDeaths() <= 0 then
                    player_system:PlayerQuestProgress(player_id, 26, 1)
                end
                if player_networth >= 60000 then
                    player_system:PlayerQuestProgress(player_id, 36, 1)
                end
            end
            if player_hero:GetKills() >= 70 then
                player_system:PlayerQuestProgress(player_id, 31, 1)
            end
            if player_hero:GetLastHits() >= 550 then
                player_system:PlayerQuestProgress(player_id, 32, 1)
            end
            if duel_streak >= 7 then
                player_system:PlayerQuestProgress(player_id, 33, 1)
            end
        end
    end
    if player_hero.IsMainAtturibute == 2 then
        if string.find(current_map, "rating") or IsInToolsMode() then
            if player_place == 1 then
                player_system:PlayerQuestProgress(player_id, 45, 1)
                player_system:PlayerQuestProgress(player_id, 46, 1)
                if player_hero:GetKills() <= 0 then
                    player_system:PlayerQuestProgress(player_id, 47, 1)
                end
                if player_hero:GetDeaths() <= 0 then
                    player_system:PlayerQuestProgress(player_id, 48, 1)
                end
                if player_networth >= 60000 then
                    player_system:PlayerQuestProgress(player_id, 58, 1)
                end
            end
            if player_hero:GetKills() >= 70 then
                player_system:PlayerQuestProgress(player_id, 53, 1)
            end
            if player_hero:GetLastHits() >= 550 then
                player_system:PlayerQuestProgress(player_id, 54, 1)
            end
            if duel_streak >= 7 then
                player_system:PlayerQuestProgress(player_id, 55, 1)
            end
        end
    end
    if player_hero.IsMainAtturibute == 3 then
        if string.find(current_map, "rating") or IsInToolsMode() then
            if player_place == 1 then
                player_system:PlayerQuestProgress(player_id, 67, 1)
                player_system:PlayerQuestProgress(player_id, 68, 1)
                if player_hero:GetKills() <= 0 then
                    player_system:PlayerQuestProgress(player_id, 69, 1)
                end
                if player_hero:GetDeaths() <= 0 then
                    player_system:PlayerQuestProgress(player_id, 70, 1)
                end
            end
            if player_hero:GetKills() >= 70 then
                player_system:PlayerQuestProgress(player_id, 75, 1)
            end
            if player_hero:GetLastHits() >= 550 then
                player_system:PlayerQuestProgress(player_id, 76, 1)
            end
            if duel_streak >= 7 then
                player_system:PlayerQuestProgress(player_id, 77, 1)
            end
            if player_networth >= 60000 then
                player_system:PlayerQuestProgress(player_id, 80, 1)
            end
        end
    end
end

function player_system:CheckBossKilled(player_id)
    if PLAYERS[player_id] == nil then return end
    local player_hero = PLAYERS[player_id].hero
    if player_hero == nil then return end
    if player_hero:IsNull() then return end
    local player_data = player_system.PLAYERS_GLOBAL_INFORMATION[player_id]
    if player_data == nil then return end
    if player_hero.IsMainAtturibute == nil then return end
    local current_map = GetMapName()
    if player_hero.IsMainAtturibute == 0 then
        if string.find(current_map, "rating") then
            player_system:PlayerQuestProgress(player_id, 5, 1)
        elseif current_map == "arena" then
            player_system:PlayerQuestProgress(player_id, 6, 1)
        end
    end
    if player_hero.IsMainAtturibute == 1 then
        if string.find(current_map, "rating") then
            player_system:PlayerQuestProgress(player_id, 27, 1)
        elseif current_map == "arena" then
            player_system:PlayerQuestProgress(player_id, 28, 1)
        end
    end
    if player_hero.IsMainAtturibute == 2 then
        if string.find(current_map, "rating") then
            player_system:PlayerQuestProgress(player_id, 49, 1)
        elseif current_map == "arena" then
            player_system:PlayerQuestProgress(player_id, 50, 1)
        end
    end
    if player_hero.IsMainAtturibute == 3 then
        if string.find(current_map, "rating") then
            player_system:PlayerQuestProgress(player_id, 71, 1)
        elseif current_map == "arena" then
            player_system:PlayerQuestProgress(player_id, 72, 1)
        end
    end
end

function player_system:CheckAttributeQuest(player_id, quest_id_str, quest_id_agi, quest_id_int, quest_id_all)
    if PLAYERS[player_id] == nil then return end
    local player_hero = PLAYERS[player_id].hero
    if player_hero == nil then return end
    if player_hero:IsNull() then return end
    local player_data = player_system.PLAYERS_GLOBAL_INFORMATION[player_id]
    if player_data == nil then return end
    if player_hero.IsMainAtturibute == nil then return end
    local current_map = GetMapName()
    if player_hero.IsMainAtturibute == 0 and quest_id_str ~= nil then
        player_system:PlayerQuestProgress(player_id, quest_id_str, 1)
    end
    if player_hero.IsMainAtturibute == 1 and quest_id_agi ~= nil then
        player_system:PlayerQuestProgress(player_id, quest_id_agi, 1)
    end
    if player_hero.IsMainAtturibute == 2 and quest_id_int ~= nil then
        player_system:PlayerQuestProgress(player_id, quest_id_int, 1)
    end
    if player_hero.IsMainAtturibute == 3 and quest_id_all ~= nil then
        player_system:PlayerQuestProgress(player_id, quest_id_all, 1)
    end
end

function player_system:UpdatePlayerBPLevelsHero(id)
    local exp_table = 
    {
        [0] = 0,
        [1] = 10,
        [2] = 20,
        [3] = 30,
        [4] = 40,
        [5] = 50,
        [6] = 60,
        [7] = 70,
        [8] = 80,
        [9] = 90,
        [10] = 100,
        [11] = 110,
        [12] = 120,
        [13] = 130,
        [14] = 140,
        [15] = 150,
        [16] = 160,
        [17] = 170,
        [18] = 180,
        [19] = 190,
        [20] = 200,
        [21] = 210,
        [22] = 220,
        [23] = 230,
        [24] = 240,
        [25] = 250,
        [26] = 260,
        [27] = 270,
        [28] = 280,
        [29] = 290,
        [30] = 300,
    }

    for _, hero_info in pairs(player_system.PLAYERS_GLOBAL_INFORMATION[id]["heroes_level"]) do
        local hero_level = player_system:GetLevelByCoins(tonumber(hero_info.coins), exp_table)
        local hero_name = hero_info.hero
        if hero_level >= 30 then
            if _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_STRENGTH" then
                player_system:PlayerQuestProgress(id, 22, 1, true)
            elseif _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_AGILITY" then
                player_system:PlayerQuestProgress(id, 44, 1, true)
            elseif _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_INTELLECT" then
                player_system:PlayerQuestProgress(id, 66, 1, true)
            elseif _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_ALL" then
                player_system:PlayerQuestProgress(id, 88, 1, true)
            end
        end
        if hero_level >= 25 then
            if _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_STRENGTH" then
                player_system:PlayerQuestProgress(id, 21, 1, true)
            elseif _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_AGILITY" then
                player_system:PlayerQuestProgress(id, 43, 1, true)
            elseif _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_INTELLECT" then
                player_system:PlayerQuestProgress(id, 65, 1, true)
            elseif _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_ALL" then
                player_system:PlayerQuestProgress(id, 87, 1, true)
            end
        end
        if hero_level >= 18 then
            if _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_STRENGTH" then
                player_system:PlayerQuestProgress(id, 20, 1, true)
            elseif _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_AGILITY" then
                player_system:PlayerQuestProgress(id, 42, 1, true)
            elseif _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_INTELLECT" then
                player_system:PlayerQuestProgress(id, 64, 1, true)
            elseif _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_ALL" then
                player_system:PlayerQuestProgress(id, 86, 1, true)
            end
        end
        if hero_level >= 12 then
            if _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_STRENGTH" then
                player_system:PlayerQuestProgress(id, 19, 1, true)
            elseif _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_AGILITY" then
                player_system:PlayerQuestProgress(id, 41, 1, true)
            elseif _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_INTELLECT" then
                player_system:PlayerQuestProgress(id, 63, 1, true)
            elseif _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_ALL" then
                player_system:PlayerQuestProgress(id, 85, 1, true)
            end
        end
        if hero_level >= 6 then
            if _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_STRENGTH" then
                player_system:PlayerQuestProgress(id, 18, 1, true)
            elseif _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_AGILITY" then
                player_system:PlayerQuestProgress(id, 40, 1, true)
            elseif _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_INTELLECT" then
                player_system:PlayerQuestProgress(id, 62, 1, true)
            elseif _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_ALL" then
                player_system:PlayerQuestProgress(id, 84, 1, true)
            end
        end
        if hero_level >= 1 then
            if _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_STRENGTH" then
                player_system:PlayerQuestProgress(id, 17, 1, true)
            elseif _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_AGILITY" then
                player_system:PlayerQuestProgress(id, 39, 1, true)
            elseif _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_INTELLECT" then
                player_system:PlayerQuestProgress(id, 61, 1, true)
            elseif _G.HEROES_LIST_CUSTOM[hero_name] and _G.HEROES_LIST_CUSTOM[hero_name].AttributePrimary == "DOTA_ATTRIBUTE_ALL" then
                player_system:PlayerQuestProgress(id, 83, 1, true)
            end
        end
    end
end

function player_system:GetLevelByCoins(coins, exp_table)
    local full_sum = 0
    local level_end = 30
    for cc = 0, 31 do
        full_sum = full_sum + (exp_table[cc] or 0)
        if (coins < full_sum) then
            level_end = cc - 1
            break
        end
    end
    return level_end
end

function player_system:SelectHeroVO(data)
    if data.PlayerID == nil then return end
    local player = PlayerResource:GetPlayer(data.PlayerID)
    local hero_name = PlayerResource:GetSelectedHeroName(data.PlayerID)
    if hero_name == "" then return end
    if not player.sound_cooldown then
        player.sound_cooldown = {0, 0}
    end
    if (player.sound_cooldown[1] > 0) and (player.sound_cooldown[2] > 0) then
        local player = PlayerResource:GetPlayer(data.PlayerID)
        if player then
            local cooldown_sound = math.max(player.sound_cooldown[1], player.sound_cooldown[2])
            CustomGameEventManager:Send_ServerToPlayer(player, "panorama_cooldown_error", {message="#dota_sound_error", time=cooldown_sound})
        end
        return
    end
    if player.sound_cooldown[1] > 0 then
        player.sound_cooldown[2] = 30
        Timers:CreateTimer({
            useGameTime = false,
            endTime = 1,
            callback = function()
                if player.sound_cooldown[2] <= 0 then return nil end
                player.sound_cooldown[2] = player.sound_cooldown[2] - 1
                return 1
            end
        })
    else
        player.sound_cooldown[1] = 30
        Timers:CreateTimer({
            useGameTime = false,
            endTime = 1,
            callback = function()
                if player.sound_cooldown[1] <= 0 then return nil end
                player.sound_cooldown[1] = player.sound_cooldown[1] - 1
                return 1
            end
        })
    end
    CustomGameEventManager:Send_ServerToAllClients( 'chat_dota_sound', {hero_name = hero_name, player_id = data.PlayerID, sound_name = data.sound, sound_name_global = data.message, level = data.level})
end

function player_system:donate_shop_get_hero_votes(data)
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(data.PlayerID), "donate_shop_set_hero_votes", player_system.HEROES_VOTES_DATA)
end

function player_system:donate_shop_get_top_rating(data)
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(data.PlayerID), "donate_shop_set_top_rating", player_system.TOP_RATING_DATA)
end

function player_system:battlepass_get_player_reward(data)
	if data.PlayerID == nil then return end
    local player_id = data.PlayerID
    local level = tonumber(data.level)
    local reward_id = tonumber(data.reward_id)
    local player_data = player_system.PLAYERS_GLOBAL_INFORMATION[player_id]
    if player_data == nil then return end
    if level == nil or reward_id == nil then return end
    if _G.BATTLEPASS_REWARDS[reward_id] == nil then return end
    if player_system:HasDonateItem(player_data, reward_id) then return end
    if data.battlepass_2026 then
        if player_data.battlepass_level_2026 <= 0 then return end
        if player_data.has_battlepass_2026 <= 0 then return end
        if player_data.battlepass_level_2026 < level then return end
        if player_data.battlepass_level_2026 < _G.BATTLEPASS_REWARDS[reward_id] then return end
    else
        if player_data.battlepass_level <= 0 then return end
        if player_data.has_battlepass <= 0 then return end
        if player_data.battlepass_level < level then return end
        if player_data.battlepass_level < _G.BATTLEPASS_REWARDS[reward_id] then return end
    end
    table.insert(player_data.donate_items, tonumber(reward_id))
    local plus_days = 0
    local bonus_coins = 0
    local bonus_tokens = 0
    if _G.BATTLEPASS_REWARDS_TYPES[reward_id] then
        if _G.BATTLEPASS_REWARDS_TYPES[reward_id][1] == "coins" then
            player_data.coins = player_data.coins + _G.BATTLEPASS_REWARDS_TYPES[reward_id][2]
            bonus_coins = _G.BATTLEPASS_REWARDS_TYPES[reward_id][2]
        elseif _G.BATTLEPASS_REWARDS_TYPES[reward_id][1] == "plus" then
            player_data.plus_days = player_data.plus_days + _G.BATTLEPASS_REWARDS_TYPES[reward_id][2]
            plus_days = _G.BATTLEPASS_REWARDS_TYPES[reward_id][2]
        elseif _G.BATTLEPASS_REWARDS_TYPES[reward_id][1] == "double_token" then
            player_data.double_tokens = player_data.double_tokens + _G.BATTLEPASS_REWARDS_TYPES[reward_id][2]
            bonus_tokens = _G.BATTLEPASS_REWARDS_TYPES[reward_id][2]
        end
    end
    CustomTables:SetTableValue('woda_player_data', tostring(player_id), player_data)
    local post_data = 
    {
        player = 
        {
            {
                steamid = PlayerResource:GetSteamAccountID(player_id),
                player_coin = bonus_coins,
                item_id = reward_id,
                days = plus_days,
                tokens = bonus_tokens,
            }
        },
    }
    SendData('https://' ..player_system.site_url .. '/data/give_reward_bp.php', post_data, nil)
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(player_id), "shop_set_currency", {crystall = player_data.crystals, coin = player_data.coins, plus_days = player_data.plus_days} )
end

function player_system:win_condition_predict(data)
	if data.PlayerID == nil then return end
    local player_id = data.PlayerID
    local player_data = player_system.PLAYERS_GLOBAL_INFORMATION[player_id]
    if player_data == nil then return end
    if PLAYERS[player_id] == nil then return end
    if player_data.double_tokens <= 0 then return end
    PLAYERS[player_id].player_doubled = true
end

function player_system:DoubleTokenRelease()
    if DISCONNECT_FREE then return end
    for id, info in pairs(PLAYERS) do
        if info.player_doubled then
            player_system:UpdateTokenServer(id)
        end
    end
end

function player_system:UpdateTokenServer(player_id)
    local post_data = 
    {
        player = 
        {
            {
                steamid = PlayerResource:GetSteamAccountID(player_id),
            }
        },
    }
    SendData('https://' ..player_system.site_url .. '/data/steal_token.php', post_data, nil)
end

function player_system:UpdatePlayerSetItem(params)
	local player_id = params.PlayerID
    print("closed store")
    if GameRules:IsCheatMode() and not IsInToolsMode() then return end
    local post_data = 
    { 
        players = {}
    }
    for id, player_info in pairs(player_system.PLAYERS_GLOBAL_INFORMATION) do
        local player_table = 
        {
            steamid = player_info.steamid,
            pet_id = player_info.pet_id or 0,
            effect_id = player_info.effect_id or 0,
            five_id = player_info.five_id or 0,
            background_id = player_info.background_id or 0,
            teleport_id = player_info.teleport_id or 0,
            tips = player_info.tips or {},
            equipped_runes = player_info.equipped_runes or {},
        }
        table.insert(post_data.players, player_table)
    end
    SendData('https://' ..player_system.site_url .. '/data/update_items_server.php', post_data, nil)
end