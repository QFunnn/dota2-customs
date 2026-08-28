--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
SLVector = SLVector or {}
do
	--- 在 XY 平面内，将 point 绕 origin 旋转 yaw_degrees 度（正值逆时针，负值顺时针）
	-- 用于替代已废弃的全局 RotatePosition API
	--
	-- @both
	function SLVector.RotateByYaw(self, origin, yaw_degrees, point)
		local rad = yaw_degrees * (math.pi / 180)
		local cos_a = math.cos(rad)
		local sin_a = math.sin(rad)
		local dx = point.x - origin.x
		local dy = point.y - origin.y
		return Vector(origin.x + dx * cos_a - dy * sin_a, origin.y + dx * sin_a + dy * cos_a, point.z)
	end
	--- 当z为0时的单位向量
	--
	-- @both
	function SLVector.Normalized2D(self, vec)
		if vec.x == 0 and vec.y == 0 then
			return RandomVector(1)
		end
		return Vector(vec.x, vec.y, 0):Normalized()
	end
	--- 两个向量的二维距离
	--
	-- @both
	function SLVector.Distance2D(self, vec1, vec2)
		return math.sqrt(math.pow(vec1.x - vec2.x, 2) + math.pow(vec1.y - vec2.y, 2))
	end
	--- 返回参数position的[向下取整][整数]向量
	--
	-- @param position 原向量
	-- @returns 向下取整的整数向量
	function SLVector.IntVector(self, position)
		if not position then
			return Vector(0, 0, 0)
		end
		return Vector(math.floor(position.x), math.floor(position.y), math.floor(position.z))
	end
	--- 以0点为圆心旋转单位向量 base dota2api: RotatePosition
	--
	-- @param angle 角度 正 逆时针/负 顺时针
	-- @both
	function SLVector.RotateNormailzedDirection(self, normalizedVector, angle)
		return SLVector.RotateByYaw(_G, Vector(0, 0, 0), angle, normalizedVector)
	end
	--- 随机获取一个点附近的点
	--
	-- @param basePoint 原点
	-- @param minRange 最小距离
	-- @param maxRange 最大距离
	-- @both
	function SLVector.PointAroundPoint(self, basePoint, minRange, maxRange)
		return basePoint:__add(
			SLVector.RotateNormailzedDirection(_G, Vector(basePoint.x, basePoint.y, 0):Normalized(), RandomInt(0, 360))
				:__mul(RandomInt(minRange, maxRange))
		)
	end
	--- 随机获取一个点附近的一组点
	--
	-- @param originVector 原点
	-- @param minRange 最小距离
	-- @param maxRange 最大距离
	-- @param isRandom 是否随机分布（默认均匀分布）
	-- @both
	function SLVector.PointsListAroundPoint(self, originVector, minRange, maxRange, count, isRandom)
		local result = {}
		local direction = SLVector.Normalized2D(_G, originVector)
		if isRandom then
			do
				local i = 0
				while i < count do
					local vec = originVector:__add(
						SLVector.RotateNormailzedDirection(_G, direction, RandomInt(0, 360))
							:__mul(RandomInt(minRange, maxRange))
					)
					result[#result + 1] = vec
					i = i + 1
				end
			end
		else
			local anglePerCount = 360 / count
			local angle = 0
			do
				local i = 0
				while i < count do
					local vec = originVector:__add(
						SLVector.RotateNormailzedDirection(_G, direction, angle):__mul(RandomInt(minRange, maxRange))
					)
					result[#result + 1] = vec
					angle = angle + anglePerCount
					i = i + 1
				end
			end
		end
		return result
	end
	--- 判断 <矩形> 是否 **被包含** 在 <圆> 内
	--
	-- @param rectCenter 矩形中心点
	-- @param rectSize 矩形大小(x 宽度, y 长度)
	-- @param circleCenter 圆的圆心
	-- @param circleRadius 圆的半径
	-- @both
	function SLVector.IsRectInCircle(self, rectCenter, rectSize, circleCenter, circleRadius)
		local rectMin = rectCenter:__sub(rectSize:__mul(0.5))
		local rectMax = rectCenter:__add(rectSize:__mul(0.5))
		local circleMin = circleCenter:__sub(Vector(circleRadius, circleRadius, 0))
		local circleMax = circleCenter:__add(Vector(circleRadius, circleRadius, 0))
		return rectMin.x < circleMax.x
			and rectMax.x > circleMin.x
			and rectMin.y < circleMax.y
			and rectMax.y > circleMin.y
	end
	--- 判断 <矩形> 是否与 <圆> 有交集
	--
	-- @param rectCenter 矩形中心点
	-- @param rectSize 矩形大小(x 宽度, y 长度)
	-- @param circleCenter 圆的圆心
	-- @param circleRadius 圆的半径
	-- @both
	function SLVector.IsRectIntersectCircle(self, rectCenter, rectSize, circleCenter, circleRadius)
		local circleDistanceX = math.abs(circleCenter.x - rectCenter.x)
		local circleDistanceY = math.abs(circleCenter.y - rectCenter.y)
		if circleDistanceX > rectSize.x / 2 + circleRadius then
			return false
		end
		if circleDistanceY > rectSize.y / 2 + circleRadius then
			return false
		end
		if circleDistanceX <= rectSize.x / 2 then
			return true
		end
		if circleDistanceY <= rectSize.y / 2 then
			return true
		end
		local cornerDistance_sq =
			bit.bxor(bit.bxor(circleDistanceX - rectSize.x / 2, 2 + (circleDistanceY - rectSize.y / 2)), 2)
		return cornerDistance_sq <= bit.bxor(circleRadius, 2)
	end
	--- 判断 <点> 是否在 <圆> 内
	--
	-- @param point 点
	-- @param circleCenter 圆心
	-- @param circleRadius 圆半径
	-- @both
	function SLVector.IsPointInCircle(self, point, circleCenter, circleRadius)
		return point:__sub(circleCenter):Length2D() <= circleRadius
	end
	--- 判断 <点> 是否在 <有方向的矩形> 内
	--
	-- @param point 点
	-- @param rectStartPosition 矩形的开始位置的中间点
	-- @param direction 矩形的方向
	-- @param width 矩形宽度(从开始位置左右各延伸 width/2)
	-- @param length 矩形长度
	-- @both
	function SLVector.IsPointInDirectionRect(self, point, rectStartPosition, direction, width, length)
		local rotate_yaw = AngleDiff(90, VectorToAngles(direction:Normalized()).y)
		local rotate_start_position = SLVector.RotateByYaw(_G, Vector(0, 0, 0), rotate_yaw, rectStartPosition)
		local min_xy = rotate_start_position:__sub(Vector(width / 2, 0, 0))
		local max_xy = rotate_start_position:__add(Vector(width / 2, length, 0))
		local rotate_point = SLVector.RotateByYaw(_G, Vector(0, 0, 0), rotate_yaw, point)
		return rotate_point.x >= min_xy.x
			and rotate_point.x <= max_xy.x
			and rotate_point.y >= min_xy.y
			and rotate_point.y <= max_xy.y
	end
	--- 判断 <圆> 是否与 <有方向的矩形> 有交集
	--
	-- @param rectStartPosition 矩形的开始点(宽度的中心)
	-- @param rectDirection 矩形的方向 从宽度中心(start)到矩形中心的方向
	-- @param rectWidth 矩形的宽度
	-- @param rectLength 矩形的长度
	-- @param circleCenter 圆的圆心
	-- @param circleRadius 圆的半径
	-- @both
	function SLVector.IsCircleIntersectDirectionRect(
		self,
		rectStartPosition,
		rectDirection,
		rectWidth,
		rectLength,
		circleCenter,
		circleRadius
	)
		local start_direction_yaw = VectorToAngles(Vector(rectDirection.x, rectDirection.y, 0)).y
		local angle_diff_yaw = AngleDiff(90, start_direction_yaw)
		local rect_start_rotated = SLVector.RotateByYaw(
			_G,
			Vector(0, 0, 0),
			angle_diff_yaw,
			Vector(rectStartPosition.x, rectStartPosition.y, 0)
		)
		local rect_center_rotated = Vector(rect_start_rotated.x, rect_start_rotated.y + rectLength * 0.5, 0)
		local circel_center_rotated =
			SLVector.RotateByYaw(_G, Vector(0, 0, 0), angle_diff_yaw, Vector(circleCenter.x, circleCenter.y, 0))
		local x_length = math.abs(
			math.max(circel_center_rotated.x, rect_center_rotated.x)
				- math.min(circel_center_rotated.x, rect_center_rotated.x)
		)
		local y_length = math.abs(
			math.max(circel_center_rotated.y, rect_center_rotated.y)
				- math.min(circel_center_rotated.y, rect_center_rotated.y)
		)
		return x_length <= circleRadius + rectWidth * 0.5 and y_length <= circleRadius + rectLength * 0.5
	end
	--- 判断点是否在 扇形 内
	--
	-- @param point 判断的点
	-- @param sectorCenter 扇形圆心
	-- @param sectorRadius 扇形半径
	-- @param sectorAngle 扇形角度
	-- @param sectorDirection 扇形方向(中间)
	-- @both
	function SLVector.IsPointInSector(self, point, sectorCenter, sectorRadius, sectorAngle, sectorDirection)
		local distance = point:__sub(sectorCenter):Length2D()
		local angle = AngleDiff(VectorToAngles(point:__sub(sectorCenter)).y, VectorToAngles(sectorDirection).y)
		return distance <= sectorRadius and math.abs(angle) <= sectorAngle / 2
	end
	--- 获取两个向量在平面上的夹角。
	-- 从 vec_1 旋转到 vec_2 的角度。
	-- 负数为逆时针旋转，且最低-180。
	-- 正数为顺时针旋转，且最高为180。
	--
	-- @param vec_1
	-- @param vec_2
	-- @param range 返回值范围。默认是0~180。
	-- @both
	function SLVector.GetAngleDiffVecter(self, vec_1, vec_2, range)
		if range == nil then
			range = "0~180"
		end
		local angle = AngleDiff(VectorToAngles(vec_1).y, VectorToAngles(vec_2).y)
		if range == "-180~180" then
			return angle
		elseif range == "0~180" then
			return math.abs(angle)
		end
	end
	--- 获取两个向量在平面上的夹角。（从 vec1 到 vec2 要旋转多少度） 按顺时针或逆顺时针计算。
	--
	-- @param vec_1
	-- @param vec_2
	-- @param clockwise 按顺时针计算？默认是true。false则按逆时针计算
	-- @returns 0~360
	-- @both
	function SLVector.GetAngleDiffVecterClockWise(self, vec_1, vec_2, clockwise)
		if clockwise == nil then
			clockwise = true
		end
		local vec_1_angle = VectorToAngles(vec_1).y
		local vec_2_angle = VectorToAngles(vec_2).y
		local diffAngle = SLVector.GetAngleDiffVecter(_G, vec_1, vec_2, "-180~180")
		if clockwise then
			if diffAngle < 0 then
				return diffAngle + 360
			else
				return diffAngle
			end
		else
			if diffAngle < 0 then
				return math.abs(diffAngle)
			else
				return 360 - diffAngle
			end
		end
	end
	--- 根据单位的朝向，获得一个偏移一定角度后，和单位有一定距离的点。
	--
	-- @param unit
	-- @param distance 距离
	-- @param angle 角度。默认0是单位的正前方。正值逆时针旋转，负值顺时针旋转，最大180
	-- @param canFindPath 是否要求找到路径。默认是false。如果为true，则会获得groundposition
	-- @both
	function SLVector.GetPointAroundPointByAngle(self, position, direction, distance, angle, canFindPath)
		if canFindPath == nil then
			canFindPath = false
		end
		local ____temp_0
		if angle > 0 then
			____temp_0 = math.min(angle, 180)
		else
			____temp_0 = math.max(angle, -180)
		end
		angle = ____temp_0
		direction = Vector(direction.x, direction.y, 0)
		local point = position + direction * distance
		point = SLVector.RotateByYaw(_G, position, angle, point)
		if canFindPath then
			point = GetGroundPosition(point, nil)
			if not GridNav:CanFindPath(point, position) or GridNav:IsBlocked(point) then
				return nil
			else
				return point
			end
		else
			return point
		end
	end
	--- 随机获取圆内的一个点(均匀分布)
	--
	-- @param center 圆心
	-- @param radius 半径
	function SLVector.GetPointAvgInCircle(self, center, radius)
		if radius <= 0 then
			return center
		end
		local theta = RandomFloat(0, 360)
		local r = RandomInt(0, radius)
		local x = r * math.cos(theta)
		local y = r * math.sin(theta)
		return Vector(center.x + x, center.y + y, center.z)
	end
end