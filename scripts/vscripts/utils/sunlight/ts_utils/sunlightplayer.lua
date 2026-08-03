--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
SLPlayer = SLPlayer or {}
do
	--- 遍历有效玩家
	--
	-- @server
	function SLPlayer.ValidPlayerForEach(self, callback)
		do
			local playerID = 0
			while playerID <= DOTA_MAX_TEAM_PLAYERS do
				local player = PlayerResource:GetPlayer(playerID)
				if player then
					if callback(_G, playerID) == true then
						break
					end
				end
				playerID = playerID + 1
			end
		end
	end
	--- 通过steamID获取玩家ID
	--
	-- @param steamID
	-- @server
	function SLPlayer.GetPlayerIDBySteamID(self, steamID)
		do
			local i = 0
			while i <= 24 do
				local playerId = i
				local steamAccountID = PlayerResource:GetSteamAccountID(playerId)
				if steamID == steamAccountID then
					return playerId
				end
				i = i + 1
			end
		end
		return -steamID
	end
end