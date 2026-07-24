--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---Важную логику нельзя писать здесь, потому что её можно злонамеренно подделать
---@param orderTable ExecuteOrderFilterEvent
---@return boolean
function GameMode:OrderFilter(orderTable)

	local nPlayerID = orderTable.issuer_player_id_const
	if (orderTable.order_type == DOTA_UNIT_ORDER_PICKUP_ITEM or orderTable.order_type == DOTA_UNIT_ORDER_ATTACK_TARGET) and orderTable.queue == 0 then
		local hTarget = EntIndexToHScript(orderTable.entindex_target)
		--PrintTable(hTarget)
		if nPlayerID and hTarget and hTarget.GetContainedItem ~= nil then
			local hItem = hTarget:GetContainedItem()
			local hCaster = hItem:GetCaster()

			if IsValid(hCaster) and hCaster:GetPlayerOwnerID() ~= nPlayerID then
				return false
			elseif hItem.iPlayerID and hItem.iPlayerID ~= nPlayerID then
				return false
			end
		end
	end

	if (orderTable.order_type == DOTA_UNIT_ORDER_EJECT_ITEM_FROM_STASH) and orderTable.queue == 0 then
		return false
	end

	if (orderTable.order_type == DOTA_UNIT_ORDER_DROP_ITEM) and orderTable.queue == 0 then
		local hAbility = EntIndexToHScript(orderTable.entindex_ability)
		if hAbility and hAbility:IsItem() then
			if hAbility:GetName() and "item_rapier" == hAbility:GetName() then
				return false
			end
		end
	end
	if (orderTable.order_type == DOTA_UNIT_ORDER_CAST_TARGET) and orderTable.queue == 0 then
		if orderTable.entindex_target ~= nil then
			local hAbility = EntIndexToHScript(orderTable.entindex_ability)
			if hAbility and hAbility.IsItem and hAbility:IsItem() then
				if hAbility:GetName() and "item_moon_shard" == hAbility:GetName() then
					local hUnit
					if orderTable.units and orderTable.units["0"] then
						hUnit = EntIndexToHScript(orderTable.units["0"])
					end
					if hUnit and hUnit:IsTempestDouble() then
						local hPlayer = PlayerResource:GetPlayer(nPlayerID)
						if hPlayer then
							CustomGameEventManager:Send_ServerToPlayer(hPlayer, "SendHudError", { message = "dota_hud_error_ability_inactive" })
						end
						return false
					end
				end
			end
		end
	end

	if orderTable.queue == 0 then
	end
	if (orderTable.order_type == DOTA_UNIT_ORDER_CAST_TARGET) and orderTable.queue == 0 then
		local hAbility = EntIndexToHScript(orderTable.entindex_ability)
		if hAbility and hAbility.GetAbilityName then
			if hAbility:GetAbilityName() == "life_stealer_infest" then
				if orderTable.entindex_target then
					local hTarget = EntIndexToHScript(orderTable.entindex_target)
					if hTarget ~= nil and hTarget:HasModifier("modifier_life_stealer_infest_effect") then
						if nPlayerID then
							local hPlayer = PlayerResource:GetPlayer(nPlayerID)
							if hPlayer then
								CustomGameEventManager:Send_ServerToPlayer(hPlayer, "SendHudError", { message = "dota_hud_error_target_already_infected" })
							end
						end
						return false
					end
				end
			end
		end
	end

	if (orderTable.order_type == DOTA_UNIT_ORDER_CAST_TARGET) then
		local hAbility = EntIndexToHScript(orderTable.entindex_ability)
		local hTarget = EntIndexToHScript(orderTable.entindex_target)
		if IsValid(hTarget) and hAbility then
			local AbilityName = hAbility:GetAbilityName()
			if hTarget:GetUnitName() == "npc_dota_roshan" then
				if AbilityName == "snapfire_gobble_up" then
					return false
				end
				if AbilityName == "item_iron_talon" then
					return false
				end
			end
		end
	end

	if (orderTable.order_type == DOTA_UNIT_ORDER_CAST_TARGET) and orderTable.queue == 0 then
		local hAbility = EntIndexToHScript(orderTable.entindex_ability)
		if hAbility and hAbility.GetAbilityName then
			if "life_stealer_infest" == hAbility:GetAbilityName() or "doom_bringer_devour" == hAbility:GetAbilityName() or "night_stalker_hunter_in_the_night" == hAbility:GetAbilityName() then
				if orderTable.entindex_target then
					local hTarget = EntIndexToHScript(orderTable.entindex_target)
					if hTarget and hTarget.GetUnitName and (hTarget:GetUnitName() == "npc_dota_roshan") then
						if nPlayerID then
							local hPlayer = PlayerResource:GetPlayer(nPlayerID)
							if hPlayer then
								CustomGameEventManager:Send_ServerToPlayer(hPlayer, "SendHudError", { message = "dota_hud_error_cant_cast_on_roshan" })
							end
						end
						return false
					end
				end
			end
		end
	end

	return true
end