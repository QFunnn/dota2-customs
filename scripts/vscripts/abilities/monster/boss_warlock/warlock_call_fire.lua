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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 1.2
local CAST_DURATION = 1.5
local DROP_COUNT = 9
local DROP_INTERVAL = 0.06
local DROP_FALL_DELAY = 1.04
local DROP_RADIUS = 300
local DROP_DAMAGE_RATE = 25
local DROP_STUN_DURATION = 0.5
local DROP_RANGE = 800
local GROUND_DURATION = 10
local GROUND_POLL_INTERVAL = 0.1
local GROUND_DAMAGE_INTERVAL = 0.5
local GROUND_DAMAGE_RATE = 4
local GROUND_SLOW_PCT = 35
local GROUND_SLOW_DURATION = 0.7
--- 陨石下落轨迹粒子保留时长（秒）
local METEOR_FLY_PFX_LIFETIME = 2.8
--- 陨石落地爆炸粒子保留时长（秒）
local METEOR_IMPACT_PFX_LIFETIME = 4
local METEOR_FLY_PARTICLE = "particles/units/heroes/hero_invoker/invoker_chaos_meteor_fly.vpcf"
local METEOR_IMPACT_PARTICLE = "particles/units/heroes/hero_warlock/warlock_rain_of_chaos.vpcf"
local GROUND_PARTICLE = "particles/econ/items/warlock/warlock_staff_hellborn/warlock_upheaval_hellborn.vpcf"
local CAST_SOUND = "Hero_RingMaster.TheWheel.Cast.Layer"
local METEOR_SOUND = "Hero_Invoker.ChaosMeteor.Cast"
____exports.warlock_call_fire = __TS__Class()
local warlock_call_fire = ____exports.warlock_call_fire
warlock_call_fire.name = "warlock_call_fire"
__TS__ClassExtends(warlock_call_fire, MonsterAbility_CS)
function warlock_call_fire.prototype.Precache(self, context)
	PrecacheResource("particle", METEOR_FLY_PARTICLE, context)
	PrecacheResource("particle", METEOR_IMPACT_PARTICLE, context)
	PrecacheResource("particle", GROUND_PARTICLE, context)
end
function warlock_call_fire.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		isNotMove = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
		end,
		OnStart = function()
			return self:onStart()
		end,
	}
end
function warlock_call_fire.prototype.onStart(self)
	local caster = self:GetCaster()
	caster:EmitSound(CAST_SOUND)
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	local target = caster:GetMinDistanceUnit(2000)
	if target then
		caster:LockTargetForSpeed(target, CAST_POINT, 4)
	end
	local basePoint = target and target:GetAbsOrigin() or caster:GetAbsOrigin()
	local points = GetRandomPointsInCircle(nil, basePoint, 2500, DROP_COUNT, 550)
	local rainController =
		____exports.modifier_warlock_call_fire_rain_controller:applys(caster, caster, self, { duration = 6 })
	if not rainController then
		return
	end
	do
		local index = 0
		while index < #points do
			local currentPoint = points[index + 1]
			local currentDelay = index * DROP_INTERVAL
			self:Timer(currentDelay, function()
				if not currentPoint or not IsValidAlive(nil, caster) then
					return
				end
				self:playMeteorFlyEffect(currentPoint)
				rainController:AddMeteorPoint(currentPoint, GameRules:GetGameTime() + DROP_FALL_DELAY)
				ScreenShake(currentPoint, 10, 10, 0.1, 2000, 0, true)
				self:playMeteorWarningEffect(currentPoint)
			end)
			index = index + 1
		end
	end
end
function warlock_call_fire.prototype.playMeteorWarningEffect(self, position)
	self:WarningRingEffect(position, DROP_RADIUS, DROP_FALL_DELAY)
end
function warlock_call_fire.prototype.playMeteorFlyEffect(self, position)
	local caster = self:GetCaster()
	local effect = ParticleManager:CreateParticle(METEOR_FLY_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, position:__add(Vector(0, 0, 1500)))
	ParticleManager:SetParticleControl(effect, 1, position:__add(Vector(0, 0, -100)))
	ParticleManager:SetParticleControl(effect, 2, Vector(DROP_FALL_DELAY, 0, 0))
	ScreenShake(position, 10, 10, 0.1, 2000, 0, true)
	Timers:CreateTimer(METEOR_FLY_PFX_LIFETIME, function()
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
		return nil
	end)
	EmitSoundOnLocationWithCaster(position, METEOR_SOUND, caster)
end
function warlock_call_fire.prototype.playMeteorEffect(self, position)
	local caster = self:GetCaster()
	ScreenShake(position, 10, 10, 0.1, 2500, 0, true)
	local effect = ParticleManager:CreateParticle(METEOR_IMPACT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, position)
	ParticleManager:SetParticleControl(effect, 1, Vector(1, 1, 1))
	Timers:CreateTimer(METEOR_IMPACT_PFX_LIFETIME, function()
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
		ScreenShake(position, 10, 10, 0.1, 2000, 0, true)
		return nil
	end)
	EmitSoundOnLocationWithCaster(position, "Hero_Warlock.RainOfChaos", caster)
end
warlock_call_fire = __TS__DecorateLegacy({ registerAbility(nil, "warlock_call_fire") }, warlock_call_fire)
____exports.warlock_call_fire = warlock_call_fire
____exports.modifier_warlock_call_fire_rain_controller = __TS__Class()
local modifier_warlock_call_fire_rain_controller = ____exports.modifier_warlock_call_fire_rain_controller
modifier_warlock_call_fire_rain_controller.name = "modifier_warlock_call_fire_rain_controller"
__TS__ClassExtends(modifier_warlock_call_fire_rain_controller, MonsterModifier_CS)
function modifier_warlock_call_fire_rain_controller.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.zones = {}
end
function modifier_warlock_call_fire_rain_controller.prototype.IsHidden(self)
	return true
end
function modifier_warlock_call_fire_rain_controller.prototype.IsPurgable(self)
	return false
end
function modifier_warlock_call_fire_rain_controller.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.zones = {}
	self:StartIntervalThink(GROUND_POLL_INTERVAL)
end
function modifier_warlock_call_fire_rain_controller.prototype.AddMeteorPoint(self, point, landTime)
	if not IsServer() then
		return
	end
	local ____self_zones_2 = self.zones
	____self_zones_2[#____self_zones_2 + 1] = {
		point = Vector(point.x, point.y, point.z),
		landTime = landTime,
		activeUntil = landTime + GROUND_DURATION,
		nextDamageTime = landTime,
		landed = false,
	}
end
function modifier_warlock_call_fire_rain_controller.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local now = GameRules:GetGameTime()
	local nextZones = {}
	for ____, zone in ipairs(self.zones) do
		do
			if not zone.landed and now >= zone.landTime then
				self:onMeteorLanded(zone)
			end
			if not zone.landed or now <= zone.activeUntil then
				if zone.landed then
					if now >= zone.nextDamageTime then
						self:applyGroundAuraTick(zone)
						zone.nextDamageTime = now + GROUND_DAMAGE_INTERVAL
					end
				end
				nextZones[#nextZones + 1] = zone
				goto __continue26
			end
			self:destroyZoneParticle(zone)
		end
		::__continue26::
	end
	self.zones = nextZones
	if #self.zones <= 0 then
		self:Destroy()
	end
end
function modifier_warlock_call_fire_rain_controller.prototype.onMeteorLanded(self, zone)
	zone.landed = true
	local ability = self:GetAbility()
	if ability then
		ability:playMeteorEffect(zone.point)
	end
	self:applyLandingDamage(zone.point)
	self:createZoneParticle(zone)
end
function modifier_warlock_call_fire_rain_controller.prototype.applyLandingDamage(self, position)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability = self:GetAbility()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		position,
		nil,
		DROP_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		bit.bor(bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC), DOTA_UNIT_TARGET_BUILDING),
		DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
		FIND_ANY_ORDER,
		false
	)
	for ____, target in ipairs(enemies) do
		do
			if not IsValidAlive(nil, target) then
				goto __continue37
			end
			caster:MonsterDamage({ victim = target, damage_rate = DROP_DAMAGE_RATE, ability = ability })
			AddDeBuffStatus(nil, target, caster, ability, DebuffStatusType.STUN, { duration = DROP_STUN_DURATION })
		end
		::__continue37::
	end
end
function modifier_warlock_call_fire_rain_controller.prototype.applyGroundAuraTick(self, zone)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability = self:GetAbility()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		zone.point,
		nil,
		DROP_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
		FIND_ANY_ORDER,
		false
	)
	for ____, hero in ipairs(enemies) do
		do
			if not IsValidAlive(nil, hero) then
				goto __continue42
			end
			caster:MonsterDamage({ victim = hero, damage_rate = GROUND_DAMAGE_RATE, ability = ability })
			____exports.modifier_warlock_call_fire_ground_slow:applys(
				hero,
				caster,
				ability,
				{ duration = GROUND_SLOW_DURATION }
			)
		end
		::__continue42::
	end
end
function modifier_warlock_call_fire_rain_controller.prototype.createZoneParticle(self, zone)
	if zone.particleId ~= nil then
		return
	end
	local pid = ParticleManager:CreateParticle(GROUND_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, zone.point)
	ParticleManager:SetParticleControl(pid, 1, Vector(DROP_RADIUS, DROP_RADIUS, DROP_RADIUS))
	zone.particleId = pid
end
function modifier_warlock_call_fire_rain_controller.prototype.destroyZoneParticle(self, zone)
	if zone.particleId == nil then
		return
	end
	ParticleManager:DestroyParticle(zone.particleId, false)
	ParticleManager:ReleaseParticleIndex(zone.particleId)
	zone.particleId = nil
end
function modifier_warlock_call_fire_rain_controller.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	for ____, zone in ipairs(self.zones) do
		self:destroyZoneParticle(zone)
	end
	self.zones = {}
end
modifier_warlock_call_fire_rain_controller = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_warlock_call_fire_rain_controller") },
	modifier_warlock_call_fire_rain_controller
)
____exports.modifier_warlock_call_fire_rain_controller = modifier_warlock_call_fire_rain_controller
____exports.modifier_warlock_call_fire_ground_slow = __TS__Class()
local modifier_warlock_call_fire_ground_slow = ____exports.modifier_warlock_call_fire_ground_slow
modifier_warlock_call_fire_ground_slow.name = "modifier_warlock_call_fire_ground_slow"
__TS__ClassExtends(modifier_warlock_call_fire_ground_slow, MonsterModifier_CS)
function modifier_warlock_call_fire_ground_slow.prototype.IsHidden(self)
	return false
end
function modifier_warlock_call_fire_ground_slow.prototype.IsDebuff(self)
	return true
end
function modifier_warlock_call_fire_ground_slow.prototype.IsPurgable(self)
	return true
end
function modifier_warlock_call_fire_ground_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -GROUND_SLOW_PCT }
end
modifier_warlock_call_fire_ground_slow = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_warlock_call_fire_ground_slow") },
	modifier_warlock_call_fire_ground_slow
)
____exports.modifier_warlock_call_fire_ground_slow = modifier_warlock_call_fire_ground_slow
return ____exports