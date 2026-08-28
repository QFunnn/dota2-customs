--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_zeus_defense"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_zeus_defense"
d(j, h)
function j.prototype.EventListener(self)
	return {
		ability_cast_complete = function(k, l)
			local m = self:GetCaster()
			if
				m == l.caster
				and (
					l.abilityTag == AbilityTag.Defense
					or l.abilityTag == AbilityTag.Skill
					or l.abilityTag == AbilityTag.Dodge
					or l.abilityTag == AbilityTag.Ultimate
				)
			then
				local n = self:GetSpecialValueFor("stack")
				local o = FindEnemiesInRadius(m, m:GetAbsOrigin(), 1200)
				for p, q in ipairs(o) do
					m:AddExpose(q, n)
				end
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f