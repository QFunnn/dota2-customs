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
local __TS__Delete = ____lualib.__TS__Delete
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____boss_002 = require("abilities.monster.boss.boss_002")
local modifier_boss_002_dash = ____boss_002.modifier_boss_002_dash
local modifier_boss_002_dash_self = ____boss_002.modifier_boss_002_dash_self
local modifier_boss_002_dash_victim = ____boss_002.modifier_boss_002_dash_victim
local PROJECTILE_EFFECT = "particles/boss/boss_006.vpcf"
local THINKER_AMBIENT_EFFECT = "particles/boss/cyclone_winterrewardline_2025.vpcf"
local PROJECTILE_HIT_EFFECT = "particles/units/heroes/hero_stormspirit/stormspirit_overload_discharge.vpcf"
local THINKER_SKY_EFFECT = "particles/boss/sky/razor_ambient_main.vpcf"
local AURA_EFFECT = "particles/boss/sky/disruptor_2022_immortal_static_storm.vpcf"
--- 层数演出：CP0 原点，CP1 的 Y 为堆栈数量（参考 drow_003）
local EXECUTE_STACK_COUNTER_PFX = "particles/units/heroes/hero_drow/drow_hypothermia_counter_stack.vpcf"
local HIT_KNOCKBACK_DURATION = 0.5
local HIT_KNOCKBACK_DISTANCE = 300
local HIT_KNOCKBACK_HEIGHT = 80
local AURA_OUTER_RADIUS = 2300
local AURA_INNER_SAFE_RADIUS = 1200
local AURA_DAMAGE_RATE = 10
local EXECUTE_STACK_DURATION = 12
local EXECUTE_INITIAL_STACKS = 3
local EXECUTE_PRE_APPLY_RADIUS = 2000
local EXECUTE_DROP_DURATION = 0.15
local EXECUTE_CAPTURE_DELAY = 0.12
local PRE_CAST_DASH_DURATION = 0.5
local BOSS_006_EXECUTE_DAMAGE_RATE = 3
local BOSS_006_START_SOUND_1 = "Hero_Razor.Storm.Cast"
local BOSS_006_START_SOUND_2 = "Hero_Disruptor.StaticStorm"
local BOSS_006_AURA_TICK_SOUND = "Hero_SkywrathMage.MysticFlare.Target"
local BOSS_006_PROJECTILE_CAST_SOUND = "Hero_SkywrathMage.ArcaneBolt.Cast"
local BOSS_006_PROJECTILE_IMPACT_SOUND = "Hero_SkywrathMage.ArcaneBolt.Impact"
local BOSS_006_EXECUTE_SOUND = "Hero_Leshrac.Split_Earth.Tormented"
--- Boss6：自身上浮 Buff，每 0.5s 向每位敌方英雄侧面（左/右+后偏 0~30° 随机）发射弹道，Thinker 管特效、投射物管碰撞。
____exports.boss_006 = __TS__Class()
local boss_006 = ____exports.boss_006
boss_006.name = "boss_006"
__TS__ClassExtends(boss_006, MonsterAbility_CS)
function boss_006.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.boltThinkers = {}
	self.hasExecutedInThisCast = false
	self.buffDuration = 8
	self.liftDuration = 0.5
	self.liftHeight = 2000
	self.projectileFireInterval = 0.5
	self.projectileOffsetRight = 1500
	self.backOffsetMaxDeg = 30
	self.projectileDistance = 3000
	self.projectileSpeed = 1000
	self.projectileRange = 60
end
function boss_006.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/boss/boss_006ambient.vpcf", context)
	PrecacheResource("particle", "particles/boss/boss_006ambient_container.vpcf", context)
	PrecacheResource("particle", PROJECTILE_EFFECT, context)
	PrecacheResource("particle", THINKER_AMBIENT_EFFECT, context)
	PrecacheResource("particle", PROJECTILE_HIT_EFFECT, context)
	PrecacheResource("particle", THINKER_SKY_EFFECT, context)
	PrecacheResource("particle", AURA_EFFECT, context)
	PrecacheResource("particle", EXECUTE_STACK_COUNTER_PFX, context)
end
function boss_006.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_POINT,
		castPoint = 1,
		castDuration = self.buffDuration + self.liftDuration,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		animationPlaybackRate = 0.5,
		OnPhaseStart = function()
			if not IsServer() then
				return
			end
			local caster = self:GetCaster()
			local spawnPoint = caster:GetSpawnPoint()
			if not spawnPoint then
				return
			end
			local currentPos = caster:GetAbsOrigin()
			local control = (currentPos + spawnPoint) * 0.5
			caster:Bezier2Mover({ currentPos, control, spawnPoint }, PRE_CAST_DASH_DURATION, nil, true)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self.hasExecutedInThisCast = false
			self.executingTarget = nil
			caster:AddNewModifier(caster, self, "modifier_boss_006_buff", { duration = self.buffDuration })
		end,
	}
end
function boss_006.prototype.getBuffDuration(self)
	return self.buffDuration
end
function boss_006.prototype.getLiftDuration(self)
	return self.liftDuration
end
function boss_006.prototype.getProjectileFireInterval(self)
	return self.projectileFireInterval
end
function boss_006.prototype.getLiftHeight(self)
	return self.liftHeight
end
function boss_006.prototype.getProjectileOffsetRight(self)
	return self.projectileOffsetRight
end
function boss_006.prototype.getProjectileDistance(self)
	return self.projectileDistance
end
function boss_006.prototype.getProjectileSpeed(self)
	return self.projectileSpeed
end
function boss_006.prototype.getProjectileRange(self)
	return self.projectileRange
end
function boss_006.prototype.getProjectileEffect(self)
	return PROJECTILE_EFFECT
end
function boss_006.prototype.getThinkerAmbientEffect(self)
	return THINKER_AMBIENT_EFFECT
end
function boss_006.prototype.getProjectileHitEffect(self)
	return PROJECTILE_HIT_EFFECT
end
function boss_006.prototype.invalidateActiveProjectiles(self)
	if not IsServer() then
		return
	end
	for thinkerId in pairs(self.boltThinkers) do
		local thinker = self.boltThinkers[thinkerId]
		if thinker and IsValid(nil, thinker) and not thinker:IsNull() then
			thinker:RemoveSelf()
		end
		__TS__Delete(self.boltThinkers, thinkerId)
	end
end
function boss_006.prototype.addExecuteStack(self, target, caster)
	if not IsValidAlive(nil, target) or not IsValidAlive(nil, caster) then
		return -1
	end
	local stackModifier = ____exports.modifier_boss_006_execute_stack:find_on(target)
	if not stackModifier then
		return -1
	end
	local next = math.max(0, stackModifier:GetStackCount() - 1)
	stackModifier:SetStackCount(next)
	return next
end
function boss_006.prototype.preApplyExecuteStacks(self, caster, center)
	if not IsServer() or not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		EXECUTE_PRE_APPLY_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, u in ipairs(enemies) do
		do
			if not IsValidAlive(nil, u) then
				goto __continue30
			end
			if ____exports.modifier_boss_006_execute_stack:find_on(u) then
				goto __continue30
			end
			____exports.modifier_boss_006_execute_stack:applys(
				u,
				caster,
				self,
				{ duration = EXECUTE_STACK_DURATION, stacks = EXECUTE_INITIAL_STACKS }
			)
		end
		::__continue30::
	end
end
function boss_006.prototype.startExecuteFromSky(self, target)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	if self.hasExecutedInThisCast then
		return
	end
	if modifier_boss_002_dash_victim:find_on(target) then
		return
	end
	self.hasExecutedInThisCast = true
	self.executingTarget = target
	EmitSoundOn(BOSS_006_EXECUTE_SOUND, target)
	self:invalidateActiveProjectiles()
	self:DestroyDuration()
	____exports.modifier_boss_006_execute_stack:remove(target)
	local skyBuff = ____exports.modifier_boss_006_buff:find_on(caster)
	if skyBuff ~= nil then
		skyBuff:StopForExecution()
	end
	local startPos = caster:GetAbsOrigin()
	local targetPos = target:GetAbsOrigin()
	local dropDir = GetDirection(nil, targetPos, startPos)
	caster:SetForwardVector(dropDir)
	local landingPos = GetGroundPosition(targetPos - dropDir * 120, caster)
	modifier_boss_002_dash:remove(caster)
	modifier_boss_002_dash_self:remove(caster)
	modifier_boss_002_dash:applys(caster, caster, self, { duration = EXECUTE_DROP_DURATION })
	caster:Mover(landingPos, EXECUTE_DROP_DURATION, nil, true)
	self:Timer(EXECUTE_DROP_DURATION + 0.03, function()
		if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
			self.executingTarget = nil
			return
		end
		caster:SetForwardVector(GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin()))
		self._caster:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 2)
		self:Timer(EXECUTE_CAPTURE_DELAY, function()
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
				self.executingTarget = nil
				return
			end
			modifier_boss_002_dash_victim:applys(
				target,
				caster,
				self,
				{ duration = 3.5, execute_damage_rate = BOSS_006_EXECUTE_DAMAGE_RATE }
			)
			self:Timer(0.6, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				modifier_boss_002_dash_self:applys(caster, caster, self, { duration = 3 })
				self:Timer(3.2, function()
					if not IsValid(nil, caster) or caster:IsNull() then
						return
					end
					modifier_boss_002_dash_self:remove(caster)
					modifier_boss_002_dash:remove(caster)
				end)
			end)
		end)
		self:Timer(4.2, function()
			if self.executingTarget == target then
				self.executingTarget = nil
			end
		end)
	end)
end
function boss_006.prototype.OnProjectileHit_ExtraData(self, target, _location, extraData)
	local caster = self:GetCaster()
	if self.hasExecutedInThisCast then
		local thinkerId = extraData and extraData.__thinker_id
		if thinkerId ~= nil then
			local thinker = self.boltThinkers[thinkerId]
			if thinker and IsValid(nil, thinker) and not thinker:IsNull() then
				thinker:RemoveSelf()
			end
			__TS__Delete(self.boltThinkers, thinkerId)
		end
		return false
	end
	local hitPos
	if _location then
		local groundZ = GetGroundHeight(_location, caster)
		local ____location_x_5 = _location.x
		local ____location_y_6 = _location.y
		local ____temp_4
		if groundZ ~= nil then
			____temp_4 = groundZ
		else
			____temp_4 = _location.z
		end
		hitPos = Vector(____location_x_5, ____location_y_6, ____temp_4)
	end
	if not target then
		local thinkerId = extraData and extraData.__thinker_id
		if thinkerId ~= nil then
			local t = self.boltThinkers[thinkerId]
			if t and IsValid(nil, t) then
				t:RemoveSelf()
			end
			__TS__Delete(self.boltThinkers, thinkerId)
		end
	end
	if hitPos then
		local hitFx = ParticleManager:CreateParticle(self:getProjectileHitEffect(), PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(hitFx, 0, hitPos)
		ParticleManager:ReleaseParticleIndex(hitFx)
	end
	if IsValidAlive(nil, target) and IsValidAlive(nil, caster) then
		EmitSoundOn(BOSS_006_PROJECTILE_IMPACT_SOUND, target)
		local remainStacks = self:addExecuteStack(target, caster)
		if remainStacks == 0 then
			self:startExecuteFromSky(target)
			return false
		end
		if hitPos then
			local to = target:GetAbsOrigin() - hitPos
			local len = math.sqrt(to.x * to.x + to.y * to.y) or 1
			local knockDir = Vector(to.x / len, to.y / len, 0)
			target:KnockBack(caster, self, {
				duration = HIT_KNOCKBACK_DURATION,
				distance = HIT_KNOCKBACK_DISTANCE,
				height = HIT_KNOCKBACK_HEIGHT,
				direction = knockDir,
				heightType = "parabola",
				destroyTreesType = "onDestroy",
				particleName = "",
				removeOnDeath = true,
			})
		end
		Damage:ApplyDamage({
			victim = target,
			attacker = caster,
			damage = self:GetAllAttackDamage(),
			damage_type = 2,
			ability = self,
		})
		return false
	end
	return false
end
function boss_006.prototype.fireProjectilesAtEnemyHeroes(self, caster)
	if not IsServer() or not IsValidAlive(nil, caster) then
		return
	end
	if self.hasExecutedInThisCast then
		return
	end
	local heroes = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		1500,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local travelTime = self.projectileDistance / self.projectileSpeed
	local function velocity(____, v)
		return v * self.projectileSpeed
	end
	for ____, hero in ipairs(heroes) do
		do
			if not IsValidAlive(nil, hero) then
				goto __continue65
			end
			local heroPos = hero:GetAbsOrigin()
			local forward = Vector(hero:GetForwardVector().x, hero:GetForwardVector().y, 0):Normalized()
			if forward:Length2D() < 0.01 then
				forward.x = 1
				forward.y = 0
			end
			local directionType = RandomInt(0, 2)
			local rightDir = RotateVector2D(nil, forward, -90)
			local leftDir = RotateVector2D(nil, forward, 90)
			local backOffsetDeg = math.random() * self.backOffsetMaxDeg
			local finalDir = forward
			if directionType == 0 then
				finalDir = RotateVector2D(nil, rightDir, backOffsetDeg)
			elseif directionType == 1 then
				finalDir = RotateVector2D(nil, leftDir, -backOffsetDeg)
			end
			if finalDir:Length2D() < 0.01 then
				finalDir.x = 1
				finalDir.y = 0
			end
			local startPoint = heroPos + finalDir * self.projectileOffsetRight
			startPoint.z = GetGroundHeight(startPoint, hero) or heroPos.z
			local dir = GetDirection(nil, heroPos, startPoint)
			local thinkerId = DoUniqueString("bolt")
			local thinker = CreateModifierThinker(
				caster,
				self,
				"modifier_boss_006_bolt_thinker",
				{ duration = travelTime, dir_x = dir.x, dir_y = dir.y, dir_z = dir.z },
				startPoint,
				caster:GetTeamNumber(),
				false
			)
			self.boltThinkers[thinkerId] = thinker
			EmitSoundOn(BOSS_006_PROJECTILE_CAST_SOUND, caster)
			ProjectileManager:CreateLinearProjectile({
				EffectName = self:getProjectileEffect(),
				Ability = self,
				vVelocity = velocity(nil, dir),
				Source = caster,
				fDistance = self.projectileDistance,
				iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
				iUnitTargetType = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
				iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
				fStartRadius = self.projectileRange,
				fEndRadius = self.projectileRange,
				fExpireTime = GameRules:GetGameTime() + 10,
				vSpawnOrigin = startPoint,
				ExtraData = { __thinker_id = thinkerId },
			})
			break
		end
		::__continue65::
	end
end
boss_006 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_006)
____exports.boss_006 = boss_006
--- Buff：前 0.5s 抬升，之后每 0.5s 发射弹道，结束落回原位
____exports.modifier_boss_006_buff = __TS__Class()
local modifier_boss_006_buff = ____exports.modifier_boss_006_buff
modifier_boss_006_buff.name = "modifier_boss_006_buff"
__TS__ClassExtends(modifier_boss_006_buff, MonsterModifier_CS)
function modifier_boss_006_buff.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.nextFireTime = 0
	self.lastAuraDamageTime = 0
	self.skipRestorePosition = false
	self.hasPreAppliedExecuteStacks = false
end
function modifier_boss_006_buff.prototype.OnCreated(self, _kv)
	if not IsServer() then
		return
	end
	self.ability = self:GetAbility()
	local parent = self:GetParent()
	self.savedOrigin = parent:GetAbsOrigin()
	self.nextFireTime = self.ability:getLiftDuration()
	EmitSoundOn(BOSS_006_START_SOUND_1, parent)
	EmitSoundOn(BOSS_006_START_SOUND_2, parent)
	self.auraFx = ParticleManager:CreateParticle(AURA_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.auraFx, 0, self.savedOrigin)
	ParticleManager:SetParticleControl(self.auraFx, 1, Vector(AURA_OUTER_RADIUS, 1, 1))
	ParticleManager:SetParticleShouldCheckFoW(self.auraFx, false)
	self.lastAuraDamageTime = GameRules:GetGameTime()
	self:StartIntervalThink(0.03)
end
function modifier_boss_006_buff.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local liftDur = self.ability:getLiftDuration()
	local ____temp_9
	if self:GetDuration() > 0 then
		____temp_9 = self:GetDuration()
	else
		____temp_9 = self.ability:getBuffDuration()
	end
	local totalDuration = ____temp_9
	local remaining = self:GetRemainingTime()
	local fireInt = self.ability:getProjectileFireInterval()
	local elapsed = totalDuration - remaining
	local descendDur = 0.5
	local heightFactor = 1
	if elapsed <= liftDur then
		heightFactor = math.max(0, math.min(1, elapsed / liftDur))
	elseif remaining <= descendDur then
		local downElapsed = descendDur - remaining
		heightFactor = 1 - math.max(0, math.min(1, downElapsed / descendDur))
	else
		heightFactor = 1
	end
	local h = self.ability:getLiftHeight()
	local pos = Vector(self.savedOrigin.x, self.savedOrigin.y, self.savedOrigin.z + h * heightFactor)
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:SetAbsOrigin(pos)
	local now = GameRules:GetGameTime()
	if now - self.lastAuraDamageTime >= 0.2 and IsValidAlive(nil, caster) then
		self.lastAuraDamageTime = now
		EmitSoundOnLocationWithCaster(self.savedOrigin, BOSS_006_AURA_TICK_SOUND, caster)
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			self.savedOrigin,
			nil,
			AURA_OUTER_RADIUS,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for ____, u in ipairs(enemies) do
			do
				if not IsValidAlive(nil, u) then
					goto __continue81
				end
				local d = (u:GetAbsOrigin() - self.savedOrigin):Length2D()
				if d <= AURA_INNER_SAFE_RADIUS then
					goto __continue81
				end
				caster:MonsterDamage({ victim = u, damage_rate = AURA_DAMAGE_RATE, ability = self.ability })
			end
			::__continue81::
		end
	end
	if elapsed >= self.nextFireTime and IsValidAlive(nil, caster) and remaining > 2 then
		if not self.hasPreAppliedExecuteStacks then
			self.hasPreAppliedExecuteStacks = true
			self.ability:preApplyExecuteStacks(caster, parent:GetAbsOrigin())
		end
		self.ability:fireProjectilesAtEnemyHeroes(caster)
		self.nextFireTime = self.nextFireTime + fireInt
	end
end
function modifier_boss_006_buff.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not self.skipRestorePosition and IsValid(nil, parent) then
		FindClearSpaceForUnit(parent, self.savedOrigin, true)
		parent:MoveToPosition(self.savedOrigin)
		self._caster:StartGestureWithPlaybackRate(ACT_DOTA_TELEPORT_END, 1)
	end
	if self.auraFx ~= nil then
		ParticleManager:DestroyParticle(self.auraFx, false)
		ParticleManager:ReleaseParticleIndex(self.auraFx)
		self.auraFx = nil
	end
end
function modifier_boss_006_buff.prototype.StopForExecution(self)
	if not IsServer() then
		return
	end
	self.skipRestorePosition = true
	self:Destroy()
end
function modifier_boss_006_buff.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end
function modifier_boss_006_buff.prototype.IsHidden(self)
	return false
end
function modifier_boss_006_buff.prototype.IsPurgable(self)
	return false
end
modifier_boss_006_buff =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_boss_006_buff") }, modifier_boss_006_buff)
____exports.modifier_boss_006_buff = modifier_boss_006_buff
____exports.modifier_boss_006_execute_stack = __TS__Class()
local modifier_boss_006_execute_stack = ____exports.modifier_boss_006_execute_stack
modifier_boss_006_execute_stack.name = "modifier_boss_006_execute_stack"
__TS__ClassExtends(modifier_boss_006_execute_stack, MonsterModifier_CS)
function modifier_boss_006_execute_stack.GetLocalizationCN(self)
	return {
		name = "风暴印记",
		description = "技能开始发射时预置倒计时层数；每次被旋风命中会减少 1 层，归零将触发处决。",
	}
end
function modifier_boss_006_execute_stack.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	local initStacks = kv and kv.stacks or 1
	self:SetStackCount(math.max(0, initStacks))
	local parent = self:GetParent()
	if IsValid(nil, parent) then
		local pfx = ParticleManager:CreateParticle(EXECUTE_STACK_COUNTER_PFX, PATTACH_OVERHEAD_FOLLOW, parent)
		ParticleManager:SetParticleControl(pfx, 0, parent:GetAbsOrigin())
		ParticleManager:SetParticleControl(pfx, 1, Vector(0, self:GetStackCount(), 0))
		self._pfx = pfx
		self:AddParticle(pfx, false, false, -1, false, false)
	end
end
function modifier_boss_006_execute_stack.prototype.OnStackCountChanged(self, stackCount)
	if not IsServer() then
		return
	end
	if self._pfx ~= nil then
		ParticleManager:SetParticleControl(self._pfx, 1, Vector(0, self:GetStackCount(), 0))
	end
end
function modifier_boss_006_execute_stack.prototype.IsHidden(self)
	return false
end
function modifier_boss_006_execute_stack.prototype.IsDebuff(self)
	return true
end
function modifier_boss_006_execute_stack.prototype.IsPurgable(self)
	return false
end
modifier_boss_006_execute_stack =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_boss_006_execute_stack") }, modifier_boss_006_execute_stack)
____exports.modifier_boss_006_execute_stack = modifier_boss_006_execute_stack
--- 弹道 Thinker：挂持续特效（cp3 绑 attach_origin），每帧沿 dir 移动，碰撞由投射物处理
____exports.modifier_boss_006_bolt_thinker = __TS__Class()
local modifier_boss_006_bolt_thinker = ____exports.modifier_boss_006_bolt_thinker
modifier_boss_006_bolt_thinker.name = "modifier_boss_006_bolt_thinker"
__TS__ClassExtends(modifier_boss_006_bolt_thinker, MonsterModifier_CS)
function modifier_boss_006_bolt_thinker.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.lastSkyFxTime = 0
end
function modifier_boss_006_bolt_thinker.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	self.ability = self:GetAbility()
	local thinker = self:GetParent()
	local dx = kv.dir_x or 0
	local dy = kv.dir_y or 1
	local dz = kv.dir_z or 0
	self.dir = Vector(dx, dy, dz)
	if self.dir:Length2D() < 0.01 then
		self.dir.x = 1
		self.dir.y = 0
		self.dir.z = 0
	else
		self.dir = self.dir:Normalized()
	end
	self.ambientFx =
		ParticleManager:CreateParticle(self.ability:getThinkerAmbientEffect(), PATTACH_ABSORIGIN_FOLLOW, thinker)
	ParticleManager:SetParticleControlEnt(
		self.ambientFx,
		0,
		thinker,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_origin",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:SetParticleShouldCheckFoW(self.ambientFx, false)
	self:StartIntervalThink(0.03)
	self.lastSkyFxTime = GameRules:GetGameTime()
end
function modifier_boss_006_bolt_thinker.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local thinker = self:GetParent()
	if not IsValidAlive(nil, thinker) then
		return
	end
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	local speed = self.ability:getProjectileSpeed()
	local dt = 0.03
	local move = self.dir * (speed * dt)
	local newPos = thinker:GetAbsOrigin() + move
	newPos.z = GetGroundHeight(newPos, thinker) or newPos.z
	thinker:SetAbsOrigin(newPos)
end
function modifier_boss_006_bolt_thinker.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.ambientFx ~= nil then
		ParticleManager:DestroyParticle(self.ambientFx, false)
		ParticleManager:ReleaseParticleIndex(self.ambientFx)
	end
end
function modifier_boss_006_bolt_thinker.prototype.IsHidden(self)
	return true
end
function modifier_boss_006_bolt_thinker.prototype.IsPurgable(self)
	return false
end
modifier_boss_006_bolt_thinker =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_boss_006_bolt_thinker") }, modifier_boss_006_bolt_thinker)
____exports.modifier_boss_006_bolt_thinker = modifier_boss_006_bolt_thinker
return ____exports