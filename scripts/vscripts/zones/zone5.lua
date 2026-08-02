--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function quest_start(data)
	quest_system:StartQuest("main", 9)
end

function crate()
	for i = 41, 51 do
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
	rules:clear_zone("crate", 41, 51)
end

function creep_spawn()
	local random_ability = passive[RandomInt(1, #passive)]
	local count = 0

	local trap_wave = {
		"npc_dota_zone_5_unit_3",
		"npc_dota_zone_5_unit_1",
		"npc_dota_zone_5_unit_1",
		"npc_dota_zone_5_unit_1",
		"npc_dota_zone_5_unit_2",
		"npc_dota_zone_5_unit_2",
	}

	Timers:CreateTimer(0, function()
		count = count + 1
		if count > 17 then
			return nil
		end

		local point = Entities:FindByName(nil, "trapspawn" .. count):GetAbsOrigin()

		for _, unit_name in ipairs(trap_wave) do
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

	rules:clear_zone("trapspawn", 1, 17)
end

------------------------------------------------------------------

function teleport_room(event)
	local unit = event.activator
	local triggerName = thisEntity:GetName()
	if not unit or unit.isTeleporting then
		return
	end

	local playerID = unit:GetPlayerOwnerID()

	unit.isTeleporting = true

	if triggerName == "trap_tp_10" then
		local quest_9 = _G.players_quest_progress["additional"][106]
		if quest_9 and not quest_9.completed then
			quest_9.kill_count = (quest_9.kill_count or 0) + 1
			quest_system:UpdateQuest("additional", 106, quest_9.kill_count)
			if quest_9.kill_count >= _G.quest_data["additional"][106].goal then
				quest_9.completed = true
				quest_system:RemoveQuest("additional", 106, "success")
			end
		end
	end

	Timers:CreateTimer(0.3, function()
		local ent = Entities:FindByName(nil, triggerName .. "_point")

		if ent then
			local point = ent:GetAbsOrigin()

			unit:EmitSound("DOTA_Item.BlinkDagger.Activate")
			ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_ABSORIGIN, unit)

			unit:SetAbsOrigin(point)
			FindClearSpaceForUnit(unit, point, true)
			unit:Stop()

			PlayerResource:SetCameraTarget(playerID, unit)

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

------------------------------------------------------------------

function guard_activate()
	_G.Zone_trap_1_room = false
	local unit = Entities:FindAllByName("npc_dota_boss_guardian")
	for _, key in pairs(unit) do
		key:RemoveModifierByName("modifier_invulnerable")
		key:RemoveModifierByName("modifier_medusa_stone_gaze_stone")
		key:RemoveModifierByName("modifier_magic_immune")
	end
end

------------------------------------------------------------------

function create_item_key()
	local item = CreateItem("item_prison_cell_key", nil, nil)
	local pos = Entities:FindByName(nil, "guard_room_activate"):GetAbsOrigin()
	local drop = CreateItemOnPositionSync(pos, item)
	-- item:LaunchLoot(false, 20, 0.75, pos)
	item:LaunchLootInitialHeight(false, 0, 20, 0.5, pos)
end

------------------------------------------------------------------

function hide_room_sound(trigger)
	local hActivatorHero = trigger.activator
	hActivatorHero:EmitSound("tutorial_gate_open_metal")
end

------------------------------------------------------------------

LinkLuaModifier("modifier_hidden_room_effect", "modifiers/modifier_hidden_room_effect", LUA_MODIFIER_MOTION_NONE)

function silent_effect(event)
	local unit = event.activator
	unit:AddNewModifier(unit, self, "modifier_hidden_room_effect", {})
end