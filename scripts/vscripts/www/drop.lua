--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


if drop == nil then
	_G.drop = class({})
end

local item_drop = {
	-------------------------------------------QUEST-------------------------------------------
	{
		items = {
			"item_naga_stone",
		},
		chance = 100,
		limit = 100,
		units = {
			"npc_dota_zone_6_unit_4",
		},
	},
	-------------------------------------------BOXES-------------------------------------------
	{
		items = {
			"item_power_treads",
			"item_point_booster",
			"item_vitality_booster",
			"item_mithril_hammer",
			"item_platemail",
			"item_energy_booster",
			"item_yasha",
			"item_sange",
			"item_claymore",
			"item_javelin",
			"item_helm_of_iron_will",
		},
		chance = 100,
		units = {
			"invis_box",
		},
	},
	{
		items = {
			"item_null_talisman",
			"item_boots",
			"item_soul_ring",
			"item_chainmail",
			"item_blades_of_attack",
			"item_gloves",
			"item_belt_of_strength",
			"item_ring_of_basilius",
			"item_ring_of_regen",
			"item_robe",
		},
		chance = 100,
		units = {
			"small_box",
		},
	},
	{
		items = {
			"item_power_treads",
			"item_point_booster",
			"item_vitality_booster",
			"item_mithril_hammer",
			"item_platemail",
			"item_energy_booster",
			"item_yasha",
			"item_sange",
			"item_claymore",
			"item_javelin",
			"item_helm_of_iron_will",
		},
		chance = 100,
		units = {
			"middle_box",
		},
	},
	{
		items = {
			"item_ogre_axe",
			"item_blade_of_alacrity",
			"item_staff_of_wizardry",
			"item_energy_booster",
			"item_vitality_booster",
			"item_claymore",
			"item_point_booster",
			"item_medallion_of_courage",
			"item_mithril_hammer",
			"item_javelin",
		},
		chance = 100,
		units = {
			"big_box",
		},
	},
	{
		items = {
			"item_heart_lua1",
			"item_desolator_lua1",
			"item_vladmir_lua1",
			"item_rapier_lua1",
			"item_satanic_lua1",
			"item_skadi_lua1",
			"item_mjollnir_lua1",
			"item_assault_lua1",
			"item_shivas_guard_lua1",
			"item_bloodstone_lua1",
			"item_greater_crit_lua1",
			"item_butterfly_lua1",
			"item_radiance_lua1",
			"item_monkey_king_bar_lua1",
			"item_crimson_guard_lua1",
			"item_guardian_greaves_lua1",
		},
		chance = 100,
		units = {
			"ultra_box",
		},
	},
	{
		items = {
			"item_heart_lua1",
			"item_desolator_lua1",
			"item_vladmir_lua1",
			"item_rapier_lua1",
			"item_octarine_core_lua1",
			"item_skadi_lua1",
			"item_mjollnir_lua1",
			"item_assault_lua1",
			"item_shivas_guard_lua1",
			"item_bloodstone_lua1",
			"item_greater_crit_lua1",
			"item_butterfly_lua1",
			"item_radiance_lua1",
			"item_monkey_king_bar_lua1",
			"item_crimson_guard_lua1",
			"item_guardian_greaves_lua1",
			"item_satanic_lua1",
			"item_boss_soul",
		},
		chance = 100,
		units = {
			"epic_box",
		},
	},

	-------------------------------------------OTHER-------------------------------------------

	{
		items = {
			"item_xdes_heart",
		},
		chance = 100,
		limit = 1,
		units = {
			"npc_xdes",
		},
	},
	{
		items = {
			"item_ticket",
			"item_book_of_strength",
			"item_book_of_agility",
			"item_book_of_intelligence",
		},
		chance = 10,
		duration = 30,
		units = {
			"npc_dota_zone_1_unit_2",
			"npc_dota_zone_1_unit_1",
			"npc_dota_zone_1_unit_3",
			"npc_dota_zone_1_unit_4",
			"npc_dota_zone_1_unit_5",
			"npc_dota_zone_1_unit_6",
			"npc_dota_zone_2_unit_2",
			"npc_dota_zone_2_unit_3",
			"npc_dota_zone_3_unit_2",
			"npc_dota_zone_3_unit_3",
			"npc_dota_zone_3_unit_1",
			"npc_dota_zone_4_unit_3",
			"npc_dota_zone_4_unit_5",
			"npc_dota_zone_4_unit_1",
			"npc_dota_zone_4_unit_2",
			"npc_dota_boss_guardian",
			"npc_dota_zone_5_unit_1",
			"npc_dota_zone_5_unit_3",
			"npc_dota_zone_5_unit_2",
			"npc_dota_zone_6_unit_3",
			"npc_dota_zone_6_unit_1",
			"npc_dota_zone_6_unit_4",
			"npc_dota_zone_7_unit_1",
			"npc_dota_zone_7_unit_2",
			"npc_dota_zone_7_unit_3",
			"npc_dota_zone_7_unit_4",
			"npc_dota_zone_8_unit_5",
			"npc_dota_zone_8_unit_3",
			"npc_dota_zone_8_unit_4",
			"npc_dota_zone_8_unit_2",
			"npc_dota_zone_8_unit_6",
			"npc_dota_zone_9_unit_3",
			"npc_dota_zone_9_unit_1",
			"npc_dota_zone_9_unit_2",
			"npc_dota_zone_10_unit_1",
			"npc_dota_zone_10_unit_4",
			"npc_dota_zone_10_unit_3",
			"npc_dota_zone_11_unit_1",
			"npc_dota_zone_11_unit_2",
			"npc_dota_zone_11_unit_3",
			"npc_dota_zone_11_unit_4",
		},
	},
	{
		items = {
			"item_cheese_lua",
		},
		chance = 70,
		units = {
			"roshan_npc",
		},
	},
	{
		items = {
			"item_aegis_lua",
		},
		chance = 100,
		units = {
			"roshan_npc",
		},
	},
	{
		items = {
			"item_lapa_ursa",
		},
		chance = 100,
		limit = 1,
		units = {
			"npc_dota_boss_ursa",
		},
	},
	{
		items = {
			"item_undying_skin",
		},
		chance = 100,
		limit = 1,
		units = {
			"npc_dota_boss_undying",
		},
	},
	{
		items = {
			"item_lich_heart",
		},
		chance = 100,
		limit = 1,
		units = {
			"npc_dota_boss_lich",
		},
	},
	{
		items = {
			"item_tiny_buff",
		},
		chance = 100,
		limit = 1,
		units = {
			"npc_dota_boss_tiny",
		},
	},
	{
		items = {
			"item_speed_",
			"item_boots_speed_",
			"item_crit_",
			"item_bolt_",
			"item_bash_",
		},
		rares = true,
		chance = 100,
		limit = 2,
		units = {
			"npc_hidden_snow_boss",
			"npc_hidden_earth_boss",
		},
	},
}

local unitToDrop = {}

local zombie_configs = {
	["npc_zone_9_tomb_minion_1"] = {
		items = { "item_candy1" },
		chance = 15,
	},
	["npc_zone_9_tomb_minion_2"] = {
		items = { "item_candy2" },
		chance = 15,
	},
	["npc_zone_9_tomb_minion_3"] = {
		items = { "item_candy3" },
		chance = 15,
	},
	["npc_zone_9_tomb_minion_4"] = {
		items = { "item_candy4" },
		chance = 15,
	},
}

for customName, data in pairs(zombie_configs) do
	unitToDrop[customName] = { data }
end

for _, dropData in pairs(item_drop) do
	for _, unitName in pairs(dropData.units) do
		unitToDrop[unitName] = unitToDrop[unitName] or {}

		table.insert(unitToDrop[unitName], dropData)
	end
end

function drop:init()
	ListenToGameEvent("entity_killed", Dynamic_Wrap(drop, "OnEntityKilled"), self)
	ListenToGameEvent("dota_item_spawned", Dynamic_Wrap(drop, "AutoDeleteUnitDrops"), self)
end

function drop:OnEntityKilled(keys)
	local killedUnit = EntIndexToHScript(keys.entindex_killed)
	local attacker = keys.entindex_attacker and EntIndexToHScript(keys.entindex_attacker) or nil

	if killedUnit and not killedUnit:IsRealHero() then
		self:RollItemDrop(killedUnit, attacker)
	end
end

function drop:RollItemDrop(unit, attacker)
	if not IsServer() or not attacker then
		return
	end

	-- local pID = attacker:GetPlayerOwnerID()

	if _G.guild_events:IsAnyEventActiveForPlayer(attacker) then
		return
	end

	local unitDrops = unitToDrop[unit.force_drop_name or unit:GetUnitName()]
	if not unitDrops then
		return
	end

	for _, dropData in ipairs(unitDrops) do
		self:DoDropItem(dropData, unit)
	end
end

function drop:DoDropItem(dropData, unit)
	if RandomInt(1, 100) > dropData.chance then
		return
	end

	if dropData.limit then
		if dropData.limit <= 0 then
			return
		end

		dropData.limit = dropData.limit - 1
	end

	local item_name
	if #dropData.items > 1 then
		item_name = dropData.items[RandomInt(1, #dropData.items)]
	else
		item_name = dropData.items[1]
	end

	if dropData.rares then
		local rare_roll = RandomInt(1, 100)
		if rare_roll <= 15 then
			item_name = item_name .. "legendary"
		elseif rare_roll <= 45 then
			item_name = item_name .. "rare"
		else
			item_name = item_name .. "common"
		end
	end

	local spawnPoint = unit:GetAbsOrigin()
	local newItem = CreateItem(item_name, nil, nil)
	local itemDrop = CreateItemOnPositionForLaunch(spawnPoint, newItem)
	local dropRadius = RandomInt(50, 100)

	newItem:LaunchLootInitialHeight(false, 0, 150, 0.5, spawnPoint + RandomVector(dropRadius))

	if dropData.duration then
		newItem:SetContextThink("KillLoot", function()
			return self:KillLoot(newItem, itemDrop)
		end, dropData.duration)
	end
end

function drop:KillLoot(item, itemDrop)
	if itemDrop:IsNull() then
		return
	end

	local nFXIndex =
		ParticleManager:CreateParticle("particles/items2_fx/veil_of_discord.vpcf", PATTACH_CUSTOMORIGIN, itemDrop)
	ParticleManager:SetParticleControl(nFXIndex, 0, itemDrop:GetOrigin())
	ParticleManager:SetParticleControl(nFXIndex, 1, Vector(35, 35, 25))
	ParticleManager:ReleaseParticleIndex(nFXIndex)

	UTIL_Remove(item)
	UTIL_Remove(itemDrop)
end

local itemsForAutoDelete = {
	["item_health_potion"] = 30,
	["item_mana_potion"] = 30,
	["item_candy1"] = 10,
	["item_candy2"] = 10,
	["item_candy3"] = 10,
	["item_candy4"] = 10,
	["item_book_of_strength"] = 30,
	["item_book_of_agility"] = 30,
	["item_book_of_intelligence"] = 30,
	["item_bag_of_gold"] = 30,
	["item_ticket"] = 30,
}

function drop:AutoDeleteUnitDrops(event)
	if not IsServer() then
		return
	end

	if event.player_id ~= -1 then
		return
	end

	local item = EntIndexToHScript(event.item_ent_index)

	if not item then
		return
	end

	local removalDelayTime = itemsForAutoDelete[item:GetName()]

	if not removalDelayTime then
		return
	end

	Timers:CreateTimer(0, function()
		local itemContainer = item:GetContainer()

		if not itemContainer then
			return
		end

		item:SetContextThink("KillLoot", function()
			if itemContainer:IsNull() then
				return
			end

			local nFXIndex =
				ParticleManager:CreateParticle("particles/items2_fx/veil_of_discord.vpcf", PATTACH_CUSTOMORIGIN, item)
			ParticleManager:SetParticleControl(nFXIndex, 0, item:GetOrigin())
			ParticleManager:SetParticleControl(nFXIndex, 1, Vector(35, 35, 25))
			ParticleManager:ReleaseParticleIndex(nFXIndex)

			UTIL_Remove(itemContainer)
		end, removalDelayTime)
	end)
end

drop:init()