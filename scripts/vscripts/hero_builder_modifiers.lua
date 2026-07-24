--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- HeroBuilder 相关的公共 Modifier 注册。
-- 此文件需要同时在服务端和客户端加载，不能作为服务端模块加密。
LinkLuaModifier("modifier_aegis", "heroes/modifier_aegis", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_aegis_buff", "heroes/modifier_aegis_buff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_muted_lua", "heroes/modifier_generic_muted_lua", LUA_MODIFIER_MOTION_NONE)
-- LinkLuaModifier("modifier_skywrath_mage_shard_lua", "heroes/hero_skywrath_mage/modifier_skywrath_mage_shard_lua", LUA_MODIFIER_MOTION_NONE)
-- LinkLuaModifier("modifier_skywrath_mage_shard_bonus_counter_lua", "heroes/hero_skywrath_mage/modifier_skywrath_mage_shard_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_legion_commander_duel_creep", "heroes/hero_legion_commander/legion_commander_duel",
	LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spell_amplify_controller", "heroes/modifier_spell_amplify_controller", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_escape_controller", "heroes/modifier_escape_controller", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pvp_ending", "heroes/modifier_pvp_ending", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pvp_ending_effect", "heroes/modifier_pvp_ending", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_attack_system", "heroes/modifier_attack_system", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dummy", "heroes/modifier_dummy", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_events", "heroes/modifier_events", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_relief_fund", "heroes/modifier_relief_fund", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_magic_crit", "heroes/modifier_magic_crit", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_magic_crit_msg", "heroes/modifier_magic_crit", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_loser_curse", "heroes/modifier_loser_curse", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creature_berserk", "creature_ability/modifier_creature_berserk", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creature_berserk_debuff", "creature_ability/modifier_creature_berserk_debuff",
	LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_hero_refreshing", "heroes/modifier_hero_refreshing", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_fountain_thinker", "heroes/modifier_hero_refreshing", LUA_MODIFIER_MOTION_NONE)

LinkLuaModifier("modifier_creature_true_sight", "creature_ability/modifier_creature_true_sight", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creature_spell_amplify", "creature_ability/modifier_creature_spell_amplify",
	LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creature_after60", "creature_ability/modifier_creature_after60", LUA_MODIFIER_MOTION_NONE)

-- 处理陈的问题
LinkLuaModifier("modifier_chen_base", "heroes/hero_chen/modifier_chen_base", LUA_MODIFIER_MOTION_NONE)

-- 织网光环
LinkLuaModifier("modifier_broodmother_spin_web_web_lua",
	"heroes/hero_broodmother/modifier_broodmother_spin_web_web_lua.lua", LUA_MODIFIER_MOTION_NONE)