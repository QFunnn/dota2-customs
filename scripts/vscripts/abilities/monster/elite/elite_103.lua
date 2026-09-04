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
local modifier_elite_103_plasma_field, modifier_elite_103_plasma_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____elite_showcase_utils = require("abilities.monster.elite.elite_showcase_utils")
local EliteCreateLimitedWarningTargetTracker = ____elite_showcase_utils.EliteCreateLimitedWarningTargetTracker
local CAST_POINT = 1.5
local WARNING_FOLLOW_DURATION = 1
local WARNING_FOLLOW_SPEED = 330
local WARNING_RADIUS = 350
local FIELD_MAX_RADIUS = 560
local CAST_RANGE = 900
local FIELD_MIN_RADIUS = 0
local FIELD_PARTICLE_RETURN_RADIUS = 1
local FIELD_WAVE_WIDTH = 110
local FIELD_DURATION = 1.1
local FIELD_EXPAND_TIME = FIELD_DURATION / 2
local FIELD_RETURN_TIME = FIELD_DURATION / 2
local FIELD_PARTICLE_SPEED = FIELD_MAX_RADIUS / FIELD_EXPAND_TIME
local MIN_DAMAGE_RATE = 20
local MAX_DAMAGE_RATE = 30
local MIN_SLOW_PCT = 5
local MAX_SLOW_PCT = 25
local SLOW_DURATION = 1.5
local WARNING_RING_PARTICLE = "particles/monster/ability_warning_ring.vpcf"
local FIELD_PARTICLE = "particles/units/heroes/hero_razor/razor_plasmafield.vpcf"
local BLINK_START_PARTICLE = "particles/units/heroes/hero_queenofpain/queen_blink_shard_start.vpcf"
local BLINK_END_PARTICLE = "particles/dd/lightning_link_hit.vpcf"
local RAZOR_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_razor.vsndevts"
local FIELD_CAST_SOUND = "Ability.PlasmaField"
--- 精英怪技能：释放向外扩散并回收的等离子场，越远处命中伤害越高。
____exports.elite_103 = __TS__Class()
local elite_103 = ____exports.elite_103
elite_103.name = "elite_103"
__TS__ClassExtends(elite_103, MonsterAbility_CS)
function elite_103.prototype.Precache(self, context)
	PrecacheResource("particle", WARNING_RING_PARTICLE, context)
	PrecacheResource("particle", FIELD_PARTICLE, context)
	PrecacheResource("particle", BLINK_START_PARTICLE, context)
	PrecacheResource("particle", BLINK_END_PARTICLE, context)
	PrecacheResource("soundfile", RAZOR_SOUND_EVENTS, context)
end
function elite_103.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = FIELD_DURATION,
		isNotMove = false,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		castProgressBarColor = "blue",
		thunderizedCounterBreak = true,
		thunderizedCounterBreakStunDuration = 1,
		thunderizedDamageImmune = true,
		canCast = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return UF_FAIL_CUSTOM
			end
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, target) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		castError = function()
			return "附近没有可释放等离子场的目标"
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if not IsValidAlive(nil, target) then
				return
			end
			caster:LockTargetForSpeed(target, CAST_POINT)
			local initialCenter = GetGroundPosition(target:GetAbsOrigin(), caster)
			local tracker = EliteCreateLimitedWarningTargetTracker(nil, {
				caster = caster,
				initialTarget = target,
				initialCenter = initialCenter,
				followDuration = WARNING_FOLLOW_DURATION,
				followSpeed = WARNING_FOLLOW_SPEED,
				resolveTarget = function()
					return target
				end,
				resolveFallbackPoint = function()
					return initialCenter
				end,
			})
			self.warningTracker = tracker
			ScreenShake(caster:GetAbsOrigin(), 5, 5, 0.8, 2000, 0, true)
			self:WarningRingEffect(initialCenter, WARNING_RADIUS, CAST_POINT, {
				getCenter = function()
					return tracker:update()
				end,
			})
		end,
		OnInterrupt = function()
			self.warningTracker = nil
			local caster = self:GetCaster()
			if IsValid(nil, caster) and not caster:IsNull() then
				modifier_elite_103_plasma_field:remove(caster)
			end
		end,
		OnFinish = function()
			self.warningTracker = nil
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsServer() or not IsValidAlive(nil, caster) then
				return
			end
			local ____opt_1 = self.warningTracker
			local blinkPosition = ____opt_1 and ____opt_1:lock()
			self.warningTracker = nil
			if blinkPosition ~= nil then
				local blinkStartPosition = caster:GetAbsOrigin()
				self:PlayBlinkParticle(BLINK_START_PARTICLE, blinkStartPosition)
				ProjectileManager:ProjectileDodge(caster)
				FindClearSpaceForUnit(caster, blinkPosition, true)
				self:PlayBlinkLinkParticle(blinkStartPosition, caster:GetAbsOrigin())
			end
			caster:SetAnimation("razor_teleport_end")
			EmitSoundOn(FIELD_CAST_SOUND, caster)
			modifier_elite_103_plasma_field:remove(caster)
			modifier_elite_103_plasma_field:applys(caster, caster, self, { duration = FIELD_DURATION })
		end,
	}
end
function elite_103.prototype.HitPlasmaFieldEnemy(self, caster, enemy, radius)
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, enemy) then
		return
	end
	local damageRate = self:GetDamageRateByRadius(radius)
	caster:MonsterDamage({ victim = enemy, damage_rate = damageRate, ability = self })
	modifier_elite_103_plasma_slow:applys(enemy, caster, self, {
		duration = SLOW_DURATION,
		slow_pct = self:GetSlowPctByRadius(radius),
	})
end
function elite_103.prototype.GetDamageRateByRadius(self, radius)
	local progress = self:GetRadiusProgress(radius)
	return MIN_DAMAGE_RATE + (MAX_DAMAGE_RATE - MIN_DAMAGE_RATE) * progress
end
function elite_103.prototype.GetSlowPctByRadius(self, radius)
	local progress = self:GetRadiusProgress(radius)
	return MIN_SLOW_PCT + (MAX_SLOW_PCT - MIN_SLOW_PCT) * progress
end
function elite_103.prototype.GetRadiusProgress(self, radius)
	local clampedRadius = math.min(math.max(radius, FIELD_MIN_RADIUS), FIELD_MAX_RADIUS)
	return (clampedRadius - FIELD_MIN_RADIUS) / (FIELD_MAX_RADIUS - FIELD_MIN_RADIUS)
end
function elite_103.prototype.PlayBlinkParticle(self, particleName, position)
	local particle = ParticleManager:CreateParticle(particleName, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(particle, false)
	ParticleManager:SetParticleControl(particle, 0, position)
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_103.prototype.PlayBlinkLinkParticle(self, startPosition, endPosition)
	local particle = ParticleManager:CreateParticle(BLINK_END_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(particle, false)
	ParticleManager:SetParticleControl(particle, 0, startPosition)
	ParticleManager:SetParticleControl(particle, 1, endPosition)
	ParticleManager:ReleaseParticleIndex(particle)
end
elite_103 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_103)
____exports.elite_103 = elite_103
modifier_elite_103_plasma_field = __TS__Class()
modifier_elite_103_plasma_field.name = "modifier_elite_103_plasma_field"
__TS__ClassExtends(modifier_elite_103_plasma_field, MonsterModifier_CS)
function modifier_elite_103_plasma_field.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.outwardHit = {}
	self.returnHit = {}
	self.previousRadius = FIELD_MIN_RADIUS
	self.hasStartedReturn = false
end
function modifier_elite_103_plasma_field.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	self.fieldPfx = ParticleManager:CreateParticle(FIELD_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(self.fieldPfx, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.fieldPfx, 1, Vector(FIELD_PARTICLE_SPEED, FIELD_MAX_RADIUS, 1))
	self.previousRadius = FIELD_MIN_RADIUS
	self.hasStartedReturn = false
	self:StartIntervalThink(FrameTime())
	self:OnIntervalThink()
end
function modifier_elite_103_plasma_field.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability or ability:IsNull() then
		self:Destroy()
		return
	end
	local elapsed = self:GetElapsedTime()
	local expanding = elapsed <= FIELD_EXPAND_TIME
	local currentRadius = self:GetCurrentRadius(elapsed)
	self:UpdateParticle(caster, elapsed)
	self:HitEnemiesOnWave(caster, ability, currentRadius, expanding)
	self.previousRadius = currentRadius
	if elapsed >= FIELD_DURATION then
		self:Destroy()
	end
end
function modifier_elite_103_plasma_field.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	if self.fieldPfx ~= nil then
		ParticleManager:DestroyParticle(self.fieldPfx, false)
		ParticleManager:ReleaseParticleIndex(self.fieldPfx)
		self.fieldPfx = nil
	end
	local ability = self:GetAbility()
	if ability and not ability:IsNull() then
		ability:DestroyDuration()
	end
end
function modifier_elite_103_plasma_field.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false }
end
function modifier_elite_103_plasma_field.prototype.IsHidden(self)
	return true
end
function modifier_elite_103_plasma_field.prototype.IsDebuff(self)
	return false
end
function modifier_elite_103_plasma_field.prototype.IsPurgable(self)
	return false
end
function modifier_elite_103_plasma_field.prototype.GetCurrentRadius(self, elapsed)
	if elapsed <= FIELD_EXPAND_TIME then
		local progress = math.min(elapsed / FIELD_EXPAND_TIME, 1)
		return FIELD_MIN_RADIUS + (FIELD_MAX_RADIUS - FIELD_MIN_RADIUS) * progress
	end
	local returnProgress = math.min((elapsed - FIELD_EXPAND_TIME) / FIELD_RETURN_TIME, 1)
	return FIELD_MAX_RADIUS - (FIELD_MAX_RADIUS - FIELD_MIN_RADIUS) * returnProgress
end
function modifier_elite_103_plasma_field.prototype.UpdateParticle(self, caster, elapsed)
	if self.fieldPfx == nil then
		return
	end
	if not IsValidAlive(nil, caster) then
		return
	end
	ParticleManager:SetParticleControl(self.fieldPfx, 0, caster:GetAbsOrigin())
	if not self.hasStartedReturn and elapsed >= FIELD_EXPAND_TIME then
		self.hasStartedReturn = true
		ParticleManager:SetParticleControl(
			self.fieldPfx,
			1,
			Vector(FIELD_PARTICLE_SPEED, FIELD_PARTICLE_RETURN_RADIUS, 1)
		)
	end
end
function modifier_elite_103_plasma_field.prototype.HitEnemiesOnWave(self, caster, ability, currentRadius, expanding)
	local minRadius = math.max(math.min(self.previousRadius, currentRadius) - FIELD_WAVE_WIDTH, 0)
	local maxRadius =
		math.min(math.max(self.previousRadius, currentRadius) + FIELD_WAVE_WIDTH, FIELD_MAX_RADIUS + FIELD_WAVE_WIDTH)
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		maxRadius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue49
			end
			local distance = GetDistance(nil, caster:GetAbsOrigin(), enemy:GetAbsOrigin())
			if distance < minRadius or distance > maxRadius then
				goto __continue49
			end
			local ____expanding_3
			if expanding then
				____expanding_3 = self.outwardHit
			else
				____expanding_3 = self.returnHit
			end
			local hitMap = ____expanding_3
			local key = tostring(enemy:entindex())
			if hitMap[key] then
				goto __continue49
			end
			hitMap[key] = true
			ability:HitPlasmaFieldEnemy(caster, enemy, distance)
		end
		::__continue49::
	end
end
modifier_elite_103_plasma_field =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_103_plasma_field") }, modifier_elite_103_plasma_field)
modifier_elite_103_plasma_slow = __TS__Class()
modifier_elite_103_plasma_slow.name = "modifier_elite_103_plasma_slow"
__TS__ClassExtends(modifier_elite_103_plasma_slow, MonsterModifier_CS)
function modifier_elite_103_plasma_slow.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetSlowPct(params.slow_pct)
end
function modifier_elite_103_plasma_slow.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:SetSlowPct(params.slow_pct)
end
function modifier_elite_103_plasma_slow.prototype.SetSlowPct(self, slowPct)
	local normalizedSlowPct = math.max(0, math.floor(slowPct or MIN_SLOW_PCT))
	self:SetStackCount(normalizedSlowPct)
end
function modifier_elite_103_plasma_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -self:GetStackCount() }
end
function modifier_elite_103_plasma_slow.prototype.IsHidden(self)
	return false
end
function modifier_elite_103_plasma_slow.prototype.IsDebuff(self)
	return true
end
function modifier_elite_103_plasma_slow.prototype.IsPurgable(self)
	return true
end
function modifier_elite_103_plasma_slow.prototype.GetTexture(self)
	return "razor_plasma_field"
end
function modifier_elite_103_plasma_slow.GetLocalizationCN(self)
	return { name = "等离子场", description = "移动速度降低。" }
end
modifier_elite_103_plasma_slow =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_103_plasma_slow") }, modifier_elite_103_plasma_slow)
return ____exports