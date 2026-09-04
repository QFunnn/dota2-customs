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
local modifier_normal_034_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 900
local CAST_POINT = 0.6
local TOTAL_ACTION_DURATION = 3
local LAND_TIME = 1.25
local CAST_DURATION = TOTAL_ACTION_DURATION - CAST_POINT
local JUMP_DURATION = LAND_TIME - CAST_POINT
local JUMP_DISTANCE = 600
local JUMP_HEIGHT = 420
local JUMP_PATH_SAMPLE_DISTANCE = 32
local DAMAGE_RADIUS = 450
local DAMAGE_RATE = 25
local SLOW_DURATION = 3
local SLOW_MOVESPEED_PCT = 80
local SECOND_STUN_DURATION = 2
local MAX_HEALTH_DAMAGE_PCT = 80
local EARTHSHOCK_EFFECT = "particles/units/heroes/hero_ursa/ursa_earthshock.vpcf"
local JUMP_SOUND = "Ability.TossThrow"
local LAND_SOUND = "Hero_Centaur.HoofStomp"
local PARTICLE_POOL = "particles/queen_blink_shard_start.vpcf"
local function getGroundPosition(self, pos, context)
	return GetGroundPosition(pos, context)
end
--- 普通技能34 - 跃震：蓄力后跳向目标方向，落地时在脚下造成范围伤害
____exports.normal_034 = __TS__Class()
local normal_034 = ____exports.normal_034
normal_034.name = "normal_034"
__TS__ClassExtends(normal_034, MonsterAbility_CS)
function normal_034.prototype.Precache(self, context)
	PrecacheResource("particle", EARTHSHOCK_EFFECT, context)
end
function normal_034.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 1.35,
		cooldown = 8,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self.lockedTargetIndex = nil
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if IsValidAlive(nil, target) then
				self.lockedTargetIndex = target:entindex()
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local ____temp_0 = self:GetJumpData(caster, self:GetLockedTarget())
			local origin = ____temp_0.origin
			local landPos = ____temp_0.landPos
			local direction = ____temp_0.direction
			local safeLandPos = self:ResolveSafeJumpLanding(caster, origin, landPos) or origin
			local peak = origin:__add(Vector(0, 0, JUMP_HEIGHT))
			caster:SetForwardVector(direction)
			self:WarningRingEffect(safeLandPos, DAMAGE_RADIUS, JUMP_DURATION)
			EmitSoundOn(JUMP_SOUND, caster)
			caster:Bezier2Mover({ origin, peak, safeLandPos }, JUMP_DURATION, nil, true)
			self:Timer(JUMP_DURATION + 0.1, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				FindClearSpaceForUnit(caster, safeLandPos, false)
				ScreenShake(caster:GetAbsOrigin(), 10, 10, 0.3, 3000, 0, true)
				self:LandEarthshock(caster, safeLandPos)
			end)
			self:Timer(JUMP_DURATION + 0.8, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:stompArea(caster:GetAbsOrigin(), DAMAGE_RADIUS)
				ScreenShake(caster:GetAbsOrigin(), 20, 20, 0.3, 3000, 0, true)
			end)
			self:Timer(JUMP_DURATION + 1.5, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				local pfx_name = "particles/_2juggernaut_blade_fury_abyssal_start_p_2x.vpcf"
				ScreenShake(caster:GetAbsOrigin(), 10, 10, 0.3, 3000, 0, true)
				local pfx4 = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, caster)
				self:LandEarthshock2(caster, caster:GetAbsOrigin())
				caster:EmitSound("Hero_Broodmother.SilkenBola.Target")
				ParticleManager:SetParticleControl(pfx4, 0, caster:GetAbsOrigin())
				self:armParticleLifetime(pfx4, 0.28)
			end)
		end,
		OnFinish = function()
			self.lockedTargetIndex = nil
		end,
		OnInterrupt = function()
			self.lockedTargetIndex = nil
		end,
	}
end
function normal_034.prototype.stompArea(self, pos, radius)
	local caster = self:GetCaster()
	EmitSoundOnLocationWithCaster(pos, LAND_SOUND, caster)
	local pfx = ParticleManager:CreateParticle(PARTICLE_POOL, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(pfx, 0, pos)
	ParticleManager:SetParticleControl(pfx, 1, Vector(radius, radius, radius))
	ParticleManager:SetParticleControl(pfx, 2, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(pfx)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		radius * 0.9,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue19
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE * 0.7, ability = self })
			self:ClearTargetShield(enemy)
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = SECOND_STUN_DURATION })
		end
		::__continue19::
	end
end
function normal_034.prototype.armParticleLifetime(self, pid, lifeSec)
	if not IsServer() then
		return
	end
	local done = false
	Timers:CreateTimer(lifeSec, function()
		if done then
			return nil
		end
		done = true
		ParticleManager:DestroyParticle(pid, false)
		ParticleManager:ReleaseParticleIndex(pid)
		return nil
	end)
end
function normal_034.prototype.GetLockedTarget(self)
	if self.lockedTargetIndex == nil then
		return nil
	end
	local target = EntIndexToHScript(self.lockedTargetIndex)
	local ____IsValidAlive_result_1
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_1 = target
	else
		____IsValidAlive_result_1 = nil
	end
	return ____IsValidAlive_result_1
end
function normal_034.prototype.ResolveSafeJumpLanding(self, caster, origin, intendedLandPos)
	local startPoint = getGroundPosition(nil, origin, caster)
	local landPoint = getGroundPosition(nil, intendedLandPos, caster)
	if not IsGridNavDisplacementWalkable(nil, startPoint) or not IsGridNavDisplacementWalkable(nil, landPoint) then
		return nil
	end
	local horizontalOffset = Vector(landPoint.x - startPoint.x, landPoint.y - startPoint.y, 0)
	local sampleCount = math.max(1, math.ceil(horizontalOffset:Length2D() / JUMP_PATH_SAMPLE_DISTANCE))
	do
		local index = 1
		while index <= sampleCount do
			local samplePoint =
				getGroundPosition(nil, startPoint:__add(horizontalOffset:__mul(index / sampleCount)), caster)
			if not IsGridNavDisplacementWalkable(nil, samplePoint) then
				return nil
			end
			index = index + 1
		end
	end
	if not GridNav:CanFindPath(startPoint, landPoint) then
		return nil
	end
	local ____temp_2
	if GridNav:FindPathLength(startPoint, landPoint) ~= -1 then
		____temp_2 = landPoint
	else
		____temp_2 = nil
	end
	return ____temp_2
end
function normal_034.prototype.GetJumpData(self, caster, target)
	local origin = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local direction = caster:GetForwardVector()
	if IsValidAlive(nil, target) then
		local targetPos = getGroundPosition(nil, target:GetAbsOrigin(), target)
		local targetDirection = GetDirection(nil, targetPos, origin)
		if targetDirection:Length2D() > 0.01 then
			direction = targetDirection
		end
	end
	direction = Vector(direction.x, direction.y, 0):Normalized()
	local landPos = getGroundPosition(nil, origin:__add(direction:__mul(JUMP_DISTANCE)), caster)
	return { origin = origin, landPos = landPos, direction = direction }
end
function normal_034.prototype.LandEarthshock(self, caster, origin)
	EmitSoundOnLocationWithCaster(origin, LAND_SOUND, caster)
	local pfx = ParticleManager:CreateParticle(EARTHSHOCK_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, Vector(DAMAGE_RADIUS, DAMAGE_RADIUS / 2, DAMAGE_RADIUS / 4))
	ParticleManager:ReleaseParticleIndex(pfx)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		DAMAGE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue37
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE * 0.4, ability = self })
			modifier_normal_034_slow:applys(enemy, caster, self, { duration = SLOW_DURATION })
		end
		::__continue37::
	end
end
function normal_034.prototype.LandEarthshock2(self, caster, origin)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		DAMAGE_RADIUS * 1.1,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue41
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			self:ApplyMaxHealthDamage(caster, enemy)
		end
		::__continue41::
	end
end
function normal_034.prototype.ClearTargetShield(self, target)
	if not IsValidAlive(nil, target) then
		return
	end
	local ____this_4
	____this_4 = target
	local ____opt_3 = ____this_4.SetCurrentEnergyShield
	if ____opt_3 ~= nil then
		____opt_3(____this_4, 0)
	end
end
function normal_034.prototype.ApplyMaxHealthDamage(self, caster, target)
	if not IsValidAlive(nil, target) then
		return
	end
	local damage = math.floor(math.max(0, target:GetMaxHealth()) * MAX_HEALTH_DAMAGE_PCT / 100)
	if damage <= 0 then
		return
	end
	Damage:ApplyDamage({
		attacker = caster,
		victim = target,
		damage = damage,
		damage_type = 4,
		ability = self,
	})
end
normal_034 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_034)
____exports.normal_034 = normal_034
modifier_normal_034_slow = __TS__Class()
modifier_normal_034_slow.name = "modifier_normal_034_slow"
__TS__ClassExtends(modifier_normal_034_slow, MonsterModifier_CS)
function modifier_normal_034_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -SLOW_MOVESPEED_PCT }
end
function modifier_normal_034_slow.prototype.IsHidden(self)
	return false
end
function modifier_normal_034_slow.prototype.IsDebuff(self)
	return true
end
function modifier_normal_034_slow.prototype.IsPurgable(self)
	return true
end
function modifier_normal_034_slow.prototype.GetTexture(self)
	return "ursa_earthshock"
end
function modifier_normal_034_slow.GetLocalizationCN(self)
	return { name = "跃震迟缓", description = "移动速度降低80%。" }
end
modifier_normal_034_slow =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_034_slow") }, modifier_normal_034_slow)
return ____exports