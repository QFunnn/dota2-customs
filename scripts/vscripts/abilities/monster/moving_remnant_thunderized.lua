--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ResolveMovingRemnantRoomId, IsSameMovingRemnantRoom
local ____item_thunder_grass = require("abilities.items.potions.item_thunder_grass")
local IsUnitThunderized = ____item_thunder_grass.IsUnitThunderized
function ResolveMovingRemnantRoomId(self, unit)
	if not unit or not IsValid(nil, unit) or unit:IsNull() then
		return nil
	end
	local ____this_1
	____this_1 = unit
	local ____opt_0 = ____this_1.GetRoomId
	local unitRoomId = ____opt_0 and ____opt_0(____this_1)
	if unitRoomId ~= nil and unitRoomId ~= nil then
		return unitRoomId
	end
	local playerId = unit:GetPlayerOwnerID()
	if playerId == nil or playerId < 0 then
		return nil
	end
	local ____opt_2 = MyGameRoomManager and MyGameRoomManager:GetPlayerRoom(playerId)
	return ____opt_2 and ____opt_2:GetRoomId()
end
function IsSameMovingRemnantRoom(self, unit, expectedRoomId)
	if expectedRoomId == nil or expectedRoomId == nil then
		return true
	end
	return ResolveMovingRemnantRoomId(nil, unit) == expectedRoomId
end
--- 雷化单位会吸引移动残影，但免疫残影爆炸带来的伤害和控制。
function ____exports.ShouldIgnoreMovingRemnantImpact(self, unit, roomId)
	if not IsValidAlive(nil, unit) then
		return false
	end
	if not IsUnitThunderized(nil, unit) then
		return false
	end
	return IsSameMovingRemnantRoom(nil, unit, roomId)
end
--- 查找同房间内最近的雷化敌方单位，供移动残影追踪使用。
function ____exports.FindNearestThunderizedEnemyForMovingRemnant(self, caster, origin, searchRange, roomId)
	if not IsValidAlive(nil, caster) then
		return nil
	end
	local expectedRoomId = roomId or ResolveMovingRemnantRoomId(nil, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		searchRange,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	local nearestTarget
	local nearestDistance = searchRange + 1
	for ____, enemy in ipairs(enemies) do
		do
			if not ____exports.ShouldIgnoreMovingRemnantImpact(nil, enemy, expectedRoomId) then
				goto __continue10
			end
			local distance = GetDistance(nil, origin, enemy:GetAbsOrigin())
			if distance >= nearestDistance then
				goto __continue10
			end
			nearestTarget = enemy
			nearestDistance = distance
		end
		::__continue10::
	end
	return nearestTarget
end
return ____exports