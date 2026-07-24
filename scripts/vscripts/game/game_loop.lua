--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameLoop = GameLoop or {}

require("game/modifiers/init")
require("game/shuffle")


function GameLoop:Init()
	EventDriver:Listen("Events:hero_killed", GameLoop.OnUnitKilled, GameLoop)
	ListenToGameEvent("dota_player_killed", Dynamic_Wrap(self, "OnHeroKilled"), self)

	local current_layout = TEAMS_LAYOUTS[GetMapName()]
	if not current_layout then return end
	GameLoop.current_layout = current_layout

	GameLoop.target_kill_goal = current_layout.kill_goal
	GameLoop.target_kill_goal = current_layout.kill_goal
	GameLoop.max_teams = #current_layout.teamlist

	GameLoop.current_kills_count = {}

	GameLoop.hero_by_player_id = {}
	GameLoop.heroes_by_team = {}

	GameLoop.common_upgrades_progress = {}
	GameLoop.rare_upgrades_progress = {}

	GameLoop.rare_upgrades_requirement = {}
	GameLoop.rare_upgrades_filled_times = {}

	GameLoop.current_kill_order = {}

	GameLoop.kill_leader_team = nil
	GameLoop.game_over = false

	GameLoop.stalemate_game_timer = 0
	GameLoop.game_start_time = 0

	GameLoop._leader_overthrow_candidate = false

	GameLoop:InitWinrates()

	GameLoop:InitFountains()
	GameLoop:InitTowers()
	GameLoop:InitOverboss()
	GameLoop:InitFOWRevealers()

	FlyingTreasureDrop:Init()

	self.state_changed_listener = EventDriver:Listen("Events:state_changed", GameLoop.OnStateChanged, GameLoop)

	CustomNetTables:SetTableValue("game_options", "score_goal", {
		goal = GameLoop.target_kill_goal,
		limit = GameLoop.current_layout.game_base_duration,
	})

	EventStream:Listen("pick_random_hero", function(event) GameLoop:PickRandomHero(event.PlayerID) end)
end

function GameLoop:OnStateChanged(event)
	print("[Game Loop] game state changed to", event.state)

	if event.state == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
		if DEV_BOTS_ENABLED == true then
			Timers:CreateTimer(1.0, function ()
				SendToServerConsole('sm_gmode 1')
				SendToServerConsole('dota_bot_populate')
			end)
		end

		Shuffle:DoTeamShuffle()

		local player_count = PlayerResource:NumPlayers()
		local max_players = GameLoop.current_layout.player_count * #GameLoop.current_layout.teamlist

		GameLoop.is_full_lobby = player_count == max_players

		DebugMessage("[Game Loop] full lobby status: ", GameLoop.is_full_lobby, player_count, "/", max_players)

		if not GameLoop.is_full_lobby then
			--GameRules:LockCustomGameSetupTeamAssignment(false)
			GameRules:SetCustomGameSetupAutoLaunchDelay(15)
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

				for player_id = 0, DOTA_MAX_TEAM_PLAYERS -1 do
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

	if event.state == DOTA_GAMERULES_STATE_HERO_SELECTION then
		Timers:CreateTimer(0.1, function()
			local ban_state_end = GameRules:GetGameTime() + (GameRules:IsInBanPhase() and 15 or 0)
			CustomNetTables:SetTableValue("game_state", "ban_state_endtime", {time = ban_state_end})
		end)
	end

	if event.state ~= DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then return end
	GameLoop.game_start_time = GetSystemTimeMS()
	-- make sure heroes will be able to move at the same time regardless of when the modifier was added
	for _, hero in pairs(HeroList:GetAllHeroes()) do
		hero:RemoveModifierByName("modifier_pregame_stunned")
	end

	-- Very not jank setup for orb drop manager
	OrbDropManager:OnGameStart()

	GameLoop:UpdateTeamsOrder()
	print("[Game Loop] starting duration timer and common upgrades timer")

	if GetMapName() ~= "ot3_demo" then
		self.game_duration_timer = Timers:CreateTimer(function()
			local time = GameRules:GetDOTATime(false, false)

			if time >= self.current_layout.game_base_duration then
				GameLoop:OnGameDurationFinished()
				return
			end

			if not IsInToolsMode() and CountPlayers(false) > 2 and GameLoop.first_blood then
				GameLoop.stalemate_game_timer = GameLoop.stalemate_game_timer + 1

				if GameLoop.stalemate_game_timer >= GameLoop.current_layout.stalemate_game_time_limit then
					GameLoop:OnGameDurationFinished()
					return
				end
			end

			FlyingTreasureDrop:ThinkSpecialItemDrop()

			return 1
		end)
	end

	self.common_upgrades_timer = Timers:CreateTimer(1, function()
		GameLoop:CommonUpgradesTick()
		return 1
	end)
end

function GameLoop:OnHeroKilled(event)
	GameLoop:SetRespawnTime(event.PlayerID)
end

function GameLoop:OnUnitKilled(event)
	local killed = event.killed
	if not killed or not event.killer then return end
	if not killed:IsRealHero() then return end
	if killed:IsReincarnating() then return end
	if not GameLoop.heroes_by_team[event.killer:GetTeam()] then return end

	local killer
	local killer_team = event.killer:GetTeam()
	local killed_team = killed:GetTeam()

	if event.killer:IsMainHero() then
		killer = event.killer
	else
		local hero = GameLoop.hero_by_player_id[event.killer:GetPlayerOwnerID()]
		if hero and not hero:IsNull() then
			killer = hero
		end
	end

	-- Don't score kill if hero denied
	if killer_team == killed:GetTeam() then return end
	if not IsValidEntity(killer) then return end

	local current_kills_count = GameLoop.current_kills_count[killer_team]

	GameLoop.current_kills_count[killer_team] = current_kills_count + 1
	CustomNetTables:SetTableValue("game_state", "team_score", GameLoop.current_kills_count)

	print("[GameLoop] registered kill by", event.killer:GetUnitName(), "of", killed:GetUnitName())
	DeepPrintTable(GameLoop.current_kills_count)

	killer:QueueMadstones(1)

	local kill_difference = GameLoop.current_kills_count[killed_team] - current_kills_count
	local team_gold_reward = LEADER_KILL_GOLD_REWARD_PER_DIFFERENCE * math.floor(kill_difference / LEADER_KILLS_TO_DIFFERENCE)
	local is_killed_leader = killed:HasModifier("modifier_kill_leader")

	if team_gold_reward > 0 then
		-- if killed is leader, fire on-screen alert, otherwise reduce the reward
		if is_killed_leader then
			CustomGameEventManager:Send_ServerToAllClients("Alerts:leader_killed", {
				player_id = killer:GetPlayerOwnerID(),
				gold_reward = team_gold_reward
			})
		else
			team_gold_reward = team_gold_reward * NONLEADER_KILL_MULTIPLIER
		end
		print("[Game Loop] distributing reward: ", is_killed_leader, team_gold_reward)

		local team_share = math.ceil(team_gold_reward / (#GameLoop.heroes_by_team[killer_team] + 1))

		for _, team_hero in pairs(GameLoop.heroes_by_team[killer_team]) do
			if IsValidEntity(team_hero) then
				local bonus = team_share * (team_hero == killer and 2 or 1)
				team_hero:ModifyGold(bonus, false, DOTA_ModifyGold_HeroKill)
				team_hero:AddExperience(bonus * GOLD_TO_EXP_RATIO, DOTA_ModifyXP_HeroKill, false, true)
			end
		end
	end

	GameLoop:UpdateTeamsOrder()

	local current_kill_leader = GameLoop:GetKillLeader()

	GameLoop:UpdateLeaderOverthrowStatus(current_kill_leader)

	GameLoop:TransferLeadership(current_kill_leader)

	GameLoop:ProcessRareUpgradeProgress(killer_team)

	-- overtime means tie between leaders, getting a valid leader means instant win in this case
	if current_kill_leader and GameLoop.overtime then GameLoop:SetGameWinner(current_kill_leader) end

	if GameLoop.current_kills_count[killer_team] >= GameLoop.target_kill_goal then
		GameLoop:SetGameWinner(killer_team)
	end

	GameLoop.first_blood = true
	GameLoop.stalemate_game_timer = 0
end

function GameLoop:UpdateLeaderOverthrowStatus(kill_leader_team)
	local threshold = GameLoop.current_layout.leader_overthrow_threshold or 5

	local leader_team_kills = GameLoop.current_kills_count[kill_leader_team]

	local runner_up_team = table.findkey(GameLoop.current_kill_order, 2)

	if not kill_leader_team or not runner_up_team then return end

	local runner_up_kills = GameLoop.current_kills_count[runner_up_team] or 0

	if (leader_team_kills - runner_up_kills) >= threshold then
		GameLoop._leader_overthrow_candidate = true
	end
end


function GameLoop:SetRespawnTime(player_id)
	if GetMapName() == "ot3_demo" then return 5 end
	local map_definition = TEAMS_LAYOUTS[GetMapName()] or {}
	local hero_team = PlayerResource:GetTeam(player_id)
	local hero_place = GameLoop.current_kill_order[hero_team]

	local tying_teams = 1
	local new_respawn_time = map_definition["respawn_time"][hero_place] or 1

	for team, place in pairs(GameLoop.current_kill_order) do
		if hero_place == place and team ~= hero_team then
			new_respawn_time = new_respawn_time + map_definition["respawn_time"][hero_place + tying_teams]
			tying_teams = tying_teams + 1
		end
	end

	new_respawn_time = new_respawn_time / tying_teams


	local hero = PlayerResource:GetSelectedHeroEntity(player_id)

	if hero and IsValidEntity(hero) and not hero:IsReincarnating() then
		print("[GameLoop] set respawn time of", hero:GetUnitName(), "to", new_respawn_time or 1)

		if not hero:IsAlive() then
			hero:SetTimeUntilRespawn(new_respawn_time or 1)  -- Very long code just to fix meepo respawn time
		else
			DebugMessage("[GameLoop] hero is still alive, delaying respawn time setter!")
			Timers:CreateTimer(0.3, function()
				if not IsValidEntity(hero) then return end
				hero:SetTimeUntilRespawn(new_respawn_time or 1)
			end)
		end
	end
end


function GameLoop:InitHero(hero)
	if not IsValidEntity(hero) then return end
	print("[GameLoop] Initializing hero", hero:GetUnitName())

	local player_id = hero:GetPlayerOwnerID()
	local team = hero:GetTeam()

	GameLoop.hero_by_player_id[player_id] = hero
	GameLoop.heroes_by_team[team] = GameLoop.heroes_by_team[team] or {}
	GameLoop.common_upgrades_progress[team] = GameLoop.common_upgrades_progress[team] or 0
	GameLoop.rare_upgrades_progress[team] = GameLoop.rare_upgrades_progress[team] or 0
	GameLoop.rare_upgrades_requirement[team] = GameLoop.rare_upgrades_requirement[team] or GameLoop.current_layout.rare_upgrade_basic_requirement
	GameLoop.rare_upgrades_filled_times[team] = GameLoop.rare_upgrades_filled_times[team] or 0

	local orb_data = {
		team = team,
		orb_type = UPGRADE_RARITY_RARE,
		current = GameLoop.rare_upgrades_progress[team],
		max = GameLoop.rare_upgrades_requirement[team]
	}

	GameLoop:UpdateOrbNetTables(team, orb_data)

	table.insert(GameLoop.heroes_by_team[team], hero)

	hero:AddNewModifier(hero, nil, "modifier_xpm_gpm", {duration = -1})
	hero:AddNewModifier(hero, nil, "modifier_ability_upgrades_controller", {duration = -1})
	hero:AddNewModifier(hero, nil, "modifier_primary_attribute_reader", {duration = -1})
	hero:AddNewModifier(hero, nil, "modifier_bat_handler", {duration = -1})

	if not IsInToolsMode() and GameRules:State_Get() < DOTA_GAMERULES_STATE_GAME_IN_PROGRESS and GetMapName() ~= "ot3_demo" then
		hero:AddNewModifier(hero, nil, "modifier_pregame_stunned", {duration = PREGAME_TIME})
	end

	hero.upgrades = {}

	Upgrades:LoadUpgradesData(hero:GetUnitName())
	Upgrades:SendUpgradesData(player_id)

	local winrateOrbs = GameLoop.winrateOrbs[hero:GetUnitName()]
	if winrateOrbs and winrateOrbs > 0 then
		for i = 1, winrateOrbs do
			Upgrades:QueueSelection(hero, UPGRADE_RARITY_COMMON)
		end
	end

	UpgradeRerolls:PreparePlayer(player_id)

	if not GetDummyInventory(player_id) then
		CreateDummyInventoryForPlayer(player_id, hero)
	end

	local color = TEAM_COLORS[team]
	PlayerResource:SetCustomPlayerColor(player_id, color[1], color[2], color[3])

	if PlayerResource:HasRandomed(player_id) then
		for _, item_name in ipairs(RANDOM_BONUS_ITEMS) do
			local item = hero:AddItemByName(item_name)
			if item then
				item:SetSellable(false)
			end
		end
	end

	local tp_scroll = hero:FindItemInInventory("item_tpscroll")
	if IsValidEntity(tp_scroll) then
		tp_scroll:EndCooldown()
	end

	-- all inventory / item related events on strategy item have no hero and no player id (set as -1)
	-- therefore the only way to ensure boots bought there are locked is to check on hero spawn
	-- local boots = hero:FindItemInInventory("item_boots")
	-- if IsValidEntity(boots) and WebSettings:GetSettingValue(player_id, "lock_first_boots") then
	-- 	boots:SetCombineLocked(true)
	-- 	Filters.__has_locked_boots[player_id] = true
	-- end

	hero.initialized = true

	EventDriver:Dispatch("GameLoop:hero_init_finished", {
		player_id = player_id,
		hero = hero
	})
end


function GameLoop:InitFountains()
	local fountains = Entities:FindAllByClassname("ent_dota_fountain")

	for _, fountain in pairs(fountains) do
		print("[GameLoop] found fountain", fountain:GetEntityIndex(), "of", fountain:GetTeam())

		fountain:RemoveModifierByName("modifier_fountain_aura")
		fountain:SetAttackCapability(DOTA_UNIT_CAP_NO_ATTACK)

		-- Hides fountains in FFA so they can be at the proper placement (relevant for fear and similar abilities)
		if GetMapName() == "ot3_necropolis_ffa" then fountain:AddNewModifier(fountain, nil, "modifier_demo_tower_disabled", {}) end
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

		-- fountain auras are placed on the tower to match the attack range, fountains are just props now
		tower:AddNewModifier(tower, nil, "modifier_fountain_rejuvenation_lua", {duration = -1})
		tower:AddNewModifier(tower, nil, "modifier_fountain_movespeed_lua", {duration = -1})

		GameLoop.towers[tower:GetTeam()] = tower
	end
end


function GameLoop:InitOverboss()
	local overboss = Entities:FindByName( nil, "@overboss" )
	overboss:AddNewModifier(overboss, nil, "modifier_central_ring_emitter", {duration = -1})
	overboss:AddNewModifier(overboss, nil, "modifier_event_proxy", nil)
end


function GameLoop:InitFOWRevealers()
	local overboss = Entities:FindByName( nil, "@overboss" )

	for _, team in pairs(GameLoop.current_layout.teamlist) do
		AddFOWViewer(team, overboss:GetAbsOrigin() + Vector(0,0,1000), GameLoop.current_layout.center_vision_reveal_radius, 99999, false)
	end
end

function GameLoop:UpdateScoreGoal()
	CustomNetTables:SetTableValue("game_options", "score_goal", {
		goal = self.target_kill_goal,
		limit = self.current_layout.game_base_duration,
	})
end

function GameLoop:IncreaseScoreByVote(player_id)
	local kills_by_vote = TEAMS_LAYOUTS[GetMapName()].kills_by_vote
	local time_by_vote = TEAMS_LAYOUTS[GetMapName()].time_by_vote

	self.target_kill_goal = self.target_kill_goal + kills_by_vote
	self.current_layout.game_base_duration = self.current_layout.game_base_duration + time_by_vote
	EarlyConsumables:RegisterScoreVoteForPlayer(player_id, EXTRA_SCORE_VOTE_TYPE.DEFAULT)

	GameLoop:UpdateScoreGoal()
end


function GameLoop:DecreaseScoreByPlayerDisconnect(player_id)
	if GameLoop.game_over then return end

	local reduction = math.ceil(self.target_kill_goal / (self.current_layout.player_count * #self.current_layout.teamlist))
	-- since reduction is relative to `current` KL, make sure it won't be lower than certain sane minimal value
	reduction = math.max(reduction, GameLoop.current_layout.abandon_kill_goal_reduction)

	local leader_kills = self.current_kills_count[self.kill_leader_team or DOTA_TEAM_GOODGUYS]
	-- cannot make kill goal lower than current kills
	local new_kill_goal = math.max(self.target_kill_goal - reduction, leader_kills + 1)

	self.target_kill_goal = new_kill_goal

	GameRules:SendCustomMessage( "#game_duration_decreased_abandon_note", player_id, reduction)

	GameLoop:UpdateScoreGoal()
end


function GameLoop:IncreaseScoreByPlayerDisconnect(player_id, iCount)
	self.target_kill_goal = self.target_kill_goal + iCount
--	self.current_layout.game_base_duration = self.current_layout.game_base_duration - GAME_DURATION_INCREASE_PER_VOTE

	GameRules:SendCustomMessage( "#game_duration_increased_abandon_note", player_id, iCount)
end


function GameLoop:IncreaseTimeAndGoal(amount)
	self.target_kill_goal = self.target_kill_goal + amount
	self.current_layout.game_base_duration = self.current_layout.game_base_duration + (amount * 10)

	GameLoop:UpdateScoreGoal()
end


function GameLoop:GetKillLeader()
	local kill_leader, max_kills = -1, -1
	local prev_kill_leader, prev_max_kills = -1, -1

	for team, kills in pairs(GameLoop.current_kills_count) do
		if kills >= max_kills then
			prev_kill_leader = kill_leader
			prev_max_kills = max_kills

			kill_leader = team
			max_kills = kills
		end
	end

	-- return kill leader team, but only if there's no tie for the first place
	if max_kills ~= prev_max_kills then
		return kill_leader
	end
end

function GameLoop:TransferLeadership(new_kill_leader_team)
	if GameLoop.kill_leader_team == new_kill_leader_team then return end
	-- in case there's a tie for leader place, remove latest leader modifiers and exit
	-- otherwise grant leadership to heroes in new kill leader team
	if GameLoop.kill_leader_team then
		for _, hero in pairs(GameLoop.heroes_by_team[GameLoop.kill_leader_team]) do
			if IsValidEntity(hero) then
				hero:RemoveModifierByName("modifier_kill_leader")
			end
		end
	end

	GameLoop.kill_leader_team = new_kill_leader_team

	if not new_kill_leader_team then return end

	-- if we have leader overthrow candidate, and kill leader has changed (checked above), then leader was overthrown
	if GameLoop._leader_overthrow_candidate and GameLoop:IsOrbSpreeAllowed() then
		print("[Game Loop] triggered leader overthrow")
		local overthrow_reward_min = GameLoop.current_layout.overthrow_reward_min or 3
		local overthrow_reward_max = GameLoop.current_layout.overthrow_reward_max or 6
		local orbs_count = RandomInt(overthrow_reward_min, overthrow_reward_max)

		OrbDropManager:ThrowMultipleOrbs(orbs_count, 0.1)

		GameLoop._leader_overthrow_candidate = nil

		-- particle
		local particle = ParticleManager:CreateParticle("particles/orb_spree/orb_spree_shockwave.vpcf", PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(particle, 0, OrbDropManager.overboss_position)
		ParticleManager:SetParticleControl(particle, 1, OrbDropManager.overboss_position)
		ParticleManager:SetParticleControl(particle, 2, Vector(GameLoop.current_layout.ring_radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(particle)

		-- sound
		EmitGlobalSound("Shrine.Cast")
	end

	for _, hero in pairs(GameLoop.heroes_by_team[GameLoop.kill_leader_team] or {}) do
		if IsValidEntity(hero) then
			local added_modifier = hero:AddNewModifier(hero, nil, "modifier_kill_leader", {duration = -1})

			-- if leader modifier failed to apply (due to target being dead or invulnerable), attempt until applied successfully
			-- or until target is no longer an actual leader / invalid
			if not added_modifier or added_modifier:IsNull() then
				Timers:CreateTimer(0.5, function()
					if not IsValidEntity(hero) then return end
					if GameLoop.kill_leader_team ~= hero:GetTeam() then return end

					local reapplied_timer = hero:AddNewModifier(hero, nil, "modifier_kill_leader", {duration = -1})
					if not reapplied_timer or reapplied_timer:IsNull() then return 0.5 end
				end)
			end
		end
	end
end

function GameLoop:UpdateTeamsOrder()
	print("[GameLoop] updating teams order")
	local sorted_team_ids = {}

	for team, kills in pairs(GameLoop.current_kills_count) do
		table.insert(sorted_team_ids, {team, kills})
	end

	table.sort(sorted_team_ids, function(a, b) return a[2] > b[2] end)

	local placement = 0
	local kill_count = nil
	for _, values in ipairs(sorted_team_ids) do
		if values[2] ~= kill_count then
			kill_count = values[2]
			placement = placement + 1
		end
		GameLoop.current_kill_order[values[1]] = placement
	end
end


function GameLoop:OnGameDurationFinished()
	local current_kill_leader = GameLoop:GetKillLeader()

	if current_kill_leader then
		GameLoop:SetGameWinner(current_kill_leader)
		return
	end

	CustomGameEventManager:Send_ServerToAllClients("alerts:alert", { message = "overtime" })
	GameLoop.overtime = true
end


function GameLoop:GetCommonUpgradesRate(team, place)
	local base_progress = GameLoop.current_layout.common_upgrade_progress[place]
	local teamwork_enhancers = 0
	local modifier_enhancers = 0

	local modifier_names = {
		"modifier_elder_titan_tip_the_scales_lua",
	}

	for _, hero in pairs(GameLoop.heroes_by_team[team] or {}) do
		if IsValidEntity(hero) then
			teamwork_enhancers = teamwork_enhancers + WebInventory:GetItemCount(hero:GetPlayerID(), "bp_teamwork_enhancer")

			if hero:IsAlive() and not hero:PassivesDisabled() then
				for _, modifier_name in ipairs(modifier_names) do
					local modifier = hero:FindModifierByName(modifier_name)
					if modifier and modifier.common_orb_generation_rate_pct then
						modifier_enhancers = modifier_enhancers + modifier.common_orb_generation_rate_pct
					end
				end
			end
		end
    end

	return base_progress * (1 + teamwork_enhancers * 0.01) * (1 + modifier_enhancers * 0.01)
end


function GameLoop:CommonUpgradesTick()
	if GameRules:IsGamePaused() then return end

	for team, place in pairs(GameLoop.current_kill_order) do
		local progress = GameLoop:GetCommonUpgradesRate(team, place)
		GameLoop.common_upgrades_progress[team] = (GameLoop.common_upgrades_progress[team] or 0) + progress

		if GameLoop.common_upgrades_progress[team] >= COMMON_UPGRADES_REQUIREMENT then
			GameLoop.common_upgrades_progress[team] = GameLoop.common_upgrades_progress[team] - COMMON_UPGRADES_REQUIREMENT

			Upgrades:QueueSelectionForTeam(team, UPGRADE_RARITY_COMMON)
			EndGameStats:AddCapturedOrb(team, ORB_CAPTURE_TYPE.PASSIVE, UPGRADE_RARITY_COMMON)
		end

		local orb_data = {
			team = team,
			orb_type = UPGRADE_RARITY_COMMON,
			current = GameLoop.common_upgrades_progress[team],
			max = COMMON_UPGRADES_REQUIREMENT
		}

		GameLoop:UpdateOrbNetTables(team, orb_data)
	end
end


function GameLoop:ProcessRareUpgradeProgress(team)
	GameLoop.rare_upgrades_progress[team] = GameLoop.rare_upgrades_progress[team] + 1

	if GameLoop.rare_upgrades_progress[team] >= GameLoop.rare_upgrades_requirement[team] then
		Upgrades:QueueSelectionForTeam(team, UPGRADE_RARITY_RARE)
		EndGameStats:AddCapturedOrb(team, ORB_CAPTURE_TYPE.KILLS, UPGRADE_RARITY_RARE)

		GameLoop.rare_upgrades_progress[team] = 0

		-- increment rare upgrade bar max value for every N fills with P increment, N and P defined in `core_declarations.lua`
		GameLoop.rare_upgrades_filled_times[team] = GameLoop.rare_upgrades_filled_times[team] + 1

		if GameLoop.rare_upgrades_filled_times[team] >= GameLoop.current_layout.rare_upgrade_requirement_step then
			GameLoop.rare_upgrades_requirement[team] = GameLoop.rare_upgrades_requirement[team] + GameLoop.current_layout.rare_upgrade_requirement_increment
		end
	end

	local orb_data = {
		team = team,
		orb_type = UPGRADE_RARITY_RARE,
		current = GameLoop.rare_upgrades_progress[team],
		max = GameLoop.rare_upgrades_requirement[team]
	}

	GameLoop:UpdateOrbNetTables(team, orb_data)
end

function GameLoop:UpdateOrbNetTables(team, orb_data)
	CustomNetTables:SetTableValue("orbs", "current_progress_"..tostring(team), orb_data)
end

function GameLoop:GetSortedTeams()
	local sortedTeams = {}
	for _, team in pairs(GameLoop.current_layout.teamlist) do
		table.insert(sortedTeams, { team = team, score = GameLoop.current_kills_count[team] })
	end

	table.sort(sortedTeams, function(a, b) return a.score > b.score end)
	return sortedTeams
end


function GameLoop:SetGameWinner(team)
	if GameLoop.game_over == true then return end
	GameLoop.game_over = true

	SimulatedEndGame:EndWithWinner(team)
end


function GameLoop:InitWinrates(winrates)
	GameLoop.winrates = {}
	GameLoop.winrateOrbs = {}

	for k,v in pairs(LoadKeyValues("scripts/npc/npc_heroes.txt")) do
		if k ~= "Version" then
			if winrates then
				GameLoop.winrates[k] = winrates[k] or 1
			elseif DEV_RANDOM_WINRATES then
				GameLoop.winrates[k] = RandomFloat(0.1, 0.9)
			end
			if GameLoop.winrates[k] ~= nil then
				GameLoop.winrateOrbs[k] = math.floor((0.5 - GameLoop.winrates[k]) / 0.5)
			end
		end
	end
	CustomNetTables:SetTableValue("winrates", "orbs", GameLoop.winrateOrbs)
end


function GameLoop:PickRandomHero(player_id)
	if GameRules:State_Get() > DOTA_GAMERULES_STATE_HERO_SELECTION then return end
	if GameRules:IsInBanPhase() then return end
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end
	local player = PlayerResource:GetPlayer(player_id)
	if not player then return end
	if PlayerResource:HasRandomed(player_id) or player:GetAssignedHero() then return end
	player:MakeRandomHeroSelection()
	PlayerResource:SetHasRandomed(player_id)
end

function GameLoop:IsOrbSpreeAllowed()
	return not SeasonalEvents:IsAnyEpicEventRunning()
end