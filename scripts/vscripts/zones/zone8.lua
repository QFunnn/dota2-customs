--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


function start_quest(data)
	quest_system:StartQuest("main", 14)
end

function spawn_creeps()
	random_ability = passive[RandomInt(1, #passive)]

	local count = 0
	local forest_waves = {
		odd = {
			"npc_dota_zone_8_unit_5",
			"npc_dota_zone_8_unit_3",
			"npc_dota_zone_8_unit_4",
			"npc_dota_zone_8_unit_4",
			"npc_dota_zone_8_unit_2",
			"npc_dota_zone_8_unit_6",
		},
		even = {
			"npc_dota_zone_8_unit_5",
			"npc_dota_zone_8_unit_4",
			"npc_dota_zone_8_unit_3",
			"npc_dota_zone_8_unit_2",
			"npc_dota_zone_8_unit_2",
			"npc_dota_zone_8_unit_6",
		},
	}

	Timers:CreateTimer(0, function()
		count = count + 1
		if count > 25 then
			return nil
		end

		local point = Entities:FindByName(nil, "for" .. count):GetAbsOrigin()

		local current_wave = (count % 2 == 1) and forest_waves.odd or forest_waves.even

		for _, unit_name in ipairs(current_wave) do
			local unit = CreateUnitByName(unit_name, point + RandomVector(200), true, nil, nil, DOTA_TEAM_NEUTRALS)
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

	rules:clear_zone("for", 1, 25)
end