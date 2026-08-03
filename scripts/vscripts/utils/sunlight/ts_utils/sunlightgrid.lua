--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
SLGrid = SLGrid or {}
do
	--- 检查开始和结束点之间有没有阻隔 有阻隔找到最近的位置
	--
	-- @block_class_name 阻隔名称 默认 `point_simple_obstruction`
	-- @server
	function SLGrid.CheckPath(self, startPoint, endPoint, block_class_name)
		if block_class_name == nil then
			block_class_name = "point_simple_obstruction"
		end
		local distance = SLVector:Distance2D(startPoint, endPoint)
		local fv = (endPoint - startPoint):Normalized()
		local checkPoint = startPoint + fv * distance / 2
		local obstructions = Entities:FindAllByClassnameWithin(block_class_name, checkPoint, distance)
		__TS__ArrayForEach(obstructions, function(____, obstruction)
			local obstructionPos = obstruction:GetAbsOrigin()
			local hypotenuse = SLVector:Distance2D(obstructionPos, startPoint)
			local hypotenuseFv = (obstructionPos - startPoint):Normalized()
			local angle = AngleDiff(fv, hypotenuseFv)
			local sin = hypotenuse * math.sin(angle * math.pi / 180)
			if sin < 120 then
				endPoint = obstructionPos - hypotenuseFv * 30
			end
		end)
		local num = math.ceil(distance / 32)
		do
			local i = 1
			while i <= num do
				local currentPos = startPoint + fv * 32 * i
				local newPos = currentPos + fv * 32
				local length = GridNav:FindPathLength(currentPos, newPos)
				if length < 0 and not GridNav:IsNearbyTree(newPos, 32, true) then
					endPoint = currentPos
					break
				end
				i = i + 1
			end
		end
		return endPoint
	end
	--- 以一个单位为中心，获取一个有效的点。（在地图内）
	--
	-- @param unit
	-- @param distance 距离
	-- @param angle 角度。默认0是单位的正前方。正值逆时针旋转，负值顺时针旋转，最大180
	-- @server
	function SLGrid.GetPointAroundUnit(self, unit, distance, angle)
		local ____temp_0
		if angle > 0 then
			____temp_0 = math.min(angle, 180)
		else
			____temp_0 = math.max(angle, -180)
		end
		angle = ____temp_0
		local direction = unit:GetForwardVector()
		direction = Vector(direction.x, direction.y, 0)
		local point = unit:GetAbsOrigin() + direction * distance
		point = SLVector:RotateByYaw(unit:GetAbsOrigin(), angle, point)
		if not GridNav:CanFindPath(point, unit:GetAbsOrigin()) or GridNav:IsBlocked(point) then
			return unit:GetAbsOrigin()
		else
			return point
		end
	end
	--- 找到最近的一个有效地形
	--
	-- @param pos
	-- @param maxFindRadius 最大检索范围
	-- @server
	function SLGrid.FindNearestValidGrid(self, pos, maxFindRadius)
		local result_pos
		if not GridNav:CanFindPath(pos, pos) then
			local interval = 50
			local intervalAngle = 10
			do
				local radius = interval
				while radius <= maxFindRadius do
					do
						local angle = 0
						while angle < 360 do
							local new_pos = GetGroundPosition(
								SLVector:RotateByYaw(pos, angle, pos + SLVector:Normalized2D(pos) * radius),
								nil
							)
							if GridNav:CanFindPath(new_pos, new_pos) then
								result_pos = new_pos
								break
							end
							angle = angle + intervalAngle
						end
					end
					if result_pos then
						break
					end
					radius = radius + interval
				end
			end
			return result_pos
		else
			return pos
		end
	end
end