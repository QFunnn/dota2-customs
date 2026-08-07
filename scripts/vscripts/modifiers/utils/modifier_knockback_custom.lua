--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_knockback_custom"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 11,
		["13"] = 3,
		["14"] = 11,
		["16"] = 11,
		["17"] = 22,
		["18"] = 23,
		["19"] = 3,
		["20"] = 24,
		["21"] = 25,
		["22"] = 26,
		["23"] = 27,
		["24"] = 28,
		["25"] = 29,
		["28"] = 32,
		["29"] = 35,
		["30"] = 36,
		["31"] = 37,
		["32"] = 39,
		["33"] = 40,
		["34"] = 41,
		["35"] = 42,
		["36"] = 43,
		["37"] = 45,
		["38"] = 46,
		["39"] = 47,
		["40"] = 48,
		["41"] = 49,
		["43"] = 51,
		["44"] = 52,
		["45"] = 53,
		["46"] = 54,
		["47"] = 56,
		["48"] = 57,
		["51"] = 60,
		["53"] = 24,
		["54"] = 63,
		["55"] = 64,
		["56"] = 65,
		["57"] = 66,
		["59"] = 63,
		["60"] = 71,
		["61"] = 72,
		["62"] = 73,
		["63"] = 74,
		["64"] = 75,
		["66"] = 77,
		["67"] = 78,
		["69"] = 71,
		["70"] = 81,
		["71"] = 82,
		["72"] = 83,
		["73"] = 84,
		["75"] = 86,
		["76"] = 88,
		["77"] = 90,
		["78"] = 91,
		["79"] = 92,
		["80"] = 93,
		["81"] = 94,
		["82"] = 95,
		["83"] = 96,
		["85"] = 98,
		["86"] = 99,
		["89"] = 102,
		["90"] = 104,
		["91"] = 105,
		["92"] = 107,
		["93"] = 109,
		["96"] = 81,
		["97"] = 113,
		["98"] = 114,
		["99"] = 115,
		["100"] = 116,
		["101"] = 117,
		["102"] = 118,
		["103"] = 119,
		["104"] = 120,
		["105"] = 121,
		["106"] = 122,
		["107"] = 124,
		["110"] = 113,
		["111"] = 133,
		["112"] = 134,
		["113"] = 133,
		["114"] = 138,
		["115"] = 139,
		["116"] = 138,
		["117"] = 11,
		["118"] = 3,
		["119"] = 3,
		["120"] = 3,
		["121"] = 3,
		["122"] = 3,
		["123"] = 3,
		["124"] = 3,
		["125"] = 3,
		["126"] = 11,
		["128"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_knockback_custom = c()
local k = g.modifier_knockback_custom
k.name = "modifier_knockback_custom"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.horizontal = true
	self.vertical = true
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		local m = StringToVector(l.vDirection)
		self.ignore_block = l.ignore_block
		if m == nil then
			self:Destroy()
			return
		end
		local n = self:GetParent()
		local o = n:GetAbsOrigin()
		self.fHeightOffset = o.z - GetGroundHeight(o, n)
		self.fStartHeight = GetGroundHeight(o, n)
		self.fKnockbackDuration = tonumber(l.knockback_duration) or 0
		if self.fKnockbackDuration > 0 then
			self.fDistance = tonumber(l.knockback_distance) or 0
			if self.fDistance ~= 0 then
				self.fHorizontalTime = 0
				m = m:Normalized()
				m.z = 0
				self.vVelocity = m:Normalized() * self.fDistance / self.fKnockbackDuration
				local p = o + m:Normalized() * self.fDistance
				self.fTargetHeight = GetGroundHeight(p, n)
			end
			self.fHeight = tonumber(l.knockback_height) or 0
			if self.fHeight ~= 0 then
				n:StartGesture(ACT_DOTA_FLAIL)
				self.fVerticalTime = 0
				self.fHeight = self.fHeight + self.fStartHeight
				self.fTargetHeight = self.fTargetHeight or self.fStartHeight
			end
		end
		self:StartIntervalThink(0)
	end
end
function k.prototype.OnDestroy(self)
	if IsServer() then
		local n = self:GetParent()
		n:RemoveGesture(ACT_DOTA_FLAIL)
	end
end
function k.prototype.OnIntervalThink(self)
	local n = self:GetParent()
	local q = FrameTime()
	if self.horizontal then
		self:UpdateHorizontal(n, q)
	end
	if self.vertical then
		self:UpdateVertical(n, q)
	end
end
function k.prototype.UpdateHorizontal(self, r, s)
	if IsServer() then
		if self.fHorizontalTime + s > self.fKnockbackDuration then
			s = self.fKnockbackDuration - self.fHorizontalTime
		end
		self.fHorizontalTime = self.fHorizontalTime + s
		local o = r:GetAbsOrigin()
		local t = self.vVelocity.x
		local u = self.vVelocity.y
		local v = o + Vector(t * s, 0, 0)
		local w = o + Vector(u * s, 0, 0)
		if self.ignore_block == 0 then
			if not GridNav:IsTraversable(v) or not GridNav:CanFindPath(o, v) then
				t = 0
			end
			if not GridNav:IsTraversable(w) or not GridNav:CanFindPath(o, w) then
				u = 0
			end
		end
		local p = o + Vector(t, u, self.vVelocity.z) * s
		local x = p
		r:SetAbsOrigin(GetGroundPosition(x, r))
		if self.fHorizontalTime >= self.fKnockbackDuration then
			self.horizontal = false
		end
	end
end
function k.prototype.UpdateVertical(self, r, s)
	if IsServer() then
		self.fVerticalTime = self.fVerticalTime + s
		local y = Clamp(self.fVerticalTime / self.fKnockbackDuration, 0, 1)
		local z = KnockBackFunction(
			y,
			self.fStartHeight + self.fHeightOffset,
			self.fHeight + self.fHeightOffset,
			self.fTargetHeight
		)
		local x = r:GetAbsOrigin()
		x.z = z
		r:SetAbsOrigin(x)
		if self.fVerticalTime >= self.fKnockbackDuration then
			r:RemoveGesture(ACT_DOTA_FLAIL)
			self.vertical = false
		end
	end
end
function k.prototype.DeclareFunctions(self)
	return {}
end
function k.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_DISABLED
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	k
)
g.modifier_knockback_custom = k
return g