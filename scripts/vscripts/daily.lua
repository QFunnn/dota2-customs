--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


if daily == nil then
	_G.daily = class({})
end

function daily:init()
	CustomGameEventManager:RegisterListener("daily_open", Dynamic_Wrap(daily, "daily_open"))
	CustomGameEventManager:RegisterListener("daily_claim", Dynamic_Wrap(daily, "daily_claim"))
end

local function send_state(pid, state)
	local player = PlayerResource:GetPlayer(pid)
	if not (player and state) then
		return
	end
	CustomGameEventManager:Send_ServerToPlayer(player, "daily_data", {
		claimed = state.claimed or 0,
		cycle = state.cycle or 0,
		available = state.available and 1 or 0,
		slots = json.encode(state.slots or {}),
	})
end

function daily:daily_open(t)
	local pid = t.PlayerID
	local arr = json.encode({ sid = tostring(PlayerResource:GetSteamID(pid)) })

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_daily_state/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", arr)
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			send_state(pid, json.decode(res.Body))
		else
			print("[daily] state error: " .. tostring(res.StatusCode))
		end
	end)
end

function daily:daily_claim(t)
	local pid = t.PlayerID
	local arr = json.encode({ sid = tostring(PlayerResource:GetSteamID(pid)) })

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_daily_claim/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", arr)
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			local resp = json.decode(res.Body)
			if not resp then
				return
			end

			send_state(pid, resp.state)

			local player = PlayerResource:GetPlayer(pid)
			if player then
				CustomGameEventManager:Send_ServerToPlayer(player, "daily_result", {
					day = resp.day or 0,
					detail = json.encode(resp.detail or {}),
				})
			end
		else
			print("[daily] claim error: " .. tostring(res.StatusCode))
		end
	end)
end

daily:init()