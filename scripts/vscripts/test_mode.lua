--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



test_mode = class({})

test_mode.TeamList =
{
	[DOTA_TEAM_GOODGUYS] = 0,
	[DOTA_TEAM_BADGUYS] = 0,
	[DOTA_TEAM_CUSTOM_1] = 0,
	[DOTA_TEAM_CUSTOM_2] = 0,
	[DOTA_TEAM_CUSTOM_7] = 0,
	[DOTA_TEAM_CUSTOM_4] = 0
}


test_mode.TeamNumber =
{
	[1] = DOTA_TEAM_GOODGUYS,
	[2] = DOTA_TEAM_BADGUYS,
	[3] = DOTA_TEAM_CUSTOM_1,
	[4] = DOTA_TEAM_CUSTOM_2,
	[5] = DOTA_TEAM_CUSTOM_7,
	[6] = DOTA_TEAM_CUSTOM_4,
}

test_mode.BannedHeroes = {}
test_mode.BotHeroes = {}
test_mode.PlayerHeroes = {}
test_mode.team_not_full = -1
test_mode.hud_hidden = false

function test_mode:InitGameMode()
CustomGameEventManager:RegisterListener( "AddTalent", Dynamic_Wrap(self, "AddTalent"))
CustomGameEventManager:RegisterListener( "AddLevel", Dynamic_Wrap(self, "AddLevel"))
CustomGameEventManager:RegisterListener( "AddGold", Dynamic_Wrap(self, "AddGold"))
CustomGameEventManager:RegisterListener( "AddItem", Dynamic_Wrap(self, "AddItem"))
CustomGameEventManager:RegisterListener( "AddHero", Dynamic_Wrap(self, "AddHero"))
CustomGameEventManager:RegisterListener( "LevelBots", Dynamic_Wrap(self, "LevelBots"))
CustomGameEventManager:RegisterListener( "AddBotItem", Dynamic_Wrap(self, "AddBotItem"))
CustomGameEventManager:RegisterListener( "NoBot", Dynamic_Wrap(self, "NoBot"))
CustomGameEventManager:RegisterListener( "RefreshButton", Dynamic_Wrap(self, "RefreshButton"))
CustomGameEventManager:RegisterListener( "HudButton", Dynamic_Wrap(self, "HudButton"))

if test then
	if false then
		test_mode:DoSound()
	end
end

end




function test_mode:DoSound()
local sound_list = LoadKeyValues("scripts/sound_events/test.txt")
test_mode:PrintSoundData(sound_list)
end

function test_mode:PrintSoundData(sound_list)
local new_table = {}

local operator_table = 
{
	["volume"] = "volume",
	["pitch_rand_min"] = "pitch_rand_min",
	["pitch_rand_max"] = "pitch_rand_max",
	["pitch"] = "pitch",
	["soundlevel"] = "soundlevel",
	["distance_max"] = "distance_max",
	["volume_fade_out"] = "volume_fade_out",

}

for key, data in pairs(sound_list) do
	new_table[key] = {}
	for new_key, new_data in pairs(data["operator_stacks"]["update_stack"]["reference_operator"]) do
		if new_key == "reference_stack" then
			new_table[key]["type"] = new_data
		elseif new_key == "operator_variables" then
			for operator_name, operator_data in pairs(new_data) do
				for operator_table_name,operator_table_data in pairs(operator_table) do
					if operator_name == operator_table_name then
						new_table[key][operator_table_data] = operator_data["value"]
					end
				end

				if operator_name == "vsnd_files" then
					new_table[key]["vsnd_files"] = {}

					for _,sound_name in pairs(operator_data["value"]) do
						table.insert(new_table[key]["vsnd_files"], sound_name)
					end
				end
			end
		end
	end
end

print("<!-- kv3 encoding:text:version{e21c7f3c-8a33-41c5-9977-a76d3a32aa0d} format:generic:version{7412167c-06e9-4698-aff2-e63eb59037e7} -->")
print("{")
print("")

for key, data in pairs(new_table) do
	print(key.." =")
	print("{")
	for operator_name, operator_data in pairs(data) do
		if type(operator_data) ~= "table" then
			if operator_name == "type" then
				print(string.rep(" ", 1*3)..operator_name..' = "'..operator_data..'"')
			else
				print(string.rep(" ", 1*3)..operator_name.." = "..operator_data)
			end
		else
			print(string.rep(" ", 1*3)..operator_name.." = ")
			print(string.rep(" ", 1*3).."[")
			for _,sound_name in pairs(operator_data) do
				print(string.rep(" ", 1*6)..'"'..sound_name..'",')
			end
			print(string.rep(" ", 1*3).."]")
		end
	end
	print("}")
	print("")
end

print("}")
end


function test_mode:NoBot(data)
if _G.TestMode == false then return end
if data.PlayerID == nil then return end

CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(data.PlayerID), "CreateIngameErrorMessage", {message = "no_selected_bot"})
end


function test_mode:AddLevel(data)
if _G.TestMode == false then return end
if data.PlayerID == nil then return end

local player = players[data.PlayerID]

if not player then return end

for i = 1,data.value do 
	player:HeroLevelUp(false)
end 


test_mode:MaxSkills(player)

end


test_mode.init_players = false

function test_mode:InitPlayers()
if test_mode.init_players == true then return end

for id = 0, 24 do
	if ValidId(id) and PlayerResource:GetPlayer(id) and PlayerResource:GetPlayer(id):GetAssignedHero() then
	
		test_mode.init_players = true
		test_mode:AddPlayer(id)
	end
end

CustomGameEventManager:Send_ServerToAllClients("set_test_mode",  {state = _G.TestMode})
end


function test_mode:AddPlayer(id, is_bot)

local hero = PlayerResource:GetPlayer(id):GetAssignedHero() 
local count = test_mode.TeamList[hero:GetTeamNumber()]

if is_bot then
	test_mode.BotHeroes[hero:GetUnitName()] = hero:entindex()
end

test_mode.TeamList[hero:GetTeamNumber()] = count + 1
test_mode.BannedHeroes[hero:GetUnitName()] = hero:GetUnitName()


local count = #test_mode.PlayerHeroes + 1

test_mode.PlayerHeroes[count] = {}
test_mode.PlayerHeroes[count].id = id 
test_mode.PlayerHeroes[count].ent = hero:entindex()

local panel_id = -1

for id,team in pairs(test_mode.TeamNumber) do
	if team == hero:GetTeamNumber() then
		panel_id = id
	end
end

test_mode.PlayerHeroes[count].team = panel_id
test_mode.PlayerHeroes[count].pos_in_team = test_mode.TeamList[hero:GetTeamNumber()]

team_not_full = -1
local team_not_full_id = -1

local team_status = {}

for i = 1,max_teams do

	team_status[i] = {}
	team_status[i].is_full = 1
	team_status[i].is_current = 0

	local team = test_mode.TeamNumber[i]
	if team then
		local team_count = test_mode.TeamList[team]
		if team_count < players_in_team then
			team_status[i].is_full = 0
			if team_not_full == -1 then
				team_not_full = team
				team_status[i].is_current = 1
			end
		end
	end
end


CustomNetTables:SetTableValue("test_mode", "players_heroes", test_mode.PlayerHeroes)
CustomNetTables:SetTableValue("test_mode", "banned_heroes", test_mode.BannedHeroes)
CustomNetTables:SetTableValue("test_mode", "bot_heroes", test_mode.BotHeroes)
CustomNetTables:SetTableValue("test_mode", "team_status", team_status)
end


function test_mode:AddGold(data)
if _G.TestMode == false then return end
if data.PlayerID == nil then return end


local player = players[data.PlayerID]

if not player then return end

player:ModifyGoldFiltered(data.value, true, DOTA_ModifyGold_CreepKill)
end







function test_mode:AddTalent(data)
if _G.TestMode == false then return end
if data.PlayerID == nil then return end
if data.ent == nil then return end 


local unit = EntIndexToHScript(data.ent)
local player = players[data.PlayerID]

if not player then return end
if not unit then return end 

local hero = unit

if not hero:IsAlive() then return end

local skill_data = nil
local skill_name = data.value

if not skill_name then return end

local skill_data = nil
for _, skills_group in pairs(ingame_talents) do
	for name, data in pairs(skills_group) do
		if name == skill_name then
			skill_data = data
			break
		end
	end
end

if skill_data == nil then
	return
end

hero:InitTalent(skill_name)

CustomGameEventManager:Send_ServerToAllClients("update_test_talents",  {name = skill_name, type = skill_data["rarity"], level = hero:TalentLevel(skill_name), max = upgrade:GetMaxLevel(skill_data)})
end



function test_mode:AddItem(data)
if _G.TestMode == false then return end
if data.PlayerID == nil then return end


local player = players[data.PlayerID]

if not player then return end

test_mode:GiveItem(player, data.value)
end





function test_mode:AddHero(data, full_test)
if _G.TestMode == false then return end
test_mode:InitPlayers()

if data.PlayerID == nil then return end
if data.value == nil then return end

local player = players[data.PlayerID]

if not player then return end
if test_mode.BannedHeroes[data.value] then return end


if not data.spawn_for_team or data.spawn_for_team == -1 then return end

local team = test_mode.TeamNumber[data.spawn_for_team]
if not team then return end

local name = data.value

FireGameEvent("save_talents", 
{
    hero_name = name,
})

if added_shop_heroes[name] then
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

local unit = DebugCreateHeroWithVariant( PlayerResource:GetPlayer(player:GetId()), data.value, 0, team, false,
function( unit )
	local point = player:GetAbsOrigin() + player:GetForwardVector()*300

	if full_test then
		point = (player:GetAbsOrigin() + player:GetForwardVector()*500) + RandomVector(300)
	end

	--GlobalHeroes[#GlobalHeroes + 1] = unit
	unit:SetTeam(team)

	unit.is_bot = true

	unit:SetControllableByPlayer(player:GetPlayerID(), true)

	unit:AddNewModifier(unit, nil, "modifier_test_hero_custom", {x = point.x, y = point.y, full_test = full_test})

	if test then
		local tp_item = CreateItem("item_dagon_5_custom", unit, unit)
		unit:AddItem(tp_item)
		for i = 1,4 do
			local tp_item = CreateItem("item_moon_shard", unit, unit)
			unit:AddItem(tp_item)
		end
	end

	bots_ids[unit:GetId()] = true
	test_mode:AddPlayer(unit:GetId(), true)
	dota1x6:initiate_player(unit, true)

	HTTP.Request("/get_offered_talents",
		{
			matchId = tostring(GameRules:Script_GetMatchID()),
			matchKey = HTTP.MATCH_KEY,
			heroName = {data.value},
		}, function(data)
			talents_values:SendPickRates(data)
	end, nil, false)


	if full_test then
		local level_data = {}
		level_data.ent = unit:entindex()
		level_data.PlayerID = data.PlayerID
		level_data.value = 30
		test_mode:LevelBots(level_data)

		local talent_data = {}
		talent_data.ent = unit:entindex()
		talent_data.PlayerID = data.PlayerID
		for name,talent in pairs(ingame_talents["general"]) do
			talent_data.value = name
			test_mode:AddTalent(talent_data)
		end
	end
end)


end




function test_mode:LevelBots(data)
if _G.TestMode == false then return end
if data.PlayerID == nil then return end
if data.ent == nil then return end 

local unit = EntIndexToHScript(data.ent)

local player = players[data.PlayerID]

if not player then return end
if not unit then return end

for i = 1,data.value do 
	unit:HeroLevelUp(true)
end 

test_mode:MaxSkills(unit)

end


function test_mode:MaxSkills(unit)
if _G.TestMode == false then return end


if unit:GetLevel() == 30 then 
	for i = 0, 30 do
		local current_ability = unit:GetAbilityByIndex(i)

		if current_ability then
			current_ability:SetLevel(current_ability:GetMaxLevel())
		end
	end
end

end




function test_mode:AddBotItem(data)
if _G.TestMode == false then return end
if data.PlayerID == nil then return end
if data.ent == nil then return end 

local unit = EntIndexToHScript(data.ent)

local player = players[data.PlayerID]

if not player then return end
if not unit then return end

test_mode:GiveItem(unit, data.value)

end


function test_mode:GiveItem(unit, name)
if _G.TestMode == false then return end

if unit:GetNumItemsInInventory() >= 9 then return end 

local item = CreateItem(name, unit, unit)
unit:AddItem(item)

end



function test_mode:RefreshButton(data)
if _G.TestMode == false then return end
if data.PlayerID == nil then return end

test_mode:RefreshAll()
end


function test_mode:RefreshAll()
if _G.TestMode == false then return end

local units = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, Vector(0,0,0), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_DEAD + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false)

for _,unit in pairs(units) do 

	if unit:IsAlive() then 
		unit:SetHealth(unit:GetMaxHealth())
		unit:SetMana(unit:GetMaxMana())
	end 

	dota1x6:RefreshCooldowns(unit)

end 

end



function test_mode:HudButton(data)
if _G.TestMode == false then return end
if data.PlayerID == nil then return end

test_mode.hud_hidden = not test_mode.hud_hidden

CustomGameEventManager:Send_ServerToAllClients("update_hud_hidden",  {state = test_mode.hud_hidden})
end