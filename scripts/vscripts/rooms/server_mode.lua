--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


if ServerMode == nil then
	_G.ServerMode = class({})
end

ServerMode.mode = nil
ServerMode.CFG_POLL = 0.3
ServerMode.CFG_TRIES = 10
ServerMode.LOAD_RETRY_SEC = 5

Convars:RegisterConvar("bsa_api_host", "", "backend url of this room", 0)
Convars:RegisterConvar("bsa_api_key", "", "backend key of this room", 0)
Convars:RegisterConvar("bsa_force_mode", "", "debug: valve | room | listen | tools", 0)
if IsDedicatedServer() then
	SendToServerConsole("exec bsa_server")
end
if IsInToolsMode() then
	SendToServerConsole("exec bsa_dev")
end

local function read_cfg()
	local host = Convars:GetStr("bsa_api_host") or ""
	local key = Convars:GetStr("bsa_api_key") or ""
	if key == "" then
		return false
	end
	if host ~= "" then
		_G.host = host
	end
	_G.key = key
	return true
end

function ServerMode:Is(mode)
	return self.mode == mode
end

function ServerMode:Resolve(cb)
	local forced = Convars:GetStr("bsa_force_mode") or ""
	if forced ~= "" and forced ~= self.mode then
		if forced == "room" then
			read_cfg()
		end
		self.mode = forced
		print("[ServerMode] FORCED mode=" .. forced)
	end
	if self.mode then
		cb(self.mode)
		return
	end
	local function done(mode)
		self.mode = mode
		print("[ServerMode] mode=" .. mode .. " host=" .. tostring(_G.host))
		cb(mode)
	end
	if IsInToolsMode() then
		return done("tools")
	end
	if not IsDedicatedServer() then
		return done("listen")
	end

	local tries = 0
	local function poll()
		if read_cfg() then
			return done("room")
		end
		tries = tries + 1
		if tries >= ServerMode.CFG_TRIES then
			return done("valve")
		end
		Timers:CreateTimer({ endTime = ServerMode.CFG_POLL, useGameTime = false, callback = poll })
	end
	poll()
end

function ServerMode:Boot(trigger)
	if self.booted then
		return
	end
	self:Resolve(function(mode)
		if self.booted then
			return
		end
		if trigger == "init" and mode ~= "room" then
			return
		end
		self.booted = true
		if mode == "room" then
			RoomServer:Init()
		elseif mode == "listen" then
			Connector:Init()
		else
			self:LoadServerLua(5, function(ok)
				if not ok then
					print("[ServerMode] load server lua: gave up")
				end
			end)
		end
	end)
end

function _G.GetBSAMatchID()
	if ServerMode.mode == "room" and _G.RoomServer and RoomServer.match_id then
		return RoomServer.match_id
	end
	return GameRules:Script_GetMatchID()
end

function ServerMode:LoadServerLua(max_tries, cb, skip_web_init)
	local attempt, loaded = 0, false
	local function try()
		if loaded then
			return
		end
		attempt = attempt + 1
		local url = _G.host
			.. "/api_game_load_lua/?key="
			.. _G.key
			.. "&t="
			.. RandomInt(1, 2000000000)
			.. "&a="
			.. attempt
		print("[ServerMode] load server lua, attempt " .. attempt)
		local req = CreateHTTPRequestScriptVM("GET", url)
		req:SetHTTPRequestAbsoluteTimeoutMS(30000)
		req:Send(function(res)
			if loaded then
				return
			end
			local chunk, err
			if res.StatusCode == 200 and res.Body then
				chunk, err = loadstring(res.Body)
			else
				err = "http " .. tostring(res.StatusCode)
			end
			if chunk then
				loaded = true
				chunk()
				if not skip_web_init then
					web:init()
				end
				Shop:init()
				Casino:init()
				print("[ServerMode] server lua loaded")
				if cb then
					cb(true)
				end
				return
			end
			print("[ServerMode] load failed: " .. tostring(err))
			if max_tries and attempt >= max_tries then
				if cb then
					cb(false)
				end
				return
			end
			Timers:CreateTimer({ endTime = ServerMode.LOAD_RETRY_SEC, useGameTime = false, callback = try })
		end)
	end
	try()
end