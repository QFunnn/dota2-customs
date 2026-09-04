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
local __TS__ArrayPushArray = ____lualib.__TS__ArrayPushArray
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____base_rubick_origin_ability = require("abilities.monster.boss_rubick.base_rubick_origin_ability")
local RubickOriginAbility = ____base_rubick_origin_ability.RubickOriginAbility
--- 技能最大索敌距离。
local RUBICK_ORIGIN_4_CAST_RANGE = 3000
--- 旋转追击前摇。
local RUBICK_ORIGIN_4_CAST_POINT = 0.35
--- 旋转追击持续时间。
local RUBICK_ORIGIN_4_DURATION = 10
--- Rubick 剑刃风暴动作。
local RUBICK_ORIGIN_4_SPIN_ANIMATION = "rubick_steal_jspinb_anim"
--- Rubick 追踪移动速度。
local RUBICK_ORIGIN_4_MOVE_SPEED = 300
--- 追踪移动更新间隔。
local RUBICK_ORIGIN_4_MOVE_THINK_INTERVAL = 0.03
--- 持续伤害半径。
local RUBICK_ORIGIN_4_DAMAGE_RADIUS = 275
--- 持续伤害间隔。
local RUBICK_ORIGIN_4_DAMAGE_INTERVAL = 0.32
--- 单次持续伤害倍率。
local RUBICK_ORIGIN_4_DAMAGE_RATE = 5
--- 前路抬格判断间隔。
local RUBICK_ORIGIN_4_BLOCK_INTERVAL = 0.34
--- 前路抬格触发概率。
local RUBICK_ORIGIN_4_BLOCK_CHANCE = 45
--- 正前方候选优先概率，其余会偏向侧前方。
local RUBICK_ORIGIN_4_FRONT_TILE_CHANCE = 70
--- 抬起地块基础高度；实际高度会被限制在地块边长内，避免露出底面。
local RUBICK_ORIGIN_4_BLOCK_TILE_HEIGHT = 220
--- 地块真正抬起前的预警时间。
local RUBICK_ORIGIN_4_BLOCK_WARNING_DURATION = 0.5
--- 地块抬起、停留、落下的总周期。
local RUBICK_ORIGIN_4_BLOCK_TILE_TOTAL_DURATION = 5
--- 地块抬起时间。
local RUBICK_ORIGIN_4_BLOCK_TILE_LIFT_DURATION = 0.35
--- 地块阻路停留时间。
local RUBICK_ORIGIN_4_BLOCK_TILE_HOLD_DURATION = 4.2
--- 地块回落时间。
local RUBICK_ORIGIN_4_BLOCK_TILE_RELEASE_DURATION = 0.45
--- 同一地块重复抬起冷却。
local RUBICK_ORIGIN_4_BLOCK_TILE_COOLDOWN = RUBICK_ORIGIN_4_BLOCK_WARNING_DURATION
	+ RUBICK_ORIGIN_4_BLOCK_TILE_TOTAL_DURATION
--- 方块抬起时对站在格子上的玩家造成的击飞持续时间。
local RUBICK_ORIGIN_4_BLOCK_KNOCKUP_DURATION = 0.45
--- 方块抬起时对站在格子上的玩家造成的击飞高度。
local RUBICK_ORIGIN_4_BLOCK_KNOCKUP_HEIGHT = 260
--- 方块抬起时对站在格子上的玩家造成的眩晕时间。
local RUBICK_ORIGIN_4_BLOCK_STUN_DURATION = 0.8
--- 旋转附着特效。
local RUBICK_ORIGIN_4_SPIN_PARTICLE =
	"particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_crimson_blade_fury_abyssal.vpcf"
--- 抬格预警特效。
local RUBICK_ORIGIN_4_WARNING_PARTICLE = "particles/rebuild/spell/rubick_boss/cube_aura/effect_flame/effect.vpcf"
--- 拉比克原始技能四：奥术旋封。
--
-- 技能形态：
-- 1. Rubick 播放剑刃风暴动作并进入持续旋转。
-- 2. 旋转期间以恒定速度慢速追踪最近敌人，并对周围单位造成持续伤害。
-- 3. 按目标逃离方向预测前路，概率性抬起前方或侧前方地块，短暂扰乱逃跑路线。
-- 4. 抬格不永久破坏地形，只作为追击压力和路线扰动。
____exports.boss_rubick_origin_4 = __TS__Class()
local boss_rubick_origin_4 = ____exports.boss_rubick_origin_4
boss_rubick_origin_4.name = "boss_rubick_origin_4"
__TS__ClassExtends(boss_rubick_origin_4, RubickOriginAbility)
function boss_rubick_origin_4.prototype.____constructor(self, ...)
	RubickOriginAbility.prototype.____constructor(self, ...)
	self.castToken = 0
	self.blockedTileCooldowns = {}
	self.activeObstructions = {}
	self.raisedTileRecords = {}
end
function boss_rubick_origin_4.prototype.Precache(self, context)
	PrecacheResource("particle", RUBICK_ORIGIN_4_SPIN_PARTICLE, context)
	PrecacheResource("particle", RUBICK_ORIGIN_4_WARNING_PARTICLE, context)
end
function boss_rubick_origin_4.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = RUBICK_ORIGIN_4_CAST_RANGE,
		castPoint = RUBICK_ORIGIN_4_CAST_POINT,
		castDuration = RUBICK_ORIGIN_4_DURATION,
		castAnimation = "",
		canCast = function()
			local target = self:GetCaster():GetMinDistanceUnit(RUBICK_ORIGIN_4_CAST_RANGE)
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
			return self:PrepareSpin()
		end,
		OnStart = function()
			return self:StartSpin()
		end,
		OnInterrupt = function()
			return self:StopSpin(true)
		end,
		OnFinish = function()
			return self:StopSpin(true)
		end,
	}
end
function boss_rubick_origin_4.prototype.PrepareSpin(self)
	local caster = self:GetCaster()
	local target = caster:GetMinDistanceUnit(RUBICK_ORIGIN_4_CAST_RANGE)
	self.castToken = self.castToken + 1
	self.lastTargetOrigin = nil
	self.blockedTileCooldowns = {}
	if not IsValidAlive(nil, target) then
		return
	end
	caster:LockTargetForSpeed(target, RUBICK_ORIGIN_4_CAST_POINT, 8)
end
function boss_rubick_origin_4.prototype.StartSpin(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local token = self.castToken
	local target = caster:GetMinDistanceUnit(RUBICK_ORIGIN_4_CAST_RANGE)
	local ____IsValidAlive_result_1
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_1 = target:GetAbsOrigin()
	else
		____IsValidAlive_result_1 = nil
	end
	self.lastTargetOrigin = ____IsValidAlive_result_1
	caster:SetAnimation(RUBICK_ORIGIN_4_SPIN_ANIMATION)
	self:StartSpinParticle(caster)
	self:StartMoveThink(token)
	self:StartDamageThink(token)
	self:StartBlockThink(token)
end
function boss_rubick_origin_4.prototype.StopSpin(self, invalidateToken)
	if invalidateToken then
		self.castToken = self.castToken + 1
	end
	if self.spinParticle ~= nil then
		ParticleManager:DestroyParticle(self.spinParticle, false)
		ParticleManager:ReleaseParticleIndex(self.spinParticle)
		self.spinParticle = nil
	end
	local caster = self:GetCaster()
	if IsValid(nil, caster) then
		caster:RemoveGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
	end
	self.lastTargetOrigin = nil
	self.blockedTileCooldowns = {}
end
function boss_rubick_origin_4.prototype.StartSpinParticle(self, caster)
	if self.spinParticle ~= nil then
		ParticleManager:DestroyParticle(self.spinParticle, false)
		ParticleManager:ReleaseParticleIndex(self.spinParticle)
		self.spinParticle = nil
	end
	self.spinParticle = ParticleManager:CreateParticle(RUBICK_ORIGIN_4_SPIN_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		self.spinParticle,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_origin",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self.spinParticle, 5, Vector(700, 1, 1))
end
function boss_rubick_origin_4.prototype.StartMoveThink(self, token)
	local caster = self:GetCaster()
	local startTime = GameRules:GetGameTime()
	SysTimers:CreateTimer(0, function()
		if token ~= self.castToken or not IsValidAlive(nil, caster) then
			return nil
		end
		if GameRules:GetGameTime() - startTime >= RUBICK_ORIGIN_4_DURATION then
			return nil
		end
		local target = caster:GetMinDistanceUnit(RUBICK_ORIGIN_4_CAST_RANGE)
		if IsValidAlive(nil, target) then
			self:MoveCasterTowardTarget(caster, target, RUBICK_ORIGIN_4_MOVE_THINK_INTERVAL)
		end
		return RUBICK_ORIGIN_4_MOVE_THINK_INTERVAL
	end)
end
function boss_rubick_origin_4.prototype.StartDamageThink(self, token)
	local caster = self:GetCaster()
	local startTime = GameRules:GetGameTime()
	SysTimers:CreateTimer(0, function()
		if token ~= self.castToken or not IsValidAlive(nil, caster) then
			return nil
		end
		if GameRules:GetGameTime() - startTime >= RUBICK_ORIGIN_4_DURATION then
			return nil
		end
		self:DamageEnemiesAround(caster)
		return RUBICK_ORIGIN_4_DAMAGE_INTERVAL
	end)
end
function boss_rubick_origin_4.prototype.StartBlockThink(self, token)
	local caster = self:GetCaster()
	local startTime = GameRules:GetGameTime()
	SysTimers:CreateTimer(RUBICK_ORIGIN_4_BLOCK_INTERVAL, function()
		if token ~= self.castToken or not IsValidAlive(nil, caster) then
			return nil
		end
		if GameRules:GetGameTime() - startTime >= RUBICK_ORIGIN_4_DURATION then
			return nil
		end
		local target = caster:GetMinDistanceUnit(RUBICK_ORIGIN_4_CAST_RANGE)
		if IsValidAlive(nil, target) then
			self:TryRaiseEscapeTile(caster, target)
			self.lastTargetOrigin = target:GetAbsOrigin()
		end
		return RUBICK_ORIGIN_4_BLOCK_INTERVAL
	end)
end
function boss_rubick_origin_4.prototype.MoveCasterTowardTarget(self, caster, target, dt)
	local casterOrigin = caster:GetAbsOrigin()
	if not IsValidAlive(nil, target) then
		return
	end
	local targetOrigin = target:GetAbsOrigin()
	local direction = self:GetFlatDirection(targetOrigin:__sub(casterOrigin))
	if not direction then
		return
	end
	caster:SetForwardVectorWithoutInterrupt(direction)
	local distance = casterOrigin:__sub(targetOrigin):Length2D()
	if distance <= RUBICK_ORIGIN_4_DAMAGE_RADIUS * 0.45 then
		return
	end
	local step = math.min(RUBICK_ORIGIN_4_MOVE_SPEED * dt, distance)
	local next = casterOrigin:__add(direction:__mul(step))
	local ground = GetGroundPosition(next, caster) or next
	caster:SetAbsOrigin(ground)
	self:NormalizeRaisedTileUnderRubick(caster)
end
function boss_rubick_origin_4.prototype.DamageEnemiesAround(self, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		RUBICK_ORIGIN_4_DAMAGE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue39
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = RUBICK_ORIGIN_4_DAMAGE_RATE, ability = self })
		end
		::__continue39::
	end
end
function boss_rubick_origin_4.prototype.TryRaiseEscapeTile(self, caster, target)
	if not MyGameDynamicFloor or RandomFloat(0, 100) > RUBICK_ORIGIN_4_BLOCK_CHANCE then
		return
	end
	local targetTile = self:GetUnitTile(target)
	if not targetTile then
		return
	end
	local escapeDirection = self:GetEscapeGridDirection(caster, target)
	if not escapeDirection then
		return
	end
	local candidate = self:PickEscapeBlockTile(targetTile, escapeDirection)
	if not candidate then
		return
	end
	self:StartRaiseTileWarning(self.castToken, candidate)
	self.blockedTileCooldowns[self:GetTileKey(candidate)] = GameRules:GetGameTime()
		+ RUBICK_ORIGIN_4_BLOCK_TILE_COOLDOWN
end
function boss_rubick_origin_4.prototype.GetSafeBlockTileHeight(self, tile)
	return math.min(RUBICK_ORIGIN_4_BLOCK_TILE_HEIGHT, tile.tileSize)
end
function boss_rubick_origin_4.prototype.StartRaiseTileWarning(self, token, tile)
	local warningParticle = self:PlayTileWarning(tile)
	SysTimers:CreateTimer(RUBICK_ORIGIN_4_BLOCK_WARNING_DURATION, function()
		ParticleManager:DestroyParticle(warningParticle, false)
		ParticleManager:ReleaseParticleIndex(warningParticle)
		if token == self.castToken then
			self:RaiseWarnedTile(tile)
		end
		return nil
	end)
end
function boss_rubick_origin_4.prototype.RaiseWarnedTile(self, tile)
	if not self:IsTileStillBlockable(tile) then
		return
	end
	local blockHeight = self:GetSafeBlockTileHeight(tile)
	local obstructions = MyGameDynamicFloor
			and MyGameDynamicFloor:SpawnTileObstructions(
				tile.floorId,
				{ tiles = { { gridColumn = tile.gridColumn, gridRow = tile.gridRow } } }
			)
		or {}
	__TS__ArrayPushArray(self.activeObstructions, obstructions)
	self.raisedTileRecords[self:GetTileKey(tile)] = {
		key = self:GetTileKey(tile),
		tile = tile,
		obstructions = obstructions,
	}
	if MyGameDynamicFloor ~= nil then
		MyGameDynamicFloor:PulseTile(tile.floorId, tile.gridColumn, tile.gridRow, {
			height = blockHeight,
			liftDuration = RUBICK_ORIGIN_4_BLOCK_TILE_LIFT_DURATION,
			liftMotion = "easeOut",
			holdDuration = RUBICK_ORIGIN_4_BLOCK_TILE_HOLD_DURATION,
			releaseDuration = RUBICK_ORIGIN_4_BLOCK_TILE_RELEASE_DURATION,
			releaseMotion = "spring",
		})
	end
	self:KnockUpUnitsOnTile(tile)
	SysTimers:CreateTimer(RUBICK_ORIGIN_4_BLOCK_TILE_TOTAL_DURATION, function()
		self:RemoveObstructions(obstructions)
		local ____opt_6 = self.raisedTileRecords[self:GetTileKey(tile)]
		if (____opt_6 and ____opt_6.obstructions) == obstructions then
			self.raisedTileRecords[self:GetTileKey(tile)] = nil
		end
		return nil
	end)
end
function boss_rubick_origin_4.prototype.PlayTileWarning(self, tile)
	local particle = ParticleManager:CreateParticle(RUBICK_ORIGIN_4_WARNING_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, tile.surfaceOrigin)
	ParticleManager:SetParticleControl(particle, 1, Vector(tile.radius, tile.radius, tile.radius))
	ParticleManager:SetParticleControl(particle, 10, Vector(RUBICK_ORIGIN_4_BLOCK_WARNING_DURATION, 0, 0))
	ParticleManager:SetParticleControl(particle, 11, tile.surfaceOrigin)
	return particle
end
function boss_rubick_origin_4.prototype.KnockUpUnitsOnTile(self, tile)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	for ____, unit in ipairs(self:FindEnemyUnitsOnTiles({ tile })) do
		do
			if not IsValidAlive(nil, unit) then
				goto __continue58
			end
			unit:KnockBack(caster, self, {
				duration = RUBICK_ORIGIN_4_BLOCK_KNOCKUP_DURATION,
				distance = 1,
				height = RUBICK_ORIGIN_4_BLOCK_KNOCKUP_HEIGHT,
				direction = Vector(0, 0, 0),
				heightType = "parabola",
				stun = true,
				stunDuration = RUBICK_ORIGIN_4_BLOCK_STUN_DURATION,
				block = false,
				ignore_walls = 1,
				removeOnDeath = true,
			})
		end
		::__continue58::
	end
end
function boss_rubick_origin_4.prototype.NormalizeRaisedTileUnderRubick(self, caster)
	local tile = self:GetUnitTile(caster)
	if not tile then
		return
	end
	local key = self:GetTileKey(tile)
	local record = self.raisedTileRecords[key]
	if not record then
		return
	end
	self:RemoveObstructions(record.obstructions)
	self.raisedTileRecords[key] = nil
	if MyGameDynamicFloor ~= nil then
		MyGameDynamicFloor:PulseTile(tile.floorId, tile.gridColumn, tile.gridRow, {
			height = 0,
			liftDuration = 0.05,
			liftMotion = "linear",
			holdDuration = 0,
			releaseDuration = 0.05,
			releaseMotion = "linear",
		})
	end
end
function boss_rubick_origin_4.prototype.IsTileStillBlockable(self, tile)
	return tile.isAvailable and not tile.isDisabled and not tile.modelRemoved
end
function boss_rubick_origin_4.prototype.RemoveObstructions(self, obstructions)
	for ____, obstruction in ipairs(obstructions) do
		if IsValid(nil, obstruction) then
			obstruction:RemoveSelf()
		end
	end
	self.activeObstructions = __TS__ArrayFilter(self.activeObstructions, function(____, active)
		return IsValid(nil, active)
	end)
end
function boss_rubick_origin_4.prototype.GetEscapeGridDirection(self, caster, target)
	if not IsValidAlive(nil, target) then
		return
	end
	local currentOrigin = target:GetAbsOrigin()
	local ____table_lastTargetOrigin_10
	if self.lastTargetOrigin then
		____table_lastTargetOrigin_10 = currentOrigin:__sub(self.lastTargetOrigin)
	else
		____table_lastTargetOrigin_10 = nil
	end
	local escape = ____table_lastTargetOrigin_10
	if not escape or escape:Length2D() <= 8 then
		escape = currentOrigin:__sub(caster:GetAbsOrigin())
	end
	if not escape or escape:Length2D() <= 0.001 then
		return nil
	end
	return self:GetCardinalDirectionFromVector(escape)
end
function boss_rubick_origin_4.prototype.PickEscapeBlockTile(self, targetTile, direction)
	local side = { dx = -direction.dy, dy = direction.dx }
	local preferFront = RandomFloat(0, 100) <= RUBICK_ORIGIN_4_FRONT_TILE_CHANCE
	local ____preferFront_11
	if preferFront then
		____preferFront_11 = { 0, -1, 1 }
	else
		____preferFront_11 = {
			RandomInt(0, 1) == 0 and -1 or 1,
			0,
		}
	end
	local lateralCandidates = ____preferFront_11
	local distanceCandidates = { 1, 2, 3 }
	for ____, distance in ipairs(distanceCandidates) do
		for ____, lateral in ipairs(lateralCandidates) do
			local tile = self:GetTileByGrid(
				targetTile.floorId,
				targetTile.gridColumn + direction.dx * distance + side.dx * lateral,
				targetTile.gridRow + direction.dy * distance + side.dy * lateral
			)
			if tile and self:CanRaiseTile(tile) then
				return tile
			end
		end
	end
	return nil
end
function boss_rubick_origin_4.prototype.CanRaiseTile(self, tile)
	if not tile.isAvailable or tile.isDisabled or tile.modelRemoved then
		return false
	end
	local cooldownUntil = self.blockedTileCooldowns[self:GetTileKey(tile)] or 0
	return GameRules:GetGameTime() >= cooldownUntil
end
function boss_rubick_origin_4.prototype.GetFlatDirection(self, direction)
	local flat = Vector(direction.x, direction.y, 0)
	if flat:Length2D() <= 0.001 then
		return nil
	end
	return flat:Normalized()
end
function boss_rubick_origin_4.prototype.GetTileKey(self, tile)
	return (((tile.floorId .. ":") .. tostring(tile.gridColumn)) .. ":") .. tostring(tile.gridRow)
end
boss_rubick_origin_4 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_rubick_origin_4)
____exports.boss_rubick_origin_4 = boss_rubick_origin_4
return ____exports