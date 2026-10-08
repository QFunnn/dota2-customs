--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


print("[CLIENT] addon_game_mode_client.lua loaded")
print("[CLIENT] IsClient =", tostring(IsClient()))
local function OnConnectServerClient(keys)
	print("[CLIENT] OnConnectServerClient")
	local map_name = keys.map_name or "ranked_1x8"

	print("[CLIENT] launch_game: map=" .. map_name)
	local launch_console = "dota_launch_custom_game 3797844518 platform launch_addon=835235955 launch_map="
		.. map_name
		.. " launch_arg=1"
	print(launch_console)
	SendToConsole(launch_console)
end

ListenToGameEvent("client_connect_server", OnConnectServerClient, nil)
print("[CLIENT] listener registered")