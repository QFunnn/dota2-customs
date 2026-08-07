--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/spawn/modifier_boss_treant"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_spawn_boss_treant"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsServer() then
		local l = self:GetParent()
		self:StartThink(0, function()
			l:SetForwardVector(vec3_bottom)
			return -1
		end)
		self:StartThink(1, function()
			EmitGlobalSound("Treant.Spawn")
			l:StartGesture(ACT_DOTA_TELEPORT)
			return -1
		end)
		self:SetDuration(4, true)
	end
end
function j.prototype.OnDestroy(self)
	if IsServer() then
		local l = self:GetParent()
		l:RemoveGesture(ACT_DOTA_TELEPORT)
		l:AddNewModifier(l, nil, "modifier_boss_treant", {})
	end
end
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.AVOID_DAMAGE] = 1 }
end
function j.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function j.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_INVULNERABLE] = true }
end
j = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	j
)
local m = c()
m.name = "modifier_boss_treant"
d(m, h)
function m.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.changeAggroEnabled = false
	self.nextActionTime = 0
	self.nextMoveTime = 0
	self.currentStage = 1
	self.usedArmorThresholds = {}
	self.nextGrabSearchTime = 0
	self.nextTreeSummonTime = 0
end
function m.prototype.OnCreated(self, k)
	if not IsServer() then
		return
	end
	local l = self:GetParent()
	self.center = l:GetAbsOrigin()
	self.boss_treant_1 = l:FindAbilityByName("boss_treant_1")
	self.boss_treant_2 = l:FindAbilityByName("boss_treant_2")
	self.boss_treant_3 = l:FindAbilityByName("boss_treant_3")
	self.boss_treant_4 = l:FindAbilityByName("boss_treant_4")
	self.boss_treant_5 = l:FindAbilityByName("boss_treant_5")
	self.boss_treant_6 = l:FindAbilityByName("boss_treant_6")
	self.boss_treant_7 = l:FindAbilityByName("boss_treant_7")
	self.boss_shredder_1 = l:FindAbilityByName("boss_shredder_1")
	self:SetAbilityLevelAtLeast(self.boss_shredder_1, 1)
	self:StartThink(0.1, "UpdateAggroTarget", function()
		if l:HasState(StateEnum.AI_DISABLED) then
			return 1
		end
		self:UpdateAggroTarget()
		return self.target == nil and 0.1 or 1
	end)
	self:StartThink(0.5, "Patrol", function()
		if l:HasState(StateEnum.AI_DISABLED) then
			return 0.5
		end
		self:Patrol()
		return 0.5
	end)
	self:StartThink(0, "BossAI", function()
		if l:HasState(StateEnum.AI_DISABLED) then
			return 0.2
		end
		self:UpdateStage()
		self:ThinkAI()
		return 0.15
	end)
end
function m.prototype.UpdateStage(self)
	local n = self:GetParent():GetHealthPercent()
	if n <= 30 and self.currentStage < 3 then
		self.currentStage = 3
		self:SetAbilityLevelAtLeast(self.boss_treant_2, 2)
		self:SetAbilityLevelAtLeast(self.boss_treant_3, 2)
		self:SetAbilityLevelAtLeast(self.boss_treant_7, 3)
		return
	end
	if n <= 60 and self.currentStage < 2 then
		self.currentStage = 2
		self:SetAbilityLevelAtLeast(self.boss_treant_7, 2)
	end
end
function m.prototype.SetAbilityLevelAtLeast(self, o, p)
	if IsValid(o) and o:GetLevel() < p then
		o:SetLevel(p)
	end
end
function m.prototype.HasValidTarget(self)
	if self.target == nil or not IsValid(self.target) or not self.target:IsAlive() then
		self.target = nil
		return false
	end
	return true
end
function m.prototype.CanExecuteAction(self)
	return self:HasValidTarget() and not self:GetParent():IsCasting()
end
function m.prototype.CanCastAbility(self, o)
	if not IsValid(o) or not o:IsAbilityReady() then
		return false
	end
	local q = o.funcCondition
	if q ~= nil and q(nil, o) ~= true then
		return false
	end
	return true
end
function m.prototype.GetDistanceToTarget(self)
	if not self:HasValidTarget() then
		return 99999
	end
	return CalcDistance(self:GetParent(), self.target)
end
function m.prototype.GetTargetPosition(self)
	if not self:HasValidTarget() then
		return nil
	end
	return self.target:GetAbsOrigin()
end
function m.prototype.GetBossGapMultiplier(self)
	return 1 + math.max(0, GetBossGapAmplify(self:GetParent())) / 100
end
function m.prototype.GetGapDuration(self, o)
	if o == self.boss_treant_1 then
		return o:GetCastPoint() + 1.1
	end
	if o == self.boss_treant_2 then
		return o:GetCastPoint() + 1.8
	end
	if o == self.boss_treant_3 then
		return o:GetChannelTime() + 0.6
	end
	if o == self.boss_treant_7 then
		return o:GetChannelTime() + 0.6
	end
	if o == self.boss_treant_4 then
		return o:GetChannelTime() + 0.3
	end
	if o == self.boss_treant_5 then
		return o:GetCastPoint() + 0.4
	end
	if o == self.boss_treant_6 then
		return o:GetCastPoint() + 1.2
	end
	if o == self.boss_shredder_1 then
		return o:GetCastPoint() + 1.5
	end
	return o:GetCastPoint() + 1
end
function m.prototype.AfterCast(self, o, r)
	local s = GameRules:GetGameTime()
	self.nextActionTime = s + (r or self:GetGapDuration(o)) * self:GetBossGapMultiplier()
	self.nextMoveTime = s + 0.2
end
function m.prototype.TryCastOnPosition(self, o, t, r)
	if not self:CanExecuteAction() or not self:CanCastAbility(o) then
		return false
	end
	local l = self:GetParent()
	l:RemoveModifierByName("modifier_face_move")
	l:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, o, t)
	self:AfterCast(o, r)
	return true
end
function m.prototype.TryCastOnTarget(self, o, u, r)
	if not self:CanExecuteAction() or not self:CanCastAbility(o) or not IsValid(u) or not u:IsAlive() then
		return false
	end
	local l = self:GetParent()
	l:RemoveModifierByName("modifier_face_move")
	l:ExecuteOrder(DOTA_UNIT_ORDER_CAST_TARGET, o, u)
	self:AfterCast(o, r)
	return true
end
function m.prototype.TryCastNoTarget(self, o, r)
	if not self:CanExecuteAction() or not self:CanCastAbility(o) then
		return false
	end
	local l = self:GetParent()
	l:RemoveModifierByName("modifier_face_move")
	l:ExecuteOrder(DOTA_UNIT_ORDER_CAST_NO_TARGET, o)
	self:AfterCast(o, r)
	return true
end
function m.prototype.GetPendingArmorThreshold(self)
	local n = self:GetParent():GetHealthPercent()
	local v = { 80, 50, 20 }
	do
		local w = 0
		while w < #v do
			local x = v[w + 1]
			if n <= x and self.usedArmorThresholds[x] ~= true then
				return x
			end
			w = w + 1
		end
	end
	return nil
end
function m.prototype.TryCastTriggeredArmor(self)
	local x = self:GetPendingArmorThreshold()
	if x == nil then
		return false
	end
	if self:TryCastNoTarget(self.boss_treant_4) then
		self.usedArmorThresholds[x] = true
		return true
	end
	return false
end
function m.prototype.GetCatchUnit(self)
	if not IsValid(self.boss_treant_5) then
		return nil
	end
	local y = self.boss_treant_5:GetCatchUnit()
	if not IsValid(y) or not y:IsAlive() then
		return nil
	end
	return y
end
function m.prototype.GetTreeCount(self)
	if not IsValid(self.boss_shredder_1) then
		return 0
	end
	local z = self.boss_shredder_1.treeList or {}
	local A = {}
	do
		local w = 0
		while w < #z do
			local B = z[w + 1]
			if IsValid(B) and B:IsAlive() then
				A[#A + 1] = B
			end
			w = w + 1
		end
	end
	self.boss_shredder_1.treeList = A
	return #A
end
function m.prototype.TrySummonTrees(self, s, C)
	local D = self.currentStage >= 2 and 3 or 2
	if C >= D or s < self.nextTreeSummonTime then
		return false
	end
	if self:TryCastNoTarget(self.boss_shredder_1, 1.8) then
		self.nextTreeSummonTime = s + 12
		return true
	end
	return false
end
function m.prototype.TryPrepareTreant7(self, s, C)
	if not self:CanCastAbility(self.boss_treant_7) then
		return false
	end
	local E = 3
	if C >= E then
		return self:TryCastNoTarget(self.boss_treant_7)
	end
	if self:TryCastNoTarget(self.boss_shredder_1, 1.8) then
		self.nextTreeSummonTime = s + 12
		return true
	end
	return false
end
function m.prototype.FindFriendlyByUnitName(self, F, G)
	local l = self:GetParent()
	local H = FindUnitsInRadius(
		l:GetTeamNumber(),
		l:GetAbsOrigin(),
		nil,
		G,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
		FIND_CLOSEST,
		false
	)
	do
		local w = 0
		while w < #H do
			local I = H[w + 1]
			if IsValid(I) and I:IsAlive() and I:GetUnitName() == F and not I:HasModifier("modifier_boss_treant_5") then
				return I
			end
			w = w + 1
		end
	end
	return nil
end
function m.prototype.FindNearestGrabTarget(self)
	local J = self.boss_treant_5:GetCastRange(vec3_zero, nil) + 80
	local K = self:FindFriendlyByUnitName("shredder_treant", J)
	if K ~= nil then
		return K
	end
	local L = self:FindFriendlyByUnitName("shredder_tree", 2000)
	if L ~= nil then
		return L
	end
	return nil
end
function m.prototype.IsValidGrabTarget(self, I)
	return I ~= nil and IsValid(I) and I:IsAlive() and not I:HasModifier("modifier_boss_treant_5")
end
function m.prototype.MoveToGrabTarget(self, u)
	local l = self:GetParent()
	local M = CalcDirection(l, u)
	local J = math.max(150, self.boss_treant_5:GetCastRange(vec3_zero, nil))
	local N = u:GetAbsOrigin() - M * J * 0.55
	l:ExecuteOrder(DOTA_UNIT_ORDER_MOVE_TO_POSITION, N)
end
function m.prototype.RefreshGrabMoveSpeed(self)
	local l = self:GetParent()
	l:AddNewModifier(l, self.boss_treant_5, "modifier_boss_treant_5_movespeed", { duration = 3 })
end
function m.prototype.TryHandleGrabAndThrow(self, s)
	local y = self:GetCatchUnit()
	if y ~= nil then
		local O = self:GetTargetPosition()
		if O ~= nil and self:TryCastOnPosition(self.boss_treant_6, O) then
			self.grabTarget = nil
			return true
		end
		return true
	end
	if not self:CanCastAbility(self.boss_treant_5) then
		self.grabTarget = nil
		return false
	end
	if s >= self.nextGrabSearchTime or not self:IsValidGrabTarget(self.grabTarget) then
		self.grabTarget = self:FindNearestGrabTarget()
		self.nextGrabSearchTime = s + 0.5
	end
	if not self:IsValidGrabTarget(self.grabTarget) then
		return false
	end
	self:RefreshGrabMoveSpeed()
	local l = self:GetParent()
	local P = self.grabTarget
	local J = self.boss_treant_5:GetCastRange(vec3_zero, nil) + l:GetHullRadius() + P:GetHullRadius()
	if CalcDistance(l, P) <= J + 30 then
		return self:TryCastOnTarget(self.boss_treant_5, P, 0.75)
	end
	if s >= self.nextMoveTime and not l:IsCasting() then
		self.nextMoveTime = s + 0.35
		self:MoveToGrabTarget(P)
	end
	return true
end
function m.prototype.MoveToEnemy(self)
	if not self:HasValidTarget() then
		return
	end
	local l = self:GetParent()
	local u = self.target
	local Q = math.max(350, l:Script_GetAttackRange())
	if self:GetDistanceToTarget() > Q then
		local M = CalcDirection(l, u)
		local N = u:GetAbsOrigin() - M * Q * 0.55
		l:MoveToPosition(N)
	end
end
function m.prototype.FaceMove(self)
	if not self:HasValidTarget() then
		return
	end
	local l = self:GetParent()
	local G = math.max(260, l:Script_GetAttackRange())
	l:AddNewModifier(
		l,
		nil,
		"modifier_face_move",
		{ target = self.target:entindex(), moveType = "strafe", radius = G, duration = 0.45 }
	)
end
function m.prototype.ExecuteGapMovement(self, s)
	if s < self.nextMoveTime or not self:HasValidTarget() or self:GetParent():IsCasting() then
		return
	end
	self.nextMoveTime = s + 0.3
	local R = self:GetDistanceToTarget()
	local Q = math.max(350, self:GetParent():Script_GetAttackRange())
	if R <= Q * 1.1 then
		self:FaceMove()
	else
		self:MoveToEnemy()
	end
end
function m.prototype.Patrol(self)
	local l = self:GetParent()
	if self.target == nil and not l:IsRooted() and not l:IsMoving() and not l:IsCasting() then
		local t = self.center + RandomVector(RandomInt(0, l:GetAcquisitionRange()))
		l:ExecuteOrder(DOTA_UNIT_ORDER_MOVE_TO_POSITION, t)
	end
end
function m.prototype.UpdateAggroTarget(self)
	local l = self:GetParent()
	local u = Player:FindNearestAliveEnemyHero(l:GetTeamNumber(), l:GetAbsOrigin(), l:GetAcquisitionRange())
	if u == nil then
		self.target = nil
		return
	end
	if self.target == nil then
		self.target = u
		self.changeAggroEnabled = false
		self:StartThink(10, "EnableAggroChange", function()
			self.changeAggroEnabled = true
			return -1
		end)
		return
	end
	if self.changeAggroEnabled then
		self.target = u
		self.changeAggroEnabled = false
		self:StartThink(10, "EnableAggroChange", function()
			self.changeAggroEnabled = true
			return -1
		end)
	end
end
function m.prototype.EventListener(self)
	return {
		entity_killed = function(S, T)
			if self.target ~= nil and T.victim == self.target then
				self.target = nil
				self:UpdateAggroTarget()
			end
			if self.grabTarget ~= nil and T.victim == self.grabTarget then
				self.grabTarget = nil
			end
		end,
	}
end
function m.prototype.ThinkAI(self)
	local s = GameRules:GetGameTime()
	if not self:CanExecuteAction() then
		return
	end
	if self:TryCastTriggeredArmor() then
		return
	end
	if s < self.nextActionTime then
		self:ExecuteGapMovement(s)
		return
	end
	local C = self:GetTreeCount()
	if self:GetParent():GetHealthPercent() <= 60 and self:TryCastNoTarget(self.boss_treant_3) then
		return
	end
	if self:TryPrepareTreant7(s, C) then
		return
	end
	if self:TryHandleGrabAndThrow(s) then
		return
	end
	if self:TrySummonTrees(s, C) then
		return
	end
	local O = self:GetTargetPosition()
	if O == nil then
		return
	end
	local R = self:GetDistanceToTarget()
	local Q = math.max(350, self:GetParent():Script_GetAttackRange())
	if R <= Q * 1.25 and self:TryCastOnPosition(self.boss_treant_2, O) then
		return
	end
	if R <= self.boss_treant_1:GetCastRange(vec3_zero, nil) and self:TryCastOnPosition(self.boss_treant_1, O) then
		return
	end
	if self:TryCastOnPosition(self.boss_treant_1, O) then
		return
	end
	self:ExecuteGapMovement(s)
end
m = e(
	{
		i(
			a,
			{
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
return f