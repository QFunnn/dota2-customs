--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/upgrades")
require("game/game_loop")
require("game/items_limits")
if IsInToolsMode() or GetMapName() == "ot3_demo" then require("game/demo/init") end
require("game/end_game_stats")
require("game/overboss_orb_drop_manager")
require("game/flying_item_drop")
require("game/neutral_item_drop")
require("game/capture_points/capture_points")
require("game/player_disconnect")
require("game/runes")
require("game/simulated_end_game")
require("game/mvp/mvp_controller")
require("game/hero_challenges/hero_challenges")