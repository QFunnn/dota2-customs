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
--- 施法距离（AI 追到此距离内才放；风车以自身为轴，贴近了才有威胁）
local CAST_RANGE = 700
--- 前摇时长（蓄力+双臂预警充能）
local CAST_POINT = 1.3
--- 激光臂长（旋转半径；1.55 倍体型巨怪配长臂才有压迫）
local WHEEL_RADIUS = 1200
--- 第一段起转前的静止展示（激光压在预警线上，可见不判定+从轴心弹出成形）
local WHEEL_WARMUP = 0.4
--- 第二段起转前的渐显（激光从轴心弹出+不判定——9 秒顺时针肌肉记忆后的反向缓冲，评审采纳）
local WHEEL_LEG2_WARMUP = 0.3
--- 单段旋转时长（用户调参：9 秒容错太多 → 7.8 秒）
local WHEEL_SPIN_TIME = 7.8
--- 单段总旋转角度（度）：位置驱动——每段精确转完此角度（用户定稿 270°），结束角恒定无积分漂移
local WHEEL_ARC = 270
--- 加速段占比：前 75% 一路加速，后 25% 快速刹车（"从慢到快，再短时间由快变慢"）
local WHEEL_ACCEL_RATIO = 0.75
--- ↓三个为曲线形状参数（相对值只定"慢快慢"形状，实际角速度由 WHEEL_ARC÷WHEEL_SPIN_TIME 归一化）
local WHEEL_START_SPEED = 55
--- 峰值相对速度（ease-in 平方爬到此值）
local WHEEL_PEAK_SPEED = 300
--- 刹车末端相对速度
local WHEEL_BRAKE_END_SPEED = 40
--- 段间隙：第一段吸回轴心→消失角度预警充能→第二段弹出再现（9 秒段长配 1.2s 反向缓冲，评审采纳）
local WHEEL_GAP = 1.2
--- 段末激光"吸回黑洞"的收束时长（间隙头部：臂长收缩到 0 再消失，湮灭主题演出）
local WHEEL_RETRACT_TIME = 0.25
--- 风车全程时长（modifier duration）= 静止展示 + 两段 + 间隙 + 第二段渐显
local WHEEL_TOTAL = WHEEL_WARMUP + WHEEL_SPIN_TIME * 2 + WHEEL_GAP + WHEEL_LEG2_WARMUP
--- 三道激光臂的长度比例（最长/中/短，1200/780/480——差距拉大但短臂仍罩住贴身圈，用户+评审定稿）
local ARM_LENGTH_RATIOS = { 1, 0.65, 0.4 }
--- 组内离散上限（度）：任一臂相对基准角的超前/滞后钳制——贴身圈恒有安全走廊的公平性保险丝（评审采纳）
local ARM_MAX_SPREAD = 40
--- 黑洞抬手姿态重播间隔（动作本体仅 5.4s，19s 释放期靠周期重播防"巨怪发呆"）
local GESTURE_REFRESH = 4.8
--- 每道臂的曲线形状随机区间（每段重掷）——🔑铁律：每道都整 WHEEL_SPIN_TIME 秒转完整 WHEEL_ARC 度，
-- 随机的只是"慢快慢"的节奏（早冲型 vs 晚爆型），中途拉开角度差、段末全部精确对齐
local ARM_ACCEL_MIN = 0.55
local ARM_ACCEL_MAX = 0.85
local ARM_PEAK_MIN = 220
local ARM_PEAK_MAX = 380
--- 被打断/前摇被掐后的快速再试 CD（完整放完才吃满额 CD；防止一次打断罚满导致风车久久不见）
local CD_RETRY = 5
--- 牢笼边界能量圈粒子（谜团午夜脉冲，半径=最长臂；已随 precacheUnits enigma 全局缓存）
local AXIS_RING_PARTICLE = "particles/units/heroes/hero_enigma/enigma_midnight_pulse.vpcf"
--- 风车每跳伤害系数
local WHEEL_DMG_RATE = 1
--- 同一目标命中冷却（激光扫过身体只吃一跳）
local WHEEL_HIT_CD = 0.4
--- 释放锁定总时长（怪站桩抬手）：略长于风车全程
local CAST_DURATION = WHEEL_TOTAL + 0.3
--- 激光判定宽度（与预警线同宽）
local LASER_WIDTH = 180
--- 激光束粒子（elite_324 专属持续光束：CP0=起点/轴心 CP1=终点/臂尖，超长寿命+每帧重排跟随端点）
-- ⚠️与 320/321 用的 tinker_laser（瞬发~1s）完全独立——改这份不影响前面技能
-- ⚠️销毁必须 DestroyParticle(pfx, true) 硬删——false 会让存量粒子按 30s 寿命残留
local LASER_PARTICLE = "particles/dd/elite_324_laser.vpcf"
--- 激光音效（每段起转时播）
local LASER_SOUND = "Hero_Tinker.Laser"
--- 蓄力身体星云（谜团本体 ambient，与 elite_320/321 同款；已验证存在+全局缓存）
local CHARGE_MIST_PARTICLE = "particles/units/heroes/hero_enigma/enigma_ambient_body.vpcf"
--- 激光视觉的离地高度
local BEAM_HEIGHT = 85
--- 风车 modifier 名（技能挂/打断移除）
local WHEEL_MODIFIER = "modifier_elite_324_wheel"
--- 慢→快→慢 旋转进度函数（解析积分归一化）：u=时间进度[0,1] → 已转角占比[0,1]。
-- 形状=前 r 段 ease-in 平方加速（START→peak），尾段平方刹车（peak→BRAKE_END）；
-- F(1)=1 恒成立 → 无论 r/peak 怎么随机，每段结束角都精确等于 起始角±WHEEL_ARC，无漂移。
--
-- @param r 加速段占比（随机化=早冲型 vs 晚爆型）
-- @param p 峰值相对速度（随机化=冲刺强度）
local function spinProgress(self, u, r, p)
	local s = WHEEL_START_SPEED
	local e = WHEEL_BRAKE_END_SPEED
	local total = s * r + (p - s) * r / 3 + e * (1 - r) + (p - e) * (1 - r) / 3
	local acc
	if u <= r then
		acc = s * u + (p - s) * u * u * u / (3 * r * r)
	else
		local w = (u - r) / (1 - r)
		local inv = 1 - w
		acc = s * r + (p - s) * r / 3 + (1 - r) * (e * w + (p - e) / 3 * (1 - inv * inv * inv))
	end
	return acc / total
end
--- 湮灭风车：两段双臂旋转激光（第一段顺时针加速→急刹消失，段间隙预警，第二段原位逆时针再来）
____exports.elite_324 = __TS__Class()
local elite_324 = ____exports.elite_324
elite_324.name = "elite_324"
__TS__ClassExtends(elite_324, MonsterAbility_CS)
function elite_324.prototype.Precache(self, context)
	PrecacheResource("particle", LASER_PARTICLE, context)
	PrecacheResource("particle", CHARGE_MIST_PARTICLE, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_tinker.vsndevts", context)
end
function elite_324.prototype.GetMosnterAbilityConfig(self)
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
			return self:onWheelStart()
		end,
		OnInterrupt = function()
			self._interrupted = true
			local c = self:GetCaster()
			if IsValid(nil, c) and not c:IsNull() then
				c:RemoveModifierByName(WHEEL_MODIFIER)
			end
			self:cleanupCastFx()
		end,
		OnFinish = function()
			local fullRun = self._wheelStarted == true and self._interrupted ~= true
			self._wheelStarted = nil
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
function elite_324.prototype.onChargeStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local center = GetGroundPosition(caster:GetAbsOrigin(), nil)
	self._center = center
	local dir = caster:GetForwardVector()
	local target = self:GetMinDistanceUnit(CAST_RANGE + 500)
	if target and IsValidAlive(nil, target) then
		local rel = target:GetAbsOrigin():__sub(center)
		if rel:Length2D() > 1 then
			dir = rel:Normalized()
		end
	end
	local startAngle = math.atan2(dir.y, dir.x) * 180 / math.pi
	self._startAngle = startAngle
	self:warnArms(center, startAngle, CAST_POINT + WHEEL_WARMUP - 0.05)
	local mist = ParticleManager:CreateParticle(CHARGE_MIST_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	self._chargePfx = { mist }
	caster:EmitSound("Hero_Enigma.Demonic_Conversion")
end
function elite_324.prototype.warnArms(self, center, angleDeg, duration)
	do
		local i = 0
		while i < 2 do
			local a = math.rad(angleDeg + i * 180)
			local d = Vector(math.cos(a), math.sin(a), 0)
			local tip = GetGroundPosition(center:__add(d:__mul(WHEEL_RADIUS)), nil)
			self:WarningEffect(center, tip, duration, { startWidth = LASER_WIDTH, endWidth = LASER_WIDTH })
			i = i + 1
		end
	end
end
function elite_324.prototype.onWheelStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:cleanupCastFx()
	self._wheelStarted = true
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1)
	caster:EmitSound("Hero_Enigma.Demonic_Conversion")
	local center = self._center or GetGroundPosition(caster:GetAbsOrigin(), nil)
	caster:AddNewModifier(
		caster,
		self,
		WHEEL_MODIFIER,
		{ duration = WHEEL_TOTAL + 1, cx = center.x, cy = center.y, start_angle = self._startAngle or 90 }
	)
end
function elite_324.prototype.cleanupCastFx(self)
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
		c:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
	end
end
elite_324 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_324)
____exports.elite_324 = elite_324
local modifier_elite_324_wheel = __TS__Class()
modifier_elite_324_wheel.name = "modifier_elite_324_wheel"
__TS__ClassExtends(modifier_elite_324_wheel, BaseModifier)
function modifier_elite_324_wheel.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self.phase = "leg1"
	self.t = 0
	self.angle = 90
	self.cx = 0
	self.cy = 0
	self.lastT = 0
	self.beams = {}
	self.legStartAngle = 90
	self.nextGestureAt = 0
	self.armCurves = {}
	self.cagedUnits = {}
	self.hitCd = {}
end
function modifier_elite_324_wheel.prototype.IsHidden(self)
	return true
end
function modifier_elite_324_wheel.prototype.IsPurgable(self)
	return false
end
function modifier_elite_324_wheel.prototype.IsDebuff(self)
	return false
end
function modifier_elite_324_wheel.prototype.RemoveOnDeath(self)
	return true
end
function modifier_elite_324_wheel.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	self.cx = kv.cx or 0
	self.cy = kv.cy or 0
	self.angle = kv.start_angle or 90
	self.legStartAngle = self.angle
	self.lastT = GameRules:GetGameTime()
	self.nextGestureAt = self.lastT + GESTURE_REFRESH
	local center = self:center()
	local caster = self:GetParent()
	local ring = ParticleManager:CreateParticle(AXIS_RING_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(ring, 0, center)
	ParticleManager:SetParticleControl(ring, 1, Vector(WHEEL_RADIUS, 0, 0))
	self.axisRing = ring
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		WHEEL_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue36
			end
			enemy:AddNewModifier(
				caster,
				self:GetAbility(),
				"modifier_elite_324_cage",
				{ duration = WHEEL_TOTAL + 1, cx = center.x, cy = center.y, radius = WHEEL_RADIUS }
			)
			local ____self_cagedUnits_0 = self.cagedUnits
			____self_cagedUnits_0[#____self_cagedUnits_0 + 1] = enemy
		end
		::__continue36::
	end
	self:spawnBeams()
	caster:EmitSound(LASER_SOUND)
	print(
		(("[elite_324] wheel created: leg1 start angle=" .. tostring(math.floor(self.angle))) .. " caged=")
			.. tostring(#self.cagedUnits)
	)
	self:StartIntervalThink(0.03)
end
function modifier_elite_324_wheel.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:destroyBeams()
	if self.axisRing ~= nil then
		ParticleManager:DestroyParticle(self.axisRing, false)
		ParticleManager:ReleaseParticleIndex(self.axisRing)
		self.axisRing = nil
	end
	for ____, unit in ipairs(self.cagedUnits) do
		if IsValid(nil, unit) and not unit:IsNull() then
			unit:RemoveModifierByName("modifier_elite_324_cage")
		end
	end
	self.cagedUnits = {}
	print("[elite_324] wheel destroyed")
end
function modifier_elite_324_wheel.prototype.OnIntervalThink(self)
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
		parent:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
		parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1)
	end
	if self.phase == "leg1" then
		self:tickSpin(-1, WHEEL_WARMUP, now, function()
			self.phase = "gap"
			self.t = 0
			parent:EmitSound("Hero_Enigma.Demonic_Conversion")
			local ability = self:GetAbility()
			if ability and not ability:IsNull() then
				ability:warnArms(self:center(), self.angle, WHEEL_GAP - 0.05)
			end
			print(("[elite_324] leg1 done at angle=" .. tostring(math.floor(self.angle))) .. ", gap begins")
		end)
	elseif self.phase == "gap" then
		if self.t < WHEEL_RETRACT_TIME then
			self:updateBeamsAndDamage(false, WHEEL_SPIN_TIME, -1, now, 1 - self.t / WHEEL_RETRACT_TIME)
		elseif #self.beams > 0 then
			self:destroyBeams()
		end
		if self.t >= WHEEL_GAP then
			self.phase = "leg2"
			self.t = 0
			self.hitCd = {}
			self.legStartAngle = self.angle
			self:spawnBeams()
			parent:EmitSound(LASER_SOUND)
			print("[elite_324] leg2 spawned at angle=" .. tostring(math.floor(self.angle)))
		end
	else
		self:tickSpin(1, WHEEL_LEG2_WARMUP, now, function()
			print("[elite_324] leg2 done, self-destruct")
			self:Destroy()
		end)
	end
end
function modifier_elite_324_wheel.prototype.tickSpin(self, dir, warmup, now, onDone)
	local spinT = self.t - warmup
	if spinT > 0 then
		local u = math.min(spinT / WHEEL_SPIN_TIME, 1)
		self.angle = self.legStartAngle + dir * WHEEL_ARC * spinProgress(nil, u, WHEEL_ACCEL_RATIO, WHEEL_PEAK_SPEED)
	end
	if spinT >= WHEEL_SPIN_TIME then
		onDone(nil)
		return
	end
	local ____temp_1
	if spinT < 0 and warmup > 0 then
		____temp_1 = 1 + spinT / warmup
	else
		____temp_1 = 1
	end
	local lenScale = ____temp_1
	self:updateBeamsAndDamage(spinT >= 0, spinT, dir, now, lenScale)
end
function modifier_elite_324_wheel.prototype.updateBeamsAndDamage(self, judge, spinT, dir, now, lenScale)
	local parent = self:GetParent()
	local center = self:center()
	local axis = center:__add(Vector(0, 0, BEAM_HEIGHT))
	local ____temp_2
	if spinT > 0 then
		____temp_2 = math.min(spinT / WHEEL_SPIN_TIME, 1)
	else
		____temp_2 = 0
	end
	local u = ____temp_2
	local scale = lenScale or 1
	do
		local j = 0
		while j < 3 do
			local curve = self.armCurves[j + 1] or { r = WHEEL_ACCEL_RATIO, p = WHEEL_PEAK_SPEED }
			local armAngle = self.legStartAngle + dir * WHEEL_ARC * spinProgress(nil, u, curve.r, curve.p)
			local spread = armAngle - self.angle
			if spread > ARM_MAX_SPREAD then
				armAngle = self.angle + ARM_MAX_SPREAD
			elseif spread < -ARM_MAX_SPREAD then
				armAngle = self.angle - ARM_MAX_SPREAD
			end
			local len = WHEEL_RADIUS * ARM_LENGTH_RATIOS[j + 1] * scale
			do
				local i = 0
				while i < 2 do
					do
						local a = math.rad(armAngle + i * 180)
						local armDir = Vector(math.cos(a), math.sin(a), 0)
						local tipGround = GetGroundPosition(center:__add(armDir:__mul(len)), nil)
						local beam = self.beams[i * 3 + j + 1]
						if beam ~= nil then
							ParticleManager:SetParticleControl(beam, 0, axis)
							ParticleManager:SetParticleControl(beam, 1, tipGround:__add(Vector(0, 0, BEAM_HEIGHT)))
						end
						if not judge then
							goto __continue65
						end
						if not IsValidAlive(nil, parent) then
							goto __continue65
						end
						local enemies = FindUnitsInLine(
							parent:GetTeamNumber(),
							center,
							tipGround,
							nil,
							LASER_WIDTH,
							DOTA_UNIT_TARGET_TEAM_ENEMY,
							DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
							DOTA_UNIT_TARGET_FLAG_NONE
						)
						for ____, enemy in ipairs(enemies) do
							do
								if not IsValidAlive(nil, enemy) then
									goto __continue69
								end
								local idx = enemy:entindex()
								if now < (self.hitCd[idx] or 0) then
									goto __continue69
								end
								self.hitCd[idx] = now + WHEEL_HIT_CD
								parent:MonsterDamage({
									victim = enemy,
									damage_rate = WHEEL_DMG_RATE,
									ability = self:GetAbility(),
								})
							end
							::__continue69::
						end
					end
					::__continue65::
					i = i + 1
				end
			end
			j = j + 1
		end
	end
end
function modifier_elite_324_wheel.prototype.spawnBeams(self)
	local caster = self:GetParent()
	local axis = self:center():__add(Vector(0, 0, BEAM_HEIGHT))
	do
		local i = 0
		while i < 6 do
			local p = ParticleManager:CreateParticle(LASER_PARTICLE, PATTACH_WORLDORIGIN, caster)
			ParticleManager:SetParticleControl(p, 0, axis)
			ParticleManager:SetParticleControl(p, 1, axis)
			local ____self_beams_3 = self.beams
			____self_beams_3[#____self_beams_3 + 1] = p
			i = i + 1
		end
	end
	self.armCurves = {
		{
			r = RandomFloat(ARM_ACCEL_MIN, ARM_ACCEL_MAX),
			p = RandomFloat(ARM_PEAK_MIN, ARM_PEAK_MAX),
		},
		{
			r = RandomFloat(ARM_ACCEL_MIN, ARM_ACCEL_MAX),
			p = RandomFloat(ARM_PEAK_MIN, ARM_PEAK_MAX),
		},
		{
			r = RandomFloat(ARM_ACCEL_MIN, ARM_ACCEL_MAX),
			p = RandomFloat(ARM_PEAK_MIN, ARM_PEAK_MAX),
		},
	}
	ScreenShake(self:center(), 10, 10, 0.4, WHEEL_RADIUS + 600, 0, true)
end
function modifier_elite_324_wheel.prototype.destroyBeams(self)
	for ____, p in ipairs(self.beams) do
		ParticleManager:DestroyParticle(p, true)
		ParticleManager:ReleaseParticleIndex(p)
	end
	self.beams = {}
end
function modifier_elite_324_wheel.prototype.center(self)
	return GetGroundPosition(Vector(self.cx, self.cy, 0), nil)
end
modifier_elite_324_wheel =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_324_wheel") }, modifier_elite_324_wheel)
--- 湮灭风车·牢笼 debuff：高频位置钳制——到轴心距离超出最长臂立即拉回边界。
-- 不禁用任何技能（位移可正常释放），任何手段出圈都会被"扯回"（elite_321 囚阵同款技法、无引力）。
-- 不可驱散；持有者死亡自动移除；风车 modifier 死亡时统一解除。
local modifier_elite_324_cage = __TS__Class()
modifier_elite_324_cage.name = "modifier_elite_324_cage"
__TS__ClassExtends(modifier_elite_324_cage, BaseModifier)
function modifier_elite_324_cage.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self.cx = 0
	self.cy = 0
	self.radius = WHEEL_RADIUS
end
function modifier_elite_324_cage.prototype.IsHidden(self)
	return false
end
function modifier_elite_324_cage.prototype.IsDebuff(self)
	return true
end
function modifier_elite_324_cage.prototype.IsPurgable(self)
	return false
end
function modifier_elite_324_cage.prototype.RemoveOnDeath(self)
	return true
end
function modifier_elite_324_cage.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	self.cx = kv.cx or 0
	self.cy = kv.cy or 0
	self.radius = kv.radius or WHEEL_RADIUS
	self:StartIntervalThink(0.03)
end
function modifier_elite_324_cage.prototype.OnIntervalThink(self)
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
modifier_elite_324_cage =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_324_cage") }, modifier_elite_324_cage)
return ____exports