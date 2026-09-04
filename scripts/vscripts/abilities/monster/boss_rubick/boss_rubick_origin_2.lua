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
local __TS__ArraySort = ____lualib.__TS__ArraySort
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____base_rubick_origin_ability = require("abilities.monster.boss_rubick.base_rubick_origin_ability")
local RubickOriginAbility = ____base_rubick_origin_ability.RubickOriginAbility
--- 技能最大索敌距离。
local RUBICK_ORIGIN_2_CAST_RANGE = 3000
--- 后空翻后撤动作时长。
local RUBICK_ORIGIN_2_BACKFLIP_DURATION = 0.75
--- 投掷动作总时长。
local RUBICK_ORIGIN_2_THROW_ANIMATION_DURATION = 3.97
--- 投掷动作中真正甩出方块的关键帧。
local RUBICK_ORIGIN_2_THROW_RELEASE_TIME = 1.17
--- Rubick 返回场地中心的起始时间。
local RUBICK_ORIGIN_2_RETURN_START_TIME = 2.2
--- Rubick 返回场地的移动时长。
local RUBICK_ORIGIN_2_RETURN_DURATION = 0.85
--- 方块漂浮在 Rubick 背后的高度。
local RUBICK_ORIGIN_2_FLOAT_HEIGHT = 260
--- 方块漂浮在棋盘外侧的水平距离。
local RUBICK_ORIGIN_2_FLOAT_BACK_DISTANCE = 420
--- 方块贴地滑行时的高度。
local RUBICK_ORIGIN_2_SLIDE_SURFACE_OFFSET = 48
--- 方块从背后落到首格的飞行速度。
local RUBICK_ORIGIN_2_ENTRY_SPEED = 1500
--- 方块向对侧滑出棋盘的额外距离，按格数计算。
local RUBICK_ORIGIN_2_EXIT_DISTANCE_TILES = 1.3
--- 方块滑行速度。
local RUBICK_ORIGIN_2_SLIDE_SPEED = 1900
--- 一次随机抽取的投掷方块数量。
local RUBICK_ORIGIN_2_THROW_TILE_COUNT = 3
--- 施法点附近随机抽块的搜索半径，按格数计算。
local RUBICK_ORIGIN_2_PICK_RADIUS = 2
--- 后跳过程中延迟拉起地面方块的时间。
local RUBICK_ORIGIN_2_PICKUP_DELAY = 0.5
--- 方块依次甩出的间隔。
local RUBICK_ORIGIN_2_THROW_STAGGER = 0.16
--- 背后漂浮的水平散布范围。
local RUBICK_ORIGIN_2_FLOAT_SIDE_JITTER = 360
--- 背后漂浮的高度散布范围。
local RUBICK_ORIGIN_2_FLOAT_Z_JITTER = 130
--- 方块滑过地块造成的伤害倍率。
local RUBICK_ORIGIN_2_DAMAGE_RATE = 18
--- 抽走脚下方块时造成的伤害倍率。
local RUBICK_ORIGIN_2_PICKUP_DAMAGE_RATE = 18
--- 抽走脚下方块时抛飞单位的持续时间。
local RUBICK_ORIGIN_2_PICKUP_THROW_DURATION = 0.38
--- 抽走脚下方块时抛飞单位的高度。
local RUBICK_ORIGIN_2_PICKUP_THROW_HEIGHT = 280
--- 抽走脚下方块时优先寻找落点的半径，按格数计算。
local RUBICK_ORIGIN_2_PICKUP_LANDING_RADIUS = 4
--- 命中后沿投掷方向轻推单位的距离。
local RUBICK_ORIGIN_2_KNOCKBACK_DISTANCE = 150
--- 命中后轻推单位的持续时间。
local RUBICK_ORIGIN_2_KNOCKBACK_DURATION = 0.2
--- 后空翻动作。
local RUBICK_ORIGIN_2_BACKFLIP_ANIMATION = "rubick_steal_shadow_realm"
--- 甩出投射方块动作。
local RUBICK_ORIGIN_2_THROW_ANIMATION = "rubick_steal_terrorize"
--- 投掷路径预警粒子。
local RUBICK_ORIGIN_2_WARNING_PARTICLE = "particles/rebuild/spell/rubick_boss/cube_aura/effect_flame/effect.vpcf"
--- 方块滑过地块时的奥术冲击特效。
local RUBICK_ORIGIN_2_IMPACT_PARTICLE = "particles/units/heroes/hero_rubick/rubick_telekinesis_land.vpcf"
--- 第二技能释放判定排查日志。
local RUBICK_ORIGIN_2_DEBUG = true
--- 拉比克原始技能二：奥术抛界。
--
-- 技能形态：
-- 1. Rubick 播放后空翻动作，后撤到目标相反侧的棋盘边缘。
-- 2. 从施法点附近随机抽取 3 个方块，散乱漂浮到 Rubick 背后作为弹药。
-- 3. Rubick 播放投掷动作，在 1.17 秒关键帧附近按序列帧依次甩出方块。
-- 4. 方块沿目标方向的三条相邻固定路线滑行一次；滑过的地块触发奥术冲击、伤害和轻推。
-- 5. 方块飞出棋盘后直接销毁，技能后段 Rubick 返回场地中央或最近可用地块。
____exports.boss_rubick_origin_2 = __TS__Class()
local boss_rubick_origin_2 = ____exports.boss_rubick_origin_2
boss_rubick_origin_2.name = "boss_rubick_origin_2"
__TS__ClassExtends(boss_rubick_origin_2, RubickOriginAbility)
function boss_rubick_origin_2.prototype.____constructor(self, ...)
	RubickOriginAbility.prototype.____constructor(self, ...)
	self.castToken = 0
	self.lanes = {}
	self.warningParticles = {}
	self.impactedTileKeys = {}
	self.damagedUnitKeys = {}
	self.hasReleasedTiles = false
end
function boss_rubick_origin_2.prototype.Precache(self, context)
	PrecacheResource("particle", RUBICK_ORIGIN_2_WARNING_PARTICLE, context)
	PrecacheResource("particle", RUBICK_ORIGIN_2_IMPACT_PARTICLE, context)
end
function boss_rubick_origin_2.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = RUBICK_ORIGIN_2_CAST_RANGE,
		castPoint = RUBICK_ORIGIN_2_BACKFLIP_DURATION,
		castDuration = RUBICK_ORIGIN_2_THROW_ANIMATION_DURATION,
		castAnimation = "",
		canCast = function(____, ____bindingPattern0)
			local target
			target = ____bindingPattern0.target
			local caster = self:GetCaster()
			local castTarget = target or caster:GetMinDistanceUnit(RUBICK_ORIGIN_2_CAST_RANGE)
			self:DebugLog(
				"canCast",
				(("开始判定 caster=" .. self:FormatUnit(caster)) .. " target=") .. self:FormatUnit(castTarget)
			)
			if not MyGameDynamicFloor or not IsValidAlive(nil, castTarget) then
				self:DebugLog(
					"canCast",
					(
						("失败：动态地板或目标无效 hasFloor=" .. tostring(not not MyGameDynamicFloor))
						.. " targetValid="
					) .. tostring(IsValidAlive(nil, castTarget))
				)
				return UF_FAIL_CUSTOM
			end
			local referenceTiles = self:GetReferenceTiles(caster, castTarget, "canCast")
			if not referenceTiles then
				self:DebugLog("canCast", "失败：无法解析可用参考地块")
				return UF_FAIL_CUSTOM
			end
			local lanes = self:BuildThrowLanes(referenceTiles.casterTile, referenceTiles.targetTile, "canCast")
			if #lanes <= 0 then
				self:DebugLog("canCast", "失败：路线生成数量为 0")
				return UF_FAIL_CUSTOM
			end
			self:DebugLog("canCast", "成功：可生成路线数量=" .. tostring(#lanes))
			return UF_SUCCESS
		end,
		OnPhaseStart = function()
			return self:PrepareThrow()
		end,
		OnStart = function()
			return self:StartThrow(self.castToken)
		end,
		OnInterrupt = function()
			self.castToken = self.castToken + 1
			self:ClearWarnings()
			if self.hasReleasedTiles then
				self:DestroyThrownTiles()
			else
				self:ReturnLaneTiles(0.08)
			end
		end,
		OnFinish = function()
			self:ClearWarnings()
		end,
	}
end
function boss_rubick_origin_2.prototype.PrepareThrow(self)
	local caster = self:GetCaster()
	local target = caster:GetMinDistanceUnit(RUBICK_ORIGIN_2_CAST_RANGE)
	self.castToken = self.castToken + 1
	self.lanes = {}
	self.impactedTileKeys = {}
	self.damagedUnitKeys = {}
	self.hasReleasedTiles = false
	self:ClearWarnings()
	if not IsValidAlive(nil, target) or not MyGameDynamicFloor then
		return
	end
	local referenceTiles = self:GetReferenceTiles(caster, target, "phase")
	if not referenceTiles then
		self:DebugLog("phase", "中止：无法解析可用参考地块")
		return
	end
	self:NormalizeCasterToReferenceTile(caster, referenceTiles.casterTile)
	self.lanes = self:BuildThrowLanes(referenceTiles.casterTile, referenceTiles.targetTile, "phase")
	if #self.lanes <= 0 then
		self:DebugLog("phase", "中止：路线生成数量为 0")
		return
	end
	caster:SetAnimation(RUBICK_ORIGIN_2_BACKFLIP_ANIMATION)
	caster:LockTargetForSpeed(target, RUBICK_ORIGIN_2_BACKFLIP_DURATION + RUBICK_ORIGIN_2_THROW_RELEASE_TIME, 8)
	self:MoveCasterToThrowEdge(caster, target)
	local token = self.castToken
	SysTimers:CreateTimer(RUBICK_ORIGIN_2_PICKUP_DELAY, function()
		if token == self.castToken then
			self:LiftLaneTiles()
		end
		return nil
	end)
	self:PlayLaneWarnings(RUBICK_ORIGIN_2_BACKFLIP_DURATION + RUBICK_ORIGIN_2_THROW_RELEASE_TIME)
end
function boss_rubick_origin_2.prototype.StartThrow(self, token)
	local caster = self:GetCaster()
	if token ~= self.castToken or #self.lanes <= 0 or not IsValidAlive(nil, caster) then
		return
	end
	caster:SetAnimation(RUBICK_ORIGIN_2_THROW_ANIMATION)
	SysTimers:CreateTimer(RUBICK_ORIGIN_2_THROW_RELEASE_TIME, function()
		if token ~= self.castToken then
			return nil
		end
		self:ClearWarnings()
		self:ThrowLaneTiles(token)
		return nil
	end)
	SysTimers:CreateTimer(RUBICK_ORIGIN_2_RETURN_START_TIME, function()
		if token ~= self.castToken then
			return nil
		end
		self:ReturnCasterToFloor(caster)
		return nil
	end)
	self:ScheduleThrownTileCleanup(token)
end
function boss_rubick_origin_2.prototype.GetReferenceTiles(self, caster, target, debugContext)
	local casterTile = self:GetUnitTile(caster)
	local targetTile = self:GetUnitTile(target)
	local floorId = targetTile and targetTile.floorId or casterTile and casterTile.floorId
	self:DebugLog(
		debugContext,
		(
			(
				(("原始地块 casterTile=" .. self:FormatTile(casterTile)) .. " targetTile=")
				.. self:FormatTile(targetTile)
			) .. " selectedFloor="
		) .. (floorId or "nil")
	)
	if not floorId then
		return nil
	end
	local resolvedCasterTile =
		self:ResolveUsableReferenceTile(floorId, casterTile, caster:GetAbsOrigin(), "caster", debugContext)
	local resolvedTargetTile =
		self:ResolveUsableReferenceTile(floorId, targetTile, target:GetAbsOrigin(), "target", debugContext)
	if not resolvedCasterTile or not resolvedTargetTile then
		self:DebugLog(
			debugContext,
			(("解析失败 resolvedCaster=" .. self:FormatTile(resolvedCasterTile)) .. " resolvedTarget=")
				.. self:FormatTile(resolvedTargetTile)
		)
		return nil
	end
	self:DebugLog(
		debugContext,
		(("解析成功 casterRef=" .. self:FormatTile(resolvedCasterTile)) .. " targetRef=")
			.. self:FormatTile(resolvedTargetTile)
	)
	return { casterTile = resolvedCasterTile, targetTile = resolvedTargetTile }
end
function boss_rubick_origin_2.prototype.ResolveUsableReferenceTile(self, floorId, tile, origin, label, debugContext)
	if self:IsUsableReferenceTile(tile, floorId) then
		self:DebugLog(debugContext, (label .. " 使用脚下可用地块 ") .. self:FormatTile(tile))
		return tile
	end
	if not MyGameDynamicFloor then
		self:DebugLog(debugContext, label .. " 回退失败：MyGameDynamicFloor 不存在")
		return nil
	end
	local result = MyGameDynamicFloor:GetNearestAvailableTileCenter(floorId, origin)
	self:DebugLog(
		debugContext,
		(
			(
				(((label .. " 脚下不可用，尝试最近可用格 floor=") .. floorId) .. " origin=")
				.. self:FormatVector(origin)
			) .. " "
		)
			.. (((((("success=" .. tostring(result.success)) .. " grid=(") .. tostring(result.gridColumn or "nil")) .. ",") .. tostring(
				result.gridRow or "nil"
			)) .. ") pos=")
			.. self:FormatVector(result.position)
	)
	if not result.success or result.gridColumn == nil or result.gridRow == nil then
		return nil
	end
	local fallbackTile = self:GetTileByGrid(floorId, result.gridColumn, result.gridRow)
	self:DebugLog(debugContext, (label .. " 最近可用格结果 ") .. self:FormatTile(fallbackTile))
	return fallbackTile
end
function boss_rubick_origin_2.prototype.IsUsableReferenceTile(self, tile, floorId)
	return not not tile
		and tile.floorId == floorId
		and tile.isAvailable
		and not tile.isDisabled
		and not tile.modelRemoved
end
function boss_rubick_origin_2.prototype.NormalizeCasterToReferenceTile(self, caster, casterTile)
	local currentTile = self:GetUnitTile(caster)
	if
		currentTile
		and currentTile.floorId == casterTile.floorId
		and currentTile.gridColumn == casterTile.gridColumn
		and currentTile.gridRow == casterTile.gridRow
	then
		return
	end
	local targetPos = Vector(
		casterTile.origin.x,
		casterTile.origin.y,
		GetGroundHeight(casterTile.origin, caster) or casterTile.origin.z
	)
	FindClearSpaceForUnit(caster, targetPos, true)
end
function boss_rubick_origin_2.prototype.BuildThrowLanes(self, casterTile, targetTile, debugContext)
	local retreatChoice = self:GetRetreatChoice(casterTile, targetTile)
	if not retreatChoice then
		self:DebugLog(debugContext, "路线准备失败：没有可用的后撤方向")
		return {}
	end
	local outsideDirection = retreatChoice.outsideDirection
	local direction = { dx = -outsideDirection.dx, dy = -outsideDirection.dy }
	local retreatTile = retreatChoice.retreatTile
	local candidates = self:GetNearbyThrowCandidates(casterTile)
	local routeStarts = retreatChoice.routeStarts
	local playableBounds = MyGameDynamicFloor and MyGameDynamicFloor:GetPlayableBounds(casterTile.floorId)
	self:DebugLog(
		debugContext,
		(
			(
				(
					(
						(
							(
								(
									(("路线准备 outsideDir=(" .. tostring(outsideDirection.dx)) .. ",")
									.. tostring(outsideDirection.dy)
								) .. ") throwDir=("
							) .. tostring(direction.dx)
						) .. ","
					) .. tostring(direction.dy)
				) .. ") "
			)
			.. ((((("retreat=" .. self:FormatTile(retreatTile)) .. " candidates=") .. tostring(#candidates)) .. " routeStarts=") .. tostring(
				#routeStarts
			))
			.. " "
		)
			.. (("edgeSteps=" .. tostring(retreatChoice.boundarySteps)) .. " playableBounds=")
			.. self:FormatPlayableBounds(playableBounds)
	)
	if #candidates <= 0 or #routeStarts <= 0 then
		return {}
	end
	self:ShuffleTiles(candidates)
	local lanes = {}
	local laneCount = math.min(RUBICK_ORIGIN_2_THROW_TILE_COUNT, #candidates, #routeStarts)
	do
		local index = 0
		while index < laneCount do
			local lane = self:BuildThrowLaneFromTile(
				candidates[index + 1],
				routeStarts[index + 1],
				retreatTile,
				direction,
				outsideDirection,
				#lanes,
				debugContext
			)
			if lane then
				lanes[#lanes + 1] = lane
			end
			index = index + 1
		end
	end
	return lanes
end
function boss_rubick_origin_2.prototype.BuildThrowLaneFromTile(
	self,
	startTile,
	pathStartTile,
	retreatTile,
	direction,
	outsideDirection,
	index,
	debugContext
)
	local travelSteps = self:GetPlayableTravelSteps(pathStartTile, direction)
	local pathTiles = self:GetForwardPathTiles(pathStartTile, direction, travelSteps)
	if #pathTiles <= 0 then
		self:DebugLog(
			debugContext,
			(
				(
					(
						(
							(("路线 " .. tostring(index)) .. " 失败：路径为空 start=")
							.. self:FormatTile(startTile)
						) .. " pathStart="
					) .. self:FormatTile(pathStartTile)
				) .. " "
			)
				.. ((("dir=(" .. tostring(direction.dx)) .. ",") .. tostring(direction.dy))
				.. ")"
		)
		return nil
	end
	local endTile = pathTiles[#pathTiles]
	local floatWorldOrigin = self:BuildFloatWorldOrigin(startTile, retreatTile, outsideDirection, direction)
	local unitDistance = self:GetDirectionUnitDistance(pathStartTile.tileSize, direction)
	local entryWorldOrigin = self:GetTileSlideWorldOrigin(pathStartTile)
	local exitWorldOrigin = self:GetBoardExitWorldOrigin(pathStartTile, travelSteps, entryWorldOrigin, direction)
	local entryDistance = self:GetDistance3D(floatWorldOrigin, entryWorldOrigin)
	local slideDistance = self:GetDistance2D(entryWorldOrigin, exitWorldOrigin)
	local entryDuration = entryDistance / RUBICK_ORIGIN_2_ENTRY_SPEED
	self:DebugLog(
		debugContext,
		(
			(
				(
					(
						((("路线 " .. tostring(index)) .. " 成功：ammo=") .. self:FormatTile(startTile))
						.. " pathStart="
					) .. self:FormatTile(pathStartTile)
				) .. " "
			)
			.. ((((("pathTiles=" .. tostring(#pathTiles)) .. " travelSteps=") .. tostring(travelSteps)) .. " end=") .. self:FormatTile(
				endTile
			))
			.. " "
		)
			.. (("entry=" .. tostring(entryDuration)) .. " slide=")
			.. tostring(slideDistance / RUBICK_ORIGIN_2_SLIDE_SPEED)
	)
	return {
		floorId = startTile.floorId,
		startTile = startTile,
		pathStartTile = pathStartTile,
		retreatTile = retreatTile,
		endTile = endTile,
		pathTiles = pathTiles,
		travelSteps = travelSteps,
		direction = direction,
		outsideDirection = outsideDirection,
		floatOffset = floatWorldOrigin:__sub(startTile.origin),
		floatWorldOrigin = floatWorldOrigin,
		entryWorldOrigin = entryWorldOrigin,
		exitWorldOrigin = exitWorldOrigin,
		entryDuration = entryDuration,
		throwDelay = index * RUBICK_ORIGIN_2_THROW_STAGGER,
		impactStartDelay = entryDuration,
		slideDuration = slideDistance / RUBICK_ORIGIN_2_SLIDE_SPEED,
	}
end
function boss_rubick_origin_2.prototype.GetRetreatChoice(self, casterTile, targetTile)
	local awayDirection = self:NormalizeGridDirection(
		casterTile.gridColumn - targetTile.gridColumn,
		casterTile.gridRow - targetTile.gridRow
	)
	local awayUnit = self:GetDirectionUnitVector(awayDirection)
	local candidates = {}
	for ____, outsideDirection in ipairs(self:GetEightGridDirections()) do
		do
			local retreatTile = self:GetRetreatEdgeTile(casterTile, outsideDirection)
			local routeStarts = self:BuildEdgeRouteStarts(retreatTile, outsideDirection)
			if #routeStarts <= 0 then
				goto __continue44
			end
			local directionUnit = self:GetDirectionUnitVector(outsideDirection)
			candidates[#candidates + 1] = {
				outsideDirection = outsideDirection,
				retreatTile = retreatTile,
				routeStarts = routeStarts,
				boundarySteps = self:GetRetreatBoundarySteps(casterTile, outsideDirection),
				awayScore = directionUnit.x * awayUnit.x + directionUnit.y * awayUnit.y,
				roll = RandomFloat(0, 1),
			}
		end
		::__continue44::
	end
	__TS__ArraySort(candidates, function(____, left, right)
		local edgeDelta = left.boundarySteps - right.boundarySteps
		if math.abs(edgeDelta) > 0.001 then
			return edgeDelta
		end
		local awayDelta = right.awayScore - left.awayScore
		if math.abs(awayDelta) > 0.001 then
			return awayDelta
		end
		return left.roll - right.roll
	end)
	return candidates[1]
end
function boss_rubick_origin_2.prototype.NormalizeGridDirection(self, dx, dy)
	if math.abs(dx) <= 0.001 and math.abs(dy) <= 0.001 then
		return { dx = 1, dy = 0 }
	end
	local angle = math.atan2(dy, dx)
	local step = math.pi / 4
	local index = math.floor(angle / step + 0.5)
	local normalized = (index % 8 + 8) % 8
	local directions = {
		{ dx = 1, dy = 0 },
		{ dx = 1, dy = 1 },
		{ dx = 0, dy = 1 },
		{ dx = -1, dy = 1 },
		{ dx = -1, dy = 0 },
		{ dx = -1, dy = -1 },
		{ dx = 0, dy = -1 },
		{ dx = 1, dy = -1 },
	}
	return directions[normalized + 1]
end
function boss_rubick_origin_2.prototype.GetEightGridDirections(self)
	return {
		{ dx = 1, dy = 0 },
		{ dx = 1, dy = 1 },
		{ dx = 0, dy = 1 },
		{ dx = -1, dy = 1 },
		{ dx = -1, dy = 0 },
		{ dx = -1, dy = -1 },
		{ dx = 0, dy = -1 },
		{ dx = 1, dy = -1 },
	}
end
function boss_rubick_origin_2.prototype.GetRetreatBoundarySteps(self, tile, direction)
	local bounds = MyGameDynamicFloor and MyGameDynamicFloor:GetPlayableBounds(tile.floorId)
	if
		not (bounds and bounds.exists)
		or bounds.minColumn == nil
		or bounds.maxColumn == nil
		or bounds.minRow == nil
		or bounds.maxRow == nil
	then
		return 9999
	end
	local columnSteps = self:GetAxisTravelSteps(tile.gridColumn, direction.dx, bounds.minColumn, bounds.maxColumn)
	local rowSteps = self:GetAxisTravelSteps(tile.gridRow, direction.dy, bounds.minRow, bounds.maxRow)
	return math.max(0, math.min(columnSteps, rowSteps))
end
function boss_rubick_origin_2.prototype.GetRetreatEdgeTile(self, startTile, direction)
	local result = startTile
	local column = startTile.gridColumn + direction.dx
	local row = startTile.gridRow + direction.dy
	while true do
		local tile = self:GetTileByGrid(startTile.floorId, column, row)
		if not tile or not self:CanUseTile(tile) then
			return result
		end
		result = tile
		column = column + direction.dx
		row = row + direction.dy
	end
end
function boss_rubick_origin_2.prototype.BuildEdgeRouteStarts(self, retreatTile, outsideDirection)
	local edgeTiles = MyGameDynamicFloor
			and MyGameDynamicFloor:GetAvailableBoundaryTiles(retreatTile.floorId, outsideDirection)
		or {}
	local routeStarts = {}
	local usedKeys = {}
	while #routeStarts < RUBICK_ORIGIN_2_THROW_TILE_COUNT do
		local bestTile
		local bestDistance = 999999
		for ____, tile in ipairs(edgeTiles) do
			do
				local key = self:GetTileKey(tile)
				if __TS__ArrayIndexOf(usedKeys, key) ~= -1 then
					goto __continue60
				end
				local distance = self:GetGridDistanceSq(tile, retreatTile)
				if distance < bestDistance then
					bestDistance = distance
					bestTile = tile
				end
			end
			::__continue60::
		end
		if not bestTile then
			break
		end
		usedKeys[#usedKeys + 1] = self:GetTileKey(bestTile)
		routeStarts[#routeStarts + 1] = bestTile
	end
	return routeStarts
end
function boss_rubick_origin_2.prototype.GetNearbyThrowCandidates(self, centerTile)
	local candidates = {}
	local usedKeys = {}
	do
		local radius = 0
		while radius <= RUBICK_ORIGIN_2_PICK_RADIUS do
			do
				local dx = -radius
				while dx <= radius do
					do
						local dy = -radius
						while dy <= radius do
							do
								if math.max(math.abs(dx), math.abs(dy)) ~= radius then
									goto __continue68
								end
								local tile = self:GetTileByGrid(
									centerTile.floorId,
									centerTile.gridColumn + dx,
									centerTile.gridRow + dy
								)
								if not tile or not self:CanUseTile(tile) then
									goto __continue68
								end
								local key = self:GetTileKey(tile)
								if __TS__ArrayIndexOf(usedKeys, key) ~= -1 then
									goto __continue68
								end
								usedKeys[#usedKeys + 1] = key
								candidates[#candidates + 1] = tile
							end
							::__continue68::
							dy = dy + 1
						end
					end
					dx = dx + 1
				end
			end
			radius = radius + 1
		end
	end
	return candidates
end
function boss_rubick_origin_2.prototype.GetForwardPathTiles(self, startTile, direction, travelSteps)
	local tiles = {}
	local column = startTile.gridColumn
	local row = startTile.gridRow
	do
		local step = 0
		while step <= travelSteps do
			local tile = self:GetTileByGrid(startTile.floorId, column, row)
			if tile and self:CanUseTile(tile) then
				tiles[#tiles + 1] = tile
			end
			column = column + direction.dx
			row = row + direction.dy
			step = step + 1
		end
	end
	return tiles
end
function boss_rubick_origin_2.prototype.ShuffleTiles(self, tiles)
	do
		local index = #tiles - 1
		while index > 0 do
			local swapIndex = RandomInt(0, index)
			local current = tiles[index + 1]
			tiles[index + 1] = tiles[swapIndex + 1]
			tiles[swapIndex + 1] = current
			index = index - 1
		end
	end
end
function boss_rubick_origin_2.prototype.MoveCasterToThrowEdge(self, caster, target)
	local firstLane = self.lanes[1]
	if not firstLane then
		return
	end
	local startPos = caster:GetAbsOrigin()
	local retreatUnit = self:GetDirectionUnitVector(firstLane.outsideDirection)
	local retreatPos = firstLane.retreatTile.origin:__add(
		Vector(
			retreatUnit.x * firstLane.startTile.tileSize * 0.35,
			retreatUnit.y * firstLane.startTile.tileSize * 0.35,
			0
		)
	)
	local peak = Vector(
		(startPos.x + retreatPos.x) / 2,
		(startPos.y + retreatPos.y) / 2,
		math.max(startPos.z, retreatPos.z) + 360
	)
	caster:Bezier2Mover({ startPos, peak, retreatPos }, RUBICK_ORIGIN_2_BACKFLIP_DURATION, nil, true, true)
	SysTimers:CreateTimer(RUBICK_ORIGIN_2_BACKFLIP_DURATION, function()
		if IsValidAlive(nil, caster) then
			caster:LockTargetForSpeed(target, RUBICK_ORIGIN_2_THROW_RELEASE_TIME + 0.3, 10)
		end
		return nil
	end)
end
function boss_rubick_origin_2.prototype.LiftLaneTiles(self)
	if not MyGameDynamicFloor or #self.lanes <= 0 then
		return
	end
	self:DamageAndLaunchUnitsFromLiftedTiles()
	MyGameDynamicFloor:MoveTilesToWorldOffsets(self.lanes[1].floorId, {
		tiles = __TS__ArrayMap(self.lanes, function(____, lane)
			return {
				gridColumn = lane.startTile.gridColumn,
				gridRow = lane.startTile.gridRow,
				offset = lane.floatOffset,
			}
		end),
		duration = RUBICK_ORIGIN_2_BACKFLIP_DURATION,
		motion = "easeOut",
	})
end
function boss_rubick_origin_2.prototype.DamageAndLaunchUnitsFromLiftedTiles(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or #self.lanes <= 0 then
		return
	end
	local liftedTileKeys = __TS__ArrayMap(self.lanes, function(____, lane)
		return self:GetTileKey(lane.startTile)
	end)
	for ____, lane in ipairs(self.lanes) do
		for ____, unit in ipairs(self:FindEnemyUnitsOnTiles({ lane.startTile })) do
			do
				if not IsValidAlive(nil, unit) then
					goto __continue88
				end
				caster:MonsterDamage({ victim = unit, damage_rate = RUBICK_ORIGIN_2_PICKUP_DAMAGE_RATE, ability = self })
				self:LaunchUnitToOtherTile(unit, lane.startTile, liftedTileKeys)
			end
			::__continue88::
		end
	end
end
function boss_rubick_origin_2.prototype.LaunchUnitToOtherTile(self, unit, sourceTile, excludedTileKeys)
	local landingTile = self:GetRandomLandingTile(sourceTile, excludedTileKeys)
	if not landingTile then
		return
	end
	if not IsValidAlive(nil, unit) then
		return
	end
	local origin = unit:GetAbsOrigin()
	local landPos = Vector(
		landingTile.origin.x,
		landingTile.origin.y,
		GetGroundHeight(landingTile.origin, unit) or landingTile.origin.z
	)
	local peak = origin:__add(landPos):__mul(0.5):__add(Vector(0, 0, RUBICK_ORIGIN_2_PICKUP_THROW_HEIGHT))
	unit:Bezier2Mover({ origin, peak, landPos }, RUBICK_ORIGIN_2_PICKUP_THROW_DURATION, nil, false, true)
	SysTimers:CreateTimer(RUBICK_ORIGIN_2_PICKUP_THROW_DURATION, function()
		if IsValidAlive(nil, unit) then
			FindClearSpaceForUnit(unit, landPos, true)
		end
		return nil
	end)
end
function boss_rubick_origin_2.prototype.GetRandomLandingTile(self, sourceTile, excludedTileKeys)
	local nearbyTiles = {}
	do
		local radius = 1
		while radius <= RUBICK_ORIGIN_2_PICKUP_LANDING_RADIUS do
			do
				local dx = -radius
				while dx <= radius do
					do
						local dy = -radius
						while dy <= radius do
							do
								if math.max(math.abs(dx), math.abs(dy)) ~= radius then
									goto __continue100
								end
								local tile = self:GetTileByGrid(
									sourceTile.floorId,
									sourceTile.gridColumn + dx,
									sourceTile.gridRow + dy
								)
								if tile and self:CanUseLandingTile(tile, excludedTileKeys) then
									nearbyTiles[#nearbyTiles + 1] = tile
								end
							end
							::__continue100::
							dy = dy + 1
						end
					end
					dx = dx + 1
				end
			end
			if #nearbyTiles > 0 then
				return nearbyTiles[RandomInt(0, #nearbyTiles - 1) + 1]
			end
			radius = radius + 1
		end
	end
	local fallbackTiles = self:GetAllLandingTiles(sourceTile.floorId, excludedTileKeys)
	if #fallbackTiles <= 0 then
		return nil
	end
	return fallbackTiles[RandomInt(0, #fallbackTiles - 1) + 1]
end
function boss_rubick_origin_2.prototype.GetAllLandingTiles(self, floorId, excludedTileKeys)
	local tiles = {}
	for ____, tile in ipairs(MyGameDynamicFloor and MyGameDynamicFloor:GetAvailableTiles(floorId) or {}) do
		if self:CanUseLandingTile(tile, excludedTileKeys) then
			tiles[#tiles + 1] = tile
		end
	end
	return tiles
end
function boss_rubick_origin_2.prototype.CanUseLandingTile(self, tile, excludedTileKeys)
	return self:CanUseTile(tile) and __TS__ArrayIndexOf(excludedTileKeys, self:GetTileKey(tile)) == -1
end
function boss_rubick_origin_2.prototype.ThrowLaneTiles(self, token)
	if not MyGameDynamicFloor then
		return
	end
	self.hasReleasedTiles = true
	for ____, lane in ipairs(self.lanes) do
		SysTimers:CreateTimer(lane.throwDelay, function()
			if token ~= self.castToken or not MyGameDynamicFloor then
				return nil
			end
			MyGameDynamicFloor:MoveTileAlongWorldPath(
				lane.floorId,
				{
					gridColumn = lane.startTile.gridColumn,
					gridRow = lane.startTile.gridRow,
					segments = {
						{ origin = lane.entryWorldOrigin, duration = lane.entryDuration, motion = "easeIn" },
						{ origin = lane.exitWorldOrigin, duration = lane.slideDuration, motion = "linear" },
					},
				}
			)
			self:ScheduleLaneImpacts(token, lane)
			return nil
		end)
	end
end
function boss_rubick_origin_2.prototype.ReturnLaneTiles(self, duration)
	if not MyGameDynamicFloor or #self.lanes <= 0 then
		return
	end
	MyGameDynamicFloor:MoveTilesToWorldOffsets(self.lanes[1].floorId, {
		tiles = __TS__ArrayMap(self.lanes, function(____, lane)
			return {
				gridColumn = lane.startTile.gridColumn,
				gridRow = lane.startTile.gridRow,
				offset = Vector(0, 0, 0),
			}
		end),
		duration = duration,
		motion = "smooth",
	})
end
function boss_rubick_origin_2.prototype.ReturnCasterToFloor(self, caster)
	local firstLane = self.lanes[1]
	if not firstLane or not MyGameDynamicFloor or not IsValidAlive(nil, caster) then
		return
	end
	local centerPoint = self:GetFloorCenterPoint(firstLane.floorId) or caster:GetAbsOrigin()
	local result = MyGameDynamicFloor:GetNearestAvailableTileCenter(firstLane.floorId, centerPoint)
	local ____temp_14
	if result.success and result.position then
		____temp_14 = result.position
	else
		____temp_14 = centerPoint
	end
	local targetPos = ____temp_14
	local startPos = caster:GetAbsOrigin()
	local peak =
		Vector((startPos.x + targetPos.x) / 2, (startPos.y + targetPos.y) / 2, math.max(startPos.z, targetPos.z) + 220)
	caster:Bezier2Mover({ startPos, peak, targetPos }, RUBICK_ORIGIN_2_RETURN_DURATION, nil, true, true)
end
function boss_rubick_origin_2.prototype.ScheduleLaneImpacts(self, token, lane)
	local unitDistance = self:GetDirectionUnitDistance(lane.pathStartTile.tileSize, lane.direction)
	for ____, tile in ipairs(lane.pathTiles) do
		local step = self:GetPathStepDistance(lane.pathStartTile, tile)
		SysTimers:CreateTimer(lane.impactStartDelay + step * unitDistance / RUBICK_ORIGIN_2_SLIDE_SPEED, function()
			if token == self.castToken then
				self:ImpactTile(tile, lane.direction)
			end
			return nil
		end)
	end
end
function boss_rubick_origin_2.prototype.ScheduleThrownTileCleanup(self, token)
	for ____, lane in ipairs(self.lanes) do
		SysTimers:CreateTimer(
			RUBICK_ORIGIN_2_THROW_RELEASE_TIME + lane.throwDelay + lane.entryDuration + lane.slideDuration + 0.05,
			function()
				if token == self.castToken then
					self:DestroyThrownTile(lane)
				end
				return nil
			end
		)
	end
end
function boss_rubick_origin_2.prototype.DestroyThrownTiles(self)
	for ____, lane in ipairs(self.lanes) do
		self:DestroyThrownTile(lane)
	end
end
function boss_rubick_origin_2.prototype.DestroyThrownTile(self, lane)
	if not MyGameDynamicFloor then
		return
	end
	MyGameDynamicFloor:DisableTileForPhase(
		lane.floorId,
		lane.startTile.gridColumn,
		lane.startTile.gridRow,
		{ removeTileModel = true }
	)
end
function boss_rubick_origin_2.prototype.ImpactTile(self, tile, direction)
	if not self:CanUseTile(tile) then
		return
	end
	local tileKey = self:GetTileKey(tile)
	if __TS__ArrayIndexOf(self.impactedTileKeys, tileKey) ~= -1 then
		return
	end
	local ____self_impactedTileKeys_15 = self.impactedTileKeys
	____self_impactedTileKeys_15[#____self_impactedTileKeys_15 + 1] = tileKey
	self:PlayImpactParticle(tile.surfaceOrigin)
	self:DamageUnitsOnTile(tile, direction)
end
function boss_rubick_origin_2.prototype.DamageUnitsOnTile(self, tile, direction)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	for ____, unit in ipairs(self:FindEnemyUnitsOnTiles({ tile })) do
		do
			if not IsValidAlive(nil, unit) then
				goto __continue141
			end
			local damageKey = (self:GetTileKey(tile) .. "_") .. tostring(unit:entindex())
			if __TS__ArrayIndexOf(self.damagedUnitKeys, damageKey) ~= -1 then
				goto __continue141
			end
			local ____self_damagedUnitKeys_16 = self.damagedUnitKeys
			____self_damagedUnitKeys_16[#____self_damagedUnitKeys_16 + 1] = damageKey
			caster:MonsterDamage({ victim = unit, damage_rate = RUBICK_ORIGIN_2_DAMAGE_RATE, ability = self })
			unit:KnockBack(caster, self, {
				duration = RUBICK_ORIGIN_2_KNOCKBACK_DURATION,
				distance = RUBICK_ORIGIN_2_KNOCKBACK_DISTANCE,
				height = 90,
				direction = Vector(direction.dx, direction.dy, 0),
				heightType = "parabola",
				block = false,
				ignore_walls = 1,
				removeOnDeath = true,
			})
		end
		::__continue141::
	end
end
function boss_rubick_origin_2.prototype.PlayLaneWarnings(self, duration)
	local warnedTileKeys = {}
	for ____, lane in ipairs(self.lanes) do
		for ____, tile in ipairs(lane.pathTiles) do
			do
				local key = self:GetTileKey(tile)
				if __TS__ArrayIndexOf(warnedTileKeys, key) ~= -1 then
					goto __continue147
				end
				warnedTileKeys[#warnedTileKeys + 1] = key
				local particle =
					ParticleManager:CreateParticle(RUBICK_ORIGIN_2_WARNING_PARTICLE, PATTACH_WORLDORIGIN, nil)
				ParticleManager:SetParticleControl(particle, 0, tile.surfaceOrigin)
				ParticleManager:SetParticleControl(particle, 1, Vector(tile.radius, tile.radius, tile.radius))
				ParticleManager:SetParticleControl(particle, 10, Vector(duration, 0, 0))
				ParticleManager:SetParticleControl(particle, 11, tile.surfaceOrigin)
				local ____self_warningParticles_17 = self.warningParticles
				____self_warningParticles_17[#____self_warningParticles_17 + 1] = particle
			end
			::__continue147::
		end
	end
end
function boss_rubick_origin_2.prototype.ClearWarnings(self)
	for ____, particle in ipairs(self.warningParticles) do
		ParticleManager:DestroyParticle(particle, false)
		ParticleManager:ReleaseParticleIndex(particle)
	end
	self.warningParticles = {}
end
function boss_rubick_origin_2.prototype.PlayImpactParticle(self, origin)
	local particle = ParticleManager:CreateParticle(RUBICK_ORIGIN_2_IMPACT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:ReleaseParticleIndex(particle)
end
function boss_rubick_origin_2.prototype.BuildFloatWorldOrigin(
	self,
	startTile,
	retreatTile,
	outsideDirection,
	throwDirection
)
	local outsideUnit = self:GetDirectionUnitVector(outsideDirection)
	local sideUnit = self:GetDirectionUnitVector({ dx = -throwDirection.dy, dy = throwDirection.dx })
	local sideJitter = RandomInt(-RUBICK_ORIGIN_2_FLOAT_SIDE_JITTER, RUBICK_ORIGIN_2_FLOAT_SIDE_JITTER)
	local backJitter = RandomInt(-70, 80)
	local zJitter = RandomInt(-RUBICK_ORIGIN_2_FLOAT_Z_JITTER, RUBICK_ORIGIN_2_FLOAT_Z_JITTER)
	return retreatTile.origin:__add(
		Vector(
			outsideUnit.x * (RUBICK_ORIGIN_2_FLOAT_BACK_DISTANCE + backJitter) + sideUnit.x * sideJitter,
			outsideUnit.y * (RUBICK_ORIGIN_2_FLOAT_BACK_DISTANCE + backJitter) + sideUnit.y * sideJitter,
			RUBICK_ORIGIN_2_FLOAT_HEIGHT + zJitter
		)
	)
end
function boss_rubick_origin_2.prototype.GetTileSlideWorldOrigin(self, tile)
	return tile.origin:__add(Vector(0, 0, tile.tileSize / 2 + RUBICK_ORIGIN_2_SLIDE_SURFACE_OFFSET))
end
function boss_rubick_origin_2.prototype.GetExitWorldOrigin(self, entryWorldOrigin, direction, distance)
	local directionUnit = self:GetDirectionUnitVector(direction)
	return entryWorldOrigin:__add(Vector(directionUnit.x * distance, directionUnit.y * distance, 0))
end
function boss_rubick_origin_2.prototype.GetBoardExitWorldOrigin(
	self,
	pathStartTile,
	travelSteps,
	entryWorldOrigin,
	direction
)
	local unitDistance = self:GetDirectionUnitDistance(pathStartTile.tileSize, direction)
	return self:GetExitWorldOrigin(
		entryWorldOrigin,
		direction,
		unitDistance * (travelSteps + RUBICK_ORIGIN_2_EXIT_DISTANCE_TILES)
	)
end
function boss_rubick_origin_2.prototype.GetPlayableTravelSteps(self, startTile, direction)
	local bounds = MyGameDynamicFloor and MyGameDynamicFloor:GetPlayableBounds(startTile.floorId)
	if
		not (bounds and bounds.exists)
		or bounds.minColumn == nil
		or bounds.maxColumn == nil
		or bounds.minRow == nil
		or bounds.maxRow == nil
	then
		return 0
	end
	local columnSteps = self:GetAxisTravelSteps(startTile.gridColumn, direction.dx, bounds.minColumn, bounds.maxColumn)
	local rowSteps = self:GetAxisTravelSteps(startTile.gridRow, direction.dy, bounds.minRow, bounds.maxRow)
	return math.max(0, math.min(columnSteps, rowSteps))
end
function boss_rubick_origin_2.prototype.GetAxisTravelSteps(self, value, delta, minValue, maxValue)
	if delta > 0 then
		return maxValue - value
	end
	if delta < 0 then
		return value - minValue
	end
	return 9999
end
function boss_rubick_origin_2.prototype.GetPathStepDistance(self, startTile, tile)
	local dx = math.abs(tile.gridColumn - startTile.gridColumn)
	local dy = math.abs(tile.gridRow - startTile.gridRow)
	return math.max(dx, dy)
end
function boss_rubick_origin_2.prototype.GetDirectionUnitVector(self, direction)
	local length = math.sqrt(direction.dx * direction.dx + direction.dy * direction.dy)
	if length <= 0.001 then
		return Vector(1, 0, 0)
	end
	return Vector(direction.dx / length, direction.dy / length, 0)
end
function boss_rubick_origin_2.prototype.GetDirectionUnitDistance(self, tileSize, direction)
	return tileSize * math.sqrt(direction.dx * direction.dx + direction.dy * direction.dy)
end
function boss_rubick_origin_2.prototype.GetDistance2D(self, left, right)
	local dx = left.x - right.x
	local dy = left.y - right.y
	return math.sqrt(dx * dx + dy * dy)
end
function boss_rubick_origin_2.prototype.GetDistance3D(self, left, right)
	local dx = left.x - right.x
	local dy = left.y - right.y
	local dz = left.z - right.z
	return math.sqrt(dx * dx + dy * dy + dz * dz)
end
function boss_rubick_origin_2.prototype.GetGridDistanceSq(self, left, right)
	local dx = left.gridColumn - right.gridColumn
	local dy = left.gridRow - right.gridRow
	return dx * dx + dy * dy
end
function boss_rubick_origin_2.prototype.GetFloorCenterPoint(self, floorId)
	local bounds = MyGameDynamicFloor and MyGameDynamicFloor:GetPlayableBounds(floorId)
	if
		not (bounds and bounds.exists)
		or bounds.minColumn == nil
		or bounds.maxColumn == nil
		or bounds.minRow == nil
		or bounds.maxRow == nil
	then
		return nil
	end
	local tile = self:GetTileByGrid(
		floorId,
		math.floor((bounds.minColumn + bounds.maxColumn) / 2),
		math.floor((bounds.minRow + bounds.maxRow) / 2)
	)
	return tile and tile.origin
end
function boss_rubick_origin_2.prototype.GetTileKey(self, tile)
	return (((tile.floorId .. "_") .. tostring(tile.gridColumn)) .. "_") .. tostring(tile.gridRow)
end
function boss_rubick_origin_2.prototype.DebugLog(self, context, message)
	if not RUBICK_ORIGIN_2_DEBUG or not IsServer() then
		return
	end
	print((("[RubickOrigin2][" .. (context or "debug")) .. "] ") .. message)
end
function boss_rubick_origin_2.prototype.FormatUnit(self, unit)
	if not unit or not IsValid(nil, unit) or unit:IsNull() then
		return "nil"
	end
	return (((unit:GetUnitName() .. "#") .. tostring(unit:entindex())) .. " pos=")
		.. self:FormatVector(unit:GetAbsOrigin())
end
function boss_rubick_origin_2.prototype.FormatTile(self, tile)
	if not tile then
		return "nil"
	end
	return (
		(((((tile.floorId .. "(") .. tostring(tile.gridColumn)) .. ",") .. tostring(tile.gridRow)) .. ") ")
		.. ((((("available=" .. tostring(tile.isAvailable)) .. " disabled=") .. tostring(tile.isDisabled)) .. " removed=") .. tostring(
			tile.modelRemoved
		))
		.. " "
	)
		.. "origin="
		.. self:FormatVector(tile.origin)
end
function boss_rubick_origin_2.prototype.FormatPlayableBounds(self, bounds)
	if not bounds or not bounds.exists then
		return "nil"
	end
	return (
		(
			(
				((("columns=" .. tostring(bounds.columns or "nil")) .. " rows=") .. tostring(bounds.rows or "nil"))
				.. " tileCount="
			) .. tostring(bounds.tileCount or "nil")
		) .. " "
	)
		.. ((((((("columnRange=(" .. tostring(bounds.minColumn or "nil")) .. ",") .. tostring(bounds.maxColumn or "nil")) .. ") rowRange=(") .. tostring(
			bounds.minRow or "nil"
		)) .. ",") .. tostring(bounds.maxRow or "nil"))
		.. ")"
end
function boss_rubick_origin_2.prototype.FormatVector(self, origin)
	if not origin then
		return "nil"
	end
	return (
		(((("(" .. tostring(math.floor(origin.x))) .. ",") .. tostring(math.floor(origin.y))) .. ",")
		.. tostring(math.floor(origin.z))
	) .. ")"
end
function boss_rubick_origin_2.prototype.CanUseTile(self, tile)
	return tile.isAvailable and not tile.isDisabled and not tile.modelRemoved
end
boss_rubick_origin_2 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_rubick_origin_2)
____exports.boss_rubick_origin_2 = boss_rubick_origin_2
return ____exports