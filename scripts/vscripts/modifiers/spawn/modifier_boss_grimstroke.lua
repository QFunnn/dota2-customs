--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/spawn/modifier_boss_grimstroke"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_spawn_boss_grimstroke"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsServer() then
		local l = self:GetParent()
		self:StartThink(0, function()
			l:SetForwardVector(vec3_bottom)
			return -1
		end)
		self:StartThink(1, function()
			EmitGlobalSound("Grimstroke.Spawn")
			l:StartGesture(ACT_DOTA_LOADOUT_RARE)
			return -1
		end)
		self:SetDuration(4, true)
	end
end
function j.prototype.OnDestroy(self)
	if IsServer() then
		local l = self:GetParent()
		l:RemoveGesture(ACT_DOTA_LOADOUT_RARE)
		l:AddNewModifier(l, nil, "modifier_boss_grimstroke", {})
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
m.name = "modifier_boss_grimstroke"
d(m, h)
function m.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.changeAggroEnabled = false
	self.currentStage = 0
	self.nextActionTime = 0
	self.nextMoveTime = 0
	self.nextRapidFireComboTime = 0
	self.pendingRapidFire = false
	self.pendingRapidFireExpireTime = 0
end
function m.prototype.OnCreated(self, k)
	if not IsServer() then
		return
	end
	local l = self:GetParent()
	self.center = l:GetAbsOrigin()
	self.boss_grimstroke_1 = l:FindAbilityByName("boss_grimstroke_1")
	self.boss_grimstroke_2 = l:FindAbilityByName("boss_grimstroke_2")
	self.boss_grimstroke_3 = l:FindAbilityByName("boss_grimstroke_3")
	self.boss_grimstroke_4 = l:FindAbilityByName("boss_grimstroke_4")
	self.boss_grimstroke_5 = l:FindAbilityByName("boss_grimstroke_5")
	self.boss_grimstroke_6 = l:FindAbilityByName("boss_grimstroke_6")
	self:OnStageChanged(self:GetDesiredStage())
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
	self:StartThink(0, "StageThink", function()
		if l:HasState(StateEnum.AI_DISABLED) then
			return 0.1
		end
		self:UpdateStage()
		if self.currentStage == 2 then
			self:Stage2()
		else
			self:Stage1()
		end
		return 0.1
	end)
end
function m.prototype.GetDesiredStage(self)
	if self:GetParent():GetHealthPercent() <= 60 then
		return 2
	end
	return 1
end
function m.prototype.UpdateStage(self)
	local n = self:GetDesiredStage()
	if n ~= self.currentStage then
		self:OnStageChanged(n)
	end
end
function m.prototype.OnStageChanged(self, o)
	self.currentStage = o
	local p = GameRules:GetGameTime()
	self.nextActionTime = p + 0.35
	self.nextMoveTime = p + 0.2
	if o == 2 then
		if IsValid(self.boss_grimstroke_5) and self.boss_grimstroke_5:GetLevel() < 2 then
			self.boss_grimstroke_5:SetLevel(2)
		end
		if IsValid(self.boss_grimstroke_6) and self.boss_grimstroke_6:GetLevel() < 2 then
			self.boss_grimstroke_6:SetLevel(2)
		end
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
function m.prototype.CanCastAbility(self, q)
	if not IsValid(q) or not q:IsAbilityReady() then
		return false
	end
	local r = q.funcCondition
	if r ~= nil and r(nil, q) ~= true then
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
	return self.target:GetAbsOrigin()
end
function m.prototype.IsReachablePosition(self, s)
	local l = self:GetParent()
	local t = GetGroundPosition(s, l)
	if GridNav:IsBlocked(t) or not GridNav:IsTraversable(t) then
		return false
	end
	return GridNav:CanFindPath(l:GetAbsOrigin(), t)
end
function m.prototype.GetRetreatPosition(self)
	local l = self:GetParent()
	local u = l:GetAbsOrigin()
	local v = self:GetTargetPosition()
	local w = CalcDirection2D(u, v)
	local x = CalcDistance(u, self.center) > 10 and CalcDirection2D(self.center, u) or w
	local y = math.max(500, self.boss_grimstroke_3:GetCastRange(vec3_zero, nil))
	local z = math.min(y, 800)
	local A = { 420, 560, 700, z }
	local B = { 0, 30, -30, 55, -55 }
	local C = u
	local D = -999999
	do
		local E = 0
		while E < #B do
			local F = (w * 0.75 + x * 0.55):Normalized()
			local G = Rotation2D(F, B[E + 1], true)
			do
				local H = 0
				while H < #A do
					do
						local I = A[H + 1]
						local J = GetGroundPosition(u + G * I, l)
						if not self:IsReachablePosition(J) then
							goto K
						end
						local L = CalcDistance(J, v)
						local M = CalcDistance(J, self.center)
						local N = -math.abs(L - 750) - M * 0.35
						if N > D then
							D = N
							C = J
						end
					end
					::K::
					H = H + 1
				end
			end
			E = E + 1
		end
	end
	if D <= -999999 then
		local O = GetGroundPosition(u + x * 300, l)
		if self:IsReachablePosition(O) then
			return O
		end
	end
	return C
end
function m.prototype.GetGapDuration(self, q)
	if q == self.boss_grimstroke_1 then
		return 2.7
	end
	if q == self.boss_grimstroke_2 then
		return 1.8
	end
	if q == self.boss_grimstroke_3 then
		return 1
	end
	if q == self.boss_grimstroke_4 then
		return 1.7
	end
	if q == self.boss_grimstroke_5 then
		return q:GetChannelTime() + 0.8
	end
	if q == self.boss_grimstroke_6 then
		return 1.6
	end
	return q:GetCastPoint() + 1
end
function m.prototype.GetBossGapMultiplier(self)
	return 1 + math.max(0, GetBossGapAmplify(self:GetParent())) / 100
end
function m.prototype.TryCastNoTargetAbility(self, q)
	if not self:CanExecuteAction() or not self:CanCastAbility(q) then
		return false
	end
	local l = self:GetParent()
	l:RemoveModifierByName("modifier_face_move")
	l:ExecuteOrder(DOTA_UNIT_ORDER_CAST_NO_TARGET, q)
	local p = GameRules:GetGameTime()
	self.nextActionTime = p + self:GetGapDuration(q) * self:GetBossGapMultiplier()
	self.nextMoveTime = p + 0.2
	return true
end
function m.prototype.TryCastPositionAbility(self, q, s)
	if not self:CanExecuteAction() or not self:CanCastAbility(q) then
		return false
	end
	local l = self:GetParent()
	l:RemoveModifierByName("modifier_face_move")
	l:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, q, s)
	local p = GameRules:GetGameTime()
	self.nextActionTime = p + self:GetGapDuration(q) * self:GetBossGapMultiplier()
	self.nextMoveTime = p + 0.2
	return true
end
function m.prototype.TryCastTrackingAbility(self, q)
	return self:TryCastPositionAbility(q, self:GetTargetPosition())
end
function m.prototype.CanStartRapidFireCombo(self, p)
	if self.pendingRapidFire then
		return false
	end
	if not self:HasValidTarget() then
		return false
	end
	if not IsValid(self.boss_grimstroke_2) or not IsValid(self.boss_grimstroke_3) then
		return false
	end
	if not self:CanCastAbility(self.boss_grimstroke_3) or p < self.nextRapidFireComboTime then
		return false
	end
	return self:GetDistanceToTarget() <= 900
end
function m.prototype.TryStartRapidFireCombo(self, p)
	if not self:CanStartRapidFireCombo(p) then
		return false
	end
	self.boss_grimstroke_2:EndCooldown()
	if not self:TryCastPositionAbility(self.boss_grimstroke_3, self:GetRetreatPosition()) then
		return false
	end
	self.pendingRapidFire = true
	self.pendingRapidFireExpireTime = p + 2.2
	self.nextRapidFireComboTime = p
		+ math.max(8, self.boss_grimstroke_2:GetCooldown(self.boss_grimstroke_2:GetLevel()) + 2)
			* self:GetBossGapMultiplier()
	return true
end
function m.prototype.TryExecutePendingRapidFire(self)
	if not self.pendingRapidFire then
		return false
	end
	local p = GameRules:GetGameTime()
	if p >= self.pendingRapidFireExpireTime then
		self.pendingRapidFire = false
		return false
	end
	if not self:CanExecuteAction() then
		return true
	end
	if self:TryCastTrackingAbility(self.boss_grimstroke_2) then
		self.pendingRapidFire = false
		self.pendingRapidFireExpireTime = 0
		return true
	end
	return false
end
function m.prototype.MoveToTargetRange(self)
	if not self:HasValidTarget() then
		return
	end
	local l = self:GetParent()
	local P = self.target
	local I = self:GetDistanceToTarget()
	local Q = 700
	if I > Q then
		local R = CalcDirection(l, P)
		local S = P:GetAbsOrigin() - R * 500
		l:MoveToPosition(S)
	end
end
function m.prototype.FaceMove(self)
	if not self:HasValidTarget() then
		return
	end
	local l = self:GetParent()
	l:AddNewModifier(
		l,
		nil,
		"modifier_face_move",
		{ target = self.target:entindex(), moveType = "strafe", radius = 450, duration = 0.45 }
	)
end
function m.prototype.ExecuteGapMovement(self, p)
	if p < self.nextMoveTime or not self:HasValidTarget() or self:GetParent():IsCasting() then
		return
	end
	self.nextMoveTime = p + 0.3
	if self:GetDistanceToTarget() <= 800 then
		self:FaceMove()
		return
	end
	self:MoveToTargetRange()
end
function m.prototype.Patrol(self)
	local l = self:GetParent()
	if self.target == nil and not l:IsRooted() and not l:IsMoving() and not l:IsCasting() then
		local s = self.center + RandomVector(RandomInt(0, l:GetAcquisitionRange()))
		l:ExecuteOrder(DOTA_UNIT_ORDER_MOVE_TO_POSITION, s)
	end
end
function m.prototype.UpdateAggroTarget(self)
	local l = self:GetParent()
	local P = Player:FindNearestAliveEnemyHero(l:GetTeamNumber(), l:GetAbsOrigin(), l:GetAcquisitionRange())
	if P == nil then
		self.target = nil
		return
	end
	if self.target == nil then
		self.target = P
		self.changeAggroEnabled = false
		self:StartThink(10, "EnableAggroChange", function()
			self.changeAggroEnabled = true
			return -1
		end)
		return
	end
	if self.changeAggroEnabled then
		self.target = P
		self.changeAggroEnabled = false
		self:StartThink(10, "EnableAggroChange", function()
			self.changeAggroEnabled = true
			return -1
		end)
	end
end
function m.prototype.EventListener(self)
	return {
		entity_killed = function(T, U)
			if self.target ~= nil and U.victim == self.target then
				self.target = nil
				self:UpdateAggroTarget()
			end
		end,
	}
end
function m.prototype.Stage1(self)
	local p = GameRules:GetGameTime()
	if not self:CanExecuteAction() then
		return
	end
	if p < self.nextActionTime then
		self:ExecuteGapMovement(p)
		return
	end
	if self:TryExecutePendingRapidFire() then
		return
	end
	if self:TryCastNoTargetAbility(self.boss_grimstroke_4) then
		return
	end
	if self:TryStartRapidFireCombo(p) then
		return
	end
	if self:GetDistanceToTarget() <= 900 and self:TryCastTrackingAbility(self.boss_grimstroke_1) then
		return
	end
	if self:TryCastTrackingAbility(self.boss_grimstroke_6) then
		return
	end
	self:ExecuteGapMovement(p)
end
function m.prototype.Stage2(self)
	local p = GameRules:GetGameTime()
	if not self:CanExecuteAction() then
		return
	end
	if p < self.nextActionTime then
		self:ExecuteGapMovement(p)
		return
	end
	if self:TryExecutePendingRapidFire() then
		return
	end
	if self:TryCastNoTargetAbility(self.boss_grimstroke_5) then
		return
	end
	if self:TryCastNoTargetAbility(self.boss_grimstroke_4) then
		return
	end
	if self:TryCastTrackingAbility(self.boss_grimstroke_6) then
		return
	end
	if self:TryStartRapidFireCombo(p) then
		return
	end
	if self:TryCastTrackingAbility(self.boss_grimstroke_1) then
		return
	end
	self:ExecuteGapMovement(p)
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