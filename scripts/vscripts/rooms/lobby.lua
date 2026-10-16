--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


if Lobby == nil then
	_G.Lobby = class({})
end

-- Карта lobby. Запуск лобби из интерфейса Доты сломан, поэтому каждый игрок сам
-- запускает у себя эту карту (dota_launch_custom_game 1571786267 lobby) и видит
-- список комнат (team_select/lobby_rooms.js). Всю работу с бэкендом делает
-- Panorama через HTML-мост; сюда она присылает только адрес, куда ехать.
-- Игра навсегда остаётся в выборе команд.
function Lobby:Init()
	GameRules:SetCustomGameSetupAutoLaunchDelay(-1)
	GameRules:SetCustomGameSetupTimeout(-1)
	GameRules:SetCustomGameSetupRemainingTime(9999)

	ListenToGameEvent("game_rules_state_change", function()
		if GameRules:State_Get() == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
			GameRules:SetCustomGameSetupRemainingTime(9999)
		end
	end, nil)

	CustomGameEventManager:RegisterListener("bsa_lobby_go", function(_, t)
		local pid = tonumber(t and t.PlayerID)
		local address = tostring(t and t.address or "")
		if pid == nil or not Lobby:IsRoomAddress(address) then
			return
		end
		print("[Lobby] отправляю pid=" .. pid .. " в комнату " .. address)
		FireGameEvent("bsa_connect", { player_id = pid, address = address })
	end)
end

-- Только ip:port или SDR-адрес: в connect не должно попасть ничего лишнего.
function Lobby:IsRoomAddress(address)
	return address:match("^%d+%.%d+%.%d+%.%d+:%d+$") ~= nil or address:match("^%[A:1:%d+:%d+%]$") ~= nil
end