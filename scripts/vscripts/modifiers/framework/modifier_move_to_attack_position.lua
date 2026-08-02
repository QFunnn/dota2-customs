--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_move_to_attack_position"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifierMotionHorizontal
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_move_to_attack_position"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.currentAngle = 0
	self.lastReevaluateTime = 0
	self.reevaluateInterval = 1.5
	self.moveState = "approach"
	self.strafeAngle = 90
end
function j.prototype.OnCreated(self, k)
	if IsServer() then
		self.target = EntIndexToHScript(k.target)
		local l = self:GetParent()
		local m = l:Script_GetAttackRange()
		self.minOptimalDistance = k.minDistance or m * 0.8
		self.maxOptimalDistance = k.maxDistance or m
		self.currentAngle = VectorToAngles(l:GetForwardVector()).y
		self.strafeAngle = RollPercentage(50) and 90 or -90
		l:StartGestureWithPlaybackRate(ACT_DOTA_RUN, 0.4)
		self:StartIntervalThink(self.reevaluateInterval)
		if not self:ApplyHorizontalMotionController() then
			self:Destroy()
			return
		end
	end
end
function j.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():FadeGesture(ACT_DOTA_RUN)
	end
end
function j.prototype.OnIntervalThink(self)
	self.strafeAngle = RollPercentage(50) and 90 or -90
	self:StartIntervalThink(self.reevaluateInterval)
end
function j.prototype.OnHorizontalMotionInterrupted(self)
	if IsServer() then
		self:Destroy()
	end
end
function j.prototype.UpdateHorizontalMotion(self, n, o)
	if IsServer() then
		if not IsValid(self.target) or not self.target:IsAlive() then
			self:Destroy()
			return
		end
		local p = n:GetAbsOrigin()
		local q = self.target:GetAbsOrigin()
		local r = CalcDistance(n, self.target)
		local s = CalcDirection2D(self.target, n)
		local t = VectorToAngles(s).y
		local u = n:GetMoveSpeedModifier(n:GetBaseMoveSpeed(), false)
		local v
		if r < self.minOptimalDistance then
			self.moveState = "retreat"
			local w = s:__mul(-1)
			v = w
		elseif r > self.maxOptimalDistance then
			self.moveState = "approach"
			v = s:__mul(-1):__mul(-1)
		else
			self.moveState = "strafe"
			local x = self.minOptimalDistance * 0.9
			if r < x then
				local w = s:__mul(-1)
				local y = Rotation2D(s, self.strafeAngle, true)
				v = (w:__mul(0.6) + y:__mul(0.4)):Normalized()
			else
				v = Rotation2D(s, self.strafeAngle, true)
			end
			local z = VectorToAngles(v).y
			local A = AngleDiff(z, self.currentAngle)
			if math.abs(A) > 120 then
				self.strafeAngle = -self.strafeAngle
				v = Rotation2D(s, self.strafeAngle, true)
			end
		end
		local z = VectorToAngles(v).y
		local A = AngleDiff(z, self.currentAngle)
		local B = 500
		local C = B * o
		local D = self.currentAngle
		if math.abs(A) <= C then
			D = z
		else
			D = self.currentAngle + (A > 0 and 1 or -1) * C
		end
		self.currentAngle = D
		n:SetLocalAngles(0, D, 0)
		local E = u * o
		n:SetAbsOrigin(p + v:__mul(E))
	end
end
function j.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true }
end
j = e(
	{
		i(
			a,
			{
				IsHidden = false,
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