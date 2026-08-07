--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "reload"
local b = require("lualib_bundle")
local c = b.__TS__ArrayForEach
if GameModeActivated then
	c(GameEventListenerIDs, function(d, e)
		StopListeningToGameEvent(e)
	end)
	c(CustomUIEventListenerIDs, function(d, e)
		CustomGameEventManager:UnregisterListener(e)
	end)
	_G.GameEventListenerIDs = {}
	_G.CustomUIEventListenerIDs = {}
	if IsServer() then
		_G.TimerEventListenerIDs = {}
	end
	collectgarbage("collect")
	CModule:reload()
	if IsServer() then
		print("Reload completed. Server time: " .. tostring(GameRules:GetGameTime()))
	end
else
	GameModeActivated = true
end