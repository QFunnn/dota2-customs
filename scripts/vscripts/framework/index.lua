--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "framework/index"
require("framework.enums")
require("framework.constant")
require("framework.large_number_health")
require("framework.pseudo_random")
require("framework.global")
require("framework.module")
require("framework.message")
require("framework.notification")
require("framework.timer")
require("framework.particle_clear")
require("framework.debug")
require("framework.entity_pool_stress_test")
require("framework.request")
require("framework.game_event")
require("framework.event")
require("framework.draw_pool")
require("framework.behavior_tree.index")
require("framework.property_system.property_system")
require("framework.state_system.state_system")
if IsServer() then
	require("framework.game_state")
	require("framework.demo")
	require("framework.settings")
	require("framework.unit_manager")
end