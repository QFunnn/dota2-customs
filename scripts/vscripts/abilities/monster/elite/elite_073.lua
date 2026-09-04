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
local ____normal_042 = require("abilities.monster.normal.normal_042")
local modifier_normal_042_shield_suppress = ____normal_042.modifier_normal_042_shield_suppress
local modifier_normal_042_wound = ____normal_042.modifier_normal_042_wound
local NORMAL_042_SHIELD_SUPPRESS_DURATION = ____normal_042.SHIELD_SUPPRESS_DURATION
local NORMAL_042_WOUND_DURATION = ____normal_042.WOUND_DURATION
local CAST_RANGE = 900
local CAST_POINT = 0.45
local CAST_DURATION = 0.5
local FIELD_DURATION = 7
local FIELD_RADIUS = 600
local FIELD_RANDOM_RADIUS = 300
local FIELD_POINT_ATTEMPTS = 12
local MIN_PULL_RADIUS = 300
local DAMAGE_RADIUS = 250
local MIN_PULL_SPEED = 200
local MAX_PULL_SPEED = 300
local THINK_INTERVAL = 0.03
local DAMAGE_INTERVAL = 0.5
local DAMAGE_RATE = 5
local NIGHTMARE_PARTICLE = "particles/units/heroes/hero_bane/bane_nightmare.vpcf"
local FIENDSGRIP_GHOST_PARTICLE = "particles/units/heroes/hero_bane/bane_fiendsgrip_ghost.vpcf"
local FIENDSGRIP_PARTICLE = "particles/units/heroes/hero_bane/bane_fiends_grip.vpcf"
local SOUL_CATCHER_PARTICLE = "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_debuff.vpcf"
local CAST_SOUND = "Hero_Bane.Nightmare"
local DAMAGE_SOUND = "Hero_ShadowDemon.Soul_Catcher"
local PULL_LOOP_SOUND = "Hero_Bane.FiendsGrip"
--- 精英技能73 - 末影绊影：生成梦魇引力场，吸引敌人并伤害中心区域目标
____exports.elite_073 = __TS__Class()
local elite_073 = ____exports.elite_073
elite_073.name = "elite_073"
__TS__ClassExtends(elite_073, MonsterAbility_CS)
function elite_073.prototype.Precache(self, context)
	PrecacheResource("particle", NIGHTMARE_PARTICLE, context)
	PrecacheResource("particle", FIENDSGRIP_GHOST_PARTICLE, context)
	PrecacheResource("particle", FIENDSGRIP_PARTICLE, context)
	PrecacheResource("particle", SOUL_CATCHER_PARTICLE, context)
	PrecacheResource("soundfile", PULL_LOOP_SOUND, context)
end
function elite_073.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		canCast = function()
			local caster = self:GetCaster()
			local ____temp_0
			if IsValidAlive(nil, caster) and IsValidAlive(nil, self:FindNearestEnemy(caster)) then
				____temp_0 = UF_SUCCESS
			else
				____temp_0 = UF_FAIL_CUSTOM
			end
			return ____temp_0
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = self:FindNearestEnemy(caster)
			if IsValidAlive(nil, target) then
				self.targetPoint = self:FindFieldPointNearTarget(caster, target)
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
		end,
		OnInterrupt = function()
			self.targetPoint = nil
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = self:FindNearestEnemy(caster)
			local ____self_targetPoint_2 = self.targetPoint
			if ____self_targetPoint_2 == nil then
				local ____IsValidAlive_result_1
				if IsValidAlive(nil, target) then
					____IsValidAlive_result_1 = self:FindFieldPointNearTarget(caster, target)
				else
					____IsValidAlive_result_1 = nil
				end
				____self_targetPoint_2 = ____IsValidAlive_result_1
			end
			local point = ____self_targetPoint_2
			self.targetPoint = nil
			if not point then
				return
			end
			local origin = GetGroundPosition(point, caster)
			EmitSoundOnLocationWithCaster(origin, CAST_SOUND, caster)
			CreateModifierThinker(
				caster,
				self,
				"modifier_elite_073_shadow_tether_field",
				{ duration = FIELD_DURATION },
				origin,
				caster:GetTeamNumber(),
				false
			)
		end,
	}
end
function elite_073.prototype.FindNearestEnemy(self, caster)
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
function elite_073.prototype.FindFieldPointNearTarget(self, caster, target)
	local targetOrigin = GetGroundPosition(target:GetAbsOrigin(), caster)
	do
		local i = 0
		while i < FIELD_POINT_ATTEMPTS do
			local candidate = targetOrigin:__add(RandomVector(RandomFloat(0, FIELD_RANDOM_RADIUS)))
			local point = GetGroundPosition(candidate, caster)
			if IsGridNavDisplacementWalkable(nil, point) then
				return point
			end
			i = i + 1
		end
	end
	return targetOrigin
end
function elite_073.prototype.DamageCenter(self, origin)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		DAMAGE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	if #enemies > 0 then
		EmitSoundOnLocationWithCaster(origin, DAMAGE_SOUND, caster)
	end
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue19
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			self:ApplyNormal042Debuffs(caster, enemy)
		end
		::__continue19::
	end
end
function elite_073.prototype.ApplyNormal042Debuffs(self, caster, target)
	if not IsValidAlive(nil, target) then
		return
	end
	modifier_normal_042_wound:applys(target, caster, self, { duration = NORMAL_042_WOUND_DURATION })
	local ____this_4
	____this_4 = target
	local ____opt_3 = ____this_4.IsRealHero
	if ____opt_3 and ____opt_3(____this_4) then
		modifier_normal_042_shield_suppress:applys(
			target,
			caster,
			self,
			{ duration = NORMAL_042_SHIELD_SUPPRESS_DURATION }
		)
	end
end
elite_073 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_073)
____exports.elite_073 = elite_073
local modifier_elite_073_shadow_tether_field = __TS__Class()
modifier_elite_073_shadow_tether_field.name = "modifier_elite_073_shadow_tether_field"
__TS__ClassExtends(modifier_elite_073_shadow_tether_field, MonsterModifier_CS)
function modifier_elite_073_shadow_tether_field.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.origin = Vector(0, 0, 0)
	self.damageElapsed = 0
	self.loopSoundStarted = false
end
function modifier_elite_073_shadow_tether_field.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_PROVIDES_VISION] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end
function modifier_elite_073_shadow_tether_field.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	self.origin = GetGroundPosition(parent:GetAbsOrigin(), caster)
	parent:SetAbsOrigin(self.origin)
	self:CreateFieldParticles(parent)
	self:StartLoopSound(parent)
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_elite_073_shadow_tether_field.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability or ability:IsNull() then
		self:Destroy()
		return
	end
	self:PullEnemies(caster)
	self.damageElapsed = self.damageElapsed + THINK_INTERVAL
	if self.damageElapsed >= DAMAGE_INTERVAL then
		self.damageElapsed = 0
		ability:DamageCenter(self.origin)
	end
end
function modifier_elite_073_shadow_tether_field.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	self:DestroyParticle(self.nightmareParticle)
	self:DestroyParticle(self.ghostParticle)
	self:DestroyParticle(self.gripParticle)
	self:DestroyParticle(self.soulCatcherParticle)
	self.nightmareParticle = nil
	self.ghostParticle = nil
	self.gripParticle = nil
	self.soulCatcherParticle = nil
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		self:StopLoopSound(parent)
		parent:RemoveSelf()
	end
end
function modifier_elite_073_shadow_tether_field.prototype.PullEnemies(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		self.origin,
		nil,
		FIELD_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue38
			end
			local enemyOrigin = enemy:GetAbsOrigin()
			local distance = GetDistance(nil, enemyOrigin, self.origin)
			if distance <= MIN_PULL_RADIUS then
				goto __continue38
			end
			local direction = GetDirection(nil, self.origin, enemyOrigin)
			local pullSpeed = self:GetPullSpeed(distance)
			local step = math.min(pullSpeed * THINK_INTERVAL, distance - MIN_PULL_RADIUS)
			local nextPoint = enemyOrigin:__add(direction:__mul(step))
			local groundPoint = GetGroundPosition(nextPoint, enemy)
			if not IsGridNavDisplacementWalkable(nil, groundPoint) then
				goto __continue38
			end
			enemy:SetAbsOrigin(groundPoint)
			ResolveNPCPositions(groundPoint, enemy:GetHullRadius())
		end
		::__continue38::
	end
end
function modifier_elite_073_shadow_tether_field.prototype.GetPullSpeed(self, distance)
	local clamped = math.max(MIN_PULL_RADIUS, math.min(FIELD_RADIUS, distance))
	local progress = (clamped - MIN_PULL_RADIUS) / (FIELD_RADIUS - MIN_PULL_RADIUS)
	return MIN_PULL_SPEED + (MAX_PULL_SPEED - MIN_PULL_SPEED) * progress
end
function modifier_elite_073_shadow_tether_field.prototype.CreateFieldParticles(self, parent)
	self.nightmareParticle = ParticleManager:CreateParticle(NIGHTMARE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.nightmareParticle, 0, self.origin)
	self.ghostParticle = ParticleManager:CreateParticle(FIENDSGRIP_GHOST_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.ghostParticle, 0, self.origin)
	self.gripParticle = ParticleManager:CreateParticle(FIENDSGRIP_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.gripParticle, 0, self.origin)
	self.soulCatcherParticle = ParticleManager:CreateParticle(SOUL_CATCHER_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.soulCatcherParticle, 0, self.origin)
end
function modifier_elite_073_shadow_tether_field.prototype.DestroyParticle(self, particleId)
	if particleId == nil then
		return
	end
	ParticleManager:DestroyParticle(particleId, false)
	ParticleManager:ReleaseParticleIndex(particleId)
end
function modifier_elite_073_shadow_tether_field.prototype.StartLoopSound(self, parent)
	if self.loopSoundStarted then
		return
	end
	self.loopSoundStarted = true
	EmitSoundOn(PULL_LOOP_SOUND, parent)
end
function modifier_elite_073_shadow_tether_field.prototype.StopLoopSound(self, parent)
	if not self.loopSoundStarted then
		return
	end
	StopSoundOn(PULL_LOOP_SOUND, parent)
	self.loopSoundStarted = false
end
function modifier_elite_073_shadow_tether_field.prototype.IsHidden(self)
	return true
end
function modifier_elite_073_shadow_tether_field.prototype.IsPurgable(self)
	return false
end
modifier_elite_073_shadow_tether_field = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_073_shadow_tether_field") },
	modifier_elite_073_shadow_tether_field
)
return ____exports