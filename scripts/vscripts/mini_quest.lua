--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


_G.shovel_event = false

function mine_room_quest(trigger)
	local hero = trigger.activator
	if hero ~= nil then
		local Key = hero:FindItemInInventory("item_shovel")
		if Key ~= nil then
			UTIL_Remove(Key)
			mine_spawn()
			start_event()
		else
			Notifications:TopToAll({ text = "#mine_quest", duration = 5 })
		end
	end
end

function mine_spawn()
	local random_epic_box = RandomInt(1, 7)
	local units = { "middle_box", "small_box", "ultra_box" }
	for i = 1, 7 do
		local point = Entities:FindByName(nil, "mine" .. i):GetAbsOrigin()
		if i % 2 ~= 0 then
			for i = 1, 2 do
				local unit = CreateUnitByName(
					"npc_treasure_chest",
					point + RandomVector(RandomInt(30, 30)),
					true,
					nil,
					nil,
					DOTA_TEAM_BADGUYS
				)
			end
		end
		if i == random_epic_box then
			local unit =
				CreateUnitByName("epic_box", point + RandomVector(RandomInt(30, 30)), true, nil, nil, DOTA_TEAM_BADGUYS)
		else
			local unit = CreateUnitByName(
				units[RandomInt(1, #units)],
				point + RandomVector(RandomInt(30, 30)),
				true,
				nil,
				nil,
				DOTA_TEAM_BADGUYS
			)
		end
	end
end

function start_event()
	_G.shovel_event = true
	local first_show = true
	for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:GetTeam(nPlayerID) == DOTA_TEAM_GOODGUYS then
			if PlayerResource:HasSelectedHero(nPlayerID) then
				local unit = PlayerResource:GetSelectedHeroEntity(nPlayerID)
				unit:AddNewModifier(unit, nil, "modifier_teleport_event", {})
				unit:EmitSound("Portal.Loop_Appear")

				Timers:CreateTimer(3, function()
					local point = Entities:FindByName(nil, "minepnt"):GetAbsOrigin()
					unit:SetAbsOrigin(point)
					FindClearSpaceForUnit(unit, point, true)
					unit:Stop()
					unit:StopSound("Portal.Loop_Appear")
					unit:RemoveModifierByName("modifier_teleport_event")

					PlayerResource:SetCameraTarget(unit:GetPlayerOwnerID(), unit)

					EmitGlobalSound("tutorial_rockslide")
					Timers:CreateTimer(0.1, function()
						PlayerResource:SetCameraTarget(unit:GetPlayerOwnerID(), nil)
						return nil
					end)

					-- local itemsOnGround = Entities:FindAllByClassnameWithin( "dota_item_drop", point, 2500 )
					-- for _, item in pairs(itemsOnGround) do
					-- 	UTIL_Remove(item)
					-- end
				end)
			end
		end
	end

	local duration_event = 10
	Timers:CreateTimer(3, function()
		if first_show then
			first_show = false
			Notifications:TopToAll({ text = "#mine_quest2", duration = 3 })
		end
		duration_event = duration_event - 1
		if duration_event > 0 then
			Notifications:TopToAll({ text = "#mine" .. duration_event, duration = 1 })
			return 1
		else
			mine_tp_out()
			return nil
		end
	end)
end

function mine_tp_out()
	for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:GetTeam(nPlayerID) == DOTA_TEAM_GOODGUYS then
			if PlayerResource:HasSelectedHero(nPlayerID) then
				local unit = PlayerResource:GetSelectedHeroEntity(nPlayerID)
				unit:AddNewModifier(unit, nil, "modifier_teleport_event", {})
				unit:EmitSound("Portal.Loop_Appear")
				Timers:CreateTimer(3, function()
					_G.shovel_event = false
					local ent = Entities:FindByName(nil, "pnt5")
					local point = ent:GetAbsOrigin()
					unit:SetAbsOrigin(point)
					FindClearSpaceForUnit(unit, point, true)
					unit:Stop()
					unit:StopSound("Portal.Loop_Appear")
					unit:RemoveModifierByName("modifier_teleport_event")

					PlayerResource:SetCameraTarget(unit:GetPlayerOwnerID(), unit)
					Timers:CreateTimer(0.1, function()
						PlayerResource:SetCameraTarget(unit:GetPlayerOwnerID(), nil)
						return nil
					end)
					Timers:CreateTimer(3, function()
						local removableEnts = {
							["dota_item_drop"] = true,
							["npc_dota_creature"] = true,
						}

						local mineCenterPoint = Entities:FindByName(nil, "mine5"):GetAbsOrigin()

						local entsInMine = Entities:FindAllInSphere(mineCenterPoint, 2000)

						for _, ent in ipairs(entsInMine) do
							local classname = ent:GetClassname()

							if removableEnts[classname] then
								ent:RemoveSelf()
							end
						end
					end)
				end)

				Timers:CreateTimer("timer_tp_out_mines", {
					useGameTime = false,
					endTime = 1,
					callback = function()
						local hRelay = Entities:FindByName(nil, "mine_tpout")
						if hRelay == nil then
							return
						end
						hRelay:Trigger(nil, nil)
						return 0.2
					end,
				})
			end
		end
	end
end

function tp_out_mines(event)
	if _G.shovel_event == false then
		local unit = event.activator
		local ent = Entities:FindByName(nil, "pnt5")
		local point = ent:GetAbsOrigin()
		unit:SetAbsOrigin(point)
		FindClearSpaceForUnit(unit, point, true)
		unit:Stop()
		PlayerResource:SetCameraTarget(event.activator:GetPlayerOwnerID(), event.activator)
		Timers:CreateTimer(0.1, function()
			PlayerResource:SetCameraTarget(event.activator:GetPlayerOwnerID(), nil)
			return nil
		end)
	end
end