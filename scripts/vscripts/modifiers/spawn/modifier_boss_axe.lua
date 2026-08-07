--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/spawn/modifier_boss_axe"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_spawn_boss_axe"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsServer() then
		local l = self:GetParent()
		self:StartThink(0, function()
			l:SetForwardVector(vec3_bottom)
			return -1
		end)
		self:StartThink(1, function()
			EmitGlobalSound("Axe.Spawn")
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
		l:AddNewModifier(l, nil, "modifier_boss_axe", {})
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
m.name = "modifier_boss_axe"
d(m, h)
function m.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.changeAggroEnabled = false
	self.nextActionTime = 0
	self.nextMoveTime = 0
	self.jumpSlashCount = 0
	self.jumpSlashCooldownEnd = 0
end
function m.prototype.OnCreated(self, k)
	if IsServer() then
		local l = self:GetParent()
		self.center = l:GetAbsOrigin()
		self.boss_axe_1 = l:FindAbilityByName("boss_axe_1")
		self.boss_axe_2 = l:FindAbilityByName("boss_axe_2")
		self.boss_axe_3 = l:FindAbilityByName("boss_axe_3")
		self.boss_axe_4 = l:FindAbilityByName("boss_axe_4")
		self:StartThink(0.1, "UpdateAggroTarget", function()
			if l:HasState(StateEnum.AI_DISABLED) then
				return 1
			end
			self:UpdateAggroTarget()
			return self.target ~= nil and 1 or 0.1
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
			self:ThinkAI()
			return 0.15
		end)
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
function m.prototype.CanCastAbility(self, n)
	if not IsValid(n) or not n:IsAbilityReady() then
		return false
	end
	local o = n.funcCondition
	if o ~= nil and o(nil, n) ~= true then
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
function m.prototype.GetGapDuration(self, n)
	if n == self.boss_axe_1 then
		return n:GetCastPoint() + 1.2
	end
	if n == self.boss_axe_2 then
		return n:GetCastPoint() + 1.1
	end
	if n == self.boss_axe_3 then
		return 2
	end
	if n == self.boss_axe_4 then
		return 1.6
	end
	return n:GetCastPoint() + 1
end
function m.prototype.GetBossGapMultiplier(self)
	return 1 + math.max(0, GetBossGapAmplify(self:GetParent())) / 100
end
function m.prototype.TryCastOnPosition(self, n, p, q)
	if not self:CanExecuteAction() or not self:CanCastAbility(n) then
		return false
	end
	local l = self:GetParent()
	l:RemoveModifierByName("modifier_face_move")
	l:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, n, p)
	local r = GameRules:GetGameTime()
	self.nextActionTime = r + (q or self:GetGapDuration(n)) * self:GetBossGapMultiplier()
	self.nextMoveTime = r + 0.2
	return true
end
function m.prototype.TryCastOnTarget(self, n, s, q)
	if not self:CanExecuteAction() or not self:CanCastAbility(n) then
		return false
	end
	local l = self:GetParent()
	l:RemoveModifierByName("modifier_face_move")
	l:ExecuteOrder(DOTA_UNIT_ORDER_CAST_TARGET, n, s)
	local r = GameRules:GetGameTime()
	self.nextActionTime = r + (q or self:GetGapDuration(n)) * self:GetBossGapMultiplier()
	self.nextMoveTime = r + 0.2
	return true
end
function m.prototype.TryCastJumpSlash(self, r)
	if self:GetParent():GetHealthPercent() > 40 then
		return false
	end
	if self.jumpSlashCount <= 0 and r >= self.jumpSlashCooldownEnd then
		self.jumpSlashCount = 3
	end
	if self.jumpSlashCount <= 0 then
		return false
	end
	local t = self:GetTargetPosition()
	if t == nil then
		return false
	end
	local u = self.jumpSlashCount <= 1
	local v = u and self:GetGapDuration(self.boss_axe_4) or 0.75
	if not self:TryCastOnPosition(self.boss_axe_4, t, v) then
		return false
	end
	self.jumpSlashCount = self.jumpSlashCount - 1
	if self.jumpSlashCount <= 0 then
		self.jumpSlashCooldownEnd = r + 12
	end
	return true
end
function m.prototype.MoveToEnemy(self)
	if not self:HasValidTarget() then
		return
	end
	local l = self:GetParent()
	local s = self.target
	local w = math.max(350, l:Script_GetAttackRange())
	if self:GetDistanceToTarget() > w then
		local x = CalcDirection(l, s)
		local y = s:GetAbsOrigin() - x * w * 0.55
		l:MoveToPosition(y)
	end
end
function m.prototype.FaceMove(self)
	if not self:HasValidTarget() then
		return
	end
	local l = self:GetParent()
	local z = math.max(260, l:Script_GetAttackRange())
	l:AddNewModifier(
		l,
		nil,
		"modifier_face_move",
		{ target = self.target:entindex(), moveType = "strafe", radius = z, duration = 0.45 }
	)
end
function m.prototype.ExecuteGapMovement(self, r)
	if r < self.nextMoveTime or not self:HasValidTarget() or self:GetParent():IsCasting() then
		return
	end
	self.nextMoveTime = r + 0.3
	local A = self:GetDistanceToTarget()
	local w = math.max(350, self:GetParent():Script_GetAttackRange())
	if A <= w * 1.1 then
		self:FaceMove()
	else
		self:MoveToEnemy()
	end
end
function m.prototype.Patrol(self)
	local l = self:GetParent()
	if self.target == nil and not l:IsRooted() and not l:IsMoving() and not l:IsCasting() then
		local p = self.center + RandomVector(RandomInt(0, l:GetAcquisitionRange()))
		l:ExecuteOrder(DOTA_UNIT_ORDER_MOVE_TO_POSITION, p)
	end
end
function m.prototype.UpdateAggroTarget(self)
	local l = self:GetParent()
	local s = Player:FindNearestAliveEnemyHero(l:GetTeamNumber(), l:GetAbsOrigin(), l:GetAcquisitionRange())
	if s == nil then
		self.target = nil
		return
	end
	if self.target == nil then
		self.target = s
		self.changeAggroEnabled = false
		self:StartThink(10, "EnableAggroChange", function()
			self.changeAggroEnabled = true
			return -1
		end)
		return
	end
	if self.changeAggroEnabled then
		self.target = s
		self.changeAggroEnabled = false
		self:StartThink(10, "EnableAggroChange", function()
			self.changeAggroEnabled = true
			return -1
		end)
	end
end
function m.prototype.EventListener(self)
	return {
		entity_killed = function(B, C)
			if self.target ~= nil and C.victim == self.target then
				self.target = nil
				self:UpdateAggroTarget()
			end
		end,
	}
end
function m.prototype.ThinkAI(self)
	local r = GameRules:GetGameTime()
	if not self:CanExecuteAction() then
		return
	end
	if r < self.nextActionTime then
		self:ExecuteGapMovement(r)
		return
	end
	if self:TryCastJumpSlash(r) then
		return
	end
	local s = self.target
	local t = s:GetAbsOrigin()
	local A = self:GetDistanceToTarget()
	local w = math.max(350, self:GetParent():Script_GetAttackRange())
	if A > 700 and self:TryCastOnTarget(self.boss_axe_3, s) then
		return
	end
	if A > w * 1.25 and self:TryCastOnPosition(self.boss_axe_1, t) then
		return
	end
	if A <= 500 and self:TryCastOnPosition(self.boss_axe_2, t) then
		return
	end
	if self:TryCastOnPosition(self.boss_axe_1, t) then
		return
	end
	if self:TryCastOnTarget(self.boss_axe_3, s) then
		return
	end
	if self:TryCastOnPosition(self.boss_axe_2, t) then
		return
	end
	self:ExecuteGapMovement(r)
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