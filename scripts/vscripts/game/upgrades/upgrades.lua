--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


Upgrades = Upgrades or {}

require("game/upgrades/declarations")
require("game/upgrades/summons_list")
require("game/upgrades/shared")
require("game/upgrades/rerolls")
require("game/upgrades/generic_upgrades/init")


function Upgrades:Init()
	-- load kvs
	self.upgrades_kv = {}
	-- ref to previously loaded generic upgrades data. as a shortcut
	self.generic_upgrades_kv = GenericUpgrades.generic_upgrades_data
	CustomNetTables:SetTableValue("ability_upgrades", "generic_upgrades", self.generic_upgrades_kv)

	self.summon_list = {}
	self.abilities_requires_level_reset = {}
	self.abilities_requires_level_reset["medusa_split_shot"] = true
	self.abilities_requires_level_reset["medusa_mana_shield"] = true
	self.abilities_requires_level_reset["lone_druid_spirit_link"] = true

	-- save sent selection choices and queued selections
	Upgrades.pending_selection = {}
	Upgrades.queued_selection = {}
	Upgrades.favorites_upgrades = {}

	Upgrades.disabled_upgrades_per_player = {}

	Upgrades.lucky_trinket_proc  = {}

	EventStream:Listen("Upgrades:dev:load_upgrades", function(event) Upgrades:LoadUpgradesData(event.hero_name) end)
	EventStream:Listen("Upgrades:dev:request_upgrades", function(event) Upgrades:SendUpgradesData(event.PlayerID) end)
	EventStream:Listen("Upgrades:dev:add_upgrade", function(event) Upgrades:AddToolsUpgrade(event) end)
	EventStream:Listen("Upgrades:dev:add_generic_upgrade", function(event) Upgrades:AddToolsGenericUpgrade(event) end)
	EventStream:Listen("Upgrades:get_debug_localization_check", function(event) Upgrades:SendDebugUpgrades(event.PlayerID) end)

	EventStream:Listen("Upgrades:get_upgrades", Upgrades.SendPendingSelection, Upgrades)
	EventStream:Listen("Upgrades:choose_upgrade", Upgrades.UpgradeSelected, Upgrades)
	EventStream:Listen("Upgrades:reroll", Upgrades.Reroll, Upgrades)
	EventStream:Listen("Upgrades:get_available_upgrades", function(event) Upgrades:SendUpgradesData(event.PlayerID) end)

	EventStream:Listen("Upgrades:get_favorites", Upgrades.SendPendingFavorites, Upgrades)
	EventStream:Listen("Upgrades:set_favorites", Upgrades.SetFavorites, Upgrades)

	EventDriver:Listen("Events:npc_spawned", Upgrades.OnNpcSpawned, Upgrades)
	EventDriver:Listen("Events:modifier_added", Upgrades.OnModifierAdded, Upgrades)
end


function Upgrades:GetPendingUpgradesCount(player_id)
	if not Upgrades.queued_selection or not Upgrades.queued_selection[player_id] then return 0 end

	return #Upgrades.queued_selection[player_id]
end


function Upgrades:SendPendingFavorites(event)
	local player_id = event.PlayerID
	if not IsValidPlayerID(player_id) then return end

	if not Upgrades.favorites_upgrades[player_id] then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	CustomGameEventManager:Send_ServerToPlayer(player, "Upgrades:set_client_favorites", Upgrades.favorites_upgrades[player_id])
end


function Upgrades:SetFavorites(event)
	if not event.favorites_upgrades then return end

	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	Upgrades.favorites_upgrades[player_id] = event.favorites_upgrades
end


function Upgrades:SendDebugUpgrades(player_id)
	if not player_id or not IsInToolsMode() or GetMapName() ~= "ot3_demo" then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	local all_upgrades = {}
	for hero_name,_ in pairs(LoadKeyValues("scripts/npc/npc_heroes.txt")) do
		if string.find(hero_name, "npc_dota_hero_") then
			all_upgrades[hero_name] = LoadKeyValues("scripts/upgrades/heroes/" .. hero_name .. ".txt")
		end
	end

	CustomGameEventManager:Send_ServerToPlayer(player, "Upgrades:send_debug_localization_check", all_upgrades)
end


function Upgrades:SendUpgradesData(player_id)
	--	print("[Upgrades] Sending tools upgrades data to player", player_id)

	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	local hero = PlayerResource:GetSelectedHeroEntity(player_id)
	if not hero or hero:IsNull() then return end
	local hero_name = hero:GetUnitName()

	local abilities_order = {}

	for idx = 0, hero:GetAbilityCount() - 1 do
		local ability = hero:GetAbilityByIndex(idx)

		if ability and not ability:IsNull() and not ability:IsHidden() then
			local ability_name = ability:GetAbilityName()

			if not string.match(ability_name, "special_bonus_") then
				abilities_order[idx] = ability_name
			end
		end
	end

	CustomGameEventManager:Send_ServerToPlayer(player, "Upgrades:dev:upgrades_loaded", {
		upgrades_data = self.upgrades_kv[hero_name],
		generic_upgrades_data = self.generic_upgrades_kv,
		abilities_order = abilities_order
	})
end


function Upgrades:AddToolsUpgrade(event)
	if IsInToolsMode() or GetMapName() == "ot3_demo" then
		local hero = PlayerResource:GetSelectedHeroEntity(event.target_player_id)
		if not hero or not hero:IsRealHero() then return end
		Upgrades:AddAbilityUpgrade(hero, event.ability_name, event.ability_special_name, event.value)
	end
end


function Upgrades:AddToolsGenericUpgrade(event)
	if IsInToolsMode() or GetMapName() == "ot3_demo" then
		local hero = PlayerResource:GetSelectedHeroEntity(event.target_player_id)
		if not hero or not hero:IsRealHero() then return end

		Upgrades:AddGenericUpgrade(hero, event.generic_upgrade_name, event.value)
	end
end


function Upgrades:QueueSelection(hero, rarity)
	if not IsValidEntity(hero) then return end

	local player_id = hero:GetPlayerOwnerID()
	if not IsValidPlayerID(player_id) then return end

	Upgrades.queued_selection[player_id] = Upgrades.queued_selection[player_id] or {}

	table.insert(Upgrades.queued_selection[player_id], {
		rarity = rarity,
		is_lucky_trinket_proc = Upgrades.lucky_trinket_proc[player_id]
	})

	if not Upgrades.pending_selection[player_id] then
		Upgrades:ShowSelection(hero, rarity, player_id)
	else
		local player = PlayerResource:GetPlayer(player_id)
		if IsValidEntity(player) then
			CustomGameEventManager:Send_ServerToPlayer(player, "Upgrades:update_pending_count", {
				upgrades_count = #Upgrades.queued_selection[player_id];
			})
		end
	end

	-- lucky trinket can't proc on itself
	if Upgrades.lucky_trinket_proc[player_id] then return end

	local rarity_name = RARITY_ENUM_TO_TEXT[rarity]
	local lucky_trinket_count = WebInventory:GetItemCount(player_id, "bp_lucky_trinket_" .. rarity_name)

	if lucky_trinket_count and lucky_trinket_count > 0 and RollPercentage(lucky_trinket_count) then
		print("[Upgrades] Lucky Trinket proc!")
		Upgrades.lucky_trinket_proc[player_id] = true
		Upgrades:QueueSelection(hero, rarity)
		Upgrades.lucky_trinket_proc[player_id] = nil
	end
end


function Upgrades:QueueSelectionForTeam(team, rarity)
	for player_id, hero in pairs(GameLoop.heroes_by_team[team] or {}) do
		Upgrades:QueueSelection(hero, rarity)
	end
end


function Upgrades:Reroll(event)
	local player_id = event.PlayerID
	local hero = PlayerResource:GetSelectedHeroEntity(player_id)

	if not hero then return end

	local pending = Upgrades.pending_selection[player_id]
	if not pending then return end

	local price = REROLL_PRICES[pending.upgrade_rarity]

	local reroll_allowed = UpgradeRerolls:ConsumeRerolls(player_id, price)

	if reroll_allowed then
		Upgrades:ShowSelection(hero, pending.upgrade_rarity, player_id, true, pending.is_lucky_trinket_proc)
	end
end


function Upgrades:ShowSelection(hero, rarity, player_id, is_reroll, is_lucky_trinket_proc)
	if GameLoop.game_over then return end

	local pending_selection = Upgrades.pending_selection[player_id]

	local previous_choices = (is_reroll and pending_selection) and pending_selection.previous_choices or {}

	local choices = {}
	local new_previous_choices = {}

	local use_generic_from_subscription = WebSettings:GetSettingValue(player_id, "generic_from_subscription", false)

	-- roll both ability and generic upgrades
	for _, upgrade_type in pairs({UPGRADE_TYPE.ABILITY, UPGRADE_TYPE.GENERIC}) do
		local count_per_selection = UPGRADE_COUNT_PER_SELECTION[upgrade_type]

		-- if generic upgrade from subscription tier is selected, then add it to rolled generics count
		-- subtracting from all other types
		-- this option can only be toggled if player is already subscribed
		if use_generic_from_subscription then
			count_per_selection = upgrade_type == UPGRADE_TYPE.GENERIC and count_per_selection + 1 or count_per_selection - 1
		end

		local rolled_upgrades = Upgrades:RollUpgradesOfType(
			upgrade_type,
			player_id,
			rarity,
			previous_choices[upgrade_type],
			count_per_selection
		)
		new_previous_choices[upgrade_type] = rolled_upgrades
		table.extend(choices, rolled_upgrades)
	end

	local selection_id = DoUniqueString("selection_id")

	Upgrades.pending_selection[player_id] = {
		upgrade_rarity = rarity,
		choices = choices,
		previous_choices = new_previous_choices,
		selection_id = selection_id,
		is_lucky_trinket_proc = is_lucky_trinket_proc,
	}

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	Timers:CreateTimer(0, function()
		CustomGameEventManager:Send_ServerToPlayer(player, "Upgrades:show_upgrades", {
			upgrades = {
				upgrade_rarity = rarity,
				choices = choices,
				reroll = is_reroll,
				selection_id = selection_id,
				is_lucky_trinket_proc = is_lucky_trinket_proc,
			},
			upgrades_count = Upgrades:GetPendingUpgradesCount(player_id),
			favorites_upgrades = Upgrades.favorites_upgrades[player_id] or {}
		})
	end)
end


function Upgrades:RollUpgradesOfType(upgrade_type, player_id, rarity, previous_choices, count)
	local pool = {}

	local hero = GameLoop.hero_by_player_id[player_id]
	if not IsValidEntity(hero) then return end

	local hero_name = hero:GetUnitName()

	if upgrade_type == UPGRADE_TYPE.GENERIC then
		pool = Upgrades.generic_upgrades_kv
	else
		-- turns table of <ability_name>:<list of ability upgrades> into <list of all abilities upgrades>
		pool = table.join(unpack(table.make_value_table(Upgrades.upgrades_kv[hero_name])))
	end

	-- transform previous choices into lookup table for filtering
	local excluded_by_name = {}

	for _, choice in pairs(previous_choices or {}) do
		excluded_by_name[choice.upgrade_name .. "_" .. choice.ability_name] = choice
	end

	local disabled_upgrades = Upgrades.disabled_upgrades_per_player[player_id] or {}

	local hero_attack_capability = hero:GetAttackCapability()
	local is_hero_universal = hero:GetPrimaryAttribute() == DOTA_ATTRIBUTE_ALL

	local upgrades = table.random_some_with_condition(pool, count, function(t, index, upgrade_data)
		local upgrade_name = upgrade_data.upgrade_name

		if previous_choices and excluded_by_name[upgrade_name .. "_" .. upgrade_data.ability_name] then return false end
		-- min rarity for ability upgrades
		if upgrade_data.min_rarity and upgrade_data.min_rarity > rarity then return false end
		-- strict rarity for generics
		if upgrade_data.rarity and upgrade_data.rarity ~= rarity then return false end
		if upgrade_data.disabled and upgrade_data.disabled == 1 then return false end
		if upgrade_data.disabled_for_universal and upgrade_data.disabled_for_universal == 1 and is_hero_universal then return false end
		if disabled_upgrades[upgrade_name] then return false end

		-- melee/ranged-only upgrades
		if upgrade_data.attack_capability and upgrade_data.attack_capability ~= hero_attack_capability then return false end

		local ability_upgrades = hero.upgrades[upgrade_data.ability_name] or {}

		-- in case max count is less than 4 for non-generic upgrades
		if upgrade_data.max_count and not upgrade_data.rarity and upgrade_data.max_count < rarity then return end

		if upgrade_data.max_count and ability_upgrades[upgrade_data.upgrade_name] then
			local current_count = ability_upgrades[upgrade_data.upgrade_name].count

			-- strict rarity is (atm) only defined for generics
			-- and for generics it means that count is applied as-is, without 1/2/4 multiplier of rarity
			if current_count + (rarity / (upgrade_data.rarity or 1)) > upgrade_data.max_count  then return false end
		end

		return true
	end)

	-- pool was exhaused, we need extra upgrades
	-- this could only happen if previous_choices is supplied
	-- (otherwise means critical error due to insufficient overall upgrades count)
	-- which means we can just roll extra from them
	if #upgrades < count and previous_choices then
		print("[Upgrades] POOL WAS EXHAUSED FOR", player_id, upgrade_type, count - #upgrades)
		local extra_upgrades = table.random_some(previous_choices, count - #upgrades)

		table.extend(upgrades, extra_upgrades)
	end

	if upgrade_type == UPGRADE_TYPE.GENERIC then
		for index, upgrade in pairs(upgrades or {}) do
			-- shallowcopy to be able to assign count - otherwise it mutates core pool entry
			-- only copies core keys - nested tables remain as references, since we have no reason or intent to mutate them later in any form
			local new_upgrade = table.shallowcopy(upgrade)
			new_upgrade.count = hero.upgrades.generic and hero.upgrades.generic[upgrade.upgrade_name] and hero.upgrades.generic[upgrade.upgrade_name].count or 0
			upgrades[index] = new_upgrade
		end
	end

	return upgrades
end


function Upgrades:SendPendingSelection(event)
	local player_id = event.PlayerID
	if not player_id then return end
	if not Upgrades.pending_selection[player_id] then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	local pending_selection = Upgrades.pending_selection[player_id]

	CustomGameEventManager:Send_ServerToPlayer(player, "Upgrades:show_upgrades", {
		upgrades = {
			upgrade_rarity = pending_selection.upgrade_rarity,
			choices = pending_selection.choices,
			selection_id = pending_selection.selection_id,
			is_lucky_trinket_proc = pending_selection.is_lucky_trinket_proc,
		},
		upgrades_count = Upgrades:GetPendingUpgradesCount(player_id),
		favorites_upgrades = Upgrades.favorites_upgrades[player_id] or {}
	})
end


function Upgrades:UpgradeSelected(event)
	if GameLoop.game_over then return end

	local player_id = event.PlayerID
	if not player_id then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	-- print("[Upgrades] upgrade selected", event)
	-- DeepPrintTable(event)

	local pending_selection = Upgrades.pending_selection[player_id]
	if not pending_selection then print("no pending upgrades") return end

	local hero = PlayerResource:GetSelectedHeroEntity(player_id)
	local subscription_tier = WebPlayer:GetSubscriptionTier(player_id)
	local rarity = pending_selection.upgrade_rarity

	-- if tournament mode, upgrades selection is forced into t2 state
	if HostOptions:GetOption(HOST_OPTION.TOURNAMENT) then subscription_tier = 2 end

	local index, upgrade_data = table.find_element(pending_selection.choices, function(t, k, v)
		return v.upgrade_name == event.upgrade_name and v.ability_name == event.ability_name
	end)

	if not index or not upgrade_data then print("failed to find selected upgrade") return end

	-- third upgrade is for subscribers only, required tier depends on rarity
	if index == 3 and ((rarity == UPGRADE_RARITY_COMMON and subscription_tier < 1) or (rarity > UPGRADE_RARITY_COMMON and subscription_tier < 2)) then
		DisplayError(player_id, "#dota_hud_error_only_for_subscribers")
		-- show same selection again, since selecting usually hides current
		Timers:CreateTimer(0.2, function()
			CustomGameEventManager:Send_ServerToPlayer(player, "Upgrades:show_upgrades", {
				upgrades = {
					upgrade_rarity = rarity,
					choices = pending_selection.choices,
					reroll = false,
					selection_id = pending_selection.selection_id,
					is_lucky_trinket_proc = pending_selection.is_lucky_trinket_proc,
				},
				upgrades_count = Upgrades:GetPendingUpgradesCount(player_id),
				favorites_upgrades = Upgrades.favorites_upgrades[player_id] or {}
			})
		end)

		return
	end

	if upgrade_data.type == UPGRADE_TYPE.ABILITY then
		Upgrades:AddAbilityUpgrade(
			hero,
			upgrade_data.ability_name,
			upgrade_data.upgrade_name,
			rarity
		)
	else
		Upgrades:AddGenericUpgrade(hero, upgrade_data.upgrade_name, 1)
	end

	EventDriver:Dispatch("Upgrades:upgrade_selected", {
		hero = hero,
		rarity = rarity,
		upgrade_data = upgrade_data,
	})

	Upgrades.pending_selection[player_id] = nil

	-- move on in upgrade selection queue
	table.remove(Upgrades.queued_selection[player_id], 1)

	if #Upgrades.queued_selection[player_id] > 0 then
		local selection_data = Upgrades.queued_selection[player_id][1]
		Upgrades:ShowSelection(hero, selection_data.rarity, player_id, false, selection_data.is_lucky_trinket_proc or false)
	end
end


function Upgrades:LoadUpgradesData(hero_name)
	if self.upgrades_kv[hero_name] then return end

	-- TODO: remove this nonsense
	-- js demo mode sends hero id rather than hero name, need to be converted
	if tonumber(hero_name) then
		hero_name = DOTAGameManager:GetHeroUnitNameByID(tonumber(hero_name))
	end

	self.upgrades_kv[hero_name] = LoadKeyValues("scripts/upgrades/heroes/" .. hero_name .. ".txt")

	-- per-map override
	local kv_override = LoadKeyValues("scripts/upgrades/overrides/" .. GetMapName() ..  "/" .. hero_name .. ".txt")
	print("override:")
	DeepPrintTable(kv_override)
	if kv_override then
		for ability_name, upgrades in pairs(kv_override or {}) do
			for special_name, data in pairs(upgrades) do
				self.upgrades_kv[hero_name][ability_name][special_name] = data
			end
		end
	end
	print("complete:")
	DeepPrintTable(self.upgrades_kv[hero_name])

	for ability_name, upgrades in pairs(self.upgrades_kv[hero_name] or {}) do
		for upgrade_name, upgrade_data in pairs(self.upgrades_kv[hero_name][ability_name]) do
			UpgradesUtilities:ParseUpgrade(upgrade_data, upgrade_name, UPGRADE_TYPE.ABILITY, ability_name)
		end
	end

	CustomNetTables:SetTableValue("ability_upgrades", hero_name, self.upgrades_kv[hero_name] or {})
end


function Upgrades:GetUpgradeValue(hero_name, ability_name, special_value_name)
	return self.upgrades_kv[hero_name][ability_name][special_value_name].value
end


function Upgrades:DisableUpgrade(player_id, ability_name, upgrade_name)
	Upgrades.disabled_upgrades_per_player[player_id] = Upgrades.disabled_upgrades_per_player[player_id] or {}
	Upgrades.disabled_upgrades_per_player[player_id][ability_name] = Upgrades.disabled_upgrades_per_player[player_id][ability_name] or {}

	Upgrades.disabled_upgrades_per_player[player_id][ability_name][upgrade_name] = true
end


function Upgrades:AddOrIncrementUpgrade(hero, ability_name, upgrade_name, value, rarity)
	if type(value) == "table" then
		return Upgrades:AddUpgradeFromTable(hero, ability_name, upgrade_name, value, rarity)
	end

	if not hero.upgrades then hero.upgrades = {} end
	if not hero.upgrades[ability_name] then hero.upgrades[ability_name] = {} end

	local upgrade_data = hero.upgrades[ability_name][upgrade_name]

	if not upgrade_data then
		local upgrade_config = self.upgrades_kv[hero:GetUnitName()][ability_name] and self.upgrades_kv[hero:GetUnitName()][ability_name][upgrade_name] or nil
		-- not copying upgrade kv - but referencing (if definition exists)
		hero.upgrades[ability_name][upgrade_name] = upgrade_config or {
			value = value,
			count = rarity,
		}
		upgrade_data = hero.upgrades[ability_name][upgrade_name]

		-- in this case count indeed mutates original KV
		-- but it is based on the core rule that all heroes are unique
		upgrade_data.count = rarity
	else
		upgrade_data.count = upgrade_data.count + rarity
	end

	Upgrades:RefreshIntrinsicModifierByName(hero, ability_name)

	return upgrade_data
end


function Upgrades:AddUpgradeFromTable(hero, ability_name, upgrade_name, new_upgrade_data, rarity)
	if not hero.upgrades then hero.upgrades = {} end
	if not hero.upgrades[ability_name] then hero.upgrades[ability_name] = {} end

	local upgrade_data = hero.upgrades[ability_name][upgrade_name]

	if upgrade_data then
		upgrade_data.count = upgrade_data.count + rarity
	else
		hero.upgrades[ability_name][upgrade_name] = new_upgrade_data
		upgrade_data = hero.upgrades[ability_name][upgrade_name]
		upgrade_data.count = rarity
	end

	Upgrades:RefreshIntrinsicModifierByName(hero, ability_name)

	return upgrade_data
end


function Upgrades:ApplyLinkedUpgrades(hero, hero_name, ability_name, special_value_name, rarity)
	local upgrade_config = self.upgrades_kv[hero_name][ability_name][special_value_name]
	local linked_special_values = upgrade_config.linked_special_values or {}

	-- applying upgrades from in-ability links
	for linked_name, value in pairs(linked_special_values) do
		-- print("[Upgrades] adding linked upgrade for", linked_name, "with value", value)
		local upgrade_data = Upgrades:AddOrIncrementUpgrade(hero, ability_name, linked_name, value, rarity)

		-- linked upgrades operators default to parent upgrade value
		if not upgrade_data.operator then upgrade_data.operator = UPGRADE_OPERATOR.ADD end
	end

	-- applying upgrades from cross-abilities links
	local linked_abilities = upgrade_config.linked_abilities or {}

	for linked_ability_name, link_config in pairs(linked_abilities) do
		hero.upgrades[linked_ability_name] = hero.upgrades[linked_ability_name] or {}

		for linked_name, value in pairs(link_config) do
			local upgrade_data = Upgrades:AddOrIncrementUpgrade(hero, linked_ability_name, linked_name, value, rarity)

			if not upgrade_data.operator then upgrade_data.operator = UPGRADE_OPERATOR.ADD end
		end
	end
end


function Upgrades:RefreshIntrinsicModifierByName(hero, ability_name)
	Upgrades:RefreshIntrinsicModifier(hero, hero:FindAbilityByName(ability_name))
end


function Upgrades:RefreshIntrinsicModifier(hero, ability)
	if IsValidEntity(ability) and ability:GetLevel() > 0 then
		ability:RefreshIntrinsicModifier()

		if self.abilities_requires_level_reset[ability:GetAbilityName()] then
			ability:SetLevel(ability:GetLevel())
		end
	end
end


function Upgrades:AddAbilityUpgrade(hero, ability_name, special_value_name, rarity)
	local player_id = hero:GetPlayerOwnerID()
	if not player_id then return end

	if not rarity then rarity = UPGRADE_RARITY_COMMON end

	local hero_name = hero:GetUnitName()
	-- print("[Upgrades] adding ability upgrade for", hero_name, ability_name, special_value_name, rarity)

	local base_value = Upgrades:GetUpgradeValue(hero_name, ability_name, special_value_name)

	local upgrade_data = hero.upgrades[ability_name] and hero.upgrades[ability_name][special_value_name]

	-- rarity there is a multiplier effectively, being 1, 2, 4 for common, rare and legendary respectively
	-- instead of pushing several upgrades with table for each, make a counter that is incremented depending on rarity
	-- (making rare count for 2, complying to multiplier)
	-- and record added upgrades as a rarity sequence to display in UIs and whatnot
	if not upgrade_data then
		upgrade_data = Upgrades:AddOrIncrementUpgrade(hero, ability_name, special_value_name, base_value, rarity)
	else
		upgrade_data.count = upgrade_data.count + rarity
	end

	if upgrade_data.max_count and upgrade_data.count >= upgrade_data.max_count then
		Upgrades:DisableUpgrade(player_id, ability_name, special_value_name)
	end

	Upgrades:ApplyLinkedUpgrades(hero, hero_name, ability_name, special_value_name, rarity)

	local controller_modifier = hero:FindModifierByName("modifier_ability_upgrades_controller")

	if not controller_modifier then
		controller_modifier = hero:AddNewModifier(hero, nil, "modifier_ability_upgrades_controller", {})
	end

	controller_modifier:ForceRefresh()

	CustomNetTables:SetTableValue("ability_upgrades", tostring(player_id), hero.upgrades)

	Upgrades:RefreshIntrinsicModifierByName(hero, ability_name)

	Upgrades:ProcessClones(hero, true)

	Upgrades:ProcessRetroactiveSummonUpgrades(hero, ability_name)
end


function Upgrades:SetGenericUpgrade(hero, upgrade_name, count)
	if not count then return end

	local player_id = hero:GetPlayerOwnerID()
	if not player_id then return end

	hero.upgrades.generic = hero.upgrades.generic or {}
	local upgrade_data = hero.upgrades.generic[upgrade_name]

	if not upgrade_data then
		local upgrade_def = GenericUpgrades.generic_upgrades_data[upgrade_name]
		hero.upgrades.generic[upgrade_name] = {
			count = count,
			operator = upgrade_def.operator,
			min_rarity = upgrade_def.rarity,
			max_count = upgrade_def.max_count
		}
		upgrade_data = hero.upgrades.generic[upgrade_name]
	else
		upgrade_data.count = count
	end

	local upgrade_kv = self.generic_upgrades_kv[upgrade_name]
	if not upgrade_kv then return end

	if upgrade_kv.class == "modifier" then
		Upgrades:AddGenericUpgradeModifier(hero, upgrade_name, upgrade_data.count)
	end

	return upgrade_data
end


function Upgrades:AddGenericUpgradeModifier(unit, upgrade_name, upgrade_count)
	local upgrade_definition = self.generic_upgrades_kv[upgrade_name]

	if unit:IsSpiritBear() and (upgrade_definition.ignore_bear and upgrade_definition.ignore_bear == 1) then
		-- print("AddGenericUpgradeModifier discarded", upgrade_name, "for", unit:GetUnitName(), "- can't be applied to bear", upgrade_definition.ignore_bear)
		return
	end

	if unit:IsClone() and (upgrade_definition.ignore_clones and upgrade_definition.ignore_clones == 1) then
		-- print("AddGenericUpgradeModifier discarded", upgrade_name, "for", unit:GetUnitName(), "- can't be applied to clones", upgrade_definition.ignore_clones)
		return
	end

	if (unit:IsIllusion() or unit:IsMonkeyKingSoldier()) and upgrade_definition.ignore_illusions then
		-- print("AddGenericUpgradeModifier discarded", upgrade_name, "for", unit:GetUnitName(), "- can't be applied to illusions")
		return
	end

	local modifier_name = "modifier_" .. upgrade_name .. "_upgrade"

	local modifier = unit:FindModifierByName(modifier_name)

	if not modifier or modifier:IsNull() then
		modifier = unit:AddNewModifier(unit, nil, modifier_name, {duration = -1})
	end

	-- in some cases adding new modifier fails
	-- usually happens when trying to add modifier to dead unit
	-- which is irrelevant in this case since generics are refreshed / reapplied on hero respawn
	if not modifier or modifier:IsNull() then return end

	modifier:SetStackCount(upgrade_count)
	modifier:ForceRefresh()

	if unit.CalculateStatBonus then
		unit:CalculateStatBonus(true)
	end
end


function Upgrades:AddGenericUpgrade(hero, upgrade_name, count)
	if not count then return end

	local player_id = hero:GetPlayerOwnerID()
	if not player_id then return end

	local current_count = hero.upgrades.generic and hero.upgrades.generic[upgrade_name] and hero.upgrades.generic[upgrade_name].count or 0
	local new_count = current_count + count

	local applied_upgrade = Upgrades:SetGenericUpgrade(hero, upgrade_name, new_count)
	if not applied_upgrade then return end

	CustomNetTables:SetTableValue("ability_upgrades", tostring(player_id), hero.upgrades)

	for _, clone in pairs(hero:GetClones()) do
		Upgrades:AddGenericUpgradeModifier(clone, upgrade_name, new_count)
	end

	if applied_upgrade.max_count and applied_upgrade.count >= applied_upgrade.max_count then
		Upgrades:DisableUpgrade(player_id, "generic", upgrade_name)
		print("Disabled", upgrade_name, "from rolling - max count reached", applied_upgrade.count, applied_upgrade.max_count)
	end

	Upgrades:AddGenericToSummons(hero, upgrade_name, new_count)
end


function Upgrades:ProcessClone(clone, hero, skip_generics)
	if not clone or not IsValidEntity(clone) or not clone:IsAlive() then return end
	if not IsValidEntity(hero) then hero = clone:GetCloneSource() end
	if not IsValidEntity(hero) then return end

	if not clone:HasModifier("modifier_bat_handler") then
		clone:AddNewModifier(clone, nil, "modifier_bat_handler", {duration = -1})
	end

	if not clone:HasModifier("modifier_primary_attribute_reader") then
		clone:AddNewModifier(clone, nil, "modifier_primary_attribute_reader", {duration = -1})
	end

	local controller_modifier = clone:FindModifierByName("modifier_ability_upgrades_controller")

	if not controller_modifier then
		controller_modifier = clone:AddNewModifier(clone, nil, "modifier_ability_upgrades_controller", nil)

		for ability_name, _ in pairs(hero.upgrades) do
			Upgrades:RefreshIntrinsicModifierByName(clone, ability_name)
		end
	end

	controller_modifier:ForceRefresh()

	if not hero.upgrades.generic or skip_generics then return end

	for upgrade_name, upgrade_data in pairs(hero.upgrades.generic) do
		if upgrade_data and upgrade_data.count > 0 then
			Upgrades:AddGenericUpgradeModifier(clone, upgrade_name, upgrade_data.count)
		end
	end
end


function Upgrades:ProcessClones(hero, skip_generics)
	local clones = hero:GetClones()

	for _, clone in pairs(clones) do
		Upgrades:ProcessClone(clone, hero, skip_generics)
	end
end


function Upgrades:IterateSummonList(hero, callback)
	for summon_entity_index, summon in pairs(self.summon_list[hero:GetPlayerOwnerID()] or {}) do
		if not IsValidEntity(summon) then
			self.summon_list[summon_entity_index] = nil
		else
			local summon_name = summon:GetUnitName()
			local summon_params = SUMMON_TO_ABILITY_MAP[summon_name]

			ErrorTracking.Try(callback, summon, summon_name, summon_params)
		end
	end
end


function Upgrades:ProcessRetroactiveSummonUpgrades(hero, ability_name)
	Upgrades:IterateSummonList(hero, function(summon, summon_name, summon_params)
		if ability_name == summon_params.ability then
			self:ApplySummonUpgrades(summon, summon_name, hero)
		end
	end)
end


function Upgrades:AddGenericToSummons(hero, upgrade_name, new_count)
	Upgrades:IterateSummonList(hero, function(summon, summon_name, summon_params)
		if summon_params.generic_upgrades then
			Upgrades:AddGenericUpgradeModifier(summon, upgrade_name, new_count)
		end
	end)
end


function Upgrades:ApplySummonUpgrades(summon, summon_name, owner)
	if not summon or not summon_name then return end
	-- some summons have players as owners, instead of heroes (thanks valve)
	if owner:GetClassname() == "dota_player_controller" then
		owner = owner:GetAssignedHero()
	end

	local summon_params = SUMMON_TO_ABILITY_MAP[summon_name]
	if not summon_params then return end

	local ability = owner:FindAbilityByName(summon_params.ability)
	if not ability then return end

	local summon_entity_index = summon:GetEntityIndex()
	local summon_owner_id = owner:GetPlayerOwnerID()

	if summon_params.health then
		local required_health = ability:GetSpecialValueFor(summon_params.health)

		if summon:GetBaseMaxHealth() < required_health then
			-- print("[Upgrades] updating summon health to", required_health, ability:GetLevelSpecialValueNoOverride(summon_params.health, ability:GetLevel() - 1))

			-- bear is now a full hero, which requires special health handling
			if summon_params.health_bonus_as_modifier then
				-- deduct base health value since modifier acts as a bonus (unlike Set solution which overrides)
				local health_pct = summon:GetHealthPercent()

				required_health = required_health - ability:GetLevelSpecialValueNoOverride(summon_params.health, ability:GetLevel() - 1)

				local new_modifier = summon:AddNewModifier(summon, nil, "modifier_summon_bonus_health", {duration = -1})
				if new_modifier and not new_modifier:IsNull() then
					new_modifier:SetStackCount(required_health)
				end
				summon:CalculateGenericBonuses()
				summon:CalculateStatBonus(true)
				summon:SetHealth(summon:GetMaxHealth() * health_pct / 100)
			else
				local base_max_health_old = summon:GetBaseMaxHealth()
				local max_health_old = summon:GetMaxHealth()
				local health_diff = math.max(max_health_old - base_max_health_old, 0)
				local health_pct = summon:GetHealthPercent()

				summon:SetBaseMaxHealth(required_health)
				summon:SetMaxHealth(required_health + health_diff)

				if summon:IsAlive() then
					summon:SetHealth(summon:GetMaxHealth() * health_pct / 100)
				end
			end
		end
	end

	if summon_params.added_health then
		local new_max_health = summon:GetMaxHealth() + ability:GetSpecialValueFor(summon_params.added_health)

		-- print("[Upgrades] updating summon health to", new_max_health)
		local health_pct = summon:GetHealthPercent()

		summon:SetBaseMaxHealth(new_max_health)
		summon:SetMaxHealth(new_max_health)

		if summon:IsAlive() then
			summon:SetHealth(summon:GetMaxHealth() * health_pct / 100)
		end
	end

	if summon_params.damage then
		local required_damage = ability:GetSpecialValueFor(summon_params.damage)
		-- print("[Upgrades] updating summon damage to", required_damage)
		summon:SetBaseDamageMin(required_damage)
		summon:SetBaseDamageMax(required_damage)
	end

	if summon_params.armor then
		local required_armor = ability:GetSpecialValueFor(summon_params.armor)
		-- print("[Upgrades] updating summon armor to", required_armor)
		summon:SetPhysicalArmorBaseValue(required_armor)
	end

	if summon_params.vision_day then
		local vision = ability:GetSpecialValueFor(summon_params.vision_day)
		summon:SetDayTimeVisionRange(vision)
	end

	if summon_params.vision_night then
		local vision = ability:GetSpecialValueFor(summon_params.vision_night)
		summon:SetNightTimeVisionRange(vision)
	end

	if summon_params.retroactive and not (self.summon_list[summon_owner_id] and self.summon_list[summon_owner_id][summon_entity_index]) then
		if not self.summon_list[summon_owner_id] then self.summon_list[summon_owner_id] = {} end
		self.summon_list[summon_owner_id][summon_entity_index] = summon
	end

	if summon_params.ability_upgrades then

		summon:AddNewModifier(owner, nil, "modifier_ability_upgrades_controller", nil)

		-- Update intrinsic modifiers after upgrades added
		for i = 0, DOTA_MAX_ABILITIES - 1 do
			local ability = summon:GetAbilityByIndex(i)
			if ability then
				local intrinsic_modifier_name = ability:GetIntrinsicModifierName()
				local modifier = summon:FindModifierByName(intrinsic_modifier_name)
				if modifier then
					modifier:ForceRefresh()
				end
			end
		end
	end

	if summon_params.generic_upgrades then
		for name, data in pairs(owner.upgrades.generic or {}) do
			if data.count and data.count > 0 then
				Upgrades:AddGenericUpgradeModifier(summon, name, data.count)
			end
		end
	end
end


function Upgrades:OnNpcSpawned(event)
	if not event.owner_player_id then return end

	local hero = GameLoop.hero_by_player_id[event.owner_player_id]

	if event.unit ~= hero then return end

	-- reapply all generic modifiers to hero on respawn, ensuring they exist and have proper counts
	for upgrade_name, upgrade_data in pairs(hero.upgrades.generic or {}) do
		if upgrade_data and upgrade_data.count ~= nil then
			-- Upgrades:SetGenericUpgrade(clone, upgrade_name, upgrade_data.count)
			Upgrades:AddGenericUpgradeModifier(hero, upgrade_name, upgrade_data.count)
		end
	end

	-- do this to clones as well
	Upgrades:ProcessClones(hero)
end


function Upgrades:OnModifierAdded(event)
	local modifier = event.modifier
	if not modifier or modifier:IsNull() then return end

	local modifier_name = modifier:GetName()

	if modifier_name == "modifier_monkey_king_fur_army_soldier_in_position" then
		local parent = modifier:GetParent()
		local caster = modifier:GetCaster()

		Upgrades:ProcessClone(parent, caster, false)
	end

	if modifier_name == "modifier_invoker_ice_wall_slow_aura" or modifier_name == "modifier_invoker_ice_wall_thinker" then
		local parent = modifier:GetParent()
		parent:AddNewModifier(parent, modifier:GetAbility(), "modifier_dummy_caster", {})
	end
end


function Upgrades:GetPlayerUpgrades(player_id)
	local player_upgrades = {}

	local hero = GameLoop.hero_by_player_id[player_id]
	if not IsValidEntity(hero) then return {} end

	local hero_name = hero:GetUnitName()
	local hero_upgrades = Upgrades.upgrades_kv[hero_name] or {}

	for ability_name, upgrades in pairs(hero_upgrades) do
		for upgrade_name, _ in pairs(upgrades) do
			if hero.upgrades and hero.upgrades[ability_name] and hero.upgrades[ability_name][upgrade_name] and hero.upgrades[ability_name][upgrade_name].count > 0 then
				table.insert(player_upgrades, {ability_name, upgrade_name, hero.upgrades[ability_name][upgrade_name].count})
			end
		end
	end

	for upgrade_name, _ in pairs(Upgrades.generic_upgrades_kv or {}) do
		if hero.upgrades and hero.upgrades.generic and hero.upgrades.generic[upgrade_name] and hero.upgrades.generic[upgrade_name].count > 0 then
			table.insert(player_upgrades, {"generic", string.gsub(upgrade_name, "generic_", ""), hero.upgrades.generic[upgrade_name].count})
		end
	end

	return player_upgrades
end


Upgrades:Init()