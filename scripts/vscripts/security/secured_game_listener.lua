--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5a808f3 · 2026-08-08 04:09:05 UTC
  ~ auto-generated — do not edit
]]


GameListener = GameListener or {}

---@param eventName string
---@param callback fun(event: table)
---@return integer
function GameListener:SubscribeProtected(eventName, callback)
	return CustomGameEventManager:RegisterListener(eventName, function(_, event)
		if type(event) ~= "table" then
			return
		end

		local playerId = event["PlayerID"]
		local securityKey = event.security_key
		if type(playerId) ~= "number" or type(securityKey) ~= "string" then
			return
		end

		if not PlayerResource:IsValidPlayer(playerId) then
			return
		end

		if not Security:IsSecurityPlayerKeyValid(playerId, securityKey) then
			return
		end

		callback(event)
	end)
end