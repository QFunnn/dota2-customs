--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "framework/game_event"
if GameEventListenerIDs == nil then
	GameEventListenerIDs = {}
end
if CustomUIEventListenerIDs == nil then
	CustomUIEventListenerIDs = {}
end
function GameEvent(b, c, d)
	local e = ListenToGameEvent(b, c, d)
	GameEventListenerIDs[#GameEventListenerIDs + 1] = e
	return e
end
function StopGameEvent(e)
	for f = #GameEventListenerIDs - 1, 0, -1 do
		local g = GameEventListenerIDs[f + 1]
		if g == e then
			table.remove(GameEventListenerIDs, f + 1)
			StopListeningToGameEvent(e)
		end
	end
end
function CustomUIEvent(b, c, d)
	local e = CustomGameEventManager:RegisterListener(b, function(h, ...)
		local i = { ... }
		local j = EntIndexToHScript(h)
		if not IsValid(j) then
			return
		end
		local k = j:GetPlayerID()
		if not PlayerResource:IsValidPlayerID(k) then
			return
		end
		local l = i[1]
		if l == nil then
			return
		end
		l.PlayerID = k
		if d ~= nil then
			return c(d, unpack(i))
		end
		return c(unpack(i))
	end)
	CustomUIEventListenerIDs[#CustomUIEventListenerIDs + 1] = e
	return e
end
function StopCustomUIEvent(e)
	for f = #CustomUIEventListenerIDs - 1, 0, -1 do
		local g = CustomUIEventListenerIDs[f + 1]
		if g == e then
			table.remove(CustomUIEventListenerIDs, f + 1)
		end
	end
	CustomGameEventManager:UnregisterListener(e)
end
function RequestEvent(b, c, d)
	if Request ~= nil then
		if IsServer() then
			Request:RegisterServerEvent(b, c, d)
		else
			Request:RegisterClientEvent(b, c, d)
		end
	end
end