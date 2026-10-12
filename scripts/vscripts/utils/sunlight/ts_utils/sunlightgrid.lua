--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/sunlight/ts_utils/SunLightGrid.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
____debugRuntime.register(
	"utils/sunlight/ts_utils/SunLightGrid.lua",
	{
		["7"] = "1:11",
		["13"] = "7:5",
		["14"] = "7:69",
		["15"] = "7:69",
		["17"] = "8:15",
		["18"] = "9:15",
		["19"] = "10:15",
		["20"] = "11:15",
		["21"] = "12:9",
		["22"] = "12:9",
		["23"] = "12:30",
		["24"] = "13:19",
		["25"] = "14:19",
		["26"] = "15:19",
		["27"] = "16:19",
		["28"] = "17:19",
		["29"] = "18:17",
		["30"] = "19:17",
		["32"] = "12:30",
		["33"] = "12:9",
		["34"] = "22:15",
		["36"] = "23:18",
		["37"] = "23:25",
		["38"] = "24:19",
		["39"] = "25:19",
		["40"] = "26:19",
		["41"] = "27:17",
		["42"] = "28:17",
		["45"] = "23:35",
		["48"] = "32:9",
		["49"] = "7:5",
		["56"] = "42:5",
		["57"] = "43:17",
		["58"] = "43:17",
		["59"] = "43:29",
		["61"] = "43:52",
		["63"] = "43:9",
		["64"] = "44:13",
		["65"] = "45:9",
		["66"] = "46:13",
		["67"] = "47:9",
		["68"] = "47:38",
		["69"] = "47:59",
		["70"] = "47:66",
		["71"] = "47:17",
		["72"] = "48:14",
		["73"] = "48:34",
		["74"] = "48:41",
		["75"] = "48:14",
		["76"] = "50:13",
		["78"] = "52:13",
		["80"] = "42:5",
		["86"] = "62:5",
		["87"] = "63:13",
		["88"] = "64:14",
		["89"] = "65:19",
		["90"] = "66:19",
		["92"] = "67:22",
		["93"] = "67:41",
		["95"] = "68:26",
		["96"] = "68:37",
		["97"] = "69:27",
		["98"] = "69:55",
		["99"] = "69:76",
		["100"] = "69:81",
		["101"] = "69:89",
		["102"] = "69:55",
		["103"] = "69:144",
		["104"] = "69:37",
		["105"] = "70:25",
		["106"] = "71:25",
		["109"] = "68:50",
		["112"] = "75:21",
		["115"] = "67:66",
		["118"] = "77:13",
		["120"] = "79:13",
		["122"] = "62:5",
	}
)
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