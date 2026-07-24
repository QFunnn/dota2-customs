--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


EndGameStats = EndGameStats or {}

-- single damage instance above 150000 is probably a bug and should be discarded
UNREASONABLE_DAMAGE_THRESHOLD = 150000

---@class ORB_CAPTURE_TYPE
---@type table<string, number>
ORB_CAPTURE_TYPE = {
	PASSIVE = 1,
	KILLS = 2,
	DROP = 3, -- areas on the ground + epics
	SHOP = 4, -- gold shop
	GIFT = 5, -- collection items (lagresse / benefaction)
}

function EndGameStats:Init()
	---@type table<number, table>
	EndGameStats.stats = EndGameStats.stats or {}
	---@type table<number, table>
	EndGameStats.orbs_collected = {}

	for player_id = -1, 24 do
		if not EndGameStats.stats[player_id] then
			EndGameStats.stats[player_id] = {
				networth = 0,
				experience = 0,
				hero_damage = 0,
				summon_damage = 0, -- portion of damage that was dealt by summon (indirectly)
				damage_taken = 0,
				wards = {
					npc_dota_observer_wards = 0,
					npc_dota_sentry_wards = 0,
				},
				wards_killed = {
					npc_dota_observer_wards = 0,
					npc_dota_sentry_wards = 0,
				},
				killed_heroes = {},
				total_healing = 0,
				total_stuns = 0,
				gpm = 0,
				xpm = 0,
				capture_orbs_time = 0,

				current_rating = 1500,
				rating_change = 0
			}
		end
	end

	EventDriver:Listen("Events:entity_killed", EndGameStats.OnEntityKilled, EndGameStats)
	EventDriver:Listen("Events:state_changed", EndGameStats.OnGameStateChanged, EndGameStats)
end


function EndGameStats:OnGameStateChanged(event)
	if event.state == DOTA_GAMERULES_STATE_PRE_GAME then
		local global_dummy = CreateUnitByName("npc_custom_ot3_dummy_unit", Vector(-10000,-10000,-10000), true, nil, nil, DOTA_TEAM_NEUTRALS)
		global_dummy:AddNewModifier(global_dummy, nil, "modifier_global_dummy_custom", { duration = -1 })
	end
end


function EndGameStats:OnEntityKilled(event)
	local killed = event.killed
	if not IsValidEntity(killed) or not killed.GetUnitName then return end

	local killer = event.killer
	if not IsValidEntity(killer) or not killer.GetPlayerOwnerID then return end

	local killer_player_id = killer:GetPlayerOwnerID()
	local killed_name = killed:GetUnitName()

	if killer_player_id > -1 then
		if killed_name == "npc_dota_sentry_wards" or killed_name == "npc_dota_observer_wards" then
			EndGameStats:Add_KilledWards(killer_player_id, killed_name)
			return
		end

		EndGameStats:Add_KilledHero(killer_player_id, killed)
	end
end


function EndGameStats:GetOtherTeamsAverageRating(team)
	local total = 0
	local count = 0

	for player_id, hero in pairs(GameLoop.hero_by_player_id or {}) do
		if PlayerResource:GetTeam(player_id) ~= team then
			local rating = WebPlayer:GetRating(player_id)
			if rating < 500 then rating = 500 end
			total = total + rating
			count = count + 1
		end
	end

	if count > 0 then return total / count end

	return 1500
end


function EndGameStats:GetRatingChange(player_id, override_place)
	if not SimulatedEndGame:IsSubmissionAllowed() then return 0 end

	if SeasonalEvents:IsAnyEpicEventRunning() then return 0 end

	local team_id = PlayerResource:GetTeam(player_id)
	local place = override_place or SimulatedEndGame:GetPlace(team_id)

	print("calculating rating change for", player_id, team_id, place)

	local base_change = GameLoop.current_layout.rating_changes[place] or 0
	local other_teams_average_rating = EndGameStats:GetOtherTeamsAverageRating(team_id)
	local current_rating = WebPlayer:GetRating(player_id)
	if current_rating < 500 then current_rating = 500 end

	local score_delta = math.floor((other_teams_average_rating - current_rating) * RATING_MULTIPLIER + 0.5)

	local rating_change = base_change + math.clamp(score_delta, -RATING_CHANGE_CAP, RATING_CHANGE_CAP)

	if EarlyConsumables:HavePlayerUsedDoubleMMRToken(player_id) then
		rating_change = rating_change * 2
	end

	return rating_change
end


function EndGameStats:FinalizeStats()
	EndGameStats.couriers = FindUnitsInRadius(
		DOTA_TEAM_GOODGUYS,
		Vector(0, 0, 0),
		nil,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_COURIER,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for player_id = 0, 23 do
		if PlayerResource:IsValidPlayer(player_id) then
			EndGameStats:Update_Networth(player_id)
			-- EndGameStats:Update_Heal(player_id)
			EndGameStats:Update_Stuns(player_id)
			EndGameStats:Update_XPM(player_id)
			EndGameStats:Update_GPM(player_id)
			EndGameStats:UpdateDamageTaken(player_id)
			EndGameStats:UpdateMMRChange(player_id)
			EndGameStats:UpdateCaptureOrbTime(player_id)
		end
	end
end


function EndGameStats:Add_DamageTaken(player_id, damage)
	if not damage or GameLoop.game_over then return end
	EndGameStats.stats[player_id].damage_taken = EndGameStats.stats[player_id].damage_taken + damage
end


function EndGameStats:Add_HeroDamage(player_id, damage, is_summon_damage)
	if not damage or GameLoop.game_over then return end

	-- NaN check
	if damage ~= damage then return end

	EndGameStats.stats[player_id].hero_damage = EndGameStats.stats[player_id].hero_damage + damage

	if is_summon_damage then
		EndGameStats.stats[player_id].summon_damage = EndGameStats.stats[player_id].summon_damage + damage
	end
end


function EndGameStats:Add_KilledHero(player_id, hero)
	if not hero:IsHero() then return end

	local team = hero:GetTeam()
	EndGameStats.stats[player_id].killed_heroes[team] = EndGameStats.stats[player_id].killed_heroes[team] or {}

	local hero_name = hero:GetUnitName()
	EndGameStats.stats[player_id].killed_heroes[team][hero_name] = (EndGameStats.stats[player_id].killed_heroes[team][hero_name] or 0) + 1
end


function EndGameStats:Add_PlacedWard(player_id, ward_name)
	EndGameStats.stats[player_id].wards[ward_name] = EndGameStats.stats[player_id].wards[ward_name] + 1
end


function EndGameStats:Add_KilledWards(player_id, ward_name)
	EndGameStats.stats[player_id].wards_killed[ward_name] = EndGameStats.stats[player_id].wards_killed[ward_name] + 1
end


function EndGameStats:Add_Heal(player_id, value)
	EndGameStats.stats[player_id].total_healing = (EndGameStats.stats[player_id].total_healing or 0) + value
end


--- Adds captured orb with specific capture type to team stat (for endgame screen)
---@param team number
---@param capture_type ORB_CAPTURE_TYPE
---@param count number
function EndGameStats:AddCapturedOrb(team, capture_type, count)
	EndGameStats.orbs_collected[team] = EndGameStats.orbs_collected[team] or {}

	EndGameStats.orbs_collected[team][capture_type] = (EndGameStats.orbs_collected[team][capture_type] or 0) + count

	CustomNetTables:SetTableValue("game_state", "orbs_collected", EndGameStats.orbs_collected)

	print("[EndGameStats] registered captured orb by", team, capture_type, count)
end


function EndGameStats:Update_Networth(player_id)
	if not PlayerResource:IsValidPlayerID(player_id) then return end
	local hero = PlayerResource:GetSelectedHeroEntity(player_id)
	if not hero then return end

	EndGameStats.stats[player_id].networth = PlayerResource:GetNetWorth(player_id) + (hero.consumed_orbs_cost or 0)
end


--- deprecated
function EndGameStats:Update_Heal(player_id)
	print(string.format("[EndGameStats] healing for %d - expected [%d], tracked [%d]", player_id, PlayerResource:GetHealing(player_id), EndGameStats.stats[player_id].total_healing))
	-- EndGameStats.stats[player_id].total_healing = PlayerResource:GetHealing(player_id)
end

function EndGameStats:Update_Stuns(player_id)
	EndGameStats.stats[player_id].total_stuns = PlayerResource:GetStuns(player_id)
end

function EndGameStats:Update_XPM(player_id)
	EndGameStats.stats[player_id].xpm = PlayerResource:GetXPPerMin(player_id)-- EndGameStats.stats[player_id].experience / GameRules:GetGameTime() * 60
end


function EndGameStats:Update_GPM(player_id)
	EndGameStats.stats[player_id].gpm = PlayerResource:GetGoldPerMin(player_id)
end


function EndGameStats:UpdateDamageTaken(player_id)
	-- in case something goes wrong and damage taken for player is corrupted - use intrinsic valve-collected value
	local present_damage_taken = EndGameStats.stats[player_id].damage_taken

	if not present_damage_taken or present_damage_taken == 0 or present_damage_taken ~= present_damage_taken then
		print("[EndGameStats] WARNING: corrupted damage taken found, falling back to built-in tracking - " .. player_id)
		DeepPrintTable(EndGameStats.stats[player_id] or {})
		EndGameStats.stats[player_id].damage_taken = PlayerResource:GetHeroDamageTaken(player_id, true)
	end
end


function EndGameStats:UpdateMMRChange(player_id)
	EndGameStats.stats[player_id].current_rating = WebPlayer:GetRating(player_id)
	EndGameStats.stats[player_id].rating_change = EndGameStats:GetRatingChange(player_id)
end

function EndGameStats:UpdateCaptureOrbTime(player_id)
	EndGameStats.stats[player_id].capture_orbs_time = MVPController.orb_capture_score[player_id] or 0
end


function EndGameStats:GetStats(player_id)
	return EndGameStats.stats[player_id] or {}
end


EndGameStats:Init()