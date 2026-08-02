--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_wisps"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayIndexOf
local f = b.__TS__ArraySplice
local g = b.__TS__ArrayForEach
local h = b.__TS__DecorateLegacy
local i = {}
local j = require("modifiers.eom_modifier.eom_modifier")
local k = j.EOMModifier
local l = j.EOMModifierMotionHorizontal
local m = j.registerEOMModifier
local n = 200
local o = 420
local p = 120
local q = 170
local r = 120
local s = 140
local t = 70
local u = c()
u.name = "modifier_wisps"
d(u, k)
function u.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.wispList = {}
end
function u.prototype.CreateWisp(self, v, w)
	local x = self.parent:GetAbsOrigin()
	local y = self.parent:GetPlayerOwnerID()
	local z = RotatePosition(vec3_zero, QAngle(0, 30, 0), self.parent:GetForwardVector() * -n) + x
	local A = CreateUnitByName(v, z, true, self.parent, self.parent, self.parent:GetTeamNumber())
	if A ~= nil then
		A:SetForwardVector(self.parent:GetForwardVector())
		A:SetControllableByPlayer(y, false)
		A:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_wisp",
			{
				attack = w.attack,
				attack_speed = w.attack_speed or 0,
				attack_range = w.attack_range or 0,
				attack_ability_name = w.attack_ability_name,
			}
		)
		local B = self.wispList
		B[#B + 1] = A
		self:UpdateWispPositions()
	end
	return A
end
function u.prototype.RemoveWisp(self, C)
	local D = e(self.wispList, C)
	if D ~= -1 then
		f(self.wispList, D, 1)
		if IsValid(C) then
			C:RemoveModifierByName("modifier_wisp")
		end
		self:UpdateWispPositions()
	end
end
function u.prototype.UpdateWispPositions(self)
	local E = {}
	do
		local F = 0
		while F < #self.wispList do
			local C = self.wispList[F + 1]
			if IsValid(C) then
				E[#E + 1] = C
			end
			F = F + 1
		end
	end
	self.wispList = E
	local G = #self.wispList
	if G == 0 then
		return
	end
	local H = math.min(q, p + math.max(0, G - 3) * 10)
	local I = -H / 2
	local J = G > 1 and H / (G - 1) or 0
	local K = J * math.pi / 180
	local L = K > 0 and r / K or n
	local M = math.min(o, math.max(n, L))
	do
		local F = 0
		while F < G do
			local C = self.wispList[F + 1]
			if IsValid(C) then
				local N = C:FindModifierByName("modifier_wisp")
				if N ~= nil then
					local O = G == 1 and 0 or I + J * F
					N:SetFormation(O, M)
				end
			end
			F = F + 1
		end
	end
end
function u.prototype.OnDestroy(self)
	if IsServer() then
		g(self.wispList, function(P, C)
			if IsValid(C) then
				C:RemoveModifierByName("modifier_wisp")
			end
		end)
	end
end
u = h(
	{
		m(
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
	u
)
local Q = c()
Q.name = "modifier_wisp"
d(Q, l)
function Q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.angleOffset = 0
	self.followDistance = n
	self.allowFaceTowardsAt = 0
end
function Q.prototype.GetAbilitySpecialValue(self) end
function Q.prototype.SetFormation(self, R, M)
	self.angleOffset = R
	self.followDistance = M
	if IsValid(self.caster) then
		self.position = self:GetDesiredPosition()
	end
end
function Q.prototype.GetDesiredPosition(self)
	return RotatePosition(
		vec3_zero,
		QAngle(0, self.angleOffset, 0),
		self.caster:GetForwardVector() * -self.followDistance
	) + self.caster:GetAbsOrigin()
end
function Q.prototype.GetAvoidanceOffset(self, S)
	local T = self:GetCaster()
	local U = Vector(0, 0, 0)
	if not IsValid(T) then
		return U
	end
	local V = T:FindModifierByName("modifier_wisps")
	if V == nil then
		return U
	end
	local R = U
	do
		local F = 0
		while F < #V.wispList do
			do
				local W = V.wispList[F + 1]
				if not IsValid(W) or W == self.parent then
					goto X
				end
				local Y = W:GetAbsOrigin()
				local Z = CalcDistance(S, Y)
				if Z > 0 and Z < s then
					local _ = RemapValClamped(Z, 0, s, t, 0)
					R = R + CalcDirection(S, Y) * _
				end
			end
			::X::
			F = F + 1
		end
	end
	return R
end
function Q.prototype.OnCreated(self, w)
	if IsServer() then
		self.attack = w.attack
		self.attackSpeed = w.attack_speed
		self.attackRange = w.attack_range
		self.attackAbility = self.parent:FindAbilityByName(w.attack_ability_name or "custom_summon_attack")
		if IsValid(self.attackAbility) then
			self:StartIntervalThink(0.1)
		end
		self:ApplyHorizontalMotionController()
		self.position = self:GetDesiredPosition()
	else
	end
end
function Q.prototype.OnDestroy(self)
	if IsServer() then
		local a0 = self:GetParent()
		a0:RemoveHorizontalMotionController(self)
		if IsValid(a0) then
			a0:Kill(self.ability, a0)
		end
	end
end
function Q.prototype.StaticProperty(self)
	return {
		[PropertyFunction.ATTACK] = self.attack,
		[PropertyFunction.ATTACKSPEED] = self.attackSpeed,
		[PropertyFunction.ATTACK_RANGE] = self.attackRange,
	}
end
function Q.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.ATTACKSPEED] = function()
			return GetWispAttackspeed(self:GetCaster())
		end,
		[PropertyFunction.DAMAGE_AMPLIFY] = function()
			return GetWispDamage(self:GetCaster())
		end,
	}
end
function Q.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function Q.prototype.OnIntervalThink(self)
	local T = self:GetCaster()
	local a0 = self:GetParent()
	if IsValid(T) and not a0:IsCasting() then
		local a1 = FindEnemiesInRadius(T, a0:GetAbsOrigin(), a0:Script_GetAttackRange(), FIND_CLOSEST)
		if IsValid(a1[1]) and IsValid(self.attackAbility) and self.attackAbility:IsFullyCastable() then
			self.allowFaceTowardsAt = GameRules:GetGameTime() + 2
			a0:ExecuteOrder(DOTA_UNIT_ORDER_CAST_TARGET, self.attackAbility, a1[1])
		end
	end
end
function Q.prototype.UpdateHorizontalMotion(self, a2, a3)
	if not IsValid(self.caster) then
		return
	end
	self.position = self:GetDesiredPosition()
	local z = a2:GetAbsOrigin()
	local a4 = self.position + self:GetAvoidanceOffset(z)
	local a5 = CalcDistance(a4, z)
	local a6 = CalcDistance(self.caster, self.parent)
	local a7 = RemapValClamped(a5, 0, self.followDistance + 220, 180, 600)
	local a8 = CalcDirection(a4, z)
	if a6 > self.followDistance * 8 then
		a2:SetAbsOrigin(a4)
	else
		if a5 > a7 * a3 then
			a2:SetAbsOrigin(z + a8 * a7 * a3)
			if a2:GetCurrentActiveAbility() == nil and GameRules:GetGameTime() >= self.allowFaceTowardsAt then
				a2:FaceTowards(a4)
			end
		else
			a2:SetAbsOrigin(a4)
		end
	end
end
function Q.prototype.OnHorizontalMotionInterrupted(self)
	self:Destroy()
end
function Q.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end
Q = h(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
				GetAttributes = MODIFIER_ATTRIBUTE_PERMANENT,
			}
		),
	},
	Q
)
return i