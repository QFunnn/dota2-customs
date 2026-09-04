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
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____elite_302 = require("abilities.monster.elite.elite_302")
local modifier_elite_302_mound = ____elite_302.modifier_elite_302_mound
local CAST_RANGE = 900
local UNDERGROUND_CAST_RANGE = 1500
local CAST_POINT = 0.45
local DASH_SIDE_STEP = 260
local DASH_SEGMENT_DURATION = 0.08
local DASH_SEGMENT_INTERVAL = 0.09333333333333334
local DASH_ATTACK_DURATION = 0.9
local DASH_ATTACK_HIT_DELAY = 0.3
local DASH_HIT_RADIUS = 220
local DASH_DAMAGE_RATE = 10
local DASH_STUN_DURATION = 0.18
local DASH_SIDE_SIGNS = { 1, -1 }
local UNDERGROUND_SIDE_SIGNS = { 1, -1, 1 }
local DASH_SEGMENT_COUNT = #DASH_SIDE_SIGNS + 1
local DASH_TOTAL_DURATION = DASH_SEGMENT_INTERVAL * DASH_SEGMENT_COUNT
local CAST_DURATION = DASH_TOTAL_DURATION + DASH_ATTACK_DURATION
local DASH_WARNING_DURATION = CAST_POINT + DASH_TOTAL_DURATION + DASH_ATTACK_HIT_DELAY
local SMOKE_PARTICLE = "particles/units/heroes/hero_bounty_hunter/bounty_hunter_windwalk.vpcf"
local VENDETTA_PARTICLE = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta.vpcf"
local UNDERGROUND_PROJECTILE = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale.vpcf"
local UNDERGROUND_HIT_PARTICLE = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale_hit.vpcf"
local UNDERGROUND_SEGMENT_FORWARD_STEP = 430
local UNDERGROUND_SEGMENT_SIDE_STEP = 260
local UNDERGROUND_PROJECTILE_WIDTH = 140
local UNDERGROUND_PROJECTILE_SPEED = 1700
local UNDERGROUND_DAMAGE_RATE = 11
local UNDERGROUND_STUN_DURATION = 0.25
local SCREEN_SHAKE_AMPLITUDE = 12
local SCREEN_SHAKE_FREQUENCY = 12
local SCREEN_SHAKE_DURATION = 0.2
local SCREEN_SHAKE_RADIUS = 1800
____exports.elite_318 = __TS__Class()
local elite_318 = ____exports.elite_318
elite_318.name = "elite_318"
__TS__ClassExtends(elite_318, MonsterAbility_CS)
function elite_318.prototype.Precache(self, context)
	PrecacheResource("particle", SMOKE_PARTICLE, context)
	PrecacheResource("particle", VENDETTA_PARTICLE, context)
	PrecacheResource("particle", UNDERGROUND_PROJECTILE, context)
	PrecacheResource("particle", UNDERGROUND_HIT_PARTICLE, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_nyx_assassin.vsndevts", context)
end
function elite_318.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = function()
			return self:GetCastSearchRange()
		end,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		cooldown = 5,
		canCast = function()
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, self:FindTarget()) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		OnPhaseStart = function()
			return self:PrepareDash()
		end,
		OnStart = function()
			return self:StartZigzagDash()
		end,
		OnInterrupt = function()
			return self:CleanupDashState(true)
		end,
		OnFinish = function()
			return self:CleanupDashState(true)
		end,
	}
end
function elite_318.prototype.PrepareDash(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = self:FindTarget()
	self.dashDirection = self:ResolveDashDirection(caster, target)
	self.dashTargetPoint = self:ResolveDashTargetPoint(caster, target)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, CAST_POINT, 10)
	end
	if self:IsMoundState(caster) then
		self:WarnUndergroundPath(caster, self.dashDirection)
		return
	end
	self:WarningRingEffect(self.dashTargetPoint, DASH_HIT_RADIUS, DASH_WARNING_DURATION)
end
function elite_318.prototype.StartZigzagDash(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local direction = self.dashDirection or self:ResolveDashDirection(caster, self:FindTarget())
	if self:IsMoundState(caster) then
		self:StartUndergroundImpale(caster, direction)
		return
	end
	local targetPoint = self.dashTargetPoint or self:ResolveDashTargetPoint(caster, self:FindTarget())
	local points = self:BuildDashPointsToTarget(caster:GetAbsOrigin(), targetPoint, direction, caster)
	local strikeDirection = self:ResolveStrikeDirection(caster:GetAbsOrigin(), targetPoint, direction)
	EmitSoundOn("Hero_BountyHunter.WindWalk", caster)
	self:StartDashSegment(caster, points, 0, targetPoint, strikeDirection)
end
function elite_318.prototype.StartDashSegment(self, caster, points, index, strikePoint, strikeDirection)
	if not IsValidAlive(nil, caster) then
		return
	end
	if index >= #points - 1 then
		FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), true)
		self:StartTargetAreaStrike(caster, strikePoint, strikeDirection)
		return
	end
	local startPoint = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local endPoint = points[index + 1 + 1]
	local direction = GetDirection(nil, endPoint, startPoint)
	if direction:Length2D() > 0.01 then
		caster:SetForwardVectorWithoutInterrupt(direction)
	end
	self:PlaySmoke(startPoint, caster)
	caster:Mover(endPoint, DASH_SEGMENT_DURATION, nil, true, true)
	self:Timer(DASH_SEGMENT_INTERVAL, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), true)
		if index < #DASH_SIDE_SIGNS then
			self:PlayDashScreenShake(endPoint)
		end
		self:StartDashSegment(caster, points, index + 1, strikePoint, strikeDirection)
	end)
end
function elite_318.prototype.WarnUndergroundPath(self, caster, direction)
	local points = self:BuildUndergroundPoints(caster:GetAbsOrigin(), direction, caster)
	do
		local index = 0
		while index < #points - 1 do
			self:WarningEffect(
				points[index + 1],
				points[index + 1 + 1],
				CAST_POINT,
				{ startWidth = UNDERGROUND_PROJECTILE_WIDTH, endWidth = UNDERGROUND_PROJECTILE_WIDTH }
			)
			index = index + 1
		end
	end
end
function elite_318.prototype.StartUndergroundImpale(self, caster, direction)
	local points = self:BuildUndergroundPoints(caster:GetAbsOrigin(), direction, caster)
	local hitTargets = {}
	self:PlaySmoke(points[1], caster)
	self:FireUndergroundSegment(caster, points, 0, hitTargets)
end
function elite_318.prototype.FireUndergroundSegment(self, caster, points, index, hitTargets)
	if not IsValidAlive(nil, caster) then
		return
	end
	if index >= #points - 1 then
		return
	end
	local start = points[index + 1]
	local ____end = points[index + 1 + 1]
	local direction = GetDirection(nil, ____end, start)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = UNDERGROUND_PROJECTILE,
		projectile_type = "linear",
		start_point = start,
		target = ____end,
		projectile_speed = UNDERGROUND_PROJECTILE_SPEED,
		projectile_distance = GetDistance(nil, start, ____end),
		projectile_range = UNDERGROUND_PROJECTILE_WIDTH,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if hitTarget and IsValidAlive(nil, hitTarget) then
				local entityIndex = hitTarget:entindex()
				if __TS__ArrayIndexOf(hitTargets, entityIndex) < 0 then
					if not IsValidAlive(nil, caster) then
						return true
					end
					hitTargets[#hitTargets + 1] = entityIndex
					caster:MonsterDamage({
						victim = hitTarget,
						damage_rate = UNDERGROUND_DAMAGE_RATE,
						ability = self,
						effectName = UNDERGROUND_HIT_PARTICLE,
					})
					AddDeBuffStatus(
						nil,
						hitTarget,
						caster,
						self,
						DebuffStatusType.STUN,
						{ duration = UNDERGROUND_STUN_DURATION }
					)
				end
				return false
			end
			self:PlaySmoke(____end, caster)
			self:FireUndergroundSegment(caster, points, index + 1, hitTargets)
			return true
		end,
	})
	if direction:Length2D() > 0.01 then
		caster:SetForwardVectorWithoutInterrupt(direction)
	end
end
function elite_318.prototype.BuildDashPointsToTarget(self, origin, targetPoint, fallbackDirection, caster)
	local start = GetGroundPosition(origin, caster)
	local ____end = GetGroundPosition(targetPoint, caster)
	local forward = self:ResolveStrikeDirection(start, ____end, fallbackDirection)
	local left = Vector(-forward.y, forward.x, 0):Normalized()
	local points = { start }
	local totalOffset = ____end:__sub(start)
	do
		local index = 0
		while index < #DASH_SIDE_SIGNS do
			local currentIndex = index
			local progress = (currentIndex + 1) / (#DASH_SIDE_SIGNS + 1)
			local sideOffset = DASH_SIDE_STEP * DASH_SIDE_SIGNS[currentIndex + 1]
			local point = start:__add(totalOffset:__mul(progress)):__add(left:__mul(sideOffset))
			points[#points + 1] = GetGroundPosition(point, caster)
			index = index + 1
		end
	end
	points[#points + 1] = ____end
	return points
end
function elite_318.prototype.BuildUndergroundPoints(self, origin, direction, caster)
	local forward = self:FlatDirection(direction)
	local left = Vector(-forward.y, forward.x, 0):Normalized()
	local points = { GetGroundPosition(origin, caster) }
	do
		local index = 0
		while index < #UNDERGROUND_SIDE_SIGNS do
			local currentIndex = index
			local forwardOffset = UNDERGROUND_SEGMENT_FORWARD_STEP * (currentIndex + 1)
			local sideOffset = UNDERGROUND_SEGMENT_SIDE_STEP * UNDERGROUND_SIDE_SIGNS[currentIndex + 1]
			local point = origin:__add(forward:__mul(forwardOffset)):__add(left:__mul(sideOffset))
			points[#points + 1] = GetGroundPosition(point, caster)
			index = index + 1
		end
	end
	return points
end
function elite_318.prototype.StartTargetAreaStrike(self, caster, strikePoint, strikeDirection)
	if not IsValidAlive(nil, caster) then
		return
	end
	local point = GetGroundPosition(strikePoint, caster)
	caster:SetForwardVectorWithoutInterrupt(strikeDirection)
	caster:AddActivityModifier("vendetta")
	caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1)
	self:Timer(DASH_ATTACK_HIT_DELAY, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		self:PlayVendettaStrikeEffect(caster, point, strikeDirection)
		EmitSoundOn("Hero_NyxAssassin.Vendetta", caster)
		self:DamageTargetArea(caster, point)
	end)
	self:Timer(DASH_ATTACK_DURATION, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		self:ResetMonsterActivity(caster)
	end)
end
function elite_318.prototype.DamageTargetArea(self, caster, position)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		position,
		nil,
		DASH_HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue46
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DASH_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = DASH_STUN_DURATION })
		end
		::__continue46::
	end
end
function elite_318.prototype.PlayVendettaStrikeEffect(self, caster, point, direction)
	local anchor = CreateModifierThinker(
		caster,
		self,
		"modifier_dummy_thinker",
		{ duration = 0.5 },
		point,
		caster:GetTeamNumber(),
		false
	)
	if IsValidAlive(nil, anchor) then
		anchor:SetAbsOrigin(point)
		anchor:SetForwardVector(direction)
		local particle = ParticleManager:CreateParticle(VENDETTA_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, anchor)
		ParticleManager:SetParticleControlEnt(
			particle,
			0,
			anchor,
			PATTACH_ABSORIGIN_FOLLOW,
			"attach_hitloc",
			point,
			true
		)
		ParticleManager:SetParticleControlTransformForward(particle, 0, point, direction)
		ParticleManager:SetParticleControlForward(particle, 0, direction)
		ParticleManager:ReleaseParticleIndex(particle)
		return
	end
	local particle = ParticleManager:CreateParticle(VENDETTA_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControlTransformForward(particle, 0, point, direction)
	ParticleManager:SetParticleControlForward(particle, 0, direction)
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_318.prototype.ResolveDashDirection(self, caster, target)
	if IsValidAlive(nil, target) then
		local direction = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
		if direction:Length2D() > 0.01 then
			return direction
		end
	end
	return self:FlatDirection(caster:GetForwardVector())
end
function elite_318.prototype.ResolveDashTargetPoint(self, caster, target)
	if IsValidAlive(nil, target) then
		return GetGroundPosition(target:GetAbsOrigin(), caster)
	end
	local point = caster:GetAbsOrigin():__add(self:FlatDirection(caster:GetForwardVector()):__mul(450))
	return GetGroundPosition(point, caster)
end
function elite_318.prototype.ResolveStrikeDirection(self, origin, targetPoint, fallbackDirection)
	local direction = GetDirection(nil, targetPoint, origin)
	local ____temp_1
	if direction:Length2D() > 0.01 then
		____temp_1 = direction
	else
		____temp_1 = self:FlatDirection(fallbackDirection)
	end
	return ____temp_1
end
function elite_318.prototype.FlatDirection(self, direction)
	local flat = Vector(direction.x, direction.y, 0)
	local ____temp_2
	if flat:Length2D() > 0.01 then
		____temp_2 = flat:Normalized()
	else
		____temp_2 = Vector(1, 0, 0)
	end
	return ____temp_2
end
function elite_318.prototype.FindTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(self:GetCastSearchRange())
end
function elite_318.prototype.GetCastSearchRange(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return CAST_RANGE
	end
	return self:IsMoundState(caster) and UNDERGROUND_CAST_RANGE or CAST_RANGE
end
function elite_318.prototype.IsMoundState(self, caster)
	return not not modifier_elite_302_mound:find_on(caster)
end
function elite_318.prototype.CleanupDashState(self, resetActivity)
	if resetActivity then
		self:ResetMonsterActivity()
	end
	self:ClearDashData()
end
function elite_318.prototype.ClearDashData(self)
	self.dashDirection = nil
	self.dashTargetPoint = nil
end
function elite_318.prototype.ResetMonsterActivity(self, unit)
	local caster = unit or self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:ClearActivityModifiers()
	caster:AddActivityModifier("aggressive")
	caster:AddActivityModifier("attack_normal_range")
end
function elite_318.prototype.PlaySmoke(self, origin, caster)
	local particle = ParticleManager:CreateParticle(SMOKE_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_318.prototype.PlayDashScreenShake(self, point)
	ScreenShake(
		point,
		SCREEN_SHAKE_AMPLITUDE,
		SCREEN_SHAKE_FREQUENCY,
		SCREEN_SHAKE_DURATION,
		SCREEN_SHAKE_RADIUS,
		0,
		true
	)
end
elite_318 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_318)
____exports.elite_318 = elite_318
return ____exports