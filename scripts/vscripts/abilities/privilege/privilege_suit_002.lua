--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_suit_002"
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
l.name = "privilege_suit_002"
d(l, j)
function l.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.hitCounter = 0
end
function l.prototype.EventListener(self)
	return {
		damage_event = function(m, n)
			local o = self:GetCaster()
			if n.attacker ~= o or n.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then
				return
			end
			local p = self:GetSpecialValueFor("hit_count")
			local q = self:GetSpecialValueFor("shock_stacks")
			self.hitCounter = self.hitCounter + 1
			if self.hitCounter >= p then
				local r = n.target
				if IsValid(r) then
					o:AddExpose(r, q)
				end
				self.hitCounter = 0
			end
		end,
	}
end
l = e({ h, k(nil) }, l)
return f