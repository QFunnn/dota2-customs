--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("game/game_loop")
require("game/items_limits")
if IsInToolsMode() or GetMapName() == "ot3_demo" then
	require("game/demo/init")
end
require("game/end_game_stats")
require("game/player_disconnect")
require("game/runes")
require("game/mvp/mvp_controller")
require("game/dps_counter")