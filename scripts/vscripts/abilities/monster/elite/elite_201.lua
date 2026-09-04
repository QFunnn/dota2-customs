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
local modifier_elite_201_z_dash
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
--- 前摇锁敌搜索范围
local SEARCH_RANGE = 1400
--- 随机位移最少次数
local MIN_DASH_COUNT = 1
--- 随机位移最多次数
local MAX_DASH_COUNT = 2
--- 单段位移距离
local DASH_DISTANCE = 420
--- 单段横向偏移，形成 Z 字折线
local DASH_SIDE_OFFSET = 320
--- 单段位移耗时
local DASH_DURATION = 0.18
--- 位移段之间的停顿
local DASH_GAP = 0.08
--- 最终斩击前的短暂预警
local SLASH_WARNING_DURATION = 0.16
--- 斩击生效延迟
local SLASH_DAMAGE_DELAY = 0.08
--- 斩击长度
local SLASH_RANGE = 700
--- 斩击宽度
local SLASH_WIDTH = 220
--- 斩击伤害倍率
local SLASH_DAMAGE_RATE = 22
--- 命中眩晕时间
local SLASH_STUN_DURATION = 0.35
--- 技能持续阶段，覆盖最多两段位移和最终斩击
local CAST_DURATION = MAX_DASH_COUNT * (DASH_DURATION + DASH_GAP) + SLASH_WARNING_DURATION + SLASH_DAMAGE_DELAY + 0.35
local DASH_START_EFFECT = "particles/units/heroes/hero_queenofpain/queen_blink_start.vpcf"
local DASH_END_EFFECT = "particles/units/heroes/hero_queenofpain/queen_blink_end.vpcf"
local SLASH_EFFECT = "particles/dd/attack_03.vpcf"
local HIT_EFFECT = "particles/void_spirit_astral_step_impact_red.vpcf"
--- 精英技能201 - Z字斩击：随机进行 1-2 次折线位移后，向目标方向发动斩击。
____exports.elite_201 = __TS__Class()
local elite_201 = ____exports.elite_201
elite_201.name = "elite_201"
__TS__ClassExtends(elite_201, MonsterAbility_CS)
function elite_201.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.castToken = 0
end
function elite_201.prototype.Precache(self, context)
	PrecacheResource("particle", DASH_START_EFFECT, context)
	PrecacheResource("particle", DASH_END_EFFECT, context)
	PrecacheResource("particle", SLASH_EFFECT, context)
	PrecacheResource("particle", HIT_EFFECT, context)
end
function elite_201.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.35,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 1.2,
		castRange = SEARCH_RANGE,
		isNotMove = true,
		castColor = Vector(180, 40, 40),
		OnPhaseStart = function()
			return self:PrepareCast()
		end,
		OnStart = function()
			return self:StartZSlash()
		end,
		OnFinish = function()
			return self:CleanupCast()
		end,
		OnInterrupt = function()
			return self:CleanupCast()
		end,
	}
end
function elite_201.prototype.PrepareCast(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = caster:GetMinDistanceUnit(SEARCH_RANGE)
	local ____IsValidAlive_result_0
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_0 = target
	else
		____IsValidAlive_result_0 = nil
	end
	self.lockedTarget = ____IsValidAlive_result_0
	if self.lockedTarget then
		caster:LockTargetForSpeed(self.lockedTarget, 0.35, 8)
	end
	caster:SetAnimation("golem_attack2")
	caster:EmitSound("Hero_PhantomAssassin.Strike.Start")
end
function elite_201.prototype.StartZSlash(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self.castToken = self.castToken + 1
	local token = self.castToken
	local dashCount = RandomInt(MIN_DASH_COUNT, MAX_DASH_COUNT)
	local sideSign = RandomInt(0, 1) == 0 and -1 or 1
	local baseDirection = self:ResolveDirectionToTarget(caster)
	modifier_elite_201_z_dash:applys(
		caster,
		caster,
		self,
		{ duration = dashCount * (DASH_DURATION + DASH_GAP) + SLASH_WARNING_DURATION + SLASH_DAMAGE_DELAY + 0.2 }
	)
	self:StartDashStep(caster, token, 1, dashCount, baseDirection, sideSign)
end
function elite_201.prototype.StartDashStep(self, caster, token, step, dashCount, baseDirection, sideSign)
	if token ~= self.castToken or not IsValidAlive(nil, caster) then
		return
	end
	if step > dashCount then
		self:ScheduleFinalSlash(caster, token)
		return
	end
	local dashTarget = self:ResolveDashPosition(caster, step, baseDirection, sideSign)
	local dashDirection = GetDirection(nil, dashTarget, caster:GetAbsOrigin())
	if dashDirection:Length2D() > 0.01 then
		caster:SetForwardVector(dashDirection)
	end
	self:PlayPointEffect(DASH_START_EFFECT, caster:GetAbsOrigin())
	caster:EmitSound("Hero_PhantomAssassin.Blur")
	caster:Mover(dashTarget, DASH_DURATION, nil, true, true)
	self:Timer(DASH_DURATION, function()
		if token ~= self.castToken or not IsValidAlive(nil, caster) then
			return
		end
		self:PlayPointEffect(DASH_END_EFFECT, caster:GetAbsOrigin())
	end)
	self:Timer(DASH_DURATION + DASH_GAP, function()
		if token ~= self.castToken or not IsValidAlive(nil, caster) then
			return
		end
		local nextStep = step + 1
		self:StartDashStep(caster, token, nextStep, dashCount, baseDirection, sideSign)
	end)
end
function elite_201.prototype.ScheduleFinalSlash(self, caster, token)
	if token ~= self.castToken or not IsValidAlive(nil, caster) then
		return
	end
	local slashDirection = self:ResolveDirectionToTarget(caster)
	caster:SetForwardVector(slashDirection)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.4)
	self:WarningEffect(
		caster:GetAbsOrigin(),
		caster:GetAbsOrigin():__add(slashDirection:__mul(SLASH_RANGE)),
		SLASH_WARNING_DURATION,
		{ startWidth = SLASH_WIDTH, endWidth = SLASH_WIDTH, follow = true }
	)
	self:Timer(SLASH_WARNING_DURATION, function()
		if token ~= self.castToken or not IsValidAlive(nil, caster) then
			return
		end
		caster:EmitSound("Hero_PhantomAssassin.CoupDeGrace")
		self:PlaySlashEffect(caster)
	end)
	self:Timer(SLASH_WARNING_DURATION + SLASH_DAMAGE_DELAY, function()
		if token ~= self.castToken or not IsValidAlive(nil, caster) then
			return
		end
		self:DamageSlashLine(caster, slashDirection)
	end)
end
function elite_201.prototype.ResolveDashPosition(self, caster, step, baseDirection, sideSign)
	local currentOrigin = caster:GetAbsOrigin()
	local ____temp_1
	if step % 2 == 1 then
		____temp_1 = sideSign
	else
		____temp_1 = -sideSign
	end
	local currentSideSign = ____temp_1
	local sideDirection = RotateVector2D(nil, baseDirection, currentSideSign > 0 and 90 or -90):Normalized()
	local preferred = GetGroundPosition(
		currentOrigin:__add(baseDirection:__mul(DASH_DISTANCE)):__add(sideDirection:__mul(DASH_SIDE_OFFSET)),
		caster
	)
	if IsGridNavDisplacementWalkable(nil, preferred) then
		return preferred
	end
	local fallbackAngles = {
		0,
		45,
		-45,
		90,
		-90,
		135,
		-135,
		180,
	}
	for ____, angle in ipairs(fallbackAngles) do
		local currentDirection = RotateVector2D(nil, baseDirection, angle):Normalized()
		local currentPoint = GetGroundPosition(currentOrigin:__add(currentDirection:__mul(DASH_DISTANCE)), caster)
		if IsGridNavDisplacementWalkable(nil, currentPoint) then
			return currentPoint
		end
	end
	return GetGroundPosition(currentOrigin, caster)
end
function elite_201.prototype.ResolveDirectionToTarget(self, caster)
	local ____IsValidAlive_result_2
	if IsValidAlive(nil, self.lockedTarget) then
		____IsValidAlive_result_2 = self.lockedTarget
	else
		____IsValidAlive_result_2 = caster:GetMinDistanceUnit(SEARCH_RANGE)
	end
	local target = ____IsValidAlive_result_2
	if IsValidAlive(nil, target) then
		self.lockedTarget = target
		local direction = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
		if direction:Length2D() > 0.01 then
			return Vector(direction.x, direction.y, 0):Normalized()
		end
	end
	local forward = caster:GetForwardVector()
	local flatForward = Vector(forward.x, forward.y, 0)
	if flatForward:Length2D() <= 0.01 then
		return Vector(1, 0, 0)
	end
	return flatForward:Normalized()
end
function elite_201.prototype.DamageSlashLine(self, caster, slashDirection)
	local origin = caster:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		SLASH_RANGE + SLASH_WIDTH,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue37
			end
			if not self:IsInSlashLine(origin, slashDirection, enemy:GetAbsOrigin()) then
				goto __continue37
			end
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = SLASH_DAMAGE_RATE,
				ability = self,
				effectName = HIT_EFFECT,
			})
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = SLASH_STUN_DURATION })
		end
		::__continue37::
	end
end
function elite_201.prototype.IsInSlashLine(self, origin, direction, point)
	local delta = point:__sub(origin)
	local forwardDistance = delta.x * direction.x + delta.y * direction.y
	if forwardDistance < 0 or forwardDistance > SLASH_RANGE then
		return false
	end
	local sideX = delta.x - direction.x * forwardDistance
	local sideY = delta.y - direction.y * forwardDistance
	return math.sqrt(sideX * sideX + sideY * sideY) <= SLASH_WIDTH * 0.5
end
function elite_201.prototype.PlaySlashEffect(self, caster)
	local pfx = ParticleManager:CreateParticle(SLASH_EFFECT, PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 4, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(pfx)
end
function elite_201.prototype.PlayPointEffect(self, effectName, point)
	local pfx = ParticleManager:CreateParticle(effectName, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, point)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function elite_201.prototype.CleanupCast(self)
	self.castToken = self.castToken + 1
	self.lockedTarget = nil
	local caster = self:GetCaster()
	if not IsValid(nil, caster) or caster:IsNull() then
		return
	end
	caster:RemoveModifierByName("modifier_elite_201_z_dash")
end
elite_201 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_201)
____exports.elite_201 = elite_201
modifier_elite_201_z_dash = __TS__Class()
modifier_elite_201_z_dash.name = "modifier_elite_201_z_dash"
__TS__ClassExtends(modifier_elite_201_z_dash, MonsterModifier_CS)
function modifier_elite_201_z_dash.prototype.IsHidden(self)
	return true
end
function modifier_elite_201_z_dash.prototype.IsPurgable(self)
	return false
end
function modifier_elite_201_z_dash.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true, [MODIFIER_STATE_DISARMED] = true }
end
function modifier_elite_201_z_dash.prototype.GetEffectName(self)
	return "particles/void_spirit_astral_step_debuff_ember_blue.vpcf"
end
modifier_elite_201_z_dash =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_201_z_dash") }, modifier_elite_201_z_dash)
return ____exports