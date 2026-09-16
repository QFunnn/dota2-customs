--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


print("[CLIENT] addon_game_mode_client.lua loaded")
print("[CLIENT] IsClient =", tostring(IsClient()))
local function OnConnectServerClient(keys)
	print("[CLIENT] OnConnectServerClient")
	print("[CLIENT] ip =", tostring(keys.ip))
	print("[CLIENT] player_id =", tostring(keys.player_id))
	local localPlayerID = GetLocalPlayerID()
	print("[CLIENT] localPlayerID =", tostring(localPlayerID))
	--只让点击按钮的那个客户端处理
	if tonumber(keys.player_id) ~= tonumber(localPlayerID) then
		print("[CLIENT] not target player, ignore")
		return
	end
	print("[CLIENT] target client matched")
	--之后再测试:
	SendToConsole("connect " .. tostring(keys.ip))
end

ListenToGameEvent("client_connect_server", OnConnectServerClient, nil)
print("[CLIENT] listener registered")