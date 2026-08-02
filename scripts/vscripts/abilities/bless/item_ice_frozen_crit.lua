--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_ice_frozen_crit"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_ice_frozen_crit"
d(j, h)
function j.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.CRIT_CHANCE] = function(k, l)
			local m = l and l.target
			if m and m:IsFreeze() and l.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
				return 100
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f