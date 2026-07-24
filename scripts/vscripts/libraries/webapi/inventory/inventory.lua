--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


WebInventory = WebInventory or {}
-- status: in progress
require("libraries/webapi/inventory/equipment")
require("libraries/webapi/inventory/treasure")


function WebInventory:Init()
	-- EventStream:Listen("WebInventory:get_definitions", WebInventory.GetItemDefinitions, WebInventory)
	EventStream:Listen("WebInventory:get_items", WebInventory.GetItems, WebInventory)
	EventStream:Listen("WebInventory:purchase", WebInventory.PurchaseEvent, WebInventory)
	EventStream:Listen("WebInventory:consume", WebInventory.ItemConsumeEvent, WebInventory)
	EventStream:Listen("WebInventory:use", WebInventory.ItemUseEvent, WebInventory)
	EventStream:Listen("WebInventory:add", WebInventory.AddItemEvent, WebInventory)

	WebInventory.players_items = {}
	WebInventory.definitions_client_data = {}

	WebInventory.treasure_pools = {}

	WebInventory:BuildClientData()
end


function WebInventory:AddItemEvent(event)
	if not IsInToolsMode() then return end

	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	WebInventory:AddBackendItem(player_id, event.item_name, event.count or 1)
end


function WebInventory:AddBackendItem(player_id, item_name, count)
	local steam_id = tostring(PlayerResource:GetSteamID(player_id))

	WebApi:Send(
		"api/lua/inventory/add_item",
		{
			steam_id = steam_id,
			item_name = item_name,
			item_count = count or 1,
		},
		function(data)
			print("[WebInventory] successfully purchased item", item_name)
			WebPlayer:UpdateClient(player_id)
			WebInventory:AddItem(player_id, data.item)
			WebInventory:UpdateClient(player_id)
			BattlePass:UpdateClient(player_id)
		end,
		function(err)
			print("[WebInventory] failed to purchase item", item_name)
		end
	)
end

function WebInventory:BuildClientData()
	-- build client data (stripped core declarations)
	-- while validating essential item fields

	for item_name, item_definition in pairs(ITEM_DEFINITIONS or {}) do
		if not item_definition.slot then
			local err = "[WebInventory] item is missing required `slot` param: " .. item_name
			error(err)
		end
		if not item_definition.type then
			local err = "[WebInventory] item is missing required `type` param: " .. item_name
			error(err)
		end
		if not item_definition.rarity then
			local err = "[WebInventory] item is missing required `rarity` param: " .. item_name
			error(err)
		end

		if item_definition.unlocked_with and item_definition.unlocked_with.treasure then
			local treasure_name = item_definition.unlocked_with.treasure

			if not WebInventory.treasure_pools[treasure_name] then
				WebInventory.treasure_pools[treasure_name] = {}
			end

			table.insert(WebInventory.treasure_pools[treasure_name], item_name)
		end

		WebInventory.definitions_client_data[item_name] = {
			slot = item_definition.slot,
			type = item_definition.type,
			rarity = item_definition.rarity,
			unlocked_with = item_definition.unlocked_with,
			is_hidden = item_definition.is_hidden,
			is_hidden_owned = item_definition.is_hidden_owned,
			chat_wheel_details = item_definition.chat_wheel_details,
		}
	end

	-- print("[WebInventory] client data built")
	-- DeepPrintTable(WebInventory.treasure_pools)
end


function WebInventory:SetPlayerItems(player_id, items)
	for item_name, item_data in pairs(items or {}) do
		WebInventory:AddItem(player_id, item_data)
	end
	BattlePass:ApplyItemFilters(player_id)
	-- DeepPrintTable(WebInventory.players_items[player_id])
	WebInventory:UpdateClient(player_id)
end


function WebInventory:AddItem(player_id, item_data)
	if not WebInventory.players_items[player_id] then WebInventory.players_items[player_id] = {} end

	local definition = WebInventory:GetItemDefinition(item_data.name)
	if not definition then return end

	WebInventory.players_items[player_id][item_data.name] = {
		count = item_data.count,
	}
end


function WebInventory:GetItemSlot(item_name)
	local definition = WebInventory:GetItemDefinition(item_name)
	if not definition then return end
	return definition.slot
end


function WebInventory:GetItemRarity(item_name)
	local definition = WebInventory:GetItemDefinition(item_name)
	if not definition then return {} end
	return definition.rarity or ITEM_RARITIES.COMMON
end

function WebInventory:_HasItem(player_id, item_name)
	if not WebInventory.players_items[player_id] then return false end
	if not WebInventory.players_items[player_id][item_name] then return false end
	return true
end


function WebInventory:HasItem(player_id, item_name)
	local definition = WebInventory:GetItemDefinition(item_name)

	-- check optional ways to unlock item usage
	-- aka "ephemeral" items
	if definition and definition.unlocked_with then
		local sub_tier_requirement = definition.unlocked_with.subscription_tier
		if sub_tier_requirement and sub_tier_requirement <= WebPlayer:GetSubscriptionTier(player_id) then
			return true
		end
	end

	if not WebInventory:_HasItem(player_id, item_name) then return false end
	return true
end


function WebInventory:GetItem(player_id, item_name)
	if not WebInventory.players_items[player_id] then return end
	return WebInventory.players_items[player_id][item_name]
end


function WebInventory:GetItemCount(player_id, item_name)
	local item = WebInventory:GetItem(player_id, item_name)
	if item then return item.count or 0 else return 0 end
end


function WebInventory:ModifyItemCount(player_id, item_name, count_change)
	local item = WebInventory:GetItem(player_id, item_name)
	if item then
		item.count = math.max(item.count + count_change, 0)
		return item.count
	end
	return 0
end


function WebInventory:SetItemCount(player_id, item_name, new_count)
	local item = WebInventory:GetItem(player_id, item_name)
	if item then
		item.count = new_count
	end
end


function WebInventory:GetItemDefinition(item_name)
	local definition = ITEM_DEFINITIONS[item_name]
	if not definition then
		print("[WebInventory] no definition for item", item_name)
		return
	end
	return definition
end

-- handy shortcut for consumable items
-- performs request to backend to reduce item count by `item_count` or 1 (with all appropriate validations)
-- calls passed callback when request succeeds
function WebInventory:ConsumeItem(player_id, item_name, item_count, on_item_used)
	local steam_id = tostring(PlayerResource:GetSteamID(player_id))
	if not WebInventory.players_items[player_id] or not WebInventory.players_items[player_id][item_name] then return end

	local _item_count = item_count or 1

	if WebInventory:GetItemCount(player_id, item_name) < _item_count then
		DisplayError(player_id, "#web_inventory_not_enough_items")
		return
	end

	WebApi:Send(
		"api/lua/inventory/use_item",
		{
			steam_id = steam_id,
			item_name = item_name,
			spent_count = _item_count,
		},
		function(data)
			print("[WebInventory] successfully consumed item", item_name, _item_count, data.new_count)
			WebInventory.players_items[player_id][data.name].count = data.new_count
			WebInventory:UpdateClient(player_id)

			if on_item_used then
				ErrorTracking.Try(on_item_used, data)
			end
		end,
		function(err)
			print("[WebInventory] failed to use item", item_name, _item_count)
		end
	)
end


function WebInventory:PurchaseItem(player_id, item_name, total_cost, count)
	if WebPlayer:GetCurrency(player_id) < total_cost then
		DisplayError(player_id, "#web_inventory_not_enough_currency_to_purchase")
		return
	end

	local steam_id = tostring(PlayerResource:GetSteamID(player_id))
	if count <= 0 then return end

	WebApi:Send(
		"api/lua/inventory/purchase_item",
		{
			steam_id = steam_id,
			item_name = item_name,
			total_cost = total_cost,
			purchased_count = count or 1
		},
		function(data)
			print("[WebInventory] successfully purchased item", item_name)
			WebPlayer:SetCurrency(player_id, data.new_currency)
			WebPlayer:UpdateClient(player_id)
			WebInventory:AddItem(player_id, data.item)
			WebInventory:UpdateClient(player_id)
		end,
		function(err)
			print("[WebInventory] failed to purchase item", player_id, item_name, total_cost)
		end
	)
end


function WebInventory:ModifyBackendItemCount(player_id, item_name, item_count_change)
	local steam_id = tostring(PlayerResource:GetSteamID(player_id))

	WebApi:Send(
		"api/lua/inventory/modify_item_count",
		{
			steam_id = steam_id,
			item_name = item_name,
			item_count = item_count_change
		},
		function(data)
			print("[WebInventory] successfully updated item quantity", item_name)
			WebInventory:ModifyItemCount(player_id, item_name, item_count_change)
			WebInventory:UpdateClient(player_id)
		end,
		function(err)
			print("[WebInventory] failed to update item count", player_id, item_name, item_count_change)
		end
	)
end


function WebInventory:GetItemDefinitions(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	CustomGameEventManager:Send_ServerToPlayer(player, "WebInventory:set_definitions", {
		definitions = WebInventory.definitions_client_data
	})
end


function WebInventory:GetItems(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	WebInventory:UpdateClient(player_id)
end


function WebInventory:GetItemCost(item_name)
	local definition = WebInventory:GetItemDefinition(item_name)
	if not definition.unlocked_with then return 0 end
	return definition.unlocked_with.currency or 0
end


function WebInventory:PurchaseEvent(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	local count = event.count or 1
	local total_cost = count * WebInventory:GetItemCost(event.item_name)

	WebInventory:PurchaseItem(player_id, event.item_name, total_cost, count)
end


function WebInventory:ItemConsumeEvent(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end
	if not event.item_name then return end

	local item_name = event.item_name
	local consumed_count = event.consumed_count or 1
	if consumed_count <= 0 then return end

	local definition = WebInventory:GetItemDefinition(item_name)
	if not definition then return end

	if not WebInventory:HasItem(player_id, item_name) then
		print("[WebInventory] player doesn't own item it's trying to consume!", player_id, item_name)
		return
	end

	local item = WebInventory:GetItem(player_id, item_name)
	if item.count < consumed_count then
		print("[WebInventory] player doesn't have enough of", item_name)
		return
	end

	if GetMapName() == "ot3_demo" then
		DisplayError(player_id, "dota_hud_error_cannot_use_consumables_in_demo_mode")
		return
	end

	WebInventory:ConsumeItem(player_id, item_name, consumed_count, function()
		if definition.on_consume then
			-- refetch item data since UseItem updates it internally before this callback is invoked
			local item_data = WebInventory:GetItem(player_id, item_name)
			if definition.on_consume_context then
				ErrorTracking.Try(definition.on_consume, definition.on_consume_context, player_id, item_name, item_data, definition)
			else
				ErrorTracking.Try(definition.on_consume, player_id, item_name, item_data, definition)
			end
		end
	end)
end


function WebInventory:ItemUseEvent(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end
	if not event.item_name then return end

	local item_name = event.item_name

	local definition = WebInventory:GetItemDefinition(item_name)
	if not definition then return end

	if not WebInventory:HasItem(player_id, item_name) then
		print("[WebInventory] player doesn't own item it's trying to use!", player_id, item_name)
		return
	end

	if definition.on_use then
		-- refetch item data since UseItem updates it internally before this callback is invoked
		local item_data = WebInventory:GetItem(player_id, item_name)
		if definition.on_use_context then
			ErrorTracking.Try(definition.on_use, definition.on_use_context, item_name, item_data, definition)
		else
			ErrorTracking.Try(definition.on_use, item_name, item_data, definition)
		end
	end
end


function WebInventory:UpdateClient(player_id)
	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	CustomGameEventManager:Send_ServerToPlayer(player, "WebInventory:update", {
		items = WebInventory.players_items[player_id] or {}
	})

	EventDriver:Dispatch("WebInventory:update", {
		player_id = player_id
	})
end


WebInventory:Init()


--[[
Items:
- Equipment
	Verify declaration integrity on load, check if item is eligible (if it uses sub tier constraint etc.)
	Play particle / sound effect on equip / on demand
	Allow to equip multiple
	Process special cases (or process everything separately with common tools)
- Consumable
	Cannot be equipped
	Usage via `UseItem` with passed callback or from Panorama using "WebInventory:use" event
- Passive
	Cannot be equipped
	Can be used for battle pass and other "status" items that by themselves do nothing, and don't hold any extra data
]]