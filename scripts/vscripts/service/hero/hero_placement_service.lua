--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


HeroPlacementService = HeroPlacementService or {} ---@class HeroPlacementService

---Перемещает определенного героя на фонтан
---@param playerId integer
---@param isPvpEnd? boolean
function HeroPlacementService:MoveHeroToCenter(playerId, isPvpEnd)
	isPvpEnd = isPvpEnd or false
	local hero = PlayerResource:GetSelectedHeroEntity(playerId)
	if not IsValid(hero) then
		return
	end ---@cast hero CDOTA_BaseNPC_Hero

	local teamNumber = hero:GetTeamNumber()
	local targetLocation = GameMode:GetMatch():GetTeamStartLocation(teamNumber)

	local observingTarget = HeroPlacementService:ChooseObservingTarget(playerId)
	if PlayerResource:GetConnectionState(playerId) ~= DOTA_CONNECTION_STATE_ABANDONED then
		if not hero:IsAlive() then
			hero:RespawnHero(false, false)
			if not Features:GetFeatureState(Features.Keys.HeroRefreshingDisabled) then
				hero:AddNewModifier(hero, nil, "modifier_hero_refreshing", {})
			end
		end
	end

	HeroPlacementService:MoveHeroToLocation(playerId, targetLocation, observingTarget, "prepare", isPvpEnd)
end

---Возвращает героя за которым будем наблюдать
---@param playerId integer
---@return CDOTA_BaseNPC_Hero?
function HeroPlacementService:ChooseObservingTarget(playerId)
	local homeTeamId = PvpService:GetHomeTeamId()
	if homeTeamId and Settings:Get(playerId, SettingsKey.AUTO_VIEW_PVP) == true and (not PvpService:IsDuelEnded()) then
		for i = 1, PlayerResource:GetPlayerCountForTeam(homeTeamId) do
			local tempPlayerId = PlayerResource:GetNthPlayerIDOnTeam(homeTeamId, i)
			local tempTargetHero = PlayerResource:GetSelectedHeroEntity(tempPlayerId)
			if tempTargetHero and (tempTargetHero:IsAlive() or tempTargetHero:IsReincarnating()) then
				return tempTargetHero
			end
		end
	end

	local currentRound = GameMode:GetMatch():GetCurrentRound()
	if Settings:Get(playerId, SettingsKey.AUTO_VIEW_PVE) == true and currentRound and not currentRound.isEnd then
		local killProgress = 100
		local targetTeamNumber
		for teamNumber, team in pairs(GameMode:GetMatch():GetTeams()) do
			if
				team:IsAlive()
				and currentRound.spawners[teamNumber]
				and false == currentRound.spawners[teamNumber].isProgressFinished
			then
				if killProgress > currentRound.spawners[teamNumber].killProgress then
					targetTeamNumber = teamNumber
				end
			end
		end
		if targetTeamNumber then
			for i = 1, PlayerResource:GetPlayerCountForTeam(targetTeamNumber) do
				local playerID = PlayerResource:GetNthPlayerIDOnTeam(targetTeamNumber, i)
				local tempTargetHero = PlayerResource:GetSelectedHeroEntity(playerID)
				if tempTargetHero and (tempTargetHero:IsAlive() or tempTargetHero:IsReincarnating()) then
					return tempTargetHero
				end
			end
		end
	end

	return PlayerResource:GetSelectedHeroEntity(playerId)
end

---Перемещает определенного игрока в указанное место
---@param playerId integer
---@param vLocation Vector
---@param hObservingTarget CBaseEntity?
---@param roomName string
---@param isPvpEnd boolean?
function HeroPlacementService:MoveHeroToLocation(playerId, vLocation, hObservingTarget, roomName, isPvpEnd)
	isPvpEnd = isPvpEnd or false
	local units = {}
	local hHero = PlayerResource:GetSelectedHeroEntity(playerId)
	if hHero then
		HeroPlacementService:RemoveMovemenModifier(hHero)

		do
			local pfx =
				ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_ABSORIGIN, hHero)
			ParticleManager:ReleaseParticleIndex(pfx)
		end

		if HeroPlacementService.supposedRooms == nil then
			HeroPlacementService.supposedRooms = {}
		end

		HeroPlacementService.supposedRooms[playerId] = roomName or "prepare"
		units = FindUnitsInRadius(
			PlayerResource:GetTeam(playerId),
			hHero:GetAbsOrigin(),
			nil,
			4000,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_DEAD,
			FIND_ANY_ORDER,
			false
		)

		local heroPositionBeforeBlink = hHero:GetAbsOrigin()
		FindClearSpaceForUnit(hHero, vLocation, true)

		HeroPlacementService:RemoveExorcismSpirits(hHero, heroPositionBeforeBlink)

		do
			local pfx = ParticleManager:CreateParticle(
				"particles/items_fx/blink_dagger_end.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				hHero
			)
			ParticleManager:ReleaseParticleIndex(pfx)
		end

		hHero:EmitSound("DOTA_Item.BlinkDagger.Activate")

		if hObservingTarget == nil then
			hObservingTarget = hHero
		end

		PlayerResource:SetCameraTarget(playerId, hObservingTarget)

		Timers:CreateTimer({
			endTime = 0.3,
			callback = function()
				PlayerResource:SetCameraTarget(playerId, nil)
				return nil
			end,
		})
	end

	for _, unit in pairs(units) do
		if
			IsValid(unit)
			and unit:IsAlive()
			and unit ~= hHero
			and unit:GetPlayerOwnerID() == playerId
			and unit:GetUnitName() ~= "npc_dummy_cosmetic_caster"
		then
			if unit:HasMovementCapability() then
				if unit:HasModifier("modifier_ogre_multicast_lua_bonus") then
					unit:ForceKill(false)
				else
					FindClearSpaceForUnit(unit, vLocation, true)
					if roomName == nil or roomName == "prepare" then
						if not Features:GetFeatureState(Features.Keys.HeroRefreshingDisabled) then
							unit:AddNewModifier(hHero, nil, "modifier_hero_refreshing", {})
						end
					else
						unit:RemoveModifierByName("modifier_hero_refreshing")
					end
					if isPvpEnd then
						HeroRefreshService:RefreshAbilityAndItem(unit, {})
					end
				end
			end
		end
	end
end

---Удаляет духов экзорцизма при телепорте: иначе они летят за героем через всю карту
---к границе мира и спамят "outside of cell bounds" (лаги).
---Духи без владельца, поэтому берём их по classname и привязываем к ближайшему DP.
---@param hero CDOTA_BaseNPC_Hero
---@param heroPositionBeforeBlink Vector позиция героя до блинка, для привязки духов
function HeroPlacementService:RemoveExorcismSpirits(hero, heroPositionBeforeBlink)
	if not hero:HasModifier("modifier_death_prophet_exorcism") then
		return
	end

	local spirits = Entities:FindAllByClassname("dota_death_prophet_exorcism_spirit")
	if #spirits == 0 then
		return
	end

	---@type { hero: CDOTA_BaseNPC_Hero, position: Vector }[]
	local exorcists = {}
	for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:IsValidPlayerID(playerId) then
			local exorcist = PlayerResource:GetSelectedHeroEntity(playerId)
			if exorcist and IsValid(exorcist) and exorcist:HasModifier("modifier_death_prophet_exorcism") then
				local position = (exorcist == hero) and heroPositionBeforeBlink or exorcist:GetAbsOrigin()
				exorcists[#exorcists + 1] = { hero = exorcist, position = position }
			end
		end
	end
	if #exorcists == 0 then
		return
	end

	for _, spirit in pairs(spirits) do
		if IsValid(spirit) then
			local spiritPosition = spirit:GetAbsOrigin()
			local nearestExorcist, nearestDistance
			for _, exorcist in pairs(exorcists) do
				local distance = (exorcist.position - spiritPosition):Length2D()
				if not nearestDistance or distance < nearestDistance then
					nearestDistance, nearestExorcist = distance, exorcist.hero
				end
			end
			if nearestExorcist == hero then
				spirit:RemoveSelf()
			end
		end
	end
end

---Удалить модификаторы движения с героя
---@param hHero CDOTA_BaseNPC_Hero
function HeroPlacementService:RemoveMovemenModifier(hHero)
	hHero:Stop()
	hHero:RemoveModifierByName("modifier_magnataur_skewer_movement")
	hHero:RemoveModifierByName("modifier_phoenix_icarus_dive")
	hHero:RemoveModifierByName("modifier_mirana_leap")
	hHero:RemoveModifierByName("modifier_kunkka_x_marks_the_spot")
	hHero:RemoveModifierByName("modifier_kunkka_x_marks_the_spot_thinker")
	hHero:RemoveModifierByName("modifier_riki_tricks_of_the_trade_phase")
	hHero:RemoveModifierByName("modifier_monkey_king_bounce_perch")
	hHero:RemoveModifierByName("modifier_void_spirit_dissimilate_phase")
	hHero:RemoveModifierByName("modifier_monkey_king_bounce_leap")
	hHero:RemoveModifierByName("modifier_monkey_king_tree_dance_activity")
	hHero:RemoveModifierByName("modifier_sandking_burrowstrike")
	hHero:RemoveModifierByName("modifier_phantomlancer_dopplewalk_phase")
	hHero:RemoveModifierByName("modifier_life_stealer_infest")
	hHero:RemoveModifierByName("modifier_phoenix_sun_ray")
	hHero:RemoveModifierByName("modifier_ember_spirit_sleight_of_fist_in_progress")
	hHero:RemoveModifierByName("modifier_ember_spirit_sleight_of_fist_caster")
	hHero:RemoveModifierByName("modifier_ember_spirit_sleight_of_fist_caster_invulnerability")

	-- False Promise: возврат к фонтану не восстанавливает здоровье
	if hHero:HasModifier("modifier_oracle_false_promise") then
		Timers:CreateTimer(1, function()
			hHero:RemoveModifierByName("modifier_oracle_false_promise")
			return nil
		end)
	end

	hHero:RemoveModifierByName("modifier_brewmaster_primal_split")
	hHero:RemoveModifierByName("modifier_invoker_tornado_lua")
	hHero:RemoveModifierByName("modifier_invoker_tornado")

	if hHero:HasAbility("puck_ethereal_jaunt") then
		hHero:FindAbilityByName("puck_ethereal_jaunt"):SetActivated(false)
		-- Отпустить через 3 секунды
		Timers:CreateTimer({
			endTime = 3,
			callback = function()
				if hHero:HasAbility("puck_ethereal_jaunt") then
					hHero:FindAbilityByName("puck_ethereal_jaunt"):SetActivated(true)
				end
				return nil
			end,
		})
	end

	if hHero:HasModifier("modifier_ember_spirit_fire_remnant_remnant_tracker") then
		hHero:RemoveModifierByName("modifier_ember_spirit_fire_remnant_timer")
		hHero:RemoveModifierByName("modifier_ember_spirit_fire_remnant_remnant_tracker")
		hHero:AddNewModifier(
			hHero,
			hHero:FindAbilityByName("ember_spirit_fire_remnant"),
			"modifier_ember_spirit_fire_remnant_remnant_tracker",
			{}
		)
	end

	if hHero:HasModifier("modifier_weaver_timelapse") then
		hHero:RemoveModifierByName("modifier_weaver_timelapse")
		hHero:AddNewModifier(hHero, hHero:FindAbilityByName("weaver_time_lapse"), "modifier_weaver_timelapse", {})
	end
end

---comment
---@param hUnit CDOTA_BaseNPC
---@return string
function HeroPlacementService:GetSupposeRoom(hUnit)
	if hUnit == nil then
		return "prepare"
	end

	if HeroPlacementService.supposedRooms == nil then
		HeroPlacementService.supposedRooms = {}
		HeroPlacementService.supposedRooms[hUnit:GetPlayerOwnerID()] = "prepare"
	end
	return HeroPlacementService.supposedRooms[hUnit:GetPlayerOwnerID()] or "prepare"
end

---comment
---@param roomName string
---@return unknown
function HeroPlacementService:GetRoomCenter(roomName)
	roomName = roomName or "prepare"
	local suppose_pos = nil
	if roomName == "prepare" then
		suppose_pos = (Entities:FindByName(nil, "prepare")):GetAbsOrigin()
	else
		suppose_pos = (Entities:FindByName(nil, roomName)):GetAbsOrigin()
	end

	return suppose_pos
end

---comment
---@param hUnit any
---@param vPos any
---@return boolean
function HeroPlacementService:IsEscaping(hUnit, vPos)
	vPos = vPos or hUnit:GetAbsOrigin()

	if hUnit:IsRealHero() then
		return not HeroPlacementService:IsInRoom(hUnit, nil, vPos)
	else
		return not (
			HeroPlacementService:IsInRoom(hUnit, "prepare", vPos)
			or HeroPlacementService:IsInRoom(hUnit, "center_" .. hUnit:GetTeamNumber(), vPos)
			or HeroPlacementService:IsInRoom(hUnit, nil, vPos)
		)
	end
end

function HeroPlacementService:IsInRoom(hUnit, sRoomName, vPos)
	sRoomName = sRoomName or HeroPlacementService:GetSupposeRoom(hUnit)
	vPos = vPos or hUnit:GetAbsOrigin()
	local suppose_pos = HeroPlacementService:GetRoomCenter(sRoomName)
	local mapName = GetMapName()
	local RoomWidths = {
		["1x8"] = {
			center_2 = 1824,
			center_3 = 1824,
			center_4 = 1824,
			center_5 = 1824,
			center_6 = 1824,
			center_7 = 1824,
			center_8 = 1824,
			center_9 = 1824,
			prepare = 2750,
		},
		["2x6"] = {
			enter_2 = 2240,
			center_3 = 2240,
			-- center_4 = 1824,
			-- center_5 = 1824,
			center_6 = 2240,
			center_7 = 2240,
			center_8 = 2240,
			center_9 = 2240,
			prepare = 2600,
		},
		["5v5"] = {
			center_single_pvp = 1792,
			center_2 = 3500,
			center_3 = 3500,
			center_4 = 3640,
			prepare = 3600,
		},
	}

	local range = (RoomWidths[mapName][sRoomName] or 1824) * 0.5

	local point_lu = suppose_pos + Vector(-range, range, 0)
	local point_ld = suppose_pos + Vector(-range, -range, 0)
	local point_ru = suppose_pos + Vector(range, range, 0)
	local point_rd = suppose_pos + Vector(range, -range, 0)

	return IsPointInsideRectangle(vPos, point_lu, point_ld, point_ru, point_rd)
end