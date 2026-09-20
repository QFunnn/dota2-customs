--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


if RoomServer == nil then
	_G.RoomServer = class({})
end

RoomServer.HB_IDLE = 5
RoomServer.HB_GAME = 15
RoomServer.GATHER_TIMEOUT = 300 -- страховка: столько ждём последнего, если он так и не пришёл
RoomServer.DIFF_WINDOW = 25
RoomServer.HOLD_KICK = 45 -- столько терпим чужого, если бэкенд так и не признал группу
RoomServer.CLAIM_RETRY = 5
RoomServer.MAX_PLAYERS = 5

local STATE_NAMES = {}
for _, name in ipairs({
	"INIT",
	"WAIT_FOR_PLAYERS_TO_LOAD",
	"CUSTOM_GAME_SETUP",
	"PLAYER_DRAFT",
	"HERO_SELECTION",
	"STRATEGY_TIME",
	"TEAM_SHOWCASE",
	"WAIT_FOR_MAP_TO_LOAD",
	"PRE_GAME",
	"GAME_IN_PROGRESS",
	"POST_GAME",
	"DISCONNECT",
	"SCENARIO_SETUP",
}) do
	local v = _G["DOTA_GAMERULES_STATE_" .. name]
	if v ~= nil then
		STATE_NAMES[v] = name
	end
end

local function fmt_id(n)
	if type(n) == "number" then
		return string.format("%.0f", n)
	end
	return tostring(n)
end

function RoomServer:Init()
	self.match_id = nil
	self.allowed = {}
	self.arrived = {}
	self.admitted = {}
	self.loaded = false
	self.gathered = false
	self.starting = false
	self.first_arrival = nil
	self.hb_timer = nil
	self.gather_check = nil
	self.sent_away = {}
	self.claiming = false
	self.in_queue = false

	ListenToGameEvent("player_connect_full", function(e)
		self:OnConnectFull(e)
	end, nil)
	ListenToGameEvent("game_rules_state_change", function()
		self:OnStateChanged()
	end, nil)
	ListenToGameEvent("player_disconnect", function(e)
		self:OnDisconnect(e)
	end, nil)

	CustomGameEventManager:RegisterListener("room_start", function(_, t)
		local pid = tonumber(t and t.PlayerID)
		if pid ~= 0 then
			return
		end
		print("[Room] host pressed start")
		if not self.gathered then
			self:Gather(true)
		else
			self:Start()
		end
	end)

	ServerMode:LoadServerLua(nil, function()
		self.loaded = true
		self:Heartbeat()
	end, true)
end

function RoomServer:State()
	return GameRules:State_Get()
end

function RoomServer:StateName()
	return STATE_NAMES[self:State()] or tostring(self:State())
end

function RoomServer:IsIdleState()
	local st = self:State()
	return st == DOTA_GAMERULES_STATE_INIT
		or st == DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD
		or st == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP
end

function RoomServer:IsHuman(pid)
	return PlayerResource:IsValidPlayer(pid)
		and not PlayerResource:IsFakeClient(pid)
		and PlayerResource:GetConnectionState(pid) == DOTA_CONNECTION_STATE_CONNECTED
end

function RoomServer:Roster()
	local n, roster = 0, {}
	for pid = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if self:IsHuman(pid) then
			n = n + 1
			local hero = PlayerResource:GetSelectedHeroEntity(pid)
			table.insert(roster, {
				sid = tostring(PlayerResource:GetSteamID(pid)),
				name = PlayerResource:GetPlayerName(pid) or "",
				hero = PlayerResource:GetSelectedHeroName(pid) or "",
				level = (hero and not hero:IsNull()) and hero:GetLevel() or 0,
			})
		end
	end
	return n, roster
end

function RoomServer:Heartbeat()
	if self.hb_timer then
		Timers:RemoveTimer(self.hb_timer)
		self.hb_timer = nil
	end
	local players, roster = self:Roster()
	local body = {
		port = Convars:GetInt("hostport"),
		state = self:StateName(),
		players = players,
		roster = roster,
		map = GetMapName(),
		max_players = self.MAX_PLAYERS,
		match_id = self.match_id and fmt_id(self.match_id) or nil,
		reset = self.reset_pending and 1 or 0,
		gathered = self.gathered_sids,
	}
	self.reset_pending = false
	self.gathered_sids = nil

	local sent, err = pcall(function()
		local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_room_heartbeat/?key=" .. _G.key)
		req:SetHTTPRequestGetOrPostParameter("arr", json.encode(body))
		req:SetHTTPRequestAbsoluteTimeoutMS(10000)
		req:Send(function(res)
			local ok, data = pcall(json.decode, res.Body or "")
			if res.StatusCode == 200 and ok and type(data) == "table" then
				self:OnHeartbeat(data)
			else
				print("[Room] heartbeat failed: http " .. tostring(res.StatusCode))
			end
		end)
	end)
	if not sent then
		print("[Room] heartbeat не создался: " .. tostring(err))
		self.reset_pending = body.reset == 1
		self.gathered_sids = body.gathered
	end

	if self:IsIdleState() and next(self.admitted) ~= nil then
		self:Publish()
	end
	local period = self:IsIdleState() and self.HB_IDLE or self.HB_GAME
	self.hb_timer = Timers:CreateTimer({
		endTime = period,
		useGameTime = false,
		callback = function()
			self.hb_timer = nil
			self:Heartbeat()
		end,
	})
end

function RoomServer:OnHeartbeat(data)
	local sids = {}
	if type(data.sids) == "table" then
		for _, s in pairs(data.sids) do
			sids[tostring(s)] = true
		end
	end
	if next(sids) ~= nil then
		if not self.gathered then
			self.allowed = sids
		end
		self.match_id = tonumber(data.match_id) or self.match_id
	elseif self:IsIdleState() and next(self.arrived) == nil then
		self.allowed = {}
		self.match_id = nil
		self.first_arrival = nil
	end

	for pid, sid in pairs(self.arrived) do
		if self.allowed[sid] and not self.admitted[pid] then
			self:Admit(pid)
		end
	end
	self:CheckGather()
end

function RoomServer:OnConnectFull(e)
	local pid = e and e.PlayerID
	if pid == nil or pid < 0 or PlayerResource:IsFakeClient(pid) then
		return
	end
	local sid = tostring(PlayerResource:GetSteamID(pid))
	self.arrived[pid] = sid
	print("[Room] connect pid=" .. pid .. " sid=" .. sid .. " allowed=" .. tostring(self.allowed[sid] == true))

	if self.allowed[sid] then
		self:Admit(pid)
		return
	end

	self:Claim()
	if self.loaded then
		self:Heartbeat()
	end
	Timers:CreateTimer({
		endTime = self.HOLD_KICK,
		useGameTime = false,
		callback = function()
			if self.arrived[pid] == sid and not self.allowed[sid] and not self.sent_away[pid] and not self.in_queue then
				self:Kick(pid, "бэкенд не признал эту группу")
			end
		end,
	})
end

function RoomServer:Claim()
	if self.claiming or self.gathered or not self:IsIdleState() then
		return
	end
	local sids = {}
	for pid, sid in pairs(self.arrived) do
		if self:IsHuman(pid) and not self.allowed[sid] then
			sids[#sids + 1] = sid
		end
	end
	if #sids == 0 then
		return
	end
	self.claiming = true

	local body = { port = Convars:GetInt("hostport"), sids = sids, host_sid = sids[1] }
	local sent, err = pcall(function()
		local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_room_claim/?key=" .. _G.key)
		req:SetHTTPRequestGetOrPostParameter("arr", json.encode(body))
		req:SetHTTPRequestAbsoluteTimeoutMS(10000)
		req:Send(function(res)
			self.claiming = false
			local ok, data = pcall(json.decode, res.Body or "")
			if res.StatusCode ~= 200 or not ok or type(data) ~= "table" then
				print("[Room] claim failed: http " .. tostring(res.StatusCode))
				return self:ClaimRetry()
			end
			self:OnClaim(data)
		end)
	end)
	if not sent then
		self.claiming = false
		print("[Room] claim не создался: " .. tostring(err))
		self:ClaimRetry()
	end
end

function RoomServer:ClaimRetry()
	if self.gathered then
		return
	end
	Timers:CreateTimer({
		endTime = self.CLAIM_RETRY,
		useGameTime = false,
		callback = function()
			self:Claim()
		end,
	})
end

function RoomServer:OnClaim(data)
	self.in_queue = false
	if data.status == "keep" then
		print("[Room] группа остаётся здесь, match " .. tostring(data.match_id))
		self.match_id = tonumber(data.match_id) or self.match_id
		local sids = {}
		if type(data.sids) == "table" then
			for _, v in pairs(data.sids) do
				sids[tostring(v)] = true
			end
		end
		self.allowed = sids
		CustomNetTables:SetTableValue("server", "room", { state = "gathering", updated = Time() })
		for pid, sid in pairs(self.arrived) do
			if self.allowed[sid] then
				self:Admit(pid)
			end
		end
		return self:CheckGather()
	end

	if data.status == "move" and type(data.address) == "string" and data.address ~= "" then
		print("[Room] комната занята, отправляю группу дальше")
		for pid, sid in pairs(self.arrived) do
			if not self.allowed[sid] and self:IsHuman(pid) and not self.sent_away[pid] then
				self.sent_away[pid] = true
				FireGameEvent("bsa_connect", { player_id = pid, address = data.address })
			end
		end
		return
	end

	if data.status == "queued" then
		local pos = tonumber(data.position) or 0
		self.in_queue = true
		print("[Room] свободных комнат нет, место в очереди " .. pos)
		CustomNetTables:SetTableValue("server", "room", {
			state = "queued",
			position = pos,
			free = tonumber(data.free) or 0,
			updated = Time(),
		})
		return self:ClaimRetry()
	end

	print("[Room] непонятный ответ claim: " .. tostring(data.status))
	self:ClaimRetry()
end

function RoomServer:OnDisconnect(e)
	local pid = e and e.PlayerID
	if pid == nil or pid < 0 then
		return
	end
	if not self:IsIdleState() then
		return
	end
	self.arrived[pid] = nil
	self.admitted[pid] = nil
	local present = self:Present()
	if present == 0 and not self.gathered then
		self.first_arrival = nil
	end
	self:Publish()
	if self.loaded then
		self:Heartbeat()
	end
end

function RoomServer:Admit(pid)
	if self.admitted[pid] then
		return
	end
	self.admitted[pid] = true
	self.first_arrival = self.first_arrival or Time()
	PlayerResource:SetCustomTeamAssignment(pid, DOTA_TEAM_GOODGUYS)
	self:Publish()

	if self.gathered and not self.starting and _G.Shop and Shop.get_db_info then
		print("[Room] опоздавший pid=" .. pid .. ", перечитываю профили")
		Shop:get_db_info()
	end
	self:CheckGather()
end

function RoomServer:Kick(pid, reason)
	print("[Room] kick pid=" .. pid .. ": " .. tostring(reason))
	self.arrived[pid] = nil
	self.admitted[pid] = nil

	local ok = pcall(DisconnectClient, pid, true)
	if not ok then
		local player = PlayerResource:GetPlayer(pid)
		if player and player.GetUserID then
			pcall(SendToServerConsole, "kickid " .. player:GetUserID() .. " " .. tostring(reason))
		end
		print("[Room] kick pid=" .. pid .. ": DisconnectClient не сработал")
	end
end

function RoomServer:Publish()
	local present, expected = self:Present()
	local state = "gathering"
	if self.starting then
		state = "starting"
	elseif self.gathered then
		state = "difficulty"
	end
	local players = {}
	for pid in pairs(self.admitted) do
		if self:IsHuman(pid) then
			players[tostring(pid)] =
				{ name = PlayerResource:GetPlayerName(pid) or "", sid = tostring(PlayerResource:GetSteamID(pid)) }
		end
	end
	CustomNetTables:SetTableValue("server", "room", {
		state = state,
		present = present,
		expected = expected,
		players = players,
		updated = Time(),
	})
end

function RoomServer:Present()
	local expected, present = 0, 0
	for sid in pairs(self.allowed) do
		expected = expected + 1
		for pid, s in pairs(self.arrived) do
			if s == sid and self:IsHuman(pid) then
				present = present + 1
				break
			end
		end
	end
	return present, expected
end

function RoomServer:CheckGather()
	if self.gathered or not self.loaded or not self:IsIdleState() then
		return
	end
	local present, expected = self:Present()
	if present == 0 then
		return
	end

	if present >= expected then
		return self:Gather(false)
	end
	if self.first_arrival and Time() - self.first_arrival >= self.GATHER_TIMEOUT then
		print(
			"[Room] не дождались "
				.. (expected - present)
				.. " игроков за "
				.. self.GATHER_TIMEOUT
				.. "с, стартуем"
		)
		return self:Gather(false)
	end
	if not self.gather_check then
		self.gather_check = Timers:CreateTimer({
			endTime = 5,
			useGameTime = false,
			callback = function()
				self.gather_check = nil
				self:CheckGather()
			end,
		})
	end
end

function RoomServer:Gather(force)
	if self.gathered then
		return
	end
	if not force and not self:IsIdleState() then
		return
	end
	self.gathered = true
	local present, expected = self:Present()
	print(
		"[Room] gathered " .. present .. "/" .. expected .. ", match " .. fmt_id(self.match_id) .. ", loading profiles"
	)
	web:init()
	self:Publish()
	Timers:CreateTimer({
		endTime = self.DIFF_WINDOW,
		useGameTime = false,
		callback = function()
			self:Start()
		end,
	})
end

function RoomServer:OnDiffChosen()
	if not self.gathered or self.starting or self.diff_chosen then
		return
	end
	self.diff_chosen = true
	print("[Room] difficulty chosen, start in 3s")
	Timers:CreateTimer({
		endTime = 3,
		useGameTime = false,
		callback = function()
			self:Start()
		end,
	})
end

function RoomServer:ResetIdle()
	print("[Room] nobody left before start, back to waiting")
	self.gathered = false
	self.starting = false
	self.diff_chosen = false
	self.first_arrival = nil
	self.allowed = {}
	self.arrived = {}
	self.admitted = {}
	self.match_id = nil
	self.sent_away = {}
	self.claiming = false
	self.in_queue = false
	self.reset_pending = true
	CustomNetTables:SetTableValue("server", "room", { state = "", updated = Time() })
	if self.loaded then
		self:Heartbeat()
	end
end

function RoomServer:Start()
	if self.starting then
		return
	end
	local present = self:Present()
	if present == 0 and self:IsIdleState() then
		return self:ResetIdle()
	end
	self.starting = true

	local list = {}
	for pid, sid in pairs(self.arrived) do
		if self.allowed[sid] and self:IsHuman(pid) then
			list[#list + 1] = sid
		end
	end
	self.gathered_sids = list
	self:Publish()
	if self.loaded then
		self:Heartbeat()
	end
	local st = self:State()
	print("[Room] start, state " .. self:StateName())
	if st == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
		GameRules:FinishCustomGameSetup()
	elseif st == DOTA_GAMERULES_STATE_INIT or st == DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD then
		GameRules:ResetToHeroSelection()
	end
end

function RoomServer:OnStateChanged()
	local st = self:State()
	if st == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
		GameRules:SetCustomGameSetupRemainingTime(9999)
		for pid in pairs(self.admitted) do
			if self:IsHuman(pid) then
				PlayerResource:SetCustomTeamAssignment(pid, DOTA_TEAM_GOODGUYS)
			end
		end
		self:CheckGather()
	end
	if self.loaded then
		self:Heartbeat()
	end
end