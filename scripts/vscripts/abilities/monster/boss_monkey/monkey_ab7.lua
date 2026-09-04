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
local ____monkey_movement = require("abilities.monster.boss_monkey.monkey_movement")
local ResolveMonkeyBlinkPoint = ____monkey_movement.ResolveMonkeyBlinkPoint
local MONKEY_AB7_CAST_POINT = 0.5
local MONKEY_AB7_JUMP_DURATION = 0.45
local MONKEY_AB7_JUMP_FIRE_DELAY = 0.25
local MONKEY_AB7_PROJECTILE_INTERVAL = 0.05 * 0.9
local MONKEY_AB7_PROJECTILE_COUNT = 64
local MONKEY_AB7_CAST_DURATION = MONKEY_AB7_JUMP_DURATION
	+ MONKEY_AB7_JUMP_FIRE_DELAY
	+ MONKEY_AB7_PROJECTILE_INTERVAL * MONKEY_AB7_PROJECTILE_COUNT
	+ 0.2
local MONKEY_AB7_PROJECTILE_DISTANCE = 2200
local MONKEY_AB7_PROJECTILE_RANGE = 60
local MONKEY_AB7_PROJECTILE_HEIGHT = 120
local MONKEY_AB7_SPIRAL_ANGLE_STEP = 22.5
local MONKEY_AB7_PAIR_ANGLE_OFFSET_MIN = 2
local MONKEY_AB7_PAIR_ANGLE_OFFSET_MAX = 8
local MONKEY_AB7_JUMP_HEIGHT = 480
local MONKEY_AB7_PROJECTILE_EFFECT = "particles/base_attacks/ranged_tower_bad.vpcf"
local MONKEY_AB7_JUMP_TRAIL_EFFECT = "particles/units/heroes/hero_monkey_king/monkey_king_jump_trail.vpcf"
local MONKEY_AB7_CHANNEL_SOUND = "Hero_MonkeyKing.FurArmy.Channel"
local MONKEY_AB7_JUMP_SOUND = "Hero_MonkeyKing.TreeJump.Cast"
____exports.monkey_ab7 = __TS__Class()
local monkey_ab7 = ____exports.monkey_ab7
monkey_ab7.name = "monkey_ab7"
__TS__ClassExtends(monkey_ab7, MonsterAbility_CS)
function monkey_ab7.prototype.Precache(self, context)
	PrecacheResource("particle", MONKEY_AB7_PROJECTILE_EFFECT, context)
	PrecacheResource("particle", MONKEY_AB7_JUMP_TRAIL_EFFECT, context)
end
function monkey_ab7.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = MONKEY_AB7_CAST_POINT,
		castDuration = MONKEY_AB7_CAST_DURATION,
		isNotMove = true,
		castAnimation = ACT_DOTA_MK_SPRING_CAST,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return true
			end
			local targetPos = self:GetReturnPoint(caster)
			caster:SetForwardVectorWithoutInterrupt(GetDirection(nil, targetPos, caster:GetAbsOrigin()))
		end,
		OnStart = function()
			self:StartSpiralBarrage()
		end,
		OnFinish = function()
			self:FinishSpiralBarrage()
		end,
		OnInterrupt = function()
			self.shouldCastFollowUpAb4 = false
			self:StopSpiralBarrage()
		end,
	}
end
function monkey_ab7.prototype.StartSpiralBarrage(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local token = self:NextCastToken()
	self.shouldCastFollowUpAb4 = true
	local startPos = caster:GetAbsOrigin()
	local landingPos = self:GetReturnPoint(caster)
	local controlPos = Vector(
		(startPos.x + landingPos.x) * 0.5,
		(startPos.y + landingPos.y) * 0.5,
		math.max(startPos.z, landingPos.z) + MONKEY_AB7_JUMP_HEIGHT
	)
	EmitSoundOn(MONKEY_AB7_JUMP_SOUND, caster)
	self:PlayJumpTrail(caster)
	caster:Bezier2Mover({ startPos, controlPos, landingPos }, MONKEY_AB7_JUMP_DURATION, nil, true)
	self:Timer(MONKEY_AB7_JUMP_DURATION, function()
		if not self:IsCurrentCastActive(token) then
			return
		end
		FindClearSpaceForUnit(caster, landingPos, true)
		EmitSoundOn(MONKEY_AB7_CHANNEL_SOUND, caster)
		____exports.modifier_monkey_ab7_channel:applys(
			caster,
			caster,
			self,
			{ duration = MONKEY_AB7_CAST_DURATION - MONKEY_AB7_JUMP_DURATION }
		)
		self:Timer(MONKEY_AB7_JUMP_FIRE_DELAY, function()
			if not self:IsCurrentCastActive(token) then
				return
			end
			self:FireSpiralProjectiles(caster, token)
		end)
	end)
end
function monkey_ab7.prototype.StopSpiralBarrage(self)
	self:NextCastToken()
	local caster = self:GetCaster()
	if not IsValid(nil, caster) or caster:IsNull() then
		return
	end
	caster:RemoveModifierByName(____exports.modifier_monkey_ab7_channel.name)
end
function monkey_ab7.prototype.FinishSpiralBarrage(self)
	local shouldFollowUp = self.shouldCastFollowUpAb4 == true
	self.shouldCastFollowUpAb4 = false
	self:StopSpiralBarrage()
	if not shouldFollowUp then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = caster:GetMinDistanceUnit(4500)
	if target then
		caster:LockTargetForSpeed(target, 0.27, 8)
	end
	self:Timer(0.28, function()
		return self:CastFollowUpMonkeyAb4()
	end)
end
function monkey_ab7.prototype.CastFollowUpMonkeyAb4(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	if caster:IsStunned() then
		return
	end
	local ____opt_0 = caster.IsMonsterCasting
	if (____opt_0 and ____opt_0(caster)) == true then
		return
	end
	local ability = caster:FindAbilityByName("monkey_ab4")
	if not ability or ability:IsNull() then
		return
	end
	ability:EndCooldown()
	caster:CastAbilityNoTarget(ability, caster:GetPlayerOwnerID())
end
function monkey_ab7.prototype.IsCurrentCastActive(self, token)
	return token == self.castToken and IsValidAlive(nil, self:GetCaster())
end
function monkey_ab7.prototype.NextCastToken(self)
	self.castToken = (self.castToken or 0) + 1
	return self.castToken
end
function monkey_ab7.prototype.FireSpiralProjectiles(self, caster, token)
	do
		local index = 0
		while index < MONKEY_AB7_PROJECTILE_COUNT do
			local currentIndex = index
			local currentDelay = currentIndex * MONKEY_AB7_PROJECTILE_INTERVAL
			local currentAngle = currentIndex * MONKEY_AB7_SPIRAL_ANGLE_STEP
			self:Timer(currentDelay, function()
				if not self:IsCurrentCastActive(token) then
					return
				end
				self:FireProjectilePair(caster, currentAngle)
			end)
			index = index + 1
		end
	end
end
function monkey_ab7.prototype.FireProjectilePair(self, caster, angle)
	local angleOffset = RandomFloat(MONKEY_AB7_PAIR_ANGLE_OFFSET_MIN, MONKEY_AB7_PAIR_ANGLE_OFFSET_MAX)
	self:FireSingleProjectile(caster, angle - angleOffset)
	self:FireSingleProjectile(caster, angle + angleOffset)
end
function monkey_ab7.prototype.FireSingleProjectile(self, caster, angle)
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local direction = RotateVector2D(nil, Vector(1, 0, 0), angle):Normalized()
	local startPoint = origin:__add(direction:__mul(120)):__add(Vector(0, 0, MONKEY_AB7_PROJECTILE_HEIGHT))
	local targetPoint = startPoint:__add(direction:__mul(MONKEY_AB7_PROJECTILE_DISTANCE))
	caster:SetForwardVectorWithoutInterrupt(direction)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = "particles/dragon_knight_elder_dragon_fire.vpcf",
		target = targetPoint,
		start_point = startPoint,
		projectile_type = "linear",
		projectile_speed = 900,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		projectile_distance = MONKEY_AB7_PROJECTILE_DISTANCE,
		projectile_range = MONKEY_AB7_PROJECTILE_RANGE,
		on_hit = function(____, hitTarget)
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			if not IsValidAlive(nil, caster) then
				return true
			end
			caster:MonsterDamage({ victim = hitTarget, damage_rate = 15, ability = self })
			local pfx = ParticleManager:CreateParticle(
				"particles/boss/boss_001_endcap_red.vpcf",
				PATTACH_POINT_FOLLOW,
				hitTarget
			)
			ParticleManager:SetParticleControlEnt(
				pfx,
				3,
				hitTarget,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				Vector(0, 0, 0),
				true
			)
			ParticleManager:ReleaseParticleIndex(pfx)
			hitTarget:KnockBack(caster, self, { duration = 0.1, distance = 50, height = 0, stun = true })
			return false
		end,
	})
end
function monkey_ab7.prototype.GetReturnPoint(self, caster)
	local spawnPoint = caster:GetSpawnPoint()
	local ____spawnPoint_2
	if spawnPoint then
		____spawnPoint_2 = GetGroundPosition(spawnPoint, caster)
	else
		____spawnPoint_2 = GetGroundPosition(caster:GetAbsOrigin(), caster)
	end
	local groundPoint = ____spawnPoint_2
	return ResolveMonkeyBlinkPoint(nil, caster, groundPoint) or groundPoint
end
function monkey_ab7.prototype.PlayJumpTrail(self, caster)
	local jumpTrail = ParticleManager:CreateParticle(MONKEY_AB7_JUMP_TRAIL_EFFECT, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(jumpTrail, 0, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(jumpTrail)
end
monkey_ab7 = __TS__DecorateLegacy({ registerAbility(nil) }, monkey_ab7)
____exports.monkey_ab7 = monkey_ab7
____exports.modifier_monkey_ab7_channel = __TS__Class()
local modifier_monkey_ab7_channel = ____exports.modifier_monkey_ab7_channel
modifier_monkey_ab7_channel.name = "modifier_monkey_ab7_channel"
__TS__ClassExtends(modifier_monkey_ab7_channel, MonsterModifier_CS)
function modifier_monkey_ab7_channel.prototype.IsHidden(self)
	return true
end
function modifier_monkey_ab7_channel.prototype.IsPurgable(self)
	return false
end
function modifier_monkey_ab7_channel.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end
function modifier_monkey_ab7_channel.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_GENERIC_CHANNEL_1
end
function modifier_monkey_ab7_channel.prototype.GetActivityTranslationModifiers(self)
	return "mk_generic_channel"
end
function modifier_monkey_ab7_channel.prototype.GetOverrideAnimationRate(self)
	return 1
end
function modifier_monkey_ab7_channel.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
modifier_monkey_ab7_channel = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_monkey_ab7_channel)
____exports.modifier_monkey_ab7_channel = modifier_monkey_ab7_channel
return ____exports