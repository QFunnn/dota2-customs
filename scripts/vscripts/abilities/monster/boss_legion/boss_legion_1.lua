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
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_boss_legion_1_pursuit_lock, modifier_boss_legion_1_dash_prepare, modifier_boss_legion_1_mark, modifier_boss_legion_1_dash_window, modifier_boss_legion_1_duel_caster, modifier_boss_legion_1_duel_target
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1600
local CAST_POINT = 0.5
local COUNTDOWN_DURATION = 3
local DUEL_DURATION = 5
local DUEL_DAMAGE_RATE = 20
local THINK_INTERVAL = 0.03
local TURN_SPEED = 18
local FIRST_DASH_PREPARE_DURATION = 0.5
local DASH_START_KNOCKBACK_DURATION = 0.24
local DASH_START_KNOCKBACK_HEIGHT = 40
local COUNTDOWN_PARTICLE = "particles/units/heroes/hero_drow/drow_hypothermia_counter_stack.vpcf"
local DASH_TRAIL_PARTICLE = "particles/lizi/units/heroes/legion_commander/legion_commander_3.vpcf"
local DASH_BURST_PARTICLE = "particles/dd/arr_legion_commander_odds.vpcf"
local WARNING_RING_PARTICLE = "particles/monster/ability_warning_ring.vpcf"
local DUEL_RING_PARTICLE = "particles/lizi/units/heroes/legion_commander/legion_commander_1.vpcf"
local DUEL_BUFF_PARTICLE = "particles/lizi/units/heroes/legion_commander/legion_commander_1_f.vpcf"
local DUEL_END_PARTICLE = "particles/lizi/units/heroes/legion_commander/legion_commander_1_e.vpcf"
local SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_legion_commander.vsndevts"
local COUNTDOWN_SOUND = "Hero_LegionCommander.Duel.Cast"
local DASH_SOUND = "Hero_LegionCommander.Overwhelming.Cast"
local DUEL_START_SOUND = "Hero_LegionCommander.Duel"
local DUEL_WIN_SOUND = "Hero_LegionCommander.Duel.Victory"
local function getGroundPosition(self, pos, context)
	return GetGroundPosition(pos, context)
end
local function getFlatDirection(self, direction)
	local flat = Vector(direction.x, direction.y, 0)
	local length = flat:Length2D()
	if length <= 0.001 then
		return Vector(1, 0, 0)
	end
	return flat:__mul(1 / length)
end
local function getTargetByIndex(self, targetIndex)
	if targetIndex == nil then
		return nil
	end
	return EntIndexToHScript(targetIndex)
end
local function getReachableGroundPosition(self, from, desired, context)
	local start = getGroundPosition(nil, from, context)
	local ____end = getGroundPosition(nil, desired, context)
	local delta = ____end:__sub(start)
	local distance = delta:Length2D()
	if distance <= 1 then
		return start
	end
	local direction = delta:Normalized()
	local steps = math.max(1, math.ceil(distance / 48))
	local last = start
	do
		local i = 1
		while i <= steps do
			local stepDistance = math.min(distance, i * 48)
			local candidate = getGroundPosition(nil, start:__add(direction:__mul(stepDistance)), context)
			if
				not GridNav:IsTraversable(candidate)
				or GridNav:IsBlocked(candidate)
				or not GridNav:CanFindPath(last, candidate)
			then
				break
			end
			last = candidate
			i = i + 1
		end
	end
	return last
end
--- 军团技能1：决斗追猎。
--
-- 时间轴：
-- 1. 施法成功后随机点名一名英雄，目标头顶显示 3 秒倒计时。
-- 2. 倒计时期间军团仍可移动和普攻；但通过 castDuration + isNotMove=false 保持 IsMonsterCasting 状态，阻止 Boss AI 插入其它技能。
-- 3. 倒计时结束后进入多段“蓄力预警条 -> 起步击退 -> 冲刺追猎”。
-- 4. 冲刺期间只做隐藏决斗触发判定，不常驻显示跟随圈；触发强制决斗后才播放正式决斗圈和自身 Buff 特效。
--
-- 冲刺次数、距离、预警宽度、决斗触发半径和起步击退范围均来自 csv/ak_monster_abilities.csv 的 boss_legion_1 AbilityValues。
____exports.boss_legion_1 = __TS__Class()
local boss_legion_1 = ____exports.boss_legion_1
boss_legion_1.name = "boss_legion_1"
__TS__ClassExtends(boss_legion_1, MonsterAbility_CS)
function boss_legion_1.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.pursuitToken = 0
	self.duelTriggered = false
end
function boss_legion_1.prototype.Precache(self, context)
	PrecacheResource("particle", COUNTDOWN_PARTICLE, context)
	PrecacheResource("particle", DASH_TRAIL_PARTICLE, context)
	PrecacheResource("particle", DASH_BURST_PARTICLE, context)
	PrecacheResource("particle", WARNING_RING_PARTICLE, context)
	PrecacheResource("particle", DUEL_RING_PARTICLE, context)
	PrecacheResource("particle", DUEL_BUFF_PARTICLE, context)
	PrecacheResource("particle", DUEL_END_PARTICLE, context)
	PrecacheResource("soundfile", SOUND_EVENTS, context)
end
function boss_legion_1.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = COUNTDOWN_DURATION + self:GetDashSequenceDuration() + 0.6,
		isNotMove = false,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		cooldown = 14,
		OnPhaseStart = function()
			return self:OnLegionPhaseStart()
		end,
		OnStart = function()
			return self:OnLegionStart()
		end,
		OnFinish = function()
			return self:ClearPursuit()
		end,
		OnInterrupt = function()
			return self:ClearPursuit()
		end,
	}
end
function boss_legion_1.prototype.OnLegionPhaseStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = self:FindRandomHero(caster)
	self.markedTargetIndex = target and target:entindex()
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, CAST_POINT, TURN_SPEED)
	end
end
function boss_legion_1.prototype.OnLegionStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = getTargetByIndex(nil, self.markedTargetIndex) or self:FindRandomHero(caster)
	if not IsValidAlive(nil, target) then
		self:DestroyDuration()
		return
	end
	self.duelTriggered = false
	local ____self_2, ____pursuitToken_3 = self, "pursuitToken"
	local ____self_pursuitToken_4 = ____self_2[____pursuitToken_3] + 1
	____self_2[____pursuitToken_3] = ____self_pursuitToken_4
	local token = ____self_pursuitToken_4
	self.markedTargetIndex = target:entindex()
	modifier_boss_legion_1_mark:applys(target, caster, self, { duration = COUNTDOWN_DURATION })
	modifier_boss_legion_1_pursuit_lock:applys(
		caster,
		caster,
		self,
		{ duration = COUNTDOWN_DURATION + self:GetDashSequenceDuration() + 0.6 }
	)
	EmitSoundOn(COUNTDOWN_SOUND, caster)
	self:Timer(COUNTDOWN_DURATION, function()
		if not self:IsTokenActive(token) then
			return
		end
		self:StartDashChain(caster, target, 0, token)
	end)
end
function boss_legion_1.prototype.StartDashChain(self, caster, target, dashIndex, token)
	if not self:IsTokenActive(token) or not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		self:DestroyDuration()
		return
	end
	if dashIndex >= self:GetDashCount() then
		self:DestroyDuration()
		return
	end
	local dashPrepareDuration = self:GetDashPrepareDuration(dashIndex)
	local direction = getFlatDirection(nil, target:GetAbsOrigin():__sub(caster:GetAbsOrigin()))
	caster:SetForwardVector(direction)
	caster:LockTargetForSpeed(target, dashPrepareDuration, TURN_SPEED)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.1)
	self:ShowDashWarning(caster, direction, dashPrepareDuration)
	self:ShowDuelTriggerRing(caster)
	modifier_boss_legion_1_dash_prepare:applys(caster, caster, self, { duration = dashPrepareDuration })
	self:Timer(dashPrepareDuration, function()
		if not self:IsTokenActive(token) or not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
			self:DestroyDuration()
			return
		end
		self:StartSingleDash(caster, target, direction, dashIndex, token)
	end)
end
function boss_legion_1.prototype.StartSingleDash(self, caster, target, direction, dashIndex, token)
	local start = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	if not IsValidAlive(nil, target) then
		return
	end
	local targetDistance = GetDistance(nil, start, target:GetAbsOrigin())
	local dashDistanceConfig = self:GetDashDistance()
	local duelTriggerRadius = self:GetDuelTriggerRadius()
	local dashDuration = self:GetDashDuration()
	local dashDistance = math.min(dashDistanceConfig, math.max(260, targetDistance + duelTriggerRadius * 0.35))
	local ____end = getReachableGroundPosition(nil, start, start:__add(direction:__mul(dashDistance)), caster)
	self:KnockBackNearbyEnemies(caster)
	modifier_boss_legion_1_dash_window:applys(caster, caster, self, {
		duration = dashDuration,
		target_entindex = target:entindex(),
		token = token,
		duel_trigger_radius = duelTriggerRadius,
	})
	self:StartDashEffect(caster, start, ____end, direction)
	EmitSoundOn(DASH_SOUND, caster)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1_END, 1.2)
	caster:Mover(____end, dashDuration, nil, nil, true, true)
	self:Timer(dashDuration, function()
		self:ClearDashEffect(caster)
		if not self:IsTokenActive(token) or self.duelTriggered then
			return
		end
		self:StartDashChain(caster, target, dashIndex + 1, token)
	end)
end
function boss_legion_1.prototype.TryTriggerDuel(self, target, token, effectDelay)
	if effectDelay == nil then
		effectDelay = 0
	end
	local caster = self:GetCaster()
	if
		not self:IsTokenActive(token)
		or self.duelTriggered
		or not IsValidAlive(nil, caster)
		or not IsValidAlive(nil, target)
	then
		return
	end
	self.duelTriggered = true
	self.pursuitToken = self.pursuitToken + 1
	modifier_boss_legion_1_mark:remove(target)
	modifier_boss_legion_1_dash_window:remove(caster)
	self:ClearDashEffect(caster)
	self:DestroyDuration()
	caster:SetForwardVector(getFlatDirection(nil, target:GetAbsOrigin():__sub(caster:GetAbsOrigin())))
	modifier_boss_legion_1_duel_caster:applys(caster, caster, self, {
		duration = DUEL_DURATION,
		target_entindex = target:entindex(),
		effect_delay = effectDelay,
	})
	modifier_boss_legion_1_duel_target:applys(target, caster, self, {
		duration = DUEL_DURATION,
		target_entindex = caster:entindex(),
	})
	EmitSoundOn(DUEL_START_SOUND, caster)
end
function boss_legion_1.prototype.FindRandomHero(self, caster)
	local enemies = __TS__ArrayFilter(
		FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, CAST_RANGE, 2, 1, 0, 0, false),
		function(____, enemy)
			return IsValidAlive(nil, enemy)
		end
	)
	if #enemies == 0 then
		return nil
	end
	return enemies[RandomInt(0, #enemies - 1) + 1]
end
function boss_legion_1.prototype.ShowDashWarning(self, caster, direction, duration)
	local start = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local ____end = start:__add(direction:__mul(self:GetDashDistance()))
	local dashWarningWidth = self:GetDashWarningWidth()
	self:WarningEffect(
		start,
		____end,
		duration,
		{ startWidth = dashWarningWidth, endWidth = dashWarningWidth, type = 2 }
	)
end
function boss_legion_1.prototype.ShowDuelTriggerRing(self, caster)
	self:WarningRingEffect(
		getGroundPosition(nil, caster:GetAbsOrigin(), caster),
		self:GetDuelTriggerRadius(),
		self:GetDuelTriggerRingDuration(),
		{ speed = 0 }
	)
end
function boss_legion_1.prototype.StartDashEffect(self, caster, start, ____end, direction)
	self:ClearDashEffect(caster)
	local pfx = ParticleManager:CreateParticle(DASH_TRAIL_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlForward(pfx, 0, direction)
	self.dashPfx = pfx
	self:PlayDashBurstEffect(caster, start, ____end, direction)
end
function boss_legion_1.prototype.ClearDashEffect(self, caster)
	if self.dashPfx == nil then
		return
	end
	ParticleManager:DestroyParticle(self.dashPfx, false)
	ParticleManager:ReleaseParticleIndex(self.dashPfx)
	self.dashPfx = nil
end
function boss_legion_1.prototype.PlayDashBurstEffect(self, caster, start, ____end, direction)
	local startPos = getGroundPosition(nil, start, caster)
	local endPos = getGroundPosition(nil, ____end, caster)
	local pfx = ParticleManager:CreateParticle(DASH_BURST_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControlTransformForward(pfx, 0, startPos, direction)
	ParticleManager:SetParticleControl(pfx, 1, endPos)
	ParticleManager:SetParticleControl(pfx, 2, Vector(self:GetDashDuration(), 0, 0))
	ParticleManager:SetParticleControl(pfx, 3, startPos)
	ParticleManager:SetParticleControl(pfx, 4, endPos)
	ParticleManager:SetParticleControl(pfx, 5, endPos)
	ParticleManager:SetParticleControl(pfx, 6, Vector(self:GetDashDistance(), self:GetDashWarningWidth(), 0))
	ParticleManager:ReleaseParticleIndex(pfx)
end
function boss_legion_1.prototype.KnockBackNearbyEnemies(self, caster)
	local origin = caster:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		self:GetDashStartKnockbackRadius(),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue46
			end
			local direction = getFlatDirection(nil, enemy:GetAbsOrigin():__sub(origin))
			enemy:KnockBack(caster, self, {
				duration = DASH_START_KNOCKBACK_DURATION,
				distance = self:GetDashStartKnockbackDistance(),
				height = DASH_START_KNOCKBACK_HEIGHT,
				direction = direction,
				particleName = "",
			})
		end
		::__continue46::
	end
end
function boss_legion_1.prototype.GetDashCount(self)
	return math.max(1, math.floor(self:GetSpecialValueFor("dash_count")))
end
function boss_legion_1.prototype.GetDashDistance(self)
	return self:GetSpecialValueFor("dash_distance")
end
function boss_legion_1.prototype.GetDashWarningWidth(self)
	return self:GetSpecialValueFor("dash_warning_width")
end
function boss_legion_1.prototype.GetDashReaimDuration(self)
	return self:GetSpecialValueFor("dash_reaim_duration")
end
function boss_legion_1.prototype.GetDashPrepareDuration(self, dashIndex)
	return dashIndex == 0 and FIRST_DASH_PREPARE_DURATION or self:GetDashReaimDuration()
end
function boss_legion_1.prototype.GetDashDuration(self)
	return self:GetSpecialValueFor("dash_duration")
end
function boss_legion_1.prototype.GetDashSequenceDuration(self)
	local dashCount = self:GetDashCount()
	if dashCount <= 0 then
		return 0
	end
	return FIRST_DASH_PREPARE_DURATION
		+ dashCount * self:GetDashDuration()
		+ (dashCount - 1) * self:GetDashReaimDuration()
end
function boss_legion_1.prototype.GetDuelTriggerRadius(self)
	return self:GetSpecialValueFor("duel_trigger_radius")
end
function boss_legion_1.prototype.GetDuelTriggerRingDuration(self)
	return self:GetSpecialValueFor("duel_trigger_ring_duration")
end
function boss_legion_1.prototype.GetDashStartKnockbackRadius(self)
	return self:GetSpecialValueFor("dash_start_knockback_radius")
end
function boss_legion_1.prototype.GetDashStartKnockbackDistance(self)
	return self:GetSpecialValueFor("dash_start_knockback_distance")
end
function boss_legion_1.prototype.IsTokenActive(self, token)
	return token == self.pursuitToken and not self.duelTriggered
end
function boss_legion_1.prototype.ClearPursuit(self)
	local caster = self:GetCaster()
	self.pursuitToken = self.pursuitToken + 1
	if IsValidAlive(nil, caster) then
		modifier_boss_legion_1_pursuit_lock:remove(caster)
		modifier_boss_legion_1_dash_prepare:remove(caster)
		modifier_boss_legion_1_dash_window:remove(caster)
		self:ClearDashEffect(caster)
	end
	local target = getTargetByIndex(nil, self.markedTargetIndex)
	if IsValidAlive(nil, target) then
		modifier_boss_legion_1_mark:remove(target)
	end
	self.markedTargetIndex = nil
end
boss_legion_1 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_legion_1)
____exports.boss_legion_1 = boss_legion_1
modifier_boss_legion_1_pursuit_lock = __TS__Class()
modifier_boss_legion_1_pursuit_lock.name = "modifier_boss_legion_1_pursuit_lock"
__TS__ClassExtends(modifier_boss_legion_1_pursuit_lock, MonsterModifier_CS)
function modifier_boss_legion_1_pursuit_lock.prototype.CheckState(self)
	return { [MODIFIER_STATE_SILENCED] = true }
end
function modifier_boss_legion_1_pursuit_lock.prototype.IsHidden(self)
	return true
end
function modifier_boss_legion_1_pursuit_lock.prototype.IsPurgable(self)
	return false
end
modifier_boss_legion_1_pursuit_lock =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_legion_1_pursuit_lock)
modifier_boss_legion_1_dash_prepare = __TS__Class()
modifier_boss_legion_1_dash_prepare.name = "modifier_boss_legion_1_dash_prepare"
__TS__ClassExtends(modifier_boss_legion_1_dash_prepare, MonsterModifier_CS)
function modifier_boss_legion_1_dash_prepare.prototype.CheckState(self)
	return { [MODIFIER_STATE_COMMAND_RESTRICTED] = true, [MODIFIER_STATE_DISARMED] = true }
end
function modifier_boss_legion_1_dash_prepare.prototype.IsHidden(self)
	return true
end
function modifier_boss_legion_1_dash_prepare.prototype.IsPurgable(self)
	return false
end
modifier_boss_legion_1_dash_prepare =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_legion_1_dash_prepare)
modifier_boss_legion_1_mark = __TS__Class()
modifier_boss_legion_1_mark.name = "modifier_boss_legion_1_mark"
__TS__ClassExtends(modifier_boss_legion_1_mark, MonsterModifier_CS)
function modifier_boss_legion_1_mark.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:CreateCountdownEffect()
	self:StartIntervalThink(0.1)
	self:OnIntervalThink()
end
function modifier_boss_legion_1_mark.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local remaining = math.max(0, self:GetRemainingTime())
	local count = math.max(1, math.ceil(remaining))
	self:SetStackCount(count)
	if self.countdownPfx ~= nil then
		ParticleManager:SetParticleControl(self.countdownPfx, 1, Vector(0, count, 0))
	end
end
function modifier_boss_legion_1_mark.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.countdownPfx ~= nil then
		ParticleManager:DestroyParticle(self.countdownPfx, false)
		ParticleManager:ReleaseParticleIndex(self.countdownPfx)
		self.countdownPfx = nil
	end
end
function modifier_boss_legion_1_mark.prototype.CreateCountdownEffect(self)
	local parent = self:GetParent()
	local pfx = ParticleManager:CreateParticle(COUNTDOWN_PARTICLE, PATTACH_OVERHEAD_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		parent,
		PATTACH_OVERHEAD_FOLLOW,
		"attach_overhead",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(pfx, 1, Vector(0, COUNTDOWN_DURATION, 0))
	self.countdownPfx = pfx
end
function modifier_boss_legion_1_mark.prototype.IsDebuff(self)
	return true
end
function modifier_boss_legion_1_mark.prototype.IsPurgable(self)
	return false
end
function modifier_boss_legion_1_mark.prototype.GetTexture(self)
	return "legion_commander_duel"
end
function modifier_boss_legion_1_mark.GetLocalizationCN(self)
	return { name = "决斗点名", description = "倒计时结束后，军团将连续冲刺追猎你。" }
end
modifier_boss_legion_1_mark = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_legion_1_mark)
modifier_boss_legion_1_dash_window = __TS__Class()
modifier_boss_legion_1_dash_window.name = "modifier_boss_legion_1_dash_window"
__TS__ClassExtends(modifier_boss_legion_1_dash_window, MonsterModifier_CS)
function modifier_boss_legion_1_dash_window.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.token = 0
	self.duelTriggerRadius = 0
end
function modifier_boss_legion_1_dash_window.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.targetEntIndex = params and params.target_entindex
	self.token = params and params.token or 0
	self.duelTriggerRadius = params and params.duel_trigger_radius or 0
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_boss_legion_1_dash_window.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local target = getTargetByIndex(nil, self.targetEntIndex)
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) or not ability then
		self:Destroy()
		return
	end
	if GetDistance(nil, caster:GetAbsOrigin(), target:GetAbsOrigin()) <= self.duelTriggerRadius then
		ability:TryTriggerDuel(target, self.token, math.max(0, self:GetRemainingTime()))
		self:Destroy()
	end
end
function modifier_boss_legion_1_dash_window.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_boss_legion_1_dash_window.prototype.IsHidden(self)
	return true
end
modifier_boss_legion_1_dash_window = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_legion_1_dash_window)
local modifier_boss_legion_1_duel_base = __TS__Class()
modifier_boss_legion_1_duel_base.name = "modifier_boss_legion_1_duel_base"
__TS__ClassExtends(modifier_boss_legion_1_duel_base, MonsterModifier_CS)
function modifier_boss_legion_1_duel_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.targetEntIndex = params and params.target_entindex
	self:StartIntervalThink(0.15)
	self:OnIntervalThink()
end
function modifier_boss_legion_1_duel_base.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local target = getTargetByIndex(nil, self.targetEntIndex)
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) then
		self:Destroy()
		return
	end
	parent:SetForceAttackTarget(target)
	parent:MoveToTargetToAttack(target)
end
function modifier_boss_legion_1_duel_base.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:SetForceAttackTarget(nil)
	end
	self:DestroyDuelRing()
end
function modifier_boss_legion_1_duel_base.prototype.CreateDuelRing(self, parent)
	local pfx = ParticleManager:CreateParticle(DUEL_RING_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 1, Vector(self:GetDuelEffectRadius(), 0, 0))
	self.duelRingPfx = pfx
	self:UpdateDuelRing(parent)
end
function modifier_boss_legion_1_duel_base.prototype.UpdateDuelRing(self, parent)
	if self.duelRingPfx == nil then
		return
	end
	local origin = getGroundPosition(nil, parent:GetAbsOrigin(), parent)
	ParticleManager:SetParticleControl(self.duelRingPfx, 0, origin)
	ParticleManager:SetParticleControl(self.duelRingPfx, 7, origin)
end
function modifier_boss_legion_1_duel_base.prototype.DestroyDuelRing(self)
	if self.duelRingPfx == nil then
		return
	end
	ParticleManager:DestroyParticle(self.duelRingPfx, false)
	ParticleManager:ReleaseParticleIndex(self.duelRingPfx)
	self.duelRingPfx = nil
end
function modifier_boss_legion_1_duel_base.prototype.PlayDuelEndEffect(self, parent)
	local origin = getGroundPosition(nil, parent:GetAbsOrigin(), parent)
	local pfx = ParticleManager:CreateParticle(DUEL_END_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, Vector(self:GetDuelEffectRadius(), 0, 0))
	ParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_boss_legion_1_duel_base.prototype.GetDuelEffectRadius(self)
	return self:GetAbility():GetSpecialValueFor("duel_trigger_radius")
end
function modifier_boss_legion_1_duel_base.prototype.CheckState(self)
	return { [MODIFIER_STATE_TAUNTED] = true }
end
function modifier_boss_legion_1_duel_base.prototype.IsPurgable(self)
	return false
end
modifier_boss_legion_1_duel_caster = __TS__Class()
modifier_boss_legion_1_duel_caster.name = "modifier_boss_legion_1_duel_caster"
__TS__ClassExtends(modifier_boss_legion_1_duel_caster, modifier_boss_legion_1_duel_base)
function modifier_boss_legion_1_duel_caster.prototype.OnCreated(self, params)
	modifier_boss_legion_1_duel_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local effectDelay = params and params.effect_delay or 0
	self:Timer(effectDelay, function()
		local parent = self:GetParent()
		if IsValidAlive(nil, parent) then
			self:CreateDuelRing(parent)
		end
	end)
end
function modifier_boss_legion_1_duel_caster.prototype.OnIntervalThink(self)
	modifier_boss_legion_1_duel_base.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValidAlive(nil, parent) then
		self:UpdateDuelRing(parent)
	end
end
function modifier_boss_legion_1_duel_caster.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	local target = getTargetByIndex(nil, self.targetEntIndex)
	if IsValidAlive(nil, parent) and ability then
		if IsValidAlive(nil, target) then
			parent:MonsterDamage({ victim = target, damage_rate = DUEL_DAMAGE_RATE, ability = ability, damage_type = 1 })
		end
		self:PlayDuelEndEffect(parent)
		EmitSoundOn(DUEL_WIN_SOUND, parent)
	end
	modifier_boss_legion_1_duel_base.prototype.OnDestroy(self)
end
function modifier_boss_legion_1_duel_caster.prototype.GetTexture(self)
	return "legion_commander_duel"
end
function modifier_boss_legion_1_duel_caster.GetLocalizationCN(self)
	return { name = "强制决斗", description = "军团正在强制攻击决斗目标。" }
end
modifier_boss_legion_1_duel_caster = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_legion_1_duel_caster)
modifier_boss_legion_1_duel_target = __TS__Class()
modifier_boss_legion_1_duel_target.name = "modifier_boss_legion_1_duel_target"
__TS__ClassExtends(modifier_boss_legion_1_duel_target, modifier_boss_legion_1_duel_base)
function modifier_boss_legion_1_duel_target.prototype.IsDebuff(self)
	return true
end
function modifier_boss_legion_1_duel_target.prototype.GetTexture(self)
	return "legion_commander_duel"
end
function modifier_boss_legion_1_duel_target.GetLocalizationCN(self)
	return { name = "强制决斗", description = "被军团强制决斗，持续攻击军团。" }
end
modifier_boss_legion_1_duel_target = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_legion_1_duel_target)
return ____exports