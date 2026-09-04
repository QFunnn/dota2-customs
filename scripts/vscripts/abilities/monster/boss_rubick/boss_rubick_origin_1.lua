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
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArraySort = ____lualib.__TS__ArraySort
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__Delete = ____lualib.__TS__Delete
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local ____exports = {}
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____base_rubick_origin_ability = require("abilities.monster.boss_rubick.base_rubick_origin_ability")
local RubickOriginAbility = ____base_rubick_origin_ability.RubickOriginAbility
--- 技能最大索敌距离。
local RUBICK_ORIGIN_1_CAST_RANGE = 3000
--- 巡格开始前的预警时间。
local RUBICK_ORIGIN_1_WARNING_DURATION = 1
--- 随机选择横排和竖排的大致比例。
local RUBICK_ORIGIN_1_LINE_SELECT_RATIO = 0.5
--- 单次技能至少选择的横排数量。
local RUBICK_ORIGIN_1_MIN_ROW_COUNT = 2
--- 单次技能至少选择的竖排数量。
local RUBICK_ORIGIN_1_MIN_COLUMN_COUNT = 2
--- 单次技能最多选择的横排数量，避免小房间外的大量计时器堆叠。
local RUBICK_ORIGIN_1_MAX_ROW_COUNT = 5
--- 单次技能最多选择的竖排数量，避免小房间外的大量计时器堆叠。
local RUBICK_ORIGIN_1_MAX_COLUMN_COUNT = 5
--- 方块抬起到空中的高度。
local RUBICK_ORIGIN_1_FLOAT_HEIGHT = 240
--- 方块抬起耗时。
local RUBICK_ORIGIN_1_LIFT_DURATION = 0.35
--- 方块在上层滑行速度。
local RUBICK_ORIGIN_1_SWEEP_SPEED = 3760
--- 默认最大单程滑行耗时，用于声明怪物技能生命周期。
local RUBICK_ORIGIN_1_MAX_SWEEP_DURATION = 2.4
--- 方块回到原位后下降耗时。
local RUBICK_ORIGIN_1_RETURN_DURATION = 0.2
--- 地面特效相对方块上表面的额外抬升，避免粒子埋进模型内部。
local RUBICK_ORIGIN_1_SURFACE_EFFECT_Z_OFFSET = 8
--- 方块额外滑出场地的距离，按格数计算。
local RUBICK_ORIGIN_1_EXIT_DISTANCE_TILES = 1.5
--- 每格奥术冲击的伤害倍率。
local RUBICK_ORIGIN_1_DAMAGE_RATE = 16
--- 方块经过后留下冰霜地板的持续时间。
local RUBICK_ORIGIN_1_FROST_AREA_DURATION = 3
--- 冰霜地板低频结算间隔。
local RUBICK_ORIGIN_1_FROST_AREA_TICK_INTERVAL = 0.3
--- 冰霜地板每次结算施加的冰缓层数。
local RUBICK_ORIGIN_1_FROST_AREA_STACK_PER_TICK = 1
--- 冰霜地板每次结算施加的冰缓持续时间。
local RUBICK_ORIGIN_1_FROST_AREA_DEBUFF_DURATION = 1
--- 冰霜地板每次结算造成的持续伤害倍率。
local RUBICK_ORIGIN_1_FROST_AREA_DAMAGE_RATE_PER_TICK = 4
--- 命中后沿方块巡航方向轻推单位的距离。
local RUBICK_ORIGIN_1_HIT_KNOCKBACK_DISTANCE = 120
--- 命中后轻推单位的持续时间。
local RUBICK_ORIGIN_1_HIT_KNOCKBACK_DURATION = 0.18
--- 方块预警使用的粒子路径。
local RUBICK_ORIGIN_1_WARNING_PARTICLE = "particles/rebuild/spell/rubick_boss/cube_aura/effect_flame/effect.vpcf"
--- 方块经过地块时播放的奥术落点特效。
local RUBICK_ORIGIN_1_IMPACT_PARTICLE = "particles/units/heroes/hero_rubick/rubick_telekinesis_land.vpcf"
--- 方块经过后留下的下雪冰霜地板特效。
local RUBICK_ORIGIN_1_FROST_AREA_PARTICLE =
	"particles/rebuild/spell/rubick_boss/cube_ground_effect/effect_snow/effect.vpcf"
--- 冰霜地板命中玩家时复用的冰缓表现。
local RUBICK_ORIGIN_1_FROST_STATUS_PARTICLE = "particles/status_fx/status_effect_frost_armor.vpcf"
--- 拉比克原始技能一：奥术巡格。
--
-- 技能形态：
-- 1. Rubick 锁定目标并随机征调若干横排与竖排，形成大范围交叉预警。
-- 2. 每条被选中的行/列从当前实际边缘抽取一个方块，抬到棋盘上方后往返巡航。
-- 3. 方块经过地块时触发奥术落点特效与伤害，去程和回程的命中顺序相反。
-- 4. 方块回到原边缘格后下降复位，不再产生额外方块或改变棋盘布局。
____exports.boss_rubick_origin_1 = __TS__Class()
local boss_rubick_origin_1 = ____exports.boss_rubick_origin_1
boss_rubick_origin_1.name = "boss_rubick_origin_1"
__TS__ClassExtends(boss_rubick_origin_1, RubickOriginAbility)
function boss_rubick_origin_1.prototype.____constructor(self, ...)
	RubickOriginAbility.prototype.____constructor(self, ...)
	self.castToken = 0
	self.lanes = {}
	self.warningParticles = {}
	self.impactedTileKeys = {}
	self.damagedUnitKeys = {}
end
function boss_rubick_origin_1.prototype.Precache(self, context)
	PrecacheResource("particle", RUBICK_ORIGIN_1_WARNING_PARTICLE, context)
	PrecacheResource("particle", RUBICK_ORIGIN_1_IMPACT_PARTICLE, context)
	PrecacheResource("particle", RUBICK_ORIGIN_1_FROST_AREA_PARTICLE, context)
	PrecacheResource("particle", RUBICK_ORIGIN_1_FROST_STATUS_PARTICLE, context)
end
function boss_rubick_origin_1.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = RUBICK_ORIGIN_1_CAST_RANGE,
		castPoint = RUBICK_ORIGIN_1_WARNING_DURATION,
		castDuration = RUBICK_ORIGIN_1_LIFT_DURATION
			+ RUBICK_ORIGIN_1_MAX_SWEEP_DURATION * 2
			+ RUBICK_ORIGIN_1_RETURN_DURATION,
		canCast = function(____, ____bindingPattern0)
			local target
			target = ____bindingPattern0.target
			local caster = self:GetCaster()
			local castTarget = target or caster:GetMinDistanceUnit(RUBICK_ORIGIN_1_CAST_RANGE)
			if not MyGameDynamicFloor or not IsValidAlive(nil, castTarget) then
				return UF_FAIL_CUSTOM
			end
			local targetTile = self:GetUnitTile(castTarget)
			if not targetTile then
				return UF_FAIL_CUSTOM
			end
			local ____temp_0
			if #self:BuildSweepLanes(targetTile) > 0 then
				____temp_0 = UF_SUCCESS
			else
				____temp_0 = UF_FAIL_CUSTOM
			end
			return ____temp_0
		end,
		OnPhaseStart = function()
			return self:PrepareSweep()
		end,
		OnStart = function()
			return self:StartSweep(self.castToken)
		end,
		OnInterrupt = function()
			self.castToken = self.castToken + 1
			self:ClearWarnings()
			self:ClearFrostController()
			self:ReturnLaneTiles(0.05)
		end,
		OnFinish = function()
			self:ClearWarnings()
		end,
	}
end
function boss_rubick_origin_1.prototype.PrepareSweep(self)
	local caster = self:GetCaster()
	local target = caster:GetMinDistanceUnit(RUBICK_ORIGIN_1_CAST_RANGE)
	self.castToken = self.castToken + 1
	self.lanes = {}
	self.impactedTileKeys = {}
	self.damagedUnitKeys = {}
	self:ClearWarnings()
	self:ClearFrostController()
	if not IsValidAlive(nil, target) then
		return
	end
	local targetTile = self:GetUnitTile(target)
	if not targetTile then
		return
	end
	self.lanes = self:BuildSweepLanes(targetTile)
	if #self.lanes <= 0 then
		return
	end
	caster:LockTargetForSpeed(target, RUBICK_ORIGIN_1_WARNING_DURATION, 4)
	self:PlayLaneWarnings(self.lanes)
end
function boss_rubick_origin_1.prototype.StartSweep(self, token)
	if token ~= self.castToken or #self.lanes <= 0 or not MyGameDynamicFloor then
		return
	end
	self.lanes = __TS__ArrayFilter(self.lanes, function(____, lane)
		return self:IsLaneStartStillUsable(lane)
	end)
	if #self.lanes <= 0 then
		self:ClearWarnings()
		return
	end
	self:ClearWarnings()
	self:EnsureFrostController()
	self:MoveLaneTiles(self:GetLiftMoveItems(), RUBICK_ORIGIN_1_LIFT_DURATION, "easeOut")
	SysTimers:CreateTimer(RUBICK_ORIGIN_1_LIFT_DURATION, function()
		if token ~= self.castToken then
			return nil
		end
		for ____, lane in ipairs(self.lanes) do
			self:MoveLaneTile(lane, self:GetSweepMoveItem(lane), lane.sweepDuration, "linear")
			self:ScheduleLaneImpacts(token, lane, 0, false)
			SysTimers:CreateTimer(lane.sweepDuration, function()
				if token ~= self.castToken then
					return nil
				end
				self:MoveLaneTile(lane, self:GetReturnSweepMoveItem(lane), lane.sweepDuration, "linear")
				self:ScheduleLaneImpacts(token, lane, 1, true)
				return nil
			end)
			SysTimers:CreateTimer(lane.sweepDuration * 2, function()
				if token == self.castToken then
					self:ReturnLaneTile(lane, RUBICK_ORIGIN_1_RETURN_DURATION)
				end
				return nil
			end)
		end
		return nil
	end)
end
function boss_rubick_origin_1.prototype.BuildSweepLanes(self, seedTile)
	local lanes = {}
	local usedStartTileKeys = {}
	local bounds = MyGameDynamicFloor and MyGameDynamicFloor:GetPlayableBounds(seedTile.floorId)
	if
		not (bounds and bounds.exists)
		or bounds.minColumn == nil
		or bounds.maxColumn == nil
		or bounds.minRow == nil
		or bounds.maxRow == nil
	then
		return lanes
	end
	local selectedRows = self:SelectSweepLines(
		seedTile.floorId,
		"row",
		bounds.minRow,
		bounds.maxRow,
		RUBICK_ORIGIN_1_MIN_ROW_COUNT,
		RUBICK_ORIGIN_1_MAX_ROW_COUNT
	)
	local selectedColumns = self:SelectSweepLines(
		seedTile.floorId,
		"column",
		bounds.minColumn,
		bounds.maxColumn,
		RUBICK_ORIGIN_1_MIN_COLUMN_COUNT,
		RUBICK_ORIGIN_1_MAX_COLUMN_COUNT
	)
	for ____, line in ipairs(selectedRows) do
		self:TryAddSweepLane(lanes, usedStartTileKeys, line)
	end
	for ____, line in ipairs(selectedColumns) do
		self:TryAddSweepLane(lanes, usedStartTileKeys, line)
	end
	return lanes
end
function boss_rubick_origin_1.prototype.SelectSweepLines(self, floorId, axis, minLine, maxLine, minCount, maxCount)
	local candidates = {}
	do
		local line = minLine
		while line <= maxLine do
			local playableLine = self:GetPlayableLineForSweep(floorId, axis, line)
			if playableLine then
				candidates[#candidates + 1] = {
					line = playableLine,
					roll = RandomFloat(0, 1),
				}
			end
			line = line + 1
		end
	end
	__TS__ArraySort(candidates, function(____, left, right)
		return left.roll - right.roll
	end)
	local lineCount = maxLine - minLine + 1
	local ratioCount = math.ceil(lineCount * RUBICK_ORIGIN_1_LINE_SELECT_RATIO)
	local targetCount = math.min(#candidates, math.max(minCount, math.min(maxCount, ratioCount)))
	return __TS__ArrayMap(__TS__ArraySlice(candidates, 0, targetCount), function(____, candidate)
		return candidate.line
	end)
end
function boss_rubick_origin_1.prototype.TryAddSweepLane(self, lanes, usedStartTileKeys, playableLine)
	if not self:CanUseTileForSweep(playableLine.startTile) then
		return false
	end
	local startKey = self:GetTileKey(playableLine.startTile)
	if __TS__ArrayIndexOf(usedStartTileKeys, startKey) ~= -1 then
		return false
	end
	local pathTiles = __TS__ArrayFilter(playableLine.tiles, function(____, tile)
		return self:CanUseTileForSweep(tile)
	end)
	if #pathTiles <= 0 then
		return false
	end
	usedStartTileKeys[#usedStartTileKeys + 1] = startKey
	local distance = playableLine.startTile.tileSize * (playableLine.travelSteps + RUBICK_ORIGIN_1_EXIT_DISTANCE_TILES)
	lanes[#lanes + 1] = {
		floorId = playableLine.floorId,
		startTile = playableLine.startTile,
		endTile = playableLine.endTile,
		pathTiles = pathTiles,
		direction = playableLine.gridDirection,
		distance = distance,
		travelSteps = playableLine.travelSteps,
		sweepDuration = distance / RUBICK_ORIGIN_1_SWEEP_SPEED,
	}
	return true
end
function boss_rubick_origin_1.prototype.GetPlayableLineForSweep(self, floorId, axis, line)
	local directions = self:GetRandomLineDirections()
	for ____, direction in ipairs(directions) do
		do
			local playableLine = MyGameDynamicFloor
				and MyGameDynamicFloor:GetPlayableLine(floorId, { axis = axis, line = line, direction = direction })
			if not playableLine or #playableLine.tiles <= 0 or not self:CanUseTileForSweep(playableLine.startTile) then
				goto __continue44
			end
			if not self:IsActualLineOuterStart(playableLine) then
				goto __continue44
			end
			return playableLine
		end
		::__continue44::
	end
	return nil
end
function boss_rubick_origin_1.prototype.GetRandomLineDirections(self)
	local ____temp_7
	if RandomInt(0, 1) == 0 then
		____temp_7 = { -1, 1 }
	else
		____temp_7 = { 1, -1 }
	end
	return ____temp_7
end
function boss_rubick_origin_1.prototype.IsActualLineOuterStart(self, line)
	local ____temp_12
	if line.axis == "row" then
		____temp_12 = MyGameDynamicFloor and MyGameDynamicFloor:GetRowBounds(line.floorId, line.line)
	else
		____temp_12 = MyGameDynamicFloor and MyGameDynamicFloor:GetColumnBounds(line.floorId, line.line)
	end
	local bounds = ____temp_12
	if not (bounds and bounds.exists) or bounds.min == nil or bounds.max == nil then
		return false
	end
	local startCoord = self:GetLineAxisCoord(line.startTile, line.axis)
	local ____temp_15
	if line.direction > 0 then
		____temp_15 = startCoord == bounds.min
	else
		____temp_15 = startCoord == bounds.max
	end
	return ____temp_15
end
function boss_rubick_origin_1.prototype.IsLaneStartStillUsable(self, lane)
	local tile = self:GetTileByGrid(lane.floorId, lane.startTile.gridColumn, lane.startTile.gridRow)
	return not not tile and self:CanUseTileForSweep(tile)
end
function boss_rubick_origin_1.prototype.GetLineAxisCoord(self, tile, axis)
	local ____temp_16
	if axis == "row" then
		____temp_16 = tile.gridColumn
	else
		____temp_16 = tile.gridRow
	end
	return ____temp_16
end
function boss_rubick_origin_1.prototype.PlayLaneWarnings(self, lanes)
	local warnedTileKeys = {}
	for ____, lane in ipairs(lanes) do
		for ____, tile in ipairs(lane.pathTiles) do
			do
				local key = self:GetTileKey(tile)
				if __TS__ArrayIndexOf(warnedTileKeys, key) ~= -1 then
					goto __continue55
				end
				warnedTileKeys[#warnedTileKeys + 1] = key
				local particle =
					ParticleManager:CreateParticle(RUBICK_ORIGIN_1_WARNING_PARTICLE, PATTACH_WORLDORIGIN, nil)
				ParticleManager:SetParticleControl(particle, 0, tile.surfaceOrigin)
				ParticleManager:SetParticleControl(particle, 1, Vector(tile.radius, tile.radius, tile.radius))
				ParticleManager:SetParticleControl(particle, 10, Vector(RUBICK_ORIGIN_1_WARNING_DURATION, 0, 0))
				ParticleManager:SetParticleControl(particle, 11, tile.surfaceOrigin)
				local ____self_warningParticles_17 = self.warningParticles
				____self_warningParticles_17[#____self_warningParticles_17 + 1] = particle
			end
			::__continue55::
		end
	end
end
function boss_rubick_origin_1.prototype.ClearWarnings(self)
	for ____, particle in ipairs(self.warningParticles) do
		ParticleManager:DestroyParticle(particle, false)
		ParticleManager:ReleaseParticleIndex(particle)
	end
	self.warningParticles = {}
end
function boss_rubick_origin_1.prototype.GetLiftMoveItems(self)
	return __TS__ArrayMap(self.lanes, function(____, lane)
		return {
			gridColumn = lane.startTile.gridColumn,
			gridRow = lane.startTile.gridRow,
			offset = Vector(0, 0, RUBICK_ORIGIN_1_FLOAT_HEIGHT),
		}
	end)
end
function boss_rubick_origin_1.prototype.GetSweepMoveItem(self, lane)
	return {
		gridColumn = lane.startTile.gridColumn,
		gridRow = lane.startTile.gridRow,
		offset = Vector(
			lane.direction.dx * lane.distance,
			lane.direction.dy * lane.distance,
			RUBICK_ORIGIN_1_FLOAT_HEIGHT
		),
	}
end
function boss_rubick_origin_1.prototype.GetReturnSweepMoveItem(self, lane)
	return {
		gridColumn = lane.startTile.gridColumn,
		gridRow = lane.startTile.gridRow,
		offset = Vector(0, 0, RUBICK_ORIGIN_1_FLOAT_HEIGHT),
	}
end
function boss_rubick_origin_1.prototype.MoveLaneTiles(self, items, duration, motion)
	if #items <= 0 or #self.lanes <= 0 or not MyGameDynamicFloor then
		return
	end
	MyGameDynamicFloor:MoveTilesToWorldOffsets(
		self.lanes[1].floorId,
		{ tiles = items, duration = duration, motion = motion }
	)
end
function boss_rubick_origin_1.prototype.MoveLaneTile(self, lane, item, duration, motion)
	if not MyGameDynamicFloor then
		return
	end
	MyGameDynamicFloor:MoveTilesToWorldOffsets(lane.floorId, { tiles = { item }, duration = duration, motion = motion })
end
function boss_rubick_origin_1.prototype.ScheduleLaneImpacts(self, token, lane, passIndex, reverse)
	for ____, tile in ipairs(lane.pathTiles) do
		SysTimers:CreateTimer(self:GetTileTriggerTime(lane, tile, reverse), function()
			if token == self.castToken then
				local ____self_ImpactTile_19 = self.ImpactTile
				local ____reverse_18
				if reverse then
					____reverse_18 = { dx = -lane.direction.dx, dy = -lane.direction.dy }
				else
					____reverse_18 = lane.direction
				end
				____self_ImpactTile_19(self, tile, ____reverse_18, passIndex)
			end
			return nil
		end)
	end
end
function boss_rubick_origin_1.prototype.GetTileTriggerTime(self, lane, tile, reverse)
	local stepFromStart = self:GetPathStepDistance(lane.startTile, tile)
	local ____reverse_20
	if reverse then
		____reverse_20 = lane.travelSteps - stepFromStart
	else
		____reverse_20 = stepFromStart
	end
	local stepIndex = ____reverse_20
	local ____reverse_21
	if reverse then
		____reverse_21 = RUBICK_ORIGIN_1_EXIT_DISTANCE_TILES * lane.startTile.tileSize
	else
		____reverse_21 = 0
	end
	local exitDistance = ____reverse_21
	return (exitDistance + stepIndex * lane.startTile.tileSize) / RUBICK_ORIGIN_1_SWEEP_SPEED
end
function boss_rubick_origin_1.prototype.GetPathStepDistance(self, startTile, tile)
	local dx = math.abs(tile.gridColumn - startTile.gridColumn)
	local dy = math.abs(tile.gridRow - startTile.gridRow)
	return math.max(dx, dy)
end
function boss_rubick_origin_1.prototype.ImpactTile(self, tile, direction, passIndex)
	if not self:CanUseTileForSweep(tile) then
		return
	end
	local tileKey = (tostring(passIndex) .. "_") .. self:GetTileKey(tile)
	if __TS__ArrayIndexOf(self.impactedTileKeys, tileKey) ~= -1 then
		return
	end
	local ____self_impactedTileKeys_22 = self.impactedTileKeys
	____self_impactedTileKeys_22[#____self_impactedTileKeys_22 + 1] = tileKey
	self:PlayImpactParticle(self:GetTileSurfaceOrigin(tile))
	self:AddFrostArea(tile)
	self:DamageUnitsOnTile(tile, direction, passIndex)
end
function boss_rubick_origin_1.prototype.PlayImpactParticle(self, origin)
	local particle = ParticleManager:CreateParticle(RUBICK_ORIGIN_1_IMPACT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:ReleaseParticleIndex(particle)
end
function boss_rubick_origin_1.prototype.EnsureFrostController(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	local controller = ____exports.modifier_boss_rubick_origin_1_frost_floor_controller:find_on(caster)
	if not controller then
		controller = ____exports.modifier_boss_rubick_origin_1_frost_floor_controller:applys(caster, caster, self, {})
	end
	return controller
end
function boss_rubick_origin_1.prototype.AddFrostArea(self, tile)
	local ____opt_23 = self:EnsureFrostController()
	if ____opt_23 ~= nil then
		____opt_23:AddFrostTile(tile, self:GetTileSurfaceOrigin(tile))
	end
end
function boss_rubick_origin_1.prototype.ClearFrostController(self)
	____exports.modifier_boss_rubick_origin_1_frost_floor_controller:remove(self:GetCaster())
end
function boss_rubick_origin_1.prototype.DamageUnitsOnTile(self, tile, direction, passIndex)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	for ____, unit in ipairs(self:FindEnemyUnitsOnTiles({ tile })) do
		do
			if not IsValidAlive(nil, unit) then
				goto __continue88
			end
			local damageKey = (((tostring(passIndex) .. "_") .. self:GetTileKey(tile)) .. "_")
				.. tostring(unit:entindex())
			if __TS__ArrayIndexOf(self.damagedUnitKeys, damageKey) ~= -1 then
				goto __continue88
			end
			local ____self_damagedUnitKeys_25 = self.damagedUnitKeys
			____self_damagedUnitKeys_25[#____self_damagedUnitKeys_25 + 1] = damageKey
			caster:MonsterDamage({ victim = unit, damage_rate = RUBICK_ORIGIN_1_DAMAGE_RATE, ability = self })
			self:KnockUnitAlongSweep(unit, direction)
		end
		::__continue88::
	end
end
function boss_rubick_origin_1.prototype.KnockUnitAlongSweep(self, unit, direction)
	if direction.dx == 0 and direction.dy == 0 then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, unit) then
		return
	end
	unit:KnockBack(caster, self, {
		duration = RUBICK_ORIGIN_1_HIT_KNOCKBACK_DURATION,
		distance = RUBICK_ORIGIN_1_HIT_KNOCKBACK_DISTANCE,
		height = 80,
		direction = Vector(direction.dx, direction.dy, 0),
		heightType = "parabola",
		block = false,
		ignore_walls = 1,
		removeOnDeath = true,
	})
end
function boss_rubick_origin_1.prototype.ReturnLaneTiles(self, duration)
	if #self.lanes <= 0 or not MyGameDynamicFloor then
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
		motion = "linear",
	})
end
function boss_rubick_origin_1.prototype.ReturnLaneTile(self, lane, duration)
	self:MoveLaneTile(lane, {
		gridColumn = lane.startTile.gridColumn,
		gridRow = lane.startTile.gridRow,
		offset = Vector(0, 0, 0),
	}, duration, "linear")
end
function boss_rubick_origin_1.prototype.GetTileKey(self, tile)
	return (((tile.floorId .. "_") .. tostring(tile.gridColumn)) .. "_") .. tostring(tile.gridRow)
end
function boss_rubick_origin_1.prototype.GetTileSurfaceOrigin(self, tile)
	return tile.origin:__add(Vector(0, 0, tile.tileSize / 2 + RUBICK_ORIGIN_1_SURFACE_EFFECT_Z_OFFSET))
end
function boss_rubick_origin_1.prototype.CanUseTileForSweep(self, tile)
	return tile.isAvailable and not tile.isDisabled and not tile.modelRemoved
end
boss_rubick_origin_1 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_rubick_origin_1)
____exports.boss_rubick_origin_1 = boss_rubick_origin_1
____exports.modifier_boss_rubick_origin_1_frost_floor_controller = __TS__Class()
local modifier_boss_rubick_origin_1_frost_floor_controller =
	____exports.modifier_boss_rubick_origin_1_frost_floor_controller
modifier_boss_rubick_origin_1_frost_floor_controller.name = "modifier_boss_rubick_origin_1_frost_floor_controller"
__TS__ClassExtends(modifier_boss_rubick_origin_1_frost_floor_controller, BaseModifier_CS)
function modifier_boss_rubick_origin_1_frost_floor_controller.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.frostAreas = {}
	self.frostAreaKeys = {}
	self.firstTileGraceExpireTime = 0
end
function modifier_boss_rubick_origin_1_frost_floor_controller.prototype.OnCreated(self, _params)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(RUBICK_ORIGIN_1_FROST_AREA_TICK_INTERVAL)
	self.firstTileGraceExpireTime = GameRules:GetGameTime()
		+ RUBICK_ORIGIN_1_LIFT_DURATION
		+ RUBICK_ORIGIN_1_FROST_AREA_TICK_INTERVAL
end
function modifier_boss_rubick_origin_1_frost_floor_controller.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:ClearFrostAreas()
end
function modifier_boss_rubick_origin_1_frost_floor_controller.prototype.AddFrostTile(self, tile, surfaceOrigin)
	if not IsServer() then
		return
	end
	local tileKey = self:GetTileKey(tile)
	local expireTime = GameRules:GetGameTime() + RUBICK_ORIGIN_1_FROST_AREA_DURATION
	self.firstTileGraceExpireTime = 0
	local existing = self.frostAreas[tileKey]
	if existing then
		existing.tile = tile
		existing.expireTime = expireTime
		return
	end
	local particle = ParticleManager:CreateParticle(RUBICK_ORIGIN_1_FROST_AREA_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, surfaceOrigin)
	ParticleManager:SetParticleControl(particle, 1, Vector(tile.radius, tile.radius, tile.radius))
	ParticleManager:SetParticleControl(particle, 10, Vector(tile.tileSize, tile.tileSize, 0))
	self.frostAreas[tileKey] = { tile = tile, expireTime = expireTime, particle = particle }
	local ____self_frostAreaKeys_26 = self.frostAreaKeys
	____self_frostAreaKeys_26[#____self_frostAreaKeys_26 + 1] = tileKey
end
function modifier_boss_rubick_origin_1_frost_floor_controller.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	self:RemoveExpiredFrostAreas()
	if #self.frostAreaKeys <= 0 then
		if GameRules:GetGameTime() < self.firstTileGraceExpireTime then
			return
		end
		self:Destroy()
		return
	end
	self:ApplyFrostToRoomPlayers(caster)
end
function modifier_boss_rubick_origin_1_frost_floor_controller.prototype.ApplyFrostToRoomPlayers(self, caster)
	if not MyGamePlayers or not MyGameDynamicFloor then
		return
	end
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____this_28
	____this_28 = caster
	local ____opt_27 = ____this_28.GetRoomId
	local casterRoomId = ____opt_27 and ____opt_27(____this_28)
	for ____, playerId in ipairs(MyGamePlayers:getAllPlayerIds()) do
		do
			local ____opt_29 = MyGamePlayers:getPlayer(playerId)
			local hero = ____opt_29 and ____opt_29:GetHero()
			if not hero or not IsValidAlive(nil, hero) then
				goto __continue117
			end
			local ____casterRoomId_33 = casterRoomId
			if ____casterRoomId_33 then
				local ____opt_31 = hero.GetRoomId
				____casterRoomId_33 = (____opt_31 and ____opt_31(hero)) ~= casterRoomId
			end
			if ____casterRoomId_33 then
				goto __continue117
			end
			local ____MyGameDynamicFloor_37 = MyGameDynamicFloor
			local ____MyGameDynamicFloor_GetTileAtPoint_38 = MyGameDynamicFloor.GetTileAtPoint
			local ____temp_36 = hero:GetAbsOrigin()
			local ____opt_34 = hero.GetRoomId
			local tile = ____MyGameDynamicFloor_GetTileAtPoint_38(
				____MyGameDynamicFloor_37,
				____temp_36,
				____opt_34 and ____opt_34(hero)
			)
			if not tile then
				goto __continue117
			end
			local area = self.frostAreas[self:GetTileKey(tile)]
			if not area then
				goto __continue117
			end
			AddDeBuffStatus(
				nil,
				hero,
				caster,
				self:GetAbility(),
				DebuffStatusType.ICE_SLOW,
				{
					stack = RUBICK_ORIGIN_1_FROST_AREA_STACK_PER_TICK,
					duration = RUBICK_ORIGIN_1_FROST_AREA_DEBUFF_DURATION,
					status_effect_name = RUBICK_ORIGIN_1_FROST_STATUS_PARTICLE,
				}
			)
			caster:MonsterDamage({
				victim = hero,
				damage_rate = RUBICK_ORIGIN_1_FROST_AREA_DAMAGE_RATE_PER_TICK,
				ability = self:GetAbility(),
			})
		end
		::__continue117::
	end
end
function modifier_boss_rubick_origin_1_frost_floor_controller.prototype.RemoveExpiredFrostAreas(self)
	local now = GameRules:GetGameTime()
	do
		local index = #self.frostAreaKeys - 1
		while index >= 0 do
			do
				local tileKey = self.frostAreaKeys[index + 1]
				local area = self.frostAreas[tileKey]
				if area and now < area.expireTime and self:CanUseTile(area.tile) then
					goto __continue124
				end
				self:RemoveFrostArea(tileKey)
			end
			::__continue124::
			index = index - 1
		end
	end
end
function modifier_boss_rubick_origin_1_frost_floor_controller.prototype.RemoveFrostArea(self, tileKey)
	self:DestroyFrostAreaParticle(self.frostAreas[tileKey])
	__TS__Delete(self.frostAreas, tileKey)
	local index = __TS__ArrayIndexOf(self.frostAreaKeys, tileKey)
	if index ~= -1 then
		__TS__ArraySplice(self.frostAreaKeys, index, 1)
	end
end
function modifier_boss_rubick_origin_1_frost_floor_controller.prototype.ClearFrostAreas(self)
	for ____, tileKey in ipairs(self.frostAreaKeys) do
		self:DestroyFrostAreaParticle(self.frostAreas[tileKey])
	end
	self.frostAreas = {}
	self.frostAreaKeys = {}
end
function modifier_boss_rubick_origin_1_frost_floor_controller.prototype.DestroyFrostAreaParticle(self, area)
	if not area then
		return
	end
	ParticleManager:DestroyParticle(area.particle, false)
	ParticleManager:ReleaseParticleIndex(area.particle)
end
function modifier_boss_rubick_origin_1_frost_floor_controller.prototype.CanUseTile(self, tile)
	return tile.isAvailable and not tile.isDisabled and not tile.modelRemoved
end
function modifier_boss_rubick_origin_1_frost_floor_controller.prototype.GetTileKey(self, tile)
	return (((tile.floorId .. "_") .. tostring(tile.gridColumn)) .. "_") .. tostring(tile.gridRow)
end
function modifier_boss_rubick_origin_1_frost_floor_controller.prototype.IsHidden(self)
	return true
end
function modifier_boss_rubick_origin_1_frost_floor_controller.prototype.IsPurgable(self)
	return false
end
modifier_boss_rubick_origin_1_frost_floor_controller =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_rubick_origin_1_frost_floor_controller)
____exports.modifier_boss_rubick_origin_1_frost_floor_controller = modifier_boss_rubick_origin_1_frost_floor_controller
return ____exports