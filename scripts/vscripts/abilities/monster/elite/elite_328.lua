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
local modifier_elite_328_animation
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
--- victory 蓄力时长(秒) = 引擎前摇播放
local CHARGE_DURATION = 1
--- cast_fence 动作全长(秒) = 78帧/30fps ≈ 2.6，三球在 24~78 帧间依次出现
local FENCE_DURATION = 2.6
--- 第一波三球出现时刻(秒·相对 OnStart)：第三颗在 2.3 秒出现，随后保留 0.3 秒动作收尾
local FENCE_ORB_TIMES = { 0.7, 1.5, 2.3 }
--- 蓄力段A时长(秒)：第一波火球出齐后站桩蓄力
local CHARGE_A_DURATION = 1
--- attack 段起点(秒)
local T_ATTACK1 = FENCE_DURATION + CHARGE_A_DURATION
--- attack2 段起点(秒)：与 attack 的间隔留出攻击动作出手时间
local T_ATTACK2 = T_ATTACK1 + 1
--- 蓄力段B起点(秒)：第二波火球开始依次生成（attack#2 两球连射 0.75s + 后摇之后）
local T_RESPAWN = T_ATTACK2 + 1.2
--- 蓄力段B每枚火球依次亮起的间隔(秒)
local RESPAWN_INTERVAL = 0.4
--- attack3 段起点(秒)：三枚火球全部就位后齐射
local T_ATTACK3 = T_RESPAWN + RESPAWN_INTERVAL * 2 + 0.7
--- 蓄力段B读条时长(秒)：与框架前摇条同款表现（modifier_monster_cast_pre_progress）
local CHARGE_B_BAR_DURATION = T_ATTACK3 - T_RESPAWN
--- 攻击动作出手延迟(秒)：攻击动作开始到火球离手，对齐挥击帧
local ATTACK_FIRE_DELAY = 0.35
--- 同段多球连射间隔(秒)：拉大到足以让玩家跑出位置差，实现"每球点名玩家当时位置"的依次瞄准
local VOLLEY_GAP = 0.4
--- 每球独立瞄准提前量(秒)：发射前该时长画预警线并锁定玩家当时位置
local ORB_AIM_LEAD = 0.3
--- 攻击动作在本段发射完后回到蓄力姿态的延迟(秒)，留一点后摇
local ATTACK_SETTLE_DELAY = 0.25
--- 站桩总时长 castDuration：attack3 出手 + 收尾余量
local STAND_DURATION = T_ATTACK3 + ATTACK_FIRE_DELAY + VOLLEY_GAP * 2 + 0.8
--- 蓄力站桩姿态的动画速率（victory 极慢放维持"蓄满"姿态）
local STAND_ANIM_RATE = 0.05
--- victory 蓄力动作
local CHARGE_ACTIVITY = ACT_DOTA_VICTORY
--- 搜敌/施法距离
local SEARCH_RANGE = 1800
--- 火球总数（两波各3枚）
local ORB_TOTAL = 6
--- 每波数量
local ORB_WAVE = 3
--- 火球悬浮离地高度
local ORB_HOVER_HEIGHT = 150
--- 火球阵列身前距离
local ORB_FORWARD_OFFSET = 170
--- 火球阵列左右间距
local ORB_SIDE_OFFSET = 150
--- 弹入动画总步数（每步 0.03s，总时长 ≈ 0.3s）
local ORB_BOUNCE_STEPS = 10
--- 弹入动画步进间隔(秒)
local ORB_BOUNCE_STEP_TIME = 0.03
--- 弹入过冲高度：先冲过悬浮高度再回落，营造跳动感
local ORB_BOUNCE_OVERSHOOT = 30
--- 弹道速度（匀速；原生弹道不支持变速）
local ORB_PROJECTILE_SPEED = 1800
--- 弹道最大飞行距离
local ORB_MAX_DISTANCE = 1500
--- 弹道碰撞半径
local ORB_HIT_RADIUS = 96
--- 弹道线状预警宽度 = 弹道碰撞直径（预警即承诺：发射严格沿预警线飞，线宽如实反映判定）
local WARNING_LINE_WIDTH = ORB_HIT_RADIUS * 2
--- 命中溅射范围
local ORB_AOE_RADIUS = 130
--- 单球伤害系数（MonsterDamage damage_rate）
local ORB_DAMAGE_RATE = 10
--- 悬浮火球粒子（定点渲染型，elite_027 modifier 特效同款）——WORLDORIGIN + CP0 喂位置
local ORB_IDLE_PARTICLE = "particles/dd/fire_effect.vpcf"
--- 弹道粒子：凤凰火魂投射物弹体，自带火鸟前端+长尾焰拖尾（作为 CreateProjectile effect_name 走
-- 投射物系统按弹体粒子约定驱动——手动 ABSORIGIN_FOLLOW 挂载不可用，实测踩坑）
-- 注：econ 饰品 ambient 粒子（PA 披风烟雾）依赖饰品专属资源，非饰品环境渲染为红叉，禁用
local ORB_FLY_PARTICLE = "particles/phoenix_fire_spirit_launch_2.vpcf"
--- 气浪 burst 释放间隔(秒)
local ORB_WAVE_BURST_INTERVAL = 0.09
--- 命中爆炸
local ORB_IMPACT_PARTICLE = "particles/units/heroes/hero_phoenix/phoenix_fire_spirit_ground.vpcf"
--- 火球生成音
local ORB_SPAWN_SOUND = "Hero_Phoenix.FireSpirits.Cast"
--- 火球发射音
local ORB_LAUNCH_SOUND = "Hero_Phoenix.FireSpirits.Launch"
--- 火球命中音
local ORB_IMPACT_SOUND = "Hero_OgreMagi.Fireblast.Target"
local elite_328 = __TS__Class()
elite_328.name = "elite_328"
__TS__ClassExtends(elite_328, MonsterAbility_CS)
function elite_328.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.sequence = 0
	self.orbs = {}
end
function elite_328.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_328_ai"
end
function elite_328.prototype.Precache(self, context)
	PrecacheResource("particle", ORB_IDLE_PARTICLE, context)
	PrecacheResource("particle", ORB_FLY_PARTICLE, context)
	PrecacheResource("particle", ORB_IMPACT_PARTICLE, context)
end
function elite_328.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = CHARGE_DURATION,
		castDuration = STAND_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = CHARGE_ACTIVITY,
		animationPlaybackRate = 1,
		castRange = SEARCH_RANGE,
		castProgressBarColor = "blue",
		canCast = function()
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, self:FindTarget()) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		OnPhaseStart = function()
			return self:onChargeStart()
		end,
		OnStart = function()
			return self:onStandStart()
		end,
		OnInterrupt = function()
			return self:onCleanup()
		end,
		OnFinish = function()
			return self:onCleanup()
		end,
	}
end
function elite_328.prototype.OnAbilityPhaseStart(self)
	local caster = self:GetCaster()
	local ____IsValidAlive_result_3 = IsValidAlive(nil, caster)
	if ____IsValidAlive_result_3 then
		local ____opt_1 = caster.IsMonsterCasting
		____IsValidAlive_result_3 = (____opt_1 and ____opt_1(caster)) == true
	end
	if ____IsValidAlive_result_3 then
		return false
	end
	return MonsterAbility_CS.prototype.OnAbilityPhaseStart(self)
end
function elite_328.prototype.onChargeStart(self)
	local caster = self:GetCaster()
	local target = self:FindTarget()
	local ____IsValidAlive_result_4
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_4 = target:entindex()
	else
		____IsValidAlive_result_4 = nil
	end
	self.lockedTargetIndex = ____IsValidAlive_result_4
	if IsValidAlive(nil, caster) and IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, CHARGE_DURATION, 8)
	end
end
function elite_328.prototype.ensureAnimModifier(self, caster)
	local mod = modifier_elite_328_animation:find_on(caster)
	if not mod then
		mod = modifier_elite_328_animation:applys(caster, caster, self, { duration = STAND_DURATION + 0.2 })
	end
	return mod
end
function elite_328.prototype.onStandStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self.sequence = self.sequence + 1
	local seq = self.sequence
	self:clearOrbs()
	self:Timer(0.1, function()
		if seq ~= self.sequence then
			return
		end
		self:StartCooldown(STAND_DURATION + self:GetCooldown(self:GetLevel() - 1))
	end)
	print(("[elite_328] OnStart seq=" .. tostring(seq)) .. " 动画覆盖 cast_fence")
	self:Timer(FrameTime(), function()
		if seq ~= self.sequence or not IsValidAlive(nil, caster) then
			return
		end
		local ____opt_5 = self:ensureAnimModifier(caster)
		if ____opt_5 ~= nil then
			____opt_5:SetAnimation(ACT_DOTA_CAST_FENCE, false)
		end
		caster:FadeGesture(ACT_DOTA_CAST_FENCE)
		caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_FENCE, 1)
	end)
	do
		local i = 0
		while i < ORB_WAVE do
			local slot = i
			self:Timer(FENCE_ORB_TIMES[i + 1], function()
				if seq ~= self.sequence or not IsValidAlive(nil, caster) then
					return
				end
				self:spawnOrb(caster, seq, slot)
			end)
			i = i + 1
		end
	end
	self:Timer(FENCE_DURATION, function()
		if seq ~= self.sequence or not IsValidAlive(nil, caster) then
			return
		end
		caster:FadeGesture(ACT_DOTA_CAST_FENCE)
		local ____opt_7 = self:ensureAnimModifier(caster)
		if ____opt_7 ~= nil then
			____opt_7:SetAnimation(CHARGE_ACTIVITY, true)
		end
	end)
	self:Timer(T_ATTACK1, function()
		if seq ~= self.sequence or not IsValidAlive(nil, caster) then
			return
		end
		self:playAttackAndFire(caster, seq, "attack#1", { 0 })
	end)
	self:Timer(T_ATTACK2, function()
		if seq ~= self.sequence or not IsValidAlive(nil, caster) then
			return
		end
		self:playAttackAndFire(caster, seq, "attack#2", { 1, 2 })
	end)
	self:Timer(T_RESPAWN, function()
		if seq ~= self.sequence or not IsValidAlive(nil, caster) then
			return
		end
		caster:AddNewModifier(
			caster,
			self,
			"modifier_monster_cast_pre_progress",
			{ time = CHARGE_B_BAR_DURATION, progressBarColor = 1 }
		)
	end)
	do
		local i = 0
		while i < ORB_WAVE do
			local slot = ORB_WAVE + i
			self:Timer(T_RESPAWN + RESPAWN_INTERVAL * i, function()
				if seq ~= self.sequence or not IsValidAlive(nil, caster) then
					return
				end
				self:spawnOrb(caster, seq, slot)
			end)
			i = i + 1
		end
	end
	self:Timer(T_ATTACK3, function()
		if seq ~= self.sequence or not IsValidAlive(nil, caster) then
			return
		end
		self:playAttackAndFire(caster, seq, "attack#3", { 3, 4, 5 })
	end)
	print(
		(("[elite_328] 时间轴注册完毕 seq=" .. tostring(seq)) .. " 动画modifier=")
			.. (modifier_elite_328_animation:find_on(caster) and "已挂载" or "挂载失败")
	)
end
function elite_328.prototype.spawnOrb(self, caster, seq, slot)
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local forward = caster:GetForwardVector()
	local right = RotateVector2D(nil, forward, 90)
	local side = (slot % ORB_WAVE - 1) * ORB_SIDE_OFFSET
	local groundPos =
		GetGroundPosition(origin:__add(forward:__mul(ORB_FORWARD_OFFSET)):__add(right:__mul(side)), caster)
	local hoverPos = Vector(groundPos.x, groundPos.y, groundPos.z + ORB_HOVER_HEIGHT)
	EmitSoundOn(ORB_SPAWN_SOUND, caster)
	local pfx = ParticleManager:CreateParticle(ORB_IDLE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, groundPos)
	self.orbs[slot + 1] = { pfx = pfx, pos = groundPos }
	print((("[elite_328] 生成火球 slot=" .. tostring(slot)) .. " pos=") .. tostring(hoverPos))
	self:animateOrbBounce(seq, slot, groundPos, 0)
end
function elite_328.prototype.animateOrbBounce(self, seq, slot, base, step)
	self:Timer(ORB_BOUNCE_STEP_TIME, function()
		if seq ~= self.sequence then
			return
		end
		local orb = self.orbs[slot + 1]
		if not orb then
			return
		end
		local nextStep = step + 1
		local t = nextStep / ORB_BOUNCE_STEPS
		local peakZ = ORB_HOVER_HEIGHT + ORB_BOUNCE_OVERSHOOT
		local z
		if t < 0.7 then
			z = peakZ * math.sin(t / 0.7 * math.pi / 2)
		else
			z = peakZ - ORB_BOUNCE_OVERSHOOT * ((t - 0.7) / 0.3)
		end
		local pos = Vector(base.x, base.y, base.z + z)
		ParticleManager:SetParticleControl(orb.pfx, 0, pos)
		orb.pos = pos
		if nextStep < ORB_BOUNCE_STEPS then
			self:animateOrbBounce(seq, slot, base, nextStep)
		else
			local settled = Vector(base.x, base.y, base.z + ORB_HOVER_HEIGHT)
			ParticleManager:SetParticleControl(orb.pfx, 0, settled)
			orb.pos = settled
		end
	end)
end
function elite_328.prototype.playAttackAndFire(self, caster, seq, label, slots)
	print((("[elite_328] 播放攻击动作 " .. label) .. " 发射槽位=") .. table.concat(slots, ","))
	local targetPos = self:resolveTargetPosition(caster)
	caster:SetForwardVector(self:getDirectionTo(caster:GetAbsOrigin(), targetPos))
	local ____opt_9 = self:ensureAnimModifier(caster)
	if ____opt_9 ~= nil then
		____opt_9:SetAnimation(ACT_DOTA_ATTACK, false)
	end
	do
		local i = 0
		while i < #slots do
			local slot = slots[i + 1]
			local fireAt = ATTACK_FIRE_DELAY + VOLLEY_GAP * i
			self:Timer(fireAt - ORB_AIM_LEAD, function()
				if seq ~= self.sequence or not IsValidAlive(nil, caster) then
					return
				end
				local orb = self.orbs[slot + 1]
				if not orb then
					return
				end
				local aimPos = self:resolveTargetPosition(caster)
				local direction = self:getDirectionTo(orb.pos, aimPos)
				caster:SetForwardVector(self:getDirectionTo(caster:GetAbsOrigin(), aimPos))
				self:warnOrbTrajectory(caster, slot, direction, ORB_AIM_LEAD + 0.05)
			end)
			self:Timer(fireAt, function()
				if seq ~= self.sequence or not IsValidAlive(nil, caster) then
					return
				end
				self:launchOrb(caster, slot)
			end)
			i = i + 1
		end
	end
	self:Timer(ATTACK_FIRE_DELAY + VOLLEY_GAP * (#slots - 1) + ATTACK_SETTLE_DELAY, function()
		if seq ~= self.sequence or not IsValidAlive(nil, caster) then
			return
		end
		local ____opt_11 = self:ensureAnimModifier(caster)
		if ____opt_11 ~= nil then
			____opt_11:SetAnimation(CHARGE_ACTIVITY, true)
		end
	end)
end
function elite_328.prototype.launchOrb(self, caster, slot)
	local orb = self.orbs[slot + 1]
	self.orbs[slot + 1] = nil
	if not orb then
		return
	end
	ParticleManager:DestroyParticle(orb.pfx, false)
	ParticleManager:ReleaseParticleIndex(orb.pfx)
	local direction = orb.direction
	if not direction then
		local target = self:getLockedTarget() or self:FindTarget()
		if IsValidAlive(nil, target) then
			direction = self:getDirectionTo(orb.pos, target:GetAbsOrigin())
		else
			local forward = caster:GetForwardVector()
			direction = Vector(forward.x, forward.y, 0):Normalized()
		end
	end
	EmitSoundOn(ORB_LAUNCH_SOUND, caster)
	print("[elite_328] 发射火球 slot=" .. tostring(slot))
	local flyDirection = direction
	local lastWaveTime = 0
	CreateProjectile(nil, {
		projectile_type = "linear",
		effect_name = ORB_FLY_PARTICLE,
		projectile_speed = ORB_PROJECTILE_SPEED,
		caster = caster,
		ability = self,
		start_point = orb.pos,
		direction = direction,
		projectile_distance = ORB_MAX_DISTANCE,
		projectile_range = ORB_HIT_RADIUS,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget, location)
			self:explodeAt(caster, location, hitTarget)
			return true
		end,
	})
end
function elite_328.prototype.explodeAt(self, caster, location, directTarget)
	if not IsValidAlive(nil, caster) then
		return
	end
	local groundPos = GetGroundPosition(location, caster)
	local impact = ParticleManager:CreateParticle(ORB_IMPACT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(impact, 0, groundPos)
	ParticleManager:ReleaseParticleIndex(impact)
	EmitSoundOnLocationWithCaster(groundPos, ORB_IMPACT_SOUND, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		groundPos,
		nil,
		ORB_AOE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local ____print_15 = print
	local ____temp_14 = #enemies
	local ____directTarget_13
	if directTarget then
		____directTarget_13 = directTarget:GetUnitName()
	else
		____directTarget_13 = "none"
	end
	____print_15(
		(("[elite_328] 火球爆炸 命中数=" .. tostring(____temp_14)) .. " 直击=") .. ____directTarget_13
	)
	local hitSet = __TS__New(Set)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue64
			end
			hitSet:add(enemy:GetEntityIndex())
			caster:MonsterDamage({ victim = enemy, damage_rate = ORB_DAMAGE_RATE, ability = self })
		end
		::__continue64::
	end
	if directTarget and IsValidAlive(nil, directTarget) and not hitSet:has(directTarget:GetEntityIndex()) then
		caster:MonsterDamage({ victim = directTarget, damage_rate = ORB_DAMAGE_RATE, ability = self })
	end
end
function elite_328.prototype.warnOrbTrajectory(self, caster, slot, direction, duration)
	local orb = self.orbs[slot + 1]
	if not orb then
		return
	end
	orb.direction = direction
	local start = GetGroundPosition(orb.pos, caster)
	local ____end = GetGroundPosition(start:__add(direction:__mul(ORB_MAX_DISTANCE)), caster)
	self:WarningEffect(start, ____end, duration, { startWidth = WARNING_LINE_WIDTH, endWidth = WARNING_LINE_WIDTH })
end
function elite_328.prototype.resolveTargetPosition(self, caster)
	local target = self:getLockedTarget() or self:FindTarget()
	if IsValidAlive(nil, target) then
		return GetGroundPosition(target:GetAbsOrigin(), target)
	end
	return GetGroundPosition(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(600)), caster)
end
function elite_328.prototype.FindTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(SEARCH_RANGE)
end
function elite_328.prototype.getLockedTarget(self)
	if self.lockedTargetIndex == nil then
		return nil
	end
	local target = EntIndexToHScript(self.lockedTargetIndex)
	local ____IsValidAlive_result_16
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_16 = target
	else
		____IsValidAlive_result_16 = nil
	end
	return ____IsValidAlive_result_16
end
function elite_328.prototype.getDirectionTo(self, start, ____end)
	local direction = Vector(____end.x - start.x, ____end.y - start.y, 0)
	if direction:Length2D() <= 0.01 then
		return Vector(1, 0, 0)
	end
	return direction:Normalized()
end
function elite_328.prototype.onCleanup(self)
	self.sequence = self.sequence + 1
	self.lockedTargetIndex = nil
	local caster = self:GetCaster()
	if IsValid(nil, caster) and not caster:IsNull() then
		caster:FadeGesture(ACT_DOTA_CAST_FENCE)
		modifier_elite_328_animation:remove(caster)
		caster:RemoveModifierByName("modifier_monster_cast_pre_progress")
	end
	self:clearOrbs()
	self:StartCooldown(self:GetCooldown(self:GetLevel() - 1))
end
function elite_328.prototype.clearOrbs(self)
	do
		local i = 0
		while i < ORB_TOTAL do
			do
				local orb = self.orbs[i + 1]
				if not orb then
					goto __continue81
				end
				ParticleManager:DestroyParticle(orb.pfx, false)
				ParticleManager:ReleaseParticleIndex(orb.pfx)
				self.orbs[i + 1] = nil
			end
			::__continue81::
			i = i + 1
		end
	end
	self.orbs = {}
end
elite_328 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_328)
--- 动画覆盖 modifier：技能演出期间强制播放指定动作（OVERRIDE_ANIMATION 优先级高于 idle 状态机，
-- boss_beast_1 等活怪实证可靠）。
-- 重要：动画函数在客户端查询，普通字段不跨端同步——activity 与慢放标记编码进 StackCount
-- （引擎自动同步字段，CLAUDE.md 的 GetStackCount 范式）：stack = activity * 10 + (慢放 ? 1 : 0)
modifier_elite_328_animation = __TS__Class()
modifier_elite_328_animation.name = "modifier_elite_328_animation"
__TS__ClassExtends(modifier_elite_328_animation, MonsterModifier_CS)
function modifier_elite_328_animation.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(ACT_DOTA_CAST_FENCE * 10)
end
function modifier_elite_328_animation.prototype.SetAnimation(self, activity, slow)
	if not IsServer() then
		return
	end
	self:SetStackCount(activity * 10 + (slow and 1 or 0))
end
function modifier_elite_328_animation.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
function modifier_elite_328_animation.prototype.GetOverrideAnimation(self)
	local stack = self:GetStackCount()
	if stack <= 0 then
		return ACT_DOTA_CAST_FENCE
	end
	return math.floor(stack / 10)
end
function modifier_elite_328_animation.prototype.GetOverrideAnimationRate(self)
	return self:GetStackCount() % 10 == 1 and STAND_ANIM_RATE or 1
end
function modifier_elite_328_animation.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_DISARMED] = true }
end
function modifier_elite_328_animation.prototype.IsHidden(self)
	return true
end
function modifier_elite_328_animation.prototype.IsPurgable(self)
	return false
end
function modifier_elite_328_animation.prototype.IsDebuff(self)
	return false
end
modifier_elite_328_animation =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_328_animation") }, modifier_elite_328_animation)
--- AI 思考间隔(秒)
local AI_THINK_INTERVAL = 0.25
--- 后撤触发距离：最近敌人进入该范围即向反方向后撤
local RETREAT_TRIGGER_RANGE = 600
--- 单次后撤移动指令的步长
local RETREAT_STEP = 500
--- 施放尝试的最小间隔(秒)：覆盖前摇期，防止 think 高频重复下施法指令
local CAST_RETRY_INTERVAL = CHARGE_DURATION + 0.5
--- 专属 AI（攻城车 elite_210 范式，去掉其风筝移速加成）：
-- 禁普攻；技能就绪且有目标 → 立即施放；CD 期间最近敌人进入 600 码 → 以原生移速向反方向后撤
local modifier_elite_328_ai = __TS__Class()
modifier_elite_328_ai.name = "modifier_elite_328_ai"
__TS__ClassExtends(modifier_elite_328_ai, BaseModifier)
function modifier_elite_328_ai.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self.lastCastAttempt = 0
end
function modifier_elite_328_ai.prototype.IsHidden(self)
	return true
end
function modifier_elite_328_ai.prototype.IsPurgable(self)
	return false
end
function modifier_elite_328_ai.prototype.RemoveOnDeath(self)
	return true
end
function modifier_elite_328_ai.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.lastCastAttempt = 0
	self:StartIntervalThink(AI_THINK_INTERVAL)
end
function modifier_elite_328_ai.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
function modifier_elite_328_ai.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local ____temp_19 = parent:IsStunned()
	if not ____temp_19 then
		local ____opt_17 = parent.IsMonsterCasting
		____temp_19 = (____opt_17 and ____opt_17(parent)) == true
	end
	if ____temp_19 then
		return
	end
	local target = parent:GetMinDistanceUnit(SEARCH_RANGE)
	if not target or not IsValidAlive(nil, target) then
		return
	end
	local ability = parent:FindAbilityByName("elite_328")
	if ability and not ability:IsNull() and ability:IsCooldownReady() then
		local now = GameRules:GetGameTime()
		if now - self.lastCastAttempt < CAST_RETRY_INTERVAL then
			return
		end
		self.lastCastAttempt = now
		parent:Stop()
		Timers:CreateTimer(0.1, function()
			if not IsValidAlive(nil, parent) then
				return
			end
			local ____temp_22 = parent:IsStunned()
			if not ____temp_22 then
				local ____opt_20 = parent.IsMonsterCasting
				____temp_22 = (____opt_20 and ____opt_20(parent)) == true
			end
			if ____temp_22 then
				return
			end
			local ab = parent:FindAbilityByName("elite_328")
			if ab and not ab:IsNull() and ab:IsCooldownReady() then
				parent:CastAbilityNoTarget(ab, parent:GetPlayerOwnerID())
			end
		end)
		return
	end
	if GetDistance(nil, parent:GetAbsOrigin(), target:GetAbsOrigin()) <= RETREAT_TRIGGER_RANGE then
		local away = parent:GetAbsOrigin():__sub(target:GetAbsOrigin())
		local flat = Vector(away.x, away.y, 0)
		local ____temp_23
		if flat:Length2D() > 0.01 then
			____temp_23 = flat:Normalized()
		else
			____temp_23 = parent:GetForwardVector()
		end
		local dir = ____temp_23
		parent:MoveToPosition(parent:GetAbsOrigin():__add(dir:__mul(RETREAT_STEP)))
	end
end
modifier_elite_328_ai = __TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_328_ai") }, modifier_elite_328_ai)
return ____exports