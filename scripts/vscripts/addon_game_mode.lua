--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


_G.ONLINE_TEST_MODE = false
_G.PUBLISH_TIMESTAMP = "2026-09-11T08:46:51.141Z"
-- 发布入口只预载资源；业务必须同时等到 Activate 与地图分片。
if not IsServer() then
	return
end

local release = require("utils.release_bootstrap")
local state = release.get_entry_state()
local addon_scope = getfenv()
local activate_wrapper, precache_wrapper
local timeout_seconds = 30
local think_name = "dota_super_mid_release_startup"

local function reject_startup()
	if state.failed then
		return
	end
	state.failed = true
	local admission = { status = "rejected", actual_players = 0, required_players = 10, reason = "not_ready" }
	if type(GameInfos) == "table" then
		GameInfos.MATCH_ADMISSION = admission
	end
	CustomNetTables:SetTableValue("game_flow", "admission", admission)
	GameRules:SetCustomVictoryMessage("#match_admission_rejected")
	GameRules:SetCustomGameEndDelay(0)
	GameRules:SetPostGameTime(3)
	GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
end

local function start_game()
	if state.failed or state.started or not state.activated_at or not release.is_ready() then
		return
	end
	if
		GameRules:State_Get() > DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP
		or Plat_FloatTime() - state.activated_at >= timeout_seconds
	then
		reject_startup()
		return
	end
	local ok, err = pcall(function()
		release.run_startup_once(function()
			local previous_activate = rawget(_G, "Activate")
			local previous_precache = rawget(_G, "Precache")
			local function restore_callbacks()
				addon_scope.Activate = activate_wrapper
				addon_scope.Precache = precache_wrapper
				if addon_scope ~= _G then
					if rawget(_G, "Activate") ~= previous_activate then
						_G.Activate = activate_wrapper
					end
					if rawget(_G, "Precache") ~= previous_precache then
						_G.Precache = precache_wrapper
					end
				end
			end
			local loaded, load_error = pcall(function()
				require("release_main")
				local main_activate = addon_scope.Activate
				if main_activate == activate_wrapper and rawget(_G, "Activate") ~= previous_activate then
					main_activate = rawget(_G, "Activate")
				end
				assert(
					type(main_activate) == "function" and main_activate ~= activate_wrapper,
					"Release entry did not install Activate"
				)
				restore_callbacks()
				main_activate()
			end)
			restore_callbacks()
			if not loaded then
				error(load_error, 0)
			end
			state.started = true
		end)
	end)
	if not ok then
		reject_startup()
		error(err, 0)
	end
end

precache_wrapper = function(context)
	return require("precache").default(context)
end

activate_wrapper = function()
	if state.failed or state.started then
		return
	end
	state.activated_at = state.activated_at or Plat_FloatTime()
	start_game()
	if state.failed or state.started then
		return
	end
	GameRules:GetGameModeEntity():SetContextThink(think_name, function()
		if state.failed or state.started then
			return
		end
		if
			GameRules:State_Get() > DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP
			or Plat_FloatTime() - state.activated_at >= timeout_seconds
		then
			reject_startup()
			return
		end
		if GameRules:State_Get() == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
			GameRules:SetCustomGameSetupRemainingTime(10)
		end
		return 0.1
	end, 0)
end

addon_scope.Precache = precache_wrapper
addon_scope.Activate = activate_wrapper
release.when_ready(start_game)