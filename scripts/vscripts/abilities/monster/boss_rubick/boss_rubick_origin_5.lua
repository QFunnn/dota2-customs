--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____base_rubick_origin_ability = require("abilities.monster.boss_rubick.base_rubick_origin_ability")
local RubickOriginAbility = ____base_rubick_origin_ability.RubickOriginAbility
--- 技能最大索敌距离。
local RUBICK_ORIGIN_5_CAST_RANGE = 3000
--- 墙体抬起前的预警时间。
local RUBICK_ORIGIN_5_WARNING_DURATION = 0.8
--- 局部墙体覆盖的长度。
local RUBICK_ORIGIN_5_ROW_COUNT = 5
--- 两侧墙体抬起高度。
local RUBICK_ORIGIN_5_WALL_HEIGHT = 220
--- 两侧墙体抬起动画时长。
local RUBICK_ORIGIN_5_LIFT_DURATION = 0.28
--- 两侧墙体抬起完成后的停顿时间。
local RUBICK_ORIGIN_5_LIFT_HOLD_DURATION = 0.08
--- 两侧墙体向外慢拉蓄力的距离占半格距离的比例。
local RUBICK_ORIGIN_5_WINDUP_DISTANCE_RATIO = 0.35
--- 两侧墙体向外慢拉蓄力的时间。
local RUBICK_ORIGIN_5_WINDUP_DURATION = 0.32
--- 蓄力末端单次细小抖动的时间。
local RUBICK_ORIGIN_5_WINDUP_SHAKE_DURATION = 0.06
--- 蓄力末端细小抖动的次数。
local RUBICK_ORIGIN_5_WINDUP_SHAKE_COUNT = 2
--- 蓄力末端抖动距离占半格距离的比例。
local RUBICK_ORIGIN_5_WINDUP_SHAKE_DISTANCE_RATIO = 0.08
--- 两侧墙体向中列加速合拢的动画时长。
local RUBICK_ORIGIN_5_CLAMP_DURATION = 0.055
--- 两侧墙体夹击后的停顿时间。
local RUBICK_ORIGIN_5_CLAMP_HOLD_DURATION = 0.35
--- 两侧墙体回到原列的动画时长。
local RUBICK_ORIGIN_5_RETURN_DURATION = 0.3
--- 两侧墙体落回地面的动画时长。
local RUBICK_ORIGIN_5_RELEASE_DURATION = 0.32
--- 单位被推到相邻格子的运动时长。
local RUBICK_ORIGIN_5_PUSH_DURATION = 0.28
--- 单位被推到相邻格子时的抛物线高度。
local RUBICK_ORIGIN_5_PUSH_HEIGHT = 220
--- 中列被夹击时受到的怪物伤害倍率。
local RUBICK_ORIGIN_5_CLAMP_DAMAGE_RATE = 20
--- 中列被夹击时附加的眩晕时间。
local RUBICK_ORIGIN_5_CLAMP_STUN_DURATION = 0.8
--- 墙体阻挡点相对墙体中心的高度。
local RUBICK_ORIGIN_5_OBSTRUCTION_Z = 96
--- 方块预警使用的粒子路径。
local RUBICK_ORIGIN_5_WARNING_PARTICLE = "particles/rebuild/spell/rubick_boss/cube_aura/effect_flame/effect.vpcf"
--- 从演出开始到墙体完成抬起的延迟。
local RUBICK_ORIGIN_5_LIFT_DONE_DELAY = RUBICK_ORIGIN_5_LIFT_DURATION
--- 两侧墙体完成拉弦蓄力所需总时间。
local RUBICK_ORIGIN_5_WINDUP_TOTAL_DURATION = RUBICK_ORIGIN_5_WINDUP_DURATION
	+ RUBICK_ORIGIN_5_WINDUP_SHAKE_DURATION * RUBICK_ORIGIN_5_WINDUP_SHAKE_COUNT * 2
--- 从演出开始到夹击命中的延迟。
local RUBICK_ORIGIN_5_CLAMP_HIT_DELAY = RUBICK_ORIGIN_5_LIFT_DURATION
	+ RUBICK_ORIGIN_5_LIFT_HOLD_DURATION
	+ RUBICK_ORIGIN_5_WINDUP_TOTAL_DURATION
	+ RUBICK_ORIGIN_5_CLAMP_DURATION
--- 技能开始后的总演出时长。
local RUBICK_ORIGIN_5_CAST_DURATION = RUBICK_ORIGIN_5_LIFT_DURATION
	+ RUBICK_ORIGIN_5_LIFT_HOLD_DURATION
	+ RUBICK_ORIGIN_5_WINDUP_TOTAL_DURATION
	+ RUBICK_ORIGIN_5_CLAMP_DURATION
	+ RUBICK_ORIGIN_5_CLAMP_HOLD_DURATION
	+ RUBICK_ORIGIN_5_RETURN_DURATION
	+ RUBICK_ORIGIN_5_RELEASE_DURATION
--- 拉比克原始技能五：魔方夹墙。
--
-- 技能形态：
-- 1. 锁定目标脚下地块，生成 3 列 x 5 格的局部区域。
-- 2. 第 1 列和第 3 列先预警并抬起成墙，抬起时会阻挡移动。
-- 3. 两侧墙体抬起时，站在墙列上的单位会被推到中间第 2 列。
-- 4. 两侧墙体随后向中间第 2 列靠拢，挤压中列单位并造成伤害和眩晕。
-- 5. 当前版本使用阻挡组件和 FindClearSpaceForUnit 处理不可通行位置，不额外管理缺失地块状态。
____exports.boss_rubick_origin_5 = __TS__Class()
local boss_rubick_origin_5 = ____exports.boss_rubick_origin_5
boss_rubick_origin_5.name = "boss_rubick_origin_5"
__TS__ClassExtends(boss_rubick_origin_5, RubickOriginAbility)
function boss_rubick_origin_5.prototype.____constructor(self, ...)
	RubickOriginAbility.prototype.____constructor(self, ...)
	self.castToken = 0
	self.warningParticles = {}
	self.wallObstructions = {}
	self.clampedUnits = {}
end
function boss_rubick_origin_5.prototype.Precache(self, context)
	PrecacheResource("particle", RUBICK_ORIGIN_5_WARNING_PARTICLE, context)
end
function boss_rubick_origin_5.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = RUBICK_ORIGIN_5_CAST_RANGE,
		castPoint = RUBICK_ORIGIN_5_WARNING_DURATION,
		castDuration = RUBICK_ORIGIN_5_CAST_DURATION,
		canCast = function()
			local target = self:GetCaster():GetMinDistanceUnit(RUBICK_ORIGIN_5_CAST_RANGE)
			if not MyGameDynamicFloor or not IsValidAlive(nil, target) then
				return UF_FAIL_CUSTOM
			end
			local ____table_GetUnitTile_result_0
			if self:GetUnitTile(target) then
				____table_GetUnitTile_result_0 = UF_SUCCESS
			else
				____table_GetUnitTile_result_0 = UF_FAIL_CUSTOM
			end
			return ____table_GetUnitTile_result_0
		end,
		OnPhaseStart = function()
			self.castToken = self.castToken + 1
			self:PrepareClamp()
		end,
		OnStart = function()
			return self:StartClamp(self.castToken)
		end,
		OnInterrupt = function()
			self.castToken = self.castToken + 1
			self:ClearWarnings()
			self:ClearWallObstructions()
		end,
		OnFinish = function()
			self:ClearWarnings()
			self:ClearWallObstructions()
		end,
	}
end
function boss_rubick_origin_5.prototype.PrepareClamp(self)
	local caster = self:GetCaster()
	local target = caster:GetMinDistanceUnit(RUBICK_ORIGIN_5_CAST_RANGE)
	self:ClearWarnings()
	self:ClearWallObstructions()
	self.clampedUnits = {}
	self.lanes = nil
	self.lockedRoomId = nil
	if not IsValidAlive(nil, target) then
		return
	end
	local centerTile = self:GetUnitTile(target)
	if not centerTile then
		return
	end
	caster:LockTargetForSpeed(target, RUBICK_ORIGIN_5_WARNING_DURATION, 4)
	local ____opt_1 = target.GetRoomId
	self.lockedRoomId = ____opt_1 and ____opt_1(target)
	self.lanes = self:BuildLanes(caster, target, centerTile)
	local ____array_3 = __TS__SparseArrayNew(unpack(self.lanes.left))
	__TS__SparseArrayPush(____array_3, unpack(self.lanes.center))
	__TS__SparseArrayPush(____array_3, unpack(self.lanes.right))
	for ____, tile in ipairs({ __TS__SparseArraySpread(____array_3) }) do
		self:PlayTileWarning(tile)
	end
end
function boss_rubick_origin_5.prototype.StartClamp(self, token)
	self:ClearWarnings()
	local lanes = self.lanes
	if token ~= self.castToken or not lanes or not MyGameDynamicFloor then
		return
	end
	if #lanes.center <= 0 then
		return
	end
	local sideOffset =
		Vector(lanes.sideDirection.dx * lanes.center[1].radius, lanes.sideDirection.dy * lanes.center[1].radius, 0)
	local windupOffset = sideOffset:__mul(RUBICK_ORIGIN_5_WINDUP_DISTANCE_RATIO)
	local leftLiftOffset = Vector(0, 0, RUBICK_ORIGIN_5_WALL_HEIGHT)
	local rightLiftOffset = Vector(0, 0, RUBICK_ORIGIN_5_WALL_HEIGHT)
	self:MoveLane(lanes.left, leftLiftOffset, RUBICK_ORIGIN_5_LIFT_DURATION, "easeOut")
	self:MoveLane(lanes.right, rightLiftOffset, RUBICK_ORIGIN_5_LIFT_DURATION, "easeOut")
	SysTimers:CreateTimer(RUBICK_ORIGIN_5_LIFT_DONE_DELAY, function()
		if token ~= self.castToken then
			return nil
		end
		local ____self_CreateWallObstructions_5 = self.CreateWallObstructions
		local ____array_4 = __TS__SparseArrayNew(unpack(lanes.left))
		__TS__SparseArrayPush(____array_4, unpack(lanes.right))
		____self_CreateWallObstructions_5(self, { __TS__SparseArraySpread(____array_4) })
		self:PushUnitsFromSideLanes(lanes)
		return nil
	end)
	SysTimers:CreateTimer(RUBICK_ORIGIN_5_LIFT_DONE_DELAY + RUBICK_ORIGIN_5_LIFT_HOLD_DURATION, function()
		if token ~= self.castToken then
			return nil
		end
		self:MoveLane(lanes.left, leftLiftOffset:__sub(windupOffset), RUBICK_ORIGIN_5_WINDUP_DURATION, "smooth")
		self:MoveLane(lanes.right, rightLiftOffset:__add(windupOffset), RUBICK_ORIGIN_5_WINDUP_DURATION, "smooth")
		self:MoveWallObstructions(lanes.left, windupOffset:__mul(-1), RUBICK_ORIGIN_5_WINDUP_DURATION, "smooth")
		self:MoveWallObstructions(lanes.right, windupOffset, RUBICK_ORIGIN_5_WINDUP_DURATION, "smooth")
		self:ScheduleWindupShake(token, lanes, leftLiftOffset, rightLiftOffset, sideOffset, windupOffset)
		return nil
	end)
	SysTimers:CreateTimer(
		RUBICK_ORIGIN_5_LIFT_DONE_DELAY + RUBICK_ORIGIN_5_LIFT_HOLD_DURATION + RUBICK_ORIGIN_5_WINDUP_TOTAL_DURATION,
		function()
			if token ~= self.castToken then
				return nil
			end
			self:MoveLane(lanes.left, leftLiftOffset:__add(sideOffset), RUBICK_ORIGIN_5_CLAMP_DURATION, "easeIn")
			self:MoveLane(lanes.right, rightLiftOffset:__sub(sideOffset), RUBICK_ORIGIN_5_CLAMP_DURATION, "easeIn")
			self:MoveWallObstructions(lanes.left, sideOffset, RUBICK_ORIGIN_5_CLAMP_DURATION, "easeIn")
			self:MoveWallObstructions(lanes.right, sideOffset:__mul(-1), RUBICK_ORIGIN_5_CLAMP_DURATION, "easeIn")
			return nil
		end
	)
	SysTimers:CreateTimer(RUBICK_ORIGIN_5_CLAMP_HIT_DELAY, function()
		if token ~= self.castToken then
			return nil
		end
		self:PushUnitsFromCenterLane(lanes)
		return nil
	end)
	SysTimers:CreateTimer(RUBICK_ORIGIN_5_CLAMP_HIT_DELAY + RUBICK_ORIGIN_5_CLAMP_HOLD_DURATION, function()
		if token ~= self.castToken then
			return nil
		end
		self:MoveLane(lanes.left, leftLiftOffset, RUBICK_ORIGIN_5_RETURN_DURATION, "smooth")
		self:MoveLane(lanes.right, rightLiftOffset, RUBICK_ORIGIN_5_RETURN_DURATION, "smooth")
		self:MoveWallObstructions(lanes.left, Vector(0, 0, 0), RUBICK_ORIGIN_5_RETURN_DURATION, "smooth")
		self:MoveWallObstructions(lanes.right, Vector(0, 0, 0), RUBICK_ORIGIN_5_RETURN_DURATION, "smooth")
		self:ClearClampedUnitsAfterReturn()
		return nil
	end)
	SysTimers:CreateTimer(
		RUBICK_ORIGIN_5_CLAMP_HIT_DELAY + RUBICK_ORIGIN_5_CLAMP_HOLD_DURATION + RUBICK_ORIGIN_5_RETURN_DURATION,
		function()
			if token ~= self.castToken then
				return nil
			end
			self:ClearWallObstructions()
			self:MoveLane(lanes.left, Vector(0, 0, 0), RUBICK_ORIGIN_5_RELEASE_DURATION, "smooth")
			self:MoveLane(lanes.right, Vector(0, 0, 0), RUBICK_ORIGIN_5_RELEASE_DURATION, "smooth")
			return nil
		end
	)
end
function boss_rubick_origin_5.prototype.ScheduleWindupShake(
	self,
	token,
	lanes,
	leftLiftOffset,
	rightLiftOffset,
	sideOffset,
	windupOffset
)
	local shakeOffset = sideOffset:__mul(RUBICK_ORIGIN_5_WINDUP_SHAKE_DISTANCE_RATIO)
	do
		local index = 0
		while index < RUBICK_ORIGIN_5_WINDUP_SHAKE_COUNT do
			local shakeOutDelay = RUBICK_ORIGIN_5_WINDUP_DURATION + index * RUBICK_ORIGIN_5_WINDUP_SHAKE_DURATION * 2
			local shakeBackDelay = shakeOutDelay + RUBICK_ORIGIN_5_WINDUP_SHAKE_DURATION
			SysTimers:CreateTimer(shakeOutDelay, function()
				if token ~= self.castToken then
					return nil
				end
				local leftOffset = leftLiftOffset:__sub(windupOffset):__sub(shakeOffset)
				local rightOffset = rightLiftOffset:__add(windupOffset):__add(shakeOffset)
				self:MoveLane(lanes.left, leftOffset, RUBICK_ORIGIN_5_WINDUP_SHAKE_DURATION, "easeOut")
				self:MoveLane(lanes.right, rightOffset, RUBICK_ORIGIN_5_WINDUP_SHAKE_DURATION, "easeOut")
				self:MoveWallObstructions(
					lanes.left,
					windupOffset:__add(shakeOffset):__mul(-1),
					RUBICK_ORIGIN_5_WINDUP_SHAKE_DURATION,
					"easeOut"
				)
				self:MoveWallObstructions(
					lanes.right,
					windupOffset:__add(shakeOffset),
					RUBICK_ORIGIN_5_WINDUP_SHAKE_DURATION,
					"easeOut"
				)
				return nil
			end)
			SysTimers:CreateTimer(shakeBackDelay, function()
				if token ~= self.castToken then
					return nil
				end
				self:MoveLane(
					lanes.left,
					leftLiftOffset:__sub(windupOffset),
					RUBICK_ORIGIN_5_WINDUP_SHAKE_DURATION,
					"easeIn"
				)
				self:MoveLane(
					lanes.right,
					rightLiftOffset:__add(windupOffset),
					RUBICK_ORIGIN_5_WINDUP_SHAKE_DURATION,
					"easeIn"
				)
				self:MoveWallObstructions(
					lanes.left,
					windupOffset:__mul(-1),
					RUBICK_ORIGIN_5_WINDUP_SHAKE_DURATION,
					"easeIn"
				)
				self:MoveWallObstructions(lanes.right, windupOffset, RUBICK_ORIGIN_5_WINDUP_SHAKE_DURATION, "easeIn")
				return nil
			end)
			index = index + 1
		end
	end
end
function boss_rubick_origin_5.prototype.BuildLanes(self, caster, target, centerTile)
	local forward = self:GetDirectionFromCasterToTarget(caster, target)
	local side = { dx = -forward.dy, dy = forward.dx }
	local halfLength = math.floor(RUBICK_ORIGIN_5_ROW_COUNT / 2)
	local left = {}
	local center = {}
	local right = {}
	do
		local step = -halfLength
		while step <= halfLength do
			local baseColumn = centerTile.gridColumn + forward.dx * step
			local baseRow = centerTile.gridRow + forward.dy * step
			local leftTile = self:GetTileByGrid(centerTile.floorId, baseColumn - side.dx, baseRow - side.dy)
			local centerLaneTile = self:GetTileByGrid(centerTile.floorId, baseColumn, baseRow)
			local rightTile = self:GetTileByGrid(centerTile.floorId, baseColumn + side.dx, baseRow + side.dy)
			if leftTile and centerLaneTile and rightTile then
				left[#left + 1] = leftTile
				center[#center + 1] = centerLaneTile
				right[#right + 1] = rightTile
			end
			step = step + 1
		end
	end
	return { left = left, center = center, right = right, sideDirection = side }
end
function boss_rubick_origin_5.prototype.MoveLane(self, tiles, offset, duration, motion)
	if #tiles <= 0 or not MyGameDynamicFloor then
		return
	end
	MyGameDynamicFloor:MoveTilesToWorldOffsets(tiles[1].floorId, {
		tiles = __TS__ArrayMap(tiles, function(____, tile)
			return { gridColumn = tile.gridColumn, gridRow = tile.gridRow, offset = offset }
		end),
		duration = duration,
		motion = motion,
	})
end
function boss_rubick_origin_5.prototype.CreateWallObstructions(self, tiles)
	self:ClearWallObstructions()
	if not MyGameDynamicFloor then
		return
	end
	for ____, tile in ipairs(tiles) do
		local obstructions = MyGameDynamicFloor:SpawnTileObstructions(
			tile.floorId,
			{
				tiles = {
					{
						gridColumn = tile.gridColumn,
						gridRow = tile.gridRow,
						offset = Vector(0, 0, RUBICK_ORIGIN_5_OBSTRUCTION_Z),
					},
				},
			}
		)
		if #obstructions > 0 then
			local ____self_wallObstructions_6 = self.wallObstructions
			____self_wallObstructions_6[#____self_wallObstructions_6 + 1] =
				{ obstructions = obstructions, origin = tile.origin }
		end
	end
end
function boss_rubick_origin_5.prototype.ClearWallObstructions(self)
	for ____, record in ipairs(self.wallObstructions) do
		for ____, obstruction in ipairs(record.obstructions) do
			if IsValid(nil, obstruction) then
				obstruction:RemoveSelf()
			end
		end
	end
	self.wallObstructions = {}
end
function boss_rubick_origin_5.prototype.MoveWallObstructions(self, tiles, offset, duration, motion)
	for ____, tile in ipairs(tiles) do
		local records = __TS__ArrayFilter(self.wallObstructions, function(____, record)
			return GetDistance(nil, record.origin, tile.origin) <= 1
		end)
		for ____, record in ipairs(records) do
			self:AnimateWallObstruction(record, offset, duration, motion)
		end
	end
end
function boss_rubick_origin_5.prototype.AnimateWallObstruction(self, record, offset, duration, motion)
	local starts = __TS__ArrayMap(record.obstructions, function(____, obstruction)
		local ____temp_7
		if IsValid(nil, obstruction) and IsValidEntity(obstruction) then
			____temp_7 = obstruction:GetAbsOrigin()
		else
			____temp_7 = record.origin
		end
		return ____temp_7
	end)
	local targetCenter = record.origin:__add(offset):__add(Vector(0, 0, RUBICK_ORIGIN_5_OBSTRUCTION_Z))
	local currentCenter = self:GetObstructionGroupCenter(record.obstructions, targetCenter)
	local targetDelta = targetCenter:__sub(currentCenter)
	local startTime = GameRules:GetGameTime()
	local safeDuration = math.max(0.03, duration)
	SysTimers:CreateTimer(0, function()
		local elapsed = GameRules:GetGameTime() - startTime
		local progress = math.min(1, elapsed / safeDuration)
		local eased = self:GetEaseProgress(progress, motion)
		do
			local index = 0
			while index < #record.obstructions do
				do
					local obstruction = record.obstructions[index + 1]
					if not IsValid(nil, obstruction) or not IsValidEntity(obstruction) then
						goto __continue62
					end
					local start = starts[index + 1]
					local target = start:__add(targetDelta)
					obstruction:SetAbsOrigin(
						Vector(
							start.x + (target.x - start.x) * eased,
							start.y + (target.y - start.y) * eased,
							start.z + (target.z - start.z) * eased
						)
					)
				end
				::__continue62::
				index = index + 1
			end
		end
		if progress >= 1 then
			do
				local index = 0
				while index < #record.obstructions do
					local obstruction = record.obstructions[index + 1]
					if IsValid(nil, obstruction) and IsValidEntity(obstruction) then
						obstruction:SetAbsOrigin(starts[index + 1]:__add(targetDelta))
					end
					index = index + 1
				end
			end
			return nil
		end
		return FrameTime()
	end)
end
function boss_rubick_origin_5.prototype.GetObstructionGroupCenter(self, obstructions, fallback)
	local x = 0
	local y = 0
	local z = 0
	local count = 0
	for ____, obstruction in ipairs(obstructions) do
		do
			if not IsValid(nil, obstruction) or not IsValidEntity(obstruction) then
				goto __continue68
			end
			local origin = obstruction:GetAbsOrigin()
			x = x + origin.x
			y = y + origin.y
			z = z + origin.z
			count = count + 1
		end
		::__continue68::
	end
	if count <= 0 then
		return fallback
	end
	return Vector(x / count, y / count, z / count)
end
function boss_rubick_origin_5.prototype.GetEaseProgress(self, progress, motion)
	local safeProgress = math.max(0, math.min(1, progress))
	if motion == "linear" then
		return safeProgress
	end
	if motion == "easeIn" then
		return safeProgress * safeProgress * safeProgress
	end
	if motion == "easeOut" then
		local inverseProgress = 1 - safeProgress
		return 1 - inverseProgress * inverseProgress * inverseProgress
	end
	return safeProgress * safeProgress * (3 - 2 * safeProgress)
end
function boss_rubick_origin_5.prototype.PushUnitsFromSideLanes(self, lanes)
	self:PushUnitsBetweenLanes(lanes.left, lanes.center)
	self:PushUnitsBetweenLanes(lanes.right, lanes.center)
end
function boss_rubick_origin_5.prototype.PushUnitsFromCenterLane(self, lanes)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	for ____, centerTile in ipairs(lanes.center) do
		for ____, unit in ipairs(self:FindEnemyUnitsOnTiles({ centerTile })) do
			do
				if not IsValidAlive(nil, unit) then
					goto __continue80
				end
				caster:MonsterDamage({ victim = unit, damage_rate = RUBICK_ORIGIN_5_CLAMP_DAMAGE_RATE, ability = self })
				AddDeBuffStatus(
					nil,
					unit,
					caster,
					self,
					DebuffStatusType.STUN,
					{ duration = RUBICK_ORIGIN_5_CLAMP_STUN_DURATION }
				)
				self:AddClampedUnit(unit)
				goto __continue80
			end
			::__continue80::
		end
	end
end
function boss_rubick_origin_5.prototype.AddClampedUnit(self, unit)
	if __TS__ArrayIndexOf(self.clampedUnits, unit) == -1 then
		local ____self_clampedUnits_8 = self.clampedUnits
		____self_clampedUnits_8[#____self_clampedUnits_8 + 1] = unit
	end
end
function boss_rubick_origin_5.prototype.ClearClampedUnitsAfterReturn(self)
	SysTimers:CreateTimer(RUBICK_ORIGIN_5_RETURN_DURATION, function()
		for ____, unit in ipairs(self.clampedUnits) do
			if IsValidAlive(nil, unit) then
				FindClearSpaceForUnit(unit, unit:GetAbsOrigin(), true)
			end
		end
		self.clampedUnits = {}
		return nil
	end)
end
function boss_rubick_origin_5.prototype.PushUnitsBetweenLanes(self, sourceLane, targetLane)
	do
		local index = 0
		while index < #sourceLane do
			local sourceTile = sourceLane[index + 1]
			local targetTile = targetLane[index + 1]
			if targetTile then
				self:PushUnitsOnTile(sourceTile, targetTile)
			end
			index = index + 1
		end
	end
end
function boss_rubick_origin_5.prototype.PushUnitsOnTile(self, sourceTile, targetTile)
	for ____, unit in ipairs(self:FindEnemyUnitsOnTiles({ sourceTile })) do
		do
			if not IsValidAlive(nil, unit) then
				goto __continue95
			end
			self:MoveUnitToTile(unit, targetTile)
		end
		::__continue95::
	end
end
function boss_rubick_origin_5.prototype.MoveUnitToTile(self, unit, tile)
	if not IsValidAlive(nil, unit) then
		return
	end
	local origin = unit:GetAbsOrigin()
	local landPos = Vector(tile.origin.x, tile.origin.y, GetGroundHeight(tile.origin, unit) or tile.origin.z)
	local peak = origin:__add(landPos):__mul(0.5):__add(Vector(0, 0, RUBICK_ORIGIN_5_PUSH_HEIGHT))
	unit:Bezier2Mover({ origin, peak, landPos }, RUBICK_ORIGIN_5_PUSH_DURATION, nil, false, true)
	SysTimers:CreateTimer(RUBICK_ORIGIN_5_PUSH_DURATION, function()
		if IsValidAlive(nil, unit) then
			FindClearSpaceForUnit(unit, landPos, true)
		end
		return nil
	end)
end
function boss_rubick_origin_5.prototype.PlayTileWarning(self, tile)
	local particle = ParticleManager:CreateParticle(RUBICK_ORIGIN_5_WARNING_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, tile.surfaceOrigin)
	ParticleManager:SetParticleControl(particle, 1, Vector(tile.radius, tile.radius, tile.radius))
	ParticleManager:SetParticleControl(particle, 10, Vector(RUBICK_ORIGIN_5_WARNING_DURATION, 0, 0))
	ParticleManager:SetParticleControl(particle, 11, tile.surfaceOrigin)
	local ____self_warningParticles_9 = self.warningParticles
	____self_warningParticles_9[#____self_warningParticles_9 + 1] = particle
end
function boss_rubick_origin_5.prototype.ClearWarnings(self)
	for ____, particle in ipairs(self.warningParticles) do
		ParticleManager:DestroyParticle(particle, false)
		ParticleManager:ReleaseParticleIndex(particle)
	end
	self.warningParticles = {}
end
boss_rubick_origin_5 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_rubick_origin_5)
____exports.boss_rubick_origin_5 = boss_rubick_origin_5
return ____exports