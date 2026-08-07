--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_013"
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
l.name = "privilege_013"
d(l, j)
function l.prototype.OnCreated(self)
	self.use_count = 0
end
function l.prototype.EventListener(self)
	return {
		ability_cast_complete = function(m, n)
			if self.use_count ~= 0 then
				return
			end
			if n.caster ~= self:GetCaster() then
				return
			end
			if n.abilityTag ~= AbilityTag.Ultimate then
				return
			end
			n.ability:RefundManaCost()
			self.use_count = self.use_count + 1
		end,
	}
end
l = e({ h, k(nil) }, l)
return f