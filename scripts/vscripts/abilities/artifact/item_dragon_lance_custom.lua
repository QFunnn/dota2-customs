--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_dragon_lance_custom"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_dragon_lance_custom"
d(j, h)
function j.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.ATTACK_DAMAGE_AMPLIFY] = function(k, l)
			if
				(l and l.target) ~= nil
				and CalcDistance(l.target, self:GetCaster()) >= self:GetSpecialValueFor("distance")
			then
				return self:GetSpecialValueFor("damage_amp")
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f