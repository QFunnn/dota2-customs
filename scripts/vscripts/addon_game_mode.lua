--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


_G.GameMode = GameMode or {}

require("core_declarations")
require("precache")

require("extensions/init")
require("utils/init")
require("libraries/init")
require("filters/init")
require("events/init")
require("game/init")
require("modifiers/init")

function Activate()
	GameMode:Init()
end


function Precache(context)
	print("[GameMode] Precache started")
	PrecacheManager:Run(context)
	print("[GameMode] Precache finished")
end


function GameMode:Init()
	print("[GameMode] Init started")

	local seed = string.gsub(string.gsub(GetSystemTime(), ':', ''), '0','')
	math.randomseed(tonumber(seed))

	local game_mode_entity = GameRules:GetGameModeEntity()
	game_mode_entity.GameMode = self

	GameLoop:Init()
	Events:Init()

	GameMode:SetTeams()
	OrbDropManager:Init()
	Filters:Init()
	CustomChat:Init()
	Runes:Init()

	GameRules:SetUseUniversalShopMode(true)
	GameRules:SetGoldPerTick(0)
	GameRules:SetShowcaseTime(0.0)
	GameRules:SetStrategyTime(15)
	GameRules:SetPreGameTime(PREGAME_TIME)
	GameRules:LockCustomGameSetupTeamAssignment(true)
	GameRules:SetCustomGameSetupAutoLaunchDelay(3)
	GameRules:SetTreeRegrowTime(10)
	GameRules:SetStartingGold(700)

	Convars:SetInt("tv_delay", 10)

	game_mode_entity:SetLoseGoldOnDeath(false)
	game_mode_entity:SetFreeCourierModeEnabled(GetMapName() ~= "ot3_demo")
	game_mode_entity:SetPauseEnabled(IsInToolsMode())
	game_mode_entity:SetRandomHeroBonusItemGrantDisabled(true)
	game_mode_entity:SetCanSellAnywhere(true)
	-- game_mode_entity:SetUseTurboCouriers(true)

	if IsInToolsMode() then
		game_mode_entity:SetFixedRespawnTime(1)
		game_mode_entity:SetDraftingBanningTimeOverride(0)
		GameRules:SetCustomGameSetupAutoLaunchDelay(3)
	end

	-- this setting is weird and persists in demo mode between reloads
	if GetMapName() == "ot3_demo" then
		game_mode_entity:SetDaynightCycleDisabled(true)
	else
		game_mode_entity:SetDaynightCycleDisabled(false)
	end

	GameRules:SetTimeOfDay(0.251)

	if IsInToolsMode() or GetMapName() == "ot3_demo" then OT3Demo:Init(game_mode_entity) end

	EventDriver:Dispatch("GameMode:init_finished", {})

	print("[GameMode] Init finished")
end


function GameMode:IsDeveloper(player_id)
	local steam_id = tostring(PlayerResource:GetSteamID(player_id))

	return DEVELOPERS[steam_id] == true
end


function GameMode:SetTeams()
	for team = 0, DOTA_TEAM_COUNT - 1 do
		local color = TEAM_COLORS[team]
		if color then
			SetTeamCustomHealthbarColor(team, color[1], color[2], color[3])
		end
	end

	local teams_layout = TEAMS_LAYOUTS[GetMapName()]

	for _, team in pairs(teams_layout.teamlist) do
		local player_count = GetMapName() == "ot3_demo" and 99 or teams_layout.player_count
		GameRules:SetCustomGameTeamMaxPlayers(team, player_count)
		GameLoop.current_kills_count[team] = 0
	end

	GameRules:SetCustomGameBansPerTeam(teams_layout.player_count)

	if DEV_ENABLE_SPECTATOR_TEAM == true then
		GameRules:SetCustomGameTeamMaxPlayers(1, 1)
		CustomNetTables:SetTableValue("game_options", "spectator_slots", {DEV_ENABLE_SPECTATOR_TEAM})
	end
end