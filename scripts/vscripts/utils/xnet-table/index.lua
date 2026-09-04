--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ArrayUnshift = ____lualib.__TS__ArrayUnshift
local __TS__StringSubstring = ____lualib.__TS__StringSubstring
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____tstl_2Dutils = require("utils.tstl-utils")
local reloadable = ____tstl_2Dutils.reloadable
local ____Sync = require("modules.Sync")
local SyncGameEvent = ____Sync.SyncGameEvent
local function get_table_size(self, t)
	if type(t) ~= "table" then
		return #tostring(t)
	end
	local size = 0
	for k, v in pairs(t) do
		size = size + get_table_size(nil, k) + get_table_size(nil, v)
	end
	return size
end
--- A module that uses events to simulate a network table, primarily intended to implement the
-- functionality of Valve's official `CustomNetTables`
-- as described at: https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Custom_Nettables
-- The main purpose is to overcome the 2MB limit of the network table and allow for transmission of larger data sets.
-- It should be noted that sending events takes up server frame time, so for very large data sets
-- they will be split up and sent separately before being reassembled.
-- For small, frequently updated data in-game, it is still recommended to
-- use the native CustomNetTables to avoid affecting network performance.
--
-- 一个使用事件来模拟网表的模块，其主要目的是为了实现官方的 `CustomNetTables` 的功能
-- 具体见：https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Custom_Nettables
-- 主要目的是为了突破网表的2MB的限制，用以实现更大的数据传输。
-- 需要注意的是，发送事件需要占用服务器帧时间，所以对于特别大的数据将会拆分后发送再组合。
-- 游戏中的小体积高频数据同步，依然推荐使用原生的CustomNetTables，以避免影响网络性能。
--
-- @export
-- @class XNetTable
-- @license MIT
____exports.XNetTable = __TS__Class()
local XNetTable = ____exports.XNetTable
XNetTable.name = "XNetTable"
function XNetTable.prototype.____constructor(self)
	self.MTU = 1024 * 64
	self._data = {}
	self._player_data = {}
	self._data_queue = {}
	self._last_update_time_mark = {}
	print("[XNetTable] Activated")
	self:_startHeartbeat()
	ListenToGameEvent("player_connect_full", function(____, keys)
		return self:_onPlayerConnectFull(keys)
	end, self)
end
function XNetTable.prototype.Reload(self)
	print("[XNetTable] Reloaded")
end
function XNetTable.prototype.SetTableValue(self, tname, key, value)
	if not IsServer() then
		return
	end
	local key_name = tostring(key)
	local ____self__data_0, ____tname_1 = self._data, tname
	if ____self__data_0[____tname_1] == nil then
		____self__data_0[____tname_1] = {}
	end
	value = value or {}
	self._data[tname][key_name] = value
	if MyGameSyncMonitor ~= nil then
		MyGameSyncMonitor:RecordXNetTableValue(tostring(tname), key_name, value, "all")
	end
	self:_appendUpdateRequest(nil, tname, key_name, value)
end
function XNetTable.prototype.SetPlayerTableValue(self, playerId, tname, key, value)
	if not IsServer() then
		return
	end
	local key_name = tostring(key)
	local ____self__player_data_4, ____playerId_5 = self._player_data, playerId
	if ____self__player_data_4[____playerId_5] == nil then
		____self__player_data_4[____playerId_5] = {}
	end
	local ____self__player_data_playerId_6, ____tname_7 = self._player_data[playerId], tname
	if ____self__player_data_playerId_6[____tname_7] == nil then
		____self__player_data_playerId_6[____tname_7] = {}
	end
	value = value or {}
	self._player_data[playerId][tname][key_name] = value
	if MyGameSyncMonitor ~= nil then
		MyGameSyncMonitor:RecordXNetTableValue(tostring(tname), key_name, value, "player_" .. tostring(playerId))
	end
	self:_appendUpdateRequest(playerId, tname, key_name, value)
end
function XNetTable.prototype._appendUpdateRequest(self, playerId, tname, key, value)
	local k = tostring(key)
	local size = get_table_size(nil, value)
	local mark_name = (((tostring(playerId or "all") .. ".") .. tname) .. ".") .. k
	local now = GameRules:GetGameTime()
	local last_update_time = self._last_update_time_mark[mark_name] or 0
	if now == last_update_time then
		print(
			("[XNetTable] " .. mark_name)
				.. "同一帧执行了多次更新，建议优化代码，一帧最多只更新一次，本次更新照常执行"
		)
	end
	self._last_update_time_mark[mark_name] = now
	if size < self.MTU then
		local ____self__data_queue_10 = self._data_queue
		____self__data_queue_10[#____self__data_queue_10 + 1] =
			{ target = playerId, data_length = size, data = { table_name = tname, key = k, content = value } }
	else
		local data = self:_prepareDataChunks(tname, k, value)
		do
			local i = 0
			while i < #data do
				self:_insertDataToQueue(data[i + 1], playerId)
				i = i + 1
			end
		end
	end
end
function XNetTable.prototype._insertDataToQueue(self, data, playerId, positively)
	local size = get_table_size(nil, data)
	if positively then
		__TS__ArrayUnshift(self._data_queue, { target = playerId, data_length = size, data = data })
	else
		local ____self__data_queue_11 = self._data_queue
		____self__data_queue_11[#____self__data_queue_11 + 1] = { target = playerId, data_length = size, data = data }
	end
end
function XNetTable.prototype._prepareDataChunks(self, tname, key, value)
	local data = self:_encodeTable({ table = tname, key = key, value = value })
	local chunks = {}
	local chunk_size = self.MTU - 2
	local unique_id = DoUniqueString("")
	local data_length = string.len(data)
	if data_length > chunk_size then
		local chunk_count = math.ceil(data_length / chunk_size)
		do
			local i = 0
			while i < chunk_count do
				local chunk = __TS__StringSubstring(data, i * chunk_size, (i + 1) * chunk_size)
				chunk = (((((("#" .. unique_id) .. "#") .. tostring(chunk_count)) .. "#") .. tostring(i)) .. "#")
					.. chunk
				chunks[#chunks + 1] = chunk
				i = i + 1
			end
		end
	else
		chunks[#chunks + 1] = data
	end
	return chunks
end
function XNetTable.prototype._encodeTable(self, t)
	return json.encode(t)
end
function XNetTable.prototype._onPlayerConnectFull(self, keys)
	local playerId = keys.PlayerID
	local player = PlayerResource:GetPlayer(playerId)
	if player == nil then
		return
	end
	for tname in pairs(self._data) do
		for key in pairs(self._data[tname]) do
			self:_appendUpdateRequest(playerId, tname, key, self._data[tname][key])
		end
	end
	if self._player_data[playerId] == nil then
		return
	end
	for tname in pairs(self._player_data[playerId]) do
		do
			local ____table = self._player_data[playerId][tname]
			if ____table == nil then
				goto __continue32
			end
			for key in pairs(____table) do
				self:_appendUpdateRequest(playerId, tname, key, ____table[key])
			end
		end
		::__continue32::
	end
end
function XNetTable.prototype._startHeartbeat(self)
	Timers:CreateTimer(function()
		local data_sent_length = 0
		while #self._data_queue > 0 do
			if data_sent_length > self.MTU then
				return FrameTime()
			end
			local data = table.remove(self._data_queue, 1)
			if data == nil then
				return FrameTime()
			end
			local content = data.data
			local content_length = data.data_length
			local target = data.target
			data_sent_length = data_sent_length + content_length
			if target == nil or target == -1 then
				if MyGameSyncMonitor ~= nil then
					MyGameSyncMonitor:RecordXNetTable("x_net_table", content_length, "all")
				end
				SyncGameEvent:Send_ServerToAllClients("x_net_table", { data = content })
			else
				local player = PlayerResource:GetPlayer(target)
				if player ~= nil and not player:IsNull() then
					if MyGameSyncMonitor ~= nil then
						MyGameSyncMonitor:RecordXNetTable("x_net_table", content_length, "player_" .. tostring(target))
					end
					SyncGameEvent:Send_ServerToPlayer(player, "x_net_table", { data = content })
				end
			end
		end
		return FrameTime()
	end)
end
XNetTable = __TS__DecorateLegacy({ reloadable }, XNetTable)
____exports.XNetTable = XNetTable
return ____exports