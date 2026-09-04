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
--- 激光射程（从施法者沿锁定方向延伸）
local LASER_RANGE = 1000
--- 激光判定宽度（FindUnitsInLine 搜敌宽度，与预警线同宽）
local LASER_WIDTH = 180
--- 第二段·三线合击：主射线发射到合击预警亮起的延迟
local CHASE_DELAY = 0.2
--- 合击预警时长（明显短于主射线的 2s 蓄力预警：躲开第一段后反应窗口很小）
local CHASE_WARN = 0.35
--- 合击目标搜索半径（以中线落点为圆心找最近敌方英雄，其实时位置=三线汇聚点）
local CHASE_SEARCH = 900
--- 合击每线伤害系数（站在汇聚点可能三线全中=重惩罚）
local CHASE_DAMAGE_RATE = 1
--- 前摇总时长 = 预警总时长
local CAST_POINT = 2
--- 预警跟踪段时长：超过后预警线锁死（余下时间给玩家侧移反应）
local TRACK_TIME = 1.5
--- 释放段锁定时长（甩臂+发射）
local CAST_DURATION = 0.9
--- OnStart 后延迟发射：对齐甩臂到位的时刻（可调）
local FIRE_DELAY = 0.4
--- 甩臂动作播放速率（1.27s 的攻击动作压进释放段）
local GESTURE_RATE = 1.4
--- 主射线扇形分叉角度：中线沿锁定方向，两侧各偏 ±此角度（三条独立激光+独立判定）
local SPREAD_ANGLE = 15
--- 扇形三条的角度偏移表（0=中线，先中线保证追击落点取中线）
local FAN_OFFSETS = { 0, SPREAD_ANGLE, -SPREAD_ANGLE }
--- 每条扇形射线的伤害系数（近身可能三条全中=3倍惩罚贴脸；远处通常只中一条）
local DAMAGE_RATE = 1.4
--- 平面向量旋转（度，正=逆时针）
local function rotate2D(self, v, deg)
	local r = math.rad(deg)
	local c = math.cos(r)
	local s = math.sin(r)
	return Vector(v.x * c - v.y * s, v.x * s + v.y * c, 0)
end
--- 激光束粒子（修补匠激光：CP9=起点 CP1=终点，内置已缓存）
local LASER_PARTICLE = "particles/units/heroes/hero_tinker/tinker_laser.vpcf"
--- 激光出膛点·怪物本地空间偏移（相对脚下 origin，随朝向旋转）。
-- ⚠️左右手【不对称】（ModelDoc 两帧实测）：attack1 右手=身前下甩，attack2 左手=左侧平甩，各自一组。
-- forward=前后(正=正前方)，right=左右(正=右侧/负=左侧)，up=离地高度。数值按 ModelScale 0.9 后的游戏内观感目测，待微调。
-- ⚠️引擎读不到 gesture 的实时手位（服务器动画无 gesture、tinker_laser 不吃实体绑定、
--   FollowEntityMerge 后逻辑位置=脚下原点——三路全实测证死），本地偏移近似是唯一可靠路径（elite_210 ORB_OFFSET 同款）
local MUZZLE_R = { forward = 112, right = 68, up = 112 }
local MUZZLE_L = { forward = 52, right = -181, up = 190 }
--- 激光音效
local LASER_SOUND = "Hero_Tinker.Laser"
--- 蓄力叠加层·身体星云（谜团本体原生 ambient，压制公共蓄力特效里不吃变色的白电弧）
-- ⚠️曾用 hero_bane/bane_ambient.vpcf——该路径在 VPK 中不存在，CreateParticle 无效路径=每帧红X
local CHARGE_MIST_PARTICLE = "particles/units/heroes/hero_enigma/enigma_ambient_body.vpcf"
--- 蓄力叠加层·脚下紫圈（谜团午夜脉冲；内置已缓存）
local CHARGE_RING_PARTICLE = "particles/units/heroes/hero_enigma/enigma_midnight_pulse.vpcf"
--- 脚下紫圈半径
local CHARGE_RING_RADIUS = 380
--- 激光视觉的离地高度（终点端，与 elite_012 同款）
local BEAM_HEIGHT = 85
--- AI 思考间隔（秒）
local AI_THINK_INTERVAL = 0.25
--- 索敌范围（与怪物 csv 感知威胁范围 900 对齐）
local AGGRO_RANGE = 900
--- 施法距离：目标进入此距离才起手
local CAST_RANGE = 700
--- CD 期间与目标的保持距离：大于则贴近施压
local HOLD_DISTANCE = 500
--- 湮灭射线：左右手交替的锁定式激光
____exports.elite_320 = __TS__Class()
local elite_320 = ____exports.elite_320
elite_320.name = "elite_320"
__TS__ClassExtends(elite_320, MonsterAbility_CS)
function elite_320.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_320_ai"
end
function elite_320.prototype.Precache(self, context)
	PrecacheResource("particle", LASER_PARTICLE, context)
	PrecacheResource("particle", CHARGE_MIST_PARTICLE, context)
	PrecacheResource("particle", CHARGE_RING_PARTICLE, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_tinker.vsndevts", context)
end
function elite_320.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_DISABLED,
		castColor = Vector(70, 30, 160),
		castProgressBarColor = "blue",
		OnPhaseStart = function()
			return self:onChargeStart()
		end,
		OnStart = function()
			return self:onFireStart()
		end,
		OnInterrupt = function()
			return self:cleanupChargeFx()
		end,
		OnFinish = function()
			self:cleanupChargeFx()
			local cd = self:GetCooldown(self:GetLevel() - 1)
			if cd > 0 then
				self:StartCooldown(cd)
			end
		end,
	}
end
function elite_320.prototype.onChargeStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local target = self:GetMinDistanceUnit(AGGRO_RANGE, origin)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, TRACK_TIME)
	end
	local forward = caster:GetForwardVector()
	self._lockedDir = forward
	local startTime = GameRules:GetGameTime()
	for ____, off in ipairs(FAN_OFFSETS) do
		local isCenter = off == 0
		local warnEnd = origin:__add(rotate2D(nil, forward, off):__mul(LASER_RANGE))
		self:WarningEffect(origin, warnEnd, CAST_POINT, {
			startWidth = LASER_WIDTH,
			endWidth = LASER_WIDTH,
			getDirection = function()
				if GameRules:GetGameTime() - startTime >= TRACK_TIME then
					return nil
				end
				local dir = caster:GetForwardVector()
				if isCenter then
					self._lockedDir = dir
				end
				return rotate2D(nil, dir, off)
			end,
		})
	end
	self:cleanupChargeFx()
	local chargeList = {}
	local mist = ParticleManager:CreateParticle(CHARGE_MIST_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	chargeList[#chargeList + 1] = mist
	local ring = ParticleManager:CreateParticle(CHARGE_RING_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(ring, 0, origin)
	ParticleManager:SetParticleControl(ring, 1, Vector(CHARGE_RING_RADIUS, 0, 0))
	chargeList[#chargeList + 1] = ring
	self._chargePfxList = chargeList
end
function elite_320.prototype.cleanupChargeFx(self)
	local list = self._chargePfxList
	if not list then
		return
	end
	self._chargePfxList = nil
	for ____, pfx in ipairs(list) do
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end
end
function elite_320.prototype.onFireStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:cleanupChargeFx()
	local useLeft = self._useLeftHand == true
	self._useLeftHand = not useLeft
	local ____useLeft_0
	if useLeft then
		____useLeft_0 = ACT_DOTA_ATTACK2
	else
		____useLeft_0 = ACT_DOTA_ATTACK
	end
	local gesture = ____useLeft_0
	caster:StartGestureWithPlaybackRate(gesture, GESTURE_RATE)
	self:Timer(FIRE_DELAY, function()
		return self:fireLaser(useLeft)
	end)
end
function elite_320.prototype.fireLaser(self, useLeft)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local dir = self._lockedDir or caster:GetForwardVector()
	local endGround = origin:__add(dir:__mul(LASER_RANGE))
	local ____useLeft_1
	if useLeft then
		____useLeft_1 = MUZZLE_L
	else
		____useLeft_1 = MUZZLE_R
	end
	local m = ____useLeft_1
	local muzzle = origin
		:__add(caster:GetForwardVector():__mul(m.forward))
		:__add(caster:GetRightVector():__mul(m.right))
		:__add(Vector(0, 0, m.up))
	local fanEnds = {}
	for ____, off in ipairs(FAN_OFFSETS) do
		local fanDir = rotate2D(nil, dir, off)
		local fanEnd = GetGroundPosition(origin:__add(fanDir:__mul(LASER_RANGE)), nil)
		fanEnds[#fanEnds + 1] = fanEnd
		self:fireBeamAt(muzzle, origin, fanEnd, DAMAGE_RATE, off == 0)
	end
	self:Timer(CHASE_DELAY, function()
		local c = self:GetCaster()
		if not IsValidAlive(nil, c) then
			return
		end
		local heroes = self:FindHeroesInRadius(CHASE_SEARCH, endGround)
		local best
		local bestDist = math.huge
		for ____, h in ipairs(heroes) do
			do
				if not IsValidAlive(nil, h) then
					goto __continue32
				end
				local d = h:GetAbsOrigin():__sub(endGround):Length2D()
				if d < bestDist then
					bestDist = d
					best = h
				end
			end
			::__continue32::
		end
		if not IsValidAlive(nil, best) then
			return
		end
		local converge = GetGroundPosition(best:GetAbsOrigin(), nil)
		for ____, fe in ipairs(fanEnds) do
			self:WarningEffect(fe, converge, CHASE_WARN, { startWidth = LASER_WIDTH, endWidth = LASER_WIDTH })
		end
		self:Timer(CHASE_WARN, function()
			if not IsValidAlive(nil, self:GetCaster()) then
				return
			end
			local first = true
			for ____, fe in ipairs(fanEnds) do
				self:fireBeamAt(fe:__add(Vector(0, 0, BEAM_HEIGHT)), fe, converge, CHASE_DAMAGE_RATE, first)
				first = false
			end
		end)
	end)
end
function elite_320.prototype.fireBeamAt(self, visualFrom, judgeFrom, judgeTo, damageRate, playSound)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	if judgeTo:__sub(judgeFrom):Length2D() < 10 then
		return
	end
	local pfx = ParticleManager:CreateParticle(LASER_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(pfx, 9, visualFrom)
	ParticleManager:SetParticleControl(pfx, 1, judgeTo:__add(Vector(0, 0, BEAM_HEIGHT)))
	Timers:CreateTimer(0.5, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
	if playSound ~= false then
		caster:EmitSound(LASER_SOUND)
	end
	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		judgeFrom,
		judgeTo,
		nil,
		LASER_WIDTH,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue48
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = damageRate, ability = self })
		end
		::__continue48::
	end
end
elite_320 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_320)
____exports.elite_320 = elite_320
--- 长演出技能（321/324/325）之间的最小间隔（秒）
local BIG_SKILL_GAP = 8
local modifier_elite_320_ai = __TS__Class()
modifier_elite_320_ai.name = "modifier_elite_320_ai"
__TS__ClassExtends(modifier_elite_320_ai, BaseModifier)
function modifier_elite_320_ai.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self.wasCasting = false
	self.lastCastBig = false
	self.bigLockUntil = 0
end
function modifier_elite_320_ai.prototype.IsHidden(self)
	return true
end
function modifier_elite_320_ai.prototype.IsPurgable(self)
	return false
end
function modifier_elite_320_ai.prototype.RemoveOnDeath(self)
	return true
end
function modifier_elite_320_ai.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(AI_THINK_INTERVAL)
end
function modifier_elite_320_ai.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local ____opt_2 = parent.IsMonsterCasting
	if (____opt_2 and ____opt_2(parent)) == true then
		self.wasCasting = true
		return
	end
	if self.wasCasting then
		self.wasCasting = false
		if self.lastCastBig then
			self.lastCastBig = false
			self.bigLockUntil = GameRules:GetGameTime() + BIG_SKILL_GAP
		end
	end
	if parent:IsStunned() then
		return
	end
	local target = parent:GetMinDistanceUnit(AGGRO_RANGE)
	if not target or not IsValidAlive(nil, target) then
		return
	end
	local distance = GetDistance(nil, parent:GetAbsOrigin(), target:GetAbsOrigin())
	local bigReady = GameRules:GetGameTime() >= self.bigLockUntil
	local ult = parent:FindAbilityByName("elite_321")
	if ult and not ult:IsNull() and ult:IsCooldownReady() and bigReady then
		local ultRange = ult:GetCastRange(parent:GetAbsOrigin(), nil) or 700
		if distance <= ultRange then
			parent:Stop()
			parent:CastAbilityNoTarget(ult, parent:GetPlayerOwnerID())
			self.lastCastBig = true
		else
			parent:MoveToPosition(target:GetAbsOrigin())
		end
		return
	end
	local horizon = parent:FindAbilityByName("elite_325")
	if horizon and not horizon:IsNull() and horizon:IsCooldownReady() and bigReady then
		local horizonRange = horizon:GetCastRange(parent:GetAbsOrigin(), nil) or 700
		if distance <= horizonRange then
			parent:Stop()
			parent:CastAbilityNoTarget(horizon, parent:GetPlayerOwnerID())
			self.lastCastBig = true
		else
			parent:MoveToPosition(target:GetAbsOrigin())
		end
		return
	end
	local wheel = parent:FindAbilityByName("elite_324")
	if wheel and not wheel:IsNull() and wheel:IsCooldownReady() and bigReady then
		local wheelRange = wheel:GetCastRange(parent:GetAbsOrigin(), nil) or 700
		if distance <= wheelRange then
			parent:Stop()
			parent:CastAbilityNoTarget(wheel, parent:GetPlayerOwnerID())
			self.lastCastBig = true
		else
			parent:MoveToPosition(target:GetAbsOrigin())
		end
		return
	end
	local ability = parent:FindAbilityByName("elite_320")
	if ability and not ability:IsNull() and ability:IsCooldownReady() then
		if distance <= CAST_RANGE then
			parent:Stop()
			parent:CastAbilityNoTarget(ability, parent:GetPlayerOwnerID())
		else
			parent:MoveToPosition(target:GetAbsOrigin())
		end
		return
	end
	if distance > HOLD_DISTANCE then
		parent:MoveToPosition(target:GetAbsOrigin())
	end
end
modifier_elite_320_ai = __TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_320_ai") }, modifier_elite_320_ai)
return ____exports