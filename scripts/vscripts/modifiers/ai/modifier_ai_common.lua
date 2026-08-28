--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/ai/modifier_ai_common"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = 0
local k = 1
local l = 2
local m = 3
local n = 800
local o = 200
local p = 1.5
local q = 0.5
local r = 2
local s = 0.5
local t = 0.25
local u = 0.5
local v = 128
local w = 0.5
local x = 128
local y = c()
y.name = "modifier_ai_common"
d(y, h)
function y.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.center = vec3_zero
	self.state = j
	self.stateTimer = 0
	self.abilities = {}
	self.nextEnemySearchTime = 0
	self.lastThinkTime = 0
	self.nextChaseOrderTime = 0
end
function y.prototype.OnCreated(self, z)
	if IsServer() then
		local A = self:GetParent()
		local B = GameRules:GetGameTime()
		self.stateTimer = RandomFloat(q, r)
		self.lastThinkTime = B
		self.nextEnemySearchTime = B + RandomFloat(0, u)
		self.nextChaseOrderTime = B + RandomFloat(0, w)
		self:CacheAbilities(A)
		self:StartIntervalThink(t + RandomFloat(0, 0.05))
	end
end
function y.prototype.CacheAbilities(self, A)
	local C = {}
	local D = A:GetAbilityCount()
	do
		local E = 0
		while E < D do
			do
				local F = A:GetAbilityByIndex(E)
				if not IsValid(F) then
					goto G
				end
				if F:IsPassive() then
					goto G
				end
				C[#C + 1] = F
			end
			::G::
			E = E + 1
		end
	end
	self.abilities = C
end
function y.prototype.OnIntervalThink(self)
	local A = self:GetParent()
	if not IsValid(A) or not A:IsAlive() then
		return
	end
	local B = GameRules:GetGameTime()
	if A:HasState(StateEnum.AI_DISABLED) then
		self.lastThinkTime = B
		return
	end
	if A:IsCasting() then
		self.lastThinkTime = B
		return
	end
	local H = math.max(0, B - self.lastThinkTime)
	self.lastThinkTime = B
	local I = self:GetCachedOrFindEnemy(A, B)
	if IsValid(I) then
		self.currentTarget = I
		self.state = m
		self:DoCombat(A, I, B)
	else
		self:DoNonCombat(A, H)
	end
end
function y.prototype.GetCachedOrFindEnemy(self, A, B)
	if A:HasState(StateEnum.BLIND) then
		self.currentTarget = nil
		return nil
	end
	local J = self.currentTarget
	if IsValid(J) and J:IsAlive() then
		local K = n + v
		if CalcDistance(A, J) <= K then
			return J
		end
	end
	self.currentTarget = nil
	if B < self.nextEnemySearchTime then
		return nil
	end
	self.nextEnemySearchTime = B + u
	local L = Player:FindNearestAliveEnemyHero(A:GetTeamNumber(), A:GetAbsOrigin(), n)
	if L ~= nil then
		self.currentTarget = L
		return self.currentTarget
	end
	return nil
end
function y.prototype.DoCombat(self, A, J, B)
	if self:TryCastAbilities(A, J) then
		return
	end
	self:MoveToTarget(A, J, B)
end
function y.prototype.TryCastAbilities(self, A, J)
	do
		local E = 0
		while E < #self.abilities do
			do
				local F = self.abilities[E + 1]
				if not IsValid(F) or not F:IsFullyCastable() then
					goto M
				end
				local N = CalcDistance(A, J)
				local O = F:GetCastRange(vec3_zero, nil)
				local P = self:GetAbilityBehavior(F)
				if P == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
					if O > 0 and N > O + 80 then
						goto M
					end
					A:ExecuteOrder(DOTA_UNIT_ORDER_CAST_NO_TARGET, F)
					return true
				end
				if P == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
					if N > O + 80 then
						goto M
					end
					A:ExecuteOrder(DOTA_UNIT_ORDER_CAST_TARGET, F, J)
					return true
				end
				if P == DOTA_ABILITY_BEHAVIOR_POINT then
					if O > 0 and N > O + 120 then
						goto M
					end
					A:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, F, J:GetAbsOrigin())
					return true
				end
			end
			::M::
			E = E + 1
		end
	end
	return false
end
function y.prototype.MoveToTarget(self, A, J, B)
	if B < self.nextChaseOrderTime then
		return
	end
	local Q = J:GetAbsOrigin()
	local R = self.lastChaseTargetPosition
	local S = R == nil or CalcDistance(R, Q) >= x
	if not S and A:IsMoving() then
		return
	end
	A:ExecuteOrder(DOTA_UNIT_ORDER_MOVE_TO_POSITION, Q)
	self.lastChaseTargetPosition = Vector(Q.x, Q.y, Q.z)
	self.nextChaseOrderTime = B + w
end
function y.prototype.DoNonCombat(self, A, H)
	if self.state == m then
		self.state = l
		self.stateTimer = p
		self.currentTarget = nil
		self.lastChaseTargetPosition = nil
		self.nextChaseOrderTime = 0
	end
	if self.state == l then
		self.stateTimer = self.stateTimer - H
		if self.stateTimer <= 0 then
			self.state = k
			self.stateTimer = RandomFloat(q, r)
		end
		return
	end
	if self.state == k or self.state == j then
		self.stateTimer = self.stateTimer - H
		if self.stateTimer <= 0 then
			if self:Patrol(A) then
				self.state = k
				self.stateTimer = s
			end
		end
	end
end
function y.prototype.Patrol(self, A)
	if A:IsRooted() or A:IsMoving() then
		return false
	end
	if self.center == vec3_zero then
		self.center = A:GetAbsOrigin()
	end
	local T = A:GetAcquisitionRange()
	local U = self.center:__add(RandomVector(RandomInt(0, T)))
	A:ExecuteOrder(DOTA_UNIT_ORDER_MOVE_TO_POSITION, U)
	return true
end
function y.prototype.GetAbilityBehavior(self, F)
	local P = tonumber(tostring(F:GetBehavior()))
	if bit.band(P, DOTA_ABILITY_BEHAVIOR_NO_TARGET) ~= 0 then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET
	end
	if bit.band(P, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 then
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	end
	if bit.band(P, DOTA_ABILITY_BEHAVIOR_POINT) ~= 0 then
		return DOTA_ABILITY_BEHAVIOR_POINT
	end
	return nil
end
function y.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE }
end
function y.prototype.GetModifierMoveSpeed_Absolute(self)
	if self.state == k or self.state == l or self.state == j then
		return o
	end
	return 0
end
function y.prototype.StaticProperty(self)
	return { [PropertyFunction.COOLDOWN_REDUCTION] = RandomInt(-20, 20) }
end
y = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = true,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	y
)
return f