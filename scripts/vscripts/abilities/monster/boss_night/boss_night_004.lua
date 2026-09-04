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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_channel_haste_fly
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local warningEffectRing = ____monster_base.warningEffectRing
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local DARK_FLIGHT_DURATION = 5
local ORBIT_RADIUS = 1300
local PROJECTILE_START_DELAY = 1
local RETURN_TO_SPAWN_BEFORE_END = 0.5
local IMPACT_RADIUS = 120
local IMPACT_DAMAGE_RATE = 8
local IMPACT_RANDOM_RADIUS = 800
local IMPACT_HIT_PARTICLE =
	"particles/econ/items/nightstalker/nightstalker_black_nihility/nightstalker_black_nihility_void_hit.vpcf"
____exports.boss_night_004 = __TS__Class()
local boss_night_004 = ____exports.boss_night_004
boss_night_004.name = "boss_night_004"
__TS__ClassExtends(boss_night_004, MonsterAbility_CS)
function boss_night_004.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.3,
		castDuration = DARK_FLIGHT_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		isNotMove = true,
		OnStart = function()
			return self:startDarkFlight()
		end,
		OnFinish = function()
			return self:finishDarkFlight()
		end,
		OnInterrupt = function()
			return self:finishDarkFlight()
		end,
	}
end
function boss_night_004.prototype.startDarkFlight(self)
	local caster = self:GetCaster()
	caster:EmitSound("Hero_Nightstalker.Darkness.Team")
	local spawnPoint = self:resolveSpawnPoint(caster)
	local flightToken = DoUniqueString("boss_night_004_flight")
	self.activeFlightToken = flightToken
	self.currentSpawnPoint = spawnPoint
	caster:ClearDebuffs()
	self:playFlightParticles(caster)
	modifier_channel_haste_fly:applys(caster, caster, self, { duration = DARK_FLIGHT_DURATION })
	self:Timer(0.3, function()
		if not self:IsActiveFlight(flightToken) then
			return
		end
		local orbitCenter = self:createThinker(spawnPoint, DARK_FLIGHT_DURATION + 4)
		self:Timer(DARK_FLIGHT_DURATION + 3, function()
			if IsValid(nil, orbitCenter) then
				orbitCenter:RemoveSelf()
			end
		end)
		self:circleMoveAround(
			caster,
			orbitCenter,
			ORBIT_RADIUS,
			1.5,
			DARK_FLIGHT_DURATION - RETURN_TO_SPAWN_BEFORE_END - 0.3,
			flightToken
		)
	end)
	local lockTarget = self:createThinker(spawnPoint, DARK_FLIGHT_DURATION + 3)
	caster:LockTargetForSpeed(lockTarget, DARK_FLIGHT_DURATION + 0.2, 9)
	self:Timer(DARK_FLIGHT_DURATION - RETURN_TO_SPAWN_BEFORE_END, function()
		return self:returnToSpawnPoint(caster, spawnPoint, flightToken)
	end)
	local tick = 0
	Timers:CreateTimer(0.1, function()
		if not IsValidAlive(nil, caster) or not self:IsActiveFlight(flightToken) then
			return
		end
		tick = tick + 1
		if tick > PROJECTILE_START_DELAY * 10 then
			self:createDarkProjectile()
		end
		if tick < DARK_FLIGHT_DURATION * 10 then
			return 0.1
		end
	end)
end
function boss_night_004.prototype.finishDarkFlight(self)
	local caster = self:GetCaster()
	local spawnPoint = self.currentSpawnPoint
	self.activeFlightToken = nil
	self.currentSpawnPoint = nil
	if not IsValidAlive(nil, caster) or not spawnPoint then
		return
	end
	modifier_channel_haste_fly:remove(caster)
	self:forceSetToSpawnPoint(caster, spawnPoint)
end
function boss_night_004.prototype.IsActiveFlight(self, flightToken)
	return self.activeFlightToken == flightToken
end
function boss_night_004.prototype.createThinker(self, pos, duration)
	local caster = self:GetCaster()
	return CreateModifierThinker(
		caster,
		nil,
		"modifier_dummy_thinker",
		{ duration = duration },
		pos,
		caster:GetTeamNumber(),
		false
	)
end
function boss_night_004.prototype.playFlightParticles(self, caster)
	local ult = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_night_stalker/nightstalker_ulti.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:ReleaseParticleIndex(ult)
	local burst = ParticleManager:CreateParticle(
		"particles/econ/events/diretide_2020/death_effect/death_dt20_post.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:ReleaseParticleIndex(burst)
end
function boss_night_004.prototype.circleMoveAround(self, caster, center, radius, rounds, duration, flightToken)
	if not IsValidAlive(nil, center) then
		return
	end
	local start = caster:GetAbsOrigin():__sub(center:GetAbsOrigin())
	local startAngle = math.atan2(start.y, start.x)
	local startTime = GameRules:GetGameTime()
	Timers:CreateTimer(FrameTime(), function()
		if not IsValidAlive(nil, center) then
			return
		end
		if not IsValidAlive(nil, caster) or not IsValid(nil, center) or not self:IsActiveFlight(flightToken) then
			return
		end
		local elapsed = GameRules:GetGameTime() - startTime
		local progress = math.min(elapsed / duration, 1)
		local angle = startAngle + progress * rounds * math.pi * 2
		local point = center:GetAbsOrigin():__add(Vector(math.cos(angle) * radius, math.sin(angle) * radius, 0))
		caster:SetAbsOrigin(GetGroundPosition(point, caster))
		if progress < 1 then
			return FrameTime()
		end
		FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), true)
	end)
end
function boss_night_004.prototype.createDarkProjectile(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:EmitSound("Hero_Spectre.DaggerCast")
	local p0 = caster:GetAbsOrigin()
	local target = caster:GetMinDistanceUnit(2500, p0)
	local ____IsValidAlive_result_0
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_0 = target:GetAbsOrigin()
	else
		____IsValidAlive_result_0 = self:resolveSpawnPoint(caster)
	end
	local targetPoint = ____IsValidAlive_result_0
	local fv = p0:__sub(targetPoint):Normalized()
	local ____temp_1
	if math.random(1, 2) == 1 then
		____temp_1 = -math.random(50, 100)
	else
		____temp_1 = math.random(50, 100)
	end
	local angle = ____temp_1
	local fv2 = RotateVector2D(nil, fv, angle)
	local p1 = p0:__add(fv:__mul(500)):__add(fv2:__mul(1500))
	p1.z = math.random(128, 400)
	local randomImpactPoint = self:randomPointAround(targetPoint, IMPACT_RANDOM_RADIUS)
	local impactPoint = GetGroundPosition(randomImpactPoint, caster)
	local travelTime = math.random(0.8, 1.2)
	self:playBezierParticle("particles/zisefeibiao/beastmaster_wildaxe_p.vpcf", { p0, p1, impactPoint }, travelTime)
	warningEffectRing(nil, caster, impactPoint, IMPACT_RADIUS, travelTime)
	self:Timer(travelTime, function()
		return self:explodeDarkProjectile(caster, impactPoint)
	end)
end
function boss_night_004.prototype.explodeDarkProjectile(self, caster, impactPoint)
	if not IsValidAlive(nil, caster) then
		return
	end
	local groundImpactPoint = GetGroundPosition(impactPoint, caster)
	self:playPointParticle(IMPACT_HIT_PARTICLE, groundImpactPoint, 1, Vector(IMPACT_RADIUS, IMPACT_RADIUS, 0))
	local tick = 0
	Timers:CreateTimer(0.1, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		tick = tick + 1
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			groundImpactPoint,
			nil,
			IMPACT_RADIUS,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		__TS__ArrayForEach(enemies, function(____, enemy)
			return caster:MonsterDamage({
				victim = enemy,
				damage_rate = IMPACT_DAMAGE_RATE,
				ability = self,
				effectName = IMPACT_HIT_PARTICLE,
			})
		end)
		if tick < 4 then
			return 0.06
		end
	end)
	ScreenShake(groundImpactPoint, 20, 20, 0.1, 2500, 0, true)
end
function boss_night_004.prototype.resolveSpawnPoint(self, caster)
	local ____this_3
	____this_3 = caster
	local ____opt_2 = ____this_3.GetSpawnPoint
	local spawnPoint = ____opt_2 and ____opt_2(____this_3)
	if spawnPoint then
		return spawnPoint
	end
	return caster:GetAbsOrigin():__add(Vector(50, 50, 0))
end
function boss_night_004.prototype.randomPointAround(self, center, radius)
	local angle = RandomFloat(0, math.pi * 2)
	local distance = RandomFloat(0, radius)
	return center:__add(Vector(math.cos(angle) * distance, math.sin(angle) * distance, 0))
end
function boss_night_004.prototype.returnToSpawnPoint(self, caster, spawnPoint, flightToken)
	if not IsValidAlive(nil, caster) or not self:IsActiveFlight(flightToken) then
		return
	end
	local startPoint = caster:GetAbsOrigin()
	local targetPoint = GetGroundPosition(spawnPoint, caster)
	local startTime = GameRules:GetGameTime()
	Timers:CreateTimer(FrameTime(), function()
		if not IsValidAlive(nil, caster) or not self:IsActiveFlight(flightToken) then
			return
		end
		local elapsed = GameRules:GetGameTime() - startTime
		local progress = math.min(elapsed / RETURN_TO_SPAWN_BEFORE_END, 1)
		local position = startPoint:__add(targetPoint:__sub(startPoint):__mul(progress))
		caster:SetAbsOrigin(GetGroundPosition(position, caster))
		if progress < 1 then
			return FrameTime()
		end
		self:forceSetToSpawnPoint(caster, spawnPoint)
	end)
end
function boss_night_004.prototype.forceSetToSpawnPoint(self, caster, spawnPoint)
	if not IsValidAlive(nil, caster) then
		return
	end
	local targetPoint = GetGroundPosition(spawnPoint, caster)
	caster:SetAbsOrigin(targetPoint)
	FindClearSpaceForUnit(caster, targetPoint, true)
end
function boss_night_004.prototype.playPointParticle(self, name, point, duration, cp2)
	local pfx = ParticleManager:CreateParticle(name, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, point)
	if cp2 then
		ParticleManager:SetParticleControl(pfx, 2, cp2)
	end
	Timers:CreateTimer(duration + 1, function()
		ParticleManager:DestroyParticle(pfx, true)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function boss_night_004.prototype.playBezierParticle(self, name, points, duration)
	local caster = self:GetCaster()
	local thinker = CreateModifierThinker(
		caster,
		self,
		"modifier_dummy_thinker",
		{ duration = duration + 0.2 },
		points[1],
		caster:GetTeamNumber(),
		false
	)
	if not IsValidAlive(nil, thinker) then
		return
	end
	local pfx = ParticleManager:CreateParticle(name, PATTACH_ABSORIGIN_FOLLOW, thinker)
	ParticleManager:SetParticleControl(pfx, 0, points[1])
	thinker:Bezier2Mover(points, duration, nil, false, true)
	Timers:CreateTimer(duration + 0.1, function()
		ParticleManager:DestroyParticle(pfx, true)
		ParticleManager:ReleaseParticleIndex(pfx)
		if IsValid(nil, thinker) then
			thinker:RemoveSelf()
		end
	end)
end
boss_night_004 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_night_004)
____exports.boss_night_004 = boss_night_004
modifier_channel_haste_fly = __TS__Class()
modifier_channel_haste_fly.name = "modifier_channel_haste_fly"
__TS__ClassExtends(modifier_channel_haste_fly, BaseModifier_CS)
function modifier_channel_haste_fly.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
	}
end
function modifier_channel_haste_fly.prototype.CheckState(self)
	return { [MODIFIER_STATE_FLYING] = true, [MODIFIER_STATE_FORCED_FLYING_VISION] = true }
end
function modifier_channel_haste_fly.prototype.GetOverrideAnimationRate(self)
	return 1.3
end
function modifier_channel_haste_fly.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_RUN
end
function modifier_channel_haste_fly.prototype.GetPriority(self)
	return MODIFIER_PRIORITY_ULTRA + 10001
end
function modifier_channel_haste_fly.prototype.IsHidden(self)
	return true
end
function modifier_channel_haste_fly.prototype.IsPurgable(self)
	return false
end
function modifier_channel_haste_fly.prototype.GetModifierMoveSpeed_Absolute(self)
	return 600
end
function modifier_channel_haste_fly.prototype.GetActivityTranslationModifiers(self)
	return "haste"
end
modifier_channel_haste_fly = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_channel_haste_fly)
return ____exports