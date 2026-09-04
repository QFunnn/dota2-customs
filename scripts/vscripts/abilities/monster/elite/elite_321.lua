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
--- 牢笼半径 = 五芒星外接圆半径
local CAGE_RADIUS = 800
--- 施法距离（AI 追到此距离内才放）
local CAST_RANGE = 700
--- 前摇时长
local CAST_POINT = 0.8
--- 激光段数：中心→P0 + 五芒星一笔画5段
local SEGMENT_COUNT = 6
--- 相邻激光段的间隔
local SEGMENT_INTERVAL = 0.55
--- 每段发射前的预警先行时长
local SEGMENT_WARN = 0.5
--- OnStart 后到第一段预警亮起的准备时间（瞬移安顿）
local ARENA_PREP = 0.4
--- 回旋扫射发数（均分 360° 绕一整圈）
local SWEEP_COUNT = 10
--- 每发扫过的角度（顺时针步进）
local SWEEP_ANGLE_STEP = 360 / SWEEP_COUNT
--- 首发间隔（秒），逐发递减 = 越放越快（蓄力完毕后的快速爆发）
local SWEEP_START_INTERVAL = 0.25
--- 每发间隔递减量
local SWEEP_STEP = 0.02
--- 间隔下限（加速封顶）
local SWEEP_MIN_INTERVAL = 0.1
--- 回旋预警固定先行量（与发射间隔解耦：发射快时同屏多条预警连成追人的扇面）
local SWEEP_WARN_LEAD = 0.4
--- 星轨结束到回旋首发的停顿 = 怪物蓄力演出时长（黑洞蓄力动作+蓄力粒子+阵心收缩圈读秒）
local SWEEP_PREP = 1.4
--- 回旋每发伤害系数（发数多，单发低于星轨段）
local SWEEP_DAMAGE_RATE = 1
--- 牢笼向心引力：每秒往阵心拖拽的速度（黑洞主题；玩家移速~350 可对抗=逆流而行，站桩会被吸进弹幕区）
local PULL_SPEED = 120
--- 引力死区半径：距阵心此距离内不再拖拽（防止被钉在怪物脸上）
local PULL_DEADZONE = 180
--- 蓄力身体星云（谜团本体 ambient，与 elite_320 蓄力同款；已验证存在+全局缓存）
local CHARGE_MIST_PARTICLE = "particles/units/heroes/hero_enigma/enigma_ambient_body.vpcf"
--- 第 i 发回旋的间隔（递减至下限）
local function sweepInterval(self, i)
	return math.max(SWEEP_START_INTERVAL - SWEEP_STEP * i, SWEEP_MIN_INTERVAL)
end
--- 回旋阶段总时长
local function sweepTotal(self)
	local t = 0
	do
		local i = 0
		while i < SWEEP_COUNT do
			t = t + sweepInterval(nil, i)
			i = i + 1
		end
	end
	return t
end
--- 星轨阶段总时长（准备 + 6 段）
local STAR_PHASE = ARENA_PREP + SEGMENT_COUNT * SEGMENT_INTERVAL
--- 释放锁定总时长 = 星轨 + 回旋 + 收尾余量（期间怪物站桩阵心）
local CAST_DURATION = STAR_PHASE + SWEEP_PREP + sweepTotal(nil) + 0.5
--- 激光判定宽度（与预警线同宽）
local LASER_WIDTH = 180
--- 梭形激光·中段最大张开半宽：三束"先分散后集中"（起点合一→中点张开±此值→终点收拢合一，用户手绘定稿）
local BEAM_BULGE = 110
--- 每段伤害系数（damage_rate × 攻击力；多段可能连续命中，单段低于普通射线）
local DAMAGE_RATE = 1.2
--- 激光束粒子（修补匠激光：CP9=起点 CP1=终点，⚠️只吃纯静态 SetParticleControl，见 elite_320）
local LASER_PARTICLE = "particles/units/heroes/hero_tinker/tinker_laser.vpcf"
--- 激光音效
local LASER_SOUND = "Hero_Tinker.Laser"
--- 阵心氛围粒子（谜团午夜脉冲大圈；已随 precacheUnits enigma 全局缓存）
local ARENA_PARTICLE = "particles/units/heroes/hero_enigma/enigma_midnight_pulse.vpcf"
--- 激光视觉的离地高度
local BEAM_HEIGHT = 85
--- 五芒星"一笔画"顶点序列（-1 = 阵心；P0→P2→P4→P1→P3→P0 即星线反弹路径）
local SEGMENT_ORDER = {
	{ -1, 0 },
	{ 0, 2 },
	{ 2, 4 },
	{ 4, 1 },
	{ 1, 3 },
	{ 3, 0 },
}
____exports.elite_321 = __TS__Class()
local elite_321 = ____exports.elite_321
elite_321.name = "elite_321"
__TS__ClassExtends(elite_321, MonsterAbility_CS)
function elite_321.prototype.resolveSweepBaseAngle(self, center)
	local best
	local bestDist = math.huge
	local caged = self._cagedUnits
	if caged then
		for ____, u in ipairs(caged) do
			do
				if not IsValidAlive(nil, u) then
					goto __continue7
				end
				local d = u:GetAbsOrigin():__sub(center):Length2D()
				if d < bestDist then
					bestDist = d
					best = u
				end
			end
			::__continue7::
		end
	end
	if not IsValidAlive(nil, best) then
		return 90
	end
	local rel = best:GetAbsOrigin():__sub(center)
	if rel:Length2D() < 1 then
		return 90
	end
	return math.atan2(rel.y, rel.x) * 180 / math.pi
end
function elite_321.prototype.sweepTarget(self, center, idx)
	local base = self._sweepBaseAngle or 90
	local angle = math.rad(base - SWEEP_ANGLE_STEP * idx)
	local dir = Vector(math.cos(angle), math.sin(angle), 0)
	return GetGroundPosition(center:__add(dir:__mul(CAGE_RADIUS)), nil)
end
function elite_321.prototype.Precache(self, context)
	PrecacheResource("particle", LASER_PARTICLE, context)
	PrecacheResource("particle", ARENA_PARTICLE, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_tinker.vsndevts", context)
end
function elite_321.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_DISABLED,
		castProgressBarColor = "blue",
		castColor = Vector(150, 60, 255),
		OnStart = function()
			return self:onArenaStart()
		end,
		OnInterrupt = function()
			return self:cleanupArena()
		end,
		OnFinish = function()
			self:cleanupArena()
			local cd = self:GetCooldown(self:GetLevel() - 1)
			if cd > 0 then
				self:StartCooldown(cd)
			end
		end,
	}
end
function elite_321.prototype.starPoints(self, center)
	local points = {}
	do
		local i = 0
		while i < 5 do
			local angle = math.rad(90 + 72 * i)
			local p = center:__add(Vector(math.cos(angle) * CAGE_RADIUS, math.sin(angle) * CAGE_RADIUS, 0))
			points[#points + 1] = GetGroundPosition(p, nil)
			i = i + 1
		end
	end
	return points
end
function elite_321.prototype.onArenaStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local token = DoUniqueString("arena_321")
	self._runToken = token
	local target = self:GetMinDistanceUnit(CAST_RANGE + 300)
	local ____GetGroundPosition_1 = GetGroundPosition
	local ____IsValidAlive_result_0
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_0 = target:GetAbsOrigin()
	else
		____IsValidAlive_result_0 = caster:GetAbsOrigin()
	end
	local center = ____GetGroundPosition_1(____IsValidAlive_result_0, nil)
	local points = self:starPoints(center)
	local arenaLife = CAST_DURATION - 0.2
	local pulse = ParticleManager:CreateParticle(ARENA_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(pulse, 0, center)
	ParticleManager:SetParticleControl(pulse, 1, Vector(CAGE_RADIUS, 0, 0))
	self._arenaPfx = { pulse }
	local caged = {}
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		CAGE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue24
			end
			enemy:AddNewModifier(
				caster,
				self,
				"modifier_elite_321_cage",
				{ duration = arenaLife, cx = center.x, cy = center.y, radius = CAGE_RADIUS }
			)
			caged[#caged + 1] = enemy
		end
		::__continue24::
	end
	self._cagedUnits = caged
	self:WarningRingEffect(caster:GetAbsOrigin(), 190, 0.4)
	FindClearSpaceForUnit(caster, center, true)
	caster:SetForwardVector(points[1]:__sub(center):Normalized())
	self:WarningRingEffect(center, 190, 0.4)
	caster:EmitSound("Hero_Enigma.Demonic_Conversion")
	caster:StartGesture(ACT_DOTA_DISABLED)
	do
		local i = 0
		while i < #SEGMENT_ORDER do
			local a, b = unpack(SEGMENT_ORDER[i + 1])
			local ____temp_2
			if a < 0 then
				____temp_2 = center
			else
				____temp_2 = points[a + 1]
			end
			local from = ____temp_2
			local to = points[b + 1]
			local fireAt = ARENA_PREP + SEGMENT_WARN + i * SEGMENT_INTERVAL
			self:Timer(ARENA_PREP, function()
				if self._runToken ~= token then
					return
				end
				self:WarningEffect(from, to, fireAt - ARENA_PREP, { startWidth = LASER_WIDTH, endWidth = LASER_WIDTH })
			end)
			self:Timer(fireAt, function()
				if self._runToken ~= token then
					return
				end
				self:fireSegment(from, to)
			end)
			i = i + 1
		end
	end
	self:Timer(STAR_PHASE + 0.1, function()
		if self._runToken ~= token then
			return
		end
		local c = self:GetCaster()
		if not IsValidAlive(nil, c) then
			return
		end
		c:FadeGesture(ACT_DOTA_DISABLED)
		c:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1)
		local mist = ParticleManager:CreateParticle(CHARGE_MIST_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, c)
		self._sweepChargePfx = { mist }
		self:WarningRingEffect(center, 280, SWEEP_PREP - 0.15)
		c:EmitSound("Hero_Enigma.Demonic_Conversion")
	end)
	self:Timer(STAR_PHASE + SWEEP_PREP - 0.05, function()
		if self._runToken ~= token then
			return
		end
		self:cleanupSweepCharge()
	end)
	local sweepAt = STAR_PHASE + SWEEP_PREP
	do
		local i = 0
		while i < SWEEP_COUNT do
			local idx = i
			self:Timer(sweepAt - SWEEP_WARN_LEAD, function()
				if self._runToken ~= token then
					return
				end
				if idx == 0 then
					self._sweepBaseAngle = self:resolveSweepBaseAngle(center)
				end
				self:WarningEffect(
					center,
					self:sweepTarget(center, idx),
					SWEEP_WARN_LEAD,
					{ startWidth = LASER_WIDTH, endWidth = LASER_WIDTH }
				)
			end)
			self:Timer(sweepAt, function()
				if self._runToken ~= token then
					return
				end
				self:fireSegment(center, self:sweepTarget(center, idx), SWEEP_DAMAGE_RATE)
			end)
			sweepAt = sweepAt + sweepInterval(nil, i)
			i = i + 1
		end
	end
	self:Timer(sweepAt + 0.2, function()
		if self._runToken ~= token then
			return
		end
		local c = self:GetCaster()
		if IsValidAlive(nil, c) then
			c:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
		end
	end)
end
function elite_321.prototype.cleanupSweepCharge(self)
	local list = self._sweepChargePfx
	if not list then
		return
	end
	self._sweepChargePfx = nil
	for ____, pfx in ipairs(list) do
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end
end
function elite_321.prototype.fireSegment(self, from, to, damageRate)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local flat = to:__sub(from)
	if flat:Length2D() < 10 then
		return
	end
	local segDir = flat:Normalized()
	local perp = Vector(-segDir.y, segDir.x, 0)
	local beamFrom = from:__add(Vector(0, 0, BEAM_HEIGHT))
	local beamTo = to:__add(Vector(0, 0, BEAM_HEIGHT))
	local mid = from:__add(flat:__mul(0.5))
	local beams = {}
	local function spawnLine(____, a, b)
		local pfx = ParticleManager:CreateParticle(LASER_PARTICLE, PATTACH_WORLDORIGIN, caster)
		ParticleManager:SetParticleControl(pfx, 9, a)
		ParticleManager:SetParticleControl(pfx, 1, b)
		beams[#beams + 1] = pfx
	end
	spawnLine(nil, beamFrom, beamTo)
	for ____, side in ipairs({ 1, -1 }) do
		local bulge = mid:__add(perp:__mul(BEAM_BULGE * side)):__add(Vector(0, 0, BEAM_HEIGHT))
		spawnLine(nil, beamFrom, bulge)
		spawnLine(nil, bulge, beamTo)
	end
	Timers:CreateTimer(0.45, function()
		for ____, pfx in ipairs(beams) do
			ParticleManager:DestroyParticle(pfx, false)
			ParticleManager:ReleaseParticleIndex(pfx)
		end
	end)
	caster:EmitSound(LASER_SOUND)
	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		from,
		to,
		nil,
		LASER_WIDTH,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue59
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = damageRate or DAMAGE_RATE, ability = self })
		end
		::__continue59::
	end
end
function elite_321.prototype.cleanupArena(self)
	self._runToken = nil
	self._sweepBaseAngle = nil
	self:cleanupSweepCharge()
	local c = self:GetCaster()
	if IsValidAlive(nil, c) then
		c:FadeGesture(ACT_DOTA_DISABLED)
		c:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
	end
	local pfxList = self._arenaPfx
	if pfxList then
		self._arenaPfx = nil
		for ____, pfx in ipairs(pfxList) do
			ParticleManager:DestroyParticle(pfx, false)
			ParticleManager:ReleaseParticleIndex(pfx)
		end
	end
	local caged = self._cagedUnits
	if caged then
		self._cagedUnits = nil
		for ____, unit in ipairs(caged) do
			if IsValid(nil, unit) and not unit:IsNull() then
				unit:RemoveModifierByName("modifier_elite_321_cage")
			end
		end
	end
end
elite_321 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_321)
____exports.elite_321 = elite_321
--- 五芒囚阵·牢笼 debuff：高频位置钳制——到阵心距离超出半径立即拉回边界。
-- 不禁用任何技能（位移可正常释放），任何手段出圈都会被"法阵扯回"，兜底万能。
-- 不可驱散；持有者死亡自动移除。
local modifier_elite_321_cage = __TS__Class()
modifier_elite_321_cage.name = "modifier_elite_321_cage"
__TS__ClassExtends(modifier_elite_321_cage, BaseModifier)
function modifier_elite_321_cage.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self.cx = 0
	self.cy = 0
	self.radius = CAGE_RADIUS
end
function modifier_elite_321_cage.prototype.IsHidden(self)
	return false
end
function modifier_elite_321_cage.prototype.IsDebuff(self)
	return true
end
function modifier_elite_321_cage.prototype.IsPurgable(self)
	return false
end
function modifier_elite_321_cage.prototype.RemoveOnDeath(self)
	return true
end
function modifier_elite_321_cage.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	self.cx = kv.cx or 0
	self.cy = kv.cy or 0
	self.radius = kv.radius or CAGE_RADIUS
	self:StartIntervalThink(0.03)
end
function modifier_elite_321_cage.prototype.OnIntervalThink(self)
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
		return
	end
	if dist > PULL_DEADZONE then
		local step = math.min(PULL_SPEED * 0.03, dist - PULL_DEADZONE)
		local scale = (dist - step) / dist
		local pulled = GetGroundPosition(Vector(self.cx + dx * scale, self.cy + dy * scale, pos.z), parent)
		parent:SetAbsOrigin(pulled)
	end
end
modifier_elite_321_cage =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_321_cage") }, modifier_elite_321_cage)
return ____exports