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
local PROJECTILE_EFFECT = "particles/venomancer_latent_poison_projectile.vpcf"
local TAIL_PASSIVE_EFFECT = "particles/econ/items/venomancer/toxicant/veno_toxicant_tail.vpcf"
local TAIL_PASSIVE_ATTACH = "attach_tail_fx"
local VENOMANCER_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts"
local PROJECTILE_SOUND = "Hero_Venomancer.VenomousGale"
local PROJECTILE_HIT_SOUND = "Hero_Venomancer.VenomousGaleImpact"
local PROJECTILE_ATTACH_1 = "attach_attack1"
local PROJECTILE_ATTACH_2 = "attach_attack2"
local PROJECTILE_GROUND_HEIGHT_OFFSET = 75
local CAST_RANGE = 1200
local CAST_POINT = 0.8
local FAN_ANGLE = 140
local PROJECTILE_COUNT = 6
local OFFSET_PROJECTILE_COUNT = PROJECTILE_COUNT - 1
local PROJECTILE_WAVE_COUNT = 4
local PROJECTILE_INTERVAL = 0.06
local PROJECTILE_DISTANCE = 1600
local PROJECTILE_SPEED = 1200
local PROJECTILE_RADIUS = 64
local PROJECTILE_START_OFFSET = 80
local PROJECTILE_START_HEIGHT = 96
local DAMAGE_RATE = 12
local POISON_STACK_PER_HIT = 5
local FIRE_ANIMATION_PLAYBACK_RATE = 2
local RECOIL_DISTANCE = 50
local RECOIL_DURATION = 0.1
local FULL_PROJECTILE_WAVE_COUNT = math.floor((PROJECTILE_WAVE_COUNT + 1) / 2)
local OFFSET_PROJECTILE_WAVE_COUNT = math.floor(PROJECTILE_WAVE_COUNT / 2)
local TOTAL_PROJECTILE_COUNT = FULL_PROJECTILE_WAVE_COUNT * PROJECTILE_COUNT
	+ OFFSET_PROJECTILE_WAVE_COUNT * OFFSET_PROJECTILE_COUNT
local CAST_DURATION = PROJECTILE_INTERVAL * TOTAL_PROJECTILE_COUNT
local WARNING_DISTANCE = 500
local WARNING_START_WIDTH = 120
local WARNING_END_WIDTH = 500
local HIT_KNOCKBACK_DISTANCE = 60
local HIT_KNOCKBACK_DURATION = 0.18
local HIT_KNOCKBACK_HEIGHT = 0
____exports.elite_135 = __TS__Class()
local elite_135 = ____exports.elite_135
elite_135.name = "elite_135"
__TS__ClassExtends(elite_135, MonsterAbility_CS)
function elite_135.prototype.Precache(self, context)
	PrecacheResource("particle", PROJECTILE_EFFECT, context)
	PrecacheResource("particle", TAIL_PASSIVE_EFFECT, context)
	PrecacheResource("soundfile", VENOMANCER_SOUND_EVENTS, context)
end
function elite_135.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_elite_135_tail_passive_effect.name
end
function elite_135.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 0.8,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
			local origin = caster:GetAbsOrigin()
			local endPos = origin:__add(caster:GetForwardVector():__mul(WARNING_DISTANCE))
			self:WarningEffect(origin, endPos, CAST_POINT + 0.1, {
				startWidth = WARNING_START_WIDTH,
				endWidth = WARNING_END_WIDTH,
				getDirection = function()
					return caster:GetForwardVector()
				end,
			})
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.2)
			self:FireSweepProjectiles()
		end,
	}
end
function elite_135.prototype.FireSweepProjectiles(self)
	local angleStep = FAN_ANGLE / (PROJECTILE_COUNT - 1)
	local projectileOffset = 0
	do
		local waveIndex = 0
		while waveIndex < PROJECTILE_WAVE_COUNT do
			local currentWaveIndex = waveIndex
			local currentWaveProjectileCount = self:GetWaveProjectileCount(currentWaveIndex)
			local currentWaveStartOffset = projectileOffset
			self:Timer(PROJECTILE_INTERVAL * currentWaveStartOffset, function()
				return self:ApplyWaveRecoil()
			end)
			do
				local index = 0
				while index < currentWaveProjectileCount do
					local currentIndex = index
					local currentAngle = self:GetWaveProjectileAngle(currentWaveIndex, currentIndex, angleStep)
					local currentProjectileIndex = currentWaveStartOffset + currentIndex
					local currentDelay = PROJECTILE_INTERVAL * currentProjectileIndex
					self:Timer(currentDelay, function()
						return self:FireProjectileByAngle(currentAngle, currentProjectileIndex)
					end)
					index = index + 1
				end
			end
			projectileOffset = projectileOffset + currentWaveProjectileCount
			waveIndex = waveIndex + 1
		end
	end
end
function elite_135.prototype.GetWaveProjectileCount(self, waveIndex)
	return waveIndex % 2 == 0 and PROJECTILE_COUNT or OFFSET_PROJECTILE_COUNT
end
function elite_135.prototype.GetWaveProjectileAngle(self, waveIndex, index, angleStep)
	if waveIndex % 2 == 0 then
		return FAN_ANGLE / 2 - angleStep * index
	end
	return -FAN_ANGLE / 2 + angleStep * 0.5 + angleStep * index
end
function elite_135.prototype.FireProjectileByAngle(self, angle, projectileIndex)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local forward = caster:GetForwardVector():Normalized()
	local direction = RotateVector2D(nil, forward, angle):Normalized()
	local startPoint = self:GetProjectileStartPoint(caster, direction, projectileIndex)
	self:ForcePlayFireGesture(caster)
	EmitSoundOn(PROJECTILE_SOUND, caster)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = PROJECTILE_EFFECT,
		projectile_type = "linear",
		start_point = startPoint,
		direction = direction,
		projectile_speed = PROJECTILE_SPEED,
		projectile_distance = PROJECTILE_DISTANCE,
		projectile_range = PROJECTILE_RADIUS,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if hitTarget and IsValidAlive(nil, hitTarget) then
				if not IsValidAlive(nil, caster) then
					return true
				end
				EmitSoundOn(PROJECTILE_HIT_SOUND, hitTarget)
				caster:MonsterDamage({ victim = hitTarget, damage_rate = DAMAGE_RATE, ability = self })
				AddDeBuffStatus(
					nil,
					hitTarget,
					caster,
					self,
					DebuffStatusType.POISON,
					{ stack = POISON_STACK_PER_HIT, duration = 5 }
				)
				self:ApplyHitKnockback(caster, hitTarget, direction)
				return true
			end
			return true
		end,
	})
end
function elite_135.prototype.ForcePlayFireGesture(self, caster)
	caster:RemoveGesture(ACT_DOTA_CAST_ABILITY_1)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, FIRE_ANIMATION_PLAYBACK_RATE)
end
function elite_135.prototype.GetProjectileStartPoint(self, caster, direction, projectileIndex)
	local attachName = projectileIndex % 2 == 0 and PROJECTILE_ATTACH_1 or PROJECTILE_ATTACH_2
	local attachIndex = caster:ScriptLookupAttachment(attachName)
	if attachIndex > 0 then
		return self:GetGroundOffsetPoint(caster:GetAttachmentOrigin(attachIndex), caster)
	end
	local fallbackPoint = caster
		:GetAbsOrigin()
		:__add(direction:__mul(PROJECTILE_START_OFFSET))
		:__add(Vector(0, 0, PROJECTILE_START_HEIGHT))
	return self:GetGroundOffsetPoint(fallbackPoint, caster)
end
function elite_135.prototype.GetGroundOffsetPoint(self, point, context)
	local groundZ = GetGroundHeight(point, context) or point.z
	return Vector(point.x, point.y, groundZ + PROJECTILE_GROUND_HEIGHT_OFFSET)
end
function elite_135.prototype.ApplyWaveRecoil(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local forward = caster:GetForwardVector():Normalized()
	self:ApplyRecoil(caster, forward)
end
function elite_135.prototype.ApplyRecoil(self, caster, direction)
	local recoilDir = Vector(-direction.x, -direction.y, 0):Normalized()
	local recoilTarget = caster:GetAbsOrigin():__add(recoilDir:__mul(RECOIL_DISTANCE))
	caster:Mover(recoilTarget, RECOIL_DURATION, nil, true, true)
end
function elite_135.prototype.ApplyHitKnockback(self, caster, enemy, direction)
	local planarDirection = Vector(direction.x, direction.y, 0)
	if planarDirection:Length2D() <= 0.1 then
		return
	end
	if not IsValidAlive(nil, enemy) then
		return
	end
	enemy:KnockBack(caster, self, {
		direction = planarDirection:Normalized(),
		distance = HIT_KNOCKBACK_DISTANCE,
		duration = HIT_KNOCKBACK_DURATION,
		height = HIT_KNOCKBACK_HEIGHT,
		stun = false,
		block = true,
		blockUntraversable = true,
	})
end
elite_135 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_135)
____exports.elite_135 = elite_135
____exports.modifier_elite_135_tail_passive_effect = __TS__Class()
local modifier_elite_135_tail_passive_effect = ____exports.modifier_elite_135_tail_passive_effect
modifier_elite_135_tail_passive_effect.name = "modifier_elite_135_tail_passive_effect"
__TS__ClassExtends(modifier_elite_135_tail_passive_effect, MonsterModifier_CS)
function modifier_elite_135_tail_passive_effect.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
end
function modifier_elite_135_tail_passive_effect.prototype.OnIntervalThink(self)
	self:CreateTailEffect()
	self:StartIntervalThink(-1)
end
function modifier_elite_135_tail_passive_effect.prototype.CreateTailEffect(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local pfx = ParticleManager:CreateParticle(TAIL_PASSIVE_EFFECT, PATTACH_POINT_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		parent,
		PATTACH_POINT_FOLLOW,
		TAIL_PASSIVE_ATTACH,
		parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(pfx, false, false, -1, false, false)
end
function modifier_elite_135_tail_passive_effect.prototype.IsHidden(self)
	return true
end
function modifier_elite_135_tail_passive_effect.prototype.IsPurgable(self)
	return false
end
modifier_elite_135_tail_passive_effect =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_135_tail_passive_effect)
____exports.modifier_elite_135_tail_passive_effect = modifier_elite_135_tail_passive_effect
return ____exports