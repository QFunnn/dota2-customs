--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks_definition")

GamePerks = GamePerks or {}

function GamePerks:Init()
	self.game_perks_specials = {}

	self.chosen_perks = {}
	self.perk_tiers = {}
	self.family_perks = {}

	for perk_name, perk_data in pairs(GAME_PERKS_BY_NAME) do
		local parsed_perk_data = table.shallowcopy(perk_data)
		parsed_perk_data.name = nil

		self.game_perks_specials[perk_name] = parsed_perk_data
	end

	EventStream:Listen("game_perks:get_player_info", GamePerks.RequestUpdatePlayerInfo, GamePerks)
	EventStream:Listen("game_perks:set_perk", GamePerks.SetGamePerk, GamePerks)
	EventStream:Listen("game_perks:get_before_match_state", GamePerks.UpdateWebApiState, GamePerks)

	EventDriver:Listen("Events:npc_spawned", GamePerks.OnNpcSpawned, GamePerks)
end

function GamePerks:UpdateWebApiState(event)
	local player_id = event.PlayerID
	if not player_id then
		return
	end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then
		return
	end

	CustomGameEventManager:Send_ServerToPlayer(player, "game_perks:update_before_match_state", {
		state = WebApi.before_match_state,
	})
end

function GamePerks:UpdatePerksOnClients()
	local client_data = {}

	for player_id, _ in pairs(self.chosen_perks) do
		client_data[player_id] = GamePerks:CollectDataForClient(player_id)
	end

	CustomNetTables:SetTableValue("game_state", "game_perks", client_data)
end

function GamePerks:UpdatePlayerInfo(player_id)
	if not player_id then
		return
	end

	-- perks are disabled in tournament mode
	-- if GameMode:IsTournamentMode() then return end

	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(player_id), "game_perks:set_player_info", {
		perks_list = GAME_PERKS,
		supp_level = WebPlayer:GetSubscriptionTier(player_id),
		current_perk = self.chosen_perks[player_id],
		forbidden_perks_by_hero = PERKS_FORBIDDEN_BY_HERO,
		perks_white_list = PERKS_FORCE_ALLOWED,
		is_developer = GameMode:IsDeveloper(player_id),
	})
end

function GamePerks:RequestUpdatePlayerInfo(event)
	local player_id = event.PlayerID
	if not player_id then
		return
	end

	GamePerks:UpdatePlayerInfo(player_id)
end

function GamePerks:UpdateSupporterTier(player_id)
	if self.chosen_perks[player_id] then
		GamePerks:ResetPerk(player_id)
	else
		GamePerks:UpdatePlayerInfo(player_id)
	end
end

function GamePerks:SetGamePerkSchedule(event)
	Timers:CreateTimer(1, function()
		print("Retrying setting perk in 1s")
		GamePerks:SetGamePerk(event)
		return nil
	end)
end

function GamePerks:IsForbiddenPerkForHero(hero, perk_name, check_for_family)
	local hero_name = hero:GetUnitName()

	if check_for_family and PERKS_FORBIDDEN_FOR_FAMILY[perk_name] and PERKS_FORCE_ALLOWED[perk_name][hero_name] then
		return true
	end

	if PERKS_FORCE_ALLOWED[perk_name] and not PERKS_FORCE_ALLOWED[perk_name][hero_name] then
		return true
	end

	if PERKS_FORBIDDEN_BY_HERO[hero_name] and PERKS_FORBIDDEN_BY_HERO[hero_name][perk_name] then
		return true
	end

	return false
end

function GamePerks:RemovePerk(player_id, hero)
	local chosen_name = self.chosen_perks[player_id]
	hero:RemoveModifierByName(chosen_name)
	self.chosen_perks[player_id] = nil
	self.family_perks[player_id] = nil
	self.perk_tiers[player_id] = nil
end

function GamePerks:SetGamePerk(event)
	local player_id = event.PlayerID
	if not player_id then
		return
	end

	if not event.resetter and self.chosen_perks[player_id] then
		return
	end
	local player = PlayerResource:GetPlayer(player_id)
	if not player then
		GamePerks:SetGamePerkSchedule(event)
		return
	end

	--if not event.external then
	--	event.perk_name = "armor"
	--end

	if PlayerResource:GetConnectionState(player_id) ~= DOTA_CONNECTION_STATE_CONNECTED then
		GamePerks:SetGamePerkSchedule(event)
		return
	end

	local perk_name = event.perk_name
	local perk_tier = WebPlayer:GetSubscriptionTier(player_id)

	if GameMode:IsDeveloper(player_id) and event.tier then
		perk_tier = event.tier

		if event.tier > 0 and perk_name ~= "family" then
			self.family_perks[player_id] = "family"
		end
	end

	local hero = player:GetAssignedHero()
	if not IsValidEntity(hero) then
		GamePerks:SetGamePerkSchedule(event)
		return
	end

	if event.resetter and self.family_perks[player_id] then
		perk_tier = perk_tier + 1
	end

	if not GAME_PERKS_BY_NAME[perk_name] then
		return
	end

	local is_perk_forbidden = GamePerks:IsForbiddenPerkForHero(hero, perk_name, false)
	if is_perk_forbidden then
		return
	end

	if perk_name == "family" then
		self.family_perks[player_id] = perk_name

		local perks_pool = {}

		for _perk_name, _ in pairs(GAME_PERKS_BY_NAME) do
			local _is_perk_forbidden = GamePerks:IsForbiddenPerkForHero(hero, _perk_name, true)
			if _perk_name ~= "family" and not _is_perk_forbidden then
				table.insert(perks_pool, _perk_name)
			end
		end

		perk_name = table.random(perks_pool)
		perk_tier = perk_tier + 1
	end

	perk_tier = math.clamp(perk_tier, 0, 3) + 1

	if hero and not hero:IsNull() and hero:IsAlive() then
		self.chosen_perks[player_id] = perk_name
		self.perk_tiers[player_id] = perk_tier

		local stacks = -1
		if event.resetter then
			local ex_perk_modifier = hero:FindModifierByNameAndCaster(perk_name, hero)
			if ex_perk_modifier and not ex_perk_modifier:IsNull() then
				stacks = ex_perk_modifier:GetStackCount()
			end
		end
		hero:RemoveModifierByName(perk_name)

		local new_perk = hero:AddNewModifier(hero, nil, perk_name, { duration = -1, perk_tier = perk_tier })
		if stacks > 0 then
			new_perk:SetStackCount(stacks)
		end

		new_perk:ForceRefresh()

		hero.current_perk_modifier = new_perk

		hero:CalculateGenericBonuses()
		hero:CalculateStatBonus(true)

		if self.family_perks[player_id] then
			self:UpdatePlayerInfo(player_id)
		end

		CustomGameEventManager:Send_ServerToPlayer(player, "game_perks:set_perk_client", {
			current_perk = perk_name,
			perk_tier = perk_tier,
			specials = self.game_perks_specials[perk_name],
		})

		GamePerks:UpdatePerksOnClients()
	else
		GamePerks:SetGamePerkSchedule(event)
	end
end

function GamePerks:GetSelectedPerkNameWithTier(player_id)
	if not self.chosen_perks[player_id] then
		return
	end

	local perk_name = self.family_perks[player_id] or self.chosen_perks[player_id]
	if not perk_name then
		return
	end

	return perk_name .. "_t" .. WebPlayer:GetSubscriptionTier(player_id)
end

function GamePerks:ResetPerk(player_id)
	local ex_perk = self.chosen_perks[player_id]
	if not self.chosen_perks[player_id] then
		return
	end

	GamePerks:SetGamePerk({
		PlayerID = player_id,
		perk_name = ex_perk,
		resetter = true,
	})
end

function GamePerks:CollectDataForClient(player_id)
	if not self.chosen_perks[player_id] then
		return
	end

	local base_name = self.chosen_perks[player_id]
	local perk_name = base_name
	if self.family_perks[player_id] then
		perk_name = self.family_perks[player_id]
	end

	return {
		player_id = player_id,
		perk_name = perk_name,
		base_perk = base_name,
	}
end

function GamePerks:IsPerkSharableToUnits(perk_name, is_illusion)
	if PERKS_BLOCK_LIST_FOR_NON_HEROES[perk_name] then
		return false
	end
	if is_illusion and PERKS_BLOCK_LIST_FOR_ILLUSIONS[perk_name] then
		return false
	end
	return true
end

function GamePerks:ShouldApplyPerksToUnit(unit)
	if not unit or unit:IsNull() then
		return false
	end
	if unit.IsTempestDouble and unit:IsTempestDouble() then
		return true
	end
	if unit.IsClone and unit:IsClone() then
		return true
	end
	if unit.IsIllusion and unit:IsIllusion() then
		return true
	end
	return false
end

function GamePerks:GetPerksValues(name, perk_tier)
	if not self.game_perks_specials[name] then
		return
	end

	local result = {}

	for k, v in pairs(self.game_perks_specials[name]) do
		if type(v) == "table" then
			result[k] = v[perk_tier] or v[1]
		elseif type(v) == "number" then
			result[k] = v
		end
	end

	return result
end

function GamePerks:OnNpcSpawned(event)
	local unit = event.unit
	Timers:CreateTimer(0.1, function()
		if not GamePerks:ShouldApplyPerksToUnit(unit) then
			return
		end

		local modifier_illusion = unit:FindModifierByName("modifier_illusion")
		local player_id = modifier_illusion and modifier_illusion:GetCaster():GetPlayerOwnerID()
			or unit:GetPlayerOwnerID()
		local perk_name = GamePerks.chosen_perks[player_id]
		local perk_tier = WebPlayer:GetSubscriptionTier(player_id)
		local main_hero = PlayerResource:GetSelectedHeroEntity(player_id)

		if GamePerks.family_perks[player_id] then
			perk_tier = perk_tier + 1
		end

		perk_tier = math.clamp(perk_tier, 0, 3) + 1

		if perk_name and GamePerks:IsPerkSharableToUnits(perk_name, modifier_illusion) then
			unit:AddNewModifier(unit, nil, perk_name, { duration = -1, perk_tier = perk_tier })
			local main_perk_stacks = main_hero:GetModifierStackCount(perk_name, main_hero)
			unit:SetModifierStackCount(perk_name, nil, main_perk_stacks)
		end

		-- apply punishments as well
		if main_hero and main_hero:HasModifier("modifier_punishment_level_10") then
			unit:AddNewModifier(main_hero, nil, "modifier_punishment_level_10", { duration = -1 })
		end
	end)
end