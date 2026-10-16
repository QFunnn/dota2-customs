--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


if not IsClient() then
	return {}
end

local LAUNCH_COMMAND =
	"dota_launch_custom_game 3797844518 platform launch_addon=835235955 launch_map=casual_1x8 launch_arg=1"
local jumped = false

ListenToGameEvent("hall_jump_ready", function(event)
	if jumped or not event or tostring(event.workshop_id) ~= "3797844518" then
		return
	end
	if type(SendToConsole) ~= "function" then
		print("[HallJump] SendToConsole unavailable")
		return
	end
	-- Panorama 先取消订阅，随后才发送这个本机事件；命令完全由本地图定义。
	local ok, err = pcall(function()
		SendToConsole(LAUNCH_COMMAND)
	end)
	if ok then
		jumped = true
		print("[HallJump] " .. LAUNCH_COMMAND)
	else
		print("[HallJump] launch failed: " .. tostring(err))
	end
end, nil)

return {}