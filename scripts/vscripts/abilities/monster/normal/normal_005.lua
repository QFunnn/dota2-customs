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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local CAST_RANGE = 300
local CAST_POINT = 0.67
local BREATH_DURATION = 3.05
local FIREBALL_INTERVAL = 0.3
local FIREBALL_RELEASE_TIME = 0.3
local FIREBALL_ATTACK_ANIMATION_TIME = 0.3
local FIREBALL_ATTACK_PLAYBACK_RATE = FIREBALL_ATTACK_ANIMATION_TIME / FIREBALL_INTERVAL
local FIREBALL_MIN_DISTANCE = 300
local FIREBALL_MAX_DISTANCE = 600
local FIREBALL_BAND_WIDTH = 300
local FIREBALL_RADIUS = 100
local FIREBALL_TRAVEL_TIME = 0.3
local FIREBALL_DAMAGE_RATE = 5
local TARGET_CHECK_RANGE = 500
local FRONT_CONE_HALF_ANGLE_DEG = 60
local FIREBALL_MUZZLE_FORWARD_OFFSET = 60
local FIREBALL_MUZZLE_HEIGHT = 80
local FIREBALL_FLY_PARTICLE = "particles/units/monster/dragon_knight_elder_dragon_fire.vpcf"
local FIREBALL_IMPACT_PARTICLE = "particles/units/heroes/hero_phoenix/phoenix_fire_spirit_ground.vpcf"
local BREATH_START_SOUND = "Hero_Batrider.Firefly.Cast"
local FIREBALL_IMPACT_SOUND = "Hero_OgreMagi.Fireblast.Target"
local function toGroundPos(self, point, context)
	local ground = GetGroundPosition(point, context)
	return Vector(point.x, point.y, ground.z)
end
--- 普通技能5 - 怪物持续朝前方吐出多颗火球，落地后造成小范围伤害
____exports.normal_005 = __TS__Class()
local normal_005 = ____exports.normal_005
normal_005.name = "normal_005"
__TS__ClassExtends(normal_005, MonsterAbility_CS)
function normal_005.prototype.Precache(self, context)
	PrecacheResource("particle", FIREBALL_FLY_PARTICLE, context)
	PrecacheResource("particle", FIREBALL_IMPACT_PARTICLE, context)
end
function normal_005.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = BREATH_DURATION,
		castAnimation = ACT_DOTA_SPAWN,
		animationPlaybackRate = 1,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = caster:GetMinDistanceUnit(3500)
			caster:LockTargetForSpeed(target, CAST_POINT)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			EmitSoundOn(BREATH_START_SOUND, caster)
			local target = caster:GetMinDistanceUnit(3500)
			caster:LockTargetForSpeed(target, BREATH_DURATION)
			local attackCount = math.floor((BREATH_DURATION - FIREBALL_RELEASE_TIME) / FIREBALL_INTERVAL) + 1
			do
				local i = 0
				while i < attackCount do
					local attackStart = i * FIREBALL_INTERVAL
					self:Timer(attackStart, function()
						return self:PlayAttackGesture()
					end)
					self:Timer(attackStart + FIREBALL_RELEASE_TIME, function()
						return self:LaunchFireball()
					end)
					i = i + 1
				end
			end
		end,
	}
end
function normal_005.prototype.PlayAttackGesture(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, FIREBALL_ATTACK_PLAYBACK_RATE)
end
function normal_005.prototype.LaunchFireball(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector():Normalized()
	local right = Vector(-forward.y, forward.x, 0)
	local startPos =
		origin:__add(forward:__mul(FIREBALL_MUZZLE_FORWARD_OFFSET)):__add(Vector(0, 0, FIREBALL_MUZZLE_HEIGHT))
	local lockCenter = self:GetFrontEnemyCenter(caster)
	local rawTargetPos
	if lockCenter then
		rawTargetPos = lockCenter
	else
		local distance = RandomFloat(FIREBALL_MIN_DISTANCE, FIREBALL_MAX_DISTANCE)
		local sideOffset = RandomFloat(-FIREBALL_BAND_WIDTH * 0.5, FIREBALL_BAND_WIDTH * 0.5)
		rawTargetPos = origin:__add(forward:__mul(distance)):__add(right:__mul(sideOffset))
	end
	local targetPos = toGroundPos(nil, rawTargetPos, caster)
	local flyPfx = ParticleManager:CreateParticle(FIREBALL_FLY_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(flyPfx, 0, startPos)
	ParticleManager:SetParticleControl(flyPfx, 1, targetPos)
	ParticleManager:ReleaseParticleIndex(flyPfx)
	self:Timer(FIREBALL_TRAVEL_TIME, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		local impactPfx = ParticleManager:CreateParticle(FIREBALL_IMPACT_PARTICLE, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(impactPfx, 0, targetPos)
		ParticleManager:SetParticleControl(impactPfx, 1, Vector(FIREBALL_RADIUS, FIREBALL_RADIUS, FIREBALL_RADIUS))
		ParticleManager:ReleaseParticleIndex(impactPfx)
		EmitSoundOnLocationWithCaster(targetPos, FIREBALL_IMPACT_SOUND, caster)
		self:DamageArea(targetPos)
	end)
end
function normal_005.prototype.GetFrontEnemyCenter(self, caster)
	local nearest = caster:GetMinDistanceUnit(TARGET_CHECK_RANGE)
	if not IsValidAlive(nil, nearest) then
		return
	end
	if nearest:GetTeamNumber() == caster:GetTeamNumber() then
		return
	end
	local toTarget = nearest:GetAbsOrigin():__sub(caster:GetAbsOrigin())
	local dist2D = toTarget:Length2D()
	if dist2D <= 0.001 or dist2D > TARGET_CHECK_RANGE then
		return
	end
	local f = caster:GetForwardVector()
	local f2D = Vector(f.x, f.y, 0)
	local lenF = f2D:Length2D()
	if lenF <= 0.001 then
		return
	end
	local dirToTarget = Vector(toTarget.x / dist2D, toTarget.y / dist2D, 0)
	local dirForward = Vector(f2D.x / lenF, f2D.y / lenF, 0)
	local dot = dirForward.x * dirToTarget.x + dirForward.y * dirToTarget.y
	if dot < math.cos(FRONT_CONE_HALF_ANGLE_DEG * math.pi / 180) then
		return
	end
	return nearest:GetAbsOrigin()
end
function normal_005.prototype.DamageArea(self, center)
	local caster = self:GetCaster()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		FIREBALL_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue27
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = FIREBALL_DAMAGE_RATE, ability = self })
			if math.random() < 0.5 then
				AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = 0.1 })
			else
				AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.BURN, { duration = 5 })
			end
		end
		::__continue27::
	end
end
normal_005 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_005)
____exports.normal_005 = normal_005
return ____exports