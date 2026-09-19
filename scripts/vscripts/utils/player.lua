--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---Возвращает SteamId игрока
---@param playerId integer
---@return string
function GetSteamID(playerId)
	local playerSteamId = tostring(PlayerResource:GetSteamAccountID(playerId))
	if playerSteamId == "0" then
		playerSteamId = tostring(80000000 + playerId)
	end
	return playerSteamId
end