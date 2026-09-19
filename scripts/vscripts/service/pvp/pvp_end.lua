--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---Завершить PvP-сражение для команд
---@param winnerTeamId integer
---@param loserTeamId integer
function PvpService:EndPvp(winnerTeamId, loserTeamId)
	self:RefreshTeamHero(winnerTeamId)
	self:RefreshTeamHero(loserTeamId)

	local duel = self:GetDuel()
	if duel:IsEnded() then
		return
	end
	logger:Log(string.format("END PVP. Winner = %d, Loser = %d", winnerTeamId, loserTeamId))

	self:KillSummonedCreatureAsyn(duel:GetHomeCenter())

	self:CompensateTeamExp(winnerTeamId)
	self:CompensateTeamExp(loserTeamId)

	duel:End()

	self:PlayWinnerTeamEffect(winnerTeamId)

	Timers:CreateTimer({
		endTime = 3.6,
		callback = function()
			local match = GameMode:GetMatch()
			if GameMode:GetMatchType() == "PVP_SOLO" then
				if
					match:GetPlace()
					and match:GetPlace() <= 3
					and (match:GetValidTeamNumber() >= 5 or IsInToolsMode())
				then
					self:PunishLoser(loserTeamId)
				end
			end
			if GameMode:GetMatchType() == "PVP_DUO" then
				if
					match:GetPlace()
					and match:GetPlace() <= 2
					and (match:GetValidTeamNumber() >= 4 or IsInToolsMode())
				then
					self:PunishLoser(loserTeamId)
				end
			end
			return nil
		end,
	})

	local betMap = BetService:GetBetMap()
	local pool = 0
	for _, teamId in ipairs({ winnerTeamId, loserTeamId }) do
		local list = betMap[teamId]
		if list then
			for _, data in ipairs(list) do
				if data and data.nValue then
					pool = pool + data.nValue
				end
			end
		end
	end

	BetService:GrantBetBonus(winnerTeamId, loserTeamId, pool)

	for _, data in ipairs(betMap[loserTeamId] or {}) do
		if data and data.nPlayerId and data.flRatio and data.nValue then
			PvpRecordBook:RecordBetHistory(
				data.nPlayerId,
				(-1 * data.nValue),
				winnerTeamId,
				loserTeamId,
				data.nValue,
				0,
				pool
			)
		end
	end

	PvpRecordBook:RecordWinner(winnerTeamId)
	PvpRecordBook:RecordLoser(loserTeamId)

	for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		local records = PvpRecordBook:Get(nPlayerID)
		if
			not (#records.bet_history == 0 and records.win == 0 and records.lose == 0 and records.total_bet_reward == 0)
		then
			CustomNetTables:SetTableValue("pvp_record", tostring(nPlayerID), records)
		end
	end

	CustomGameEventManager:Send_ServerToAllClients("TeamWin", {
		winnerTeamID = winnerTeamId,
		loserTeamID = loserTeamId,
	})
end

---Перезарядить героев команд, которые участвовали в PVP
---@param teamId integer
function PvpService:RefreshTeamHero(teamId)
	for i = 1, PlayerResource:GetPlayerCountForTeam(teamId) do
		local playerId = PlayerResource:GetNthPlayerIDOnTeam(teamId, i)
		local hero = PlayerResource:GetSelectedHeroEntity(playerId)

		if not IsValid(hero) then ---@cast hero CDOTA_BaseNPC_Hero
			goto continue
		end

		if not hero:IsAlive() then
			HeroRefreshService:RefreshAbilityAndItem(hero)
			Timers:CreateTimer({
				endTime = 3,
				callback = function()
					HeroPlacementService:MoveHeroToCenter(playerId, true)
					if PlayerResource:GetConnectionState(playerId) ~= DOTA_CONNECTION_STATE_ABANDONED then
						HeroRefreshService:RefreshAbilityAndItem(hero)
						hero:RespawnHero(false, false)
						if not Features:GetFeatureState(Features.Keys.HeroRefreshingDisabled) then
							hero:AddNewModifier(hero, nil, "modifier_hero_refreshing", {})
						end
					end
					hero.bJoiningPvp = false
					return nil
				end,
			})
		else
			HeroRefreshService:RefreshAbilityAndItem(hero)
			hero:SetHealth(hero:GetMaxHealth())
			hero:SetMana(hero:GetMaxMana())
			if not Features:GetFeatureState(Features.Keys.HeroRefreshingDisabled) then
				hero:AddNewModifier(hero, nil, "modifier_hero_refreshing", {})
			end
			hero:AddNewModifier(hero, nil, "modifier_pvp_ending", { duration = 3.1 })
			Timers:CreateTimer({
				endTime = 3,
				callback = function()
					HeroPlacementService:MoveHeroToCenter(playerId, true)
					HeroRefreshService:RefreshAbilityAndItem(hero)

					hero.bJoiningPvp = false
					return nil
				end,
			})
		end

		::continue::
	end
end

---Очищает целевую арену от саммонов
---@param targetLocation Vector
function PvpService:KillSummonedCreatureAsyn(targetLocation)
	if not targetLocation then
		return
	end

	local cleanLocation = Vector(targetLocation.x, targetLocation.y, targetLocation.z)
	Timers:CreateTimer({
		endTime = 5,
		callback = function()
			local summonedCreature = FindUnitsInRadius(
				DOTA_TEAM_NEUTRALS,
				cleanLocation,
				nil,
				2500,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_ALL,
				DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
					+ DOTA_UNIT_TARGET_FLAG_INVULNERABLE
					+ DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
				FIND_CLOSEST,
				false
			)

			for _, unit in ipairs(summonedCreature) do
				if
					not unit
					or unit:IsNull()
					or not unit.GetUnitName
					or not unit:GetUnitName()
					or not unit:IsSummoned()
					or unit:IsIllusion()
					or unit:IsTempestDouble()
					or unit:HasModifier("modifier_arc_warden_tempest_double_lua")
				then
					goto continue
				end

				if not unit:IsAlive() then
					goto continue
				end

				if string.find(unit:GetUnitName(), "npc_dota_lone_druid_bear") == 1 then
					local owner = unit:GetOwner()
					if
						owner
						and owner.IsRealHero
						and owner:IsRealHero()
						and owner:HasAbility("lone_druid_spirit_bear")
					then
						local ability = owner:FindAbilityByName("lone_druid_spirit_bear")
						ability:EndCooldown()
					end
				end

				if string.find(unit:GetUnitName(), "npc_dota_visage_familiar") == 1 then
					local owner = unit:GetOwner()
					if
						owner
						and owner.IsRealHero
						and owner:IsRealHero()
						and owner:HasAbility("visage_summon_familiars")
					then
						local ability = owner:FindAbilityByName("visage_summon_familiars")
						ability:EndCooldown()
					end
				end

				if string.find(unit:GetUnitName(), "npc_dota_warlock_golem") == 1 then
					local owner = unit:GetOwner()
					if
						owner
						and owner.IsRealHero
						and owner:IsRealHero()
						and owner:HasAbility("warlock_rain_of_chaos")
					then
						local ability = owner:FindAbilityByName("warlock_rain_of_chaos")
						ability:EndCooldown()
					end
				end

				if string.find(unit:GetUnitName(), "npc_dota_shadow_shaman_ward") == 1 then
					local owner = unit:GetOwner()
					if
						owner
						and owner.IsRealHero
						and owner:IsRealHero()
						and owner:HasAbility("shadow_shaman_mass_serpent_ward")
					then
						local ability = owner:FindAbilityByName("shadow_shaman_mass_serpent_ward")
						ability:EndCooldown()
					end
				end

				if string.find(unit:GetUnitName(), "npc_dota_brewmaster") == 1 then
					local owner = unit:GetOwner()
					if
						owner
						and owner.IsRealHero
						and owner:IsRealHero()
						and owner:HasAbility("brewmaster_primal_split")
					then
						local ability = owner:FindAbilityByName("brewmaster_primal_split")
						ability:EndCooldown()
					end
				end

				unit:ForceKill(false)

				::continue::
			end
			return nil
		end,
	})
end