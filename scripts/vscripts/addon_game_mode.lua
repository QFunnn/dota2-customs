--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


if IsInToolsMode() then
	LISTENER_IDS = LISTENER_IDS or {}

	CustomGameEventManager_RegisterListener = CustomGameEventManager_RegisterListener
		or CustomGameEventManager.RegisterListener
	CustomGameEventManager.RegisterListener = function(self, name, func)
		if LISTENER_IDS[name] then
			CustomGameEventManager:UnregisterListener(LISTENER_IDS[name])
			LISTENER_IDS[name] = nil
		end

		LISTENER_IDS[name] = CustomGameEventManager_RegisterListener(self, name, func)
	end

	_G.old_GetDedicatedServerKeyV3 = _G.old_GetDedicatedServerKeyV3 or GetDedicatedServerKeyV3

	function GetDedicatedServerKeyV3(str)
		local custom_key = LoadKeyValues("../bsa_key.txt")
		if custom_key and custom_key["CustomDedicatedKey"] then
			return custom_key["CustomDedicatedKey"]
		end
		return _G.old_GetDedicatedServerKeyV3(str)
	end
end

require("libraries/timers")

require("overrides")
-- require("debug_panel")

require("talents_stats")
require("libraries/notifications")

require("libraries/timers")
require("libraries/animations")
require("libraries/table")
require("libraries/utils")
require("libraries/debounce")
require("libraries/base_npc")
-- require("profiler_temp")
require("mini_quest")
require("essentials")
require("rules")
require("daily")
require("guild_events")
require("effects")
require("hero_builder")
require("player_summary")
require("hats")

-- require('www/acc')
-- require("www/web")
-- require('www/guilds')
-- require('www/drop')
-- require('www/shop')
-- require("www/quest_system")
-- require("www/inventory")
-- require("www/casino")

_G.key = GetDedicatedServerKeyV3("BSAKEY1")
_G.host = "https://boss-survival-adventure.com"
_G.Game_Difficulty = 1

if CAddonAdvExGameMode == nil then
	CAddonAdvExGameMode = class({})
end

Precache = require("precache")

function Activate()
	GameRules.AddonAdventure = CAddonAdvExGameMode()
	GameRules.AddonAdventure:InitGameMode()
end

function CAddonAdvExGameMode:InitGameMode()
	local GameModeEntity = GameRules:GetGameModeEntity()
	GameRules:SetUseUniversalShopMode(true)
	GameRules:GetGameModeEntity():SetLoseGoldOnDeath(false)
	GameRules:SetCustomGameSetupAutoLaunchDelay(30)
	GameRules:GetGameModeEntity():SetHudCombatEventsDisabled(true)
	GameRules:GetGameModeEntity():SetKillingSpreeAnnouncerDisabled(true)
	GameRules:SetHeroSelectionTime(50)
	GameRules:SetPreGameTime(0)
	GameRules:SetPostGameTime(60)
	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_GOODGUYS, 5)
	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, 0)
	GameRules:GetGameModeEntity():SetUnseenFogOfWarEnabled(not IsInToolsMode())
	GameRules:GetGameModeEntity():SetFogOfWarDisabled(IsInToolsMode())
	GameRules:SetUseBaseGoldBountyOnHeroes(true)
	GameRules:SetStrategyTime(0)
	GameRules:GetGameModeEntity():SetRuneSpawnFilter(Dynamic_Wrap(CAddonAdvExGameMode, "RuneSpawnFilter"), self)
	GameRules:GetGameModeEntity():SetMaximumAttackSpeed(800)
	GameRules:GetGameModeEntity():SetThink("OnThink", self, "GlobalThink", 2)
	ListenToGameEvent("entity_killed", Dynamic_Wrap(CAddonAdvExGameMode, "OnEntityKilled"), self)
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(CAddonAdvExGameMode, "OnNPCSpawned"), self)
	ListenToGameEvent("player_chat", Dynamic_Wrap(CAddonAdvExGameMode, "OnChat"), self)
	ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(CAddonAdvExGameMode, "OnGameStateChanged"), self)
	ListenToGameEvent("dota_rune_activated_server", Dynamic_Wrap(CAddonAdvExGameMode, "onRuneActivated"), self)
	CustomGameEventManager:RegisterListener("npc_interact", Dynamic_Wrap(CAddonAdvExGameMode, "OnNpcInteract"))
	GameRules:SetStartingGold(600)

	GameRules:GetGameModeEntity():SetInnateMeleeDamageBlockAmount(0)

	GameRules:GetGameModeEntity():SetPlayerHeroAvailabilityFiltered(true)
	GameRules:GetGameModeEntity():SetBountyRunePickupFilter(Dynamic_Wrap(CAddonAdvExGameMode, "BountyFilter"), self)

	GameRules:GetGameModeEntity():SetExecuteOrderFilter(Dynamic_Wrap(self, "GameEventsFilter"), self)

	GameModeEntity:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_AGILITY_ATTACK_SPEED, 0.2)

	GameRules:SetShowcaseTime(0)
	essentials:Init()
	effects:init()
	PlayersSummary:Init()

	self._ischeckingdefeat = false
	self._defeatcounter = 5

	_G.ability_mode = false
	if GetMapName() == "ability_mode" then
		HeroBuilder:Init()
		_G.ability_mode = true
	end

	_G.player_quest = {}
	for i = 0, 4 do
		_G.player_quest[i] = {}
	end

	SendToServerConsole("dota_max_physical_items_purchase_limit 9999")

	if IsInToolsMode() then
		GameRules:SetStartingGold(99999)
	end
end

function CAddonAdvExGameMode:OnChat(event)
	local text = event.text
	local pid = event.playerid
	local hero = PlayerResource:GetSelectedHeroEntity(pid)
	local point = hero:GetAbsOrigin()
	local steamID = PlayerResource:GetSteamAccountID(pid)

	local IsAdmin = function(steamID)
		return table.contains({ 393187346, 455872541 }, steamID)
	end

	if text == "1" and steamID == 393187346 then
	end

	if text == "2" and steamID == 393187346 then
	end

	if IsAdmin(steamID) and text == "2434" then
		local hero = PlayerResource:GetSelectedHeroEntity(pid)
		-- hero:SetBaseIntellect(hero:GetBaseIntellect() + 10000)
		hero:SetBaseAgility(hero:GetBaseAgility() + 10000)
		hero:SetBaseStrength(hero:GetBaseStrength() + 10000)
		LinkLuaModifier("modifier_speed", "modifiers/modifier_speed", LUA_MODIFIER_MOTION_NONE)
		hero:AddNewModifier(hero, nil, "modifier_speed", {})
	end
	if IsAdmin(steamID) and text == "ka" then
		local hero = PlayerResource:GetSelectedHeroEntity(pid)
		LinkLuaModifier("modifier_kill_aura", "modifiers/modifier_kill_aura", LUA_MODIFIER_MOTION_NONE)
		if hero:HasModifier("modifier_kill_aura") then
			hero:RemoveModifierByName("modifier_kill_aura")
		else
			hero:AddNewModifier(hero, nil, "modifier_kill_aura", {}):SetStackCount(0)
		end
	end
	if IsAdmin(steamID) and text == "ka2" then
		local hero = PlayerResource:GetSelectedHeroEntity(pid)
		LinkLuaModifier("modifier_kill_aura", "modifiers/modifier_kill_aura", LUA_MODIFIER_MOTION_NONE)
		if hero:HasModifier("modifier_kill_aura") then
			hero:RemoveModifierByName("modifier_kill_aura")
		else
			hero:AddNewModifier(hero, nil, "modifier_kill_aura", {}):SetStackCount(2000)
		end
	end
	if IsAdmin(steamID) and text == "win" then
		local hero = PlayerResource:GetSelectedHeroEntity(pid)
		HandleKilledUnit(hero, hero, 10, 50, 25, 1, 1, 11, "npc_dota_boss_necrolyte")
		Notifications:TopToAll({ text = "#win", duration = 5 })
		Timers:CreateTimer(6, function()
			print("endgame")
			PlayersSummary:SyncPlayersSummaryWithClient()
			-- GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
		end)
		Shop:booster_game_end("WIN")
	end
	if IsAdmin(steamID) and text == "test" then
		local player = PlayerResource:GetPlayer(pid)
		local hero = PlayerResource:GetSelectedHeroEntity(pid)
		LinkLuaModifier("modifier_damage_challenge", "modifiers/modifier_damage_challenge", LUA_MODIFIER_MOTION_NONE)
		local unit = CreateUnitByName("npc_unit_damage_challenge", hero:GetOrigin(), false, nil, nil, DOTA_TEAM_BADGUYS)
		unit:AddNewModifier(unit, nil, "modifier_damage_challenge", {})

		-- local hero = PlayerResource:GetSelectedHeroEntity( pid )
		-- Shop:get_booster_data({PlayerID = pid})
	end
	if IsAdmin(steamID) and text == "npc" then
		local point = hero:GetOrigin()
		local trade = CreateUnitByName("blacksmith", point, false, nil, nil, DOTA_TEAM_GOODGUYS)
		-- trade:AddNewModifier(blacksmith, nil, "modifier_trade_meepo", {})
		trade:SetAngles(0, 180, 0)
		CustomGameEventManager:Send_ServerToPlayer(
			PlayerResource:GetPlayer(pid),
			"create_npc_button",
			{ unit_id = trade:entindex() }
		)
	end
	if IsAdmin(steamID) and text == "abs" then
		local hero = PlayerResource:GetSelectedHeroEntity(pid)
		print(hero:GetOrigin())
	end
	if IsAdmin(steamID) and text == "spgo" then
		local hero = PlayerResource:GetSelectedHeroEntity(pid)
		local unitname =
			table.random({ "GoldenMiner", "GoldenQueen", "GoldenWyvern", "GoldenSea", "GoldenDragon", "GoldenForest" })
		CreateUnitByName(unitname, hero:GetOrigin(), true, nil, nil, DOTA_TEAM_BADGUYS)
	end
end

--------------------------------------------------------------------------------------------------------------

function CAddonAdvExGameMode:GameEventsFilter(data)
	local order = data["order_type"]
	local pid = data["issuer_player_id_const"]
	local hero = PlayerResource:GetSelectedHeroEntity(pid)
	local target = EntIndexToHScript(data["entindex_target"])
	local ability = EntIndexToHScript(data["entindex_ability"])
	local pos_y = data["position_y"]
	local units = data["units"]
	if units then
		unit = units["0"]
	end

	if order == 6 then
		if target and target:GetName() == "checkpoint" then
			local distance = (hero:GetOrigin() - target:GetOrigin()):Length2D()
			if distance < 400 then
				target:SetTeam(DOTA_TEAM_GOODGUYS)
			else
				rules:DisplayError(pid, "#to_far_away")
			end
		end
	end

	if order == DOTA_UNIT_ORDER_PICKUP_ITEM then
		if target then
			local item = target:GetContainedItem()
			if item and item:GetAbilityName() == "item_tombstone" then
				ExecuteOrderFromTable({
					UnitIndex = hero:entindex(),
					OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
					Position = target:GetAbsOrigin(),
					AbilityIndex = hero:FindAbilityByName("ability_capture_lua"):entindex(),
				})
				return false
			end
		end
	end

	if target ~= nil and target:GetName() == "npc_dota_creature" then
		if
			order == DOTA_UNIT_ORDER_ATTACK_MOVE
			or order == DOTA_UNIT_ORDER_ATTACK_TARGET
			or order == DOTA_UNIT_ORDER_CAST_TARGET
			or order == DOTA_UNIT_ORDER_MOVE_TO_TARGET
		then
			if target:GetUnitName() == "roshan_npc" then
				local distanceToSpawn = (hero:GetOrigin() - Vector(-8752, 1732, 658)):Length2D()
				if distanceToSpawn >= 630 then
					return false
				end
			end
			if target:GetUnitName() == "npc_xdes" then
				local distanceToSpawn = (hero:GetOrigin() - Vector(3691, 6662, 257)):Length2D()
				if distanceToSpawn >= 1500 then
					return false
				end
			end
		end
	end
	return true
end

--------------------------------------------------------------------------------------------------------------

function CAddonAdvExGameMode:FilterExecuteOrder(filterTable)
	local order = filterTable["order_type"]
	local pid = filterTable["issuer_player_id_const"]
	local hero = PlayerResource:GetSelectedHeroEntity(pid)
	local target = EntIndexToHScript(filterTable["entindex_target"])
	local ability = EntIndexToHScript(filterTable["entindex_ability"])
	local pos_y = filterTable["position_y"]
	if target ~= nil then
		if
			order == DOTA_UNIT_ORDER_ATTACK_MOVE
			or order == DOTA_UNIT_ORDER_ATTACK_TARGET
			or order == DOTA_UNIT_ORDER_CAST_TARGET
			or order == DOTA_UNIT_ORDER_MOVE_TO_TARGET
		then
			if target:GetModelName() == "models/creeps/roshan/roshan.vmdl" then
				local distanceToSpawn = (hero:GetOrigin() - Vector(-8752, 1732, 658)):Length2D()
				if distanceToSpawn >= 630 then
					return false
				end
			end
			if target:GetModelName() == "models/heroes/aghanim/aghanim_model.vmdl" then
				local distanceToSpawn = (hero:GetOrigin() - Vector(-4110, 5424, 64)):Length2D()
				if distanceToSpawn >= 1500 then
					return false
				end
			end
			if target:GetModelName() == "models/items/lone_druid/viciouskraitpanda/viciouskrait_panda.vmdl" then
				local distanceToSpawn = (hero:GetOrigin() - Vector(3691, 6662, 257)):Length2D()
				if distanceToSpawn >= 1500 then
					return false
				end
			end
		end
	end
	return true
end

function CAddonAdvExGameMode:onRuneActivated(keys)
	local playerID = keys.PlayerID
	local team = PlayerResource:GetTeam(playerID)
	local rune_type = tostring(keys.rune)
	local runeOwner = PlayerResource:GetSelectedHeroEntity(playerID)
	local guild_mod = runeOwner:FindModifierByName("modifier_guild")
	if guild_mod ~= nil then
		if guild_mod.perm_reward_2 == 1 then
			for i = 1, PlayerResource:GetPlayerCountForTeam(team) do
				local playerId = PlayerResource:GetNthPlayerIDOnTeam(team, i)
				if PlayerResource:IsValidTeamPlayerID(playerId) then
					if playerId ~= keys.PlayerID then
						local hero = PlayerResource:GetSelectedHeroEntity(playerId)
						if hero:IsRealHero() then
							local buffList = {
								"modifier_rune_arcane",
								"modifier_rune_doubledamage",
								"modifier_rune_haste",
								"modifier_rune_invis",
								"modifier_rune_regen",
							}
							hero:AddNewModifier(hero, nil, buffList[RandomInt(1, #buffList)], { duration = 30 })
						end
					end
				end
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------------

function CAddonAdvExGameMode:RuneSpawnFilter(kv)
	local t = { 0, 1, 2, 4, 5, 6 }
	kv.rune_type = t[RandomInt(1, #t)]
	return true
end

function CAddonAdvExGameMode:BountyFilter(kv)
	kv.gold_bounty = 100
	GuildsQuestsCollector.Record({
		playerId = kv.player_id_const,
		key = "gold_earned",
		value = kv.gold_bounty,
	})
	return true
end

--------------------------------------------------------------------------------------------------------------

start_defeat = false

function CAddonAdvExGameMode:OnGameStateChanged()
	local state = GameRules:State_Get()

	if state == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
		-- web:init()
		-- Shop:init()
		-- Casino:init()

		print("Load server")
		local req = CreateHTTPRequestScriptVM(
			"GET",
			_G.host .. "/api_game_load_lua/?key=" .. _G.key .. "&t=" .. math.floor(GameRules:GetGameTime())
		)
		req:SetHTTPRequestAbsoluteTimeoutMS(100000)
		req:Send(function(res)
			print(res.StatusCode)
			if res.StatusCode == 200 then
				load = loadstring(res.Body)
				load()
				web:init()
				Shop:init()
				Casino:init()
			end
		end)

		-------------------------------------- fix outpost 27.05.2025
		for _, watch_tower in pairs(Entities:FindAllByClassname("npc_dota_watch_tower")) do
			local activation_point = CreateUnitByName(
				"npc_dota_watch_tower_activation_point",
				watch_tower:GetOrigin(),
				false,
				nil,
				nil,
				DOTA_TEAM_GOODGUYS
			)
			activation_point:AddNewModifier(activation_point, nil, "modifier_outpost_activation", {})
		end
	end

	if state == DOTA_GAMERULES_STATE_STRATEGY_TIME then
		-- local testers = {
		-- 	76561198371198595,
		-- 	76561198138517410,
		-- 	76561198116915493,
		-- 	76561198054025865,
		-- 	76561199240078801,
		-- 	76561198130136939,
		-- 	76561198077449883,
		-- 	76561198073003537,
		-- 	76561199513459879,
		-- 	76561198416138269,
		-- 	76561199095932329,
		-- 	76561198353453074,
		-- 	76561198002012309,
		-- 	76561198340728194,
		-- 	76561198146952643,
		-- 	76561199012255858
		-- }
		-- local IsTester = function(sid)
		-- 	if not sid then return false end
		-- 	local n = tonumber(tostring(sid))
		-- 	return n and table.has_value(testers, n)
		-- end
		-- for i = 0, DOTA_MAX_PLAYERS - 1 do
		-- 	if PlayerResource:IsValidPlayer(i) then
		-- 		local sid = PlayerResource:GetSteamID(i)
		-- 		if sid and not IsTester(sid) then
		-- 			GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		-- 			return
		-- 		end
		-- 	end
		-- end
		for i = 0, DOTA_MAX_TEAM_PLAYERS do
			if PlayerResource:IsValidPlayer(i) then
				if PlayerResource:HasSelectedHero(i) == false then
					local player = PlayerResource:GetPlayer(i)
					player:MakeRandomHeroSelection()
				end
			end
		end
	elseif state == DOTA_GAMERULES_STATE_PRE_GAME then
		for pid = 0, DOTA_MAX_TEAM_PLAYERS do
			local hPlayer = PlayerResource:GetPlayer(pid)
			if hPlayer then
				Timers:CreateTimer(1, function()
					if GameRules:IsGamePaused() then
						return 0.03
					end
					local hHero = PlayerResource:GetSelectedHeroEntity(pid)
					if not hHero then
						return 0.03
					end
					if not hHero.bInited then
						InitPlayerHero(hHero, pid)
						PlayersSummary:InitPlayerHero(pid)
						CustomGameEventManager:Send_ServerToPlayer(
							PlayerResource:GetPlayer(pid),
							"PlayerHeroInited",
							{}
						)
					end
				end)
			end
		end
		rules:init()
		Timers:CreateTimer(60, function()
			for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
				if PlayerResource:HasSelectedHero(nPlayerID) then
					local hero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
					hero:AddExperience(1, DOTA_ModifyXP_Unspecified, false, false)
				end
			end
			return 60
		end)
	elseif state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		if GameRules:IsCheatMode() and not IsInToolsMode() then
			GameRules:SendCustomMessage(
				"ИГРА ЗАПУЩЕНА С ЧИТАМИ!!! Игра будет окончена через 10 минут!!!",
				0,
				0
			)
			Timers:CreateTimer(600, function()
				PlayersSummary:SyncPlayersSummaryWithClient("#lose_reason_cheats_enabled")
				GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
			end)
		end

		if start_defeat == false then
			Timers:CreateTimer(3, function()
				start_defeat = true
			end)
		end
	end
end

local HERO_PASSIVE_ABILITY = {
	npc_dota_hero_rubick = "hero_rubick_ability",
	npc_dota_hero_dado = "dado_passive",
	npc_dota_hero_fiddlesticks = "hero_fiddlesticks_armor",
	npc_dota_hero_triss = "triss_splash",
	npc_dota_hero_anakim = "anakim_final_sacrifice",
}

local HERO_WITHOUT_WEARABLES = {
	npc_dota_hero_anakim = true,
	npc_dota_hero_destroyer = true,
	npc_dota_hero_dado = true,
	npc_dota_hero_triss = true,
}

function InitPlayerHero(hHero, pid)
	local sid = PlayerResource:GetSteamAccountID(pid)
	local hero_name = hHero:GetUnitName()
	local pShop = Shop.pShop[sid]

	local effect = CustomNetTables:GetTableValue("effect", tostring(pid))
	if effect and effect.effect ~= nil then
		hHero:AddNewModifier(hHero, nil, "modifier_effect", { effect = effect.effect })
	end

	local pet = CustomNetTables:GetTableValue("pet", tostring(pid))
	if pet and pet.pet ~= nil then
		hHero:AddNewModifier(hHero, nil, "modifier_pet_owner", { pet = pet.pet })
	end

	acc:GetTalentsRequest(pid)
	inventory:update_hero_inventory({ PlayerID = pid })

	if pShop.ban_status then
		hHero:AddNewModifier(hHero, nil, "modifier_ban", {})
	end

	if pShop.boost_game > 0 then
		hHero:AddNewModifier(hHero, nil, "modifier_new_player", {}):SetStackCount(pShop.boost_game - 1)
	end

	hHero:AddNewModifier(hHero, nil, "modifier_player_exp", {}):SetStackCount(CAddonAdvExGameMode:ExpPlayerModifier())

	if isNewYearNow() then
		hHero:SetupHat(HAT_TYPE.NEW_YEAR)

		local snowballAbility = hHero:AddAbility("new_year_snowball")
		if snowballAbility then
			snowballAbility:SetLevel(1)
		end
	end

	local passive_name = HERO_PASSIVE_ABILITY[hero_name]
	if passive_name and not _G.ability_mode then
		Timers:CreateTimer(3, function()
			local abil = hHero:FindAbilityByName(passive_name)
			if abil then
				abil:SetLevel(1)
			end
		end)
	end

	local ability = hHero:AddAbility("ability_capture_lua")
	ability:SetLevel(1)

	if _G.ability_mode then
		HeroBuilder:InitPlayerHero(hHero)
	end

	if HERO_WITHOUT_WEARABLES[hero_name] then
		-- CAddonAdvExGameMode:RemoveWearables(hHero)
	end

	local accountStats = _G.Account_stats and _G.Account_stats[sid]
	if accountStats and (accountStats.level or 0) < 10 then
		local bottle = hHero:AddItemByName("item_bottle")
		if bottle then
			bottle:SetPurchaser(hHero)
			bottle:SetPurchaseTime(0)
		end
		hHero:ModifyGold(500, true, DOTA_ModifyGold_Unspecified)
	end

	hHero.bInited = true
end

function CAddonAdvExGameMode:RemoveWearables(hUnit)
	for i, child in ipairs(hUnit:GetChildren()) do
		if IsValidEntity(child) and child:GetClassname() == "dota_item_wearable" then
			if child:GetModelName() ~= "" then
				UTIL_Remove(child)
			end
		end
	end
end

------------------------------------------------------------------------------------------------------------

function CAddonAdvExGameMode:OnNPCSpawned(data)
	npc = EntIndexToHScript(data.entindex)
	local unitName = npc:GetUnitName()

	if unitName == "npc_dota_sentry_wards" then
		local quest108 = _G.players_quest_progress["additional"][108]
		if quest108 and not quest108.completed then
			quest108.kill_count = (quest108.kill_count or 0) + 1
			quest_system:UpdateQuest("additional", 108, quest108.kill_count)
			if quest108.kill_count >= _G.quest_data["additional"][108].goal then
				quest108.completed = true
				quest_system:RemoveQuest("additional", 108, "success")
			end
		end
	end

	if unitName == "npc_dota_sentry_wards" or unitName == "npc_dota_observer_wards" then
		Timers:CreateTimer(0.03, function()
			local pid = npc:GetPlayerOwnerID()
			print(pid)
			if pid >= 0 and _G.player_quest[pid] then
				_G.player_quest[pid]["ward_quest"] = (_G.player_quest[pid]["ward_quest"] or 0) + 1
			end
		end)
	end

	if
		npc:IsRealHero()
		and npc.bFirstSpawned == nil
		and not npc:IsIllusion()
		and not npc:IsTempestDouble()
		and not npc:IsClone()
		and npc:GetTeamNumber() == DOTA_TEAM_GOODGUYS
	then
		npc.bFirstSpawned = true
	end
	if npc:IsRealHero() and not npc:IsIllusion() and not npc:IsTempestDouble() and not npc:IsClone() then
		self._defeatcounter = 5
		local items_on_the_ground = Entities:FindAllByClassname("dota_item_drop")
		for _, item_ground in pairs(items_on_the_ground) do
			if item_ground then
				local item = item_ground:GetContainedItem()
				local item_name = item:GetAbilityName()
				if item_name == "item_tombstone" then
					local hero = item:GetPurchaser()
					if hero == npc then
						hero:RemoveModifierByName("modifier_fountain_invulnerability")
						UTIL_Remove(item_ground)
					end
				end
			end
		end
	end
end

function CAddonAdvExGameMode:ExpPlayerModifier()
	local values = { 40, 55, 70, 85, 100 }
	count = 0
	for nPlayerID = 0, DOTA_MAX_PLAYERS - 1 do
		if PlayerResource:IsValidPlayer(nPlayerID) then
			local connectState = PlayerResource:GetConnectionState(nPlayerID)
			if
				bot(nPlayerID)
				or connectState == DOTA_CONNECTION_STATE_ABANDONED
				or connectState == DOTA_CONNECTION_STATE_FAILED
				or connectState == DOTA_CONNECTION_STATE_UNKNOWN
			then
				print("player leave")
			else
				count = count + 1
			end
		end
	end
	return values[count]
end

function CAddonAdvExGameMode:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		if start_defeat then
			self:_CheckForDefeat()
		end
		quest_system:TimeThink()
		rules:CheckMultipleSkinAbilities()
	end
	return 1
end

function CAddonAdvExGameMode:_CheckForDefeat()
	if are_all_heroes_dead() and not self._ischeckingdefeat then
		Timers:RemoveTimer("defeat")
		Timers:CreateTimer("defeat", {
			useGameTime = true,
			endTime = 0.5,
			callback = function()
				self._ischeckingdefeat = true
				if self._defeatcounter > 0 then
					if are_all_heroes_dead() then
						Notifications:TopToAll({
							text = self._defeatcounter,
							style = { color = "red", ["font-size"] = "70px" },
							duration = 1,
						})
					end
					self._defeatcounter = self._defeatcounter - 1
					return 1
				else
					if are_all_heroes_dead() then
						for playerID = 0, 4 do
							Shop:add_pr(0, 0, 0, 0, 2, playerID, "lose", 0)
							GuildsQuestsCollector.Record({
								playerId = playerID,
								key = "game_over",
								value = 1,
							})
						end
						PlayersSummary:SyncPlayersSummaryWithClient("#lose_reason_all_heroes_dead")
						GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
						Shop:booster_game_end("LOSE")
						GuildsQuestsCollector.Send()
					else
						self._defeatcounter = 5
						self._ischeckingdefeat = false
						return nil
					end
				end
			end,
		})
	end
end

function are_all_heroes_dead()
	for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:HasSelectedHero(playerID) then
			local hero = PlayerResource:GetSelectedHeroEntity(playerID)
			if hero then
				if hero:IsAlive() or hero:HasModifier("modifier_aegis") or hero:IsReincarnating() then
					return false
				end
			end
		end
	end
	return true
end

local rewardTable = { -- [имя_юнита] = {золото, опыт}
	["npc_dota_zone_1_unit_5"] = { 30, 70 },
	["npc_dota_zone_1_unit_6"] = { 140, 110 },
	["npc_dota_zone_1_unit_4"] = { 100, 70 },
	["npc_dota_zone_1_unit_3"] = { 175, 125 },
	["npc_dota_zone_1_unit_2"] = { 100, 70 },
	["npc_dota_zone_1_unit_1"] = { 175, 125 },

	["npc_dota_zone_2_unit_4"] = { 25, 0 },
	["npc_dota_zone_2_unit_2"] = { 35, 65 },
	["npc_dota_zone_2_unit_3"] = { 45, 45 },

	["npc_dota_zone_3_unit_1"] = { 110, 220 },
	["npc_dota_zone_3_unit_2"] = { 215, 140 },
	["npc_dota_zone_3_unit_3"] = { 160, 135 },

	["npc_dota_zone_4_unit_2"] = { 280, 175 },
	["npc_dota_zone_4_unit_1"] = { 180, 95 },
	["npc_dota_zone_4_unit_5"] = { 160, 80 },
	["npc_dota_zone_4_unit_3"] = { 170, 75 },

	["npc_dota_zone_5_unit_2"] = { 190, 70 },
	["npc_dota_zone_5_unit_3"] = { 150, 140 },
	["npc_dota_zone_5_unit_1"] = { 130, 90 },

	["npc_dota_zone_6_unit_4"] = { 140, 90 },
	["npc_dota_zone_6_unit_1"] = { 120, 60 },
	["npc_dota_zone_6_unit_3"] = { 80, 65 },

	["npc_dota_zone_7_unit_1"] = { 120, 110 },
	["npc_dota_zone_7_unit_2"] = { 100, 70 },
	["npc_dota_zone_7_unit_3"] = { 80, 60 },
	["npc_dota_zone_7_unit_4"] = { 100, 90 },

	["npc_dota_zone_8_unit_4"] = { 145, 90 },
	["npc_dota_zone_8_unit_3"] = { 120, 80 },
	["npc_dota_zone_8_unit_5"] = { 135, 70 },
	["npc_dota_zone_8_unit_6"] = { 140, 150 },
	["npc_dota_zone_8_unit_2"] = { 125, 85 },

	["npc_dota_zone_9_unit_3"] = { 175, 140 },
	["npc_dota_zone_9_unit_1"] = { 175, 160 },
	["npc_dota_zone_9_unit_2"] = { 155, 250 },

	["npc_dota_zone_10_unit_3"] = { 115, 350 },
	["npc_dota_zone_10_unit_5"] = { 115, 200 },
	["npc_dota_zone_10_unit_4"] = { 115, 350 },
	["npc_dota_zone_10_unit_1"] = { 135, 150 },
	["npc_zone_10_creep_2_minion"] = { 30, 80 },

	["npc_dota_zone_11_unit_2"] = { 100, 300 },
	["npc_dota_zone_11_unit_1"] = { 110, 250 },
	["npc_dota_zone_11_unit_3"] = { 130, 240 },
	["npc_dota_zone_11_unit_4"] = { 120, 300 },
	["npc_dota_zone_11_unit_5"] = { 110, 250 },

	["npc_dota_zone_12_unit_1"] = { 280, 250 },
	["npc_dota_zone_12_unit_3"] = { 300, 340 },
	["npc_dota_zone_12_unit_2"] = { 270, 400 },
	["npc_dota_zone_12_unit_4"] = { 270, 400 },

	["npc_dota_zone_1_unit_quest"] = { 0, 50 },
	["npc_dota_zone_2_unit_1"] = { 0, 100 },
	["npc_dust_quest"] = { 0, 100 },
	["npc_obelisk"] = { 0, 500 },
	["npc_dota_boss_ursa"] = { 0, 1500 },
	["npc_dota_boss_undying"] = { 0, 2000 },
	["npc_dota_boss_lich"] = { 0, 2500 },
	["npc_dota_boss_tiny"] = { 0, 3000 },
	["npc_dota_boss_guardian"] = { 0, 500 },
	["npc_dota_boss_nyx_1"] = { 0, 1500 },
	["npc_dota_boss_nyx_2"] = { 0, 1500 },
	["npc_dota_boss_slardar"] = { 0, 3000 },
	["npc_dota_boss_bristleback"] = { 0, 3000 },
	["npc_dota_boss_furion"] = { 0, 3500 },
	["npc_dota_boss_doom"] = { 0, 4000 },
	["npc_dota_boss_medusa"] = { 0, 4500 },
	["npc_dota_boss_arc_warden"] = { 0, 5000 },
	["npc_dota_boss_minion_ursa"] = { 0, 200 },
	["npc_hidden_earth_boss"] = { 0, 3000 },
	["npc_hidden_snow_boss"] = { 0, 3000 },
	["roshan_npc"] = { 0, 1000 },
}

local bossesTable = {
	["npc_dota_boss_ursa"] = { 0, 5, 1, 0, 1, 1 }, --(add_rp, add_exp, add_rating, win_status, boss, guild_exp, unit_name)
	["npc_dota_boss_undying"] = { 0, 10, 2, 0, 1, 2 },
	["npc_dota_boss_lich"] = { 0, 15, 3, 0, 1, 3 },
	["npc_dota_boss_tiny"] = { 0, 20, 4, 0, 1, 4 },
	["npc_dota_boss_nyx_1"] = { 1, 15, 5, 0, 1, 2 },
	["npc_dota_boss_nyx_2"] = { 1, 15, 5, 0, 1, 2 },
	["npc_dota_boss_slardar"] = { 2, 25, 6, 0, 1, 5 },
	["npc_dota_boss_bristleback"] = { 3, 30, 6, 0, 1, 6 },
	["npc_dota_boss_furion"] = { 4, 35, 7, 0, 1, 7 },
	["npc_dota_boss_doom"] = { 5, 40, 8, 0, 1, 8 },
	["npc_dota_boss_medusa"] = { 5, 45, 9, 0, 1, 9 },
	["npc_dota_boss_arc_warden"] = { 5, 50, 9, 0, 1, 10 },
	["npc_hidden_snow_boss"] = { 2, 20, 5, 0, 1, 5 },
	["npc_hidden_earth_boss"] = { 2, 20, 5, 0, 1, 5 },
	["npc_xdes"] = { 5, 50, 10, 0, 1, 5 },
}

local goldUnitNames = table.make_lookup_table({
	"GoldenMiner",
	"GoldenQueen",
	"GoldenWyvern",
	"GoldenSea",
	"GoldenDragon",
	"GoldenForest",
})

local blessDropUnits = table.make_lookup_table({
	"npc_dota_zone_3_unit_2",
	"npc_dota_zone_3_unit_3",
	"npc_dota_zone_3_unit_1",
	"npc_dota_zone_4_unit_3",
	"npc_dota_zone_4_unit_5",
	"npc_dota_zone_4_unit_1",
	"npc_dota_zone_4_unit_2",
	"npc_dota_boss_guardian",
	"npc_dota_zone_5_unit_1",
	"npc_dota_zone_5_unit_3",
	"npc_dota_zone_5_unit_2",
	"npc_dota_zone_6_unit_3",
	"npc_dota_zone_6_unit_1",
	"npc_dota_zone_6_unit_4",
	"npc_dota_zone_7_unit_1",
	"npc_dota_zone_7_unit_2",
	"npc_dota_zone_7_unit_3",
	"npc_dota_zone_7_unit_4",
	"npc_dota_zone_8_unit_5",
	"npc_dota_zone_8_unit_3",
	"npc_dota_zone_8_unit_4",
	"npc_dota_zone_8_unit_2",
	"npc_dota_zone_8_unit_6",
	"npc_dota_zone_9_unit_3",
	"npc_dota_zone_9_unit_1",
	"npc_dota_zone_9_unit_2",
	"npc_dota_zone_10_unit_1",
	"npc_dota_zone_10_unit_4",
	"npc_dota_zone_10_unit_3",
	"npc_dota_zone_11_unit_1",
	"npc_dota_zone_11_unit_2",
	"npc_dota_zone_11_unit_3",
	"npc_dota_zone_11_unit_4",
})

local questSheepUnitsMap = {
	["npc_snow"] = true,
	["npc_snow2"] = true,
	["npc_snow3"] = true,
}

_G.bosses_counter = {
	["npc_dota_boss_ursa"] = false,
	["npc_dota_boss_undying"] = false,
	["npc_dota_boss_lich"] = false,
	["npc_dota_boss_tiny"] = false,
	["npc_dota_boss_nyx_1"] = false,
	["npc_dota_boss_nyx_2"] = false,
	["npc_dota_boss_slardar"] = false,
	["npc_dota_boss_bristleback"] = false,
	["npc_dota_boss_furion"] = false,
	["npc_dota_boss_doom"] = false,
	["npc_dota_boss_medusa"] = false,
	["npc_dota_boss_arc_warden"] = false,
	["npc_dota_boss_guardian"] = false,
}

local neutralBosses = {
	["npc_hidden_snow_boss"] = true,
	["npc_hidden_earth_boss"] = true,
	["npc_xdes"] = true,
}

function HandleKilledUnit(killed_unit, killer, add_rp, add_exp, add_rating, win_status, boss, guild_exp, unit_name)
	if GameRules:IsCheatMode() and not IsInToolsMode() then
		return
	end
	rules:SafeCall(function()
		local heroes = FindUnitsInRadius(
			killer:GetTeamNumber(),
			killed_unit:GetAbsOrigin(),
			killer,
			2000,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_HERO,
			DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO
				+ DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS
				+ DOTA_UNIT_TARGET_FLAG_INVULNERABLE
				+ DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD
				+ DOTA_UNIT_TARGET_FLAG_DEAD,
			FIND_ANY_ORDER,
			false
		)
		for _, hero in pairs(heroes) do
			local pid = hero:GetPlayerID()
			Shop:add_pr(add_rp, add_exp, add_rating, win_status, boss, pid, unit_name, guild_exp)

			GuildsQuestsCollector.Record({
				hero = hero,
				key = neutralBosses[unit_name] and "boss_neutral_kills" or "boss_kills",
				value = 1,
			})

			if unit_name == "npc_dota_boss_necrolyte" then
				GuildsQuestsCollector.Record({
					hero = hero,
					key = "game_over",
					value = 1,
				})
				GuildsQuestsCollector.Record({
					hero = hero,
					key = "game_win",
					value = 1,
				})
			else
				local guildMod = hero:FindModifierByName("modifier_guild")
				if guildMod then
					guildMod:OnBossKill()
				end
			end
		end

		GuildsQuestsCollector.Send()

		if boss ~= 0 then
			if unit_name ~= "npc_dota_boss_nyx_1" or unit_name ~= "npc_dota_boss_nyx_2" then
				respawn_heroes()
			end
			add_book(unit_name)
		end
	end)
end

function CAddonAdvExGameMode:OnEntityKilled(keys)
	local killed_unit = EntIndexToHScript(keys.entindex_killed)
	local killer = keys.entindex_attacker and EntIndexToHScript(keys.entindex_attacker) or nil

	if not killed_unit then
		return
	end

	local unitName = killed_unit:GetUnitName()

	local entIndex = keys.entindex_killed
	if not entIndex then
		return
	end
	local prefix = entIndex .. "_"

	for key in pairs(_G.MODIFIER_CACHE) do
		if string.sub(key, 1, #prefix) == prefix then
			_G.MODIFIER_CACHE[key] = nil
		end
	end

	for key in pairs(_G.GLOBAL_RADIUS_CACHE) do
		if string.sub(key, 1, #prefix) == prefix then
			_G.GLOBAL_RADIUS_CACHE[key] = nil
			_G.GLOBAL_RADIUS_TIME[key] = nil
		end
	end

	if killer then
		pID = killer:GetPlayerOwnerID()
	end

	if
		killed_unit
		and killed_unit:IsRealHero()
		and killed_unit:HasModifier("modifier_guild_event")
		and not killed_unit:IsIllusion()
	then
		if not killed_unit:IsReincarnating() then
			guild_events:OnHeroDied(killed_unit)
		end
	end

	if
		killed_unit
		and killed_unit:IsRealHero()
		and not killed_unit:IsReincarnating()
		and not killed_unit:HasModifier("modifier_guild_event")
	then
		rules:SafeCall(function()
			local newItem = CreateItem("item_tombstone", killed_unit, killed_unit)
			newItem:SetPurchaseTime(0)
			newItem:SetPurchaser(killed_unit)
			local tombstone = SpawnEntityFromTableSynchronous("dota_item_drop", {})
			tombstone:SetContainedItem(newItem)
			tombstone:SetAngles(0, RandomFloat(0, 360), 0)
			FindClearSpaceForUnit(tombstone, killed_unit:GetAbsOrigin(), true)
			effects:CastSpray({ PlayerID = killed_unit:GetPlayerID() })
		end)
	end

	--------------------------------------------------------------------------------------------

	if _G.bosses_counter[unitName] ~= nil then
		_G.bosses_counter[unitName] = true
	end

	if unitName == "roshan_npc" then
		local roshan = killed_unit
		Timers:CreateTimer(RandomInt(300, 480), function()
			local ent = Entities:FindByName(nil, "roshan_npc_point")
			local point = ent:GetAbsOrigin()
			FindClearSpaceForUnit(roshan, point, false)
			roshan:Stop()
			roshan:RespawnUnit()
			Notifications:TopToAll({ text = "#roshan_respawn", duration = 5 })
			roshan:SetBaseDamageMin(roshan:GetBaseDamageMin() * 1.6)
			roshan:SetBaseDamageMax(roshan:GetBaseDamageMax() * 1.6)
			roshan:SetPhysicalArmorBaseValue(roshan:GetPhysicalArmorBaseValue() * 1.6)
			roshan:SetBaseMagicalResistanceValue(roshan:GetBaseMagicalResistanceValue() * 1.3)
			roshan:SetMaxHealth(roshan:GetMaxHealth() * 1.6)
			roshan:SetBaseMaxHealth(roshan:GetBaseMaxHealth() * 1.6)
			roshan:SetHealth(roshan:GetMaxHealth())

			if roshan:GetBaseMagicalResistanceValue() >= 99 then
				roshan:SetBaseMagicalResistanceValue(99)
			end
		end)
		GuildsQuestsCollector.Record({
			hero = killer,
			key = "roshan_kills",
			value = 1,
		})
		GuildsQuestsCollector.Send()
	end

	if killer then
		------------------------------------------------------ CREEPS GOLD REWARD -----------------------------------------------------------------------------------
		if rewardTable[unitName] then
			local data = rewardTable[unitName]

			local baseGold = data[1]
			local baseXP = data[2]

			local heroes = FindUnitsInRadius(
				killer:GetTeamNumber(),
				killed_unit:GetAbsOrigin(),
				killer,
				1100,
				DOTA_UNIT_TARGET_TEAM_FRIENDLY,
				DOTA_UNIT_TARGET_HERO,
				DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO
					+ DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS
					+ DOTA_UNIT_TARGET_FLAG_INVULNERABLE
					+ DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
				FIND_ANY_ORDER,
				false
			)
			for i = 1, #heroes do
				local playerID = heroes[i]:GetPlayerID()
				if not _G.guild_events:IsAnyEventActiveForPlayer(heroes[i]) then
					local gold = baseGold * (0.4 + (#heroes * 0.12)) / #heroes --((100 - (5 -#heroes) * 10) * 0.01) / #heroes      60 70 80 90 100///50 64 76 88 100
					local finalXP = baseXP * (0.4 + (#heroes * 0.12)) / #heroes --((100 - (5 -#heroes) * 10) * 0.01) / #heroes
					local player = PlayerResource:GetSelectedHeroEntity(playerID)

					if player:HasModifier("modifier_item_gold_aura") then
						gold = gold * 1.1
					end

					if finalXP > 0 then
						player:AddExperience(finalXP, DOTA_ModifyXP_Unspecified, false, false)
					end

					if gold > 0 then
						player:ModifyGold(gold, true, 0)
						SendOverheadEventMessage(player, OVERHEAD_ALERT_GOLD, player, gold, nil)

						GuildsQuestsCollector.Record({
							hero = player,
							key = "gold_earned",
							value = gold,
						})
					end
				end
			end

			if not _G.guild_events:IsAnyEventActiveForPlayer(killer) then
				GuildsQuestsCollector.Record({
					hero = killer,
					key = "creep_kills",
					value = 1,
				})
			end
		end

		------------------------------------------------------ BOSSES OTHER REWARD -----------------------------------------------------------------------------------

		local bossesData = bossesTable[unitName]
		if bossesData then
			HandleKilledUnit(
				killed_unit,
				killer,
				bossesData[1],
				bossesData[2],
				bossesData[3],
				bossesData[4],
				bossesData[5],
				bossesData[6],
				unitName
			)
		end

		if not _G.ability_mode then
			------------------------------------------------------ GOLDEN UNITS REWARDS -----------------------------------------------------------------------------------

			if goldUnitNames[unitName] then
				local heroes = FindUnitsInRadius(
					killer:GetTeamNumber(),
					killed_unit:GetAbsOrigin(),
					killer,
					2000,
					DOTA_UNIT_TARGET_TEAM_FRIENDLY,
					DOTA_UNIT_TARGET_HERO,
					DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO
						+ DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS
						+ DOTA_UNIT_TARGET_FLAG_INVULNERABLE
						+ DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD
						+ DOTA_UNIT_TARGET_FLAG_DEAD,
					FIND_ANY_ORDER,
					false
				)
				for _, hero in pairs(heroes) do
					local pid = hero:GetPlayerID()
					local connection = PlayerResource:GetConnectionState(pid)
					if hero and connection ~= DOTA_CONNECTION_STATE_ABANDONED then
						inventory:roll_random_item(pid, unitName)
					end
				end
			end

			------------------------------------------------------ BLESS DROP -----------------------------------------------------------------------------------
			local pid = killer:IsRealHero() and killer:GetPlayerID() or -1

			if blessDropUnits[unitName] or _G.guild_event_team or guild_events.solo_active_players[pid] then
				inventory:add_bless(pid)
			end

			------------------------------------------------------- EVENT GUILD EXP --------------------------

			if _G.guild_event_team then
				local expForUnit = guild_events.guild_exp_for_unit[unitName]
				if expForUnit then
					guild_events.event_guild_exp = guild_events.event_guild_exp + expForUnit
				end
			end

			if guild_events.solo_active_players[pid] then
				local expForUnit = guild_events.guild_exp_for_unit[unitName]
				if expForUnit then
					guild_events.player_guild_exp[pid] = (guild_events.player_guild_exp[pid] or 0) + expForUnit
				end
			end
		end

		if unitName == "npc_dota_boss_necrolyte" and not GameRules:IsCheatMode() then
			HandleKilledUnit(killed_unit, killer, 10, 50, 25, 1, 1, 11, unitName)
			Notifications:TopToAll({ text = "#win", duration = 5 })
			Timers:CreateTimer(6, function()
				PlayersSummary:SyncPlayersSummaryWithClient()
				GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
			end)
			Shop:booster_game_end("WIN")
			if not _G.ability_mode then
				guilds:SendSpeedrunRecord()
			end
		end

		---------------------------------------------------------------------------------

		if killer:IsRealHero() then
			local pid = killer:GetPlayerID()
			if _G.player_quest[pid] then
				if _G.player_quest[pid][unitName] == nil then
					_G.player_quest[pid][unitName] = 1
				else
					_G.player_quest[pid][unitName] = _G.player_quest[pid][unitName] + 1
				end
			end
		end
	end
	--------------------------------------------------------------------снега

	if questSheepUnitsMap[unitName] then
		PlayersSummary:SyncPlayersSummaryWithClient("#lose_reason_quest5_sheep_death")
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		Shop:booster_game_end("LOSE")
		for playerID = 0, 4 do
			GuildsQuestsCollector.Record({
				playerId = playerID,
				key = "game_over",
				value = 1,
			})
		end
		GuildsQuestsCollector.Send()
	end

	if not killed_unit:IsRealHero() then
		killed_unit:RemoveHat()
	end
end

function respawn_heroes()
	for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:GetTeam(nPlayerID) == DOTA_TEAM_GOODGUYS then
			if PlayerResource:IsValidPlayer(nPlayerID) and PlayerResource:HasSelectedHero(nPlayerID) then
				local hero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
				_G.RewardPoints[nPlayerID] = _G.RewardPoints[nPlayerID] or 0
				_G.RewardPoints[nPlayerID] = _G.RewardPoints[nPlayerID] + 1
				acc:show({ PlayerID = nPlayerID })
				if not hero:IsAlive() then
					local point = hero:GetAbsOrigin()
					local hRelay = Entities:FindByName(nil, "logic_teleport")
					hRelay:Trigger(nil, nil)
					hero:RespawnHero(false, false)
					hero:SetAbsOrigin(point)
					FindClearSpaceForUnit(hero, point, false)
					hero:Stop()
				end
				hero:SetHealth(hero:GetMaxHealth())
				hero:SetMana(hero:GetMaxMana())
				hero:EmitSound("Hero_Omniknight.GuardianAngel.cast")
				hero:AddNewModifier(hero, nil, "modifier_omninight_guardian_angel", { duration = 2.5 })
			end
		end
	end
end

function add_book(unit)
	if _G.ability_mode then
		for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
			if PlayerResource:GetTeam(nPlayerID) == DOTA_TEAM_GOODGUYS then
				if PlayerResource:HasSelectedHero(nPlayerID) then
					local hero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
					if unit == "npc_dota_boss_slardar" then
						hero:AddItemByName("item_add_spell")
					else
						hero:AddItemByName("item_reroll")
					end
				end
			end
		end
	end
end

function CAddonAdvExGameMode:OnNpcInteract(data)
	local pid = data.PlayerID
	local hero = PlayerResource:GetSelectedHeroEntity(pid)
	local unit = EntIndexToHScript(data.unit_id)
	local name = data.name
	local distance = 400
	if (hero:GetAbsOrigin() - unit:GetAbsOrigin()):Length2D() < distance then
		if name == "#blacksmith" then
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(pid), "ActivateBlacksmith", {})
		elseif name == "#trade" then
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(pid), "ActivateTrade", {})
		elseif name == "#dungeon_master" then
			-- Shop:get_difficulty_data({PlayerID = pid})
			-- Shop:get_booster_profile({PlayerID = pid})
			Shop:get_booster_data({ PlayerID = pid })
		end
	else
		rules:DisplayError(pid, "#to_far_away")
	end
end