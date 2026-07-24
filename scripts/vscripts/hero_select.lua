--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("events_protector")

hero_select = class({})

PICK_STATE_PLAYERS_LOADED = "PICK_STATE_PLAYERS_LOADED"
PICK_STATE_PICK_BANNED = "PICK_STATE_PICK_BANNED"
PICK_STATE_SELECT_HERO = "PICK_STATE_SELECT_HERO"
PICK_STATE_SELECT_BASE = "PICK_STATE_SELECT_BASE"
PICK_STATE_PICK_END = "PICK_STATE_PICK_END"
PICK_STATE = PICK_STATE_PLAYERS_LOADED
BAN_TIME = 15
TIME_OF_STATE = {5, 75, 60, 0}
LOBBY_PLAYERS = {}
LOBBY_PLAYERS_MAX = 0
HEROES_FOR_PICK = {}
BASE_FOR_PICK = {2, 7, 6, 3, 12, 9}

if not IsSoloMode() then
    BASE_FOR_PICK = {2, 3, 6, 7}
end

PICKED_HEROES = {}
PICKED_BASES = {}
PICK_ORDER = 0
_G.IN_STATE = false
BAN_HEROES_VOTE = {}
_G.BANNED_HEROES = {}
MAX_BANNED = 4
MAX_BANNED_TOTAL = 6

-- Duo
LOBBY_TEAMS_COUNTER = 0
LOBBY_TEAMS_INFO = {}
PLAYERS_PRE_SELECT_BASE = {}
DUO_BANNED = 
{
    "npc_dota_hero_terrorblade"
}
--

NO_BANNED_HEROES = 
{ 
    "npc_dota_hero_jakiro",
    "npc_dota_hero_monkey_king",
    "npc_dota_hero_muerta",
    "npc_dota_hero_furion",
    "npc_dota_hero_ogre_magi",
}

DONATE_HEROES = 
{
    ["npc_dota_hero_jakiro"] = true,
}
NEW_SYSTEM_HEROES = 
{
    ["npc_dota_hero_ogre_magi"] = true,
}

--[[PRO_MOD_ALLOWED =
{
    ["npc_dota_hero_alchemist"] = {3, 4},
    ["npc_dota_hero_bristleback"] = {1, 3, 4},
    ["npc_dota_hero_centaur"] = {1, 3},
    ["npc_dota_hero_legion_commander"] = {3, 4},
    ["npc_dota_hero_mars"] = {2, 3},
    ["npc_dota_hero_skeleton_king"] = {2, 3},
    ["npc_dota_hero_sven"] = {3, 4},
    ["npc_dota_hero_antimage"] = {1, 2},
    ["npc_dota_hero_bloodseeker"] = {1, 3},
    ["npc_dota_hero_juggernaut"] = {2, 3},
    ["npc_dota_hero_monkey_king"] = {1, 3},
    ["npc_dota_hero_phantom_assassin"] = {3, 4},
    ["npc_dota_hero_slark"] = {3, 4},
    ["npc_dota_hero_troll_warlord"] = {3},
    ["npc_dota_hero_marci"] = {1, 4},
    ["npc_dota_hero_pangolier"] = {3, 4},
}
]]

function hero_select:IsHeroDonate(hero, id)

local subData = CustomNetTables:GetTableValue("sub_data", tostring( id ))

if subData and subData.subscribed == 0 then
    if DONATE_HEROES[hero] or NEW_SYSTEM_HEROES[hero] then
        return true
    end
end
return false
end




function hero_select:RandomHero(id)
local hero

if false then
    local player_id = PlayerResource:GetSteamAccountID(id)
    if (player_id == "172784619" or player_id == 172784619) and not dota1x6:check_used(PICKED_HEROES, "npc_dota_hero_bane") and not dota1x6:check_used(BANNED_HEROES, "npc_dota_hero_bane") then
        return "npc_dota_hero_bane"
    end
end

repeat
    local random = RandomInt(1, #HEROES_FOR_PICK)
    hero = HEROES_FOR_PICK[random]
until not dota1x6:check_used(PICKED_HEROES, hero) and not hero_select:IsHeroDonate(hero, id)

return hero
end

function hero_select:RandomBase()
local base
repeat
    base = RandomInt(1, #BASE_FOR_PICK)
until not dota1x6:check_used(PICKED_BASES, base)
return base
end

function hero_select:PickBase(id, number)
if SelectedBases[id] ~= nil then return end

local player_info = LOBBY_PLAYERS[id]

player_info.select_base = number

PLAYERS_PRE_SELECT_BASE[id] = number

HTTP.playersData[id].base = number

table.insert(PICKED_BASES, number)

CustomNetTables:SetTableValue(
    "custom_pick",
    "base_list",
    {
        picked_bases = PICKED_BASES,
        picked_bases_length = #PICKED_BASES
    }
)

CustomGameEventManager:Send_ServerToAllClients(
    "pick_select_base",
    {number = number, hero = player_info.picked_hero, id = id}
)

SelectedBases[id] = number

if ValidId(id) and SelectedHeroes[id] and SelectedHeroes[id].hero
    and PlayerResource:GetSelectedHeroName(id) == "" and PlayerResource:GetPlayer(id) then 

    PlayerResource:GetPlayer(id):SetSelectedHero(SelectedHeroes[id].hero)
else 
    if PlayerResource:GetSelectedHeroName(id) ~= "" and GlobalHeroes[id] and towers[GlobalHeroes[id]:GetTeamNumber()] == nil then 
        dota1x6:PlaceHero(id)   
    end
end

hero_select:check_picked_bases()

CustomGameEventManager:Send_ServerToAllClients("update_pre_select_base", {info = PLAYERS_PRE_SELECT_BASE})
end

function hero_select:ChoseBase(params)
if params.PlayerID == nil then
    return
end

if not params.number then
    return
end
if PICK_STATE ~= PICK_STATE_SELECT_BASE then
    return
end
local player_info = LOBBY_PLAYERS[params.PlayerID]
if player_info.select_base ~= nil or hero_select:check_picked_base_number(params.number) then
    return
end
if IsSoloMode() then
    hero_select:PickBase(params.PlayerID, params.number)
else
    hero_select:PickBaseDuo(params.PlayerID, params.number)
    -- hero_select:PickBaseDuo(1, 3)
end
end

function hero_select:PickBaseDuo(PlayerID, number)
PLAYERS_PRE_SELECT_BASE[PlayerID] = number
local current_team = LOBBY_PLAYERS[PlayerID].player_team
local players_in_team = hero_select:GetPlayersInTeam(current_team)
CustomGameEventManager:Send_ServerToAllClients("update_pre_select_base", {info = PLAYERS_PRE_SELECT_BASE})
CustomNetTables:SetTableValue("custom_pick", "pre_select_base", PLAYERS_PRE_SELECT_BASE)
local next_stage = true
for _, pid in pairs(players_in_team) do
    if pid ~= PlayerID and PLAYERS_PRE_SELECT_BASE[pid] ~= number then
        next_stage = false
    end
end
-- if IsInToolsMode() and PlayerID == 0 then
--     Timers:CreateTimer(2, function()
--         hero_select:PickBaseDuo(1, number)
--     end)
-- end
if next_stage then
    for _, pid in pairs(players_in_team) do
        hero_select:PickBase(pid, number)
    end
     Timers:CreateTimer(3, function()
        DeepPrintTable(LOBBY_PLAYERS)
     end)
end

end

function hero_select:PickHero(id, name, random)
local player_info = LOBBY_PLAYERS[id]
local player = PlayerResource:GetPlayer(id)

player_info.picked_hero = name

start_quest:HeroPickEvent(id)
HTTP.GetItemBuild(name, PlayerResource:GetPlayer(id))

FireGameEvent("save_talents", 
{
    hero_name = name,
})

if added_shop_heroes[name] then
    if PlayerCount > TestMode_players then
        wearables_system:AddPrecachedData(name)
        wearables_system.ITEMS_DATA[name] = require("wearables_system/donate_items/"..name)
        wearables_system:SendHeroItems(name)
    end

    local subData = CustomNetTables:GetTableValue("sub_data", tostring( id ))

    if subData and subData.player_items_onequip and subData.player_items_onequip[name] then 
        for _,item in pairs(subData.player_items_onequip[name]) do 
            wearables_system:PreSaveItemSelectionData(id, item, name)
        end 
    end
    if subData and subData.player_items_onequip_effects and subData.player_items_onequip_effects[name] then 
        for _,item in pairs(subData.player_items_onequip_effects[name]) do 
            wearables_system:PreSaveItemSelectionEffectsData(id, item, name)
        end 
    end
end

table.insert(PICKED_HEROES, name)

CustomNetTables:SetTableValue(
    "custom_pick",
    "player_list",
    {
        picked_heroes = PICKED_HEROES,
        picked_heroes_length = #PICKED_HEROES
    }
)

CustomNetTables:SetTableValue(
    "custom_pick",
    "player_lobby",
    {
        lobby_players = LOBBY_PLAYERS,
        lobby_players_length = LOBBY_PLAYERS_MAX
    }
)

if player then
    CustomGameEventManager:Send_ServerToPlayer(player, "pick_update_selection_button", {})
end

SelectedHeroes[id] = {}
SelectedHeroes[id].hero = name
SelectedHeroes[id].random = random

local rand = random
if pro_mod and pro_mod_data.show_random then
    rand = 1
end

CustomNetTables:SetTableValue("players_heroes", tostring(id), {hero = name, id = id, random = rand})
--CustomGameEventManager:Send_ServerToAllClients("pick_select_hero", {hero = name, id = id, random = rand, pro_mod = pro_mod})

hero_select:check_picked_players()
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

    if not LOBBY_PLAYERS[params.PlayerID] then return end


    local player_info = LOBBY_PLAYERS[params.PlayerID]

    if params.random then
        local random_hero = hero_select:RandomHero(params.PlayerID)

        LOBBY_PLAYERS[params.PlayerID].randomed = true

        if player_info.picked_hero ~= nil or hero_select:check_picked(random_hero) then
            return
        end
        hero_select:PickHero(params.PlayerID, random_hero, 1)
        return
    end

    if player_info.picked_hero ~= nil or hero_select:check_picked(params.hero) then
        return
    end

    LOBBY_PLAYERS[params.PlayerID].randomed = false
    hero_select:PickHero(params.PlayerID, params.hero, 0)
end

function hero_select:EndPickHeroes()
CustomNetTables:SetTableValue(
    "custom_pick",
    "player_lobby",
    {
        lobby_players = LOBBY_PLAYERS,
        lobby_players_length = LOBBY_PLAYERS_MAX
    }
)
PICK_ORDER = 0

CustomGameEventManager:Send_ServerToAllClients("start_base_pick", {})
PICK_STATE = PICK_STATE_SELECT_BASE

HTTP.GetTalentsBuild()

Timers:CreateTimer(
    "",
    {
        useGameTime = false,
        endTime = 1,
        callback = function()
            if IsSoloMode() then
                hero_select:StartOrderPickBase()
            else
                hero_select:StartOrderPickBaseDuo()
            end
        end
    })
end




function hero_select:OnDisconnect(params)
if GAME_STARTED == false then return end
if not params.PlayerID then return end
local id = params.PlayerID 

if PlayerResource:GetSelectedHeroName(id) ~= "" then return end
if GlobalHeroes[id] then return end

if LOBBY_PLAYERS[id].picked_hero == nil or SelectedHeroes[id] == nil or SelectedHeroes[id].hero == nil then
     hero_select:PickHero(id, hero_select:RandomHero(id), 1)
end 

if SelectedHeroes[id] and SelectedHeroes[id].hero then 
    PlayerResource:GetPlayer(params.PlayerID):SetSelectedHero(SelectedHeroes[id].hero)

end


end




function hero_select:EndPick(source)
if PICK_STATE == PICK_STATE_PICK_END then return end


for id = 0,24 do 
    if ValidId(id) and SelectedHeroes[id] and SelectedHeroes[id].hero 
        and  SelectedBases[id] == nil then 
        hero_select:PickBase(id, hero_select:RandomBase())
    end
end


PICK_STATE = PICK_STATE_PICK_END
CustomGameEventManager:Send_ServerToAllClients("pick_base_end", {})
CustomGameEventManager:Send_ServerToAllClients("HideQuestAlert", {})

--CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "pick_base_end", {})

Timers:CreateTimer(0.4, function()
    _G.IN_STATE = false
    dota1x6:EndPickStage()
end)


CustomNetTables:SetTableValue( "custom_pick", "pick_state",  { in_progress = false, player_count = PlayerCount } )
end


function hero_select:check_banned_players()
for _, i in pairs(LOBBY_PLAYERS) do
    if i.ban_hero == nil then
        return false
    end
end
CustomGameEventManager:Send_ServerToAllClients("EndBanStage", {no_ban_hero = NO_BANNED_HEROES})
CustomNetTables:SetTableValue("custom_pick", "ban_stage_check", {state = false})
hero_select:BanHero()
hero_select:StartSelectionStage()
end 


function hero_select:check_picked_players()
for _, i in pairs(LOBBY_PLAYERS) do
    if i.picked_hero == nil then
        return false
    end
end

if dont_end_pick_hero == false then 
   hero_select:EndPickHeroes()
end

end

function hero_select:check_picked_bases()
for _, i in pairs(LOBBY_PLAYERS) do
    if i.select_base == nil then
        return false
    end
end
hero_select:EndPick()
end

function hero_select:check_picked(hero)
for _, i in pairs(BANNED_HEROES) do
    if i == hero then
        return true
    end
end

for _, i in pairs(PICKED_HEROES) do
    if i == hero then
        return true
    end
end

return false
end

function hero_select:check_picked_base_number(number)
for _, i in pairs(PICKED_BASES) do
    if i == number then
        return true
    end
end
return false
end

function hero_select:UpdatePlayersTeams()
for i=0, 24 do
    if ValidId(i) and PlayerResource:GetTeam(i) ~= 1 then
        local player_team = PlayerResource:GetTeam(i)
        if LOBBY_PLAYERS[i] then
            LOBBY_PLAYERS[i].player_team = player_team
            LOBBY_PLAYERS_MAX = LOBBY_PLAYERS_MAX + 1
            if LOBBY_TEAMS_INFO[player_team] == nil then
                LOBBY_TEAMS_INFO[player_team] = {}
                LOBBY_TEAMS_COUNTER = LOBBY_TEAMS_COUNTER + 1
            end
        end
    else
        if PlayerResource:GetTeam(i) == 1 then
            if LOBBY_PLAYERS and LOBBY_PLAYERS[i] then
                LOBBY_PLAYERS[i] = nil
            end
            _G.PlayerCount = _G.PlayerCount - 1
        end
    end
end

if IsInToolsMode() and test_pick_stage then
    LOBBY_TEAMS_INFO[3] = {}
    LOBBY_TEAMS_INFO[6] = {}
    LOBBY_TEAMS_INFO[7] = {}


    local teams = 
    {
        [1] = {1, 2},
        [2] = {0, 3},
        [3] = {0, 6},
        [4] = {0, 7},
    }

    if max_teams == 6 then
        LOBBY_TEAMS_INFO[12] = {}
        LOBBY_TEAMS_INFO[9] = {}
        teams[5] = {0, 12}
        teams[6] = {0, 9}
    end

    local team_count = 1
    LOBBY_TEAMS_COUNTER = max_teams

    for i = 1,(players_in_team*max_teams - 1) do
        if teams[team_count][1] >= players_in_team then
            team_count = team_count + 1
        end

        LOBBY_PLAYERS_MAX = LOBBY_PLAYERS_MAX + 1
        teams[team_count][1] = teams[team_count][1] + 1

        print(i, teams[team_count][2])

        LOBBY_PLAYERS[i] = 
        {
            bRegistred = false,
            bLoaded = false,
            steamid = PlayerResource:GetSteamAccountID(0),
            picked_hero = nil,
            select_base = nil,
            pick_order = nil,
            ban_hero = nil,
            player_team = teams[team_count][2],
        }
    end
end

end

function hero_select:RegisterPlayerInfo(pid)
    if PlayerResource:GetSteamAccountID(pid) == 0 then return end
    local pinfo = LOBBY_PLAYERS[pid]
    if pinfo == nil then
        local player_team = PlayerResource:GetTeam(pid)
        pinfo = 
        {
            bRegistred = false,
            bLoaded = false,
            steamid = PlayerResource:GetSteamAccountID(pid),
            picked_hero = nil,
            select_base = nil,
            pick_order = nil,
            ban_hero = nil,
            player_team = player_team,
        }
    end
    LOBBY_PLAYERS[pid] = pinfo
    return pinfo
end

function hero_select:DecreasePlayerCount()
    LOBBY_PLAYERS_MAX = LOBBY_PLAYERS_MAX - 1
end

function hero_select:CheckReadyPlayers(attempt)
    if PICK_STATE ~= PICK_STATE_PLAYERS_LOADED then
        return
    end

    local bAllReady = true
    for pid, pinfo in pairs(LOBBY_PLAYERS) do
        if pinfo.bRegistred and not pinfo.bLoaded and PlayerResource:GetTeam(pid) ~= 1 then
            bAllReady = false
        end
    end

    if bAllReady then
        hero_select:Start()
    else
        local check_interval = 0.5
        attempt = (attempt or 0) + check_interval
        if attempt > TIME_OF_STATE[1] then
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

function hero_select:PlayerConnected(kv)
	if kv.PlayerID == nil then
		return
	end
    local pinfo = hero_select:RegisterPlayerInfo(kv.PlayerID)
    pinfo.bRegistred = true
end

function hero_select:PlayerLoaded(player, pid)

    if PlayerResource:GetTeam(pid) == 1 then
        return
    end

    if not LOBBY_PLAYERS[pid] then
        CustomGameEventManager:Send_ServerToPlayer(player, "pick_end", {})
        return
    end

    LOBBY_PLAYERS[pid].bLoaded = true

    local team = PlayerResource:GetTeam(pid)
    local hero = GlobalHeroes[pid]
    if hero ~= nil then
        hero:SetOwner(player)
        hero:SetControllableByPlayer(pid, true)
        player:SetAssignedHeroEntity(hero)
    end

    if not IN_STATE then
        print('2')
        dota1x6:ReconnectFilter(pid)
        return
    end

    if PICK_STATE ~= PICK_STATE_PLAYERS_LOADED then
        hero_select:DrawPickScreenForPlayer(pid)

        if PICK_STATE == PICK_STATE_PICK_BANNED then
            CustomGameEventManager:Send_ServerToPlayer(
                player,
                "reload_pick_heroes",
                {
                    lobby_players = LOBBY_PLAYERS
                }
            )

            for _, banned_hero in pairs(BAN_HEROES_VOTE) do
                CustomGameEventManager:Send_ServerToPlayer(
                    player,
                    "ban_hero_vote",
                    {hero = banned_hero}
                )
            end
        elseif PICK_STATE == PICK_STATE_SELECT_HERO then
            CustomGameEventManager:Send_ServerToPlayer(
                player,
                "reload_pick_heroes",
                {
                    lobby_players = LOBBY_PLAYERS
                }
            )
            for _, banned_hero in pairs(BAN_HEROES_VOTE) do
                CustomGameEventManager:Send_ServerToPlayer(
                    player,
                    "ban_hero_vote",
                    {hero = banned_hero}
                )
            end
            for _, banned_hero in pairs(BANNED_HEROES) do
                CustomGameEventManager:Send_ServerToPlayer(player, "ban_hero", {hero = banned_hero})
            end
        elseif PICK_STATE == PICK_STATE_SELECT_BASE then
            for current, pinfo in pairs(LOBBY_PLAYERS) do
                if pinfo.pick_order == PICK_ORDER then
                    CustomGameEventManager:Send_ServerToPlayer(
                        PlayerResource:GetPlayer(pid),
                        "pick_start_time_base",
                        {
                            order = PICK_ORDER,
                            max = LOBBY_PLAYERS_MAX,
                            id = current,
                            time = -1,
                            picked_bases = PICKED_BASES,
                            picked_bases_length = #PICKED_BASES
                        }
                    )
                    break
                end
            end

            CustomGameEventManager:Send_ServerToPlayer(
                player,
                "reload_pick_bases",
                {
                    lobby_players = LOBBY_PLAYERS
                }
            )
        elseif PICK_STATE == PICK_STATE_PICK_END then
            print('3')
            CustomGameEventManager:Send_ServerToPlayer(player, "pick_end", {})
        end
    end
end

function hero_select:Start()
    self:UpdatePlayersTeams()
    local r = 0
    local used_numbers = {}

    if IsSoloMode() then
        for i, player in pairs(LOBBY_PLAYERS) do
            repeat
               r = RandomInt(0, LOBBY_PLAYERS_MAX - 1)
            until not dota1x6:check_used(used_numbers, r)
            used_numbers[#used_numbers + 1] = r
            player.pick_order = r
        end
    else
        for team_id, team_inf in pairs(LOBBY_TEAMS_INFO) do
            repeat
                r = RandomInt(0, LOBBY_TEAMS_COUNTER - 1)
            until not dota1x6:check_used(used_numbers, r)
            used_numbers[#used_numbers + 1] = r
            team_inf.pick_order = r
        end
    end
    if IsSoloMode() then
        local place_admin = 0
        local place_normal = 1
        local first_pick_id = 
        {
         --   ['216015457'] = true, -- мяу

           -- ['244395427'] = true, -- паша фп
            ['232290025'] = not test,
            ['411040863'] = true,
           -- ['1674997262'] = true, -- ден
            --['418896247'] = true,-- колян мейн
            ['1727917408'] = true, -- колян
            ['149889029'] = true,

          --  ['122413750'] = true,
           -- ['1442764865'] = true, -- рейз фейк
            --['111393624'] = true, -- серега
            --['154672909'] = true, -- боря
            --['122413750'] = true, -- 
            --['883703644'] = true,
            --362469930--
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
        for id, player in pairs(LOBBY_PLAYERS) do
            print("QWESAEDAS", HTTP.playersData[id], id, player.pickOrder)
            HTTP.playersData[id].pickOrder = player.pick_order
        end
    else
        for id, player in pairs(LOBBY_PLAYERS) do
            if LOBBY_TEAMS_INFO[PlayerResource:GetTeam(id)] and LOBBY_TEAMS_INFO[PlayerResource:GetTeam(id)].pick_order then
                HTTP.playersData[id].pickOrder = LOBBY_TEAMS_INFO[PlayerResource:GetTeam(id)].pick_order
            end
        end
    end
    CustomNetTables:SetTableValue(
        "custom_pick",
        "player_lobby",
        {
            lobby_players = LOBBY_PLAYERS,
            lobby_players_length = LOBBY_PLAYERS_MAX
        }
    )
    CustomNetTables:SetTableValue(
        "custom_pick",
        "teams_lobby",
        {
            lobby_teams = LOBBY_TEAMS_INFO,
            lobby_teams_length = LOBBY_TEAMS_COUNTER
        }
    )

    for pid, pinfo in pairs(LOBBY_PLAYERS) do
        if pinfo.bLoaded then
            hero_select:DrawPickScreenForPlayer(pid)
        end
    end

    if LOBBY_PLAYERS_MAX <= 2 and (pro_mod == false or PRO_MOD_ALLOWED) then 
        hero_select:StartSelectionStage(test and 1 or 0.1)
    else 
        hero_select:StartBanStage()
    end
end

function hero_select:StartBanStage()
PICK_STATE = PICK_STATE_PICK_BANNED
local time_ban_stage = BAN_TIME

CustomGameEventManager:Send_ServerToAllClients("StartBanStage",  {time = time_ban_stage, no_ban_hero = NO_BANNED_HEROES})

CustomNetTables:SetTableValue("custom_pick", "ban_stage_check", {state = true})
Timers:CreateTimer(
    "",
    {
        useGameTime = false,
        endTime = 1,
        callback = function()
            time_ban_stage = time_ban_stage - 1
            CustomGameEventManager:Send_ServerToAllClients("TimeBanStage",  {time = time_ban_stage, no_ban_hero = NO_BANNED_HEROES} )
            if time_ban_stage <= 0 then
                CustomNetTables:SetTableValue("custom_pick", "ban_stage_check", {state = false})
                hero_select:BanHero()
                hero_select:StartSelectionStage()
                return
            end
            return 1
        end
    })
end

function hero_select:BanHero()

if pro_mod then

    if #BAN_HEROES_VOTE <= 0 then return end

    for i = 1,#BAN_HEROES_VOTE do
        table.insert(BANNED_HEROES, BAN_HEROES_VOTE[i])

        for id, hero in pairs(HEROES_FOR_PICK) do
            if hero == BAN_HEROES_VOTE[i] then
                table.remove(HEROES_FOR_PICK, id)
                break
            end
        end

        CustomGameEventManager:Send_ServerToAllClients("ban_hero",  {hero = BAN_HEROES_VOTE[i], table_votes = BAN_HEROES_VOTE})
    end
else

    if #BAN_HEROES_VOTE < MAX_BANNED_TOTAL then 

        for i = 1,(MAX_BANNED_TOTAL - #BAN_HEROES_VOTE) do 

            local hero
            repeat
                hero = HEROES_FOR_PICK[RandomInt(1, #HEROES_FOR_PICK)]
            until not dota1x6:check_used(BAN_HEROES_VOTE, hero) and not dota1x6:check_used(NO_BANNED_HEROES, hero)

            table.insert(BAN_HEROES_VOTE, hero)
        end
    end

    if #BAN_HEROES_VOTE <= 0 then return end

    for ban_count = 1, MAX_BANNED do
        local random_hero = RandomInt(1, #BAN_HEROES_VOTE)

        if BAN_HEROES_VOTE[random_hero] then
            table.insert(BANNED_HEROES, BAN_HEROES_VOTE[random_hero])

            for id, hero in pairs(HEROES_FOR_PICK) do
                if hero == BAN_HEROES_VOTE[random_hero] then
                    table.remove(HEROES_FOR_PICK, id)
                    break
                end
            end

            CustomGameEventManager:Send_ServerToAllClients("ban_hero",  {hero = BAN_HEROES_VOTE[random_hero], table_votes = BAN_HEROES_VOTE})

            table.remove(BAN_HEROES_VOTE, random_hero)
        end
    end
end

if #BAN_HEROES_VOTE <= 0 then return end

for i = 1,#BAN_HEROES_VOTE do 
     CustomGameEventManager:Send_ServerToAllClients("clear_ban_hero",  {hero = BAN_HEROES_VOTE[i]})
end

end

function hero_select:BanVoteHero(params)
if params.PlayerID == nil then
    return
end

if not LOBBY_PLAYERS[params.PlayerID] then return end

if LOBBY_PLAYERS[params.PlayerID].ban_hero == nil then
    for _, no_ban_hero in pairs(NO_BANNED_HEROES) do
        if no_ban_hero == params.hero then
            return
        end
    end

    for _, banned_hero in pairs(BAN_HEROES_VOTE) do
        if banned_hero == params.hero then
           
            CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(params.PlayerID), "CreateIngameErrorMessage", {message = "#wrong_ban"})
            return
        end
    end

    HTTP.playersData[params.PlayerID].bannedHero = params.hero
    LOBBY_PLAYERS[params.PlayerID].ban_hero = params.hero

    table.insert(BAN_HEROES_VOTE, params.hero)
    CustomGameEventManager:Send_ServerToAllClients("ban_hero_vote", {hero = params.hero, votes = 1})

    hero_select:check_banned_players()
end

end

function hero_select:StartSelectionStage(new_timer)
    PICK_STATE = PICK_STATE_SELECT_HERO
    local timer = 1
    if new_timer then 
        timer = new_timer
    end
    CustomGameEventManager:Send_ServerToAllClients("EndBanStage", {no_ban_hero = NO_BANNED_HEROES})
    Timers:CreateTimer(
        "",
        {
            useGameTime = false,
            endTime = new_timer,
            callback = function()
                if IsSoloMode() then
                    hero_select:StartOrderPick()
                else
                    hero_select:StartOrderPickDuo()
                end
            end
        }
    )
end

function hero_select:StartOrderPick()
    local time = Time_to_pick_Hero
    local id = 0
    for pid, pinfo in pairs(LOBBY_PLAYERS) do
        if pinfo.pick_order == PICK_ORDER then
            CustomGameEventManager:Send_ServerToAllClients("pick_start_time", {id = pid, time = time})
            CustomNetTables:SetTableValue("custom_pick", "active_player",  { id = pid })
            id = pid
            break
        end
    end
    Timers:CreateTimer(
    "",
    {
        useGameTime = false,
        endTime = 1,
        callback = function()

            local timer_disable = LOBBY_PLAYERS_MAX == 1 or SafeToLeave

            if not timer_disable then
                time = time - 1
            end

            if time == 20  then 
                --hero_select:OnDisconnect({PlayerID = id})
            end
            CustomGameEventManager:Send_ServerToAllClients("change_time", {time = time, id = id})
            local server_player = HTTP.GetPlayerData(id)
            print( "PWPEAS", server_player, id )

            if server_player and server_player.lowPriorityRemaining > 0 and not SafeToLeave then
                hero_select:PickHero(id, hero_select:RandomHero(id), 1)
            end
            if time <= 0 or (LOBBY_PLAYERS[id].picked_hero ~= nil) then
                if LOBBY_PLAYERS[id].picked_hero == nil then
                    hero_select:PickHero(id, hero_select:RandomHero(id), 1)
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
    })
end

function hero_select:StartOrderPickDuo()
    local time = Time_to_pick_Hero
    local current_team = 2
    for team_id, team_info in pairs(LOBBY_TEAMS_INFO) do
        if team_info.pick_order == PICK_ORDER then
            current_team = team_id
            CustomGameEventManager:Send_ServerToAllClients("pick_start_time", {current_team = current_team, time = time})
            CustomNetTables:SetTableValue("custom_pick", "active_player",  { current_team = current_team })
            break
        end
    end
    Timers:CreateTimer(
    "",
    {
        useGameTime = false,
        endTime = 1,
        callback = function()
            if LOBBY_PLAYERS_MAX ~= 1 and not SafeToLeave then
                time = time - 1
            end
            if time == 20  then 
                --hero_select:OnDisconnect({PlayerID = id})
            end
            CustomGameEventManager:Send_ServerToAllClients("change_time", {time = time, current_team = current_team})
            local players_in_team = hero_select:GetPlayersInTeam(current_team)
            local next_stage = true
            for _, pid in pairs(players_in_team) do
                local server_player = HTTP.GetPlayerData(pid)
                if server_player ~= nil then
                    if server_player.lowPriorityRemaining > 0 then
                        if LOBBY_PLAYERS[pid].picked_hero == nil then
                            hero_select:PickHero(pid, hero_select:RandomHero(pid), 1)
                        end
                    end
                end
                if LOBBY_PLAYERS[pid].picked_hero == nil then
                    next_stage = false
                end
            end
            if time <= 0 or next_stage then
                for _, pid in pairs(players_in_team) do
                    if LOBBY_PLAYERS[pid].picked_hero == nil then
                        hero_select:PickHero(pid, hero_select:RandomHero(pid), 1)
                    end
                end
                if PICK_STATE ~= PICK_STATE_SELECT_HERO then return end
                PICK_ORDER = PICK_ORDER + 1
                if PICK_ORDER < LOBBY_TEAMS_COUNTER + 1 then
                    hero_select:StartOrderPickDuo()
                end
                return
            end
            return 1
        end
    })
end

function hero_select:StartOrderPickBaseDuo()
    if PICK_STATE == PICK_STATE_PICK_END then return end
    local time = Time_to_pick_Base
    local current_team = 2
    for team_id, team_info in pairs(LOBBY_TEAMS_INFO) do
        if team_info.pick_order == PICK_ORDER then
            current_team = team_id
            CustomNetTables:SetTableValue(
                "custom_pick",
                "active_player",
                {
                    current_team = current_team
                }
            )
            CustomGameEventManager:Send_ServerToAllClients(
                "pick_start_time_base",
                {
                    order = PICK_ORDER,
                    max = LOBBY_PLAYERS_MAX,
                    current_team = current_team,
                    time = time,
                    picked_bases = PICKED_BASES,
                    picked_bases_length = #PICKED_BASES
                }
            )
        end
    end
    Timers:CreateTimer(
    "",
    {
        useGameTime = false,
        endTime = 1,
        callback = function()
            if LOBBY_PLAYERS_MAX ~= 1 then
                time = time - 1
            end
            CustomGameEventManager:Send_ServerToAllClients("change_time_base", {time = time, current_team = current_team})
            local next_stage = true
            local players_in_team = hero_select:GetPlayersInTeam(current_team)
            local player_choose_team = nil
            
            for _, pid in pairs(players_in_team) do
                if PLAYERS_PRE_SELECT_BASE[pid] == nil then
                    next_stage = false
                end
                if player_choose_team then
                    if PLAYERS_PRE_SELECT_BASE[pid] ~= player_choose_team then
                        next_stage = false
                    end
                else
                    if PLAYERS_PRE_SELECT_BASE[pid] ~= nil then
                        player_choose_team = PLAYERS_PRE_SELECT_BASE[pid]
                    end
                end
            end

            if time <= 0 or next_stage then
                PICK_ORDER = PICK_ORDER + 1
                if time <= 0 then
                    local random_base_list = {}
                    for _, pid in pairs(players_in_team) do
                        if PLAYERS_PRE_SELECT_BASE[pid] ~= nil then
                            table.insert(random_base_list, PLAYERS_PRE_SELECT_BASE[pid])
                        end
                    end
                    local get_base_counter = nil
                    if #random_base_list > 0 then
                        get_base_counter = random_base_list[RandomInt(1, #random_base_list)]
                    else
                        get_base_counter = hero_select:RandomBase()
                    end
                    for _, pid in pairs(players_in_team) do
                        if LOBBY_PLAYERS[pid].select_base == nil then
                            hero_select:PickBase(pid, get_base_counter)
                        end
                    end
                end
                if PICK_ORDER < LOBBY_TEAMS_COUNTER + 1 then
                    hero_select:StartOrderPickBaseDuo()
                end
                return
            end
            return 1
        end
    })
end

function hero_select:GetPlayersInTeam(team_id)
    local players = {}
    for pid, info in pairs(LOBBY_PLAYERS) do
        if info.player_team == team_id then
            table.insert(players, pid)
        end
    end
    return players
end

function hero_select:StartOrderPickBase()
if PICK_STATE == PICK_STATE_PICK_END then return end

local time = Time_to_pick_Base
local id = 0


for pid, pinfo in pairs(LOBBY_PLAYERS) do
    if pinfo.pick_order == PICK_ORDER then

         CustomNetTables:SetTableValue(
            "custom_pick",
            "active_player",
            {
                id = pid
            }
        )

        
        CustomGameEventManager:Send_ServerToAllClients(
            "pick_start_time_base",
            {
                order = PICK_ORDER,
                max = LOBBY_PLAYERS_MAX,
                id = pid,
                time = time,
                picked_bases = PICKED_BASES,
                picked_bases_length = #PICKED_BASES
            }
        )
       
        id = pid

        break
    end
end


Timers:CreateTimer(
"",
{
    useGameTime = false,
    endTime = 1,
    callback = function()
        if LOBBY_PLAYERS_MAX ~= 1 then
            time = time - 1
        end

        if PICK_ORDER + 1 == LOBBY_PLAYERS_MAX and LOBBY_PLAYERS[id].select_base == nil then 

          --  PICK_ORDER = PICK_ORDER + 1
          --  hero_select:PickBase(id, hero_select:RandomBase())
        --    return
        end

        CustomGameEventManager:Send_ServerToAllClients("change_time_base", {time = time, id = id})

        if time <= 0 or (LOBBY_PLAYERS[id].select_base ~= nil) then
            PICK_ORDER = PICK_ORDER + 1

            if LOBBY_PLAYERS[id].select_base == nil or PICK_ORDER >= LOBBY_PLAYERS_MAX + 1 then
                hero_select:PickBase(id, hero_select:RandomBase())
                if PICK_ORDER == LOBBY_PLAYERS_MAX then
                    return
                end
            end

            if PICK_ORDER < LOBBY_PLAYERS_MAX + 1 then

                hero_select:StartOrderPickBase()
            end
            return
        end
        return 1
    end
})
end

function hero_select:DrawPickScreenForPlayer(pid)
if not ValidId(pid) then
    return
end
--    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(pid), "pick_start", {})
end

function hero_select:init()
_G.IN_STATE = true

print('PICK START INIT')

RegisterLoadListener(
    function(player, playerID)
        hero_select:PlayerLoaded(player, playerID)
    end
)

if not IsSoloMode() then
    for _,hero_name in pairs(DUO_BANNED) do
        table.insert(BANNED_HEROES, hero_name)

       for id, hero in pairs(HEROES_FOR_PICK) do
            if hero == hero_name then
                table.remove(HEROES_FOR_PICK, id)
                break
            end
        end
        CustomGameEventManager:Send_ServerToAllClients("ban_hero",  {hero = hero_name, table_votes = BAN_HEROES_VOTE, no_sound = 1})
    end
end


CustomGameEventManager:RegisterListener("chose_hero", Dynamic_Wrap(self, "ChoseHero"))
CustomGameEventManager:RegisterListener("chose_base", Dynamic_Wrap(self, "ChoseBase"))
CustomGameEventManager:RegisterListener("BanVoteHero", Dynamic_Wrap(self, "BanVoteHero"))
CustomGameEventManager:RegisterListener("SetClickHero", Dynamic_Wrap(self, "SetClickHero"))

for i = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
    if PlayerResource:IsValidTeamPlayerID(i) and PlayerResource:GetTeam(i) ~= 1 then
        self:RegisterPlayerInfo(i)
    end
end

self:CheckReadyPlayers()
end



function hero_select:SetClickHero(params)
if not params.PlayerID then return end
local player_info = LOBBY_PLAYERS[params.PlayerID]

if not player_info then return end
if player_info.picked_hero then return end

local team = PlayerResource:GetTeam(params.PlayerID)
local ids = hero_select:GetPlayersInTeam(team)

for _,id in pairs(ids) do
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "ReturnClickHero", {hero = params.hero, id = params.PlayerID})
end

end




function hero_select:RegisterHeroes()
local enable_heroes = {}
local hero_list = {}
local anime = {}
local all = {}
local heroes = LoadKeyValues("scripts/npc/activelist.txt")
local h = LoadKeyValues("scripts/npc/npc_heroes_custom.txt")
local abilki = LoadKeyValues("scripts/npc/npc_abilities_custom.txt")

--

for k, v in pairs(heroes) do
    if v == 1 then
        local allow = true
        if pro_mod then
            if PRO_MOD_ALLOWED and not PRO_MOD_ALLOWED[k] then
                allow = false
            end
            if pro_mod_data.new_system and not new_talent_system[k] then
                allow = false
            end
            if pro_mod_data.disable_heroes[k] then
                allow = false
            end
        end
        if allow then
            table.insert(enable_heroes, k)
        end
    end
end

for c = 1, #enable_heroes do
    local inf = h[enable_heroes[c]]
    local ability = {}
    local heroid = {}
    if inf then
        for ab = 1, 9 do
            if
                inf["Ability" .. ab] ~= nil and inf["Ability" .. ab] ~= "" and
                    inf["Ability" .. ab] ~= "generic_hidden"
             then
                if abilki[inf["Ability" .. ab]] then
                    behavior = abilki[inf["Ability" .. ab]].AbilityBehavior
                end
                if behavior and not behavior:find("DOTA_ABILITY_BEHAVIOR_HIDDEN") then
                    table.insert(ability, inf["Ability" .. ab])
                end
            end
        end
        CustomNetTables:SetTableValue("custom_pick", tostring(enable_heroes[c]), ability)
    end
end

HEROES_FOR_PICK = enable_heroes

for _, hero in pairs(enable_heroes) do
    if h[hero].AttributePrimary == "DOTA_ATTRIBUTE_STRENGTH" then
        hero_list[hero] = 0
    elseif h[hero].AttributePrimary == "DOTA_ATTRIBUTE_AGILITY" then
        hero_list[hero] = 1
    elseif h[hero].AttributePrimary == "DOTA_ATTRIBUTE_INTELLECT" then
        hero_list[hero] = 2
    elseif h[hero].AttributePrimary == "DOTA_ATTRIBUTE_ALL" then
        hero_list[hero] = 3
    end
end


CustomNetTables:SetTableValue("custom_pick", "hero_list", hero_list)
CustomNetTables:SetTableValue("custom_pick", "hero_changes", hero_changes)
CustomNetTables:SetTableValue("custom_pick", "donate_heroes", DONATE_HEROES)
CustomNetTables:SetTableValue("custom_pick", "new_system_heroes", NEW_SYSTEM_HEROES)
end

function hero_select:GetState()
    return PICK_STATE
end