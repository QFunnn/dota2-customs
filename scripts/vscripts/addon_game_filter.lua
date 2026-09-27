--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local duel_allowed_orders = {
	[DOTA_UNIT_ORDER_CAST_TARGET] = true,
	[DOTA_UNIT_ORDER_CAST_NO_TARGET] = true,
	[DOTA_UNIT_ORDER_CAST_POSITION] = true,
	[DOTA_UNIT_ORDER_CAST_TOGGLE] = true,
}

local pickup_orders = {
	[DOTA_UNIT_ORDER_PICKUP_RUNE] = true,
	[DOTA_UNIT_ORDER_PICKUP_ITEM] = true,
}

local infest_cast_orders = {
	[DOTA_UNIT_ORDER_CAST_POSITION] = true,
	[DOTA_UNIT_ORDER_CAST_NO_TARGET] = true,
	[DOTA_UNIT_ORDER_CAST_TARGET] = true,
}

local infest_redirect_orders = {
	[DOTA_UNIT_ORDER_MOVE_TO_POSITION] = true,
	[DOTA_UNIT_ORDER_ATTACK_MOVE] = true,
	[DOTA_UNIT_ORDER_STOP] = true,
	[DOTA_UNIT_ORDER_HOLD_POSITION] = true,
	[DOTA_UNIT_ORDER_MOVE_TO_TARGET] = true,
	[DOTA_UNIT_ORDER_ATTACK_TARGET] = true,
}

local channel_blocked_orders = {
	[DOTA_UNIT_ORDER_CAST_POSITION] = true,
	[DOTA_UNIT_ORDER_CAST_TARGET] = true,
	[DOTA_UNIT_ORDER_CAST_TARGET_TREE] = true,
	[DOTA_UNIT_ORDER_MOVE_TO_POSITION] = true,
	[DOTA_UNIT_ORDER_MOVE_TO_TARGET] = true,
	[DOTA_UNIT_ORDER_ATTACK_MOVE] = true,
	[DOTA_UNIT_ORDER_ATTACK_TARGET] = true,
	[DOTA_UNIT_ORDER_CAST_NO_TARGET] = true,
	[DOTA_UNIT_ORDER_PICKUP_ITEM] = true,
	[DOTA_UNIT_ORDER_PICKUP_RUNE] = true,
}

local custom_move_orders = {
	[DOTA_UNIT_ORDER_ATTACK_TARGET] = true,
	[DOTA_UNIT_ORDER_MOVE_TO_TARGET] = true,
	[DOTA_UNIT_ORDER_MOVE_TO_POSITION] = true,
	[DOTA_UNIT_ORDER_ATTACK_MOVE] = true,
	[DOTA_UNIT_ORDER_PICKUP_ITEM] = true,
	[DOTA_UNIT_ORDER_PICKUP_RUNE] = true,
	[DOTA_UNIT_ORDER_MOVE_TO_DIRECTION] = true,
}

local ward_break_orders = {
	[DOTA_UNIT_ORDER_MOVE_TO_POSITION] = true,
	[DOTA_UNIT_ORDER_MOVE_TO_TARGET] = true,
	[DOTA_UNIT_ORDER_MOVE_TO_DIRECTION] = true,
	[DOTA_UNIT_ORDER_ATTACK_MOVE] = true,
	[DOTA_UNIT_ORDER_STOP] = true,
	[DOTA_UNIT_ORDER_HOLD_POSITION] = true,
}

function dota1x6:ExecuteOrderFilterCustom(ord)
	local target = nil
	local player = PlayerResource:GetPlayer(ord["issuer_player_id_const"])
	local new_pos = Vector(ord.position_x, ord.position_y, ord.position_z)
	local order = ord.order_type
	local ability = nil
	local unit
	if ord.units and ord.units["0"] then
		unit = EntIndexToHScript(ord.units["0"])
	end

	if order == DOTA_UNIT_ORDER_RADAR then
		return false
	end

	if not unit then
		return true
	end

	if ord.entindex_target and ord.entindex_target ~= 0 then
		target = EntIndexToHScript(ord.entindex_target)
	end

	if ord.entindex_ability and ord.entindex_ability > 0 and order ~= DOTA_UNIT_ORDER_PURCHASE_ITEM then
		ability = EntIndexToHScript(ord.entindex_ability)
	end

	local teleport_mod = unit:FindModifierByName("modifier_teleport_cast")
	if teleport_mod and not teleport_mod.ords[order] then
		teleport_mod:Destroy()
	end

	if
		(order == DOTA_UNIT_ORDER_STOP or order == DOTA_UNIT_ORDER_HOLD_POSITION)
		and unit:HasModifier("modifier_life_stealer_unfettered_custom")
	then
		unit:RemoveModifierByName("modifier_life_stealer_unfettered_custom")
	end

	local duel_mod = unit:FindModifierByName("modifier_legion_commander_duel_custom_buff")
	if duel_mod and not duel_mod.is_enemy and not duel_allowed_orders[order] then
		return false
	end

	if
		order == DOTA_UNIT_ORDER_CAST_TARGET
		and ability
		and ability:IsItem()
		and (ability:GetName() == "item_cyclone_custom" or ability:GetName() == "item_wind_waker_custom")
		and target
	then
		if
			(unit.owner and unit.owner == target and unit:IsTempestDouble())
			or (target.owner and target.owner == unit and target:IsTempestDouble())
		then
			CustomGameEventManager:Send_ServerToPlayer(
				player,
				"CreateIngameErrorMessage",
				{ message = "#cyclone_error" }
			)
			return false
		end
	end

	local infest_mod = unit.infest_mod
	local unit_controlled = unit:HasModifier("modifier_life_stealer_infest_custom_legendary_creep")
		or unit:HasModifier("modifier_enigma_demonic_conversion_custom_legendary_creep")

	if
		unit.infest_creep
		and (order == DOTA_UNIT_ORDER_ATTACK_TARGET or order == DOTA_UNIT_ORDER_MOVE_TO_TARGET)
		and target
		and target == unit.infest_creep
	then
		return false
	end

	if
		(order == DOTA_UNIT_ORDER_ATTACK_TARGET or order == DOTA_UNIT_ORDER_MOVE_TO_TARGET)
		and (unit:IsRealHero() or unit_controlled)
		and target
		and not target:IsNull()
		and target:IsBaseNPC()
		and target:GetUnitName() == "npc_teleport"
	then
		if dota1x6:IsCustomRules("no_teleport") then
			return false
		end

		if
			unit:HasModifier("modifier_mid_teleport_cast")
			or (target:GetTeamNumber() ~= unit:GetTeamNumber() and target:GetName() ~= "edge_teleport_1" and target:GetName() ~= "edge_teleport_2")
			or unit:IsChanneling()
		then
			return false
		end

		if IsValid(infest_mod) and infest_mod.is_legendary ~= 1 then
			return false
		end

		local tower = towers[unit:GetTeamNumber()]

		if tower and tower:HasModifier("modifier_the_hunt_custom_tower") then
			CustomGameEventManager:Send_ServerToPlayer(
				player,
				"CreateIngameErrorMessage",
				{ message = "#midteleport_hunt" }
			)
			return false
		end
		local cast_unit = unit
		if IsValid(infest_mod) and infest_mod.target then
			cast_unit = infest_mod.target
		end

		cast_unit:AddNewModifier(cast_unit, nil, "modifier_teleport_cast", { teleport = target:entindex() })
		return false
	end

	if order == DOTA_UNIT_ORDER_CAST_TARGET and target then
		if target:GetUnitName() == "npc_teleport" then
			return false
		end
	end

	if target and order == DOTA_UNIT_ORDER_ATTACK_TARGET then
		local death_ward_mod = unit:FindModifierByName("modifier_witch_doctor_death_ward_custom")
		if death_ward_mod then
			death_ward_mod:SetTarget(target)
			return false
		end
	end

	if unit.marci_creep and order == DOTA_UNIT_ORDER_MOVE_TO_POSITION then
		local mod = unit:FindModifierByName("modifier_marci_guardian_custom_legendary_tether_wisp")
		if mod then
			mod:Destroy()
		end
	end

	if order == DOTA_UNIT_ORDER_CONSUME_ITEM and ability then
		local witch_doctor_innate = unit:FindModifierByName("modifier_witch_doctor_innate_custom_grisgris")
		if witch_doctor_innate and ability == witch_doctor_innate:GetAbility() then
			witch_doctor_innate:ConsumeGold()
		end
		return true
	end

	if unit_controlled then
		if unit:IsChanneling() and order ~= DOTA_UNIT_ORDER_STOP and order ~= DOTA_UNIT_ORDER_HOLD_POSITION then
			return false
		end

		if pickup_orders[order] and target then
			local order_table = {
				UnitIndex = unit:entindex(),
				OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
				Queue = false,
				Position = target:GetAbsOrigin(),
				TargetIndex = target and target:entindex() or nil,
			}
			ExecuteOrderFromTable(order_table)
			local owner = unit.owner
			if owner then
				local order_table = {
					UnitIndex = owner:entindex(),
					OrderType = order,
					Queue = false,
					Position = target:GetAbsOrigin(),
					TargetIndex = target and target:entindex() or nil,
				}
				ExecuteOrderFromTable(order_table)
			end
			return false
		end
		return true
	end

	if
		IsValid(infest_mod)
		and infest_mod.target
		and infest_mod.is_legendary == 1
		and (
			not infest_mod.target:IsChanneling()
			or order == DOTA_UNIT_ORDER_STOP
			or order == DOTA_UNIT_ORDER_HOLD_POSITION
		)
	then
		if infest_cast_orders[order] and ability then
			if
				(infest_mod.target:IsSilenced() and not ability:IsItem())
				or infest_mod.target:IsHexed()
				or infest_mod.target:IsFeared()
				or (
					(infest_mod.target:IsStunned() or infest_mod.target:GetForceAttackTarget() ~= nil)
					and not dota1x6:ContainsValue(ability:GetBehaviorInt(), DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE)
				)
			then
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"CreateIngameErrorMessage",
					{ message = "#lifestealer_control" }
				)
				return false
			end
		end

		if infest_redirect_orders[order] then
			local order_table = {
				UnitIndex = infest_mod.target:entindex(),
				OrderType = order,
				Queue = false,
				Position = new_pos,
				TargetIndex = target and target:entindex() or nil,
			}
			ExecuteOrderFromTable(order_table)

			ord.units["0"] = nil
			return true
		elseif pickup_orders[order] and target then
			local order_table = {
				UnitIndex = infest_mod.target:entindex(),
				OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
				Queue = false,
				Position = target:GetAbsOrigin(),
				TargetIndex = target and target:entindex() or nil,
			}
			ExecuteOrderFromTable(order_table)
		end
	end

	if unit:HasModifier("modifier_duel_hero_start") then
		return false
	end

	local id = ord["issuer_player_id_const"]

	if order == DOTA_UNIT_ORDER_TRAIN_ABILITY and ability then
		local behavior = ability:GetAbilityKeyValues()
		local can_learn = true
		if behavior and behavior["AbilityBehavior"] then
			can_learn = not string.find(behavior["AbilityBehavior"], "DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE")
		end
		if not can_learn then
			CustomGameEventManager:Send_ServerToPlayer(
				player,
				"CreateIngameErrorMessage",
				{ message = "#ability_not_learnable" }
			)
			return false
		end

		if ability.GetIntrinsicModifierName and ability:GetIntrinsicModifierName() then
			local mod = ability:GetCaster():FindModifierByName(ability:GetIntrinsicModifierName())
			Timers:CreateTimer(0.5, function()
				if IsValid(mod) and mod.OnRefresh then
					mod:OnRefresh({})
				end
			end)
		end
	end

	if unit.order_mods and unit:IsAlive() then
		local data_table = {}
		data_table.target = target
		data_table.pos = new_pos
		data_table.order_type = order
		data_table.ability = ability
		for mod, _ in pairs(unit.order_mods) do
			if mod and not mod:IsNull() and mod.OrderEvent ~= nil then
				local result = mod:OrderEvent(data_table)
				if result and result == 0 then
					return false
				end
			else
				unit.order_mods[mod] = nil
			end
		end
	end

	for _, index in pairs(ord.units) do
		local table_unit = EntIndexToHScript(index)
		if
			table_unit
			and table_unit:IsCourier()
			and (
				(table_unit.player_owner and table_unit.player_owner ~= id)
				or dota1x6.NO_FOW_TEAMS[table_unit:GetTeamNumber()]
			)
		then
			return false
		end
	end

	if
		ability
		and ability:GetName() == "centaur_hoof_stomp_custom"
		and unit:HasModifier("modifier_centaur_hoof_stomp_custom_prepair")
	then
		return false
	end

	if
		channel_blocked_orders[order]
		and (
			unit:HasModifier("modifier_custom_ability_teleport")
			or unit:HasModifier("modifier_patrol_warp_amulet")
			or unit:HasModifier("modifier_tinker_rearm_custom")
		)
	then
		if order ~= DOTA_UNIT_ORDER_CAST_NO_TARGET then
			return false
		end
		if ability and not dota1x6:ContainsValue(ability:GetBehavior(), DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL) then
			return false
		end
	end

	if order == DOTA_UNIT_ORDER_PICKUP_ITEM and target then
		local pickedItem = target:GetContainedItem()
		if not pickedItem then
			return true
		end
		if players[unit:GetId()] == nil then
			return false
		end

		if dota1x6:IsSphere(pickedItem) and players[unit:GetId()]:HasModifier("modifier_end_choise") then
			return false
		end

		if unit:IsCourier() and pickedItem:GetName() == "item_rapier_custom" then
			CustomGameEventManager:Send_ServerToPlayer(
				player,
				"CreateIngameErrorMessage",
				{ message = "#wrong_sphere" }
			)
			return false
		end

		if unit:IsCourier() and pickedItem:GetPurchaser() ~= players[unit:GetId()] then
			CustomGameEventManager:Send_ServerToPlayer(
				player,
				"CreateIngameErrorMessage",
				{ message = "#wrong_sphere" }
			)
			return false
		end

		if
			(pickedItem:GetPurchaser() ~= unit)
			and (pickedItem:GetName() ~= "item_rapier_custom")
			and not unit:IsCourier()
		then
			CustomGameEventManager:Send_ServerToPlayer(
				player,
				"CreateIngameErrorMessage",
				{ message = "#wrong_sphere" }
			)
			return false
		end
	end

	if order == DOTA_UNIT_ORDER_GIVE_ITEM and ability and ability:GetName() == "item_rapier_custom" then
		CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", { message = "#wrong_sphere" })
		return false
	end

	if
		order == DOTA_UNIT_ORDER_DROP_ITEM
		and ability
		and ability:GetName() == "item_rapier_custom"
		and ability.rapier_free
	then
		return false
	end

	if
		order == DOTA_UNIT_ORDER_BUYBACK
		and not unit:IsReincarnating()
		and not unit:IsAlive()
		and unit.no_buyback ~= 1
		and players[unit:GetId()]
	then
		if unit.died_on_duel then
			return false
		end

		unit.no_buyback = 1
		Timers:CreateTimer(0.2, function()
			if IsValid(unit) and players[unit:GetId()] then
				if not unit:IsAlive() then
					unit:RespawnHero(false, false)
				end
				dota1x6:RefreshCooldowns(unit, true)
				dota1x6:ResetOnRespawn(unit)
			end
		end)

		Timers:CreateTimer(1, function()
			if unit and not unit:IsNull() then
				unit:SetBuybackCooldownTime(99999)
			end
		end)
	end

	if order == DOTA_UNIT_ORDER_CAST_TARGET and unit:GetUnitName() == "npc_dota_hero_alchemist" then
		if ability and ability:GetName() == "item_ultimate_scepter" then
			CustomGameEventManager:Send_ServerToPlayer(
				player,
				"CreateIngameErrorMessage",
				{ message = "#alch_scepter" }
			)
			return false
		end
	end

	if
		(order == DOTA_UNIT_ORDER_PURCHASE_ITEM or order == DOTA_UNIT_ORDER_EJECT_ITEM_FROM_STASH)
		and unit:HasModifier("modifier_duel_hero_thinker")
	then
		return false
	end

	if order == DOTA_UNIT_ORDER_CAST_TOGGLE and ability then
		if ability:GetCooldownTimeRemaining() > 0 then
			return false
		end

		if
			ability:GetName() == "custom_pudge_rot"
			and (unit:IsSilenced() or unit:IsStunned() or unit:GetForceAttackTarget() ~= nil)
			and not unit:HasTalent("modifier_pudge_rot_6")
		then
			return false
		end
	end

	if ability then
		if
			ability:GetName() == "terrorblade_demon_zeal_custom"
			and (unit:IsStunned() or unit:GetForceAttackTarget() ~= nil)
			and not unit:HasTalent("modifier_terror_meta_5")
		then
			return false
		end
	end

	if
		order == DOTA_UNIT_ORDER_CAST_TOGGLE_AUTO
		and ability
		and auto_cast_spells[ability:GetName()] ~= nil
		and bit.band(ability:GetBehaviorInt(), DOTA_ABILITY_BEHAVIOR_AUTOCAST) ~= 0
	then
		if not unit:IsAlive() then
			return false
		end

		local data = auto_cast_spells[ability:GetName()]
		local mod = data
		local stop_order = false
		if type(data) == "table" then
			stop_order = data[2]
			mod = data[1]
		end

		if ability.CheckToggle and not ability:CheckToggle() then
			return false
		end

		if ability:GetAutoCastState() == false then
			unit:AddNewModifier(unit, ability, mod, {})
		else
			unit:RemoveModifierByName(mod)
		end
		if stop_order then
			return false
		end
	end

	if custom_move_orders[order] then
		local gyroshell_mod = unit:FindModifierByName("modifier_pangolier_gyroshell_custom")
		if gyroshell_mod then
			gyroshell_mod:OnOrderCustom(new_pos, target)
			return false
		end

		local sail_mod = unit:FindModifierByName("modifier_kunkka_ghostship_custom_legendary_sail")
		if sail_mod then
			sail_mod:OnOrderCustom(new_pos, target)
			return false
		end
	end

	if
		order == DOTA_UNIT_ORDER_ATTACK_TARGET
		and target
		and not target:IsNull()
		and target:IsBaseNPC()
		and unit:IsAlive()
		and unit:IsRealHero()
	then
		local target_name = target:GetUnitName()
		if target_name == "npc_dota_observer_wards" or target_name == "npc_dota_sentry_wards" then
			unit:AddNewModifier(unit, nil, "modifier_ward_attack_range", { ward = target:entindex() })
		elseif ord.queue ~= 1 and IsValid(unit.ward_attack_mod) then
			unit.ward_attack_mod:Destroy()
		end

		if target:IsHero() and not unit:HasModifier("modifier_attacking_hero") then
			unit:AddNewModifier(unit, nil, "modifier_attacking_hero", {})
		end
		if not target:IsHero() and unit:HasModifier("modifier_attacking_hero") then
			unit:RemoveModifierByName("modifier_attacking_hero")
		end
	elseif ward_break_orders[order] and ord.queue ~= 1 and IsValid(unit.ward_attack_mod) then
		unit.ward_attack_mod:Destroy()
	end

	if not ability or not ability.GetBehaviorInt then
		return true
	end
	local behavior = ability:GetBehaviorInt()

	if
		(
			bit.band(behavior, DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING) ~= 0
			or ability:GetAbilityName() == "broodmother_shard_ability_custom"
		)
		and (
			order == DOTA_UNIT_ORDER_CAST_POSITION
			or order == DOTA_UNIT_ORDER_CAST_TARGET
			or order == DOTA_UNIT_ORDER_CAST_TARGET_TREE
			or order == DOTA_UNIT_ORDER_VECTOR_TARGET_POSITION
		)
	then
		if order == DOTA_UNIT_ORDER_VECTOR_TARGET_POSITION then
			ability.vectorTargetPosition2 = Vector(ord.position_x, ord.position_y, 0)
			ability.vectorTargetPosition = ability.vectorTargetPosition2
			if IsValid(target) then
				ability.vectorTargetPosition = target:GetAbsOrigin()
				ability.vectorTargetPosition.z = 0
			end
			return true
		end

		if order == DOTA_UNIT_ORDER_CAST_POSITION then
			ability.vectorTargetPosition = Vector(ord.position_x, ord.position_y, 0)
		end

		local position_start = ability.vectorTargetPosition or unit:GetAbsOrigin()
		local position_end = ability.vectorTargetPosition2 or position_start
		local vec = position_end - position_start
		vec.z = 0

		if vec:Length2D() < 1 then
			vec = position_start - unit:GetAbsOrigin()
			vec.z = 0
		end

		if vec:Length2D() < 1 then
			vec = unit:GetForwardVector()
			vec.z = 0
		end

		local direction = vec:Normalized()
		ability.vectorTargetDirection = direction

		local function OverrideSpellStart(self, position, direction)
			self:OnVectorCastStart(position_start, direction)
		end
		ability.OnSpellStart = function(self)
			return OverrideSpellStart(self, position_start, direction)
		end
	end

	return true
end

function dota1x6:OnRuneActivated(params)
	local id = params.PlayerID

	if not players[id] then
		return
	end
	if params.rune ~= DOTA_RUNE_BOUNTY then
		return
	end

	local unit = players[id]
	local team = unit:GetTeamNumber()
	local net_k = bounty_net_min
	local teams_net = dota1x6:GetTeamsNet()
	local bonus = 1

	if #teams_net > 1 then
		table.sort(teams_net, function(x, y)
			return y.gold < x.gold
		end)
	end

	for index, data in pairs(teams_net) do
		if data.team == team then
			net_k = bounty_net_min + (bounty_net_max - bounty_net_min) * ((index - 1) / (max_teams - 1))
		end
	end

	local heroes = dota1x6:FindPlayers(team, false, true)
	local white = 0
	local tower = towers[team]
	if tower then
		white = bounty_white_init + tower.bounty_runes * bounty_white_rune
		tower.bounty_runes = tower.bounty_runes + 1
	end

	start_quest:CheckQuest({ id = id, quest_name = "Quest_8" })

	players[id].bounty_runes_picked = players[id].bounty_runes_picked + 1

	if unit:GetQuest() == "General.Quest_6" then
		unit:UpdateQuest(1)
	end

	if unit:HasModifier("modifier_templar_assassin_innate_custom") then
		local mod = unit:FindModifierByName("modifier_templar_assassin_innate_custom")
		mod:UseSmoke()
	end

	local bottle = unit:FindItemInInventory("item_bottle_custom")
	if bottle then
		unit:AddNewModifier(unit, bottle, "modifier_item_bottle_custom_rune", {})
	end

	if IsValid(unit.xmark_ability) and IsValid(unit.xmark_ability.tracker) then
		unit.xmark_ability.tracker:ShopGold(nil, 2)
	end

	if unit:HasAbility("alchemist_goblins_greed_custom") then
		unit:AddNewModifier(unit, nil, "modifier_alchemist_goblins_greed_custom_runes", {})
	end

	if unit:HasAbility("arc_warden_innate_custom") then
		unit:AddNewModifier(
			unit,
			unit:FindAbilityByName("arc_warden_innate_custom"),
			"modifier_arc_warden_ancients_ally_custom_runes",
			{}
		)
	end

	local minute = math.floor(GameRules:GetDOTATime(false, false) / 60)
	local gold = ((bounty_gold_init + minute * bounty_gold_per_minute) / #heroes) * net_k
	local exp = ((bounty_exp_init + minute * bounty_exp_per_minute) / #heroes) * net_k

	local names = {}
	for _, hero in pairs(heroes) do
		table.insert(names, hero:GetUnitName())
	end

	for _, hero in pairs(heroes) do
		CustomGameEventManager:Send_ServerToPlayer(
			PlayerResource:GetPlayer(hero:GetId()),
			"mini_alert_event",
			{ heroes = names, net_k = math.floor(net_k * 100), event_type = "bounty" }
		)

		local gold_k = 1
		local white_k = 1
		local exp_k = 1

		if hero:HasModifier("modifier_templar_assassin_innate_custom") then
			local mod = hero:FindModifierByName("modifier_templar_assassin_innate_custom")
			if mod then
				white_k = white_k + (mod.bonus - 1)
				exp_k = exp_k + (mod.bonus - 1)
				gold_k = gold_k + (mod.bonus - 1)
			end
		end

		if hero:HasModifier("modifier_alchemist_goblins_greed_custom") then
			local ability = hero:FindAbilityByName("alchemist_goblins_greed_custom")
			gold_k = gold_k + (ability:GetSpecialValueFor("bounty_multiplier") - 1)
		end

		local travel_mod = (
			hero:FindModifierByName("modifier_item_travel_boots_custom")
			or hero:FindModifierByName("modifier_item_travel_boots_2_custom")
		) or hero:FindModifierByName("modifier_item_travel_boots_2_perma")
		if travel_mod and travel_mod.bounty_bonus then
			white_k = white_k + travel_mod.bounty_bonus
			exp_k = exp_k + travel_mod.bounty_bonus
			gold_k = gold_k + travel_mod.bounty_bonus
		end

		hero:AddExperience(exp * exp_k, 5, false, false)

		if dota1x6:IsCustomRules("bounty_orb") then
			dota1x6:CreateUpgradeOrb(hero, 1)
		end
		hero:AddPoints("white", white * white_k, "bounty_rune")
		hero:GiveGold(gold * gold_k, nil, true, "bounty_rune")
		hero:SendNumber(0, gold * gold_k)
	end

	local mod = unit:FindModifierByName("modifier_voice_module")
	if mod then
		mod:BountyEvent()
	end
end

function dota1x6:BountyRunePickupFilter(params)
	CustomGameEventManager:Send_ServerToAllClients("delete_bounty", {})
	params["gold_bounty"] = 0
	dota1x6:StartBountyWatch()
	return true
end

function dota1x6:OnItemPickUp(event)
	local item = EntIndexToHScript(event.ItemEntityIndex)

	local owner
	if event.HeroEntityIndex then
		owner = EntIndexToHScript(event.HeroEntityIndex)
	elseif event.UnitEntityIndex then
		owner = EntIndexToHScript(event.UnitEntityIndex)
	end

	if not owner:IsRealHero() then
		return
	end
	local id = owner:GetId()

	if event.itemname == "item_aegis" then
		UTIL_Remove(item)
		owner:AddNewModifier(owner, nil, "modifier_aegis_custom", { duration = 300 })
	end

	local hero = players[id]

	if not hero:HasModifier("modifier_end_choise") then
		local after_legen = false
		if item.after_legen == true then
			after_legen = true
		end

		if event.itemname == "item_gray_upgrade" then
			upgrade:init_upgrade(owner, 1, nil, after_legen)
			UTIL_Remove(item)
		end

		if event.itemname == "item_blue_upgrade" then
			upgrade:init_upgrade(owner, 2, nil, after_legen)
			UTIL_Remove(item)
		end
		if event.itemname == "item_purple_upgrade" then
			upgrade:init_upgrade(owner, 3, nil, after_legen)
			UTIL_Remove(item)
		end
		if event.itemname == "item_purple_upgrade_shop" then
			upgrade:init_upgrade(owner, 3, nil, true)
			UTIL_Remove(item)
		end
		if event.itemname == "item_legendary_upgrade" then
			upgrade:init_upgrade(owner, 4, nil, after_legen)
			UTIL_Remove(item)
		end

		if event.itemname == "item_alchemist_recipe" then
			upgrade:init_upgrade(owner, 13, nil, nil)
			UTIL_Remove(item)
		end
	end
end

function dota1x6:OnGlyphUsed(params)
	local team = params.teamnumber
	GameRules:SetGlyphCooldown(team, glyph_cd)

	local heroes = dota1x6:FindPlayers(team, true)
	CustomGameEventManager:Send_ServerToAllClients("glyph_used", { heroes = heroes })

	local towers = FindUnitsInRadius(
		team,
		Vector(0, 0, 0),
		nil,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		0,
		false
	)
	for _, tower in pairs(towers) do
		if tower:FindModifierByName("modifier_fountain_glyph") then
			tower:FindModifierByName("modifier_fountain_glyph"):SetDuration(glyph_duration, true)
		end
	end
end

function dota1x6:ExpFilter(params)
	if params.reason_const == DOTA_ModifyXP_HeroKill then
		return false
	end
	return true
end

function dota1x6:CountKill()
	dota1x6.KillCount = dota1x6.KillCount + 1
end

function dota1x6:OnPlayerLevelUp(data)
	local hero = EntIndexToHScript(data.hero_entindex)

	if hero then
		local mod = hero:FindModifierByName("modifier_voice_module")
		if mod then
			mod:LevelEvent()
		end
	end
end

function dota1x6:OnEntityKilled(param)
	if param.entindex_attacker == nil then
		return
	end

	local hero = EntIndexToHScript(param.entindex_attacker)
	local unit = EntIndexToHScript(param.entindex_killed)

	if unit:IsTempestDouble() then
		return
	end

	local hero_id = hero:GetId()
	local unit_id = unit:GetId()
	local hero_player = players[hero_id]
	local unit_player = players[unit_id]
	local max_dist = 1200

	if hero_player and unit:IsValidKill(hero) then
		hero_player:GiveKillExp(unit)
	end

	if
		hero_player
		and (unit:GetTeamNumber() == DOTA_TEAM_NEUTRALS or unit:GetTeamNumber() == DOTA_TEAM_CUSTOM_5)
		and unit:GetMaximumGoldBounty() > 0
	then
		local gold = unit:GetMaximumGoldBounty()
		local source = "lane"
		if unit:GetTeamNumber() == DOTA_TEAM_NEUTRALS then
			source = unit:IsAncient() and "ancient" or "neutral"
		end

		local total = gold
		hero_player:GiveGold(gold, nil, true, source)

		if unit:GetTeamNumber() == DOTA_TEAM_NEUTRALS and (hero == hero_player or hero.owner == hero_player) then
			local patrol_mod = hero_player:FindModifierByName("modifier_patrol_reward_1_gold")
			if patrol_mod then
				local bonus = math.max(1, gold * patrol_mod.gold)
				total = total + bonus
				hero_player:GiveGold(bonus, nil, true, "modifier_patrol_reward_gold")
			end

			local bfury_mod = hero_player:FindModifierByName("modifier_item_bfury_custom")
			if bfury_mod then
				local bonus = math.max(1, gold * bfury_mod.gold_bonus)
				total = total + bonus
				hero_player:GiveGold(bonus, nil, true, bfury_mod:GetAbility())
			end
		end

		hero_player:SendNumber(0, total)
	end

	if
		hero_player
		and unit:GetUnitName() == "npc_dota_observer_wards"
		and unit:GetTeamNumber() ~= hero_player:GetTeamNumber()
	then
		hero_player:GiveGold(ward_gold, nil, true, "ward")
		hero_player:SendNumber(0, ward_gold)
	end

	local no_purple_for_hero = false

	if hero.owner ~= nil then
		hero = hero.owner
	end

	if (hero:GetQuest() ~= nil) and hero:GetUnitName() ~= unit:GetUnitName() then
		if
			(hero:GetQuest() == "General.Quest_1")
			and unit:GetTeamNumber() == DOTA_TEAM_NEUTRALS
			and not unit:IsPatrolCreep()
		then
			hero:UpdateQuest(1)
		end

		if (hero:GetQuest() == "General.Quest_2") and unit:IsPatrolCreep() then
			hero:UpdateQuest(1)
		end

		if
			(hero:GetQuest() == "General.Quest_17")
			and unit:GetTeamNumber() == DOTA_TEAM_NEUTRALS
			and unit:IsAncient()
		then
			hero:UpdateQuest(1)
		end

		if
			(hero:GetQuest() == "General.Quest_3")
			and unit:GetTeamNumber() ~= hero:GetTeamNumber()
			and (unit:GetUnitName() == "npc_dota_observer_wards" or unit:GetUnitName() == "npc_dota_sentry_wards")
		then
			hero:UpdateQuest(1)
		end

		if (hero:GetQuest() == "General.Quest_4") and unit:IsRealHero() and not unit:IsReincarnating() then
			hero:UpdateQuest(1)
		end

		if
			(hero:GetQuest() == "Mars.Quest_8")
			and unit:IsRealHero()
			and not unit:IsReincarnating()
			and unit:HasModifier("modifier_mars_arena_of_blood_custom_projectile_aura")
		then
			hero:UpdateQuest(1)
		end

		if
			(hero:GetQuest() == "Never.Quest_6" or hero:GetQuest() == "Blood.Quest_7")
			and unit:IsRealHero()
			and not unit:IsReincarnating()
		then
			if hero.quest.extra_data == nil then
				hero.quest.extra_data = {}
			end

			if not hero.quest.extra_data[unit:GetUnitName()] then
				hero.quest.extra_data[unit:GetUnitName()] = true
				hero:UpdateQuest(1)
			end
		end

		if
			(hero:GetQuest() == "Terr.Quest_6")
			and EntIndexToHScript(param.entindex_attacker):IsIllusion()
			and unit:GetTeamNumber() == DOTA_TEAM_NEUTRALS
			and not unit:IsPatrolCreep()
		then
			hero:UpdateQuest(1)
		end

		if
			(hero:GetQuest() == "General.Quest_16")
			and unit:IsRealHero()
			and hero:HasModifier("modifier_item_custom_smoke_quest_kill")
		then
			hero:UpdateQuest(1)
		end
	end

	if unit:IsRealHero() and not unit:IsCreepHero() and unit:IsReincarnating() == false then
		if hero and hero_player then
			hero_player.kills_done = hero_player.kills_done + 1
		end

		dota1x6:KillGold(unit, hero)

		if not unit.died_on_duel then
			if unit_player then
				if
					hero_player
					and hero ~= unit
					and hero:IsHero()
					and unit:HasModifier("modifier_player_main_custom")
				then
					local target_array = unit_player
					local killer_array = hero_player
					local mod = unit:FindModifierByName("modifier_player_main_custom")
					if mod then
						if mod:GetStackCount() >= Player_damage_max then
							no_purple_for_hero = true
						end
						if mod:GetStackCount() < Player_damage_max then
							mod:IncrementStackCount()
						end
					end

					mod = hero:FindModifierByName("modifier_player_main_custom")
					if mod then
						mod:SetStackCount(0)
					end
				end

				local target = unit:FindModifierByName("modifier_the_hunt_custom_hero")
				local respawn_mod = unit:FindModifierByName("modifier_patrol_reward_2_respawn")

				local tower = towers[unit:GetTeamNumber()]

				local killed_by_hero = false
				if hero:IsRealHero() or (hero.owner ~= nil and hero:GetTeamNumber() ~= DOTA_TEAM_CUSTOM_5) then
					killed_by_hero = true
				end

				local new_respawn = StartDeathTimer + dota1x6.current_wave * DeathTimer_PerWave
				local ids = dota1x6:FindPlayers(unit:GetTeamNumber())
				if ids and #ids == 2 then
					new_respawn = new_respawn * (1 + DeathTimerDuo)
				end

				local respawn_k = 1

				if tower and tower:HasModifier("modifier_tower_armor_aura") then
					respawn_k = respawn_k - tower:FindModifierByName("modifier_tower_armor_aura").respawn
				end

				respawn_k = math.max(0, respawn_k)
				new_respawn = new_respawn * respawn_k

				if killed_by_hero and target then
					new_respawn = Short_Respawn_target
					target:Destroy()
				end

				if respawn_mod and respawn_mod.respawn_time then
					new_respawn = respawn_mod.respawn_time
					respawn_mod:Proc()
				end
				unit:SetTimeUntilRespawn(new_respawn)

				if unit.is_bot then
					unit:SetTimeUntilRespawn(5)
				end

				unit_player.death = unit_player.death + 1
			else
				unit:SetTimeUntilRespawn(5)
			end
		end

		local tower = towers[unit:GetTeamNumber()]
		local hunt = tower and tower:FindModifierByName("modifier_the_hunt_custom_tower")

		if hunt then
			hunt:TargetKilled(unit, hero)
		end
	end

	if not hero:IsHero() and not hero:IsBuilding() then
		return
	end

	local drop = true

	if (unit:GetTeam() == DOTA_TEAM_CUSTOM_5) and unit.ally and not unit.is_necro_creep and not unit.is_test_creep then
		local count_mob = 0

		for i = 1, #unit.ally do
			if not unit.ally[i]:IsNull() and unit.ally[i] ~= unit then
				if unit.ally[i]:IsAlive() then
					drop = false
					count_mob = count_mob + 1
				end
			end

			if unit.ally[i].dropped then
				drop = false
				break
			end
		end

		if drop == true then
			unit.dropped = true
		end

		if unit.host_team then
			local ids = dota1x6:FindPlayers(unit.host_team)
			if ids then
				for _, id in pairs(ids) do
					local player = players[id]
					if player then
						local distance = (player:GetAbsOrigin() - hero:GetAbsOrigin()):Length2D()

						if not hero:IsBuilding() and hero ~= player and distance <= max_dist and player:IsAlive() then
							local gold = unit:GetMaximumGoldBounty()
							player:GiveGold(gold, nil, true, "lane")
							player:SendNumber(0, gold)
						end

						local reward = dota1x6:GetReward(unit.current_wave_number, player)

						if dota1x6:FinalDuel() == false then
							player.ActiveWave = {
								units = count_mob,
								units_max = unit.max,
								name = dota1x6:GetWave(unit.wave_number, unit.isboss),
								skills = dota1x6:GetSkills(unit.wave_number, unit.isboss),
								mkb = dota1x6:GetMkb(unit.wave_number, unit.isboss),
								reward = reward,
								gold = unit.more_gold,
								show_gold = unit.show_gold,
								number = dota1x6.current_wave,
							}
						end
						if drop then
							if unit.lownet == 1 then
								dota1x6:InitLowNet(player)
							end
							player.ActiveWave = nil

							local get_drop = false

							if hero == player then
								get_drop = true
							else
								if reward == 4 or reward == 3 then
									get_drop = true
								end

								if reward == 1 and player:IsAlive() and distance <= max_dist then
									get_drop = true
								end
							end

							if get_drop and not DontUpgradeCreeps then
								dota1x6:CreateUpgradeOrb(player, reward)
								if reward == 4 and pro_mod and pro_mod_data.double_legendary then
									dota1x6:CreateUpgradeOrb(player, reward)
								end
							end
						end
					end
				end
			end
		end
	end

	if
		(unit:GetTeam() == DOTA_TEAM_NEUTRALS or unit:IsBuilding())
		and hero_player
		and not hero:HasModifier("modifier_duel_hero_thinker")
		and not hero.no_blue
		and (CreepsStats[unit:GetUnitName()] or Shared_Bounty[unit:GetUnitName()])
	then
		local points
		if CreepsStats[unit:GetUnitName()] then
			points = CreepsStats[unit:GetUnitName()].blue
			hero:AddPoints("blue", points, unit:IsAncient() and "ancient" or "neutral", true)
		end
		if Shared_Bounty[unit:GetUnitName()] then
			points = Shared_Bounty[unit:GetUnitName()].blue
			local gold = Shared_Bounty[unit:GetUnitName()].gold
			local source = unit:IsBuilding() and "shrine" or "patrol"

			local ids = dota1x6:FindPlayers(hero:GetTeamNumber())
			if ids and gold then
				points = points * (unit.patrol_blue or 1) / #ids
				gold = gold * (unit.patrol_gold or 1) / #ids
				for _, id in pairs(ids) do
					local player = players[id]
					if player then
						player:AddPoints("blue", points, source, true)
						player:GiveGold(gold, nil, true, source)
						player:SendNumber(0, gold)
					end
				end
			end
		end
	end

	dota1x6:KillPurple(unit, hero, no_purple_for_hero)
end

function dota1x6:KillGoldTeam(net_victim, net_team, count, k)
	local gold = kill_net_gold
	local diff = net_victim - net_team

	if diff > 0 then
		gold = gold + math.floor((diff * k) / count)
	end

	return gold
end

function dota1x6:KillGold(unit, hero)
	if hero and hero:GetTeamNumber() == unit:GetTeamNumber() then
		return
	end

	local unit_player = players[unit:GetId()]
	local hunt = unit:HasModifier("modifier_the_hunt_custom_hero") and hero ~= nil and players[hero:GetId()] ~= nil
	local k = hunt and Target_k or Streak_k

	local net_teams = {}
	local near_teams = {}
	local killer_team = hero and hero:GetTeamNumber()

	if killer_team then
		near_teams[killer_team] = true
	end

	for id, player in pairs(players) do
		local team = player:GetTeamNumber()
		net_teams[team] = (net_teams[team] or 0) + player.networth

		if hunt or (player:GetAbsOrigin() - unit:GetAbsOrigin()):Length2D() <= more_gold_radius then
			near_teams[team] = true
		end
	end

	near_teams[unit:GetTeamNumber()] = nil

	local gold_teams = {}

	for id, player in pairs(players) do
		local team = player:GetTeamNumber()

		if near_teams[team] then
			gold_teams[team] = gold_teams[team] or {}
			gold_teams[team][#gold_teams[team] + 1] = player
		end
	end

	local team_gold = {}

	for team, list in pairs(gold_teams) do
		local gold = dota1x6:KillGoldTeam(net_teams[unit:GetTeamNumber()] or 0, net_teams[team] or 0, #list, k)

		for _, player in pairs(list) do
			local total = gold

			if player == hero then
				total = total + kill_gold_base + kill_gold_level * unit:GetLevel()
			end

			team_gold[team] = (team_gold[team] or 0) + total

			player:GiveGold(total, nil, true, "hero_kill")
			player:SendNumber(0, total)
		end
	end

	local team_ids = {}
	local team_heroes = {}
	local team_colors = {}

	if killer_team and gold_teams[killer_team] then
		for _, player in pairs(gold_teams[killer_team]) do
			local index = player == hero and 1 or #team_ids + 1
			table.insert(team_ids, index, player:GetPlayerOwnerID())
			table.insert(team_heroes, index, player:GetUnitName())
			table.insert(team_colors, index, player.team_color)
		end
	end

	local other_teams = {}

	for team, _ in pairs(gold_teams) do
		if team ~= killer_team then
			table.insert(other_teams, team)
		end
	end

	table.sort(other_teams)

	local other_ids = {}
	local other_heroes = {}
	local other_gold = {}

	for _, team in pairs(other_teams) do
		local ids = {}
		local heroes = {}

		for _, player in pairs(gold_teams[team]) do
			table.insert(ids, player:GetPlayerOwnerID())
			table.insert(heroes, player:GetUnitName())
		end

		table.insert(other_ids, table.concat(ids, ","))
		table.insert(other_heroes, table.concat(heroes, ","))
		table.insert(other_gold, team_gold[team])
	end

	CustomGameEventManager:Send_ServerToAllClients("kill_feed_gold", {
		team_ids = table.concat(team_ids, ","),
		team_heroes = table.concat(team_heroes, ","),
		team_colors = table.concat(team_colors, ","),
		victim = unit:GetPlayerOwnerID(),
		victim_hero = unit:GetUnitName(),
		victim_color = unit_player and unit_player.team_color or "#ffffff",
		gold = killer_team and team_gold[killer_team] or 0,
		other_ids = table.concat(other_ids, ";"),
		other_heroes = table.concat(other_heroes, ";"),
		other_gold = table.concat(other_gold, ";"),
	})
end

function dota1x6:KillPurple(unit, hero, no_purple)
	if not unit:IsRealHero() or unit:IsCreepHero() or not players[unit:GetId()] or unit:IsReincarnating() then
		return
	end
	if no_purple and not test then
		return
	end
	if hero:GetTeamNumber() == unit:GetTeamNumber() then
		return
	end
	if dota1x6:FinalDuel() and duel_data[#duel_data].rounds ~= 0 then
		return
	end

	local more_heroes = dota1x6:FindPlayers(hero:GetTeamNumber(), false, true)
	local near_heroes = {}

	for _, ally in pairs(more_heroes) do
		if (ally:GetAbsOrigin() - unit:GetAbsOrigin()):Length2D() <= kill_purple_radius or ally == hero then
			near_heroes[#near_heroes + 1] = ally
		end
	end

	local reward_for = nil
	if #near_heroes == 1 then
		reward_for = near_heroes[1]
	elseif #near_heroes == 2 then
		local tower = towers[hero:GetTeamNumber()]
		for _, near_hero in pairs(near_heroes) do
			if near_hero ~= tower.last_reward_for then
				tower.last_reward_for = near_hero
				reward_for = near_hero
				near_hero:GenericParticle("particles/ui/purple_orb_point.vpcf")
				break
			end
		end
	end

	if reward_for then
		reward_for:AddPoints("purple", 1)
	end
end

function dota1x6:ReconnectFilter(pid)
	local player = PlayerResource:GetPlayer(pid)
	local team = PlayerResource:GetTeam(pid)
	local hero = GlobalHeroes[pid]
	local player_table = players[pid]

	if player == nil then
		return
	end
	if hero == nil then
		return
	end
	if player_table == nil then
		return
	end

	CustomGameEventManager:Send_ServerToPlayer(player, "pick_end", {})

	Timers:CreateTimer(FrameTime(), function()
		wearables_system:UpdateClientData()
	end)

	Timers:CreateTimer(3, function()
		for _, player_unit in pairs(players) do
			FireGameEvent("event_init_unit", {
				hero_name = player_unit:GetUnitName(),
			})
			wearables_system:UpdateFullParticleForPlayer(player_unit:GetPlayerOwnerID(), player_unit, pid)
			if player_unit.current_emblem then
				if
					player_unit.current_emblem
					and _G.EmblemsListPFX
					and _G.EmblemsListPFX[player_unit.current_emblem]
				then
					if not player_unit.reconnects_emblems then
						player_unit.reconnects_emblems = {}
					end
					table.insert(
						player_unit.reconnects_emblems,
						ParticleManager:CreateParticleForPlayer(
							_G.EmblemsListPFX[player_unit.current_emblem],
							PATTACH_ABSORIGIN_FOLLOW,
							player_unit,
							player
						)
					)
				end
			end
		end
	end)

	for _, player in pairs(players) do
		FireGameEvent("save_talents", {
			hero_name = player:GetUnitName(),
		})
	end

	Timers:CreateTimer(1.5, function()
		CustomGameEventManager:Send_ServerToPlayer(
			player,
			"init_chat",
			{ tools = IsInToolsMode(), cheat = GameRules:IsCheatMode(), valid = HTTP.IsValidGame(PlayerCount) }
		)

		for _, player in pairs(players) do
			FireGameEvent("save_abilities", {
				ent_index = player:entindex(),
			})
		end

		hero:UpdateQuest(0)

		local tempest_ability = hero:FindAbilityByName("arc_warden_tempest_double_custom")
		if tempest_ability then
			tempest_ability:ReconnectProc()
		end

		dota1x6:GiveVisionForAll(2, hero:GetTeamNumber())

		Timers:CreateTimer(1, function()
			hero:UpdateTalentsClient()
		end)

		if sale_alert and not test then
			CustomGameEventManager:Send_ServerToPlayer(player, "show_sale_alert", {})
		end

		CustomGameEventManager:Send_ServerToPlayer(player, "set_test_mode", { state = _G.TestMode })
		CustomGameEventManager:Send_ServerToAllClients("lua_wtf_mode", { wtf = _G.WtfMode })
		CustomGameEventManager:Send_ServerToAllClients("lua_timer_stop", { stop = _G.TimerStop })

		CustomGameEventManager:Send_ServerToPlayer(player, "init_hero_level", {})
		CustomGameEventManager:Send_ServerToPlayer(player, "end_loading", {})
		CustomGameEventManager:Send_ServerToPlayer(player, "PreGameEnd_top", {})

		CustomGameEventManager:Send_ServerToPlayer(
			player,
			"init_damage_table",
			{ subscribed = player_table.subscribed }
		)
		CustomGameEventManager:Send_ServerToPlayer(player, "reconnect_hero_image", {})

		for target_pid, player_unit in pairs(players) do
			if player_unit and player_unit.pet and IsValid(player_unit.pet) then
				CustomGameEventManager:Send_ServerToAllClients(
					"event_update_pets_index",
					{ index = player_unit.pet:GetEntityIndex() }
				)
			end
		end

		if hero:HasAbility("invoker_invoke_custom") then
			CustomGameEventManager:Send_ServerToPlayer(player, "initInvokerPanel", {})
			if hero:HasTalent("modifier_invoker_invoke_7") then
				CustomGameEventManager:Send_ServerToPlayer(
					PlayerResource:GetPlayer(hero:GetPlayerOwnerID()),
					"invoker_hide_neutral",
					{}
				)
			end
		end

		if player_table.goodwin_quest and (test or pro_mod) and false then
			CustomGameEventManager:Send_ServerToPlayer(
				player,
				"goodwin_quest_icon",
				{ id = player_table.goodwin_quest }
			)
		end

		CustomGameEventManager:Send_ServerToPlayer(player, "init_custom_item_build", {})

		player_table:UpdateVisualPoints()

		if player_table:HasModifier("modifier_end_choise") then
			CustomGameEventManager:Send_ServerToPlayer(player, "show_choise", {
				choise = player_table.choise_table.content,
				mods = player_table.choise_table.mod_stacks,
				alert = player_table.choise_table.alert,
				refresh = player_table.choise_table.refresh,
				rarity = player_table.choise_table.rarity,
				is_reward = player_table.choise_table.is_reward,
			})
		end
	end)
end

function dota1x6:ItemPurchased(data)
	local player = players[data.PlayerID]
	if not player then
		return
	end
	if data.itemname ~= "item_purple_upgrade_shop" then
		return
	end
	if player.got_purple then
		for i = 0, 20 do
			local item = player:GetItemInSlot(i)
			local stop = false
			if item and item:GetName() == data.itemname then
				UTIL_Remove(item)
				player:ModifyGoldFiltered(data.itemcost, true, DOTA_ModifyGold_SellItem)
				stop = true
			end

			if player.player_courier and not stop then
				item = player.player_courier:GetItemInSlot(i)
				if item and item:GetName() == data.itemname then
					UTIL_Remove(item)
					player:ModifyGoldFiltered(data.itemcost, true, DOTA_ModifyGold_SellItem)
					stop = true
				end
			end

			if stop then
				break
			end
		end

		return
	end

	player.purple = player.purple + 1
	player.got_purple = true
end

function dota1x6:ItemAddedFilter(keys)
	local unit = EntIndexToHScript(keys.inventory_parent_entindex_const)
	if unit == nil then
		return true
	end
	local item = EntIndexToHScript(keys.item_entindex_const)
	if item == nil then
		return true
	end
	if unit:GetUnitName() == "npc_dota_hero_invoker" and unit:HasTalent("modifier_invoker_invoke_7") then
		if item:IsActiveNeutral() and item:GetName() ~= "item_invoker_custom_legendary" then
			local item = CreateItem("item_invoker_custom_legendary", unit, unit)
			unit:AddItem(item)
			return false
		end
	end
	return true
end

function dota1x6:ModifyGoldFilter(params)
	local gold = params.gold
	local player = players[params.player_id_const]
	local reason = params.reason_const

	if reason == DOTA_ModifyGold_HeroKill then
		return false
	end
	if reason == DOTA_ModifyGold_CreepKill then
		return false
	end
	if reason == DOTA_ModifyGold_NeutralKill then
		return false
	end
	if reason == DOTA_ModifyGold_Building then
		return false
	end

	if
		player
		and gold > 0
		and reason ~= DOTA_ModifyGold_AbandonedRedistribute
		and reason ~= DOTA_ModifyGold_SellItem
	then
		player.networth = player.networth + gold
	end

	return true
end