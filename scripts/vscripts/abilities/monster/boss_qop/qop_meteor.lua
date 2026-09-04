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
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local YELLOW_METEOR_CAST_POINT = 0
local YELLOW_METEOR_FINAL_IMPACT_TIME = 5
local YELLOW_METEOR_TOTAL_DURATION = 5.53
local YELLOW_METEOR_BLINK_START_DURATION = 0.43
local YELLOW_METEOR_BLINK_END_DURATION = 0.67
local YELLOW_METEOR_ABILITY_4_DURATION = 1.47
local YELLOW_METEOR_ABILITY_4_START_TIME = YELLOW_METEOR_BLINK_START_DURATION + YELLOW_METEOR_BLINK_END_DURATION
local YELLOW_METEOR_MID_ACTION_DURATION = 1.35
local YELLOW_METEOR_MID_ACTION_START_TIME = YELLOW_METEOR_ABILITY_4_START_TIME + YELLOW_METEOR_ABILITY_4_DURATION
local YELLOW_METEOR_FINAL_ACTION_DURATION = 1.33
local YELLOW_METEOR_FINAL_ACTION_SHOCKWAVE_TIME = 0.8
local YELLOW_METEOR_FINAL_ACTION_START_TIME = YELLOW_METEOR_FINAL_IMPACT_TIME
	- YELLOW_METEOR_FINAL_ACTION_SHOCKWAVE_TIME
local YELLOW_METEOR_FINAL_ACTION_ANIMATION = "qop_arc_arcana_celebration_2022"
local YELLOW_METEOR_MID_ACTION_ANIMATION = "qop_arc_attack_whip_c_fast_2022"
local YELLOW_METEOR_RADIUS = 2000
local YELLOW_METEOR_DAMAGE_RATE = 70
local YELLOW_METEOR_BLOCKED_DAMAGE_RATE = 10
local YELLOW_METEOR_POWER_BARRAGE_COUNT = 3
local YELLOW_METEOR_FALLBACK_WARNING_DURATION = 1.3
local YELLOW_METEOR_FALLBACK_IMPACT_RADIUS = 450
local YELLOW_METEOR_FALLBACK_IMPACT_DAMAGE_RATE = 20
local YELLOW_METEOR_FALLBACK_RADIUS_MIN = 500
local YELLOW_METEOR_FALLBACK_RADIUS_MAX = 950
local YELLOW_METEOR_FALLBACK_SHIELD_WIDTH = 180
local YELLOW_METEOR_FALLBACK_UNIT_NAME = "monster_11316_meteor"
local YELLOW_METEOR_FALLBACK_MODEL_PARTICLE = "particles/monster/qop/chaos_meteor_on.vpcf"
local YELLOW_METEOR_RING_DROP_PARTICLE = "particles/units/heroes/hero_invoker/invoker_chaos_meteor_fly.vpcf"
local YELLOW_METEOR_RING_ROLL_PARTICLE = "particles/units/heroes/hero_invoker/invoker_chaos_meteor.vpcf"
local YELLOW_METEOR_RING_SHOCKWAVE_PARTICLE =
	"particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_sonic_wave_v2.vpcf"
local YELLOW_METEOR_RING_COUNT = 16
local YELLOW_METEOR_RING_SHOCKWAVE_COUNT = 12
local YELLOW_METEOR_RING_RADIUS_MIN = 200
local YELLOW_METEOR_RING_RADIUS_MAX = 300
local YELLOW_METEOR_RING_DROP_DURATION = 1.3
local YELLOW_METEOR_RING_DROP_HEIGHT = 1500
local YELLOW_METEOR_RING_ROLL_DISTANCE = 1200
local YELLOW_METEOR_RING_ROLL_SPEED = 1050
local YELLOW_METEOR_RING_ROLL_RADIUS = 125
local YELLOW_METEOR_RING_ROLL_DAMAGE_PCT = 10
local YELLOW_METEOR_RING_SHOCKWAVE_DISTANCE = 3000
local YELLOW_METEOR_RING_SHOCKWAVE_SPEED = 2250
local YELLOW_METEOR_RING_SHOCKWAVE_RADIUS = 150
local YELLOW_METEOR_RING_SHOCKWAVE_TRAVEL_DURATION = YELLOW_METEOR_RING_SHOCKWAVE_DISTANCE
	/ YELLOW_METEOR_RING_SHOCKWAVE_SPEED
local YELLOW_METEOR_RING_DESTROY_DELAY = 2
local YELLOW_METEOR_CAST_SOUND = "Hero_QueenOfPain.ScreamOfPain"
local YELLOW_METEOR_IMPACT_SOUND = "Hero_Invoker.ChaosMeteor.Impact"
local YELLOW_METEOR_PROJECTILE_SOUND = "Hero_Invoker.ChaosMeteor.Cast"
local YELLOW_METEOR_FINAL_SHOCKWAVE_SOUND = "Hero_QueenOfPain.SonicWave"
local YELLOW_METEOR_BLINK_START_PARTICLE = "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_start.vpcf"
local YELLOW_METEOR_BLINK_END_PARTICLE = "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_end.vpcf"
--- 黄道陨石：女王长蓄力后引爆周围区域，陨石可作为玩家掩体。
____exports.qop_meteor = __TS__Class()
local qop_meteor = ____exports.qop_meteor
qop_meteor.name = "qop_meteor"
__TS__ClassExtends(qop_meteor, MonsterAbility_CS)
function qop_meteor.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.fallbackMeteorIndexes = __TS__New(Set)
	self.fallbackMeteorToken = 0
	self.yellowMeteorCastToken = 0
end
function qop_meteor.prototype.Precache(self, context)
	PrecacheResource("particle", YELLOW_METEOR_FALLBACK_MODEL_PARTICLE, context)
	PrecacheResource("particle", YELLOW_METEOR_BLINK_START_PARTICLE, context)
	PrecacheResource("particle", YELLOW_METEOR_BLINK_END_PARTICLE, context)
	PrecacheResource("particle", YELLOW_METEOR_RING_DROP_PARTICLE, context)
	PrecacheResource("particle", YELLOW_METEOR_RING_ROLL_PARTICLE, context)
	PrecacheResource("particle", YELLOW_METEOR_RING_SHOCKWAVE_PARTICLE, context)
end
function qop_meteor.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = YELLOW_METEOR_CAST_POINT,
		castDuration = YELLOW_METEOR_TOTAL_DURATION,
		castAnimation = "",
		animationPlaybackRate = 1,
		isNotMove = true,
		OnStart = function()
			return self:StartYellowMeteorPerformance()
		end,
		OnInterrupt = function()
			return self:CancelYellowMeteor()
		end,
	}
end
function qop_meteor.prototype.StartYellowMeteorPerformance(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____self_0, ____yellowMeteorCastToken_1 = self, "yellowMeteorCastToken"
	local ____self_yellowMeteorCastToken_2 = ____self_0[____yellowMeteorCastToken_1] + 1
	____self_0[____yellowMeteorCastToken_1] = ____self_yellowMeteorCastToken_2
	local castToken = ____self_yellowMeteorCastToken_2
	local ____opt_3 = caster.GetSpawnPoint
	local spawnPoint = ____opt_3 and ____opt_3(caster)
	local startPoint = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local center = GetGroundPosition(spawnPoint or startPoint, caster)
	local blinkDirection = self:GetBlinkDirection(startPoint, center, caster)
	local target = caster:GetMinDistanceUnit(YELLOW_METEOR_RADIUS)
	if target then
		caster:LockTargetForSpeed(target, YELLOW_METEOR_TOTAL_DURATION, 4)
	end
	self:WarningRingEffect(center, YELLOW_METEOR_RADIUS, YELLOW_METEOR_FINAL_IMPACT_TIME, { speed = 0 })
	caster:EmitSound(YELLOW_METEOR_CAST_SOUND)
	self:PlayGesture(caster, ACT_DOTA_CAST_ABILITY_2, YELLOW_METEOR_BLINK_START_DURATION)
	self:PlayBlinkStartEffect(startPoint, blinkDirection)
	self:Timer(YELLOW_METEOR_BLINK_START_DURATION, function()
		if castToken ~= self.yellowMeteorCastToken or not IsValidAlive(nil, caster) then
			return
		end
		caster:SetAbsOrigin(center)
		FindClearSpaceForUnit(caster, center, true)
		caster:SetAbsAngles(0, 270, 0)
		self:PlayBlinkEndEffect(center)
		self:PlayGesture(caster, ACT_DOTA_CAST_ABILITY_2_END, YELLOW_METEOR_BLINK_END_DURATION)
		local room = self:GetM013Room(caster)
		if room and room.SpawnPowerMeteorBarrageNear then
			room:SpawnPowerMeteorBarrageNear(caster, YELLOW_METEOR_POWER_BARRAGE_COUNT)
		else
			self:StartFallbackMeteorBarrage(caster)
		end
	end)
	self:Timer(YELLOW_METEOR_ABILITY_4_START_TIME, function()
		if castToken ~= self.yellowMeteorCastToken or not IsValidAlive(nil, caster) then
			return
		end
		self:PlayGesture(caster, ACT_DOTA_CAST_ABILITY_4, YELLOW_METEOR_ABILITY_4_DURATION)
	end)
	self:Timer(YELLOW_METEOR_MID_ACTION_START_TIME, function()
		if castToken ~= self.yellowMeteorCastToken or not IsValidAlive(nil, caster) then
			return
		end
		caster:SetAnimation(YELLOW_METEOR_MID_ACTION_ANIMATION)
	end)
	self:Timer(YELLOW_METEOR_FINAL_IMPACT_TIME * 0.5, function()
		if castToken ~= self.yellowMeteorCastToken or not IsValidAlive(nil, caster) then
			return
		end
		self:StartMeteorRing(caster, center, castToken)
	end)
	self:Timer(YELLOW_METEOR_FINAL_ACTION_START_TIME, function()
		if castToken ~= self.yellowMeteorCastToken or not IsValidAlive(nil, caster) then
			return
		end
		self:PlayFinalAction(caster)
	end)
	self:Timer(YELLOW_METEOR_FINAL_IMPACT_TIME, function()
		if castToken ~= self.yellowMeteorCastToken or not IsValidAlive(nil, caster) then
			return
		end
		self:OnYellowMeteorImpact()
	end)
end
function qop_meteor.prototype.PlayGesture(self, caster, activity, duration)
	caster:RemoveGesture(activity)
	caster:StartGestureWithPlaybackRate(activity, 1)
	self:Timer(duration, function()
		local ____temp_9 = not IsValid(nil, caster)
		if not ____temp_9 then
			local ____this_8
			____this_8 = caster
			local ____opt_7 = ____this_8.IsNull
			____temp_9 = ____opt_7 and ____opt_7(____this_8)
		end
		if ____temp_9 then
			return
		end
		caster:RemoveGesture(activity)
	end)
end
function qop_meteor.prototype.GetBlinkDirection(self, startPoint, endPoint, caster)
	local offset = endPoint:__sub(startPoint)
	local flatDirection = Vector(offset.x, offset.y, 0)
	local ____temp_10
	if flatDirection:Length2D() > 0.01 then
		____temp_10 = flatDirection:Normalized()
	else
		____temp_10 = caster:GetForwardVector()
	end
	return ____temp_10
end
function qop_meteor.prototype.PlayBlinkStartEffect(self, origin, direction)
	local particle = ParticleManager:CreateParticle(YELLOW_METEOR_BLINK_START_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControlForward(particle, 0, direction)
	ParticleManager:ReleaseParticleIndex(particle)
end
function qop_meteor.prototype.PlayBlinkEndEffect(self, origin)
	local particle = ParticleManager:CreateParticle(YELLOW_METEOR_BLINK_END_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:ReleaseParticleIndex(particle)
end
function qop_meteor.prototype.PlayFinalAction(self, caster)
	caster:SetAnimation(YELLOW_METEOR_FINAL_ACTION_ANIMATION)
end
function qop_meteor.prototype.OnYellowMeteorImpact(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:EmitSound(YELLOW_METEOR_FINAL_SHOCKWAVE_SOUND)
	local room = self:GetM013Room(caster)
	if room and room.ResolveYellowMeteor then
		room:ResolveYellowMeteor(
			caster,
			YELLOW_METEOR_RADIUS,
			YELLOW_METEOR_DAMAGE_RATE,
			YELLOW_METEOR_BLOCKED_DAMAGE_RATE,
			self
		)
	else
		self:ResolveFallbackYellowMeteor(caster)
	end
	self:FireShockwaveRing(caster)
	self:Timer(YELLOW_METEOR_RING_SHOCKWAVE_TRAVEL_DURATION + YELLOW_METEOR_RING_DESTROY_DELAY, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
		local currentRoom = self:GetM013Room(caster)
		if currentRoom and currentRoom.ClearPowerMeteorMonstersInRadius then
			currentRoom:ClearPowerMeteorMonstersInRadius(origin, YELLOW_METEOR_RADIUS)
			return
		end
		self:ClearFallbackMeteors()
	end)
end
function qop_meteor.prototype.CancelYellowMeteor(self)
	self.yellowMeteorCastToken = self.yellowMeteorCastToken + 1
	self:ClearFallbackMeteors()
end
function qop_meteor.prototype.StartMeteorRing(self, caster, center, castToken)
	EmitSoundOnLocationWithCaster(center, YELLOW_METEOR_PROJECTILE_SOUND, caster)
	self:Timer(YELLOW_METEOR_RING_DROP_DURATION, function()
		if castToken ~= self.yellowMeteorCastToken or not IsValidAlive(nil, caster) then
			return
		end
		EmitSoundOnLocationWithCaster(center, YELLOW_METEOR_IMPACT_SOUND, caster)
	end)
	do
		local index = 0
		while index < YELLOW_METEOR_RING_COUNT do
			local currentIndex = index
			local currentAngle = math.pi * 2 * currentIndex / YELLOW_METEOR_RING_COUNT
			local currentDirection = Vector(math.cos(currentAngle), math.sin(currentAngle), 0):Normalized()
			local currentRadius = RandomFloat(YELLOW_METEOR_RING_RADIUS_MIN, YELLOW_METEOR_RING_RADIUS_MAX)
			local currentPoint = GetGroundPosition(center:__add(currentDirection:__mul(currentRadius)), caster)
			self:PlayMeteorRingDrop(center, currentPoint)
			self:Timer(YELLOW_METEOR_RING_DROP_DURATION, function()
				if castToken ~= self.yellowMeteorCastToken or not IsValidAlive(nil, caster) then
					return
				end
				self:CreateRollingMeteor(caster, currentPoint, currentDirection)
			end)
			index = index + 1
		end
	end
end
function qop_meteor.prototype.PlayMeteorRingDrop(self, center, point)
	local startPoint = center:__add(Vector(0, 0, YELLOW_METEOR_RING_DROP_HEIGHT))
	local particle = ParticleManager:CreateParticle(YELLOW_METEOR_RING_DROP_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, startPoint)
	ParticleManager:SetParticleControl(particle, 1, point)
	ParticleManager:SetParticleControl(particle, 2, Vector(YELLOW_METEOR_RING_DROP_DURATION, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)
end
function qop_meteor.prototype.CreateRollingMeteor(self, caster, point, direction)
	CreateProjectile(nil, {
		caster = caster,
		ability = self,
		effect_name = YELLOW_METEOR_RING_ROLL_PARTICLE,
		projectile_type = "linear",
		start_point = point,
		direction = direction,
		projectile_speed = YELLOW_METEOR_RING_ROLL_SPEED,
		projectile_distance = YELLOW_METEOR_RING_ROLL_DISTANCE,
		projectile_range = YELLOW_METEOR_RING_ROLL_RADIUS,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_BOTH,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_OTHER,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			if self:IsMeteorBlocker(hitTarget) then
				return true
			end
			if not IsValidAlive(nil, caster) then
				return
			end
			if hitTarget:GetTeamNumber() == caster:GetTeamNumber() then
				return false
			end
			local ____this_16
			____this_16 = hitTarget
			local ____opt_15 = ____this_16.IsRealHero
			if not (____opt_15 and ____opt_15(____this_16)) then
				return false
			end
			Damage:ApplyDamage({
				attacker = caster,
				victim = hitTarget,
				damage = hitTarget:GetMaxHealth() * YELLOW_METEOR_RING_ROLL_DAMAGE_PCT / 100,
				damage_type = 4,
				ability = self,
			})
			return false
		end,
	})
end
function qop_meteor.prototype.FireShockwaveRing(self, caster)
	local center = GetGroundPosition(caster:GetAbsOrigin(), caster)
	do
		local index = 0
		while index < YELLOW_METEOR_RING_SHOCKWAVE_COUNT do
			local currentIndex = index
			local currentAngle = math.pi * 2 * currentIndex / YELLOW_METEOR_RING_SHOCKWAVE_COUNT
			local currentDirection = Vector(math.cos(currentAngle), math.sin(currentAngle), 0):Normalized()
			self:CreateShockwave(caster, center, currentDirection)
			index = index + 1
		end
	end
end
function qop_meteor.prototype.CreateShockwave(self, caster, center, direction)
	CreateProjectile(nil, {
		caster = caster,
		ability = self,
		effect_name = YELLOW_METEOR_RING_SHOCKWAVE_PARTICLE,
		projectile_type = "linear",
		start_point = center:__add(Vector(0, 0, 50)),
		direction = direction,
		projectile_speed = YELLOW_METEOR_RING_SHOCKWAVE_SPEED,
		projectile_distance = YELLOW_METEOR_RING_SHOCKWAVE_DISTANCE,
		projectile_range = YELLOW_METEOR_RING_SHOCKWAVE_RADIUS,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_BOTH,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_OTHER,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			if self:TryDestroyMeteorByShockwave(caster, hitTarget) then
				return true
			end
			return false
		end,
	})
end
function qop_meteor.prototype.IsMeteorBlocker(self, unit)
	if not IsValidAlive(nil, unit) then
		return false
	end
	local ____this_18
	____this_18 = unit
	local ____opt_17 = ____this_18.GetUnitName
	return (____opt_17 and ____opt_17(____this_18)) == YELLOW_METEOR_FALLBACK_UNIT_NAME
end
function qop_meteor.prototype.TryDestroyMeteorByShockwave(self, caster, target)
	if not IsValidAlive(nil, target) then
		return false
	end
	if not self:IsMeteorBlocker(target) then
		return false
	end
	local room = self:GetM013Room(caster)
	local ____opt_19 = room and room.TryDelayDestroyPowerMeteorMonsterByYellowMeteor
	if (____opt_19 and ____opt_19(room, target, YELLOW_METEOR_RING_DESTROY_DELAY)) == true then
		return true
	end
	if target.__qop_meteor_fallback_blocker__ ~= true then
		return false
	end
	if target.__qop_yellow_meteor_destroy_pending__ == true then
		return true
	end
	target.__qop_yellow_meteor_destroy_pending__ = true
	local targetIndex = target:entindex()
	self:Timer(YELLOW_METEOR_RING_DESTROY_DELAY, function()
		local meteor = EntIndexToHScript(targetIndex)
		local ____temp_25 = not meteor or not IsValid(nil, meteor)
		if not ____temp_25 then
			local ____opt_23 = meteor.IsNull
			____temp_25 = ____opt_23 and ____opt_23(meteor)
		end
		if ____temp_25 then
			return
		end
		if meteor.__qop_yellow_meteor_destroy_pending__ ~= true then
			return
		end
		self.fallbackMeteorIndexes:delete(targetIndex)
		SafeRemoveUnit(nil, meteor)
	end)
	return true
end
function qop_meteor.prototype.StartFallbackMeteorBarrage(self, caster)
	self:ClearFallbackMeteors()
	local ____self_26, ____fallbackMeteorToken_27 = self, "fallbackMeteorToken"
	local ____self_fallbackMeteorToken_28 = ____self_26[____fallbackMeteorToken_27] + 1
	____self_26[____fallbackMeteorToken_27] = ____self_fallbackMeteorToken_28
	local token = ____self_fallbackMeteorToken_28
	local casterPoint = GetGroundPosition(caster:GetAbsOrigin(), caster)
	do
		local index = 0
		while index < YELLOW_METEOR_POWER_BARRAGE_COUNT do
			local currentIndex = index
			local angle = math.pi * 2 * currentIndex / YELLOW_METEOR_POWER_BARRAGE_COUNT + RandomFloat(-0.35, 0.35)
			local radius = RandomFloat(YELLOW_METEOR_FALLBACK_RADIUS_MIN, YELLOW_METEOR_FALLBACK_RADIUS_MAX)
			local point = GetGroundPosition(
				casterPoint:__add(Vector(math.cos(angle) * radius, math.sin(angle) * radius, 0)),
				caster
			)
			self:ScheduleFallbackMeteor(caster, point, token)
			index = index + 1
		end
	end
	self:Timer(
		YELLOW_METEOR_TOTAL_DURATION + YELLOW_METEOR_RING_SHOCKWAVE_TRAVEL_DURATION + YELLOW_METEOR_RING_DESTROY_DELAY,
		function()
			if token ~= self.fallbackMeteorToken then
				return
			end
			self:ClearFallbackMeteors()
		end
	)
end
function qop_meteor.prototype.ScheduleFallbackMeteor(self, caster, point, token)
	self:WarningRingEffect(
		point,
		YELLOW_METEOR_FALLBACK_IMPACT_RADIUS,
		YELLOW_METEOR_FALLBACK_WARNING_DURATION,
		{ speed = 0 }
	)
	self:Timer(0, function()
		if token ~= self.fallbackMeteorToken or not IsValidAlive(nil, caster) then
			return
		end
		EmitSoundOnLocationWithCaster(point, YELLOW_METEOR_PROJECTILE_SOUND, caster)
		local flyStart = point:__add(Vector(0, 0, YELLOW_METEOR_RING_DROP_HEIGHT))
		local particle = ParticleManager:CreateParticle(YELLOW_METEOR_RING_DROP_PARTICLE, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(particle, 0, flyStart)
		ParticleManager:SetParticleControl(particle, 1, point)
		ParticleManager:SetParticleControl(particle, 2, Vector(YELLOW_METEOR_RING_DROP_DURATION, 0, 0))
		ParticleManager:ReleaseParticleIndex(particle)
	end)
	self:Timer(YELLOW_METEOR_FALLBACK_WARNING_DURATION, function()
		if token ~= self.fallbackMeteorToken or not IsValidAlive(nil, caster) then
			return
		end
		EmitSoundOnLocationWithCaster(point, YELLOW_METEOR_IMPACT_SOUND, caster)
		self:DamageFallbackMeteorImpact(caster, point)
		self:CreateFallbackMeteor(caster, point)
	end)
end
function qop_meteor.prototype.DamageFallbackMeteorImpact(self, caster, point)
	local heroes = self:FindHeroesInRadius(YELLOW_METEOR_FALLBACK_IMPACT_RADIUS, point)
	for ____, hero in ipairs(heroes) do
		do
			if not IsValidAlive(nil, hero) then
				goto __continue79
			end
			caster:MonsterDamage({
				victim = hero,
				damage_rate = YELLOW_METEOR_FALLBACK_IMPACT_DAMAGE_RATE,
				damage_type = 4,
				ability = self,
			})
		end
		::__continue79::
	end
end
function qop_meteor.prototype.CreateFallbackMeteor(self, caster, point)
	local ____MyGameUnit_33 = MyGameUnit
	local ____MyGameUnit_CreateUnitAsync_34 = MyGameUnit.CreateUnitAsync
	local ____UnitType_SUMMONED_31 = UnitType.SUMMONED
	local ____point_32 = point
	local ____this_30
	____this_30 = caster
	local ____opt_29 = ____this_30.GetRoomId
	____MyGameUnit_CreateUnitAsync_34(____MyGameUnit_33, {
		unitName = YELLOW_METEOR_FALLBACK_UNIT_NAME,
		unitType = ____UnitType_SUMMONED_31,
		position = ____point_32,
		roomId = ____opt_29 and ____opt_29(____this_30),
		team = caster:GetTeamNumber(),
		findClearSpace = true,
		onSpawn = function(____, unit)
			if not unit or not IsValidAlive(nil, unit) then
				return
			end
			unit:SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)
			unit:SetAttackCapability(DOTA_UNIT_CAP_NO_ATTACK)
			unit:SetAcquisitionRange(0)
			unit:AddNewModifier(unit, nil, "modifier_phased", { duration = -1 })
			unit.__qop_meteor_fallback_blocker__ = true
			self.fallbackMeteorIndexes:add(unit:entindex())
			local particle =
				ParticleManager:CreateParticle(YELLOW_METEOR_FALLBACK_MODEL_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, unit)
			ParticleManager:SetParticleControlEnt(
				particle,
				0,
				unit,
				PATTACH_ABSORIGIN_FOLLOW,
				"attach_hitloc",
				unit:GetAbsOrigin(),
				true
			)
			unit.__pfx__ = particle
		end,
	})
end
function qop_meteor.prototype.ResolveFallbackYellowMeteor(self, caster)
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local heroes = self:FindHeroesInRadius(YELLOW_METEOR_RADIUS, origin)
	for ____, hero in ipairs(heroes) do
		do
			if not IsValidAlive(nil, hero) then
				goto __continue86
			end
			local damageRate = self:IsFallbackMeteorBlockingDamage(origin, hero) and YELLOW_METEOR_BLOCKED_DAMAGE_RATE
				or YELLOW_METEOR_DAMAGE_RATE
			caster:MonsterDamage({ victim = hero, damage_rate = damageRate, damage_type = 4, ability = self })
		end
		::__continue86::
	end
end
function qop_meteor.prototype.IsFallbackMeteorBlockingDamage(self, origin, hero)
	if not IsValidAlive(nil, hero) then
		return false
	end
	local heroPoint = GetGroundPosition(hero:GetAbsOrigin(), hero)
	local segmentX = heroPoint.x - origin.x
	local segmentY = heroPoint.y - origin.y
	local segmentLengthSquared = segmentX * segmentX + segmentY * segmentY
	if segmentLengthSquared <= 0.01 then
		return false
	end
	for ____, unitIndex in __TS__Iterator(self.fallbackMeteorIndexes) do
		do
			local meteor = EntIndexToHScript(unitIndex)
			if not meteor or not IsValidAlive(nil, meteor) then
				goto __continue92
			end
			local meteorPoint = GetGroundPosition(meteor:GetAbsOrigin(), meteor)
			local relativeX = meteorPoint.x - origin.x
			local relativeY = meteorPoint.y - origin.y
			local projection = (relativeX * segmentX + relativeY * segmentY) / segmentLengthSquared
			if projection <= 0.08 or projection >= 0.92 then
				goto __continue92
			end
			local closestX = origin.x + segmentX * projection
			local closestY = origin.y + segmentY * projection
			local offsetX = meteorPoint.x - closestX
			local offsetY = meteorPoint.y - closestY
			local ____math_max_37 = math.max
			local ____opt_35 = meteor.GetHullRadius
			local shieldWidth =
				____math_max_37(YELLOW_METEOR_FALLBACK_SHIELD_WIDTH, ____opt_35 and ____opt_35(meteor) or 0)
			if offsetX * offsetX + offsetY * offsetY <= shieldWidth * shieldWidth then
				return true
			end
		end
		::__continue92::
	end
	return false
end
function qop_meteor.prototype.ClearFallbackMeteors(self)
	self.fallbackMeteorToken = self.fallbackMeteorToken + 1
	local meteorIndexes = self.fallbackMeteorIndexes
	self.fallbackMeteorIndexes = __TS__New(Set)
	for ____, unitIndex in __TS__Iterator(meteorIndexes) do
		do
			local meteor = EntIndexToHScript(unitIndex)
			local ____temp_40 = not meteor or not IsValid(nil, meteor)
			if not ____temp_40 then
				local ____opt_38 = meteor.IsNull
				____temp_40 = ____opt_38 and ____opt_38(meteor)
			end
			if ____temp_40 then
				goto __continue98
			end
			SafeRemoveUnit(nil, meteor)
		end
		::__continue98::
	end
end
function qop_meteor.prototype.GetM013Room(self, caster)
	local ____this_42
	____this_42 = caster
	local ____opt_41 = ____this_42.GetRoomId
	local roomId = ____opt_41 and ____opt_41(____this_42)
	if roomId == nil or roomId == nil then
		return nil
	end
	return MyGameRoomManager:GetRoom(roomId)
end
qop_meteor = __TS__DecorateLegacy({ registerAbility(nil) }, qop_meteor)
____exports.qop_meteor = qop_meteor
return ____exports