--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


if inventory == nil then
	_G.inventory = class({})
end

function inventory:init()
	CustomGameEventManager:RegisterListener("get_hero_inventory", Dynamic_Wrap(inventory, "get_hero_inventory"))
	CustomGameEventManager:RegisterListener("swap_inventory_items", Dynamic_Wrap(inventory, "update_hero_inventory"))

	CustomGameEventManager:RegisterListener("get_items_upgrade", Dynamic_Wrap(inventory, "get_items_upgrade"))
	CustomGameEventManager:RegisterListener("try_items_upgrade", Dynamic_Wrap(inventory, "try_items_upgrade"))

	CustomGameEventManager:RegisterListener("try_merge_items", Dynamic_Wrap(inventory, "try_merge_items"))
	CustomGameEventManager:RegisterListener("try_enchant_items", Dynamic_Wrap(inventory, "try_enchant_items"))

	CustomGameEventManager:RegisterListener("get_trade_items", Dynamic_Wrap(inventory, "get_trade_items"))
	CustomGameEventManager:RegisterListener("buy_trade_items", Dynamic_Wrap(inventory, "buy_trade_items"))
	CustomGameEventManager:RegisterListener("get_inventory_for_sell", Dynamic_Wrap(inventory, "get_inventory_for_sell"))
	CustomGameEventManager:RegisterListener("sell_item", Dynamic_Wrap(inventory, "sell_item"))
	CustomGameEventManager:RegisterListener("get_order", Dynamic_Wrap(inventory, "get_order"))
	CustomGameEventManager:RegisterListener("close_order", Dynamic_Wrap(inventory, "close_order"))
	CustomGameEventManager:RegisterListener(
		"auto_dismantling_toggle",
		Dynamic_Wrap(inventory, "auto_dismantling_toggle")
	)

	CustomNetTables:SetTableValue("set_attributes", "set_attributes", {
		desolator = 1, -- базовое снижение тир 1 сета  ||| фул сет = ((1 * номер сета) + (буст по номеру сета * (уровень сета -1))) * 2 * все 6 вещей // (5 + 0.5 * (11-1)) * 2 * 6 = 120
		magic_desolator = 1,
		reflect = 0.4,
		lifesteal = 0.4,
		magic_lifesteal = 0.5,
		mjolnir = 25,
		mjolnir_armor = 25,
		mkb = 35,
		hp_regen = 0.05,
		hp_regen_amp = 1,
		damage_block = 3,
		manacost = 1,
		crit = 5,
		multicast = 1,
		magic_crit = 0.2,

		head = 50,
		armor = 1,
		weapon = 10,
		legs = 3,
		boots = 1,
		shield = 0.5,
	})

	CustomNetTables:SetTableValue("boost_attributes", "boost_attributes", {
		desolator = { 0.1, 0.2, 0.3, 0.4, 0.5, 0.6 },
		magic_desolator = { 0.1, 0.2, 0.3, 0.4, 0.5, 0.6 },
		reflect = { 0.1, 0.1, 0.1, 0.1, 0.1, 0.1 },
		lifesteal = { 0.1, 0.1, 0.1, 0.1, 0.1, 0.1 },
		magic_lifesteal = { 0.1, 0.1, 0.1, 0.1, 0.1, 0.1 },
		mjolnir = { 5, 10, 15, 20, 25, 30 },
		mjolnir_armor = { 5, 10, 15, 20, 25, 30 },
		mkb = { 5, 10, 15, 20, 25, 30 },
		hp_regen = { 0.05, 0.05, 0.05, 0.05, 0.05, 0.05 },
		hp_regen_amp = { 0.2, 0.2, 0.2, 0.2, 0.2, 0.2 },
		damage_block = { 0.1, 0.2, 0.3, 0.4, 0.5, 0.6 },
		manacost = { 0.1, 0.1, 0.1, 0.1, 0.1, 0.1 },
		crit = { 2.0, 2.5, 3.0, 3.5, 4.0, 4.5 },
		multicast = { 0.1, 0.1, 0.1, 0.1, 0.1, 0.1 },
		magic_crit = { 0.2, 0.2, 0.2, 0.2, 0.2, 0.2 },
	})

	_G.state = {}

	_G.state[0] = true
	_G.state[1] = true
	_G.state[2] = true
	_G.state[3] = true
	_G.state[4] = true
end

function inventory:get_set_type(level)
	local set_type
	local set_number
	if level <= 3 then -- 1 2 3
		set_type = "set_1"
		set_number = 1
	elseif level > 3 and level <= 7 then --- 4 5 6 7
		set_type = "set_2"
		set_number = 2
	elseif level > 7 and level <= 11 then --- 8 9 10 11
		set_type = "set_3"
		set_number = 3
	elseif level > 11 and level <= 14 then --- 11 12 13 14
		set_type = "set_4"
		set_number = 4
	elseif level > 14 and level <= 17 then --- 15 16 17
		set_type = "set_5"
		set_number = 5
	elseif level > 17 then --- 18 19 20
		set_type = "set_6"
		set_number = 6
	end

	return set_type, set_number
end

-------------------------------------------------------

function inventory:CheckFullSet(data)
	local filledItems = 0
	local setType = nil
	for itemKey, itemData in pairs(data) do
		if itemData ~= nil then
			filledItems = filledItems + 1
			if setType == nil then
				setType = itemData.set_type
			elseif setType ~= itemData.set_type then
				return 1
			end
		end
	end
	if filledItems == 6 then
		return 2
	else
		return 1
	end
end

local can_use_sets = {
	["1"] = { min = 0 },
	["2"] = { min = 20 },
	["3"] = { min = 40 },
	["4"] = { min = 80 },
	["5"] = { min = 120 },
	["6"] = { min = 200 },
}

-- local can_use_sets = {
--     ["1"] = {min=0},
--     ["2"] = {min=4},
--     ["3"] = {min=8},
--     ["4"] = {min=12},
--     ["5"] = {min=15},
--     ["6"] = {min=18},
-- }

CustomNetTables:SetTableValue("can_use_sets", "can_use_sets", can_use_sets)

function inventory:update_description(data, pid)
	local decription_attributes = CustomNetTables:GetTableValue("set_attributes", "set_attributes")
	local boost_attributes = CustomNetTables:GetTableValue("boost_attributes", "boost_attributes")
	local can_use_sets_net = CustomNetTables:GetTableValue("can_use_sets", "can_use_sets")
	local sid = PlayerResource:GetSteamAccountID(pid)
	local attributeSum = {}
	for itemKey, itemData in pairs(data) do
		if itemData ~= nil then
			for _, attributesKey in ipairs({ "bonus_attribute", "base_attribute" }) do
				local attributes = itemData[attributesKey]

				for attrKey, _ in pairs(attributes) do
					local set_req = can_use_sets_net[tostring(itemData.set_number)]
					if set_req and _G.Account_stats[sid].level < set_req.min then
						goto continue_inner_loop
					end

					local value = decription_attributes[attrKey]

					if attributesKey == "base_attribute" then
						if attributeSum[attrKey] == nil then
							attributeSum[attrKey] = itemData.level * itemData.set_number * value
						end
					else
						if attributeSum[attrKey] == nil then
							-- attributeSum[attrKey] = value + (itemData.set_number * 0.1 * itemData.level) - itemData.set_number * 0.1
							attributeSum[attrKey] = value * itemData.set_number
								+ boost_attributes[attrKey][tostring(itemData.set_number)] * (itemData.level - 1)
						else
							-- attributeSum[attrKey] = attributeSum[attrKey] + value + (itemData.set_number * 0.1 * itemData.level) - itemData.set_number * 0.1
							attributeSum[attrKey] = attributeSum[attrKey]
								+ value * itemData.set_number
								+ boost_attributes[attrKey][tostring(itemData.set_number)] * (itemData.level - 1)
						end
					end
					::continue_inner_loop::
				end
			end
		end
	end
	return attributeSum
end

ListenToGameEvent("npc_spawned", function(data)
	local unit = EntIndexToHScript(data.entindex)

	if not unit then
		return
	end
	if not unit.IsBaseNPC or not unit:IsBaseNPC() then
		return
	end
	if not unit:IsRealHero() then
		return
	end

	local setBonusStats = unit.__setBonusStats

	if not setBonusStats then
		return
	end

	unit.__setBonusStats = nil

	if unit:HasModifier("modifier_sets") then --- проблема с OnRefresh() поэтому так
		unit:RemoveModifierByName("modifier_sets")
		unit:AddNewModifier(unit, nil, "modifier_sets", setBonusStats)
	else
		unit:AddNewModifier(unit, nil, "modifier_sets", setBonusStats)
	end
end, nil)

function inventory:update_sets(pid, data)
	print("update set")
	new_data = inventory:update_description(data, pid)
	new_data["full_set"] = inventory:CheckFullSet(data)
	local hero = PlayerResource:GetSelectedHeroEntity(pid)

	if hero:IsAlive() then
		if hero:HasModifier("modifier_sets") then --- проблема с OnRefresh() поэтому так
			hero:RemoveModifierByName("modifier_sets")
			hero:AddNewModifier(hero, nil, "modifier_sets", new_data)
		else
			hero:AddNewModifier(hero, nil, "modifier_sets", new_data)
		end
	else
		hero.__setBonusStats = new_data
	end
end

-------------------------------------------------------

function inventory:roll_random_attributes_count(pid)
	local chances

	-- if _G.Game_Difficulty == 20 then
	--     chances = {
	--         {min = 0, max = 1, reward = 5},     -- 1%
	--         {min = 1, max = 3, reward = 4},     -- 2%
	--         {min = 4, max = 8, reward = 3},     -- 4%
	--         {min = 9, max = 20, reward = 2},    -- 12%
	--         {min = 21, max = 101, reward = 1}   -- 80%
	--     }
	-- else
	chances = {
		{ min = 0, max = 1, reward = 4 }, -- 1%
		{ min = 1, max = 3, reward = 3 }, -- 2%
		{ min = 4, max = 8, reward = 2 }, -- 4%
		{ min = 9, max = 20, reward = 1 }, -- 12%
		{ min = 21, max = 101, reward = 0 }, -- 80%
	}
	-- end

	local hero = PlayerResource:GetSelectedHeroEntity(pid)
	local bonus_percent = 0

	local guildMod = hero:FindModifierByName("modifier_guild")
	if guildMod then
		bonus_percent = guildMod.nonZeroStatsEquipmentChance
	end

	local random_number = RandomInt(0, 100)

	-- Если выпал 0 атрибутов, даем шанс на переролл
	if random_number >= 21 and random_number <= 100 then
		if RandomInt(1, 100) <= bonus_percent then
			random_number = RandomInt(0, 20) -- Переролл в пользу лучших наград
		end
	end

	local result = 0
	for _, range in ipairs(chances) do
		if random_number >= range.min and random_number < range.max then
			result = range.reward
			break
		end
	end
	return result
end

function inventory:selectUniqueRandomAttributes(count, attributes)
	local result = {}
	local tempAttributes = table.shuffle(table.shallowcopy(attributes))
	for i = 1, count do
		result[tempAttributes[i]] = 1
	end
	return result
end

function inventory:get_attribute_data(pid)
	local count = inventory:roll_random_attributes_count(pid)
	local attributes = {
		"desolator",
		"magic_desolator",
		"reflect",
		"lifesteal",
		"magic_lifesteal",
		"mjolnir",
		"mjolnir_armor",
		"mkb",
		"hp_regen",
		"hp_regen_amp",
		"damage_block",
		"manacost",
		"crit",
		"multicast",
		"magic_crit",
	}
	return inventory:selectUniqueRandomAttributes(count, attributes)
end

function inventory:roll_random_item(pid, unitname)
	if GameRules:IsCheatMode() and not IsInToolsMode() then
		return
	end

	local golden_unit_drops = {
		GoldenMiner = "boots",
		GoldenQueen = "armor",
		GoldenWyvern = "shield",
		GoldenSea = "head",
		GoldenDragon = "legs",
		GoldenForest = "weapon",
	}

	local item_data = {}
	local set_name, set_number = inventory:get_set_type(_G.Game_Difficulty)
	local item = golden_unit_drops[unitname]
	item_data["item_type"] = item
	item_data["level"] = 1
	item_data["set_type"] = set_name
	item_data["bonus_attribute"] = inventory:get_attribute_data(pid)
	item_data["set_number"] = set_number
	item_data["base_attribute"] = { [item] = 1 }
	table.print(item_data)
	inventory:add_new_item_in_inventory(pid, item_data)
end

function inventory:add_bless(pid)
	if GameRules:IsCheatMode() and not IsInToolsMode() then
		return
	end

	local playerIDs = {}
	for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:HasSelectedHero(playerID) and PlayerResource:GetTeam(playerID) == DOTA_TEAM_GOODGUYS then
			local connection = PlayerResource:GetConnectionState(playerID)
			if connection ~= DOTA_CONNECTION_STATE_ABANDONED then
				table.insert(playerIDs, playerID)
			end
		end
	end

	local random = RandomInt(0, 15000 - (_G.Game_Difficulty * 500))
	if random < 5 then
		local item_data = {}
		item_data["item_type"] = "bless"
		item_data["level"] = 1
		item_data["set_type"] = "jewell"
		item_data["bonus_attribute"] = {}
		item_data["set_number"] = 1
		item_data["base_attribute"] = {}

		if _G.guild_event_team then
			for _, target_pid in pairs(playerIDs) do
				inventory:add_new_item_in_inventory(target_pid, item_data)
			end
			return
		end

		local final_pid = pid

		if not (guild_events and guild_events.solo_active_players and guild_events.solo_active_players[pid]) then
			if #playerIDs > 0 then
				local randomIndex = RandomInt(1, #playerIDs)
				final_pid = playerIDs[randomIndex]
			end
		end

		inventory:add_new_item_in_inventory(final_pid, item_data)
	end
end

function inventory:add_soul(pid)
	if GameRules:IsCheatMode() and not IsInToolsMode() then
		return
	end

	local item_data = {}
	item_data["item_type"] = "soul"
	item_data["level"] = _G.Game_Difficulty
	item_data["set_type"] = "jewell"
	item_data["bonus_attribute"] = {}
	item_data["set_number"] = 1
	item_data["base_attribute"] = {}
	inventory:add_new_item_in_inventory(pid, item_data)
end

function inventory:roll_discount(pid)
	if GameRules:IsCheatMode() and not IsInToolsMode() then
		return
	end

	local discount_drop = { "boots", "armor", "shield", "legs", "head", "weapon" }

	local attributes = {
		"desolator",
		"magic_desolator",
		"reflect",
		"lifesteal",
		"magic_lifesteal",
		"mjolnir",
		"mjolnir_armor",
		"mkb",
		"hp_regen",
		"hp_regen_amp",
		"damage_block",
		"manacost",
		"crit",
		"multicast",
		"magic_crit",
	}

	local index = 1

	Timers:CreateTimer(0, function()
		if index > #discount_drop then
			return nil
		end

		local item = discount_drop[index]

		local item_data = {}
		item_data["item_type"] = item
		item_data["level"] = 1
		item_data["set_type"] = "set_1"
		item_data["bonus_attribute"] = inventory:selectUniqueRandomAttributes(2, attributes)
		item_data["set_number"] = 1
		item_data["base_attribute"] = { [item] = 1 }

		inventory:add_new_item_in_inventory(pid, item_data)

		index = index + 1
		return 0.3
	end)
end

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

function inventory:get_hero_inventory(t)
	if _G.state[t.pid] then
		print("get_hero_inventory")
		arr = {
			sid = tostring(PlayerResource:GetSteamID(t.pid)),
		}
		arr = json.encode(arr)
		local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_get_hero_inventory1/?key=" .. _G.key)
		req:SetHTTPRequestGetOrPostParameter("arr", arr)
		req:SetHTTPRequestAbsoluteTimeoutMS(100000)
		req:Send(function(res)
			if res.StatusCode == 200 and res.Body ~= nil then
				local data = json.decode(res.Body)
				local sid = PlayerResource:GetSteamAccountID(t.pid)
				if t.send_id then
					data["send_id"] = t.send_id
				end
				CustomGameEventManager:Send_ServerToPlayer(
					PlayerResource:GetPlayer(t.PlayerID),
					"open_inv",
					{ data = data, diff = _G.Account_stats[sid].level }
				)
			else
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(t.PlayerID), "open_inv", {})
				print(res.StatusCode)
			end
		end)
	end
end

function inventory:update_hero_inventory(t)
	print("update_hero_inventory")

	if _G.state[t.PlayerID] then
		arr = {
			sid = tostring(PlayerResource:GetSteamID(t.PlayerID)),
			swapped_items = t.swapped_items,
		}
		arr = json.encode(arr)
		local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_update_hero_inventory1/?key=" .. _G.key)
		req:SetHTTPRequestGetOrPostParameter("arr", arr)
		req:SetHTTPRequestAbsoluteTimeoutMS(100000)
		req:Send(function(res)
			if res.StatusCode == 200 and res.Body ~= nil then
				local data = json.decode(res.Body)
				data.send_id = t.send_id
				inventory:update_sets(t.PlayerID, data.hero_enquip)
				local sid = PlayerResource:GetSteamAccountID(t.PlayerID)
				CustomGameEventManager:Send_ServerToPlayer(
					PlayerResource:GetPlayer(t.PlayerID),
					"UpdateInventoryMain",
					{ data = data, diff = _G.Account_stats[sid].level, PlayerID = t.PlayerID }
				)
			else
				print(res.StatusCode)
				print(res.Body)
				if callback_error and callback_error.status then
					CustomGameEventManager:Send_ServerToPlayer(
						PlayerResource:GetPlayer(t.PlayerID),
						"mountain_dota_hud_show_hud_error",
						{ message = callback_error.status }
					)
				end
			end
		end)
	end
end

function inventory:add_new_item_in_inventory(pid, data)
	print("add_new_item_in_inventory")
	arr = {
		sid = tostring(PlayerResource:GetSteamID(pid)),
		data = data,
		auto_dismantling = inventory.auto_dismantling and inventory.auto_dismantling[pid],
	}
	arr = json.encode(arr)
	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/add_new_item_in_inventory/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", arr)
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(pid), "show_item_reward", data)
		else
			print(res.StatusCode)
			if callback_error and callback_error.status then
				CustomGameEventManager:Send_ServerToPlayer(
					PlayerResource:GetPlayer(t.PlayerID),
					"mountain_dota_hud_show_hud_error",
					{ message = callback_error.status }
				)
			end
		end
	end)
end

----------------------------------------------------------------------------------------

function inventory:get_items_upgrade(t)
	print("get_items_upgrade")
	arr = {
		sid = tostring(PlayerResource:GetSteamID(t.PlayerID)),
	}
	arr = json.encode(arr)
	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_get_items_upgrade/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", arr)
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			local data = json.decode(res.Body)
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(t.PlayerID), "blacksmith_init", data)
		else
			print(res.StatusCode)
			if callback_error and callback_error.status then
				CustomGameEventManager:Send_ServerToPlayer(
					PlayerResource:GetPlayer(t.PlayerID),
					"mountain_dota_hud_show_hud_error",
					{ message = callback_error.status }
				)
			end
		end
	end)
end

function inventory:try_items_upgrade(t)
	print("try_items_upgrade")
	_G.state[t.PlayerID] = false
	arr = {
		sid = tostring(PlayerResource:GetSteamID(t.PlayerID)),
		item_id = t.item_id,
		slot_number = t.slot_number,
	}
	arr = json.encode(arr)
	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_try_item_upgrade/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", arr)
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			local data = json.decode(res.Body)
			_G.state[t.PlayerID] = true
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(t.PlayerID), "blacksmith_update", data)
		else
			_G.state[t.PlayerID] = true
			print(res.StatusCode, res.Body)
			if callback_error and callback_error.status then
				CustomGameEventManager:Send_ServerToPlayer(
					PlayerResource:GetPlayer(t.PlayerID),
					"mountain_dota_hud_show_hud_error",
					{ message = callback_error.status }
				)
			end
		end
	end)
end

function inventory:try_enchant_items(t)
	print("try_enchant_items")
	_G.state[t.PlayerID] = false
	arr = {
		sid = tostring(PlayerResource:GetSteamID(t.PlayerID)),
		item_id = t.item_id,
		slot_number = t.slot_number,
	}
	arr = json.encode(arr)
	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_try_enchant_items/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", arr)
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			local data = json.decode(res.Body)
			_G.state[t.PlayerID] = true
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(t.PlayerID), "blacksmith_update", data)
		else
			_G.state[t.PlayerID] = true
			print(res.StatusCode, res.Body)
			if callback_error and callback_error.status then
				CustomGameEventManager:Send_ServerToPlayer(
					PlayerResource:GetPlayer(t.PlayerID),
					"mountain_dota_hud_show_hud_error",
					{ message = callback_error.status }
				)
			end
		end
	end)
end

function inventory:try_merge_items(t)
	print("try_merge_items")
	local playerID = t.PlayerID

	if _G.state[playerID] == false then
		print("Request already in progress for player: " .. playerID)
		return
	end

	_G.state[playerID] = false

	local arr = {
		sid = tostring(PlayerResource:GetSteamID(playerID)),
		item_ids = t.ids,
		result_type = t.result_type,
	}

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_try_merge_items/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		_G.state[playerID] = true
		if res.StatusCode == 200 and res.Body ~= nil then
			local data = json.decode(res.Body)
			_G.state[t.PlayerID] = true
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(t.PlayerID), "merge_update", data)
		else
			_G.state[t.PlayerID] = true
			print(res.StatusCode, res.Body)
			if callback_error and callback_error.status then
				CustomGameEventManager:Send_ServerToPlayer(
					PlayerResource:GetPlayer(t.PlayerID),
					"mountain_dota_hud_show_hud_error",
					{ message = callback_error.status }
				)
			end
		end
	end)
end

-- ////////////////////////////////////////// TRADE //////////////////////////////

function inventory:get_trade_items(t)
	print("get_trade_items")
	arr = {
		type = t.type,
	}
	arr = json.encode(arr)
	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_get_trade_items/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", arr)
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			local data = json.decode(res.Body)
			CustomGameEventManager:Send_ServerToPlayer(
				PlayerResource:GetPlayer(t.PlayerID),
				"init_buy",
				{ listings = data.listings, type = t.type }
			)
		else
			print(res.StatusCode)
			if callback_error and callback_error.status then
				CustomGameEventManager:Send_ServerToPlayer(
					PlayerResource:GetPlayer(t.PlayerID),
					"mountain_dota_hud_show_hud_error",
					{ message = callback_error.status }
				)
			end
		end
	end)
end

function inventory:buy_trade_items(t)
	print("buy_trade_items")
	arr = {
		sid = tostring(PlayerResource:GetSteamID(t.PlayerID)),
		listing_id = t.listing_id,
		item_id = t.item_id,
		trade_section = t.tab,
	}
	arr = json.encode(arr)
	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_buy_trade_items/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", arr)
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			local data = json.decode(res.Body)
			CustomGameEventManager:Send_ServerToPlayer(
				PlayerResource:GetPlayer(t.PlayerID),
				"update_buy",
				{ listing = data.listing, type = t.tab }
			)
		else
			print(res.StatusCode)
			print(res.Body)
			if callback_error and callback_error.status then
				CustomGameEventManager:Send_ServerToPlayer(
					PlayerResource:GetPlayer(t.PlayerID),
					"mountain_dota_hud_show_hud_error",
					{ message = callback_error.status }
				)
			end
		end
	end)
end

function inventory:get_inventory_for_sell(t)
	print("get_inventory_for_sell")
	arr = {
		sid = tostring(PlayerResource:GetSteamID(t.PlayerID)),
	}
	arr = json.encode(arr)
	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_get_inventory_for_sell/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", arr)
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			local data = json.decode(res.Body)
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(t.PlayerID), "init_sell", data)
		else
			print(res.StatusCode)
			if callback_error and callback_error.status then
				CustomGameEventManager:Send_ServerToPlayer(
					PlayerResource:GetPlayer(t.PlayerID),
					"mountain_dota_hud_show_hud_error",
					{ message = callback_error.status }
				)
			end
		end
	end)
end

function inventory:sell_item(t)
	print("sell_item")
	_G.state[t.PlayerID] = false
	arr = {
		sid = tostring(PlayerResource:GetSteamID(t.PlayerID)),
		item_id = t.item_id,
		slot_number = t.slot_number,
		price = math.floor(t.price),
	}

	arr = json.encode(arr)
	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_sell_item/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", arr)
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			local data = json.decode(res.Body)
			_G.state[t.PlayerID] = true
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(t.PlayerID), "init_sell", data)
		else
			_G.state[t.PlayerID] = true
			print(res.StatusCode)
			local callback_error = json.decode(res.Body)
			if callback_error and callback_error.status then
				CustomGameEventManager:Send_ServerToPlayer(
					PlayerResource:GetPlayer(t.PlayerID),
					"mountain_dota_hud_show_hud_error",
					{ message = callback_error.status }
				)
			end
		end
	end)
end

function inventory:get_order(t)
	print("get_order")
	arr = {
		sid = tostring(PlayerResource:GetSteamID(t.PlayerID)),
	}
	arr = json.encode(arr)
	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_get_order/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", arr)
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			local data = json.decode(res.Body)
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(t.PlayerID), "init_order", data)
		else
			print(res.StatusCode)
			if callback_error and callback_error.status then
				CustomGameEventManager:Send_ServerToPlayer(
					PlayerResource:GetPlayer(t.PlayerID),
					"mountain_dota_hud_show_hud_error",
					{ message = callback_error.status }
				)
			end
		end
	end)
end

function inventory:close_order(t)
	print("close_order")
	arr = {
		sid = tostring(PlayerResource:GetSteamID(t.PlayerID)),
		item_id = t.item_id,
		listing_id = t.listing_id,
	}
	arr = json.encode(arr)
	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_close_order/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", arr)
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			local data = json.decode(res.Body)
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(t.PlayerID), "update_order", data)
		else
			print(res.StatusCode)
			if callback_error and callback_error.status then
				CustomGameEventManager:Send_ServerToPlayer(
					PlayerResource:GetPlayer(t.PlayerID),
					"mountain_dota_hud_show_hud_error",
					{ message = callback_error.status }
				)
			end
		end
	end)
end

function inventory:auto_dismantling_toggle(t)
	inventory.auto_dismantling = inventory.auto_dismantling or {}
	local toggle_state = t.toggle_state == 1
	inventory.auto_dismantling[t.PlayerID] = toggle_state
end

inventory:init()