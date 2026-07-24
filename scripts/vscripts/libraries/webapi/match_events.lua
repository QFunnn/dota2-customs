--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


MatchEvents = MatchEvents or {}
MatchEvents.current_request_delay = MATCH_EVENT_DEFAULT_POLL_DELAY
MatchEvents.event_handlers = {}
-- status: complete, untested

function MatchEvents:ScheduleNextRequest()
	if MatchEvents.request_timer then Timers:RemoveTimer(MatchEvents.request_timer) end

	MatchEvents.request_timer = Timers:CreateTimer({
		useGameTime = false,
		endTime = MatchEvents.current_request_delay,
		callback = function() MatchEvents:SendRequest() end
	})
end


function MatchEvents:SendRequest()
	MatchEvents.request_timer = nil

	WebApi:Send(
		"api/lua/match/events",
		{
			match_id = WebApi:GetMatchID()
		},
		function(events)
			MatchEvents:ScheduleNextRequest()
			for _, event in ipairs(events or {}) do
				MatchEvents:HandleEvent(event)
			end
		end,
		function(err)
			print("[MatchEvents] failed request, rescheduling...")
			MatchEvents:ScheduleNextRequest()
		end
	)
end


function MatchEvents:HandleEvent(event)
	local handler = MatchEvents.event_handlers[event.event_type]

	if not handler then
		error("[Match Events] no handler for event of type " .. event.event_type)
	end

	handler(event)
end


function MatchEvents:SetActivePolling(status)
	if status then
		MatchEvents.current_request_delay = MATCH_EVENT_ACTIVE_POLL_DELAY
	else
		MatchEvents.current_request_delay = MATCH_EVENT_DEFAULT_POLL_DELAY
	end

	MatchEvents:ScheduleNextRequest()
end