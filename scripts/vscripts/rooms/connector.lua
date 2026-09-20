--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


if Connector == nil then
	_G.Connector = class({})
end

Connector.QUIET_SEC = 4 -- тишина в лобби перед запросом комнаты (ждём, пока зайдут все)
Connector.FALLBACK_SEC = 90 -- хост-панель молчит так долго -> играем локально
Connector.HOST_DELAY = 1.5

-- Спросить бэкенд с машины хоста Lua больше не может (Valve режет HTTP на
-- listen-сервере). За адресом комнаты ходит Panorama хоста через HTML-мост
-- (team_select_rooms.js) и присылает результат сюда событием.
--
-- Пати: друг заходит в лобби позже хоста. Чтобы комната не забронировалась и
-- не стартовала без него, мост дёргаем НЕ сразу, а после QUIET_SEC тишины
-- (никто не заходил) — к этому моменту в лобби уже вся группа, и бронь сразу
-- на всех. Опоздавших после этого домердживаем и досылаем отдельно.
function Connector:Init()
	self.address = nil
	self.fallback_done = false
	self.published = false
	self.started_at = Time()
	self.last_join = Time()
	self.sent = {}
	self.host_pid = nil
	self.cur_state = "connecting"
	self.group_sids = ""
	self.group_host = ""

	GameRules:SetCustomGameSetupAutoLaunchDelay(-1)
	GameRules:SetCustomGameSetupTimeout(-1)
	GameRules:SetCustomGameSetupRemainingTime(9999)

	self:SetStatus("connecting")

	CustomGameEventManager:RegisterListener("bsa_room_addr", function(_, t)
		local pid = tonumber(t and t.PlayerID)
		if pid ~= self.host_pid then
			return
		end
		local addr = tostring(t.address or "")
		if addr == "" or self.address then
			return
		end
		self.address = addr
		self:SetStatus("ready")
		print("[Connector] хост прислал комнату, рассылаю группу")
		self:SendAll()
	end)

	CustomGameEventManager:RegisterListener("bsa_room_queue", function(_, t)
		local pid = tonumber(t and t.PlayerID)
		if pid ~= self.host_pid or self.address then
			return
		end
		self:SetStatus("queued", { position = tonumber(t.position) or 0 })
	end)

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
		self.last_join = Time()
		if self.published then
			-- Группу уже запросили: опоздавший обновляет состав (мост дозабронирует)
			-- и, если комната уже есть, едет сразу.
			self:RefreshGroup()
			if self.address then
				self:SendConnect(e.PlayerID)
			end
		end
	end, nil)

	-- Ждём тишины, потом один раз публикуем полный состав хосту.
	Timers:CreateTimer({
		endTime = 1,
		useGameTime = false,
		callback = function()
			if self.fallback_done then
				return nil
			end
			if self.published then
				return nil
			end
			if #self:Sids() > 0 and Time() - self.last_join >= self.QUIET_SEC then
				self.published = true
				self:RefreshGroup()
				return nil
			end
			return 1
		end,
	})

	Timers:CreateTimer({
		endTime = self.FALLBACK_SEC,
		useGameTime = false,
		callback = function()
			if not self.address and not self.fallback_done then
				self:Fallback("хост-панель не ответила")
			end
		end,
	})
end

function Connector:IsHuman(pid)
	return PlayerResource:IsValidPlayer(pid)
		and not PlayerResource:IsFakeClient(pid)
		and PlayerResource:GetConnectionState(pid) == DOTA_CONNECTION_STATE_CONNECTED
end

function Connector:SetStatus(state, extra)
	self.cur_state = state
	local t = { state = state, updated = Time() }
	if self.group_sids ~= "" then
		t.sids = self.group_sids
		t.host = self.group_host
	end
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

-- Публикуем актуальный состав хосту -> его Panorama (пере)запрашивает комнату
-- мостом. Бэкенд домердживает новых в ту же бронь по общему host_sid.
function Connector:RefreshGroup()
	if self.fallback_done then
		return
	end
	local sids = self:Sids()
	if #sids == 0 then
		return
	end
	local host_sid = sids[1]
	if self.host_pid ~= nil and self:IsHuman(self.host_pid) then
		host_sid = tostring(PlayerResource:GetSteamID(self.host_pid))
	end
	local csv = table.concat(sids, ",")
	if csv == self.group_sids then
		return
	end
	self.group_sids = csv
	self.group_host = host_sid
	print("[Connector] публикую состав: " .. #sids .. " игроков")
	self:SetStatus(self.cur_state)
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