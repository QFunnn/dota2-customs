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
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_boss_brewmaster_4_leap
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____monkey_movement = require("abilities.monster.boss_monkey.monkey_movement")
local ResolveMonkeyBlinkPoint = ____monkey_movement.ResolveMonkeyBlinkPoint
local CAST_RANGE = 4500
local CAST_POINT = 0.6
local BACKSTEP_DELAY = 0.1
local BACKSTEP_DISTANCE = 200
local BACKSTEP_DURATION = 0.2
local DASH_DISTANCE = 1050
local DASH_DURATION = 0.3
local DASH_HIT_RADIUS = 160
local DASH_HIT_DAMAGE_RATE = 13
local DASH_HIT_STUN_DURATION = 0.65
local DASH_STOP_MIN_DISTANCE = 400
local SMASH_ACTION_DURATION = 0.9
local SMASH_IMPACT_DELAY = 0.5
local FOLLOWUP_ATTACK_START_DELAY = 0.5
local FOLLOWUP_DURATION = 1
local CAST_DURATION = DASH_DURATION + SMASH_ACTION_DURATION + FOLLOWUP_ATTACK_START_DELAY + 0.1
local SMASH_RADIUS = 350
local DAMAGE_RATE = 45.5
local FOLLOWUP_ATTACK_DAMAGE_RATE = 13
local KNOCKBACK_DISTANCE = 150
local KNOCKBACK_HEIGHT = 100
local KNOCKBACK_DURATION = 0.5
local STUN_DURATION = 1
local KNOCKBACK_STUN_EXTRA_DURATION = STUN_DURATION - KNOCKBACK_DURATION
local FOLLOWUP_ATTACK_COUNT = 3
local FOLLOWUP_ATTACK_PLAYBACK_RATE = 3
local FOLLOWUP_ATTACK_BASE_DURATION = 1
local FOLLOWUP_ATTACK_INTERVAL = FOLLOWUP_ATTACK_BASE_DURATION / FOLLOWUP_ATTACK_PLAYBACK_RATE
local FOLLOWUP_ATTACK_HIT_POINT = 0.43 / FOLLOWUP_ATTACK_PLAYBACK_RATE
local SMASH_EFFECT = "particles/econ/items/brewmaster/brewmaster_offhand_elixir/brewmaster_thunder_clap_elixir.vpcf"
local LEAP_STATUS_EFFECT = "particles/econ/items/phoenix/phoenix_ti10_immortal/phoenix_ti10_icarus_dive.vpcf"
local SMASH_SOUND = "Hero_Brewmaster.ThunderClap"
local CRIT_SOUND = "Hero_Brewmaster.Brawler.Crit"
local FOLLOWUP_ATTACK_SOUND = "Hero_Brewmaster.Attack"
--- 酒仙 BOSS 技能 4：后撤蓄力后冲刺砸地，并在命中后追加三次攻击演出。
____exports.boss_brewmaster_4 = __TS__Class()
local boss_brewmaster_4 = ____exports.boss_brewmaster_4
boss_brewmaster_4.name = "boss_brewmaster_4"
__TS__ClassExtends(boss_brewmaster_4, MonsterAbility_CS)
function boss_brewmaster_4.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.dashHasHit = false
	self.smashStarted = false
	self.castSequence = 0
end
function boss_brewmaster_4.prototype.Precache(self, context)
	PrecacheResource("particle", SMASH_EFFECT, context)
	PrecacheResource("particle", LEAP_STATUS_EFFECT, context)
	PrecacheResource("soundfile", "sounds/weapons/hero/brewmaster/attack01.vsnd", context)
end
function boss_brewmaster_4.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		animationPlaybackRate = 1.2,
		OnPhaseStart = function()
			return self:PrepareDash()
		end,
		OnStart = function()
			return self:StartDash()
		end,
		OnInterrupt = function()
			return self:InterruptDash()
		end,
		OnFinish = function()
			return self:ClearLeapState()
		end,
	}
end
function boss_brewmaster_4.prototype.PrepareDash(self)
	local caster = self:GetCaster()
	local ____IsValidAlive_result_0
	if IsValidAlive(nil, caster) then
		____IsValidAlive_result_0 = caster:GetMinDistanceUnit(CAST_RANGE)
	else
		____IsValidAlive_result_0 = nil
	end
	local target = ____IsValidAlive_result_0
	local ____self_1, ____castSequence_2 = self, "castSequence"
	local ____self_castSequence_3 = ____self_1[____castSequence_2] + 1
	____self_1[____castSequence_2] = ____self_castSequence_3
	local sequence = ____self_castSequence_3
	if not IsValidAlive(nil, caster) then
		return
	end
	self.followupTarget = nil
	local direction = caster:GetForwardVector()
	if IsValidAlive(nil, target) then
		direction = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
		caster:LockTargetForSpeed(target, 0.4, 8)
	end
	self.dashDirection = direction
	self:Timer(BACKSTEP_DELAY, function()
		if sequence ~= self.castSequence or not IsValidAlive(nil, caster) then
			return
		end
		local backstepOrigin = caster:GetAbsOrigin()
		local backstepEnd =
			ResolveMonkeyBlinkPoint(nil, caster, backstepOrigin:__sub(direction:__mul(BACKSTEP_DISTANCE)))
		self.dashHasHit = false
		if backstepEnd then
			caster:Mover(backstepEnd, BACKSTEP_DURATION)
		end
	end)
end
function boss_brewmaster_4.prototype.StartDash(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local sequence = self.castSequence
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local direction = self.dashDirection or caster:GetForwardVector()
	local dashEnd = ResolveMonkeyBlinkPoint(nil, caster, origin:__add(direction:__mul(DASH_DISTANCE)))
	self.dashDirection = nil
	if not dashEnd then
		return
	end
	self.smashStarted = false
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_5, 1)
	caster:SetForwardVector(direction)
	modifier_boss_brewmaster_4_leap:applys(caster, caster, self, { duration = 0.35 })
	ScreenShake(origin, 10, 10, DASH_DURATION, 2000, 0, true)
	caster:Mover(dashEnd, DASH_DURATION, function(____, position)
		if self.dashHasHit then
			if GetDistance(nil, position, origin) > DASH_STOP_MIN_DISTANCE then
				self:StartSmashSequence(sequence)
				return true
			end
			return
		end
		local hitPoint = position:__add(caster:GetForwardVector():__mul(80))
		self:DamageDashArea(hitPoint)
	end, true, true)
	self:Timer(DASH_DURATION, function()
		return self:StartSmashSequence(sequence)
	end)
end
function boss_brewmaster_4.prototype.StartSmashSequence(self, sequence)
	if sequence ~= self.castSequence or self.smashStarted then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self.smashStarted = true
	caster:FadeGesture(ACT_DOTA_CAST_ABILITY_5)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	modifier_boss_brewmaster_4_leap:applys(caster, caster, self, { duration = SMASH_ACTION_DURATION })
	local smashPoint = GetGroundPosition(caster:GetAbsOrigin(), caster)
	self:WarningRingEffect(smashPoint, SMASH_RADIUS, SMASH_IMPACT_DELAY)
	self:Timer(SMASH_IMPACT_DELAY, function()
		if sequence ~= self.castSequence or not IsValidAlive(nil, caster) then
			return
		end
		self:SmashAt(smashPoint)
	end)
	self:Timer(SMASH_ACTION_DURATION, function()
		if sequence ~= self.castSequence or not IsValid(nil, caster) then
			return
		end
		caster:FadeGesture(ACT_DOTA_CAST_ABILITY_1)
	end)
end
function boss_brewmaster_4.prototype.DamageDashArea(self, origin)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		DASH_HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue30
			end
			caster:PerformAttack(enemy, true, true, true, false, true, false, true)
			caster:MonsterDamage({ victim = enemy, damage_rate = DASH_HIT_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = DASH_HIT_STUN_DURATION })
			self.dashHasHit = true
		end
		::__continue30::
	end
end
function boss_brewmaster_4.prototype.SmashAt(self, origin)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local smashPoint = GetGroundPosition(origin, caster)
	local effect = ParticleManager:CreateParticle(SMASH_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, smashPoint)
	ParticleManager:SetParticleControl(effect, 1, Vector(SMASH_RADIUS, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect)
	EmitSoundOnLocationWithCaster(smashPoint, SMASH_SOUND, caster)
	ScreenShake(origin, 20, 20, 0.25, 3000, 0, true)
	local damagedEnemy
	for ____, enemy in ipairs(self:FindUnitInRange(smashPoint, SMASH_RADIUS)) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue35
			end
			if damagedEnemy == nil then
				damagedEnemy = enemy
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			enemy:KnockBack(caster, self, {
				origin_pos = smashPoint,
				duration = KNOCKBACK_DURATION,
				distance = KNOCKBACK_DISTANCE,
				height = KNOCKBACK_HEIGHT,
				stun = true,
				stunDuration = KNOCKBACK_STUN_EXTRA_DURATION,
			})
		end
		::__continue35::
	end
	if damagedEnemy then
		self.followupTarget = self:FindNearestEnemyAround(damagedEnemy:GetAbsOrigin())
		self:ScheduleFollowupAttacks()
	end
end
function boss_brewmaster_4.prototype.FindNearestEnemyAround(self, position)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		position,
		nil,
		CAST_RANGE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	return __TS__ArrayFind(enemies, function(____, enemy)
		return IsValidAlive(nil, enemy)
	end)
end
function boss_brewmaster_4.prototype.ScheduleFollowupAttacks(self)
	local caster = self:GetCaster()
	local target = self.followupTarget
	local sequence = self.castSequence
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	caster:SetForwardVector(GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin()))
	caster:LockTargetForSpeed(target, FOLLOWUP_DURATION, 12)
	do
		local attackIndex = 0
		while attackIndex < FOLLOWUP_ATTACK_COUNT do
			local currentAttackIndex = attackIndex
			local attackStartDelay = FOLLOWUP_ATTACK_START_DELAY + currentAttackIndex * FOLLOWUP_ATTACK_INTERVAL
			self:Timer(attackStartDelay, function()
				if sequence ~= self.castSequence or not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
					return
				end
				caster:SetForwardVector(GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin()))
				caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK_EVENT, FOLLOWUP_ATTACK_PLAYBACK_RATE)
			end)
			self:Timer(attackStartDelay + FOLLOWUP_ATTACK_HIT_POINT, function()
				if sequence ~= self.castSequence or not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
					return
				end
				caster:MonsterDamage({ victim = target, damage_rate = FOLLOWUP_ATTACK_DAMAGE_RATE, ability = self })
				EmitSoundOn(CRIT_SOUND, target)
				EmitSoundOn(FOLLOWUP_ATTACK_SOUND, caster)
			end)
			attackIndex = attackIndex + 1
		end
	end
end
function boss_brewmaster_4.prototype.InterruptDash(self)
	self.castSequence = self.castSequence + 1
	self:ClearLeapState()
end
function boss_brewmaster_4.prototype.ClearLeapState(self)
	self.dashDirection = nil
	self.dashHasHit = false
	self.smashStarted = false
	self.followupTarget = nil
	local caster = self:GetCaster()
	if IsValid(nil, caster) then
		caster:FadeGesture(ACT_DOTA_CAST_ABILITY_5)
		caster:FadeGesture(ACT_DOTA_CAST_ABILITY_1)
	end
	modifier_boss_brewmaster_4_leap:remove(caster)
end
boss_brewmaster_4 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_brewmaster_4)
____exports.boss_brewmaster_4 = boss_brewmaster_4
modifier_boss_brewmaster_4_leap = __TS__Class()
modifier_boss_brewmaster_4_leap.name = "modifier_boss_brewmaster_4_leap"
__TS__ClassExtends(modifier_boss_brewmaster_4_leap, BaseModifier_CS)
function modifier_boss_brewmaster_4_leap.prototype.GetEffectName(self)
	return LEAP_STATUS_EFFECT
end
function modifier_boss_brewmaster_4_leap.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_boss_brewmaster_4_leap.prototype.IsHidden(self)
	return true
end
function modifier_boss_brewmaster_4_leap.prototype.IsPurgable(self)
	return false
end
modifier_boss_brewmaster_4_leap = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_brewmaster_4_leap)
return ____exports