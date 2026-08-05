--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


function start_quest(data)
	quest_system:StartQuest("main", 18)
end

function creep_spawn()
	local random_ability = passive[RandomInt(1, #passive)]
	local count = 0

	local venom_waves = {
		special = {
			"npc_dota_zone_10_unit_1",
			"npc_dota_zone_10_unit_2",
			"npc_dota_zone_10_unit_2",
			"npc_dota_zone_10_unit_4",
		},
		normal = {
			"npc_dota_zone_10_unit_3",
			"npc_dota_zone_10_unit_2",
			"npc_dota_zone_10_unit_2",
			"npc_dota_zone_10_unit_4",
		},
	}

	Timers:CreateTimer(0, function()
		count = count + 1
		if count > 30 then
			return nil
		end

		local ent = Entities:FindByName(nil, "venom" .. count)
		if not ent then
			return 0.1
		end
		local point = ent:GetAbsOrigin()

		local current_wave = (count % 4 == 0) and venom_waves.special or venom_waves.normal

		for _, unit_name in ipairs(current_wave) do
			local unit = CreateUnitByName(unit_name, point + RandomVector(250), true, nil, nil, DOTA_TEAM_NEUTRALS)
			rules:aura_dif(unit, random_ability)
		end

		if count % 3 == 0 then
			local extra_unit = CreateUnitByName(
				"npc_dota_zone_10_unit_5",
				point + RandomVector(300),
				true,
				nil,
				nil,
				DOTA_TEAM_NEUTRALS
			)
			if extra_unit then
				rules:aura_dif(extra_unit, random_ability)
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

	rules:clear_zone("venom", 1, 30)
end

--------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_acid_damage", "modifiers/modifier_acid_damage", LUA_MODIFIER_MOTION_NONE)

function OnSlowEnter(trigger)
	local ent = trigger.activator
	if not ent then
		return
	end
	if ent:IsAlive() then
		ent:AddNewModifier(ent, self, "modifier_acid_damage", {})
		return
	end
end

function OnSlowExit(trigger)
	local ent = trigger.activator
	if not ent then
		return
	end
	if ent:IsAlive() then
		ent:RemoveModifierByName("modifier_acid_damage")
		return
	end
end

--------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_acid", "modifiers/modifier_acid", LUA_MODIFIER_MOTION_NONE)

function OnSlowEnter2(trigger)
	local ent = trigger.activator
	if not ent then
		return
	end
	if ent:IsAlive() then
		ent:AddNewModifier(ent, self, "modifier_acid", {})
		return
	end
end

function OnSlowExit2(trigger)
	local ent = trigger.activator
	if not ent then
		return
	end
	if ent:IsAlive() then
		ent:RemoveModifierByName("modifier_acid")
		return
	end
end