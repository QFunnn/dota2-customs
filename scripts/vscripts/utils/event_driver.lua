--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


EventDriver = EventDriver or class({})


function EventDriver:Init()
	EventDriver.serverside_events = {}
end

function EventDriver:Dispatch(event_name, args_tbl)
	if not event_name then
		logger:Log("[Event Driver] no event name in dispatch")
		return
	end
	local callbacks = EventDriver.serverside_events[event_name]
	if not callbacks then
		logger:Log("[Event Driver] no callback in dispatch")
		return
	end
	for id, callback_info in pairs(callbacks) do
		if not callback_info[1] then
			logger:Log("[Event Driver] WARNING: callback of event", event_name, "at id", id,
				"is deleted! Unsubscribing...")
			EventDriver:CancelListener(event_name, id)
		else
			if callback_info[2] then
				if not callback_info[2].IsNull or not callback_info[2]:IsNull() then
					xpcall(function()
							return callback_info[1](callback_info[2], args_tbl)
						end,
						function(err)
							logger:Log("[Event Driver] Error in callback of event", event_name, "at id", id, ":", err)
						end)
				else
					EventDriver:CancelListener(event_name, id)
				end
			else
				xpcall(function()
						return callback_info[1](args_tbl)
					end,
					function(err)
						logger:Log("[Event Driver] Error in callback of event", event_name, "at id", id, ":", err)
					end)
			end
		end
	end
end

function EventDriver:CancelListener(event_name, listener_id)
	local event_callbacks = EventDriver.serverside_events[event_name]
	if event_callbacks and event_callbacks[listener_id] then
		event_callbacks[listener_id] = nil
	end
end

EventDriver:Init()