--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


function start_quest(data)
	quest_system:StartQuest("main", 12)

	local orb_quest = _G.players_quest_progress["additional"][110]
	if orb_quest and orb_quest.completed then
		quest_system:StartQuest("additional", 107)
	end
end

function spawn_creeps()
	local random_ability = passive[RandomInt(1, #passive)]
	local count = 0
	local quest = 0

	local dust_waves = {
		odd = {
			"npc_dota_zone_7_unit_1",
			"npc_dota_zone_7_unit_2",
			"npc_dota_zone_7_unit_4",
		},
		even = {
			"npc_dota_zone_7_unit_1",
			"npc_dota_zone_7_unit_4",
			"npc_dota_zone_7_unit_3",
		},
	}

	Timers:CreateTimer(0, function()
		count = count + 1
		if count > 27 then
			return nil
		end

		local point = Entities:FindByName(nil, "dust_" .. count):GetAbsOrigin()

		local current_wave = (count % 2 == 1) and dust_waves.odd or dust_waves.even

		for _, unit_name in ipairs(current_wave) do
			local unit = CreateUnitByName(unit_name, point + RandomVector(200), true, nil, nil, DOTA_TEAM_NEUTRALS)
			rules:aura_dif(unit, random_ability)
		end

		return 0.1
	end)

	Timers:CreateTimer(0, function()
		quest = quest + 1
		if quest > 7 then
			return nil
		end
		local point = Entities:FindByName(nil, "dust_quest_" .. quest):GetAbsOrigin()
		local unit = CreateUnitByName("npc_dust_quest", point, true, nil, nil, DOTA_TEAM_NEUTRALS)
		return 0.1
	end)

	if _G.Game_Difficulty >= 12 then
		Timers:CreateTimer(3, function()
			Notifications:TopToAll({ text = "#usilenie", duration = 3 })
			Notifications:TopToAll({ text = "#DOTA_Tooltip_ability_" .. random_ability, duration = 3 })
			rules:updateExtraAbility("creeps", random_ability)
		end)
	end

	rules:clear_zone("dust_", 1, 27)
	rules:clear_zone("dust_quest_", 1, 7)
end