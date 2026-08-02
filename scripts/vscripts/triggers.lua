--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("essentials")

function add_quest_1(trigger)
	local hActivatorHero = trigger.activator

	if not _G.players_quest_progress["additional"][102] then
		local data = _G.quest_data["additional"][102].target
		quest_system:StartQuest("additional", 102, data[RandomInt(1, 6)])
		return
	end

	if hActivatorHero and not _G.players_quest_progress["additional"][102].completed then
		local Key = hActivatorHero:FindItemInInventory(_G.players_quest_progress["additional"][102].target)
		if Key then
			_G.players_quest_progress["additional"][102].completed = true
			quest_system:RemoveQuest("additional", 102, "success")
		end
	end
end

function add_quest_3(trigger)
	local hActivatorHero = trigger.activator
	local pid = hActivatorHero:GetPlayerID()

	if not _G.players_quest_progress["additional"][104] then
		local condition = _G.quest_data["additional"][104].condition
		if
			condition
			and _G.players_quest_progress["additional"][condition]
			and _G.players_quest_progress["additional"][condition].completed == true
		then
			quest_system:StartQuest("additional", 104, _G.quest_data["additional"][104].target[1])
			return
		else
			rules:DisplayError(pid, "#fail_additional_quest")
			return
		end
	elseif hActivatorHero and not _G.players_quest_progress["additional"][104].completed then
		local Key = hActivatorHero:FindItemInInventory(_G.quest_data["additional"][104].target[1])
		if Key then
			UTIL_Remove(Key)
			_G.players_quest_progress["additional"][104].completed = true
			quest_system:RemoveQuest("additional", 104, "success")
		end
	end
end

function quest_9(trigger)
	local hActivatorHero = trigger.activator
	hActivatorHero:EmitSound("tutorial_gate_open_metal")
	local quest_9 = _G.players_quest_progress["additional"][109]
	if quest_9 and not quest_9.completed then
		quest_9.kill_count = (quest_9.kill_count or 0) + 1
		quest_system:UpdateQuest("additional", 109, quest_9.kill_count)
		if quest_9.kill_count >= _G.quest_data["additional"][109].goal then
			quest_9.completed = true
			quest_system:RemoveQuest("additional", 109, "success")
		end
	end
end

function quest_111()
	Notifications:TopToAll({ text = "#minihidden", duration = 5 })
	local quest_111 = _G.players_quest_progress["additional"][111]
	if quest_111 and not quest_111.completed then
		quest_111.kill_count = (quest_111.kill_count or 0) + 1
		quest_system:UpdateQuest("additional", 111, quest_111.kill_count)
		if quest_111.kill_count >= _G.quest_data["additional"][111].goal then
			quest_111.completed = true
			quest_system:RemoveQuest("additional", 111, "success")
		end
	end
end

function quest_114(trigger)
	local hActivatorHero = trigger.activator
	hActivatorHero:EmitSound("tutorial_gate_open_metal")
	local quest_114 = _G.players_quest_progress["additional"][114]
	if quest_114 and not quest_114.completed then
		quest_114.kill_count = (quest_114.kill_count or 0) + 1
		quest_system:UpdateQuest("additional", 114, quest_114.kill_count)
		if quest_114.kill_count >= _G.quest_data["additional"][114].goal then
			quest_114.completed = true
			quest_system:RemoveQuest("additional", 114, "success")
		end
	end
end

function reward()
	local origin = thisEntity:GetAbsOrigin()
	local particleLeader =
		ParticleManager:CreateParticle("particles/dire_fx/fire_barracks.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particleLeader, 0, origin + Vector(0, 0, 120))

	local rewardPoint = Entities:FindByName(nil, "reward_point")
	local point = rewardPoint:GetAbsOrigin()
	local rewards = { "middle_box", "small_box", "big_box" }
	local rewardIndex = RandomInt(1, #rewards)
	local hUnit =
		CreateUnitByName(rewards[rewardIndex], point + RandomVector(RandomInt(0, 0)), true, nil, nil, DOTA_TEAM_BADGUYS)
	local unit = Entities:FindByName(nil, "lighter2")
	unit:SetDayTimeVisionRange(1500)
	unit:SetNightTimeVisionRange(1500)
	local particleLeader =
		ParticleManager:CreateParticle("particles/dire_fx/fire_barracks.vpcf", PATTACH_OVERHEAD_FOLLOW, unit)
	ParticleManager:SetParticleControlEnt(
		particleLeader,
		PATTACH_OVERHEAD_FOLLOW,
		unit,
		PATTACH_OVERHEAD_FOLLOW,
		"follow_overhead",
		unit:GetAbsOrigin(),
		true
	)
	quest_system:StartQuest("additional", 112)
end

function quest_110(trigger)
	local hActivatorHero = trigger.activator
	local pid = hActivatorHero:GetPlayerID()

	local main_quest = _G.players_quest_progress["main"][11]
	if main_quest and main_quest.completed then
		return
	end

	local orb_quest = _G.players_quest_progress["additional"][110]

	if not orb_quest then
		local condition = _G.quest_data["additional"][110].condition
		if
			condition
			and _G.players_quest_progress["additional"][condition]
			and _G.players_quest_progress["additional"][condition].completed == true
		then
			quest_system:StartQuest("additional", 110, "item_orb")
			return
		else
			rules:DisplayError(pid, "#fail_additional_quest")
			return
		end
	end

	if orb_quest and not orb_quest.completed then
		local Key = hActivatorHero:FindItemInInventory("item_orb")
		if Key ~= nil then
			UTIL_Remove(Key)
			hActivatorHero:EmitSound("Item.DropGemWorld")

			orb_quest.completed = true
			quest_system:RemoveQuest("additional", 110, "success")

			local point = Entities:FindByName(nil, "drop_point_orb_quest"):GetAbsOrigin()
			local hUnit = CreateUnitByName(
				"middle_box",
				point + RandomVector(RandomInt(0, 20)),
				true,
				nil,
				nil,
				DOTA_TEAM_BADGUYS
			)
			hUnit:EmitSound("Item.DropGemWorld")

			randomspawnshovel()

			local unit = Entities:FindByName(nil, "lighter3")
			unit:SetDayTimeVisionRange(1500)
			unit:SetNightTimeVisionRange(1500)
			local particleLeader =
				ParticleManager:CreateParticle("particles/dire_fx/fire_barracks.vpcf", PATTACH_OVERHEAD_FOLLOW, unit)
			ParticleManager:SetParticleControlEnt(
				particleLeader,
				PATTACH_OVERHEAD_FOLLOW,
				unit,
				PATTACH_OVERHEAD_FOLLOW,
				"follow_overhead",
				unit:GetAbsOrigin(),
				true
			)
			unit:Attribute_SetIntValue("particleID", particleLeader)
		end
	end
end

function quest_10(trigger)
	local hActivatorHero = trigger.activator
	if hActivatorHero ~= nil then
		local Key = hActivatorHero:FindItemInInventory("item_naga_stone")
		if Key ~= nil and Key:GetCurrentCharges() >= 30 then
			UTIL_Remove(Key)
			local quest10 = _G.players_quest_progress["main"][10]
			if quest10 and not quest10.completed then
				quest10.completed = true
				quest_system:RemoveQuest("main", 10, "success")
				hActivatorHero:EmitSound("tutorial_gate_open_metal")
			end
		end
	end
end

function tiny_quest(trigger)
	local hActivatorHero = trigger.activator
	if hActivatorHero ~= nil then
		local Key = hActivatorHero:FindItemInInventory("item_prison_cell_key")
		if Key ~= nil then
			UTIL_Remove(Key)
			local hRelay = Entities:FindByName(nil, "open_tiny_gate")
			hRelay:Trigger(nil, nil)
		end
	end
end

function quest_22(trigger)
	local hActivatorHero = trigger.activator
	local triggerName = thisEntity:GetName()
	hActivatorHero:EmitSound("tutorial_gate_open_metal")

	local quest_22 = _G.players_quest_progress["main"][22]

	local key = hActivatorHero:FindItemInInventory("item_" .. triggerName)
	if key ~= nil and quest_22 and not quest_22.completed then
		UTIL_Remove(key)
		quest_22.kill_count = (quest_22.kill_count or 0) + 1
		quest_system:UpdateQuest("main", 22, quest_22.kill_count)
		if quest_22.kill_count >= _G.quest_data["main"][22].goal then
			quest_22.completed = true
			quest_system:RemoveQuest("main", 22, "success")
			hActivatorHero:EmitSound("tutorial_gate_open_metal")
		end
	end
end

function invasion()
	quest_system:invasion()
end

function randomspawnshovel()
	local item = CreateItem("item_shovel", nil, nil)
	local pos = RandomInt(1, 6)
	local position = Entities:FindByName(nil, "shov" .. pos):GetAbsOrigin()
	if IsInToolsMode() then
		GameRules:SendCustomMessage("ЛОПАТА ПОЗИЦИЯ - " .. pos, 0, 0)
	end
	local drop = CreateItemOnPositionSync(position, item)
	item:LaunchLootInitialHeight(false, 0, 20, 0.5, position)
end

function roshan_gate(trigger)
	local unit = trigger.activator
	local Key = unit:FindItemInInventory("item_ticket2") or unit:FindItemInInventory("item_ticket")
	if Key ~= nil then
		local count = Key:GetCurrentCharges()

		if count > 1 then
			Key:SetCurrentCharges(Key:GetCurrentCharges() - 1)
		else
			UTIL_Remove(Key)
		end

		local gate = Entities:FindByName(nil, "roshan_gate")
		if gate then
			DoEntFire(gate:GetName(), "SetAnimation", "gate_aghanim_01_open_anim", 0.1, nil, nil)
		end
		local obstructions = Entities:FindAllByName("roshan_obstruction")
		for _, obstr in pairs(obstructions) do
			DoEntFire(obstr:GetName(), "Disable", "", 0.1, nil, nil)
		end
		Timers:CreateTimer(5, function()
			if gate then
				DoEntFire(gate:GetName(), "SetAnimation", "gate_aghanim_01_closed", 0.1, nil, nil)
			end
			for _, obstr in pairs(obstructions) do
				DoEntFire(obstr:GetName(), "Enable", "", 0.1, nil, nil)
			end
			return nil
		end)
	else
		Notifications:Top(unit, { text = "#ROSH_need", duration = 5 })
	end
end

function OnTouch(trigger)
	local hActivatorHero = trigger.activator
	if hActivatorHero ~= nil then
		local Key = hActivatorHero:FindItemInInventory("item_prison_cell_key")
		if Key ~= nil then
			UTIL_Remove(Key)
			local hRelay = Entities:FindByName(nil, "traplogic1")
			if hRelay == nil then
				return
			end
			hRelay:Trigger(nil, nil)
			local unit = Entities:FindByName(nil, "npc_dota_boss_nyx_1")
			essentials:createCustomHpBarFor(unit)
			hActivatorHero:EmitSound("DOTA_Item.Bloodstone.Cast")
		end
	end
end

function earth_boss(event)
	local unit = Entities:FindByName(nil, "npc_hidden_earth_boss")
	unit:RemoveModifierByName("modifier_invulnerable")
	unit:RemoveModifierByName("modifier_medusa_stone_gaze_stone")
	unit:RemoveModifierByName("modifier_magic_immune")
	essentials:createCustomHpBarFor(unit)
end

function snow_boss(event)
	local unit = Entities:FindByName(nil, "npc_hidden_snow_boss")
	unit:RemoveModifierByName("modifier_invulnerable")
	unit:RemoveModifierByName("modifier_medusa_stone_gaze_stone")
	unit:RemoveModifierByName("modifier_magic_immune")
	essentials:createCustomHpBarFor(unit)
end

--------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_fire_points", "modifiers/modifier_fire_points", LUA_MODIFIER_MOTION_NONE)

function OnLavaEnter(trigger)
	local ent = trigger.activator
	if not ent then
		return
	end
	if ent:IsAlive() then
		ent:AddNewModifier(ent, self, "modifier_fire_points", {})
		return
	end
end

function OnLavaExit(trigger)
	local ent = trigger.activator
	if not ent then
		return
	end
	if ent:IsAlive() then
		ent:RemoveModifierByName("modifier_fire_points")
		return
	end
end

--------------------------------------------------------------------------------------------------------

function teleport_roshan(event)
	local unit = event.activator

	if not unit or unit.isTeleporting then
		return
	end

	local playerID = unit:GetPlayerOwnerID()

	unit.isTeleporting = true

	ProjectileManager:ProjectileDodge(unit)

	local point = Entities:FindByName(nil, "pnt5"):GetAbsOrigin()

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
end

--------------------------------------------------------------------------------------------------------

local necrolyteIsActivated = false

function tp_necrolyte(event)
	if GameRules:IsCheatMode() and not IsInToolsMode() then
		return
	end
	local unit = event.activator

	if not unit or unit.isTeleporting then
		return
	end

	local playerID = unit:GetPlayerOwnerID()

	unit.isTeleporting = true

	ProjectileManager:ProjectileDodge(unit)

	local point = Entities:FindByName(nil, "point_final_boss"):GetAbsOrigin()

	unit:EmitSound("DOTA_Item.BlinkDagger.Activate")
	ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_ABSORIGIN, unit)

	unit:SetAbsOrigin(point)
	FindClearSpaceForUnit(unit, point, true)
	unit:Stop()

	Timers:CreateTimer(0.1, function()
		if playerID ~= -1 then
			PlayerResource:SetCameraTarget(playerID, nil)
		end
		unit.isTeleporting = false
		return nil
	end)

	for _, status in pairs(_G.bosses_counter) do
		if status == false then
			Shop:ban("exploit: boss_skip_teleport")
			break
		end
	end

	if not necrolyteIsActivated then
		necrolyteIsActivated = true

		Notifications:TopToAll({ text = "#sandgo", duration = 5 })

		Timers:CreateTimer(5.5, function()
			rules:boss_invulnerable("npc_dota_boss_necrolyte")
		end)
	end
end

--------------------------------------------------------------------------------------------------------

function teleportnyx(trigger)
	local hActivatorHero = trigger.activator
	if hActivatorHero ~= nil then
		local R5 = RandomInt(1, 5)
		ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_ABSORIGIN, hActivatorHero)
		hActivatorHero:EmitSound("DOTA_Item.BlinkDagger.Activate")
		local point = Entities:FindByName(nil, "tpnyx" .. R5):GetAbsOrigin()
		PlayerResource:SetCameraTarget(trigger.activator:GetPlayerOwnerID(), trigger.activator)
		trigger.activator:SetAbsOrigin(point)
		FindClearSpaceForUnit(trigger.activator, point, true)
		trigger.activator:Stop()
		Timers:CreateTimer(0.1, function()
			PlayerResource:SetCameraTarget(trigger.activator:GetPlayerOwnerID(), nil)
		end)
	end
end

function nyxoff()
	local unit = Entities:FindByName(nil, "npc_dota_boss_nyx_1")
	unit:RemoveModifierByName("modifier_invulnerable")
	unit:RemoveModifierByName("modifier_medusa_stone_gaze_stone")
	unit:RemoveModifierByName("modifier_magic_immune")
end

function nyxoff2()
	local unit = Entities:FindByName(nil, "npc_dota_boss_nyx_2")
	unit:RemoveModifierByName("modifier_invulnerable")
	unit:RemoveModifierByName("modifier_medusa_stone_gaze_stone")
	unit:RemoveModifierByName("modifier_magic_immune")
end