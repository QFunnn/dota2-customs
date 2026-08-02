--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/combo_events/modifier_abyssal_knock"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.registerEOMModifier
local i = g.EOMModifier
local j = c()
j.name = "modifier_abyssal_knock"
d(j, i)
function j.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.interval = 0
	self.radius = 0
end
function j.prototype.OnCreated(self, k)
	if not IsServer() then
		return
	end
	self:UpdateParams(k)
	if self.interval > 0 then
		self:StartIntervalThink(self.interval)
	end
end
function j.prototype.OnRefresh(self, k)
	if not IsServer() then
		return
	end
	self:UpdateParams(k)
	self:StartIntervalThink(self.interval > 0 and self.interval or -1)
end
function j.prototype.OnIntervalThink(self)
	local l = self:GetParent()
	if not IsValid(l) or not l:IsAlive() or self.radius <= 0 then
		return
	end
	local m = FindEnemiesInRadius(l, l:GetAbsOrigin(), self.radius)
	for n, o in ipairs(m) do
		do
			local p = CalcDistance(o, l) * 0.7
			if p <= 0 then
				goto q
			end
			o:KnockBack(CalcDirection2D(l, o), p, 0, 0.5)
		end
		::q::
	end
end
function j.prototype.UpdateParams(self, k)
	self.interval = math.max(0, toFiniteNumber(k.interval, 0))
	self.radius = math.max(0, toFiniteNumber(k.radius, 0))
end
j = e(
	{
		h(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	j
)
return f