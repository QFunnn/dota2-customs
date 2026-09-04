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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
--- 施法距离（AI 追到此距离内才放）
local CAST_RANGE = 700
--- 前摇时长（白圈亮起+蓄力仪式，可打断）
local CAST_POINT = 1.5
--- 安全圈可视半径（白圈=判定承诺：站进来绝对不吃激光；用户三轮裁决 350→250→200→150）
local SAFE_RADIUS = 150
--- 圈心到 Boss 的距离（用户裁决"不能离 boss 太近"——圈缩小后近缘离 Boss 400，看守感更足）
local D_BOSS = 650
--- 排布切换阈值：被点名玩家距 Boss ≥此值→圈落 Boss 与他之间；<此值（贴脸白嫖位）→圈落 Boss 背后
local PLACEMENT_SWITCH_DIST = 1000
--- 激光臂视觉根部半径（绳粒子 CP0）：往圈内缩一段，吸收绳状粒子的端点缩进+相机透视错位，
-- 让激光第一粒恰好显示在白圈边缘=真"挂在圈上"（实测标定：根悬空→加大内缩；伸进圈内→减小）。
-- ⚠️只影响视觉；判定起点由 ARM_JUDGE_RADIUS 锚定、弦公式自动适配，安全性不受此值影响
local ARM_ROOT_RADIUS = SAFE_RADIUS - 10
--- 判定线到圈心的最小距离（=圈半径+210 margin，随 SAFE_RADIUS 联动）。
-- ⚠️调参红线：margin 210 按判定宽最坏语义设防，宽度语义实测前不许下调
local ARM_JUDGE_RADIUS = SAFE_RADIUS + 210
--- 激光臂数量（参考图密度定档；观感/性能降档改这一个数）
local ARM_COUNT = 12
--- 挂点抖动（±度）：30° 均分基础上的乱网感；上限保最窄缝 ≥14°（评审玩法席红线）
local MOUNT_JITTER_DEG = 8
--- 臂方向偏斜（±度）：径向基础上的乱角度；>15° 近圈视觉交叉破坏"从圈长出"语法
local DEV_ANGLE_MAX_DEG = 12
--- 臂长随机区间（从挂点起算；臂尖距圈心约 1410~1610）
local ARM_LEN_MIN = 1050
local ARM_LEN_MAX = 1250
--- 匀速转速（度/秒，顺时针——用户点名）；60°/s×6s=整 360° 一圈，收轮自带完成感
local ROT_SPEED_DEG = 60
--- 绞杀期时长（判定开启后转整一圈）
local SPIN_TIME = 6
--- 预警期时长（红线预旋转+玩家跑图窗口；总预警=castPoint 1.5+此值=4.0s，覆盖对角最坏跑距）
local WARN_TIME = 2.5
--- 红线依次弹出间隔（12 道 ~0.96s 挂满，之后继续预旋转到实体化）
local SPAWN_STAGGER = 0.08
--- 末班车提示时长（实体化前最后 N 秒：圈缘脉冲+音效催促）
local LASTCALL_TIME = 1
--- 末班车脉冲间隔
local LASTCALL_PULSE_INTERVAL = 0.33
--- 收轮时长（旋转结束臂长缩回圈边）
local RETRACT_TIME = 0.25
--- 光轮全程时长（modifier 自治相位机总长；duration 兜底另给 +1.0 余量）
local FIELD_TOTAL = WARN_TIME + SPIN_TIME + RETRACT_TIME
--- 释放锁定总时长（怪站桩）：略长于光轮全程
local CAST_DURATION = FIELD_TOTAL + 0.3
--- Boss 全程减伤（%）——站桩活靶子的保护（用户裁决替代弱点窗）。
-- ⚠️DOT/HP_LOSS 不进 PRE_APPLY 回流=对点燃流血流无效（管线 by design）
local GUARD_PCT = 50
--- 每跳伤害系数（播测偏软调 rate 1.25~1.5，不提转速不动钳——评审玩法席旋钮纪律）
local BEAM_DMG_RATE = 1
--- 同一目标命中冷却（每臂独立）
local BEAM_HIT_CD = 0.4
--- 同一目标同一冷却窗内最多结算臂数（公平钳=穿带抢救窗的承重墙，评审定档 2 不放宽）
local MAX_HITS_PER_WINDOW = 2
--- 光轮 tick（旋转激光高频推端点+判定；elite_324 同款）
local THINK_INTERVAL = 0.03
--- 激光判定宽度（与预警线同宽，项目铁配对）
local BEAM_WIDTH = 180
--- 激光视觉离地高度（贴地：本技能语义="挂在地上的圈"；85 的空中光刃感会与贴地白圈透视错位）
local BEAM_HEIGHT = 40
--- 锁场：施法瞬间快照半径 → 钳进战场半径（圆心=圈心；Boss 距圈心 650 必被罩住）。
-- ⚠️禁全场瞬拽——快照外的远人接受白站
local CAGE_SNAPSHOT_RADIUS = 1800
local CAGE_RADIUS = 1400
--- 锁场补挂节流（对中途新进 1400 的人补挂，防反复横跳白嫖）
local CAGE_RECHECK_INTERVAL = 0.5
--- 姿态重播间隔（施法期姿态=versus_attack1 对峙叫阵，用户指定；非循环动作周期重播防"巨怪发呆"。
-- ⚠️versus 动作时长未实测——若出现姿态空窗发呆，缩短此值到动作实际时长
local GESTURE_REFRESH = 4.8
--- 白圈"回应性脉冲"的短命叠圈寿命（末班车/实体化/收轮时圈亮一下）
local RING_PULSE_LIFE = 0.4
--- 被打断后的快速再试 CD（完整放完才吃满额；分级 CD 惯例）
local CD_RETRY = 5
--- 实体激光束（elite_324 三层过曝紫白：CP0/CP1 每帧推端点=旋转；寿命 30s，
-- ⚠️销毁必须 DestroyParticle(pfx, true) 硬删）
local LASER_PARTICLE = "particles/dd/elite_324_laser.vpcf"
--- 旋转预警细线（克隆版单层细芯红色——项目文法"红线=预警可以踩"；同样每帧跟转/必须硬删）
local WARNLINE_PARTICLE = "particles/dd/elite_325_warnline.vpcf"
--- 安全圈=反转配色的预警圈（用户定稿："就是个预警圈，只是反过来——圈里面白色（安全），
-- 外面红色（危险=12 道旋转红线）"）。复用项目预警圈粒子（全项目在用零风险）：
-- CP0=圈心 CP1=(半径,0,收缩速度=0 恒定) CP2=(边线寿命,0,0)⚠️clamp 10s CP15=颜色（白）。
-- 填充盘 _b 永生到 destroy（endcap 淡出 0.1s），边线 _c 寿命吃 CP2.x
local SAFE_RING_PARTICLE = "particles/monster/ability_warning_ring.vpcf"
--- 安全圈颜色：白色（反转预警语义——全项目预警圈都是黄→红，唯独这个圈是白=活路）
local SAFE_RING_COLOR = Vector(0.75, 0.75, 0.75)
--- 蓄力身体星云（谜团本体 ambient）
local CHARGE_MIST_PARTICLE = "particles/units/heroes/hero_enigma/enigma_ambient_body.vpcf"
--- 激光音效（红线弹出的节拍 tick 与实体化重音共用 bank）
local LASER_SOUND = "Hero_Tinker.Laser"
--- 场地 modifier 名（技能挂/打断移除；elite_322 双 gate 按此名 grep）
local FIELD_MODIFIER = "modifier_elite_325_field"
--- 点名/首臂方位的搜人半径
local CAST_SNAPSHOT_SEARCH = CAST_RANGE + 500
--- 事件视界：场地独立落圈+12 道乱角度激光随圈旋转绞杀圈外，唯圈内是净土；Boss 全程减伤看守
____exports.elite_325 = __TS__Class()
local elite_325 = ____exports.elite_325
elite_325.name = "elite_325"
__TS__ClassExtends(elite_325, MonsterAbility_CS)
function elite_325.prototype.Precache(self, context)
	PrecacheResource("particle", LASER_PARTICLE, context)
	PrecacheResource("particle", WARNLINE_PARTICLE, context)
	PrecacheResource("particle", SAFE_RING_PARTICLE, context)
	PrecacheResource("particle", CHARGE_MIST_PARTICLE, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_tinker.vsndevts", context)
end
function elite_325.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_DISABLED,
		castProgressBarColor = "blue",
		castColor = Vector(150, 60, 255),
		OnPhaseStart = function()
			return self:onChargeStart()
		end,
		OnStart = function()
			return self:onFieldStart()
		end,
		OnInterrupt = function()
			self._interrupted = true
			local c = self:GetCaster()
			if IsValid(nil, c) and not c:IsNull() then
				c:RemoveModifierByName(FIELD_MODIFIER)
			end
			self:cleanupCastFx()
		end,
		OnFinish = function()
			local fullRun = self._fieldStarted == true and self._interrupted ~= true
			self._fieldStarted = nil
			self._interrupted = nil
			self:cleanupCastFx()
			local full = self:GetCooldown(self:GetLevel() - 1)
			if fullRun then
				if full > 0 then
					self:StartCooldown(full)
				end
			else
				Timers:CreateTimer(0.01, function()
					if not IsValid(nil, self) or self:IsNull() then
						return
					end
					self:EndCooldown()
					self:StartCooldown(math.min(CD_RETRY, full))
				end)
			end
		end,
	}
end
function elite_325.prototype.onChargeStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local center = self:pickFieldCenter(caster)
	self._center = center
	local startAngle = 90
	local target = self:GetMinDistanceUnit(CAST_SNAPSHOT_SEARCH)
	if target and IsValidAlive(nil, target) then
		local rel = target:GetAbsOrigin():__sub(center)
		if rel:Length2D() > 1 then
			startAngle = math.atan2(rel.y, rel.x) * 180 / math.pi
		end
	end
	self._startAngle = startAngle
	local ring = ParticleManager:CreateParticle(SAFE_RING_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleShouldCheckFoW(ring, false)
	ParticleManager:SetParticleControl(ring, 0, center)
	ParticleManager:SetParticleControl(ring, 1, Vector(SAFE_RADIUS, 0, 0))
	ParticleManager:SetParticleControl(ring, 2, Vector(CAST_POINT + 0.5, 0, 0))
	ParticleManager:SetParticleControl(ring, 15, SAFE_RING_COLOR)
	local mist = ParticleManager:CreateParticle(CHARGE_MIST_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	self._chargePfx = { ring, mist }
	caster:EmitSound("Hero_Enigma.Demonic_Conversion")
end
function elite_325.prototype.pickFieldCenter(self, caster)
	local bossPos = GetGroundPosition(caster:GetAbsOrigin(), nil)
	local heroes = FindUnitsInRadius(
		caster:GetTeamNumber(),
		bossPos,
		nil,
		CAGE_SNAPSHOT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local alive = {}
	for ____, h in ipairs(heroes) do
		if IsValidAlive(nil, h) then
			alive[#alive + 1] = h
		end
	end
	if #alive == 0 then
		return bossPos
	end
	local anchor = alive[RandomInt(0, #alive - 1) + 1]
	local anchorPos = anchor:GetAbsOrigin()
	local rel = anchorPos:__sub(bossPos)
	local dPB = rel:Length2D()
	local ____temp_0
	if dPB > 1 then
		____temp_0 = rel:Normalized()
	else
		____temp_0 = Vector(1, 0, 0)
	end
	local dir = ____temp_0
	if dPB < PLACEMENT_SWITCH_DIST then
		dir = dir:__mul(-1)
	end
	local baseAngle = math.atan2(dir.y, dir.x)
	local offsets = {
		0,
		30,
		-30,
		60,
		-60,
		90,
		-90,
		120,
		-120,
		150,
		-150,
		180,
	}
	for ____, off in ipairs(offsets) do
		local a = baseAngle + math.rad(off)
		local c = GetGroundPosition(bossPos:__add(Vector(math.cos(a) * D_BOSS, math.sin(a) * D_BOSS, 0)), nil)
		if IsGridNavDisplacementWalkable(nil, c) and GridNav:CanFindPath(anchorPos, c) then
			return c
		end
	end
	return bossPos
end
function elite_325.prototype.onFieldStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:cleanupCastFx()
	self._fieldStarted = true
	local center = self._center or GetGroundPosition(caster:GetAbsOrigin(), nil)
	local toRing = center:__sub(caster:GetAbsOrigin())
	if toRing:Length2D() > 1 then
		caster:SetForwardVector(toRing:Normalized())
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_VERSUS, 1)
	caster:EmitSound("Hero_Enigma.Demonic_Conversion")
	caster:AddNewModifier(
		caster,
		self,
		FIELD_MODIFIER,
		{ duration = FIELD_TOTAL + 1, cx = center.x, cy = center.y, start_angle = self._startAngle or 90 }
	)
end
function elite_325.prototype.cleanupCastFx(self)
	local list = self._chargePfx
	if list then
		self._chargePfx = nil
		for ____, pfx in ipairs(list) do
			ParticleManager:DestroyParticle(pfx, false)
			ParticleManager:ReleaseParticleIndex(pfx)
		end
	end
	local c = self:GetCaster()
	if IsValidAlive(nil, c) then
		c:FadeGesture(ACT_DOTA_VERSUS)
	end
end
elite_325 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_325)
____exports.elite_325 = elite_325
local modifier_elite_325_field = __TS__Class()
modifier_elite_325_field.name = "modifier_elite_325_field"
__TS__ClassExtends(modifier_elite_325_field, BaseModifier)
function modifier_elite_325_field.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self.phase = "warn"
	self.t = 0
	self.lastT = 0
	self.cx = 0
	self.cy = 0
	self.angle = 90
	self.arms = {}
	self.spawnedCount = 0
	self.tempFx = {}
	self.nextGestureAt = 0
	self.nextLastcallAt = 0
	self.cageAcc = 0
	self.cagedUnits = {}
	self.windowHits = {}
end
function modifier_elite_325_field.prototype.IsHidden(self)
	return true
end
function modifier_elite_325_field.prototype.IsPurgable(self)
	return false
end
function modifier_elite_325_field.prototype.IsDebuff(self)
	return false
end
function modifier_elite_325_field.prototype.RemoveOnDeath(self)
	return true
end
function modifier_elite_325_field.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	self.cx = kv.cx or 0
	self.cy = kv.cy or 0
	self.angle = kv.start_angle or 90
	self.lastT = GameRules:GetGameTime()
	self.nextGestureAt = self.lastT + GESTURE_REFRESH
	local center = self:center()
	local caster = self:GetParent()
	self.safeRing = self:createSafeRing(center, FIELD_TOTAL + 1)
	do
		local i = 0
		while i < ARM_COUNT do
			local dev = RandomFloat(-DEV_ANGLE_MAX_DEG, DEV_ANGLE_MAX_DEG)
			local devRad = math.rad(dev)
			local sinDev = math.sin(devRad)
			local judgeOffset = -ARM_ROOT_RADIUS * math.cos(devRad)
				+ math.sqrt(ARM_JUDGE_RADIUS * ARM_JUDGE_RADIUS - ARM_ROOT_RADIUS * ARM_ROOT_RADIUS * sinDev * sinDev)
			local ____self_arms_1 = self.arms
			____self_arms_1[#____self_arms_1 + 1] = {
				mountOffset = i * 360 / ARM_COUNT + RandomFloat(-MOUNT_JITTER_DEG, MOUNT_JITTER_DEG),
				devAngle = dev,
				armLen = RandomFloat(ARM_LEN_MIN, ARM_LEN_MAX),
				judgeOffset = judgeOffset,
				hitCd = {},
			}
			i = i + 1
		end
	end
	self:cageAll(center, CAGE_SNAPSHOT_RADIUS)
	caster:AddNewModifier(caster, self:GetAbility(), "modifier_elite_325_guard", { duration = FIELD_TOTAL + 1 })
	print((("[elite_325] field created: arms=" .. tostring(ARM_COUNT)) .. " caged=") .. tostring(#self.cagedUnits))
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_elite_325_field.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:destroyArms()
	if self.safeRing ~= nil then
		ParticleManager:DestroyParticle(self.safeRing, true)
		ParticleManager:ReleaseParticleIndex(self.safeRing)
		self.safeRing = nil
	end
	for ____, f in ipairs(self.tempFx) do
		ParticleManager:DestroyParticle(f.pfx, false)
		ParticleManager:ReleaseParticleIndex(f.pfx)
	end
	self.tempFx = {}
	for ____, unit in ipairs(self.cagedUnits) do
		if IsValid(nil, unit) and not unit:IsNull() then
			unit:RemoveModifierByName("modifier_elite_325_cage")
		end
	end
	self.cagedUnits = {}
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveModifierByName("modifier_elite_325_guard")
		parent:FadeGesture(ACT_DOTA_VERSUS)
	end
	print("[elite_325] field destroyed")
end
function modifier_elite_325_field.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local now = GameRules:GetGameTime()
	local dt = now - self.lastT
	self.lastT = now
	self.t = self.t + dt
	if now >= self.nextGestureAt then
		self.nextGestureAt = now + GESTURE_REFRESH
		parent:FadeGesture(ACT_DOTA_VERSUS)
		parent:StartGestureWithPlaybackRate(ACT_DOTA_VERSUS, 1)
	end
	if #self.tempFx > 0 then
		local kept = {}
		for ____, f in ipairs(self.tempFx) do
			if now >= f.killAt then
				ParticleManager:DestroyParticle(f.pfx, false)
				ParticleManager:ReleaseParticleIndex(f.pfx)
			else
				kept[#kept + 1] = f
			end
		end
		self.tempFx = kept
	end
	self.angle = self.angle - ROT_SPEED_DEG * dt
	if self.phase == "warn" then
		while self.spawnedCount < ARM_COUNT and self.t >= self.spawnedCount * SPAWN_STAGGER do
			self:spawnArm(parent, self.spawnedCount, WARNLINE_PARTICLE, self.spawnedCount % 3 == 0)
			self.spawnedCount = self.spawnedCount + 1
		end
		self:updateArms(false, 1, now, parent)
		if self.t >= WARN_TIME - LASTCALL_TIME and now >= self.nextLastcallAt then
			if self.nextLastcallAt == 0 then
				parent:EmitSound("Hero_Enigma.Demonic_Conversion")
			end
			self.nextLastcallAt = now + LASTCALL_PULSE_INTERVAL
			self:pulseSafeRing(now)
		end
		if self.t >= WARN_TIME then
			self.phase = "spin"
			self:destroyArms()
			do
				local i = 0
				while i < ARM_COUNT do
					self:spawnArm(parent, i, LASER_PARTICLE, false)
					i = i + 1
				end
			end
			self:updateArms(false, 1, now, parent)
			parent:EmitSound(LASER_SOUND)
			parent:EmitSound("Hero_Enigma.Demonic_Conversion")
			self:pulseSafeRing(now)
			ScreenShake(self:center(), 10, 10, 0.4, CAGE_RADIUS + 600, 0, true)
			print(("[elite_325] materialized at angle=" .. tostring(math.floor(self.angle))) .. ", grinding begins")
		end
	elseif self.phase == "spin" then
		self:updateArms(true, 1, now, parent)
		if self.t >= WARN_TIME + SPIN_TIME then
			self.phase = "retract"
			parent:EmitSound("Hero_Enigma.Demonic_Conversion")
			self:pulseSafeRing(now)
			print("[elite_325] spin done, retracting")
		end
	else
		local rt = self.t - (WARN_TIME + SPIN_TIME)
		local lenScale = math.max(0, 1 - rt / RETRACT_TIME)
		self:updateArms(false, lenScale, now, parent)
		if rt >= RETRACT_TIME then
			print("[elite_325] retract done, self-destruct")
			self:Destroy()
			return
		end
	end
	self.cageAcc = self.cageAcc + dt
	if self.cageAcc >= CAGE_RECHECK_INTERVAL then
		self.cageAcc = 0
		self:cageAll(self:center(), CAGE_RADIUS)
	end
end
function modifier_elite_325_field.prototype.spawnArm(self, parent, i, particle, tickSound)
	local slot = self.arms[i + 1]
	if slot.pfx ~= nil then
		return
	end
	local axis = self:center():__add(Vector(0, 0, BEAM_HEIGHT))
	if not IsValidAlive(nil, parent) then
		return
	end
	local p = ParticleManager:CreateParticle(particle, PATTACH_WORLDORIGIN, parent)
	ParticleManager:SetParticleControl(p, 0, axis)
	ParticleManager:SetParticleControl(p, 1, axis)
	slot.pfx = p
	if tickSound then
		parent:EmitSound(LASER_SOUND)
	end
end
function modifier_elite_325_field.prototype.updateArms(self, judge, lenScale, now, parent)
	local center = self:center()
	do
		local i = 0
		while i < ARM_COUNT do
			do
				local slot = self.arms[i + 1]
				if slot.pfx == nil then
					goto __continue76
				end
				local mountRad = math.rad(self.angle + slot.mountOffset)
				local dirRad = mountRad + math.rad(slot.devAngle)
				local mx = center.x + math.cos(mountRad) * ARM_ROOT_RADIUS
				local my = center.y + math.sin(mountRad) * ARM_ROOT_RADIUS
				local dx = math.cos(dirRad)
				local dy = math.sin(dirRad)
				local len = slot.armLen * lenScale
				local rootGround = GetGroundPosition(Vector(mx, my, 0), nil)
				local tipGround = GetGroundPosition(Vector(mx + dx * len, my + dy * len, 0), nil)
				ParticleManager:SetParticleControl(slot.pfx, 0, rootGround:__add(Vector(0, 0, BEAM_HEIGHT)))
				ParticleManager:SetParticleControl(slot.pfx, 1, tipGround:__add(Vector(0, 0, BEAM_HEIGHT)))
				if not judge then
					goto __continue76
				end
				local judgeFrom =
					GetGroundPosition(Vector(mx + dx * slot.judgeOffset, my + dy * slot.judgeOffset, 0), nil)
				if not IsValidAlive(nil, parent) then
					goto __continue76
				end
				local enemies = FindUnitsInLine(
					parent:GetTeamNumber(),
					judgeFrom,
					tipGround,
					nil,
					BEAM_WIDTH,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
					DOTA_UNIT_TARGET_FLAG_NONE
				)
				for ____, enemy in ipairs(enemies) do
					do
						if not IsValidAlive(nil, enemy) then
							goto __continue80
						end
						local idx = enemy:entindex()
						if now < (slot.hitCd[idx] or 0) then
							goto __continue80
						end
						local win = self.windowHits[idx]
						if win == nil or now >= win["until"] then
							win = { ["until"] = now + BEAM_HIT_CD, count = 0 }
							self.windowHits[idx] = win
						end
						if win.count >= MAX_HITS_PER_WINDOW then
							goto __continue80
						end
						slot.hitCd[idx] = now + BEAM_HIT_CD
						win.count = win.count + 1
						parent:MonsterDamage({
							victim = enemy,
							damage_rate = BEAM_DMG_RATE,
							ability = self:GetAbility(),
						})
					end
					::__continue80::
				end
			end
			::__continue76::
			i = i + 1
		end
	end
end
function modifier_elite_325_field.prototype.destroyArms(self)
	for ____, slot in ipairs(self.arms) do
		if slot.pfx ~= nil then
			ParticleManager:DestroyParticle(slot.pfx, true)
			ParticleManager:ReleaseParticleIndex(slot.pfx)
			slot.pfx = nil
		end
	end
end
function modifier_elite_325_field.prototype.cageAll(self, center, radius)
	local caster = self:GetParent()
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue92
			end
			if enemy:HasModifier("modifier_elite_325_cage") then
				goto __continue92
			end
			enemy:AddNewModifier(
				caster,
				self:GetAbility(),
				"modifier_elite_325_cage",
				{ duration = FIELD_TOTAL + 1, cx = self.cx, cy = self.cy, radius = CAGE_RADIUS }
			)
			local ____self_cagedUnits_2 = self.cagedUnits
			____self_cagedUnits_2[#____self_cagedUnits_2 + 1] = enemy
		end
		::__continue92::
	end
end
function modifier_elite_325_field.prototype.createSafeRing(self, center, lifetime)
	local p = ParticleManager:CreateParticle(SAFE_RING_PARTICLE, PATTACH_WORLDORIGIN, self:GetParent())
	ParticleManager:SetParticleShouldCheckFoW(p, false)
	ParticleManager:SetParticleControl(p, 0, center)
	ParticleManager:SetParticleControl(p, 1, Vector(SAFE_RADIUS, 0, 0))
	ParticleManager:SetParticleControl(p, 2, Vector(lifetime, 0, 0))
	ParticleManager:SetParticleControl(p, 15, SAFE_RING_COLOR)
	return p
end
function modifier_elite_325_field.prototype.pulseSafeRing(self, now)
	local p = self:createSafeRing(self:center(), RING_PULSE_LIFE)
	local ____self_tempFx_3 = self.tempFx
	____self_tempFx_3[#____self_tempFx_3 + 1] = { pfx = p, killAt = now + RING_PULSE_LIFE }
end
function modifier_elite_325_field.prototype.center(self)
	return GetGroundPosition(Vector(self.cx, self.cy, 0), nil)
end
modifier_elite_325_field =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_325_field") }, modifier_elite_325_field)
--- 事件视界·锁场 debuff：高频位置钳制——到圈心距离超出 1400 立即拉回边界。
-- 锁的是【战场】不是安全圈（圈进出自由——"自愿朝圣"）；防跑出光轮臂长白嫖。
-- 不禁用任何技能；不可驱散；持有者死亡自动移除；场地 modifier 死亡时统一解除。
local modifier_elite_325_cage = __TS__Class()
modifier_elite_325_cage.name = "modifier_elite_325_cage"
__TS__ClassExtends(modifier_elite_325_cage, BaseModifier)
function modifier_elite_325_cage.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self.cx = 0
	self.cy = 0
	self.radius = CAGE_RADIUS
end
function modifier_elite_325_cage.prototype.IsHidden(self)
	return false
end
function modifier_elite_325_cage.prototype.IsDebuff(self)
	return true
end
function modifier_elite_325_cage.prototype.IsPurgable(self)
	return false
end
function modifier_elite_325_cage.prototype.RemoveOnDeath(self)
	return true
end
function modifier_elite_325_cage.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	self.cx = kv.cx or 0
	self.cy = kv.cy or 0
	self.radius = kv.radius or CAGE_RADIUS
	self:StartIntervalThink(0.03)
end
function modifier_elite_325_cage.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local pos = parent:GetAbsOrigin()
	local dx = pos.x - self.cx
	local dy = pos.y - self.cy
	local dist = math.sqrt(dx * dx + dy * dy)
	if dist > self.radius then
		local scale = (self.radius - 25) / dist
		local clamped = GetGroundPosition(Vector(self.cx + dx * scale, self.cy + dy * scale, pos.z), parent)
		FindClearSpaceForUnit(parent, clamped, true)
	end
end
modifier_elite_325_cage =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_325_cage") }, modifier_elite_325_cage)
--- 事件视界·视界守护（Boss 全程减伤）：光轮运转期间 Boss 站桩=活靶子，受到的攻击与技能伤害降低 50%。
-- victim 侧 ON_DAMAGE_PRE_APPLY 乘区（modifier_generic_vulnerable 同管线的镜像，自包含）。
-- ⚠️DOT/HP_LOSS 走 TryFinalizeEarly 不进 PRE_APPLY 回流——减伤对点燃/流血流无效（管线 by design）。
-- 与光轮同生共死：field OnCreated 挂上、OnDestroy 移除——打断=束断圈碎减伤即失。
local modifier_elite_325_guard = __TS__Class()
modifier_elite_325_guard.name = "modifier_elite_325_guard"
__TS__ClassExtends(modifier_elite_325_guard, BaseModifier_CS)
function modifier_elite_325_guard.GetLocalizationCN(self)
	return {
		name = "视界守护",
		description = ("事件视界运转中：受到的攻击与技能伤害降低" .. tostring(GUARD_PCT)) .. "%。",
	}
end
function modifier_elite_325_guard.prototype.IsHidden(self)
	return false
end
function modifier_elite_325_guard.prototype.IsDebuff(self)
	return false
end
function modifier_elite_325_guard.prototype.IsPurgable(self)
	return false
end
function modifier_elite_325_guard.prototype.RemoveOnDeath(self)
	return true
end
function modifier_elite_325_guard.prototype.GetTexture(self)
	return "enigma_midnight_pulse"
end
function modifier_elite_325_guard.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_elite_325_guard.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	if event.ctx.spec.victim ~= self:GetParent() then
		return
	end
	local ____event_final_4, ____mul_5 = event.final, "mul"
	if ____event_final_4[____mul_5] == nil then
		____event_final_4[____mul_5] = {}
	end
	local ____event_final_mul_6 = event.final.mul
	____event_final_mul_6[#____event_final_mul_6 + 1] =
		{ value = 1 - GUARD_PCT / 100, source = "modifier_elite_325_guard:视界守护" }
end
modifier_elite_325_guard =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_325_guard") }, modifier_elite_325_guard)
return ____exports