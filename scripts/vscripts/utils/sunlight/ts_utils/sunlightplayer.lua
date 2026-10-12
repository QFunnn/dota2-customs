--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/sunlight/ts_utils/SunLightPlayer.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
____debugRuntime.register(
	"utils/sunlight/ts_utils/SunLightPlayer.lua",
	{
		["6"] = "1:11",
		["11"] = "6:5",
		["13"] = "7:18",
		["14"] = "7:42",
		["15"] = "8:19",
		["16"] = "9:17",
		["17"] = "10:21",
		["21"] = "7:79",
		["24"] = "6:5",
		["29"] = "22:5",
		["31"] = "23:18",
		["32"] = "23:25",
		["33"] = "24:19",
		["34"] = "25:19",
		["35"] = "26:17",
		["36"] = "27:17",
		["38"] = "23:34",
		["41"] = "31:9",
		["42"] = "22:5",
	}
)
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