--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


-- Мост Lua: приём событий от Panorama, запросы на бэкенд, раздача результатов по игрокам.
if Casino == nil then
	_G.Casino = class({})
end

local ERR_SERVER = "#ui_casv2_error_server"
local ERR_CONNECTION = "#ui_casv2_error_connection"
local ERR_GENERIC = "#ui_casv2_error_generic"
local DEFAULT_ITEM = "item_bkb_flask"
local DEFAULT_HERO = "npc_dota_hero_axe"
local TITLE_WIN = "#ui_casv2_ally_win_title"
local DEFAULT_TOTALS = { ruby = 0, shield = 0 }
local RECENT_JACKPOTS_INTERVAL = 60
local RECENT_JACKPOTS_INIT_DELAY = 5
local MAX_PLAYERS = DOTA_MAX_PLAYERS or 24

local function safeJsonDecode(body)
	if not body or body == "" then
		return nil
	end
	local ok, data = pcall(json.decode, body)
	return ok and data or nil
end

local function getSteamIdsInGame()
	local ids = {}
	if not PlayerResource then
		return ids
	end
	for pid = 0, MAX_PLAYERS - 1 do
		if PlayerResource:GetConnectionState(pid) == DOTA_CONNECTION_STATE_CONNECTED then
			local sid = PlayerResource:GetSteamID(pid)
			if sid and sid ~= 0 then
				ids[tostring(sid)] = true
			end
		end
	end
	return ids
end

local function normalizeArray(value)
	if not value or type(value) ~= "table" then
		return {}
	end
	for k in pairs(value) do
		if type(k) == "number" then
			return value
		end
	end
	local arr = {}
	for _, v in pairs(value) do
		table.insert(arr, v)
	end
	return arr
end

local function buildJackpotPayload(j)
	return {
		steamid = tostring(j.steamid or ""),
		heroname = DEFAULT_HERO,
		item_name = tostring(j.item_name or DEFAULT_ITEM),
		title = TITLE_WIN,
		roll_history_id = j.roll_history_id,
		reward_value = j.reward_value,
		reward_currency = j.reward_currency,
	}
end

local function buildSellClaimResponse(response)
	return {
		success = true,
		inventory = response.inventory or {},
		claimed_history = response.claimed_history or {},
		sold_history = response.sold_history or {},
		sold_totals = response.sold_totals or DEFAULT_TOTALS,
		inventory_sell_totals = response.inventory_sell_totals or DEFAULT_TOTALS,
		inventory_total = response.inventory_total or 0,
		claimed_total = response.claimed_total or 0,
		sold_total = response.sold_total or 0,
		inventory_has_more = response.inventory_has_more or false,
		claimed_has_more = response.claimed_has_more or false,
		sold_has_more = response.sold_has_more or false,
		profile = response.profile,
	}
end

function Casino:init()
	-- События от UI: спин, загрузка данных, история, sell/claim, win_animation_finished.
	CustomGameEventManager:RegisterListener("casino_spin", Dynamic_Wrap(Casino, "OnCasinoSpin"))
	CustomGameEventManager:RegisterListener("casv2_load_data", Dynamic_Wrap(Casino, "OnCasinoLoadData"))
	CustomGameEventManager:RegisterListener("casv2_load_history", Dynamic_Wrap(Casino, "OnCasinoLoadHistory"))
	CustomGameEventManager:RegisterListener(
		"casv2_load_inventory_paginated",
		Dynamic_Wrap(Casino, "OnCasinoLoadInventoryPaginated")
	)
	CustomGameEventManager:RegisterListener("casv2_sell_item", Dynamic_Wrap(Casino, "OnCasinoSellItem"))
	CustomGameEventManager:RegisterListener("casv2_claim_item", Dynamic_Wrap(Casino, "OnCasinoClaimItem"))
	CustomGameEventManager:RegisterListener("casv2_sell_all", Dynamic_Wrap(Casino, "OnCasinoSellAll"))
	CustomGameEventManager:RegisterListener("casv2_claim_all", Dynamic_Wrap(Casino, "OnCasinoClaimAll"))
	CustomGameEventManager:RegisterListener(
		"casv2_claim_level_reward",
		Dynamic_Wrap(Casino, "OnCasinoClaimLevelReward")
	)
	CustomGameEventManager:RegisterListener(
		"casv2_win_animation_finished",
		Dynamic_Wrap(Casino, "OnWinAnimationFinished")
	)
	Casino.lastRecentJackpotsRequestTime = 0
	Casino.pendingWinByPlayer = {}
	Casino.pendingJackpotByPlayer = {}
	Casino.nextRecentJackpotsRunAt = 0
	if Timers then
		Timers:CreateTimer(1, function()
			local now = GameRules:GetGameTime()
			if Casino.nextRecentJackpotsRunAt == 0 then
				Casino.nextRecentJackpotsRunAt = now + RECENT_JACKPOTS_INIT_DELAY
			end
			if now >= Casino.nextRecentJackpotsRunAt then
				Casino:RequestRecentJackpots()
				Casino.nextRecentJackpotsRunAt = now + RECENT_JACKPOTS_INTERVAL
			end
			return 1
		end)
	end
end

function Casino:RequestRecentJackpots()
	-- Джекпоты игроков не из текущей игры — рассылаем всем casv2_show_jackpot_notification.
	local now = GameRules:GetGameTime()
	local timeSinceLast = (Casino.lastRecentJackpotsRequestTime > 0) and (now - Casino.lastRecentJackpotsRequestTime)
		or 55
	local lastSeconds = timeSinceLast + 5
	Casino.lastRecentJackpotsRequestTime = now
	web:SendRequest("/api_recent_jackpots/", "GET", { last_seconds = lastSeconds }, function(res)
		if res.StatusCode ~= 200 or not res.Body then
			return
		end
		local data = safeJsonDecode(res.Body)
		if not data or data.status ~= "success" or not data.jackpots or #data.jackpots == 0 then
			return
		end

		local gameSteamIds = getSteamIdsInGame()
		local filtered = {}
		for _, j in ipairs(data.jackpots) do
			local sid = tostring(j.steamid or "")
			if sid ~= "" and not gameSteamIds[sid] then
				table.insert(filtered, j)
			end
		end

		if #filtered > 0 then
			for _, j in ipairs(filtered) do
				CustomGameEventManager:Send_ServerToAllClients(
					"casv2_show_jackpot_notification",
					buildJackpotPayload(j)
				)
			end
		end
	end)
end

function Casino:OnCasinoSpin(event)
	-- Ставка уходит на бэкенд; ответ casino_spin_result шлём обратно игроку.
	local playerID = event.PlayerID
	local currency = event.currency or "ruby"
	local bet = event.bet

	if not playerID then
		return
	end
	local player = PlayerResource:GetPlayer(playerID)
	if not player then
		return
	end

	local requestData = { sid = tostring(PlayerResource:GetSteamID(playerID)), currency = currency }
	if bet ~= nil then
		requestData.bet = tostring(bet)
	end

	web:SendRequest("/api_roll_casino_reward/", "POST", requestData, function(res)
		if res.StatusCode ~= 200 or not res.Body then
			CustomGameEventManager:Send_ServerToPlayer(
				player,
				"casino_spin_result",
				{ success = false, error = ERR_CONNECTION, currency = currency }
			)
			return
		end

		local response = safeJsonDecode(res.Body)
		if not response then
			CustomGameEventManager:Send_ServerToPlayer(
				player,
				"casino_spin_result",
				{ success = false, error = ERR_SERVER, currency = currency }
			)
			return
		end
		if response.status == "error" then
			CustomGameEventManager:Send_ServerToPlayer(
				player,
				"casino_spin_result",
				{ success = false, error = response.message or ERR_SERVER, currency = currency }
			)
			return
		end

		local slots = response.slots or {}
		local s1, s2, s3 = slots.slot1, slots.slot2, slots.slot3
		local item1 = (s1 and s1.item_name) or DEFAULT_ITEM
		local item2 = (s2 and s2.item_name) or DEFAULT_ITEM
		local item3 = (s3 and s3.item_name) or DEFAULT_ITEM

		local displayCurrency = currency
		if response.is_win and response.reward and response.reward.currency then
			displayCurrency = response.reward.currency
		end

		CustomGameEventManager:Send_ServerToPlayer(player, "casino_spin_result", {
			success = true,
			is_win = response.is_win,
			item1 = item1,
			item2 = item2,
			item3 = item3,
			currency = displayCurrency,
			reward = response.reward,
			refunded = response.refunded or false,
			profile = response.profile,
			rewards = response.rewards,
		})

		if Casino.nextRecentJackpotsRunAt then
			Casino.nextRecentJackpotsRunAt = GameRules:GetGameTime() + RECENT_JACKPOTS_INTERVAL
		end
		Casino:RequestRecentJackpots()

		if response.is_win then
			local steamid, item_name, title, roll_history_id
			if response.ally_win and response.ally_win.steamid and response.ally_win.item_name then
				steamid = tostring(response.ally_win.steamid)
				item_name = tostring(response.ally_win.item_name)
				title = (response.ally_win.title and tostring(response.ally_win.title) ~= "")
						and tostring(response.ally_win.title)
					or TITLE_WIN
				roll_history_id = response.ally_win.roll_history_id
			elseif response.reward and response.reward.item_name then
				steamid = tostring(PlayerResource:GetSteamID(playerID))
				item_name = tostring(response.reward.item_name)
				title = TITLE_WIN
				roll_history_id = response.roll_history_id
			end
			if steamid and item_name then
				local heroname = DEFAULT_HERO
				if PlayerResource then
					local hname = PlayerResource:GetSelectedHeroName(playerID)
					if hname and hname ~= "" then
						heroname = hname
					end
				end
				local payload = {
					steamid = steamid,
					heroname = heroname,
					item_name = item_name,
					title = title,
					roll_history_id = roll_history_id,
				}
				Casino.pendingWinByPlayer[playerID] = payload
				if response.reward and response.reward.is_jackpot then
					payload.reward_value = response.reward.value
					payload.reward_currency = response.reward.currency
					Casino.pendingJackpotByPlayer[playerID] = payload
				end
			end
		end
	end)
end

function Casino:OnWinAnimationFinished(event)
	-- После анимации выигрыша: союзникам — show_win_notification, джекпот — всем show_jackpot_notification.
	local playerID = event.PlayerID
	if playerID == nil then
		return
	end
	if Casino.pendingWinByPlayer and Casino.pendingWinByPlayer[playerID] then
		local winPayload = Casino.pendingWinByPlayer[playerID]
		Casino.pendingWinByPlayer[playerID] = nil
		for pid = 0, MAX_PLAYERS - 1 do
			if pid ~= playerID then
				local p = PlayerResource:GetPlayer(pid)
				if p and PlayerResource:GetConnectionState(pid) == DOTA_CONNECTION_STATE_CONNECTED then
					CustomGameEventManager:Send_ServerToPlayer(p, "casv2_show_win_notification", winPayload)
				end
			end
		end
	end
	if Casino.pendingJackpotByPlayer and Casino.pendingJackpotByPlayer[playerID] then
		local jackpotPayload = Casino.pendingJackpotByPlayer[playerID]
		Casino.pendingJackpotByPlayer[playerID] = nil
		CustomGameEventManager:Send_ServerToAllClients("casv2_show_jackpot_notification", jackpotPayload)
	end
end

function Casino:OnCasinoLoadData(event)
	-- Запрос профиля, инвентаря, истории, джекпотов; ответ casv2_data.
	local playerID = event.PlayerID
	local request_key = event.request_key
	if not playerID then
		return
	end

	if Casino.nextRecentJackpotsRunAt then
		Casino.nextRecentJackpotsRunAt = GameRules:GetGameTime() + RECENT_JACKPOTS_INTERVAL
	end
	Casino:RequestRecentJackpots()

	local player = PlayerResource:GetPlayer(playerID)
	if not player then
		return
	end

	local sid = tostring(PlayerResource:GetSteamID(playerID))
	web:SendRequest("/api_get_casino_data/", "GET", { sid = sid }, function(res)
		if res.StatusCode ~= 200 or not res.Body then
			local errData = { success = false, error = ERR_CONNECTION }
			if request_key ~= nil then
				errData.request_key = request_key
			end
			CustomGameEventManager:Send_ServerToPlayer(player, "casv2_data", errData)
			return
		end

		local response = safeJsonDecode(res.Body)
		if not response then
			local errData = { success = false, error = ERR_SERVER }
			if request_key ~= nil then
				errData.request_key = request_key
			end
			CustomGameEventManager:Send_ServerToPlayer(player, "casv2_data", errData)
			return
		end
		if response.status == "error" then
			local errData = { success = false, error = response.message or ERR_SERVER }
			if request_key ~= nil then
				errData.request_key = request_key
			end
			CustomGameEventManager:Send_ServerToPlayer(player, "casv2_data", errData)
			return
		end

		local data = {
			success = true,
			crystal_jackpots = normalizeArray(response.crystal_jackpots),
			progressive_jackpots = response.progressive_jackpots or {},
			profile = response.profile,
			rewards = response.rewards,
			history = response.history or {},
			inventory = response.inventory or {},
			claimed_history = response.claimed_history or {},
			sold_history = response.sold_history or {},
			sold_totals = response.sold_totals or DEFAULT_TOTALS,
			inventory_sell_totals = response.inventory_sell_totals or DEFAULT_TOTALS,
			inventory_total = response.inventory_total or 0,
			claimed_total = response.claimed_total or 0,
			sold_total = response.sold_total or 0,
			inventory_has_more = response.inventory_has_more or false,
			claimed_has_more = response.claimed_has_more or false,
			sold_has_more = response.sold_has_more or false,
			jackpot_history = response.jackpot_history or {},
			jackpot_total = response.jackpot_total or 0,
			server_now_utc = response.server_now_utc,
			server_timezone = response.server_timezone,
			server_utc_offset_minutes = response.server_utc_offset_minutes,
		}
		if request_key ~= nil then
			data.request_key = request_key
		end
		CustomGameEventManager:Send_ServerToPlayer(player, "casv2_data", data)
	end)
end

function Casino:OnCasinoLoadHistory(event)
	local playerID = event.PlayerID
	local limit = event.limit or 10
	local last_id = event.last_id
	local offset = event.offset or 0
	if not playerID then
		return
	end

	local player = PlayerResource:GetPlayer(playerID)
	if not player then
		return
	end

	local requestParams = { sid = tostring(PlayerResource:GetSteamID(playerID)), limit = tostring(limit) }
	if last_id ~= nil then
		requestParams.last_id = tostring(last_id)
	elseif offset > 0 then
		requestParams.offset = tostring(offset)
	end

	web:SendRequest("/api_get_casino_history/", "GET", requestParams, function(res)
		if res.StatusCode ~= 200 or not res.Body then
			CustomGameEventManager:Send_ServerToPlayer(
				player,
				"casv2_history",
				{ success = false, error = ERR_CONNECTION }
			)
			return
		end
		local response = safeJsonDecode(res.Body)
		if not response then
			CustomGameEventManager:Send_ServerToPlayer(player, "casv2_history", { success = false, error = ERR_SERVER })
			return
		end
		if response.status == "error" then
			CustomGameEventManager:Send_ServerToPlayer(
				player,
				"casv2_history",
				{ success = false, error = response.message or ERR_SERVER }
			)
			return
		end

		local historyData = normalizeArray(response.history)
		CustomGameEventManager:Send_ServerToPlayer(player, "casv2_history", {
			success = true,
			history = historyData,
			total_count = response.total_count or 0,
			limit = response.limit or limit,
			last_id = response.last_id,
			offset = response.offset or offset,
			has_more = response.has_more or false,
		})
	end)
end

function Casino:OnCasinoLoadInventoryPaginated(event)
	local playerID = event.PlayerID
	local status = event.status or "received"
	local offset = event.offset or 0
	local limit = event.limit or 10
	if not playerID then
		return
	end

	local player = PlayerResource:GetPlayer(playerID)
	if not player then
		return
	end

	web:SendRequest("/api_get_casino_inventory_paginated/", "GET", {
		sid = tostring(PlayerResource:GetSteamID(playerID)),
		status = status,
		offset = tostring(offset),
		limit = tostring(limit),
	}, function(res)
		if res.StatusCode ~= 200 or not res.Body then
			CustomGameEventManager:Send_ServerToPlayer(
				player,
				"casv2_inventory_paginated",
				{ success = false, error = ERR_CONNECTION }
			)
			return
		end
		local response = safeJsonDecode(res.Body)
		if not response then
			CustomGameEventManager:Send_ServerToPlayer(
				player,
				"casv2_inventory_paginated",
				{ success = false, error = ERR_SERVER }
			)
			return
		end
		if response.status == "error" then
			CustomGameEventManager:Send_ServerToPlayer(
				player,
				"casv2_inventory_paginated",
				{ success = false, error = response.message or ERR_SERVER }
			)
			return
		end
		CustomGameEventManager:Send_ServerToPlayer(player, "casv2_inventory_paginated", {
			success = true,
			items = normalizeArray(response.items),
			has_more = response.has_more or false,
			total_count = response.total_count or 0,
			offset = response.offset or offset,
			limit = response.limit or limit,
			status = status,
			inventory_sell_totals = response.inventory_sell_totals or DEFAULT_TOTALS,
		})
	end)
end

function Casino:OnCasinoSellItem(event)
	-- Продажа предмета за валюту; ответ casv2_sell_result.
	local playerID = event.PlayerID
	local inventory_id = event.inventory_id
	if not playerID or inventory_id == nil then
		return
	end
	local player = PlayerResource:GetPlayer(playerID)
	if not player then
		return
	end

	web:SendRequest(
		"/api_sell_casino_item/",
		"POST",
		{ sid = tostring(PlayerResource:GetSteamID(playerID)), inventory_id = inventory_id },
		function(res)
			if res.StatusCode ~= 200 or not res.Body then
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"casv2_sell_result",
					{ success = false, error = ERR_CONNECTION }
				)
				return
			end
			local response = safeJsonDecode(res.Body)
			if not response then
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"casv2_sell_result",
					{ success = false, error = ERR_SERVER }
				)
				return
			end
			if response.status == "error" then
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"casv2_sell_result",
					{ success = false, error = response.message or ERR_GENERIC }
				)
				return
			end
			CustomGameEventManager:Send_ServerToPlayer(player, "casv2_sell_result", buildSellClaimResponse(response))
		end
	)
end

function Casino:OnCasinoClaimItem(event)
	-- Забрать в инвентарь (UserItems); при успехе — Shop:win_cas. Ответ casv2_claim_result.
	local playerID = event.PlayerID
	local inventory_id = tonumber(event.inventory_id) or event.inventory_id
	if not playerID or inventory_id == nil then
		return
	end
	local player = PlayerResource:GetPlayer(playerID)
	if not player then
		return
	end

	web:SendRequest(
		"/api_claim_casino_item/",
		"POST",
		{ sid = tostring(PlayerResource:GetSteamID(playerID)), inventory_id = inventory_id },
		function(res)
			if res.StatusCode == 200 and res.Body then
				local response = safeJsonDecode(res.Body)
				if not response then
					CustomGameEventManager:Send_ServerToPlayer(
						player,
						"casv2_claim_result",
						{ success = false, error = ERR_SERVER }
					)
					return
				end
				if response.status == "error" then
					CustomGameEventManager:Send_ServerToPlayer(
						player,
						"casv2_claim_result",
						{ success = false, error = response.message or ERR_GENERIC }
					)
					return
				end
				if response.claimed_item_name and Shop and Shop.win_cas then
					Shop:win_cas({ itemname = response.claimed_item_name, PlayerID = playerID, count = 1 })
				end
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"casv2_claim_result",
					buildSellClaimResponse(response)
				)
			else
				local errMsg = ERR_CONNECTION
				local inv = {}
				if res.Body and res.Body ~= "" then
					local resp = safeJsonDecode(res.Body)
					if resp then
						if resp.message then
							errMsg = resp.message
						end
						if resp.inventory then
							inv = resp.inventory
						end
					end
				end
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"casv2_claim_result",
					{ success = false, error = errMsg, inventory = inv }
				)
			end
		end
	)
end

function Casino:OnCasinoSellAll(event)
	local playerID = event.PlayerID
	if not playerID then
		return
	end
	local player = PlayerResource:GetPlayer(playerID)
	if not player then
		return
	end

	web:SendRequest(
		"/api_sell_all_casino_items/",
		"POST",
		{ sid = tostring(PlayerResource:GetSteamID(playerID)) },
		function(res)
			if res.StatusCode ~= 200 or not res.Body then
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"casv2_sell_result",
					{ success = false, error = ERR_CONNECTION }
				)
				return
			end
			local response = safeJsonDecode(res.Body)
			if not response then
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"casv2_sell_result",
					{ success = false, error = ERR_SERVER }
				)
				return
			end
			if response.status == "error" then
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"casv2_sell_result",
					{ success = false, error = response.message or ERR_GENERIC }
				)
				return
			end
			CustomGameEventManager:Send_ServerToPlayer(player, "casv2_sell_result", buildSellClaimResponse(response))
		end
	)
end

function Casino:OnCasinoClaimAll(event)
	local playerID = event.PlayerID
	if not playerID then
		return
	end
	local player = PlayerResource:GetPlayer(playerID)
	if not player then
		return
	end

	web:SendRequest(
		"/api_claim_all_casino_items/",
		"POST",
		{ sid = tostring(PlayerResource:GetSteamID(playerID)) },
		function(res)
			if res.StatusCode ~= 200 or not res.Body then
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"casv2_claim_result",
					{ success = false, error = ERR_CONNECTION }
				)
				return
			end
			local response = safeJsonDecode(res.Body)
			if not response then
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"casv2_claim_result",
					{ success = false, error = ERR_SERVER }
				)
				return
			end
			if response.status == "error" then
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"casv2_claim_result",
					{ success = false, error = response.message or ERR_GENERIC }
				)
				return
			end
			if response.claimed_items and Shop and Shop.win_cas then
				for _, entry in ipairs(response.claimed_items) do
					local name = entry.item_name
					local count = tonumber(entry.count) or 1
					if name then
						Shop:win_cas({ itemname = name, PlayerID = playerID, count = count })
					end
				end
			end
			CustomGameEventManager:Send_ServerToPlayer(player, "casv2_claim_result", buildSellClaimResponse(response))
		end
	)
end

function Casino:OnCasinoClaimLevelReward(event)
	local playerID = event.PlayerID
	if not playerID then
		return
	end
	local player = PlayerResource:GetPlayer(playerID)
	if not player then
		return
	end
	local reward_id = event.reward_id
	if reward_id == nil then
		CustomGameEventManager:Send_ServerToPlayer(
			player,
			"casv2_level_reward_claimed",
			{ success = false, error = "#ui_casv2_error_reward_id_required" }
		)
		return
	end

	web:SendRequest(
		"/api_claim_level_reward/",
		"POST",
		{ sid = tostring(PlayerResource:GetSteamID(playerID)), reward_id = reward_id },
		function(res)
			if res.StatusCode ~= 200 or not res.Body then
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"casv2_level_reward_claimed",
					{ success = false, error = ERR_CONNECTION }
				)
				return
			end
			local response = safeJsonDecode(res.Body)
			if not response then
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"casv2_level_reward_claimed",
					{ success = false, error = ERR_SERVER }
				)
				return
			end
			if response.status == "error" then
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"casv2_level_reward_claimed",
					{ success = false, error = response.message or ERR_GENERIC }
				)
				return
			end
			CustomGameEventManager:Send_ServerToPlayer(player, "casv2_level_reward_claimed", {
				success = true,
				message = response.message or "",
				reward = response.reward,
				profile = response.profile,
			})
		end
	)
end