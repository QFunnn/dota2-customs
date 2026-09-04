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
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local SEARCH_RANGE = 2500
local CAST_POINT = 0.8
local TURN_SPEED = 12
local DASH_SPEED = 2000
local BACKSTEP_DISTANCE = 150
local BACKSTEP_DURATION = 0.18
local FIRST_DASH_DISTANCE = 600
local SECOND_DASH_DISTANCE = 500
local THIRD_DASH_DISTANCE = 500
local FIRST_DASH_DURATION = FIRST_DASH_DISTANCE / DASH_SPEED
local SECOND_DASH_DURATION = SECOND_DASH_DISTANCE / DASH_SPEED
local THIRD_DASH_DURATION = THIRD_DASH_DISTANCE / DASH_SPEED
local FIRST_STAB_RANGE = 750
local SECOND_STAB_RANGE = 800
local THIRD_DASH_STAB_RANGE = 800
local FIRST_STAB_WIDTH = 200
local SECOND_STAB_WIDTH = 200
local DASH_PATH_CHECK_STEP = 32
local BLINK_DISTANCE_FROM_ENEMY = 900
local BLINK_POINT_ATTEMPTS = 24
local STAB_DAMAGE_INTERVAL = 0.07
local STAB_DAMAGE_COUNT = 3
local DAMAGE_RATE = 8
local BLEED_DAMAGE_MULTIPLIER = 0.5
local PANGOLIER_STAB_PARTICLE = "particles/cc/spear_line_aoe_basec.vpcf"
local PANGOLIER_STAB_NARROW_PARTICLE = "particles/cc/boss_pangolier_3_spear_line_aoe_narrow.vpcf"
local BLINK_PARTICLE = "particles/units/heroes/hero_queenofpain/queen_blink_shard_start.vpcf"
local CAST_SOUND = "Hero_Pangolier.Swashbuckle.Cast"
local STAB_SOUND = "Hero_Pangolier.Swashbuckle.Layer"
local HIT_SOUND = "Hero_Pangolier.Swashbuckle.Damage"
--- 将坐标投影到地面高度
local function getGroundPosition(self, pos, context)
	return GetGroundPosition(pos, context)
end
--- 获取水平归一化朝向，避免 Z 轴或异常长度影响预警角度
local function getFlatDirection(self, direction)
	local flat = Vector(direction.x, direction.y, 0)
	local length = flat:Length2D()
	if length <= 0.001 then
		return Vector(1, 0, 0)
	end
	return flat:__mul(1 / length)
end
--- 沿 from 到 desired 分段检测地形，返回最后一个可达地面点
local function getReachableGroundPosition(self, from, desired, context)
	local start = getGroundPosition(nil, from, context)
	local ____end = getGroundPosition(nil, desired, context)
	local delta = ____end:__sub(start)
	local distance = delta:Length2D()
	if distance <= 1 then
		return start
	end
	local direction = delta:Normalized()
	local steps = math.max(1, math.ceil(distance / DASH_PATH_CHECK_STEP))
	local last = start
	do
		local i = 1
		while i <= steps do
			local stepDistance = math.min(distance, i * DASH_PATH_CHECK_STEP)
			local candidate = getGroundPosition(nil, start:__add(direction:__mul(stepDistance)), context)
			if
				not GridNav:IsTraversable(candidate)
				or GridNav:IsBlocked(candidate)
				or not GridNav:CanFindPath(last, candidate)
			then
				break
			end
			last = candidate
			i = i + 1
		end
	end
	return last
end
--- Boss 滚滚虚张声势：后撤蓄力后多段冲刺刺击，并在段间闪烁重定位
____exports.boss_pangolier_3 = __TS__Class()
local boss_pangolier_3 = ____exports.boss_pangolier_3
boss_pangolier_3.name = "boss_pangolier_3"
__TS__ClassExtends(boss_pangolier_3, MonsterAbility_CS)
function boss_pangolier_3.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.lockedDirection = Vector(1, 0, 0)
end
function boss_pangolier_3.prototype.Precache(self, context)
	PrecacheResource("particle", PANGOLIER_STAB_PARTICLE, context)
	PrecacheResource("particle", PANGOLIER_STAB_NARROW_PARTICLE, context)
	PrecacheResource("particle", BLINK_PARTICLE, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_pangolier.vsndevts", context)
end
function boss_pangolier_3.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 1000,
		castPoint = CAST_POINT,
		castDuration = 2.65,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		cooldown = 1,
		OnPhaseStart = function()
			return self:OnChargeStart()
		end,
		OnStart = function()
			return self:OnSwashbuckleStart()
		end,
		OnInterrupt = function()
			return nil
		end,
	}
end
function boss_pangolier_3.prototype.OnChargeStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = caster:GetMinDistanceUnit(SEARCH_RANGE)
	if IsValidAlive(nil, target) then
		self:BlinkNearEnemy(caster, target)
		caster:LockTargetForSpeed(target, CAST_POINT, TURN_SPEED)
	end
	local origin = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local chargeStartDirection = getFlatDirection(nil, caster:GetForwardVector())
	local backstepEnd =
		getReachableGroundPosition(nil, origin, origin:__sub(chargeStartDirection:__mul(BACKSTEP_DISTANCE)), caster)
	caster:Mover(backstepEnd, BACKSTEP_DURATION)
	self:Timer(BACKSTEP_DURATION, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		caster:SetAbsOrigin(backstepEnd)
		self:ShowDashWarning(
			caster,
			FIRST_DASH_DISTANCE,
			FIRST_STAB_RANGE,
			FIRST_STAB_WIDTH,
			CAST_POINT - BACKSTEP_DURATION
		)
	end)
end
function boss_pangolier_3.prototype.OnSwashbuckleStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOn(CAST_SOUND, caster)
	self:StartDashChain(caster, 0)
end
function boss_pangolier_3.prototype.StartDashChain(self, caster, dashIndex)
	if not IsValidAlive(nil, caster) then
		return
	end
	local config = self:GetDashConfig(dashIndex)
	if not config then
		return
	end
	self.lockedDirection = getFlatDirection(nil, caster:GetForwardVector())
	local start = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local target = caster:GetMinDistanceUnit(2000)
	if IsValidAlive(nil, target) then
		local distance = GetDistance(nil, caster:GetAbsOrigin(), target:GetAbsOrigin())
		config.distance = math.min(config.distance, distance)
	end
	local ____end =
		getReachableGroundPosition(nil, start, start:__add(self.lockedDirection:__mul(config.distance)), caster)
	caster:RemoveGesture(ACT_DOTA_CAST_ABILITY_1)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1_END, 1)
	caster:Mover(____end, config.duration)
	self:Timer(config.duration, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		self:PlayStabAndDamage(caster, caster:GetAbsOrigin(), config.stabRange, config.stabWidth, config.particle)
		self:Timer(0.15, function()
			self:ScheduleNextDash(caster, dashIndex + 1)
		end)
	end)
end
function boss_pangolier_3.prototype.ScheduleNextDash(self, caster, dashIndex)
	if not IsValidAlive(nil, caster) then
		return
	end
	local nextConfig = self:GetDashConfig(dashIndex)
	if not nextConfig then
		return
	end
	local reaimDelay = 0.8
	local target = self:FindRandomEnemy(caster, SEARCH_RANGE)
	if IsValidAlive(nil, target) then
		self:BlinkNearEnemy(caster, target)
		caster:LockTargetForSpeed(target, reaimDelay, TURN_SPEED)
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	self:ShowDashWarning(caster, nextConfig.distance, nextConfig.stabRange, nextConfig.stabWidth, reaimDelay)
	self:Timer(reaimDelay, function()
		return self:StartDashChain(caster, dashIndex)
	end)
end
function boss_pangolier_3.prototype.GetDashConfig(self, dashIndex)
	local dashConfigs = {
		{
			distance = FIRST_DASH_DISTANCE,
			duration = FIRST_DASH_DURATION,
			stabRange = FIRST_STAB_RANGE,
			stabWidth = FIRST_STAB_WIDTH,
			particle = PANGOLIER_STAB_NARROW_PARTICLE,
		},
		{
			distance = SECOND_DASH_DISTANCE,
			duration = SECOND_DASH_DURATION,
			stabRange = SECOND_STAB_RANGE,
			stabWidth = SECOND_STAB_WIDTH,
			particle = PANGOLIER_STAB_PARTICLE,
		},
		{
			distance = THIRD_DASH_DISTANCE,
			duration = THIRD_DASH_DURATION,
			stabRange = THIRD_DASH_STAB_RANGE,
			stabWidth = SECOND_STAB_WIDTH,
			particle = PANGOLIER_STAB_PARTICLE,
		},
	}
	return dashConfigs[dashIndex + 1]
end
function boss_pangolier_3.prototype.ShowDashWarning(self, caster, dashDistance, stabRange, stabWidth, duration)
	local start = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local direction = getFlatDirection(nil, caster:GetForwardVector())
	local dashEnd = getReachableGroundPosition(nil, start, start:__add(direction:__mul(dashDistance)), caster)
	self:WarningEffect(start, self:GetStabEnd(dashEnd, stabRange * 0.9, direction), duration, {
		startWidth = stabWidth,
		endWidth = stabWidth,
		getDirection = function()
			return getFlatDirection(nil, caster:GetForwardVector())
		end,
	})
end
function boss_pangolier_3.prototype.PlayStabAndDamage(self, caster, startPos, stabRange, stabWidth, particleName)
	local direction = self.lockedDirection
	local stabEnd = self:GetStabEnd(startPos, stabRange, direction)
	self:PlayStabEffect(caster, startPos, stabRange, stabWidth, particleName, direction)
	do
		local i = 0
		while i < STAB_DAMAGE_COUNT do
			local currentDelay = i * STAB_DAMAGE_INTERVAL
			self:Timer(currentDelay, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				EmitSoundOn(STAB_SOUND, caster)
				self:Timer(0.1, function()
					self:DamageStabLine(caster, startPos, stabEnd, stabWidth)
				end)
			end)
			i = i + 1
		end
	end
end
function boss_pangolier_3.prototype.FindRandomEnemy(self, caster, range)
	local enemies = __TS__ArrayFilter(
		FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, range, 2, 1 + 18, 0, 0, false),
		function(____, enemy)
			return IsValidAlive(nil, enemy)
		end
	)
	if #enemies == 0 then
		return nil
	end
	return enemies[RandomInt(0, #enemies - 1) + 1]
end
function boss_pangolier_3.prototype.BlinkNearEnemy(self, caster, enemy)
	local casterOrigin = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	if not IsValidAlive(nil, enemy) then
		return
	end
	local blinkPoint = self:FindBlinkPointNearEnemy(caster, casterOrigin, enemy)
	if not blinkPoint then
		return
	end
	self:PlayBlinkParticle(casterOrigin)
	ProjectileManager:ProjectileDodge(caster)
	FindClearSpaceForUnit(caster, blinkPoint, true)
	self:PlayBlinkParticle(blinkPoint)
	caster:SetForwardVector(getFlatDirection(nil, enemy:GetAbsOrigin():__sub(blinkPoint)))
end
function boss_pangolier_3.prototype.FindBlinkPointNearEnemy(self, caster, casterOrigin, enemy)
	if not IsValidAlive(nil, enemy) then
		return
	end
	local enemyOrigin = getGroundPosition(nil, enemy:GetAbsOrigin(), enemy)
	local baseDirection = getFlatDirection(nil, casterOrigin:__sub(enemyOrigin))
	do
		local i = 0
		while i < BLINK_POINT_ATTEMPTS do
			local direction = getFlatDirection(nil, RotateVector2D(nil, baseDirection, RandomFloat(-180, 180)))
			local candidate = enemyOrigin:__add(direction:__mul(BLINK_DISTANCE_FROM_ENEMY))
			local point = getGroundPosition(nil, candidate, caster)
			if self:IsValidBlinkPoint(casterOrigin, point) then
				return point
			end
			i = i + 1
		end
	end
	local fallback = getGroundPosition(nil, enemyOrigin:__add(baseDirection:__mul(BLINK_DISTANCE_FROM_ENEMY)), caster)
	local ____table_IsValidBlinkPoint_result_0
	if self:IsValidBlinkPoint(casterOrigin, fallback) then
		____table_IsValidBlinkPoint_result_0 = fallback
	else
		____table_IsValidBlinkPoint_result_0 = nil
	end
	return ____table_IsValidBlinkPoint_result_0
end
function boss_pangolier_3.prototype.IsValidBlinkPoint(self, origin, point)
	if not GridNav:IsTraversable(point) or GridNav:IsBlocked(point) then
		return false
	end
	if not GridNav:CanFindPath(origin, point) then
		return false
	end
	return GridNav:FindPathLength(origin, point) ~= -1
end
function boss_pangolier_3.prototype.PlayBlinkParticle(self, position)
	local pfx = ParticleManager:CreateParticle(BLINK_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, position)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function boss_pangolier_3.prototype.DamageStabLine(self, caster, startPos, endPos, stabWidth)
	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		startPos,
		endPos,
		nil,
		stabWidth,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue56
			end
			local ____opt_1 = enemy.GetUnitType
			local unitType = ____opt_1 and ____opt_1(enemy)
			if unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE then
				goto __continue56
			end
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = DAMAGE_RATE,
				ability = self,
				damage_type = 1,
				effectName = "particles/dd/effect_hit_blood.vpcf",
			})
			self:ApplyBleed(caster, enemy)
			EmitSoundOn(HIT_SOUND, enemy)
		end
		::__continue56::
	end
end
function boss_pangolier_3.prototype.ApplyBleed(self, caster, target)
	local bleedDamage =
		math.max(0, (MyGameAttribute:GetAttribute(caster, "total_attack_damage") or 0) * BLEED_DAMAGE_MULTIPLIER)
	AddDeBuffStatus(nil, target, caster, self, DebuffStatusType.BLEED, { source_final_damage = bleedDamage })
end
function boss_pangolier_3.prototype.GetStabEnd(self, startPos, stabRange, direction)
	return getGroundPosition(nil, startPos:__add(direction:__mul(stabRange)), self:GetCaster())
end
function boss_pangolier_3.prototype.PlayStabEffect(
	self,
	caster,
	startPos,
	stabRange,
	stabWidth,
	particleName,
	direction
)
	local segmentCount = math.max(1, math.ceil(stabRange / 200))
	local segmentLength = stabRange / segmentCount
	do
		local i = 0
		while i < segmentCount do
			local effectPos = startPos:__add(direction:__mul(60 + segmentLength * i))
			local origin = Vector(effectPos.x, effectPos.y, GetGroundHeight(effectPos, caster) + 85)
			local stabPfx = ParticleManager:CreateParticle(particleName, PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleControlTransformForward(stabPfx, 0, origin, direction)
			ParticleManager:SetParticleControlForward(stabPfx, 1, direction)
			ParticleManager:SetParticleControl(stabPfx, 2, Vector(segmentLength + 80, stabWidth, 0))
			ParticleManager:ReleaseParticleIndex(stabPfx)
			i = i + 1
		end
	end
end
boss_pangolier_3 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_pangolier_3)
____exports.boss_pangolier_3 = boss_pangolier_3
return ____exports