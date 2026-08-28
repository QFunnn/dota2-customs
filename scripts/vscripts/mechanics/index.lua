--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "mechanics/index"
require("mechanics.kv")
require("mechanics.ability_upgrade")
require("mechanics.cosmetic")
if IsServer() then
	require("mechanics.controller")
	require("mechanics.base")
	require("mechanics.npc")
	require("mechanics.service_attribute")
	require("mechanics.player")
	require("mechanics.multi_choice.multi_choice_manager")
	require("mechanics.skill_upgrade_choice")
	require("mechanics.courier")
	require("mechanics.interaction")
	require("mechanics.team_request_manager")
	require("mechanics.bullet")
	require("mechanics.game_mode_manager")
	require("mechanics.dungeon_manager")
	require("mechanics.damage_system.damage_system")
	require("mechanics.bless")
	require("mechanics.bless_upgrade_choice")
	require("mechanics.artifact")
	require("mechanics.artifact_upgrade_choice")
	require("mechanics.privilege_reward_choice")
	require("mechanics.privilege")
	require("mechanics.fishing")
	require("mechanics.fish_item")
	require("mechanics.courier_explore")
	require("mechanics.arena")
	require("mechanics.sound")
	require("mechanics.combo_system.combo")
	require("mechanics.damage_system.damage_counter")
	require("mechanics.game_mode.mode_dungeon")
	require("mechanics.game_mode.mode_tutorial")
	require("mechanics.game_mode.mode_abyssal")
	require("mechanics.abyssal_horde")
	require("mechanics.fake_cosmetic_preview")
	require("mechanics.rune")
	require("mechanics.simulate_unit_manager")
	require("mechanics.performance_profiler")
	require("mechanics.battle_gem")
	require("mechanics.dungeon_adventure")
else
end