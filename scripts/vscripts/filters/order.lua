--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local PROHIBITED_TO_CAST_ON_FOUNTAIN = {
	vengefulspirit_nether_swap = true,
	pudge_meat_hook = true,
	naga_siren_reel_in = true,
}
local DISABLED_ABILITIES_CAST_ON_ENEMY_FOUNTAIN = {
	muerta_ofrenda = true,
	wisp_relocate = true,
	furion_teleportation = true,
}

local FOUNTAIN_CAST_ORDERS = {
	[DOTA_UNIT_ORDER_CAST_TARGET] = true,
	[DOTA_UNIT_ORDER_CAST_POSITION] = true,
}

local IMMOVABLE_OUTSIDE_FOUNTAIN = {
	item_rapier = true,
	item_gem = true,
}

local STASH_SLOTS = {
	[DOTA_STASH_SLOT_1] = true,
	[DOTA_STASH_SLOT_2] = true,
	[DOTA_STASH_SLOT_3] = true,
	[DOTA_STASH_SLOT_4] = true,
	[DOTA_STASH_SLOT_5] = true,
	[DOTA_STASH_SLOT_6] = true,
}

function Filters:ExecuteOrderFilter(event)
	local order_type = event.order_type
	local player_id = event.issuer_player_id_const
	local target = event.entindex_target ~= 0 and EntIndexToHScript(event.entindex_target) or nil
	local ability = event.entindex_ability ~= 0 and EntIndexToHScript(event.entindex_ability) or nil
	local order_vector = Vector(event.position_x, event.position_y, event.position_z)

	if ability and not ability.GetAbilityName then
		ability = nil
	end
	local ability_name = ability and ability:GetAbilityName() or nil

	local unit
	if event.units and event.units["0"] then
		unit = EntIndexToHScript(event.units["0"])

		if not IsInToolsMode() then
			-- Prevent units of disconnected players from being controlled by their allies
			-- Except party players
			for k, entity_id in pairs(event.units) do
				local unit = EntIndexToHScript(entity_id)

				if unit then
					local owner_player_id = unit:GetPlayerOwnerID()

					if
						owner_player_id ~= player_id
						and not IsPlayerConnected(owner_player_id)
						and not IsPlayersInParty(player_id, owner_player_id)
						and not IsPlayerBotByConnect(owner_player_id)
					then
						event.units[k] = nil
					end
				end
			end
		end
	end

	-- to be sure, let all illusion orders through
	if unit and IsValidEntity(unit) and unit:IsIllusion() then
		return true
	end

	if player_id and Kicks:IsPlayerKicked(player_id) then
		return false
	end

	if DisableHelp.ExecuteOrderFilter(order_type, ability, target, unit, order_vector) == false then
		return false
	end

	if unit and IsValidEntity(unit) and IsValidEntity(ability) then
		local res = FountainProtection:OrderFilter(order_type, ability, target, unit)
		if res then
			return false
		end
	end

	if order_type == DOTA_UNIT_ORDER_VECTOR_TARGET_POSITION and ability and order_vector and event.queue == 0 then
		ability.vector_target_position = order_vector
	end

	-- prevent swapping enemies into fountain
	if
		FOUNTAIN_CAST_ORDERS[order_type]
		and ability
		and PROHIBITED_TO_CAST_ON_FOUNTAIN[ability_name]
		and IsValidEntity(unit)
	then
		local is_caster_on_fountain = unit and unit:HasModifier("modifier_fountain_rejuvenation_effect_lua")
		-- prohibit casting specific spells on fountain entirely if they don't have a target, or target is an enemy
		if is_caster_on_fountain and (not IsValidEntity(target) or target:GetTeamNumber() ~= unit:GetTeamNumber()) then
			DisplayError(player_id, "#dota_hud_error_cant_cast_this_on_fountain")
			return false
		end
	end

	if
		order_type == DOTA_UNIT_ORDER_CAST_POSITION
		and ability
		and IsValidEntity(unit)
		and DISABLED_ABILITIES_CAST_ON_ENEMY_FOUNTAIN[ability_name]
	then
		local fountains = Entities:FindAllByClassname("ent_dota_fountain")
		local min_distance = 2200

		for _, fountain in pairs(fountains) do
			if IsValidEntity(fountain) and fountain:GetTeam() ~= unit:GetTeam() then
				local fountain_location = fountain:GetAbsOrigin()
				if (order_vector - fountain_location):Length2D() < min_distance then
					DisplayErrorWithValues(player_id, "#dota_hud_error_cannot_cast_near_enemy_fountains", {
						ability_name = "DOTA_Tooltip_ability_" .. ability_name,
					})
					return false
				end
			end
		end
	end

	if order_type == DOTA_UNIT_ORDER_MOVE_ITEM and IMMOVABLE_OUTSIDE_FOUNTAIN[ability_name] then
		local origin_slot = ability:GetItemSlot()
		local target_slot = event.entindex_target

		-- prohibit moving from main inventory into stash unless we're at fountain
		if
			STASH_SLOTS[target_slot]
			and not STASH_SLOTS[origin_slot]
			and not unit:HasModifier("modifier_fountain_phasing_effect")
		then
			local player = unit:GetPlayerOwner()
			if IsValidEntity(player) then
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"display_custom_error",
					{ message = "#dota_hud_error_special_item_transfer_only_fountain" }
				)
			end
			return false
		end
	end

	if order_type == DOTA_UNIT_ORDER_PURCHASE_ITEM then
		local item_name = event.shop_item_name or ""

		if AntiFeed:IsForbiddenItemForFeeder(item_name, player_id) then
			local player = unit:GetPlayerOwner()

			if player then
				CustomGameEventManager:Send_ServerToPlayer(
					player,
					"display_custom_error",
					{ message = "#item_purchasing_block" }
				)
			end

			return false
		end
	end

	local punishment_level = WebPlayer:GetPunishmentLevel(player_id)
	if punishment_level == 10 then
		return false
	end

	return true
end