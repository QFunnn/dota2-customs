--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---@class GameRulesCustom : CDOTAGameRules
---@field heroesPoolList table
---@field unitsPoolList table
_G.GameRulesCustom = _G.GameRules

local GameRulesCustom = _G.GameRulesCustom
---@cast GameRulesCustom GameRulesCustom

if GameMode == nil then
	_G.GameMode = class({}) ---@class GameMode
end

require("utils.core")
require("utils.logger")
require("utils.string_extensions")
require("utils.utility_functions")
require("utils.timers")
require("utils.bit")
require("utils.table")
require("utils.math")
require("utils.combat")
require("utils.player")
require("utils.notifications")
require("extensions.cdota_base_npc")
require("extensions.cdota_base_ability")
require("extensions.cdota_modifier_lua")
require("utils.dev_utils")
require("utils.memory_tracker")
require("utils.event_driver")

require("security.secured_game_listener")
require("security.secured_event_sender")
require("security.security")

require("link_lua_modifiers")

require("domain.match.team")
require("domain.match.match")

require("core.gamemode.gamemode")
require("service.hero_builder.hero_builder_service")
require("domain.round.round")
require("core.spawner")
require("service.pvp.pvp_service")

require("mechanics.debugger")
require("mechanics.debug_tool")
require("mechanics.features")
require("mechanics.extra_creature")
require("mechanics.barrage")
require("mechanics.shop")
require("mechanics.roulette")
require("mechanics.cases")
require("mechanics.chat_wheel")
require("mechanics.player_tips")
require("mechanics.game_pause_manager")
require("mechanics.wereable_system.wereable_system")
require("mechanics.modifiers")

require("service.outbound.player_outbound_api")
require("service.outbound.shop_outbound_api")
require("service.outbound.match_outbound_api")
require("service.outbound.outbound_request_sender")
require("service.match.match_state_service")
require("service.match.heartbeat_service")
require("service.settings")
require("service.player.player_connection_service")
require("service.gold_service")
require("service.hero.hero_placement_service")
require("service.hero.hero_refresh_service")
require("service.hero.reincarnation_service")
require("service.match.match_command_service")
require("service.match.match_lifecycle_service")
require("service.match.match_setup_service")
require("service.match.match_outcome")

require("pass")
require("illusion")

require("data_manager.main")

require("service.ability.ability_kv")
require("libraries.extender_stash")

require("precache.precache")
require("precache.precache_default")

GameRulesCustom.heroesPoolList = {}
GameRulesCustom.unitsPoolList = LoadKeyValues("scripts/npc/npc_units_custom.txt")

for heroName, _ in pairs(LoadKeyValues("scripts/npc/herolist.txt")) do
	table.insert(GameRulesCustom.heroesPoolList, heroName)
end

---@param context CScriptPrecacheContext
function Precache(context)
	GameMode:Precache(context)
end

function Activate()
	GameMode:Activate()
end

function Reload()
	GameMode:Reload()
end