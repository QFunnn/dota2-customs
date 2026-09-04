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
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1000
local CAST_POINT = 0.35
local ROAR_START_DELAY = 0.5
local ROAR_DURATION = 0.67
local POST_ROAR_DURATION = 0.33
local CAST_DURATION = ROAR_START_DELAY + ROAR_DURATION + POST_ROAR_DURATION
local BEHIND_DISTANCE = 180
local ROAR_DAMAGE_RADIUS = 450
local ROAR_PULSE_INTERVAL = 0.1
local ROAR_DAMAGE_RATE = 3
local ROAR_EXPECTED_DAMAGE_PCT = 5
local ROAR_STUN_DURATION = 0.5
local FINAL_ROAR_PROTECTION_DURATION = CAST_DURATION + 0.1
local BLINK_START_EFFECT = "particles/units/heroes/hero_queenofpain/queen_blink_start.vpcf"
local BLINK_END_EFFECT = "particles/units/heroes/hero_queenofpain/queen_blink_end.vpcf"
local ROAR_DAMAGE_EFFECT = "particles/units/heroes/hero_queenofpain/queen_scream_of_pain_owner.vpcf"
local BLINK_OUT_SOUND = "Hero_QueenOfPain.Blink_out"
local BLINK_IN_SOUND = "Hero_QueenOfPain.Blink_in"
local SCREAM_SOUND = "Hero_QueenOfPain.SonicWave"
local function getGroundPosition(self, pos, context)
	return GetGroundPosition(pos, context)
end
--- 普通技能35 - 魅影尖啸：预警后瞬移至目标身后，并在自身周围持续尖啸伤害
____exports.normal_035 = __TS__Class()
local normal_035 = ____exports.normal_035
normal_035.name = "normal_035"
__TS__ClassExtends(normal_035, MonsterAbility_CS)
function normal_035.prototype.Precache(self, context)
	PrecacheResource("particle", BLINK_START_EFFECT, context)
	PrecacheResource("particle", BLINK_END_EFFECT, context)
	PrecacheResource("particle", ROAR_DAMAGE_EFFECT, context)
end
function normal_035.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_035_final_roar"
end
function normal_035.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		cooldown = 6,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:LockTargetAndLandPos(caster)
			if self.lockedLandPos then
				self:Timer(0.5, function()
					self:WarningRingEffect(self.lockedLandPos, ROAR_DAMAGE_RADIUS, CAST_POINT)
				end)
			end
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local landPos = self.lockedLandPos or getGroundPosition(nil, caster:GetAbsOrigin(), caster)
			local moveDirection = self.lockedMoveDirection or caster:GetForwardVector()
			self:PlayBlinkStartEffect(caster, landPos, moveDirection)
			EmitSoundOn(BLINK_OUT_SOUND, caster)
			FindClearSpaceForUnit(caster, landPos, false)
			self:FaceLockedTarget(caster)
			self:PlayBlinkEndEffect(caster, landPos, moveDirection)
			EmitSoundOn(BLINK_IN_SOUND, caster)
			self:Timer(ROAR_START_DELAY, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:StartRoar(caster)
			end)
		end,
		OnFinish = function()
			self:ClearLockedData()
		end,
		OnInterrupt = function()
			self:ClearLockedData()
		end,
	}
end
function normal_035.prototype.LockTargetAndLandPos(self, caster)
	self:ClearLockedData()
	local target = caster:GetMinDistanceUnit(CAST_RANGE)
	if not IsValidAlive(nil, target) then
		return
	end
	self.lockedTargetIndex = target:entindex()
	caster:LockTargetForSpeed(target, CAST_POINT)
	local targetOrigin = getGroundPosition(nil, target:GetAbsOrigin(), target)
	local backward = Vector(-target:GetForwardVector().x, -target:GetForwardVector().y, 0):Normalized()
	local landPos = getGroundPosition(nil, targetOrigin:__add(backward:__mul(BEHIND_DISTANCE)), caster)
	local safeLandPos = self:ResolveSafeBlinkLanding(caster, caster:GetAbsOrigin(), landPos)
	if not safeLandPos then
		return
	end
	self.lockedLandPos = safeLandPos
	local origin = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local moveDirection = GetDirection(nil, safeLandPos, origin)
	local ____temp_0
	if moveDirection:Length2D() > 0.01 then
		____temp_0 = moveDirection
	else
		____temp_0 = caster:GetForwardVector()
	end
	self.lockedMoveDirection = ____temp_0
end
function normal_035.prototype.FaceLockedTarget(self, caster)
	local target = self:GetLockedTarget()
	if not IsValidAlive(nil, target) then
		return
	end
	local direction = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
	if direction:Length2D() > 0.01 then
		caster:SetForwardVector(direction)
	end
end
function normal_035.prototype.ResolveSafeBlinkLanding(self, caster, origin, intendedLandPos)
	local startPoint = getGroundPosition(nil, origin, caster)
	local landPoint = getGroundPosition(nil, intendedLandPos, caster)
	if not IsGridNavDisplacementWalkable(nil, startPoint) or not IsGridNavDisplacementWalkable(nil, landPoint) then
		return nil
	end
	if not GridNav:CanFindPath(startPoint, landPoint) then
		return nil
	end
	local ____temp_1
	if GridNav:FindPathLength(startPoint, landPoint) ~= -1 then
		____temp_1 = landPoint
	else
		____temp_1 = nil
	end
	return ____temp_1
end
function normal_035.prototype.GetLockedTarget(self)
	if self.lockedTargetIndex == nil then
		return nil
	end
	local target = EntIndexToHScript(self.lockedTargetIndex)
	local ____IsValidAlive_result_2
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_2 = target
	else
		____IsValidAlive_result_2 = nil
	end
	return ____IsValidAlive_result_2
end
function normal_035.prototype.PlayBlinkStartEffect(self, caster, endPos, moveDirection)
	local origin = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local pfx = ParticleManager:CreateParticle(BLINK_START_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, endPos)
	ParticleManager:SetParticleControlForward(pfx, 0, moveDirection)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function normal_035.prototype.PlayBlinkEndEffect(self, caster, landPos, moveDirection)
	local pfx = ParticleManager:CreateParticle(BLINK_END_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, landPos)
	ParticleManager:SetParticleControlForward(pfx, 0, moveDirection)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function normal_035.prototype.StartRoar(self, caster)
	EmitSoundOn(SCREAM_SOUND, caster)
	local pulseCount = math.floor(ROAR_DURATION / ROAR_PULSE_INTERVAL) + 1
	local stunnedTargets = __TS__New(Set)
	do
		local i = 0
		while i < pulseCount do
			local currentDelay = i * ROAR_PULSE_INTERVAL
			self:Timer(currentDelay, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:DamageRoarPoint(caster, getGroundPosition(nil, caster:GetAbsOrigin(), caster), stunnedTargets)
			end)
			i = i + 1
		end
	end
end
function normal_035.prototype.ReleaseFinalRoar(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	self:LockTargetAndLandPos(caster)
	local landPos = self.lockedLandPos or getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local moveDirection = self.lockedMoveDirection or caster:GetForwardVector()
	self:PlayBlinkStartEffect(caster, landPos, moveDirection)
	EmitSoundOn(BLINK_OUT_SOUND, caster)
	FindClearSpaceForUnit(caster, landPos, false)
	self:FaceLockedTarget(caster)
	self:PlayBlinkEndEffect(caster, landPos, moveDirection)
	EmitSoundOn(BLINK_IN_SOUND, caster)
	self:Timer(ROAR_START_DELAY, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		self:StartRoar(caster)
	end)
	self:Timer(CAST_DURATION, function()
		self:ClearLockedData()
	end)
end
function normal_035.prototype.DamageRoarPoint(self, caster, center, stunnedTargets)
	local pfx = ParticleManager:CreateParticle(ROAR_DAMAGE_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, center + caster:GetForwardVector() * 20 + Vector(0, 0, 150))
	ParticleManager:ReleaseParticleIndex(pfx)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		ROAR_DAMAGE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue39
			end
			local ____opt_3 = enemy.GetTotalEnergyShield
			local maxShield = ____opt_3 and ____opt_3(enemy)
				or MyGameAttribute:GetAttribute(enemy, "total_energy_shield")
				or 0
			local expectedDamageBase = enemy:GetMaxHealth() + math.max(0, maxShield)
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = ROAR_DAMAGE_RATE,
				expected_damage_health_pct_override = ROAR_EXPECTED_DAMAGE_PCT,
				expected_damage_health_base_override = expectedDamageBase,
				ability = self,
			})
			local enemyIndex = enemy:GetEntityIndex()
			if not stunnedTargets:has(enemyIndex) then
				stunnedTargets:add(enemyIndex)
				AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = ROAR_STUN_DURATION })
			end
		end
		::__continue39::
	end
end
function normal_035.prototype.ClearLockedData(self)
	self.lockedTargetIndex = nil
	self.lockedLandPos = nil
	self.lockedMoveDirection = nil
end
normal_035 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_035)
____exports.normal_035 = normal_035
local modifier_normal_035_final_roar = __TS__Class()
modifier_normal_035_final_roar.name = "modifier_normal_035_final_roar"
__TS__ClassExtends(modifier_normal_035_final_roar, MonsterModifier_CS)
function modifier_normal_035_final_roar.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.triggered = false
end
function modifier_normal_035_final_roar.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_MIN_HEALTH_TRIGGER }
end
function modifier_normal_035_final_roar.prototype.GetAttributeBonus(self)
	local ____table_triggered_5
	if self.triggered then
		____table_triggered_5 = {}
	else
		____table_triggered_5 = { min_health = 1 }
	end
	return ____table_triggered_5
end
function modifier_normal_035_final_roar.prototype.OnMinHealthTrigger_CS(self, event)
	if not IsServer() then
		return
	end
	if self.triggered then
		return
	end
	local parent = self:GetParent()
	if event.victim ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	self.triggered = true
	self:RefreshAttributes()
	parent:AddNewModifier(
		parent,
		ability,
		"modifier_normal_035_final_roar_protection",
		{ duration = FINAL_ROAR_PROTECTION_DURATION }
	)
end
function modifier_normal_035_final_roar.prototype.IsHidden(self)
	return true
end
function modifier_normal_035_final_roar.prototype.IsPurgable(self)
	return false
end
modifier_normal_035_final_roar = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_normal_035_final_roar)
local modifier_normal_035_final_roar_protection = __TS__Class()
modifier_normal_035_final_roar_protection.name = "modifier_normal_035_final_roar_protection"
__TS__ClassExtends(modifier_normal_035_final_roar_protection, MonsterModifier_CS)
function modifier_normal_035_final_roar_protection.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	ability:ReleaseFinalRoar(parent)
	parent:AddNewModifier(parent, ability, "modifier_pause_actions", { duration = 1 })
end
function modifier_normal_035_final_roar_protection.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function modifier_normal_035_final_roar_protection.prototype.IsHidden(self)
	return false
end
function modifier_normal_035_final_roar_protection.prototype.IsPurgable(self)
	return false
end
modifier_normal_035_final_roar_protection =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_normal_035_final_roar_protection)
return ____exports