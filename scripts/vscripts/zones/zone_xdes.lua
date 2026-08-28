--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function spawn_creeps()
	local random_ability = passive[RandomInt(1, #passive)]
	local count = 0

	local creeps_xdes_zone = {
		"npc_dota_zone_8_unit_3",
		"npc_dota_zone_8_unit_4",
		"npc_dota_zone_8_unit_5",
		"npc_dota_zone_8_unit_6",
		"npc_dota_zone_9_unit_1",
		"npc_dota_zone_9_unit_2",
		"npc_dota_zone_9_unit_3",
		"npc_dota_zone_10_unit_1",
		"npc_dota_zone_10_unit_4",
		"npc_dota_zone_11_unit_1",
		"npc_dota_zone_11_unit_2",
		"npc_dota_zone_11_unit_3",
		"npc_dota_zone_11_unit_4",
		"npc_dota_zone_12_unit_1",
		"npc_dota_zone_12_unit_2",
		"npc_dota_zone_12_unit_3",
		"npc_dota_zone_12_unit_4",
	}

	Timers:CreateTimer(0, function()
		count = count + 1
		if count > 10 then
			return nil
		end

		local point = Entities:FindByName(nil, "xdes_zone_" .. count):GetAbsOrigin()

		for i = 1, 4 do
			local unit_name = creeps_xdes_zone[RandomInt(1, #creeps_xdes_zone)]
			local unit = CreateUnitByName(
				unit_name,
				point + RandomVector(RandomFloat(50, 200)),
				true,
				nil,
				nil,
				DOTA_TEAM_NEUTRALS
			)

			if unit then
				rules:aura_dif(unit, random_ability)
			end
		end

		return 0.1
	end)

	if _G.Game_Difficulty >= 12 then
		Timers:CreateTimer(3, function()
			Notifications:TopToAll({ text = "#usilenie", duration = 3 })
			Notifications:TopToAll({ text = "#DOTA_Tooltip_ability_" .. random_ability, duration = 3 })
			rules:updateExtraAbility("creeps", random_ability)
		end)
	end

	rules:clear_zone("xdes_zone_", 1, 10)
end

function teleport(event)
	local unit = event.activator
	local triggerName = thisEntity:GetName()
	if not unit or unit.isTeleporting then
		return
	end

	unit.isTeleporting = true

	Timers:CreateTimer(0.3, function()
		local ent = Entities:FindByName(nil, triggerName .. "_point")

		if ent then
			local point = ent:GetAbsOrigin()

			unit:EmitSound("DOTA_Item.BlinkDagger.Activate")
			ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_ABSORIGIN, unit)

			unit:SetAbsOrigin(point)
			FindClearSpaceForUnit(unit, point, true)
			unit:Stop()

			local playerID = unit:GetPlayerOwnerID()
			if playerID ~= -1 then
				PlayerResource:SetCameraTarget(playerID, unit)
			end

			Timers:CreateTimer(0.1, function()
				if playerID ~= -1 then
					PlayerResource:SetCameraTarget(playerID, nil)
				end

				unit.isTeleporting = false
				return nil
			end)
		else
			unit.isTeleporting = false
		end
		return nil
	end)
end