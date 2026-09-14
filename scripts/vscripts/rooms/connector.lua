--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


if Connector == nil then
	_G.Connector = class({})
end

Connector.SETTLE_SEC = 4
Connector.FALLBACK_SEC = 999999
Connector.MAX_ERRORS = 999999
Connector.HOST_DELAY = 1.5
Connector.RETRY_SEC = 5

function Connector:Init()
	self.address = nil
	self.request_in_flight = false
	self.fallback_done = false
	self.started_at = Time()
	self.errors = 0
	self.sent = {}
	self.host_pid = nil
	self.settle = nil

	GameRules:SetCustomGameSetupAutoLaunchDelay(-1)
	GameRules:SetCustomGameSetupTimeout(-1)
	GameRules:SetCustomGameSetupRemainingTime(9999)
	self:SetStatus("waiting")

	for pid = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if self:IsHuman(pid) and self.host_pid == nil then
			self.host_pid = pid
		end
	end

	ListenToGameEvent("player_connect_full", function(e)
		if not e or e.PlayerID == nil or e.PlayerID < 0 then
			return
		end
		if PlayerResource:IsFakeClient(e.PlayerID) then
			return
		end
		if self.host_pid == nil then
			self.host_pid = e.PlayerID
		end
		if self.address then
			self:Request()
		else
			self:Schedule()
		end
	end, nil)

	self:Schedule()
end

function Connector:IsHuman(pid)
	return PlayerResource:IsValidPlayer(pid)
		and not PlayerResource:IsFakeClient(pid)
		and PlayerResource:GetConnectionState(pid) == DOTA_CONNECTION_STATE_CONNECTED
end

function Connector:SetStatus(state, extra)
	local t = { state = state, updated = Time() }
	for k, v in pairs(extra or {}) do
		t[k] = v
	end
	CustomNetTables:SetTableValue("server", "connector", t)
end

function Connector:Sids()
	local sids, pids = {}, {}
	for pid = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if self:IsHuman(pid) then
			local sid = tostring(PlayerResource:GetSteamID(pid))
			if sid ~= "0" and sid ~= "" then
				table.insert(sids, sid)
				table.insert(pids, pid)
			end
		end
	end
	return sids, pids
end

function Connector:Schedule()
	if self.address or self.fallback_done then
		return
	end
	if self.settle then
		Timers:RemoveTimer(self.settle)
	end
	self.settle = Timers:CreateTimer({
		endTime = self.SETTLE_SEC,
		useGameTime = false,
		callback = function()
			self.settle = nil
			self:Request()
		end,
	})
end

function Connector:Request()
	if self.fallback_done or self.request_in_flight then
		return
	end
	local sids = self:Sids()
	if #sids == 0 then
		return
	end
	if Time() - self.started_at > self.FALLBACK_SEC then
		return self:Fallback("timeout")
	end

	local host_sid = sids[1]
	if self.host_pid ~= nil and self:IsHuman(self.host_pid) then
		host_sid = tostring(PlayerResource:GetSteamID(self.host_pid))
	end

	self.request_in_flight = true
	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_room_allocate/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", json.encode({ sids = sids, host_sid = host_sid }))
	req:SetHTTPRequestAbsoluteTimeoutMS(10000)
	req:Send(function(res)
		self.request_in_flight = false
		local ok, data = pcall(json.decode, res.Body or "")
		if res.StatusCode ~= 200 or not ok or type(data) ~= "table" then
			self.errors = self.errors + 1
			print("[Connector] allocate failed: http " .. tostring(res.StatusCode) .. " (" .. self.errors .. ")")
			if self.errors >= self.MAX_ERRORS then
				return self:Fallback("backend")
			end
			self:SetStatus("error")
			return self:Retry(self.RETRY_SEC)
		end
		self.errors = 0
		if data.status == "ready" and type(data.address) == "string" and data.address ~= "" then
			return self:OnReady(data)
		end
		if data.status == "queued" then
			self:SetStatus("queued", { position = tonumber(data.position) or 0, free = tonumber(data.free) or 0 })
			return self:Retry(tonumber(data.retry_after) or self.RETRY_SEC)
		end
		print("[Connector] unexpected allocate response: " .. tostring(data.status))
		self:SetStatus("error")
		self:Retry(self.RETRY_SEC)
	end)
end

function Connector:Retry(delay)
	if self.address or self.fallback_done then
		return
	end
	Timers:CreateTimer({
		endTime = delay,
		useGameTime = false,
		callback = function()
			self:Request()
		end,
	})
end

function Connector:OnReady(data)
	local first = self.address == nil
	self.address = data.address
	self:SetStatus("ready", { address = data.address })
	print(
		"[Connector] room "
			.. data.address
			.. " match "
			.. tostring(data.match_id)
			.. (data.reconnect and " (reconnect)" or "")
	)

	local _, pids = self:Sids()
	for _, pid in ipairs(pids) do
		if pid ~= self.host_pid and not self.sent[pid] then
			self:SendConnect(pid)
		end
	end
	if first and self.host_pid ~= nil then
		Timers:CreateTimer({
			endTime = self.HOST_DELAY,
			useGameTime = false,
			callback = function()
				self:SendConnect(self.host_pid)
			end,
		})
	end
end

function Connector:SendConnect(pid)
	if self.sent[pid] then
		return
	end
	self.sent[pid] = true
	print("[Connector] connect pid=" .. pid .. " -> " .. self.address)
	FireGameEvent("bsa_connect", { player_id = pid, address = self.address })
end

function Connector:Fallback(reason)
	if self.fallback_done or self.address then
		return
	end
	self.fallback_done = true
	print("[Connector] fallback to local game: " .. tostring(reason))
	self:SetStatus("local")
	GameRules:SetCustomGameSetupAutoLaunchDelay(30)
	GameRules:SetCustomGameSetupTimeout(30)
	GameRules:SetCustomGameSetupRemainingTime(30)
	ServerMode:LoadServerLua(5, function(ok)
		if not ok then
			print("[Connector] local server lua: gave up")
		end
	end)
end