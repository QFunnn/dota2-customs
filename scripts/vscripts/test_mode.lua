--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


test_mode = class({})

test_mode.TeamList = {
	[DOTA_TEAM_GOODGUYS] = 0,
	[DOTA_TEAM_BADGUYS] = 0,
	[DOTA_TEAM_CUSTOM_1] = 0,
	[DOTA_TEAM_CUSTOM_2] = 0,
	[DOTA_TEAM_CUSTOM_7] = 0,
	[DOTA_TEAM_CUSTOM_4] = 0,
}

test_mode.TeamNumber = {
	[1] = DOTA_TEAM_GOODGUYS,
	[2] = DOTA_TEAM_BADGUYS,
	[3] = DOTA_TEAM_CUSTOM_1,
	[4] = DOTA_TEAM_CUSTOM_2,
	[5] = DOTA_TEAM_CUSTOM_7,
	[6] = DOTA_TEAM_CUSTOM_4,
}

test_mode.BotHeroes = {}
test_mode.PlayerHeroes = {}
test_mode.team_not_full = -1
test_mode.hud_hidden = false
test_mode.particle_log = false
test_mode.all_vision = false
test_mode.target_dummy = nil
test_mode.dummy_pending = false
test_mode.time_scale_steps = { 0.01, 0.2, 0.5, 1, 2, 3, 4, 5, 10 }
test_mode.time_scale_default = 4
test_mode.time_scale_index = 4

function test_mode:InitGameMode()
	CustomGameEventManager:RegisterListener("AddTalent", Dynamic_Wrap(self, "AddTalent"))
	CustomGameEventManager:RegisterListener("AddGold", Dynamic_Wrap(self, "AddGold"))
	CustomGameEventManager:RegisterListener("AddHero", Dynamic_Wrap(self, "AddHero"))
	CustomGameEventManager:RegisterListener("LevelBots", Dynamic_Wrap(self, "LevelBots"))
	CustomGameEventManager:RegisterListener("AddBotItem", Dynamic_Wrap(self, "AddBotItem"))
	CustomGameEventManager:RegisterListener("NoBot", Dynamic_Wrap(self, "NoBot"))
	CustomGameEventManager:RegisterListener("RefreshButton", Dynamic_Wrap(self, "RefreshButton"))
	CustomGameEventManager:RegisterListener("HudButton", Dynamic_Wrap(self, "HudButton"))
	CustomGameEventManager:RegisterListener("TargetDummy", Dynamic_Wrap(self, "TargetDummy"))
	CustomGameEventManager:RegisterListener("TimeScale", Dynamic_Wrap(self, "TimeScale"))
	CustomGameEventManager:RegisterListener("WaveNumber", Dynamic_Wrap(self, "WaveNumber"))
	CustomGameEventManager:RegisterListener("StartHunt", Dynamic_Wrap(self, "StartHunt"))
	CustomGameEventManager:RegisterListener("DestroyTower", Dynamic_Wrap(self, "DestroyTower"))
	CustomGameEventManager:RegisterListener("StartDuel", Dynamic_Wrap(self, "StartDuel"))
	CustomGameEventManager:RegisterListener("ParticleLog", Dynamic_Wrap(self, "ParticleLog"))
	CustomGameEventManager:RegisterListener("BountyRunes", Dynamic_Wrap(self, "BountyRunes"))
	CustomGameEventManager:RegisterListener("OrbShrines", Dynamic_Wrap(self, "OrbShrines"))
	CustomGameEventManager:RegisterListener("JungleCreeps", Dynamic_Wrap(self, "JungleCreeps"))
	CustomGameEventManager:RegisterListener("SpawnPatrol", Dynamic_Wrap(self, "SpawnPatrol"))
	CustomGameEventManager:RegisterListener("LaneWave", Dynamic_Wrap(self, "LaneWave"))
	CustomGameEventManager:RegisterListener("Vision", Dynamic_Wrap(self, "Vision"))

	CustomNetTables:SetTableValue("test_mode", "lane_waves", wave_types)

	if test then
		if false then
			test_mode:DoSound()
		end
	end

	test_mode:StartInitPlayersThink()
end

function test_mode:DoSound()
	local sound_list = LoadKeyValues("scripts/sound_events/test.txt")
	test_mode:PrintSoundData(sound_list)
end

function test_mode:PrintSoundData(sound_list)
	local new_table = {}

	local operator_table = {
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
					for operator_table_name, operator_table_data in pairs(operator_table) do
						if operator_name == operator_table_name then
							new_table[key][operator_table_data] = operator_data["value"]
						end
					end

					if operator_name == "vsnd_files" then
						new_table[key]["vsnd_files"] = {}

						for _, sound_name in pairs(operator_data["value"]) do
							table.insert(new_table[key]["vsnd_files"], sound_name)
						end
					end
				end
			end
		end
	end

	print(
		"<!-- kv3 encoding:text:version{e21c7f3c-8a33-41c5-9977-a76d3a32aa0d} format:generic:version{7412167c-06e9-4698-aff2-e63eb59037e7} -->"
	)
	print("{")
	print("")

	for key, data in pairs(new_table) do
		print(key .. " =")
		print("{")
		for operator_name, operator_data in pairs(data) do
			if type(operator_data) ~= "table" then
				if operator_name == "type" then
					print(string.rep(" ", 1 * 3) .. operator_name .. ' = "' .. operator_data .. '"')
				else
					print(string.rep(" ", 1 * 3) .. operator_name .. " = " .. operator_data)
				end
			else
				print(string.rep(" ", 1 * 3) .. operator_name .. " = ")
				print(string.rep(" ", 1 * 3) .. "[")
				for _, sound_name in pairs(operator_data) do
					print(string.rep(" ", 1 * 6) .. '"' .. sound_name .. '",')
				end
				print(string.rep(" ", 1 * 3) .. "]")
			end
		end
		print("}")
		print("")
	end

	print("}")
end

function test_mode:NoBot(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end

	CustomGameEventManager:Send_ServerToPlayer(
		PlayerResource:GetPlayer(data.PlayerID),
		"CreateIngameErrorMessage",
		{ message = "no_selected_bot" }
	)
end

test_mode.added_players = {}
test_mode.init_ticks = 0

function test_mode:InitPlayers()
	for id = 0, 24 do
		if ValidId(id) and PlayerResource:GetPlayer(id) and PlayerResource:GetPlayer(id):GetAssignedHero() then
			test_mode:AddPlayer(id)
		end
	end

	CustomGameEventManager:Send_ServerToAllClients("set_test_mode", { state = _G.TestMode })
end

function test_mode:AllPlayersAdded()
	local found = false

	for id = 0, 24 do
		if ValidId(id) then
			found = true
			if not test_mode.added_players[id] then
				return false
			end
		end
	end

	return found
end

function test_mode:StartInitPlayersThink()
	GameRules:GetGameModeEntity():SetThink(function()
		test_mode.init_ticks = test_mode.init_ticks + 1
		test_mode:InitPlayers()

		if test_mode:AllPlayersAdded() or test_mode.init_ticks >= 180 then
			return -1
		end

		return 1
	end, "TestModeInitPlayers", 1)
end

function test_mode:AddPlayer(id, is_bot)
	if test_mode.added_players[id] then
		return
	end
	test_mode.added_players[id] = true

	local hero = PlayerResource:GetPlayer(id):GetAssignedHero()
	local count = test_mode.TeamList[hero:GetTeamNumber()]

	if is_bot then
		test_mode.BotHeroes[hero:GetUnitName()] = hero:entindex()
	end

	test_mode.TeamList[hero:GetTeamNumber()] = count + 1

	local count = #test_mode.PlayerHeroes + 1

	test_mode.PlayerHeroes[count] = {}
	test_mode.PlayerHeroes[count].id = id
	test_mode.PlayerHeroes[count].ent = hero:entindex()

	local panel_id = -1

	for id, team in pairs(test_mode.TeamNumber) do
		if team == hero:GetTeamNumber() then
			panel_id = id
		end
	end

	test_mode.PlayerHeroes[count].team = panel_id
	test_mode.PlayerHeroes[count].pos_in_team = test_mode.TeamList[hero:GetTeamNumber()]

	team_not_full = -1
	local team_not_full_id = -1

	local team_status = {}

	for i = 1, max_teams do
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
	CustomNetTables:SetTableValue("test_mode", "bot_heroes", test_mode.BotHeroes)
	CustomNetTables:SetTableValue("test_mode", "team_status", team_status)
end

function test_mode:AddGold(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end
	if data.ent == nil then
		return
	end

	local unit = EntIndexToHScript(data.ent)

	if not IsValid(unit) then
		return
	end
	if not players[unit:GetId()] then
		return
	end

	unit:GiveGold(data.value, nil, true)
end

function test_mode:AddTalent(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end
	if data.ent == nil then
		return
	end

	local unit = EntIndexToHScript(data.ent)
	local player = players[data.PlayerID]

	if not IsValid(player, unit) then
		return
	end

	local hero = unit

	if not hero:IsAlive() then
		return
	end

	local skill_data = nil
	local skill_name = data.value

	if not skill_name then
		return
	end

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

	local max = upgrade:GetMaxLevel(skill_data)

	if hero:TalentLevel(skill_name) >= max then
		hero:RemoveTalent(skill_name)
		CustomGameEventManager:Send_ServerToAllClients(
			"update_test_talents",
			{ name = skill_name, type = skill_data["rarity"], level = 0, max = max }
		)
		return
	end

	hero:InitTalent(skill_name)

	CustomGameEventManager:Send_ServerToAllClients(
		"update_test_talents",
		{ name = skill_name, type = skill_data["rarity"], level = hero:TalentLevel(skill_name), max = max }
	)
end

function test_mode:AddHero(data, full_test)
	if _G.TestMode == false then
		return
	end
	test_mode:InitPlayers()

	if data.PlayerID == nil then
		return
	end
	if data.value == nil then
		return
	end

	local player = players[data.PlayerID]

	if not player then
		return
	end

	if not data.spawn_for_team or data.spawn_for_team == -1 then
		return
	end

	local team = test_mode.TeamNumber[data.spawn_for_team]
	if not team then
		return
	end

	local name = data.value

	FireGameEvent("save_talents", {
		hero_name = name,
	})

	if added_shop_heroes[name] then
		local subData = CustomNetTables:GetTableValue("sub_data", tostring(id))
		if subData and subData.player_items_onequip and subData.player_items_onequip[name] then
			for _, item in pairs(subData.player_items_onequip[name]) do
				wearables_system:PreSaveItemSelectionData(id, item, name)
			end
		end
		if subData and subData.player_items_onequip_effects and subData.player_items_onequip_effects[name] then
			for _, item in pairs(subData.player_items_onequip_effects[name]) do
				wearables_system:PreSaveItemSelectionEffectsData(id, item, name)
			end
		end
	end

	local unit = DebugCreateHeroWithVariant(
		PlayerResource:GetPlayer(player:GetId()),
		data.value,
		0,
		team,
		false,
		function(unit)
			local point = player:GetAbsOrigin() + player:GetForwardVector() * 300

			if full_test then
				point = (player:GetAbsOrigin() + player:GetForwardVector() * 500) + RandomVector(300)
			end

			--GlobalHeroes[#GlobalHeroes + 1] = unit
			unit:SetTeam(team)

			unit.is_bot = true

			unit:SetControllableByPlayer(player:GetPlayerID(), true)

			unit:AddNewModifier(
				unit,
				nil,
				"modifier_test_hero_custom",
				{ x = point.x, y = point.y, full_test = full_test }
			)

			if test then
				local tp_item = CreateItem("item_dagon_5_custom", unit, unit)
				unit:AddItem(tp_item)
				for i = 1, 4 do
					local tp_item = CreateItem("item_moon_shard", unit, unit)
					unit:AddItem(tp_item)
				end
			end

			bots_ids[unit:GetId()] = true
			test_mode:AddPlayer(unit:GetId(), true)
			dota1x6:initiate_player(unit, true)

			HTTP.Request("/get_offered_talents", {
				matchId = HTTP.GetMatchId(),
				matchKey = HTTP.MATCH_KEY,
				heroName = { data.value },
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
				for name, talent in pairs(ingame_talents["general"]) do
					talent_data.value = name
					test_mode:AddTalent(talent_data)
				end
			end
		end
	)
end

function test_mode:TargetDummy(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end
	if test_mode.dummy_pending then
		return
	end

	local player = players[data.PlayerID]

	if not player then
		return
	end

	if test_mode.target_dummy then
		if IsValid(test_mode.target_dummy) then
			UTIL_Remove(test_mode.target_dummy)
		end

		test_mode.target_dummy = nil
		CustomNetTables:SetTableValue("test_mode", "target_dummy", { ent = -1 })
		return
	end

	test_mode.dummy_pending = true

	local point = player:GetAbsOrigin() + player:GetForwardVector() * 300

	PrecacheUnitByNameAsync("npc_dota_hero_target_dummy", function()
		test_mode.dummy_pending = false

		local unit = CreateUnitByName("npc_dota_hero_target_dummy", point, true, nil, nil, DOTA_TEAM_NEUTRALS)

		if not unit then
			return
		end

		test_mode.target_dummy = unit

		unit:SetControllableByPlayer(player:GetPlayerID(), true)
		unit:SetIdleAcquire(false)
		unit:SetAcquisitionRange(0)
		unit:Stop()

		if test then
			local item = CreateItem("item_dagon_5_custom", unit, unit)
			unit:AddItem(item)
		end

		CustomNetTables:SetTableValue("test_mode", "target_dummy", { ent = unit:entindex() })

		test_mode:WatchTargetDummy()
	end)
end

function test_mode:WatchTargetDummy()
	Timers:CreateTimer(1, function()
		local unit = test_mode.target_dummy

		if not unit then
			return
		end

		if not IsValid(unit) or not unit:IsAlive() then
			if IsValid(unit) then
				UTIL_Remove(unit)
			end

			test_mode.target_dummy = nil
			CustomNetTables:SetTableValue("test_mode", "target_dummy", { ent = -1 })
			return
		end

		return 1
	end)
end

function test_mode:LevelBots(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end
	if data.ent == nil then
		return
	end

	local unit = EntIndexToHScript(data.ent)

	local player = players[data.PlayerID]

	if not IsValid(player, unit) then
		return
	end

	for i = 1, data.value do
		unit:HeroLevelUp(true)
	end

	test_mode:MaxSkills(unit)
end

function test_mode:MaxSkills(unit)
	if _G.TestMode == false then
		return
	end

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
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end
	if data.ent == nil then
		return
	end

	local unit = EntIndexToHScript(data.ent)

	local player = players[data.PlayerID]

	if not IsValid(player, unit) then
		return
	end

	test_mode:GiveItem(unit, data.value, data.level)
end

function test_mode:GiveItem(unit, name, level)
	if _G.TestMode == false then
		return
	end

	local kv = GetAbilityKeyValuesByName(name) or {}
	local slot = nil

	if tonumber(kv.ItemIsNeutralPassiveDrop) == 1 then
		slot = DOTA_ITEM_NEUTRAL_PASSIVE_SLOT
	elseif tonumber(kv.ItemIsNeutralActiveDrop) == 1 or tonumber(kv.ItemIsNeutralDrop) == 1 then
		slot = DOTA_ITEM_NEUTRAL_ACTIVE_SLOT
	end

	if not slot and unit:GetNumItemsInInventory() >= 9 then
		return
	end

	if slot then
		local old = unit:GetItemInSlot(slot)

		if old then
			unit:RemoveItem(old)
		end
	end

	local item = CreateItem(name, unit, unit)

	if level and level > 0 then
		item:SetLevel(level)
	end

	unit:AddItem(item)
end

function test_mode:RefreshButton(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end

	test_mode:RefreshAll()
end

function test_mode:RefreshAll()
	if _G.TestMode == false then
		return
	end

	local units = FindUnitsInRadius(
		DOTA_TEAM_GOODGUYS,
		Vector(0, 0, 0),
		nil,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE
			+ DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD
			+ DOTA_UNIT_TARGET_FLAG_DEAD
			+ DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_CLOSEST,
		false
	)

	for _, unit in pairs(units) do
		if unit:IsAlive() then
			unit:SetHealth(unit:GetMaxHealth())
			unit:SetMana(unit:GetMaxMana())
		end

		dota1x6:RefreshCooldowns(unit)
	end
end

function test_mode:StartDuel(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end
	if data.ent == nil then
		return
	end

	local unit = EntIndexToHScript(data.ent)

	local player = players[data.PlayerID]

	if not IsValid(player, unit) then
		return
	end
	if dota1x6:FinalDuel() then
		return
	end

	local team = player:GetTeamNumber()
	local enemy_team = unit:GetTeamNumber()

	if team == enemy_team then
		return
	end
	if not IsValid(towers[team], towers[enemy_team]) then
		return
	end

	local final = data.final == 1 and 1 or 0

	if final == 1 then
		local rest = {}

		for tower_team, tower in pairs(towers) do
			if tower_team ~= team and tower_team ~= enemy_team then
				rest[#rest + 1] = tower
			end
		end

		for _, tower in pairs(rest) do
			dota1x6:destroy_tower(tower, true)
		end
	end

	dota1x6:InitDuel(team, enemy_team, final)

	if final == 0 then
		dota1x6:SetWaveTimer(duel_push_time)
	end
end

function test_mode:StartHunt(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end
	if data.ent == nil then
		return
	end

	local unit = EntIndexToHScript(data.ent)

	local player = players[data.PlayerID]

	if not IsValid(player, unit) then
		return
	end

	local tower = towers[unit:GetTeamNumber()]

	if not IsValid(tower) then
		return
	end

	dota1x6:StartTheHunt(tower)
end

function test_mode:DestroyTower(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end
	if data.ent == nil then
		return
	end

	local unit = EntIndexToHScript(data.ent)

	local player = players[data.PlayerID]

	if not IsValid(player, unit) then
		return
	end

	local tower = towers[unit:GetTeamNumber()]

	if not IsValid(tower) then
		return
	end

	dota1x6:destroy_tower(tower, data.cycle ~= 1)
end

function test_mode:TimeScale(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end
	if data.step == nil then
		return
	end

	local step = data.step > 0 and 1 or -1
	local index = test_mode.time_scale_index + step

	if step < 0 and test_mode.time_scale_index > test_mode.time_scale_default then
		index = test_mode.time_scale_default
	end

	if index < 1 or index > #test_mode.time_scale_steps then
		return
	end

	test_mode.time_scale_index = index

	local value = test_mode.time_scale_steps[index]

	SendToServerConsole("host_timescale " .. value)
	CustomGameEventManager:Send_ServerToAllClients("update_time_scale", { value = tostring(value) })
end

function test_mode:WaveNumber(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end
	if data.step == nil then
		return
	end

	if data.step ~= 0 then
		local wave = math.max(0, dota1x6.current_wave + (data.step > 0 and 1 or -1))
		local bosses = 0

		for _, number in pairs(Wave_boss_number) do
			if number <= wave then
				bosses = bosses + 1
			end
		end

		dota1x6.current_wave = wave
		dota1x6.go_boss_number = bosses
		dota1x6.go_wave = (wave - bosses) % #waves
		timer = 0

		dota1x6:UpdateLaneCreepsStats()
		dota1x6:UpdatePatrolCreepsStats()

		for _, tower in pairs(towers) do
			if IsValid(tower) then
				for i = tower:GetUpgradeStack("modifier_tower_level") + 1, math.min(wave, 24) - 1 do
					tower:AddNewModifier(tower, nil, "modifier_tower_level", {})
				end
			end
		end
	end

	CustomGameEventManager:Send_ServerToAllClients("update_wave_number", { value = dota1x6.current_wave })
end

function test_mode:BountyRunes(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end

	dota1x6:SpawnBountyRunes()
end

function test_mode:OrbShrines(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end

	dota1x6:ActivateOrbShrines(math.max(6, dota1x6.current_wave), true)
end

function test_mode:JungleCreeps(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end

	GameRules:SpawnNeutralCreeps()
end

function test_mode:SpawnPatrol(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end
	if data.type == nil then
		return
	end

	if #dota1x6.patrol_data <= 0 then
		return
	end

	local is_tormentor = data.type == 3
	local force_tier = not is_tormentor and data.type or nil

	local allowed, special_vision = dota1x6:GetPatrolIndexes()

	dota1x6:DestroyPatrol()

	for index, allow in pairs(allowed) do
		if allow then
			dota1x6:spawn_patrol(index, is_tormentor, false, special_vision, force_tier)
		end
	end

	dota1x6:SetPatrolLaunched(true)
end

function test_mode:LaneWave(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end
	if data.ent == nil then
		return
	end
	if data.value == nil then
		return
	end

	local unit = EntIndexToHScript(data.ent)
	local player = players[data.PlayerID]

	if not IsValid(player, unit) then
		return
	end

	local team = unit:GetTeamNumber()
	local wave = wave_types[data.value]

	if not wave then
		return
	end
	if not teleports[team] then
		return
	end
	if not IsValid(towers[team]) then
		return
	end

	local spawner = Entities:FindByName(nil, "spawner_team" .. tonumber(teleports[team]:GetName()))

	if not spawner then
		return
	end

	local is_boss = wave.creeps_type == 2
	local boss_wave = dota1x6.current_wave < Wave_boss_number[2] and 1 or 2
	local allys = {}
	local count = 0

	for _, creep_name in pairs(wave.creeps) do
		dota1x6:CreateUnitCustom(
			creep_name,
			spawner:GetAbsOrigin() + RandomVector(125),
			true,
			nil,
			nil,
			DOTA_TEAM_CUSTOM_5,
			function(creep)
				count = count + 1

				creep.host_team = team
				creep.number = count
				creep.mkb = wave.mkb
				creep.is_test_creep = true

				allys[count] = creep

				if not DontUpgradeCreeps then
					if is_boss then
						creep:AddNewModifier(creep, nil, "modifier_waveupgrade_boss", { wave = boss_wave })
					else
						dota1x6:SetLaneCreepsStats(creep)
					end
				end

				if count < #wave.creeps then
					return
				end

				for _, ally in pairs(allys) do
					ally.ally = allys
				end
			end
		)
	end
end

function test_mode:Vision(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end

	test_mode.all_vision = not test_mode.all_vision

	SendToServerConsole("dota_all_vision " .. (test_mode.all_vision and 1 or 0))

	CustomGameEventManager:Send_ServerToAllClients("update_vision", { state = test_mode.all_vision })
end

function test_mode:HudButton(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end

	test_mode.hud_hidden = not test_mode.hud_hidden

	CustomGameEventManager:Send_ServerToAllClients("update_hud_hidden", { state = test_mode.hud_hidden })
end

function test_mode:ParticleLog(data)
	if _G.TestMode == false then
		return
	end
	if data.PlayerID == nil then
		return
	end

	test_mode.particle_log = not test_mode.particle_log

	SendToServerConsole("cl_particle_log_creates " .. (test_mode.particle_log and 1 or 0))

	CustomGameEventManager:Send_ServerToAllClients("update_particle_log", { state = test_mode.particle_log })
end