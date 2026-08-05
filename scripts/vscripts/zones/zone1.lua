--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


function quest_start(data)
	quest_system:StartQuest("main", 1)
end

function creeps_spawn()
	local random_ability = passive[RandomInt(1, #passive)]

	local wolf_wave = {
		"npc_dota_zone_1_unit_5",
		"npc_dota_zone_1_unit_5",
		"npc_dota_zone_1_unit_5",
		"npc_dota_zone_1_unit_5",
		"npc_dota_zone_1_unit_6",
	}

	local ursa_waves = {
		special = {
			"npc_dota_zone_1_unit_4",
			"npc_dota_zone_1_unit_4",
			"npc_dota_zone_1_unit_4",
			"npc_dota_zone_1_unit_3",
		},
		normal = {
			"npc_dota_zone_1_unit_2",
			"npc_dota_zone_1_unit_2",
			"npc_dota_zone_1_unit_2",
			"npc_dota_zone_1_unit_1",
		},
	}

	local special_ursa_indices =
		{ [1] = true, [3] = true, [5] = true, [6] = true, [7] = true, [8] = true, [10] = true, [12] = true }

	local count_first = 0
	Timers:CreateTimer(0, function()
		count_first = count_first + 1
		if count_first > 15 then
			return nil
		end

		local point = Entities:FindByName(nil, "wolf" .. count_first):GetAbsOrigin()
		for _, unit_name in ipairs(wolf_wave) do
			local unit = CreateUnitByName(unit_name, point + RandomVector(150), true, nil, nil, DOTA_TEAM_NEUTRALS)
			rules:aura_dif(unit, random_ability)
		end

		return 0.1
	end)

	local count_second = 0
	Timers:CreateTimer(0, function()
		count_second = count_second + 1
		if count_second > 13 then
			return nil
		end

		local point = Entities:FindByName(nil, "ursa" .. count_second):GetAbsOrigin()

		local current_wave = special_ursa_indices[count_second] and ursa_waves.special or ursa_waves.normal
		for _, unit_name in ipairs(current_wave) do
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

	if _G.Game_Difficulty >= 16 then
		local point = Entities:FindByName(nil, "easy_target"):GetAbsOrigin()
		local unit = CreateUnitByName("ultra_caster", point, true, nil, nil, DOTA_TEAM_NEUTRALS)
		UltraCastSkills(unit)
	end

	rules:clear_zone("wolf", 1, 15)
	rules:clear_zone("ursa", 1, 13)
end

function UltraCastSkills(caster)
	local delay = RandomFloat(60, 120)

	caster:SetContextThink("RandomAbilityThinker", function()
		if not caster or caster:IsNull() or not caster:IsAlive() then
			return nil
		end

		local abilities = {}
		for i = 0, caster:GetAbilityCount() - 1 do
			local ab = caster:GetAbilityByIndex(i)
			if ab and not ab:IsPassive() and ab:GetLevel() > 0 then
				table.insert(abilities, ab)
			end
		end

		if #abilities > 0 then
			local random_ab = abilities[RandomInt(1, #abilities)]
			caster:CastAbilityNoTarget(random_ab, -1)
		end

		return RandomFloat(60, 120)
	end, delay)
end