--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function start_quest(data)
	quest_system:StartQuest("main", 16)
end

function creep_spawn()
	local point = Entities:FindByName(nil, "tomb_spawn_1"):GetAbsOrigin()
	local unit = CreateUnitByName("npc_zone_9_tomb", point, true, nil, nil, DOTA_TEAM_NEUTRALS)
	unit:SetEntityName("npc_zone_9_tomb")
	unit.number = 1

	random_ability = passive[RandomInt(1, #passive)]
	local count = 0
	local wave_templates = {
		odd = {
			"npc_dota_zone_9_unit_1",
			"npc_dota_zone_9_unit_2",
			"npc_dota_zone_9_unit_3",
		},
		even = {
			"npc_dota_zone_9_unit_1",
			"npc_dota_zone_9_unit_2",
			"npc_dota_zone_9_unit_3",
			"npc_dota_zone_9_unit_3",
		},
	}

	Timers:CreateTimer(0, function()
		count = count + 1
		if count > 29 then
			return nil
		end

		local point = Entities:FindByName(nil, "doom" .. count):GetAbsOrigin()

		local current_wave = (count % 2 == 1) and wave_templates.odd or wave_templates.even

		for _, unit_name in ipairs(current_wave) do
			local spawn_pos = point + RandomVector(250)
			local unit = CreateUnitByName(unit_name, spawn_pos, true, nil, nil, DOTA_TEAM_NEUTRALS)
			unit:SetEntityName(unit_name)
			rules:aura_dif(unit, random_ability)
			if count > 19 then
				part_invulnerable(unit)
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

	rules:clear_zone("doom", 1, 29)

	thisEntity:SetContextThink("universal_trap_thinker", UniversalTrapThinker, 0.5)
end

function part_invulnerable(unit)
	unit:AddNewModifier(unit, nil, "modifier_invulnerable", {})
	unit:AddNewModifier(unit, nil, "modifier_medusa_stone_gaze_stone", {})
	unit:AddNewModifier(unit, nil, "modifier_magic_immune", {})
end

-- //////////////////////////

function lord_quest(trigger)
	local triggerName = thisEntity:GetName()
	local hActivatorHero = trigger.activator
	if hActivatorHero ~= nil then
		local Key = hActivatorHero:FindItemInInventory("item_" .. triggerName)
		if Key ~= nil then
			UTIL_Remove(Key)
			local hRelay = Entities:FindByName(nil, "relay_" .. triggerName)
			hRelay:Trigger(nil, nil)

			local num = tonumber(triggerName:match("%d+"))

			local units = Entities:FindAllByName("npc_zone_9_tomb")
			for _, unit in ipairs(units) do
				if unit.number == num then
					UTIL_Remove(unit)
				end
			end

			if triggerName == "candy3" then
				local unit_types = { "npc_dota_zone_9_unit_1", "npc_dota_zone_9_unit_2", "npc_dota_zone_9_unit_3" }
				local modifiers_to_remove = {
					"modifier_invulnerable",
					"modifier_medusa_stone_gaze_stone",
					"modifier_magic_immune",
				}
				for _, unit_name in ipairs(unit_types) do
					local units = Entities:FindAllByName(unit_name)
					for _, unit in pairs(units) do
						for _, mod_name in ipairs(modifiers_to_remove) do
							unit:RemoveModifierByName(mod_name)
						end
					end
				end
			end

			hActivatorHero:EmitSound("tutorial_gate_open_metal")

			if num < 4 then
				local point = Entities:FindByName(nil, "tomb_spawn_" .. num + 1):GetAbsOrigin()
				local unit = CreateUnitByName("npc_zone_9_tomb", point, true, nil, nil, DOTA_TEAM_NEUTRALS)
				unit:SetEntityName("npc_zone_9_tomb")
				unit.number = num + 1
			end

			local quest16 = _G.players_quest_progress["main"][16]
			if quest16 and not quest16.completed then
				quest16.kill_count = (quest16.kill_count or 0) + 1
				quest_system:UpdateQuest("main", 16, quest16.kill_count)
				if quest16.kill_count >= _G.quest_data["main"][16].goal then
					quest16.completed = true
					quest_system:RemoveQuest("main", 16, "success")
				end
			end
		end
	end
end

-- //////////////////////////

local TRAP_SETTINGS = {
	{
		npc_name = "1_lord_room_npc",
		target_name = "1_lord_room_target",
		model_name = "1_lord_room_model",
		max_shots = 3,
		interval = 0.3,
		cooldown = 1.7,
		damage_prc = 75,
		damage = 0,
		shot_range = 600,
		particle = "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf",
	},
	{
		npc_name = "2_lord_room_npc",
		target_name = "2_lord_room_target",
		model_name = "2_lord_room_model",
		max_shots = 2,
		interval = 0.2,
		cooldown = 0.8,
		damage_prc = 75,
		damage = 0,
		shot_range = 600,
		particle = "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf",
	},
	{
		npc_name = "3_lord_room_npc",
		target_name = "3_lord_room_target",
		model_name = "3_lord_room_model",
		max_shots = 3,
		interval = 0.3,
		cooldown = 0.9,
		damage_prc = 75,
		damage = 0,
		shot_range = 600,
		particle = "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf",
	},
}

for _, trap in pairs(TRAP_SETTINGS) do
	trap.current_shots = trap.max_shots
end

function UniversalTrapThinker()
	if not IsServer() then
		return -1
	end

	if GameRules:IsGamePaused() then
		return 0.1
	end

	local next_think = 0.1

	for _, trap in pairs(TRAP_SETTINGS) do
		if not trap.wait_until or GameRules:GetGameTime() >= trap.wait_until then
			if trap.current_shots > 0 then
				FireSingleTrap(trap)
				trap.current_shots = trap.current_shots - 1
				trap.wait_until = GameRules:GetGameTime() + trap.interval
			else
				trap.current_shots = trap.max_shots
				trap.wait_until = GameRules:GetGameTime() + trap.cooldown
			end
		end
	end
	return next_think
end

function FireSingleTrap(data)
	local npc = Entities:FindByName(nil, data.npc_name)
	local target = Entities:FindByName(nil, data.target_name)

	if npc and target then
		local ability = npc:FindAbilityByName("simple_trap_shot")
		if ability then
			ability.damage_prc = data.damage_prc
			ability.shot_range = data.shot_range
			ability.damage = data.damage
			ability.particle = data.particle
			ability.sound = "Conquest.FireTrap.Generic"

			if data.model_name then
				DoEntFire(data.model_name, "SetAnimation", "bark_attack", 0.1, nil, nil)
			end
			npc:CastAbilityOnPosition(target:GetOrigin(), ability, -1)
		end
	end
end