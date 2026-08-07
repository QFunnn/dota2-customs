--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_poison_ice"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.AbilityValue
local i = g.EOMItem
local j = g.registerEOMAbility
local k = c()
k.name = "item_poison_ice"
d(k, i)
function k.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.POISON_ATTENUATION_REDUCTION] = function(l, m)
			if m == nil or m.target == nil then
				return 0
			end
			if m.target:IsFrozen() then
				return self.pct
			end
		end,
	}
end
e({ h(nil) }, k.prototype, "pct", nil)
k = e({ j(nil) }, k)
return f