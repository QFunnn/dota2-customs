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
local CAST_POINT = 1
local CAST_DURATION = 0.5
local CAST_RANGE = 2500
local PROJECTILE_SPEED = 800
local PROJECTILE_MIN_DISTANCE = 200
local PROJECTILE_RANGE = 120
local PROJECTILE_HEIGHT = 96
local EXPLOSION_RADIUS = 200
local PATH_DAMAGE_RATE = 10
local EXPLOSION_DAMAGE_RATE = 20
local EXPLOSION_SLOW_PCT = 50
local EXPLOSION_SLOW_DURATION = 3
local PARTICLE_PROJECTILE = "particles/units/heroes/hero_lich/lich_chain_frost.vpcf"
local PARTICLE_EXPLOSION = "particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_explode.vpcf"
local SOUND_NAME = "Hero_Lich.ChainFrost"
local EXPLOSION_SOUND = "Hero_Crystal.CrystalNova"
local function getDamageAttacker(self, caster)
	local ____this_1
	____this_1 = caster
	local ____opt_0 = ____this_1.GetRoomId
	local roomId = ____opt_0 and ____opt_0(____this_1)
	if roomId == nil or roomId == nil then
		return caster
	end
	local room = MyGameRoomManager:GetRoom(tostring(roomId))
	return room and room:GetRoomDummy() or caster
end
____exports.normal_019 = __TS__Class()
local normal_019 = ____exports.normal_019
normal_019.name = "normal_019"
__TS__ClassExtends(normal_019, MonsterAbility_CS)
function normal_019.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE_PROJECTILE, context)
	PrecacheResource("particle", PARTICLE_EXPLOSION, context)
end
function normal_019.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		cooldown = 5,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self._targetPoint = self:resolveTargetPoint(caster)
			self:WarningRingEffect(self._targetPoint, EXPLOSION_RADIUS, CAST_POINT)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			EmitSoundOn(SOUND_NAME, caster)
			local start = caster:GetAbsOrigin()
			local startGround = Vector(start.x, start.y, GetGroundHeight(start, caster) or start.z)
			local ____end = self._targetPoint or self:resolveTargetPoint(caster)
			local dir = GetDirection(nil, ____end, startGround)
			local distance =
				math.max(PROJECTILE_MIN_DISTANCE, math.min(GetDistance(nil, startGround, ____end), CAST_RANGE))
			local travelEnd = startGround:__add(dir:__mul(distance))
			local projectileStart = startGround:__add(Vector(0, 0, PROJECTILE_HEIGHT))
			local projectileEnd = travelEnd:__add(Vector(0, 0, PROJECTILE_HEIGHT))
			self:launchIceBall(caster, projectileStart, projectileEnd, travelEnd, distance)
		end,
		OnFinish = function()
			self._targetPoint = nil
		end,
		OnInterrupt = function()
			self._targetPoint = nil
		end,
	}
end
function normal_019.prototype.resolveTargetPoint(self, caster)
	local nearest = self:GetMinDistanceUnit(CAST_RANGE)
	if nearest and IsValidAlive(nil, nearest) then
		local pos = nearest:GetAbsOrigin()
		return Vector(pos.x, pos.y, GetGroundHeight(pos, nearest) or pos.z)
	end
	local fallback = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(math.min(CAST_RANGE, 600)))
	return Vector(fallback.x, fallback.y, GetGroundHeight(fallback, caster) or fallback.z)
end
function normal_019.prototype.launchIceBall(self, caster, startPos, endPos, explosionCenter, distance)
	local attacker = getDamageAttacker(nil, caster)
	local exploded = false
	local pfx = self:PlayTrackingProjectileAsLinear(
		PARTICLE_PROJECTILE,
		attacker,
		caster,
		caster:GetAttachmentOrigin(caster:ScriptLookupAttachment("attach_attack1"))
	)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = "",
		projectile_type = "linear",
		projectile_speed = PROJECTILE_SPEED,
		start_point = caster:GetAttachmentOrigin(caster:ScriptLookupAttachment("attach_attack1")),
		target = endPos,
		projectile_range = PROJECTILE_RANGE,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget, location)
			ParticleManager:DestroyParticle(pfx, false)
			ParticleManager:ReleaseParticleIndex(pfx)
			local gz = GetGroundHeight(location, caster) or location.z
			local pos2 = Vector(location.x, location.y, gz)
			self:playSoundAndDealDamage(attacker, caster, pos2)
			if exploded then
				return true
			end
			exploded = true
			self:explodeAt(attacker, caster, pos2)
			return true
		end,
		on_think = function(____, location)
			if not IsServer() then
				return
			end
			ParticleManager:SetParticleControl(pfx, 1, location)
		end,
	})
end
function normal_019.prototype.playSoundAndDealDamage(self, attacker, caster, location)
	local gz = GetGroundHeight(location, caster) or location.z
	local pos2 = Vector(location.x, location.y, gz)
	EmitSoundOnLocationWithCaster(pos2, EXPLOSION_SOUND, caster)
	self:DealDamageInRadius(attacker, pos2, PATH_DAMAGE_RATE, PATH_DAMAGE_RATE)
end
function normal_019.prototype.explodeAt(self, attacker, caster, center)
	local pfx = ParticleManager:CreateParticle(PARTICLE_EXPLOSION, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 3, center)
	ParticleManager:ReleaseParticleIndex(pfx)
	local enemies = self:FindHeroesInRadius(EXPLOSION_RADIUS, center)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue21
			end
			ApplyMonsterDamage(
				nil,
				attacker,
				{ victim = enemy, damage_rate = EXPLOSION_DAMAGE_RATE, damage_type = 2, ability = self }
			)
			AddDeBuffStatus(
				nil,
				enemy,
				caster,
				self,
				DebuffStatusType.ICE_SLOW,
				{ stack = EXPLOSION_SLOW_PCT, duration = EXPLOSION_SLOW_DURATION }
			)
		end
		::__continue21::
	end
end
function normal_019.prototype.DealDamageInRadius(self, caster, center, radius, damageRate)
	if not IsServer() or not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue26
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = damageRate, ability = self })
		end
		::__continue26::
	end
end
function normal_019.prototype.PlayTrackingProjectileAsLinear(self, pfx_name, attacker, target, start_position)
	local direction = GetDirection(nil, target:GetAbsOrigin(), attacker:GetAbsOrigin())
	local pfx = ParticleManager:CreateParticle(pfx_name, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, start_position)
	ParticleManager:SetParticleControl(pfx, 1, target:GetAbsOrigin() + direction * 1)
	ParticleManager:SetParticleControl(pfx, 2, Vector(attacker:GetProjectileSpeed(), 0, 0))
	return pfx
end
normal_019 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_019)
____exports.normal_019 = normal_019
return ____exports