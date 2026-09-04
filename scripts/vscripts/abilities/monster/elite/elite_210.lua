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
local ____elite_showcase_utils = require("abilities.monster.elite.elite_showcase_utils")
local EliteCreateLimitedWarningTargetTracker = ____elite_showcase_utils.EliteCreateLimitedWarningTargetTracker
--- 蓄力时长（秒）= castPoint 前摇时长
local CHARGE_DURATION = 1.5
--- 预警时长随机波动比例：0.2 表示本次预警在基础时长的 ±20% 内浮动
local WARNING_DURATION_RANDOM_RATIO = 0.2
--- 预警圈停止跟随后额外保留时长
local WARNING_HOLD_AFTER_STOP = 0.5
--- 预警圈追踪目标的最大移动速度，玩家高速位移时可以把落点甩开
local WARNING_FOLLOW_SPEED = 330
--- 释放动作锁定时长：cast_controller 锁住，期间 IsMonsterCasting=true，boss_ai 不敢插手
local RELEASE_DURATION = 0.5
--- 释放动作切到后、球随炮臂甩到前方再脱手发射的延迟（对上 catapult_attack 甩臂到位的时刻，可调）
local PROJECTILE_DELAY = 0.75
--- 投石弹飞行速度（collideground 弹道速度，可调）
local PROJECTILE_SPEED = 1200
--- 落点命中半径
local IMPACT_RADIUS = 220
--- 落点伤害倍率
local IMPACT_DAMAGE_RATE = 25
--- 燃烧地面持续时间
local BURNING_GROUND_DURATION = 3
--- 燃烧地面伤害间隔
local BURNING_GROUND_DAMAGE_INTERVAL = 0.5
--- 燃烧地面每跳伤害为砸击伤害的 30%
local BURNING_GROUND_DAMAGE_RATE = IMPACT_DAMAGE_RATE * 0.3
--- 击飞高度
local KNOCKBACK_HEIGHT = 150
--- 击飞持续时间
local KNOCKBACK_DURATION = 0.4
--- 击飞结束后额外眩晕时间
local KNOCKBACK_STUN_DURATION = 0.6
--- 击飞水平推开距离
local KNOCKBACK_DISTANCE = 150
--- 前摇锁敌搜索范围（castRange 一致）
local TARGET_SEARCH_RANGE = 2000
--- 无目标时默认落点距离（前方）
local FALLBACK_LAND_DISTANCE = 600
--- 炮口挂点取不到时的兜底：相对脚下抬升高度（近似炮臂高度）
local LAUNCH_HEIGHT = 220
--- 炮口挂点取不到时的兜底：相对脚下前方偏移
local LAUNCH_FORWARD = 60
--- 蓄力期身体充能光环（野兽突袭 chargeup，红光汇聚，绑 attach_hitloc 跟随身体，已 precache）
local CHARGE_GATHER_PARTICLE = "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_chargeup.vpcf"
--- 蓄力球 + 飞行投石弹同款；loot_greevil_tgt=greevil 发光球（实测能渲染会飞）
local ORB_PARTICLE = "particles/base_attacks/ranged_tower_bad.vpcf"
--- 蓄力球钉住的【骨骼】名。模型实测【零挂点】(挂点探测全 ✗)→粒子无法挂/跟随骨骼局部动画(API 无读骨骼坐标函数)。
-- 但 `FollowEntityMerge(ent, boneName)` 能把一个 dummy 单位【钉到 tail_end 骨骼的位置】(随单位整体位置/朝向走，
-- 不含尾巴的局部摆动) → 球绑 dummy → 球静态钉在尾尖(用户画的红框处)。用户已接受"球在尾尖、不随摆动"。
local ORB_BONE = "tail_end"
--- 蓄力球相对 tail_end 的偏移（怪物【本地朝向】空间，球随怪转身保持相对位置，不会因转身飘走）。
-- 调这三个数把球挪到你要的位置：X=前后(正=朝怪物正前方)，Y=左右(正=朝怪物右侧)，Z=上下(正=向上)。
-- 单位≈游戏距离单位。三个全 0 = 正好钉在 tail_end。
local ORB_OFFSET_X_FORWARD = 110
local ORB_OFFSET_Y_RIGHT = 0
local ORB_OFFSET_Z_UP = 17
--- 投石弹飞行特效 = 蓄力球同款 greevil 球（用户指定，飞行时实测能渲染）；飞行形式照搬石头那套 collideground 弹道
local PROJECTILE_PARTICLE = ORB_PARTICLE
--- 落地爆炸粒子（野兽岩石投掷命中，与投石弹同族，已 precache）
local IMPACT_PARTICLE = "particles/lina_spell_light_strike_array_3.vpcf"
--- 燃烧地面粒子
local BURNING_GROUND_PARTICLE = "particles/units/heroes/hero_phoenix/phoenix_fire_spirit_ground.vpcf"
--- 投石释放音效
local RELEASE_SOUND = "Hero_PrimalBeast.RockThrow.Cast"
--- AI 思考间隔（秒）
local AI_THINK_INTERVAL = 0.25
--- 风筝触发/侦测距离：最近敌人进入此距离就开始逃（可控）
local KITE_DISTANCE = 1000
--- 风筝逃跑移速（可控）；怪物只在风筝时移动，故此即逃跑速度
local KITE_SPEED = 300
--- 每次寻路逃跑的步长（往反方向走多远，越大越流畅）
local KITE_STEP = 1000
--- 风筝停下后的"准备阶段"驻留时长（秒）：停下→转向玩家→驻留→放炮，避免停下瞬间硬放（可调）
local PREP_TIME = 1
--- 准备阶段转向速度（度/秒）：每帧手动朝玩家转这么多度，越大越利落、越小越柔（可调）
local PREP_TURN_RATE = 360
local elite_210 = __TS__Class()
elite_210.name = "elite_210"
__TS__ClassExtends(elite_210, MonsterAbility_CS)
function elite_210.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_210_ai"
end
function elite_210.prototype.Precache(self, context)
	PrecacheResource("particle", CHARGE_GATHER_PARTICLE, context)
	PrecacheResource("particle", ORB_PARTICLE, context)
	PrecacheResource("particle", PROJECTILE_PARTICLE, context)
	PrecacheResource("particle", IMPACT_PARTICLE, context)
	PrecacheResource("particle", BURNING_GROUND_PARTICLE, context)
end
function elite_210.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = self:getWarningDuration(),
		castDuration = RELEASE_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_DISABLED,
		animationPlaybackRate = 1,
		castRange = TARGET_SEARCH_RANGE,
		OnPhaseStart = function()
			return self:onChargeStart()
		end,
		OnStart = function()
			return self:onRelease()
		end,
		OnInterrupt = function()
			return self:cleanupChargeVisuals()
		end,
		OnFinish = function()
			return self:cleanupChargeVisuals()
		end,
	}
end
function elite_210.prototype.getWarningDuration(self)
	if not IsServer() then
		return CHARGE_DURATION
	end
	if self._warningDuration == nil then
		self._warningDuration = CHARGE_DURATION
			* RandomFloat(1 - WARNING_DURATION_RANDOM_RATIO, 1 + WARNING_DURATION_RANDOM_RATIO)
	end
	return self._warningDuration
end
function elite_210.prototype.onChargeStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local warningDuration = self:getWarningDuration()
	self._lockedLandPos = nil
	self._isWarningLandPosLocked = false
	self._warningTracker = nil
	self._lockedTarget = caster:GetMinDistanceUnit(TARGET_SEARCH_RANGE)
	self._chargeParticleId = ParticleManager:CreateParticle(CHARGE_GATHER_PARTICLE, PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleShouldCheckFoW(self._chargeParticleId, false)
	ParticleManager:SetParticleControlEnt(
		self._chargeParticleId,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	self:createOrb(caster, warningDuration)
	local ____self_groundPosition_2 = self.groundPosition
	local ____opt_0 = self._lockedTarget
	local initialCenter =
		____self_groundPosition_2(self, ____opt_0 and ____opt_0:GetAbsOrigin() or caster:GetAbsOrigin(), caster)
	local tracker = EliteCreateLimitedWarningTargetTracker(nil, {
		caster = caster,
		initialTarget = self._lockedTarget,
		initialCenter = initialCenter,
		followDuration = warningDuration,
		followSpeed = WARNING_FOLLOW_SPEED,
		resolveTarget = function()
			return self._lockedTarget
		end,
		resolveTargetPoint = function(____, target)
			return self:groundPosition(target:GetAbsOrigin(), target)
		end,
		resolveFallbackPoint = function()
			return self:groundPosition(
				caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(FALLBACK_LAND_DISTANCE)),
				caster
			)
		end,
	})
	self._warningTracker = tracker
	self._lockedLandPos = tracker:getCenter()
	self:FacePoint(caster, self._lockedLandPos)
	self:Timer(math.max(warningDuration - 0.2, 0), function()
		if self._warningTracker == nil then
			return
		end
		caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.5)
	end)
	self:WarningRingEffect(initialCenter, IMPACT_RADIUS, warningDuration + WARNING_HOLD_AFTER_STOP, {
		getCenter = function()
			self._lockedLandPos = tracker:update()
			self:FacePoint(caster, self._lockedLandPos)
			return self._lockedLandPos
		end,
	})
end
function elite_210.prototype.onRelease(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:DestroyChargeParticle()
	caster:EmitSound(RELEASE_SOUND)
	self:lockWarningLandPosition(caster)
	self:launchProjectile()
end
function elite_210.prototype.launchProjectile(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local landPos = self:resolveLandPosition(caster)
	self:cleanupOrb()
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = PROJECTILE_PARTICLE,
		projectile_type = "collideground",
		projectile_speed = PROJECTILE_SPEED,
		start_point = self:launchPosition(caster),
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
function elite_210.prototype.resolveLandPosition(self, caster)
	if self._lockedLandPos ~= nil then
		return self._lockedLandPos
	end
	local target = self._lockedTarget
	if target and IsValidAlive(nil, target) then
		return self:groundPosition(target:GetAbsOrigin(), target)
	end
	local f = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(FALLBACK_LAND_DISTANCE))
	return self:groundPosition(f, caster)
end
function elite_210.prototype.lockWarningLandPosition(self, caster)
	if self._isWarningLandPosLocked and self._lockedLandPos ~= nil then
		return self._lockedLandPos
	end
	if self._warningTracker ~= nil then
		self._lockedLandPos = self._warningTracker:lock()
		self._isWarningLandPosLocked = true
		self:FacePoint(caster, self._lockedLandPos)
		return self._lockedLandPos
	end
	local target = self._lockedTarget
	if target and IsValidAlive(nil, target) then
		self._lockedLandPos = self:groundPosition(target:GetAbsOrigin(), target)
	elseif self._lockedLandPos == nil then
		local f = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(FALLBACK_LAND_DISTANCE))
		self._lockedLandPos = self:groundPosition(f, caster)
	end
	self._isWarningLandPosLocked = true
	local finalLandPos = self._lockedLandPos
	if finalLandPos ~= nil then
		self:FacePoint(caster, finalLandPos)
		return finalLandPos
	end
	local fallback = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(FALLBACK_LAND_DISTANCE))
	self._lockedLandPos = self:groundPosition(fallback, caster)
	self:FacePoint(caster, self._lockedLandPos)
	return self._lockedLandPos
end
function elite_210.prototype.groundPosition(self, pos, unit)
	return Vector(pos.x, pos.y, GetGroundHeight(pos, unit) or pos.z)
end
function elite_210.prototype.FacePoint(self, caster, point)
	if not IsValidAlive(nil, caster) or point == nil then
		return
	end
	local direction = GetDirection(nil, point, caster:GetAbsOrigin())
	if direction:Length2D() > 0.01 then
		caster:SetForwardVectorWithoutInterrupt(direction)
	end
end
function elite_210.prototype.launchPosition(self, caster)
	local idx = caster:ScriptLookupAttachment("attach_attack1")
	if idx and idx > 0 then
		local p = caster:GetAttachmentOrigin(idx)
		if p then
			return p
		end
	end
	return caster
		:GetAbsOrigin()
		:__add(caster:GetForwardVector():__mul(LAUNCH_FORWARD))
		:__add(Vector(0, 0, LAUNCH_HEIGHT))
end
function elite_210.prototype.createOrb(self, caster, warningDuration)
	local dummy = CreateModifierThinker(
		caster,
		self,
		"modifier_dummy_thinker",
		{ duration = warningDuration + RELEASE_DURATION + 1 },
		caster:GetAbsOrigin(),
		caster:GetTeamNumber(),
		false
	)
	if not IsValidAlive(nil, dummy) then
		return
	end
	dummy:FollowEntityMerge(caster, ORB_BONE)
	self._orbDummy = dummy
	local orb = ParticleManager:CreateParticle(ORB_PARTICLE, PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleShouldCheckFoW(orb, false)
	ParticleManager:SetParticleControl(orb, 0, self:orbAnchorPos(caster, dummy))
	self._orbPfxList = { orb }
	Timers:CreateTimer(FrameTime(), function()
		if self._orbPfxList == nil then
			return nil
		end
		local c = self:GetCaster()
		local d = self._orbDummy
		if not IsValidAlive(nil, c) or not IsValidAlive(nil, d) then
			self:cleanupOrb()
			return nil
		end
		ParticleManager:SetParticleControl(orb, 0, self:orbAnchorPos(c, d))
		return FrameTime()
	end)
end
function elite_210.prototype.orbAnchorPos(self, caster, dummy)
	local base = dummy:GetAbsOrigin()
	local fwd = caster:GetForwardVector()
	local right = caster:GetRightVector()
	return base:__add(fwd:__mul(ORB_OFFSET_X_FORWARD))
		:__add(right:__mul(ORB_OFFSET_Y_RIGHT))
		:__add(Vector(0, 0, ORB_OFFSET_Z_UP))
end
function elite_210.prototype.onImpact(self, caster, center)
	local ability = self
	if not IsValidAlive(nil, caster) then
		return
	end
	local impactPfx = ParticleManager:CreateParticle(IMPACT_PARTICLE, PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleShouldCheckFoW(impactPfx, false)
	ParticleManager:SetParticleControl(impactPfx, 0, center)
	ParticleManager:SetParticleControl(impactPfx, 1, center)
	Timers:CreateTimer(1.2, function()
		ParticleManager:DestroyParticle(impactPfx, false)
		ParticleManager:ReleaseParticleIndex(impactPfx)
	end)
	ScreenShake(center, 10, 10, 1, IMPACT_RADIUS * 5, 0, true)
	self:createBurningGround(caster, center)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		IMPACT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue52
			end
			local outward = enemy:GetAbsOrigin():__sub(center)
			local flat = Vector(outward.x, outward.y, 0)
			local ____temp_3
			if flat:Length2D() > 0.01 then
				____temp_3 = flat:Normalized()
			else
				____temp_3 = caster:GetForwardVector()
			end
			local knockDir = ____temp_3
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = IMPACT_DAMAGE_RATE,
				ability = ability,
				effectName = IMPACT_PARTICLE,
			})
			enemy:KnockBack(caster, ability, {
				direction = knockDir,
				duration = KNOCKBACK_DURATION,
				distance = KNOCKBACK_DISTANCE,
				height = KNOCKBACK_HEIGHT,
				stun = true,
				stunDuration = KNOCKBACK_STUN_DURATION,
				uniform = true,
				destroyTreesRange = 120,
				destroyTreesType = "continues",
			})
		end
		::__continue52::
	end
end
function elite_210.prototype.createBurningGround(self, caster, center)
	if not IsValidAlive(nil, caster) then
		return
	end
	CreateModifierThinker(
		caster,
		self,
		"modifier_elite_210_burning_ground",
		{ duration = BURNING_GROUND_DURATION },
		center,
		caster:GetTeamNumber(),
		false
	)
end
function elite_210.prototype.cleanupOrb(self)
	if self._orbPfxList ~= nil then
		for ____, orb in ipairs(self._orbPfxList) do
			ParticleManager:DestroyParticle(orb, false)
			ParticleManager:ReleaseParticleIndex(orb)
		end
		self._orbPfxList = nil
	end
	if self._orbDummy ~= nil then
		if IsValid(nil, self._orbDummy) and not self._orbDummy:IsNull() then
			self._orbDummy:RemoveSelf()
		end
		self._orbDummy = nil
	end
end
function elite_210.prototype.DestroyChargeParticle(self)
	if self._chargeParticleId == nil then
		return
	end
	ParticleManager:DestroyParticle(self._chargeParticleId, false)
	ParticleManager:ReleaseParticleIndex(self._chargeParticleId)
	self._chargeParticleId = nil
end
function elite_210.prototype.cleanupChargeVisuals(self)
	self:DestroyChargeParticle()
	self:cleanupOrb()
	self._warningTracker = nil
	self._warningDuration = nil
end
elite_210 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_210)
local modifier_elite_210_burning_ground = __TS__Class()
modifier_elite_210_burning_ground.name = "modifier_elite_210_burning_ground"
__TS__ClassExtends(modifier_elite_210_burning_ground, BaseModifier)
function modifier_elite_210_burning_ground.prototype.IsHidden(self)
	return true
end
function modifier_elite_210_burning_ground.prototype.IsPurgable(self)
	return false
end
function modifier_elite_210_burning_ground.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local center = self:GetParent():GetAbsOrigin()
	local particleId = ParticleManager:CreateParticle(BURNING_GROUND_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(particleId, false)
	ParticleManager:SetParticleControl(particleId, 0, center)
	ParticleManager:SetParticleControl(particleId, 1, Vector(IMPACT_RADIUS, IMPACT_RADIUS, IMPACT_RADIUS))
	ParticleManager:SetParticleControl(particleId, 2, Vector(BURNING_GROUND_DURATION, 0, 0))
	self._burnParticleId = particleId
	self:StartIntervalThink(BURNING_GROUND_DAMAGE_INTERVAL)
end
function modifier_elite_210_burning_ground.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local ability = self:GetAbility()
	local center = parent:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		IMPACT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue73
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = BURNING_GROUND_DAMAGE_RATE, ability = ability })
		end
		::__continue73::
	end
end
function modifier_elite_210_burning_ground.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self._burnParticleId == nil then
		return
	end
	ParticleManager:DestroyParticle(self._burnParticleId, false)
	ParticleManager:ReleaseParticleIndex(self._burnParticleId)
	self._burnParticleId = nil
end
modifier_elite_210_burning_ground = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_210_burning_ground") },
	modifier_elite_210_burning_ground
)
local modifier_elite_210_ai = __TS__Class()
modifier_elite_210_ai.name = "modifier_elite_210_ai"
__TS__ClassExtends(modifier_elite_210_ai, BaseModifier)
function modifier_elite_210_ai.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self._preparing = false
end
function modifier_elite_210_ai.prototype.IsHidden(self)
	return true
end
function modifier_elite_210_ai.prototype.IsPurgable(self)
	return false
end
function modifier_elite_210_ai.prototype.RemoveOnDeath(self)
	return true
end
function modifier_elite_210_ai.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self._preparing = false
	self:StartIntervalThink(AI_THINK_INTERVAL)
end
function modifier_elite_210_ai.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
function modifier_elite_210_ai.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE }
end
function modifier_elite_210_ai.prototype.GetModifierMoveSpeed_Absolute(self)
	return KITE_SPEED
end
function modifier_elite_210_ai.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local ____temp_6 = parent:IsStunned()
	if not ____temp_6 then
		local ____opt_4 = parent.IsMonsterCasting
		____temp_6 = (____opt_4 and ____opt_4(parent)) == true
	end
	if ____temp_6 then
		return
	end
	if self._preparing then
		return
	end
	local target = parent:GetMinDistanceUnit(TARGET_SEARCH_RANGE)
	if not target or not IsValidAlive(nil, target) then
		return
	end
	local ability = parent:FindAbilityByName("elite_210")
	if ability and not ability:IsNull() and ability:IsCooldownReady() then
		self._preparing = true
		parent:Stop()
		local prepStart = GameRules:GetGameTime()
		Timers:CreateTimer(FrameTime(), function()
			if not IsValidAlive(nil, parent) then
				self._preparing = false
				return nil
			end
			local t2 = parent:GetMinDistanceUnit(TARGET_SEARCH_RANGE)
			if t2 and IsValidAlive(nil, t2) then
				local cur = parent:GetForwardVector()
				local want = GetDirection(nil, t2:GetAbsOrigin(), parent:GetAbsOrigin())
				local dot = math.max(-1, math.min(1, cur.x * want.x + cur.y * want.y))
				local angle = math.deg(math.acos(dot))
				local step = PREP_TURN_RATE * FrameTime()
				if angle <= step then
					parent:SetForwardVector(Vector(want.x, want.y, 0))
				else
					local sign = cur.x * want.y - cur.y * want.x >= 0 and 1 or -1
					parent:SetForwardVector(RotateVector2D(nil, cur, sign * step))
				end
			end
			if GameRules:GetGameTime() - prepStart < PREP_TIME then
				return FrameTime()
			end
			self._preparing = false
			local ____temp_9 = parent:IsStunned()
			if not ____temp_9 then
				local ____opt_7 = parent.IsMonsterCasting
				____temp_9 = (____opt_7 and ____opt_7(parent)) == true
			end
			if ____temp_9 then
				return nil
			end
			local ab = parent:FindAbilityByName("elite_210")
			if ab and not ab:IsNull() and ab:IsCooldownReady() then
				parent:CastAbilityNoTarget(ab, parent:GetPlayerOwnerID())
			end
			return nil
		end)
		return
	end
	if GetDistance(nil, parent:GetAbsOrigin(), target:GetAbsOrigin()) <= KITE_DISTANCE then
		local away = parent:GetAbsOrigin():__sub(target:GetAbsOrigin())
		local flat = Vector(away.x, away.y, 0)
		local ____temp_10
		if flat:Length2D() > 0.01 then
			____temp_10 = flat:Normalized()
		else
			____temp_10 = parent:GetForwardVector()
		end
		local dir = ____temp_10
		local fleePos = parent:GetAbsOrigin():__add(dir:__mul(KITE_STEP))
		parent:MoveToPosition(fleePos)
	end
end
function modifier_elite_210_ai.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if IsValid(nil, self:GetParent()) then
		self:GetParent():AddNoDraw()
		local pfx = ParticleManager:CreateParticle(
			"particles/econ/creeps/creep_2021_dire/creep_2021_dire_siege_death.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(pfx, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControlTransformForward(
			pfx,
			0,
			self:GetParent():GetAbsOrigin(),
			self:GetParent():GetForwardVector()
		)
		ParticleManager:ReleaseParticleIndex(pfx)
	end
end
modifier_elite_210_ai = __TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_210_ai") }, modifier_elite_210_ai)
return ____exports