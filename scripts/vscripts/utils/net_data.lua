--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


-- Private, incremental UI state. All writes are queued; only the frame pump sends events.
local Json = require("utils/json")
NetData = NetData or {}
NetData.MAX_BYTES_PER_FRAME = 8192 -- shared by ALL recipients, including JSON envelope + reserve
NetData.MAX_CHUNK_BYTES = 1024
NetData.EVENT_OVERHEAD_BYTES = 64

-- Keep Lua's numeric keys (including 0 and sparse item IDs) as JSON object keys,
-- matching the old net-table shape. Copies also isolate the diff baseline from callers.
local function copy(value)
	if type(value) ~= "table" then
		return value
	end
	local result = Json:newObject({})
	for key, entry in pairs(value) do
		result[tostring(key)] = copy(entry)
	end
	return result
end

local function diff(before, after, path, changes)
	if before == after then
		return
	end
	if type(before) == "table" and type(after) == "table" then
		for key, value in pairs(after) do
			path[#path + 1] = key
			diff(before[key], value, path, changes)
			path[#path] = nil
		end
		for key in pairs(before) do
			if after[key] == nil then
				path[#path + 1] = key
				diff(before[key], nil, path, changes)
				path[#path] = nil
			end
		end
	else
		local location = {}
		for i = 1, #path do
			location[i] = path[i]
		end
		changes[#changes + 1] = { p = location, v = after, d = after == nil and 1 or nil }
	end
end

function NetData:GetPlayerState(playerID)
	self.players = self.players or {}
	if not self.players[playerID] then
		self.players[playerID] = { data = Json:newObject({}), sent = {}, version = 0, serial = 0 }
	end
	return self.players[playerID]
end

function NetData:SetTableValue(playerID, name, key, value)
	assert(
		type(playerID) == "number" and PlayerResource:IsValidPlayerID(playerID),
		"NetData requires a valid recipient"
	)
	assert(type(name) == "string" and type(key) == "string", "NetData requires string namespace/key")
	local state = self:GetPlayerState(playerID)
	state.data[name] = state.data[name] or Json:newObject({})
	state.data[name][key] = copy(value)
	state.dirty = true
end

function NetData:GetTableValue(playerID, name, key)
	local state = self.players and self.players[playerID]
	return copy(state and state.data[name] and state.data[name][key])
end

function NetData:RequestSnapshot(params)
	local playerID = GetClientEventPlayerID(params)
	if playerID == nil or type(params.request) ~= "string" or #params.request > 64 or #params.request == 0 then
		return
	end
	local state = self:GetPlayerState(playerID)
	-- The client already switched tokens. Keep only its latest request, and
	-- stop the obsolete stream while the frame pump waits for the throttle.
	state.snapshotRequest = params.request
	state.ready = false
	state.pending = nil
end

function NetData:BuildMessage(state)
	if not state.dirty then
		return
	end
	local target = copy(state.data)
	local changes = {}
	if not state.full then
		diff(state.sent, target, {}, changes)
	end
	state.dirty = false
	if not state.full and #changes == 0 then
		return
	end
	state.serial = state.serial + 1
	local message = { version = state.serial, base = state.version, full = state.full and 1 or 0 }
	if state.full then
		message.data = target
	else
		message.changes = changes
	end
	local encoded = Json:encode(message)
	local chunks = {}
	local offset = 1
	-- A worst-case escaped byte needs six bytes in the event JSON envelope.
	local limit = math.min(self.MAX_CHUNK_BYTES, math.floor((self.MAX_BYTES_PER_FRAME - 512) / 6))
	assert(limit >= 4, "NetData frame budget is too small")
	while offset <= #encoded do
		local last = math.min(#encoded, offset + limit - 1)
		while last < #encoded and string.byte(encoded, last + 1) >= 128 and string.byte(encoded, last + 1) < 192 do
			last = last - 1
		end
		chunks[#chunks + 1] = string.sub(encoded, offset, last)
		offset = last + 1
	end
	state.pending = { chunks = chunks, index = 1, target = target, version = state.serial }
	state.full = false
end

function NetData:FlushFrame()
	local recipients = {}
	-- Real time keeps reconnect/recovery working while the game is paused.
	local now = Time()
	for playerID, state in pairs(self.players or {}) do
		local player = PlayerResource:GetPlayer(playerID)
		if not player or PlayerResource:GetConnectionState(playerID) ~= DOTA_CONNECTION_STATE_CONNECTED then
			state.ready = false
			state.pending = nil
			state.snapshotRequest = nil
		else
			if state.snapshotRequest and (not state.lastRequest or now - state.lastRequest >= 0.5) then
				state.lastRequest = now
				state.request = state.snapshotRequest
				state.snapshotRequest = nil
				state.ready = true
				state.full = true
				state.dirty = true
			end
			if state.ready then
				if not state.pending then
					self:BuildMessage(state)
				end
				if state.pending then
					recipients[#recipients + 1] = playerID
				end
			end
		end
	end
	table.sort(recipients)
	local budget = self.MAX_BYTES_PER_FRAME
	local start = 1
	for i = 1, #recipients do
		if recipients[i] > (self.lastRecipient or -1) then
			start = i
			break
		end
	end
	local misses = 0
	while #recipients > 0 and misses < #recipients do
		local playerID = recipients[start]
		local state = self.players[playerID]
		local pending = state.pending
		local sent = false
		if pending then
			local packet = {
				id = pending.version,
				index = pending.index,
				count = #pending.chunks,
				request = state.request,
				data = pending.chunks[pending.index],
			}
			local cost = #Json:encode(packet) + self.EVENT_OVERHEAD_BYTES
			if cost <= budget then
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "net_data", packet)
				budget = budget - cost
				self.lastRecipient = playerID
				pending.index = pending.index + 1
				if pending.index > #pending.chunks then
					state.sent = pending.target
					state.version = pending.version
					state.pending = nil
				end
				sent = true
			end
		end
		misses = sent and 0 or misses + 1
		start = start % #recipients + 1
	end
	return self.MAX_BYTES_PER_FRAME - budget
end

function NetData:Init()
	self.players = self.players or {}
	CustomUIEvent("net_data_request", function(_, params)
		self:RequestSnapshot(params)
	end)
	-- Exactly one named engine think; writes and snapshot requests never send directly.
	GameRules:GetGameModeEntity():SetContextThink("NetData.Flush", function()
		self:FlushFrame()
		return FrameTime()
	end, 0)
end

return NetData