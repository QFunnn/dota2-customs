--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_suit_004"
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
l.name = "privilege_suit_004"
d(l, j)
function l.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.stack = 0
end
function l.prototype.OnCreated(self)
	self:StartThink(0.1, "SwordIntent", function(m, n)
		n.stack = math.min(n.stack + 0.1, SWORD_INTENT_MAX_STACK)
	end)
end
function l.prototype.EventListener(self)
	return {
		ability_cast_complete = function(m, o)
			local p = self:GetCaster()
			if o.caster ~= p then
				return
			end
			if o.abilityTag ~= AbilityTag.Skill then
				return
			end
			local q = p:GetAbsOrigin()
			local r = CalcDirection2D(o.position, q)
			if r:Length() == 0 then
				r = p:GetForwardVector()
			end
			local s = self:GetSpecialValueFor("damage")
			p:SwordWave(q, r, s, self.stack)
			self.stack = 0
		end,
	}
end
l = e({ h, k(nil) }, l)
return f