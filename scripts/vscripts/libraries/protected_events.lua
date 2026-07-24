--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


ProtectedCustomEvents = ProtectedCustomEvents or {}

-- This library inject auth token(unique for each connection) into every custom event to autentificate events sended from server
-- Clients reject events that doesn't contain that token and thus prevent cheats that use GameEvents.SendCustomGameEventToClient
-- Token sends to server by client after connection on UI initialization phase

function ProtectedCustomEvents:Init()
	-- reload protection, to avoid function override self-referencing
	if ProtectedCustomEvents.loaded then return end
	ProtectedCustomEvents.loaded = true
	-- tokens are stored by user id (entity index of player instance)
	ProtectedCustomEvents.player_tokens = {}

	EventStream:Listen("ProtectedEvents:set_token", ProtectedCustomEvents.SetToken)

	CCustomGameEventManager.Send_ServerToPlayerEngine = CCustomGameEventManager.Send_ServerToPlayer
	CCustomGameEventManager.Send_ServerToTeamEngine = CCustomGameEventManager.Send_ServerToTeam
	CCustomGameEventManager.Send_ServerToAllClientsEngine = CCustomGameEventManager.Send_ServerToAllClients

	CCustomGameEventManager.Send_ServerToPlayer = ProtectedCustomEvents.SendToPlayer
	CCustomGameEventManager.Send_ServerToTeam = ProtectedCustomEvents.SendToTeam
	CCustomGameEventManager.Send_ServerToAllClients = ProtectedCustomEvents.SendToAllClients

	print("[ProtectedCustomEvents] init finished")
end


-- note . used here - essentially means class method, that doesn't expect `self` (and won't have it defined) when called
function ProtectedCustomEvents.SetToken(event, user_id)
	print("[ProtectedCustomEvents] Set Token", user_id, event.token)
	if user_id == -1 then return end
	ProtectedCustomEvents.player_tokens[user_id] = event.token
end


function ProtectedCustomEvents:SendToPlayer(player, event_name, event_data)
	-- print("[ProtectedCustomEvents] SendToPlayer", player, event_name, event_data)
	if not player or player:IsNull() then
		print("[ProtectedCustomEvents] Send_ServerToPlayer: invalid player entity")
		return
	end

	local player_id = player:GetPlayerID()
	local entindex = player:GetEntityIndex()

	local new_table = {
		event_data = event_data
	}

	if ProtectedCustomEvents.player_tokens[entindex] then
		new_table.protected_token = ProtectedCustomEvents.player_tokens[entindex]
	elseif player_id ~= -1 and not PlayerResource:IsFakeClient(player_id) then
		print("[ProtectedCustomEvents] No secret token for player " .. player_id .. ", entindex " .. entindex)
	end

	CustomGameEventManager:Send_ServerToPlayerEngine(player, event_name, new_table)
end


function ProtectedCustomEvents:SendToTeam(team, event_name, event_data)
	for entindex = 1, DOTA_MAX_PLAYERS do -- Possible entity indexes of players, including spectators
		local player = EntIndexToHScript(entindex)
		if player and not player:IsNull() and player:GetTeam() == team then
			CustomGameEventManager:Send_ServerToPlayer(player, event_name, event_data)
		end
	end
end


function ProtectedCustomEvents:SendToAllClients(event_name, event_data)
	for entindex = 1, DOTA_MAX_PLAYERS do -- Possible entity indexes of players, including spectators
		local player = EntIndexToHScript(entindex)
		if player and not player:IsNull() then
			CustomGameEventManager:Send_ServerToPlayer(player, event_name, event_data)
		end
	end
end


ProtectedCustomEvents:Init()