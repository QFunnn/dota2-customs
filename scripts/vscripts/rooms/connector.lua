--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


if Connector == nil then
	_G.Connector = class({})
end

Connector.SETTLE_SEC = 4
Connector.FALLBACK_SEC = 999999
Connector.HOST_DELAY = 1.5
Connector.CHOICE_SEC = 30 -- сколько ждём выбора хоста, потом уходим на сервер

function Connector:Init()
	self.address = nil
	self.fallback_done = false
	self.started_at = Time()
	self.sent = {}
	self.host_pid = nil
	self.settle = nil

	GameRules:SetCustomGameSetupAutoLaunchDelay(-1)
	GameRules:SetCustomGameSetupTimeout(-1)
	GameRules:SetCustomGameSetupRemainingTime(9999)
	self.chosen = nil

	-- Хост выбирает, где играть: на своей машине или на нашем сервере.
	-- Не выбрал за CHOICE_SEC — уходим на сервер.
	self.choice_left = self.CHOICE_SEC
	self:SetStatus("choice", { left = self.choice_left })
	CustomGameEventManager:RegisterListener("bsa_mode_choice", function(_, t)
		local pid = tonumber(t and t.PlayerID)
		if pid ~= self.host_pid then
			return
		end
		if tostring(t.mode) == "local" then
			self:ChooseLocal()
		else
			self:ChooseServer()
		end
	end)
	Timers:CreateTimer({
		endTime = 1,
		useGameTime = false,
		callback = function()
			if self.chosen then
				return nil
			end
			self.choice_left = self.choice_left - 1
			if self.choice_left <= 0 then
				self:ChooseServer()
				return nil
			end
			self:SetStatus("choice", { left = self.choice_left })
			return 1
		end,
	})

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
		if self.chosen ~= "server" then
			return
		end
		if self.address then
			self:SendConnect(e.PlayerID)
		else
			self:Schedule()
		end
	end, nil)
end

-- Играем на нашем сервере. Спросить бэкенд отсюда нельзя, поэтому берём
-- адрес из зашитого списка и отправляем туда всю группу одним адресом:
-- решение принимает хост, значит все попадут в одну комнату.
function Connector:ChooseServer()
	if self.chosen then
		return
	end
	self.chosen = "server"
	print("[Connector] выбран сервер BSA")
	self:SetStatus("waiting")
	self:Schedule()
end

-- Играем здесь же, на машине хоста, как до появления своих серверов.
function Connector:ChooseLocal()
	if self.chosen then
		return
	end
	self.chosen = "local"
	print("[Connector] выбрана игра на машине хоста")
	self:Fallback("выбор хоста")
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
			self:Dispatch()
		end,
	})
end

function Connector:Dispatch()
	if self.address or self.fallback_done then
		return
	end
	local sids, pids = self:Sids()
	if #pids == 0 then
		print("[Connector] пока некого отправлять")
		return
	end
	local addr = RoomList:Pick()
	if not addr then
		return self:Fallback("список комнат пуст")
	end
	self.address = addr
	self:SetStatus("ready")
	print("[Connector] отправляю " .. #pids .. " игроков в комнату")
	self:SendAll()
end

function Connector:SendAll()
	local _, pids = self:Sids()
	for _, pid in ipairs(pids) do
		if pid ~= self.host_pid then
			self:SendConnect(pid)
		end
	end
	if self.host_pid ~= nil and not self.sent[self.host_pid] then
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
	print("[Connector] отправляю в комнату pid=" .. pid)
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