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
local __TS__ArraySome = ____lualib.__TS__ArraySome
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____base_rubick_origin_ability = require("abilities.monster.boss_rubick.base_rubick_origin_ability")
local RubickOriginAbility = ____base_rubick_origin_ability.RubickOriginAbility
--- 技能最大索敌距离。
local RUBICK_SAND_1_CAST_RANGE = 3000
--- 边线抬升前的预警时间。
local RUBICK_SAND_1_WARNING_DURATION = 0.75
--- 边线抬升高度。
local RUBICK_SAND_1_LIFT_HEIGHT = 130
--- 边线抬升动画时长。
local RUBICK_SAND_1_LIFT_DURATION = 0.16
--- 边线抬升后的保持时间。
local RUBICK_SAND_1_HOLD_DURATION = 0
--- 边线回落动画时长。
local RUBICK_SAND_1_RELEASE_DURATION = 0.18
--- 行列方块依次抬升的间隔。
local RUBICK_SAND_1_TILE_STAGGER_DELAY = 0.025
--- 行列波动演出预留的最大持续时间。
local RUBICK_SAND_1_CAST_DURATION = 1
--- 被边线抬升命中的眩晕时间。
local RUBICK_SAND_1_STUN_DURATION = 1
--- 沙漠边线预警特效。
local RUBICK_SAND_1_WARNING_PARTICLE = "particles/rebuild/spell/rubick_boss/cube_aura/effect_sand/effect.vpcf"
--- 播放在目标方块原始地面上的沙漠穿刺材质特效。
local RUBICK_SAND_1_BURROWSTRIKE_TILE_PARTICLE =
	"particles/rebuild/spell/rubick_boss/hd_rubick_boss_burrowstrike/effect_2/effect.vpcf"
--- 穿刺材质特效覆盖范围比例。
local RUBICK_SAND_1_BURROWSTRIKE_TILE_EFFECT_SCALE = 0.5
--- 拉比克沙漠技能一：边线穿刺。
--
-- 技能形态：
-- 1. 随机选择一行和一列。
-- 2. 行列方块整体抬升，站在上面的单位被眩晕。
-- 3. 目标方块原始地面播放沙漠穿刺材质特效。
____exports.boss_rubick_sand_1 = __TS__Class()
local boss_rubick_sand_1 = ____exports.boss_rubick_sand_1
boss_rubick_sand_1.name = "boss_rubick_sand_1"
__TS__ClassExtends(boss_rubick_sand_1, RubickOriginAbility)
function boss_rubick_sand_1.prototype.____constructor(self, ...)
	RubickOriginAbility.prototype.____constructor(self, ...)
	self.castToken = 0
	self.warningParticles = {}
	self.burrowstrikeTileParticles = {}
end
function boss_rubick_sand_1.prototype.Precache(self, context)
	PrecacheResource("particle", RUBICK_SAND_1_WARNING_PARTICLE, context)
	PrecacheResource("particle", RUBICK_SAND_1_BURROWSTRIKE_TILE_PARTICLE, context)
end
function boss_rubick_sand_1.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = RUBICK_SAND_1_CAST_RANGE,
		castAnimation = "",
		castPoint = RUBICK_SAND_1_WARNING_DURATION,
		castDuration = RUBICK_SAND_1_CAST_DURATION,
		canCast = function()
			return self:CanCastEdgeLift()
		end,
		OnPhaseStart = function()
			self.castToken = self.castToken + 1
			self:PrepareEdgeLift()
		end,
		OnStart = function()
			return self:StartEdgeLift(self.castToken)
		end,
		OnInterrupt = function()
			self.castToken = self.castToken + 1
			self:ClearWarnings()
			self:ClearBurrowstrikeTileParticles()
			self:ReleaseSelectedTiles(0.1)
		end,
		OnFinish = function()
			self:ClearWarnings()
			self:ClearBurrowstrikeTileParticles()
		end,
	}
end
function boss_rubick_sand_1.prototype.CanCastEdgeLift(self)
	if not MyGameDynamicFloor then
		return UF_FAIL_CUSTOM
	end
	local floorId = self:GetCastFloorId()
	if not floorId then
		return UF_FAIL_CUSTOM
	end
	local ____table_SelectLines_result_0
	if self:SelectLines(floorId) then
		____table_SelectLines_result_0 = UF_SUCCESS
	else
		____table_SelectLines_result_0 = UF_FAIL_CUSTOM
	end
	return ____table_SelectLines_result_0
end
function boss_rubick_sand_1.prototype.PrepareEdgeLift(self)
	self:ClearWarnings()
	self.selectedLines = nil
	local floorId = self:GetCastFloorId()
	if not floorId then
		return
	end
	local lines = self:SelectLines(floorId)
	if not lines then
		return
	end
	self.selectedLines = lines
	for ____, tile in ipairs(lines.allTiles) do
		self:PlayTileWarning(tile)
	end
end
function boss_rubick_sand_1.prototype.StartEdgeLift(self, token)
	self:ClearWarnings()
	self:ClearBurrowstrikeTileParticles()
	local lines = self.selectedLines
	if token ~= self.castToken or not lines or #lines.allTiles <= 0 or not MyGameDynamicFloor then
		return
	end
	self:StunUnitsOnTiles(lines.allTiles)
	self:StartStaggeredLineLift(lines, token)
end
function boss_rubick_sand_1.prototype.StartStaggeredLineLift(self, lines, token)
	local sequenceTiles = self:GetLineSequenceTiles(lines)
	do
		local index = 0
		while index < #sequenceTiles do
			local tile = sequenceTiles[index + 1]
			local delay = index * RUBICK_SAND_1_TILE_STAGGER_DELAY
			SysTimers:CreateTimer(delay, function()
				if token ~= self.castToken or not MyGameDynamicFloor then
					return nil
				end
				self:MoveSingleTile(
					tile,
					Vector(0, 0, RUBICK_SAND_1_LIFT_HEIGHT),
					RUBICK_SAND_1_LIFT_DURATION,
					"easeOut"
				)
				return nil
			end)
			SysTimers:CreateTimer(delay + RUBICK_SAND_1_LIFT_DURATION, function()
				if token ~= self.castToken then
					return nil
				end
				self:PlayBurrowstrikeTileEffects({ tile }, false)
				return nil
			end)
			SysTimers:CreateTimer(delay + RUBICK_SAND_1_LIFT_DURATION + RUBICK_SAND_1_HOLD_DURATION, function()
				if token ~= self.castToken then
					return nil
				end
				self:MoveSingleTile(tile, Vector(0, 0, 0), RUBICK_SAND_1_RELEASE_DURATION, "easeIn")
				return nil
			end)
			index = index + 1
		end
	end
	local totalDuration = math.max(0, #sequenceTiles - 1) * RUBICK_SAND_1_TILE_STAGGER_DELAY
		+ RUBICK_SAND_1_LIFT_DURATION
		+ RUBICK_SAND_1_HOLD_DURATION
		+ RUBICK_SAND_1_RELEASE_DURATION
	SysTimers:CreateTimer(totalDuration, function()
		if token ~= self.castToken then
			return nil
		end
		self:ClearBurrowstrikeTileParticles()
		return nil
	end)
end
function boss_rubick_sand_1.prototype.SelectLines(self, floorId)
	if not MyGameDynamicFloor then
		return nil
	end
	local bounds = MyGameDynamicFloor:GetPlayableBounds(floorId)
	if
		not bounds.exists
		or bounds.minColumn == nil
		or bounds.maxColumn == nil
		or bounds.minRow == nil
		or bounds.maxRow == nil
	then
		return nil
	end
	local horizontalRow = RandomInt(bounds.minRow, bounds.maxRow)
	local verticalColumn = RandomInt(bounds.minColumn, bounds.maxColumn)
	local availableTiles = __TS__ArrayFilter(MyGameDynamicFloor:GetAvailableTiles(floorId), function(____, tile)
		return self:CanUseTile(tile)
	end)
	local horizontalTiles = __TS__ArraySort(
		__TS__ArrayFilter(availableTiles, function(____, tile)
			return tile.gridRow == horizontalRow
		end),
		function(____, left, right)
			return left.gridColumn - right.gridColumn
		end
	)
	local verticalTiles = __TS__ArraySort(
		__TS__ArrayFilter(availableTiles, function(____, tile)
			return tile.gridColumn == verticalColumn
		end),
		function(____, left, right)
			return left.gridRow - right.gridRow
		end
	)
	local allTiles = self:MergeTiles(horizontalTiles, verticalTiles)
	if #horizontalTiles <= 0 or #verticalTiles <= 0 or #allTiles <= 0 then
		return nil
	end
	return {
		floorId = floorId,
		horizontalRow = horizontalRow,
		verticalColumn = verticalColumn,
		horizontalTiles = horizontalTiles,
		verticalTiles = verticalTiles,
		allTiles = allTiles,
	}
end
function boss_rubick_sand_1.prototype.MergeTiles(self, first, second)
	local result = {}
	local ____array_1 = __TS__SparseArrayNew(unpack(first))
	__TS__SparseArrayPush(____array_1, unpack(second))
	for ____, tile in ipairs({ __TS__SparseArraySpread(____array_1) }) do
		if not __TS__ArraySome(result, function(____, existing)
			return self:IsSameTile(existing, tile)
		end) then
			result[#result + 1] = tile
		end
	end
	return result
end
function boss_rubick_sand_1.prototype.StunUnitsOnTiles(self, tiles)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	for ____, unit in ipairs(self:FindEnemyUnitsOnTiles(tiles)) do
		do
			if not IsValidAlive(nil, unit) then
				goto __continue45
			end
			AddDeBuffStatus(nil, unit, caster, self, DebuffStatusType.STUN, { duration = RUBICK_SAND_1_STUN_DURATION })
		end
		::__continue45::
	end
end
function boss_rubick_sand_1.prototype.PlayBurrowstrikeTileEffects(self, tiles, clearExisting)
	if clearExisting == nil then
		clearExisting = true
	end
	if clearExisting then
		self:ClearBurrowstrikeTileParticles()
	end
	for ____, tile in ipairs(tiles) do
		local origin = tile.surfaceOrigin
		local particle =
			ParticleManager:CreateParticle(RUBICK_SAND_1_BURROWSTRIKE_TILE_PARTICLE, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(particle, 0, origin)
		ParticleManager:SetParticleControl(particle, 1, origin)
		ParticleManager:SetParticleControl(
			particle,
			10,
			Vector(
				tile.tileSize * RUBICK_SAND_1_BURROWSTRIKE_TILE_EFFECT_SCALE,
				tile.tileSize * RUBICK_SAND_1_BURROWSTRIKE_TILE_EFFECT_SCALE,
				0
			)
		)
		local ____self_burrowstrikeTileParticles_2 = self.burrowstrikeTileParticles
		____self_burrowstrikeTileParticles_2[#____self_burrowstrikeTileParticles_2 + 1] = particle
	end
end
function boss_rubick_sand_1.prototype.PlayTileWarning(self, tile)
	local particle = ParticleManager:CreateParticle(RUBICK_SAND_1_WARNING_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, tile.surfaceOrigin)
	ParticleManager:SetParticleControl(particle, 1, Vector(tile.radius, tile.radius, tile.radius))
	ParticleManager:SetParticleControl(particle, 10, Vector(RUBICK_SAND_1_WARNING_DURATION, 0, 0))
	ParticleManager:SetParticleControl(particle, 11, tile.surfaceOrigin)
	local ____self_warningParticles_3 = self.warningParticles
	____self_warningParticles_3[#____self_warningParticles_3 + 1] = particle
end
function boss_rubick_sand_1.prototype.ClearWarnings(self)
	for ____, particle in ipairs(self.warningParticles) do
		ParticleManager:DestroyParticle(particle, false)
		ParticleManager:ReleaseParticleIndex(particle)
	end
	self.warningParticles = {}
end
function boss_rubick_sand_1.prototype.ClearBurrowstrikeTileParticles(self)
	for ____, particle in ipairs(self.burrowstrikeTileParticles) do
		ParticleManager:DestroyParticle(particle, false)
		ParticleManager:ReleaseParticleIndex(particle)
	end
	self.burrowstrikeTileParticles = {}
end
function boss_rubick_sand_1.prototype.ReleaseSelectedTiles(self, duration)
	local lines = self.selectedLines
	if not lines or #lines.allTiles <= 0 or not MyGameDynamicFloor then
		return
	end
	MyGameDynamicFloor:MoveTilesToWorldOffsets(lines.floorId, {
		tiles = __TS__ArrayMap(lines.allTiles, function(____, tile)
			return {
				gridColumn = tile.gridColumn,
				gridRow = tile.gridRow,
				offset = Vector(0, 0, 0),
			}
		end),
		duration = duration,
		motion = "easeIn",
	})
end
function boss_rubick_sand_1.prototype.GetLineSequenceTiles(self, lines)
	return self:MergeTiles(lines.horizontalTiles, lines.verticalTiles)
end
function boss_rubick_sand_1.prototype.MoveSingleTile(self, tile, offset, duration, motion)
	if not MyGameDynamicFloor then
		return
	end
	MyGameDynamicFloor:MoveTilesToWorldOffsets(
		tile.floorId,
		{
			tiles = { { gridColumn = tile.gridColumn, gridRow = tile.gridRow, offset = offset } },
			duration = duration,
			motion = motion,
		}
	)
end
function boss_rubick_sand_1.prototype.GetCastFloorId(self)
	local caster = self:GetCaster()
	local casterTile = self:GetUnitTile(caster)
	if casterTile then
		return casterTile.floorId
	end
	local target = caster:GetMinDistanceUnit(RUBICK_SAND_1_CAST_RANGE)
	local ____IsValidAlive_result_6
	if IsValidAlive(nil, target) then
		local ____opt_4 = self:GetUnitTile(target)
		____IsValidAlive_result_6 = ____opt_4 and ____opt_4.floorId
	else
		____IsValidAlive_result_6 = nil
	end
	return ____IsValidAlive_result_6
end
function boss_rubick_sand_1.prototype.CanUseTile(self, tile)
	return tile.isAvailable and not tile.isDisabled and not tile.modelRemoved
end
boss_rubick_sand_1 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_rubick_sand_1)
____exports.boss_rubick_sand_1 = boss_rubick_sand_1
return ____exports