--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


EventStream = EventStream or {}

-- after 15 seconds, event token is "forgotten"
TOKEN_TIMEOUT = 15


function EventStream:Init()
	for _, listener_id in ipairs(EventStream.listeners or {}) do
		CustomGameEventManager:UnregisterListener(listener_id)
	end

	EventStream.listeners = {}
	EventStream.accepted_events = {}

	if EventStream.cleanup_timer then Timers:RemoveTimer(EventStream.cleanup_timer) end

	EventStream.cleanup_timer = Timers:CreateTimer(60, function()
		EventStream:PurgeAcceptedEvents()
		return 1
	end)
end


function EventStream:AcknowledgeEvent(user_id, event_name, args)
	local player = EntIndexToHScript(user_id)
	if not IsValidEntity(player) then print(event_name, "received with invalid user ID: ", user_id) return end
	-- inform client that server acknowledged this event, and resend schedule can be cancelled
	CCustomGameEventManager:Send_ServerToPlayer(player, "EventStream:ack", {
		ack_id = args._id
	})
end


function EventStream:Listen(event_name, callback, context)
	if not callback then
		error("Invalid / nil callback passed in EventStream:Listen")
		return
	end

	local listener_id = CustomGameEventManager:RegisterListener(event_name, function(user_id, args)
		-- if not IsValidPlayerID(args.PlayerID) then print(event_name, "received with invalid player ID!") return end

		-- print("[Event Stream] incoming event", event_name)
		-- DebugMessage("[Event Stream] incoming event", event_name, "from", user_id, IsValidEntity(EntIndexToHScript(user_id)))

		if args._id then
			-- we have already received this event - discarding
			if EventStream.accepted_events[args._id] then
				print(GameRules:GetGameTime(), "[Event Stream] received duplicate event", event_name, "discading!")
				EventStream:AcknowledgeEvent(user_id, event_name, args)
				return
			end
		else
			print("[Event Stream] NO EVENT TOKEN IN PAYLOAD FOR EVENT", event_name)
			DeepPrintTable(args or {})
		end

		if context then
			ErrorTracking.Try(callback, context, args, user_id)
		else
			ErrorTracking.Try(callback, args, user_id)
		end

		if args._id then
			-- saving after processing, for cases where callback affects global state (i.e. ProtectedCustomEvents)
			EventStream.accepted_events[args._id] = GameRules:GetGameTime() + TOKEN_TIMEOUT
			print(GameRules:GetGameTime(), "[Event Stream] recorded new event token", args._id)

			EventStream:AcknowledgeEvent(user_id, event_name, args, true)
		end
	end)

	table.insert(EventStream.listeners, listener_id)
end


function EventStream:PurgeAcceptedEvents()
	local time = GameRules:GetGameTime()
	for token, expire_time in pairs(EventStream.accepted_events or {}) do
		if expire_time < time then
			EventStream.accepted_events[token] = nil
			print("[Event Stream] event token", token, "expired")
		end
	end
end


EventStream:Init()