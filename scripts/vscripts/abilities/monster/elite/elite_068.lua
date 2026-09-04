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
local modifier_elite_068_latched, modifier_elite_068_shrink
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1200
local CAST_POINT = 1.1
local TARGET_TRACK_DURATION = 0.65
local LEAP_DURATION = 0.25
local LEAP_HEIGHT = 360
local HIT_RADIUS = 220
local IMPACT_DAMAGE_RATE = 15
local LATCH_DURATION = 6
local BACK_OFFSET = 70
local ATTACK_INTERVAL = 1
local ATTACK_HIT_DELAY = 0.4
local LATCH_BREAK_DISTANCE = 500
local LATCH_SLOW_PCT = 40
local IMPACT_PARTICLE = "particles/units/monster/broodmother_spiderlings_spawn.vpcf"
local BROODMOTHER_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_broodmother.vsndevts"
local CAST_SOUND = "Hero_Broodmother.SpawnSpiderlingsCast"
local IMPACT_SOUND = "Hero_Broodmother.SpawnSpiderlings"
local HIT_SOUND = "Hero_Broodmother.SilkenBola.Target"
--- 精英技能68 - 冰蛛扑咬：预警目标地点后扑击，命中后趴在目标背后持续撕咬
____exports.elite_068 = __TS__Class()
local elite_068 = ____exports.elite_068
elite_068.name = "elite_068"
__TS__ClassExtends(elite_068, MonsterAbility_CS)
function elite_068.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.castSequence = 0
end
function elite_068.prototype.Precache(self, context)
	PrecacheResource("particle", IMPACT_PARTICLE, context)
	PrecacheResource("soundfile", BROODMOTHER_SOUND_EVENTS, context)
end
function elite_068.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = 1000,
		castPoint = CAST_POINT,
		castDuration = LEAP_DURATION + 0.1,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		canCast = function()
			local target = self:FindTarget()
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, target) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		OnPhaseStart = function()
			local ____self_1, ____castSequence_2 = self, "castSequence"
			local ____self_castSequence_3 = ____self_1[____castSequence_2] + 1
			____self_1[____castSequence_2] = ____self_castSequence_3
			local castSequence = ____self_castSequence_3
			local caster = self:GetCaster()
			local target = self:FindTarget()
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
				self.leapTargetPos = nil
				return
			end
			self.leapTargetPos = GetGroundPosition(target:GetAbsOrigin(), target)
			local trackEndTime = GameRules:GetGameTime() + TARGET_TRACK_DURATION
			caster:LockTargetForSpeed(target, TARGET_TRACK_DURATION, 8)
			self:WarningRingEffect(self.leapTargetPos, HIT_RADIUS, CAST_POINT, {
				getCenter = function()
					if
						self.castSequence ~= castSequence
						or GameRules:GetGameTime() >= trackEndTime
						or not IsValidAlive(nil, target)
					then
						return nil
					end
					local targetPos = GetGroundPosition(target:GetAbsOrigin(), target)
					self.leapTargetPos = targetPos
					return targetPos
				end,
			})
		end,
		OnStart = function()
			self.castSequence = self.castSequence + 1
			self:LeapToTargetPoint()
		end,
		OnInterrupt = function()
			self.castSequence = self.castSequence + 1
			self.leapTargetPos = nil
		end,
	}
end
function elite_068.prototype.LeapToTargetPoint(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local landPos = self.leapTargetPos
	self.leapTargetPos = nil
	if not landPos then
		return
	end
	local origin = caster:GetAbsOrigin()
	local direction = GetDirection(nil, landPos, origin)
	local peak = origin:__add(Vector(0, 0, LEAP_HEIGHT))
	caster:SetForwardVector(direction)
	EmitSoundOn(CAST_SOUND, caster)
	caster:Bezier2Mover({ origin, peak, landPos }, LEAP_DURATION, nil, true, true)
	self:Timer(LEAP_DURATION, function()
		return self:ImpactAt(landPos)
	end)
end
function elite_068.prototype.ImpactAt(self, origin)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local impactPos = GetGroundPosition(origin, caster)
	local pfx = ParticleManager:CreateParticle(IMPACT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, impactPos)
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(impactPos, IMPACT_SOUND, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		impactPos,
		nil,
		HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local latchTarget
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue17
			end
			latchTarget = enemy
			break
		end
		::__continue17::
	end
	if IsValidAlive(nil, latchTarget) then
		caster:MonsterDamage({ victim = latchTarget, damage_rate = IMPACT_DAMAGE_RATE, ability = self })
		EmitSoundOn(HIT_SOUND, latchTarget)
		ScreenShake(latchTarget:GetAbsOrigin(), 8, 8, 0.15, 700, 0, true)
		modifier_elite_068_latched:applys(latchTarget, caster, self, { duration = LATCH_DURATION })
	end
end
function elite_068.prototype.FindTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
elite_068 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_068)
____exports.elite_068 = elite_068
modifier_elite_068_latched = __TS__Class()
modifier_elite_068_latched.name = "modifier_elite_068_latched"
__TS__ClassExtends(modifier_elite_068_latched, MonsterModifier_CS)
function modifier_elite_068_latched.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.attackElapsed = 0
end
function modifier_elite_068_latched.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.attackElapsed = 0
	self.lastTargetPos = self:GetParent():GetAbsOrigin()
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		modifier_elite_068_shrink:applys(caster, caster, self:GetAbility(), { duration = LATCH_DURATION })
	end
	self:StartIntervalThink(FrameTime())
end
function modifier_elite_068_latched.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self:GetParent()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		self:Destroy()
		return
	end
	local currentTargetPos = target:GetAbsOrigin()
	if self.lastTargetPos and GetDistance(nil, self.lastTargetPos, currentTargetPos) > LATCH_BREAK_DISTANCE then
		self:Destroy()
		return
	end
	self.lastTargetPos = currentTargetPos
	self:AttachCasterToTargetBack(caster, target)
	self.attackElapsed = self.attackElapsed + FrameTime()
	if self.attackElapsed < ATTACK_INTERVAL then
		return
	end
	self.attackElapsed = 0
	caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1)
	self:Timer(ATTACK_HIT_DELAY, function()
		if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
			return
		end
		MyGameAttack:PerformAttack(caster, target, { use_projectile = false, use_effect = true })
	end)
end
function modifier_elite_068_latched.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		modifier_elite_068_shrink:remove(caster)
		caster:SetAbsAngles(0, 0, 0)
		FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), true)
	end
end
function modifier_elite_068_latched.prototype.AttachCasterToTargetBack(self, caster, target)
	if not IsValidAlive(nil, target) then
		return
	end
	local targetPos = target:GetAbsOrigin()
	local backDir = target:GetForwardVector():__mul(-1):Normalized()
	local rawPos = targetPos:__add(backDir:__mul(BACK_OFFSET))
	local groundZ = GetGroundHeight(rawPos, target) or targetPos.z
	local attachPos = Vector(rawPos.x, rawPos.y, groundZ)
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:SetForwardVector(GetDirection(nil, targetPos, attachPos))
	caster:SetAbsOrigin(attachPos + Vector(0, 0, 125))
	caster:SetAbsAngles(-90, caster:GetAngles().y, caster:GetAngles().z)
end
function modifier_elite_068_latched.prototype.IsHidden(self)
	return false
end
function modifier_elite_068_latched.prototype.IsDebuff(self)
	return true
end
function modifier_elite_068_latched.prototype.IsPurgable(self)
	return true
end
function modifier_elite_068_latched.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -LATCH_SLOW_PCT }
end
function modifier_elite_068_latched.GetLocalizationCN(self)
	return { name = "冰蛛附背", description = "冰蛛趴在背后持续撕咬，每秒受到一次攻击。" }
end
modifier_elite_068_latched =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_068_latched") }, modifier_elite_068_latched)
modifier_elite_068_shrink = __TS__Class()
modifier_elite_068_shrink.name = "modifier_elite_068_shrink"
__TS__ClassExtends(modifier_elite_068_shrink, MonsterModifier_CS)
function modifier_elite_068_shrink.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE }
end
function modifier_elite_068_shrink.prototype.GetModifierModelScale(self)
	return -50
end
function modifier_elite_068_shrink.prototype.IsHidden(self)
	return true
end
function modifier_elite_068_shrink.prototype.IsPurgable(self)
	return false
end
function modifier_elite_068_shrink.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end
modifier_elite_068_shrink =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_068_shrink") }, modifier_elite_068_shrink)
return ____exports