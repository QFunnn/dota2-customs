--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


WebApi = WebApi or {}
-- status: complete, untested

-- change this into provided dev key for testing in tools
WebApi.dev_key = ""

WebApi.custom_game = "Dota12v12"
WebApi.server_url = IsInToolsMode() and "http://127.0.0.1:5000/" or "https://api.12v12.dota2unofficial.com/"
WebApi.dedicated_key = IsInToolsMode() and WebApi.dev_key or GetDedicatedServerKeyV2("1")
WebApi.dedicated_key_v3 = IsInToolsMode() and WebApi.dev_key or GetDedicatedServerKeyV3("3")

function WebApi:GetMatchID()
	if WebApi._match_id then
		return WebApi._match_id
	end

	WebApi._match_id = IsInToolsMode() and RandomInt(-10000000, -1) or tonumber(tostring(GameRules:Script_GetMatchID()))

	return WebApi._match_id
end

function WebApi:Send(path, data, on_success_callback, on_error_callback, retry_while)
	local request = CreateHTTPRequest("POST", WebApi.server_url .. path)
	if not request then
		return
	end
	request:SetHTTPRequestHeaderValue("Dedicated-Server-Key", WebApi.dedicated_key)
	request:SetHTTPRequestHeaderValue("Dedicated-Server-Key-v3", WebApi.dedicated_key_v3)

	if data then
		data.mapName = GetMapName()
		data.customGame = WebApi.custom_game
		data.matchId = WebApi:GetMatchID()
		if IsInToolsMode() then
			DebugMessage("[WebApi] requesting", path)
			DeepPrintTable(data)
		end
		request:SetHTTPRequestRawPostBody("application/json", json.encode(data))
	end

	local request_start_time = GetSystemTimeMS()

	request:Send(function(response)
		local status_code = response.StatusCode
		local time_to_finish = GetSystemTimeMS() - request_start_time
		if status_code >= 200 and status_code <= 300 then
			DebugMessage("[WebApi] finished request to", path, status_code, "took", time_to_finish, "ms")
			local response_data = json.decode(response.Body)
			if on_success_callback then
				on_success_callback(response_data)
			end
		else
			DebugMessage("[WebApi] failed request, body:", response.Body, "took", time_to_finish, "ms")
			local error_data = response.Body and json.decode(response.Body) or {}

			if retry_while and retry_while() then
				WebApi:Send(path, data, on_success_callback, on_error_callback, retry_while)
			elseif on_error_callback then
				on_error_callback(error_data)
			end
		end
	end)
end

function WebApi:GetPlayerIdBySteamId(steam_id)
	return WebApi.steam_id_to_player_id[steam_id]
end

function WebApi:InitSteamIdTable()
	WebApi.steam_id_to_player_id = {}
	for player_id = 0, 24 do
		if PlayerResource:IsValidPlayerID(player_id) then
			local steam_id = tostring(PlayerResource:GetSteamID(player_id))
			if steam_id then
				WebApi.steam_id_to_player_id[steam_id] = player_id
			end
		end
	end
	print("Initialized steam ID table")
	DeepPrintTable(WebApi.steam_id_to_player_id)
end

function WebApi:ProcessMetadata(player_id, metadata)
	if not metadata then
		return
	end
	-- match event carries current player state (i.e. current currency instead of additional)
	if metadata.glory then
		WebPlayer:SetCurrency(player_id, tonumber(metadata.glory))
	end

	if metadata.items then
		for _, item in pairs(metadata.items) do
			WebInventory:AddItem(player_id, item)
		end
		WebInventory:UpdateClient(player_id)
	end

	if metadata.supporterState then
		local t = {
			tier = metadata.supporterState.level,
			end_date = metadata.supporterState.endDate,
			metadata = metadata.supporterState.metadata,
		}
		local ex_sub_tier = WebPlayer:GetSubscriptionTier(player_id)

		WebPlayer:SetSubscriptionStatus(player_id, t)

		if t.tier ~= ex_sub_tier then
			GamePerks:UpdateSupporterTier(player_id)
			Tips:UpdateClient(player_id)
		end
	end

	if metadata.bp_level then
		WebPlayer:SetLevel(player_id, metadata.bp_level)
	end

	if metadata.bp_exp then
		WebPlayer:SetCurrentExp(player_id, metadata.bp_exp)
	end

	if metadata.gift_codes then
		for _, code in pairs(metadata.gift_codes) do
			GiftCodes:AddGiftCode(player_id, code)
		end
		GiftCodes:UpdateClient(player_id)
	end

	if metadata.newRating and metadata.newRating[GetMapName()] then
		local player_stats = CustomNetTables:GetTableValue("game_state", "player_stats")
		if not player_stats then
			return
		end

		local player_id_string = tostring(player_id)
		if not player_stats[player_id_string] then
			return
		end
		if not player_stats[player_id_string].rating then
			return
		end

		player_stats[player_id_string].rating = metadata.newRating[GetMapName()]

		CustomNetTables:SetTableValue("game_state", "player_stats", player_stats)
	end

	WebPlayer:UpdateClient(player_id)
	BattlePass:UpdateClient(player_id)
end

--- Builds metadata table from reward definition (required since metadata by definition acts as a setter, rather than addendum)
---@param player_id number
---@param reward_data table
function WebApi:BuildMetadataFromReward(player_id, reward_data)
	local new_rewards = {
		currency = WebPlayer:GetCurrency(player_id) + (reward_data.currency or 0),
		items = {},
	}

	for item_name, count in pairs(reward_data.items or {}) do
		table.insert(new_rewards.items, {
			name = item_name,
			count = WebInventory:GetItemCount(player_id, item_name) + count,
		})
	end

	return new_rewards
end

RegisterGameEventListener("player_connect_full", function()
	if WebApi.before_match_sent then
		return
	end

	CustomNetTables:SetTableValue("game_state", "match_id", { match_id = WebApi:GetMatchID() })

	DebugMessage("Sending before-match request")
	WebApi:InitSteamIdTable()
	WebApi.before_match_sent = true
	WebApi:RequestBeforeMatch()

	WebApi.start_time_counter = GetSystemTimeMS()

	MatchEvents:ScheduleNextRequest()
end)