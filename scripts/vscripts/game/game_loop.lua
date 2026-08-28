--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


GameLoop = GameLoop or {}

require("game/modifiers/init")
require("game/shuffle")

function GameLoop:Init()
	EventDriver:Listen("Events:hero_killed", GameLoop.OnUnitKilled, GameLoop)
	EventDriver:Listen("Events:entity_killed", GameLoop.OnEntityKilled, GameLoop)

	ListenToGameEvent("dota_player_killed", Dynamic_Wrap(self, "OnHeroKilled"), self)

	local current_layout = TEAMS_LAYOUTS[GetMapName()]
	if not current_layout then
		return
	end
	GameLoop.current_layout = current_layout

	GameLoop.do_stagger_gold = false
	GameLoop.staggered_gold = {}

	GameLoop.max_teams = #current_layout.teamlist

	GameLoop.hero_by_player_id = {}
	GameLoop.heroes_by_team = {}

	GameLoop.game_over = false

	GameLoop.current_gold_scale_factor = GOLD_SCALE_FACTOR_INITIAL
	GameLoop.current_xp_scale_factor = XP_SCALE_FACTOR_INITIAL

	GameLoop.ancients = {}
	GameLoop.fountains = {}

	GameLoop.barracks_bonus = {
		[DOTA_TEAM_BADGUYS] = 0,
		[DOTA_TEAM_GOODGUYS] = 0,
	}

	GameLoop.low_winrate_gold_applied = {}

	GameLoop:InitFountains()
	GameLoop:InitTowers()
	GameLoop:OverrideAncients()
	GameLoop:SetupCamps()
	GamePerks:Init()

	self.state_changed_listener = EventDriver:Listen("Events:state_changed", GameLoop.OnStateChanged, GameLoop)

	GameLoop.tethered_targets = {}

	EventStream:Listen("pick_random_hero", function(event)
		GameLoop:PickRandomHero(event.PlayerID)
	end)
	EventDriver:Listen("EventProxy:OnModifierAdded", GameLoop.OnModifierAdded, GameLoop)
end

function GameLoop:OnModifierAdded(event)
	if not event.unit then
		return
	end
	if not event.added_buff or not event.added_buff.GetName or not event.added_buff.GetCaster then
		return
	end

	local caster = event.added_buff:GetCaster()
	if not IsValidEntity(caster) or not caster.GetPlayerOwnerID then
		return
	end

	local caster_owner_id = caster:GetPlayerOwnerID()
	if not caster_owner_id then
		return
	end

	local mod_name = event.added_buff:GetName()

	local clear_tether = function(_target)
		if IsValidEntity(_target) then
			if not PlayerResource:IsDisableHelpSetForPlayerID(_target:GetPlayerOwnerID(), caster_owner_id) then
				return
			end

			_target:RemoveModifierByName("modifier_wisp_tether_haste")
			caster:RemoveModifierByName("modifier_wisp_tether")
		end
	end

	if mod_name == "modifier_wisp_tether_haste" then
		if caster:HasModifier("modifier_wisp_relocate_return") then
			Timers:CreateTimer(0, function()
				clear_tether(event.unit)
			end)
		else
			GameLoop.tethered_targets[caster_owner_id] = event.unit
		end
	end

	if mod_name == "modifier_wisp_relocate_return" and GameLoop.tethered_targets[caster_owner_id] then
		clear_tether(GameLoop.tethered_targets[caster_owner_id])
	end

	if mod_name == "modifier_item_ultimate_scepter_consumed_alchemist" then
		event.unit:AddNewModifier(caster, nil, "modifier_alchemist_consumable_scepter_nerf", { duration = -1 })
	end
end

function GameLoop:OnStateChanged(event)
	print("[Game Loop] game state changed to", event.state)

	if event.state == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
		if DEV_BOTS_ENABLED == true then
			Timers:CreateTimer(0.5, function()
				SendToServerConsole("sm_gmode 1")
				SendToServerConsole("dota_bot_populate")
			end)
		end

		GameRules:LockCustomGameSetupTeamAssignment(false)
		Shuffle:DoTeamShuffle()

		Timers:CreateTimer(1, function()
			GameRules:LockCustomGameSetupTeamAssignment(true)
		end)

		local player_count = PlayerResource:NumPlayers()
		local max_players = GameLoop.current_layout.player_count * #GameLoop.current_layout.teamlist

		GameLoop.is_full_lobby = player_count == max_players

		DebugMessage("[Game Loop] full lobby status: ", GameLoop.is_full_lobby, player_count, "/", max_players)

		if not GameLoop.is_full_lobby then
			--GameRules:LockCustomGameSetupTeamAssignment(false)
			GameRules:SetCustomGameSetupAutoLaunchDelay(15)
			Timers:CreateTimer(15, function()
				GameRules:FinishCustomGameSetup()
			end)
		else
			Timers:CreateTimer(3, function()
				GameRules:FinishCustomGameSetup()
			end)
		end
	end

	if event.state == DOTA_GAMERULES_STATE_WAIT_FOR_MAP_TO_LOAD then
		local game_mode = GameRules:GetGameModeEntity()

		GameLoop.wait_for_load_pause = false
		-- PauseGame(GameLoop.wait_for_load_pause)

		game_mode:SetContextThink("ot3_loadpause_think", function()
			if GameLoop.wait_for_load_pause then
				local selected_heroes = 0
				local spawned_heroes = 0

				for player_id = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
					if PlayerResource:IsValidPlayerID(player_id) then
						if PlayerResource:GetSelectedHeroName(player_id) ~= "" then
							selected_heroes = selected_heroes + 1
						end

						if PlayerResource:GetSelectedHeroEntity(player_id) then
							spawned_heroes = spawned_heroes + 1
						end
					end
				end

				if spawned_heroes >= selected_heroes then
					GameLoop.wait_for_load_pause = nil
					PauseGame(false)
					return
				end

				return 2
			end
		end, 2)

		game_mode:SetContextThink("ot3_loadpause_watchdog", function()
			if GameLoop.wait_for_load_pause then
				GameLoop.wait_for_load_pause = nil
				PauseGame(false)
			end
		end, 20)
	end

	if event.state == DOTA_GAMERULES_STATE_PRE_GAME then
		Timers:CreateTimer(3, function()
			Shuffle:AnnounceWeakTeam()

			local shops = Entities:FindAllByClassname("trigger_shop")

			for _, shop in pairs(shops) do
				UTIL_Remove(shop)
			end

			local global_shop = SpawnDOTAShopTriggerRadiusApproximate(Vector(0, 0, 0), 40000)
			global_shop:SetShopType(DOTA_SHOP_HOME)

			GameLoop:FixDefendersGateFX()
		end)
	end

	if event.state ~= DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		return
	end

	GameLoop.game_start_time = GetSystemTimeMS()

	print("[Game Loop] starting duration timer and common upgrades timer")

	self.game_loop_update = Timers:CreateTimer(1, function()
		local current_time = GameRules:GetDOTATime(false, false)
		local gold_factor_scale = math.min(math.max(current_time / GOLD_SCALE_FACTOR_FADEIN_SECONDS, 0), 1)
		local xp_factor_scale = math.min(math.max(current_time / XP_SCALE_FACTOR_FADEIN_SECONDS, 0), 1)

		GameLoop.current_gold_scale_factor = GOLD_SCALE_FACTOR_INITIAL
			+ (gold_factor_scale * (GOLD_SCALE_FACTOR_FINAL - GOLD_SCALE_FACTOR_INITIAL))
		GameLoop.current_xp_scale_factor = XP_SCALE_FACTOR_INITIAL
			+ (xp_factor_scale * (XP_SCALE_FACTOR_FINAL - XP_SCALE_FACTOR_INITIAL))

		return 1
	end)

	local gpm_player_id = 0
	self.custom_gpm = Timers:CreateTimer(0, function()
		if CUSTOM_GPM_GOLD_PER_TICK <= 0 then
			return CUSTOM_GPM_INTERVAL
		end

		local gold_to_add = CUSTOM_GPM_GOLD_PER_TICK

		if GameLoop.staggered_gold[gpm_player_id] and GameLoop.staggered_gold[gpm_player_id] > 0 then
			gold_to_add = math.ceil(gold_to_add + GameLoop.staggered_gold[gpm_player_id])
			GameLoop.staggered_gold[gpm_player_id] = 0
		end

		local bonus_gold_t = BONUS_GOLD_PLAYERS[gpm_player_id]
		if bonus_gold_t and bonus_gold_t.gold > 0 then
			local bonus_gold_perk = math.floor(math.min(bonus_gold_t.gold_per_operation, bonus_gold_t.gold))
			bonus_gold_t.gold = bonus_gold_t.gold - bonus_gold_perk

			gold_to_add = math.ceil(gold_to_add + bonus_gold_perk)
		end

		local hero = GameLoop.hero_by_player_id[gpm_player_id]
		if IsValidEntity(hero) then
			-- print("give gold for player, ", gpm_player_id, hero:GetUnitName(), gold_to_add)
			hero:ModifyGold(gold_to_add, true, DOTA_ModifyGold_GameTick)
		end

		gpm_player_id = gpm_player_id + 1
		if gpm_player_id > 23 then
			gpm_player_id = 0
		end

		return CUSTOM_GPM_INTERVAL
	end)

	self.redistribute_gold_update = Timers:CreateTimer(REDISTRIBUTE_GOLD_INTERVAL, function()
		Kicks:RedistributeGoldUpdate()
		return REDISTRIBUTE_GOLD_INTERVAL
	end)

	self.fix_positions_timer = Timers:CreateTimer(0, function()
		for player_id = 0, 23 do
			GameLoop:FixHeroPosition(player_id)
		end

		return 5
	end)
end

function GameLoop:FixHeroPosition(player_id)
	if not PlayerResource:IsValidPlayer(player_id) then
		return
	end

	local hero = PlayerResource:GetSelectedHeroEntity(player_id)
	if not IsValidEntity(hero) or not hero:IsAlive() then
		return
	end

	local pos = hero:GetAbsOrigin()
	local x, y, z = pos.x, pos.y, pos.z
	local max = 9000
	local offset = 200

	if math.abs(x) > max or math.abs(y) > max or math.abs(z) > 10000 then
		local new_x = math.abs(x) > max and (max - offset) * (x > 0 and 1 or -1) or x
		local new_y = math.abs(y) > max and (max - offset) * (y > 0 and 1 or -1) or y
		FindClearSpaceForUnit(hero, Vector(new_x, new_y, 0), false)
	end

	local connection_state = PlayerResource:GetConnectionState(player_id)
	if
		connection_state == DOTA_CONNECTION_STATE_DISCONNECTED
		or connection_state == DOTA_CONNECTION_STATE_ABANDONED
	then
		local move_pos = GetFountainSpawnPosition(hero:GetTeam(), 150)
		if (move_pos - hero:GetAbsOrigin()):Length2D() > 310 then
			hero:Interrupt()
			hero:MoveToPosition(move_pos)
		end
	end
end

function GameLoop:AddDelayedGold(player_id, gold)
	GameLoop.staggered_gold[player_id] = (GameLoop.staggered_gold[player_id] or 0) + gold
	-- print("[GameLoop] staggered gold", player_id, gold, GameLoop.staggered_gold[player_id])
end

function GameLoop:OnHeroKilled(event)
	-- GameLoop:SetRespawnTime(event.PlayerID)
end

function GameLoop:OnUnitKilled(event) end

function GameLoop:InitHero(hero)
	if not IsValidEntity(hero) then
		return
	end
	print("[GameLoop] Initializing hero", hero:GetUnitName())

	local player_id = hero:GetPlayerOwnerID()
	local team = hero:GetTeam()

	GameLoop.hero_by_player_id[player_id] = hero
	GameLoop.heroes_by_team[team] = GameLoop.heroes_by_team[team] or {}

	table.insert(GameLoop.heroes_by_team[team], hero)

	-- hero:AddNewModifier(hero, nil, "modifier_primary_attribute_reader", {duration = -1})
	-- hero:AddNewModifier(hero, nil, "modifier_perk_tier_indicator", {duration = -1})
	hero:AddNewModifier(hero, nil, "modifier_respawn_time_handler", { duration = -1 })

	if PlayerResource:HasRandomed(player_id) then
		for _, item_name in ipairs(RANDOM_BONUS_ITEMS) do
			local item = hero:AddItemByName(item_name)
			if item then
				item:SetSellable(false)
			end
		end
	end

	hero.initialized = true

	if team == Shuffle.weak_team_id then
		Shuffle:GiveBonusToHero(hero)
	end

	if WebPlayer:GetPunishmentLevel(player_id) == 10 then
		hero:AddNewModifier(hero, nil, "modifier_punishment_level_10", { duration = -1 })
		Kicks:AddPlayerToRedistributeGoldList(player_id)
	end

	EventDriver:Dispatch("GameLoop:hero_init_finished", {
		player_id = player_id,
		hero = hero,
	})
end

function GameLoop:SetTeamColors()
	local counters = {
		[DOTA_TEAM_GOODGUYS] = 0,
		[DOTA_TEAM_BADGUYS] = 0,
	}

	for player_id = 0, PlayerResource:GetPlayerCount() - 1 do
		local team = PlayerResource:GetTeam(player_id)
		if IsValidTeamNumber(team) then
			local counter = counters[team] + 1
			counters[team] = counter
			local color = PLAYER_COLORS[team][counter]

			if color then
				CustomPings:SetColor(player_id, color)
				PlayerResource:SetCustomPlayerColor(player_id, color[1], color[2], color[3])
			end
		end
	end
end

function GameLoop:InitFountains()
	local fountains = Entities:FindAllByClassname("ent_dota_fountain")

	for _, fountain in pairs(fountains) do
		local team_id = fountain:GetTeam()
		print("[GameLoop] found fountain", fountain:GetEntityIndex(), "of", team_id)

		GameLoop.fountains[team_id] = {
			pos = fountain:GetAbsOrigin(),
			pos_multiplier = team_id == DOTA_TEAM_GOODGUYS and -350 or -650,
		}
	end
end

function GameLoop:OverrideAncients()
	local ancients = Entities:FindAllByClassname("npc_dota_fort")

	for _, ancient in ipairs(ancients) do
		GameLoop.ancients[ancient:GetTeam()] = ancient
		ancient:RemoveModifierByName("modifier_invulnerable")
		ancient:AddNewModifier(ancient, nil, "modifier_ancient_kill_override", { duration = -1 })
		ancient:AddNewModifier(ancient, nil, "modifier_invulnerable", { duration = -1 })
	end
end

function GameLoop:InitTowers()
	GameLoop.towers = {}
	local towers = Entities:FindAllByClassname("npc_dota_tower")
	for _, tower in pairs(towers) do
		print("[GameLoop] found tower", tower:GetEntityIndex(), "of", tower:GetTeam())

		local ability = tower:FindAbilityByName("tower_fury_swipes")
		if ability and not ability:IsNull() then
			ability:SetLevel(1)
		end

		GameLoop.towers[tower:GetTeam()] = tower
	end
end

function GameLoop:SetupCamps()
	local pull_camps = {
		neutralcamp_good_1 = true,
		neutralcamp_good_2 = true,
		neutralcamp_evil_1 = true,
		neutralcamp_evil_2 = true,
	}

	local function camp_filter_good(_, trigger)
		local name = trigger:GetName()
		return name:find("neutralcamp_good") ~= nil and not pull_camps[name]
	end

	local function camp_filter_bad(_, trigger)
		local name = trigger:GetName()
		return name:find("neutralcamp_evil") ~= nil and not pull_camps[name]
	end

	local triggers = Entities:FindAllByClassname("trigger_multiple")

	GameLoop.blockable_neutral_camps = {
		[DOTA_TEAM_GOODGUYS] = table.array_filter(triggers, camp_filter_good),
		[DOTA_TEAM_BADGUYS] = table.array_filter(triggers, camp_filter_bad),
	}
end

function GameLoop:SetGameWinner(team)
	if GameLoop.game_over == true then
		return
	end
	GameLoop.game_over = true

	DebugMessage("GameLoop:SetGameWinner executed")

	ErrorTracking.TryImmediate(function()
		EndGameStats:FinalizeStats(team)
		WebApi:AfterMatch(team)
	end)
end

function GameLoop:PickRandomHero(player_id)
	if GameRules:State_Get() > DOTA_GAMERULES_STATE_HERO_SELECTION then
		return
	end
	if GameRules:IsInBanPhase() then
		return
	end
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then
		return
	end
	local player = PlayerResource:GetPlayer(player_id)
	if not player then
		return
	end
	if PlayerResource:HasRandomed(player_id) or player:GetAssignedHero() then
		return
	end
	player:MakeRandomHeroSelection()
	PlayerResource:SetHasRandomed(player_id)
end

function GameLoop:OnEntityKilled(event)
	local killed = event.killed
	if not IsValidEntity(killed) then
		return
	end

	local unit_name = killed:GetUnitName()
	local team = killed:GetTeam()

	local time = BARRACKS_RESPAWN_TIMES[unit_name]
	if not time or not GameLoop.barracks_bonus[team] then
		return
	end

	GameLoop.barracks_bonus[team] = GameLoop.barracks_bonus[team] + time

	SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, killed, time, nil)
	GameRules:SendCustomMessage("#destroyed_" .. string.sub(unit_name, 10, #unit_name - 4), -1, 0)

	-- all barracks have been killed, extra 4 seconds
	if GameLoop.barracks_bonus[team] == 18 then
		GameLoop.barracks_bonus[team] = 22
		GameRules:SendCustomMessage("#destroyed_all_rax_" .. team, -1, 0)
	end
end

function GameLoop:ValidatePlacedWardForCamps(ward, owner_team)
	-- Allow placing sentry wards in your own camps but automatically destroy them just before the end of the minute mark.
	Timers:NextTick(function()
		if not IsValidEntity(ward) or not ward:IsAlive() then
			return
		end

		for _, trigger in pairs(GameLoop.blockable_neutral_camps[owner_team]) do
			if IsInTriggerBox(trigger, 12, ward:GetAbsOrigin()) then
				local time = GameRules:GetDOTATime(false, false)
				local duration = 59.5 - (time % 60)

				local observer_modifier = ward:FindModifierByName("modifier_item_buff_ward")
				if observer_modifier then
					observer_modifier:SetDuration(duration, true)
				end

				local observer_modifier = ward:FindModifierByName("modifier_item_ward_true_sight")
				if observer_modifier then
					observer_modifier:SetDuration(duration, true)
				end

				break
			end
		end
	end)
end

function GameLoop:FixDefendersGateFX()
	local gates = Entities:FindAllByClassname("npc_dota_base_blocker")

	local fx_name = {
		[DOTA_TEAM_GOODGUYS] = "particles/base_static/base_gate_ambient_radiant.vpcf",
		[DOTA_TEAM_BADGUYS] = "particles/base_static/base_gate_ambient_dire.vpcf",
	}

	for _, gate in pairs(gates) do
		local origin = gate:GetAbsOrigin()
		local angles = gate:GetAngles()
		local vstart = RotatePosition(Vector(0, 0, 0), angles, Vector(200, 0, 0)) + origin
		local vend = RotatePosition(Vector(0, 0, 0), angles, Vector(-200, 0, 0)) + origin

		local fx = ParticleManager:CreateParticle(fx_name[gate:GetTeam()], PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(fx, 3, vstart)
		ParticleManager:SetParticleControl(fx, 4, vend)
	end
end