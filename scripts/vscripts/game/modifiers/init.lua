--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local modifier_names = {
	"modifier_pregame_stunned",
	"modifier_primary_attribute_reader",
	"modifier_severe_punishment",
	"modifier_summon_bonus_health",
	"modifier_dummy_inventory_custom",
	"modifier_player_abandon",
	"modifier_no_collision",
	"modifier_global_dummy_custom",
	"modifier_courier_speed_controller",
}

for _, modifier_name in pairs(modifier_names) do
	LinkLuaModifier(modifier_name, "game/modifiers/" .. modifier_name, LUA_MODIFIER_MOTION_NONE)
end

-- demo
LinkLuaModifier(
	"modifier_demo_tower_disabled",
	"game/demo/modifiers/modifier_demo_tower_disabled",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("lm_take_no_damage", "game/demo/modifiers/lm_take_no_damage", LUA_MODIFIER_MOTION_NONE)
-- webapi
LinkLuaModifier(
	"modifier_hero_status_fx",
	"libraries/webapi/modifiers/modifier_hero_status_fx",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_equipped_pet", "libraries/webapi/modifiers/modifier_equipped_pet", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dummy_caster", "libraries/webapi/modifiers/modifier_dummy_caster", LUA_MODIFIER_MOTION_NONE)