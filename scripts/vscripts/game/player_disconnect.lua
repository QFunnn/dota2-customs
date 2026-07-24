--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


PlayerDC = PlayerDC or {}


function PlayerDC:Init()
	print("[PlayerDC] initialized!")
	PlayerDC.abandon_time = 3 * 60
	PlayerDC.disconnect_timer = {}
	PlayerDC.has_abandoned = {}
	PlayerDC.has_decreased_score = {}

	Timers:CreateTimer({
		useGameTime = false,
		endTime = 2,
		callback = function()
			if GameRules:State_Get() < DOTA_GAMERULES_STATE_PRE_GAME then return 1 end
			PlayerDC:ScanPlayers()
			return 2
		end
	})
end


function PlayerDC:ProcessPlayer(player_id)
	if not PlayerDC.disconnect_timer[player_id] then
		PlayerDC.disconnect_timer[player_id] = 0
	end

	if not PlayerDC.has_abandoned[player_id] then
		PlayerDC.has_abandoned[player_id] = false
	end

	if not PlayerResource:IsBotOrPlayerConnected(player_id) then
		-- print(player_id, PlayerDC.disconnect_timer[player_id], PlayerDC.abandon_time)
		if PlayerDC.disconnect_timer[player_id] >= PlayerDC.abandon_time or PlayerResource:HasPlayerAbandoned(player_id) then

			if not PlayerDC.has_abandoned[player_id] then
				PlayerDC.has_abandoned[player_id] = true

				-- decrease max score
				if not PlayerDC.has_decreased_score[player_id] then
					PlayerDC.has_decreased_score[player_id] = true
					GameLoop:DecreaseScoreByPlayerDisconnect(player_id, GameLoop.current_layout.abandon_kill_goal_reduction)
				end

				-- lock hero
				local hero = PlayerResource:GetSelectedHeroEntity(player_id)

				if IsValidEntity(hero) then
					hero:AddNewModifier(hero, nil, "modifier_player_abandon", {})
				end

			end

			-- split gold to ally team / sell items
			PlayerDC:AbandonGame(player_id)
		end

		PlayerDC.disconnect_timer[player_id] = PlayerDC.disconnect_timer[player_id] + 1

	elseif PlayerDC.has_abandoned[player_id] then
		PlayerDC.disconnect_timer[player_id] = 0
		PlayerDC.has_abandoned[player_id] = false

		local hero = PlayerResource:GetSelectedHeroEntity(player_id)

		if IsValidEntity(hero) then
			hero:RemoveModifierByName("modifier_player_abandon")
		end
	end
end


function PlayerDC:ScanPlayers()
	for player_id = 0, PlayerResource:GetPlayerCount() - 1 do
		PlayerDC:ProcessPlayer(player_id)
	end

	if not IsInToolsMode() and PlayerResource:GetPlayerCount() > 1 and not GameRules:IsCheatMode() then
		PlayerDC:CheckEndGame()
	end
end


function PlayerDC:AbandonGame(player_id)
	local allies = {}
	local hero = GameLoop.hero_by_player_id[player_id]
	if not IsValidEntity(hero) then return end

	local team = hero:GetTeam()

	for i = DOTA_ITEM_SLOT_1 , DOTA_STASH_SLOT_6 do
		local item = hero:GetItemInSlot(i)

		if IsValidEntity(item) then
			hero:SellItem(item)
		end
	end

	local gold_refund = hero:GetGold()

	hero:SetGold(0, true) -- reliable gold
	hero:SetGold(0, false) -- unreliable gold

	-- gather teammates id's, don't include DC'ed player and abandoned players
	for id = 0, PlayerResource:GetPlayerCount() - 1 do
		if PlayerResource:GetTeam(id) == team and id ~= player_id and not PlayerResource:HasPlayerAbandoned(id) then
			table.insert(allies, id)
		end
	end

	local gold_per_ally = gold_refund / #allies
	-- split gold pool for allies
	for _, ally_id in pairs(allies) do
		PlayerResource:ModifyGold(ally_id, gold_per_ally, true, DOTA_ModifyGold_AbandonedRedistribute)
	end
end


function PlayerDC:GetTeamConnectedPlayerCount(team_number)
	local counter = 0

	for i = 0, 23 do
		if PlayerResource:IsValidPlayerID(i) and PlayerResource:IsBotOrPlayerConnected(i) and not PlayerDC.has_abandoned[i] and PlayerResource:GetTeam(i) == team_number then
			counter = counter + 1
		end
	end

	return counter
end


function PlayerDC:CheckEndGame()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_POST_GAME then return end

	local teams = GameLoop.current_layout.teamlist
	local amount_of_teams_remaining = 0
	local winner = nil

	for _, team in pairs(teams) do
		if self:GetTeamConnectedPlayerCount(team) > 0 then
			amount_of_teams_remaining = amount_of_teams_remaining + 1
			winner = team
		end
	end

	if winner and amount_of_teams_remaining == 1 and GetMapName() ~= "ot3_demo" then
		GameLoop:SetGameWinner(winner)
	end
end


PlayerDC:Init()