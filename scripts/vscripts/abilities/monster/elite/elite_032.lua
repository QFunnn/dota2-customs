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
local CAST_POINT = 1.1
local ACTION_DURATION = 2.67
local CAST_DURATION = ACTION_DURATION - CAST_POINT
local LASER_RANGE = 1500
local EMPTY_LASER_RANGE = 1000
local HALF_ANGLE_DEG = 30
local DAMAGE_RATE = 25
local LASER_HEIGHT = 120
local START_KNOCKBACK_RADIUS = 400
local START_KNOCKBACK_DISTANCE = 520
local START_KNOCKBACK_DURATION = 0.25
local LASER_PARTICLE = "particles/econ/items/lion/dungeon_poacher/dungeon_poacher_finger.vpcf"
local START_KNOCKBACK_PARTICLE = "particles/dd/jg_dazzle_weave.vpcf"
local CAST_CHARGED_PARTICLE = "particles/dd/fire_ring.vpcf"
local LASER_IMPACT_SOUND = "Hero_Lion.FingerOfDeathImpact"
--- 精英技能32 - 短前摇后向前方扇形搜敌，命中目标时释放激光并造成高额伤害
____exports.elite_032 = __TS__Class()
local elite_032 = ____exports.elite_032
elite_032.name = "elite_032"
__TS__ClassExtends(elite_032, MonsterAbility_CS)
function elite_032.prototype.Precache(self, context)
	PrecacheResource("particle", LASER_PARTICLE, context)
	PrecacheResource("particle", START_KNOCKBACK_PARTICLE, context)
	PrecacheResource("particle", CAST_CHARGED_PARTICLE, context)
end
function elite_032.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = LASER_RANGE - 500,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 1,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local origin = caster:GetAbsOrigin()
			self:PlayStartKnockbackEffect(origin)
			self:KnockBackAround(caster, origin)
			self:PlayCastChargedEffect(caster)
			local target = self:GetMinDistanceUnit(2500)
			if target then
				caster:LockTargetForSpeed(target, 0.9)
			end
			local endPos = origin:__add(caster:GetForwardVector():__mul(LASER_RANGE))
			local endWidth = 1000 * math.sin(math.rad(HALF_ANGLE_DEG))
			self:WarningEffect(origin, endPos, CAST_POINT, {
				startWidth = 80,
				endWidth = endWidth,
				getDirection = function()
					return caster:GetForwardVector()
				end,
			})
			ScreenShake(origin, 50, 50, 0.5, 1000, 0, true)
			EmitSoundOn("Hero_AbyssalUnderlord.Firestorm", caster)
			EmitSoundOn("Hero_Huskar.Inner_Fire.Cast", caster)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = self:FindLaserTarget(caster)
			local origin = caster:GetAbsOrigin():__add(Vector(0, 0, LASER_HEIGHT))
			self:PlayLaserEffect(origin, target)
			EmitSoundOn("Hero_Lion.FoD.Cast.TI8_layer", caster)
			if target then
				EmitSoundOn(LASER_IMPACT_SOUND, target)
				caster:MonsterDamage({ victim = target, damage_rate = DAMAGE_RATE, ability = self })
			end
			ScreenShake(origin, 50, 50, 0.5, 1000, 0, true)
		end,
	}
end
function elite_032.prototype.FindLaserTarget(self, caster)
	local origin = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector()
	local minDot = math.cos(math.rad(HALF_ANGLE_DEG))
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		LASER_RANGE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue12
			end
			local delta = enemy:GetAbsOrigin():__sub(origin)
			local distance = delta:Length2D()
			if distance <= 0.01 or distance > LASER_RANGE then
				goto __continue12
			end
			local direction = Vector(delta.x / distance, delta.y / distance, 0)
			local dot = forward.x * direction.x + forward.y * direction.y
			if dot >= minDot then
				return enemy
			end
		end
		::__continue12::
	end
end
function elite_032.prototype.PlayStartKnockbackEffect(self, origin)
	local pfx = ParticleManager:CreateParticle(START_KNOCKBACK_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function elite_032.prototype.KnockBackAround(self, caster, origin)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		START_KNOCKBACK_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue19
			end
			local direction = GetDirection(nil, enemy:GetAbsOrigin(), origin)
			enemy:KnockBack(caster, self, {
				duration = START_KNOCKBACK_DURATION,
				distance = START_KNOCKBACK_DISTANCE,
				direction = direction,
				particleName = "",
				destroyTreesType = "onDestroy",
			})
		end
		::__continue19::
	end
end
function elite_032.prototype.PlayCastChargedEffect(self, caster)
	local origin = self:GetAttachmentPosition(caster, "attach_attack2")
	local forward = caster:GetForwardVector()
	local pfx = ParticleManager:CreateParticle(CAST_CHARGED_PARTICLE, PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(pfx, 40, caster, PATTACH_POINT_FOLLOW, "attach_attack2", origin, true)
	ParticleManager:SetParticleControlTransformForward(pfx, 40, origin, forward)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	self:Timer(CAST_POINT, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function elite_032.prototype.GetAttachmentPosition(self, caster, attachmentName)
	local attachment = caster:ScriptLookupAttachment(attachmentName)
	if attachment > 0 then
		return caster:GetAttachmentOrigin(attachment)
	end
	return caster:GetAbsOrigin():__add(Vector(0, 0, LASER_HEIGHT))
end
function elite_032.prototype.PlayLaserEffect(self, origin, target)
	local ____target_0
	if target then
		____target_0 = target:GetAbsOrigin():__add(Vector(0, 0, LASER_HEIGHT))
	else
		____target_0 =
			origin:__add(self:GetCaster():GetForwardVector():__mul(EMPTY_LASER_RANGE)):__add(Vector(0, 0, LASER_HEIGHT))
	end
	local targetPoint = ____target_0
	local pfx = ParticleManager:CreateParticle(LASER_PARTICLE, PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleAlwaysSimulate(pfx)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		origin,
		true
	)
	ParticleManager:SetParticleControlEnt(pfx, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", targetPoint, true)
	ParticleManager:SetParticleControlEnt(
		pfx,
		2,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		origin,
		true
	)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:ReleaseParticleIndex(pfx)
end
elite_032 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_032)
____exports.elite_032 = elite_032
return ____exports