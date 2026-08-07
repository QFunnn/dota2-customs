--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_001"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_001"
d(j, h)
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			if not self:IsCooldownReady() then
				return
			end
			local m = self:GetCaster()
			if l.target ~= m then
				return
			end
			local n = self:GetSpecialValueFor("reduce_doge_cd")
			local o = self:GetSpecialValueFor("trigger_cd")
			self:StartCooldown(o)
			local p = m:GetAbilityByTag(AbilityTag.Dodge)
			if IsValid(p) then
				p:ReduceCooldown(n)
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f