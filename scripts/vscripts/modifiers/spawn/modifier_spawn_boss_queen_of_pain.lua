--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/spawn/modifier_spawn_boss_queen_of_pain"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__New
local g = {}
local h = require("class.weight_pool")
local i = h.CWeightPool
local j = require("modifiers.eom_modifier.eom_modifier")
local k = j.EOMModifier
local l = j.registerEOMModifier
local m = c()
m.name = "modifier_spawn_boss_queen_of_pain"
d(m, k)
function m.prototype.OnCreated(self, n)
	if not IsServer() then
		return
	end
	local o = self:GetParent()
	self:StartThink(0, function()
		o:SetForwardVector(vec3_bottom)
		return -1
	end)
	self:StartThink(1, function()
		return -1
	end)
	self:SetDuration(5.5, true)
end
function m.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local o = self:GetParent()
	o:AddNewModifier(o, nil, "modifier_boss_queenofpain", {})
end
function m.prototype.StaticProperty(self)
	return { [PropertyFunction.AVOID_DAMAGE] = 1 }
end
function m.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function m.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_INVULNERABLE] = true }
end
m = e(
	{
		l(
			a,
			{
				name = "modifier_spawn_boss_queenofpain",
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	m
)
local p = c()
p.name = "modifier_boss_queenofpain"
d(p, k)
function p.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.changeAggroEnabled = false
	self.currentStage = 0
	self.nextActionTime = 0
	self.nextMoveTime = 0
	self.nextBlinkLineComboTime = 0
	self.blinkLineComboRemaining = 0
	self.nextSonicWaveTime = 0
	self.abilityLastCastTime = {}
end
function p.prototype.OnCreated(self, n)
	if not IsServer() then
		return
	end
	local o = self:GetParent()
	self.center = o:GetAbsOrigin()
	self.queenofpain_1 = o:FindAbilityByName("queenofpain_1")
	self.queenofpain_2 = o:FindAbilityByName("queenofpain_2")
	self.queenofpain_3 = o:FindAbilityByName("queenofpain_3")
	self.queenofpain_4 = o:FindAbilityByName("queenofpain_4")
	self.queenofpain_5 = o:FindAbilityByName("queenofpain_5")
	self.queenofpain_6 = o:FindAbilityByName("queenofpain_6")
	self.queenofpain_7 = o:FindAbilityByName("queenofpain_7")
	self.queenofpain_8 = o:FindAbilityByName("queenofpain_8")
	self.queenofpain_9 = o:FindAbilityByName("queenofpain_9")
	self.queenofpain_10 = o:FindAbilityByName("queenofpain_10")
	self:OnStageChanged(self:GetDesiredStage())
	self:StartThink(0.1, "UpdateAggroTarget", function()
		if o:HasState(StateEnum.AI_DISABLED) then
			return 1
		end
		self:UpdateAggroTarget()
		return self.target == nil and 0.1 or 1
	end)
	self:StartThink(0.5, "Patrol", function()
		if o:HasState(StateEnum.AI_DISABLED) then
			return 0.5
		end
		self:Patrol()
		return 0.5
	end)
	self:StartThink(0, "BossAI", function()
		if o:HasState(StateEnum.AI_DISABLED) then
			return 0.2
		end
		self:ThinkAI()
		return 0.15
	end)
end
function p.prototype.GetDesiredStage(self)
	return self:GetParent():GetHealthPercent() <= 50 and 2 or 1
end
function p.prototype.UpdateStage(self)
	local q = self:GetDesiredStage()
	if q ~= self.currentStage then
		self:OnStageChanged(q)
	end
end
function p.prototype.OnStageChanged(self, r)
	self.currentStage = r
	local s = GameRules:GetGameTime()
	self.lastCastAbilityName = nil
	self.nextActionTime = s + 0.35
	self.nextMoveTime = s + 0.15
	if r == 2 then
		self:SetAbilityLevelAtLeast(self.queenofpain_2, 2)
		self:SetAbilityLevelAtLeast(self.queenofpain_4, 2)
		self:SetAbilityLevelAtLeast(self.queenofpain_5, 2)
		self.nextBlinkLineComboTime = s + 2
		self.nextSonicWaveTime = s + 8
		self:GetParent():EmitSound("Hero_QueenOfPain.SonicWave.Arcana")
	end
end
function p.prototype.SetAbilityLevelAtLeast(self, t, u)
	if IsValid(t) and t:GetLevel() < u then
		t:SetLevel(u)
	end
end
function p.prototype.HasValidTarget(self)
	if self.target == nil or not IsValid(self.target) or not self.target:IsAlive() then
		self.target = nil
		return false
	end
	return true
end
function p.prototype.CanExecuteAction(self)
	return self:HasValidTarget() and not self:GetParent():IsCasting()
end
function p.prototype.CanCastAbility(self, t)
	if not IsValid(t) or not t:IsAbilityReady() then
		return false
	end
	local v = t.funcCondition
	if v ~= nil and v(nil, t) ~= true then
		return false
	end
	return true
end
function p.prototype.GetDistanceToTarget(self)
	if not self:HasValidTarget() then
		return 99999
	end
	return CalcDistance(self:GetParent(), self.target)
end
function p.prototype.GetTargetPosition(self)
	return self.target:GetAbsOrigin()
end
function p.prototype.GetBossGapMultiplier(self)
	return 1 + math.max(0, GetBossGapAmplify(self:GetParent())) / 100
end
function p.prototype.GetGapDuration(self, t)
	if t == self.queenofpain_1 then
		return t:GetCastPoint() + 2
	end
	if t == self.queenofpain_2 then
		return t:GetCastPoint() + (self.currentStage == 2 and 6 or 4)
	end
	if t == self.queenofpain_3 then
		return t:GetCastPoint() + 2
	end
	if t == self.queenofpain_4 then
		return t:GetCastPoint() + 4
	end
	if t == self.queenofpain_5 then
		return t:GetCastPoint() + 2
	end
	if t == self.queenofpain_6 then
		return t:GetCastPoint() + 4
	end
	if t == self.queenofpain_7 then
		return t:GetCastPoint() + t:GetChannelTime() + 4
	end
	if t == self.queenofpain_8 then
		return t:GetCastPoint() + 4
	end
	if t == self.queenofpain_9 then
		return t:GetCastPoint() + 4
	end
	if t == self.queenofpain_10 then
		return t:GetCastPoint() + 1.2
	end
	return t:GetCastPoint() + 4
end
function p.prototype.GetMaxWait(self, w)
	local x = {
		queenofpain_1 = 15,
		queenofpain_2 = 13,
		queenofpain_3 = 11,
		queenofpain_4 = 13,
		queenofpain_5 = 7,
		queenofpain_6 = 17,
		queenofpain_7 = 21,
		queenofpain_8 = 24,
		queenofpain_9 = 36,
		queenofpain_10 = 8,
	}
	return x[w] or 12
end
function p.prototype.GetAbilityIdleTime(self, t)
	local w = t:GetAbilityName()
	local y = self.abilityLastCastTime[w] or 0
	return GameRules:GetGameTime() - y
end
function p.prototype.CanSelectAbility(self, t, z)
	if z == nil then
		z = true
	end
	if not self:CanCastAbility(t) then
		return false
	end
	local w = t:GetAbilityName()
	if z and self.lastCastAbilityName == w then
		return false
	end
	if (t == self.queenofpain_8 or t == self.queenofpain_9) and self.currentStage < 2 then
		return false
	end
	if t == self.queenofpain_7 and self:GetParent():GetHealthPercent() > 80 then
		return false
	end
	local A = self:GetDistanceToTarget()
	if
		(t == self.queenofpain_3 or t == self.queenofpain_4 or t == self.queenofpain_5 or t == self.queenofpain_10)
		and A > t:GetCastRange(vec3_zero, nil) + 150
	then
		return false
	end
	if t == self.queenofpain_4 and A < 220 then
		return false
	end
	return true
end
function p.prototype.FindOverdueAbility(self, B)
	local C = nil
	local D = 0
	do
		local E = 0
		while E < #B do
			do
				local t = B[E + 1]
				if not self:CanSelectAbility(t, true) then
					goto F
				end
				local w = t:GetAbilityName()
				local G = self:GetAbilityIdleTime(t) - self:GetMaxWait(w)
				if G > D then
					D = G
					C = t
				end
			end
			::F::
			E = E + 1
		end
	end
	return C
end
function p.prototype.GetStage1WeightedAbility(self)
	local B = {
		self.queenofpain_1,
		self.queenofpain_2,
		self.queenofpain_3,
		self.queenofpain_4,
		self.queenofpain_5,
		self.queenofpain_6,
		self.queenofpain_7,
		self.queenofpain_10,
	}
	local H = self:FindOverdueAbility(B)
	if H ~= nil then
		return H
	end
	local I = f(
		i,
		{
			queenofpain_1 = 7,
			queenofpain_2 = 8,
			queenofpain_3 = 8,
			queenofpain_4 = 6,
			queenofpain_5 = 5,
			queenofpain_6 = 7,
			queenofpain_7 = 6,
			queenofpain_10 = 10,
		}
	)
	I:Each(function(J, w)
		local t = self[w]
		if not self:CanSelectAbility(t, true) then
			I:Set(w, 0)
		end
	end)
	local w = I:Random()
	local K
	if w == nil then
		K = nil
	else
		K = self[w]
	end
	return K
end
function p.prototype.GetStage2WeightedAbility(self)
	local B = {
		self.queenofpain_1,
		self.queenofpain_2,
		self.queenofpain_3,
		self.queenofpain_4,
		self.queenofpain_5,
		self.queenofpain_6,
		self.queenofpain_7,
		self.queenofpain_10,
	}
	local H = self:FindOverdueAbility(B)
	if H ~= nil then
		return H
	end
	local I = f(
		i,
		{
			queenofpain_1 = 6,
			queenofpain_2 = 9,
			queenofpain_3 = 7,
			queenofpain_4 = 8,
			queenofpain_5 = 5,
			queenofpain_6 = 8,
			queenofpain_7 = 7,
			queenofpain_10 = 11,
		}
	)
	I:Each(function(J, w)
		local t = self[w]
		if not self:CanSelectAbility(t, true) then
			I:Set(w, 0)
		end
	end)
	local w = I:Random()
	local L
	if w == nil then
		L = nil
	else
		L = self[w]
	end
	return L
end
function p.prototype.TryCastNoTarget(self, t, M)
	if not self:CanExecuteAction() or not self:CanCastAbility(t) then
		return false
	end
	local o = self:GetParent()
	o:RemoveModifierByName("modifier_face_move")
	o:ExecuteOrder(DOTA_UNIT_ORDER_CAST_NO_TARGET, t)
	self:OnAbilityCast(t, M)
	return true
end
function p.prototype.TryCastPosition(self, t, N, M)
	if not self:CanExecuteAction() or not self:CanCastAbility(t) then
		return false
	end
	local o = self:GetParent()
	o:RemoveModifierByName("modifier_face_move")
	o:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, t, N)
	self:OnAbilityCast(t, M)
	return true
end
function p.prototype.TryCastSelectedAbility(self, t, M)
	if not self:CanSelectAbility(t, false) then
		return false
	end
	if
		t == self.queenofpain_1
		or t == self.queenofpain_6
		or t == self.queenofpain_7
		or t == self.queenofpain_8
		or t == self.queenofpain_9
	then
		return self:TryCastNoTarget(t, M)
	end
	return self:TryCastPosition(t, self:GetTargetPosition(), M)
end
function p.prototype.OnAbilityCast(self, t, M)
	local s = GameRules:GetGameTime()
	self.lastCastAbilityName = t:GetAbilityName()
	self.abilityLastCastTime[self.lastCastAbilityName] = s
	self.nextActionTime = s + (M or self:GetGapDuration(t)) * self:GetBossGapMultiplier()
	self.nextMoveTime = s + (self.currentStage == 2 and 0.12 or 0.18)
end
function p.prototype.TryHandleBlinkLineCombo(self, s)
	if self.currentStage < 2 then
		return false
	end
	if
		self.blinkLineComboRemaining <= 0
		and s >= self.nextBlinkLineComboTime
		and self:CanSelectAbility(self.queenofpain_8, true)
	then
		self.blinkLineComboRemaining = 3
	end
	if self.blinkLineComboRemaining <= 0 then
		return false
	end
	if self.blinkLineComboRemaining < 3 then
		self.queenofpain_8:EndCooldown()
	end
	if not self:TryCastSelectedAbility(self.queenofpain_8, 1.55) then
		return true
	end
	self.blinkLineComboRemaining = self.blinkLineComboRemaining - 1
	if self.blinkLineComboRemaining <= 0 then
		self.nextBlinkLineComboTime = s + 26 * self:GetBossGapMultiplier()
		self.nextActionTime = s + 2.1 * self:GetBossGapMultiplier()
	end
	return true
end
function p.prototype.TryCastLowFrequencySonicWave(self, s)
	if self.currentStage < 2 or s < self.nextSonicWaveTime then
		return false
	end
	if not self:CanSelectAbility(self.queenofpain_9, true) then
		return false
	end
	if not self:TryCastSelectedAbility(self.queenofpain_9) then
		return false
	end
	self.nextSonicWaveTime = s + 34 * self:GetBossGapMultiplier()
	return true
end
function p.prototype.ThinkAI(self)
	self:UpdateStage()
	local s = GameRules:GetGameTime()
	if not self:CanExecuteAction() then
		return
	end
	if s < self.nextActionTime then
		self:ExecuteGapMovement(s)
		return
	end
	if self:TryHandleBlinkLineCombo(s) then
		return
	end
	if self:TryCastLowFrequencySonicWave(s) then
		return
	end
	local O
	if self.currentStage == 2 then
		O = self:GetStage2WeightedAbility()
	else
		O = self:GetStage1WeightedAbility()
	end
	local t = O
	if t ~= nil and self:TryCastSelectedAbility(t) then
		return
	end
	self:ExecuteGapMovement(s)
end
function p.prototype.FaceMove(self)
	if IsValid(self.target) then
		local o = self:GetParent()
		local P = o:Script_GetAttackRange()
		o:AddNewModifier(
			o,
			nil,
			"modifier_face_move",
			{ target = self.target:entindex(), moveType = "strafe", radius = P, duration = 0.5 }
		)
	end
end
function p.prototype.MoveToEnemy(self)
	if IsValid(self.target) then
		local o = self:GetParent()
		local A = CalcDistance(o, self.target)
		local Q = o:Script_GetAttackRange()
		if A > Q then
			local R = self.target:GetAbsOrigin()
			local S = CalcDirection(o, self.target)
			local T = R - S * Q * 0.5
			o:MoveToPosition(T)
		end
	end
end
function p.prototype.ExecuteGapMovement(self, s)
	if s < self.nextMoveTime or not self:HasValidTarget() or self:GetParent():IsCasting() then
		return
	end
	local o = self:GetParent()
	local A = CalcDistance(o, self.target)
	local Q = o:Script_GetAttackRange()
	self.nextMoveTime = s + 0.35
	if A <= Q then
		self:FaceMove()
	else
		self:MoveToEnemy()
	end
end
function p.prototype.Patrol(self)
	local o = self:GetParent()
	if self.target == nil and not o:IsRooted() and not o:IsMoving() and not o:IsCasting() then
		local N = self.center + RandomVector(RandomInt(0, o:GetAcquisitionRange()))
		o:ExecuteOrder(DOTA_UNIT_ORDER_MOVE_TO_POSITION, N)
	end
end
function p.prototype.UpdateAggroTarget(self)
	local o = self:GetParent()
	local U = Player:FindNearestAliveEnemyHero(o:GetTeamNumber(), o:GetAbsOrigin(), o:GetAcquisitionRange())
	if U == nil then
		self.target = nil
		return
	end
	if self.target == nil then
		self.target = U
		self.changeAggroEnabled = false
		self:StartThink(10, "EnableAggroChange", function()
			self.changeAggroEnabled = true
			return -1
		end)
		return
	end
	if self.changeAggroEnabled then
		self.target = U
		self.changeAggroEnabled = false
		self:StartThink(10, "EnableAggroChange", function()
			self.changeAggroEnabled = true
			return -1
		end)
	end
end
function p.prototype.EventListener(self)
	return {
		entity_killed = function(J, V)
			if self.target ~= nil and V.victim == self.target then
				self.target = nil
				self:UpdateAggroTarget()
			end
		end,
	}
end
p = e(
	{
		l(
			a,
			{
				name = "modifier_boss_queenofpain",
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	p
)
return g