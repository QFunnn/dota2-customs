--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_holy_skill2"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_holy_skill2"
d(j, h)
function j.prototype.EventListener(self)
	return {
		ability_cast_complete = function(k, l)
			local m = self:GetCaster()
			if m == l.caster and l.abilityTag == AbilityTag.Skill then
				local n = LASER_LENGTH + GetBulletRange(m)
				local o = FindUnitsInRadiusWithAbility(m, m:GetAbsOrigin(), n, self)
				local p = GetRandomElement(o)
				local q = IsValid(p) and p:GetAbsOrigin() or m:GetAbsOrigin() + RandomVector(300)
				m:Laser(CalcDirection2D(q, m), self:GetSpecialValueFor("damage"))
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f