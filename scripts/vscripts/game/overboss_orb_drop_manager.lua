--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


OrbDropManager = OrbDropManager or class({})

function OrbDropManager:Init()
	GameMode.do_double_orb_drops = GetMapName() == "ot3_necropolis_ffa"

	local layout = GameLoop.current_layout

	OrbDropManager.ring_radius = layout.ring_radius
	OrbDropManager.capture_point_radius = layout.capture_point_radius
	OrbDropManager.overboss_position = Vector(0, 0, 0)

	-- sector-based "uniform" random
	OrbDropManager.__debug_draw = false -- IsInToolsMode()
	OrbDropManager.__sectors_generated = false
	OrbDropManager.sector_count = RING_SECTOR_COUNT
	OrbDropManager.sector_weights = {}
	-- {start angle, end angle}, radians
	OrbDropManager.sector_boundaries = {}
	OrbDropManager.current_radius = RING_RADIUS_MINIMUM + 50
	OrbDropManager.orbs_dropped = 0
	OrbDropManager.__random_stream = CreateUniformRandomStream(RandomInt(1, 15000000))

	OrbDropManager.epic_orb_weights = {}

	local overboss = Entities:FindByName(nil, "@overboss")
	if overboss and IsValidEntity(overboss) then
		OrbDropManager.overboss_position = overboss:GetAbsOrigin()
	end

	OrbDropManager.team_ring_origins = {}
	OrbDropManager.distance_totals = {}
end


function OrbDropManager:OnGameStart()
	-- Find all the towers on the map and save the intersection between
	-- The line from their origin to the overboss and the centre ring
	-- To OrbDropManager.team_ring_origins

	local units = FindUnitsInRadius(4, Vector(0, 0, 0), nil, 69420, 3, 55, 64, 0, false) -- go away i didnt want it to be 12 years long ok

	for _, building in pairs(units) do
		if building.GetUnitName and building:GetUnitName() == "npc_dota_goodguys_tower1_bot" then
			local team_number = building:GetTeamNumber()

			OrbDropManager.team_ring_origins[team_number] = OrbDropManager.overboss_position + building:GetAbsOrigin():Normalized() * OrbDropManager.ring_radius * 3

			OrbDropManager.distance_totals[team_number] = 0
		end
	end

	Timers:CreateTimer(10, function()
		if not OrbDropManager.overboss then
			OrbDropManager.overboss = Entities:FindByName(nil, "@overboss")
		end
		OrbDropManager:TryOrbThrow(OrbDropManager.overboss)
		return 1
	end)
end


function OrbDropManager:TryOrbThrow(overboss)
	if GameLoop.game_over then return end

	local chance = GameLoop.current_layout.overboss_throw_chance or 100

	local minutes = math.floor(GameRules:GetDOTATime(false, false) / 60)
	local raw_multiplier = OVERBOSS_ORB_THROW_MULTIPLIER_PCT + OVERBOSS_ORB_THROW_MULTIPLIER_PCT_CHANGE_PER_MINUTE * minutes

	local chance_multiplier = math.max(math.min(raw_multiplier, OVERBOSS_ORB_THROW_MULTIPLIER_MAX_CAP), OVERBOSS_ORB_THROW_MULTIPLIER_MIN_CAP) / 100

	if RollPseudoRandomPercentage(chance * chance_multiplier, DOTA_PSEUDO_RANDOM_CUSTOM_GAME_9, overboss) then
		OrbDropManager:ThrowOrbs(overboss)
	end
end


function OrbDropManager:ThrowMultipleOrbs(orbs_count, delay)
	local overboss = Entities:FindByName(nil, "@overboss")

	if not delay or delay <= 0 then
		for _ = 0, orbs_count do OrbDropManager:ThrowOrbs(overboss) end
		return
	end

	for i = 0, orbs_count do
		Timers:CreateTimer(i * 0.1, function()
			OrbDropManager:ThrowOrbs(overboss)
		end)
	end
end


function OrbDropManager:ThrowOrbs(overboss)
	local position = INIT_POSITION_FOR_ITEM

	if IsValidEntity(overboss) then
		local coin_toss_attachment = overboss:ScriptLookupAttachment("coin_toss_point")
		if coin_toss_attachment ~= -1 then
			position = overboss:GetAttachmentOrigin(coin_toss_attachment)
		end
	end

	-- play animation, then throw orbs
	overboss:StartGestureWithFade(ACT_DOTA_CAST_ABILITY_1, 2, 1)

	Timers:CreateTimer(2, function()
		local rarity = self:OverbossSelectRarity()
		GameMode:SpawnOrbDrop(position, rarity, true)

		if GameMode.do_double_orb_drops then
			GameMode:SpawnOrbDrop(position, rarity, true)
		end
	end)
end


function OrbDropManager:OverbossSelectRarity()
	local minutes = math.floor(GameRules:GetDOTATime(false, false)/60)
	local random = RandomInt(1, 100)

	local epic_threshold = math.max(math.min(OVERBOSS_ORB_THROW_EPIC_PCT + OVERBOSS_ORB_THROW_EPIC_PCT_CHANGE_PER_MINUTE * minutes, OVERBOSS_ORB_THROW_EPIC_PCT_MAX_CAP), 0)
	local rare_threshold = epic_threshold + math.max(math.min(OVERBOSS_ORB_THROW_RARE_PCT + OVERBOSS_ORB_THROW_RARE_PCT_CHANGE_PER_MINUTE * minutes, OVERBOSS_ORB_THROW_RARE_PCT_MAX_CAP), 0)

	if random <= epic_threshold then
		return UPGRADE_RARITY_EPIC
	elseif random <= rare_threshold then
		return UPGRADE_RARITY_RARE
	end

	return UPGRADE_RARITY_COMMON
end


function OrbDropManager:GenerateSectors()
	local step = (2 * math.pi) / OrbDropManager.sector_count

	if OrbDropManager.__debug_draw then
		DebugDrawClear()
		DebugDrawCircle(OrbDropManager.overboss_position, Vector(0, 255, 0), 35, OrbDropManager.ring_radius, true, -1)
	end

	for i = 1, OrbDropManager.sector_count do
		OrbDropManager.sector_weights[i] = GameLoop.current_layout.starting_drop_weights[i] or 0
		OrbDropManager.sector_boundaries[i] = {step * i, step * (i + 1)}

		if OrbDropManager.__debug_draw then
			local p_from = Vector(math.cos(step * i), math.sin(step * i))
			local p_to = p_from * OrbDropManager.ring_radius

			print("drawing", p_from, p_to)
			DebugDrawLine_vCol(RING_RADIUS_MINIMUM * p_from, p_to, Vector(255, 0, 0), true, -1)

			local mid_point = Vector(math.cos(step * i + step / 2.0), math.sin(step * i + step / 2.0))
			DebugDrawText(mid_point * OrbDropManager.ring_radius / 2.0, tostring(i), true, -1)
		end
	end

	OrbDropManager.__sectors_generated = true
end


function OrbDropManager:GenerateRandomInSector(sector_id, rarity)
	local sector_boundaries = OrbDropManager.sector_boundaries[sector_id]

	local theta = OrbDropManager.__random_stream:RandomFloat(sector_boundaries[1], sector_boundaries[2])

	-- take current radius, reduce it by capture orb radius and min radius to offset both sides
	-- so it doesn't drop too close to center or outer border
	-- since radius start small, make sure it doesn't go negative
	local random_radius = math.max(OrbDropManager.current_radius - OrbDropManager.capture_point_radius - RING_RADIUS_MINIMUM, RING_RADIUS_MINIMUM * 0.5)

	local r = math.sqrt(OrbDropManager.__random_stream:RandomFloat(0, 1)) * random_radius

	local x = r * math.cos(theta)
	local y = r * math.sin(theta)

	local point = Vector(x, y)
	local direction = point:Normalized()

	-- minimal offset so it doesn't drop below overboss throne (or too close to it)
	local complete_position = direction * RING_RADIUS_MINIMUM + OrbDropManager.overboss_position + point

	OrbDropManager.previous_location = complete_position
	OrbDropManager.previous_sector_id = sector_id
	OrbDropManager:AddWeightToSector(sector_id, rarity)

	return complete_position
end


function OrbDropManager:AddWeightToSector(sector_id, rarity)
	local weight = rarity * RARITY_WEIGHT_MULTIPLIER
	local adjacent = weight * ADJACENT_SECTOR_FACTOR

	local adjacent_left = math.wrap(sector_id - 1, 1, OrbDropManager.sector_count)
	local adjacent_right = math.wrap(sector_id + 1, 1, OrbDropManager.sector_count)

	OrbDropManager.sector_weights[adjacent_left] = OrbDropManager.sector_weights[adjacent_left] + adjacent
	OrbDropManager.sector_weights[sector_id] = OrbDropManager.sector_weights[sector_id] + weight
	OrbDropManager.sector_weights[adjacent_right] = OrbDropManager.sector_weights[adjacent_right] + adjacent

	-- print("added weights", sector_id, weight)
	-- DeepPrintTable(OrbDropManager.sector_weights)
end


function OrbDropManager:SelectRingOrbDropLocation(rarity)
	-- for double orb modes, every second call should mirror previous
	if GameMode.do_double_orb_drops and OrbDropManager.previous_location and OrbDropManager.previous_sector_id then
		local location = OrbDropManager.overboss_position - OrbDropManager.previous_location
		OrbDropManager.previous_location = nil

		-- technically this is not entirely correct, since mirrored orb should add weight to mirrored sector
		-- but since orbs are doubled anyway, this shouldn't matter, and calculating proper mirrored sector is annoying
		OrbDropManager:AddWeightToSector(OrbDropManager.previous_sector_id, rarity)

		return location
	end

	-- adjust radius from orbs dropped, from min to max
	OrbDropManager.current_radius = math.min(OrbDropManager.ring_radius, RING_RADIUS_MINIMUM + OrbDropManager.orbs_dropped * RING_RADIUS_PER_ORB)

	OrbDropManager.orbs_dropped = OrbDropManager.orbs_dropped + 1

	if not OrbDropManager.__sectors_generated then
		OrbDropManager:GenerateSectors()

		local sector_id = RandomInt(1, OrbDropManager.sector_count)
		return OrbDropManager:GenerateRandomInSector(sector_id, rarity)
	end

	-- using somewhat deterministic system
	-- find minimum total orb value, and select random sector from pool that have that value
	-- that way balance is always eventually reached
	local _, min_value = table.min_value(OrbDropManager.sector_weights)
	local applicable_sectors = table.filter(OrbDropManager.sector_weights, function(k, v, t) return v == min_value end)

	local _, sector_id = table.random(applicable_sectors)

	-- print("generated next sector id", sector_id)

	return OrbDropManager:GenerateRandomInSector(sector_id, rarity)
end


function OrbDropManager:SelectEpicOrbDropLocation(orb_spawn_entities, last_entities)
	-- if weights are not initialized yet, fill with zeros, random whatever
	if table.count(OrbDropManager.epic_orb_weights) <= 0 then
		for index, entity in ipairs(orb_spawn_entities) do
			OrbDropManager.epic_orb_weights[index] = 0
		end

		local location_index = RandomInt(1, table.count(orb_spawn_entities))
		OrbDropManager.epic_orb_weights[location_index] = OrbDropManager.epic_orb_weights[location_index] + EPIC_ORB_WEIGHT
		return location_index
	end

	local weights = {}
	-- otherwise roll location with weightened random
	-- actual weights are reversed, so least picked location has the most weight
	-- not using default orbs algo because it will just drop in the same order on maps with smaller spawn entities (3 for quintet / octet)
	for index, entity in ipairs(orb_spawn_entities) do
		weights[index] = OrbDropManager.epic_orb_weights[index] or 0
	end

	local _, max_value = table.max_value(weights)
	local weights_reversed = table.map(OrbDropManager.epic_orb_weights, function(t, location_index, location_value)
		return INVERSED_WEIGHT_MULTIPLIER * math.max(max_value - location_value + 1, 1)
	end)

	local location_index = table.random_weighted(weights_reversed)

	OrbDropManager.epic_orb_weights[location_index] = OrbDropManager.epic_orb_weights[location_index] + EPIC_ORB_WEIGHT

	return location_index
end