--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_knockback_custom"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifierMotionBoth
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_knockback_custom"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.throwDistance = 250
	self.hasLanded = false
	self.landingToleranceZ = 16
	self.isDescending = false
	self.heightFactor = 1
	self.checkHole = true
end
function j.prototype.GetModifierMoveType(self)
	return DOTA_MOTION_CONTROLLER_PRIORITY_HIGHEST
end
function j.prototype.OnCreated(self, k)
	if not IsServer() then
		return
	end
	local l = self:GetParent()
	self.dashDirection = StringToVector(k.direction):Normalized()
	self.dashDuration = Round(k.dash_duration, 2)
	self.dashDistance = Round(k.dash_distance, 0)
	self.dashHeight = Round(k.dash_height, 0)
	if self.dashHeight > 0 then
		self:SetDuration(self.dashDuration * 3, true)
	else
		self:SetDuration(self.dashDuration, true)
	end
	self.startPosition = l:GetAbsOrigin()
	self.startZ = self.startPosition.z
	self.throwEndPosition = self.startPosition + self.dashDirection * self.dashDistance
	self.throwCompensationEndPosition = self.startPosition
		+ self.dashDirection * (self.dashDistance + self.throwDistance)
	self.horizontalSpeed = self.dashDistance / self.dashDuration
	self.elapsedTime = 0
	self.hasLanded = false
	self.isDescending = false
	self.heightFactor = math.sqrt(self.dashHeight)
	if not self:ApplyVerticalMotionController() or not self:ApplyHorizontalMotionController() then
		self:Destroy()
		return
	end
end
function j.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local l = self:GetParent()
	local m = l:GetAbsOrigin()
	l:RemoveHorizontalMotionController(self)
	l:RemoveVerticalMotionController(self)
	if self.hasLanded then
		local n = l:GetAbsOrigin()
		local o = GetGroundHeight(n, l)
		l:SetAbsOrigin(Vector(n.x, n.y, o))
	end
	if self.callback then
		self.callback(m)
	end
end
function j.prototype.GetJumpHeight(self, p)
	local q = p / self.dashDuration * self.heightFactor * 2 - self.heightFactor
	return -q ^ 2 + self.dashHeight
end
function j.prototype.FindFirstValidPosition(self, r, s, t, u)
	if t <= 0 then
		return nil
	end
	local v = math.floor(t / u)
	do
		local w = 0
		while w <= v do
			local x = r + s * u * w
			if GridNav:IsValidPosition(x) then
				return x
			end
			w = w + 1
		end
	end
	return nil
end
function j.prototype.OnHorizontalMotionInterrupted(self)
	self.hasLanded = true
	self:Destroy()
end
function j.prototype.OnVerticalMotionInterrupted(self)
	self.hasLanded = true
	self:Destroy()
end
function j.prototype.UpdateHorizontalMotion(self, l, y)
	if self.hasLanded then
		self:Destroy()
		return
	end
	self.elapsedTime = self.elapsedTime + y
	local m = l:GetAbsOrigin() + self.dashDirection * self.horizontalSpeed * y
	if not GridNav:IsValidPosition(m) then
		if GridNav:IsHole(m) then
			if self.checkHole then
				self.checkHole = false
				local u = 32
				local z = (self.throwCompensationEndPosition - self.throwEndPosition):Length2D()
				local A = self:FindFirstValidPosition(self.throwEndPosition, self.dashDirection, z, u)
				if A then
				end
				if A == nil then
					self.hasLanded = true
					return
				else
					if not GridNav:IsValidPosition(self.throwEndPosition) then
						local B = (A - m):Length2D()
						local C = self:FindFirstValidPosition(A, -self.dashDirection, B, u)
						if C == nil then
							self.hasLanded = true
							return
						end
						local D = (C - m):Length2D()
						local E = D / self.horizontalSpeed
						if E <= 0 then
							self.hasLanded = true
							return
						end
						self:SetDuration(E, true)
					end
				end
			end
		else
			self.hasLanded = true
			return
		end
	end
	l:SetAbsOrigin(m)
end
function j.prototype.UpdateVerticalMotion(self, l, y)
	if self.hasLanded then
		return
	end
	local F = l:GetAbsOrigin()
	local o = GetGroundHeight(F, l)
	local G = self:GetJumpHeight(self.elapsedTime)
	local H = self.startZ + G
	if self.elapsedTime > self.dashDuration / 2 then
		self.isDescending = true
	end
	if self.dashHeight > 0 and self.isDescending then
		if H <= o + self.landingToleranceZ then
			l:SetAbsOrigin(Vector(F.x, F.y, o))
			self.hasLanded = true
			self:Destroy()
			return
		end
	end
	local I = math.max(H, o)
	l:SetAbsOrigin(Vector(F.x, F.y, I))
end
function j.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true }
end
function j.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function j.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_FLAIL
end
function j.prototype.FindValidPositionWithRaycast(self, r, J, l)
	local s = J - r
	s.z = 0
	local K = s:Length2D()
	if K <= 0 then
		return r
	end
	local L = r
	local u = 16
	do
		local M = 0
		while M < K do
			local N = r + s:Normalized() * math.min(M + u, K)
			if
				GridNav:IsBlocked(N)
				or not GridNav:IsTraversable(N)
				or GridNav:IsNearbyTree(N, l:GetHullRadius(), true)
				or not GridNav:CanFindPath(L, N)
			then
				local O = self:TrySlidePosition(L, N, l)
				if O then
					L = O
				end
				break
			end
			L = N
			M = M + u
		end
	end
	return L
end
function j.prototype.TrySlidePosition(self, P, Q, l)
	local s = (Q - P):Normalized()
	local R = l:GetHullRadius()
	local S = { 30, -30, 45, -45, 60, -60 }
	for T, U in ipairs(S) do
		local V = RotatePosition(Vector(0, 0, 0), QAngle(0, U, 0), s)
		local O = P + V * R * 2
		if not GridNav:IsBlocked(O) and GridNav:IsTraversable(O) and not GridNav:IsNearbyTree(O, R, true) then
			return O
		end
	end
	return nil
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
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	j
)
return f