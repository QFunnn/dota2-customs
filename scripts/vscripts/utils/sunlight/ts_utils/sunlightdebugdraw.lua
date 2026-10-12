--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/sunlight/ts_utils/SunLightDebugDraw.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
____debugRuntime.register(
	"utils/sunlight/ts_utils/SunLightDebugDraw.lua",
	{
		["6"] = "4:11",
		["13"] = "11:5",
		["14"] = "12:14",
		["17"] = "13:9",
		["18"] = "13:23",
		["19"] = "13:36",
		["20"] = "13:47",
		["21"] = "13:52",
		["22"] = "13:55",
		["23"] = "13:58",
		["24"] = "13:65",
		["25"] = "13:9",
		["26"] = "11:5",
		["32"] = "22:5",
		["33"] = "23:14",
		["36"] = "24:9",
		["37"] = "24:25",
		["38"] = "24:33",
		["39"] = "24:52",
		["40"] = "24:57",
		["41"] = "24:65",
		["42"] = "24:72",
		["43"] = "24:9",
		["44"] = "22:5",
		["54"] = "37:5",
		["55"] = "37:60",
		["56"] = "37:60",
		["58"] = "37:68",
		["59"] = "37:68",
		["61"] = "37:82",
		["62"] = "37:82",
		["64"] = "37:113",
		["65"] = "37:113",
		["67"] = "38:14",
		["70"] = "39:9",
		["71"] = "39:25",
		["72"] = "39:33",
		["73"] = "39:40",
		["74"] = "39:43",
		["75"] = "39:51",
		["76"] = "39:58",
		["77"] = "39:9",
		["78"] = "37:5",
		["89"] = "53:5",
		["90"] = "58:9",
		["91"] = "58:9",
		["93"] = "59:9",
		["94"] = "59:9",
		["96"] = "60:9",
		["97"] = "60:9",
		["99"] = "62:14",
		["102"] = "63:15",
		["103"] = "64:15",
		["104"] = "65:15",
		["105"] = "67:15",
		["106"] = "68:15",
		["107"] = "69:15",
		["108"] = "70:15",
		["109"] = "72:9",
		["110"] = "72:23",
		["111"] = "72:30",
		["112"] = "72:37",
		["113"] = "72:46",
		["114"] = "72:55",
		["115"] = "72:64",
		["116"] = "72:71",
		["117"] = "72:9",
		["118"] = "73:9",
		["119"] = "73:23",
		["120"] = "73:30",
		["121"] = "73:37",
		["122"] = "73:46",
		["123"] = "73:55",
		["124"] = "73:64",
		["125"] = "73:71",
		["126"] = "73:9",
		["127"] = "74:9",
		["128"] = "74:23",
		["129"] = "74:30",
		["130"] = "74:37",
		["131"] = "74:46",
		["132"] = "74:55",
		["133"] = "74:64",
		["134"] = "74:71",
		["135"] = "74:9",
		["136"] = "75:9",
		["137"] = "75:23",
		["138"] = "75:30",
		["139"] = "75:37",
		["140"] = "75:46",
		["141"] = "75:55",
		["142"] = "75:64",
		["143"] = "75:71",
		["144"] = "75:9",
		["145"] = "53:5",
		["156"] = "89:5",
		["157"] = "95:9",
		["158"] = "95:9",
		["160"] = "96:9",
		["161"] = "96:9",
		["163"] = "99:14",
		["166"] = "100:9",
		["167"] = "101:19",
		["168"] = "101:19",
		["169"] = "101:25",
		["171"] = "101:33",
		["173"] = "101:15",
		["174"] = "102:19",
		["175"] = "102:19",
		["176"] = "102:25",
		["178"] = "102:33",
		["180"] = "102:15",
		["181"] = "103:19",
		["182"] = "103:19",
		["183"] = "103:25",
		["185"] = "103:33",
		["187"] = "103:15",
		["188"] = "105:9",
		["189"] = "105:25",
		["190"] = "105:33",
		["191"] = "105:50",
		["192"] = "105:69",
		["193"] = "105:73",
		["194"] = "105:80",
		["195"] = "105:9",
		["196"] = "108:15",
		["197"] = "108:54",
		["198"] = "108:71",
		["199"] = "108:82",
		["200"] = "108:33",
		["201"] = "110:15",
		["202"] = "110:55",
		["203"] = "110:73",
		["204"] = "110:84",
		["205"] = "110:34",
		["206"] = "112:9",
		["207"] = "112:23",
		["208"] = "112:31",
		["209"] = "112:63",
		["210"] = "112:66",
		["211"] = "112:69",
		["212"] = "112:72",
		["213"] = "112:79",
		["214"] = "112:9",
		["215"] = "114:9",
		["216"] = "114:23",
		["217"] = "114:31",
		["218"] = "114:62",
		["219"] = "114:65",
		["220"] = "114:68",
		["221"] = "114:71",
		["222"] = "114:78",
		["223"] = "114:9",
		["224"] = "116:15",
		["225"] = "118:15",
		["226"] = "119:13",
		["227"] = "120:13",
		["229"] = "121:18",
		["230"] = "121:29",
		["231"] = "122:19",
		["232"] = "124:38",
		["233"] = "124:55",
		["234"] = "124:75",
		["235"] = "124:17",
		["236"] = "126:13",
		["237"] = "126:27",
		["238"] = "126:40",
		["239"] = "126:54",
		["240"] = "126:57",
		["241"] = "126:60",
		["242"] = "126:63",
		["243"] = "126:70",
		["244"] = "126:13",
		["245"] = "128:13",
		["246"] = "129:13",
		["247"] = "129:53",
		["248"] = "129:70",
		["249"] = "129:84",
		["250"] = "129:32",
		["251"] = "121:54",
		["254"] = "89:5",
		["261"] = "140:5",
		["262"] = "140:47",
		["263"] = "140:47",
		["265"] = "140:61",
		["266"] = "140:61",
		["268"] = "140:92",
		["269"] = "140:92",
		["271"] = "141:14",
		["275"] = "142:18",
		["276"] = "142:25",
		["277"] = "143:19",
		["278"] = "144:19",
		["279"] = "145:13",
		["280"] = "145:27",
		["281"] = "145:34",
		["282"] = "145:39",
		["283"] = "145:48",
		["284"] = "145:57",
		["285"] = "145:66",
		["286"] = "145:73",
		["287"] = "145:13",
		["288"] = "142:44",
		["291"] = "140:5",
	}
)
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