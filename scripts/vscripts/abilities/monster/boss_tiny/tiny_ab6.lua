--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Number = ____lualib.__TS__Number
local __TS__NumberIsFinite = ____lualib.__TS__NumberIsFinite
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local warningEffectRing = ____monster_base.warningEffectRing
--- 预警时间（秒）
local TINY_AB6_WARNING_DURATION = 1
--- 单次循环总时长：1 秒抛物线 + 0.6 秒后摇
local CYCLE_DURATION = 1.8
--- 抛物线运动时间（跃起落下）
local PARABOLA_TIME = 1
--- 落地后静止后摇时间
local RECOVERY_TIME = 0.6
--- 默认循环次数（各阶段未配置时兜底）
local DEFAULT_CYCLE_COUNT = 5
--- 跃起抛物线高度（单位码）
local JUMP_HEIGHT = 900
--- 砸地伤害系数
local SLAM_DAMAGE_RATE = 25
--- 砸地落地特效：cp0 原点，cp2.x 范围
local SLAM_PARTICLE = "particles/cb/epic7_effect.vpcf"
--- 砸地大范围粒子保留时长（秒）
local SLAM_PFX_LIFETIME = 2.5
local TINY_TOSS_PARTICLE = "particles/cb/tiny_toss_sb2020_boulder.vpcf"
--- 后摇 TINY_TOSS：同时抛出的碎石数量
local TINY_AB6_TOSS_ROCK_COUNT = 3
--- 有目标时：落点在目标周围该半径（码）内随机
local TINY_AB6_TOSS_SCATTER_RADIUS = 320
--- 有目标时：多枚落点之间的最小间距（码）
local TINY_AB6_TOSS_SCATTER_MIN_DIST = 100
--- 无目标时：在 Boss 周围取落点的半径与间距
local TINY_AB6_TOSS_FALLBACK_RADIUS = 800
local TINY_AB6_TOSS_FALLBACK_MIN_DIST = 150
--- 随机落点：以初始位置为圆心、该值为半径的圆内取点（各阶段未配置时兜底）
local RANDOM_LAND_RADIUS = 1500
--- 随机落点之间最小距离（各阶段未配置时兜底）
local RANDOM_LAND_MIN_DIST = 520
--- 智能主落点：沿目标面朝方向，从目标脚下前移该距离（码）作为随机圆心
local TINY_AB6_SMART_LAND_FRONT_OFFSET = 500
--- 智能主落点：以上述圆心为中心、该半径（码）内随机取地面点（非小石子逻辑）
local TINY_AB6_SMART_LAND_RADIUS = 500
--- 按成长阶段（0~3）划分的技能 6 配置
local TINY_AB6_STAGE_CONFIG = {
	[0] = { jumpCount = 3, damageRadius = 400, smartLandChance = 0.6 },
	[1] = { jumpCount = 3, damageRadius = 400, smartLandChance = 0.6 },
	[2] = { jumpCount = 4, damageRadius = 500, smartLandChance = 0.9 },
	[3] = { jumpCount = 4, damageRadius = 500, smartLandChance = 0.9 },
}
--- 安全读取单位当前成长阶段（0~3）
local function getTinyGrowthStageSafe(self, caster)
	local modifier = caster and caster:HasModifier("modifier_tiny_ab1_buff")
	if modifier then
		return 2
	else
		return 1
	end
end
--- 根据单位当前血量阶段取技能6配置，无阶段或非法时用阶段 0
local function getTinyAb6Config(self, caster)
	local stage = getTinyGrowthStageSafe(nil, caster)
	local ____temp_2
	if __TS__NumberIsFinite(__TS__Number(stage)) and stage >= 0 and stage <= 3 then
		____temp_2 = stage
	else
		____temp_2 = 0
	end
	local key = ____temp_2
	return TINY_AB6_STAGE_CONFIG[key] or TINY_AB6_STAGE_CONFIG[0]
end
--- 小小 Boss 技能6 - 预警 3 秒后给自己添加「滚动砸地」modifier，重复 N 次：每次 1 秒抛物线落地造成范围伤害 + 0.6 秒后摇
____exports.tiny_ab6 = __TS__Class()
local tiny_ab6 = ____exports.tiny_ab6
tiny_ab6.name = "tiny_ab6"
__TS__ClassExtends(tiny_ab6, MonsterAbility_CS)
function tiny_ab6.prototype.Precache(self, context)
	PrecacheResource("particle", SLAM_PARTICLE, context)
end
function tiny_ab6.prototype.GetCooldown(self, level)
	return 5
end
function tiny_ab6.prototype.GetMosnterAbilityConfig(self)
	local caster = self:GetCaster()
	local cfg = getTinyAb6Config(nil, caster)
	local totalDuration = cfg.jumpCount * CYCLE_DURATION
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = TINY_AB6_WARNING_DURATION,
		castDuration = totalDuration - 0.5,
		castAnimation = ACT_DOTA_GENERIC_CHANNEL_1,
		animationPlaybackRate = 1,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:AddActivityModifier("taunt_ti9")
			caster:AddActivityModifier("taunt")
			Timers:CreateTimer(TINY_AB6_WARNING_DURATION - 0.5, function()
				if not IsValidAlive(nil, caster) then
					return nil
				end
				caster:RemoveGesture(ACT_DOTA_GENERIC_CHANNEL_1)
				return nil
			end)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local stageCfg = getTinyAb6Config(nil, caster)
			local duration = stageCfg.jumpCount * CYCLE_DURATION
			caster:AddNewModifier(
				caster,
				self,
				"modifier_tiny_ab6_roll_slam",
				{
					duration = duration,
					jump_count = stageCfg.jumpCount,
					damage_radius = stageCfg.damageRadius,
					smart_chance = stageCfg.smartLandChance,
				}
			)
		end,
	}
end
tiny_ab6 = __TS__DecorateLegacy({ registerAbility(nil) }, tiny_ab6)
____exports.tiny_ab6 = tiny_ab6
--- 滚动砸地 modifier：每 1.6 秒用 StartGestureWithPlaybackRate 播放一次 DOTA_TAUNT（非循环），同轮内 1 秒抛物线落地 + 伤害/特效，0.6 秒后摇，共 5 轮
____exports.modifier_tiny_ab6_roll_slam = __TS__Class()
local modifier_tiny_ab6_roll_slam = ____exports.modifier_tiny_ab6_roll_slam
modifier_tiny_ab6_roll_slam.name = "modifier_tiny_ab6_roll_slam"
__TS__ClassExtends(modifier_tiny_ab6_roll_slam, MonsterModifier_CS)
function modifier_tiny_ab6_roll_slam.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.cycleIndex = 0
	self.landPositions = {}
	self.totalCycles = DEFAULT_CYCLE_COUNT
	self.damageRadius = 340
	self.smartLandChance = 0.5
end
function modifier_tiny_ab6_roll_slam.prototype.IsHidden(self)
	return false
end
function modifier_tiny_ab6_roll_slam.prototype.IsPurgable(self)
	return false
end
function modifier_tiny_ab6_roll_slam.prototype.IsDebuff(self)
	return false
end
function modifier_tiny_ab6_roll_slam.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local center = parent:GetAbsOrigin()
	local ____temp_3
	if params.jump_count and params.jump_count > 0 then
		____temp_3 = params.jump_count
	else
		____temp_3 = DEFAULT_CYCLE_COUNT
	end
	self.totalCycles = ____temp_3
	local r = tonumber(params.damage_radius or self.damageRadius) or self.damageRadius
	self.damageRadius = r
	local smart = tonumber(params.smart_chance or self.smartLandChance)
	local ____temp_4
	if smart >= 0 and smart <= 1 then
		____temp_4 = smart
	else
		____temp_4 = self.smartLandChance
	end
	self.smartLandChance = ____temp_4
	local points = GetRandomPointsInCircle(nil, center, RANDOM_LAND_RADIUS, self.totalCycles, RANDOM_LAND_MIN_DIST)
	self.landPositions = __TS__ArrayMap(points, function(____, p)
		local z = GetGroundHeight(p, parent)
		local ____p_x_6 = p.x
		local ____p_y_7 = p.y
		local ____temp_5
		if z ~= nil then
			____temp_5 = z
		else
			____temp_5 = p.z
		end
		return Vector(____p_x_6, ____p_y_7, ____temp_5)
	end)
	self:StartNextCycle()
end
function modifier_tiny_ab6_roll_slam.prototype.IsValidLandingPoint(self, origin, point)
	if not GridNav:IsTraversable(point) or GridNav:IsBlocked(point) then
		return false
	end
	if not GridNav:CanFindPath(origin, point) then
		return false
	end
	if GridNav:FindPathLength(origin, point) == -1 then
		return false
	end
	return true
end
function modifier_tiny_ab6_roll_slam.prototype.StartNextCycle(self)
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or ability:IsNull() then
		return
	end
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		return
	end
	if self:IsNull() or self.cycleIndex >= self.totalCycles then
		return
	end
	local stack = getTinyGrowthStageSafe(nil, parent)
	parent:SetAnimation(("tiny_0" .. tostring(stack + 1)) .. "_taunt")
	parent:EmitSound("Hero_Tiny.Toss.Target")
	local origin = parent:GetAbsOrigin()
	local landPos = self.landPositions[self.cycleIndex + 1] or origin
	if not self:IsValidLandingPoint(origin, landPos) then
		landPos = origin
	end
	local candidates = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		2000,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	local target = candidates[1]
	if target and IsValidAlive(nil, target) then
		local face = target:GetForwardVector()
		local flen = math.sqrt(face.x * face.x + face.y * face.y) or 1
		local fwd = Vector(face.x / flen, face.y / flen, 0)
		local base = target:GetAbsOrigin()
		local circleCenter = base:__add(fwd:__mul(TINY_AB6_SMART_LAND_FRONT_OFFSET * math.random(0.8, 1.1)))
		local raw = GetRandomPointsInCircle(nil, circleCenter, TINY_AB6_SMART_LAND_RADIUS, 1, 0)[1] or circleCenter
		local z = GetGroundHeight(raw, target)
		local ____raw_x_9 = raw.x
		local ____raw_y_10 = raw.y
		local ____temp_8
		if z ~= nil then
			____temp_8 = z
		else
			____temp_8 = raw.z
		end
		local smartPos = Vector(____raw_x_9, ____raw_y_10, ____temp_8)
		if self:IsValidLandingPoint(origin, smartPos) then
			landPos = smartPos
		end
	end
	if not self:IsValidLandingPoint(origin, landPos) then
		landPos = origin
	end
	local peak = origin:__add(Vector(0, 0, JUMP_HEIGHT))
	parent:SetForwardVector(GetDirection(nil, landPos, origin))
	parent:Bezier2Mover({ origin, peak, landPos }, PARABOLA_TIME, nil, true, true)
	warningEffectRing(nil, caster, landPos, self.damageRadius, PARABOLA_TIME)
	Timers:CreateTimer(PARABOLA_TIME, function()
		if self:IsNull() then
			return nil
		end
		local abilityNow = self:GetAbility()
		if not abilityNow or not IsValid(nil, abilityNow) or abilityNow:IsNull() then
			return nil
		end
		if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
			return nil
		end
		parent:EmitSound("Hero_EarthShaker.Gravelmaw")
		self:ApplySlamDamage()
		self.cycleIndex = self.cycleIndex + 1
		if self.cycleIndex < self.totalCycles then
			Timers:CreateTimer(0.1, function()
				if self:IsNull() then
					return nil
				end
				local ab = self:GetAbility()
				if not ab or not IsValid(nil, ab) or ab:IsNull() then
					return nil
				end
				if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
					return nil
				end
				parent:StartGestureWithPlaybackRate(ACT_TINY_TOSS, 1)
				local target = self:GetMinDistanceUnit(2000, parent:GetAbsOrigin())
				local ____temp_11
				if target and IsValidAlive(nil, target) then
					____temp_11 = target:GetAbsOrigin()
				else
					____temp_11 = parent:GetAbsOrigin()
				end
				local center = ____temp_11
				local radius = target and IsValidAlive(nil, target) and TINY_AB6_TOSS_SCATTER_RADIUS
					or TINY_AB6_TOSS_FALLBACK_RADIUS
				local minDist = target and IsValidAlive(nil, target) and TINY_AB6_TOSS_SCATTER_MIN_DIST
					or TINY_AB6_TOSS_FALLBACK_MIN_DIST
				local rawPoints = GetRandomPointsInCircle(nil, center, radius, TINY_AB6_TOSS_ROCK_COUNT, minDist)
				for ____, p in ipairs(rawPoints) do
					local gz = GetGroundHeight(p, parent)
					local ____p_x_13 = p.x
					local ____p_y_14 = p.y
					local ____temp_12
					if gz ~= nil then
						____temp_12 = gz
					else
						____temp_12 = p.z
					end
					local pos = Vector(____p_x_13, ____p_y_14, ____temp_12)
					self:PlayEffect(pos)
				end
				return nil
			end)
			Timers:CreateTimer(RECOVERY_TIME, function()
				if self:IsNull() then
					return nil
				end
				local ab = self:GetAbility()
				if not ab or not IsValid(nil, ab) or ab:IsNull() then
					return nil
				end
				if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
					return nil
				end
				self:StartNextCycle()
				return nil
			end)
		end
		return nil
	end)
end
function modifier_tiny_ab6_roll_slam.prototype.ApplySlamDamage(self)
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		return
	end
	local pos = parent:GetAbsOrigin()
	local pfx = ParticleManager:CreateParticle(SLAM_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, pos)
	local radius = self.damageRadius
	ParticleManager:SetParticleControl(pfx, 1, Vector(radius, 0, 0))
	Timers:CreateTimer(SLAM_PFX_LIFETIME, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		return nil
	end)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		if IsValidAlive(nil, enemy) then
			caster:MonsterDamage({ victim = enemy, damage_rate = SLAM_DAMAGE_RATE, ability = ability })
			AddDeBuffStatus(nil, enemy, self:GetCaster(), self:GetAbility(), DebuffStatusType.STUN, { duration = 0.1 })
		end
	end
end
function modifier_tiny_ab6_roll_slam.prototype.PlayEffect(self, pos)
	if not IsValidAlive(nil, self._parent) then
		return
	end
	local pfx = ParticleManager:CreateParticle(TINY_TOSS_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, self._parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 1, pos)
	warningEffectRing(nil, self._parent, pos, 200, 1)
	Timers:CreateTimer(1, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		if not IsValidAlive(nil, self._parent) or not IsValidAlive(nil, self._caster) then
			return nil
		end
		local ability = self:GetAbility()
		if not ability or not IsValid(nil, ability) or ability:IsNull() then
			return nil
		end
		self._parent:EmitSound("Hero_EarthShaker.Totem")
		local blurPfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_tiny/tiny_toss_blur.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(blurPfx, 0, pos)
		ParticleManager:SetParticleControl(blurPfx, 1, Vector(200, 0, 0))
		ParticleManager:DestroyParticle(blurPfx, false)
		ParticleManager:ReleaseParticleIndex(blurPfx)
		local enemies = self:FindHeroesInRadius(200, pos)
		__TS__ArrayForEach(enemies, function(____, enemy)
			self._caster:MonsterDamage({ victim = enemy, damage_rate = SLAM_DAMAGE_RATE / 3, ability = ability })
			AddDeBuffStatus(nil, enemy, self:GetCaster(), ability, DebuffStatusType.STUN, { duration = 0.1 })
		end)
		return nil
	end)
end
modifier_tiny_ab6_roll_slam =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_tiny_ab6_roll_slam") }, modifier_tiny_ab6_roll_slam)
____exports.modifier_tiny_ab6_roll_slam = modifier_tiny_ab6_roll_slam
return ____exports