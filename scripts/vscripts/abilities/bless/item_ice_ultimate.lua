--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_ice_ultimate"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_ice_ultimate"
d(j, h)
function j.prototype.EventListener(self)
	return {
		ability_cast_complete = function(k, l)
			local m = self:GetCaster()
			if m == l.caster and l.abilityTag == AbilityTag.Ultimate then
				local n = self:GetSpecialValueFor("frozen")
				local o = self:GetSpecialValueFor("damage")
				local p = FindUnitsInRadiusWithAbility(m, m:GetAbsOrigin(), 900, self)
				for q, r in ipairs(p) do
					m:FrozenBurst(o, n, r:GetAbsOrigin())
				end
				m:EmitSound("Ability.FrostNova")
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f