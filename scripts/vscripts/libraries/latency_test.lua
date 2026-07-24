--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LATENCY_TEST_ENABLED = false
LATENCY_TEST_AMOUNT = 0.5

if not LATENCY_TEST_ENABLED then return end

local old_register_listener = CustomGameEventManager.RegisterListener
CustomGameEventManager.RegisterListener = function(self, name, callback)
	old_register_listener(self, name, function (_, event)
		Timers:CreateTimer(LATENCY_TEST_AMOUNT, function ()
			callback(_, event)
		end)
	end)
end

local old_server_to_player = CustomGameEventManager.Send_ServerToPlayer
CustomGameEventManager.Send_ServerToPlayer = function(self, player, name, data)
	Timers:CreateTimer(LATENCY_TEST_AMOUNT, function ()
		old_server_to_player(self, player, name, data)
	end)
end

local old_server_to_team = CustomGameEventManager.Send_ServerToTeam
CustomGameEventManager.Send_ServerToTeam = function(self, team, name, data)
	Timers:CreateTimer(LATENCY_TEST_AMOUNT, function ()
		old_server_to_team(self, team, name, data)
	end)
end

local old_server_to_all_clients = CustomGameEventManager.Send_ServerToAllClients
CustomGameEventManager.Send_ServerToAllClients = function(self, name, data)
	Timers:CreateTimer(LATENCY_TEST_AMOUNT, function ()
		old_server_to_all_clients(self, name, data)
	end)
end