--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
---
-- @noSelf
OnStartTouch_CS = function(trigger)
	local activator = trigger.activator
	local caller = trigger.caller
	if not activator or not caller then
		return
	end
	local nameParts = split(caller:GetName(), ",")
	local roomId = nameParts[1]
	local Signal = caller:Attribute_GetIntValue("Signal_OnEnter", 0)
	local ClassType = nameParts[2]
	if ClassType == "Retrue" or ClassType == "CatReturn" then
		local ____print_7 = print
		local ____temp_6 = caller:GetName()
		local ____opt_0 = activator.GetUnitName
		if ____opt_0 ~= nil then
			____opt_0 = ____opt_0(activator)
		end
		local ____opt_0_2 = ____opt_0
		if ____opt_0_2 == nil then
			____opt_0_2 = "unknown"
		end
		local ____opt_3 = activator.entindex
		if ____opt_3 ~= nil then
			____opt_3 = ____opt_3(activator)
		end
		local ____opt_3_5 = ____opt_3
		if ____opt_3_5 == nil then
			____opt_3_5 = -1
		end
		____print_7(
			(
				(
					(
						(
							(((("[ReturnTrigger] 进入 type=" .. ClassType) .. " entity=") .. ____temp_6) .. " room=")
							.. roomId
						) .. " activator="
					) .. tostring(____opt_0_2)
				) .. " ent="
			) .. tostring(____opt_3_5)
		)
	end
	MyGameEvent:FireEvent(
		"OnEnterComponent_CS",
		{ activator = activator, caller = caller, roomId = roomId, Type = ClassType }
	)
	if Signal == 0 then
		return
	end
	MyGameEvent:FireEvent("Signal_CS", {
		type = "OnEnter",
		activator = activator,
		caller = caller,
		roomId = roomId,
		Signal = Signal,
	})
end
---
-- @noSelf
OnEndTouch_CS = function(trigger)
	if not IsServer() then
		return
	end
	local activator = trigger.activator
	local caller = trigger.caller
	if not activator or not caller then
		return
	end
	local nameParts = split(caller:GetName(), ",")
	local roomId = nameParts[1]
	local Signal = caller:Attribute_GetIntValue("Signal_OnLeave", 0)
	local ClassType = nameParts[2]
	if ClassType == "Retrue" or ClassType == "CatReturn" then
		local ____print_15 = print
		local ____temp_14 = caller:GetName()
		local ____opt_8 = activator.GetUnitName
		if ____opt_8 ~= nil then
			____opt_8 = ____opt_8(activator)
		end
		local ____opt_8_10 = ____opt_8
		if ____opt_8_10 == nil then
			____opt_8_10 = "unknown"
		end
		local ____opt_11 = activator.entindex
		if ____opt_11 ~= nil then
			____opt_11 = ____opt_11(activator)
		end
		local ____opt_11_13 = ____opt_11
		if ____opt_11_13 == nil then
			____opt_11_13 = -1
		end
		____print_15(
			(
				(
					(
						(
							(
								((("[ReturnTrigger] 离开 type=" .. ClassType) .. " entity=") .. tostring(____temp_14))
								.. " room="
							) .. roomId
						) .. " activator="
					) .. tostring(____opt_8_10)
				) .. " ent="
			) .. tostring(____opt_11_13)
		)
	end
	MyGameEvent:FireEvent(
		"OnLeaveComponent_CS",
		{ activator = activator, caller = caller, roomId = roomId, Type = ClassType }
	)
	if Signal == 0 then
		return
	end
	MyGameEvent:FireEvent("Signal_CS", {
		type = "OnLeave",
		activator = activator,
		caller = caller,
		roomId = roomId,
		Signal = Signal,
	})
end