--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local __TS__StringSubstring = ____lualib.__TS__StringSubstring
local __TS__StringEndsWith = ____lualib.__TS__StringEndsWith
local ____exports = {}
require("client.GlobalFunctions")
require("utils.index")
require("client._index")
local ____AbilityCastFxManager = require("client.AbilityCastFxManager")
local AbilityCastFxManager = ____AbilityCastFxManager.AbilityCastFxManager
local ____ruleset_manager = require("rulesets.ruleset_manager")
local RulesetManager = ____ruleset_manager.RulesetManager
MyGameAbilityCastFxManager = __TS__New(AbilityCastFxManager)
SendToConsole("dota_combine_models 1")
SendToConsole("dota_force_right_click_attack 0")
SendToConsole("dota_hud_flip 0")
SendToConsole("dota_hud_healthbars 1")
SendToConsole("dota_player_add_summoned_to_selection 0")
SendToConsole("dota_player_multipler_orders 0")
SendToConsole("dota_hud_disable_damage_numbers 0")
SendToConsole("dota_hud_healthbar_disable_status_display 0")
SendToConsole("r_dota_default_post_process_fade 1")
SendToConsole("dota_versus_scene_disable_heroes 1")
SendToConsole("dota_minimap_position_option 0")
SendToConsole("r_deferred_simple_light 1")
SendToConsole("r_deferred_additive_pass 1")
SendToConsole("r_ssao 1")
MyGameUnitKeyValues = {}
MyGameItemKeyValues = {}
MyGameAbilityKeyValues = {}
local hasAppliedDefaultAutoAttack = false
local function applyDefaultAutoAttackOnce(self)
	if hasAppliedDefaultAutoAttack then
		return
	end
	hasAppliedDefaultAutoAttack = true
	SendToConsole("dota_toggle_autoattack")
end
local function tryApplyDefaultAutoAttackOnHeroSpawn(self, event)
	local entindex = event.entindex
	if entindex == nil then
		return
	end
	local unit = EntIndexToHScript(entindex)
	if not unit then
		return
	end
	if not unit:IsRealHero() then
		return
	end
	if unit:GetPlayerOwnerID() ~= GetLocalPlayerID() then
		return
	end
	applyDefaultAutoAttackOnce(nil)
end
GetPlayerCustomValue = function(self, playerId, key)
	local data = CustomNetTables:GetTableValue("custom_value", "custom_value_" .. tostring(playerId)) or {}
	local value = data[key] or 0
	return value
end
C_DOTAPlayerController.GetCustomValue = function(self, key)
	local data = CustomNetTables:GetTableValue("custom_value", "custom_value_" .. tostring(self:GetPlayerID())) or {}
	local value = data[key] or 0
	return value
end
local function getClientRulesetMapName(self)
	local rawMapName = GetMapName()
	local ____rawMapName_startsWith_result_0
	if __TS__StringStartsWith(rawMapName, "maps/") then
		____rawMapName_startsWith_result_0 = __TS__StringSubstring(rawMapName, #"maps/")
	else
		____rawMapName_startsWith_result_0 = rawMapName
	end
	local mapName = ____rawMapName_startsWith_result_0
	local ____mapName_endsWith_result_1
	if __TS__StringEndsWith(mapName, ".vpk") then
		____mapName_endsWith_result_1 = __TS__StringSubstring(mapName, 0, #mapName - #".vpk")
	else
		____mapName_endsWith_result_1 = mapName
	end
	return ____mapName_endsWith_result_1
end
local function onClientNativeGameStateChanged(event)
	local currentState = event.new_state
	print("[onClientNativeGameStateChanged] currentState: " .. tostring(currentState))
	print("[onClientNativeGameStateChanged] currentState !== 2: " .. tostring(currentState ~= 2))
	if currentState ~= 2 then
		return
	end
	local rulesetMapName = getClientRulesetMapName(nil)
	print((("[ClientRuleset] begin preload rawMap=" .. GetMapName()) .. " rulesetMap=") .. rulesetMapName)
	local rulesetManager = RulesetManager:TryCreate(rulesetMapName)
	if not rulesetManager then
		return
	end
	MyGameRulesetManager = rulesetManager
	print("[ClientRuleset] preload complete ruleset=" .. MyGameRulesetManager:GetActiveRulesetId())
end
ListenToGameEvent("dota_game_state_change", onClientNativeGameStateChanged, nil)
ListenToGameEvent("restart", function()
	print("客户端重启游戏")
	SendToConsole("restart")
end, nil)
ListenToGameEvent("reload_script", function()
	print("客户端重载脚本")
	SendToConsole("script_reload")
end, nil)
ListenToGameEvent("c2c_debug_set_client_weather", function(event)
	local weather = tostring(event.weather or "")
	local weatherId = tonumber(weather)
	if weatherId == nil then
		return
	end
	Convars:SetFloat("cl_weather", weatherId)
end, nil)
ListenToGameEvent("player_connect_full", function(event)
	applyDefaultAutoAttackOnce(nil)
end, nil)
return ____exports