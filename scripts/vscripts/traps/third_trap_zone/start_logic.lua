--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local TRAP_SETTINGS = {
	{
		npc_name = "1_roll_trap_npc",
		target_name = "1_roll_trap_target",
		max_shots = 1,
		interval = 1,
		cooldown = 1,
		shot_range = 1100,
		travel_speed = 400,
	},
	{
		npc_name = "2_roll_trap_npc",
		target_name = "2_roll_trap_target",
		max_shots = 1,
		interval = 1,
		cooldown = 1,
		shot_range = 1100,
		travel_speed = 400,
	},
	{
		npc_name = "3_roll_trap_npc",
		target_name = "3_roll_trap_target",
		max_shots = 1,
		interval = 1,
		cooldown = 1.2,
		shot_range = 1220,
		travel_speed = 450,
	},

	{
		npc_name = "4_roll_trap_npc",
		target_name = "4_roll_trap_target",
		max_shots = 1,
		interval = 1,
		cooldown = 1.4,
		shot_range = 1220,
		travel_speed = 450,
	},

	{
		npc_name = "5_roll_trap_npc",
		target_name = "5_roll_trap_target",
		max_shots = 1,
		interval = 1,
		cooldown = 0.8,
		shot_range = 1220,
		travel_speed = 450,
	},

	{
		npc_name = "6_roll_trap_npc",
		target_name = "6_roll_trap_target",
		max_shots = 1,
		interval = 1,
		cooldown = 1.2,
		shot_range = 1220,
		travel_speed = 450,
	},

	{
		npc_name = "7_roll_trap_npc",
		target_name = "7_roll_trap_target",
		max_shots = 1,
		interval = 1,
		cooldown = 1,
		shot_range = 1220,
		travel_speed = 450,
	},
}

local SPIKE_SETTINGS = {
	{
		npc_name = "1_spike_lord", --1111
		target_name = "1_spike_lord_target",
		model_name = "1_spike_lord_model",
		max_shots = 1,
		interval = 3,
		delay = 1,
	},

	{
		npc_name = "2_spike_lord", --999
		target_name = "2_spike_lord_target",
		model_name = "2_spike_lord_model",
		max_shots = 1,
		interval = 3,
		delay = 2,
	},

	{
		npc_name = "3_spike_lord", --1111
		target_name = "3_spike_lord_target",
		model_name = "3_spike_lord_model",
		max_shots = 1,
		interval = 3,
		delay = 1,
	},

	{
		npc_name = "4_spike_lord",
		target_name = "4_spike_lord_target",
		model_name = "4_spike_lord_model",
		max_shots = 1,
		interval = 3,
		delay = 3,
	},

	{
		npc_name = "5_spike_lord", --999
		target_name = "5_spike_lord_target",
		model_name = "5_spike_lord_model",
		max_shots = 1,
		interval = 3,
		delay = 2,
	},

	{
		npc_name = "6_spike_lord",
		target_name = "6_spike_lord_target",
		model_name = "6_spike_lord_model",
		max_shots = 1,
		interval = 3,
		delay = 2,
	},

	{
		npc_name = "7_spike_lord",
		target_name = "7_spike_lord_target",
		model_name = "7_spike_lord_model",
		max_shots = 1,
		interval = 3,
		delay = 3,
	},

	{
		npc_name = "8_spike_lord", --1111
		target_name = "8_spike_lord_target",
		model_name = "8_spike_lord_model",
		max_shots = 1,
		interval = 3,
		delay = 1,
	},

	{
		npc_name = "9_spike_lord",
		target_name = "9_spike_lord_target",
		model_name = "9_spike_lord_model",
		max_shots = 1,
		interval = 3,
		delay = 3,
	},

	{
		npc_name = "10_spike_lord", --999
		target_name = "10_spike_lord_target",
		model_name = "10_spike_lord_model",
		max_shots = 1,
		interval = 3,
		delay = 2,
	},

	{
		npc_name = "11_spike_lord",
		target_name = "11_spike_lord_target",
		model_name = "11_spike_lord_model",
		max_shots = 1,
		interval = 3,
		delay = 1,
	},

	{
		npc_name = "12_spike_lord",
		target_name = "12_spike_lord_target",
		model_name = "12_spike_lord_model",
		max_shots = 1,
		interval = 3,
		delay = 3,
	},
}

for _, trap in pairs(TRAP_SETTINGS) do
	trap.current_shots = trap.max_shots
end

for _, trap in pairs(SPIKE_SETTINGS) do
	trap.delay = trap.delay
	trap.start = false
end

_G.Zone_trap_roll_room = true

_G.button_home_positions = {}

function SaveButtonHomePositions()
	local all_names = { "red", "blue", "yellow" }
	for _, name in pairs(all_names) do
		_G.button_home_positions[name] = {}
		local props = Entities:FindAllByName(name)
		for _, prop in pairs(props) do
			table.insert(_G.button_home_positions[name], prop:GetAbsOrigin())
		end
	end
end

function ResetAllButtonsInstant()
	local all_names = { "red", "blue", "yellow" }
	for _, name in pairs(all_names) do
		local props = Entities:FindAllByName(name)
		local positions = _G.button_home_positions[name]
		if positions then
			for i, prop in ipairs(props) do
				if prop and not prop:IsNull() and positions[i] then
					prop:SetAbsOrigin(positions[i])
				end
			end
		end
	end
end

function start_shot()
	thisEntity:SetContextThink("universal_trap_thinker", UniversalTrapThinker, 0.5)
	thisEntity:SetContextThink("universal_trap_thinkerSpike", UniversalTrapThinkerSpike, 0.5)
	StartColorQuest()
	SaveButtonHomePositions()
end

-----------------------------------------------------------------------

function UniversalTrapThinker()
	if not IsServer() or not _G.Zone_trap_roll_room then
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
		local ability = npc:FindAbilityByName("simple_roll_shot")
		if ability then
			ability.shot_range = data.shot_range
			ability.travel_speed = data.travel_speed

			npc:CastAbilityOnPosition(target:GetOrigin(), ability, -1)
		end
	end
end

-----------------------------------------------------------------------

function StartColorQuest()
	_G.color_quest = {
		buttons_colors = {
			["lord_room_red"] = 1,
			["lord_room_blue"] = 2,
			["lord_room_yellow"] = 3,
		},
		quest_sequence = {},
		quest_step = 1,
		quest_props = {},
	}

	color_quest.quest_sequence = table.shuffle({ 1, 2, 3 })

	for i, color_index in ipairs(color_quest.quest_sequence) do
		local model = ""
		if color_index == 1 then
			model = "models/events/crownfall/match3/gems/gem_lina.vmdl"
		elseif color_index == 2 then
			model = "models/events/crownfall/match3/gems/gem_lich.vmdl"
		else
			model = "models/events/crownfall/match3/gems/gem_crystalmaiden.vmdl"
		end

		local prop = SpawnEntityFromTableSynchronous("prop_dynamic", {
			model = model,
			origin = Entities:FindByName(nil, "color_point_" .. i):GetAbsOrigin(),
			scales = "2.0 2.0 2.0",
		})
		table.insert(color_quest.quest_props, prop)
	end
end

function restart_quest()
	if color_quest.quest_props and #color_quest.quest_props > 0 then
		for _, prop in pairs(color_quest.quest_props) do
			if prop and not prop:IsNull() then
				UTIL_Remove(prop)
			end
		end
	end
	StartColorQuest()
end

function press_color_button(trigger)
	if _G.Zone_trap_roll_room == false then
		return
	end
	local hero = trigger.activator
	local trigger_name = thisEntity:GetName()
	local pressed_color = color_quest.buttons_colors[trigger_name]
	local correct_color = color_quest.quest_sequence[color_quest.quest_step]
	local button = trigger_name .. "_button"

	DoEntFire(button, "SetAnimation", "ancient_trigger001_down", 0, self, self)
	DoEntFire(button, "SetAnimation", "ancient_trigger001_down_idle", 0.35, self, self)
	DoEntFire(button, "SetAnimation", "ancient_trigger001_up", 0.5, self, self)
	DoEntFire(button, "SetAnimation", "ancient_trigger001_idle", 0.6, self, self)

	print("Нажато: " .. tostring(pressed_color))
	print("Нужно: " .. tostring(correct_color))

	if pressed_color == correct_color then
		color_quest.quest_step = color_quest.quest_step + 1
		hero:EmitSound("tutorial_gate_open_metal")

		MoveDownButton(correct_color)

		if color_quest.quest_step > #color_quest.quest_sequence then
			print("Квест выполнен!")
			color_quest.quest_step = 1
			_G.Zone_trap_roll_room = false

			local hRelay = Entities:FindByName(nil, "relay_bridge_obstr")
			hRelay:Trigger(nil, nil)
		end
	else
		print("Неверный порядок!")
		hero:EmitSound("DOTA_Item.ComboBreaker")
		ResetAllButtonsInstant()
		teleport_room(hero)
		restart_quest()
		-- hero:Kill(nil, nil)
	end
end

function MoveDownButton(number)
	local button_names = { "red", "blue", "yellow" }
	local name = button_names[number]

	if not name then
		return
	end

	local distance_to_move = 300
	local speed = 10
	local moved_so_far = 0

	local props = Entities:FindAllByName(name)

	Timers:CreateTimer(0.03, function()
		if moved_so_far >= distance_to_move then
			return nil
		end
		moved_so_far = moved_so_far + speed
		for _, prop in pairs(props) do
			if prop and not prop:IsNull() then
				local pos = prop:GetAbsOrigin()
				prop:SetAbsOrigin(pos - Vector(0, 0, speed))
			end
		end
		return 0.03
	end)
end

-----------------------------------------------------------------------

function teleport_room(unit)
	if not unit or unit.isTeleporting then
		return
	end

	unit.isTeleporting = true

	Timers:CreateTimer(0.3, function()
		local point = Entities:FindByName(nil, "lord_room_back"):GetAbsOrigin()

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
		return nil
	end)
end

-----------------------------------------------------------------------

function UniversalTrapThinkerSpike()
	if not IsServer() or not _G.Zone_trap_roll_room then
		return -1
	end

	if GameRules:IsGamePaused() then
		return 0.1
	end

	local next_think = 0.1

	for _, trap in pairs(SPIKE_SETTINGS) do
		if not trap.wait_until or GameRules:GetGameTime() >= trap.wait_until then
			if trap.start == false then
				trap.start = true
				trap.wait_until = GameRules:GetGameTime() + trap.delay
			else
				FireSingleTrapSpike(trap)
				trap.wait_until = GameRules:GetGameTime() + trap.interval
			end
		end
	end
	return next_think
end

function FireSingleTrapSpike(data)
	local npc = Entities:FindByName(nil, data.npc_name)
	local target = Entities:FindByName(nil, data.target_name)

	if npc and target then
		local ability = npc:FindAbilityByName("spike_trap")
		if ability then
			local spikes = data.model_name
			DoEntFire(spikes, "SetAnimation", "spiketrap_activate", 0, self, self)
			DoEntFire(spikes, "SetAnimation", "spiketrap_idle", 1.3, self, self)
			npc:CastAbilityOnPosition(target:GetOrigin(), ability, -1)
		end
	end
end