--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
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
	if not event.player then return end

	event.hero = event.player:GetAssignedHero()
	if not event.hero then return end

	event.player_id = event.hero:GetPlayerID()

	local command_source = string.trim(string.lower(event.text))
	if command_source:sub(0,1) ~= "-" then return end
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
	if not command_name then return end
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then return end

	if string.find(command_name, "item_") == 1 then
		local new_item = event.hero:AddItemByName(command_name)
		if not new_item then return end
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
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then return end

	local help_list = {

	}

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
		print(string.format("- %-50s | %-10.1f | %-12.1f |", modifier:GetName(), modifier:GetElapsedTime(), modifier:GetRemainingTime()))
	end
	print(string.rep("-", 81) .. "|", "\n")
end


function ChatCommands:allup(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then return end
	if not arguments[1] then return end

	local arg = tonumber(arguments[1])

	for player_id = 0, (DOTA_MAX_TEAM_PLAYERS-1) do
		if PlayerResource:IsValidPlayer( player_id ) then
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
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then return end

	SendToServerConsole('script_reload')
end

-- Set host_timescale to given value to speed up/slow down time
function ChatCommands:timescale(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then return end
	if not arguments[1] then return end

	local value = tonumber(arguments[1])

	if value < 0.1 then value = 0.1 end -- if arg <= 0, server freezes
	Convars:SetFloat("host_timescale", value)
end

-- Make the server run at full tilt until arg[1] seconds have elapsed
function ChatCommands:warp(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then return end
	if not arguments[1] then return end

	local duration = tonumber(arguments[1])

	if not duration then return end

	local current_timescale = Convars:GetFloat("host_timescale") -- probably breaks if you warp twice at once, too bad!

	Convars:SetFloat("host_force_frametime_to_equal_tick_interval", 1)
	Convars:SetFloat("host_timescale", 100)

	Timers:CreateTimer(duration, function()
		Convars:SetInt("host_force_frametime_to_equal_tick_interval", 0)
		Convars:SetFloat("host_timescale", current_timescale)
	end)
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
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then return end

	local your_team = event.hero:GetTeam()
	for _, team in pairs(GameMode:GetAllAliveTeams()) do
		if team ~= your_team then GameMode:TeamLose(team) end
	end
	GameMode:TeamLose(your_team)
	return
end


function ChatCommands:queue(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then return end

	for i = 1, (tonumber(arguments[2]) or 1) do
		Upgrades:QueueSelection(event.hero, tonumber(arguments[1]))
	end
end


function ChatCommands:clearqueue(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then return end

	Upgrades.queued_selection[event.hero:GetPlayerID()] = {}
end


function ChatCommands:upgrade(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then return end

	Upgrades:AddAbilityUpgrade(event.hero, arguments[1], arguments[2], arguments[3])
end


function ChatCommands:generic(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then return end

	Upgrades:AddGenericUpgrade(event.hero, arguments[1], tonumber(arguments[2]))
end


function ChatCommands:couriers(arguments, event)
	local couriers = Entities:FindAllByClassname("npc_dota_courier")
	local couriers_2 = Entities:FindAllByName("npc_dota_courier")
	print("[ChatCommands] scanning couriers: ", #couriers, #couriers_2)
end


function ChatCommands:setgamewinner(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then return end
	if not tonumber(arguments[1]) then return end

	GameLoop:SetGameWinner(tonumber(arguments[1]))
end


function ChatCommands:entindex(arguments, event)
	print(event.hero:entindex(), event.hero:GetPlayerOwnerID())
end


function ChatCommands:purchase_item(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then return end

	WebInventory:PurchaseItem(event.player_id, arguments[1], tonumber(arguments[2] or 0), tonumber(arguments[3] or 1))
end


function ChatCommands:equip(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then return end

	WebInventory:EquipEvent({
		PlayerID = event.player_id,
		item_name = arguments[1]
	})
end


function ChatCommands:unequip(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then return end

	WebInventory:UnequipEvent({
		PlayerID = event.player_id,
		item_name = arguments[1]

	})
end


function ChatCommands:use_item(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then return end

	WebInventory:ItemConsumeEvent({
		PlayerID = event.player_id,
		item_name = arguments[1],
		used_count = tonumber(arguments[2] or 1)
	})
end


function ChatCommands:redeem_gift_code(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then return end

	GiftCodes:RedeemGiftCode({
		PlayerID = event.player_id,
		gift_code = arguments[1]
	})
end


function ChatCommands:roll_test(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then return end

	local rolled = {}

	for i = 0, 1000 do
		local outcome = WebTreasure:RollTreasureItem(event.player_id, WebInventory.treasure_pools[arguments[1] or "sprays_treasure_1"])

		if not rolled[outcome] then
			rolled[outcome] = 1
		else
			rolled[outcome] = rolled[outcome] + 1
		end
	end

	print("1k rolls result: ")
	DeepPrintTable(rolled)
end


function ChatCommands:double_orbs(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then return end

	GameMode.do_double_orb_drops = not GameMode.do_double_orb_drops
end


function ChatCommands:bots_upgrade(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then return end

	for player_id = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:IsValidPlayerID(player_id) and PlayerResource:IsFakeClient(player_id) then
			local hero = PlayerResource:GetSelectedHeroEntity(player_id)

			local upgrades = Upgrades:GetRandomAbilityUpgrades(hero, UPGRADE_RARITY_COMMON)
			Upgrades:AddAbilityUpgrade(hero, upgrades[1].ability_name, upgrades[1].upgrade_name, UPGRADE_RARITY_COMMON)
		end
	end
end


function ChatCommands:gpl(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then return end

	print("Punishment level:", WebPlayer:GetPunishmentLevel(event.player_id))
end


function ChatCommands:spl(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then return end

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
	if not GameMode:IsDeveloper(event.player_id) then return end
	if not arguments[1] then return end

	local target_player_id  = defer_player_id(arguments[1])

	if not target_player_id then return end

	local hero = PlayerResource:GetPlayer(target_player_id):GetAssignedHero()
	if IsValidEntity(hero) then
		hero:AddNewModifier(hero, nil, "modifier_severe_punishment", {duration = -1})
	end

	GameRules:SendCustomMessage("#chat_command_player_punished", target_player_id, 1)

	WebPlayer:SetPunishmentLevel(target_player_id, tonumber(arguments[2] or 1000), arguments[3] or "chat command", true)
end


function ChatCommands:unpunish(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then return end
	if not arguments[1] then return end

	local target_player_id  = defer_player_id(arguments[1])

	if not target_player_id then return end

	local hero = PlayerResource:GetPlayer(target_player_id):GetAssignedHero()
	if IsValidEntity(hero) then
		hero:RemoveModifierByName("modifier_severe_punishment")
	end

	GameRules:SendCustomMessage("#chat_command_player_punishment_lifted", target_player_id, 1)

	WebPlayer:SetPunishmentLevel(target_player_id, 0, "chat command", true)
end


function ChatCommands:throw_orbs(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then return end

	local overboss = Entities:FindByName(nil, "@overboss")

	local orbs_count = tonumber(arguments[1] or 10)
	local throw_delay = tonumber(arguments[2] or 0.1)

	for i = 0, orbs_count do
		Timers:CreateTimer(i * throw_delay, function()
			OrbDropManager:ThrowOrbs(overboss)
		end)
	end
end


function ChatCommands:reduce_kl(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then return end

	GameLoop:DecreaseScoreByPlayerDisconnect(tonumber(arguments[1] or event.player_id))
end


function ChatCommands:spawn_epic(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then return end

	-- going negative to avoid collisions with "proper" spawn ids
	ChatCommands._epic_spawn_id = (ChatCommands._epic_spawn_id or -100) - 2

	local current_spawn_id = FlyingTreasureDrop.spawn_id

	FlyingTreasureDrop.spawn_id = ChatCommands._epic_spawn_id
	FlyingTreasureDrop:StageOrbLaunches()
	FlyingTreasureDrop:LaunchStagedOrbs()
	FlyingTreasureDrop.spawn_id = current_spawn_id
end


function ChatCommands:map_stats(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then return end

	WebPlayerStats:GetMapStatsEvent({
		PlayerID = event.player_id,
		map_name = arguments[1]
	})
end


function ChatCommands:match_data(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then return end

	WebPlayerStats:GetMatchDataEvent({
		PlayerID = event.player_id,
		match_id = tonumber(arguments[1])
	})
end


function ChatCommands:neutrals(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then return end

	-- NeutralItemDrop:Drop(tonumber(arguments[1] or 1))

	DropNeutralItemAtPositionForHero("item_tier1_token", event.hero:GetAbsOrigin(), event.hero, 0, true)
end


function ChatCommands:abilities(arguments, event)
	DebugMessage("Abilities of", event.hero:GetUnitName())
	DebugMessage(string.rep("-", 68) .. "|")
	for i = 0, 30 do
		local ability = event.hero:GetAbilityByIndex(i)
		if IsValidEntity(ability) then
			DebugMessage(string.format("%-3d - %-50s [Index: %-3d]", i, ability:GetAbilityName(), ability:GetAbilityIndex()))
		end
	end
	DebugMessage(string.rep("-", 68) .. "|")
end

function ChatCommands:fill_cw(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) then return end


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