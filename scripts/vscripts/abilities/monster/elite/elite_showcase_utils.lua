--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
function ____exports.EliteFindTarget(self, caster, range)
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(range)
end
function ____exports.EliteDirectionToTarget(self, caster, range)
	local target = ____exports.EliteFindTarget(nil, caster, range)
	if IsValidAlive(nil, target) then
		local direction = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
		if direction:Length2D() > 0.01 then
			return direction
		end
	end
	local forward = caster:GetForwardVector()
	local ____temp_0
	if forward:Length2D() > 0.01 then
		____temp_0 = forward:Normalized()
	else
		____temp_0 = Vector(1, 0, 0)
	end
	return ____temp_0
end
function ____exports.EliteRotateDirection(self, direction, angleDegrees)
	local radians = angleDegrees * math.pi / 180
	local cos = math.cos(radians)
	local sin = math.sin(radians)
	return Vector(direction.x * cos - direction.y * sin, direction.x * sin + direction.y * cos, 0):Normalized()
end
function ____exports.EliteGroundLineEnd(self, start, direction, distance, caster)
	return GetGroundPosition(start:__add(direction:__mul(distance)), caster)
end
function ____exports.ElitePlayWorldParticle(self, particleName, origin, caster, cp1, cp2)
	local particle = ParticleManager:CreateParticle(particleName, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, origin)
	if cp1 then
		ParticleManager:SetParticleControl(particle, 1, cp1)
	end
	if cp2 then
		ParticleManager:SetParticleControl(particle, 2, cp2)
	end
	ParticleManager:ReleaseParticleIndex(particle)
end
function ____exports.EliteCreateLimitedWarningTargetTracker(self, params)
	local caster = params.caster
	local startTime = GameRules:GetGameTime()
	local lastUpdateTime = startTime
	local ____IsValidAlive_result_3
	if IsValidAlive(nil, params.initialTarget) then
		____IsValidAlive_result_3 = params.initialTarget
	else
		local ____this_2
		____this_2 = params
		local ____opt_1 = ____this_2.resolveTarget
		____IsValidAlive_result_3 = ____opt_1 and ____opt_1(____this_2)
	end
	local lockedTarget = ____IsValidAlive_result_3
	local function resolveTarget()
		if not IsValidAlive(nil, lockedTarget) then
			local ____this_5
			____this_5 = params
			local ____opt_4 = ____this_5.resolveTarget
			lockedTarget = ____opt_4 and ____opt_4(____this_5)
		end
		return lockedTarget
	end
	local function resolveTargetPoint()
		local target = resolveTarget(nil)
		if IsValidAlive(nil, target) then
			local ____params_resolveTargetPoint_6
			if params.resolveTargetPoint then
				____params_resolveTargetPoint_6 = params:resolveTargetPoint(target)
			else
				____params_resolveTargetPoint_6 = target:GetAbsOrigin()
			end
			local targetPoint = ____params_resolveTargetPoint_6
			return GetGroundPosition(targetPoint, caster)
		end
		return GetGroundPosition(params:resolveFallbackPoint(), caster)
	end
	local currentCenter = GetGroundPosition(params.initialCenter or resolveTargetPoint(nil), caster)
	local function updateBySpeedLimit(____, desiredCenter, deltaTime)
		local delta = desiredCenter:__sub(currentCenter)
		local distance = delta:Length2D()
		if distance <= 0.01 then
			return GetGroundPosition(desiredCenter, caster)
		end
		local moveDistance = math.min(math.max(params.followSpeed, 0) * deltaTime, distance)
		if moveDistance >= distance then
			return GetGroundPosition(desiredCenter, caster)
		end
		local direction = Vector(delta.x / distance, delta.y / distance, 0)
		return GetGroundPosition(currentCenter:__add(direction:__mul(moveDistance)), caster)
	end
	return {
		getCenter = function()
			return currentCenter
		end,
		update = function()
			if not IsValidAlive(nil, caster) then
				return currentCenter
			end
			local now = GameRules:GetGameTime()
			local deltaTime = math.max(now - lastUpdateTime, 0)
			lastUpdateTime = now
			if now - startTime >= params.followDuration then
				return currentCenter
			end
			currentCenter = updateBySpeedLimit(nil, resolveTargetPoint(nil), deltaTime)
			return currentCenter
		end,
		lock = function()
			return currentCenter
		end,
	}
end
function ____exports.EliteDamageEnemiesInRadius(
	self,
	ability,
	caster,
	origin,
	radius,
	damageRate,
	stunDuration,
	effectName
)
	if stunDuration == nil then
		stunDuration = 0
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue26
			end
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = damageRate,
				ability = ability,
				effectName = effectName,
			})
			if stunDuration > 0 then
				AddDeBuffStatus(nil, enemy, caster, ability, DebuffStatusType.STUN, { duration = stunDuration })
			end
		end
		::__continue26::
	end
end
function ____exports.EliteFirePiercingLine(self, params)
	local ____end = ____exports.EliteGroundLineEnd(nil, params.start, params.direction, params.distance, params.caster)
	CreateProjectile(nil, {
		ability = params.ability,
		caster = params.caster,
		effect_name = params.particle,
		projectile_type = "linear",
		start_point = params.start,
		target = ____end,
		projectile_speed = params.speed,
		projectile_distance = params.distance,
		projectile_range = params.width,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			if not IsValidAlive(nil, params.caster) then
				return
			end
			params.caster:MonsterDamage({
				victim = hitTarget,
				damage_rate = params.damageRate,
				ability = params.ability,
				effectName = params.hitParticle,
			})
			if params.stunDuration and params.stunDuration > 0 then
				AddDeBuffStatus(
					nil,
					hitTarget,
					params.caster,
					params.ability,
					DebuffStatusType.STUN,
					{ duration = params.stunDuration }
				)
			end
			if params.slowDuration and params.slowDuration > 0 then
				AddDeBuffStatus(
					nil,
					hitTarget,
					params.caster,
					params.ability,
					DebuffStatusType.ICE_SLOW,
					{ stack = 4, duration = params.slowDuration }
				)
			end
			if params.hitSound then
				EmitSoundOn(params.hitSound, hitTarget)
			end
			return false
		end,
	})
end
return ____exports