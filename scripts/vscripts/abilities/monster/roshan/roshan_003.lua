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
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 650
local CAST_POINT = 0.35
local CAST_DURATION = 1.25
local HOLD_DURATION = 0.55
local HOLD_OFFSET = 135
local HOLD_HEIGHT = 180
local THROW_DISTANCE = 950
local THROW_DURATION = 0.75
local THROW_HEIGHT = 180
local IMPACT_RADIUS = 280
local DIRECT_DAMAGE_RATE = 34
local IMPACT_DAMAGE_RATE = 24
local LANDING_STUN_DURATION = 1
local WARNING_WIDTH_START = 160
local WARNING_WIDTH_END = 240
local TURN_SPEED = 8
local GRAB_TRAIL_PARTICLE = "particles/units/heroes/hero_tiny/tiny_toss_blur.vpcf"
local IMPACT_PARTICLE = "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf"
local GRAB_SOUND = "Roshan.Attack"
local THROW_SOUND = "Hero_Tiny.Toss.Target"
local IMPACT_SOUND = "Hero_Tiny.Toss.Impact"
____exports.roshan_003 = __TS__Class()
local roshan_003 = ____exports.roshan_003
roshan_003.name = "roshan_003"
__TS__ClassExtends(roshan_003, MonsterAbility_CS)
function roshan_003.prototype.Precache(self, context)
	PrecacheResource("particle", GRAB_TRAIL_PARTICLE, context)
	PrecacheResource("particle", IMPACT_PARTICLE, context)
end
function roshan_003.prototype.GetCooldown(self, _level)
	return 10
end
function roshan_003.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		animationPlaybackRate = 1.2,
		isNotMove = true,
		canCast = function()
			local caster = self:GetCaster()
			local ____temp_0
			if IsValidAlive(nil, caster) and IsValidAlive(nil, self:FindGrabTarget(caster)) then
				____temp_0 = UF_SUCCESS
			else
				____temp_0 = UF_FAIL_CUSTOM
			end
			return ____temp_0
		end,
		OnPhaseStart = function()
			return self:PrepareGrab()
		end,
		OnStart = function()
			return self:StartGrab()
		end,
		OnFinish = function()
			return self:ClearLockedTarget()
		end,
		OnInterrupt = function()
			return self:ClearLockedTarget()
		end,
	}
end
function roshan_003.prototype.ThrowTarget(self, target)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	local throwDirection = self:GetThrowDirection(caster, target)
	local trail = ParticleManager:CreateParticle(GRAB_TRAIL_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(trail)
	EmitSoundOn(THROW_SOUND, target)
	target:KnockBack(caster, self, {
		duration = THROW_DURATION,
		distance = THROW_DISTANCE,
		height = THROW_HEIGHT,
		direction = throwDirection,
		stun = true,
		stunDuration = 0,
		particleName = "",
	})
	self:Timer(THROW_DURATION, function()
		if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
			return
		end
		local impactCenter = GetGroundPosition(target:GetAbsOrigin(), target)
		FindClearSpaceForUnit(target, impactCenter, true)
		self:PlayImpact(impactCenter, caster)
		self:DamageImpact(caster, impactCenter, target)
	end)
end
function roshan_003.prototype.PrepareGrab(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = self:FindGrabTarget(caster)
	if not IsValidAlive(nil, target) then
		return
	end
	self.lockedTargetIndex = target:GetEntityIndex()
	caster:LockTargetForSpeed(target, CAST_POINT, TURN_SPEED)
	local direction = self:GetThrowDirection(caster, target)
	local start = caster:GetAbsOrigin():__add(direction:__mul(120))
	local ____end = start:__add(direction:__mul(THROW_DISTANCE))
	self:WarningEffect(start, ____end, CAST_POINT, { startWidth = WARNING_WIDTH_START, endWidth = WARNING_WIDTH_END })
end
function roshan_003.prototype.StartGrab(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = self:GetLockedTarget() or self:FindGrabTarget(caster)
	if not IsValidAlive(nil, target) then
		return
	end
	local direction = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
	caster:SetForwardVectorWithoutInterrupt(direction)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1.2)
	EmitSoundOn(GRAB_SOUND, caster)
	AddDeBuffStatus(nil, target, caster, self, DebuffStatusType.STUN, { duration = HOLD_DURATION + 0.2 })
	____exports.modifier_roshan_003_grabbed:applys(target, caster, self, { duration = HOLD_DURATION })
end
function roshan_003.prototype.DamageImpact(self, caster, center, thrownTarget)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		IMPACT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local damagedTargets = __TS__New(Set)
	if IsValidAlive(nil, thrownTarget) then
		damagedTargets:add(thrownTarget:GetEntityIndex())
		caster:MonsterDamage({ victim = thrownTarget, damage_rate = DIRECT_DAMAGE_RATE, ability = self })
		AddDeBuffStatus(nil, thrownTarget, caster, self, DebuffStatusType.STUN, { duration = LANDING_STUN_DURATION })
	end
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue22
			end
			local enemyIndex = enemy:GetEntityIndex()
			if damagedTargets:has(enemyIndex) then
				goto __continue22
			end
			damagedTargets:add(enemyIndex)
			caster:MonsterDamage({ victim = enemy, damage_rate = IMPACT_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = LANDING_STUN_DURATION })
		end
		::__continue22::
	end
end
function roshan_003.prototype.PlayImpact(self, center, caster)
	EmitSoundOnLocationWithCaster(center, IMPACT_SOUND, caster)
	ScreenShake(center, 16, 12, 0.35, 1200, 0, true)
	GridNav:DestroyTreesAroundPoint(center, IMPACT_RADIUS, false)
	local impact = ParticleManager:CreateParticle(IMPACT_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(impact, 0, center)
	ParticleManager:SetParticleControl(impact, 1, Vector(IMPACT_RADIUS, 0, 0))
	ParticleManager:ReleaseParticleIndex(impact)
end
function roshan_003.prototype.FindGrabTarget(self, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
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
function roshan_003.prototype.GetLockedTarget(self)
	if self.lockedTargetIndex == nil then
		return nil
	end
	return EntIndexToHScript(self.lockedTargetIndex)
end
function roshan_003.prototype.ClearLockedTarget(self)
	self.lockedTargetIndex = nil
end
function roshan_003.prototype.GetThrowDirection(self, caster, target)
	local direction = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
	if direction:Length2D() <= 0.01 then
		return caster:GetForwardVector()
	end
	return direction
end
roshan_003 = __TS__DecorateLegacy({ registerAbility(nil) }, roshan_003)
____exports.roshan_003 = roshan_003
____exports.modifier_roshan_003_grabbed = __TS__Class()
local modifier_roshan_003_grabbed = ____exports.modifier_roshan_003_grabbed
modifier_roshan_003_grabbed.name = "modifier_roshan_003_grabbed"
__TS__ClassExtends(modifier_roshan_003_grabbed, MonsterModifier_CS)
function modifier_roshan_003_grabbed.GetLocalizationCN(self)
	return { name = "肉山抓取", description = "被肉山抓住并即将被投掷。" }
end
function modifier_roshan_003_grabbed.prototype.OnCreated(self, _params)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(FrameTime())
	self:OnIntervalThink()
end
function modifier_roshan_003_grabbed.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local holdPos =
		caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(HOLD_OFFSET)):__add(Vector(0, 0, HOLD_HEIGHT))
	parent:SetAbsOrigin(holdPos)
end
function modifier_roshan_003_grabbed.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not ability or not IsValid(nil, ability) then
		if IsValid(nil, parent) and not parent:IsNull() then
			FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
		end
		return
	end
	ability:ThrowTarget(parent)
end
function modifier_roshan_003_grabbed.prototype.IsDebuff(self)
	return true
end
function modifier_roshan_003_grabbed.prototype.IsPurgable(self)
	return false
end
function modifier_roshan_003_grabbed.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
function modifier_roshan_003_grabbed.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_FLAIL
end
function modifier_roshan_003_grabbed.prototype.GetOverrideAnimationRate(self)
	return 1.5
end
function modifier_roshan_003_grabbed.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function modifier_roshan_003_grabbed.prototype.GetTexture(self)
	return "roshan_grab_and_throw"
end
modifier_roshan_003_grabbed = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_roshan_003_grabbed)
____exports.modifier_roshan_003_grabbed = modifier_roshan_003_grabbed
return ____exports