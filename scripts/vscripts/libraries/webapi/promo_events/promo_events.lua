--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


WebPromoEvents = WebPromoEvents or {}

local PROMO_EVENTS_DATA = require("libraries/webapi/promo_events/events_declaration")

-- collect active events
-- request event data for active events once we're in appropriate game state
-- also have to process already redeemed rewards
-- send to clients and wait for claims


function WebPromoEvents:Init()
	WebPromoEvents.active_events = {}
	WebPromoEvents.fetched_data = {}

	WebPromoEvents.claimed_tasks = {}
	WebPromoEvents.__claim_lock = {}

	WebPromoEvents.__fetch_timing = {}

	EventStream:Listen("WebPromoEvents:get_data", WebPromoEvents.SendDataEvent, WebPromoEvents)
	EventStream:Listen("WebPromoEvents:claim", WebPromoEvents.ClaimRewardEvent, WebPromoEvents)

	EventDriver:Listen("Events:state_changed", function(event)
		if event.state < DOTA_GAMERULES_STATE_PRE_GAME then return end
		if not WebApi.__before_match_loaded then print("[WebPromoEvents] skipping init - BeforeMatch failed!") end

		if WebPromoEvents.__requested_event_data then return end
		WebPromoEvents.__requested_event_data = true

		WebPromoEvents:RequestEventData()
	end)

	WebPromoEvents:IndexEvents()
end


function WebPromoEvents:IndexEvents()
	for event_id, event_data in pairs(PROMO_EVENTS_DATA) do
		local is_ongoing = DateOlder(GetSystemDate(), event_data.ends_at)
		local is_active = event_data.active and is_ongoing
		local has_start_date = event_data.started_at and event_data.started_at ~= "" and DateOlder(event_data.started_at, GetSystemDate())
		local has_tasks_defined = table.count(event_data.tasks or {}) > 0

		-- print("checking start date:", event_data.started_at, GetSystemDate(), DateOlder(event_data.started_at, GetSystemDate()))

		if is_active and is_ongoing and has_start_date and has_tasks_defined then
			WebPromoEvents.active_events[event_id] = event_data
		else
			print("[WebPromoEvents] event is deemed inactive: ", event_id, is_ongoing, is_active, has_start_date, has_tasks_defined)
		end
	end
end


function WebPromoEvents:SetClaimsData(player_id, claims)
	for _, claim in pairs(claims) do
		WebPromoEvents:AddClaim(player_id, claim[1], claim[2])
	end
end


function WebPromoEvents:AddClaim(player_id, event_id, task_id)
	WebPromoEvents.claimed_tasks[player_id] = WebPromoEvents.claimed_tasks[player_id] or {}
	WebPromoEvents.claimed_tasks[player_id][event_id] = WebPromoEvents.claimed_tasks[player_id][event_id] or {}
	WebPromoEvents.claimed_tasks[player_id][event_id][task_id] = true

	print("[WebPromoEvents] marking claimed: ", player_id, event_id, task_id)
end


function WebPromoEvents:IsClaimed(player_id, event_id, task_id)
	return WebPromoEvents.claimed_tasks[player_id] and WebPromoEvents.claimed_tasks[player_id][event_id] and WebPromoEvents.claimed_tasks[player_id][event_id][task_id]
end


function WebPromoEvents:ClaimRewardEvent(event)
	local player_id = event.PlayerID
	if not IsValidPlayerID(player_id) then return end
	local event_id = event.promo_event_id
	local task_id = event.task_id

	if not event_id or not task_id then return end
	if not WebPromoEvents.active_events[event_id] then return end
	if not WebPromoEvents.fetched_data[event_id] then return end
	if WebPromoEvents.__claim_lock[player_id] then
		DisplayError(player_id, "#dota_hud_error_promo_claim_in_progress")
		return
	end

	local task_data = PROMO_EVENTS_DATA[event_id].tasks[task_id]
	if not task_data then return end

	WebPromoEvents.__claim_lock[player_id] = true
	local steam_id = tostring(PlayerResource:GetSteamID(player_id))

	local target = task_data.target
	local reported_progress = WebPromoEvents.fetched_data[event_id][steam_id][task_id]

	print("[WebPromoEvents] claim progress: ", target, reported_progress)
	if reported_progress < target then return end

	if WebPromoEvents:IsClaimed(player_id, event_id, task_id) then DebugMessage("Player", player_id, "already redeemed event", event_id, task_id) return end

	WebApi:Send(
		"api/lua/promo/events/claim",
		{
			event_id = event_id,
			steam_id = steam_id,
			claim_id = task_id,
			claim_rewards = task_data.rewards or {}
		},
		function(response)
			WebPromoEvents.__claim_lock[player_id] = false
			DebugMessage("[WebPromoEvents] successfully claimed reward in event ", event_id, " - ", task_id)
			DeepPrintTable(response)
			-- notify client of it (toast or w/e?) and update client state

			WebApi:ProcessMetadata(player_id, response)
			WebPromoEvents:AddClaim(player_id, event_id, task_id)

			WebPromoEvents:UpdateClient(player_id)
		end,
		function(err)
			WebPromoEvents.__claim_lock[player_id] = false
			DebugMessage("[WebPromoEvents] failed to claim rewards: ", event_id, task_id)
		end
	)
end


function WebPromoEvents:RequestEventData()
	-- is only requested if before-match is successful
	local steam_ids = WebApi:GetPlayersSteamIDs()

	print("[WebPromoEvents] RequestEventData")

	for event_id, event_data in pairs(WebPromoEvents.active_events) do
		WebPromoEvents.__fetch_timing[event_id] = GetSystemTimeMS()
		print("[WebPromoEvents] requesting event id", event_id)

		WebApi:Send(
			"api/lua/promo/events/fetch_data",
			{
				event_id = event_id,
				started_at = event_data.started_at,
				target_custom_game = event_data.custom_game,
				steam_ids = steam_ids,
				tasks_ids = table.make_key_table(event_data.tasks or {})
			},
			function(response)
				-- response contains progress for every player in requested event ID
				DebugMessage("[WebPromoEvents] fetched data for event: ", event_id, "; took: ", GetSystemTimeMS() - WebPromoEvents.__fetch_timing[event_id], "ms")
				DeepPrintTable(response)
				WebPromoEvents.fetched_data[event_id] = response.event_data

				WebPromoEvents:UpdateUnclamedStatus()

				for player_id = 0, 23 do
					if IsValidPlayerID(player_id) then
						WebPromoEvents:UpdateClient(player_id)
					end
				end
			end,
			function(err)
				DebugMessage("[WebPromoEvents] FAILED to fetch data for event: ", event_id)
				WebPromoEvents.fetched_data[event_id] = {
					error = "data_fetch_failed"
				}

				WebPromoEvents:UpdateUnclamedStatus()
			end
		)
	end
end


function WebPromoEvents:UpdateUnclamedStatus()
	local fetched_count = table.count(WebPromoEvents.fetched_data)
	local expected_count = table.count(WebPromoEvents.active_events)

	if fetched_count < expected_count then
		DebugMessage("[WebPromoEvents] received unclaimed update, waiting till all events are fetched:", fetched_count, "/", expected_count)
		return
	end

	DebugMessage("[WebPromoEvents] all events have been pulled, verifying claims")

	local has_unclaimed_rewards = {}

	for event_id, event_data in pairs(WebPromoEvents.fetched_data) do
		if not event_data.error then
			for steam_id, player_progress in pairs(event_data) do
				local player_id = WebApi:GetPlayerIdBySteamId(steam_id)

				for task_id, progress_value in pairs(player_progress) do
					local is_claimed = WebPromoEvents:IsClaimed(player_id, event_id, task_id)
					local task_data = PROMO_EVENTS_DATA[event_id].tasks[task_id]

					if task_data and task_data.target and progress_value >= task_data.target and not is_claimed then
						has_unclaimed_rewards[player_id] = true
						DebugMessage("[WebPromoEvents] player", player_id)
					end
				end
			end
		end
	end

	for player_id, _ in pairs(has_unclaimed_rewards) do
		Toasts:NewForPlayer(player_id, "promo_claim_available", {})
	end
end


function WebPromoEvents:SendDataEvent(event)
	local player_id = event.PlayerID

	WebPromoEvents:UpdateClient(player_id)
end


function WebPromoEvents:UpdateClient(player_id)
	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	local steam_id = tostring(PlayerResource:GetSteamID(player_id))
	local player_event_data = {}

	-- transform data to client view
	for event_id, event_data in pairs(WebPromoEvents.fetched_data) do
		if event_data.error then
			WebPromoEvents.active_events[event_id] = nil
			-- do we want to somehow show that we failed to show the data for this event? not sure!
		else
			local player_progress = event_data[steam_id]
			if player_progress then
				player_event_data[event_id] = {}

				for task_id, progress_value in pairs(player_progress) do
					player_event_data[event_id][task_id] = {
						progress = progress_value,
						claimed = WebPromoEvents:IsClaimed(player_id, event_id, task_id)
					}
				end
			end
		end
	end

	print("[WebPromoEvents] updating client")
	print("\tactive events:")
	DeepPrintTable(WebPromoEvents.active_events)
	print("\tplayer data:")
	DeepPrintTable(player_event_data)

	CustomGameEventManager:Send_ServerToPlayer(player, "WebPromoEvents:update", {
		active_events = WebPromoEvents.active_events,
		player_event_data = player_event_data,
	})
end


WebPromoEvents:Init()