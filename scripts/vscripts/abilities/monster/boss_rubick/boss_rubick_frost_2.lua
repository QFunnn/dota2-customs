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
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____base_rubick_origin_ability = require("abilities.monster.boss_rubick.base_rubick_origin_ability")
local RubickOriginAbility = ____base_rubick_origin_ability.RubickOriginAbility
--- 技能最大索敌距离。
local RUBICK_FROST_2_CAST_RANGE = 3000
--- 飞跃到当前可用棋盘边缘的时间。
local RUBICK_FROST_2_CAST_POINT = 0.75
--- 边缘飞跃的抛物线高度。
local RUBICK_FROST_2_EDGE_JUMP_HEIGHT = 360
--- 落到边缘时向棋盘外侧额外偏移的比例。
local RUBICK_FROST_2_EDGE_OUTSIDE_OFFSET_RATIO = 0.35
--- 每次 trick shot 动作的完整时长。
local RUBICK_FROST_2_ACTION_DURATION = 0.7
--- 每次动作开始后发射投射物的时间点。
local RUBICK_FROST_2_PROJECTILE_FIRE_TIME = 0.4
--- 每次喷发前的线性预警时间。
local RUBICK_FROST_2_WARNING_DURATION = 0.35
--- 冰霜投射物发射间隔。
local RUBICK_FROST_2_PROJECTILE_INTERVAL = RUBICK_FROST_2_ACTION_DURATION
--- 冰霜投射物发射次数。
local RUBICK_FROST_2_PROJECTILE_COUNT = 5
--- 整体动作持续时间。
local RUBICK_FROST_2_TOTAL_DURATION = RUBICK_FROST_2_PROJECTILE_COUNT * RUBICK_FROST_2_ACTION_DURATION
--- 冰霜投射物飞行速度
local RUBICK_FROST_2_PROJECTILE_SPEED = 3000
--- 冰霜投射物飞行距离。
local RUBICK_FROST_2_PROJECTILE_DISTANCE = 2600
--- 冰霜投射物碰撞宽度。
local RUBICK_FROST_2_PROJECTILE_WIDTH = 180
--- 冰霜投射物起点高度。
local RUBICK_FROST_2_PROJECTILE_HEIGHT = 128
--- 冰霜投射物起点前移距离。
local RUBICK_FROST_2_PROJECTILE_FORWARD_OFFSET = 120
--- 命中伤害系数。
local RUBICK_FROST_2_DAMAGE_RATE = 18
--- 冰缓满层层数，与通用冰冻 Debuff 上限保持一致。
local RUBICK_FROST_2_ICE_SLOW_FULL_STACK = 10
--- 冰缓持续时间。
local RUBICK_FROST_2_ICE_SLOW_DURATION = 4
--- 每次发射前播放的戏法射击动作。
local RUBICK_FROST_2_CAST_ANIMATION = "rubick_steal_mrta_trick_shot"
--- 冰霜投射物特效。
local RUBICK_FROST_2_PROJECTILE_PARTICLE =
	"particles/econ/items/jakiro/jakiro_ti8_immortal_head/jakiro_ti8_dual_breath_ice.vpcf"
--- 命中后复用的冰缓表现。
local RUBICK_FROST_2_SLOW_STATUS_PARTICLE = "particles/status_fx/status_effect_frost_armor.vpcf"
____exports.boss_rubick_frost_2 = __TS__Class()
local boss_rubick_frost_2 = ____exports.boss_rubick_frost_2
boss_rubick_frost_2.name = "boss_rubick_frost_2"
__TS__ClassExtends(boss_rubick_frost_2, RubickOriginAbility)
function boss_rubick_frost_2.prototype.____constructor(self, ...)
	RubickOriginAbility.prototype.____constructor(self, ...)
	self.castToken = 0
end
function boss_rubick_frost_2.prototype.Precache(self, context)
	PrecacheResource("particle", RUBICK_FROST_2_PROJECTILE_PARTICLE, context)
	PrecacheResource("particle", RUBICK_FROST_2_SLOW_STATUS_PARTICLE, context)
end
function boss_rubick_frost_2.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = RUBICK_FROST_2_CAST_RANGE,
		castAnimation = "",
		castPoint = RUBICK_FROST_2_CAST_POINT,
		castDuration = RUBICK_FROST_2_TOTAL_DURATION,
		canCast = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return UF_FAIL_CUSTOM
			end
			local ____caster_GetMinDistanceUnit_result_0
			if caster:GetMinDistanceUnit(RUBICK_FROST_2_CAST_RANGE) then
				____caster_GetMinDistanceUnit_result_0 = UF_SUCCESS
			else
				____caster_GetMinDistanceUnit_result_0 = UF_FAIL_CUSTOM
			end
			return ____caster_GetMinDistanceUnit_result_0
		end,
		OnPhaseStart = function()
			return self:PrepareFrostBarrage()
		end,
		OnStart = function()
			return self:StartFrostBarrage(self.castToken)
		end,
		OnInterrupt = function()
			self.castToken = self.castToken + 1
		end,
	}
end
function boss_rubick_frost_2.prototype.PrepareFrostBarrage(self)
	local caster = self:GetCaster()
	self.castToken = self.castToken + 1
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = caster:GetMinDistanceUnit(RUBICK_FROST_2_CAST_RANGE)
	if target and IsValidAlive(nil, target) then
		self.lockedTarget = target
		caster:LockTargetForSpeed(target, RUBICK_FROST_2_CAST_POINT + RUBICK_FROST_2_TOTAL_DURATION, 6)
		self:MoveCasterToFrostEdge(caster, target)
	end
end
function boss_rubick_frost_2.prototype.StartFrostBarrage(self, token)
	do
		local index = 0
		while index < RUBICK_FROST_2_PROJECTILE_COUNT do
			local actionDelay = index * RUBICK_FROST_2_PROJECTILE_INTERVAL
			local warningDelay =
				math.max(0, actionDelay + RUBICK_FROST_2_PROJECTILE_FIRE_TIME - RUBICK_FROST_2_WARNING_DURATION)
			SysTimers:CreateTimer(actionDelay, function()
				if not self:IsCurrentCast(token) then
					return nil
				end
				self:PlayCastAnimation()
				return nil
			end)
			SysTimers:CreateTimer(warningDelay, function()
				if not self:IsCurrentCast(token) then
					return nil
				end
				self:PlayProjectileWarning()
				return nil
			end)
			SysTimers:CreateTimer(actionDelay + RUBICK_FROST_2_PROJECTILE_FIRE_TIME, function()
				if not self:IsCurrentCast(token) then
					return nil
				end
				self:FireFrostProjectile()
				return nil
			end)
			index = index + 1
		end
	end
end
function boss_rubick_frost_2.prototype.IsCurrentCast(self, token)
	return token == self.castToken and IsValidAlive(nil, self:GetCaster())
end
function boss_rubick_frost_2.prototype.PlayCastAnimation(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = self.lockedTarget
	if target and IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, RUBICK_FROST_2_ACTION_DURATION, 8)
	end
	caster:SetAnimation(RUBICK_FROST_2_CAST_ANIMATION)
end
function boss_rubick_frost_2.prototype.MoveCasterToFrostEdge(self, caster, target)
	local edgeTile = self:FindFrostEdgeTile(caster, target)
	if not edgeTile then
		return
	end
	local startPos = caster:GetAbsOrigin()
	local targetDirection = GetDirection(nil, target:GetAbsOrigin(), edgeTile.origin)
	local outsideDirection = Vector(-targetDirection.x, -targetDirection.y, 0)
	local retreatPos = edgeTile.origin:__add(
		Vector(
			outsideDirection.x * edgeTile.tileSize * RUBICK_FROST_2_EDGE_OUTSIDE_OFFSET_RATIO,
			outsideDirection.y * edgeTile.tileSize * RUBICK_FROST_2_EDGE_OUTSIDE_OFFSET_RATIO,
			0
		)
	)
	local peak = Vector(
		(startPos.x + retreatPos.x) / 2,
		(startPos.y + retreatPos.y) / 2,
		math.max(startPos.z, retreatPos.z) + RUBICK_FROST_2_EDGE_JUMP_HEIGHT
	)
	caster:Bezier2Mover({ startPos, peak, retreatPos }, RUBICK_FROST_2_CAST_POINT, nil, true, true)
	SysTimers:CreateTimer(RUBICK_FROST_2_CAST_POINT, function()
		if IsValidAlive(nil, caster) and IsValidAlive(nil, target) then
			caster:LockTargetForSpeed(target, RUBICK_FROST_2_TOTAL_DURATION, 8)
		end
		return nil
	end)
end
function boss_rubick_frost_2.prototype.FindFrostEdgeTile(self, caster, target)
	if not MyGameDynamicFloor then
		return nil
	end
	local casterTile = self:ResolveUsableTile(caster)
	local targetTile = self:ResolveUsableTile(target)
	local floorId = casterTile and casterTile.floorId or targetTile and targetTile.floorId
	if not floorId then
		return nil
	end
	local reference = casterTile or targetTile
	local boundaryTiles = MyGameDynamicFloor:GetAvailableBoundaryTiles(floorId)
	if not reference or #boundaryTiles <= 0 then
		return reference
	end
	local targetOrigin = target:GetAbsOrigin()
	local bestTile
	local bestScore = -999999
	for ____, tile in ipairs(boundaryTiles) do
		local awayScore = GetDistance(nil, tile.origin, targetOrigin)
		local casterScore = -GetDistance(nil, tile.origin, caster:GetAbsOrigin()) * 0.25
		local score = awayScore + casterScore
		if not bestTile or score > bestScore then
			bestTile = tile
			bestScore = score
		end
	end
	return bestTile
end
function boss_rubick_frost_2.prototype.ResolveUsableTile(self, unit)
	local tile = self:GetUnitTile(unit)
	if tile and tile.isAvailable and not tile.isDisabled and not tile.modelRemoved then
		return tile
	end
	if not tile or not MyGameDynamicFloor then
		return nil
	end
	local result = MyGameDynamicFloor:GetNearestAvailableTileCenter(tile.floorId, unit:GetAbsOrigin())
	if not result.success or result.gridColumn == nil or result.gridRow == nil then
		return nil
	end
	return self:GetTileByGrid(tile.floorId, result.gridColumn, result.gridRow)
end
function boss_rubick_frost_2.prototype.PlayProjectileWarning(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local startPoint = self:GetProjectileStartPoint(caster)
	local endPoint = self:GetProjectileEndPoint(startPoint, caster:GetForwardVector())
	self:WarningEffect(startPoint, endPoint, RUBICK_FROST_2_WARNING_DURATION, {
		startWidth = RUBICK_FROST_2_PROJECTILE_WIDTH,
		endWidth = RUBICK_FROST_2_PROJECTILE_WIDTH,
		getDirection = function()
			return caster:GetForwardVector()
		end,
	})
end
function boss_rubick_frost_2.prototype.FireFrostProjectile(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local direction = caster:GetForwardVector()
	local startPoint = self:GetProjectileStartPoint(caster)
	local endPoint = self:GetProjectileEndPoint(startPoint, direction)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = RUBICK_FROST_2_PROJECTILE_PARTICLE,
		projectile_type = "linear",
		start_point = startPoint,
		target = endPoint,
		projectile_speed = RUBICK_FROST_2_PROJECTILE_SPEED,
		projectile_distance = RUBICK_FROST_2_PROJECTILE_DISTANCE,
		projectile_range = RUBICK_FROST_2_PROJECTILE_WIDTH,
		projectile_end_range = RUBICK_FROST_2_PROJECTILE_WIDTH,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			if not IsValidAlive(nil, caster) then
				return true
			end
			caster:MonsterDamage({ victim = hitTarget, damage_rate = RUBICK_FROST_2_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(
				nil,
				hitTarget,
				caster,
				self,
				DebuffStatusType.ICE_SLOW,
				{
					stack = RUBICK_FROST_2_ICE_SLOW_FULL_STACK,
					duration = RUBICK_FROST_2_ICE_SLOW_DURATION,
					status_effect_name = RUBICK_FROST_2_SLOW_STATUS_PARTICLE,
				}
			)
			return false
		end,
	})
end
function boss_rubick_frost_2.prototype.GetProjectileStartPoint(self, caster)
	local attachment = caster:ScriptLookupAttachment("attach_attack1")
	if attachment > 0 then
		return caster:GetAttachmentOrigin(attachment)
	end
	return caster
		:GetAbsOrigin()
		:__add(Vector(0, 0, RUBICK_FROST_2_PROJECTILE_HEIGHT))
		:__add(caster:GetForwardVector():__mul(RUBICK_FROST_2_PROJECTILE_FORWARD_OFFSET))
end
function boss_rubick_frost_2.prototype.GetProjectileEndPoint(self, startPoint, direction)
	local flatDirection = Vector(direction.x, direction.y, 0)
	local length = flatDirection:Length2D()
	local ____temp_5
	if length > 0.01 then
		____temp_5 = flatDirection:__mul(1 / length)
	else
		____temp_5 = Vector(1, 0, 0)
	end
	local normalized = ____temp_5
	return startPoint:__add(normalized:__mul(RUBICK_FROST_2_PROJECTILE_DISTANCE))
end
boss_rubick_frost_2 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_rubick_frost_2)
____exports.boss_rubick_frost_2 = boss_rubick_frost_2
return ____exports