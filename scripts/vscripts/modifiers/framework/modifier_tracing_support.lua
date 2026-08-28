--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_tracing_support"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_tracing_support"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsServer() then
		self.target = EntIndexToHScript(k.entindex)
		self.turnRate = k.turnRate
		self.distance = k.distance
		self.flowAngle = k.flowAngle or 0
		self:StartIntervalThink(0)
	end
end
function j.prototype.OnIntervalThink(self)
	local l = self:GetCaster()
	local m = self:GetParent()
	if not IsValid(l) or not IsValid(self.target) then
		self:Destroy()
		return
	end
	if self.currentYaw == nil then
		self.currentYaw = VectorToAngles(CalcDirection2D(m, l)).y
	end
	local n = CalcDirection2D(self.target:GetAbsOrigin(), l)
	local o = VectorToAngles(n).y + self.flowAngle
	local p = AngleDiff(o, self.currentYaw)
	local q = self.turnRate * FrameTime()
	local r = math.max(-q, math.min(q, p))
	local s = self.currentYaw + r
	if math.abs(p) <= q then
		s = o
	end
	local t = AnglesToVector(QAngle(0, s, 0))
	m:SetAbsOrigin(l:GetAbsOrigin() + t * self.distance)
	self.currentYaw = s
end
function j.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():RemoveSelf()
	end
end
function j.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_INVULNERABLE] = true }
end
j = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	j
)
return f