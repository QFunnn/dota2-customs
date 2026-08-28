--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local modifiers = {
	"modifier_invulnerable_custom",
	"modifier_hidden_caster_dummy",
	"modifier_ancient_kill_override",
	"modifier_anti_feed_detected",
	"modifier_gold_bonus",
	"modifier_custom_disabled_unit",
	"modifier_punishment_level_10",
	"modifier_respawn_time_handler",
	"modifier_weak_team_bonus",
	"modifier_alchemist_consumable_scepter_nerf",
}

for _, modifier in pairs(modifiers) do
	LinkLuaModifier(modifier, "modifiers/" .. modifier, LUA_MODIFIER_MOTION_NONE)
end

LinkLuaModifier("modifier_summon_power_buff", "libraries/game_perks/perks/summon_power", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_disarmor_perk_debuff", "libraries/game_perks/perks/disarmor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_perk_tier_indicator",
	"libraries/game_perks/perks/modifier_perk_tier_indicator",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_event_proxy", "libraries/event_proxy/modifier_event_proxy", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_fountain_invulnerability_custom",
	"libraries/fountain_protection/modifier_fountain_invulnerability_custom",
	LUA_MODIFIER_MOTION_NONE
)

for _, perk_data in pairs(GAME_PERKS) do
	local perk_name = perk_data.name
	if perk_name ~= "family" then
		LinkLuaModifier(perk_name, "libraries/game_perks/perks/" .. perk_name, LUA_MODIFIER_MOTION_NONE)
		print("Linked perk modifier", perk_name)
	end
end