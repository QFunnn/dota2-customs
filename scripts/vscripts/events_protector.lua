--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


ProtectedCustomEvents = ProtectedCustomEvents or {}

function ProtectedCustomEvents:Init()
    if ProtectedCustomEvents.loaded then return end
	ProtectedCustomEvents.loaded = true
    ProtectedCustomEvents.allow_keys_reload = IsInToolsMode()
    ProtectedCustomEvents.client_keys = {}
    ProtectedCustomEvents.server_keys = {}
    ProtectedCustomEvents.load_listeners = {}
    CustomGameEventManager.RegisterListener_old = CustomGameEventManager.RegisterListener
    CustomGameEventManager.Send_ServerToPlayer_old = CustomGameEventManager.Send_ServerToPlayer

    CustomGameEventManager.RegisterListener = function(self, name, listener)
        return self:RegisterListener_old(name, function(player, data)
            if data.PlayerID == nil or data.n ~= ProtectedCustomEvents.client_keys[data.PlayerID] then
                return
            end
            return listener(player, data)
        end)
    end

    CustomGameEventManager.Send_ServerToPlayer = function(self, player, name, data)
        if player == nil or player:IsNull() then
            return
        end
        local server_key = ProtectedCustomEvents.server_keys[player:GetPlayerID()]
        if server_key ~= nil then
            data.n = server_key
            self:Send_ServerToPlayer_old(player, name, data)
        end
        data.n = nil
    end

    CustomGameEventManager.Send_ServerToAllClients = function(self, name, data)
        for playerID, server_key in pairs(ProtectedCustomEvents.server_keys) do
            local player = PlayerResource:GetPlayer(tonumber(playerID))
            if player ~= nil then
                data.n = server_key
                self:Send_ServerToPlayer_old(player, name, data)
            end
        end
        data.n = nil
    end

    CustomGameEventManager.Send_ServerToTeam = function(self, team, name, data)
        for playerID, server_key in pairs(ProtectedCustomEvents.server_keys) do
            local player = PlayerResource:GetPlayer(tonumber(playerID))
            if player ~= nil and player:GetTeam() == team then
                data.n = server_key
                self:Send_ServerToPlayer_old(player, name, data)
            end
        end
        data.n = nil
    end
end

CustomGameEventManager:RegisterListener("ok", function(_, data)
	local playerID = data.PlayerID
	if playerID == nil or type(data.n) ~= "number" then
		return
	end
	local player = PlayerResource:GetPlayer(playerID)
	if player == nil or player:IsNull() then
		return
	end

	local server_key = ProtectedCustomEvents.server_keys[playerID]
	local trigger_load = false
	if server_key ~= nil then
		if not ProtectedCustomEvents.allow_keys_reload then
			return
		end
	else
		server_key = RandomInt(0, math.pow(2, 30))
		ProtectedCustomEvents.server_keys[playerID] = server_key
		trigger_load = true
	end

	ProtectedCustomEvents.client_keys[playerID] = data.n
	CustomGameEventManager:Send_ServerToPlayer_old(player, "ok", {
		n = data.n,
		k = server_key
	})
	if trigger_load then
		for _, listener in pairs(ProtectedCustomEvents.load_listeners) do
			listener(player, playerID)
		end
	end
end)

function RegisterLoadListener(listener)
	table.insert(ProtectedCustomEvents.load_listeners, listener)
	for playerID, _ in pairs(ProtectedCustomEvents.server_keys) do
		local player = PlayerResource:GetPlayer(tonumber(playerID))
		if player ~= nil then
			listener(player, playerID)
		end
	end
end

ListenToGameEvent("player_disconnect", function(data)
	local playerID = data.PlayerID
	if playerID == nil then
		return
	end
	ProtectedCustomEvents.client_keys[playerID] = nil
	ProtectedCustomEvents.server_keys[playerID] = nil
end, nil)

ProtectedCustomEvents:Init()