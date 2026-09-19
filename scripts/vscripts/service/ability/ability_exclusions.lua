--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- Взаимоисключающие способности и модели. Листовой data-модуль (без сайд-эффектов).
---@class AbilityExclusions
---@field byAbility table<string, string[]> взаимоисключающие способности (нельзя выбрать обе)
---@field byHeroModel table<string, string[]> способности, несовместимые с моделью героя

local byAbility = {
	["lone_druid_true_form"] = { "lone_druid_spirit_bear" }, --todo подумать
	["lone_druid_spirit_bear"] = { "lone_druid_true_form" },
	["oracle_false_promise"] = { "abaddon_borrowed_time" },
}

local byHeroModel = {
	["npc_dota_hero_silencer"] = { "monkey_king_wukongs_command" }, --todo подумать
	["npc_dota_hero_razor"] = { "monkey_king_wukongs_command" },
	["npc_dota_hero_meepo"] = { "arc_warden_tempest_double_lua" },
	["npc_dota_hero_sand_king"] = { "sandking_caustic_finale_lua" },
	["npc_dota_hero_naga_siren"] = { "naga_siren_rip_tide" },
	["npc_dota_hero_shadow_shaman"] = { "brewmaster_primal_split" },
	["npc_dota_hero_alchemist"] = { "ogre_magi_multicast_lua" },
}

return {
	byAbility = byAbility,
	byHeroModel = byHeroModel,
}