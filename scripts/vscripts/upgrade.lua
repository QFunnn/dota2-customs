--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



if upgrade == nil then
	_G.upgrade = class({})
end


function upgrade:InitGameMode()

CustomGameEventManager:RegisterListener("activate_choise", Dynamic_Wrap(self, "make_choise"))
CustomGameEventManager:RegisterListener("refresh_sphere", Dynamic_Wrap(self, "refresh_sphere"))

end


function upgrade:GetRarityName(rare)
	if rare == 1 then
		return "gray"
	end
	if rare == 2 then
		return "blue"
	end
	if rare == 3 then
		return "purple"
	end
	if rare == 4 then
		return "orange"
	end
	return nil
end

function upgrade:GetBroodScepter(player, type)
local talent_table = {}
if not ingame_talents['broodmother_spiders'] then return talent_table end

local count = 0
for _,data in pairs(ingame_talents['broodmother_spiders']) do
	count = count + 1
end

for i = 1,count do
	local name = "modifier_broodmother_scepter_"..i
	local data = ingame_talents['broodmother_spiders'][name]
	if data then
		local rarity = data["rarity"]
		if rarity and ((rarity == "blue" and type == 14) or (rarity == "purple" and type == 15)) then
			table.insert(talent_table, name)
		end
	end
end

local BroodPossible = function(ignore_table)
	local result = {}
	for i = 1,#talent_table do
		local name = talent_table[i]
		local good = true
		for _,ignore_name in pairs(ignore_table) do
			if ignore_name == name then
				good = false
			end
		end

		local level = player:TalentLevel(name)
		local max_level = player:GetTalentValue(name, "max_level", true)
		if level >= max_level then
			good = false
		end
		if good then
			table.insert(result, name)
		end
	end
	return result
end

local result_table = {}
if type == 15 then
	for i = 1,3 do
		local possible_table = BroodPossible(result_table)
		if #possible_table > 0 then
			table.insert(result_table, possible_table[1])	
		end
	end
else
	for i = 1,2 do
		local possible_table = BroodPossible(result_table)
		if #possible_table > 0 then
			local random = RandomInt(1, #possible_table)
			table.insert(result_table, possible_table[random])	
		end
	end
end

return result_table
end


function upgrade:GetAlchemistItems(player)

local items_table = {}

for name,data in pairs(ingame_talents['alchemist_items']) do
	table.insert(items_table, name)
end

local used_types = {[1] = false, [2] = false}

local r_1 = RandomInt(1, #items_table)
local r_2 = r_1
local r_3 = r_1

local name_1 = items_table[r_1]
used_types[ingame_talents['alchemist_items'][name_1].type] = true

repeat r_2 = RandomInt(1, #items_table)
until (r_2 ~= r_1)

local name_2 = items_table[r_2]
used_types[ingame_talents['alchemist_items'][name_2].type] = true

local name_3

repeat r_3 = RandomInt(1, #items_table)
	name_3 = items_table[r_3]
	used_types[ingame_talents['alchemist_items'][name_3].type] = true

until (r_2 ~= r_3 and r_1 ~= r_3 and used_types[1] == true and used_types[2] == true)

return {name_1, name_2, name_3}
end





function ContainName(name, array)
if not array then return false end

for i = 1,#array do 
	if array[i] == name then 
		return true
	end 
end 

return false
end 


function upgrade:CheckType(player, data)
if not data["exception"] then return true end 

local exceptions = data["exception"]
local hero = players[player:GetId()]
local hero_type = hero.HeroType

if ContainName("only_normal", exceptions) and hero:GetPrimaryAttribute() == DOTA_ATTRIBUTE_ALL then
	return false
end

if ContainName("only_all", exceptions) and hero:GetPrimaryAttribute() ~= DOTA_ATTRIBUTE_ALL then
	return false
end

if ContainName("mage", exceptions) and not ContainName("mage", hero_type) then 
	return false
end 

if ContainName("melle", exceptions) and not ContainName("melle", hero_type) then 
	return false
end 

return true
end



function upgrade:MainEpicAllowed(player, name)

local data = ingame_talents[player:GetUnitName()][name]
if not data then return true end

if data["rarity"] ~= "purple" then return true end 
if data["main_epic"] ~= 1 then return true end

if not player:HasTalent(name) or player:TalentLevel(name) ~= 1 then 
	return true
end 

local skill = data["skill_number"]

for name,talent in pairs(ingame_talents[player:GetUnitName()]) do 
	if talent["skill_number"] == skill and talent["rarity"] == "purple" and upgrade:GetMaxLevel(talent) == 1 and not player:HasTalent(name) then 
		return false
	end 
end 

return true
end 


function upgrade:GetMaxLevel(data)
local rarity = data["rarity"]
local max_level = 0

if rarity == "blue" then
    max_level = 3
elseif rarity == "purple" or rarity == "orange" then
    max_level = 1
end

if data["main_epic"] == 1 then
    max_level = 2
end

return max_level
end


function upgrade:FindUpgrade(player, skill, rarity, banned_talents, banned_skills)

local all_upgrades = ingame_talents[player:GetUnitName()]
local is_general = false

if rarity == 1 or skill == 0 then  -- Белый или общий талант
	is_general = true
	all_upgrades = ingame_talents["general"]
end 

local banned = {}
local possible_upgrades = {}
local rarity_name = upgrade:GetRarityName(rarity)

if new_talent_system[player:GetUnitName()] then
	is_general = false
	all_upgrades = ingame_talents[player:GetUnitName()] 
	if rarity == 1 then
		is_general = true
		all_upgrades = ingame_talents["general"]
	end

	for name,data in pairs(all_upgrades) do 
		local skill_number = data["skill_number"]	
		local data_rarity = data["rarity"]
		local max_level = upgrade:GetMaxLevel(data)

		if is_general then 
			skill_number = skill -- Если общий талант, номер скила всегда подходит
		end 

		local has_talent = player:HasTalent(name)
		if rarity == 1 then 
			has_talent = false -- Если белый талант, уровень не 
		end

		if data_rarity ~= rarity_name or -- Не подходит тип 
		   (has_talent and (player:TalentLevel(name) >= max_level or rarity == 4)) or -- Улучшение уже есть с макс. уровнем
		   (skill_number ~= skill and skill ~= -1) or  -- Не тот скил
		   (rarity == 1 and not upgrade:CheckType(player, data)) or -- Тип героя подходит под общий талант
		   ContainName(name, banned_talents) or 
		   (ContainName(data["skill_number"], banned_skills) and skill ~= 0) or 
		   not upgrade:MainEpicAllowed(player, name) or
		   (player.banned_talents and player.banned_talents[name])
		then 
			banned[name] = true
		end 
	end 

else
	for name,data in pairs(all_upgrades) do 
		local skill_number = data["skill_number"]	
		local data_rarity = data["rarity"]
		local max_level = upgrade:GetMaxLevel(data)

		if is_general then 
			skill_number = skill -- Если общий талант, номер скила всегда подходит
		end 

		local has_talent = player:HasTalent(name)
		if rarity == 1 then 
			has_talent = false -- Если белый талант, уровень не 
		end

		if data_rarity ~= rarity_name or -- Не подходит тип 
		   (has_talent and (player:TalentLevel(name) >= max_level or rarity == 4)) or -- Улучшение уже есть с макс. уровнем
		   (skill_number ~= skill) or  -- Не тот скил
		   ((skill == 0 or rarity == 1) and not upgrade:CheckType(player, data)) or -- Тип героя подходит под общий талант
		   (ContainName(name, banned_talents)) or 
		   (ContainName(data["skill_number"], banned_skills) and skill ~= 0) or 
		   not upgrade:MainEpicAllowed(player, name)
		then 
			banned[name] = true
		end 
	end 
end

for name,data in pairs(all_upgrades) do 
	if not banned[name] then 
		table.insert(possible_upgrades, name)
	end 
end 

return possible_upgrades
end 


function upgrade:CheckProMod(player, data)
if not pro_mod then return true end
if not PRO_MOD_ALLOWED then return true end
if not PRO_MOD_ALLOWED[player:GetUnitName()] then return true end
if #PRO_MOD_ALLOWED[player:GetUnitName()] == 1 and HTTP.playersData[player:GetId()].firstOrangeTalent then return true end

for _,skill_number in pairs(PRO_MOD_ALLOWED[player:GetUnitName()]) do
	if skill_number == data["skill_number"] then
		return true
	end
end

return false
end


function upgrade:find_legendary(player)
if not players[player:GetId()] then return end
if not ingame_talents[player:GetUnitName()] then return end

local choise_table = {}

for name, data in pairs(ingame_talents[player:GetUnitName()]) do
	if data["rarity"] == "orange" then
		local new_data = data
		new_data["name"] = name
		if not player:HasTalent(name) and upgrade:CheckProMod(player, data) and (not player.banned_talents or not player.banned_talents[name]) then
			table.insert(choise_table, new_data)
		end
	end
end

table.sort( choise_table, function(x,y) return y["skill_number"] > x["skill_number"] end )

for i = 1,#choise_table do
	table.insert(players[player:GetId()].choise, choise_table[i]["name"])
end

end



function upgrade:GetPatrol(name)
if not IsServer() then return end

local possible_table = {}

for talent_name,data in pairs(ingame_talents["patrol"]) do
	if data[name] == 1 then
		table.insert(possible_table, talent_name)
	end
end

local r_1 = RandomInt(1, #possible_table)
local r_2 = r_1

repeat r_2 = RandomInt(1, #possible_table)
until r_2 ~= r_1

return {possible_table[r_1], possible_table[r_2]}
end



function upgrade:init_upgrade(player, rarity, can_refresh, after_legen, prev_choise, instant, patrol_name)
local player_table = players[player:GetId()]
if not player_table then return end

local id = player:GetId()
if PlayerResource:GetPlayer(id) and PlayerResource:GetPlayer(id):GetAssignedHero() then
	if PlayerResource:GetPlayer(id):GetAssignedHero():GetUnitName() ~= player_table:GetUnitName() then
		return
	end
end

if not test or patrol_name then
	local duration = 90
	if patrol_name then
		duration = 30
	end

	player_table:AddNewModifier(player_table, nil, "modifier_end_choise", {duration = duration})
end

player_table.choise = {}

local legendary_info = false

if patrol_name then
	player_table.choise = upgrade:GetPatrol(patrol_name)
elseif rarity == 13 then 
	player_table.choise = upgrade:GetAlchemistItems(player)

elseif rarity == 14 or rarity == 15 then
	player_table.choise = upgrade:GetBroodScepter(player, rarity)
elseif rarity == 10 then
	player_table.choise = {"modifier_lownet_gold", "modifier_lownet_blue", "modifier_lownet_purple", }
elseif rarity == 4 then 
	upgrade:find_legendary(player)
	
	if player_table.chosen_skill == 0 then
		legendary_info = 1
	end

elseif (rarity == 1 or rarity == 2 or rarity == 3) then 

	local skills_upgrades = {}
	local rarity_table = {}
	local banned_upgrades = {}
	local banned_skills = {}
	local main_skill = nil


	if prev_choise then 
		for _,data in pairs(prev_choise) do
			if data['name'] then 
				table.insert(banned_upgrades, data['name']) 
				if (after_legen == false or after_legen == 0) then 
					table.insert(banned_skills, tonumber(data['skill_number'])) 
				end 
			end
		end 
	end 

	if player.chosen_skill ~= 0 and (after_legen == true or test == true) then 
		main_skill = player.chosen_skill
	end
	for i = 1,4 do 
		rarity_table[i] = {}
	end 

	for skill_number = 0,4 do 
		skills_upgrades[skill_number] = {}

		local min_rarity = 1
		if rarity == 4 then
			min_rarity = rarity
		end

		local found = false
		for rarity_number = rarity, min_rarity, -1 do

			skills_upgrades[skill_number][rarity_number] = {}

			local data = upgrade:FindUpgrade(player, skill_number, rarity_number, banned_upgrades, banned_skills)
			if #data <= 0 and skill_number == 0 then
				data = upgrade:FindUpgrade(player, -1, rarity_number, banned_upgrades, banned_skills)
			end
			skills_upgrades[skill_number][rarity_number] = data

			if #data <= 0 then
				if rarity_number == rarity and skill_number == main_skill then
					main_skill = nil -- Если в выбранной редкости нет таланта главной ветки - главная ветка не будет работать
				end  
			elseif not found then
				found = true
				table.insert(rarity_table[rarity_number], skill_number)
			end
		end
	end

	local skill_1 = main_skill
	local skill_2 = nil
	local skill_3 = 0

	for index = 4, 1, -1 do
		local count = #rarity_table[index]
		if count > 0 then
			local skill_1_added = false

			if not skill_1 then 
				local random = 0
				repeat random = rarity_table[index][RandomInt(1, count)]
				until random ~= 0

				skill_1 = random
				skill_1_added = true
			end 

			if not skill_2 and (not skill_1_added or count > 2) then 
				repeat skill_2 = rarity_table[index][RandomInt(1, count)]
				until (skill_2 ~= skill_1 and skill_2 ~= 0)
			end 
		end  
		if skill_1 and skill_2 then 
			break
		end 
	end 

	local final_table = {skills_upgrades[skill_1], skills_upgrades[skill_2], skills_upgrades[skill_3]}

	if rarity == 1 and player:HasTalent("modifier_up_graypoints") then
		table.insert(final_table, skills_upgrades[skill_3])
	end

	local result = {}
	for _,data in pairs(final_table) do
		local found = false
		for rarity_index = 4, 1, -1 do
			if not found and data[rarity_index] and #data[rarity_index] > 0 then
				local possible_table = {}
				for _,skill in pairs(data[rarity_index]) do
					if not ContainName(skill, result) then
						table.insert(possible_table, skill)
					end
				end
				if #possible_table > 0 then
					found = true
					table.insert(result, possible_table[RandomInt(1, #possible_table)])
				end
			end
		end
	end
	player_table.choise = result
end 

local refresh = false

if can_refresh == nil then
	if rarity == 3 and (player_table.can_refresh == true or test == true) then --and After_Lich == true then
		refresh = true
	end
end

local mod_stacks = {}

for i = 1, #player_table.choise do
	local name = player_table.choise[i]

	mod_stacks[i] = player:TalentLevel(name)
end

local perma_info = {}

for i = 1, #player_table.choise do
	perma_info[i] = {}
	perma_info[i].stack = -1
	local name = player_table.choise[i]

	if player:GetTalentValue(name, "is_perma", true ) == 1 then 
		local mod = player:FindModifierByName(player:GetTalentValue(name, "mod_name", true ))

		perma_info[i].stack = 0
		perma_info[i].max = -1 

		if player:GetTalentValue(name, "max", true ) ~= 0 then 
			perma_info[i].max = player:GetTalentValue(name, "max", true )
		end 

		if mod then 
			perma_info[i].stack = mod:GetStackCount()
		end 
	end 
end


player_table.can_refresh_choise = refresh

if #player_table.choise == 0 then 
	player_table:RemoveModifierByName("modifier_end_choise")
	return
end 

if not instant then 

	CustomGameEventManager:Send_ServerToPlayer(
		PlayerResource:GetPlayer(player:GetId()),
		"show_choise",
		{
			choise = player_table.choise,
			mods = mod_stacks,
			legendary = l,
			hasup = player_table:HasTalent("modifier_up_graypoints"),
			refresh = refresh,
			after_legen = after_legen,
			perma_info = perma_info,
			alert = legendary_info
		}
	)


	player_table.choise_table = {player_table.choise, false, player_table:HasTalent("modifier_up_graypoints"), mod_stacks, refresh }

else 
	local kv = {}
	kv.PlayerID = player:GetId()
	kv.chosen = RandomInt(1, #player_table.choise)
	kv.random = 1

	upgrade:make_choise(kv)
end

mod_stacks = {}
end






function upgrade:make_choise(kv)
if kv.PlayerID == nil then return end

local id = kv.PlayerID
local hero = GlobalHeroes[id]
local chosen_number = kv.chosen
local player = players[id]

if hero and player then

	hero:RemoveModifierByName("modifier_end_choise")

	if #player.choise > 0 then
		
		player.can_refresh_choise = false

		local skill_name = player.choise[chosen_number]

		if skill_name then
			hero:InitTalent(skill_name)

			if kv.random and kv.random == 1 then
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(hero:GetId()), "random_talent_alert", { skill = skill_name, hero = hero:GetUnitName() } )
			else
				HTTP.FillTalentsData(id, skill_name, player.choise)
			end
		end

		player.choise_table = {}
		player.choise = {}
	end
end

CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), "end_choise", {choise = chosen_number} )
end





function upgrade:refresh_sphere(kv)
if kv.PlayerID == nil then
	return
end
local hero = GlobalHeroes[kv.PlayerID]
local player = players[kv.PlayerID]

if player == nil then
	return
end

player.can_refresh = false

if #player.choise == 0 then
	return
end

if not player.can_refresh_choise then
	return
end


local after = false
if kv.after_legen and kv.after_legen == 1 then 
	after = true
end

player.can_refresh_choise = false
player.choise = {}
upgrade:init_upgrade(hero, 3, nil, after, kv.global_choise)
end



function upgrade:EndChoiseJs(kv)
	if kv.PlayerID == nil then
		return
	end

	local hero = GlobalHeroes[kv.PlayerID]

	if hero then 
		--hero:RemoveModifierByName("modifier_end_choise")
	end
end

