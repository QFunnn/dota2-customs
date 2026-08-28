--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
SLDebugDraw = SLDebugDraw or {}
do
	--- 快速画线, 颜色 红, 无zbuffer深度, 持续时间0.5
	--
	-- @param start_point
	-- @param end_point
	-- @both
	function SLDebugDraw.FastLine(self, start_point, end_point)
		if not IsInToolsMode() then
			return
		end
		DebugDrawLine(start_point, end_point, 255, 0, 0, false, 0.5)
	end
	--- 快速画圆, 颜色 红, 透明度(100/255), 无zbuffer深度, 持续时间0.5
	--
	-- @param center 圆心
	-- @param radius 半径
	-- @both
	function SLDebugDraw.FastCircle(self, center, radius)
		if not IsInToolsMode() then
			return
		end
		DebugDrawCircle(center, Vector(255, 0, 0), 100, radius, false, 0.5)
	end
	--- debug 画圆
	--
	-- @param center 圆心
	-- @param radius 半径
	-- @param a 透明度(0-255)
	-- @param ztest 是否检测z深度 默认为 true
	-- @param color 颜色 默认 白色
	-- @param duration 持续时间 默认 0.5
	-- @both
	function SLDebugDraw.Circle(self, center, radius, a, ztest, color, duration)
		if a == nil then
			a = 50
		end
		if ztest == nil then
			ztest = true
		end
		if color == nil then
			color = Vector(255, 255, 255)
		end
		if duration == nil then
			duration = 0.5
		end
		if not IsInToolsMode() then
			return
		end
		DebugDrawCircle(center, color, a, radius, ztest, duration)
	end
	--- debug 画矩形
	--
	-- @param start_center_point 矩形边长上, 开始方向的中心点
	-- @param forward_direction 矩形从开始中心点到中心点的单位向量方向
	-- @param forward_length 向前方向边长的长度
	-- @param vertical_length 与向前方向垂直的另一个边长的长度
	-- @param ztest 知否检查z深度 默认true
	-- @param color 颜色 范围(0-255) 默认白色
	-- @param duration 持续时间 默认0.5
	-- @both
	function SLDebugDraw.Rect(
		self,
		start_center_point,
		forward_direction,
		forward_length,
		vertical_length,
		ztest,
		color,
		duration
	)
		if ztest == nil then
			ztest = true
		end
		if color == nil then
			color = Vector(255, 255, 255)
		end
		if duration == nil then
			duration = 0.5
		end
		if not IsInToolsMode() then
			return
		end
		local direction_cross = forward_direction:Cross(Vector(0, 0, 1)):Normalized()
		local base_wid_len = direction_cross:__mul(vertical_length / 2)
		local base_len_len = forward_direction:__mul(forward_length)
		local v_d_l = start_center_point:__add(base_wid_len)
		local v_d_r = start_center_point:__sub(base_wid_len)
		local v_t_l = v_d_l:__add(base_len_len)
		local v_t_r = v_d_r:__add(base_len_len)
		DebugDrawLine(v_d_l, v_d_r, color.x, color.y, color.z, false, duration)
		DebugDrawLine(v_t_l, v_t_r, color.x, color.y, color.z, false, duration)
		DebugDrawLine(v_d_l, v_t_l, color.x, color.y, color.z, false, duration)
		DebugDrawLine(v_d_r, v_t_r, color.x, color.y, color.z, false, duration)
	end
	--- 测试画扇形
	--
	-- @param origin 圆心
	-- @param center_direction 方向 中间位置
	-- @param angle 左右角度
	-- @param radius 半径
	-- @param precision_count 圆边的粒度(由多少条直线组成)
	-- @param duration 扇形持续时间 默认为1
	-- @param ztest 是否检查z深度, 默认为true
	-- @both
	function SLDebugDraw.Sector(self, origin, center_direction, angle, radius, precision_count, duration, ztest, rgb)
		if duration == nil then
			duration = 1
		end
		if ztest == nil then
			ztest = true
		end
		if not IsInToolsMode() then
			return
		end
		angle = math.abs(angle)
		local ____rgb_0
		if rgb then
			____rgb_0 = rgb.x
		else
			____rgb_0 = RandomInt(0, 255)
		end
		local r = ____rgb_0
		local ____rgb_1
		if rgb then
			____rgb_1 = rgb.y
		else
			____rgb_1 = RandomInt(0, 255)
		end
		local g = ____rgb_1
		local ____rgb_2
		if rgb then
			____rgb_2 = rgb.z
		else
			____rgb_2 = RandomInt(0, 255)
		end
		local b = ____rgb_2
		DebugDrawCircle(origin, Vector(r, g, b), RandomInt(0, 100), 10, ztest, duration)
		local left_target_vec = SLVector:RotateByYaw(Vector(0, 0, 0), angle / 2, center_direction:Normalized())
			:__mul(radius)
		local right_target_vec = SLVector:RotateByYaw(Vector(0, 0, 0), -angle / 2, center_direction:Normalized())
			:__mul(radius)
		DebugDrawLine(origin, origin:__add(right_target_vec), r, g, b, ztest, duration)
		DebugDrawLine(origin, origin:__add(left_target_vec), r, g, b, ztest, duration)
		local single_angle = angle / precision_count
		local length = math.abs(math.sin(single_angle / 360 * math.pi)) * radius * 2
		local start_point = origin:__add(right_target_vec)
		local circle_direction = right_target_vec:Cross(Vector(0, 0, -1))
		do
			local index = 0
			while index < precision_count do
				local target_point = start_point:__add(
					SLVector:RotateByYaw(Vector(0, 0, 0), single_angle * 0.5, circle_direction:Normalized())
						:__mul(length)
				)
				DebugDrawLine(start_point, target_point, r, g, b, ztest, duration)
				start_point = SLVector:RotateByYaw(origin, single_angle, start_point)
				circle_direction = SLVector:RotateByYaw(Vector(0, 0, 0), single_angle, circle_direction)
				index = index + 1
			end
		end
	end
	--- 画多边形
	--
	-- @param points 多边形的顶点数组
	-- @param ztest 是否检查z深度, 默认为true
	-- @param color 多边形的颜色, 默认为白色
	-- @param duration 多边形持续时间, 默认为0.5
	function SLDebugDraw.Polygon(self, points, ztest, color, duration)
		if ztest == nil then
			ztest = true
		end
		if color == nil then
			color = Vector(255, 255, 255)
		end
		if duration == nil then
			duration = 0.5
		end
		if not IsInToolsMode() then
			return
		end
		do
			local i = 0
			while i < #points do
				local start = points[i + 1]
				local ____end = points[(i + 1) % #points + 1]
				DebugDrawLine(start, ____end, color.x, color.y, color.z, ztest, duration)
				i = i + 1
			end
		end
	end
end