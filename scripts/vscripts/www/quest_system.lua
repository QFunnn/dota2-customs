--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


if quest_system == nil then
	_G.quest_system = class({})
end

_G.players_quest_progress = {
	["main"] = {},
	["additional"] = {},
}

_G.quest_data = {
	["main"] = {
		[1] = {
			name = "quest1",
			description = "quest1_des",
			target = { "npc_dota_zone_1_unit_quest" },
			goal = 11,
			type = "kill",
			rewards = { gold = 150, exp = 25 },
			relay = "relay_zone_1",
			autonext = true,
			uninvulnerable = "npc_dota_boss_ursa",
		}, --goal = 11
		[2] = {
			name = "quest2",
			description = "quest2_des",
			target = { "npc_dota_boss_ursa" },
			goal = 1,
			type = "boss",
			rewards = { gold = 300, exp = 50 },
			additional = 101,
			autoadditional = 101,
		},
		[3] = {
			name = "quest3",
			description = "quest3_des",
			target = { "npc_dota_zone_2_unit_2", "npc_dota_zone_2_unit_3" },
			goal = 150,
			type = "kill",
			rewards = { gold = 100, exp = 75 },
			relay = "relay_zone_2",
			autonext = true,
			autoadditional = 109,
			uninvulnerable = "npc_dota_boss_undying",
		}, --goal = 150
		[4] = {
			name = "quest4",
			description = "quest4_des",
			target = { "npc_dota_boss_undying" },
			goal = 1,
			type = "boss",
			rewards = { gold = 300, exp = 150 },
			additional = 102,
		},
		[5] = {
			name = "quest5",
			description = "quest5_des",
			target = "",
			goal = 3,
			type = "collect",
			rewards = { gold = 150, exp = 50 },
			autonext = true,
			relay = "lich_gate_relay",
			uninvulnerable = "npc_dota_boss_lich",
		}, --goal = 3,
		[6] = {
			name = "quest6",
			description = "quest6_des",
			target = { "npc_dota_boss_lich" },
			goal = 1,
			type = "boss",
			rewards = { gold = 400, exp = 100 },
			additional = 104,
		},
		[7] = {
			name = "quest7",
			description = "quest7_des",
			target = { "item_prison_cell_key" },
			goal = 1,
			type = "find",
			rewards = { gold = 200, exp = 25 },
			autonext = true,
			uninvulnerable = "npc_dota_boss_tiny",
			autoadditional = 105,
		},
		[8] = {
			name = "quest8",
			description = "quest8_des",
			target = { "npc_dota_boss_tiny" },
			goal = 1,
			type = "boss",
			rewards = { gold = 400, exp = 50 },
		},
		[9] = {
			name = "quest9",
			description = "quest9_des",
			target = { "npc_dota_boss_nyx_1", "npc_dota_boss_nyx_2" },
			goal = 2,
			type = "kill",
			rewards = { gold = 400, exp = 75 },
			autonext = true,
			additional = 106,
			autoadditional = 106,
			autotarget = true,
		},
		[10] = {
			name = "quest10",
			description = "quest10_des",
			target = { "item_naga_stone" },
			goal = 1,
			type = "bring",
			rewards = { gold = 100, exp = 75 },
			autonext = true,
			relay = "relay_naga",
			uninvulnerable = "npc_dota_boss_slardar",
		},
		[11] = {
			name = "quest11",
			description = "quest11_des",
			target = { "npc_dota_boss_slardar" },
			goal = 1,
			type = "boss",
			rewards = { gold = 400, exp = 100 },
			additional = 110,
		},
		[12] = {
			name = "quest12",
			description = "quest12_des",
			target = { "npc_dust_quest" },
			goal = 7,
			type = "kill",
			rewards = { gold = 200, exp = 50 },
			relay = "bristleback_relay",
			autonext = true,
			uninvulnerable = "npc_dota_boss_bristleback",
		},
		[13] = {
			name = "quest13",
			description = "quest13_des",
			target = { "npc_dota_boss_bristleback" },
			goal = 1,
			type = "boss",
			rewards = { gold = 400, exp = 50 },
		},
		[14] = {
			name = "quest14",
			description = "quest14_des",
			target = { "npc_dota_zone_8_unit_1" },
			goal = 3,
			type = "boss",
			time = 900,
			rewards = { gold = 150, exp = 150 },
			additional = 108,
			autonext = true,
			autoadditional = 108,
			uninvulnerable = "npc_dota_boss_furion",
		},
		[15] = {
			name = "quest15",
			description = "quest15_des",
			target = { "npc_dota_boss_furion" },
			goal = 1,
			type = "boss",
			rewards = { gold = 500, exp = 50 },
		},
		[16] = {
			name = "quest16",
			description = "quest16_des",
			target = "",
			goal = 4,
			type = "collect",
			rewards = { gold = 200, exp = 75 },
			autonext = true,
			uninvulnerable = "npc_dota_boss_doom",
		},
		[17] = {
			name = "quest17",
			description = "quest17_des",
			target = { "npc_dota_boss_doom" },
			goal = 1,
			type = "boss",
			rewards = { gold = 600, exp = 100 },
		},
		[18] = {
			name = "quest18",
			description = "quest18_des",
			target = { "npc_obelisk" },
			goal = 5,
			type = "kill",
			rewards = { gold = 150, exp = 100 },
			relay = "kill_obelisk",
			autonext = true,
			uninvulnerable = "npc_dota_boss_medusa",
		},
		[19] = {
			name = "quest19",
			description = "quest19_des",
			target = { "npc_dota_boss_medusa" },
			goal = 1,
			type = "boss",
			rewards = { gold = 700, exp = 100 },
		},
		[20] = {
			name = "quest20",
			description = "quest20_des",
			target = {
				"npc_dota_zone_11_unit_2",
				"npc_dota_zone_11_unit_1",
				"npc_dota_zone_11_unit_3",
				"npc_dota_zone_11_unit_4",
				"npc_dota_zone_11_unit_5",
			},
			goal = 104,
			type = "kill",
			rewards = { gold = 100, exp = 25 },
			relay = "arc_logic",
			autonext = true,
			uninvulnerable = "npc_dota_boss_arc_warden",
		},
		[21] = {
			name = "quest21",
			description = "quest21_des",
			target = { "npc_dota_boss_arc_warden" },
			goal = 1,
			type = "boss",
			rewards = { gold = 800, exp = 75 },
			autonext = true,
		},
		[22] = {
			name = "quest22",
			description = "quest22_des",
			target = { "" },
			goal = 2,
			type = "collect",
			rewards = { gold = 50, exp = 25 },
			relay = "last_gate_relay",
		},
		[23] = {
			name = "quest23",
			description = "quest23_des",
			target = { "" },
			goal = 6,
			type = "collect",
			rewards = { gold = 250, exp = 75 },
			relay = "creep_kill_final",
		},
	},

	["additional"] = {
		[101] = {
			name = "add_quest1",
			description = "add_quest1_des",
			target = { "npc_dota_boss_minion_ursa" },
			goal = 3,
			type = "kill",
			rewards = { gold = 100, exp = 25 },
		},
		[102] = {
			name = "add_quest2",
			description = "add_quest2_des",
			target = {
				"item_mekansm",
				"item_vladmir_lua1",
				"item_up_stone",
				"item_pers",
				"item_demon_edge",
				"item_ultimate_orb",
			},
			goal = 1,
			type = "bring",
			rewards = { gold = 100, exp = 25 },
		},
		[103] = {
			name = "add_quest3",
			description = "add_quest3_des",
			target = "",
			goal = 1,
			type = "pass",
			rewards = { gold = 100, exp = 50 },
		},
		[104] = {
			name = "add_quest4",
			description = "add_quest4_des",
			target = { "item_cheese_lua" },
			condition = 102,
			goal = 1,
			type = "bring",
			rewards = { gold = 150, exp = 25 },
		},
		[105] = {
			name = "add_quest5",
			description = "add_quest5_des",
			target = "",
			goal = 300,
			type = "pass",
			time = 300,
			rewards = { gold = 50, exp = 150 },
		},
		[106] = {
			name = "add_quest6",
			description = "add_quest6_des",
			target = "",
			goal = 1,
			type = "find",
			rewards = { gold = 50, exp = 50 },
		},
		[107] = {
			name = "add_quest7",
			description = "add_quest7_des",
			target = { "item_shovel" },
			goal = 1,
			type = "find",
			rewards = { gold = 50, exp = 50 },
		},
		[108] = {
			name = "add_quest8",
			description = "add_quest8_des",
			target = { "item_ward_sentry" },
			goal = 8,
			type = "collect",
			rewards = { gold = 200, exp = 50 },
		},

		[109] = {
			name = "add_quest9",
			description = "add_quest9_des",
			target = "",
			goal = 3,
			type = "collect",
			rewards = { gold = 50, exp = 50 },
			relay = "hidden_room_logic",
			manual_next = { priority = "additional", num = 111 },
		},
		[110] = {
			name = "add_quest10",
			description = "add_quest10_des",
			target = { "item_orb" },
			condition = 104,
			goal = 1,
			type = "bring",
			rewards = { gold = 50, exp = 125 },
			relay = "mini_2_log",
			manual_next = { priority = "additional", num = 113 },
		},

		[111] = {
			name = "add_quest11",
			description = "add_quest11_des",
			target = { "" },
			goal = 1,
			type = "find",
			rewards = { gold = 50, exp = 50 },
			manual_next = { priority = "additional", num = 114 },
		},
		[112] = {
			name = "add_quest12",
			description = "add_quest12_des",
			target = { "npc_hidden_earth_boss" },
			goal = 1,
			type = "boss",
			rewards = { gold = 350, exp = 50 },
		},
		[113] = {
			name = "add_quest13",
			description = "add_quest13_des",
			target = { "npc_hidden_snow_boss" },
			goal = 1,
			type = "boss",
			rewards = { gold = 350, exp = 50 },
		},

		[114] = {
			name = "add_quest14",
			description = "add_quest14_des",
			target = { "" },
			goal = 1,
			type = "find",
			rewards = { gold = 250, exp = 25 },
			relay = "xdes_move_logic",
		},
	},
}

function quest_system:init()
	print("init quest system")
	ListenToGameEvent("entity_killed", Dynamic_Wrap(self, "OnEntityKilled"), self)
	ListenToGameEvent("dota_item_picked_up", Dynamic_Wrap(self, "On_dota_item_picked_up"), self)

	CustomGameEventManager:RegisterListener("RequestQuests", Dynamic_Wrap(quest_system, "RequestQuests"))
end

function quest_system:RequestQuests(data)
	local pid = data.PlayerID

	local data = {}

	for priority, quests in pairs(_G.players_quest_progress) do
		for num, questData in pairs(quests) do
			if questData.completed == false then
				local quest = _G.quest_data[priority][num]

				table.insert(data, {
					name = quest.name,
					description = quest.description,
					target = questData.target or "",
					goal = quest.goal,
					type = quest.type,
					id = num,
					priority = priority,
					rewards = quest.rewards,
					expireAt = quest.time and (GameRules:GetGameTime() + quest.time - questData.time) or nil,
					current = questData.kill_count,
				})
			end
		end
	end

	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(pid), "RequestQuests", { data = data })
end

function quest_system:OnEntityKilled(dat)
	local killed_unit = EntIndexToHScript(dat.entindex_killed)
	local killed_unit_name = killed_unit:GetUnitName()

	for priority, quests in pairs(_G.players_quest_progress) do
		for num, data in pairs(quests) do
			local currentQuest = _G.quest_data[priority][num]
			if
				data.completed == false
				and currentQuest
				and (currentQuest.type == "kill" or currentQuest.type == "boss")
			then
				if table.contains(currentQuest.target, killed_unit_name) then
					if
						currentQuest.additional
						and _G.players_quest_progress["additional"][currentQuest.additional]
						and not _G.players_quest_progress["additional"][currentQuest.additional].completed
					then
						_G.players_quest_progress["additional"][currentQuest.additional].completed = true
						quest_system:RemoveQuest("additional", currentQuest.additional, "fail")
					end

					data.kill_count = (data.kill_count or 0) + 1
					quest_system:UpdateQuest(priority, num, data.kill_count)

					if data.kill_count >= currentQuest.goal then
						data.completed = true
						quest_system:RemoveQuest(priority, num, "success")
					end
					break
				end
			end
		end
	end
end

function quest_system:TimeThink()
	local quest103 = _G.players_quest_progress["additional"][103]
	if quest103 and not quest103.completed then
		for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
			local hero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
			if hero and hero:GetTeam() == DOTA_TEAM_GOODGUYS and hero:GetHealthPercent() < 100 then
				quest103.completed = true
				quest_system:RemoveQuest("additional", 103, "fail")
				break
			end
		end
	end

	local quest105 = _G.players_quest_progress["additional"][105]
	if quest105 and not quest105.completed then
		quest105.time = (quest105.time or 0) + 1
		quest_system:UpdateQuest("additional", 105, quest105.time)
		if quest105.time >= _G.quest_data["additional"][105].time then
			quest105.completed = true
			quest_system:RemoveQuest("additional", 105, "fail")
		end
	end

	local quest14 = _G.players_quest_progress["main"][14]
	if quest14 and not quest14.completed then
		quest14.time = (quest14.time or 0) + 1
		quest_system:UpdateQuest("main", 14, quest14.kill_count)
		if quest14.time >= _G.quest_data["main"][14].time then
			quest14.completed = true
			quest_system:RemoveQuest("main", 14, "fail")
			PlayersSummary:SyncPlayersSummaryWithClient("#lose_reason_quest14_timeout")
			GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
			for playerID = 0, 4 do
				GuildsQuestsCollector.Record({
					playerId = playerID,
					key = "game_over",
					value = 1,
				})
			end
			GuildsQuestsCollector.Send()
		end
	end
end

function quest_system:On_dota_item_picked_up(keys)
	if keys.itemname == "item_prison_cell_key" then
		local quest7 = _G.players_quest_progress["main"][7]
		if quest7 and not quest7.completed then
			quest7.completed = true
			quest_system:RemoveQuest("main", 7, "success")

			local quest105 = _G.players_quest_progress["additional"][105]
			if quest105 and not quest105.completed then
				quest105.completed = true
				quest_system:RemoveQuest("additional", 105, "success")
			end
		end
		UTIL_Remove(keys)
	end

	if keys.itemname == "item_shovel" then
		local quest107 = _G.players_quest_progress["additional"][107]
		if quest107 and not quest107.completed then
			quest107.completed = true
			quest_system:RemoveQuest("additional", 107, "success")
		end
	end
end

---------------------------------------------------------------------------------------

function quest_system:StartQuest(priority, num, target)
	local data = _G.quest_data[priority][num]

	if not _G.players_quest_progress[priority][num] then
		_G.players_quest_progress[priority][num] =
			{ completed = false, kill_count = 0, target = target or "", time = 0, condition = condition or nil }
	end

	if _G.quest_data[priority][num].autoadditional then
		quest_system:StartQuest("additional", _G.quest_data[priority][num].autoadditional)
	end

	CustomGameEventManager:Send_ServerToAllClients("quest_system_start_quest", {
		name = data.name,
		description = data.description,
		target = target or "",
		goal = data.goal,
		type = data.type,
		id = num,
		priority = priority,
		rewards = data.rewards,
		expireAt = data.time and (GameRules:GetGameTime() + data.time) or nil,
	})
end

function quest_system:UpdateQuest(priority, num, current)
	local data = _G.quest_data[priority][num]
	CustomGameEventManager:Send_ServerToAllClients(
		"quest_system_update",
		{ current = current, goal = data.goal, id = num, type = data.type }
	)
end

function quest_system:RemoveQuest(priority, num, status)
	if status == "success" then
		if _G.quest_data[priority][num].relay then
			local hRelay = Entities:FindByName(nil, _G.quest_data[priority][num].relay)
			hRelay:Trigger(nil, nil)
		end

		if _G.quest_data[priority][num].autonext then
			local target = ""
			if _G.quest_data[priority][num].autotarget then
				target = _G.quest_data[priority][num + 1].target[1]
			end
			quest_system:StartQuest(priority, num + 1, target)
		end

		if _G.quest_data[priority][num].manual_next then
			quest_system:StartQuest(
				_G.quest_data[priority][num].manual_next.priority,
				_G.quest_data[priority][num].manual_next.num
			)
		end

		if _G.quest_data[priority][num].uninvulnerable then
			rules:boss_invulnerable(_G.quest_data[priority][num].uninvulnerable)
		end

		EmitGlobalSound("Tutorial.Quest.complete_01")
		local data = _G.quest_data[priority][num]
		for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
			if
				PlayerResource:GetTeam(nPlayerID) == DOTA_TEAM_GOODGUYS and PlayerResource:HasSelectedHero(nPlayerID)
			then
				local hero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
				hero:ModifyGold(data.rewards.gold, true, 0)
				hero:AddExperience(data.rewards.exp, DOTA_ModifyXP_Unspecified, false, false)
				SendOverheadEventMessage(hero, OVERHEAD_ALERT_GOLD, hero, data.rewards.gold, nil)
			end
		end
	else
		EmitGlobalSound("Conquest.capture_point_timer.Generic")
	end
	CustomGameEventManager:Send_ServerToAllClients(
		"quest_system_remove",
		{ description = _G.quest_data[priority][num].description, num = num, status = status }
	)
end

function quest_system:QuestIsCompleted(priority, num)
	local questsProgress = _G.players_quest_progress

	if not questsProgress[priority] then
		return false
	end

	if not questsProgress[priority][num] then
		return false
	end

	return not not questsProgress[priority][num].completed
end

function quest_system:quest_23()
	local quest_23 = _G.players_quest_progress["main"][23]
	if quest_23 and not quest_23.completed then
		quest_23.kill_count = (quest_23.kill_count or 0) + 1
		quest_system:UpdateQuest("main", 23, quest_23.kill_count)
		if quest_23.kill_count >= _G.quest_data["main"][23].goal then
			quest_23.completed = true
			quest_system:RemoveQuest("main", 23, "success")
		end
	end
end

------------------------------------------------------- GOLDEN QUEST -----------------------------------------------------------------

zone = 0

golden_zone_spawn_time = {
	["zone_1"] = 0,
	["zone_2"] = 0,
	["zone_3"] = 0,
	["zone_4"] = 0,
	["zone_5"] = 0,
	["zone_6"] = 0,
}

function spawn_creep_in_zone(zone_name)
	local random_time = RandomInt(480, 660)
	Timers:CreateTimer(300, function()
		if golden_zone_spawn_time[zone_name] == 0 then
			golden_zone_spawn_time[zone_name] = math.ceil(GameRules:GetGameTime())
		end
		golden_creep_spawn(zone_name)
		return random_time
	end)
end

function quest_system:invasion()
	zone = zone + 1
	local zone_name = "zone_" .. zone
	if zone >= 1 and zone <= 6 then
		spawn_creep_in_zone(zone_name)
	end
end

function add_item(unit)
	local items_pool = {
		"item_desolator_lua1",
		"item_skadi_lua1",
		"item_mjollnir_lua1",
		"item_heart_lua1",
		"item_monkey_king_bar_lua1",
		"item_shivas_guard_lua1",
		"item_dagon_lua_1",
		"item_octarine_core_lua1",
		"item_crimson_guard_lua1",
		"item_pipe_lua1",
		"item_veil_of_discord_lua1",
		"item_greater_crit_lua1",
	}
	local items = {}
	while #items < 6 do
		local item, _ = table.random(items_pool)
		if not table.has_value(items, item) then
			table.insert(items, item)
		end
	end
	for _, item in pairs(items) do
		unit:AddItemByName(item)
	end
end

function golden_creep_spawn(zone_name)
	local spawn_points = {
		["zone_1"] = { "1_golden_1", "1_golden_2", "1_golden_3" },
		["zone_2"] = { "2_golden_1", "2_golden_2", "2_golden_3" },
		["zone_3"] = { "3_golden_1", "3_golden_2", "3_golden_3" },
		["zone_4"] = { "4_golden_1", "4_golden_2", "4_golden_3" },
		["zone_5"] = { "5_golden_1", "5_golden_2", "5_golden_3" },
		["zone_6"] = { "6_golden_1", "6_golden_2", "6_golden_3" },
	}

	local golden_creeps = { "GoldenMiner", "GoldenQueen", "GoldenWyvern", "GoldenSea", "GoldenDragon", "GoldenForest" }
	local zone_points = spawn_points[zone_name]
	local point_name = zone_points[math.random(#zone_points)]
	local creep = golden_creeps[math.random(#golden_creeps)]

	Notifications:TopToAll({ text = "#golden_" .. zone_name, text2 = "#" .. creep, duration = 3 })

	local point = Entities:FindByName(nil, point_name):GetAbsOrigin()
	local unit = CreateUnitByName(creep, point, true, nil, nil, DOTA_TEAM_NEUTRALS)
	random_ability = passive[RandomInt(1, #passive)]
	unit:AddNewModifier(unit, nil, "modifier_golden_unit", {})
		:SetStackCount(math.ceil(GameRules:GetGameTime() - golden_zone_spawn_time[zone_name]))
	rules:aura_dif(unit, random_ability)
	add_item(unit)

	Timers:CreateTimer({
		endTime = 290,
		callback = function()
			golden_end(unit)
		end,
	})
end

LinkLuaModifier("modifier_teleport_event", "modifiers/modifier_teleport_event", LUA_MODIFIER_MOTION_NONE)

function golden_end(unit)
	unit:AddNewModifier(unit, nil, "modifier_teleport_event", {})
	unit:EmitSound("Portal.Loop_Appear")
	Timers:CreateTimer(3, function()
		unit:StopSound("Portal.Loop_Appear")
		unit:RemoveModifierByName("modifier_teleport_event")
		PlayerResource:SetCameraTarget(unit:GetPlayerOwnerID(), unit)
		UTIL_Remove(unit)
	end)
end

quest_system:init()