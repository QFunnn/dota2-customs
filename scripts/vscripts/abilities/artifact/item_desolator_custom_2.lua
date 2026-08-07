--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_desolator_custom_2"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_desolator_custom_2"
d(j, h)
function j.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.ATTACK_DAMAGE_AMPLIFY] = function(k, l)
			if l ~= nil and l.target:GetShield() <= 0 then
				return self:GetSpecialValueFor("damage_amplify")
			end
		end,
	}
end
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.BARRIER_DAMAGE_AMPLIFY] = self:GetSpecialValueFor("barrier_damage_amplify") }
end
j = e({ i(nil) }, j)
return f