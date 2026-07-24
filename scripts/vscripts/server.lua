--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("debug_")

HTTP = {}


function GenerateMatchKey()
	local syms = {
		'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
		'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
		"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"
	}

	local key = ""

	for i = 1, 32 do
		key = key .. syms[RandomInt( 1, #syms )]
	end

	return key
end

HTTP.GAME_HOST =  "https://dota1x6.com/api/game"
HTTP.STATS_HOST = "https://stats.dota1x6.com/api"
HTTP.KEY = GetDedicatedServerKeyV3( "dota1x6keyN2" ) --
HTTP.MATCH_ID = tostring( IsInToolsMode() and RandomInt( 1, 999999 ) or GameRules:Script_GetMatchID() )

HTTP.MATCH_KEY = GenerateMatchKey()
HTTP.MATCH_CLUSTER = Convars:GetInt( "sv_cluster" )
HTTP.MATCH_REGION = Convars:GetInt( "sv_region" )
HTTP.serverData = nil
HTTP.playersData = {}
HTTP.leavedPlayers = {}
HTTP.ItemsData = {}
HTTP.TalentsData = nil
HTTP.global_party = false

for id = 0, 24 do
	HTTP.playersData[id] = {
		items = {},
		team = -1,
		buffs = {},
		isLeaver = false,
		ratingChange = 0,
		lost_game = false,
		dpHeroMatchXp = 0,
		dpHeroQuestXp = 0,
		is_active = 0,
		BlueTalentsCount = 0,
		WhiteTalentsCount = 0,
		PurpleTalentsCount = 0,
		SecondMainTalent = "",
		LastHits = 0,
		TowerDamage = 0,
		achivment_done_before = {},
		achivment_completed = {},
		destroyed_buildings = {},
		matchShardsReceipts = {},
		damageDealt = {},
		damageRecieved = {},
	}
end

function TableMap( t, cb )
	local new = {}

	for k, v in pairs( t or {} ) do
		local nv, nk = cb( v, k )
		new[nk or k] = nv or v
	end

	return new
end

function GetPenalty(table)
if not table then return 0 end

local avgPlace = table.avgPlace
local matches = table.matchCount
if not avgPlace or not matches then return 0 end

local hardLimit = 2.8
local minMatches = 4

local C = 1.1
local k = 0.06
local N0 = 4

if matches >= 3 and avgPlace <= 1.35 then
	return 1
end

if matches <= minMatches or avgPlace > hardLimit then
    return 0
end

local effectiveMatches = matches - N0

local threshold = hardLimit - C * math.exp(-k * effectiveMatches)

if avgPlace < threshold then
    return 1
else
    return 0
end

end

function HTTP.GetMatchId()
	return HTTP.MATCH_ID == "0" and tostring( GameRules:Script_GetMatchID() ) or HTTP.MATCH_ID
end

function HTTP.GetAccountPlayerId( playerId )
	if type( playerId ) == "number" then
 		return tostring( PlayerResource:GetSteamAccountID( playerId ) )
	else
		return tostring( playerId )
	end
end


function HTTP.FillOfflineServerData()
if HTTP.serverData and not HTTP.serverData.isOffline then
	return
end

local data = {
	isStatsMatch = false,
	isOffline = true,
	seasonName = "Server offline",
	averageRating = 0,
	leaderboard = {
	--	{
			--steamID = "",
			--favoriteHero = "npc_dota_hero_broodmother",
			--matchCount = 1337,
		--	rating = 228,
		--}
	},

	end_date = "24.01.2022",
    active_vote = 0,
    hero_won = "npc_dota_hero_sven",

	heroes_vote = 
	{
		{'npc_dota_hero_ursa', 0, 0, 2},
		{'npc_dota_hero_furion', 0, 0, 3},
		{'npc_dota_hero_sniper', 0, 0, 2},
	},
	players = {}
}

for id = 0, 24 do
	if ValidId(id) or (test and test_ids[id]) then
		local all_heroes_data = {}

		local player_items_onequip = {}
        local player_items_onequip_effects = {}

		for _,hero_name in pairs(all_heroes) do 

			all_heroes_data[hero_name] = {}

			all_heroes_data[hero_name].quests = {}

			all_heroes_data[hero_name].exp = 0--RandomInt(1, 60)
			all_heroes_data[hero_name].level = 1
				
			if (hero_name == "npc_dota_hero_jakiro") then
				--all_heroes_data[hero_name].level = 30
			end 

			player_items_onequip[hero_name] = {}
            player_items_onequip_effects[hero_name] = {}

            if IsInToolsMode() then
                player_items_onequip_effects[hero_name]["drow_ranger_wave_of_silence_custom"] = 8006
            end

            for ll, item_id_check in pairs(player_items_onequip[hero_name]) do
                wearables_system:PreSaveItemSelectionData(id, item_id_check, hero_name)
            end

            for ll, item_id_check in pairs(player_items_onequip_effects[hero_name]) do
                wearables_system:PreSaveItemSelectionEffectsData(id, item_id_check, hero_name)
            end
		end

		local items_ids = {}
		local chest_opened = {}

		local chat_wheel = {0,0,0,0,0,0,0,0}
		local player_tips = {0,0,0,0,0,0,0}


		local sub = 0
		if test then 
			sub = 1
		end
		local points = 100000
		if test then 
			points = 100000
		end
		local quests_cd = 10
		if false then
			quests_cd = 0
		end

		local steam_id = tostring( PlayerResource:GetSteamAccountID( id ) )
		if test and test_ids[id] then
			steam_id = test_ids[id]
		end
		data.players[id] = {
			steamID = steam_id,
			rating = 0,
			UsedWrongMap = 0,
			isAdmin = false,
			isBanned = false,
			IsBannedByReports = false,
			lowPriorityRemaining = 0,
			favoriteHero = "",
			matchCount = 5,
			freeItemBuilds = 0,
			subData =
			{ 
				points = points,
				subscribed = sub,
				hide_tier = 0,
                hide_pet_names = 0,
				disable_quest = 0,
				disable_tips = 0,
                wavealert_hide = 0,
				used_quest_reward = 0,
				pet_id = 0,
				pet_state = 0,
				double_rating_cd = 0, 
				heroes_data = all_heroes_data,
				items_ids = items_ids,
				chat_wheel = chat_wheel,
				player_tips = player_tips,
                selected_high_five = 0,
                pet_overhead_name = "",
				selected_tip = "0",
				votes_count = 3,
				free_vote_cd = 0,
				bonus_shards_cd = 0,
                selected_emblem = 0,
                selected_effects = {},
				item_build_cd = 0,
				sub_time = 0,
				quests_cd = quests_cd,
				full_talents = 0,
                chest_opened = chest_opened,
				player_items_onequip = player_items_onequip,
                player_items_onequip_effects = player_items_onequip_effects,
			},

			keyBinds = {keybind_observer_ward = "1", keybind_sentry_ward = "2", keybind_smoke = "3", keybind_dust = "4", keybind_grenade = "5"},
			heroes = 
			{
				--npc_dota_hero_huskar = {
			--		matchCount = 12,
				--	kills = 44,
			--		deaths = 12,
			--		rating = -25
			--	}
			},
			matches = {
				--{
			--		heroName = "npc_dota_hero_huskar",
				--	firstOrangeTalent = "inner_fire",
				--	items = {"item_dagon_1_custom"},
			--		kills = 50,
			--		deaths = 120,
			--		duration = 45 * 60 + 12,
				--	date = 0,
			--	}
			}
		} 
	end
end

HTTP.serverData = data

HTTP.InitServerData()
end


function HTTP.InitServerData()

local total = 0
local count = 0
for id = 0, 24 do
	if ValidId(id) then 
		_G.lobby_rating[id] = HTTP.serverData.players[id].rating
		total = total + lobby_rating[id]
		count = count + 1
	end
end

_G.avg_rating = math.floor(total/math.max(1,count))

local name = GetMapName()
local min = 0
local max = 99999

if rating_thresh[name] then
	min = rating_thresh[name].min
	max = rating_thresh[name].max
end

CustomNetTables:SetTableValue(
	"server_data",
	"",
	{
		is_match_made = true,
		season_name = HTTP.serverData.seasonName
	}
)

CustomNetTables:SetTableValue("leaderboard", "leaderboard",
	TableMap( HTTP.serverData.leaderboard, 
	function( row )
	return 
	{
		playerId = row.playerId,
		rating = row.rating,
		favorite_hero = row.favoriteHero,
		total_matches = row.matchCount,

	}
end))

CustomNetTables:SetTableValue("leaderboard", "leaderboard_duo",
	TableMap( HTTP.serverData.leaderboard_duo, 
	function( row )
	return 
	{
		playerId = row.playerId,
		rating = row.rating,
		favorite_hero = row.favoriteHero,
		total_matches = row.matchCount,
	}
end))

if HTTP.serverData.voting then

	local heroes_vote = {}
	for _,kv in pairs(HTTP.serverData.voting.heroes) do 
		table.insert(heroes_vote, {kv.heroName, kv.voteCount, 0, kv.attributeId})
	end

	CustomNetTables:SetTableValue(
		"sub_data",
		"heroes_vote",
		{
			end_date = "12.05.2024",-- HTTP.serverData.voting.endDateString,
			hero_won =  HTTP.serverData.voting.heroWon,
			active_vote = HTTP.serverData.voting.isActive,
			vote_table = heroes_vote
		}
			
	)
else 

	CustomNetTables:SetTableValue(
		"sub_data",
		"heroes_vote",
		{
			end_date = HTTP.serverData.end_date,
			hero_won = HTTP.serverData.hero_won,
			active_vote = HTTP.serverData.active_vote,
			vote_table = HTTP.serverData.heroes_vote
		}	
	)

end


CustomNetTables:SetTableValue(
	"custom_pick",
	"avg_rating",
	{
		avg_rating = avg_rating
	}
)

if test and false then
	local new_data = {}
	new_data.engDescription = ""
	new_data.engName = ""
	new_data.ruName = ""
	new_data.awardType = 1
	new_data.awardAmount = 3000
	new_data.id = 2
	new_data.ruDescription = ""

	local achivments = {}
	table.insert(achivments, new_data)

	for _,achievement_data in pairs(achivments) do
		local id = achievement_data.id
		if id and not dota1x6.achivment_table[id] then
			dota1x6.achivment_table[id] = {}
			dota1x6.achivment_table[id].id = id
			dota1x6.achivment_table[id].awardType = achievement_data.awardType
			dota1x6.achivment_table[id].awardAmount = achievement_data.awardAmount
			dota1x6.achivment_table[id].ru_text = achievement_data.ruDescription
			dota1x6.achivment_table[id].eng_text = achievement_data.engDescription
		end
	end
end

for i, player in pairs( HTTP.serverData.players ) do

	local pid = HTTP.GetPlayerBySteamID( player.steamID )
	local sub_data = player.subData

	local new_quests = false

	if test or (sub_data.quests_cd == 0 and (sub_data.subscribed == 1 or sub_data.subscribed == true)) then 
		new_quests = true
		sub_data.quests_cd = shop_quests_cd
	end

	local all_heroes_data = {}
	local quests_net_table = {}


	for _,hero_name in pairs(all_heroes) do 
		all_heroes_data[hero_name] = {}
		all_heroes_data[hero_name].level = 1
		all_heroes_data[hero_name].exp = 0

		all_heroes_data[hero_name].quests = {}
		quests_net_table[hero_name] = {}

		if sub_data.heroes_data[hero_name] == nil then 
			sub_data.heroes_data[hero_name] = {}
			sub_data.heroes_data[hero_name].exp = 0
			sub_data.heroes_data[hero_name].level = 1
			sub_data.heroes_data[hero_name].quests = {}
		else 
			all_heroes_data[hero_name].level = sub_data.heroes_data[hero_name].level
			all_heroes_data[hero_name].exp = sub_data.heroes_data[hero_name].exp
		end

		all_heroes_data[hero_name].quests = sub_data.heroes_data[hero_name].quests or {}

		if new_quests == true then 
			all_heroes_data[hero_name].quests = dota1x6:FillQuests(hero_name)
		end

		for _,quest_name in pairs(all_heroes_data[hero_name].quests) do
			for _,shop_hero_quest in pairs(All_Quests.hero_quests[hero_name]) do 
				if (shop_hero_quest.name == quest_name) then 
   					local n = #quests_net_table[hero_name] + 1
   					quests_net_table[hero_name][n] = {}
   					quests_net_table[hero_name][n].goal = shop_hero_quest.goal
   					quests_net_table[hero_name][n].name = shop_hero_quest.name
   					quests_net_table[hero_name][n].exp = shop_hero_quest.reward_exp
   					quests_net_table[hero_name][n].shards = shop_hero_quest.reward_shards
   					quests_net_table[hero_name][n].icon = shop_hero_quest.icon
   					quests_net_table[hero_name][n].number = shop_hero_quest.number
   					quests_net_table[hero_name][n].legendary = nil 
   					if shop_hero_quest.legendary then 
   						quests_net_table[hero_name][n].legendary = shop_hero_quest.legendary
   					end
				end
			end

			for _,shop_hero_quest in pairs(All_Quests.general_quests) do 
				if (shop_hero_quest.name == quest_name) then
   					local n = #quests_net_table[hero_name] + 1
   					quests_net_table[hero_name][n] = {}
   					quests_net_table[hero_name][n].goal = shop_hero_quest.goal
  					quests_net_table[hero_name][n].name = shop_hero_quest.name
 					quests_net_table[hero_name][n].exp = shop_hero_quest.reward_exp
   					quests_net_table[hero_name][n].shards = shop_hero_quest.reward_shards
   					quests_net_table[hero_name][n].icon = shop_hero_quest.icon
   					quests_net_table[hero_name][n].number = shop_hero_quest.number
				end
			end
		end

	    local tier = 0

	    for i,thresh in pairs(level_thresh) do
	    	if all_heroes_data[hero_name].level >= thresh then 
	    		tier = i
	    	else
	    		break
	    	end 
	    end

	    all_heroes_data[hero_name].tier = tier
	    all_heroes_data[hero_name].has_level = 0


	    if all_heroes_data[hero_name].level > 1 or all_heroes_data[hero_name].exp > 0 then 
	   		all_heroes_data[hero_name].has_level = 1
	    end
	end	

	sub_data.heroes_data = all_heroes_data

	if new_quests == true then 
		HTTP.UpdateQuests( pid, all_heroes_data, sub_data.quests_cd * 1000 )
	end

	CustomNetTables:SetTableValue("sub_data", tostring(pid), sub_data)
	CustomNetTables:SetTableValue("hero_quests", tostring(pid), quests_net_table)
	CustomNetTables:SetTableValue("keybinds", tostring(pid), player.keyBinds)

	if pid then
		for hero_name, stats in pairs( player.heroes ) do
			CustomNetTables:SetTableValue(
				"server_hero_stats",
				tostring(pid) .. "_" .. hero_name,
				{
					places = TableMap( stats.places, function( count, place )
						return count, tonumber( place ) - 1
					end ),
					rating = stats.rating,
					kills = stats.kills,
					deaths = stats.deaths,
					total = stats.matchCount
				}
			)
		end

		local wrong_map_status = 0
        local unranked_penalty = 0
        local reports_teammate = -1
        local ranked_low_games = 0
      	local leave_banned = 0
      	local ranked_game_count = 0
      	local unranked_penalty_reason = 0
      	local is_banned = 0

		if player.rating and HTTP.serverData.isStatsMatch == true then 
			if player.rating > max or player.rating < min then 
				wrong_map_status = 2
			end
		end

		if player.IsBannedByLeaveReports == true then
			leave_banned = 1
		end

		--[[
		if wrong_map == 1 then 
			if (player.rating > max and player.rating - max <= 40) 
				or (player.rating < min and min - player.rating <= 40) then 
				wrong_map_status = 1
			else 
				wrong_map_status = 2
			end
		end]]

		if player.reports and IsSoloMode() then
			for other_player, report_count in pairs(player.reports) do
				local other_pid = HTTP.GetPlayerBySteamID(other_player)
				if report_count >= MAX_REPORTS then 
					reports_teammate = other_pid
					break
				end
			end
		end

		if HTTP.global_party == false then
	        if IsUnrankedMap() and not pro_mod then
	        	if IsSoloMode() then
	        		if player.unrankedStats and GetPenalty(player.unrankedStats) == 1 then
						unranked_penalty = UNRANKED_DAMAGE_PENALTY
	        			unranked_penalty_reason = 2
	        		end
	        	elseif player.rating >= UNRANKED_RATING_PENALTY then
					unranked_penalty = UNRANKED_DAMAGE_PENALTY
	        		unranked_penalty_reason = 1
	        	end
			end

			if GetMapName() == "ranked_800-x" and HTTP.serverData then
				local summ = 0
				local count = 0
				local rating = nil
				local max_rating = 999999
				if HTTP.serverData.leaderboard then
					local data = HTTP.serverData.leaderboard[#HTTP.serverData.leaderboard]
					if data and data.rating then
						max_rating = data.rating
					end
				end

				max_rating = 1200

				for id,data in pairs(HTTP.serverData.players) do
					if data.rating then
						if id == pid then
							rating = data.rating
						else
							summ = summ + data.rating
							count = count + 1
						end
					end
				end
				if count >= 5 and rating and max_rating >= rating then
					local avg = summ/count
					if avg - rating >= 400 then
						unranked_penalty = RANKED_DAMAGE_BONUS
						unranked_penalty_reason = 3
					end
				end
			end
		end

		if player.isBanned then
			is_banned = 1
		end

		if not IsUnrankedMap() and IsSoloMode() and not HTTP.serverData.isOffline and (HTTP.serverData.isStatsMatch or test) then
			if (player.unrankedStats and player.unrankedStats.matchCountTotal < RANKED_GAME_COUNT) and player.matchCount < RANKED_GAME_COUNT_TOTAL then
				ranked_low_games = RANKED_GAME_COUNT
				ranked_game_count = player.unrankedStats.matchCountTotal
			end
		end

		local tier = 0
		local in_ranked = 0

		if player.rating then 
			for i = 1,#ranked_tier do 
				if player.rating < ranked_tier[i]  then 
					tier = i - 1
					break
				end
			end
		end

		if rating_thresh[GetMapName()] then 
			in_ranked = 1
		end

		local free_build_used = player.FreeBuildsConsumedCount and player.FreeBuildsConsumedCount or 0
		local can_use_free_build = HTTP.CanUseFreeBuild(free_build_used, player.matchCount) and 1 or 0

		CustomNetTables:SetTableValue(
			"server_data",
			tostring(pid),
			{
				leave_data = player.LeaveReports,
				leave_banned = leave_banned,
				stats_match = HTTP.serverData.isStatsMatch,
				total_games = player.matchCount,
				ranked_game_count = ranked_game_count,
			 	rating = player.rating,
			 	ranked_tier = tier,
			 	is_banned = is_banned,
			 	max_leave = MAX_LEAVE,
				rank_tier = 0,
				in_ranked = in_ranked,
				leaderboard_rank = 0,
				ranked_low_games = ranked_low_games,
				reports_teammate = reports_teammate,
				map_rating = {min = min, max = max},
				wrong_map_status = wrong_map_status,
                unranked_penalty = unranked_penalty,
                unranked_penalty_reason = unranked_penalty_reason,
				competitive_calibration_games_remaining = 0,
				favorite_hero = player.favoriteHero,
				places = TableMap( player.places, function( count, place )
					return count, tonumber( place ) - 1
				end ),
				lp_games_remaining = player.lowPriorityRemaining,
				player_matches = TableMap( player.matches, function( match )
					return {
						hero = match.heroName,
						orange_talent = match.mainTalent,
						items = match.items,
						kills = match.kills,
						deaths = match.deaths,
						place = match.place,
						rating = match.ratingChange,
						duration = match.duration,
						date = match.date,
						endTime = match.endTime,
					}
				end ),
				free_item_builds = free_build_used,--player.freeItemBuilds or 9,
				max_free_item_builds = MAX_FREE_BUILDS,
				can_use_free_build = can_use_free_build,
				chosenBuild = false
			}
		)
	end
end

CustomGameEventManager:Send_ServerToAllClients( 'update_lobby_rating', {} ) 

end


function HTTP.AddDotaPlusHeroXp( id, amount )
	HTTP.playersData[id].dpHeroXp = HTTP.playersData[id].dpHeroXp + amount
end

function HTTP.AddPlayerMatchShardsReceipt( id, amount, desc )
	table.insert( HTTP.playersData[id].matchShardsReceipts, {
		amount = amount,
		desc = desc
	} ) 
end


function HTTP.GetPlayerData( id )
	if not HTTP.serverData then return end

	local steamID = tostring( PlayerResource:GetSteamAccountID( id ) )
	local fake = {}

	for _, player in pairs( HTTP.serverData.players or {} ) do

		fake = player

		if player.steamID == steamID then
			return player
		end
	end
	return fake
end

function HTTP.GetPlayerBySteamID( steamID )
	for id = 0, 24 do
		if steamID == tostring( PlayerResource:GetSteamAccountID( id ) ) or steamID == PlayerResource:GetSteamAccountID( id ) then
			return id
		end
	end

	return -1
end

function HTTP.IsValidGame( count )
if test then return false end
return IsInToolsMode() or count >= max_teams*players_in_team
end

function ChangeUserData(array, new_array)

for name,data in pairs(array) do 


	if type(data) == "table" then 
		new_array[name] = {}
		ChangeUserData(data, new_array[name])
	else 

		if type(data) == "userdata" then 
			new_array[name] = tonumber(data)
		else 
			new_array[name] = data
		end 
	end
end 

end


function HTTP.Request( url, data, cb, tries, isStats)


if not isStats then
    data.matchId = HTTP.GetMatchId()
    data.matchKey = HTTP.MATCH_KEY
end

local r = CreateHTTPRequestScriptVM("POST", ( isStats and HTTP.STATS_HOST or HTTP.GAME_HOST ) .. url )

print("POST" .. " Request - ", ( isStats and HTTP.STATS_HOST or HTTP.GAME_HOST ) .. url)

if r == nil then 
--	return
end

r:SetHTTPRequestHeaderValue( "dedicated-key", HTTP.KEY )

if (url == "/leave") then 
	local new_data = {}
	ChangeUserData(data, new_data)
	data = new_data
end 


r:SetHTTPRequestRawPostBody( "application/json", json.encode( data ) )
r:SetHTTPRequestAbsoluteTimeoutMS( 600 * 1000 )
r:Send( function( res )
	local body = nil
	local StatusCode = tonumber(res.StatusCode)

	--print( "Req", url, StatusCode, res.Body )

	if StatusCode == 200 then
		--print( "Req Body", res.Body, url )
		body = json.decode( res.Body or "{}" )
		if cb then
			cb( body )
		end
	else
		if url ~= "/http-errors" then
			HTTP.Request( "/http-errors", {
				matchId = tostring(GameRules:Script_GetMatchID()),
	    		matchKey = HTTP.MATCH_KEY,
				Url = tostring(url),
				StatusCode = StatusCode,
				ResponseMessage = tostring(res.Body),
				RequestBody = data,
			}, function( data )
				
			end)
		end

		if tries and tries > 0 then

			--local hero = players[0]
			--GameRules:ExecuteTeamPing(hero:GetTeamNumber(), hero:GetAbsOrigin().x, hero:GetAbsOrigin().y, PlayerResource:GetPlayer(hero:GetId()), 8 )

			Timers:CreateTimer( 3, function()
				HTTP.Request( url, data, cb, tries - 1 )
			end )
		end
	end
end )

end

function HTTP.MatchStart()
print( "HTTP MatchStart" )
local steamIDs = {}
local reverse_id = {}
local party_id = nil
local party_check = true

for id = 0, 24 do
	if ValidId(id) then
		local steam_id = tostring( PlayerResource:GetSteamAccountID( id ) )
		table.insert( steamIDs, steam_id )
		reverse_id[steam_id] = id

		local party = tonumber(PlayerResource:GetPartyID( id ))
		if party then
	 		if party == 0 then
	 			party_check = false
	 		else
	 			if not party_id then
	 				party_id = party
	 			elseif party_id ~= party then
	 				party_check = false
	 			end
	 		end
		else
			party_check = false
		end
	end
end

if party_check then
	HTTP.global_party = true
end

if test then
	for id, steam_id in pairs(test_ids) do
		table.insert(steamIDs, steam_id)
		reverse_id[steam_id] = id
	end
end

--[[
table.insert(steamIDs, 3)
table.insert(steamIDs, 4)
table.insert(steamIDs, 5)
]]

HTTP.MatchDetailsData() 
HTTP.MatchLeaderboardData()

local cheats = GameRules:IsCheatMode() 

if IsInToolsMode() then
	cheats = false
end

HTTP.Request( "/unranked_stats", {
	players = steamIDs,
}, function( data )
	if data then
		for _,info in pairs(data) do
			local steam_id = info.playerId
			local player_data = HTTP.GetPlayerData( HTTP.GetPlayerBySteamID(steam_id) )
			player_data.unrankedStats = info
		end
		HTTP.InitServerData()
	end
end, not IsInToolsMode() and 50 or nil )


HTTP.Request( "/match_start", {
	matchId = tostring(GameRules:Script_GetMatchID()),
	matchKey = HTTP.MATCH_KEY,
	cluster = HTTP.MATCH_CLUSTER,
	region = HTTP.MATCH_REGION,
	players = steamIDs,
	mapName = GetMapName(),
	isCheatsMode = cheats
}, function( data )

	--Timers:CreateTimer(3, function()
	if data then
		HTTP.serverData.voting = data.voting
		HTTP.serverData.averageRating = data.averageRating
		HTTP.serverData.seasonName = data.seasonName
		HTTP.serverData.isStatsMatch = data.isStatsMatch

		dota1x6.achivment_table["completed"] = {}

		if data.achievements then
			for _,achievement_data in pairs(data.achievements) do
				local id = achievement_data.id
				if id and not dota1x6.achivment_table[id] then
					dota1x6.achivment_table[id] = {}
					dota1x6.achivment_table[id].id = id
					dota1x6.achivment_table[id].awardType = achievement_data.awardType
					dota1x6.achivment_table[id].awardAmount = achievement_data.awardAmount
					dota1x6.achivment_table[id].ru_text = achievement_data.ruDescription
					dota1x6.achivment_table[id].eng_text = achievement_data.engDescription
				end
			end
		end

		for _,player in pairs(data.players) do 

			local steam_id = player.playerId
			local player_id = reverse_id[steam_id]

			local player_data = HTTP.GetPlayerData( HTTP.GetPlayerBySteamID(steam_id) )

			if player_id and HTTP.playersData[player_id] and player.completedAchievements then

				dota1x6.achivment_table["completed"][player_id] = {}

				for _,data in pairs(player.completedAchievements) do 
					if data.achievementId then
						dota1x6.achivment_table["completed"][player_id][tonumber(data.achievementId)] = 1
						HTTP.playersData[player_id].achivment_done_before[tonumber(data.achievementId)] = true
					end
				end
			end	

			player_data.lowPriorityRemaining = player.lpCount
			player_data.rating = player.rating
			player_data.isAdmin = player.isAdmin

			player_data.LeaveReports = player.leaveReports
			player_data.IsBannedByLeaveReports = player.isBannedByLeaveReports
			player_data.isBanned = player.isBanned
			player_data.IsBannedByReports = player.isBannedByReports
			player_data.reports = player.reports
			player_data.UsedWrongMap = player.usedWrongMap and 1 or 0
			player_data.reportedPlayers = player.reportedPlayers
			player_data.FreeBuildsConsumedCount = player.freeBuildsConsumedCount

			local savedSubData = player.savedData and player.savedData.subData or nil

			local items_ids = {}
			local chest_opened = {}

			if player.items then 
				for k, v in pairs( player.items ) do
					local number = tonumber(v)
					table.insert( items_ids, number )

					local is_chest = shop:IsChest(number)
					print(k, number, is_chest)
					if is_chest ~= false then
						table.insert( chest_opened, is_chest )
					end
				end
			end

			local all_heroes_data = {}
			local items = {}
            local items_effects = {}


			for _,hero_name in pairs(all_heroes) do
				items[hero_name] = {}
                items_effects[hero_name] = {}

				if savedSubData and savedSubData.player_items_onequip and savedSubData.player_items_onequip[hero_name] then 
					for _,item in pairs(savedSubData.player_items_onequip[hero_name]) do 
						table.insert(items[hero_name], item)
					end 
				end

                if savedSubData and savedSubData.player_items_onequip_effects and savedSubData.player_items_onequip_effects[hero_name] then 
					for name,item in pairs(savedSubData.player_items_onequip_effects[hero_name]) do 
						items_effects[hero_name][name] = item
					end 
				end

				if player.dotaPlusHeroes[hero_name] then 

					local xp = player.dotaPlusHeroes[hero_name].xp
					local level = 1

					for k, v in pairs( _G.sub_level_thresh ) do
						if xp >= v then
							xp = xp - v
							level = level + 1
						else
							break
						end
					end

					all_heroes_data[hero_name] = {
						exp = xp,
						level = level,
						quests = player.dotaPlusHeroes[hero_name].quests
					}
				end
			end

			--DeepPrintTable(player)

			player_data.subData = { 
				hide_tier = savedSubData and savedSubData.hide_tier or player_data.subData.hide_tier,
                hide_pet_names = savedSubData and savedSubData.hide_pet_names or player_data.subData.hide_pet_names,
				disable_quest = savedSubData and savedSubData.disable_quest or player_data.subData.disable_quest,
				disable_tips = savedSubData and savedSubData.disable_tips or player_data.subData.disable_tips,
                wavealert_hide = savedSubData and savedSubData.wavealert_hide or player_data.subData.wavealert_hide,
				pet_id = savedSubData and savedSubData.pet_id or player_data.subData.pet_id,
				used_quest_reward = savedSubData and savedSubData.used_quest_reward or player_data.subData.used_quest_reward,
				chat_wheel = savedSubData and savedSubData.chat_wheel or player_data.subData.chat_wheel,

				player_tips = savedSubData and savedSubData.player_tips or player_data.subData.player_tips,
				selected_tip = savedSubData and savedSubData.selected_tip or "0",
				selected_high_five = savedSubData and savedSubData.selected_high_five or 0,
                selected_emblem = savedSubData and savedSubData.selected_emblem or 0,
                selected_effects = savedSubData and savedSubData.selected_effects or {},
                pet_overhead_name = savedSubData and savedSubData.pet_overhead_name or "",
				pet_state = savedSubData and savedSubData.pet_state or 0,
				subscribed = player.hasDotaPlus and player.hasDotaPlus or 0,
				points = player.shardsAmount and player.shardsAmount or 0,
				votes_count = player.voteCount and player.voteCount or 0,
				double_rating_cd = player.doubleRatingCd and player.doubleRatingCd / 1000 or 0, 
				free_vote_cd = player.bonusVotesCd and player.bonusVotesCd / 1000 or 0,
				bonus_shards_cd = player.bonusShardsCd and player.bonusShardsCd / 1000 or 0,
				item_build_cd = player.itemBuildsCd and player.itemBuildsCd / 1000 or 0,
				quests_cd = player.updateQuestsCd and player.updateQuestsCd / 1000 or 0,
				sub_time = player.dotaPlusExpire and player.dotaPlusExpire / 1000 or 0,
				full_talents = savedSubData and savedSubData.full_talents or 0,
				items_ids = items_ids,
				heroes_data = all_heroes_data,
				player_items_onequip = items,
                player_items_onequip_effects = items_effects,
                chest_opened = chest_opened,
			}
		end
	end

	CustomGameEventManager:Send_ServerToAllClients("SendAchivments", dota1x6.achivment_table)

	HTTP.InitServerData()	

	--end)

end, not IsInToolsMode() and 50 or nil )


end



function HTTP.MatchDetailsData()
local steamIDs = {}

for id = 0, 24 do
	if ValidId(id) then
		table.insert( steamIDs, tostring( PlayerResource:GetSteamAccountID( id ) ) )
	end
end

HTTP.Request( "/match_details", steamIDs, function( data )

	if not data then
		print("no data details") 
		return
	end
	HTTP.serverData.isOffline = false


	for _,player in pairs(data) do 
		local player_data = HTTP.GetPlayerData( HTTP.GetPlayerBySteamID(player.playerId) )
		
		if player_data then 
			player_data.matchCount = player.matchCount
			player_data.favoriteHero = player.favoriteHero
			player_data.places = player.places
			player_data.heroes = player.heroes
			player_data.matches = player.matches
		end

	end
	HTTP.InitServerData()	
end, nil, true )

end






function HTTP.MatchLeaderboardData()
local steamIDs = {}

for id = 0, 24 do
	if ValidId(id) then
		table.insert( steamIDs, tostring( PlayerResource:GetSteamAccountID( id ) ) )
	end
end

HTTP.Request( "/match_leaderboard", steamIDs, function( data )

	if not data then
		print("no leaderboard") 
		return
	end

	HTTP.serverData.leaderboard = data.solo
	HTTP.serverData.leaderboard_duo = data.duo

	HTTP.InitServerData()	
end, nil, true )

end




local function RatingChange( id, data )

local ratingChange = data and data.ratingChange or 0

local player = PlayerResource:GetPlayer( id )

HTTP.playersData[id].ratingChange = ratingChange

local place = 0
local items = {}
local net = 0

if HTTP.playersData[id] then
	place = HTTP.playersData[id].place
	items = HTTP.playersData[id].items
	net = HTTP.playersData[id].net
end

local net_table = CustomNetTables:GetTableValue("networth_players", tostring(id))
net_table.net = net
net_table.place = place
net_table.items = items
net_table.rating_before =  math.max(0, lobby_rating[id] + lobby_rating_change[id])
net_table.rating_change = lobby_rating_change[id]

CustomNetTables:SetTableValue("networth_players", tostring(id), net_table)
end





function HTTP.PlayerEnd( id )
if lobby_rating_change[id] ~= nil and dont_end_game == false and not test then return end

local player_data = HTTP.playersData[id]

lobby_rating_change[id] = dota1x6:calc_rating(avg_rating, lobby_rating[id], player_data.place, id)

player_data.lost_game = true

local hero = GlobalHeroes[id]

if hero then 
	print(hero:GetUnitName())
else 
	print('nil ',PlayerResource:GetSteamAccountID( id ))
	return
end

local subData = CustomNetTables:GetTableValue("sub_data", tostring( id ))
local serverData = CustomNetTables:GetTableValue("server_data", tostring( id ))

if hero:GetQuest() and hero.quest.legendary ~= nil and player_data.firstOrangeTalent and player_data.place < 2 and string.lower(hero.quest.icon) == string.lower(player_data.firstOrangeTalent) then 
	for name,talent_data in pairs(ingame_talents[hero:GetUnitName()]) do 

		if talent_data["skill_icon"] == player_data.firstOrangeTalent and (hero:HasModifier(name) or hero:HasTalent(name)) then 
			hero:UpdateQuest(1)
		end
	end
end	

local subData_visual = {points = 0, subscribed = 0, level = 1, exp = 0}

if subData and subData.heroes_data[hero:GetUnitName()] then 
	subData_visual = 
	{
		points = subData.points, 
		subscribed = subData.subscribed, 
		expire = subData.sub_time, 
		level = subData.heroes_data[hero:GetUnitName()].level,
		exp = subData.heroes_data[hero:GetUnitName()].exp	
	}
end

local quest_table = {}
local achivment_table = {}

if (hero:GetQuest() ~= nil) and hero:QuestCompleted() and player_data.place <= win_place then 
	quest_table.name = hero.quest.name
	quest_table.icon = hero.quest.icon
	quest_table.exp = hero.quest.exp
	quest_table.shards = hero.quest.shards
	quest_table.completed = 1
end

if #player_data.achivment_completed > 0 then
	for _,data in pairs(player_data.achivment_completed) do
		if data.AchievementId and dota1x6.achivment_table[data.AchievementId] then
			local info = dota1x6.achivment_table[data.AchievementId]
			local new_data = {}
			new_data.amount = info.awardAmount
			new_data.id = info.id
			new_data.completed = 1
			table.insert(achivment_table, new_data)
			if info.awardType == 1 then
				subData_visual.points = subData_visual.points + info.awardAmount
			end
		end
	end
end

local screen_table = 
{
	place = player_data.place,
	kills = player_data.kills_done,
	towers = player_data.towers_destroyed,
	runes = player_data.bounty_runes_picked, 
	randomed = player_data.randomed,
	rating_before = lobby_rating[id],
	rating_change = lobby_rating_change[id],
	calibration_games = 0, 
	points = subData_visual.points,
	subscribed = subData_visual.subscribed,
	level = subData_visual.level,
	exp = subData_visual.exp,
	expire = subData_visual.expire,
	quest_table = quest_table,
	achivment_table = achivment_table,
	valid_time = GameRules:GetDOTATime(false, false) >= push_timer,
	total_games = serverData.total_games
}


if player_data.place > 2 or dont_end_game then 
	if not player_data.banned then 
		CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "EndScreenShow", screen_table)
	end
else 
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer( id ), "EndScreen_game_end", screen_table)
end

dota1x6:PostMatchPoints(hero)

local data = CustomNetTables:GetTableValue("server_data", tostring(id))
local penalty_type = 0
local lp_games = data.lp_games_remaining

if data.unranked_penalty then
	if data.unranked_penalty == UNRANKED_DAMAGE_PENALTY then
		penalty_type = 1
	end
end

if lp_games > 0 and player_data.place <= win_place and SafeToLeave == false then 
	lp_games = lp_games - 1
end

data.lp_games_remaining = lp_games

CustomNetTables:SetTableValue("server_data", tostring(id), data)

if not HTTP.serverData.isStatsMatch then
	RatingChange( id )
	return
end

if SafeToLeave == true then 
	return
end

local completedQuest = nil

if hero and hero:GetQuest() and hero:QuestCompleted() and player_data.place <= win_place then
	completedQuest = hero.quest.name
end

print('the last', id)

HTTP.Request( "/end", {
	matchId = tostring(GameRules:Script_GetMatchID()),
	matchKey = HTTP.MATCH_KEY,
	teamId = player_data.team,
    lpCount = lp_games,
    isWrongMap = player_data.wrong_map_status > 0,
	playerId = tostring( PlayerResource:GetSteamAccountID( id ) ),
	playerName = PlayerResource:GetPlayerName( id ),
	partyId = tostring( PlayerResource:GetPartyID( id ) ),
	heroName = PlayerResource:GetSelectedHeroName( id ),
	mainTalent = player_data.firstOrangeTalent,
	totalBuffs = player_data.buffs,
	items = player_data.items,
	buildingsDestroyed = player_data.destroyed_buildings,
	kills = PlayerResource:GetKills( id ),
	deaths = PlayerResource:GetDeaths( id ),
	assists = PlayerResource:GetAssists( id ),
	networth = PlayerResource:GetNetWorth( id ),
	gpm = PlayerResource:GetGoldPerMin( id ),
	xpm = PlayerResource:GetXPPerMin( id ),
	level = PlayerResource:GetLevel( id ),
	base = player_data.base,
	bans = {player_data.bannedHero},
	pickOrder = player_data.pickOrder,
	Penalty = penalty_type,
	place = player_data.place,
	killer = player_data.killer,
	isLeaver = player_data.isLeaver,
	endTime = GameRules:GetDOTATime(false, false),
	dpHeroMatchXp = player_data.dpHeroMatchXp,
	dpHeroQuestXp = player_data.dpHeroQuestXp,
	completedQuest = completedQuest,
	shardsReceipts = player_data.matchShardsReceipts,
	completedAchievements = player_data.achivment_completed,
	DealtDamages = player_data.damageDealt,
	ReceivedDamages = player_data.damageRecieved,
	SecondMainTalent = player_data.SecondMainTalent,
	LastHits = player_data.LastHits,
	BlueTalentsCount = player_data.BlueTalentsCount,
	WhiteTalentsCount = player_data.WhiteTalentsCount,
	PurpleTalentsCount = player_data.PurpleTalentsCount,
	TowerDamage = player_data.TowerDamage,

}, function( data )
	print('qweqwr',id)
	RatingChange( id, data )
end, not IsInToolsMode() and 50 or nil )

end

function HTTP.PlayerLeave( id )
if HTTP.leavedPlayers[id] or not ValidId(id) then
	return
end

shop:shop_dota1x6_close_chest_checked_reward({PlayerID = id})

HTTP.leavedPlayers[id] = true

local data = CustomNetTables:GetTableValue("server_data", tostring(id) )

if not data then return end

local wrong_map_status = data.wrong_map_status
local subData = CustomNetTables:GetTableValue("sub_data", tostring( id ))
local playerData = HTTP.GetPlayerData( id )

HTTP.Request( "/leave", {
	playerId = tostring( PlayerResource:GetSteamAccountID(id) ),
    isWrongMap = wrong_map_status == 2, 
	isSafeToLeave = data.switch_safetoleave,
    leaveTime = GameRules:GetDOTATime(false, false),
    playerName = PlayerResource:GetPlayerName( id ),
    lpCount = data.lp_games_remaining,   
	savedData = {
		subData = subData
	},
} )
end

function HTTP.Report( reporter, reported1, reported2, t )
	print( "HTTP.PlayerEnd", id )

	HTTP.Request( "/report", {
		matchId = tostring(GameRules:Script_GetMatchID()),
		matchKey = HTTP.MATCH_KEY,
		reporter = tostring( PlayerResource:GetSteamAccountID( reporter ) ),
		reported1 = tostring( PlayerResource:GetSteamAccountID( reported1 ) ),
		reported2 = tostring( PlayerResource:GetSteamAccountID( reported2 ) ),
		type = t
	}, nil, 50 )
end

function HTTP.RegisterBuildingDeath(id, unit)
if not HTTP.playersData[id] or HTTP.playersData[id].is_active == 0 then return end

local enemy_team = unit:GetTeamNumber()
local tower = towers[enemy_team]

if not tower or not tower.ids then return end

local type = ""
local name = unit:GetUnitName()
if name == "npc_towerradiant" or name == "npc_towerdire" then
	type = "tower"
elseif name == "npc_filler_radiant_resist" or name == "npc_filler_dire_resist" then
	type = "green_shrine"
elseif name == "npc_filler_radiant_stun" or name == "npc_filler_dire_stun" then
	type = "white_shrine"
elseif name == "npc_filler_radiant_plasma" or name == "npc_filler_dire_plasma" then
	type = "blue_shrine"
end

local count = #HTTP.playersData[id].destroyed_buildings + 1
HTTP.playersData[id].destroyed_buildings[count] = {}

local data = {}

data.pushedPlayerIds = {}

 for _,id in pairs(tower.ids) do
	table.insert(data.pushedPlayerIds, tostring(PlayerResource:GetSteamAccountID(id)))
end

data.type = type
data.time = GameRules:GetDOTATime(false, false)

HTTP.playersData[id].destroyed_buildings[count] = data
end


function HTTP.BuyItem( playerId, productId, amount, count )

	print('!!!!', amount, count)

	HTTP.Request( "/shards_expense", {
		playerId = HTTP.GetAccountPlayerId( playerId ),
		productId = productId,
		isItem = true,
		amount = amount,
		count = count or 1
	} )
end

function HTTP.Vote( playerId, heroName, count )
	HTTP.Request( "/vote", {
		playerId = HTTP.GetAccountPlayerId( playerId ),
		heroName = heroName,
		count = count
	} )
end

function HTTP.BonusShards( playerId, amount, cd )
	HTTP.Request( "/bonus_shards", {
		playerId = HTTP.GetAccountPlayerId( playerId ),
		amount = amount,
		cd = cd
	} )
end

function HTTP.BonusVotes( playerId, count, cd )
	HTTP.Request( "/bonus_votes", {
		playerId = HTTP.GetAccountPlayerId( playerId ),
		count = count,
		cd = cd
	} )
end

function HTTP.UpdateQuests( playerId, heroes, cd )
	local quests = {}

	for heroName, questsList in pairs( heroes ) do
		local hero = {
			heroName = heroName,
			quests = questsList.quests
		}

		table.insert( quests, hero )
	end



	HTTP.Request( "/update_quests", {
		playerId = HTTP.GetAccountPlayerId( playerId ),
		heroes = quests,
		cd = cd,
	} )
end

function HTTP.DoubleRating( playerId, cd )
	HTTP.Request( "/double_rating", {
		playerId = HTTP.GetAccountPlayerId( playerId ),
		type = IsSoloMode() and 1 or 2,
		cd = cd
	} )
end


function HTTP.ItemBuild( playerId, cd )
	HTTP.Request( "/item_builds", {
		playerId = HTTP.GetAccountPlayerId( playerId ),
		cd = cd
	} )
end

function HTTP.CanUseFreeBuild(build_count, game_count)
return build_count < MAX_FREE_BUILDS and game_count <= FREE_BUILDS_MAX_GAMES and (HTTP.serverData.isStatsMatch or test)
end

function HTTP.FreeItemBuild( playerId )
	HTTP.Request( "/consume_free_build", {
		playerId = HTTP.GetAccountPlayerId( playerId )
	} )
end

function HTTP.GetItemBuild( name, playerID )
HTTP.Request("/get_item_builds",
	{
		matchId = tostring(GameRules:Script_GetMatchID()),
		matchKey = HTTP.MATCH_KEY,
		heroName = name,
	}, function(data)
		ItemBuilds[name] = data
end, nil, false)

end

function HTTP.GetTalentsBuild()

local names = {}
for _,data in pairs(SelectedHeroes) do
	table.insert(names, data.hero)
end

HTTP.Request("/get_offered_talents",
	{
		matchId = tostring(GameRules:Script_GetMatchID()),
		matchKey = HTTP.MATCH_KEY,
		heroName = names,
	}, function(data)
		talents_values:SendPickRates(data)
end, nil, false)

end

--[[
function HTTP.ShopRequestBuy(playerId, point_change, item_id)
HTTP.Request( "/shards_expense", 
{
	playerId =  playerId,
	productId = item_id,
	count = 1,
	amount = math.abs( point_change ),
	isItem = true,

}, function( data )

	end)

end


function HTTP.ShopRequestBuyVote(playerId, point_change, count)
	print(point_change, count)
	
	HTTP.Request( "/shards_expense", {
		playerId =  playerId,
		productId = 'vote',
		amount = math.abs( point_change ),
		count = count,
		isItem = false,
	} )

end


function HTTP.ShopRequestAdd(playerId, point_change, reason)
	print(point_change, reason)
	
	HTTP.Request( "/shards_receipt", {
		playerId =  playerId,
		details = { reason = reason },
		amount = math.abs( point_change )
	} )
end


function HTTP.ShopRequestVote(playerId, amount, hero_name)
print(amount, hero_name)

HTTP.Request( "/vote", 
{
	playerId =  playerId,
	heroName = hero_name,
	count = amount,
}, function( data )

	end)

end

]]


function HTTP.Login(playerId, item_name, player_id) 


	local url = 'https://dota1x6.com/?popup=payment_method&productId='..item_name

	if item_name == "sub" then 
		url = 'https://dota1x6.com/?popup=dota_plus'
	end

	if item_name == "shards" then 
		url = 'https://dota1x6.com/?popup=shards'
	end

	if item_name == "gift" then 
		url = 'https://dota1x6.com/?popup=present'
	end

	if item_name == "profile" then 
		url = 'https://dota1x6.com/players/'..tostring(PlayerResource:GetSteamAccountID(player_id))
	end

	HTTP.Request( "/login", {
		playerId =  HTTP.GetAccountPlayerId( playerId ),
		redirectUrl = url,

	}, function( data )

		CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer( playerId ), "get_payment_url", {url = data.url}) 
	end )
end



function HTTP.PaymentDotaPlus(playerId, type) -- HTTP.PlayerSubscribe(playerId, type_sub)
HTTP.Request( "/payment", {
	playerId =  HTTP.GetAccountPlayerId( playerId ),
	productId = "dota_plus_" .. type,
}, function( data )
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer( playerId ), "get_payment_url", {url = data.url}) 
end )

end

function HTTP.FillOtherData(id)
local player = players[id]
if not player then return end

HTTP.playersData[id].BlueTalentsCount = tonumber(player.blue)
HTTP.playersData[id].WhiteTalentsCount = tonumber(player.gray)
HTTP.playersData[id].PurpleTalentsCount = tonumber(player.purple)
HTTP.playersData[id].LastHits = PlayerResource:GetLastHits(id) and tonumber(PlayerResource:GetLastHits(id)) or 0
HTTP.playersData[id].TowerDamage = tonumber(player.tower_damage)
end


function HTTP.FillDamageData(id)
local player = players[id]
if not player then return end

local dealt_table = {}
local incoming_table = {}

for name, data in pairs(player.damage_out) do
	local new_table = {}
	new_table.Name = tostring(name)
	new_table.Type = tostring(data.type)
	new_table.DamageType = tonumber(data.damage_type)
	new_table.NewIcon = tostring(data.new_icon)
	new_table.Damage = data.damage and tonumber(data.damage) or 0
	new_table.Time = tonumber(data.time)

	table.insert(dealt_table, new_table)
end

for hero, data in pairs(player.damage_inc) do
	local new_table = {}
	new_table.HeroName = tostring(hero)
	new_table.Physical = data.phys and tonumber(data.phys) or 0
	new_table.Magical = data.magic and tonumber(data.magic) or 0
	new_table.Pure = data.pure and tonumber(data.pure) or 0

	table.insert(incoming_table, new_table)
end

HTTP.playersData[id].damageDealt = dealt_table
HTTP.playersData[id].damageRecieved = incoming_table
end




function HTTP.FillTalentsData(id, name, offered_talents)
local hero = GlobalHeroes[id]
if not hero then return end 

local key = tostring(id)

if not HTTP.TalentsData then
	HTTP.TalentsData = {}
end

if not HTTP.TalentsData[key] then
	HTTP.TalentsData[key] = {}
	HTTP.TalentsData[key].player_id = PlayerResource:GetSteamAccountID( id )
	HTTP.TalentsData[key].match_id = tostring(GameRules:Script_GetMatchID())
	HTTP.TalentsData[key].map_name = GetMapName() 
	HTTP.TalentsData[key].hero_name = hero:GetUnitName()
	HTTP.TalentsData[key].place = -1 
	HTTP.TalentsData[key].main_talent = "-1"
	HTTP.TalentsData[key].talents = {} 
end

local rarity = hero:GetTalentValue(name, "rarity", true)
local table_name = talents_heroes[name]
if not table_name or (table_name ~= hero:GetUnitName() and table_name ~= "general") then return end

if rarity == "orange" and HTTP.TalentsData[key].main_talent == "-1" then
	HTTP.TalentsData[key].main_talent = tostring(hero:GetTalentValue(name, "skill_icon", true))
end

local data = {}
local count = #HTTP.TalentsData[key].talents + 1

data.picked_talent = name
data.rarity = tostring(rarity)
data.pick_number = count
data.offered_talents = offered_talents

table.insert(HTTP.TalentsData[key].talents, data)
end



function HTTP.FillItemsData(id, place)
local data = {}
local hero = GlobalHeroes[id]

if not hero then return end 

local items = {}

for i = 0, 5 do
	local item = hero:GetItemInSlot( i )
	
	if item and not NonRecordItems[item:GetAbilityName()] then
		table.insert(items, item:GetAbilityName())
	end
end

if hero:HasShard() then 
	table.insert(items, "item_aghanims_shard")
end 

if hero:HasScepter() then 
	table.insert(items, "item_ultimate_scepter")
end 

data.player_id = PlayerResource:GetSteamAccountID( id )
data.match_id = tostring(GameRules:Script_GetMatchID())
data.place = place
data.hero_name = hero:GetUnitName()
data.main_talent = HTTP.playersData[id].firstOrangeTalent or '0'
data.networth = PlayerResource:GetNetWorth( id )
data.time = math.floor(GameRules:GetDOTATime(false, false)/60)
data.items = items
data.map_name = GetMapName() 

table.insert(HTTP.ItemsData, data)

if place and place ~= -1 then 

	for _,data in pairs(HTTP.ItemsData) do
		if data.hero_name and data.hero_name == hero:GetUnitName() then 
			if data.place then
				data.place = place
			end

			if HTTP.playersData[id].firstOrangeTalent and data.main_talent then 
				data.main_talent = HTTP.playersData[id].firstOrangeTalent
			end 
		end 
	end 
end 


end


function HTTP.CheckReports()
for _,server_player in pairs(HTTP.serverData.players) do

	local pid = HTTP.GetPlayerBySteamID( server_player.steamID )

	local player = nil

	if pid then 
		player = players[pid]
	end

	if player ~= nil and server_player.reports then

		if player.banned ~= true then
			player.banned = server_player.isBanned
		end
 
	end
end


end