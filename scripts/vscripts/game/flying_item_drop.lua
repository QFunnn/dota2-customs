--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


FlyingTreasureDrop = FlyingTreasureDrop or class({})


function FlyingTreasureDrop:Init()
    self.spawn_id = 1
	self.current_tick = 0
    self.spawn_time = GameLoop.current_layout.flying_item_drop_time

	self.item_spawn_location = Entities:FindByName(nil, "greevil")
	self:InitOrbDropLocationList()

	self.staged_orbs = {}
	self.current_vision_revealers = {}

	self.orbs_per_launch = 1

	self.active_path_particles = {}

	ListenToGameEvent("dota_npc_goal_reached", Dynamic_Wrap(FlyingTreasureDrop, "OnNpcGoalReached"), self)

	EventDriver:Listen("WebSettings:settings_changed", FlyingTreasureDrop.OnPlayerSettingsChanged, FlyingTreasureDrop)
end


function FlyingTreasureDrop:InitOrbDropLocationList()
	self.orb_entities = {}
	self.previous_entities = {}

	for i = 1, 20 do
		local drop_location = Entities:FindByName(nil, "item_spawn_" .. i)
		if drop_location then
			table.insert(self.orb_entities, drop_location)
		end
	end
end


function FlyingTreasureDrop:OnNpcGoalReached(event)
    local npc = EntIndexToHScript(event.npc_entindex)

    if npc:GetUnitName() == "npc_dota_treasure_courier" then
        self:TreasureDrop(npc)
    end
end


function FlyingTreasureDrop:ThinkSpecialItemDrop()
	if GameLoop.game_over then return end

    -- Don't spawn if the game is about to end
	self.current_tick = self.current_tick + 1

	local expected_spawn_tick = self.spawn_time * self.spawn_id

	if GetMapName() == "ot3_desert_octet" then return end

	if self.current_tick == expected_spawn_tick - 15 then
		self:StageOrbLaunches()
	end

	if self.current_tick == expected_spawn_tick then
		self:LaunchStagedOrbs()
	end
end


function FlyingTreasureDrop:RollOrbLocations()
	local target_indices = {}

	if #self.previous_entities >= #self.orb_entities then
		self.previous_entities = {}
	end

	local orbs_per_launch = GameMode.do_double_orb_drops and self.orbs_per_launch * 2 or self.orbs_per_launch

	-- print("requested orbs count:", orbs_per_launch)

	for i = 1, orbs_per_launch do
		local expected_index

		if i % 2 == 0 then
			local previous_index = target_indices[i - 1]
			-- for even indices in orbs per launch opposite of previous location is chosen
			if GetMapName() == "ot3_necropolis_ffa" then
				expected_index = 1 + (previous_index - 1 + #self.orb_entities / 2) % #self.orb_entities
			-- for other maps with uneven spawn count, just select any other spawn point
			else
				local _, randomed_index = table.random_with_condition(self.orb_entities, function(t, k, v) return k ~= previous_index end)
				expected_index = randomed_index
			end

			-- print("previous index: ", previous_index, "expected index: ", expected_index)
		else
			-- roll target point, fetch position with returned index
			expected_index = OrbDropManager:SelectEpicOrbDropLocation(self.orb_entities, self.previous_entities)
			-- print("selected expected index: ", expected_index)
		end

		table.insert(self.previous_entities, expected_index)
		table.insert(target_indices, expected_index)
	end

	return target_indices
end


function FlyingTreasureDrop:StageOrbLaunches()
	self.staged_orbs = FlyingTreasureDrop:RollOrbLocations()

	EmitGlobalSound("powerup_03")

	self.current_vision_revealers[self.spawn_id] = self.current_vision_revealers[self.spawn_id] or {}

	for i, target_index in pairs(self.staged_orbs) do
		local spawn_location = self.orb_entities[target_index]:GetAbsOrigin()
		PingLocationForEveryoneWithDelay(spawn_location, i - 1)

		DoEntFire("item_spawn_particle_" .. target_index, "Start", "0", 0, self, self)

		local vision_revealer = CreateUnitByName("npc_vision_revealer", spawn_location, false, nil, nil, DOTA_TEAM_GOODGUYS)
		vision_revealer:AddNewModifier(vision_revealer, nil, "modifier_no_collision", { duration = -1 })

		local true_sight_particle = ParticleManager:CreateParticle("particles/econ/wards/f2p/f2p_ward/f2p_ward_true_sight_ambient.vpcf", PATTACH_ABSORIGIN, vision_revealer)
		ParticleManager:SetParticleControlEnt(true_sight_particle, PATTACH_ABSORIGIN, vision_revealer, PATTACH_ABSORIGIN, "attach_origin", vision_revealer:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(true_sight_particle)

		self.current_vision_revealers[self.spawn_id][target_index] = vision_revealer

		self:CreatePathParticles(self.spawn_id, target_index, spawn_location)
	end

	CustomGameEventManager:Send_ServerToAllClients("item_will_spawn", {})
end


function FlyingTreasureDrop:LaunchStagedOrbs()
	print("default staged launch")
	-- self:TreasureDrop(npc)
	EmitGlobalSound("powerup_05")
	CustomGameEventManager:Send_ServerToAllClients("item_has_spawned", {})

	for i, target_index in pairs(self.staged_orbs) do
		local launch_target = self.orb_entities[target_index]
		local spawn_location = launch_target:GetAbsOrigin()

		PingLocationForEveryoneWithDelay(spawn_location, i - 1)

		local treasure_courier = CreateUnitByName("npc_dota_treasure_courier", Vector(0, 0, 700), true, nil, nil, DOTA_TEAM_NEUTRALS)
		treasure_courier:AddNewModifier(treasure_courier, nil, "modifier_treasure_courier", {duration = -1})

		treasure_courier:SetInitialGoalEntity(launch_target)

		-- record which spawn wave sent courier, and in which order
		-- to properly remove vision revealers etc
		treasure_courier.spawn_id = self.spawn_id
		treasure_courier.target_index = target_index
	end

	self.spawn_id = self.spawn_id + 1
end


function FlyingTreasureDrop:LaunchStagedOctet()
	print("octet staged launch")
	EmitGlobalSound("powerup_05")
	CustomGameEventManager:Send_ServerToAllClients("item_has_spawned", {})

	local spawn_id = self.spawn_id

	for i, target_index in pairs(self.staged_orbs) do
		local launch_target = self.orb_entities[target_index]
		local spawn_location = launch_target:GetAbsOrigin()
		spawn_location.z = 400

		local vision_revealer = self.current_vision_revealers[spawn_id][target_index]
		self.current_vision_revealers[spawn_id][target_index] = nil

		if table.count(self.current_vision_revealers[spawn_id]) == 0 then self.current_vision_revealers[spawn_id] = nil end

		-- Spawn the orb capture area at the selected item spawn location
		local capture_point = GameMode:SpawnOrbDrop(spawn_location, UPGRADE_RARITY_EPIC, false, function()
			-- on orb capture - remove fow revealer and path particles
			self:DestroyPathParticles(spawn_id, target_index)
			UTIL_Remove(vision_revealer)
		end)

		capture_point:SetOrigin(GetGroundPosition(spawn_location, capture_point))

		-- Stop the particle effect
		DoEntFire("item_spawn_particle_" .. target_index, "stopplayendcap", "0", 0, self, self)

		self:KnockBackFromTreasure(spawn_location, 375, 0.25, 400, 100)
	end

	self.spawn_id = self.spawn_id + 1
end


function FlyingTreasureDrop:TreasureDrop(treasure_courier)
    local spawn_point = treasure_courier:GetInitialGoalEntity():GetAbsOrigin()
    spawn_point.z = 400

    -- Create the death effect for the courier
    local death_particle = ParticleManager:CreateParticle("particles/treasure_courier_death.vpcf", PATTACH_CUSTOMORIGIN, nil)
    ParticleManager:SetParticleControl(death_particle, 0, spawn_point)
    ParticleManager:SetParticleControlOrientation(death_particle, 0, treasure_courier:GetForwardVector(), treasure_courier:GetRightVector(), treasure_courier:GetUpVector())
	ParticleManager:ReleaseParticleIndex(death_particle)

	treasure_courier:EmitSound("lockjaw_Courier.Impact")
	treasure_courier:EmitSound("lockjaw_Courier.gold_big")

	local vision_revealer = self.current_vision_revealers[treasure_courier.spawn_id][treasure_courier.target_index]
	self.current_vision_revealers[treasure_courier.spawn_id][treasure_courier.target_index] = nil

	if table.count(self.current_vision_revealers[treasure_courier.spawn_id]) == 0 then self.current_vision_revealers[treasure_courier.spawn_id] = nil end

    -- Spawn the orb capture area at the selected item spawn location
    local capture_point = GameMode:SpawnOrbDrop(spawn_point, UPGRADE_RARITY_EPIC, false, function()
		-- on orb capture - remove fow revealer and path particles
		self:DestroyPathParticles(treasure_courier.spawn_id, treasure_courier.target_index)
		UTIL_Remove(vision_revealer)
    end)

    capture_point:SetOrigin(GetGroundPosition(spawn_point, capture_point))

    -- Stop the particle effect
    DoEntFire("item_spawn_particle_" .. treasure_courier.target_index, "stopplayendcap", "0", 0, self, self)

    self:KnockBackFromTreasure(spawn_point, 375, 0.25, 400, 100)

    UTIL_Remove(treasure_courier)
end


function FlyingTreasureDrop:KnockBackFromTreasure(center, radius, knockback_duration, knockback_distance, knockback_height)
    local target_type = bit.bor(DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_HERO)
    local units = FindUnitsInRadius(DOTA_TEAM_NOTEAM, center, nil, radius, DOTA_UNIT_TARGET_TEAM_BOTH, target_type, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)

    for _, unit in pairs(units or {}) do
        unit:AddNewModifier(unit, nil, "modifier_knockback", {
			center_x = center.x,
			center_y = center.y,
			center_z = center.z,
			duration = knockback_duration,
			knockback_duration = knockback_duration,
			knockback_distance = knockback_distance,
			knockback_height = knockback_height
		});
    end
end


function FlyingTreasureDrop:CreatePathParticles(spawn_id, target_index, point)
	-- create path particles separately per-player
	-- so that every player can control particle visibility for themself

	self.active_path_particles[spawn_id] = self.active_path_particles[spawn_id] or {}

	local attachment_entity = Entities:FindByName(nil, "@overboss")

	local particles = {}

	for player_id, _ in pairs(GameLoop.hero_by_player_id) do
		local player = PlayerResource:GetPlayer(player_id)
		if IsValidEntity(player) then
			local p_id = ParticleManager:CreateParticleForPlayer("particles/epic_pathfinder.vpcf", PATTACH_ABSORIGIN, attachment_entity, player)
			ParticleManager:SetParticleControl(p_id, 1, IsValidEntity(attachment_entity) and attachment_entity:GetAbsOrigin() or Vector(0, 0, 0))
			ParticleManager:SetParticleControl(p_id, 0, point)

			local transparency = WebSettings:GetSettingValue(player_id, "disable_epic_path", false) and 0 or 1
			ParticleManager:SetParticleControl(p_id, 6, Vector(transparency, 0, 0))

			particles[player_id] = p_id
		end
	end

	self.active_path_particles[spawn_id][target_index] = particles
end


function FlyingTreasureDrop:DestroyPathParticles(spawn_id, target_index)
	if not self.active_path_particles[spawn_id] or not self.active_path_particles[spawn_id][target_index] then return end

	local active_particles = self.active_path_particles[spawn_id][target_index]

	for _, p_id in pairs(active_particles or {}) do
		ParticleManager:DestroyParticle(p_id, true)
		ParticleManager:ReleaseParticleIndex(p_id)
	end

	self.active_path_particles[spawn_id][target_index] = nil

	if table.count(self.active_path_particles) <= 0 then self.active_path_particles[spawn_id] = nil end
end


function FlyingTreasureDrop:OnPlayerSettingsChanged(event)
	-- toggle active path particles
	if event.setting_name ~= "disable_epic_path" then print("discarded changed settings", event.setting_name) return end

	local player_id = event.player_id

	local transparency = event.setting_value and 0 or 1

	for _, targets in pairs(self.active_path_particles or {}) do
		for _, particles in pairs(targets or {}) do
			local player_particle = particles[player_id]

			if player_particle then
				ParticleManager:SetParticleControl(player_particle, 6, Vector(transparency, 0, 0))
			end
		end
	end
end