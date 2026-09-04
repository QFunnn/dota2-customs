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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local CAST_RANGE = 1600
local CAST_POINT = 1.2
local CAST_DURATION = 1.2
local CAST_COOLDOWN = 5
local DASH_DISTANCE = 600
local DASH_DURATION = 0.35
local DASH_HIT_RADIUS = 140
local WARNING_WIDTH = DASH_HIT_RADIUS
local DAMAGE_RATE = 20
local KNOCKBACK_DISTANCE = 280
local KNOCKBACK_DURATION = 0.35
local STUN_DURATION = 1
local FINAL_CONE_RANGE = 300
local FINAL_CONE_HALF_ANGLE = 80
local FINAL_KNOCKUP_DURATION = 0.4
local FINAL_KNOCKUP_DISTANCE = 100
local FINAL_KNOCKUP_HEIGHT = 350
local FINAL_STUN_DURATION = 1
local pfx5 = "particles/status_fx/status_effect_void_spirit_pulse_buff.vpcf"
local pfx10 = "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_debuff.vpcf"
local PUNCH_PARTICLE = "particles/bb/pun_dark_seer_attack_normal_punch.vpcf"
local PUNCH_HIT_PARTICLE = "particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica_replicate.vpcf"
local PUNCH_SOUND = "Hero_Dark_Seer.NormalPunch.Lv1"
local PUNCH_HIT_SOUND = "Hero_Dark_Seer.Surge"
--- 精英技能332：蓄力后向前冲刺出拳，对路径上的敌人造成伤害、击退和眩晕。
____exports.elite_332 = __TS__Class()
local elite_332 = ____exports.elite_332
elite_332.name = "elite_332"
__TS__ClassExtends(elite_332, MonsterAbility_CS)
function elite_332.prototype.Precache(self, context)
	PrecacheResource("particle", PUNCH_PARTICLE, context)
	PrecacheResource("particle", PUNCH_HIT_PARTICLE, context)
end
function elite_332.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		animationPlaybackRate = 1.3,
		cooldown = CAST_COOLDOWN,
		isNotMove = true,
		OnPhaseStart = function()
			return self:PreparePunch()
		end,
		OnStart = function()
			return self:ReleasePunch()
		end,
	}
end
function elite_332.prototype.PreparePunch(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = self:GetCaster():GetMinDistanceUnit(CAST_RANGE)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, CAST_POINT, 5)
	end
	local origin = caster:GetAbsOrigin()
	local endPosition = origin:__add(caster:GetForwardVector():__mul(DASH_DISTANCE))
	self:WarningEffect(origin, endPosition, CAST_POINT, {
		startWidth = WARNING_WIDTH,
		endWidth = WARNING_WIDTH,
		getDirection = function()
			return caster:GetForwardVector()
		end,
		follow = true,
	})
	self:Timer(0.85, function()
		caster:Mover(origin:__sub(caster:GetForwardVector():__mul(100)), 0.3, nil, true, true)
		____exports.modifier_elite_332_material_change:applys(caster, caster, nil, { duration = 0.29 })
	end)
end
function elite_332.prototype.ReleasePunch(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local direction = self:FlatDirection(caster:GetForwardVector())
	local dashStart = caster:GetAbsOrigin()
	local dashEnd = dashStart:__add(direction:__mul(DASH_DISTANCE))
	local hitTargets = __TS__New(Set)
	caster:SetForwardVectorWithoutInterrupt(direction)
	caster:SetAnimation("attack_normal_punch_2022")
	____exports.modifier_elite_332_material_change:applys(caster, caster, nil, { duration = 0.3 })
	self:Timer(0.1, function()
		EmitSoundOn(PUNCH_SOUND, caster)
		ScreenShake(caster:GetAbsOrigin(), 12, 12, 0.2, 1200, 0, true)
		self:PlayPunchEffect(caster)
		self:HitDashEnemies(caster, dashStart, dashStart, direction, hitTargets)
		caster:Mover(dashEnd, DASH_DURATION, function(____, position)
			if not IsValidAlive(nil, caster) then
				return true
			end
			self:HitDashEnemies(caster, position, dashStart, direction, hitTargets)
		end)
		self:Timer(DASH_DURATION, function()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:KnockUpFinalCone(caster, direction)
		end)
	end)
end
function elite_332.prototype.HitDashEnemies(self, caster, position, dashStart, direction, hitTargets)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		position,
		nil,
		DASH_HIT_RADIUS,
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
			local enemyIndex = enemy:entindex()
			if hitTargets:has(enemyIndex) then
				goto __continue19
			end
			local offset = enemy:GetAbsOrigin():__sub(dashStart)
			local forwardDistance = offset.x * direction.x + offset.y * direction.y
			if forwardDistance < 0 or forwardDistance > DASH_DISTANCE then
				goto __continue19
			end
			local distanceSquared = offset.x * offset.x + offset.y * offset.y
			local lateralDistanceSquared = math.max(distanceSquared - forwardDistance * forwardDistance, 0)
			if lateralDistanceSquared > DASH_HIT_RADIUS * DASH_HIT_RADIUS then
				goto __continue19
			end
			hitTargets:add(enemyIndex)
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = DAMAGE_RATE,
				ability = self,
				effectName = PUNCH_HIT_PARTICLE,
			})
			EmitSoundOn(PUNCH_HIT_SOUND, enemy)
			enemy:KnockBack(caster, self, {
				duration = KNOCKBACK_DURATION,
				distance = KNOCKBACK_DISTANCE,
				direction = direction,
				destroyTreesType = "onDestroy",
				stun = true,
				stunDuration = STUN_DURATION,
			})
		end
		::__continue19::
	end
end
function elite_332.prototype.KnockUpFinalCone(self, caster, direction)
	local origin = caster:GetAbsOrigin()
	local minDot = math.cos(math.rad(FINAL_CONE_HALF_ANGLE))
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		FINAL_CONE_RANGE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	ScreenShake(origin, 12, 12, 0.2, 1200, 0, true)
	self:PlayPunchEffect(caster)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue26
			end
			local offset = enemy:GetAbsOrigin():__sub(origin)
			local distance = offset:Length2D()
			local ____temp_0
			if distance > 0.01 then
				____temp_0 = Vector(offset.x / distance, offset.y / distance, 0)
			else
				____temp_0 = direction
			end
			local enemyDirection = ____temp_0
			local dot = direction.x * enemyDirection.x + direction.y * enemyDirection.y
			if dot < minDot then
				goto __continue26
			end
			self:PlayFinalHitEffect(enemy, direction)
			EmitSoundOn(PUNCH_HIT_SOUND, enemy)
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = DAMAGE_RATE,
				ability = self,
				effectName = PUNCH_HIT_PARTICLE,
			})
			enemy:KnockBack(caster, self, {
				duration = FINAL_KNOCKUP_DURATION,
				distance = FINAL_KNOCKUP_DISTANCE,
				height = FINAL_KNOCKUP_HEIGHT,
				direction = direction,
				destroyTreesType = "onDestroy",
				stun = true,
				stunDuration = FINAL_STUN_DURATION,
			})
		end
		::__continue26::
	end
end
function elite_332.prototype.PlayFinalHitEffect(self, target, direction)
	if not IsValidAlive(nil, target) then
		return
	end
	local origin = target:GetAbsOrigin()
	local particle = ParticleManager:CreateParticle(PUNCH_HIT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControlTransformForward(particle, 1, origin, direction)
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_332.prototype.PlayPunchEffect(self, caster)
	local origin = caster:GetAbsOrigin()
	local forward = self:FlatDirection(caster:GetForwardVector())
	local particle = ParticleManager:CreateParticle(PUNCH_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControlForward(particle, 0, forward)
	ParticleManager:SetParticleControlTransformForward(particle, 0, origin, forward)
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_332.prototype.FindTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
function elite_332.prototype.FlatDirection(self, direction)
	local flatDirection = Vector(direction.x, direction.y, 0)
	local ____temp_1
	if flatDirection:Length2D() > 0.01 then
		____temp_1 = flatDirection:Normalized()
	else
		____temp_1 = Vector(1, 0, 0)
	end
	return ____temp_1
end
elite_332 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_332)
____exports.elite_332 = elite_332
____exports.modifier_elite_332_material_change = __TS__Class()
local modifier_elite_332_material_change = ____exports.modifier_elite_332_material_change
modifier_elite_332_material_change.name = "modifier_elite_332_material_change"
__TS__ClassExtends(modifier_elite_332_material_change, BaseModifier_CS)
function modifier_elite_332_material_change.GetLocalizationCN(self)
	return { name = "材质变色", description = "材质变色" }
end
function modifier_elite_332_material_change.prototype.GetEffectName(self)
	return pfx10
end
function modifier_elite_332_material_change.prototype.GetStatusEffectName(self)
	return pfx5
end
modifier_elite_332_material_change = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_332_material_change)
____exports.modifier_elite_332_material_change = modifier_elite_332_material_change
return ____exports