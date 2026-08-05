--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


function spawn_creeps()
	local random_ability = passive[RandomInt(1, #passive)]
	local count = 0

	local sea_wave = {
		"npc_dota_zone_6_unit_3",
		"npc_dota_zone_6_unit_3",
		"npc_dota_zone_6_unit_1",
		"npc_dota_zone_6_unit_1",
		"npc_dota_zone_6_unit_4",
	}

	Timers:CreateTimer(0, function()
		count = count + 1
		if count > 36 then
			return nil
		end

		local point = Entities:FindByName(nil, "sea" .. count):GetAbsOrigin()

		for _, unit_name in ipairs(sea_wave) do
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

	rules:clear_zone("sea", 1, 36)
end