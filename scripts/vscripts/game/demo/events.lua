--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--[[ Events ]]


function OT3Demo:OnItemPurchased(event)
	local buyer = PlayerResource:GetPlayer(event.PlayerID)
	local buyer_hero = buyer:GetAssignedHero()

	if IsValidEntity(buyer_hero) then
		buyer_hero:ModifyGold(event.itemcost, true, 0)
	end
end


function OT3Demo:OnNPCSpawned(event)
	local player_id = event.unit:GetPlayerOwnerID()
	if IsValidPlayerID(player_id) then
		PlayerResource:ModifyGold(player_id, 99999, true, 0)
	end

	event.unit:SetControllableByPlayer(self.demo_player_id, false)
end


function OT3Demo:OnEntityKilled(event)
	local killed = event.killed
	if not killed or not killed:IsRealHero() or killed:IsClone() then return end

	if GetMapName() == "ot3_demo" then
		killed:SetRespawnPosition(killed:GetAbsOrigin())
	end
end


function OT3Demo:OnAbilityUsed(event)
	if not self.free_spells_enabled then return end

	local caster = EntIndexToHScript(event.caster_entindex)
	if not IsValidEntity(caster) then return end

	-- try to find casted in abilities or inventory - since event procs for both
	local ability = caster:FindAbilityByName(event.abilityname) or caster:FindItemInInventory(event.abilityname)
	if IsValidEntity(ability) then
		ability:EndCooldown()
		ability:RefundManaCost()
		ability:RefreshCharges()
	end
end


function OT3Demo:RefreshPlayers()
	for _, hero in pairs(HeroList:GetAllHeroes()) do
		if not hero:IsAlive() then
			hero:RespawnHero(false, false)
		end

		for i = 0, 24 - 1 do
			local ability = hero:GetAbilityByIndex(i)
			if IsValidEntity(ability) then
				ability:EndCooldown()
				ability:RefundManaCost()
				ability:RefreshCharges()
			end

			for i = 0, 15 do
				local item = hero:GetItemInSlot(i)

				if item then
					item:EndCooldown()
					item:RefundManaCost()
					item:RefreshCharges()
				end
			end
		end

		hero:SetHealth(hero:GetMaxHealth())
		hero:SetMana(hero:GetMaxMana())
	end
end


function OT3Demo:OnRefreshButtonPressed()
	self:RefreshPlayers()
end


function OT3Demo:OnFreeSpellsButtonPressed()
	self.free_spells_enabled = not self.free_spells_enabled

	if self.free_spells_enabled then self:RefreshPlayers() end
end


function OT3Demo:OnSetInvulnerabilityHero(event)
	local hero_entindex = tonumber(event.entity)
	local hero = EntIndexToHScript(hero_entindex)

	local state = event.state == 1

	if IsValidEntity(hero) and hero:IsHero() then
		--print('OnSetInvulnerabilityHero! - found hero with ent index = ' .. hero_entindex)

		local all_units = {}

		if hero:IsRealHero() then
			all_units = hero:GetAdditionalOwnedUnits()
		end

		table.insert(all_units, hero)

		for _, unit in pairs(all_units) do
			if state then
				unit:AddNewModifier(hero, nil, "lm_take_no_damage", {})
			else
				unit:RemoveModifierByName("lm_take_no_damage")
			end
		end
	end
end


function OT3Demo:OnSpawnEnemyButtonPressed(event)
	local hero = PlayerResource:GetSelectedHeroEntity( event.PlayerID )

	if not IsValidEntity(hero) then return end

	local player = PlayerResource:GetPlayer(event.PlayerID)
	local facet_id = event.facet_id or 1

	local function on_hero_precached()
		DebugCreateHeroWithVariant(player, OT3Demo.hero_to_spawn, facet_id, event.enemy_team_id, true,
			function(new_hero)
				new_hero:SetControllableByPlayer(event.PlayerID, false)
				new_hero:SetRespawnPosition(hero:GetAbsOrigin())
				FindClearSpaceForUnit(new_hero, hero:GetAbsOrigin(), false)
				new_hero:Hold()
				new_hero:SetIdleAcquire(false)
				new_hero:SetAcquisitionRange(0)
			end
		)
	end
	-- will this help? idfk
	PrecacheUnitByNameAsync(OT3Demo.hero_to_spawn, on_hero_precached, event.PlayerID)
end


function OT3Demo:OnRequestInitialSpawnHeroID()
	local hero_id = DOTAGameManager:GetHeroIDByName(OT3Demo.hero_to_spawn)

	CustomGameEventManager:Send_ServerToAllClients("set_spawn_hero_id", {
		hero_id = hero_id,
		hero_name = OT3Demo.hero_to_spawn
	})
end


function OT3Demo:OnRemoveSelectedPressed(event)
	local unit = EntIndexToHScript(event.entity)
	local owner_player_id = unit:GetPlayerOwnerID()

	if IsValidEntity(unit) and (not IsValidPlayerID(owner_player_id) or unit ~= PlayerResource:GetSelectedHeroEntity(event.PlayerID)) then
		unit:Destroy()
	end
end


function OT3Demo:OnLevelUpHero(event)
	local hero_entindex = tonumber(event.entity)
	local hero = EntIndexToHScript(hero_entindex)

	if IsValidEntity(hero) and hero:IsHero() then
		--print('OnLevelUpHero! - found hero with ent index = ' .. hero_entindex)
		if hero.HeroLevelUp then
			hero:HeroLevelUp(true)
		end
	end
end


function OT3Demo:OnMaxLevelUpHero(event)
	local hero_entindex = tonumber(event.entity)
	local hero = EntIndexToHScript(hero_entindex)

	if IsValidEntity(hero) and hero:IsHero() then
		--print('OnMaxLevelUpHero! - found hero with ent index = ' .. hero_entindex)

		if hero.AddExperience then
			hero:AddExperience(100000, false, false) -- for some reason maxing your level this way fixes the bad interaction with OnHeroReplaced

			for i = 0, OT3Demo.DOTA_MAX_ABILITIES - 1 do
				local ability = hero:GetAbilityByIndex(i)
				if ability and not ability:IsAttributeBonus() then
					while ability:GetLevel() < ability:GetMaxLevel() and ability:CanAbilityBeUpgraded() == ABILITY_CAN_BE_UPGRADED and not ability:IsHidden() do
						hero:UpgradeAbility(ability)
					end
				end
			end
		end
	end
end


function OT3Demo:OnScepterHero(event)
	local hero_entindex = tonumber(event.entity)
	local hero = EntIndexToHScript(hero_entindex)

	if IsValidEntity(hero) and hero:IsHero() then
		--print('OnScepterHero! - found hero with ent index = ' .. hero_entindex)

		if not hero:FindModifierByName( "modifier_item_ultimate_scepter_consumed" ) then
			hero:AddItemByName( "item_ultimate_scepter_2" )
		else
			hero:RemoveModifierByName("modifier_item_ultimate_scepter_consumed")
		end
	end
end


function OT3Demo:OnShardHero(event)
	local hero_entindex = tonumber(event.entity)
	local hero = EntIndexToHScript(hero_entindex)

	if IsValidEntity(hero) and hero:IsHero() then
		--print('OnShardHero! - found hero with ent index = ' .. hero_entindex)

		if not hero:FindModifierByName("modifier_item_aghanims_shard") then
			hero:AddItemByName("item_aghanims_shard")
		else
			hero:RemoveModifierByName("modifier_item_aghanims_shard")
		end
	end
end


function OT3Demo:OnResetHero(event)
	local hero_entindex = tonumber(event.entity)
	local hero = EntIndexToHScript(hero_entindex)

	if IsValidEntity(hero) and hero:IsHero() then
		--print('OnResetHero! - found hero with ent index = ' .. hero_entindex)
		GameRules:SetSpeechUseSpawnInsteadOfRespawnConcept(true)
		PlayerResource:ReplaceHeroWithNoTransfer(hero:GetPlayerOwnerID(), hero:GetUnitName(), -1, 0)
		GameRules:SetSpeechUseSpawnInsteadOfRespawnConcept(false)
	end
end


function OT3Demo:OnSpawnAllyButtonPressed(event)
	local hero = PlayerResource:GetSelectedHeroEntity(event.PlayerID)
	local player = PlayerResource:GetPlayer(event.PlayerID)
	local facet_id = event.facet_id or 1

	if not IsValidEntity(hero) then return end

	DebugCreateHeroWithVariant(player, OT3Demo.hero_to_spawn, facet_id, hero:GetTeam(), false,
		function(new_hero)
			new_hero:SetControllableByPlayer(event.PlayerID, false)
			new_hero:SetRespawnPosition(hero:GetAbsOrigin())
			FindClearSpaceForUnit(new_hero, hero:GetAbsOrigin(), false)
			new_hero:Hold()
			new_hero:SetIdleAcquire( false )
			new_hero:SetAcquisitionRange(0)
		end
	)
end


function OT3Demo:OnDummyTargetButtonPressed(event)
	local hero = PlayerResource:GetSelectedHeroEntity(event.PlayerID)

	if not IsValidEntity(hero) then return end

	local dummy = CreateUnitByName("npc_dota_hero_target_dummy", hero:GetAbsOrigin(), true, nil, nil, hero:GetOpposingTeamNumber())
	dummy:SetAbilityPoints(0)
	dummy:SetControllableByPlayer(self.demo_player_id, false)
	dummy:Hold()
	dummy:SetIdleAcquire(false)
	dummy:SetAcquisitionRange(0)
end


function OT3Demo:OnSpawnRune(event)
	local rune_type = event.rune_type or DOTA_RUNE_DOUBLEDAMAGE

	local player_id = event.PlayerID

	local hero = GameLoop.hero_by_player_id[player_id]
	if not IsValidEntity(hero) then print("invalid hero in SpawnRuneInFrontOfUnit", player_id, hero) return end

	local base_origin = hero:GetAbsOrigin()
	local direction = hero:GetForwardVector() * 150

	local location = GetGroundPosition(base_origin + direction, nil)

	CreateRune(location, rune_type)
end


function OT3Demo:OnChangeHeroButtonPressed(event)
	PrecacheUnitByNameAsync(OT3Demo.hero_to_spawn, function()
		local old_hero = PlayerResource:GetSelectedHeroEntity(event.PlayerID)
		PlayerResource:ReplaceHeroWith(event.PlayerID, OT3Demo.hero_to_spawn, 99999, 0)

		Timers:CreateTimer(1.0, function()
			old_hero:RemoveSelf()
		end)

		Upgrades:LoadUpgradesData(OT3Demo.hero_to_spawn)
		Upgrades:SendUpgradesData(event.PlayerID)
	end)
end


function OT3Demo:OnPauseButtonPressed(...)
	PauseGame(not GameRules:IsGamePaused())
end


function OT3Demo:OnLeaveButtonPressed(event)
	local player_id = event.PlayerID
	local team = PlayerResource:GetTeam(player_id)
	GameLoop:SetGameWinner(team)
end


function OT3Demo:OnSelectSpawnHeroButtonPressed(event)
	local hero_to_spawn = DOTAGameManager:GetHeroUnitNameByID(tonumber(event.hero_id))
	OT3Demo.hero_to_spawn = hero_to_spawn

	CustomGameEventManager:Send_ServerToAllClients("set_spawn_hero_id", {
		hero_id = tonumber(event.hero_id),
		hero_name = hero_to_spawn
	})
end


function OT3Demo:OnCreepsToggled(event)
	self.creeps_enabled = not self.creeps_enabled

	GameRules:SetCreepSpawningEnabled(self.creeps_enabled)

	-- remove currently alive creeps
	if not self.creeps_enabled then
		local flags = DOTA_UNIT_TARGET_FLAG_DEAD + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD
		local creeps = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, Vector(0,0,0), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_CREEP, flags, FIND_ANY_ORDER, false)

		for _, creep in pairs(creeps or {}) do
			if IsValidEntity(creep) and creep:IsCreep() and not creep:IsControllableByAnyPlayer() and string.starts(creep:GetUnitName(), "npc_dota_creep_") then
				creep:Destroy()
			end
		end
	-- otherwise force a new wave
	else
		GameRules:SpawnAndReleaseCreeps()
	end
end


function OT3Demo:OnTowersToggled(event)
	self.towers_enabled = not self.towers_enabled

	for _, tower in pairs(self.towers or {}) do
		if IsValidEntity(tower) then
			if self.towers_enabled then
				if not tower:IsAlive() then
					tower:RespawnUnit()
				end
				tower:RemoveModifierByName("modifier_demo_tower_disabled")
				tower:RemoveNoDraw()
			else
				tower:AddNoDraw()
				tower:AddNewModifier(tower, nil, "modifier_demo_tower_disabled", {})
			end
		end
	end
end