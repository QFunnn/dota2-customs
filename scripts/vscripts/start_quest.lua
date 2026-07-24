--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



if start_quest == nil then
	_G.start_quest = class({})
end

start_quest.quest_table =
{
	["Quest_1"] =
	{
		time = 0,
		goal = 1,
		timer = 15,
	},
	["Quest_2"] =
	{
		time = 1,
		goal = 1,
		timer = 12,
		follow_quest = "Quest_3"
	},
	["Quest_3"] =
	{
		goal = 3,
		timer = 12,
		use_ping = 1,
		follow_quest = "Quest_4"
	},
	["Quest_4"] =
	{
		goal = 1,
		timer = 15,
	},
	["Quest_5"] =
	{
		time = 2*60 + 25,
		goal = 1,
		timer = 12,
		follow_message = "Quest_5_1"
	},
	["Quest_6"] =
	{
		time = 4*60 + 40,
		goal = 1,
		timer = 15,
		follow_quest = "Quest_7"
	},
	["Quest_7"] =
	{
		goal = 1,
		use_ping = 1,
		timer = 15,
	},
	["Quest_8"] =
	{
		time = 6*60,
		goal = 1,
		timer = 15,
		use_ping = 1,
		follow_quest = "Quest_9"
	},
	["Quest_9"] =
	{
		goal = 1,
		use_ping = 1,
		timer = 15,
	},
	["Quest_10"] =
	{
		time = 15*60 + 30,
		goal = 3,
		timer = 15,
		follow_message = "Quest_10_1",
	},
	["Quest_11"] =
	{
		time = 17*60 + 30,
		goal = 1,
		timer = 12,
		follow_message = "Quest_11_1",
	},
}

start_quest.max_quest = 0
for _,data in pairs(start_quest.quest_table) do
	start_quest.max_quest = start_quest.max_quest + 1
end

start_quest.Neutrals_Camps = {
	-- Easy
	["Easy"] =
	{
		"neutralcamp_good_easy_1",
		"neutralcamp_good_easy_2",
		"neutralcamp_good_easy_3",
		"neutralcamp_good_easy_4",
		"neutralcamp_good_easy_5",
		"neutralcamp_good_easy_6",
		"neutralcamp_evil_easy_1",
		"neutralcamp_evil_easy_2",
		"neutralcamp_evil_easy_3",
		"neutralcamp_evil_easy_4",
		"neutralcamp_evil_easy_5",
		"neutralcamp_evil_easy_6",
	},
}


start_quest.small_creeps = 
{
    ["npc_dota_neutral_kobold"] = true,
    ["npc_dota_neutral_kobold_tunneler"] = true,
    ["npc_dota_neutral_kobold_taskmaster"] = true, 
    ["npc_dota_neutral_forest_troll_berserker"] = true,
    ["npc_dota_neutral_forest_troll_high_priest"] = true, 
    ["npc_dota_neutral_harpy_scout"] = true, 
    ["npc_dota_neutral_harpy_storm"] = true,
    ["npc_dota_neutral_gnoll_assassin"] = true, 
    ["npc_dota_neutral_ghost"] = true, 
    ["npc_dota_neutral_fel_beast"] = true, 
}

start_quest.early_items =
{
	["item_bracer_custom"] = true,
	["item_wraith_band_custom"] = true,
	["item_magic_wand_custom"] = true,
	["item_null_talisman_custom"] = true
}

start_quest.simple_quest =
{
	["Quest_4"] = true,
	["Quest_5"] = true,
	["Quest_6"] = true,
	["Quest_2"] = true,
	["Quest_7"] = true,
	["Quest_8"] = true,
	["Quest_9"] = true,
	["Quest_10"] = true,
	["Quest_11"] = true,
}


function start_quest:InitGameMode()

start_quest.test_disable = test and true or false
CustomGameEventManager:RegisterListener( "RequestCurrentQuests", Dynamic_Wrap(self, 'SendCurrentQuests'))
end

function start_quest:CheckTimer()
if not IsServer() then return end
if start_quest.test_disable then return end
if _G.ReadyPlayers < PlayerCount then return end

local current_time = GameRules:GetDOTATime(false, false)

for name,data in pairs(start_quest.quest_table) do
	if not data.completed and data.time and current_time >= data.time then
		data.completed = true
		for id,player in pairs(players) do
			if player.disable_quest == 0 and player.completed_start_quest == 0 then
				start_quest:BeginQuest(id, name)
			end
		end
	end
end

end

function start_quest:HeroPickEvent(id)
if not IsServer() then return end
if start_quest.test_disable then return end

local player = PlayerResource:GetPlayer(id)
local subData = CustomNetTables:GetTableValue("sub_data", tostring( id ))

if not player or not subData then return end
if subData.disable_quest == 1 then return end
if HTTP.playersData[id].achivment_done_before and HTTP.playersData[id].achivment_done_before[2] then return end

Timers:CreateTimer(1, function()
	CustomGameEventManager:Send_ServerToPlayer(player, "ShowQuestAlert", {type = "Quest_Start"})
end)

end



function start_quest:BeginQuest(id, name)
if not IsServer() then return end
local player = players[id]
if not player then return end

local quest_data = start_quest.quest_table[name]
if not quest_data then return end

CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "ShowQuestAlert", {type = name, timer = quest_data.timer})

if not player.start_quest_table then
	player.start_quest_table = {}
end

local data = {}
data.name = name
data.progress = 0
data.completed = 0
data.follow_quest = quest_data.follow_quest and quest_data.follow_quest or nil
data.follow_message = quest_data.follow_message and quest_data.follow_message or nil
data.timer = quest_data.timer and quest_data.timer or 0
data.goal = quest_data.goal and quest_data.goal or 0

if quest_data.use_ping then
	start_quest:RegisterPing(name, player)
end

table.insert(player.start_quest_table, data)
start_quest:SendCurrentQuests({PlayerID = id})
end



function start_quest:SendCurrentQuests(data)
if not IsServer() then return end
if start_quest.test_disable then return end

local id = data.PlayerID
if not id then return end
if not players[id] or players[id].disable_quest == 1 or players[id].completed_start_quest == 1 then return end

CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "UpdateCurrentQuests", {quest_data = players[id].start_quest_table, max_quest = start_quest.max_quest})
end


function start_quest:CheckQuest(data)
if not IsServer() then return end
local id = data.id
if not id or not players[id] then return end
if players[id].disable_quest == 1 then return end
if players[id].completed_start_quest == 1 then return end

local quest_name = data.quest_name
local progress = 0

if quest_name == "Quest_1" then
	if data.item and start_quest.early_items[data.item] then
		progress = 1
	end
elseif quest_name == "Quest_3" then
	if data.creep and start_quest.small_creeps[data.creep] then
		progress = 1
	end
elseif start_quest.simple_quest[quest_name] then
	progress = 1
end

if progress == 0 then return end
start_quest:CompleteQuest(id, quest_name, progress)
end



function start_quest:CompleteQuest(id, quest_name, progress)
if not IsServer() then return end
if not id or not players[id] or not players[id].start_quest_table then return end

for _,data in pairs(players[id].start_quest_table) do
	if data.name == quest_name and data.completed == 0 then
		data.progress = data.progress + progress
		if data.progress >= data.goal then
			data.completed = 1
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "HideQuestAlert", {completed_quest = data.name})

			Timers:CreateTimer(3, function()
				if data.follow_quest then
					start_quest:BeginQuest(id, data.follow_quest)
				elseif data.follow_message then
					CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "ShowQuestAlert", {type = data.follow_message, timer = data.timer})
				end
			end)

			local quest_ended = dota1x6:CheckAchivment(id, 2)
			if quest_ended == true then
				local timer = 3
				if data.follow_message then
					timer = timer + data.timer + 1
				end
				Timers:CreateTimer(timer, function()
					CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "ShowQuestAlert", {type = "Quest_end"})
				end)
			end

		end
		break
	end
end
start_quest:SendCurrentQuests({PlayerID = id,})
end


function start_quest:RegisterPing(name, player)
if not IsServer() then return end
local tower = towers[player:GetTeamNumber()]
if not tower then return end

if name == "Quest_3" then
	local spawner_table = {}
	local tower_origin = tower:GetAbsOrigin()
	for _,spawn_name in pairs(start_quest.Neutrals_Camps["Easy"]) do
		local trigger = Entities:FindByName(nil, spawn_name)
		if IsValid(trigger) then
			table.insert(spawner_table, trigger)
		end
	end
	table.sort( spawner_table, function(x,y) return (y:GetAbsOrigin() - tower_origin):Length2D() > (x:GetAbsOrigin() - tower_origin):Length2D() end )
	local count = 0
	for _,spawner in pairs(spawner_table) do
		count = count + 1
		start_quest:ExecutePing(player, spawner:GetAbsOrigin().x, spawner:GetAbsOrigin().y, 3)
		if (count >= 2) then
			break
		end
	end
end

if name == "Quest_7" then
	local radiant_creeps = Entities:FindAllByModel("models/creeps/lane_creeps/creep_radiant_melee/radiant_melee_mega.vmdl")
	for _,creep in pairs(radiant_creeps) do
		if creep.is_patrol_creep then
			start_quest:ExecutePing(player, 0, 0, 3, creep)
			break
		end
	end
	local dire_creeps = Entities:FindAllByModel("models/creeps/lane_creeps/creep_bad_melee/creep_bad_melee_mega.vmdl")
	for _,creep in pairs(dire_creeps) do
		if creep.is_patrol_creep then
			start_quest:ExecutePing(player, 0, 0, 3, creep)
			break
		end
	end
end

if name == "Quest_8" then
	local spawner_table = Entities:FindAllByName("bounty_spawner")
	for _,spawner in pairs(spawner_table) do
		start_quest:ExecutePing(player, spawner:GetAbsOrigin().x, spawner:GetAbsOrigin().y, 3)
	end
end

if name == "Quest_9" then
	local teleport = teleports[tower:GetTeamNumber()]
	if IsValid(teleport) then
		start_quest:ExecutePing(player, teleport:GetAbsOrigin().x, teleport:GetAbsOrigin().y, 3)
	end
end

end


function start_quest:ExecutePing(player, x, y, count, unit)
if not IsServer() then return end
local pos_x = unit and unit:GetAbsOrigin().x or x
local pos_y = unit and unit:GetAbsOrigin().y or y

GameRules:ExecuteTeamPing( player:GetTeamNumber(), pos_x, pos_y, player, 0 )

if count > 1 then
	Timers:CreateTimer(2, function()
		start_quest:ExecutePing(player, x, y, count - 1, unit)
	end)
end

end


function start_quest:QuestReward(id)
if not IsServer() then return end

local sub_data = CustomNetTables:GetTableValue("sub_data", tostring(id))
if not sub_data then return end

sub_data.used_quest_reward = 1
CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "ShowQuestAlert", {type = "Quest_shop", timer = 15})
CustomNetTables:SetTableValue("sub_data", tostring(id), sub_data)
end





function start_quest:SendTip(id)
if not IsServer() then return end
local player = players[id]

if not player or player.disable_tips == 1 then return end
if player.completed_start_quest == 0 and player.disable_quest == 0 then return end

CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "ShowQuestAlert", {is_tip = 1, timer = 12})
end


function start_quest:HideTip(id)
if not IsServer() then return end
local player = players[id]

if not player or player.disable_tips == 1 then return end
if player.completed_start_quest == 0 and player.disable_quest == 0 then return end
CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "HideQuestAlert", {})
end