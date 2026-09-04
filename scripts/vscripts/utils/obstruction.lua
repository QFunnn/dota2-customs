--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
--- 用 4 个 point_simple_obstruction（固定阻挡范围约 64）在正方形四象限中心各放一个，
-- 近似拼出一个正方形不可通过区域。
--
-- 约定：正方形半边长 H=64 时，4 个点相对中心偏移 (H/2, H/2)、(-H/2, H/2) 等，
-- 即 (±32, ±32)，每个点覆盖一个象限，重叠后基本盖满 128×128 正方形。
local OBSTRUCTION_HALF_OFFSET = 48
--- 正方形四象限中心相对偏移（XZ 平面，Y 为 0；Dota 中水平面为 XY，这里用 x,y 表示平面）
local SQUARE_4_OBSTRUCTION_OFFSETS = {
	Vector(OBSTRUCTION_HALF_OFFSET, OBSTRUCTION_HALF_OFFSET, 0),
	Vector(-OBSTRUCTION_HALF_OFFSET, OBSTRUCTION_HALF_OFFSET, 0),
	Vector(OBSTRUCTION_HALF_OFFSET, -OBSTRUCTION_HALF_OFFSET, 0),
	Vector(-OBSTRUCTION_HALF_OFFSET, -OBSTRUCTION_HALF_OFFSET, 0),
}
--- 在指定位置生成一个 point_simple_obstruction。
-- 用于把单个小地块近似成圆形阻挡点，适合动态机关快速启停。
local function SpawnSimpleObstruction(self, center, startEnabled)
	if startEnabled == nil then
		startEnabled = true
	end
	local groundPos = GetGroundPosition(center, nil):__add(Vector(0, 0, 10))
	local originStr = (((tostring(groundPos.x) .. " ") .. tostring(groundPos.y)) .. " ") .. tostring(groundPos.z)
	local ent = SpawnEntityFromTableSynchronous(
		"point_simple_obstruction",
		{ origin = originStr, StartDisabled = startEnabled and "0" or "1", block_fow = "0" }
	)
	if not ent then
		return nil
	end
	ent:SetAbsOrigin(groundPos)
	return ent
end
--- 在指定中心生成 4 个 point_simple_obstruction，近似拼成正方形不可通过区域（边长 128）。
--
-- @param center 正方形中心（世界坐标）
-- @param yawDeg 可选，朝向角度（度），用于旋转四个点
-- @returns 4 个 obstruction 实体，便于后续 SetEnabled / Remove
local function SpawnSquareObstructions(self, center, yawDeg)
	local result = {}
	for ____, offset in ipairs(SQUARE_4_OBSTRUCTION_OFFSETS) do
		local ____local = Vector(offset.x, offset.y, 0)
		local ____temp_0
		if yawDeg ~= nil then
			____temp_0 = RotateVector2D(nil, ____local, yawDeg)
		else
			____temp_0 = ____local
		end
		local worldOffset = ____temp_0
		local pos = center:__add(worldOffset)
		local groundPos = GetGroundPosition(pos, nil):__add(Vector(0, 0, 10))
		local originStr = (((tostring(groundPos.x) .. " ") .. tostring(groundPos.y)) .. " ") .. tostring(groundPos.z)
		local ent = SpawnEntityFromTableSynchronous(
			"point_simple_obstruction",
			{ origin = originStr, StartDisabled = "1", block_fow = "0" }
		)
		if ent then
			ent:SetAbsOrigin(groundPos)
			result[#result + 1] = ent
		end
	end
	return result
end
--- 生成一个地块级阻挡。
-- 普通失活空洞和临时墙体等整格阻挡通过动态地板接口统一调用这个入口。
-- 大面积阶段重构会额外使用外圈边界阻挡，避免框外每个地块都生成 obstruction。
local function SpawnTileObstructions(self, center, options)
	local mode = options and options.mode or "square4"
	local ____temp_8
	if mode == "single" then
		local ____SpawnSimpleObstruction_7 = SpawnSimpleObstruction
		local ____center_6 = center
		local ____temp_5 = options and options.startEnabled
		if ____temp_5 == nil then
			____temp_5 = true
		end
		____temp_8 = ____SpawnSimpleObstruction_7(nil, ____center_6, ____temp_5)
	else
		____temp_8 = nil
	end
	local simpleObstruction = ____temp_8
	local ____simpleObstruction_11
	if simpleObstruction then
		____simpleObstruction_11 = { simpleObstruction }
	else
		____simpleObstruction_11 = SpawnSquareObstructions(nil, center, options and options.yawDeg)
	end
	local obstructions = ____simpleObstruction_11
	local ____temp_14 = options and options.startEnabled
	if ____temp_14 == nil then
		____temp_14 = true
	end
	if ____temp_14 then
		for ____, obstruction in ipairs(obstructions) do
			if IsValid(nil, obstruction) then
				obstruction:SetEnabled(true, false)
			end
		end
	end
	return obstructions
end
____exports.SQUARE_4_OBSTRUCTION_OFFSETS = SQUARE_4_OBSTRUCTION_OFFSETS
____exports.SpawnSimpleObstruction = SpawnSimpleObstruction
____exports.SpawnSquareObstructions = SpawnSquareObstructions
____exports.SpawnTileObstructions = SpawnTileObstructions
return ____exports