--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


local modifier_names = {
	"modifier_bat_handler",
	"modifier_central_ring_emitter",
	"modifier_fountain_movespeed_lua",
	"modifier_fountain_rejuvenation_lua",
	"modifier_kill_leader",
	"modifier_pregame_stunned",
	"modifier_primary_attribute_reader",
	"modifier_severe_punishment",
	"modifier_treasure_courier",
	"modifier_xpm_gpm",
	"modifier_simulated_end_game",
	"modifier_summon_bonus_health",
	"modifier_dummy_inventory_custom",
	"modifier_player_abandon",
	"modifier_no_collision",
	"modifier_global_dummy_custom",
	"modifier_capturing_orb_custom",
	"modifier_courier_speed_controller",
}


for _, modifier_name in pairs(modifier_names) do
	LinkLuaModifier(modifier_name, "game/modifiers/" .. modifier_name, LUA_MODIFIER_MOTION_NONE)
end

-- gathering in a single place so linking on both server and client is easier
LinkLuaModifier("capture_point_area", "game/capture_points/capture_point_area", LUA_MODIFIER_MOTION_BOTH)
-- demo
LinkLuaModifier("modifier_demo_tower_disabled", "game/demo/modifiers/modifier_demo_tower_disabled", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("lm_take_no_damage", "game/demo/modifiers/lm_take_no_damage", LUA_MODIFIER_MOTION_NONE)
-- ???
LinkLuaModifier("modifier_silencer_new_int_steal", "abilities/heroes/silencer/modifier_silencer_new_int_steal", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_necromastery_auto", "abilities/heroes/nevermore/necromastery.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeleton_king_vampiric_aura_auto", "abilities/heroes/skeleton_king/vampiric_aura.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_vengefulspirit_command_aura_scepter_debuff_lua", "abilities/heroes/vengefulspirit/modifier_vengefulspirit_command_aura_scepter_debuff", LUA_MODIFIER_MOTION_NONE)
-- webapi
LinkLuaModifier("modifier_hero_status_fx", "libraries/webapi/modifiers/modifier_hero_status_fx", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_equipped_pet", "libraries/webapi/modifiers/modifier_equipped_pet", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dummy_caster", "libraries/webapi/modifiers/modifier_dummy_caster", LUA_MODIFIER_MOTION_NONE)