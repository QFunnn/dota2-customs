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
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local TIDAL_WAVE_PARTICLE = "particles/units/heroes/hero_kunkka/kunkka_shard_tidal_wave.vpcf"
--- 前摇时间（秒）
local CAST_POINT = 1
--- 施法锁定与索敌范围
local CAST_RANGE = 1600
--- 潮汐矩形范围边长
local WAVE_RECT_SIZE = 2000
--- 潮汐区域平分数量
local WAVE_LANE_COUNT = 4
--- 单个潮汐区域宽度
local WAVE_LANE_SIZE = WAVE_RECT_SIZE / WAVE_LANE_COUNT
--- 四道齐发时相邻潮汐中心间距，默认与两道齐发的中心距一致
local FULL_WAVE_LANE_SPACING = 760
--- 潮汐碰撞半径
local WAVE_WIDTH = 280
--- 潮汐预警半径，略宽于碰撞用于贴合实际浪潮特效
local WAVE_WARNING_WIDTH = 300
--- 浪潮飞行速度
local WAVE_SPEED = 1200
--- 每轮打击预警时间
local WAVE_WARNING_TIME = 0.75
--- 动作提前量：让动作出手点对齐潮汐波释放
local WAVE_GESTURE_LEAD_TIME = 0.4
--- 召唤动作播放速率
local WAVE_GESTURE_PLAYBACK_RATE = 1
--- 潮汐波朝向转身速度，与 LockTargetForSpeed 的 rotationSpeed 语义一致
local WAVE_FACE_ROTATION_SPEED = 12
--- 两轮打击开始间隔
local WAVE_INTERVAL = 1.5
--- 命中伤害系数
local DAMAGE_RATE = 20
--- 被浪潮拖拽的距离
local DRAG_DISTANCE = 250
--- 被浪潮拖拽的持续时间
local DRAG_DURATION = 0.5
local WAVE_ROUNDS = {
	{ axis = "x", lanes = { 1, 3 } },
	{ axis = "x", lanes = { 2, 4 } },
	{ axis = "x", lanes = { 1, 2, 3, 4 } },
	{ axis = "y", lanes = { 1, 3 } },
	{ axis = "y", lanes = { 2, 4 } },
	{ axis = "y", lanes = { 1, 2, 3, 4 } },
}
--- 技能持续阶段覆盖完整召唤节奏
local CAST_DURATION = (#WAVE_ROUNDS - 1) * WAVE_INTERVAL + WAVE_WARNING_TIME + 0.5
--- 西瓜皮：潮汐巨浪
____exports.tide_hunter_ab3 = __TS__Class()
local tide_hunter_ab3 = ____exports.tide_hunter_ab3
tide_hunter_ab3.name = "tide_hunter_ab3"
__TS__ClassExtends(tide_hunter_ab3, MonsterAbility_CS)
function tide_hunter_ab3.prototype.Precache(self, context)
	PrecacheResource("particle", TIDAL_WAVE_PARTICLE, context)
end
function tide_hunter_ab3.prototype.GetCooldown(self, level)
	return 8
end
function tide_hunter_ab3.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 0.7,
		castPointDamageReduction = 0.4,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = self:GetMinDistanceUnit(CAST_RANGE, caster:GetAbsOrigin())
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:AddNewModifier(caster, self, "modifier_tide_hunter_ab3_tidal_summon", { duration = CAST_DURATION })
		end,
	}
end
tide_hunter_ab3 = __TS__DecorateLegacy({ registerAbility(nil) }, tide_hunter_ab3)
____exports.tide_hunter_ab3 = tide_hunter_ab3
____exports.modifier_tide_hunter_ab3_tidal_summon = __TS__Class()
local modifier_tide_hunter_ab3_tidal_summon = ____exports.modifier_tide_hunter_ab3_tidal_summon
modifier_tide_hunter_ab3_tidal_summon.name = "modifier_tide_hunter_ab3_tidal_summon"
__TS__ClassExtends(modifier_tide_hunter_ab3_tidal_summon, MonsterModifier_CS)
function modifier_tide_hunter_ab3_tidal_summon.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.waveIndex = 0
end
function modifier_tide_hunter_ab3_tidal_summon.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		return
	end
	self.waveIndex = 0
	self.lockedOrigin = GetGroundPosition(parent:GetAbsOrigin(), parent)
	self:ShowWarningAndFireWave()
	self:StartIntervalThink(WAVE_INTERVAL)
end
function modifier_tide_hunter_ab3_tidal_summon.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self.waveIndex = self.waveIndex + 1
	if self.waveIndex >= #WAVE_ROUNDS then
		self:StartIntervalThink(-1)
		return
	end
	self:ShowWarningAndFireWave()
end
function modifier_tide_hunter_ab3_tidal_summon.prototype.ShowWarningAndFireWave(self)
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		return
	end
	local round = WAVE_ROUNDS[self.waveIndex + 1]
	local yReverse = round.axis == "y" and RandomInt(0, 1) == 1
	local paths = __TS__ArrayMap(round.lanes, function(____, lane)
		return self:GetWavePath(round.axis, lane, yReverse, #round.lanes == WAVE_LANE_COUNT)
	end)
	local waveDirection = paths[1].direction
	local waveIndex = self.waveIndex
	for ____, path in ipairs(paths) do
		ability:WarningEffect(
			path.start,
			path["end"],
			WAVE_WARNING_TIME,
			{ startWidth = WAVE_WARNING_WIDTH, endWidth = WAVE_WARNING_WIDTH, type = 2 }
		)
	end
	self:SmoothFaceWaveDirection(parent, waveDirection, WAVE_WARNING_TIME, waveIndex)
	self:Timer(math.max(0, WAVE_WARNING_TIME - WAVE_GESTURE_LEAD_TIME), function()
		if self:IsRemoved() then
			return
		end
		if not IsValidAlive(nil, parent) then
			return
		end
		parent:StartGestureWithFadeAndPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 0.05, 0.25, WAVE_GESTURE_PLAYBACK_RATE)
	end)
	self:Timer(WAVE_WARNING_TIME, function()
		if self:IsRemoved() then
			return
		end
		if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
			return
		end
		EmitSoundOnLocationWithCaster(self.lockedOrigin, "Ability.GushCast", caster)
		for ____, path in ipairs(paths) do
			self:LaunchTidalWave(path.start, path.direction)
		end
	end)
end
function modifier_tide_hunter_ab3_tidal_summon.prototype.LaunchTidalWave(self, start, direction)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) then
		return
	end
	local startPoint = start:__add(Vector(0, 0, 90))
	CreateProjectile(nil, {
		ability = ability,
		caster = caster,
		effect_name = TIDAL_WAVE_PARTICLE,
		projectile_type = "linear",
		start_point = startPoint,
		direction = direction,
		projectile_speed = WAVE_SPEED,
		projectile_distance = WAVE_RECT_SIZE,
		projectile_range = WAVE_WIDTH,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if hitTarget and IsValidAlive(nil, hitTarget) then
				if not IsValidAlive(nil, caster) then
					return
				end
				caster:MonsterDamage({ victim = hitTarget, damage_rate = DAMAGE_RATE, ability = ability })
				self:DragTarget(hitTarget, caster, ability, direction)
				return false
			end
			return true
		end,
	})
end
function modifier_tide_hunter_ab3_tidal_summon.prototype.SmoothFaceWaveDirection(
	self,
	parent,
	direction,
	duration,
	waveIndex
)
	local targetDirection = Vector(direction.x, direction.y, 0)
	if targetDirection:Length2D() <= 0.001 then
		return
	end
	local normalizedDirection = targetDirection:Normalized()
	local rotationSpeedScaled = WAVE_FACE_ROTATION_SPEED * 30
	local frameInterval = FrameTime()
	local elapsed = 0
	self:Timer(0, function()
		if self:IsRemoved() then
			return
		end
		if self.waveIndex ~= waveIndex then
			return
		end
		if not IsValidAlive(nil, parent) then
			return
		end
		local currentDirection = parent:GetForwardVector()
		local cross = currentDirection.x * normalizedDirection.y - currentDirection.y * normalizedDirection.x
		local dot = currentDirection.x * normalizedDirection.x + currentDirection.y * normalizedDirection.y
		local deltaDeg = math.atan2(cross, dot) * 180 / math.pi
		local distanceFactor = math.max(0.5, math.min(2, 2 - WAVE_RECT_SIZE / 1500))
		local maxAngleDegPerFrame = rotationSpeedScaled * frameInterval * distanceFactor
		local stepDeg = math.max(-maxAngleDegPerFrame, math.min(maxAngleDegPerFrame, deltaDeg))
		local newForwardVector = RotateVector2D(nil, currentDirection, stepDeg)
		parent:SetForwardVector(Vector(newForwardVector.x, newForwardVector.y, 0))
		elapsed = elapsed + frameInterval
		if elapsed < duration and math.abs(deltaDeg) > 0.5 then
			return frameInterval
		end
		return nil
	end)
end
function modifier_tide_hunter_ab3_tidal_summon.prototype.DragTarget(self, target, caster, ability, direction)
	if not IsValidAlive(nil, target) then
		return
	end
	target:KnockBack(caster, ability, {
		duration = DRAG_DURATION,
		distance = DRAG_DISTANCE,
		height = 0,
		direction = direction,
		stun = true,
		stunDuration = 0,
		power = 0.85,
		destroyTreesRange = 100,
		destroyTreesType = "continues",
	})
end
function modifier_tide_hunter_ab3_tidal_summon.prototype.GetWavePath(self, axis, lane, yReverse, useFullWaveSpacing)
	if yReverse == nil then
		yReverse = false
	end
	if useFullWaveSpacing == nil then
		useFullWaveSpacing = false
	end
	local halfSize = WAVE_RECT_SIZE / 2
	local ____useFullWaveSpacing_0
	if useFullWaveSpacing then
		____useFullWaveSpacing_0 = (lane - (WAVE_LANE_COUNT + 1) / 2) * FULL_WAVE_LANE_SPACING
	else
		____useFullWaveSpacing_0 = -halfSize + WAVE_LANE_SIZE * (lane - 0.5)
	end
	local laneOffset = ____useFullWaveSpacing_0
	local origin = self.lockedOrigin
	if axis == "x" then
		local start = origin:__add(Vector(-halfSize, laneOffset, 0))
		local ____end = origin:__add(Vector(halfSize, laneOffset, 0))
		return {
			start = GetGroundPosition(start, self:GetParent()),
			["end"] = GetGroundPosition(____end, self:GetParent()),
			direction = Vector(1, 0, 0),
		}
	end
	local ____yReverse_1
	if yReverse then
		____yReverse_1 = halfSize
	else
		____yReverse_1 = -halfSize
	end
	local startY = ____yReverse_1
	local ____yReverse_2
	if yReverse then
		____yReverse_2 = -halfSize
	else
		____yReverse_2 = halfSize
	end
	local endY = ____yReverse_2
	local ____yReverse_3
	if yReverse then
		____yReverse_3 = Vector(0, -1, 0)
	else
		____yReverse_3 = Vector(0, 1, 0)
	end
	local direction = ____yReverse_3
	local start = origin:__add(Vector(laneOffset, startY, 0))
	local ____end = origin:__add(Vector(laneOffset, endY, 0))
	return {
		start = GetGroundPosition(start, self:GetParent()),
		["end"] = GetGroundPosition(____end, self:GetParent()),
		direction = direction,
	}
end
function modifier_tide_hunter_ab3_tidal_summon.prototype.IsHidden(self)
	return true
end
function modifier_tide_hunter_ab3_tidal_summon.prototype.IsPurgable(self)
	return false
end
function modifier_tide_hunter_ab3_tidal_summon.prototype.IsDebuff(self)
	return false
end
modifier_tide_hunter_ab3_tidal_summon = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_tide_hunter_ab3_tidal_summon") },
	modifier_tide_hunter_ab3_tidal_summon
)
____exports.modifier_tide_hunter_ab3_tidal_summon = modifier_tide_hunter_ab3_tidal_summon
return ____exports