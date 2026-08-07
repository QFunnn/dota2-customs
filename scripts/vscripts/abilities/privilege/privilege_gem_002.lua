--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_gem_002"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = h.TransmitterData
local l = require("abilities.eom_privilege")
local m = l.EOMPrivilege
local n = l.PrivilegeValue
local o = l.RegisterPrivilege
local p = c()
p.name = "privilege_gem_002"
d(p, m)
function p.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.stackRecord = 0
end
function p.prototype.EventListener(self)
	return {
		frozen_event = function(q, r)
			local s = self:GetCaster()
			if r.caster == s then
				self.stackRecord = self.stackRecord + r.stack
				if self.stackRecord >= self.stack then
					self.stackRecord = self.stackRecord - self.stack
					r.target:AddNewModifier(s, nil, g.name, { value = self.value })
				end
			end
		end,
	}
end
e({ n(nil) }, p.prototype, "value", nil)
e({ n(nil) }, p.prototype, "stack", nil)
p = e({ o(nil) }, p)
g = c()
g.name = "modifier_gem_freeze_armor"
d(g, i)
function g.prototype.OnCreated(self, t)
	if IsServer() then
		self.value = t.value
	end
end
function g.prototype.OnRefresh(self, t)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function g.prototype.StaticProperty(self)
	return {
		[PropertyFunction.PHYSICAL_ARMOR] = -toFiniteNumber(self.value) * self:GetStackCount(),
		[PropertyFunction.ELEMENTAL_DAMAGE] = -toFiniteNumber(self.value) * self:GetStackCount(),
	}
end
e({ k(nil) }, g.prototype, "value", nil)
g = e(
	{ j(
		a,
		{ IsHidden = false, IsDebuff = true, IsPurgable = true, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	g
)
return f