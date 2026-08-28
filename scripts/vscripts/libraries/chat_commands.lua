--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


ChatCommands = ChatCommands or class({})

function ChatCommands:Init()
	RegisterGameEventListener("player_chat", function(event)
		ChatCommands:OnPlayerChat(event)
	end)
end

function ChatCommands:OnPlayerChat(event)
	event.player = PlayerResource:GetPlayer(event.playerid)
	if not event.player then
		return
	end

	event.hero = event.player:GetAssignedHero()
	if not event.hero then
		return
	end

	event.player_id = event.hero:GetPlayerID()

	local command_source = string.trim(string.lower(event.text))
	if command_source:sub(0, 1) ~= "-" then
		return
	end
	-- removing `-`
	command_source = command_source:sub(2)

	local arguments = string.split(command_source)
	local command_name = table.remove(arguments, 1)

	if ChatCommands[command_name] then
		ErrorTracking.Try(ChatCommands[command_name], ChatCommands, arguments, event)
	end

	ErrorTracking.Try(ChatCommands.GeneralProcessing, ChatCommands, command_name, arguments, event)
end

ChatCommands:Init()

-- Chat commands that rely on knowing command name go here
function ChatCommands:GeneralProcessing(command_name, arguments, event)
	if not command_name then
		return
	end
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then
		return
	end

	if string.find(command_name, "item_") == 1 then
		local new_item = event.hero:AddItemByName(command_name)
		if not new_item then
			return
		end
		new_item:SetSellable(true)
	end
end

function ChatCommands:pause(arguments, event)
	if (GameMode.is_solo_pve_game or GameMode:IsDeveloper(event.player_id)) and event.hero then
		PauseGame(not GameRules:IsGamePaused())
	end
end

function ChatCommands:events(arguments, event)
	-- for event_name, callbacks in pairs(EventDriver.serverside_events) do
	-- 	print(event_name, "=", #callbacks)
	-- 	for i = 1, #callbacks do
	-- 		if callbacks[i][1] then
	-- 			local callback_info = debug.getinfo(callbacks[i][1])
	-- 			local traceback_line = callback_info.short_src .. ":" .. callback_info.linedefined
	-- 			print("|\t", traceback_line)
	-- 		end
	-- 	end
	-- 	print("------------------")
	-- end
end

function ChatCommands:help(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then
		return
	end

	local help_list = {}

	for name, description in pairs(help_list) do
		print(name, description)
	end
end

function ChatCommands:lm(arguments, event)
	print("\nModifiers on ", event.hero:GetUnitName())
	print(string.rep("-", 81) .. "|")
	print(string.format("| %-50s | %-10s | %-12s |", "[Name]", "[Elapsed]", "[Remaining]"))
	print(string.rep("-", 81) .. "|")
	for _, modifier in pairs(event.hero:FindAllModifiers()) do
		print(
			string.format(
				"- %-50s | %-10.1f | %-12.1f |",
				modifier:GetName() .. " [" .. modifier:GetStackCount() .. "]",
				modifier:GetElapsedTime(),
				modifier:GetRemainingTime()
			)
		)
	end
	print(string.rep("-", 81) .. "|", "\n")
end

function ChatCommands:allup(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then
		return
	end
	if not arguments[1] then
		return
	end

	local arg = tonumber(arguments[1])

	for player_id = 0, (DOTA_MAX_TEAM_PLAYERS - 1) do
		if PlayerResource:IsValidPlayer(player_id) then
			local hero = PlayerResource:GetSelectedHeroEntity(player_id)
			if hero then
				hero:AddExperience(arg, 0, true, true)
			end
		end
	end
end

function ChatCommands:position(arguments, event)
	print("[DEBUG] position:", event.hero:GetAbsOrigin())
end

function ChatCommands:rr(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then
		return
	end

	SendToServerConsole("script_reload")
end

function ChatCommands:timescale(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then
		return
	end
	if not arguments[1] then
		return
	end

	local value = tonumber(arguments[1])
	if value < 0.1 then
		value = 0.1
	end -- if arg <= 0, server freezes
	Convars:SetFloat("host_timescale", value)
end

function ChatCommands:li(arguments, event)
	local items = {}

	local hero = event.hero

	for index = DOTA_ITEM_SLOT_1, DOTA_ITEM_TRANSIENT_CAST_ITEM do
		local item = hero:GetItemInSlot(index)
		if item and not item:IsNull() then
			items[index + 1] = item:GetAbilityName()
		else
			items[index + 1] = ""
		end
	end

	DeepPrintTable(items)
end

function ChatCommands:endgame(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then
		return
	end

	local your_team = event.hero:GetTeam()
	for _, team in pairs(GameMode:GetAllAliveTeams()) do
		if team ~= your_team then
			GameMode:TeamLose(team)
		end
	end
	GameMode:TeamLose(your_team)
	return
end

function ChatCommands:couriers(arguments, event)
	local couriers = Entities:FindAllByClassname("npc_dota_courier")
	local couriers_2 = Entities:FindAllByName("npc_dota_courier")
	print("[ChatCommands] scanning couriers: ", #couriers, #couriers_2)
end

function ChatCommands:setgamewinner(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then
		return
	end
	local team = tonumber(arguments[1])
	if not team then
		DebugMessage("setgamewinner failed - no team supplied!")
		return
	end
	GameLoop:SetGameWinner(team)
end

function ChatCommands:entindex(arguments, event)
	print(event.hero:entindex(), event.hero:GetPlayerOwnerID())
end

function ChatCommands:purchase_item(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	WebInventory:PurchaseItem(event.player_id, arguments[1], tonumber(arguments[2] or 0), tonumber(arguments[3] or 1))
end

function ChatCommands:equip(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	WebInventory:EquipEvent({
		PlayerID = event.player_id,
		item_name = arguments[1],
	})
end

function ChatCommands:unequip(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	WebInventory:UnequipEvent({
		PlayerID = event.player_id,
		item_name = arguments[1],
	})
end

function ChatCommands:use_item(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	WebInventory:ItemConsumeEvent({
		PlayerID = event.player_id,
		item_name = arguments[1],
		used_count = tonumber(arguments[2] or 1),
	})
end

function ChatCommands:redeem_gift_code(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	GiftCodes:RedeemGiftCode({
		PlayerID = event.player_id,
		gift_code = arguments[1],
	})
end

function ChatCommands:roll_test(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	local count = tonumber(arguments[2]) or 1000

	local rolled = {}

	for i = 0, count do
		local outcome = WebTreasure:RollTreasureItem(
			event.player_id,
			WebInventory.treasure_pools[arguments[1] or "sprays_treasure_1"]
		)

		if not rolled[outcome] then
			rolled[outcome] = 1
		else
			rolled[outcome] = rolled[outcome] + 1
		end
	end

	print(count .. " rolls result: ")
	DeepPrintTable(rolled)
end

function ChatCommands:double_orbs(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then
		return
	end

	GameMode.do_double_orb_drops = not GameMode.do_double_orb_drops
end

function ChatCommands:gpl(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	print("Punishment level:", WebPlayer:GetPunishmentLevel(event.player_id))
end

function ChatCommands:spl(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	WebPlayer:SetPunishmentLevel(event.player_id, tonumber(arguments[1] or 0), arguments[2] or "chat command", true)
end

local function defer_player_id(hero_name)
	if not string.starts(hero_name, "npc_dota_hero_") then
		hero_name = "npc_dota_hero_" .. hero_name
	end

	for _player_id, hero in pairs(GameLoop.hero_by_player_id or {}) do
		if hero:GetUnitName() == hero_name then
			return _player_id
		end
	end

	return nil
end

function ChatCommands:punish(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end
	if not arguments[1] then
		return
	end

	local target_player_id = defer_player_id(arguments[1])

	if not target_player_id then
		return
	end

	local hero = PlayerResource:GetPlayer(target_player_id):GetAssignedHero()
	if IsValidEntity(hero) then
		hero:AddNewModifier(hero, nil, "modifier_severe_punishment", { duration = -1 })
	end

	GameRules:SendCustomMessage("#chat_command_player_punished", target_player_id, 1)

	WebPlayer:SetPunishmentLevel(target_player_id, tonumber(arguments[2] or 1000), arguments[3] or "chat command", true)
end

function ChatCommands:unpunish(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end
	if not arguments[1] then
		return
	end

	local target_player_id = defer_player_id(arguments[1])

	if not target_player_id then
		return
	end

	local hero = PlayerResource:GetPlayer(target_player_id):GetAssignedHero()
	if IsValidEntity(hero) then
		hero:RemoveModifierByName("modifier_severe_punishment")
	end

	GameRules:SendCustomMessage("#chat_command_player_punishment_lifted", target_player_id, 1)

	WebPlayer:SetPunishmentLevel(target_player_id, 0, "chat command", true)
end

function ChatCommands:map_stats(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	WebPlayerStats:GetMapStatsEvent({
		PlayerID = event.player_id,
		map_name = arguments[1],
	})
end

function ChatCommands:match_data(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	WebPlayerStats:GetMatchDataEvent({
		PlayerID = event.player_id,
		match_id = tonumber(arguments[1]),
	})
end

function ChatCommands:abilities(arguments, event)
	DebugMessage("Abilities of", event.hero:GetUnitName())
	DebugMessage(string.rep("-", 68) .. "|")
	for i = 0, 30 do
		local ability = event.hero:GetAbilityByIndex(i)
		if IsValidEntity(ability) then
			DebugMessage(
				string.format("%-3d - %-50s [Index: %-3d]", i, ability:GetAbilityName(), ability:GetAbilityIndex())
			)
		end
	end
	DebugMessage(string.rep("-", 68) .. "|")
end

function ChatCommands:banall(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	for player_id, hero in pairs(GameLoop.hero_by_player_id) do
		if not GameMode:IsDeveloper(player_id) and IsValidEntity(hero) then
			hero:AddNewModifier(hero, nil, "modifier_severe_punishment", { duration = -1 })
		end
	end
end

function ChatCommands:unbanall(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	for player_id, hero in pairs(GameLoop.hero_by_player_id) do
		if IsValidEntity(hero) then
			hero:RemoveModifierByName("modifier_severe_punishment")
		end
	end
end

function ChatCommands:set_global_perk(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end
	local perk_name = arguments[1]

	for player_id, hero in pairs(GameLoop.hero_by_player_id) do
		if IsValidEntity(hero) then
			GamePerks:RemovePerk(player_id, hero)
			GamePerks:SetGamePerk({
				PlayerID = player_id,
				perk_name = perk_name,
				resetter = true,
				external = true,
			})
		end
	end
end

function ChatCommands:see_perks(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	for player_id, hero in pairs(GameLoop.hero_by_player_id) do
		if IsValidEntity(hero) then
			DebugMessage(
				"Player",
				player_id,
				hero:GetUnitName(),
				"perk is",
				GamePerks.chosen_perks[player_id] or "<none>"
			)
		end
	end
end

function ChatCommands:clear_filters(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	local game_mode_entity = GameRules:GetGameModeEntity()
	game_mode_entity:ClearBountyRunePickupFilter()
	game_mode_entity:ClearDamageFilter()
	game_mode_entity:ClearExecuteOrderFilter()
	game_mode_entity:ClearHealingFilter()
	game_mode_entity:ClearItemAddedToInventoryFilter()
	game_mode_entity:ClearModifierGainedFilter()
	game_mode_entity:ClearModifyExperienceFilter()
	game_mode_entity:ClearModifyGoldFilter()
	game_mode_entity:ClearRuneSpawnFilter()
	game_mode_entity:ClearTrackingProjectileFilter()
end

function ChatCommands:gpm(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	CUSTOM_GPM_GOLD_PER_TICK = tonumber(arguments[1]) or 0
end

function ChatCommands:gpm_kill(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	Timers:RemoveTimer(GameLoop.custom_gpm)
end
function ChatCommands:boost(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then
		return
	end

	local hero = PlayerResource:GetSelectedHeroEntity(event.player_id)
	hero:AddExperience(1000000, DOTA_ModifyXP_TomeOfKnowledge, false, true)
	hero:SetBaseStrength(100000)
	hero:SetBaseAgility(100000)
	hero:SetBaseIntellect(100000)
	hero:SetBaseMoveSpeed(19885)
	hero:AddItemByName("item_force_boots")
	hero:CalculateStatBonus(true)
end

function ChatCommands:af(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	print("===========================")
	DebugMessage("[AntiFeed] points for player " .. event.player_id .. " > ", AntiFeed.points[event.player_id] or -1)
	print("AntiFeed.points")
	DeepPrintTable(AntiFeed.points)
	print("AntiFeed.time_factor")
	DeepPrintTable(AntiFeed.time_factor)
	print("AntiFeed.time_after_respawn")
	DeepPrintTable(AntiFeed.time_after_respawn)
	print("===========================")
end

function ChatCommands:c_gold(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	event.hero:ModifyGold(tonumber(arguments[1] or 1), true, 0)
end

function ChatCommands:frame(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	DebugMessage("Server frame time: ", GameRules:GetGameFrameTime())
	DebugMessage(
		"Current Time Dilation:",
		((GetSystemTimeMS() - GameLoop.game_start_time) / 1000.0) / GameRules:GetDOTATime(false, true)
	)
end

function ChatCommands:gold_bench(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	local time = GetSystemTimeMS()

	for i = 0, 24 do
		if IsValidPlayerID(i) then
			PlayerResource:ModifyGold(i, 10, true, DOTA_ModifyGold_AbandonedRedistribute)
		end
	end

	local elapsed = GetSystemTimeMS() - time

	DebugMessage("Gold Distribution took: ", elapsed, "ms")
end

function ChatCommands:stagger_gold(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end
	GameLoop.do_stagger_gold = not GameLoop.do_stagger_gold
end

function ChatCommands:abs(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	local hero = PlayerResource:GetSelectedHeroEntity(event.player_id)
	Timers:CreateTimer(0.04, function()
		CustomChat:MessageToPlayer(event.player_id, event.player_id, hero:GetAbsOrigin())
	end)
end

function ChatCommands:base_model(arguments, event)
	local base_model = event.hero:GetRootMoveParent()
	if not base_model or not base_model.GetModelName or not base_model.GetMaterialGroupHash then
		return
	end

	DebugMessage("hero model: ", base_model:GetModelName(), base_model:GetMaterialGroupHash())
end

-- Make the server run at full tilt until arg[1] seconds have elapsed
function ChatCommands:warp(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then
		return
	end
	if not arguments[1] then
		return
	end

	local duration = tonumber(arguments[1])

	if not duration then
		return
	end

	local current_timescale = Convars:GetFloat("host_timescale") -- probably breaks if you warp twice at once, too bad!

	Convars:SetFloat("host_force_frametime_to_equal_tick_interval", 1)
	Convars:SetFloat("host_timescale", 100)

	Timers:CreateTimer(duration, function()
		Convars:SetInt("host_force_frametime_to_equal_tick_interval", 0)
		Convars:SetFloat("host_timescale", current_timescale)
	end)
end
function ChatCommands:fill_cw(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then
		return
	end

	for item_name, item_definition in pairs(ITEM_DEFINITIONS or {}) do
		if item_definition.chat_wheel_details then
			WebInventory:AddItem(event.player_id, {
				name = item_name,
				count = 1,
			})
		end
	end

	WebInventory:UpdateClient(event.player_id)
end