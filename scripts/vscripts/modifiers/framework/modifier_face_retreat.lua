--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_face_retreat"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifierMotionHorizontal
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_face_retreat"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.currentAngle = 0
end
function j.prototype.OnCreated(self, k)
	if IsServer() then
		local l = self:GetParent()
		self.target = EntIndexToHScript(k.target)
		self.retreatDistance = k.distance
		self.startPosition = l:GetAbsOrigin()
		self.currentAngle = VectorToAngles(l:GetForwardVector()).y
		l:StartGestureWithPlaybackRate(ACT_DOTA_RUN, 0.4)
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
function j.prototype.OnHorizontalMotionInterrupted(self)
	if IsServer() then
		self:Destroy()
	end
end
function j.prototype.UpdateHorizontalMotion(self, m, n)
	if IsServer() then
		if not IsValid(self.target) or not self.target:IsAlive() then
			self:Destroy()
			return
		end
		local o = m:GetAbsOrigin()
		local p = CalcDistance(o, self.startPosition)
		if p >= self.retreatDistance then
			self:Destroy()
			return
		end
		local q = CalcDirection2D(self.target, m):__mul(-1):__mul(-1)
		local r = q:__mul(-1)
		local s = m:GetMoveSpeedModifier(m:GetBaseMoveSpeed(), false) * 0.8
		local t = VectorToAngles(q).y
		local u = self.currentAngle + AngleDiff(t, self.currentAngle) * 2 * n
		self.currentAngle = u
		m:SetLocalAngles(0, u, 0)
		local v = s * n
		local w = m:GetAbsOrigin() + r:__mul(v)
		if not GridNav:CanFindPath(m:GetAbsOrigin(), w) then
			self:Destroy()
			return
		end
		m:SetAbsOrigin(w)
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