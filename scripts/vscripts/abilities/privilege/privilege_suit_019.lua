--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_suit_019"
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
l.name = "privilege_suit_019"
d(l, j)
function l.prototype.EventListener(self)
	return {
		entity_killed = function(m, n)
			local o = self:GetCaster()
			if n.attacker == o and n.victim:IsFreeze() then
				local p = self:GetSpecialValueFor("radius")
				local q = self:GetSpecialValueFor("freeze_time")
				local r = FindEnemiesInRadius(o, n.victim:GetAbsOrigin(), p, FIND_CLOSEST)
				ArrayRemove(r, n.victim)
				for s, t in ipairs(r) do
					o:Freeze(t, q)
				end
			end
		end,
	}
end
l = e({ h, k(nil) }, l)
return f