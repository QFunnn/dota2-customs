--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("extensions/string")
require("extensions/table")
require("extensions/math")
require("extensions/cdota_modifier_lua")
require("extensions/cdota_ability_lua")
require("extensions/cdota_basenpc")
require("extensions/cdota_basenpc_hero")
require("extensions/cdota_player_controller")
require("extensions/cdota_player_resource")


if not PauseGame_Engine then
	_G.PauseGame_Engine = PauseGame
	_G.PauseGame = function(new_state)
		if GameRules:IsGamePaused() ~= new_state then
			PauseGame_Engine(new_state)
		end
	end
end