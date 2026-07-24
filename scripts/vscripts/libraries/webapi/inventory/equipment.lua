--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


Equipment = Equipment or {}


function Equipment:Init()
	Equipment.slot_callbacks = {
		[INVENTORY_SLOTS.PET] = Equipment.OnPetEquipped,
		[INVENTORY_SLOTS.SPRAY] = Equipment.OnSprayEquipped,
		[INVENTORY_SLOTS.COSMETIC_SKILL] = Equipment.OnCosmeticSkillEquipped,
	}

	EventDriver:Listen("Events:entity_killed", Equipment.OnEntityKilled, Equipment)
	EventDriver:Listen("Events:npc_spawned", Equipment.OnNpcSpawned, Equipment)
	EventDriver:Listen("Events:hero_picked", Equipment.OnHeroPicked, Equipment)

	Equipment.__assigned_equipped_items = {}
	Equipment._scheduled_updates = {}
	Equipment.equipped_items = {}

	EventStream:Listen("WebInventory:get_equipped_items", Equipment.SendEquippedItems, Equipment)
	EventStream:Listen("WebInventory:equip", Equipment.EquipEvent, Equipment)
	EventStream:Listen("WebInventory:unequip", Equipment.UnequipEvent, Equipment)

	Equipment:StartBackendUpdateTimer()
end


function Equipment:SpecialSlotEquipped(player_id, hero, item_name, item_definition)
	local callback = Equipment.slot_callbacks[item_definition.slot]
	if not callback then return end

	return ErrorTracking.Try(callback, Equipment, player_id, hero, item_name, item_definition)
end


function Equipment:AssignEquippedItems(player_id, equipped_items)
	Equipment.__assigned_equipped_items[player_id] = equipped_items
end


function Equipment:ApplyEquippedItems(player_id)
	if not Equipment.__assigned_equipped_items[player_id] then
		return
	end
	-- print("[Equipment] setting equipped items", player_id)
	DeepPrintTable(Equipment.__assigned_equipped_items[player_id])
	for slot, item in pairs(Equipment.__assigned_equipped_items[player_id] or {}) do
		if type(item) == "string" then
			Equipment:Equip(player_id, item)
		else
			for _, m_item in pairs(item) do
				Equipment:Equip(player_id, m_item)
			end
		end
	end
	Equipment:UpdateClient(player_id)
end


function Equipment:Equip(player_id, item_name)
	print("[Equipment] Equip", player_id, item_name)
	Equipment.equipped_items[player_id] = Equipment.equipped_items[player_id] or {}

	if not WebInventory:HasItem(player_id, item_name) then
		print("[Equipment] discarded equip as player " .. player_id .. " doesn't own item ", item_name)
		DisplayError(player_id, "#dota_hud_error_cant_equip_unowned_item")
		return
	end

	local item_definition = ITEM_DEFINITIONS[item_name]
	if not item_definition then print("[Equipment] no definition found for", item_name) return end

	local slot = item_definition.slot
	if not slot then print("[WebInventory] no slot found for item", item_name) return end

	local slot_equipment_policy = Equipment:GetSlotEquipmentPolicy(slot)

	local hero = PlayerResource:GetSelectedHeroEntity(player_id)

	local current_equipped_item = Equipment.equipped_items[player_id][slot]
	if current_equipped_item and slot_equipment_policy ~= EQUIPMENT_POLICY.MANUAL then
		Equipment:Unequip(player_id, current_equipped_item.name)
	end

	local resource_list = Equipment:GetItemResourceList(item_definition)
	PrecacheManager:PrecacheResourceListAsync(resource_list, function()
		print("Resource list precached for", item_name)
		if Equipment.slot_callbacks[slot] then
			local _, modifiers, particles, units = Equipment:SpecialSlotEquipped(player_id, hero, item_name, item_definition)
			-- print("[Equipment] special slot returned:", modifiers, particles, units)
			if slot_equipment_policy ~= EQUIPMENT_POLICY.MANUAL then
				Equipment.equipped_items[player_id][slot] = {
					name = item_name,
					modifiers = modifiers,
					particles = particles,
					units = units
				}
			end
		else
			Equipment.equipped_items[player_id][slot] = {
				name = item_name,
			}
			-- print("[Equipment] equipped item", Equipment.equipped_items[player_id][slot].name)
			if slot_equipment_policy ~= EQUIPMENT_POLICY.AUTO_SKIP_EFFECT_ON_EQUIP then
				local modifiers, particles = Equipment:PlayItemEffects(player_id, item_name, hero)
				Equipment.equipped_items[player_id][slot].modifiers = modifiers
				Equipment.equipped_items[player_id][slot].particles = particles

				-- apply equipped item to meepo clones
				local clones = hero:GetClones()
				for _, clone in pairs(clones or {}) do
					local modifiers, particles = Equipment:PlayItemEffects(player_id, item_name, clone)
					clone._equipment_bound_assets[item_name] = {
						modifiers = modifiers,
						particles = particles
					}
				end
			end
		end
		Equipment:UpdateClient(player_id)
	end)

	Equipment:UpdateClient(player_id)
	return true
end


function Equipment:GetItemResourceList(item_definition)
	local resource_list = {}

	if item_definition.particles then
		for _, particle_data in pairs(item_definition.particles) do
			print("[Resource List] precaching particle", particle_data.path)
			-- PrecacheResource("particle", particle_data.path, context)
			resource_list[particle_data.path] = "particle"
		end
	end
	if item_definition.particle_variants then
		for _, particle_data in pairs(item_definition.particle_variants) do
			print("[Resource List] precaching particle variant", particle_data.path)
			-- PrecacheResource("particle", particle_data.path, context)
			resource_list[particle_data.path] = "particle"
		end
	end
	if item_definition.blink_particles then
		if item_definition.blink_particles.start_name then
			-- PrecacheResource("particle", item_definition.blink_particles.start_name, context)
			resource_list[item_definition.blink_particles.start_name] = "particle"
		end
		if item_definition.blink_particles.end_name then
			-- PrecacheResource("particle", item_definition.blink_particles.end_name, context)
			resource_list[item_definition.blink_particles.end_name] = "particle"
		end
	end

	if item_definition.model_path then
		print("[Resource List] precaching model", item_definition.model_path)
		-- PrecacheResource("model", item_definition.model_path, context)
		resource_list[item_definition.model_path] = "model"
	end

	return resource_list
end



function Equipment:Unequip(player_id, item_name)
	Equipment.equipped_items[player_id] = Equipment.equipped_items[player_id] or {}

	local slot = WebInventory:GetItemSlot(item_name)
	if not slot then return end

	if not Equipment.equipped_items[player_id][slot] or Equipment.equipped_items[player_id][slot].name ~= item_name then
		return
	end

	Equipment:DestroyItemEffects(player_id, item_name)
	Equipment.equipped_items[player_id][slot] = nil

	local hero = PlayerResource:GetSelectedHeroEntity(player_id)
	if not IsValidEntity(hero) then return end

	local clones = hero:GetClones()
	-- destroy unequipped effect from meepo clones
	for _, clone in pairs(clones or {}) do
		local assets = clone._equipment_bound_assets[item_name]
		if assets then
			Equipment:_RemoveAssetsFromTable(assets)
			clone._equipment_bound_assets[item_name] = nil
		end
	end

	Equipment:UpdateClient(player_id)
	return true
end


function Equipment:ParticleFromData(player_id, particle_data, unit, target_table)
	if not IsValidEntity(unit) then return end
	-- print("[Equipment] ParticleFromData", particle_data.path, particle_data.attach_type, unit)
	local p_id = ParticleManager:CreateParticle(particle_data.path, particle_data.attach_type, unit)

	for cp_id, cp_data in pairs(particle_data.control_points or {}) do
		if cp_data.attachment then
			ParticleManager:SetParticleControlEnt(p_id, cp_id, unit, cp_data.attach_type, cp_data.attachment, unit:GetAbsOrigin(), true)
		end
		if cp_data.orientation then
			ParticleManager:SetParticleControlTransform(p_id, cp_id, unit:GetOrigin(), unit:GetAngles())
		end
	end

	-- unset `persists` flag defaults to true
	if particle_data.persists == nil or particle_data == true then
		print("[Equipment] saving persistent particle id", p_id)
		table.insert(target_table, p_id)
	else
		print("[Equipment] releasing particle id", p_id)
		ParticleManager:ReleaseParticleIndex(p_id)
	end

	return p_id
end


function Equipment:PlayItemEffects(player_id, item_name, target_override, particle_variant)
	-- print("[Equipment] PlayItemEffects", player_id, item_name, target_override)
	local definition = ITEM_DEFINITIONS[item_name]
	local modifiers = {}
	local particles = {}

	local unit
	if target_override then
		unit = target_override
	else
		unit = PlayerResource:GetSelectedHeroEntity(player_id)
		-- print("[Equipment] inferring player hero", unit)
	end

	-- variant particle currently is never persistent
	if definition.particle_variants and particle_variant then
		local particle_data = definition.particle_variants[particle_variant]
		local p_id = Equipment:ParticleFromData(
			player_id, particle_data, unit, particles
		)
		-- print("[Equipment] created variant particle", p_id)
	end

	for _, particle_data in pairs(definition.particles or {}) do
		if particle_data.attach_type == PATTACH_SPECIAL_STATUS_FX then
			unit:RemoveModifierByName("modifier_hero_status_fx")

			local modifier = unit:AddNewModifier(unit, nil, "modifier_hero_status_fx", {
				duration = -1,
				status_fx_name = particle_data.path
			})

			table.insert(modifiers, modifier)
		else
			Equipment:ParticleFromData(player_id, particle_data, unit, particles)
		end
	end

	if definition.sound_effect then
		unit:EmitSound(definition.sound_effect)
	end

	return modifiers, particles
end


function Equipment:_RemoveBoundAssets(unit)
	if not unit._equipment_bound_assets then return end
	for _, assets in pairs(unit._equipment_bound_assets) do
		Equipment:_RemoveAssetsFromTable(assets)
	end
	unit._equipment_bound_assets = {}
end


function Equipment:_RemoveAssetsFromTable(assets_table)
	-- print("[Equipment] Particles to remove: ", #(assets_table.particles or {}))
	for _, p_id in pairs(assets_table.particles or {}) do
		-- print("\tdestroying particle", p_id)
		ParticleManager:DestroyParticle(p_id, true)
		ParticleManager:ReleaseParticleIndex(p_id)
	end
	assets_table.particles = {}

	-- print("[Equipment] Modifiers to remove: ", #(assets_table.modifiers or {}))
	for _, modifier in pairs(assets_table.modifiers or {}) do
		-- print("\tdestroying modifier", modifier:GetName())
		if modifier and not modifier:IsNull() then
			modifier:Destroy()
		end
	end
	assets_table.modifiers = {}

	-- print("[Equipment] Handles to remove: ", #(assets_table.units or {}))
	for _, unit in pairs(assets_table.units or {}) do
		if IsValidEntity(unit) then
			-- print("\tdestroying handle", unit:GetUnitName())
			unit:RemoveSelf()
		end
	end
	assets_table.units = {}
end


function Equipment:DestroyItemEffects(player_id, item_name)
	local slot = WebInventory:GetItemSlot(item_name)

	local current_equipped_item = Equipment.equipped_items[player_id][slot]
	if not current_equipped_item then return end

	Equipment:_RemoveAssetsFromTable(current_equipped_item)
end


function Equipment:GetEquippedItems(player_id)
	local result = {}
	for slot, item in pairs(Equipment.equipped_items[player_id] or {}) do
		result[slot] = item.name
	end
	return result
end


function Equipment:GetItemInSlot(player_id, slot)
	if not Equipment.equipped_items[player_id] then return end
	if not Equipment.equipped_items[player_id][slot] then return end

	return Equipment.equipped_items[player_id][slot]
end


function Equipment:GetParticleVariant(item_name, variant)
	local definition = ITEM_DEFINITIONS[item_name]
	if not definition or not definition.particle_variants then print("[Equipment] no definition or particle variants defined for", item_name) return end
	return definition.particle_variants[variant]
end


function Equipment:SendEquippedItems(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	Equipment:UpdateClient(player_id)
end


function Equipment:EquipEvent(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end
	if not event.item_name then return end

	if Equipment:Equip(player_id, event.item_name) then
		Equipment:ScheduleBackendUpdate(player_id)
	end
end


function Equipment:UnequipEvent(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end
	if not event.item_name then return end

	if Equipment:Unequip(player_id, event.item_name) then
		Equipment:ScheduleBackendUpdate(player_id)
	end
end


function Equipment:UpdateClient(player_id)
	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	CustomGameEventManager:Send_ServerToPlayer(player, "WebInventory:update_equipped_items", {
		equipped_items = Equipment:GetEquippedItems(player_id)
	})
end


function Equipment:OnEntityKilled(event)
	local killer = event.killer
	local killed = event.killed

	if not IsValidEntity(killed) then return end
	-- destroy all effects attached to died illusion / clone
	if killed:IsIllusion() or killed:IsClone() then
		Equipment:_RemoveBoundAssets(killed)
	end

	if not IsValidEntity(killer) then return end

	local killer_player_owner_id = killer:GetPlayerOwnerID()
	if not killer_player_owner_id or killer_player_owner_id == -1 then return end
	if killer:GetTeam() == killed:GetTeam() then return end

	-- kill effect has 2 variants - for hero and for creeps
	local effect_item = Equipment:GetItemInSlot(killer_player_owner_id, INVENTORY_SLOTS.KILL_EFFECT)
	if not effect_item then return end

	local variant = killed:IsRealHero() and "hero" or "creature"

	Equipment:PlayItemEffects(killer_player_owner_id, effect_item.name, killed, variant)
end


function Equipment:OnNpcSpawned(event)
	if not event.unit:IsIllusion() and not event.unit:IsClone() and not event.unit:IsTempestDouble() then return end

	local player_id = event.unit:GetPlayerOwnerID()
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	Equipment:_RemoveBoundAssets(event.unit)
	event.unit._equipment_bound_assets = {}
	for slot, item in pairs(Equipment.equipped_items[player_id] or {}) do
		if not Equipment.slot_callbacks[slot] then
			local modifiers, particles = Equipment:PlayItemEffects(player_id, item.name, event.unit)
			event.unit._equipment_bound_assets[item.name] = {
				modifiers = modifiers,
				particles = particles
			}
		end
	end
end


function Equipment:OnHeroPicked(event)
	-- wait until picked hero is properly initialized
	Timers:CreateTimer(1, function()
		if not IsValidEntity(event.hero) then return end
		if not PlayerResource:GetSelectedHeroEntity(event.player_id) then
			return 1
		end
		CosmeticAbilities:PrepareForHero(event.player_id, event.hero)
		Equipment:ApplyEquippedItems(event.player_id)
	end)
end


function Equipment:GetSlotEquipmentPolicy(slot)
	return SLOT_EQUIPMENT_POLICY[slot] or EQUIPMENT_POLICY.AUTO
end


function Equipment:ScheduleBackendUpdate(player_id)
	Equipment._scheduled_updates[player_id] = true
end


function Equipment:StartBackendUpdateTimer()
	-- send request to backend on interval to update equipped items
	-- but only if there's any scheduled changed
	-- this request batches all players with any changes detected
	Equipment._backend_request_timer = Timers.CreateTimer(EQUIPMENT_UPDATE_DELAY, function()
		if next(Equipment._scheduled_updates) == nil then return EQUIPMENT_UPDATE_DELAY end

		local equipped_items = {}

		for player_id, _ in pairs(Equipment._scheduled_updates or {}) do
			local steam_id = tostring(PlayerResource:GetSteamID(player_id))
			equipped_items[steam_id] = Equipment:GetEquippedItems(player_id)
		end
		DeepPrintTable(equipped_items)
		WebApi:Send(
			"api/lua/inventory/set_equipped_items",
			{
				players_equipped_items = equipped_items,
			},
			function()
				Equipment._scheduled_updates = {}
				print("[Equipment] successfully updated equipment on backend")
			end,
			function()
				print("[Equipment] failed to update equipped items on backend")
			end
		)

		return EQUIPMENT_UPDATE_DELAY
	end)
end


-----------------------------------------------------------------------------
-- EQUIPMENT CALLBACKS
-----------------------------------------------------------------------------


function Equipment:OnPetEquipped(player_id, hero, item_name, item_definition)
	-- create a new unit for pet (old one is deleted in unequip)
	-- uses single unit name for any pet, sets the model / flying status / material etc
	-- attaches all defined particles of an item to pet unit
	local model_path = item_definition.model_path
	local pet = CreateUnitByName(
		"npc_cosmetic_pet",
		hero:GetAbsOrigin() + RandomVector(300), true,
		hero, hero, hero:GetTeam()
	)
	-- pet:SetOwner(hero)
	pet:SetForwardVector(hero:GetForwardVector())
	local pet_modifier = pet:AddNewModifier(hero, nil, "modifier_equipped_pet", {duration = -1})
	pet:RemoveModifierByName("modifier_pet")
	pet:SetModel(model_path)
	pet:SetOriginalModel(model_path)
	pet:SetModelScale(item_definition.model_scale or 1)

	-- pet:StartGesture(ACT_DOTA_SPAWN)

	if item_definition.material_group then
		pet:SetMaterialGroup(item_definition.material_group)
	end

	if item_definition.is_flying then
		pet_modifier:SetStackCount(1)
	end

	-- note that pet is used as target override
	local modifiers, particles = Equipment:PlayItemEffects(player_id, item_name, pet)

	-- technically, at least modifiers would get deleted with unit removal
	-- but just to be safe/sure, sign them up for cleanup
	return modifiers, particles, {pet, }
end


function Equipment:OnSprayEquipped(player_id, hero, item_name, item_definition)
	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	CustomGameEventManager:Send_ServerToPlayer(player, "CosmeticAbilities:update_spray", {
		spray = item_name
	})
end


function Equipment:OnCosmeticSkillEquipped(player_id, hero, item_name, item_definition)
	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	local dummy = CosmeticAbilities:GetDummyCaster(player_id)
	CosmeticAbilities:AddAbility(dummy, item_name)

	CustomGameEventManager:Send_ServerToPlayer(player, "CosmeticAbilities:update_ability", {
		ability = item_name
	})
end


function Equipment:OnTestUse(item_name, definition)
	print("[Equipment] test item used", item_name)
end


Equipment:Init()