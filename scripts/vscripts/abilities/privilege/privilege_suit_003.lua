--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_suit_003"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.tstl-utils")
local h = g.reloadable
local i = require("abilities.eom_privilege")
local j = i.EOMPrivilege
local k = i.RegisterPrivilege
local l = c()
l.name = "privilege_suit_003"
d(l, j)
function l.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.frozenStacks = {}
end
function l.prototype.OnCreated(self) end
function l.prototype.EventListener(self)
	return {
		frozen_event = function(m, n)
			local o = self:GetCaster()
			if n.caster ~= o then
				return
			end
			local p = self:GetSpecialValueFor("frozen_stacks")
			local q = self:GetSpecialValueFor("freeze_time")
			if Privilege:HasPrivilege("privilege_suit_019", self.playerID) then
				q = Privilege:GetPrivilegeSpecialValue("privilege_suit_019", 1, "freeze_time", o)
			end
			local r = n.target:entindex()
			self.frozenStacks[r] = toFiniteNumber(self.frozenStacks[r], 0) + n.addStack
			if self.frozenStacks[r] >= p then
				o:Freeze(n.target, q)
				local s, t = self.frozenStacks, r
				s[t] = s[t] - p
			end
		end,
	}
end
l = e({ h, k(nil) }, l)
return f