--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function quest_start(data)
	quest_system:StartQuest("main", 7, "item_prison_cell_key")
end

function creep_spawn()
	local random_ability = passive[RandomInt(1, #passive)]
	local count = 0

	local ice_wave = {
		"npc_dota_zone_4_unit_3",
		"npc_dota_zone_4_unit_5",
		"npc_dota_zone_4_unit_5",
		"npc_dota_zone_4_unit_5",
		"npc_dota_zone_4_unit_1",
		"npc_dota_zone_4_unit_2",
	}

	Timers:CreateTimer(0, function()
		count = count + 1
		if count > 22 then
			return nil
		end

		local point = Entities:FindByName(nil, "ice" .. count):GetAbsOrigin()

		for _, unit_name in ipairs(ice_wave) do
			local unit = CreateUnitByName(unit_name, point + RandomVector(150), true, nil, nil, DOTA_TEAM_NEUTRALS)
			rules:aura_dif(unit, random_ability)
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

	rules:clear_zone("ice", 1, 22)

	for i = 30, 40 do
		local point = Entities:FindByName(nil, "crate" .. i):GetAbsOrigin()
		for i = 1, RandomInt(3, 4) do
			local unit = CreateUnitByName(
				"npc_dota_crate",
				point + RandomVector(RandomInt(50, 50)),
				true,
				nil,
				nil,
				DOTA_TEAM_NEUTRALS
			)
		end
	end
	rules:clear_zone("crate", 30, 40)

	local item = CreateItem("item_prison_cell_key", nil, nil)
	local pos = RandomInt(1, 4)
	local position = Entities:FindByName(nil, "rand" .. pos):GetAbsOrigin()
	if IsInToolsMode() then
		GameRules:SendCustomMessage("КЛЮЧ ПОЗИЦИЯ - " .. pos, 0, 0)
	end
	local drop = CreateItemOnPositionSync(position, item)
	item:LaunchLootInitialHeight(false, 0, 20, 0.5, position)

	rules:clear_zone("rand", 1, 4)
end

------------------------------------------------------------------------

LinkLuaModifier("modifier_cold_map_ability", "modifiers/modifier_cold_map_ability", LUA_MODIFIER_MOTION_NONE)

function cold_effect(trigger)
	local ent = trigger.activator
	if not ent or not ent:IsRealHero() then
		return
	end
	ent:AddNewModifier(ent, nil, "modifier_cold_map_ability", {})
end