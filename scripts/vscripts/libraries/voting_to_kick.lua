--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


Kicks = Kicks or {}

Kicks.supporters_kick_threshold = {
	[-1] = 0.8, -- new players (lower than 5 games)
	[0] = 0.6,
	[1] = 0.7,
	[2] = 0.8,
}

local KICK_COOLDOWN = 600
local TIME_FOR_ALLOW_INIT_VOTING = 60
local TIME_FOR_ALLOW_INIT_VOTING_MIN_DEATHS_IGNORE_TIME_LIMIT = 2
local REPORTS_TO_DECIDE_VOTING_ABUSIVE = 4
local MINIMUM_PLAYERS_TO_START_VOTING = 3

function Kicks:Init()
	self.user_ids = {}
	self.time_to_voting = 40
	self.votes_for_kick = 6 -- Now redefined on each voting start
	self.voting = nil
	self.kicks_id = {}
	self.pre_voting = {}
	self.stats = {}
	self.init_voting_cooldowns = {}
	self.is_enabled = true
	self.redistribute_gold_players_list = {}

	local map_name = GetMapName()
	if map_name == "ot3_gardens_duo" or map_name == "ot3_necropolis_ffa" then
		self.is_enabled = false
	end

	self.reasons_for_kick = {
		["feeding"] = true,
		["ability_abuse"] = true,
		["toxicity"] = true,
		["afk"] = true,
	}

	for player_id = 0, 24 do
		self.stats[player_id] = {
			reports = 0,
			voting_start = 0,
			voting_reported = 0,
		}
	end

	EventStream:Listen("voting_to_kick:reason_picked", function(event)
		if not self.is_enabled then
			return
		end
		self:StartVoting(event)
	end)
	EventStream:Listen("voting_to_kick:vote_yes", function(event)
		if not self.is_enabled then
			return
		end
		self:VoteYes(event.PlayerID)
	end)
	EventStream:Listen("voting_to_kick:vote_no", function(event)
		if not self.is_enabled then
			return
		end
		self:VoteNo(event.PlayerID)
	end)
	EventStream:Listen("voting_to_kick:check_state", function(event)
		if not self.is_enabled then
			return
		end
		self:CheckState(event)
	end)
	EventStream:Listen("voting_to_kick:report", function(event)
		if not self.is_enabled then
			return
		end
		self:Report(event.PlayerID)
	end)
	EventStream:Listen("voting_for_kick:kick_player", function(event)
		if not self.is_enabled then
			return
		end
		self:InitKickVoting(event)
	end)
	EventStream:Listen("voting_for_kick:get_enable_state", function(event)
		if not self.is_enabled then
			return
		end
		self:GetEnableState(event.PlayerID)
	end)
	ListenToGameEvent("player_connect_full", Dynamic_Wrap(Kicks, "OnConnectFull"), self)
end

function Kicks:OnConnectFull(data)
	local player_id = data.PlayerID
	if not self.user_ids[player_id] then
		self.user_ids[player_id] = data.userid
	end

	DebugMessage("Player", player_id, "connected, in team", PlayerResource:GetTeam(player_id))
	--
	--if self:IsPlayerKicked(player_id) then
	--	-- self:DropItemsForDisconnectedPlayer(player_id)
	--	self:Kick(player_id)
	--end
end

function Kicks:GetEnableState(player_id)
	if not player_id or not self.is_enabled then
		return
	end

	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(player_id), "voting_for_kick:enable", {})
end

function Kicks:IsPlayerKicked(player_id)
	return Kicks.kicks_id and Kicks.kicks_id[player_id]
end

function Kicks:Report(player_id)
	if not player_id or not self.voting or not self.voting.init or not self.voting.reports_count then
		return
	end
	if self.voting.players_reports and self.voting.players_reports[player_id] then
		return
	end

	self.voting.players_reports[player_id] = true
	self.voting.reports_count = self.voting.reports_count + 1

	local init_pid = self.voting.init

	if self.voting.reports_count >= REPORTS_TO_DECIDE_VOTING_ABUSIVE then
		self:StopVoting(false)
		self.stats[init_pid].voting_reported = self.stats[init_pid].voting_reported + 1
	end

	self.stats[init_pid].reports = self.stats[init_pid].reports + 1
end

function Kicks:AlertPlayersAboutStartVoting()
	if not self.voting then
		return
	end

	CustomChat:MessageToTeam(-1, self.voting.team, "kick_voting_chat_message", {
		players = {
			[self.voting.init] = C_CHAT_PRESETS.PLAYER(1),
			[self.voting.target] = C_CHAT_PRESETS.PLAYER(2),
		},
	})

	local all_heroes = HeroList:GetAllHeroes()
	for _, hero in pairs(all_heroes) do
		if hero:IsRealHero() and hero:IsControllableByAnyPlayer() then
			EmitSoundOn("CustomSounds.Bonk", hero)
		end
	end
end

function Kicks:StartVoting(data)
	local player_init_id = data.PlayerID
	if not player_init_id then
		return
	end

	if self.voting then
		CustomGameEventManager:Send_ServerToPlayer(
			PlayerResource:GetPlayer(player_init_id),
			"display_custom_error",
			{ message = "#voting_to_kick_voiting_for_now" }
		)
		return
	end

	local player_init = PlayerResource:GetPlayer(player_init_id)
	local team = player_init:GetTeam()

	if not self.reasons_for_kick[data.reason] then
		return
	end

	local player_target_id = self.pre_voting[player_init_id]
	local game_time = GameRules:GetGameTime()

	self.voting = {
		players_voted = {},
		team = team,
		reason = data.reason,
		init = player_init_id,
		target = player_target_id,
		votes = 0,
		players_reports = {},
		reports_count = 0,
		init_time = game_time,
	}

	self:UpdateVotingForKick()
	self:AlertPlayersAboutStartVoting()

	self.stats[player_init_id].voting_start = self.stats[player_init_id].voting_start + 1

	CustomGameEventManager:Send_ServerToTeam(team, "voting_to_kick:show_voting", {
		target_id = player_target_id,
		reason = data.reason,
		player_id_init = player_init_id,
		init_time = game_time,
	})
	CustomGameEventManager:Send_ServerToPlayer(player_init, "voting_to_kick:hide_reason", {})

	Timers:CreateTimer("start_voting_to_kick", {
		useGameTime = true,
		endTime = self.time_to_voting,
		callback = function()
			self:StopVoting(false)
			return nil
		end,
	})

	self:VoteYes(data.PlayerID)
end

function Kicks:StopVoting(successful_voting)
	Timers:RemoveTimer("start_voting_to_kick")
	CustomGameEventManager:Send_ServerToTeam(self.voting.team, "voting_to_kick:hide_voting", {})
	GameRules:SendCustomMessage(
		successful_voting and "#voting_to_kick_player_kicked" or "#voting_to_kick_voting_failed",
		self.voting.target,
		0
	)

	if successful_voting then
		CustomGameEventManager:Send_ServerToAllClients("voting_to_kick:player_kicked", {
			reason = self.voting.reason,
			target_id = self.voting.target,
		})
	end

	self.voting = nil
end

function Kicks:UpdateVotingForKick()
	if not self.voting then
		return
	end
	local max_voices_in_team = 0

	for player_id = 0, 24 do
		local connection_state = PlayerResource:GetConnectionState(player_id)

		if
			PlayerResource:IsValidPlayerID(player_id)
			and PlayerResource:GetTeam(self.voting.target) == PlayerResource:GetTeam(player_id)
			and connection_state ~= DOTA_CONNECTION_STATE_ABANDONED
		then
			max_voices_in_team = max_voices_in_team + 1
		end
	end

	local target_id = self.voting.target
	local is_new_player = WebApi.playerMatchesCount
		and WebApi.playerMatchesCount[target_id]
		and WebApi.playerMatchesCount[target_id] < 5
	local level = is_new_player and -1 or WebPlayer:GetSubscriptionTier(target_id)
	self.votes_for_kick = math.floor(max_voices_in_team * self.supporters_kick_threshold[level])
end

function Kicks:GetVoteWeight(player_id)
	if not self.voting then
		return
	end

	local source_party_id = tonumber(tostring(PlayerResource:GetPartyID(player_id)))
	if not source_party_id then
		return 0
	end
	if source_party_id == 0 then
		return 1
	end

	for _player_id, _ in pairs(self.voting.players_voted) do
		local focus_party_id = tonumber(tostring(PlayerResource:GetPartyID(_player_id)))
		if focus_party_id and (focus_party_id == source_party_id) then
			return 0.5
		end
	end

	return 1
end

function Kicks:Kick(player_id)
	local user_id = self.user_ids[player_id]
	if not user_id then
		return
	end

	--SendToServerConsole('kickid '.. user_id)

	Kicks:SellItemsForDisconnectedPlayer(player_id)
	Kicks:RedistributePlayerGold(player_id)
	Kicks:AddPlayerToRedistributeGoldList(player_id)
	Kicks:CleanSummons(player_id)

	local hero = PlayerResource:GetSelectedHeroEntity(player_id)
	if not IsValidEntity(hero) then
		return
	end

	hero:Stop()
	hero:InterruptMotionControllers(false)
	FindClearSpaceForUnit(hero, GetFountainSpawnPosition(hero:GetTeam(), 300), false)

	hero:AddNewModifier(hero, nil, "modifier_custom_disabled_unit", { duration = -1 })

	--Give shard to kicked players to stop them receiving one from the Tormentor.
	if not hero:HasShard() then
		Timers:CreateTimer(0, function()
			if not hero:IsAlive() then
				return 0
			end
			hero:AddNewModifier(hero, nil, "modifier_item_aghanims_shard", nil)
		end)
	end

	self.kicks_id[player_id] = true

	CustomNetTables:SetTableValue("game_state", "kicked_players", self.kicks_id)
end

function Kicks:VoteNo(player_id)
	if not self.voting then
		return
	end
	if self.voting.team ~= PlayerResource:GetTeam(player_id) then
		return
	end
	if self.voting.players_voted[player_id] then
		return
	end

	self.voting.players_voted[player_id] = true
end

function Kicks:VoteYes(player_id)
	if not self.voting then
		return
	end
	if self.voting.players_voted[player_id] then
		return
	end
	if player_id == self.voting.target then
		return
	end

	self.voting.votes = self.voting.votes + self:GetVoteWeight(player_id)
	self.voting.players_voted[player_id] = true

	if self.voting.votes >= self.votes_for_kick then
		self.kicks_id[self.voting.target] = true
		self:Kick(self.voting.target)
		self:StopVoting(true)
	end
end

function Kicks:CheckState(data)
	if
		self.voting
		and self.voting.target
		and data.PlayerID
		and (PlayerResource:GetTeam(self.voting.target) == PlayerResource:GetTeam(data.PlayerID))
	then
		CustomGameEventManager:Send_ServerToPlayer(
			PlayerResource:GetPlayer(data.PlayerID),
			"voting_to_kick:show_voting",
			{
				target_id = self.voting.target,
				reason = self.voting.reason,
				player_id_init = self.voting.init,
				player_voted = self.voting.players_voted[data.PlayerID],
				init_time = self.voting.init_time,
			}
		)
	end
end

function Kicks:FilterInitVotingTime(target_id)
	local target_deaths = PlayerResource:GetDeaths(target_id)
	if target_deaths >= TIME_FOR_ALLOW_INIT_VOTING_MIN_DEATHS_IGNORE_TIME_LIMIT then
		return true
	end
	if GameRules:GetDOTATime(false, false) >= TIME_FOR_ALLOW_INIT_VOTING then
		return true
	end

	return false
end

function Kicks:InitKickVoting(data)
	local player_id = data.PlayerID
	local target_id = data.target_id
	if not player_id or not target_id then
		return
	end

	if PlayerResource:GetTeam(player_id) ~= PlayerResource:GetTeam(target_id) then
		return
	end

	local player = PlayerResource:GetPlayer(player_id)

	if GameMode:IsDeveloper(target_id) then
		return
	end
	if Kicks:IsPlayerKicked(player_id) then
		return
	end

	-- Punished 10 players can't be kicked and do not participate in voting
	if WebPlayer:GetPunishmentLevel(player_id) == 10 then
		return
	end
	if WebPlayer:GetPunishmentLevel(target_id) == 10 then
		return
	end

	--Can't start voting if too few players in team
	if Kicks:CountVotersInTeam(PlayerResource:GetTeam(player_id)).count < MINIMUM_PLAYERS_TO_START_VOTING then
		return
	end

	if Kicks:IsPlayerKicked(target_id) then
		CustomGameEventManager:Send_ServerToPlayer(
			player,
			"display_custom_error",
			{ message = "#voting_to_kick_already_kicked" }
		)
		return
	end

	if not Kicks:FilterInitVotingTime(target_id) then
		CustomGameEventManager:Send_ServerToPlayer(player, "display_custom_error", { message = "#not_yet_kick_time" })
		return
	end

	if self:IsPlayerBanned(player_id) then
		CustomGameEventManager:Send_ServerToPlayer(
			player,
			"custom_hud_message:send",
			{ message = "#voting_to_kick_cannot_kick_ban" }
		)
		return
	end

	if self:CheckPartyBan(player_id) then
		CustomGameEventManager:Send_ServerToPlayer(
			player,
			"custom_hud_message:send",
			{ message = "#voting_to_kick_cannot_kick_ban_party" }
		)
		return
	end

	if PlayerResource:GetConnectionState(target_id) == DOTA_CONNECTION_STATE_ABANDONED then
		CustomGameEventManager:Send_ServerToPlayer(
			player,
			"display_custom_error",
			{ message = "#voting_to_kick_abandoned" }
		)
		return
	end

	if self.voting then
		CustomGameEventManager:Send_ServerToPlayer(
			player,
			"display_custom_error",
			{ message = "#voting_to_kick_voiting_for_now" }
		)
		return
	end

	local cd_time = self.init_voting_cooldowns[player_id]
	if cd_time and ((GameRules:GetGameTime() - cd_time) <= KICK_COOLDOWN) then
		DisplayErrorWithValues(player_id, "#voting_to_kick_cooldown", {
			sec = KICK_COOLDOWN - (GameRules:GetGameTime() - cd_time),
		})
		return
	end
	self.init_voting_cooldowns[player_id] = GameRules:GetGameTime()

	if self:IsPlayerWarning(player_id) then
		CustomGameEventManager:Send_ServerToPlayer(
			player,
			"custom_hud_message:send",
			{ message = "#voting_to_kick_warning" }
		)
	end

	self.pre_voting[player_id] = target_id

	CustomGameEventManager:Send_ServerToPlayer(player, "voting_to_kick:show_reason", { target_id = target_id })

	local all_heroes = HeroList:GetAllHeroes()
	for _, hero in pairs(all_heroes) do
		if hero:IsRealHero() and hero:IsControllableByAnyPlayer() then
			EmitSoundOn("CustomSounds.Bonk", hero)
		end
	end
end

function Kicks:CheckPartyBan(player_id)
	local source_party_id = tonumber(tostring(PlayerResource:GetPartyID(player_id)))
	if not source_party_id then
		return true
	end
	if source_party_id == 0 then
		return false
	end

	for i = 0, 24 do
		local focus_party_id = tonumber(tostring(PlayerResource:GetPartyID(i)))
		if focus_party_id and (focus_party_id == source_party_id) then
			if self:IsPlayerBanned(i) then
				return true
			end
		end
	end
	return false
end

function Kicks:DropItemsForDisconnectedPlayer(player_id)
	local hero = PlayerResource:GetSelectedHeroEntity(player_id)
	if not hero then
		return
	end

	local team = hero:GetTeamNumber()
	if not team then
		return
	end

	local home_shop_pos = {
		[DOTA_TEAM_BADGUYS] = Vector(6980, 6334, 390),
		[DOTA_TEAM_GOODGUYS] = Vector(-7045, -6480, 384),
	}

	local home_pos = home_shop_pos[team]
	if not home_pos then
		return
	end

	local items_for_drop = {
		["item_ward_dispenser"] = true,
		["item_ward_observer"] = true,
		["item_ward_sentry"] = true,
	}

	for i = DOTA_ITEM_SLOT_1, DOTA_STASH_SLOT_6 do
		local item = hero:GetItemInSlot(i)
		if item and not item:IsNull() then
			if items_for_drop[item:GetAbilityName()] then
				hero:DropItemAtPositionImmediate(item, home_pos + RandomVector(RandomFloat(200, 200)))
			end
		end
	end
end

function Kicks:SellItemsForDisconnectedPlayer(player_id)
	local hero = PlayerResource:GetSelectedHeroEntity(player_id)
	if not hero then
		return
	end

	for i = DOTA_ITEM_SLOT_1, DOTA_STASH_SLOT_6 do
		local item = hero:GetItemInSlot(i)
		if item and item:IsSellable() then
			hero:SellItem(item)
		end
	end

	for _, unit in pairs(hero:GetAdditionalOwnedUnits()) do
		if unit:GetClassname() == "npc_dota_lone_druid_bear" and not unit:IsIllusion() then
			for i = DOTA_ITEM_SLOT_1, DOTA_STASH_SLOT_6 do
				local item = unit:GetItemInSlot(i)
				if item and item:IsSellable() then
					unit:SellItem(item)
				end
			end
		end
	end
end

function Kicks:AddPlayerToRedistributeGoldList(player_id)
	Kicks.redistribute_gold_players_list[player_id] = true
end

function Kicks:RedistributePlayerGold(player_id)
	local team = PlayerResource:GetTeam(player_id)
	local gold = PlayerResource:GetGold(player_id)

	local connected_players = Kicks:CountVotersInTeam(team, { [player_id] = true })
	local gold_per_player = math.floor(gold / connected_players.count)

	PlayerResource:SetGold(player_id, 0, true)
	PlayerResource:SetGold(player_id, 0, false)

	for _, _p_id in pairs(connected_players.players) do
		Timers:CreateTimer(_p_id * 0.2, function()
			PlayerResource:ModifyGold(_p_id, gold_per_player, false, DOTA_ModifyGold_AbandonedRedistribute)
			return nil
		end)
	end
end

function Kicks:CountVotersInTeam(team, exception_list)
	local count = 0
	local players = {}
	exception_list = exception_list or {}

	for player_id = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		local connection_state = PlayerResource:GetConnectionState(player_id)

		if
			not exception_list[player_id]
			and PlayerResource:GetTeam(player_id) == team
			and (connection_state == DOTA_CONNECTION_STATE_CONNECTED or connection_state == DOTA_CONNECTION_STATE_DISCONNECTED)
			and not Kicks:IsPlayerKicked(player_id)
			and WebPlayer:GetPunishmentLevel(player_id) ~= 10
		then
			count = count + 1
			table.insert(players, player_id)
		end
	end

	return { count = count, players = players }
end

function Kicks:RedistributeGoldUpdate()
	for player_id, _ in pairs(Kicks.redistribute_gold_players_list) do
		Kicks:RedistributePlayerGold(player_id)
	end
end

function Kicks:CleanSummons(player_id)
	local units = FindUnitsInRadius(
		PlayerResource:GetTeam(player_id),
		Vector(0, 0, 0),
		nil,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
		FIND_ANY_ORDER,
		false
	)
	for _, unit in pairs(units) do
		if
			unit:GetPlayerOwnerID() == player_id
			and (unit:IsIllusion() or unit:IsSummoned() or unit:IsNeutralUnitType())
		then
			unit:ForceKill(false)
		end
	end
end

function Kicks:GetReports(player_id)
	return self.stats[player_id] and self.stats[player_id].reports or 0
end
function Kicks:GetInitVotings(player_id)
	return self.stats[player_id] and self.stats[player_id].voting_start or 0
end
function Kicks:GetFailedVotings(player_id)
	return self.stats[player_id] and self.stats[player_id].voting_reported or 0
end

function Kicks:SetWarningForPlayer(player_id)
	if self.stats[player_id] then
		self.stats[player_id].warning = true
	end
end
function Kicks:IsPlayerWarning(player_id)
	return self.stats[player_id] and self.stats[player_id].warning
end

function Kicks:SetBanForPlayer(player_id)
	if self.stats[player_id] then
		self.stats[player_id].ban = true
	end
end
function Kicks:IsPlayerBanned(player_id)
	return self.stats[player_id] and self.stats[player_id].ban
end

Kicks:Init()