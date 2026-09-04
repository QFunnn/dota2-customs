--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
--- 同一玩家的转镜头事件最短派发间隔（秒）。
local CAMERA_ORBIT_EVENT_COOLDOWN_SEC = 1
local lastCameraOrbitEventAtByPlayer = {}
local function getSyncMonitorPlayerLabel(self, player)
	if player == nil or player:IsNull() then
		return "unknown"
	end
	return tostring(player:GetPlayerID())
end
--- 转镜头是不可叠加的表现：相邻事件会互相覆盖客户端的镜头恢复状态。
-- 在服务端统一限流，保证客户端一秒内最多收到一次该事件。
local function shouldSendCameraOrbitEvent(self, player, eventName)
	if eventName ~= "s2c_enter_room_camera_orbit" then
		return true
	end
	local playerId = player:GetPlayerID()
	local now = GameRules:GetGameTime()
	local lastSentAt = lastCameraOrbitEventAtByPlayer[playerId]
	if lastSentAt ~= nil and now - lastSentAt < CAMERA_ORBIT_EVENT_COOLDOWN_SEC then
		return false
	end
	lastCameraOrbitEventAtByPlayer[playerId] = now
	return true
end
____exports.SyncNetTable = {}
local SyncNetTable = ____exports.SyncNetTable
do
	function SyncNetTable.SetTableValue(self, tableName, keyName, value)
		if __AK_NET_TABLE_RESOURCE_INDEX_ENABLED then
			if MyGameSyncMonitor ~= nil then
				MyGameSyncMonitor:RecordNativeNetTable(tostring(tableName), tostring(keyName), value)
			end
		end
		return CustomNetTables:SetTableValue(tableName, keyName, value)
	end
end
____exports.SyncGameEvent = {}
local SyncGameEvent = ____exports.SyncGameEvent
do
	function SyncGameEvent.Send_ServerToAllClients(self, eventName, eventData)
		if MyGameSyncMonitor ~= nil then
			MyGameSyncMonitor:RecordGameEvent(tostring(eventName), eventData, "all")
		end
		CustomGameEventManager:Send_ServerToAllClients(eventName, eventData)
	end
	function SyncGameEvent.Send_ServerToPlayer(self, player, eventName, eventData)
		if not shouldSendCameraOrbitEvent(nil, player, eventName) then
			return
		end
		if MyGameSyncMonitor ~= nil then
			MyGameSyncMonitor:RecordGameEvent(
				tostring(eventName),
				eventData,
				"player_" .. getSyncMonitorPlayerLabel(nil, player)
			)
		end
		CustomGameEventManager:Send_ServerToPlayer(player, eventName, eventData)
	end
	function SyncGameEvent.Send_ServerToTeam(self, team, eventName, eventData)
		if MyGameSyncMonitor ~= nil then
			MyGameSyncMonitor:RecordGameEvent(tostring(eventName), eventData, "team_" .. tostring(team))
		end
		CustomGameEventManager:Send_ServerToTeam(team, eventName, eventData)
	end
end
return ____exports