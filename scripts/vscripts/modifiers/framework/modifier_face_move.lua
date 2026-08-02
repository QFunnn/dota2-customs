--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_face_move"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifierMotionHorizontal
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_face_move"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.currentAngle = 0
	self.horizontalAngle = 90
end
function j.prototype.OnCreated(self, k)
	if IsServer() then
		self.target = EntIndexToHScript(k.target)
		self.moveType = k.moveType or "strafe"
		self.radius = k.radius
		self.retreatDistance = k.retreatDistance
		self.currentAngle = VectorToAngles(self:GetParent():GetForwardVector()).y
		self.horizontalAngle = RollPercentage(50) and 90 or -90
		if self.moveType == "retreat" then
			self.startPosition = self:GetParent():GetAbsOrigin()
		end
		self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_RUN, 0.4)
		if self.moveType == "strafe" then
			self:StartIntervalThink(RandomInt(2, 3))
		end
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
function j.prototype.OnRefresh(self, k)
	if IsServer() then
		local l = EntIndexToHScript(k.target)
		local m = k.moveType or "strafe"
		if l ~= self.target or m ~= self.moveType then
			self.target = EntIndexToHScript(k.target)
			self.moveType = k.moveType or "strafe"
		end
	end
end
function j.prototype.OnIntervalThink(self)
	if self.moveType == "strafe" then
		self:StartIntervalThink(RandomInt(2, 3))
		self.horizontalAngle = -self.horizontalAngle
	end
end
function j.prototype.OnHorizontalMotionInterrupted(self)
	if IsServer() then
		self:Destroy()
	end
end
function j.prototype.UpdateHorizontalMotion(self, n, o)
	if IsServer() then
		if not IsValid(self.target) or not self.target:IsAlive() or n:IsStunned() then
			self:Destroy()
			return
		end
		local p = n:GetAbsOrigin()
		local q
		if self.moveType == "retreat" then
			if self.retreatDistance and self.startPosition then
				local r = CalcDistance(p, self.startPosition)
				if r >= self.retreatDistance then
					self:Destroy()
					return
				end
			end
			local s = CalcDirection2D(self.target, n):__mul(-1):__mul(-1)
			q = s:__mul(-1)
		elseif self.moveType == "approach" then
			local s = CalcDirection2D(self.target, n):__mul(-1):__mul(-1)
			q = s
		else
			local t = CalcDirection2D(self.target, n)
			local u = Rotation2D(t, self.horizontalAngle, true)
			local v = t:__mul(-1)
			q = CalcDistance(n, self.target) < 300 and (v + u):Normalized() or u
		end
		local s = CalcDirection2D(self.target, n):__mul(-1):__mul(-1)
		local w = VectorToAngles(s).y
		if self.moveType == "strafe" then
			if AngleDiff(w, self.currentAngle) > 180 then
				self.horizontalAngle = -self.horizontalAngle
			end
		end
		local x = self.currentAngle + AngleDiff(w, self.currentAngle) * 1 * o
		self.currentAngle = x
		n:SetLocalAngles(0, x, 0)
		local y = 150
		local z = self.moveType == "retreat" and 0.8 or 1
		local A = y * z * o
		local B = p + q:__mul(A)
		if not GridNav:IsValidPosition(B) then
			self:Destroy()
			return
		end
		n:SetAbsOrigin(B)
	end
end
function j.prototype.StaticDeclare(self)
	return { [MODIFIER_PROPERTY_DISABLE_TURNING] = 1, [MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS] = "walk" }
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