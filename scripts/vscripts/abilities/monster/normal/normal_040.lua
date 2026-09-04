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
local modifier_normal_040_stun
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____monster_warning_effects = require("modifiers.monster.monster_warning_effects")
local warningEffectRing = ____monster_warning_effects.warningEffectRing
local TRIGGER_CHANCE_PCT = 10
local INTERNAL_COOLDOWN = 3
local TRIGGER_RANGE = 1200
local BACKSTAB_DISTANCE = 120
local WARNING_DURATION = 0.5
local WARNING_ATTACK_RADIUS = 125
local SELF_STUN_MODIFIER = "modifier_generic_stunned"
local BLINK_START_EFFECT = "particles/units/heroes/hero_queenofpain/queen_blink_start.vpcf"
local BLINK_END_EFFECT = "particles/units/heroes/hero_queenofpain/queen_blink_end.vpcf"
local HIT_EFFECT = "particles/unit/normal_040explosion.vpcf"
local BLINK_OUT_SOUND = "Hero_QueenOfPain.Blink_out"
local BLINK_IN_SOUND = "Hero_QueenOfPain.Blink_in"
--- 普通技能40 - 誓言：受伤时概率取消伤害，闪至攻击者背后并预警反击
____exports.normal_040 = __TS__Class()
local normal_040 = ____exports.normal_040
normal_040.name = "normal_040"
__TS__ClassExtends(normal_040, MonsterAbility_CS)
function normal_040.prototype.Precache(self, context)
	PrecacheResource("particle", BLINK_START_EFFECT, context)
	PrecacheResource("particle", BLINK_END_EFFECT, context)
	PrecacheResource("particle", HIT_EFFECT, context)
	PrecacheResource("particle", "particles/monster/ability_warning_ring.vpcf", context)
end
function normal_040.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_040.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_040"
end
normal_040 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_040)
____exports.normal_040 = normal_040
local modifier_normal_040 = __TS__Class()
modifier_normal_040.name = "modifier_normal_040"
__TS__ClassExtends(modifier_normal_040, MonsterModifier_CS)
function modifier_normal_040.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.nextTriggerTime = 0
end
function modifier_normal_040.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_normal_040.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.ctx.spec.victim ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	if GameRules:GetGameTime() < self.nextTriggerTime then
		return
	end
	local attacker = event.ctx.spec.attacker
	if not self:IsTriggerAttackerInRange(parent, attacker) then
		return
	end
	local hasDarknessBuff = parent:HasModifier("modifier_env_monster_darkness")
	local ____RollPercentage_1 = RollPercentage
	local ____hasDarknessBuff_0
	if hasDarknessBuff then
		____hasDarknessBuff_0 = TRIGGER_CHANCE_PCT * 3
	else
		____hasDarknessBuff_0 = TRIGGER_CHANCE_PCT
	end
	if ____RollPercentage_1(____hasDarknessBuff_0) ~= true then
		return
	end
	event.prevent_apply = true
	self.nextTriggerTime = GameRules:GetGameTime() + INTERNAL_COOLDOWN
	self:StartBackstabWarningAttack(parent, attacker)
end
function modifier_normal_040.prototype.IsTriggerAttackerInRange(self, parent, attacker)
	if not IsValidAlive(nil, attacker) then
		return false
	end
	if attacker == parent then
		return false
	end
	if attacker:GetTeamNumber() == parent:GetTeamNumber() then
		return false
	end
	return GetDistance(nil, parent:GetAbsOrigin(), attacker:GetAbsOrigin()) <= TRIGGER_RANGE
end
function modifier_normal_040.prototype.StartBackstabWarningAttack(self, parent, attacker)
	if not self:IsTriggerAttackerInRange(parent, attacker) then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local blinkTarget = self:FindBackstabPosition(parent, attacker)
	if not blinkTarget then
		return
	end
	local blinkOrigin = self:BlinkTo(parent, blinkTarget, attacker)
	local attackDirection = GetDirection(nil, attacker:GetAbsOrigin(), blinkOrigin)
	parent:SetForwardVector(attackDirection)
	parent:Stop()
	parent:AddNewModifier(
		parent,
		ability,
		"modifier_monster_cast_controller",
		{ duration = WARNING_DURATION, __lock_actions = 1 }
	)
	parent:AddNewModifier(parent, ability, modifier_normal_040_stun.name, { duration = WARNING_DURATION + 0.5 })
	parent:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, self:GetAttackPlaybackRate(parent))
	local attackOrigin = attacker:GetAbsOrigin()
	self:PlayAttackWarning(parent, attackOrigin)
	self:Timer(WARNING_DURATION, function()
		return self:PerformWarningAttack(parent, attackOrigin)
	end)
end
function modifier_normal_040.prototype.FindBackstabPosition(self, parent, attacker)
	local origin = attacker:GetAbsOrigin()
	local attackerForward = attacker:GetForwardVector()
	local backDirection = Vector(-attackerForward.x, -attackerForward.y, 0)
	if backDirection:Length2D() <= 0.001 then
		backDirection = GetDirection(nil, parent:GetAbsOrigin(), origin)
	else
		backDirection = backDirection:Normalized()
	end
	local angleOffsets = {
		0,
		35,
		-35,
		70,
		-70,
		110,
		-110,
		180,
	}
	for ____, angleOffset in ipairs(angleOffsets) do
		do
			local direction = self:RotateDirection(backDirection, angleOffset)
			local target = origin:__add(direction:__mul(BACKSTAB_DISTANCE))
			local groundTarget = GetGroundPosition(target, parent)
			if not IsGridNavDisplacementWalkable(nil, groundTarget) then
				goto __continue26
			end
			return groundTarget
		end
		::__continue26::
	end
	return nil
end
function modifier_normal_040.prototype.RotateDirection(self, direction, angleDeg)
	local rad = angleDeg * math.pi / 180
	local cos = math.cos(rad)
	local sin = math.sin(rad)
	return Vector(direction.x * cos - direction.y * sin, direction.x * sin + direction.y * cos, 0):Normalized()
end
function modifier_normal_040.prototype.BlinkTo(self, parent, target, lookTarget)
	local origin = GetGroundPosition(parent:GetAbsOrigin(), parent)
	local direction = GetDirection(nil, target, origin)
	self:PlayBlinkStartEffect(origin, target, direction)
	EmitSoundOn(BLINK_OUT_SOUND, parent)
	FindClearSpaceForUnit(parent, target, false)
	local finalOrigin = GetGroundPosition(parent:GetAbsOrigin(), parent)
	parent:SetForwardVector(GetDirection(nil, lookTarget:GetAbsOrigin(), finalOrigin))
	self:PlayBlinkEndEffect(finalOrigin, direction)
	EmitSoundOn(BLINK_IN_SOUND, parent)
	return finalOrigin
end
function modifier_normal_040.prototype.GetAttackPlaybackRate(self, parent)
	local ____this_3
	____this_3 = parent
	local ____opt_2 = ____this_3.GetAttackAnimationPoint
	local attackPoint = ____opt_2 and ____opt_2(____this_3) or 0.3
	return math.max(attackPoint / WARNING_DURATION, 0.1)
end
function modifier_normal_040.prototype.PlayAttackWarning(self, parent, origin)
	warningEffectRing(nil, parent, origin, WARNING_ATTACK_RADIUS, WARNING_DURATION)
end
function modifier_normal_040.prototype.PerformWarningAttack(self, parent, origin)
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:RemoveModifierByName("modifier_monster_cast_controller")
	parent:RemoveModifierByName(SELF_STUN_MODIFIER)
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		origin,
		nil,
		WARNING_ATTACK_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	self:PlayHitEffect(parent, origin)
	ScreenShake(parent:GetAbsOrigin(), 20, 20, 0.3, 2000, 0, true)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue35
			end
			parent:MonsterDamage({
				victim = enemy,
				damage_rate = 10,
				ability = self:GetAbility(),
			})
			MyGameAttack:PerformAttack(
				parent,
				enemy,
				{ use_projectile = false, use_effect = true, never_miss = true, is_sub_attack = true }
			)
		end
		::__continue35::
	end
end
function modifier_normal_040.prototype.PlayHitEffect(self, parent, origin)
	if not IsValidAlive(nil, parent) then
		return
	end
	EmitSoundOnLocationWithCaster(origin, "Hero_Slardar.Bash", parent)
	local pfx = ParticleManager:CreateParticle(HIT_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 3, origin + Vector(0, 0, 75))
	ParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_normal_040.prototype.PlayBlinkStartEffect(self, origin, target, direction)
	local pfx = ParticleManager:CreateParticle(BLINK_START_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, target)
	ParticleManager:SetParticleControlForward(pfx, 0, direction)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_normal_040.prototype.PlayBlinkEndEffect(self, target, direction)
	local pfx = ParticleManager:CreateParticle(BLINK_END_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, target)
	ParticleManager:SetParticleControlForward(pfx, 0, direction)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_normal_040.prototype.IsHidden(self)
	return true
end
function modifier_normal_040.prototype.IsPurgable(self)
	return false
end
modifier_normal_040 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_040") }, modifier_normal_040)
modifier_normal_040_stun = __TS__Class()
modifier_normal_040_stun.name = "modifier_normal_040_stun"
__TS__ClassExtends(modifier_normal_040_stun, MonsterModifier_CS)
function modifier_normal_040_stun.prototype.IsHidden(self)
	return true
end
function modifier_normal_040_stun.prototype.IsPurgable(self)
	return false
end
function modifier_normal_040_stun.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true }
end
modifier_normal_040_stun =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_040_stun") }, modifier_normal_040_stun)
return ____exports