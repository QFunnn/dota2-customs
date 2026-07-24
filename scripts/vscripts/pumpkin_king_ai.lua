--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function Spawn( entityKeyValues )
	
	if not IsServer() then
		return
	end

	if thisEntity == nil then
		return
	end

	if thisEntity.vWaypoints==nil then
	    thisEntity.vWaypoints = {}
	    --画一个漫步的行走方向
	    local currentWayPoint = thisEntity:GetAbsOrigin()
		while #thisEntity.vWaypoints < 50 do
			local waypoint = currentWayPoint + RandomVector( RandomFloat( 0, 2048 ) )
			if GridNav:CanFindPath( thisEntity:GetAbsOrigin(), waypoint ) then
				table.insert( thisEntity.vWaypoints, waypoint )
				currentWayPoint=waypoint
			end
		end		
	end

	thisEntity:SetContextThink( "CreepThink", CreepThink, 0.5 )

end

function CreepThink()

	if GameRules:IsGamePaused() then
		return 0.1
	end

	return RoamBetweenWaypoints()

end


function RoamBetweenWaypoints()
	if thisEntity.targetWayPoint ~= nil then
		--如果到了时间, 或者抵达目的地换目标点
		if (thisEntity.targetWayPoint-thisEntity:GetAbsOrigin()):Length2D()<100 or GameRules:GetGameTime()-thisEntity.targetWayPointTime>60 then
			thisEntity.targetWayPoint = nil
		end
		--print(GameRules:GetGameTime()-thisEntity.targetWayPointTime)
	end
	if thisEntity.targetWayPoint == nil then
	   thisEntity.targetWayPoint = thisEntity.vWaypoints[ RandomInt( 1, #thisEntity.vWaypoints ) ]
	   --记录获得新地点的时间
	   thisEntity.targetWayPointTime = GameRules:GetGameTime()
	end
	if thisEntity.targetWayPoint then
	   thisEntity:MoveToPosition( thisEntity.targetWayPoint )
	end
	
	return 0.5
end