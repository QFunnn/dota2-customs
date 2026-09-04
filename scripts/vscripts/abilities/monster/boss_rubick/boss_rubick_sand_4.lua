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
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArraySome = ____lualib.__TS__ArraySome
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____base_rubick_origin_ability = require("abilities.monster.boss_rubick.base_rubick_origin_ability")
local RubickOriginAbility = ____base_rubick_origin_ability.RubickOriginAbility
--- 技能最大索敌距离。
local RUBICK_SAND_4_CAST_RANGE = 3000
--- 地震前预警时间。
local RUBICK_SAND_4_CAST_POINT = 1.1
--- 地震持续时间。
local RUBICK_SAND_4_DURATION = 4
--- 地震脉冲间隔。
local RUBICK_SAND_4_PULSE_INTERVAL = 0.35
--- 地块水平最大抖动距离。
local RUBICK_SAND_4_SHAKE_XY = 8
--- 地块上下最大抖动距离。
local RUBICK_SAND_4_SHAKE_Z = 10
--- 整体地震波动水平幅度。
local RUBICK_SAND_4_WAVE_XY = 10
--- 整体地震波动垂直幅度。
local RUBICK_SAND_4_WAVE_Z = 27
--- 整体地震波动频率。
local RUBICK_SAND_4_WAVE_FREQUENCY = 7
--- 地震区域边长。
local RUBICK_SAND_4_AREA_SIZE = 3
--- 中心格减速持续时间。
local RUBICK_SAND_4_CENTER_SLOW_DURATION = 0.45
--- 中心格减速百分比。
local RUBICK_SAND_4_CENTER_SLOW_PCT = 80
--- 外围格吸附检测间隔。
local RUBICK_SAND_4_PULL_INTERVAL = 0.12
--- 外围格每次吸附位移距离。
local RUBICK_SAND_4_PULL_STEP_DISTANCE = 120
--- 外围格每次吸附位移时间。
local RUBICK_SAND_4_PULL_STEP_DURATION = 0.1
--- 地震预警特效。
local RUBICK_SAND_4_WARNING_PARTICLE = "particles/rebuild/spell/rubick_boss/cube_aura/effect_sand/effect.vpcf"
--- 地震脉冲特效。
local RUBICK_SAND_4_EPICENTER_PARTICLE = "particles/boss/sandking_epicenter.vpcf"
--- 地震施法动作。
local RUBICK_SAND_4_CAST_ANIMATION = "rubick_steal_skburrowa"
____exports.boss_rubick_sand_4 = __TS__Class()
local boss_rubick_sand_4 = ____exports.boss_rubick_sand_4
boss_rubick_sand_4.name = "boss_rubick_sand_4"
__TS__ClassExtends(boss_rubick_sand_4, RubickOriginAbility)
function boss_rubick_sand_4.prototype.____constructor(self, ...)
	RubickOriginAbility.prototype.____constructor(self, ...)
	self.castToken = 0
	self.warningToken = 0
	self.warningParticles = {}
end
function boss_rubick_sand_4.prototype.Precache(self, context)
	PrecacheResource("particle", RUBICK_SAND_4_WARNING_PARTICLE, context)
	PrecacheResource("particle", RUBICK_SAND_4_EPICENTER_PARTICLE, context)
end
function boss_rubick_sand_4.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = RUBICK_SAND_4_CAST_RANGE,
		castAnimation = "",
		castPoint = RUBICK_SAND_4_CAST_POINT,
		castDuration = RUBICK_SAND_4_DURATION,
		canCast = function()
			local ____table_ResolveQuakeCenterTile_result_0
			if self:ResolveQuakeCenterTile() then
				____table_ResolveQuakeCenterTile_result_0 = UF_SUCCESS
			else
				____table_ResolveQuakeCenterTile_result_0 = UF_FAIL_CUSTOM
			end
			return ____table_ResolveQuakeCenterTile_result_0
		end,
		OnPhaseStart = function()
			return self:PrepareQuake()
		end,
		OnStart = function()
			return self:StartQuake(self.castToken)
		end,
		OnInterrupt = function()
			self.castToken = self.castToken + 1
			self:ScheduleWarningClear(RUBICK_SAND_4_CAST_POINT)
			self:ReleaseQuakeController()
		end,
		OnFinish = function()
			self:ReleaseQuakeController()
		end,
	}
end
function boss_rubick_sand_4.prototype.PrepareQuake(self)
	self.castToken = self.castToken + 1
	self:ClearWarnings()
	self:ReleaseQuakeController()
	self.lockedArea = nil
	local centerTile = self:ResolveQuakeCenterTile()
	if not centerTile then
		return
	end
	local tiles = self:GetQuakeTiles(centerTile)
	if #tiles <= 0 then
		return
	end
	self.lockedArea = { floorId = centerTile.floorId, centerTile = centerTile, tiles = tiles }
	self:PlayWarnings(tiles)
	local caster = self:GetCaster()
	local target = caster:GetMinDistanceUnit(RUBICK_SAND_4_CAST_RANGE)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, RUBICK_SAND_4_CAST_POINT, 8)
	end
	caster:SetAnimation(RUBICK_SAND_4_CAST_ANIMATION)
end
function boss_rubick_sand_4.prototype.StartQuake(self, token)
	self:ClearWarnings()
	local caster = self:GetCaster()
	local area = self.lockedArea
	if token ~= self.castToken or not IsValidAlive(nil, caster) or not area or not MyGameDynamicFloor then
		return
	end
	local controller = ____exports.modifier_boss_rubick_sand_4_quake_controller:applys(
		caster,
		caster,
		self,
		{ duration = RUBICK_SAND_4_DURATION }
	)
	controller:StartQuake(area)
end
function boss_rubick_sand_4.prototype.ResolveQuakeCenterTile(self)
	local caster = self:GetCaster()
	if not MyGameDynamicFloor or not IsValidAlive(nil, caster) then
		return nil
	end
	local target = caster:GetMinDistanceUnit(RUBICK_SAND_4_CAST_RANGE)
	local ____IsValidAlive_result_1
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_1 = self:GetUnitTile(target)
	else
		____IsValidAlive_result_1 = nil
	end
	local targetTile = ____IsValidAlive_result_1
	if targetTile and self:CanUseTile(targetTile) then
		return targetTile
	end
	local casterTile = self:GetUnitTile(caster)
	if casterTile and self:CanUseTile(casterTile) then
		return casterTile
	end
	return nil
end
function boss_rubick_sand_4.prototype.GetQuakeTiles(self, centerTile)
	local halfSize = math.floor(RUBICK_SAND_4_AREA_SIZE / 2)
	local offsets = {}
	do
		local dx = -halfSize
		while dx <= halfSize do
			local currentDx = dx
			do
				local dy = -halfSize
				while dy <= halfSize do
					local currentDy = dy
					offsets[#offsets + 1] = { dx = currentDx, dy = currentDy }
					dy = dy + 1
				end
			end
			dx = dx + 1
		end
	end
	return __TS__ArrayFilter(self:GetTilesByOffsets(centerTile, offsets), function(____, tile)
		return self:CanUseTile(tile)
	end)
end
function boss_rubick_sand_4.prototype.PlayWarnings(self, tiles)
	for ____, tile in ipairs(tiles) do
		local particle = ParticleManager:CreateParticle(RUBICK_SAND_4_WARNING_PARTICLE, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(particle, 0, tile.surfaceOrigin)
		ParticleManager:SetParticleControl(particle, 1, Vector(tile.radius, tile.radius, tile.radius))
		ParticleManager:SetParticleControl(particle, 10, Vector(RUBICK_SAND_4_CAST_POINT, 0, 0))
		ParticleManager:SetParticleControl(particle, 11, tile.surfaceOrigin)
		local ____self_warningParticles_2 = self.warningParticles
		____self_warningParticles_2[#____self_warningParticles_2 + 1] = particle
	end
end
function boss_rubick_sand_4.prototype.ClearWarnings(self)
	self.warningToken = self.warningToken + 1
	for ____, particle in ipairs(self.warningParticles) do
		ParticleManager:DestroyParticle(particle, false)
		ParticleManager:ReleaseParticleIndex(particle)
	end
	self.warningParticles = {}
end
function boss_rubick_sand_4.prototype.ScheduleWarningClear(self, delay)
	local token = self.warningToken
	SysTimers:CreateTimer(delay, function()
		if token == self.warningToken then
			self:ClearWarnings()
		end
		return nil
	end)
end
function boss_rubick_sand_4.prototype.ReleaseQuakeController(self)
	____exports.modifier_boss_rubick_sand_4_quake_controller:remove(self:GetCaster())
end
function boss_rubick_sand_4.prototype.CanUseTile(self, tile)
	return tile.isAvailable and not tile.isDisabled and not tile.modelRemoved
end
boss_rubick_sand_4 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_rubick_sand_4)
____exports.boss_rubick_sand_4 = boss_rubick_sand_4
____exports.modifier_boss_rubick_sand_4_quake_controller = __TS__Class()
local modifier_boss_rubick_sand_4_quake_controller = ____exports.modifier_boss_rubick_sand_4_quake_controller
modifier_boss_rubick_sand_4_quake_controller.name = "modifier_boss_rubick_sand_4_quake_controller"
__TS__ClassExtends(modifier_boss_rubick_sand_4_quake_controller, MonsterModifier_CS)
function modifier_boss_rubick_sand_4_quake_controller.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.visualTiles = {}
	self.pulseElapsed = 0
	self.pullElapsed = 0
	self.elapsed = 0
end
function modifier_boss_rubick_sand_4_quake_controller.prototype.OnCreated(self, _params)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(FrameTime())
end
function modifier_boss_rubick_sand_4_quake_controller.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:ReleaseTiles(0.12)
end
function modifier_boss_rubick_sand_4_quake_controller.prototype.StartQuake(self, area)
	self.area = area
	self.visualTiles = self:ResolveVisualTiles(area)
	self:PlayPulse()
end
function modifier_boss_rubick_sand_4_quake_controller.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not self.area then
		self:Destroy()
		return
	end
	local frameTime = FrameTime()
	self.elapsed = self.elapsed + frameTime
	self.pulseElapsed = self.pulseElapsed + frameTime
	self.pullElapsed = self.pullElapsed + frameTime
	self:UpdateTileEarthquakeFrame()
	if self.pulseElapsed >= RUBICK_SAND_4_PULSE_INTERVAL then
		self.pulseElapsed = 0
		self:PlayPulse()
	end
	if self.pullElapsed >= RUBICK_SAND_4_PULL_INTERVAL then
		self.pullElapsed = 0
		self:ApplyPullAndSlow(caster)
	end
end
function modifier_boss_rubick_sand_4_quake_controller.prototype.UpdateTileEarthquakeFrame(self)
	local area = self.area
	if not area then
		return
	end
	local centerOrigin = area.centerTile.origin
	for ____, tile in ipairs(self.visualTiles) do
		do
			if not IsValid(nil, tile.entity) or not IsValidEntity(tile.entity) then
				goto __continue46
			end
			local distance = GetDistance(nil, tile.baseOrigin, centerOrigin)
			local tilePhase = distance / math.max(1, area.centerTile.tileSize) * 0.75
			local wave = math.sin((self.elapsed + tilePhase) * RUBICK_SAND_4_WAVE_FREQUENCY)
			local waveOffset = Vector(
				wave * RUBICK_SAND_4_WAVE_XY,
				math.cos((self.elapsed + tilePhase) * RUBICK_SAND_4_WAVE_FREQUENCY * 0.8) * RUBICK_SAND_4_WAVE_XY,
				wave * RUBICK_SAND_4_WAVE_Z
			)
			local shakeOffset = Vector(
				RandomFloat(-RUBICK_SAND_4_SHAKE_XY, RUBICK_SAND_4_SHAKE_XY),
				RandomFloat(-RUBICK_SAND_4_SHAKE_XY, RUBICK_SAND_4_SHAKE_XY),
				RandomFloat(-RUBICK_SAND_4_SHAKE_Z, RUBICK_SAND_4_SHAKE_Z)
			)
			tile.entity:SetLocalOrigin(tile.baseOrigin:__add(waveOffset):__add(shakeOffset))
		end
		::__continue46::
	end
end
function modifier_boss_rubick_sand_4_quake_controller.prototype.PlayPulse(self)
	local area = self.area
	if not area then
		return
	end
	local particle = ParticleManager:CreateParticle(RUBICK_SAND_4_EPICENTER_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, area.centerTile.surfaceOrigin)
	ParticleManager:SetParticleControl(
		particle,
		1,
		Vector(
			area.centerTile.tileSize * RUBICK_SAND_4_AREA_SIZE / 2,
			area.centerTile.tileSize * RUBICK_SAND_4_AREA_SIZE / 2,
			RUBICK_SAND_4_WAVE_Z
		)
	)
	ParticleManager:ReleaseParticleIndex(particle)
end
function modifier_boss_rubick_sand_4_quake_controller.prototype.ApplyPullAndSlow(self, caster)
	local area = self.area
	if not area or not MyGameDynamicFloor or not MyGamePlayers then
		return
	end
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____this_4
	____this_4 = caster
	local ____opt_3 = ____this_4.GetRoomId
	local casterRoomId = ____opt_3 and ____opt_3(____this_4)
	for ____, playerId in ipairs(MyGamePlayers:getAllPlayerIds()) do
		do
			local ____opt_5 = MyGamePlayers:getPlayer(playerId)
			local hero = ____opt_5 and ____opt_5:GetHero()
			if not hero or not IsValidAlive(nil, hero) then
				goto __continue54
			end
			local ____casterRoomId_9 = casterRoomId
			if ____casterRoomId_9 then
				local ____opt_7 = hero.GetRoomId
				____casterRoomId_9 = (____opt_7 and ____opt_7(hero)) ~= casterRoomId
			end
			if ____casterRoomId_9 then
				goto __continue54
			end
			local ____MyGameDynamicFloor_13 = MyGameDynamicFloor
			local ____MyGameDynamicFloor_GetTileAtPoint_14 = MyGameDynamicFloor.GetTileAtPoint
			local ____temp_12 = hero:GetAbsOrigin()
			local ____opt_10 = hero.GetRoomId
			local heroTile = ____MyGameDynamicFloor_GetTileAtPoint_14(
				____MyGameDynamicFloor_13,
				____temp_12,
				____opt_10 and ____opt_10(hero)
			)
			if not heroTile or not self:HasTile(area.tiles, heroTile) then
				goto __continue54
			end
			if self:IsSameTile(heroTile, area.centerTile) then
				____exports.modifier_boss_rubick_sand_4_center_slow:applys(
					hero,
					caster,
					self:GetAbility(),
					{ duration = RUBICK_SAND_4_CENTER_SLOW_DURATION }
				)
				goto __continue54
			end
			self:PullHeroToCenter(hero, area.centerTile.surfaceOrigin)
		end
		::__continue54::
	end
end
function modifier_boss_rubick_sand_4_quake_controller.prototype.PullHeroToCenter(self, hero, center)
	if not IsValidAlive(nil, hero) then
		return
	end
	local origin = hero:GetAbsOrigin()
	local direction = Vector(center.x - origin.x, center.y - origin.y, 0)
	local distance = direction:Length2D()
	if distance <= 8 then
		return
	end
	local stepDistance = math.min(RUBICK_SAND_4_PULL_STEP_DISTANCE, distance)
	local target = GetGroundPosition(origin:__add(direction:Normalized():__mul(stepDistance)), hero)
	hero:Mover(target, RUBICK_SAND_4_PULL_STEP_DURATION, nil, true, true, true)
end
function modifier_boss_rubick_sand_4_quake_controller.prototype.ReleaseTiles(self, duration)
	local area = self.area
	if not area or not MyGameDynamicFloor then
		return
	end
	if #self.visualTiles > 0 then
		for ____, tile in ipairs(self.visualTiles) do
			if IsValid(nil, tile.entity) then
				tile.entity:SetLocalOrigin(tile.baseOrigin)
			end
		end
		return
	end
	MyGameDynamicFloor:MoveTilesToWorldOffsets(area.floorId, {
		tiles = __TS__ArrayMap(area.tiles, function(____, tile)
			return {
				gridColumn = tile.gridColumn,
				gridRow = tile.gridRow,
				offset = Vector(0, 0, 0),
			}
		end),
		duration = duration,
		motion = "easeOut",
	})
end
function modifier_boss_rubick_sand_4_quake_controller.prototype.ResolveVisualTiles(self, area)
	local floor = MyGameDynamicFloor and MyGameDynamicFloor:GetFloor(area.floorId)
	if not floor then
		return {}
	end
	local visualTiles = {}
	for ____, tileInfo in ipairs(area.tiles) do
		do
			local tile = floor:GetTile(tileInfo.gridColumn, tileInfo.gridRow)
			if not tile or not tile.entity or not IsValid(nil, tile.entity) or tile.modelRemoved then
				goto __continue72
			end
			visualTiles[#visualTiles + 1] = {
				entity = tile.entity,
				baseOrigin = tile.baseOrigin,
				gridColumn = tile.gridColumn,
				gridRow = tile.gridRow,
			}
		end
		::__continue72::
	end
	return visualTiles
end
function modifier_boss_rubick_sand_4_quake_controller.prototype.HasTile(self, tiles, target)
	return __TS__ArraySome(tiles, function(____, tile)
		return self:IsSameTile(tile, target)
	end)
end
function modifier_boss_rubick_sand_4_quake_controller.prototype.IsSameTile(self, left, right)
	return left.floorId == right.floorId and left.gridColumn == right.gridColumn and left.gridRow == right.gridRow
end
function modifier_boss_rubick_sand_4_quake_controller.prototype.IsHidden(self)
	return true
end
function modifier_boss_rubick_sand_4_quake_controller.prototype.IsPurgable(self)
	return false
end
modifier_boss_rubick_sand_4_quake_controller =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_rubick_sand_4_quake_controller)
____exports.modifier_boss_rubick_sand_4_quake_controller = modifier_boss_rubick_sand_4_quake_controller
____exports.modifier_boss_rubick_sand_4_center_slow = __TS__Class()
local modifier_boss_rubick_sand_4_center_slow = ____exports.modifier_boss_rubick_sand_4_center_slow
modifier_boss_rubick_sand_4_center_slow.name = "modifier_boss_rubick_sand_4_center_slow"
__TS__ClassExtends(modifier_boss_rubick_sand_4_center_slow, MonsterModifier_CS)
function modifier_boss_rubick_sand_4_center_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -RUBICK_SAND_4_CENTER_SLOW_PCT }
end
function modifier_boss_rubick_sand_4_center_slow.prototype.IsHidden(self)
	return false
end
function modifier_boss_rubick_sand_4_center_slow.prototype.IsDebuff(self)
	return true
end
function modifier_boss_rubick_sand_4_center_slow.prototype.IsPurgable(self)
	return true
end
function modifier_boss_rubick_sand_4_center_slow.prototype.GetTexture(self)
	return "sand_king_epicenter"
end
function modifier_boss_rubick_sand_4_center_slow.GetLocalizationCN(self)
	return {
		name = "地震核心",
		description = ("处于地震核心区域，移动速度降低" .. tostring(RUBICK_SAND_4_CENTER_SLOW_PCT))
			.. "%。",
	}
end
modifier_boss_rubick_sand_4_center_slow =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_rubick_sand_4_center_slow)
____exports.modifier_boss_rubick_sand_4_center_slow = modifier_boss_rubick_sand_4_center_slow
return ____exports