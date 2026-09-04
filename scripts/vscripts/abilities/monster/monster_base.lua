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
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local ____exports = {}
local ____base_ability = require("abilities._base.base_ability")
local BaseAbility_CS = ____base_ability.BaseAbility_CS
local ____monster_warning_effects = require("modifiers.monster.monster_warning_effects")
local findHeroesInRadius = ____monster_warning_effects.findHeroesInRadius
local warningEffectLinear = ____monster_warning_effects.warningEffectLinear
local warningEffectRing = ____monster_warning_effects.warningEffectRing
do
	local ____monster_modifier_cs = require("modifiers.monster.monster_modifier_cs")
	____exports.MonsterModifier_CS = ____monster_modifier_cs.MonsterModifier_CS
end
do
	local ____monster_warning_effects = require("modifiers.monster.monster_warning_effects")
	____exports.warningEffectRing = ____monster_warning_effects.warningEffectRing
end
local MONSTER_CAST_FINISH_CUE_LEAD_TIME = 0.08
local MONSTER_CAST_FINISH_CUE_SOUND = "Building_Tower.Aggro"
--- 解析施法者怪物子类：优先 KV `UnitType`，否则回退 IsBoss / IsMiniboss / IsElite
local function resolveMonsterCastUnitType(self, unit)
	if not IsValidAlive(nil, unit) then
		return UnitType.MONSTER_NORMAL
	end
	local ____this_1
	____this_1 = unit
	local ____opt_0 = ____this_1.GetUnitType
	local kv = ____opt_0 and ____opt_0(____this_1)
	if
		kv == UnitType.MONSTER_BOSS
		or kv == UnitType.MONSTER_MINIBOSS
		or kv == UnitType.MONSTER_ELITE
		or kv == UnitType.MONSTER_NORMAL
	then
		return kv
	end
	local ____this_3
	____this_3 = unit
	local ____opt_2 = ____this_3.IsBoss
	if (____opt_2 and ____opt_2(____this_3)) == true then
		return UnitType.MONSTER_BOSS
	end
	local ____this_5
	____this_5 = unit
	local ____opt_4 = ____this_5.IsMiniboss
	if (____opt_4 and ____opt_4(____this_5)) == true then
		return UnitType.MONSTER_MINIBOSS
	end
	local ____this_7
	____this_7 = unit
	local ____opt_6 = ____this_7.IsElite
	if (____opt_6 and ____opt_6(____this_7)) == true then
		return UnitType.MONSTER_ELITE
	end
	return UnitType.MONSTER_NORMAL
end
--- 普通怪：前摇可被人直接打断；不施加 debuff 免疫/破招窗口；打断时不播收尾粒子、不自晕（慢动作仅走破招链，普通怪无窗口即不会触发）
local function isMonsterNormalForCastFramework(self, unit)
	return resolveMonsterCastUnitType(nil, unit) == UnitType.MONSTER_NORMAL
end
--- 怪物技能基类，继承自通用 BaseAbility_CS
____exports.MonsterAbility_CS = __TS__Class()
local MonsterAbility_CS = ____exports.MonsterAbility_CS
MonsterAbility_CS.name = "MonsterAbility_CS"
__TS__ClassExtends(MonsterAbility_CS, BaseAbility_CS)
function MonsterAbility_CS.prototype.____constructor(self, ...)
	BaseAbility_CS.prototype.____constructor(self, ...)
	self._skipNextPhaseInterrupted = false
	self._defaultThunderizedCounterBreakStunDuration = 0.5
end
function MonsterAbility_CS.prototype.DebugBossPhaseCastFlow(self, stage, extra)
	if not IsServer() then
		return
	end
	local ____opt_8 = self.IsBossPhaseTransitionAbility
	if not (____opt_8 and ____opt_8(self)) then
		return
	end
	local caster = self._caster or self:GetCaster()
	local ____IsValid_result_10
	if IsValid(nil, caster) then
		____IsValid_result_10 = caster:GetUnitName()
	else
		____IsValid_result_10 = "<invalid>"
	end
	local casterName = ____IsValid_result_10
	local abilityName = self:GetAbilityName()
	local hiddenOk, hiddenValue = pcall(function()
		return self:IsHidden()
	end)
	local ____hiddenOk_11
	if hiddenOk then
		____hiddenOk_11 = hiddenValue
	else
		____hiddenOk_11 = false
	end
	local hidden = ____hiddenOk_11
	local ____IsValidAlive_result_12
	if IsValidAlive(nil, caster) then
		____IsValidAlive_result_12 = caster:IsStunned()
	else
		____IsValidAlive_result_12 = false
	end
	local stunned = ____IsValidAlive_result_12
	local ____IsValidAlive_result_15
	if IsValidAlive(nil, caster) then
		local ____opt_13 = caster.IsMonsterCasting
		____IsValidAlive_result_15 = (____opt_13 and ____opt_13(caster)) == true
	else
		____IsValidAlive_result_15 = false
	end
	local monsterCasting = ____IsValidAlive_result_15
	local ____IsValidAlive_result_16
	if IsValidAlive(nil, caster) then
		____IsValidAlive_result_16 = caster:HasModifier("modifier_monster_cast_pre_progress")
	else
		____IsValidAlive_result_16 = false
	end
	local preProgress = ____IsValidAlive_result_16
	local ____IsValidAlive_result_17
	if IsValidAlive(nil, caster) then
		____IsValidAlive_result_17 = caster:HasModifier("modifier_monster_cast_controller")
	else
		____IsValidAlive_result_17 = false
	end
	local castController = ____IsValidAlive_result_17
	local ____print_20 = print
	local ____stage_19 = stage
	local ____extra_18
	if extra then
		____extra_18 = " " .. extra
	else
		____extra_18 = ""
	end
	____print_20(
		(
			(
				(
					(
						(
							(
								(
									(
										(
											(
												(
													(
														(
															(("[BossPhaseFlow] " .. ____stage_19) .. " ability=")
															.. abilityName
														) .. " caster="
													) .. casterName
												) .. " hidden="
											) .. tostring(hidden)
										) .. " stunned="
									) .. tostring(stunned)
								) .. " monsterCasting="
							) .. tostring(monsterCasting)
						) .. " pre="
					) .. tostring(preProgress)
				) .. " controller="
			) .. tostring(castController)
		) .. ____extra_18
	)
end
function MonsterAbility_CS.prototype.GetMosnterAbilityConfig(self)
	return { castDuration = 0, castPoint = 0.5 }
end
function MonsterAbility_CS.prototype.ShouldUseSeasonRuleset(self)
	return false
end
function MonsterAbility_CS.prototype.GetBaseCastPointValue(self)
	return self:GetMosnterAbilityConfig().castPoint or BaseAbility_CS.prototype.GetBaseCastPointValue(self)
end
function MonsterAbility_CS.prototype.IsBossPhaseTransitionAbility(self)
	return false
end
function MonsterAbility_CS.prototype.CanTriggerBossPhaseTransition(self, _caster)
	return false
end
function MonsterAbility_CS.prototype.MarkBossPhaseTransitionTriggered(self) end
function MonsterAbility_CS.prototype.Timer(self, delay, callback)
	Timers:CreateTimer(delay, function()
		if
			not self
			or not IsValid(nil, self)
			or not self._caster
			or not IsValid(nil, self._caster)
			or not IsValidAlive(nil, self._caster)
		then
			return
		end
		return SafelyCall(nil, function()
			return callback(nil)
		end)
	end)
end
function MonsterAbility_CS.prototype.GetAbilityConfig(self)
	local cfg = self:GetMosnterAbilityConfig()
	return {
		animationPlaybackRate = cfg.animationPlaybackRate,
		behavior = cfg.behavior,
		castPoint = cfg.castPoint,
		castAnimation = cfg.castAnimation,
		castRange = cfg.castRange,
		cooldown = cfg.cooldown,
		manaCost = cfg.manaCost,
		healthCost = cfg.healthCost,
		canCast = cfg.canCast,
		castError = cfg.castError,
	}
end
function MonsterAbility_CS.prototype.CleanupPrecastVisuals(self, token)
	if not IsServer() then
		return
	end
	if token and self._precastToken and token ~= self._precastToken then
		return
	end
	self._precastToken = nil
	if IsValid(nil, self._caster) then
		self._caster:RemoveModifierByName("modifier_monster_cast_pre_move")
		self._caster:RemoveModifierByName("modifier_monster_cast_pre_progress")
		self._caster:RemoveModifierByName("modifier_monster_cast_debuff_immune")
	end
end
function MonsterAbility_CS.prototype.RemovePrePhaseMoveMarker(self)
	if not IsServer() then
		return
	end
	if IsValid(nil, self._caster) then
		self._caster:RemoveModifierByName("modifier_monster_cast_pre_move")
	end
end
function MonsterAbility_CS.prototype.ScheduleFinishCueBeforeSpellStart(self, castPoint, token)
	if not token then
		return
	end
	local delay = math.max(castPoint - MONSTER_CAST_FINISH_CUE_LEAD_TIME, 0)
	self:Timer(delay, function()
		if self._precastToken ~= token then
			return
		end
		if not IsValidAlive(nil, self._caster) then
			return
		end
		if castPoint > 0 and not self._caster:HasModifier("modifier_monster_cast_pre_progress") then
			return
		end
		if self._caster:IsStunned() then
			return
		end
		self:PlayFinishCue(token)
	end)
end
function MonsterAbility_CS.prototype.PlayFinishCue(self, token)
	if token and self._finishCueToken == token then
		return
	end
	if not IsValidAlive(nil, self._caster) then
		return
	end
	self:PlayFinishEffect(false)
	self._caster:EmitSound(MONSTER_CAST_FINISH_CUE_SOUND)
	if token then
		self._finishCueToken = token
	end
end
function MonsterAbility_CS.prototype.OnAbilityPhaseStart(self)
	if not IsServer() then
		return true
	end
	local cfg = self:GetMosnterAbilityConfig()
	local castPoint = cfg.castPoint or 0
	self:DebugBossPhaseCastFlow(
		"OnAbilityPhaseStart",
		(("castPoint=" .. tostring(castPoint)) .. " castDuration=") .. tostring(cfg.castDuration or 0)
	)
	local token = self:BeginPrecastToken()
	if cfg.OnPrePhaseMove then
		self:StartDynamicPrePhaseMove(cfg, token)
		self._dynamicPrePhaseNativeToken = token
		return true
	end
	self:StartPhaseStartLayer(cfg, token)
	return true
end
function MonsterAbility_CS.prototype.BeginPrecastToken(self)
	self:CleanupPrecastVisuals()
	self._dynamicPrePhaseNativeToken = nil
	local token = DoUniqueString("monster_precast")
	self._precastToken = token
	return token
end
function MonsterAbility_CS.prototype.StartPhaseStartLayer(self, cfg, token)
	local castPoint = cfg.castPoint or 0
	if token ~= self._precastToken then
		return
	end
	if not IsValidAlive(nil, self._caster) then
		return
	end
	self:RemovePrePhaseMoveMarker()
	local ut = resolveMonsterCastUnitType(nil, self._caster)
	local point = MyGameMonsterCounterBreak:GetInterruptWindowDuration(
		self._caster,
		ut,
		castPoint,
		cfg.counterBreakWindowDuration
	)
	local isNormalMonster = isMonsterNormalForCastFramework(nil, self._caster)
	if castPoint > 0 then
		local ____self_23 = self._caster
		local ____self_23_AddNewModifier_24 = ____self_23.AddNewModifier
		local ____self__caster_22 = self._caster
		local ____isNormalMonster_21
		if isNormalMonster then
			____isNormalMonster_21 = castPoint
		else
			____isNormalMonster_21 = point
		end
		____self_23_AddNewModifier_24(
			____self_23,
			____self__caster_22,
			self,
			"modifier_monster_cast_pre_progress",
			{ time = castPoint, interruptWindow = ____isNormalMonster_21 }
		)
	end
	self:ScheduleFinishCueBeforeSpellStart(castPoint, token)
	if not isNormalMonster and castPoint > 0 then
		local ____temp_25
		if cfg.castPointDamageReduction ~= nil then
			____temp_25 = cfg.castPointDamageReduction
		else
			____temp_25 = ut == UnitType.MONSTER_BOSS and 80 or 0
		end
		local damageReduction = ____temp_25
		self._caster:AddNewModifier(
			self._caster,
			self,
			"modifier_monster_cast_debuff_immune",
			{ duration = castPoint, point = point, damageReduction = damageReduction }
		)
	end
	SafelyCall(nil, function()
		local ____this_27
		____this_27 = cfg
		local ____opt_26 = ____this_27.OnPhaseStart
		return ____opt_26 and ____opt_26(____this_27)
	end, "MonsterAbility_CS.OnPhaseStart")
end
function MonsterAbility_CS.prototype.StartDynamicPrePhaseMove(self, cfg, token)
	if not IsValidAlive(nil, self._caster) then
		return
	end
	self._caster:AddNewModifier(self._caster, self, "modifier_monster_cast_pre_move", {})
	self:StartManualPrecastInterruptMonitor(cfg, token)
	local finished = false
	local function finishMove()
		if finished then
			return
		end
		finished = true
		if token ~= self._precastToken then
			return
		end
		if not IsValidAlive(nil, self._caster) or self._caster:IsStunned() then
			self:InterruptPrecastFlow(cfg, token)
			return
		end
		self:StartPhaseStartLayer(cfg, token)
		self:ScheduleManualSpellStart(cfg, token)
	end
	local timeout = math.max(cfg.prePhaseMoveTimeout or 0, 0)
	if timeout > 0 then
		self:Timer(timeout, finishMove)
	end
	SafelyCall(nil, function()
		local ____this_29
		____this_29 = cfg
		local ____opt_28 = ____this_29.OnPrePhaseMove
		return ____opt_28 and ____opt_28(____this_29, finishMove)
	end, "MonsterAbility_CS.OnPrePhaseMove")
end
function MonsterAbility_CS.prototype.ScheduleManualSpellStart(self, cfg, token)
	local castPoint = math.max(cfg.castPoint or 0, 0)
	if castPoint <= 0 then
		self:CompletePrecastAndStart(cfg, token, true)
		return
	end
	self:Timer(castPoint, function()
		return self:CompletePrecastAndStart(cfg, token, true)
	end)
end
function MonsterAbility_CS.prototype.StartManualPrecastInterruptMonitor(self, cfg, token)
	self:Timer(FrameTime(), function()
		if token ~= self._precastToken then
			return
		end
		if not IsValidAlive(nil, self._caster) or self._caster:IsStunned() then
			self:InterruptPrecastFlow(cfg, token)
			return
		end
		return FrameTime()
	end)
end
function MonsterAbility_CS.prototype.OnAbilityPhaseInterrupted(self)
	if not IsServer() then
		return
	end
	local cfg = self:GetMosnterAbilityConfig()
	if cfg.OnPrePhaseMove and self._precastToken then
		self._dynamicPrePhaseNativeToken = nil
		self:DebugBossPhaseCastFlow(
			"OnAbilityPhaseInterrupted:ignoreDynamicPrePhase",
			"castPoint=" .. tostring(cfg.castPoint or 0)
		)
		return
	end
	if self._skipNextPhaseInterrupted then
		self._skipNextPhaseInterrupted = false
		return
	end
	self:DebugBossPhaseCastFlow(
		"OnAbilityPhaseInterrupted",
		(("castPoint=" .. tostring(cfg.castPoint or 0)) .. " castDuration=") .. tostring(cfg.castDuration or 0)
	)
	self:InterruptPrecastFlow(cfg, self._precastToken)
end
function MonsterAbility_CS.prototype.StartConfiguredCooldown(self)
	local cd = self:GetCooldown(self:GetLevel() - 1)
	if cd > 0 then
		self:StartCooldown(cd)
	end
end
function MonsterAbility_CS.prototype.InterruptPrecastFlow(self, cfg, token)
	if token and self._precastToken and token ~= self._precastToken then
		return
	end
	SafelyCall(nil, function()
		local ____this_31
		____this_31 = cfg
		local ____opt_30 = ____this_31.OnInterrupt
		return ____opt_30 and ____opt_30(____this_31)
	end, "MonsterAbility_CS.OnInterrupt")
	SafelyCall(nil, function()
		local ____this_33
		____this_33 = cfg
		local ____opt_32 = ____this_33.OnFinish
		return ____opt_32 and ____opt_32(____this_33)
	end, "MonsterAbility_CS.OnFinish")
	if not IsValidAlive(nil, self._caster) then
		return
	end
	self:CleanupPrecastVisuals(token)
	if not isMonsterNormalForCastFramework(nil, self._caster) then
		self:PlayFinishEffect(true)
		AddDeBuffStatus(nil, self._caster, self._caster, self, DebuffStatusType.STUN, { duration = 4 })
	end
	self:StartConfiguredCooldown()
	self._caster:Stop()
end
function MonsterAbility_CS.prototype.TryTriggerThunderizedCounterBreak(self, attacker)
	if not IsServer() then
		return false
	end
	if not IsValidAlive(nil, self._caster) or not IsValidAlive(nil, attacker) then
		return false
	end
	local ____this_35
	____this_35 = self._caster
	local ____opt_34 = ____this_35.IsMonsterCasting
	if (____opt_34 and ____opt_34(____this_35)) ~= true then
		return false
	end
	local cfg = self:GetMosnterAbilityConfig()
	if cfg.thunderizedCounterBreak ~= true then
		return false
	end
	local hasPrecast = self._caster:HasModifier("modifier_monster_cast_pre_move")
		or self._caster:HasModifier("modifier_monster_cast_pre_progress")
	local hasDuration = self._caster:HasModifier("modifier_monster_cast_controller")
	if not hasPrecast and not hasDuration then
		return false
	end
	if hasPrecast then
		self._skipNextPhaseInterrupted = true
		Timers:CreateTimer(0.2, function()
			self._skipNextPhaseInterrupted = false
		end)
	end
	SafelyCall(nil, function()
		local ____opt_36 = cfg.OnInterrupt
		return ____opt_36 and ____opt_36(cfg)
	end, "MonsterAbility_CS.ThunderizedCounterBreak.OnInterrupt")
	self:CleanupPrecastVisuals(self._precastToken)
	if hasDuration then
		self:DestroyDuration()
	else
		SafelyCall(nil, function()
			local ____opt_38 = cfg.OnFinish
			return ____opt_38 and ____opt_38(cfg)
		end, "MonsterAbility_CS.ThunderizedCounterBreak.OnFinish")
	end
	self:PlayFinishEffect(true)
	local stunDuration =
		math.max(cfg.thunderizedCounterBreakStunDuration or self._defaultThunderizedCounterBreakStunDuration, 0.1)
	self._caster:AddNewModifier(attacker, self, "modifier_generic_stunned", { duration = stunDuration })
	local cd = self:GetCooldown(self:GetLevel() - 1)
	if cd > 0 then
		self:StartCooldown(cd)
	end
	MyGameMonsterCounterBreak:TriggerThunderizedCounterBreak(self._caster)
	return true
end
function MonsterAbility_CS.prototype.PlayFinishEffect(self, interrupted)
	local effectName = interrupted and "particles/hero/hero_ability_bk_2b.vpcf"
		or "particles/hero/hero_ability_bkb.vpcf"
	local effect = ParticleManager:CreateParticle(effectName, PATTACH_CENTER_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(effect, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(
		effect,
		1,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetCaster():GetAbsOrigin(),
		false
	)
	if not interrupted then
		local castColor = self:GetMosnterAbilityConfig().castColor or Vector(255, 0, 0)
		ParticleManager:SetParticleControl(effect, 60, castColor)
		ParticleManager:SetParticleControl(effect, 61, Vector(1, 0, 0))
	end
	ParticleManager:ReleaseParticleIndex(effect)
end
function MonsterAbility_CS.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local cfg = self:GetMosnterAbilityConfig()
	if cfg.OnPrePhaseMove then
		if self._dynamicPrePhaseNativeToken then
			self._dynamicPrePhaseNativeToken = nil
			return
		end
		if not self._precastToken then
			local token = self:BeginPrecastToken()
			self:StartDynamicPrePhaseMove(cfg, token)
			return
		end
	end
	self:CompletePrecastAndStart(cfg, self._precastToken, false)
end
function MonsterAbility_CS.prototype.CompletePrecastAndStart(self, cfg, precastToken, manualCast)
	if precastToken and self._precastToken ~= precastToken then
		return
	end
	local castDuration = cfg.castDuration or 0
	self:DebugBossPhaseCastFlow("OnSpellStart:enter", "castDuration=" .. tostring(castDuration))
	self:CleanupPrecastVisuals(precastToken)
	local dead = not IsValidAlive(nil, self._caster)
	local stunned = not dead and self._caster:IsStunned()
	local function finishNow(____, interrupted)
		self:DebugBossPhaseCastFlow("OnSpellStart:finishNow", "interrupted=" .. tostring(interrupted))
		if interrupted then
			SafelyCall(nil, function()
				local ____this_41
				____this_41 = cfg
				local ____opt_40 = ____this_41.OnInterrupt
				return ____opt_40 and ____opt_40(____this_41)
			end, "MonsterAbility_CS.OnInterrupt")
		end
		SafelyCall(nil, function()
			local ____this_43
			____this_43 = cfg
			local ____opt_42 = ____this_43.OnFinish
			return ____opt_42 and ____opt_42(____this_43)
		end, "MonsterAbility_CS.OnFinish")
		self:StartConfiguredCooldown()
	end
	if dead or stunned then
		self:DebugBossPhaseCastFlow(
			"OnSpellStart:blocked",
			(("dead=" .. tostring(dead)) .. " stunned=") .. tostring(stunned)
		)
		finishNow(nil, true)
		return
	end
	self:PlayFinishCue(precastToken)
	self:DebugBossPhaseCastFlow("OnSpellStart:OnStart:before")
	SafelyCall(nil, function()
		local ____this_45
		____this_45 = cfg
		local ____opt_44 = ____this_45.OnStart
		return ____opt_44 and ____opt_44(____this_45)
	end, "MonsterAbility_CS.OnStart")
	self:DebugBossPhaseCastFlow("OnSpellStart:OnStart:after")
	if castDuration <= 0 then
		finishNow(nil, false)
		return
	end
	if manualCast then
		self:StartConfiguredCooldown()
	end
	local lockActions = cfg.isNotMove ~= false
	self._caster:SetPostureLocked(true)
	self:DebugBossPhaseCastFlow(
		"OnSpellStart:addCastController",
		(("duration=" .. tostring(castDuration)) .. " lockActions=") .. tostring(lockActions)
	)
	self._caster:AddNewModifier(
		self._caster,
		self,
		"modifier_monster_cast_controller",
		{ duration = castDuration, __lock_actions = lockActions and 1 or 0 }
	)
end
function MonsterAbility_CS.prototype.DestroyDuration(self)
	if not IsServer() then
		return
	end
	if not IsValid(nil, self._caster) or self._caster:IsNull() then
		return
	end
	self._caster:RemoveModifierByName("modifier_monster_cast_controller")
end
function MonsterAbility_CS.prototype.GetAnimationIgnoresModelScale(self)
	return true
end
function MonsterAbility_CS.prototype.GetAbilityTargetType(self)
	return bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC)
end
function MonsterAbility_CS.prototype.GetAbilityTargetTeam(self)
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function MonsterAbility_CS.prototype.GetMinDistanceUnit(self, range, p)
	return self._caster:GetMinDistanceUnit(range, p)
end
function MonsterAbility_CS.prototype.WarningEffect(self, start_pos, end_pos, duration, options)
	local ____warningEffectLinear_51 = warningEffectLinear
	local ____array_50 = __TS__SparseArrayNew(nil, self._caster, self, start_pos, end_pos, duration)
	local ____options_49 = options
	local ____temp_48 = options and options.follow
	if ____temp_48 == nil then
		____temp_48 = false
	end
	__TS__SparseArrayPush(____array_50, __TS__ObjectAssign({}, ____options_49, { follow = ____temp_48 }))
	____warningEffectLinear_51(__TS__SparseArraySpread(____array_50))
end
function MonsterAbility_CS.prototype.WarningRingEffect(self, center, damageRadius, duration, options)
	warningEffectRing(nil, self._caster, center, damageRadius, duration, options)
end
function MonsterAbility_CS.prototype.FindHeroesInRadius(self, range, point)
	return findHeroesInRadius(nil, self._caster:GetTeamNumber(), point or self._caster:GetAbsOrigin(), range)
end
return ____exports