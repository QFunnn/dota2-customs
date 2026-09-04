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
local BaseModifier = ____dota_ts_adapter.BaseModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
--- 施法距离（站桩炮台，给大射程补偿固定性）
local CAST_RANGE = 1000
--- 索敌范围
local AGGRO_RANGE = 1200
--- 蓄力前摇
local CAST_POINT = 1.2
--- 释放锁定（甩弹动作）
local CAST_DURATION = 0.6
--- OnStart 后到冰弹脱手的延迟（对齐攻击动作甩臂）
local FIRE_DELAY = 0.35
--- 冰弹飞行速度
local PROJECTILE_SPEED = 900
--- 落地冰爆半径
local IMPACT_RADIUS = 220
--- 落地伤害系数（damage_rate × 小鬼攻击力35）
local DAMAGE_RATE = 2
--- 预警圈总时长：蓄力+脱手延迟+典型飞行时间（圈收满变红 ≈ 冰弹落地）
local WARN_DURATION = 2.4
--- 冰弹飞行粒子（冰女普攻弹道）
local PROJECTILE_PARTICLE = "particles/units/heroes/hero_crystalmaiden/maiden_base_attack.vpcf"
--- 落地冰爆粒子（冰女新星）
local IMPACT_PARTICLE = "particles/units/heroes/hero_crystalmaiden/maiden_crystal_nova.vpcf"
--- 冰爆音效（随 CM 音效库全局缓存）
local IMPACT_SOUND = "Hero_Crystal.CrystalNova"
--- 冰弹出手点：本地偏移（小鬼模型挂点未验证，走兜底=身前上方）
local LAUNCH_FORWARD = 40
local LAUNCH_HEIGHT = 90
____exports.elite_323 = __TS__Class()
local elite_323 = ____exports.elite_323
elite_323.name = "elite_323"
__TS__ClassExtends(elite_323, MonsterAbility_CS)
function elite_323.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_323_ai"
end
function elite_323.prototype.Precache(self, context)
	PrecacheResource("particle", PROJECTILE_PARTICLE, context)
	PrecacheResource("particle", IMPACT_PARTICLE, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_crystalmaiden.vsndevts", context)
end
function elite_323.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_IDLE,
		castProgressBarColor = "blue",
		castColor = Vector(120, 200, 255),
		OnPhaseStart = function()
			return self:onChargeStart()
		end,
		OnStart = function()
			return self:onFire()
		end,
		OnInterrupt = function()
			return self:resetLock()
		end,
		OnFinish = function()
			return self:resetLock()
		end,
	}
end
function elite_323.prototype.resetLock(self)
	self._lockedTarget = nil
	self._lockedLandPos = nil
end
function elite_323.prototype.onChargeStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = self:GetMinDistanceUnit(AGGRO_RANGE)
	local ____IsValidAlive_result_0
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_0 = target
	else
		____IsValidAlive_result_0 = nil
	end
	self._lockedTarget = ____IsValidAlive_result_0
	if self._lockedTarget then
		caster:LockTargetForSpeed(self._lockedTarget, CAST_POINT)
	end
	local ____table__lockedTarget_1
	if self._lockedTarget then
		____table__lockedTarget_1 = self._lockedTarget:GetAbsOrigin()
	else
		____table__lockedTarget_1 = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(400))
	end
	local initialCenter = ____table__lockedTarget_1
	self:WarningRingEffect(initialCenter, IMPACT_RADIUS, WARN_DURATION, {
		getCenter = function()
			if self._lockedLandPos ~= nil then
				return self._lockedLandPos
			end
			local t = self._lockedTarget
			if t and IsValidAlive(nil, t) then
				return t:GetAbsOrigin()
			end
			return nil
		end,
	})
end
function elite_323.prototype.onFire(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local t = self._lockedTarget
	local fallback = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(400))
	local ____temp_2
	if t and IsValidAlive(nil, t) then
		____temp_2 = t:GetAbsOrigin()
	else
		____temp_2 = fallback
	end
	local land = ____temp_2
	self._lockedLandPos = GetGroundPosition(land, nil)
	caster:StartGesture(ACT_DOTA_ATTACK)
	self:Timer(FIRE_DELAY, function()
		return self:launchProjectile()
	end)
end
function elite_323.prototype.launchProjectile(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local landPos = self._lockedLandPos
	if not landPos then
		return
	end
	local start =
		caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(LAUNCH_FORWARD)):__add(Vector(0, 0, LAUNCH_HEIGHT))
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = PROJECTILE_PARTICLE,
		projectile_type = "collideground",
		projectile_speed = PROJECTILE_SPEED,
		start_point = start,
		target = landPos,
		on_hit = function(____, _hitTarget, location)
			if not IsServer() then
				return true
			end
			local c = self:GetCaster()
			if not IsValidAlive(nil, c) then
				return true
			end
			local gz = GetGroundHeight(location, c) or location.z
			self:onImpact(c, Vector(location.x, location.y, gz))
			return true
		end,
	})
end
function elite_323.prototype.onImpact(self, caster, center)
	if not IsValidAlive(nil, caster) then
		return
	end
	local pfx = ParticleManager:CreateParticle(IMPACT_PARTICLE, PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 0, center)
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(center, IMPACT_SOUND, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		IMPACT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue27
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
		end
		::__continue27::
	end
end
elite_323 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_323)
____exports.elite_323 = elite_323
--- 站桩炮台 AI：不移动——只转向 + 技能就绪即施放。
-- （单位本体 NO_ATTACK + 移动能力 NONE，无需 DISARMED/走位逻辑）
local modifier_elite_323_ai = __TS__Class()
modifier_elite_323_ai.name = "modifier_elite_323_ai"
__TS__ClassExtends(modifier_elite_323_ai, BaseModifier)
function modifier_elite_323_ai.prototype.IsHidden(self)
	return true
end
function modifier_elite_323_ai.prototype.IsPurgable(self)
	return false
end
function modifier_elite_323_ai.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.25)
end
function modifier_elite_323_ai.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local ____temp_5 = parent:IsStunned()
	if not ____temp_5 then
		local ____opt_3 = parent.IsMonsterCasting
		____temp_5 = (____opt_3 and ____opt_3(parent)) == true
	end
	if ____temp_5 then
		return
	end
	local target = parent:GetMinDistanceUnit(AGGRO_RANGE)
	if not IsValidAlive(nil, target) then
		return
	end
	if not IsValidAlive(nil, target) then
		return
	end
	local dir = target:GetAbsOrigin():__sub(parent:GetAbsOrigin()):Normalized()
	parent:SetForwardVector(dir)
	local ability = parent:FindAbilityByName("elite_323")
	if not ability or ability:IsNull() or not ability:IsCooldownReady() then
		return
	end
	local dist = target:GetAbsOrigin():__sub(parent:GetAbsOrigin()):Length2D()
	if dist > CAST_RANGE then
		return
	end
	parent:CastAbilityNoTarget(ability, parent:GetPlayerOwnerID())
end
modifier_elite_323_ai = __TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_323_ai") }, modifier_elite_323_ai)
return ____exports