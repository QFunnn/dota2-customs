--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_suit_022"
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
l.name = "privilege_suit_022"
d(l, j)
function l.prototype.OnCreated(self)
	self.cd = self:GetSpecialValueFor("cd")
	self.chance = self:GetSpecialValueFor("chance")
end
function l.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.AVOID_DAMAGE] = function(m, n)
			local o = self:GetCaster()
			if self:IsCooldownReady() and n and IsValid(o) then
				local p = o:GetShield()
				local q = self:GetSpecialValueFor("shield_threshold")
				if n.damage < p * q * 0.01 and self:PRD(self.chance, "privilege_suit_022") then
					self:StartCooldown(self.cd)
					return 1
				end
			end
		end,
	}
end
l = e({ h, k(nil) }, l)
return f