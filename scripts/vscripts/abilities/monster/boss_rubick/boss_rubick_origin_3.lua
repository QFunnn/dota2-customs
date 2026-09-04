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
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____base_rubick_origin_ability = require("abilities.monster.boss_rubick.base_rubick_origin_ability")
local RubickOriginAbility = ____base_rubick_origin_ability.RubickOriginAbility
--- 技能最大索敌距离。
local RUBICK_ORIGIN_3_CAST_RANGE = 3000
--- 下砸前蓄力预警时间，对应 Rubick 准备起跳动作。
local RUBICK_ORIGIN_3_CAST_POINT = 1.5
--- Rubick 起跳到落点的时间，承接从蓄力阶段挪出的演出时间。
local RUBICK_ORIGIN_3_JUMP_DURATION = 1.39
--- Rubick 起跳高度。
local RUBICK_ORIGIN_3_JUMP_HEIGHT = 1500
--- 起跳时脚下地块上弹高度。
local RUBICK_ORIGIN_3_LAUNCH_TILE_HEIGHT = 360
--- 起跳地块上弹时间。
local RUBICK_ORIGIN_3_LAUNCH_TILE_LIFT_DURATION = 0.16
--- 起跳地块停留时间。
local RUBICK_ORIGIN_3_LAUNCH_TILE_HOLD_DURATION = 0.04
--- 起跳地块回落时间。
local RUBICK_ORIGIN_3_LAUNCH_TILE_RELEASE_DURATION = 0.34
--- 起跳地块冲击伤害倍率。
local RUBICK_ORIGIN_3_LAUNCH_DAMAGE_RATE = 10
--- 起跳地块命中击飞持续时间。
local RUBICK_ORIGIN_3_LAUNCH_KNOCKBACK_DURATION = 0.18
--- 起跳地块命中击飞高度。
local RUBICK_ORIGIN_3_LAUNCH_KNOCKBACK_HEIGHT = 180
--- 蓄力动作：预警并准备起跳。
local RUBICK_ORIGIN_3_CHARGE_ANIMATION = "rubick_steal_mk_cast04_spring"
--- 空中动作：无限循环的空中翻滚。
local RUBICK_ORIGIN_3_AIR_ANIMATION = "rubick_steal_mk_spring_jumping_soar"
--- 落地动作：落地并准备砸地。
local RUBICK_ORIGIN_3_LAND_ANIMATION = "rubick_steal_arm_tail_thump"
--- 落地动作总时长。
local RUBICK_ORIGIN_3_LAND_ANIMATION_DURATION = 0.53
--- 最终下砸动作提前播放时间，只提前动画，不提前落地位移结算。
local RUBICK_ORIGIN_3_LAND_ANIMATION_LEAD_TIME = 0.25
--- 下砸冲击提前触发时间，不改变 Boss 本体动作流程。
local RUBICK_ORIGIN_3_IMPACT_LEAD_TIME = 0.3
--- 真实落点后触发砸地的延迟。
local RUBICK_ORIGIN_3_LAND_IMPACT_DELAY = 0
--- 三层冲击的最大棋盘距离。
local RUBICK_ORIGIN_3_MAX_RING = 2
--- 外圈冲击延迟，让地板有扩散波感。
local RUBICK_ORIGIN_3_RING_DELAY = 0.03
--- 中心地块下沉高度。
local RUBICK_ORIGIN_3_CENTER_SINK_HEIGHT = -320
--- 第一圈地块下沉高度。
local RUBICK_ORIGIN_3_INNER_SINK_HEIGHT = -230
--- 第二圈地块下沉高度。
local RUBICK_ORIGIN_3_OUTER_SINK_HEIGHT = -180
--- 地块被压下的时间。
local RUBICK_ORIGIN_3_SINK_DURATION = 0.3
--- 地块最低点停留时间。
local RUBICK_ORIGIN_3_HOLD_DURATION = 0.1
--- 地块弹簧回弹时间。
local RUBICK_ORIGIN_3_RELEASE_DURATION = 0.6
--- Rubick 落地后跟随地块下压的深度。
local RUBICK_ORIGIN_3_CASTER_SINK_HEIGHT = -110
--- 中心伤害倍率。
local RUBICK_ORIGIN_3_CENTER_DAMAGE_RATE = 26
--- 第一圈伤害倍率。
local RUBICK_ORIGIN_3_INNER_DAMAGE_RATE = 16
--- 第二圈伤害倍率。
local RUBICK_ORIGIN_3_OUTER_DAMAGE_RATE = 9
--- 命中击退持续时间。
local RUBICK_ORIGIN_3_KNOCKBACK_DURATION = 0.24
--- 中心命中击飞高度。
local RUBICK_ORIGIN_3_CENTER_KNOCKBACK_HEIGHT = 300
--- 外圈命中击飞高度。
local RUBICK_ORIGIN_3_RING_KNOCKBACK_HEIGHT = 170
--- 外圈命中向外推开的距离。
local RUBICK_ORIGIN_3_RING_KNOCKBACK_DISTANCE = 150
--- 冲击预警粒子。
local RUBICK_ORIGIN_3_WARNING_PARTICLE = "particles/rebuild/spell/rubick_boss/cube_aura/effect_flame/effect.vpcf"
--- 落地冲击粒子。
local RUBICK_ORIGIN_3_IMPACT_PARTICLE = "particles/tower_bad_destroy3.vpcf"
--- 拉比克原始技能三：奥术坠击。
--
-- 技能形态：
-- 1. Rubick 蓄力锁定目标脚下地块，并预警三层冲击区域。
-- 2. 蓄力结束后 Rubick 起跳，沿抛物线砸向目标地块中心。
-- 3. 落地瞬间触发三层地板弹簧波：中心下沉最深，外圈逐层减弱。
-- 4. 命中单位按所在层级受到不同伤害和击飞/击退。
-- 5. 当前版本不永久破坏地块，先验证本体动作与地板响应的体感。
____exports.boss_rubick_origin_3 = __TS__Class()
local boss_rubick_origin_3 = ____exports.boss_rubick_origin_3
boss_rubick_origin_3.name = "boss_rubick_origin_3"
__TS__ClassExtends(boss_rubick_origin_3, RubickOriginAbility)
function boss_rubick_origin_3.prototype.____constructor(self, ...)
	RubickOriginAbility.prototype.____constructor(self, ...)
	self.castToken = 0
	self.impactTiles = {}
	self.warningParticles = {}
end
function boss_rubick_origin_3.prototype.Precache(self, context)
	PrecacheResource("particle", RUBICK_ORIGIN_3_WARNING_PARTICLE, context)
	PrecacheResource("particle", RUBICK_ORIGIN_3_IMPACT_PARTICLE, context)
end
function boss_rubick_origin_3.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = RUBICK_ORIGIN_3_CAST_RANGE,
		castAnimation = "",
		castPoint = RUBICK_ORIGIN_3_CAST_POINT,
		castDuration = RUBICK_ORIGIN_3_JUMP_DURATION + math.max(
			RUBICK_ORIGIN_3_LAND_ANIMATION_DURATION,
			RUBICK_ORIGIN_3_LAND_IMPACT_DELAY
				+ RUBICK_ORIGIN_3_RING_DELAY * RUBICK_ORIGIN_3_MAX_RING
				+ RUBICK_ORIGIN_3_SINK_DURATION
				+ RUBICK_ORIGIN_3_HOLD_DURATION
				+ RUBICK_ORIGIN_3_RELEASE_DURATION
		),
		canCast = function()
			local target = self:GetCaster():GetMinDistanceUnit(RUBICK_ORIGIN_3_CAST_RANGE)
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
			return self:PrepareSlam()
		end,
		OnStart = function()
			return self:StartSlam(self.castToken)
		end,
		OnInterrupt = function()
			self.castToken = self.castToken + 1
			self:ClearWarnings()
		end,
		OnFinish = function()
			self:ClearWarnings()
		end,
	}
end
function boss_rubick_origin_3.prototype.PrepareSlam(self)
	local caster = self:GetCaster()
	local target = caster:GetMinDistanceUnit(RUBICK_ORIGIN_3_CAST_RANGE)
	self.castToken = self.castToken + 1
	self.lockedTile = nil
	self.impactTiles = {}
	self:ClearWarnings()
	if not IsValidAlive(nil, target) then
		return
	end
	caster:SetAnimation(RUBICK_ORIGIN_3_CHARGE_ANIMATION)
	caster:LockTargetForSpeed(
		target,
		RUBICK_ORIGIN_3_CAST_POINT + RUBICK_ORIGIN_3_JUMP_DURATION + RUBICK_ORIGIN_3_LAND_IMPACT_DELAY,
		6
	)
	local targetTile = self:GetUnitTile(target)
	if not targetTile then
		return
	end
	self.lockedTile = targetTile
	self.impactTiles = self:BuildImpactTiles(targetTile)
	self:PlayWarnings(
		self.impactTiles,
		RUBICK_ORIGIN_3_CAST_POINT + RUBICK_ORIGIN_3_JUMP_DURATION + RUBICK_ORIGIN_3_LAND_IMPACT_DELAY
	)
end
function boss_rubick_origin_3.prototype.StartSlam(self, token)
	local caster = self:GetCaster()
	local lockedTile = self.lockedTile
	if token ~= self.castToken or not lockedTile or not IsValidAlive(nil, caster) then
		return
	end
	local startPos = caster:GetAbsOrigin()
	local landPos = self:GetLandingPosition(lockedTile, caster)
	self:PlayLaunchTileSpring(token)
	local peak = Vector(
		(startPos.x + landPos.x) / 2,
		(startPos.y + landPos.y) / 2,
		math.max(startPos.z, landPos.z) + RUBICK_ORIGIN_3_JUMP_HEIGHT
	)
	caster:SetAnimation(RUBICK_ORIGIN_3_AIR_ANIMATION)
	caster:Bezier2Mover({ startPos, peak, landPos }, RUBICK_ORIGIN_3_JUMP_DURATION, nil, true, true)
	SysTimers:CreateTimer(math.max(0, RUBICK_ORIGIN_3_JUMP_DURATION - RUBICK_ORIGIN_3_IMPACT_LEAD_TIME), function()
		if token ~= self.castToken or not IsValidAlive(nil, caster) then
			return nil
		end
		self:ExecuteSlam(token)
		return nil
	end)
	SysTimers:CreateTimer(
		math.max(0, RUBICK_ORIGIN_3_JUMP_DURATION - RUBICK_ORIGIN_3_LAND_ANIMATION_LEAD_TIME),
		function()
			if token ~= self.castToken or not IsValidAlive(nil, caster) then
				return nil
			end
			caster:SetAnimation(RUBICK_ORIGIN_3_LAND_ANIMATION)
			return nil
		end
	)
	SysTimers:CreateTimer(RUBICK_ORIGIN_3_JUMP_DURATION + 0.03, function()
		if token ~= self.castToken or not IsValidAlive(nil, caster) then
			return nil
		end
		FindClearSpaceForUnit(caster, landPos, true)
		self:StartRubickLandingSpring(token, landPos)
		return nil
	end)
end
function boss_rubick_origin_3.prototype.PlayLaunchTileSpring(self, token)
	if token ~= self.castToken or not MyGameDynamicFloor then
		return
	end
	local caster = self:GetCaster()
	local launchTile = self:GetUnitTile(caster)
	if not launchTile or not self:CanUseTile(launchTile) then
		return
	end
	MyGameDynamicFloor:PulseTile(launchTile.floorId, launchTile.gridColumn, launchTile.gridRow, {
		height = RUBICK_ORIGIN_3_LAUNCH_TILE_HEIGHT,
		liftDuration = RUBICK_ORIGIN_3_LAUNCH_TILE_LIFT_DURATION,
		liftMotion = "easeOut",
		holdDuration = RUBICK_ORIGIN_3_LAUNCH_TILE_HOLD_DURATION,
		releaseDuration = RUBICK_ORIGIN_3_LAUNCH_TILE_RELEASE_DURATION,
		releaseMotion = "spring",
	})
	local direction = self:GetFlatForward(caster)
	for ____, unit in ipairs(self:FindEnemyUnitsOnTiles({ launchTile })) do
		do
			if not IsValidAlive(nil, unit) then
				goto __continue24
			end
			caster:MonsterDamage({ victim = unit, damage_rate = RUBICK_ORIGIN_3_LAUNCH_DAMAGE_RATE, ability = self })
			unit:KnockBack(caster, self, {
				duration = RUBICK_ORIGIN_3_LAUNCH_KNOCKBACK_DURATION,
				distance = 1,
				height = RUBICK_ORIGIN_3_LAUNCH_KNOCKBACK_HEIGHT,
				direction = direction,
				heightType = "parabola",
				block = false,
				ignore_walls = 1,
				removeOnDeath = true,
			})
		end
		::__continue24::
	end
end
function boss_rubick_origin_3.prototype.StartRubickLandingSpring(self, token, basePos)
	local caster = self:GetCaster()
	if token ~= self.castToken or not IsValidAlive(nil, caster) then
		return
	end
	self:AnimateCasterVerticalOffset(
		token,
		basePos,
		0,
		RUBICK_ORIGIN_3_CASTER_SINK_HEIGHT,
		RUBICK_ORIGIN_3_SINK_DURATION,
		"easeIn",
		function()
			SysTimers:CreateTimer(RUBICK_ORIGIN_3_HOLD_DURATION, function()
				if token ~= self.castToken or not IsValidAlive(nil, caster) then
					return nil
				end
				self:AnimateCasterVerticalOffset(
					token,
					basePos,
					RUBICK_ORIGIN_3_CASTER_SINK_HEIGHT,
					0,
					RUBICK_ORIGIN_3_RELEASE_DURATION,
					"spring",
					function()
						if token ~= self.castToken or not IsValidAlive(nil, caster) then
							return
						end
						FindClearSpaceForUnit(caster, basePos, true)
					end
				)
				return nil
			end)
		end
	)
end
function boss_rubick_origin_3.prototype.AnimateCasterVerticalOffset(
	self,
	token,
	basePos,
	startOffsetZ,
	targetOffsetZ,
	duration,
	motion,
	onFinish
)
	local caster = self:GetCaster()
	local startTime = GameRules:GetGameTime()
	local safeDuration = math.max(0.03, duration)
	SysTimers:CreateTimer(0, function()
		if token ~= self.castToken or not IsValidAlive(nil, caster) then
			return nil
		end
		local elapsed = GameRules:GetGameTime() - startTime
		local progress = math.min(1, elapsed / safeDuration)
		local offsetZ = startOffsetZ + (targetOffsetZ - startOffsetZ) * self:GetMotionProgress(progress, motion)
		caster:SetAbsOrigin(Vector(basePos.x, basePos.y, basePos.z + offsetZ))
		if progress >= 1 then
			caster:SetAbsOrigin(Vector(basePos.x, basePos.y, basePos.z + targetOffsetZ))
			local ____ = onFinish and onFinish(nil)
			return nil
		end
		return FrameTime()
	end)
end
function boss_rubick_origin_3.prototype.ExecuteSlam(self, token)
	if token ~= self.castToken then
		return
	end
	self:ClearWarnings()
	self:PlayImpactParticle(self.lockedTile)
	do
		local ring = 0
		while ring <= RUBICK_ORIGIN_3_MAX_RING do
			local currentRing = ring
			SysTimers:CreateTimer(currentRing * RUBICK_ORIGIN_3_RING_DELAY, function()
				if token ~= self.castToken then
					return nil
				end
				local tiles = self:GetImpactTilesByRing(currentRing)
				self:PulseTiles(tiles, currentRing)
				self:DamageUnitsOnRing(tiles, currentRing)
				return nil
			end)
			ring = ring + 1
		end
	end
end
function boss_rubick_origin_3.prototype.BuildImpactTiles(self, centerTile)
	local tiles = {}
	do
		local dx = -RUBICK_ORIGIN_3_MAX_RING
		while dx <= RUBICK_ORIGIN_3_MAX_RING do
			do
				local dy = -RUBICK_ORIGIN_3_MAX_RING
				while dy <= RUBICK_ORIGIN_3_MAX_RING do
					do
						local ring = math.max(math.abs(dx), math.abs(dy))
						if ring > RUBICK_ORIGIN_3_MAX_RING then
							goto __continue45
						end
						local tile =
							self:GetTileByGrid(centerTile.floorId, centerTile.gridColumn + dx, centerTile.gridRow + dy)
						if tile and self:CanUseTile(tile) then
							tiles[#tiles + 1] = { tile = tile, ring = ring }
						end
					end
					::__continue45::
					dy = dy + 1
				end
			end
			dx = dx + 1
		end
	end
	return tiles
end
function boss_rubick_origin_3.prototype.PlayWarnings(self, tiles, duration)
	for ____, item in ipairs(tiles) do
		local particle = ParticleManager:CreateParticle(RUBICK_ORIGIN_3_WARNING_PARTICLE, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(particle, 0, item.tile.surfaceOrigin)
		ParticleManager:SetParticleControl(particle, 1, Vector(item.tile.radius, item.tile.radius, item.tile.radius))
		ParticleManager:SetParticleControl(particle, 10, Vector(duration, 0, 0))
		ParticleManager:SetParticleControl(particle, 11, item.tile.surfaceOrigin)
		local ____self_warningParticles_1 = self.warningParticles
		____self_warningParticles_1[#____self_warningParticles_1 + 1] = particle
	end
end
function boss_rubick_origin_3.prototype.PulseTiles(self, tiles, ring)
	if not MyGameDynamicFloor then
		print(("[RubickOrigin3] 下陷失败 ring=" .. tostring(ring)) .. " reason=MyGameDynamicFloor 不存在")
		return
	end
	local height = self:GetSinkHeight(ring)
	print(
		(((("[RubickOrigin3] 开始下陷 ring=" .. tostring(ring)) .. " count=") .. tostring(#tiles)) .. " height=")
			.. tostring(height)
	)
	for ____, tile in ipairs(tiles) do
		local success = MyGameDynamicFloor:PulseTile(tile.floorId, tile.gridColumn, tile.gridRow, {
			height = height,
			liftDuration = RUBICK_ORIGIN_3_SINK_DURATION,
			liftMotion = "easeIn",
			holdDuration = RUBICK_ORIGIN_3_HOLD_DURATION,
			releaseDuration = RUBICK_ORIGIN_3_RELEASE_DURATION,
			releaseMotion = "spring",
		})
		print(
			(
				(
					(
						(
							(
								(
									(
										(("[RubickOrigin3] 下陷方块 ring=" .. tostring(ring)) .. " floor=")
										.. tile.floorId
									) .. " grid=("
								) .. tostring(tile.gridColumn)
							) .. ","
						) .. tostring(tile.gridRow)
					) .. ") "
				)
				.. ((((("origin=(" .. tostring(math.floor(tile.origin.x))) .. ",") .. tostring(
					math.floor(tile.origin.y)
				)) .. ",") .. tostring(math.floor(tile.origin.z)))
				.. ") "
			)
				.. (("height=" .. tostring(height)) .. " success=")
				.. tostring(success and 1 or 0)
		)
	end
end
function boss_rubick_origin_3.prototype.DamageUnitsOnRing(self, tiles, ring)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or #tiles <= 0 then
		return
	end
	for ____, unit in ipairs(self:FindEnemyUnitsOnTiles(tiles)) do
		do
			if not IsValidAlive(nil, unit) then
				goto __continue57
			end
			caster:MonsterDamage({
				victim = unit,
				damage_rate = self:GetDamageRate(ring),
				ability = self,
			})
			self:KnockUnitFromSlam(unit, ring)
		end
		::__continue57::
	end
end
function boss_rubick_origin_3.prototype.KnockUnitFromSlam(self, unit, ring)
	local centerTile = self.lockedTile
	local caster = self:GetCaster()
	if not centerTile or not IsValidAlive(nil, caster) then
		return
	end
	if not IsValidAlive(nil, unit) then
		return
	end
	local unitOrigin = unit:GetAbsOrigin()
	local rawDirection = unitOrigin:__sub(centerTile.origin)
	local rawDistance = rawDirection:Length2D()
	local direction
	if rawDistance > 0.001 then
		direction = Vector(rawDirection.x, rawDirection.y, 0):Normalized()
	else
		local forward = caster:GetForwardVector()
		direction = Vector(forward.x, forward.y, 0)
		if direction:Length2D() > 0.001 then
			direction = direction:Normalized()
		else
			direction = Vector(1, 0, 0)
		end
	end
	local distance = ring == 0 and 1 or RUBICK_ORIGIN_3_RING_KNOCKBACK_DISTANCE
	local height = ring == 0 and RUBICK_ORIGIN_3_CENTER_KNOCKBACK_HEIGHT or RUBICK_ORIGIN_3_RING_KNOCKBACK_HEIGHT
	print(
		(
			(
				(
					(
						((("[RubickOrigin3] 击飞开始 ring=" .. tostring(ring)) .. " unit=") .. unit:GetUnitName())
						.. " "
					)
					.. ((((("pos=(" .. tostring(math.floor(unitOrigin.x))) .. ",") .. tostring(math.floor(unitOrigin.y))) .. ",") .. tostring(
						math.floor(unitOrigin.z)
					))
					.. ") "
				)
				.. ((((("center=(" .. tostring(math.floor(centerTile.origin.x))) .. ",") .. tostring(
					math.floor(centerTile.origin.y)
				)) .. ",") .. tostring(math.floor(centerTile.origin.z)))
				.. ") "
			)
			.. ((((((("rawDistance=" .. tostring(math.floor(rawDistance))) .. " direction=(") .. tostring(direction.x)) .. ",") .. tostring(
				direction.y
			)) .. ",") .. tostring(direction.z))
			.. ") "
		)
			.. (("distance=" .. tostring(distance)) .. " height=")
			.. tostring(height)
	)
	unit:KnockBack(caster, self, {
		duration = RUBICK_ORIGIN_3_KNOCKBACK_DURATION,
		distance = distance,
		height = height,
		direction = direction,
		heightType = "parabola",
		block = false,
		ignore_walls = 1,
		removeOnDeath = true,
	})
	SysTimers:CreateTimer(RUBICK_ORIGIN_3_KNOCKBACK_DURATION + 0.08, function()
		if not IsValidAlive(nil, unit) then
			return nil
		end
		local endOrigin = unit:GetAbsOrigin()
		print(
			(("[RubickOrigin3] 击飞结束 unit=" .. unit:GetUnitName()) .. " ")
				.. ((((("pos=(" .. tostring(math.floor(endOrigin.x))) .. ",") .. tostring(math.floor(endOrigin.y))) .. ",") .. tostring(
					math.floor(endOrigin.z)
				))
				.. ")"
		)
		return nil
	end)
end
function boss_rubick_origin_3.prototype.PlayImpactParticle(self, tile)
	if not tile then
		return
	end
	local particle = ParticleManager:CreateParticle(RUBICK_ORIGIN_3_IMPACT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, tile.origin)
	ParticleManager:SetParticleControl(particle, 3, Vector(tile.modelScale, 0, 0))
	SysTimers:CreateTimer(1.8, function()
		ParticleManager:DestroyParticle(particle, true)
		ParticleManager:ReleaseParticleIndex(particle)
		return nil
	end)
end
function boss_rubick_origin_3.prototype.GetImpactTilesByRing(self, ring)
	return __TS__ArrayMap(
		__TS__ArrayFilter(self.impactTiles, function(____, item)
			return item.ring == ring
		end),
		function(____, item)
			return item.tile
		end
	)
end
function boss_rubick_origin_3.prototype.GetLandingPosition(self, tile, caster)
	local groundZ = GetGroundHeight(tile.origin, caster) or tile.origin.z
	return Vector(tile.origin.x, tile.origin.y, groundZ)
end
function boss_rubick_origin_3.prototype.GetSinkHeight(self, ring)
	if ring == 0 then
		return RUBICK_ORIGIN_3_CENTER_SINK_HEIGHT
	end
	if ring == 1 then
		return RUBICK_ORIGIN_3_INNER_SINK_HEIGHT
	end
	return RUBICK_ORIGIN_3_OUTER_SINK_HEIGHT
end
function boss_rubick_origin_3.prototype.GetDamageRate(self, ring)
	if ring == 0 then
		return RUBICK_ORIGIN_3_CENTER_DAMAGE_RATE
	end
	if ring == 1 then
		return RUBICK_ORIGIN_3_INNER_DAMAGE_RATE
	end
	return RUBICK_ORIGIN_3_OUTER_DAMAGE_RATE
end
function boss_rubick_origin_3.prototype.GetFlatForward(self, unit)
	local forward = unit:GetForwardVector()
	local flat = Vector(forward.x, forward.y, 0)
	if flat:Length2D() > 0.001 then
		return flat:Normalized()
	end
	return Vector(1, 0, 0)
end
function boss_rubick_origin_3.prototype.GetMotionProgress(self, progress, motion)
	local safeProgress = math.max(0, math.min(1, progress))
	if motion == "linear" then
		return safeProgress
	end
	if motion == "easeIn" then
		return safeProgress * safeProgress * safeProgress
	end
	if motion == "easeOut" then
		local inverse = 1 - safeProgress
		return 1 - inverse * inverse * inverse
	end
	if motion == "spring" then
		local damping = 5.5
		return (1 - math.exp(-damping * safeProgress)) / (1 - math.exp(-damping))
	end
	return safeProgress * safeProgress * (3 - 2 * safeProgress)
end
function boss_rubick_origin_3.prototype.ClearWarnings(self)
	for ____, particle in ipairs(self.warningParticles) do
		ParticleManager:DestroyParticle(particle, false)
		ParticleManager:ReleaseParticleIndex(particle)
	end
	self.warningParticles = {}
end
function boss_rubick_origin_3.prototype.CanUseTile(self, tile)
	return tile.isAvailable and not tile.isDisabled and not tile.modelRemoved
end
boss_rubick_origin_3 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_rubick_origin_3)
____exports.boss_rubick_origin_3 = boss_rubick_origin_3
return ____exports