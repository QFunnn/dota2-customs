--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


_G.hero_select = class({})

PICK_STATE_PLAYERS_LOADED = "PICK_STATE_PLAYERS_LOADED"
PICK_STATE_CHOOSE_MODE = "PICK_STATE_CHOOSE_MODE"
PICK_STATE_BAN = "PICK_STATE_BAN"
PICK_STATE_TOURNAMENT_BANS = "PICK_STATE_TOURNAMENT_BANS"
PICK_STATE_SELECT_HERO = "PICK_STATE_SELECT_HERO"
PICK_STATE_PICK_PRE_END = "PICK_STATE_PICK_PRE_END"
PICK_STATE_PICK_END = "PICK_STATE_PICK_END"

PICK_STATE = PICK_STATE_PLAYERS_LOADED
TIME_OF_STATE = 30
TIME_TO_PICK_HERO = 20
TIME_TO_BAN_HERO = 10
LOBBY_PLAYERS = {}
LOBBY_PLAYERS_MAX = 0
HEROES_FOR_PICK = {}
PICKED_HEROES = {}
BANNED_HEROES = {}
PICK_ORDER = 0
BAN_ORDER = 0
PLAYER_IS_BAN_NEXT = false
_G.IN_STATE = false
TIME_TO_GAME = 5
BONUS_RANDOM_GOLD = 100
DEFAULT_GOLD = 600
hero_select.BANS_COUNTER_SAVE = 0
MAX_BANS_COUNTER = 0

hero_select.SELECTED_HEROES = {}
hero_select.SELECTED_HEROES_DISCONNECTED = {}
hero_select.START_GOLD_PLAYERS = {}
hero_select.IsTournamentMode = false
hero_select.PlayerSelectTournamentMode = {}
hero_select.VotingPlayersBansCounter = 
{
    ["1"] = 0,
    ["2"] = 0,
    ["3"] = 0,
    ["4"] = 0,
}
hero_select.VotingPlayersBansCounterPlayerBox = {}

hero_select.IsRandomHeroes = false
hero_select.VotingPlayersRandomHeroesPlayerBox = {}
hero_select.VotingPlayersRandomHeroesCounter = 
{
    ["1"] = 0,
    ["2"] = 0
}

DONATE_HEROES = 
{
    -- "npc_dota_hero_nevermore",
    -- "npc_dota_hero_tidehunter",
    -- "npc_dota_hero_skywrath_mage",
    -- "npc_dota_hero_pudge",
    -- "npc_dota_hero_furion",
    -- "npc_dota_hero_phantom_assassin",
    -- "npc_dota_hero_doom_bringer",
    -- "npc_dota_hero_death_prophet",
    -- "npc_dota_hero_invoker",
    -- "npc_dota_hero_terrorblade",
    -- "npc_dota_hero_vengefulspirit",
    -- "npc_dota_hero_legion_commander",
    -- "npc_dota_hero_lion",
    -- "npc_dota_hero_kunkka",
    -- "npc_dota_hero_slardar",
    -- "npc_dota_hero_morphling",
    -- "npc_dota_hero_slark",
    -- "npc_dota_hero_disruptor",
    -- "npc_dota_hero_juggernaut",
    -- "npc_dota_hero_spectre",
    -- "npc_dota_hero_bristleback",
}

if true then
    DONATE_HEROES = {}
end

function hero_select:init()
    _G.IN_STATE = true

    CustomTables:SetTableValue(
        "custom_pick",
        "pick_state",
        {
            in_progress = true
        }
    )

    RegisterLoadListener(
        function(player, playerID)
            hero_select:PlayerLoaded(player, playerID)
        end
    )

    CustomGameEventManager:RegisterListener( "pick_player_connected", Dynamic_Wrap( self, "PlayerConnected" ) )
    CustomGameEventManager:RegisterListener( "chose_hero", Dynamic_Wrap(self, "ChoseHero"))
    --CustomGameEventManager:RegisterListener( "PlayerChooseTournamentMode", Dynamic_Wrap(self, "PlayerChooseTournamentMode"))
    CustomGameEventManager:RegisterListener( "select_tournament_ban_counter", Dynamic_Wrap(self, "select_tournament_ban_counter"))
    CustomGameEventManager:RegisterListener( "select_tournament_random_heroes", Dynamic_Wrap(self, "select_tournament_random_heroes"))
    CustomGameEventManager:RegisterListener( "select_ban_hero", Dynamic_Wrap(self, "select_ban_hero"))

    for i = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        if PlayerResource:IsValidTeamPlayerID(i) then
            self:RegisterPlayerInfo(i)
        end
    end

    if IsInToolsMode() then
        -- self:RegisterFakePlayer(1)
        -- self:RegisterFakePlayer(2)
        -- self:RegisterFakePlayer(3)
    end

    self:CheckReadyPlayers()
end

function hero_select:PlayerChooseTournamentMode(params)
    local player_id = params.PlayerID
    if hero_select.PlayerSelectTournamentMode[player_id] then return end
    hero_select.PlayerSelectTournamentMode[player_id] = true
    CustomGameEventManager:Send_ServerToAllClients("event_player_select_tournament_mode_announce", {pid = player_id})
end

function hero_select:CheckReadyPlayers(attempt)
    if PICK_STATE ~= PICK_STATE_PLAYERS_LOADED then
        return
    end

    local bAllReady = true
    for pid, pinfo in pairs(LOBBY_PLAYERS) do
        if pinfo.bRegistred and not pinfo.bLoaded then
            bAllReady = false
        end
    end

    if bAllReady then
        hero_select:Start()
    else
        local check_interval = 0.5
        attempt = (attempt or 0) + check_interval
        if attempt > TIME_OF_STATE then
            hero_select:Start()
        else
            Timers:CreateTimer(
                "",
                {
                    useGameTime = false,
                    endTime = check_interval,
                    callback = function()
                        hero_select:CheckReadyPlayers(attempt)
                    end
                }
            )
        end
    end
end

function hero_select:GetState()
    return PICK_STATE
end

function hero_select:PlayerConnected(params)
	if params.PlayerID == nil then return end
    local pinfo = hero_select:RegisterPlayerInfo(params.PlayerID)
    pinfo.bRegistred = true
    pinfo.bLoaded = true
end

function hero_select:PlayerLoaded(player, pid)
    if player == nil then return end

    if not LOBBY_PLAYERS[pid] then
        CustomGameEventManager:Send_ServerToPlayer(player, "pick_end", {})
        arena_system:SetMinimapPlayer(pid, 4)
        return
    end

    LOBBY_PLAYERS[pid].bLoaded = true

    local team = PlayerResource:GetTeam(pid)
    local hero = PlayerResource:GetSelectedHeroEntity(pid)

    if hero ~= nil then
        hero:SetOwner(player)
        hero:SetControllableByPlayer(pid, true)
        player:SetAssignedHeroEntity(hero)
        for _, mod in pairs(hero:FindAllModifiers()) do
            if mod.UpdateTalent and mod.UpdateTalent == true then
                hero:AddNewModifier(hero, nil, mod:GetName(), {})
            end
        end
    end

    if not IN_STATE then
        CustomGameEventManager:Send_ServerToPlayer(player, "pick_end", {})
        arena_system:SetMinimapPlayer(pid, 4)
        Timers:CreateTimer(1.5, function()
            local player = PlayerResource:GetPlayer(pid)
            if player == nil then
                return
            end
            if hero == nil then
                return
            end
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
        end)

        return
    end

    if PICK_STATE ~= PICK_STATE_PLAYERS_LOADED then
        hero_select:DrawPickScreenForPlayer(pid)
        if PICK_STATE == PICK_STATE_SELECT_HERO or PICK_STATE == PICK_STATE_PICK_PRE_END  then
            CustomGameEventManager:Send_ServerToPlayer( player, "reload_pick_heroes", { lobby_players = LOBBY_PLAYERS,  } )
        elseif PICK_STATE == PICK_STATE_PICK_END then
            CustomGameEventManager:Send_ServerToPlayer(player, "pick_end", {})
            arena_system:SetMinimapPlayer(pid, 4)
        end
    end
end

function hero_select:RegisterHeroes()
    local enable_heroes = {}
    local hero_list = {}
    local heroes = LoadKeyValues("scripts/npc/activelist.txt")
    local heroes_custom_info = LoadKeyValues("scripts/npc/npc_heroes_custom.txt")
    local abilities_list_custom = LoadKeyValues("scripts/npc/npc_abilities_custom.txt")
    local innates_ignore_move =
    {
        ["dawnbreaker_break_of_dawn_custom"] = true,
        ["dragon_knight_dragon_blood_custom"] = true,
        ["huskar_blood_magic"] = true,
    }
    local enable_hud_abilities =
    {
        ["lone_druid_spirit_bear_custom"] = true,
        ["monkey_king_mischief_custom"] = true,
        ["phantom_assassin_blur_custom"] = true,
        ["disruptor_electromagnetic_repulsion_custom"] = true,
        ["invoker_invoke_custom"] = true,
        ["lich_death_charge_custom"] = true,
        ["roshan_strength_of_the_immortal_custom"] = true,
        ["marci_special_delivery_custom"] = true,
        ["kez_switch_weapons_custom"] = true,
    }
    for hero_name, is_enable in pairs(heroes) do
        if is_enable == 1 then
            table.insert(enable_heroes, hero_name)
        end
    end
    for _, hero_name in pairs(enable_heroes) do
        local hero_info = heroes_custom_info[hero_name]
        local abilities_list = {}
        if hero_info then
            local innate_ability_name = nil
            for ability_id = 1, 20 do
                local ability = hero_info["Ability" .. ability_id]
                if ability and ability ~= "" and ability ~= "generic_hidden" then
                    local behavior = nil
                    local is_innate = false
                    local ability_info = abilities_list_custom[ability]
                    if not ability_info then
                        local default_dota_values = LoadKeyValues("scripts/npc/heroes/"..hero_name..".txt")
                        if default_dota_values and default_dota_values[ability] then
                            ability_info = default_dota_values[ability]
                        end
                    end
                    if ability_info then
                        behavior = ability_info.AbilityBehavior
                        if ability_info.Innate then
                            is_innate = true
                        end
                    end
                    if is_innate then
                        innate_ability_name = ability
                    end
                    if is_innate and behavior and (behavior:find("DOTA_ABILITY_BEHAVIOR_HIDDEN") or behavior:find("DOTA_ABILITY_BEHAVIOR_INNATE_UI") or innates_ignore_move[ability]) then
                        --table.insert(abilities_list, 1, ability)
                    elseif not is_innate and behavior and not behavior:find("DOTA_ABILITY_BEHAVIOR_HIDDEN") then
                        table.insert(abilities_list, ability)
                    end
                    if enable_hud_abilities[ability] then
                        table.insert(abilities_list, ability)
                    end
                end
            end
            CustomTables:SetTableValue("custom_pick", tostring(hero_name), abilities_list)
            if innate_ability_name then
                CustomTables:SetTableValue("custom_pick", tostring(hero_name).."_innate", {ability_name = innate_ability_name})
            end
        end
    end

    HEROES_FOR_PICK = enable_heroes

    local sort_heroes = {[0]={}, [1]={}, [2]={}, [3]={}}
    for _, hero in pairs(enable_heroes) do
        if heroes_custom_info[hero].AttributePrimary == "DOTA_ATTRIBUTE_STRENGTH" then
            hero_list[hero] = 0
            table.insert(sort_heroes[0], hero)
        elseif heroes_custom_info[hero].AttributePrimary == "DOTA_ATTRIBUTE_AGILITY" then
            hero_list[hero] = 1
            table.insert(sort_heroes[1], hero)
        elseif heroes_custom_info[hero].AttributePrimary == "DOTA_ATTRIBUTE_INTELLECT" then
            hero_list[hero] = 2
            table.insert(sort_heroes[2], hero)
        elseif heroes_custom_info[hero].AttributePrimary == "DOTA_ATTRIBUTE_ALL" then
            hero_list[hero] = 3
            table.insert(sort_heroes[3], hero)
        end
    end

    CustomTables:SetTableValue("custom_pick", "donate_heroes", DONATE_HEROES)
    CustomTables:SetTableValue("custom_pick", "hero_list", hero_list)
end

function IsHeroDonate(hero, id)
    if player_system.PLAYERS_GLOBAL_INFORMATION[id] and player_system.PLAYERS_GLOBAL_INFORMATION[id].donate_heroes ~= nil then
        for _, hero_info in pairs(player_system.PLAYERS_GLOBAL_INFORMATION[id].donate_heroes) do
            if hero_info.hero_name == hero and tonumber(hero_info.days) > 0 then
                return false
            end
        end
    end
    for _, donate in pairs(FREE_HEROES) do
        if hero == donate then
            return false
        end
    end
    for _, donate in pairs(DONATE_HEROES) do
        if hero == donate then
            return true
        end
    end
    return false
end

function hero_select:RegisterPlayerInfo(pid)
    if PlayerResource:GetSteamAccountID(pid) == 0 then
        return
    end
    local pinfo = LOBBY_PLAYERS[pid]
    if pinfo == nil then
        pinfo = {
            bRegistred = false,
            bLoaded = false,
            steamid = PlayerResource:GetSteamAccountID(pid),
            picked_hero = nil,
            pick_order = nil,
            respawn = false,
            bans_counter = 0,
        }
        LOBBY_PLAYERS_MAX = LOBBY_PLAYERS_MAX + 1
        if PICK_STATE ~= PICK_STATE_PLAYERS_LOADED then
            pinfo.pick_order = LOBBY_PLAYERS_MAX - 1
        end
    end
    LOBBY_PLAYERS[pid] = pinfo
    return pinfo
end

function hero_select:RegisterFakePlayer(pid)
    local pinfo = LOBBY_PLAYERS[pid]
    if pinfo == nil then
        pinfo = 
        {
            bRegistred = false,
            bLoaded = false,
            steamid = PlayerResource:GetSteamAccountID(pid),
            picked_hero = nil,
            pick_order = nil,
            respawn = false,
            bans_counter = 0,
        }
        LOBBY_PLAYERS_MAX = LOBBY_PLAYERS_MAX + 1
    end
    LOBBY_PLAYERS[pid] = pinfo
    return pinfo
end

function hero_select:AllPlayersRespawn()
    for _, info in pairs(LOBBY_PLAYERS) do
        if info and info.respawn == false then
            return false
        end
    end
    return true
end

function hero_select:Start()
    local r = 0
    local used_numbers = {}

    for i, player in pairs(LOBBY_PLAYERS) do
        repeat
            r = RandomInt(0, LOBBY_PLAYERS_MAX - 1)
        until not hero_select:check_used(used_numbers, r)
        used_numbers[#used_numbers + 1] = r
        player.pick_order = r
    end

    local place_admin = 0
    local place_normal = 1

    local first_pick_id = 
    {
        ['883703644'] = true,
        ['122413750'] = true,
        ['181517303'] = true,
        ['1602096619'] = true,
        ['1899469460'] = true
    }

    if LOBBY_PLAYERS_MAX > 1 then
        for i, player in pairs(LOBBY_PLAYERS) do
            if LOBBY_PLAYERS[i].pick_order == 0 then
                place_normal = i
            end
        end

        for i, player in pairs(LOBBY_PLAYERS) do
            if first_pick_id[tostring(LOBBY_PLAYERS[i].steamid)] == true then
                place_admin = LOBBY_PLAYERS[i].pick_order

                LOBBY_PLAYERS[i].pick_order = 0
                LOBBY_PLAYERS[place_normal].pick_order = place_admin
                break
            end
        end
    end
    
    CustomTables:SetTableValue(
        "custom_pick",
        "player_lobby",
        {
            lobby_players = LOBBY_PLAYERS,
            lobby_players_length = LOBBY_PLAYERS_MAX
        }
    )

    for pid, pinfo in pairs(LOBBY_PLAYERS) do
        if pinfo.bLoaded then
            hero_select:DrawPickScreenForPlayer(pid)
        end  
    end

    player_system:UpdateReportsInfo()
    if string.find(GetMapName(), "rating") then
        hero_select:StartChooseGameMode()
    else
        hero_select:StartSelectionStage()
    end
end

function hero_select:StartChooseGameMode()
    PICK_STATE = PICK_STATE_CHOOSE_MODE
    Timers:CreateTimer(
        "",
        {
            useGameTime = false,
            endTime = 1,
            callback = function()
                if string.find(GetMapName(), "rating") then
                    --CustomGameEventManager:Send_ServerToAllClients("enable_tournament_button_player", {})
                end
                hero_select:ChooseModeWaiting()
            end
        }
    )
end

function hero_select:ChooseModeWaiting()
    local time_choose_mode = 3
    if IsInToolsMode() then
        --time_choose_mode = 0
    end
    CustomGameEventManager:Send_ServerToAllClients("change_time", {time = time_choose_mode})
    Timers:CreateTimer(
        "",
        {
            useGameTime = false,
            endTime = 1,
            callback = function()
                time_choose_mode = time_choose_mode - 1
                player_system:DisconnectPlayerChecked()
                if time_choose_mode <= 0 then
                    hero_select:PreModeChange()
                    return
                end
                CustomGameEventManager:Send_ServerToAllClients("change_time", {time = time_choose_mode})
                return 1
            end
        }
    )
end

function hero_select:PreModeChange()
    if not hero_select.IsTournamentMode then
        local players_counter_agree = 0
        for id, _ in pairs(hero_select.PlayerSelectTournamentMode) do
            players_counter_agree = players_counter_agree + 1
        end
        local player_to_mode_tournament = LOBBY_PLAYERS_MAX
        if LOBBY_PLAYERS_MAX == 7 or LOBBY_PLAYERS_MAX == 8 then
            player_to_mode_tournament = 6
        end
        if players_counter_agree >= player_to_mode_tournament then
            hero_select.IsTournamentMode = true
        end
    end
    CustomGameEventManager:Send_ServerToAllClients("event_tournament_mode_announce_clear", {})
    CustomGameEventManager:Send_ServerToAllClients("disable_tournament_button_player", {})

    if GetMapName() == "rating_300" or GetMapName() == "rating_duo_300" then
        hero_select.IsTournamentMode = true
    end

    if hero_select.IsTournamentMode then
        hero_select:StartPlayerSelectTournamentBans()
    else
        hero_select:StartSelectionStage(true)
    end
end

function hero_select:StartPlayerSelectTournamentBans()
    CustomGameEventManager:Send_ServerToAllClients("change_color_timer", {is_ban = 1})
    local time_select_ban = 20
    PICK_STATE = PICK_STATE_TOURNAMENT_BANS
    CustomGameEventManager:Send_ServerToAllClients("change_time", {time = time_select_ban})
    CustomGameEventManager:Send_ServerToAllClients("open_select_ban_counter", {})
    Timers:CreateTimer(
        "",
        {
            useGameTime = false,
            endTime = 1,
            callback = function()
                time_select_ban = time_select_ban - 1
                player_system:DisconnectPlayerChecked()
                if time_select_ban <= 0 then
                    CustomGameEventManager:Send_ServerToAllClients("close_select_ban_counter", {})
                    hero_select:StartBanState()
                    return
                end
                CustomGameEventManager:Send_ServerToAllClients("change_time", {time = time_select_ban})
                return 1
            end
        }
    )
end

function hero_select:StartBanState()
    PICK_STATE = PICK_STATE_BAN
    local bans_counter = 1
    local last_value = -1
    local is_random_notif = nil
    for ban_counter, counter in pairs(hero_select.VotingPlayersBansCounter) do
        if counter > last_value then
            bans_counter = tonumber(ban_counter)
            last_value = counter
        end
    end
    for pid, info in pairs(LOBBY_PLAYERS) do
        LOBBY_PLAYERS[pid].bans_counter = bans_counter
    end
    local how_much_players_to_random = 6
    if IsInToolsMode() then
        how_much_players_to_random = 1
    end
    if hero_select.VotingPlayersRandomHeroesCounter["1"] and hero_select.VotingPlayersRandomHeroesCounter["1"] >= how_much_players_to_random then
        hero_select.IsRandomHeroes = true
        is_random_notif = true
    end
    MAX_BANS_COUNTER = bans_counter
    hero_select.BANS_COUNTER_SAVE = bans_counter
    hero_select:UpdateOrdersPick()
    CustomGameEventManager:Send_ServerToAllClients("notification_tournament_data", {bans = bans_counter, random = is_random_notif})
    local time = 3
    CustomGameEventManager:Send_ServerToAllClients("change_time", {time = time, id = -1})
    Timers:CreateTimer(
        "",
        {
            useGameTime = false,
            endTime = 1,
            callback = function()
                time = time - 1
                CustomGameEventManager:Send_ServerToAllClients("change_time", {time = time, id = -1})
                if time <= 0 then
                    hero_select:StartBanOrderPick()
                    return
                end
                return 1
            end
        }
    )
end

function hero_select:select_tournament_ban_counter(params)
    local player_id = params.PlayerID
    if hero_select.VotingPlayersBansCounterPlayerBox[player_id] then return end
    hero_select.VotingPlayersBansCounterPlayerBox[player_id] = true
    if not hero_select.VotingPlayersBansCounter[tostring(params.counter)] then return end
    hero_select.VotingPlayersBansCounter[tostring(params.counter)] = hero_select.VotingPlayersBansCounter[tostring(params.counter)] + 1
end

function hero_select:select_tournament_random_heroes(params)
    local player_id = params.PlayerID
    if hero_select.VotingPlayersRandomHeroesPlayerBox[player_id] then return end
    hero_select.VotingPlayersRandomHeroesPlayerBox[player_id] = true
    if not hero_select.VotingPlayersRandomHeroesCounter[tostring(params.counter)] then return end
    hero_select.VotingPlayersRandomHeroesCounter[tostring(params.counter)] = hero_select.VotingPlayersRandomHeroesCounter[tostring(params.counter)] + 1
end

function hero_select:UpdateOrdersPick()
    local r = 0
    local used_numbers = {}

    for i, player in pairs(LOBBY_PLAYERS) do
        repeat
            r = RandomInt(0, LOBBY_PLAYERS_MAX - 1)
        until not hero_select:check_used(used_numbers, r)
        used_numbers[#used_numbers + 1] = r
        player.pick_order = r
    end
    
    CustomTables:SetTableValue("custom_pick", "player_lobby",
    {
        lobby_players = LOBBY_PLAYERS,
        lobby_players_length = LOBBY_PLAYERS_MAX
    })

    CustomGameEventManager:Send_ServerToAllClients("UpdatePlayersOrdersList", {})
end

function hero_select:StartBanOrderPick()
    PLAYER_IS_BAN_NEXT = false
    local time = TIME_TO_BAN_HERO
    local id = 0
    for pid, pinfo in pairs(LOBBY_PLAYERS) do
        if pinfo.pick_order == BAN_ORDER then
            CustomGameEventManager:Send_ServerToAllClients("pick_start_time", {id = pid, time = time})
            CustomTables:SetTableValue( "custom_pick", "active_player", { id = pid, is_ban = 1, is_ban_stage = true } )
            id = pid
            break
        end
    end
    CustomGameEventManager:Send_ServerToAllClients("change_time", {time = time, id = id})
    Timers:CreateTimer(
        "",
        {
            useGameTime = false,
            endTime = 1,
            callback = function()
                player_system:DisconnectPlayerChecked()
                time = time - 1
                CustomGameEventManager:Send_ServerToAllClients("change_time", {time = time, id = id})
                if time <= 0 or (PLAYER_IS_BAN_NEXT) then
                    if time <= 0 then
                        local rand_hero = hero_select:RandomHero(id)
                        hero_select:select_ban_hero({PlayerID = id, hero = rand_hero})
                    end
                    BAN_ORDER = BAN_ORDER + 1
                    if BAN_ORDER >= LOBBY_PLAYERS_MAX then
                        BAN_ORDER = 0
                        MAX_BANS_COUNTER = MAX_BANS_COUNTER - 1
                        hero_select:DelayCircleBans()
                        return
                    end
                    if MAX_BANS_COUNTER > 0 then
                        hero_select:StartBanOrderPick()
                    else
                        hero_select:StartSelectionStage(true)
                    end
                    return
                end
                return 1
            end
        }
    )
end

function hero_select:DelayCircleBans()
    local time = 3
    CustomTables:SetTableValue( "custom_pick", "active_player", { id = -1, is_ban = 1, is_ban_stage = true } )
    CustomGameEventManager:Send_ServerToAllClients("change_time", {time = time, id = -1})
    Timers:CreateTimer(
        "",
        {
            useGameTime = false,
            endTime = 1,
            callback = function()
                time = time - 1
                CustomGameEventManager:Send_ServerToAllClients("change_time", {time = time, id = -1})
                if time <= 0 then
                    CustomGameEventManager:Send_ServerToAllClients("ban_client_hero_reload", {})
                    if MAX_BANS_COUNTER > 0 then
                        hero_select:StartBanOrderPick()
                    else
                        hero_select:StartSelectionStage(true)
                    end
                    return
                end
                return 1
            end
        }
    )
end

function hero_select:select_ban_hero(params)
    local player_id = params.PlayerID
    local hero_name = params.hero
    if LOBBY_PLAYERS[player_id].bans_counter ~= MAX_BANS_COUNTER then return end
    if hero_select:check_picked(hero_name) then return end
    LOBBY_PLAYERS[player_id].bans_counter = LOBBY_PLAYERS[player_id].bans_counter - 1
    table.insert(BANNED_HEROES, hero_name)
    PLAYER_IS_BAN_NEXT = true
    CustomGameEventManager:Send_ServerToAllClients("ban_client_hero", {hero_name = hero_name, player_id = player_id})
    CustomTables:SetTableValue(
        "custom_pick",
        "player_list",
        {
            picked_heroes = PICKED_HEROES,
            banned_heroes = BANNED_HEROES,
        }
    )
end

function hero_select:StartSelectionStage(delay_minus)
    local delay = 1
    if delay_minus then
        delay = FrameTime()
    end
    PICK_STATE = PICK_STATE_SELECT_HERO
    Timers:CreateTimer(
        "",
        {
            useGameTime = false,
            endTime = delay,
            callback = function()
                hero_select:StartOrderPick()
            end
        }
    )
end

function hero_select:StartOrderPick()
    CustomGameEventManager:Send_ServerToAllClients("change_color_timer", {})
    local time = TIME_TO_PICK_HERO
    local id = nil
    for pid, pinfo in pairs(LOBBY_PLAYERS) do
        if pinfo.pick_order == PICK_ORDER then
            CustomGameEventManager:Send_ServerToAllClients("pick_start_time", {id = pid, time = time})
            CustomTables:SetTableValue(
                "custom_pick",
                "active_player",
                {
                    id = pid
                }
            )
            id = pid
            break
        end
    end

    if id == nil then
        PICK_ORDER = PICK_ORDER + 1
        if PICK_ORDER < LOBBY_PLAYERS_MAX + 1 then
            hero_select:StartOrderPick()
        else
            hero_select:check_picked_players()
        end
        return
    end

    CustomGameEventManager:Send_ServerToAllClients("change_time", {time = time, id = id})

    Timers:CreateTimer(
        "",
        {
            useGameTime = false,
            endTime = 1,
            callback = function()
                if LOBBY_PLAYERS_MAX ~= 1 then
                    time = time - 1
                end
                
                player_system:DisconnectPlayerChecked()
                CustomGameEventManager:Send_ServerToAllClients("change_time", {time = time, id = id, })

                if player_system.PLAYERS_GLOBAL_INFORMATION[id] then
                    local allow_random_hero = false
                    if string.find(GetMapName(), "rating") then
                        if player_system.PLAYERS_GLOBAL_INFORMATION[id].last_leave ~= nil and player_system.PLAYERS_GLOBAL_INFORMATION[id].last_leave == 1 then
                            allow_random_hero = true
                        end
                        if GetMapName() == "rating" or GetMapName() == "rating_300" then
                            if player_system.PLAYERS_GLOBAL_INFORMATION[id].has_report_random ~= nil and tonumber(player_system.PLAYERS_GLOBAL_INFORMATION[id].has_report_random) > 0 then
                                allow_random_hero = true
                            end
                        end
                    end
                    if allow_random_hero then
                        if LOBBY_PLAYERS[id].picked_hero == nil then
                            local rand_hero = hero_select:RandomHero(id)
                            hero_select:PickHero(id, rand_hero, 1, 1)
                        end
                    end
                end

                if hero_select.IsRandomHeroes then
                    if LOBBY_PLAYERS[id].picked_hero == nil then
                        local rand_hero = hero_select:RandomHero(id)
                        hero_select:PickHero(id, rand_hero, 1, 1)
                    end
                end

                if time <= 0 or (LOBBY_PLAYERS[id].picked_hero ~= nil) then
                    if LOBBY_PLAYERS[id].picked_hero == nil then
                        local rand_hero = hero_select:RandomHero(id)
                        hero_select:PickHero(id, rand_hero, 1, 1)
                    end

                    if PICK_STATE ~= PICK_STATE_SELECT_HERO then
                        return
                    end

                    PICK_ORDER = PICK_ORDER + 1

                    if PICK_ORDER < LOBBY_PLAYERS_MAX + 1 then
                        hero_select:StartOrderPick()
                    end

                    return
                end
                return 1
            end
        }
    )
end



function hero_select:EndPick()
    if PICK_STATE ~= PICK_STATE_PICK_END then
        PICK_STATE = PICK_STATE_PICK_END
        CustomTables:SetTableValue( "custom_pick", "pick_state", { in_progress = false } )
        CustomGameEventManager:Send_ServerToAllClients("pick_end", {})
        hero_select:GiveHeroesPlayersStart()
        Timers:CreateTimer(0.4, function()
            _G.IN_STATE = false
        end)
    end
end

function hero_select:RandomHero(id)
    local hero
    repeat
        local random = RandomInt(1, #HEROES_FOR_PICK)
        hero = HEROES_FOR_PICK[random]
    until not hero_select:check_used(PICKED_HEROES, hero) and not IsHeroDonate(hero, id) and not hero_select:check_used(BANNED_HEROES, hero)

    return hero
end

function HasHeroForPick(hero)
    for _, hero_name in pairs(HEROES_FOR_PICK) do
        if hero_name == hero then
            return false
        end
    end
    return true
end

function hero_select:check_used( t , n ) 
	if #t == 0 then return false end
	for i = 1,#t do
		if t[i] == n then return true end
	end	
	return false
end

function hero_select:ChoseHero(params)
    if params.PlayerID == nil then
        return
    end

    if not params.hero then
        return
    end

    if PICK_STATE ~= PICK_STATE_SELECT_HERO then
        return
    end

    if HasHeroForPick(params.hero) then
        return
    end

    if hero_select.IsRandomHeroes then return end

    local id = params.PlayerID

    local player_info = LOBBY_PLAYERS[params.PlayerID]

    if params.random then
        local random_hero = hero_select:RandomHero(params.PlayerID)
        LOBBY_PLAYERS[params.PlayerID].randomed = true
        if player_info.picked_hero ~= nil or hero_select:check_picked(random_hero) then
            return
        end
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(params.PlayerID), "change_random", {hero = random_hero, })
        hero_select:PickHero(params.PlayerID, random_hero, 1)
        return
    end

    if player_info.picked_hero ~= nil or hero_select:check_picked(params.hero) then
        return
    end


    if player_system.PLAYERS_GLOBAL_INFORMATION[id] then
        local allow_random_hero = false
        if string.find(GetMapName(), "rating") then
            if player_system.PLAYERS_GLOBAL_INFORMATION[id].last_leave ~= nil and player_system.PLAYERS_GLOBAL_INFORMATION[id].last_leave == 1 then
                allow_random_hero = true
            end
            if GetMapName() == "rating" or GetMapName() == "rating_300" then
                if player_system.PLAYERS_GLOBAL_INFORMATION[id].has_report_random ~= nil and tonumber(player_system.PLAYERS_GLOBAL_INFORMATION[id].has_report_random) > 0 then
                    allow_random_hero = true
                end
            end
        end
        if allow_random_hero then
            return
        end
    end

    LOBBY_PLAYERS[params.PlayerID].randomed = false
    hero_select:PickHero(params.PlayerID, params.hero, 0)
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(params.PlayerID), "change_random", {hero = params.hero, })
end

function hero_select:check_picked_players()

    for id, i in pairs(LOBBY_PLAYERS) do
        if i.picked_hero == nil then
            return false
        end
    end

    hero_select:EndPickHeroes()
end

function hero_select:EndPickHeroes()
    CustomTables:SetTableValue(
        "custom_pick",
        "player_lobby",
        {
            lobby_players = LOBBY_PLAYERS,
            lobby_players_length = LOBBY_PLAYERS_MAX
        }
    )
    for hero_id, info in pairs(player_system.SOUNDS_INFO) do
        local hero_name = DOTAGameManager:GetHeroNameByID(tonumber(hero_id))
        if hero_name and hero_select:check_picked("npc_dota_hero_" .. hero_name) then
            CustomTables:SetTableValue("hero_sounds", tostring(hero_id), info)
        end
    end
    hero_select:EndPick()
end

function hero_select:check_picked(hero)
    for _, i in pairs(PICKED_HEROES) do
        if i == hero then
            return true
        end
    end
    for _, i in pairs(BANNED_HEROES) do
        if i == hero then
            return true
        end
    end

    return false
end

function hero_select:DrawPickScreenForPlayer(pid)
    if not PlayerResource:IsValidPlayerID(pid) then
        return
    end
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(pid), "pick_start", {})
end

function hero_select:PickHero(id, name, random, disc)
    local player_info = LOBBY_PLAYERS[id]
    LOBBY_PLAYERS[id].picked_hero = name
    table.insert(PICKED_HEROES, name)
    CustomTables:SetTableValue(
        "custom_pick",
        "player_list",
        {
            picked_heroes = PICKED_HEROES,
            banned_heroes = BANNED_HEROES,
        }
    )
    CustomTables:SetTableValue(
        "custom_pick",
        "player_current_hero"..id,
        {
            picked = 1
        }
    )

    local gold = DEFAULT_GOLD
    if random and random == 1 then
        gold = gold + BONUS_RANDOM_GOLD
    end

    hero_select.START_GOLD_PLAYERS[id] = gold

    CustomGameEventManager:Send_ServerToAllClients("pick_select_hero", {hero = name, id = id, random = random, })

    if disc == nil then
        if PlayerResource:GetPlayer(id) ~= nil then
            CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "change_random", {hero = name})
        end
    end

    CustomNetTables:SetTableValue("players_heroes", tostring(id), {hero = name})

    hero_select.SELECTED_HEROES[id] = name

    local player = PlayerResource:GetPlayer(id)
    if player then
        player:SetSelectedHero(name)
    end
    
    hero_select:check_picked_players()
end

-- Вспомогательная функции

function hero_select:DisconnectPlayer(id)
    if PICK_STATE == PICK_STATE_PICK_END then return end
    if PICK_STATE == PICK_STATE_PLAYERS_LOADED then return end
    if PlayerResource:GetSelectedHeroName(id) ~= "" then return end
    if LOBBY_PLAYERS[id].picked_hero == nil or hero_select.SELECTED_HEROES[id] == nil then
        hero_select.SELECTED_HEROES_DISCONNECTED[id] = true
        hero_select:PickHero(id, hero_select:RandomHero(id), 1, 1)
    end
end

function hero_select:GiveHeroesPlayersStart()
    for id = 0,24 do
        if LOBBY_PLAYERS[id] ~= nil and hero_select.SELECTED_HEROES_DISCONNECTED[id] == nil and PlayerResource:IsValidPlayerID(id) and PlayerResource:GetSteamAccountID(id) ~= 0 then
            if PlayerResource:GetSelectedHeroName(id) == "" then
                if LOBBY_PLAYERS[id].picked_hero == nil then
                    hero_select:PickHero(id, hero_select:RandomHero(id), 1, 1)
                else
                    local player = PlayerResource:GetPlayer(id)
                    if player then
                        player:SetSelectedHero(LOBBY_PLAYERS[id].picked_hero)
                    end
                end
            end
        end
    end
end